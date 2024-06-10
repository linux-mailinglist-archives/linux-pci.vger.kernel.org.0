Return-Path: <linux-pci+bounces-8519-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56880901E52
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 11:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B66AFB25AB0
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 09:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769537D3F5;
	Mon, 10 Jun 2024 09:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zh+N+N4s"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B6479DC5
	for <linux-pci@vger.kernel.org>; Mon, 10 Jun 2024 09:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718011935; cv=none; b=CgrKaK3gH2irpa+V6Va+pVXyQgtSo+oJmC2vn5hgWf5dhUE36YL2O03LACU5oy18sXcgm8denr/SPIgnypmQHbO7DxNLD8Z5bBPM7gQqzSxA/ZleUEby+gE/AZs0zT+lbSaXtI4OW7ME4CuZ6kz/Q3UDb4NKv6R87E+Q8T6QcCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718011935; c=relaxed/simple;
	bh=p5aP8feMDL/KVPuUsmLl9Z6+CZ7Vvg39RrLQww3jf+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kV0h8C0fT0hEDJ6JiEmQSGNDIIxr/C6rUw//xhYSSX3y7kA23sW3kYLwJdmu6WVPjhHP06ICJ6UmNCLdvaRznMojNTBNGYz9QG9v/CwvdMG8buo0hcambJ40Zrb7vbDleYPE5FlQZGHGXKbRRDf3U6HFZr4sAA8fungWltpKO3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zh+N+N4s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718011932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SzRgXuNR+5R6UFNTz4a6dQ6zzeQCJg+lenadNGYN7bg=;
	b=Zh+N+N4s6NUSkJx7K5PEYIBwoW4U4/ROpnGmxNKIKBbA2mYxbE9veoSr4l/GhHZafQvHxw
	Amq5QjhOSn+lvt8wWpsTn+dbQxwdSYDDmI8sNQ3r4zEnyXFKsqaWdHj3EWbaXzC9t5K5Bm
	LwDeEWP9qFSfUjpwfRI4Wze93KeHEGI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-9cVxsAIAOzaY1z4_E3qnww-1; Mon, 10 Jun 2024 05:32:08 -0400
X-MC-Unique: 9cVxsAIAOzaY1z4_E3qnww-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-421920de031so1512045e9.0
        for <linux-pci@vger.kernel.org>; Mon, 10 Jun 2024 02:32:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718011925; x=1718616725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SzRgXuNR+5R6UFNTz4a6dQ6zzeQCJg+lenadNGYN7bg=;
        b=EEkgxglPC0aUrV+gQgfGNP3m9g5PZzHn4ywDVOQPlY/Uybu2tOjfprFRhgohNdamwO
         GDaKyQfjqWfaVsDsRqH67YQ2k+1Lch7cUK9e0Pf/Gv6+Kn5sdSd7IECNNe+m4iVX5gA3
         oGrx3tUOrrzDFtioUbtz7chpr5N4+87/YaAW4nb/LdSijb93RwvTAVeBe0o0ADNtEeuv
         FFBSvViI+JFkMsYxl8O23qJA1cDCJlvFKpsGpobri3BSqkFuU0jZYcw++UIOV6woev5W
         I8FGd1u1uS96nAR84jS4QmlDk9NwjRruTtb/lAjpQ49TVuGSxJc9rDEM1mwrlAfsiNbU
         ruqA==
X-Forwarded-Encrypted: i=1; AJvYcCVTv0cG18V8HMHXrbehG+Ga1/oUrhauQ1ZLxTnqw4Sr90vr2Qbqzqb2TQoC4+6JBsRUyJ+flCJENDmhpMaVBKRQ8E9A9y0Xm5z+
X-Gm-Message-State: AOJu0YxQf7PnkebYrVNrvKLlhpFDv0Z+iaT4etlS0oE0LUrot/zuCBRF
	zAEGkW534uKL3GMEhWQqtkDF2QVZ3YVlxurTSQkrF6QQQyEbwJkb4+6A7qRjdijJV/T+/9Bga9J
	Xxw1nUhYL1Vy1hPkUOfAiArHvEhDuSwxdhXkeF/ANDlrks5K/cPuU+mvY8A==
X-Received: by 2002:a05:6000:2a1:b0:35f:2287:7b97 with SMTP id ffacd0b85a97d-35f22877d54mr1983942f8f.4.1718011925311;
        Mon, 10 Jun 2024 02:32:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnJj+pjvnt6EbKvh468//5k+11F9WXb809fPmNpxRIYhVMOIHvE6nxXbo9J+kfKJh1cgO5QA==
X-Received: by 2002:a05:6000:2a1:b0:35f:2287:7b97 with SMTP id ffacd0b85a97d-35f22877d54mr1983925f8f.4.1718011924931;
        Mon, 10 Jun 2024 02:32:04 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f0ce4b62fsm7257545f8f.80.2024.06.10.02.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 02:32:04 -0700 (PDT)
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
Subject: [PATCH v8 05/13] PCI: Make devres region requests consistent
Date: Mon, 10 Jun 2024 11:31:27 +0200
Message-ID: <20240610093149.20640-6-pstanner@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240610093149.20640-1-pstanner@redhat.com>
References: <20240610093149.20640-1-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that pure managed region request functions are available, the
implementation of the hybrid-functions which are only sometimes managed can
be made more consistent and readable by wrapping those always-managed
functions.

