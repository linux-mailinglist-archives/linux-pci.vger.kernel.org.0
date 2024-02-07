Return-Path: <linux-pci+bounces-3228-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D7084D682
	for <lists+linux-pci@lfdr.de>; Thu,  8 Feb 2024 00:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4906B2287D
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 23:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3961C2031D;
	Wed,  7 Feb 2024 23:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TSSvDrn4"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2063.outbound.protection.outlook.com [40.107.105.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5AC20320;
	Wed,  7 Feb 2024 23:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707347785; cv=fail; b=WZ+WlhI5m5fgSNM4fLW/Zai5WVtEzrNCuTk5Vys0KQhDtBlco2t7ZqWG1Bp4obw6KVdnKaasnS2zqINupGnbzP5N4Ck11b2cPfK5g3R0cvQBoXe/+RQf5w5VQ8eHYcpwD7/uFLAlBwXSHfJ3y34g6QnqKDLxvAj2OpMKB9N3USA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707347785; c=relaxed/simple;
	bh=eAPLNrmo3F41u5UTYudICFt1twI2J5fnZywndxka+8E=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=U9ypEidB5KbF2+pb/Sweh5jS2Haw0wlWk+qlYy9xLUizxB/QbWA7ln0ToeOy4IwrBxGSt+jM+zyO7IG+5IvmruzJbh7gAryO+YDDB6ytV4PP7Av+VLDPfQ4Du6HNHZITNHIc95rlrACAqPKlOvCo7uHRlRByquOI11ODTVZouQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=TSSvDrn4; arc=fail smtp.client-ip=40.107.105.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fstO/a03CxvKJgMxNQ5F3amvdYi3oDwMnnMD5MYjXYxAhLxEKK0wys4WWGrxqNdLcpIPTWs+rIPhDQxJkcgvhL3YS8MzAWVaCe7uIhJCEil/7xPIgEcgmZC9IOLkPt7CW5nH0T5L2ceUo6Dngne9bC7oj/Xajqd2zcP1UA5Z7Xo2saUb7RTXx+gVyJHlSoRGhVT7rwNnV29bjEuKH2n1ztBUyom01TsZlfprXyDFUF2SeJKYZWLCZCK6mH+YdK86K7xTIZs6NCrcNk0eYvfWAsmplqKAnYRwIae7bz0aRdLhOaHHAucObidP7KPiajFiR+B/P6Si/sPFjQIPgpSyUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JeQyN4C2BPcnNU6JJ0DDCmMLFAySVvvS75mbMvaFW0U=;
 b=EO8TFHKQkOQn3ZeQfxjo/cgh5owisRd4jlQ96TNFpTXnfs+IvRxG81TDpPSV0OzFeLwatBfipyWHU953vXidKxnivGIyZABK4kdmmLsuFwP0oN2TomB+uMRvmWCjn8JfxichdCV/0uOfqwY64keKzT6Sc9avqXvaA3BQUEiqcWFxibfQq87M9edcE/TrEmlGUlceY5hd4usqxe/z/KL9annIiT4eR2YGjJnaz4ptgfdzEc7/5AoCAsEeMbKsaR94CFLQKgIec1ctZTxBEyZuAuu5bUjCZ0/BLY16l6FQxTKMPChFiP0IFfh+WBjQnhRCcY8COWzrYjHNH4Y/fXwG+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JeQyN4C2BPcnNU6JJ0DDCmMLFAySVvvS75mbMvaFW0U=;
 b=TSSvDrn4rNtKz4DKMWXgMCHbeG8QADVOH9jRyb0J9hNF8D4uqnVAFYrSLw4EWNn3juySo1TCF4SSRKJdEP7gSbUOsWtJu2itx11D1d9sNvj5cAnYHGxLQvw8jR16LTBtD4BQDUS2GkTzTO2eMFOxTOLXM6kxTEmWgyI8Nlt6fYA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB9513.eurprd04.prod.outlook.com (2603:10a6:150:1e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.39; Wed, 7 Feb
 2024 23:16:19 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.035; Wed, 7 Feb 2024
 23:16:19 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH v2 1/1] dt-bindings: pci: layerscape-pci: Convert to yaml file
Date: Wed,  7 Feb 2024 18:15:49 -0500
Message-Id: <20240207231550.2663689-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0018.namprd10.prod.outlook.com
 (2603:10b6:a03:255::23) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB9513:EE_
