Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9FFF3E8A7C
	for <lists+linux-pci@lfdr.de>; Wed, 11 Aug 2021 08:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234961AbhHKGse (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Aug 2021 02:48:34 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42442 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235274AbhHKGs3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Aug 2021 02:48:29 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 17B6lfVM026521;
        Wed, 11 Aug 2021 01:47:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1628664462;
        bh=zHVOCuDL0/C7A0Qkb0i1OwP97SSve+zrew+t8+sPVl8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Bjq45xIvQsrxiRcxLTkE2HArwhcgQq85++aMmP86B7LEC5ghnhD0nXfqIMizdFpRX
         aqvIIYCyzL03uvV28Q5//MRTsON/G1yrc8LrgNyoZv+Ej+KszFqbZxgHdhaVrZg5ZP
         54Qi0KbZGl8ENxwBaNQNK3/fxF6VfPpf0uHzBCvg=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 17B6lf4F069553
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Aug 2021 01:47:41 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 11
 Aug 2021 01:47:41 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 11 Aug 2021 01:47:41 -0500
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 17B6kvu6013269;
        Wed, 11 Aug 2021 01:47:35 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Joseph <tjoseph@cadence.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
CC:     Jonathan Corbet <corbet@lwn.net>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Lokesh Vutla <lokeshvutla@ti.com>, <kishon@ti.com>
Subject: [PATCH v8 5/8] PCI: cadence: Simplify code to get register base address for configuring BAR
Date:   Wed, 11 Aug 2021 12:16:53 +0530
Message-ID: <20210811064656.15399-6-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210811064656.15399-1-kishon@ti.com>
References: <20210811064656.15399-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

No functional change. Simplify code to get register base address for
configuring PCI BAR.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../pci/controller/cadence/pcie-cadence-ep.c   | 18 ++++--------------
 drivers/pci/controller/cadence/pcie-cadence.h  |  2 ++
 2 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index 912a15be8bfd..f337f0842400 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -97,13 +97,8 @@ static int cdns_pcie_ep_set_bar(struct pci_epc *epc, u8 fn, u8 vfn,
 	cdns_pcie_writel(pcie, CDNS_PCIE_AT_IB_EP_FUNC_BAR_ADDR1(fn, bar),
 			 addr1);
 
-	if (bar < BAR_4) {
-		reg = CDNS_PCIE_LM_EP_FUNC_BAR_CFG0(fn);
-		b = bar;
-	} else {
-		reg = CDNS_PCIE_LM_EP_FUNC_BAR_CFG1(fn);
-		b = bar - BAR_4;
-	}
+	reg = CDNS_PCIE_LM_EP_FUNC_BAR_CFG(bar, fn);
+	b = (bar < BAR_4) ? bar : bar - BAR_4;
 
 	cfg = cdns_pcie_readl(pcie, reg);
 	cfg &= ~(CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_APERTURE_MASK(b) |
@@ -126,13 +121,8 @@ static void cdns_pcie_ep_clear_bar(struct pci_epc *epc, u8 fn, u8 vfn,
 	enum pci_barno bar = epf_bar->barno;
 	u32 reg, cfg, b, ctrl;
 
-	if (bar < BAR_4) {
-		reg = CDNS_PCIE_LM_EP_FUNC_BAR_CFG0(fn);
-		b = bar;
-	} else {
-		reg = CDNS_PCIE_LM_EP_FUNC_BAR_CFG1(fn);
-		b = bar - BAR_4;
-	}
+	reg = CDNS_PCIE_LM_EP_FUNC_BAR_CFG(bar, fn);
+	b = (bar < BAR_4) ? bar : bar - BAR_4;
 
 	ctrl = CDNS_PCIE_LM_BAR_CFG_CTRL_DISABLED;
 	cfg = cdns_pcie_readl(pcie, reg);
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index 30db2d68c17a..d5b1fcf2c39d 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -46,6 +46,8 @@
 #define  CDNS_PCIE_LM_EP_ID_BUS_SHIFT	8
 
 /* Endpoint Function f BAR b Configuration Registers */
+#define CDNS_PCIE_LM_EP_FUNC_BAR_CFG(bar, fn) \
+	(((bar) < 4) ? CDNS_PCIE_LM_EP_FUNC_BAR_CFG0(fn) : CDNS_PCIE_LM_EP_FUNC_BAR_CFG1(fn))
 #define CDNS_PCIE_LM_EP_FUNC_BAR_CFG0(fn) \
 	(CDNS_PCIE_LM_BASE + 0x0240 + (fn) * 0x0008)
 #define CDNS_PCIE_LM_EP_FUNC_BAR_CFG1(fn) \
-- 
2.17.1

