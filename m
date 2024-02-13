Return-Path: <linux-pci+bounces-3419-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6016853DBA
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 22:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48BD71F2C42E
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 21:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D021F61695;
	Tue, 13 Feb 2024 21:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ShOz6Fh9"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2066.outbound.protection.outlook.com [40.107.6.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C17629F7;
	Tue, 13 Feb 2024 21:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707861278; cv=fail; b=hKHEZvnZOb49J/fboGoLpW3vOsOqnvw5CMi+5CXZcZhCMxssGXSoYoC1MG9ydoDYC+1YdJHBz688WPKwFSzP58Xk4aZcjcgVAJq4/CCj1MI0lWXlGe7lGoIxp711Hde16L/viEhkBNw2svEPlMY05gD29BMURgTd3stmWSBcQgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707861278; c=relaxed/simple;
	bh=7FFRHRwEBxYYDyDE+Xc1Nj6MXaMHfM//Z7AcSvNtlyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j9ueu7ivzL7ILs9erqei7qlOdvPN9ZLzSB+IvpdeFA3qOCIorvD/Fg7qp6nyMnmh1pFquafITqxlfc+exeeLg8kaYC0qjnN6WKu2obvjdo5Yq8GVkKmn7bGQt8Xb0domZjRg1CNRoNYLrGTO2d5MY1FCNHFUzj0Wqh+yZ8Tbas0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ShOz6Fh9; arc=fail smtp.client-ip=40.107.6.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WsKX5Iy4jQwBdLh8NQRRLfArenWqeittw1q3MIbjz1mzkooB35S0MDFQ3CirxPB6IplAHm240qBRq99Xk6XFJXbLLST+FrOvac7KDjbCjrXxyum6yGVqFYo3xoqdjZyU3Mw4G/FJYumAnjA6MV6ttuDFpFeFzN5PxWpz3qC4yqpW4qVwiN99cOCRbGvnONu6cNYAljXMOhorXV4aDOUk8IOw+yH5BH4zmxakaGHX8EJeAHwOkvVn+WjHKjdvos+0B6R0jR92g5xexqMv4XY1u+NjarVOI8udDwH5c8wzrRTsc9pCPeJlSITJ/GKbKLGgwCC0//C8IJzpec1XP6x1PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IpqxR6iN0uJvM95b7yu55CEZJExYLwKrEJlw6jLDJsE=;
 b=LZJaqxgf0fCQ30o2wJKSrqFs3OlPDpJq2tnc6FN6OVJDsPjcmgpDyzGpakGJdWmGsl++Ska4UeNzWoHge4EXLOX8GL9qwDW5H2eszMluw6iudllbUjDu08FXEzET0zvH2QgJ1rshPyySH27q57OP+WNcH6Qk0coDe3ZPACYQPiziNArmY6umpkKBTNZo6idlG8pQy0TJnfxlk1z9ehCrtbUlb9J0OYGy7grRfM8oZBcH2asxV4ITTKMIb78x0EJ6ogBLbX3TKtcOORpMgodYpNEgNmn2LEpNbVbC58BAut1XLAZrZ43vSEEiK596o1ScboFmg+42H3/A5NEgCl5mFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IpqxR6iN0uJvM95b7yu55CEZJExYLwKrEJlw6jLDJsE=;
 b=ShOz6Fh9u1nbpL0FQjdv8SnsrcYiJnh4DfgxKmrvocVN0m0CPskneBmPBBf5oSI57KCGAEee5fh++KznmGzwl7Un2UNuAUHWBE2TU7dg/gtwpoNi3R2GzwDXD9+vkwjCQZ3E71NtZ5SogOAXLLLEbsu/bRAX6LwNC4ODyh5DRSY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8837.eurprd04.prod.outlook.com (2603:10a6:10:2e0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.44; Tue, 13 Feb
 2024 21:54:33 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7270.025; Tue, 13 Feb 2024
 21:54:32 +0000
Date: Tue, 13 Feb 2024 16:54:24 -0500
From: Frank Li <Frank.li@nxp.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 5/6] dt-bindings: PCI: dwc: Add 'msg' register region
Message-ID: <ZcvlEPzDY9QFw5Zf@lizhi-Precision-Tower-5810>
References: <20240202-pme_msg-v3-0-ff2af57a02ad@nxp.com>
 <20240202-pme_msg-v3-5-ff2af57a02ad@nxp.com>
 <eg7wrjp5ebz43g37fvebr44nwkoh4rptbtyu76nalbmgbbnqke@4zugpgwesyqd>
 <20240205183048.GA3818249-robh@kernel.org>
 <ZcEzYdZKotBJlR5i@lizhi-Precision-Tower-5810>
 <ZcK2/tmLG9O7CBEH@lizhi-Precision-Tower-5810>
 <luk5hswq4wnk5p7axml73qih35hio3y3pfnklctbn6rwres62s@mumnvygjh5ch>
 <ZcOpehO3rzCfAwXf@lizhi-Precision-Tower-5810>
 <gl7zmzkezr6k4txrrgqyikspfah3vmgwwz2e3j5kwb2iarpkxv@3ofwrhtxl2sz>
 <ZcqagbUnSfRgv5Hd@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcqagbUnSfRgv5Hd@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: SJ0PR03CA0155.namprd03.prod.outlook.com
 (2603:10b6:a03:338::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8837:EE_
X-MS-Office365-Filtering-Correlation-Id: e4fce502-40bd-4950-77af-08dc2cde5c44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TU4QmjtprOYYchaNL83vKZ/PlAt66a+SE8yTn0AIeMsTDxw+nc61q7KlKXS+bP8OSGXAJ0ZHeujsacVfnKev0ehJKwnmdFfXzweLU8D/tVl3aLfO/YRzGOBShWxnsR1TE9Kk3yCiL5g3TdykXF+qcSpj0bsfZvkOZXN/B2r+VsnLGR86z1WGxubAJwnCbWuRenW0HSEaOYXeRz+WlsNgBC8BPqRVeXP5wZWclSFwgsZ2UPkz0DP4BTHjyCuRQoX/nt8DXlBVwy4+7D93uKBReWMjmOcKhmNH67xWQnqNMianH9bijpnU8/ySjgbO3tFBpcdIhg/+pdUjfdlop1JQote9jzI83Ojb0/tPEmsPJ4KWtM6Ee1SgsBWRb2LRDbOisx7v2zG/Onx4h9uPGuLDtaGeq+y/Vl4MSN9oO6JYe8+Y0YpdJCqeCJSu5AFPGIR9rm5Dz89Ba1Bn4JLBqrQsQAwM3upwroJXv04l4cfUs93hhH3SgvBLxD6l2/o0LtQRwTUHh7ExoVPJe4+snotr1VMsVcPP1roUme5kkW2GYhqY3EsMCL/n+nJitF1kVl7FMEPBwjmTb9pRFTSmWd43SGQxHdXg+TOaorzDfzzZVZQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(136003)(346002)(39860400002)(376002)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(41300700001)(38100700002)(86362001)(33716001)(7416002)(6916009)(316002)(54906003)(26005)(83380400001)(966005)(478600001)(6486002)(66899024)(9686003)(52116002)(6506007)(6512007)(2906002)(8676002)(4326008)(66946007)(66556008)(6666004)(66476007)(38350700005)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rsbyW4jTDYOTggsPdfp58A/aurzhMRoE0PbHsmwD9FdxnSyox6upPQKySJv9?=
 =?us-ascii?Q?4x7g10U/zjjgzJbm8wTd3+f8zv+AQOoYxbvv7HUAZvZ5Wd3iIX8oMOOxJ4Rh?=
 =?us-ascii?Q?Lod/YBYaAIVz0a/PPIHOp5qzaUDjsIrP6PB4ZlrGrwZWuBrJ0AspUqOj7dNA?=
 =?us-ascii?Q?Rhh02Ejhi0owJ9LbKUdPGtL03OO2zjRnB+KXZYUgc7oZVqIlQ4/BvUd4SiOV?=
 =?us-ascii?Q?0R/qeX9aEuhMgw+TYT9MK0gRQXn+IvaBL+RU37ldFGevBgXCz4YRTDDgFID1?=
 =?us-ascii?Q?rb+gDXUpcMhKabg6ECVR0yTH1BpjD0wm/VJaFzNUzDown8f+eXWBz5ZAIuYN?=
 =?us-ascii?Q?p65asrbB2e/Aur2aqnQkBRGDgcy4b1uqQ5if+X70k1Fce9euBIVEN/6YC0K4?=
 =?us-ascii?Q?PFBwPeZV34WAiYNYMLkl0C+o749NOyphRVDYN9lBv+B5hex/EYcd/J3TEwuN?=
 =?us-ascii?Q?UxigktRjxz5qsGxoesy0ePKHtKTe3R4Qq0nNp/Tg6cQWAOmo19HwJUOohBS6?=
 =?us-ascii?Q?HYlKWZKF6/JScdX8FdPRp1JFQUO4/Z482giN8cOA38YZn1Ucq4HWVFIsR0Jj?=
 =?us-ascii?Q?9N1+MExC26EBOYnrmqJo7gabaEhHV4/p7UDnVVJE+dW65UnJl2xE3t1kw3Nc?=
 =?us-ascii?Q?wybN+XLi5SOvzt9MwFTA3rpaVwL/pQkhLqNOPn2CiRi2xIsliaMNUAi6Pvej?=
 =?us-ascii?Q?2F2btLGVHUwUv2h9S0bZkS98Y1bzX4pAWL5otNuukV9DULd0tBcJDqW1OZtt?=
 =?us-ascii?Q?7dxW4FOqeAx5b59ILIwU3KzaaKX55rtRuO+sn31RVJyxRuU869kt60fZgyPr?=
 =?us-ascii?Q?dFYPNHUhb5mjDCxvzot6Dhd30JC67gHl++o68sLyrowWC6Ep73/7v5Jl7YBi?=
 =?us-ascii?Q?vnVX2vUvxFPk9ywlCTMJv/TP+vGQSR3TXoqoV+j5FElnYlFNaKXzr+UbjE4n?=
 =?us-ascii?Q?4mGziX+W+IuL5tlcAiCFPRRxKznZUJLgZf/G6RXXI67TNyQkYgil3e+3NzPx?=
 =?us-ascii?Q?9yJA2ml28sOwhwguKdWezjf7EQyrmk0aYiSGCqKUgIonvqvciYGO+VIE/hGx?=
 =?us-ascii?Q?u88ALsOhHjCbksBvgR1TCBsMJqFLD9TnopJSpKTO6VdXvsZwnbMYeFeNrYIE?=
 =?us-ascii?Q?CAn617JjqGtABl3Yf5aY1qXAj60UGgJ9uVorOzUT02DomdEV+5CqMXMD+JnJ?=
 =?us-ascii?Q?rfqYOsA2peEk2bShu+b5Bkn/L1OT41aIvqID8GKYP9lDxbhJy0HbcdxrTqOC?=
 =?us-ascii?Q?5uLTMYadyHYuICQge1U8W015f3m4d0F0iGFRfEq7w0wkMVa8oEs2IFttwqXu?=
 =?us-ascii?Q?TMcasgxWExvueYVC8HGemscAXA+W+BJfXd/R08MEXxp9xzQDAJ0L5sOrQA79?=
 =?us-ascii?Q?P8G5hinypnUyjyX8NeLw+0CVDQ2AeBur2P0YC+mSyoNZze1dwVtNYwpRXabI?=
 =?us-ascii?Q?RV/5XAvH2mq5fvUBjSwiqT40frgGDF4sgYaGCkLUshxTbtiOYbWKa7W47CCn?=
 =?us-ascii?Q?0eFDK97u5JbkYYAeuRFkR/tI7+vtsXpv+lX+Isjo5UN6A/DS6I1Fze6Q0PhB?=
 =?us-ascii?Q?StF276cIdCNGd0lwRQ9QCxLM/2RkUlq+C8ppVVUP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4fce502-40bd-4950-77af-08dc2cde5c44
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 21:54:32.3782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E7JteoIznDNeQ1up1wMpFB4XhkcfZu9B20SMrK5YVNTqdF84j6JMbRUzGa13Z+mbu0RLZHbdtoHsZw97aD/+dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8837

On Mon, Feb 12, 2024 at 05:24:01PM -0500, Frank Li wrote:
> On Fri, Feb 09, 2024 at 12:52:52PM +0300, Serge Semin wrote:
> > On Wed, Feb 07, 2024 at 11:02:02AM -0500, Frank Li wrote:
> > > On Wed, Feb 07, 2024 at 03:37:30PM +0300, Serge Semin wrote:
> > > > On Tue, Feb 06, 2024 at 05:47:26PM -0500, Frank Li wrote:
> > > > > On Mon, Feb 05, 2024 at 02:13:37PM -0500, Frank Li wrote:
> > > > > > On Mon, Feb 05, 2024 at 06:30:48PM +0000, Rob Herring wrote:
> > > > > > > On Sat, Feb 03, 2024 at 01:44:31AM +0300, Serge Semin wrote:
> > > > > > > > On Fri, Feb 02, 2024 at 10:11:27AM -0500, Frank Li wrote:
> > > > > > > > > Add an outbound iATU-capable memory-region which will be used to send PCIe
> > > > > > > > > message (such as PME_Turn_Off) to peripheral. So all platforms can use
> > > > > > > > > common method to send out PME_Turn_Off message by using one outbound iATU.
> > > > > > > > > 
> > > > > > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > > > > > ---
> > > > > > > > >  Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml | 4 ++++
> > > > > > > > >  1 file changed, 4 insertions(+)
> > > > > > > > > 
> > > > > > > > > diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > > > > > > > > index 022055edbf9e6..25a5420a9ce1e 100644
> > > > > > > > > --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > > > > > > > > +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > > > > > > > > @@ -101,6 +101,10 @@ properties:
> > > > > > > > 
> > > > > > > > >              Outbound iATU-capable memory-region which will be used to access
> > > > > > > > >              the peripheral PCIe devices configuration space.
> > > > > > > > >            const: config
> > > > > > > > > +        - description:
> > > > > > > > > +            Outbound iATU-capable memory-region which will be used to send
> > > > > > > > > +            PCIe message (such as PME_Turn_Off) to peripheral.
> > > > > > > > > +          const: msg
> > > > > > > > 
> > > > > > > > Note there is a good chance Rob won't like this change. AFAIR he
> > > > > > > > already expressed a concern regarding having the "config" reg-name
> > > > > > > > describing a memory space within the outbound iATU memory which is
> > > > > > > > normally defined by the "ranges" property. Adding a new reg-entry with
> > > > > > > > similar semantics I guess won't receive warm welcome.
> > > > > > > 
> > > > > > > I do think it is a bit questionable. Ideally, the driver could 
> > > > > > > just configure this on its own. However, since we don't describe all of 
> > > > > > > the CPU address space (that's input to the iATU) already, that's not 
> > > > > > > going to be possible. I suppose we could fix that, but then config space 
> > > > > > > would have to be handled differently too.
> > > > > > 
> > > > > > Sorry, I have not understand what your means. Do you means, you want
> > > > > > a "cpu-space", for example, 0x8000000 - 0x9000000 for all ATU. 
> > > > > > 
> > > > > > Then allocated some space to 'config', 'io', 'memory' and this 'msg'.
> > > > > 
> > > > > @rob:
> > > > > 
> > > > >     So far, I think "msg" is feasilbe solution. Or give me some little
> > > > > detail direction?
> > > > 
> > > > Found the Rob' note about the iATU-space chunks utilized in the reg
> > > > property:
> > > > https://lore.kernel.org/linux-pci/CAL_JsqLp7QVgxrAZkW=z38iB7SV5VeWH1O6s+DVCm9p338Czdw@mail.gmail.com/
> > > > 
> > > > So basically Rob meant back then that
> > > > either originally we should have defined a new reg-name like "atu-out"
> > > > with the entire outbound iATU CPU-space specified and unpin the
> > > > regions like "config"/"ecam"/"msg"/etc from there in the driver
> > > > or, well, stick to the chunking further. The later path was chosen
> > > > after the patch with the "ecam" reg-name was accepted (see the link
> > > > above).
> > > > 
> > > > Really ECAM/config space access, custom TLP messages, legacy interrupt
> > > > TLPs, etc are all application-specific features. Each of them is
> > > > implemented based on a bit specific but basically the same outbound
> > > > iATU engine setup. Thus from the "DT is a hardware description" point
> > > > of view it would have been enough to describe the entire outbound iATU
> > > > CPU address space and then let the software do the space
> > > > reconfiguration in runtime based on it' application needs.
> > > 
> > > There are "addr_space" in EP mode, which useful map out outbound iatu
> > > region. We can reuse this name.
> > > 
> > > To keep compatiblity, cut hole from 'config' and 'ranges'. If there are
> > > not 'config', we can alloc a 1M(default) from top for 'config', then, 4K
> > > (default) for msg, 64K( for IO if not IO region in 'ranges'), left is
> > > mem region. We can config each region size by module parameter or drvdata.
> > > 
> > > So we can deprecate 'config', even 'ranges'
> > 
> > Not sure I fully understand what you mean. In anyway the "config" reg
> > name is highly utilized by the DW PCIe IP-core instances. We can't
> > deprecate it that easily. At least the backwards compatibility must be
> > preserved. Moreover "addr_space" is also just a single value reg which
> > won't solve a problem with the disjoint DW PCIe outbound iATU memory
> > regions.
> > 
> > The "ranges" property is a part of the DT specification.  The
> > PCI-specific way of the property-based mapping is de-facto a standard
> > too. So this can't be deprecated.
> > 
> > > 
> > > > 
> > > > * Rob, correct me if am wrong.
> > > > 
> > > > On the other hand it's possible to have more than one disjoint CPU
> > > > address region handled by the outbound iATU (especially if there is no
> > > > AXI-bridge enabled, see XALI - application transmit client interfaces
> > > > in HW manual). Thus having a single reg-property might get to be
> > > > inapplicable in some cases. Thinking about that got me to an idea.
> > > > What about just extending the PCIe "ranges" property flags
> > > > (IORESOURCE_TYPE_BITS) with the new ones in this case indicating the
> > > > TLP Msg mapping? Thus we can avoid creating app-specific reg-names and
> > > > use the flag to define a custom memory range for the TLP messages
> > > > generation. At some point it can be also utilized for the config-space
> > > > mapping. What do you think?
> > > 
> > 
> > > IORESOURCE_TYPE_BITS is 1f, Only 5bit. If extend IORESOURCE_TYPE_BITS, 
> > > all IORESOURCE_* bit need move. And it is actual MEMORY regain. 
> > 
> > No. The lowest four bits aren't flags but the actual value. They are
> > retrieved from the PCI-specific memory ranges mapping:
> > https://elinux.org/Device_Tree_Usage#PCI_Address_Translation
> > https://elixir.bootlin.com/linux/latest/source/arch/sparc/kernel/of_device_64.c#L141
> > https://elixir.bootlin.com/linux/latest/source/arch/sparc/kernel/of_device_32.c#L78
> 
> In dt: phys.hi cell: npt000ss bbbbbbbb dddddfff rrrrrrrr
> 
> of_bus_pci_get_flags() will parser (phys.hi) to resource flags. Even there
> are "000" in dt, we can use, but it need convert IORESOURCE_*, which have
> not reserve bit can be used for TLP.
> 
> we may call reserve_region_with_split() to split 4k region in mmio windows
> in dw_pcie_host_init(). 

By using resource_request() to reserve a region from IOMEMORY space. So
Needn't change dt binding. All changes are in dwc drivers.

If you have time, please check
https://lore.kernel.org/imx/20240213-pme_msg-v4-0-e2acd4d7a292@nxp.com/T/#t

Frank

> 
> So needn't change any dts file. 
> 
> Frank
> 
> > Currently only first four out of _sixteen_ values have been defined so
> > far. So we can freely use some of the free values for custom TLPs,
> > etc. Note the config-space is already defined by the ranges property
> > having the 0x0 space code (see the first link above), but it isn't
> > currently supported by the PCI subsystem. So at least that option can
> > be considered as a ready-to-implement replacement for the "config"
> > reg-name.
> > 
> > > 
> > > Or we can use IORESOURCE_BITS (0xff)
> > > 
> > > /* PCI ROM control bits (IORESOURCE_BITS) */
> > > #define IORESOURCE_ROM_ENABLE		(1<<0)	/* ROM is enabled, same as PCI_ROM_ADDRESS_ENABLE */
> > > #define IORESOURCE_ROM_SHADOW		(1<<1)	/* Use RAM image, not ROM BAR */
> > > 
> > > /* PCI control bits.  Shares IORESOURCE_BITS with above PCI ROM.  */
> > > #define IORESOURCE_PCI_FIXED		(1<<4)	/* Do not move resource */
> > > #define IORESOURCE_PCI_EA_BEI		(1<<5)	/* BAR Equivalent Indicator */
> > > 
> > > we can add
> > > 
> > > IORESOURCE_PRIV_WINDOWS			(1<<6)
> > > 
> > > I think previous method was more extendable. How do you think?
> > 
> > IMO extending the PCIe "ranges" property semantics looks more
> > promising, more flexible and more portable across various PCIe
> > controllers. But the most importantly is what Rob and Bjorn think
> > about that, not me.
> > 
> > -Serge(y)
> > 
> > > 
> > > > 
> > > > -Serge(y)
> > > > 
> > > > > 
> > > > > Frank
> > > > > 
> > > > > > 
> > > > > > Frank
> > > > > > 
> > > > > > > 
> > > > > > > Rob

