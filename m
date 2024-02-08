Return-Path: <linux-pci+bounces-3249-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59EC984E992
	for <lists+linux-pci@lfdr.de>; Thu,  8 Feb 2024 21:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10AD32904F6
	for <lists+linux-pci@lfdr.de>; Thu,  8 Feb 2024 20:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F197B383AE;
	Thu,  8 Feb 2024 20:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZrYykj4P"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2078.outbound.protection.outlook.com [40.107.20.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381B2381BB;
	Thu,  8 Feb 2024 20:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707423665; cv=fail; b=WEpoUTrpLs0aT53ixkF95gsrFJM2LRhtSqEj39QgJmsB/v6NgeSqjJUaFZ7xMuv5z+n07MF3QGlMjNX1GPJTk8eJfXgwF416wb3C13RW+Zpnced+lwLQt/++3RaW/RtBAbco87ZA+R1yjHu4t/CryJBrWHbYax6oCmQ8t3xZ++U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707423665; c=relaxed/simple;
	bh=OjSEbZJPVPbCDsdWEpWvzQtuhAxjzJTJ2DLMue3pLAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PZ1Gj0r3xIJgvUm6tdy0+KiUyvcvhg9opTNTLNEf+lyA9L+REoplHB5oKqTiPxuURjOfJlet/jAr9OHipJDC8AlDq2C8u72ltUDh2wng5tm/LmdzIbC2UR3XWeri/RSWCsJjkkgeXUY5/hIgXF3IQIpxgBe3fxhPVh49x0FMVW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZrYykj4P; arc=fail smtp.client-ip=40.107.20.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RiAC1WXTf6gccjKJiV5JIlaJvX9Z199r9A/ptJpe2uTPvXO/W0GoqSbqfV57LravtQ8yd2dBbwgW85gEscfoPPcpp9ZjIsUGvr4WTv/GEfkAjG++snQEe7ppAJQoaNwNIEfAK2vHjdITYtoYjrTHZExq3lfAkQxQmZ5+rmj/rswQJsHwKXzsZSTUeJchZqYALcs2X1zEEbev+A+Nc6vigBL5bpZLeIE7BDkI2VLyaKxQ7sgXUVxPDlnOpttj2KFyyHZEQoLj32sK87fLkWS9kD0L4KB9GRQv9+yBNynK2bAcdkW91egDgXNv+QRlWjBfzdCT2+yv5hlkG8ECaXfagA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmbzA3kh+aTZgvbqXK75tBDHqNHcrB+uXSKG0WsMIjk=;
 b=lxu/o9kDRbVzzP9KNvdZhk/BLM6O2BKlSxXJnGwLz3au9FfBb+J8IrQkVVjYv+d6ObG6ZRnaCQxR+E2c2R+xvWlci6EpxKJcL+vxhsBkNrqMbNqBpLZTUJkbaioM+CJKZeyR4dyp7DwyBPxIfCA9bO4P5oM6L2VtCPT65+5tykZDKjbuTYuxn3DWurfoMaK+vi1MNOqO2htHRV5S0arXhLagMnTX70kEmrUNaCBQfC063hfORbDO4sDZGeOvmiXeq6e30OS/zwCNMJvY6/VI1WQopMUfYjfMBlfINTKJePHLOBPI3jmTWbJBDzlyuesvKlsicnki3/cmZneXUFBA5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmbzA3kh+aTZgvbqXK75tBDHqNHcrB+uXSKG0WsMIjk=;
 b=ZrYykj4PwFUTw4UvrXTFk6qAAD5y7inan0Lj888gyDO3GIZQFAeUfAa133ndxJH/7X56+7MmnLzGYihuR0oBjbPRYQe351tYdVPQuxmow28tWCFLQiSUPQl6jGZMkA3FGD69E6CqtvJfgmm968U1e22iqyQ9tDba9puYRIoCG98=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8402.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.39; Thu, 8 Feb
 2024 20:20:57 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.035; Thu, 8 Feb 2024
 20:20:57 +0000
