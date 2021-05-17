Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19F023837E1
	for <lists+linux-pci@lfdr.de>; Mon, 17 May 2021 17:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244644AbhEQPrS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 May 2021 11:47:18 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:58627 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344188AbhEQPmz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 May 2021 11:42:55 -0400
Received: from [77.244.183.192] (port=64722 helo=melee.fritz.box)
        by hostingweb31.netsons.net with esmtpa (Exim 4.94.2)
        (envelope-from <luca@lucaceresoli.net>)
        id 1lifNB-000Exi-NQ; Mon, 17 May 2021 17:41:37 +0200
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
Subject: [PATCH 3/5] PCI: dwc: pci-dra7xx: allow to build as a loadable module
Date:   Mon, 17 May 2021 17:41:20 +0200
Message-Id: <20210517154122.430544-4-luca@lucaceresoli.net>
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

Allow the pci-dra7xx PCIe controller to be build as a loadable module.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
---
 drivers/pci/controller/dwc/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 423d35872ce4..775ad590966e 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -17,10 +17,10 @@ config PCIE_DW_EP
 	select PCIE_DW
 
 config PCI_DRA7XX
-	bool
+	tristate
 
 config PCI_DRA7XX_HOST
-	bool "TI DRA7xx PCIe controller Host Mode"
+	tristate "TI DRA7xx PCIe controller Host Mode"
 	depends on SOC_DRA7XX || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
 	depends on OF && HAS_IOMEM && TI_PIPE3
@@ -36,7 +36,7 @@ config PCI_DRA7XX_HOST
 	  This uses the DesignWare core.
 
 config PCI_DRA7XX_EP
-	bool "TI DRA7xx PCIe controller Endpoint Mode"
+	tristate "TI DRA7xx PCIe controller Endpoint Mode"
 	depends on SOC_DRA7XX || COMPILE_TEST
 	depends on PCI_ENDPOINT
 	depends on OF && HAS_IOMEM && TI_PIPE3
-- 
2.25.1

