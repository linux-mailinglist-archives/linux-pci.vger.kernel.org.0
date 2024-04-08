Return-Path: <linux-pci+bounces-5869-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F055889BAAD
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 10:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A73B82816D6
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 08:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F904F616;
	Mon,  8 Apr 2024 08:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fj/+Twbp"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960FA4F1E2
	for <linux-pci@vger.kernel.org>; Mon,  8 Apr 2024 08:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712565895; cv=none; b=epCDoAMnSlieET8lVnCmqzhupOstGRmrVlxrxZOLT11UqkbMpubzyOZ863KGHj7AuB4NftBi+p4w1kTnLHBkdfIjXlcJ52C+VR0aKiOHWrXsBsgX+4DfO0EGp6eTCnxLEJXzFQhztcHwrgpOFIamdnoYGY+wYZvPIyZ5FFju+AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712565895; c=relaxed/simple;
	bh=OSX8DiwC7JJUNzRzeW1OOkPWOeyv5OusvgjKcUnS2qg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m+9VcvX/5FNj/2UdHHbR0w5wTgcUJwgBbjy8JX2Ys192VzS74P4CF51ORNhITT1Q2OGVfWx7BieRPz55UHOEDrW7XhW31mGKiUTi5UntQxjZqCS2DUgzzJAIGxCQsNpbkixTdZF6t6D4rGGMqKJlMIXVp/NTwMjETYIGyMeqgS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fj/+Twbp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712565892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oIKnJtHF26OJHg4kpBO8DHHyo5/AIkRLYVzYG0l0EPg=;
	b=fj/+TwbpMKlDFJVBxOZOear4zKdkNRYVu1MZp0ddNP/vyBlKUAUelr2NRdFZkCI9UeaseK
	8K1Ri/7tJez8jKaQqX28zJlV48hfJjRL9fvc4x7sU/PUZu9Q0ots/DCc7YquXTsTQ/MduF
	bKJM4amv5/afZvLfrc0oqCdJfcRPgOQ=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-gE_cLU35PvKxbjxh5dDQ3Q-1; Mon, 08 Apr 2024 04:44:49 -0400
X-MC-Unique: gE_cLU35PvKxbjxh5dDQ3Q-1
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-7dba4d44c1dso582020241.0
        for <linux-pci@vger.kernel.org>; Mon, 08 Apr 2024 01:44:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712565888; x=1713170688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oIKnJtHF26OJHg4kpBO8DHHyo5/AIkRLYVzYG0l0EPg=;
        b=tXVJk6KYj/lrPt0fZyH64lSia10pmkYnplb34IJ9sek88ZiSZYJJWPixB5eFln0X0d
         Qmk6LQHd8ukNeRFo5HnYyMg9Yugj5zXRWEtkmVoCQhU3F5rK7LzrzDtmiNxEuL0YEunT
         EA4NT1WvyifN9X8FAqfbRCMY6MRcawJsGHRVJfL40JCx9/yOYRhq+PQ7xT/Wy8czQeBH
         OJidOq+sLmNbyN8J6XVb7Udu7v+zkDo8ZiWM57SN1q8gFwOJuntjTCLxsGWmzwnXNnmI
         qBkJEXmzE6/cJ9/8S6aGhxsUaI0lDrTyApuIbU+sc3pehcLjc3Nz2cn16akMV5BwQPfm
         Vdlw==
X-Forwarded-Encrypted: i=1; AJvYcCV386cPHdvZUgzbo8mQeayL9+9L8+NHPwm0THq38JuLNRdip7c7oqobR8mP/jG8/qCzuWcrjIOKwrFcOBVzrjuqqW3kX1mpveKq
X-Gm-Message-State: AOJu0Yx1PEGpLorTNrqDqLoVqmKM0tr9nSHpHPFSi8of8fZ1ichEzS8F
	/eI2Lf9UBq7M9GSqKdy1Z8l7ILnnC8HcBhjWZJjAT2v+OoaWuYglO5CkDTqmdz6ehR5WToH0F5c
	evtrlvh3OprebBiiWUIZwxXal3SMRbxvqutHJEpCL+NC1y0r/hqI6dGTXzIzq1qzAIA==
X-Received: by 2002:a67:f610:0:b0:479:dedd:565f with SMTP id k16-20020a67f610000000b00479dedd565fmr4684472vso.2.1712565888607;
        Mon, 08 Apr 2024 01:44:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHL+VVRQtoyNoPL7BOIfq0nBVbWMHsJxHqXPuBD7jjNvaEZvxqdDMSuVChpXM2urhBCQM1pWA==
X-Received: by 2002:a67:f610:0:b0:479:dedd:565f with SMTP id k16-20020a67f610000000b00479dedd565fmr4684452vso.2.1712565888186;
        Mon, 08 Apr 2024 01:44:48 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id oo15-20020a05620a530f00b0078d54e39f6csm2036989qkn.23.2024.04.08.01.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 01:44:47 -0700 (PDT)
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
Subject: [PATCH v6 09/10] PCI: Remove legacy pcim_release()
Date: Mon,  8 Apr 2024 10:44:21 +0200
Message-ID: <20240408084423.6697-10-pstanner@redhat.com>
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

Thanks to preceding cleanup steps, pcim_release() is now not needed
anymore and can be replaced by pcim_disable_device(), which is the exact
counterpart to pcim_enable_device().

This permits removing further parts of the old devres API.

Replace pcim_release() with pcim_disable_device().
Remove the now surplus function get_pci_dr().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/devres.c | 49 +++++++++++++++++++-------------------------
 1 file changed, 21 insertions(+), 28 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index b81bbb9abe51..1229704db2dc 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -463,48 +463,41 @@ int pcim_intx(struct pci_dev *pdev, int enable)
 	return 0;
 }
 
-static void pcim_release(struct device *gendev, void *res)
+static void pcim_disable_device(void *pdev_raw)
 {
-	struct pci_dev *dev = to_pci_dev(gendev);
-
-	if (!dev->pinned)
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
+	if (ret != 0)
+		devm_remove_action(&pdev->dev, pcim_disable_device, pdev);
 
-	return rc;
+	return ret;
 }
 EXPORT_SYMBOL(pcim_enable_device);
 
-- 
2.44.0


