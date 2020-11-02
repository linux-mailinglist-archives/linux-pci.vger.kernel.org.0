Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30A382A27EA
	for <lists+linux-pci@lfdr.de>; Mon,  2 Nov 2020 11:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbgKBKMh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Nov 2020 05:12:37 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39282 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728478AbgKBKMg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Nov 2020 05:12:36 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A2ACU6S012628;
        Mon, 2 Nov 2020 04:12:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604311950;
        bh=IpwM0VYjFst7O7GZPtDw/QKWR6xLDCT8pa2h5EbOyBs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=G6cFQoqzyjpVf/XGVk6VzOfg7fO3kMzmPtnhDa/JvQm2Pjw1FZvnjBqlxCtpBMaSn
         gWEg4lPLrXB8ZrGxr0WtyDlPp/V7CkwZtLCRy4cDtjOorhlaVk2+Q8ZfCqpc272z9t
         iXTzhiDJJHnG4mpC3gsWb2EfjFl/M7GSR964aKBE=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A2ACU4o045730
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Nov 2020 04:12:30 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 2 Nov
 2020 04:12:29 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 2 Nov 2020 04:12:29 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A2ABtue059084;
        Mon, 2 Nov 2020 04:12:25 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>
CC:     Roger Quadros <rogerq@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 7/8] arm64: dts: ti: k3-j7200-common-proc-board: Enable PCIe
Date:   Mon, 2 Nov 2020 15:41:53 +0530
Message-ID: <20201102101154.13598-8-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201102101154.13598-1-kishon@ti.com>
References: <20201102101154.13598-1-kishon@ti.com>
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