Date: Thu, 8 Feb 2024 15:20:50 -0500
From: Frank Li <Frank.li@nxp.com>
To: Conor Dooley <conor@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: pci: layerscape-pci: Convert to yaml
 file
Message-ID: <ZcU3ohEg5Z1ky+/W@lizhi-Precision-Tower-5810>
References: <20240207062403.304367-1-Frank.Li@nxp.com>
 <20240207-yoga-mobility-90a728f6342c@spud>
 <ZcPCn8q7viB/qcOH@lizhi-Precision-Tower-5810>
 <20240208-jarring-frolic-8d4c9b409127@spud>
 <ZcUs16+Z+I4m4q00@lizhi-Precision-Tower-5810>
 <20240208-revoke-doorman-5ba34f39c743@spud>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208-revoke-doorman-5ba34f39c743@spud>
X-ClientProxiedBy: SJ0PR13CA0115.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8402:EE_
X-MS-Office365-Filtering-Correlation-Id: 648423bd-3437-4c70-74f9-08dc28e3758f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CTfX51Fdi5HQzb18GyqYC+h1jb3nsGill33duEl5gpt2XxKQsQ23lQ4ife4itWwMv9SAEVIXtweeXx3XqydP2shI6aSxyB7Ln/S3mUzu/3cRwsHRjNSthVZULf1Qc1qZddPpsn5cDQtoljQdAe/nTlkwK8Yj2H4n/i7XU2I+fCC+hmG9vKGQ0xuWsfNq5xxrbkCoJgcfcGp/f3RT8uQXdxNhKqYO0wFgEbSBG+oYQe3hFLAwi/xB6p0937/ZVFRlPV5Vm85SH09CdKOGWohcAzHDtEyX3Q6tlS4/KEKj1+ve9GbpnZUOWhKrtCCQg/R5GMr7g/22odGwZXdKoGNYqSMTp/27f2XBpjgSCfybLX49cfFDXy8N/+Q+XZgLxs6OezV8txclG9nDlGyV5HeoUF0i5WNXV1C7/wDILdhmhexb9RBcuSYtfBtKE2nOYerL5021QbETzU8ds3HjMFK2s+7JbcRGUYLSpCqMKz4qyRV+JQ95gyekoVkVbXkK+90K1titUA+mlV6QQMbfTf4dQZC7x8ORbP+4o7BhV1d2BG/6SVRfgwWGDDwjc48B0vZmKAG+zl7QpQQZJJitRXjGxBcRoattEgSTLC6QPEXH5FX2WlTyp2gya0I0xWq2tLnc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(346002)(376002)(396003)(366004)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(7416002)(2906002)(5660300002)(66899024)(41300700001)(33716001)(83380400001)(6486002)(38100700002)(86362001)(26005)(6506007)(316002)(66556008)(52116002)(54906003)(6666004)(478600001)(6916009)(6512007)(66476007)(9686003)(66946007)(8676002)(4326008)(38350700005)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RcHzwHFCcHFkeI6+IsugqByqoDwZ3heK5UMUtD/rycf68WrRXd8SBTZouxQy?=
 =?us-ascii?Q?H5tcgwXf3FnszuxbrjF9b918NhAkMA093l/mwxqY5zSfZX7AgyMLOKMxBAZP?=
 =?us-ascii?Q?V1LOHcpKDmjja+TGEPICaXcj4w111KiNrxLFwZYEpiHNHCPLv8Re8rMDnM1I?=
 =?us-ascii?Q?+lzwj+kUFygF0kuxsVM8wgiCO2ZDP6rVjzJpGGytxke00lB5dpuSGU8uetxM?=
 =?us-ascii?Q?xUeZ5SWFYPFB9nqxaBmGesVLWrKl/C/14fwmqoIEWh97pxFUqffUiddbPVdB?=
 =?us-ascii?Q?aN/uIJ5zpY9ZThGWbOKummTUFMM3ox/sVSE2mrRpUOlPGUQeyfoZrRWudN1e?=
 =?us-ascii?Q?WClTe5jrM1hwF8y/D6uxHL1G0AbWDTBi/nATsjYtt0HaEkOKSBRdjWzM2hIu?=
 =?us-ascii?Q?6oXxi590iW9SoavUT406crGiuC8Vu9u0B5xkvmsZ7Hl75jflKLp4BaQMMkSR?=
 =?us-ascii?Q?nHFuTz1y38cbcQia9nSqhQFeJobZIFALyyvbvRDDqm6GT5DqOIteVhOwu0gW?=
 =?us-ascii?Q?Uera0pWFUgzZgNHpsNZ4KgIJc8rCzDyUCA98Ef83N8bfsAhc9GZfPJosWhJG?=
 =?us-ascii?Q?bxcU+z699pIj/gvm5HR2Kmo/DwdOiUprkbK7dc/tRN2PYAw7b91B6wXeV8AT?=
 =?us-ascii?Q?/lzmeKJ10v3cVjdUYj+sv7nJaxevVSMNgyvuU3NSWdmaFUv7uk+1bmvlUX9/?=
 =?us-ascii?Q?etZjlBoKcXsN3gmAkjYxEa3tEA6hDWR7qkGorlYRvpJvuH4m0x1vB0imEfLT?=
 =?us-ascii?Q?5CAJ35qLaf6SFvPDxGtHokF59xU5MfCaED46cNvZKdtDS+ciCYzhPK9tqTyG?=
 =?us-ascii?Q?6xZ7LCVtWpYGGFZcPbeyvlSjSeJf5jx4lXvbKg8f0DKkZKZCS9X/W1ZTdw5e?=
 =?us-ascii?Q?HCdV7wox9/IqAJTmlh0O5NT5m72SPoSPSSH89KQyCKDTJ/zL/9TyqQePHPdT?=
 =?us-ascii?Q?vNQ6CZSxU2yB5uIo3dFuC1ChiSsJz3Zq5q0cQ5jDuyNM20vmV+NS1exUSrzX?=
 =?us-ascii?Q?qEYs/drtETWG7RZv9FC2RWcqASeFN51zIO/hI8jo8REhbEQk/ZPJ8fWaKauU?=
 =?us-ascii?Q?r8ZoLBYyhZJNVhG0mf6+Iw2T0OqlqX6fRQFOo8qX2tesTr5Vt/935/eHm2WW?=
 =?us-ascii?Q?AWU4pa8eUV5L9RV4hMDdHVwLFRMP+MGNRbl8uunKuySkxLmpM/cwso3HXx9Z?=
 =?us-ascii?Q?l5XbepMoVdUpFek4lt24F9VNOLgojTuj5JeP5bjgcl8gDH1jTgtNP8S2I9sO?=
 =?us-ascii?Q?tAapgcCmu1ioR7guqXr54HtCc4lZ8HF0hOzNqwXXYKXbVb2QONB7Cvsebm5i?=
 =?us-ascii?Q?Jn4+ZtwVWIwfTj+qArpyUZluYvwIpR/79FQsPqVdq5pGZ1T28a6kJSIcMiTg?=
 =?us-ascii?Q?d3fhLjPLFFuCKozyrL4yyG2Xuud/GRIL1sz0V/SDSE0lLc1c3K+cre4syp44?=
 =?us-ascii?Q?91ab2RAhH5QxTrZRqpX4TlBQhs6xnh73e4XEGkkpRDg8Toijy7Lq+Vz0I1zH?=
 =?us-ascii?Q?q1pAGGQb5Ap94LD3bIzMEtGtnueyPaJKPKz8WMaivNxYocuFkwwx3sb5tHdT?=
 =?us-ascii?Q?xxrVvI/nYTEV3CaPtfzRU3N+2BqsX9Uu0KQoHAgx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 648423bd-3437-4c70-74f9-08dc28e3758f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 20:20:57.5804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D/yErgZ/dGQHIEwqixoXUmOOwSnJolSYPoIThhRu8km8SoPsHWpY4pNf/LW2wdNxN75cgzdZf4I+ZSvB2CdYvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8402

