Return-Path: <linux-pci+bounces-1247-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EFC81A84C
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 22:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6A521C21CAD
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 21:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E284B133;
	Wed, 20 Dec 2023 21:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WfnSrXmc"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2075.outbound.protection.outlook.com [40.107.105.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDA24CE14;
	Wed, 20 Dec 2023 21:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aUJ5e4Gej5WEPuDhLQ0xUz3XZMqNLlTxDx9dIgd/5PwufoOjMDhrppOKYMbnTXUyU3Fw8hxymzbHlR45IQPZCiEjx6DEor8zmJ8E9qey4M5xO7+KduqjvyRoedjISRlTee8BP58ZXU3lfR5AQlmHDwfZt4emL8UkYelKtWr9woubDAqiwZlvoI8QQl/iJ2EM4GE8LKt8auygAMBqjG5Trsc7M2kGAXjQUbwDTZeDNAYTdZZKx/3EJ/sFkQRjbE1Y1ZVq1Cq54UJwRto5id/Ugy85yeh4/B9xaEeZEiidv9BMEK0pYrMtIUqDIWd68JA7G+3agptxANd8wDjbMNHsig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=63F9NxfXq3HmQYGZBPKTxEqddJisXBl3IIB1cnlRj6M=;
 b=HfLvXeKDHwxXqm5GloQ85P2BLdScIMnry8jQmB4loR1oTnl3jlS65auPJNI6gOFiRLVSyNbfgqE1Bh2d30SuhWh/hwTgZEdExTXl2E+k9r6WxDg+3zQ0EmCGOU59GV5hBnjry3yrZyUEWN50ZxL3jdvZdawTQohPWVa/eiVGRaxSDbCn3LTcTEhbpyp8yASsr1keZ7/LMuEf/xavgKi05i9mMkNh9vEiS9QjQRgYMVxr7V55f91p7oM217cHUekSfyjgWr8o70iYX6F3mZqiikno3sB3SsDHbIcchfl7lb+AyZSEdQ9Cnt5utC99qYnhZ8NEF8cAwDYOd/KqoixObw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63F9NxfXq3HmQYGZBPKTxEqddJisXBl3IIB1cnlRj6M=;
 b=WfnSrXmc5f6Axkm3dUcQc3mhJ4+KdC2udu2afubbfr1T2uIeYrZ1XieuAmtBhHc5Qk7Max8BgVvE66siuYRe9r3osXxk/qI46FrT7UvChc0JM5ZAKxJtUk27mHuBxD3LJtMQY0/OSMeb1Fm1MoRIIUyElEgG1QP36HoVSoBiDVg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB8313.eurprd04.prod.outlook.com (2603:10a6:10:241::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20; Wed, 20 Dec
 2023 21:37:59 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.019; Wed, 20 Dec 2023
 21:37:59 +0000
From: Frank Li <Frank.Li@nxp.com>
To: manivannan.sadhasivam@linaro.org
Cc: Frank.Li@nxp.com,
	bhelgaas@google.com,
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
	lpieralisi@kernel.org,
	robh@kernel.org,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: [PATCH v5 15/16] dt-bindings: imx6q-pcie: Add iMX95 pcie endpoint compatible string
Date: Wed, 20 Dec 2023 16:36:14 -0500
Message-Id: <20231220213615.1561528-16-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220213615.1561528-1-Frank.Li@nxp.com>
References: <20231220213615.1561528-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0110.namprd07.prod.outlook.com
 (2603:10b6:510:4::25) To AM0PR04MB4834.eurprd04.prod.outlook.com
 (2603:10a6:208:c8::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB9PR04MB8313:EE_
X-MS-Office365-Filtering-Correlation-Id: d445690e-cb41-40fc-dc42-08dc01a3ef7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	W4bnFLfufnMw8sNj0VFrCfF4QPCErQpJ/SR1cCSQprlVcVtCl31hENtpuvxC0+3D48THfzdMJRauBOpMgXa98EjJEjX9doGX/6NL9PdZ9W3PTe33R+c+LTc4j0c/N5lkstTnLMJVdFqIVZnEp3knXoPUanmVeGk+4DEfFPSQvcDX4GL6R4EUy2E/KM+1qN8/kill5bvCSkkL3PKOU+Mo/nu9ljqriS3GfB31jUcHc4xO16AuCUHOH7bigIt9AmpMmGazHcA+jkNLHWnXwaea5PKTSkh9pnQXrxMpj9zdJX3+CY546iYZyIUcz1X4IJ4eGVkjX09jROX4jXLcos/LLr1rl9nzjmctzbbMlNEuvck2QeBlMZkzeSHxv4MwmFWab0i6DkHxrC/QECdRud49n65bh5Pev6B1M3hM9qz1VGrqpyWbl9FHaHKemRDfXgLffpRVM+ypAFETX6I/n6j/ClAAGBdgt274bvcxDHDMGiRynVJWHGat6PYZkt8Po7JUNDd3+Tc7iAWCHBHVi6mvCuFWNnvhiennlLwUqlV1fFS1xKuh8w+suKQ9sIGwwPGW6l2kxSC4mXa0qFHKSQfkTO7GqrVwfsyDJowCbu9GVGRHhYsB1u9hlYw+xd8PYV82Cu5jpuyWyb1S9/6jNKQCjQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(376002)(396003)(39860400002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(6486002)(6666004)(316002)(478600001)(6916009)(66476007)(66556008)(8676002)(8936002)(66946007)(83380400001)(6512007)(6506007)(52116002)(1076003)(26005)(2616005)(41300700001)(2906002)(7416002)(4326008)(5660300002)(86362001)(38350700005)(36756003)(38100700002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?td13WycAy0+PP6CvkyR0BiH3EdYPEC7T48txM2j8R0X7VT/n+lIRDT8zLLpF?=
 =?us-ascii?Q?wcx0uxSGYnSQolcO8a5OtS2R3BQMnkgas/zSiGRc60K8JTisi69WS98EFBBB?=
 =?us-ascii?Q?yGMuNuB+XIDhIHameLxZQy7G3v0W8Kh3AVzjF6zW1KENmZKrk3yW3THP0wkH?=
 =?us-ascii?Q?N180uH1BQc2z69tubmuteiWVAdRG2v47uPIs4dbrTiR0Lo7/Uxy3c/UwynSY?=
 =?us-ascii?Q?DOmJtP7m7mKaijf1tDqhTuORN78nBKOds14OJFwhKM9NtDiWmi7pyUjh4EpU?=
 =?us-ascii?Q?zfSu8HIVRsqlN6Nberbnza40UfHCn+dR5uunh1EPZNVFQGtqtOy5hRThLZ+W?=
 =?us-ascii?Q?E6aRaUAqJkOPnxigPuZiYBTow8fyUG2/pAZK6AAtORALcPsPG8nyiCoWN0Gy?=
 =?us-ascii?Q?bOkhihuW53MkBscpCerq2HY6y7aKDl3ko54oPOYPnHdydQCNi1yjwFb5cj39?=
 =?us-ascii?Q?6MecXNSoVXpyIdjfarQYKYpYZQ0LnFDzMJjGb029XcjOw9Ve87R1oGCXdtrO?=
 =?us-ascii?Q?muVDlYOkU2fmFxX3+U0NK+XrMU+VKZJ/deKZ4xsBGiUTWhgTd8ZqN1cznDwg?=
 =?us-ascii?Q?c5A2fbuFx9HK345aTRuqHyijiulx799W2ujjdSHTQ1Jt4db4XnEajSaONSfb?=
 =?us-ascii?Q?IXcP1aUDQjEiG5aB4IDgfX1RuQ/rJGUOOlYO3oHwkLaSB5lhguHf3dj8Ncpb?=
 =?us-ascii?Q?BNi96Z7L1T9zPq1zxq16OCC8Uf3EUL60xhLSk8TUHK2HGMrsdL1BEvu9L3ur?=
 =?us-ascii?Q?r3HetbT1qgn/fCNKAn7q8/1WEw/v5dfmGpTEUoN1o1+uX2viw4OO8phdlORv?=
 =?us-ascii?Q?F6ZbTyorgDiq1521kGr+DqA0eybxmj3hIa5Lf5UyVF5tmZPliu+Kyh2D8mUC?=
 =?us-ascii?Q?wXf57ZCdXxAk04BFT0vJ16SAXLJQn8DLMaFnY1dSLwYkWiOg1tY4hX8f/GbI?=
 =?us-ascii?Q?2LNT6qjJJfG/FpUHjR2mu3KmEXGHdAxpaIbimITNLcX49BINeNwF3V7uq+4y?=
 =?us-ascii?Q?7xq+5+ZWmxXACRsRruOM2nA2R+U3bWhRfyeBJ9b8Aot4mTLDsrDOPqJZnsh5?=
 =?us-ascii?Q?mYuOJ4zHLaXswxhsta/Qv3VTcd4p/ZsR8JcR0bjpRFan/jlK9QSwTKhZOU1s?=
 =?us-ascii?Q?w5MIevbSA2rVT/7gHVAGjj1vMjiicx1HTVwsXC6DNkK7wdIS/jtroBGbpWJQ?=
 =?us-ascii?Q?BpoqmJrYSsFpGGLVgbklJuRYUG07wHW1cCaH/JI+AzFzECNPVEfoayk0pmyT?=
 =?us-ascii?Q?rk8HxHjLn08Vg0lHy5mzmcwA6YyQ+qY5LTB7K9rR5z45Yy6skvHDZux0BYdr?=
 =?us-ascii?Q?iMJMLC5y1BPpP/41z4DkfaNlZBMzzdutxPasc563xDpUP5h+rjZ2NJ78W8t8?=
 =?us-ascii?Q?FULvGqN47nkNVPJW2VxGL5skWD6upRb5+J1EU6L4DPHYSgbCjNjGtYxoGYSC?=
 =?us-ascii?Q?4B8DGAVUuVjQIXbfHMhOHvtprY5nj2CZtt4Uh6ZGJoVT7pLEtiAm+2XcsYe5?=
 =?us-ascii?Q?rbjuQQKWYbzfTyQVZsrUrhKYGaQrdPSA/nVDfXpXXEs3Iosrv2n5rxampyJe?=
 =?us-ascii?Q?rODCrxceT9SywumXr3g=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d445690e-cb41-40fc-dc42-08dc01a3ef7e
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4834.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 21:37:59.0990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gpeSKMkV+enU4qkcu8MCG8fyTPt5X/3kRglqc0ovDA8ziRfnjnTiU+2C7pqgLdUCWpBTVyyr1YllQmuv6yZGsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8313

Add i.MX95 PCIe "fsl,imx95-pcie-ep" compatible string.
Add reg-name: "atu", "dbi2", "dma" and "serdes".

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v1 to v3
    - new patches at v3

 .../bindings/pci/fsl,imx6q-pcie-ep.yaml       | 52 ++++++++++++++++---
 1 file changed, 44 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
index ee155ed5f1811..be9ea77ce8548 100644
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
@@ -62,11 +55,46 @@ required:
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
@@ -87,6 +115,14 @@ allOf:
             - const: pcie_bus
             - const: pcie_aux
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,imx95-pcie-ep
+    then:
+      properties:
+        linux,pci-domain: true
 
 unevaluatedProperties: false
 
-- 
2.34.1


