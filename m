Return-Path: <linux-pci+bounces-1351-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6AC81DBE8
	for <lists+linux-pci@lfdr.de>; Sun, 24 Dec 2023 19:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB478281E3B
	for <lists+linux-pci@lfdr.de>; Sun, 24 Dec 2023 18:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D90EAD9;
	Sun, 24 Dec 2023 18:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MIi63QsF"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2067.outbound.protection.outlook.com [40.107.22.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DD316429;
	Sun, 24 Dec 2023 18:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lGm+6d01zSBgOJWdch0xt1lV0w9k9bS0tnNu9IFImZINoVwEn0nWRUDqI6dCzqtGGKpmxWdI/qAB4s3LiGON9R3cHsnvhGsDshcuzCqNt5zIRbfrPSwa4fiUQMtLL9IxrrmPhmsIs6NqEbCsjwcQl0b9/nt1YR9DSkp28AtBLVzYG/U2qGXwisCkllh+3sGmr9Ob+6qKG5KfRcY6i0ry3AakB3KagWM2zDxHULPRUmWC3MYTSUjlaiQ3tKVB8QjD3/iO6Z9XjJYfTL39IUAbz4cV7vX8WQBYIhZkJEMQIYXjPREuQWWgKGCuEC9uoC8UWRtShXQ+Vg0780LtKZkz8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KHpyHGEliWWrt/gcDy2BoVLigQmbfFhVRMGZwKdtry8=;
 b=NoQQUFphlbVjL2N74KRQ+Lh9qVfkuJC/ET4Y0EuVQxQmyJPB8Tp5bHYbJ2UoBdjbuvlVuHQh9G4fGeiCMI9kG1pJ4gv+HGRtlb5tu9LySyt8jO4JuaseZ0UykR7mkVCnHRWKJMxzLMmPoqJp7HHQvn37UivOXJ+6BXrkdQlWayaFfqmknX7AWc0moNSB88+apy9MUgi/t1Q0l9CqtDe2LG+MzCCZL8JOfzkE3UciORYTJqOzJoGX1kwY8uSL33zQdhkUj/hLVGar5yaXgpl4IdEnrzjwxfei/46haNWM9jraErcuJTCl0SYb42rotPd2f5MA3djbCAVwb1tfZqm78g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHpyHGEliWWrt/gcDy2BoVLigQmbfFhVRMGZwKdtry8=;
 b=MIi63QsF2To1UlcEn8bPaWmOv7reY6qUwe2fdQyljTx4BEWBFIq+9eLr/VP3VZ/kfIxH0yy9wqjBW+LSLZ94i8fnYXPOtbMyFmMAHbCWZHe/UNyE+FNkBPlZBfWMzh8NWQYmroujZfXFNpk32iejsPgoVgg9YqFW2hmNiPqF52w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS5PR04MB10020.eurprd04.prod.outlook.com (2603:10a6:20b:682::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Sun, 24 Dec
 2023 18:33:54 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.026; Sun, 24 Dec 2023
 18:33:54 +0000
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
Subject: [PATCH v6 10/16] dt-bindings: imx6q-pcie: restruct reg and reg-name
Date: Sun, 24 Dec 2023 13:32:36 -0500
Message-Id: <20231224183242.1675372-11-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: e79bd259-a255-4591-391a-08dc04aee22b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6ar2KW78zhj97kTqyn7DOsUgVcqjyxqAIoe+6VEDsi1b62LoFZiezjupkz5tmhk+vrxmrkz9+G/yMBTE5aumuXcI21M4s3puF+Mk2vtpYd0TkLNi+ETtS67Hmzp6A1bTnOquijW7/enI492/SxVv/K6ZbnZZATXSjCkh9aIqMPUhDAIMXnNnEKq2VcOKlbvp43BUY2552YnWxqrm+BJicYL82CaumW0pobl+1fZ3+NK7TmyFVIsRE3ijTTtuC6KqVw/ktarHCsub/rJqyxQ+D7wd8A2lFyFf9R6I9j1Fg//u5aBL/g1zHat83gsr8kzhX/nCTTW6cGubfDFskaNRA8s4YQH+pJM7+sXO2iF+gKXDpBg0iNy8C3OzvfBFvFA7uZNguIRZG0j2q04R8HF0CBuqp1pgDWAEnnsdAXUVwryO4+tgOBSvW6hQTMryrvfICw2bOSHTRCqZsCaVZdrIxcA4JiTeakvUCv4ZmH/1Fn5quKkjzHuwVjuUJ7kSchaEO9AAYNJa/v9vpfxhIFxjCZ2HEiBojds3edoPyt/6SiDg91HuKLuoxz5FAIOc//rmbxLu4LiyBnloK5tsH+JroqyBLrSLChOPGTB6KsxWs6sU4qE1/VGYb8C9cMKK6Htpyh3QBexl/qZ+umcnt0/CZw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(346002)(376002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(38350700005)(41300700001)(86362001)(26005)(36756003)(2616005)(1076003)(83380400001)(38100700002)(52116002)(478600001)(6916009)(316002)(66476007)(6666004)(66946007)(66556008)(6512007)(6506007)(8676002)(8936002)(7416002)(5660300002)(2906002)(4326008)(6486002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g8J6sZ7Rys7VklsUtdZT4mZaKH0E4yvsgWx9tN7ySNii5RKWj2HLKELBA5ug?=
 =?us-ascii?Q?DFw9cdYAJFgGheT5CNQErLx4q0kjgJKg+iNXuO5wGv6dvlDWiO68eVMXo/1j?=
 =?us-ascii?Q?5xj71zai31gLdYsaXmgz4/JPXw//XVosofHptrEFQm0KQlcCR5EfYb5fy0ko?=
 =?us-ascii?Q?IypQLbgwrPVIC9i1XrjsPBXY3kfuAWw6V9dQjTFRrwYFjevVsSCIr4rA847J?=
 =?us-ascii?Q?xWQsFewiNU22Y7+QFrCirvijJnWAITAmZ60SjhlqcxNE9YJhHKgL29beZpWP?=
 =?us-ascii?Q?EguLoikyPY15JmD9IofDfkYhfBReSc9yerbcqCYPkMa7YZZt/EJ4J9rZ/EI5?=
 =?us-ascii?Q?JY7+4DTx3ThZKeAIlmuEnBTQzbQ6zjdxsHsqpbDvYYNotXktNu4/BWg09Vxg?=
 =?us-ascii?Q?AChv+Uc7KC4OpK9+3sJGQLlHlED5lSouKqUV4dPtXJ0QX2HXCI2Mx0TEcN4q?=
 =?us-ascii?Q?6SvIiRyRMRSvyWPBcs+ZFNqaP0mqIfjHpGQp2VqTJPM9MiqpNNTOFJ4nV9Zf?=
 =?us-ascii?Q?uszuC2jgjB22UFXnCLXTN+d2Nrgk/imSDrJM2QSc85PnCDBcCI/AEA4PCE8u?=
 =?us-ascii?Q?/PIPsMBAVJn8CYou9A5EGM9VqD1PiJE8WZmClye9lZVxcGdHZD5QteCbd1Un?=
 =?us-ascii?Q?MK8e+gtUgJ53sf+hpf3wXcMwuU26QH+Yfgyo+40BabrS1UwXsMyFezDZnhkh?=
 =?us-ascii?Q?zJkbINldhfggWfMVu2CMG4gP0Qt5ufWvsLky4HcwPOTVqj5Yq3yS/PQKud9O?=
 =?us-ascii?Q?Oox3WgtCxX0A3p2aTkwMHVJXqrRVb2LLK4/4/C4+zqKpn6YiH3KWbEFXDLOu?=
 =?us-ascii?Q?rV7wK6LiKgehf+TRf33BlQK9oSOIIDv1CGPMZji9STkfMi4qEDn9sXF7aXAR?=
 =?us-ascii?Q?girC3qm6XuUVT+LTxmrEalLM0noNT0QEZRRc0ST+CQ/4r7cu49gqYManETNJ?=
 =?us-ascii?Q?ewRdC+YCsoTk/Q/Voc3xGcX0+g72MqHrVZDqac7rDV3v0q89IEkkIEDYeuR9?=
 =?us-ascii?Q?6ghewR14cs6Y2yMzB6XoQtnf/05jAlRuVO1XbCLz217uQ2d5Bc/qTywZBDOi?=
 =?us-ascii?Q?5DcBakYzG680mggQRY9e86/J/p30/zxgLgvv3rKRITCDn/wO2MRht1UAtIc6?=
 =?us-ascii?Q?dio4wWYZzyGK9KbijviNPHwFybMp9N+MU4Fiz/D8PQuhO4rBKheg4qKMzvLn?=
 =?us-ascii?Q?6KbYbAw3BoMtw9MBkz8wNE5Eymybr5XNDBR+2isJhm0E+iKtEe4HB91U1oX4?=
 =?us-ascii?Q?/qr6cQm7qvWEF5OaxvuEygaRzFDDikD2hwbU9kDWg0Yp8WBu8Wv1vfD1r7su?=
 =?us-ascii?Q?qro2RhvVGDKYEUdUCYFXxSHCotCtP3Msy1Edt9pAa7E9WqMiUjPwST3OdSWg?=
 =?us-ascii?Q?IRb/eTMFgJq/3D2WrNq4O1DlyUeLIsnFNNDgWHLZZmGhoWGz8wmy8N3rAYBR?=
 =?us-ascii?Q?XvDYV7WLclRFDb0GWmoeK+MfsafP75HWh7pyHy6yHg+WRpVxLZhN6aS5xLUR?=
 =?us-ascii?Q?mwbt41Gks7oTjSeg4C7XZNGmjA+D2a6bZ9VbwH/duNmbYkrJdjhmLq/W2xer?=
 =?us-ascii?Q?z9Uk8igPvqSE9fXPZFQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e79bd259-a255-4591-391a-08dc04aee22b
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2023 18:33:54.6658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B5LvCsOMtzptDMmANKKuVq9zbdeJMBIspwaq5efctnXr1pPu4LkuV6fbo1QppNne+SbyXrlIAK/rqpofWoiojw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10020

snps,dw-pcie.yaml already have reg and reg-name information. Needn't
duplciate here.

Add 'if' check for existed compatible string to restrict reg and reg-names.
This prepare to add new compatible string with difference reg-names sets.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
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


