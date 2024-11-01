Return-Path: <linux-pci+bounces-15778-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 598E79B8B92
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 07:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96804B22E1E
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 06:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC93155A59;
	Fri,  1 Nov 2024 06:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="O2YIUVuH"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2073.outbound.protection.outlook.com [40.107.21.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC801531EF;
	Fri,  1 Nov 2024 06:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730444197; cv=fail; b=SvbA3b1AuyORlUtJBsw1KuOOnbPF5FLDv46kYR+pBd4uPKCmMFItmj68Ra4Kh9HuDzTu9J1as1esnI/5mGXcIUNGLoWsfaD72s4vYvOYgXUpUndDOQdNct5tu9Ma3L7ztDrCJg36EdWSx1AXZnOVAJiaKUZmh6KL+Z/cPbQjid8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730444197; c=relaxed/simple;
	bh=7gGusH9mfXKrCYg3B/6BFA5pgOddNL1+GViWL52ZtGc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iPVxu20SuOSWEqlQ/e6P37CMRSVVyFzy9w9Mwp+hta1AtUm6fZD3TDyjRIIa59xJT3IJOLpATvIw6QiycjbwHiKCZvLn7x0zX0mWmynNd0R8Z4Rf8JN2uanaFNATow2A8Oe6o2Fv4WwbG/KCtLEjNtdmyMngcdwe1plTSsYVR8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=O2YIUVuH; arc=fail smtp.client-ip=40.107.21.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qIz7ZVfqtSRpYr5XZG/vKLsYcVftZlKgJLcY1xQz9eSsW/Ifdq8prnNzzMKlC/9qWbUnrhIpbbQr911se5cYrGAsFk0JULT7HveEqbcspQBS24qFq3IXuhdkfgjaMrU5ajB0q6DueTCoe9Yn0Ts7yhCg45AVHLqKibPTnvbTW+aF39bDn8bJ6jmCKPyK7QW+90Gqhy/EgkNrDw8Nw17uSwCh7ScRcVTq3+PMPnlGNx37eMaxnfeDrS55r3yiL/Flbsg5oXPcnJuXsziL0PbPzIzYj8KVN58ZS2Z17pC8WYvi/l+0/cGW9BfvqSW2n8HdKvqd2Y3C69sn7wv7foMFxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3sL1r5PmjJpnf6mp1AfaQeR0TiNGX3bScEnLTP2+Uo=;
 b=ER+lSBF3r3aCMTgyKiAEEiEDLMTxhcArbgpKjyOK5r35dNquyg2aWJNJi9aD09/VVxy2Ku53r7jn3I8NxVve8qyrCtQw0QJin4ZdU5SESm66X6N/rM/wdkgr1ZZASX8lXF7jdtR2YQ9BhqUV1V7HxiqY6ezUx4QsAKOvN3aMFfVgdAGYVI6mEfvGVz0b0rbTF/AJogsvE9kCxrua/ZMJXNNgLXvJxFyJ3Ordafo23BY5WbVapfKvFqI1ncolY+fSNvydMqZ62FdA8kiQUIlrYQ5UelvLrCNcTyHoG147bYcusXuEWcj09WJVKk8f/INvnV79XAolsy8ZO4SU1hS+Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3sL1r5PmjJpnf6mp1AfaQeR0TiNGX3bScEnLTP2+Uo=;
 b=O2YIUVuHjNJo/dwhBnaMvXjoWLjfN6ngTIBDjeiQji2fjyJ357qgcYlqtvQzMrlEDsRV6D1YRE8lSC332z6KZa+grD27PZDN43kguNkWVXacozhjxxAsbPmwgiDXFx63AoJAfSv6Dqswt0qFyH2O605+raZY06D/HcH0BhCR01AGJdRXQ0mM779B3SCdx3FDpDPfBU/pj1HhOxs6eeEhDJeqnksjSonf3tX1a82d7S0fdCrwDJP3T9qgG6a6ByWuuK/2HwnyDj1WonfWeiQP7CFRO9neloo0/0qMqohpXkdRUBhAML9xoIgk2kcxxYV18Kt4tEtCSO4uejst3BlCww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PAXPR04MB8573.eurprd04.prod.outlook.com (2603:10a6:102:214::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Fri, 1 Nov
 2024 06:56:32 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%6]) with mapi id 15.20.8114.015; Fri, 1 Nov 2024
 06:56:32 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: l.stach@pengutronix.de,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	frank.li@nxp.com,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: imx@lists.linux.dev,
	kernel@pengutronix.de,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v6 04/10] PCI: imx6: Correct controller_id generation logic for i.MX7D
