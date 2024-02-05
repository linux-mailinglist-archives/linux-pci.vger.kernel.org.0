Return-Path: <linux-pci+bounces-3101-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7FE84A0EC
	for <lists+linux-pci@lfdr.de>; Mon,  5 Feb 2024 18:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12E8D1F21458
	for <lists+linux-pci@lfdr.de>; Mon,  5 Feb 2024 17:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AD54A990;
	Mon,  5 Feb 2024 17:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dNd6gTgR"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2086.outbound.protection.outlook.com [40.107.21.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9614A9A5;
	Mon,  5 Feb 2024 17:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707154479; cv=fail; b=PqThtlSR1SMKi7hN/P23c/UEZin8S+6vNloZOzA9+YFOOGkV1OYJiMxyq13PPU9OYsCTT/YjBSFjP63israiMAeV1+nnPGcxAvOJFy+z7adGPhrlwEbCnvlcZDEnA1QptBKbfWzfzuAsc4ri3k931Aq+IJ2W5o71r61yluGfin8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707154479; c=relaxed/simple;
	bh=v1qDlSDFc0Q9C33fJ+0C9n0DYjxe83RrxbWMbOeJ2Tg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pjFX4GErI2TD9l/Es+XdR818okjVfY7I1qY4gVniwYSHvCxlmHWoVyQ2n7Fwofe0NJfgng7KaL1UhzlOslnYN8HpJH3zobxykvVVavStnuug9Xue+TLuic/uswhLdlfkXgq2I2GrT3dPZf2QXh91l1Lv19jzsoYzQhEd8g9y9xA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=dNd6gTgR; arc=fail smtp.client-ip=40.107.21.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTs/pvZ3zKr5V1rIAHc/VEHMb+qq8jKxMd5Z6wsTIYML0EQNNOaiSMic8GSL6x5MFKYlXBiVRqn3Z8sD4NdhhcSeMT5wITDlqNusFzd90qlJPCuch3xjPM4F2M5Jpy2LL/G6PqgwuEP6+AxFmHMAcKQ5LjrSVX+jn9+Dg7xFK/6S/vU6R1x7x2PM32ukekhqlaPsZxFO2UYmos8wS5kwCbyG4RcpZdjTFnM8eWDODmGwbn27zPZwn9yu45APQCIxOWkvq4aUwLXCO/QtpcRKs8dRp6IH1IyLukM7MY3foRAb8a7CTaImAouWkRCDQH1BDnPnzbgif4MZHdIogjCbhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X5vVO7HnDeTAwyeVm6+Wd2tuSRM6SgTSkBrfq99jSQY=;
 b=YzcNyf9Xz3ThyY+u1sPX/VhPvOeJOdMCM2PW/9OyzD2/6C5m2RuetZUFSIUR4whuph8MMfGvNuX/GLQcBYruxBkr5GsCdbtExxQdztr/iLWAr+E/zl1l/Xx/+Z7bMITYolTzPwzGPZnHYf3jFLKXjU8s77KWPY5zVCJKGGJZsox8DXtt2wLswd7NmKzanYNL1yO+2XcrlcJeBjsS0TeabAAlZxTkUicsNc7t0Phr7M12kYI+cIAYsujDeK2lQ3y8fncu+imln/lylFGIJI7yrf60TOfMJOON7fsnJ/8QU6O+id66sMULPtVFRwDNeR35QSKavGte6C9oaHMgo43t4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5vVO7HnDeTAwyeVm6+Wd2tuSRM6SgTSkBrfq99jSQY=;
 b=dNd6gTgRrMKJOL/8oEc15Myd3hvv1610cpRHrdF+EZTq1hyIOdlSq8PtjOu8Mu3llixs6C5NwRI2wUh/pgu+CpLoop5xp2QdKCbbUBKofwbutQkcc1BnJ3JX6gbFW61NsT7ZV3k1LoFomRS0r+ybJHVceD/vKI0KWDbeNeFJEU0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7733.eurprd04.prod.outlook.com (2603:10a6:20b:288::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 17:34:34 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 17:34:34 +0000
From: Frank Li <Frank.Li@nxp.com>
To: lpieralisi@kernel.org
Cc: Frank.li@nxp.com,
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
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: [PATCH v10 08/14] dt-bindings: imx6q-pcie: Restruct reg and reg-name
Date: Mon,  5 Feb 2024 12:33:29 -0500
Message-Id: <20240205173335.1120469-9-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205173335.1120469-1-Frank.Li@nxp.com>
References: <20240205173335.1120469-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0041.namprd07.prod.outlook.com
 (2603:10b6:a03:60::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7733:EE_
X-MS-Office365-Filtering-Correlation-Id: e7ff9a79-ad13-4070-e8dd-08dc2670b7fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+kKmloBTP5JMVRg+QQTwFS4Osu1PxveyG5kx+O7umQh1N4aHjwtsfHP/Olj+NvvW5rMz75RRUm75YxKiOla77JAvqwHqoqH5bL6tEZ4Qx5gW2z0GLmTRCzsCqaefazgWS78ibw7fFlHdjhlzl8qvivYEMisN5hGkudYG6alwNvh0LufN/YL77T/FezfZ5UJjr3LWu4TRVP8VQoFIPgJjBqq8Z9p/PbwDm1eICU3nDSQ7dyJptDmkI7SL3vea/WQHMLkphyoLVsKCUr0ybj1KbsIsZcJ9f4qp8JovtvWTcEMRRd5pr370tWdiFjl32jdZj76rdFzM+au8ux0Nfrl5h3BLRanTqyif36KFPapfy/0OAkatLLDEaMz1rElCd+9uBNldFhs/vftEQ0PKzvh6w8vlIEniKg9H6ueldR1/qDbcdIr4P6SDjzicnB9L8ykfhw7M6o+FAkfFbRUtnWBD4YHW3Hz4PnKGQGjFARmG3poEfsBDPmJjxY1ybspcm3J0shK9s7UOOHsELXElIumrysVKDDoOcEHA8DX0pFl9g5drAk5kyo13XCg6tGMpC3pWyOIaHFZjR50Rbsvr/8fe7eE5srvZYhvrMBQUe55Ldm8BrMEaJ7yGLBWfSIkNvTlK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(39860400002)(346002)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(38100700002)(41300700001)(66556008)(66946007)(6666004)(1076003)(478600001)(6486002)(6512007)(52116002)(6506007)(2616005)(2906002)(26005)(4326008)(8676002)(6916009)(316002)(8936002)(86362001)(7416002)(66476007)(5660300002)(83380400001)(36756003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L9InXqXtTy6NZWD00vHVqZCsOCvugS/ebIFZlgmusHR3CQXtnxoAqQBzTzkC?=
 =?us-ascii?Q?Ttog1VK1bj7Xz2O6kzZvqDrxiuk1b/MPxqfS5ACemJeMhYYp3KWb0c5Koi0l?=
 =?us-ascii?Q?v5hE0jCIQjYrvtDZsCNLqtKjQwjBWz2jYXxt2cZiKf96r8nmMUjj9+H6+SsP?=
 =?us-ascii?Q?8UVumrwBo4mw4aNyqWtFvwzi3+4gliHuNoGNEY3jb9HUIkTCO9vWRg6J/qNt?=
 =?us-ascii?Q?ItStGjgG6MVYEirVFfLwBIFQIRndBqbDvL9n4nS3j5CVeePECpY/VNc8bq1m?=
 =?us-ascii?Q?V96WUYKHkIHPK+nEztI6VaeUBEqosm4nKcr5k/ikxsvQmtDMXkSeUBSfGzIH?=
 =?us-ascii?Q?PfD7tfmeDg2teKqDPGyuAONxQH0X3BMKrWxo/H+6NbYCmK3naoR/v+Id/mFg?=
 =?us-ascii?Q?ezqAIkhOeqR7ilkohoV1rbpgGyAL8nTtRgnxFvtGCnnnH5c6z6q1/cjrFty4?=
 =?us-ascii?Q?yL2IUYjwVkXZXbYYJo8NBS7eyJfzbOR9lSQV2p/bHpAMXulPUa+WFUL90K0w?=
 =?us-ascii?Q?vg7vbsVanYZsCwaK/7xgP3yUNxMH8MjU/GLd57bN2H/R9KmM4pPni4JKBlun?=
 =?us-ascii?Q?UH4yaiVqF9rm6NvnBilNFjjgCqM8NEspWkrEz/PQC/QI0YJmbpLdxk1sQPEv?=
 =?us-ascii?Q?d+pl0k+EmZvQmjLVjPj67U7dQ6GLFFxCmCWhy/ESlcNkzwI3VXuIxNdzaEyy?=
 =?us-ascii?Q?oYGWUyteeGMdqbeTkvBE5f3g8wOm9fkOaOdoyazxoHDLW0rHAQKPL4pOgXtX?=
 =?us-ascii?Q?DWBzgynq57F1ZqFgfZ7XuEYf02t38FRANkBXsA+4o6BkXJqq81zZ7ItDODkx?=
 =?us-ascii?Q?GIM2eAUqBCKLyu0AIrEUfg0RRN2IaAuheOG7Ggt8UOleHYZym3sDL4w0RF34?=
 =?us-ascii?Q?Uc9RV9ZCD2rbXry/uvo7leXNgYuy5irLWzzyjIvC/UOPv6LtXuT2W+jlutO1?=
 =?us-ascii?Q?F+MzMN/HUbKDawp5stcJYEfGn8l8xLi0Mp25ouh07/3JTl3iYNrQTZDKnOL8?=
 =?us-ascii?Q?9VQzuxYuVpFLRs+MNfERX/t6LvdE0AiWpqMgV/czv3K6jCgK+ZXgk4kJ+f06?=
 =?us-ascii?Q?zV53u29Ro6yBN/CLsKrFkcqnlDnnUc8T7t4gpikkmMDjy1iaadJLJ74W9IfN?=
 =?us-ascii?Q?TNHZu6IVIy7qPn+6SBp5OWg+hGaLy1WdE+BYHch8ILm7m+hUgZDFWlL4jS2r?=
 =?us-ascii?Q?VVBtEKD+pAMHG1eWHL4MizI8MX8bpjSbPHjHOETpivLVHE4fj82agLyjTSei?=
 =?us-ascii?Q?D6GX7/TdArFRSLVfrSturb0cQmmFzXCquFAehvQGqMvY9qcI4BaLjg3NnEXz?=
 =?us-ascii?Q?PTgXG5rRrGkwkiT4dBb2RXcPnvLaBHV/AJRbhRg3gWvFBwvg0eIFp+L9bndm?=
 =?us-ascii?Q?T1atOvil7hvoC1cEP5UKYUhftJBQkk0QSexDHyogNLJyNzSgTdywXqT+p15i?=
 =?us-ascii?Q?Zp7BoZHtrTe5tRIPw6EA3LGeMzQnpV7ABK+DMovN96DBFEjVGfmmxxVXMOry?=
 =?us-ascii?Q?i6rnHqxib1EY+YCvA3zaMebntupu/lLbh8m6BR33ChcKauCLupp6JJb+DLkq?=
 =?us-ascii?Q?4fwhwkeyTaI1lEYhiVOXMb4yqTolOo4EgRkWHg92?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7ff9a79-ad13-4070-e8dd-08dc2670b7fb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 17:34:34.5857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5V/cWZiCGofZvLa+C8AeWmFlpc+7GY5ZvrnZ3HTMemdLd5IXUjbYdsm1+p5MPE9e6pTv+CBzxeNUdPHVPpGX6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7733

snps,dw-pcie.yaml already have reg and reg-name information. Needn't
duplciate here.

Add 'if' check for existed compatible string to restrict reg and reg-names.
This prepare to add new compatible string with difference reg-names sets.

Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v7 to v8
    - Add Manivannan Sadhasivam's ACK tag
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


