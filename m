Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2AF799330
	for <lists+linux-pci@lfdr.de>; Sat,  9 Sep 2023 02:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345418AbjIIAWv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Sep 2023 20:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345491AbjIIAWu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Sep 2023 20:22:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E3526BF;
        Fri,  8 Sep 2023 17:22:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 984E4C433CC;
        Sat,  9 Sep 2023 00:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694218950;
        bh=2s3vHOMcNdcrZU+wGpSckbUw5LTnWIjmBpY4tiNXT3Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h1jK6Px8UVMlZIyTRqfF3Ol2MbaiWqIUw+lFYEUnmxCEVXlIRjUnpZ6VG4vflzmOO
         NDlkNfxXV1v5sT+gImxLpyc3GYj8ah/8gm5+ztxr8L3YSXUNykBMPK4WlNNUF56p6C
         xYz4lq2wIrwr14mCziSOPg3LW5pTZroF+wvuyJy8mzokiSvLVVHe1pkekPAvKHt6F1
         9BnmPRXn8e/lLchQi6bjNiU+C2NOXGjA++2wQwBUMnJiCy4LgEHYnUVhvTasG/aVJJ
         QgVTCS2ocz6KoZIefQ7z+X+hRTkQU7/MxWCFgGQ726HsFn2497e0Z253a+/AXFxOF6
         rnSqj9VNgYPnw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yong-Xuan Wang <yongxuan.wang@sifive.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Sasha Levin <sashal@kernel.org>, paul.walmsley@sifive.com,
        greentime.hu@sifive.com, kw@linux.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 11/11] PCI: fu740: Set the number of MSI vectors
Date:   Fri,  8 Sep 2023 20:22:04 -0400
Message-Id: <20230909002205.3578068-11-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230909002205.3578068-1-sashal@kernel.org>
References: <20230909002205.3578068-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.2
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Yong-Xuan Wang <yongxuan.wang@sifive.com>

[ Upstream commit 551a60e1225e71fff8efd9390204c505b0870e0f ]

The iMSI-RX module of the DW PCIe controller provides multiple sets of
MSI_CTRL_INT_i_* registers, and each set is capable of handling 32 MSI
interrupts. However, the fu740 PCIe controller driver only enabled one set
of MSI_CTRL_INT_i_* registers, as the total number of supported interrupts
was not specified.

Set the supported number of MSI vectors to enable all the MSI_CTRL_INT_i_*
registers on the fu740 PCIe core, allowing the system to fully utilize the
available MSI interrupts.

Link: https://lore.kernel.org/r/20230807055621.2431-1-yongxuan.wang@sifive.com
Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pcie-fu740.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-fu740.c b/drivers/pci/controller/dwc/pcie-fu740.c
index 0c90583c078bf..1e9b44b8bba48 100644
--- a/drivers/pci/controller/dwc/pcie-fu740.c
+++ b/drivers/pci/controller/dwc/pcie-fu740.c
@@ -299,6 +299,7 @@ static int fu740_pcie_probe(struct platform_device *pdev)
 	pci->dev = dev;
 	pci->ops = &dw_pcie_ops;
 	pci->pp.ops = &fu740_pcie_host_ops;
+	pci->pp.num_vectors = MAX_MSI_IRQS;
 
 	/* SiFive specific region: mgmt */
 	afp->mgmt_base = devm_platform_ioremap_resource_byname(pdev, "mgmt");
-- 
2.40.1

