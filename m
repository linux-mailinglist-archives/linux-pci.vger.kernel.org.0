Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF79B1BCE9
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2019 20:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732336AbfEMSJ2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 May 2019 14:09:28 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:3260 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732296AbfEMSJ2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 May 2019 14:09:28 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cd9b2b00000>; Mon, 13 May 2019 11:08:48 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 13 May 2019 11:09:27 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 13 May 2019 11:09:27 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 13 May
 2019 18:09:27 +0000
Received: from manikanta-bm2.nvidia.com (172.20.13.39) by HQMAIL.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 13 May 2019 18:09:23 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V3 24/29] arm64: tegra: Add PEX DPD states as pinctrl properties
Date:   Mon, 13 May 2019 23:37:39 +0530
Message-ID: <20190513180744.16493-25-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513180744.16493-1-mmaddireddy@nvidia.com>
References: <20190513180744.16493-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557770928; bh=wTmWUtqVuZaq+doe6n8tn4jUysCcjSIn15ycJ+Qbtcs=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=boS0OJlRSO45JP/6L9Zqwc27sXNc7hBBHt/KCYp6v6vi5wfA0Cx6t3mDXEbQEKWCL
         LpHcfNTKQEceAoE1SE+YEeSRqu4rbotNy74syIw4OrHdEy9Y7FknE2BbfUs/ix1HJb
         1j3dBAEKM3tWb9DM1G/+TntfUfwKGTliAjvVTHZl10R9vu0iw1i4xoSMYZIde+Ch+A
         ajhSRbMzrDTVySAv2Dq4bF5vw7ZqbITUJj2IGri8VhSmQZ8FPVUtnKy6ElMkeJ8Swj
         rCfVV9LdhhEOjQ3mBgerJ8vkhPnrYseW4IJjSWZTGQ+055NHWLfrLqUQ6MSdl4hNba
         zcRaNXMdktYnw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add PEX deep power down states as pinctrl properties to set in PCIe driver.
In Tegra210, BIAS pads are not in power down mode when clamps are applied.
To set the pads in DPD, pass the PEX DPD states as pinctrl properties to
PCIe driver.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V3: No change

V2: Using standard pinctrl names, default and idle

 arch/arm64/boot/dts/nvidia/tegra210.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index a550c0a4d572..3899c54ea28f 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -48,6 +48,11 @@
 			 <&tegra_car 72>,
 			 <&tegra_car 74>;
 		reset-names = "pex", "afi", "pcie_x";
+
+		pinctrl-names = "default", "idle";
+		pinctrl-0 = <&pex_dpd_disable>;
+		pinctrl-1 = <&pex_dpd_enable>;
+
 		status = "disabled";
 
 		pci@1,0 {
@@ -848,6 +853,20 @@
 			pins = "sdmmc3";
 			power-source = <TEGRA_IO_PAD_VOLTAGE_1V8>;
 		};
+
+		pex_dpd_disable: pex_en {
+			pex-dpd-disable {
+				pins = "pex-bias", "pex-clk1", "pex-clk2";
+				low-power-disable;
+			};
+		};
+
+		pex_dpd_enable: pex_dis {
+			pex-dpd-enable {
+				pins = "pex-bias", "pex-clk1", "pex-clk2";
+				low-power-enable;
+			};
+		};
 	};
 
 	fuse@7000f800 {
-- 
2.17.1

