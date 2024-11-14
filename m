Return-Path: <linux-pci+bounces-16789-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F379C9086
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 18:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81A24281C29
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 17:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEF017A583;
	Thu, 14 Nov 2024 17:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="A1nSTl2W"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2064.outbound.protection.outlook.com [40.107.22.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562A9433C4
	for <linux-pci@vger.kernel.org>; Thu, 14 Nov 2024 17:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731604011; cv=fail; b=MCpcxyp/vdfBN2wmVT8QLDCgEM2rnpF/qEP7BDEzS7tyd7PVBJ14cxL/Ii9rxRUII3o2bMdTrSVJaIVM3Z796NVGJO54168DhqGGDn6Pf4w49pMXe53iJ2xcvoRQAKFSmMuMIe+cop9tN9d1fDF2xuU2DalJZsYPaw0ax6JQhbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731604011; c=relaxed/simple;
	bh=Afywu7Z64V3t1Ih8Tfvh/EBh3o42AtsBvLcu2JnD7wQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Rd9VtMcsp6fI9EbvCYoRiFoq8pbIIZlYvnqxXWOjH/DVz2FLtIwWMckwRSLBqGTea0gTHeQkshMa/Z27NbU1Y568E36jIc8iNozENtEUwEBAirgIjMQ4yNCjCdtqVsXgJm0h6uAN0LF+QUgA+GNbViB+MF6VaIAYaEa+0Asz0xM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=A1nSTl2W; arc=fail smtp.client-ip=40.107.22.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ltFPLvBKp16352OEfLG1+VuoY1gOSVj5x3Pk5o1q/9Z9Hj+Pe7LZi+i/wHf3HjJX192uh1eT4FM5Fe2Acom2JU8a+5pnKGxKWYE0Rijp3AbY+jr0eZmuGtHj+Mo7jIezrxRRs9X6CPVPIdovOOXzoNQFq29Viejj99mc/TK8NUhUv7q78luMD1N7b3ZyC5W1yVt3BtjPVHq8kwmStsVoxruTAf+btcor1/1nTSyosuQejGvRQ9gqp1o9pPORIPMrGT/E9lDOKDhlUWRABcxGhM/P7kj488PmCrKQza2zD/i+6YDdAyW3mmwRB42f8SDmOE4FJ+xF80AZZ53UpLOdsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EEdYhC9i5tQXDdKPNsnFCM5pJjC3ftjTu+j8GsEW6ZY=;
 b=MHMZ2WZXG11lmAg2hRTwC7JA8Us1rii97X9cchuy5eMzi/Dnb13ceGZb7ei7B8VQnEIWEjghjnFeUTMug822neAYxzbZ7ViPt3pwVUzrVGrfULXcA6mB6jd7G0uM+L1TW8H8oWcIoTBsXrBguRoc99KKh5uXPpLMDTTSmwMIBrAQ9xAqHIEaZoFDQkHV/a8/XxjI70P6LBSdOwCyzBj/+SZkExAjxEaHjgV5lB+XgHaf4OdAMZkhd8AZ37WJUFd/JLmzRchXJXKPmni6k3IDAqF0rsGRspLy3Wt+pSzHUnjcWImDhc21EKWyuBnvOXA4oox+bsw9dpQ+8f1l/tuH9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EEdYhC9i5tQXDdKPNsnFCM5pJjC3ftjTu+j8GsEW6ZY=;
 b=A1nSTl2WpsMsKd13LYYBaUSklCMqtC2axBleaFHK28MQNqrHtEiWh9Ak01/j6+76WPo6Q2sOZBzA/ThdPHWa0rJY2nkLh/TzN3cAuxQqdwpSHbHpaFa7EaLyzn8BxwnUj+N4RnzAeO1xUkZjuvwz2NUFUljBYLyLNEUAbmxQj1Blx/m1RUS/TxWCijy73KtujQ9ry7SYgBomb9vReppkvqyAC0sIyfFI2ZjPsHTM8AbvqRzH9hPdSXC12Vc9YWFhNS8bACZZvdRKZG8KS7BAgA3qzk7IU8X6LmC2d2aHKZsglr+KtH2lmPby8AatP1dEfa6bFHEO54JQ9Hh9Ebr00w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8747.eurprd04.prod.outlook.com (2603:10a6:20b:408::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 17:06:43 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 17:06:43 +0000
Date: Thu, 14 Nov 2024 12:06:36 -0500
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Jesper Nilsson <jesper.nilsson@axis.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/3] PCI: endpoint: Add size check for fixed size BARs in
 pci_epc_set_bar()
Message-ID: <ZzYuHJgsidw6DiCf@lizhi-Precision-Tower-5810>
References: <20241114110326.1891331-5-cassel@kernel.org>
 <20241114110326.1891331-7-cassel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114110326.1891331-7-cassel@kernel.org>
X-ClientProxiedBy: BYAPR01CA0027.prod.exchangelabs.com (2603:10b6:a02:80::40)
 To PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8747:EE_
X-MS-Office365-Filtering-Correlation-Id: a9ecc0b0-2715-47bb-3ee0-08dd04ceb6f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YI+qlEm886kGuyDVZx4tL3pvvutIWe53xOihN21b/Zc0uTegOfRiCtC3i1fb?=
 =?us-ascii?Q?BKABtiKDLlStdxi6dfja+x5TS+YDG8mqu2M0zhjPvBJNlvaIg0ucVyj8Tdgw?=
 =?us-ascii?Q?R1FdlFnIhurL9ZutYCQuRD8D1ypmoMti4cJCIgj9S2OuA5JHzi6NU5bPU6mW?=
 =?us-ascii?Q?dh+WL4Cxv9pyIgOaO9YikD5hMTPI/Qgc36kZVUhnEu0BeFBVeyeooCZCl3H0?=
 =?us-ascii?Q?AgygKNSmtLgk4H/iQq0pM+lPpe3jCaUrXxfgOTqNas+jNbuGOrCeeMXKMh7p?=
 =?us-ascii?Q?OEztkBy/F4A8AWK0nMWBrwvWhDMl8C3BvbBGlyha2YCkJo2XtwGpBxVvY3lW?=
 =?us-ascii?Q?h8RrDmeyzLCVuPAZiqyklRuZsAdaEunyWIAPJGeg/gneyC3y83gEr5b3MlRk?=
 =?us-ascii?Q?P1J5zX3awVr3NfcnG/WVXoSUK//YWo4MVW1bA+XZO2zoxXekeiN6X9zdhXMZ?=
 =?us-ascii?Q?cYQrWzxT9c4MVdm56QmaVJWi4TWvTojVQ/vAoeUlDCXpNgg82llAjfNf1PJC?=
 =?us-ascii?Q?+5nnpeLsHqVDBuidIO7afm+Ro+jz8pom3KtkRh4i47IYOnS0ALuSdB075Dyg?=
 =?us-ascii?Q?ieRQR5JQrJT8vD8pczoZUWMtbQHXie/6xSsvmuqsRGTftHj7InKS72xctBIY?=
 =?us-ascii?Q?0hSWwTQaFLmpsV+W9IUjFJDkG5AD5nhgJ1HVR46ocM3W8CizdMCUVyUW0rpD?=
 =?us-ascii?Q?W8if+Nn6voZlQVbz4F3ogPurY+RzQjOW3BVat4tw04tGo9EtsyZOCqMbLRxG?=
 =?us-ascii?Q?XvIwAHvgFS0eLqA1o4oFw41U0JMDbBtZ66WylpCqIYBHepuNJbGvMRnJU6zk?=
 =?us-ascii?Q?EJeZbt7m+pAd5SvgFHRRHp/t3JuQ3DqCwGOjK53vLb23kPIICn3Owk3BWOLQ?=
 =?us-ascii?Q?l8TJEBkmFO9rTqylc7BDgULl36OLnyMvZUnGIIOBqEPFfwWG1+YI3bYeo1nm?=
 =?us-ascii?Q?wutOSOtT+MVTLCq3OxRn13Je0Yh5C1YCsM//3fOH4F5yP92Coaifyapppc86?=
 =?us-ascii?Q?4YIk1qBkVf84JgvddFRLuANF2gDgw0XW4DNgKdYE6fGMTfB3UPeMRim/BSm+?=
 =?us-ascii?Q?iNJ+mnjswkgC+ISPApa9wqvptJeuSeb1EfInKkzT9KqQmykBxVF8TsQdE99b?=
 =?us-ascii?Q?PnyyjQZIqNWcF3NH0d0Oyz3umo8dB/KTvBD8xZMXU/BoVfd0ZiUyEblo5Jt4?=
 =?us-ascii?Q?oX6m33x4UIUmar30mRLcb31Rb1WfEcES/rMXsqujVg+ptK5Ff/4UFQj5HA+9?=
 =?us-ascii?Q?4EYRGcCSzqa0Ct1/TX7PqcH6+GxFgPN3KbgZAZDhsmfK5lDYJpSkANz4p8dk?=
 =?us-ascii?Q?4hfBJMvfCjos6YABEa2PYi/9bZF6OG1Zg7CaNmE7TwgpvQIdTCfmddrh9veb?=
 =?us-ascii?Q?Hd7vm9k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZVgsH+VOtpATlqISd5JiEupnyBbMryVIzo5oVlrVhRGiyaY06JE9KAdpeUyJ?=
 =?us-ascii?Q?ddppa0xp+PM+sJ0vNPL087BmEHD6WvM4G+DlM1aTl7DJZOFaC00ItGDJYNdR?=
 =?us-ascii?Q?Ax4hnNXpZB06S0dU0/A0ud6xAHAWXE4vBUbNX8spaDJ0fe1h3pKzLBjYiWXj?=
 =?us-ascii?Q?5mQDx9dVvH8zUyXUXv73DLQA3zHy0FyDgfbAs3Lm+ts8jxigv3HkU0xNreGN?=
 =?us-ascii?Q?54I1DxNzuNhzx920M6wC8QADiMf/rQgQwntGnc0QFPUAU4w8j4LGHNBam6NC?=
 =?us-ascii?Q?/xL56HlGWYRgT4GOl9ffQTmxzT/yAHN1ba9lBccCgqylxXn6waeqXrdndHMn?=
 =?us-ascii?Q?w7ps3pDkMeB+zZ7EGxZDOqNKwm0KfEz2z4Nuqiy6Wp90eDfeQPzB+QD2vwTf?=
 =?us-ascii?Q?sHn2dVkmneqj/hyEvyQdxcdrtigF4JoCxmnaNG1l8q045ApLRuyQWDy/wSnr?=
 =?us-ascii?Q?avYLRvi6DDIjrWJGDlrSn9QXhnpsekPY5LFV+iadHcJiX7HVcfMkA0HDGb/a?=
 =?us-ascii?Q?F9WQSBbHf2F3D6uJRcGyRmtkoOxNSxpmfa6GHrqZPWZBcpkDMveTHwD0k5mE?=
 =?us-ascii?Q?Sk+OBYh969Vp3sblDtJCeyUcIY2jXWR2Xuc16a9nd+hxkmDef4hyOzqNlHtV?=
 =?us-ascii?Q?ZtO+B5X3q4WK//z6fmgkeMJf67lpZ5KuK1p2r4wgse5A3LY/yFROPQ/Bn3Ht?=
 =?us-ascii?Q?f2xOxHJx5WDBmApTDgGTyncGblBmbPPwbBnUx+5lUfKunnBvnRCISjhatqhK?=
 =?us-ascii?Q?ATtUFkJ2wc5PsXgCR9fEdB24cSp25/R/1YCVSPN9b/cQvsiLr8U7NPTMYova?=
 =?us-ascii?Q?rMGpKnBbL75zSRbdJ8+BL3WqAn9iDpsuxWjSM6SWC6wJkoL8Io6B9UDC91GZ?=
 =?us-ascii?Q?GNhvOFlL+bp7ZryWirw8qlgde9NTirS51wTX8hR/9hhUfGoopWcWpu8UstSA?=
 =?us-ascii?Q?kaypzgEZ44l0umENrqgqiASmWmJUm55mPSDDk5qHFCrTIvTaIGNtyeWV1pjE?=
 =?us-ascii?Q?l5khC83fuhGnkG+jfmBKcGPCisbm22ymjRcG0TvJg9rv3sgxWmk2E4vUHb0L?=
 =?us-ascii?Q?6GuoxNwPmM87uztRpDPeRghbE/T0tX95h7zSTpoUamoa4uXiBk9FQyzixtyn?=
 =?us-ascii?Q?3ko441kGK6GbLKZkw0Bx+deOb7UXK1smZKU0hiAyu4JSufSjiGVR6gD4g4DN?=
 =?us-ascii?Q?rksb/FnV7bquq8hnryeHNkP48+yvuQeyW9AeDZDMNOoFeepWCL9Az3GibZxt?=
 =?us-ascii?Q?wNQ4SVKeg4JTytePZwqQEaieFPyV3RwfNobp3mf01ary2PqohJNHM+/2/kk3?=
 =?us-ascii?Q?BLsVRn5EHZ0+3383FyWRS8io9L6HRYn+12PLzk04EY71KgTpoUDVV4QMeU3Y?=
 =?us-ascii?Q?EjodhTiXv1wmlvLFj5VBj7e5JH3a3TELNQ97skedyOQmDONtZPeGU+wYf+yt?=
 =?us-ascii?Q?OTikVSU2qjasJfIlBjHpTuxJrICzecfQEKchF360IF3OjfERIy5if9XES2X1?=
 =?us-ascii?Q?jOl7FPRBFECXd71rNgR5976VB9XgMP9VyughFNFv9hIDlHmBl3bP7askLQTJ?=
 =?us-ascii?Q?7x72Y1/jIs547XMZ62I=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9ecc0b0-2715-47bb-3ee0-08dd04ceb6f0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 17:06:43.6955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MSkg2D6H1P6vVuJHWDYy76tQANsIO+EmRhThL0LuThZWFJhLUolcg9j8DX4w4s9NXwQP+3EQ1Pw6b1ZAJAxIGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8747

On Thu, Nov 14, 2024 at 12:03:28PM +0100, Niklas Cassel wrote:
> A BAR of type BAR_FIXED has a fixed BAR size (the size cannot be changed).
>
> When using pci_epf_alloc_space() to allocate backing memory for a BAR,
> pci_epf_alloc_space() will always set the size to the fixed BAR size if
> the BAR type is BAR_FIXED (and will give an error if you the requested size
> is larger than the fixed BAR size).
>
> However, some drivers might not call pci_epf_alloc_space() before calling
> pci_epc_set_bar(), so add a check in pci_epc_set_bar() to ensure that an
> EPF driver cannot set a size different from the fixed BAR size, if the BAR
> type is BAR_FIXED.
>
> The pci_epc_function_is_valid() check is removed because this check is now
> done by pci_epc_get_features().
>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/pci/endpoint/pci-epc-core.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index bed7c7d1fe3c3..c69c133701c92 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -609,10 +609,17 @@ EXPORT_SYMBOL_GPL(pci_epc_clear_bar);
>  int pci_epc_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  		    struct pci_epf_bar *epf_bar)
>  {
> -	int ret;
> +	const struct pci_epc_features *epc_features;
> +	enum pci_barno bar = epf_bar->barno;
>  	int flags = epf_bar->flags;
> +	int ret;
>
> -	if (!pci_epc_function_is_valid(epc, func_no, vfunc_no))
> +	epc_features = pci_epc_get_features(epc, func_no, vfunc_no);
> +	if (!epc_features)
> +		return -EINVAL;
> +
> +	if (epc_features->bar[bar].type == BAR_FIXED &&
> +	    (epc_features->bar[bar].fixed_size != epf_bar->size))
>  		return -EINVAL;
>
>  	if ((epf_bar->barno == BAR_5 && flags & PCI_BASE_ADDRESS_MEM_TYPE_64) ||
> --
> 2.47.0
>

