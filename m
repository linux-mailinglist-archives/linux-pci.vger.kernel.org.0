Return-Path: <linux-pci+bounces-8300-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD848FC5ED
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 10:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C1A71F21C32
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 08:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA95193094;
	Wed,  5 Jun 2024 08:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ej8/cys4"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A54619306B
	for <linux-pci@vger.kernel.org>; Wed,  5 Jun 2024 08:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717575394; cv=none; b=kS2HwwldT6VMsMYNVg/C/XS6cL1DKfLRuccpBPq4d5alEYyWE3vfhtF0ubINDT995TYWOcJDDsT0etqEvje/TC5d3NFJU7aw71jWj6+3JzEHiNg8aycDhZID+AMUrf6acOiK6+BpIAevAZ6YMeZfbjXbXU1eksdjsj7BMrIDTIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717575394; c=relaxed/simple;
	bh=AlFTmLMzlg/9siSmkDtaN7HrGXf9sRz/JBoLcrgGJpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G1tszl+G/Kk6StZ3lPcc9x68HWFCUyhWi5qhkfTxKncXvjzV6llh3PCEx8Q9XmK1E9zZ9v+rPUcPV9lkvS0F7gZngJpX340KdcKeX4SiwmlhovB3ZiVQTDmfoaCjiz6UQJE6EvpHOEr6Q9XsPbAsrPHN1ABdRY0GmdmKvM0iJIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ej8/cys4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717575391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3wjuhXIVsdrU0yS+eTswxcN+RcBPUQZ+Ad0UnwdbpZc=;
	b=ej8/cys4mDxvQErsiIoNDu65N2ZFq+MCMRfvJgaIxDToQ0TZHLjGf/hj9w7Dag0QwJU9+q
	zij+7Bkg/dbDRR8SbwkFVnJPVoLKOr47EuGU4gqzH78Ja7QmYl11jA6B6Yf9eeIl1xgZi9
	g21kKYzUY/aC/uVlKILRz4wbVUjbtdc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-6noU5jxSMVSLjksu04OMQQ-1; Wed, 05 Jun 2024 04:16:23 -0400
X-MC-Unique: 6noU5jxSMVSLjksu04OMQQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-35dceeb18c9so281441f8f.0
        for <linux-pci@vger.kernel.org>; Wed, 05 Jun 2024 01:16:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717575381; x=1718180181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3wjuhXIVsdrU0yS+eTswxcN+RcBPUQZ+Ad0UnwdbpZc=;
        b=RL+wccEk6NYiWx6uXEWz0IfD51l1qDIN3JsDZ0Vgd5deI43/8uVceTN2wu0hr2RF5O
         nunucCN6OT7PgQhrQ7EZ9lQ69W+r3n4GYl002W1x7rCftKUWWV485H362q/34JpQtU/1
         x7hlqGEE95pMNNrDm7lN+0L3NZ37AOOJSy1yoU1Mr3Q3W/gqEikdx+S7PB4PptqbQM/n
         9znFb+2UZlt7ZBCqOhEemSqKPB7j48tJW5jCLx+YKmDJJdgwsGxMSu7XpAvysCNKT9qE
         +3kMcjgAEQHi/VGzvmIeNusfIX8sfo8ZSvU0Je7EprxUgzw6Pqyym8nm2piK6oBTpPb9
         pGWw==
X-Forwarded-Encrypted: i=1; AJvYcCUYJowInzrci7eZWOkQIgM6DReFIQL07WmkgywAUloKKJ/2IK+DJv6gGlSlRwAQS3a49uMznPmgHxiRS2eN+OX4h/MjB2mxNrFv
X-Gm-Message-State: AOJu0YyxmMovUukVbpb0U6e9zFYbw29gkuOgMNbuISezZ63l8UfmJ6/o
	H0aNWXhEqoqg5MY0CwnZqH/P2DpmI92d1a4apFIvbR9913CCOFAvTIvJqAP28Tk42iGMSY0HlNE
	w1Z/xm+0tqNiJdj6gOhQaTBXONQN1EqEMHPv+ACwXHmzGDq7F0CnWoULMVI2MlWHSvA==
X-Received: by 2002:a05:6000:bd0:b0:355:3ec:c7e7 with SMTP id ffacd0b85a97d-35e84057ebemr1244195f8f.2.1717575381551;
        Wed, 05 Jun 2024 01:16:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjZbVLQcTv5XWXPkHqha5v7vJWmf4YkZ6i75B+qQMTp1XC9toezuTporsM1/y1jErlQkDyeQ==
X-Received: by 2002:a05:6000:bd0:b0:355:3ec:c7e7 with SMTP id ffacd0b85a97d-35e84057ebemr1244182f8f.2.1717575381207;
        Wed, 05 Jun 2024 01:16:21 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.fritz.box ([2001:9e8:32e6:e600:c901:4daf:2476:80ad])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd0630010sm13739163f8f.76.2024.06.05.01.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 01:16:20 -0700 (PDT)
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
Subject: [PATCH v7 05/13] PCI: Make devres region requests consistent
Date: Wed,  5 Jun 2024 10:15:57 +0200
Message-ID: <20240605081605.18769-7-pstanner@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240605081605.18769-2-pstanner@redhat.com>
References: <20240605081605.18769-2-pstanner@redhat.com>
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

Implement pcim_request_region_exclusive() as a PCI-internal helper.
Have the PCI request / release functions call their pcim_ counterparts.
Remove the now surplus region_mask from struct pci_devres.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/devres.c | 52 ++++++++++++++++++++++----------------------
 drivers/pci/pci.c    | 45 +++++++++++++-------------------------
 drivers/pci/pci.h    | 10 ++++-----
 3 files changed, 45 insertions(+), 62 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index f199f610ae51..572a4e193879 100644
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
@@ -394,21 +391,6 @@ static void pcim_release(struct device *gendev, void *res)
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
-		if (mask_contains_bar(this->region_mask, i))
-			pci_release_region(dev, i);
 
 	if (this->mwi)
 		pci_clear_mwi(dev);
@@ -816,11 +798,29 @@ static int _pcim_request_region(struct pci_dev *pdev, int bar, const char *name,
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
@@ -829,7 +829,7 @@ static int pcim_request_region(struct pci_dev *pdev, int bar, const char *name)
  * Release a region manually that was previously requested by
  * pcim_request_region().
  */
-static void pcim_release_region(struct pci_dev *pdev, int bar)
+void pcim_release_region(struct pci_dev *pdev, int bar)
 {
 	struct pcim_addr_devres res_searched;
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b5d21d8207d6..e4feb093f097 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3869,7 +3869,15 @@ EXPORT_SYMBOL(pci_enable_atomic_ops_to_root);
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
 
@@ -3918,7 +3912,12 @@ EXPORT_SYMBOL(pci_release_region);
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
@@ -3934,20 +3933,6 @@ static int __pci_request_region(struct pci_dev *pdev, int bar,
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
index 171884aba8e1..9fd50bc99e6b 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -828,16 +828,14 @@ struct pci_devres {
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


