Return-Path: <linux-pci+bounces-15724-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 684369B7FC8
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 17:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 270032815FA
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 16:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919BD1B07AE;
	Thu, 31 Oct 2024 16:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="b1U2N0Q/"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2080.outbound.protection.outlook.com [40.107.241.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254151B6541;
	Thu, 31 Oct 2024 16:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730391462; cv=fail; b=m/V/0MHHdXJp7Wa0S6TjQ4drq8O+nsiL4NHe5UTpLp00A1qmBz/r6afK2Fa8SsvJ+NNZrOdeP7VQNX9u54ePTGUUbS322eg1FIiuh0OzugZ0ZLM4slKgYVqB4SxRSSIu3bOXOJxX1xnarkmtzGgzGgMXuQZ6VkaysEoPpUKn8Ng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730391462; c=relaxed/simple;
	bh=zcfiOT9xPw0rDSz6z4A0UHhaN0L0aTaJVOO9rqLS5dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fJIL8mnIHo+4UPxjw5wr6CBVSbQE4n8RFvU3KjVAcldE8HBfGUyy27yydLFTHF7duwdBczbNBxAU4aUhsKnXF+Zj7A+2EyJUpFngf42UEudz53q6YMs9bnan9QJ/ndv9Ew/BouZyhGBHDTZBud5EfIXvrIkxsntEVsmA6op+gTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=b1U2N0Q/; arc=fail smtp.client-ip=40.107.241.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uCui3cfOQSrC2xOmZOGZh54VedvMM0E4dd6F8NmrMoivPZICmVUM0BNoOWkCslnoV3PER+OgrwWr8zGnt7UK0dzARxRlDGJDhaI1ph7VEHOnO/zp8XYj4EJPBuaEx6evcitJkgsSOJZocIWlTAp7EOSxScPZZmrAXVS0lYsbl2zYkzzguaO3gsFVKWt8YfspewsJ0euYIBZkKIlNEEc1FOqR9PGzgAoM+yf1EdXyK8UQbBtDJRkQTroyRHcGpC9fy7u6VcBGZNeFl6DlNjZ/4wXf0Axjan+xlkExsELpaRLqWvFGtPjXNndO0UeQZZukOZ7QKJyzbixveZYrwLXodw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uBug01rxFSBIciVpOzDEmNILmL7XC4hrPeor/NEQcR0=;
 b=LZj0BAj+Kq65O6aCDqtY6t1MpeBu9mj1avxveb/HwJ8jhjYIau1Grl7g5Y9QCX3zc86S+RdoWEJyFYk4wGXbntNVtggvWffUvjfWT1wtMoIcJritF6JgQqXbFYZbVdwXytkmK9xN7jC2+RHpy7ZfYDnR2YTfcbUxsg7vOdF6QEx9a94hhugpOLkBILM3x/JHUzGloWyhTu3lf56pzeU68U9VPRkp+H0wV/0PdZM4ZZz329JpTUpnHeTpXoUhlsl8fRZyYfvkKznkDaDIQl6VJhMF/RsqhH/4gKEWGyCZzmA+q9myRIhR5DRstRiVddigeyKGla/IyZBeFwvPYL2F2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBug01rxFSBIciVpOzDEmNILmL7XC4hrPeor/NEQcR0=;
 b=b1U2N0Q/Fs34ObzzMY8IUz+C43eJ3IfflMhmAo12veN4j7BeyZLRt7koRAyi2kC+cI7Onyhwx80ZkcD2k9GEfCeADSAvpftl9XWYaQr6QKjlOxA5ntKLdvAFWPkU3HZQ8SEsjjAUuT2dO4Hhuekf+RELC4RZZsf2yGvS7+p6vCOL72emu3zEpr4g85CDXXSJIkj0gjGmDPokiho9KPdGcDGcrU1C3m5mMxzhuSx8AMbo/MdgrpnhNVEVnmyL5dvMwJvjJWGXjIhLvddvdVUltoE5L1c9+HevQztCpL4tgDtSXfOKe/4f9QaSEyZ5zxZPNldxVuwzkTL0s5i5Wq0T3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7355.eurprd04.prod.outlook.com (2603:10a6:102:8f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Thu, 31 Oct
 2024 16:17:36 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8093.027; Thu, 31 Oct 2024
 16:17:36 +0000
Date: Thu, 31 Oct 2024 12:17:27 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, bhelgaas@google.com, lpieralisi@kernel.org,
	kw@linux.com, manivannan.sadhasivam@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org,
	s.hauer@pengutronix.de, festevam@gmail.com, imx@lists.linux.dev,
	kernel@pengutronix.de, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 04/10] PCI: imx6: Correct controller_id generation
 logic for i.MX7D
Message-ID: <ZyOtl8zCmxSBSOxd@lizhi-Precision-Tower-5810>
References: <20241031080655.3879139-1-hongxing.zhu@nxp.com>
 <20241031080655.3879139-5-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031080655.3879139-5-hongxing.zhu@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0288.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::23) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PR3PR04MB7355:EE_
