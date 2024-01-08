Return-Path: <linux-pci+bounces-1852-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F40A827B8B
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 00:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EA36B2341D
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 23:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E721B56479;
	Mon,  8 Jan 2024 23:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y2CGO/oI"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2059.outbound.protection.outlook.com [40.107.8.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CB058AAF;
	Mon,  8 Jan 2024 23:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOUpjtHOUJcs/nOh2QDhIRhkKRjOkIfmA3l45PdhryT16kDci9flWeISB3+lfGycM3GMPvaVjfoh15nNeieb7MrcA6FMi2zKEFOz2txfUymCQJaqPQpwzfMJzYEOeyU+gSmOALVijKqCY8YYo5KnaTuX7fdCS5Lr5caU5uC+Dp1wT/sNeIYL45rXNsOgOeXiSc7t/Kk/P6/Y2Pm5QxqE5JHNRmOaZNlZ48uWDHXJk8CRLlkVPqAiX1oQI6bVLp1HPKTixuN52i87qtHyE/Qpu4hkFKDzPl6dwrWtv7FlT3s+OSuYGX3pyLLFuzTo7p/vvA+Utyb9QeuLroL0B+fY8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNhX4RRQTn5X8Wm4GXmBWpdCt/K2/H1fcxxALLTJjwY=;
 b=LYYEhBQqOJ/YvtbE4iMXoIO8YQ8/+Eg1+K8QX3QXdoSRi1Ky9ckck//OAuD2CdSAkQCCHnbhHFN5599arEBBUlHU8BP1MpH6c6tU2AKDT1emNMp0zs0KtqiLNfMzxV/gVpU/YysLztlkWkEAGepIfZtHlyjmEbF9czVmeQKunCNLA3M32N84IZQmq7CgxNEpeQmIxShiIOxQlOPNPDgrjcMxp/uf1H6Qfp1EhXET+cHoB5RDDzZpDb1OULYDCAHWznTV3o4MsiAF22lOlrN/+Kk20jjCRchi1GpjKicTMIzzb8CgkJfQ6ZFXn2pBr5PU6TOiQ4X/WwUfbgtD5eh/lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNhX4RRQTn5X8Wm4GXmBWpdCt/K2/H1fcxxALLTJjwY=;
 b=Y2CGO/oIgloMG6QnUC97qHusm1GTOtRrR3AV/wnLdTAeL2Eb6dcacguqrdV66HqMp0ytmzTUkha+Q9B5d+ev1B6eKUfzPqJjF8sOv5zKjikpEgwrC5Og1+XOnJYOXZFUkp3Toa8nz6a7NKBGtoDs4fBTIm0FkP43W/FEHU/DZ3s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com (2603:10a6:20b:23f::5)
 by AS4PR04MB9338.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 23:23:20 +0000
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469]) by AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469%4]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 23:23:20 +0000
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
Subject: [PATCH v8 14/16] PCI: imx6: Add epc_features in imx6_pcie_drvdata
Date: Mon,  8 Jan 2024 18:21:43 -0500
Message-Id: <20240108232145.2116455-15-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 48f2818b-75d4-45f4-dc0f-08dc10a0cd09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rt6pq07D38XiBgLtse7Dn3RaSgvGLkEZPEQ6IihpEUgkc6t/8zKEr8IWIdulmDQbXF2pX3bWNYyzavg7y1VcYif7bcOh7SVFJOG2Gu+jA9u/Mk94Jm9L57wqFyuZjS23rok0w8uydPoiJY3rs0xl7U3Tw90KTqElaJuz+H7n40CqAegWBVsQhwnp6u36I/6B/vWRCBZx51k4k7iVo85EfsfCX31mPp+iutq/VIgdz3P4+mqqfkLlYGevoSwcqhIVJoHofCuw6+LoGCfIv3g9ji5B8c2q/iT0KJ33+Qu9JecBiw5JDrzR00FEoWZtjhPXlZyCI+KfNeJazFSBP2kG6fW2HpEXoPBJd9AsdIwTFOxMMGILM2c8mUsaYq5JAJ17uINbCLFOpt9OdOSuAkEbNVtJertpwtVazSqWIuJNJKhsA3h31pAb/zdC/F2ZmWGqB6+S6pgsH18q8IFld4cxDk4hongJDwHQvzC2N/SytFWKs30o7XITREAuACplOzg+0PWnh/9F1lBdt1mHiJAAXeTouNj1jLZd2R0XvuIhycHiN6x91CNH9lKuN1UkuGDnMukkrA9ZDleW/ATZ18MWwCJ4yvxDfChTdElzzVYG5RiDtzpsjAfCc+rv35SALdth
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB7511.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(396003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(52116002)(6506007)(2616005)(1076003)(6666004)(6512007)(478600001)(26005)(6486002)(38100700002)(86362001)(38350700005)(36756003)(41300700001)(83380400001)(7416002)(66556008)(2906002)(316002)(66476007)(6916009)(4326008)(5660300002)(8676002)(8936002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cx+BYG/CuVgqc7fLXMPFdBjDXKYGdbuKcxtMIZettM/exC6ae6yJiTuUw3m7?=
 =?us-ascii?Q?VVeonXf5DX6K2XKgzMyUUbDKKBWVQG9eB/ETAyAtpog8cS0atoG0jbOA32A6?=
 =?us-ascii?Q?HCG3vr04AKM7Cq7dl+SmMcurqi4nAOrxUZxxe5yTG/PXGsBHNIwjpk/2kN7C?=
 =?us-ascii?Q?EJpmZXi7B4mNoFcyjRGNVhIRXeE4Tw83kyFNKs8fwapBhaPJ5JgfzZ3YF5tJ?=
 =?us-ascii?Q?JafXTkBnI6gCf+k/AHwH2PTxIDxy+Z0gV5xKUQBN6MRy6b5xYovfVAkgaNp2?=
 =?us-ascii?Q?dvD6rP6S7cQzYxIt9rCgfh4ZznbATZqYzcRfkiilFDQTBfVoMS3E/+4CvNSd?=
 =?us-ascii?Q?2J+YjGJxB8aftB6VvMmNQr+zVx5rgMXBcewphiTyeJX0xXqhxTS5KBI87ft+?=
 =?us-ascii?Q?CxYWd6m9YGXYkpjit7XodcmPnRbKyGjvKVZLdRKYSm6I9aspgNVJs3i/IJKj?=
 =?us-ascii?Q?kcOnouaIY05sD8RNj2wkImhd3T7rAagiyuvVs9ylKO4ykkcFLo6vEsEAmOCs?=
 =?us-ascii?Q?nr8kB04n0y+MZPjI+bgGYX2Unz44dh8rl9tK3NWrWsJyWVGnJl0C4IRXmOJS?=
 =?us-ascii?Q?rsu22IjM7VO2X9Ma7gr/D1Bq5LQ1OaHivtvN3niDUj23PrHwmLVPnXuXNmsE?=
 =?us-ascii?Q?V62DhOB7R6qJcpC5XWcZ6Jb00NLgfyn9kUby/Nagso1jU/H2zWqRdrr1nFBz?=
 =?us-ascii?Q?SvhnlzzEtfGVDFoBgOw9gq5YnM0KapOCDYQxjjRzEcxcO1c6TuqnoqMErU9F?=
 =?us-ascii?Q?rqdBtVsqCObXgChiWxPKlcbzL4ZvRtFIa1w61ai6nVdhw73Su/M9Ldj+gAIJ?=
 =?us-ascii?Q?YwWGPr/lutE4RYWRDdJ1pT7sPTCVx5oktmla+rCpVb5nIWiRKa9CKw81POCJ?=
 =?us-ascii?Q?yp5uY42R+F9P5Bv3IQlAc2MbffHP9SeI6KKCwGgNT1u6oFoJ3Ot1/88x0N5Q?=
 =?us-ascii?Q?k4fHfb9At6MZVoto3vyoO1kwZvH1TgZtsA2tqRoXA5nq76FW2Oz/SqSrDg8p?=
 =?us-ascii?Q?qwIa7g3MtfV9Y2a29M6XKahSkkkKoL+mnDKH86EY4WoiRBDV2eo7fVzoBNHw?=
 =?us-ascii?Q?OoeWN56AG6iYY33iVkoBRZp9+BNiwxTrK6Vg30Mf3FjSL82upeQMqh3YjpIf?=
 =?us-ascii?Q?sdUnNsOTAtYCqaEJ9sW3S3fYkjYD1x++6F8yOUcAfkEHKnfM9jZZLBOICDA8?=
 =?us-ascii?Q?oCW5LdJpUxqR9m4I67Agb9wpwvOokI+zGtPgqJa+amRH7Yvy1MxcsuMU63KX?=
 =?us-ascii?Q?ni5sybLDkaJOMM5XzYMAZqm5ZZ5uJPUDUD7lBUkGflWYm6zjodNUMZwJxg4u?=
 =?us-ascii?Q?MWreiFLQ5eBzHWk7VK9rhmJ1jCD0jN8RGUxIKfXWTtjadTOipeqhWDcrnwpd?=
 =?us-ascii?Q?UT+HHVjNydOVyM9Digkw5SAxUm37CMZXFItI47lrQdwhK70m+MlShodGhc8t?=
 =?us-ascii?Q?99hi2gad7P9/an/tde51MITWFN3SGjDkBNNV9XRiV36aVxisuJg4k1PdDZD9?=
 =?us-ascii?Q?cYT1FI/3zNyBHcZCW0Z1JrDPh9x1RxCrCOuEfl1hr1BOW/AeFWa92yu7fAYn?=
 =?us-ascii?Q?RmDB6XTqio4ryY9w49wt/OjUZVFfsk+HWsmiAZJu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48f2818b-75d4-45f4-dc0f-08dc10a0cd09
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB7511.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 23:23:20.2099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jop1WxcGZUtASie/Yk+lCXXC2Gw7tbwBHfVK+Ood4CXPvuQ3mLh7iclxmnppmCcQeiH+5i5jCz55H0UApeBFxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9338

The i.MX EP exhibits variations in epc_features among different EP
configurations. This introduces the addition of epc_features in
imx6_pcie_drvdata to accommodate these differences. It's important to note
that there are no functional changes in this commit; instead, it lays the
groundwork for supporting i.MX95 EP functions.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v7 to v8
    - Added  Manivannan Sadhasivam's review tag
    Change from v6 to v7
    - none
    Change from v5 to v6
    - add missed maxitems.
    - add comments about reuse linux,pci-domain as controller id.
    linux,pci-domain have not defined at PCI endpoint side.
    
    Change from v1 to v3
    - new patch at v3

 drivers/pci/controller/dwc/pci-imx6.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 1741af88040be..3f474d4749dce 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -105,6 +105,7 @@ struct imx6_pcie_drvdata {
 	const u32 ltssm_mask;
 	const u32 mode_off[IMX6_PCIE_MAX_INSTANCES];
 	const u32 mode_mask[IMX6_PCIE_MAX_INSTANCES];
+	const struct pci_epc_features *epc_features;
 	int (*init_phy)(struct imx6_pcie *pcie);
 };
 
@@ -1052,7 +1053,10 @@ static const struct pci_epc_features imx8m_pcie_epc_features = {
 static const struct pci_epc_features*
 imx6_pcie_ep_get_features(struct dw_pcie_ep *ep)
 {
-	return &imx8m_pcie_epc_features;
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pci);
+
+	return imx6_pcie->drvdata->epc_features;
 }
 
 static const struct dw_pcie_ep_ops pcie_ep_ops = {
@@ -1538,6 +1542,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.mode_off[1] = IOMUXC_GPR12,
 		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
+		.epc_features = &imx8m_pcie_epc_features,
 		.init_phy = imx8mq_pcie_init_phy,
 	},
 	[IMX8MM_EP] = {
@@ -1549,6 +1554,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.clks_cnt = ARRAY_SIZE(imx6_3clks_bus_pcie_aux),
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.epc_features = &imx8m_pcie_epc_features,
 	},
 	[IMX8MP_EP] = {
 		.variant = IMX8MP_EP,
@@ -1559,6 +1565,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.clks_cnt = ARRAY_SIZE(imx6_3clks_bus_pcie_aux),
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.epc_features = &imx8m_pcie_epc_features,
 	},
 };
 
-- 
2.34.1


