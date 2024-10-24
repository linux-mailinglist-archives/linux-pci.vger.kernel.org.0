Return-Path: <linux-pci+bounces-15178-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFDE9ADD3E
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 09:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42F33282BE7
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 07:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4820D1B3934;
	Thu, 24 Oct 2024 07:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HCqwHH7g"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2058.outbound.protection.outlook.com [40.107.21.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CED119E98B;
	Thu, 24 Oct 2024 07:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729753781; cv=fail; b=qlCDpVX7eM4O9pGk0FVqJ46uRTorXGg2AtT0eAZ0q5wILPvpbs37UAxHXg5q3zCyAlzSEY36aXB2fcG+kKQ8Q3InnNAF3SSmFxlAi9wV+QekrrZnnXnwVjPNJgeu4vI0BLtrYOrQBRvwJt7Vb5z0eAT86SHNZKPb33Y0yITQjzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729753781; c=relaxed/simple;
	bh=zoJm6GbcQksWJwaUTUUpbnjWR60wyAH7rrE4AizlkX0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=todffSAIRxMZP/bbn5V+RWHEH/T4+2B5Ozif4QqnIM5y4wID/qDxulfiK6ol1JoSM2srVcR0VJq55lAtEh1ImPesSdMjfckyGkTfsBzXfwhCqigOPizzYGrpkGC/WIILrs1nW8r0wIC3yrwY10qTz9yR4/PkXG5uQFthBtIluR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HCqwHH7g; arc=fail smtp.client-ip=40.107.21.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mHbsIQzFPjqxyA8LvnHkEYiXBYp/U+V5+fvEntpRfxFUzETFJIvaanUWmWv1M7QBNR1piI5X3QwHfwjLZQ6eNZLHJOEVJ7VDzxhgfiBYkOeMCTxKwcS6gQ5IJlHvfyrml1ts50L4VoiQtu45jvJtamR130e9JOmxPkv2A/kMROxCaZ17y0TuBq7ZOzI/O2pXgkmE2csNKnFIn5BEb8tNWtIuFZRe3U9S7ZAu+LMfhhp++c8P2itm+UwKCthFgaTjaM1qZHp82lGn9LwT+UqFTq7dqF+RwOm5ad4ec2QO5fkVxboitcupY64r470fzVxhbmmRcpdPfP6B8AUzZSjJPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mPorPa/35+1G24FCRqRFp2H9a0H8Z7hpIQ0BAms4tPo=;
 b=jYQAkva0ASrEmQny4DwkiCqwpLY3vjO8blZKVCGS/ehsdTvDOxl2v5q+9On+RYVIrmpF1gzLBHHQs5RyeqJ19pTdJtgA2ZrLFB1INYFmFAx78NvggRVcr/Ha0lN50Q4eESzReMV0w6iU4UyfiTe1but+AjTNDH68UGq77+6/fCMsMs1ELnJncQ/mU0v2BXV49IHfyb6t6Bx85WdihDvNcvCZUvDCXSc7Hx58Bb9OszB9MTO19FLpB1wWZXTIW8CJ6kI/p7PUkBxFAhJzfKpc6gNdXFoz1QmROxcXjaql2gtIw1scdJJR3CZ5PnPZeInvTzaJ8Dt17UcNYXQ+GtOoLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mPorPa/35+1G24FCRqRFp2H9a0H8Z7hpIQ0BAms4tPo=;
 b=HCqwHH7gRjNhJOA9rC2qU+CRP+C9G7MxBg7rjvb/IrDc5rhO6Yv02ViYXctLmKLHR73oNVeKt7bIHXmDEDs/IOpzcYq+HXjXtDoee4ynwIfI0/aoULIiSxSLVxmuPGRmVmVI5lZbFbsIJvxhX6sNf5etp9rM2yda7X18uD9L202Z3I97eVMIJycZxpelSuLELMZZY1jhiupm/1FFvLv0yWRZbIvZJZrRq7jOZ36EpdKhuMtIheCXt009ZvefCFRLcEHlwauXHzSA6/hn0TgUoSt1uh37YlovfKbq2jySsUNlvS1up0Fq5FoqdluHDCQpHgVSZwwKrMYkYsu5f8WdqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB8627.eurprd04.prod.outlook.com (2603:10a6:20b:42a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Thu, 24 Oct
 2024 07:09:35 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8069.027; Thu, 24 Oct 2024
 07:09:35 +0000
From: Wei Fang <wei.fang@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	vladimir.oltean@nxp.com,
	claudiu.manoil@nxp.com,
	xiaoning.wang@nxp.com,
	Frank.Li@nxp.com,
	christophe.leroy@csgroup.eu,
	linux@armlinux.org.uk,
	bhelgaas@google.com,
	horms@kernel.org
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	alexander.stein@ew.tq-group.com
Subject: [PATCH v5 net-next 09/13] net: enetc: add i.MX95 EMDIO support
Date: Thu, 24 Oct 2024 14:53:24 +0800
Message-Id: <20241024065328.521518-10-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241024065328.521518-1-wei.fang@nxp.com>
References: <20241024065328.521518-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:4:197::10) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AS8PR04MB8627:EE_
X-MS-Office365-Filtering-Correlation-Id: 811a2245-b1ea-47ed-a6e4-08dcf3fad05f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|52116014|1800799024|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j5ZvBQQ6rDTWoaY8swnygT0YdcJvAyv/IP8dNa8w5kxkRP66U3LUSKtsMk/2?=
 =?us-ascii?Q?DTBj6KBRS3xQ/rY/n9ETYTfTJ3tkgqOHlUKmqL5fqcNPXe+xeXwzyn9EyCrq?=
 =?us-ascii?Q?qNV3iAl3/qJ/6qNpgkyhUHwafE4XaXOjrVDkM79qq2K+itNikC8ziaPyIPHF?=
 =?us-ascii?Q?111pmQ7h4z6/RnQSXkxnKwJnpDZQRQLFJ0sZ9KP7MUd2q2soHBZL4/poTno7?=
 =?us-ascii?Q?B1yAKR3AYGe2Zv0BnjePmSwDBzTHGWcp8QYscGAhHV64i+zpmZ97OgwBmznG?=
 =?us-ascii?Q?FtRh3AcM9yv+UOdUEyg0d6U15DzuGu0EFh+7oOOTCJgs9tYMiIZDjNkvyb6r?=
 =?us-ascii?Q?uLvacXjjdIBuRdyEIUUohPLjPNYposG8U3ErNEiJXmfWX46VdGXTUJuk0KvG?=
 =?us-ascii?Q?5XuKPeftEkKbjYFGZqvUAt135nOqjXrbBRB0A+Mswe92ufzgy1QTYzFUpuSx?=
 =?us-ascii?Q?Lymvlgl51otBsAExulNgF7VpccCZDCZSXoFGQKAiZ5IByufgtKqqCDus4jKj?=
 =?us-ascii?Q?Wi0r9qWhNNmowkXDMckw23+4vIERoTtDyDekvYuTdgsoxzIsTFr8aLNxoXH8?=
 =?us-ascii?Q?f/hgqCAl0erJlgyvMhX7hF7g4MPTF+NoSyUlybsW66GdwJPhyMBC8MBpTVV+?=
 =?us-ascii?Q?uXjF9pZiSLx+Zu1cDc3D7z4HgKIAHdr4xSDWKZCgjFV0hWGVHdPViSNz+cIp?=
 =?us-ascii?Q?IZD3HSKOhx3VMWzqmXSnUB21L8wAHGT1qa1YXRWNbrFTpumY4IvMfKfBtHhw?=
 =?us-ascii?Q?0+T0LzMXtQNRm7ajTVeLa3oSNOM9ypDK+DllP5EjxpLTKYq3zloXNOO79Qyz?=
 =?us-ascii?Q?BY9hOxtYd5+D+2eBHayHJ+uMep+d9v0oODcskKf9CCQGFSP6G6q6UspML86M?=
 =?us-ascii?Q?OLFyFri6mpcc1Is/S9XyRTvdT93Y8x0GtnNV3P1cAWMpAZDOP7HnW7ZZ0sqN?=
 =?us-ascii?Q?2f48r7O/YP3FX59imG5P1TBvzwF6auA9MpkZ7h0Bh7cIgMjkB7rvmfnO5cal?=
 =?us-ascii?Q?86tmVajaJTP/zvHij5I0Bny3FDbfM23zlQf8NH0aAFzeMkeZavujIEfcmHQX?=
 =?us-ascii?Q?ENiYQ5Ti98V4ejUrX4Hmnm3Lat9gTpLGj1ZDNQZuMeQwhmj/FhFL7iJgRXz2?=
 =?us-ascii?Q?KQPNyiMKIuWpoVL+jhA07wsrmfswXNsd6G1cpo6qILCReZqFM7czB+pLqQES?=
 =?us-ascii?Q?VfFIF+9Ra9EvCwqrdVjC7v/4nOBAsIqx6fKlZyWcqzVKabS23Kos+Qh/Wbl2?=
 =?us-ascii?Q?yt7HK1Jb77ZmvcxzMm9LI1qh+HSwblft4nAx1gNdxgFGt0LOuz2id+YOmJKP?=
 =?us-ascii?Q?MmpKWxpRh3gLQoU4PD+a/1GonETyXdesUK4JGzfHRlxMifFjkXc45JNboWZ9?=
 =?us-ascii?Q?U4itQNvq5aK/W1g9fy3Q/QUbE73B?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(52116014)(1800799024)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?paXf2pIeC+1+k95Ok3W092KrGPX9dzxsex1z2YrNh7LA6G21GBrVxiA0eZrV?=
 =?us-ascii?Q?/MeeEDOFpsCy2B4X6e+HCVZN4QNK8cof6Db9BBQ/TaQHsrf7ncr/9NohEBnU?=
 =?us-ascii?Q?50VjY+ouh0UhtAw3KlJ1FMOLgxXhBcqhWkyZCp/q1DTIWKAIAOV9+UeKEcl4?=
 =?us-ascii?Q?nYmBq3z7OeRiKf2WCTA+eoCFSSZH+2UOYnnI8+CPZpLn4AbJuoUu/QwvLUXG?=
 =?us-ascii?Q?rAPlhWYYZYCcMUFAG9t9rgjCa5gRyOSF4YvT6cCQWX7kQ42FB6fAHzftfe9e?=
 =?us-ascii?Q?7JTUMzvaAH+dJEe7xk1nUSiyDR5fsbHRRQRIHWA3cl6pDXAt+xTlfyDdtkOu?=
 =?us-ascii?Q?3czRQgb4rjTrpYLSRD9t8MYHLbA+aC2+wjIGCyorL6xVXHUUaclSwDd+hXYb?=
 =?us-ascii?Q?rX/rbQD2CEP+3G+NjoUaR5RUyGvCFmrzUzDFlFpSyS9Iu0iImb/RDuq7hEFq?=
 =?us-ascii?Q?2Uv+lw65YpeNElAxiUmR4g7ew7wg2aPQlO8lgcCD84QU+TS5DoOS90V+ZWQY?=
 =?us-ascii?Q?ws4ayvKnki4CBeecCpCOBLrb6Z/QDCvmc5FTRnVdq0NDUNXD8Edo1bz7A6mt?=
 =?us-ascii?Q?XRQdDrw0tLMeRRI0m0hMMoEefc5JUSE3/1fcHAHFhL/Uo7ikXmeLlBzIwNR4?=
 =?us-ascii?Q?ssjRTzpnQGRvvyEx/i4yH1P3B1obkbMitwkD6hM8kL4V3t8GxNufAZLbbs1t?=
 =?us-ascii?Q?pOF2ejUlUgLbNbw7UHrcQ/a/86lGe690sgKT92rUXLgzLkZ+cKCzBNAMfz1r?=
 =?us-ascii?Q?2n0P613nAngWUt0kMgYl0J7y4toYFyvi+rRzCVDeuTSCdrlgLK2dKOguM7VE?=
 =?us-ascii?Q?uEytsJWdjf+99vd7b8ElAWDVn+Huz7msF+MB7GnvA+mQbi2ftzcnzKOaSgUF?=
 =?us-ascii?Q?RjVZZh6ypY9heHmEY7OYwAR0PeSrNyAMjRbLTQQ8o77FDhoI65MjrXsLJKfo?=
 =?us-ascii?Q?HZOdXzNHRcObBodm/0vGKNVEy8pou9gO/0S644CuEGfo1wOgI+ttT4/j9AqQ?=
 =?us-ascii?Q?7aWxA32yny7iRf3pFnGoYVZ5pPgKB7g0bbRmfrH2VMW4z/HZQPVKt4SppzzT?=
 =?us-ascii?Q?ATMVQmZQSAxoiQ+Oe01gEnOGkxLdjDN9NC/wfYInQQoNrt0sQZPC7qdTNKJF?=
 =?us-ascii?Q?aPfpsLcSTIEfw/4KzDzbdmvdxMIRt5GFOhXHcV7/16fFt3ZI8NWzkrERUu4l?=
 =?us-ascii?Q?jJrKJbiaTj7YNQupaGavvOcJ4Bbb+dHJKNxjFxJGZv062edBpLBksJ0S6aC4?=
 =?us-ascii?Q?ROIWUdofwOJVfj4v6rkjT2ZfS/nkB9Dfwzdyycsp5tyvObU9fEUa4Z3kiAIX?=
 =?us-ascii?Q?2yUrR+6dwI1ZXF7Ri1XsKBaw50g/wtAGaFiaBAxAyOwyNqSrlnsL4h4RfE8P?=
 =?us-ascii?Q?7bWHP9TBWNT9ESqRLdjKsht5UgyCu88G0HLKdTI+oMjZWdky796wiHaKx4Cr?=
 =?us-ascii?Q?dvOTb/tfAsxPkg/0J4lWZUHSYLvjOMyyyMr35v4NEME/63hGJZ21lOR8RN1W?=
 =?us-ascii?Q?WAlKVhwt5lB0EgGkUNa5b452blZQs4m1VN3TiGdIMYOXS3y1ayrHSmqTouMd?=
 =?us-ascii?Q?mON5jOBtx9fgUZFdr3WuHSWHWWkT7PDXHk+WH0F1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 811a2245-b1ea-47ed-a6e4-08dcf3fad05f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 07:09:34.9953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DODan/5zQ+aCxOtb/rICZ2puRM/iiADMhmTrrsEmpKAN7iRI+O6lThAQV6476KxN9K/RDQW2r6dAHA00DBNc2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8627

