Return-Path: <linux-pci+bounces-2464-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62352838AB8
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 10:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7B38B24DC3
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 09:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6B55A117;
	Tue, 23 Jan 2024 09:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="chFwGSt7"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9875A0ED
	for <linux-pci@vger.kernel.org>; Tue, 23 Jan 2024 09:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706003095; cv=none; b=haEMUdZ379vK3MavblRWVMu6wQIeefplh95jdbn0U2fQN8FfsA391q0+X2REmUgx2Ofp+B2sRvUr5De7r8nCUdJ0PFmdkEAnjEtPhPkEmeYG6QuAASOG/nSnpD60aiiWkpXrQr/G7NWsged81ovqBXPKjalrAF35+QWbpVtMpMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706003095; c=relaxed/simple;
	bh=DpufObqHMp2GH2jiS2xo13V7ghDTJR3FuOoF4N0d8p4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C3yPl1muH+RVkRJfMsNs/f+XXhrenX8NNgdkbDEz9L9tytKJCQNDx8MQzWvSyme1QOIAG/oszw9YUW+fg6zenQBLD/tF1jPmwzIn3f0UF+lHLklxN7mPCsdupe/ldDHQUEAEBMeq260eJOgSvNNU9bu2BcgyfbilHsxTjZZRY4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=chFwGSt7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706003091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DpxKmM3l8Vl7kV3GYXjRni+YGoQ2Eibk4E8EGJ3z2IA=;
	b=chFwGSt7RI+CMDedXqrzeCfnOm32X/vIGARkStCy/npvmuiJh4ZvlSDh7qy1nrJFzwKip9
	3Kx27ecT8uRyF47LNdpgfBz4X6xPsZKcLPEmD9g9bID5qqkKi3aBMybRYyH+LbfVMXFsoP
	Yh7O02rkLi31eckkBbSxcCbL87XopXg=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-Sgw_kCeZNOiqKBTkK6HY9g-1; Tue, 23 Jan 2024 04:44:50 -0500
X-MC-Unique: Sgw_kCeZNOiqKBTkK6HY9g-1
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-46a9d50a8b4so216819137.1
        for <linux-pci@vger.kernel.org>; Tue, 23 Jan 2024 01:44:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706003090; x=1706607890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DpxKmM3l8Vl7kV3GYXjRni+YGoQ2Eibk4E8EGJ3z2IA=;
        b=wjd2VyPOd5OUkdrutMHqont5tizl+3nIxSd3cF/O2KGlAp26wzi2tA6y8yJJdgsYd+
         rYHTV+CloalDQBr/q1p3YwnR0GIJMIQxPumpx/6SXwpqJDPpTkRIXkJfgkgn2f3Q5fM9
         BWSxB+3JgTxcHzssSaDcih6rdmaplkxxswLoYDJ9Bs1ac7MwSGgEaa7DwZWQjozlzHQN
         swsINpJwAhbrzPsxGUgw8tKy2taw7+VYIAm6qnWw6buW138AETi3DrZemX8PrxLmlInJ
         DeJsySJN7VL7mRTZnHEQYPxciUDI9tUEnOflS8lRqBtXyzB8OnrTJ6Ej0pLVhW95cTwT
         FRtQ==
X-Gm-Message-State: AOJu0YzmE4c6WIe8Du2MMG5tlBuSAiqe5Ouh7oFaay8/3Ni233ZoT+mz
	Ak/0H/yx+zcYG2M0FCI8CZP+olevQw8veW5unN4Q/lx8YvaqjVZ5jZeZfzG/gfOfXLHc9pgiay2
	pFnKrw+pfakGeGkG15+nV7JP5PGCUo+cSReEQHb6Aac95pruqnzKNqI+ZHaQfsWweWg==
X-Received: by 2002:a05:6122:c94:b0:4b6:c04b:3a1e with SMTP id ba20-20020a0561220c9400b004b6c04b3a1emr5163532vkb.0.1706003089515;
        Tue, 23 Jan 2024 01:44:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHT8H18rgKDaN7+JY0OqB/sHz+MdkaXZBz3BqTmjmuLzasT1lm67GOGTxaekMz9Tgf/+wSe9g==
