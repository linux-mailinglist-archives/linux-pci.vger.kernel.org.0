Return-Path: <linux-pci+bounces-1018-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7F6813C0F
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 21:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7109428375B
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 20:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9E66ABBE;
	Thu, 14 Dec 2023 20:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CPT7ttTz"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2087.outbound.protection.outlook.com [40.107.105.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5959282E6
	for <linux-pci@vger.kernel.org>; Thu, 14 Dec 2023 20:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLwK6E7MAM9q3jX87fLDUDm7y39Fp3o8IoP+UR6Z9KfKk5AqBaga61TDbL2IyMXu6AtN1wjOxn6NvqewYPGEYRLCMqfUp2byBS02pfyt2T4vtlDloWLKEanNdL/t8lWWBhff8w+/VhNXbcOw7eUcpQRQogms4wfZOrKQvUhqOstym2Xn8DmSUzeoAY51lGVo2hpXqkelznvuggdNAxpE1/rfGeC3AARV9EGSse7tcWwBTvSwGjHPGZfmZ+ducEp0LzCATo7F8BYRKmFT0l3R4if/GndosF/qgAWpgDbWP2ArjoC+dXOOjrSXVnCCsS4d8oa7Aq3q2oixucg5xnwPlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMT8lKUs2DDlYs+pRemgyMUTgjz9tFIn/6g2rCN0rYU=;
 b=gvsOMXdhY9hbuBLkGiEVR+ak65LFcvDPw1M0GXcdF3um0ijEhfdLwiOgbT/dacYI1vKomL6Ft1eq45gI7lj/yjWZmCwvKdSH3wsJgC5k8WFdSCO9jJxxFG3UhCi388N08D6rCnCvGpaq83AWs13T9ukEthQVXPU+MichJXORw0OHSn5sf7EHN7cFXHiEtKWYhazZXyvVf5LEmhJ1tce4pKB/XpI4rDkLjJFk8zwmYCHTprSrcSsH/w5ZNPfpBkpp+JB9KV52tB2kntnFBE1q3Dr6EpdoavMSuXVW9+IhgtHEh9E4trfSchkEd2wHJ4RU5u8pUB/VEaYmpOeuwjKKcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMT8lKUs2DDlYs+pRemgyMUTgjz9tFIn/6g2rCN0rYU=;
 b=CPT7ttTz8Gc0E3iEkaeoHUQcSP63vXbC7rsn2qfeD1IFsPAC/XCEcg3/XNuA3Qz0W2lFHHRYxR5m1y3jivvywaTWhtPmqbNb2rVqocNe4zQc/TBA+hd4vHQztVu5/j4z2Y3zGMlD0OYK7u7Zqddy0VT6Lb1SSbt5+QFQC35uzkI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB8733.eurprd04.prod.outlook.com (2603:10a6:102:21d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 20:52:51 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 20:52:51 +0000
Date: Thu, 14 Dec 2023 15:52:43 -0500
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Vidya Sagar <vidyas@nvidia.com>,
	"helgaas@kernel.org" <helgaas@kernel.org>,
	"kishon@ti.com" <kishon@ti.com>,
	"lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
	"kw@linux.com" <kw@linux.com>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
	"lznuaa@gmail.com" <lznuaa@gmail.com>,
	"hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>,
	"jdmason@kudzu.us" <jdmason@kudzu.us>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>,
	"allenbh@gmail.com" <allenbh@gmail.com>,
	"linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] PCI: designware-ep: Allow pci_epc_set_bar()
 update inbound map address
Message-ID: <ZXtrG40SR81YAR6a@lizhi-Precision-Tower-5810>
References: <20220222162355.32369-1-Frank.Li@nxp.com>
 <20220222162355.32369-2-Frank.Li@nxp.com>
 <ZXsRp+Lzg3x/nhk3@x1-carbon>
 <ZXsc57whj/3e/+zq@lizhi-Precision-Tower-5810>
 <ZXtkMC1ZjsgHMRvT@x1-carbon>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXtkMC1ZjsgHMRvT@x1-carbon>
X-ClientProxiedBy: BY5PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::11) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB8733:EE_
X-MS-Office365-Filtering-Correlation-Id: aeb3e95c-7b04-4fb1-00b5-08dbfce6a33b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	b/lo/BPjx8hmmTX0jG3+kDu0YU46qsMwGIqIZAPlsGXb4BGtGyUu7o/n+eoK1kQBLqjimYgpkD/Dwz2I4/aGCrpgtWHDQRK/ylfYdUGHwpLaMufIiWd8EaC1U9lMBEAgNBqZbn2wde2C7TuQFPm4SjpKo35RQjbgCwlSkP3h3tAtrynq6B6ZdjbwKu5KMXoNh1NYW3yTI4EMFJpIobE8rvGhZuC85//1rfx+B2O/kEgCKVNW8lDVUrmTfRIBVY5EJ/9UqiQRcPhe96JeFj/I8fXIrXhzp58pF7GWDJQmZke+beDnK6nr6PUcYUZUsEhkfEYLbGGhvGN7xaP7BBzjCajSSoxFgUqNSh3lKM/tefm9MEB8doMr0iElf0TEnu6w4/Ut5pLnLnLsZIjLe978JzjsC5Qwnj4tt9ufjExpkSt1kbhxdS1S1XVeLbcxvVaa4g2gSjcsfGSQsG0arguFqdFxnPC+pwu9sOjiRY4aZ/zDJFGyfZ09n9qGNxpXsE/gRo8ttUeDGFytsMXvJwHlXWJxEcl/3T4rKR5x8efoH/VjhiL8M3TJ/iJrgdgeosQAZahbqmV/LJw6tK74pTg1OOb3K7gLnMyIIUzPJJFLZrk1Ar+7q/a+tkhCEjkZzF6F
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(136003)(396003)(366004)(39860400002)(376002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(33716001)(38350700005)(15650500001)(7416002)(38100700002)(2906002)(41300700001)(86362001)(83380400001)(478600001)(6666004)(9686003)(6512007)(6486002)(26005)(54906003)(66476007)(66556008)(316002)(6916009)(52116002)(5660300002)(6506007)(66946007)(8676002)(8936002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BwsYa7sCkhFq+ULSi+3C/hBOhi4o5jXzhRYYjAIFDXjmunLTyCMF8TGg0t/B?=
 =?us-ascii?Q?9myEGSUyC8EeAVTjNB96zcwd8K7L/Bh6JZ040VBHGk9YmBgzujJLg/npnaoS?=
 =?us-ascii?Q?xfjixR8ahc836rwXY/JzuU9qzX4QL0WyucqCcy8a3vIXrgrAJyWVeKbdK6H6?=
 =?us-ascii?Q?1SYWeUsaEJwxtdz9IxV/I8kHUG9/qjytoEAXVpNETWOP5nCYEUadodFOHvQj?=
 =?us-ascii?Q?A/kva4p9Mi4xTqjaJWHFOlpjz2Y4DHBNT6VBNnZnxaCR5OTkQhmFzXwprUzD?=
 =?us-ascii?Q?0bS8wB/8VdA1TGm8bLNzFptuZKTRk8zxFVit/J/FRkKJOuStQVSGaab6ks0A?=
 =?us-ascii?Q?qq6YM2x+xjPIC98tU2Y/B4mdXgeBHnX/bM0qlnxSCqloh11506uRZIe+1nUg?=
 =?us-ascii?Q?xlkUam2s5Eqla1w7KOuit6Y4hVOcvBU/6wLeAzHljwm/WdBQxIoP3NNzMX3G?=
 =?us-ascii?Q?+F7k6QpNEY1L7d3IVpTcqjH/f788CydapjgbIgJE5QyVkPQa7fNu1NhYi9An?=
 =?us-ascii?Q?Hp9M7sUhGN4TWYbG/qk2sybk1O3F8w6ArzWfK/cC8d7Peuhn5VFgEeSuwFsN?=
 =?us-ascii?Q?9UPdROsOkQ7qPHrIMjl/Y3a3WXGTgGhbg2xU2EisUrGtq9vpftKkXyoJwumW?=
 =?us-ascii?Q?8Lz/CB7Dt5OtdoSzuWumTkiYae06uREEkpx7O4fs7kBA3iKM1KSTCv9cpgz8?=
 =?us-ascii?Q?M5V0bKvUxxznvNVNzeR5lS+rIIy0x1pI4zhZ3Q3J+3S5hW4aW4phpnA0Uupq?=
 =?us-ascii?Q?jeGS5bojOu+JD+eHDTABYMrqGiSEOJeRG5prdWv/ju+RdpWPzYAKkMl4+7wk?=
 =?us-ascii?Q?q5Lt4jT+q+L0U8LjCWksV9ZgNjmPBhRLzxxxGwttecIt0uYg9u+/vq2CVYGF?=
 =?us-ascii?Q?TNJnuK9dtbDxupRyRcjcvXwpRJ7W72Yd1zYkHaEpZebXF5DxYs/6+QpFAOr1?=
 =?us-ascii?Q?x/kO+7GA2j1w2NpoCxKxzMw2ZDzY2gci/YwyOdhXGy6prfb7q47rWnmsTUet?=
 =?us-ascii?Q?XAtN+iqC+Eg02rmt7MAixRTbX+2AE7TG3o3OkrwExYjJ5kNxGNdcKkWCUkJC?=
 =?us-ascii?Q?m95NO1QMpGwoRjDakTLTCAD7WfwXI7W0Y+MNQfOITTQST6U35XgaUOkedNK1?=
 =?us-ascii?Q?MburXS7CKEBf+8JMgQawHyBlmInWxtW34HE4w5Oi/O6euAlybV+A9c3Eboyr?=
 =?us-ascii?Q?IwhPPZahRnSwh3/EflicAXlOCQhDRVKePdHx3AsPlKa6Iwaj/FMWOqx/YNMI?=
 =?us-ascii?Q?3qI+pblU8fG9ZBbaMD0ASXjjNcsY0bkUiCdLC+q/K6Mpd6p5nLworvESwv6R?=
 =?us-ascii?Q?WYxvEKMiBl1b23AOxDsm5TtYYKKlMtaQzx5y5U2GeMVTqRzMIOe2BN8B0val?=
 =?us-ascii?Q?YN5Dh0QyKpHq+mYUDDceMl2uCN/XBywqAUHVQYz+UvOQcahJevaYZSCQWV4g?=
 =?us-ascii?Q?V8lxuuogEpKK4ZdWYPR5Ol5Tcc4WKNcys9IWAOy0zSeTc8/2QMzdnbnfYn5R?=
 =?us-ascii?Q?dZUngIEW+1YhkotbG+fVo4x7VH6rtA/l8/yRqwdd7SwFW/wmbPQ82qPuIICY?=
 =?us-ascii?Q?SbsSM6v454NjJtZMwGo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeb3e95c-7b04-4fb1-00b5-08dbfce6a33b
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 20:52:51.6917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +cUQeXXZo2JYy3YcaLQVWRnW3BDKwdNSrWH80FfAjy9lHDDur6qA9cKeyZeuU1opAP2bE5GU4VQbB10PRIzw1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8733

On Thu, Dec 14, 2023 at 08:23:14PM +0000, Niklas Cassel wrote:
> On Thu, Dec 14, 2023 at 10:19:03AM -0500, Frank Li wrote:
> > On Thu, Dec 14, 2023 at 02:31:04PM +0000, Niklas Cassel wrote:
> > > Hello Frank,
> > > 
> > > On Tue, Feb 22, 2022 at 10:23:52AM -0600, Frank Li wrote:
> > > > ntb_mw_set_trans() will set memory map window after endpoint function
> > > > driver bind. The inbound map address need be updated dynamically when
> > > > using NTB by PCIe Root Port and PCIe Endpoint connection.
> > > > 
> > > > Checking if iatu already assigned to the BAR, if yes, using assigned iatu
> > > > number to update inbound address map and skip set BAR's register.
> > > > 
> > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > ---
> > > > 
> > > > Change from V1:
> > > >  - improve commit message
> > > > 
> > > >  drivers/pci/controller/dwc/pcie-designware-ep.c | 10 +++++++++-
> > > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > > index 998b698f40858..cad5d9ea7cc6c 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > > @@ -161,7 +161,11 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no,
> > > >  	u32 free_win;
> > > >  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > > >  
> > > > -	free_win = find_first_zero_bit(ep->ib_window_map, pci->num_ib_windows);
> > > 
> > > find_first_zero_bit() can return 0, representing bit 0,
> > > which is a perfectly valid return value.
> > > 
> > > > +	if (!ep->bar_to_atu[bar])
> > > 
> > > so this check is not correct.
> > > 
> > 
> > Please sent out your fixed patch. If want to me fix it, please tell me
> > reproduce steps.
> 
> Reproduce steps are simple:
> 1) Add debug messages to dw_pcie_ep_inbound_atu() to see the iATU index for
> each BAR.
> 2) Boot an EP platform with a core_init_notifier.
> 3) Boot the RC.
> 4) Reboot the RC, which will assert + deassert PERST, and will call
>    pci_epc_init_notify(), which will call .core_init (pci_epf_test_core_init())
>    which will set the BARs.
> 
> 
> In step 3) BAR0 will use iATU0.
> 
> In step 4) BAR0 will use iATU6 instead of iATU0.
> There is no reason for this, as it should really reuse the same
> iATU index as before, just like all the other BARs do.
> (This is because of find_first_zero_bit() misusage.)
> 
> 
> I could send out my patch, but from inspecting the code, it looks like:
> 
> > > > + if (ep->epf_bar[bar])
> > > > +         return 0;

