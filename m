Return-Path: <linux-pci+bounces-1356-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D2981DBF7
	for <lists+linux-pci@lfdr.de>; Sun, 24 Dec 2023 19:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B002281F6B
	for <lists+linux-pci@lfdr.de>; Sun, 24 Dec 2023 18:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0C610785;
	Sun, 24 Dec 2023 18:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="afnenlQr"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2061.outbound.protection.outlook.com [40.107.22.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79ACE18EB9;
	Sun, 24 Dec 2023 18:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MMBrhloQfU4HCnJ7Mc/Qlgo1x7tueOpKUSK26VlwZI/fczBnLBXAY0GDmFxioo0p9nQ7Vmva+Bmng92bGgKbOjnQtU3PWxMLMNMMx2Aby4h2MDmGlpvcEXuELmB0dvY9EDlRVd3Tb7bU1uPnf1IybRxmAb2HKgvmndrb8nWeTcLj936nI9WQdkFoSPtCMIND0zida8jfptE8TSN0Uscjn8SdYKaqeTvuRqcJuHwZhs+SJUS1roCvq1zMo6rfu+ZZs+vnQzk9E3hc7WLVmvhCjwbxv5a+6FP5bsJYJoIx3lqvMcDLnlkZA+2IfPQ2d3o6zhsnHDtsVFvd7+ioBFX9oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KqwMa6eMbLnQJ2/DnJpJInA1vRcpd1Bx4zYAn3HEDQw=;
 b=Dp4r80aCrLr2RJcJFvvb3bQzx3PgFxNC+6uJkkYrSTPd04kkS2wgejSNUkXam9hHgD9jkGbRaksub7hNgflQcQEyIV5rFa3yRLrWZEDHlhszj9Fnb74Pi0LxY3rhgpIhAL4e/KnttwvkFznqMtF9cM20tPkVQ5cex7NmXV3vhBkMNR6r6rwNV6wrYMnQfnAhZPmPBbap75MCTtibBVT5gtJTmPVoVA4RHRwAf/N6aFdDahiGc51v3Szm/GLaF/ALaTU7/q9yKn07KABJDSlcMVPzaqBFOl5/2l76VHC9lG0C6JK5fMy8a1gOAc+Y9Ao1bSQuY2M2MxYu+GYUbNuXog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqwMa6eMbLnQJ2/DnJpJInA1vRcpd1Bx4zYAn3HEDQw=;
 b=afnenlQrnPWRgibC6erFzYcN4qBIj/LP0IUy4x/E1aFsHAe+89G1K7xZI+ZfRQtzB6CVDdsxqSMEhk/OiPD4L5npfKtNAl2KNje2wUoFhYcw+v3uGb8MgsxK2P6CCmqaxlkbV+WY4NEfg1Xn2Ng9KMQid1ewDz/nWl1DjjDIzbU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS5PR04MB10020.eurprd04.prod.outlook.com (2603:10a6:20b:682::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Sun, 24 Dec
 2023 18:34:22 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.026; Sun, 24 Dec 2023
 18:34:22 +0000
From: Frank Li <Frank.Li@nxp.com>
To: krzysztof.kozlowski@linaro.org
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
	kw@linux.com,
	l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-imx@nxp.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: [PATCH v6 15/16] dt-bindings: imx6q-pcie: Add iMX95 pcie endpoint compatible string
Date: Sun, 24 Dec 2023 13:32:41 -0500
Message-Id: <20231224183242.1675372-16-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231224183242.1675372-1-Frank.Li@nxp.com>
References: <20231224183242.1675372-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0169.namprd03.prod.outlook.com
 (2603:10b6:a03:338::24) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS5PR04MB10020:EE_
X-MS-Office365-Filtering-Correlation-Id: 020576e3-213e-4456-11e6-08dc04aef281
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eOVAPqEk0BzFAm0w+lhAHrLyGygXCNaH0t4eTt4jmtu7nQNHul7L6jiQzKf3v3dXUxqeyj/rC3o+NI4N5Dem6rPokqXtWNu+A+/AsUQHMhlCLVrD3/y7lG/VWkrf9I8+q/sLfRuEK+9L9S6r0gNb5s6DZTbNTsjI3BhJtTdFmys14O9aGkPUM6iN64m1Sr8BQ6Df17IUJoy9LrQ1KAVRvpf0WzqaMOo4pEy3ZMxqb65vVxdUwD0qfaDObtbnf7lWVcEg+eu+uUBi2vpy4sxnOCVXTBrFgtUv8iDCDCQY8WwCYqRlHuqPzcJnTBCAscsUlT2u1VJmyWejE7c1w+8C4XZxbVlCCUcPLd8s3DwuQdS9uHKiWR+u0vZ5TcjzYcjtpn2CFjsAHzIWdkchPrMaIp6geB6K0WF0zHlovI81ZUBYqVU2f4dylmGiLQjsubxNW5FEd8Epuu/ec1j7xckJ+HuLBl2RjK6zSubBlS6zmjDq1t4AhW/lRkU0/f/JFW8JGEVxwmYtNQBJk0ntekPq3Fom9ZL83woQRp9To9UQhgearlkz/d7bPotA1ddQ2cKc5K2XAj2Ax2nZ07wubCIU8r48M57n3ZFn4szJtlJ2LQp0Bxp5OqBTa+TM5kSm7dIbnaSNiag3+21XZAshmcg7BQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(346002)(376002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(38350700005)(41300700001)(86362001)(26005)(36756003)(2616005)(1076003)(83380400001)(38100700002)(52116002)(478600001)(6916009)(316002)(66476007)(6666004)(66946007)(66556008)(6512007)(6506007)(8676002)(8936002)(7416002)(5660300002)(2906002)(4326008)(6486002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZClNXLJpOH+EwW/sSd3IB3IWHRyeM6vfGHhIvyjkFiz0EVXqprEC1fDmUCJ0?=
 =?us-ascii?Q?/yv9NVvvkvmfUNer5QxTy2vtRnK/gkaobpdZpAcXVshg2F+io+2eS8QiYArk?=
 =?us-ascii?Q?NeeA/wK4FPuDWnTIT+1oqibHbKeF1XK7QbadtymxtOx1NTK4DB6DBpE+/hV5?=
 =?us-ascii?Q?Q4i4Hw3dlpJNLTGESq1dXYf4NLq2Dc25G3B6fFQ3HseYgRS+Fu/Aj8ILPz+u?=
 =?us-ascii?Q?lj2ajZt/sQFJ6ZvAyZLRZhbBDnnK5E9WJjZ7GsXWc+nDJHIrbrHfwevgVpQm?=
 =?us-ascii?Q?6UoVPflseW/MEBSR42A9QQTDOuqOtdYpb8tDAB/dbezGmG84kCCyLyhwsX8A?=
 =?us-ascii?Q?C0fhEoilpTuFUYGp0J2uVmE86DYYaJsfZ0Ceqat7gDape8xTgDP4EhQzl5rv?=
 =?us-ascii?Q?FWOwLh8j93KtuKR1tsknNJqD4fiZ1CNar74OjXIRVHXKxXDmn4STRJ91zjtN?=
 =?us-ascii?Q?8al8VaexjxFyL9a6+1BnsUNKBlveK1K1q1Fah3cBqGLEY+YBiKLKp3YSAY6c?=
 =?us-ascii?Q?/y34bU2gp6frYkqJFkXzw5UKQRQ3qziquT2aFVVZ1H9zbed2iyE1MiBQuCFQ?=
 =?us-ascii?Q?teqSRFQTrwevtOooos8HA+os1HwFU/Ay/4BukpIa61fQ3eyLWAw8KJ+n8dkZ?=
 =?us-ascii?Q?t0qSUzjGrw5bfZbwNJYE4q6Du2UPCJtixI02j/VBzeBFPTYnkB8bySkya9pm?=
 =?us-ascii?Q?Zw1+aaC+Jcee7riXdEHB0penoA/uFjcWsQRqezFJV+I8QiJkNcCd6yrhbfV2?=
 =?us-ascii?Q?ORdGYktycclG/A2ToCpXgUrhW/Vwf1ttimg1CgDgNadtDrx3VBkj2FLwj7Gm?=
 =?us-ascii?Q?3tyblD/LUo64qsoHV0hIKCfBBgBYP84PdWR+z5CEO1YFZNxJW/G6EDa1Vd95?=
 =?us-ascii?Q?ymYyKUZ9ltDQNuaxnhlqAY4SQp3xHc2ThASrym4AvttUswmmZ1hT3hyc/whD?=
 =?us-ascii?Q?h8rfyrNP+SHd5Cb5uNBT5wqWy6rk2ykpzaSyBMYY9OcRigbOgNjGuy7q1lLq?=
 =?us-ascii?Q?ZJYa17fycYutuVpA20OQLAbPS+w2ahMw+4xFaH1Vxb0d4NXfpMZO5VGIqTLc?=
 =?us-ascii?Q?8n2FotfQUThExqyIY/mjIppjezeSSfHW2pg2lgYivlxJl+yaJvuFyNdk7u+f?=
 =?us-ascii?Q?xGgpa7CQeGgj91nROfd0QsMTOVVqTizSmzRJksbT3CPTeBBX5QAge+qa5Jde?=
 =?us-ascii?Q?CN+jaUDtTIWZVRPMhctg3mlzUS1TOy4+n8HLk/w4kM+kKZOF4/6j/ltyhj/i?=
 =?us-ascii?Q?a2HerAAQg/WukNPBy19Z71wDv1tXcrmm9miRvRVrIqW3cEpVLGUT1stLkrDs?=
 =?us-ascii?Q?I3PT+lHc4KMNF/iRVI04rV81CPeRCv54f91xwDqnFVAjvyeZQVALpexYHnMV?=
 =?us-ascii?Q?mC1VrFYoO0zZnnAk4EktYag4ZyVVoZLScQ4pvm2ZcXCdz0gF2Yj+8jadSJ4r?=
 =?us-ascii?Q?6idcrXUNsipFGzmzoYKQnQAVcgLClj2CxP1ev+7JOuFCP/QpZyHSuXxib4tB?=
 =?us-ascii?Q?3VzQ0oGMtuaJiGiQ7e6YGzJSp0oNWOe0jlCqcPOjhkMMH9MXyHClxC1L4Nfu?=
 =?us-ascii?Q?T9bsKftYgC0iTD4Cno0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 020576e3-213e-4456-11e6-08dc04aef281
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2023 18:34:22.0801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9hy08R4JNseBDA7EX2Z7bLIBwsuFRXtyv3ZpBVYh8hB3b2s5hD08AdyK+I3wZyfssLyi8K72WZVDFE0+so6TtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10020

Add i.MX95 PCIe "fsl,imx95-pcie-ep" compatible string.
Add reg-name: "atu", "dbi2", "dma" and "app".
Reuse PCI linux,pci-domain as controller id at endpoint.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v1 to v3
    - new patches at v3

 .../bindings/pci/fsl,imx6q-pcie-ep.yaml       | 57 ++++++++++++++++---
 1 file changed, 49 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
index ee155ed5f1811..f4d6ae5dab785 100644
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
@@ -87,6 +117,17 @@ allOf:
             - const: pcie_bus
             - const: pcie_aux
 
+# reuse PCI linux,pci-domain as controller id at Endpoint
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,imx95-pcie-ep
+    then:
+      properties:
+        linux,pci-domain: true
+      required:
+        - linux,pci-domain
 
 unevaluatedProperties: false
 
-- 
2.34.1


