Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88AB45958DC
	for <lists+linux-pci@lfdr.de>; Tue, 16 Aug 2022 12:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235064AbiHPKsK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Aug 2022 06:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234223AbiHPKrj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Aug 2022 06:47:39 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9678F6331
        for <linux-pci@vger.kernel.org>; Tue, 16 Aug 2022 03:06:51 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id h21-20020a17090aa89500b001f31a61b91dso16928160pjq.4
        for <linux-pci@vger.kernel.org>; Tue, 16 Aug 2022 03:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=95RmrDaOTs+TArBQIen65/TK8NYN58Pk/yEsVpA/XLQ=;
        b=zz9Kx3opIvtvTrScnyxJFs+GMVOTDDp5nBSvQKpeRSoleANTX97HmK+QRmChlfTaKV
         jGVVnWVywSPSjU/a1ky6Uzb13fGSTlUMNszCrAZnwHKYSsuJRvLnm9XnY/hSfuhXTxbY
         UP3EsrGopcq32sK+1wS/JrcKLEUuEmAHuhB8T0Rlkd63ALxbuaOALnGeUDDAZpvicfFw
         wBm6+MTqaNHlBnO60iQ98zQp0sfAdXY84wjR0IIBqqmM+NTV5XhCYShRZXQ6l/lxcEcD
         0TdQrSd2U16XmkLX3UFTO3u2dhKUX1gwgXDG+2jiPAWkcbZRzCOEACiokc4Ud8V0GdU2
         4mgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=95RmrDaOTs+TArBQIen65/TK8NYN58Pk/yEsVpA/XLQ=;
        b=WLf+BQbaMltF8Gj8S5y9Ot59WwKgnD7SVmEpK8Sq7ghGkxcseRO2Le5n+vOhN6F2Yn
         dvx/P8Px4klK5wnV60Bw3RWSv0OuRqCXcmhDn9mqAz59N3vy+tTI70YZikd8N9FPMSYm
         sQUpn6YcIQdDD2MVGnDcJGVo69xR+Bw7F09jBbVLHF9NH4Njl/+0U6SvtxSxkkyMn65y
         GE5bh+9QCptxz1RxItP99bDILt7SBN/un1NzK+PklOo9toDhvRHoW3DTW4cCrvao/M5d
         o3lqq0Vp8ql0HXv21nn7Vw4q98DcFcz460dezvwW65YpFOOggiblpA2kxDTIwZG+bBcU
         OjBA==
X-Gm-Message-State: ACgBeo1JjZcnDPxVirrvvKesChS9+w2fdRO3AAF9kHSABnnnzrBZaW0u
        38NCE13wOSEx3+z2ki6AM20m0g==
X-Google-Smtp-Source: AA6agR6iuIfqsnKC8rmEvnL+RqpghMmdGBLz80IUfA88+gmFc61k0TjFisYsOWDicYjBJ7EdB/T1VA==
X-Received: by 2002:a17:90b:17ce:b0:1f4:d068:5722 with SMTP id me14-20020a17090b17ce00b001f4d0685722mr31558785pjb.28.1660644411079;
        Tue, 16 Aug 2022 03:06:51 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id y24-20020a631818000000b004202cb1c491sm7219029pgl.31.2022.08.16.03.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 03:06:50 -0700 (PDT)
From:   Shunsuke Mie <mie@igel.co.jp>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shunsuke Mie <mie@igel.co.jp>
Subject: [PATCH] misc: pci_endpoint_test: Fix pci_endpoint_test_{copy,write,read}() panic
Date:   Tue, 16 Aug 2022 19:06:17 +0900
Message-Id: <20220816100617.90720-1-mie@igel.co.jp>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Although dma_map_single() doesn't permit zero length mapping, the each
test functions called the function without zero checking.

A panic was reported on arm64:

