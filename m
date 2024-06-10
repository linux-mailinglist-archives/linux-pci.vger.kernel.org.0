Return-Path: <linux-pci+bounces-8524-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E85E901E59
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 11:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF3911F2246C
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 09:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1D77FBAE;
	Mon, 10 Jun 2024 09:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RGNoCSzM"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813387D40D
	for <linux-pci@vger.kernel.org>; Mon, 10 Jun 2024 09:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718011937; cv=none; b=RFtv9roRV6W8cliKxyrdZw604w3iaA9Z+rEv+Cnfbw+YnP/pYUkqxBEVXH79yoTpT3dcpXZJHD0lGsn3mqLYUPG1nrehKkcbQjDh/SJ70m7CRssrdw2znLjzmIARhw6FodPJT3+VLemMbuvkzPiSIBqFM0zUhMy6hF4vOZ2t6Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718011937; c=relaxed/simple;
	bh=60by0ZGSmu26TnhpKT16jO9iZCuapVeU+qpbrVig91Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IODqblE+wfUp0rKc41q/Cm7whQOJisE4M3Ym39jCIwgaJjl/pqvV1NTwnK00L3tA+i2zNEMY5KN5joT3sHKwS/CHeklJKVsX/vCVUwtodVmcciXvqFnj71xTypI21OgBUQE5YxO9jDGn38LWweKkQCVHLO6ODcc7k4AyEDVrS+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RGNoCSzM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718011934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uYVaQkWqZSrx/i/zySmVb2SXxUjFViRl1HRUPLR6DN4=;
	b=RGNoCSzMMn6mkqtP4O0Uva+/0JBlaLzEsHFAFA9QB24t1Y1l2pNzkBSvdCwRVrh1EwYeFR
	EXIBFJ5U1+N4SP5UVHYuy8cXSLFIXKcxtfPwIyFGXFqIrdD01XBTMypbFon+lpHxoUe22l
	v8wyFwvDwGX9CDtORmAGCn7+KeUO1i8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-hHSxm22rOcCRqHqROPEhpw-1; Mon, 10 Jun 2024 05:32:12 -0400
X-MC-Unique: hHSxm22rOcCRqHqROPEhpw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4217e21bcd4so1990685e9.2
        for <linux-pci@vger.kernel.org>; Mon, 10 Jun 2024 02:32:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718011931; x=1718616731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uYVaQkWqZSrx/i/zySmVb2SXxUjFViRl1HRUPLR6DN4=;
        b=dyzY0gCfeXbU3Kt17zmrwfgTdjSo3eE7EISU/pZOfgDAaWjOhyZQVkcedjWRflS3E3
         g4CzHzaEg7T+mt9SKxrs4l2tWdynXX6UAFgAnLBTX8GKcJE9RSaaiQ2pGxfs1tVB2dxm
         qkI3UYNkDPmKsNLoy7N3F7P1wPhdHmUvBcoVBrorb3tqkdwfB00bbO13FaNgfSjMj10y
         f5E5gwZGrF2i4BDBc7Ss3P0hOmhex8vJl2/uC4wINpxWvjJmtZgXeQWI+ZhzSgDHldLx
         abQCHhTJbvPlvftj+kckNcBdS+IXhM6bwlX3DUKKYbav+60HRLKpu/2qLp4eWIdYNtQr
         9MbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaVHQSCVZxO/mwpJBaaGIewDGWOcX6oZE8woswkUTGYm6GPzW2aab48dXdO3SdJQK16Qpkyg/2PZ2VNXqU/ll9qCv2d0Zk/SKh
X-Gm-Message-State: AOJu0YwHEz91SV8V/tOaVFh/zcmTEAxTOQNI8dEf34sJ1J2OIo8xFWFe
	FT7aaApHrE2c9vAV/khjtMdM9n+8TenwTXFVO08M7fpKAOQk/A1BeiC6cV75HxXIf7w2wJ4L4Ey
	uoUDRrnBpQibs7RVAD2k3T7V2LYNdDNFnvAStgfMwy4zCPQ8aH0/eSjvsAg==
X-Received: by 2002:a05:6000:1ac7:b0:35f:229e:9c6d with SMTP id ffacd0b85a97d-35f229e9eafmr2316699f8f.6.1718011931038;
        Mon, 10 Jun 2024 02:32:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHC5EISwyWHtH2eTnirfsjXBBnu5C7SW4kxtaGwTzx8vXOIkqsWX8QFdvGZWKIwJ9P9VX916w==
X-Received: by 2002:a05:6000:1ac7:b0:35f:229e:9c6d with SMTP id ffacd0b85a97d-35f229e9eafmr2316683f8f.6.1718011930743;
        Mon, 10 Jun 2024 02:32:10 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f0ce4b62fsm7257545f8f.80.2024.06.10.02.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 02:32:10 -0700 (PDT)
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
Subject: [PATCH v8 11/13] PCI: Remove legacy pcim_release()
Date: Mon, 10 Jun 2024 11:31:33 +0200
Message-ID: <20240610093149.20640-12-pstanner@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240610093149.20640-1-pstanner@redhat.com>
References: <20240610093149.20640-1-pstanner@redhat.com>
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
index 0bb144fdb69b..e92a8802832f 100644
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


