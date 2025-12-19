Return-Path: <linux-pci+bounces-43433-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C15FCD151A
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 19:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29EDB300AB33
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 18:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766F7346E42;
	Fri, 19 Dec 2025 17:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SsdS3MLe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9420D346AF2;
	Fri, 19 Dec 2025 17:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766166208; cv=none; b=jWLfu5E4MI+xrK6LW42DqcOASwfJtybap/ScGm/p/c+VMdyjP5m0junzGC3EsyVOEr4p5v/J5ljFZvGRraYN5bm2wN1XDKCwN92AL9iXyoFe7tuhVZjXcXj6D3ly/wFek+kbRHqFnRVW1EKOyMElsS/KUVxSUM9zk7sEtcPvbPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766166208; c=relaxed/simple;
	bh=w09h8LS9ug2G+pOpj4FoyPd7I26PgR32M0TkaAjbUPY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tgy6o3c36qOlCgwA0L9Zx/li8z4wCt76I98DozSwhmz4xiDdaEGaIP6uGbXkeqL2EsVCQJ+E4gY/rD45sOq8eodKS4x63RMHuTQWzCD/QAFzHpp8yN97TDGzaUUofHMYssbJEiAGpDzzaOf1MZLAD1aOw/UQO1E9oz9mRBRJ99c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SsdS3MLe; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766166206; x=1797702206;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w09h8LS9ug2G+pOpj4FoyPd7I26PgR32M0TkaAjbUPY=;
  b=SsdS3MLenDy9lWh7vTfktuLnai1tjrDLRPuTwAiAyX+Y2TqckO+v2Z33
   2K2uVlowIbB4waIvoV1Tp6O7J7islJHqGkiItO1rFtfSom1k6zOcZAkqO
   w0CBB6xQULcZ7A83tgH678TJx+X41I4USDMqLGzgmuThOusacFXGXViP8
   FyLkn0rcH5sia2WrOkXrJUp23/LoT7woVWzPyJx1rByJzTKP9TSBJIZwX
   UKSkxsC7IQThjuSuMRlp7tfaBG88UUxboeKxKRDYHnAcwbnXG+m5HNe4A
   e6BoN4kW1ROuze+v/sSWRbPiFB8jj0HWzKvjMNhlJ/IuWO5lWcwO+J7DR
   g==;
X-CSE-ConnectionGUID: C9TtMd4pR1KSxq6A+Rp+qw==
X-CSE-MsgGUID: PoK5RPD4SHeh+r+qJXMLOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11647"; a="78764458"
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="78764458"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 09:43:26 -0800
X-CSE-ConnectionGUID: 5KLJm32+TbCMIFqhgco5rg==
X-CSE-MsgGUID: Bkr6KHDsSDKEB/MplFvIFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="198066163"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.61])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 09:43:12 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 18/23] PCI: Handle CardBus specific params in setup-cardbus.c
Date: Fri, 19 Dec 2025 19:40:31 +0200
Message-Id: <20251219174036.16738-19-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251219174036.16738-1-ilpo.jarvinen@linux.intel.com>
References: <20251219174036.16738-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Move cardbus window sizing parameters to setup-cardbus.c that contains
all the other CardBus code.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pci.c           | 14 +++-----------
 drivers/pci/pci.h           |  4 ++--
 drivers/pci/setup-cardbus.c | 21 +++++++++++++++++++++
 3 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 13dbb405dc31..85c22f30e20a 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -99,12 +99,6 @@ bool pci_reset_supported(struct pci_dev *dev)
 int pci_domains_supported = 1;
 #endif
 
-#define DEFAULT_CARDBUS_IO_SIZE		(256)
-#define DEFAULT_CARDBUS_MEM_SIZE	(64*1024*1024)
-/* pci=cbmemsize=nnM,cbiosize=nn can override this */
-unsigned long pci_cardbus_io_size = DEFAULT_CARDBUS_IO_SIZE;
-unsigned long pci_cardbus_mem_size = DEFAULT_CARDBUS_MEM_SIZE;
-
 #define DEFAULT_HOTPLUG_IO_SIZE		(256)
 #define DEFAULT_HOTPLUG_MMIO_SIZE	(2*1024*1024)
 #define DEFAULT_HOTPLUG_MMIO_PREF_SIZE	(2*1024*1024)
