Return-Path: <linux-pci+bounces-8297-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9158FC5E9
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 10:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A4B11F200E7
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 08:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1311922FB;
	Wed,  5 Jun 2024 08:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IpzRLl8R"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4875919148E
	for <linux-pci@vger.kernel.org>; Wed,  5 Jun 2024 08:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717575391; cv=none; b=Sp9qm3k1T/d/04TYRaxmE5KsQEb5fLVfUYkinMzsjX8Dk+AWgQHBvljnihwBkifOwHSUIEnMCZ9u2FL+74shVmUQQm1C3SOLIm9c2jY/ZXWBxdXO1e20kvyb7RM4H6a9l1MGGEmppJzTlgq12bf/94qo9DOflBuk23OthKqslKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717575391; c=relaxed/simple;
	bh=MI0mRgfrILGP9+SXcTL9wGDcBl7tlRwscoQrU2TMa2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oDSlZ3pWhH9YfaNyTxmJ/SKdYpLJM50IGuNAhwBB6dc1NdFpgzu4PWNoAEnoxLwezPE7O8jTJwsX2EY3y0u0H+4vZtglYEXJINkNW6Eq9bN58Fk7VXZhQyNO/ypOjxYpGkPSOErA8w6zjhiKHJryxlE6RbXDt6829wwhrZGWjcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IpzRLl8R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717575389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vEB31yOtYoIre4MIRkuOCh7GA8J//awJNnm4ltdU4bo=;
	b=IpzRLl8RP1YwWfOwPhY29lJmU+hnzExNnC8GBKxQoow3bpg2KNy/PV1Pi3JwJdzXJ5H5Vu
	1gvgqdjAt9QlQbZvvJgMN04mV63x2d9aD4dFQ2CektLX35QkewS4dQ+MXw0DqiEvctnJUd
	3jqC38TiqfFUPfP5iNRzFpn7r8gZJlc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-Aj7guTDRP9OpTskjxIvSQA-1; Wed, 05 Jun 2024 04:16:24 -0400
X-MC-Unique: Aj7guTDRP9OpTskjxIvSQA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-354f30004c8so422184f8f.3
        for <linux-pci@vger.kernel.org>; Wed, 05 Jun 2024 01:16:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717575383; x=1718180183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vEB31yOtYoIre4MIRkuOCh7GA8J//awJNnm4ltdU4bo=;
        b=w2z8MZLP97MNeFfdavv1WDC4OlWcTLqkCVANSQNq8W6b4kxdlamMvGadVXqxwXWEww
         EUbjsyEuB2QhM2oC0ZFXzFmwCDURdYKObQB1oHa8Q/A8EgX3Xj55EkM/e07lMjGPN35/
         hjXY7TdBLwNy/SetgQvmJ0UnVKktSP4PVNFWKX4/3bgRMeofnbyvN3NvGu1WmDgvGEkY
         ZQrkeHbY3EnvJTyTAnZ8M93ifVBkUjT1jYilRl0JHZBKp0KyukJD3rgb6QMjTzY6o8Sw
         O++cTNXvb9P89Ev8m/dWoCPfwn8yekiDnEg5/+q8t8A4480oR3ZJy5lY+DO41NrY+hK6
         DhPA==
X-Forwarded-Encrypted: i=1; AJvYcCXB4r+avs0KRmpqvXZn2zd3JeqHIJ50B4qlygtr7bpPjDox5OwJXIsonEYquML7SSahgpih897aJbnP3KMTUQVd6Tvmme/+nhlM
X-Gm-Message-State: AOJu0Yz1G7BBMed7lt4KBesJ8ltDKoPFvWkNERnDy+h4b0tmlkyGv+fM
	zUcs7C3lqDwbjZg+CzJCFNwZIzlUQKLG/1J+Dyj5AzGhzm+CgHVN9FL2Px0rTMKSvTZWCge7Q4w
	Ygidsf4buJfVCzxWYUYMZR4b9yDmRF7EINPadmH+p4mOcmuvUYrunZpn5zg==
X-Received: by 2002:a5d:58e5:0:b0:354:fa7d:dcf5 with SMTP id ffacd0b85a97d-35e83fd7bcdmr1226790f8f.0.1717575383553;
        Wed, 05 Jun 2024 01:16:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6YjKkvVSUFoGcDbJ+SMXSxLwos65XaniDE58RD/+F87WgYW7Zh+OCWAsYEUg9t6JsH1PI+Q==
X-Received: by 2002:a5d:58e5:0:b0:354:fa7d:dcf5 with SMTP id ffacd0b85a97d-35e83fd7bcdmr1226764f8f.0.1717575383238;
        Wed, 05 Jun 2024 01:16:23 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.fritz.box ([2001:9e8:32e6:e600:c901:4daf:2476:80ad])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd0630010sm13739163f8f.76.2024.06.05.01.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 01:16:22 -0700 (PDT)
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
Subject: [PATCH v7 07/13] PCI: Move dev-enabled status bit to struct pci_dev
Date: Wed,  5 Jun 2024 10:15:59 +0200
Message-ID: <20240605081605.18769-9-pstanner@redhat.com>
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
index 572a4e193879..ea590caf8995 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -398,7 +398,7 @@ static void pcim_release(struct device *gendev, void *res)
 	if (this->restore_intx)
 		pci_intx(dev, this->orig_intx);
 
-	if (this->enabled && !this->pinned)
+	if (!this->pinned)
 		pci_disable_device(dev);
 }
 
@@ -441,14 +441,11 @@ int pcim_enable_device(struct pci_dev *pdev)
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
@@ -466,7 +463,7 @@ void pcim_pin_device(struct pci_dev *pdev)
 	struct pci_devres *dr;
 
 	dr = find_pci_dr(pdev);
-	WARN_ON(!dr || !dr->enabled);
+	WARN_ON(!dr || !pdev->enabled);
 	if (dr)
 		dr->pinned = 1;
 }
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8dd711b9a291..04accdfab7ce 100644
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
index 9fd50bc99e6b..e223e0f7dada 100644
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
index 16493426a04f..110548f00b3b 100644
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
2.45.0


