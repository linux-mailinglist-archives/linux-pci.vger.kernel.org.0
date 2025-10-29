Return-Path: <linux-pci+bounces-39688-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 331FAC1C4D5
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 17:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 739A54E518E
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 16:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4922B2D8DB9;
	Wed, 29 Oct 2025 16:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CpHeD5KY"
X-Original-To: linux-pci@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013071.outbound.protection.outlook.com [40.107.159.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0966228C854;
	Wed, 29 Oct 2025 16:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761756833; cv=fail; b=NvPoY1iub/QARd+z49JpK6kLH2vml5L1dTg+fDk3mGHYznN+gPzcEfrtKEdsxegeDGIvrkuxV3IfHkjIUAbxLF3/RMTj9qZyQxxMDP/8M3u7C4GSRkRzOEtoKnjdNGjmQ/oevDPmPjnxXnh58R14cY4Xd9KDOf7XvsKXt7ACG1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761756833; c=relaxed/simple;
	bh=oXQQpx3/C1aTaESBHKDaW1OIGD7YLmT6nMqks0CMjAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IpAEeBqs7/ihjFqMx4fxP+OZWttAlD5NLw/tQK7t7/FKW11uryOiZNmi6MpBczB4Fd8Ft1zw7s2Qe17XYQJzdNhSBjx9dWqQPo9vELbg9AVA8Tb4W/qL5qCXyYE2D1wH1fWUWR9aEd5FbdBUomJkfo2wNQqJ490hg+DzOKz9/Ss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CpHeD5KY; arc=fail smtp.client-ip=40.107.159.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DJrY4phA2dYKabpOLr+VHZYW0Nm5unRD7mBKdfRLnIWMhdOf7rH9OG/T5deIaW9g/3kcomAFWiRcyTP589wOKkfCU378UaEJ/su6Cej/2NR87i3z09VEdcngNy/7FwTOn1uWOlmdleBlTiuPKb66fxli2Rq1Ak8gGiwH5gX8X3RREBiBwysKZMLesipN9GqEQkPqTUfftsKOnZVtGq1K1TJjzzW9Egh8yJj22op7l5LXLT/7LtkpZUEfPEzsO3d+WZUvAvGO+lUEE+swnpYGu7RM4z5tgyY/ujUbb1QtN0tu9sVm/L8uoeDhkUsywkLTA8i8KeJ0ONBkGbln4LzAow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PfCsxc/aGAZY1t247YSYxi0wyZ3zQsx31ehkl5916Z4=;
 b=KUOrjVE9BdT0eq+wwSZnzYT4Kist03OFD7Xpgjfp7uI+1R8S/pyMXfXrgA9BUvbn1r/ogszTckaf2o+s2/mv8+kL0pvSVh1vnrC9UrkXmHU4LR0QQJcrtkGQjKGC5UwghXlAMxmBKHJDpU5fZVojP2mgJMZCPl8Hy/IgCoTPAnn9h8Z1Veo0xLmcmGBFFOMjcnup6kEUbFgf4fX4eNjPjcLi+tmdOeH/dss6ZN69jwo4oovd2SvV/folSgSouD8G+1i4a+BDopmIIM0p622QoCzMzUMXo9JWPz+5UaAd1VAH+S+QJzDF2AKj2WFyu4rQ+oOHTY7NuOBF5F6cE8uDnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PfCsxc/aGAZY1t247YSYxi0wyZ3zQsx31ehkl5916Z4=;
 b=CpHeD5KYZOVnAVWib9QB8HBSjT/wD9UTmcknfgyTthBaWwGwVclJQlpdS8m2TiAOngLvXS76sUOePIdnuhB55Kw7XRDsqZHXs+aIRPWMIM3Mua3JE1U6m2TbS8Az2g3rR/tyj9jSGedSyedEdRzFgWUdBfwA2hHFnm5s386+wfG69iGwf/E/Ti6yK2dFdoXbiUpBPXTDt+hJqQgCvPtJkb0B7AAzgYqNhgqHynsp/qlePPTyqpjsw/0uc9+tTjPfVBcyEw1UqWWGyMbeJHHE2cIgwsXPXE0LCpT14/zNfvyVw7T8FjBldZkAoAZ3YsO9HSlOg6a3IrK5j4Yuni7k+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by VE1PR04MB7438.eurprd04.prod.outlook.com (2603:10a6:800:1a0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 16:53:48 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 16:53:48 +0000
Date: Wed, 29 Oct 2025 12:53:40 -0400
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, jdmason@kudzu.us,
	dave.jiang@intel.com, allenbh@gmail.com, mani@kernel.org,
	kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com,
	jbrunet@baylibre.com, lpieralisi@kernel.org, yebin10@huawei.com,
	geert+renesas@glider.be, arnd@arndb.de
Subject: Re: [PATCH v2 6/6] PCI: endpoint: pci-epf-vntb: manage ntb_dev
 lifetime and fix vpci bus teardown
Message-ID: <aQJGlOIJBY+44Q0v@lizhi-Precision-Tower-5810>
References: <20251029080321.807943-1-den@valinux.co.jp>
 <20251029080321.807943-7-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029080321.807943-7-den@valinux.co.jp>
X-ClientProxiedBy: PH8PR02CA0022.namprd02.prod.outlook.com
 (2603:10b6:510:2d0::12) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|VE1PR04MB7438:EE_
X-MS-Office365-Filtering-Correlation-Id: f4663688-da91-4b41-c35e-08de170bbad3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FzGGQPhkG12Xei91QtwcGRtW3rc2IyDpcLJUySdzYwxYqXEPNKCjEsBXmfdt?=
 =?us-ascii?Q?fHrazCNjHjQBm4QUWL3mfv0rMQ4SXfQUc1YnqeI75e/Jw1lFf/DoAQhNgZvu?=
 =?us-ascii?Q?N/MeVJ8HuOS6HLAoaqrhaJBsy51bvPe9B2E+CRKK1dElpIj1AVQYzDnrjlQ4?=
 =?us-ascii?Q?Zi+YdMTrWNUPIZWqwzhLRQYSyn1fJyJdAzQsJVhzE4W42sSNqpDdCT/zES2L?=
 =?us-ascii?Q?tCZqLZo4TPraa/z10v1W8pC+/+5L+EwjmfC1o1sVIxiUeOUyGkqjGuy78Uru?=
 =?us-ascii?Q?pEzhAKJV0zIZIPPkeGD1JTxCTXRksWpSFdDHEk7NWe5l/Wh8ClwRi4+6ent2?=
 =?us-ascii?Q?ouk3UH3krx4YB2WaNoS4LMD/pxdJj4cMtClP+YcbJQ2ITXrze1Jrnqj+7+mf?=
 =?us-ascii?Q?9nQCM6PzFpLnuHsoNrvgQwBXt/CbHLxOyYp5W7QpFibDlpYy3gy6QiQ2lKZF?=
 =?us-ascii?Q?PfNE5bYMYiwbEYEXsaGmCzpu9GhTmoA5yDsFj4VAuSh5keDkWNIpYVseuZQZ?=
 =?us-ascii?Q?TrJ5XGbPKtIb6o9ZC9WLdKnRoc+nEBl1NOnnPxVSQLtCZH32J4FSB2gP28W5?=
 =?us-ascii?Q?oG49DQSjLs5MHHc9vEWvSYG9ZsOdJ+QZM/cXSLiuszplbl6NMfW+KDslS1gn?=
 =?us-ascii?Q?hol4jrRoU1uQL6hxoPgdH3AUOCCfz99f8pn9bz4jmScEwrYvL6n+KhGjLaZ+?=
 =?us-ascii?Q?6dXrj1YmskVt7EKtPMEPXwhwSoN8iLzd0WMHgfO4L5Vk8eJGIshZJNlU61MN?=
 =?us-ascii?Q?unsxbUSBJ23WsmejasIof5rBYdxWQgxl4dDlcXjJFaoVYrVbQWvnVvI/heeB?=
 =?us-ascii?Q?/2T0G/fEkxdfpQ3iS9T3vifGj5rWGYrUTh1omYAr3EanO8aeAfGrGt2c4kln?=
 =?us-ascii?Q?ZlWGNF/6ypIorf9odJm55wsDdq2xYRBuRCrJGEq+3wEQOE68VcAg7vuSS0O1?=
 =?us-ascii?Q?azAMh+8kDche8gCmqTAABVmiHTMczABIZpw329eik+Ykui7x0o6iIQGzRyJ9?=
 =?us-ascii?Q?XbN3BCfp0XmLt9NfXxhVVttrPQ+GfHh97d7jI5SytfEVpBVSUfpGPr+nPAR1?=
 =?us-ascii?Q?7H668tfCktEf6plJ6gfJkLO998BUtXsO8RffncN8qjzdmabP2oKx1wmhiiGs?=
 =?us-ascii?Q?d6xjuaYpCtKtVC3pbo60BEMF6RcYsSDaBgrZU+J62nmgm+IbaZiU9Y1jrhSx?=
 =?us-ascii?Q?GpHpUxtxeS5LxDaRzjVv0O5vC9/t7i4WYg5g6vtYYNqlpNp7DL7eyt7I8I9C?=
 =?us-ascii?Q?f+xotmhDtkRqfETR252c1NGUmJ1JvTNvI9rlatnlzKevBz8m1cssCuJKVKFO?=
 =?us-ascii?Q?1EOsT0NT28wpM7V9E3e0zRtSx0ZFE72NA/gFHXsYmi4ZNDpiawQMQtOw+FLv?=
 =?us-ascii?Q?eHqvvJ9GFsF7VvjYQ6WQ5rMLEdyVYabwSUdQirUPWHnsKSa6k+BpusLQRO65?=
 =?us-ascii?Q?+ZdIL2ZAcL7s0yBOd0AU321mtlwWpPA9VnRzkWVSgrGXEP4HlsebqKEY1EP1?=
 =?us-ascii?Q?4Uht1x2V6N3eKc8fsEk5OwAs+1vcWjrv4b56?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dxw+E/6sRX9HQqG2KvBf7Uhv3KaUd+n32f0t11eo/5SC9UfXX9jrOwS4yJsz?=
 =?us-ascii?Q?ZC3YmGdWJtRiaMwv9pnlpmTp/I4Wppp0YvmvM2gsbTMWLUylQEehAMOe3Ssv?=
 =?us-ascii?Q?nsaxLyP9rmb/5p2Z9iXHoyczHdnGEYVZKUes1Og7hXvy4VZJu+1buFgwNmWm?=
 =?us-ascii?Q?CUf1UOovNIQON5+NfwtdoaxuUEtKxoNKISzbDchsukwNVSN2cYADq2N/a7Ue?=
 =?us-ascii?Q?vkVEebrGADSn1XsojEUwxiXdIJddXv48TVlthebS2vaRjXNrayQJYjldP8wC?=
 =?us-ascii?Q?u3PGHjuxYBe25zhlEBoVBHEEV2EvaWEpYw6BaoV5b/Yt/sjofJ47GYW81K4d?=
 =?us-ascii?Q?5Qw422D63b3MFxjIwXLOBpbioWtD4nFWu5lfzK84/4yNrghx6wjBeHmh97G7?=
 =?us-ascii?Q?9e2jaKp03BAZXNLDNzYT7X09lW+YMi6Wj2tZsMtHZ6qrUBGLUgpae9gxXU3Y?=
 =?us-ascii?Q?ppKy9rbeA5Psl8JtjHoYFnWz9H3IGCaKUWOOYaR+lZTcTgzH4ftww81cahvU?=
 =?us-ascii?Q?JdU7jT3J0gPwt33fmcpu1h2RUMFz1XeByVDxfkacypzFOT0tEIDgpELsrxeF?=
 =?us-ascii?Q?6CaOsxNXRimr6typiEuE3eMVPJCGWU0501+Ed6kH5V3ioESm4jl82DfNbRXE?=
 =?us-ascii?Q?NwU/eoybcXSXEzblNEAnY2M7KmGCRwuIee9IhN0aY7Anv1AKLZCf2eYOLfjl?=
 =?us-ascii?Q?trBVDLOQKT3m2yP5tpLsGrhvmPDXfU6v0BbIP2ah/rPROqBu1DumP7hBPLrJ?=
 =?us-ascii?Q?Vexergzr3jVwpWBOxhmRSpt6Yuytna/7tI60OPDfSWMMbqxEDjEUyQGgahsS?=
 =?us-ascii?Q?XB1HuLQk1nsv0CSsvkWIkIjTg61vpDqzn+3RhA0/qTjzNCXDsaJdTjIgI5Kx?=
 =?us-ascii?Q?qmbdTl4Na135EW+QzT20Jp927gBW8bHyYaD/zw1dX20bZUapQsQsvWOTgXTi?=
 =?us-ascii?Q?vw7Hh7yNuH6pMEzkQneTSY3IaSkps18S/xY9tNjCc2LIBF3hTVkHr0oJd8z4?=
 =?us-ascii?Q?r0X8sWWHxJvXAwFKkIZ15w6ovrVzZf8K4GCx05XI7MyMqMTy72b/AOqp2MTE?=
 =?us-ascii?Q?DnKYQe1EMf0BrOAq1OPTewZdIauMqSw98rES+CK658aj9WI1IHCeqCyyuysq?=
 =?us-ascii?Q?B7MRaJ5JuyGKO8rVhkC81G7rAseRXjMIAcJ44oRa0RPezHNr94hn2LNcwLSk?=
 =?us-ascii?Q?fLbTiOMWKz8B5wc11jh8kR4hB1f6UOCEXa2n9owd4hgOH8R2kHZWySo/w+U2?=
 =?us-ascii?Q?NfQC/+eWiHkC8LbqwX/ZKxSgEwOOSJZKRPqjwxEH3haKHGPAQ1KfvyFoN9G8?=
 =?us-ascii?Q?yG3ugojSEcqh1I2GQOKdY/CAYsNQlvPNz0VDJLfvlM0hgo1F5eddyQjXuvN1?=
 =?us-ascii?Q?4eSUPBS8nzRUcQA2G4ToB1WFlgiJ3mKOgShD6GbwodojJAiugng6W8jaZmsV?=
 =?us-ascii?Q?+8KaJsMrDQEIx/FU4rBfN4LWCscWTydybWV4GTPO0gt3B13NRSg63Hn91hQr?=
 =?us-ascii?Q?s20CwIoVqd9nkH6+Jg8664YiJh5Q8V1slvED7jRorw/1pyqvm7fonp7REH7Y?=
 =?us-ascii?Q?CIi8DDRWbLZSUn0Im5HktfoF0XW1T0QGsFA7zFC7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4663688-da91-4b41-c35e-08de170bbad3
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 16:53:48.1054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WlB76SEt9eewn23JvyV8Ry1ao8Dr+btD4e+DmjwCnW0kBzWKLsw2X+cZA+xJTyBCZDLMYydWVQOaN8pwaWIABQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7438

On Wed, Oct 29, 2025 at 05:03:21PM +0900, Koichiro Den wrote:
> Currently ntb_dev is embedded in epf_ntb, while configfs allows starting
> or stopping controller and linking or unlinking functions as you want.
> In fact, re-linking and re-starting is not possible with the embedded
> design and leads to oopses.
>
> Allocate ntb_dev with devm and add a .remove callback to the pci driver
> that calls ntb_unregister_device(). This allows a fresh device to be
> created on the next .bind call.
>
> With these changes, the controller can now be stopped, a function
> unlinked, configfs settings updated, and the controller re-linked and
> restarted without rebooting the endpoint, as long as the underlying
> pci_epc_ops .stop() operation is non-destructive, and .start() can
> restore normal operations.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 66 +++++++++++++++----
>  1 file changed, 52 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 750a246f79c9..3059ed85a955 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -118,7 +118,7 @@ struct epf_ntb_ctrl {
>  } __packed;
>
>  struct epf_ntb {
> -	struct ntb_dev ntb;
> +	struct ntb_dev *ntb;
>  	struct pci_epf *epf;
>  	struct config_group group;
>
> @@ -144,10 +144,16 @@ struct epf_ntb {
>  	void __iomem *vpci_mw_addr[MAX_MW];
>
>  	struct delayed_work cmd_handler;
> +
> +	struct pci_bus *vpci_bus;
>  };
>
>  #define to_epf_ntb(epf_group) container_of((epf_group), struct epf_ntb, group)
> -#define ntb_ndev(__ntb) container_of(__ntb, struct epf_ntb, ntb)
> +
> +static inline struct epf_ntb *ntb_ndev(struct ntb_dev *ntb)
> +{
> +	return (struct epf_ntb *)ntb->pdev->sysdata;
> +}
>
>  static struct pci_epf_header epf_ntb_header = {
>  	.vendorid	= PCI_ANY_ID,
> @@ -173,7 +179,7 @@ static int epf_ntb_link_up(struct epf_ntb *ntb, bool link_up)
>  	else
>  		ntb->reg->link_status &= ~LINK_STATUS_UP;
>
> -	ntb_link_event(&ntb->ntb);
> +	ntb_link_event(ntb->ntb);
>  	return 0;
>  }
>
> @@ -261,7 +267,7 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
>  	for (i = 1; i < ntb->db_count; i++) {
>  		if (ntb->epf_db[i]) {
>  			ntb->db |= 1 << (i - 1);
> -			ntb_db_event(&ntb->ntb, i);
> +			ntb_db_event(ntb->ntb, i);
>  			ntb->epf_db[i] = 0;
>  		}
>  	}
> @@ -1097,12 +1103,24 @@ static int vpci_scan_bus(void *sysdata)
>  {
>  	struct pci_bus *vpci_bus;
>  	struct epf_ntb *ndev = sysdata;
> -
> -	vpci_bus = pci_scan_bus(ndev->vbus_number, &vpci_ops, sysdata);
> +	LIST_HEAD(resources);
> +	static struct resource busn_res = {
> +		.start = 0,
> +		.end = 255,
> +		.flags = IORESOURCE_BUS,
> +	};
> +
> +	pci_add_resource(&resources, &ioport_resource);
> +	pci_add_resource(&resources, &iomem_resource);
> +	pci_add_resource(&resources, &busn_res);
> +
> +	vpci_bus = pci_scan_root_bus(&ndev->epf->epc->dev, ndev->vbus_number,
> +				     &vpci_ops, sysdata, &resources);

look this part is not belong to this patch. just change API
pci_scan_bus() to pci_scan_root_bus()?

Frank

>  	if (!vpci_bus) {
>  		pr_err("create pci bus failed\n");
>  		return -EINVAL;
>  	}
> +	ndev->vpci_bus = vpci_bus;
>
>  	pci_bus_add_devices(vpci_bus);
>
> @@ -1147,7 +1165,7 @@ static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
>  	int ret;
>  	struct device *dev;
>
> -	dev = &ntb->ntb.dev;
> +	dev = &ntb->ntb->dev;
>  	barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
>  	epf_bar = &ntb->epf->bar[barno];
>  	epf_bar->phys_addr = addr;
> @@ -1247,7 +1265,7 @@ static int vntb_epf_peer_db_set(struct ntb_dev *ndev, u64 db_bits)
>  	ret = pci_epc_raise_irq(ntb->epf->epc, func_no, vfunc_no,
>  				PCI_IRQ_MSI, interrupt_num + 1);
>  	if (ret)
> -		dev_err(&ntb->ntb.dev, "Failed to raise IRQ\n");
> +		dev_err(&ntb->ntb->dev, "Failed to raise IRQ\n");
>
>  	return ret;
>  }
> @@ -1334,9 +1352,12 @@ static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	struct epf_ntb *ndev = (struct epf_ntb *)pdev->sysdata;
>  	struct device *dev = &pdev->dev;
>
> -	ndev->ntb.pdev = pdev;
> -	ndev->ntb.topo = NTB_TOPO_NONE;
> -	ndev->ntb.ops =  &vntb_epf_ops;
> +	ndev->ntb = devm_kzalloc(dev, sizeof(*ndev->ntb), GFP_KERNEL);
> +	if (!ndev->ntb)
> +		return -ENOMEM;
> +	ndev->ntb->pdev = pdev;
> +	ndev->ntb->topo = NTB_TOPO_NONE;
> +	ndev->ntb->ops = &vntb_epf_ops;
>
>  	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
>  	if (ret) {
> @@ -1344,7 +1365,7 @@ static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  		return ret;
>  	}
>
> -	ret = ntb_register_device(&ndev->ntb);
> +	ret = ntb_register_device(ndev->ntb);
>  	if (ret) {
>  		dev_err(dev, "Failed to register NTB device\n");
>  		return ret;
> @@ -1354,6 +1375,17 @@ static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	return 0;
>  }
>
> +static void pci_vntb_remove(struct pci_dev *pdev)
> +{
> +	struct epf_ntb *ndev = (struct epf_ntb *)pdev->sysdata;
> +
> +	if (!ndev || !ndev->ntb)
> +		return;
> +
> +	ntb_unregister_device(ndev->ntb);
> +	ndev->ntb = NULL;
> +}
> +
>  static struct pci_device_id pci_vntb_table[] = {
>  	{
>  		PCI_DEVICE(0xffff, 0xffff),
> @@ -1365,6 +1397,7 @@ static struct pci_driver vntb_pci_driver = {
>  	.name           = "pci-vntb",
>  	.id_table       = pci_vntb_table,
>  	.probe          = pci_vntb_probe,
> +	.remove         = pci_vntb_remove,
>  };
>
>  /* ============ PCIe EPF Driver Bind ====================*/
> @@ -1447,10 +1480,15 @@ static void epf_ntb_unbind(struct pci_epf *epf)
>  {
>  	struct epf_ntb *ntb = epf_get_drvdata(epf);
>
> +	pci_unregister_driver(&vntb_pci_driver);
> +
> +	pci_lock_rescan_remove();
> +	pci_stop_root_bus(ntb->vpci_bus);
> +	pci_remove_root_bus(ntb->vpci_bus);
> +	pci_unlock_rescan_remove();
> +
>  	epf_ntb_epc_cleanup(ntb);
>  	epf_ntb_config_spad_bar_free(ntb);
> -
> -	pci_unregister_driver(&vntb_pci_driver);
>  }
>
>  // EPF driver probe
> --
> 2.48.1
>

