Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB0C5AE51C
	for <lists+linux-pci@lfdr.de>; Tue,  6 Sep 2022 12:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238941AbiIFKQK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Sep 2022 06:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234241AbiIFKQJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Sep 2022 06:16:09 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E614E2DAB4
        for <linux-pci@vger.kernel.org>; Tue,  6 Sep 2022 03:16:05 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id 9so7601832plj.11
        for <linux-pci@vger.kernel.org>; Tue, 06 Sep 2022 03:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=PSI0JSTR6ajvpst5Ao0UXAh2Ubf3cYvnj2IZbT0+W3o=;
        b=B+HLStzWZ6dE78OhNa1sVeVMpWXI2SUo4JcT6k+etTosGiY2l88gWyRinw8ehugasC
         zMJR28eNOmTO6G72ZWpla5T1aB5sNqfM+89g/WczZptoWCCUQCaZpYWzrii9Irvkp1ev
         WgIiD2CHBWiXuS/1x8nGvTIgTkKb3hYdYL5tlyxP1geqHaGK5SoWDVktgf/wo5bymYoZ
         DUPEgMixavBC+jRDIKXl/vqgMWRdmJOV19zqXsFZWRljYlF4lKsh/xYCpeav+PP+BkzB
         85vxCL+aOy3w6kj9PyGCLcJp3XoGwXLqoz+dRH4kbYdfhJ9rp0YwGhi5fU5N5HBgt+3D
         EvRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=PSI0JSTR6ajvpst5Ao0UXAh2Ubf3cYvnj2IZbT0+W3o=;
        b=nMO+cSpX5AytbULVsvyzhzIE198JLZ+7UhpOxZYGKiR91fspV12+mE3LTW2KMwO/AB
         sdSlTYD02ZZKvLYMrWxzDeIz3HaIP3Sx7MivedkbUw/iKoSRHWUoG9UgUEisopR7MzFU
         Wni/dp/X4usWld3uHA8/fUJRFPayuB1CJUZt5mqE1t0PBk7CLiCLznW02KrehfaLQo1F
         JiFdPWQlGZHlxBivOkLY6zZuFW34SW4zJwlyDHhZZ3PN6pV6w+pY0zt7dKzG4SRYBIvh
         JFjkeL733FktaXk2KCeXEOVV9fjZb7XM0FgMnQ69PkJSWLCqgIXbtDPvgeetdqQWnkza
         5QmA==
X-Gm-Message-State: ACgBeo27M/zBOrTq2cyc2VNmR5FyqNRTdtyk+T1dhrTnpMP4aPcsaYyC
        NQDB/LGzT506Rx2ZKbcUPKKC3w==
X-Google-Smtp-Source: AA6agR7l9hMxw2a+fj6VjmlhPXMJGnrDQPYbitZUj+wR5dmA04lAOaePB2o9KHfDwD8n1wpXl3Uv9g==
X-Received: by 2002:a17:902:ec90:b0:16d:d156:2c01 with SMTP id x16-20020a170902ec9000b0016dd1562c01mr55140422plg.114.1662459365393;
        Tue, 06 Sep 2022 03:16:05 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id f62-20020a625141000000b0053b723a74f7sm7914151pfb.90.2022.09.06.03.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 03:16:04 -0700 (PDT)
From:   Shunsuke Mie <mie@igel.co.jp>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shunsuke Mie <mie@igel.co.jp>
Subject: [RFC PATCH v2 2/2] misc: pci_endpoint_test: Fix pci_endpoint_test_{copy,write,read}() panic
Date:   Tue,  6 Sep 2022 19:15:55 +0900
Message-Id: <20220906101555.106033-2-mie@igel.co.jp>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220906101555.106033-1-mie@igel.co.jp>
References: <20220906101555.106033-1-mie@igel.co.jp>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The dma_map_single() doesn't permit zero length mapping. It causes a follow
panic.

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

To fix it, this patch adds a checking the payload length if it is zero.

Fixes: 343dc693f7b7 ("misc: pci_endpoint_test: Prevent some integer overflows")
Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---
Changes in v2:
* Move a checking code to an introduced function in previous patch
---
---
 drivers/misc/pci_endpoint_test.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 3bd9f135cdac..a7193bf6a49f 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -335,6 +335,11 @@ static bool pci_endpoint_test_msi_irq(struct pci_endpoint_test *test,
 static int pci_endpoint_test_validate_xfer_params(struct device *dev,
 		struct pci_endpoint_test_xfer_param *param, size_t alignment)
 {
+	if (!param->size) {
+		dev_err(dev, "Data size is zero\n");
+		return -EINVAL;
+	}
+
 	if (param->size > SIZE_MAX - alignment) {
 		dev_err(dev, "Maximum transfer data size exceeded\n");
 		return -EINVAL;
-- 
2.17.1

