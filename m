Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1448712A365
	for <lists+linux-pci@lfdr.de>; Tue, 24 Dec 2019 18:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfLXRcV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Dec 2019 12:32:21 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:54775 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfLXRcV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Dec 2019 12:32:21 -0500
X-Originating-IP: 88.190.179.123
Received: from localhost (unknown [88.190.179.123])
        (Authenticated sender: repk@triplefau.lt)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 41D6D20005;
        Tue, 24 Dec 2019 17:32:18 +0000 (UTC)
From:   Remi Pommarel <repk@triplefau.lt>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Yue Wang <yue.wang@Amlogic.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Remi Pommarel <repk@triplefau.lt>,
        devicetree@vger.kernel.org
Subject: [PATCH v3 3/5] arm64: dts: meson-axg: Add PCIE PHY node
Date:   Tue, 24 Dec 2019 18:39:40 +0100
Message-Id: <20191224173942.18160-4-repk@triplefau.lt>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191224173942.18160-1-repk@triplefau.lt>
References: <20191224173942.18160-1-repk@triplefau.lt>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Enable PCIE PHY node to make PCIE reliable on AXG SoC.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 04803c3bccfa..e679ef26ab79 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -1356,6 +1356,15 @@ tdmout_c: audio-controller@580 {
 			};
 		};
 
+		pcie_phy: pcie-phy@ff644000 {
+			compatible = "amlogic,axg-pcie-phy";
+			reg = <0x0 0xff644000 0x0 0x2000>;
+			aml,hhi-gpr = <&sysctrl>;
+			resets = <&reset RESET_PCIE_PHY>;
+			reset-names = "phy";
+			#phy-cells = <0>;
+		};
+
 		aobus: bus@ff800000 {
 			compatible = "simple-bus";
 			reg = <0x0 0xff800000 0x0 0x100000>;
-- 
2.24.0

