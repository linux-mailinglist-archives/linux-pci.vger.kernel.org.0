Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBD3178284
	for <lists+linux-pci@lfdr.de>; Tue,  3 Mar 2020 20:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388354AbgCCSLM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Mar 2020 13:11:12 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:7350 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731860AbgCCSLL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Mar 2020 13:11:11 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e5e9d960000>; Tue, 03 Mar 2020 10:10:30 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 03 Mar 2020 10:11:10 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 03 Mar 2020 10:11:10 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 3 Mar
 2020 18:11:10 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 3 Mar 2020 18:11:10 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e5e9dba0002>; Tue, 03 Mar 2020 10:11:09 -0800
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <andrew.murray@arm.com>
CC:     <kishon@ti.com>, <gustavo.pimentel@synopsys.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V5 2/5] dt-bindings: PCI: tegra: Add DT support for PCIe EP nodes in Tegra194
Date:   Tue, 3 Mar 2020 23:40:49 +0530
Message-ID: <20200303181052.16134-3-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200303181052.16134-1-vidyas@nvidia.com>
References: <20200303181052.16134-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1583259030; bh=t4oCLmABxlwk2MGRSHlpjn2jQ53ejin9noU9fRJaPTE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=D8gkYbYMT1iqiPVSiuopMoTB4o3MuuhnFmIOKO0qhPw+bStvEOUmuS6XH+1KSK9/i
         0htp6zWZGCfU46gJyueOs8BPSiPeh5yv5Vyv7OPAKV4QJrDwIvuyolkfn7dPbZUgc0
         c9+NfODvqA5EaAc2LDTQNFdz5/3V4mBSG/ttTdJPBtikcmMJKhWJ9BS6+BK93FZNjp
         H3j00LPgHGJBRfhZGuIRW4F0uNHUuP8hugD2sYBMDxkWsS3kZUiIaQGIuyUVyX30BB
         NIEBpb96T0hd7GcdjN+Bk1jemZMRGjt4+Lfq5YbpXvCjMoxEO8WKtFPpx9SS24o5/s
         jnW6uGaqMEshA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for PCIe controllers that can operate in endpoint mode
in Tegra194.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Thierry Reding <treding@nvidia.com>
---
V5:
* Added Acked-by: Thierry Reding <treding@nvidia.com>
* Rebased on top of Lorenzo's pci/endpoint branch

V4:
* None

V3:
* Added Reviewed-by: Rob Herring <robh@kernel.org>

V2:
* Addressed Thierry's review comments
* Merged EP specific information from tegra194-pcie-ep.txt to tegra194-pcie.txt itself
* Started using the standard 'reset-gpios' for PERST GPIO
* Added 'nvidia,refclk-select-gpios' to enable REFCLK signals

 .../bindings/pci/nvidia,tegra194-pcie.txt     | 125 ++++++++++++++----
 1 file changed, 99 insertions(+), 26 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
index b739f92da58e..faa3ef5adfbb 100644
--- a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
@@ -1,11 +1,11 @@
 NVIDIA Tegra PCIe controller (Synopsys DesignWare Core based)
 
-This PCIe host controller is based on the Synopsis Designware PCIe IP
+This PCIe controller is based on the Synopsis Designware PCIe IP
 and thus inherits all the common properties defined in designware-pcie.txt.
+Some of the controller instances are dual mode where in they can work either
+in root port mode or endpoint mode but one at a time.
 
 Required properties:
-- compatible: For Tegra19x, must contain "nvidia,tegra194-pcie".
-- device_type: Must be "pci"
 - power-domains: A phandle to the node that controls power to the respective
   PCIe controller and a specifier name for the PCIe controller. Following are
   the specifiers for the different PCIe controllers
