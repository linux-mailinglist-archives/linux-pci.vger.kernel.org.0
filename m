Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7CA33E0522
	for <lists+linux-pci@lfdr.de>; Wed,  4 Aug 2021 18:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbhHDQD0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Aug 2021 12:03:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:58912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229783AbhHDQDX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 4 Aug 2021 12:03:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 73B1061008;
        Wed,  4 Aug 2021 16:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628092990;
        bh=Hy8eNUUARmfSXo114esRtBNHADBjh2HhC5zgYtA2zEg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QOQwJFp1+EfjDECMx5h7cUJVQ3oYNeoNXzaBL6OKj6agiAZcqPaovI0yLDzoA+Je4
         2niXudUvjUbtZf3p+uwEVkg5Jy+F0roYeOwBeyuk9gZp3cHWQCGZNOkFummGAFhbnB
         DrsP5Ng8dFLR0jbsZOLuvxl96mH9c3SGE049nK9DYRL1NV7AO44hlOmKN2NPQ++H5C
         M2X15wAVyn2eQKtj93VZTIx9lcKUBURaAQHpxSGCgy+wfQ2909GazY0qYCGAR2bHpy
         v3cyEz0lhtINqRJXF0WiXxs5N5EH+QhMxgyc/ubeKiqbyyRrINLUDoTMIdL/sK2cRl
         G0xWUchWYqyDQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mBJMK-000Pzr-OE; Wed, 04 Aug 2021 18:03:08 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        "Rob Herring" <robh@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v9 09/11] PCI: kirin: Add power_off support for Kirin 960 PHY
Date:   Wed,  4 Aug 2021 18:03:05 +0200
Message-Id: <3ee32cd118bec7603937c3b9b55f51c424d54ba6.1628092716.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1628092716.git.mchehab+huawei@kernel.org>
References: <cover.1628092716.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In order to prepare for module unload, add a power_off method
for HiKey 960.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/pci/controller/dwc/pcie-kirin.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index dbd45896920f..b7cc0c6701e4 100644
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
@@ -562,7 +574,6 @@ static int kirin_pcie_add_bus(struct pci_bus *bus)
 	return 0;
 }
 
-
 static struct pci_ops kirin_pci_ops = {
 	.read = kirin_pcie_rd_own_conf,
 	.write = kirin_pcie_wr_own_conf,
@@ -716,8 +727,12 @@ static int kirin_pcie_power_on(struct platform_device *pdev,
 
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
@@ -727,7 +742,7 @@ static int __exit kirin_pcie_remove(struct platform_device *pdev)
 	struct kirin_pcie *kirin_pcie = platform_get_drvdata(pdev);
 
 	if (kirin_pcie->type == PCIE_KIRIN_INTERNAL_PHY)
-		return 0;
+		return hi3660_pcie_phy_power_off(kirin_pcie);
 
 	phy_power_off(kirin_pcie->phy);
 	phy_exit(kirin_pcie->phy);
-- 
2.31.1

