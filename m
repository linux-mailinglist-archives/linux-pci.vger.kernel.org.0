Return-Path: <linux-pci+bounces-4145-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9440869DE5
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 18:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41C4B1F23C2D
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 17:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29AA48CE0;
	Tue, 27 Feb 2024 17:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MBdV5KSJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2082.outbound.protection.outlook.com [40.107.6.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8FD1E896;
	Tue, 27 Feb 2024 17:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709055546; cv=fail; b=JSn67K57gGYsLWJgycMh7JqWWdwHjYcqI10OruN+8Wp8PIIHIuiCOibd/mWR6gaxNfrOCNdJZG5apn1Xtea5fokn/pWEYEDDz9LmxhMsiBK6fZX6Vv6pC6lYayfZ/e6z8BFv5PTdlQM8/7Z6dFWE4HP8ZJrJmdS9RsF+KbVpZaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709055546; c=relaxed/simple;
	bh=+II4BuTHSPtiFd1ULeDsAtTNF9M6AG3tiNt39fWX56A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WcK5odQmgOBT8FaECUoe6U1GqYvPLP/dnZi52mQY55GeLTyMlshgWhQ7RIx7nIlR6oeyqcUEfxi0uUJgQ97E+NUrLYD3fuOetKlZ2GsVviVRgea+NxLhMqhsfHO/x2ZldkneHWrz1NLuG9jWIyOhYLwpi97i3lFwBu6jVOEQJwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=MBdV5KSJ; arc=fail smtp.client-ip=40.107.6.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CqNnTINMJ35Vn9BPG1glmplhEcAnPHee6VSf6Kw0156WrOEgK1oJ6zgzJRvZdleBfh6re9suEB5tV0xDPBLgojf7UcZ8/LXZKqGXxiJnmLNUBWYbYwynXNwIc8+cFUkU2t4KvjaOzF9NF6BCAOYe6C4sEkarUaENXqRR4A1/x1Rf56kDETWSIPevz2bQe79VzryFEHWU4dpoDtFYgZZHE6R6trg5yOuAynhWvrUVQiYjrzj8+mGCJRN+laXON2qIZN2tfmdmxXfHyMhWfXScxckOcvobQNX8eqP/MEXehBuYT214yczXW95PXaidku2j/np/pWSns3ELqK0XCaI+Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uz+DHxDCUx/FREkCFHetlvIkgz5rnHJhyGZqQgtzvtA=;
 b=KqHFy4RZMpnnO4dvXrefJKPh+GOvNl1liOlm85HU0CM1cc7gKb1//LaOqMVClMFXspsE2I29wLWuApslO+J5IF+G+RZDeUxYxjDn4tiaCz/zC6H4RUraEcq8A3KzK6gZN7HkPIW5Ob06giRrBBSoEa+DcCG0/Ix7mUZQW/4cwA7cmK0y2D06Q5N5E0Gxv9rN4GMe424rjt8hYbD+AMjFVweNVqNQnD8qT29VCb6Matw3QNYR1XvDR6L4DcCCVXfALGkERnvC6iIOoQMh1JeSuGmGR+W0glULJnO1/+tOTYnZSf+NLCBXs+jA1LSENuH3Os+FitSlJKkrkqfEtPAwgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uz+DHxDCUx/FREkCFHetlvIkgz5rnHJhyGZqQgtzvtA=;
 b=MBdV5KSJVlgjqhJcp5Kt0c3uqkEbR6i964GRL1L/54YPUnmkprJ1TSi1VdxjIXDEDd2E1EHbaZEcq5okBNfOakJS65eWzvmb5/NvOqCdO8OLGp46AyJsm7WHh5j5BRyXjjj+L4vYdLsE8ZrAmT0TBDsNncc36yX1WagqZrfWm/Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9631.eurprd04.prod.outlook.com (2603:10a6:20b:476::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Tue, 27 Feb
 2024 17:39:01 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Tue, 27 Feb 2024
 17:39:01 +0000
Date: Tue, 27 Feb 2024 12:38:52 -0500
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
	Siddharth Vadapalli <s-vadapalli@ti.com>
Subject: Re: [PATCH v3 3/5] PCI: dwc: Pass the eDMA mapping format flag
 directly from glue drivers
Message-ID: <Zd4eLBXscaV1WkbV@lizhi-Precision-Tower-5810>
References: <20240226-dw-hdma-v3-0-cfcb8171fc24@linaro.org>
 <20240226-dw-hdma-v3-3-cfcb8171fc24@linaro.org>
 <Zdy8lVU6r+JO6OSJ@lizhi-Precision-Tower-5810>
 <20240227074533.GH2587@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240227074533.GH2587@thinkpad>
X-ClientProxiedBy: SJ0PR13CA0235.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS1PR04MB9631:EE_
X-MS-Office365-Filtering-Correlation-Id: c0869dcb-5ae4-48c2-a44f-08dc37bafbdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bba4ZIzMCjk0T6rP7F+6TsCLyqxwZKx6QvLd53uQqvEN7lQd0t+UCMf0Xj3PBhWt9uQSkXsG4vuS4AHw3Dd8SwTlcmrgiTkUivF50cmc1cI2dcT+OTeb8ZHYAw3kWTIBtkpyZXX8dPWJryGtlo2Wtj1X1CpI5cUBFXl+7OB0mbCJvS1/wrdbkXDMCLukWh1Ubou+7eNQA64z/ISQ5b8j4SQDaf/sdwV/OhFHGNYycP7QufoCiHrDToUMfJ55VYlb4yNCZ3uQGsVsgajDNtaswmNeJRKSnKK22wanroPAGmbmgXoU849Kg64lEE9yjpn+TbzfBa1ZgH9j1oOhirzSWUVKuoA0WMZXtMcUNUwR7fZns48SXcgtFjlTGOme8gMmknMGPhYVsgRdhtR/GfRhCgcIjkQKSpycC7OQHW5kE0e1Ai7OSmv5/BHuJippTc3gNH+/VYVoBCcx3fAHXnuIb0Z1htAxjjk57A7OcTHfHb0k1JgU2ZhF4+xvpzeJA6BxevoqzyO7thlv7UAekkTfvCauFKWZiOk+nXZItjfaBhmmKaTzF/ZhaRLKFkY25/Al5XWaSbqYoKX1z9BjiJvkg73zle8UlZvtBbqntE9kVSRf0lEKCHaLdUWu5jdDHCogWZjlNCJL0DmYeOuI/DdJK8Iy1pRb3l7rygjYDEhHSXYETLHvgYw3mJImkcNyn5ilubPmzsjZTb9Ro713uClu30JA1ZKODyjPefOPHESMH2g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZW82bkNQYk84bUFGMU5YVEtCREp6UGQ2S1dvM2phL3RDWjdBRkRGYWpSVGIw?=
 =?utf-8?B?TjlybFFZTmFTTkVKV1FldW8vRitBU3A3TzlPNzRWWk5FODVtQkdPbEhjL29S?=
 =?utf-8?B?VndHUXQxdEtaWkhhODJxY21Id0lkbnRKb1p4UmoreHZodnNudytLQUFOeVl2?=
 =?utf-8?B?STlpY1FPd0xsR0dvUlNpMUFrL090bzNxK00zVlNmSXlJM2lRcCtBRi9kc0hR?=
 =?utf-8?B?Y3VMcXU1ZkQranM0RGFrTUZpbUZWU1RSY3ZUcktMc0hieE9GK1BieUNRajdx?=
 =?utf-8?B?dlM4ZEVRVjdqZDhqM1dmK1dibGIxWnRPWXpDczkxbWdWQUl3WERDd0xsTXVy?=
 =?utf-8?B?WU8vaGg2b21scGg1ZTRWT0R3NU1uNytnMG5aME1lK0hlYkdPN1ZhT241QU5k?=
 =?utf-8?B?dzhjQW1UWGdPd1JIdXRhT0tJcDRuUUpEZ2Jrd1hSWEFjdk94Z1pnL3l4NTRM?=
 =?utf-8?B?RVhoejIxWkxiVE02dkFWa3JDRlFQZC9RZ01XanNFdWJyZFgwZ3NnK3gyYitk?=
 =?utf-8?B?K3FrakRONmNQejRYT1JyRkJFa3dpa0xnOG4zc1RlK29rekNvNjAxTXdqaWtM?=
 =?utf-8?B?SGtaY2dHYTlmdTZHVnlETFBjb3JvQjlHUVErYnhjSGFoMnlaUTIxWkcxeWJk?=
 =?utf-8?B?ZUJFYVNwV2lXSGMrelRHS1VRdlBIdFpTY3BxUUVCZWwreE1TeE92NEVQSWRr?=
 =?utf-8?B?OHcvYzhaeWdGN0d6WndYVjRSVis5cWt3VTJ6SnkxR1pKNHVrZXpDaXN2bWgr?=
 =?utf-8?B?aWtweXRoZEl4MzgxR08zYkgvM1ErSENIV1IzOWRsL0xoSGZWOTF5VWtLR0dD?=
 =?utf-8?B?U25TdElKMnhwY1RHNHljYTNCUlFya2Zxd2JjaFphNHVQVHNYN0ZTMDdqT0ZL?=
 =?utf-8?B?UktETXIzRU1abXNyekdiaEExNFBLdlhBWDFJaWpNaXJZejNhSnhyemdwOVpo?=
 =?utf-8?B?NnhsWVI0RDlZRGI5NS9QNU9kS1Q5N3luVjlhMUJ4Mzd2SW9aQ0wxK3hiay92?=
 =?utf-8?B?WXdnWE5TOWxqTmI5S3hGdzBDc2xzKzFWT3Rtb1N0SU9JZEZvNUVPL2h0MFMx?=
 =?utf-8?B?Njd6NWN3dUc5dnpnS1phWnZjcXZKSzNPNEM5ZWpuK28wTi9saTFxYU5ZSnJu?=
 =?utf-8?B?Y0xSNml5dVM2N2RrTXZIZU9oK3RBVXMwVW8wa0ZlY0M4anBqbFZ3WE9RZmxw?=
 =?utf-8?B?K2tyMkZpZ0tDa2o5c3duOWpXQU5pSnRzaVhSRTBtVEV0SnloZlo1ZjZpQS9u?=
 =?utf-8?B?cisxbFlzQThzZTJjSCt3Z2JwVjRBclZ3b2wrNDFCSEkvV0hlREVDeHRyK1Bx?=
 =?utf-8?B?Ump6VDdHWCtsRzV0cE4rZGZVR1JVSjF2WnZoMEU3alJQeVJIMHJZaWNYeFVD?=
 =?utf-8?B?QSswQ3kzZWRXVkVaYkNvc1hZbzl1aythaHFodEhJVzd3QWNuUWlJQ3g1OEN0?=
 =?utf-8?B?V1RBU1FRQmFEVUNOWEcrV3FIRWp4TkZHRTVLbVlybXNPU1hFZCt6VWtQell0?=
 =?utf-8?B?SU5XSGZLbE1HWXZja3IwbWFoOWpHTlVrQzB1eXBEaU8vT1hBL3o0ZlVZUU5m?=
 =?utf-8?B?MnhXUzNUMzV4NG5uUlF4S1RrVnFmQ0l0eEEzLy83UEVPYnpTRWgvcmVxa2hI?=
 =?utf-8?B?LzhkZXFlbmVpS1VwN29GUTQ4dTYzbHNueWVnTjVpbmNRRGlONmZaR2o0SkpM?=
 =?utf-8?B?a1lvMUowMnZmNVBCUnhYdlNhQlNGYmw0OW9UR3dvWEUrWGVWZFZlTm9GMXRl?=
 =?utf-8?B?VzhMdUtxTFRsS00zVytkc0JQTW16Ly9XZGx2RkZ1NVZQeG9TR0ZGY2JUUHpr?=
 =?utf-8?B?YmhUVFVYYlAyQk0wWERmc1RwNWtUTVBaZEZTc2hNelBKM2xDeTNIbDRPNE1i?=
 =?utf-8?B?dkZFTnBsNkJHMUZrSm00RVdJbTAwYUR4c0p3L0Fvdzlwb1JQOW9GWG5GZnpp?=
 =?utf-8?B?TllZM0hmUWVaMDY2anVBUnhVNU1VS3EvKzhXbEJXWklTSTdmMXh5Y00vNGQ3?=
 =?utf-8?B?V3B3bVhHeVBGRmpSVUMzbk05TEI4RVRGTHVVclN5MVI4Y3ZhQVlMa2RlckJt?=
 =?utf-8?B?ZkZhVjFEcThvZDBKQzlSRUc5cDZYZ3M2eHRwYXNjdVVyNXltVnhSTnNPVWtW?=
 =?utf-8?Q?LMvQ9JgAxhm/L+yNl/PDIyL96?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0869dcb-5ae4-48c2-a44f-08dc37bafbdb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 17:39:00.9632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h71/rqnC+xSjYz2GcEuSb43lYWiAKJSQsM298C3fmCmKfkxR4NnKIIn5TAAgPoK3HkIM6AjH2PeJN9qhTpN1CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9631

On Tue, Feb 27, 2024 at 01:15:33PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Feb 26, 2024 at 11:30:13AM -0500, Frank Li wrote:
> > On Mon, Feb 26, 2024 at 05:07:28PM +0530, Manivannan Sadhasivam wrote:
> > > Instead of maintaining a separate capability for glue drivers that cannot
> > > support auto detection of the eDMA mapping format, let's pass the mapping
> > > format directly from them.
> > 
> > Sorry, what's mapping? is it register address layout?
> > 
> 
> Memory map containing the register layout for iATU, DMA etc...

the world 'map' is too general. can you use 'register map' at least at one
place? There are bunch 'map' related DMA, such iommu map, stream id map, 
memory page map. The reader need go though whole thread to figure out it is
register map. 

Frank 
 
> 
> - Mani
> 
> > Frank
> > 
> > > 
> > > This will simplify the code and also allow adding HDMA support that also
> > > doesn't support auto detection of mapping format.
> > > 
> > > Suggested-by: Serge Semin <fancer.lancer@gmail.com>
> > > Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-designware.c | 16 +++++++++-------
> > >  drivers/pci/controller/dwc/pcie-designware.h |  5 ++---
> > >  drivers/pci/controller/dwc/pcie-rcar-gen4.c  |  2 +-
> > >  3 files changed, 12 insertions(+), 11 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > > index ce273c3c5421..3e90b9947a13 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > @@ -894,18 +894,20 @@ static int dw_pcie_edma_find_mf(struct dw_pcie *pci)
> > >  {
> > >  	u32 val;
> > >  
> > > +	/*
> > > +	 * Bail out finding the mapping format if it is already set by the glue
> > > +	 * driver. Also ensure that the edma.reg_base is pointing to a valid
> > > +	 * memory region.
> > > +	 */
> > > +	if (pci->edma.mf != EDMA_MF_EDMA_LEGACY)
> > > +		return pci->edma.reg_base ? 0 : -ENODEV;
> > > +
> > >  	/*
> > >  	 * Indirect eDMA CSRs access has been completely removed since v5.40a
> > >  	 * thus no space is now reserved for the eDMA channels viewport and
> > >  	 * former DMA CTRL register is no longer fixed to FFs.
> > > -	 *
> > > -	 * Note that Renesas R-Car S4-8's PCIe controllers for unknown reason
> > > -	 * have zeros in the eDMA CTRL register even though the HW-manual
> > > -	 * explicitly states there must FFs if the unrolled mapping is enabled.
> > > -	 * For such cases the low-level drivers are supposed to manually
> > > -	 * activate the unrolled mapping to bypass the auto-detection procedure.
> > >  	 */
> > > -	if (dw_pcie_ver_is_ge(pci, 540A) || dw_pcie_cap_is(pci, EDMA_UNROLL))
> > > +	if (dw_pcie_ver_is_ge(pci, 540A))
> > >  		val = 0xFFFFFFFF;
> > >  	else
> > >  		val = dw_pcie_readl_dbi(pci, PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL);
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > > index 26dae4837462..995805279021 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > > @@ -51,9 +51,8 @@
> > >  
> > >  /* DWC PCIe controller capabilities */
> > >  #define DW_PCIE_CAP_REQ_RES		0
> > > -#define DW_PCIE_CAP_EDMA_UNROLL		1
> > > -#define DW_PCIE_CAP_IATU_UNROLL		2
> > > -#define DW_PCIE_CAP_CDM_CHECK		3
> > > +#define DW_PCIE_CAP_IATU_UNROLL		1
> > > +#define DW_PCIE_CAP_CDM_CHECK		2
> > >  
> > >  #define dw_pcie_cap_is(_pci, _cap) \
> > >  	test_bit(DW_PCIE_CAP_ ## _cap, &(_pci)->caps)
> > > diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> > > index e9166619b1f9..3c535ef5ea91 100644
> > > --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> > > +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> > > @@ -255,7 +255,7 @@ static struct rcar_gen4_pcie *rcar_gen4_pcie_alloc(struct platform_device *pdev)
> > >  	rcar->dw.ops = &dw_pcie_ops;
> > >  	rcar->dw.dev = dev;
> > >  	rcar->pdev = pdev;
> > > -	dw_pcie_cap_set(&rcar->dw, EDMA_UNROLL);
> > > +	rcar->dw.edma.mf = EDMA_MF_EDMA_UNROLL;
> > >  	dw_pcie_cap_set(&rcar->dw, REQ_RES);
> > >  	platform_set_drvdata(pdev, rcar);
> > >  
> > > 
> > > -- 
> > > 2.25.1
> > > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்

