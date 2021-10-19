Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 270C7432DB6
	for <lists+linux-pci@lfdr.de>; Tue, 19 Oct 2021 08:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234013AbhJSGJH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Oct 2021 02:09:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:46030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229649AbhJSGJG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Oct 2021 02:09:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6D04E61264;
        Tue, 19 Oct 2021 06:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634623614;
        bh=4pgxXk8mR5U1EoFn6jsQnBhmENZEHjQC1LfKyFHdc+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H8+Og9AhprJAcV6U188sbUnIGGWi4qpktxfl36OAbZGyFnYaOgQIhqhf5WpWsi2LD
         iBWXOPZSHl3QZEZJdO71yg4+qJEdInOQEFXy6QGRlIQU7rQ8ZcVquv5UgW9LPM6zqJ
         B75Tksb8Q+55VfWKC3U8KrLiZkuZ315/DUyFHLx1epnDtqhfg+llZFJ0e2PDFluMIi
         X4vWcum4+wtU1TpUQsJZXScY4LYY56NKYy2MT5Q/bebAmoshbd4tAH79bUGn7tdCLe
         UFx5N2GxbFkKLfh1OSW7kzVf5cTMXouSlDC9+THRsb9RFaZU0SNL4UxpPNht3klCWi
         J55XaSMzmIPcQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mciGx-001krw-Ss; Tue, 19 Oct 2021 07:06:51 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        "Songxiaowei" <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v14 09/11] PCI: kirin: Add power_off support for Kirin 960 PHY
Date:   Tue, 19 Oct 2021 07:06:46 +0100
Message-Id: <45dfd17631254203db639341fe629b24d64913f3.1634622716.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634622716.git.mchehab+huawei@kernel.org>
References: <cover.1634622716.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In order to prepare for module unload, add a power_off method
for HiKey 960.

Acked-by: Xiaowei Song <songxiaowei@hisilicon.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

See [PATCH v14 00/11] at: https://lore.kernel.org/all/cover.1634622716.git.mchehab+huawei@kernel.org/

 drivers/pci/controller/dwc/pcie-kirin.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index b55830d2a19b..64221a204db2 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -343,6 +343,18 @@ static int hi3660_pcie_phy_init(struct platform_device *pdev,
 	return hi3660_pcie_phy_get_resource(phy);
 }
 
+static int hi3660_pcie_phy_power_off(struct kirin_pcie *pcie)
+{
+	struct hi3660_pcie_phy *phy = pcie->phy_priv;
+
+	/* Drop power supply for Host */
+	regmap_write(phy->sysctrl, SCTRL_PCIE_CMOS_OFFSET, 0x00);
+
+	hi3660_pcie_phy_clk_ctrl(phy, false);
+
+	return 0;
+}
+
 /*
  * The non-PHY part starts here
  */
@@ -560,7 +572,6 @@ static int kirin_pcie_add_bus(struct pci_bus *bus)
 	return 0;
 }
 
-
 static struct pci_ops kirin_pci_ops = {
 	.read = kirin_pcie_rd_own_conf,
 	.write = kirin_pcie_wr_own_conf,
@@ -714,8 +725,12 @@ static int kirin_pcie_power_on(struct platform_device *pdev,
 
 	return 0;
 err:
-	if (kirin_pcie->type != PCIE_KIRIN_INTERNAL_PHY)
+	if (kirin_pcie->type == PCIE_KIRIN_INTERNAL_PHY) {
+		hi3660_pcie_phy_power_off(kirin_pcie);
+	} else {
+		phy_power_off(kirin_pcie->phy);
 		phy_exit(kirin_pcie->phy);
+	}
 
 	return ret;
 }
@@ -725,7 +740,7 @@ static int __exit kirin_pcie_remove(struct platform_device *pdev)
 	struct kirin_pcie *kirin_pcie = platform_get_drvdata(pdev);
 
 	if (kirin_pcie->type == PCIE_KIRIN_INTERNAL_PHY)
-		return 0;
+		return hi3660_pcie_phy_power_off(kirin_pcie);
 
 	phy_power_off(kirin_pcie->phy);
 	phy_exit(kirin_pcie->phy);
-- 
2.31.1

