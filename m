Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4447DCB678
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2019 10:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbfJDIgU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Oct 2019 04:36:20 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:15709 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728462AbfJDIgU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Oct 2019 04:36:20 -0400
X-IronPort-AV: E=Sophos;i="5.67,255,1566831600"; 
   d="scan'208";a="28287642"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 04 Oct 2019 17:36:18 +0900
Received: from fabrizio-dev.ree.adwin.renesas.com (unknown [10.226.36.196])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id A14F241E73E6;
        Fri,  4 Oct 2019 17:36:13 +0900 (JST)
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>, xu_shunji@hoperun.com
Subject: [PATCH 7/7] arm64: dts: renesas: hihope-rzg2-ex: Let the board specific DT decide about pciec1
Date:   Fri,  4 Oct 2019 09:35:33 +0100
Message-Id: <1570178133-21532-8-git-send-email-fabrizio.castro@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1570178133-21532-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1570178133-21532-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The plan for the HiHope RZ/G2N board is to enable pciec0 by default,
and use pciec1 physical interface for SATA (as SATA and PCIE1 share
the same physical interface), therefore move pciec1 enabling away
from hihope-rzg2-ex.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/hihope-rzg2-ex.dtsi          | 4 ----
 arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-ex.dts | 4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/hihope-rzg2-ex.dtsi b/arch/arm64/boot/dts/renesas/hihope-rzg2-ex.dtsi
index ae1ef2d..63e407a 100644
--- a/arch/arm64/boot/dts/renesas/hihope-rzg2-ex.dtsi
+++ b/arch/arm64/boot/dts/renesas/hihope-rzg2-ex.dtsi
@@ -85,10 +85,6 @@
 	status = "okay";
 };
 
-&pciec1 {
-	status = "okay";
-};
-
 &pfc {
 	pinctrl-0 = <&scif_clk_pins>;
 	pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-ex.dts b/arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-ex.dts
index 6e33a3b..c754fca 100644
--- a/arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-ex.dts
+++ b/arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-ex.dts
@@ -13,3 +13,7 @@
 	compatible = "hoperun,hihope-rzg2-ex", "hoperun,hihope-rzg2m",
 		     "renesas,r8a774a1";
 };
+
+&pciec1 {
+	status = "okay";
+};
-- 
2.7.4

