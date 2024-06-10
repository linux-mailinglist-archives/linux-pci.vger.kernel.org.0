Return-Path: <linux-pci+bounces-8525-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 999C7901E5D
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 11:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1C7D1C2031F
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 09:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542F48062E;
	Mon, 10 Jun 2024 09:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iWLaIMIc"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6327FBC3
	for <linux-pci@vger.kernel.org>; Mon, 10 Jun 2024 09:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718011939; cv=none; b=HIeen585Gfqxg14fwj33bZAg7OY6shq3MscBT1oray/kI0VJqGTjJ00J87rey6b/2a9tgHHdyxSQrxzab4xzDZlqiF1J2A6qzvKPMPVoKIjIuyFSpGasTRMRQaTMTgO5WdXTJhcE17imvgI6FDI8oxVJlQQoZqNpiu16N4DHBVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718011939; c=relaxed/simple;
	bh=iGO9d2tDV8jgMXAb9ljo4BmxYhAXls7ncq8pchC9GTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C56WmA3R0Q/WX9PtrnysB7D4RKF8g4QJaLHhickkNn4DZ9YlaZq88hb/kngbXsJ9OIRkedtrT0ku8DVIPgKe6bQ1hg5miAm7FnVo5kpvAJOMocNR/t3GPyWwojnvyUDMydUhxLtk3Cuz3jaxV285ap2w5skjGwrNsA/ueVfOy+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iWLaIMIc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718011936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9WQJKGGQ63IpYpwAqks0j3zwgngy8EFW/hBQkkDLpOw=;
	b=iWLaIMIclbuWbTSK8m3+Z1TQWSCtN/36cPAogobwLNz7KozotLL696gROHcnFtr/YOTxQf
	mJNN7Edwc4zMVxzvpPc4hY8t+Qy8Jsl57TU+Epbq2hpmIclmzM1pZ8UH5ExLgPGU2Am3WQ
	9jqRWBh1oZS65ZzB+7vrfeO08p5rpWY=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-dSi4Z0uFNqu-zIaYbuYeIA-1; Mon, 10 Jun 2024 05:32:14 -0400
X-MC-Unique: dSi4Z0uFNqu-zIaYbuYeIA-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2eae267d112so3093211fa.1
        for <linux-pci@vger.kernel.org>; Mon, 10 Jun 2024 02:32:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718011933; x=1718616733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9WQJKGGQ63IpYpwAqks0j3zwgngy8EFW/hBQkkDLpOw=;
        b=r68m1oikOeskVs4yBWkPQyTAoB21y1gF4gbgfc7/FF21szq48WV/0g3iR2q1RJsPnQ
         u2MQdUtL6lcQcvmIK9/R457Czrk7BqCEalbB6mYn2Up7ns9Q/bDvqcMA0bV6wyOj2X6d
         Rn9MC2crvS0iH/vl703rrAbaBFKTSUzYpzcmVdCz9gB3acRjnaRhObbScgsc3L61geZy
         4mx+hILuB59vqvSVPBzB1tLGaxtxrAeBC7AfV12ILoVwW9kzKP0AeLfO2z6AAx1/mflk
         z+gr8+/rT9sck2qRO1Kzyd9ydEb4XMayc4gTh1ES5izaee7vJEi+NJNehYu2ezu5JtFN
         5YnA==
X-Forwarded-Encrypted: i=1; AJvYcCUY/mtZiXCWR01BOqBsFJaJ18B1xW/CVYqxvbHJP+gHOdv3DLBn6M81UxUztxcFnGcHxoQtVv1pZ5lgqb9PbdbzFxEOVWjlgEVN
X-Gm-Message-State: AOJu0YyQuhbvO9z1x7cu2zxe3z81m3fsSgahaY/InKgC+kvMyK/UxERw
	vkuqiL0hS5F6CI0Mzcst7WA3a6qjHBJcZaOJFKYcZRdO1vNKhXLV1Bnqj8npqJRmbeqQCCUyLGv
	S4ot1CqubSx1AWi78XgpMxfTMWo5cc54B5H1UKNVZjLkGTD1jMtA+fRitXP8CmVm3gg==
