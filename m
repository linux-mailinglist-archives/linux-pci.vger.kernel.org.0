Return-Path: <linux-pci+bounces-24767-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11953A71896
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 15:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BFE17A2AFC
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 14:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D7A1F30D1;
	Wed, 26 Mar 2025 14:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PkxKPjbl"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013014.outbound.protection.outlook.com [52.101.67.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92F31A316C;
	Wed, 26 Mar 2025 14:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742999699; cv=fail; b=dR4K/oVlehNX5UVdU6EvOWhQ4kDG6uIi8IuuT+kAfXA0rNpEBx3qx3zMkZ4RH3s2Vz6xwjrVOMhhEtUpBLwYLdKH1XUkUOTj6nUxKHncFyw1c0vO6zzlt0wxsYixYQIj3EOkF/SCSiaExwrW+sEbnoAUrlVQcgG5aMagftb+ReU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742999699; c=relaxed/simple;
	bh=FHj7oQl9UmaQU4M8A9VPr2K+HcMMXahAF8Uwq9YQp3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=monRT+KtgJeuF8qZNwMUtscjSyxG301Sqy3quPSKXCspNCBC/45yzLQ28ULvCcPaYTPFvpa/vKrobGnRMm+9nOlN6LiDDC5TuC9bYt2iPwb1RLdEPZXXPnM55lrTQXP29LkEP1Ad0/rMClNa+fc/vpZDF4XkIjkugjrLzbYiT2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PkxKPjbl; arc=fail smtp.client-ip=52.101.67.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b1K1W6ken/nCRDXhKGNkg5ncFOfjoJvU2ZFMvf34TF5PryrMV16ej8OlbmVeyDljlJZXxKYrzk0h1Vgr8u1ptRUqPxZFjwn+TmIVoanEHBeAAhDdtOsQmCKc0hkA11025OXYIpuoH4TXXwvaXpHY2YToAMbRj5ageueM96H0UEBcpoXdCIBlnaIyYoxQgSPE5olvcrazTrJlfLZDS50/XjDYDL62QFUt0ez0S94QNwYvpC4ZvFbO7Xnl98rCNpkkskKM2vJOrOLmeYD0cMvOxDgVWPUJUTgkzGa/siHTjPjZD6Fu2hx80e5lLKLZZRPGXUJCqa+aeSSLziXk3uc3eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YsvIqybl403ujzsSijW2VrVCrTY7T+GKiBogAWU4ub8=;
 b=miyAlRVhIx0k2CldC9xpJGik0hxEAnUG2djq59d6L3UW7zjVgsMoCUzpCI4nX/Ygs77+xsLS/0Rl1/qYwZWus9UV6Zyeaax0ZlGch65XOLLL7cDvTELKKF9XjvlyG5Dh57BFPmEyeZoP5l8oignPvwubTN2SYfJ4GUtJBlNY53wWsHtn3VZbgrOjNguRy9DfOu10yIISAx8/uPilrxQF24SAo+SFj2QW8JtXTz9R/a80e6aiX6qOWdA8a2nr77KT11nI2ZK3pRCiOurUZ9RyLfQ4MgaUSu10UK0+7NH9HNiaWYPvqt7tZrruYE3PbpwJL3NRLbKi1td5aTVHZUNByg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YsvIqybl403ujzsSijW2VrVCrTY7T+GKiBogAWU4ub8=;
 b=PkxKPjblXpbeGBWjZQMy2r7MTP/X/Tmq5AJQrqTc5CyMokNtZ7wF0FSaPlZwMyDpV5ABant8Up9jIYEYjXybbIGZMKjkJ7HlzFjo1AA894tv2I1cysLOVXEbbOUaG7P2prAD0cXbe2UvKx35K/t1CdPqDoFK9hct/fdApzm5o5S4EoqhUI2FGrJ0g3ft5lYWDk56N/6YL9IiPcUc6XbCIpG6UPCTc4aAa3eZMkbBeC5NeL7XCxpvUHP113WjNpXK3EQ5euzV9eJCcX8FLJtPuk9Dz0N5NmGZQ+IKalw5fpyIqqZVqyUZKk/9S4290UPaeK/zkWWgm6F56SvggnNlqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 14:34:54 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8534.040; Wed, 26 Mar 2025
 14:34:53 +0000
