Return-Path: <linux-pci+bounces-17193-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 498DE9D5A4E
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 08:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 100D628167B
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 07:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41714176FD2;
	Fri, 22 Nov 2024 07:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MMWZnMas"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D07166F26
	for <linux-pci@vger.kernel.org>; Fri, 22 Nov 2024 07:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732261844; cv=none; b=vB5e1tso+AVGl2biM2AvcOFfSjMzphJFIX/PG60wgt3Yf1O28edChaG+u6dj3m18k416pa8UPLq8IibtqJ9+t+Qz3enuhSdyX3GvC/VY01O/8SY0DJunxnwi1CMlf3zVytccYLT3APZqkUZwDKi0B2TTt7yPJ1G0lEmJZUB4Bgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732261844; c=relaxed/simple;
	bh=O3ZsdH4fZwDkt1iFEBhrQDi06NYunmCQRzLSOvjBkE8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CA7K02GIsKLLpYEUNXuhUa2LnFaLuD1TtoJ0ey26XvyaRjllnqBdHCXdmtxt8t8tKnROIiFw5q4Ombcqwhs1mnLre4HQPRiLDLU6cHp0MFckT0BqVurLz1zz/CzcY/W10awJFewZva879l9ahRX7dyvpK9deu99bFqKkVyfTc/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MMWZnMas; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732261842; x=1763797842;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=O3ZsdH4fZwDkt1iFEBhrQDi06NYunmCQRzLSOvjBkE8=;
  b=MMWZnMas6v76RzDQJ/vu/MDc17p+9BJ1CwOQkGjk6Pqdpq5mfbcB5okh
   QDfPGb5tgYc9SzTeRRWNSpB/iiJQxnkOg2zvCM81p7RLXDT7PWFcvM5/V
   1UHh7WEWEIpxjfdDBMGB3bBeylB0ItR+hiGae4QWmie8TzmqIb26uvlLj
   h3LZlX9SmNpxlN4AzSDvnWqWMxIEF6tbfp3DWDX+xaKRgXEwE01wvMopY
   3FTFSXU3PJOiX5h5n2i9eDNreKQZaSp0P3/sY2JiZjEfTWICJfuyiioej
   /yFiz5TSOq0oGH7IjzuFnhdE+7WZycYvB63O1wdBJuxm4+V/xp1Z3UZnl
   w==;
X-CSE-ConnectionGUID: t+eSOZuJS5ywjHY5aVg/SA==
X-CSE-MsgGUID: MHK6rF3zR2218UgK9WVykg==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="32156799"
X-IronPort-AV: E=Sophos;i="6.12,175,1728975600"; 
   d="scan'208";a="32156799"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 23:50:42 -0800
X-CSE-ConnectionGUID: ac5jOAfyTHG7nup49Mn19w==
X-CSE-MsgGUID: 9M3EfFw9TYSvSCjItcojrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,175,1728975600"; 
   d="scan'208";a="90301532"
Received: from arl-s-03.igk.intel.com ([10.91.111.103])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 23:50:39 -0800
From: Szymon Durawa <szymon.durawa@linux.intel.com>
To: helgaas@kernel.org
Cc: Szymon Durawa <szymon.durawa@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	linux-pci@vger.kernel.org,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Subject: [PATCH v3 0/8] VMD add second rootbus support
Date: Fri, 22 Nov 2024 09:52:07 +0100
Message-Id: <20241122085215.424736-1-szymon.durawa@linux.intel.com>
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
It allows to find/register VMD Rootbus1 and discovers devices or root
ports under it.

Patches 1 to 6 introduce code refactoring without functional changes.
Patch 7 implements VMD Rootbus1 support and patch 8 provides workaround for
rootbus number hardwired to fixed non-zero value. Patch 8 is necessary for
correct enumeration attached devices under VMD Rootbus1. Without it user cannot
access those devices as they are not visible in the system, only drives under
VMD Rootbus0 are available to the user.

Changes from v1:
- splitting series into more commits, requested by Bjorn
- adding helper functions, suggested by Bjorn
- minor typos and unclear wording updated, suggested by Bjorn

Changes from v2:
- wording update in commit logs, suggested by Bjorn

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
  PCI: vmd: Add workaround for bus number hardwired to fixed non-zero
    value

 drivers/pci/controller/vmd.c | 470 +++++++++++++++++++++++++++--------
 1 file changed, 360 insertions(+), 110 deletions(-)
 mode change 100644 => 100755 drivers/pci/controller/vmd.c

-- 
2.39.3


