Return-Path: <linux-pci+bounces-25211-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E00A79B7B
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 07:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16F313A4699
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 05:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D061A2C11;
	Thu,  3 Apr 2025 05:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DHEDx1SL"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2073.outbound.protection.outlook.com [40.107.21.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089231C7005;
	Thu,  3 Apr 2025 05:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743658897; cv=fail; b=P6UCmoIru5ng6catMoigYyILIZ6ertHm0aPEggEuJ2e7R3IgceZFwHR3Ynlnwj4ULyD1kLeAI0JItZedE+AwzGASIaETPY0XbmoVohwTYaj04WtsqaWcVDkcWGJ31b0t/pnn1XK/2VPmkeSmUU5DJVWKJUWKDpq4stqYRdixN40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743658897; c=relaxed/simple;
	bh=LNzkxDNZtbuyawzgLVxP0Op+mM60LMh5ya0gMBg74Fc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K3V3qO8tywyFZyYY5+/5gMq0j+jVLaTtrrGklgRdOGG7Lr4DsmvtOfak9VMwY+9WCx7N1brzw48JZSNPHmB/pgtY0buF3j/Pjs0hIZwsxboKT0DDtboJJ//t4/Z42W3jtnGLXIK6OhTfxQQnEaeTZu3LBL8Q+mWecLQEgwKRAWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DHEDx1SL; arc=fail smtp.client-ip=40.107.21.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kpg6tnkyAWGDLdrPs7Gok+cXJfQvO6BVGM6hWU6U97ciCq+w4FJoOCch/Gfak+g1exbGAS/cGOvq5fvCN9+hzJoqQa5Yy+7V+jhogk24yoMbDl2zBmI4Ywo2fWB8E67l8v0+RTk6gAUkJIIRrlMuD0qw39yocgPLFC0chR3Oa5VzXn6dNz3+THj3gQkwiO5sUeeGBPZeDyjjRvhYuhCf2N3GnKC7sL2aOyXnSdXDZ3ygvg6H04VjFf3QTLira+IWby1h/RejEZA0F6Yfd1Dv6HtfWz895+l8kRC53XDJFG+cN1KPWSAbVYMQP1PqkciWbnwU21Cs/5feW2wK4AR9JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7FVqzbUpnJP/6QYALcUHGeZ1JYt194NWiSde1H9Wz1E=;
 b=J+q4v05PafpMyp0SWvPEIzIaPeeVsnYhQ6O8+0h2Jof0Cs+rfveA1JvP9qzOHTcU56UJFn5aB4tXGNHZ/LElqj0FkB6QkxzY/ZmLG0KQJGgjaVxfn9gAuzZdjksNvYH/ZoLT58yhPgQR5ctJEHieZHN6r+P6Tek/KwMpz9WNsSIWRc8k02Tl8849p1Y6yUIhZ0IZMKkT8xIrvLe83gcPBTp8bbzQoRrVOfD9srM1J0Vp58kjTT65te1xVXf5UbnShwa8t2UaFe3jHNuXq5g+yAN4TOPTo5JCFdPwWn2mYQU2tTGRPhTFSoYCVz5xjCc7PgbArJDlG4/XxIDZVovpBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7FVqzbUpnJP/6QYALcUHGeZ1JYt194NWiSde1H9Wz1E=;
 b=DHEDx1SLL7bEfVcCw09tMWU35ay+il294UB5n9ulMlOTV+WK/IDyc0gcD6O9So8Rp6yHn30YC2PiBzrE1q3tEWGJ6WMqXrCNwSSijjdDTthINpt022pzwbfTIZNXlVJNeH8fVxWHsPZSV+qTenzz+Vlf4PFQpdl/M+h/m2IwkFBV0JUr5eA6utWkKifGYfXj//HK+IRmbpXNLA36VMR06buP1nnEme9IfzAWK2dLiCsWsBI/K0pww5tuRWQ2WkJyQ0gFUKRB9EERa1sfL52A6f+GWur4z1tFbW56CrCkzlEBbZtyN896MjrORoSFH9wBUFNH2kZdasCyHviShCm3dA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM9PR04MB8145.eurprd04.prod.outlook.com (2603:10a6:20b:3e1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.46; Thu, 3 Apr
 2025 05:41:33 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8583.041; Thu, 3 Apr 2025
 05:41:33 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	bhelgaas@google.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v4 7/7] PCI: imx6: Save and restore the LUT setting for i.MX95 PCIe
