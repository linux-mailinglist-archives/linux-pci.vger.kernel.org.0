Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E10518FAA
	for <lists+linux-pci@lfdr.de>; Tue,  3 May 2022 23:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241395AbiECVBF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 May 2022 17:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236009AbiECVBE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 May 2022 17:01:04 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 730081F637;
        Tue,  3 May 2022 13:57:30 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 554B916D1;
        Tue,  3 May 2022 23:58:03 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru 554B916D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1651611483;
        bh=Xn98MR7V1F/LIQ3Yu3hI7bvvVoawgSacfNBPSyIHRWs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=dsLSE21xSeEZAu+nC7Bv28qHIii5vOg4dwe37ES+wh3jc8kIPRSXwONifvj3uMuRB
         j/YbSffLy1rS0YNRXTfSngIcLkCuEbH8g8tqSj3erqy1Lf73Z/hGvVxsZ4oY+Vl2wc
         Y6NhDbKufsXvXdA9KLvnCUPeex7vMAunRZqY3Rco=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 3 May 2022 23:57:28 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        <linux-clk@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-mips@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/4] clk: baikal-t1: Fix invalid xGMAC PTP clock divider
Date:   Tue, 3 May 2022 23:57:19 +0300
Message-ID: <20220503205722.24755-2-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220503205722.24755-1-Sergey.Semin@baikalelectronics.ru>
References: <20220503205722.24755-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Most likely due to copy-paste mistake the divider has been set to 10 while
according to the SoC reference manual it's supposed to be 8 thus having
PTP clock frequency of 156.25 MHz.

Fixes: 353afa3a8d2e ("clk: Add Baikal-T1 CCU Dividers driver")
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/clk/baikal-t1/clk-ccu-div.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/baikal-t1/clk-ccu-div.c b/drivers/clk/baikal-t1/clk-ccu-div.c
index f141fda12b09..ea77eec40ddd 100644
--- a/drivers/clk/baikal-t1/clk-ccu-div.c
+++ b/drivers/clk/baikal-t1/clk-ccu-div.c
@@ -207,7 +207,7 @@ static const struct ccu_div_info sys_info[] = {
 	CCU_DIV_GATE_INFO(CCU_SYS_XGMAC_REF_CLK, "sys_xgmac_ref_clk",
 			  "eth_clk", CCU_SYS_XGMAC_BASE, 8),
 	CCU_DIV_FIXED_INFO(CCU_SYS_XGMAC_PTP_CLK, "sys_xgmac_ptp_clk",
-			   "eth_clk", 10),
+			   "eth_clk", 8),
 	CCU_DIV_GATE_INFO(CCU_SYS_USB_CLK, "sys_usb_clk",
 			  "eth_clk", CCU_SYS_USB_BASE, 10),
 	CCU_DIV_VAR_INFO(CCU_SYS_PVT_CLK, "sys_pvt_clk",
-- 
2.35.1

