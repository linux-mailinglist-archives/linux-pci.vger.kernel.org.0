Return-Path: <linux-pci+bounces-36837-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E46B98852
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 09:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D18804A30A8
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 07:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEC8274B23;
	Wed, 24 Sep 2025 07:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CligES47"
X-Original-To: linux-pci@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013032.outbound.protection.outlook.com [52.101.83.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B196F277C87;
	Wed, 24 Sep 2025 07:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758698658; cv=fail; b=fANirxVWF6ua40XPpNbQdHTuDuGkFeBCLiOpgsoqheQ2cJVAngG0FBkHal+av+Nf6cXImrPR/JHu4W7RdcB8JX0Z9B2wPhOGfPi6961hG4FY8sbSmaTrKnr3esPTnDsu5WaksSlWFnVUXusgRRqxxdoGZmlAgHaAl67xnZUl48w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758698658; c=relaxed/simple;
	bh=UlaCrmPOng2Ex32GctbCL+S+SMwvOwg0PX3qpc4JhX4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DX65mgpf8QWezf+OOb+Pv3VAfJDhNcpEzyBoCU02Wf0iq0R/+IgFoGH383aXAhmvlsJa1uniGliE/T4rGIuD62jBaXwqAhrIBQVNIxuudkspAFA5LBim6LsHEaHloOR7Yecotd2+dV/VbMMZKr8mtYArInkCQDO1pMxTxEPdORM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CligES47; arc=fail smtp.client-ip=52.101.83.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yQvDfZnL8x0fH5bYZT9mjgeqkc1gBr/wzl9ABp4nWKESWZx0oDvxNi9keRewap5mvAFUj/anSyF4MIHwcpIYohv1WBL6+FtKM1m1yX5sGRYopucihjQ+zdVT3K42i6EtD1zkgFs3pIzoRfKMp+7bK4IsyLySpb8oD+oX5Ahqap8AzyZ9kfCb73stYD3uksbiX49F59s+rHXshifzI9W5AdjVOmWmR7dLGKrtg8Y0iLYtKCDSY2/h32sqIhCwLLFr/bgmqDjM+BVEhg3HYeJGB5COOjbnS525+zqa7KSZCRhzq45hLUpthfP0ZStMl0Q4mPUQ4arde78RA0TySSZhJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xbj7KMFOecHJ2qDwJCN87Tph+T0NsVu1XNu/Fp76H+s=;
 b=CAeEdyf13r5oGK9UhNrRY/EFV4ok+JoiOSPxA/IlwswqSKTe5sF8sf1rccS61jsATo+8N2QWXNw8AMoZFPTtpAjWLhK//4vfp/g8akireLZn46B6Xrr15IGDgSDZvqMNe2tJRcAwpzOJs9PO90/ocYVs3yi6bcCLuynNn8YSpVEHXlelPVwKRM7CIe2UITTmObOJ1D4Rv3QI3n4lPt34GikU0gUlIEgm1CUiDSOa7m4d6DBDB9I4WcOl7cygC4qROcOH+uwVsNSmtaTJSdfLv9gtxIfm/eNcRbaCpWjeamHthZYP+UkrRzYyIYngVw6Qc6lUeoa4I494F4l2oihkeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xbj7KMFOecHJ2qDwJCN87Tph+T0NsVu1XNu/Fp76H+s=;
 b=CligES47uGwR3g9ZwhZGzNc3RM1gyQBabiBC9ksQbnHodoi9ck+7PnevOQ1I2ZA5+xUvAB73vgtgbfzdZJ5mnwFLveMQmlmDHOBk2D/eocYiYr3VIUWAiewhYUq4YTbYMCt3RsBMf6flh5f8iD1dbBm7lZOAUrrLQLULxs2g+SVKc6n328gRT7BMzvJ1wiois3sFEd3DngVicbTCqHUmGcDyrnLgWY3lD+iXQVd1B4dFPbFUa4WnpwObnsmqUDpJtBzWU1Qma+Iu0Hh1GfO+VlIV99ubYHja85+InZikgTlbQT9+9Twc5LokzwWK08FVqpcqZ7GEiYIuHrs/yQ/X4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by PAXPR04MB8271.eurprd04.prod.outlook.com (2603:10a6:102:1ca::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 07:24:12 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%3]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 07:24:12 +0000
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
	stable@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v6 4/4] PCI: dwc: Don't return error when wait for link up in dw_pcie_resume_noirq()
