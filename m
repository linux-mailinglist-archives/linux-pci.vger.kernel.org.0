Return-Path: <linux-pci+bounces-5866-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B31DA89BAA2
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 10:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CB061F22B3B
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 08:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D78481B1;
	Mon,  8 Apr 2024 08:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZwocmTi5"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3CE45951
	for <linux-pci@vger.kernel.org>; Mon,  8 Apr 2024 08:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712565883; cv=none; b=lpoOx563lOEqyYyOWim9+6Rn9R2tlhNIl8PgJao1r2dVBUaOd2rvabdFZkKQKVW9yjXD5w+dlIwmfdWTgnwJ5pQwysTFQw1jyuMo58M4VuZ1XUgNg1W9NArMU0r0myE6yCF5getWf3MvjzWJyMoe1sOFtOyDHbq6jr4H9tLmpkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712565883; c=relaxed/simple;
	bh=ph/4KcAsTi43ubN861sbaEt6JoUBoxu5rEFqsUZSaCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cwn6A2L7xJ9SnLV+Qz7JNZt6kgDdm06BuNbc/8S2CEUAePJgqIykkIYQ9J7oSm+KDL+YTKKPdJzxEfMrbCD5jFzv3Y6t0Nnkkdh2n/5m1a1udf72wRzjvRSbCRmb/vwglFwtSDDu6QgWSQ8fIIV9qgouWHyoJu5K0NXwxVjgQnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZwocmTi5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712565881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HBYxescmGlqJZbkhxXkrYbSUutHFKaQyU2GxTiA6gSQ=;
	b=ZwocmTi59N1GRS+VdlBAinkZ0cAKVKFapAVvO1EHpTgxFkUeMqYJTodeTNpOcimPgvggvw
	CFe5ep56MsaZCu4L98Hi8/I0nnfFFI5VPVv+FMPi2kX3qh3JVoAbc84oCbVt84I1RgFrM2
	dkwmnSe/cZFqptM5/XKgfnclwY2LaUE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-Ec92vJ9oOV69hBK9KNYATg-1; Mon, 08 Apr 2024 04:44:39 -0400
X-MC-Unique: Ec92vJ9oOV69hBK9KNYATg-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-78d346eeb02so182035285a.1
        for <linux-pci@vger.kernel.org>; Mon, 08 Apr 2024 01:44:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712565879; x=1713170679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HBYxescmGlqJZbkhxXkrYbSUutHFKaQyU2GxTiA6gSQ=;
        b=pYyv7UmVZ8oiB8cQjwJreUYmW8qTVsbnn6bacP5iQ85TVfCAwI0Hs8jiMxVMtUKJAL
         lXp2OzpKUvsImIzO/flbTNfiBMf0iXBIU4BxqyJPFZ0NqAywR96CcCb00cAGaa6WXZLL
         ozWgRBNpZSGueMv2s0JDCTutieC31MGhi0kIrh1X2PvoFw0dS2lkW7Zw7PE0e/0JHlzu
         rLiU2Vbji6YQT4No+NektC18UYGEklJln5tuAAiQSigs1P8hv6WS7Db0i9lK7UQNLvyQ
         x7A4pMSA+LaTPZ+qx9mTn3Hs09zSt48Vdzak0XHYZfYlSzq+R8QQxrFCqF7qaVe5qZlq
         SdSQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7nnY+fjPguIS3T7E/haxeFZL7xe54PqFRaAg5oWati+UQfeTzfR1fmdLS1CrWR7qJPxBqHFdS9if44DzoDMXqlX7wPMoZJKFo
X-Gm-Message-State: AOJu0Ywo3Bty9UDuzKmjZ/4y1PH2XZYHmVoLkHFpiEeGl/Ukj4eL3FWC
	yd8kB2FjlP8edTzMmY63aN3GeaJ02YU51OTpNQWM/z4cSpZbJf8Qflt9gZ3nGkkJMpPQcsJHZ/3
	CTRpr43VZSHpWsSLUsQ3nJUWgwmRtBYk6jJeJcEcVIEycglqSA4OhuEc7EA==
X-Received: by 2002:a05:620a:4014:b0:78b:c3a2:26ce with SMTP id h20-20020a05620a401400b0078bc3a226cemr9387796qko.7.1712565879329;
        Mon, 08 Apr 2024 01:44:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCnsmOGRAE/Be/m4mXdpGAm4C6IVXQDRK7QdJQ/6V7/eI39vG2eQRZ/l8WvRwG9UKSoTuiAQ==
