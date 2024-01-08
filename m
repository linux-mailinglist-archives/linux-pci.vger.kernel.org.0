Return-Path: <linux-pci+bounces-1847-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCC8827B7B
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 00:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55B7A1F240BD
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 23:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1169C58101;
	Mon,  8 Jan 2024 23:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="V/zNAWot"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2045.outbound.protection.outlook.com [40.107.104.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A8157896;
	Mon,  8 Jan 2024 23:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JqAgWu9nhnqZxXenpDMeAfrtELrUBDn2ZNn4zZR4gHiT0/fOrtJXxp5tpNvJtGirNdFSY8llWYk0uYiISoE7hOavVyFC3rZ5zqC65owstVDxRqg1u4TKDYIFHh40UB8GiBtcQp9RIYKVBrxLDhhyWEO7RfOgZsttEgnQNciz1DonToRfbVedPV43teb9tWk9JouOadj2mrHF8/agIZuwBz05QpnzJFgLoDJAK26ud1COXTl09xI6sv01tjbVL4v4DeLZEPu+GEvKlAz7hxiCiR+EFBhbf997+fPd8jRVIIFoFuj08dABje5PewvJ9orXHXiV2O9CmtQzstsvGJiwnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gV1LmGPihazQf9EcU7o32Xhyn4PgMLg/E0OO76MiU9w=;
 b=SCAGYX8EyGrhbsuzqwHoWAfEdRFQRI8YrX+aFfUBBXM1pxN2gtvazJ/ZS0du86BR6ZOa4VcRGrYPUTKjWD07YKxJFNUHvpcOho0Oh4gukGZld/aHDs7+eNue157OSqciitcqtUH+VET18RaD84civ3EEDL5iGiUQNLMAz2vXxyKCepJ2LYOcGBlBZ1PNHVuX6jFeGbqhSnrc4HICjit3eQJ86lKm6UwzUz9dTaIH/T5gSTQuNf2R/bU2SnZQaGFdP17N+I5gWtHhapDv+IDvRb4FjI4vhvEP6OxJgbcANJkYRt2GFkyIrCXgzauVlVDl5KwuGrrihYgBNjNEgCNJlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gV1LmGPihazQf9EcU7o32Xhyn4PgMLg/E0OO76MiU9w=;
 b=V/zNAWotZsXb4C5Y2GaERxosMyhabRG7R9X5p0m/HTzSm8iOFGQ/6vrPpPRgIyfsm2reHbwFg1Vr9LBAz/trPBoCxxyZmseXd8nPtPAGdAKnPumDu5risn07cctRbCfcNgz0g61J4Kib6hDTaQsudlvssjYK3sYcyH9sjKjIpqM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com (2603:10a6:20b:23f::5)
 by AS4PR04MB9338.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 23:22:54 +0000
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469]) by AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469%4]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 23:22:54 +0000
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
Subject: [PATCH v8 09/16] dt-bindings: imx6q-pcie: Clean up irrationality clocks check
Date: Mon,  8 Jan 2024 18:21:38 -0500
Message-Id: <20240108232145.2116455-10-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3bcf54a1-51bb-4746-5400-08dc10a0bdc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PZs95iD4hHPw7aRy3R6A7esnu6Pilb69eCeq1RhOpLjcpzO58e3FGPYsXsEnUY+/ylHe8EdhjTtxsAacKSX8J0VUEBL43cR7NvFwLPVP9lFtqoZ87BScjYcYGCeWbL+AK8tH3epj/wQeTh3HzlQkX0dTzdNltoWvVrQ3hJK9y/AWE/nCehficpfrrOQJWFlnIPv9QYZDil0syXQT6yod/5/Ujg9L6ZvxfvvEfySLncN7Jrfgs75HxUXluYS5eoyLpVse1HZkavGW9Lyyco1FJXHuaD/nRmV8bgf1Xx/NckDATcTa/EidbcIa4TkT6bRg3vVPsjhTVFXqoSOgyYRC1xayfIaflqf29Icote1RPHRVn40vVcRY3eP88915DFF5bodtor87t2O6T8XNy9Hj+6sALDoUwed3fe6r8+S5jyf7v0LVxvLYiv+VjdUliQh8DkQ14k2njWYZZg8AWyxj746kMW9NGU+kaQqezXR5We0iWaSTXWwgzrgKhjw0kSvIMDODg4ulcKxnf12AR9vquKBloIlZO0J9AZdADj/xBanTBZZ6vuO2FYPajZYXHLX4DzE4YXWZ/PKbKFA+KWXNz4LK3LWrBeEI5hzYrO+Q39GfHeEM3OsakwPbHG4Fu+CNoS5czpQN2N7I7imCKDk7+A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB7511.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(396003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(52116002)(6506007)(2616005)(1076003)(6666004)(6512007)(478600001)(26005)(6486002)(38100700002)(86362001)(38350700005)(36756003)(41300700001)(83380400001)(7416002)(66556008)(2906002)(316002)(66476007)(6916009)(4326008)(5660300002)(8676002)(8936002)(66946007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CmaqLk5ZQafKrxfLezXgCVbz/vrxS9heZSt4yHXC/0Chg+OtxM2gETi6g2LP?=
 =?us-ascii?Q?G7UliC6pqxiZ+ohmGPbdaTM4AB4lC1nvyaGVqRk4V829UF17HXkoYex+BhUJ?=
 =?us-ascii?Q?BuvBftk6L/joL+U2/zlrGy/towR/jmVOxlw1Ckx3TbRuT/xm3/OUkLxSEoAf?=
 =?us-ascii?Q?xRU/9QJI9hL8eXBttma9u0yrKfg7Tz3NO/oBhODpnuV7KqpwPR25yhhexox2?=
 =?us-ascii?Q?+Y87HUYD8hwJwRBAsAHuDcUK2oO8/ySA7RVhqKMMSLIVWaR85hb7NMyoEXA0?=
 =?us-ascii?Q?Obl9IBkfi0zWAaLW+Nl+m8qrTezmZjHSNyrpRGcBPUF6iZVvhzythGZD834i?=
 =?us-ascii?Q?YrRAoFfCzfTSQA++9/OlJGI8OYINlSJZ2C9P1JxjspoNA67BDPH4uEW7PhkF?=
 =?us-ascii?Q?oqMlG7wfnRBMAqQBDdVLjwfWvXVhGRQYyZjb5Bl4+faakR+tHEy89AXB0rvD?=
 =?us-ascii?Q?38vbYpDXbyhjkuow1SOM1zEU5nKikY4Qzfv6ez7daxBtTkJjrxeqW93rD4LG?=
 =?us-ascii?Q?3xUdRlOdyrp3dqjd5TvwnxEJ3KIwZWcqNRcBpVLtGc5aT+7f4awkK+zPRdHI?=
 =?us-ascii?Q?+lhstg9fjvsGxj/GYimw2P2UwkdE5mKhHhqLiBkMITcKuuPCYWj09ER7iUBl?=
 =?us-ascii?Q?Q+BrSg6G5kjPfNJCWT5Sigh92ZIPlWX8a1GC72Ye6uj8OTWomUzozDBioQNo?=
 =?us-ascii?Q?Bziqooxc/nAMPDdymNbsdUeflBUzCdIvjNGs7kLYvfh1kDBN0hDDludR3kiu?=
 =?us-ascii?Q?2gJTH35e3EMRXw6gP9VV/RvObGqaXfLv6DEkAYSeuIzNhy+IIdUIRutGDO0d?=
 =?us-ascii?Q?PuPb80rX+Zq/bb7G25TbrT6mTIW/L+9gFWydCT1N+A9J1DNmQludKLgfW8T+?=
 =?us-ascii?Q?NDaWf2ApvaGsHP0DGx15x+lbT0DO7bHqCklCXoMCTHdYcQuYX88G8+XnZk9j?=
 =?us-ascii?Q?YuecqX0IhkCRN/Q0wCZ0aqRExZv2JfaHyGudBNpkVz110jq8gWOIKZjwCUlU?=
 =?us-ascii?Q?HBWZW1xP5zCGMzQ+vLlINwpyxrzZtsHfduQspaxB/vnqV+CEZzPMvx0A7JbF?=
 =?us-ascii?Q?q0JdxO+UH0XF4v2L/P6fstaPAK9VDkkKjJ4WBFByMl2J20DVYXJs3QGScOy/?=
 =?us-ascii?Q?t6rsA4dyYDMxX+QArqjD8OuPl0xuAB1Tx8zkpQbQ8Nu48+nBIr4fJwunGYMW?=
 =?us-ascii?Q?GLzM7ZqgGX4S1gkR5kk8L9g1I43qjfFwKY0TCk/5DSIllAEt9kT3tywd49Gw?=
 =?us-ascii?Q?TObrkDR5U77KgAvOE1BCe/1KmP4Q1TfJA6OibiP7R9QN3oB5o0hzyEEg5pL+?=
 =?us-ascii?Q?Brmpy4Cz/1ODwSPNYW1fZBNQKHou7IHU9i7/eAvUCZYaR1e/EwMRh54wN0x4?=
 =?us-ascii?Q?c8ELvUJ94nvUwLNHFIs/ys1z/CbXpl9NDq7DCF7FZV2ef1Krt0h+XlK7a6ib?=
 =?us-ascii?Q?QlRnZgPYUOhY6grFoHWXpBbXZZnvZqL8zDqpWKHoCtAvU576kwOYYmB3Cyog?=
 =?us-ascii?Q?dlmmoe2rwyBcXZgJGYRNOuAp334wIg1vnu+NfreX8ExXw6vTWGHoLMdfLo9O?=
 =?us-ascii?Q?hp1pecW2Oq9b0dq/nVTN3EfuoL6TyaG5iXm6JS0B?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bcf54a1-51bb-4746-5400-08dc10a0bdc1
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB7511.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 23:22:54.5579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4YksJ/S88fafnWMy697v86vNefm01wMltJ5l8ugdC7BnJlWD4ufqlgHViPkFQYJpXB+OqHukwwzAhclHwytH0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9338

The bindings referencing this file already define these constraints for
each of the variants, so the if not: then: is redundant.

Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v7 to v8
    - add Manivannan Sadhasiva's Ack tag
    Change from v6 to v7
    - rewrite git commit message by using simple words
    Change from v5 to v6
    - rewrite git commit message and explain why remove it safely.
    - Add Rob's Ack
    Change from v1 to v4
    - new patch at v4

 .../bindings/pci/fsl,imx6q-pcie-common.yaml      | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
index 8f39b4e6e8491..a284a27c5e873 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
@@ -150,22 +150,6 @@ allOf:
             - {}
             - const: pcie_phy
             - const: pcie_aux
-  - if:
-      properties:
-        compatible:
-          not:
-            contains:
-              enum:
-                - fsl,imx6sx-pcie
-                - fsl,imx8mq-pcie
-                - fsl,imx6sx-pcie-ep
-                - fsl,imx8mq-pcie-ep
-    then:
-      properties:
-        clocks:
-          maxItems: 3
-        clock-names:
-          maxItems: 3
 
   - if:
       properties:
-- 
2.34.1


