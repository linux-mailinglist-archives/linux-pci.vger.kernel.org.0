Return-Path: <linux-pci+bounces-40306-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4DBC33E57
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 05:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 048B718C128C
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 04:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C5314EC73;
	Wed,  5 Nov 2025 04:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Av4qJvm+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF1A1F4262
	for <linux-pci@vger.kernel.org>; Wed,  5 Nov 2025 04:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762315256; cv=none; b=X5cI/s/VKzpcR6r64ehwMyFHj39KnSl8KEdYJzy33SeZeDLrmXsZFV+mt0B2j7AgW0cr8xonYjGOK3SZ4MI4KoNr180GQmT3Jom3TydF/zU0qNjgL6Z8czhiEslEMiB7epQn5mqei7JAspLwqSDBWHSHIK0TopmmJD1jYWjVIoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762315256; c=relaxed/simple;
	bh=GE97+HNjs6vBiVOzuLYmHcAdJfCOtJcy8yNlcLtmFpw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Vytfn7BKvtgtJJuQ9pq48xWnp+LaXpbRqREY4HVSh5ZkvoaBVF5sX83xAZ5YiZj9BJDLF2ArrT3AN3stTLRxf+C0ELjT4M+fvab0R2zZIs983rTc5jDjdi66sOq8aUU2TrCgHTh2PWGepYDGxAoe87HjAYWyM5OlQyJrHZdmMFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Av4qJvm+; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762315255; x=1793851255;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GE97+HNjs6vBiVOzuLYmHcAdJfCOtJcy8yNlcLtmFpw=;
  b=Av4qJvm+on9onKe+9/8EgCcrOTsKI5WOYaviJoAp0xwA21Q6p4YXRhx7
   A6QslsXQqIXOuR9e1WmtHPie/uXOEss0EOO79ZPkNlvb9W6t8idnWl7yY
   Edi3Oesb4tPUAzEZkFFtGPmqK9KXN7rkYbfsEgVnVJyzKCnZodiCIj0Qg
   7mLe89T5hor1eLPctNyl62al7klk3s+d7K4RXwsJpzjsw+5er3gLi6/iv
   xa7PS/rd2vt3iTfP4IvskJ88H7+0l5/IKdu9UNwgV6GWIAR8a2MHttI2x
   LTC54Tvixf3jQ51OehtMzHwgadkxpoEVY8jQHlA3SdpYYjMKr93OFxeDu
   Q==;
X-CSE-ConnectionGUID: y+dQuMqLTser2zkJhsrMpA==
X-CSE-MsgGUID: IJ0PpLEtTDScGkZUcHjDHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64328829"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64328829"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 20:00:52 -0800
X-CSE-ConnectionGUID: z6ycfIbhSyyS1cx58tNXag==
X-CSE-MsgGUID: GM6oir/ARCilPBsEbHttCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,280,1754982000"; 
   d="scan'208";a="224588514"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by orviesa001.jf.intel.com with ESMTP; 04 Nov 2025 20:00:52 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: linux-pci@vger.kernel.org
Cc: linux-coco@lists.linux.dev,
	bhelgaas@google.com,
	aneesh.kumar@kernel.org,
	yilun.xu@linux.intel.com,
	aik@amd.com,
	Arto Merilainen <amerilainen@nvidia.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 0/6] PCI/TSM: Finalize "Link" TSM infrastructure
Date: Tue,  4 Nov 2025 20:00:49 -0800
Message-ID: <20251105040055.2832866-1-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Now that the base series has settled [1], here is a collection of topics
to finish off the "Link" side of the PCI/TSM core. Recall that "Link"
refers to all the physical device security aspects of TEE Device
Interface Security Protocol (TDISP) managed by the host kernel / VMM.

[1]: http://lore.kernel.org/20251031212902.2256310-1-dan.j.williams@intel.com

Add support for Address Association registers that helps root port
hardware pick the Selective IDE Stream to use for a downstream memory
transaction.

Add support for devices that expect to have all Stream IDs on the device
configured to unique values even if the given stream is not in use.

Add an operation for requesting a device enter the LOCKED TDISP state
(pci_tsm_bind())). This has no user outside of test code in the staging
tree [2] for now, but examples exist in the SEV-TIO and ARM CCA RFC
branches.

Add an operation for marshaling TDISP collateral and TDISP state change
requests from confidential guests to the platform TSM
(pci_tsm_guest_req()). This too has no consumer in the staging branch
outside of the samples/devsec/ test module, but is used in the vendor
RFC branches that will soon be incorporated into the staging branch.

These patches have previously appeared in the tsm.git#staging branch [3]
for integration testing.

[2]: https://git.kernel.org/pub/scm/linux/kernel/git/devsec/tsm.git/tree/samples/devsec/link_tsm.c?h=staging#n306
[3]: https://git.kernel.org/pub/scm/linux/kernel/git/devsec/tsm.git/log/?h=staging

Dan Williams (5):
  resource: Introduce resource_assigned() for discerning active
    resources
  PCI/IDE: Initialize an ID for all IDE streams
  PCI/TSM: Add pci_tsm_bind() helper for instantiating TDIs
  PCI/TSM: Add pci_tsm_guest_req() for managing TDIs
  PCI/TSM: Add 'dsm' and 'bound' attributes for dependent functions

Xu Yilun (1):
  PCI/IDE: Add Address Association Register setup for downstream MMIO

 Documentation/ABI/testing/sysfs-bus-pci |  30 +++
 drivers/pci/pci.h                       |   2 +
 include/linux/ioport.h                  |   9 +
 include/linux/pci-ide.h                 |  33 +++
 include/linux/pci-tsm.h                 |  92 +++++++
 include/linux/pci.h                     |   6 +
 drivers/pci/ide.c                       | 248 ++++++++++++++++++-
 drivers/pci/remove.c                    |   1 +
 drivers/pci/tsm.c                       | 303 ++++++++++++++++++++++--
 9 files changed, 694 insertions(+), 30 deletions(-)


base-commit: 0fe2f67a913cedca2be48c5b7b0412cbbaf29108
-- 
2.51.0