X-Received: by 2002:a19:2d0d:0:b0:52c:8857:7631 with SMTP id 2adb3069b0e04-52c88577793mr2123922e87.1.1718011933080;
        Mon, 10 Jun 2024 02:32:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfUeStS0N5eJVU1XtsiGlp2iqafq61SQZHkJWQKYKYv8JTZLy1IaAESVE2BsaioUjz+IfNVg==
X-Received: by 2002:a19:2d0d:0:b0:52c:8857:7631 with SMTP id 2adb3069b0e04-52c88577793mr2123916e87.1.1718011932865;
        Mon, 10 Jun 2024 02:32:12 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f0ce4b62fsm7257545f8f.80.2024.06.10.02.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 02:32:12 -0700 (PDT)
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
Subject: [PATCH v8 13/13] drm/vboxvideo: fix mapping leaks
Date: Mon, 10 Jun 2024 11:31:35 +0200
Message-ID: <20240610093149.20640-14-pstanner@redhat.com>
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

When the PCI devres API was introduced to this driver, it was wrongly
assumed that initializing the device with pcim_enable_device() instead
of pci_enable_device() will make all PCI functions managed.

This is wrong and was caused by the quite confusing PCI devres API in
which some, but not all, functions become managed that way.

The function pci_iomap_range() is never managed.

Replace pci_iomap_range() with the actually managed function
pcim_iomap_range().

Fixes: 8558de401b5f ("drm/vboxvideo: use managed pci functions")
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/gpu/drm/vboxvideo/vbox_main.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/vboxvideo/vbox_main.c b/drivers/gpu/drm/vboxvideo/vbox_main.c
index 42c2d8a99509..d4ade9325401 100644
--- a/drivers/gpu/drm/vboxvideo/vbox_main.c
+++ b/drivers/gpu/drm/vboxvideo/vbox_main.c
@@ -42,12 +42,11 @@ static int vbox_accel_init(struct vbox_private *vbox)
 	/* Take a command buffer for each screen from the end of usable VRAM. */
 	vbox->available_vram_size -= vbox->num_crtcs * VBVA_MIN_BUFFER_SIZE;
 
-	vbox->vbva_buffers = pci_iomap_range(pdev, 0,
-					     vbox->available_vram_size,
-					     vbox->num_crtcs *
-					     VBVA_MIN_BUFFER_SIZE);
-	if (!vbox->vbva_buffers)
-		return -ENOMEM;
+	vbox->vbva_buffers = pcim_iomap_range(
+			pdev, 0, vbox->available_vram_size,
+			vbox->num_crtcs * VBVA_MIN_BUFFER_SIZE);
+	if (IS_ERR(vbox->vbva_buffers))
+		return PTR_ERR(vbox->vbva_buffers);
 
 	for (i = 0; i < vbox->num_crtcs; ++i) {
 		vbva_setup_buffer_context(&vbox->vbva_info[i],
@@ -116,11 +115,10 @@ int vbox_hw_init(struct vbox_private *vbox)
 	DRM_INFO("VRAM %08x\n", vbox->full_vram_size);
 
 	/* Map guest-heap at end of vram */
-	vbox->guest_heap =
-	    pci_iomap_range(pdev, 0, GUEST_HEAP_OFFSET(vbox),
-			    GUEST_HEAP_SIZE);
-	if (!vbox->guest_heap)
-		return -ENOMEM;
+	vbox->guest_heap = pcim_iomap_range(pdev, 0,
+			GUEST_HEAP_OFFSET(vbox), GUEST_HEAP_SIZE);
+	if (IS_ERR(vbox->guest_heap))
+		return PTR_ERR(vbox->guest_heap);
 
 	/* Create guest-heap mem-pool use 2^4 = 16 byte chunks */
 	vbox->guest_pool = devm_gen_pool_create(vbox->ddev.dev, 4, -1,
-- 
2.45.0


