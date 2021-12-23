Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB0747DC9F
	for <lists+linux-pci@lfdr.de>; Thu, 23 Dec 2021 02:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345706AbhLWBLd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Dec 2021 20:11:33 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:57674 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345653AbhLWBL3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Dec 2021 20:11:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2D867CE1F05;
        Thu, 23 Dec 2021 01:11:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E3E5C36AE5;
        Thu, 23 Dec 2021 01:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640221886;
        bh=eL22WxVnfWizuXg7JF9XO7PuirwfJH3BG09wKmU3gYY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a6qmGpQ4Z1R+PC0Nzb8OWW8lQu0oF3N4cwXUFNu7vSaIhDnM9fn1gP8qjuhc+D2t/
         yQ9S/d/ARscwNN0t3flXrGyZkiPVwLgeD4WySM4ATxlynnMu/Vr1uP1UA8RPdCavhq
         JmehnTuzMWUdsVMOL9W7cgt2QN+O5SUX6DKB+gD9XRiMiPNRc+H5g4AR4gI0EZNd/A
         am3gghZL2ewa8t18U0MfNNyBjxEPI911dUFapSpb6aV3mrkECqVOsuxP5nw26pX2zI
         MmjMbKG41wu9nEz3C8IuBAwHGojkd9uC6h540FZ7l+pnEAiG2EYuWrgJhVf+VtSxbB
         VAg2rSU6WkJ+g==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org, Fan Fei <ffclaire1224@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tom Joseph <tjoseph@cadence.com>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 09/23] PCI: j721e: Drop redundant struct device *
Date:   Wed, 22 Dec 2021 19:10:40 -0600
Message-Id: <20211223011054.1227810-10-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211223011054.1227810-1-helgaas@kernel.org>
References: <20211223011054.1227810-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

The struct cdns_pcie already contains the struct device for the j721e PCIe
controller.  There's no need to store another copy in struct j721e_pcie.
Remove the redundant copy from struct j721e_pcie.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Tom Joseph <tjoseph@cadence.com>
Cc: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/pci/controller/cadence/pci-j721e.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index cd43d1898482..489586a4cdc7 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -51,11 +51,10 @@ enum link_status {
 #define MAX_LANES			2
 
 struct j721e_pcie {
-	struct device		*dev;
+	struct cdns_pcie	*cdns_pcie;
 	struct clk		*refclk;
 	u32			mode;
 	u32			num_lanes;
-	struct cdns_pcie	*cdns_pcie;
 	void __iomem		*user_cfg_base;
 	void __iomem		*intd_cfg_base;
 	u32			linkdown_irq_regfield;
@@ -99,7 +98,7 @@ static inline void j721e_pcie_intd_writel(struct j721e_pcie *pcie, u32 offset,
 static irqreturn_t j721e_pcie_link_irq_handler(int irq, void *priv)
 {
 	struct j721e_pcie *pcie = priv;
-	struct device *dev = pcie->dev;
+	struct device *dev = pcie->cdns_pcie->dev;
 	u32 reg;
 
 	reg = j721e_pcie_intd_readl(pcie, STATUS_REG_SYS_2);
@@ -165,7 +164,7 @@ static const struct cdns_pcie_ops j721e_pcie_ops = {
 static int j721e_pcie_set_mode(struct j721e_pcie *pcie, struct regmap *syscon,
 			       unsigned int offset)
 {
-	struct device *dev = pcie->dev;
+	struct device *dev = pcie->cdns_pcie->dev;
 	u32 mask = J721E_MODE_RC;
 	u32 mode = pcie->mode;
 	u32 val = 0;
@@ -184,7 +183,7 @@ static int j721e_pcie_set_mode(struct j721e_pcie *pcie, struct regmap *syscon,
 static int j721e_pcie_set_link_speed(struct j721e_pcie *pcie,
 				     struct regmap *syscon, unsigned int offset)
 {
-	struct device *dev = pcie->dev;
+	struct device *dev = pcie->cdns_pcie->dev;
 	struct device_node *np = dev->of_node;
 	int link_speed;
 	u32 val = 0;
@@ -205,7 +204,7 @@ static int j721e_pcie_set_link_speed(struct j721e_pcie *pcie,
 static int j721e_pcie_set_lane_count(struct j721e_pcie *pcie,
 				     struct regmap *syscon, unsigned int offset)
 {
-	struct device *dev = pcie->dev;
+	struct device *dev = pcie->cdns_pcie->dev;
 	u32 lanes = pcie->num_lanes;
 	u32 val = 0;
 	int ret;
@@ -220,7 +219,7 @@ static int j721e_pcie_set_lane_count(struct j721e_pcie *pcie,
 
 static int j721e_pcie_ctrl_init(struct j721e_pcie *pcie)
 {
-	struct device *dev = pcie->dev;
+	struct device *dev = pcie->cdns_pcie->dev;
 	struct device_node *node = dev->of_node;
 	struct of_phandle_args args;
 	unsigned int offset = 0;
@@ -377,7 +376,6 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 	if (!pcie)
 		return -ENOMEM;
 
-	pcie->dev = dev;
 	pcie->mode = mode;
 	pcie->linkdown_irq_regfield = data->linkdown_irq_regfield;
 
-- 
2.25.1