@@ -6630,7 +6624,9 @@ static int __init pci_setup(char *str)
 		if (k)
 			*k++ = 0;
 		if (*str && (str = pcibios_setup(str)) && *str) {
-			if (!strcmp(str, "nomsi")) {
+			if (!pci_setup_cardbus(str)) {
+				/* Function handled the parameters */
+			} else if (!strcmp(str, "nomsi")) {
 				pci_no_msi();
 			} else if (!strncmp(str, "noats", 5)) {
 				pr_info("PCIe: ATS is disabled\n");
@@ -6649,10 +6645,6 @@ static int __init pci_setup(char *str)
 				pcie_ari_disabled = true;
 			} else if (!strncmp(str, "notph", 5)) {
 				pci_no_tph();
-			} else if (!strncmp(str, "cbiosize=", 9)) {
-				pci_cardbus_io_size = memparse(str + 9, &str);
-			} else if (!strncmp(str, "cbmemsize=", 10)) {
-				pci_cardbus_mem_size = memparse(str + 10, &str);
 			} else if (!strncmp(str, "resource_alignment=", 19)) {
 				resource_alignment_param = str + 19;
 			} else if (!strncmp(str, "ecrc=", 5)) {
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 2340e9df05c2..dbea5db07959 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -376,13 +376,12 @@ extern unsigned long pci_hotplug_io_size;
 extern unsigned long pci_hotplug_mmio_size;
 extern unsigned long pci_hotplug_mmio_pref_size;
 extern unsigned long pci_hotplug_bus_size;
-extern unsigned long pci_cardbus_io_size;
-extern unsigned long pci_cardbus_mem_size;
 
 #ifdef CONFIG_CARDBUS
 unsigned long pci_cardbus_resource_alignment(struct resource *res);
 int pci_bus_size_cardbus_bridge(struct pci_bus *bus,
 				struct list_head *realloc_head);
+int pci_setup_cardbus(char *str);
 
 #else
 static inline unsigned long pci_cardbus_resource_alignment(struct resource *res)
@@ -394,6 +393,7 @@ static inline int pci_bus_size_cardbus_bridge(struct pci_bus *bus,
 {
 	return -EOPNOTSUPP;
 }
+static inline int pci_setup_cardbus(char *str) { return -ENOENT; }
 #endif /* CONFIG_CARDBUS */
 
 /**
diff --git a/drivers/pci/setup-cardbus.c b/drivers/pci/setup-cardbus.c
index b017a2039fe1..93a2b43c637b 100644
--- a/drivers/pci/setup-cardbus.c
+++ b/drivers/pci/setup-cardbus.c
@@ -3,12 +3,20 @@
  * Cardbus bridge setup routines.
  */
 
+#include <linux/errno.h>
 #include <linux/ioport.h>
 #include <linux/pci.h>
+#include <linux/sizes.h>
 #include <linux/types.h>
 
 #include "pci.h"
 
+#define DEFAULT_CARDBUS_IO_SIZE		SZ_256
+#define DEFAULT_CARDBUS_MEM_SIZE	SZ_64M
+/* pci=cbmemsize=nnM,cbiosize=nn can override this */
+static unsigned long pci_cardbus_io_size = DEFAULT_CARDBUS_IO_SIZE;
+static unsigned long pci_cardbus_mem_size = DEFAULT_CARDBUS_MEM_SIZE;
+
 unsigned long pci_cardbus_resource_alignment(struct resource *res)
 {
 	if (res->flags & IORESOURCE_IO)
@@ -165,3 +173,16 @@ void pci_setup_cardbus_bridge(struct pci_bus *bus)
 	}
 }
 EXPORT_SYMBOL(pci_setup_cardbus_bridge);
+
+int pci_setup_cardbus(char *str)
+{
+	if (!strncmp(str, "cbiosize=", 9)) {
+		pci_cardbus_io_size = memparse(str + 9, &str);
+		return 0;
+	} else if (!strncmp(str, "cbmemsize=", 10)) {
+		pci_cardbus_mem_size = memparse(str + 10, &str);
+		return 0;
+	}
+
+	return -ENOENT;
+}
-- 
2.39.5


