Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9443F791DEB
	for <lists+linux-pci@lfdr.de>; Mon,  4 Sep 2023 21:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236368AbjIDT56 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Sep 2023 15:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236321AbjIDT5x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Sep 2023 15:57:53 -0400
Received: from out-213.mta1.migadu.com (out-213.mta1.migadu.com [95.215.58.213])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE08BD
        for <linux-pci@vger.kernel.org>; Mon,  4 Sep 2023 12:57:43 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1693857462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kmuyy5d8TjfKPYFKMrpKxMdJxlBIiyPktdk9/3dqaTc=;
        b=MRbIL1ezV+MLDlrq8FrN2e2iqKWOCBSzCMXu00ItCM4BykmOR85mcBF+KstvvBGs6g1CU3
        mO/B8rdGeNOFX1B78Vqej0MqiBxruE4A0+Vuxx2Pu/ErmZJgbG1UNtUYiHBqabuPRdixNg
        0+mVRFLiH5Q5VIHnOltwIszhLHFeGRg=
From:   Sui Jingfeng <sui.jingfeng@linux.dev>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-pci@vger.kernel.org,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>
Subject: [RFC,drm-misc-next v4 3/9] drm/radeon: Implement .be_primary() callback
Date:   Tue,  5 Sep 2023 03:57:18 +0800
Message-Id: <20230904195724.633404-4-sui.jingfeng@linux.dev>
In-Reply-To: <20230904195724.633404-1-sui.jingfeng@linux.dev>
References: <20230904195724.633404-1-sui.jingfeng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sui Jingfeng <suijingfeng@loongson.cn>

On a machine with multiple GPUs, a Linux user has no control over which one
is primary at boot time. This patch tries to solve the mentioned problem by
implementing the .be_primary() callback. Pass radeon.modeset=10 on the
kernel cmd line if you really want the device bound by radeon to be the
primary video adapter, no matter what VGAARB say.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 drivers/gpu/drm/radeon/radeon_device.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
index 71f2ff39d6a1..b661cd3a8dc2 100644
--- a/drivers/gpu/drm/radeon/radeon_device.c
+++ b/drivers/gpu/drm/radeon/radeon_device.c
@@ -1263,6 +1263,14 @@ static const struct vga_switcheroo_client_ops radeon_switcheroo_ops = {
 	.can_switch = radeon_switcheroo_can_switch,
 };
 
+static bool radeon_want_to_be_primary(struct pci_dev *pdev)
+{
+	if (radeon_modeset == 10)
+		return true;
+
+	return false;
+}
+
 /**
  * radeon_device_init - initialize the driver
  *
@@ -1425,7 +1433,7 @@ int radeon_device_init(struct radeon_device *rdev,
 	/* if we have > 1 VGA cards, then disable the radeon VGA resources */
 	/* this will fail for cards that aren't VGA class devices, just
 	 * ignore it */
-	vga_client_register(rdev->pdev, radeon_vga_set_decode, NULL);
+	vga_client_register(rdev->pdev, radeon_vga_set_decode, radeon_want_to_be_primary);
 
 	if (rdev->flags & RADEON_IS_PX)
 		runtime = true;
-- 
2.34.1

