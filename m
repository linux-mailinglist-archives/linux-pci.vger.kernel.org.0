Return-Path: <linux-pci+bounces-15286-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A249AFF0A
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 11:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C97D1F22EFC
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 09:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2571D47AD;
	Fri, 25 Oct 2024 09:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EJywoHHu"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2044.outbound.protection.outlook.com [40.107.249.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6921D27A4;
	Fri, 25 Oct 2024 09:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729849905; cv=fail; b=nA1OTP1/2tZL8ihm2EOtOa7hrMRUS7YX/hiVbEXi0mi3LP1tjuNg/2T5Zsf52O0qAILuW/tLUgjABy4Uy1wpTHGIzcaUX0Q9/TKLghDzHnWERGL98cIq+RlhQxRcC8YuHMxpUgFMvVUxFuNPLuRZuevVO239erbAbWiVTfXbiLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729849905; c=relaxed/simple;
	bh=V8igBrSr0c+THoINQ+mh5QZ56L3VDrdcZUuhukyopwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hMKNVO8MXeTl5ayjx+G0RCJKy5fm9mvfKVexaHRL5Za389axl5jFGCddqpmWQjDERRLaIInJs87wdT3aGJPyNbOC8pCREZdnXYQ9VFmqdUGYXIkHOAPym+LoMA1gdxGk81L7+4q1NF2KzvHGYzF7TfFwEdW4AL5guRDpqZ1DboI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EJywoHHu; arc=fail smtp.client-ip=40.107.249.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RJ9X9IGBzExyJR5gHqizWBGzs5JEwUQvtsSIuI614GsRFUrxxrm+bwsDe+fJVSJpTrMfeTj69N+KVz5aLhs7ASk0hwcW54AjnTE/WIYNpPqH1gzKzo39NLS8f9f22u6YvMKPbTnRU70vJg9ROPSmlDj8qqPJMq4nKZVsV0HufvskOvuB6QYZi7Ke9E0Air7t4O4e6bp1AQrul+P0EcJFJpkRIfQ+s0eNNREZXWNhD6TUVOdY6xTjAWlQL05g4KWa2vcY6rGL0pEKhPrpCS6RoglByadTv0o0t8NHf+2Y/R04K6iSVzFblJyNyhRgvWntghZyl1aC9tndipKGRD8W7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dtbdKIzZ2+s8m5okwWDyFOrOFdbAPU1cPV/HFGJkAb4=;
 b=U7iHXEGYu6RgOBs8B9Y61Eib9zIlx3doHShmkyNvOF7X9RtS5/3CfgQAX03M29EADx3W1Ebr1wYN8iwtgogZXL2354op3D3PeeOkhfo/MXEqBT8mr/lotEYaUPOa857dtoGd26FDIBq8W1lreKdP4zP7W/1RBSI648DuNjYbBM5S1oLaqYP3PDCp6ULTpFArdFd5SAAQQrJ8ZeDXoO2oNVf/rAPiq93txa64CZJNeJsJ3Oc34S0+RjZnbwQbHZj8WSrST08CCkRyYxsz2ONLwocVhNYNEdMPfeFcxPR3b8cxE7dkRw0+7llNdePEy/1aXapNyKdYl1tyLPPAata3TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dtbdKIzZ2+s8m5okwWDyFOrOFdbAPU1cPV/HFGJkAb4=;
 b=EJywoHHuXCiEJk+gA2HXZ1SdtNSFqWzTg2uuOGEPA/Qh8C+Lu2nQioVx8DESFRuOtqY41DIwnHkAzVjw8o2FABDOciCi5ElJJG7xUPD3Ke0k6IbcdJXfs1YTcHeG61viUfajPGLSE6VfbZkDGcIv7bkFOiaY9qFq1EMhi97XVjCocZD+uwV6JTuiO58maoJQsnmpdcrrTNTGy8oSbtyqPaY7gl6xMDcwyizsc+OtmzpVvQrOxzjFFGDrSZcdwUPKkptUwUUwzoVBm7QXsb55cf0+5Kl7vd2RmD60ItJ1jFhfJG8BdRkKsyM2+KNTYKjlhzyCuJgK80KNK/K0LQteJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM8PR04MB8034.eurprd04.prod.outlook.com (2603:10a6:20b:249::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 09:51:40 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 09:51:39 +0000
Date: Fri, 25 Oct 2024 12:51:36 +0300
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
Subject: Re: [PATCH v5 net-next 11/13] net: enetc: optimize the allocation of
 tx_bdr
Message-ID: <20241025095136.dlft7ixliiixejkv@skbuf>
References: <20241024065328.521518-1-wei.fang@nxp.com>
 <20241024065328.521518-1-wei.fang@nxp.com>
 <20241024065328.521518-12-wei.fang@nxp.com>
 <20241024065328.521518-12-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024065328.521518-12-wei.fang@nxp.com>
 <20241024065328.521518-12-wei.fang@nxp.com>
X-ClientProxiedBy: VI1P195CA0045.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::34) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM8PR04MB8034:EE_
X-MS-Office365-Filtering-Correlation-Id: dc92cacd-9ee9-4692-5493-08dcf4da9f9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RoSFyrHwUh70y/ZouRYOfGVczAa1SjAiWvyldtD+hpHGCzcopUPPharbzBlv?=
 =?us-ascii?Q?VwtTbBBK6zUyErjOaLWX9mZ+qMGLZV50laliJbKDbOaCtVd0lAlUFFSar08M?=
 =?us-ascii?Q?FXO/Wg4A04JgFNcHVOA+0FD9+neg05klAYicLXdXCg2fMxdTPuqUaJzr8JDI?=
 =?us-ascii?Q?wS1b/pAb0m08uf+mxt3+QJ5+vfXFX8wfje+zhM0Yln6/DyWxo+OfJDNmZT4K?=
 =?us-ascii?Q?ZQyyEy1Y3LNz7SXrqzaqQFyINlkS/m7yj8oeDhImhNa+omDmdpc5lrPy+sKe?=
 =?us-ascii?Q?DA9Y8r/9PssKsZutzJw+ChaQw+i6md3h3+Gfghg/Mc9D20FiVhG1+0jzABDl?=
 =?us-ascii?Q?u+ePqjQo8lQTPRkxju1ezojYXT1BOcDorm4hynDQtGMs4Zz7KZTmyZkeBnxN?=
 =?us-ascii?Q?sOrffffjrLzd55Qj6rofMyseelGjTGZN49J1f9Av6cIWqaeSDi7KtVA9MXwW?=
 =?us-ascii?Q?fUBzvzeiQl5xVDd4PiAHIB5sHK/y6cYRAJkc2NopHiKuaa7LE6L3qVEzZUHg?=
 =?us-ascii?Q?7TBBdBvIl+vgvajIKozvjsymVoWGUC4XhLHhQduxGmEtAAz1CD59tiSxPaRw?=
 =?us-ascii?Q?Zz6nrfR6xbV9+GNBejLhFYbvczjrA5/8Vyz9Ax5cesHQktVmngJMKpwDsA86?=
 =?us-ascii?Q?D6e+/ZJjxHLWoAloTbe7aQDY16M1InaXeMrsV3NIJFngIiWWi9BI9Ccs2vcc?=
 =?us-ascii?Q?HFvCKROqRlyy0BpC34xsXeUzZEo/Znn5OQUwBSoEu3kB0KAmFmsJdfc8j36g?=
 =?us-ascii?Q?3UMQObliKRzh9u7vuUvL0tQtYxuHrTjs6YWD1wwNWYKXKPBoApmNa4haECdC?=
 =?us-ascii?Q?2KTT9AULWdLua1iTWza50Uj17cY2OACqumpKhn+tsc1oevRcrER+/4w7oPWN?=
 =?us-ascii?Q?q02YWKAv8mpqSqBZmsY94RZMBGzuFdsdb3bLHAefI37fpabh1WyrxDUvr4ho?=
 =?us-ascii?Q?XxZuzS9g2IhWpJZFrfudARmDJcSVfTsTNBrpEYiQBbNC3yTNjHqrX/ILNYxC?=
 =?us-ascii?Q?PSLJt3ZLrnthnSQXKZ2XKeACIoYlukvTCEKvVbkl7D8QxBr0coQL8FiGQmAk?=
 =?us-ascii?Q?/0mEk1AU3NRQjz+4653oZ17IlPBHvN40plBFdke4kK8GfRlNTro4Qa+7Bakf?=
 =?us-ascii?Q?NmMnvs9GI/0JvDx9/75sJCXrZIFaWFLVYuIfEx8WN6jZeGpUgIGyjQ9jL/QU?=
 =?us-ascii?Q?FmLe3KnDbybu0bcddx/FFxn22klfoIA5QzH13+dUvmpwmymtEWrxdA4y/cTR?=
 =?us-ascii?Q?6Cjnqp7xCK5YvmmCoWLDTaje84mWJeEk4KIPHgYr/2SraSbEzh4sr9MyAPPk?=
 =?us-ascii?Q?OO4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XKki82NmBcRa+9CHls80VRg+Etro8FoUxrVNTjxp9uf0HUm87QosGY9XsfYZ?=
 =?us-ascii?Q?7OM1HSiIpAdSdTLT86HWY+BKRvCTgz5My53lu3WHNWMNSXRpJxSvR6xljkr8?=
 =?us-ascii?Q?nD2cpwvr668OmSsdeMqIuEsFF5INZOSyX+pD9T6clcFkofaLhoKtwmK+k10q?=
 =?us-ascii?Q?QWz7ME204vCOcQurhEc0Hp2wsFSQTfw9k6Z/EDVh18wcrhh3n6mRm0L2UOIb?=
 =?us-ascii?Q?QzP1pvoSUZNFWJehSzzsA4KDkeUl278pH2pcFLzToBu2MgKTSiSRf67F/teJ?=
 =?us-ascii?Q?LZtMYBfBeTSH000SeyuCdQb2ZouWlgF7kl3tXLoCz82I+RpYoWP1dLF4Lt36?=
 =?us-ascii?Q?8j3Js3BGjxFL8XzQ2cch8YY6S3oevyAxX6KleIV6dkAjqnfQR9ZJx/2I0dgm?=
 =?us-ascii?Q?FgF92d9NuzgfY/9FD3r7NwlYoarR29Rie4xbhFuofzWaVbR6qLebbpP0g8YW?=
 =?us-ascii?Q?OMS2NTVG/6ZUSjHknbe/DhBL8STOqXtPf81WSILNcZ6dImvwgWn064qshRqJ?=
 =?us-ascii?Q?cqcE1r+tvrYmNBmXC9cYELQl+ZYzdolK9ocKc1/64p9z9FrBs6sLAfjR2c+I?=
 =?us-ascii?Q?6geBSI8CqQ9C1hsZ0ZlFFLfKhZdVyD2vJ8HK/1KWA67fVSv+een6fNq71YOq?=
 =?us-ascii?Q?A35FfWQKzFR4qlhrDmpv1oWAuITMm9pxkE0fetHhnYyvkGGMLFlbeBCPmlc0?=
 =?us-ascii?Q?sLwj8VGw3RGCXiDOaUq5jCHEofGu7ZWcdLTWhOH6GKpKGlvK/WuNeP1G8xDr?=
 =?us-ascii?Q?1AT/9PHz9/D/pJh0WExsf5jZPmncvfEli8tvm52v4j9Om70O5g0zgpVoyTuM?=
 =?us-ascii?Q?6ZUeoyvDhQFPJDToLPBERAl5LzrDzComrBmodjVwtYOwxFzzaytjircYz57E?=
 =?us-ascii?Q?/jPQbRqiFNCHp++wdAcpd1uWFw2f2r/9GeBfPW2VIfSaCE7P/62dlrAj5KO7?=
 =?us-ascii?Q?0a5ywKVSnhzalPSNnhuefEwdh4aR3ryRXJHF6XOSK+ruEeP4eylIkUXi3lLc?=
 =?us-ascii?Q?yhtP4lrG9yATYvoHiNcVIXpZy4NsqWUPY/7235SYUW8+GkMX2zSILSWWiNSg?=
 =?us-ascii?Q?q/YjrKTwzi65UaNc0gqFEKMVhsw/t/wnz/zEZVILlliLVYOO5qu2qvTe4vsC?=
 =?us-ascii?Q?y2ebu+b+B/qJZ1HW2lHboQlW0LaGYd+bm5pqthynesTKdvno5PLtw7ivGelO?=
 =?us-ascii?Q?fInHu8viHR7evxuR/FgONPmrsFvqC39Ouai0UVB/sxhrHpOpGkFlpcyM5qKy?=
 =?us-ascii?Q?G46GttP9FVnC0zzFnDm0KjapDDqhooMW8ZJrEk0bsTP/XzWuNh3/3Ewvwg3i?=
 =?us-ascii?Q?nmRljPXAOPJkcu14osIYqV0YdHRfYvfP7KciFDKT2QOBTtP1MtkG+mvrVpTh?=
 =?us-ascii?Q?P+ZmZYdBEQ7L2mgb8A8Ax1XeTB/GSLQKBsQ8gLP5FiLX12Qm8h3mYV/f2ubm?=
 =?us-ascii?Q?MYzEe+awAlsqvocKxInYD27+GkWfkpfGjwmfHrY3MB52SyRNP+SO5dsp8nEd?=
 =?us-ascii?Q?3/3z32P4h/hly96L7p9sSH98xiDwyujumeYiRadxg88vnOzlYdTw/xNIMtMB?=
 =?us-ascii?Q?6UBXEqwDrfBEtC3gzYsxPmnoAlgRQ5ojK8ANP1EIZA/VKMsSt06XrUxrOPzm?=
 =?us-ascii?Q?4g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc92cacd-9ee9-4692-5493-08dcf4da9f9d
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 09:51:39.9373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uSQmBjANJBgfjp6dgKnJ6ir7atWGyaBat2ptgoHAHkvbWztM5AG3/ZeRJuXhsuyoHPDVELskj+6gA87JGzDdMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8034

