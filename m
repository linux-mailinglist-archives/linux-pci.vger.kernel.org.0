Return-Path: <linux-pci+bounces-12765-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B43F96C368
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 18:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDB53B29B51
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 16:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4FE1E0B89;
	Wed,  4 Sep 2024 15:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UgpYt9gv"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011052.outbound.protection.outlook.com [52.101.70.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158761E0B6E;
	Wed,  4 Sep 2024 15:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725465555; cv=fail; b=fD1p9DcqD4YevfU02Cgm3dxYkbVrfVqTkObxeuuSncX9q3wQhgYYfKgAXj1u8WYGblW1IKX/JB6gDMI6NXCu103k85AC+Jd1bAJBGSDOtVK4NSPaVzONX8Kvhek0hvYYK76ea7K+N8842qzgwanMkyQyVdstSHNL4NIz0PtMfUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725465555; c=relaxed/simple;
	bh=CUN6Lb8pEUAY0NwdtOMMj4tJ7RbdIdosJ8g08B9FY1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AAhvLEK+thzNzyxSBjmcBCSfhu3ly2wWKXzy0plVuywbH457haKKA+AjMv3h/7YlYbtninMGcLcfWZGIEZpY2OssZH3LsoiUvqLESl52+t8xBo7cuNWyzdUFc1SA9Ym7qW7bqeJhz+okf6MjSYetwKjOgaVTGcoPFDQIaYxBp0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UgpYt9gv; arc=fail smtp.client-ip=52.101.70.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e1fNz64M5WGRmPbgLuj/d8twfgSgz1bCPVMHxgRrMxMIadq+WeQfy4NbnTHOgWlCtPVRdNmUFLw46RNrxvIepcdmUiU+k9MSXrA6YZ+t8Q1v41d8NhItCKJozoRx9d8nPmBsb3NFTDEC6e5v1vIXpSdF2AovmWv1TWmHOQ9pMRAXVxIb3JTYnI7sNL2a2aSWzKq5VwjDDWr5O69NmULj+0ST4upPAPeIz3jFkJwNbXNZKonPNmuKGVqQds/nW4GrddAkqlKprEnztEzx8wvteUsvrc6UrTtCLQbE06KZ8xRwTkhkLqvXoigY7Qo31zhb1f+TgkPlT8yMjov05hd5lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U49e58KgrR/reI3zbuWt1yK7Vfi9vW8BHeoodLw+Avo=;
 b=DV3T06mjc/yaqIB2JG92sanEMxmxLVi1Kp725SXr29Slc70Ijo0ksWYaKdy6Lla3AharS92Nle9IWNEiEalZuLnjDiTuKMojMQShGztUeRaq4YzF6X1uaS20KexH8ojkMAiflXSBmhkkt+K9fDgFMABOi+8XVd/vFrkEUyOIVRUBfg7+rBlmBorusOQK/kiiMQWvF8hb1eZm+ByB2SjRCDdYNdqPEglGXSZXlf9mi3o1/6AROo672zlmayxPXenXVRTe8O+EmbOHlGnyM3H+K6ZSdHGwoGe3fytt8fxJbpYG0HVLn4atkl7d8qVqsor6uG+93+ktasY0aIrtOWeXgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U49e58KgrR/reI3zbuWt1yK7Vfi9vW8BHeoodLw+Avo=;
 b=UgpYt9gvbuh18ymWrEQAgVf736iY5OV2tfqDW9/A+FPOPvJEQHkvq1spgEuOeClvSuwbUbUYTHwLlWoQXrNay4VpG/v5b/9H7SaO8TZZQ93xVIQKhIaPZIyUMZf6ZcHmjYwylcDgoXYvFdGAhqpbvyDVCwwtIO5XKeuL/LqntwVwI69Qb3LsOU9F3tUkNjCmp/FNjLz0nrSEOKJ96WgvT2yhJnUxdozq1kn/AaTxk36YQhODnwpBlitivBEddNPDV5V4hGIMqaKq9kPPgnxVOnsJrfvlf9y7mky8H9hSl6o2YMaEkC7moARrnPS+i6NnX6K9COa+MEdws+rJ0gDlVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8888.eurprd04.prod.outlook.com (2603:10a6:10:2e3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 15:59:09 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 15:59:09 +0000
Date: Wed, 4 Sep 2024 11:58:58 -0400
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Chuanhua Lei <lchuanhua@maxlinear.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	abel.vesa@linaro.org, johan+linaro@kernel.org,
	Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
Subject: Re: [PATCH v6 1/4] PCI: dwc: Rename 'dw_pcie::link_gen' to
 'dw_pcie::max_link_speed'
Message-ID: <ZtiDwuz5jFDfGvi5@lizhi-Precision-Tower-5810>
References: <20240904-pci-qcom-gen4-stability-v6-0-ec39f7ae3f62@linaro.org>
 <20240904-pci-qcom-gen4-stability-v6-1-ec39f7ae3f62@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904-pci-qcom-gen4-stability-v6-1-ec39f7ae3f62@linaro.org>
X-ClientProxiedBy: BYAPR06CA0028.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::41) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8888:EE_
X-MS-Office365-Filtering-Correlation-Id: f147e4dc-40e9-4c4a-e9f7-08dcccfa8323
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FO0BWUxDcv4fsJk1xcU99ql1tNivgytXsmFB6+OHvkRs3NfGKuss2zPPEZPN?=
 =?us-ascii?Q?5kyU2GisCcZpCwnWhJyU7LgdAJUpHy4ZV6ws2KkohlUglE7ZUM/OfZh4uyyj?=
 =?us-ascii?Q?JO1apbRVfykI0+9mawXE7TYOW7gfpQDxLHTAApHRhhvPyCZHVx3ttfabZlRi?=
 =?us-ascii?Q?NtTPXw7ABAc3xiZ+59brC59hpzzOdphecl8nBTkz1QEsWYknEJR+uFCzr0MT?=
 =?us-ascii?Q?XF3RATD3LaLv2Bjdw4o3aRVH/5AaWHkPIw7bFOdLsTzwFc+n2IDVubf9pHnr?=
 =?us-ascii?Q?NCfxWSpWooUw6oBE2sE2R5if/B2I5kOQet+sp5YhNf1M8Zy7xFfS2QVS9X5P?=
 =?us-ascii?Q?ryFpIKNzX2g90X7rcLwJu4QqXzRueLbZaF4QqARa0YHeFbRFgcjDCHRtH6Pn?=
 =?us-ascii?Q?sEnqQo6adRlcFKGONWz8zGxu7to+ICBqCxEMZzm48heUI1qXO+jai+/ig3cX?=
 =?us-ascii?Q?rQQav7j49wa68yOAuYsFaFX+0nO96ZK9QXk3RXTbwfuFvHYywKBvLKnPgs0U?=
 =?us-ascii?Q?EGujGlKNLFnb++KQ5yUIYR3FTy8PKWCL4j5I3PyQQsvAlSmrCYq90NwTI+H6?=
 =?us-ascii?Q?zhdn6QqaheiKppcmxVfp9gMw3aTTSVH4gndZjwogDONxa8hvs8ruSpzSCCjv?=
 =?us-ascii?Q?Dc4RaBemJs2gX5Nx3FO7KP6jU1wmqUJMss+5YGqHdStW4sJO8dLqMmS/AE4C?=
 =?us-ascii?Q?uU/SZqoRkm9eT7MnS/TsSNhFsszxfHnVKHAww/bLa7R+BIaWAjsRvosajReY?=
 =?us-ascii?Q?v7gRH1GH89oMDbySBefc0AlFdlDbDiCcM6tyGXxmjbcOfaCazgcJg7EbV/47?=
 =?us-ascii?Q?CPLWKTYRMzH8Vm3BW8P9wyEjncWTH02TwFl8uVEpE/sQJ5cmNDBKNMhdaFWg?=
 =?us-ascii?Q?wKxIOR8L/VkVw1NheL3f8ZKdlO0U0fVrKu1l4R+Jzr9U+rNWl2XqvYeirOut?=
 =?us-ascii?Q?Tl/gHE/tXXpQOdoJ4pF/K5dPSgVHAHWbWftccUQi3W69qYp+MgAyK+yMXbyh?=
 =?us-ascii?Q?hBYqgjzk4qLC+/2/nZ0CS1t7mQVmOc8Wl7qCLyoWFocPz0vRlA368EMxKxjw?=
 =?us-ascii?Q?VcvYsn1uuExHgBTWYW2UDWlKw+/1Z+4BytsEeTMgOmqsWRsgcYYrET5HG/Y7?=
 =?us-ascii?Q?R9mHVVU0milYG7nyIcKki+gtA9Vu7+Bk5lq3InnLaBbVyd2ZQw2Ma1Bkayu9?=
 =?us-ascii?Q?vo4jrqZwN10+nP36MoNR+npEd0kqX4Ehcz9xV5IqmsaXOH9mH0ltejD7yvim?=
 =?us-ascii?Q?NJxhVp7ms4JeG4qDza/wsQv1h8Oxu7+ZEBIfnW+ihrQJHrlxmVbMfeT3xR3I?=
 =?us-ascii?Q?wDTUZfbt0bDgYo6yrPreYwZs8VWrOfwaJ5WSNj+x+Cvin6TPrnnegd4VnvYZ?=
 =?us-ascii?Q?OW1gjPJ+cUbh1eEX3DwLrF9xxW2P/FrJwFOi4uVGCmsDiGtjGQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EJlGvCeAti9nIqhCUpnz3aL/PWPAVN9ww9kw+ekCI+EAvr02D+eoipwRHK/n?=
 =?us-ascii?Q?yy/xudOCWd791ZAnpabmPS2fE0qMKI6U3Csw8IT3ptCu2QFFS/xcqo6MF7iZ?=
 =?us-ascii?Q?3T0smVj8qMmIjFbv/5zq0oXR9CYhznj1PtfQK3/yuPUpFkpPS6tV3N/Wh2eR?=
 =?us-ascii?Q?CsWYTPRPcEw6fM/lEB7FRRa8uBhpDSA+d3bYst7IujXkl6dgyiXsBw6Qn83/?=
 =?us-ascii?Q?eJOeYDT1wt52xHgBCsko0fpsg7B+0GD1jwOWO/Vk16/V9zIu59PDwYcI+nGg?=
 =?us-ascii?Q?JQgOneusHBWOidS4E9uXMjtwIhxiKco5AkMiHC6AokMkpybKCspT/S/Z+OEE?=
 =?us-ascii?Q?C4+6zlk1PE4vxaXJeGxfeWmJ3PC4jt4pUBjCvsXTs2NfvVGHefF810k2JmTa?=
 =?us-ascii?Q?GV5y8XYbx5R9m9DOjK5ZOgEEWk9uAAxFMDqCa+xSt6C9MoWfEXP+Q3nMAvtU?=
 =?us-ascii?Q?YAq5OApmouCP8DcDpwl/XmaNI7CSzdY/n/rVOJ34e74U4NQSWG7pWHN1dINp?=
 =?us-ascii?Q?ysHM6U0Y9MMtH3aOcP14ZsOkHXkq1TjqfJXswEDJv6w4KezfNUS6K8tjViKw?=
 =?us-ascii?Q?r7ZQv7j+wNMjAgCcvA46RLNG3uQxyE7ZzjXjxm5OVbEWLUK5buKEK7zrwt+n?=
 =?us-ascii?Q?ZPBd7QnYzMaheE1+hvAgEuKECX1CAwPt7UX1msbWKege+0ux1dm5ULS2gWMC?=
 =?us-ascii?Q?B2zMDEYYgD+K7vCreuLvIIX+UvB3ddbwdjWglR/QayYQv28saVr3zQQl7+Wx?=
 =?us-ascii?Q?hxTNrE7NVbTv9ZYSpsdKe7z77UoUMD7X8vT4zjAZ06QWFLR0DwlWh7ldw291?=
 =?us-ascii?Q?kEF1NSX0iVQShMWXkAUM8K1QsWB55jBupRoz5mpXn5lHbf09m9maENBwoM70?=
 =?us-ascii?Q?GxVESyrtaG0okLVVgnlc8WPJEj8SIXS8WsoLdXDYHYOcgej1p3ZF/P8hzx9n?=
 =?us-ascii?Q?akYjxu4Ivc3OU83DGK82hrPx6CrUMe3qhiDrDh7kMiP0pWanO5n2rkLFgejt?=
 =?us-ascii?Q?xF5ig7JZUmitNZjSe8B5lxRS8+tqjB/iH3ceCKgmqlBfvxYJIHZvu5KYiwd7?=
 =?us-ascii?Q?HUQgVFGBZqHNMHexR8fRJyjE7ZHKscV/ENwIlHVTp+d5mxenGC3AHhrWZtbX?=
 =?us-ascii?Q?rYVf5/8rxz5rb6l71CwtwRnVxRE2IU0nNqXKTcPoYI648KGyitScxGVrVbFE?=
 =?us-ascii?Q?2HzrrLrOCkJtUfFEAduYQ1Q6UE8QOqqHxHsw3Z33VzCw+2AIjVPF/KOTUBcS?=
 =?us-ascii?Q?xi8qegICu5tAHdDAnhwCbIXDwxnvVZXYS8stzlZ9easkpog9l2Pv39L0KIeD?=
 =?us-ascii?Q?QXJkMuD6BkYwGGJSkkODuDcw6KBusxAHKSp5zpRrBV4HSEVTfuJU0G56oei6?=
 =?us-ascii?Q?y59ZUdHdTNb1Ind9ArCm6v93eYvZtRTTsAAnsPKSPfqAPEgcaY+GR5sgX1hu?=
 =?us-ascii?Q?H6pmGSgAP6M+7tVztREVhl3vLT+3SAkPBUVnxi9abp0PosZEz/7ebKj7QfYZ?=
 =?us-ascii?Q?L5Ai+qzeEYV5poGuLMhmmoSRaVFLR/b/RShlGS6wbtR4nwE94+D5O8l2Br1z?=
 =?us-ascii?Q?oB1EkgDbUlaBZvt8RgLeOQJ3uvKQKFcQy57gAQG5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f147e4dc-40e9-4c4a-e9f7-08dcccfa8323
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 15:59:09.5081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hrzlumc+NOBg/7rCSkmSh5vn2Qd/1SLbqoffc3EDDpJikXHI7Hu3MIH84Z84gHpZfRd6+jpUDGhiihwCppileA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8888

