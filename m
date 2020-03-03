Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07BBD1781F2
	for <lists+linux-pci@lfdr.de>; Tue,  3 Mar 2020 20:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731860AbgCCSLY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Mar 2020 13:11:24 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:7391 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731773AbgCCSLX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Mar 2020 13:11:23 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e5e9da20000>; Tue, 03 Mar 2020 10:10:42 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 03 Mar 2020 10:11:22 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 03 Mar 2020 10:11:22 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 3 Mar
 2020 18:11:22 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 3 Mar 2020 18:11:22 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e5e9dc60000>; Tue, 03 Mar 2020 10:11:21 -0800
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <andrew.murray@arm.com>
CC:     <kishon@ti.com>, <gustavo.pimentel@synopsys.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V5 4/5] arm64: tegra: Add support for PCIe endpoint mode in P2972-0000 platform
Date:   Tue, 3 Mar 2020 23:40:51 +0530
Message-ID: <20200303181052.16134-5-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200303181052.16134-1-vidyas@nvidia.com>
References: <20200303181052.16134-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1583259042; bh=jXXaBXN/3T1QNpU2kh+R+FK9v9PeNIStuPovmbh2czA=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=KetUfTXDA8j+Rky5+v5leJqdTCfqtjgiXWqlKemx2Vgv0A2a+qlbdbybC44w+kPqJ
         oRdYvkfA4S6QBzJFzMV+CCwES0pXgqpGFoTH2pUQjq8da5w+iYxERG9HnztYxfJfbb
         57pa68BAKHhc2G0m/tAcVisj+5VBsQePaUAsSxmNdKX8AFwKA5utW1ByGO5jN5g8ty
         EHH/dj4C1M2wGnNx95knyBJpBXFGedTOjEi0htNMaSLoWCkgnOZ0pzQAZBmsi7Uof5
         iui60/rmBSJ3aTbG2zEG6QKnC+ncKkl/NIW9QhLyMjSkCv71Xp+xS/silf/PJJBw7h
         9xUc3RBI9NMng==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add endpoint mode support for PCIe C5 controller in P2972-0000 platform
with information about supplies, PHY, PERST GPIO and GPIO that controls
PCIe reference clock coming from the host system.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V5:
* None

V4:
* None

V3:
* None

V2:
* Addressed Thierry's review comments
* Changed 'nvidia,pex-rst-gpio' to 'reset-gpios'
* Added 'nvidia,refclk-select-gpios'

 .../boot/dts/nvidia/tegra194-p2972-0000.dts    | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
index 985e7d84f161..734eb294d1e6 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
@@ -136,6 +136,24 @@
 			    "p2u-5", "p2u-6", "p2u-7";
 	};
 
+	pcie_ep@141a0000 {
+		status = "disabled";
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
+
 	fan: fan {
 		compatible = "pwm-fan";
 		pwms = <&pwm4 0 45334>;
-- 
2.17.1

