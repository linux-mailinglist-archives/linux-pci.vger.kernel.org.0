Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D732B2AC1C1
	for <lists+linux-pci@lfdr.de>; Mon,  9 Nov 2020 18:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731325AbgKIRE7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Nov 2020 12:04:59 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:45396 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731319AbgKIRE6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Nov 2020 12:04:58 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A9H4qct001909;
        Mon, 9 Nov 2020 11:04:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604941492;
        bh=IpwM0VYjFst7O7GZPtDw/QKWR6xLDCT8pa2h5EbOyBs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=tfqw9T8T151l+pyju4yVSNOUQV7OlEHiqS7soVCoFiO4f3oy9bC93V5+ThABX4i/B
         7F7zA77+EiTQOuzQCYdI4e7ezRXx45UZy1FTdZubW/NaY3fF02x3vzYS5ocfkM8P6M
         QPCLIXxk0p7ERpZwDb8i4f+kuTIZmyTkY3BDF6Ws=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A9H4qE7096660
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Nov 2020 11:04:52 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 9 Nov
 2020 11:04:52 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 9 Nov 2020 11:04:52 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A9H4Awa036684;
        Mon, 9 Nov 2020 11:04:48 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Roger Quadros <rogerq@ti.com>, Lee Jones <lee.jones@linaro.org>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 7/7] arm64: dts: ti: k3-j7200-common-proc-board: Enable PCIe
Date:   Mon, 9 Nov 2020 22:34:09 +0530
Message-ID: <20201109170409.4498-8-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201109170409.4498-1-kishon@ti.com>
References: <20201109170409.4498-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

x2 lane PCIe slot in the common processor board is enabled and connected to
j7200 SOM. Add PCIe DT node in common processor board to reflect the
same.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../boot/dts/ti/k3-j7200-common-proc-board.dts    | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
index 65a2e5aeb050..174a55a18522 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
@@ -6,6 +6,7 @@
 /dts-v1/;
 
 #include "k3-j7200-som-p0.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/net/ti-dp83867.h>
 #include <dt-bindings/mux/ti-serdes.h>
 #include <dt-bindings/phy/phy.h>
@@ -236,3 +237,17 @@
 		resets = <&serdes_wiz0 3>;
 	};
 };
+
+&pcie1_rc {
+	reset-gpios = <&exp1 2 GPIO_ACTIVE_HIGH>;
+	phys = <&serdes0_pcie_link>;
+	phy-names = "pcie-phy";
+	num-lanes = <2>;
+};
+
+&pcie1_ep {
+	phys = <&serdes0_pcie_link>;
+	phy-names = "pcie-phy";
+	num-lanes = <2>;
+	status = "disabled";
+};
-- 
2.17.1

