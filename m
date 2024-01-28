Return-Path: <linux-pci+bounces-2654-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BBD83FAED
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 00:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC0E828203B
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jan 2024 23:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C47446C6;
	Sun, 28 Jan 2024 23:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tydek15V"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC7C446CA;
	Sun, 28 Jan 2024 23:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706484736; cv=none; b=re+yVJ+rZWA1znFpRVnoPEtFC2Z7eSN4kq2zpToQJeWt9zLU3i0gdt+gYpoPI7qQlV3st7di9EgBuo08WzxbGy8puN+tBKeu7DiERFReciGH1tphLSYAr/fpmCj26XBOFZlr7lfg2ZnSwH+blR7OVQ3OxWj9/PpL80I6MqvmPug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706484736; c=relaxed/simple;
	bh=O2DJ6Mu5KMdLzbxSBZdon80LtAPdKg3vJDjBKzmyAyc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LEBx3eMWI8Ty0o8B1BIZAepnkdT9oP/gx8SIYyu/CS8VGwWsXEcxVQSEOce21ogF6VOWoUTE6ZEGY+aBQswX5lKWQHAqL1BhR5Po38gczGyiygtpVibNYkkvBpW9nbi1cKyOrImlj0lX+I3DtE2qOE3VcnWJ98DdCQAcK1zeBVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tydek15V; arc=none smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706484734; x=1738020734;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=O2DJ6Mu5KMdLzbxSBZdon80LtAPdKg3vJDjBKzmyAyc=;
  b=Tydek15VmtoZGZ1Up8DsMfwV4JI1u5TO0m2NcFfmPqFnBkKj6oOp9Pt4
   pB6sEDVNcSAhPfB5WAeQRMvPndDp3QqynQG+P7VHNP2v1qM/gALvBKq/q
   dkNJLWoBe0h9D05hr5PVAYvS7Pcd5EhJuHQkZzTY4topUFXzjBJ3PrFI7
   DaCBCypa2grnWGXa2KeVXe7X4ud6CRM1mmhi4wHZjCyL6FCFGD99LAAv+
   E05E6J9h2wXmArPf+kN6g9E399k2m/8zV5OZxpTMuVlns7sE/71DdexKL
   hdtJhXTEDLwns1K6/0tQ0yCdZIeo5o5QFLZNsxB4twaY+6q49zqfCcOU8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="406535984"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="406535984"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 15:32:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="857921252"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="857921252"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 15:32:12 -0800
Received: from debox1-desk4.intel.com (sdutta-mobl2.amr.corp.intel.com [10.209.55.52])
	by linux.intel.com (Postfix) with ESMTP id 3036D580D78;
	Sun, 28 Jan 2024 15:32:12 -0800 (PST)
From: "David E. Box" <david.e.box@linux.intel.com>
To: mika.westerberg@linux.intel.com,
	david.e.box@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	bhelgaas@google.com,
	rjw@rjwysocki.net
Cc: tasev.stefanoska@skynet.be,
	enriquezmark36@gmail.com,
	kernel@witt.link,
	wse@tuxedocomputers.com,
	vidyas@nvidia.com,
	kai.heng.feng@canonical.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	ricky_wu@realtek.com,
	mario.limonciello@amd.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] Always build aspm.c
Date: Sun, 28 Jan 2024 15:32:07 -0800
Message-Id: <20240128233212.1139663-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here is the series to always build aspm.c, add back L1SS save/restore, and
consolidate all ASPM related code in aspm.c.

Patch 1 - Moves all PCI core functions running under CONFIG_PCIEASPM into
aspm.c and changes they Makefile to always build it. No functional changes.

Patch 2 - Creates a separate function to save the L1SS offset and places it
outside of CONFIG_PCIEASPM in aspm.c so that the offset is available for
later use by the L1SS save/restore code which needs to run when
CONFIG_PCIEASPM=n.

Patch 3 - Updated L1 Substate save/restore patch from previous V5 [1].

Patch 4 - Moves the LTR save/restore state functions into aspm.c outside of
CONFIG_PCIEASPM.

Patch 5 - Moves the LTR save/restore state calls into
pci_save/restore_pcie_state().

The series does not continue any of the ASPM robustness changes proposed by
Ilpo [2]. But if we think it's worth combining with this series I can
add it and help continue the work.

[1] https://lore.kernel.org/linux-pci/20231221011250.191599-1-david.e.box@linux.intel.com/
[2] https://lore.kernel.org/linux-pci/20230918131103.24119-1-ilpo.jarvinen@linux.intel.com/

David E. Box (5):
  PCI: Always build aspm.c
  PCI: Create function to save L1SS offset
  PCI/ASPM: Add back L1 PM Substate save and restore
  PCI: Move pci_save/restore_ltr_state() to aspm.c
  PCI: Call LTR save/restore state from PCIe save/restore

 drivers/pci/pci.c         |  91 ++++----------
 drivers/pci/pci.h         |  10 +-
 drivers/pci/pcie/Makefile |   2 +-
 drivers/pci/pcie/aspm.c   | 257 ++++++++++++++++++++++++++++++++++++--
 drivers/pci/probe.c       |  62 +--------
 include/linux/pci.h       |   4 +-
 6 files changed, 283 insertions(+), 143 deletions(-)


base-commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a
-- 
2.34.1


