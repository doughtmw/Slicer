/*=auto=========================================================================

  Portions (c) Copyright 2005 Brigham and Women's Hospital (BWH) All Rights Reserved.

  See COPYRIGHT.txt
  or http://www.slicer.org/copyright/copyright.txt for details.

  Program:   3D Slicer
  Module:    $RCSfile: vtkMRMLSceneViewStorageNode.h,v $
  Date:      $Date: 2006/03/19 17:12:29 $
  Version:   $Revision: 1.3 $

=========================================================================auto=*/

#ifndef __vtkMRMLSceneViewStorageNode_h
#define __vtkMRMLSceneViewStorageNode_h

#include "vtkMRMLStorageNode.h"

/// \brief MRML node for model storage on disk.
///
/// Storage nodes has methods to read/write vtkPolyData to/from disk.
class VTK_MRML_EXPORT vtkMRMLSceneViewStorageNode : public vtkMRMLStorageNode
{
public:
  static vtkMRMLSceneViewStorageNode *New();
  vtkTypeMacro(vtkMRMLSceneViewStorageNode,vtkMRMLStorageNode);
  void PrintSelf(ostream& os, vtkIndent indent) VTK_OVERRIDE;

  virtual vtkMRMLNode* CreateNodeInstance() VTK_OVERRIDE;

  ///
  /// Get node XML tag name (like Storage, Model)
  virtual const char* GetNodeTagName() VTK_OVERRIDE {return "SceneViewStorage";}

  /// Initialize all the supported read file types
  virtual void InitializeSupportedReadFileTypes() VTK_OVERRIDE;

  /// Initialize all the supported write file types
  virtual void InitializeSupportedWriteFileTypes() VTK_OVERRIDE;

  /// Return true if the node can be read in
  virtual bool CanReadInReferenceNode(vtkMRMLNode *refNode) VTK_OVERRIDE;

protected:
  vtkMRMLSceneViewStorageNode();
  ~vtkMRMLSceneViewStorageNode();
  vtkMRMLSceneViewStorageNode(const vtkMRMLSceneViewStorageNode&);
  void operator=(const vtkMRMLSceneViewStorageNode&);

  ///
  /// Read data and set it in the referenced node
  /// NOTE: Subclasses should implement this method
  virtual int ReadDataInternal(vtkMRMLNode *refNode) VTK_OVERRIDE;

  ///
  /// Write data from a  referenced node
  /// NOTE: Subclasses should implement this method
  virtual int WriteDataInternal(vtkMRMLNode *refNode) VTK_OVERRIDE;

};

#endif
