Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F819313541
	for <lists+linux-pci@lfdr.de>; Mon,  8 Feb 2021 15:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhBHOdF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Feb 2021 09:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbhBHOcA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Feb 2021 09:32:00 -0500
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C08EC06178A
        for <linux-pci@vger.kernel.org>; Mon,  8 Feb 2021 06:23:09 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by andre.telenet-ops.be with bizsmtp
        id SeP62400b4C55Sk01eP6KW; Mon, 08 Feb 2021 15:23:07 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1l97RS-004dqT-B5; Mon, 08 Feb 2021 15:23:06 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1l97RR-001jbR-Pc; Mon, 08 Feb 2021 15:23:05 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Minghuan Lian <Minghuan.Lian@nxp.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] PCI: mobiveil: Improve PCIE_LAYERSCAPE_GEN4 dependencies
Date:   Mon,  8 Feb 2021 15:23:01 +0100
Message-Id: <20210208142301.413582-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

  - Drop the dependency on PCI, as this is implied by the dependency on
    PCI_MSI_IRQ_DOMAIN,
  - Drop the dependencies on OF and ARM64, as the driver compiles fine
    without OF and/or on other architectures,
  - The Freescale Layerscape PCIe Gen4 controller is present only on
    Freescale Layerscape SoCs.  Hence depend on ARCH_LAYERSCAPE, to
    prevent asking the user about this driver when configuring a kernel
    without Freescale Layerscape support, unless compile-testing.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pci/controller/mobiveil/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/controller/mobiveil/Kconfig b/drivers/pci/controller/mobiveil/Kconfig
index a62d247018cf6b51..e4643fb94e78f3da 100644
--- a/drivers/pci/controller/mobiveil/Kconfig
+++ b/drivers/pci/controller/mobiveil/Kconfig
@@ -24,8 +24,7 @@ config PCIE_MOBIVEIL_PLAT
 
 config PCIE_LAYERSCAPE_GEN4
 	bool "Freescale Layerscape PCIe Gen4 controller"
-	depends on PCI
-	depends on OF && (ARM64 || ARCH_LAYERSCAPE)
+	depends on ARCH_LAYERSCAPE || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_MOBIVEIL_HOST
 	help
-- 
2.25.1

