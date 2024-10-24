Return-Path: <linux-pci+bounces-15215-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0133E9AEC56
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 18:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 076D31C21E4B
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 16:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC301F76CE;
	Thu, 24 Oct 2024 16:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MFFPb93i"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2056.outbound.protection.outlook.com [40.107.103.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C608D1F8192;
	Thu, 24 Oct 2024 16:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729787893; cv=fail; b=ardLR+xCvY+nLNb4xyRE3DaqGjgkgBgMhUH5gxQ8RwiZxVa8kC9yfwjVEZfHGwPv8lIrZi4wVk5gM19HIf427qy6nh1f46paVCjOG9h9bG6eprNXpC7Ei37V1ddQfU/c7SJMZbpzW08EmP/LA6YmvSgjOH1H8s0gxg7N4J3BGDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729787893; c=relaxed/simple;
	bh=0wQsfuZsVwOP56RZ1b3IJEYBVAA5eNj35MyS8niOUgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Uaqq0+96EC8wiU4Peg9+L3kj/7IZwkpuhngIUHiv7B/ObwOlUeNpJDNiByVQZysZBB2h/IC2P1h/UoZDqtT8vInmxSGn1ZFfYiPgnpT57n+jTovX/ai7ju+IDU073z0EUxeHtEW+8eAy47s8jcOIHXos+lMF8Ar/gLv02PlTak0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MFFPb93i; arc=fail smtp.client-ip=40.107.103.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lM5yhtyHYFYUa0eFHNbCbP/nt2jr5jO8KNtUMiqoTfLrFyp5rutZuODpAJx3O1ZT4akYuc+l4dIieqE+ViDOQO6N+HvlNvzg2Ast3zxcg4W6xlPw6aJ59SpsCNdZO7RyZZ0iecxbFoGY6dByYH/NZTq8w1mk3tKvNiPQXI5oCrTDLQiGkvyxfBDjuPcSqGch704i/FMDOuek8ikOH1whHHi/UKHVdKn1HqlY3ndL60DrYuEVswkGcKplbZzI7H2UVoZeWd4ZFSdRWC7RUOW6iKPbrULvpYo78ILbRlmgyPN5f93YhmSH84vTMUzQtXaiLjDk7Vmpy3ZkOCyGivU98w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cE8SnGz81uDh21LDwzHRufScS+n9BTWze2vXBtR00t4=;
 b=ZtBF+y2ZX/7bD8LRcGYFRoCogmXfy5STK76Z6kjvCYXerw6Kqu5Pu+NhBCodsap5zMwmqM1ozsfmlgDQRsE5eSBq4jOAAMxZjF35R6ctU0z0uqxzUPYSoFyj85Ye2hcFii9wXgc6wZ/q6nI/JNqelRkfex/TkqQO8Q09Hr+h4x5Z2ue0quwaqexsSHrorf/TBGVefabmRKGBDTJ74qyqmWdD9TA4y3zYS43JqpKhSoDKjqQstDTztk6ytCG50agRUxC9BAhKNJv9zk/goMJ+pwLcu4zI1QxTWUZcU/6TF7AMRMoFyQgO/l+bOS6ADaJeuhgGliGDMfkXCmvNVQC/hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cE8SnGz81uDh21LDwzHRufScS+n9BTWze2vXBtR00t4=;
 b=MFFPb93it4meKf4qS9MpVhB8Eiz15jjqOzyo4SBZLPFfuG8rhujf+jpl2Jj4q6hW9Ml3yI9LQh/TRLN5uFXj+PocMuVACyQt2l/oQVRWU6zM1XMVdZUOGuVbfEXJsP82pOhR4+lyqdK8WKGlnf1f657aXp4TvwbMjzG5epeibaGCxyT3U/CMYUjAj4cPg9Fakjqa7BMXv8fI7Rxzs5+b3HBEmVQI7sUtHVPRMVpf5GyJk4ijeotkjaERW/2jaxu3oM0tdCOTB3qL8CjtBgAuahiHrzcoDLfG4LHgYN6hzQp/UFBKDmJeR753rM9KbIXVrbVDqr0KxjiCO12pEFJ+tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by PA4PR04MB9663.eurprd04.prod.outlook.com (2603:10a6:102:261::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Thu, 24 Oct
 2024 16:38:07 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::6861:40f7:98b3:c2bc]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::6861:40f7:98b3:c2bc%6]) with mapi id 15.20.8093.018; Thu, 24 Oct 2024
 16:38:07 +0000