@@ -32,6 +32,32 @@ Required properties:
   entry for each entry in the interrupt-names property.
 - interrupt-names: Must include the following entries:
   "intr": The Tegra interrupt that is asserted for controller interrupts
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
+    1: C1
+    2: C2
+    3: C3
+    4: C4
+    5: C5
+- vddio-pex-ctl-supply: Regulator supply for PCIe side band signals
+
+RC mode:
+- compatible: Tegra19x must contain  "nvidia,tegra194-pcie"
+- device_type: Must be "pci" for RC mode
+- interrupt-names: Must include the following entries:
   "msi": The Tegra interrupt that is asserted when an MSI is received
 - bus-range: Range of bus numbers associated with this controller
 - #address-cells: Address representation for root ports (must be 3)
@@ -60,27 +86,15 @@ Required properties:
 - interrupt-map-mask and interrupt-map: Standard PCI IRQ mapping properties
   Please refer to the standard PCI bus binding document for a more detailed
   explanation.
-- clocks: Must contain an entry for each entry in clock-names.
-  See ../clocks/clock-bindings.txt for details.
-- clock-names: Must include the following entries:
-  - core
-- resets: Must contain an entry for each entry in reset-names.
-  See ../reset/reset.txt for details.
-- reset-names: Must include the following entries:
-  - apb
-  - core
-- phys: Must contain a phandle to P2U PHY for each entry in phy-names.
-- phy-names: Must include an entry for each active lane.
-  "p2u-N": where N ranges from 0 to one less than the total number of lanes
-- nvidia,bpmp: Must contain a pair of phandle to BPMP controller node followed
-  by controller-id. Following are the controller ids for each controller.
-    0: C0
-    1: C1
-    2: C2
-    3: C3
-    4: C4
-    5: C5
-- vddio-pex-ctl-supply: Regulator supply for PCIe side band signals
+
+EP mode:
+In Tegra194, Only controllers C0, C4 & C5 support EP mode.
+- compatible: Tegra19x must contain "nvidia,tegra194-pcie-ep"
+- reg-names: Must include the following entries:
+  "addr_space": Used to map remote RC address space
+- reset-gpios: Must contain a phandle to a GPIO controller followed by
+  GPIO that is being used as PERST input signal. Please refer to pci.txt
+  document.
 
 Optional properties:
 - pinctrl-names: A list of pinctrl state names.
@@ -104,6 +118,8 @@ Optional properties:
    specified in microseconds
 - nvidia,aspm-l0s-entrance-latency-us: ASPM L0s entrance latency to be
    specified in microseconds
+
+RC mode:
 - vpcie3v3-supply: A phandle to the regulator node that supplies 3.3V to the slot
   if the platform has one such slot. (Ex:- x16 slot owned by C5 controller
   in p2972-0000 platform).
@@ -111,11 +127,18 @@ Optional properties:
   if the platform has one such slot. (Ex:- x16 slot owned by C5 controller
   in p2972-0000 platform).
 
+EP mode:
+- nvidia,refclk-select-gpios: Must contain a phandle to a GPIO controller
+  followed by GPIO that is being used to enable REFCLK to controller from host
+
+NOTE:- On Tegra194's P2972-0000 platform, only C5 controller can be enabled to
+operate in the endpoint mode because of the way the platform is designed.
+
 Examples:
 =========
 
-Tegra194:
---------
+Tegra194 RC mode:
+-----------------
 
 	pcie@14180000 {
 		compatible = "nvidia,tegra194-pcie", "snps,dw-pcie";
@@ -169,3 +192,53 @@ Tegra194:
 		       <&p2u_hsio_5>;
 		phy-names = "p2u-0", "p2u-1", "p2u-2", "p2u-3";
 	};
+
+Tegra194 EP mode:
+-----------------
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
+		reset-gpios = <&gpio TEGRA194_MAIN_GPIO(GG, 1) GPIO_ACTIVE_LOW>;
+
+		nvidia,refclk-select-gpios = <&gpio_aon TEGRA194_AON_GPIO(AA, 5)
+					      GPIO_ACTIVE_HIGH>;
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

