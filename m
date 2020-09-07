Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C75D425F2B6
	for <lists+linux-pci@lfdr.de>; Mon,  7 Sep 2020 07:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbgIGFqR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Sep 2020 01:46:17 -0400
Received: from inva021.nxp.com ([92.121.34.21]:33192 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726913AbgIGFqP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Sep 2020 01:46:15 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 66D42200C66;
        Mon,  7 Sep 2020 07:46:10 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3229C2000E9;
        Mon,  7 Sep 2020 07:46:05 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 1C04C402EB;
        Mon,  7 Sep 2020 07:45:54 +0200 (CEST)
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bhelgaas@google.com,
        robh+dt@kernel.org, shawnguo@kernel.org, leoyang.li@nxp.com,
        lorenzo.pieralisi@arm.com, gustavo.pimentel@synopsys.com
Cc:     minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCH 6/7] dts: arm64: ls1043a: Add SCFG phandle for PCIe nodes
Date:   Mon,  7 Sep 2020 13:38:00 +0800
Message-Id: <20200907053801.22149-7-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200907053801.22149-1-Zhiqiang.Hou@nxp.com>
References: <20200907053801.22149-1-Zhiqiang.Hou@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

The LS1043A PCIe controller has some control registers
in SCFG block, so add the SCFG phandle for each PCIe
controller DT node.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 70e07612da12..30ccf1fdb851 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -822,6 +822,7 @@
 			interrupts = <0 118 0x4>, /* controller interrupt */
 				     <0 117 0x4>; /* PME interrupt */
 			interrupt-names = "intr", "pme";
+			fsl,pcie-scfg = <&scfg 0>;
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
@@ -849,6 +850,7 @@
 			interrupts = <0 128 0x4>,
 				     <0 127 0x4>;
 			interrupt-names = "intr", "pme";
+			fsl,pcie-scfg = <&scfg 1>;
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
@@ -876,6 +878,7 @@
 			interrupts = <0 162 0x4>,
 				     <0 161 0x4>;
 			interrupt-names = "intr", "pme";
+			fsl,pcie-scfg = <&scfg 2>;
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
-- 
2.17.1

