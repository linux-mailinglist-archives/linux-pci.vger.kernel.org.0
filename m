Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24FF55B1B4
	for <lists+linux-pci@lfdr.de>; Sun, 30 Jun 2019 22:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfF3UzZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 30 Jun 2019 16:55:25 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:50544 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbfF3UzZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 30 Jun 2019 16:55:25 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 45cN7G4nCQz1rHDP;
        Sun, 30 Jun 2019 22:55:22 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 45cN7G3b9jz1qqkg;
        Sun, 30 Jun 2019 22:55:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 4rZCtBscNt44; Sun, 30 Jun 2019 22:55:21 +0200 (CEST)
X-Auth-Info: dce1KNS9OlqHhNEIBmDLeIQSdy3x7NPXzDR9v/ssqBc=
Received: from kurokawa.lan (ip-86-49-110-70.net.upcbroadband.cz [86.49.110.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sun, 30 Jun 2019 22:55:21 +0200 (CEST)
From:   Marek Vasut <marex@denx.de>
To:     linux-pci@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Sasha Levin <sashal@kernel.org>,
        Sven Van Asbroeck <TheSven73@googlemail.com>,
        Trent Piepho <tpiepho@impinj.com>
Subject: [PATCH] PCI: imx: Allow iMX PCIe driver on iMX6SX
Date:   Sun, 30 Jun 2019 22:53:07 +0200
Message-Id: <20190630205307.27360-1-marex@denx.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The driver supports iMX6SX, align the Kconfig file with the driver.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: Sasha Levin <sashal@kernel.org>
Cc: Sven Van Asbroeck <TheSven73@googlemail.com>
Cc: Trent Piepho <tpiepho@impinj.com>
---
 drivers/pci/controller/dwc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index a6ce1ee51b4c..3051387bf4f3 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -90,7 +90,7 @@ config PCI_EXYNOS
 
 config PCI_IMX6
 	bool "Freescale i.MX6/7/8 PCIe controller"
-	depends on SOC_IMX6Q || SOC_IMX7D || (ARM64 && ARCH_MXC) || COMPILE_TEST
+	depends on SOC_IMX6SX || SOC_IMX6Q || SOC_IMX7D || (ARM64 && ARCH_MXC) || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
 
-- 
2.20.1

