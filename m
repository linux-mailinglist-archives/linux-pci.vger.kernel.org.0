Return-Path: <linux-pci+bounces-4319-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D94586E064
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 12:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E955B28AD15
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 11:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961F770AE5;
	Fri,  1 Mar 2024 11:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZYKV9D0h"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4C67004D
	for <linux-pci@vger.kernel.org>; Fri,  1 Mar 2024 11:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709292635; cv=none; b=nwjkIKU1gsGm0dtt4nyj4SRfg+yk2FOh8nNzz07lkLbeLZzKsardESW/pU4SIgggDmeCqrg2rQr85qIj6/rvrjXvL+KNZ7YKTdnPKA85b+D5MeI96ipP3U7CXoE0QqEFQjBQ5GSNF/dTKtGIecYgnLNUPXEJ6GyDHcmRPqBHn7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709292635; c=relaxed/simple;
	bh=DqC1146Gw+gtEXd1U6evjshsYPG+7+z9wKN5tAwt5no=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sSNZgLjeM6HicHVZTT26crHfrKHDBnzSYdvm00J7UhA+UrdLAadtQhZ6ruYDVKVBsh8g2m6a/GKhJyQjKX35GHvXyiEACdeb113Q1spu5X/LmwT6ZrRhmJ+s3OIp3DrcAdgwg9F/zU8Z4HPwkfCE6fzfDxaz31902s6fo21ViRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZYKV9D0h; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709292633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wFTRxYvZ76dhFqAdPDH/a2zkO7llSf+/xEzdCoge4iY=;
	b=ZYKV9D0hvVvacwx8yiJs+UW+XgeQ5ae1YFfaOl+yD+doMUTyju39GTB7OrCbMebSgTU8yQ
	UO1XjeKM5FI/nheGuk2DuVJ+yid/6aQ6YmtLuCC005RTmXi3HNb6ljcmMUFHmPJLFqAHE5
	xL9O6t2vRpISMt3y711MYsTiOxwMRv0=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-zh34YMYBP1m8R-_RneXGwA-1; Fri, 01 Mar 2024 06:30:31 -0500
X-MC-Unique: zh34YMYBP1m8R-_RneXGwA-1
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-5a0c318c056so154567eaf.1
        for <linux-pci@vger.kernel.org>; Fri, 01 Mar 2024 03:30:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709292631; x=1709897431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wFTRxYvZ76dhFqAdPDH/a2zkO7llSf+/xEzdCoge4iY=;
        b=i0W1I0VzRo9fFxU/9/FR2xyMmtlsnPVDMcqiSXMCr8qvQUlk/TqFcPYvvEy5aAzmOM
         0FIPacHT8Rd75u9fVCtRYOohPsy7DoQBDoVu9ngLX2eSgQM9NgeV+obRfKSPOVblihKZ
         7mnIvMUFROJmONaUhnTDQmnFgKzMqbBzrK3Ie2sOeF3STQo/3EJ6ESOOPZWCbvB0AdCv
         ZJafGKpSwVerOrrfkrBnnyGsl6aNMTOcx4ajPtDpsI3xVBLt1W2HwGQi1ukxEF/RB55d
         kzGGY3WaC18LPQm7HRZYhaiP+bsS/wdGGKqp8CxuScYT0sN/VZtD702zk+5fggovfOAH
         OGrA==
X-Forwarded-Encrypted: i=1; AJvYcCWsAywSe7/RTK5XxuRAbWq3tLTb0kA7G788GCa7TGCwz3uDWMsw3CfeBQiYazeRLyemiWKBSPYNlXmHpDaXa4VdM68fO00srgq4
X-Gm-Message-State: AOJu0Ywcedq0gtsQBv6A8fjefAwSz04oNi7QuwnGsgfsdtamidjaNlu2
	JPbdE4tzRHyhFogpxXxPF1lBNwOROk68aFxxaMhIUSK4xMFc6URsF+LUFPyH3fHOwwdHpDqba3j
	zNnLui/TMpdkmvyebe81IE13Ps7yRnBcmM+wPfqtv4A0ov6SEYerRHiaw9Q==
X-Received: by 2002:a05:6358:5923:b0:178:9f1d:65e4 with SMTP id g35-20020a056358592300b001789f1d65e4mr1147483rwf.3.1709292631161;
        Fri, 01 Mar 2024 03:30:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/dYBpHA/2LZIcNaPDDpZ49F70JHds10e81JbU90eBR8pmO8IjXPGhx9tXuvUpPM6IQ4Mw1Q==
X-Received: by 2002:a05:6358:5923:b0:178:9f1d:65e4 with SMTP id g35-20020a056358592300b001789f1d65e4mr1147459rwf.3.1709292630853;
        Fri, 01 Mar 2024 03:30:30 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id b1-20020ac86781000000b0042eb46d15bbsm1596239qtp.88.2024.03.01.03.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 03:30:30 -0800 (PST)
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
Subject: [PATCH v4 10/10] drm/vboxvideo: fix mapping leaks
Date: Fri,  1 Mar 2024 12:29:58 +0100
Message-ID: <20240301112959.21947-11-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240301112959.21947-1-pstanner@redhat.com>
References: <20240301112959.21947-1-pstanner@redhat.com>
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


