Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9AF015B844
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2020 05:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729650AbgBMEKr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Feb 2020 23:10:47 -0500
Received: from mail-eopbgr150051.outbound.protection.outlook.com ([40.107.15.51]:30350
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729440AbgBMEKr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Feb 2020 23:10:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lxy/5fwiKKh6oyXC8QBVWv79omNRrvHv2f2dwMuqsbIwG5R19WYiXwYzJl19vNcS30uFP2msKRuUaPjMSrmEWVyKu2S1miZ7nE5UuK/zxiXmCar1KRSABAgMpLNpob6MvUVunEnc9GErTd/ZXqdkKdnNfdsFHAQnL4bzjBAr3RbkiKrrBmyQO9B1sbILLx+ijOLa5Fe15ZEKbvvng6yJD2nddhFXEGJ6Y8zar1/0U0F5M6W8dpiR6LdLflaMHxhNrclS+wHR6St7tCIwI4U3iuY4ZshU0oJ8++sLtZHkMOqyP8af8jiLYuaJhQ/flME4QLaL0S81JLyQZwHK+yUvJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cf5l4STCJTkkJTF2LJiEUYuRrZH32iOZY7Lx4JtsIbc=;
 b=YpOn6TITGdYQD7/mIeNnaVqqmBVeWGy71CFYcpKrSKfNtptaAqrrzb1JByjLSqgX+e7SBLCaSNhKGy387kM+3PBEM53R0Cb7IrAt/ziLWogBl2g1fgazDHOualqVWW3anCNmag9qAY4LqBWYaYwatxx/gF3zgJNoGipbcQTkW806LNcBvYJsEoynkBSRPhJWF3vnpU9Yq2feFcCEWcrBBINm2ordtV0O4LxWdyhxRypvar7w4uDqA+rvLoFga0Asp11xkii/ICvlq+F96DSHsIdIlBvZ7wvof+ZVu1HyCyf+NMLyzA+ASMINhMQ5IZSLrG4BFq+OiRT3vNTKbk2xmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cf5l4STCJTkkJTF2LJiEUYuRrZH32iOZY7Lx4JtsIbc=;
 b=aQb5viuLo5wY1CpINp9VW040g905y1wol4GATwk8mgX17oo2tPngVi0gis92TPxTwK5aXEB/BUQ800V+sk+BGiiwSovgI7xUjM4jpCcR6LL2JN4x3/wIXbI8OmKT1EuH9cRCmj/5obAIP6/zEJwghZBzy7WbsHuH8vk70QeEW3A=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB7084.eurprd04.prod.outlook.com (52.135.63.71) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.23; Thu, 13 Feb 2020 04:10:44 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::104b:e88b:b0d3:cdaa]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::104b:e88b:b0d3:cdaa%4]) with mapi id 15.20.2707.030; Thu, 13 Feb 2020
 04:10:44 +0000
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, robh+dt@kernel.org, andrew.murray@arm.com,
        arnd@arndb.de, mark.rutland@arm.com, l.subrahmanya@mobiveil.co.in,
        shawnguo@kernel.org, m.karthikeyan@mobiveil.co.in,
        leoyang.li@nxp.com, lorenzo.pieralisi@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com
Cc:     Mingkai.Hu@nxp.com, Minghuan.Lian@nxp.com, Xiaowei.Bao@nxp.com,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv10 10/13] dt-bindings: PCI: Add NXP Layerscape SoCs PCIe Gen4 controller
Date:   Thu, 13 Feb 2020 12:06:41 +0800
Message-Id: <20200213040644.45858-11-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200213040644.45858-1-Zhiqiang.Hou@nxp.com>
References: <20200213040644.45858-1-Zhiqiang.Hou@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0069.apcprd04.prod.outlook.com
 (2603:1096:202:15::13) To DB8PR04MB6747.eurprd04.prod.outlook.com
 (2603:10a6:10:10b::31)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.73) by HK2PR04CA0069.apcprd04.prod.outlook.com (2603:1096:202:15::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.24 via Frontend Transport; Thu, 13 Feb 2020 04:10:38 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.73]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 967cd8cc-177b-432c-81f9-08d7b03ab203