X-Received: by 2002:a05:6122:c94:b0:4b6:c04b:3a1e with SMTP id ba20-20020a0561220c9400b004b6c04b3a1emr5163513vkb.0.1706003089033;
        Tue, 23 Jan 2024 01:44:49 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id nc5-20020a0562142dc500b00685e2ffcaf5sm2958704qvb.38.2024.01.23.01.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 01:44:48 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Hans de Goede <hdegoede@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	dakr@redhat.com
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 02/10] PCI: deprecate iomap-table functions
Date: Tue, 23 Jan 2024 10:42:59 +0100
Message-ID: <20240123094317.15958-3-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123094317.15958-1-pstanner@redhat.com>
References: <20240123094317.15958-1-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The old plural devres functions tie the PCI devres API to the
iomap-table mechanism which unfortunately is not extensible.

As the purlal functions are almost never used with more than one bit set
in their bit-mask, deprecating them and encouraging users to use the new
singular functions instead is reasonable.

Furthermore, to make the implementation more consistent and extensible,
the plural functions should use the singular functions.

Add new wrapper to request / release all BARs.
Make the plural functions call into the singular functions.
Mark the plural functions as deprecated.
Remove as much of the iomap-table-mechanism as possible.
Add comments describing the path towards a cleaned-up API.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/devres.c | 374 +++++++++++++++++++++++++++++++++----------
 drivers/pci/pci.c    |  20 +++
 drivers/pci/pci.h    |   5 +
 include/linux/pci.h  |   2 +
 4 files changed, 318 insertions(+), 83 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index 91252856aa66..1279aac9b63e 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -4,15 +4,43 @@
 #include "pci.h"
 
 /*
- * PCI iomap devres
+ * On the state of PCI's devres implementation:
+ *
+ * The older devres API for PCI has two significant problems:
+ *
+ * 1. It is very strongly tied to the statically allocated mapping table in
+ *    struct pcim_iomap_devres below. This is mostly solved in the sense of the
+ *    pcim_ functions in this file providing things like ranged mapping by
+ *    bypassing this table, wheras the functions that were present in the old
+ *    API still enter the mapping addresses into the table for users of the old
+ *    API.
+ * 2. The region-request-functions in pci.c do become managed IF the device has
+ *    been enabled with pcim_enable_device() instead of pci_enable_device().
+ *    This resulted in the API becoming inconsistent: Some functions have an
+ *    obviously managed counter-part (e.g., pci_iomap() <-> pcim_iomap()),
+ *    whereas some don't and are never managed, while others don't and are
+ *    _sometimes_ managed (e.g. pci_request_region()).
+ *    Consequently, in the new API, region requests performed by the pcim_
+ *    functions are automatically cleaned up through the devres callback
+ *    pcim_addr_resource_release(), while requests performed by
+ *    pcim_enable_device() + pci_*region*() are automatically cleaned up
+ *    through the for-loop in pcim_release().
+ *
+ * TODO 1:
+ * Remove the legacy table entirely once all calls to pcim_iomap_table() in
+ * the kernel have been removed.
+ *
+ * TODO 2:
+ * Port everyone calling pcim_enable_device() + pci_*region*() to using the
+ * pcim_ functions. Then, remove all devres functionality from pci_*region*()
+ * functions and remove the associated cleanups described above in point #2.
  */
-#define PCIM_IOMAP_MAX	PCI_STD_NUM_BARS
 
 /*
  * Legacy struct storing addresses to whole mapped BARs.
  */
 struct pcim_iomap_devres {
-	void __iomem *table[PCIM_IOMAP_MAX];
+	void __iomem *table[PCI_STD_NUM_BARS];
 };
 
 enum pcim_addr_devres_type {
@@ -373,6 +401,16 @@ static void pcim_release(struct device *gendev, void *res)
 	struct pci_devres *this = res;
 	int i;
 
+	/*
+	 * This is legacy code.
+	 * All regions requested by a pcim_ function do get released through
+	 * pcim_addr_resource_release(). Thanks to the hybrid nature of the pci_
+	 * region-request functions, this for-loop has to release the regions
+	 * if they have been requested by such a function.
+	 *
+	 * TODO: Remove this once all users of pcim_enable_device() PLUS
+	 * pci-region-request-functions have been ported to pcim_ functions.
+	 */
 	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++)
 		if (this->region_mask & (1 << i))
 			pci_release_region(dev, i);
