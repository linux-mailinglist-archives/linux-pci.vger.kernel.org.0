Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 034383837DA
	for <lists+linux-pci@lfdr.de>; Mon, 17 May 2021 17:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244535AbhEQPrO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 May 2021 11:47:14 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:34160 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344185AbhEQPmy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 May 2021 11:42:54 -0400
Received: from [77.244.183.192] (port=64722 helo=melee.fritz.box)
        by hostingweb31.netsons.net with esmtpa (Exim 4.94.2)
        (envelope-from <luca@lucaceresoli.net>)
        id 1lifNA-000Exi-RL; Mon, 17 May 2021 17:41:36 +0200
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-pci@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH 1/5] PCI: dwc: export more symbols to allow modular drivers
Date:   Mon, 17 May 2021 17:41:18 +0200
Message-Id: <20210517154122.430544-2-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517154122.430544-1-luca@lucaceresoli.net>
References: <20210517154122.430544-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

These symbols are used by the pci-dra7xx driver. Export them to allow
building pci-dra7xx as a module.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 1 +
 drivers/pci/controller/dwc/pcie-designware.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 8d028a88b375..f2692a138216 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -83,6 +83,7 @@ void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar)
 	for (func_no = 0; func_no < funcs; func_no++)
 		__dw_pcie_ep_reset_bar(pci, func_no, bar, 0);
 }
+EXPORT_SYMBOL_GPL(dw_pcie_ep_reset_bar);
 
 static u8 __dw_pcie_ep_find_next_cap(struct dw_pcie_ep *ep, u8 func_no,
 		u8 cap_ptr, u8 cap)
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index a945f0c0e73d..850b4533f4ef 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -538,6 +538,7 @@ int dw_pcie_link_up(struct dw_pcie *pci)
 	return ((val & PCIE_PORT_DEBUG1_LINK_UP) &&
 		(!(val & PCIE_PORT_DEBUG1_LINK_IN_TRAINING)));
 }
+EXPORT_SYMBOL_GPL(dw_pcie_link_up);
 
 void dw_pcie_upconfig_setup(struct dw_pcie *pci)
 {
-- 
2.25.1

