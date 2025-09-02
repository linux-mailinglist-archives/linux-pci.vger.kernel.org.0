Return-Path: <linux-pci+bounces-35305-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C911BB3F773
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 10:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 463641A83949
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 08:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3519021FF38;
	Tue,  2 Sep 2025 08:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="g7C97dbI"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010024.outbound.protection.outlook.com [52.101.84.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E730A2E8B60;
	Tue,  2 Sep 2025 08:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756800169; cv=fail; b=CRonBtq4+5Kz3IWTujrkbE5LAvfGrSC7LghE0fNk1/DNEh+2Es0byjXp6M+LC9cMxBz/NwwB3g1Jga2Cf2l9HldVOxKaIFQhP0CTO2CRfLlL5K3wKLeQhbehIH7g34xIWOfi1Wa0VYtfnge+8whIeo01AZWUVbHb1uZy6UVWvns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756800169; c=relaxed/simple;
	bh=Ac8YAu0at8XGQ1Y4kHS0HrdCKMFJHwMpnP5ke9vh88o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sMUkgnVfrveptAB0S2MSgOIaMK2t/Em+yk1/x7b7gFSixAh4BWNV79gw+KNKnWex8t7N6ELY5DJMfPpvFN3bKpJn52CcXzj9rKwGtq72+yeV5nzWQ9OWm1EYkaEzMGSnqLdzY53gOJljlZV2q21CpcZU7vcltWleJDdgm6x4z5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=g7C97dbI; arc=fail smtp.client-ip=52.101.84.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SGS1tuMgizrQT2S2Bg7JvWQ2bnNiICApCIg30Zqfq9yxY+HMvX4vmp01oOfgXu7dpwLqMvqOpKZaf3qXAXPZf680RaI4gsC5IM70HKfKVOO26ZRvUSi0L0UaHJI8yxtAm0LXaAChVJ4EmYESjMw4coD45ErTHfC9fdDxiJJNPzvweTdBznOdve9K8sP4bOLRr01ItAw81Pa1msQTLYPbNiALLHTPB/xhi4I0vQ2qS/MAKraenZwdxElxdoVtD+7VFWlCnkiGj5iIjn5CsmJOTue3Q5NYRuI9wJIHP8FQ4PQcP2zFfTtE2/6j7KL8MQwEF+JctMTJ8BHd3nBNW6Co4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pGfTVWJ1dXHION4wsSZzwA3/vG9zZf1wSECAHBt5oqQ=;
 b=feayzPfDOJ7/MfIa6M4im0wrE1XA/A9h6CQoEtvhZBEan9fhngtWNcA7SLVferAa8SeMw+fgqNrU7QZB5Jphv1JL2r3eMGTevU+7TUsPDyi6ylr4oYqWP+wzTO6ylusBTItAAE6cfQ34p1BlyyezBnlvW6P7mXwZolYbQBE4GJCqGxPp4/cCF/71Ka9wgWr65zXiRR5+1mzLBrl/4ECTJEI/UQJw35zwIZHzkhGgu+Z73rHG6bXWCse/EVLZP4qvjesZBpXVMETaZVIxUqX1UMrBJnrDKDOYdksGZAVDD8sf/phEGmUDc3bu1cp6Mn4KiT8WiR3+xC/TS4K5+ZnVUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGfTVWJ1dXHION4wsSZzwA3/vG9zZf1wSECAHBt5oqQ=;
 b=g7C97dbIPDa8LmfE9yD9WjQW79CoFqbNETWzdvp6hwwV8wizpJCF3ZZuBcJxwtjaBoppP1eEy533dGJQAkFSrXwXk7jvk5FzgAsr2h4Lhb+qBSoKTdGUCtPUJzAke+HtVUNWv6mLJbyxs9b7+6QcKJ63Rb1c0aCEN7cia4QTbnD+FKJec6E7zBwPqVDByA5i7lGQzr2PFylGsjGk+FULK6m7y6Wj+vq5HoXqMYtzgTsGhuf9oVucA6p2JpmQtY/ieXsqouBe4cqg/kfX5vt8m49xUvDQyPuvnhr6IZ6jeDue5yfCtJOCFmc2awIKJUN1u6Kv0uzY76qTKx21wWlilg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by DB9PR04MB8265.eurprd04.prod.outlook.com (2603:10a6:10:24f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.14; Tue, 2 Sep
 2025 08:02:42 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%4]) with mapi id 15.20.9094.015; Tue, 2 Sep 2025
 08:02:42 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	jingoohan1@gmail.com,
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
	Richard Zhu <hongxing.zhu@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v5 2/6] PCI: dwc: Don't poll L2 if QUIRK_NOL2POLL_IN_PM is existing in suspend
