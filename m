Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54B912EAC31
	for <lists+linux-pci@lfdr.de>; Tue,  5 Jan 2021 14:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730342AbhAENox (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Jan 2021 08:44:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730161AbhAENox (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Jan 2021 08:44:53 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62588C061796
        for <linux-pci@vger.kernel.org>; Tue,  5 Jan 2021 05:44:12 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id r3so36259411wrt.2
        for <linux-pci@vger.kernel.org>; Tue, 05 Jan 2021 05:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4uTZYuSmoeTiRu33iHMIlMouIHVooiXnKLwMhzI2plk=;
        b=YLVW6yaz4t2tTxAlT7N9+bLCR18/eFsvPFiFFdhF+38gMYzmjR9uWvyDt1FUjqrDad
         qZuW6FjBp/2HVZt8h4Fkkefp2Z11UWNrqrHGBwOe2dldv5E7bWG1qBlrMggcCpneniSF
         /pQvB4U1bPCcEXQRT2jBVYhggUF+v299sxZxzraG6Fl0EJsbYU+VfOt7MpIXpzNYrDBs
         r99ADcF1Kce/XRWO4273uOPAFoB5DQSeRzn4tONPK/02cyNvLmrTaQMLL3euKvHHBvBw
         sjh8tDthm968s1bUEtRspTUxVY5XpkYhPeoqHgPbqSvqo9qAAiT9EY2KgbPPQv59svE/
         4u4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4uTZYuSmoeTiRu33iHMIlMouIHVooiXnKLwMhzI2plk=;
        b=RxQM/g/x+tsWslAxIqp/2SvfO8CjasTWMWxBWlxDXeJWT7m6vgytThGjUUF7KECRjJ
         c43Qz7DwUm4wfv84t83N1AEIBHECYMk+jn9+jdNEX8sfzYAJ2tTdH3RDZ52ZxdMnq875
         PVb7keO1PpNAVCuXKBV8iATZY+bE71FmIzE3/hynW2u6PEUeLklsp37rMN04+uFJwfgt
         H9lmDxXPCBymTtXrtI9IRYkArD4RF8MLkJk7WK5Z+XMp3Ee0g3RoGLllTW3BP7oRh71N
         8J7Q6uB9E5bdX0IvEUflLb7iNLh8RXn9yj49YpqCXfyeBbEJ0Fdjfe0EhusshOZgg5AW
         8M6w==
X-Gm-Message-State: AOAM530eP9u49Q65Vplo/zm5U/KpwP+SIxu5GhTXMtC13DgnNKQRY7Cu
        6CY9uXdoFe1idNZxkSpKyYA=
X-Google-Smtp-Source: ABdhPJz5gt/7ovBihzHlh30pzyKlkA2e3I28sjv3mvtpk/2hFlTNoNgDQDk+RVB3ef2kI+uYHLqrBA==
X-Received: by 2002:adf:f344:: with SMTP id e4mr85434282wrp.25.1609854251240;
        Tue, 05 Jan 2021 05:44:11 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:3137:60b9:8d8f:7f55])
        by smtp.gmail.com with ESMTPSA id l20sm102191243wrh.82.2021.01.05.05.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 05:44:10 -0800 (PST)
From:   "=?UTF-8?q?Christian=20K=C3=B6nig?=" 
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To:     bhelgaas@google.com
Cc:     devspam@moreofthesa.me.uk, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org
Subject: [PATCH 3/4] amdgpu: resize BAR0 to the maximum available size, even if it doesn't cover VRAM (v6)
Date:   Tue,  5 Jan 2021 14:44:03 +0100
Message-Id: <20210105134404.1545-4-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210105134404.1545-1-christian.koenig@amd.com>
References: <20210105134404.1545-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Darren Salt <devspam@moreofthesa.me.uk>

This allows BAR0 resizing to be done for cards which don't advertise support
for a size large enough to cover the VRAM but which do advertise at least
one size larger than the default. For example, my RX 5600 XT, which
advertises 256MB, 512MB and 1GB.

[v6] (chk) Reduce to only the necessary functionality

[v5] Drop the retry loop…

[v4] Use bit ops to find sizes to try.

[v3] Don't use pci_rebar_get_current_size().

[v2] Rewritten to use PCI helper functions; some extra log text.

Signed-off-by: Darren Salt <devspam@moreofthesa.me.uk>
Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 70acd673e3f2..da78746174f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1089,7 +1089,7 @@ void amdgpu_device_wb_free(struct amdgpu_device *adev, u32 wb)
  */
 int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 {
-	u32 rbar_size = pci_rebar_bytes_to_size(adev->gmc.real_vram_size);
+	int rbar_size = pci_rebar_bytes_to_size(adev->gmc.real_vram_size);
 	struct pci_bus *root;
 	struct resource *res;
 	unsigned i;
@@ -1120,6 +1120,10 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 	if (!res)
 		return 0;
 
+	/* Limit the BAR size to what is available */
+	rbar_size = min(fls(pci_rebar_get_possible_sizes(adev->pdev, 0)) - 1,
+			rbar_size);
+
 	/* Disable memory decoding while we change the BAR addresses and size */
 	pci_read_config_word(adev->pdev, PCI_COMMAND, &cmd);
 	pci_write_config_word(adev->pdev, PCI_COMMAND,
-- 
2.25.1

