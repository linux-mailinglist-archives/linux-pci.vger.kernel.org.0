Return-Path: <linux-pci+bounces-5559-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D727689593E
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 18:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BF20B20CA6
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 16:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBF5140E50;
	Tue,  2 Apr 2024 16:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="T3GPL3Fv"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2119.outbound.protection.outlook.com [40.107.7.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B0D3611A;
	Tue,  2 Apr 2024 16:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712073971; cv=fail; b=WCNejSTMjAOKAOyUwRyxqdyYUP6YemqrYgztaVos/HisVJz7oGESqPIRrGdA8WZGL4+qqoBrDtD0NpBbUhkEe/Azib7SKaO6ZpC1TpKVXlqYv74JSE/xJGeciKGsNiSBuSwkNff+UmY0bHNrBUSmS3B2I6t5Ob1aHqm2RvmUXTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712073971; c=relaxed/simple;
	bh=duQ7Vu5UBJIBb8wfxfqbcCfwzmJU9wbEeyoekzDc0d0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WMfsCx6urKr73VAG1aGTlFs2G4MaJ0WIg9hHrAaYGI2SGyovhDe2XPQtfCSRly6gdnROpEYUf6gTOVkhpWRy4ea3JBtNDVFW0CGuCKWD5OxvWZnfYmCSTmbdI6NRumKQWkVgJKA+8f0esL9vKM4w1q0p7FFJduI/fIioDomrBos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=T3GPL3Fv; arc=fail smtp.client-ip=40.107.7.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C5yCWkEr4zmEv1YHJcViaBDqP0qEaif1unFpCGFKBzOgyYwLRK5H+S511hZx/d+9kmFIktgTVM4ef9XtKBrZRcBmTg0oEA8OrflgyACxezSN0ti6SA4tMkJmZnWSP1fGx8anys/8wl0Hy5V74eqFgANCc3GwAhr3Mgar6tWvTBKaNSB6k7TLz+wiJw5AKt5acTFEscJzNvM5PSsPAjb4emw+f/Z64dJQj7or8V2b4D9zhwbwd/jFJTTx8F8Ck1r8P2GLPNsRiZ3frgv+ItZ0dGgjX5O0YkEKTY+7iGvpVj02Q53g/WvEaJGt+Cu5PUwMCgXTGWwNb20LSIKwHOOf6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=prYFhq6kGH/MNhC9dUdaN/EhOFnm6gMhemCxR73nePM=;
 b=LN3f6ELzPj/JXjX401WKmtSg9nDy9mp5JQh39j3zM0QFRTjPMuiF0iIsKcxxS/mpj2uyKYMANXeK82ww+UTTcyPP947P5VB9kdku0DIenKhfbPcggu8b01vgY8za18/7UbehANEOes8l8it6p0cdRuK+gm9/xFDfUsXNDNa3s+kKwBoqm5edZUoM+osR6uHaEppkeoGoPvpnyAqLWUbKpmWsFmgiJBZhzHmNeo9vGmdSXtNHBX8xye42MKSB1CK0GgnHTGKcL0A/Dvxh5vDQlLrWCle8x3QcmLvPD8sdN1U3xmlz8Xp70LPeuWRW97dRt2WGJS2ME2KRii8qosDWaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=prYFhq6kGH/MNhC9dUdaN/EhOFnm6gMhemCxR73nePM=;
 b=T3GPL3Fva9Bn5OEtbm9uAqdvw+UTLOnxFupMkDaTKmiXswQ+yXmrt8rA9sbUn/Yix+Wb/W/HaL+u+bkiEh4hTOSekAZ19Jd/MBq9Hd0d4xg1zfGXEvuUcAD6EpmX+YnRKMKvLBOyb703UhbY8PcwAXi9NGti8Tme5nGdzrCv03c=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9256.eurprd04.prod.outlook.com (2603:10a6:102:2ba::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Tue, 2 Apr
 2024 16:06:05 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 16:06:05 +0000
Date: Tue, 2 Apr 2024 12:05:57 -0400
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>, niklas.cassel@wdc.com,
	bhelgaas@google.com, gustavo.pimentel@synopsys.com,
	imx@lists.linux.dev, jdmason@kudzu.us, jingoohan1@gmail.com,
	kw@linux.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, lpieralisi@kernel.org, robh@kernel.org
Subject: Re: [PATCH v2 1/1] PCI: dwc: Fix index 0 incorrectly being
 interpreted as a free ATU slot
Message-ID: <Zgws5Z850iM4XtdD@lizhi-Precision-Tower-5810>
References: <20240321171345.GA2385@thinkpad>
 <20240321180732.GA1329092@bhelgaas>
 <20240322052623.GA4092@thinkpad>
 <Zf0i1X5fg-E59NWx@ryzen>
 <20240402051228.GH2933@thinkpad>
 <ZgvOpTcNKPantiHg@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgvOpTcNKPantiHg@ryzen>
X-ClientProxiedBy: SJ0PR03CA0352.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9256:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xTimid+LK6MjJeCdU4FV8lDxYAvCAmoAiPcNV4zz8/UZENKDqGc/liMOwO3TagRH3xkgNs8q2nuQXt3EWmvlq1lmFQ0ejQ6Km73S/2VIIC4BY7yzrfZKcx+bLPY/WspnZp+RQzwbj0Xun+bZRneeK65m6Lz3NJ75dG04w8YGaIfwgZSui+RTvyjwPrGBc3J2dEiUAjEC5SYxGLaPXtXXM+HXe6gi/5gwG1xE3OIGLPfJIPUUpniGzTw3LUcphRcCq5xZoJ0vJBCLmwnXove39pwk5xplotmZZ2i5NtfhXa0+1/eaBBCZ7kuZRx3CPCH8LH1ZBP4irL8hw7eBxn1Uw2H5BHCZJMs+w8MHiaGBTnuY9c9ZJvqgSpNMQWa6vZ/QYfJ7/xeUDMsG5nanc8atGLmfNeWZZCrVWoxQ1QxwumeTnj9DKxTp3lAZYFL2vYn8PWF5SFUUA8gSkYV60HqF+JFWLFsQ307pKMrT82VVAgfXv80D5mXP0wmagIgXrng0QEg+zz5jCg1tyxu0mr6MAk213dCs6A73T7NeHzr/4mW4iYhVFNiy7bhxHeHUOlBx0jZN5v33/IjQkKN6hngvz4dCEom6BoXcGSiWFNCDJfqIW499e4gCzr6U8Td5bMNEZOlf/3CX692xzfaFsRcF+7TJPvOIkK3q8jAmP79zVp0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(52116005)(7416005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yN1R9YVYHGeEw6NH4y6UvCICXvOJ2pWl8Il3wv49PXVheAi4AG2GP1mMenCN?=
 =?us-ascii?Q?1uEU1dkqqad11kTaRbfb+f5Cj65WdHwjVSsh4Tw9rRPrleW3MlxygQTeqxn+?=
 =?us-ascii?Q?ZEPSyQbIzhePO+ynugCIvKjnR+xzMZcZvsig0Yh//6LG8lTBVOD8l8CRIr9b?=
 =?us-ascii?Q?/JokRnxSy+jIRIxgMJVXvc31jcGLBU4a2Yqq7hQ6PsPmoSVVA5lXbUM3OB6J?=
 =?us-ascii?Q?GJym0HCwnxgjLFJIFqOLqhlUE7Z56Dkesosm27p8wM4a554+XubmJuk2aU+a?=
 =?us-ascii?Q?5hJlDKch+H4YK7o7K2qSH8iBtVVeZkYgjRcCGM+8km+72dkeQ1WTtpzjvs4P?=
 =?us-ascii?Q?kbfr68tLLbC7vOPPud4nwezNfLVeyTQ1Ap3DCvlZpi3LdQ20dZGVKA3OgNhr?=
 =?us-ascii?Q?VkefaDYDJpwJwm8jRBbTQ4jkqH44JPN9rnGPLB55alMDCIlWTWefYcQjcR4T?=
 =?us-ascii?Q?wCLYyBwbahdQgix0oOZO09rlDwPMdP5ByZ/BsUph8UfUgmYmH6PdmGkoKva1?=
 =?us-ascii?Q?hBXu/+qvj1kI8g9+6oNIvcF12+wwgKiTW7ry55ozAN937H0HkL05LF8rb8if?=
 =?us-ascii?Q?vo/un3itQsuo9Cx2wY1iorHBPsFa2Az3eQGVH8LYq9SQYUsVekocuuyDo2mm?=
 =?us-ascii?Q?5NFQMfnrfwavDFX1GFvfMjj7HwXR/eRWcfjmOWeWNMXwM2eeJQmyF9NoadkQ?=
 =?us-ascii?Q?59xbDISHSQqE9PpwMzuAk9Ks61nNNXil2BFW0Ys+wp03u+4HDl5c3/nHhuA4?=
 =?us-ascii?Q?/UxOY+8JdNWSX0IAX7YkwxxoXlNeewvMc1TCaTQ1FF71ud3v24TlK3mRNS5T?=
 =?us-ascii?Q?Scwjotvx/PIXWM5B8jy/EcJ0/ZH7BCgsVzPDBCOMFjzL6TAE6CVCEY69Eo2r?=
 =?us-ascii?Q?juI7xkuU4CslzWm33YPqN0UMmKbKXxW5VguOscXn+/y66mf+WK1jjhHWjbzr?=
 =?us-ascii?Q?LoY1O9UrmdH/eJohcHaQVQy22dazL90tDzQysGcyOn44yYDGLMAqUorESZSp?=
 =?us-ascii?Q?5o20jOWjWNSfPZpYQpIkokTbcjtoTma576D3/m2BJv7+p7HjIlE8WeqV9YQ6?=
 =?us-ascii?Q?BQFRxmbE7T3Lsax2j5n0uxxwIfTOjFFb8HnzEtr34cj1y+usmiP9vomi7Gce?=
 =?us-ascii?Q?7PakJXipZPR0blJsaOwqcZt93kmhnWC9NOlzjFPpckJDNThe+o8m4DMPBaZz?=
 =?us-ascii?Q?GzZYr/8+EiSJaRhq5HE21M2FRCL4OnQ1nK3LwoyRI5bZA065iuWFnrTlJO2j?=
 =?us-ascii?Q?rRcjCqfcGsG49UpEfPD5gN7JzojJ/JSWmj5z04+x7YQhBiy4YhfYOhtMf1fm?=
 =?us-ascii?Q?mEqIJym+YoQekx6fbUNHun7Xm2ziGO6EY01rkqQwOePNVZbDRoAsa2RjvWG7?=
 =?us-ascii?Q?nASpAIxjGczJOuHZzSdo3msGdvr8QYh5T7x5hdQIkhkumfJtbgbq6hLvPTS7?=
 =?us-ascii?Q?XAdbuIxemre9nHCO9eyYNZW3LcwObbxrfxx+p1uziLGBPDYjBflnElrdQD8E?=
 =?us-ascii?Q?fdvKA2tcIm3mkRcK6TGxYMUR9vSnkf2YJLRlK4VWDvKe5G9bBTWkAfXGDXlT?=
 =?us-ascii?Q?gh0a+6GFz1OKXOi1k7F5LQRxg6n0uz4+0pWoXKRY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2843157d-480f-407b-121d-08dc532ecd0d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 16:06:05.4816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mIwyF5ipaUHuHja4AoaGZNrjwmFdgp7MU6bjvfWsJcmD9bl/qx4cjT16WyucxpvUpLHJLHH/ME1NBDV3ZtU+Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9256

On Tue, Apr 02, 2024 at 11:23:49AM +0200, Niklas Cassel wrote:
> On Tue, Apr 02, 2024 at 10:42:28AM +0530, Manivannan Sadhasivam wrote:
> > On Fri, Mar 22, 2024 at 07:19:01AM +0100, Niklas Cassel wrote:
> > > On Fri, Mar 22, 2024 at 10:56:23AM +0530, Manivannan Sadhasivam wrote:
> > > > On Thu, Mar 21, 2024 at 01:07:32PM -0500, Bjorn Helgaas wrote:
> > > > > On Thu, Mar 21, 2024 at 10:43:45PM +0530, Manivannan Sadhasivam wrote:
> > > > > > On Mon, Mar 04, 2024 at 05:46:16PM -0500, Frank Li wrote:
> > > > > > > dw_pcie_ep_inbound_atu()
> > > > > > > {
> > > > > > > 	...
> > > > > > > 	if (!ep->bar_to_atu[bar])
> > > > > > > 		free_win = find_first_zero_bit(ep->ib_window_map, pci->num_ib_windows);
> > > > > > > 	else
> > > > > > > 		free_win = ep->bar_to_atu[bar];
> > > > > > > 	...
> > > > > > > }
> > > > > > > 
> > > > > > > The atu index 0 is valid case for atu number. The find_first_zero_bit()
> > > > > > > will return 6 when second time call into this function if atu is 0. Suppose
> > > > > > > it should use branch 'free_win = ep->bar_to_atu[bar]'.
> > > > > > > 
> > > > > > > Change 'bar_to_atu' to free_win + 1. Initialize bar_to_atu as 0 to indicate
> > > > > > > it have not allocate atu to the bar.
> > > > > > 
> > > > > > I'd rewrite the commit message as below:
> > > > > > 
> > > > > > "The mapping between PCI BAR and iATU inbound window are maintained in the
> > > > > > dw_pcie_ep::bar_to_atu[] array. While allocating a new inbound iATU map for a
> > > > > > BAR, dw_pcie_ep_inbound_atu() API will first check for the availability of the
> > > > > > existing mapping in the array and if it is not found (i.e., value in the array
> > > > > > indexed by the BAR is found to be 0), then it will allocate a new map value
> > > > > > using find_first_zero_bit().
> > > > > > 
> > > > > > The issue here is, the existing logic failed to consider the fact that the map
> > > > > > value '0' is a valid value for BAR0. Because, find_first_zero_bit() will return
> > > > > > '0' as the map value for BAR0 (note that it returns the first zero bit
> > > > > > position).
> > > > > > 
> > > > > > Due to this, when PERST# assert + deassert happens on the PERST# supported
> > > > > > platforms, the inbound window allocation restarts from BAR0 and the existing
> > > > > > logic to find the BAR mapping will return '6' for BAR0 instead of '0' due to the
> > > > > > fact that it considers '0' as an invalid map value.
> > > > > > 
> > > > > > So fix this issue by always incrementing the map value before assigning to
> > > > > > bar_to_atu[] array and then decrementing it while fetching. This will make sure
> > > > > > that the map value '0' always represents the invalid mapping."
> > > > > 
> > > > > This translates C code to English in great detail, but still doesn't
> > > > > tell me what's broken from a user's point of view, how urgent the fix
> > > > > is, or how it should be handled.
> > > > > 
> > > > > DMA doesn't work because ATU setup is wrong?  Driver MMIO access to
> > > > > the device doesn't work?  OS crashes?  How?  Incorrectly routed access
> > > > > causes UR response?  Happens on every boot?  Only after a reboot or
> > > > > controller reset?  What platforms are affected?  "PERST# supported
> > > > > platforms" is not actionable without a lot of research or pre-existing
> > > > > knowledge.  Should this be backported to -stable?
> > > > > 
> > > > 
> > > > Severity is less for the bug fixed by this patch. We have 8 inbound iATU windows
> > > > on almost all of the platforms and after PERST# assert + deassert, BAR0 uses map
> > > > '6' instead of '0'.
> > > > 
> > > > This has no user visibility since the mapping will go fine and we have only 6
> > > > BARs. So I'd not mark this as as critical fix that needs special attention.
> > > 
> > > So we will have 6 mappings configured, but only 5 BARs, so two mappings for
> > > BAR0. The iATU looks at them in order, so index 0 will override index 6.
> > > 
> > > We are lucky that the endpoint subsystem does not clean up allocations properly
> > > right now (you have an outstanding series which fixes this).
> > > 
> > > If the endpoint subsystem did clean up resources properly, we would DMA to the
> > > area that was previously allocated for BAR0, instead of the new area for BAR0.
> > > 
> > 
> > How would DMA happen to the previously allocated area? When the BARs are cleared
> > properly and then allocated again, BAR0 will get the map of 0 again and then the
> > iATU will map window 0 with BAR0. Only if we don't clear the BARs properly (as
> > like now), then it will result in BAR0 having 2 identical mappings and even with
> > that there won't be any issue since both map 0 and 6 are valid.
> > 
> > Am I missing anything?
> 
> Like Bjorn summarize it:
> "We dodge the bullet as long as the mappings for BAR 0 are identical,
> which doesn't feel like much comfort."
> 
> Yes, right now we don't have a cleanup of either the backing memory for
> the BAR, or the iATUs mapping the PCI address to backing memory.
> (We allocate the backing memory for the BARs in .bind(), and free it in
> unbind().)
> 
> So the superfluous iATU6 mapping will be the same as the iATU0 mapping.
> 
> After your series, we will still allocate and free the backing memory
> in .bind()/.unbind(), but we will set/clear the iATU mapping in the
> .init()/.deinit() EPF callbacks.
> 
> 
> > 
> > > Perhaps just include this fix in your series that actually cleans up the BARs?
> > > 
> > 
> > Yeah, makes sense. Once we agree on a finalized commit message in this thread,
> > I'll include this patch in my series.
> 
> I think that we have spent too much time on this patch already.
> 
> My suggestion is that you simply apply it to pci/endpoint branch directly and
> fixup the commit message (like Bjorn usually does with [bhelgaas: commit log])
> after Frank's Sign-off.

I combined mani and your suggested message to 

https://lore.kernel.org/imx/20240326193540.3610570-1-Frank.Li@nxp.com/

I am okay to fine tune it by yourself. 

Frank

> 
> 
> Kind regards,
> Niklas

