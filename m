Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31716424E3
	for <lists+linux-pci@lfdr.de>; Mon,  5 Dec 2022 09:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbiLEInH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Dec 2022 03:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbiLEInE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Dec 2022 03:43:04 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1633763C6
        for <linux-pci@vger.kernel.org>; Mon,  5 Dec 2022 00:42:52 -0800 (PST)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NQcQT6jgpzqSvW;
        Mon,  5 Dec 2022 16:38:41 +0800 (CST)
Received: from huawei.com (10.175.100.227) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 5 Dec
 2022 16:42:49 +0800
From:   Shang XiaoJing <shangxiaojing@huawei.com>
To:     <paul.walmsley@sifive.com>, <greentime.hu@sifive.com>,
        <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>, <erik.danie@sifive.com>, <hes@sifive.com>,
        <linux-pci@vger.kernel.org>
CC:     <shangxiaojing@huawei.com>
Subject: [PATCH] PCI: fu740: Fix missing clk_disable_unprepare() in fu740_pcie_host_init()
Date:   Mon, 5 Dec 2022 16:40:44 +0800
Message-ID: <20221205084044.19936-1-shangxiaojing@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The clk_disable_unprepare() should be called in the error handling of
fu740_pcie_host_init().

Fixes: e7e21b3a339b ("PCI: fu740: Add SiFive FU740 PCIe host controller driver")
Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
---
 drivers/pci/controller/dwc/pcie-fu740.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-fu740.c b/drivers/pci/controller/dwc/pcie-fu740.c
index 0c90583c078b..6d5b7fdc0048 100644
--- a/drivers/pci/controller/dwc/pcie-fu740.c
+++ b/drivers/pci/controller/dwc/pcie-fu740.c
@@ -261,6 +261,7 @@ static int fu740_pcie_host_init(struct dw_pcie_rp *pp)
 	ret = reset_control_deassert(afp->rst);
 	if (ret) {
 		dev_err(dev, "unable to deassert pcie_power_up_rst_n\n");
+		clk_disable_unprepare(afp->pcie_aux);
 		return ret;
 	}
 
-- 
2.17.1