Date: Fri,  1 Nov 2024 15:06:04 +0800
Message-Id: <20241101070610.1267391-5-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20241101070610.1267391-1-hongxing.zhu@nxp.com>
References: <20241101070610.1267391-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::10) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|PAXPR04MB8573:EE_
X-MS-Office365-Filtering-Correlation-Id: 63c4728a-7d60-4744-5d19-08dcfa425157
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|7416014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WBxNbgvDm9eQHwE5xIbELQBVo52tXjXUOQQtFictzAhyMH3GCLz36us9kcyw?=
 =?us-ascii?Q?XGvVHlXS1ovANgLRVj287aYtKtNzKj5j4XdZQaxn/RA02mYv/YhH/XVFkhPe?=
 =?us-ascii?Q?OtsYznSADY9Xg/1DuiAwJW0adiV9tkvgMaFpiWFCTgdq77Dqcdc8Zb4Otako?=
 =?us-ascii?Q?CecVk1y7aH+hHs62gONuxAKBG0v/SHd8dwmGMGqlPKW/qwaXeXqYNirmwDd4?=
 =?us-ascii?Q?FNQCYI+2HSX7bCpkGz5vdWjAQ9vtWQ5Wt5m4F/zuxziMAjoRmGrd+U1I7RPj?=
 =?us-ascii?Q?WLjoux4rqufrzOX4Rr1UZeidjQ7GNKSXg99fQ6crbUHL+lN6lk6qyLk2/PSH?=
 =?us-ascii?Q?W5KjHBQXXRvdMGZa7MngA73Dw7/75pEV3/zXgaRqe7c/vJkd0hdpdEvZtMGh?=
 =?us-ascii?Q?EJLmqV5E25xkeZr969R6g2F5lFr4fs8T4D2Tm+lwWua4f0mw8xVxCLJtXTzF?=
 =?us-ascii?Q?ln0CDk6rIpT2L8ow2h50OtVmeHbRxEJ/p38LqxRnTdV4nF/7gDMHJX0tCoBJ?=
 =?us-ascii?Q?pX9gJE8DATXwe703ThhfiwHJmzO+vGtFCxayINBfvFpTuoy8kdfZbWiBYtfU?=
 =?us-ascii?Q?Bu83+NUwm0z9zQ0fa1/6ZjWpUoie3Ug7SHslvgta2f70PR05ceEN9vNOoNBm?=
 =?us-ascii?Q?H0/MkbOseiKHcL321JJlaWjT3gmndeoFL6+R8702qh/kBtv/dkVoMqRQ7Ybs?=
 =?us-ascii?Q?wETulhtLichG0gZSmx7jKHWLZdR9r8cDAjImOsswHy38zPbdkPMxUAapQ4kU?=
 =?us-ascii?Q?DidQfBAwm3IJNKgvLgh5p5lkwhxcl36ppRPEHQI8o/anwme/fOLNKAs+Mbwk?=
 =?us-ascii?Q?ME1pqamo6Qq4k5ENmw+VgEj8gqyLqxB0G22KbNmjXubWqiDD665XoKwkivJm?=
 =?us-ascii?Q?HNfnUomaTHwnkQEJH8HrHv5wFderFx1dDHvRnMWv0hyZAiJ41uz1Wu/5Yzzb?=
 =?us-ascii?Q?z/jYtMm3mK0arDkoSc2pvNDkU6fLIGtMEWgKI8yORmWZPIsxknHMkH3CEicv?=
 =?us-ascii?Q?GArkpmY7GAcjVXifxyROJ0hNtteJ9+1kqUAoeg4IIDaMNqj86N3FgPxzxaHO?=
 =?us-ascii?Q?shZTjoT7DkDJGWzXre9utpJDvjcJb7eSmET9hW7AJMML2LH6KPUqVkzfUChp?=
 =?us-ascii?Q?Tn/Mq3EgmmCQvQ/Oq3vdK01ClFxVP/HM4GhMpLwTjy/RMZY3z7xPZnSti7Hp?=
 =?us-ascii?Q?ZDElZu1ngBqDrCSR/QomIM8ygw7Y/woJxVj+i2CwaXnIqN9VJIWjG3qNFM6Z?=
 =?us-ascii?Q?09FqeXSw8uejJg1lYVs6W2UeF4nMg8rFjJatBerL0ugEqQjmzPTr1fsppzcA?=
 =?us-ascii?Q?HsVV9utKOhkd8AwG+SbiaZjoCFC4JkYkMKiVcH3eiyDju7F6LbzRxzhKBKC6?=
 =?us-ascii?Q?kQ4h32qI6fyXaV1i+0btuHwPjTSL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2l+1viStw/9GXSeSI9WxTgyrCR/4rDOSnIDYKoEBHluRuXdTeFUNxJC9vldG?=
 =?us-ascii?Q?PzkcK/9CLmK0MY0pO2EbHGlo8WThVJt1ha7aUmfYSEi3IDSe/P9RWoEpMi9/?=
 =?us-ascii?Q?liny8sJve8rGYVC4eNkNRHdcZyaQ7/yw4z2QulGwAYVzQevs1SZg3WLHRouI?=
 =?us-ascii?Q?IJGL7H9+786xGumFf5Mwz7dMkyDesXEqKD0mNTGcVwqFJwKXJw/KMrqqpr9O?=
 =?us-ascii?Q?2a2L73GiWW1WCvTY1mvHP2lbc4OVXl5OO/OdMr/aOvSyBDjzsbhGYGzGC3hI?=
 =?us-ascii?Q?8/3EEMTS3eUhBA6/9AmGRXX+5OK5YrKZM3gJR8hEABKT42gIxqUM/9JgOigD?=
 =?us-ascii?Q?RJjD4dp2fuhhqRQ0sgPnWctlGG+bLz1CWriKf6QV3i8TVqyt7c1bHbaeJrRj?=
 =?us-ascii?Q?YFKsaMOCl6dMQlNVofXgWl4Pzd08uahnpUGkT1cEBX12WqDf5I87eDA8IgEz?=
 =?us-ascii?Q?Ik5r797jRSamgDQvmvXlhYPUpQuEZXFGps8HYyJ2vVfjNoDj069JgOsCF4/w?=
 =?us-ascii?Q?+pXHKgMgA0tctLFwk7H11A4LqcVjiljSE6NIPcrb6Roq4E88zmPeP6Uo2V1l?=
 =?us-ascii?Q?AyiCpcL5zO6J48pgVD2FJs/lLGmYTu3+zWYoI3BN4f/f4JGXmuPJZA/OkF1/?=
 =?us-ascii?Q?z0E9fPR/KW1MPSYtKDS5BfS3hpJyV52bH6TJCXLgJ5clkQHbZ5dqhvIbO+iH?=
 =?us-ascii?Q?vGg9nuUBFqlaCFK2iPsOP05xcP5W2NR13OqbvyDT35V/k6ADfLFAtNmsw3F3?=
 =?us-ascii?Q?PUrHKM/5Ncbjn1kGRs+wMzw5OdbKJh1DR6EWreCgFHnF2IGi/Up2aPvtXyAj?=
 =?us-ascii?Q?NPVNPaV/VHkL0WmUqHEJDLam1ls1wf3w3WS/GqFgwQr0ECgmDNJqAtG3rtSk?=
 =?us-ascii?Q?SZGgw+J0cNNJEZ9mect+eTmrbfOXDsWCmr0ksPmbuEitXPojDLzzZDh8nYQU?=
 =?us-ascii?Q?OYc7qhggrcanUt7HyfvoGNZC9X6MiXFT2lplqrqb196WjNR5Dj8L8NpclJev?=
 =?us-ascii?Q?y1G1OZiPIBa+447wnYsnevj0jgc07nR3pRMRdiJLmDwVearbVoVlWBaYrs5L?=
 =?us-ascii?Q?FBj5Ha/nkRnqI4u2BxlDkV8BC5Xpjr87zjX2Du43zkko1lL1n88C4MqB4pZh?=
 =?us-ascii?Q?+lsQ5NwViup2E7BpHNPRGRKzjzjFZIH3P608jHl1WH4Wgz0V+2CmC6J2tJEC?=
 =?us-ascii?Q?fHLeQg2XP7Qo8OwunIftXjNandd1xiGh2uJHU/bKg1oX+BfehCPCOzuQgcaz?=
 =?us-ascii?Q?o7JlhijT+2AIbUlJnMQ9gGJU7BTs1OTI6aIa9m8m4iF06hL69+hyH9SzdSlw?=
 =?us-ascii?Q?a9QBw6CzcqfLJl5lnWE8GI41a7fC6QxQF38UxC3YoXCzK7TWuMmSUv22Twb0?=
 =?us-ascii?Q?15n5LQtPbElPOjr8DH+q+EXxct2EkaZanvQwp0irZPFcgqowO/unRjUUQGdV?=
 =?us-ascii?Q?fMyK62t0IbaOI6O1tEBI745uSe54EAZBQepP7Tg2D67bphcR564IsYmAZmqD?=
 =?us-ascii?Q?LAXbmnJF69o7MPC6RXSWTWKdNuaYNrh6XDy4h2wKPFRlNRLG4/x0GDSRY5p6?=
 =?us-ascii?Q?E8QnTGP3NZGbqS3DT2Hfy9DDiVkqJ3ZID5drep7t?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63c4728a-7d60-4744-5d19-08dcfa425157
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 06:56:32.2581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SwLWsl2JEdKAdXBUb5tS6bNfvWcQG+JJHGekjAZA5EZKvmSsaGo2i9+v3zFk5GWfw0z6hfARCtStqNlLkJv7Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8573

i.MX7D only has one PCIe controller, so controller_id should always be 0.
The previous code is incorrect although yielding the correct result. Fix by
removing IMX7D from the switch case branch.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
"This is just *wrong*. You cannot hardcode the MMIO address in the driver.
Even though this code is old, you should fix it instead of building on top
of it.

- Mani"

IMX7D here is wrong athough check IMX8MQ_PCIE2_BASE_ADDR is not good
method. Previously try to use 'linux,pci-domain' to replace this check
logic. Need more discussion to improve it and keep old compatiblity.
Let's fix this code error firstly.
---
 drivers/pci/controller/dwc/pci-imx6.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 462decd1d589..996333e9017d 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1342,7 +1342,6 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	switch (imx_pcie->drvdata->variant) {
 	case IMX8MQ:
 	case IMX8MQ_EP:
-	case IMX7D:
 		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
 			imx_pcie->controller_id = 1;
 		break;
-- 
2.37.1