Date: Thu, 24 Oct 2024 19:38:03 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, claudiu.manoil@nxp.com, xiaoning.wang@nxp.com,
	Frank.Li@nxp.com, christophe.leroy@csgroup.eu,
	linux@armlinux.org.uk, bhelgaas@google.com, horms@kernel.org,
	imx@lists.linux.dev, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, alexander.stein@ew.tq-group.com
Subject: Re: [PATCH v5 net-next 05/13] net: enetc: extract common ENETC PF
 parts for LS1028A and i.MX95 platforms
Message-ID: <20241024163803.2oinbux5l5tw5fy5@skbuf>
References: <20241024065328.521518-1-wei.fang@nxp.com>
 <20241024065328.521518-6-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024065328.521518-6-wei.fang@nxp.com>
X-ClientProxiedBy: VI1PR09CA0186.eurprd09.prod.outlook.com
 (2603:10a6:800:120::40) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|PA4PR04MB9663:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f7d3b5b-bcb9-4d99-9f17-08dcf44a3d30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NjuJ8mvAyJbCCcyUFrlk6r3p4TPz79zPWJZIp8LKwQV0F9zVw+upI2xEPhTE?=
 =?us-ascii?Q?kWBiwMWzEr8J2tuX1NxmMOAfm+bVr81MzjCaYmIZdLNlaoL4EUy2Tvuf60Yg?=
 =?us-ascii?Q?0StFHgV7EX5PIta1Zxl3jFTEGlFl8YynicTbdnmaj6PAcDpGV/PbBnJL2Dpn?=
 =?us-ascii?Q?IEWPmbFyImwhfMmMap0oU5NlijDHDR3Ez5mho6wB5BMOfj2sJ38Azf4PV+A6?=
 =?us-ascii?Q?ZMbRQdaa6lm6g+XMoocBrmAthSA00WBd+EkpZbmjf2NJwnCJ4L2/WeU7+J9q?=
 =?us-ascii?Q?sh99zNajLKw5OqGSjNvbRSdaCC1gQADnVDoWnp4FAnCpUkIGB6vGlUJfXbrD?=
 =?us-ascii?Q?Sgi6FCCOA5KQO+/eQRwVLPk6Hp5/zXI/8Vn1cwVXT7AYopUqQk5SVrPZEjcI?=
 =?us-ascii?Q?0Stf9i2QDMJjUVfVneXTZWLOF8f1G340NxYN8I3IjdnZ8vZToKRznFSYjjsI?=
 =?us-ascii?Q?hyjGwgxiwvDahQ4BwnDs/sTxdX8IAflXQNpDMZqFwHObysN1cXS1mkSMo75F?=
 =?us-ascii?Q?3bUjAYZ4350B3HHSudw90Bg3r3VdCnlgQQysBJemoiWCP21nfFIsi3qAI1uB?=
 =?us-ascii?Q?jJGVlv7Jwxj9i3bYDDSRwQvLbtbgvKarfu1E8fulzDjg00UDlTByOhxZXIm8?=
 =?us-ascii?Q?68+Ncsj3kDErYmka0c0mxt4U6YYIug3W/ZlKRp1k1zKoKSyhuE2wOzZ2qnFT?=
 =?us-ascii?Q?FR6kFO/WfBoTV+BatkLnRJhukMerlbovFPwfbD0jxKpftb03SQm3ZqGfpOSh?=
 =?us-ascii?Q?PCkABUgclkQeYRvx9j/R9yYlGLeW8P4grq5D/tU9SkI0iBTf9cZzTNPO+doL?=
 =?us-ascii?Q?zLba3Acokbg/ySlkibgIGJyfmyXi/Lc/VIx0Nmsg0AmMNDEMGgvKsZEZz8/q?=
 =?us-ascii?Q?UpNdU17wTewBLo9idRogKww5/ueYPVymVajmdeCKS8918hEKfXvxUZbC0loJ?=
 =?us-ascii?Q?+QQ4aLXzVGCkpcay8ZCXHcEqRaZX9LlgWejKRLOAXCUdg7fsOhQ7MQG7vU7h?=
 =?us-ascii?Q?yI6Im7M99iQeP7WSWRu4v52PTxGheRObNF6tMNOuiRYX6BHEAVdxwub8i2WE?=
 =?us-ascii?Q?SCfYj4BBNqBTQl1lkP5t+3nIVY6oFATBzmRj9L6Yw0iFTZW+9NH1kxVPMXz6?=
 =?us-ascii?Q?1DRjvvmAn8YwmLv2kuWt2yoH0J+1yQWoj4Q5WxcUmkfnZU0/0fQ6OSg+mSZs?=
 =?us-ascii?Q?ryAmZbT9XuVnZLmjv9lMzwTSPsUeWtcmByJAh2VDotB+ZMECWRMV7pTEO9my?=
 =?us-ascii?Q?JWJN/RUnYvzTT7trgfROFclgg68NASyod12zGusJa6fkbQVNzyPULUHZNcBT?=
 =?us-ascii?Q?GA4DWza1e2UYWhqCYvotcHxM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2aTABhzdZERMIkZC26NsnoOV/uVOLENTCSl8UFgYpmy8TQNGdNpcj+rsJdZ5?=
 =?us-ascii?Q?BQKBK6R/RFWHWwO07abyRwOsLkv2wMEXZ2edetvB5+1rvMkLItmsga7y4SuG?=
 =?us-ascii?Q?RrsazZjluBS72Vke2iSSKBGPNg01XWh8Lrhll+u9ItSXMJBKunE7/koa0NZU?=
 =?us-ascii?Q?4yiPxWg1koaxevr04KpjLeV6dsc2Yh+4dH69CIeY6Z7fO5szNXvMfLKVitrt?=
 =?us-ascii?Q?858ixRc6tw1BY4O2W+rUnoRjPSiwYD0pP1iz/uhE80iDruaz96xxW2ChpMV1?=
 =?us-ascii?Q?nUizNON2760jvyTpokC8qIlCsmAvo93BccvBZhLjHFvdgdnewzjBFiNdASlT?=
 =?us-ascii?Q?d2crRq+TWWMfXTwKmEoGGHkN88apV1vFNj8f9c7BcpubxVCvhKDxeW6Hl+/+?=
 =?us-ascii?Q?XVmAAZjJX9xj2G3hGBSApI+5GzCEInVisbNjs1f82PYr+uD2oBLZxxRmTgpl?=
 =?us-ascii?Q?rhfOdrpFvYDrThwGUc5eGCzHF/E7r4vhlgCqQPIbNZozMVNVdj/FtYASyViP?=
 =?us-ascii?Q?yj3VTQYnZTEzT+OWpsnanovLqrQavRSJvOjJjxXaJwD2OywLu/nd0uoGIQfW?=
 =?us-ascii?Q?rIWGfak5wXUDYTnAEx9K4l+O7IWs/wFG5Ly1tvV/XUamxsqOfZqckQtbmZY6?=
 =?us-ascii?Q?IBtY3IL3aEojJ/CZhubdmm8QpsyI3bxLJ2QRiQOyIZIpETJFII1CGWyn6oxz?=
 =?us-ascii?Q?jyoMBUK6XphPpzbFF+xY01/qvLgQ2Lr/SRpKmJqGQWU7NrDP2ro63c+v/QY+?=
 =?us-ascii?Q?ao7lbVovOFKv3+HXuRJM250e+46RXKh/HWpxhWXgWU7sbrDmyzBeByTVU7Gl?=
 =?us-ascii?Q?kWeyVq5efmG3dVXz/Qhvuk10Y5a31ZxRE5C93Gu0fl6zGx1BL24BjaXQH3Tm?=
 =?us-ascii?Q?zwCR6lDytMhQxM7f7dFBDiOl/shp5el1WEbbAH/lvb2OG+5mJKqz+rS5B07k?=
 =?us-ascii?Q?4DOxLTc1nqQcGOwrYttyq4WK37JoetadxU3K+1uAxM4cGcSHRt2b4Dlzqt07?=
 =?us-ascii?Q?XnHvrqf6fbNkKX6m25W8+sS22naYNrzY+8fw+H/ucfDAqe82d0kqItdvhpBx?=
 =?us-ascii?Q?dLAnK8offwLM6P7h9Hg1wMQ3TfxVQZ/fKeyiRi3lkGXsVPaIP65Rj0Dm8Toq?=
 =?us-ascii?Q?6pPpt1EqWHPF9MXtim5dP3Resr5Vg9OslG2/yD5R4DSoEa/6QGcDXq91JQuw?=
 =?us-ascii?Q?0+fid2WtbEensnG1CnfFA4IGf5yNEsWeFq0hwGyRWBmFoP1oGUvM+z5Af/pM?=
 =?us-ascii?Q?n6/rpwup0xWvowGRwcmE0GffgJfpw3ObioNpWAmB+GE5AK4kQMR4YJ7A/zKc?=
 =?us-ascii?Q?seRt9Nm8iJoczzl25aXbDGmBJJgigTxafp96h+GuEqwp0kByINO6nDjXvekC?=
 =?us-ascii?Q?GrJI18LySVW0ppxmLgXZxRkh+8pE3cTp9Rd295l5jtM/crkbNMTyqqXK7lgn?=
 =?us-ascii?Q?MrnueKi6pTsQgcLyn4r8Xdrf38DpLeMhNVniGn2YuEeL2XP6mfgXg54IEuzA?=
 =?us-ascii?Q?hy2yrhhL3miu0Y01KhJ2ucE2Aei77ju8J/U+Dd+NJa3CN0GppidFODjLFYvy?=
 =?us-ascii?Q?M9/PJom/208+v5ygXLD99ItNP1q2cLQ67vxD3PUharJYPUrtHRLjgoxL6hfN?=
 =?us-ascii?Q?HQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f7d3b5b-bcb9-4d99-9f17-08dcf44a3d30
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 16:38:07.2215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z/IjlY17OhdcPCGPMjXVXVnkqgVLrSBJ3xSVf3oOFvzKi8xup1tbEkeWPa/JiQDYh5pBEFbZ5Sct0f6uhY1IuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9663