Implement pcim_request_region_exclusive() as a PCI-internal helper.  Have
the PCI request / release functions call their pcim_ counterparts.  Remove
the now surplus region_mask from struct pci_devres.

Link: https://lore.kernel.org/r/20240605081605.18769-7-pstanner@redhat.com
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/devres.c | 53 ++++++++++++++++++++++----------------------
 drivers/pci/pci.c    | 47 +++++++++++++--------------------------
 drivers/pci/pci.h    | 10 ++++-----
 3 files changed, 45 insertions(+), 65 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index 54b10f5433ab..f2a1250c0679 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -24,18 +24,15 @@
  *
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
@@ -399,22 +396,6 @@ static void pcim_release(struct device *gendev, void *res)
 {
 	struct pci_dev *dev = to_pci_dev(gendev);
 	struct pci_devres *this = res;
-	int i;
-
-	/*
-	 * This is legacy code.
-	 *
-	 * All regions requested by a pcim_ function do get released through
-	 * pcim_addr_resource_release(). Thanks to the hybrid nature of the pci_
-	 * region-request functions, this for-loop has to release the regions
-	 * if they have been requested by such a function.
-	 *
-	 * TODO: Remove this once all users of pcim_enable_device() PLUS
-	 * pci-region-request-functions have been ported to pcim_ functions.
-	 */
-	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++)
-		if (mask_contains_bar(this->region_mask, i))
-			pci_release_region(dev, i);
 
 	if (this->mwi)
 		pci_clear_mwi(dev);
@@ -823,11 +804,29 @@ static int _pcim_request_region(struct pci_dev *pdev, int bar, const char *name,
  * The region will automatically be released on driver detach. If desired,
  * release manually only with pcim_release_region().
  */
-static int pcim_request_region(struct pci_dev *pdev, int bar, const char *name)
+int pcim_request_region(struct pci_dev *pdev, int bar, const char *name)
 {
 	return _pcim_request_region(pdev, bar, name, 0);
 }
 
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
+
 /**
  * pcim_release_region - Release a PCI BAR
  * @pdev: PCI device to operate on
@@ -836,7 +835,7 @@ static int pcim_request_region(struct pci_dev *pdev, int bar, const char *name)
  * Release a region manually that was previously requested by
  * pcim_request_region().
  */
-static void pcim_release_region(struct pci_dev *pdev, int bar)
+void pcim_release_region(struct pci_dev *pdev, int bar)
 {
 	struct pcim_addr_devres res_searched;
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d94445f5f882..7013699db242 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3872,7 +3872,15 @@ EXPORT_SYMBOL(pci_enable_atomic_ops_to_root);
  */
 void pci_release_region(struct pci_dev *pdev, int bar)
 {
-	struct pci_devres *dr;
+	/*
+	 * This is done for backwards compatibility, because the old PCI devres
+	 * API had a mode in which the function became managed if it had been
+	 * enabled with pcim_enable_device() instead of pci_enable_device().
+	 */
+	if (pci_is_managed(pdev)) {
+		pcim_release_region(pdev, bar);
+		return;
+	}
 
 	if (pci_resource_len(pdev, bar) == 0)
 		return;
@@ -3882,21 +3890,6 @@ void pci_release_region(struct pci_dev *pdev, int bar)
 	else if (pci_resource_flags(pdev, bar) & IORESOURCE_MEM)
 		release_mem_region(pci_resource_start(pdev, bar),
 				pci_resource_len(pdev, bar));
-
-	/*
-	 * This devres utility makes this function sometimes managed
-	 * (when pcim_enable_device() has been called before).
-	 *
-	 * This is bad because it conflicts with the pcim_ functions being
-	 * exclusively responsible for managed PCI. Its "sometimes yes,
-	 * sometimes no" nature can cause bugs.
-	 *
-	 * TODO: Remove this once all users that use pcim_enable_device() PLUS
-	 * a region request function have been ported to using pcim_ functions.
-	 */
-	dr = find_pci_dr(pdev);
-	if (dr)
-		dr->region_mask &= ~(1 << bar);
 }
 EXPORT_SYMBOL(pci_release_region);
 
@@ -3922,7 +3915,12 @@ EXPORT_SYMBOL(pci_release_region);
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
@@ -3938,21 +3936,6 @@ static int __pci_request_region(struct pci_dev *pdev, int bar,
 			goto err_out;
 	}
 
-	/*
-	 * This devres utility makes this function sometimes managed
-	 * (when pcim_enable_device() has been called before).
-	 *
-	 * This is bad because it conflicts with the pcim_ functions being
-	 * exclusively responsible for managed pci. Its "sometimes yes,
-	 * sometimes no" nature can cause bugs.
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
index c09487f5550c..2403c5a0ff7a 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -826,16 +826,14 @@ struct pci_devres {
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
 
+int pcim_request_region(struct pci_dev *pdev, int bar, const char *name);
+int pcim_request_region_exclusive(struct pci_dev *pdev, int bar, const char *name);
+void pcim_release_region(struct pci_dev *pdev, int bar);
+
 /*
  * Config Address for PCI Configuration Mechanism #1
  *
-- 
2.45.0


