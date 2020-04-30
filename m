Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25E451BF234
	for <lists+linux-pci@lfdr.de>; Thu, 30 Apr 2020 10:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgD3IHV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Apr 2020 04:07:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:51072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726906AbgD3IGr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Apr 2020 04:06:47 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 828F621974;
        Thu, 30 Apr 2020 08:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588234006;
        bh=2uk4vuo8OceUNZZViPFMJEfPFWL6CEM3o4lkAfUrGCk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IGaxNTLeS9yhWqzKvVjc2ESi38PzzhIq9ttgBe8qykNz2k7IXQkDDtofRL7t4MCS+
         Yb27Ea/4lo1VxTzlvOJ+CUe6R/eVVALWyoOs0rArNa6S4w2aKrrf5sG5ZGhSy3Fqgk
         t4XoQn7wt4UR+deuF4t+R3w+5GMlssS8jokbZmHY=
Received: by pali.im (Postfix)
        id ACD857AD; Thu, 30 Apr 2020 10:06:44 +0200 (CEST)
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
Subject: [PATCH v4 05/12] PCI: aardvark: Issue PERST via GPIO
Date:   Thu, 30 Apr 2020 10:06:18 +0200
Message-Id: <20200430080625.26070-6-pali@kernel.org>
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

Add support for issuing PERST via GPIO specified in 'reset-gpios'
property (as described in PCI device tree bindings).

Some buggy cards (e.g. Compex WLE900VX or WLE1216) are not detected
after reboot when PERST is not issued during driver initialization.

If bootloader already enabled link training then issuing PERST has no
effect for some buggy cards (e.g. Compex WLE900VX) and these cards are
not detected. We therefore clear the LINK_TRAINING_EN register before.

It was observed that Compex WLE900VX card needs to be in PERST reset
for at least 10ms if bootloader enabled link training.

Tested on Turris MOX.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 43 ++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index e202f954eb84..2ecc79c03ade 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/delay.h>
+#include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
@@ -18,6 +19,7 @@
 #include <linux/platform_device.h>
 #include <linux/msi.h>
 #include <linux/of_address.h>
+#include <linux/of_gpio.h>
 #include <linux/of_pci.h>
 
 #include "../pci.h"
@@ -204,6 +206,7 @@ struct advk_pcie {
 	int root_bus_nr;
 	int link_gen;
 	struct pci_bridge_emul bridge;
+	struct gpio_desc *reset_gpio;
 };
 
 static inline void advk_writel(struct advk_pcie *pcie, u32 val, u64 reg)
@@ -330,10 +333,31 @@ static void advk_pcie_train_link(struct advk_pcie *pcie)
 	dev_err(dev, "link never came up\n");
 }
 
+static void advk_pcie_issue_perst(struct advk_pcie *pcie)
+{
+	u32 reg;
+
+	if (!pcie->reset_gpio)
+		return;
+
+	/* PERST does not work for some cards when link training is enabled */
+	reg = advk_readl(pcie, PCIE_CORE_CTRL0_REG);
+	reg &= ~LINK_TRAINING_EN;
+	advk_writel(pcie, reg, PCIE_CORE_CTRL0_REG);
+
+	/* 10ms delay is needed for some cards */
+	dev_info(&pcie->pdev->dev, "issuing PERST via reset GPIO for 10ms\n");
+	gpiod_set_value_cansleep(pcie->reset_gpio, 1);
+	usleep_range(10000, 11000);
+	gpiod_set_value_cansleep(pcie->reset_gpio, 0);
+}
+
 static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 {
 	u32 reg;
 
+	advk_pcie_issue_perst(pcie);
+
 	/* Set to Direct mode */
 	reg = advk_readl(pcie, CTRL_CONFIG_REG);
 	reg &= ~(CTRL_MODE_MASK << CTRL_MODE_SHIFT);
@@ -406,7 +430,8 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 
 	/*
 	 * PERST# signal could have been asserted by pinctrl subsystem before
-	 * probe() callback has been called, making the endpoint going into
+	 * probe() callback has been called or issued explicitly by reset gpio
+	 * function advk_pcie_issue_perst(), making the endpoint going into
 	 * fundamental reset. As required by PCI Express spec a delay for at
 	 * least 100ms after such a reset before link training is needed.
 	 */
@@ -1046,6 +1071,22 @@ static int advk_pcie_probe(struct platform_device *pdev)
 	}
 	pcie->root_bus_nr = bus->start;
 
+	pcie->reset_gpio = devm_gpiod_get_from_of_node(dev, dev->of_node,
+						       "reset-gpios", 0,
+						       GPIOD_OUT_LOW,
+						       "pcie1-reset");
+	ret = PTR_ERR_OR_ZERO(pcie->reset_gpio);
+	if (ret) {
+		if (ret == -ENOENT) {
+			pcie->reset_gpio = NULL;
+		} else {
+			if (ret != -EPROBE_DEFER)
+				dev_err(dev, "Failed to get reset-gpio: %i\n",
+					ret);
+			return ret;
+		}
+	}
+
 	ret = of_pci_get_max_link_speed(dev->of_node);
 	if (ret <= 0 || ret > 3)
 		pcie->link_gen = 3;
-- 
2.20.1

