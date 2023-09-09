Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925B17995C8
	for <lists+linux-pci@lfdr.de>; Sat,  9 Sep 2023 03:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234841AbjIIBmU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Sep 2023 21:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbjIIBmT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Sep 2023 21:42:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF8A1FE0;
        Fri,  8 Sep 2023 18:42:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C00BC433BB;
        Sat,  9 Sep 2023 00:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694219028;
        bh=H6a1aURnFd4oVdvbRBmRi8y7C0Jcr43sFa/mWBxl9KE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D6hNClG850u+HoiBbqZVE6y11zKFITpW9VGFwAYspAJDJCgbUE3HcV+M/VmmwNJtz
         vje6WKWZJd3rNFgn82lMHsPw9WlM5x7IRZ6CNbzecIscSoIJJsTyXadKOVN/KjBrrP
         49YdYxKtt3LvwKKMDw63PYrbm2BABAoiYIJ/Uej3g/Pn4YG0JXnd1Nv0UYbrYnBsj3
         aoxTfXGvDTCMJoW2pnSxeX0hm0HYnjezoHynrTfjfOBy75laJBBmtl9mHfeKtWzwM4
         lMiRd7/c/26alFL2a2BDk9B8hUtnuakxWg7njaMHd1tgkg+Gl2rDwQSNnnz1rn4VIp
         UzA5JhR5X4aLg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yong-Xuan Wang <yongxuan.wang@sifive.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Sasha Levin <sashal@kernel.org>, paul.walmsley@sifive.com,
        greentime.hu@sifive.com, kw@linux.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 7/7] PCI: fu740: Set the number of MSI vectors
Date:   Fri,  8 Sep 2023 20:23:26 -0400
Message-Id: <20230909002329.3578534-7-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230909002329.3578534-1-sashal@kernel.org>
References: <20230909002329.3578534-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.131
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index 78d002be4f821..f6c71c1b657b6 100644
--- a/drivers/pci/controller/dwc/pcie-fu740.c
+++ b/drivers/pci/controller/dwc/pcie-fu740.c
@@ -301,6 +301,7 @@ static int fu740_pcie_probe(struct platform_device *pdev)
 	pci->dev = dev;
 	pci->ops = &dw_pcie_ops;
 	pci->pp.ops = &fu740_pcie_host_ops;
+	pci->pp.num_vectors = MAX_MSI_IRQS;
 
 	/* SiFive specific region: mgmt */
 	afp->mgmt_base = devm_platform_ioremap_resource_byname(pdev, "mgmt");
-- 
2.40.1

