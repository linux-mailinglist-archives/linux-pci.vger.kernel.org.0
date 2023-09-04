Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B8C791DE8
	for <lists+linux-pci@lfdr.de>; Mon,  4 Sep 2023 21:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236105AbjIDT56 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Sep 2023 15:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236937AbjIDT55 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Sep 2023 15:57:57 -0400
Received: from out-216.mta1.migadu.com (out-216.mta1.migadu.com [95.215.58.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077601715
        for <linux-pci@vger.kernel.org>; Mon,  4 Sep 2023 12:57:49 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1693857466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LqpDfy7jFw2xJEvEvsvRPCTDdY9j+2hqZZDtflMLDhg=;
        b=WStnGQXeW5BqIuHoiyaRzA+TJzXqxO/w6kqSS4bJpIIHA8VKpuQJC55KX3cJTyU0ojlG48
        rQA4YgJna8esL75FwGA1ZCP6tfeU2Te6m7aNzn1JJt1o1j+Trw9b2ZZgImETGb439FHPM2
        KY/rIaV6Z10ITNKiYHL2D3EBhLDq5cI=
From:   Sui Jingfeng <sui.jingfeng@linux.dev>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-pci@vger.kernel.org,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [RFC,drm-misc-next v4 5/9] drm/i915: Implement .be_primary() callback
Date:   Tue,  5 Sep 2023 03:57:20 +0800
Message-Id: <20230904195724.633404-6-sui.jingfeng@linux.dev>
In-Reply-To: <20230904195724.633404-1-sui.jingfeng@linux.dev>
References: <20230904195724.633404-1-sui.jingfeng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sui Jingfeng <suijingfeng@loongson.cn>

On a machine with multiple GPUs, a Linux user has no control over which one
is primary at boot time. This patch tries to solve the mentioned problem by
implementing the .be_primary() callback. Pass i915.modeset=10 on the kernel
cmd line if you really want the device bound by i915 drm driver to be the
primary video adapter, no matter what VGAARB say.

Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 drivers/gpu/drm/i915/display/intel_vga.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_vga.c b/drivers/gpu/drm/i915/display/intel_vga.c
index 98d7d4dffe9f..e3f78ba2668b 100644
--- a/drivers/gpu/drm/i915/display/intel_vga.c
+++ b/drivers/gpu/drm/i915/display/intel_vga.c
@@ -113,6 +113,17 @@ intel_vga_set_decode(struct pci_dev *pdev, bool enable_decode)
 		return VGA_RSRC_NORMAL_IO | VGA_RSRC_NORMAL_MEM;
 }
 
+static bool intel_want_to_be_primary(struct pci_dev *pdev)
+{
+	struct drm_i915_private *i915 = pdev_to_i915(pdev);
+	struct i915_params *params = &i915->params;
+
+	if (params->modeset == 10)
+		return true;
+
+	return false;
+}
+
 int intel_vga_register(struct drm_i915_private *i915)
 {
 	struct pci_dev *pdev = to_pci_dev(i915->drm.dev);
@@ -126,7 +137,8 @@ int intel_vga_register(struct drm_i915_private *i915)
 	 * then we do not take part in VGA arbitration and the
 	 * vga_client_register() fails with -ENODEV.
 	 */
-	ret = vga_client_register(pdev, intel_vga_set_decode, NULL);
+	ret = vga_client_register(pdev, intel_vga_set_decode,
+				  intel_want_to_be_primary);
 	if (ret && ret != -ENODEV)
 		return ret;
 
-- 
2.34.1

