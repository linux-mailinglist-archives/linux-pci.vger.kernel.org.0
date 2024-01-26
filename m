Return-Path: <linux-pci+bounces-2559-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D8083D221
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jan 2024 02:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBFBC1C21837
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jan 2024 01:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1105010EB;
	Fri, 26 Jan 2024 01:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oJZxwOJh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718D8EC3;
	Fri, 26 Jan 2024 01:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706233225; cv=none; b=jPAkGOpqRj8PVZmBFwLLyGuGNI2mywM3wxyKntasNJJ4XfjY4HOp3P5MiAvjeUlS1jI0SVGp0jcaCmCUcrWGB7swz+olVcx0tYBIdh6qXY22ZtmNHc/RR9mNki3N5i3DWlhuzFi7Zp9aRTTzo6fAV6fNtH2x1vZVdQ3Z1fD2DBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706233225; c=relaxed/simple;
	bh=4dlBSbHCmNEO4tqCGXWVdwuxmbBaTOw3I9YxMiM23sY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eXOf4j7aiQBhzmr7/ILb/zd1dEvPnkAJYQKCy78i/UdaVlkJe55I2G7a6M+phWJXjpHSmPZmsvNqAMY30EALD8LD9/0S6DRpiaau36OQMTpyH3zgww/ixkZMjQMvzDl1NhJhiIdz4wLYcGCK2N8eaJ5jMf+4WxTsy2c3lP7fLKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oJZxwOJh; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706233223; x=1737769223;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4dlBSbHCmNEO4tqCGXWVdwuxmbBaTOw3I9YxMiM23sY=;
  b=oJZxwOJhsAqNhJVm4g3ruRTDE6g42ggsxbm8+cC/Kl+t1ipTODVQNMsh
   veENgtfDmqJcXIciRD9SQoMrzT52yohmm4EfpmJAHW0ZbBSFu9cJUS+jo
   9UYgxwPhie0L6WlYTanE3dOFeKb3gMJ9jcjT9gb62Hwii2sNa0xPBXanb
   NX85HazPbPEZy3LlNlJzjsdAU4LL673buAt9QjgqEa1+tn2P8yIKpvBtt
   dCpcDvcouUzkh6JwnX1GP9LYq7evz1yP3AkJsFBwx3NNv1/EBjzB3gE/A
   KDiUaZy4C8zwgGGuwGzZ+91AxQqKd1whORPhuq3kj+jrxU+fxSVr6XUIe
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="15718431"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="15718431"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 17:40:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2533076"
Received: from unknown (HELO ply01-vm-store.amr.corp.intel.com) ([10.238.153.201])
  by fmviesa003.fm.intel.com with ESMTP; 25 Jan 2024 17:40:19 -0800
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
To: baolu.lu@linux.intel.com,
	bhelgaas@google.com,
	robin.murphy@arm.com,
	jgg@ziepe.ca
Cc: kevin.tian@intel.com,
	dwmw2@infradead.org,
	will@kernel.org,
	lukas@wunner.de,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Ethan Zhao <haifeng.zhao@linux.intel.com>
Subject: [PATCH v11 0/5] fix vt-d hard lockup when hotplug ATS capable device
Date: Thu, 25 Jan 2024 20:39:57 -0500
Message-Id: <20240126014002.481294-1-haifeng.zhao@linux.intel.com>
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

patch [1&2] were tested by yehaorong@bytedance.com on stable v6.7-rc4.
patch [1-5] passed compiling on stable v6.8rc1.

change log:
v11: 
- update per latest comment and suggestion from Baolu and YiLiu.
- split refactoring patch into two patches, [3/5] for simplify parameters
  and [4/5] for pdev parameter passing.
- re-order patches.
- fold target device presence check into qi_check_fault().
- combine patch[2][5] in v10 into one patch[5].
- some commit description correctness.
- add fixes tag to patch[2/5].
- rebased on 6.8rc1
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
  PCI: make pci_dev_is_disconnected() helper public for other drivers
  iommu/vt-d: don't issue ATS Invalidation request when device is
    disconnected
  iommu/vt-d: simplify parameters of qi_submit_sync() ATS invalidation
    callers
  iommu/vt-d: pass pdev parameter for qi_check_fault() and refactor
    callers
  iommu/vt-d: improve ITE fault handling if target device isn't present

 drivers/iommu/intel/dmar.c          | 71 +++++++++++++++++++++++------
 drivers/iommu/intel/iommu.c         | 26 +++--------
 drivers/iommu/intel/iommu.h         | 20 ++++----
 drivers/iommu/intel/irq_remapping.c |  2 +-
 drivers/iommu/intel/nested.c        |  9 +---
 drivers/iommu/intel/pasid.c         | 12 ++---
 drivers/iommu/intel/svm.c           | 13 +++---
 drivers/pci/pci.h                   |  5 --
 include/linux/pci.h                 |  5 ++
 9 files changed, 93 insertions(+), 70 deletions(-)

-- 
2.31.1