On Wed, Sep 04, 2024 at 12:41:57PM +0530, Manivannan Sadhasivam wrote:
> 'link_gen' field is now holding the maximum supported link speed set either
> by the controller driver or by DT through 'max-link-speed' property.
>
> But the name 'link_gen' sounds like the negotiated link speed of the PCIe
> link. So let's rename it to 'max_link_speed' to make it clear that it holds
> the maximum supported link speed of the controller.
>
> NOTE: For the sake of clarity, I've used 'max_link_speed' instead of
> 'max_link_gen'. Also the link speed and link generation values map 1:1.

Maybe a little confuse is about unit of max_link_speed. the word 'gen'
(1, 2, 3...), we know it PCIe[1,2,3...].  But word "speed" look like should
be some mHz.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c        |  8 ++++----
>  drivers/pci/controller/dwc/pcie-designware.c | 12 ++++++------
>  drivers/pci/controller/dwc/pcie-designware.h |  2 +-
>  drivers/pci/controller/dwc/pcie-intel-gw.c   |  4 ++--
>  drivers/pci/controller/dwc/pcie-rcar-gen4.c  |  6 +++---
>  5 files changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 964d67756eb2..ef12a4f31740 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -847,12 +847,12 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
>  	if (ret)
>  		goto err_reset_phy;
>
> -	if (pci->link_gen > 1) {
> +	if (pci->max_link_speed > 1) {
>  		/* Allow faster modes after the link is up */
>  		dw_pcie_dbi_ro_wr_en(pci);
>  		tmp = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
>  		tmp &= ~PCI_EXP_LNKCAP_SLS;
> -		tmp |= pci->link_gen;
> +		tmp |= pci->max_link_speed;
>  		dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, tmp);
>
>  		/*
> @@ -1386,8 +1386,8 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  		imx6_pcie->tx_swing_low = 127;
>
>  	/* Limit link speed */
> -	pci->link_gen = 1;
> -	of_property_read_u32(node, "fsl,max-link-speed", &pci->link_gen);
> +	pci->max_link_speed = 1;
> +	of_property_read_u32(node, "fsl,max-link-speed", &pci->max_link_speed);
>
>  	imx6_pcie->vpcie = devm_regulator_get_optional(&pdev->dev, "vpcie");
>  	if (IS_ERR(imx6_pcie->vpcie)) {
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 1b5aba1f0c92..86c49ba097c6 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -166,8 +166,8 @@ int dw_pcie_get_resources(struct dw_pcie *pci)
>  			return ret;
>  	}
>
> -	if (pci->link_gen < 1)
> -		pci->link_gen = of_pci_get_max_link_speed(np);
> +	if (pci->max_link_speed < 1)
> +		pci->max_link_speed = of_pci_get_max_link_speed(np);
>
>  	of_property_read_u32(np, "num-lanes", &pci->num_lanes);
>
> @@ -687,7 +687,7 @@ void dw_pcie_upconfig_setup(struct dw_pcie *pci)
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_upconfig_setup);
>
> -static void dw_pcie_link_set_max_speed(struct dw_pcie *pci, u32 link_gen)
> +static void dw_pcie_link_set_max_speed(struct dw_pcie *pci, u32 max_link_speed)
>  {
>  	u32 cap, ctrl2, link_speed;
>  	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> @@ -696,7 +696,7 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci, u32 link_gen)
>  	ctrl2 = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCTL2);
>  	ctrl2 &= ~PCI_EXP_LNKCTL2_TLS;
>
> -	switch (pcie_link_speed[link_gen]) {
> +	switch (pcie_link_speed[max_link_speed]) {
>  	case PCIE_SPEED_2_5GT:
>  		link_speed = PCI_EXP_LNKCTL2_TLS_2_5GT;
>  		break;
> @@ -1058,8 +1058,8 @@ void dw_pcie_setup(struct dw_pcie *pci)
>  {
>  	u32 val;
>
> -	if (pci->link_gen > 0)
> -		dw_pcie_link_set_max_speed(pci, pci->link_gen);
> +	if (pci->max_link_speed > 0)
> +		dw_pcie_link_set_max_speed(pci, pci->max_link_speed);
>
>  	/* Configure Gen1 N_FTS */
>  	if (pci->n_fts[0]) {
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 53c4c8f399c8..22765564f301 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -421,7 +421,7 @@ struct dw_pcie {
>  	u32			type;
>  	unsigned long		caps;
>  	int			num_lanes;
> -	int			link_gen;
> +	int			max_link_speed;
>  	u8			n_fts[2];
>  	struct dw_edma_chip	edma;
>  	struct clk_bulk_data	app_clks[DW_PCIE_NUM_APP_CLKS];
> diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/controller/dwc/pcie-intel-gw.c
> index acbe4f6d3291..676d2aba4fbd 100644
> --- a/drivers/pci/controller/dwc/pcie-intel-gw.c
> +++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
> @@ -132,7 +132,7 @@ static void intel_pcie_link_setup(struct intel_pcie *pcie)
>
>  static void intel_pcie_init_n_fts(struct dw_pcie *pci)
>  {
> -	switch (pci->link_gen) {
> +	switch (pci->max_link_speed) {
>  	case 3:
>  		pci->n_fts[1] = PORT_AFR_N_FTS_GEN3;
>  		break;
> @@ -252,7 +252,7 @@ static int intel_pcie_wait_l2(struct intel_pcie *pcie)
>  	int ret;
>  	struct dw_pcie *pci = &pcie->pci;
>
> -	if (pci->link_gen < 3)
> +	if (pci->max_link_speed < 3)
>  		return 0;
>
>  	/* Send PME_TURN_OFF message */
> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> index f0f3ebd1a033..00ad4832f2cf 100644
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> @@ -141,10 +141,10 @@ static int rcar_gen4_pcie_start_link(struct dw_pcie *dw)
>  	}
>
>  	/*
> -	 * Require direct speed change with retrying here if the link_gen is
> -	 * PCIe Gen2 or higher.
> +	 * Require direct speed change with retrying here if the max_link_speed
> +	 * is PCIe Gen2 or higher.
>  	 */
> -	changes = min_not_zero(dw->link_gen, RCAR_MAX_LINK_SPEED) - 1;
> +	changes = min_not_zero(dw->max_link_speed, RCAR_MAX_LINK_SPEED) - 1;
>
>  	/*
>  	 * Since dw_pcie_setup_rc() sets it once, PCIe Gen2 will be trained.
>
> --
> 2.25.1
>

