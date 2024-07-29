Return-Path: <linux-pci+bounces-10937-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B91A93F14C
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 11:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F815B227FC
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 09:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE861420CC;
	Mon, 29 Jul 2024 09:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AXL0jiEA"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BFA770E1
	for <linux-pci@vger.kernel.org>; Mon, 29 Jul 2024 09:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722245829; cv=none; b=MY7PYxC4Kd8lOO3iQPhI3LPwVKuoQXNqVee2f4fKi1SRqr/aTuGB27fIpEahsUWMYVG/C7mYfiAC7bJPgM5hAmkggcDFTa/RDUl9UGI0Be++c4Xo3Ooo7zDA9nyuvJY5q8FPQmkpohtDGJeUd9rxc4HoplJfmR1+U+v1Eh2s7Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722245829; c=relaxed/simple;
	bh=q+R0BpDAfe+tAd0rPJpsXFT4k1DLRypi7UxROY3RFFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rf/H9f4lci0IVNpgIztY8gkq/0ZotQh1J4X13yLDSPASwuxqGUGw1U11D8j4gTsQHnO7mL8h2GImeD2JphS9+2A54ntyao2jUO276BVqj7tZCfdy1ZTE0a53U/GSwT0XYMRL6q5BzEKjyVLgLYxgrlP6TCzNgnXJHWNhfeayKmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AXL0jiEA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722245826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8yzHolj0LBWvvfbf6+tRyOWfIn+0w0Jej2YhRYKH2Gc=;
	b=AXL0jiEACOHMyFDkK9gWKCB/VCH09jVUUE/w6zKOPD8sZraRKzEvhR+nvoVFH2JukmWS/G
	AVk5ByJeb099fKXeAI1Cp6H34ulsAvI6mM5zW6S5itDlvvcE/YUC0JtforYi7caGuqu0m1
	WQEDpbZZkGwvAgSuHr9yB5qnL4iFVg8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-2nohE3dAMkWcvvT9bZwpcA-1; Mon, 29 Jul 2024 05:37:04 -0400
X-MC-Unique: 2nohE3dAMkWcvvT9bZwpcA-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6b7a47a271cso7339396d6.2
        for <linux-pci@vger.kernel.org>; Mon, 29 Jul 2024 02:37:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722245824; x=1722850624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8yzHolj0LBWvvfbf6+tRyOWfIn+0w0Jej2YhRYKH2Gc=;
        b=ijTOHKCktpG/x5fzWWsNoSczFlkTnq4m+z/229SQi2u7qRdWfsJnDW75QYkz3hgIFy
         yD3sb7KauKpQ4EpvcSp41/Eo2uk5Vok4v4mYBMHL/GhdosBWKUwET+v+TmZ/TaQ6EMP7
         L0M+0keioqdwPHQjuMTUt4QD1CJ+P4UFpHFoYybqWXcj5/MBb9pv0mynZWuTVjdM3bhX
         CEkHPW3M5Vx0OnLuIZsC5Ex+d+MiRzrw/NwYafVBUfj5puG7SuKHn8+uuuTRm9zklpg2
         X7sy2KV35SMC6Ej2ooAgDUdtQHIES6MmZjy9JzIkFEB1q2S66UDNFPQmjWEYhYlFvgoN
         4XEA==
X-Forwarded-Encrypted: i=1; AJvYcCVKVf49nf+fTUXUqZkXyllyCez135HxCJ7eTSTnoGNjI4SfSdiNUwMfChXslJtkMg9FAmefp5VZnf1MulE7l3abP9PMhZORVxXt
X-Gm-Message-State: AOJu0YyHnag72prkz8GZEhmJ5fCUZFOgrxGODKNx6ifGzDidvXjGFna5
	IR/49mNsMoAenqJcCtcU3ccFYLxF31KYqc56KxWRR69huBfVF1nf6vFN2KymurC2LZlyGIQ6+gn
	RGHlAbBev6HlbRQlpbcOPpxrVv5L6k+tCohsPrfMQ3fGJsYArVHqEQKcQJg==
X-Received: by 2002:a05:6214:2b0a:b0:6b7:7832:2211 with SMTP id 6a1803df08f44-6bb3e2043dbmr102004156d6.3.1722245824090;
        Mon, 29 Jul 2024 02:37:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFajgcbMizSfez+xFTta1vgiY+ZYkosQdlpq9GU2h/rROwHquJE6I29rQYeZi0foyo1YN47NA==
X-Received: by 2002:a05:6214:2b0a:b0:6b7:7832:2211 with SMTP id 6a1803df08f44-6bb3e2043dbmr102003986d6.3.1722245823659;
        Mon, 29 Jul 2024 02:37:03 -0700 (PDT)
Received: from dhcp-64-164.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3fa94a16sm50047086d6.86.2024.07.29.02.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 02:37:03 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH 2/2] drm/vboxvideo: Add PCI region request
Date: Mon, 29 Jul 2024 11:36:27 +0200
Message-ID: <20240729093625.17561-5-pstanner@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240729093625.17561-2-pstanner@redhat.com>
References: <20240729093625.17561-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vboxvideo currently does not reserve its PCI BAR through a region
request.

Implement the request through the managed function
pcim_request_region().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/gpu/drm/vboxvideo/vbox_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/vboxvideo/vbox_main.c b/drivers/gpu/drm/vboxvideo/vbox_main.c
index d4ade9325401..7f686a0190e6 100644
--- a/drivers/gpu/drm/vboxvideo/vbox_main.c
+++ b/drivers/gpu/drm/vboxvideo/vbox_main.c
@@ -114,6 +114,10 @@ int vbox_hw_init(struct vbox_private *vbox)
 
 	DRM_INFO("VRAM %08x\n", vbox->full_vram_size);
 
+	ret = pcim_request_region(pdev, 0, "vboxvideo");
+	if (ret)
+		return ret;
+
 	/* Map guest-heap at end of vram */
 	vbox->guest_heap = pcim_iomap_range(pdev, 0,
 			GUEST_HEAP_OFFSET(vbox), GUEST_HEAP_SIZE);
-- 
2.45.2


