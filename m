Return-Path: <linux-pci+bounces-4201-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D66086B7D1
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 20:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10B6B1F26F07
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 19:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429D374422;
	Wed, 28 Feb 2024 19:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pcENeWjf"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2077.outbound.protection.outlook.com [40.107.8.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AD674409;
	Wed, 28 Feb 2024 19:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709147025; cv=fail; b=AJ/xM6dLS/difKDz4JRbvZNb0qMx40gl5hWlqObjPRIze8NAwzNR5X7Ctz8KCK049FnSahB1rsEN+yM1CcTucOyWTkZnpSOSZsdkTtj2BbSZK3LSTjS9aij8yNp2Q7JJ0xeRHNC7wCIQo6FV4br/PCfkkd/2o7l2fH48GUo2JdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709147025; c=relaxed/simple;
	bh=qz5oL39Brj8220nsvS24/MzLmuiiqWkDQlYmL4J5yKw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F/xTWHc2Lar2w/ZNrPcqOSQqRw9iqZ5eo6ZC7Uxuc/aUMnqFb9eVt94kNs31P021fAb0yP61zCaNEfY7JZPDAl4G9IUZOsu7FPsVVjZPrSSm75t40eWj6gJSJP6RVEdmKWSE6EfeRLVoyhw8O4vVa+hXIstG7Py+pMDo9gtKM0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=pcENeWjf; arc=fail smtp.client-ip=40.107.8.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MvYse7YRxeau7y4reVutOo3sIX5WCoOdpEbcvDgoZlQV2486y6GGeE4vPtfIQhPOi6aP/wUEsORrvqysbfmQ7N2QupZAsNVdiw7LKORVpuHEMiYJLrAFQiSdjZZUvo6KYkx3kgPFHQWdO4Ei4PZ7N/CKiFgXnJlroagj5nIbp36AWuXxgxps4GEBYtPeb6WwIL2FQ6TP7IsTQikoyITG4NRa7K/Sng7G1nnyonoJ5C9AxTEaIZCeBZ8BRrI1Dwegv3trC14Hl68b1xnLsC9bLZZn7wa2opHVgKgHRscinuf25dN6AqT+aYD+bDELERGCZIIMXjm2OFwIarYv76wIjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gXu4WunQQmY3l+sAajF7oNDBik3Y3QGkhgj6iXliE88=;
 b=U8seNdzrnIUBGugputhjDKrmSSnG1cKH0+73cOGVzDSunGiABzWPhDWFxaNDur5b67CWuQwhY+AnZqi3BM71mgux0ipjoi738lctekIrD+A/uHg90/IwKUYTn2oHL3YsdOY3gW6SZtMkXHk61o2tU0TB9JcL8GJesEf9pk3VXJ/vf+GHXVLJkN8CKuhnw16KCA8jIRmb7SswnutZn39dETp0vCYI45tIXCcP7OiXDSCeRtYv6G/DlrvXo7nvi18eSX1KJl8YIbg/HmPm9rD2VBsYr8O5g50+kmES9BmKdsa52LU9LG5qJIVyGTe1i1SWVsJnVlIqhA5i6RERYwUpKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXu4WunQQmY3l+sAajF7oNDBik3Y3QGkhgj6iXliE88=;
 b=pcENeWjfuO4p0u0pvzXhPvBYaGK111/OFZ1cfOEZRjfBqnJb4Cea9n6Pdn9iK8lRu2gCY/+sQ8Zk78RSsx+s3HEsoZ0RN8bhsCbbDh92wGOJJ8MKyL2cRbVT5knDhaF1T9XLUiZ/j+5SDNRKi05iLiuxIFFb0ufVmlmy1AdNVBw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8370.eurprd04.prod.outlook.com (2603:10a6:20b:3b1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 19:03:41 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Wed, 28 Feb 2024
 19:03:41 +0000
From: Frank Li <Frank.Li@nxp.com>
To: helgaas@kernel.org
Cc: Frank.Li@nxp.com,
	bhelgaas@google.com,
	conor+dt@kernel.org,
	conor@kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	krzysztof.kozlowski+dt@linaro.org,
	kw@linux.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lpieralisi@kernel.org,
	robh@kernel.org
Subject: [PATCH v5 1/5] dt-bindings: pci: layerscape-pci: Convert to yaml format
Date: Wed, 28 Feb 2024 14:03:17 -0500
Message-Id: <20240228190321.580846-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228190321.580846-1-Frank.Li@nxp.com>
References: <20240228190321.580846-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0165.namprd05.prod.outlook.com
 (2603:10b6:a03:339::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8370:EE_
X-MS-Office365-Filtering-Correlation-Id: 62ca58df-03ea-43e4-2898-08dc388ffa63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	h5WkSju89i0TE+w8mwWLItBwU2TrxEJbQVL/pnl2JZ21pEyRf/bbpMXH64nbyMbOMwlxmU7hNVoFHX96qPecnRpBPzC/ChOrwl7N/tkoJ7FH6KaS92uo2KaTFnWa5dqaXNBaxd6km7CJAjibcCPdH2SAqW6Nwu+fYLQu/MBV8m94s9b3Sg+AN2gJOETPmgGgnAt5NHCwfpyAIoFwdFYjbFgOl5EUAi6BeBFXOrfZtrg3O3v75eMz09NjMSQ8Xg2364KUilDptaPlEDikxMS6y48gFCXzOff0W5yFWl/I87z6UozMNng3WKK430v0KBLRYUSwZhvHXnM86VHXOayUxAB1O7vBIFEAvrd7eMZjAd/CcYr47tF1fhY4aGsD3/nxIR9ZE0TfXrTnMQJvzyjzVHUnkx+h47zDi1K6WG43Dpaw6UsM2RgdGAMV2+1cvmHqPuudBOcjZPTQoMYy4NgZYwLqB6pBBoprogS+iyPyDPp974z5tlgZhAaYVre6ybloCbRhVzLePeff5HActMfFskHac0jcRK9wl2DmD0RGCPFoolsIwdDcmBtf2ltuE3nbHOzE+xw/DhXLl5DzDT4usFWOFfct/5unZ7W5k/MMH3WEXWdY+gXlSzZjM/A10dWJAcx/vsQqaCBqe29whKeGuNMg/4BiRSHPPhzO2UKKGmrP81raorr6OakektHU8b1oW0Utm81zT8wb2misQhdBkQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jR0NnH16DIpTbC2h3BbxuP0Yh6jFY544KYS0cWNEB0SFpR82bajb3WjgdINb?=
 =?us-ascii?Q?I4jJiqO5MN/uaEfmX3lVAkU0jvvY0QkU07IPWhlhDjcNPXWpxPi0hUeLcLhV?=
 =?us-ascii?Q?82bXXUkgihy7HDHsPtg1zE5kiw5Ecxo0GjOljlRQ/S3sS9gHYmRLsPYkY8Vq?=
 =?us-ascii?Q?+1YLwJeEjtYGqdIO9shbJbl8FXfV0WI47KcW+LH9Etha9hw2laQ1bvbES+ml?=
 =?us-ascii?Q?8+UoAJadfNMml+PIeroerXL+u+0zTvIPuwaex0xFOCBw3S0mhS1WrXwGd4s5?=
 =?us-ascii?Q?aqZK4pfish7yIAu6xYIAIXekFMPViVoRdITRLT4IHpruG6rgy9Pb5UVKepam?=
 =?us-ascii?Q?mZQOxMsSgyD9h/zE9qyZSUYtC4AaJEW9zuzsSRdnvmT4Z3gCoy3hNPzwe6iU?=
 =?us-ascii?Q?wbGbaJ125f1Ls+p9nIYCoo9CZTrYoewdnwWXZ7GLcMrIGCnvCiVC/mnLaEvN?=
 =?us-ascii?Q?2aormozL7Y9g/1i+5NnAAPZYXPS750M75itaEEEmwss6xoK/LkESVfq2rUqb?=
 =?us-ascii?Q?PzfgLbpBM+bEZL0983yVpsl47vRXvHvNSIwBJKKbtS0jA5ro7Hh4k187U+2E?=
 =?us-ascii?Q?Q7R9RFKWRpnB5EVI7d0Bg3z2Tp14BwNevI1aLti/ZHoIGtL29ox9UjANhnOT?=
 =?us-ascii?Q?+HP3kD/wJO31CsPMMPUSonKPgQOidqZAj69CTFwaT9sp8GVXwW0tb24u4vKE?=
 =?us-ascii?Q?vc1UBVnm3fmXInK1IrYVcLMnLDl39PhrXOgMoHV0xRRoBGt8zXpHRZGmhxvQ?=
 =?us-ascii?Q?NL2Q6TWHi2cV8q0OdBOve/jYOEEABI1vRGHRCVqf6XTJfAOaBwNF7RHysObn?=
 =?us-ascii?Q?R74VM3sM+XyOWjiQFUPV9I4E8TmaqYfoQ2dhPLHoWi9UX0RGzybWS3vJ0V16?=
 =?us-ascii?Q?EQ1YB1xTmcXykETBZmJhd2YIHzAc54zEUN/CIRlKq7LYyI3XFvpAgjgVvdmS?=
 =?us-ascii?Q?8zaLMtqbgPmc3heNCtrmOKq1klHk9KajPRSYGuvKV0aESF6Tza/7O9bK2IAA?=
 =?us-ascii?Q?25RL/91C/0UkCb0XLLP1hxVyEMJfH9PCDUQ+BTj1fL4dvC8Yt2YMZ6dj+LRt?=
 =?us-ascii?Q?IUc98N1BCPWaw5znzzRxJ+wKq+zy5rpqeyDBrB+b44HS109Ire2kNrfIndaV?=
 =?us-ascii?Q?uczjcix6YpSm6Pb8+3HqIdALQ+tIFnlsHu/2nrG6e2e4q1puH4CG0oUWpJN5?=
 =?us-ascii?Q?H1Wn72f+j9axpemgxrXf/ENDu981JoO5/uZPWi9qjcmaMuZK4mLSzLzw4DGN?=
 =?us-ascii?Q?pZMWmHHLYVaeluolWGH5/8vbtH7EpgzL1BonfmK2sBR9Gg3GXvh8GLtcWABL?=
 =?us-ascii?Q?x7abCk8G8TbOWnA5ggwxkPz3uyNwzPtfLOYvIuVFeQ/YIGn8Wmgwv/kDhqhc?=
 =?us-ascii?Q?a5CktoHa52/qbh7M20dlS9GUQc39I7+LAuLdyXpNFHnV5TJaO/H9GEuFMo8p?=
 =?us-ascii?Q?cECcpP5baNTlETB89qxeuQeplL8EcUfUPtCm+R/7EmUtdFNCwVUzIsvpwZLG?=
 =?us-ascii?Q?6NZtnNzZPHRzALg/4xiT9gGwRMexO5AwOeqxhjR83Egh72gxkryBTcxGYdFs?=
 =?us-ascii?Q?49aRoGi7gnfd2mZ9GtdqTpZoypHkN2b9lFhLdLi7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62ca58df-03ea-43e4-2898-08dc388ffa63
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 19:03:41.5227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mj4yXfgDh6uvhc0ixtQdjnYzZiH1/mfBaOQi9QNp2UDpgeDRRL4zx96L3JNAaRLRv3awO/mVTpUdemBkc2zraw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8370

Split layerscape-pci.txt into two yaml files: fsl,layerscape-pcie-ep.yaml
and fsl,layerscape-pcie.yaml.
yaml files contain the same content as the original txt file.

The subsequent commit will fix DTB_CHECK failure.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../bindings/pci/fsl,layerscape-pcie-ep.yaml  |  89 +++++++++++++
 .../bindings/pci/fsl,layerscape-pcie.yaml     | 123 ++++++++++++++++++
 .../bindings/pci/layerscape-pci.txt           |  79 -----------
 3 files changed, 212 insertions(+), 79 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/layerscape-pci.txt

diff --git a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
new file mode 100644
index 0000000000000..0af70a4bc5d91
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
@@ -0,0 +1,89 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/fsl,layerscape-pcie-ep.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale Layerscape PCIe Root Complex(RC) controller
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+description:
+  This PCIe RC controller is based on the Synopsys DesignWare PCIe IP
+  and thus inherits all the common properties defined in snps,dw-pcie.yaml.
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
+          - fsl,ls1028a-pcie-ep
+          - fsl,ls2046a-pcie-ep
+          - fsl,ls2088a-pcie-ep
+          - fsl,ls1046a-pcie-ep
+          - fsl,ls1043a-pcie-ep
+          - fsl,ls1012a-pcie-ep
+          - fsl,lx2160ar2-pcie-ep
+      - const: fsl,ls-pcie-ep
+
+  reg:
+    description: base addresses and lengths of the PCIe controller register blocks.
+
+  interrupts:
+    description: A list of interrupt outputs of the controller. Must contain an
+      entry for each entry in the interrupt-names property.
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 3
+    description: It could include the following entries.
+    items:
+      oneOf:
+        - description:
+            Used for interrupt line which reports AER events when
+            non MSI/MSI-X/INTx mode is used.
+          const: aer
+        - description:
+            Used for interrupt line which reports PME events when
+            non MSI/MSI-X/INTx mode is used.
+          const: pme
+        - description:
+            Used for SoCs(like ls2080a, lx2160a, ls2080a, ls2088a, ls1088a)
+            which has a single interrupt line for miscellaneous controller
+            events(could include AER and PME events).
+          const: intr
+
+  fsl,pcie-scfg:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Must include two entries.
+      The first entry must be a link to the SCFG device node
+      The second entry is the physical PCIe controller index starting from '0'.
+      This is used to get SCFG PEXN registers
+
+  dma-coherent:
+    description: Indicates that the hardware IP block can ensure the coherency
+      of the data transferred from/to the IP block. This can avoid the software
+      cache flush/invalid actions, and improve the performance significantly
+
+  big-endian:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: If the PEX_LUT and PF register block is in big-endian, specify
+      this property.
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupt-names
+  - fsl,pcie-scfg
+  - dma-coherence
+
diff --git a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
new file mode 100644
index 0000000000000..c37578fde8bb1
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
@@ -0,0 +1,123 @@
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
+  and thus inherits all the common properties defined in snps,dw-pcie.yaml.
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
+    description: base addresses and lengths of the PCIe controller register blocks.
+
+  interrupts:
+    description: A list of interrupt outputs of the controller. Must contain an
+      entry for each entry in the interrupt-names property.
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 3
+    description: It could include the following entries.
+    items:
+      oneOf:
+        - description:
+            Used for interrupt line which reports AER events when
+            non MSI/MSI-X/INTx mode is used.
+          const: aer
+        - description:
+            Used for interrupt line which reports PME events when
+            non MSI/MSI-X/INTx mode is used.
+          const: pme
+        - description:
+            Used for SoCs(like ls2080a, lx2160a, ls2080a, ls2088a, ls1088a)
+            which has a single interrupt line for miscellaneous controller
+            events(could include AER and PME events).
+          const: intr
+
+  fsl,pcie-scfg:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Must include two entries.
+      The first entry must be a link to the SCFG device node
+      The second entry is the physical PCIe controller index starting from '0'.
+      This is used to get SCFG PEXN registers
+
+  dma-coherent:
+    description: Indicates that the hardware IP block can ensure the coherency
+      of the data transferred from/to the IP block. This can avoid the software
+      cache flush/invalid actions, and improve the performance significantly
+
+  big-endian:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: If the PEX_LUT and PF register block is in big-endian, specify
+      this property.
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupt-names
+  - fsl,pcie-scfg
+  - dma-coherence
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


