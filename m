Return-Path: <linux-pci+bounces-34572-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 070F5B31CED
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 16:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E36107B3B32
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 14:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42BC31282C;
	Fri, 22 Aug 2025 14:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QLSl+Rxb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9C4296BBA;
	Fri, 22 Aug 2025 14:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755874606; cv=none; b=lBBBw3eCxYH2ramkyp50RqherEV6H4BD3QDykNcs+0Q7RfqHjR3u49rzxTu+umgy/IuRwAaqC7TWtau14TtHy/0/ehnlUZ48UMSUebsR2N2+8cwJNvVKQCOLgwFU6WEarSUtXp4C/HNvddI++Tk7/AKy1+Vl3FVqXenz4q5e0l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755874606; c=relaxed/simple;
	bh=jBXSW/HvE/oTFKPyIiL0xTmEeLPgXFT+lohCoGdRapA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S50rr7pmcqdn6LBWeLq1Fx4hf+08J49YoGt8RaVtIUE49Dz5XvA6WNa5JZsOJv3IdFf7VKElZB6qT1v+mdCqw0BifhndP+M2MD83dItXkAQrbkFPYcDmlhMUJgNHuocDuiRHINkgjPch7GzgeRflmQK9y/H/pJTMXm9UibFylNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QLSl+Rxb; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755874605; x=1787410605;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jBXSW/HvE/oTFKPyIiL0xTmEeLPgXFT+lohCoGdRapA=;
  b=QLSl+RxbnrFjAbYJPYO6BN5GS7HWHQtGTgm7y4cGWGwUl0t9ef9txcL1
   O7iu8qzKZX5g47lPqc19GcNM+LsCfdGRmHnvtJZTYKA3J6wu4Fu4z8kCs
   oPPhJkD0NmZ0Kc7zzR4sbMY35GRpq89/grwafHQaRotBYHEuZIiPo+/2M
   lhF1aMsGg0jTA4GC0BlJJveBeWxDnsq0WBd9kBZw5aEBs4lnYXr2GNEMF
   011M/g5k+SkWxHQhSTpQyl8ft7ZjxGb2kInSwoEc6ewCE91VDgauDFkyk
   T7DVuW1JLbYVG7t+hFzodKCgsU3uIZsQEGCWZwmnV0W3sBGh3jjXHiAPo
   Q==;
X-CSE-ConnectionGUID: oCnHBOs6QBWq+NesGVlJkw==
X-CSE-MsgGUID: cjFlEEcUQgmSYmgCAa4Yrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="62015777"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="62015777"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 07:56:45 -0700
X-CSE-ConnectionGUID: ixYcXxcpSP2pUy6rUGsbsQ==
X-CSE-MsgGUID: FOhRjr0IQkSfd3SUorEZlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="173994552"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.115])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 07:56:39 -0700
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
Subject: [PATCH 03/24] MIPS: PCI: Use pci_enable_resources()
Date: Fri, 22 Aug 2025 17:55:44 +0300
Message-Id: <20250822145605.18172-4-ilpo.jarvinen@linux.intel.com>
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

pci-legacy.c under MIPS has a copy of pci_enable_resources() named as
pcibios_enable_resources(). Having own copy of same functionality could
lead to inconsistencies in behavior, especially now as
pci_enable_resources() and the bridge window resource flags behavior
are going to be altered by upcoming changes.

The check for !r->start && r->end is already covered by the more
generic checks done in pci_enable_resources().

Call pci_enable_resources() from MIPS's pcibios_enable_device() and
remove pcibios_enable_resources().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
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


