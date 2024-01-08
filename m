Return-Path: <linux-pci+bounces-1801-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A81F0826C95
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 12:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17CD91F23CAF
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 11:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355AD29428;
	Mon,  8 Jan 2024 11:24:04 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2089.outbound.protection.partner.outlook.cn [139.219.146.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BE814A99;
	Mon,  8 Jan 2024 11:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GJK/3IReauIRjNz6iNidDSYr4W7vENhrhIG+SvqBJLV9U41tH4x9hexcXl4QrbxAPexV3Gbr1IFMbH09ouxRvNl0C9deNrhp9YfMN18mynVm8yf4XgKpsDyPUT6b4RdXZHqN6AhCIpt/aPX9ax4PoUQ1qW0lfpCa/MLx+IEqHQf9afmNdpP3bxmG8JVpSaDUhwhaI107G8/Rk6cslyH1oGa7QBqF9IWOjea8EC4PfBnjIY6kE7JVnJk9QsRuf3w6yqaBcK+0tNMliPEWzGS75H6TNl/wYl2wSnfkySMUenBXlDqm7TYQrqocwGJofZQFdIpM87E03RQUtXxgTypAJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dKh7nmkaSdzB3ghyDF6RJecUyhtYIfwA0UmbLzDOakc=;
 b=ZDGBjQqXOJDR0oCmdUSWdKZQuH/QTHI4D+lvQLeKWVLHXhOGTyt9NaC2hNNOBRgpvhfozImz971Re3jem6RImD+OHrT/NJzJBSzsrZ/oCwlRS4ThR/6bGk2zGUfvgoTqViRZXwIqpDDKfu1ho2yelV+xYvTryMCh3xW6sJTszykYoY2ruFzY5uRuH2iTq2NAELg1nW8AKWK2LRKkqhAnlpReUPDrQejReAbgffVYxcZUOvK/ZSwzBktFVelhHZp1wkfy2AHXceKnZ7ibecXjpEFNCVLjNkpTRfp6/O3UGsD8n+FFh6mz+VD1QSFnEftBsarNc6RuV369LSCLHV0kGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0797.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.32; Mon, 8 Jan
 2024 11:06:59 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::e6aa:baea:fd8c:4cd2]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::e6aa:baea:fd8c:4cd2%7])
 with mapi id 15.20.7135.032; Mon, 8 Jan 2024 11:06:59 +0000
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
Subject: [PATCH v14 19/22] dt-bindings: PCI: Add StarFive JH7110 PCIe controller
Date: Mon,  8 Jan 2024 19:06:09 +0800
Message-Id: <20240108110612.19048-20-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240108110612.19048-1-minda.chen@starfivetech.com>
References: <20240108110612.19048-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0014.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::19) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0797:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e1f906b-b202-44a1-1c5b-08dc1039ef79
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XzLqtqdbDCoyX1rNcIXxwXkXY7yROHBD+99QsywOcn/SX0bz9wUkVrLgcgoHoAwFeR0bmvyo74EIcj+8sNICs/ywxvj0Kr3MRUr8Kzyvf7qXvMz2kDbnD/wQYXT6g1cWXyym3hjG2Mi+cfe1CcDr7LCSeEDOcfUn/v2ANgqb6UXOeAFi7YKCx70RKtNDnbaKdgHsVr5WqU8W+sqjbocqdezV3fzFeWKXOGOoXW2vHhBl0EI7FoLEnKyzwSSztfkuYlDxDeMoqQogotk4nWEWAr990MbCvVExDjHj2W/TX6075Oes6WgLA1JIByh/piugfbTKxcNswDj1NIPAQf1wIKkuE/lkEHFjsWowPrb3dbItwEkrnlIVZ0EnpRP56IBa4NdfvLI/AuHHF1BrnvkFB2iBw356NjnO5Ck91qRH3iJP9t3cdis+K79IpM7ldO+1BbMbuKzYK+MaFc2MJKMLnbEj+KVU6HFd883yE0dUtbQ3UZkRTUcF590JKhedlybbqul9XH7a5h7lrhUa+wntu/AWh8M3kV1UjqgjgQijarRlWIZ8bnpNc2MZ7fqUO9mr7Q9vsswecSFsqCwCLhmMAA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(39830400003)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(8936002)(41320700001)(1076003)(107886003)(26005)(2616005)(83380400001)(44832011)(8676002)(4326008)(86362001)(966005)(52116002)(508600001)(66476007)(6666004)(66946007)(66556008)(54906003)(110136005)(40160700002)(38100700002)(38350700005)(2906002)(5660300002)(7416002)(40180700001)(41300700001)(36756003)(449214003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ki1hL+J7yNZaf01k3sWXdWif66mlS7K8V7Bd+yDQ7SdCfJq2KK4i34r9Xc4P?=
 =?us-ascii?Q?byjpUYK4eVH10P+7iaHnUBU/5WS4E8XXUBe5ZsGjSeHqX8EEPO4i+oOPc/dC?=
 =?us-ascii?Q?JPVMvVL7ic8yqQIqRif3Z8CdBTFu/WaAzipAQbGRUW7DOxl5rM83BN6jAk5J?=
 =?us-ascii?Q?m2QW13s0j8INDcCSWkBwbLntWyygpV35EsuZh8x3PA1bN1U1AtLTNRXqzQZE?=
 =?us-ascii?Q?9vihTDUqaH7fHlK5haL4JjXcHsoIECvx5waf2ari34d0v/KnXUYVCiuEDvQo?=
 =?us-ascii?Q?Jtj/PpAwZjnY7PfucY2iZa1L/90oqsEUM5qRYvo5twQALtVUd/iC0eazUUyA?=
 =?us-ascii?Q?zJ8o16o3w5v9Ch1fFPUtRysA0m7SeFEXUj0kr3fypj7GtitXbq2TfLqQm4n+?=
 =?us-ascii?Q?SfTCvs50dJg/ie5IY1PaayrsrKHkH3gXf0dCyF9Wdj5GO1pnCX/8esEZpckZ?=
 =?us-ascii?Q?ZqI9kc8Jbeh+TDvAu3I7sQqMtzONb8N5gl4m89eeFwiqMEncBXkn4N9cSETL?=
 =?us-ascii?Q?Mw7pnBTbJuGdSzAvjFJeamupBMkEyeeF6OInzr43N9ENhJtP6mM7HrLT0raZ?=
 =?us-ascii?Q?mcV5Wczdhi5l2UNlK3wn4ZYUNZDkWiyR6AuTEflF8U2kkcTn7xgXME8qH/PA?=
 =?us-ascii?Q?MVHXnIpdEYe3XrOwxdT2ky8vbJI1lICch5uJim4NXMD0Q6GzrCbG8S/WGPt4?=
 =?us-ascii?Q?FDKtITPKf6SMNK+SMtrjHf+DrLflEE8L5r2UpaR8jtAoXwkGAZC7yvnsghlh?=
 =?us-ascii?Q?tZjs7Z/7oxQWi4xszvIFRvkcZS9JLFJM0U+Ea0QbjNwrr+umrfBbWJdoSZAN?=
 =?us-ascii?Q?xA7FcY/DBYq8NeWHrH/xl7bIPYKd54bzN01mbsbjRoW/Gmcc3XbDVzmDGmlI?=
 =?us-ascii?Q?HiFKMqa+CFBA/Sl2nk6d7EEx8bXGCl9VKqvsAEJ4cgANvZ+rBxzGpZfrvb8w?=
 =?us-ascii?Q?joJZubmCpylOSwom2kZfThmSzpDm9BEJ69zo5Xmg6qhoJU7BwkfNn7TtCOlX?=
 =?us-ascii?Q?iKFpg9LF7qzc0PyUGIXT3UxOxYV0zlyootHhk9nqWSFMAeA+/VYFj0nMAoDI?=
 =?us-ascii?Q?x1ijvL+4hpXGmmNGTz8/ohVoLKv1AM6R4AjzvnC5X+OnwrZEm4FYQDvs7yCi?=
 =?us-ascii?Q?zDsMmpmSTWkt9ST7DkPHWq+dXQ4Z1gxeeVuQIz9giwcAev9aPSEOAbS7h9YJ?=
 =?us-ascii?Q?iLdyB2GyBJ3okKLV78kuwy/z7lu9NGn1XXal8JRcMn0w+vFSyw71JHgU0vu7?=
 =?us-ascii?Q?66z6QektlJgWXYPuXIxY35zABCbchbTLj7QyVGMn1JWmyRK3T408oYDF+xxA?=
 =?us-ascii?Q?pZdoNn1dH1j5lodrP8DlOc/VcEddSafCN8qauotwUdssuTP6r/pFgc5iVcqF?=
 =?us-ascii?Q?gCkS78ia/pJ5jmkBtj5t5CoLEZDgNvcrQHz4ZPl2yxk2zo3qFYzTy0TqAVgR?=
 =?us-ascii?Q?qQJtUhKpb6GchI9ygxMrF08labGR+zBf1Y5d82wia/EPYxvyqxJ85yfIW7/V?=
 =?us-ascii?Q?OF/dgicKq1jt9ogls0CtC6/pi16q/p1wMs8Hm4yE4rqSSqfUYSY5GsaptoSX?=
 =?us-ascii?Q?sNs2CIkdX3V9rqpc8UjArBeZTdaMWB4ICkcij8Zi86xQd14xTKd9GPY6u3g0?=
 =?us-ascii?Q?qQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e1f906b-b202-44a1-1c5b-08dc1039ef79
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 11:06:59.8229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EIE5b+2zyMPKhigZmY5k4hrWDjDnWGkjBFSm+FPr8q7U2YQgU+q2RYEEK0zp9SmVOwQ/2Jb+XImJzooqjVgPhwJprUkjfpX5en0vFnjT2AM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0797

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


