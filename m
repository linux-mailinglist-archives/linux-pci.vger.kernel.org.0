Return-Path: <linux-pci+bounces-5600-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95062896816
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 10:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B984E1C26291
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 08:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2C21353F9;
	Wed,  3 Apr 2024 08:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W4MG/SOy"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28098134430
	for <linux-pci@vger.kernel.org>; Wed,  3 Apr 2024 08:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131657; cv=none; b=ElMwmlSVCBpctDUdIDgBr4oGrjlRA+BKQlt16pv+9yqmU0JoYEXul9a059mekcrSC/u5qnmKjNaKfpRVgFbDZ20UX7PHyBeNJXyc8MjM91x8Gio9VTM16H1JOWwVtNc8ZZDEWgRmzXoAsLgcDDCQD2Oi3/w93Q/u0yUuo83B+zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131657; c=relaxed/simple;
	bh=0wJQMmMkjS5IOjz9EiIyEcxDO6Pp1pMNiUh/O813Vnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WKmiZkypS5dQI0JeveuF4da5BYvush3lBG4mXZWPFqP05gieFkfXYKpuVcei1ym0pky8NPMdfEQQGrGRBvsmglDbqcR3WM7Zcr833RiA1ZjmvFfY4RQRVBuZsw64eb61XFCe0OfLYxdvhZw9kj/xz1tUZKgBgn1CPBJ+ns1sGnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W4MG/SOy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712131654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mv4ykgBp7tIq5JFp/WPF/48WKjiwIBWsXj1zC6254y0=;
	b=W4MG/SOyjXI94cJJE8i93Y6ktMPxvaYjLCjkZKkNymCeZqUB1XcIjsgQfAMYe9U/XyMoNv
	bOgLSWX2S1apwTDTOhNO23PxrVH10nr9sIbikN80611OVy4/Kw/Nig3wMwNmaRYL6cfNpd
	N4jZrdmoYdRnzwAgrh2aAdmD+w2GFBs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-XC0IwF2fOvy9agt8QTSLEQ-1; Wed, 03 Apr 2024 04:07:32 -0400
X-MC-Unique: XC0IwF2fOvy9agt8QTSLEQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-343740ca794so324769f8f.0
        for <linux-pci@vger.kernel.org>; Wed, 03 Apr 2024 01:07:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712131651; x=1712736451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mv4ykgBp7tIq5JFp/WPF/48WKjiwIBWsXj1zC6254y0=;
        b=deg6XD8+PZJ/YbtrTpjtlS3eLl5XJ7p4FDNjVsrsunT12xw+y9pkwvFWojCMjEOWOr
         G8p+6lDQqmy91PnLTSMzmSc2ezRbJQ7yybPOE1dxNLpleIjbn80a3ldGYykfnxqMFrVR
         xdVO2Qr5ebxTBVMqC1jD3UP3LAhOP9ZYccD/OEImyogMv/fawM6tC/zQk32Kh8Cqft/W
         AvxoXefqlpSY+a67I5ysgc6u6189h7Dl1lzX8tWuFuS0rABxhVcsL8qeHx0yA+lmlqGT
         jKHeeaMvtcxACLP70RLQySBw451mW/cShljSKsiVgm0T2ynMqd8BAjY/N/5m8nHj/Qeb
         EpcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTWOuAFUtCWfzWykk6P9JSUhUAMxdF8vbw19PclSjTnskjg6EQIE5yQOJ82qLXEHr2Tg3z457k/J+L3mZCI9RwuqbNeq5DSHTC
X-Gm-Message-State: AOJu0Yz0GuiwKS+ALVVCxnVLYx/xTXrE00VvirZoU5RaxVEfTBXKVeYF
	KskztPpF2mAPPfrPS2tbOLeKjyKChVWS83e/BBe/5fgWJm9+ek9t4pPePeRo+kcYp3BTY8+hQq1
	W2eARjTNRpqepqAZNs/wyBatZEyqzkqM52C1DZKkeyo9R6gocN5UyPYKGGA==
X-Received: by 2002:a05:600c:1c8f:b0:414:6467:2b1d with SMTP id k15-20020a05600c1c8f00b0041464672b1dmr11644923wms.0.1712131651309;
        Wed, 03 Apr 2024 01:07:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHy0bb2txLFwSU3H8V6tdWjhamYkws9PjapnUSSagxGhJjCMl7W+EijOgzD0DIJvQD9fCFkWg==
