Return-Path: <linux-pci+bounces-35099-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF53B3BC12
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 15:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2186205CAA
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 13:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B33731A550;
	Fri, 29 Aug 2025 13:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TJq1H0QL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED002F83B7;
	Fri, 29 Aug 2025 13:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756473101; cv=none; b=XoxYo3hkyAn1Y+Bh8Afgr9cJ/hBaILOsJfR89nfx4pu9taIYY0NXmm1H436p+5rzAInIEBNxvvkpNkVgHnWWmM9DOkyKj7gkYc2JW810JTd7l6mKWQsTP5g5po1HqZ6RROO8/C8lrxdyNTo3J9q4BDGA0QcavFm2dJi5iZvCnsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756473101; c=relaxed/simple;
	bh=6CmIUrioSfaBP4/6EQqT9N+5TC9MVCQT9GnbpIvI7Tc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IV7QkJlsHEo7lbXuMwgQjG2Vf/od4VsWiTgdYFjhqGl5U2+phmFrR/lH1FGN/0utB6bmoILNdKEqXuwgdTfmT4/d4zLwLKcjY/wzXSPH6MRabr/Hw534aXJINNCLslEbRQ3hSxylxCKA/NDuvQ4aqvJ5B+8ZBOibA973/hmnaak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TJq1H0QL; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756473099; x=1788009099;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6CmIUrioSfaBP4/6EQqT9N+5TC9MVCQT9GnbpIvI7Tc=;
  b=TJq1H0QLf9X9XQBB5a+s12ixUnKCGlTz/2UBYujA/P9LXjMA0vd34/hC
   R0eUl+0yyrVhHtp1Rp2+m/oIXRZ2QvmV8434GaZXMnOWgVfNhGiZJ7TvS
   zTgCp/3uiIx3pjy0U7GIqT03uES0or3vwGRdYwQc2TISZU7ZOGJPt+Vl+
   STDyjE77GFKEii/Q+BsBFj97zWZqwnXtXpw/i5Bif4QCzm/APjpKwmMJH
   q+tmvEjCgpCKYg8UPjJswAxnqWiAyE1YHf4QeGKwaSU8EityeaH7fqzvF
   fwTs5fa9d9OvmGs1s+mh/US/pxS8NT2cRcIrWKRtn579GNUfZn22eQGGw
   Q==;
X-CSE-ConnectionGUID: dP4me6xuTS6c9RZ+FUKtLw==
X-CSE-MsgGUID: 8rSVzG/DQtmXNs1oxk6x+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="58687488"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="58687488"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 06:11:38 -0700
X-CSE-ConnectionGUID: JnLYhS0yS7OPZkWUIsP1cw==
X-CSE-MsgGUID: dSv00wODTY6Hb56C5tdNNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="174550837"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 06:11:36 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 02/24] sparc/PCI: Remove pcibios_enable_device() as they do nothing extra
Date: Fri, 29 Aug 2025 16:10:51 +0300
Message-Id: <20250829131113.36754-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250829131113.36754-1-ilpo.jarvinen@linux.intel.com>
References: <20250829131113.36754-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Under arch/sparc/ there are multiple copies of pcibios_enable_device() but
none of those seem to do anything extra beyond what pci_enable_resources()
is supposed to do. These functions could lead to inconsistencies in
behavior, especially now as pci_enable_resources() and the bridge window
resource flags behavior are going to be altered by upcoming changes.

Remove all pcibios_enable_device() from arch/sparc/ so that PCI core can
simply call into pci_enable_resources() instead using its __weak version
of pcibios_enable_device().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 arch/sparc/kernel/leon_pci.c | 27 ---------------------------
 arch/sparc/kernel/pci.c      | 27 ---------------------------
 arch/sparc/kernel/pcic.c     | 27 ---------------------------
 3 files changed, 81 deletions(-)

