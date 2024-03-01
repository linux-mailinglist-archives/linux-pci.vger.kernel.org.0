Return-Path: <linux-pci+bounces-4317-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A046F86E060
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 12:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 187EB1F230F3
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 11:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785556E60B;
	Fri,  1 Mar 2024 11:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V1CW600U"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1096F062
	for <linux-pci@vger.kernel.org>; Fri,  1 Mar 2024 11:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709292631; cv=none; b=oEBlRRttHNAqoArqskfynu1oHW4JR6NCZFWP7NyG5CcOjyDMzRZ31dYLD7rC8CQ8gLJ0cuJE4Hu237SI1Z1lOPZ8cCTj/8gXFYPvT3ZfErt+fc3dnYYjHdG3noAmAyg8BOak1xTCK7s+0sM4rC0IJb8vmFPW0/BMjkxRDfIowgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709292631; c=relaxed/simple;
	bh=wGKLutgNDish9diSLXJl2upRYyiSWsXKdjBkv9G+Yqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nczNrXQT0AXR63PsCV+PbxNNiVcHxPx7eeYshAQ1GdYgxEiGwoOywUBOze2FB5ojzavFSZZzJfq8inXHS+oY5VfgEGO1prX8hBGWoENjeFhrVXfneflmxMHsV1JKD6pWDbnEGlTHYgxqSxID/LrTlzd4bD3j4JTd8JuNP9n1VmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V1CW600U; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709292628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gFrW8U6ifOIeoCJ4m2srgLpDe6q16UWzB5DewZd74Sc=;
	b=V1CW600U4H3MbP3CewpfjFFWhfVN7i5MNzzCYwbOuTfSCFK9IwN8DA8Tl8AN4LPKVTzeJu
	M6chIPhxRsCu1UeLaGybNbqI9bDQqkBhqa6r8KVEVDIQ6tga70CamVFdV50Da0SGErxiAX
	NbJGIGjxn+g8KwFscJWOGwWLt2wJxbA=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-Sdh9zWxnPuSzyt8Smg8kIA-1; Fri, 01 Mar 2024 06:30:27 -0500
X-MC-Unique: Sdh9zWxnPuSzyt8Smg8kIA-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-42e8abd04feso2121621cf.0
        for <linux-pci@vger.kernel.org>; Fri, 01 Mar 2024 03:30:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709292627; x=1709897427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gFrW8U6ifOIeoCJ4m2srgLpDe6q16UWzB5DewZd74Sc=;
        b=V9dAPI8+/fgnrkAfAdQsioADOxcxNt98om3ucfbGF/dbxo7glWJzv/UROVJLpjZvY+
         LUwSuDZs8e93nl1shg23e5JGOjpSIOj2M8WgVhrANiPJx9W5AFOBsjQ9GeqIL7ogGT0A
         NWz9jAvbI1vAAofEi3kkiP8UYU72ieX5e34PblYE7C5zXiBG95/ttd656c2+TE+aONl5
         rIfUXRvfUmD1Rniur0fgHLshLSRgs8GayBDHOQzEvRDSUwUy9JU+sWxec5iwxm0cjBjZ
         uu1CzcTxgIywgc3fug0RDBUQB/a8E9HQWfIRRNVDeyWZyWew7pwuZ4l/qSO0ky0a7bQR
         WovQ==
X-Forwarded-Encrypted: i=1; AJvYcCXej4YSWlZQwt62ewCFyWaHQmdPOF9NdQa/AljLec0KIspZF3rPmLayiJC3e5PeZWK5/cZVWqOvgA1s4UA8O43NlHmfD8HY40NC
X-Gm-Message-State: AOJu0YwzygiHFr4WtOIT97N63TlYUJTVYAx+yNi2o32K6L+QWcVSFxFW
	Ta5Jzf8UBi+CqkhD1/7fiB/uw4pIvVM4yfDpDzfJOaE0M5IDRNUF/7tFwsJcxSaTkAWdaeYBBst
	VN7ZCSSiBwRk0Os0UxIz1mtNUGqLHug0jGfVrewyCAYRcffxZZWHTjxhwWg==
