Return-Path: <linux-pci+bounces-8303-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BFF8FC5F5
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 10:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0750E1C2144C
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 08:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C78194A4F;
	Wed,  5 Jun 2024 08:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PS2vtOUd"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F59194147
	for <linux-pci@vger.kernel.org>; Wed,  5 Jun 2024 08:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717575397; cv=none; b=PUubV8lPHN7fi6/nI/HjrKjCtAwqDyWqoyM7eY6Aoz8McPafkeHut1A0jZhAKBskggS0XXhIxJm08SYS5QYWHcl31NHzSlrxbefDzNLG0xoc23Mf39cT5+ZOuvjE/5wslFP1/ZN4uR6zBZtbIyhXMMHiBkGtUCY69lItrlbAuqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717575397; c=relaxed/simple;
	bh=iGO9d2tDV8jgMXAb9ljo4BmxYhAXls7ncq8pchC9GTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZNcSB80McfdeOFG5qvFNFSXBm379/2v5CBNLmCyH+208prpzxNQWA6KTVOenZExy48wOOSJG5aIddiWQvxZ/t0m144Vpy2nWrxUQLgQR1ERhy1a+PPUBe5IgxdR1Ro2miae782ev5u7jPtH3yuzlRI/8iaRZm+ou6/Q9+SIR9Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PS2vtOUd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717575395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9WQJKGGQ63IpYpwAqks0j3zwgngy8EFW/hBQkkDLpOw=;
	b=PS2vtOUdeYss/n2HngzviDg6RSSXO/9F4CnyRbGU4JJkFjpQ0R/Kr0Emk58oN379Ow0QeY
	Te1kK4GPwPwYL1GapfsgMm6mDtDndnsuo8GLkc3gv6rhj/jlUtwftPxHvQim6kJBxmizWv
	fpzUMmL+RqaRCERDsoZCkKeqKpZbUSY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-eQnOHsO5MvetbGqOw_xD0Q-1; Wed, 05 Jun 2024 04:16:30 -0400
X-MC-Unique: eQnOHsO5MvetbGqOw_xD0Q-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42110b33fecso7980905e9.0
        for <linux-pci@vger.kernel.org>; Wed, 05 Jun 2024 01:16:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717575390; x=1718180190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9WQJKGGQ63IpYpwAqks0j3zwgngy8EFW/hBQkkDLpOw=;
        b=MI7CXB8J617T7V5QkBId5ykAwWTSijaxfMIWULy3Ug4Wr8yRUVNEDPh3bEGu3wjt7U
         Hfj0JRvICFcJypvvPJelAlJhjsnrRNqH62y1KYReq+VnrEO9GwbWlp220h/5HRoPuZG2
         Eyhvr85mjidw2X1Dn+Nv5qRmOhV1qyVLbFjEu1fvgxpV2FhzIw7Ny+M0gdVC5zrCTPNv
         g/Sm4ZsDXEneA1bQn3BKjDN0Koe/cFubXU3zloBgsupxWMckBw97MQQYLE3dbB9wBuaB
         qcMh0GcN4L4PBOzb/knIqIrcVcnmAGz+sMtwef0NCvo/9V4ZVPPuUsoZy7syUS53qaBJ
         poww==
X-Forwarded-Encrypted: i=1; AJvYcCVL7X/CzbuZLIU1dcJmoWNZHa/lmmlnrZrHE93KL9Mx1bMW3ShE/lurixQzHal7kUnBW2iik9NvmqAwP54oASB+DM7WJZFxky1B
X-Gm-Message-State: AOJu0YxcvwcKgR3x/nYOwxWMbLxBKfrLS7C1ZUZ4gClmZl7Hsrrg39sO
	8UFedwMCqgyQNYNZ5ypg1i7pQ5vGX7qJajTS9pK11z1OrgnpCy3qosYU7Y+5nw3UYAWeBJV+7d+
	y7vFwx1PsLQBikaa04lNVXnVBssTXdzjakBcQ83F13AKBDdT95Ri5qB8azQ==
X-Received: by 2002:a5d:404d:0:b0:35e:83dc:e6ed with SMTP id ffacd0b85a97d-35e83fcb079mr1241481f8f.0.1717575389877;
        Wed, 05 Jun 2024 01:16:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjXIQcWcnmum91rBphrXn5QVRVx0JrE+Ei0yMho9Onfe+TO5zfd469TFQpM4baXxySxHqFTA==
X-Received: by 2002:a5d:404d:0:b0:35e:83dc:e6ed with SMTP id ffacd0b85a97d-35e83fcb079mr1241464f8f.0.1717575389558;
        Wed, 05 Jun 2024 01:16:29 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.fritz.box ([2001:9e8:32e6:e600:c901:4daf:2476:80ad])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd0630010sm13739163f8f.76.2024.06.05.01.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 01:16:29 -0700 (PDT)
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
Subject: [PATCH v7 13/13] drm/vboxvideo: fix mapping leaks
Date: Wed,  5 Jun 2024 10:16:05 +0200
Message-ID: <20240605081605.18769-15-pstanner@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240605081605.18769-2-pstanner@redhat.com>
References: <20240605081605.18769-2-pstanner@redhat.com>
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


