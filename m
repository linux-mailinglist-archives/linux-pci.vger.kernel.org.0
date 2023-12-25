Return-Path: <linux-pci+bounces-1367-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F1E81DF1F
	for <lists+linux-pci@lfdr.de>; Mon, 25 Dec 2023 09:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F04781C2127D
	for <lists+linux-pci@lfdr.de>; Mon, 25 Dec 2023 08:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C333415B0;
	Mon, 25 Dec 2023 08:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B9EX5/r5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198D015AF;
	Mon, 25 Dec 2023 08:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703492737; x=1735028737;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Vprv0hFwwaz00IFfEg9mec2/0QKJFt2d7jrEt35TXXI=;
  b=B9EX5/r5jl0g3jdk/bQpRHyDM83EsksSMZqkOtnFZZdkQzMrKhvQMe4H
   fDLAivUDOyT9kosq4f20pd7srhX1ezl2MyZNHzb2T3tDAh/kIzru0JYRo
   Ele7GspYGJvz4J453MYqf9cbMudjN5DPe9QnTwb9gMbsqUFlUZDZLK1Lu
   p1JakVrkr+b0C7Mbc32hI4lnShk6s45qHklTfdEAfJNo3QP/eToCWcpMX
   BXGkTu4BkfpokEDdL5yxMEtqMeJlabu3Xr8BP4xY1Jh+8DxAGSjthslJI
   k/Gklt9K30Ua+bHXn5uYGTZl4GhKyHlrTPiOO3utzYmbK7r1TY82AVV2s
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="3108154"
X-IronPort-AV: E=Sophos;i="6.04,302,1695711600"; 
   d="scan'208";a="3108154"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2023 00:25:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="1024856386"
X-IronPort-AV: E=Sophos;i="6.04,302,1695711600"; 
   d="scan'208";a="1024856386"
Received: from ply01-vm-store.bj.intel.com ([10.238.153.201])
  by fmsmga006.fm.intel.com with ESMTP; 25 Dec 2023 00:25:33 -0800
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
To: bhelgaas@google.com,
	baolu.lu@linux.intel.com,
	dwmw2@infradead.org,
	will@kernel.org,
	robin.murphy@arm.com,
	lukas@wunner.de
Cc: linux-pci@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v7 0/4] fix vt-d hard lockup when hotplug ATS capable device 
Date: Mon, 25 Dec 2023 03:25:28 -0500
Message-Id: <20231225082532.427362-1-haifeng.zhao@linux.intel.com>
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
driver is unloading an iommu device-TLB invalidation (Intel vt-d spec, or
'ATS invalidation' in PCIe spec) request issued to that link down device,
thus a long time completion/timeout waiting in interrupt context causes
continuous hard lockup warnning and system hang.

Other detail, see every patch commit log.

patch [3&4] were tested by yehaorong@bytedance.com on stable v6.7-rc4.
patch [1&2] only passed compiling on stable v6.7-rc6.


change log:
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


Ethan Zhao (4):
  iommu/vt-d: add flush_target_dev member to struct intel_iommu and pass
    device info to all ATS invalidation functions
  iommu/vt-d: break out device-TLB invalidation if target device is gone
  PCI: make pci_dev_is_disconnected() helper public for other drivers
  iommu/vt-d: don't issue device-TLB invalidate request when device is
    disconnected

 drivers/iommu/intel/dmar.c  | 12 ++++++++++++
 drivers/iommu/intel/iommu.c |  1 +
 drivers/iommu/intel/iommu.h |  2 ++
 drivers/iommu/intel/pasid.c |  4 ++++
 drivers/iommu/intel/svm.c   |  1 +
 drivers/pci/pci.h           |  5 -----
 include/linux/pci.h         |  5 +++++
 7 files changed, 25 insertions(+), 5 deletions(-)

-- 
2.31.1


