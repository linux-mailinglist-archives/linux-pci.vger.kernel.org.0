Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8454E519041
	for <lists+linux-pci@lfdr.de>; Tue,  3 May 2022 23:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242936AbiECV1X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 May 2022 17:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242863AbiECV1W (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 May 2022 17:27:22 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 691CE41632;
        Tue,  3 May 2022 14:23:33 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 5E05C16D6;
        Wed,  4 May 2022 00:24:06 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru 5E05C16D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1651613046;
        bh=1LEzq7uEU4+vzq4sUsHD/tXEJkpmJ5noJd8Q4gwxeW0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=Wm8lntYhHD+s0DZu0M6heTk/HA+0VKSZTEafivcsfmtOgeE5OigbvIDEgpSutpCYo
         cHRaCxkNTr5Vp380O06v5yjs0YwbM1vr/BVeURebWcx6g5+o6F3ebwm0sp3X4CTK4l
         wsxMLL/PnsmJbMtYOTEdRprw9q2DPfqjA5VPTthw=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 4 May 2022 00:23:32 +0300
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
Subject: [PATCH v2 07/13] PCI: dwc: Add trailing new-line literals to the log messages
Date:   Wed, 4 May 2022 00:22:54 +0300
Message-ID: <20220503212300.30105-8-Sergey.Semin@baikalelectronics.ru>
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

There are two places in the DW PCIe controller driver, which omit the
trailing newlines in the log info and warn messages. Not having them there
will cause leaving the messages in the printk ring buffer until a next
'\n'-terminated message is printed (it will consequently cause the buffer
flush). As it isn't what the corresponding code implies let's add the
new-line characters in the messages.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 2 +-
 drivers/pci/controller/dwc/pcie-designware.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 4e5c89c19f78..1c815d3bead9 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -662,7 +662,7 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 		}
 
 		if (pci->num_ob_windows <= atu_idx)
-			dev_warn(pci->dev, "Resources exceed number of ATU entries (%d)",
+			dev_warn(pci->dev, "Resources exceed number of ATU entries (%d)\n",
 				 pci->num_ob_windows);
 	}
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 9f4d2b44612b..3bd1cfd12148 100644
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

