Return-Path: <linux-pci+bounces-3685-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F211859675
	for <lists+linux-pci@lfdr.de>; Sun, 18 Feb 2024 11:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A508B2120F
	for <lists+linux-pci@lfdr.de>; Sun, 18 Feb 2024 10:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5000B4E1D9;
	Sun, 18 Feb 2024 10:53:56 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2119.outbound.protection.partner.outlook.cn [139.219.17.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD1F184F;
	Sun, 18 Feb 2024 10:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708253636; cv=fail; b=VK/Dh7iO6Z8hv2/DC2dcat060iMbg4RgCOTcG4Ara4Mhmq7XSIgLH9x3525XBDVYD6JXkiENiklS03il0SzpPvivI8W2R7BHP8/uKgyMPgSD4AqosOxvpSEpz9ToBrEUCUk/vJ0iZhCdI0lvPy0qZiymxXeiVcgFKyU4dhwkon4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708253636; c=relaxed/simple;
	bh=ezVb01ARc2sotdU/DiPWhdNByguKOhyFg0gEaneG3TQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NMY/7ebrFJq6r5cvaNkZ7P2n9FUmN/JMyFQPYZUees+rqdHYUcVD00UgEfiV95gSdQpseKawrVt6wPHDoQ+CmGQWrSZrpwKBfipqeZR61LktLTsuJgsAosff+vwHmXLsvacQQmVGOciB+dsizdq0COa8BHxstRDcxC2uMvKwUE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ipsTQfno2e3qe9KcyO90+o05kw9srjfEI17cLnraaeju0Vb6ZUm4GfaacnFfR8r4s9E9bUsacjhKBzW9qt4XMau0EMjnaqzDLRLez/yAmG863Mx3Fd97HJgJYE4Toy/Cr28LP/Zmkjv1LqrRs+c/EibJTgrnfOslM0InI3HoWCu2mZoje3wcy/xCG87OPHsRzV8/Jhp/xLV5GfPFp4ZM6aPJwDOhCTUgV0yoj3GYGbj6UjRSHMOE+CoHYm0pWDOh/tdsPlBPoUmZuvzfUjkF9qKrOj4TtROvmbbqutU2kW58kEqsbNU8+ZkJCneEwxOC/AT07DVSql4oFLAj5EwtSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dKh7nmkaSdzB3ghyDF6RJecUyhtYIfwA0UmbLzDOakc=;
 b=ACsk3dpNTouoZc09ar8GcnFD4OZvf5NF215UVxjV4fYZCW8mpfEZb/dOt25MRxbMrUFKUEVmck6FB0krdnKRYfrFqsQc1TIzXXAPmOPN2yyF0YH8MjKd6z1ZZrIiZvH+7IWpg+OX27pieaEHRGm5aY5ysK7XYlpfyYAaWVTgrtR5S7eCFwngDlJQpMBPMPejkXJVFIMlOOL1scw7xW1JdLh11RXIgnkRf7sYJShoFEp32ykjVPY8WsbGgDCKZv00yHpBxzCSYLajMNkxZzQ/5mGHXLblzun+SKFK3YN10VUg53krUejfRzg9FQ3Y3OrCMs7XR76ttJF79gQtnzQPyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0464.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1d::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.50; Sun, 18 Feb
 2024 10:19:32 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::5a5a:fa59:15fd:63dc]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::5a5a:fa59:15fd:63dc%3])
 with mapi id 15.20.7249.051; Sun, 18 Feb 2024 10:19:32 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Conor Dooley <conor@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Mason Huo <mason.huo@starfivetech.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Kevin Xie <kevin.xie@starfivetech.com>,
	Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH v15 19/23] dt-bindings: PCI: Add StarFive JH7110 PCIe controller
