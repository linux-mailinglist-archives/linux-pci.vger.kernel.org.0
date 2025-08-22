Return-Path: <linux-pci+bounces-34571-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4726B31D1E
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 17:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 242FD189F9FE
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 14:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCAB3126CD;
	Fri, 22 Aug 2025 14:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I0maB8j7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E6D3128B1;
	Fri, 22 Aug 2025 14:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755874597; cv=none; b=ojI7V7pryhLHOE62FtDMhapBEYNgzGUyCvACgCgK7WUJS3AbRH3HkZmvntoHDPyqr5uCQF0KR/v5a5rjzyi/K8vtDRH1uv5ikpD1lJqdZMNgXrov1ycYloBk8f0vo1R0rUddrCWUzkL1XrLl00hVovIps+uiyYb8yeZJ93Xwih8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755874597; c=relaxed/simple;
	bh=bSxDSi61ISCt6N4ERv3jPARPEFvmoSF1OZejWsVVizA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UrLeSAorqesuZQqVHR94odBO06cvT+7BcV/tSk3V1OAc7n8h9sdhDhrpFcowiMaDdFRxOtksRqgU+SKCe7a2VybQjgGA5BjuUUR6jMFHm9r6R5tmN/ldaaLrjwqJr8tEatJwLIcyx+ToxKjnZL7Wt379qhXfrg6y+AGGX7Ws5t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I0maB8j7; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755874596; x=1787410596;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bSxDSi61ISCt6N4ERv3jPARPEFvmoSF1OZejWsVVizA=;
  b=I0maB8j7RkFHtTLUh3OUedsyWICC4kWaBB759JYbY/HzYbr/jYjSC675
   YMUSGUpHKEPOl3e01WhSDBdnwHz+j4pfWzrysnGnUbVeXFS1q2v9e3/nZ
   zmmnafb/utzophjpWhrkaMZiUoOrTVDPXMkS9sWGtsOA9JJQjCd0x15AU
   z8jwFbenuZdj12sVLL2jbZlEtFaaHG0IfWJBHPziHV8vwpVLO85hKVnau
   Durm63DoRYMRPjRMVTd6wiSABCmarRIcukOLbSNgjnatmXEaUVQeI1I5c
   i0lo+3lmlmYT82BVRi+2vAemkVhNsJ8t9CfUmcLHkmXz8ubdZKuLiZJZO
   g==;
X-CSE-ConnectionGUID: 4TaXzFmcREKF5MioTy5jsg==
X-CSE-MsgGUID: oLmIHuFnQD6MoqC7/exafA==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="62015739"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="62015739"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 07:56:35 -0700
X-CSE-ConnectionGUID: x91kP381TK+YfIUNtqcyDg==
X-CSE-MsgGUID: q2j8ygTuTqiZ23lnI0XmWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="173994475"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.115])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 07:56:30 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Andreas Larsson <andreas@gaisler.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-pci@vger.kernel.org,
	sparclinux@vger.kernel.org,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Igor Mammedov <imammedo@redhat.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
	linuxppc-dev@lists.ozlabs.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 02/24] sparc/PCI: Remove pcibios_enable_device() as they do nothing extra
Date: Fri, 22 Aug 2025 17:55:43 +0300
Message-Id: <20250822145605.18172-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250822145605.18172-1-ilpo.jarvinen@linux.intel.com>
References: <20250822145605.18172-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Under arch/sparc/ there are multiple copies of pcibios_enable_device()
but none of those seem to do anything extra beyond what
pci_enable_resources() is supposed to do. These functions could lead to
inconsistencies in behavior, especially now as pci_enable_resources()
and the bridge window resource flags behavior are going to be altered
by upcoming changes.

Remove all pcibios_enable_device() from arch/sparc/ so that PCI core
can simply call into pci_enable_resources() instead using it's __weak
version of pcibios_enable_device().

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


