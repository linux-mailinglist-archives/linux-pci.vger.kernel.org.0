Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0152107042
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2019 12:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbfKVLVI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Nov 2019 06:21:08 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:10389 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729459AbfKVKp0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Nov 2019 05:45:26 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dd7bc460000>; Fri, 22 Nov 2019 02:45:27 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 22 Nov 2019 02:45:25 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 22 Nov 2019 02:45:25 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 22 Nov
 2019 10:45:25 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 22 Nov 2019 10:45:24 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.48]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5dd7bc400000>; Fri, 22 Nov 2019 02:45:24 -0800
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <andrew.murray@arm.com>
CC:     <kishon@ti.com>, <gustavo.pimentel@synopsys.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH 2/6] dt-bindings: PCI: tegra: Add DT support for PCIe EP nodes in Tegra194
Date:   Fri, 22 Nov 2019 16:15:01 +0530
Message-ID: <20191122104505.8986-3-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191122104505.8986-1-vidyas@nvidia.com>
References: <20191122104505.8986-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1574419527; bh=SCp1duD2Ut21vhCShMPQ6eGGVMeaFQ/2YUPbWmKKsF4=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=Q6Ljpn3gDLDm53NuuctjUu+Sc4YbQWlgGWwqA/KjQC71BSpU+qZblGBOcWqOC7Ud+
         7JzAhzieEGuor051+AoKyK40P+X9i0+VHbbhIwZ0GaCc3uxxEp83hktYoHRmq7gZk/
         Ryu3IR7Kk/TwtZykO8Nkx9h8X9m40cthefHEZQ6eK+aX+EPC3omZga41ghDCYog290
         3t6Ce5JgmaT+dw/o3Vo1VpGHvkdDhR9F2h0xKT8x3C6/8mM4QmNCPaPqTHnG8bVmKY
         n7EllQoyoYBU8mYlEi20yJAiCii3Hyst8CZKPmue2hBwietzdoCVqQkb4Ys0H9HBm5
         lXG670n7Nl8eA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for PCIe controllers that can operate in endpoint mode
in Tegra194.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 .../bindings/pci/nvidia,tegra194-pcie-ep.txt  | 138 ++++++++++++++++++
 1 file changed, 138 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.txt

diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.txt
new file mode 100644
index 000000000000..4676ccf7dfa5
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.txt
@@ -0,0 +1,138 @@
+NVIDIA Tegra PCIe Endpoint mode controller (Synopsys DesignWare Core based)
+
+Some of the PCIe controllers which are based on Synopsys DesignWare PCIe IP
+are dual mode i.e. they can work in root port mode or endpoint mode but one
+ at a time. Since they are based on DesignWare IP, they inherit all the common
+properties defined in designware-pcie.txt.
+
+Required properties:
+- compatible: For Tegra19x, must contain "nvidia,tegra194-pcie".
+  Tegra194: Only C0, C4 & C5 controllers are dual mode controllers.
+- power-domains: A phandle to the node that controls power to the respective
+  PCIe controller and a specifier name for the PCIe controller. Following are
+  the specifiers for the different PCIe controllers
+    TEGRA194_POWER_DOMAIN_PCIEX8B: C0
+    TEGRA194_POWER_DOMAIN_PCIEX4A: C4
+    TEGRA194_POWER_DOMAIN_PCIEX8A: C5
+  these specifiers are defined in
+  "include/dt-bindings/power/tegra194-powergate.h" file.
+- reg: A list of physical base address and length pairs for each set of
+  controller registers. Must contain an entry for each entry in the reg-names
+  property.
+- reg-names: Must include the following entries:
+  "appl": Controller's application logic registers
+  "atu_dma": iATU and DMA registers. This is where the iATU (internal Address
+             Translation Unit) registers of the PCIe core are made available
+             for SW access.
+  "dbi": The aperture where root port's own configuration registers are
+         available
+  "addr_space": Used to map remote RC address space
+- interrupts: A list of interrupt outputs of the controller. Must contain an
+  entry for each entry in the interrupt-names property.
+- interrupt-names: Must include the following entry:
+  "intr": The Tegra interrupt that is asserted for controller interrupts
+- clocks: Must contain an entry for each entry in clock-names.
+  See ../clocks/clock-bindings.txt for details.
+- clock-names: Must include the following entries:
+  - core
+- resets: Must contain an entry for each entry in reset-names.
+  See ../reset/reset.txt for details.
+- reset-names: Must include the following entries:
+  - apb
+  - core
+- phys: Must contain a phandle to P2U PHY for each entry in phy-names.
+- phy-names: Must include an entry for each active lane.
+  "p2u-N": where N ranges from 0 to one less than the total number of lanes
+- nvidia,bpmp: Must contain a pair of phandle to BPMP controller node followed
+  by controller-id. Following are the controller ids for each controller.
+    0: C0
+    4: C4
+    5: C5
+- vddio-pex-ctl-supply: Regulator supply for PCIe side band signals
+- nvidia,pex-rst-gpio: Must contain a phandle to a GPIO controller followed by
+  GPIO that is being used as PERST signal
+
+Optional properties:
+- pinctrl-names: A list of pinctrl state names.
+  It is mandatory for C5 controller and optional for other controllers.
+  - "default": Configures PCIe I/O for proper operation.
+- pinctrl-0: phandle for the 'default' state of pin configuration.
+  It is mandatory for C5 controller and optional for other controllers.
+- supports-clkreq: Refer to Documentation/devicetree/bindings/pci/pci.txt
+- nvidia,update-fc-fixup: This is a boolean property and needs to be present to
+    improve performance when a platform is designed in such a way that it
+    satisfies at least one of the following conditions thereby enabling root
+    port to exchange optimum number of FC (Flow Control) credits with
+    downstream devices
+    1. If C0/C4/C5 run at x1/x2 link widths (irrespective of speed and MPS)
+    2. If C0/C4/C5 operate at their respective max link widths and
+       a) speed is Gen-2 and MPS is 256B
+       b) speed is >= Gen-3 with any MPS
+- nvidia,aspm-cmrt-us: Common Mode Restore Time for proper operation of ASPM
+   to be specified in microseconds
+- nvidia,aspm-pwr-on-t-us: Power On time for proper operation of ASPM to be
+   specified in microseconds
+- nvidia,aspm-l0s-entrance-latency-us: ASPM L0s entrance latency to be
+   specified in microseconds
+
+NOTE:- On Tegra194's P2972-0000 platform, only C5 controller can be enabled to
+operate in the endpoint mode because of the way the platform is designed.
+There is a mux that needs to be programmed to let the REFCLK from the host to
+flow into C5 controller when it operates in the endpoint mode. This mux is
+controlled by the GPIO (AA, 5) and it needs to be driven 'high'. For this to
+happen, set status of "pex-refclk-sel-high" node under "gpio@c2f0000" node to
+'okay'.
+	When any dual mode controller is made to operate in the endpoint mode,
+please make sure that its respective root port node's status is set to
+'disabled'.
+
+Examples:
+=========
+
+Tegra194:
+--------
+
+	pcie_ep@141a0000 {
+		compatible = "nvidia,tegra194-pcie-ep", "snps,dw-pcie-ep";
+		power-domains = <&bpmp TEGRA194_POWER_DOMAIN_PCIEX8A>;
+		reg = <0x00 0x141a0000 0x0 0x00020000   /* appl registers (128K)      */
+		       0x00 0x3a040000 0x0 0x00040000   /* iATU_DMA reg space (256K)  */
+		       0x00 0x3a080000 0x0 0x00040000   /* DBI reg space (256K)       */
+		       0x1c 0x00000000 0x4 0x00000000>; /* Address Space (16G)        */
+		reg-names = "appl", "atu_dma", "dbi", "addr_space";
+
+		num-lanes = <8>;
+		num-ib-windows = <2>;
+		num-ob-windows = <8>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&clkreq_c5_bi_dir_state>;
+
+		clocks = <&bpmp TEGRA194_CLK_PEX1_CORE_5>;
+		clock-names = "core";
+
+		resets = <&bpmp TEGRA194_RESET_PEX1_CORE_5_APB>,
+			 <&bpmp TEGRA194_RESET_PEX1_CORE_5>;
+		reset-names = "apb", "core";
+
+		interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;	/* controller interrupt */
+		interrupt-names = "intr";
+
+		nvidia,bpmp = <&bpmp 5>;
+
+		nvidia,aspm-cmrt-us = <60>;
+		nvidia,aspm-pwr-on-t-us = <20>;
+		nvidia,aspm-l0s-entrance-latency-us = <3>;
+
+		vddio-pex-ctl-supply = <&vdd_1v8ao>;
+
+		nvidia,pex-rst-gpio = <&gpio TEGRA194_MAIN_GPIO(GG, 1)
+					GPIO_ACTIVE_LOW>;
+
+		phys = <&p2u_nvhs_0>, <&p2u_nvhs_1>, <&p2u_nvhs_2>,
+		       <&p2u_nvhs_3>, <&p2u_nvhs_4>, <&p2u_nvhs_5>,
+		       <&p2u_nvhs_6>, <&p2u_nvhs_7>;
+
+		phy-names = "p2u-0", "p2u-1", "p2u-2", "p2u-3", "p2u-4",
+			    "p2u-5", "p2u-6", "p2u-7";
+	};
-- 
2.17.1

