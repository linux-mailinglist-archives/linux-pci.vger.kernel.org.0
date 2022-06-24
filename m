Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0BF6559C7B
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 16:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbiFXOkL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jun 2022 10:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbiFXOkE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jun 2022 10:40:04 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D39A964783;
        Fri, 24 Jun 2022 07:40:02 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 757125BC8;
        Fri, 24 Jun 2022 17:41:18 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 757125BC8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1656081678;
        bh=sqybDdlfjcWMfGt3IouG+nXNJDDBjqxPG52I8Bh8Ud0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=gzyT8ZCm7WQ9gtQ24m5QWY7E476tB0fjnonSLQGQ9PRg4kYI0xC8ZAKqlIu2FbsBI
         3+ZxFNoyzXjXNZTSNIxNCvAISzO9kaIUB92+CH6Gwt4PP/h2+l/hh2TbWvM7t7E61u
         dPh/RAoZB66juFS2XF6S+/8LlkxJqZqkJkTO6I8E=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 24 Jun 2022 17:39:58 +0300
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
        Rob Herring <robh+dt@kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND v4 08/15] PCI: dwc: Add host de-initialization callback
Date:   Fri, 24 Jun 2022 17:39:40 +0300
Message-ID: <20220624143947.8991-9-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220624143947.8991-1-Sergey.Semin@baikalelectronics.ru>
References: <20220624143947.8991-1-Sergey.Semin@baikalelectronics.ru>
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

Seeing the platform-specific DW PCIe host-initialization is performed from
within the generic dw_pcie_host_init() method by means of the dedicated
dw_pcie_ops.host_init() callback, there must be declared an antagonist
which would perform the corresponding cleanups. Let's add such callback
then. It will be called in the dw_pcie_host_deinit() method and in the
cleanup-on-error path in the dw_pcie_host_init() function.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 .../pci/controller/dwc/pcie-designware-host.c | 21 ++++++++++++++-----
 drivers/pci/controller/dwc/pcie-designware.h  |  1 +
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index b1437b37140f..4f984c845b59 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -354,13 +354,14 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 			pp->num_vectors = MSI_DEF_NUM_VECTORS;
 		} else if (pp->num_vectors > MAX_MSI_IRQS) {
 			dev_err(dev, "Invalid number of vectors\n");
-			return -EINVAL;
+			ret = -EINVAL;
+			goto err_deinit_host;
 		}
 
 		if (pp->ops->msi_host_init) {
 			ret = pp->ops->msi_host_init(pp);
 			if (ret < 0)
-				return ret;
+				goto err_deinit_host;
 		} else if (pp->has_msi_ctrl) {
 			u32 ctrl, num_ctrls;
 
@@ -372,8 +373,10 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 				pp->msi_irq = platform_get_irq_byname_optional(pdev, "msi");
 				if (pp->msi_irq < 0) {
 					pp->msi_irq = platform_get_irq(pdev, 0);
-					if (pp->msi_irq < 0)
-						return pp->msi_irq;
+					if (pp->msi_irq < 0) {
+						ret = pp->msi_irq;
+						goto err_deinit_host;
+					}
 				}
 			}
 
@@ -381,7 +384,7 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 
 			ret = dw_pcie_allocate_domains(pp);
 			if (ret)
-				return ret;
+				goto err_deinit_host;
 
 			if (pp->msi_irq > 0)
 				irq_set_chained_handler_and_data(pp->msi_irq,
@@ -434,6 +437,11 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 err_free_msi:
 	if (pp->has_msi_ctrl)
 		dw_pcie_free_msi(pp);
+
+err_deinit_host:
+	if (pp->ops->host_deinit)
+		pp->ops->host_deinit(pp);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(dw_pcie_host_init);
@@ -449,6 +457,9 @@ void dw_pcie_host_deinit(struct dw_pcie_rp *pp)
 
 	if (pp->has_msi_ctrl)
 		dw_pcie_free_msi(pp);
+
+	if (pp->ops->host_deinit)
+		pp->ops->host_deinit(pp);
 }
 EXPORT_SYMBOL_GPL(dw_pcie_host_deinit);
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index d247f227464c..7f1c00fa084d 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -200,6 +200,7 @@ enum dw_pcie_device_mode {
 
 struct dw_pcie_host_ops {
 	int (*host_init)(struct dw_pcie_rp *pp);
+	void (*host_deinit)(struct dw_pcie_rp *pp);
 	int (*msi_host_init)(struct dw_pcie_rp *pp);
 };
 
-- 
2.35.1

