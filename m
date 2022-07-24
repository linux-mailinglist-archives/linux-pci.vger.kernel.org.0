Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3BE457F4A7
	for <lists+linux-pci@lfdr.de>; Sun, 24 Jul 2022 12:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbiGXKQJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 24 Jul 2022 06:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbiGXKQJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 24 Jul 2022 06:16:09 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE991F5A2;
        Sun, 24 Jul 2022 03:16:07 -0700 (PDT)
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LrJsr6BWnzkWR3;
        Sun, 24 Jul 2022 18:13:36 +0800 (CST)
Received: from dggpeml500008.china.huawei.com (7.185.36.147) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 24 Jul 2022 18:16:05 +0800
Received: from huawei.com (10.67.175.34) by dggpeml500008.china.huawei.com
 (7.185.36.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sun, 24 Jul
 2022 18:16:04 +0800
From:   Ren Zhijie <renzhijie2@huawei.com>
To:     <hongxing.zhu@nxp.com>, <l.stach@pengutronix.de>,
        <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Ren Zhijie <renzhijie2@huawei.com>
Subject: [PATCH -next] PCI: imx6: Fix build error unused-function
Date:   Sun, 24 Jul 2022 18:13:53 +0800
Message-ID: <20220724101353.127875-1-renzhijie2@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.175.34]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500008.china.huawei.com (7.185.36.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If CONFIG_PM_SLEEP is not set,
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-, will be failed, like this:

drivers/pci/controller/dwc/pci-imx6.c:973:13: error: ‘imx6_pcie_host_exit’ defined but not used [-Werror=unused-function]
 static void imx6_pcie_host_exit(struct dw_pcie_rp *pp)
             ^~~~~~~~~~~~~~~~~~~
drivers/pci/controller/dwc/pci-imx6.c:904:13: error: ‘imx6_pcie_stop_link’ defined but not used [-Werror=unused-function]
 static void imx6_pcie_stop_link(struct dw_pcie *pci)
             ^~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[4]: *** [drivers/pci/controller/dwc/pci-imx6.o] Error 1

These two functions imx6_pcie_host_exit() and imx6_pcie_stop_link() only be called by imx6_pcie_suspend_noirq(), which was warpped by CONFIG_PM_SLEEP.
To fix build error unused-function, use __maybe_unused to attach them.

Fixes: 25ae5434c3de ("PCI: imx6: Reformat suspend callback to keep symmetric with resume")
Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 55e109d1ab27..533f5ef68e94 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -901,7 +901,7 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
 	return 0;
 }
 
-static void imx6_pcie_stop_link(struct dw_pcie *pci)
+static void __maybe_unused imx6_pcie_stop_link(struct dw_pcie *pci)
 {
 	struct device *dev = pci->dev;
 
@@ -970,7 +970,7 @@ static int imx6_pcie_host_init(struct dw_pcie_rp *pp)
 	return ret;
 }
 
-static void imx6_pcie_host_exit(struct dw_pcie_rp *pp)
+static void __maybe_unused imx6_pcie_host_exit(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pci);
-- 
2.17.1

