Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEFF647DCB2
	for <lists+linux-pci@lfdr.de>; Thu, 23 Dec 2021 02:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346013AbhLWBMg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Dec 2021 20:12:36 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:57946 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345786AbhLWBLq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Dec 2021 20:11:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4859BCE1EFD;
        Thu, 23 Dec 2021 01:11:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53991C36AEB;
        Thu, 23 Dec 2021 01:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640221902;
        bh=LFg3f+vxhc16OiGKNO9DQqvVW+Fx4PcKl6aq6BZtG3Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qHjAgDrE+WWnLnH/YfCSYiGYmFP3MNAlBQLYffSYSwj/hC0+g4Nac7mY7Ivkg1bvu
         i1hQ/QFtSXiJ48k7TmMab4HNFvF+oJVd0Ttq1d9hHc6sj8H6i0Ui1sNgAJNSz27xxO
         1DVyZNiLxkrltMG1hq1AKGjYtFUnghQAy0Mq9OSvx+sjkxz2AnHeWkrMfxYOK3yn9L
         PbEDJQoxiu//L0qhhx8Vpu3wv1mG2tIOeVk1NRUz/qMOdtwiPvka92S5Xo0Jdj/NDz
         BbYbaZp7gQxazMfRVqveTm50lS3eupXkIkXCUIKMCS6FjEo7HrxksPhjs1JKcvaj16
         Xa4Maj8K2MEWA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org, Fan Fei <ffclaire1224@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 18/23] PCI: rcar-gen2: Rename rcar_pci_priv to rcar_pci
Date:   Wed, 22 Dec 2021 19:10:49 -0600
Message-Id: <20211223011054.1227810-19-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211223011054.1227810-1-helgaas@kernel.org>
References: <20211223011054.1227810-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Rename struct rcar_pci_priv to rcar_pci to match the convention of
<driver>_pci. No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: linux-renesas-soc@vger.kernel.org
---
 drivers/pci/controller/pci-rcar-gen2.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/pci-rcar-gen2.c b/drivers/pci/controller/pci-rcar-gen2.c
index afde4aa8f6dc..35804ea394fd 100644
--- a/drivers/pci/controller/pci-rcar-gen2.c
+++ b/drivers/pci/controller/pci-rcar-gen2.c
@@ -93,7 +93,7 @@
 
 #define RCAR_PCI_UNIT_REV_REG		(RCAR_AHBPCI_PCICOM_OFFSET + 0x48)
 
-struct rcar_pci_priv {
+struct rcar_pci {
 	struct device *dev;
 	void __iomem *reg;
 	struct resource mem_res;
@@ -105,7 +105,7 @@ struct rcar_pci_priv {
 static void __iomem *rcar_pci_cfg_base(struct pci_bus *bus, unsigned int devfn,
 				       int where)
 {
-	struct rcar_pci_priv *priv = bus->sysdata;
+	struct rcar_pci *priv = bus->sysdata;
 	int slot, val;
 
 	if (!pci_is_root_bus(bus) || PCI_FUNC(devfn))
@@ -132,7 +132,7 @@ static void __iomem *rcar_pci_cfg_base(struct pci_bus *bus, unsigned int devfn,
 
 static irqreturn_t rcar_pci_err_irq(int irq, void *pw)
 {
-	struct rcar_pci_priv *priv = pw;
+	struct rcar_pci *priv = pw;
 	struct device *dev = priv->dev;
 	u32 status = ioread32(priv->reg + RCAR_PCI_INT_STATUS_REG);
 
@@ -148,7 +148,7 @@ static irqreturn_t rcar_pci_err_irq(int irq, void *pw)
 	return IRQ_NONE;
 }
 
-static void rcar_pci_setup_errirq(struct rcar_pci_priv *priv)
+static void rcar_pci_setup_errirq(struct rcar_pci *priv)
 {
 	struct device *dev = priv->dev;
 	int ret;
@@ -166,11 +166,11 @@ static void rcar_pci_setup_errirq(struct rcar_pci_priv *priv)
 	iowrite32(val, priv->reg + RCAR_PCI_INT_ENABLE_REG);
 }
 #else
-static inline void rcar_pci_setup_errirq(struct rcar_pci_priv *priv) { }
+static inline void rcar_pci_setup_errirq(struct rcar_pci *priv) { }
 #endif
 
 /* PCI host controller setup */
-static void rcar_pci_setup(struct rcar_pci_priv *priv)
+static void rcar_pci_setup(struct rcar_pci *priv)
 {
 	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(priv);
 	struct device *dev = priv->dev;
@@ -279,7 +279,7 @@ static int rcar_pci_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct resource *cfg_res, *mem_res;
-	struct rcar_pci_priv *priv;
+	struct rcar_pci *priv;
 	struct pci_host_bridge *bridge;
 	void __iomem *reg;
 
-- 
2.25.1