Date: Thu,  3 Apr 2025 13:39:37 +0800
Message-Id: <20250403053937.765849-8-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250403053937.765849-1-hongxing.zhu@nxp.com>
References: <20250403053937.765849-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0042.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::13) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|AM9PR04MB8145:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b5a03f8-0318-4fdf-4d65-08dd7272310d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t0Edi+GsuIB492pGKN/wQVpeDydDEC2RGsuWs1rrZQJbOiev3xtcMDUYorWT?=
 =?us-ascii?Q?8knxzWodBxLoA6d2xLDpMQv1pAaX5tSG1ukA5mPlU8HzNiEu2SaI145AmEdX?=
 =?us-ascii?Q?WU9y0g3/sJM1/idMpXHNU29E1oW4gxKd5QXoXxeusK4qokHZuaYKo14OFTRe?=
 =?us-ascii?Q?h6ICsA728eC5r5CiEqYDESIj9dUmGAWopajdrQ1T2SN8MNAfFk3XbClyZroz?=
 =?us-ascii?Q?pJHIkagYAQDIAW2RnDnECUoZ7asQDuFQul65bXtedaltbUegT74a6cTwxZse?=
 =?us-ascii?Q?zllAZ8PSmt1g90+A0mkWI4Zsx4XegYsiWGNlEvtQeONwnU4wG2vmBDaCWC16?=
 =?us-ascii?Q?2th1vNagHU9WdwS5B5g2imFol3f/uwODnOR60e5a3B2kwTimNK6lOMXWTm3+?=
 =?us-ascii?Q?tH8gjRVENuwpdel0TZf8FTpCVqrcatjNBqtKAabpIkG5HBvkF6GifzeTk2v6?=
 =?us-ascii?Q?Unm7jSRh/2m1tm7jhufmITp4xpeJBYLKxd0f9ASR/NH5qubp8eb3b8ceNKW2?=
 =?us-ascii?Q?8FQ4emB9hKgVwigYLPWbROtDNSvEUubhISb0XYkY4ENx5q73T5Cid2XqUYwK?=
 =?us-ascii?Q?zO2TpFQlfqcRBvT4NhJcmx7dVWQOgUWyfH1OYDk+hdTfBtFtGdxNoUyG0VoH?=
 =?us-ascii?Q?dMbvnF88Fzxh6OjhIDFNvHBl11pYsIRuIhDl0RaAIDQLxG0bUC8k52qq2qwL?=
 =?us-ascii?Q?XIp6ObipKFkzkPsYEVvlX/vnNRfXDRXOwBegJwodmlYEbV1adwFfereAqdH5?=
 =?us-ascii?Q?PezjLk2uVFbpRs0KshyKA4Sec+r0KT81gR8MUnfJFv0lotdjIq6Ac4LfY2Du?=
 =?us-ascii?Q?OGEYPWvbsyDvpo6SX4b3EBQo5ECkkYtD3QnjBsY6GKBZH39hyDUo4W/TB3+N?=
 =?us-ascii?Q?H+qJyih1SYC3XmQY/k6Vd8ZVXmPwmLHbZ8+LQ7+LJQAofsqcR0BPdhCyjHPs?=
 =?us-ascii?Q?O5d3X+/tgsRJq4OjHT+1LMybOj1xOw7byTUi9+6L9dSCLPlVn5wtTIYRInRO?=
 =?us-ascii?Q?8iw/COJMD6feblJqvVtP4iMRO8OkClsp+rmaHQcfhdbGYgI5S6LKjdEdiMPS?=
 =?us-ascii?Q?tK7StCW11V6cEW2I+zEZh2Wj5zO6+RPLre+iWik82dYG5wOPErhYjrVSCEct?=
 =?us-ascii?Q?IhtP9zVD4yNCWsPtA4FMDlTT1hFXR7xq/uW5urfwqpd+GFgnri/SvBePGU1p?=
 =?us-ascii?Q?k+EPQgbmszE92qy+G5De4HeIyemqn6rp3sQIAdU7MCizjAeRHkV3j9vugQ9p?=
 =?us-ascii?Q?YVHXMEg26WSwoN1T89gu6T32ZLFhmQGO7V0TmwhzBO62Uhji6+b6WGf0Q5ij?=
 =?us-ascii?Q?NEvqtSg5gSoHPla0jKnH8Ai1Lxhk82ODAXuZTXvex71F7PqSHFjPbJ3xaGcj?=
 =?us-ascii?Q?x20W3BBGp5Y8JwExjdookyFaCiYkZwpLiHC3nN3Zugyn6QIlFF/NCoBtPM9q?=
 =?us-ascii?Q?MU0vNCq8sSPBAT5lregvucSXlFWs91PK8RiPUETROWHaGtlf0GI5nw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ozb/NrKIOntZxjKD8Q3/9MN94S0Epl0JW9o5LqpXSmDCMz4PJ/dCqTe2aFwg?=
 =?us-ascii?Q?Ux/v2awO8dD2rlkOihrhy35OjIzKlhcMoJgjrl4iKhHxfPbhpMDZJkdlfuJs?=
 =?us-ascii?Q?cnh4FRYD8RrHge+vWY+XHw3LyU6kb/Fgy7LMIbVkpD6IM3lX0cAETgkS06xD?=
 =?us-ascii?Q?fgmbar5ax1icBzNHsbmoWqVsEWINlItxIMlXYLYgy/3pNlmn62sfgG6ENtoU?=
 =?us-ascii?Q?entmGWx4Crl+jo0vr2KsBZ1ZUPER7Yk+XVY/NY4TwMP3OncuS3Yrq5HMKusO?=
 =?us-ascii?Q?hEZeBZVLZ3Zqlz+6ED9i4U5qkNStqajOyxGDdfr4kphtOqMEsHvfSDHQ2AzX?=
 =?us-ascii?Q?IKJ1x4+MuEP2ljAu+k8Jgh+TlF5prTWT/i7SVWDBrqTKEy/0I4Os4gICbSWc?=
 =?us-ascii?Q?Fgx7ak6sjFQRj7j7qnI5gtZcCD7WsBsR2dVBF840ehHXbImg3CFDfkK0lLCJ?=
 =?us-ascii?Q?26dVwdlTv7uG9WHunQ9T/0+Ey+C9QXS41g+pPRuYGCozRCDnzIzYrmYLk4I/?=
 =?us-ascii?Q?WeR+PqME1FzTkxqUjSBqYxT4xpM/w17WNu7nNv6sI07XNzUsAQMi0kEYXc/Y?=
 =?us-ascii?Q?ssad4jEhWhUXYmFE2ooVZzBqxSd1g9L6Eo4R9LForzSFrCnypxXl8/MqDGZ5?=
 =?us-ascii?Q?ESnYpQKXoTnkuvmd5oisw6Rh/hEJKQ5hhRiMsJdaySE8j/hd5cPwPJZegggJ?=
 =?us-ascii?Q?SoxhCTKREpx2q1JT71EJqM3ko3znJRtPzDcECQ+2hQHzOtb7swbE9NisQ1M0?=
 =?us-ascii?Q?IHsWlnQL4YecvXDFSU9Dk0wSyi9aNIUC9jXmk0+HTHWCxuWV+oq0Qq2DCuwK?=
 =?us-ascii?Q?xXHqyZOkvUAwUw+F0PXbABokw4LfMrMW77b86V+MNQJRlIt6sSERyMcsfoFz?=
 =?us-ascii?Q?J49DsSQ622nwvYV2wll70kb9yPTOb73lS9rBUEahPzTn+lLH7ciYGlWk076R?=
 =?us-ascii?Q?Thd+ObSxlo5RylXA7mVR6AtbA9BEuHeC3+OUg0sKRuLt/zl12Ugd0LuQVtWH?=
 =?us-ascii?Q?zn3YX8SuVRZXzNy0Nh9nsIusWvGwHBAhcrFZxWW7VWgbJebZ3sbO+N3rlEuZ?=
 =?us-ascii?Q?GaJioBWMgQeoq9UlxrDq2LU6290ZSpR1inzS039xzUb2AEZkNG+zwT+YBPz1?=
 =?us-ascii?Q?RSIG7Atb6OEqVW8I3Ga43ezJTBDg7AlEQA45/FYOeORuaTqhjxO4VWMApCnJ?=
 =?us-ascii?Q?lWIWTryd/2aG1ZUIrZPxhov4UvRei/+teh8HrB5cxw+XJux7/aQAxzwVR3uK?=
 =?us-ascii?Q?b+pLfx8aN1CMJnqXDPwEqpiTN5Xctnm0vkvmLSUr4qhWblNGUrH95o3qAoAS?=
 =?us-ascii?Q?SFcPy0Ug+nfC10D/OMzy8vhJUZkbbtn4hgydXhJCpPauMirUGMt94hDEow3j?=
 =?us-ascii?Q?ps9rc+8EcwB0prxErSHqrYbSuJVB4frGFA8HmfrOwqgLJ2/uXfvcTOCJJD1v?=
 =?us-ascii?Q?GuZIUNBvMk2aR8bb9CohWFOnb+BXqyNeup+sqm34ckzFaYX7I0YoMv6jRB1v?=
 =?us-ascii?Q?TQXdZv97WGEecKuct8O27xbihOYJaGjmKa2djTxXv5J4yl+AYz110vGbisrG?=
 =?us-ascii?Q?T2EEM+pXPA4764Ii0DfQeBuoxEPGZ/NVaoFZqEV4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b5a03f8-0318-4fdf-4d65-08dd7272310d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 05:41:33.3456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sFYqN9whhLz653uRlkdU9rMkWYXqTtyDN/gEdNTNkrInJ0mJHviQY9Lm3d7hrZ1sWCgYB5JqIysYtEHCk2+KkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8145

