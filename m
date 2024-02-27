Return-Path: <linux-pci+bounces-4100-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0891A868DBF
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 11:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B6531C23A06
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 10:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0569513A261;
	Tue, 27 Feb 2024 10:37:06 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2118.outbound.protection.partner.outlook.cn [139.219.17.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D4613A241;
	Tue, 27 Feb 2024 10:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709030225; cv=fail; b=afOoyf1ajOl0X/VoUmp239RjZ/tDzjFabHq5gX/zesq8lGaNiV/WORSFB8FyL/AXYKzsKgluXIt1m0YdZyVn/0FdX30tlDMSWBD02Awzs1CnXAkKPsGanmPgaOo86+TdiO3CvguHjeb0E7z7Scq3dIWvf6ALrpfroJRg90ybKp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709030225; c=relaxed/simple;
	bh=ezVb01ARc2sotdU/DiPWhdNByguKOhyFg0gEaneG3TQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FpEiFWFEePppLsccBqgh7/oud4QTXuSrAUnWLehCYDhfh6uALlggeEX036F0+0IthT7Xj9s9iKUz2EiRP4y+YymQZkrHQIQI+JbgfS/p96E2i3tAA6BZ9Zuz/XZZQpgegoH2VrUiQLEz184P15QWkmP8Y3y8DLO5R9nPw9CBRHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R8bVlD3BDnFai3IZ76+eknamDp3QJrGDqaBSLhIcjfiEtG9Td7Z5cgCQ6ZF91eEWjWuPM2v/RwUoaUqPR/7IjxkTJaeq+xLtKrCND4DKI2blHYFzyLldpH7EdBguMkBwAZFmOVO4LgBxiOLxb4iuipbhWjhh1apWE8BSPzntTIA10DLp72NUxLVWb2WSYk4qUOSgK5VkgbqwT5/9rOPekxe94ooHjGPyMxLOhi2ASssHane5nVr3a4DZ0be9x8NICBeQeGua0pbEZn21Sv8LIBZkUIBAlOXdNKyMttEjflmj9DePtyKwuIcXLQW4o9vaiQLQuyZjG+KCJdYt09vNZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dKh7nmkaSdzB3ghyDF6RJecUyhtYIfwA0UmbLzDOakc=;
 b=S8VfzSQf/F9zasoBp60TH86cppt6YH4bD0beKqYDtCJat/NUVMep5o5tnS5nvxq1wBbYbqb4t/SLkP8rhmAeiYjFtCt4N+dfuK2NX+kCAOIkc8djJTrNfUThygyR3SAeKAjB7khSb2/jgrng3+R49oyXD69RxNwRebjm+oBDKRd3LeT6zH777Zg7OR3fQVM7SHsJ8kuDBJ7SE1GWPsyQxPQf22Cb6sM7K7rff68qhTn8a+96q79daUjCggk6F99hFieVuwhnn+SfEsWV3acMg7ecij1zPzCPbKsXxVdnS9QmDHViqog37JEh0FpnAcb5yKvcM0+gEuVwwEtdc9zVAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0496.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.47; Tue, 27 Feb
 2024 10:35:49 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::5a5a:fa59:15fd:63dc]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::5a5a:fa59:15fd:63dc%3])
 with mapi id 15.20.7270.047; Tue, 27 Feb 2024 10:35:49 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Conor Dooley <conor@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
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
Subject: [PATCH v15,RESEND 19/23] dt-bindings: PCI: Add StarFive JH7110 PCIe controller
Date: Tue, 27 Feb 2024 18:35:18 +0800
Message-Id: <20240227103522.80915-20-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240227103522.80915-1-minda.chen@starfivetech.com>
References: <20240227103522.80915-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0003.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::15) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0496:EE_
X-MS-Office365-Filtering-Correlation-Id: 49c8d5ee-2c30-410a-6deb-08dc377fdd2f
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	K4rfD9vkI5XNvEC6lp/ejKgUta4TIcS1DLFNAZVUBA3eGOCO9hTYJ3I4DmdGgxXTIsOydlMV8yOI/WZU+r3HjZYaA6aIWQymYCtrc2p7CecqpUnEmlN3JLcV0KXm+H3vPif/wIYGtghdOgMJA1jnx26UlaWQr0lcm04ZIsnDTUN5I1OPVfkx61n1ydBP5bL6l3fSkxJRZfBctpx0eqY0rMdwd1Ig14veIFhWWNxmPrWf6Tou95il0DLncxE5uMiHUwWOCdydnDVTYnvut7PE4SqU2PbD3O/4R8x+00Wg0HZtWW7Td/uhdgDwO7Ydn3kQvHvE5oZpD9ig2vkKPkHMw0mALK7lMliO6PXgqhl7XIrh8idmD74kgDRCD5Lw5huuftL/RSXTCSeoRW+ocuh9oIxxfMDXdikrUWolUsBYIA2sjwjWciNrwbh7pZatLXigHRkoudrikCL6D9K86zs1DuEFvvLVd4Krr8FlWqM3NXcmyCdqn27h0rZ0V8ElTZIPIYPChi5BjOtkV7H0gPtRngzq3mvr4DmoCgGhomcUXyMLFNg/qEz2XArUZCAm692mApus6yKxIbvTtQG2+TDtDxAxllac+EWaupi0PSbjZwY/NHcWmQ/CEiuCZdKPgC9Z
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UY79KnfCaZaw1qBJ2UwqTJv78YTTu0eu9eyKmpsbwjOXlFsLToItsTuQmm0S?=
 =?us-ascii?Q?lKT1uNukC3KEJvxdRjhzsWAt6N/o3tQ8n/vl77DsARk9lQ5MKmDrFKNRoCDV?=
 =?us-ascii?Q?tSTZxNspP5I3YabbKKHr/bc/6BsW22JwvpS1HHyz4IlJNjYmL0FpPhKDwGxu?=
 =?us-ascii?Q?P7tt83V18CdRMRgNy7KZs2r8NFUBq7xSnG24aFkBu7v5GZSfrt5hBFprnEIa?=
 =?us-ascii?Q?6TMs0p5AtECjV+zeFj9VsCw41rwkvfwS/86nq6t/pMkrGtPZzQRMJ4qRZ3wl?=
 =?us-ascii?Q?/CVPizEv+V27zC4qG4xbs+sLjvF4hacmVsJBIEvW9ePGdiy26Iyerqwur4J+?=
 =?us-ascii?Q?hnRDDKzs572bDVD0m6AQPlABash4VD26G00jJbVHOu/HphMIrfQJaer20/9Q?=
 =?us-ascii?Q?WOP4vIwy1k1z3iNsVFyJixqUHs5gnA/+LitCMC0gmYh8xHecCyI9DWegOiqN?=
 =?us-ascii?Q?sWX6xoq8JgFPqMu1PXHqRaqslFNYbutWKwS9F2oUxsberf8XDwByx5H/KFYP?=
 =?us-ascii?Q?p0rNf1XdvIMM2uI2fBuQ+ne9oePlhCud5SQJ9KycPmSs/JjsqboeqNWvNqvW?=
 =?us-ascii?Q?gZOOnA7StKjOC4bFGm/ZroHzgkudcSyjSUR8Gf7VCwCgpt3LsNPwOZ/+o+Kq?=
 =?us-ascii?Q?p0rIAj72CTe4OkaLvIKm2BrDkAVc0lYg2Eaw6wZyRc92JHZmUInDQBT244oA?=
 =?us-ascii?Q?uSPjaam8p3nDrTH6cL4uT/SQSVVKJuzIZ6WVN2PJhXtqxZdu+dlU1BaLp6z1?=
 =?us-ascii?Q?lgANSMh14h/9Rpfja+9Cu1W1ETHvfF2C/02qm3Hynm/QAIavu7OjAGZbiT2a?=
 =?us-ascii?Q?kI+iMcAQ7CM/8BQNciW65+FZzUY1ENKQDc91OiYoNolnLFdfrraoVMRYAHUb?=
 =?us-ascii?Q?dSDdYPbKhhJIrMx7jDh1sTE6o6GRiE45B3+VVmqXclr0wnc7UbfCv0hljDAz?=
 =?us-ascii?Q?RwYpxMxymdkwc9jkM1EHe+vplXbS6OvacnU4bWifdzlnsNm7gGdxvgf5Z5Fg?=
 =?us-ascii?Q?Bn6Ri+wrs2bRLNJvFZWzwmzEmULUvBqYl3BdFnpNE5RC+B9L8sRzhCTbFQJA?=
 =?us-ascii?Q?o2cQAlZtVmmU+7QxR9bEvPv2V07sP/atYptVYM8FwANPVMszSwNKfcOky04U?=
 =?us-ascii?Q?UcCFYtX6P2WTejTQ46IEIbUZBQ2m8y7b0xTMv55j+TBGIZNFr3yF6JfQUyb9?=
 =?us-ascii?Q?g4bCITQInkjDY5Q5MBAaS/6lBvG5VI3QdNfF2NdCVwT6TU2K6JC5shfAvdz3?=
 =?us-ascii?Q?MkYkFriQsHoK8zp04q/JCCb7N+u0Gkcy2TFIw6FkddmaUueHp6ZLhHmefHWo?=
 =?us-ascii?Q?iNdGWmQ6MwpM1xq+lVt3aOlSiCIcbOhBY94WsRytat2VbGLHfy79mAB3qcSX?=
 =?us-ascii?Q?CUzm6AhfM+DPLAxJRucDGNvDC7RDAGZE1CaX7bPrC08hnn3e4H8g6YvnbVEm?=
 =?us-ascii?Q?MDA65jIkStsagVjWn/jzu6GcLbBRLJfJUlDFUP8KJMY5iMmx0iiAnXcYI7XH?=
 =?us-ascii?Q?IJPwvFP0WK+PTVuJIOaM8IwFX+yA8zCryRpnwFhxFmazSz2gPotJybp2QUJU?=
 =?us-ascii?Q?28/s2ClwrXzWfC7WV7EB0UpiCIM/leRYKqU0rZzLTM2lL4Q7zMj9dbUFqXrp?=
 =?us-ascii?Q?sg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49c8d5ee-2c30-410a-6deb-08dc377fdd2f
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 10:35:49.2228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dQXDccumKJW5coy572kIBSGozqdPzhCbcy8po55MXmV1ok8XDyzEKDenGkU/AYH6nO5k3Zfw3sumAmznASCM9vRNTuoWo1Iy/ynx/CHgAec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0496

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


