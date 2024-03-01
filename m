Return-Path: <linux-pci+bounces-4313-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0A386E058
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 12:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DADEB24B0A
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 11:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746BC6E5E6;
	Fri,  1 Mar 2024 11:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FZK6RSg0"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F406D51F
	for <linux-pci@vger.kernel.org>; Fri,  1 Mar 2024 11:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709292624; cv=none; b=J4l32WbDgp7gKzBz8ZHEm1b9PKyxyH4wZZ0K3dHWrLaz1tsd0fktZlBlQpaZ7W6zyKd2GGSuwPaX06On9EKM1AaY/x2S2trSIHzzwFNs5d5cdPx07n81yaHw34DORHWWrU6nFQAW95myguuTDeQSSs4RdkhHXHnBuIkSqMTl5cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709292624; c=relaxed/simple;
	bh=dBpZAY4G6Rr00NPdO0HEOlJV6ToWk/vij/dkGBAi4nE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gHHrBLWCV29prvX+qHJ270STglSYZGrX+PtxjYKojLKhnfJSiwelL88g5A6hRXsSLUqRU7NMixK7q06GHw8Yv4f4eFCwS+1tZwwocPEaepqhl39UZ7KeUkR+/j6oqwiUfWZdCRl03MxQzXSWhaOXE9vpt6ffqQ5wwdNwzOfou1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FZK6RSg0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709292620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=01p8tyKoJsE6IcXs1ENkYsvv8j7qWZ5JcxE7CS3OF90=;
	b=FZK6RSg0fNIWuA3046Zvr/R/DTpCEYVhDwZoo2bmN+r6xFZT1FMcJo6XHduThmMoTUW2FE
	356m8CUtZcvHncliE6sUtJG2y7s+v9hBLZVly5Ih2gQSijohPf8lYkheqCQSe+XxPI9CeH
	NScLaluoLJFX7JJOXMITqIOqMdCS+4Y=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-2Ue_JXVKPUy1ZBqrDMIjOw-1; Fri, 01 Mar 2024 06:30:19 -0500
X-MC-Unique: 2Ue_JXVKPUy1ZBqrDMIjOw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-78315f4f5c2so67763785a.0
        for <linux-pci@vger.kernel.org>; Fri, 01 Mar 2024 03:30:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709292619; x=1709897419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=01p8tyKoJsE6IcXs1ENkYsvv8j7qWZ5JcxE7CS3OF90=;
        b=au0f/H6CBQ6HcPWwfw4IS6btdm99OszaBe7AGlZ2pIxF3lAcThtgpNnYZwNOAkKbTJ
         mWp/pfUZW1cSgxU1cEEDBH0mu8eiV2csxX/1oM7P7EBtUqftfOcpRFzc7ip48ISrGzir
         PC3BGTnjtDGQrwg+4s3oCwPTHAtYKbV3+wYCfqkwnUG5oef45c7Lz6t1hQeYYsdCHgcZ
         ekavx0JMgb78AVTD2B0FVUhgtwuDBHODqkfGTgOTrVk8RWb0EszRi7Urx0VKk8sJtfz7
         ymSJi/ojDpP2FSGnPekvId4o77YuRu+Z2hXGnmZcq6cUXY2nZxNBA43e0j5HsbLY1Myh
         npsQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6CGa1NB/nVnLEu41QgVEcgfP6fyTYobiFo0WUfRwhz/JeyXPexo6rvpCuzr9rz7ajqYqHRxktpPs49ZPRw0zxUxUfDExr2kJz
X-Gm-Message-State: AOJu0YyRW5aBY4H8kZP2bE3vgb7ifD4prnmwUN6Xw5ih5TOxJeTskG+1
	h4ypuPigJn2qDM58d6GR27ebCuF1VZM8EyGHiNMvBB84qaVlDKAVg/5e0QReuyiYzjdT+pZVLLU
	Vak2d/3Vno6/8n1zitWkoMj1aq9ZxxVtcP9d8ylqUADMhDamrLyggJYwyqQ==
X-Received: by 2002:a05:622a:1a03:b0:42e:b8da:9f62 with SMTP id f3-20020a05622a1a0300b0042eb8da9f62mr1316809qtb.4.1709292618487;
        Fri, 01 Mar 2024 03:30:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQw2pD+Wo/GKiG19WPn8v3+gPfSTvvT8b89owjce4fj65GgvIEE3cXUI2Nli8KWBwmgJhdYg==
X-Received: by 2002:a05:622a:1a03:b0:42e:b8da:9f62 with SMTP id f3-20020a05622a1a0300b0042eb8da9f62mr1316788qtb.4.1709292618065;
        Fri, 01 Mar 2024 03:30:18 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id b1-20020ac86781000000b0042eb46d15bbsm1596239qtp.88.2024.03.01.03.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 03:30:17 -0800 (PST)
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
Subject: [PATCH v4 04/10] PCI: Make devres region requests consistent
Date: Fri,  1 Mar 2024 12:29:52 +0100
Message-ID: <20240301112959.21947-5-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240301112959.21947-1-pstanner@redhat.com>
References: <20240301112959.21947-1-pstanner@redhat.com>
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
index 26179611587b..9ff52e840d9e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3853,7 +3853,15 @@ EXPORT_SYMBOL(pci_enable_atomic_ops_to_root);
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
@@ -3863,20 +3871,6 @@ void pci_release_region(struct pci_dev *pdev, int bar)
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
 
@@ -3904,14 +3898,18 @@ EXPORT_SYMBOL(pci_release_region);
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
@@ -3927,20 +3925,6 @@ static int __pci_request_region(struct pci_dev *pdev, int bar,
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
index 9d334bf4cbc4..3452684e5611 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -830,12 +830,6 @@ struct pci_devres {
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
index 5d134e833546..8964ef9f2e9b 100644
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
2.43.0


