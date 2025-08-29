Return-Path: <linux-pci+bounces-35100-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45323B3BC11
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 15:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70E441CC17A2
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 13:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82E92F83B7;
	Fri, 29 Aug 2025 13:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WJXjF/sf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CF72EBDF4;
	Fri, 29 Aug 2025 13:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756473108; cv=none; b=NE8JRPRQWsH62Lqtwz3KctSxobbt6ht/YoV4b4Y0bgmQJ6pr+X4swL8I2TYFUmRHVrjQe2GZglstRoMETMqMxl/CXT1906QydNq6k8Uhgdf09+C13E5eYIIBEjJ4NWd73fqJ5EUYHxKR2oBYqUyHGTaVUpiMJW7KJ4dsFKxMgXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756473108; c=relaxed/simple;
	bh=SzDQkTA7NTBmRlfYnPAavJTI3pdxjD9H9NvznhBu//0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t7aqJkw/cvsGHapls4CR5GI8AskgDCjHeoO0tQRXVFKljh6IfbHKjvmTPuojF1R/HoHj8n0s8uTwTSAHfj3GxUSa5ND3JAmhs5r3OL+hH/uPokPaEHKvCeHg3Fe/iJtAyel4s5PEgVRABEoeP9HbwZqprQyQAcIfT2Xj0/E1FYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WJXjF/sf; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756473107; x=1788009107;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SzDQkTA7NTBmRlfYnPAavJTI3pdxjD9H9NvznhBu//0=;
  b=WJXjF/sf5WeanawoXfSB3W3qeHEaSEnCSEgaPPL9Jqb/yMLTRdV7FG9Y
   6yTOWT1LITmQSW7OIVCVh0YxOY07syoRLjI8dzVG2bG+XbNTyid8u5zS+
   6Y8lKnr7/jHZ5xvaGklE+ZiHxkKXL4nYKmC40S1N/zp0U+Xbzl5JEbV/m
   Pia2OFB+apkyrJo941DPomNoY9XWkNFFTQNpqE4D8rIy6/VH69ADZ0KGs
   Vl+naTuTlekbJ2RGKvAHduH7tKAkNW4lTiGmBCKEq/cA1DGhn6GJf5hf5
   iR346AgB5ocmP9o5VWZV0lGwnBcr4vzwHmuoYw2jH1F71/SCfnUXx/JYA
   A==;
X-CSE-ConnectionGUID: cQluqfI0QyqBgorSSt4cnA==
X-CSE-MsgGUID: xNCGT82IS7eUCCgwP2zNJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="58687493"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="58687493"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 06:11:46 -0700
X-CSE-ConnectionGUID: g8Lt4dy7QYOk/04BYPW2fw==
X-CSE-MsgGUID: pCvGApl+QqW81c5iGZ24Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="174550855"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 06:11:43 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH v2 03/24] MIPS: PCI: Use pci_enable_resources()
Date: Fri, 29 Aug 2025 16:10:52 +0300
Message-Id: <20250829131113.36754-4-ilpo.jarvinen@linux.intel.com>
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

pci-legacy.c under MIPS has a copy of pci_enable_resources() named as
pcibios_enable_resources(). Having own copy of same functionality could
lead to inconsistencies in behavior, especially now as
pci_enable_resources() and the bridge window resource flags behavior are
going to be altered by upcoming changes.

The check for !r->start && r->end is already covered by the more generic
checks done in pci_enable_resources().

Call pci_enable_resources() from MIPS's pcibios_enable_device() and remove
pcibios_enable_resources().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
 arch/mips/pci/pci-legacy.c | 38 ++------------------------------------
 1 file changed, 2 insertions(+), 36 deletions(-)

diff --git a/arch/mips/pci/pci-legacy.c b/arch/mips/pci/pci-legacy.c
index 66898fd182dc..d04b7c1294b6 100644
--- a/arch/mips/pci/pci-legacy.c
+++ b/arch/mips/pci/pci-legacy.c
@@ -249,45 +249,11 @@ static int __init pcibios_init(void)
 
 subsys_initcall(pcibios_init);
 
-static int pcibios_enable_resources(struct pci_dev *dev, int mask)
-{
-	u16 cmd, old_cmd;
-	int idx;
-	struct resource *r;
-
-	pci_read_config_word(dev, PCI_COMMAND, &cmd);
-	old_cmd = cmd;
-	pci_dev_for_each_resource(dev, r, idx) {
-		/* Only set up the requested stuff */
-		if (!(mask & (1<<idx)))
-			continue;
-
-		if (!(r->flags & (IORESOURCE_IO | IORESOURCE_MEM)))
-			continue;
-		if ((idx == PCI_ROM_RESOURCE) &&
-				(!(r->flags & IORESOURCE_ROM_ENABLE)))
-			continue;
-		if (!r->start && r->end) {
-			pci_err(dev,
-				"can't enable device: resource collisions\n");
-			return -EINVAL;
-		}
-		if (r->flags & IORESOURCE_IO)
-			cmd |= PCI_COMMAND_IO;
-		if (r->flags & IORESOURCE_MEM)
-			cmd |= PCI_COMMAND_MEMORY;
-	}
-	if (cmd != old_cmd) {
-		pci_info(dev, "enabling device (%04x -> %04x)\n", old_cmd, cmd);
-		pci_write_config_word(dev, PCI_COMMAND, cmd);
-	}
-	return 0;
-}
-
 int pcibios_enable_device(struct pci_dev *dev, int mask)
 {
-	int err = pcibios_enable_resources(dev, mask);
+	int err;
 
+	err = pci_enable_resources(dev, mask);
 	if (err < 0)
 		return err;
 
-- 
2.39.5