Date: Wed, 24 Sep 2025 15:23:24 +0800
Message-Id: <20250924072324.3046687-5-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250924072324.3046687-1-hongxing.zhu@nxp.com>
References: <20250924072324.3046687-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0019.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::12) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|PAXPR04MB8271:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fa8be6a-da01-4281-4515-08ddfb3b5bfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|52116014|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YFus7Z3q7kv3DgusTzJEkXdQXH/sz6ke20+E5T6oKPbbFmK6NdIAnuAiMgRm?=
 =?us-ascii?Q?mmv0DP4rQ0QRqFd9uQS0lyZY+tBex1e9x2VR5OzoXaeut2QInLs0fgLIZRbI?=
 =?us-ascii?Q?qnUv04/Fh8qvWYrW6Kwlc8R1BuJqXSeQMpPsCl9jWaIE51QB/N5lsm4i9+h2?=
 =?us-ascii?Q?yKvPEiHbK5XmYyy+J4dli3zXg7jNaSrV2WuZRvHjPNFvmaPhTYa4x7wjJ+PP?=
 =?us-ascii?Q?L7wM8bUxIabR67OT0bPTFhf6X0Km9xLYPl8jqK6Ay4d+mg7YqI4mi0GU8RJR?=
 =?us-ascii?Q?3OIPgU0qPEvFuZgN+KkB1sywQ+o37mJyJIibyQVzMGfOGiuL55ZWALxiEH8j?=
 =?us-ascii?Q?/bVDPUgqwT+WzZj6WaQgXtuc3Mf00rDxULWMevLbRjixQqjimc/170GQHbz4?=
 =?us-ascii?Q?uPR+sM/IZd/omJ5v7xvPXcVvCXKjjH3NUT1zYlcR5QTcfFkZY+Fhx4jplG7/?=
 =?us-ascii?Q?5W9QPV1yvHMxdiLE2zE81HBDHLsy54SvJGYFESrbBgK7kiO98j2ShTSK7TMb?=
 =?us-ascii?Q?K4Zz+Dl13GuLhL4zahCmIEg1DnWE5I4asY5relp6oco/xN4ZIjKxwYeiDAiH?=
 =?us-ascii?Q?uyTdQ0Zg8yzYaCYH6PilDhGPfB0onO3B2wAXsCrNqT46wapxzXz7MbuD3RWc?=
 =?us-ascii?Q?i45proV4uhwYHJ0VyJwIVKr4N9qyrKBpmNuRjU17tr9EzOPLpLgFK/funoQk?=
 =?us-ascii?Q?mkq2jeMo/XFkTjSe2S+eKOeUIpMY0L46mGq+0/TmskoCN0MhgPpYI3xMVvok?=
 =?us-ascii?Q?KdFzmKfuARKkH8zAy8XGzNCQKT0NwiidVxdoRtC72ETFsPUDGT0Vipougdy3?=
 =?us-ascii?Q?7Z8P4/L5SI3JVT8SAUdquV2CEzZpe68ojbsYSqqmNXKDN0iWvEkgflRQK6d1?=
 =?us-ascii?Q?PrVQPFBMp76MNF+EB7nwkWMeD8zmvGw+0JDuFqN6pdZDshpAkwHb5WrU+gxd?=
 =?us-ascii?Q?3CZlBmuGT1y9qHqcN2wYgtNN9SQJp302rKw86h1PSs/5p4VuUlN8JDvUUoh1?=
 =?us-ascii?Q?lKHEnpJ0vO3Ff3k6CYovE5lcjXCIlU5zaK0B4NLsQsqcBYBeW0Zfz8mj8K7E?=
 =?us-ascii?Q?gyfQz7t3LrVCl0qv+VtwPTk0fQfDDOvnmwASEh0B29R4I1hmqDFElgLMXFv4?=
 =?us-ascii?Q?FpArumRtknJKslZ/nI2BLWgHv6RDB/FE8LtKvePK14ZqCOryc7wrTZL6eFKL?=
 =?us-ascii?Q?jKHi2im2A/LTX9Yfoi8EOOTbffJsgx5lH1OyujhWhszkzAYds9YzwVutUV3U?=
 =?us-ascii?Q?F/Qgq8KohLUKN+MLIWdIvqdPiXtFWzgCa+AdHpiX6qbQ9oHd5kESL50iCRcX?=
 =?us-ascii?Q?s54jNvVkGe+eP0VWiflW44pGtKazubkRlN0vA2tgxkH/rzxiLkDSoSmbcptW?=
 =?us-ascii?Q?T8Za1MQ7Glbjy+j4nSg6GWChCVD6FZ8q+KuRrvSYoaIkKwuH1FwjM1DZ2huA?=
 =?us-ascii?Q?J/PeIrW328WBnlV4wugNnx2OjpajaO4sugYQdS9nWpOEKKr4nnw+C8NJFI/T?=
 =?us-ascii?Q?rX2tHByY/o2Gzr0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VK8Bwi4y8oZ5GYOfL63j2GiYI7e6L21VqKTUYjOr2VXbxtfGz9G8Bp4vpdvs?=
 =?us-ascii?Q?sBC7AoMq0UaKhf/PO0YZmAYSKsNN5zUoQR3jm6+FGhofYzl++u2I1JFszBNj?=
 =?us-ascii?Q?UP8VfB/4rQiOz4d+J4f3FaqfzP7kOijkOCSipTacvsjh2SU2/Z3l1e90XVkD?=
 =?us-ascii?Q?WWB9P2nZ01nfeFsUKBwEmSAJNe+oRnIXwFSh0OwzUsCds+vLBIZCbsdhtsB+?=
 =?us-ascii?Q?NPTj4PPwJKz5jNGVFld0c3Hli7nW48v1638+4vUZPxMNRuJRp4DCxdKBXO5e?=
 =?us-ascii?Q?KGjhkgVPnNZ20/8ajv3hMrayqPTN49kWFs8mrPvid8v5ZpLCuD2JvZ7MAb6m?=
 =?us-ascii?Q?q9lCRDQ3WpuYtllXGpfM1vg/jOdAwLj8JWQloEUTcJ0ZOKCtt+f8vPvps7dz?=
 =?us-ascii?Q?N9qI8RcWI70mr52LHwdCQHeSph5p7wxJqeMLmjWlwiuVXnt0wK9wRL+SWrfq?=
 =?us-ascii?Q?+YuAa9e3nYh7dxhjh02TyaTOCUjNGilaSm0xuDo9JujMnE0A/7MIWpzBAVF3?=
 =?us-ascii?Q?s3PR8IIniFEZa4X9V/8jiaoAhAvE6VJeE9N4TCDuguOrq25zkmwK/qtXIfIs?=
 =?us-ascii?Q?NPVdVGDlzj5OjcSESgfynqsoVvkRYiZeA9YD+N3j3NccLwq2hazRDKD85hRl?=
 =?us-ascii?Q?EA/Stb6goQVo2gRhCJS2umhhRV79Q5Kgg+caMn9cBgbGZvjqsKt4zSNoFIfo?=
 =?us-ascii?Q?o2zYb9PoBOSBYyd1kAcoGkjJyI5vUcVsNHxByPXTFKFHCyVMXUfl+t0c85Eh?=
 =?us-ascii?Q?YeKJTzZvGxzjWi+CZmi4qhDvPGMov35AY9vcgFcLckQHf+vmp9J/BRVyiBWn?=
 =?us-ascii?Q?1V9p5tkQyoQQ83s09sA4JdK2KiAXhmO08LTW3WxXVbrXWRjVA2sy9WaraFcW?=
 =?us-ascii?Q?wskD5xn6Cn9xHTSMuekSjaE1wawIq7EUJr0zMxv31fOI2ccRmW6nJnfvJh32?=
 =?us-ascii?Q?3Qztr3u/8a/qDpbQvdqBtnYSe7SwExntcCQhFQ3xLbAubPgsPsNN463JSZ4c?=
 =?us-ascii?Q?MUwTZXYH3YhCIKVLjQnbWqk8USuavzwcOWGH3fFvTs62QeN4zND2dPJLlYOx?=
 =?us-ascii?Q?LCenZuuoNmM+8T4hpWXqbSM7hYPO94SZ+5Arx3f3wCN8HPUc1Q9nOVlCqOYG?=
 =?us-ascii?Q?0lIqfgnBqOwoc/2jhh8gUl8QVaYpzFB4ISWS2qeQjRHKqwoRLNeX2yfJFHfZ?=
 =?us-ascii?Q?Z0EIrgue+xRp817q29Y6kIEN9BYssculX0RP7IMv7HgriKUbe4pwseVNasIw?=
 =?us-ascii?Q?mcORgOozL+BCczN0zjWKbqslsvslZGQScUP+/xcbBmb+ge5yn2iZ5VMTEDKE?=
 =?us-ascii?Q?hy8kJrGivXwsZcVAycoIsUPN94HXUROquNBk0tJbK3zAseSDoPipmhdeN4cp?=
 =?us-ascii?Q?QhEHKzj+kTNTRlo78G/HTqb6okOEHZeeW0FpZJSYEHJWY8FuSl3/iBe0lO/E?=
 =?us-ascii?Q?2t0sY58LsRG06NDd5n6QKbdJ+YXWBESRHwrsske/y7BlNzf5KVKjjff0YJNS?=
 =?us-ascii?Q?LF5MAg82YupvFk4y7KMt/T/he2LNtY/fSWB9z2j4Sq7rbPK7sUqLsnra83JQ?=
 =?us-ascii?Q?HZyIJ/0CL9cTz8PlUotdeQ8oXxxWHmJ6k546aBXN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fa8be6a-da01-4281-4515-08ddfb3b5bfb
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 07:24:12.6781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FEVHPRTxnnhFYQQODp4jUo+weiZ83yf40Mk+Xi3rGtztUnRQKkappe1sO92GGHRKIiBjE7pzmMw+LNZp2ZzLhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8271

When waiting for the PCIe link to come up, both link up and link down
are valid results depending on the device state.

Since the link may come up later and to get rid of the following
mis-reported PM errors. Do not return an -ETIMEDOUT error, as the
outcome has already been reported in dw_pcie_wait_for_link().

PM error logs introduced by the -ETIMEDOUT error return.
imx6q-pcie 33800000.pcie: Phy link never came up
imx6q-pcie 33800000.pcie: PM: dpm_run_callback(): genpd_resume_noirq returns -110
imx6q-pcie 33800000.pcie: PM: failed to resume noirq: error -110

Cc: stable@vger.kernel.org
Fixes: 4774faf854f5 ("PCI: dwc: Implement generic suspend/resume functionality")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index b303a74b0fd7..c4386be38a07 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -1084,10 +1084,9 @@ int dw_pcie_resume_noirq(struct dw_pcie *pci)
 	if (ret)
 		return ret;
 
-	ret = dw_pcie_wait_for_link(pci);
-	if (ret)
-		return ret;
+	/* Ignore errors, the link may come up later */
+	dw_pcie_wait_for_link(pci);
 
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(dw_pcie_resume_noirq);
-- 
2.37.1


