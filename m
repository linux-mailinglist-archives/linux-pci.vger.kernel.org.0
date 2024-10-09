Return-Path: <linux-pci+bounces-14084-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F969967BC
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 12:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0397A1F24138
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 10:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3227919149E;
	Wed,  9 Oct 2024 10:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iwfAWz9O"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F8A19049A;
	Wed,  9 Oct 2024 10:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728471151; cv=none; b=ll+3WTCHYWNMsfMJ+HOP5UCg1cP1qG3ElRguzV0aBmfFaYTfcp3x4dWuRrfpdNosI/QtqYov169wXSLQ2mjMpEliRq/XiFItvq5AXgy70tDN2nlMroBULxv5bdwUft84iJAEngTe7qlnEGyBOYk4vzGXHdPuzVsLjI0CUtou0FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728471151; c=relaxed/simple;
	bh=79g+gJx7OJcWdLNPVFGgUvMBjzoj7nD53HIZ/OcztQo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=PCgsO4UQi7Biu8UmTp451jHIkD9lHE174r2T+Lc/6Ker4wW5+KOd0zU7iO3SBf4eC/Wqql5doAsBGhHfCTIRcIFSqtwolYH3vZsk1mqn7JakyuRr1iUnIgiYlHrjtyAanU4DEXscX183C3hc/04BHEkxOHteJSvK2HK0dWml2+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iwfAWz9O; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728471150; x=1760007150;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=79g+gJx7OJcWdLNPVFGgUvMBjzoj7nD53HIZ/OcztQo=;
  b=iwfAWz9OZ50WGceqpl/BcwSobdlRFLIbht9L4Z0fUiYNyM4Ubc1YkiNZ
   YfRg2j5C/bcKWTtSLr1u8Gd/WL9A/kinQoaL4rnj+xOlhi+RUMnV2Wr4o
   C7Aq0yONTUdDhFmWOanEHE/VCT8OLZAilz4A8m9x0tQGg5kyVl6QBR2gI
   vvlLVi+ktMpVLteWz+fEYJBsYHMMeLgusDF3Mh/o4vkyfwshr0la42y8u
   nGI/7LLfDrwZ4UlOJ7bOJohanIaWJ8J55un0D6+io2wiz+hgQ7qNPYCtA
   f+jncA9KNOgWvKC6RlpeXaErL4CTPIZJs1EJBh49pMo1/d3DhrTC8TAQa
   w==;
X-CSE-ConnectionGUID: 69IcwbJyRN2H5xRUUu4NjA==
X-CSE-MsgGUID: +0Wgo1s0SHqAFnMl+e5q9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="38349764"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="38349764"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 03:52:28 -0700
X-CSE-ConnectionGUID: BdgtP9jKRVKr/D5tVmDGPg==
X-CSE-MsgGUID: jUtkbT7ZRZ+ILNWdrOblww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="80722037"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.41])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 03:52:25 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/1] PCI: Move no_pci_devices() to the only driver using it
Date: Wed,  9 Oct 2024 13:52:18 +0300
Message-Id: <20241009105218.7798-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Core PCI code provides no_pci_devices() that is only used in the
pc110pad driver during init to detect cases when PC110 definitely cannot
be present. Move this legacy detection trickery/hack into the pc110pad
driver.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/input/mouse/pc110pad.c | 19 +++++++++++++++++++
 drivers/pci/probe.c            | 17 -----------------
 include/linux/pci.h            |  3 ---
 3 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/input/mouse/pc110pad.c b/drivers/input/mouse/pc110pad.c
index efa58049f746..f4167a7e71c8 100644
--- a/drivers/input/mouse/pc110pad.c
+++ b/drivers/input/mouse/pc110pad.c
@@ -87,6 +87,25 @@ static int pc110pad_open(struct input_dev *dev)
  * that the PC110 is not a PCI system. So if we find any
  * PCI devices in the machine, we don't have a PC110.
  */
+#ifdef CONFIG_PCI
+static int __init no_pci_devices(void)
+{
+	struct device *dev;
+	int no_devices;
+
+	dev = bus_find_next_device(&pci_bus_type, NULL);
+	no_devices = (dev == NULL);
+	put_device(dev);
+	return no_devices;
+}
+#else
+static int __init no_pci_devices(void)
+{
+	return 1;
+}
+#endif
+
+
 static int __init pc110pad_init(void)
 {
 	int err;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 4f68414c3086..2704503fa8fb 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -65,23 +65,6 @@ static struct resource *get_pci_domain_busn_res(int domain_nr)
 	return &r->res;
 }
 
-/*
- * Some device drivers need know if PCI is initiated.
- * Basically, we think PCI is not initiated when there
- * is no device to be found on the pci_bus_type.
- */
-int no_pci_devices(void)
-{
-	struct device *dev;
-	int no_devices;
-
-	dev = bus_find_next_device(&pci_bus_type, NULL);
-	no_devices = (dev == NULL);
-	put_device(dev);
-	return no_devices;
-}
-EXPORT_SYMBOL(no_pci_devices);
-
 /*
  * PCI Bus Class
  */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 573b4c4c2be6..4757ce7ccd53 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1107,8 +1107,6 @@ extern const struct bus_type pci_bus_type;
 /* Do NOT directly access these two variables, unless you are arch-specific PCI
  * code, or PCI core code. */
 extern struct list_head pci_root_buses;	/* List of all known PCI buses */
-/* Some device drivers need know if PCI is initiated */
-int no_pci_devices(void);
 
 void pcibios_resource_survey_bus(struct pci_bus *bus);
 void pcibios_bus_add_device(struct pci_dev *pdev);
@@ -1969,7 +1967,6 @@ static inline struct pci_dev *pci_get_base_class(unsigned int class,
 static inline int pci_dev_present(const struct pci_device_id *ids)
 { return 0; }
 
-#define no_pci_devices()	(1)
 #define pci_dev_put(dev)	do { } while (0)
 
 static inline void pci_set_master(struct pci_dev *dev) { }
-- 
2.39.5


