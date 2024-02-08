Return-Path: <linux-pci+bounces-3255-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C21AE84EAA9
	for <lists+linux-pci@lfdr.de>; Thu,  8 Feb 2024 22:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE72DB21DF1
	for <lists+linux-pci@lfdr.de>; Thu,  8 Feb 2024 21:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BA34F1F9;
	Thu,  8 Feb 2024 21:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="J4QxBdDZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2070.outbound.protection.outlook.com [40.107.7.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44934F1EE;
	Thu,  8 Feb 2024 21:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707428071; cv=fail; b=EU5yjlJ5a98WS3iY+ZwXGmRaXRiDFN/ngOEFjDyAAp4X5lgUTiTQZoa0Hc0kFWyxbeJj0z562f+iQaNzLqEUWgTWpjRfQL7wsZ20DoxMz1x114ZxV0juoTYwTsulPWzFlOELGn0NXDI0tSrtuEjDvx6sjQzRISJW+Pl9PLLiqz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707428071; c=relaxed/simple;
	bh=v8ViK/zXgvmp1nE8bSApbcGwXDudLTxpMT5Dve4cz4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=chUFvtnYk34E+Q0+AuS7ZE+ekfr9A8Ib0PJez+YzsH+64ycjfKhi2aMsUSEofG6FhAvJV3dtaxfGwrBVmNeDGOjKD0TYRJ3ZOBm2eyrlfvzRLE0gbVdJi0l5vz8vq/o9FRe+//LkYk/d1Naq+CEdrKS+V64OChnEfGXOk6LalDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=J4QxBdDZ; arc=fail smtp.client-ip=40.107.7.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cIkXsMxKRzyRn3nJXbB8H+n9iLLR5xasegyZ3jaS2hccSoG/metb2YxixzTm59gP4eYCuxvuohYsUOotHA74Q6fwPww8REPPlYQt51eAO80brDuGCcq01u9bZVkJoltgIWRSEgy/EVROcMcH689zvcKOKWPjJdmgkwna6pmgR+9ebNWPiIFkha4t9XZSC3/wuirvE/jSQqcstqRMspivt5zHLU5oCLtr88SCkmNBSNuzFJCjFJdu2zK1GuI1UX+TGkDzkRNbkLHZA7CuQGwuJMqs/upkzjH4CdeADLrXtQoNej8QocLaAXQxhbzTCSfG6ludj29oWsAlioJyAfKH6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CALB6I/jXC0eWOE0hO+JQn2KKK6CQFd3jUjnPxX/78g=;
 b=lTvtVJmQGllJrcUFhiurgdrj+UtypTCeImRiPQoDFiOG+wQKDNti0WaknF5MWyBgYzQCRDXGY3qFea/wOMTcHrT6KVJE3fe9s/erlzAJDIV/E4TpECiu3Hk+TwJX18fUcOCThei4jh6DzMVXEqxR9BpaHdGAO0CnLu1K/ye94KWaRSy9ApJWSs9TqRZhCSVd2Sou1K6AqMzESX7EqQLI7uW8ivK0YhMidfb175Ff002KYDzBZ0vht5NhIrUZzKcHdtpnNYvyyw0EAZ4obVTPO1BZ9W9QuS62/b965ybLjzxUCvM20CSx7SjxlR3kVIjBoKrXg2+WCyQVWiSZ1ErVEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CALB6I/jXC0eWOE0hO+JQn2KKK6CQFd3jUjnPxX/78g=;
 b=J4QxBdDZHNYanw/cCvQ6qm8mF7ltXlDoc7kfx8HwHDLm7AhhK/ChIld0cF0bO7kFNmTDauUBA41RNUTnlP0RIq8+7NoAUGMJSrF7tChFEnqVODQwsFS/ANIjRmvU2lRkSgk7lMw1U1qYhYFF0zmITmIojJntRz1MNMlXI/VU5T0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM0PR04MB6787.eurprd04.prod.outlook.com (2603:10a6:208:18a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.43; Thu, 8 Feb
 2024 21:34:26 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.035; Thu, 8 Feb 2024
 21:34:26 +0000
Date: Thu, 8 Feb 2024 16:34:19 -0500
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
Message-ID: <ZcVI23X4T04cFyJL@lizhi-Precision-Tower-5810>
References: <20240207062403.304367-1-Frank.Li@nxp.com>
 <20240207-yoga-mobility-90a728f6342c@spud>
 <ZcPCn8q7viB/qcOH@lizhi-Precision-Tower-5810>
 <20240208-jarring-frolic-8d4c9b409127@spud>
 <ZcUs16+Z+I4m4q00@lizhi-Precision-Tower-5810>
 <20240208-revoke-doorman-5ba34f39c743@spud>
 <ZcU3ohEg5Z1ky+/W@lizhi-Precision-Tower-5810>
 <20240208-outing-nature-74b6fab0cdea@spud>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208-outing-nature-74b6fab0cdea@spud>
X-ClientProxiedBy: SJ0PR05CA0079.namprd05.prod.outlook.com
 (2603:10b6:a03:332::24) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM0PR04MB6787:EE_
X-MS-Office365-Filtering-Correlation-Id: 618fbd39-fcbe-4126-812c-08dc28edb9ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	z+q1Cl9iHhlGO4XWcCGmhPt22b76kvb1MFTiJeCdiHgm5DMHQsjAy2bSBqWWRNaSBbrjsQExw6/YKnHAEefH9BlMx2UF/FOCUcGUDpCd6/m532u4TRtoIbCMh4FR1HVAKB4tFUCf0hhMqqwj3+WDTB3iHSsoFTTnZoWb2DnyVRpYLD5rJ48l5ZQ97s8+rxL8t06K8DGxNu5GMHRiFBtBRtanHnx+rLcMLtSFoMv7jdYQx3lecy/gHB4kx1uXoMxH9Slgw5Ih5yOA0iziNCHtCaGkBWw+KJW1xlSXE3uzPkfQyvBtAjWRXZoFUgPMes0XO3N+Zi6eGtSgTyBRj3mkQqtjz7CDpq1NcvUN6uMrdZEv7LX3goo1Ew7Xc+fPCFR3mmwq9yCe6v+O5uT0WPZit+Zd4OH5qYKioDjV57YDS53tzDaIlXE352i2Dd0SEP5XFtj4cZpkXgOzsi5SfMLKAIUW6MeJjT7IVKHZ2M5CoCQyK+J0QNrjMm308I1ekie1PKEFai6R/B27Hhs1yME1RYk59CTfjDIXD3aulPiXk5mnPo7rcTL/bpJ/bm7tn06p/vP/nBA0UgeJ/lnjA5Ec9uJd5f1La/5+/mUq6lUliCcYrKQ/4WzziJBCGyCxf8Rk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(396003)(136003)(39860400002)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(83380400001)(66899024)(41300700001)(86362001)(33716001)(316002)(66556008)(54906003)(66476007)(66946007)(6916009)(38100700002)(6666004)(6506007)(6512007)(9686003)(52116002)(6486002)(478600001)(5660300002)(2906002)(7416002)(26005)(8936002)(8676002)(4326008)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GrKkqjwKCMieODccLpwiRMuoDU4zQ6zVFFuCQhmX0q0GKaVFO69ZvWO9FQmP?=
 =?us-ascii?Q?BDD96ZLsK8fePuWk+LYBHBp7Ihx8HXqfIRo9/bzVynKlc1R/Kt4bcMyMiv/W?=
 =?us-ascii?Q?sxIP1Eu311UP8xYELcccKj2eyRS02aifnON6xwtisNIghI557SAXnP07TWLr?=
 =?us-ascii?Q?T2Duq2YWlOE9xCPHu7zM0QQSU+nVDRoG150dn8R/K+0CO2TpCBE8SkT2qWza?=
 =?us-ascii?Q?6QkKbzxCbm2pf5IoA6F1PRQ0/PdQJqJuQKQWgNG+2hX3Zq+ubW44AqiOiFwx?=
 =?us-ascii?Q?A4Ay4vhyP7OuOODsekXW62tst6SRNlOowB80Zgnui5syOpARcqpFYMHGJkUb?=
 =?us-ascii?Q?8oDZ8SAqnN/xYYAIpIduIqKIABSr8spcuVYXHU/k4X5dat2OJ+vLfNGtiZN6?=
 =?us-ascii?Q?BFihLs2FqCpc5w+0+DTBlezrF5OGhUyGBgrdIGxsnlS4RtyR40MhCLKmpXhT?=
 =?us-ascii?Q?aOpD4Pk1dl8N35ig/KmN+1JgzCjCJDqUDZiVjbN1su1Djhp+IuDdXGITzIDf?=
 =?us-ascii?Q?B3XTFwx3dVeKml1L097hefLb6RrZZSJbg9twUt0+2REXi+SAFyAbPqAqrFPx?=
 =?us-ascii?Q?id52RcW2ytM5DgD9p9egT7wstuZ/BO1MLf4XH1JuTdPUOi1dz697PkGVqHo8?=
 =?us-ascii?Q?j3l8UQboEzuhZMWKLZsLCEi06hRnGWf4M8HUujT4h/rWIIc2ealIvwdzaAYp?=
 =?us-ascii?Q?1m4gybCd8+mNz5XtdRfPHt2P0pAntOyytEGt1HApiJeVrX2XJJ3HICAIDJB/?=
 =?us-ascii?Q?SoIyMxKAFnlrs1jDt4RLIpyW8ldEhjbJ40/7CVw08t2Hv1ujdDKO1eiG8z87?=
 =?us-ascii?Q?Vxqtw5rWJcVX0zUgCsptsAnaqmSUeTgKltrJsCO/HK2yUOXcCYGtcppGx1KS?=
 =?us-ascii?Q?zu0CN0yPX1KLsjs0rWIgX/QZKmyUzRKWiRuSQOtNtj9CO4Yv9ZBXSnoZ7Dw1?=
 =?us-ascii?Q?VoWQfAyum16At8UYmk1DAL3TMnKaKHKt2t3kRuHigOCAU5d5QZop55WrmkPn?=
 =?us-ascii?Q?ON4Jw5xckGd9BTAqRpaXSvtkNTburSNrnOwP8I1Y3D99VYC0xE7BuTqr8fr7?=
 =?us-ascii?Q?TyA6R+w32DKuRpXyWEoR/DOxqBKmx9vae6eD0bPyBJO0gKqByKdLKo+z77Kk?=
 =?us-ascii?Q?MjKb1Wn3hCZOuudQgr6KzYITFLQ3O2iJUbjD4lALYSXbkkWdkz27QcbAzSWh?=
 =?us-ascii?Q?n5CVZTlxfahTGZkI4GWtDVZw1YZDGzE+cWR9+is1AIxp8G/B2Z+Zk2+2HVpQ?=
 =?us-ascii?Q?bIcD4jPw3RGzjEWzH//5+U9obIz7/BkglzvipkGdefWsjI3UpneFFIhOUBlw?=
 =?us-ascii?Q?vo3V/8RA5eIMdAde+E87gMmXpN3mVy1WAbX8IVQl29UokLAbN9xa+s9MzgyK?=
 =?us-ascii?Q?EW+oSLbnFeMy6ys/kE1qGRJmi9qDkxjQkyaqZKsO9cOXwIJ/DE2mMHiLpbJu?=
 =?us-ascii?Q?Og+rdIs6LFLopIXEck6uLzsqvt/SNsTsBJtn8Ri4aG5AjbzJqOJeXsSgFvst?=
 =?us-ascii?Q?mDuGR7QocLs4iRryjMl6cSyllefSbmViEsiEqhJCpOv+aUum5vI9fxXnlOAc?=
 =?us-ascii?Q?ukyp/79IFWg/sm3tWFylVVymKzU7FSZbBq+9vLki?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 618fbd39-fcbe-4126-812c-08dc28edb9ac
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 21:34:26.8105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1HvZGQrHhIsDNgCQe3Pgw75dInETlShDjDe59ZNrU2c2sf0ytynandrKwf+MgJISX+wTpWSalSt5/eDHK4sWOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6787

On Thu, Feb 08, 2024 at 09:20:08PM +0000, Conor Dooley wrote:
> On Thu, Feb 08, 2024 at 03:20:50PM -0500, Frank Li wrote:
> 
> > > > > > > > +  reg:
> > > > > > > > +    maxItems: 2
> > > > > > > > +
> > > > > > > > +  reg-names:
> > > > > > > > +    items:
> > > > > > > > +      - const: regs
> > > > > > > > +      - const: addr_space
> > > > > > > 
> > > > > > > The example uses "regs" and "config". Where did addr_space come from?
> > > > > > 
> > > > > > Example just show pcie-host part. Not show pcie-ep part.
> > > > > > pcie-ep part need 'addr_space'.
> > > > > 
> > > > > Okay. Again, please mention where this is coming from.
> > > > 
> > > > Ideally it comes from snsp,dwc-pcie-ep.yaml. but it is use 'dbi' instead
> > > > of 'regs'. It needs extra effort to make driver code algin common
> > > > snps,dwc-pcie-ep.yaml, and update exist all dts files.
> > > > 
> > > > I think it will be deleted soon. 
> > > 
> > > What I am looking for here is you to explain in the commit message that
> > > the endpoint driver in linux and the dts have always used "addr_space".
> > > Checking that there's not a u-boot or *bsd that uses "config" would also
> > > be very helpful.
> > 
> > I confused. Actually this two part PCIE-RC and PCIE-EP.
> > PCIE-RC using 'config'
> > PCIE-EP using 'addr_spcae'
> 
> Yeah, I get this. The text binding makes it seem like "config" should be
> used for both RC and EP, so I am just asking you to check that there are
> no drivers in other kernels or bootloaders that use "config" for EP
> mode.

There are not 'config' concept for EP mode. Only RC mode have 'config'
space concept to get PCIe device's config space. EP mode only have
"add_space" for outbound windows. If other place using "config" for EP, it
is totally wrong, they should fix it.

> 
> > I check old txt file, which have not mention it. I can remove it.
> 
> if you drop "addr_space", you'll need to update the endpoint driver so
> that it supports both "addr_space" and "config". If there are no
> endpoint drivers using "config" in other operating systems, and all the
> dts files use "addr_space", documenting "reg" and "addr_space" for
> endpoint mode seems fair to me.

It is up to how to create patches. "addr_space" needs. If you want me to
create one version, which 100% match original txt. I can do that. Then
create increment patch to fix the problem.

If want to create a basic work version like this, which included some minus
fixes.  

The both method is fine for me. Second method just need more efforts.

Frank
> 
> Thanks,
> Conor.



