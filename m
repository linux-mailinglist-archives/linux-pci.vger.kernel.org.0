Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F61552A204
	for <lists+linux-pci@lfdr.de>; Tue, 17 May 2022 14:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346502AbiEQMwB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 May 2022 08:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346465AbiEQMvw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 May 2022 08:51:52 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B581E21834;
        Tue, 17 May 2022 05:51:45 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id CEBC0BD6;
        Tue, 17 May 2022 15:52:37 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru CEBC0BD6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1652791958;
        bh=EOVES41k44a8aiGRCiFSCyFxTqVIh9wxi/EixTfGm+s=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=SmPmlx6qGvUsWFLTvFBJfzFDejvEAoC2dRctHcun3JnmN8GZfZUZMK2/izUdj2hrk
         oFapl8BzqIDgJqsAQT6TIDMaEIMLm/ebchAE9yf0kj5UYWnTK19VNf84pQWNQf+Y0R
         P2HfyudqP/iaiDo/3EThO/9FdP8Ir7USEovvT1EY=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 17 May 2022 15:51:40 +0300
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
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 05/13] PCI: dwc: Set INCREASE_REGION_SIZE flag based on limit address
Date:   Tue, 17 May 2022 15:50:50 +0300
Message-ID: <20220517125058.18488-6-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220517125058.18488-1-Sergey.Semin@baikalelectronics.ru>
References: <20220517125058.18488-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_XBL,SPF_HELO_NONE,
        SPF_PASS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE autolearn=no
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
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

---

Changelog v2:
- Fix the end address in the example of the patch log. It should be
  0x1000FFFF and not 0x0000FFFF (@Manivannan).
---
 drivers/pci/controller/dwc/pcie-designware.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 84fef21efdbc..347251bf87d0 100644
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