X-MS-TrafficTypeDiagnostic: DB8PR04MB7084:|DB8PR04MB7084:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB70844737BF9EFBB2BC971D4C841A0@DB8PR04MB7084.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 031257FE13
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6029001)(4636009)(376002)(366004)(136003)(396003)(39860400002)(346002)(189003)(199004)(36756003)(6506007)(5660300002)(26005)(66476007)(7416002)(66556008)(66946007)(6512007)(4326008)(52116002)(6666004)(16526019)(86362001)(478600001)(1076003)(2616005)(956004)(6486002)(69590400006)(81156014)(8676002)(81166006)(8936002)(186003)(2906002)(316002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB7084;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: agROas7awzjolGxFAwUXZ8Hm6Sebi+b12r+ajmZzDob04l5lYlrbry4hjLiVTEL4Lx2psExHX8VtqSPZFzJvE5Yy5jsiP+jEQ8XdLFZgLWecNagY+hG5421l79Wwvyt5Km3XAReOqX3X+aUHlEdtss0d5/uvGLxfPPUseS5bbb3qHJnr5RC8uT2xqu9A/dCBjQqQE6ErxuDZgLEvhxdRx4LmQYn08KsAVDR4z8f6O6jfcLqQnuPbSVdpOUX4RtHL4QxUx2qOoFpgNOpaCQB3Tw0GihXq9G68IBqlHcxet9tQebOSjdXzaSpkUJCBMVYCNGpb5nX+c9GlkKhR+fEttYvpU8U/NAdLtrgH+pko1LTQWFBw5lhs13F+VNFyVtnkLy/3rbTsJzebjQ/HJVYdN6f9KYo1qv8z3Fqw8Cq/BENFDjOtB896jf8d/UZztr5dQQ5K0HEDgJGwGEaabYUMnCWSTiD00jYA4WBaO127E+U4703nrOAElj6BjAvsQ9+UnTA9cKzzrfedYBhPWYhMXXjRqTEYkf1vG2JuI/H9Jq8GbASMsMBffabgfSGBalDWDJtUdXQ9Ul77M+S2BZO0NA==
X-MS-Exchange-AntiSpam-MessageData: FEYhR7CppB8PHxnoE+th8v9vCR5ZVWaluibw4pKF5re51yMKc2njHirPrpTP2Moktxg4ecf57cTtZ2rDiT3882yODaqC3OH7RjdHrtAFIvwwEv3GecKljepL07+L8O6zcbnwn77/4lZv9BKySMTK7A==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 967cd8cc-177b-432c-81f9-08d7b03ab203
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2020 04:10:44.1188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T/UXl0Gp73rGl4nA7/gJ9CbPyoKOIz8FPlHMo1Viu11vFOd2HVcJjysl8xfGKmbaoalnM49v6uwxLLwEeQHxAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7084
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Add PCIe Gen4 controller DT bindings of NXP Layerscape SoCs.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
V10:
 - No change

 .../bindings/pci/layerscape-pcie-gen4.txt     | 52 +++++++++++++++++++
 MAINTAINERS                                   |  8 +++
 2 files changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/layerscape-pcie-gen4.txt

diff --git a/Documentation/devicetree/bindings/pci/layerscape-pcie-gen4.txt b/Documentation/devicetree/bindings/pci/layerscape-pcie-gen4.txt
new file mode 100644
index 000000000000..b40fb5d15d3d
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/layerscape-pcie-gen4.txt
@@ -0,0 +1,52 @@
+NXP Layerscape PCIe Gen4 controller
+
+This PCIe controller is based on the Mobiveil PCIe IP and thus inherits all
+the common properties defined in mobiveil-pcie.txt.
+
+Required properties:
+- compatible: should contain the platform identifier such as:
+  "fsl,lx2160a-pcie"
+- reg: base addresses and lengths of the PCIe controller register blocks.
+  "csr_axi_slave": Bridge config registers
+  "config_axi_slave": PCIe controller registers
+- interrupts: A list of interrupt outputs of the controller. Must contain an
+  entry for each entry in the interrupt-names property.
+- interrupt-names: It could include the following entries:
+  "intr": The interrupt that is asserted for controller interrupts
+  "aer": Asserted for aer interrupt when chip support the aer interrupt with
+	 none MSI/MSI-X/INTx mode,but there is interrupt line for aer.
+  "pme": Asserted for pme interrupt when chip support the pme interrupt with
+	 none MSI/MSI-X/INTx mode,but there is interrupt line for pme.
+- dma-coherent: Indicates that the hardware IP block can ensure the coherency
+  of the data transferred from/to the IP block. This can avoid the software
+  cache flush/invalid actions, and improve the performance significantly.
+- msi-parent : See the generic MSI binding described in
+  Documentation/devicetree/bindings/interrupt-controller/msi.txt.
+
+Example:
+
+	pcie@3400000 {
+		compatible = "fsl,lx2160a-pcie";
+		reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
+		       0x80 0x00000000 0x0 0x00001000>; /* configuration space */
+		reg-names = "csr_axi_slave", "config_axi_slave";
+		interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
+			     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
+			     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
+		interrupt-names = "aer", "pme", "intr";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		device_type = "pci";
+		apio-wins = <8>;
+		ppio-wins = <8>;
+		dma-coherent;
+		bus-range = <0x0 0xff>;
+		msi-parent = <&its>;
+		ranges = <0x82000000 0x0 0x40000000 0x80 0x40000000 0x0 0x40000000>;
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
+				<0000 0 0 2 &gic 0 0 GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
+				<0000 0 0 3 &gic 0 0 GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
+				<0000 0 0 4 &gic 0 0 GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 60b4c93914cb..6a2350e10c54 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12773,6 +12773,14 @@ L:	linux-arm-kernel@lists.infradead.org
 S:	Maintained
 F:	drivers/pci/controller/dwc/*layerscape*
 
+PCI DRIVER FOR NXP LAYERSCAPE GEN4 CONTROLLER
+M:	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
+L:	linux-pci@vger.kernel.org
+L:	linux-arm-kernel@lists.infradead.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/pci/layerscape-pcie-gen4.txt
+F:	drivers/pci/controller/mobibeil/pcie-layerscape-gen4.c
+
 PCI DRIVER FOR GENERIC OF HOSTS
 M:	Will Deacon <will@kernel.org>
 L:	linux-pci@vger.kernel.org
-- 
2.17.1

