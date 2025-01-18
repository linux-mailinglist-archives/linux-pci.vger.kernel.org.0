Return-Path: <linux-pci+bounces-20101-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19138A15EF8
	for <lists+linux-pci@lfdr.de>; Sat, 18 Jan 2025 22:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72254188699D
	for <lists+linux-pci@lfdr.de>; Sat, 18 Jan 2025 21:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB80818785D;
	Sat, 18 Jan 2025 21:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SIyoKHNr"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2084.outbound.protection.outlook.com [40.107.104.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858E4170A1B;
	Sat, 18 Jan 2025 21:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737237013; cv=fail; b=FcWhBEV1k3gIYISBvMYOJfG9pHMZtxbiWt/AjRHuO/SqyuSOLDQORrSVdyTRTaHryYrKN8DDBCyejnb0qByHiYpJw9yjpq671ekRRU947S7SU3q8G/XU+27fqvxhSFTZlOATyZeaet8zDl/j0es+Hf38pPBai3cbzu87f7kI3GY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737237013; c=relaxed/simple;
	bh=Z8uUiQyZCxRFcDIUai2Y8yOpLWg/iPtMgTaE38dBlJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nRL5eCFeTFPaBvrrb1lsxSmQDdgD6XzEmLCddwPme0aLyc9iTDQTU3uzezz9pcsaHHII0TSgDEfspaDXJ29ek/aHJO7XWNTf2Y+EnUKqohuSFE9U1aTRgVuKIG02YrP2lpCjGPmpHa1nAYsQK9P1DA0CEk9lhIK7POa8UhyY7RU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SIyoKHNr; arc=fail smtp.client-ip=40.107.104.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fixhR/bRU4FfugQXcbpMUkvFZHHLsQHD3wVyL3JuyUR9pHBw/76hRHtxRJvNUgcq+VOVP3prI47sP+CifyMav3+x3cjnHaR9upGN5/XHsKnOwAJ/UBgc7fJ9mpzxElKxHUT+vMBiL80tK/l0scDPAsMTRQR8ZXexeCjFaCagKzvmf+f9LYUHJAUKfKO1Ovyms3MiK5I17bLr60FizgNYDcWwS56KU6tPv1tIAsjD4VDD1MuS22DykjICDqTEbkY5oPmJ3yoK/zTZ4X/zlgWtG0XEkqFZHBYooTzBo5K0dv81gNRzsDS6+qHOdiWwjJmESDU3+4EWHtdHLfzcLbQPLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pPBz1o3F0DiIHq+9FKk302/iIeeqXqA6NdgSBeMIxVA=;
 b=SwBzbnvN30gDHBSWhIXehse34Q6RHY/R0fDs6PIgAqhX5uDN6O6L+LxMGtvpIIvCoX7Wlv9TUoy9w1VwLNxky0rNMTMr+xwtouvhEGoFrVR+r0TXdYr6oBEeWR4lgphfgQTDP+1TFONBIRBpmdrqDI7I78JAGAxM8ivwPkLMn56gbSr5lL0dEf/S3gjGKkzDhhFYcazCy3oqQgjHDupxBLTzQUu7BbAkrvCkab4bYxrnN83BFWuCSDJaBBvitUwB9+cfQ/N0xGJkY7rdCoBCFnkNlKiQ6eDHGRq5OzSozNYEJHwbg7xIRIY5yLp1yf0TQUzPLD5tJTXe3xC8zoJDtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPBz1o3F0DiIHq+9FKk302/iIeeqXqA6NdgSBeMIxVA=;
 b=SIyoKHNrAOea1C4Ec+xxvUB601/tBuPDp0XfzgpxM0JEkuv2MXOixAxeltSh5i10nRhcUcVk6jumQTv+bM63h1lnVIzC9PbC1QdTzgJPaNFcKzaU037C0QgQhm4913bSSdIb5pIZLdWTv9d3fzbJpRBJzdn+22SjZtXiRPhfCq4oIclkxGGNcAGvyXWCpqCKOxy0Ucv3zWItZ2egn6BJ0IoUfxDjT6vS+/nwKHX5qVZbDpteJxWoANbwUlQ1CDAE2MlplB49x+FNookrtTLRre6x/Ze7i+IBJ5e0KvBvcQlZC8RqU5CBx5MDbW/TvCXy0b7VVfC07C5xCt9vS4IFAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8509.eurprd04.prod.outlook.com (2603:10a6:102:210::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Sat, 18 Jan
 2025 21:50:08 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8356.014; Sat, 18 Jan 2025
 21:50:08 +0000
Date: Sat, 18 Jan 2025 16:50:01 -0500
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: imx6: Clean up comments and whitespace
Message-ID: <Z4wiCSnNdzJS97CV@lizhi-Precision-Tower-5810>
References: <20250118210727.795559-1-helgaas@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250118210727.795559-1-helgaas@kernel.org>
X-ClientProxiedBy: BYAPR07CA0025.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::38) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8509:EE_
X-MS-Office365-Filtering-Correlation-Id: e7d6b5d5-a44f-4f83-3c20-08dd380a13b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YwGwMXdDplAqxk4mUrPhkoTZQrRo7qxEJY6uHl4/QH+Z5FRg+ArloW+Umwor?=
 =?us-ascii?Q?rM+6SBCCgqhZ2/ar4uvD7UZAj0vcy1CvSmKTYx/bq165UEEHv77Yht3y7Ovz?=
 =?us-ascii?Q?XTZ4a8bnd3CwK5lcDTigk8vZ+lL7m/vcrHvOeqsHtZWCaV8dC/NCHq1NFQ4X?=
 =?us-ascii?Q?NSBl86oQ2fTzx2IjUiU/yASIbEpw2mtfmOL6NmbOe7h4HBZFqIUWgqCpmSXs?=
 =?us-ascii?Q?fSDw+1gPQV/FxFB87jS2VrBUD41be0SeYDxf0S1yvITGeiF7OnGRFtChKKWe?=
 =?us-ascii?Q?0lVBztTfiDmIyeSZENFmhCwO7BE3VZoZwmARLnoX9SDjSHhDUYMJFt2LEFVG?=
 =?us-ascii?Q?EU5K/J8f3h6Xv2MCV0zNtYbjCmXorYMa7AQG26z6YZ1uBzZShsoHN2sI8him?=
 =?us-ascii?Q?KgCsgP88MzdnjtIFIGpyXh3Lz/HAeleVBw3Esd1tPGMaGqd1wVFVEumgB424?=
 =?us-ascii?Q?1uNS+Icm+SSubRlUi7QoIcf9s4ls/PVisZIYR1Cp2mVrUCPLHa3AiNrgNqqt?=
 =?us-ascii?Q?fATcjHNRcdruBuBuHt5PrSyHaL98+n/I4TdDi3SsjIfgYvTf03r3K6c4TNyK?=
 =?us-ascii?Q?fSU7tbDsbMhGpEeFGOqkIXscdUW5nvGgj1BDtBD104de49qHrfHdujGzxzC/?=
 =?us-ascii?Q?i9z1hjGe33FPQj1NoT8RCcm8VeDlIYXanGbth14Zx51B3SlnXAq73uqMjOrr?=
 =?us-ascii?Q?rkAvVkHqrhR6pdMsmEU1ljDKUi06QXUVodTOQUIKBEpMrHgHf1/e4QMtuPhb?=
 =?us-ascii?Q?K7QZ5zgwprg+lrvMcVndWFlPgFVnkE+bvcj4bydpiRerhe7ARy3eaF8J53rC?=
 =?us-ascii?Q?pQgLRgMIVaVZMqMA4kjdRudp7/CYvRVDhig/g1kugo4pLFi76pxG3L+sm25A?=
 =?us-ascii?Q?rm2h+lJwW5m1j1xdLxumEPgDAtutZS/5JX1zVzyv2BZ6qHhTLVhNrLp7pjfa?=
 =?us-ascii?Q?A5rWw+AWJFpLkYrm70o8qkaLrYrq/BdUMKErDQcJ3debB5PXfZQ6OoMc0/nt?=
 =?us-ascii?Q?lgFgMqqZNBH9rtiBHK8IB79O7OmLym5mXxLe7J/Qhdmd5iMrBE+TWgMqyr01?=
 =?us-ascii?Q?HZtlsva8T1AJbJ81FmIfTB2NKqtt32qxMXqry369ObH7SpZwFvDb/L76CGF1?=
 =?us-ascii?Q?0RjbiNlLM2lJo4Cb3iYC09H12PFZE6frf7k56tTE/9lUd11Eo+4UBuVKZSIW?=
 =?us-ascii?Q?UNjDFVTtvS6Uyf9o0BD3UgJJfo+YDEZqBz0WkT1CyebT283OBXF9Gy5UkMhl?=
 =?us-ascii?Q?l83EbYzIY/MkCzL+aoj791w8hP9L8pFWJcBQ/EQIR7lPjK7VzOsYrWiTT1Wk?=
 =?us-ascii?Q?RjsAhrvOXHFwph6X7PU9uMEOeZw7jt/rPHQQZua3HJH+ev3XCTdZoRfit81m?=
 =?us-ascii?Q?Ql+84S5pVeAar2nsWHf8bTUuGf4O3tivC8yhwLQ5vdjNWBVy+x5/1we6LVXU?=
 =?us-ascii?Q?HZsqlRf0c0VpdF+nRFN8+EF8sbw1szim?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J0aYd8TIKAI3VL9miyOxJFii5/wFdo7kv0/77NScezhdoK6QNBoqrNXNSMI0?=
 =?us-ascii?Q?Z9k/iuEMapHr4UHtR/mhB4Sx5xeF6upQqDDPWGdicZqZ/btAgursHyZCJV9f?=
 =?us-ascii?Q?vbj5TmnTon89NgshkAG6dHSmLLkdVgckV7z+11JrS71cx+UZoWSgowbetwMx?=
 =?us-ascii?Q?bbLS5I+iRXH6Gs0RobIFUL1LWRoxmXxBM/0qYZFatHrXIyUNOsctG5jGzfhp?=
 =?us-ascii?Q?ScaLe/klDfYIafJnLkcXsvrSv4/VL9velJNDMCtbAaEizB/5iDZbxdddoLst?=
 =?us-ascii?Q?gh/MsPcJJm2VezncivRrz07omzQVXi3mfggIP/KQQ0Dwci2qCI2hEaL9F0Uu?=
 =?us-ascii?Q?3ZKFCDU1iuHCFr2tqRLDzBiU1vngG+QYNF61PrgH0gf3PckAxbJbDxHnaua1?=
 =?us-ascii?Q?/uyPAdEEWUBHVsUDknDAOS//MWPW1Xc94ViTXAYPdhfQFFc3EhdSGRFQJ0Kp?=
 =?us-ascii?Q?FzXGuzikLYQvNvE+gQ2m+pjXCg8nXi8esV7vKa+WWx4oc/dfSxSSjAOQjifB?=
 =?us-ascii?Q?+P9c39IBxeISixRLDReg0QgTwwIOyTbjLuoBkhJ0hdHkYXeMFzBsDSgnBlr0?=
 =?us-ascii?Q?ywDc6Lxa7lEExaaoJ5VvSMhnrynshAYmxXwKJnv2/tlgII7XxIZjvJkXPJwp?=
 =?us-ascii?Q?X1IyPx8utwo+USYS3k3dE6wkwV2eC9m15ClTESy2FX8kzy9ikoMBnvtBLtRL?=
 =?us-ascii?Q?twhtnOWFQzTGI0mZSH8B0VgbRt7MW3g0sg0vXI+UPalboYAC0RhXTvToPBut?=
 =?us-ascii?Q?7Mxb77Lo2cbwcOtQaUBZhjoYKzM6hYv4heAj6iH5eyJPyVbetIqHO44ZMCtF?=
 =?us-ascii?Q?6iSSj9qJGP6aly7sek/11Bzl1QgsD4byWoDnU0YjeBhManEPa9bBefuHqlUV?=
 =?us-ascii?Q?HTmjZqjcft28DnQrwA+WtvS5/Rq66FWn9iW5cWb2JW+ZvmDmNx1NoKTK/MuR?=
 =?us-ascii?Q?T8ZEs5HnSfEUUBwiVcYFTIIU/58rCB1BaAN4a7aaN9LeUQCNk1FSGFXv5kDP?=
 =?us-ascii?Q?jX2Fowj6THoc1fsljPlOZqlgm1Yfu8NC7PLOXNCdEbQ5WyTVy46ae0DW0Phn?=
 =?us-ascii?Q?tHLTAZ7GbVKanQwR+4W0effFRATTrsMbx+4fmuKc4NykgSKT2rPHamRQmYrJ?=
 =?us-ascii?Q?9rOL4LTfDNDdJwcwVy/Y759wbJtqMz5oaEfkGO3Uaq91LwsH/AZQ2KuXuCuR?=
 =?us-ascii?Q?Kg+Fgopu4lMzSFs4WfnOto9N90xtNnZdm+/3kY69csdEFAlCOwCztplrtdgK?=
 =?us-ascii?Q?3VO+OV+pdDVR42AepMOx4F1iop6LFESMAoL/JzliqoSONMyXBNV5yOX+8eyW?=
 =?us-ascii?Q?AnNguXYEfabZi+48Z8HTLJBrXK3jh84OIOFW4CbBz2pTH0SD9PSYyF33eQiN?=
 =?us-ascii?Q?7iel/FvIP9AmOieBXw1kLZmC3euVWZCAhVu6r8kJIcxuNorUSk+3l7Pppe8B?=
 =?us-ascii?Q?UJiTIsn+LI5d6x4OYb03zw+FEw6xPeYDqrL+6QtSOvJPu8MqhaciGsTBeyCR?=
 =?us-ascii?Q?m3o2NeFVSyp/TfhcirMGIgsSiEak+qSQ0giOcgRw6CliFMceyXXfDdDOKkFl?=
 =?us-ascii?Q?hIyyUNyFDgEoqDRjJ60MlztbrxwpzfXVaxenS0P4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d6b5d5-a44f-4f83-3c20-08dd380a13b6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2025 21:50:08.8772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BMqNMO9q4ri+p0vwE9jfVrMVgDNmhleeTmDNj+gf7qPYADGmmK13TmoYXPK2Gif3b6nrqYXv3pLSNtXpBehGXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8509

