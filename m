Return-Path: <linux-pci+bounces-6354-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AA18A861B
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 16:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B35CB210D5
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 14:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC7D13A265;
	Wed, 17 Apr 2024 14:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y/tq+W/E"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2048.outbound.protection.outlook.com [40.107.15.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC0822334;
	Wed, 17 Apr 2024 14:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713364698; cv=fail; b=GNOD88RPhR5SazdOZgTGQ1gd+CgZLzGfl0S8Vwkt3ZtTP8wxtZ45r27QhIWZARs2r+zVYaGsyWWawuXhMWuAD3cCMiDEjrMejv97bxqLJdOjAhOOJNELkEXySwTwUIYPgPoT/5Wr7VksTrJ88SWYmFGWdsybQ7MDBEjlYTtFFZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713364698; c=relaxed/simple;
	bh=KgRTQn5pqYFk7XlNkk6DA9ZdGyi7fybVuPF1xp1bwfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EqZXw4dwrfoV+j5jntDYQy/5ipmvYla/QAjnHIffQHZhPfhlPjiv0Ij8tphPkGahKcfMorxuv93DT8L5ymhh3JzW7gMHCPzIJ31H3ZHn2ynmI9+CCAz8cjYKgZNhmRaPV5isiKZHVQc/JLiZVDgQ5ZY0AjQ9C7SXbVVK/02hBhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Y/tq+W/E; arc=fail smtp.client-ip=40.107.15.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dxi4U7rGFSp8IkPmyTF1d/7OiKa3bT5Ks7GSyMsjrlH9T+U+h5g2VqhQ/Nn7CeP6rFCfcPOjW7INnmsaUrUO6ssteqyM+ri00r+y+IK/HCUyDDXIIkRytcYTa7ezJqFBveJyuqljInsT0qVWvf5ZaBZ4CcKEPGmkuY24AGYLrmvgwC0Hr5uFhk4vC+uaXKJRd+fkOnVa9ernwRziMuAj5UfVImO94QrvUqKtjiLM9oNqpRe6TGbptAJRplIzTRcYJ6t0wpoBgrD4/GRZMMkJ/cXHyphzcRJtV3utYfvWzGukCOwC/RNmR4iScsRbZdcTQyFwJvNk1X8FHO66xtL/8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dMUkDroFmc3r8Q6xtq99hvmNzl26f/UFYdt9K2AjsJw=;
 b=XbuUG0DAPBQfQpWo1laVXtrV/B57EsJEY4LfSrBJs7uHjGQ/WS6+bs7RT1JQsLr0PH6pD7RbGTKz2ZU1GF/2GY86iuo9K8Jqb4YbEf6nCarOZy3YOhcS+PXaBWNGmkgOdfJeDHNn/hpwUram9CtyJkEcoznJIWhh4/nHC1iD5vXyBJ3y/0P+taaH6BiR/lScdpET7TYb3A7wH8dAHr4e5tpxwiuAAUDlsPfmZ5oBsGqiwuvGXA1ss5C9dzbq9wkc1rdotGMl4Z+xKKDCZLgbaQtMPkwIFhwv5sH6btSqdkTRNmTF6gVBNv0TwXPBrJWE5o8EyWLLwZ2ZV+tWIlR4kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dMUkDroFmc3r8Q6xtq99hvmNzl26f/UFYdt9K2AjsJw=;
 b=Y/tq+W/Ee2SNBxLczpL9jdWzNXOF2Vio2G/wWbf6RMcA39Bivd1HPjg0NYMV2ibC7d32gRErzbKNbdtN+Hnq8UHwFN2f107iXlWsb/tnaEUEIXDQp1DUwKbuNSdobtQpSeXoUC8Yzrqzc0OwKXP7I5BvxhnkfyeTjCczkmC1vEk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VE1PR04MB7357.eurprd04.prod.outlook.com (2603:10a6:800:1ae::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.49; Wed, 17 Apr
 2024 14:38:14 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 14:38:13 +0000
Date: Wed, 17 Apr 2024 10:38:04 -0400
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v6 5/5] PCI: dwc: Add generic MSG TLP support for sending
 PME_Turn_Off when system suspend
