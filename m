Return-Path: <linux-pci+bounces-2164-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A5882DBCE
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jan 2024 15:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D406E1F21831
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jan 2024 14:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D109617735;
	Mon, 15 Jan 2024 14:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OvsBgFDH"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553D71863C
	for <linux-pci@vger.kernel.org>; Mon, 15 Jan 2024 14:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705330058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jIzHvpzkkigfxw83x1LWeciN350K4+qfOeyYElcXkdQ=;
	b=OvsBgFDHBCmsVrBMYQEvJrJ4nR3+j1Kze2Z282eczrlZuNoULV4+QgGwChLoHlCSQMx3lI
	abH4ZXhk4evOY8XQ6PjHb9GlUefEmjZp9IFYvIHE0qVVgIGVPusNXmRlVvtJ9+VeBtAKFQ
	zZyFDPKa1lB/u1dMbU6eIxUBPSV+cRI=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-70WWM5H4Odqon65Tnmrl2g-1; Mon, 15 Jan 2024 09:47:37 -0500
X-MC-Unique: 70WWM5H4Odqon65Tnmrl2g-1
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-5990b589658so74687eaf.1
        for <linux-pci@vger.kernel.org>; Mon, 15 Jan 2024 06:47:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705330056; x=1705934856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jIzHvpzkkigfxw83x1LWeciN350K4+qfOeyYElcXkdQ=;
        b=WlrIK9lTJGdfX7LPPmL2jsYLeSjMDZATYVzHpibvT9go6pee+/WsMJwWeybPprkQFK
         Rp1u8FeuPMYJntTCBZi5Zp2W2WCTO5frxZt2L354gXfopTQcYu++WTN3Gi//NgpBcVLw
         gJFwmufUSNPGnUBNOBHCn0F6braIQ4U5CDsEmPqhW41HJ09r2ThxVIF/AntYtdGKVgOl
         9q8ovhe/lsdN1whahw+tmAwjFvxHd2rt3wNkOoDOD68uxf/px81591ruS1HHOXgj/9hx
         B0+/uPWopO5/eccbYYIHzkJg8UkqQ7Ni9Lmu2A9mWI9qyn+8W5ezeJwPnjUHnfZyqu95
         YwFA==
X-Gm-Message-State: AOJu0YyWiS2WSfvSKlOaqKNVuKJHgbcWS1RlS3CjgRYCbdIIy34SxZul
	0BI2asGe2HTfClLxXNFrYYgFApKs54Dw3nRqWpimWPHxuoDpl+3RhpHDGpgNZikmKte27FG1RZq
	Q0JRtkB9SINZs1g3PgRRx6OClQUb/
X-Received: by 2002:a4a:dd8f:0:b0:598:b2d7:2499 with SMTP id h15-20020a4add8f000000b00598b2d72499mr7707345oov.0.1705330056432;
        Mon, 15 Jan 2024 06:47:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHi7+XsSK011xhs3AvyU5Z7vMLQIc2V6iqOiH+OrjwaSbXs/XiSSr4Ft9JY9kxXHF9woE1zRQ==
X-Received: by 2002:a4a:dd8f:0:b0:598:b2d7:2499 with SMTP id h15-20020a4add8f000000b00598b2d72499mr7707328oov.0.1705330056145;
        Mon, 15 Jan 2024 06:47:36 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ne13-20020a056214424d00b006815cf9a644sm1020720qvb.55.2024.01.15.06.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 06:47:35 -0800 (PST)
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
	linux-pci@vger.kernel.org,
	stable@kernel.vger.org
Subject: [PATCH 10/10] drm/vboxvideo: fix mapping leaks
Date: Mon, 15 Jan 2024 15:46:21 +0100
Message-ID: <20240115144655.32046-12-pstanner@redhat.com>
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

When the managed PCI-API was introduced to this driver, it was falsly
assumed that initializing the device with pcim_enable_device() instead
of pci_enable_device() will make all PCI functions managed.

This is wrong and was caused by the quite confusing devres API for PCI:
The function pci_iomap_range() is never managed.

Replace pci_iomap_range() with the actually managed function
pcim_iomap_range().

Additionally, add a call to pcim_request_region() to ensure exclusive
access to BAR 0.

CC: <stable@kernel.vger.org> # v5.10+
Fixes: 8558de401b5f ("drm/vboxvideo: use managed pci functions")
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/gpu/drm/vboxvideo/vbox_main.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/vboxvideo/vbox_main.c b/drivers/gpu/drm/vboxvideo/vbox_main.c
index 42c2d8a99509..7f686a0190e6 100644
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
@@ -115,12 +114,15 @@ int vbox_hw_init(struct vbox_private *vbox)
 
 	DRM_INFO("VRAM %08x\n", vbox->full_vram_size);
 
+	ret = pcim_request_region(pdev, 0, "vboxvideo");
+	if (ret)
+		return ret;
+
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
2.43.0