On Thu, Oct 24, 2024 at 02:53:26PM +0800, Wei Fang wrote:
> From: Clark Wang <xiaoning.wang@nxp.com>
> 
> There is a situation where num_tx_rings cannot be divided by bdr_int_num.
> For example, num_tx_rings is 8 and bdr_int_num is 3. According to the
> previous logic, this results in two tx_bdr corresponding memories not
> being allocated, so when sending packets to tx ring 6 or 7, wild pointers
> will be accessed. Of course, this issue doesn't exist on LS1028A, because
> its num_tx_rings is 8, and bdr_int_num is either 1 or 2. However, there
> is a risk for the upcoming i.MX95. Therefore, it is necessary to ensure
> that each tx_bdr can be allocated to the corresponding memory.
> 
> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
> v5: no changes
> ---
>  drivers/net/ethernet/freescale/enetc/enetc.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index bd725561b8a2..bccbeb1f355c 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -3049,10 +3049,10 @@ static void enetc_int_vector_destroy(struct enetc_ndev_priv *priv, int i)
>  int enetc_alloc_msix(struct enetc_ndev_priv *priv)
>  {
>  	struct pci_dev *pdev = priv->si->pdev;
> +	int v_tx_rings, v_remainder;
>  	int num_stack_tx_queues;
>  	int first_xdp_tx_ring;
>  	int i, n, err, nvec;
> -	int v_tx_rings;
>  
>  	nvec = ENETC_BDR_INT_BASE_IDX + priv->bdr_int_num;
>  	/* allocate MSIX for both messaging and Rx/Tx interrupts */
> @@ -3066,9 +3066,12 @@ int enetc_alloc_msix(struct enetc_ndev_priv *priv)
>  
>  	/* # of tx rings per int vector */
>  	v_tx_rings = priv->num_tx_rings / priv->bdr_int_num;
> +	v_remainder = priv->num_tx_rings % priv->bdr_int_num;
>  
>  	for (i = 0; i < priv->bdr_int_num; i++) {
> -		err = enetc_int_vector_init(priv, i, v_tx_rings);
> +		int num_tx_rings = i < v_remainder ? v_tx_rings + 1 : v_tx_rings;

It took me a moment to understand the mechanism through which this
works, even though I read the intention in the commit message.

Do you think this additional comment would help?

		/* Distribute the remaining TX rings to the first
		 * v_tx_rings interrupt vectors
		 */

> +
> +		err = enetc_int_vector_init(priv, i, num_tx_rings);
>  		if (err)
>  			goto fail;
>  	}
> -- 
> 2.34.1
>

