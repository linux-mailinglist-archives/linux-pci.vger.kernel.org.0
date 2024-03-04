Return-Path: <linux-pci+bounces-4484-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 045B8870C41
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 22:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 361951C212E1
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 21:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA4D1C6AB;
	Mon,  4 Mar 2024 21:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kkVMDTcP"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2049.outbound.protection.outlook.com [40.107.8.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F0F8F61;
	Mon,  4 Mar 2024 21:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587059; cv=fail; b=VIsmiSwy5FfZvsd+7xD/yvnjBXGSPwWWlg6CfSwECxqNYeBsVfAmqz9Ck1BViWdqfBKvFQXk3IqdyojYaynjFbpZOskNFoES0ZOrdv/T0IEI2SBBevRZmlqeItP4yuBBtNWE6pL2bSMDC48kiPTNWauineI7aTCAxy28gbJJ5Tw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587059; c=relaxed/simple;
	bh=n8tjQtXZFbAqBQeuiiFbvFJJhj4NNThDD9CfjgnV2LI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=amuWSR+DGDcUZ6Ako38sHL1lInNqtm9Z/hdi/npZczK8GWfR7cIKz+K668P5uQcOnfP9eNV9Q9AVj0mcCKHokSU4vZCVGfk0/K0nd0TrtyJ4k05FSji5ARKobyj+zpYZhaUWGYjGXZxF2xyak5yhzulVeWh/YUwjILSgq1kcAlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=kkVMDTcP; arc=fail smtp.client-ip=40.107.8.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQ8FLh4XXLGIJ/Xdf2eKH3iVcdZyRchxEglpk+0x6eb5bVQA7I/o7dJkFVDOwxquTGmmXS98gzLYaLiTPTOqGSvdwrYwg1ugsp7Nisi8EQIiGLZ/MtZkyxoJBeLKCXNXaTJyqHRf72zhK5rlrUX3FgsPIZKGIcw0j893yI6joqA7YVYnpxNvfpSqHUN/3Cte8GXN2LXx1X0XQCtqvIF6d+Sdw66DbFq6zBQGqXeg4/K2iv21P7gifQ0IHK7SNCLfwJuSTNfre3tGCf0PRuCxOLKWm6XEDYn2KxGbcol+AvsbnGBchCUHKbEbn+8ENcZt7/fZbNH0Jz88VP3BHeF0sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r8gpnRq0gAh+LFIHZ65Jq6Qu9jDtDiw2TXlRVJ/rz44=;
 b=fky9iipS5QbrTO/rcxtjL9slYQIOdhrR8qSW3P+gh67+J6gTcE5RD+N3rtNeh1NOfGRGeIWddAzCwimwZin93zMBmN2rzBdwAnxCri4GFtRQqghOC/ypEKQp+1GQMJ9AhK+Q2IdOvQ9IwuCOm3/B34duWNS4aDyvC2jwPANMlZ1ZtKskdJFEiShmhaPQirxPyjW9WFlJ1yKN78R8Q+TJeqi+ADF6Q68OfWgZefrefq6lAlwekBhhCRZ8lAYRtXbUh0FLWEOaRdpFk4gfgCLiG06Hg99oGCgwJlb4RFwP4EljreRCqdcw6U/0tUD9gTixyQDNDIgrDT3y8u382Kpw+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8gpnRq0gAh+LFIHZ65Jq6Qu9jDtDiw2TXlRVJ/rz44=;
 b=kkVMDTcPVKoGFQF52zCJTHjb1/tRKPSo1JhQJF27q4xFBb3/hDC5IGDbt+hjHJxEdWFFtAaVPCJ0oBP9bT2skCktRJEQtfzVUEsp31SFo4OIf4HNYezoesf2ippuLEQV9tkN9aENSs6V50aQgxWa1WrJn3Oe8jcjgMKnr7TSC14=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM0PR04MB6898.eurprd04.prod.outlook.com (2603:10a6:208:185::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 21:17:34 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7339.033; Mon, 4 Mar 2024
 21:17:34 +0000
Date: Mon, 4 Mar 2024 16:17:26 -0500
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jon Mason <jdmason@kudzu.us>,
	"open list:PCI DRIVER FOR SYNOPSYS DESIGNWARE" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] PCI: dwc: Fix BAR0 wrong map to iATU6 after root
 complex reinit endpoint
Message-ID: <ZeY6Zvo5TZABhWvF@lizhi-Precision-Tower-5810>
References: <20231219044844.1195294-1-Frank.Li@nxp.com>
 <ZYFrUWM7JXdv7rtb@x1-carbon>
 <ZYGmpaf18pJgM/qj@lizhi-Precision-Tower-5810>
 <ZYGq6RdCfdhXFF/9@x1-carbon>
 <20240304084841.GJ2647@thinkpad>
 <ZeX7KDuwLWxwb5Kw@lizhi-Precision-Tower-5810>
 <20240304181005.GF31079@thinkpad>
 <ZeYdV3xMWa0nbz3k@lizhi-Precision-Tower-5810>
 <ZeY3XqgUf84qAMCL@fedora>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeY3XqgUf84qAMCL@fedora>
