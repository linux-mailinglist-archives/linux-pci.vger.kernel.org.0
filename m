Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87BF8717DF1
	for <lists+linux-pci@lfdr.de>; Wed, 31 May 2023 13:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234935AbjEaL0L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 May 2023 07:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjEaL0K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 May 2023 07:26:10 -0400
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B9895123;
        Wed, 31 May 2023 04:26:08 -0700 (PDT)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id CEC3DE0DEA;
        Wed, 31 May 2023 14:26:07 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=7SbAcuds+tlWFnTKWKdoeNb1Lhp8lSpPRXuDUOszIQI=; b=aImCJQZ014Me
        kT/OIT+rp+XA7RSh57y7bgpmGlYnUgNtn1t1ww0Ml58s+Fs93rIl3avwih4zqLZo
        r2pk2KMXOwxTgJ3LoIldRYNDvPl2zsv53S4FgfqsMqLamh85lJe+Ds8bSSGFlr6Q
        dkF6z3XvJiKP4VGcGRI6uGdk0hOKgDg=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id AB609E0DE3;
        Wed, 31 May 2023 14:26:07 +0300 (MSK)
Received: from localhost (10.8.30.6) by mail (192.168.51.25) with Microsoft
 SMTP Server (TLS) id 15.0.1395.4; Wed, 31 May 2023 14:26:07 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND v6 02/11] PCI: dwc: Fix inbound iATU entries out-of-bounds warning message
Date:   Wed, 31 May 2023 14:25:53 +0300
Message-ID: <20230531112602.7222-3-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230531112602.7222-1-Sergey.Semin@baikalelectronics.ru>
References: <20230531112602.7222-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.8.30.6]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The message is printed if the number of requested inbound iATU windows
exceed the device capability. In that case the message should either refer
to the "dma-ranges" DT property or to the DMA-ranges mapping. We suggest
to use the later version as a counterpart to the just CPU-ranges mapping.
In any case the current "Dma-ranges" phrase seems incorrect.

Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 9952057c8819..5718b4bb67f0 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -723,7 +723,7 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 	}
 
 	if (pci->num_ib_windows <= i)
-		dev_warn(pci->dev, "Dma-ranges exceed inbound iATU size (%u)\n",
+		dev_warn(pci->dev, "DMA-ranges exceed inbound iATU size (%u)\n",
 			 pci->num_ib_windows);
 
 	return 0;
-- 
2.40.0


