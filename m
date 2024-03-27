Return-Path: <linux-pci+bounces-5286-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7790288EEBB
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 19:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E46741F26A68
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 18:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA7F14E2FB;
	Wed, 27 Mar 2024 18:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IylMLnWg"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2087.outbound.protection.outlook.com [40.107.14.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8244814E2CB
	for <linux-pci@vger.kernel.org>; Wed, 27 Mar 2024 18:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711565861; cv=fail; b=oazWKjW/WGXqI0PmOcx6aPwgVycQYRGqpKx9IyQ/YGIPSID0IJ2iN2OSjpv8hJ+B1uX1XEgZ4jyBW/KRoi10zbT17IGtjZfyICoAGXXmbi8ZFyPJ8k+QS5Qq13tyIsFpQEYQaKsROkaZ7a7f+jK6+b3EqnfW5dXKsJNmUXrI9YY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711565861; c=relaxed/simple;
	bh=r7WocrnVxJ24+TMrPw/XaL68pZYY9bWoJ7ojSDDtzzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VOWr/I8kfvrAwAUGeaAZoZ2pouT5mpNzufjabXb3IuNbIsNHObRVU6BknbMfF6Zl52bRhkQXClFEDz89hat1k8knBBsoH4mS3nZk5ySIppyznyw1ze39HjzuvxVNRvJlEx/9M62CQNYCPcR/41c/cRxBqiBZW7LBxqYk/KFABCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=IylMLnWg; arc=fail smtp.client-ip=40.107.14.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QIoL8UZNM98mNZUeBOPrjcMiePbAkF8MCCjk+LuvbA8VS8jbWfJ+sUYks3EdS+p0/04ezrRIQDgiyQcMwBK3qW6xMCYb5CQ2uwEL0iEOB0co29igm2ynhp0SmEmVoGRHIYvD8DM8OMdm3ETLCo+FMJ6LXRgqLIp5ByA8xqRIwxQK2+hPuOx0LvgRU/L6inO323+UWxBfp5pnyJfa+Vcz8KvsK0IKqmKPnuxCE9n/k+dNkRVd9Htf9R19JIwoKN2YAXnwFrc7CB3P6lDHvGf8rM9E2DGf5yDKAPSRxPQNHzD81rEXGPk2zxunHnIVytP4/EaT6hicbfKPkKxU/Swv5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7jL5wPnwHF4e9FPsYteY5iEs7BC5D8KWoGugn8BlXIo=;
 b=mjw5IPXZwRJT5xJTYKTaS6yoDvM4HLEWKZTB+egGcoremq2Ern5xU2ORLeHaxRhk3tUFBEGNwX2jMQOT4K3ZGotYpUjOnpCCnnpBp8ktwNN1JvADaZXaxuqoW2mIYN7JLiAAcwqpWMzh7rTp3eXfVau9V3JH473I3LXrMR3jc0YRiX/z5IOUtQ/makGHQO4HDP7EYCb3pU1iQrNHRG7WOpp4W1qnJG5Iz7Ij4NLCp0hZawVqGUfmkTo3lx07aWq7BYqlUJILeRJOKkjPqX44mrAMKK1Lu68o/AXRFI+G0n9dVuOHShFLLUQYIAeEJRx042SouOeEK3UTnfKWgUExIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7jL5wPnwHF4e9FPsYteY5iEs7BC5D8KWoGugn8BlXIo=;
 b=IylMLnWgC9bh3s8RfBcskt3895Fr9ODt0oEJkOQexLHPuAhGzyymnJwNZm+k+iRSEYcL+cfWfxYODXbVQiG1A8OsXZoutaiAYe8cH0JmdgSHUEx1QKTxEnjz8C8LiSsISaaCxNustAKeJLPgNFAXsiWTOICMcI8oTkpcZSBaBUs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB9002.eurprd04.prod.outlook.com (2603:10a6:20b:409::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 18:57:36 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.028; Wed, 27 Mar 2024
 18:57:36 +0000
Date: Wed, 27 Mar 2024 14:57:28 -0400
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] misc: pci_endpoint_test: Remove superfluous code
Message-ID: <ZgRsGGJCYyXjBXF2@lizhi-Precision-Tower-5810>
References: <20240325142356.731039-1-cassel@kernel.org>
 <ZgMaQcRsdHvSEGUD@lizhi-Precision-Tower-5810>
 <ZgRE-B2RnABfZkjU@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgRE-B2RnABfZkjU@ryzen>
