Return-Path: <linux-pci+bounces-37528-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 861F9BB64EA
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 11:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BACA1AE058A
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 09:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5003B283CAA;
	Fri,  3 Oct 2025 09:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="qOKnudwI"
X-Original-To: linux-pci@vger.kernel.org
Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35FD1F63CD;
	Fri,  3 Oct 2025 09:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.26.1.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759482339; cv=none; b=tIO3MRCpgJeeZn2LmN4j0cyOUr2CvbpOmFjVgojqvbJpum/GmlhXIiS5u0spFyAmzP6IOGoARRt+96U6Tt69HVSOCE8Q76HmnfSKJIxsuCNAZgEStDHACKinx67c2KglOSlTZFNV3hjnY0DOiLuAz3Zd1dAOyGWy38OgJthn4m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759482339; c=relaxed/simple;
	bh=slLWGxQfls1x1S/FVs4FN7heJzZTdg6FH91JCzX11E8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ee91qfiJ7HxeN1QYWHY7tfWwR2B6/6NnHKWOgzA4dGiZuxBhq7K4uaD2EXUlZJZxIsk9hX7PHDUOiz0BBi3RbLaipXvfLB00+1g+R5P1Uc0aN7PH6Xn+pOxVRSJZ3+nk4JUN533oiTOsneDoh2zNmU63W83pAucMbBl8+MyKYac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=qOKnudwI; arc=none smtp.client-ip=52.26.1.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1759482337; x=1791018337;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Tn0GQRVzT5fKEu1tgXMFMDyjYjbCRfljUqvSP9velpg=;
  b=qOKnudwIPrdDIUOAh5v4VWsBOS4Hj/o4HIZYD2ZwvvRlHVteHuaimq7Y
   ymaJ6Ryra6kk5FPwOwcEHSpwL2orjKA3i8364sEa1au7k3JdPl+VYXX9k
   6INyBrT2OsYafJ1kbMO+sS4+outWCuLplZHV/6xNXILPcw1yuPm8OLD9j
   jRvDCAkpSCxT1WFs4rCdM1PeKqWF50PLtYp1GHeg8tkFc/PU2ouKkJMJR
   Rm9fUjPPmj3rPrVSFPq4jxFcY+M6N28YrTlHYqLR6FrQhY9q+mNa6cfq7
   UCmRVBLB3HNQwvvUdWX2odTyKPoeGaNrjw/WX/C+Wrn8NCjHholGIVWbS
   A==;
X-CSE-ConnectionGUID: Dtu+UvqTT5SZjS6EPSHS9g==
X-CSE-MsgGUID: zmyYvmr+Q7KbR3Erf9NvWw==
X-IronPort-AV: E=Sophos;i="6.18,281,1751241600"; 
   d="scan'208";a="4212893"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2025 09:05:37 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:44698]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.156:2525] with esmtp (Farcaster)
 id 9215df3b-2cb7-42da-a9b3-e947d8efb987; Fri, 3 Oct 2025 09:05:37 +0000 (UTC)
X-Farcaster-Flow-ID: 9215df3b-2cb7-42da-a9b3-e947d8efb987
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Fri, 3 Oct 2025 09:05:36 +0000
Received: from dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com
 (10.253.109.105) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Fri, 3 Oct 2025
 09:05:33 +0000
From: Evangelos Petrongonas <epetron@amazon.de>
To: Bjorn Helgaas <bhelgaas@google.com>, Alex Williamson
	<alex.williamson@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>, "Len
 Brown" <lenb@kernel.org>
CC: Evangelos Petrongonas <epetron@amazon.de>, Pasha Tatashin
	<pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, "Vipin
 Sharma" <vipinsh@google.com>, Chris Li <chrisl@kernel.org>, Jason Miu
	<jasonmiu@google.com>, Pratyush Yadav <pratyush@kernel.org>, "Stanislav
 Spassov" <stanspas@amazon.de>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nh-open-source@amazon.com>
Subject: [RFC PATCH 10/13] pci: pcsc: Use contiguous pages for the cache data
Date: Fri, 3 Oct 2025 09:00:46 +0000
Message-ID: <914285f708739992f14c16fb3be336c6e8afed52.1759312886.git.epetron@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1759312886.git.epetron@amazon.de>
References: <cover.1759312886.git.epetron@amazon.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D039UWB001.ant.amazon.com (10.13.138.119) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch refactors PCSC to use a single contiguous memory block for
all per-device data. This improves memory allocation efficiency.