Date: Sun, 18 Feb 2024 18:19:17 +0800
Message-Id: <20240218101921.113528-4-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240218101921.113528-1-minda.chen@starfivetech.com>
References: <20240218101921.113528-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0010.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::21) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0464:EE_
X-MS-Office365-Filtering-Correlation-Id: 366cc90a-f6ee-40d7-e23b-08dc306b196b
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gGcShokTfOcXgz1Vg2mCgyrc6JJuGv9LV2Yb+YisJyIHugJYqzi6T60bH8FapVk07w7+uMKFDpfqfpdI8fQPJkOb7Gndv+nHcvVUdNRbBwTGposseT9i5zYHRGrKyZS6FYqXtCUwJd59ulNpw0cNMtzwZ53/Z4B+CF1Opxd7My7PptjZv9sHqw/HH5Iezyd2A/eG+KaY7Cbri92efovxsdJvUD6aOuuUmWnMSyZMKvwFqLohXP0yTHh9IMInCHNqkTF11UcOAKBySQwbdktw1q4K7zRXGzHSFPaO69NKLMNex91t+n4DVbTABrTtT1ZQ+MKa5kcB760KH31k1VQbKfBjAlRC7hwYqXp8W6UTMBNv1ULOGcJEJByzlcGDgkSOBQJfbed9Ioqen0KT9UMUdNtOLOsNh9O/JAfXw9+BdsGoEGsc+xoP4hikrT2WHsweNu2gBPelWyHBfl62eYUbpPJ7PLpj6XgLT8fiXNMFBTf0ueZJbZz2rGJ5fuG0ZHSyxLj2OxQ1d4sWv1IQ8+X7emIZKw8xBHUtyOFpPIFgVAiIbTTGIIioSlwkRNbzXhrO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(366004)(346002)(136003)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(86362001)(83380400001)(40180700001)(40160700002)(38100700002)(36756003)(5660300002)(41320700001)(38350700005)(7416002)(2906002)(66946007)(4326008)(44832011)(54906003)(66476007)(41300700001)(8936002)(66556008)(8676002)(6666004)(52116002)(26005)(966005)(508600001)(110136005)(1076003)(107886003)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F57FzcTxmz7E7c5rTFWisOErFWcST1IFEI2gwGtOAKlxDUcx0ouxmBpIscR2?=
 =?us-ascii?Q?Sp2IFspurJ1KeifTiSAfJzcITQc87qWvTx6xeVW+5R2IrLmWVkz46lBW6kML?=
 =?us-ascii?Q?LwyNoZvb7aje38kGmRncenK3YgvNX4roLZd5pLcg1CyyD0FJZRI9ceYeM1ds?=
 =?us-ascii?Q?601fXZV4sc3vRR3WmSUIUMWO9waS9pLjAdRzuiiLnakuh6u4wl2w8TSN6ki0?=
 =?us-ascii?Q?M8edtumYnloOgRMlNdPzDyf22wclyqZLjhIKnUBPJdaLQcIQoJzHuz6oFz3c?=
 =?us-ascii?Q?GLeDWm2B5yje/8QwyhK+svMcX9oBrsJy0jjbUX8Ilg2RG3/P5umWtslv8yld?=
 =?us-ascii?Q?vLzqv+1JlxFpzO2VGlqgtjocpJXR2qjQe/CDaqkmBdseAsmOVzEu1fffXxd6?=
 =?us-ascii?Q?EXMbN4IGKQW6MsGn4dk/7TBhrVWRfDuj6JpGwMYtwZsFaEGW9OT+V7HlZGoT?=
 =?us-ascii?Q?MgZcShoLgIxdPZRX0uJ0khIj204f/JeET+4iSh33YTce/fJZ2Imot400fHjh?=
 =?us-ascii?Q?Ie5Kv0nlt+Bn7PqRUR47MjQSWMQANY7lHlaaXIfKk/VoAiCskJd/uJeOz3bF?=
 =?us-ascii?Q?cK4IZjQ8rqvfcPOpKabgGhHKiUZC3TCf2KWdCC29ftXdg21Wvrf3MJEnMzgX?=
 =?us-ascii?Q?IzE2GltE8FF7U2QOolKCfTKrWTcHtrJWJ+Kx8FuBnepUYnuwt0TlGP2F8Mls?=
 =?us-ascii?Q?GLdX9ZA0ha3TIh2Rza9YVAi5S0lKtoj8GMkRI+gU0HF36h+z1S4CE9pW3JB/?=
 =?us-ascii?Q?WeoXDN4cp1DG67vjPV8wpaJkYDXNnedie+dx6ahX2CFp1FipUJVRApVMfdLA?=
 =?us-ascii?Q?MOlsqWy7ZaUOsG/7j6a+CkgsvrqPhVeyTKeJqArvsmbaTJWCJVM07C3tnhWz?=
 =?us-ascii?Q?axl51F9tcWKlD5cf6rvLUY4+k7/gmNPTlYtKsFEesPeuwnRWuoCdo0Iu78TS?=
 =?us-ascii?Q?AKWWBwlth+gX0aw2cg4Pv0l0kE9cMmZ3Jm0AGQ4HpAh5pQ+0zRSv724UORep?=
 =?us-ascii?Q?WrkZWiImzg6QEqXIit9dJyh/jkHRurCtIsl/3GZF246LwhhTxTyckbk2hdwC?=
 =?us-ascii?Q?p31TNI8Jg1DxtfWOhk83u13Cj5KTGb5IyvRlec9yc+wzp9oUDD7vmamF92bA?=
 =?us-ascii?Q?UWWVs/++t1/MahU+AkIAvTPBK+HiW85x1TeDHZsWBerELRJrJV2CsklLv0wc?=
 =?us-ascii?Q?t+QcVq54WA0oK2aPBNOsw+voF4PQ1cUAZxrHKBY3ux3/iDc5hlGU/OUBSvbe?=
 =?us-ascii?Q?dQ2J4JvO+B0M5NuSY3j01Cw9G4GBX7ARtq4+eDz3qIW55uwqPoaylMnPYdJk?=
 =?us-ascii?Q?QAUTYFagwXDuc8fdtd/9JC/H5jAg0TfNh2mRSVybMcwwS/MukimNSAU/sdW+?=
 =?us-ascii?Q?1udehuCh+11kBfQQuKfyJrk2/aVXIExPeOiWnFF4fj29OrvCMbUesD9iQp2h?=
 =?us-ascii?Q?17BcCJXEWy6npdRdnAaGzs99Be21f4rAIj76yZoWe0mzhoH0r1rRgRgLnTnV?=
 =?us-ascii?Q?FVkw1phBFMlke0L9pyIOYcc1xvi/86HT2mSmFZvQYKfTaVEshVVBBbm5q5jd?=
 =?us-ascii?Q?NRdHRNLw14tEKa4Q6eKvSYWjNhGOhAbvamCw41pEbj3b/3ehXdBvX+D4NTSL?=
 =?us-ascii?Q?TA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 366cc90a-f6ee-40d7-e23b-08dc306b196b
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2024 10:19:32.6815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f99RjDCCY0t1BQK6Uy98qvBvkRg8z3ZBUMEi08wgCD6WdKmSUNKNfwmuMdSTiSDA5bF82upHy4OuhcJgSGWp6pu3WkQlGCaLeqW/l9k1pLk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0464