X-Received: by 2002:a05:622a:1ba8:b0:42e:b428:808d with SMTP id bp40-20020a05622a1ba800b0042eb428808dmr1172314qtb.0.1709292626854;
        Fri, 01 Mar 2024 03:30:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGhT502yChHD7nPbq6Ya4luJieu8HbTHkr0kt24S6xsGaGCfqyhcYmSy34J3ytpTb8Oyflxg==
X-Received: by 2002:a05:622a:1ba8:b0:42e:b428:808d with SMTP id bp40-20020a05622a1ba800b0042eb428808dmr1172294qtb.0.1709292626575;
        Fri, 01 Mar 2024 03:30:26 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id b1-20020ac86781000000b0042eb46d15bbsm1596239qtp.88.2024.03.01.03.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 03:30:26 -0800 (PST)
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
Subject: [PATCH v4 08/10] PCI: Give pci(m)_intx its own devres callback
Date: Fri,  1 Mar 2024 12:29:56 +0100
Message-ID: <20240301112959.21947-9-pstanner@redhat.com>
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

pci_intx() is one of the functions that have "hybrid mode" (i.e.,
sometimes managed, sometimes not). Providing a separate pcim_intx()
function with its own device resource and cleanup callback allows for
removing further large parts of the legacy pci-devres implementation.

As in the region-request-functions, pci_intx() has to call into its
managed counterpart for backwards compatibility.

As pci_intx() is an outdated function, pcim_intx() shall not be made
visible to other drivers via a public API.

Implement pcim_intx() with its own device resource.
Make pci_intx() call pcim_intx() in the managed case.
Remove the struct pci_devres from pci.h.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/devres.c | 74 +++++++++++++++++++++++++++++++++++---------
 drivers/pci/pci.c    | 24 +++++++-------
 drivers/pci/pci.h    | 17 +---------
 3 files changed, 74 insertions(+), 41 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index e417bd3ea96f..8a643f15140a 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -40,6 +40,11 @@ struct pcim_iomap_devres {
 	void __iomem *table[PCI_STD_NUM_BARS];
 };
 
