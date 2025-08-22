Return-Path: <linux-pci+bounces-34570-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10121B31D39
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 17:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5C153A32D4
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 14:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2D83093BD;
	Fri, 22 Aug 2025 14:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U6jabSQ/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB15F3126B6;
	Fri, 22 Aug 2025 14:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755874588; cv=none; b=ufwjt/Xe1XMhr9jdF3l8vX49nhlDn8ojHKgTmbN9B98rYUhqCT05HsVVs5Gor1EKIdnmR4aS8DNR1OHGouYDe1q1QtATZZbU/XbYpu2MDr0d+XQ4DIVk0HyKKM7ULzditAwUv81DgOnI3xN+IGVpVVEA7TU0e6zjnsjxqDITuXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755874588; c=relaxed/simple;
	bh=x5WvhX4O8xfwMKYkjxN13ooXO03C+az2T3Yal0pKgnU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AEt7cnqStQY3ULmOAWQjoeldvT4gKoXbXdbfYvWcT7iugZVCxyhXc5BdCNQQ1TMsdiuyuj2IuZPTyBH+RAqoWm8SbhdIXSd4pnbM1VwFaLSVzzXwJRLQB7qQAdCsr2cRQt6KIvmmyGpnlthpbLUxiB+/cwRIJQKzeOa6qYUmmXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U6jabSQ/; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755874587; x=1787410587;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x5WvhX4O8xfwMKYkjxN13ooXO03C+az2T3Yal0pKgnU=;
  b=U6jabSQ/xIydUyZnlKHC5iKUIqDl1FRvpV7bkE8nW/B2ta2Zlolmzw7F
   kS+pv9V67Vu5fOZzHPbcjyZgVLnbC7XDlMtCbqPiVAw+LvM/ulsFsTk7A
   ukundmK1XZ0LAecegGcJyw0V5BJqbPIJAxatQfwBkYXwtcIYfFzRVcrR2
   KzxDagZDWVQxjI4jeQ4Gs//NfYHHroS/1swrS9FGM1SU8kQ669ml4Gzax
   0RDM/hO608xFPcwKaEURiEjVT8cNprOANWnhtfDCREsOse/h5qoZa8K0F
   QzK/J/khWaZWu63ba7oeZdaphdDtKehIHi5abOZUtwfacEtuhIMjwoQ3s
   g==;
X-CSE-ConnectionGUID: cgFgg7F9QZmnQA/gumBr2w==
X-CSE-MsgGUID: 2axb+LHZSqqg9Das9lvB4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="62015713"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="62015713"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 07:56:26 -0700
X-CSE-ConnectionGUID: 0i+eI+8LQqmInl7HncQ8ZQ==
X-CSE-MsgGUID: YUBpK2JcQ7ytQJraYVvkOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="173994430"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.115])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 07:56:21 -0700
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
Subject: [PATCH 01/24] m68k/PCI: Use pci_enable_resources() in pcibios_enable_device()
Date: Fri, 22 Aug 2025 17:55:42 +0300
Message-Id: <20250822145605.18172-2-ilpo.jarvinen@linux.intel.com>
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

m68k has a resource enable (check) loop in its pcibios_enable_device()
which for some reason differs from pci_enable_resources(). This could
lead to inconsistencies in behavior, especially now as
pci_enable_resources() and the bridge window resource flags behavior
are going to be altered by upcoming changes.

The check for !r->start && r->end is already covered by the more
generic checks done in pci_enable_resources().

The entire pcibios_enable_device() suspiciously looks copy-paste from
some other arch as also indicated by the preceding comment. However,
it also enables PCI_COMMAND_IO | PCI_COMMAND_MEMORY always for bridges,
it is not clear why that is being done as the commit e93a6bbeb5a5
("m68k: common PCI support definitions and code") introducing this
code states: "Nothing specific to any PCI implementation in any m68k
class CPU hardware yet".

Replace the resource enable loop with a call to pci_enable_resources()
and adjust the Command Register afterwards as it's unclear if that is
necessary or not so keep it for now.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 arch/m68k/kernel/pcibios.c | 39 +++++++++++---------------------------
 1 file changed, 11 insertions(+), 28 deletions(-)

diff --git a/arch/m68k/kernel/pcibios.c b/arch/m68k/kernel/pcibios.c
index 9504eb19d73a..e6ab3f9ff5d8 100644
--- a/arch/m68k/kernel/pcibios.c
+++ b/arch/m68k/kernel/pcibios.c
@@ -44,41 +44,24 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
  */
 int pcibios_enable_device(struct pci_dev *dev, int mask)
 {
-	struct resource *r;
 	u16 cmd, newcmd;
-	int idx;
+	int ret;
 
-	pci_read_config_word(dev, PCI_COMMAND, &cmd);
-	newcmd = cmd;
-
-	for (idx = 0; idx < 6; idx++) {
-		/* Only set up the requested stuff */
-		if (!(mask & (1 << idx)))
-			continue;
-
-		r = dev->resource + idx;
-		if (!r->start && r->end) {
-			pr_err("PCI: Device %s not available because of resource collisions\n",
-				pci_name(dev));
-			return -EINVAL;
-		}
-		if (r->flags & IORESOURCE_IO)
-			newcmd |= PCI_COMMAND_IO;
-		if (r->flags & IORESOURCE_MEM)
-			newcmd |= PCI_COMMAND_MEMORY;
-	}
+	ret = pci_enable_resources(dev, mask);
+	if (ret < 0)
+		return ret;
 
 	/*
 	 * Bridges (eg, cardbus bridges) need to be fully enabled
 	 */
-	if ((dev->class >> 16) == PCI_BASE_CLASS_BRIDGE)
+	if ((dev->class >> 16) == PCI_BASE_CLASS_BRIDGE) {
+		pci_read_config_word(dev, PCI_COMMAND, &cmd);
 		newcmd |= PCI_COMMAND_IO | PCI_COMMAND_MEMORY;
-
-
-	if (newcmd != cmd) {
-		pr_info("PCI: enabling device %s (0x%04x -> 0x%04x)\n",
-			pci_name(dev), cmd, newcmd);
-		pci_write_config_word(dev, PCI_COMMAND, newcmd);
+		if (newcmd != cmd) {
+			pr_info("PCI: enabling bridge %s (0x%04x -> 0x%04x)\n",
+				pci_name(dev), cmd, newcmd);
+			pci_write_config_word(dev, PCI_COMMAND, newcmd);
+		}
 	}
 	return 0;
 }
-- 
2.39.5