X-ClientProxiedBy: SJ0PR05CA0162.namprd05.prod.outlook.com
 (2603:10b6:a03:339::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB9002:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d78982f-b2bc-4572-382c-08dc4e8fc49c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rwpDCf8ok5VR52G1rjt9QBXHtxUrLNjbyAkdQtJSB5YSN0sQDBmq4lODb8LSXmGIY2/cbGON4WKM7geqw6GQuElGTVrMMHh9gMIABtLNf0EQeIAz2ERRMlUGhnxBmCYyQ9B9F5gHEfejVX3lJdbrP7JOEGL6ReMvh11a51i29/BRyPVe3UdQnbdF78HmFMUV6bdGFPr1mMD0Sz0hOXrdLTwx3H6BiOGisnUkM+e9Ia7xuhGvbjWiCrWHiksAUjxVP3DzfBkCRQsZG3Bos2PpHh11PRKPyckCxVgwCJh6MiWnSsHf4p1LItiTJ32rEvA4JaPHQKm3qjbH3AJkQy7CzaKrxCR1QhqruUCdIt0d98C0ugyqGGrNgZf/mWsiownha01/4fYOjEFTvsHehKi0CtQasxKJxX25HQ30/lEv1uGpIntrDVlvAMNuSeg3ZWZBkMQgyI5vpA7YJWKPAYj1SG3kp0QOKx0F5OCz110wBJbH33ibBmz6tCfEuSKp+xueIHEmMcxG2qqrjU+jJDsGUEDcdIdzdPp/Gban9R0oCI0hCe+gY2RQzegkQ9mPF2c7ZGQr1YMcAIwFFliGHMYbWwhuFJ/1MkGH2JiftiuhD6fyK7QiGx3J0S+EanEGTP6dPFwAhWDelxcMefVpJM10m4jqj1DO4y88lAtM8CDo2vE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gUKU3xYzW8ZBT1Du3+h/n8/g2Rv6+E9eh5jaHar9tMccM+dp6p8djUvnOst1?=
 =?us-ascii?Q?j+R0Vs2aj6l1HVejhffqEjjYVhQ0zMO6bxzbMEatlW02KeZgNuMCb+cL1+Wb?=
 =?us-ascii?Q?mk2+xVn2GJ1/llLrft9QSAgkR8qNMR8MZfBgaJxhJkE2a7nkVlQJ70E52Psz?=
 =?us-ascii?Q?SFBRPRl6fQOyQ17mZTSWdt/80GU/MjFVjGDczMHJ5BY2U/+4J1paX1eUi/2C?=
 =?us-ascii?Q?RgHErWt7DQzm8Y49CrmWwNzaQPjDbjU2gdbunl5Rpk1QBVG9jmgJyzbtSq9H?=
 =?us-ascii?Q?2AB0JmiURyQaKmVCepeYgwSlSBpKCm0kAf23rHgj1jEy6H1m4/zqw8jBDqkk?=
 =?us-ascii?Q?SVyDgW0HDiX+9vTS1hJN+0iQwNOe0SSABDTRhA/7vDcf3t1MYgk2/nI6Wbzk?=
 =?us-ascii?Q?cwJxBK/f/a+E9PIWnYQGqv4+676W32uexv4YehSHxZyaaC9evZu5o1rKUUmz?=
 =?us-ascii?Q?4b7QzomW8ELkuqXn6RYjnf4JjiTK8vYgMSyy1DPIzfEMNSLjLV/Qw4Y8itFh?=
 =?us-ascii?Q?ZiJbOKMZ7ivMvOI3p4ZjhFgRCHcyXircsqHkTRjaKqJkc0K7R8jpWRoSntrl?=
 =?us-ascii?Q?/jNADSBqbJz+in2MziPY+cTSNB930EZwRVQwHKoJqXeq8QtRErsqf6PrH3l+?=
 =?us-ascii?Q?r8R/Krn8irM8DHGEJJnQ56tvtfkumwYi6Uh193xLl6HswIMy1TjPI/b6ASey?=
 =?us-ascii?Q?eR7xRRWXMXVUBTVWDy4RaL1QmjQMGsLMPoTMNxwYcubxWYz70UuxYOLO8q+d?=
 =?us-ascii?Q?RvNf+Vfh/bDwSBH3/joLF06QkFkZxGAr4zodVaym/zfNoH3NYP8xKWW+vFmw?=
 =?us-ascii?Q?HUlnollFLOpYbjYPzOAmdjA9OKIkQbjogFgJ2vnoimszElGR005vNt6n4Ctj?=
 =?us-ascii?Q?iEW5GC7yS82lSuiIhoeWtyNrWgt0OQH/KFcHBdXjGq7w4RmsgeV5Ot2q3Tlq?=
 =?us-ascii?Q?Mydh6CXjVifv3LmvmCdnyeb680CodJD/4KAHWQD4EurNXY+bumLqp8WI0r4t?=
 =?us-ascii?Q?uQ8yBReUGVizp0HqhWwpRPWSzn4neosd81k+fmfPDrYNqcyrGEgYjuDzeQfj?=
 =?us-ascii?Q?7EoBEzpMRoM1vIVdkfKVQ9nKcS6Jy7KXs2p65TzO1vouBlX4sVx5XxVBnWdv?=
 =?us-ascii?Q?QaAGmfyYYKXFYrvAReLNiyRpAueficbyHqmW7NZ5Dd/Jvk3tuKt1J9mfJyzz?=
 =?us-ascii?Q?AfEUkU1WMWBKG/ofkxkVD/1HUHXgKLL3+KHf8Hm8o//U7LeCwSk62U3kb//3?=
 =?us-ascii?Q?MJoURQR2qn7tSizEg1alnsqRo/OQP7weJV+/EcZQ0GH2Bu3lzHYCBiZIYod9?=
 =?us-ascii?Q?D+afdP8yVy7CI/cjpTV770SrL92DDvXxB8CMAafVpdyXdYoCO/EA+FIAZNfX?=
 =?us-ascii?Q?v+VO0kH/6Pq/ZcC7V2yoY+rG1G87Pp8LdaZCdz037kDMnScmF1hsqTMV2TUL?=
 =?us-ascii?Q?tt4elBxWSUYKDO4uw6uNQwx5QiLY8jMWK0pBLncgk1gPYu5WnmJ1bKtvbD6d?=
 =?us-ascii?Q?ndxugKN6eaQtAflPnRtUqL5FZDzvP6tww8bg4BG6T9zaEHAkf4lChlIRRjNy?=
 =?us-ascii?Q?A1jtwb98iZRybyTCvs2u22eZUlQfv2DtKHJHxmTW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d78982f-b2bc-4572-382c-08dc4e8fc49c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 18:57:36.6811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jP/Jtks7rDZRzAkpnz8W0heK5XGbADVymwqYdnzhYMaVl/LK3PuoLGDDKKW9XQI9tf6sivpbVAojpFltROZldA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB9002

On Wed, Mar 27, 2024 at 05:10:32PM +0100, Niklas Cassel wrote:
> On Tue, Mar 26, 2024 at 02:56:01PM -0400, Frank Li wrote:
> > On Mon, Mar 25, 2024 at 03:23:55PM +0100, Niklas Cassel wrote:
> > > There are two things that made me read this code multiple times:
> > > 
> > > 1) There is a parenthesis around the first conditional, but not
> > > around the second conditional. This is inconsistent, and makes
> > > you assume that the return value should be treated differently.
> > > 
> > > 2) There is no need to explicitly write != 0 in a conditional.
> > > 
> > > Remove the superfluous parenthesis and != 0.
> > > 
> > > No functional change intended.
> > > 
> > > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > > ---
> > >  drivers/misc/pci_endpoint_test.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> > > index bf64d3aff7d8..1005dfdf664e 100644
> > > --- a/drivers/misc/pci_endpoint_test.c
> > > +++ b/drivers/misc/pci_endpoint_test.c
> > > @@ -854,8 +854,8 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
> > >  	init_completion(&test->irq_raised);
> > >  	mutex_init(&test->mutex);
> > >  
> > > -	if ((dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(48)) != 0) &&
> > > -	    dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32)) != 0) {
> > > +	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(48)) &&
> > > +	    dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32))) {
> > 
> > Actaully above orginal code is wrong. If 
> > dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(48)) failure, 
> > dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32)) must be failure.
> > Needn't retry 32bit.
> > 
> > https://lore.kernel.org/linux-pci/925da248-f582-6dd5-57ab-0fadc4e84f9e@wanadoo.fr/
> 
> To be honest, I do not really understand how this works,
> and I don't want to spend time reading the DMA-API code
> to understand why it can't fail.
> 
> Feel free to send a patch that you think is better than
> the one in $subject. (No need to give me any credit.)
> 
> 
> > 
> > I am also strange where 48 come from. It should be EP side access windows
> > capiblity. Idealy, it should read from BAR0 or use device id to decide
> > dma mask. If EP side only support 32bit dma space.
> 
> Yes, I agree that it depends on the EP's capability.
> (and I also wonder where 48 came from :) )
> 
> Namely the outbound iATUs on the EP side.
> (and the eDMA's capability on the EP side).
> 
> At least the iATU in DWC controller can map a 64-bit address target address.
> (Regardless if the EP has configured its BARs as 32-bit or 64-bit).
> 
> However, this feels like a bigger patch than just fixing some
> stylistic changes.
> 

It doesn't make sense to fix wrong code's stylistic instead of fix the real
problem.

Frank

> If you feel like you want to tacle this problem, feel free to send
> a patch series. (It is outside the scope of what I wanted to fix,
> which is to just make the existing code more readable.)
> 
> 
> Kind regards,
> Niklas
> 
> > 
> > dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(48) still return
> > success because host side may support more than 48bit DMA cap.
> > 
> > endpoint_test will set > 4G address to EP side. EP actaully can't access
> > it.
> > 
> > Most dwc ep controller it should be 64.
> > 
> > //64bit mask never return failure.
> > dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64)); 
> > 
> > if (drvdata.flags & 32_BIT_ONLY)
> >     if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32))
> > 	err_code..
> > 
> > Or
> > 
> > if (dma_set_mask_and_coherent(&pdev->dev, drvdata.dmamask))
> > 	err_code;
> > 
> > Frank
> > 
> > >  		dev_err(dev, "Cannot set DMA mask\n");
> > >  		return -EINVAL;
> > >  	}
> > > -- 
> > > 2.44.0
> > > 

