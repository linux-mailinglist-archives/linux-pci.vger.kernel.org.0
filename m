Return-Path: <linux-pci+bounces-44713-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D8AD1D22A
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 09:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9E03301CEB5
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 08:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B41A37F11D;
	Wed, 14 Jan 2026 08:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="C2X/eiJq"
X-Original-To: linux-pci@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013001.outbound.protection.outlook.com [40.107.162.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD0B37F10B;
	Wed, 14 Jan 2026 08:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768379619; cv=fail; b=W03b0OM06ybluY24g6HmnSefEVdsNyqsN3e662aSFwpjy/cfBl25ucG94Fjws/ZehzavvwlnY+pXuqh+4gYxplyyFGpbQzp8rMYGWqMxBR8E0t93c6asMgU3V45p5jWlg0LrgYZknqr3qdJgA7JRv8jI9MnOZPeRR09royS6PiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768379619; c=relaxed/simple;
	bh=YD3I9WIdacyUccrd8j0sa2ZI5i+oG5cEzhcXfLDHexE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=HyklUSRwsV6TxT+hnXnqgJViqXIaB/7yNFfKU3SMgBqTkxTKOrv1w+98+IRpZeSAUPQNC6s7iADr5wnnpbX+mHnUYrHv0FrQ7m30QuTMnn6saxQnGodzf2ZZGmK1HucNswVB/2/esjKOpGdfe8+RzCBxqxrdXhUs6wD84ecBHZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=C2X/eiJq; arc=fail smtp.client-ip=40.107.162.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cr+JCHIUnXUOITMmFT3ltWPoqe051OHk+zTQNO7yFJTZHLjdOT4/3aB3X+wpBGSB7SVAzedDDvE19E2e4g5v4bjZzIUUkxQp+FuHaIxPh3GNUnrWXtegSgEES5JyNF+J2lbDWFCP7yqW70Z7PB2CRnPcDwPhlBgR/mu9hxVFodBWpoWRhr8Ynw4njz0vD81YupTpXIhqExpM2vVtXBwN6g+7VG67wrkxNP8Hc1OMH1aMBtf23RgUa4htTMjqZG6HjdLEuuinBST4KGe0udee+cFNPFQCi1IXitNewOChB5OCdg35e57i+cCi8j5eqpsov37Gt2aBXelVEZ5kjDJNFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n1e6vTXJRzRqco2Evdf6+ZFqRO71YH7QbKBODlDuFZQ=;
 b=yQgwkzD1ECNOW6lG827woKesCW+0VWg3fPEeoT2Xok85b0LsH39giLWZpKm0F/XNSBxAQOk/EGQxJsRs4gk1FlxMhtZz+CBp+zeFntIBzm6n/q2Oduc2a3aBjUA35XJ+je6vK2KYlVG6/2f5JyKtNSlV+4ZNkHArgmm8qdrY92EeZVZNdqOzdVnkvi4VHxLQNlbSJTeSxVKBAw+WYyY/Gr94/ot9M5E3gFrSTcZU1wRS6dNn5W+/b3Gp2RQ0qwwyc7XVa3/mTrht85eAfOd07zNGhMvAiiraTievl4MKdPa+soJH0xU4CSXf/TgTXm72saXtSgVqcUx8ChE9GfSFwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n1e6vTXJRzRqco2Evdf6+ZFqRO71YH7QbKBODlDuFZQ=;
 b=C2X/eiJqu/54Egs5esHGzZe7JIZBVpr35P/7FuWBGzOBEqZw+TC+7GJ2+rqiNc/28mE1Xpg1KfhiSZBqL5hva2foKkew8/vYkjqJeki4bdV922xPnqBPszxzlZyUbyM/s53Br8hPP9n0K2m2v/VKxUqB1vBq3O3JhoMTcSme82Zbb+B6flZbucf3Ql0LD9JEpvUckueDDer86vPrpN8RqqI/OG/9+OOiG+QjSqmQ38ZZrpFmwWjH8dik/Dm93tVGVvmixAjKbG7DxCX02qzZkTkhXAXjCa0kh2Cu83FK3okS14172laUgVlER3fmH1DBUA71nx0nJOSdcQO/zwHXGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by PA4PR04MB7853.eurprd04.prod.outlook.com (2603:10a6:102:c0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 08:33:32 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%7]) with mapi id 15.20.9499.002; Wed, 14 Jan 2026
 08:33:32 +0000
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v9 0/1] Add quirks to proceed PME handshake in DWC PM
Date: Wed, 14 Jan 2026 16:32:59 +0800
Message-Id: <20260114083300.3689672-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::8) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|PA4PR04MB7853:EE_
X-MS-Office365-Filtering-Correlation-Id: 660fda1a-f872-4f7c-6190-08de53479a06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|52116014|7416014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sFea4pdvlop/2iiSEYOM4SUPswtgZVDsYZCvVgJ3YdoF74gaKiC36Og5EjbC?=
 =?us-ascii?Q?OjBQvkva7IkHTH+JRkAS3CojTBPSs09e/4Tfamm8HQBHpGFgU8f63rOBHbaX?=
 =?us-ascii?Q?+Dx50it9XN5QTedElznf9uopCvNqjRVZ1ddjnWqxPv+/GPpKNiSZMjxmGtCP?=
 =?us-ascii?Q?U8ekasGREv8T0nRGS6CeWszOd69av7UdUu3rEVlLJ7c1LyZ0oniPnqr0Vfq6?=
 =?us-ascii?Q?97KHVVpKzQNqArOG9v+4UHe5qt+WvrMSB6RPuHkqs/9VzHTokIJEgOUJvh3+?=
 =?us-ascii?Q?+pT19Bz1CufbNJ6a/vrzX7DQtcSRVepOzFiewo4DsmLj3/XHlNfk47yQ/mO4?=
 =?us-ascii?Q?GWwSQkdKa33xzRhIL4UyRXl+JeMGnk3mGh8QHczoNwwtTKLq3SqNe1UozqxW?=
 =?us-ascii?Q?+qRatAqssMbnyATxymrySmkC9NglQVfh3oUaAc9oX+gNxk/DKhIl/jCY4QNg?=
 =?us-ascii?Q?0GGZcvtmVFbK7w0nqkYtQn1qhuu4JO15ksUSq6CY/1vNFiOh8HxE/8mFK0Un?=
 =?us-ascii?Q?WDXVAcKBzGR5qbcN+CBNG3qC+dSABIgJrgRFu6rgTPBRTScGgrAVN67ZCQTX?=
 =?us-ascii?Q?EkINjLXrSc1KaoZixO+w/sJ0Mt1nVknRw3BvocQxcXsd2OGbT2gmKayFgWUJ?=
 =?us-ascii?Q?eiu86+VY/pJGpHc0QkH0vRRvkG1SZY5FwJiTceRDoC6YVg5Su3P49elHh6MF?=
 =?us-ascii?Q?phqjJzJ2ix4wZZNuQ5J4+UMCM0jalzGIVXGa0lXHpMHM+pD6g/xOeSz0lL9X?=
 =?us-ascii?Q?Yv9dDa8WTrFxstNAfqyrHAuz2UUKFjSKIwIdKq9AJ4n82E035kq3dT4u4Gts?=
 =?us-ascii?Q?NseYw4qrdcFem7tQSNZ8xQFBlLIUE9XF5D0WpqopwaPSw2OHFQ3ONCCNXWl0?=
 =?us-ascii?Q?UFJbOakx9/hol2bibu9/yeVeKw1cu84wYz4t3YZhlFxwejvAEi9Q/HWoiW2E?=
 =?us-ascii?Q?ncTnSKuAv2QUwn8S24PypgsopeTyfhK6ympAB9MaVWSEqQNa+hUNG34iJupW?=
 =?us-ascii?Q?5+iZuL3C4wIXZWZnFuC9dLFxqMp8Jmayl2UZfIjuEacI9Ql4gK7oV4jXZJya?=
 =?us-ascii?Q?1SsF1sSJIextFbf655msaK63OIxRNjAJ6CK8oALfjuolbYrbZqFZAykey6qt?=
 =?us-ascii?Q?xi8tlYNEyMSn9I4ZO2/xaTPlj7lXFZxC6F0Clp8J7YEZVWSRpTM0sZX++mMg?=
 =?us-ascii?Q?8ry213IXMjJixd++aTE71AuFATVjoEef5yjaFsRQO4IZCf4+G83gh9CUOVUX?=
 =?us-ascii?Q?PF3BQvJekdiFNwIJbZ0Z94MALwYj8Of6Ys0Jh50XM3OilnUExDvQYjmf+Q1A?=
 =?us-ascii?Q?PKDUA2tDxThG0MF/VQRLD+RYOyzimrmRyzkTbGGr2m31e4Ou5cfFnJZIQSFY?=
 =?us-ascii?Q?WLOp4Bs6wNeLgNsiwIGbg85l48W2s6mRRqofm5VEif7ls6vspRRF4Qf0173D?=
 =?us-ascii?Q?l4po2QM+bcOr5BwP0VlyoIAj9ltr5S98e1Fq8h4X2qnUROSh9MtIXQ2WViAQ?=
 =?us-ascii?Q?w78NeoAFVvTdPVIjrwY1x8DpVgv32YKAoFYKm5+o8TynNwh3Sl2LTyXcEUas?=
 =?us-ascii?Q?6HWepItrxb1UXRDt3fg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(52116014)(7416014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZCAPMCz2rV16SeqfSlmyNcM6r4Oj2ZzCOzHHqHqCnog4GEUqfRy4WiNfPTTU?=
 =?us-ascii?Q?a/YMsPrHKIPvGfO9+eJTLSO4ImzAdsTauT3r09XxgGFrsD3R50pvp4rj89aw?=
 =?us-ascii?Q?tpIWaevEW3ba+uW/Wn1z50cIGxCK4AiYt2nKBx03J3e3h4olSJWItKBik7G6?=
 =?us-ascii?Q?lJKq7v1zFYukeG64bX9Qu34xOOKOhj0y/j1QcZYnQI0TajKlgejUio4Xmvbc?=
 =?us-ascii?Q?x0Y6uEl/mI7569UMc5+5KFKIMNXyTMF/snHMvp4BZFmlfPirWVx/s92rHiaI?=
 =?us-ascii?Q?vQF51Q+JCQJWbtP91nwDUBdR/hNxh6/niutHsM7D7s0+6AWrJG7OR245hYuZ?=
 =?us-ascii?Q?SZcHBAQr6lKG5qULjNcLJ9WoQ0vtHtI+w0QuAj6J7ckFge11qCCd9opotg/u?=
 =?us-ascii?Q?qAvWGfbeJYzoh87D4S5YU0qcvlE3V9l5R4K74076qMNq7jaOZhgk1xZCamZL?=
 =?us-ascii?Q?w5bcqfqWhn0OQjhFdWeNuRWP53WlXjFNroMRss0uHPJHa5pFRDV+pkdvQKR2?=
 =?us-ascii?Q?nvMaFYEwC+0bF+oE/RRYx2yg5tKmHpz7HzkPFNsSbTX8HS/lLBlX/VxcW/Uk?=
 =?us-ascii?Q?wzuCMPXvb8e5B6R/u9Fr8GjWleIMCV41ZYFTvx4XvveldGJVFPCaUhB35gBG?=
 =?us-ascii?Q?/ApeH8Eh5ymoqcRVCi/DSgZAfEZR6YFif70I61wLvkj3qlWpT7XZJigeoG0e?=
 =?us-ascii?Q?Ndgjp1CmrShso0d6akienrNGxgrakhtmHFPw6tYJPEbf8mvFP8/oDqC1EJSl?=
 =?us-ascii?Q?NsU83JF/NAoJ2OD0OiN3vxXbn7PGQCsUAEhC4cWwzihZjYmoI208nEwQ92IQ?=
 =?us-ascii?Q?pnduIf6pk+dov5/JylVr6Vq7d4e1KCfk9dtVUUr4Gvkl6KX+YFrGwww8FLJ/?=
 =?us-ascii?Q?M8Kmfy9PlM3ngUpMmFgK9VFs54khQPHr3WJpC5LhRJs/8l58j2I0P0+Lg4EO?=
 =?us-ascii?Q?rEONcAj26BWb+ppnlSVAu1apaSxDTWd3dSKyzS2s5mJ6wTX/ukh/avz6rGbE?=
 =?us-ascii?Q?YZEnmJnncRTGJ/BajoC0rP8z3UDjJEPMvtulyk1RRVE4ROtR9VJX00ElOSkt?=
 =?us-ascii?Q?Yit+Ph4CovwQOuJM+woBMO8Yzzw8w3ATTEaRW7Z03Z7YquBdJIUW+vNL4drv?=
 =?us-ascii?Q?NEqrVgYB99FvWRyHkuEgriQcbZe7dEDNm2MTjpw/HMBABjCUw8e6Gjr79OEm?=
 =?us-ascii?Q?+nXDdy0jBHY+O3xEEpKFgFs9FMOuMJtToOOid6xEDQH8D2/kqewUNZPsrmz+?=
 =?us-ascii?Q?QrhnsskSEWaVHcBzVJlIcrFbyHegL1EcpFmN37DzfKoP4YWgLPzb8GAM4KMs?=
 =?us-ascii?Q?23hoSInn+jIJOw0DUNqbZeSkxru8oeYWyIM+4jGDgjOkBbNx993tMQhI6vaw?=
 =?us-ascii?Q?Uhn4AuNfMNN+ltyUm1pEUCJE7EgIdO/e0hcjwlfGPpC67Ykr7efxvgxERItK?=
 =?us-ascii?Q?97cNZq7GUAvNTBzU9OjMn7McMxkXyOyjiA+W9JoHvx/p2zmn2hLuwms9AeZK?=
 =?us-ascii?Q?k/0t5mRQv5L57K8uOJb22tlg7XOCw9u3Dt6L/a1AclmcNJeuONhUBt4FAeZG?=
 =?us-ascii?Q?/Gf/LedrM+iunFMeaRgLM6x168BjbGEtBn/X/j7IpP1/qHCEgrCPkNyKh+UK?=
 =?us-ascii?Q?fMMkeO7GA+c71+bvHhVyIUqgLiIIRFleKS8wg238TbrvlhSghBgLUlFGxECU?=
 =?us-ascii?Q?eI1sw0zN6cdUq/yDLOn16iWnZjeL49gwO0inW7Z3ftpAS4yyLGVkHqVXLwIl?=
 =?us-ascii?Q?3uUZu6jdDw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 660fda1a-f872-4f7c-6190-08de53479a06
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 08:33:32.7701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9iLJlV/jXpdb72ltNz9gAX20Az1UD/SFFuNY0Jlgb1el5FOe8BhpZgagzvHFZNqyRV05KjSQmyyGACpioWu3IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7853

It's harmless to let dw_pcie_suspend_noirq() proceed suspend after the
PME_Turn_Off is sent out, whatever the LTSSM state is in L2 or L3 after
a recommended 10ms max wait refer to PCIe r6.0, sec 5.3.3.2.1 PME
Synchronization.

The LTSSM states of i.MX6QP PCIe is inaccessible after the PME_Turn_Off
is kicked off. To handle this case, don't poll L2 state and add one max
10ms delay if the skip_l23_wait flag is true in suspend.

Main changes in v9:
- Based on v4 patch-set[1] and the pcie/controller/dwc of the following pci git.
git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
- Drop 2-2 of v8 patch-set.
- Refine the first patch of v8 patch-set refer to Mani's suggestions.
[1]:https://lore.kernel.org/linux-pci/20260107-pci-dwc-suspend-rework-v4-0-9b5f3c72df0a@oss.qualcomm.com/#r
v8:https://lore.kernel.org/all/20260107024553.3307205-1-hongxing.zhu@nxp.com/

Main changes in v8:
- Rebase to v6.19-rc1.
v7:https://lore.kernel.org/all/20251024025627.787833-1-hongxing.zhu@nxp.com/

Main changes in v7:
- Rebase to v6.18-rc1.
- Drop the first patch of v6, since it's not necessary part of this topic, 
  and it seems that more evaluations and discussions are required.
v6:https://lore.kernel.org/imx/20250924072324.3046687-1-hongxing.zhu@nxp.com/

Main changes in v6:
Refer to Mani' comments.
- Update the commit message of first patch.
- Squash the 6-3 and 6-4 into 6-2 of v5 patch-set.
- Add the Fixes tag, and CC stable list.
v5:https://lore.kernel.org/imx/20250902080151.3748965-1-hongxing.zhu@nxp.com/

Main changes in v5:
- Fix build warning caused by 6-1 patch.
v4:https://lore.kernel.org/imx/20250822084341.3160738-1-hongxing.zhu@nxp.com/

Main changes in v4:
- Add one patch[1/6] to remove the L1SS check during L2 entry.
- Update the code comments of 2/6 patch and commit description of 6/6 patch.
- Add background to 5/6 to describe why skip PME_Turn_off message when no
endpoint device is connected.
v3:https://lore.kernel.org/imx/20250818073205.1412507-1-hongxing.zhu@nxp.com/

Main changes in v3:
- Adjust the patch sequence to avoid the build break.
- Update the commit message.
v2:https://lore.kernel.org/imx/20250618024116.3704579-1-hongxing.zhu@nxp.com/

Main changes in v2:
Add the following two patches.
- Skip PME_Turn_Off message if there is no endpoint connected.
- Don't return error when wait for link up.
v1:https://lore.kernel.org/imx/20250408065221.1941928-1-hongxing.zhu@nxp.com/

[PATCH v9] PCI: dwc: Don't poll L2 if skip_l23_wait is true

drivers/pci/controller/dwc/pci-imx6.c             |  5 +++++
drivers/pci/controller/dwc/pcie-designware-host.c | 15 +++++++++++++++
drivers/pci/controller/dwc/pcie-designware.h      |  1 +
3 files changed, 21 insertions(+)



