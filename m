Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C07A431113
	for <lists+linux-pci@lfdr.de>; Mon, 18 Oct 2021 09:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbhJRHJ6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Oct 2021 03:09:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:54128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230442AbhJRHJz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Oct 2021 03:09:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 17D7061279;
        Mon, 18 Oct 2021 07:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634540864;
        bh=RN3IniCpmW6GCc51JgcNyEo3Gx4h0PN2adG5iG1gw0w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DSiQ0h8pzQZ5TCY/ipCY8pMLXSEjBD+bgC74cgpCXd6b/mZdtdl6M/Qx+VUY5QjSM
         yzbZt/3C0gdBS7jPTozJDywiRgbuxtvma+ju6abpbcQVOZA5ZQR7HS7zTZbvvQ2rn3
         hETHifrvv1wouc5UEsiVzgulI/mBOD8xBOS5HPrnQHoIYiZoO91B3SC2Ziv3pfHOMB
         GVCWKgz/NzCgdd6WNBv9v3acAJzI5DmoJLSyrZqLwwYn523tWNMx28D8jggTe2C7RG
         ylA7mvLia1lPKcgVyDedPo8EJIhZkAFC7WK8ae4YchNLjENdKea4rhwvgmS4MCdL0b
         tTHLAFhcuZAIQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mcMkC-000IdD-SG; Mon, 18 Oct 2021 08:07:36 +0100
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
Subject: [PATCH v13 08/10] PCI: kirin: Add power_off support for Kirin 960 PHY
Date:   Mon, 18 Oct 2021 08:07:33 +0100
Message-Id: <72c6049d2125d575396de9e590b253b93dc51fa4.1634539769.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634539769.git.mchehab+huawei@kernel.org>
References: <cover.1634539769.git.mchehab+huawei@kernel.org>
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

See [PATCH v13 00/10] at: https://lore.kernel.org/all/cover.1634539769.git.mchehab+huawei@kernel.org/

 drivers/pci/controller/dwc/pcie-kirin.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index d5c29a266756..b17a194cf78d 100644
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

