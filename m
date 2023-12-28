Return-Path: <linux-pci+bounces-1514-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E43981FA2C
	for <lists+linux-pci@lfdr.de>; Thu, 28 Dec 2023 18:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFEB61F220A5
	for <lists+linux-pci@lfdr.de>; Thu, 28 Dec 2023 17:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CF1F519;
	Thu, 28 Dec 2023 17:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JPFh8xcy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E051F50E;
	Thu, 28 Dec 2023 17:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703782934; x=1735318934;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=E4S700sBn75X/3Gsw0UEUvo6avxdYoT8g3X4kF0jwe0=;
  b=JPFh8xcyiG24ADm0+bvT/B7kkwO8W0tJhNsD6QvQU4is2TaZd8ur5b6D
   LGbR1ZkypHzyuQrsBK/T9MndjlQRJGXzxMU+R5h7cbxd3zWypj/58Z9/v
   bTH7pkAozhkPEtGALT4Ne2gEpStHTY5tzal4WQ55ltoKQ0P0x1nx38uGI
   Lc23nQMqfPyLU4dtJRm4aRY4iPVtftBeFYmApRHVzZwgVOZxQuN5nelaN
   nyRirIYncwuEW22qW8oU7ULbIm0KyhbmREugJ3GFb7EXMXNCuz8pJfaVU
   aN/EDjtiJY/w3yc20g07zRl3Osxv9X3cWY9hbzbGWfqrDXS8Iu2larFDx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="18119283"
X-IronPort-AV: E=Sophos;i="6.04,312,1695711600"; 
   d="scan'208";a="18119283"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 09:02:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="771757391"
X-IronPort-AV: E=Sophos;i="6.04,312,1695711600"; 
   d="scan'208";a="771757391"
Received: from ply01-vm-store.bj.intel.com ([10.238.153.201])
  by orsmga007.jf.intel.com with ESMTP; 28 Dec 2023 09:02:09 -0800
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
To: kevin.tian@intel.com,
	bhelgaas@google.com,
	baolu.lu@linux.intel.com,
	dwmw2@infradead.org,
	will@kernel.org,
	robin.murphy@arm.com,
	lukas@wunner.de
Cc: linux-pci@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v10 0/5] fix vt-d hard lockup when hotplug ATS capable device
Date: Thu, 28 Dec 2023 12:02:01 -0500
Message-Id: <20231228170206.720675-1-haifeng.zhao@linux.intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset is used to fix vt-d hard lockup reported when surprise
unplug ATS capable endpoint device connects to system via PCIe switch
as following topology.                                               
                                                                    
     +-[0000:15]-+-00.0  Intel Corporation Ice Lake Memory Map/VT-d 
     |           +-00.1  Intel Corporation Ice Lake Mesh 2 PCIe     
     |           +-00.2  Intel Corporation Ice Lake RAS             
     |           +-00.4  Intel Corporation Device 0b23              
     |           \-01.0-[16-1b]----00.0-[17-1b]--+-00.0-[18]----00.0 
                                           NVIDIA Corporation Device 2324 
     |                                           +-01.0-[19]----00.0    
                          Mellanox Technologies MT2910 Family [ConnectX-7]
                                                                          
User brought endpoint device 19:00.0's link down by flapping it's hotplug 
capable slot 17:01.0 link control register, as sequence DLLSC response, 
pciehp_ist() will unload device driver and power it off, durning device 
driver is unloading an iommu device-TLB invalidation (Intel VT-d spec, or 
'ATS Invalidation' in PCIe spec) request issued to that link down device, 
thus a long time completion/timeout waiting in interrupt context causes   
continuous hard lockup warnning and system hang.                         
                                                                         
Other detail, see every patch commit log.                                
                                                                         
patch [3&4] were tested by yehaorong@bytedance.com on stable v6.7-rc4.   
patch [1-5] passed compiling on stable v6.7-rc6.                    
                                                                         
                                                                         
change log:  
v10:
- refactor qi_submit_sync() and its callers to get pci_dev instance, as
  Kevin pointed out add target_flush_dev to iommu is not right.
v9:
- unify all spelling of ATS Invalidation adhere to PCIe spec per Bjorn's
  suggestion.                                                         
v8:
- add a patch to break the loop for timeout device-TLB invalidation, as
  Bjorn said there is possibility device just no response but not gone.  
v7:                                                                      
- reorder patches and revise commit log per Bjorn's guide.              
- other code and commit log revise per Lukas' suggestion.               
- rebased to stable v6.7-rc6.                                           
v6:                                                                     
- add two patches to break out device-TLB invalidation if device is gone. 
v5:                                                                       
- add a patch try to fix the rare case (surprise remove a device in       
  safe removal process). not work because surprise removal handling can't 
  re-enter when another safe removal is in process.                       
v4:                                                                       
- move the PCI device state checking after ATS per Baolu's suggestion.    
v3:                                                                       
- fix commit description typo.                                            
v2:                                                                       
- revise commit[1] description part according to Lukas' suggestion.       
- revise commit[2] description to clarify the issue's impact.             
v1:                                                                       
- https://lore.kernel.org/lkml/20231213034637.2603013-1-haifeng.zhao@     
linux.intel.com/T/                                                        
                                                                          
                                                                          
Thanks,                                                                   
Ethan                           


Ethan Zhao (5):
  iommu/vt-d: add pci_dev parameter to qi_submit_sync and refactor
    callers
  iommu/vt-d: break out ATS Invalidation if target device is gone
  PCI: make pci_dev_is_disconnected() helper public for other drivers
  iommu/vt-d: don't issue ATS Invalidation request when device is
    disconnected
  iommu/vt-d: don't loop for timeout ATS Invalidation request forever

 drivers/iommu/intel/dmar.c          | 55 ++++++++++++++++++++++-------
 drivers/iommu/intel/iommu.c         | 26 ++++----------
 drivers/iommu/intel/iommu.h         | 17 +++++----
 drivers/iommu/intel/irq_remapping.c |  2 +-
 drivers/iommu/intel/pasid.c         | 13 +++----
 drivers/iommu/intel/svm.c           | 13 ++++---
 drivers/pci/pci.h                   |  5 ---
 include/linux/pci.h                 |  5 +++
 8 files changed, 74 insertions(+), 62 deletions(-)

-- 
2.31.1