X-Received: by 2002:a05:620a:4014:b0:78b:c3a2:26ce with SMTP id h20-20020a05620a401400b0078bc3a226cemr9387787qko.7.1712565879044;
        Mon, 08 Apr 2024 01:44:39 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id oo15-20020a05620a530f00b0078d54e39f6csm2036989qkn.23.2024.04.08.01.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 01:44:38 -0700 (PDT)
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
Subject: [PATCH v6 05/10] PCI: Move dev-enabled status bit to struct pci_dev
Date: Mon,  8 Apr 2024 10:44:17 +0200
Message-ID: <20240408084423.6697-6-pstanner@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408084423.6697-1-pstanner@redhat.com>
References: <20240408084423.6697-1-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bit describing whether the PCI device is currently enabled is stored
in struct pci_devres. Besides this struct being subject of a cleanup
process, struct pci_device is in general the right place to store this
information, since it is not devres-specific.

Move the 'enabled' boolean bit to struct pci_dev.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/devres.c | 11 ++++-------
 drivers/pci/pci.c    | 17 ++++++++++-------
 drivers/pci/pci.h    |  1 -
 include/linux/pci.h  |  1 +
 4 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index d9cd7f97c38c..623e27aea2b1 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -403,7 +403,7 @@ static void pcim_release(struct device *gendev, void *res)
 	if (this->restore_intx)
 		pci_intx(dev, this->orig_intx);
 
-	if (this->enabled && !this->pinned)
+	if (!this->pinned)
 		pci_disable_device(dev);
 }
 
@@ -446,14 +446,11 @@ int pcim_enable_device(struct pci_dev *pdev)
 	dr = get_pci_dr(pdev);
 	if (unlikely(!dr))
 		return -ENOMEM;
-	if (dr->enabled)
-		return 0;
 
 	rc = pci_enable_device(pdev);
-	if (!rc) {
+	if (!rc)
 		pdev->is_managed = 1;
-		dr->enabled = 1;
-	}
+
 	return rc;
 }
 EXPORT_SYMBOL(pcim_enable_device);
@@ -471,7 +468,7 @@ void pcim_pin_device(struct pci_dev *pdev)
 	struct pci_devres *dr;
 
 	dr = find_pci_dr(pdev);
-	WARN_ON(!dr || !dr->enabled);
+	WARN_ON(!dr || !pdev->enabled);
 	if (dr)
 		dr->pinned = 1;
 }
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index c0c1ee17a06b..9f1419bac9b9 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2011,6 +2011,9 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
 	u16 cmd;
 	u8 pin;
 
+	if (dev->enabled)
+		return 0;
+
 	err = pci_set_power_state(dev, PCI_D0);
 	if (err < 0 && err != -EIO)
 		return err;
@@ -2025,7 +2028,7 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
 	pci_fixup_device(pci_fixup_enable, dev);
 
 	if (dev->msi_enabled || dev->msix_enabled)
-		return 0;
+		goto success_out;
 
 	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
 	if (pin) {
@@ -2035,6 +2038,8 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
 					      cmd & ~PCI_COMMAND_INTX_DISABLE);
 	}
 
+success_out:
+	dev->enabled = true;
 	return 0;
 }
 
@@ -2193,6 +2198,9 @@ static void do_pci_disable_device(struct pci_dev *dev)
 {
 	u16 pci_command;
 
+	if (!dev->enabled)
+		return;
+
 	pci_read_config_word(dev, PCI_COMMAND, &pci_command);
 	if (pci_command & PCI_COMMAND_MASTER) {
 		pci_command &= ~PCI_COMMAND_MASTER;
@@ -2200,6 +2208,7 @@ static void do_pci_disable_device(struct pci_dev *dev)
 	}
 
 	pcibios_disable_device(dev);
+	dev->enabled = false;
 }
 
 /**
@@ -2227,12 +2236,6 @@ void pci_disable_enabled_device(struct pci_dev *dev)
  */
 void pci_disable_device(struct pci_dev *dev)
 {
-	struct pci_devres *dr;
-
-	dr = find_pci_dr(dev);
-	if (dr)
-		dr->enabled = 0;
-
 	dev_WARN_ONCE(&dev->dev, atomic_read(&dev->enable_cnt) <= 0,
 		      "disabling already-disabled device");
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 040ed2825554..2b6c0df133bf 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -823,7 +823,6 @@ static inline pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
  * then remove them from here.
  */
 struct pci_devres {
-	unsigned int enabled:1;
 	unsigned int pinned:1;
 	unsigned int orig_intx:1;
 	unsigned int restore_intx:1;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 0f203338f820..95cdd1bc73c4 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -367,6 +367,7 @@ struct pci_dev {
 					   this is D0-D3, D0 being fully
 					   functional, and D3 being off. */
 	u8		pm_cap;		/* PM capability offset */
+	unsigned int	enabled:1;	/* Whether this dev is enabled */
 	unsigned int	imm_ready:1;	/* Supports Immediate Readiness */
 	unsigned int	pme_support:5;	/* Bitmask of states from which PME#
 					   can be generated */
-- 
2.44.0