Date: Wed, 26 Mar 2025 10:34:27 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] PCI: imx6: Workaround i.MX95 PCIe may not exit
 L23 ready
Message-ID: <Z+QQc4qtC2W6KeHe@lizhi-Precision-Tower-5810>
References: <20250326075915.4073725-1-hongxing.zhu@nxp.com>
 <20250326075915.4073725-4-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326075915.4073725-4-hongxing.zhu@nxp.com>
X-ClientProxiedBy: PH8PR07CA0020.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::12) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB7743:EE_
X-MS-Office365-Filtering-Correlation-Id: 392f6a72-a7c0-4874-7ddc-08dd6c73543e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i9lF1Lkd9OWO61MGwXHJamht7sjBTmZtcODf7stXSRSbsPUSjdT7i/iRHV+Z?=
 =?us-ascii?Q?5OUYCISsm5Ny8CSy6alUdrqOpCSI8MJTZL8eEz4cSLPnTY4u4HNv4AwlqYx4?=
 =?us-ascii?Q?I5IDHwXmgTiypSNTCPTgERmze4CsLqwoY395YLHNbCFZkLm4SE6lDhfQvxBI?=
 =?us-ascii?Q?FoNjksuCSichgYL0nRLfOMYRia8gsKmv+P/Qp3GnW1bbSgMdvCCRlNIx8Z6J?=
 =?us-ascii?Q?tgMo4BsscJzw+5F7hwExanWLhM4UlB1jY8+9YkqKQTueDffVX/Gu+YwLOr9s?=
 =?us-ascii?Q?P0TKh7RktrBJIeRQdCm99RAs7kOwftEzsUHf/n/GhccHkaGfY9K/riUs2ylI?=
 =?us-ascii?Q?RNjLdu0aDWPjXyPFkUmCF31bq9vRAqHC/ToK1xOsqmEhwJxmzsOsdp2/WV37?=
 =?us-ascii?Q?eKI48tdk25i1qDySZ6/rMXAN7aqZlgfwXw9MYe4cTkYZdVZXcp/rSJNDVN8P?=
 =?us-ascii?Q?At2PtFURpHraxmAR0BXyxwE0musN/TEcBc+ia86qtppEk9BUOFeStx9BAlcz?=
 =?us-ascii?Q?kYLzf1frJe3MXa119sx3TdACOkkUrg9giPs1/3XGYrI8eBnrcvZ9DyZZslzd?=
 =?us-ascii?Q?fAwjTMG9KqHnDAiahGkKETkt9I9Bfo+BwjhCofr8HeMlpeSGzNKuwAXu3eeq?=
 =?us-ascii?Q?IL4Px1xZRuhYHw5KPRqvEFYi5kvVUvZdv+Dw7BM61adQ8YIS6EOLTc/N3wwO?=
 =?us-ascii?Q?CmpG4BhayucMskIujKEIJ7QTm/g77Xl0Cx159l4q9Y/PbXpSQoBibhyWwyiD?=
 =?us-ascii?Q?TmeLv6w1H1Dbhz7EJE3V7VG6JIUPfN/u26Ac95HnEr9NrTUvWFLs0Ywhv/4Q?=
 =?us-ascii?Q?DdXJjRCZX6Rb3NTiwy7X29wDdpTomtdipwoUIk42oZAB4mvQn1cIIDkY9ffW?=
 =?us-ascii?Q?0cQwJKsagcVAw21rmMh1hdsF3B6dMkwCzNpjQW8SKCCxQ0DmBrzL3WlSF4kX?=
 =?us-ascii?Q?FZvsLp8UKt9fE7SAU8BPqiQOoL3B2qQdqeEaNsa0urxPBIoNeI4RPcx8/cKt?=
 =?us-ascii?Q?T3uLRTmp/hcfZ5T8dXrsjf0moGNx3TUdcPPZj87gRfxjhqiwDxcCIudQ1fRk?=
 =?us-ascii?Q?9QWp7si2rq1PJ7KjMy5u9ExKKKrLkRvtkTYwxueHZfRddgcJibPxQkUpmdcu?=
 =?us-ascii?Q?Sm3Bn6eVVz4jPHzlJUgMp8w/PeiQzaf4PvD/yfbzHbPEkRt8HgBJdv7LcwS+?=
 =?us-ascii?Q?3GwmAlldSpA3Ej6wLXKT/t627U721vNqBt2RveLLq0DVaxpq+HgxlS0nZP5+?=
 =?us-ascii?Q?6R9J+LfOp/jZgE0HzbHfHIToZzwnQp6D2WXOWa0O+dEm/OTi1iggnim/bkQs?=
 =?us-ascii?Q?6GF5EEyd2d10EaoPzxDzuSgKSrVxJHY2boHnw4yYklWLNN4UPgjSFhKKPYaI?=
 =?us-ascii?Q?dpXh/gBEYyXqFB2rcAT0EMckyedZVXxZJYF2CKmwDmegWVJ4MSkhURL82ddh?=
 =?us-ascii?Q?CYbGmq9CqaYv5SGcO57OprsH2HWO8H3d?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8EkEgbZ1N377CB1aGfLliqDZ38PFF3A6EDPp73KHM7ET5GIYloG5Zpv7CPe9?=
 =?us-ascii?Q?C2d/guSvqZ5J0a/swk+yrthquYntpmFYP4cXUex3rL8rai5Otiff7SxwDnSq?=
 =?us-ascii?Q?+vcaVQADwEFPKq0ue7lFIIdSiutxlK0eJJUwHvK+M3c3O67HdmpXhlmZ5eZY?=
 =?us-ascii?Q?wZEBuFsGOSU6BeANGNgh0F4tOH8WvR49r1BkmjBWJ2/yMEjlkOpxH9kZViEz?=
 =?us-ascii?Q?LhaEwRGA6WNooG9Dfr9RdsVIqHfxWCtl4qezc+cLxz+AbaCbJ7VWKd3hWdHe?=
 =?us-ascii?Q?V+ccnJNxyeRUeTG0TeqR1KFF7tcTlmyPKpu8iznglwxCNqoJXgnfTkSP6FYP?=
 =?us-ascii?Q?iwMdf8MdTJHcBLgzh63kI7OQI8NRuXMYxoJRyqU9OBtvzrB3yBjaQ53IbfGL?=
 =?us-ascii?Q?rCF3ICM/TkgMOX40p4z2SqLoLXqv526aIpTDaKheIHUb7mViGou+vFuWeHjy?=
 =?us-ascii?Q?N4l4vr3nCGvUge8Sl06uli/1sRYdJGo6jNbLx931nIbFPrU5WGvNLMedncdS?=
 =?us-ascii?Q?8RIAiBbwywlrN+LAe2jNWP2oT58NAwcibRCOE+aPW3CU4vXFR6NBpAjOLZtj?=
 =?us-ascii?Q?qTfwpZWUu/XvP2+8wGavNhFEDdKOMDrhvsJTKpWnAIBj4XHZx5wp9qlHQx10?=
 =?us-ascii?Q?0HvyM97F0V9jPZe/n8KHAL3OtWJKpdqlx3n+lOQOMrq4rqITmQdoSP/JiXa5?=
 =?us-ascii?Q?qD2PHG5l4y8f9tElSZcr1zdFAClhvvrov8N/qQjHQFe6ktBKjI9pNAn3J52i?=
 =?us-ascii?Q?HxirW8ExvT2aZwYxAxzSVTbndECaSVTbeY1zf+sx1t2Ql6/qgp2DK6xP6llI?=
 =?us-ascii?Q?Ebb5a+Vxqxij17dK/9WPz2BPM8+kTp4GKhzM4LEpcdVKuOMOsIC5KdhXoG3D?=
 =?us-ascii?Q?j1xu8zkBKtTisAPHUm0BDm/9K34X7oQlVLTNVb5nW8YAPo5HeALgxzPY0vMi?=
 =?us-ascii?Q?d3mqe23hZA0jn/nbC2tjIpfRnLGdCoZsCOzJ/xaNTzT6jkXfgxduCUMfRlUX?=
 =?us-ascii?Q?b+HbA4HxwIy3xB6C1C3t7Q+m/BtvI3pDcZbk6akbQTRgo+ndCf/wlb9fkMsI?=
 =?us-ascii?Q?5C9xN6J6FIABk3BBFgyHGaBIYDf3BEJ0ScrR0+3f2aHav31SVip325XzJRvJ?=
 =?us-ascii?Q?YzSotS7BWWkDjcvHF63FUThxUicDTfOugjv4cn6oj7coRPaU7fGZKTzamlev?=
 =?us-ascii?Q?OmoFsZ8Ela4wO0CSMQJnnk1Lv6iKNkkboxc/ikdGjMXv57s8TrEV2OgJUnzr?=
 =?us-ascii?Q?AY3+sqY9izuAlPQHzZOFAw5u/YUqW93N7pY0dpGVdbmQyhpzWWBD/DOOIMes?=
 =?us-ascii?Q?YWfWGtgSTDesBgmH5emnGOSvvBTZqh9uSmEZ3A0HbOWL0j1KBr5HzDxM6biI?=
 =?us-ascii?Q?TFMzaIi7QHC+tw3tp6sm43W3TOlsedq9j4WwENrpRAaHLRhdqa14/bbd5FI5?=
 =?us-ascii?Q?aOzbVPZcs9jX9jNIMTt+iQQQPdZF0Zk8QKdKSVaCYzoVN5dX8uY4oh6rLhIv?=
 =?us-ascii?Q?mldFoPMKmyg0e8MNDPcK72XnQG/QUUgk5aDcePZC7KkT5PH4KszkApExYEwg?=
 =?us-ascii?Q?VtPdqsez/siPTn4CBGkqZtrSE0jaGPrPzTSnK/lU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 392f6a72-a7c0-4874-7ddc-08dd6c73543e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 14:34:34.8307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AL6VpGM5oxm+jnLheI84V0lJXl/VJ+kb8QunRpf13vsMK0DCJ/oAYwliMlhTSuc3vTDNaYV5dBwF7DLrhqlYoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7743

