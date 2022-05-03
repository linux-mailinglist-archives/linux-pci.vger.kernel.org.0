Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2B5519046
	for <lists+linux-pci@lfdr.de>; Tue,  3 May 2022 23:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242680AbiECV1b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 May 2022 17:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242900AbiECV1X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 May 2022 17:27:23 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F264D4198D;
        Tue,  3 May 2022 14:23:36 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 5607716D1;
        Wed,  4 May 2022 00:24:10 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru 5607716D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1651613050;
        bh=oslhO17dYHGFIhWNNUG9XBnFq2z7WSrBbWWUbSeRRGk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=hg6fXzul40AbgnhsWa/mt14/U61QAgb7Tv3MAONU1943Vu6RXmXADFl0MPk+Bfk+N
         f47aaEzcQRSJ7NvKQAthj2Wp78pYKoRl+Y8A/nDsuzmKSRyVPZ/zaP2NxHe26SsJss
         +7ysQfqaNQijiR/TRDdb8nRE4OjbTBrwjTUIgy2s=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 4 May 2022 00:23:36 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 11/13] PCI: dwc-plat: Simplify the probe method return value handling
Date:   Wed, 4 May 2022 00:22:58 +0300
Message-ID: <20220503212300.30105-12-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220503212300.30105-1-Sergey.Semin@baikalelectronics.ru>
References: <20220503212300.30105-1-Sergey.Semin@baikalelectronics.ru>
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
---
 drivers/pci/controller/dwc/pcie-designware-plat.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c b/drivers/pci/controller/dwc/pcie-designware-plat.c
index 0c5de87d3cc6..fea785096261 100644
--- a/drivers/pci/controller/dwc/pcie-designware-plat.c
+++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
@@ -153,20 +153,21 @@ static int dw_plat_pcie_probe(struct platform_device *pdev)
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

