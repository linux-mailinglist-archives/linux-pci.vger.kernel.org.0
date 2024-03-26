Return-Path: <linux-pci+bounces-5198-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 655BA88CC75
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 19:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E69B5309688
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 18:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D6313C67E;
	Tue, 26 Mar 2024 18:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UnE1mUUh"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2109.outbound.protection.outlook.com [40.107.22.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F12F129E88
	for <linux-pci@vger.kernel.org>; Tue, 26 Mar 2024 18:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711479374; cv=fail; b=mWYhrpvAVptO4Yw5wY5PBSIm79+9q0Qh6MDb28OhgiNfcElmJezXYlZdzm4ILOacvW4WjyiQ0BrQjUCtt5ks/TKghUvacErxBl/N2ppbgS8sLOq1NJ1+Zy+0Hv8K8aLOkf5oo4JIXY4S0h1i1ACgHsTQl7Gn8Fkwr6hpWR1ZD88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711479374; c=relaxed/simple;
	bh=sCyyQZ4cuSfkw/SxITVEuQBzfikVVpk28/IilEwfK7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=l9P4C7XehLpLFE1u7+Y2NdPzjx5wwVtwzsr3V9Ir0eQ5PlpWVVZsPNf1UHtqnVV59E9hZLDz7imqzrDncOuuYh2jaiZQm3+1SRGwz+hdhDEkoMR2cgpaAhIcADDWB2+QhfX6AMbec6I06F0sUq9XiLnmEtwU1cLiQOOizqlnnDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=UnE1mUUh; arc=fail smtp.client-ip=40.107.22.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lIGjCJvRBE2WwtRctFJJH1iiWPQxBfDnSFQffqZz7yyQobMnDgXMEp5i4Sy6y6FH4bnYh/LofRqhjiFRy+m5U8pC3/8FNgtx9go8sX2/JO7kuh2hwoh7ULB7gOMKTZznGOuuKrhkCCS7EFek3u6GIWLMYTRtL/N8uu9WCNfmoM9sDSkgVHqU8bJW2uA/rewEbWaeU7Uvz5LOnGx9P8ZN1in0m6pdP8UuC9KbkyMItj3J+rmkJcBM3TTZCVJ1PuVzu4pjmjJmwB5lZlaYV3laXVUwfw03wYeg3UG932ofGhx07uBeCAMq5q3tsNlOmeN8PIZe8POdDfmXNvDbx0BX/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cunf8btstACNvaCihi8289+u4a47wMULkg4pe3nQ3zw=;
 b=BBSHuau9AO7nBdzD+3CI5ujLZX7vet+f9To8h9tEHyNGnpSJNW65EPr+55oiT8kvzkWuqqfyA8TQ02eoAGOKo+C00AeNgZrpDKMKQ73K/F09asGYBitEGGeFPPZVdw7GLYsQGl+OV39KytoFlPhvXUYtYR7O1qblsB0ftaxR3z9pdqRvTWpYSm8KAWzuJFy5lhca2hKh3LXTkLchyTV1xg6xgAcabNmgW93VCXTeJWW2LRJs8iwO/XgExKYlQNefvaXLGfa/YxsWMwskUVr8r4DkrwVDA3TQ9rRr6puYia62JhCu63uDsGgo/wGwnOXskdoeTjj2DmMsGtr2VmFSHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cunf8btstACNvaCihi8289+u4a47wMULkg4pe3nQ3zw=;
 b=UnE1mUUhL1sohng1mJCVL8FUxOHV8hhYuKP69z6B8RefCQO+ULmJwOBFkJKzI3t3Ps/WQKcDJP6r5iyHp0Fh/nsY5gGLFEp0pTAUAiKkG6Z7pgTgUaWBy3qOORaF18R4xyC61GeaKk7m2XrnprcKLlMjbFHsi0VsY141Gokb5uo=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8836.eurprd04.prod.outlook.com (2603:10a6:20b:42f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Tue, 26 Mar
 2024 18:56:08 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.028; Tue, 26 Mar 2024
 18:56:08 +0000
Date: Tue, 26 Mar 2024 14:56:01 -0400
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] misc: pci_endpoint_test: Remove superfluous code
Message-ID: <ZgMaQcRsdHvSEGUD@lizhi-Precision-Tower-5810>
References: <20240325142356.731039-1-cassel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325142356.731039-1-cassel@kernel.org>
X-ClientProxiedBy: SJ0PR13CA0200.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::25) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8836:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	48rzJFrH44eqro6XkxtUw63ay879S+ClLPTlAci0rjtJ6ZpXeofGFGJNLXdJYMnn5MBXrfANfvigFQAPooWMHfAsi6qg1UDsnUBxvsX91sVbVhX+TXuQQt1bRTX11mRHNkq3vCV6evnsW2atZLufm+CGDbxBt7BYpqhkOPX5xtw6noJcnAROchJ89joSNmR6W0v70+lpWWI0AqpFfo2ev38Bmz+FJ2LbW4lvDssjColJ8h+M/wenLKi2+/2r8PUMsU8eCBted8JxUlo32hiQyjVShYOzCStxxvJtPiwnkR0vQ7DFcNe+wS5KTrcIh8ehMuUg/i6Bomdrz96RZ7N2X8TImoTALuynswTYOx8P8UUkEpZ7QoT9e4fO+DEVoXpwhZSJAIpDSejKDai/vkq4RHJQdxzFyYIm92BbBIdGZKJ/HCNiqFhxnQl4BFsS4ZhJGbJ/ny9a9ZZETVH2AxUn55gINtrvtuS5frNAa6jETSRNOe+3bZ3WhPWKNpO1/RZx2JTrrBsOQ+jTUR+EEVksH4OqFW6VtxUphwrjEPEwL/lwBu0yVMDf6XDlavW/BRcwfeul3UhDpXuJ0+DJK/rTsyRwdQjE2uYKoAgUcbAFR962aN/7iaL9ZQ9T3PC+aNrm9EkXpdYa2XLaFj6c0QM6Hvm8YVK83bOpvO5HhwG149Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(52116005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?001Dkfk2Rp5yI10EnsNMQD0d/t6XLd6aOM1HHbGw/lUk5ZEGpFHfpkoYd/64?=
 =?us-ascii?Q?sqJWRzQmUd2ZySzQSKsp/0X9/TEIuNKFHK+uYoxuvCL766ckvYak7Yaa/g0j?=
 =?us-ascii?Q?iN5uIX+z16GcjaRXqQFEsRxq1uoiYux3y1PkXSeQa3gltsnzUG6MilHemO2v?=
 =?us-ascii?Q?pqHEQZyw4fEHY19VPPr5/itiDOvHx5ubQumHgMqVu4yj3tGkDrmH7KbXtn/i?=
 =?us-ascii?Q?0WIVSigkgucNSXlyt0vCH6N6hEgTM+6Y7gEHsMm+kpuQsrwHgD1dw/rR5BSI?=
 =?us-ascii?Q?Oxy3HX97sbhWL/k7tMsNrDJNf04FjqbeBEVPE60ATFFUl1zEpJqrWOdkTlY6?=
 =?us-ascii?Q?l3aN/k1xG64eyal1uJOToUTdiJ523UKt7SddaJhmRoJ1+avthWV4R/WBCL3C?=
 =?us-ascii?Q?ITpV2uZUVDMr1+42Z+4j8G8YhbbocyIpoelJSzusuQ5lZUiL3r+ron3ntLrX?=
 =?us-ascii?Q?DeGXRLWbcZROhNT7F20ePF7M5CGtHfve+LaxTiYpiNmHL7X8xUwTr3wco+k9?=
 =?us-ascii?Q?klUkRrDKSuMR+jb2jm7PPLm/+J7uwUPVNs3sCGf6+oprp9tYYP5BCxhHRrf5?=
 =?us-ascii?Q?x7eHRFKzucYFLeZbfwLQx7jqakJ1m5C1J70Zc09BzXDmGATVGU8qrahAQv0y?=
 =?us-ascii?Q?Np+7m+UqCl8DzEP3RqERgoD/Bx/UrgBc4nWwma3u2mvr5ohGIRccI2/ZsY4U?=
 =?us-ascii?Q?ROp68LeE8ivzMxUyhEBLLTrES57Qj+mDhjzrljY68IyjBKrxXF51DjrwyUjm?=
 =?us-ascii?Q?Brf4TB9clF5+VbRvQpAfCAP6pJlgeGz+1crD5Hj6qxlifzLCJevJM8XHxUuh?=
 =?us-ascii?Q?uYr91G8XjGvpx+BzTBfAEaOnY3XOPz9E2KndXPczibVcDW5IB7MBWngVs25V?=
 =?us-ascii?Q?2ybKix2/iePs+7gZziZfOGg1SryuETsHTuk4toifyr3UyLs4TFsBWiqtVz6A?=
 =?us-ascii?Q?A8QPowUmOLBfEjlpe7MpNY17wOyUh/J5Dw+QFJdCOfCPRBEctBavpS6+qi5d?=
 =?us-ascii?Q?vVSS7KSMqNxz1OUCGliC2Hvg0Jngj9pU+6VIahA0txTMHPGs+OW39l8icj9t?=
 =?us-ascii?Q?kGNoq641pbICsgDwC0dmPBsDedPsk4oHWZiaQ1jAU0lXDiCAyRjIfR7cUT6O?=
 =?us-ascii?Q?4Y6WCmUKRnbUbtBs3X1hV4HObEAMLnInVJUPh9U+HzdJ9vJ1xG7iPiLi39OZ?=
 =?us-ascii?Q?xDbQS6UX2vNv0dKOCBjgUbj/J6cBakKqgNoUxSdrZhOzf+x5y8wgaFZMSMBN?=
 =?us-ascii?Q?lh1DeGDgnE/UacIUKTsaBvHOvi0u/jz6zvxEbbSNOKoLmVql1w+MR3HwWwoT?=
 =?us-ascii?Q?bo60Kc+mNItODQyJ+A9eEfh/RSl0hV09E+y7cQqGl3vfKK2anwgBr1GYB5h+?=
 =?us-ascii?Q?XdIGwAgMNI/kdyTHHhPLxfNiywILJhnu0iU3lQSIobU6IS3GrHiCe56DQWSr?=
 =?us-ascii?Q?nHpP47Zic/RIVcKoHgieMaPmbWjzZT2r2b9kWSZEVyGcEnyBebvABIKj5Uie?=
 =?us-ascii?Q?Dfv4Y2gqjqUva08pEMgiRn69CeYIBDuKIllL7U4ZrkHRHJB1fFbd5Y5V5t0E?=
 =?us-ascii?Q?kUDzOBX6ZlxNSemSHOI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c799f8c7-d9fa-4665-eec8-08dc4dc665c8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 18:56:08.7537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wmhtgk7CwVYytgyHfpHhJ2SEdRbbQkvxUaUBpcWp760Ls9SaOpCCTvpGSktziZCDUfMhCX1HQsNuoIz4FqoV+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8836

On Mon, Mar 25, 2024 at 03:23:55PM +0100, Niklas Cassel wrote:
> There are two things that made me read this code multiple times:
> 
> 1) There is a parenthesis around the first conditional, but not
> around the second conditional. This is inconsistent, and makes
> you assume that the return value should be treated differently.
> 
> 2) There is no need to explicitly write != 0 in a conditional.
> 
> Remove the superfluous parenthesis and != 0.
> 
> No functional change intended.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/misc/pci_endpoint_test.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index bf64d3aff7d8..1005dfdf664e 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -854,8 +854,8 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
>  	init_completion(&test->irq_raised);
>  	mutex_init(&test->mutex);
>  
> -	if ((dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(48)) != 0) &&
> -	    dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32)) != 0) {
> +	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(48)) &&
> +	    dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32))) {

Actaully above orginal code is wrong. If 
dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(48)) failure, 
dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32)) must be failure.
Needn't retry 32bit.

https://lore.kernel.org/linux-pci/925da248-f582-6dd5-57ab-0fadc4e84f9e@wanadoo.fr/

I am also strange where 48 come from. It should be EP side access windows
capiblity. Idealy, it should read from BAR0 or use device id to decide
dma mask. If EP side only support 32bit dma space. 

dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(48) still return
success because host side may support more than 48bit DMA cap.

endpoint_test will set > 4G address to EP side. EP actaully can't access
it.

Most dwc ep controller it should be 64.

//64bit mask never return failure.
dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64)); 

if (drvdata.flags & 32_BIT_ONLY)
    if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32))
	err_code..

Or

if (dma_set_mask_and_coherent(&pdev->dev, drvdata.dmamask))
	err_code;

Frank

>  		dev_err(dev, "Cannot set DMA mask\n");
>  		return -EINVAL;
>  	}
> -- 
> 2.44.0
> 

