Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0BC2A80E
	for <lists+linux-pci@lfdr.de>; Sun, 26 May 2019 06:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfEZEiV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 26 May 2019 00:38:21 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:5339 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbfEZEiV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 26 May 2019 00:38:21 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cea18350000>; Sat, 25 May 2019 21:38:13 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sat, 25 May 2019 21:38:19 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sat, 25 May 2019 21:38:19 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 26 May
 2019 04:38:19 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sun, 26 May 2019 04:38:19 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cea18360001>; Sat, 25 May 2019 21:38:19 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <kishon@ti.com>, <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>
CC:     <mperttunen@nvidia.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V8 03/15] PCI: dwc: Perform dbi regs write lock towards the end
Date:   Sun, 26 May 2019 10:07:39 +0530
Message-ID: <20190526043751.12729-4-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190526043751.12729-1-vidyas@nvidia.com>
References: <20190526043751.12729-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1558845493; bh=pFE6fVodh+kPVyO9bcNtoO6L1XAsQHgu0GZBTljTYtU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=DR9UiLzqVIEP32K1zk4KLeJGVzfh95qED1saMhFELvt3Eq8X5FKOXetlbAgyP6M0S
         qqyoXe/Wdq5KfvSbKKCsRL/YoMWoNMVM6tZb0hJIILLcVtWlNWmb3v8m1TQYvX++uV
         AZrT/8UUGrNUSn6O8zs6AFgQdddUeQ2oCWIKBqVaNrhfRXeC9hoBZfFVuRQEvBWfzc
         2kNEQaJN4L1Koli7TvYitJKGRsWaBen5KuZ0mt6iEa8tJMusoKr8cDDITdGAU6mR8E
         Lm+eAu6M8/Fn1VrbAnP16l16VFU1HiOPPjtqsVuP0V2BhCy9jOUwuaK/WnLBV0KBEi
         fD+oH8209BR8w==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove multiple write enable and disable sequences of dbi registers as
Tegra194 implements writes to BAR-0 register (offset: 0x10) controlled by
DBI write-lock enable bit thereby not allowing any further writes to BAR-0
register in config space to take place. Hence enabling write permission at
the start of function and disabling the same only towards the end.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Reviewed-by: Thierry Reding <treding@nvidia.com>
---
Changes since [v7]:
* None

Changes since [v6]:
* None

Changes since [v5]:
* Moved write enable to the beginning of the API and write disable to the end

Changes since [v4]:
* None

Changes since [v3]:
* None

Changes since [v2]:
* None

Changes since [v1]:
* None

 drivers/pci/controller/dwc/pcie-designware-host.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index f93252d0da5b..d3156446ff27 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -628,6 +628,12 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 	u32 val, ctrl, num_ctrls;
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 
+	/*
+	 * Enable DBI read-only registers for writing/updating configuration.
+	 * Write permission gets disabled towards the end of this function.
+	 */
+	dw_pcie_dbi_ro_wr_en(pci);
+
 	dw_pcie_setup(pci);
 
 	if (!pp->ops->msi_host_init) {
@@ -650,12 +656,10 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_1, 0x00000000);
 
 	/* Setup interrupt pins */
-	dw_pcie_dbi_ro_wr_en(pci);
 	val = dw_pcie_readl_dbi(pci, PCI_INTERRUPT_LINE);
 	val &= 0xffff00ff;
 	val |= 0x00000100;
 	dw_pcie_writel_dbi(pci, PCI_INTERRUPT_LINE, val);
-	dw_pcie_dbi_ro_wr_dis(pci);
 
 	/* Setup bus numbers */
 	val = dw_pcie_readl_dbi(pci, PCI_PRIMARY_BUS);
@@ -687,15 +691,13 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 
 	dw_pcie_wr_own_conf(pp, PCI_BASE_ADDRESS_0, 4, 0);
 
-	/* Enable write permission for the DBI read-only register */
-	dw_pcie_dbi_ro_wr_en(pci);
 	/* Program correct class for RC */
 	dw_pcie_wr_own_conf(pp, PCI_CLASS_DEVICE, 2, PCI_CLASS_BRIDGE_PCI);
-	/* Better disable write permission right after the update */
-	dw_pcie_dbi_ro_wr_dis(pci);
 
 	dw_pcie_rd_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, &val);
 	val |= PORT_LOGIC_SPEED_CHANGE;
 	dw_pcie_wr_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, val);
+
+	dw_pcie_dbi_ro_wr_dis(pci);
 }
 EXPORT_SYMBOL_GPL(dw_pcie_setup_rc);
-- 
2.17.1

