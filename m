Return-Path: <linux-pci+bounces-41036-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D416CC55659
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 03:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA13F4E14C8
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 02:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7817620F09C;
	Thu, 13 Nov 2025 02:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="buyrDW/R"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A99829D282
	for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2025 02:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763000046; cv=none; b=OolCLxTMj2yq5/5C+rnVdCGPiROtJuaA6BzOhUJ/CHht6qy5Rt8As3Cs19InIVasOcaR+OWlTIq9YHfEx3H1+74csn9YNMgXAjScOStaWI5ZnwdzvaC69z4kCd2Tw2yLBVgpC6O1jpxJV/Kwyj2fAC6bQGoTyOWAuJsEfdLccEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763000046; c=relaxed/simple;
	bh=GBotcwGj8MYNya16slKOQXeJQhVQIxA26JCdBgVVknA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jmju2zN2/TnLJUhTGWFHs/WsGlOUpxwSVtMb1Uk6/KhSMaNPo+7MR68h7AkrIswJyzcRzlMJK6/5IFcyeaceSv+RNiXkRf2mRbUSlMkHr90BNAgnFa7vISisevyqqHsqtfAd77IbqRBQ3dDZOYBtcENXD8USDtK/D3xLxmsiARI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=buyrDW/R; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763000045; x=1794536045;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GBotcwGj8MYNya16slKOQXeJQhVQIxA26JCdBgVVknA=;
  b=buyrDW/Riyy8V3IXlw+LCQ0Nalzr4EoXlUYln7vugDxQbGUozBl6tmdG
   hMCu41ZU2JlOJCu+rg3HUpyYGEKF5PhAV6Y/MqVO0UxJGb4JRLLtdFlOZ
   3EoQu2Z0OvutWVeLWKCaC24rbxNue+qs+vFGdlE6szE+0GFv5PGEdv3Du
   YJprsCR5Hgvs3GKFPvqLIwgCx9b/J6G3s2vO8Icl4u7+gADwbsGRfmC3K
   Ycr8Qd1NZElSU4R+ALJ47Qlf/PJX3JE3MSno6QV1IDx9u632oKxDgFh3R
   QAbOKhCpoJ04ThXO95sfFjhsFhK3lVvdaXncEgMzkhHOCk9RdlEuvc33p
   Q==;
X-CSE-ConnectionGUID: JZijyPTBTI2MI3OUI5CETA==
X-CSE-MsgGUID: Z/CST4mKTCq5U8YEItBPMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="82471754"
X-IronPort-AV: E=Sophos;i="6.19,300,1754982000"; 
   d="scan'208";a="82471754"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 18:14:05 -0800
X-CSE-ConnectionGUID: RRalTxGnTpuk+Ul3n8oNLA==
X-CSE-MsgGUID: IIIfmtFQRbalC1CwAc76UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,300,1754982000"; 
   d="scan'208";a="189802482"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa009.fm.intel.com with ESMTP; 12 Nov 2025 18:14:04 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: linux-pci@vger.kernel.org
Cc: linux-coco@lists.linux.dev,
	Jonathan.Cameron@huawei.com
Subject: [PATCH v2 0/8] PCI/TSM: Finalize "Link" TSM infrastructure
Date: Wed, 12 Nov 2025 18:14:38 -0800
Message-ID: <20251113021446.436830-1-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes since v1 [1]:
- Fix build error reported for the commits in linux-next (lkp@intel.com)
- Clarify how TSM drivers can accept / modify default the @mem_assoc and
  @pref_assoc settings (Jonathan)
- Drop the pci_tsm_doe_transfer() stub (Yilun)
- Simple cleanups of reserve_stream_idx() and reserve_stream_id()
  (Jonathan)
- Rename alloc_stream_id() to request_stream_id() (Jonathan)
- Simplify conditional in pci_tsm_bind() (Jonathan)
- Reflow whitespace and spelling fixes (Jonathan)

[1]: http://lore.kernel.org/20251105040055.2832866-1-dan.j.williams@intel.com

Now that the base series has settled [2], here is a collection of topics
to finish off the "Link" side of the PCI/TSM core. Recall that "Link"
refers to all the physical device security aspects of TEE Device
Interface Security Protocol (TDISP) managed by the host kernel / VMM.

[2]: http://lore.kernel.org/20251031212902.2256310-1-dan.j.williams@intel.com

Add support for Address Association registers that helps root port
hardware pick the Selective IDE Stream to use for a downstream memory
transaction.

Add support for devices that expect to have all Stream IDs on the device
configured to unique values even if the given stream is not in use.

Add an operation for requesting a device enter the LOCKED TDISP state
(pci_tsm_bind())). This has no user outside of test code in the staging
tree [3] for now, but examples exist in the SEV-TIO and ARM CCA RFC
branches.

Add an operation for marshaling TDISP collateral and TDISP state change
requests from confidential guests to the platform TSM
(pci_tsm_guest_req()). This too has no consumer in the staging branch
outside of the samples/devsec/ test module, but is used in the vendor
RFC branches that will soon be incorporated into the staging branch.

These patches have previously appeared in the tsm.git#staging branch [4]
for integration testing.

[3]: https://git.kernel.org/pub/scm/linux/kernel/git/devsec/tsm.git/tree/samples/devsec/link_tsm.c?h=staging#n306
[4]: https://git.kernel.org/pub/scm/linux/kernel/git/devsec/tsm.git/log/?h=staging

Dan Williams (7):
  drivers/virt: Drop VIRT_DRIVERS build dependency
  PCI/TSM: Drop stub for pci_tsm_doe_transfer()
  resource: Introduce resource_assigned() for discerning active
    resources
  PCI/IDE: Initialize an ID for all IDE streams
  PCI/TSM: Add pci_tsm_bind() helper for instantiating TDIs
  PCI/TSM: Add pci_tsm_guest_req() for managing TDIs
  PCI/TSM: Add 'dsm' and 'bound' attributes for dependent functions

Xu Yilun (1):
  PCI/IDE: Add Address Association Register setup for downstream MMIO

 drivers/Makefile                        |   2 +-
 Documentation/ABI/testing/sysfs-bus-pci |  30 +++
 drivers/pci/pci.h                       |   2 +
 include/linux/ioport.h                  |   9 +
 include/linux/pci-ide.h                 |  38 +++
 include/linux/pci-tsm.h                 |  92 +++++++-
 include/linux/pci.h                     |   6 +
 drivers/pci/ide.c                       | 244 ++++++++++++++++++-
 drivers/pci/remove.c                    |   1 +
 drivers/pci/tsm.c                       | 299 ++++++++++++++++++++++--
 10 files changed, 689 insertions(+), 34 deletions(-)


base-commit: a4438f06b1db15ce3d831ce82b8767665638aa2a
-- 
2.51.1