Date: Tue,  2 Sep 2025 16:01:47 +0800
Message-Id: <20250902080151.3748965-3-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250902080151.3748965-1-hongxing.zhu@nxp.com>
References: <20250902080151.3748965-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0087.apcprd03.prod.outlook.com
 (2603:1096:4:7c::15) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|DB9PR04MB8265:EE_
X-MS-Office365-Filtering-Correlation-Id: 747bf5a3-aa84-4bee-9272-08dde9f717e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z5+prJpIXTCnwMYYI3eo1tGLjJtBcVE7tS3v41cxbZfZDDBC0pytPCOEviv0?=
 =?us-ascii?Q?pY1CRqd+0CTd9P8oxOUyFHbzPTSzzBao6QFtl/tV/1HuNNyYP/3rRsTRvmht?=
 =?us-ascii?Q?1dsEtJE46a/1m2ApN1skREzEB8V9027M/aJ/IvDVWTOOpO3PvA/bWO287Tkx?=
 =?us-ascii?Q?VDhnCRnIa6cl8FqRB0v1ZeFzyIj3rpXkh8eugbrJb2PP4oN0SYUUiMYgHjER?=
 =?us-ascii?Q?rSWHwqygI5h2l+9k/e72Fxfv9ba4OcvH/2ChL+COvV98eAN9pxKb46LlvYZJ?=
 =?us-ascii?Q?/wq12VLAjuWZisdUV8oBbGvVy8J7rjwl6AjPJfxrF45QckAZr/3Ub8t3HBzZ?=
 =?us-ascii?Q?BUnoPAhfMGAxWVvV1sbyKmKL1FUcE06hBXegPkj/pwNAm/NbgVGqOe4ZZujr?=
 =?us-ascii?Q?o/ijPCNfFvFStlKV5w8LjD5obuRaDeVfy92O97c3KTA6SSrHLQnECAF0UD2A?=
 =?us-ascii?Q?jMkCLOt6dBnr2umliEB+H5hrYwGlCLMg015+a0uwrXMqBjKgJxpf3M/tqQzy?=
 =?us-ascii?Q?1PBgsH2WKoiFkBDocI36+YPxS5xd+LiW78oCjPljPASb2tzgPRp3+vhdowuy?=
 =?us-ascii?Q?EtOM1m+sL1B5+WvFOEJxhPY0QdirfOKWAeQ9pjRmsyIfCk1HfjRh8za0BlfQ?=
 =?us-ascii?Q?BB+ZqAFuZg8U1o5AMb+xtNyMwRTDHHui736y0gnlycIA1SUH1vNwAI0qMg+A?=
 =?us-ascii?Q?ysHdEg6mcoroSOO3YrK0tjQV0fd6ZUzn1c4iWbR3tb2dIXu1UJoW8IdQLtZ0?=
 =?us-ascii?Q?1Q3aq6H1OLE9tmNPRwbJyGIYUH+vjE7k5aLw1dVe1N0lneYUkyXQ8uPvIv2+?=
 =?us-ascii?Q?hiyr29pDL4DB7Rhr4WG4PeetoM4k2MGDtyZTWffBqBgP5YaeFCbqlgE8EXHs?=
 =?us-ascii?Q?L84ViOqXOBYlOqf03pi6PaX8rKYwPY7VQ5TIgIIK4qPleDmgG7PkU7LvVqJL?=
 =?us-ascii?Q?Q1ails7nelaxIuJ97Yutd35EjBfdAs4MJatEb8aFgc153h39+Zhs6uEC1EC1?=
 =?us-ascii?Q?5ahNrv2mxab5VRbNYGYuxXCzQmWGpjLk008XLzzzPHIncyunx9ofFeOAVpIY?=
 =?us-ascii?Q?XauGkSQWIVdr96r9q34SI+Ul+2mY6xvNq5sIlhFEnpJxUFPf0XWhU7aAxK3m?=
 =?us-ascii?Q?nojHZxpE2jGEL3UBTyabmuqHwgWWugiAC2SQfHUIxe4IXo75agIhlCJsVxaq?=
 =?us-ascii?Q?KE+jmUSk58IV2dr3Wx9H5PAxxxEJQ5IbJTObUGnNTGf6ZeLVxmExqm+nPUNs?=
 =?us-ascii?Q?/yEYXKdRN8/0yp/eri2aJgtovpWdcUogvlOTpTm3DyP2dU0WhEIJbmvlx6yt?=
 =?us-ascii?Q?ZLb7wKoiGvxwYeIU3jN5LPAH+74S9t0ccaMnFcSvfC3psEDzRwzF/UhfIds6?=
 =?us-ascii?Q?k1M8YaAsWbNLL6KUimsO3uh8lDGLOncbfHdXiv6KETlpyB50Vq82nWffZe/6?=
 =?us-ascii?Q?HnRhAxphb/wDlb5ha0Et1PVEeLQ+0cSi+XxS/bh+0ZK+lpoRRCK4Hb0Ug4Hh?=
 =?us-ascii?Q?Eq6krYvglCms84o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FKK0597vDEHlAFYfQysM0vTDW+Uk72v/vXNK0IpVR55wSgJ581RMkNNfMW7L?=
 =?us-ascii?Q?TCTxf5Ie4O7agF9gwAhYj1YsmTbOMaa1wyud2jI2QaOnuOXPqxwDN/qVEGrr?=
 =?us-ascii?Q?zmDXKyjZlWOAWSfrpg3jaFA2Gixu2wXRL6o8+W640VD04gSb9fEMWZdpReBL?=
 =?us-ascii?Q?1KtFtFzvdlUFFUgBLAhnDOMPC2k96+qW6bhuHOtMgfPlnaqW+6GhitV7RfLE?=
 =?us-ascii?Q?GPJd6R6e9qrPnk1tKFZOusUUYpHyaF5Q3bJyKK7GF5cHz/kp/EbX3iTP88BC?=
 =?us-ascii?Q?2gnYQPZIjSWD8gwMwIVj4M0vydEWiB+arnyydUsgC6YHQiWBhJQrSv78bsm8?=
 =?us-ascii?Q?YZVH5/sxFGWkXUsOiZGN5lS1+DsybttI2NXYe7hE6ZtwWbbG1ybeymilQgji?=
 =?us-ascii?Q?veP8X+Va24MldagPi3PKYxZuQbjSnW4zb4m0C11gPpdASRvMH3nNLLIirBi+?=
 =?us-ascii?Q?4juzgAh6fA83PO1i7rSnn98NmTtkoM8Go/A3mz/+GPO4/r6ZQrj6M5XHVLcg?=
 =?us-ascii?Q?g/E/nLlGdY9QqrILis6BW6yq/wR8MVmR7AjLLnuv9O+yp8RRiVmLRnX6sT5w?=
 =?us-ascii?Q?vEffjTQ0nnHO94CJk1Vlo5nRQj5tCD/L+9wMaMW9c9Hefnq2xR3U3xPLqiuV?=
 =?us-ascii?Q?gjHXFXtFyrT1ywYTIV/pBICAOHdU/kbyENfJEw+/cEvYpCBx3NLTBAn3B9Gr?=
 =?us-ascii?Q?dLkYdJp8PSPl0Xuh6y5NPwzIe8pbcma/fknm+w2JVa4xBXYcXqd88Q88l6Kf?=
 =?us-ascii?Q?CCHj1C1Ywn0mehnY1PWciDdWoZrAzXdm51DbkGIIW7BVLerabHFn2gT+xvu/?=
 =?us-ascii?Q?o2yG0pxAOkzyomsXCn+ucebkKCRvX40GxBplq02qtsyLvLadPld67ppjuJen?=
 =?us-ascii?Q?c/DJBr9zNEaRcRAWS0ObzPMuUxhpcOJI1Nlv7Uu52jOh56Nra88UExe4oEX7?=
 =?us-ascii?Q?2lhzcjEUm5kdqxgiKYZvO2n+8XVE8HJ/R1keCiho3/m2gFYqqHujmkCS+yZR?=
 =?us-ascii?Q?dtuBA4OLmCb545sEvn/0Po8/O4DBhNhsuAKa30a02T8r6ivQqXkdYA+YW2Bx?=
 =?us-ascii?Q?/Xz71J6XjBJ0EQxlccml3TLCGvFiwudRprVa6lVhOzg9BaTun5VwBIMqf7+4?=
 =?us-ascii?Q?JS3TCfMyjkHUjd/PVtMZpXwjMU+IwAl/YohI/4ESm5wHaLNwKaC+5vYJDU16?=
 =?us-ascii?Q?eaQGZ+N9HaSKFRJPOTxW+2E6yll+4zisJ+4iXEypYw7CGsSChP1vlvKG9fI6?=
 =?us-ascii?Q?35Gq0BFwp1qpyq6RuRa3lipgxAvElO8nuN/H33efeVJ6yIOCjFH7V4ioh3Xr?=
 =?us-ascii?Q?uLAL4Go4m73dCLXpV7+LsT7d8tp37AwgMhcaZG6oxZrOV9e71VKMY6rzerAS?=
 =?us-ascii?Q?IXKEt9dGQojk23kdiukhUGzASYQhMFUEvjy72oiRBf8jiQZVjLaFLGVzdSzy?=
 =?us-ascii?Q?7SnFCTCTUfW7aAjieXptEIq73QtUqnXxrOkEz7EnOZJh41dkMCSxXJKUX3u6?=
 =?us-ascii?Q?3LPXuK9qYfgTf6fymoBv0CaTTNrHIbM23FyM2tFMEFmoKBelI6zUpXLDWaqA?=
 =?us-ascii?Q?WxFfJhtIx9wXXzZHEWBoGULBVJWncolBsPV5Y2iy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 747bf5a3-aa84-4bee-9272-08dde9f717e6
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 08:02:42.7237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IRfN15RW96nyqWSHaEejruVDd3OtyW2RS9HBTFiBsRMdOHFqOGz1/YDyYKQWSdnT8HlZ/kE98XDUbvIIcLYa2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8265

