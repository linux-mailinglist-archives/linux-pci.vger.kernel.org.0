Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8CA545EFE
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jun 2022 10:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346881AbiFJI3a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jun 2022 04:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347640AbiFJI1q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jun 2022 04:27:46 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 668382DE8;
        Fri, 10 Jun 2022 01:25:55 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id C1255BD9;
        Fri, 10 Jun 2022 11:26:34 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com C1255BD9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1654849594;
        bh=VjW3xaVAbKchksNdRhBI4i2OOsfSLrHLqX3SHbxoV/4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=pUqPVeBUUsnW0B2fEtGPusOKUpOydcs7GeKnmlOcBfI6xLx/PZHrwgmf2PghGwoDy
         sxnq3BdpKZIdEofZL1byDaW5Az0Mupdt5iYk7H50kCGZPhDkVoRTFikJKRUPZSak9J
         XMrEHBHQiqqF5zciw0XlpgpVUJ2JkT+oeUMxm7Kw=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 10 Jun 2022 11:25:42 +0300
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
Subject: [PATCH v4 08/18] PCI: dwc: Add trailing new-line literals to the log messages
Date:   Fri, 10 Jun 2022 11:25:24 +0300
Message-ID: <20220610082535.12802-9-Sergey.Semin@baikalelectronics.ru>
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

There are two places in the DW PCIe controller driver, which omit the
trailing newlines in the log info and warn messages. Not having them there
will cause leaving the messages in the printk ring buffer until a next
'\n'-terminated message is printed (it will consequently cause the buffer
flush). As it isn't what the corresponding code implies let's add the
new-line characters in the messages.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 2 +-
 drivers/pci/controller/dwc/pcie-designware.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index f686727bd3c1..52ca9d9121f9 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -632,7 +632,7 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 		}
 
 		if (pci->num_ob_windows <= atu_idx)
-			dev_warn(pci->dev, "Resources exceed number of ATU entries (%d)",
+			dev_warn(pci->dev, "Resources exceed number of ATU entries (%d)\n",
 				 pci->num_ob_windows);
 	}
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index d0061735b434..ac966ed28c5b 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -706,7 +706,7 @@ void dw_pcie_iatu_detect(struct dw_pcie *pci)
 	dev_info(pci->dev, "iATU unroll: %s\n", pci->iatu_unroll_enabled ?
 		"enabled" : "disabled");
 
-	dev_info(pci->dev, "Detected iATU regions: %u outbound, %u inbound",
+	dev_info(pci->dev, "Detected iATU regions: %u outbound, %u inbound\n",
 		 pci->num_ob_windows, pci->num_ib_windows);
 }
 
-- 
2.35.1