+/* Used to restore the old intx state on driver detach. */
+struct pcim_intx_devres {
+	int orig_intx;
+};
+
 enum pcim_addr_devres_type {
 	/* Default initializer. */
 	PCIM_ADDR_DEVRES_TYPE_INVALID,
@@ -401,28 +406,69 @@ int pcim_set_mwi(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL(pcim_set_mwi);
 
+static void pcim_intx_restore(struct device *dev, void *data)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pcim_intx_devres *res = data;
 
-static void pcim_release(struct device *gendev, void *res)
+	pci_intx(pdev, res->orig_intx);
+}
+
+static struct pcim_intx_devres *get_or_create_intx_devres(struct device *dev)
 {
-	struct pci_dev *dev = to_pci_dev(gendev);
-	struct pci_devres *this = res;
+	struct pcim_intx_devres *res;
 
-	if (this->restore_intx)
-		pci_intx(dev, this->orig_intx);
+	res = devres_find(dev, pcim_intx_restore, NULL, NULL);
+	if (res)
+		return res;
 
-	if (!dev->pinned)
-		pci_disable_device(dev);
+	res = devres_alloc(pcim_intx_restore, sizeof(*res), GFP_KERNEL);
+	if (res)
+		devres_add(dev, res);
+
+	return res;
 }
 
-/*
- * TODO: After the last four callers in pci.c are ported, find_pci_dr()
- * needs to be made static again.
+/**
+ * pcim_intx - managed pci_intx()
+ * @pdev: the PCI device to operate on
+ * @enable: boolean: whether to enable or disable PCI INTx
+ *
+ * Returns: 0 on success, -ENOMEM on error.
+ *
+ * Enables/disables PCI INTx for device @pdev.
+ * Restores the original state on driver detach.
  */
-struct pci_devres *find_pci_dr(struct pci_dev *pdev)
+int pcim_intx(struct pci_dev *pdev, int enable)
 {
-	if (pci_is_managed(pdev))
-		return devres_find(&pdev->dev, pcim_release, NULL, NULL);
-	return NULL;
+	u16 pci_command, new;
+	struct pcim_intx_devres *res;
+
+	res = get_or_create_intx_devres(&pdev->dev);
+	if (!res)
+		return -ENOMEM;
+
+	res->orig_intx = !enable;
+
+	pci_read_config_word(pdev, PCI_COMMAND, &pci_command);
+
+	if (enable)
+		new = pci_command & ~PCI_COMMAND_INTX_DISABLE;
+	else
+		new = pci_command | PCI_COMMAND_INTX_DISABLE;
+
+	if (new != pci_command)
+		pci_write_config_word(pdev, PCI_COMMAND, new);
+
+	return 0;
+}
+
+static void pcim_release(struct device *gendev, void *res)
+{
+	struct pci_dev *dev = to_pci_dev(gendev);
+
+	if (!dev->pinned)
+		pci_disable_device(dev);
 }
 
 static struct pci_devres *get_pci_dr(struct pci_dev *pdev)
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 862dab87732a..8ad2ded49ab5 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3857,7 +3857,7 @@ EXPORT_SYMBOL(pci_enable_atomic_ops_to_root);
 void pci_release_region(struct pci_dev *pdev, int bar)
 {
 	/*
-	 * This is done for backwards compatibility, because the old pci-devres
+	 * This is done for backwards compatibility, because the old PCI devres
 	 * API had a mode in which the function became managed if it had been
 	 * enabled with pcim_enable_device() instead of pci_enable_device().
 	 */
@@ -4445,11 +4445,22 @@ void pci_disable_parity(struct pci_dev *dev)
  * This is a "hybrid" function: Its normally unmanaged, but becomes managed
  * when pcim_enable_device() has been called in advance.
  * This hybrid feature is DEPRECATED!
+ * Use pcim_intx() if you need a managed version.
  */
 void pci_intx(struct pci_dev *pdev, int enable)
 {
 	u16 pci_command, new;
 
+	/*
+	 * This is done for backwards compatibility, because the old PCI devres
+	 * API had a mode in which this function became managed if the dev had
+	 * been enabled with pcim_enable_device() instead of pci_enable_device().
+	 */
+	if (pci_is_managed(pdev)) {
+		WARN_ON_ONCE(pcim_intx(pdev, enable) != 0);
+		return;
+	}
+
 	pci_read_config_word(pdev, PCI_COMMAND, &pci_command);
 
 	if (enable)
@@ -4457,17 +4468,8 @@ void pci_intx(struct pci_dev *pdev, int enable)
 	else
 		new = pci_command | PCI_COMMAND_INTX_DISABLE;
 
-	if (new != pci_command) {
-		struct pci_devres *dr;
-
+	if (new != pci_command)
 		pci_write_config_word(pdev, PCI_COMMAND, new);
-
-		dr = find_pci_dr(pdev);
-		if (dr && !dr->restore_intx) {
-			dr->restore_intx = 1;
-			dr->orig_intx = !enable;
-		}
-	}
 }
 EXPORT_SYMBOL_GPL(pci_intx);
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index bbe004eabcc1..c6da2b554108 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -814,22 +814,7 @@ static inline pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
 }
 #endif
 
-/*
- * Managed PCI resources.  This manages device on/off, INTx/MSI/MSI-X
- * on/off and BAR regions.  pci_dev itself records MSI/MSI-X status, so
- * there's no need to track it separately.  pci_devres is initialized
- * when a device is enabled using managed PCI device enable interface.
- *
- * TODO: Struct pci_devres and find_pci_dr() only need to be here because
- * they're used in pci.c.  Port or move these functions to devres.c and
- * then remove them from here.
- */
-struct pci_devres {
-	unsigned int orig_intx:1;
-	unsigned int restore_intx:1;
-};
-
-struct pci_devres *find_pci_dr(struct pci_dev *pdev);
+int pcim_intx(struct pci_dev *dev, int enable);
 
 /*
  * Config Address for PCI Configuration Mechanism #1
-- 
2.43.0


