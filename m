Return-Path: <linux-pci+bounces-3781-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0B685C11E
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 17:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D8BB1C21B29
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 16:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5AA778B7E;
	Tue, 20 Feb 2024 16:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="J4mt1Xvh"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2070.outbound.protection.outlook.com [40.107.249.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B286678B79;
	Tue, 20 Feb 2024 16:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708446036; cv=fail; b=Z4+siRqGS6qRJURNYWBf4T/WmiJBGed0z59LP91zgxkfobQLa9bVyvSbY3LXbsl30o+DF0ttJ+cvGvrgumBmgCLYHwLyf6sdld2VZh7iezkSpPaSGqkrplWHxPmRVZp0mP9STtntwt+XW4V+sWbZqC7+22+yAH246XeRLJln+WQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708446036; c=relaxed/simple;
	bh=ScTy0K4MQ+5/neKteBFZcAyY3Cy1DUs22TiBOkS+Rv8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rzvnUuj6r8oNqb2lwuI+CoRqkbnS3F1ws8HqPNcDm3E5chtnTwlDy+cBkuCauBJ340hCiflYWN+rZykbzTHcBZb0WYl1mkcckuOE+Q/hdETb1uSGIZ11qQa06NPjL/7nSJX92LOrlJL4JbonI3JbhgmLEIXG5QnFM+A19Dn/T9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=J4mt1Xvh; arc=fail smtp.client-ip=40.107.249.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qn/y8xMVFGUwgHgDxfJwghvAmtPgTgORnBw5mV94eGUtQGvyGi3OCjBsa0FkpHsg43bsWIxExESuWZqJs0XIICzaOvDihw+sQXuCFX7xXqDzE+GYPfVNqsvHrmDN3rdxH0Ad35kC6eR+FpzY4nCK5d9Gz5jh/DFrff2Q59iywf1htjZyOBHFbXun/PlFdAXExmkKU0lzA2kna94m88LtyNsUtPNFORhj+GGVkpYjV92JiQ3voD0l0Seqi2/aD1xHnyRrwRjw+pTe44I5GbHGbrvpGKtYZr3dXNQpyEFrfI3sp5LoG4/+M02zRYXbfaBT7XiiWGnWjvUvR4C4Mo12Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FVX7YF2nnMsn4TCg5IFrEsxcSGDvsICvYhMpzGmBmJU=;
 b=UV+asqqffwDPbyVzudWBUEtpcjaVjAd3xtzJGJhXjruISw47hSYUX2tf4x6E+cY1S1/qy2CjP9dZxvBGwNLgj4o5IZRi6CGlkuMFp5wJ2CfMfQQD6Hmv2d5tfLDRNlv5QV6pIxWcYgzrqGWteGoZfViqNsnhrg8ugSnLivfNTlMOWzizLU06FNHjkKYp0bH4e9YaMtp9/EFueKSGHO9mNVIdwdf/2MxBp8Z/aImxdLG8mHUTp7ybjErxRzjZqLr2eVwJRQmxzs8siG+ymKIbIWKI8GpJYWw/AnEp7RR0Lr7J0auMeHxZ4tli/GqQnzmF6Or8DyL6lkRrB5k4+BrGZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FVX7YF2nnMsn4TCg5IFrEsxcSGDvsICvYhMpzGmBmJU=;
 b=J4mt1Xvhm4BRQ21IRnVAf0xoVku59ISzD2JOUfqDV2NzM70CSUNounEm4mIQDk2z8B2CLfInLlvZm8OGQaLR5d+4e34XgD9022Swb9Oj8IK7OTNCxFX/xbn/KPVIKGcdJ8gpSzLgxSRbwkCsWlaDw1/tQvtk93aHdOJ/zwNasfU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VE1PR04MB7295.eurprd04.prod.outlook.com (2603:10a6:800:1ac::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Tue, 20 Feb
 2024 16:20:31 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 16:20:31 +0000
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
Subject: [PATCH v11 09/14] dt-bindings: imx6q-pcie: Add imx95 pcie compatible string
Date: Tue, 20 Feb 2024 11:19:19 -0500
Message-Id: <20240220161924.3871774-10-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: ad29e59b-e497-4ec2-fcc3-08dc322fdbbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SJib65YVAFucroOMBqoSJTv8nb7s/z3Wk/JeEGqbN+bbY1qjz4EnWyuc9bFrS9PIhbNfgTAtSbPlHlIdwMWHCQ2qLDnAALd77a+4R0/Im/3WAhF9AC9KqzigGVOu+3dlKqRmrhd5EBPHRg7S6F0wxAC1J7fYonrvrjAWfwyu3OieBhOJq0hev1BmtVsNFpsl2QEfddEUpQr6EunF6aUEllYFbEJ9gtDpxTdLdJi3IOn0rVKEchruYlNEacgm+GFDHvogURL9yKEcFW1yRekGr//3vt2GRon52/vYQgJ4/bXarY1++buBTlwVu/0fLZczA0TBRnGtVSTtBRlK9TPe1tAWROXfJuKgHzjV0CKYuHStyQA8vR2YL/6ERRZxEMk9j+J01BgSf63LM1KaXGimS79tWrvcDu1vUySZ4l9irpGvWXGPkvctT6dcktUdiNVW/0puefNz5OySVvmDiwbsJTDzi5lqhknQW+n1C0fbJyPYIFFWa4T6b9ifQ05HFNM+1JltSE3EorGC9HVgLUe9IfqrwYo1nh/8KpOjAjem0QsoIiNr2Z12Ha5Mtw3XOlSD01n66Oc5m1/3D9774bCXT4OvyFECJcwe0P6Rw+KgnYjV+m88MUf36kH1xZSB0BJ9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GjSDLiC7O63h2T5yz3g1knqVyhktNaJg8XTEJ0sbza4U7wRkHFhiEYsJ12xU?=
 =?us-ascii?Q?Ur/deDmvWWurwokPR8AClvyIIYTWKtT6d2n+slkuGfZQUbRFnN5QWrxUy2Tr?=
 =?us-ascii?Q?ZjhoDvm3aFEzpgOiCygOnYh+ZsGPo3oLa/S5eCRHogRswUTRffVhd/5fI56v?=
 =?us-ascii?Q?5h293zCqU/fQHjSqqWwW/1T1QnS2wOhaJIzFoCvlFb2sjZPrnotulWhlI0Lg?=
 =?us-ascii?Q?Gl7IUAQ1vOyTL4lzGfPDzM53Sd0dlNdMbXG2aGNBFLaRvvkSQHKWK2WVRj+7?=
 =?us-ascii?Q?sxc5kaRs1WU29K2Z2/PnEh4WuDCCYh7RskSy5Hi+RD7KAFSl3Hn4T1Gg9Q3P?=
 =?us-ascii?Q?jZ1l2wZSRz/L3Z7gcHjxnoDicfLVfzhe+YJUqZZnp5iETsVeNmwfxs7mk4Kt?=
 =?us-ascii?Q?rnAWM9BtKQDG5t1sK4aeCQuw8HPEjN+j3CRoM0NjVZ/0YVXWmAFHXaiEaf38?=
 =?us-ascii?Q?ZIi6Xtrf1lDIo0IZO4Q8mKk5Yf9exmbzaZYYzy+z/r6OXaaTue6pkpTeqO0S?=
 =?us-ascii?Q?RYzfFq220VF2dUOsiOrxJi3lh5yrD30L16WlVfg3bUbczVPW1okxgcZb1DGu?=
 =?us-ascii?Q?79CaoXS4qaLVwFtGYcqzGqWcWDkI5VTlslPeZql5IgfWsWjdlwcXME0ZkeSl?=
 =?us-ascii?Q?32GgcXovXDDCyV6yA82ddjmxQ93OhR+GZsWJqr/9fVEhBwsMwzZ15dQ4Kjcq?=
 =?us-ascii?Q?R8F0DNkCQowPFwQRoaBqpJHhSM+jSz0UpcidgKnRt8l1BDFFJ08fLPPNk9md?=
 =?us-ascii?Q?vPcsqKCHOmgvYnctg4iHwB9i8nFY3A/PsOeEU7oHFJ5OqtjRHpaa73AC+3Cj?=
 =?us-ascii?Q?K+jzLSw+KQnh7c2croUuuHossEiCUJYlyklVlgXNplc48LAktiXMefZu6byq?=
 =?us-ascii?Q?FWCtmrcf9otQE2PLmFfMSkLtnfkwzE6irLVEO9QmX4BMfOrJPpBEbrEwLoIt?=
 =?us-ascii?Q?ezGm4p8CcNjmWj5of2Uj8HahuPy+aFqb+wQ6xQzozFJGc8WjhyWL/VvQIodk?=
 =?us-ascii?Q?TrI8UhtvNA/+BpfyrnI+fjRTpG6ci6hc2FyVISgfJdLO/H3Kd+dL7F5383M7?=
 =?us-ascii?Q?5r8ObIa8Wxp9MPolNv5tTDz+oPjnIPKO8w0oPVwMmdRuTzS9Db9AJ1n70ZrL?=
 =?us-ascii?Q?P/631GT4IUuvtFfmwHkumri+n1/M3WQ63EEjQGz3UOQ/E1ccj12zz5WwQUmS?=
 =?us-ascii?Q?mgKmTnA6/rltNFOGHAgTa6VO1ud5GhyHjf5M6cU9IFqSq7GAMj9v0SQoB8aG?=
 =?us-ascii?Q?ngJkgBWpezoYdo8+VPwt6fwFkIqJMQIuuXIGQhi2qcEzeRYN8ijTGnwKTqwI?=
 =?us-ascii?Q?wBxljcTiOttlCduiJlyy9TzcOogZ5dvwirlyybUmkCcexFGmLS2SyzNUcNge?=
 =?us-ascii?Q?S9GlxZYvumroxC5yUaK2B6nTJoKOL7Nqo6U7uGqx/y0OA9zOkZFJitNJ6PxZ?=
 =?us-ascii?Q?PnymzQE0JGoaRiKKr+rEypgLIRN8PfMnYX8bwyNvVlIIbFyQC+aD30RszUUY?=
 =?us-ascii?Q?DAEhkc+zJjS/eAxoZ/WWgZUIIVpBTZ1LP2b9B1A8u6FS686RPZA+z0RWCD4L?=
 =?us-ascii?Q?9ku4SApRsX6nNL1e9ITD6bXEyqtX5Jg21wgmXLiq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad29e59b-e497-4ec2-fcc3-08dc322fdbbc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 16:20:31.3640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: emlG4F0dDH2pXN05IjHQ8aR1VSALWZmRsv8tft50zGcMlxtgwFnDBkTNKTuu8DttRgRkUV0pXDjnJvLnon35Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7295

From: Richard Zhu <hongxing.zhu@nxp.com>

Add i.MX95 PCIe "fsl,imx95-pcie" compatible string.
Add "atu" and "app" to reg-names.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v8 to v9
    - Added rob's review tag
    Change from v7 to v8
    -none
    Change from v6 to v7
    - Added my sign off
    
    Change from v5 to v6
    - move atu and app after config
    
    Change from v2 to v3
    - Remove krzy's ACK tag
    - Add condition check for imx95, which required more reg-names then old
    platform, so need Krzy review again,
    
    Change from v1 to v2
    - add Krzy's ACK tag

 .../bindings/pci/fsl,imx6q-pcie-common.yaml   |  1 +
 .../bindings/pci/fsl,imx6q-pcie.yaml          | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
index 0c50487a3866d..a8b34f58f8f49 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
@@ -207,6 +207,7 @@ allOf:
                 - fsl,imx6sx-pcie
                 - fsl,imx6q-pcie
                 - fsl,imx6qp-pcie
+                - fsl,imx95-pcie
                 - fsl,imx6sx-pcie-ep
                 - fsl,imx6q-pcie-ep
                 - fsl,imx6qp-pcie-ep
diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
index eeca6b7b540f9..8b8d77b1154b5 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
@@ -29,6 +29,7 @@ properties:
       - fsl,imx8mq-pcie
       - fsl,imx8mm-pcie
       - fsl,imx8mp-pcie
+      - fsl,imx95-pcie
 
   clocks:
     minItems: 3
@@ -100,6 +101,23 @@ allOf:
             - const: dbi
             - const: config
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,imx95-pcie
+    then:
+      properties:
+        reg:
+          minItems: 4
+          maxItems: 4
+        reg-names:
+          items:
+            - const: dbi
+            - const: config
+            - const: atu
+            - const: app
+
   - if:
       properties:
         compatible:
@@ -121,6 +139,7 @@ allOf:
         compatible:
           enum:
             - fsl,imx8mq-pcie
+            - fsl,imx95-pcie
     then:
       properties:
         clocks:
-- 
2.34.1