On Sat, Jan 18, 2025 at 03:07:27PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> For readability, fix typos and comments that needlessly exceed 80 columns.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 41 ++++++++++++++-------------
>  1 file changed, 22 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 06d22f23c6b3..d70e6c427976 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -236,11 +236,11 @@ static void imx_pcie_configure_type(struct imx_pcie *imx_pcie)
>
>  	id = imx_pcie->controller_id;
>
> -	/* If mode_mask is 0, then generic PHY driver is used to set the mode */
> +	/* If mode_mask is 0, generic PHY driver is used to set the mode */
>  	if (!drvdata->mode_mask[0])
>  		return;
>
> -	/* If mode_mask[id] is zero, means each controller have its individual gpr */
> +	/* If mode_mask[id] is 0, each controller has its individual GPR */
>  	if (!drvdata->mode_mask[id])
>  		id = 0;
>
> @@ -377,14 +377,15 @@ static int pcie_phy_write(struct imx_pcie *imx_pcie, int addr, u16 data)
>
>  static int imx8mq_pcie_init_phy(struct imx_pcie *imx_pcie)
>  {
> -	/* TODO: Currently this code assumes external oscillator is being used */
> +	/* TODO: This code assumes external oscillator is being used */
>  	regmap_update_bits(imx_pcie->iomuxc_gpr,
>  			   imx_pcie_grp_offset(imx_pcie),
>  			   IMX8MQ_GPR_PCIE_REF_USE_PAD,
>  			   IMX8MQ_GPR_PCIE_REF_USE_PAD);
>  	/*
> -	 * Regarding the datasheet, the PCIE_VPH is suggested to be 1.8V. If the PCIE_VPH is
> -	 * supplied by 3.3V, the VREG_BYPASS should be cleared to zero.
> +	 * Per the datasheet, the PCIE_VPH is suggested to be 1.8V.  If the
> +	 * PCIE_VPH is supplied by 3.3V, the VREG_BYPASS should be cleared
> +	 * to zero.
>  	 */
>  	if (imx_pcie->vph && regulator_get_voltage(imx_pcie->vph) > 3000000)
>  		regmap_update_bits(imx_pcie->iomuxc_gpr,
> @@ -571,7 +572,7 @@ static int imx_pcie_attach_pd(struct device *dev)
>  			DL_FLAG_PM_RUNTIME |
>  			DL_FLAG_RPM_ACTIVE);
>  	if (!link) {
> -		dev_err(dev, "Failed to add device_link to pcie pd.\n");
> +		dev_err(dev, "Failed to add device_link to pcie pd\n");
>  		return -EINVAL;
>  	}
>
> @@ -584,7 +585,7 @@ static int imx_pcie_attach_pd(struct device *dev)
>  			DL_FLAG_PM_RUNTIME |
>  			DL_FLAG_RPM_ACTIVE);
>  	if (!link) {
> -		dev_err(dev, "Failed to add device_link to pcie_phy pd.\n");
> +		dev_err(dev, "Failed to add device_link to pcie_phy pd\n");
>  		return -EINVAL;
>  	}
>
> @@ -605,10 +606,10 @@ static int imx6q_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
>  		/* power up core phy and enable ref clock */
>  		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_TEST_PD);
>  		/*
> -		 * the async reset input need ref clock to sync internally,
> +		 * The async reset input need ref clock to sync internally,
>  		 * when the ref clock comes after reset, internal synced
>  		 * reset time is too short, cannot meet the requirement.
> -		 * add one ~10us delay here.
> +		 * Add a ~10us delay here.
>  		 */
>  		usleep_range(10, 100);
>  		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_REF_CLK_EN);
> @@ -880,6 +881,7 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
>
>  		if (imx_pcie->drvdata->flags &
>  		    IMX_PCIE_FLAG_IMX_SPEED_CHANGE) {
> +
>  			/*
>  			 * On i.MX7, DIRECT_SPEED_CHANGE behaves differently
>  			 * from i.MX6 family when no link speed transition
> @@ -888,7 +890,6 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
>  			 * which will cause the following code to report false
>  			 * failure.
>  			 */
> -
>  			ret = imx_pcie_wait_for_speed_change(imx_pcie);
>  			if (ret) {
>  				dev_err(dev, "Failed to bring link up!\n");
> @@ -1091,15 +1092,16 @@ static const struct pci_epc_features imx8q_pcie_epc_features = {
>  };
>
>  /*
> - * BAR#	| Default BAR enable	| Default BAR Type	| Default BAR Size	| BAR Sizing Scheme
> - * ================================================================================================
> - * BAR0	| Enable		| 64-bit		| 1 MB			| Programmable Size
> - * BAR1	| Disable		| 32-bit		| 64 KB			| Fixed Size
> - *        BAR1 should be disabled if BAR0 is 64bit.
> - * BAR2	| Enable		| 32-bit		| 1 MB			| Programmable Size
> - * BAR3	| Enable		| 32-bit		| 64 KB			| Programmable Size
> - * BAR4	| Enable		| 32-bit		| 1M			| Programmable Size
> - * BAR5	| Enable		| 32-bit		| 64 KB			| Programmable Size
> + *     	| Default  | Default | Default | BAR Sizing
> + * BAR#	| Enable?  | Type    | Size    | Scheme
> + * =======================================================
> + * BAR0	| Enable   | 64-bit  |  1 MB   | Programmable Size
> + * BAR1	| Disable  | 32-bit  | 64 KB   | Fixed Size
> + *       (BAR1 should be disabled if BAR0 is 64-bit)
> + * BAR2	| Enable   | 32-bit  |  1 MB   | Programmable Size
> + * BAR3	| Enable   | 32-bit  | 64 KB   | Programmable Size
> + * BAR4	| Enable   | 32-bit  |  1 MB   | Programmable Size
> + * BAR5	| Enable   | 32-bit  | 64 KB   | Programmable Size
>   */
>  static const struct pci_epc_features imx95_pcie_epc_features = {
>  	.msi_capable = true,
> @@ -1260,6 +1262,7 @@ static int imx_pcie_resume_noirq(struct device *dev)
>  		ret = imx_pcie_deassert_core_reset(imx_pcie);
>  		if (ret)
>  			return ret;
> +
>  		/*
>  		 * Using PCIE_TEST_PD seems to disable MSI and powers down the
>  		 * root complex. This is why we have to setup the rc again and
> --
> 2.34.1
>