Refer to PCIe r6.0, sec 5.2, fig 5-1 Link Power Management State Flow
Diagram. Both L0 and L2/L3 Ready can be transferred to LDn directly.

It's harmless to let dw_pcie_suspend_noirq() proceed suspend after the
PME_Turn_Off is sent out, whatever the LTSSM state is in L2 or L3 after
a recommended 10ms max wait refer to PCIe r6.0, sec 5.3.3.2.1 PME
Synchronization.

The LTSSM states are inaccessible on i.MX6QP and i.MX7D after the
PME_Turn_Off is sent out.

To support this case, don't poll L2 state and apply a simple delay of
PCIE_PME_TO_L2_TIMEOUT_US(10ms) if the QUIRK_NOL2POLL_IN_PM flag is set
in suspend.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 .../pci/controller/dwc/pcie-designware-host.c | 34 +++++++++++++------
 drivers/pci/controller/dwc/pcie-designware.h  |  4 +++
 2 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 9d46d1f0334b..57a1ba08c427 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -1016,15 +1016,29 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 			return ret;
 	}
 
-	ret = read_poll_timeout(dw_pcie_get_ltssm, val,
-				val == DW_PCIE_LTSSM_L2_IDLE ||
-				val <= DW_PCIE_LTSSM_DETECT_WAIT,
-				PCIE_PME_TO_L2_TIMEOUT_US/10,
-				PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
-	if (ret) {
-		/* Only log message when LTSSM isn't in DETECT or POLL */
-		dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
-		return ret;
+	if (dwc_quirk(pci, QUIRK_NOL2POLL_IN_PM)) {
+		/*
+		 * Add the QUIRK_NOL2_POLL_IN_PM case to avoid the read hang,
+		 * when LTSSM is not powered in L2/L3/LDn properly.
+		 *
+		 * Refer to PCIe r6.0, sec 5.2, fig 5-1 Link Power Management
+		 * State Flow Diagram. Both L0 and L2/L3 Ready can be
+		 * transferred to LDn directly. On the LTSSM states poll broken
+		 * platforms, add a max 10ms delay refer to PCIe r6.0,
+		 * sec 5.3.3.2.1 PME Synchronization.
+		 */
+		mdelay(PCIE_PME_TO_L2_TIMEOUT_US/1000);
+	} else {
+		ret = read_poll_timeout(dw_pcie_get_ltssm, val,
+					val == DW_PCIE_LTSSM_L2_IDLE ||
+					val <= DW_PCIE_LTSSM_DETECT_WAIT,
+					PCIE_PME_TO_L2_TIMEOUT_US/10,
+					PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
+		if (ret) {
+			/* Only log message when LTSSM isn't in DETECT or POLL */
+			dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
+			return ret;
+		}
 	}
 
 	/*
@@ -1040,7 +1054,7 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 
 	pci->suspended = true;
 
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(dw_pcie_suspend_noirq);
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 00f52d472dcd..4e5bf6cb6ce8 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -295,6 +295,9 @@
 /* Default eDMA LLP memory size */
 #define DMA_LLP_MEM_SIZE		PAGE_SIZE
 
+#define QUIRK_NOL2POLL_IN_PM		BIT(0)
+#define dwc_quirk(pci, val)		(pci->quirk_flag & val)
+
 struct dw_pcie;
 struct dw_pcie_rp;
 struct dw_pcie_ep;
@@ -504,6 +507,7 @@ struct dw_pcie {
 	const struct dw_pcie_ops *ops;
 	u32			version;
 	u32			type;
+	u32			quirk_flag;
 	unsigned long		caps;
 	int			num_lanes;
 	int			max_link_speed;
-- 
2.37.1


