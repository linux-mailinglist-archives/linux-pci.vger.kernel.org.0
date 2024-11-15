Return-Path: <linux-pci+bounces-16833-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BA49CDA6A
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 09:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F19BB2361F
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 08:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6B3188714;
	Fri, 15 Nov 2024 08:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hmJCwP6D"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23CA2B9B7
	for <linux-pci@vger.kernel.org>; Fri, 15 Nov 2024 08:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731659082; cv=none; b=OHKiJtE1fYqAykDeecYTcN1lAF+l/9ln6XcSe05TMSR6erzyOIABZxILWZhgM8LOW9qNBsHS+D0j62rRS2tBo51J4k/ZIchOkmhT9U+vFWN7z0ZBet3WyH74uqoHjweGHkA+Qcj/aTjCodhJAu1hRQhto+6JTYa0Utjjsr0qTqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731659082; c=relaxed/simple;
	bh=1rpa2h0Ydyfhg+ZMjSOkMq+HrUlLc/S/Do6lxT2jELs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EF2ig6w6n96IaabTYnIE682ztocfvsLF97UFzJlKkkc/1a70ao1wdyMzzGYNxX2R2sL/AFQnVvOqXJjouKZbPm0H4UyzXLsNHhhDuoTpVqFMmk0SJfVuwpRP57exJPz4yRIISo66khDDRBzPrECRhu84JXEZAiPEINu6nOJfTOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hmJCwP6D; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731659081; x=1763195081;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1rpa2h0Ydyfhg+ZMjSOkMq+HrUlLc/S/Do6lxT2jELs=;
  b=hmJCwP6DyJxDDWzkD1atfJJ9anZDqOJFz6C2DoJjAgrWpjuOLUxVR8Fo
   7/G9R3+ZzIMN/183tX0UU3wx3rzHZ2CF36WCeDTpYzvobWamWmx7cOJ9P
   aGOP+f3NFyctEgfXTM3oKtDFan2FHXv1SL0pNng3wdwhmyoXbEXkfHzoE
   lYeDLPcMcA1yyz1lrzdXWFpjDGAUw2otKjvyKgyhX4y+02+v53E33OSrZ
   zw0T+xDTCJY5xFKluxenSSJGsBKYrTACjWPyH0CVK0xzjZSHJZuUtA7M+
   5zTlBE7mXrM+cZpHiXQrcJ7RQrqNNdC3YbPkl8Hk6DAi5txPapfs5tldW
   A==;
X-CSE-ConnectionGUID: v1Z88HmASlGRI4ziUPJpqQ==
X-CSE-MsgGUID: F4gra3N1Rw+/s7VTtvM7TA==
X-IronPort-AV: E=McAfee;i="6700,10204,11256"; a="42185282"
X-IronPort-AV: E=Sophos;i="6.12,156,1728975600"; 
   d="scan'208";a="42185282"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2024 00:24:41 -0800
X-CSE-ConnectionGUID: KJHXFsm8Rau4eXYjzZaybw==
X-CSE-MsgGUID: O8io4X9NTQiF34z0mdZz+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,156,1728975600"; 
   d="scan'208";a="88898560"
Received: from arl-s-03.igk.intel.com ([10.91.111.103])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2024 00:24:38 -0800
From: Szymon Durawa <szymon.durawa@linux.intel.com>
To: helgaas@kernel.org
Cc: Szymon Durawa <szymon.durawa@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	linux-pci@vger.kernel.org,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Subject: [PATCH v2 0/8] VMD add second rootbus support
Date: Fri, 15 Nov 2024 10:22:48 +0100
Message-Id: <20241115092256.2525264-1-szymon.durawa@linux.intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series implements second rootbus support inside Intel VMD module.
Current implementation allows VMD to take ownership of devices only on first
bus (Rootbus0). Starting from Intel Arrow Lake, VMD exposes second bus 
(Rootbus1) to allow VMD to own devices on this bus as well. VMD MMIO BARs
(CFGBAR. MEMBAR1 and MEMBAR2) are now shared between Rootbus0 and Rootbus1.
Reconfiguration of 3 MMIO BARs is required by resizing current MMIO BARs ranges.
It allows to find/register Rootbus1 and discovers devices behind it.

Patches 1 to 6 introduce code refactoring without functional changes.
Patch 7 implements VMD Rootbus1 and patch 8 provides workaround for rootbus
number hardwired to fixed non-zero value. Patch 8 is necessary for correct 
enumeration attached devices behind Rottbus1. Without it user cannot access
those devices.

Changes from v1:
- splitting series into more commits, requested by Bjorn
- adding helper functions, suggested by Bjorn
- minor typos and unclear wording updated, suggested by Bjorn

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org
Suggested-by: Nirmal Patel <nirmal.patel@linux.intel.com>
Reviewed-by: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Signed-off-by: Szymon Durawa <szymon.durawa@linux.intel.com>

Szymon Durawa (8):
  PCI: vmd: Add vmd_bus_enumeration()
  PCI: vmd: Add vmd_configure_cfgbar()
  PCI: vmd: Add vmd_configure_membar() and
    vmd_configure_membar1_membar2()
  PCI: vmd: Add vmd_create_bus()
  PCI: vmd: Replace hardcoded values with enum and defines
  PCI: vmd: Convert bus and busn_start to an array
  PCI: vmd: Add support for second rootbus under VMD
  PCI: vmd: Add workaround for rootbus number hardwired to fixed
    non-zero value

 drivers/pci/controller/vmd.c | 467 ++++++++++++++++++++++++++---------
 1 file changed, 357 insertions(+), 110 deletions(-)
 mode change 100644 => 100755 drivers/pci/controller/vmd.c

-- 
2.39.3


