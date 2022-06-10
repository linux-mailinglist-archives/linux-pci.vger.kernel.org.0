Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD206545F07
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jun 2022 10:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347478AbiFJI3i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jun 2022 04:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347748AbiFJI1u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jun 2022 04:27:50 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 00120AE4D;
        Fri, 10 Jun 2022 01:26:12 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id E14AE16A4;
        Fri, 10 Jun 2022 11:26:43 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com E14AE16A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1654849603;
        bh=3MvYX2gSsYGdqr08ji+XGUNZWE/94NNXQE7xjF2HVRU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=VUVSJtb4WL9uxlfy/r9jqZJ4LI6dKSAO0kx98V4crgUG/uoFx2t+em+dD9FYpPaP4
         aDBUDQ3nz8heLjRyj/2ze5Lc8aNJYmJhitkACAa7q2uuc3RHhMd4rYK2ZGhpvZOGYe
         UFKAONuIq0aWXmOp5j4m6pCs+/FV1jBSYdz0Q0LQ=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 10 Jun 2022 11:25:50 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 16/18] PCI: dwc-plat: Simplify the probe method return value handling
Date:   Fri, 10 Jun 2022 11:25:32 +0300
Message-ID: <20220610082535.12802-17-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220610082535.12802-1-Sergey.Semin@baikalelectronics.ru>
References: <20220610082535.12802-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

The whole switch-case-logic implemented in the DWC PCIe RC/EP probe
procedure doesn't seem well thought through. First of all the ret variable
is unused in the EP-case and is only partly involved in the RC-case of the
switch-case statement, which unnecessary complicates the code. Secondly
the probe method will return zero if an unknown mode is detected. That is
improbable situation since the OF-device data is initialized only with
valid modes, but such code is still wrong at least from maintainability
point of view. So let's convert the switch-case part of the probe function
to being more coherent. We suggest to use the local ret variable to
preserve the status of the case-clauses and return its value from the
probe procedure after the work is done.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-designware-plat.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c b/drivers/pci/controller/dwc/pcie-designware-plat.c
index 97de6ad7f9db..c6871bebf3fe 100644
--- a/drivers/pci/controller/dwc/pcie-designware-plat.c
+++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
@@ -143,20 +143,21 @@ static int dw_plat_pcie_probe(struct platform_device *pdev)
 			return -ENODEV;
 
 		ret = dw_plat_add_pcie_port(dw_plat_pcie, pdev);
-		if (ret < 0)
-			return ret;
 		break;
 	case DW_PCIE_EP_TYPE:
 		if (!IS_ENABLED(CONFIG_PCIE_DW_PLAT_EP))
 			return -ENODEV;
 
 		pci->ep.ops = &pcie_ep_ops;
-		return dw_pcie_ep_init(&pci->ep);
+		ret = dw_pcie_ep_init(&pci->ep);
+		break;
 	default:
 		dev_err(dev, "INVALID device type %d\n", dw_plat_pcie->mode);
+		ret = -EINVAL;
+		break;
 	}
 
-	return 0;
+	return ret;
 }
 
 static const struct dw_plat_pcie_of_data dw_plat_pcie_rc_of_data = {
-- 
2.35.1

