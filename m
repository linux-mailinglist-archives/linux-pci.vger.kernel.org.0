Return-Path: <linux-pci+bounces-998-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EB881347E
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 16:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E83BE1C20866
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 15:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D95D5C903;
	Thu, 14 Dec 2023 15:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mQRmh38o"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2042.outbound.protection.outlook.com [40.107.249.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3C6121
	for <linux-pci@vger.kernel.org>; Thu, 14 Dec 2023 07:19:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jcf2uQB+p331wyNOTBkAqs8FCmj0wvoHKJePRr0lFFK0QmRCUTSKtepza7wpixoJv246/IJ6b2mYA82fy5jeDAtmCmSoGG9XUu9QSmXXRzPHIGQJo+OmyY8wda7GVtfLNf3q3YQJMQ3+HjyaFGJ8rE2GuLbSsdwvBPgw7iyWqPyj5UP8Y3WSSQHr5yY+sngn9oTbMT4coHWysDGsnfEGKCZYD2SBExjlYmUy4P6bFxadZJMqN6fBbl4nwwinTuAVXYZ0e9nVSUI8TtkjhposbCPsAgChEdWCy9ta7M+VjyAVOL8Zaj6iVeHHuVjGILnH7MEdZ533TA/GT4NBylGkPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rmc04Y176vNcqSbq2hvQkFGDh7HbzpNUjduVUqmzldw=;
 b=BaHTAPKOWjgsYrJc9VzfPaen0SvmwzcAcAH2raGrANOBK4aThZrJ/EZok5tgerEcsztD/4ZWBTDoOsSuigI5rNOyqhlLjGJCr906MjbWYGt/VGYKzvjtc5BcVxvj5I05wW+jcbg5KfCVFUSmivm/wiO0cBcoMZVhPnggBSa+7ne9RsaZVVYjnCpPv5I2c6jU3jL/dW2fA+fL2Z6Cuv9eRJlZCDgyGKHs+ztq20Wzd8zTz/JyZuGDTMG/0uI+Yr20cu2f5qYtXivWfgLaQWeb4b2v620a3QKzpnucu8/b8oUEW16S1NdejRBx4JNfJj/oi0SL2YjGR9dFAL6EBbujLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rmc04Y176vNcqSbq2hvQkFGDh7HbzpNUjduVUqmzldw=;
 b=mQRmh38olbxIWTJblrSklDE3NCiIPDRNz54i8icUqq9Y7nqda7zrE3YZrGbzylyl6It9poO8bQEHmlOuHpdhfc47Te+szjzo3sfP6UcI+MWuwAtp4MdkE8xPMEydUYXQKV0X+QhvwzhcXLyR32x06YmzaTlwUzO78a1vSfW2Ibo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DBAPR04MB7400.eurprd04.prod.outlook.com (2603:10a6:10:1b3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 15:19:12 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 15:19:12 +0000
Date: Thu, 14 Dec 2023 10:19:03 -0500
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
Message-ID: <ZXsc57whj/3e/+zq@lizhi-Precision-Tower-5810>
References: <20220222162355.32369-1-Frank.Li@nxp.com>
 <20220222162355.32369-2-Frank.Li@nxp.com>
 <ZXsRp+Lzg3x/nhk3@x1-carbon>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXsRp+Lzg3x/nhk3@x1-carbon>
X-ClientProxiedBy: SN6PR08CA0035.namprd08.prod.outlook.com
 (2603:10b6:805:66::48) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DBAPR04MB7400:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d32322d-8cd3-4113-94ed-08dbfcb806a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DPeuC7ovhrG/+N96AYwJmKkby2GIkBHwcBFOuMEksLWqBgyRurUiF8+CvYCwcTk+7E8hFedFCX+QEsT5sufZpBQXW7WE0FJgcDigZY4xpAf23wykwRBC510G2sfPbdR38vzauur6ldDwV0hJhg9cJVXXGeJCBOFJugDmHSDzUo1+r9MqgLr1R440aAPz9HCjVF0N2YgXnOAIx5RMiwFwEVrQLyoVaNgvmQv/S2oYZufuPz1ULM1ig2wqRPIsprLt4HXWSjOjOei3bAdj0+lcc4w2kUoOolJHi9zA706bVoAuv+rdHs8LNIy5GtYwZNCBaZPjSHh6PdFDJOQdzyYZ7KG91P6fdDDdLSxkrqHGmTkmzSzEL9vJEw+DHuPjX/3tBUdjkkDK1xrYppyVLDhB7uTiR2xXhJyQTKqj74MJBzWEbuyV8W0zA32A9oqyz/Wq45RMkLS29FkwBoivDs3xIHCRcUYwQEjKC253QVSCwdJzIAyxR8VpEqw+ONn4t8qmS/ZlAHGyNN/kCbW/DXtnbPpdezI1pk5Llwjiac23mkZIOIHHZ88rPQVclpo+srersEdvCIjvwMRmFGsScxgj2byRhOIzAuXXocnpaQ+EJBYO05KP8i3myu6XqbKH2d6m
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(376002)(39860400002)(366004)(396003)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(33716001)(86362001)(38100700002)(316002)(6916009)(66946007)(66556008)(66476007)(26005)(83380400001)(54906003)(15650500001)(5660300002)(4326008)(8676002)(8936002)(6666004)(6512007)(6506007)(9686003)(52116002)(478600001)(6486002)(41300700001)(7416002)(2906002)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4U4InPZDCLjBlifYFOA19P+oT0d4D+x4z3xtktbhRaP88emHWy+acZ5+EHHU?=
 =?us-ascii?Q?u8HJUoiUy9z3CW6IoLPXdgqNQadX4CfqP65gY49jsbufRLETEb+pCciYuDRZ?=
 =?us-ascii?Q?xjvHmjVpvKMyGXkvYoczLSCV23ac851srpXyZS8Bu65mDIr33vUXeQhQs9pT?=
 =?us-ascii?Q?dPTOHXXBELidFsK9h67Jze8aOONV6ylgVIQOV4jHK5ym1ji4kpSbGmFSEzAx?=
 =?us-ascii?Q?bu2q0g6rk0G17bN/dx7hz/3+9zoW1d1AGPWnkQuuqLG/xerVqgWxGzShj/UV?=
 =?us-ascii?Q?QXPAtKasF9Gt8gbMwY8+9PvzXSoMUu/LuVTqYR++/MgZUz3ktd7nPsgKbsGd?=
 =?us-ascii?Q?Umnn8c9V9peNkVxR6dpYzOsiNX6gegJYHq8Lj0q81n7poc5qdQeLAF5Lm7z7?=
 =?us-ascii?Q?wrEF7Bp0EqXi1q4hmbSKIesLBouPLqwXTqSSMo9TOZjXd6Kqp8CJYe18oOpN?=
 =?us-ascii?Q?oOhIj9X8lAu8C8tSRX9gtE3rGr4F2MZ2+FjzpOT8Be5E5DMf0anyYKj0JmeN?=
 =?us-ascii?Q?mlDbizzvm5VCzRTffzIzp1CdVZr9lxX7dbj5OLNTLDN3XgfiPPssphDyqNpd?=
 =?us-ascii?Q?vtiVmjsBsQl2M+Y0f8uw0Q0cuEc/RixRezKHoNdanO2Mi4/dWug81899rIwP?=
 =?us-ascii?Q?/9pRvPPicBrGmCoPPJzENd2aBWRdMJV4HN7iLof/EOBlerur0YObdwUOb7fp?=
 =?us-ascii?Q?8yYTTk2nNe4ZvGklYU+H5QQOzf8FlZZH3bXfXQ1Gnx60I/mH77uM9D6qLjKz?=
 =?us-ascii?Q?VKAg4WlPb/oC9K1ygVevNh6vdgLRY7jHvSBpUoxdij6yGXxy31VzdA5IxnO9?=
 =?us-ascii?Q?e3w4tdLmiQjC8FDK6aZVmUGHa798jE2HP8yLNDOJQQ0ADzneoWQ8SLo6tmEa?=
 =?us-ascii?Q?amX26RVslPz9gT61XP2xr/TBRcezRHfSyVvmq+4BTl0dW3V2INnqXCPcy/tH?=
 =?us-ascii?Q?qBhlIHvhUMiOuB7Oap3UBl6FzJrp5AVESji+deM2FQUoC8TE4oVwNuRXnVGO?=
 =?us-ascii?Q?CbJvZqPSax2o8jsELfZ+nq1xJCgFtkGcY4vuxNlCt3/Lv40KZUbC9GXkHBsN?=
 =?us-ascii?Q?HNYBeqlw7GTc+qCf0vdd7dMOBtGCbyHMKNl1NtU7SerEjnteCbTSGFLxBhPv?=
 =?us-ascii?Q?RwMgzleOMkL2KuBjGTlO+UyK/cBNBJcAHV7nT387DIBVYaNMnaFo5+KRbyPD?=
 =?us-ascii?Q?s1RAudq5zVt9rbQuh0PxZADT2RXBc+/4yEcq9/qFv21OeesKc/J+pXzhj2Qt?=
 =?us-ascii?Q?Q5izz9Hfw1aQHC4OdzlVhoFEsdIE7o6z17fbo56GUpv76HKLE010ZNLR+F4B?=
 =?us-ascii?Q?HDSuCoJpVZiI5mPRyoBy6QoIYElrgPPN0zA4lTDHwpw556YAG7LyeA5G+1t2?=
 =?us-ascii?Q?psNjqwaq69RRFI63+xCUQ/aKOPKQDZDIYZLJJvox+gTocUerhUtmRtJXqwMO?=
 =?us-ascii?Q?0JuW1u7UBHwAadlPsAhrYEWYBxNhb3bCs2Yy6seaHyYjOQb8cPq940Qp4Y5I?=
 =?us-ascii?Q?1h/cUcT/O/eGe3wRfOSbJFhrRLIioeY21f3ZXMeATicbCT76kcxY4fEOpQOX?=
 =?us-ascii?Q?/aI2zp65bQDflFZbhFmNxx+V9NCsQ5xml40xDkyx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d32322d-8cd3-4113-94ed-08dbfcb806a4
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 15:19:12.0715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w9n/48+dsTM71rlrAGRG7cS+OraDZiWbolr8W+EY6g2pV05mlNH3fZY3adYbx1uaPe62U5uIvvMApHwN8KBJ/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7400

On Thu, Dec 14, 2023 at 02:31:04PM +0000, Niklas Cassel wrote:
> Hello Frank,
> 
> On Tue, Feb 22, 2022 at 10:23:52AM -0600, Frank Li wrote:
> > ntb_mw_set_trans() will set memory map window after endpoint function
> > driver bind. The inbound map address need be updated dynamically when
> > using NTB by PCIe Root Port and PCIe Endpoint connection.
> > 
> > Checking if iatu already assigned to the BAR, if yes, using assigned iatu
> > number to update inbound address map and skip set BAR's register.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > 
> > Change from V1:
> >  - improve commit message
> > 
> >  drivers/pci/controller/dwc/pcie-designware-ep.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > index 998b698f40858..cad5d9ea7cc6c 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > @@ -161,7 +161,11 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no,
> >  	u32 free_win;
> >  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> >  
> > -	free_win = find_first_zero_bit(ep->ib_window_map, pci->num_ib_windows);
> 
> find_first_zero_bit() can return 0, representing bit 0,
> which is a perfectly valid return value.
> 
> > +	if (!ep->bar_to_atu[bar])
> 
> so this check is not correct.
> 

Please sent out your fixed patch. If want to me fix it, please tell me
reproduce steps.

Frank

> 
> For platforms that has a core_init_notifier, e.g. qcom and tegra,
> what will happen is that, on first boot:
> 
> BAR0: iATU0
> BAR1: iATU1
> BAR2: iATU2
> BAR3: iATU3
> BAR4: iATU4
> BAR5: iATU5
> 
> Rebooting the RC, will cause a perst assertion + deassertion,
> after which:
> 
> BAR0: iATU6
> BAR1: iATU1
> BAR2: iATU2
> BAR3: iATU3
> BAR4: iATU4
> BAR5: iATU5
> 
> This is obviously a bug, because you cannot use:
> 
> if (!ep->bar_to_atu[bar])
> 
> when 0 is a valid return value.
> 
> My proposed fix is:
> 
> 
> @@ -172,16 +176,26 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
>  {
>         int ret;
>         u32 free_win;
> +       u32 saved_atu;
>         struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  
> -       if (!ep->bar_to_atu[bar])
> +       saved_atu = ep->bar_to_atu[bar];
> +       if (!saved_atu) {
>                 free_win = find_first_zero_bit(ep->ib_window_map, pci->num_ib_windows);
> -       else
> -               free_win = ep->bar_to_atu[bar];
> -
> -       if (free_win >= pci->num_ib_windows) {
> -               dev_err(pci->dev, "No free inbound window\n");
> -               return -EINVAL;
> +               //pr_err("%s BAR: %d, found no ATU, using first free, index: %d\n", __func__, bar, free_win);
> +               if (free_win >= pci->num_ib_windows) {
> +                       dev_err(pci->dev, "No free inbound window\n");
> +                       return -EINVAL;
> +               }
> +
> +               /*
> +                * In order for bar_to_atu[bar] == 0 to equal no iATU, offset
> +                * the saved value with 1.
> +                */
> +               saved_atu = free_win + 1;
> +       } else {
> +               free_win = saved_atu - 1;
> +               //pr_err("%s BAR: %d, already has ATU, index: %d\n", __func__, bar, free_win);
>         }
>  
>         ret = dw_pcie_prog_ep_inbound_atu(pci, func_no, free_win, type,
> @@ -191,7 +205,7 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
>                 return ret;
>         }
>  
> -       ep->bar_to_atu[bar] = free_win;
> +       ep->bar_to_atu[bar] = saved_atu;
>         set_bit(free_win, ep->ib_window_map);
>  
>         return 0;
> 
> 
> >  static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> > @@ -244,6 +249,9 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> >  	if (ret)
> >  		return ret;
> >  
> > +	if (ep->epf_bar[bar])
> > +		return 0;
> > +
> 
> However, here you ignore writing the settings if (ep->epf_bar[bar]),
> again, this will not work for a platform with a core_init_notifier,
> as they perform a full core reset using reset_control_assert(),
> when perst is asserted + deasserted, so AFAICT, these settings will
> get cleared for those platforms, so they will need to be re-written.
> 
> 
> >  	dw_pcie_dbi_ro_wr_en(pci);
> >  
> >  	dw_pcie_writel_dbi2(pci, reg, lower_32_bits(size - 1));
> 
> 
> Kind regards,
> Niklas

