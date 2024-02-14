Return-Path: <linux-pci+bounces-3463-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B343855359
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 20:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FD551C211DB
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 19:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DCE128368;
	Wed, 14 Feb 2024 19:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="J01s545p"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2063.outbound.protection.outlook.com [40.107.21.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0934112D768;
	Wed, 14 Feb 2024 19:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707939731; cv=fail; b=Nz8FolsnNNq9wvY4xhJ10+FOG29jCwwEuLZZNFYvl7rCwAtN65xZUk820cAfD5nJufxheQgewoysvucNOZufzas9NtOUnWoCpk/si9jptWQ5KwlNgcriXJMqJ3SAYla4c3DMiHqhvCBl3ogtDNRpWbSZCWXLyYWZYS74MBgEFLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707939731; c=relaxed/simple;
	bh=G5l1kafhruJxa/Ru0779olZyba24iCNlg5JbiA1gkIY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=LdfEFAZQN/Vo6Q8/ScXJ7kia/UzeEaHexZh71OfMeQhDpMn82pVMJ0bIWK+B5qj5UAv/mHA6+WUj3UBqc9UOJ4etpIaBKEMImbLg14OH/WhElhzE48wxZ/1rs2G7qJEFZ685njvL+O+3o0LMAXLogPLa5Y5DdOeWt0wnOjiHTgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=J01s545p; arc=fail smtp.client-ip=40.107.21.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BefvZvdLIWPC4uIPl/LPqikVA7zaVRyQoOThqFBUPAn/R8nEwOtn9QWhlDW2dLJnqpuh9R2tBPZK4cUiPIaamSG4u9tnutxkv6jy41ySoxlGm7Hqxo2ltsyAL9VWUWlAB6fe5js8Ve0Xcy2OOrslGuEB2dW3Y8tSS3Zhd+0WOIaEfN8oA1pfh62s9jMkXXT24F7jA4OSmHyKSepSck7jOFo4ZYPpZlFiy/ZX6jXNpDVh3bu74oec9hzjDhyzYdR+FvG+zUZgVimF6zA2wCEnfHDMgogeRgnzo1whFoWeZHJkgO5sxgekzJ8gXjPh+GYO/fvHbvXEnmeDSfDkaBJDDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=55gGF25QRNINrbw1aboCxazy2dX2ubyeeV7kyAAsOPA=;
 b=EMIvPvjUwlMMs4vrAoW8MI9kRbtFwVj8VUBOOB1vXM5oveK7V6fcLlqlnBmcJF6jjbZzeC8qYcGUQ80ZT9gfOUlzkMlYuGbT+6s0TvzyIfOmT+tsnpSZ8Bm7G+qs12gfxy3T+z/kStpcHr+9lJv8d0+tI7c4AXyvtz5Rbh8QUVwYKXDOdM8odDJ3wYD5cEt3bTJ6W/bTYMa2bpkpH4jKf38It8kaFG6rEIv+ZeAq7JaIqxqOj2QUBwqHMtxqsbiZwRBn/ODOHvpCLLug4RqeYZHDay38vWS20hcFMA6MIrwpIihAhsqGIqy1OIZ8+KnN4KrBPoGzog1hxyHtvXYF4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55gGF25QRNINrbw1aboCxazy2dX2ubyeeV7kyAAsOPA=;
 b=J01s545p7zJxLqtGhtqJrbvBaKbXmPElRXQlYA+TkniLZswWNf0uUd8IQleOmKYza22eWMVcs6drF/95JevJ63et+EjhUs6pdRnuj9a1xxiKNrQLE/ImvSLvaP1QyCOcrWNr1F5n1hAAc+0PNTeDIcHHuSmMEMNLb9c3ZLPevRY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB9258.eurprd04.prod.outlook.com (2603:10a6:10:372::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Wed, 14 Feb
 2024 19:42:03 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7292.027; Wed, 14 Feb 2024
 19:42:02 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pci@vger.kernel.org (open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH v3 1/1] dt-bindings: pci: layerscape-pci: Convert to yaml format
Date: Wed, 14 Feb 2024 14:41:44 -0500
Message-Id: <20240214194145.2669744-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0039.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB9258:EE_
X-MS-Office365-Filtering-Correlation-Id: f2b91168-a372-4d1f-db99-08dc2d95042e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	T7wWVw/JvQozLD4AN1i/32nJNrFhdDjcZa7g7zEaINTx3ccPl+kpo/Uo9TcT6wCbbrJ52KVrScIsS57wrrBGym5RCebx6lSb+qM8bXUj1/X0Csp4VltkV2b/geSDD2g6MXlfUYBlpx4ycQMLcbZ9MswH5jBMNLM2K/KdG/CghgH3i3TXgGm/SXm6CFoTyFlKFVb86hwILMkXf/lYSmoRbEKpHK+0AjPpRDOQR8HCy989sAYt9iAF++6rb2T4t3Hrc7miHD/SjDALVFwYNiwu3YwIkoakIxTRN6w76em5U3CrzUqbSCq6/+MJ9Y4megevb4BPcrBrYpqad+/1zb3RbAWBtCf2cPS0WkJkM7rwJ4BpzWEtPS8ItbY5FE3slegUiwAo1vePwYqs1rkh3bLJWA5t/KKjBVXvpSWp3sY7enD4sFFHc3lzcgjxKGCmpiYyU7dUnaR6GNUi4dcMM/EyS29P35aiqok0trmQQ5OeX0QSR+JzIRg+sHa+lQ7QpSTh8+V/7cE9D8bTAlJ+ODFvv9Y49ih16VLrBuQyoGuEvMvPFweA4j1IiwtOg2RCsTkH1GG7YlwkbAU4fu2DmEG09sfArxSuRz08csc9Uygg4hY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(39860400002)(376002)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(6512007)(478600001)(6506007)(6486002)(966005)(41300700001)(2616005)(52116002)(5660300002)(30864003)(2906002)(8936002)(4326008)(8676002)(7416002)(66556008)(66946007)(66476007)(110136005)(38350700005)(6666004)(316002)(26005)(1076003)(83380400001)(36756003)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xkp5mPxUPWrh+RFeDKhBo46rKRi46fV7USpsZ7zxhYxp4U6D+zjtLa2H1shl?=
 =?us-ascii?Q?wHCECjWF0ycJsbhfs6V5m3k3/7jYNqxCp0BxekqOGc/oTi+u+bd4lzx4mYGV?=
 =?us-ascii?Q?fAcaSXdmpfo/OWbWepkOFRP2La7YmbpvN9z0RfOBTLsm/8GRM55nfXZhnSfh?=
 =?us-ascii?Q?mILlKXl85yMPXn41VEfmoPpzThnm8/grXIOHsM2dzvzcE7Y/RWBN9PBOdJiH?=
 =?us-ascii?Q?iPscyyfskg5wVxNhH3eyyFKMY1BwLBHxPTeLrbhbGwtzFSZiUjoBRrnxl4MI?=
 =?us-ascii?Q?P43YbCPZV9YbxQdlk4WZDQ3dRyH5BbiajUlK/SEG3A5jhXEsv7SkH42UF+SZ?=
 =?us-ascii?Q?GuWkthaIQepcieqMg4Z+ZT34q30om476ebMPkeAZV44Sx9wd+rHlv/HZlb/T?=
 =?us-ascii?Q?yiyjz1Uhd2hxuwT3DUCya47iGJOzs0iTjaLCsvnJ9RG6BRSf37nTtyx0pAP6?=
 =?us-ascii?Q?sE3gHWLPY8waikat6COMAANxHvLPRo787SswL8r3nHQT3jM3hmjZtx/oKAoS?=
 =?us-ascii?Q?lCIa0WssNljwp9Bu/3nFFv36HsumK4DBhZYwH4HhEXd7vr39L7pgcOjz24fG?=
 =?us-ascii?Q?wlbOWk4ACzUr9xihCDpjY7UyRFVRH/SqyYfXtX6JTQQrXQJVtEQqJgTDjYDa?=
 =?us-ascii?Q?RpskdLJM+KU1NIisbC2830TKRUXw5tOoMBE+OU/rN8OXW8MCzVly4iv8SUKO?=
 =?us-ascii?Q?jEJ5rqhTbsRBv4Au10rwI988CuGQ7DL/Be/ecfPOPCoL9tSr2MWwYSpB5z8K?=
 =?us-ascii?Q?4uEuc4XdQQmv570T5n5ydXfiSljYVvgzeZ7UhCNuYDwtBrBFhVEdZG2fdJKf?=
 =?us-ascii?Q?2n8tAiHQBxwRPqeR1ud+GvJLoG6rRlXHBPY1S69zyWwUGLaE7PoUoKsbvn8A?=
 =?us-ascii?Q?mfxwn5JhEM5EggwI+xOKuvk1LHqgpuwGSdQm1ZP/RHeG/5hVAVUHPjallLhR?=
 =?us-ascii?Q?2jg7zhcbThZ1hobeodc2l5JXkwUTQ8nB1SzolepJI8B0tYkesXaIsMUzJq7B?=
 =?us-ascii?Q?kpoO7/xHJB/Eta9AMSLjdhI/RIFytO+co2LDYZNPRU98zBRDQQhIgFpzgBpM?=
 =?us-ascii?Q?eaOIuuYpyr6JOSPCOaR8zgaX4G5YchJv1E56qhczDQSyrDctwXNbZrQl6Rcf?=
 =?us-ascii?Q?xKnz4aFON7fZRWzUrM2hTm1wgRm8LsDMI1HmgV8Xp3szHZhRm1DbQUJQz6jU?=
 =?us-ascii?Q?qy2T11iYbxOrrUJ+vXPNMleuc7J8MMyNDkym2yk1j7vVbSvhaXSduqQ+7K5y?=
 =?us-ascii?Q?LpLGzl+kil3haz+OG71bGjLpV8Ms55zEGzTu/efbZJ0JffFVo0Y5QaT+etyX?=
 =?us-ascii?Q?gv3xDNbI8FEit8+zOjpmD54k3YgOSm7h+6BWl9ExCNGvOpvzG1aOsTdSNK0t?=
 =?us-ascii?Q?XRttBIBlFNgJQogpaTJjzVvzkgZ+HlT1LlVRjdoV8dmMqZRTs8ZqEL4qNJfc?=
 =?us-ascii?Q?UJgOjmKUmBIsbE+fuqHcMUaYmef6X8jDZ1GjWU251LzMekqtq1RgOie2proU?=
 =?us-ascii?Q?8/2+P2p0ksASo8mCdlhEloZFEPF6kWBgGA8VwJ988CmE8yMRgObcNAHU6KhD?=
 =?us-ascii?Q?jHH3AKfdN1xpAujbOVyuVja3Vr8W/Sz9m5qdpupW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2b91168-a372-4d1f-db99-08dc2d95042e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 19:42:02.5171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7CnBO3D+gdl+2CpQNy/GXJGx25cMf+8rTd6e2ahwrQbOPuFhzRsTzVo+wCptB61u2XRpq3PaebwbFP5IJypmPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9258

Convert the layerscape-pci PCIe binding document to yaml format.

Additionally, changes for the layerscape-pci endpoint part:
- Add interrupt name 'pme' restriction for fsl,ls1028a-pcie-ep,
fsl,ls1046a-pcie-ep, and fsl,ls1088a-pcie-ep.
- Add register name restrictions: 'reg' and 'addr_space'. 'addr_space' is
required by snps,dw-pcie-ep.
- Add an example.

Changes for the layerscape-pci root complex part:
- Add required property: 'reg-names', "#address-cells", "#size-cells",
'device_type', 'bus-range', 'ranges', "#interrupt-cells",
'interrupt-map-mask' and 'interrupt-map'.
- Interrupt-names requirement split to each compatible string.
- Add register name restrictions: 'reg' and 'config'. 'config' is required
by snps,dw-pcie.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    There are log discuss at v1. If I missed something, let me know.
    
    Change from v2 to v3
    - update commit message, show change compare txt file
    - add failback compatible fsl,ls-pcie-ep.
    - add commit message about 'addr_space' and 'config'.
    
    Change from v1 to v2
    - remove '|-'
    - dma-coherent: true
    - add interrupts and interrupt-names at before Allof
    - remove ref to snps,pcie*.yaml, some reg-names are not aligned with in
    drivers
    - Add an example for pcie-ep

 .../bindings/pci/fsl,layerscape-pcie-ep.yaml  | 110 +++++++++++
 .../bindings/pci/fsl,layerscape-pcie.yaml     | 182 ++++++++++++++++++
 .../bindings/pci/layerscape-pci.txt           |  79 --------
 3 files changed, 292 insertions(+), 79 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/layerscape-pci.txt

diff --git a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
new file mode 100644
index 0000000000000..b384a0b2fe22e
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
@@ -0,0 +1,110 @@
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
+    items:
+      - enum:
+          - fsl,ls2088a-pcie-ep
+          - fsl,ls1088a-pcie-ep
+          - fsl,ls1046a-pcie-ep
+          - fsl,ls1028a-pcie-ep
+          - fsl,lx2160ar2-pcie-ep
+      - const: fsl,ls-pcie-ep
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
+    oneOf:
+      - anyOf:
+          - const: pme
+          - const: aer
+      - const: intr
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
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
+        compatible = "fsl,ls1028a-pcie-ep", "fsl,ls-pcie-ep";
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
index 0000000000000..988929729580a
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
@@ -0,0 +1,182 @@
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
+    maxItems: 3
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 3
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
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,lx2160a-pcie
+    then:
+      properties:
+        interrupts:
+          maxItems: 2
+        interrupt-names:
+          items:
+            - const: pme
+            - const: aer
+            - const: intr
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
+            - fsl,ls1021a-pcie
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