@@ -461,19 +499,21 @@ EXPORT_SYMBOL(pcim_pin_device);
 
 static void pcim_iomap_release(struct device *gendev, void *res)
 {
-	struct pci_dev *dev = to_pci_dev(gendev);
-	struct pcim_iomap_devres *this = res;
-	int i;
-
-	for (i = 0; i < PCIM_IOMAP_MAX; i++)
-		if (this->table[i])
-			pci_iounmap(dev, this->table[i]);
+	/*
+	 * Do nothing. This is legacy code.
+	 *
+	 * Cleanup of the mappings is now done directly through the callbacks
+	 * registered when creating them.
+	 */
 }
 
 /**
- * pcim_iomap_table - access iomap allocation table
+ * pcim_iomap_table - access iomap allocation table (DEPRECATED)
  * @pdev: PCI device to access iomap table for
  *
+ * Returns:
+ * Const pointer to array of __iomem pointers on success NULL on failure.
+ *
  * Access iomap allocation table for @dev.  If iomap table doesn't
  * exist and @pdev is managed, it will be allocated.  All iomaps
  * recorded in the iomap table are automatically unmapped on driver
@@ -482,6 +522,11 @@ static void pcim_iomap_release(struct device *gendev, void *res)
  * This function might sleep when the table is first allocated but can
  * be safely called without context and guaranteed to succeed once
  * allocated.
+ *
+ * This function is DEPRECATED. Do not use it in new code.
+ * Instead, obtain a mapping's address directly from one of the pcim_* mapping
+ * functions. For example:
+ * void __iomem *mappy = pcim_iomap(pdev, barnr, length);
  */
 void __iomem * const *pcim_iomap_table(struct pci_dev *pdev)
 {
@@ -500,27 +545,114 @@ void __iomem * const *pcim_iomap_table(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL(pcim_iomap_table);
 
+/*
+ * Fill the legacy mapping-table, so that drivers using the old API
+ * can still get a BAR's mapping address through pcim_iomap_table().
+ */
+static int pcim_add_mapping_to_legacy_table(struct pci_dev *pdev,
+		 void __iomem *mapping, short bar)
+{
+	void __iomem **legacy_iomap_table;
+
+	if (bar >= PCI_STD_NUM_BARS)
+		return -EINVAL;
+
+	legacy_iomap_table = (void __iomem **)pcim_iomap_table(pdev);
+	if (!legacy_iomap_table)
+		return -ENOMEM;
+
+	/* The legacy mechanism doesn't allow for duplicate mappings. */
+	WARN_ON(legacy_iomap_table[bar]);
+
+	legacy_iomap_table[bar] = mapping;
+
+	return 0;
+}
+
+/*
+ * Removes a mapping. The table only contains whole-bar-mappings, so this will
+ * never interfere with ranged mappings.
+ */
+static void pcim_remove_mapping_from_legacy_table(struct pci_dev *pdev,
+		void __iomem *addr)
+{
+	short bar;
+	void __iomem **legacy_iomap_table;
+
+	legacy_iomap_table = (void __iomem **)pcim_iomap_table(pdev);
+	if (!legacy_iomap_table)
+		return;
+
+	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
+		if (legacy_iomap_table[bar] == addr) {
+			legacy_iomap_table[bar] = NULL;
+			return;
+		}
+	}
+}
+
+/*
+ * The same as pcim_remove_mapping_from_legacy_table(), but identifies the
+ * mapping by its BAR index.
+ */
+static void pcim_remove_bar_from_legacy_table(struct pci_dev *pdev, short bar)
+{
+	void __iomem **legacy_iomap_table;
+
+	if (bar >= PCI_STD_NUM_BARS)
+		return;
+
+	legacy_iomap_table = (void __iomem **)pcim_iomap_table(pdev);
+	if (!legacy_iomap_table)
+		return;
+
+	legacy_iomap_table[bar] = NULL;
+}
+
 /**
  * pcim_iomap - Managed pcim_iomap()
  * @pdev: PCI device to iomap for
  * @bar: BAR to iomap
  * @maxlen: Maximum length of iomap
  *
- * Managed pci_iomap().  Map is automatically unmapped on driver
- * detach.
+ * Returns: __iomem pointer on success, NULL on failure.
+ *
+ * Managed pci_iomap(). Map is automatically unmapped on driver detach. If
+ * desired, unmap manually only with pcim_iounmap().
+ *
+ * This SHOULD only be used once per BAR.
+ *
+ * NOTE:
+ * Contrary to the other pcim_* functions, this function does not return an
+ * IOMEM_ERR_PTR() on failure, but a simple NULL. This is done for backwards
+ * compatibility.
  */
 void __iomem *pcim_iomap(struct pci_dev *pdev, int bar, unsigned long maxlen)
 {
-	void __iomem **tbl;
-
-	BUG_ON(bar >= PCIM_IOMAP_MAX);
+	void __iomem *mapping;
+	struct pcim_addr_devres *res;
 
-	tbl = (void __iomem **)pcim_iomap_table(pdev);
-	if (!tbl || tbl[bar])	/* duplicate mappings not allowed */
+	res = pcim_addr_devres_alloc(pdev);
+	if (!res)
 		return NULL;
+	res->type = PCIM_ADDR_DEVRES_TYPE_MAPPING;
+
+	mapping = pci_iomap(pdev, bar, maxlen);
+	if (!mapping)
+		goto err_iomap;
+	res->baseaddr = mapping;
+
+	if (pcim_add_mapping_to_legacy_table(pdev, mapping, bar) != 0)
+		goto err_table;
 
-	tbl[bar] = pci_iomap(pdev, bar, maxlen);
-	return tbl[bar];
+	devres_add(&pdev->dev, res);
+	return mapping;
+
+err_table:
+	pci_iounmap(pdev, mapping);
+err_iomap:
+	pcim_addr_devres_free(res);
+	return NULL;
 }
 EXPORT_SYMBOL(pcim_iomap);
 
@@ -529,23 +661,24 @@ EXPORT_SYMBOL(pcim_iomap);
  * @pdev: PCI device to iounmap for
  * @addr: Address to unmap
  *
- * Managed pci_iounmap().  @addr must have been mapped using pcim_iomap().
+ * Managed pci_iounmap(). @addr must have been mapped using pcim_iomap() or
+ * pcim_iomap_range().
  */
 void pcim_iounmap(struct pci_dev *pdev, void __iomem *addr)
 {
-	void __iomem **tbl;
-	int i;
+	struct pcim_addr_devres res_searched;
 
-	pci_iounmap(pdev, addr);
+	pcim_addr_devres_clear(&res_searched);
+	res_searched.type = PCIM_ADDR_DEVRES_TYPE_MAPPING;
+	res_searched.baseaddr = addr;
 
-	tbl = (void __iomem **)pcim_iomap_table(pdev);
-	BUG_ON(!tbl);
+	if (devres_release(&pdev->dev, pcim_addr_resource_release,
+			pcim_addr_resources_match, &res_searched) != 0) {
+		/* Doesn't exist. User passed nonsense. */
+		return;
+	}
 
-	for (i = 0; i < PCIM_IOMAP_MAX; i++)
-		if (tbl[i] == addr) {
-			tbl[i] = NULL;
-			return;
-		}
+	pcim_remove_mapping_from_legacy_table(pdev, addr);
 }
 EXPORT_SYMBOL(pcim_iounmap);
 
@@ -615,106 +748,181 @@ void pcim_iounmap_region(struct pci_dev *pdev, int bar)
 }
 EXPORT_SYMBOL(pcim_iounmap_region);
 
