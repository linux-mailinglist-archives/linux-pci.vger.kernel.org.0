Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3681E1BF212
	for <lists+linux-pci@lfdr.de>; Thu, 30 Apr 2020 10:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgD3IGn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Apr 2020 04:06:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:50796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726428AbgD3IGm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Apr 2020 04:06:42 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD4742186A;
        Thu, 30 Apr 2020 08:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588234001;
        bh=HhAmAT2/A+qPYpQdZvTmptCNczQiph9isL1WeEaN0bM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sfn8ddWur8OqKt9lcbP1xwQF3fyJR3FHROypX+VYebaQIGcnud648tmINsPhZqe4B
         OYvNYwX2aprawfc7L2zOh4eN7vIakof39COZ8WRSgFGbp3JoBvrhd18J70P75jMp+Q
         p7DZpkIkqCz2Lc/HhkKD3fwtoVWEn6NlnxVQdyOI=
Received: by pali.im (Postfix)
        id D38FCA19; Thu, 30 Apr 2020 10:06:39 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Remi Pommarel <repk@triplefau.lt>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v4 01/12] PCI: aardvark: Train link immediately after enabling training
Date:   Thu, 30 Apr 2020 10:06:14 +0200
Message-Id: <20200430080625.26070-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430080625.26070-1-pali@kernel.org>
References: <20200430080625.26070-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Adding even 100ms (PCI_PM_D3COLD_WAIT) delay between enabling link
training and starting link training causes detection issues with some
buggy cards (such as Compex WLE900VX).

Move the code which enables link training immediately before the one
which starts link traning.

This fixes detection issues of Compex WLE900VX card on Turris MOX after
cold boot.

Fixes: f4c7d053d7f7 ("PCI: aardvark: Wait for endpoint to be ready...")
Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 2a20b649f40c..f9955b494267 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -300,11 +300,6 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 	reg |= LANE_COUNT_1;
 	advk_writel(pcie, reg, PCIE_CORE_CTRL0_REG);
 
-	/* Enable link training */
-	reg = advk_readl(pcie, PCIE_CORE_CTRL0_REG);
-	reg |= LINK_TRAINING_EN;
-	advk_writel(pcie, reg, PCIE_CORE_CTRL0_REG);
-
 	/* Enable MSI */
 	reg = advk_readl(pcie, PCIE_CORE_CTRL2_REG);
 	reg |= PCIE_CORE_CTRL2_MSI_ENABLE;
@@ -346,7 +341,15 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 	 */
 	msleep(PCI_PM_D3COLD_WAIT);
 
-	/* Start link training */
+	/* Enable link training */
+	reg = advk_readl(pcie, PCIE_CORE_CTRL0_REG);
+	reg |= LINK_TRAINING_EN;
+	advk_writel(pcie, reg, PCIE_CORE_CTRL0_REG);
+
+	/*
+	 * Start link training immediately after enabling it.
+	 * This solves problems for some buggy cards.
+	 */
 	reg = advk_readl(pcie, PCIE_CORE_LINK_CTRL_STAT_REG);
 	reg |= PCIE_CORE_LINK_TRAINING;
 	advk_writel(pcie, reg, PCIE_CORE_LINK_CTRL_STAT_REG);
-- 
2.20.1