X-ClientProxiedBy: BY3PR05CA0053.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::28) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM0PR04MB6898:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a9e7b73-a6e4-4d77-8957-08dc3c9082a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8YzyeykCq2iNSK8yKmktKY+dLaLG6boaaepU6kuVIP09loesHtZ4lHq7EhviG3C0bnKQZymlfLjSTS7Wu25A+hHRHk0wWSHZu32ZHdzXIaRbVAKlSwdHN3vDqp16B1Ekq346iuVvSEyYyJp9+yZTCOkHJ17+lXaWy50aRy7e8kLY6UU7K64WWVxCW3giM/gzy0m1nVpqC/L+k5C4gA1fZAlBOUqu44QC8wYes8Spl8Gmdc1jKuoHmgCQWGMQtsXtE9O7WjG9TCmIeaIF530cKfjOEC2kuzzBEGVvJlaWGXdB2vUVdbYU01IqSvqxYykyLYXRoxvWj3kWh8xKLYf3k2Ghum68HB0n0Fl33wOHfDhqJDakiBp4ad2e/kWQaVo6ECSH6YvEoC5dQv8AtIbtPXbfTMuB3pt8RDf9Tmxk1GaTFAUPvq3L132ki8WTHaopVqgkp9IVV2WoZXYmWiKOGtXAcwztR6LXwSycm+zjPVywT+5CN4EXib8dZyj2289yCDroqyCtURMyrFGDuyC8RwldD9k+hRqqWQE4Np+QrLCQKTwTTaxxxGboZq8fwNBleIPmHlr5nNFoSGG6mQV0YHqgXwbWRCmKtKNUxbZuDIdHpJR4smKQ3DDNTJgBm7S2m2/0Ye0yYYaDa3QIe4Lz4AtV3hzQWFgZK5UTwVLTxOyaPdRYolek/IVDckqj6mULxZNs+BKxb1VVwZkKRHlXwpIbGLD4e0mPT6DaVJkntag=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cpX3Xy7rMNOAIyr54SXfLMR9d0oo294nnOYOO/DZp2mdsCp01CVChxA5aZz4?=
 =?us-ascii?Q?OasU4TnPEFA0KIB49BwZM7WC8ckqiUNsl3d3/mwyZVEUzvQ5YReHgs7K4GCF?=
 =?us-ascii?Q?CDi5VIL1LGNaIiI06dQcMf9QCJojMcIqS+82EWgy29gbCA9ACskzJe8NLpO6?=
 =?us-ascii?Q?+4FVeGmSgUZmIX6AedJRicqrn7tpZqOjjJ+pYEZypNfKGbjL4swrDy9Jdv/e?=
 =?us-ascii?Q?6QBMk8avguCnisJpEON8yzvwOYTJKGUkUxTa4GlVg7B8/3XQ+7fjGo0S6lfW?=
 =?us-ascii?Q?U6dF8UbgOZGIVVB6WNQQ2N38ZSudB0JiraAopUeMYY47hpRRwHdYZ3ShGq1u?=
 =?us-ascii?Q?M1FsR/VLp6O2dUGi0+U5QN8+JZZm9Nen/bf/b+iQ2WAdBB2K30mJdl+kjyUV?=
 =?us-ascii?Q?AxKbv9bOb+fdMYt7bMoA+RT2DBXBEaC24y7kX/eXpJx0kii2PU5aEbWgeaM/?=
 =?us-ascii?Q?QRNM3FvgflcX50YAbr8XcaCGXZZS0xLH6945POVZAOj/SA1vniSidqCDrotI?=
 =?us-ascii?Q?XxwjQ8dSxfrsTo8Tgy/8R0H5glCLFmmMRQGcT2Ku10nt3QlHLr4DY0GU6gby?=
 =?us-ascii?Q?UeLBdTDaUrVzAPIJrPiSWveW+1WZ/updios6dLdDu5N0kqfUs5QZNONZTobS?=
 =?us-ascii?Q?Xpt4bW1ZEZXwKSSlKj3qq5tWIMAIj6Bf2WSXndm7y0w19yNZDXIgm9RzTpbH?=
 =?us-ascii?Q?12R3REx241UQF1GZES58Zxxj2NRfUpaHJVmyZwSi61fm3NKFUIT/bOhvrYkl?=
 =?us-ascii?Q?7AETZZsKbRhUcTZifvvuxhRpXzUoI4D/GFqucELfROAYLDB8Bhf0RRLtlpss?=
 =?us-ascii?Q?xCKIUcVF4Onmxx4AG3R951ltPSl1Tker33+tiSH4k305YWoGR2ZE8qKG6PCZ?=
 =?us-ascii?Q?ibmX29rWEnpkamqB6cK+eAzSzjQLjbGVhb3aXXVt8rv5HKxmNVOdqalTZtfJ?=
 =?us-ascii?Q?fw9eNQoVUxwiLfypcOt4k4sAYcraBMuw28VzGEHj68s1FAxhxhNPkotpBuWa?=
 =?us-ascii?Q?2wGq8d+y6eR/Zjv9ccEWRDtvN0FfMCkHxof1TeBOMEbj+eD8x8v7GfsAt5BA?=
 =?us-ascii?Q?W81yVHkTgvNu9TVy6cpOeju3ixjNYoo9HNcnzkPPi7wRkFaymmuc05aazZyZ?=
 =?us-ascii?Q?dojqzeDMt7qrzORxhYAG6VsIseefG6OZNplHlEAOF976uLK7aUo81cA/NqFz?=
 =?us-ascii?Q?hIMjI0AnJT07NqfVV9kCIL5u4RQql8A+Uzb/KjS5WHJeY73fyxECL/UuoU16?=
 =?us-ascii?Q?a1QSD43FMCTwEXItkOIaZNuzsnHooodkTHYA3BQuYVUyZFTzz8rL8RlAwMQ+?=
 =?us-ascii?Q?W7EqYmRkc5qprWm/wEddXT3pdtKUBZxUu+lI0Ie0l3opOP8kS/0MyUmVtSH6?=
 =?us-ascii?Q?DKsWiCCGf2Spw12y8/GzUZK+7P5DIQOBP2wmP3Gxf6i7oL0uh6I2mdrDQQLb?=
 =?us-ascii?Q?7Mb35diRk2dZn9ayfwmAhf6yDisOueVlWSqKBjHVopbtfjhdzgr+Fv75wH1j?=
 =?us-ascii?Q?uurRlcANorxNfVdDTklCoEfZFH7bJ9JvuJ8pMZkmIMRgPeTPVWZ548WDGC+I?=
 =?us-ascii?Q?AIBx5JcA0DuHIOCCnC0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a9e7b73-a6e4-4d77-8957-08dc3c9082a9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 21:17:34.5685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5IIblpv90d3SOPwMrtVuOv/P5b0QlXrlJvAaH9gkP+O1CceDWLKzcMndITkCxsHsY7Hq/J1n0UyTzfebfSL+Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6898