+static inline bool mask_contains_bar(int mask, int bar)
+{
+	return mask & BIT(bar);
+}
+
 /**
- * pcim_iomap_regions - Request and iomap PCI BARs
+ * pcim_iomap_regions - Request and iomap PCI BARs (DEPRECATED)
  * @pdev: PCI device to map IO resources for
  * @mask: Mask of BARs to request and iomap
  * @name: Name associated with the requests
  *
+ * Returns: 0 on success, negative error code on failure.
+ *
  * Request and iomap regions specified by @mask.
+ *
+ * This function is DEPRECATED. Don't use it in new code.
+ * Use pcim_iomap_region() instead.
  */
 int pcim_iomap_regions(struct pci_dev *pdev, int mask, const char *name)
 {
-	void __iomem * const *iomap;
-	int i, rc;
+	int ret;
+	short bar;
+	void __iomem *mapping;
 
-	iomap = pcim_iomap_table(pdev);
-	if (!iomap)
-		return -ENOMEM;
+	for (bar = 0; bar < DEVICE_COUNT_RESOURCE; bar++) {
+		if (!mask_contains_bar(mask, bar))
+			continue;
 
-	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
-		unsigned long len;
+		mapping = pcim_iomap_region(pdev, bar, name);
+		if (IS_ERR(mapping)) {
+			ret = PTR_ERR(mapping);
+			goto err;
+		}
+		ret = pcim_add_mapping_to_legacy_table(pdev, mapping, bar);
+		if (ret != 0)
+			goto err;
+	}
 
-		if (!(mask & (1 << i)))
-			continue;
+	return 0;
 
-		rc = -EINVAL;
-		len = pci_resource_len(pdev, i);
-		if (!len)
-			goto err_inval;
+err:
+	while (--bar >= 0) {
+		pcim_iounmap_region(pdev, bar);
+		pcim_remove_bar_from_legacy_table(pdev, bar);
+	}
 
-		rc = pci_request_region(pdev, i, name);
-		if (rc)
-			goto err_inval;
+	return ret;
+}
+EXPORT_SYMBOL(pcim_iomap_regions);
 
