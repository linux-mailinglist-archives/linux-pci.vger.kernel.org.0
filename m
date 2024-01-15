Return-Path: <linux-pci+bounces-2159-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A3C82DBBD
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jan 2024 15:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40147B209CF
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jan 2024 14:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB96175BC;
	Mon, 15 Jan 2024 14:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C0HHSfn0"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4020179AF
	for <linux-pci@vger.kernel.org>; Mon, 15 Jan 2024 14:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705330045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RO0mZDJz5TK909+4LedW3qKsNhM3MJg2yInHziL/J8s=;
	b=C0HHSfn0qZzHu/IAqsZ53H2L3xXeNpzULGhL2STwLlECph0/nohD/e/tN1QnCM5gnl+tYC
	QWURZVZEpS5SR9UICD2C07LJjikEbecsEFxvuId1OmdoPMI97ofhXR8ROJQ0gu7uOUWyFe
	9jJJL/ZYEWuzgBIKanbmNlPDHedB6Iw=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-R5R9hMoON1yhaoHrPa6NwA-1; Mon, 15 Jan 2024 09:47:24 -0500
X-MC-Unique: R5R9hMoON1yhaoHrPa6NwA-1
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-4b7612db75fso197443e0c.0
        for <linux-pci@vger.kernel.org>; Mon, 15 Jan 2024 06:47:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705330043; x=1705934843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RO0mZDJz5TK909+4LedW3qKsNhM3MJg2yInHziL/J8s=;
        b=Ih7ss2a4Z+O2tcFNxEQSqqQL6LqK8/LUeecfJ1FvWL4US7kurwIDXzg+7MHg5I249W
         oOyVinPFWWD+OSeOSWcjIxLpRrcL7cVb3hZ97a+1UM12C76/AOZU0oS5hYy9QgBAy8Sg
         YUkxGqo+SMI8dUUa9o0mIR9fVPxuTdZXKWohBmVCzK5N2cSozEzPv7XC7bRShhjE4E1o
         qpsMXIX2FpHaQ+AwwVDt6MVbjRzIK0DcCRYwQzptbA5vDMYtHGTBiTL25YnHiXuQtZoS
         Ci0xxtqn93M0hRsZUmnWhAolkaGv9wG1xIfo9/51RCTE5eI+d5nFH0XxGqz6OhTto/Yt
         5m/w==
X-Gm-Message-State: AOJu0Yy1k5O5kEQ9tmbF1BTUc3TwxBe9Zcb6uSpJgMzFU0AKFpHBkgTh
	mwb0+p4yPdN5rQgdwZfqVxHDJB5iFBDUZMJt5zjtKADvifc3ldrlgr770a7H05ZkZ66d0adRCm6
	LgT3bu/tlNoHryZgp6Q1T0pL6tjgf
X-Received: by 2002:a05:6122:200a:b0:4b6:e3fa:7599 with SMTP id l10-20020a056122200a00b004b6e3fa7599mr4678993vkd.0.1705330043470;
        Mon, 15 Jan 2024 06:47:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6fwAzY9p/B8Ojoob7vJlPit+LMYVgGiOaxw4BacA7x0sKclRH2EeCFfpGqDBHtgs3IUs2RQ==
X-Received: by 2002:a05:6122:200a:b0:4b6:e3fa:7599 with SMTP id l10-20020a056122200a00b004b6e3fa7599mr4678977vkd.0.1705330043173;
        Mon, 15 Jan 2024 06:47:23 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ne13-20020a056214424d00b006815cf9a644sm1020720qvb.55.2024.01.15.06.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 06:47:22 -0800 (PST)
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
Subject: [PATCH 05/10] pci: move enabled status bit to pci_dev struct
Date: Mon, 15 Jan 2024 15:46:16 +0100
Message-ID: <20240115144655.32046-7-pstanner@redhat.com>
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

The bit describing whether the PCI device is currently enabled is stored
in the devres-struct. Besides this struct being subject of a cleanup
process, the device-struct is in general the right place to store this
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
index 1e5cf950775d..bf957f0bc5ac 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -411,7 +411,7 @@ static void pcim_release(struct device *gendev, void *res)
 	if (this->restore_intx)
 		pci_intx(dev, this->orig_intx);
 
-	if (this->enabled && !this->pinned)
+	if (!this->pinned)
 		pci_disable_device(dev);
 }
 
@@ -456,14 +456,11 @@ int pcim_enable_device(struct pci_dev *pdev)
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
@@ -481,7 +478,7 @@ void pcim_pin_device(struct pci_dev *pdev)
 	struct pci_devres *dr;
 
 	dr = find_pci_dr(pdev);
-	WARN_ON(!dr || !dr->enabled);
+	WARN_ON(!dr || !pdev->enabled);
 	if (dr)
 		dr->pinned = 1;
 }
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 66639dd754c7..0fb9e7bb0e43 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1953,6 +1953,9 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
 	u16 cmd;
 	u8 pin;
 
+	if (dev->enabled)
+		return 0;
+
 	err = pci_set_power_state(dev, PCI_D0);
 	if (err < 0 && err != -EIO)
 		return err;
@@ -1967,7 +1970,7 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
 	pci_fixup_device(pci_fixup_enable, dev);
 
 	if (dev->msi_enabled || dev->msix_enabled)
-		return 0;
+		goto success_out;
 
 	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
 	if (pin) {
@@ -1977,6 +1980,8 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
 					      cmd & ~PCI_COMMAND_INTX_DISABLE);
 	}
 
+success_out:
+	dev->enabled = true;
 	return 0;
 }
 
@@ -2146,6 +2151,9 @@ static void do_pci_disable_device(struct pci_dev *dev)
 {
 	u16 pci_command;
 
+	if (!dev->enabled)
+		return;
+
 	pci_read_config_word(dev, PCI_COMMAND, &pci_command);
 	if (pci_command & PCI_COMMAND_MASTER) {
 		pci_command &= ~PCI_COMMAND_MASTER;
@@ -2153,6 +2161,7 @@ static void do_pci_disable_device(struct pci_dev *dev)
 	}
 
 	pcibios_disable_device(dev);
+	dev->enabled = false;
 }
 
 /**
@@ -2180,12 +2189,6 @@ void pci_disable_enabled_device(struct pci_dev *dev)
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
index 7c2181677760..dbb76a3fb0e4 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -809,7 +809,6 @@ static inline pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
  * when a device is enabled using managed PCI device enable interface.
  */
 struct pci_devres {
-	unsigned int enabled:1;
 	unsigned int pinned:1;
 	unsigned int orig_intx:1;
 	unsigned int restore_intx:1;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 641ee30f7d2d..a356bdcc14cc 100644
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
2.43.0


