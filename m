Return-Path: <linux-pci+bounces-34356-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6B5B2D5BE
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 10:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83FE2A00874
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 08:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23882D9499;
	Wed, 20 Aug 2025 08:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Me/ylsjZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011007.outbound.protection.outlook.com [52.101.70.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865D62D94A8;
	Wed, 20 Aug 2025 08:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755677495; cv=fail; b=bu3gbAAYWpf/ajUd3Oh9dq7jSPyihG311BMsT2sFV6WaNWby04t1wL74qIJCK3cx6I+XGQs2f+FiZRgdLW6Zeur76eUsuixMBUNUgzy9Urq+VTmSY9gmaI/rNZY/1SJu8aELOk4WV1xNh00UuUibqgT9ob8m5f2ey7AW4XMg63o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755677495; c=relaxed/simple;
	bh=QNT1OlvD0kw+dXucSrKZo13OA2rkP4U02vVY7mK1b/E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NNiiXF87xP0Halpytbrll2Kc29rfL76k6ytdXkeGF1+YsrhwkqvEd7DabdXFSlk1kvbvtYhpnqq3vNIGXL3Hi0ErM/UUkyBaWfRsMKnb30IyknQXbPu1OjAn2rEjLokUH17LoexN/rlHhiJR+10qDR0UdLk5xyi7GX9QUf8HWhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Me/ylsjZ; arc=fail smtp.client-ip=52.101.70.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k2yJ3TTAXjmguKLfjrovGtIz7QOHiklCvZghpSgJiNt4rCT1sMSNlgAn99FOL+7XLXhI+xh7V2612KhHUa5Th+Hc1/24H6y+ZMpKagXnrI3c7Oj9auxpowTT4kAeDIdvNu1ID1jrfJ4Et3f6/ECsMTEeWu8B7vdF+DAi19Trq2ImHxRKTGEg0OyqBq9HlU1myOyS4/R849UUPyjUj9L5WB65gJlz5FINNNUEyz45VKp4K/WzDhmFMmzMO8uce23ejxpMqXn4HgKExfoTVs9owIxN0JAHjJI+a0lDcVBPP29lo/KHjZJ3wpohK5KuL4Imj1gxxh2MGhNRXC1JdR90ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BlL83dsduvc9OHoSBY6TQSuzVtjpy9MB28z5fKUPkPE=;
 b=VRot4rKcCX1cpYJQvF2myD0HznFbVUS1gEu+X+uWtn+1Twqphkhlix7PkgtLqBizBwOVASzYNfOzp7HHt5sRZgSFY30jDdijkIEnoqv0WfhOMcOyu7pwu95BRmcD74No3bLfweYP657UQRKSc4ZpLC4Jz5QVd5MvK9ZgZKxcCoOwJBP0Ts6QjjCD2PNyYnOLB/eh1rpWjCiVTIVxxaeiB24it5HyBBcnUcOrxaO4RovFb1O7BxjthCe/DERjRCpfvWO7AbvgyiLldO/UkKv3PvyQPKqq1yDnzMZaRlwXlHq7yj64rGa5iEyoNa9r1AMsgP9MmYudtQH/3BA0Fhj/IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BlL83dsduvc9OHoSBY6TQSuzVtjpy9MB28z5fKUPkPE=;
 b=Me/ylsjZAVnK5l3pz0fjBuKoeS9rq9EH3r8zDCmC7yKU6iQePLcdCNGHupBH7LT2oyeafI0GOx8NUYI/GO3U3V8BhXy81K0k+8fh5w/J4f2XZg0H0cvkd04Ydd5EqTzLy83qGY8U1O18T9NmXlhgpCavv8ZtGwzm7TWTR7n6ebG6JtAFXdcHYsVh58MBR+xUILKbOiP9k9ITKYhBX077IFr5+2ebTHjU4h1ypUyBmGEd0jRjIjGhbusUo40vLHpZsiEzJQKfD4iAuMAfBKjRSaCGbgSAE4H6i6UDpF1txkkXRwGZiVaUFsg+CP+VXrp/U+mFeTgOdLxUZCekwIbzkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by AM0PR04MB6913.eurprd04.prod.outlook.com (2603:10a6:208:184::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Wed, 20 Aug
 2025 08:11:31 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%4]) with mapi id 15.20.9052.013; Wed, 20 Aug 2025
 08:11:30 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
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
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v1 1/2] PCI: dwc: Invoke post_init in dw_pcie_resume_noirq()
Date: Wed, 20 Aug 2025 16:10:47 +0800
Message-Id: <20250820081048.2279057-2-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250820081048.2279057-1-hongxing.zhu@nxp.com>
References: <20250820081048.2279057-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::16) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|AM0PR04MB6913:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e8c1516-1a62-476d-ac10-08dddfc12b08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|19092799006|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Je0fitcZbiuWccfA9+c4MRT+NuEEcDOSie2SKE/6SySOYClMpU0X4DD85pJO?=
 =?us-ascii?Q?HjUnPWc/JR6fa/ib4PgfymQWEwCt+LEG/uhEXfBtFFQP+bwxHSdtnmHGBijH?=
 =?us-ascii?Q?ZNpOsgppe5VmN55YsiTiI/Z+pefBN7uPhJ2RQFngVq6rCzp7EIh5hBt6WX10?=
 =?us-ascii?Q?2QhMFKicamJ/sxRaoNCrdFSetScsNIY9hk/KWz5a2lvaIhkpB6UB6YBDtaq6?=
 =?us-ascii?Q?fyiaRYWrUd6AnpsVZIl+agSRkxzsZhHEcupFmbiPOo4am+uMxSVrh7OSY1J0?=
 =?us-ascii?Q?lFTwxMRIeKaTBWzN0mW7rxLUfvsIyYzG0kkqE6cu1PVPKmN3cQWuActkktS1?=
 =?us-ascii?Q?Cw/FVSuYmdmJb5k7T8tpOvV9TejV16mhVtpsp2M5hd/xmdPKs0a8RL7+K3oN?=
 =?us-ascii?Q?YuA75moe047WMQ3NCZgzWpBIKuVUn4xcrXhVhYWGuNB1vyj+5037aJiuYnhC?=
 =?us-ascii?Q?gG4HKsQOUmhsRMybiRwZFkjmThg23UD6AgUobdVwB/7Xik6Vij/L5y56j+rm?=
 =?us-ascii?Q?jL+FEPHxjft7dKHWhKPhNekZRnlGHxExMfRHKdukmsp8IOXzX2NQL6KiXUmg?=
 =?us-ascii?Q?JICa9xWtVtKro6tG0QEu0xSyHtpV4vAla8o20tfpTtWUFR9vC05yucF/XAnI?=
 =?us-ascii?Q?LWBENWsdB/NiHs+EctrrpqLBqr5JsqZ0f50XV3kL0Iuup7AfniUgajJif2Ku?=
 =?us-ascii?Q?/BaOo8EIU7BNp7HmG1BuJrEmY29nB+dMvL4QX0INrVmRK4xp/EwJEnTJRa/z?=
 =?us-ascii?Q?ZByeP1I+MZoTcuWF38V0NUEVPf3y9qXltxjQa5EOEJ1PaC8QX45MccKtrO0b?=
 =?us-ascii?Q?oDSwzZR5VJn/DHJHHlFffPn7t9nxJuLA1kPD+MFCg5NRNWxrtC+wNx2rk7KY?=
 =?us-ascii?Q?9olLRV4Tqkyd/loeo85uEW1oc/Es93+P63o7MnkTGXCbOu5MZcLPVeYAgVNj?=
 =?us-ascii?Q?/dKFBPQqfWyFDSySgVWcFXPYy4RmpCekVa303EqJRyWGA3rUak3MjFR+KqyA?=
 =?us-ascii?Q?ZeoLxjYD6oNZnuTDTMZb9H5sA7l1/5O01Akc+8W8vW+X4TWLptXOJdNlGfnm?=
 =?us-ascii?Q?MF6paT9136TYlPIwOJdN7k2LFU7p7+VTmqgaaU6IGQeqf4ZMYl4nLo3Rw9+4?=
 =?us-ascii?Q?bdRorb+wnwpFjHigQQQqFXDf3dNQfQEWhqOv0ynaWwkXIblmCruR+14WQiYS?=
 =?us-ascii?Q?Luov2dMrcLMLHz6U576bAzYSS55Zq+iJcyVOvyWkWXlmLp+Yvnr5PcjvAjRa?=
 =?us-ascii?Q?2Ws3atgCK1o8BsJ9BAGRIGQO/KvPl5q41mCYmdsveAeMcadKBEDTrClsNmKr?=
 =?us-ascii?Q?6uhNFtRE4/63XSe2CxX5Mhsjy4EqrHC0jfzu3N6NmEGP8TcHxuljNzz7cS/Q?=
 =?us-ascii?Q?m3iKvzpoUFjy5QlHKpMGjNRii2wrVoIt5Fn+qNITMyemcz0OH3wMX9mv/6D8?=
 =?us-ascii?Q?D04ho5hR1QXzEuw553AzfeclkCvalt+3NAOWAvAitOxn/ZDvv0pzrOFgo3AN?=
 =?us-ascii?Q?UOvzr8PNKgUofV4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(19092799006)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UeScbXC6szlpfktyA3HelAbePk/Ur6e1E3WZi8FAsaUp2WTaFq0jqXvUYs2I?=
 =?us-ascii?Q?EMJbUfSGHtKEY0sYirkX1ooHNmaGkpYaZJWafat9aNXTzXNJ3G4HYIULkSJE?=
 =?us-ascii?Q?VEJpPeB5vXrXEqsjuFJ0hMxHrSw4ANSpW6AeQXqNwXBZmVDU/WcG7Ko1IIuS?=
 =?us-ascii?Q?H2TrscQC0dwNva7VUxHH16rTlhtV3Rajno4XkfPGiwAChEC31DCrOBeb5r2f?=
 =?us-ascii?Q?uAEV+Atl9Ms1qnq8EP+uGXowLe1+rEJVQcNJxKoSvFTrxkHHbvzp01kS1trk?=
 =?us-ascii?Q?+kKq0wrLhXkDTswm6VSNq8uNlYaO0S1sZdIK3fd+X69x++BmeDrfigILLa6I?=
 =?us-ascii?Q?agH62cBduCC4A4Kl2oMHoF2xep/GBjikABfDPVeMz0P3gKXafiqUzbh+nC7U?=
 =?us-ascii?Q?wMNlBcO9+emYGJB/63NrJeBYHGRI/KXprl0DS0e+YrOIqdVvbI426reetPT4?=
 =?us-ascii?Q?7+fMQ9cJvcRiy2YwkInhkLPz++BUyqprsOyFsZRwRqqSLc5cdAna0dpZWvKN?=
 =?us-ascii?Q?vvqHkjxpScagB1kocqVNuHj3SU031WRr0dTKNEtroqF2/NgcDkhOk/auQX0/?=
 =?us-ascii?Q?rfdYlovigAZr8WQnrCT4Nk/ExhXoGGMKG6uSUBvUMk/A1rTSqj57tkRXvXDT?=
 =?us-ascii?Q?3ooztONRtwB0Lg3IizM+eLFEdkcGWVykwNcZALScbOceDFga4/BqrI47kI/e?=
 =?us-ascii?Q?ZP9jxbX5iiWGGCkv93cK8Fs+bwMwKqU3z2wZnAUE+FhOm/0O76WTdH49tYSj?=
 =?us-ascii?Q?Zn9+7Tq0TIVFwhFCPSgrNBGACwnP81uYr4UmLfY8Q6x9d0o/QnVxL9zRNC/2?=
 =?us-ascii?Q?ruAegKQ0mhFgNJD0Szyw46IHLE0VSD3+RhcJfIss7S26fSH1dD0Q1LRW2oB5?=
 =?us-ascii?Q?DX3L1d7cZ5AT3rvMawaSlXQWQTOX0cUMK4iKrl7NXRqFuD0L0plZmYnexgDq?=
 =?us-ascii?Q?F2X1tMVoNQm7M9Bby1bur1sSXKSkQOaBZosAiBbVVcdoZF0cjP5nZdd71zzx?=
 =?us-ascii?Q?wPPaK7L1lJF4pW0JSbw6g9nIwNzpTW2IO7K+TenGG90mkcpkcNRUPSa9oLhD?=
 =?us-ascii?Q?4NdPNzhEfQ7lr/w5C6bS1QBeqrA6DOHhGB0yvlsy5QXyfYXHvbwzfbf3T2WR?=
 =?us-ascii?Q?wkgcHjQ3uDah+OyL6FivUxEaIMmvZFxhnXQzA/7Uhxweox7n9GjpIi6iLSFo?=
 =?us-ascii?Q?yzXLzLaUTLueHiZt+YfdAR+k/Y4Ta9oQKAiwvOry1KKGWuJr5qS06BJRQD5W?=
 =?us-ascii?Q?+b9Rw4giPS+2mAuldD7DQxM4shDwqDTtgbwJ4YnIajeTsLl7n8FGNt1whSEn?=
 =?us-ascii?Q?spObXceEBOzlLYAMMZ+qC4tgG+zkK6LYwVidP7NWKslgybPki99aCf4clpcq?=
 =?us-ascii?Q?g9l7TbLWbvXp7o1Pl7TniP0MUtcPgrBfq5J7doBRi6rlVXivzNpXPvXzOzRc?=
 =?us-ascii?Q?d3DNs1FDIWIii1IGGXFd2cbHHSYJ4Nb7+u0xtP/kYfvKmpENnJD9ZdaHz8Ch?=
 =?us-ascii?Q?SSMcpr77MsGCnbTUKa9QZVPAkiv6XXJ0niQXtMCr3yWypMUu+9feQTZeVwOO?=
 =?us-ascii?Q?sQjw8896HVjnY3yj81fVCHiHhf9ZhjCZ1lNklWIw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e8c1516-1a62-476d-ac10-08dddfc12b08
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 08:11:30.8408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TE9wMa7ZNRlbpF15ui8M8XMfI4+CN8SRj9PzbeEWu/6N2RQIbfbx8vvWhmrHQ68KsJ9mPyGJpWXajV3yI8qSHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6913

If the ops has post_init callback, invoke it in dw_pcie_resume_noirq().

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 952f8594b5012..f24f4cd5c278f 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -1079,6 +1079,9 @@ int dw_pcie_resume_noirq(struct dw_pcie *pci)
 	if (ret)
 		return ret;
 
+	if (pci->pp.ops->post_init)
+		pci->pp.ops->post_init(&pci->pp);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(dw_pcie_resume_noirq);
-- 
2.37.1


