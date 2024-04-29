Return-Path: <linux-pci+bounces-6768-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3FC8B55AE
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 12:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB6951C21E68
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 10:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DDC22EEB;
	Mon, 29 Apr 2024 10:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DV7rtGNg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C1D3B7A0;
	Mon, 29 Apr 2024 10:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714387617; cv=none; b=o7VyS3YQAU7tE/WksLzJazlcvSgXPes3nH37ZRS9g+5pJXSsJnXZouyqpwhTE3kiDuYzxGL1ZebQEQEEqXyPTfBsYK7PSTlehHGzM+7cdLmps6ko0E2zr5+I09Dgp54PqPhfC1puPnOnKv3u+Y0EVuL7omvL6nMggSTxGBQD/Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714387617; c=relaxed/simple;
	bh=R2riUg/Wc1wqrQ5JnljoOoCmOH+vsHTb6i6sFG4RQIs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nloWPX3plTXJATyRayba5DRMdvW/urzQH5AwA49n3EQoMmiSSyQwekffZM1LcJTEOS69q9kgXQlVWn65nWOfFwa8pzRBZn+DFy7d+km3mCnFiZcbmIpfL7nT3VFc7z/f1RYZxQCEldYg9DZwqpUw40fSIDX3X0r4N0y6XKShn9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DV7rtGNg; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714387616; x=1745923616;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R2riUg/Wc1wqrQ5JnljoOoCmOH+vsHTb6i6sFG4RQIs=;
  b=DV7rtGNgmisbdzuxAC2wVNJ+aWVXPizoyDTbCjETCLyjYT4k6oLE/Ks4
   v27inOtscSRiCoIw0xA3GCARhvy8pw3xzeiV8H3h7/YqytnxlXICfx7hC
   ZOLOBmhwOZhtJKOceKEdZV3MpIXKs4cSFI5Jsero6jh08FtSqQIqp7pOV
   NpO6eyVKBwqcBJ4oevVzVJVVWsk889D7KU4dbShaIKBeljCb320Jiq4JU
   ZGIjPbHAfreZBVTpjOoBjeaYqc5+uIyMQ0jkj4lZixFwU6n9AUnENeJVg
   4/pScTEX2Mbk6hhQt5Elif+3aBX5Tf/FsuQ2MHwltYlRhbJCYPEpP07US
   A==;
X-CSE-ConnectionGUID: gLCXlhBgQcasfVScuPfcXw==
X-CSE-MsgGUID: b1+wGhy8SFCWRmkuzJ4iCA==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="27558815"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="27558815"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 03:46:55 -0700
X-CSE-ConnectionGUID: 8awMQp1vRrWFMQAWhN3V4A==
X-CSE-MsgGUID: nM3+DbKYRoC6OTW0EV+TyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="30896676"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.45])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 03:46:50 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 01/10] ARM: orion5x: Rename PCI_CONF_{REG,FUNC}() out of the way
Date: Mon, 29 Apr 2024 13:46:24 +0300
Message-Id: <20240429104633.11060-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240429104633.11060-1-ilpo.jarvinen@linux.intel.com>
References: <20240429104633.11060-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

orion5x defines PCI_CONF_REG() and PCI_CONF_FUNC() that are problematic
because PCI core is going to introduce defines with the same names.

Add ORION5X prefix to those defines to avoid name conflicts.

Note: as this is part of series that replaces the code in question
anyway, only bare minimum renaming is done and other similarly named
macros are not touched.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 arch/arm/mach-orion5x/pci.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-orion5x/pci.c b/arch/arm/mach-orion5x/pci.c
index 3313bc5a63ea..77ddab90f448 100644
--- a/arch/arm/mach-orion5x/pci.c
+++ b/arch/arm/mach-orion5x/pci.c
@@ -219,8 +219,8 @@ static int __init pcie_setup(struct pci_sys_data *sys)
 /*
  * PCI_CONF_ADDR bits
  */
-#define PCI_CONF_REG(reg)		((reg) & 0xfc)
-#define PCI_CONF_FUNC(func)		(((func) & 0x3) << 8)
+#define ORION5X_PCI_CONF_REG(reg)	((reg) & 0xfc)
+#define ORION5X_PCI_CONF_FUNC(func)	(((func) & 0x3) << 8)
 #define PCI_CONF_DEV(dev)		(((dev) & 0x1f) << 11)
 #define PCI_CONF_BUS(bus)		(((bus) & 0xff) << 16)
 #define PCI_CONF_ADDR_EN		(1 << 31)
@@ -277,8 +277,8 @@ static int orion5x_pci_hw_rd_conf(int bus, int dev, u32 func,
 	spin_lock_irqsave(&orion5x_pci_lock, flags);
 
 	writel(PCI_CONF_BUS(bus) |
-		PCI_CONF_DEV(dev) | PCI_CONF_REG(where) |
-		PCI_CONF_FUNC(func) | PCI_CONF_ADDR_EN, PCI_CONF_ADDR);
+		PCI_CONF_DEV(dev) | ORION5X_PCI_CONF_REG(where) |
+		ORION5X_PCI_CONF_FUNC(func) | PCI_CONF_ADDR_EN, PCI_CONF_ADDR);
 
 	*val = readl(PCI_CONF_DATA);
 
@@ -301,8 +301,8 @@ static int orion5x_pci_hw_wr_conf(int bus, int dev, u32 func,
 	spin_lock_irqsave(&orion5x_pci_lock, flags);
 
 	writel(PCI_CONF_BUS(bus) |
-		PCI_CONF_DEV(dev) | PCI_CONF_REG(where) |
-		PCI_CONF_FUNC(func) | PCI_CONF_ADDR_EN, PCI_CONF_ADDR);
+		PCI_CONF_DEV(dev) | ORION5X_PCI_CONF_REG(where) |
+		ORION5X_PCI_CONF_FUNC(func) | PCI_CONF_ADDR_EN, PCI_CONF_ADDR);
 
 	if (size == 4) {
 		__raw_writel(val, PCI_CONF_DATA);
-- 
2.39.2