Message-ID: <Zh/ezLdct9sisvhc@lizhi-Precision-Tower-5810>
References: <20240415-pme_msg-v6-0-56dad968ad3a@nxp.com>
 <20240415-pme_msg-v6-5-56dad968ad3a@nxp.com>
 <20240417101944.GG3894@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240417101944.GG3894@thinkpad>
X-ClientProxiedBy: SJ0PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::12) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VE1PR04MB7357:EE_
X-MS-Office365-Filtering-Correlation-Id: 94341345-7ede-422c-073b-08dc5eec02fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	R4nsbT43VyoMYeWxU6TNSko04bB+fh7McrO+lSWas4nXiS5r8B1O3h2p2TQxQcc22dxMGjIRcEI+qWOtmI7eDb5XL+D1P17YOE8v9FNcul+pTCRGpSVsaC2olqnlbOFOY/NH0vYQ9LUDwD2S1WTCWXJEkcCcmgxydWrjHqoy27yDJdOj4qubibIsBlZLRYoz1SuxW55kfoi6t0s9wRwhQg2X+InikPq9jozfEfvTJbkydYSQl4FHZjsV8E8BI/f9+Fj1CGISVfX6LimEvSG3ZJU2SLKg4i3DVgeoBlOOD/VVW/5WVa9cNbzjWeHp7AXZF0+tmV0gn2nDyvfLvDpivUfuTryUJEnCLdidPV3kZ+J3miYkC/TwCzuzSwb8Stb6jYBYbpNyPVaaDN+g6p331i8o2Rlbmd91C/oY9JncOZguDy04Q/DTZ5SrDPwpeY7nHHn1ShaRcEIi9aflt38go/bn8MR1ByMv1/mdWpX+y8YkITSNmxJUFg5t+ghlNKpk51ejjzgigR55Plea3i0y3YlSDBuhQ9dou627jL7yp0+CCS07SuYc5+zOvEpqYv+1AiB25uqz7MJ/30cW8JR+4SD9FBZRHTK2zV/9y+vMmfPJn+wREVeN9p7lbkG4kewlF98wnbODoSmELC1sT1Z3bkJIm2CBFDbe2+o1PaAFzWxFl30oeSzy5KEcFBViP5as3iwIqI3KcXAYFzveNwYZ1bKbuUqbogF4ExLbzlV1MnI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(7416005)(366007)(376005)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y1FOdWg5cTM1NXk5S1cycG5HY3BjSFhhR1U0WisxRXpUc1FRYmtMbzBicFUv?=
 =?utf-8?B?Q0xTeVJudS82WktKSVlZVlZLS2RIK0cxZHliRFQ4UjdYTlpTTGpQYWo4VHdi?=
 =?utf-8?B?MEVMZzFMc1AvV2tJRkxwV205TVJtME43T3Iyclk4aXhzWHdPVTI2dWlDZ002?=
 =?utf-8?B?UEw3aTJodEtwUmtGQkRZQzBWck9aZHVheTZ5dFljL2RrVGhpYjFKQVZvTDQ3?=
 =?utf-8?B?b1VUdGZtdGdNeHZqZi9XaWpZQ1NtWjNSQXhLcnFNelVTSXcwRWQrSSs0ZStM?=
 =?utf-8?B?Wkh1WC9yY1c2eE01ZWw1RlBsMnZaRkxLMjJOeG5VNThaT084UXlFVFVZRHV5?=
 =?utf-8?B?eldLMTExV2VsY3FXNHFtR3hKc2pJUFVUTkpuQzJmRHhEbFRDblNCZzl1Z25m?=
 =?utf-8?B?bHNTRXlCY1pZa2ZaS3N0SHJBa3I0ZUFlRXlaWHBFWUswLzB0QUpNM3J0Y0kr?=
 =?utf-8?B?UUc3TGlZWEVibFovK3lDbjNRZUZTcEJLWXp4OVNNcWpmZmtaRXplTnU2Q1Zp?=
 =?utf-8?B?WWRieDltUUNybjc4ZXJLNFUrUGZmRjZ5eU1NWlRnMnp5c1FTQ09GRGpValRa?=
 =?utf-8?B?ZHo3Z05PNGVyT1kyL1NPeHN0cjA4MzBwZmk5Q1JnTXJ5S3YzM2NGM0QxdXJF?=
 =?utf-8?B?QWNRVGw0L2xYblpFMGIxRUpDWWdkRDdFREtsMGhuTEthZ1NSbzBvei9iQUtM?=
 =?utf-8?B?akhtZURDNWNOcTcvL2V3WWJQQ0RKVW5zdi90bm9aZ2NDYVUxMG1GblFiRVBM?=
 =?utf-8?B?WThSOEdrRm1ZS3VqTlZERTJVakZyYmtHUW16cWdmemhyeWJqdS9KSTNhQXpk?=
 =?utf-8?B?NVNjcC9MYVR3MFpGM0hEazVJdHlhSy91VHQvbVVaVlZEQU85aGMvNm5YR2lG?=
 =?utf-8?B?RCtRM1lublBNeitCMG1UM25rRlhpc2NHdUpBTFIxRHZTVi9aRWh3UHNYTHlG?=
 =?utf-8?B?amJrWTlwMDVmMFF6V0JqQ29mcVBhWkJrQXpkWWc5bXExelB2aXNEUzNkU0JZ?=
 =?utf-8?B?VStGWkQxeTBrMzhCNGlxUDFQMml3Y2JveUJxTDNCbmR5eTAwY0xjRk95TVhK?=
 =?utf-8?B?OFhwZ29RaG5YNWkzTWx3OXhRMnp1YTZzQmxmcVdZamozMms2dnFzZ0JSMmwx?=
 =?utf-8?B?Rks4MTdsWUhJMGtrMTR5LzU3QUw5aGFJZVFiTkErUnBFUEJxcjN5WkZkWjlZ?=
 =?utf-8?B?RDZkMGZZdUVObkNndExIU1hGUkVneUhYcnlURXhweE96SllKOGtEcVdRcTd6?=
 =?utf-8?B?TkMwL0JrY24yQlZGdTVEOHYxTXljMjhOeXpMMmQzSWRBcHA3cUh3WHh6WE11?=
 =?utf-8?B?ditKUkVzdnVPMWRJWWd5TExkc0dvMVVNQTFab29qQWFGajhveVlWNXIzcmZS?=
 =?utf-8?B?Qi9kZm5Cei9nNkkraTZlOGRRU0UxMjltZWdJTmFsYnVUbE9pOEdqcEZDOW12?=
 =?utf-8?B?NFBuMktxbm1SNXg1OG9tdGx2Y3RUYXptSnZrSDg5eTlTV0lNdHJlaGNaQVRw?=
 =?utf-8?B?WDVCUlpxUk9qaHptdVFBSWV0TmpJTHJrcUpYTWlsUHZTa3MrcTI5bUhVa043?=
 =?utf-8?B?bWd6VnpRWFNSQ0ppT1h3eUxrZHplMmFLbzFaVkRlNTkrWDQxRERMdHJCNm00?=
 =?utf-8?B?YnUzWmhhcGxqaGdCQkRUY3FLZXRaOVhEVjVMNW9NR1lSRkd6TXhyTVpOMDhy?=
 =?utf-8?B?aGtTL3hOMHloVWZsSHVsVkZWUTBCSmY1K2QvUGhCUDVNVHYyaXl5OEZvZThS?=
 =?utf-8?B?T1dVTEtOVFBXaFNVNVBBY1l5M1ZjUjMwSXFaRVRJck1CWXRkNmcrRVRYVVpQ?=
 =?utf-8?B?bnhvWlEweGZoRzJwQmU0b01GaXFBcEwraXFtYWdqZThXSFh4TDNwNHN3eFR2?=
 =?utf-8?B?REQvUjBDMG5KRXFBb1FMWjRmeVo5aWNGUDlacnRpYVhwc0c5djduQU52YTgy?=
 =?utf-8?B?Umh0cnR5SnZCbmVnYS80cm5ONnMycFprdjFIT0lkWER1VGUyVFBYZ2dUSzMx?=
 =?utf-8?B?TVUxUFYyZDJrWHNCbkVaaStqRnc4Q0lxaVphNktRdk85S2NScXdiOWtzaDRL?=
 =?utf-8?B?QnNEWlhRaFN1OWZBRWRUQy9FZDFTbUYzUkp0ZnFHVTltYnMvQ3MyRmNaNWFS?=
 =?utf-8?Q?o1WhX84egBogHY5ly5tac5HR0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94341345-7ede-422c-073b-08dc5eec02fb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 14:38:13.8395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u9MxmxG3bUt73Hhs3RkvG1+H2UH31T4w6X01appcXWuqxXEgC+DvPdm68Mx3k+0LL56X47mtywz9X3UHwfIQ0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7357

