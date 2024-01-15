Return-Path: <linux-pci+bounces-2161-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E5682DBC3
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jan 2024 15:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 874B91C21C7A
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jan 2024 14:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983B91773B;
	Mon, 15 Jan 2024 14:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MY9KF10d"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208A317C8D
	for <linux-pci@vger.kernel.org>; Mon, 15 Jan 2024 14:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705330050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+s18P47JH053YQ7YJMWBY/f4LBPoNabsZFa7u4jw7Zc=;
	b=MY9KF10dJJriNnA+ntXlNTyECtuyfTx/iWDaWF94NhZBICXx1jE+Y0rLPMUKemMUmUyrff
	cTtJab0jF3hOPl8yUnylVIwPFkTbNqOTRA4PveHaJDtbcEUGzZoEFIKCW4Xt12rwks6O0X
	ckr+aClP7z21CR7afbA6rS8/q8OCFUM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-kS2EzPqSNOGXSN0uHfX6_w-1; Mon, 15 Jan 2024 09:47:29 -0500
X-MC-Unique: kS2EzPqSNOGXSN0uHfX6_w-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-429d02a62f8so5664311cf.1
        for <linux-pci@vger.kernel.org>; Mon, 15 Jan 2024 06:47:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705330048; x=1705934848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+s18P47JH053YQ7YJMWBY/f4LBPoNabsZFa7u4jw7Zc=;
        b=ac1iwFyPxpic38bBtCLEXXhYSMteQJjbty2/HSck0JHXpdO+aP6k0YqLl1TjVY1gxg
         zYKDnVZ5yNc12sQMMipaaJzKrGvid3oWccZrA3GxM58Zdp7f5UkJoFki6hmbGBon4dDe
         Rmf5iqetqQSQfMNOqBR9+65xisknr4EN77vgcAGxcFI6zX+1dciRCce+LTdmAQ3H2a3s
         rjkEN2IMYQYtXB4w7FFVnTMIJc6v0FORP5vlRWA3FUJ96sMAtz3QO9saTusapRd6Eae+
         1+0330tI/odpL5vXyRQvYTapg0pCQuTEbwp3y5B/zSJ3yPXKQy6sqUG8a77fnWraesvU
         7u5Q==
X-Gm-Message-State: AOJu0Yyh2HS0GFJZbOITIj+1HGd45egukBd4bCiUw/+BnFnhEjokeZ9X
	xutszJ9LFvSa3t5OGc8L+2A0SlsX2zpV1gP/nSj8dMQZ1XLGm1665/NlzInVyTI5f40/LhLG+IY
	RM+Yf3bCLx2wctyw1mRxMhAB0A3oe
X-Received: by 2002:a05:6214:20ca:b0:681:555c:8e64 with SMTP id 10-20020a05621420ca00b00681555c8e64mr6594572qve.6.1705330048589;
        Mon, 15 Jan 2024 06:47:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIFNFH3t9YBVxCpLVDR4bI9FQ3w+V6Y/t4RZxhNK4CjYtj3KjB51ezdoAU+KVMDwPukDm1tQ==
X-Received: by 2002:a05:6214:20ca:b0:681:555c:8e64 with SMTP id 10-20020a05621420ca00b00681555c8e64mr6594555qve.6.1705330048349;
        Mon, 15 Jan 2024 06:47:28 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ne13-20020a056214424d00b006815cf9a644sm1020720qvb.55.2024.01.15.06.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 06:47:28 -0800 (PST)
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
Subject: [PATCH 07/10] pci: devres: give mwi its own callback
Date: Mon, 15 Jan 2024 15:46:18 +0100
Message-ID: <20240115144655.32046-9-pstanner@redhat.com>
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

managing mwi with devres can easily be done with its own callback,
without the necessity to store any state about it in a device-related
struct.

Remove the mwi state from the devres-struct.
Make the devres-mwi functions set a separate devres-callback.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/devres.c | 23 +++++++++++------------
 drivers/pci/pci.h    |  1 -
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index de8cf6f87dd7..911c2037d9fd 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -378,24 +378,26 @@ void __iomem *devm_pci_remap_cfg_resource(struct device *dev,
 }
 EXPORT_SYMBOL(devm_pci_remap_cfg_resource);
 
+static void __pcim_clear_mwi(void *pdev_raw)
+{
+	struct pci_dev *pdev = pdev_raw;
+
+	pci_clear_mwi(pdev);
+}
+
 /**
  * pcim_set_mwi - a device-managed pci_set_mwi()
- * @dev: the PCI device for which MWI is enabled
+ * @pdev: the PCI device for which MWI is enabled
  *
  * Managed pci_set_mwi().
  *
  * RETURNS: An appropriate -ERRNO error value on error, or zero for success.
  */
-int pcim_set_mwi(struct pci_dev *dev)
+int pcim_set_mwi(struct pci_dev *pdev)
 {
-	struct pci_devres *dr;
-
-	dr = find_pci_dr(dev);
-	if (!dr)
-		return -ENOMEM;
+	devm_add_action(&pdev->dev, __pcim_clear_mwi, pdev);
 
-	dr->mwi = 1;
-	return pci_set_mwi(dev);
+	return pci_set_mwi(pdev);
 }
 EXPORT_SYMBOL(pcim_set_mwi);
 
@@ -405,9 +407,6 @@ static void pcim_release(struct device *gendev, void *res)
 	struct pci_dev *dev = to_pci_dev(gendev);
 	struct pci_devres *this = res;
 
-	if (this->mwi)
-		pci_clear_mwi(dev);
-
 	if (this->restore_intx)
 		pci_intx(dev, this->orig_intx);
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 3d9908a69ebf..667bfdd61d5e 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -811,7 +811,6 @@ static inline pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
 struct pci_devres {
 	unsigned int orig_intx:1;
 	unsigned int restore_intx:1;
-	unsigned int mwi:1;
 };
 
 struct pci_devres *find_pci_dr(struct pci_dev *pdev);
-- 
2.43.0