X-MS-Office365-Filtering-Correlation-Id: 8763651d-b915-4e9a-5b68-08dcf9c7882b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UXzSsvlEBFH0ZPrVXe/1WUlWDAXHvfGl8XQNgqkAhAAqi6hFGiBLyPB4n/35?=
 =?us-ascii?Q?VVY/e2uzTT+Uu3O4z/HpfwyhD0GDdGJLtrJgfdjdxkyefDkw3vGsiSmH8eVQ?=
 =?us-ascii?Q?6VvN+Dg0wQOTTulX6T99q5Shh9rm2w/n0KfWQHxWxVW8IBf10MsOu6XoXVt9?=
 =?us-ascii?Q?gg9bxgNg3E2HjPr7kxeYXNEus2Bxh2F+7f8yt0RyBA229O1f9TUROQ1GyvIf?=
 =?us-ascii?Q?tFb4YPoMawV5bl4zNWQEv9fzjpsA6fqam6eA+YwaOh4LD1kZltDKJj9LmA8Y?=
 =?us-ascii?Q?sWtSnqHIg40ffYexd0DKDSE+5IxFmLWFp2s8cUldcPtxwks/UmDln8IvZ+Ty?=
 =?us-ascii?Q?EueGTQpLE6gAKNceKiPRXnb1GDXnoMv9OiHviAYBCJuIFEsYoZMOKjmhYRwj?=
 =?us-ascii?Q?xHX3v2xY2O25HD6vd1g97knH0UUIY/76rEyT9uzcKIZyYwWVzTLbiLNAX6YY?=
 =?us-ascii?Q?lLp7Wm7vOCtyJzYLXp2YhQ+FKybmqxznYqe0IPs4dUWGFAe09rYlIHSz45lE?=
 =?us-ascii?Q?6/AmELsLDv91U/yepIcu6Ytd3Y4irdKGZjkxEJsGqOma6MS+KnAPvDaQLN0w?=
 =?us-ascii?Q?jdIp7MbHxuJ+Gthx8CKXOlZGKVjbUATNHHu+cZ/vrVJJ9br4V+Jmm2GQIFh3?=
 =?us-ascii?Q?+gusUltbYndROib+22Sl+gMGKQ7+FnlRr0RkgPXbvQSf83T+iWI5K7I5lgvz?=
 =?us-ascii?Q?EQCxQExxB8Bl9x/shX979e3IrrimPeygyYesKnuKcnPULdqcuU9NDmvU5H78?=
 =?us-ascii?Q?BxwJ+SkT4V0k0EUROcySOEIZ3TyvyAVcEHaGOpE227TC33paDr2tkFklJ3PP?=
 =?us-ascii?Q?yvv1u2wAbRviSaKoLeLqNuoewy4HXFlh1y58Vw8Ik/ln8RE2PJGFcnPwDdsm?=
 =?us-ascii?Q?B1Gx52l/ePwO2w8JYbkr0AW8zK1VVOKBEYWPWWbQ8keUwXuRRa44moeTSF4g?=
 =?us-ascii?Q?QvWXqedkU7vqtGKBkPCVrix2ZPKwDTmuUSXd/96CbKpxnD9TL7iZddmMZbGt?=
 =?us-ascii?Q?axlCK2a041F6Is+nYFeI+MpwuOG0Lz4qvYQ/u0tkaR2kGZni1YoCmT0jBuCE?=
 =?us-ascii?Q?N4ExUpD1xy6JUPzuC4e0B6cn9n2PwHSbdJ1vANz6wMoHflwA0na1gVXuWGDR?=
 =?us-ascii?Q?r306Wx2h8Qa2U0Vt0/VUfTABY2PhRH4La86m3NhLQ0+pJ6mJPM5VDOuUO3yb?=
 =?us-ascii?Q?07fbTJDhPqUqFtkYrqVyTvyRb2rB8InUZvPe9Y5yaIiDUSweKNVvUhMK1gre?=
 =?us-ascii?Q?vv2swZBLrJaz4RxHPj8oyzUQS9ditrHoq998nnp5nZgQdIbEyX/0z0EVNHq6?=
 =?us-ascii?Q?OkKQOB3PDnuw9qTxoYqm7d5RaLNUO5lykgd2sGpHqsmarn2kZ/6JAgkQUuIa?=
 =?us-ascii?Q?UoQ/BSo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yqYwO1/05oJnyp5D6b2EhLiUumLnfJOUgA1JZErccIzJbV3FqMNnNfQiHJLX?=
 =?us-ascii?Q?y5slqlymRRmxQ2Q6EuOj32Wf8fh/ShqS9PkqVHjEkonNcWQ3w3xwxvGV8U4J?=
 =?us-ascii?Q?rulBQJBAFKtPcH5KmRgnJ2/GmELTrg7fCadkUZ8xevR1/Ggt70aYRQ782kkW?=
 =?us-ascii?Q?CjSftCq5B9d1PegVPA5id9VNqIggC336hxAlKP7IHhBys+88msJ3Gx543BWk?=
 =?us-ascii?Q?aI2IFDN8C6PaqMKfyUdWV7qyTFs1cEoCJCXuQMQ2SYDdp3zDoo9tgeozKUn4?=
 =?us-ascii?Q?SMsXiBtQMpMkT9YpsLw9iVlNe5IqDA3X40JJ5eg+frpsPgulCVs9AS7TeHrT?=
 =?us-ascii?Q?6huLOWb7TLpDRJ6eBo4iwnbSQ5/035btIbKWz1cVOFqiI1PhDq9C5nFlkVT5?=
 =?us-ascii?Q?lQXhboOf+08mAWV9ZTBbQQC9YEk1f6YzaFFbzYYK3ioCuOTHMJnwwA2mYCA5?=
 =?us-ascii?Q?bofkI11wh3HdXe832cTPGWHzjO8zu45tUEMrUGR9vkJjERYce+id5wY8vOzD?=
 =?us-ascii?Q?d0FZiMHgmeEdGs/ik5XALq2kFF0c8ZIfWnjiCJdxEPm09TWZqX6vo8JCmpOq?=
 =?us-ascii?Q?lZA35lQn65BzB4IuWZGMYkXsBokU8po4gdVfrTx+zBwU9HgRReNA8KNlSgUR?=
 =?us-ascii?Q?+/4P0mIpiB6lfHVlyY+oU863suq4fp29PVD2j4Z29iYdjbJ61PrPGLmlHD5Z?=
 =?us-ascii?Q?MeoLh6qI/sZS0tN0CHYJ7LKdLvkFCLINlaGWJdov0bXWzOV4K8hEiYHG3Xqt?=
 =?us-ascii?Q?94RUA3HiAmegV4x1aCNhtugKPh+zEv+MXll7z6X0Lh9GHF3M8aZSkQ9ymqkw?=
 =?us-ascii?Q?SGroZUXs60jl02mV4Jzo3SfGCf8haXnI1fazM3Xjz4aZdD+eNfSoOTHxANPB?=
 =?us-ascii?Q?1bPU7sJXsp/sngy/NsR7dr/WE4EDce4OBrpvcx8JOKJBnQFkjRxkdv7pjvRa?=
 =?us-ascii?Q?5pk/PN0OmpuoLi1I9khqtNaca1p6uxHIqQVSEreFgsNf2YXYdcTSx0/Sq2Nt?=
 =?us-ascii?Q?bqJJ6dgtJPMVlCB9+CecKXJ8mMGJq1KUyehGJxxfr4/z4ktMwxuZobQJgO5K?=
 =?us-ascii?Q?pYPX5Lf4pMbpMzYAJ5ZNuB4aL56A8qf9gi3nccDQdC3WlwotwKDEUkhlOYIZ?=
 =?us-ascii?Q?BFfufpuHLgTB6UBjmIGf0a4lRd212TgxsEki3zTJK12ajtJgvS/z/ttcrc0d?=
 =?us-ascii?Q?PzHh7fswPazcAYfTl7MMkIW2Caqlzxd8Dmj9RdjYxOxtBNoPX0BpBTDad3N+?=
 =?us-ascii?Q?wVQ/K3rFCYupWXHkjoQE8iVWCN/FTT+qlQtjWAeGdrzc3DCL6oLuE2AfDBgG?=
 =?us-ascii?Q?PODHyoM+8g+mKb2EA+dl+jyC4H/3C/sG5uRh+3uCPKcR0c97JeT8K+OngzHD?=
 =?us-ascii?Q?KOedbSci4l0SCKFzogH985sibuh4K4lbsAJfJ+1syHizbRlRmL6zvo7vDSuA?=
 =?us-ascii?Q?52dZLFSaIibwnltyXclzYUap7mSta+Q4JILc1SQQ3zkHx+UY3KORbPDfVGD7?=
 =?us-ascii?Q?uiVxJnGxGqokGdjO6nur36cO4dgmOzwtE7jQXmtae+EH7OHhLblQ3ZBo6X7V?=
 =?us-ascii?Q?q2tqvKxQ0jNbxwRm4oq4RriJWNIXKKBwdWKiqeBX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8763651d-b915-4e9a-5b68-08dcf9c7882b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 16:17:35.9378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ucpw26UpeUMHR/zkMArTutqhrS3NC5t8ULVeaxuGAWSOIkhIpKbY/t1X5U40VqST2W1Wnxt5fduIYC3YK3U0MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7355

On Thu, Oct 31, 2024 at 04:06:49PM +0800, Richard Zhu wrote:
> i.MX7D only has one PCIe controller, so controller_id should always be 0.
> The previous code is incorrect although yielding the correct result. Fix by
> removing IMX7D from the switch case branch.
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---

You can simple mention previous discussion here.

Converience for reviewer, and past previous discission here.

"This is just *wrong*. You cannot hardcode the MMIO address in the driver. Even
though this code is old, you should fix it instead of building on top of it.

- Mani"

IMX7D here is wrong athough check IMX8MQ_PCIE2_BASE_ADDR is not good
method. Previously try to use 'linux,pci-domain' to replace this check
logic. Need more discussion to improve it and keep old compatiblity. Let's
fix this code error firstly.

Frank

>  drivers/pci/controller/dwc/pci-imx6.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index d21f7d2e79dc..7479d3253f20 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1344,7 +1344,6 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  	switch (imx_pcie->drvdata->variant) {
>  	case IMX8MQ:
>  	case IMX8MQ_EP:
> -	case IMX7D:
>  		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
>  			imx_pcie->controller_id = 1;
>  		break;
> --
> 2.37.1
>