-		rc = -ENOMEM;
-		if (!pcim_iomap(pdev, i, 0))
-			goto err_region;
+/**
+ * pcim_release_all_regions - Release all regions of a PCI-device
+ * @pdev: the PCI device
+ *
+ * Will release all regions previously requested through pcim_request_region()
+ * or pcim_request_all_regions().
+ *
+ * Can be called from any context, i.e., not necessarily as a counterpart to
+ * pcim_request_all_regions().
+ */
+void pcim_release_all_regions(struct pci_dev *pdev)
+{
+	short bar;
+
+	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++)
+		pcim_release_region(pdev, bar);
+}
+EXPORT_SYMBOL(pcim_release_all_regions);
+
+/**
+ * pcim_request_all_regions - Request all regions
+ * @pdev: PCI device to map IO resources for
+ * @name: name associated with the request
+ *
+ * Returns: 0 on success, negative error code on failure.
+ *
+ * Requested regions will automatically be released at driver detach. If desired,
+ * release individual regions with pcim_release_region() or all of them at once
+ * with pcim_release_all_regions().
+ */
+int pcim_request_all_regions(struct pci_dev *pdev, const char *name)
+{
+	int ret;
+	short bar;
+
+	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
+		ret = pcim_request_region(pdev, bar, name);
+		if (ret != 0)
+			goto err;
 	}
 
 	return 0;
 
- err_region:
-	pci_release_region(pdev, i);
- err_inval:
-	while (--i >= 0) {
-		if (!(mask & (1 << i)))
-			continue;
-		pcim_iounmap(pdev, iomap[i]);
-		pci_release_region(pdev, i);
-	}
+err:
+	pcim_release_all_regions(pdev);
 
-	return rc;
+	return ret;
 }
-EXPORT_SYMBOL(pcim_iomap_regions);
+EXPORT_SYMBOL(pcim_request_all_regions);
 
 /**
- * pcim_iomap_regions_request_all - Request all BARs and iomap specified ones
+ * pcim_iomap_regions_request_all - Request all BARs and iomap specified ones (DEPRECATED)
  * @pdev: PCI device to map IO resources for
  * @mask: Mask of BARs to iomap
  * @name: Name associated with the requests
  *
+ * Returns: 0 on success, negative error code on failure.
+ *
  * Request all PCI BARs and iomap regions specified by @mask.
+ *
+ * To release these resources manually, call pcim_release_region() for the
+ * regions and pcim_iounmap() for the mappings.
+ *
+ * This function is DEPRECATED. Don't use it in new code.
+ * Use pcim_request_all_regions() + pcim_iomap*() instead.
  */
 int pcim_iomap_regions_request_all(struct pci_dev *pdev, int mask,
 				   const char *name)
 {
-	int request_mask = ((1 << 6) - 1) & ~mask;
-	int rc;
+	short bar;
+	int ret;
+	void __iomem **legacy_iomap_table;
+
+	ret = pcim_request_all_regions(pdev, name);
+	if (ret != 0)
+		return ret;
 
-	rc = pci_request_selected_regions(pdev, request_mask, name);
-	if (rc)
-		return rc;
+	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
+		if (!mask_contains_bar(mask, bar))
+			continue;
+		if (!pcim_iomap(pdev, bar, 0))
+			goto err;
+	}
 
