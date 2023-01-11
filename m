Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26503665F65
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jan 2023 16:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235405AbjAKPlc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Jan 2023 10:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234544AbjAKPl2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jan 2023 10:41:28 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F609BEB
        for <linux-pci@vger.kernel.org>; Wed, 11 Jan 2023 07:41:27 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id d17so15464118wrs.2
        for <linux-pci@vger.kernel.org>; Wed, 11 Jan 2023 07:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3apArcl7OMNeWOL87XhRmEIILQii5IFqm3oMsEY2uTQ=;
        b=TWS3RJUGnec7HJ8IdThWihyacAzGTfgOMMVKgAJ3sP5gvHzb6Hv2fQ8yYcj9IsnVVA
         o219u3LYZ8uCnmmEdWK9E++vy2du8AWTGfafd+vHo4u8SlnZt/LoMDlKNNioYzUIuXPf
         TJ6xYHvwDOSOn4s2j1NLyLLyiRMiLhKLjL0bQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3apArcl7OMNeWOL87XhRmEIILQii5IFqm3oMsEY2uTQ=;
        b=7MyU/ZQdSLHMLgzX56Jr/6alpjPHaDvNb79I06dW+cejQADbeIoifezPtl0XTVkuXl
         tfqS55CI4VepgV4TFl0xy7mbtiyuj3FEqtVrcxZXL67dNWGCW/bd9FfBu7BCQG9qTMkY
         GqrtzHwyunbUvy+8qcWOkAfV9wGxycXn54xnPdL5LFcaOukRUcja6QMj95P7KfMorKGj
         X3YwdSlKBMyU8cPqbGJ3NI+A3IbYzLGaWD52u2ZgmSpnjxEwnnOst4R5XLDzjZOctfGE
         IhXLC5yC39XMkIhC6jI7RvEzxOmMgf3NkJg+COw4J3asVf+lvK9VOZa5zNsP8iqYDF68
         glhg==
X-Gm-Message-State: AFqh2kq6bXZtRhwfJHOQIVQzpM2zNbfAKfIjxRJOM8yo4QSsccH/aXME
        pcl0UEELoL6SnbBBvLFRYnqF3Q==
X-Google-Smtp-Source: AMrXdXsZQQb90TZBhyIGbWCTV3hGh5NVwdW1rv7mMEKuwv41FW1zTUhYSl2ws/vK/PGYSdPl/U3j9w==
X-Received: by 2002:a5d:664c:0:b0:281:b594:c716 with SMTP id f12-20020a5d664c000000b00281b594c716mr39704840wrw.36.1673451685621;
        Wed, 11 Jan 2023 07:41:25 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600c198900b003d9e74dd9b2sm15936149wmq.9.2023.01.11.07.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 07:41:24 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH 04/11] video/aperture: use generic code to figure out the vga default device
Date:   Wed, 11 Jan 2023 16:41:05 +0100
Message-Id: <20230111154112.90575-4-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230111154112.90575-1-daniel.vetter@ffwll.ch>
References: <20230111154112.90575-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since vgaarb has been promoted to be a core piece of the pci subsystem
we don't have to open code random guesses anymore, we actually know
this in a platform agnostic way, and there's no need for an x86
specific hack. See also 1d38fe6ee6a8 ("PCI/VGA: Move vgaarb to
drivers/pci")

This should not result in any functional change, and the non-x86
multi-gpu pci systems are probably rare enough to not matter (I don't
know of any tbh). But it's a nice cleanup, so let's do it.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
---
 drivers/video/aperture.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/video/aperture.c b/drivers/video/aperture.c
index 41e77de1ea82..3d8c925c7365 100644
--- a/drivers/video/aperture.c
+++ b/drivers/video/aperture.c
@@ -324,13 +324,11 @@ EXPORT_SYMBOL(aperture_remove_conflicting_devices);
  */
 int aperture_remove_conflicting_pci_devices(struct pci_dev *pdev, const char *name)
 {
-	bool primary = false;
+	bool primary;
 	resource_size_t base, size;
 	int bar, ret;
 
-#ifdef CONFIG_X86
-	primary = pdev->resource[PCI_ROM_RESOURCE].flags & IORESOURCE_ROM_SHADOW;
-#endif
+	primary = pdev == vga_default_device();
 
 	for (bar = 0; bar < PCI_STD_NUM_BARS; ++bar) {
 		if (!(pci_resource_flags(pdev, bar) & IORESOURCE_MEM))
-- 
2.39.0