The verdor ID and device ID of i.MX95 EMDIO are different from LS1028A
EMDIO, so add new vendor ID and device ID to pci_device_id table to
support i.MX95 EMDIO. And the i.MX95 EMDIO has two pins that need to be
controlled, namely MDC and MDIO.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
v5: no changes
---
 drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c b/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
index 2445e35a764a..9968a1e9b5ef 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
@@ -2,6 +2,7 @@
 /* Copyright 2019 NXP */
 #include <linux/fsl/enetc_mdio.h>
 #include <linux/of_mdio.h>
+#include <linux/pinctrl/consumer.h>
 #include "enetc_pf.h"
 
 #define ENETC_MDIO_DEV_ID	0xee01
@@ -71,6 +72,8 @@ static int enetc_pci_mdio_probe(struct pci_dev *pdev,
 		dev_info(&pdev->dev, "Enabled ERR050089 workaround\n");
 	}
 
+	pinctrl_pm_select_default_state(dev);
+
 	err = of_mdiobus_register(bus, dev->of_node);
 	if (err)
 		goto err_mdiobus_reg;
@@ -113,6 +116,7 @@ static void enetc_pci_mdio_remove(struct pci_dev *pdev)
 
 static const struct pci_device_id enetc_pci_mdio_id_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, ENETC_MDIO_DEV_ID) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NXP2, PCI_DEVICE_ID_NXP2_NETC_EMDIO) },
 	{ 0, } /* End of table. */
 };
 MODULE_DEVICE_TABLE(pci, enetc_pci_mdio_id_table);
-- 
2.34.1


