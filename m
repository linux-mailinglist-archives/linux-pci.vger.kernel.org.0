Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 645242A27E6
	for <lists+linux-pci@lfdr.de>; Mon,  2 Nov 2020 11:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbgKBKMn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Nov 2020 05:12:43 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39320 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728005AbgKBKMk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Nov 2020 05:12:40 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A2ACXbL012681;
        Mon, 2 Nov 2020 04:12:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604311953;
        bh=y3F0mMpTS94GzADfCO1F6dKsbjUP2ytKdFaTXQxi3lU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=VbOqdolufMEpSSScR+//d6t6X+VIx29k2FhYkELFxDLh/Yjr3avq34z3lnFZmJ91L
         Yxa8NrJK2JZ7TNBMZj02aMOi3YdEtaZY+ImHIxP/RfKg9tziU272itcL9B5HY+8wNj
         WTSxUF52L73LkAeEzbKfgFJxQ64dP9ShQTC4Xd4k=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A2ACXTL045818
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Nov 2020 04:12:33 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 2 Nov
 2020 04:12:33 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 2 Nov 2020 04:12:33 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A2ABtuf059084;
        Mon, 2 Nov 2020 04:12:29 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>
CC:     Roger Quadros <rogerq@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 8/8] arm64: dts: ti: k3-j721e-main: Fix PCIe maximum outbound regions
Date:   Mon, 2 Nov 2020 15:41:54 +0530
Message-ID: <20201102101154.13598-9-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201102101154.13598-1-kishon@ti.com>
References: <20201102101154.13598-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCIe controller in J721E supports a maximum of 32 outbound regions.
commit 4e5833884f66 ("arm64: dts: ti: k3-j721e-main: Add PCIe device tree
nodes") incorrectly added maximum number of outbound regions to 16. Fix
it here.

Fixes: 4e5833884f66 ("arm64: dts: ti: k3-j721e-main: Add PCIe device tree nodes")
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index e2a96b2c423c..61b533130ed1 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -652,7 +652,7 @@
 		power-domains = <&k3_pds 239 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 239 1>;
 		clock-names = "fck";
-		cdns,max-outbound-regions = <16>;
+		cdns,max-outbound-regions = <32>;
 		max-functions = /bits/ 8 <6>;
 		max-virtual-functions = /bits/ 16 <4 4 4 4 0 0>;
 		dma-coherent;
@@ -701,7 +701,7 @@
 		power-domains = <&k3_pds 240 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 240 1>;
 		clock-names = "fck";
-		cdns,max-outbound-regions = <16>;
+		cdns,max-outbound-regions = <32>;
 		max-functions = /bits/ 8 <6>;
 		max-virtual-functions = /bits/ 16 <4 4 4 4 0 0>;
 		dma-coherent;
@@ -750,7 +750,7 @@
 		power-domains = <&k3_pds 241 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 241 1>;
 		clock-names = "fck";
-		cdns,max-outbound-regions = <16>;
+		cdns,max-outbound-regions = <32>;
 		max-functions = /bits/ 8 <6>;
 		max-virtual-functions = /bits/ 16 <4 4 4 4 0 0>;
 		dma-coherent;
@@ -799,7 +799,7 @@
 		power-domains = <&k3_pds 242 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 242 1>;
 		clock-names = "fck";
-		cdns,max-outbound-regions = <16>;
+		cdns,max-outbound-regions = <32>;
 		max-functions = /bits/ 8 <6>;
 		max-virtual-functions = /bits/ 16 <4 4 4 4 0 0>;
 		dma-coherent;
-- 
2.17.1