[   60.137988] ------------[ cut here ]------------
[   60.142630] kernel BUG at kernel/dma/swiotlb.c:624!
[   60.147508] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
[   60.152992] Modules linked in: dw_hdmi_cec crct10dif_ce simple_bridge rcar_fdp1 vsp1 rcar_vin videobuf2_vmalloc rcar_csi2 v4l
2_mem2mem videobuf2_dma_contig videobuf2_memops pci_endpoint_test videobuf2_v4l2 videobuf2_common rcar_fcp v4l2_fwnode v4l2_asyn
c videodev mc gpio_bd9571mwv max9611 pwm_rcar ccree at24 authenc libdes phy_rcar_gen3_usb3 usb_dmac display_connector pwm_bl
[   60.186252] CPU: 0 PID: 508 Comm: pcitest Not tainted 6.0.0-rc1rpci-dev+ #237
[   60.193387] Hardware name: Renesas Salvator-X 2nd version board based on r8a77951 (DT)
[   60.201302] pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   60.208263] pc : swiotlb_tbl_map_single+0x2c0/0x590
[   60.213149] lr : swiotlb_map+0x88/0x1f0
[   60.216982] sp : ffff80000a883bc0
[   60.220292] x29: ffff80000a883bc0 x28: 0000000000000000 x27: 0000000000000000
[   60.227430] x26: 0000000000000000 x25: ffff0004c0da20d0 x24: ffff80000a1f77c0
[   60.234567] x23: 0000000000000002 x22: 0001000040000010 x21: 000000007a000000
[   60.241703] x20: 0000000000200000 x19: 0000000000000000 x18: 0000000000000000
[   60.248840] x17: 0000000000000000 x16: 0000000000000000 x15: ffff0006ff7b9180
[   60.255977] x14: ffff0006ff7b9180 x13: 0000000000000000 x12: 0000000000000000
[   60.263113] x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
[   60.270249] x8 : 0001000000000010 x7 : ffff0004c6754b20 x6 : 0000000000000000
[   60.277385] x5 : ffff0004c0da2090 x4 : 0000000000000000 x3 : 0000000000000001
[   60.284521] x2 : 0000000040000000 x1 : 0000000000000000 x0 : 0000000040000010
[   60.291658] Call trace:
[   60.294100]  swiotlb_tbl_map_single+0x2c0/0x590
[   60.298629]  swiotlb_map+0x88/0x1f0
[   60.302115]  dma_map_page_attrs+0x188/0x230
[   60.306299]  pci_endpoint_test_ioctl+0x5e4/0xd90 [pci_endpoint_test]
[   60.312660]  __arm64_sys_ioctl+0xa8/0xf0
[   60.316583]  invoke_syscall+0x44/0x108
[   60.320334]  el0_svc_common.constprop.0+0xcc/0xf0
[   60.325038]  do_el0_svc+0x2c/0xb8
[   60.328351]  el0_svc+0x2c/0x88
[   60.331406]  el0t_64_sync_handler+0xb8/0xc0
[   60.335587]  el0t_64_sync+0x18c/0x190
[   60.339251] Code: 52800013 d2e00414 35fff45c d503201f (d4210000)
[   60.345344] ---[ end trace 0000000000000000 ]---

To fix it, this patch adds checkings the payload length if it is zero.

Fixes: 343dc693f7b7 ("misc: pci_endpoint_test: Prevent some integer overflows")
Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---
 drivers/misc/pci_endpoint_test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 8f786a225dcf..d45426a73396 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -364,7 +364,7 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test,
 	}
 
 	size = param.size;
-	if (size > SIZE_MAX - alignment)
+	if (size > SIZE_MAX - alignment || !size)
 		goto err;
 
 	use_dma = !!(param.flags & PCITEST_FLAGS_USE_DMA);
@@ -498,7 +498,7 @@ static bool pci_endpoint_test_write(struct pci_endpoint_test *test,
 	}
 
 	size = param.size;
-	if (size > SIZE_MAX - alignment)
+	if (size > SIZE_MAX - alignment || !size)
 		goto err;
 
 	use_dma = !!(param.flags & PCITEST_FLAGS_USE_DMA);
@@ -596,7 +596,7 @@ static bool pci_endpoint_test_read(struct pci_endpoint_test *test,
 	}
 
 	size = param.size;
-	if (size > SIZE_MAX - alignment)
+	if (size > SIZE_MAX - alignment || !size)
 		goto err;
 
 	use_dma = !!(param.flags & PCITEST_FLAGS_USE_DMA);
-- 
2.17.1