X-MS-Office365-Filtering-Correlation-Id: dbd1b6e8-2911-4fa9-380b-08dc2832ca79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LKVpcm0CRocgdXDR+MVqVtw1x/5Ugv0SALC0xft1xCHtjdws07WYLfY7p7fk8pGNO+AhzBfv7qY18tYOZG9YE/3kI0VWvCJfE7A8lXzmixRDPo1kxfIEqi+HlhbVBhKxBv4XXUEEus42u6siaOf2WFZaOzaQcxXv9g0QLwXjprHXIj3GwN/7gQ2afJI5huYaZb8ymp3dnWxYo8NbPx1jHYEqXkyZYxAmXXllX1D4Vk8u8Waju2LaLGWuSc8a5VKABX1D3IXW8FpscafJOA0aCB3UtGDCYAsYU2DJQz+3uLsUCVJzPfEltvhCBZQW1DmP1u6moWc/ilWDJaSaMB2l2Lz5HX6s0HrCGPIrDQOoOPWzIQoYkQuC2jwszbyrzaE3x/B6jkWwMk35/A0pW7w4UyWCSIhz9qgWeWK8XJqnki54hKOwZ8quWuYkvlECKYvlaq4ftKWyEkSLLk8EYNwkcZiMM/QNPQr5ILKZmTdmLbCPugPNPh6BxPcut00dyq1FqPEPFXelIok6dCkEB20k6/pDz75baVTJS19q+LQqHafGO7g0zRVR8gDJfJrofWgaIJZK/p2Og2TykJDC0EYuJFD4CctVJV4z4Gm7CLRl0SE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(8936002)(8676002)(4326008)(30864003)(7416002)(5660300002)(41300700001)(2906002)(83380400001)(86362001)(38350700005)(36756003)(26005)(1076003)(2616005)(110136005)(66556008)(66476007)(66946007)(52116002)(6506007)(6666004)(6486002)(966005)(38100700002)(316002)(478600001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AdMENH6CKcC3NGqNtqjuNTeb0ZrsUIzk7/k+4y4AVwBctEnxewXs9C+VAuiO?=
 =?us-ascii?Q?JtyKkNfM7tsXv4p+vRtC6xKu3pta5lPPU1NnjW6RTccXu2mBLz+gzmX2p+QR?=
 =?us-ascii?Q?6YageIbXUyHumHB9polB/SXhxIHqLi/zy8aoezVv0tsnTwvr/CgI2OWiKQXw?=
 =?us-ascii?Q?0qXzPGpCGEs34T1SpzczyotbyihUhAd396F60erFBIZxHLghmPt5AKyxqD4i?=
 =?us-ascii?Q?wDpRHruE+AR/pGCAVAaEF/c4ZyACuRwl85se8sAzXwIcXbYtyc4PZmUQBqAv?=
 =?us-ascii?Q?nheAXNmu/CRK0XutzAvZdfOOhseJ9BlKvUq+LrQYZecrZxO2QJqvD0ejaXxp?=
 =?us-ascii?Q?izwi8zqBLiWV4e5JNJCuj+rkfGmMnHxGr3MTTJyqTvR27LPeIUyP8DCMST6k?=
 =?us-ascii?Q?lhT9PBws4naMzlRYFHmC48N9hosE9yVGSdNyB7yI56qtcbfPGxsjToNKDFJP?=
 =?us-ascii?Q?/tl2NmBtrjFjM0ynP4ycrU2z/zkCFE87uMStyI8UjvU/grnXyboGEw/hqzBn?=
 =?us-ascii?Q?zma7uOhz5FKQySP9K5rQp62VSBjWfUNk2ZL5mViuqbortj41lrWVlGSoGq0g?=
 =?us-ascii?Q?Mwd82CAl5CmWdfy/sMxRZlnOpeR5gWRGm8Ry9fAYE9pT/lXthSLO06iHGqIa?=
 =?us-ascii?Q?gezQVuyIFl7d+9Udck50tvHQSGbAXj8s9fGpEYpEd3VRM3LLwT6raH48FyIX?=
 =?us-ascii?Q?oMuJ3nPMZhF6S8uwkLxZSffsOUWjM5tPaILCdlRY8M03dfKTwk2fdbSThnqk?=
 =?us-ascii?Q?xbiCLED8fhheq8R9i8V1mmOOsEix91KmY95YAxkk6j9kbdQ+ASFjObTVwZ+S?=
 =?us-ascii?Q?gmNuYUHV8FXD6SLzDG/51nqdzJm014SSzP+gqZMYvKjOGDKj3JtxbVbqqdws?=
 =?us-ascii?Q?jVtG+3piL4/YgLNU29i0hRfZhGzRRissR4+KbqvOhEdypHLlYPHerfyiZ/Jh?=
 =?us-ascii?Q?KdSLEFW0RYz8nRaXpshUjgjZAheSYXcFyAWzE00TK+rtnUipDFfEl1D57FYW?=
 =?us-ascii?Q?d8P23uLk9O+Gno1vEADpHmnxOY4dH23hqu+BV8Sm3r1Akld+KKZoY+ZHwQm3?=
 =?us-ascii?Q?PhcNQTX9Aj/6Fjw2jAjnJXx0TSvHyUPq0Y06+ULrDruW3+5JLapZcuBtnIE6?=
 =?us-ascii?Q?QQ2IwU7wwdx3HQQ1wdSk+rIIWxJv+OiFBGY7uRM0x+pFU7CQC4+1+96Sbv+j?=
 =?us-ascii?Q?+VNyd6FldCD20dyrpmvJkbqdaKR8aM4VbqH6BJqS6O2/kFStOfadQYOOW+j3?=
 =?us-ascii?Q?k6rH4RHNQNfeJh6c9BsPVKxYBxyIxzJxZu1m0Wnvr/HScuyaQUP9YqWbzSCB?=
 =?us-ascii?Q?gUws0GNImOYXsKY3PCX3iVs+Rb0edgh9NuHVGbHsNFjLdAMc8f1q4dxzhyx6?=
 =?us-ascii?Q?h+Qq8JoENZYpGgY8W6z6c8N387qxjqnyNqX775nLTcJ2z9YSKLQkL5jon2Kg?=
 =?us-ascii?Q?JCw9Sn6nW0zlrl1WAN8UErhNZypZPaNkwhZwUFBrqS/h9roLykpPfvcn+abq?=
 =?us-ascii?Q?JtOaZhx90+J21n4jc6EBnC2BRoXIy2AGSuV8CP7HsXsayylpBdfoFD7owEHe?=
 =?us-ascii?Q?hGwKIWHR8lxHl6qLMSs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbd1b6e8-2911-4fa9-380b-08dc2832ca79
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 23:16:19.1657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uXSTZEJ5610g/J2Jr2HXBipk2sXpf7KdFODNDaI8kvVK7bUSoxQ7lrHeEtynuSbEKq0kW4b6qTTx1WxRCoAdng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9513

Convert layerscape pcie bind document to yaml file.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v1 to v2
    - remove '|-'
    - dma-coherent: true
    - add interrupts and interrupt-names at before Allof
    - remove ref to snps,pcie*.yaml, some reg-names are not aligned with in
    drivers
    - Add an example for pcie-ep

 .../bindings/pci/fsl,layerscape-pcie-ep.yaml  | 102 +++++++++++
 .../bindings/pci/fsl,layerscape-pcie.yaml     | 167 ++++++++++++++++++
 .../bindings/pci/layerscape-pci.txt           |  79 ---------
 3 files changed, 269 insertions(+), 79 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/layerscape-pci.txt

diff --git a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
new file mode 100644
index 0000000000000..399efa7364c93
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
@@ -0,0 +1,102 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/fsl,layerscape-pcie-ep.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale Layerscape PCIe Endpoint(EP) controller
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+description:
+  This PCIe EP controller is based on the Synopsys DesignWare PCIe IP.
+
+  This controller derives its clocks from the Reset Configuration Word (RCW)
+  which is used to describe the PLL settings at the time of chip-reset.
+
+  Also as per the available Reference Manuals, there is no specific 'version'
+  register available in the Freescale PCIe controller register set,
+  which can allow determining the underlying DesignWare PCIe controller version
+  information.
+
+properties:
+  compatible:
+    enum:
+      - fsl,ls2088a-pcie-ep
+      - fsl,ls1088a-pcie-ep
+      - fsl,ls1046a-pcie-ep
+      - fsl,ls1028a-pcie-ep
+      - fsl,lx2160ar2-pcie-ep
+
+  reg:
+    maxItems: 2
+
+  reg-names:
+    items:
+      - const: regs
+      - const: addr_space
+
+  fsl,pcie-scfg:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: A phandle to the SCFG device node. The second entry is the
+      physical PCIe controller index starting from '0'. This is used to get
+      SCFG PEXN registers.
+
+  big-endian:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: If the PEX_LUT and PF register block is in big-endian, specify
+      this property.
+
+  dma-coherent: true
+
+  interrupts:
+    minItems: 1
+    maxItems: 2
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 2
+
+required:
+  - compatible
+  - reg
+  - reg-names
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,ls1028a-pcie-ep
+            - fsl,ls1046a-pcie-ep
+            - fsl,ls1088a-pcie-ep
+    then:
+      properties:
+        interrupt-names:
+          items:
+            - const: pme
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      pcie_ep1: pcie-ep@3400000 {
+        compatible = "fsl,ls1028a-pcie-ep";
+        reg = <0x00 0x03400000 0x0 0x00100000
+              0x80 0x00000000 0x8 0x00000000>;
+        reg-names = "regs", "addr_space";
+        interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>; /* PME interrupt */
+        interrupt-names = "pme";
+        num-ib-windows = <6>;
+        num-ob-windows = <8>;
+        status = "disabled";
+      };
+    };
+...
diff --git a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
new file mode 100644
index 0000000000000..793986c5af7ff
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
@@ -0,0 +1,167 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/fsl,layerscape-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale Layerscape PCIe Root Complex(RC) controller
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+description:
+  This PCIe RC controller is based on the Synopsys DesignWare PCIe IP
+
+  This controller derives its clocks from the Reset Configuration Word (RCW)
+  which is used to describe the PLL settings at the time of chip-reset.
+
+  Also as per the available Reference Manuals, there is no specific 'version'
+  register available in the Freescale PCIe controller register set,
+  which can allow determining the underlying DesignWare PCIe controller version
+  information.
+
+properties:
+  compatible:
+    enum:
+      - fsl,ls1021a-pcie
+      - fsl,ls2080a-pcie
+      - fsl,ls2085a-pcie
+      - fsl,ls2088a-pcie
+      - fsl,ls1088a-pcie
+      - fsl,ls1046a-pcie
+      - fsl,ls1043a-pcie
+      - fsl,ls1012a-pcie
+      - fsl,ls1028a-pcie
+      - fsl,lx2160a-pcie
+
+  reg:
+    maxItems: 2
+
+  reg-names:
+    items:
+      - const: regs
+      - const: config
+
+  fsl,pcie-scfg:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: A phandle to the SCFG device node. The second entry is the
+      physical PCIe controller index starting from '0'. This is used to get
+      SCFG PEXN registers.
+
+  big-endian:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: If the PEX_LUT and PF register block is in big-endian, specify
+      this property.
+
+  dma-coherent: true
+
+  msi-parent: true
+
+  iommu-map: true
+
+  interrupts:
+    minItems: 1
+    maxItems: 2
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 2
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - "#address-cells"
+  - "#size-cells"
+  - device_type
+  - bus-range
+  - ranges
+  - interrupts
+  - interrupt-names
+  - "#interrupt-cells"
+  - interrupt-map-mask
+  - interrupt-map
+
+allOf:
+  - $ref: /schemas/pci/pci-bus.yaml#
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,ls1028a-pcie
+            - fsl,ls1046a-pcie
+            - fsl,ls1043a-pcie
+            - fsl,ls1012a-pcie
+    then:
+      properties:
+        interrupts:
+          maxItems: 2
+        interrupt-names:
+          items:
+            - const: pme
+            - const: aer
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,ls2080a-pcie
+            - fsl,ls2085a-pcie
+            - fsl,ls2088a-pcie
+    then:
+      properties:
+        interrupts:
+          maxItems: 1
+        interrupt-names:
+          items:
+            - const: intr
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,ls1088a-pcie
+    then:
+      properties:
+        interrupts:
+          maxItems: 1
+        interrupt-names:
+          items:
+            - const: aer
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      pcie@3400000 {
+        compatible = "fsl,ls1088a-pcie";
+        reg = <0x00 0x03400000 0x0 0x00100000>, /* controller registers */
+            <0x20 0x00000000 0x0 0x00002000>; /* configuration space */
+        reg-names = "regs", "config";
+        interrupts = <0 108 IRQ_TYPE_LEVEL_HIGH>; /* aer interrupt */
+        interrupt-names = "aer";
+        #address-cells = <3>;
+        #size-cells = <2>;
+        dma-coherent;
+        device_type = "pci";
+        bus-range = <0x0 0xff>;
+        ranges = <0x81000000 0x0 0x00000000 0x20 0x00010000 0x0 0x00010000   /* downstream I/O */
+                 0x82000000 0x0 0x40000000 0x20 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
+        msi-parent = <&its>;
+        #interrupt-cells = <1>;
+        interrupt-map-mask = <0 0 0 7>;
+        interrupt-map = <0000 0 0 1 &gic 0 0 0 109 IRQ_TYPE_LEVEL_HIGH>,
+                        <0000 0 0 2 &gic 0 0 0 110 IRQ_TYPE_LEVEL_HIGH>,
+                        <0000 0 0 3 &gic 0 0 0 111 IRQ_TYPE_LEVEL_HIGH>,
+                        <0000 0 0 4 &gic 0 0 0 112 IRQ_TYPE_LEVEL_HIGH>;
+        iommu-map = <0 &smmu 0 1>; /* Fixed-up by bootloader */
+      };
+    };
+...
diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
deleted file mode 100644
index ee8a4791a78b4..0000000000000
--- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
+++ /dev/null
@@ -1,79 +0,0 @@
-Freescale Layerscape PCIe controller
-
-This PCIe host controller is based on the Synopsys DesignWare PCIe IP
-and thus inherits all the common properties defined in snps,dw-pcie.yaml.
-
-This controller derives its clocks from the Reset Configuration Word (RCW)
-which is used to describe the PLL settings at the time of chip-reset.
-
-Also as per the available Reference Manuals, there is no specific 'version'
-register available in the Freescale PCIe controller register set,
-which can allow determining the underlying DesignWare PCIe controller version
-information.
-
-Required properties:
-- compatible: should contain the platform identifier such as:
-  RC mode:
-        "fsl,ls1021a-pcie"
-        "fsl,ls2080a-pcie", "fsl,ls2085a-pcie"
-        "fsl,ls2088a-pcie"
-        "fsl,ls1088a-pcie"
-        "fsl,ls1046a-pcie"
-        "fsl,ls1043a-pcie"
-        "fsl,ls1012a-pcie"
-        "fsl,ls1028a-pcie"
-  EP mode:
-	"fsl,ls1028a-pcie-ep", "fsl,ls-pcie-ep"
-	"fsl,ls1046a-pcie-ep", "fsl,ls-pcie-ep"
-	"fsl,ls1088a-pcie-ep", "fsl,ls-pcie-ep"
-	"fsl,ls2088a-pcie-ep", "fsl,ls-pcie-ep"
-	"fsl,lx2160ar2-pcie-ep", "fsl,ls-pcie-ep"
-- reg: base addresses and lengths of the PCIe controller register blocks.
-- interrupts: A list of interrupt outputs of the controller. Must contain an
-  entry for each entry in the interrupt-names property.
-- interrupt-names: It could include the following entries:
-  "aer": Used for interrupt line which reports AER events when
-	 non MSI/MSI-X/INTx mode is used
-  "pme": Used for interrupt line which reports PME events when
-	 non MSI/MSI-X/INTx mode is used
-  "intr": Used for SoCs(like ls2080a, lx2160a, ls2080a, ls2088a, ls1088a)
-	  which has a single interrupt line for miscellaneous controller
-	  events(could include AER and PME events).
-- fsl,pcie-scfg: Must include two entries.
-  The first entry must be a link to the SCFG device node
-  The second entry is the physical PCIe controller index starting from '0'.
-  This is used to get SCFG PEXN registers
-- dma-coherent: Indicates that the hardware IP block can ensure the coherency
-  of the data transferred from/to the IP block. This can avoid the software
-  cache flush/invalid actions, and improve the performance significantly.
-
-Optional properties:
-- big-endian: If the PEX_LUT and PF register block is in big-endian, specify
-  this property.
-
-Example:
-
-        pcie@3400000 {
-                compatible = "fsl,ls1088a-pcie";
-                reg = <0x00 0x03400000 0x0 0x00100000>, /* controller registers */
-                      <0x20 0x00000000 0x0 0x00002000>; /* configuration space */
-                reg-names = "regs", "config";
-                interrupts = <0 108 IRQ_TYPE_LEVEL_HIGH>; /* aer interrupt */
-                interrupt-names = "aer";
-                #address-cells = <3>;
-                #size-cells = <2>;
-                device_type = "pci";
-                dma-coherent;
-                num-viewport = <256>;
-                bus-range = <0x0 0xff>;
-                ranges = <0x81000000 0x0 0x00000000 0x20 0x00010000 0x0 0x00010000   /* downstream I/O */
-                          0x82000000 0x0 0x40000000 0x20 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
-                msi-parent = <&its>;
-                #interrupt-cells = <1>;
-                interrupt-map-mask = <0 0 0 7>;
-                interrupt-map = <0000 0 0 1 &gic 0 0 0 109 IRQ_TYPE_LEVEL_HIGH>,
-                                <0000 0 0 2 &gic 0 0 0 110 IRQ_TYPE_LEVEL_HIGH>,
-                                <0000 0 0 3 &gic 0 0 0 111 IRQ_TYPE_LEVEL_HIGH>,
-                                <0000 0 0 4 &gic 0 0 0 112 IRQ_TYPE_LEVEL_HIGH>;
-                iommu-map = <0 &smmu 0 1>; /* Fixed-up by bootloader */
-        };
-- 
2.34.1


