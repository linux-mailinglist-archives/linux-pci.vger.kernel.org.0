Return-Path: <linux-pci+bounces-35108-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E82B6B3BC26
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 15:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC32E1CC1B29
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 13:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7396731B13A;
	Fri, 29 Aug 2025 13:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nKgwUY+D"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13163203A7;
	Fri, 29 Aug 2025 13:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756473166; cv=none; b=bY/3xkVe4iT9f8PMYuf9vbXhM1Y6GIRypu0l2+zxiYJvDsze30JZ7BNGIlt4enzzd+ahUw73IN5mCFx6bcz1bdRkIY/oEP1l1M2F9h4fgK5r089p7O7choOxsHCfmWH8wxhbIeE5Rocqqlw0ngn5ahNEWJSKQ8mNAeM7yf1ub8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756473166; c=relaxed/simple;
	bh=Kjz8/+HZgjjp/qt3tTHK9X2z/irbLjsD7LjzpjCPghU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JqEB4NwcYlol5Q+rydd6DY4Wdz/f0iuAWEnDwT28AgOBSbQ6bXXxThA+/sg2JO5R47W14rql4T5Ndl/3QAR9c6BSD2taOCp3+T45fO0rnYKQeaKSjn9xs02wVbMPye4UXlahhJn9SCqMrNndlt5tPDBB69aaUoRB72SiAFYQ5l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nKgwUY+D; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756473165; x=1788009165;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Kjz8/+HZgjjp/qt3tTHK9X2z/irbLjsD7LjzpjCPghU=;
  b=nKgwUY+DP9Qrx1DDvWcbfGI0qHr2djXSgBeB4qGtQOOadj4v5jGXr0Eu
   POLpRU+sMwP/H6ZaRWg6ueiADZ4FRUQTjTJVW1cx/z8oA7F0ilaY5frCe
   mqQZg6Fyy6M6X9OYsF/0H+zHMuD4b93LrJFF2xVp8sbFkciKecTag6aCh
   hKPLTo1nGMMVYFI6IGWwnEGqz9wvjHQos32/QB16SSPBQCkeoJ5pZMqE4
   e3tm9qLaT93PULWu8fIAUJ6v9LKZkdR2PHUCfCBEGoohq9kBA48NOE2/N
   zr6nzg59W+haae6k0fN68iv0qag7QvjlwBBQ+gyeDNBJtON6ZN6qK6uYl
   w==;
X-CSE-ConnectionGUID: II88PwZSR8uPsQtvk6yX1g==
X-CSE-MsgGUID: 9lGyjND6TvqHc+/ZFMSrWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="62576096"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="62576096"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 06:12:45 -0700
X-CSE-ConnectionGUID: cHJkLA6NQWOmlbaFzEJArg==
X-CSE-MsgGUID: dRNr5SJhStqkF6smQ+2bWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="174733744"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 06:12:42 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 11/24] PCI: Add defines for bridge window indexing
Date: Fri, 29 Aug 2025 16:11:00 +0300
Message-Id: <20250829131113.36754-12-ilpo.jarvinen@linux.intel.com>
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

include/linux/pci.h provides PCI_BRIDGE_{IO,MEM,PREF_MEM}_WINDOW defines,
however, they're based on the resource array indexing in the pci_dev
struct. The struct pci_bus also has pointers to those same resources but
they start from zeroth index.

Add PCI_BUS_BRIDGE_{IO,MEM,PREF_MEM}_WINDOW defines to get rid of literal
indexing.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pci.h   |  4 ++++
 drivers/pci/probe.c | 10 +++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 34f65d69662e..1dc8a8066761 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -81,6 +81,10 @@ struct pcie_tlp_log;
 #define PCIE_MSG_CODE_DEASSERT_INTC	0x26
 #define PCIE_MSG_CODE_DEASSERT_INTD	0x27
 
+#define PCI_BUS_BRIDGE_IO_WINDOW	0
+#define PCI_BUS_BRIDGE_MEM_WINDOW	1
+#define PCI_BUS_BRIDGE_PREF_MEM_WINDOW	2
+
 extern const unsigned char pcie_link_speed[];
 extern bool pci_early_dump;
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index f31d27c7708a..eaeb66bec433 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -598,9 +598,13 @@ void pci_read_bridge_bases(struct pci_bus *child)
 	for (i = 0; i < PCI_BRIDGE_RESOURCE_NUM; i++)
 		child->resource[i] = &dev->resource[PCI_BRIDGE_RESOURCES+i];
 
-	pci_read_bridge_io(child->self, child->resource[0], false);
-	pci_read_bridge_mmio(child->self, child->resource[1], false);
-	pci_read_bridge_mmio_pref(child->self, child->resource[2], false);
+	pci_read_bridge_io(child->self,
+			   child->resource[PCI_BUS_BRIDGE_IO_WINDOW], false);
+	pci_read_bridge_mmio(child->self,
+			     child->resource[PCI_BUS_BRIDGE_MEM_WINDOW], false);
+	pci_read_bridge_mmio_pref(child->self,
+				  child->resource[PCI_BUS_BRIDGE_PREF_MEM_WINDOW],
+				  false);
 
 	if (!dev->transparent)
 		return;
-- 
2.39.5


