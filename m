Return-Path: <linux-pci+bounces-3183-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A0284C4F0
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 07:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E09BC1C243DA
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 06:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91451BF2F;
	Wed,  7 Feb 2024 06:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="peLzen/b"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2078.outbound.protection.outlook.com [40.107.13.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FAA1CF87;
	Wed,  7 Feb 2024 06:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707287070; cv=fail; b=C86VKobNHP4XgeHeOXDGJ2MUhMcWfcHdaa2ZbTU2dPrZ1IdxOp7P4g3xuBKq6RJJlvcUakrTmM2XbfAcDk/heWYtizsovLlSfyltZUzNDj13N7vl8a5WriLJMWqGuOiwu+xb+8f1w/gtciwUK5FCJKS+Sc8z8VyDQjZNF+p/x6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707287070; c=relaxed/simple;
	bh=2hOWvUgOfbO+GtoFYixeUKdBDgmY0G6lX/h4IEa2R4k=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=QewJ3hx3F22jQiNVWopNOy8RVfA/m0RMT1EFXJ/3SCrT8LMfvLivKqDTAskE0HLAeRFuqRNKAVoONzRjLuG0zk2yInJGnE56Ci5Qf2jAkxAs3Rgj3epPO7T9+FKwBiMUnlS/1XYbXTITyt2F1rNa9R5i76ecvkcCnQPO+MUutf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=peLzen/b; arc=fail smtp.client-ip=40.107.13.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HV2SNveeVlYEaSxWb1eF/+FJ9oAx2O9j45C67+lB6MH8HgwUKycTapmLc90Be2NUmeOFBuJxzk+w92F4UmAUlHLfAixVpuWuavjEjV9Z+m6PmVpTvwaOGg3U5UPz3mmBmcqylIHkRWcMfcrwzeYRr/zQFLyA7J9vLjZ+XDWGMJ8NdqQEa9tV0ZsMA/F50rrmJHuiAFW6HRfu6cQQgeMVyLHgeUoYM/7O7kml0DNyUG/K/cvbZS1tcSfCY3a9+2PjGf6W/BfvOFUzRxIOYWqpr/bvrCdtf7twKfM43k+RFMgsG2hTBw+VSZQjfpZWG6IN7a6BnL39aTh1RTTznlW1KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9J+uDlQ71IlsL2ROCGPQx7s3FHMxqFolgrVvkpWpz2Q=;
 b=F4K8HHae3clESnPi3MWFihUQE1V1neP79O4VYvLtkZCQy18MykfRT5KfD5Og05Ls1i37BkRYezuXP3hgSrOVQZn056cCVNT/dnQoW9riuDFlZvnuiz+yATPs6YT08huqKA7wAxqSH+NOz+ZSsDzBRDwsf/Q3Lan766REJlh6XDCHuTnEGKa7XcYSJdcgdoExEAC6BrbY4ZsCinIHMgyDvru4JNM8DiMGEnpqMCQXJbDHNxnR9DAlm7rYtzz5Yr3KIgek5lG3ospRx3tPaxMZczqFcHX/eIVMumhKYaw7rwvmy2IaZOY2INT0/XDY4iZ851rqA4BuVsm+MN22k43Ulw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9J+uDlQ71IlsL2ROCGPQx7s3FHMxqFolgrVvkpWpz2Q=;
 b=peLzen/bSYOSSkjkjTVYet+hczHHqSpTfucyEJqaHkUOcRYp1iR8162ML3Y/H+7zUrBTq8EZ3RmJb8fVW8jLtxVj60F6lKFIQqYmoD/dIGCarAqwuwBY3GlQxLSmts3ZXVyBqAZf2/I3ugQdvuKt5nYI0ju1c5qZq96H4VEtcyo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8895.eurprd04.prod.outlook.com (2603:10a6:102:20e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Wed, 7 Feb
 2024 06:24:24 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.035; Wed, 7 Feb 2024
 06:24:24 +0000
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
Subject: [PATCH 1/1] dt-bindings: pci: layerscape-pci: Convert to yaml file
Date: Wed,  7 Feb 2024 01:24:02 -0500
Message-Id: <20240207062403.304367-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0128.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::13) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8895:EE_
X-MS-Office365-Filtering-Correlation-Id: f43310ae-ca4d-475f-76d4-08dc27a56d96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	af1UuzzFBAOYwKjPXAwHvR3sp5sbZWtRwpIRXg565HF7vODvAzahNqakla3OnShoMVGLyLS6Y7sh/m9IwZEYEtUmhDffxDlAF3AAdS8k2g301QJQNsnG5p60uJZ4zxhV2XxHqu7Dxsfj1jifnnkN6KwWrGTf+4AhnUtVa3X/qWnwtg42QBD8sblFjxM1voorEUAs32YaB9j2Dud2Gp0/+HAB/NdIsfjFAVUaFSzVxrHUVMuYKZxP4yHOBWsVU838WQtqCRnW/Z6TurRK11I2j0dSFT3tVYU9S1OJlcm4LLYQMjqlLdOIoSUIzHGmiSETHeDgWIC4AhPO2oFvgom2VIBQFqyUeh66Qphbc8ggn3f/V2Xu91VrjdyZ4MeNawEW8lNofxT6noY59YpUpCl8wr/mvRhQDx7u/bKjTjKZvf/8R1WTWyqnkIg9LsuhWdkmrkoOQTyzq+jHQqSDMPm303nPC2iVFtr1YdXBHerm/jqOY3NqY5hG/HfJaHDqdKbeBZbZey6MVmWKphjzxvqnLGp9t6Mj5HDBfut8ySvVnMWEEdQ7JLOIvqfcysoFomMslGdXat5HJk9D5Te5jNziP+a0kMBsXRYCk5tBPA7jvXU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(376002)(346002)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(83380400001)(2906002)(38100700002)(41300700001)(316002)(26005)(38350700005)(66556008)(66946007)(66476007)(110136005)(7416002)(30864003)(8676002)(86362001)(8936002)(4326008)(6506007)(52116002)(2616005)(6666004)(5660300002)(6512007)(1076003)(478600001)(6486002)(36756003)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oJ+MNXFm98LMxC7INJI27w5728vxdN+ATOI2YaDm7eKwJzky8+tH2D16/ira?=
 =?us-ascii?Q?TSwSPLWBTzocG6bQW4OCtSRpQC+Uw8chpftzouUk7Yo1RIhNaeECuGcgih04?=
 =?us-ascii?Q?sKSF7nWVAZl2Z0AvECmOJMY1pLsQGLiwvl0TCPtgxtxHVyHETwssFF2r8M+y?=
 =?us-ascii?Q?+VhjNtwxu63bWDfoOPnDSKvoT78O9dYzyQx0E8F1p1+rFOLfPAF0J8BaUB1Z?=
 =?us-ascii?Q?bcATnAyhvsdkGczgeQD/R42BSetq9VwAy9oESYp+y6jPpHOrxBRV4lsq0WDa?=
 =?us-ascii?Q?FV9K6uo/XKQXrSGVILr+AMns1HnWCZGbx9cJyPQ7i9lof7WKOfgUPuaiw1EZ?=
 =?us-ascii?Q?FwNy0t+EB8PB0nvzIled1gW+MSIbePy1HdgFZiIbbC2wbMcVqx4a3SQDo7qS?=
 =?us-ascii?Q?BOH8yGM9SFk5nnzDwkoqVOI6GLLtPjMb+nH5Pwkqp0czItK0TCmyon3Lm+LO?=
 =?us-ascii?Q?TvERTR3izQ48pHiERzTpsRnMb4zKOjR+CHYRe6+IcsJb9LLEnRrfvYZlDTK7?=
 =?us-ascii?Q?iMuexBXMrtl6ORbrFcy1FZzM4v1l9ul1MI+1vvr2UCLo8f9lu8EREqgz4p00?=
 =?us-ascii?Q?98T932o6EA+ZdJVJjGTAabN+S4DuIKdojSeejzNkK1FwERE5Q0ChW8/k3q+8?=
 =?us-ascii?Q?bCatgLQ0w6pLcVxAjBdkqMaixeihZClgNtoJSAcmERgULH0RmwP4cvZHmon8?=
 =?us-ascii?Q?zREqlxB65OQzBePuanLfhH1/q6Y1uHVpA/fe0ctvfM10JG8qseVk3n+AK5jQ?=
 =?us-ascii?Q?wRgt+P3CIrVY4cWw95bCzVn118R0uC1PpGlpWoy214rJOsedQpYX2sukOVMJ?=
 =?us-ascii?Q?Ku+Hm2wRVY+odtlyp7BPxga14LoSBBb8jIsxla72g2nqh//YA0q94Y3+TjCn?=
 =?us-ascii?Q?snU9GeNcEIo+jIOLzQwUxofwe9tDChe0v5uUl8JrK/EezmzzDfDNhn0e+nT8?=
 =?us-ascii?Q?ffZ9q24O/uF2mQRQhezvhvRCUy9dKE9zJM293hV0pssJFHaowHAJTv1HkJq9?=
 =?us-ascii?Q?UVnwDWuXQHoUHDM5klfsHQp962cpboRS3EIKwqq8G0Vx9ubYiYJkVvbQriBt?=
 =?us-ascii?Q?RBwbF/nLkaCrT/psm6U0VP2YbAIN7z8blmQOOlR8pmecySILB8l+092k0cLC?=
 =?us-ascii?Q?4N7YkoSnf3KnUvqgJ3Epu3VO2ot8ZyYP71ee2rdi2wIWC6AnCEL2WMS5HEFC?=
 =?us-ascii?Q?tUtJ/U7eidpxy3hE7doB7wqe8eoVERPMuyWiOHGg75JgfU/k6KLyqm5RZA92?=
 =?us-ascii?Q?45X2lFVsXeyINB0XDYWY6CPBBr1UUzrGoezuiuNnS85Qky2WvtJRGJmIVjVH?=
 =?us-ascii?Q?oxynr9QQ77nSrWH/qym4rnTO8Hx9kC/TkkdzNGd20N3IL4s+CnIcXBOpkqRc?=
 =?us-ascii?Q?5pT6JJ0uRtxYTKWdSPEzY7SUEl81gq8gSXN/smEPO0EAi5QA9DqH0hPrKcq5?=
 =?us-ascii?Q?+lH7zP+4ZJR+XED/U7MsDUdS/LS3UbAUb0ySl/iGDByACvfe5dzY6LAw9A1B?=
 =?us-ascii?Q?txkz7EgL1M1BaqosDW5xNnhKScpfwSlcOopBRB9qlTi4oS280JpaKhd/SqUm?=
 =?us-ascii?Q?fIjfwfPczYLUktfQ1CI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f43310ae-ca4d-475f-76d4-08dc27a56d96
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 06:24:24.4348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5In9dPYek0269yQ1VNglEyHXabeGV7Zds1wCU5B8iV8aLGEb4ZuONpUFpP+7NEExp+XQkt9HBsUdILj2uaDbkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8895

Convert layerscape pcie bind document to yaml file.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../bindings/pci/fsl,layerscape-pcie-ep.yaml  |  84 +++++++++
 .../bindings/pci/fsl,layerscape-pcie.yaml     | 163 ++++++++++++++++++
 .../bindings/pci/layerscape-pci.txt           |  79 ---------
 3 files changed, 247 insertions(+), 79 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/layerscape-pci.txt

diff --git a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
new file mode 100644
index 0000000000000..3b592c820eb4c
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
@@ -0,0 +1,84 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/fsl,layerscape-pcie-ep.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale Layerscape PCIe controller
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+description: |+
+  This PCIe endpoint controller is based on the Synopsys DesignWare PCIe IP
+  and thus inherits all the common properties defined in snps,dw-pcie-ep.yaml.
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
+  dma-coherent:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: Indicates that the hardware IP block can ensure the coherency
+      of the data transferred from/to the IP block. This can avoid the software
+      cache flush/invalid actions, and improve the performance significantly.
+
+  big-endian:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: If the PEX_LUT and PF register block is in big-endian, specify
+      this property.
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
+
+allOf:
+  - $ref: /schemas/pci/snps,dw-pcie-ep.yaml#
+
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
diff --git a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
new file mode 100644
index 0000000000000..e3719da306f25
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
@@ -0,0 +1,163 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/fsl,layerscape-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale Layerscape PCIe controller
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+description: |+
+  This PCIe host controller is based on the Synopsys DesignWare PCIe IP
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
+  dma-coherent:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: Indicates that the hardware IP block can ensure the coherency
+      of the data transferred from/to the IP block. This can avoid the software
+      cache flush/invalid actions, and improve the performance significantly.
+
+  big-endian:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: If the PEX_LUT and PF register block is in big-endian, specify
+      this property.
+
+  msi-parent: true
+
+  iommu-map: true
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


