Return-Path: <linux-pci+bounces-5606-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84660896827
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 10:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 397A428A384
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 08:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2075C81AC6;
	Wed,  3 Apr 2024 08:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G4NSZiPe"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDF613AA3B
	for <linux-pci@vger.kernel.org>; Wed,  3 Apr 2024 08:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131668; cv=none; b=GpS/oTlWB06uiYlUwTMHeSfO4hFAcc595KLNp4c0nOSOGqiOvo9fHKKG6FQRbqjnzS8jZIXvQLVs7RobfbSJ1LxSrmibJqw5C8G34v/9XIKXIDFoiPnCfQkZwZQGYQsNWgVOrmgIBpaOrCssX1HQNBkcuqt0BPChpeLAo7hbjOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131668; c=relaxed/simple;
	bh=fRZfn29n+p71TfhVA+U/lx8UE07JAa/x9BZNBbrEgzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o1IAfiJMSPStJXASU0sM0bqITe2YWcYrOZNDprq9yK7ZCiAuH7ZFmfR50WyKmuo/rF2kQBrUaT0GGe4ogbvPWQVLMptOht3wke/9ClTWom8FS20yU+mvsbHS2X82/RSX9k45ax7msbYBV4gkxy32ZxWL+UPn/hsZicY8/GMFGww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G4NSZiPe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712131665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D0nMjCQAiDf49AN80TJHWT8W1hBn+/o753fWI/QiFHA=;
	b=G4NSZiPe6H/tNLmLEPT+Z0hdsSnIM36jgcnbZRuzjnKM0ONMjUWoq6URtHIRPz6OheKQKl
	slOBGwAQ5xl61jleG99YVcpwYmJrPFo4cji7WsYW4g6mc0WyVJ8wWK9gyn8k1lY+wI39+M
	5qi5hTUHMTenp1PExXcnhhtI69pHbBE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-vdkE0hmyP0-21HITqgfxvA-1; Wed, 03 Apr 2024 04:07:37 -0400
X-MC-Unique: vdkE0hmyP0-21HITqgfxvA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-343740ca794so324877f8f.0
        for <linux-pci@vger.kernel.org>; Wed, 03 Apr 2024 01:07:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712131656; x=1712736456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D0nMjCQAiDf49AN80TJHWT8W1hBn+/o753fWI/QiFHA=;
        b=hgjrc1LOt24sPsNmBsQLVYy92oOylmegH80aC8uF2+BmlWF3GnLt3+3AgqWfjfUFrQ
         GYIm5AimqQSr3IawFO1jIixQp5cnyObUrgvKDl1G8EmEg5It/CeEnG30Y2/EsenlNUpm
         +HXkxyNgINALvtlKk0gTSOhKLu7zaSUjI/6WWKfo3wHNYRAXayIAQVvwpnIObWWYy7d8
         PcHLFrAYwLKrsWkeBAyqtD+djzAyYcmdWwIecx1KmBtPtTvijdofgenw2QLzsnNf3SLT
         o0eXsKcVHxv5vhJAQM0Fqi5Zd/Yh0BfUZlOV9weCp7mry29gLEZlj5R/wSntNprGbA5v
         PLdA==
X-Forwarded-Encrypted: i=1; AJvYcCVA83c0FnP2CSADK9sgUpNj9IFk1eIibCuVEaRmpGXxc4jPM4vEEkkPDIVL7giQWrkBVh7ZNfbtieIysYMrdDkS4KY0MSShWqSv
X-Gm-Message-State: AOJu0YwvMMxfUKfymvYx00hMxTFDFj5Kx2CDkpWc19nrBWxw/rRXJ1ea
	DiRmnk2XLGetri2oexCw6P6sNivpbdUsDQUhzNcjTtwPPd216eUPuHi/Z+q5PMoKNMFQ9lDTIPI
	PzQ66YAa/vHSeOwC6ahARnZEf4ST7wp+s+Sr69djmKYoOm++Em1VwcVwz3w==
X-Received: by 2002:a05:600c:1c8f:b0:414:6467:2b1d with SMTP id k15-20020a05600c1c8f00b0041464672b1dmr11645144wms.0.1712131656619;
        Wed, 03 Apr 2024 01:07:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiVKQLb+f1OrEQQkeHaGoynxvE5CB8UQaKuohoK/Tyncy87LGCNAzMSYeiGEEBVT7VkIsd9w==
X-Received: by 2002:a05:600c:1c8f:b0:414:6467:2b1d with SMTP id k15-20020a05600c1c8f00b0041464672b1dmr11645125wms.0.1712131656385;
        Wed, 03 Apr 2024 01:07:36 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id fa14-20020a05600c518e00b004159df274d5sm5504535wmb.6.2024.04.03.01.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 01:07:36 -0700 (PDT)
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
Subject: [PATCH v5 09/10] PCI: Remove legacy pcim_release()
Date: Wed,  3 Apr 2024 10:07:10 +0200
Message-ID: <20240403080712.13986-12-pstanner@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403080712.13986-2-pstanner@redhat.com>
References: <20240403080712.13986-2-pstanner@redhat.com>
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
index 8a643f15140a..3e567773c556 100644
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


