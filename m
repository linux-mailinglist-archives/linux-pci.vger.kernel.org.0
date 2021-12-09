Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3DDA46F653
	for <lists+linux-pci@lfdr.de>; Thu,  9 Dec 2021 23:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbhLIWDi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Dec 2021 17:03:38 -0500
Received: from st43p00im-zteg10073501.me.com ([17.58.63.180]:55205 "EHLO
        st43p00im-zteg10073501.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231286AbhLIWDi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Dec 2021 17:03:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1639086855; bh=A2jhYOomsuOm4V0BEb9bdP5dTvI8ffnV0G50ioBK2m4=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=M40Zm185h/t9iNiu+p4wE2nUpiaUjg9SUMTtcugy6nVu3RYi23+Wblk7NHHvcoK7j
         0OUIDc2YizL5qUC6xWBdp9tNFTEfEtjs9msZkvS/XBvdhTYQVdd1OP4vsNyKM4DDHv
         BY4UYR8ZcZ5StJ0A1eHU0a4aFvyGOR4pWgVefFaIedZhAk0SBm+zFbwYbIvs6lZuub
         x6TZvyA3PLrHqwNvW7md7y8MryV0foPLqZtxH95WwQqLxpcrTiSd3GCdnBSa6kvQTZ
         h2ZzqpgfEhsRo6kj2MMI432mjOdwKyjYgrGFTUMA6p4b2CEEtAK8on0wpFvpCrR8/x
         +I2gnkZ+lG9vw==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-zteg10073501.me.com (Postfix) with ESMTPSA id 8F09AAE053D;
        Thu,  9 Dec 2021 21:54:14 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org
Cc:     Patrice Chotard <patrice.chotard@foss.st.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>, avolmat@me.com
Subject: [PATCH 4/5] ARM: dts: sti: add the PCIe controller node within stih407-family
Date:   Thu,  9 Dec 2021 22:53:49 +0100
Message-Id: <20211209215350.4207-5-avolmat@me.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211209215350.4207-1-avolmat@me.com>
References: <20211209215350.4207-1-avolmat@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.790
 definitions=2021-12-08_08:2021-12-08,2021-12-08 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2112090112
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add the pcie1 entry within stih407-family dtsi.

Signed-off-by: Alain Volmat <avolmat@me.com>
---
 arch/arm/boot/dts/stih407-family.dtsi | 40 +++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index 21f3347a91d6..fe4ea2d5b583 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -631,6 +631,46 @@ spifsm: spifsm@9022000{
 			status = "disabled";
 		};
 
+		pcie1: pcie@9b10000 {
+			compatible = "st,stih407-pcie";
+			device_type = "pci";
+			reg = <0x09b10000 0x00001000>,	/* cntrl registers */
+			      <0x3fff0000 0x00010000>,	/* config space */
+			      <0x40000000 0xc0000000>;	/* lmi mem window */
+
+			reg-names = "dbi",
+				    "config",
+				    "mem-window";
+
+			st,syscfg = <&syscfg_core 0xdc 0xe4>;
+
+			#interrupt-cells = <1>;
+			interrupts = <GIC_SPI 175 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi";
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0 0 0 1 &intc GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &intc GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &intc GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &intc GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+			/* non-prefetchable and prefetchable */
+			ranges = <0x82000000 0 0x30000000 0x30000000 0 0x05550000>,
+				 <0xc2000000 0 0x35550000 0x35550000 0 0x0AAA0000>;
+			bus-range = <0x00 0xff>;
+
+			resets = <&softreset STIH407_PCIE1_SOFTRESET>,
+				 <&powerdown STIH407_PCIE1_POWERDOWN>;
+
+			reset-names = "softreset", "powerdown";
+
+			phys = <&phy_port1 PHY_TYPE_PCIE>;
+			phy-names = "pcie";
+
+			status = "disabled";
+		};
+
 		sata0: sata@9b20000 {
 			compatible = "st,ahci";
 			reg = <0x9b20000 0x1000>;
-- 
2.25.1