-	rc = pcim_iomap_regions(pdev, mask, name);
-	if (rc)
-		pci_release_selected_regions(pdev, request_mask);
-	return rc;
+	return 0;
+
+err:
+	/*
+	 * Here it gets tricky: pcim_iomap() above has most likely
+	 * failed because it got an OOM when trying to create the
+	 * legacy-table.
+	 * We check here if that has happened. If not, pcim_iomap()
+	 * must have failed because of EINVAL.
+	 */
+	legacy_iomap_table = (void __iomem **)pcim_iomap_table(pdev);
+	ret = legacy_iomap_table ? -EINVAL : -ENOMEM;
+
+	while (--bar >= 0)
+		pcim_iounmap(pdev, legacy_iomap_table[bar]);
+
+	pcim_release_all_regions(pdev);
+
+	return ret;
 }
 EXPORT_SYMBOL(pcim_iomap_regions_request_all);
 
 /**
- * pcim_iounmap_regions - Unmap and release PCI BARs
+ * pcim_iounmap_regions - Unmap and release PCI BARs (DEPRECATED)
  * @pdev: PCI device to map IO resources for
  * @mask: Mask of BARs to unmap and release
  *
  * Unmap and release regions specified by @mask.
+ *
+ * This function is DEPRECATED. Don't use it in new code.
  */
 void pcim_iounmap_regions(struct pci_dev *pdev, int mask)
 {
-	void __iomem * const *iomap;
-	int i;
-
-	iomap = pcim_iomap_table(pdev);
-	if (!iomap)
-		return;
+	short bar;
 
-	for (i = 0; i < PCIM_IOMAP_MAX; i++) {
-		if (!(mask & (1 << i)))
+	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
+		if (!mask_contains_bar(mask, bar))
 			continue;
 
-		pcim_iounmap(pdev, iomap[i]);
-		pci_release_region(pdev, i);
+		pcim_iounmap_region(pdev, bar);
+		pcim_remove_bar_from_legacy_table(pdev, bar);
 	}
 }
 EXPORT_SYMBOL(pcim_iounmap_regions);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index bf5f9c3a1908..2899df77a285 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3884,6 +3884,16 @@ void pci_release_region(struct pci_dev *pdev, int bar)
 		release_mem_region(pci_resource_start(pdev, bar),
 				pci_resource_len(pdev, bar));
 
+	/*
+	 * This devres utility makes this function sometimes managed
+	 * (when pcim_enable_device() has been called before).
+	 * This is bad because it conflicts with the pcim_ functions being
+	 * exclusively responsible for managed pci. Its "sometimes yes, sometimes
+	 * no" nature can cause bugs.
+	 *
+	 * TODO: Remove this once all users that use pcim_enable_device() PLUS
+	 * a region request function have been ported to using pcim_ functions.
+	 */
 	dr = find_pci_dr(pdev);
 	if (dr)
 		dr->region_mask &= ~(1 << bar);
@@ -3928,6 +3938,16 @@ static int __pci_request_region(struct pci_dev *pdev, int bar,
 			goto err_out;
 	}
 
+	/*
+	 * This devres utility makes this function sometimes managed
+	 * (when pcim_enable_device() has been called before).
+	 * This is bad because it conflicts with the pcim_ functions being
+	 * exclusively responsible for managed pci. Its "sometimes yes, sometimes
+	 * no" nature can cause bugs.
+	 *
+	 * TODO: Remove this once all users that use pcim_enable_device() PLUS
+	 * a region request function have been ported to using pcim_ functions.
+	 */
 	dr = find_pci_dr(pdev);
 	if (dr)
 		dr->region_mask |= 1 << bar;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index de6d61d1e07f..4d4bcc2d850f 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -814,6 +814,11 @@ struct pci_devres {
 	unsigned int orig_intx:1;
 	unsigned int restore_intx:1;
 	unsigned int mwi:1;
+
+	/*
+	 * TODO: remove the region_mask once everyone calling
+	 * pcim_enable_device() + pci_*region*() is ported to pcim_ functions.
+	 */
 	u32 region_mask;
 };
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 1b45a4888703..3dcd8a5e10b5 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2322,6 +2322,8 @@ int pcim_iomap_regions_request_all(struct pci_dev *pdev, int mask,
 void pcim_iounmap_regions(struct pci_dev *pdev, int mask);
 int pcim_request_region(struct pci_dev *pdev, int bar, const char *res_name);
 void pcim_release_region(struct pci_dev *pdev, int bar);
+void pcim_release_all_regions(struct pci_dev *pdev);
+int pcim_request_all_regions(struct pci_dev *pdev, const char *name);
 void __iomem *pcim_iomap_range(struct pci_dev *pdev, int bar,
 				unsigned long offset, unsigned long len);
 void __iomem *pcim_iomap_region_range(struct pci_dev *pdev, int bar,
-- 
2.43.0


