Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B57847F5BA
	for <lists+linux-pci@lfdr.de>; Sun, 26 Dec 2021 08:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbhLZH43 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 26 Dec 2021 02:56:29 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:51040 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbhLZH42 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 26 Dec 2021 02:56:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41C1960DD6;
        Sun, 26 Dec 2021 07:56:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 533B5C36AE8;
        Sun, 26 Dec 2021 07:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640505387;
        bh=VjHN6Nst3m1bg8c3YULfkrxwbT7JDI/fcou4Khbne0I=;
        h=From:To:Cc:Subject:Date:From;
        b=AJh3hGrrP78tjywYGJv1iOhmPprxKZ66XRNjwn0Fok8tv8kih6wewma2xJw0oIoe2
         lYJh+RVTV7Rf6YDlIVO71JGIwOur5gMKpy4HpjdJ1Hzmh7Dd0VeeoNwlf3fqNq453I
         xyPGM6kGUUccgQu7LDkpytRl6m8DQN7wCnQXwEoMrYL74Aukw1JC79PRpaPh7iVjub
         gz1DkR/sj58lCpTA9SovFqT0yf7VFGKpqQZbsWFOinV88pIzuRenAoj8G1zn4cy7HT
         IBjewL3D1tUj3ey0FZWNqLReQF/qIxFWYIOyF6Zh/k+EMY3vYSGjYaDhD5P4TtOAf8
         v7Pzk6dtMksBQ==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: tegra194: Remove unnecessary MSI enable reg save and restore
Date:   Sun, 26 Dec 2021 15:49:10 +0800
Message-Id: <20211226074910.2722-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The integrated MSI Receiver enable register is always initialized in
dw_pcie_setup_rc() which is also called in resume code path, so we
don't need to save/restore the enable register during suspend/resume.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 904976913081..678898985319 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -186,8 +186,6 @@
 #define N_FTS_VAL					52
 #define FTS_VAL						52
 
-#define PORT_LOGIC_MSI_CTRL_INT_0_EN		0x828
-
 #define GEN3_EQ_CONTROL_OFF			0x8a8
 #define GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC_SHIFT	8
 #define GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC_MASK	GENMASK(23, 8)
@@ -2189,9 +2187,6 @@ static int tegra_pcie_dw_suspend_noirq(struct device *dev)
 	if (!pcie->link_state)
 		return 0;
 
-	/* Save MSI interrupt vector */
-	pcie->msi_ctrl_int = dw_pcie_readl_dbi(&pcie->pci,
-					       PORT_LOGIC_MSI_CTRL_INT_0_EN);
 	tegra_pcie_downstream_dev_to_D0(pcie);
 	tegra_pcie_dw_pme_turnoff(pcie);
 	tegra_pcie_unconfig_controller(pcie);
@@ -2223,10 +2218,6 @@ static int tegra_pcie_dw_resume_noirq(struct device *dev)
 	if (ret < 0)
 		goto fail_host_init;
 
-	/* Restore MSI interrupt vector */
-	dw_pcie_writel_dbi(&pcie->pci, PORT_LOGIC_MSI_CTRL_INT_0_EN,
-			   pcie->msi_ctrl_int);
-
 	return 0;
 
 fail_host_init:
-- 
2.34.1