On Thu, Oct 24, 2024 at 02:53:20PM +0800, Wei Fang wrote:
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
> index c26bd66e4597..92a26b09cf57 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
> @@ -58,3 +58,16 @@ struct enetc_pf {
>  int enetc_msg_psi_init(struct enetc_pf *pf);
>  void enetc_msg_psi_free(struct enetc_pf *pf);
>  void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int mbox_id, u16 *status);
> +
> +void enetc_pf_get_primary_mac_addr(struct enetc_hw *hw, int si, u8 *addr);
> +void enetc_pf_set_primary_mac_addr(struct enetc_hw *hw, int si,
> +				   const u8 *addr);
> +int enetc_pf_set_mac_addr(struct net_device *ndev, void *addr);
> +int enetc_setup_mac_addresses(struct device_node *np, struct enetc_pf *pf);
> +void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
> +			   const struct net_device_ops *ndev_ops);
> +int enetc_mdiobus_create(struct enetc_pf *pf, struct device_node *node);
> +void enetc_mdiobus_destroy(struct enetc_pf *pf);
> +int enetc_phylink_create(struct enetc_ndev_priv *priv, struct device_node *node,
> +			 const struct phylink_mac_ops *ops);
> +void enetc_phylink_destroy(struct enetc_ndev_priv *priv);

Could you put the prototypes of functions exported by enetc_pf_common.c
into a header named enetc_pf_common.h? It should be self-contained, i.e.
a dummy C file with just #include "enetc_pf_common.h" in it should compile
fine.

I know the enetc driver isn't there yet when it comes to thoroughly
respecting that, but for code we touch now, we should try to follow it.

