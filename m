Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 105B712F86D
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2020 13:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbgACMov (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Jan 2020 07:44:51 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:10617 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727494AbgACMou (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Jan 2020 07:44:50 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e0f37160000>; Fri, 03 Jan 2020 04:44:06 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 03 Jan 2020 04:44:49 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 03 Jan 2020 04:44:49 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 3 Jan
 2020 12:44:49 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 3 Jan 2020 12:44:49 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.48]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e0f373d0000>; Fri, 03 Jan 2020 04:44:49 -0800
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <andrew.murray@arm.com>
CC:     <kishon@ti.com>, <gustavo.pimentel@synopsys.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V2 5/5] arm64: tegra: Add support for PCIe endpoint mode in P2972-0000 platform
Date:   Fri, 3 Jan 2020 18:14:04 +0530
Message-ID: <20200103124404.20662-6-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200103124404.20662-1-vidyas@nvidia.com>
References: <20200103124404.20662-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578055446; bh=FjkZOhNMaufgGn7RMeZvw0u4CLJZRsNmQ0ZHtvj+nho=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=IS0NN7r1ikwtKHtnFAy/PTMJD4qiZVhCUyiWvWBci5YvcujTtFJfMNatfmdf8zu9A
         dW5xoJnyKyMWv60rs8YgZqWY8GJFiNMTK0p4AtcRBZ4/QEefyLr5IaDysc7VFg5lG6
         sU0zQRcOj2E5zhrxg22BMrpi6gWsFCW0ZiuZnQADnnpT+C4t+p/rkrTn8TtqNTAclj
         ByaZcNdBmvEuPP36Q4JhgjUKHTMLw6kSIM6h6Q93+Ny+FmNIL5wuPFwYvJQIRbFZX/
         M7vWdgSmPXEg+G/oXMYv7HTGbUPBnOp+LGw+WTp3htkJkTIyNCpAHhbAhFK+ihZoFa
         taqTKwy+2yWkw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add endpoint mode support for PCIe C5 controller in P2972-0000 platform
with information about supplies, PHY, PERST GPIO and GPIO that controls
PCIe reference clock coming from the host system.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V2:
* Addressed Thierry's review comments
* Changed 'nvidia,pex-rst-gpio' to 'reset-gpios'
* Added 'nvidia,refclk-select-gpios'

 .../boot/dts/nvidia/tegra194-p2972-0000.dts    | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
index 353a6a22196d..87ae7c6d38e2 100644
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

