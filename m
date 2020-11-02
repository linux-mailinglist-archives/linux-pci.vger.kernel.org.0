Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C00632A27DB
	for <lists+linux-pci@lfdr.de>; Mon,  2 Nov 2020 11:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbgKBKMd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Nov 2020 05:12:33 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38244 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728005AbgKBKMc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Nov 2020 05:12:32 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A2ACP1I003069;
        Mon, 2 Nov 2020 04:12:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604311945;
        bh=GYtAOEut/0FFiR6xZ9eTzNKBNpdk6Wpn5qkaz83y1S8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=yXwZff6xjWCAuax1EGSx14PxSp+w/81WdPv/FMdnp6wxPb9Mp00VX7X1fRvatg/th
         Bbey6CYEqvqgeaHee2M1h32ayz0zHFbj7ApmQFJsyzyMq5sGhF2IOzB1U4Aye6K39t
         pJSvZoQE2wmBThtVBdemfiKaJP/F08nU27jYghaU=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A2ACPHY067678
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Nov 2020 04:12:25 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 2 Nov
 2020 04:12:25 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 2 Nov 2020 04:12:25 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A2ABtud059084;
        Mon, 2 Nov 2020 04:12:22 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>
CC:     Roger Quadros <rogerq@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 6/8] arm64: dts: ti: k3-j7200-common-proc-board: Enable SERDES0
Date:   Mon, 2 Nov 2020 15:41:52 +0530
Message-ID: <20201102101154.13598-7-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201102101154.13598-1-kishon@ti.com>
References: <20201102101154.13598-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add sub-nodes to SERDES0 DT node to represent SERDES0 is connected
to PCIe and QSGMII (multi-link SERDES).

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../dts/ti/k3-j7200-common-proc-board.dts     | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
index ef03e7636b66..65a2e5aeb050 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
@@ -8,6 +8,7 @@
 #include "k3-j7200-som-p0.dtsi"
 #include <dt-bindings/net/ti-dp83867.h>
 #include <dt-bindings/mux/ti-serdes.h>
+#include <dt-bindings/phy/phy.h>
 
 / {
 	chosen {
@@ -213,3 +214,25 @@
 	dr_mode = "otg";
 	maximum-speed = "high-speed";
 };
+
+&serdes_refclk {
+	clock-frequency = <100000000>;
+};
+
+&serdes0 {
+	serdes0_pcie_link: phy@0 {
+		reg = <0>;
+		cdns,num-lanes = <2>;
+		#phy-cells = <0>;
+		cdns,phy-type = <PHY_TYPE_PCIE>;
+		resets = <&serdes_wiz0 1>, <&serdes_wiz0 2>;
+	};
+
+	serdes0_qsgmii_link: phy@1 {
+		reg = <2>;
+		cdns,num-lanes = <1>;
+		#phy-cells = <0>;
+		cdns,phy-type = <PHY_TYPE_QSGMII>;
+		resets = <&serdes_wiz0 3>;
+	};
+};
-- 
2.17.1

