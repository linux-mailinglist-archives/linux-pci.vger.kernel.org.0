Return-Path: <linux-pci+bounces-5886-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE0589C7E1
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 17:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DABA7285CFB
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 15:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1ACC13F446;
	Mon,  8 Apr 2024 15:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PusZ6Ru2"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2123.outbound.protection.outlook.com [40.107.104.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859DF5F87E;
	Mon,  8 Apr 2024 15:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712589086; cv=fail; b=OI/2kYbNDzONXhjtMOJVgxomdwPpy+mtcL5CClYWqlnEVSgAVjR8LhBPkZ0HswxIokKQkix9Ilg2VPwb18NMxeao/Iw+vbLxJRFcAHZohAOOkoJJMJVAA/I+r479H+YfzyMWiztfR7x/nrgASEssBI8NMjRx09c36su5bdOE8Ik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712589086; c=relaxed/simple;
	bh=izuho5vZE3KIs7hubu3upSr/9HMFtzolblsSlpmRtLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=f45Yd8Sb+Vmd9Ir1uB2BZAqXc95TISi1ZrRpfoUGH1d73VgsxyYHgigvwsVG1abih2rlQ33dcwke86GbwOsPXEvVklT3x7bqOR+eqz9vadIRrzpBvorP/Oqx3Yp5/NCUSjdqAmSiR8WANqiPnoVALa4G1dka3np8+h5TNvfmFc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=PusZ6Ru2; arc=fail smtp.client-ip=40.107.104.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cd7mZ3zzAuNcKzFE0zwSStpMdhUV69zIZyZmxbhTn997k2jbUrZ9POwODKH8mTunzQ+xbSHvyEnHGm5rbB96LObQqIa5xu1FdtFKMJVTzkMtbDgFZeFMVxN/42PFNp58eL063miu79WGrQ7lPJxUXHGQEKQIE6D6eAABTN5VLPeK1YRO/ogEMFkZkgDm1wKl8GSlOJLG/Ug1PKhp7XnHQzki+QhG6FgBjhIdsYZU1fboOzh8PSIMyZZCcQz0EdJiIaJxD5XI3rMKl8R2AGQLt9WJ4XnlZF3mjUke8cTkcke6/NOFxzeoQNo9UNwfpwdk/AGXqv/23f9zwjQMkF54yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1P7uCXcwP9KvaNfgmuKjf2xNYJ4Gt5Wtvfkzv+EdCo=;
 b=TQVfd8DrO7PgvEcXSQpuYPGC46zjeuhE2pG4HO8IvKjIFkqEujVihm4VWeU1x3zkqvnkvUYcvv8zqbfn8KT/a5oFJCI+3IVGZsCOeXn+PmGyVE1Q+Cz3l7sK/KSHIEPhcQi3+6hyK2QG+4aV/DPJarvG14Gzp5fpzz7W2GMxDi6yI1QjlLZa/HrJp2tqJMSLLK1HO4/IHLyxWD8LI721hfOBa60J2P+D/7NCed8J8hYU4KLPtXdaHJ8HiEED5dISTysNXckSJAse/b6/ggmmugnTUIJj5CKCh+XF1HYb+WgsWz/JBCqZ25MtG7HI5tLNeNurfKw8ArLSEJkO1iikUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1P7uCXcwP9KvaNfgmuKjf2xNYJ4Gt5Wtvfkzv+EdCo=;
 b=PusZ6Ru2zYc5ztICHSYcDHTYJMCDaCukceOPtEkcfj6CfgdrDHVTBcBRZAqTgmYn2NK19GoH2n1iYF+NuC8031mF54Qr2X8Z/b2lMbNPb0j5wP+EsxNuP18KNTRY3p2QJ2XS3sMONQoe6z63W8Hz3Dt9xouJoJQOmeIVGIx7ibo=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB6806.eurprd04.prod.outlook.com (2603:10a6:20b:103::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.54; Mon, 8 Apr
 2024 15:11:22 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 15:11:21 +0000
Date: Mon, 8 Apr 2024 11:11:11 -0400
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
Subject: Re: [PATCH v5 5/5] PCI: dwc: Add common send PME_Turn_Off message
 method
Message-ID: <ZhQJD7GjRpDwa6jI@lizhi-Precision-Tower-5810>
References: <20240319-pme_msg-v5-0-af9ffe57f432@nxp.com>
 <20240319-pme_msg-v5-5-af9ffe57f432@nxp.com>
 <20240405062426.GB2953@thinkpad>
 <ZhALNGyNTAzN86GF@lizhi-Precision-Tower-5810>
 <20240406040131.GC2678@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240406040131.GC2678@thinkpad>
X-ClientProxiedBy: SJ0PR03CA0156.namprd03.prod.outlook.com
 (2603:10b6:a03:338::11) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB6806:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GIlF+i4Hv5FVv0GXXiI8t/grzmb5ZJ2HxpgoY7uPfYsl5igYZn/36uQAXuXetF8Vbgwq2Hijk9Fbh/ZvS0vdJLobsYbhw6fh2sx2Q8klRiYa+L0mrcclbzDdXuAHs0R3VEZBFn/AxghHsKxrrCw3BsCGXuDliJvtljtSoqq5Civ5Ria/zwBkIJTrel69fazRLMDJm+zmjmRHS+Nu42UhT2BOO4fKoudFHbu2R3t2rP2WUFA9dgNpNeo6BjNCtvoMzb7rGNaHuhFAxYZ3DL6b9P/MVW+D5g8OS0Jk7Ax5toamGYNkJLh3k2Y9D/S9QZi80mgqmPKjQRAOKMvSnqe5Mu0URSkqShgSxg9KTR3SgmDB3+ui3QCEz+lMVshp14bshj8j1q/R+MqcmLdJBpt4db7UjqpjgFdvIxPBTohKjXp6TgftTHITRyXSHt5W5GP60+rM4aJHEQWgEJZM7tGIAcghC81thprnbEAb82GRCHDhFKB1Mn/sHGgbO1vKOTdGIqTmBJOtuz3b2A0I16aFwNH691b/wmJAAkIDVkpvtXO1k+X9/WhE1Gis2J6q6mZ7Gq4pkTNhn5tH2RmsRZce8twi5puXQUVlgy6fdB/euEctd2kgVFnBuky0ze9UBPjxMjy3bUVZABK//tPl1F7AAjeKwrA/6Lg8GMx7Yrw6XtqvesTpiTn64N5Yf3qcMfo59eZf5G9d00xZd09eO8pxnACE1p5juSRf9m5FpQL+9Y0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(52116005)(1800799015)(7416005)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UzRFVFRMQlVyc0RIQndwd0pHNlFQMlZyNE1oK00rdmhkcDVmSGplcjFFNmlR?=
 =?utf-8?B?MGRKWld3RlUzcC9lYVcrWlVYekpLOWc3b1ZoS0VvNE9YOGZrdVBhRFdoNUdF?=
 =?utf-8?B?UFVxV3hmS29GWW9tS29TM0U1a1RSbXBzTWh5Tm1uWTBVSmxIYy84b0xEWVJK?=
 =?utf-8?B?ZVVQaGRJblJkM05qWHJaNDNCNktRTTNleWExZmtrN2RsTi9ORThjL3lVOHFz?=
 =?utf-8?B?clcyd0RlMUQvQ00vQXAzdWxQWnl1NHBkcVBkT0N6aEFWelROakoyKzN1cUcz?=
 =?utf-8?B?bmFyTXpqRTJOVTRxMlgvSXdTei9qWFBEZHlGMWUrZ1RxWmV0U09nUjB3d29q?=
 =?utf-8?B?OXg2R2ZUdDJJTThOaXlsdGlIL3pjZWZuVEhoTzNYZ1ZjbEFzcmcvOVQ5MEti?=
 =?utf-8?B?WnA0SjBUWmJsUm9aK1pIaFVHRzRuK25uYmk0aFNZWGo1VmV4Nkl1OWxReWlm?=
 =?utf-8?B?YTJ3bVRqSlRSdmxiUWo3YWdlaFRSaGMvZjBYRXZCaEJJcGZ5aTVSN29OWnpQ?=
 =?utf-8?B?aGczaUJENFdJUHloYkhEVk5uNDEzVkxWQldPa2tSRUMrUVI0SENjV1ZDSDNl?=
 =?utf-8?B?NlBDM3dvbnp6UTRmeUxuRG5vL254SVFQTGVUQ0dkS2swejdZU3N0WTBqTU5O?=
 =?utf-8?B?Qld0ZDNrbndiRXVtcFd6TENxRVhkK3pTandPU3YwV1pCeU5kODFUTVFYM0I0?=
 =?utf-8?B?czRBR2hrd0djV2g2dXVaMWZqZ1lzOUlKSDE4NEttWUhCSDV2MEFRcWowb09r?=
 =?utf-8?B?SUVxTEpFbmx3R1NGWFNqOEJQV2ZLNDQyaWJKc0IrKzZKRVhrSUcwcGltUW1k?=
 =?utf-8?B?VzZra0JtQTJ1cVFwc1JsanRnQXZURDFPOFZGaXJYblBJZUVaRjZ0WHhtNHZF?=
 =?utf-8?B?dmdVNE12QWcySGdMdDRXaDYyTWNiZi9FWXE3d3R0RTZSblBBanRhd1NIclc5?=
 =?utf-8?B?cTJ5UHVFV2ttRDJWSEo3K0NTRWZsVkR3R1N1RzhRbjBlVnpMaGxON2VRSlNX?=
 =?utf-8?B?UjVFZklwSTJSdjVYMVhwVTFrSmlYcEQzSW4zeG5vU1hLWmpXMmcrVGwrM2Vi?=
 =?utf-8?B?d3BiWUU3UFhhTEN0cEdBcE5CM2I4c3Z5OFFuQ2tIakxleENYaTR2QlY1eGVD?=
 =?utf-8?B?VWN2UWJGajdJdm1PNUlvN254Mjc0aE5uRzd0VlF4MGFWUlRTQUlTZEhDTEtF?=
 =?utf-8?B?SWZkNngrU0ZDY0ZPZXVtL3luR1prMGdmTUdmd2VoV2tueWtPRi9BOXRxYnk3?=
 =?utf-8?B?elppeUJ5SEhCQStka0dpVHUvOXVmdTdkTmdhSE5OVEZTamdlSWVxZlVSNSta?=
 =?utf-8?B?QkZQN2JoMlVxaTRkQXVkNDJaWXBPSndBbklXdnlpM1pLazRxN2cyOHFLUGxo?=
 =?utf-8?B?UkVtUHlzQU43b0gzamdBQ0c4NVEyb1dnV1plWHlaUmhKd0Z2TkViQlJjQVhO?=
 =?utf-8?B?U0ZBOWRqa0JuZXI3S3FsVDAwZERUSE95S0JSdDFhdE92T25HU0d1VEtwNDl4?=
 =?utf-8?B?UXBocUc3MHpoT054SlRsUVBJV2t3WXB6bHArVkJ1TWVFditDZFk1bUpTV3l5?=
 =?utf-8?B?Y3dBY2p5Mi92cnBtelFWSWZHTzEwc1BuZ0dGeGxtYkpiOUVETXVoMXp0djRH?=
 =?utf-8?B?RE5oZTYzeCs0SXBrRGxYZUFDS0Q3QmZwcFlMRlpWbmJtUm5kbldlNW5sOWJH?=
 =?utf-8?B?WGlmYXlMdFBsSTlrYmZRcGNhRHdraFh2K1BidUN5RTY3WTdwNnZGVjE2ck1Z?=
 =?utf-8?B?NlNMQ3k3eVBEaXhxRUlzKzdJYWxZVTlZNW9iNGhlTFdsSXlpWFNzb0ZsbVNI?=
 =?utf-8?B?LzRETTZMZ0tyMS9sc2EwWFQ0VExEelBVSTBlLzFjNWVwak9nbXBrbWF1Lzlo?=
 =?utf-8?B?blFUb1FXMnYvak41RzZtbXQ1ejhPd04ybFdPVkliUUMvUGhscXlKcUJUWVpN?=
 =?utf-8?B?OHV4d3I2aWNEZC9FMjVaZFo0SHJaTVcrbXczYzBTWkt5UlpLc1U0UmloOEdE?=
 =?utf-8?B?QVU4L2FrSCsyR3Ntc0gxNzhXb1lDdTBlRDJ4T2NEY2VpT0NpTHRleUVoeDU3?=
 =?utf-8?B?cXVMZnR1ZGN6dXIxdmZkeklnZmxRZVpmTkhoZG5qVlN1Qkd4Vk1YQWxnSjd2?=
 =?utf-8?Q?TJ/c=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f7eb2d8-c2f6-448b-409d-08dc57de2652
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 15:11:21.9256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y+/I5ByjGd87w/WTmUKm4z0hFeygCPY9zdKvtgmTULfF9ilSx/6DUnDe2fzkjggeCSPgiF+Poyb231rik6/A5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6806

On Sat, Apr 06, 2024 at 09:31:31AM +0530, Manivannan Sadhasivam wrote:
> On Fri, Apr 05, 2024 at 10:31:16AM -0400, Frank Li wrote:
> > On Fri, Apr 05, 2024 at 11:54:26AM +0530, Manivannan Sadhasivam wrote:
> > > On Tue, Mar 19, 2024 at 12:07:15PM -0400, Frank Li wrote:
> > > 
> > > PCI: dwc: Add generic MSG TLP support for sending PME_Turn_Off during system suspend
> > > 
> > > > Reserve space at end of first IORESOURCE_MEM window as message TLP MMIO
> > > > window. This space's size is 'region_align'.
> > > > 
> > > > Set outbound ATU map memory write to send PCI message. So one MMIO write
> > > > can trigger a PCI message, such as PME_Turn_Off.
> > > > 
> > > > Add common dwc_pme_turn_off() function.
> > > > 
> > > > Call dwc_pme_turn_off() to send out PME_Turn_Off message in general
> > > > dw_pcie_suspend_noirq() if there are not platform callback pme_turn_off()
> > > > exist.
> > > > 
> > > 
> > > How about:
> > > 
> > > "Instead of relying on the vendor specific implementations to send the
> > > PME_Turn_Off message, let's introduce a generic way of sending the message using
> > > the MSG TLP.
> > > 
> > > This is achieved by reserving a region for MSG TLP of size 'pci->region_align',
> > > at the end of the first IORESOURCE_MEM window of the host bridge. And then
> > > sending the PME_Turn_Off message during system suspend with the help of iATU.
> > > 
> > > It should be noted that this generic implementation is optional for the glue
> > > drivers and can be overridden by a custom 'pme_turn_off' callback."
> > > 
> > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > ---
> > > >  drivers/pci/controller/dwc/pcie-designware-host.c | 94 ++++++++++++++++++++++-
> > > >  drivers/pci/controller/dwc/pcie-designware.h      |  3 +
> > > >  2 files changed, 93 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > index 267687ab33cbc..d5723fce7a894 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > @@ -393,6 +393,31 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
> > > >  	return 0;
> > > >  }
> > > >  
> > > > +static void dw_pcie_host_request_msg_tlp_res(struct dw_pcie_rp *pp)
> > > > +{
> > > > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > > > +	struct resource_entry *win;
> > > > +	struct resource *res;
> > > > +
> > > > +	win = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
> > > > +	if (win) {
> > > > +		res = devm_kzalloc(pci->dev, sizeof(*res), GFP_KERNEL);
> > > > +		if (!res)
> > > > +			return;
> > > > +
> > > > +		/* Reserve last region_align block as message TLP space */
> > > > +		res->start = win->res->end - pci->region_align + 1;
> > > > +		res->end = win->res->end;
> > > 
> > > Don't you need to adjust the host bridge window size and end address?
> > 
> > Needn't. request_resource will reserve it from bridge window. Like malloc,
> > if you malloc to get a region of memory, which will never get by malloc
> > again utill you call free.
> > 
> 
> Hmm, will that modify the window->res->end address and size?

No. This windows already reported to pci system before this function. It is
not good to modify window-res-end. It just add child resource like below.

windows is root resource, which will create may child when call
request_resource.
          bridge -> windows
		child1 -> msg
		child2 -> pci ep1
		child3 -> pci_ep2.
		...

Although you see whole bridge window, 'msg' already used and put under root
resource,  new pci devices will never use 'msg' resource. 

If change windows->res->end here, I worry about it may broken resource
tree.

> 
> > > 
> > > > +		res->name = "msg";
> > > > +		res->flags = win->res->flags | IORESOURCE_BUSY;
> > > > +
> > > 
> > > Shouldn't this resource be added back to the host bridge?
> > 
> > No, this resource will reserver for msg only for whole bridge life cycle.
> > Genenally alloc resource only happen at PCI devices probe. All pci space
> > will be fixed after system probe.
> > 
> 
> I don't think so. This resource still belongs to the host bridge, so we should
> add it back.

When add back?  It was reserved at bridge probe. When bridge remove, all
resource will released. 

> 
> - Mani
> 
> -- 
> மணிவண்ணன் சதாசிவம்

