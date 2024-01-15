Return-Path: <linux-pci+bounces-2160-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6610382DBC0
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jan 2024 15:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0014C1F210C3
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jan 2024 14:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F9D1773A;
	Mon, 15 Jan 2024 14:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LpQDTiZm"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A388217BBA
	for <linux-pci@vger.kernel.org>; Mon, 15 Jan 2024 14:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705330047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k3vu21hkZlZsapFSJtp8nhKKQ/3OZTkpZfYIme9+49k=;
	b=LpQDTiZm97xEslMQOhTDTPobnD0yYQjw01Kb2E7mUDTTX5FW0YMlnZQGkcpCf+9AkzmqEO
	BANRy9ZpyvqyH85KZeSsesxqvvr6AQhyI+wym51yRRs2dKHpbEU633tedY5g4g1WTgExjz
	UGMReYpTTw4WB/L8KltNVyLmhNTKmbI=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-hrjB_QY6PA-UrlL9KO4iDw-1; Mon, 15 Jan 2024 09:47:26 -0500
X-MC-Unique: hrjB_QY6PA-UrlL9KO4iDw-1
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-4b73aaf6022so137336e0c.1
        for <linux-pci@vger.kernel.org>; Mon, 15 Jan 2024 06:47:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705330046; x=1705934846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k3vu21hkZlZsapFSJtp8nhKKQ/3OZTkpZfYIme9+49k=;
        b=BKaxrQyKOJmIYhycOHgfH5hOi2/erk2uvxuZgLWByHwtAitiAquKcQL3g7eGo4csZl
         K/K3udJHwOixImos/DhnasEnZyzNEddpKKQE1AZdN2oD76XLE2ubnu0sXy5ttMoFUZEa
         9aqBfGAf7O0Qn/HI8DlZMTIt7EAF0qjRQMn3aOAbu+HliKqUfVD8S0T2iVHyEds4v8uh
         g1cj06N7qTYVDMMa4WFjmALNTuOwujjgiZ4KzYoZEMc+oQbWL8Nn1eOAx4MpefH2Bkk6
         gDeb28XvyxyuPeCUBNdcQDUVRvE75VlfY1nLhcnqFeHJqaOXHq18QyslDPDmrfi4szjX
         xTYA==
X-Gm-Message-State: AOJu0YywhtKFyq/h/2T1ms4z4rO9dzMJxfbLzvUmRecmVNbteogxlB54
	kGeFMkqjIHNbJCHK5HfoRwq+WX2Q54Uld2iZRVfB0t2PaOzjUxH33VeJiuq5QTlsiKMOorhjje+
	G94VTG8lSpMQnjoxn5sBUAvW8evZN
X-Received: by 2002:a05:6122:2886:b0:4b7:32ac:f4e5 with SMTP id fl6-20020a056122288600b004b732acf4e5mr4682345vkb.1.1705330046118;
        Mon, 15 Jan 2024 06:47:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEl3g0muu7xD/Tj+Zr9TyY8gOWhOJboojbdmamx1smFfYvzduqw18AZ9+hpq2S3HXA+drCMKA==
X-Received: by 2002:a05:6122:2886:b0:4b7:32ac:f4e5 with SMTP id fl6-20020a056122288600b004b732acf4e5mr4682321vkb.1.1705330045850;
        Mon, 15 Jan 2024 06:47:25 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ne13-20020a056214424d00b006815cf9a644sm1020720qvb.55.2024.01.15.06.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 06:47:25 -0800 (PST)
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
Subject: [PATCH 06/10] pci: move pinned status bit to pci_dev struct
Date: Mon, 15 Jan 2024 15:46:17 +0100
Message-ID: <20240115144655.32046-8-pstanner@redhat.com>
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

The bit describing whether the PCI device is currently pinned is stored
in the PCI devres struct. To clean up and simplify the pci-devres API,
it's better if this information is stored in the pci_dev struct, because
it allows for checking that device's pinned-status directly through the
device struct.
This will later permit simplifying  pcim_enable_device().

Move the 'pinned' boolean bit to struct pci_dev.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/devres.c | 14 ++++----------
 drivers/pci/pci.h    |  1 -
 include/linux/pci.h  |  1 +
 3 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index bf957f0bc5ac..de8cf6f87dd7 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -411,7 +411,7 @@ static void pcim_release(struct device *gendev, void *res)
 	if (this->restore_intx)
 		pci_intx(dev, this->orig_intx);
 
-	if (!this->pinned)
+	if (!dev->pinned)
 		pci_disable_device(dev);
 }
 
@@ -469,18 +469,12 @@ EXPORT_SYMBOL(pcim_enable_device);
  * pcim_pin_device - Pin managed PCI device
  * @pdev: PCI device to pin
  *
- * Pin managed PCI device @pdev.  Pinned device won't be disabled on
- * driver detach.  @pdev must have been enabled with
- * pcim_enable_device().
+ * Pin managed PCI device @pdev. Pinned device won't be disabled on driver
+ * detach.  @pdev must have been enabled with pcim_enable_device().
  */
 void pcim_pin_device(struct pci_dev *pdev)
 {
-	struct pci_devres *dr;
-
-	dr = find_pci_dr(pdev);
-	WARN_ON(!dr || !pdev->enabled);
-	if (dr)
-		dr->pinned = 1;
+	pdev->pinned = true;
 }
 EXPORT_SYMBOL(pcim_pin_device);
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index dbb76a3fb0e4..3d9908a69ebf 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -809,7 +809,6 @@ static inline pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
  * when a device is enabled using managed PCI device enable interface.
  */
 struct pci_devres {
-	unsigned int pinned:1;
 	unsigned int orig_intx:1;
 	unsigned int restore_intx:1;
 	unsigned int mwi:1;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index a356bdcc14cc..2f6f44991003 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -368,6 +368,7 @@ struct pci_dev {
 					   functional, and D3 being off. */
 	u8		pm_cap;		/* PM capability offset */
 	unsigned int	enabled:1;	/* Whether this dev is enabled */
+	unsigned int	pinned:1;	/* Whether this dev is pinned */
 	unsigned int	imm_ready:1;	/* Supports Immediate Readiness */
 	unsigned int	pme_support:5;	/* Bitmask of states from which PME#
 					   can be generated */
-- 
2.43.0


