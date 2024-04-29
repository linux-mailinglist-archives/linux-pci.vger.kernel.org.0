Return-Path: <linux-pci+bounces-6771-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D1F8B55B4
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 12:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1224B1C223AE
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 10:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E41838FA6;
	Mon, 29 Apr 2024 10:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qu3vcQ5U"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8B539AC7;
	Mon, 29 Apr 2024 10:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714387643; cv=none; b=e4pTWmeMCBy6wx8KUg2WyQdL2acq2fW+89Pi2hCB0KoQVbH1nMOP9Ldl2ioZraPHEE3qsDeOcRmPkn8kmoXSxtDjA8FaIgkvY4nRwCVft6r3vtG8V8fk/vSDeG5xzD7CSmOIeW+Org0FL4dEhXVx394G4+1+TXFqskZb1S6InWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714387643; c=relaxed/simple;
	bh=xm79CcWQkryZA5hqm6JEw6+gJt6rJs0jHDkc/Fm0Kvo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PMkCPamOIaZciajlXTZUehtyCBPm+9i2AakerHu2nVKu2k6AV7/CGMwmBPsfiS7O3GbPvsSYzgEHf6/OJOiPwADW7ek1SEmah7vprQJ26EwxlITeiA7U5vkx60RwBgqSE4kBBG72vNKD+tiLsZMu9XqRRPJA5Cz8Qn+9zozARFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qu3vcQ5U; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714387642; x=1745923642;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xm79CcWQkryZA5hqm6JEw6+gJt6rJs0jHDkc/Fm0Kvo=;
  b=Qu3vcQ5UG/cmqwNXpYZe7J/1dzkv/nGko92CM2YZCtuhfNbxAnRv4zgM
   /+fPjCgG41S60LisqFNIDBbrbgewYVQa6UJrFd/Huqqc626xD9/VLH3mB
   uk6A1yGvlk2OI6vkFsUJLE5/Z4s1oDqhrgEB3/+Jdeq0xfIR/L+s6s+An
   5LPxbIYMNLSQ048cmQyTsJ2rKPq5kIz//eiFFu+wQmWs1TVESTdbbeVBR
   5Wu3yAZhJbG52I1JLGeAxYzDUIBldUJqAcLwqOm/3w77MZt2Qrg8SuopW
   cyDtp1XqYk/q1ug8IRbyUFO1DrttgoIltbM9ElGnwcnWl/pAF7UXdADA5
   A==;
X-CSE-ConnectionGUID: wDQjT4U1T7SbMyjplIAeFQ==
X-CSE-MsgGUID: DxJIkC6lQjesVH6XCElxqg==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="9966408"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="9966408"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 03:47:21 -0700
X-CSE-ConnectionGUID: 4DvHrAC2QZakeUA59jFLEA==
X-CSE-MsgGUID: d/YhKH28ScaMZhNP8uPcwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="26037455"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.45])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 03:47:18 -0700
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
Subject: [PATCH 04/10] ARM: orion5x: Use generic PCI Conf Type 1 helper
Date: Mon, 29 Apr 2024 13:46:27 +0300
Message-Id: <20240429104633.11060-5-ilpo.jarvinen@linux.intel.com>
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

Convert orion5x PCI code to use pci_conf1_ext_addr() from PCI core to
calculate PCI Configuration Type 1 address.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 arch/arm/mach-orion5x/pci.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-orion5x/pci.c b/arch/arm/mach-orion5x/pci.c
index 6376e1db6386..8b7d67549adf 100644
--- a/arch/arm/mach-orion5x/pci.c
+++ b/arch/arm/mach-orion5x/pci.c
@@ -216,15 +216,6 @@ static int __init pcie_setup(struct pci_sys_data *sys)
 #define PCI_P2P_DEV_OFFS		24
 #define PCI_P2P_DEV_MASK		(0x1f << PCI_P2P_DEV_OFFS)
 
-/*
- * PCI_CONF_ADDR bits
- */
-#define ORION5X_PCI_CONF_REG(reg)	((reg) & 0xfc)
-#define ORION5X_PCI_CONF_FUNC(func)	(((func) & 0x3) << 8)
-#define PCI_CONF_DEV(dev)		(((dev) & 0x1f) << 11)
-#define PCI_CONF_BUS(bus)		(((bus) & 0xff) << 16)
-#define PCI_CONF_ADDR_EN		(1 << 31)
-
 /*
  * Internal configuration space
  */
@@ -276,9 +267,7 @@ static int orion5x_pci_hw_rd_conf(int bus, u8 devfn, u32 where,
 	unsigned long flags;
 	spin_lock_irqsave(&orion5x_pci_lock, flags);
 
-	writel(PCI_CONF_BUS(bus) |
-		PCI_CONF_DEV(PCI_SLOT(devfn)) | ORION5X_PCI_CONF_REG(where) |
-		ORION5X_PCI_CONF_FUNC(PCI_FUNC(devfn)) | PCI_CONF_ADDR_EN, PCI_CONF_ADDR);
+	writel(pci_conf1_addr(bus, devfn, where, true), PCI_CONF_ADDR);
 
 	*val = readl(PCI_CONF_DATA);
 
@@ -300,9 +289,7 @@ static int orion5x_pci_hw_wr_conf(int bus, u8 devfn, u32 where,
 
 	spin_lock_irqsave(&orion5x_pci_lock, flags);
 
-	writel(PCI_CONF_BUS(bus) |
-		PCI_CONF_DEV(PCI_SLOT(devfn)) | ORION5X_PCI_CONF_REG(where) |
-		ORION5X_PCI_CONF_FUNC(PCI_FUNC(devfn)) | PCI_CONF_ADDR_EN, PCI_CONF_ADDR);
+	writel(pci_conf1_addr(bus, devfn, where, true), PCI_CONF_ADDR);
 
 	if (size == 4) {
 		__raw_writel(val, PCI_CONF_DATA);
-- 
2.39.2


