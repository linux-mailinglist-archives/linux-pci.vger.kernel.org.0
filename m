Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1FF9791DF1
	for <lists+linux-pci@lfdr.de>; Mon,  4 Sep 2023 21:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236291AbjIDT6H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Sep 2023 15:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236671AbjIDT6C (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Sep 2023 15:58:02 -0400
Received: from out-218.mta1.migadu.com (out-218.mta1.migadu.com [95.215.58.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C964173E
        for <linux-pci@vger.kernel.org>; Mon,  4 Sep 2023 12:57:51 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1693857468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=di2qHcFYE+Hq+NlRE1bj3bLblQwmCRGCImtdcZKCjUc=;
        b=rJNfpwab0aIQm5RePnYvbfQa2evsIovN8h4+vqXvX+exhBi1P8XMkvYUlqZh4bqcSCK8ec
        a6ItmnAfUtFXDK9qfWMe9SPjx/lb97SKdjyvvILTDduL6DPrrjMNVBrp5AOCHjnpFWhe/1
        eW68Ko1bmHXCj0RZTYHobpMp/Uqx1oA=
From:   Sui Jingfeng <sui.jingfeng@linux.dev>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-pci@vger.kernel.org,
        Sui Jingfeng <suijingfeng@loongson.cn>
Subject: [RFC,drm-misc-next v4 6/9] drm/loongson: Implement .be_primary() callback
Date:   Tue,  5 Sep 2023 03:57:21 +0800
Message-Id: <20230904195724.633404-7-sui.jingfeng@linux.dev>
In-Reply-To: <20230904195724.633404-1-sui.jingfeng@linux.dev>
References: <20230904195724.633404-1-sui.jingfeng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sui Jingfeng <suijingfeng@loongson.cn>

On a machine with multiple GPUs, a Linux user has no control over which one
is primary at boot time. This patch tries to solve the mentioned problem by
implementing the .be_primary() callback. Pass loongson.modeset=10 on the
kernel cmd line if you really want the device bound by loongson drm driver
to be the primary video adapter, no matter what VGAARB say.

Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 drivers/gpu/drm/loongson/loongson_module.c |  2 +-
 drivers/gpu/drm/loongson/loongson_module.h |  1 +
 drivers/gpu/drm/loongson/lsdc_drv.c        | 10 +++++++++-
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/loongson/loongson_module.c b/drivers/gpu/drm/loongson/loongson_module.c
index d2a51bd395f6..12f2a453adff 100644
--- a/drivers/gpu/drm/loongson/loongson_module.c
+++ b/drivers/gpu/drm/loongson/loongson_module.c
@@ -9,7 +9,7 @@
 
 #include "loongson_module.h"
 
-static int loongson_modeset = -1;
+int loongson_modeset = -1;
 MODULE_PARM_DESC(modeset, "Disable/Enable modesetting");
 module_param_named(modeset, loongson_modeset, int, 0400);
 
diff --git a/drivers/gpu/drm/loongson/loongson_module.h b/drivers/gpu/drm/loongson/loongson_module.h
index 931c17521bf0..afff51e7f34f 100644
--- a/drivers/gpu/drm/loongson/loongson_module.h
+++ b/drivers/gpu/drm/loongson/loongson_module.h
@@ -6,6 +6,7 @@
 #ifndef __LOONGSON_MODULE_H__
 #define __LOONGSON_MODULE_H__
 
+extern int loongson_modeset;
 extern int loongson_vblank;
 extern struct pci_driver lsdc_pci_driver;
 
diff --git a/drivers/gpu/drm/loongson/lsdc_drv.c b/drivers/gpu/drm/loongson/lsdc_drv.c
index d10a28c2c494..7183b0666167 100644
--- a/drivers/gpu/drm/loongson/lsdc_drv.c
+++ b/drivers/gpu/drm/loongson/lsdc_drv.c
@@ -257,6 +257,14 @@ static unsigned int lsdc_vga_set_decode(struct pci_dev *pdev, bool state)
 	return VGA_RSRC_NORMAL_IO | VGA_RSRC_NORMAL_MEM;
 }
 
+static bool lsdc_want_to_be_primary(struct pci_dev *pdev)
+{
+	if (loongson_modeset == 10)
+		return true;
+
+	return false;
+}
+
 static int lsdc_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	const struct lsdc_desc *descp;
@@ -289,7 +297,7 @@ static int lsdc_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	pci_set_drvdata(pdev, ddev);
 
-	vga_client_register(pdev, lsdc_vga_set_decode, NULL);
+	vga_client_register(pdev, lsdc_vga_set_decode, lsdc_want_to_be_primary);
 
 	drm_kms_helper_poll_init(ddev);
 
-- 
2.34.1

