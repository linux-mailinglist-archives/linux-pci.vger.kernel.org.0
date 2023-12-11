Return-Path: <linux-pci+bounces-774-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B99FC80DDCE
	for <lists+linux-pci@lfdr.de>; Mon, 11 Dec 2023 23:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 397FF1F21147
	for <lists+linux-pci@lfdr.de>; Mon, 11 Dec 2023 22:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE0454FB4;
	Mon, 11 Dec 2023 22:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="shMhsbbS"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2083.outbound.protection.outlook.com [40.107.241.83])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E11FE;
	Mon, 11 Dec 2023 14:01:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aP3EMeAGm95F/DyrQu7le5G0+bP/BNtP+saekuxUzUYgqqvOewOGcKlI6ahgSepGt9CqLwHHNP9JolWWp5uHFtsvzv3OltlCnRZDI4aGp5AhXY1FSjuCTgjPHr+D9eUrCbrhDBPRILS5xarnhxEH6Hs/2Qc5zCFLVrxUhE12Ca9y5cxubCGUzSD/MCyNw8czaRFSW5mi3+1+6hoX8Sdjd5fspt4JXFL7wFKrvD++eOi8U7rkBpMXd9iFxisd8ZLmHQr3C40zCKZHQEjfxt4N7EU2PznGq6V7uscOh39GbrHAiOj5mYd5cY4/p5kSK0Zwn6SVCOGnL0vhT5/N/YZQWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJn1CcAug8mZf5HSinTejzQInL2u+Dc75u0Ow+OmQ3w=;
 b=Vs3G1E+xryfAQH0qzWW8/2d60Y305Ofze4dCT3ZwXSGrz8m/qWiKKPCy7FqT/H2T7j6aNZQ7ldTnMqhsVPPLrwxBcgaMADwHiKCuGbs08Yr5uH3aiddmd8kiT150kl4E3ZqIxyzdurR6Xtx2ZuskqoYwfO9+VqjcQ8dDHUrWDIGk5BmFtRHYXH1Cp8+3NHoEZVlLk7egU5e6OHxHrzj7u8sQHcC+BYNz8kA7+6TWVrGgADPfHG+F2gJozGSnJoqHKCA/+esyZNIkTkRyk14TujRx2HSy8evvp9QO3W1SU4riDGAktTdSmrdfp9TA6B5YHmtNcsNAf3QGvVfCgqroxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJn1CcAug8mZf5HSinTejzQInL2u+Dc75u0Ow+OmQ3w=;
 b=shMhsbbSzqvf/Mx4aAlyejznfajY0EfbvtLuOffEFzyRwtIaOORo7SYnMKY73uVpbsmtwLNi6e1gJ6UM806CSTen00m1pcenggheNAI0mdFkrB402IE335lU1sxeDNl49MHF9nioZrirmN3Uf0T8eCAzeHDsynWkCqVWCIhOt/c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com (2603:10a6:803:51::30)
 by AM9PR04MB7569.eurprd04.prod.outlook.com (2603:10a6:20b:2d8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Mon, 11 Dec
 2023 22:00:25 +0000
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::dfaa:e869:45eb:76e5]) by VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::dfaa:e869:45eb:76e5%6]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 22:00:25 +0000
From: Frank Li <Frank.Li@nxp.com>
To: frank.li@nxp.com
Cc: bhelgaas@google.com,
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
Subject: [PATCH v3 12/13] dt-bindings: imx6q-pcie: Add iMX95 pcie endpoint compatible string
Date: Mon, 11 Dec 2023 16:58:41 -0500
Message-Id: <20231211215842.134823-13-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211215842.134823-1-Frank.Li@nxp.com>
References: <20231211215842.134823-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::14) To VI1PR04MB4845.eurprd04.prod.outlook.com
 (2603:10a6:803:51::30)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB4845:EE_|AM9PR04MB7569:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c205792-e05b-406e-e6c7-08dbfa949408
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9YE7ToW4boflRLqwDkAZWA3C6bEVG2lBkx3qgrWqTE9olvuO8JbH7GTawMrKTwYEi9g8uC/IKdJkZYhTpxL+Jzgvv+FxkngqsG2GkoGyRbE/zLPF2hQ4JA+rMymnGmF6WHuyamvaBxDbYs/l//nv92Tt8aGJ9bdbzXgc5p/GLQ5meR202kWEAd2fAxn1DyW6mz46dqqdBA/GkhhT88qzUjJfOgfuuSU3PYn/gvAkLUrMD6FKxklXRQyI9trGokaykX+JP4rmvBPP1xKdYlV7ZjxBqwKFInZbr9fQufPiLlX5S6jW2QzK4fnfo4AXQTF54YD71f3VvCh3d/eWAx40+vrNoV4GJ8dDzRA+AelsPaLkhZPAG1JVrTunCyJ5QyoFSBRJK7EY9LJHo2tLqVzWfLi6VgdLJK01bMZQ3gK3Fpo2V0Y0D9iDRzl4GpJI3kIDxAWXqgKi2PL7NBlwF1GTn93GSsdJw3MSJ0zL6P81c6Ua8W5xxn8BT2xzQooLqa1dHqQnWIYN1xLq6FBcOBQMInb3IQYfKRkRcP+iPIjWkXiyZ4VOgVyb51PtD1G+V1PDpJMstgEJVz9AHA3R4Jn6j62b5340ayVYr8DGXoEaK0TInhWtRmDjRkl8irMzV5dvmM1XlU1cL2S+4pcKAGTy6w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4845.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(366004)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(1076003)(26005)(2616005)(6666004)(6506007)(6512007)(52116002)(83380400001)(5660300002)(7416002)(41300700001)(2906002)(478600001)(6486002)(8676002)(8936002)(4326008)(66946007)(66556008)(316002)(34206002)(37006003)(66476007)(86362001)(38100700002)(36756003)(38350700005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3N+mg2QpOl9sE/+5Av7VPzeKa+pwItyCSZzlnBAlrwbhPXBrIO+6++d5aZUV?=
 =?us-ascii?Q?gvWMjspxVGwp3uj95q+9xx1z9Z2hi8lfHZePKNafYPI4Y411KZ+jwAp5/wYS?=
 =?us-ascii?Q?/AQpdyPH0UHrNBiGt2VTyqXnYAU0m/mXPG8qbnIWNB4Uh2cUcWVQUguPOGi1?=
 =?us-ascii?Q?DlrnO6S7hguEUmkXR0f50+sSFrUd4JTpSEXYDYorI13xcoZEgJMukKt38EkP?=
 =?us-ascii?Q?F0WG18/XkABzFWlCVCY09tfCSmAhHqqcC0lhtQX8Ul+FPN11pIxB7Hn4h+Gy?=
 =?us-ascii?Q?QI5CCS9y6fx2Cps8O/uMamqYrAyE0WjZaRAKL0vCkjsxrBBbbTthA5IZIAHw?=
 =?us-ascii?Q?iv+26AcdRgD335iRprzSj6zZglEVirwJTE6iAn/UPy/glBdpKG8hVwR+BRSe?=
 =?us-ascii?Q?gJVsuGpsBQYVIA5eBnYbAYFtanOp7dfv3dsZPuvP0rEC+MOv+Ug63A/Ki5Q/?=
 =?us-ascii?Q?9riMqt84J3oviBFhBvG8hkAm9JE8g7/XilO8uuHv729VIwhfl+4uIjgLwBcN?=
 =?us-ascii?Q?xFR3HCQZtHtt/5txvISwtovnAfwTe4xDCxHSt99aAZn6gYMRbOecCmD/xoOp?=
 =?us-ascii?Q?58vHNX605z/sPQWDbLJM3bl4AZQmRhT0109eOJP1714GWFt+4xtYEQKJpu3c?=
 =?us-ascii?Q?TinqqfV2geeZxiKPXBp/DQ6bsGAfLZUfRvuFSRdQ+gmhE8AbMRtUVZSRMjue?=
 =?us-ascii?Q?h3akyB/YXxIEjoJAgtBrmn0BQGXYX3Pn6QWfWwrbSPJsXD5kjz2JnBw9K7xn?=
 =?us-ascii?Q?JZmgOQP3LohX4Y7OVTjCwomrYrTc3be6EUWlG/3i2eBJfRbIyAHVs0S69ufH?=
 =?us-ascii?Q?WGqAqhm5BjNeWBibijcU+RYptQfk3FXVkJ6PorzC8cx9kG8zjAgJ8cf9aluy?=
 =?us-ascii?Q?D6cdiDH6QwREvd5EbGKJtKk5eBDwFdPgUTBAP1U4mAkFdkz3gPhbAeZt+C1+?=
 =?us-ascii?Q?/eQ89XQXJm0g5HTsZ59fCdYfGCS1jq5Ht63ZGBVcfi0yv6Vc+1ih2N5SGSec?=
 =?us-ascii?Q?NrIh1DpKHtCBzGqIRUA+3YkHSznlAlkLco1JlZuOG+kbsrAhm+/bC2rWBpb7?=
 =?us-ascii?Q?p7nr8SpP1kBP3hokNcE0++ROTDF0euYI76HflNU6H/zs7sJxbh3CRTjSAGun?=
 =?us-ascii?Q?6fVOlxYhPXM1STjeDac8Y47BqbLgFM+Bqf4UXy0ogYNXMiVB/i3iYjVyCBPA?=
 =?us-ascii?Q?n27JVdgmNQ29u79wsY4Essp9OCsubnXee+dRg7uzVRU+Cdln1QmKb51IMXOh?=
 =?us-ascii?Q?9UpUeGR1LRmZAr3/Sp9r84XcFBV/zE5T1XV7f6Lz/YjBoot5jK5K2rweYG1o?=
 =?us-ascii?Q?aETKrQGj9/10jTc25pwSE2dKptjU70s+9LTeaKf06Tbxf5bcluT5mXasAANq?=
 =?us-ascii?Q?UdXiFbkrGWupNwBO+GPNFQLTAbDS0QfB++MuAt3Ln5KMfLgfPh9zIUDxTNgg?=
 =?us-ascii?Q?vgkZgFtKRsW4i45MSm1t580ubk0C8vgcTmtKXqZSnL7ErIiNE9xIpEQBLJdZ?=
 =?us-ascii?Q?eTZj+6aJzu0JFOnPiyoonHuMdwEweeTWn9wamfJ2YAdNDHESgxoVsUcOVL/q?=
 =?us-ascii?Q?jF+E/9f1sykf0FmSLZ1QqM1eI1HlPeMApzYOEUxe?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c205792-e05b-406e-e6c7-08dbfa949408
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4845.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 22:00:25.0637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 229KVatznAuJU9Kx8VPeook8qSfNwVcRSDBAyce5oTegobTR8AjWOckKP3r7NyMzV3UQ+tUubkJVhjg40mLV9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7569

Add i.MX95 PCIe "fsl,imx95-pcie-ep" compatible string.
Add reg-name: "atu", "dbi2", "dma" and "serdes".

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v1 to v3
    - new patches at v3

 .../bindings/pci/fsl,imx6q-pcie-ep.yaml       | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
index ee155ed5f1811..36d8f117fdfb3 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
@@ -22,6 +22,7 @@ properties:
       - fsl,imx8mm-pcie-ep
       - fsl,imx8mq-pcie-ep
       - fsl,imx8mp-pcie-ep
+      - fsl,imx95-pcie-ep
 
   reg:
     minItems: 2
@@ -62,11 +63,30 @@ required:
 allOf:
   - $ref: /schemas/pci/snps,dw-pcie-ep.yaml#
   - $ref: /schemas/pci/fsl,imx6q-pcie-common.yaml#
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
+            - const: serdes
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


