Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD18A559C99
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 16:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbiFXOgI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jun 2022 10:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbiFXOfe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jun 2022 10:35:34 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B89052E73;
        Fri, 24 Jun 2022 07:35:06 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 963255BC7;
        Fri, 24 Jun 2022 17:36:06 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 963255BC7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1656081366;
        bh=eZJCm0AAkbUv0jX9isFHiuFTWmDQfjgYU9WOqBXywpQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=gqDVUwppG2fXcICcwbHl119W4XVyIzXmLE//bdhztWZC0wrJt+C67Gs/WpmdlzZ95
         FU6P0hraCYESbxxkRcoF7Wx4fkpFcTmzHqM3BGSec2HuWrLweMSce8rxVsNE9jAKuc
         Agw1vjQH/Z1i/YJMRndMy5tUoypzk4S9vW+05jY8=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 24 Jun 2022 17:34:45 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND v5 16/18] PCI: dwc-plat: Simplify the probe method return value handling
Date:   Fri, 24 Jun 2022 17:34:26 +0300
Message-ID: <20220624143428.8334-17-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220624143428.8334-1-Sergey.Semin@baikalelectronics.ru>
References: <20220624143428.8334-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Rob Herring <robh@kernel.org>
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

