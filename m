Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE6C1163C4
	for <lists+linux-pci@lfdr.de>; Sun,  8 Dec 2019 21:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfLHUz0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 8 Dec 2019 15:55:26 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:55441 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfLHUz0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 8 Dec 2019 15:55:26 -0500
X-Originating-IP: 88.190.179.123
Received: from localhost (unknown [88.190.179.123])
        (Authenticated sender: repk@triplefau.lt)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id DE367C0003;
        Sun,  8 Dec 2019 20:55:22 +0000 (UTC)
From:   Remi Pommarel <repk@triplefau.lt>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Yue Wang <yue.wang@Amlogic.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH 2/2] PCI: amlogic: Use PCIe pll gate when available
Date:   Sun,  8 Dec 2019 22:03:20 +0100
Message-Id: <20191208210320.15539-3-repk@triplefau.lt>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191208210320.15539-1-repk@triplefau.lt>
References: <20191208210320.15539-1-repk@triplefau.lt>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In order to get PCIe working reliably on some AXG platforms, PCIe pll
cml needs to be enabled. This is done by using the PCIE_PLL_CML_ENABLE
clock gate.

This clock gate is optional, so do not fail if it is missing in the
devicetree.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 drivers/pci/controller/dwc/pci-meson.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
index 3772b02a5c55..32b70ea9a426 100644
--- a/drivers/pci/controller/dwc/pci-meson.c
+++ b/drivers/pci/controller/dwc/pci-meson.c
@@ -89,6 +89,7 @@ struct meson_pcie_clk_res {
 	struct clk *mipi_gate;
 	struct clk *port_clk;
 	struct clk *general_clk;
+	struct clk *pll_cml_gate;
 };
 
 struct meson_pcie_rc_reset {
@@ -300,6 +301,10 @@ static int meson_pcie_probe_clocks(struct meson_pcie *mp)
 	if (IS_ERR(res->clk))
 		return PTR_ERR(res->clk);
 
+	res->pll_cml_gate = meson_pcie_probe_clock(dev, "pll_cml_en", 0);
+	if (IS_ERR(res->pll_cml_gate))
+		res->pll_cml_gate = NULL;
+
 	return 0;
 }
 
-- 
2.24.0

