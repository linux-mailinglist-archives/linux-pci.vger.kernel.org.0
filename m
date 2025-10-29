Return-Path: <linux-pci+bounces-39716-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2140FC1CCB8
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 19:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D62A2188271E
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 18:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE879258CE5;
	Wed, 29 Oct 2025 18:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XhnbG6St"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010023.outbound.protection.outlook.com [52.101.84.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7BE3563CE;
	Wed, 29 Oct 2025 18:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761762996; cv=fail; b=ZSqQmZx4wWmzQlcXt/et5gqRJ4+vbBPnojTMiYN3yLX4nDizOOiFctALgadZfxZsMjrW6CG3gKX0jziGCc3j4uhw4Nz7aSKPV66cc9mdayKRRZdqLU42ALSRIdtX+dTRqd8zxm05SzqedYO/uvm9PmrhLxk6VD7dpVHl7sNGSKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761762996; c=relaxed/simple;
	bh=bX+ZVp0m7wuI6A8UDej2xbCaLnUGjCysyfHKnp1J4LM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HeY5mhIKKWoISBqgK0U4ey0n65f1Bp2oMXMBVR/50sL0Y/aqf4pZJUsSq5fbOiZLR53tK+5XODtZID3NOGxwmQLWICtJLJu0+RVZgucgl5tb321aZ+AUPDskeARLcGkqX8/UH8HtRR6vBmIfhHnz770kmdAmBIHMkPvBEwNdcMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XhnbG6St; arc=fail smtp.client-ip=52.101.84.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hGbXggvl95lyBdzUvNJdw1qtLVa9BnXg4jp832w3swRws74h3jxPJYB5+c17AR1jjB6O9DQUciouBVqpUZ30bwmAJjJU5O2t0DqX0Duw3ObB6Nhwvoq1iWl6fJjoBdNaHXdE3ixV+xb2oCfpBN6tLVI9z9n0pEveqkPKC5hwtL0nTGjZkl8OlfZ/KxzQabldcO5V/9AcNsYlIPxHJq3YG+xjvA8VxnhbtKaLwDfPDkf+6AfTpFMF6NObsycvXDOaIlrxOrsv4NFSf8EH/+Vl1Zh22CMumSGybQgw3G6/S+PUbvmTluOPLYuvp3NyRJw24oy7Z9t+Djf0f2e2RAgXNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GQKjgq/6gWH4+Y1pZBVtSOIecLxCeJK2OJVHGV1hpfg=;
 b=nJAXiydO8KkaThML689L02m96LF5AxtRDo9FMPJMIeO7TzjnjA5RN9BY50jFOik85z3SH4mGmT3mNTgymAAs8fVQSh4jVEprhpiFuk7GgQwEMeWho4UsB6ZZjxQ3XsKbHwJ85cdZTkLxQKCtfLVXM0fHJMIcs9CrIKXkzDq4oxjnlI4gAI+WJo6iAuPk1aZqqxOoWGY5SiP1DCKtaasInM2o71XlaEVQ3NEnDkdPxmU51noqyq8Hm5mICfwg38AfPtGbsmUmoMqLNi21FthZrYj1szHkYfjvpND9AUqG7G5DfwcMyE96/C/U42u53ESI3/vfXf2XHwgGIx7sHVUyxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQKjgq/6gWH4+Y1pZBVtSOIecLxCeJK2OJVHGV1hpfg=;
 b=XhnbG6StevbBTK9eOKrJBH+r/KSjUtplEvRxJ6onNHL1RkXOi1BjtdWdIPEmnW7s+nfMuMzhIAZSXaNf+L9FiGAfvutpvOcb9+xQzHx8Ll7EjqPgHfj5TOvf1z8h8EEFbKd7rb8cegz4HpyHs6wUVMdPYvWzmrSGl0hwFsTOSgc74c2O7bOk14staR30U2guhQF0NwMRDlwPMs6COF32/wxDhmrquEM49kFJBmC1oBCzv5gCsfYJFkmuo5fdin3L+rEuvCxbrsgGen6xN3Nbp/5FiYdMRhCMjFEPlcaQkJaT1p/SkgoVsmYe/aXzHrtQqSIkJWw6AYXv0S8fxT0eaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by GV2PR04MB11566.eurprd04.prod.outlook.com (2603:10a6:150:2c8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 18:36:28 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 18:36:28 +0000
Date: Wed, 29 Oct 2025 14:36:20 -0400
From: Frank Li <Frank.li@nxp.com>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Jingoo Han <jingoohan1@gmail.com>,
	Shawn Lin <shawn.lin@rock-chips.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@collabora.com
Subject: Re: [PATCH v4 7/9] PCI: dw-rockchip: Add pme_turn_off support
Message-ID: <aQJepFIjJx+kdBao@lizhi-Precision-Tower-5810>
References: <20251029-rockchip-pcie-system-suspend-v4-0-ce2e1b0692d2@collabora.com>
 <20251029-rockchip-pcie-system-suspend-v4-7-ce2e1b0692d2@collabora.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029-rockchip-pcie-system-suspend-v4-7-ce2e1b0692d2@collabora.com>
X-ClientProxiedBy: PH7PR10CA0011.namprd10.prod.outlook.com
 (2603:10b6:510:23d::12) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|GV2PR04MB11566:EE_
X-MS-Office365-Filtering-Correlation-Id: 7310e080-e4c4-4845-1e14-08de171a1285
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|7416014|1800799024|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cUCnId0AblVV0ElQFIX1j4TAl2N2IFL6bDLBxcbgTAdLUd9sTc1NploPEYAG?=
 =?us-ascii?Q?dxKzLYprKoldeu9JQHVk6LSU4JC884PQsM11m3xtISQizoCBGy7pajTIKsHZ?=
 =?us-ascii?Q?fKIuGipe9cW+IYwCuZQjolUvJN28W0z/F+SouoIQKl1FQxFMfUpx0avGm9ei?=
 =?us-ascii?Q?0uWAjR6ucg/cXd+2uLwZgAfBHA2kLWksV5QuJRNW8TzlG0ckJc53dfvscQac?=
 =?us-ascii?Q?aCjVqHdrDSKXWPE+NQoalt85RA4dji32Lz215gpZ2O1HhXcJpNLHby5aqdkK?=
 =?us-ascii?Q?GOAizOH+t5dWOA+OTOdk+HCDQiarigrhPSl+izPkAxls0kakyYRW5s65oHZ/?=
 =?us-ascii?Q?HJXsn4Uf2t//2Ba+eRckzNksnce+XwfL+J9i74hgGR/CdVulh2GlzUWrWsQM?=
 =?us-ascii?Q?+67f3YMcojbNTcXAlDvPjsb1q0FfR9UZvtuY+kbg1ITPwmP4+xNbkhD8coTk?=
 =?us-ascii?Q?FF5eReZ3y2b3i/6L/Xlgm8HOm2BeSgzaBWXKpXgwPNnHd7KMeka055wr0E59?=
 =?us-ascii?Q?wJ+LYreXsndgrS8b2Q6Nm6sO61P1+pb7woh7XD9MBaVQRatgNOKpX0QlQsMi?=
 =?us-ascii?Q?p/2XTuVgAYz2O+QXGJ4DqQWj7hW4/htCdxEPX/hMVSlGTKJcaiJ12yTs2/Yv?=
 =?us-ascii?Q?WvDuf6GsGrLyQxuqSNb+UKEPGR6Oezkh2rTd4/RMSTS/UGgu8AG9W0O6Q094?=
 =?us-ascii?Q?DKlgfC7r5ldHgH0Z8laDQ//HrJRPnMMgnE7EWYWCdLgjOkPU1ACiqmiwgdds?=
 =?us-ascii?Q?icmuwlaQQN/cC0acAEE6jdUi8q2YVyqu3okHeuqvhwGM97cup6tt7LG1zwux?=
 =?us-ascii?Q?W3VuZcGSK2gebB6EN68+s6QQ5q30N/+FvFAlHNQHlVwhv/8/jwz8UOhRtXW1?=
 =?us-ascii?Q?XbvZorIy1l8OPwXt9w+fSglr2c2AF7EZtMBSHIHS6m4DXcYjE2EvZoD6iHzd?=
 =?us-ascii?Q?msWE1aNOjsJoK5nIv8zXM8dBIITf8w8+x381SKpm1oatcwubQpWn2J2RC7X6?=
 =?us-ascii?Q?mYFBEzkL3QaEmHqSNLByVZfdWqdj/4UW4W/Sop1OYGykNiEKkL6icu3Xuzp/?=
 =?us-ascii?Q?fhHf0NhAUBUqxixpihejD6ILtBy6JZEkuyGqZR/aNMAT4Dd4sneLdFrs/tpU?=
 =?us-ascii?Q?cRBFydsi4vFIB6/3aAuTeyX9YELezDjE/0MC60FurdTYRCIdQd+xCOt8+d5C?=
 =?us-ascii?Q?F3kr3BiKPBc5tjJgfxauFdW+FvpoPHSquPnx/3VBUuTJQvxSN01bIw7ScRl+?=
 =?us-ascii?Q?8qDPAwXw6F8u1vXBrTBXlF/YYubRxc6kCsiDWHCTYuc+m/eQ4Q/ZtPFQtCuM?=
 =?us-ascii?Q?nsyMbcXBN0jliY16oJC8p6PoPtbmxA1aUMk1Wr7/E1UMSMQ2Kx44y9yLgVVG?=
 =?us-ascii?Q?iozLp8DVGc1Z7dV+yAW+3G5FdjAYlDTieeMkfBEn5l0/fKCD2ajCm8WG4dlU?=
 =?us-ascii?Q?IZvupq3CDMsx5WcGVQqEM8oxUR3RjPrZKHpTWtmWJeY3R7Y0/kxpU066TKh4?=
 =?us-ascii?Q?Wg6HUwJaxxRzC0uXQGRWfaDSb5rV99fodnBi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(7416014)(1800799024)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3SIQx5Jn93xJF40qKrsCqgDPBmIKVFUhpyHjzysMP56FEDaWnZhW7Kn8071o?=
 =?us-ascii?Q?4EaApSzXaDIwzV2zdMuQbQK4h70reb2607xYemD1hd9FcKbvhHoPjTMdDwhC?=
 =?us-ascii?Q?qbCJt0DjcS5WSBtDst7+XamfC0au+xAig0HwXFVwLkUYjLTb0Kd2Lk+eAcVf?=
 =?us-ascii?Q?CKlBWk9WhXsqIL7b3Rc7plnmqceMoSDO+0GP5AZRlEZt2EcIp5cZO6COKrny?=
 =?us-ascii?Q?be2kl5eFb9zD5/ZoZY41hDWQHxkwRiWZ3oWI9sqMew86LDKCEHuR6rGnwXEW?=
 =?us-ascii?Q?k+tHtmiiY78YSp/oq0G0hv6Ox5wRbx47UTNak9CQFvsLJkHMN2jygoT3PA29?=
 =?us-ascii?Q?sPNo5gxiNHXtq8NYYLqiGdvTZd7YOphGkNVMKJ4eAWuWviQiAgvGK7xZQnQG?=
 =?us-ascii?Q?K7pyUSrNtRFqRfyYNf8aWkcAglHIkQTBztOYs3/ZQvbthOs004kosbM9I+wd?=
 =?us-ascii?Q?a96Tmml0WXUcM5G0CiOCD+earoiKe5zHaq+Tk/qSkYl0ETQRYaopGEjBDU/A?=
 =?us-ascii?Q?f7Yfxr7ts6cABHkrWaw+3Ie/NmPROZ0qKSTUK406DwQbQ8WCjX0gGpe8WWGS?=
 =?us-ascii?Q?e2HPSEbK9nS68yfg86PZVcSYHvtt3QxfttyyETuEOgpSNmm2bug50AhupbHS?=
 =?us-ascii?Q?4errW3PWbRb/3dSnQj53pji9a0cdEjqro+G3u/KZTJxL3zF5UDXQ3b50mfxe?=
 =?us-ascii?Q?w+FdpsgYOLcVL+5iqZfb+4/RTF9ZJx+Im2HlKiZ6bWPC1gMPf+FSvJMt3ZqM?=
 =?us-ascii?Q?fHKMa4+t/H9dSdNqhtGrX6sCniMd4ffnVfB7W2N+z0wdAdgbQhAGrnveZSrz?=
 =?us-ascii?Q?xHrkP+VAiDCo+8gMuhk8qxteCPOuwntzUbMrXCMEAGniwLPOhncXUNX+vv/+?=
 =?us-ascii?Q?S/TbECWh1EexBZDE2ptU545BlfFHRY+gi8cjSV3C2KKc89h+9FLAhW6c/iMB?=
 =?us-ascii?Q?sy+jby3psMvt3kjQVOYXyhG5BJXuTLpRZ+oWZM6RvFwR0Fu8h21CgXzl3Z/I?=
 =?us-ascii?Q?86rmQqdoUI/+2DaMuvvnI1VVzrMwWrxD1ndOZ2xXf2P6oCjpRv50t+RdQxxw?=
 =?us-ascii?Q?Q1LhaUCMlNCHXWhhGeDxFrEujmh67KPKw7dMTbSvUGCehoTmrF5KvKAGl9PM?=
 =?us-ascii?Q?9mTkNsq+xRw+xvCdSvhSO/Gnn7P9uCj3KfrGBRndHHv642cPtW1Jg5NWEMg/?=
 =?us-ascii?Q?3C7UCZb8j/jruoh501pLeF2VqwOf8NXyM9cjEMIh6AYotU8PZA4/YLq6Ixde?=
 =?us-ascii?Q?3a5b7lfvxYFPd41jNWYkb8h6ATWugUi7WydjmZ2hOUBjHX9w5GdUPgxAuPo7?=
 =?us-ascii?Q?VVeedrZeqMctdkw45U86VA5hHZ0kgVhuG9cCghtbjP0ZlU3jzbfwWQm8ntLE?=
 =?us-ascii?Q?xop+X8RJDGPTwQ0xLZ6QCxU+EgCu6PVbxSMWwW4xlrkVcsbfjSo9qJvb/cLA?=
 =?us-ascii?Q?UCgjTOp0XdNAQJ7A4g+aTvglxzJfe8o+F2tYr+yaQtKAc8KzT5Nu1Hvsm++1?=
 =?us-ascii?Q?Ft4+Ku9SVb9rFijkL0Fd7zdqKWRLw/BX8+NhWjXhDuJLi8+QFSQqZahRditj?=
 =?us-ascii?Q?4LUvAT3ETsgOn9pckuUYvusCeWuu+Dqe5zvJGknS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7310e080-e4c4-4845-1e14-08de171a1285
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 18:36:28.4966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y2E+UMrq1a2YdRXkzhXj2I9QSkQk1qji5NiC3sBLm3f+Zv3uUzMd4sqnhp5UeuR2crHHaBB73scTvYuKKkEyVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11566

On Wed, Oct 29, 2025 at 06:56:46PM +0100, Sebastian Reichel wrote:
> Prepare Rockchip PCIe controller for system suspend support by
> adding the PME turn off operation.
>
> Co-developed-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 44 +++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index ad4a907c991f..d887513a63d6 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -42,6 +42,7 @@
>  #define  PCIE_CLIENT_LD_RQ_RST_GRT	FIELD_PREP_WM16(BIT(3), 1)
>  #define  PCIE_CLIENT_ENABLE_LTSSM	FIELD_PREP_WM16(BIT(2), 1)
>  #define  PCIE_CLIENT_DISABLE_LTSSM	FIELD_PREP_WM16(BIT(2), 0)
> +#define PCIE_CLIENT_INTR_STATUS_MSG_RX	0x04
>
>  /* Interrupt Status Register Related to Legacy Interrupt */
>  #define PCIE_CLIENT_INTR_STATUS_LEGACY	0x8
> @@ -61,6 +62,11 @@
>
>  /* Interrupt Mask Register Related to Miscellaneous Operation */
>  #define PCIE_CLIENT_INTR_MASK_MISC	0x24
> +#define PCIE_CLIENT_POWER		0x2c
> +#define PCIE_CLIENT_MSG_GEN		0x34
> +#define PME_READY_ENTER_L23		BIT(3)
> +#define PME_TURN_OFF			FIELD_PREP_WM16(BIT(4), 1)
> +#define PME_TO_ACK			FIELD_PREP_WM16(BIT(9), 1)
>
>  /* Hot Reset Control Register */
>  #define PCIE_CLIENT_HOT_RESET_CTRL	0x180
> @@ -277,8 +283,46 @@ static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
>  	return 0;
>  }
>
> +static void rockchip_pcie_pme_turn_off(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
> +	struct device *dev = rockchip->pci.dev;
> +	u32 status;
> +	int ret;
> +
> +	/* 1. Broadcast PME_Turn_Off Message, bit 4 self-clear once done */
> +	rockchip_pcie_writel_apb(rockchip, PME_TURN_OFF, PCIE_CLIENT_MSG_GEN);
> +	ret = readl_poll_timeout(rockchip->apb_base + PCIE_CLIENT_MSG_GEN,
> +				 status, !(status & BIT(4)), PCIE_PME_TO_L2_TIMEOUT_US / 10,
> +				 PCIE_PME_TO_L2_TIMEOUT_US);
> +	if (ret) {
> +		dev_warn(dev, "Failed to send PME_Turn_Off\n");
> +		return;
> +	}
> +
> +	/* 2. Wait for PME_TO_Ack, bit 9 will be set once received */
> +	ret = readl_poll_timeout(rockchip->apb_base + PCIE_CLIENT_INTR_STATUS_MSG_RX,
> +				 status, status & BIT(9), PCIE_PME_TO_L2_TIMEOUT_US / 10,
> +				 PCIE_PME_TO_L2_TIMEOUT_US);
> +	if (ret) {
> +		dev_warn(dev, "Failed to receive PME_TO_Ack\n");
> +		return;
> +	}
> +
> +	/* 3. Clear PME_TO_Ack and Wait for ready to enter L23 message */
> +	rockchip_pcie_writel_apb(rockchip, PME_TO_ACK, PCIE_CLIENT_INTR_STATUS_MSG_RX);
> +	ret = readl_poll_timeout(rockchip->apb_base + PCIE_CLIENT_POWER,
> +				 status, status & PME_READY_ENTER_L23,
> +				 PCIE_PME_TO_L2_TIMEOUT_US / 10,
> +				 PCIE_PME_TO_L2_TIMEOUT_US);
> +	if (ret)
> +		dev_err(dev, "Failed to get ready to enter L23 message\n");
> +}
> +
>  static const struct dw_pcie_host_ops rockchip_pcie_host_ops = {
>  	.init = rockchip_pcie_host_init,
> +	.pme_turn_off = rockchip_pcie_pme_turn_off,

Does common dw_pcie_pme_turn_off() work at your platform? which use iATU to
generate PME message?

I know some old chip don't support it, but I think rockchip's PCIe should
new enough.

Frank

>  };
>
>  /*
>
> --
> 2.51.0
>