I checked current code. 

dw_pcie_ep_inbound_atu()
{
 	if (!ep->bar_to_atu[bar])                                                                   
                free_win = find_first_zero_bit(ep->ib_window_map, pci->num_ib_windows);             
        else                                                                                        
                free_win = ep->bar_to_atu[bar]; 
}

I missed conside '0' is validate windows number. I think we should init
bar_to_atu to -1. 

	if (ep->bar_to_atu[bar] < 0)


Origial change want dw_pcie_ep_inbound_atu() can be call twice to update
bar map address. vntb use "bar3" as memory map windows, so have not trigger
this problem.

Frank

> 
> from dw_pcie_ep_set_bar(), also needs to be dropped, so that the iATU
> settings will be re-written for platforms with core_init_notifiers.
> 
> Right now, for a platform with a core_init_notifier, if you run
> pci_endpoint_test + reboot the RC (so that PERST is asserted + deasserted),
> and then run pci_endpoint_test again, then I'm quite sure that
> pci_endpoint_test will not pass the second time (because iATU settings
> were not rewritten after reset).
> 
> It would be nice if Mani or Vidya could confirm this.
> 
> 
> I guess that you added this statement for some reason, so I assume
> that we can't just drop this line without breaking something else.
> 
> I guess one option would be modify dw_pcie_ep_init_notify() to call
> dw_pcie_ep_clear_bar() on all non-NULL BARs stored in ep->epf_bar[],
> before calling pci_epc_init_notify(). That way the second .core_init
> (pci_epf_test_core_init()) call will use write the settings, because
> ep->epf_bar[] will be empty, so the "write the settings only the first
> time" approach will then also work for core_init_notifier platforms.
> 
> 
> Kind regards,
> Niklas

