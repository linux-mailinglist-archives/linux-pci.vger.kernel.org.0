Return-Path: <linux-pci+bounces-4054-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B2986818B
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 20:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B872B214FE
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 19:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412BB130AE4;
	Mon, 26 Feb 2024 19:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="r+kctEEA"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2084.outbound.protection.outlook.com [40.107.241.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CC312FF76;
	Mon, 26 Feb 2024 19:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708977454; cv=fail; b=CtxI0g3uSfpGGzt6oE5E+0NpZbvif+dZy2SPq5Hqxi76o7LGLyA6xJ+rqJMMSPV59AOdK1nKP9Ycm4HpyuRmVIoNrvHEQLs0QJulEOwoECWnwkyk3vLCjZOyk61bueM4sA7F8ms8Rt+RhHeZROp/t9zh6nDexi+hq0icKjvhlsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708977454; c=relaxed/simple;
	bh=POj9WB2QdSBbKwYzg0CjdGw1DM/8vmghN2llpTeCy08=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=VOX2d1ZWfwaFrWltB7Ak6f+UrGYKG9GLCAId7rkFtKrjJg5uUdbehNhQ0M1M3RfhYI9pTelv0FBLvVJuroeRXFhMcIx++FyNlV4n749UwYMPhcpVvYVx42zBLz5wlaB1CayGnGufjqGYNLaXHMMj362FpvIwYUjMoWElbQA07V0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=r+kctEEA; arc=fail smtp.client-ip=40.107.241.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OtPngpMgvdtj642cELYhtDHZ/Zn+TTkZbXBTRc43ZEFtUs0PlTI+mXyv3B/nZy6rq9FzZCxoVNwYd3lBwJiNm22YwsyIHBCCs2oOMiij7u7HF7G0bPDLmU7DvGCj64DDSYZN7g6ZQxhsgnugy4aCqj+Na9u24tAX1z+x2syJCQacIlyoWK4NxbVxKZSp9fKMFZhf4nzUr4Th64HdMX4IetfI1iQ4AxanYJmFyHGxGHZ8aZ/tazi5hpwmL5xSoIlBwXlJXIN8RXUESuHy//U70eTkrxfUwVgSk9XbnZFpJm+ck4dqzvReKeytn8GAOuECKGEoPKxEbdAw2bYgiHdJYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WEBTQ1JmLhq51B0Xn3AtPN/RfPfyhM0PaReuE2sCyrA=;
 b=Ghoor8Lp3+8BpugdJDlrxxJYpmOctG3d/qeQdB3Aquu2AuTNIXrEWYf+EtP336eA3aL6A+IXE/b3COr+o6sadt4Z3Kfv3QbA8VKojG7kD7rK+yEMED+aW7Fx+wpBt6Ve+AmS0PzFMUuqZCqR36jRvo4FH0Q6m3WsxyB85zrOyc5fL1su5OKaFTZ7KJM3etwd0BML1NPS/Qk8vZsyk0JY268zfWdQWYcYKHf7CsV2ZAAgfytEZA6ni5Gcz2HwvYQYe+elEwlfWGzYCxAHwl+40sU693lHM9m9JU7GjhthFYpoklPhMq1RZzoWWyHFDQqYSlGOBmawA70IJwZJJ2NgTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WEBTQ1JmLhq51B0Xn3AtPN/RfPfyhM0PaReuE2sCyrA=;
 b=r+kctEEAb+kTyaF5qvOgVyFt1+VyESwyyZIxVKBmZoAg5yv+s5YxnyqO8N0CcJT5MIddUlLF3XtwhQsyZnGf3bOPtqfeoxs5GlKsQzU+/SMcr6Y8WyWSat9kojMWBRv8N7cEqkKUVI1h3CUXUsmw68Ze1FgF82Gcqw+o6eMI+Wg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA2PR04MB10278.eurprd04.prod.outlook.com (2603:10a6:102:408::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Mon, 26 Feb
 2024 19:57:27 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.032; Mon, 26 Feb 2024
 19:57:27 +0000
From: Frank Li <Frank.Li@nxp.com>
To: conor@kernel.org
Cc: Frank.li@nxp.com,
	bhelgaas@google.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	krzysztof.kozlowski+dt@linaro.org,
	kw@linux.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lpieralisi@kernel.org,
	robh@kernel.org
Subject: [PATCH 1/1] dt-bindings: pci: layerscape-pci: Convert to yaml format
Date: Mon, 26 Feb 2024 14:57:11 -0500
Message-Id: <20240226195711.270153-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::24) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA2PR04MB10278:EE_
X-MS-Office365-Filtering-Correlation-Id: 853050d5-e5c7-4669-9508-08dc3705287e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4s9yN3oLotwM9JqdpazZySeDDqF3XQWz2Mbi/o+OUmgziZQnWPgxtExksKEPtYelG4ci1xkMh8mVAtLbR+06qXqeW50jQC6o1XbEdyCdienwP9DqapFoT4AmXpXKjVmSScT/kArEtcHbdYfzjQulC2mobCiy9E4auOLm9pojsM21iDoGpd3eR+OBrWwO0P29q9RGeRubKNx/7hibRCOlTjS8PAHK8WJi/1NVmCpBJY/uSjJUs/mzqJBTgeF0Z+1ze9BGLXkrshHE/mRXVDL897G+el1K6MevEbqQrgoTnqPe6pCgSJuFe93SvO3yXU5BAP7wuI817i/aGKzIlmgYUGpRcRulzh3nyGmBY+QWYtAnXon1B/Owsz4YpvA+b/H9DfeviO6K7SFJAigrh44Sgcaew5UOzH0DKku46iI96vU0DKLqnGkUoOfHuymjWyaZSPL+Jd5Ip6BOF7Y7WN8pkMTqWkL9ywFIrsfARHJ1f8dsf6IbMw9Uyv31kwTAQIz1qayd7TOJLWNmiHnqLthtRd3K+bRRlN2F2FbzcPoSrPNw4PiaIHIhXkMvs49TQjkRADLYBroUTMY/ncX3dhztvrYCJxLG6Uveh4eBmNli17Sywz9O+lWevemW7ze3EWuiVkjJepAVm8jrgEvQhYGkNPvrYxIjZevbTA9IJiF5FqvqG50b+sQZMKZ/zvdraT3i0iWPwWUsBOIMGFmNDQgKpg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X7P8hEza356TukcE0gvokV7hSCNwFJmOfGiWA/a+rnRWYQDwQGrFfgqcFuQr?=
 =?us-ascii?Q?G/QQ/ho0RBwTmWPPYrsNJHBTVOL+EQV9hNwLw4ntLwdTam/lZJblIY0Fl2CM?=
 =?us-ascii?Q?jv5AlxRg25ueWZ2MJBcB66iYAgBe3ZxQVm2wT3am+/638JO6VeClsLDT6Wuc?=
 =?us-ascii?Q?H2lzRtKNVHa+4UjB8KeMSiEa+9X2DPINLxjGvSa6q7qfGhBw9YwokLt3onnC?=
 =?us-ascii?Q?rSaPRJArbp1RtyM7oOmJpg914MFx+qeUdEEN/XvsvENx2ijghmTaqVD9nYAe?=
 =?us-ascii?Q?P5cK1CF7+gud1qjORXSFvN5QSPo40kRuF2ycPyD5YeTTWeg0pGWrUJfrJ5L5?=
 =?us-ascii?Q?EaoTYVj/1gQq0dmcqJB8R8wBLX9P3a6LTiZyqM9Aq5Ca1uy2/rbdO+cjcCnn?=
 =?us-ascii?Q?5Xt0GI22jTMgHXcqV1RfC0bQKcTKVaYNk6YILj8wtpqgVEszZ7CVHe6nPFNd?=
 =?us-ascii?Q?GV94jG2tiH3vRyiADuC1H8qIh26eiuRGKRb3wLr/Ra9wNPpmk5gD4t6g1R9i?=
 =?us-ascii?Q?zzldPKdxa7UzqOhCYZhzx46FfH3ejN7i/iFYCJn7rPsjy4iIxFzqWFa/PT7P?=
 =?us-ascii?Q?PumHSFj2X5rMa1yIJC2LKLo5x/+RMwYviQQ2VXS67xiDaeP9NarBO2yjLsJ6?=
 =?us-ascii?Q?uh6UC8JfJj4KFs7XJy0Tny/ZB62aQHtlgTOuqiF6aKQZQMwDB2SccvHjJYcN?=
 =?us-ascii?Q?d7/Lr9m1a526bQfR9HD+mzTjQjwvlFF5Lf+kf4jRU3vtP0huZRpNnkdtSppv?=
 =?us-ascii?Q?I7a9h59UWPPCAU5HBX80ldGmliPU8gFr0HD9yRt7UawMtzTX0Tlmp6QC9I15?=
 =?us-ascii?Q?X7H3TFoHB/tkBN+v6y4xSR65UQwOyuqCYAs6A9T4r8DFPog8pe9F0qMc3s5k?=
 =?us-ascii?Q?+uvvBUttf1bGk5cY2StDfb0jrIfmrn32YznAdk2Z8K9xkTrSCULoXJCVMWvR?=
 =?us-ascii?Q?JdglJE6kGv/tbIjB3OjCeNiq/Xi4EBiBpbXzNcwINtbnsmfmWpfYxNa6T+Nf?=
 =?us-ascii?Q?U0CeDKmdbI85vNZvJS5rdp3wwS5HxOw9QiF7VSgmtdVBu+cPbwgxD9xkd78t?=
 =?us-ascii?Q?rzsANMFbyY8wPmKAbNCsFdB3Nmluf581NJ9Ib1qdZtkXO2Tn2W30ozDR33XY?=
 =?us-ascii?Q?oaWkGj1Huw4Z0E6xjBgAosF8kXdY0U44JwHusn2nhEA4qwjjXmrcMKzK/npv?=
 =?us-ascii?Q?gSySQKrqGxsdPJgb+dP6X/VMgHVgcCiqh4beLoO9+tQ5cwhdGo2iLgydB+kv?=
 =?us-ascii?Q?YEnVYgfUyVtYKEHgGX/kZfIwJSwpOrkJnj0V6K5V/KnZM8yKlz8PxDsAvyjv?=
 =?us-ascii?Q?K4aS1dyZav+YYCMHCvJ1B0PS/mBzMrF73souOeQnJbfyci7NBoXMN8AipqMW?=
 =?us-ascii?Q?6QcOTHWwIHYqbP5jXcE4xU7FB4na+Wjtb8h/L2QGsxxy8hW6us2tBA51Ehjv?=
 =?us-ascii?Q?P8jBlQNAO3ZOVtPy7+C+/h57wtG4Kl87gddDwLSqpdeEIjrOdkdgXDgk+Rb/?=
 =?us-ascii?Q?LF1rgoUlN9oWPJG4XOfaPAuU2bjgG95vMn0pE+H51VEKO0j+IR+JvVjp8+Pk?=
 =?us-ascii?Q?A99VR2gESYEumM4jVIM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 853050d5-e5c7-4669-9508-08dc3705287e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 19:57:27.5325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NbsBRnCI/hb4s7etLoyGDKuEhx3BfWcl+qyRsEHOCKg8zZZLwLSyIzVQMCI6iYvCDZ9astLcvQUhUnMCmmBAPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10278

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
    
    Change from v3 to v4
    - remove ep label
    - remove status="disabled"
    - remove deprecated property
    - fixed irq max-numbers
    - because dts still use "reg" instead "dbi", to avoid dtb check warning,
    not referernece to snps,dwc-pcie yet.
    
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

 .../bindings/pci/fsl,layerscape-pcie-ep.yaml  | 107 +++++++++++
 .../bindings/pci/fsl,layerscape-pcie.yaml     | 175 ++++++++++++++++++
 .../bindings/pci/layerscape-pci.txt           |  79 --------
 3 files changed, 282 insertions(+), 79 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/layerscape-pci.txt

diff --git a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
new file mode 100644
index 0000000000000..c230446bbab1d
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
@@ -0,0 +1,107 @@
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
+      pcie-ep@3400000 {
+        compatible = "fsl,ls1028a-pcie-ep", "fsl,ls-pcie-ep";
+        reg = <0x00 0x03400000 0x0 0x00100000
+              0x80 0x00000000 0x8 0x00000000>;
+        reg-names = "regs", "addr_space";
+        interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>; /* PME interrupt */
+        interrupt-names = "pme";
+      };
+    };
+...
diff --git a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
new file mode 100644
index 0000000000000..a2bfdcf818eec
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
@@ -0,0 +1,175 @@
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
+          maxItems: 3
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