diff --git a/arch/sparc/kernel/leon_pci.c b/arch/sparc/kernel/leon_pci.c
index 8de6646e9ce8..10934dfa987a 100644
--- a/arch/sparc/kernel/leon_pci.c
+++ b/arch/sparc/kernel/leon_pci.c
@@ -60,30 +60,3 @@ void leon_pci_init(struct platform_device *ofdev, struct leon_pci_info *info)
 	pci_assign_unassigned_resources();
 	pci_bus_add_devices(root_bus);
 }
-
-int pcibios_enable_device(struct pci_dev *dev, int mask)
-{
-	struct resource *res;
-	u16 cmd, oldcmd;
-	int i;
-
-	pci_read_config_word(dev, PCI_COMMAND, &cmd);
-	oldcmd = cmd;
-
-	pci_dev_for_each_resource(dev, res, i) {
-		/* Only set up the requested stuff */
-		if (!(mask & (1<<i)))
-			continue;
-
-		if (res->flags & IORESOURCE_IO)
-			cmd |= PCI_COMMAND_IO;
-		if (res->flags & IORESOURCE_MEM)
-			cmd |= PCI_COMMAND_MEMORY;
-	}
-
-	if (cmd != oldcmd) {
-		pci_info(dev, "enabling device (%04x -> %04x)\n", oldcmd, cmd);
-		pci_write_config_word(dev, PCI_COMMAND, cmd);
-	}
-	return 0;
-}
diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index ddac216a2aff..a9448088e762 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -722,33 +722,6 @@ struct pci_bus *pci_scan_one_pbm(struct pci_pbm_info *pbm,
 	return bus;
 }
 
-int pcibios_enable_device(struct pci_dev *dev, int mask)
-{
-	struct resource *res;
-	u16 cmd, oldcmd;
-	int i;
-
-	pci_read_config_word(dev, PCI_COMMAND, &cmd);
-	oldcmd = cmd;
-
-	pci_dev_for_each_resource(dev, res, i) {
-		/* Only set up the requested stuff */
-		if (!(mask & (1<<i)))
-			continue;
-
-		if (res->flags & IORESOURCE_IO)
-			cmd |= PCI_COMMAND_IO;
-		if (res->flags & IORESOURCE_MEM)
-			cmd |= PCI_COMMAND_MEMORY;
-	}
-
-	if (cmd != oldcmd) {
-		pci_info(dev, "enabling device (%04x -> %04x)\n", oldcmd, cmd);
-		pci_write_config_word(dev, PCI_COMMAND, cmd);
-	}
-	return 0;
-}
-
 /* Platform support for /proc/bus/pci/X/Y mmap()s. */
 int pci_iobar_pfn(struct pci_dev *pdev, int bar, struct vm_area_struct *vma)
 {
diff --git a/arch/sparc/kernel/pcic.c b/arch/sparc/kernel/pcic.c
index 25fe0a061732..3d54ad5656a4 100644
--- a/arch/sparc/kernel/pcic.c
+++ b/arch/sparc/kernel/pcic.c
@@ -641,33 +641,6 @@ void pcibios_fixup_bus(struct pci_bus *bus)
 	}
 }
 
-int pcibios_enable_device(struct pci_dev *dev, int mask)
-{
-	struct resource *res;
-	u16 cmd, oldcmd;
-	int i;
-
-	pci_read_config_word(dev, PCI_COMMAND, &cmd);
-	oldcmd = cmd;
-
-	pci_dev_for_each_resource(dev, res, i) {
-		/* Only set up the requested stuff */
-		if (!(mask & (1<<i)))
-			continue;
-
-		if (res->flags & IORESOURCE_IO)
-			cmd |= PCI_COMMAND_IO;
-		if (res->flags & IORESOURCE_MEM)
-			cmd |= PCI_COMMAND_MEMORY;
-	}
-
-	if (cmd != oldcmd) {
-		pci_info(dev, "enabling device (%04x -> %04x)\n", oldcmd, cmd);
-		pci_write_config_word(dev, PCI_COMMAND, cmd);
-	}
-	return 0;
-}
-
 /* Makes compiler happy */
 static volatile int pcic_timer_dummy;
 
-- 
2.39.5


