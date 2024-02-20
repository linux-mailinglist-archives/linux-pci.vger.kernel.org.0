Return-Path: <linux-pci+bounces-3787-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D83AF85C13A
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 17:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E3F5282BEB
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 16:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CEE763F9;
	Tue, 20 Feb 2024 16:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jUxzYI4v"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2079.outbound.protection.outlook.com [40.107.249.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4DC76414;
	Tue, 20 Feb 2024 16:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708446102; cv=fail; b=MMi2qdf86LGJNUr+cvuEo/J0WW6ZNbbyw+JX2DBPL5g4wOvGbZVlL3TgqnUQv4k7Nh3KWgBfGwOsi6rY/cgad8AatzdwKS1MLK+EueUkmyyboyP5Np1/2Ra0aphNQKNugagD7f6X9r2GPHkEoGcWAG5r3vuFa0AFisOrCyJa41M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708446102; c=relaxed/simple;
	bh=jlpxR3c0uFnpuSs4Ti7ah8uLgDw4Zlt5sLYdmbQaRSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Jge+hjBK5YhNZCAcmGvOjFCaeEi6u6db+6cQYB4bCtAic/jW+4jQjImQ7XBhlFx7V8IL9TDiltpsMfVOZTcu6xdlPd9ZpgwfeFshpUV10xo2QIuh8OAhlwhVUAGyn2WYISEHklMudSD6IOwuzb2NF27uSzIy4PwxQ9qc7p/HH6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=jUxzYI4v; arc=fail smtp.client-ip=40.107.249.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fK1GnFb5pwWvdGOJKlcppEfuNuMUZ69FUEz2scvNVHXGjWH9wjsiTJtFfKMQNpSYSwqNnDf2FYwv1lJ7JcdjKmyUmOP3mj3zP7Ba5d45yhngwOZZYcWMx3usrHfMGxEl0xjJTzB7UcxPdp89yRaugUC0jeut0rMCX2I5WD4Rv3AzAZJgK4baAAHgW9sRqDLWC6XB2Kcb5NCM1QcjWnELAqcULUCD4aNfPLCVJx2OEDLoqOaYkhzrHBnceYFKiTbxlHkPfJjJF8ZXN6sCX5AAoxghuEUBg0B1ehcyOz3CEaulW0X+DLVCq5Woza3rluRdoCLLz3TuVrJO5iGyKk4Rsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9GM3Duel1ZjHQynd8B9Di0Xz7JBg7rYa4e01eZVKTwU=;
 b=HtSAzMkPYW1AdNo8Nvr9FeDmXT6D4NthnM4hQS0ZMa1OFcb2YkiuwwhKZLADGa00BA48tZShNOEmj6VhK6oFwxfTp9Xptf7ypTMwXT8YgmdtlOL3AQSJ8BJV8+yqxxpil/qSNuCGzFjJmCbd9N4mc8unTdj8G7WovYLdcDz/XfhlBPdG5STlnF2pYq03Wa+/tB9tkWvIZa77gJdoLQSzEwJyflYHNsYu/AV1hxRmp1KBb6FOOG02MDHU/5SUUU1WE/bsRkTqunohNFRmbp0lB98NXwInVgJ7FN8BKmJvudLr3uefn2adlQeSuYMT2YDNQpp2KfChWROoH/rEqud1kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9GM3Duel1ZjHQynd8B9Di0Xz7JBg7rYa4e01eZVKTwU=;
 b=jUxzYI4vP723Ej7TR/eF0uTTgNO8wlnsq7YgwFcvaQ89mySDnWRgZrP9FXc8t6uB1DGrTUghd66Kpn49RwL8AR3aPKFZhtbubyxSCqRW+Hub4tzhvTDrOWMkLLPAdyP7O8ZZNA2dKmNfl23SOKfgqCEjK6W3DOjPY41Cxrtg8N4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VE1PR04MB7295.eurprd04.prod.outlook.com (2603:10a6:800:1ac::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Tue, 20 Feb
 2024 16:21:37 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 16:21:37 +0000
Date: Tue, 20 Feb 2024 11:21:28 -0500
From: Frank Li <Frank.li@nxp.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	bhelgaas@google.com, conor+dt@kernel.org,
	devicetree@vger.kernel.org, festevam@gmail.com, helgaas@kernel.org,
	hongxing.zhu@nxp.com, imx@lists.linux.dev, kernel@pengutronix.de,
	krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
	kw@linux.com, l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	robh@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: Re: [PATCH v10 00/14] PCI: imx6: Clean up and add imx95 pci support
Message-ID: <ZdTRiB9JdQSvBwKn@lizhi-Precision-Tower-5810>
References: <20240205173335.1120469-1-Frank.Li@nxp.com>
 <ZdNvsdao8jbB/52L@lizhi-Precision-Tower-5810>
 <20240219161208.GE3281@thinkpad>
 <ZdN/OyNpw0Xa7qXG@lizhi-Precision-Tower-5810>
 <ZdR2FRQ9Fe8hhK9I@x1-carbon>
 <ZdR6EUOv6hzLEmUa@lpieralisi>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdR6EUOv6hzLEmUa@lpieralisi>
X-ClientProxiedBy: SJ0PR13CA0099.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VE1PR04MB7295:EE_
X-MS-Office365-Filtering-Correlation-Id: 04878f5f-9911-4f61-3c43-08dc32300346
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HMl4Ksj+OuJL7wB7MGayak3oclqRKxPQmm2iiH87LKAispUO3ZzR1bSjdoe0KYKogD1hv4KN8f3eNwkWZ27HUbRAyw09VCjVu0RwgJvwugJHtm01TySVCQiPwFQ6S6Uk1GxJ/LAw3BSvE5web/mczymlHSYvHmpl9VEl6nE9ZotyoCx+Spvkc/b2eu4B/JoQ5dmsyyGryV+EV8yN845+Irzcv2cHm+7AZrKlVDGAZMavi+o3wZmH+lRzozOQvDz/nvM5RlQ4QvPYEeM4DLpQoT+ZRl90D79Cl6IbqDOpXQR0FVnGiFJZVAhShHCiuxNdSLwMPPrnNyPrkacQy9Gz/QZFOZytbfibdgdfBLDXW6XWG3NArj5dkXOwXcuDpyu0eXyOupzvItsgS/BJK0GNcWIcZOf4Aq4Mq45S6VpBWlQ3mAbgv7DIpkhy6M7ZyWcvtHXaAzbUc6FxFMu/Hvq9RIcqPHDX/b8dSyO0wOiACFxGqUZ9TiHW9npsn6V4TY2y/SkiQcxaN94td6kMxRn1vBTmcMm17KEH0f9sk/vyCgL2w77SY2fhz3F/iJNT0F21L2OlntwJ6OV34RD1syv0SWvOCMSFllq2suaFS66aB/g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aQQuFkXLJ/AALZfVRwkLE0swZVhRNqJ8g/DlIqvfJA+zJxes9Z4bNoX57GH9?=
 =?us-ascii?Q?z8FHUcK6OYA/TrdXTryxpAsioli75+3rG7ZCUD68Rt9UN7Mo2lIjSYYjNrFx?=
 =?us-ascii?Q?LfecQbNsbutWYBE+Ta9q6LQvv3x/jNuZAWSjvqwB0GqzAuFBwKeEAe8gUxYR?=
 =?us-ascii?Q?ztiGA0/BDvq89zx8+1CTYix2MPi9ZV6+pIX2QTG3CGf6co7z9f+gRZQFSAsH?=
 =?us-ascii?Q?pGctvVeiuFEQ1jUpZa+59E/eU0RmzN5EnT5UwBYH8Frm0U3HB5HklBHdbILi?=
 =?us-ascii?Q?8Ds7HXTYlFqwCR5nIekaPe9n8KtraBz90p5D0sQfuNArRiK13ful9fsERz3Z?=
 =?us-ascii?Q?tQdFvzIcnHpxmfdXGYT1g0+SBEx9sIK3LuvryTSVCtKqRbKh6fKJsDPoBdMT?=
 =?us-ascii?Q?VPz3sFXKHBMraf8dpws4EmXoGocn6Dbfjwr2iR0xSRGcKUMD8iHlfmYFFwiw?=
 =?us-ascii?Q?82FdZC5iXj+0J2pFZaIU7NQEMXB16nN0EBnhD/8MsgOJxPHZe1w8uNxBJUV0?=
 =?us-ascii?Q?tKpPC5Ww0WB3w8u6D3uPJjd3+J2g31S9qOJTxNrZfzYuNXPEbgAAUDYflWCx?=
 =?us-ascii?Q?GRsVS1aMXmtDJm81+gKruczPmmT/WQNWdICwcFhw2ZPzGEIed8MDNmRcZTJf?=
 =?us-ascii?Q?1AKrx/u7FvBsVmp0H2yJvO+96ZsFwaHJ8J5EcXWDmSdhOwlOaNxdINj84FD9?=
 =?us-ascii?Q?rbTtsjhSFPYc84OjPUob/IP31aoY6qN1oqtbbX/l0t4ehrrDQdb5pQF1nU1M?=
 =?us-ascii?Q?W88sLub6AlWoUw/pIvbxoO5WKeP452n64LznOHU3YU8Yg5VdsZaBnFf4oRk5?=
 =?us-ascii?Q?jTTWrQxcCWmsbwVHmcvG8vxUe8wcA09MXZdj52YNVPxJbOv6wTDYP0TfYUo4?=
 =?us-ascii?Q?y27V17czfIqCSKLg3oZFFJ9wSgXVLC9MTEU6TY19/C9AdVWPFTA50E3NhkdQ?=
 =?us-ascii?Q?nIge19MeWMyokBPJHFBdeeafVeDCY6gCD+Hpgenr6OZ7ykBX0F4Ke0evI/WL?=
 =?us-ascii?Q?qH46GRzqxYY9XMvQ0ZZBZel3weDXdGhM8d2vw/8/Y1DJubHku15ZvYHFjoKn?=
 =?us-ascii?Q?W+OuwdxNuQgUODeAHm3THPZ1RTbDHhQaE7gXPJhoZTQdmJ+I99t4TbArn8c1?=
 =?us-ascii?Q?KS1IrAMmYZqOcUaH/Y7go3Gy3igLDpaWPh12Wq7oBiCl7sKibMkkvYekKKn0?=
 =?us-ascii?Q?rKZxmdBiBmARLelkD6VRPszyMpHxJ6g6b309gm2XcxNbbGZI3XRu+Clu+r8F?=
 =?us-ascii?Q?w4vsqHkEpI7oYSlQbK5O23+E9rajs9eUnTuORW/Zs/YN6ylCDY7rggXTzsdP?=
 =?us-ascii?Q?QoDhC9RnQ1Vi9+1bld6isfBDGGL892wZ+UziNZd6n37felHrT0J2TXFVZ1jl?=
 =?us-ascii?Q?76FGfb6t2Zyh1VxOQMu+u3V5gs/6N4HAKHk4PDn6dmPufy/zASzYEK0kjIzg?=
 =?us-ascii?Q?YTQ4bG96F+mc3XkqKtgTZbZvhMikrvv50Hl1/JOLLDdjLkBqEUHQP41JoxA4?=
 =?us-ascii?Q?2v6a9w0thXA53QR3Vu41g8eSjVs4zY0OjCSnBU5e0+n/0mmA0ZnyMPDLlsHl?=
 =?us-ascii?Q?sW3zAFPfet+U0eBjX+qubT5IDioMDXJUY9vO+KPo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04878f5f-9911-4f61-3c43-08dc32300346
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 16:21:37.6049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ghOKRiVT477Q5GhazuFfjOzgfDYv7kteRh6sYEeueqB1FqQoIr1LQcYs8Q84yh4ZiypYJmbkrla8d0kSXcsMFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7295

On Tue, Feb 20, 2024 at 11:08:17AM +0100, Lorenzo Pieralisi wrote:
> On Tue, Feb 20, 2024 at 10:51:17AM +0100, Niklas Cassel wrote:
> > On Mon, Feb 19, 2024 at 11:18:03AM -0500, Frank Li wrote:
> > > On Mon, Feb 19, 2024 at 09:42:08PM +0530, Manivannan Sadhasivam wrote:
> > > > On Mon, Feb 19, 2024 at 10:11:45AM -0500, Frank Li wrote:
> > > > > On Mon, Feb 05, 2024 at 12:33:21PM -0500, Frank Li wrote:
> > > > > > first 6 patches use drvdata: flags to simplify some switch-case code.
> > > > > > Improve maintaince and easy to read code.
> > > > > > 
> > > > > 
> > > > > @Lorenzo Pieralisi:
> > > > > 
> > > > > 	Do you have chance to look other patches?
> > > > > 	Mani's apply EP side change. 
> > > > 
> > > > Even though the controller is for the endpoint, it is still a controller
> > > > driver. So all the patches should go through Lorenzo.
> > > > 
> > > > I only merge patches under drivers/pci/endpoint. Hope this clarifies.
> > > 
> > > Sorry. It confused everyone. My means was that Mani applied Niklas Cassel's
> > > patches, which cause my 14th patch build failure.
> > 
> > Hello Frank,
> > 
> > Patch 14, which adds this:
> > 
> > +static const struct pci_epc_features imx95_pcie_epc_features = {
> > +       .msi_capable = true,
> > +       .bar_fixed_size[1] = SZ_64K,
> > +       .align = SZ_4K,
> > +};
> > 
> > 
> > Should, after rebasing on Mani's pci/endpoint branch, instead look like this:
> > 
> > +static const struct pci_epc_features imx95_pcie_epc_features = {
> > +       .msi_capable = true,
> > +       .bar[BAR_1] = { .type = BAR_FIXED, .fixed_size = SZ_64K, },
> > +       .align = SZ_4K,
> > +};
> > 
> > 
> > > 
> > > I asked if I need update my 14th patch or applied 1-13 only. 
> > 
> > I see, you want the maintainers to apply 1-13, and simply drop patch 14
> > instead of you sending out a rebased series.
> > 
> > I assume that the maintainers will be fine with your suggested approach.
> 
> If patch 14 has no dependencies on 1-13 yes; if it does we need to
> coordinate the merge between branches in the PCI tree.

Keep it easy. I rebase to linux-pci/endpoint and v11 patch sent out.
https://lore.kernel.org/imx/20240220161924.3871774-1-Frank.Li@nxp.com/T/#t

Frank

> 
> Lorenzo

