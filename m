Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A8F7E4602
	for <lists+linux-pci@lfdr.de>; Tue,  7 Nov 2023 17:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234106AbjKGQbY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Nov 2023 11:31:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234098AbjKGQbJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Nov 2023 11:31:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397F3D7A;
        Tue,  7 Nov 2023 07:49:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A39C433CA;
        Tue,  7 Nov 2023 15:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699372190;
        bh=yvPQWk4KLG1FPmpiuBEIGEd+6R9+YJXnjQkoL2grjZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LJQq2r+RQh0eVW9kL4WBNo7V46r4fHisH/txCJ/Qz+0T6eKmrA3H/ZCVarZNMTVsU
         8/L8U8KqtcZq17Fwh1XqCvp6S9g2/J1jf8iNuArXr7JkUSAyuYVOQxcmV7Q1G35wJ3
         Oj1XT7H3v2wOlgOEzSmVcGuo+YrJOn35jtJWpZ+0oHoRE2MKxtXEE71fnuZzRzBvEA
         dvfW5zlvDwIP4/SaIg9Pzvbgz4zkkhPpns/JVX5NqPRQGAxar4Ea9dmpoj20h0dym4
         xtlNc9zKj71TTO/nVKOWaxCAr1vrXdQ0ZooNQEjwWBS50KCoSd9C30dPnHRCVSriDz
         sHXe4+q8e+OVg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Sasha Levin <sashal@kernel.org>, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, lpieralisi@kernel.org, kw@linux.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 27/34] PCI: dwc: Add missing PCI_EXP_LNKCAP_MLW handling
Date:   Tue,  7 Nov 2023 10:48:07 -0500
Message-ID: <20231107154846.3766119-27-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107154846.3766119-1-sashal@kernel.org>
References: <20231107154846.3766119-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.10
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

[ Upstream commit 89db0793c9f2da265ecb6c1681f899d9af157f37 ]

Update dw_pcie_link_set_max_link_width() to set PCI_EXP_LNKCAP_MLW.

In accordance with the DW PCIe RC/EP HW manuals [1,2,3,...] aside with
the PORT_LINK_CTRL_OFF.LINK_CAPABLE and GEN2_CTRL_OFF.NUM_OF_LANES[8:0]
field there is another one which needs to be updated.

It's LINK_CAPABILITIES_REG.PCIE_CAP_MAX_LINK_WIDTH. If it isn't done at
the very least the maximum link-width capability CSR won't expose the
actual maximum capability.

[1] DesignWare Cores PCI Express Controller Databook - DWC PCIe Root Port,
    Version 4.60a, March 2015, p.1032
[2] DesignWare Cores PCI Express Controller Databook - DWC PCIe Root Port,
    Version 4.70a, March 2016, p.1065
[3] DesignWare Cores PCI Express Controller Databook - DWC PCIe Root Port,
    Version 4.90a, March 2016, p.1057
...
[X] DesignWare Cores PCI Express Controller Databook - DWC PCIe Endpoint,
      Version 5.40a, March 2019, p.1396
[X+1] DesignWare Cores PCI Express Controller Databook - DWC PCIe Root Port,
      Version 5.40a, March 2019, p.1266

Suggested-by: Serge Semin <fancer.lancer@gmail.com>
Link: https://lore.kernel.org/linux-pci/20231018085631.1121289-4-yoshihiro.shimoda.uh@renesas.com
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index d14b4da700eaf..8e6f6ac42dc96 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -734,7 +734,8 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci, u32 link_gen)
 
 static void dw_pcie_link_set_max_link_width(struct dw_pcie *pci, u32 num_lanes)
 {
-	u32 lwsc, plc;
+	u32 lnkcap, lwsc, plc;
+	u8 cap;
 
 	if (!num_lanes)
 		return;
@@ -770,6 +771,12 @@ static void dw_pcie_link_set_max_link_width(struct dw_pcie *pci, u32 num_lanes)
 	}
 	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, plc);
 	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, lwsc);
+
+	cap = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	lnkcap = dw_pcie_readl_dbi(pci, cap + PCI_EXP_LNKCAP);
+	lnkcap &= ~PCI_EXP_LNKCAP_MLW;
+	lnkcap |= FIELD_PREP(PCI_EXP_LNKCAP_MLW, num_lanes);
+	dw_pcie_writel_dbi(pci, cap + PCI_EXP_LNKCAP, lnkcap);
 }
 
 void dw_pcie_iatu_detect(struct dw_pcie *pci)
-- 
2.42.0