On Thu, Feb 08, 2024 at 07:44:59PM +0000, Conor Dooley wrote:
> On Thu, Feb 08, 2024 at 02:34:47PM -0500, Frank Li wrote:
> > On Thu, Feb 08, 2024 at 07:12:47PM +0000, Conor Dooley wrote:
> > > On Wed, Feb 07, 2024 at 12:49:19PM -0500, Frank Li wrote:
> > > > On Wed, Feb 07, 2024 at 05:17:55PM +0000, Conor Dooley wrote:
> > > > > On Wed, Feb 07, 2024 at 01:24:02AM -0500, Frank Li wrote:
> 
> > > > > > +
> > > > > > +  This controller derives its clocks from the Reset Configuration Word (RCW)
> > > > > > +  which is used to describe the PLL settings at the time of chip-reset.
> > > > > > +
> > > > > > +  Also as per the available Reference Manuals, there is no specific 'version'
> > > > > > +  register available in the Freescale PCIe controller register set,
> > > > > > +  which can allow determining the underlying DesignWare PCIe controller version
> > > > > > +  information.
> > > > > > +
> > > > > > +properties:
> > > > > > +  compatible:
> > > > > > +    enum:
> > > > > > +      - fsl,ls2088a-pcie-ep
> > > > > > +      - fsl,ls1088a-pcie-ep
> > > > > > +      - fsl,ls1046a-pcie-ep
> > > > > > +      - fsl,ls1028a-pcie-ep
> > > > > > +      - fsl,lx2160ar2-pcie-ep
> > > > > 
> > > > > Where did the fallback compatible go?
> > > > 
> > > > So far, no fallback compatible needed now. each devices already have its
> > > > compatible string.
> > > 
> > > It used to exist though, have you checked that u-boot or *bsd etc do not
> > > use the fallback compatible? You also need to mention your justification
> > > for removing it in the commit message.
> > 
> > This commit just convert binding doc from txt to yaml. I just make sure
> > which equal to what descript in txt.
> 
> The text binding does have a fallback compatible though:
>   EP mode:
> 	"fsl,ls1028a-pcie-ep", "fsl,ls-pcie-ep"
> So this is a change compared to the text binding, without any
> justification for it being okay to do.

