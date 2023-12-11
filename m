Return-Path: <linux-pci+bounces-769-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D350E80DDC0
	for <lists+linux-pci@lfdr.de>; Mon, 11 Dec 2023 23:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54CCE1F214EB
	for <lists+linux-pci@lfdr.de>; Mon, 11 Dec 2023 22:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EBE54FB6;
	Mon, 11 Dec 2023 22:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hLtZG2JI"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2083.outbound.protection.outlook.com [40.107.241.83])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E46A184;
	Mon, 11 Dec 2023 14:00:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mJUi+L3I4a1GvTbiAIYeqZxRSz2ltP53nI5YVZC5iPpFgEIlgmL2oenPimtOT2YdJIYZRnEPnA65W4U0shxatTvgNJWqxdAwWJefybtrWaTsWl89Y9xzR91eJDLEYAqLAI7UefbTXvXe3kZg1s2sSPZifa+PwxY34Y2irr/6w/KD5cfEFULLwMOHtmzrvcP5qUpnnJ6xW/soJSokK2Zhzn8rMb7M+4qYJTnSVLP9NhXAe2D3nYO8/5v7/xhA5O8g8Lttg2gCBb0mNZL0UaOhcCoaWRL/r5sTRIs4NDY49G7/r+8JRnwkRGXwhbvFY2T1IwOPrilB0V0bUH697YjtTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AoJCY3ZktTtXPzBt4oTAViK8W4q/hfs4cgWcegnnSzY=;
 b=IN1TJZ0hTFrWXMPAM+lbnBLkgVHVwbeu+EYVgH6lPCJcTOiR2xzuLVqGU42uN6idD0oLunumVKjwSXqQQiOtu6DlhmUDPEeZB7k69ZwU3YQoPUr7yBH0IJHbV/V8xsoyyxjTvA7fw5PIBU6zyi4QSrekDueLiND89S3r+T/xvvJRAySChbKrXnjjM8wciraSHnx+PlCbaQQ721MJEUTvtx/mopfUcR4zxGECN7r3VAEfPd07Pd76U96JpDCautXHgQ4yGqqPJy5Ha7ptNOShN2CEfZ5AYz2FaERsbxziX3W/3w/W5q5LZQDaZQB78A7FOC05DVmaF13TpC3qLKT9VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AoJCY3ZktTtXPzBt4oTAViK8W4q/hfs4cgWcegnnSzY=;
 b=hLtZG2JIIXfj4AZ/6ePXDaYo5W0S0PDoj1JjdKzK9xVu7NQUr6EWXEXLmvfJGjjZayzjD67n10LzhCNQiZRMgCheDe24hS4MO82it4OxcD1NjZLiyEvGPbD4iE2yshcDUhXZDgJQaUuBT57dsODuer4dEcZzsCYmTlAgCV27qL4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com (2603:10a6:803:51::30)
 by AM9PR04MB7569.eurprd04.prod.outlook.com (2603:10a6:20b:2d8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Mon, 11 Dec
 2023 22:00:05 +0000
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::dfaa:e869:45eb:76e5]) by VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::dfaa:e869:45eb:76e5%6]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 22:00:03 +0000
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
Subject: [PATCH v3 08/13] dt-bindings: imx6q-pcie: Add imx95 pcie compatible string
Date: Mon, 11 Dec 2023 16:58:37 -0500
Message-Id: <20231211215842.134823-9-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0e4b017f-5cb9-438d-aa2b-08dbfa94873a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/jg2M8uaehfApD8XACL8yWo2Z0gh3RD7NAaaZnPODfHjLuYoQFVezvxOHCBvqhT2ZusLRCBcyByI0xLGpWnvRH9XHvBslCPG8arPZayHQ+hdrsQUdKlIkSf5t9ntP1bd88cuECoudIRpC09QZ41KEhRv1q5qA/TCffvXx7ZcQsaoIHEvMsnYRkzfjAJ8vXm25ukKbr1iMFP0Uo4iwChx8MA+b9Zi96y9sjQ3LeGjW3Z4E9wzunQa4SNb68BOQU3tCbMce656rIlpnhrFEsodJS60fKztowjMKiXRRgjvc/6rCEvK+9RaLY7tq7xx2YFeouGnSvbpLQHPELcG8IRv1GQYUC1kY1vGMWv5IsZ+M+AS6txl11EncoSC/5PkeOaezcndQovxjZlKPp11pTkH2FVk5F8z9hRQEfThigBYlQdx9dAUsDoUoKURcj/SjL4PKwiemPV9Ta3l40MoZu4jCZt5VkxLvF4kxVSStY7f4nk/uus1ZYLuHHDe18aa0dRbip8Jb3RM0A9FR6GH0t9hQBuc34Tnv1PqRvmJ2aTFX4c6c+kYlcOG8nu3IuaPeIPg7yVTtaR7b1ddCWCkGP78JdqnEkJbcBZooebNcdIpqGZN4gVRE3gztou65Nz+Pf2H9BagGdGDlc3FpFDIM3zVsA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4845.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(366004)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(1076003)(26005)(2616005)(6666004)(6506007)(6512007)(52116002)(83380400001)(5660300002)(7416002)(41300700001)(2906002)(478600001)(6486002)(8676002)(8936002)(4326008)(66946007)(66556008)(316002)(34206002)(37006003)(66476007)(86362001)(38100700002)(36756003)(38350700005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7HY82mVhLBj3fCSbUy0wtwhGAghOIIrLeY1/bQymzwAMynojsKs94N66Abk0?=
 =?us-ascii?Q?2O9sPLUoZIjTFq5H3ARpgQgEh5QdEgaFbTApQuFeOgUJTyVKfJS9PL0go7o3?=
 =?us-ascii?Q?Zl92Xchg+HaSATnhU9fU1MW5zyZng5r+Mz3wFDa0NmAj3kYe7RFDXsWhAElY?=
 =?us-ascii?Q?lby6WbMKeVCNCgkSPWwbEaTUyIdGLLc3XYcixEQrxXWrHQHD6axrpm/3iHpj?=
 =?us-ascii?Q?EzwrF8pogO80qwfKCCbTjXHhamRvUl6+A4GFspYwMhV8qCVKXrMa4lglPil7?=
 =?us-ascii?Q?KreJJCnDl52pB00eNTcl0FaLv5pCLVO+mn+XRmR1m9n5Fy5YdRQ3uyKkVfJY?=
 =?us-ascii?Q?6im1BNdzvxI4oG3jZ8nbwSq/Hf9nbVJcMaKp2S9hyUlD4fgCVkSXBL4bzXUs?=
 =?us-ascii?Q?xoENUfMpLZMIqXISxTqFPsI0pS++eD787EL4+qfgXiux8RIZQw7WPqtoonIa?=
 =?us-ascii?Q?sPj52ksf8511u+F9858/VI0GLzKLxgnvvzUKX2WKLOsoBe1J4qqS/DyixOaA?=
 =?us-ascii?Q?u2Fwe5e8Xq9LhIKpsL1DwhEuxfd7aMa5wbr5HSz3zwX7ZDfqaeKJtqMwNOO1?=
 =?us-ascii?Q?MqrGtclSnToYt1uT27/WRgq14dz1oSHD2II0U7q0eRoRz2YF8LNALHujOjcb?=
 =?us-ascii?Q?uy/r7fVvtaHCKjILvq/JMuz1nTH3fJijy5h5PkvlnLER1Vwd6VRekigXtos5?=
 =?us-ascii?Q?WM7GAA0C/Me0ikjXtTTCuhSOn5lbvjlkrhK9r3+AoAcA9nw//wW2CKRQ0eeQ?=
 =?us-ascii?Q?lqFi+scGUEElEemCP7F8v1c9EiXopMkhmB3G1J6GS48tw1JTfrl1cT0j2b89?=
 =?us-ascii?Q?uHSXfpsfIwLe9bAvoYFbeB2DGV+2ou89RAVoMVJKFtFNrY00fxlH6co6Qt2L?=
 =?us-ascii?Q?PYfVlyMt8mxR3DBtFeTIFgmogSfUDPt6oy9xLShI9Pj6arNwP/xk6m3qN7h4?=
 =?us-ascii?Q?YxgqQ0PM7IkFPu0A0Hbkf4gxKyQGsR5JzbqB4yeQVrHQGc5QA8J8JMg3qmHC?=
 =?us-ascii?Q?nT2Bi8KADVz84XjJQLknmqkSBmYa9NUftl3vBrWHJPoefflawjzh7cDQBAVH?=
 =?us-ascii?Q?pkA+huWsqKWUl0k4HxfNlebq56aVXM7upDH+NvJVKwNPhs/+0GxFLTvROFzy?=
 =?us-ascii?Q?YcrjHpeAHBX8/DzdtBFzvDxmfkgXAIq1VZrBZsL0HCos2WWdIMY2TlyWLpfY?=
 =?us-ascii?Q?jKLeLXYEEznXAvaTfaOSJgTbpWlNxdgSof3WsSJhOfyyEIqq5PhtTsRe2KKY?=
 =?us-ascii?Q?ZYKeL39+qLkTxqGoDk0uu4uj0WDT/0zev7kQ3646bscJVeHY+2Z26ysOXUXG?=
 =?us-ascii?Q?vA+LZRTdBMBVYIS0L8+93yeXnPhqwHTYpJ+Pb4WUrgPkDmP2tJsT03FzH1ES?=
 =?us-ascii?Q?rDSATqIPgxPmnGB3pxmii4h9ByIDgv+XsVB/CkfYMm4Eis8nQAC+MbdL+Nw9?=
 =?us-ascii?Q?t5bYH5hGcTkTuvsGDIvbOc3Wc406E3O9lhdq7vjivHNpgPGF2Yesher9lgop?=
 =?us-ascii?Q?3L7s61UnT2UrJfr7cbGsR5YqgjzBryO2MkAe/QNTunZChlwUbiMkAMDiYujt?=
 =?us-ascii?Q?UbkziTxwrOENBhan39R701WGU7r5OlgnoXBfZfxl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e4b017f-5cb9-438d-aa2b-08dbfa94873a
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4845.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 22:00:03.5976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yvrQwmFnQoH7ocQ8rGu5qjUyhBCLCJpX0KguezTdHA9iRw7W7JUYMp/lNndVjzH0+XEsTcsBCWt2MzKIJmhcfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7569

From: Richard Zhu <hongxing.zhu@nxp.com>

Add i.MX95 PCIe "fsl,imx95-pcie" compatible string.
Add "atu" and "serdes" to reg-names.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---

Notes:
    Change from v2 to v3
    - Remove krzy's ACK tag
    - Add condition check for imx95, which required more reg-names then old
    platform, so need Krzy review again,
    
    Change from v1 to v2
    - add Krzy's ACK tag

 .../bindings/pci/fsl,imx6q-pcie.yaml           | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
index 81bbb8728f0f9..b8fcf8258f031 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
@@ -29,6 +29,7 @@ properties:
       - fsl,imx8mq-pcie
       - fsl,imx8mm-pcie
       - fsl,imx8mp-pcie
+      - fsl,imx95-pcie
 
   reg:
     items:
@@ -90,6 +91,22 @@ required:
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
+            - const: serdes
+            - const: atu
+            - const: config
+
   - if:
       properties:
         compatible:
@@ -111,6 +128,7 @@ allOf:
         compatible:
           enum:
             - fsl,imx8mq-pcie
+            - fsl,imx95-pcie
     then:
       properties:
         clocks:
-- 
2.34.1


