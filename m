Return-Path: <linux-pci+bounces-1019-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE6E813C9F
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 22:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B9061F2271F
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 21:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012F66ABBF;
	Thu, 14 Dec 2023 21:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eZWcd9Iz"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2074.outbound.protection.outlook.com [40.107.249.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B046DD1A
	for <linux-pci@vger.kernel.org>; Thu, 14 Dec 2023 21:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z+cjEr+S6xV5IDLPmIZYttaO3DkqtA6jNYDn3TCPLYOcm50AAAn12xYI/5ktSc2W6zejCQo9mB6e4YxZSvGb5aDdxS44LaPtsZA4pZR1tiN3ddJzfVJ6jErgzGHWpgkRBuroMQOPl19Rw4XspePZ4DMndq/HSvnaRDNEUM/uW95E/6VLXOJ6tDucW0HZYCjapYetgC8cLniIya6CRQF0WAgUYm9VUNBigI8v0stH69Er7XocgxcaPnPI+JJOvSPLh0hEz1Hr1VFOUqNRjn/iDWvsZ2/Ovxo7mEM4JrK9FtMkPQEP8alUAyTnZ669l4DK6LT91A9Hx03c7NCRhExt2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1VzAM2SUTgqO79GwydXX5qevzxZm1Pln82uf6l/hFl4=;
 b=MX3wY666WWC7DydDTdcviQfSdSM3O9U+a/BAOROthCvv6te4PssWr3dHP0TMpts+xkTENyFygIfrxy2iEAXv94kVPmvN3TczjOU6yKhvebQeXER15F/QcoKxK/kTB/KpwhQ4EB6D745XPt1mouy6l2aJhRX57EYtyiqWh+2rkh4jdRB7iAInfOS6Yg4Wbo77gELR5GFkeoBYlvKt7HjELjDRw0/d8+x7lChVSJXe2BBVgckfBpSdAthjqYhqHrY8k9xPQ8u/V2t32zpfzHpOvVIl3zreQbtA8QnRlyO45LHsEwI9feTB1H8O/8b200tYvE1gkDbkbQU0OWzmv+OifA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1VzAM2SUTgqO79GwydXX5qevzxZm1Pln82uf6l/hFl4=;
 b=eZWcd9IzYqYbkO/JRcXIkJEEa/dwBjWFEsF5W+SUfiwVmc2bIEG5Z4IpRZeChfgvjXvv1T5Dc+OIe4LzK5UAffnP4G1TrmY8dyQdMHrPmfnOlb19Q1r9PXU9hKFn29e0R3D6eg3tXGT6VObZi/FFR9q4kG4MPmdHqUfRygW3DPY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM9PR04MB8571.eurprd04.prod.outlook.com (2603:10a6:20b:436::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Thu, 14 Dec
 2023 21:28:53 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 21:28:53 +0000
Date: Thu, 14 Dec 2023 16:28:44 -0500
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
Message-ID: <ZXtzjIIl5oabviZI@lizhi-Precision-Tower-5810>
References: <20220222162355.32369-1-Frank.Li@nxp.com>
 <20220222162355.32369-2-Frank.Li@nxp.com>
 <ZXsRp+Lzg3x/nhk3@x1-carbon>
 <ZXsc57whj/3e/+zq@lizhi-Precision-Tower-5810>
 <ZXtkMC1ZjsgHMRvT@x1-carbon>
 <ZXtrG40SR81YAR6a@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXtrG40SR81YAR6a@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: SJ2PR07CA0024.namprd07.prod.outlook.com
 (2603:10b6:a03:505::14) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM9PR04MB8571:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a03962c-37d3-4e0f-6a14-08dbfcebabde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IR7/b+B5Gk31/GKOdoYdZGKZsN86WBi8X5gbtGHPesRBEiroMPS92LOxgVjPGm/e8C3vpvntpBXt4C0fwvcIeqf2720IllLzQaCdOudv7rVNvokzK7+Mtw+nPN1CI/1JaOAQAeJFMroiRNB7L89EgPBBS/3ZMyeCkc2q9L7NdOw8tvuwiKzW1TByfMbc9kVuTwcD36pZ4/VobuEtvMssmkQoMzUI9gRCfVVW7QG+wTD0XlPNRw52IgiL8LhyScAlC0OluqIhpxzwa+GtH6D/RZb8WtjE3AflswfjAzptVHkKkiuOoCY0tSpS9sOEB+K6/uK7QTg/9gCruZu/prOM9q1j7RK8ZNRR2qP7HL9mt78xlMp19ZKOnlprMA067WT5D3yvwGGIShSauIBdRe1/eSAo3zXtS0tD51XuAcVqH2EnWlc4SVrnFapZFhxfGPs0yhdHW5SC/8KjywzL85k8Um/+eZQ8g94NszoUjgvoEfnV9hieasSfu2JmRSuEcTMobNWyEIHIyG+iPqwyzaXa38WlkUdiEhLBjduH9Czx4qjReJFtK1RmzVJMvSIXf8L/kNG3ieccNfoQyoQWyvGskJLbM9B530oZwHFrqOU7NaUwuUh7RZx2bEti14l42qpkEJ6S7m8Yr2UmN3DI67Rtlb76XcpREMeD9ryYD4f80BQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(396003)(136003)(346002)(376002)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(4326008)(8936002)(8676002)(2906002)(7416002)(5660300002)(15650500001)(478600001)(6506007)(6512007)(6666004)(9686003)(52116002)(54906003)(66476007)(66556008)(66946007)(316002)(6916009)(6486002)(33716001)(41300700001)(38100700002)(86362001)(38350700005)(26005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HSwxWX1kBYbB+ftiyGUg4fwBmLHT8ftjKkykpn5kzne5bzfClY/Flw+HkJzP?=
 =?us-ascii?Q?wwhZzNfFStgIA2Up/Ngld6L6X71iKeZTUbZI7cOl/zlFN6xGYmtPHxV03um1?=
 =?us-ascii?Q?HCuYTKmkMDP+9NFamHmUFXIGUbub9/hY/GcLxTEbRxTagOHqxkMwNkEb1oVe?=
 =?us-ascii?Q?D/8hLg27ryfvIop+3Lv0ZjWelFteB0OsLQKegSobrSnawCY0DeOSlB/wHolA?=
 =?us-ascii?Q?3rmaVPCYpQ/yQpXydAhGjdSTtc+Eee5yujEA8uYkueuV5h1hEsyP1Z7bIAnf?=
 =?us-ascii?Q?VaGVxqZzv60cd1VNGCyDApjGiUVLCsJzH9g5HhH0dyTBjEx2mu5Sa896GmeJ?=
 =?us-ascii?Q?SjUSrRwq9l92dLfQt1AAFCbdW5ShkEgsdhXg8SedWP3A4sqKpgaM6WlcQZvB?=
 =?us-ascii?Q?wrJDw/cB7+LuvqL8ZmN/l8FLeX/mdAbTD43xXC6jXu87SruHvnTGalnbotEE?=
 =?us-ascii?Q?icGaWvuvpr4W1Yxq/3vmqWipamF/pgcPj661brhPrGVA1PugLwjGz5ePwm+D?=
 =?us-ascii?Q?BrzZ6GbVuC2+DIF7HYvmT9U2dwJuvxPSpupQ8e752IOd/Isr4LOqeD2JimCW?=
 =?us-ascii?Q?YP21ht1BjjxTxSLz69cdeaXqMr7yjrGQfVf8aM3zwxfnq051p0oLMFAA+cq9?=
 =?us-ascii?Q?Ua9qVE/SwFT1edQvv5jxrB9ofp5ILnS4Ma23y6nvql74rWKrFjqyWStV0nIE?=
 =?us-ascii?Q?Z+/UMerP4mB27IFltav/Cfptdsha+UZP+0vgcn6L63+nmFvJZxiQK3/RVN7r?=
 =?us-ascii?Q?EHojfMZK7AjQTSO1UN6rdkrvvg3N/utR4LRntlDmQfH/y2I8SWhHQVq0ja7r?=
 =?us-ascii?Q?3qUCvsKUPi2PeCmyqpP4uyFYdJGJDMP07WK/a/6um4p3sUWkiO2TgGL10PIE?=
 =?us-ascii?Q?6CycUe/UQVR7UT/qi20WtJ7+s1hLG8pe4xoZyueiyCU2CncTYLa/CveM0225?=
 =?us-ascii?Q?wEg2aqLRoOsLP/+sj7lDKxRTDcuHvyA98DdcI+vKmdFCLVZZiXAvCmrmDcWK?=
 =?us-ascii?Q?BIHv9+SW3EexChcebEIVzHuQGycHPci4YlJyVsYbARetzVbZU2O8GyJP6V6u?=
 =?us-ascii?Q?gLKW9RrpdE6PaVhoi5ujCIvc9fTyg8JNJWn3BkKKL5ZLn3X+zi017yIJ/FS4?=
 =?us-ascii?Q?jivaUsvFwe0xjDq2dIDU4F6u4mchI9J02WTjPvv5q/oIYO4D8C2u7LuNb5fx?=
 =?us-ascii?Q?5NSt/8SlMLztlIUQB4dgDjjW4ni3iMOj6R4YsJWn2ZEQuNSmRHhftWuPH25z?=
 =?us-ascii?Q?IRQeiV+0VrQFfujjjBV/zTwOOOULfA+QswN0ue4/zbWZnRH/YSy/Y18m6KIu?=
 =?us-ascii?Q?cHoTDA/D5ERn/cPdFHLKpvOTSRHLV+NwmCp6XzmxDLEgb+sJbsLx/F59Neh7?=
 =?us-ascii?Q?letUBuTrXXOdpsSZiAcjBji9F8XOxs8jEHtcu/jBxBRR+iV9wgBotQ8xZuqe?=
 =?us-ascii?Q?Elw2KolNRkWpvFFjiqX3e9fehGKbadma4TaAYHj/zuap8mhqErXEVOV1gbUN?=
 =?us-ascii?Q?/4B3Qkxa8dm65fPo9NOUeQ/k2hQBRR84lov4u0PkI3A6pnYWiGR/ev5NgKLW?=
 =?us-ascii?Q?ud8mMidbI6E+zPKtXK4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a03962c-37d3-4e0f-6a14-08dbfcebabde
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 21:28:53.5663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BNPl+sQjxbn9pgrXfis7+veE/JLOMmhqq63XLhzC4NRY6zOMRQBJqN2Fy46e85VRGeXLrFgaYMTPvfkRcQaHYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8571

On Thu, Dec 14, 2023 at 03:52:43PM -0500, Frank Li wrote:
> On Thu, Dec 14, 2023 at 08:23:14PM +0000, Niklas Cassel wrote:
> > On Thu, Dec 14, 2023 at 10:19:03AM -0500, Frank Li wrote:
> > > On Thu, Dec 14, 2023 at 02:31:04PM +0000, Niklas Cassel wrote:
> > > > Hello Frank,
> > > > 
> > > > On Tue, Feb 22, 2022 at 10:23:52AM -0600, Frank Li wrote:
> > > > > ntb_mw_set_trans() will set memory map window after endpoint function
> > > > > driver bind. The inbound map address need be updated dynamically when
> > > > > using NTB by PCIe Root Port and PCIe Endpoint connection.
> > > > > 
> > > > > Checking if iatu already assigned to the BAR, if yes, using assigned iatu
> > > > > number to update inbound address map and skip set BAR's register.
> > > > > 
> > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > ---
> > > > > 
> > > > > Change from V1:
> > > > >  - improve commit message
> > > > > 
> > > > >  drivers/pci/controller/dwc/pcie-designware-ep.c | 10 +++++++++-
> > > > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > > > index 998b698f40858..cad5d9ea7cc6c 100644
> > > > > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > > > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > > > @@ -161,7 +161,11 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no,
> > > > >  	u32 free_win;
> > > > >  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > > > >  
> > > > > -	free_win = find_first_zero_bit(ep->ib_window_map, pci->num_ib_windows);
> > > > 
> > > > find_first_zero_bit() can return 0, representing bit 0,
> > > > which is a perfectly valid return value.
> > > > 
> > > > > +	if (!ep->bar_to_atu[bar])
> > > > 
> > > > so this check is not correct.
> > > > 
> > > 
> > > Please sent out your fixed patch. If want to me fix it, please tell me
> > > reproduce steps.
> > 
> > Reproduce steps are simple:
> > 1) Add debug messages to dw_pcie_ep_inbound_atu() to see the iATU index for
> > each BAR.
> > 2) Boot an EP platform with a core_init_notifier.
> > 3) Boot the RC.
> > 4) Reboot the RC, which will assert + deassert PERST, and will call
> >    pci_epc_init_notify(), which will call .core_init (pci_epf_test_core_init())
> >    which will set the BARs.
> > 
> > 
> > In step 3) BAR0 will use iATU0.
> > 
> > In step 4) BAR0 will use iATU6 instead of iATU0.
> > There is no reason for this, as it should really reuse the same
> > iATU index as before, just like all the other BARs do.
> > (This is because of find_first_zero_bit() misusage.)
> > 
> > 
> > I could send out my patch, but from inspecting the code, it looks like:
> > 
> > > > > + if (ep->epf_bar[bar])
> > > > > +         return 0;
> 
> I checked current code. 
> 
> dw_pcie_ep_inbound_atu()
> {
>  	if (!ep->bar_to_atu[bar])                                                                   
>                 free_win = find_first_zero_bit(ep->ib_window_map, pci->num_ib_windows);             
>         else                                                                                        
>                 free_win = ep->bar_to_atu[bar]; 
> }
> 
> I missed conside '0' is validate windows number. I think we should init
> bar_to_atu to -1. 
> 
> 	if (ep->bar_to_atu[bar] < 0)
> 
> 
> Origial change want dw_pcie_ep_inbound_atu() can be call twice to update
> bar map address. vntb use "bar3" as memory map windows, so have not trigger
> this problem.

