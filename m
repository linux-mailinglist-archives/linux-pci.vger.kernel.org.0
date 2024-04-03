Return-Path: <linux-pci+bounces-5605-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2D8896823
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 10:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B3391C25E0C
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 08:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F27137C5F;
	Wed,  3 Apr 2024 08:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Osnl8HsT"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C200136996
	for <linux-pci@vger.kernel.org>; Wed,  3 Apr 2024 08:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131662; cv=none; b=dA1HstFSUVUThmOGRbBCLKVa2eim3mkN08oem2kdhz4cUaQNqLuLoM99osZeRn2TMkpGuevC5pBYaaqu1eQNQqPpDLYCxoPjUnMRYyT9Y4mJzV7YgdyaKQj31cRkxjd+tJp77ouE8qlZPl7FiIID++5vocghzO2RrF39cK+EM7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131662; c=relaxed/simple;
	bh=yB67IW3EG1x6cJSxoti1WslrkvMytD90mSjXc8mIVWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m7iWM+gt4Vs26Fe9+iE1IOoL8oyxwlGAqRt1PA0gq6vkAtcTNu6zgKj/KB3ZwlN0uVyOV9H5IltbxwWTpqHKfxpSH78VAS6vmkHgCK+EVGa/yiTxu0GueTg3b66OSrZzYl6a9x2x8sTdGdZV4JfUh+7PhJpk2q7vxyS4NeR2tFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Osnl8HsT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712131660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eiRLnMbkdq0ZK3iF1Wz+eyDORzRxcdv33M/2a8lgeaY=;
	b=Osnl8HsTI9667akdLJC/PVL4WKdksdSOQZ3fLtMaZZN+jtSmhtAdB0Vsot9ACGWSPXGyxr
	jire/6Mb7cqvZiXm8qV0NhkH5Zjh4XaefN37TBRkuACrUjiL9ms1lbRR/546oFsqBAQc4Q
	1ZpdbrPDFtxWV8ftHeXzW6nU4p+of4k=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-RpOI84PpMBysuTouE4-xMQ-1; Wed, 03 Apr 2024 04:07:38 -0400
X-MC-Unique: RpOI84PpMBysuTouE4-xMQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-34370209778so339302f8f.1
        for <linux-pci@vger.kernel.org>; Wed, 03 Apr 2024 01:07:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712131657; x=1712736457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eiRLnMbkdq0ZK3iF1Wz+eyDORzRxcdv33M/2a8lgeaY=;
        b=fv4Wu73aFmUoy0yVmTUJl/K/ZIRrAu5Yc5AviqniFM0kl9TfXE9TFAh3YYjeasK6R3
         o3vpSoVhR1tmp6TmlDZE8Bs6FLGGJl5zRnhxVsEk33ly9Zs5d6PERpKhAesIG5Ug//aG
         SijS7UHKtM8xwjPABQ5nGOUQ9FcouLYH5lcg0T3VqQv0l3SK007H5s6CwKGAZtNDeV7n
         myJtdlqvC1pBa/OHsSIek3Q4cyEWTj+XxNMcHqK4XTUEFvu83qbr0nsHeBwnFZfqCS0W
         E6fE9AJE5lzjkJzUXxEmjvs4MioydhY1Zt2dCwOH3BV7I+/mtR9QuUTdanQ+yImIzzdX
         skvg==
X-Forwarded-Encrypted: i=1; AJvYcCXAtdmAQapZGFsyElAhPbP6ZV3SCpVsp+KRRRriC+obzMa6Ya25JCMJei3QsQ67hYmxKxvMo8+ZLXBdXHdn1c9XQPUJiAjQsiI/
X-Gm-Message-State: AOJu0YzmrLVCJW4flOLmowytCCc6Gfc4PaJuadpUvtumXd23wI8tUvlP
	2x5BCDG2MBO6/Lg/Zgq6jtPoOTiWWBrsLvTHQfMwxEQ9l71kXJtC1RnDTWHv6qaZNtsbbZFpzvm
	usQCJxR9ldbf75MLCn5xcvCAsy+1Gn86xCjzwBxurzC/VBrc1TKgXuNaK9A==
X-Received: by 2002:a05:600c:1d24:b0:415:6725:f9b0 with SMTP id l36-20020a05600c1d2400b004156725f9b0mr5651478wms.2.1712131657591;
        Wed, 03 Apr 2024 01:07:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSEV4CULLDHixjQ5GOzJ41zlIKQYkOtpxOte+Iv6GRLF0JbLuFFpysICEch8WGgEL0sf/Gcg==
X-Received: by 2002:a05:600c:1d24:b0:415:6725:f9b0 with SMTP id l36-20020a05600c1d2400b004156725f9b0mr5651466wms.2.1712131657356;
        Wed, 03 Apr 2024 01:07:37 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id fa14-20020a05600c518e00b004159df274d5sm5504535wmb.6.2024.04.03.01.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 01:07:37 -0700 (PDT)
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
Subject: [PATCH v5 10/10] drm/vboxvideo: fix mapping leaks
Date: Wed,  3 Apr 2024 10:07:11 +0200
Message-ID: <20240403080712.13986-13-pstanner@redhat.com>
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
2.44.0