The look up table(LUT) setting would be lost during PCIe suspend on i.MX95.

To ensure proper functionality after resume, save and restore the LUT
setting in suspend and resume operations.

Fixes: 9d6b1bd6b3c8 ("PCI: imx6: Add i.MX8MQ, i.MX8Q and i.MX95 PM support")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pci-imx6.c | 47 +++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 614ec3c79f9c..46864204146e 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -138,6 +138,11 @@ struct imx_pcie_drvdata {
 	const struct dw_pcie_host_ops *ops;
 };
 
+struct imx_lut_data {
+	u32 data1;
+	u32 data2;
+};
+
 struct imx_pcie {
 	struct dw_pcie		*pci;
 	struct gpio_desc	*reset_gpiod;
@@ -157,6 +162,8 @@ struct imx_pcie {
 	struct regulator	*vph;
 	void __iomem		*phy_base;
 
+	/* LUT data for pcie */
+	struct imx_lut_data	luts[IMX95_MAX_LUT];
 	/* power domain for pcie */
 	struct device		*pd_pcie;
 	/* power domain for pcie phy */
@@ -1498,6 +1505,42 @@ static void imx_pcie_msi_save_restore(struct imx_pcie *imx_pcie, bool save)
 	}
 }
 
+static void imx_pcie_lut_save(struct imx_pcie *imx_pcie)
+{
+	u32 data1, data2;
+	int i;
+
+	for (i = 0; i < IMX95_MAX_LUT; i++) {
+		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL,
+			     IMX95_PEO_LUT_RWA | i);
+		regmap_read(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, &data1);
+		regmap_read(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, &data2);
+		if (data1 & IMX95_PE0_LUT_VLD) {
+			imx_pcie->luts[i].data1 = data1;
+			imx_pcie->luts[i].data2 = data2;
+		} else {
+			imx_pcie->luts[i].data1 = 0;
+			imx_pcie->luts[i].data2 = 0;
+		}
+	}
+}
+
+static void imx_pcie_lut_restore(struct imx_pcie *imx_pcie)
+{
+	int i;
+
+	for (i = 0; i < IMX95_MAX_LUT; i++) {
+		if ((imx_pcie->luts[i].data1 & IMX95_PE0_LUT_VLD) == 0)
+			continue;
+
+		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1,
+			     imx_pcie->luts[i].data1);
+		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2,
+			     imx_pcie->luts[i].data2);
+		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, i);
+	}
+}
+
 static int imx_pcie_suspend_noirq(struct device *dev)
 {
 	struct imx_pcie *imx_pcie = dev_get_drvdata(dev);
@@ -1506,6 +1549,8 @@ static int imx_pcie_suspend_noirq(struct device *dev)
 		return 0;
 
 	imx_pcie_msi_save_restore(imx_pcie, true);
+	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT))
+		imx_pcie_lut_save(imx_pcie);
 	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_BROKEN_SUSPEND)) {
 		/*
 		 * The minimum for a workaround would be to set PERST# and to
@@ -1550,6 +1595,8 @@ static int imx_pcie_resume_noirq(struct device *dev)
 		if (ret)
 			return ret;
 	}
+	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT))
+		imx_pcie_lut_restore(imx_pcie);
 	imx_pcie_msi_save_restore(imx_pcie, false);
 
 	return 0;
-- 
2.37.1


