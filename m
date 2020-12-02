Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 257872CC5CE
	for <lists+linux-pci@lfdr.de>; Wed,  2 Dec 2020 19:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389497AbgLBSsJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Dec 2020 13:48:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:43862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389461AbgLBSsJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Dec 2020 13:48:09 -0500
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Rob Herring <robh@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] PCI: aardvark: Update comment about disabling link training
Date:   Wed,  2 Dec 2020 19:46:59 +0100
Message-Id: <20201202184659.3795-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200924084618.12442-1-pali@kernel.org>
References: <20200924084618.12442-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

It is not HW bug or workaround for some cards but it is requirement by PCI
Express spec. After fundamental reset is needed 100ms delay prior enabling
link training. So update comment in code to reflect this requirement.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
Changes in v2:
* Add reference to the PCI Express spec
---
 drivers/pci/controller/pci-aardvark.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 0be485a25327..f742da2a20ee 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -259,7 +259,14 @@ static void advk_pcie_issue_perst(struct advk_pcie *pcie)
 	if (!pcie->reset_gpio)
 		return;
 
-	/* PERST does not work for some cards when link training is enabled */
+	/*
+	 * As required by PCI Express spec (PCI Express Base Specification, REV.
+	 * 4.0 PCI Express, February 19 2014, 6.6.1 Conventional Reset) a delay
+	 * for at least 100ms after de-asserting PERST# signal is needed before
+	 * link training is enabled. So ensure that link training is disabled
+	 * prior de-asserting PERST# signal to fulfill that PCI Express spec
+	 * requirement.
+	 */
 	reg = advk_readl(pcie, PCIE_CORE_CTRL0_REG);
 	reg &= ~LINK_TRAINING_EN;
 	advk_writel(pcie, reg, PCIE_CORE_CTRL0_REG);
-- 
2.20.1

