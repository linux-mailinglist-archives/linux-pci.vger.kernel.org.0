Return-Path: <linux-pci+bounces-3154-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 292CC84B6B7
	for <lists+linux-pci@lfdr.de>; Tue,  6 Feb 2024 14:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 939E71F2212E
	for <lists+linux-pci@lfdr.de>; Tue,  6 Feb 2024 13:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1318133408;
	Tue,  6 Feb 2024 13:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sss7d5p4"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556CF1332BC
	for <linux-pci@vger.kernel.org>; Tue,  6 Feb 2024 13:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707226862; cv=none; b=H+ktB2OEQV9C8UeCzJT5eJ6sK5QCQnw4/fBs5DD74SOAlxtoCa431X8o+ZqIplqtFGlVylJxt8bw5kwL+xizIOxm0hYTyJps6r1ptIz+/GKa7Cz2ArYMyCOqTDkXvsPJHvv2iXJXfZVpnm3cw3XC7US9ywMibSyuNlIHh0OR1QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707226862; c=relaxed/simple;
	bh=TeuRzMDENTP+mrbhGHtQfvvCYg0RN9gxYq3N6G/Xkt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qzw+UamWuMt5vCmd3utwQKFrN3UfMMUo5y4dSRRHCcDrxPqt9NUOWzobZoj9oEXedXMCKMWe8aOx7joX1ovfoZ3gz4x8fdPCxUGMO0Jx1vP3PZ1fRgIJVsi5n8yX1g94We1CrKFUs1jzb/D1UA16o2NRW3hxmarn7dqF6X9t+tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sss7d5p4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707226860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nDrBrW1QyBkIZW9XXC7FxnbgE53QwXCFFfi0uuWv0Ls=;
	b=Sss7d5p401UBUDBB08aXESxxXrWS5o5GZro2FxDYHI2X26fe/6N8RJdODgdqqpciX4XEIy
	2yTS5GD4zKMUXDh+XRGayamDGXLBPBbNu2v5UTeD3oCdPQc7sOlZy2E2cazgNHHknp8Tb4
	mDpyEDPjLWbj8uIqFga+Za/BbuQc3l0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-SqVGg1EPNcWVt76BdigqbA-1; Tue, 06 Feb 2024 08:40:56 -0500
X-MC-Unique: SqVGg1EPNcWVt76BdigqbA-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-78313358d3bso261634185a.0
        for <linux-pci@vger.kernel.org>; Tue, 06 Feb 2024 05:40:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707226856; x=1707831656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nDrBrW1QyBkIZW9XXC7FxnbgE53QwXCFFfi0uuWv0Ls=;
        b=afkXeXjowhNCGRsp7WZP0X3hg3NMTM2Tzsyupc9q9lUYtz1WuQlQHu+3wfjQsvw4cc
         mxKuVVBdH9F906Xf9L4p5Zb+LZvou8NOeb7R61DsYgnvRFRCaItGhPvsh46XCK7mpFvN
         b/wVEeIFHzudERxv9FxYK4hw3WoqZCtkjU5j2TDHj9ZM2qVDM5YAvsuVd+BaUsGf4U6A
         HsxmHdy1sCfDt7vR+YHrinZMTx6CpoFW8QtrbeVc+MCOxFVeAe2FbQWm2cf3sxFMbjxM
         Wn9flSuJwI8H1J2mAY7uktMBMlcsI4xjCDPMQ84Q2GzlvsMh5NQng8zr+q/0toL82/pZ
         rh4g==
X-Gm-Message-State: AOJu0YxIuD1p19uC533eFkZOhojYJ5NTuzQowr6q0o+okWcWDMmX1SSC
	VvM6I9b0YBDZMhsqvgszM8RLJGmi/fTtWCShODgzOSOVZ9VwqeJ+FPboGleWoZKQmHhFqJ1KMmS
	zWtH7uIZPxndwaJnt43OmMDCri9NtmfZCxxvzft53XsLg3KnbJ9S/oeeQ0A==
X-Received: by 2002:a05:620a:4722:b0:785:4588:7a09 with SMTP id bs34-20020a05620a472200b0078545887a09mr2762770qkb.3.1707226856085;
        Tue, 06 Feb 2024 05:40:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHV1JhLewj2WzyuV6mJbjtKqCzdBMh7UJ+3tI4Yg38PSz9EUg3UpxjFWaNX43CrNpj4fEFLiA==
X-Received: by 2002:a05:620a:4722:b0:785:4588:7a09 with SMTP id bs34-20020a05620a472200b0078545887a09mr2762751qkb.3.1707226855798;
        Tue, 06 Feb 2024 05:40:55 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXY73u7g+juzT4qNhBv3adaHj4fe+28SURqOK6AMlIWi7SNnZKGhEb2SSunmcFOciqesjrdctJWePLgX61nFQtGT5DaHz6Drpqx3G76kNq/mJa5K3DoJrAWl6f6g4DFCZF0ILo9JChZ4/clq2pplqhGRQMKv+BDBiNhFo86TN0jVsQ0QNTSA6pXfzo/lV39SDF7eXdr0HLEdQW8DLwItLzDNvPVqbSGxXWzQmvii1m9FK8AvubZrpLmdghe10es0xS+rE+5D09CNNgsmtT/eZjDpF1Pbzdgh0a3oxdS5CUX+UBfXjFLQWbZ8iPUzFmXBwQhDDVav0ymM1W7urvifsSe2K0KvynAiVS3TjOJqMuTG/VdoSvxMAAzsrZG9Gk6tkYfCuMm
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id vu4-20020a05620a560400b0078544c8be9asm903791qkn.87.2024.02.06.05.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 05:40:54 -0800 (PST)
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
Subject: [PATCH v3 09/10] PCI: Remove legacy pcim_release()
Date: Tue,  6 Feb 2024 14:39:55 +0100
Message-ID: <20240206134000.23561-11-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206134000.23561-2-pstanner@redhat.com>
References: <20240206134000.23561-2-pstanner@redhat.com>
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
2.43.0