On Mon, Mar 04, 2024 at 09:04:30PM +0000, Niklas Cassel wrote:
> On Mon, Mar 04, 2024 at 02:13:27PM -0500, Frank Li wrote:
> > > 
> > > Niklas's initial suggestion of keeping u8 for the array and 0 as the unallocated
> > > placeholder sounds good to me. Please use that instead.
> > > 
> > 
> > It is impossible to keep u8, because 255 + 1 will 0 for u8. Previously
> > Niklas's initial suggestion have not consider this condition. If u8 have to
> > change to u16 or s16 anyways, I prefer use -1 as free.
> 
> Well, to be fair, my suggestion was:
> "If we continue to use a u8, and offset the saved value by one,
> we will at least be able to support 255-1 == 254 iATUs."
> 
> But we have this define:
> drivers/pci/controller/dwc/pcie-designware.h:#define MAX_IATU_IN 256
> (Even if it isn't used anywhere.)
> 
> But as ridiculous as it may seem to support that many inbound ranges,
> that is the max number of windows supported by the hardware, so why
> not just let the driver support the max supported by the hardware?
> 
> 
> We are talking about:
> struct dw_pcie_ep {
> 	...
>         u8                      bar_to_atu[PCI_STD_NUM_BARS];
> 	...
> }
> 
> where PCI_STD_NUM_BARS == 6.
> 
> And where struct dw_pcie_ep is kzalloced for what I assume is all drivers.
> 
> So I'm actually for your idea of changing it to u16, or even unsigned int.
> 
> If the code is simplified if we use a u16 or unsigned int (because we don't
> need any weird if (val < MAX_IATU_IN - 1) check), then I'm all for it.
> 
> 
> What I personally don't like with your patch in $subject,
> was that you changed both dw_pcie_ep_clear_bar() to set the "clear value"
> to -1, but you also need a
> memset(ep->bar_to_atu, -1, sizeof(ep->bar_to_atu)); in dw_pcie_ep_init().
> 
> 
> I much prefer to have 0 as the default/unused value, because it will
> automatically get set when you do kzalloc().
> Seeing a memset -1 just looks a bit hackish to be, but I realize that
> it is personal preference.
> 
> 
> If it is super important to save 8 bytes from the heap, then I would
> even prefer changing the MAX_IATU_IN 256 to something smaller, like
> 127 or whatever, just as long as we don't need that extra memset -1 :)

Okay, Let me work on '0' version.

Frank

> 
> 
> Kind regards,
> Niklas