Does below change fix your problem?

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index f6207989fc6ad..2868d44649ef7 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -177,7 +177,7 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
        if (!ep->bar_to_atu[bar])
                free_win = find_first_zero_bit(ep->ib_window_map, pci->num_ib_windows);
        else
-               free_win = ep->bar_to_atu[bar];
+               free_win = ep->bar_to_atu[bar] - 1;
 
        if (free_win >= pci->num_ib_windows) {
                dev_err(pci->dev, "No free inbound window\n");
@@ -191,7 +191,7 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
                return ret;
        }
 
-       ep->bar_to_atu[bar] = free_win;
+       ep->bar_to_atu[bar] = free_win + 1;
        set_bit(free_win, ep->ib_window_map);
 
        return 0;
@@ -228,7 +228,7 @@ static void dw_pcie_ep_clear_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
        struct dw_pcie_ep *ep = epc_get_drvdata(epc);
        struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
        enum pci_barno bar = epf_bar->barno;
-       u32 atu_index = ep->bar_to_atu[bar];
+       u32 atu_index = ep->bar_to_atu[bar] - 1;
 
        __dw_pcie_ep_reset_bar(pci, func_no, bar, epf_bar->flags);

> 
> Frank
> 
> > 
> > from dw_pcie_ep_set_bar(), also needs to be dropped, so that the iATU
> > settings will be re-written for platforms with core_init_notifiers.
> > 
> > Right now, for a platform with a core_init_notifier, if you run
> > pci_endpoint_test + reboot the RC (so that PERST is asserted + deasserted),
> > and then run pci_endpoint_test again, then I'm quite sure that
> > pci_endpoint_test will not pass the second time (because iATU settings
> > were not rewritten after reset).
> > 
> > It would be nice if Mani or Vidya could confirm this.
> > 
> > 
> > I guess that you added this statement for some reason, so I assume
> > that we can't just drop this line without breaking something else.
> > 
> > I guess one option would be modify dw_pcie_ep_init_notify() to call
> > dw_pcie_ep_clear_bar() on all non-NULL BARs stored in ep->epf_bar[],
> > before calling pci_epc_init_notify(). That way the second .core_init
> > (pci_epf_test_core_init()) call will use write the settings, because
> > ep->epf_bar[] will be empty, so the "write the settings only the first
> > time" approach will then also work for core_init_notifier platforms.
> > 
> > 
> > Kind regards,
> > Niklas

