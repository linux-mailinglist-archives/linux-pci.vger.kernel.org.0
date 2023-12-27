Return-Path: <linux-pci+bounces-1467-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 770E781F160
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 19:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF3111F21627
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 18:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A2947771;
	Wed, 27 Dec 2023 18:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gDw2mRSX"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2068.outbound.protection.outlook.com [40.107.104.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758BF4C3B6;
	Wed, 27 Dec 2023 18:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NNGNthzRo1zCiRmU8NAocUUQzwNMWzp9nVdcj48cByh981VLfMb5dLVNLJVR6CO+JsYaNEDt0eDFIQjJSJOJiUzU042Sofkb7098PvFaJmCKQ/faarA36LDQLARcQhHaMC58PUo8/aiuDvtSdhXXj571rQmFOm9NeLILNRluP0ColNt7oz3zbIjmc5ogJd8VvJhOKLKzXEZOi8KL+VweqymNuP2OqVUpNI5L9Sv648co9+mgyQwkwVc3PoOFKq9M0tkGcWpHYpZSxhtUFWC0nsV2x42Mvl90AF399VisJDvJtKSIlVicf6UCWF1DkAecBNb/NCXv+csEZtTMN7pOOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KqwMa6eMbLnQJ2/DnJpJInA1vRcpd1Bx4zYAn3HEDQw=;
 b=RYREh3KJ5RVQdNX6PZ6jcGYkGV+M6aawNQ0DgqLRmMpeGHNtNxaItXFvYid2YuXybYVwH07V4ah1XEf9/MBa3sjjga/T7SrGBW46uUR39XaH1sjGXH00vXnK5BB9BJh7nuVyz7PDEX8dh0FNoOKupxkkY4IuLuHuRpFtjzr5/4KwNTTRVqmGE99K+16A4cZcZhdD1MN1m9Zs4e/mepTY8WqgF0wXajvnaUs+Klh9LAwc3vS2mxbkQSICPLT9rnfAtIxUx9eBwYkQBix38F+o6Gdj9+xQwDLX/al61i3hpgMl5A1WjTl0S/tNUIsLmfOrmmEsLp02eB9WClOC1230tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqwMa6eMbLnQJ2/DnJpJInA1vRcpd1Bx4zYAn3HEDQw=;
 b=gDw2mRSXqXN5GDJ1UK1XRGex4WTEF6nLDD9L5ePXVr9D7USdSDRUxx9Zu8tx39hwwd9FlYQAPxiWtUhdzinXAeit4zuOW1BcONMV4oxc/YpiVcAB7BceHU87I+YIti+MdTuOikgQqw0rwZOlPO1WIi3HML6vjedCOnpyoIPbVAI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB8271.eurprd04.prod.outlook.com (2603:10a6:102:1ca::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Wed, 27 Dec
 2023 18:29:09 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.027; Wed, 27 Dec 2023
 18:29:09 +0000
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
Subject: [PATCH v7 15/16] dt-bindings: imx6q-pcie: Add iMX95 pcie endpoint compatible string
Date: Wed, 27 Dec 2023 13:27:26 -0500
Message-Id: <20231227182727.1747435-16-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231227182727.1747435-1-Frank.Li@nxp.com>
References: <20231227182727.1747435-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0018.namprd07.prod.outlook.com
 (2603:10b6:a03:505::22) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB8271:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cf2aef7-f2dc-417f-2290-08dc0709b724
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NLLQGUMP65t8rDxO32E/O7/2YAB5RPElre0m46ytZW5fzcNMqnHhe2G1affeudrSVeQjeW8v5sY37AnpuQIL0Dxkg4Y0N+5DW9N14AeNNVYZuXdHv2lsKaCG2EPIAumXPIVzbouRka9KIQb2mLauW4U9CH5vN40wYMZVAqhAWgKf+tQsESupxiJQHtyb4icQWGSVtBSEz1syuc8voCPnRyUSSAHMKMnQQmxUDC/pwITT31H6MEszHnr++91OhR/6HsNJUv4ejLSuUg4i4V8HiDtnSYhjvHCgwidmSNtIeo0kgENRiN/CEHgQUOCFAbHwjd855sncKgL+D79ZJVXWZIaOUsKvby3qhjWM040hZ6ED/sAJ4X/gHUzUa88HZwzRiAS816L5FyAFlVn2bEaUz1SDacmbgyE9li6OPRT5hgibbGy8Tk320ODyW+p8TJ6R0GBFNyE4gVWVOldvNC/tE6pjwp10OzP05vDyvp02pwCjW47c3dOtTlpB3xymCLJViaMD2nT72biikDiNrZyhluV0ggqbZmV/3KyHqUruI9XbEgVEBjhaxX0//EW1M7N9FFoopMAZNFrF/nYZyF/Ydzc79FpP/Hl63x03cAmS5eyYT+QiIYULKu14O42bKaone/rfStJfdnIUNCGxlrIkPA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(136003)(346002)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(36756003)(52116002)(6666004)(6512007)(6916009)(6506007)(6486002)(66946007)(66556008)(66476007)(86362001)(38350700005)(26005)(38100700002)(83380400001)(1076003)(41300700001)(2616005)(2906002)(5660300002)(7416002)(478600001)(4326008)(316002)(8676002)(8936002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PMN3hWb9CUOW17xIdSTIBYMMUDE3AWETA/YZ4Ipv1ySa6gJ25eMuwCl+yAUW?=
 =?us-ascii?Q?shnKhf9o5261wgJidj2HC634K5xgId/VjQBxiq7QFvG3/KbUKb1TGmIWKi8z?=
 =?us-ascii?Q?9s2/O0W3DodC30wfMHMYzXf7ZIvNPmkbAxuiWxoCUx/2hmHJl0dxlwVzM36w?=
 =?us-ascii?Q?yqXYaAFWExLQCyon0gVvY2A4zIHP+fl7w+zAbe0d9OxkIUhnr+jS04lEnXgK?=
 =?us-ascii?Q?Dkq7qCPJCrO0V227Nb9O/NbMG12vFxFhgMn8XrQEPZXq74dnYfNyKHNDDb+H?=
 =?us-ascii?Q?VKdbsEhKxpven46XgO/hWW2cLlObpSAEPST71U3eTtmr+SvMEJtom/I849//?=
 =?us-ascii?Q?ToQYOCCxH6OamrOd/l5wrKx7xp9K4AwHkhXvdhd+noxkYhRGu8P1HT7rEvvY?=
 =?us-ascii?Q?Fo3n1x2iWwLBo1fbLVHtV/+YpTXLT26Iln5TcMVGWxHB6mOQMDfNt/OtX0ll?=
 =?us-ascii?Q?CDNv1mya8z6iaooi2Sq4xVuIM/RcALkIev5XH0Yi00Oqm2mr+nLIrXACnNfw?=
 =?us-ascii?Q?sHZ/a2ct2IUDw+ca1tY+z6AVuneGgaZYfX713PI6CZxsEtP2L2C/87NIiQEU?=
 =?us-ascii?Q?s5MSbFVEaupzenJlxpUbe1Ss1Zzt92Ea0XwpMw5jRwOR9Y4MKpenv+7Xntw1?=
 =?us-ascii?Q?feqw8GvJxf3myhCo07m0E/HeHBQUOdYVV+HMbzuF5YyOHiKoPqcivXI6Ij5C?=
 =?us-ascii?Q?Mv/RmP4qTg8anx8SITTRr4SJcpsd/5yXs1QSnP55vFvLVrdAdHwKmrwcmCN/?=
 =?us-ascii?Q?4XGxhKx9kQ8CuYSMiAbwnP8zcI3eM8DANCYF8PhyE5u+EWG5ARrQwE5oo6kY?=
 =?us-ascii?Q?orTzB6XmTRFT+GOdS8YTtJCKbw2XPs5SCIzXWLsisZj+JEaaFzqSOVV6dqIH?=
 =?us-ascii?Q?JIUphp2cjoX561qX57X5CK2FboIv3wp6OHf9Csb9qfQdMmUv808GWUYEuJTJ?=
 =?us-ascii?Q?kuocUmCOHREjn3J7PM4uovx43GhrOF/K7i9q3l/9D9xNCVdJ/I+ChLNBqiZ/?=
 =?us-ascii?Q?cQrddw9R/ka7GnuKp8TdR1ybVZ4z4w6f85dGMz0TDT7MK53MO56kMcforCHE?=
 =?us-ascii?Q?e/S0HSBYCGkKl+fd/Fvci9DM1aeFW3dyZwXGynIpAT2TDWlJibN+nE449sOF?=
 =?us-ascii?Q?X7RCnS4SjpHScVvSv6Ot/2ecmPNl5qY0nAsU+nOxJJzxkag5cr/p5RM5VkuO?=
 =?us-ascii?Q?pql2pcrPzkINnFF/SfOB4qApldoZMB68uGL2VaN1OTPiCQW+IlpsTPSdQvGU?=
 =?us-ascii?Q?8xIUMiy7n3MxzjWsnuOBqfBjg6g1hFsnkhKXiwIKaNjGbzC011KDcndRefw7?=
 =?us-ascii?Q?sXjCZWQD40GUSQ6AclIsPa/w6geFnJaFOwZ7or2C4hgpZ5YCC4nG5nDDrmMp?=
 =?us-ascii?Q?Q9fwYOJUt3bEF1LM9g8DAR0U5og05uSj00U8oAGt9jp6t3rrILjmkLVCscv/?=
 =?us-ascii?Q?izDSrKTr5LqE1YvFty9hTpLBCWFSGe4qGw5nr+DJ3A2ank2ShAI4GJn8iRbD?=
 =?us-ascii?Q?Zr4NzHJpnEqTlo2mMNsfgPZzCuJxC3+N5cdJ1uvKm5fydVo5bNprjGKlmdwC?=
 =?us-ascii?Q?J7oOHQBDJSJnvjrNYIM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cf2aef7-f2dc-417f-2290-08dc0709b724
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2023 18:29:08.9995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ePVppjzaezBlAenKsjz3WKXFS/48oBEdsrC7kKP/Jd8AfW34K2lfxHvsjh99KYVvlE4T1X4xDSMTenzYFu0dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8271

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