On Wed, Apr 17, 2024 at 03:49:44PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Apr 15, 2024 at 03:33:29PM -0400, Frank Li wrote:
> > Instead of relying on the vendor specific implementations to send the
> > PME_Turn_Off message, let's introduce a generic way of sending the message
> > using the MSG TLP.
> > 
> > This is achieved by reserving a region for MSG TLP of size
> > 'pci->region_align', at the end of the first IORESOURCE_MEM window of the
> > host bridge. And then sending the PME_Turn_Off message during system
> > suspend with the help of iATU.
> > 
> > The reserve space at end is a little bit better than alloc_resource()
> > because the below reasons.
> > - alloc_resource() will allocate space at begin of IORESOURCE_MEM window.
> > There will be a hole when first Endpoint Device (EP) try to alloc a bigger
> > space then 'region_align' size.
> > - Keep EP device's IORESOURCE_MEM space unchange with/without this patch.
> > 
> 
> I'd rewrite the above sentence as:
> 
> 'The reason for reserving the MSG TLP region at the end of the
> IORESOURCE_MEM is to avoid generating holes in between. Because, when the region
> is allocated using allocate_resource(), memory will be allocated from the start
> of the window. Later, if memory gets allocated for an endpoint of size bigger
> than 'region_align', there will be a hole between MSG TLP region and endpoint
> memory.'
> 
> > It should be noted that this generic implementation is optional for the
> > glue drivers and can be overridden by a custom 'pme_turn_off' callback.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware-host.c | 94 ++++++++++++++++++++++-
> >  drivers/pci/controller/dwc/pcie-designware.h      |  3 +
> >  2 files changed, 93 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index 3a9cb4be22ab2..5001cdf220123 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -398,6 +398,31 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
> >  	return 0;
> >  }
> >  
> > +static void dw_pcie_host_request_msg_tlp_res(struct dw_pcie_rp *pp)
> > +{
> > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > +	struct resource_entry *win;
> > +	struct resource *res;
> > +
> > +	win = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
> > +	if (win) {
> > +		res = devm_kzalloc(pci->dev, sizeof(*res), GFP_KERNEL);
> > +		if (!res)
> > +			return;
> > +
> > +		/* Reserve last region_align block as message TLP space */
> 
> 		/*
> 		 * Allocate MSG TLP region of size 'region_align' at the end of
> 		 * the host bridge window.
> 		 */
> 
> > +		res->start = win->res->end - pci->region_align + 1;
> > +		res->end = win->res->end;
> > +		res->name = "msg";
> > +		res->flags = win->res->flags | IORESOURCE_BUSY;
> > +
> > +		if (!devm_request_resource(pci->dev, win->res, res))
> > +			pp->msg_res = res;
> > +		else
> > +			devm_kfree(pci->dev, res);
> 
> You are explicitly freeing 'msg_res' everywhere. So either drop devm_ or rely
> on devm to free the memory.
> 
> > +	}
> > +}
> > +
> >  int dw_pcie_host_init(struct dw_pcie_rp *pp)
> >  {
> >  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > @@ -484,6 +509,16 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
> >  
> >  	dw_pcie_iatu_detect(pci);
> >  
> > +	/*
> > +	 * Allocate the resource for MSG TLP before programming the iATU outbound window in
> > +	 * dw_pcie_setup_rc(). Since the allocation depends on the value of 'region_align', this has
> > +	 * to be done after dw_pcie_iatu_detect().
> 
> Please wrap the comments to 80 columns.

New code style is 100 columns. does comments still stick to 80 columns?

> 
> > +	 *
> > +	 * Glue driver need set use_atu_msg before dw_pcie_host_init() if want MSG TLP feature.
> 
> How about,
> 
> 	 * Glue drivers need to set 'use_atu_msg' before dw_pcie_host_init() to
> 	 * make use of the generic MSG TLP implementation.
> 
> > +	 */
> > +	if (pp->use_atu_msg)
> > +		dw_pcie_host_request_msg_tlp_res(pp);
> > +
> >  	ret = dw_pcie_edma_detect(pci);
> >  	if (ret)
> >  		goto err_free_msi;
> > @@ -541,6 +576,11 @@ void dw_pcie_host_deinit(struct dw_pcie_rp *pp)
> >  
> >  	dw_pcie_edma_remove(pci);
> >  
> > +	if (pp->msg_res) {
> > +		release_resource(pp->msg_res);
> > +		devm_kfree(pci->dev, pp->msg_res);
> > +	}
> > +
> >  	if (pp->has_msi_ctrl)
> >  		dw_pcie_free_msi(pp);
> >  
> > @@ -702,6 +742,10 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
> >  		atu.pci_addr = entry->res->start - entry->offset;
> >  		atu.size = resource_size(entry->res);
> >  
> > +		/* MSG TLB window resource reserve at one of end of IORESOURCE_MEM resource */
> 
> How about,
> 
> 		/* Adjust iATU size if MSG TLP region was allocated before */
> 		if (pp->msg_res && pp->msg_res->parent == entry->res)
> 			atu.size = resource_size(entry->res) -
> 					resource_size(pp->msg_res);
> 		else
> 			atu.size = resource_size(entry->res);
> 
> > +		if (pp->msg_res && pp->msg_res->parent == entry->res)
> > +			atu.size -= resource_size(pp->msg_res);
> > +
> >  		ret = dw_pcie_prog_outbound_atu(pci, &atu);
> >  		if (ret) {
> >  			dev_err(pci->dev, "Failed to set MEM range %pr\n",
> > @@ -733,6 +777,8 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
> >  		dev_warn(pci->dev, "Ranges exceed outbound iATU size (%d)\n",
> >  			 pci->num_ob_windows);
> >  
> > +	pp->msg_atu_index = i;
> > +
> >  	i = 0;
> >  	resource_list_for_each_entry(entry, &pp->bridge->dma_ranges) {
> >  		if (resource_type(entry->res) != IORESOURCE_MEM)
> > @@ -838,11 +884,48 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
> >  }
> >  EXPORT_SYMBOL_GPL(dw_pcie_setup_rc);
> >  
> > +/* Using message outbound ATU to send out PME_Turn_Off message for dwc PCIe controller */
> 
> No need of this comment.
> 
> > +static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
> > +{
> > +	struct dw_pcie_ob_atu_cfg atu = { 0 };
> > +	void __iomem *mem;
> > +	int ret;
> > +
> > +	if (pci->num_ob_windows <= pci->pp.msg_atu_index)
> > +		return -EINVAL;
> 
> 		return -ENOSPC;
> 
> > +
> > +	if (!pci->pp.msg_res)
> > +		return -EINVAL;
> 
> 		return -ENOSPC;
> - Mani
> 
> -- 
> மணிவண்ணன் சதாசிவம்

