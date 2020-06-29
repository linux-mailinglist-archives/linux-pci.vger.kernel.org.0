Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A18D20D2F7
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jun 2020 21:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbgF2SyU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Jun 2020 14:54:20 -0400
Received: from inva020.nxp.com ([92.121.34.13]:41018 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729696AbgF2SyD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Jun 2020 14:54:03 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 56D2D1A12E8;
        Mon, 29 Jun 2020 17:17:30 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2F8831A12EE;
        Mon, 29 Jun 2020 17:17:19 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 4005B402F7;
        Mon, 29 Jun 2020 23:17:06 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     catalin.marinas@arm.com, will@kernel.org,
        lorenzo.pieralisi@arm.com, robh@kernel.org, bhelgaas@google.com,
        p.zabel@pengutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        bjorn.andersson@linaro.org, leoyang.li@nxp.com, vkoul@kernel.org,
        geert+renesas@glider.be, olof@lixom.net, treding@nvidia.com,
        gustavo.pimentel@synopsys.com, amurray@thegoodpenguin.co.uk,
        vidyas@nvidia.com, xiaowei.bao@nxp.com, jonnyc@amazon.com,
        hayashi.kunihiko@socionext.com, eswara.kota@linux.intel.com,
        krzk@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2 3/3] pci: imx: Select RESET_IMX7 by default
Date:   Mon, 29 Jun 2020 23:05:29 +0800
Message-Id: <1593443129-18766-3-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593443129-18766-1-git-send-email-Anson.Huang@nxp.com>
References: <1593443129-18766-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

i.MX7 reset driver now supports module build and it is no longer
built in by default, so i.MX PCI driver needs to select it explicitly
due to it is NOT supporting loadable module currently.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
New patch.
---
 drivers/pci/controller/dwc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 044a376..bcf63ce 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -90,6 +90,7 @@ config PCI_EXYNOS
 
 config PCI_IMX6
 	bool "Freescale i.MX6/7/8 PCIe controller"
+	select RESET_IMX7
 	depends on ARCH_MXC || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
-- 
2.7.4

