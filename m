Return-Path: <linux-pci+bounces-1853-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3644A827B8F
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 00:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E4911F211D6
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 23:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5315647C;
	Mon,  8 Jan 2024 23:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="S6/rf0OD"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2078.outbound.protection.outlook.com [40.107.104.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12E558ACC;
	Mon,  8 Jan 2024 23:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ob5+ReXlWkW/cVEhpRxSXhKqfNxM5mC3+aiC8FkLkDv1JEQrWpnss/rctrX3pGf4Of/ESyffSidOErTzB5Gy2JGgsuibFGUbEQvjeTj3Z2Xm9G7YzSzQSDVAEClVbWBbJvKJXSIF6+jQIlcs53vyjBjif9TgoT6Qi4bq3cfyfq8tIgiT0eIWYM1owG9S2cYYOA+nt+17aqmX1fyJujpuRH5AaDgX4r/6DwIjWlKeawauGJ1MJBs/gXlNiNSXJCKycWP0O80hv50g/WVpGvaMQDkzC68Z0Yacap5ehhwiDQGsoLBERuCtpDTY8SNPACLs1x8W9WtcUPazJWpdcbnHgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KqwMa6eMbLnQJ2/DnJpJInA1vRcpd1Bx4zYAn3HEDQw=;
 b=FaUzdyl+EqpAHCtj8RGkJP5g93vbBrNwDmHnBc3WV/9hXIf1gQgCJjpOtWKIquLTQgrSac83Y4Mh88ISQPbAf3z6HLUKc2E1kZE72gzJu933raeCRXjYkV2xqIyGHUEEJ1H+7i2/JDlo+/ioBdvjs8Lad8MSdh0YNM21pOAFu30K30yQkSSYKOVAfTde8Pd8cRHC2JnTjPL+/SP/FxjxdqJ4qQVvZ1DOisZiCm+udgik5ak8K8D1UPKG8wzDGvzJ0a7jrmN+nOjpUcA4TL5F4EBSAngeregwkGoXTNgqy0yk2gfimtZ48MBq+l7KqiJUMZWx8WgCfyNa7P0CNQDz0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqwMa6eMbLnQJ2/DnJpJInA1vRcpd1Bx4zYAn3HEDQw=;
 b=S6/rf0ODSISCnU4fPYALvBrjsDkkX+lvBRlclshoA/dCw1V7V9oiHkoUNbMfpShhEdy0DMqL/NRwCQT29mDFAWsjyWu2dD8pbiE51ZlkSPlnDmlw+O/wlbFqlA3ovPWQDpxCJq33urbOG2ZKhKRJfRrDRwUHbOkkTh0mg22wt0M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com (2603:10a6:20b:23f::5)
 by AS4PR04MB9338.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 23:23:25 +0000
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469]) by AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469%4]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 23:23:25 +0000
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
Subject: [PATCH v8 15/16] dt-bindings: imx6q-pcie: Add iMX95 pcie endpoint compatible string
Date: Mon,  8 Jan 2024 18:21:44 -0500
Message-Id: <20240108232145.2116455-16-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240108232145.2116455-1-Frank.Li@nxp.com>
References: <20240108232145.2116455-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0063.namprd02.prod.outlook.com
 (2603:10b6:a03:54::40) To AS8PR04MB7511.eurprd04.prod.outlook.com
 (2603:10a6:20b:23f::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB7511:EE_|AS4PR04MB9338:EE_
X-MS-Office365-Filtering-Correlation-Id: 7487311b-8e6f-4102-bc56-08dc10a0d010
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gYDaNEVIoRHTxXmeVax1jDs6sup8bK/pdK76gxD0GeBez4YO34rxbuXZpMUYbZYDJgaVIdAoK4WSBZ+ABOSTwDXAMvW1xam8umJkm5dlrQjXCJCFx51sLMRDnCyvXxn3nIVFJnqJxDXvCh4DbpVan3xpfQh2JwagfK2vn2ciudMBsXIcGPVvZH6sHFtoAJTjzyEVkDQNoQGn62CZWKJz5NEgN6+AvjRnjyi+j73cQdNoU4tjmPpIY1xoNBCuhPmws+j7uxMnv3gGi5u1mC0cxzE5QdL1MtUw6qsdW8xLf3fPKHcvxu2Izwu/dNvr4AX39Z0Nhmpw0npJ9jwWtsmv3HOsRIVeIauv6hzG0wcJN6Tqg4dabbkSDPSn356A7I40wAhtvwvrOc11I/SshRehLiEymR+U7Gvi+Ts0llPaGFkhnxDEmF4kCFESlRjzsYaoEX6zVxJXjxwtpBs2E5SoaqHYeK0kPglb0OC1eTtxgGzm6en9RV5vUeSzOvj4eUcUJppM19dPft//ADyn0fQu6OXBzm4d2aYfK50oNo7n733hX/PnyTXvOvz5jtOtfhuXtwX3tA/swe4rI80L1jIIbtjE4nzEGFgSOxolWCp6SvRDQ+6UlCt8BJsIKY+7nF1poAl/kkk/fYb8jKmJv1wJeg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB7511.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(396003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(52116002)(6506007)(2616005)(1076003)(6666004)(6512007)(478600001)(26005)(6486002)(38100700002)(86362001)(38350700005)(36756003)(41300700001)(83380400001)(7416002)(66556008)(2906002)(316002)(66476007)(6916009)(4326008)(5660300002)(8676002)(8936002)(66946007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9kqg8/lo20rltYNK0R3gfii5t/hTTeDlyeGdzCsfOpRfzcTQjy2IUcJjPRVr?=
 =?us-ascii?Q?59pLtBuskpV19PnMXyXeouoQd5rzkzZjd6yprlqTfwd3xxug/i5hR4cU8iQ+?=
 =?us-ascii?Q?IF/rT2RZ/nqdYxqo5BwULG2if9W/Cxgccof73ncUFPnE0y1W8tbbQ2aHnLs8?=
 =?us-ascii?Q?n8xvdjc80oRrP2WzzCC/w75MJ+1HqTZUo+RP6dhp6VrHBZT8UEmR71QISdgs?=
 =?us-ascii?Q?oaMVHFL+iRFYcR7YFfEV7+B1kYwAL7oVmcL3gU6n1ucpuH0BLLTranmWTh/v?=
 =?us-ascii?Q?644VETJEYKvwGfXH2tb98Z27XI+ubZ8TjJr3jix3o2uVtHjT2hWvIGhMiQmZ?=
 =?us-ascii?Q?tvl0d4hYO9Gs4oND2h75NJtPw+/kVTlXguiiCT4Ndku1fvOseXFBmP70RjG3?=
 =?us-ascii?Q?xMWBsgVcd3sx2D5K7fPz3A79Ody+KS9jGDPH7IKCDztczNfiri2CcOM3JNJx?=
 =?us-ascii?Q?AAREXES2jk2fZS3cU2yUfyszuMkUWDcYRlU99QhMWdZz0poMY809+FkjVr36?=
 =?us-ascii?Q?B1nCKEAFp0EuTrLxcJ3G+EDoHCc0eQ2Hhl++AJ8ad4tRbWnidi2ggpmvzztQ?=
 =?us-ascii?Q?JQHAIj3JoxAtQthANlrogoz5rZgKO1Gwjqfh5VUnLPFeYftq+ijM1YFjKnTF?=
 =?us-ascii?Q?m23x7HFPov3hUfj7Mvf2kev1oXbFcmbt0tncLWcFYmLWN7vD5m9++WFdh+7W?=
 =?us-ascii?Q?jj6ud52k2PFX30/kq4IsZLqn/w/UJrSz5FtLhUfub84RxnV0btT/Ia5PHD3b?=
 =?us-ascii?Q?o+MoWMwJMZxcU5p9htMZkzgv5TSFl/oxPlGrOoK4EdA2xwkHV5g/w4T+wVns?=
 =?us-ascii?Q?k/fVtxDU8T5Dony8kMmjRKZA3br+H2ZESANW48w6waGPgAsjMks9dmM3xmgc?=
 =?us-ascii?Q?ShUvCH+yIwBD/xXBlO+zFGu57WGdmGABedIm67YUBNlEJ2BxvzDOcFVMiP4E?=
 =?us-ascii?Q?82RDq/vhXWkRw7p1jFYwVcYLi9qaUd1nOVt3IT6PVbJOh96v/9wxJKlWFvwk?=
 =?us-ascii?Q?1ziM6McW/zOGWembayGAx8/riWB37Og4RlENf7tBYkgNK+7a2QnpzyBH/KoI?=
 =?us-ascii?Q?pYERXD4kTvrBvBFPDwYHLYFx6Ja6nxotUb29DOCV2f8fZSXLnNKzXXGN1IHM?=
 =?us-ascii?Q?Ot74k+I0t0k9mPaJEURKLsQV3uYGfmHjiiXNFHBbl+ivOi4B4yIObHGbNNT3?=
 =?us-ascii?Q?HloPoLhhJ0HgKQ4KkChLYK4/bWHiId+FlXuALpYRivr91YKX0ImTdI7JrN9M?=
 =?us-ascii?Q?50kS4tCnfN8aERGSDn5APj0r0wTjSVMnV6avLhGT6XfS6olLLz+RvjFQkT80?=
 =?us-ascii?Q?bOt6ww3Sg+l0BiabPYDJXLN4uPU1YoTY7Gmzlu2swVPFDrAixo5Jt85NaSXx?=
 =?us-ascii?Q?Wv1I+gRuNwhHhsw9E6TETvKaMXb1XeywXastBEeOTK3GRp+oVDwMSSuCzU9u?=
 =?us-ascii?Q?8+8g51tTlU4t+tEY9ecxxeLmmis5IO3BesSVYVIp9ivnB9cT0nIKnP1rA24E?=
 =?us-ascii?Q?6euZOksBifh0f3fz5v6hQdOAnWk//fKhH6Wy6GqBp9sM9OvoHYTRMNGAANWL?=
 =?us-ascii?Q?rJf6k6TxjH6xPWcb93jX2ITlaGibBp+lX6H94Z0F?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7487311b-8e6f-4102-bc56-08dc10a0d010
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB7511.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 23:23:25.2917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TBELZl2uKyerobHFggF58knu+P3abfbzsJL49bkap8C5m/xfuZiRrSm/oyH0c4pZYKlSKQYgrNhOP+5hAoUm7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9338

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


