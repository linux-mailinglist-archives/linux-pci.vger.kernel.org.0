Return-Path: <linux-pci+bounces-1169-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB6B8189A5
	for <lists+linux-pci@lfdr.de>; Tue, 19 Dec 2023 15:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BEEE1F21EF5
	for <lists+linux-pci@lfdr.de>; Tue, 19 Dec 2023 14:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807EC1A73C;
	Tue, 19 Dec 2023 14:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RC5QTpx4"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2085.outbound.protection.outlook.com [40.107.8.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9B61BDC0;
	Tue, 19 Dec 2023 14:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJE007hkmdDAbR4d78P6dYr9Cuw7TJVJXJ8pW75iw0AW/AIy93JjjqhdEWdrLWOUVW0+5/DasTy4c1jDEVxntZzhsawrsJoPF9xQ09lupdTQzvQR6IBegZwib5bTLNAWVsbfDcKdaazDRjOYGTUbKZibg7XUcoTjiQ7YG7vaZYXTwaOIlgqunICDgIwGAc/j4D9O0AzjmpGyeYfILiijpQobSySYFHCmLEJPkFSAVDFsEynNrKmPsbSxgZ+PuUdlQ3RxC3cteC6ts0hJq/lR5jC5nZzHMwcGRf879qsWiEaysxFPQyqSBpWi9v/Y0ZP2RIVX6zPEajDn0CnBKmP7wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y958+4Dk6lbd0HCHlkxedf4YoU211QYt2/1AxnYDus0=;
 b=PrAklpDHXrPtUaBnK9el77Pui14IaYt7fmvnUda0rjqh/zymePpzxxA8VaIK6+8oKTYNs7+1S50SvROm58eUiNyQjcel5fMciV4dpWU8svN5fYJwbAa+k13m9351nUzldgUOAkxLXArXZRMQrJb8c7GPvotkT4OTxZWWTaOIJPomo2kTin+4bxAN4jN9cz2qjg/A3dT17SfYu7pbBE66d3as/qEUOwVA+eQNpeQuhfFARSbhV3nAmBB0LyX7Iddcrft5/WWb/b8wyGlx+LBiyEbZhUYORXn/E8YJTWffaZVEtF3Ck9LviJz5GJV53MX3NN4804cFOZbaLasfStM+Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y958+4Dk6lbd0HCHlkxedf4YoU211QYt2/1AxnYDus0=;
 b=RC5QTpx4f9RpcPDyyYip2HBUVBWSpce4VasXnp3+IEnx9ristsCSmGNJfOYsCgEHd7k2L6cttBDnsW8hfpQCO0i69mJXAJdhGT9WeehWw5uguzeg22G8gr2tYAyWwJh+DUvx9L4iuQETjBIoepr+baT99OPWmOMPzHS/23v2zAc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DU2PR04MB9083.eurprd04.prod.outlook.com (2603:10a6:10:2f2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 14:20:29 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 14:20:28 +0000
Date: Tue, 19 Dec 2023 09:20:21 -0500
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: "imx@lists.linux.dev" <imx@lists.linux.dev>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jon Mason <jdmason@kudzu.us>,
	"open list:PCI DRIVER FOR SYNOPSYS DESIGNWARE" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] PCI: dwc: Fix BAR0 wrong map to iATU6 after root
 complex reinit endpoint
Message-ID: <ZYGmpaf18pJgM/qj@lizhi-Precision-Tower-5810>
References: <20231219044844.1195294-1-Frank.Li@nxp.com>
 <ZYFrUWM7JXdv7rtb@x1-carbon>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYFrUWM7JXdv7rtb@x1-carbon>
