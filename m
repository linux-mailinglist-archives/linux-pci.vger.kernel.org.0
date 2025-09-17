Return-Path: <linux-pci+bounces-36317-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38772B7C6D3
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 14:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36546167F1E
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 04:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DF727A462;
	Wed, 17 Sep 2025 04:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JghAKUYa"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010070.outbound.protection.outlook.com [52.101.84.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1AD277C8C;
	Wed, 17 Sep 2025 04:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758084827; cv=fail; b=ZXcGYVn8YDMt/T089CnZXUvsK7OI1Clc+DUO5GzI20haBi3tbeTCKIHYLRlJI1oS5jm1VTEigA3ekoi/rOr2rcwXw5x5QIwDCZXiyxQI+R/08o0/IFHYV+KTXpeAJqD+Xht8TSqyxbUTTetKKBc0QO9qo29RdcEyRd7sojMsWP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758084827; c=relaxed/simple;
	bh=CVSqeZOZ+hCMw+eBruzUPnz9M9lbtSm5LyHjkVMV0Ro=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YfGWatVDhplSyt6OEF9cOvaB9CnnyoUgjAaXx77aFqeFEBsNmJxW1BSHVi/Q75iMk37hozBb8cZ/HCMk2PQ1X2c11ZrB3O79XI2RCpcnqYTPNMbQdfn1h5zFLjDHCSMZoaDqPj3NcL7BFTnAQCTo45iOrIgr3p/wVLIgSAn1BIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JghAKUYa; arc=fail smtp.client-ip=52.101.84.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dVWN8Ygcx4zRHsk69KMXxuyGHSg9sUU2ZPP79tHKWtmPv6NIFoiz1SoPFWfO/WeUKT97ZePsEjOdifugLVigkDSkhYhj51Y7k0cCw4zDMwloD0/xRENLUkztyvFQy8sjPju7bVQYHlN13JvwUEYtG6CyoJZoJS/d0d2/YVpssrQwGi31Mojsm80uUu6l9OV2OL4YWFvUpsXKkEKLVauJ8I0zJ6xeL9rthYRjz0NLPKR6TtYQaa5O9ewKub91jNeTgB5x7M+qaKLNSYzfceKzl9jbtRZPHofHCBGTcAwshk15DwIWLp3twQOyXRyt+LE9tXBcyS6fqmYm7FXlf8cm3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=niuZ49cO1YK9TFQYMdhK6iSzrhQpKAKEZNsFsw6fq4s=;
 b=kf2WSuuI99mfrJOq2iEkEDHzRyQFudf2pxoV/omstqxXt4ul7SmuRdpPcx9j38+zeh3v/R4e6b7mIAkM5cHERmNmHyEjNQNSnW7FiLWuc8LoQWgcoESvFglxn/+tZlLawaPbHYjUgXVzrNPcwAYYMNxoSoPnh358wG6+mA3AkQw9MOvLtIq3nBXeuPOj5NuYKrwg0ewZvqCHf0KOFvqOJbLVX/uIbJcpYE/zLESH/YKWZyIrG/OxOggxLlsnvMy7xqu4W4ayreKQBWLsdMRCv4Uxr/eOb6cMCXOw5kPQRd6HTJpwaQmhnG+81Cca122NUrqMgoVnzSUVFmwQOeNwSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=niuZ49cO1YK9TFQYMdhK6iSzrhQpKAKEZNsFsw6fq4s=;
 b=JghAKUYaRVoG7Z5Jr11bbxbdD1Cl+h3QAWwjjysyaB/b4mNPvIdheFifY4+m/9O5PH6hiZ6+3JDcV0s1BExzF5rBS/YxRsgrJ8NlNvIlqbLwaqX0qbAC7MjZA522fVNtO8/Nlfs/AwNF6DK87ggWjmEybhLVP6TNH9Fd934HpeZRY6JPcbhUuU5A8zV66xtbccUa9Wid6EIlsopgTTAy06a958VoLL4Utb5dcTTQUCk7+H0uHGO0ORKQ9jKo4ByhpVp4NnXzkF+gNoL6uLJPnsCrggB6btaCVe9RxLNvYF1mBRqkXOgC+MYA7aWvloKuDQjMldNRt0d8GBbqQTlfxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by PA1PR04MB10098.eurprd04.prod.outlook.com (2603:10a6:102:45b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.12; Wed, 17 Sep
 2025 04:53:43 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%3]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 04:53:42 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	bhelgaas@google.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v6 3/3] PCI: imx6: Add external reference clock mode support
