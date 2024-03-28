Return-Path: <linux-pci+bounces-5333-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA4A88FB2B
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 10:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 140281F222BF
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 09:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9BC7FBDD;
	Thu, 28 Mar 2024 09:19:17 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2091.outbound.protection.partner.outlook.cn [139.219.146.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4772C7F7C7;
	Thu, 28 Mar 2024 09:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711617557; cv=fail; b=cyWXFMZHuH4DB/CrOcj62RWj4cBMJumpLUVAJ67pQclfUBaDi+/8X0vH8Oiq9j5n2Kd1VW97qaGfhs8VQ9aQ02OSiHsodLbF01G5GeIdQRoS0FwnL6IfPGPCYJFbN5eXoFIAljv07pzU6byKwaJx8/RQJHQGqe7KBJZmpGTIlj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711617557; c=relaxed/simple;
	bh=uyb6I2C3gYC/16GGjWHNw+s6yhosktS7xsF6ITGT540=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qwn8t1E1MWThzuRIel+yFdOLtGy0ztUAaBAIf3NkWHMY8qWow8u5rkzymCcfyR/oWphWdSoxEN0GjYBi6HfesxfEmPBabb3eynpvIMIUKlxIOv9gmV2aFVbHB75inyzj08K3MuUtGvzMfZe1TLgHhF2MA9L5AbVtPHJ7N7cbIMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+vesFFt9WvrlUSEUBoBoWripsZVSi9hVKyY914jUOKNox4s/u68x+1VptJvWk8hZbP9zl33WtDMVLGs+UuDREH/hDNtjZyBtxnF0TUTizNlycypHKnD7nRlwGyE73M7FC7DqGSMYf5R9DsUmLAXjNwqogIU8bE7w8AZUxkyV/TlJJuMUGxL/y+64NPsrqRYfgXEOY8mRE6azkSTYIjOryeFpRZ8JL8JjzMBYo67HyN5s2XxzD4/srxLTD8tv2JF0nwgXwIogKREQdd7cO+HaW03bbLTkD1h/XV1eeIRKrOvYycT8QUPoGQ71cV+6Xy9SxQ9buGVT3PK5TrBMjqpuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qHusBfssCi0Zf9y7h8AJ0i5YALEPObwaSdPyyYvQH0k=;
 b=j8eM7p4y6NDdHmPfEgI5Du7yK2cRoo2ehuGcQmhzzIRq4lZOe9aAWZoxxhkLK3FQsocXrjFgX+3Lkgb7vboVu8YvcqvIhijNBOT1hib/6rOVeHLrnEJqOW06JrH596HWlWrXLuidnFDR2prWKo0KnUt7P+/vf8KSVP1YwiWXTfgLGT5YAL2qlrP61R2ttXB3Hagopea8Qdl3YdjFT7tnmDml6Bnh2zMvcbgVRULtaR1t6VFp+anDMychXn3z7CS5SEVJLNkxzIzRR8zwMBidJiYdiFfYLR5avp9pVhgSUhN7OrblvYBCyUjE/upP+7y9rHgA31z7Monx4+Jo5vibNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0559.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 09:19:03 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::c738:9e6b:f92e:8bb9]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::c738:9e6b:f92e:8bb9%6])
 with mapi id 15.20.7409.031; Thu, 28 Mar 2024 09:19:03 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Conor Dooley <conor@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
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
Subject: [PATCH v16 19/22] dt-bindings: PCI: Add StarFive JH7110 PCIe controller
Date: Thu, 28 Mar 2024 17:18:32 +0800
Message-Id: <20240328091835.14797-20-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240328091835.14797-1-minda.chen@starfivetech.com>
References: <20240328091835.14797-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0020.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::16) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0559:EE_
X-MS-Office365-Filtering-Correlation-Id: 191e3b49-1114-4f7b-7186-08dc4f081c14
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/zsGejwzM5eO6jcHavgWg9g75YX5sewmD9YZPsJ6FUO2Yz/wlNI68IH3CBGIk00Kx0+q+sAbhgfp4Q0GQtL/r2UtS0Lth7LXB95b7xf3nxjJ8GXqMxXBMKFtIr2tGBt4FZyiO0d8Udr/s8r2Ba5TjLDsCpLAX42g00FvN2tT/oEi9qMQ6FalL/uOmwO3jOHvsQEEO/mt8oBEUcO8irS53/tWvarv/9azca2ctKpYhmUkGUMBXYReV4+HrPguT18HLDyDES6+/Zs288ICDXE/310+nP+/jlXciUgdjA8gqKfJsWRGuSfeKQcatz9BpMjWlSDZZLsnai5Yw1eLQTe/MbEA6zExGHzK74dvzv7rH7tpsQTdU3an5w4iOIvbd+F2Z/+cG7v1EJHTdsUU1FgqSX4i6q52Zxv9fYo1ATGA9PD7URvJV5mHKXfOQFPQ8zNIQ8VkgP+tB1vckI8SFXyPNWaZdd8GxaNiDN76/DTD1tATR6iAKHZ24DWVDhUzzvA+etkzKriKYqbNQlHLM49CQZM4FjRtjsuYOygHshypwEbLcgjTlIX7uHOa1Lwh8gwEIPngkPsK09O4LjUstcolZnv2EkniNICco3jgpYlBQgtMDcrl3ur9ZwGZXUJJG6Vt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(41320700004)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G2m6B/N/cXp7bsrM+e+ZWmXYnn0Lgmx0zQQzBtVPuBGsA9TshOdxMDCkH9uW?=
 =?us-ascii?Q?enZ1Vgt5zaiye9OTof65OQEZODP6/89VbT/szm12Y3yLA0aVRrYqeUOd0Z96?=
 =?us-ascii?Q?cjXGBNbGdM01XwF0QP0pplmbjnfDmoYZtP8eRuOi9jelVyr2ZA1VxN9Ys6l9?=
 =?us-ascii?Q?rXVWxpEXrIlOuAblo5qLM3zNlz3pdMlulhhN4vBz9tQhuFVgAYoeBIS6KF5/?=
 =?us-ascii?Q?49W6BiRpY0BreybTtu/SgDU9XxHsT/vU37BQIUpSri+cwsWYIthk6WW2IfCp?=
 =?us-ascii?Q?IqfzzaCsEbRLv//WMrssmHHeT2fsxK3sVg8v2SG+HIKFVxEYsfe7DwgCZ7vf?=
 =?us-ascii?Q?dXD5m1dPirr3Q5pDFifZ9Wv9rLZ0inJEZrCD7nYqoXw8VWY4+fYIEmyfERv+?=
 =?us-ascii?Q?VuvX02ycsoro3n04kTQcZWTjESfEqh3fEL8TC49KAHKr3BC3xgcekOXF1bNU?=
 =?us-ascii?Q?cQvhPTy/GJ0BQti8GGAbZwa+GhtrF/T4Owws2MpFlMFEq/j/47t1vaQZTW2i?=
 =?us-ascii?Q?d4KWbbGMxWdCEvbQZ3urxsRlL9rEkS3zEO/JZzrm+Ps7p8ASvZsm2kJslbX0?=
 =?us-ascii?Q?iBSuC513Oz3Pn06q16glLLUTG15vFgYu/wMrt0ZmgmTtVfdRBpp6C0oyJbEo?=
 =?us-ascii?Q?VkY9Rd059W/xQ9iywHaNWn2kKhYM3uw+/zOxynuOWW2XyeAu+OFBqUqpDnrm?=
 =?us-ascii?Q?mGJVXTH7RvIaccwzeenuP7/lgv4obP+4JCgDCv8s/0gY8ZSJh9FeZK3Mt7YD?=
 =?us-ascii?Q?Db3YGCRVhJZQAy8Imb3PxPjlnj2cxd/u9Z4Ac0UlanV2+PdvjmqoClGIpj0w?=
 =?us-ascii?Q?zyglUIXUId/ENoK01lmAL4Ple9AimCOWykOSXNkcVFjpbwT7TTfyrWMm7TFR?=
 =?us-ascii?Q?LN+fIT5WvZzN6pGQl6uk5esuUod5EW+e4T2XwxefmrmParPw0YU5L6foGcqM?=
 =?us-ascii?Q?OqNmjnARIev9pz+d7pmY8uncNl5DxSW9ayEe7+s7s1EXn8F/ekOsPTGNZagF?=
 =?us-ascii?Q?sZ7fMyDzrhj9AXPwcXWm0HilKFlCs+3E34ILFYgej5AsQsNX0M+wcl8ISx2u?=
 =?us-ascii?Q?bFuzXUKsOlQKPmqhXV36ePGx+99ZSfd9Jh8NPt+ETJPaX2fVxEShZ27ogmiF?=
 =?us-ascii?Q?BtUzPQ4z1DaJWAvjBF78o1v0r8lUp2qzfVaGQLuQU2N1TSLrgRMiyovCyBbZ?=
 =?us-ascii?Q?MqgWsN3nzGEVOD+3tf7HguL+vqGFGvaLbtbUpe50nYHSUtbcWakRKYxw87m4?=
 =?us-ascii?Q?TUyhQW2kgKs8tPyFQ0Vo1I0SaNmUDnC58zVNWi0dXvRSenoI4EJDPvYxD0vG?=
 =?us-ascii?Q?as7rt9Zo/dJDuoFBUIZSc3Of2YYM7gF1buf2n44VwtLcI93W/jv+wf+eZlGz?=
 =?us-ascii?Q?0h3iHllffgMUXiVP17ERIDxQ4qay1qzjfP8XSp6bW33VdMT34CWP29V7++3z?=
 =?us-ascii?Q?KkFbu11zphxyTwx1yq8wmS9Lm5Hvfu3plLPYjJ6BOME27rtE24UFZ6WkRrl6?=
 =?us-ascii?Q?FG3KhMnl/oeudU/W1u/1cR53aMqp1GlgRcDK8feUzMGzyrlsG63kZDH094d8?=
 =?us-ascii?Q?fkmwP6TA1BgT33tlfDfStfcqJwKXK1b5f6IiJvtFRD+rZhjBFaUSAeu6Qgad?=
 =?us-ascii?Q?eQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 191e3b49-1114-4f7b-7186-08dc4f081c14
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 09:19:03.0305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rd+qjWv32rWm4mabCUPrDzbUgGHBXkcxpicZkpiQrxaWzqsCv0aVVJZEfZiMe9bcVoIj+URlRgu2Cb1HsXnfltufmSNWNXEp3Vano4Ahaw4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0559

Add StarFive JH7110 SoC PCIe controller dt-bindings. JH7110 using PLDA
XpressRICH PCIe host controller IP.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/pci/starfive,jh7110-pcie.yaml    | 120 ++++++++++++++++++
 MAINTAINERS                                   |   6 +
 2 files changed, 126 insertions(+)
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
diff --git a/MAINTAINERS b/MAINTAINERS
index d85d9db38efa..3772f6893818 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17215,6 +17215,12 @@ L:	linux-pci@vger.kernel.org
 S:	Maintained
 F:	drivers/pci/controller/dwc/*spear*
 
+PCIE DRIVER FOR STARFIVE JH71x0
+M:	Kevin Xie <kevin.xie@starfivetech.com>
+L:	linux-pci@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml
+
 PCIE ENDPOINT DRIVER FOR QUALCOMM
 M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
 L:	linux-pci@vger.kernel.org
-- 
2.17.1


