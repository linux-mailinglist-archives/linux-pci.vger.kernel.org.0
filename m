Return-Path: <linux-pci+bounces-3155-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5452184B6B8
	for <lists+linux-pci@lfdr.de>; Tue,  6 Feb 2024 14:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 794D01C242F4
	for <lists+linux-pci@lfdr.de>; Tue,  6 Feb 2024 13:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7E0131E29;
	Tue,  6 Feb 2024 13:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="go+t2Kpo"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84C01332B0
	for <linux-pci@vger.kernel.org>; Tue,  6 Feb 2024 13:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707226863; cv=none; b=K9saI41TVmy/2lsY006r+PvhVN/pElBvcCrcuZYUpTAfA/baiDfO6GGhARWfM0nVcAJQQq6lfTfUe9Ens8sK5CKBjW9pCl6ROE13nyROaRsAoWvoLxFiYi0MYiA5Cgg+LcH7yO6j8PSZoS1o6WV0FiEzz+kYqVNcZx4Ng4RKUvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707226863; c=relaxed/simple;
	bh=DqC1146Gw+gtEXd1U6evjshsYPG+7+z9wKN5tAwt5no=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=htyTi0wr2OES2WKPunx0H1CxW33x45Yf+ok93mkM3VK/luoB/Yinz/iaWRgdD+PYad+Qnebqq0C7eM9QpBtgD00iE3W2djizCQaAFJUNOa1MYuLxzjAxuOhvn78LqC1ja505B4XO3J6Z6EfgAb5Pu+zlupoomw/T6jiPA+4tiBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=go+t2Kpo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707226861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wFTRxYvZ76dhFqAdPDH/a2zkO7llSf+/xEzdCoge4iY=;
	b=go+t2Kpoe7BtfouYV9O0a7l9UuxtLr1Ff7qESmNsV+2ED2VOtEu0aMyX8fzZt0Q5g8/RMC
	SINkUhHixjAavLZPIyoofyEK9PXahc90aTM2O55Ne7nsS7wXinK33rsWc/396gzEPi3pGp
	cLEQ2xEz92fkOb1MUl8ua6G5rrX8+Wk=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-G2TH6gl_PzqVtJDhHep7kw-1; Tue, 06 Feb 2024 08:40:59 -0500
X-MC-Unique: G2TH6gl_PzqVtJDhHep7kw-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7853449295cso25888685a.0
        for <linux-pci@vger.kernel.org>; Tue, 06 Feb 2024 05:40:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707226859; x=1707831659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wFTRxYvZ76dhFqAdPDH/a2zkO7llSf+/xEzdCoge4iY=;
        b=PjmmHlHKwCnBvxmmqsxkLJXnfVmeQCzCw5WI7noKZVVKY1/rRW810t3h8EH1gi2Ai1
         q4BeVThcXvjU79hClrnrM5WOh8cW0oTwDdar1OTWJRYMaa2CSFLKjVTw1W1pkJ6m3W6T
         yMCR/ygUH98JHCMEYPTOAhAr538E8ejBKD3LdU0NLwvzgkL3kGVKMRAPcFM5GneoO9pQ
         swnMWvoF7Ggwc8wYO8BPvkmTAtKBkLqpywZv9naBbIuabFOhDAosYKmvVh5APqUZfbu0
         3eNh3e4TydPYL1v1f1+CEwzVIfFmhvm0gXTAfvUJKPOYv2GmGYqsFpLqGuUNU6hpIxhU
         SSEg==
X-Gm-Message-State: AOJu0YzWW8Pr84TeXHw2zeJnCmD0XI88QgUdM3ofqKO3JPUGCUV4oNWV
	shfKaGgJIUmX0rqXApsvyzGBv7G0EGDWjrrVfMZ8YWcWDFzijiCjSDmnJMakmGWQNo0Lvc1RkQj
	YzxAWUgcv9pGGLC3ugm6iHJpLayg8K0tt0I2l98RJ4bCHrk5T21H2kgr+hQ==
X-Received: by 2002:a05:620a:458f:b0:785:8aed:219c with SMTP id bp15-20020a05620a458f00b007858aed219cmr2740646qkb.4.1707226858849;
        Tue, 06 Feb 2024 05:40:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGbUFe8rAmzdQwiOUkDOWaSU2uG39vl/g+XyIl4fyr/XwVyPG/ryyPI2bU0DdbSQp1oH7bwGw==
X-Received: by 2002:a05:620a:458f:b0:785:8aed:219c with SMTP id bp15-20020a05620a458f00b007858aed219cmr2740622qkb.4.1707226858478;
        Tue, 06 Feb 2024 05:40:58 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVVeDR5b9c7g/LX4DSP+QZjXTjR4mD9i/Uh3Ezjtj2GW3JtLorKY5AblA+CjtJql2aLlNALxzV0bl4U41u/GhhZLatfz9z0bPdBgozM5EYqgeElngR5qR0Txp3/2qm26N1Ys4+/8hSBu6u0aVRfjpHdO1etZE2hVCPT0KXoSUUzd617dh59feMZZeAjbZhdv8EnSQMoiuo89rEq+BvdPIr9sAN3QLOVlkylgY3mNTLjiVFjIdPDcpIFzQC9jWFF/j85Y4fRB2DTkj/Y3sTRuTE4bDbGsJR7R5v8GBdTiU3fm3/tDc7ma55apc9cEjsouFx/iBcEiQmJasZt4DHn09OqYIwb+Wn3YbkFIprccJT/mkYLQbiwHpsE+JR6Ql4TqRJ4ZFLdqlLKi8ArBJYgqbXk+HpyMNjYOPlQc7SM
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id vu4-20020a05620a560400b0078544c8be9asm903791qkn.87.2024.02.06.05.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 05:40:57 -0800 (PST)
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
	Philipp Stanner <pstanner@redhat.com>,
	stable@kernel.vger.org
Subject: [PATCH v3 10/10] drm/vboxvideo: fix mapping leaks
Date: Tue,  6 Feb 2024 14:39:56 +0100
Message-ID: <20240206134000.23561-12-pstanner@redhat.com>
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

When the PCI devres API was introduced to this driver, it was wrongly
assumed that initializing the device with pcim_enable_device() instead
of pci_enable_device() will make all PCI functions managed.

This is wrong and was caused by the quite confusing PCI devres API in
which some, but not all, functions become managed that way.

The function pci_iomap_range() is never managed.

Replace pci_iomap_range() with the actually managed function
pcim_iomap_range().

CC: <stable@kernel.vger.org> # v5.10+
Fixes: 8558de401b5f ("drm/vboxvideo: use managed pci functions")
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
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
2.43.0


