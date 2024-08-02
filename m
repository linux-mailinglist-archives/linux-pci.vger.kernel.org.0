Return-Path: <linux-pci+bounces-11210-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3C8946494
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 22:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F4A7282D2E
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 20:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B163EA98;
	Fri,  2 Aug 2024 20:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="L1FwTteV"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011044.outbound.protection.outlook.com [52.101.70.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF481ABEBA;
	Fri,  2 Aug 2024 20:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722631598; cv=fail; b=L19bAShQS6viImNgzqEhrJVH20JScXsOxi5gHs2ewQk0UVfUvUrpySE6sTksiNfIGCqaE73nzaMM6+Q/fX/rVFTmHGQEJhKLmhQhRtr7U95+oAA4ASe0MsFWSKlP5AGfXjW6MiyLuXdgTfxxhTS8Ss95i0ffTvGo+aJ3PKcjNww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722631598; c=relaxed/simple;
	bh=KC+Dh04eKfBjITEB2oo+gBYKTB37keHFMHHo2sArDyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EWLWAHeswNq0MLTH2VfEm06DnmJkCpWXV3LnESqNqTqEg10+RwdA8Tz06eTjdcOBnHQsMjwj5JZJUpnHkWGY2YfpaYNphIifZO65VBqNJjE7A7Oo8pFDuRFxrUk9z3d5pnsbvNPW482hRBf67esCl3eM7h1IAOy5F1bXVP941kU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=L1FwTteV; arc=fail smtp.client-ip=52.101.70.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m0lm0RwRYLpvojBI/c4PqGdiJXNk2y3MGd8BuXMgPzjrgbAXQXFSzBl/SGlJFgO2x4nQSyIEbv1cEIMTrX7PQRePdfYRSkYG8/WFgELIoSk4lWDbgwyeByRXfFY2ybiEJtkuWv9ghlGUK6SgTQb6Jj6reolOInpJTCUEqGAYvaSBfsTjcI5e+9ZBJLAt7geTuueYs6Mjdq9XD0923G3+zPRtS5rECs0+Z81XK/0Xv6TQ6sEfqDFUuu9bP6U8IdztaBlfo5Y3Z+dm7G+4eN4tMt8gJGCPsrv3VC2azy3/xHR9szMl/UOksMKaRpSqYY9Qqh9N+czbmRF3+pUPB7L7fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bufvuCeE/itei7P5h4H4RihKCuzWfYv9btLVt1XZTyo=;
 b=tvAVnWh3S7qcgvojakpjhR1f8CbwcfKAYMeWXK95KMROPbFJXk0hnD1PpWuYP+a8TviFdUJCjHn1DP742/ijcXdxIez04SWO1J7Iv17nw8ar3KMYVrOHTtSiorK2Lbcoz+gVKyeDHmPsW8RtMotyLLhS60o6ZP9dpiMp4KyifysmLqwX1a3LO58JkmJE6eBdwlmfoOXJAmNhKOdNvvaI7FAwj1LYvkoce7t244V2QhaB80ohqTT1+qO9cpmazvkpoy0j9l6EQcmUM4G1y0nzOV+HFvxTAB0yH3yoT63ifAfU78Bq7w3QnD4ppFnlVHC69L5FgqvnvJmAqQGEXgVceg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bufvuCeE/itei7P5h4H4RihKCuzWfYv9btLVt1XZTyo=;
 b=L1FwTteVg4nmzCETB4erWt1lktplwbfrwHhJL7tYaHV9g9vbnj+RmNIGQTMT0RhZVTUY5Zxf7L8oweSw48Jmyo8hUxbYwWBTlkq8omRDOmDVQsxWonB+ZnPHNFW7JOQdVPJcE2RDEvyxUhrZGJwH5bEvZYKFN/fHJFXLxOhP9BDtugMlxZajQgqaRU/vgdUw8cN94SKsFuP2ev0an8BIlHKi4g+itlWDdBhbXOAi2YZDjNSaqpzCIXmZ68xqRoc+xpx0Ms63uNn3+ThwrD7xA8SJ3vpjeqyi3E5kUSi0FihvcOYmkvBtE4tZBH4NRkBSvzoF5mSEDzfssEvzCJGYZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8425.eurprd04.prod.outlook.com (2603:10a6:102:1c7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Fri, 2 Aug
 2024 20:46:32 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7828.021; Fri, 2 Aug 2024
 20:46:32 +0000
Date: Fri, 2 Aug 2024 16:46:24 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, l.stach@pengutronix.de,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, imx@lists.linux.dev
Subject: Re: [PATCH v5 4/5] ata: ahci_imx: Enlarge RX water mark for i.MX8QM
 SATA
Message-ID: <Zq1FoNiGA0x/GlhI@lizhi-Precision-Tower-5810>
References: <1722581213-15221-1-git-send-email-hongxing.zhu@nxp.com>
 <1722581213-15221-5-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1722581213-15221-5-git-send-email-hongxing.zhu@nxp.com>
X-ClientProxiedBy: SJ0PR05CA0163.namprd05.prod.outlook.com
 (2603:10b6:a03:339::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8425:EE_
X-MS-Office365-Filtering-Correlation-Id: a202198e-ef02-4942-81e8-08dcb3343139
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J1PEt/Qln498YkKt2YFRGbb9Q+DucYEXRoMLK1SNmuvTHTZfWDVY36LIqsk3?=
 =?us-ascii?Q?Pj9a85QuN+q9gTDaxJR0F+C7R6ollnMiIwdloRM0cuUYHHvZmwdilkrhdJOw?=
 =?us-ascii?Q?6+iw7rcfi1faUIEG/geLVvJNdTXikmSk4xvvW/wUmlTARAq5GovS8kAVFfoz?=
 =?us-ascii?Q?lgxatYD0Kb8NUatWnrSkAPrSO6QMPvXWpn95WvBcY8Hbn2ZB720Wmil5Toi5?=
 =?us-ascii?Q?VLiowkkMJ1G8XOEvVE3do1c/1i0iqvLXmynD72YFsYzJSmUwxp97prpLwLS9?=
 =?us-ascii?Q?lQh7wjHgKKmeW4ocfGGNwhEKK1CmgND+Prr9M27+4xz/JaHBSjNA0yOzRKJ3?=
 =?us-ascii?Q?jTSXkJwxqC3ZLQ/ZtbTf9a3c/oYu69ajrVy2QIUy8TD9mMNbO/TMZVCEXLf2?=
 =?us-ascii?Q?YqYb66iuQNQuWALJdLO2CEyDYHlVfs3nUFZbUeAgypoYOXb+YHpcv0ylrJck?=
 =?us-ascii?Q?zT8WNN4TyVxiq8V1oWWmSl5lC3R6kVnWaiOeqquQGmGeeqWCoIjF3b7AyjEj?=
 =?us-ascii?Q?mBq29guxXHmL7f1pOkkF5wE4LI+gcFpZXCatUtPp18vYrZTq/h4Xsp9zGBVf?=
 =?us-ascii?Q?8qyImb2PAIrcrx4O2OtC+V+CMg1aRVqNn06mWVyz6l0ehGwHeIgBGcg3JcLE?=
 =?us-ascii?Q?/eKiJn2161qLYkWJbxNRR4syXDC4WKSnEwky2kchoOERZbmSpMST7zTDsMQj?=
 =?us-ascii?Q?FxP5lPaj6X69XEVgpu/6C9Uz7DYlEBF1p/rZDRznysNvsxT114FgZ6iWBaqh?=
 =?us-ascii?Q?AHhYn5Cm1zstCE0zIoyPz6ahRRAPrTLJwVK76KnR7xxGJMHa6u/mk4W9QfBx?=
 =?us-ascii?Q?wtxHXGxkiFfUB9OO8RNdT1xAcT/20wV6LikTWAkBaRbfOfvL/vdB/Pj94v2Q?=
 =?us-ascii?Q?90uoc7LzRPWiVnE0B7Fcs6bleWYToLuYOGniRlhki80aR4viWplTif1QVDU+?=
 =?us-ascii?Q?PXZjYjciGZU2q5dsDwaxbMmmcKxGHs6Ki6aXBdjRMx1nts2heRDrSlwBa6on?=
 =?us-ascii?Q?cUmfTjdakpzaiJLmpjV4fREgb3ZeCqH9Whot0lCzKf2A7CRYaHIgWBkB2sYG?=
 =?us-ascii?Q?sHuzI0EPcHIVKZfzuCY1uC9L7BMUpX0StEwtn8Na9nkVQMS9rN90fc4B+Doa?=
 =?us-ascii?Q?IXjzG7524+856Tp/FaU8MCV0ORVYfft43JuyYmIf2f8pMjyfmrp8YT/7W3yD?=
 =?us-ascii?Q?jeL8aP6EiFg2b9r+NXoKxUlGjuIELV/vZe7+aXQh0DwOacCsp4PmMmOCd+vr?=
 =?us-ascii?Q?1fIAOYWJI8tyadMdyVGp0/+nRwUgXLjDBitOKZkoElTYaeZa9iyjrrvjZPhy?=
 =?us-ascii?Q?uzC8v5QrYndbGd+O/OitD3/BhXmxeztipcuxfS4zaUtEQRwoTWumWR9WomHS?=
 =?us-ascii?Q?xgeWVLO1xDK6gXdGgo/dXtnmX8qaDPHfHfZvyFcBopk2fK0zDQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lLyRKSlPrcR9yzqgoZTnrh21mChvibwKAG9Xgrnzz6iNClrjncFwdgdffUJN?=
 =?us-ascii?Q?cVR0wYv1BadDLkruJtLLl4Q9cCC6RWDTJW3P83+GT6YbODXbzuFLvGiqpOXK?=
 =?us-ascii?Q?PWaNkA1w8Y5OrllbFooTiyrxDdXWlUp7QXL6SvmIEIYluuBHU1MWdTsd/E+2?=
 =?us-ascii?Q?e7HWev38EtwWtkg5NBwsRtG6yXhS3GaunUPMCR/m21tX/uve/0o9LF5KboaT?=
 =?us-ascii?Q?PVbKwByTAn5DUchQOFy2qo5OGfNOkXW0KmioU8tqrXFCCcqNaGVwaQjtf5ym?=
 =?us-ascii?Q?Q28j5f/R4wo26yzVDImH+9DVPsZB+ZBxqHgNk5HYKzgmFh1lSST9Vtri+YjB?=
 =?us-ascii?Q?SSs4SjH1ZHwbOQaDtQYn65axZ814zLP6YzNeRGWusdEUD8cILFXkkPp/27br?=
 =?us-ascii?Q?hDtPCWGWp7IjmhsgyJ+hAYMpQs6vtkje3HtNmyiCg4krKCddhnEP/aS+okcj?=
 =?us-ascii?Q?MN8odtL5BoYU4r4X7njeW+PMZb2EziNWP0bayOoMew3+8Tv6oq7yLKWBUJhf?=
 =?us-ascii?Q?iFchXvx8JFQ5Olk5Pc9hkpftn3H6Ubq+MJaeW+2i217qrbWi46QiM5xnOz45?=
 =?us-ascii?Q?JsTjiqIqE6qXbMrDJFS9kep4VO+IgRkA07Ba8HiJkQQZtsYvQSQd5z1GGQ3i?=
 =?us-ascii?Q?yPDthAUbiY8gE6MVmLHliLn7+O/vgXsmYVuuaIU8wgwBfkC3SRmEDiun9yLZ?=
 =?us-ascii?Q?1m5jj603S6J5wsdlmHMi5VCgXVSzSYCTpYvWESGCqpNVjLrsQF9sWHvj/h4w?=
 =?us-ascii?Q?Ln4umq+M8wQPUaeImEPieLzaI1aTakHcV1ju97f1fzAfX+ZSmxXn0XWwc1Xd?=
 =?us-ascii?Q?4b0I18BJuV7YhzoWahiyviikqRVPti+hrG5ww7TrwS0seWnxTvLrgjHwmYbE?=
 =?us-ascii?Q?ZA7lhihPYV6/n6El9x/a+qa9/2u1sEWvmH294mbGhI86FND7v7tZ0t30MQFS?=
 =?us-ascii?Q?ciguwm016oVoYNJ6JyU9qna+nqr2ugHo9pR76DYHN9sDAl9NvlPNNT8tu722?=
 =?us-ascii?Q?9Tuj7uHIv/Z9RhdIgZ8UOV+xcQqlUSOiyhYGzYzt2fm4y4jtu5TDatR+NX85?=
 =?us-ascii?Q?F3vDxs5Z/whJrg3jtqppe+NK+NKLOQurJ9uhkxzcTKsIdysVdJ9GWkI22HYu?=
 =?us-ascii?Q?U8SNY2CBrwpBwTWQwH+TkALajndAT+xzbB6UDDPC+7rn+kaMBPmPWKWlsk0z?=
 =?us-ascii?Q?ZRpPbtUCZTRRAKsCDqJMFtvLAB5kulrFwjn0fNxsUCC3luD00cgFDCmBVCs0?=
 =?us-ascii?Q?gAfQ5M5DkcQ2RCXAWHvZYPxT7w+gyeXz6MHCsHPuew2CkOxZOrLCGulFYOri?=
 =?us-ascii?Q?eHIjfmLAeYi6ZarE8uqS+AZxveOZ84Syuq4NWIFbVYFF9Cuj9STzzC+FTf1h?=
 =?us-ascii?Q?xfVSNNIaYwA8Itx7+YYYQkyQDxtkypkNecT6o7kkaIe4af0IpZaCZxUkYdXN?=
 =?us-ascii?Q?vqLA9RJJm3xrqs4qvTSuQI4ZKt64rtZ166tFOT0seJJiOqoyORKGdwfk2qqv?=
 =?us-ascii?Q?pbY7V+uHfE+6+7B5wxzko00L68FO4ADDwFQRBBOvzEt8jFZlKev0KshoKwVS?=
 =?us-ascii?Q?ndSP5GOJcgCimNwee6MrCeAoNAUEjwLYNI6bAtQL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a202198e-ef02-4942-81e8-08dcb3343139
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 20:46:32.6307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wnAhbevllfuUPIYp8nlOX29rpBCIYpFMivxfX5BlAz2ntx2S6ZR4l25AVTQa/MJDUSyKXcv+lqV9lI2GaYMWzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8425

On Fri, Aug 02, 2024 at 02:46:52PM +0800, Richard Zhu wrote:
> The RXWM(RxWaterMark) sets the minimum number of free location within
> the RX FIFO before the watermark is exceeded which in turn will cause
> the Transport Layer to instruct the Link Layer to transmit HOLDS to
> the transmitting end.
>
> Based on the default RXWM value 0x20, RX FIFO overflow might be
> observed on i.MX8QM MEK board, when some Gen3 SATA disks are used.
>
> The FIFO overflow will result in CRC error, internal error and protocol
> error, then the SATA link is not stable anymore.
>
> To fix this issue, enlarge RX water mark setting from 0x20 to 0x29.
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

This is bug fix. need fix tag and cc stable

Frank
> ---
>  drivers/ata/ahci_imx.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
> index 4dd98368f8562..627b36cc4b5c1 100644
> --- a/drivers/ata/ahci_imx.c
> +++ b/drivers/ata/ahci_imx.c
> @@ -45,6 +45,10 @@ enum {
>  	/* Clock Reset Register */
>  	IMX_CLOCK_RESET				= 0x7f3f,
>  	IMX_CLOCK_RESET_RESET			= 1 << 0,
> +	/* IMX8QM SATA specific control registers */
> +	IMX8QM_SATA_AHCI_PTC			= 0xc8,
> +	IMX8QM_SATA_AHCI_PTC_RXWM_MASK		= GENMASK(6, 0),
> +	IMX8QM_SATA_AHCI_PTC_RXWM		= 0x29,
>  };
>
>  enum ahci_imx_type {
> @@ -466,6 +470,12 @@ static int imx8_sata_enable(struct ahci_host_priv *hpriv)
>  	phy_power_off(imxpriv->cali_phy0);
>  	phy_exit(imxpriv->cali_phy0);
>
> +	/* RxWaterMark setting */
> +	val = readl(hpriv->mmio + IMX8QM_SATA_AHCI_PTC);
> +	val &= ~IMX8QM_SATA_AHCI_PTC_RXWM_MASK;
> +	val |= IMX8QM_SATA_AHCI_PTC_RXWM;
> +	writel(val, hpriv->mmio + IMX8QM_SATA_AHCI_PTC);
> +
>  	return 0;
>
>  err_sata_phy_exit:
> --
> 2.37.1
>

