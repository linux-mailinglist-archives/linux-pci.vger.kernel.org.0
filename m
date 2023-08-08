Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B91F774E4E
	for <lists+linux-pci@lfdr.de>; Wed,  9 Aug 2023 00:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjHHWeh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Aug 2023 18:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjHHWeh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2023 18:34:37 -0400
Received: from out-67.mta1.migadu.com (out-67.mta1.migadu.com [95.215.58.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772DE129
        for <linux-pci@vger.kernel.org>; Tue,  8 Aug 2023 15:34:36 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1691534074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uMmEu+HhjoXxANySD4aMeLT6mwndhCG4N8c23OUDKuI=;
        b=Wl506kTCXQtMlc2mHYLR0PVSvjYlKXpfKDEhL9z8b9NHnYkkOx5eYk3PeqhY98kd6c4yym
        sZy1+F9KWA1jTNyhfoZM+i1exotrTiU77Sr7hEtCWtHXWH1Eeuw6HRvzFWdot/X3cr72ow
        BgHtoJVaqPXVmlq/UafBM8KuDNeeFjg=
From:   Sui Jingfeng <sui.jingfeng@linux.dev>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Dave Airlie <airlied@redhat.com>, Daniel Vetter <daniel@ffwll.ch>,
        linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Sui Jingfeng <suijingfeng@loongson.cn>
Subject: [PATCH v2 06/11] PCI/VGA: Fix two typos in the comments of pci_notify()
Date:   Wed,  9 Aug 2023 06:34:07 +0800
Message-Id: <20230808223412.1743176-7-sui.jingfeng@linux.dev>
In-Reply-To: <20230808223412.1743176-1-sui.jingfeng@linux.dev>
References: <20230808223412.1743176-1-sui.jingfeng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sui Jingfeng <suijingfeng@loongson.cn>

1) s/intereted/interested
2) s/hotplugable/hot-pluggable

While at it, convert the comments to the conventional multi-line style,
and rewrap to fill 78 columns.

Fixes: deb2d2ecd43d ("PCI/GPU: implement VGA arbitration on Linux")
Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 drivers/pci/vgaarb.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index 6883067a802a..811510253553 100644
--- a/drivers/pci/vgaarb.c
+++ b/drivers/pci/vgaarb.c
@@ -1535,9 +1535,11 @@ static int pci_notify(struct notifier_block *nb, unsigned long action,
 	if (!pci_dev_is_vga(pdev))
 		return 0;
 
-	/* For now we're only intereted in devices added and removed. I didn't
-	 * test this thing here, so someone needs to double check for the
-	 * cases of hotplugable vga cards. */
+	/*
+	 * For now, we're only interested in devices added and removed.
+	 * I didn't test this thing here, so someone needs to double check
+	 * for the cases of hot-pluggable VGA cards.
+	 */
 	if (action == BUS_NOTIFY_ADD_DEVICE)
 		notify = vga_arbiter_add_pci_device(pdev);
 	else if (action == BUS_NOTIFY_DEL_DEVICE)
-- 
2.34.1

