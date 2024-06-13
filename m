Return-Path: <linux-pci+bounces-8727-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F18906CE6
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 13:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33F2F1C22420
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 11:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE74145A11;
	Thu, 13 Jun 2024 11:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HVF7FhFw"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AA2148FF5
	for <linux-pci@vger.kernel.org>; Thu, 13 Jun 2024 11:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279461; cv=none; b=ETEDBYwuVFMkWKfHzQ7nJqX3g6mi0Ms3xiYbPQ8S5kF8GQ5maWfg9BQXQpAQZnHTpLq5YkLUq5V60j04jM+d86t9/MNZmT4fEoiH6p6dUkcTr4CruV4FS8eaiLeuEIkHUBZ9ohwp6LirFNE/tJNAdZc7BDUTo3htt/1oG/pj2JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279461; c=relaxed/simple;
	bh=r0grzUmBcSDYCaYgn9ysXFCKA4yu6vMMhBtQa+BDezY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YAj+Wy8J/u6flc6jCdB/TlImb0XVHB2GLl3jqDko4eEm6Qms5I0m6udOFu9CQBIgygemaW9XtI+gUgI8hddrMdMYeP9UYjXZeF0i9KgyWl42hk9jhIfwLSgXnnlbupbf8BeylUP+KPlJ2hWlX2kyShpgfSefK2vOByGKoHik1ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HVF7FhFw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718279459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DkCOJZ/wPtUvxbKR6iZK0j94vWla8EApzDXg+GJsTLg=;
	b=HVF7FhFw9OXidnm3QlIMvIgeUOdvT53c33TnYvYyfyEaN7MsNGp+q1rAPIkl9gJPDgPkV9
	Agne8n0HMabXQDpiS4UHSpir8Pf3OpQS8mQVlW18032GBL9D8sk6WgJg4q7rxLbiRvoZmh
	kS+yay74tJnOMg2XEjqczx2Mz8neTCY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-LPdNPLFJPc2NSGAytRGkdA-1; Thu, 13 Jun 2024 07:50:58 -0400
X-MC-Unique: LPdNPLFJPc2NSGAytRGkdA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4210e98f8d7so1509995e9.3
        for <linux-pci@vger.kernel.org>; Thu, 13 Jun 2024 04:50:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718279457; x=1718884257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DkCOJZ/wPtUvxbKR6iZK0j94vWla8EApzDXg+GJsTLg=;
        b=AA8fzDL6Mf5ZfPV/T+CiiEGJRLfZbXoVSWPsw5Go4aqiLm/iEuL2Eivj+hgw/ZDdCB
         YmYnUsAFaH1xEEcBPciJ8zDTU8k9PviY2tkpb10jqroBcCSK2DsmDEsNxrOfplUhRe0o
         zGVYyTLqGGeZzhwI0mjgGR6Yc1FMWMejHpPwNc8Ax//V8G0WnXWCz/z4oKbrIJHsW4E/
         f+cRJB6ugmhi/v7jFmoNg01p30xLQRIiLF1c6ekVKwrvSyqkEyd5CMBDBFF+kTGwwQJc
         asAlwREc2Qqxd6iV8R/vMJFqs+I16WwuEMjzLr1U1tUbirtdqqfAUq/7j9x8LQjWZ9dR
         R0Og==
X-Forwarded-Encrypted: i=1; AJvYcCXzbVPnVZSFVIe581LnLuo5VQ5rwFWUxlIAiOrFG6yu88cfwVGvtu0Th5NZ1IZyftsOdttgzJWAGXI5gr5JetYv4bz/JDmNMWMn
X-Gm-Message-State: AOJu0YxMTFrpw/pd9ZV7ZPJbZPYzv/ui74+4vh29x6OTfw44YILO/HHm
	3qHZIAtfOFSYRP+36mUYOGkr66jswikLUHheo1BH/MfQMesrsn54cRRnMpSkVWjsMBJLlDA0rGf
	KNUivbVhl49TgDJO3AIUWBG4d0VlJ84qGNa6uSeuD/0VhGK03Xct5oscHvw==
X-Received: by 2002:a05:6000:1845:b0:35f:e38:6758 with SMTP id ffacd0b85a97d-36079a587a3mr156388f8f.7.1718279456835;
        Thu, 13 Jun 2024 04:50:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2TEvywhfauVMW37zv3JfoMBzZNIERzrEKPTEghMv7QdmvZthOHWTnGztKiTfV2ZqUSTTNVg==