X-ClientProxiedBy: BY3PR10CA0006.namprd10.prod.outlook.com
 (2603:10b6:a03:255::11) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DU2PR04MB9083:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ade4539-370b-46b6-3514-08dc009da6b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cAUZKOsb+i2OaSXNuMhZqFMjqmQ+nquH2Ftj2n4OjNBrxqtHXqBUVeBic92Yruk3MqgzJ0EDjIGcWOwTs38jBKiQWNMMoIaFpXOAsNPsHYvWMAya4gqB5rTlIcLdt5VEwHmBIOFVBsvZqThDZh6P4rxo0cnSi6Nq8ajsx/cBnXHAWAJSWO00X2IshE2r7ruwBNVrLLaIP0aKa/ETqq7L2YnVJxJ229atw4nAzrk007iNjrd2j9jym5Cx8PPmnHOXx3IIxzggebhsW4FmyORPeW8etqT4caq1Mk8XPCOsXEQ/56GXd+FpCxM1T+Gb1BDqRc0MVwH1t7uDrxt9PyK0bfq5j7Pcnkb4tJ7iF1XQ9zlBwa6QSjE4JJchEQfrCT7aB1G/f9DFM2m4KtJ3mSnNJL1ob7MMc42BSyl6/jJCB5P2ys4tAOeutYYE8OKWAkVfuQwGFqwT5K4uzhSUxlHVWzhSdnwMdFfPtchry+PySErldQhdh513A3utwJ/bIABQ+FiC21VzqeW/21MqPFq+NV9Sir/YSQ56zLqAfieBy36mWKJe2RjilDCIS7peQ9fk/UF4u4VaI+Pqod42qdrvi5lKM7f0DxpLb0VtiTSh3xg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(346002)(136003)(376002)(396003)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(6512007)(2906002)(8936002)(8676002)(4326008)(9686003)(6666004)(52116002)(6506007)(316002)(83380400001)(7416002)(66476007)(5660300002)(6916009)(66556008)(66946007)(54906003)(41300700001)(33716001)(38100700002)(966005)(478600001)(6486002)(26005)(86362001)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZalhVp76npHGe946whZ7FDGjlVEuhJm6VnjV+yDVFLQjHhsTBRDK+gC2E9OE?=
 =?us-ascii?Q?VIhSLy71Ypmo2/LnLrWDHRDV0xuE0wBu6mwEJAVcspyvdMhxNvza7TQvafzU?=
 =?us-ascii?Q?SHBRkI9EbR7oYOl2QzHziRtXgz/yXfPwzle3CThZssUnYTgfo7Hy2AddhBst?=
 =?us-ascii?Q?RPK84OzUl4vULLAdfJSYixsPm3hUhMb7VweXF18P6WE8hrxdFmHXC8nkvsiA?=
 =?us-ascii?Q?CWnRR3nbQDi6wYSMI11wvk8CjIB3VvnIa3Atl0QmEf47slpSZukmdFVi3PFm?=
 =?us-ascii?Q?hUCOdJsgQOYSqzO0eqH0hjdE1QpGeimxRXeid/fe9AMxNYQXc7Q7ViJj7UwR?=
 =?us-ascii?Q?GcMdfMUIehe2F3iZiz1aElZL43p/Yk7eYUYj6JsiLjTjQVUZCn8mTyy2KUFu?=
 =?us-ascii?Q?T3sIGhRXKGZp+LvNE72+VuvhTgLPcq7OfpgaU2HsTVxEV9YHgStnv/AmyYag?=
 =?us-ascii?Q?rGrnvVesdaxHyw2xhejbmtUExRm1jCkKygwTE4wd/9hJdFmpoLf3r/a3jxSs?=
 =?us-ascii?Q?NkDKv+HKWdPLZSunYfqwuqayXljgaq4Mz4FGe+wupijo33uhw17artGIyoJS?=
 =?us-ascii?Q?/SzSDYjbOvBljH3Ngu+xA2+Eh1eWN37VBlNE2yiXUXWeQsKpggAUpvCeGnum?=
 =?us-ascii?Q?DsFfVBangs+sbChjVVuPy3TxYMQe9AFcxAs82x8Zr3y+xvMaGK7J4JXA5NPY?=
 =?us-ascii?Q?f6gwof7Lrd86Tt54oew0sz7BNr4G7uQO3GGETNemKun+gY8W3zDWx4QzfKfC?=
 =?us-ascii?Q?yxs+c8zgfQRz5X0se4VszEFqtsjEs9Aj/A9UJXJsaWFtRLLAkjmBVFE72EeO?=
 =?us-ascii?Q?ducnhFLQfdiz1sDgBMvdrIqxInCmeYH9yqkhqTm175XPe+KuNbjJ0mA0XZ3J?=
 =?us-ascii?Q?VipufVqLysI1wuz2+R6T1wHscecrqnK9rbswM53mT115y6O81rMnVdYelaPg?=
 =?us-ascii?Q?eeeuFwPLPnGSaG8BcJur1KLmst5IGtT7gj3QAaqeqJu80QdeGPrC5Nroy3/S?=
 =?us-ascii?Q?UJ+PmUTwEVib47+LxfANVTa9jW8BhdBfjY1CCT1uOBQSJeu5PQAcOZGUP8qv?=
 =?us-ascii?Q?XIScWoZ2pZkSo1N7fTxUcL7RnNTcxlm4v20cN2gsUrIGulZHOH8K6wUypEwC?=
 =?us-ascii?Q?RzMEAhPi+1ItV3pJ0NJhwhPSakM0x+5tS6Dfc+4dJ1Aejr3ewQLKChduy9Ac?=
 =?us-ascii?Q?ptkyKGG+7dI5GIwsnGHyYL3u/htQJNNB/x5mrxvD8ClH3REGMiotPnzeDlK6?=
 =?us-ascii?Q?a1NGWwQEGeyTUluM9LZaxMoZ+RV6e/tDb29JYjuVJEzs5k6s7W65cTo/Wt8q?=
 =?us-ascii?Q?irGG232ofGinRCOIXOsrXJPCUXy7rCcDoVagb8XkRmSoQVPgYqtduAbFnmsa?=
 =?us-ascii?Q?TPVsAP65mCRJzZEM6qDNjeFJwbSrOGC0LQ28ug6/anD4s6LekKx++ZtBS8nl?=
 =?us-ascii?Q?l8rQa3RZkkm/mc3CWIT2rKZqdybjyR2PVnVs1ven78f91A5vv4CAx8+nVPq2?=
 =?us-ascii?Q?FfcWb8tFWm5Y0HD8axf3I3V71MY0JdUFHVuIWH1dPp6V1YtMzDUeBaeTPWnV?=
 =?us-ascii?Q?LHPVaINfmlw4adAZUDc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ade4539-370b-46b6-3514-08dc009da6b7
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 14:20:28.8278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SpR2hc7AsXDa8nFhmhbIBYeI9bRuMS8OTlLBkYpM/k9uNbtMe/nY/sXmc32kHuin8Z7W/hfpKMExieN4fH83AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9083

