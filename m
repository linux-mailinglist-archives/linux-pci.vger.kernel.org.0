Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75495AF9A0
	for <lists+linux-pci@lfdr.de>; Wed,  7 Sep 2022 04:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiIGCBT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Sep 2022 22:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiIGCBQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Sep 2022 22:01:16 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C9A12770
        for <linux-pci@vger.kernel.org>; Tue,  6 Sep 2022 19:01:14 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id o2-20020a17090a9f8200b0020025a22208so9545857pjp.2
        for <linux-pci@vger.kernel.org>; Tue, 06 Sep 2022 19:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=uktNvaAntymn23sWuKukykoXR7lnZlSrw+MD00LvhNw=;
        b=jbJnenQmzEGECx+0Lm/pj2ekA8GF8UaJdB3OYWsMxeVoqdRAQLooLsXHuTZQcq3SDL
         gdE7keaSfdrCVuIzf39deq5+Cufwo/31lIh6dKEE/0QRGWdIEzRNmX7ULvHJUk1WsrPb
         m70Zf8ztPOe7EY+u/UJK+2+XgtZJA7mCzJkUEDyUPdM4+qqYC9CFvdg85JEcsvJRyMpy
         vOmrd+bOlyclMoxfvgZxH/rm6fBNJpPIne1lveYcnnfPIWwY8xDOJv//sV6oUj8FPVbR
         TCA908o8D7DJnyEPO1l7oQS6lUUEihm6+iE16bB1oiw5zhBjDGK7F2+pNNlST65F8d0Q
         tG/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=uktNvaAntymn23sWuKukykoXR7lnZlSrw+MD00LvhNw=;
        b=V9zIhuY+6qNUkWHQi8eox8XtzKA+ShQrQU/uoJ95oF+FPiwevPhfS/0n2uZ6SO0wSt
         7KcZZfX1YIn08ergBS5dAHexXrhAjMiAuvOa+zFRZdPXAS3LaDfZ1CJ4KkDppyfDZcN3
         +DGR0JMEDP9ohnLXuiU1uppcN/Lj2wlybMsA15mSo2TJyl571I/9zS4y3hUDaHR0LOsM
         mthJjL594OQC4QPbIV/XpFvyU5EzYavG+yeRTxNWR/orloi1mk4VRR/GdgW/+sYIlYjo
         dx4LTm6v4iYuwSZrtOtk2eNOtwFJGToT7GpT3ee0d86IdYDfvNxsVjq7NwT8yqezTpBQ
         Wl6g==
X-Gm-Message-State: ACgBeo0fodZz3df2/7yCrkcRkKP7nSbW/Od3J3ErD9rhZU0mkwCd0YpZ
        RYtyXFHGV+9+e3UjrY8BzO4y3g==
X-Google-Smtp-Source: AA6agR6JnpfEfa154bfnWalgy1O3fC4Gxhooqg4c9nsd7KWFD8pivpvJETaTcUfrbdVM28MACeXgiA==
X-Received: by 2002:a17:90a:6d62:b0:200:579f:e4ea with SMTP id z89-20020a17090a6d6200b00200579fe4eamr15177561pjj.244.1662516074169;
        Tue, 06 Sep 2022 19:01:14 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id s59-20020a17090a2f4100b002005c3d4d4fsm5182369pjd.19.2022.09.06.19.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 19:01:13 -0700 (PDT)
From:   Shunsuke Mie <mie@igel.co.jp>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shunsuke Mie <mie@igel.co.jp>
Subject: [PATCH v3 2/2] misc: pci_endpoint_test: Fix pci_endpoint_test_{copy,write,read}() panic
Date:   Wed,  7 Sep 2022 11:01:00 +0900
Message-Id: <20220907020100.122588-2-mie@igel.co.jp>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220907020100.122588-1-mie@igel.co.jp>
References: <20220907020100.122588-1-mie@igel.co.jp>
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
Changes in v3:
* Change to use dev_dbg() instead of the dev_err().

Changes in v2:
* Move a checking code to an introduced function in previous patch.
---
---
 drivers/misc/pci_endpoint_test.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 39d477bb0989..11530b4ec389 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -335,6 +335,11 @@ static bool pci_endpoint_test_msi_irq(struct pci_endpoint_test *test,
 static int pci_endpoint_test_validate_xfer_params(struct device *dev,
 		struct pci_endpoint_test_xfer_param *param, size_t alignment)
 {
+	if (!param->size) {
+		dev_dbg(dev, "Data size is zero\n");
+		return -EINVAL;
+	}
+
 	if (param->size > SIZE_MAX - alignment) {
 		dev_dbg(dev, "Maximum transfer data size exceeded\n");
 		return -EINVAL;
-- 
2.17.1

