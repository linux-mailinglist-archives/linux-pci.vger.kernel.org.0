Return-Path: <linux-pci+bounces-1228-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E1281A717
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 19:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93E82B231FF
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 18:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD8634566;
	Wed, 20 Dec 2023 18:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rsHdTtmW"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2076.outbound.protection.outlook.com [40.107.22.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1BB482D7;
	Wed, 20 Dec 2023 18:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n5+AyLt87xHM81PiuwcjdQVRgTFUx/1LeNE3GCgdwiEfBIqVoxELb5rnXK9cIhGADXLNsgJuQd9PMRs0DrG40xmXmRJjEza62o7HHfsZ2tk9XXh6sQl2I7X/r4cOBTKDgbbPdqpcPz1v4cuvq17rK22Ip5tbxytXdvc6IWmx3prGQMhFbTjUH/zLFV80QVHBz8AmYUQOYIe3k6RLDGQ4z2JhZG0GJ4fVzxPaLnUEAGefw5P1Kw+6FoxL+ZPuVYxzi+AyNLKBR5dftlM68eAFRHSEKWDkx2uB629yJUrvDOhBCvV1tv/gJ6Ys5swMyvqGhJlhoNSpub8yXtgdA+VOBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUXQarsC9LUK25PD8eInsWlK05YZSSYPmrjs6ceFe5g=;
 b=EcvKgXJ8drxMFkubLdO3jqnFVgg3buseYmDiEUCl8NjlxNeqS9IKUIW0+9w2OlT0H5QvUavPi6N4QJkXyrDS7sk/DeN0DmZRYnkCm4FfjQB37U9JN2FsmTOuuQT80fOsaQCBAHru3NfjZfQr1Zb5f9bRH/PMgMG+M4nXQ1d8CTuli6QcuWaDESf6juyaIhmfSQc7jDStBl5VkLOYnumvW20uR1+qFhv5yWwa9k1nYTK6ayBK2mr2mjqgqgV57yMsYS6VTr3BQsnInlApwHLSwKPPgJDrY7aco9TVl9UoEAyp15eb4hde9n3geVl+zeRwKQq1r9yxkp9FkJVj/sDTvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUXQarsC9LUK25PD8eInsWlK05YZSSYPmrjs6ceFe5g=;
 b=rsHdTtmWnLTcu35J0qtSqEbQiZL6xXtFiWdygVJZnS2fz1dD5c1nfiyNAkDvqj8G3G3SVyLmQu67y/BLmc7Geo7AeZ/VgOXBRnZrIrwjbQ1bvHYv7AejB8FGfjUBzWNaFO78QT/JG6rz6zXL0KfIA0PKch4dlfx2S269uwYEnKA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB4834.eurprd04.prod.outlook.com (2603:10a6:208:c8::18)
 by AS8PR04MB8611.eurprd04.prod.outlook.com (2603:10a6:20b:426::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 18:58:12 +0000
Received: from AM0PR04MB4834.eurprd04.prod.outlook.com
 ([fe80::cca:115e:9cc0:fdcd]) by AM0PR04MB4834.eurprd04.prod.outlook.com
 ([fe80::cca:115e:9cc0:fdcd%6]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 18:58:12 +0000
Date: Wed, 20 Dec 2023 13:55:34 -0500
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: allenbh@gmail.com, bhelgaas@google.com, dave.jiang@intel.com,
	imx@lists.linux.dev, jdmason@kudzu.us, kishon@kernel.org,
	kw@linux.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, lpieralisi@kernel.org,
	ntb@lists.linux.dev
Subject: Re: [PATCH v2 1/1] PCI: endpoint: pci-epf-vntb: Fix transfer fail
 when BAR1 is fixed size
Message-ID: <ZYM4phZTHJD7+MEw@lizhi-Precision-Tower-5810>
References: <20231219142403.1223873-1-Frank.Li@nxp.com>
 <20231220142736.GE3544@thinkpad>
 <ZYMVMo3TVPMiEN/L@lizhi-Precision-Tower-5810>
 <20231220174113.GO3544@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231220174113.GO3544@thinkpad>
X-ClientProxiedBy: BYAPR07CA0004.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::17) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB4834:EE_|AS8PR04MB8611:EE_
X-MS-Office365-Filtering-Correlation-Id: a2cb637e-3b96-4d44-a81a-08dc018d4e0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	o6Vh0Kk7kwGYkU2/bLKwmwyB1bYMod+0rRs2Fg6vY2ilBvBnzUFtZ+wxTSQnHpPs8bj0eDCdnZXk9JtiVq191Koz7dJLFcqtex0LXCGxxGiu7aOxnAOm6RsKpdapBAMvw3eKmuNIKxSZotXj9PUXcvrO+3sEqz+sBbLbZBfiRCz+/Non1sXqSHiJr1bHgQ49SDqU0WBN1Uw5GA8xNAAm24O2b4baOorVCHMQNZsyg1/LBuU04IHMolGpxkXFr9AdLnaVs2O/EwYg9o2nEmiivkN0VtiBsO9CVl1x1QObB5dxqVcgKgk1T0GzrC1TxvOceAW6dkCU+JfyILfZP2AqBD6PCgN6ffQ3z3400Sdh++76MMoTTC1+Dr+sqPaUx73Pslg8YwlrUCq4t1I2dTiqeccYTt9snP+XpvafZH0oTwDJ62M7pe9VLxaiGKo1HCXqGrS2zjX2dzjhHV6gk6Xfy774uRTo0ICM7KGsdJC397C1zvnZVc3NRp8W1QIUDmxwZSFpUyybPjyyst/RDgc7GathUetB1OIPWi1/4AcHYFckA3acin6NkTG51oSzIsCEJkZ+yZbQJOhV5391HUGfKN2GAvGoH5yrBTbdxmoJ4duvBsuoSEUOfJ90Bcu6MsvW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4834.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(376002)(396003)(346002)(366004)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(33716001)(41300700001)(9686003)(6512007)(86362001)(6506007)(6666004)(26005)(52116002)(478600001)(38350700005)(7416002)(2906002)(5660300002)(8936002)(4326008)(8676002)(6486002)(966005)(83380400001)(6916009)(316002)(66556008)(66946007)(66476007)(38100700002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cFFOcWFXWklDRW5yNnJ5QnIxaGNIYlF1dnVPZWFsU0l6ZjN5U040WHZjZTgw?=
 =?utf-8?B?aDFqL2M4dTNhNWMzTFBoTnNTTXRlSjRzUjdrWUxhQU1NWG1WTHlvYlNMUUN4?=
 =?utf-8?B?NjgxSXdKd2hXSkNWY3VmSkRrdWNaSTFwcVdNVU9weWNkcnVYYVhENWdrK3V4?=
 =?utf-8?B?Z0xuNlBNRVpBMEFtTHZYWWdzdG5QTEFRczV0ZHoyZEZsVmRGVVRCaTRtd01C?=
 =?utf-8?B?VUJobVdldjc5c0ZNcEFLZXpWZ3NHSWwxRk4xd2UwTERzTEk0WHNsaFVzN3Z5?=
 =?utf-8?B?MWUxQWxDemkrbDlmVWNmNlo5RnYvM0JTdXhwajVhK21MVG9kbUNCT0xiMEJC?=
 =?utf-8?B?QUV1NHBEbkExcnN4c1VPeDhCUXJaUEo0cGRJTVdvVzFVaVlURVNFbUxhQm1l?=
 =?utf-8?B?V1QxQndMMWdZRlY1bXdMWmFVa1RyQzRYVzlPRnZnN3BLNUtmRUJCMnZzVTdl?=
 =?utf-8?B?bjRUdjBTdjB2cHFKeUFaVTM3SFpuOW5EeVQ1SS96K1U4bXVIaE1Qc2p1NHp0?=
 =?utf-8?B?Ui9BaTBOVE9wWGg0S1BGdXMrSE9STmtndGhyanNoUDNVdXlZdVNoT054di9r?=
 =?utf-8?B?cWduaUVPZVBlQzJscmNvQmErNGJxRWhtWDFjT0ZPZnJPUWZ2L2Uzcmd6UmFZ?=
 =?utf-8?B?c1RBNWdJc2tjTDUrK2g1NlJGZ3ZsMDIySTVYSDNCWDdSRUNzTmhiQTFtdVJC?=
 =?utf-8?B?WTc4ZUhVY3lHR3NpOUtydjlIZE5laDJUVzJsVThqbGRjTlVZbnJzZDlOOFN0?=
 =?utf-8?B?OENobUw4R2U0R01FSHVaVExHWE5PcFh0UDFuUy8vaWJkaTR6Q1hOaDViVjQv?=
 =?utf-8?B?bFNGTzlCNUUzdFhKOVZJUzcxSDltRW9KckJ2bDZXSTlnL2krYkRybVdKQUsz?=
 =?utf-8?B?Ujhvc3VzL1UwVnNUQlFIdGRybDdZeHNSTjJITkgwdE5WT0lackI5cFRBRzJY?=
 =?utf-8?B?OG1lcUtiTExFN2EwaVFxS2NYUG4rUlozNyt2VHNFSFZZRFdaYVRuNEFQM3I0?=
 =?utf-8?B?Z2NlU3NuTFJiTjFQSnhOSGFlV3U5eGx1TnJ4aUk0R2FlVVVpc2hQdlRxT2Fn?=
 =?utf-8?B?YkRMZHZYTEwxdlNMbmhaRmdnNEhBZUZmeUpJZEpndzdQcTBvOTIwR0pCQlY2?=
 =?utf-8?B?T2tjRXFZNGk0TEpyNGgwNFZPTXNBQXhRSHFzSFhTZEpWNzVrb1pvSGxKZ3h0?=
 =?utf-8?B?TG9pZlNRWTRod25JOHhKelVoQWVtSHE2Z1ZrMGxrTHFrVlk3ZVFmRmRUZkRp?=
 =?utf-8?B?M2lyUkdrZ0lBN0dVY0hWSWNWQUI5STVZRTgwS0drT1liSFZXM3ZKblFvSzhl?=
 =?utf-8?B?R1BvdFRwaStsYVJSMkNIQVdLY1lZb0F4RWcrMDVObmFOeE9xVHliOWtyWVp1?=
 =?utf-8?B?R0c0dlZNVEdwVEVsNC9NM1RYbXRLbW5NSXMwbFNyU1hod1RMM0YvYmNLMnd4?=
 =?utf-8?B?UDc5ZHRnOHBWbnVFVUIzN0w2cFZBUTFseVhaNUx4MXBCSlRpdGE1ZXhodUc5?=
 =?utf-8?B?ZGdGcTJaWWNzTXcvam4yN1BmTk1EUzF6cmduT3ZlUlRwSjRvRTlJaEFtQ1Av?=
 =?utf-8?B?WERLWXNwRUo4MHh0VzUwSWVodDV1Sy9vL0lyMkFqajZnc1JVd3IwbGcwL2cy?=
 =?utf-8?B?eE11Q1Y2SG8vek04Z0tGc2Zxa0t5UFVMQS94MXorMHMrNnFHZTNFVnU4bE16?=
 =?utf-8?B?WVlpUFJzaWpzY0pzMm5uaVdNb2x1bmlFRG5XOVpiMW5FSlZDZi9nc2xiY1RI?=
 =?utf-8?B?WFd1Vi9BV1NBa1BxUTZMYmkrQmxoZzRWc3UzY2xjU0VHL3V0SkxzWnFGWlhX?=
 =?utf-8?B?L1VoMnd4N1hCMjZHWDA0aHY4RTZPS05xQlMxSmVGcFAxNVlSNVlyV0dNNnZD?=
 =?utf-8?B?RXB1bWRNSlE0WHlrRmNWMGZQYzR4MkMzVFJ5NkFCZWhNcDlRdDgreFlmZGd0?=
 =?utf-8?B?dXFJcFVJcFRmRUR0bzBwMzFtTW1XR0tFYmVVNGZydFVsaUlsNS9CK2NNamtK?=
 =?utf-8?B?SXROdWZXemI0dDhHaDdRL1dib3UzRUIvWEpLZkRiNFVKWHJQTjdKSkhLVmVS?=
 =?utf-8?B?dG4rMmJ2andMY2RVMmlBSkJzbk5qQ0lNbElJVncvTk9paTd3SG04VEVhZHVX?=
 =?utf-8?Q?WPAY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2cb637e-3b96-4d44-a81a-08dc018d4e0d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 18:58:12.6912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jm/4SNAd0M207UkYU0N+f9lvUIDlb/mlxP9gAWwK0/Jkdc6NSYiCBWVRLG8JWBTJ8YtUA599LT201kUPIxVoFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8611

On Wed, Dec 20, 2023 at 11:11:13PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Dec 20, 2023 at 11:24:18AM -0500, Frank Li wrote:
> > On Wed, Dec 20, 2023 at 07:57:36PM +0530, Manivannan Sadhasivam wrote:
> > > On Tue, Dec 19, 2023 at 09:24:03AM -0500, Frank Li wrote:
> > > > ntb_netdev transfer is failing when epc controller's BAR1 is fix size, such
> > > > as 64K. Certain controller(like dwc) require memory address must be align
> > > > with the fixed bar size.
> > > > 
> > > > For example:
> > > > 	If BAR1's fix size is 64K, and other size programmable BAR's
> > > > alignment is 4K.
> > > > 	vntb call pci_epf_alloc_space() get 4K aligned address, like
> > > > 0x104E31000. But root complex actually write to address 0x104E30000 when
> > > > write BAR1.
> > > > 
> > > > Adds bar_fixed_size check and sets correct alignment for fixed-size BAR.
> > > > 
> > > 
> > > Change looks fine by me, but I have a hard time understanding this commit
> > > message.
> > > 
> > > The change just checks the size of the doorbell BAR if a fixed size BAR is used
> > > by the controller and uses the fixed size. In the commit message you are talking
> > > about alignment and root complex writing to the BAR which are just confusing.
> > > 
> > > Please reword this commit message to make it understandable.
> > 
> > Maybe I talk about too much about it. Actually, supposed it should  work if
> > use fixed-size bar(64K), which actually only mapped 4k, if RC only use 4k
> > also.
> > 
> > "copy from dwc spec"
> > 
> > But dwc iATU IATU_LWR_TARGET_ADDR_OFF_INBOUND_0
> > 11-0
> > LWR_TARGET_HW
> > Forms the LSB's of the Lower Target part of the new address of the translated region.
> > Forms the LSB's of the Lower Target part of the new address of the translated region. The start address must be aligned to a CX_ATU_MIN_REGION_SIZE kB boundary (in address match mode); and to the Bar size boundary (in BAR match mode) so that these bits are always '0'. If the BAR is smaller than the iATU region size, then the iATU target address must align to the iATU region size; otherwise it must align to the BAR size.
> > A write to this location is ignored by the PCIe controller.
> > - Field size depends on log2(CX_ATU_MIN_REGION_SIZE) in address match mode.
> > - Field size depends on log2(BAR_MASK+1) in BAR match mode.
> > ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > 
> > For fixed size bar, BAR_MASK is fixed value. If pass down a 4k aligned
> > address to iATU for 64K fixed sized bar, some address bits will be
> > truncated. 
> > 
> 
> Okay, now I understood the issue, thanks.
> 
> But this issue can happen for other BARs also, right. Since you encountered the
> issue with DB BAR, it doesn't mean that the issue won't happen with other BARs.
> So you need to have this check in place for all the used BARs.

Config BAR already consider it. Memory windows bar is little complex. I
need do some tests, let me finish 

https://lore.kernel.org/imx/20231211215842.134823-1-Frank.Li@nxp.com/T/#t

Then I will can add more SOC, which all bars is fixed size.

Frank

> 
> > Hidden some hardware detail, do you think if it is enough?
> > 
> > "ntb_netdev transfer is failing when epc controller's BAR1 is fix size.
> > Adds bar_fixed_size check. If require memory bigger than BAR1's fixed size,
> > return -ENOMEM. If smaller than BAR1's fixed size, use BAR1's fixed size."
> > 
> 
> How about,
> 
> "PCI: endpoint: pci-epf-vntb: Fix transfer failure for fixed size BARs
> 
> For the inbound MEM/IO TLPs, iATU on the endpoint expects the target address to
> be aligned to the size of the BAR. For configurable BARs, there is no issue
> because both host and endpoint will know the exact size of the BAR region. But
> for fixed size BARs available in some controllers, if the BAR size advertised by
> the endpoint is not same as of the actual BAR size used in the controller, then
> the MEM/IO TLPs generated by the host will not be translated properly by the
> endpoint iATU.
> 
> So if the fixed size BARs are available in endpoint controllers, always use the
> actual BAR size."
> 
> Also, add the Fixes tag and CC stable list since this is a bug.
> 
> - Mani
> 
> > Frank
> > 
> > > 
> > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > ---
> > > > 
> > > > Notes:
> > > >     Change from v1 to v2
> > > >     - Remove unnessary set align when fix_bar_size.
> > > > 
> > > >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 8 ++++++++
> > > >  1 file changed, 8 insertions(+)
> > > > 
> > > > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > > index 3f60128560ed0..ec3922f404efe 100644
> > > > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > > @@ -550,6 +550,14 @@ static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
> > > >  
> > > >  	barno = ntb->epf_ntb_bar[BAR_DB];
> > > >  
> > > > +	if (epc_features->bar_fixed_size[barno]) {
> > > > +		if (size > epc_features->bar_fixed_size[barno]) {
> > > > +			dev_err(dev, "Fixed BAR%d is too small for doorbell\n", barno);
> > > > +			return -EINVAL;
> > > 
> > > -ENOMEM?
> > > 
> > > - Mani
> > > 
> > > > +		}
> > > > +		size = epc_features->bar_fixed_size[barno];
> > > > +	}
> > > > +
> > > >  	mw_addr = pci_epf_alloc_space(ntb->epf, size, barno, align, 0);
> > > >  	if (!mw_addr) {
> > > >  		dev_err(dev, "Failed to allocate OB address\n");
> > > > -- 
> > > > 2.34.1
> > > > 
> > > 
> > > -- 
> > > மணிவண்ணன் சதாசிவம்
> 
> -- 
> மணிவண்ணன் சதாசிவம்

