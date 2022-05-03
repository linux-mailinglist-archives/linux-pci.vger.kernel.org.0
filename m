Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F457519037
	for <lists+linux-pci@lfdr.de>; Tue,  3 May 2022 23:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242817AbiECV1G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 May 2022 17:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242799AbiECV1F (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 May 2022 17:27:05 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6279541620;
        Tue,  3 May 2022 14:23:31 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 2AE8216DA;
        Wed,  4 May 2022 00:24:04 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru 2AE8216DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1651613044;
        bh=D8s4kkAaMIVtZOOq7LxKW6V3CsdUxny+ktG1+sp0I80=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=a5fr0Paw9piakX2d30BiZCXR/w2GqYURaiGLQhXKIMumZnDzOIz8YNWYiGFhIa/Cz
         tppZf5QfT54pCNTSqWqVWA7CzVm38xkEECgro5GWot9zCVP0VN3fvWLsqH9f5gSZeO
         pYaShBC4OVuKqAlZ0tdIoXWcSSG3DTkU2cjdWBv0=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 4 May 2022 00:23:30 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>,
        Shradha Todi <shradha.t@samsung.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 05/13] PCI: dwc: Set INCREASE_REGION_SIZE flag based on limit address
Date:   Wed, 4 May 2022 00:22:52 +0300
Message-ID: <20220503212300.30105-6-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220503212300.30105-1-Sergey.Semin@baikalelectronics.ru>
References: <20220503212300.30105-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

It was wrong to use the region size parameter in order to determine
whether the INCREASE_REGION_SIZE flag needs to be set for the outbound
iATU entry because in general there are cases when combining a region base
address and size together produces the out of bounds upper range limit
while upper_32_bits(size) still returns zero. So having a region size
within the permitted values doesn't mean the region limit address will fit
to the corresponding CSR. Here is the way iATU calculates the in- and
outbound untranslated regions if the INCREASE_REGION_SIZE flag is cleared
[1]:

  Start address:                      End address:
63              31              0   63              31              0
+---------------+---------------+   +---------------+---------------+
|               |         |  0s |   |               |         |  Fs |
+---------------+---------------+   +---------------+---------------+
   upper base   |   lower base       !upper! base   | limit address
     address          address           address

So the region start address is determined by the iATU lower and upper base
address registers, while the region upper boundary is calculated based on
the 32-bits limit address register and the upper part of the base address.
In accordance with that logic for instance the range
0xf0000000 @ 0x20000000 does have the size smaller than 4GB, but the
actual limit address turns to be invalid forming the untranslated address
map as [0xf0000000; 0x1000FFFF], which isn't what the original range was.
In order to fix that we need to check whether the size after being added
to the lower part of the base address causes the 4GB range overflow. If it
does then we need to set the INCREASE_REGION_SIZE flag thus activating the
extended limit address by means of an additional iATU CSR (upper limit
address register) [2]:

  Start address:                      End address:
63              31              0   63      x       31              0
+---------------+---------------+   +---------------+---------------+
|               |         |  0s |   |       |       |         |  Fs |
+---------------+---------------+   +---------------+---------------+
   upper base   |  lower base         upper | upper | limit address
     address         address          base  | limit |
                                     address|address|

Otherwise there is enough room in the 32-bits wide limit address register,
and the flag can be left unset.

Note the case when the size-based flag setting approach is correct implies
requiring to have the size-aligned base addresses only. But that
constraint isn't relevant to the PCIe ranges accepted by the kernel.
There is also no point in implementing it either seeing the problem can be
easily fixed by checking the whole limit address instead of the region
size.

[1] DesignWare Cores PCI Express Controller Databook - DWC PCIe Root Port,
    v5.40a, March 2019, fig.3-36, p.175
[2] DesignWare Cores PCI Express Controller Databook - DWC PCIe Root Port,
    v5.40a, March 2019, fig.3-37, p.176

Fixes: 5b4cf0f65324 ("PCI: dwc: Add upper limit address for outbound iATU")
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

---

Changelog v2:
- Fix the end address in the example of the patch log. It should be
  0x1000FFFF and not 0x0000FFFF (@Manivannan).
---
 drivers/pci/controller/dwc/pcie-designware.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 7dc8c360a0d4..d737af058903 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -287,8 +287,8 @@ static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, u8 func_no,
 	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_UPPER_TARGET,
 				 upper_32_bits(pci_addr));
 	val = type | PCIE_ATU_FUNC_NUM(func_no);
-	val = upper_32_bits(size - 1) ?
-		val | PCIE_ATU_INCREASE_REGION_SIZE : val;
+	if (upper_32_bits(limit_addr) > upper_32_bits(cpu_addr))
+		val |= PCIE_ATU_INCREASE_REGION_SIZE;
 	if (pci->version == 0x490A)
 		val = dw_pcie_enable_ecrc(val);
 	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1, val);
@@ -315,6 +315,7 @@ static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
 					u64 pci_addr, u64 size)
 {
 	u32 retries, val;
+	u64 limit_addr;
 
 	if (pci->ops && pci->ops->cpu_addr_fixup)
 		cpu_addr = pci->ops->cpu_addr_fixup(pci, cpu_addr);
@@ -325,6 +326,8 @@ static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
 		return;
 	}
 
+	limit_addr = cpu_addr + size - 1;
+
 	dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT,
 			   PCIE_ATU_REGION_OUTBOUND | index);
 	dw_pcie_writel_dbi(pci, PCIE_ATU_LOWER_BASE,
@@ -332,17 +335,18 @@ static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
 	dw_pcie_writel_dbi(pci, PCIE_ATU_UPPER_BASE,
 			   upper_32_bits(cpu_addr));
 	dw_pcie_writel_dbi(pci, PCIE_ATU_LIMIT,
-			   lower_32_bits(cpu_addr + size - 1));
+			   lower_32_bits(limit_addr));
 	if (pci->version >= 0x460A)
 		dw_pcie_writel_dbi(pci, PCIE_ATU_UPPER_LIMIT,
-				   upper_32_bits(cpu_addr + size - 1));
+				   upper_32_bits(limit_addr));
 	dw_pcie_writel_dbi(pci, PCIE_ATU_LOWER_TARGET,
 			   lower_32_bits(pci_addr));
 	dw_pcie_writel_dbi(pci, PCIE_ATU_UPPER_TARGET,
 			   upper_32_bits(pci_addr));
 	val = type | PCIE_ATU_FUNC_NUM(func_no);
-	val = ((upper_32_bits(size - 1)) && (pci->version >= 0x460A)) ?
-		val | PCIE_ATU_INCREASE_REGION_SIZE : val;
+	if (upper_32_bits(limit_addr) > upper_32_bits(cpu_addr) &&
+	    pci->version >= 0x460A)
+		val |= PCIE_ATU_INCREASE_REGION_SIZE;
 	if (pci->version == 0x490A)
 		val = dw_pcie_enable_ecrc(val);
 	dw_pcie_writel_dbi(pci, PCIE_ATU_CR1, val);
-- 
2.35.1

