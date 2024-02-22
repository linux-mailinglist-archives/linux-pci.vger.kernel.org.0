Return-Path: <linux-pci+bounces-3851-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D94D385F3CE
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 10:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 822E61F22170
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 09:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888D0364CF;
	Thu, 22 Feb 2024 09:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BxuuILld"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBAD2261F;
	Thu, 22 Feb 2024 09:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708592594; cv=none; b=k5KV5aV8rAExnaE/s6lbfnYzvYY3/O4C9aqlBGY0le74G5xs8VLZ27XTFPKqcyPzsYIfvtBxXJqBdK3W3jsR+U9+5WZe6646lDtMmMorZ+N/j/JpB56viBfYX04fVfz2PNSKDDH9luMxl8jBXNtJOhTcSMvtLiZ6V2aOTEB6QUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708592594; c=relaxed/simple;
	bh=IRW1uC71joWZcrsE1fj7twP6y+QOF1/7H0nNSSijBHE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TqK2vyooRo5kjy/ZpTXi2Z/P1p5Tiz4RwAe5eQ54H/EdN4vuvcFSsTXX8yzZfO8mJuIzMlCP6Aww3Fs/QU3aA5ioqsySRlXXOZWj8oOlCzOL3ePkayozuvSHuPEcvVZmWkC1C6n0iKqZ3JAyhIF10FZVy62obaWJxWvXSiwbZ+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BxuuILld; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708592593; x=1740128593;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IRW1uC71joWZcrsE1fj7twP6y+QOF1/7H0nNSSijBHE=;
  b=BxuuILldvkA+T2BP089Np3g0FMvUtjSBkHSt0YkVHgDiPIvy+PCkjDEy
   tQdnzQ0JAjyJW24ZwRuYZP4s7uBe9WR0GzOXkIZgipEZPvuontUVL1QJk
   0/DIDAUnpUpCHjF48c8aU1tG273a0WwyKb/DJy0pbhaMM5x+PVHg8y3W9
   tIQEQoNUxOYwQVGRemEmjT8cHM2x7IIWgsYoCfsg1RvwPYK+iHMriwKHu
   Kjjoq3jF6gwiT5deQnt83PHhn6BwdZHRvyk6nfEqh4DC6b6QD+RpjGaKw
   kjLa/bQV/CBEX/QQT0e61mVxm4AIjufDFDZEIyCiK1kzstfdYe8m1JqxX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="25264404"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="25264404"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 01:03:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="10122584"
Received: from unknown (HELO ply01-vm-store.amr.corp.intel.com) ([10.238.153.201])
  by orviesa003.jf.intel.com with ESMTP; 22 Feb 2024 01:03:05 -0800
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
	dan.carpenter@linaro.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Ethan Zhao <haifeng.zhao@linux.intel.com>
Subject: [PATCH v13 0/3] fix vt-d hard lockup when hotplug ATS capable device
Date: Thu, 22 Feb 2024 04:02:48 -0500
Message-Id: <20240222090251.2849702-1-haifeng.zhao@linux.intel.com>
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
patch [1-3] passed compiling on stable v6.8-rc4 (Baolu's rbtree branch).

change log:
v13:
- rebased on Baolu's rbtree patchset.
- removed refactor patches [3/5][4/5] in v12.
- amend commit description of patch[3/3].
v12:
- use base-commit tag to format patch.
- fix building issue on v6.8-rc2 repported by lkp@intel.com.
- https://lkml.org/lkml/2024/1/28/535
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
- https://lkml.org/lkml/2024/1/25/1314
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
 


Ethan Zhao (3):
  PCI: make pci_dev_is_disconnected() helper public for other drivers
  iommu/vt-d: don't issue ATS Invalidation request when device is
    disconnected
  iommu/vt-d: improve ITE fault handling if target device isn't valid

 drivers/iommu/intel/dmar.c  | 25 +++++++++++++++++++++++++
 drivers/iommu/intel/pasid.c |  3 +++
 drivers/pci/pci.h           |  5 -----
 include/linux/pci.h         |  5 +++++
 4 files changed, 33 insertions(+), 5 deletions(-)


base-commit: e60bf5aa1a74c0652cd12d0cdc02f5c2b5fe5c74
-- 
2.31.1


