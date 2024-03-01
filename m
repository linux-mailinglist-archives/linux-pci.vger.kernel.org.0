Return-Path: <linux-pci+bounces-4333-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0BA86E58C
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 17:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE5DAB2599B
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 16:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF6371B3B;
	Fri,  1 Mar 2024 16:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="tBCg7OJS"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2080.outbound.protection.outlook.com [40.107.22.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03DC71B37;
	Fri,  1 Mar 2024 16:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709310485; cv=fail; b=rUsoAeFcnzwF0fePOJWVHitnx1/fy0/IGcdUmEDPhAg4dbZsi9/fPgSnh8trbLuX0VDVMZrSVPN7LzFlXp9NRsBQMl6q7+SKlmImskxn7t8VyGbX/PGqF3+Is2V7j4DErpbeLcMTyeUkmi6FFhUPaFpSQN/9f21j/Y0OFfzrCQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709310485; c=relaxed/simple;
	bh=n9PX0exAcFPgv4M3SJUVcTbcv4Vp9cKArMcyaF15qI0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XFIw5Adgw0XoPQPiuWPTBz8sctSy0eFWN1QQSfcfD7zDn/B82BjCKt6QzbYyW7limrqrmG+AbsfFH5COFp4x+6cdVJ2jEM53OkcVWD27Z0fcmBw7+EXtGoafbHeFNwnc98Eo0YcgiZgQ+l3lwirvXQlZuILNEBLumdJSUk/eWWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=tBCg7OJS; arc=fail smtp.client-ip=40.107.22.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZXPdMqXHsmHxPwh8I3sgCE6QkZ6He5VjTDGnX690yTmFhWzobE864fLZd082TThhvEm/q4lgewfxzktf2PYSbv3VcSIPW+uRw5yYFRQfSn5ouOI89oxO1F2zz27T2HueJcJEdbLe1zpkUvEq7zzd5qNJi9vezn++zmqlXpPXG2sFmAEsX3Ki6/uN3MfspO1O2f7JzGnVZc10oj7GkJLuUN0MWcfl13PHdSbQcsP2xcR7m8Y8td18cdj56uiLtAjAv0Rnh5dU3Z494jlpWvpH+xHzVuhgzvU87UBkrdq1HyDjYgsxuQSiJbY4CRdxNMEh1JsCSRGnarK/VvWufyu8vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d06mD+zjvnQCBS+xOGGovGmGQbau5qKpn2v3TQx+kXw=;
 b=DiCmq+crS1QxbPmOPMTBT8yqvTBDnVGiVaYGdhm+bWrD3ktlMq5jLotE3fAj/ZkZ6ZUU5pICl4JkKa/xkVwQ6/sgvpkv9bI+jORcNkGFd0y97bSVpaaD6NIh5RPAAHRqJw0XpatNtikdUsBuCVvjujoAKgHSwCbo/GomBxQ8Ugy1/h/ZKnRMdx3fB1wwetpEn5xs3dHaYLFH/9V1r5CPyuad3jjJvUQVYysX4cGjCmrvcbbTuLqVhQCJVX9QtPU+ziNi03ZA+c6ocskJCIXhbhTx4t3ZGl6yHzEGBXAqkgomxtelvhaTwt+QtJOblLEITQU9VaAYw8Tht00j0eAUyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d06mD+zjvnQCBS+xOGGovGmGQbau5qKpn2v3TQx+kXw=;
 b=tBCg7OJSt5dtU0HyLZxGZ0d3bsd9ilLlRz7hqiJtwSwzDNaYJ9pHM/LQeXInih7jnsRkCiabPZXpzyoiLJ2SEnDtLkd5YPTLcswvLWnQo35NmIKtossiwqyAwN0jBnCWIo0SJNsu8HdVotY14dqUtwROT4ZIG5BnwDg0QKryLA0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DUZPR04MB9846.eurprd04.prod.outlook.com (2603:10a6:10:4db::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Fri, 1 Mar
 2024 16:28:01 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Fri, 1 Mar 2024
 16:28:01 +0000
From: Frank Li <Frank.Li@nxp.com>
To: conor@kernel.org
Cc: Frank.Li@nxp.com,
	bhelgaas@google.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	helgaas@kernel.org,
	imx@lists.linux.dev,
	krzysztof.kozlowski+dt@linaro.org,
	kw@linux.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lpieralisi@kernel.org,
	robh@kernel.org
Subject: [PATCH v6 1/3] dt-bindings: pci: layerscape-pci: Convert to yaml format
Date: Fri,  1 Mar 2024 11:27:39 -0500
Message-Id: <20240301162741.765524-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301162741.765524-1-Frank.Li@nxp.com>
References: <20240301162741.765524-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0388.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DUZPR04MB9846:EE_
X-MS-Office365-Filtering-Correlation-Id: db3c0037-76dc-4970-121f-08dc3a0c9007
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8VF/ydubGTjGLE5efe97MKZGUc9WSJVehqMKYvt1Ha0SkH7zxNGPYAoDMLhg49yU1DmlfFZFlpNWdWrajXHhsZzz76n3GsqQed2+LTtVMcl/dSdTCwXmvRsaSXKIBtob6Zan7HitSYCdspOa6jwlJVj8uWxTkZh12NrO7NBQ51ERdTupp2UIt+BfLceZCED3KmrYvg3lvQqGFAuu4vxqkxMQCt/CNIj4E/ztFOFsRjpY4K8eIOFe4Ux3Elp82TnH1oSe/jyiYZzytnb+6V+Nv44jyILSZlIG3Om0iy7Zql3xRkyf2sAbrrpwE1Z55G21CEX0Xei/pRuYRkxvIb7+RpyOKyfF3E7x9tbIRdbKilZpX+jQ8RzuG5oU72HFxEHNWGrzOCD322WJG25YCFkzbkePpKQsqiJ6yy+nAn+4Y218Zlln2PdfAdbDBqEiDDvM48x9Sh1Ed8w/BvqXpDn9Ls+lVx+Vbh89V7nCyPIJ+fHlKPCvNER0rri3YwIBy5AdvBoFO5BSha8sHXxkON1zidfIxEqao76TlrtWsOTE/HIl788EDWdG43DZsnpTMnV6UgoGvDmlEUTV674xe+Ltncfoi2hPF2lNk/kOmTlQpqBxuRGuf5f/TVZ/KusEsBB7d4ObZ0k5NzCjto1tZF4IbQyLpu8fHwbZ9Rk6im/pW6w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1Py1zFAjxqk07+p0nj1oRP/JOeDGsqWbrjl+xU0+qz+rlfOja8NPqGWr/Ffo?=
 =?us-ascii?Q?+SB9G63hCeCSCEK5uvlw7GDPwr7enavZSqqK8UCqlKVyTbzOypC5zeGkw2Tk?=
 =?us-ascii?Q?mynFNwrav5EafvcSz9qV14DsIy5SXa43KLOfaTPUvyRUvJgy26yx8GLqqdJN?=
 =?us-ascii?Q?getJa7GnU45XuBhXQ05RbaHJmRcdAC/pkmwF/Nm9Ozo8vcuW4LQn2aMenHGD?=
 =?us-ascii?Q?1vCsCDDih1O0m/MNVYlexw0AnStbZ6K1aR54VzZAX5QTeRdaEV0TaLFzme4m?=
 =?us-ascii?Q?Lb0icstJbJ6eSsSKRIKVFazCpVpcpgN42bdx4TkigWfDt/YRxAhY29PE8rfQ?=
 =?us-ascii?Q?5M04oIiPkHiy+a4kU4eHkDjZD3tQjbWioiJMRFdaeXdqqTsHuIeA4MlLMJmk?=
 =?us-ascii?Q?WU5DW0zVQaa6wygVse873s252C9kBVFHR1+7OlvY3qyNzPo3829JbHwqyZeT?=
 =?us-ascii?Q?yYuyGEMR/iZl4FH5fQYfUNXU54PwmHyIZfszGMGU8vPmt+BMdxzMKdq7cz0q?=
 =?us-ascii?Q?CnkyzH4pptNN3z9iPrFIgZCrd/RO3o6Ym4np01iH8UxUuRZsjAMn3CblKiHx?=
 =?us-ascii?Q?oovOEnB3Yp73W7CYKuutJwiLD29OE5/QcQ0Cch1XDcoTKFRa9D3KGI9lmWo+?=
 =?us-ascii?Q?x7a3m03pc6LVB20oINhKtIUDkdCQLRtufrlio03pcdCD9IvbUI34jNlbQ6hg?=
 =?us-ascii?Q?wkRXhzyetEaU0esY1oC9Yk9gMPk/rh0aaVo8DG/uulmyNQt97Pb6D2QHqLp/?=
 =?us-ascii?Q?h3lRIKoc6Jm5bFXowngTQjnt8hwyDYTF9yUGpU77N74erH3zxjyJjfd2D1xl?=
 =?us-ascii?Q?2MLVy3ukYDgKhYnVtMJwABpGyUdFvAmTvIhIiaYnPIZqs507yVti4v6kjWuV?=
 =?us-ascii?Q?OgY+/nwiF1ahwEzCtyjZ1HPCqjKNLP38/J0TtrYbhn2LELN+uGrjb+WlPDgL?=
 =?us-ascii?Q?ohDcbYQa4Jp7W3QjS7HBO++69GdUY9w2kglz/+BXEnXQ9EiRd1Y2JUnK15h/?=
 =?us-ascii?Q?xPFwytTEplV5MmoBKk1pZibE0UJa21vACqe9sqK/6kDETGO0+OgWaggCldJs?=
 =?us-ascii?Q?hMwV2bP8aDl9sk5WvpxxEFj5U2q23XPPLAX0vSDJ1qOROWkzjrlI5WM8RxPn?=
 =?us-ascii?Q?dgHRZpzbWQ813bAnmfgYbSonBaoRSuoa3Qr2CImJNYN5whvxNivHTajmW5Fs?=
 =?us-ascii?Q?cC+/Vk0rD5GHuo73GeLiyhGUIxpAuHeuOct4brly1FU48GTA2iP5hd1jZd9Y?=
 =?us-ascii?Q?ZV2nx/esoRG06GnHw4IbaSWKbj2J4EQ/E0oGjFYo7lKOKZzguygbgZ+Md5nZ?=
 =?us-ascii?Q?ac2FLbaFFV+KMLassUr0zhSF58m2IJJhWl0isg4AL+8Zrmz4h4atG6viwT+f?=
 =?us-ascii?Q?P+vmEYzWkgvYgBUC7e2nbuE/OTGnMX+MV1YXV/ztHB64Nb0OjBqXtH32s9BR?=
 =?us-ascii?Q?g0nYPZD8seXEN6dP7FI5erkKQjazjud6ZiEWFWIl9Qu7U9cAcRz+cSeGAHNL?=
 =?us-ascii?Q?dCLYxXxJcVNbTDCFmOVVZvGDPzNtgun2dj+d5dNiBpqIYPIqr1EgW0dniGi4?=
 =?us-ascii?Q?qMZlIEJASzPxjhIJuYrSPE1qKKAltasqgFFhnkbu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db3c0037-76dc-4970-121f-08dc3a0c9007
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 16:28:01.3478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KnvtR1oCXA4HMYvRdnteJ+fQ4iFYIyYRVdnojlTfaP1iCu6ALugTPLS8ZsL2KeGl1EG5Y1aiKOO6qjKQolhtDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9846

Split layerscape-pci.txt into two yaml files: fsl,layerscape-pcie-ep.yaml
and fsl,layerscape-pcie.yaml.
yaml files contain the same content as the original txt file.

Do below changes to pass dtb_binding check:
- Remove dma-coherent and fsl,pcie-scfg because not every SOC need it.
- Set unevaluatedProperties to true in fsl,layerscape-pcie.yaml.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../bindings/pci/fsl,layerscape-pcie-ep.yaml  |  87 +++++++++++++
 .../bindings/pci/fsl,layerscape-pcie.yaml     | 121 ++++++++++++++++++
 .../bindings/pci/layerscape-pci.txt           |  79 ------------
 3 files changed, 208 insertions(+), 79 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/layerscape-pci.txt

diff --git a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
new file mode 100644
index 0000000000000..cf517e4e46a33
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
@@ -0,0 +1,87 @@
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
+
diff --git a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
new file mode 100644
index 0000000000000..3f2d058701d22
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
@@ -0,0 +1,121 @@
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
+unevaluatedProperties: true
+
+required:
+  - compatible
+  - reg
+  - interrupt-names
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


