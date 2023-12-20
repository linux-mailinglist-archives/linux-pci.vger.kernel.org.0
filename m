Return-Path: <linux-pci+bounces-1243-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1D181A841
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 22:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A10F21C2182C
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 21:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2B6495C3;
	Wed, 20 Dec 2023 21:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KUUAd6on"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2067.outbound.protection.outlook.com [40.107.20.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6702B4C614;
	Wed, 20 Dec 2023 21:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MYXZAKtR3oC/V4ShMf2CDYtp6oQwpfoRNbithkMTKH8pLkq7FzkKmKGhNkhpqBrfcLywloU03tyaKuTzhT9ACc1dHwd77PJSwpwkA4e3Teyz00Mk6ysIqLyvqJ7LbLkUCrP2vfRab6/Fv7E8EScID90RLCXqpIDR4CbCIaAYnuESKg3VRJUvyDphxAVflxuC2v5zxkxhH2MmBXKzwmIf8EZE1TavRB/WKV2K1lMP0C/dsSdg9d6agJYxTXJKyAMuIkH/CQQ6tKQFK8vBkgqhxNL35vTaWKf+3afhBbNkc5SpkZzsFG3OY1wgcn28KWsQDeYLmDBSUz5FSbEiLA6FsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bxKxRYEsHQU4JEeZf+dFCQGjfwMzsfTAgAJlMV9R1RA=;
 b=YgmDOKauChyT5ArFOFYshgy71VgSq5I0LL7xRrdXOr4f95vHFeiI90/rM0pRgTQpxgJe/yyoh5IP849OjkGMDluSqjODc2fr8ZdiLV8iZDxNBGe6NlRVfbO0Kn+IdKnes8n3QnRqSierwvqAokGMngHmKp+jR2vfV+CSr7NClQpNoAHfoskTlDyqLNKQ9M2hqIpPH7i+io/59ys7bPh5d8HmbkIe9yl6cnA41tFoHFB/AyB+20aQfl8VVI1um/tNO4RkCEI5eGRCN0AET6Fx7AZVOhv58sXkr3pZq0osa0/E9cu21VvGzrtBtXnFKUJ/VhFqft0/viK7FCoKo014GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxKxRYEsHQU4JEeZf+dFCQGjfwMzsfTAgAJlMV9R1RA=;
 b=KUUAd6onKt4MY1rDZCCU9dygdtwwlduRB5rQfY2lYT3/t+8SKcjyiPoqPe4VSMCx/s88ELybKNn3s3drF8Io+F5U6ET0bq9XyTIOmRGkIUGnbNmAQiBOb9NlFwMkSyef2/DDpGbF3pCsSaQigf0wC+1qeCuEK4F/yeT+ITV6Mh0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB8PR04MB6777.eurprd04.prod.outlook.com (2603:10a6:10:11f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20; Wed, 20 Dec
 2023 21:37:39 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.019; Wed, 20 Dec 2023
 21:37:38 +0000
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
Subject: [PATCH v5 11/16] dt-bindings: imx6q-pcie: Add imx95 pcie compatible string
Date: Wed, 20 Dec 2023 16:36:10 -0500
Message-Id: <20231220213615.1561528-12-Frank.Li@nxp.com>
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
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB8PR04MB6777:EE_
X-MS-Office365-Filtering-Correlation-Id: 30bc290c-dc2a-4efa-d15a-08dc01a3e346
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TrcMasKRfu9knblmmVXr4tJLfpTMhzwK9wBLYREtIMgbtCYYdhr/fsUzk5Bwy2GQcQBxXNdhyS8jIwgnkMdLLetKb4oQmLikVvKQLyLVIee1+D3UwF7AgrnF2EvcgOAGamNYqA/anwL0eO/WYfpfHc6+EnUHXT0ytV/eOPxPxXaM03ELi4A+WW6MuC7EYCeaorJe2AUT3P3qIG+zh5SwWdUyswHbE1aWPMdZDT2QpZH8cd64pDyLUScPa2eTw53uIHjRvd9GP4qJu1GD18Nj3PtLEWwJKFODLF1oxTUGMVm+INgxkXhUpPqn/hXlVWOApUIYfmUQGzg72w+i6UQBuFWKGP9zmA/ZpTEJSP2Ibg/pfLqXZuVEpJ7fblz8fgVU4pfgDIKRuMHc7CiBgokFOeA806e0TfIsDWnUGjgrTmW89DtT4U69Ettk72wUs+T5mwMXjZEaQx9/7cH2aJA4Nj0h5/dH8Hc7jtplfQJ9LZoGnAzBGfRlahcTzhLNgxE3ujCwlHUY9F+WEkJPqBzSK0M2P36FT9zob5sUnwcrYSZr8MzkAxinY+nKK3VzuwuPqHzoeZZUMLBWZ7PjIwR946ZyXqbnEmsSnhIlG6fRkfuq2QyLnbnsipneYyj4yyCOAapZsoYBwP4g3oB52TVGaA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(39860400002)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(6486002)(6666004)(316002)(478600001)(6916009)(66476007)(66556008)(8676002)(8936002)(66946007)(83380400001)(6506007)(6512007)(52116002)(1076003)(26005)(2616005)(41300700001)(2906002)(7416002)(4326008)(5660300002)(86362001)(38350700005)(36756003)(38100700002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1a1d946oxnuJSmx2z4cbTxjNw9xhl7WwQyxULUNGyg5LJPml0WU5twS6tUNr?=
 =?us-ascii?Q?p+bDRyWgWKB7qrYOCO4o62G8dE7Lak/DdUtK6Gj77NU5KLQsDXpXPSBAp5Km?=
 =?us-ascii?Q?wNND8cVkg/UPuzaDkYKT2fdLZuP2FPVPWwwdoaImSPA68IaGhSKaMV5kbkHr?=
 =?us-ascii?Q?IKSqusUVBYMRf89kSjE7Ngvk4TCm4l1n/RAPZZbRR8Mgjt37ftytLfWUYP8W?=
 =?us-ascii?Q?w2Pe+VWlt1cz0aXToWwMqXldldS54Fi0Fk+51z6UxQrnhQts6eN20hvP45Q6?=
 =?us-ascii?Q?iDSLogYwxD4ercTfiZ6+Hrhymrg5iWRKikLwes6oBvcesxqmJK0NrXmGjSfX?=
 =?us-ascii?Q?JQOEVcIwuXN+hGieIR7anUNSR9Db19lTeVTkqDH5PGVZeQMQwUmZb0NOLBry?=
 =?us-ascii?Q?wYen7wBGNdYjZ6FlIwuoun5RezJSEzbBt+PJh5BG0A88LGF5jaJiimFYix1o?=
 =?us-ascii?Q?znoqV78NqCusTnCZhjnOzTPVr4mjspkMMuUgTJCJc37B/NT4l3R67/rOIt0T?=
 =?us-ascii?Q?ecFEBorr+f8cNxzc4IG7/UerSQVKYEnaeKePr7dCcLvWYXrmVQbYTosTfRgC?=
 =?us-ascii?Q?rz+YBulCLzmb7/xr8Y+pWwk2FTyhQtMZDOWkzQbPtbvOoJObNiNSf3kbB3nf?=
 =?us-ascii?Q?kXrbcs2sbP3d3b1T/2dul/4n5aob9vIWi6jOYN84hbNAjFgo9jT9eboDc3+b?=
 =?us-ascii?Q?7C8ixuC7viRPQbWXEUZGHc37iplHS57SBHAq7YTeTTjqyONJF88hRPPqBi1S?=
 =?us-ascii?Q?BI6esaVkLm5ASAJ9ld6+hg32nrIhEwYFKVZSurBBHqK0sz87yj8F3GCBHKW5?=
 =?us-ascii?Q?0F4hr2qXL6a3ohsBJgTKnl476e7yAAiOqzzVDbiSd5qqUhU97vCoUB0dMWdi?=
 =?us-ascii?Q?KnkTp2ptWHL1FPkiedGGtvulC9Tc97ijtCVIfuPrsyU5YbhTyASfvFa66eIC?=
 =?us-ascii?Q?402bh4tzsJiQA1hhKNo0HSeeZdhOWkdnM1EFdQ/hrpc2ttRbl9zYNfypxg2k?=
 =?us-ascii?Q?MkgeVnlYcRbVJ7DwB30TY2Hc65m4syEEUPi+30wjkAh9PA087KCYK+dQBAaa?=
 =?us-ascii?Q?fHpXHk1N76tYox/y8YxFLuPGgI2OPOzFW6NbEx6TsE5/gMqR2Ykfiy9KbV1V?=
 =?us-ascii?Q?HsHAprZ0lMX5gaAtLtGnEgQq4E6VWtbRMlBPuUSEwWRiuZs9UeVgoeNQoSOj?=
 =?us-ascii?Q?s4H7qcEiq9yVZtkztb56y6LhstNBHULoGW7LwjKU9KiEi5k2NY3yYKNW7m0r?=
 =?us-ascii?Q?bKh9+2wBuQtxHPXP9V2x94EkJ4wwf+CVNg2oFn4k9d7vQajpw2121IjYZoeI?=
 =?us-ascii?Q?/Sss1+OI0Dxni3PVM81yJ6zu+hHYnuTEzUORoUkvscFoZLaxvDevu3zE9uHl?=
 =?us-ascii?Q?emZodI5Ti3o7hmCnSegLjyUp8aqcuqKtmWUGnl05yaD4hf0fr30cse0HUT9U?=
 =?us-ascii?Q?04dusyDa3fU7ZObNRY2j6OgwJfdwNS8LL+FJdN5dLXEucBiaSY2eq/mw6mrU?=
 =?us-ascii?Q?DWsbhW4nLhbjfOfai+S7D3QOf0ZNKay5aMPxNgcyd3891wveSyV1cBvygoug?=
 =?us-ascii?Q?Xh6pky4m1QhomZtoZ80=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30bc290c-dc2a-4efa-d15a-08dc01a3e346
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4834.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 21:37:38.9346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jLW9mhLr9HPjXonCmIOPZjhM/R/+YC7hNIZnxJeiR0lIy0fEcvrRmkWylSLtUVtHgT6nh9kBBFtH5jd09lGVCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6777

From: Richard Zhu <hongxing.zhu@nxp.com>

Add i.MX95 PCIe "fsl,imx95-pcie" compatible string.
Add "atu" and "app" to reg-names.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---

Notes:
    Change from v2 to v3
    - Remove krzy's ACK tag
    - Add condition check for imx95, which required more reg-names then old
    platform, so need Krzy review again,
    
    Change from v1 to v2
    - add Krzy's ACK tag

 .../bindings/pci/fsl,imx6q-pcie-common.yaml    |  1 +
 .../bindings/pci/fsl,imx6q-pcie.yaml           | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
index a284a27c5e873..1b63089ff0aee 100644
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
index f20d4f0e3cb6c..8633c622bd178 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
@@ -29,6 +29,7 @@ properties:
       - fsl,imx8mq-pcie
       - fsl,imx8mm-pcie
       - fsl,imx8mp-pcie
+      - fsl,imx95-pcie
 
   clocks:
     minItems: 3
@@ -80,6 +81,22 @@ required:
 allOf:
   - $ref: /schemas/pci/snps,dw-pcie.yaml#
   - $ref: /schemas/pci/fsl,imx6q-pcie-common.yaml#
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,imx95-pcie
+    then:
+      properties:
+        reg:
+          minItems: 4
+        reg-names:
+          items:
+            - const: dbi
+            - const: atu
+            - const: app
+            - const: config
+
   - if:
       properties:
         compatible:
@@ -101,6 +118,7 @@ allOf:
         compatible:
           enum:
             - fsl,imx8mq-pcie
+            - fsl,imx95-pcie
     then:
       properties:
         clocks:
-- 
2.34.1