X-Received: by 2002:a05:600c:1c8f:b0:414:6467:2b1d with SMTP id k15-20020a05600c1c8f00b0041464672b1dmr11644894wms.0.1712131650884;
        Wed, 03 Apr 2024 01:07:30 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id fa14-20020a05600c518e00b004159df274d5sm5504535wmb.6.2024.04.03.01.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 01:07:30 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	dakr@redhat.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH v5 04/10] PCI: Make devres region requests consistent
Date: Wed,  3 Apr 2024 10:07:05 +0200
Message-ID: <20240403080712.13986-7-pstanner@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403080712.13986-2-pstanner@redhat.com>
References: <20240403080712.13986-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that pure managed region request functions are available, the
implementation of the hybrid-functions which are only sometimes managed
can be made more consistent and readable by wrapping those
always-managed functions.

Implement a new pcim_ function for exclusively requested regions.
Have the pci_request / release functions call their pcim_ counterparts.
Remove the now surplus region_mask from struct pci_devres.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/devres.c | 49 ++++++++++++++++++++++---------------------
 drivers/pci/pci.c    | 50 +++++++++++++++-----------------------------
 drivers/pci/pci.h    |  6 ------
 include/linux/pci.h  |  1 +
 4 files changed, 43 insertions(+), 63 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index bc31e3a8cc04..03662760d629 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -22,18 +22,15 @@
  *    _sometimes_ managed (e.g. pci_request_region()).
  *    Consequently, in the new API, region requests performed by the pcim_
  *    functions are automatically cleaned up through the devres callback
- *    pcim_addr_resource_release(), while requests performed by
- *    pcim_enable_device() + pci_*region*() are automatically cleaned up
- *    through the for-loop in pcim_release().
+ *    pcim_addr_resource_release().
+ *    Users utilizing pcim_enable_device() + pci_*region*() are redirected in
+ *    pci.c to the managed functions here in this file. This isn't exactly
+ *    perfect, but the only alternative way would be to port ALL drivers using
+ *    said combination to pcim_ functions.
  *
- * TODO 1:
+ * TODO:
  * Remove the legacy table entirely once all calls to pcim_iomap_table() in
  * the kernel have been removed.
- *
- * TODO 2:
- * Port everyone calling pcim_enable_device() + pci_*region*() to using the
- * pcim_ functions. Then, remove all devres functionality from pci_*region*()
- * functions and remove the associated cleanups described above in point #2.
  */
 
 /*
@@ -399,21 +396,6 @@ static void pcim_release(struct device *gendev, void *res)
 {
 	struct pci_dev *dev = to_pci_dev(gendev);
 	struct pci_devres *this = res;
-	int i;
-
-	/*
-	 * This is legacy code.
-	 * All regions requested by a pcim_ function do get released through
-	 * pcim_addr_resource_release(). Thanks to the hybrid nature of the pci_
-	 * region-request functions, this for-loop has to release the regions
-	 * if they have been requested by such a function.
-	 *
-	 * TODO: Remove this once all users of pcim_enable_device() PLUS
-	 * pci-region-request-functions have been ported to pcim_ functions.
-	 */
-	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++)
-		if (this->region_mask & (1 << i))
-			pci_release_region(dev, i);
 
 	if (this->mwi)
 		pci_clear_mwi(dev);
@@ -966,6 +948,25 @@ int pcim_request_region(struct pci_dev *pdev, int bar, const char *name)
 }
 EXPORT_SYMBOL(pcim_request_region);
 
