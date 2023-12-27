Return-Path: <linux-pci+bounces-1462-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7611E81F152
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 19:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4A1EB227C3
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 18:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B400D47F64;
	Wed, 27 Dec 2023 18:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JrKaOuiD"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2078.outbound.protection.outlook.com [40.107.7.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AFF4989D;
	Wed, 27 Dec 2023 18:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aDC4YmQwZ1jsHjVXrhYo8fT125Aa9d2x92RBmGuKPRzUJpixDPes91uJ4E9agwVUjX52hxABiib6hr4lyynC2qOa7/zQOfuLZNYbdiPUTm8a/fVIorxPKDO7FQVvRtmB5cKpDEKVyK6rM6Y8KrzCz+S1Z3WgHJ2Xc1B6mzekHnMw/0UgWLLpL1A3CGg/l3v3dHj6R6Ss5uFZJtVREFXRsUgR6KsAa8yClBMmNolwPHqbz91DuA+gXFb/nWtGG5yDXpbMnl1k0Q3jquOB9JmPPgKAYJmVmGDfgbvEplriqvRTFhhA8DIOuIpDVgQaOns/Ub2ZIQsGUHjG+PU6LhceDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kzT9xQDWHyPkja52vLXfmsmvSsExDWiRMIup4s/pdkY=;
 b=ljR+ajbyZH7ntsp9+uHanyh8/cQpjdWsImYmePLVPtg+5sNfXnHqTHdIQEnWrPG92sIBwFv3WwXKSV8tQKPONLihsLZZwv34lUz9QZ1qiF3mDMuDVwEFaP8YwzfjTV9Epzg4X6nVIio6QBOXd26NRIwoTIJLjWyt7N0nWPDgELU0RjL7EY7rnx/5wAOFi2wDNKzLRSpj/mHTMwhlaK9Oxz4CmGa+h8uan5KEVADpJPF0dC7YP7pFBuKT+cUt8qO8QMI4Oq5BIICqSwj0gtCETRNETFKz8Ksejwt2HmnzCnQAnZmMpGTmsjdZm0KOzauCEI1xKZu8mQtbNnkBViQQ6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kzT9xQDWHyPkja52vLXfmsmvSsExDWiRMIup4s/pdkY=;
 b=JrKaOuiDzHXLM3Pii44VCbfcbC3Jon26mUynUZ4hJfVhIi67cmLxqHvk7OymV65dOsKM1eyhdBsQsS0OdVtbA4w73wMHxckyzS1mlm1GfEWd7ZGH9yHON7YFbx//Fi65bI3yzHUlt9YOyCcE/3rrt3eeQLv8UIdxSrKSglvVhdQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DU2PR04MB9050.eurprd04.prod.outlook.com (2603:10a6:10:2e5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Wed, 27 Dec
 2023 18:28:42 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.027; Wed, 27 Dec 2023
 18:28:42 +0000
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
Subject: [PATCH v7 10/16] dt-bindings: imx6q-pcie: restruct reg and reg-name
Date: Wed, 27 Dec 2023 13:27:21 -0500
Message-Id: <20231227182727.1747435-11-Frank.Li@nxp.com>
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
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DU2PR04MB9050:EE_
X-MS-Office365-Filtering-Correlation-Id: aaa79a36-1a21-4b8f-cd47-08dc0709a753
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	v5+qGfBjbffR79AZ70wli1QtM3+7+74kyeOLj+qIMNFWNmsRfkDVToHhvX+1BMCSxAnRTI0E42nrfHBL560Eu26x3DNjyr/YYiHny5W1QgC/TUc+PSAQf/s+1uSBnbaA62vdj2jJmlRSJpfMNWz+HejXkIm+a3PBa6c+QpPMMQcZu5ovSjO4grnlWoZLa1pIjALOkLhWnijFDDHk+neIZ5/BQEiGLVG91fGb/8qIpLP9hvXnijHxsWMLoLV/5znLitlAI9xvj+NspkvQ4SzOsoxDeegIjeTnn3EhtD9Jqa5HDp4h3EKIkvH8ZGqUgK1TjniKAQ2ArKPo0uOrxAdfrsxL/7VqsEVmbAB7l1JMG8rnximITm/Fy7atg0O+UC+xYpKLWske99Lioj6MumPG6CjUhzJ9zvXP+xJqW4rDjDqIF3AheuvLe8rOHRNkKE9a1bVa/+8oiZYtbwkPSk5xkbd2ekAi6XBlg98X63MJWt+WJ3/s6c6Un9uZwVOrnqYVa8XOLyjaKWyT6e7CfSfPfwWLu6P5JCo+A+dtxXz8PyQ6rF22BhMlL4Zyy4FCpoCfr+Sf4J0wigf94OLuvCY7L290sa2p+QcfuMJyD9NZxQFnGM8YqshAK0+LtqanuLYNXQxQUv00Cmd+A40yWJenrA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(5660300002)(2906002)(7416002)(478600001)(38100700002)(2616005)(26005)(52116002)(1076003)(6486002)(41300700001)(36756003)(86362001)(38350700005)(66556008)(316002)(66476007)(66946007)(6916009)(6666004)(6512007)(8676002)(4326008)(8936002)(6506007)(83380400001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ET+R20b4fC+ev2vP1L7qEYEMlODkyVR2A8A5CZoiuh+VWePBB2RjOy8XPJ4K?=
 =?us-ascii?Q?lkcN/OgkdDv8enc7bkPmbxNFDGV6lXoHURkCdkyw9qXRuUhUqcbDFfLATKcM?=
 =?us-ascii?Q?yzOI4DfWZ8EB+RFOmzOTcPu5Cyex+IkjIOaVhVVBfLFPHsB2CoU/XGaGKF59?=
 =?us-ascii?Q?SJJj5UooYypQUtPvr+Sji649RheHMAaf9puANoj2hdK8gGOR4TLwYuh0H7gO?=
 =?us-ascii?Q?0zFFtMvq+dTwvASwv0Vj2FCay+ufTl6sy5Y4XzspyDpkt983Tek7FofG1zN9?=
 =?us-ascii?Q?9N01yYEOwamLiudWv5p37QOOT7CXLVKNtilDv7xYpNI6/i9UF7SplIdFOR6C?=
 =?us-ascii?Q?3hSNF5GeFho5NTSvMCYLdd8hjjxLVTvVkGxx1eZMv3hxp6keIGGTMCcw0/+y?=
 =?us-ascii?Q?5o4ntA5Q5Vj5fZcbv4/sYsgQRuHSN9sDKUAxfu4KdNYV5z3BkV+K2q3n0nHq?=
 =?us-ascii?Q?QJ7C0OYZjjGITJTtA7RLwAJyW/ihrS2GknzpmIFP0lP66R/FTOuCHSQytRmF?=
 =?us-ascii?Q?DYpiT64+W7HDldi/U1K7Jfu+i/6ke3faW3R0ZfmwuaCO3W0OpColfZqefGh2?=
 =?us-ascii?Q?sujY2vOtUhMVcQf7ZEu6jGD8l5HsXBsQfSKONoxCkgYqxzTBI+n+04aYQD9J?=
 =?us-ascii?Q?eieetlELA1HwDHHw1+ubP9vHCILCtycriAiw66AaIBJ/93IGfKBw8CcHe5Hr?=
 =?us-ascii?Q?cbyRirO8s0lxYorCxsjxOp9Z3hL7F32OHItrLMryg2JxH1wZIuoR0zsIWnGG?=
 =?us-ascii?Q?D+2xYJdAby0Yc4j4aCy+AyydYs+gakGOgmBkvgVKmtj7J3YptLsQONrkfFeW?=
 =?us-ascii?Q?wKQk7FoHRVVY8hpTtw8JGS5ILIB72tSfqUzQpbnOHJqV3TDtIDN/UjyZlQac?=
 =?us-ascii?Q?TwAD9X+7RvknIC7UqtNrPCTj6Dl6aqf7d+h2kWstjiJSAtW4ik1t+omjckfv?=
 =?us-ascii?Q?x46UlS7eGakPuaizar0tGEqoT2RoiIQWDZtHk5PosZMTJ6avhYigfPA3cgO2?=
 =?us-ascii?Q?cOfswEyuXqkN92oPrBczHKmiutjG+g5vDsi6lEltsP28SlNB/hfziP2RVMXs?=
 =?us-ascii?Q?WzCPz5XrqMTUxM7qTTPJ2Akz0pX8ATyoLo9n5Uy00em8YkX+cbV4YCdoX2zE?=
 =?us-ascii?Q?XDk2Y+rRveObvUlmuQSMzmO9LgMQbRfVyuRLzkeyrUcCBuTpn6XLVTp3LTQD?=
 =?us-ascii?Q?sJBcLY7bq2FoXDv/UkhGn8Pa0/8Ug0ib8ZXxt7YDCU/9iEe22RCvle5sjc7P?=
 =?us-ascii?Q?agOSve/i10Xp5U48rQtBdgBsOPT8u+pIOnUzUMlUX/9KkNckvKL/YdCg1rtZ?=
 =?us-ascii?Q?DEBLMdLwc6eNacs8RdNAAtol6eJbR/rxPBXMwc4GKw7+Ks5iyXuh3E2XEfKw?=
 =?us-ascii?Q?4DU6k2CSr6VwTML708HYeKqpXWeHaEi+wTN2iJsQYbtsjUo+AvthvMUbGPyw?=
 =?us-ascii?Q?EB7FLEAJT5E1lOQ9t+FrD0bHUQMNtwA0OeddOlaGGSPVPa7xWlZBJ5Mdo0sB?=
 =?us-ascii?Q?c5xky+VSc4ZaFRc81rFp5mTyHzoAwLRQ9ugb8PdKiqFGtrDDKnGGbvEHSZ63?=
 =?us-ascii?Q?FpNcJmfSM1Batgu3CFY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaa79a36-1a21-4b8f-cd47-08dc0709a753
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2023 18:28:42.4806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WV9N2OLfF7P+WS9AZRX7v9Ificpb9aKqj1xg3b5Fy8qU1x22lUTYM7CnEIrJm7X+/FJWrWIOFmPSbwCYXF+nGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9050

snps,dw-pcie.yaml already have reg and reg-name information. Needn't
duplciate here.

Add 'if' check for existed compatible string to restrict reg and reg-names.
This prepare to add new compatible string with difference reg-names sets.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v6 to v7
    - add Krzysztof's review tag
    Change from v5 to v6
    - Add if check for existed compatible string
    Change from v4 to v5
    - add Rob's Acked
    Change from v1 to v4:
    - new patch at v4

 .../bindings/pci/fsl,imx6q-pcie.yaml          | 30 ++++++++++++-------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
index 81bbb8728f0f9..eeca6b7b540f9 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
@@ -30,16 +30,6 @@ properties:
       - fsl,imx8mm-pcie
       - fsl,imx8mp-pcie
 
-  reg:
-    items:
-      - description: Data Bus Interface (DBI) registers.
-      - description: PCIe configuration space region.
-
-  reg-names:
-    items:
-      - const: dbi
-      - const: config
-
   clocks:
     minItems: 3
     items:
@@ -90,6 +80,26 @@ required:
 allOf:
   - $ref: /schemas/pci/snps,dw-pcie.yaml#
   - $ref: /schemas/pci/fsl,imx6q-pcie-common.yaml#
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,imx6q-pcie
+            - fsl,imx6sx-pcie
+            - fsl,imx6qp-pcie
+            - fsl,imx7d-pcie
+            - fsl,imx8mq-pcie
+            - fsl,imx8mm-pcie
+            - fsl,imx8mp-pcie
+    then:
+      properties:
+        reg:
+          maxItems: 2
+        reg-names:
+          items:
+            - const: dbi
+            - const: config
+
   - if:
       properties:
         compatible:
-- 
2.34.1


