Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7C321163BE
	for <lists+linux-pci@lfdr.de>; Sun,  8 Dec 2019 21:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfLHUzM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 8 Dec 2019 15:55:12 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:40445 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfLHUzM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 8 Dec 2019 15:55:12 -0500
X-Originating-IP: 88.190.179.123
Received: from localhost (unknown [88.190.179.123])
        (Authenticated sender: repk@triplefau.lt)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id E6B7AC0005;
        Sun,  8 Dec 2019 20:55:07 +0000 (UTC)
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
Subject: [PATCH 0/2] PCI: amlogic: Make PCIe working reliably on AXG platforms
Date:   Sun,  8 Dec 2019 22:03:18 +0100
Message-Id: <20191208210320.15539-1-repk@triplefau.lt>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCIe device probing failures have been seen on some AXG platforms and were
due to unreliable clock signal output. Setting HHI_MIPI_CNTL0[26] bit
solved the problem. After being contacted about this, vendor reported that
this bit was linked to PCIe PLL CML output.

This serie adds a way to set this bit through AXG clock gating logic.
Platforms having this kind of issue could make use of this gating by
applying a patch to their devicetree similar to:

                clocks = <&clkc CLKID_USB
                        &clkc CLKID_MIPI_ENABLE
                        &clkc CLKID_PCIE_A
-                       &clkc CLKID_PCIE_CML_EN0>;
+                       &clkc CLKID_PCIE_CML_EN0
+                       &clkc CLKID_PCIE_PLL_CML_ENABLE>;
                clock-names = "pcie_general",
                                "pcie_mipi_en",
                                "pcie",
-                               "port";
+                               "port",
+                               "pll_cml_en";
                resets = <&reset RESET_PCIE_PHY>,
                        <&reset RESET_PCIE_A>,
                        <&reset RESET_PCIE_APB>;


Remi Pommarel (2):
  clk: meson: axg: add pcie pll cml gating
  PCI: amlogic: Use PCIe pll gate when available

 drivers/clk/meson/axg.c                | 3 +++
 drivers/clk/meson/axg.h                | 2 +-
 drivers/pci/controller/dwc/pci-meson.c | 5 +++++
 include/dt-bindings/clock/axg-clkc.h   | 1 +
 4 files changed, 10 insertions(+), 1 deletion(-)

-- 
2.24.0

