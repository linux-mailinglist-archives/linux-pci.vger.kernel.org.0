Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9BA791DDE
	for <lists+linux-pci@lfdr.de>; Mon,  4 Sep 2023 21:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235731AbjIDT5q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Sep 2023 15:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbjIDT5o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Sep 2023 15:57:44 -0400
Received: from out-227.mta1.migadu.com (out-227.mta1.migadu.com [95.215.58.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE67FBD
        for <linux-pci@vger.kernel.org>; Mon,  4 Sep 2023 12:57:41 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1693857460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o7qBg3iDQqf8IwXL/E4Wgz6fxfLGjyBUHVlaSKqEqM0=;
        b=WMS/w8FgJ79aPQ8l4g/8/d9wVJNdmJ/Trts3yfgLGchh5WoxYx1+w0H8NIuaAyS0IT5BkC
        Kjx20glONovJ8q2nZ9dMoVofSgZDpd/8y0klyEVggRv/eqObUf7XYTSMmhsr0xBmxPkuBC
        v/o6je4JekFri0ZrPJpgLowPojwWyOs=
From:   Sui Jingfeng <sui.jingfeng@linux.dev>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-pci@vger.kernel.org,
        Sui Jingfeng <suijingfeng@loongson.cn>
Subject: [RFC,drm-misc-next v4 2/9] drm/nouveau: Implement .be_primary() callback
Date:   Tue,  5 Sep 2023 03:57:17 +0800
Message-Id: <20230904195724.633404-3-sui.jingfeng@linux.dev>
In-Reply-To: <20230904195724.633404-1-sui.jingfeng@linux.dev>
References: <20230904195724.633404-1-sui.jingfeng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sui Jingfeng <suijingfeng@loongson.cn>

On a machine with multiple GPUs, a Linux user has no control over which one
is primary at boot time. This patch tries to solve the mentioned problem by
implementing the .be_primary() callback. VGAARB will call back to Nouveau
when the drm/nouveau gets loaded successfully.

Pass nouveau.modeset=10 on the kernel cmd line if you really want the
device bound by Nouveau to be the primary video adapter. This overrides
whatever boot device selected by VGAARB.

Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 drivers/gpu/drm/nouveau/nouveau_vga.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_vga.c b/drivers/gpu/drm/nouveau/nouveau_vga.c
index 162b4f4676c7..4242188667e2 100644
--- a/drivers/gpu/drm/nouveau/nouveau_vga.c
+++ b/drivers/gpu/drm/nouveau/nouveau_vga.c
@@ -80,6 +80,15 @@ nouveau_switcheroo_ops = {
 	.can_switch = nouveau_switcheroo_can_switch,
 };
 
+static bool
+nouveau_want_to_be_primary(struct pci_dev *pdev)
+{
+	if (nouveau_modeset == 10)
+		return true;
+
+	return false;
+}
+
 void
 nouveau_vga_init(struct nouveau_drm *drm)
 {
@@ -92,7 +101,7 @@ nouveau_vga_init(struct nouveau_drm *drm)
 		return;
 	pdev = to_pci_dev(dev->dev);
 
-	vga_client_register(pdev, nouveau_vga_set_decode, NULL);
+	vga_client_register(pdev, nouveau_vga_set_decode, nouveau_want_to_be_primary);
 
 	/* don't register Thunderbolt eGPU with vga_switcheroo */
 	if (pci_is_thunderbolt_attached(pdev))
-- 
2.34.1

