Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 378A53F197A
	for <lists+linux-pci@lfdr.de>; Thu, 19 Aug 2021 14:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239665AbhHSMfe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Aug 2021 08:35:34 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35846 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239449AbhHSMfb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Aug 2021 08:35:31 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 17JCYUmW032745;
        Thu, 19 Aug 2021 07:34:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1629376470;
        bh=EzToIQKfYZKUFJNPi+YNykgFAg/XjfIKJRu2x72y+mU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=sGQeNRaBoet17oC0kyeeAB8kQlXhRaxQcfvBEIOPBJHL5GT4o9p96uexXqEVT1eye
         +Xk5ZkuEaTejr89ERayudfbdmK3xOEQYw9QO7mp27NFlG94sCbihzW7ra2WQGkv9OU
         H9x1keq2nMSGrraiOlEu6NF0rBDrQ65pVY8hls50=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 17JCYUi3107508
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Aug 2021 07:34:30 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 19
 Aug 2021 07:34:29 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 19 Aug 2021 07:34:29 -0500
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 17JCXlZT035715;
        Thu, 19 Aug 2021 07:34:23 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tom Joseph <tjoseph@cadence.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>, <linux-pci@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v9 5/8] PCI: cadence: Simplify code to get register base address for configuring BAR
Date:   Thu, 19 Aug 2021 18:03:40 +0530
Message-ID: <20210819123343.1951-6-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210819123343.1951-1-kishon@ti.com>
References: <20210819123343.1951-1-kishon@ti.com>
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
 drivers/pci/controller/cadence/pcie-cadence.h  |  3 +++
 2 files changed, 7 insertions(+), 14 deletions(-)

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
index 30db2d68c17a..347ed7bd2038 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -8,6 +8,7 @@
 
 #include <linux/kernel.h>
 #include <linux/pci.h>
+#include <linux/pci-epf.h>
 #include <linux/phy/phy.h>
 
 /* Parameters for the waiting for link up routine */
@@ -46,6 +47,8 @@
 #define  CDNS_PCIE_LM_EP_ID_BUS_SHIFT	8
 
 /* Endpoint Function f BAR b Configuration Registers */
+#define CDNS_PCIE_LM_EP_FUNC_BAR_CFG(bar, fn) \
+	(((bar) < BAR_4) ? CDNS_PCIE_LM_EP_FUNC_BAR_CFG0(fn) : CDNS_PCIE_LM_EP_FUNC_BAR_CFG1(fn))
 #define CDNS_PCIE_LM_EP_FUNC_BAR_CFG0(fn) \
 	(CDNS_PCIE_LM_BASE + 0x0240 + (fn) * 0x0008)
 #define CDNS_PCIE_LM_EP_FUNC_BAR_CFG1(fn) \
-- 
2.17.1