Okay, I see what your concern. I think old txt is wrong. Or try to work
as it, but actually not. 

> 
> > If there are someting wrong in "uboot"
> > or "bsd", we can fixed it later.
> 
> If other bits of software are using the fallback, you cannot remove it.
> 
> > I checked driver code. exited dts tree
> > under kernel, which use unexited fallback compatible string
> > "fsl, lx-pcie-ep", which should be removed at dts file.
> 
> What do you mean by "unexisted"? It was in the text binding, so it is
> perfectly fine to have it in the dts. Given it has users, I don't think
> you should be removing the fallback without a very good justification.
> 

No driver parse "fsl,lx-pcie-ep". I can keep it as equal as old txt file
and remove later if need.

> > > > > > +  reg:
> > > > > > +    maxItems: 2
> > > > > > +
> > > > > > +  reg-names:
> > > > > > +    items:
> > > > > > +      - const: regs
> > > > > > +      - const: addr_space
> > > > > 
> > > > > The example uses "regs" and "config". Where did addr_space come from?
> > > > 
> > > > Example just show pcie-host part. Not show pcie-ep part.
> > > > pcie-ep part need 'addr_space'.
> > > 
> > > Okay. Again, please mention where this is coming from.
> > 
> > Ideally it comes from snsp,dwc-pcie-ep.yaml. but it is use 'dbi' instead
> > of 'regs'. It needs extra effort to make driver code algin common
> > snps,dwc-pcie-ep.yaml, and update exist all dts files.
> > 
> > I think it will be deleted soon. 
> 
> What I am looking for here is you to explain in the commit message that
> the endpoint driver in linux and the dts have always used "addr_space".
> Checking that there's not a u-boot or *bsd that uses "config" would also
> be very helpful.

I confused. Actually this two part PCIE-RC and PCIE-EP.
PCIE-RC using 'config'
PCIE-EP using 'addr_spcae'

I check old txt file, which have not mention it. I can remove it.

Frank
> 
> Thanks,
> Conor.
> 



