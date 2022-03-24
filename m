Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A604E9AE2
	for <lists+linux-pci@lfdr.de>; Mon, 28 Mar 2022 17:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236149AbiC1PZw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Mar 2022 11:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235716AbiC1PZu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Mar 2022 11:25:50 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B1E7C1FA55;
        Mon, 28 Mar 2022 08:24:08 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 433211E4924;
        Thu, 24 Mar 2022 04:37:53 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru 433211E4924
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1648085873;
        bh=6CL1zvQSdfUwCZE8IBob0c16fWf+m5n9Xre0iS0ETF8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=K1ZE5vhR4GVRfQvKFc46ycU4LyYIZMAs8ce9lEeRepE1CVEd8cFT4uxWffZFsinPs
         ZJduq9wsBt7MvzevmiXd1gjEgkHS06KpgDDnRHl+kQJ9sOddgate6YpUZ8uKtxYKFL
         YolYIzI/ZxFKZdU+wB7vSMi/GQe0n2ODKBnHypMU=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 24 Mar 2022 04:37:53 +0300
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
        Rob Herring <robh+dt@kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 06/16] PCI: dwc: Introduce Synopsys IP-core versions/types interface
Date:   Thu, 24 Mar 2022 04:37:24 +0300
Message-ID: <20220324013734.18234-7-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220324013734.18234-1-Sergey.Semin@baikalelectronics.ru>
References: <20220324013734.18234-1-Sergey.Semin@baikalelectronics.ru>
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

Instead of manual DW PCIe data version field comparison let's use a handy
macro-based interface in order to shorten out the statements, simplify the
corresponding parts, improve the code readability and maintainability in
perspective when more complex version-based dependencies need to
implemented. Similar approaches have already been implemented in the DWC
USB3 and DW SPI drivers (though with some IP-core evolution specifics).

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/pci/controller/dwc/pci-keystone.c    |  2 +-
 drivers/pci/controller/dwc/pcie-designware.c |  8 ++++----
 drivers/pci/controller/dwc/pcie-designware.h | 15 +++++++++++++++
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index ec65355dd29b..8fbebeb923b8 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -1233,7 +1233,7 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 		goto err_get_sync;
 	}
 
-	if (pci->version >= DW_PCIE_VER_480A)
+	if (dw_pcie_ver_is_ge(pci, 480A))
 		ret = ks_pcie_am654_set_mode(dev, mode);
 	else
 		ret = ks_pcie_set_mode(dev);
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 49c494d82042..d5ce19625769 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -313,7 +313,7 @@ static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, u8 func_no,
 	val = type | PCIE_ATU_FUNC_NUM(func_no);
 	if (upper_32_bits(limit_addr) > upper_32_bits(cpu_addr))
 		val |= PCIE_ATU_INCREASE_REGION_SIZE;
-	if (pci->version == DW_PCIE_VER_490A)
+	if (dw_pcie_ver_is(pci, 490A))
 		val = dw_pcie_enable_ecrc(val);
 	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1, val);
 	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL2,
@@ -360,7 +360,7 @@ static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
 			   upper_32_bits(cpu_addr));
 	dw_pcie_writel_dbi(pci, PCIE_ATU_LIMIT,
 			   lower_32_bits(limit_addr));
-	if (pci->version >= DW_PCIE_VER_460A)
+	if (dw_pcie_ver_is_ge(pci, 460A))
 		dw_pcie_writel_dbi(pci, PCIE_ATU_UPPER_LIMIT,
 				   upper_32_bits(limit_addr));
 	dw_pcie_writel_dbi(pci, PCIE_ATU_LOWER_TARGET,
@@ -369,9 +369,9 @@ static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
 			   upper_32_bits(pci_addr));
 	val = type | PCIE_ATU_FUNC_NUM(func_no);
 	if (upper_32_bits(limit_addr) > upper_32_bits(cpu_addr) &&
-	    pci->version >= DW_PCIE_VER_460A)
+	    dw_pcie_ver_is_ge(pci, 460A))
 		val |= PCIE_ATU_INCREASE_REGION_SIZE;
-	if (pci->version == DW_PCIE_VER_490A)
+	if (dw_pcie_ver_is(pci, 490A))
 		val = dw_pcie_enable_ecrc(val);
 	dw_pcie_writel_dbi(pci, PCIE_ATU_CR1, val);
 	dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, PCIE_ATU_ENABLE);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index f70cbdedf5a3..1868773ecb91 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -28,6 +28,21 @@
 #define DW_PCIE_VER_490A		0x3439302a
 #define DW_PCIE_VER_520A		0x3532302a
 
+#define __dw_pcie_ver_cmp(_pci, _ver, _op) \
+	((_pci)->version _op DW_PCIE_VER_ ## _ver)
+
+#define dw_pcie_ver_is(_pci, _ver) __dw_pcie_ver_cmp(_pci, _ver, ==)
+
+#define dw_pcie_ver_is_ge(_pci, _ver) __dw_pcie_ver_cmp(_pci, _ver, >=)
+
+#define dw_pcie_ver_type_is(_pci, _ver, _type) \
+	(__dw_pcie_ver_cmp(_pci, _ver, ==) && \
+	 __dw_pcie_ver_cmp(_pci, TYPE_ ## _type, ==))
+
+#define dw_pcie_ver_type_is_ge(_pci, _ver, _type) \
+	(__dw_pcie_ver_cmp(_pci, _ver, ==) && \
+	 __dw_pcie_ver_cmp(_pci, TYPE_ ## _type, >=))
+
 /* Parameters for the waiting for link up routine */
 #define LINK_WAIT_MAX_RETRIES		10
 #define LINK_WAIT_USLEEP_MIN		90000
-- 
2.35.1