This is a preparatory step for KHO persistence support, as it is easier
to manipulate physically continuous pages.

Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
---
 drivers/pci/pcsc.c   | 28 ++++++++++++++++++++++++----
 include/linux/pcsc.h | 32 ++++++++++++++++++++++++++++++--
 2 files changed, 54 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pcsc.c b/drivers/pci/pcsc.c
index 304239b7ff8a..18d508f76649 100644
--- a/drivers/pci/pcsc.c
+++ b/drivers/pci/pcsc.c
@@ -725,6 +725,7 @@ int pcsc_add_device(struct pci_dev *dev)
 {
 	struct pcsc_node *node;
 	struct pci_bus *bus;
+	size_t data_size;
 
 	if (WARN_ON(!dev))
 		return -EINVAL;
@@ -741,12 +742,27 @@ int pcsc_add_device(struct pci_dev *dev)
 	 * nodes for these devices, as it simplifies the code flow
 	 */
 	if (dev->hdr_type == PCI_HEADER_TYPE_NORMAL) {
-		dev->pcsc->cfg_space = kzalloc(PCSC_CFG_SPC_SIZE, GFP_KERNEL);
-		if (!dev->pcsc->cfg_space)
+		/* Allocate contiguous, page aligned data block. This will be
+		 * needed for persisting the data with KHO.
+		 */
+		data_size = sizeof(struct pcsc_data);
+
+		dev->pcsc->data =
+			(struct pcsc_data *)__get_free_pages(
+				GFP_KERNEL | __GFP_ZERO, get_order(data_size));
+		if (!dev->pcsc->data)
+
 			goto err_free_node;
 
+		dev->pcsc->cachable_bitmask = dev->pcsc->data->cachable_bitmask;
+		dev->pcsc->cached_bitmask = dev->pcsc->data->cached_bitmask;
+		dev->pcsc->cfg_space = dev->pcsc->data->cfg_space;
+
 		infer_cacheability(dev);
 	} else {
+		dev->pcsc->data = NULL;
+		dev->pcsc->cachable_bitmask = NULL;
+		dev->pcsc->cached_bitmask = NULL;
 		dev->pcsc->cfg_space = NULL;
 	}
 
@@ -771,8 +787,12 @@ int pcsc_remove_device(struct pci_dev *dev)
 
 	atomic_dec(&num_nodes);
 
-	if (dev->pcsc && dev->pcsc->cfg_space) {
-		kfree(dev->pcsc->cfg_space);
+	if (dev->pcsc && dev->pcsc->data) {
+		size_t data_size = sizeof(struct pcsc_data);
+		size_t total_size = PAGE_ALIGN(data_size);
+
+		free_pages((unsigned long)dev->pcsc->data,
+			get_order(total_size));
 		kfree(dev->pcsc);
 	}
 	dev->pcsc = NULL;
diff --git a/include/linux/pcsc.h b/include/linux/pcsc.h
index 85471273c0a9..88894f641257 100644
--- a/include/linux/pcsc.h
+++ b/include/linux/pcsc.h
@@ -18,12 +18,40 @@
 #define PCSC_CFG_SPC_SIZE 256
 #endif
 
-struct pcsc_node {
-	u8 *cfg_space;
+/*
+ * struct pcsc__data - Continuous data block for PCSC
+ *
+ * This structure contains all the PCSC data in a single continuous
+ * memory block.
+ *
+ * @cfg_space: Configuration space cache
+ * @cachable_bitmask: Bitmap of cacheable configuration space offsets
+ * @cached_bitmask: Bitmap of cached configuration space offsets
+ */
+struct pcsc_data {
+	u8 cfg_space[PCSC_CFG_SPC_SIZE];
 	DECLARE_BITMAP(cachable_bitmask, PCSC_CFG_SPC_SIZE);
 	DECLARE_BITMAP(cached_bitmask, PCSC_CFG_SPC_SIZE);
 };
 
+/*
+ * struct pcsc_node - PCSC node structure
+ *
+ * This structure represents a PCSC node for a PCI device.
+ * It contains pointers into the data block for convenient access.
+ *
+ * @data: Pointer to the continuous data block
+ * @cachable_bitmask: Pointer to cachable_bitmask in data
+ * @cached_bitmask: Pointer to cached_bitmask in data
+ * @cfg_space: Pointer to cfg_space in data
+ */
+struct pcsc_node {
+	struct pcsc_data *data; /* Pointer to continuous data block */
+	unsigned long *cachable_bitmask; /* Convenience pointer into data */
+	unsigned long *cached_bitmask; /* Convenience pointer into data */
+	u8 *cfg_space; /* Convenience pointer into data */
+};
+
 /**
  * pcsc_hw_config_read - Direct hardware PCI config space read
  * @bus: PCI bus
-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


