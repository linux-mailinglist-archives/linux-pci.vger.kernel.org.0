Return-Path: <linux-pci+bounces-8729-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2657906CEC
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 13:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC9821C2242A
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 11:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99ECB149E0A;
	Thu, 13 Jun 2024 11:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L3muyuzt"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4256149C4C
	for <linux-pci@vger.kernel.org>; Thu, 13 Jun 2024 11:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279464; cv=none; b=Evl91H5pu/sGc7e8MPjImf826WVCNILJflc9oCzXnyB0vfsnXFObup3W0npUEYQoLJvAiADyvGF7mN3PGi1hZbvE2pQq1Y5kPT1UBqb27GXfy4YLnLk4WVlTEJeD2GofEjcdDYvE4HxY5M7AprpclR3FCJoE/J7e2yjMByM++hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279464; c=relaxed/simple;
	bh=iGO9d2tDV8jgMXAb9ljo4BmxYhAXls7ncq8pchC9GTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n8vmr/dnBK3qiBveU1jV/fUqDdUczZlFjNgfOIQgMBmeUUrByw/z8GSXFG+v7+9udrgEYwjM5cZjt5NOQ8tJn5cEr1bJmnxjfB9K8OQSD4ydmVUP8nNlzvy246ocUQ9OD6WA48Jo/EwFTDaXa1+Aydl0JFGg5hKA9lpPG87QYeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L3muyuzt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718279462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9WQJKGGQ63IpYpwAqks0j3zwgngy8EFW/hBQkkDLpOw=;
	b=L3muyuztZ6LOEQvWQlHONgETqgjo3k/aAc7Hkw51QCOKMQRB6xTYwJBeYOPUK6MEZ6KPTu
	WfpkBc7PLblzJFlRiIro7q6s5FL9MZzzvKWQNOJfLWy40Yb0zOltrxBgC6a7h7YoEpAeiX
	l7alLtbMrwvA79dPWIvtuQ2ECHo/ozQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-zf97ePQ4O_K6OOp-MG8BGQ-1; Thu, 13 Jun 2024 07:51:00 -0400
X-MC-Unique: zf97ePQ4O_K6OOp-MG8BGQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-35f184b67ceso79928f8f.2
        for <linux-pci@vger.kernel.org>; Thu, 13 Jun 2024 04:51:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718279459; x=1718884259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9WQJKGGQ63IpYpwAqks0j3zwgngy8EFW/hBQkkDLpOw=;
        b=oewnUPWyQNOdHaCaXTBWtBvzUoBKjtsJq0Zlg4UI8JjKd2vLKnFMxfgKqfqEQH5CKH
         DoUeA4iaTBwyRqexUoMZwgCL7+flK8dn11cfmtWwPdVG2ryyojsluKP2QfePP5YuJH1A
         dnOdffiMZY2sFFgnb/0yvlJ8m5YijIF6VGZXvF1p2cQSj5xjZFdqgIaG1EekktM1mNcm
         WJmyQOISrEwHi7VLzUQPYojUq8Ig54mkEvsYNVIWQSJc5XlZMT7/ZQIDuSL0d1NHvfcQ
         3zooN9XAk7/NvmyY24ERdIed6hCuFOm+s37KSMHjQw4GDYGuJfwy1TjVpQT799Jimqv2
         RXhg==
X-Forwarded-Encrypted: i=1; AJvYcCXf1RZPhPHI1Od9mYng8W87MBDeRj0iujYGg41KrmU2f3uFVQPVUtfm4TQYKWeB2epKJcbWywqA4YQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzro1yRs7ta/wx/p4QccyLIrR+Z0DP5wPqIoPBS19TFZA+EWsPW
	P5LpqVRbj97CP3xh2h0EI3D2T9Br83nopyjoH01a7IZhVmwnUjmrAFwZPwjq5SPxDNjBzR6jAoH
	X1WWGm3zwkHrsxACZAS5AHXjS6K3H83gWDysqpyPDorNVWrKYM7U9oDU9/Q==
X-Received: by 2002:a5d:6da4:0:b0:35f:2584:7714 with SMTP id ffacd0b85a97d-36079a55d96mr164403f8f.5.1718279459402;
        Thu, 13 Jun 2024 04:50:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElWKl4RSn/FE/WxBDl2/l3vU5Ab6FM43jl4nz2rwpq5A2nGMHBM+4ko0mCUeuR7gvoXMoyQA==
X-Received: by 2002:a5d:6da4:0:b0:35f:2584:7714 with SMTP id ffacd0b85a97d-36079a55d96mr164394f8f.5.1718279459138;
        Thu, 13 Jun 2024 04:50:59 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607509c883sm1510620f8f.29.2024.06.13.04.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 04:50:58 -0700 (PDT)
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
Subject: [PATCH v9 13/13] drm/vboxvideo: fix mapping leaks
Date: Thu, 13 Jun 2024 13:50:26 +0200
Message-ID: <20240613115032.29098-14-pstanner@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240613115032.29098-1-pstanner@redhat.com>
References: <20240613115032.29098-1-pstanner@redhat.com>
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