+/**
+ * pcim_request_region_exclusive - Request a PCI BAR exclusively
+ * @pdev: PCI device to requestion region for
+ * @bar: Index of BAR to request
+ * @name: Name associated with the request
+ *
+ * Returns: 0 on success, a negative error code on failure.
+ *
+ * Request region specified by @bar exclusively.
+ *
+ * The region will automatically be released on driver detach. If desired,
+ * release manually only with pcim_release_region().
+ */
+int pcim_request_region_exclusive(struct pci_dev *pdev, int bar, const char *name)
+{
+	return _pcim_request_region(pdev, bar, name, IORESOURCE_EXCLUSIVE);
+}
+EXPORT_SYMBOL(pcim_request_region_exclusive);
+
 /**
  * pcim_release_region - Release a PCI BAR
  * @pdev: PCI device to operate on
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 9d9d09534efe..c0c1ee17a06b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3869,7 +3869,15 @@ EXPORT_SYMBOL(pci_enable_atomic_ops_to_root);
  */
 void pci_release_region(struct pci_dev *pdev, int bar)
 {
-	struct pci_devres *dr;
+	/*
+	 * This is done for backwards compatibility, because the old pci-devres
+	 * API had a mode in which the function became managed if it had been
+	 * enabled with pcim_enable_device() instead of pci_enable_device().
+	 */
+	if (pci_is_managed(pdev)) {
+		pcim_release_region(pdev, bar);
+		return;
+	}
 
 	if (pci_resource_len(pdev, bar) == 0)
 		return;
@@ -3879,20 +3887,6 @@ void pci_release_region(struct pci_dev *pdev, int bar)
 	else if (pci_resource_flags(pdev, bar) & IORESOURCE_MEM)
 		release_mem_region(pci_resource_start(pdev, bar),
 				pci_resource_len(pdev, bar));
-
-	/*
-	 * This devres utility makes this function sometimes managed
-	 * (when pcim_enable_device() has been called before).
-	 * This is bad because it conflicts with the pcim_ functions being
-	 * exclusively responsible for managed pci. Its "sometimes yes, sometimes
-	 * no" nature can cause bugs.
-	 *
-	 * TODO: Remove this once all users that use pcim_enable_device() PLUS
-	 * a region request function have been ported to using pcim_ functions.
-	 */
-	dr = find_pci_dr(pdev);
-	if (dr)
-		dr->region_mask &= ~(1 << bar);
 }
 EXPORT_SYMBOL(pci_release_region);
 
@@ -3920,14 +3914,18 @@ EXPORT_SYMBOL(pci_release_region);
  * NOTE:
  * This is a "hybrid" function: Its normally unmanaged, but becomes managed
  * when pcim_enable_device() has been called in advance.
- * This hybrid feature is DEPRECATED! If you need to implement a new pci
- * function that does automatic cleanup, write a new pcim_* function that uses
- * devres directly.
+ * This hybrid feature is DEPRECATED! If you want managed cleanup, use the
+ * pcim_* functions instead.
  */
 static int __pci_request_region(struct pci_dev *pdev, int bar,
 				const char *res_name, int exclusive)
 {
-	struct pci_devres *dr;
+	if (pci_is_managed(pdev)) {
+		if (exclusive == IORESOURCE_EXCLUSIVE)
+			return pcim_request_region_exclusive(pdev, bar, res_name);
+
+		return pcim_request_region(pdev, bar, res_name);
+	}
 
 	if (pci_resource_len(pdev, bar) == 0)
 		return 0;
@@ -3943,20 +3941,6 @@ static int __pci_request_region(struct pci_dev *pdev, int bar,
 			goto err_out;
 	}
 
-	/*
-	 * This devres utility makes this function sometimes managed
-	 * (when pcim_enable_device() has been called before).
-	 * This is bad because it conflicts with the pcim_ functions being
-	 * exclusively responsible for managed pci. Its "sometimes yes, sometimes
-	 * no" nature can cause bugs.
-	 *
-	 * TODO: Remove this once all users that use pcim_enable_device() PLUS
-	 * a region request function have been ported to using pcim_ functions.
-	 */
-	dr = find_pci_dr(pdev);
-	if (dr)
-		dr->region_mask |= 1 << bar;
-
 	return 0;
 
 err_out:
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 171884aba8e1..040ed2825554 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -828,12 +828,6 @@ struct pci_devres {
 	unsigned int orig_intx:1;
 	unsigned int restore_intx:1;
 	unsigned int mwi:1;
-
-	/*
-	 * TODO: remove the region_mask once everyone calling
-	 * pcim_enable_device() + pci_*region*() is ported to pcim_ functions.
-	 */
-	u32 region_mask;
 };
 
 struct pci_devres *find_pci_dr(struct pci_dev *pdev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 5782ad034178..0f203338f820 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2330,6 +2330,7 @@ int pcim_iomap_regions_request_all(struct pci_dev *pdev, int mask,
 				   const char *name);
 void pcim_iounmap_regions(struct pci_dev *pdev, int mask);
 int pcim_request_region(struct pci_dev *pdev, int bar, const char *res_name);
+int pcim_request_region_exclusive(struct pci_dev *pdev, int bar, const char *name);
 void pcim_release_region(struct pci_dev *pdev, int bar);
 void pcim_release_all_regions(struct pci_dev *pdev);
 int pcim_request_all_regions(struct pci_dev *pdev, const char *name);
-- 
2.44.0