Add StarFive JH7110 SoC PCIe controller dt-bindings. JH7110 using PLDA
XpressRICH PCIe host controller IP.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/pci/starfive,jh7110-pcie.yaml    | 120 ++++++++++++++++++
 1 file changed, 120 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml b/Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml
new file mode 100644
index 000000000000..67151aaa3948
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml
@@ -0,0 +1,120 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/starfive,jh7110-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JH7110 PCIe host controller
+
+maintainers:
+  - Kevin Xie <kevin.xie@starfivetech.com>
+
+allOf:
+  - $ref: plda,xpressrich3-axi-common.yaml#
+
+properties:
+  compatible:
+    const: starfive,jh7110-pcie
+
+  clocks:
+    items:
+      - description: NOC bus clock
+      - description: Transport layer clock
+      - description: AXI MST0 clock
+      - description: APB clock
+
+  clock-names:
+    items:
+      - const: noc
+      - const: tl
+      - const: axi_mst0
+      - const: apb
+
+  resets:
+    items:
+      - description: AXI MST0 reset
+      - description: AXI SLAVE0 reset
+      - description: AXI SLAVE reset
+      - description: PCIE BRIDGE reset
+      - description: PCIE CORE reset
+      - description: PCIE APB reset
+
+  reset-names:
+    items:
+      - const: mst0
+      - const: slv0
+      - const: slv
+      - const: brg
+      - const: core
+      - const: apb
+
+  starfive,stg-syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      The phandle to System Register Controller syscon node.
+
+  perst-gpios:
+    description: GPIO controlled connection to PERST# signal
+    maxItems: 1
+
+  phys:
+    description:
+      Specified PHY is attached to PCIe controller.
+    maxItems: 1
+
+required:
+  - clocks
+  - resets
+  - starfive,stg-syscon
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pcie@940000000 {
+            compatible = "starfive,jh7110-pcie";
+            reg = <0x9 0x40000000 0x0 0x10000000>,
+                  <0x0 0x2b000000 0x0 0x1000000>;
+            reg-names = "cfg", "apb";
+            #address-cells = <3>;
+            #size-cells = <2>;
+            #interrupt-cells = <1>;
+            device_type = "pci";
+            ranges = <0x82000000  0x0 0x30000000  0x0 0x30000000 0x0 0x08000000>,
+                     <0xc3000000  0x9 0x00000000  0x9 0x00000000 0x0 0x40000000>;
+            starfive,stg-syscon = <&stg_syscon>;
+            bus-range = <0x0 0xff>;
+            interrupt-parent = <&plic>;
+            interrupts = <56>;
+            interrupt-map-mask = <0x0 0x0 0x0 0x7>;
+            interrupt-map = <0x0 0x0 0x0 0x1 &pcie_intc0 0x1>,
+                            <0x0 0x0 0x0 0x2 &pcie_intc0 0x2>,
+                            <0x0 0x0 0x0 0x3 &pcie_intc0 0x3>,
+                            <0x0 0x0 0x0 0x4 &pcie_intc0 0x4>;
+            msi-controller;
+            clocks = <&syscrg 86>,
+                     <&stgcrg 10>,
+                     <&stgcrg 8>,
+                     <&stgcrg 9>;
+            clock-names = "noc", "tl", "axi_mst0", "apb";
+            resets = <&stgcrg 11>,
+                     <&stgcrg 12>,
+                     <&stgcrg 13>,
+                     <&stgcrg 14>,
+                     <&stgcrg 15>,
+                     <&stgcrg 16>;
+            perst-gpios = <&gpios 26 GPIO_ACTIVE_LOW>;
+            phys = <&pciephy0>;
+
+            pcie_intc0: interrupt-controller {
+                #address-cells = <0>;
+                #interrupt-cells = <1>;
+                interrupt-controller;
+            };
+        };
+    };
-- 
2.17.1