On Wed, Mar 26, 2025 at 03:59:12PM +0800, Richard Zhu wrote:
> ERR051624: The Controller Without Vaux Cannot Exit L23 Ready Through Beacon
> or PERST# De-assertion
>
> When the auxiliary power is not available, the controller cannot exit from
> L23 Ready with beacon or PERST# de-assertion when main power is not
> removed.
>
> Workaround: Set SS_RW_REG_1[SYS_AUX_PWR_DET] to 1.
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 13e53311cc0e..fbab5a4621aa 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -48,6 +48,8 @@
>  #define IMX95_PCIE_SS_RW_REG_0			0xf0
>  #define IMX95_PCIE_REF_CLKEN			BIT(23)
>  #define IMX95_PCIE_PHY_CR_PARA_SEL		BIT(9)
> +#define IMX95_PCIE_SS_RW_REG_1			0xf4
> +#define IMX95_PCIE_SYS_AUX_PWR_DET		BIT(31)
>
>  #define IMX95_PE0_GEN_CTRL_1			0x1050
>  #define IMX95_PCIE_DEVICE_TYPE			GENMASK(3, 0)
> @@ -227,6 +229,19 @@ static unsigned int imx_pcie_grp_offset(const struct imx_pcie *imx_pcie)
>
>  static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
>  {
> +	/*
> +	 * ERR051624: The Controller Without Vaux Cannot Exit L23 Ready
> +	 * Through Beacon or PERST# De-assertion
> +	 *
> +	 * When the auxiliary power is not available, the controller
> +	 * cannot exit from L23 Ready with beacon or PERST# de-assertion
> +	 * when main power is not removed.
> +	 *
> +	 * Workaround: Set SS_RW_REG_1[SYS_AUX_PWR_DET] to 1.
> +	 */
> +	regmap_set_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_1,
> +			IMX95_PCIE_SYS_AUX_PWR_DET);
> +
>  	regmap_update_bits(imx_pcie->iomuxc_gpr,
>  			IMX95_PCIE_SS_RW_REG_0,
>  			IMX95_PCIE_PHY_CR_PARA_SEL,
> --
> 2.37.1
>

