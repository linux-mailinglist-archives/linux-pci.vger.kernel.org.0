Return-Path: <linux-pci+bounces-2162-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5648E82DBC7
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jan 2024 15:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A5B5B21CC2
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jan 2024 14:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8AB17571;
	Mon, 15 Jan 2024 14:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G3MeuJj5"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2DC182AE
	for <linux-pci@vger.kernel.org>; Mon, 15 Jan 2024 14:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705330053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NKQuejYaTfOy+ygLhxh3ezuOqu6KilFVvxO7msTQ6Q0=;
	b=G3MeuJj5ekiHdioLT1bKZtcShERGVuH4pcCLr82mzY9q4Me+aIQUjL2e3YuXwp3MMchP1w
	nJ7VdiVsKlsN/B9T9qDtx1m1N2AZNAwmKQ4L85dCHStwkMOxJ9eiP9E3W9v2myeZ5dxFvU
	zxaC5RXOhWDjwt1kgweaZu28HbXI3sw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-KJzpDJQcNpuskn8tEaO-tA-1; Mon, 15 Jan 2024 09:47:32 -0500
X-MC-Unique: KJzpDJQcNpuskn8tEaO-tA-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-680fce72f68so25067926d6.0
        for <linux-pci@vger.kernel.org>; Mon, 15 Jan 2024 06:47:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705330051; x=1705934851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NKQuejYaTfOy+ygLhxh3ezuOqu6KilFVvxO7msTQ6Q0=;
        b=kfAR/Up4+nbs5eNZ+LJD8pCguCecVtHDH7I9PwtxFOdLfjaX5JbkyZj3SA4JWPoPV8
         wbYlCpb6Zs/XEZxra+Ltqp4HGIRyxVEE4aT/BewhraEPFgIJUkfP0HDz1guECHkKK7lY
         fONxuHPhee5td+YwacHn0DW1VD58CFKEX3Kvb/qFUXvUjG8Jtp+4qbUOVt2LTKEIqViw
         lH7iiJNEwifOBjNzPDyQuQ/ozwupA0IBFeOmNM0eHAO0NjGxBTGv4fr/lhJubENQVhgf
         5wQQp+2n2OHCvkyHCxXiO+bv4QAzDUalwg+HMCbdnv2bO+PQOQ//o2X1ABwqYSrZgJ6V
         65lg==
X-Gm-Message-State: AOJu0YyankoRTjiB5L87HULVvs5fBvCZjgmSEsAA9b/sTXZf0h2mZCp/
	E2kjUnJWrjqObqMxG2KGvMITh24EVxfDsL5fZag20dYHW5Dy/mGdFqojZU9ntkMQSKzNbGoovdx
	nyNkT8B7cAwuvoIFP2gZBBsIqWSyg
X-Received: by 2002:a05:6214:2409:b0:680:fee0:b9e9 with SMTP id fv9-20020a056214240900b00680fee0b9e9mr10832209qvb.0.1705330051548;
        Mon, 15 Jan 2024 06:47:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKb3jA3FUB/hnqVjWXw40a5VCI+1scQGITF6TP15jP4nIN+0I4b0P9xvnyisVbpi9btL+QGg==
X-Received: by 2002:a05:6214:2409:b0:680:fee0:b9e9 with SMTP id fv9-20020a056214240900b00680fee0b9e9mr10832176qvb.0.1705330051170;
        Mon, 15 Jan 2024 06:47:31 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ne13-20020a056214424d00b006815cf9a644sm1020720qvb.55.2024.01.15.06.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 06:47:30 -0800 (PST)
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
Subject: [PATCH 08/10] pci: devres: give pci(m)_intx its own callback
Date: Mon, 15 Jan 2024 15:46:19 +0100
Message-ID: <20240115144655.32046-10-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240115144655.32046-2-pstanner@redhat.com>
References: <20240115144655.32046-2-pstanner@redhat.com>
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

Implement pcim_intx() with its own device resource.
Make pci_intx() call pcim_intx() in the managed case.
Remove the legacy devres struct from pci.h.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/devres.c | 77 +++++++++++++++++++++++++++++++++++---------
 drivers/pci/pci.c    | 23 +++++++------
 drivers/pci/pci.h    | 20 ------------
 include/linux/pci.h  |  1 +
 4 files changed, 75 insertions(+), 46 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index 911c2037d9fd..7c4edcaeb8fe 100644
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
@@ -401,31 +406,71 @@ int pcim_set_mwi(struct pci_dev *pdev)
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
- * TODO:
- * Once the last four callers in pci.c are ported, this function here needs to
- * be made static again.
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
+EXPORT_SYMBOL_GPL(pcim_intx);
+
+static void pcim_release(struct device *gendev, void *res)
+{
+	struct pci_dev *dev = to_pci_dev(gendev);
+
+	if (!dev->pinned)
+		pci_disable_device(dev);
 }
-EXPORT_SYMBOL(find_pci_dr);
 
 static struct pci_devres *get_pci_dr(struct pci_dev *pdev)
 {
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 0fb9e7bb0e43..a03ad3f17540 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4465,11 +4465,23 @@ void pci_disable_parity(struct pci_dev *dev)
  * This is a "hybrid" function: Its normally unmanaged, but becomes managed
  * when pcim_enable_device() has been called in advance.
  * This hybrid feature is DEPRECATED!
+ * Use pcim_intx() if you need a managed version.
  */
 void pci_intx(struct pci_dev *pdev, int enable)
 {
 	u16 pci_command, new;
 
+	/*
+	 * This is done for backwards compatibility, because the old pci-devres
+	 * API had a mode in which this function became managed if the dev had
+	 * been enabled with pcim_enable_device() instead of pci_enable_device().
+	 */
+	if (pci_is_managed(pdev)) {
+		if (pcim_intx(pdev, enable) != 0)
+			WARN_ON_ONCE(1);
+		return;
+	}
+
 	pci_read_config_word(pdev, PCI_COMMAND, &pci_command);
 
 	if (enable)
@@ -4477,17 +4489,8 @@ void pci_intx(struct pci_dev *pdev, int enable)
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
index 667bfdd61d5e..f43873049d52 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -795,26 +795,6 @@ static inline pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
 }
 #endif
 
-/*
- * TODO:
- * The following two components wouldn't need to be here if they weren't used at
- * four last places in pci.c
- * Port or move these functions to devres.c and then remove the
- * pci_devres-components from this header file here.
- */
-/*
- * Managed PCI resources.  This manages device on/off, INTx/MSI/MSI-X
- * on/off and BAR regions.  pci_dev itself records MSI/MSI-X status, so
- * there's no need to track it separately.  pci_devres is initialized
- * when a device is enabled using managed PCI device enable interface.
- */
-struct pci_devres {
-	unsigned int orig_intx:1;
-	unsigned int restore_intx:1;
-};
-
-struct pci_devres *find_pci_dr(struct pci_dev *pdev);
-
 /*
  * Config Address for PCI Configuration Mechanism #1
  *
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2f6f44991003..721657cb59d8 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1354,6 +1354,7 @@ int pci_try_set_mwi(struct pci_dev *dev);
 void pci_clear_mwi(struct pci_dev *dev);
 void pci_disable_parity(struct pci_dev *dev);
 void pci_intx(struct pci_dev *dev, int enable);
+int pcim_intx(struct pci_dev *dev, int enable);
 bool pci_check_and_mask_intx(struct pci_dev *dev);
 bool pci_check_and_unmask_intx(struct pci_dev *dev);
 int pci_wait_for_pending(struct pci_dev *dev, int pos, u16 mask);
-- 
2.43.0