Date: Wed, 17 Sep 2025 12:52:38 +0800
Message-Id: <20250917045238.1048484-4-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250917045238.1048484-1-hongxing.zhu@nxp.com>
References: <20250917045238.1048484-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0172.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::28) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|PA1PR04MB10098:EE_
X-MS-Office365-Filtering-Correlation-Id: 31b71237-e071-4e76-2abf-08ddf5a62d14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|376014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RlHzaTa8iHemdbuAbmoZka4V0V66ZM6iGjIlmGXcbTZIyhza1JsIpkAls9J8?=
 =?us-ascii?Q?b/cNGgMt0sHOKC0mU0jPmmD9ll8DGsPYFsuG1L/j0Kwx0sM7395Ea0SQug4u?=
 =?us-ascii?Q?tfEeRVro+3OfhyYdNqDIzd6uRbpje8PM/vqTx3YTu7cyTpmZPP2zleTuHjW6?=
 =?us-ascii?Q?Ikn7EBuy6zDfnUMt17XTGNe/4C6+sk2CP2lLBytFvp2aUefh3ni87NmObOZI?=
 =?us-ascii?Q?cIdsxihjqzsHIJPVKk9Uen5JqFoFha47MEc0xZhcA6QiTDwLF1NDSsSc525M?=
 =?us-ascii?Q?bj1t3TUqjuCbl9QSEv1MS+UjUCCo2c4dh6eubMF4sAaC6GAIFte5T7ahc8WE?=
 =?us-ascii?Q?+Bt+B4kyIYFt0jZxn1dEzTjwWaHU3MU2W/1qgyN0KLTncxYlTfYO34ZwIAAq?=
 =?us-ascii?Q?8Q6Mv4zE6zBPOfbo+YFCEpGjh3rqfaB7w6eZt9IPciGCfL5d/kq6cJPgHPuV?=
 =?us-ascii?Q?yhwaQ8PzsPqOWMdc7LRoax87mISM4pPpNLUU3JNeL/kmo1NQmJPTp/xWlPzm?=
 =?us-ascii?Q?5ffrQ/1WDVRkpEO2sIiRsOJGpnyZ/7K+PRrm1Xvx38/cQfQk+gojBwlX/wZR?=
 =?us-ascii?Q?I9Hwf9ApsPC+0eZcQEsUXLcAj8FJaAVDQjP36M3/wTYe19QOTJqonej4bQx+?=
 =?us-ascii?Q?I6Oomi1hJyvjt/86JS5av48HyUpHgn/qikZ1//zREWxDxuTJdd2/0BmPo/n2?=
 =?us-ascii?Q?OcYsGielXp5UY9EIILhSP9wqWZTlDSNIpruBlDdqbxf6Tx8r++3uHPxIFIJ0?=
 =?us-ascii?Q?n467ub3RlrKfb7pUkCZ/7sU8MIKReyzBpDorJjUrJZTxqukSwWKujVv+Um+k?=
 =?us-ascii?Q?bAieKjqsvxZnK7+W3CeMvkEXKpgBYLzZA03leeH90mB60v95vHqqrYJ/XHEM?=
 =?us-ascii?Q?uvthnkmawkD2SaZRXeIwja7GUNe6mJzxFoVxhP+fwW5JVKdNPlxYFxDysB0k?=
 =?us-ascii?Q?woPfLOFS1RpNePON4sxgn+ViCM2LUFyI/lIj9RdYIkROl8uMbGeGJnvpZuJH?=
 =?us-ascii?Q?u25NN9pwhQr6mkuxIB+A8ORSlVX4aGYaL4X2psH3Zm2E+FZCKmhJ0iNHKOqU?=
 =?us-ascii?Q?TPixQh2C+DqQEBqWeLsoo8hVBxEFw87M7OvzThndqywv7GGmJhFB+YnELMSk?=
 =?us-ascii?Q?4Cef+xLQVHjaOyPMtIznTs+zNSnSE1909E+3xR2s6yWzWMffLPw8wHsVExDd?=
 =?us-ascii?Q?GvvR/PshjU3w7oSxoGjOkfnbiF68xi+88vdXOsd4+FThWMzQeqASA2/p5jKb?=
 =?us-ascii?Q?C7WFIosCWVVPWhcEL5EPNllN7QqHIn3102lTUnSKfJXAR0VB4s7gtoMWmF9k?=
 =?us-ascii?Q?hTp1Fo8YEppYcfiffAU4xZUu2STkrqdGSKPWslPrX63sL/ZvTWeDkLbED6OS?=
 =?us-ascii?Q?b+T88ePqLlr348WORYUn8m6LlUdDthRqu4izMqY8+zPsC8SlygH0XJLJnk2c?=
 =?us-ascii?Q?676aTQl4ydMbG3p0TIbkk1Gcb8VTj2taTaBRw4YXu9/uB+2i+lx9BFYlAUTf?=
 =?us-ascii?Q?JoQ0nZjZ1JuTxEs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(376014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ybP96fb/cBPjFfFNXaBvEaqx1p3kDn6YavtQjcCx39HMSZyWYNS5ZTHH+WxP?=
 =?us-ascii?Q?2Pz157zubW5EB2kNEwESfTuBajBi4MTD74iM/46yapEA8K5SZF+IhfTUQYzo?=
 =?us-ascii?Q?7+cdJIxd3EtZmzYWWjeOPAsZWesQEecK8LKm3DvfX1aANF/YdH2c7Q1QJIte?=
 =?us-ascii?Q?013A/xgTgmQKJX2pNfp4v3biGTPSQRROgNXmiRt0RXv1qBzmrdMMpmQZ5jJZ?=
 =?us-ascii?Q?9Gj5A0GdXBJq1bnTM3+MV8wg9rTOprgcgA7TSHhCCvM7jajKeMWbIQQIeBLQ?=
 =?us-ascii?Q?aD8YevieOtO8nOTDvHPfa0Mjm+G+HAHHJySTm9AMJiWnhKDyWXe1MjEaNd+0?=
 =?us-ascii?Q?bSuJ64sqiaJSQrrvTwQzrKiC3FtLE3GxeWXnCDn1QAhQczTFN9w8+JHsaiQF?=
 =?us-ascii?Q?12aFqmKeNYnVzwA1myu4Tew5+n+B/lxeCsRjsMEQIK2OelOxQWSzTUerK7Kz?=
 =?us-ascii?Q?fBk14OM1T5O62hvEC+WMN3Z5UMkGwD0L/LVPkZl6ekvbfiAJ31UOCdHTgeYv?=
 =?us-ascii?Q?LDpvhaIsg1I83tqDLgNPvN4DN2sb2nlAHfN4fTExlfzV8B93uyO8HzXGkpNx?=
 =?us-ascii?Q?6QEiN+GquhJWfrefSxXwD9t17wtysqzFv4zoffQf+usi3xW4nZtr5Ysk0Fym?=
 =?us-ascii?Q?5qUpFwHIgwAAmSb/+jtE4ym+QrhnqS6WrcsQkuERsoKeaP6veg35xw7GmoqV?=
 =?us-ascii?Q?FvqDqcdE7WhYQhxThP3gzesFjy2spMyAG5K5ZXbXD6aIC723bvhNdU0RHyOH?=
 =?us-ascii?Q?YUTICHA1aPdkPv0kawE9g0j3LmI+CRyB6BNJm46hzKfBsvi66dYcP+9yjRys?=
 =?us-ascii?Q?va+dlz3ZD6YypdBcnjmDZoKYCxFMAta+BXH4gV9U+EZjmUsKYdthNKJ+Sntx?=
 =?us-ascii?Q?sXt6H207bIEHDbGZh7R0Q4h3qW6dVXL8g9rAgSykC62VmLS4fRNY+x0avYms?=
 =?us-ascii?Q?3vW3IesyPKe1zdUkaGFHxM8FVyQ9e6pXE5p0WlzJWDA00bIcpeJzqaGSRlfq?=
 =?us-ascii?Q?Xnlw5DR1Cygoj9/kDIPxSSIfj+EJv1owCmH1d2GG8QoCH/TSCyZVPCjtR+lz?=
 =?us-ascii?Q?PN2kVs6ETQZYobWJ3PdnoK4fUM9jOIHskYPkcJLuBzKX1uaApvakCyRJpMu0?=
 =?us-ascii?Q?AT4YxQKJP/V9bcayP9ubJSWmgHRVrmOvz745t3aqyXOi9/21ycWYFzhQ1ESr?=
 =?us-ascii?Q?8NQTcRJ9G5WnbRPSrhB6ul64E/AywnUq/VMksYOqUQ5tYZdx+ThroWpbcgEH?=
 =?us-ascii?Q?faopNLDUXtah8pE+zNJOerpVX4QCi3vFXH0ZCfM52ZHp86b4xDBwVnUP+6Zk?=
 =?us-ascii?Q?X6lkxYOoP9KEHPeDtoEd5yneoMDJNx2A/0Yz1CLKsDyzC8IeVHVH8UWj++l0?=
 =?us-ascii?Q?ym3+YhsjY4ftptLGwNNo/Lm9MxNpWIJXdU16Bpmnb7LWFJezsktwkFZhSrSd?=
 =?us-ascii?Q?+H0CKsIqtl6NToKPstwC6j7oH/chbtIIjOXTM8vlhKhrNrcdjR6eA+I8VirM?=
 =?us-ascii?Q?cgsRF8As1fBJDeZU8T8/mzXkfYFaLlwr2W7jDmVwzZDj7XVObYAmFL3FomnA?=
 =?us-ascii?Q?ODCfibp82YV907leCiJpV/Z29ebRUkiuTpQRzDjn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31b71237-e071-4e76-2abf-08ddf5a62d14
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 04:53:42.8884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ceG9OSviO7OSpEWJlcUAk+zwFo8M7J7bLN7FB65WRdddXAigQoODscGbRS4dsM7dDpn1NpOsHrY2YnI+H0QJWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10098

i.MX95 PCIes have two reference clock inputs: one from internal PLL,
the other from off chip crystal oscillator. Use extref clock name to be
onhalf of the reference clock comes from external crystal oscillator.

Add external reference clock mode support when extref clock is present.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 80e48746bbaf..e2ca8b036253 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -149,6 +149,7 @@ struct imx_pcie {
 	struct gpio_desc	*reset_gpiod;
 	struct clk_bulk_data	*clks;
 	int			num_clks;
+	bool			enable_ext_refclk;
 	struct regmap		*iomuxc_gpr;
 	u16			msi_ctrl;
 	u32			controller_id;
@@ -241,6 +242,8 @@ static unsigned int imx_pcie_grp_offset(const struct imx_pcie *imx_pcie)
 
 static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
 {
+	bool ext = imx_pcie->enable_ext_refclk;
+
 	/*
 	 * ERR051624: The Controller Without Vaux Cannot Exit L23 Ready
 	 * Through Beacon or PERST# De-assertion
@@ -259,13 +262,12 @@ static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
 			IMX95_PCIE_PHY_CR_PARA_SEL,
 			IMX95_PCIE_PHY_CR_PARA_SEL);
 
-	regmap_update_bits(imx_pcie->iomuxc_gpr,
-			   IMX95_PCIE_PHY_GEN_CTRL,
-			   IMX95_PCIE_REF_USE_PAD, 0);
-	regmap_update_bits(imx_pcie->iomuxc_gpr,
-			   IMX95_PCIE_SS_RW_REG_0,
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_PHY_GEN_CTRL,
+			   ext ? IMX95_PCIE_REF_USE_PAD : 0,
+			   IMX95_PCIE_REF_USE_PAD);
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_0,
 			   IMX95_PCIE_REF_CLKEN,
-			   IMX95_PCIE_REF_CLKEN);
+			   ext ? 0 : IMX95_PCIE_REF_CLKEN);
 
 	return 0;
 }
@@ -1606,7 +1608,7 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	struct imx_pcie *imx_pcie;
 	struct device_node *np;
 	struct device_node *node = dev->of_node;
-	int ret, domain;
+	int i, ret, domain;
 	u16 val;
 
 	imx_pcie = devm_kzalloc(dev, sizeof(*imx_pcie), GFP_KERNEL);
@@ -1657,6 +1659,10 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	if (imx_pcie->num_clks < 0)
 		return dev_err_probe(dev, imx_pcie->num_clks,
 				     "failed to get clocks\n");
+	imx_pcie->enable_ext_refclk = false;
+	for (i = 0; i < imx_pcie->num_clks; i++)
+		if (strncmp(imx_pcie->clks[i].id, "extref", 6) == 0)
+			imx_pcie->enable_ext_refclk = true;
 
 	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_PHYDRV)) {
 		imx_pcie->phy = devm_phy_get(dev, "pcie-phy");
-- 
2.37.1


