Return-Path: <linux-pci+bounces-1246-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FD281A849
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 22:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEABE1C20BBA
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 21:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C31B4AF89;
	Wed, 20 Dec 2023 21:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HHanbpkO"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2085.outbound.protection.outlook.com [40.107.15.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0F94CB5D;
	Wed, 20 Dec 2023 21:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WoOEp+P6kqiPGI0RP18UzIgi/WrYrfRxGKfLuITNy+Ivz0xKOPxJw/PWa4thQzrH2NTi/zNUJlTsz3fpRGlzS+IE8dPDfl4XO+Tk3V4YgSRFz3TkFggmUOI2yxOWy0M65/viFwz1L2M2lecK0EaSCebHY1oyx8HP8VLhQklunN6Sd8++jeaFaIboheIk4m8nXXDmRLtczIV7OJUHtvdWv+mTvGpc9IC5Q3jGUZNJ/l9jVA08oZgauiWTGJrnFk/zcmze/Zimg8ZW/oCcAUEdyLq0R5bcB8YPaO9EDwJdN3KKHzwvnkulX2RAXLxTRF99Qqvvep9PUnpHgrAYj34O2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWT2WFbB/46UWtR1XXax3RRljvqqZTdW/OyudF1A54U=;
 b=ajttabTFoCXylJEg353WRftuR2piohJZiQkmrj92EH/T/WbWemNyc6rxVbODzRmEbqlArTLZI/giDiz+shXNoSNhR2TM0/t0wz8Yq74j/gqDwNIpbvGKFsrSJedDjH6Z6x48K2ZICQkh0kW48noK9WVlAUJQ5kMLzBsmkP5QB9+9XE9CnTPCgRmXDiqT40m2PfvYYDQowugx6C0bWyAP7tRUvkJDXxv2HUNORUFKy2lt6U3094NCGL4rFIgznDEW6tdLvX7xyIGyqtlLh6x8D6MPN66qvVFqZNTNyQhr62C/rcGIduTnxb7MfGbfHweXU4oOIGF2uKeoJI4o4bYIsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWT2WFbB/46UWtR1XXax3RRljvqqZTdW/OyudF1A54U=;
 b=HHanbpkO4/5AfVvCK457WhQI5jLQKSSRVZRI+0kLMHdisR3h18Z/kp0sXd4g6GqA3nDqGt0FCW6sjLPtW4AEeuCptlVLjEdZWomq6DRK4rCJed7yGVPivIHDVxyCsM9tmV17tzb+JHh3nEV0pCG6TsKoTxyYTnhFOB4R7gG5Xqo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB8313.eurprd04.prod.outlook.com (2603:10a6:10:241::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20; Wed, 20 Dec
 2023 21:37:54 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.019; Wed, 20 Dec 2023
 21:37:54 +0000
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
Subject: [PATCH v5 14/16] PCI: imx6: Add epc_features in imx6_pcie_drvdata
Date: Wed, 20 Dec 2023 16:36:13 -0500
Message-Id: <20231220213615.1561528-15-Frank.Li@nxp.com>
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
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB9PR04MB8313:EE_
X-MS-Office365-Filtering-Correlation-Id: e0ae2d6c-a605-465f-3a71-08dc01a3ec92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CCbv8Pb+Mw3QoJ1Ypo+JMdXuZjVtr+5bGIot6a6htRYDiTpijQTDdq9eOPyKRX64VTDWJX7IzozjNy5Azl2dnh/QacqXxiOeKVaO27PaOIGiHhCitRzi93YL8/nLeOP1oiD0eVUXiWCIHXDh4Z7pSrTTDEK2oMmTerVG0nuo/t2G3yFQGiZXU06AKuPhC6b7a4n7ZYmphw9dj+sQTvV4A/WKJMWpCsVqB8w6UOd3+aoJ9WimsHMx5hHv8sdKUKX3Um3+fG6zhSOquWcXN9kw2XESenXGy7ZxmO1GKcYKJzJB9ikCRNVG+RS1EZxfdmPpvfSPOW7WN9MSkoskkmIjXdvww9s0OH3SY3jEZA3JzUrnuurTF3oz3XxTue1vyz1KDhukD1RRYGTk+hFj6XxO4CyoERP/1vQJQrURnUKgFaqmH1rxaguVKHw4WEuyzkU0+aikE3nnMOPOtC96tkYGmvMCjpQeEM3PL4RIq6P69WeKTviQDfa8hWdbHj9tIsvWbVkJTv1+7n7S/ftFvt/l3ztgH4jb2IAe/Jn+ZSz3Bl0OHknPuTf6BaihhwO9dlcoldsxK49y79CZRsQRVFXQrCoHavmrH2fcSPHf7bkgg31W32E1dBRAUJTN2kWOJHNY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(376002)(396003)(39860400002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(6486002)(6666004)(316002)(478600001)(6916009)(66476007)(66556008)(8676002)(8936002)(66946007)(83380400001)(6512007)(6506007)(52116002)(1076003)(26005)(2616005)(41300700001)(2906002)(7416002)(4326008)(5660300002)(86362001)(38350700005)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FlB1OyLDCz4/zlhWo0kVN2zz06vltAtXSRCLMHfMXG5sPHjBZSxrCAn4d1oi?=
 =?us-ascii?Q?kByv6vYy8gdZ+/zK+LJEgLdv8M4vLtmT9ZT84avuo1yvZmN7cE2KJRM99dvk?=
 =?us-ascii?Q?M84vdgbFI1Lr0H8vu7qdHs74IP9Y/KBTP/JZ4o1bJ7He5yXizZp9v8Omsx6V?=
 =?us-ascii?Q?E3s/4RzUChxlY2Ce6Gyhbr3Q52+B4M63uStGPyRB8TAhq0Xjz/UotNPEKK0t?=
 =?us-ascii?Q?FGGeKLovhGivAigpjN7ttSNLhieUQzc/jrY5EA3L8Y+9+naPgki6SqGKYGIP?=
 =?us-ascii?Q?iRARsWuR8vwXu3XbFNC5/Qg+V5QjtxTFT6dPqlzJlXVT6e0mnMg3PmrZuR2f?=
 =?us-ascii?Q?a5QfhKa6fvjBpPboNqyWgbKpE5uuzFsadKCHbS8b6rEoIvYLSE7rbrOwfTvS?=
 =?us-ascii?Q?5YXfpnKmzVgPKMskJqWUoZXE6ScZ1FfJ8gSArFLk6cbeFqJhnYiMqsrpc/mP?=
 =?us-ascii?Q?zNLTHFrqPvnQTw7QoPycWosv3W9XL5IgY3sZAVOxQH6f1o7FaNK5QGr2BFJr?=
 =?us-ascii?Q?HtLCEd5SVh/TvX8w3sBnmdxXobzi8qFRXDpLcb8n7vdfe5qS4mvVFqtA0/5N?=
 =?us-ascii?Q?71PSu6acnAE0dLEd6c+jQoH2DDDY7MvL/IM1ZQ2uUUeGNlx3GqZAJKu4v9yZ?=
 =?us-ascii?Q?0dcF4RqOHNLcUW9YpRaCVyJpPccMxLrvG5JJoqzRZ5tZv6nfyp18kWYJm2kB?=
 =?us-ascii?Q?Lq91Upb8ZrRO349vn6/6TzZiVydlh6yvH74L0fKiQMVkF+LzqmhNaps2ii8M?=
 =?us-ascii?Q?95jDAk9VGQPohIBGFumfpufZNn02PUu099e/PvE4IYYdIeJl+dIPHrS/8EKK?=
 =?us-ascii?Q?TVaH0dCjZiu+XmWa9wfYUenGpV+kVJXQX25kOL/NN3uItCWPlRNSLwsL7AlG?=
 =?us-ascii?Q?2QsgX2Y9YDcusJknqbqmXm4Ix+Bk4crbgqdJN9bHr7nLlS6c5JAhSsZvC/8Q?=
 =?us-ascii?Q?CVa5E9Ys2k/4sJhybx0qX/uHBFQqQ5vg/5YGaZQOKMfP4dCfu/9NKRzfGQEp?=
 =?us-ascii?Q?EFlpq3c+bo9QfoHW72yIZ4qca239wdhVXGGyr8WMGHJM9jiQppDaAavbG+LS?=
 =?us-ascii?Q?1ZryQNCWa2tPsI6MQElAuGppdhp1Z6L+owimr4CAoHMfwfGSftrdK0qygAHn?=
 =?us-ascii?Q?4WDXne2uSvOpFFEMHjFmZyhomPnHOYwFCCsROhIL50cVgyWBHinuLP69TYhR?=
 =?us-ascii?Q?tZmY/fcLUhJXkc7lRFsZwM+TKy9FihUMWLn3lNVc+fSV5n+AdZCc40c8ywrI?=
 =?us-ascii?Q?KXmcyTIu9Cm8KGAGzFcEO9XFqLQxsoS6IwWfJQbpm07p2pG43NCBc6IDaNrf?=
 =?us-ascii?Q?ILx3vOE1V71m8lJ20sdq8658XA3+tJRYguajki0zXAofId526auqZNLqv+P1?=
 =?us-ascii?Q?/5aDwwbCB/PN86nWVUTtdgQ5a+EECL8aa60c9eScfhp6qlfZr6nCA184cU8E?=
 =?us-ascii?Q?3yvuVjuN552nDbrFhwW+Q71zbQXIw28cE9epXrUb7cP4RPuto1jSTO2a+pn5?=
 =?us-ascii?Q?tFHuwM3mnnM9YDslkQM0d2c/AS8mctTRhJ+nHHXF+He5VYfDqQvPOBNcyZXL?=
 =?us-ascii?Q?mnf0R6AdWVViScedR3c=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ae2d6c-a605-465f-3a71-08dc01a3ec92
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4834.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 21:37:54.1574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Egczss+kXjHUBEOMlv8yXWOXcZ2EG82C4ehltohTUlemP6q0Yy7lolQeQcp6hPrIiRzeW7Ec13m4MBKy91MliQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8313

The i.MX EP exhibits variations in epc_features among different EP
configurations. This introduces the addition of epc_features in
imx6_pcie_drvdata to accommodate these differences. It's important to note
that there are no functional changes in this commit; instead, it lays the
groundwork for supporting i.MX95 EP functions.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v1 to v3
    - new patch at v3

 drivers/pci/controller/dwc/pci-imx6.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 4b2b9aafad1b4..6a58fd63a9dd2 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -104,6 +104,7 @@ struct imx6_pcie_drvdata {
 	const u32 ltssm_mask;
 	const u32 mode_off[IMX6_PCIE_MAX_INSTANCES];
 	const u32 mode_mask[IMX6_PCIE_MAX_INSTANCES];
+	const struct pci_epc_features *epc_features;
 	int (*init_phy)(struct imx6_pcie *pcie);
 };
 
@@ -1065,7 +1066,10 @@ static const struct pci_epc_features imx8m_pcie_epc_features = {
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
@@ -1530,6 +1534,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.mode_off[1] = IOMUXC_GPR12,
 		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
+		.epc_features = &imx8m_pcie_epc_features,
 		.init_phy = imx8mq_pcie_init_phy,
 	},
 	[IMX8MM_EP] = {
@@ -1540,6 +1545,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.clk_names = {"pcie_bus", "pcie", "pcie_aux"},
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.epc_features = &imx8m_pcie_epc_features,
 	},
 	[IMX8MP_EP] = {
 		.variant = IMX8MP_EP,
@@ -1549,6 +1555,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.clk_names = {"pcie_bus", "pcie", "pcie_aux"},
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.epc_features = &imx8m_pcie_epc_features,
 	},
 };
 
-- 
2.34.1


