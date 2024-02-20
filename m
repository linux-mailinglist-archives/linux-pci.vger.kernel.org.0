Return-Path: <linux-pci+bounces-3785-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC9685C134
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 17:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 062922829EC
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 16:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A8876C6C;
	Tue, 20 Feb 2024 16:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AcRJPtGs"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2078.outbound.protection.outlook.com [40.107.249.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3F57BAE8;
	Tue, 20 Feb 2024 16:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708446058; cv=fail; b=qEB91mAHmPzdiCf7GW+92AAcvaZxhE8YpW8dsZtgVyTyM57lbjN/PrfuYOU8Ixc3GOWhaIrh+Zv1UV3ojqQpeJpMyXyDal7keCduN1UNbvWUMB1aNaIVZ2YDcz0IEaFgmGHWkfl84kkmTHFDUpTSP7x/6lTJfEs6fmh0MNf6UoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708446058; c=relaxed/simple;
	bh=iFUxdRN3L2SpjQUZm4S3F5xYleOwOVtp+4PH2WmXswQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S8BQGO9dVCJBaKspV1u6uCl5iU2WvUZvMBGhaWRrrcwHek4e7rwM4h1dM25ngQ5h2fuNbA6VKIVO+iiyr7aNwN/CHsfhvpML4p3M/KyHblaF6HwIWOFnOTQojLUJ+rA7FkNeWx6Oo0skDzlG5A2PUMLag2VqHDl5Cfhosd7ln5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=AcRJPtGs; arc=fail smtp.client-ip=40.107.249.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMBKHeDCBBLb/tmfEKu23aJrPX7lIoDlf459H0FsShkWscMplX6pt3YgAji+udLW/+KYO/yeDC8uULXmp9N3lHKN72uN/JW2c/p7dYYOOq3dop63MIHP65PmwlnM/93/nz0I3QLy4KL6B7qWEqEarwKISw30nYGn3EHGAlKGKO7d2GKdAVmbQ8VTXAuJjFY96x3aFOHu9TWMcR9ceCeAptDhb1HaE+YF281azS7lRN4Kdfh1gP02Hmv5/YqmPv6GkGSWSwqV1opWew4WsYCzLfsM6z3H/AvMaZ5XIZLKWi9qB+gXKX7sihzyfF2EibDSTBbx1XJHvDOx84WkLs+fRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rhNl3Hork5CmF1omBkGsnHlaO2lfUl4S/hnuftb6GaE=;
 b=I2cMo0325f3sCFAZ8x41nLzVmAGISCy05jJxMzOH4VUCHRf544S//Yzjvbnp4ENBejo7jjH5TvfrCsln9SXRVbJOC9Kl3E96fAEkrh3zPahAcygX2KNSXxy8ZP9X0gz2QaMfHY3dB5SNzNSB7N38eQSYcJtT8eNkRL2p7QjN+rchygfM2GMyB97B4JSm786y3hFxXp+sgt0u8RCFJ9lQP4Af7VgGn9g/z7Jhpyb9rCbG3OK4sLO5iFrdcTxOpaB1pRgZgNGcB6RHYT5ZhBgYdPiYjxD5vhDTzJfAOSqAPOUU2BbxAbk0ijMu9SLbnqmrbj/sHsuXlBnglxq+3rBusg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rhNl3Hork5CmF1omBkGsnHlaO2lfUl4S/hnuftb6GaE=;
 b=AcRJPtGsTCWDh4JasWgrEZG0cnFvjQwlulIpO4ktMZP9cLJtZhujWQOfI9Xp+crveT6XHeRYDFgGVZS9ctFxvLVINCQ0uZ21IAvDRwHeZ846yDVPO6nu+ZLgeW5hx+h/ROyrtGzHLcrBm+vzRDJcsg1g/S5dsEWIqyO9eHp2plU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VE1PR04MB7295.eurprd04.prod.outlook.com (2603:10a6:800:1ac::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Tue, 20 Feb
 2024 16:20:52 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 16:20:52 +0000
From: Frank Li <Frank.Li@nxp.com>
To: lpieralisi@kernel.org
Cc: Frank.li@nxp.com,
	bhelgaas@google.com,
	cassel@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	festevam@gmail.com,
	helgaas@kernel.org,
	hongxing.zhu@nxp.com,
	imx@lists.linux.dev,
	kernel@pengutronix.de,
	krzysztof.kozlowski+dt@linaro.org,
	krzysztof.kozlowski@linaro.org,
	kw@linux.com,
	l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-imx@nxp.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: [PATCH v11 13/14] dt-bindings: imx6q-pcie: Add iMX95 pcie endpoint compatible string
Date: Tue, 20 Feb 2024 11:19:23 -0500
Message-Id: <20240220161924.3871774-14-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220161924.3871774-1-Frank.Li@nxp.com>
References: <20240220161924.3871774-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0268.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VE1PR04MB7295:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cf85f74-de10-4095-bcb3-08dc322fe83b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	knfRlstfuFKB/xoKa1IhYn/EVKgCtgwZDrsZlwgqmuTMxu1+9MNOwIxm9DIjkZ+t13p5ml49lipJasTWqxemtzD1at+3K7wCd6jQ3HF8XmXyP9O4j/BcXCX5EDgja+/BcfVjQtUGzutPoOXrtd1WfUCZlblobV4vN+X1Y8ShMT4eGi1H7aF0UTaqzdoh/dP6lw9u9FU/jCxTPzIH3V77UFFGmu65hDKmLjOz0Fl/pZuoh/H9tcaDKQxwyvtALJ9YOstkr8VsGrq5MdfAhEp1fU4BW314fz0ROznz62FamXTQtvN6EOtq4ZnepQ/bCBvEYsavqswD/CBMs1Bu4I2XnnzLB4/C+D476znkz/6A4l4IN2jWGybRjrO+/P7B4lu3eKbOa5Oo4+knbjIQ2zvEOlWQ5uE68TPHuKY6sBBIG6sMFkmbyAYZpqRkIMWSQZYr64gr6L9EnPos7BeFTMm4Kf73aPG0WcKH0/zQTDYwceTg+hAN4Fb+c8tzvfOjG1VgQhmUqkro7Q0+rD+hgU6pCGDvEzJsDmBClN/yKB4JYlws49Mas2y89Lp1nkjF4U703ry6LwezfiCoo3VXJkb/xnUWpM9djBmfWYCJmsNFzJzU9xXJAv8EHHIYoCPgSZAh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KVRrh2RFV3ncZotTivR6eWpPpchrAivjyFlOMl29j2D18nGqBxvZo+OSrtzo?=
 =?us-ascii?Q?SSTfcrM072TyD5qNCTN7sG0uTqm7skcmR1ApatrEdF9XypU5dg2mkq7JplnS?=
 =?us-ascii?Q?nSGNlEdyRsZFBTCicTLEQBR44BWuSM/hyBLs5Mjj6ukdy9lbLH5pEviEtyA2?=
 =?us-ascii?Q?kAzkQpAlphoErhzj1EJB1shGlnH64yzB1vyvSAX6cGFlTm4+9oDjvbFQ2oAA?=
 =?us-ascii?Q?kIe3QC2lcGBAdjxTFoCO1sm+5RpRIsIhSurUTWT/XQ8RGTEeeYvyYRWr6zeR?=
 =?us-ascii?Q?VjZfCRS8D8gsxCnL3YUYlSTHLbt/cTamVB0WUny0iojg7/c3cKkhVrjTxdyQ?=
 =?us-ascii?Q?Ovoykewe5Zq89fLV3iGVt1Lz25uTg5o6Bef1kj4YDpNFppnJUGYkVZxzl1Ci?=
 =?us-ascii?Q?T3L711LWT8M9kunwKkra9f70mgs/OnQynQAKDmp31ABWVyiIF7SWsrDhfOSn?=
 =?us-ascii?Q?IpEyhFFjW5Y6lEbzUyBWsRY8BYtdJ3UbUP3ldI6xt+Noj2S3kpbvM7oGtoxs?=
 =?us-ascii?Q?LaHdyXSF+xEI2B1Qyef8+SKnWjmX2DJVgg4UWaDMjBnnOza5VnsHn7KVzLFq?=
 =?us-ascii?Q?XvBveAC5s7ujl+3x61nNCnpQRc+GpSf7pON/tXF+jqKWf+ZnHBScvk9F66wu?=
 =?us-ascii?Q?ZJvmU5MT31kMm8Ucp3EAwHbtbu2wW6Mh0lpA8mYugv4eVtzmdQP1C9fDqoYO?=
 =?us-ascii?Q?X3lM1W+4Cs/eTTLp4Gh9bHnopKFwX+0q9eIQzVZ2Fs86spif8EF1hrUdzom+?=
 =?us-ascii?Q?ODQNefg+e5yJNElohR8711SBgKeukhejmM7lePK+4isbbTBCBmRCwf47bmwA?=
 =?us-ascii?Q?8K1xrjEB2wFe4gIHk21S0l5zMFbQI736e8TlmTJi/aSzL0m8Tt4nN3LkvX25?=
 =?us-ascii?Q?yKWj3LmzaXkmAPv2051GRgyY5fpCNvDAlSE5QUmucFQK9qaphRtpoFWbtA3V?=
 =?us-ascii?Q?t8F2DvEsfBEkREwXL/IDES7OwZf3hsyJ82QcYsyumjhdPoMuqef3842w6jLA?=
 =?us-ascii?Q?iR398qdGLgX75GvoX+WOumjfVQ1lQRebt3+aEgSUcPk/A5g07YM0kexA/7zd?=
 =?us-ascii?Q?frIKKFiKCODzpuHaXM+ao4R5eu2BqjAN9cgoJtHAplXSYIC6jFOJlm7kd4c3?=
 =?us-ascii?Q?Vk2DgCPujEW1phB3w52s8SQwE7p9KPhWQ7wVNDma9Ys6hw23qspN58oIhmPq?=
 =?us-ascii?Q?+8rByJxKOUwQ+20GlWHLj6KNv0BJCjhazB1rfpm5A7gRm8esIkgCF3gclCYy?=
 =?us-ascii?Q?sBb7xZb93LVrps2qtEXYXYn+j7xJ0qDRVFiRPBwT9xj6nSBqbgc4cNgNsaTH?=
 =?us-ascii?Q?MfYcATTM9A6ugh1EEL9GeztGbQCwVYGzfOcwgxMQ8f2mTtPS2PUDTJ0FSnKA?=
 =?us-ascii?Q?IV/znVZK9BI9NwgeFuA+SciJpOV0gxEWq4BGFYUYbEaHPA50KbChxg3hf3Yu?=
 =?us-ascii?Q?PUsCbeeqep8G3bqF2HvUxA1VPF5mCNXQ9m4Fq3/3f3+y5INNRGFr63qK0pBf?=
 =?us-ascii?Q?qHFDA0RXYXdCRB9+/OoZL4PcV8HOldlsF0MPSe8Yhlztrys32QE5elxotlCK?=
 =?us-ascii?Q?0w5DrPKYuuU9OyLH4HuheheFAhonNXiXzlKw/x4W?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cf85f74-de10-4095-bcb3-08dc322fe83b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 16:20:52.2031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RJSTgjKbhHO/1XqbwZ/7vh0UP5r1zFFqXwxOO5JeiF3fzhydPjuuodbD+vWIotglChAmCuP98h9h6//qFe+JXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7295

Add i.MX95 PCIe "fsl,imx95-pcie-ep" compatible string.
Add reg-name: "atu", "dbi2", "dma" and "app".

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v9 to v10
    - remove "pci-domain" part
    Change from v8 to v9
    - add rob's review tag
    Change from v3 to v8
    - none
    Change from v1 to v3
    - new patches at v3

 .../bindings/pci/fsl,imx6q-pcie-ep.yaml       | 46 +++++++++++++++----
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
index ee155ed5f1811..a06f75df8458a 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
@@ -22,14 +22,7 @@ properties:
       - fsl,imx8mm-pcie-ep
       - fsl,imx8mq-pcie-ep
       - fsl,imx8mp-pcie-ep
-
-  reg:
-    minItems: 2
-
-  reg-names:
-    items:
-      - const: dbi
-      - const: addr_space
+      - fsl,imx95-pcie-ep
 
   clocks:
     minItems: 3
@@ -62,11 +55,48 @@ required:
 allOf:
   - $ref: /schemas/pci/snps,dw-pcie-ep.yaml#
   - $ref: /schemas/pci/fsl,imx6q-pcie-common.yaml#
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,imx8mm-pcie-ep
+            - fsl,imx8mq-pcie-ep
+            - fsl,imx8mp-pcie-ep
+    then:
+      properties:
+        reg:
+          minItems: 2
+          maxItems: 2
+        reg-names:
+          items:
+            - const: dbi
+            - const: addr_space
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,imx95-pcie-ep
+    then:
+      properties:
+        reg:
+          minItems: 6
+          maxItems: 6
+        reg-names:
+          items:
+            - const: dbi
+            - const: atu
+            - const: dbi2
+            - const: app
+            - const: dma
+            - const: addr_space
+
   - if:
       properties:
         compatible:
           enum:
             - fsl,imx8mq-pcie-ep
+            - fsl,imx95-pcie-ep
     then:
       properties:
         clocks:
-- 
2.34.1