X-Received: by 2002:a05:6000:1845:b0:35f:e38:6758 with SMTP id ffacd0b85a97d-36079a587a3mr156374f8f.7.1718279456563;
        Thu, 13 Jun 2024 04:50:56 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607509c883sm1510620f8f.29.2024.06.13.04.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 04:50:56 -0700 (PDT)
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
Subject: [PATCH v9 11/13] PCI: Remove legacy pcim_release()
Date: Thu, 13 Jun 2024 13:50:24 +0200
Message-ID: <20240613115032.29098-12-pstanner@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240613115032.29098-1-pstanner@redhat.com>
References: <20240613115032.29098-1-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks to preceding cleanup steps, pcim_release() is now not needed
anymore and can be replaced by pcim_disable_device(), which is the exact
counterpart to pcim_enable_device().

This permits removing further parts of the old PCI devres implementation.

Replace pcim_release() with pcim_disable_device().
Remove the now surplus function get_pci_dr().
Remove the struct pci_devres from pci.h.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/devres.c | 53 +++++++++++++++++++++-----------------------
 drivers/pci/pci.h    | 16 -------------
 2 files changed, 25 insertions(+), 44 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index 7b72c952a9e5..37ac8fd37291 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -465,48 +465,45 @@ int pcim_intx(struct pci_dev *pdev, int enable)
 	return 0;
 }
 
-static void pcim_release(struct device *gendev, void *res)
+static void pcim_disable_device(void *pdev_raw)
 {
-	struct pci_dev *dev = to_pci_dev(gendev);
-
-	if (pci_is_enabled(dev) && !dev->pinned)
-		pci_disable_device(dev);
-}
-
-static struct pci_devres *get_pci_dr(struct pci_dev *pdev)
-{
-	struct pci_devres *dr, *new_dr;
-
-	dr = devres_find(&pdev->dev, pcim_release, NULL, NULL);
-	if (dr)
-		return dr;
+	struct pci_dev *pdev = pdev_raw;
 
-	new_dr = devres_alloc(pcim_release, sizeof(*new_dr), GFP_KERNEL);
-	if (!new_dr)
-		return NULL;
-	return devres_get(&pdev->dev, new_dr, NULL, NULL);
+	if (!pdev->pinned)
+		pci_disable_device(pdev);
 }
 
 /**
  * pcim_enable_device - Managed pci_enable_device()
  * @pdev: PCI device to be initialized
  *
- * Managed pci_enable_device().
+ * Returns: 0 on success, negative error code on failure.
+ *
+ * Managed pci_enable_device(). Device will automatically be disabled on
+ * driver detach.
  */
 int pcim_enable_device(struct pci_dev *pdev)
 {
-	struct pci_devres *dr;
-	int rc;
+	int ret;
 
-	dr = get_pci_dr(pdev);
-	if (unlikely(!dr))
-		return -ENOMEM;
+	ret = devm_add_action(&pdev->dev, pcim_disable_device, pdev);
+	if (ret != 0)
+		return ret;
 
-	rc = pci_enable_device(pdev);
-	if (!rc)
-		pdev->is_managed = 1;
+	/*
+	 * We prefer removing the action in case of an error over
+	 * devm_add_action_or_reset() because the later could theoretically be
+	 * disturbed by users having pinned the device too soon.
+	 */
+	ret = pci_enable_device(pdev);
+	if (ret != 0) {
+		devm_remove_action(&pdev->dev, pcim_disable_device, pdev);
+		return ret;
+	}
 
-	return rc;
+	pdev->is_managed = true;
+
+	return ret;
 }
 EXPORT_SYMBOL(pcim_enable_device);
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 9e87528f1157..e51e6fa79fcc 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -810,22 +810,6 @@ static inline pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
 }
 #endif
 
-/*
- * Managed PCI resources.  This manages device on/off, INTx/MSI/MSI-X
- * on/off and BAR regions.  pci_dev itself records MSI/MSI-X status, so
- * there's no need to track it separately.  pci_devres is initialized
- * when a device is enabled using managed PCI device enable interface.
- *
- * TODO: Struct pci_devres only needs to be here because they're used in pci.c.
- * Port or move these functions to devres.c and then remove them from here.
- */
-struct pci_devres {
-	/*
-	 * TODO:
-	 * This struct is now surplus. Remove it by refactoring pci/devres.c
-	 */
-};
-
 int pcim_intx(struct pci_dev *dev, int enable);
 
 int pcim_request_region(struct pci_dev *pdev, int bar, const char *name);
-- 
2.45.0


