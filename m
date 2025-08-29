Return-Path: <linux-pci+bounces-35098-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B36B3BC0C
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 15:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2C561C23362
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 13:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2F82EBDF4;
	Fri, 29 Aug 2025 13:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kacLKW3j"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9166C2E7BDA;
	Fri, 29 Aug 2025 13:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756473093; cv=none; b=FYgqEzEZ1UPuiNTyE1SeyFwRqFy6VmlY9tmYQGd26eRrMqDcAB7cjW9AvdQ6CI72AQ1WD/mk6uW+nF8kaY/scLTt/JaWUSz0hqJ9R7nXnrdtke0qrZFxc6GcwsfrE7ScYSJfL6s8IKlDtYsF5axC12NYH0EIKMjWwQ072PBN5dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756473093; c=relaxed/simple;
	bh=3/KqAj6SPENBeMHK838Xzt1epcWPtBMI4CsY0Xu62D0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AGeiiozPumfWrbbdtFl8IhQ7XtOjj3AqBUSQU8ov1OC4kZAMhrntvmqeptNPonwVNLsoPDEfaEqTs5drRyuCg4QCnXMXnbcpfXCnnTyQQSgwcsng6r3MRLxznCqKSPqZJt2OhZZY3GqLCZ8wdrS2/0tvGGHN4s+lHy8xB0FL8e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kacLKW3j; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756473091; x=1788009091;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3/KqAj6SPENBeMHK838Xzt1epcWPtBMI4CsY0Xu62D0=;
  b=kacLKW3jfIUaWx3HtbOo9myspSHo3rUGtEFIpNyqX+zCqqLXdtAxL50V
   O0uZ1w/S8rMl+ihCYJsd5DsCx+b+xNpmkDKUatcj09JUl76shnywFoOPK
   jAYcwXVSSXZKc6ntcCidsdzvwazBiHnCl4mz5yzk0tTLqMtZJ+2zRbNUi
   0QgNNNNGHWGx+vPblyRQ/x9RjFBCgkk5LVD2NZ02GI+RMravmgTQbzXOZ
   vKXr5AUWqOmlVXSb93mPqrVNGqjFDYMpNqdnxhj4VPfmGONIoSxWx7s56
   uYTXkJBXWWVqOFIM6AVmXG7qhleFVpDdvEHso5mcfWAw+1hHub4+QgV4A
   g==;
X-CSE-ConnectionGUID: p3l2oRxnRnGLBeuHrj1DVQ==
X-CSE-MsgGUID: l2ICkCFyT6yv06QtidcoxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="58687483"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="58687483"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 06:11:31 -0700
X-CSE-ConnectionGUID: m1i8cZgXRqiu9WFN10Odcg==
X-CSE-MsgGUID: obssSdZoRrmCqw2eLD7bFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="174550835"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 06:11:29 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 01/24] m68k/PCI: Use pci_enable_resources() in pcibios_enable_device()
Date: Fri, 29 Aug 2025 16:10:50 +0300
Message-Id: <20250829131113.36754-2-ilpo.jarvinen@linux.intel.com>
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

m68k has a resource enable (check) loop in its pcibios_enable_device()
which for some reason differs from pci_enable_resources(). This could lead
to inconsistencies in behavior, especially now as pci_enable_resources()
and the bridge window resource flags behavior are going to be altered by
upcoming changes.

The check for !r->start && r->end is already covered by the more generic
checks done in pci_enable_resources().

The entire pcibios_enable_device() suspiciously looks copy-paste from some
other arch as also indicated by the preceding comment. However, it also
enables PCI_COMMAND_IO | PCI_COMMAND_MEMORY always for bridges. It is not
clear why that is being done as the commit e93a6bbeb5a5 ("m68k: common PCI
support definitions and code") introducing this code states "Nothing
specific to any PCI implementation in any m68k class CPU hardware yet".

Replace the resource enable loop with a call to pci_enable_resources() and
adjust the Command Register afterwards as it's unclear if that is necessary
or not so keep it for now.

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