On Tue, Dec 19, 2023 at 10:07:14AM +0000, Niklas Cassel wrote:
> On Mon, Dec 18, 2023 at 11:48:43PM -0500, Frank Li wrote:
> > dw_pcie_ep_inbound_atu()
> > {
> > 	...
> > 	if (!ep->bar_to_atu[bar])
> > 		free_win = find_first_zero_bit(ep->ib_window_map, pci->num_ib_windows);
> > 	else
> > 		free_win = ep->bar_to_atu[bar];
> > 	...
> > }
> > 
> > The atu index 0 is valid case for atu number. The find_first_zero_bit()
> > will return 6 when second time call into this function if atu is 0. Suppose
> > it should use branch 'free_win = ep->bar_to_atu[bar]'.
> > 
> > Change 'bar_to_atu' to s8. Initialize bar_to_atu as -1 to indicate it have
> > not allocate atu to the bar.
> > 
> > Reported-by: Niklas Cassel <Niklas.Cassel@wdc.com>
> > Close: https://lore.kernel.org/linux-pci/ZXt2A+Fusfz3luQV@x1-carbon/T/#u
> > Fixes: 4284c88fff0e ("PCI: designware-ep: Allow pci_epc_set_bar() update inbound map address")
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > 
> > Notes:
> >     @Niklas:
> >     	I have not test your case. I should be equal to previous's fix in
> >     mail list.
> 
> Hello Frank,
> 
> Thank you for sending a proper fix for this!
> 
> Personally, I slightly prefer your fix that saves the iatu index + 1, and
> keeps 0 to mean unused. That way, you don't need the memset, and you don't
> need to change the type to signed, but either way is fine by me, so:

index + 1 don't match hardware iATU index. It will be confused because
other parts is 0 based.

So I choose "-1" as free iATU. 

Frank

> 
> Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>
> 
> > 
> >  drivers/pci/controller/dwc/pcie-designware-ep.c | 11 ++++++++---
> >  drivers/pci/controller/dwc/pcie-designware.h    |  2 +-
> >  2 files changed, 9 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > index f6207989fc6ad..0ff5cd64f49b0 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > @@ -174,7 +174,7 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
> >  	u32 free_win;
> >  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> >  
> > -	if (!ep->bar_to_atu[bar])
> > +	if (ep->bar_to_atu[bar] < 0)
> >  		free_win = find_first_zero_bit(ep->ib_window_map, pci->num_ib_windows);
> >  	else
> >  		free_win = ep->bar_to_atu[bar];
> > @@ -228,14 +228,17 @@ static void dw_pcie_ep_clear_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> >  	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
> >  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> >  	enum pci_barno bar = epf_bar->barno;
> > -	u32 atu_index = ep->bar_to_atu[bar];
> > +	s8 atu_index = ep->bar_to_atu[bar];
> > +
> > +	if (atu_index < 0)
> > +		return;
> >  
> >  	__dw_pcie_ep_reset_bar(pci, func_no, bar, epf_bar->flags);
> >  
> >  	dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_IB, atu_index);
> >  	clear_bit(atu_index, ep->ib_window_map);
> >  	ep->epf_bar[bar] = NULL;
> > -	ep->bar_to_atu[bar] = 0;
> > +	ep->bar_to_atu[bar] = -1;
> >  }
> >  
> >  static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> > @@ -767,6 +770,8 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> >  		return -ENOMEM;
> >  	ep->outbound_addr = addr;
> >  
> > +	memset(ep->bar_to_atu, -1, sizeof(ep->bar_to_atu));
> > +
> >  	epc = devm_pci_epc_create(dev, &epc_ops);
> >  	if (IS_ERR(epc)) {
> >  		dev_err(dev, "Failed to create epc device\n");
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > index 55ff76e3d3846..5879907c5cf25 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -362,7 +362,7 @@ struct dw_pcie_ep {
> >  	phys_addr_t		phys_base;
> >  	size_t			addr_size;
> >  	size_t			page_size;
> > -	u8			bar_to_atu[PCI_STD_NUM_BARS];
> > +	s8			bar_to_atu[PCI_STD_NUM_BARS];
> >  	phys_addr_t		*outbound_addr;
> >  	unsigned long		*ib_window_map;
> >  	unsigned long		*ob_window_map;
> > -- 
> > 2.34.1
> > 

