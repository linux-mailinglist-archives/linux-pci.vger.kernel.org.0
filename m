Return-Path: <linux-pci+bounces-2683-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C3D83FCF7
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 04:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F78EB210A7
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 03:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90C310A03;
	Mon, 29 Jan 2024 03:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dmj/H8eE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491F810962;
	Mon, 29 Jan 2024 03:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706500174; cv=none; b=ccF+Gcsea7TPs5/CH9Yv0wCK5vMGSszZF+E2f02Ccys6jjWW+GzFcb9R5u9Y8T3rOM8VQ7kXosqnIdF86VRwgVZY+HpJdRxoUPh9VE7d3O+xwGdtdl/Vu7vHHcu2kgrGKi4djZGAXnI0WPFaFX3QavfcLqLSaZbFFLp9tA4ro2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706500174; c=relaxed/simple;
	bh=L8S0ZnqopWvxV0k41s69onli9Jnj8oBzZN6pErAOoLQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gxQWPYNvR6eq8+DRAqtcviGtYuAbgTTFScVYeg5Te7esuVviGvjUmq6Uim+7c8LUrmvVO/1ze5BTiYMEPwOhBoLaCxRFlHIPmNF1re73e6sWpJEBUB2rQMZW1VDAHaHcfu9Z0lVhLADPLwZV0Js/r9Fx4WkDcQxuJLm8RSfvZTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dmj/H8eE; arc=none smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706500173; x=1738036173;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=L8S0ZnqopWvxV0k41s69onli9Jnj8oBzZN6pErAOoLQ=;
  b=dmj/H8eEzwhqLXzLH++9F6wUPVr6PmvIxHghUSHivzgkQ5Kx48gBkSeC
   NlmbyP+s5AFS5EAjtvZBAbK/5faOnG0wo+e5tORrlfSUHHestk4eQzagF
   HIJSeRzD1NOAwhUazgRxk+6o1v7+u2Y28bKLh7VI0aQjaRfn1lPhsurbX
   TcMO9j1tcdk4rIZ73yKAhtS6w5KwQVUk50aNueODxcQmfbFkFp4l2CuJL
   mQBrtyS9kqBl0TMs1oB8oJIEsPJTIboEuWJe40+RrtCZ31sUnKgVJWGAd
   lmfM7v/T4+PSk8tLK4MUjXv7ekP1awife40hm9Eaidak/5HaLTjtw0XG3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="406566875"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="406566875"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 19:49:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="960775175"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="960775175"
Received: from unknown (HELO ply01-vm-store.amr.corp.intel.com) ([10.238.153.201])
  by orsmga005.jf.intel.com with ESMTP; 28 Jan 2024 19:49:28 -0800
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
Subject: [PATCH v12 0/5] fix vt-d hard lockup when hotplug ATS capable device
Date: Sun, 28 Jan 2024 22:49:19 -0500
Message-Id: <20240129034924.817005-1-haifeng.zhao@linux.intel.com>
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
patch [1-5] passed compiling on stable v6.8-rc2.

change log:
v12: 
- use base-commit tag to format patch.
- fix building issue on v6.8-rc2 repported by lkp@intel.com.
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
 drivers/iommu/intel/iommu.c         | 29 +++---------
 drivers/iommu/intel/iommu.h         | 20 ++++----
 drivers/iommu/intel/irq_remapping.c |  2 +-
 drivers/iommu/intel/nested.c        |  9 +---
 drivers/iommu/intel/pasid.c         | 12 ++---
 drivers/iommu/intel/svm.c           | 23 +++++-----
 drivers/pci/pci.h                   |  5 --
 include/linux/pci.h                 |  5 ++
 9 files changed, 98 insertions(+), 78 deletions(-)


base-commit: 41bccc98fb7931d63d03f326a746ac4d429c1dd3
-- 
2.31.1


