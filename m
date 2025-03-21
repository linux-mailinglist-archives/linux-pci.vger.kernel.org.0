Return-Path: <linux-pci+bounces-24383-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F37A6C11F
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 18:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CBF316907B
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 17:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F026A1EA7DC;
	Fri, 21 Mar 2025 17:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="bN7qCiTS"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2077.outbound.protection.outlook.com [40.107.104.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B53B13D8A4;
	Fri, 21 Mar 2025 17:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742577471; cv=fail; b=OFa02hMb8eGFwVPHeFfzzFn4NX2oEmeUQVt/B3tWNZ2hLErdR3aTDH2Fo5/iKgChlH22HOyp0T70ecx4GFwOsyEIXOODe1F9voUEXZVlt1Z4tGD958RyL1EH3U5Bo8Sxdn78+gIEptsS2JVbf3zFVqP5ojnO2U7FdcurOqCjAD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742577471; c=relaxed/simple;
	bh=DVXMfY2ngTmECShDt19aO/aYv1xosKvmbBOUUQ7WeNA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z9ImoNnddhCo9iOH3bgdYo0NOpswz4otkXW7mDrKuxYI1ln/briymWe8jEGEjemW9d4LoiofJl+ZpzdWdP4x372yeZbZohyoe0yoRViAwgkUTKBHr31Ua2dyNsH9KVH2UIwLJLQCoe4RiRBBBZBVwzZ7pMARy8/PJnfk9jhpkYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=bN7qCiTS; arc=fail smtp.client-ip=40.107.104.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jiu+G1ZaMabwZgtPiTj4xG7+mtxjnP3LhmFO3hAG+xftYfnrkIjjdQFdw9Fuctb4OYk12lknftcR5j/1ZSSjkXt1We/fo8koK7+5/G6Kdd4XtFVZizDb1N6r1T9rc/k5PuhBO/7VltLRwC2/woBHh/MuXO6kLFgSneYu4Q+DCbdInytE52PzrJ56Z+iGuJOSHz8ca1JClISsWQKU3EfL+zkwd1/tVzw+X7AbAGl+90ohXWq7zNp7xLwq5GWSl/ttAlQFOdP0+s0TCr6ZqU6Tu7dTeOtdEDenf7LkvSIBloZ2ARZGa7hE2AUHNIjhgM75BLea4/Wg8CHkbcvNl79rqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DPMz4Nlg42LKRgYtXqblEop1AWGtN3QO+9LrJTg7RyM=;
 b=BNFRutVp+yipGrZbERtFNa7w9Xry9rnd1RdOEnuMjANT7zfNUCIv+XcmvJKcGRStBcTOBZChyCbhBcN0ulAl/cEWFNbwi0lNrYXYB2IfOZOyi11L2yzr6WNGZx+z7Y0M3dkcZCUfdLcR/AFDs1dkYE4M3N+teLh7Pp6d4/PglW9NUESDO8X1MbfSGfwPZr9LX8aoaye3DnmfpP24dLYgv0UKA80+ITQcWA6YJHwHIBsv7zC4CMXVpDEzZSKITA0fjZ9I+RQpR6g3zrq4rAhKtBEhOC4C8sZZRWS5NJptVnJ2004EvvTm2EhukrBTrq7rNCcIu2cycw06yhi7bkMoKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=google.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPMz4Nlg42LKRgYtXqblEop1AWGtN3QO+9LrJTg7RyM=;
 b=bN7qCiTSmpj0OlAJVOHD/QYvs7xyxuX3tm4V9SI4HJzlWRaO/Mr8A+5KHWKUA1tl1+PpJWBOceSpFHvdD2HVCdEUGYcVIzJnDbOipDaA56bnVPShHmU4AdYOk+luCIbxAm3VG5dLFcYvWn3Eh5SdPskwbTIg/oCqy75nqeyhVoM=
Received: from AM0PR03CA0081.eurprd03.prod.outlook.com (2603:10a6:208:69::22)
 by AM7PR02MB6019.eurprd02.prod.outlook.com (2603:10a6:20b:1af::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Fri, 21 Mar
 2025 17:17:43 +0000
Received: from AMS0EPF0000019B.eurprd05.prod.outlook.com
 (2603:10a6:208:69:cafe::95) by AM0PR03CA0081.outlook.office365.com
 (2603:10a6:208:69::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.36 via Frontend Transport; Fri,
 21 Mar 2025 17:17:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF0000019B.mail.protection.outlook.com (10.167.16.247) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Fri, 21 Mar 2025 17:17:43 +0000
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 21 Mar
 2025 18:17:42 +0100
Received: from se-mail02w.axis.com (10.20.40.8) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 21 Mar
 2025 18:17:42 +0100
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Fri, 21 Mar 2025 18:17:42 +0100
Received: from pc36611-1939.se.axis.com (pc36611-1939.se.axis.com [10.88.125.175])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id BCD86E2;
	Fri, 21 Mar 2025 18:17:42 +0100 (CET)
Received: by pc36611-1939.se.axis.com (Postfix, from userid 363)
	id B6808624E5; Fri, 21 Mar 2025 18:17:42 +0100 (CET)
Date: Fri, 21 Mar 2025 18:17:42 +0100
From: Jesper Nilsson <jesper.nilsson@axis.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Niklas Cassel <cassel@kernel.org>, Jesper Nilsson
	<jesper.nilsson@axis.com>, Frank Li <Frank.Li@nxp.com>, Lars Persson
	<lars.persson@axis.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
	<kw@linux.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>, <linux-arm-kernel@axis.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH RFC NOT TESTED 0/2] PCI: artpec6: Try to clean up
 artpec6_pcie_cpu_addr_fixup()
Message-ID: <Z92fNs31ybMO2Y1+@axis.com>
References: <Z9k2fLFU3UCubK97@ryzen>
 <20250320215405.GA1102700@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250320215405.GA1102700@bhelgaas>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019B:EE_|AM7PR02MB6019:EE_
X-MS-Office365-Filtering-Correlation-Id: a177c27f-6cdc-4918-89ff-08dd689c4af3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|30052699003|7416014|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hitrBMdqJz91IYntXmK/PYVjDocsCru8GqaU3VuBMTOW7YhqynIwnYjIMH65?=
 =?us-ascii?Q?JUN/qBSkVI7Anrr2hz6l8H+mh1mver9cuHpD56/vvKFJN9Fku9IQABR0EAtc?=
 =?us-ascii?Q?xC2rf2mnV4hjFt96nE3SAF8Z9B1B1xvCxPuQexwR+oZlQ9a1vl8lNeijvgXM?=
 =?us-ascii?Q?txrm75k8nxM/1iU5V/OkbZ+T7QxWZIcrL7hHpkCUD6oZQiTslOoH1M7l075+?=
 =?us-ascii?Q?0WBLvsr5WB0eek9OMq4FL6oURu64A3STNwo1iKO8UxwW30enBtfI43H7mt7M?=
 =?us-ascii?Q?UydZMM0I+egMcsmLRylEZN+02QyiOAOND9mR5MY4ZvgG53zMonDxCRzNoJfE?=
 =?us-ascii?Q?GL3ia149Ycb4ewdNzzRX3O/ST6jrRT0tm/nUOfBCqsET3jBzd1EGZSSSbseB?=
 =?us-ascii?Q?dFccOLdI124N3MZshMrpDMjg6bVD2liR1xBerxV8cb/InoWnp/oJLahjtC6R?=
 =?us-ascii?Q?SWNY7TGB33RNQ+0/NPHD/Gq1X+0fW5BHeXtySdwlRTsb4pngbsRy+Fqkv55X?=
 =?us-ascii?Q?Ao15QoUDerdMdwcl5qjwsCr1ueM64l8FfLrlk+wLu77w3ewkFfgAdN8/kdNa?=
 =?us-ascii?Q?Q80PJXZYX6xZLp1iJiLZReTXKNiCbXXYAkNjDvbF233XJN1wxsc+5M84vcDb?=
 =?us-ascii?Q?f1/gk8MRXskUCKeIgAdwiTvuPBQvNb1vFoFx2rsm++OL4W9lZ5/RidAQpUaW?=
 =?us-ascii?Q?Tf09HKMkLsvFRDMoDK7CdvIKdx39rXjuWN/6l4DNhwWSrD1ZBaXVZV/ySmdP?=
 =?us-ascii?Q?FaYHg8Zb1uON2eTXeM86ZnLyIx6hQuOR0aNR/1cQV7gtvlBj/3RV7aD94q+r?=
 =?us-ascii?Q?kdrwNjdj4pKS/z+zY4laZciMkfSY/JS5Q8uw1sVpS1sZqcb6fnMuyiKfn3iu?=
 =?us-ascii?Q?kBf1HPwHKPVkV7ozOKs3l8MIh/7nECukf68QttUZbu00PTPltVT1Jf6fUauh?=
 =?us-ascii?Q?NQaXiKFxA69J2/yH6lIxBvz0NOIboLSNgUstXrSzaUrTKOjF6k80sqIDSr7k?=
 =?us-ascii?Q?GqkAjaQ7hnFg7w3zO0txeTqCYGwo19xfshUsAx4Wz94mhmVu8ZXDZau3YYCB?=
 =?us-ascii?Q?auX0LvcsoI1DuA4dXC2FOBMnH1tu/4xkIl5UI36FuNDQYWN3VftyUWBlX8qq?=
 =?us-ascii?Q?hGnTfpdYxp1Gzm22iVXF+o4BvByi7RX6pTivXs0vkFI6IW692iyf4WpXijrn?=
 =?us-ascii?Q?xyNUxQNUg9HI0zLc13WlQ2gk3Bri98t3dQyK1Z19B7p9Ps/3Mhak8BzSV5NP?=
 =?us-ascii?Q?9qz1vFEJ9UfwNTpLkLks/peqjjHIr0HfrcjpZlAsJEexzn3yhHGhX07CkxQ8?=
 =?us-ascii?Q?e4HWK0SLPcLyK8fnXZcDrc6TwlerlFLwAE/TUT8fvSHtcq7n1tIC8AlczhJm?=
 =?us-ascii?Q?5Kb8+89zHDp+LzVrQ+Hh4vYEDqeEaRl8XziNbSjmJN8XhttQOh6jD7bsDAn0?=
 =?us-ascii?Q?uK81c8JgXl8=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(30052699003)(7416014)(376014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 17:17:43.7671
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a177c27f-6cdc-4918-89ff-08dd689c4af3
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF0000019B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR02MB6019

On Thu, Mar 20, 2025 at 04:54:05PM -0500, Bjorn Helgaas wrote:
> On Tue, Mar 18, 2025 at 10:01:48AM +0100, Niklas Cassel wrote:
> > On Mon, Mar 17, 2025 at 12:54:19PM -0500, Bjorn Helgaas wrote:
> > > On Mon, Mar 10, 2025 at 05:47:03PM +0100, Jesper Nilsson wrote:
> > > > I've now tested this patch-set together with your v9 on-top of the
> > > > next-branch of the pci tree, and seems to be working good on my
> > > > ARTPEC-6 set as RC:
> > > > 
> > > > # lspci
> > > > 00:00.0 PCI bridge: Renesas Technology Corp. Device 0024
> > > > 01:00.0 PCI bridge: Pericom Semiconductor PI7C9X2G304 EL/SL PCIe2 3-Port/4-Lane Packet Switch (rev 05)
> > > > 02:01.0 PCI bridge: Pericom Semiconductor PI7C9X2G304 EL/SL PCIe2 3-Port/4-Lane Packet Switch (rev 05)
> > > > 02:02.0 PCI bridge: Pericom Semiconductor PI7C9X2G304 EL/SL PCIe2 3-Port/4-Lane Packet Switch (rev 05)
> > > > 03:00.0 Non-Volatile memory controller: Phison Electronics Corporation E18 PCIe4 NVMe Controller (rev 01)
> > > > 
> > > > However, when running as EP, I found that the DT setup for pcie_ep
> > > > wasn't correct:
> > > > 
> > > > diff --git a/arch/arm/boot/dts/axis/artpec6.dtsi b/arch/arm/boot/dts/axis/artpec6.dtsi
> > > > index 399e87f72865..6d52f60d402d 100644
> > > > --- a/arch/arm/boot/dts/axis/artpec6.dtsi
> > > > +++ b/arch/arm/boot/dts/axis/artpec6.dtsi
> > > > @@ -195,8 +195,8 @@ pcie: pcie@f8050000 {
> > > >  
> > > >                 pcie_ep: pcie_ep@f8050000 {
> > > >                         compatible = "axis,artpec6-pcie-ep", "snps,dw-pcie";
> > > > -                       reg = <0xf8050000 0x2000
> > > > -                              0xf8051000 0x2000
> > > > +                       reg = <0xf8050000 0x1000
> > > > +                              0xf8051000 0x1000
> > > >                                0xf8040000 0x1000
> > > >                                0x00000000 0x20000000>;
> > > >                         reg-names = "dbi", "dbi2", "phy", "addr_space";
> > > > 
> > > > Even with this fix, I get a panic in dw_pcie_read_dbi() in EP-setup,
> > > > both with and without:
> > 
> > Your fix looks correct to me.
> > 
> > You should even be able keep dbi as 0x2000, and simply remove the dbi2
> > from "reg" and "reg-names", as the driver should be able to infer dbi2
> > automatically:
> > https://github.com/torvalds/linux/blob/v6.14-rc7/drivers/pci/controller/dwc/pcie-designware.c#L119-L128
> > 
> > But your fix seems more correct.
> > You should probably also change the size of "dbi" to 0x1000 in the RC node.
> 
> Just a ping to see if there's any chance of getting this into v6.15?
> 
> To do that, I think we'd need to confirm that:
> 
>   - the endpoint issue is fixed

Unfortunately, I've been unable to get any resolution to this problem.

- Tested on units without the PCIe switch - still fail
- Tested on another units - still fail
- Tested with 6.12-rc7 - fail
- Tested with 6.6-rc6 - fail
- Tested with 6.1 - fail
- Older kernels fail with toolchain or boot problems due to my hacky
  tools for booting upstream kernels so I can't easily test
- Tested with original bringup kernel 4.19 - no crash, but endpoint is
  not enumerated from RC. This contains lots of hacked around code
  which could also come into play, and there is an untested hardware
  adapter in between the two boards.

The panic looks like this (with some minor variations due to kernel version)

=============
[   16.601883] 8<--- cut here ---
[   16.604937] Unhandled fault: external abort on non-linefetch (0x008) at 0xf0bdd00e
[   16.612502] [f0bdd00e] *pgd=029d6811, *pte=f8050243, *ppte=f8050013
[   16.618775] Internal error: : 8 [#1] SMP ARM
[   16.623041] Modules linked in:
[   16.626092] CPU: 0 UID: 0 PID: 1 Comm: sh Not tainted 6.14.0-rc4-g98c0bcfef512-dirty #26
[   16.634181] Hardware name: Axis ARTPEC-6 Platform
[   16.638877] PC is at dw_pcie_read_dbi+0x60/0xa4
[   16.643414] LR is at 0x0
[   16.645942] pc : [<c05d9e64>]    lr : [<00000000>]    psr: 60000013
[   16.652203] sp : f0819bc0  ip : c1e2b840  fp : 00000000
[   16.657420] r10: c1d9f000  r9 : c1efdbc0  r8 : c1e2b930
[   16.662638] r7 : c0d2f188  r6 : c1e2b840  r5 : c1e2b930  r4 : 00000000
[   16.669159] r3 : 00000001  r2 : 00000000  r1 : f0bdd00e  r0 : c1e2b840
[   16.675679] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[   16.682810] Control: 10c5387d  Table: 02bec04a  DAC: 00000051
[   16.688548] Register r0 information: slab kmalloc-2k start c1e2b800 pointer offset 64 size 2048
[   16.697257] Register r1 information: 0-page vmalloc region starting at 0xf0bdd000 allocated at devm_pci_remap_cfgspace+0x4c/0x80
[   16.708826] Register r2 information: NULL pointer
[   16.713527] Register r3 information: non-paged memory
[   16.718573] Register r4 information: NULL pointer
[   16.723272] Register r5 information: slab kmalloc-2k start c1e2b800 pointer offset 304 size 2048
[   16.732064] Register r6 information: slab kmalloc-2k start c1e2b800 pointer offset 64 size 2048
[   16.740769] Register r7 information: non-slab/vmalloc memory
[   16.746424] Register r8 information: slab kmalloc-2k start c1e2b800 pointer offset 304 size 2048
[   16.755215] Register r9 information: slab kmalloc-128 start c1efdb80 pointer offset 64 size 128
[   16.763919] Register r10 information: slab kmalloc-1k start c1d9f000 pointer offset 0 size 1024
[   16.772624] Register r11 information: NULL pointer
[   16.777410] Register r12 information: slab kmalloc-2k start c1e2b800 pointer offset 64 size 2048
[   16.786201] Process sh (pid: 1, stack limit = 0xf7eac871)
[   16.791596] Stack: (0xf0819bc0 to 0xf081a000)
[   16.795951] 9bc0: 00000000 c05dd354 c1d9f410 c12ef02c 00000000 00000000 c1d9f410 c1e2b840
[   16.804125] 9be0: c0d2f188 c1e2b930 c1efdbc0 c12ef02c 00000000 c010b70c 01040800 3841aac4
[   16.812298] 9c00: c1d9f410 00000000 c1d9f410 c12e01a4 c1317740 00000000 00000000 c06f7200
[   16.820471] 9c20: 00000000 c1d9f410 c12e01a4 c06f464c c1d9f410 00000000 c1d9f410 c12e01a4
[   16.828643] 9c40: c1d9f410 00000006 c1317428 c06f49d4 60000013 00000000 c138a5f8 c12e01a4
[   16.836816] 9c60: c1d9f410 00000006 c1317428 c06f4be4 00000001 c12e01a4 f0819ccc c1d9f410
[   16.844989] 9c80: c1317428 c06f4d1c 00000000 f0819ccc c06f4c74 c1418100 c1317428 c06f2714
[   16.853162] 9ca0: c1418100 c141816c c15a8cb8 3841aac4 00000000 c1d9f410 00000001 c1d9f454
[   16.861334] 9cc0: c1418100 c06f50ec 00000000 c1d9f410 00000001 3841aac4 c1d9f410 c1d9f410
[   16.869507] 9ce0: cfef0e4c c06f35f0 c1d9f410 00000000 cfef0e4c c16a5810 c1317428 c06f0ea0
[   16.877680] 9d00: 00000000 00000000 00000000 00000000 00000000 3841aac4 c1d9f400 00000000
[   16.885852] 9d20: 00000000 c16a5810 cfef0ea4 ffffffff c0fdff38 c0a0a6d8 f0819da0 00000000
[   16.894025] 9d40: c16a5800 f0819da0 c1308d3c c0a0a81c 00000000 3841aac4 c1308d30 c12dea88
[   16.902198] 9d60: 00000005 c015642c f0819da0 00000005 cfef0e40 cfef1080 c1ed4d40 c0fdd378
[   16.910371] 9d80: c0fdff38 c0a0f0a8 c1ed4554 c0a08e44 c1ed4540 c1ed4540 00000005 c0a0f240
[   16.918543] 9da0: cfef0e40 c1ed4d40 cfef1080 c0a0f4e8 00000000 00000000 00000000 00000000
[   16.926715] 9dc0: 00000000 00000000 00000000 00000000 00000000 3841aac4 c1ed4540 00000000
[   16.934888] 9de0: c1ed4c68 c1328858 00000001 c0a100bc 00000000 c1ed4c40 c1ed4c68 c1ed4c68
[   16.943060] 9e00: 00000001 c0a15e5c 00000000 c0ffa474 00008060 c1ed4c40 00000000 c0fdfd74
[   16.951233] 9e20: c1efd1c8 c1328f60 c138d3dc c1ed4c68 c1e76400 00000000 00000000 cfef0e40
[   16.959406] 9e40: 00000001 3841aac4 00000000 00000000 c1308df0 c1308ddc c1e76400 00000015
[   16.967579] 9e60: c1efd180 c1efd188 00000000 c0a1640c c1ed4940 7265766f 2d79616c 50646e45
[   16.975751] 9e80: 746e696f 6274642e 00000000 00000000 00000000 00000000 00000000 00000000
[   16.983924] 9ea0: 00000000 00000000 00000000 00000000 00000000 3841aac4 c1ed4e80 c1efd600
[   16.992096] 9ec0: 00000015 f0819f28 c1efd610 00000000 00000000 c02f9704 00000000 00000000
[   17.000269] 9ee0: c1eca400 f0819f80 c02f9608 c1448000 00000015 c0d0b648 00000000 c026fc44
[   17.008441] 9f00: 00000000 00000000 00000000 00000000 00010000 00000015 005a8fb8 00000000
[   17.016613] 9f20: 00000001 00000000 c1eca400 00000000 00000000 00000000 00000000 00000000
[   17.024786] 9f40: 00000000 00000000 00000000 00000000 00000000 3841aac4 00000000 c1eca400
[   17.032958] 9f60: c1eca400 00000000 00000000 c01002c4 c1448000 00000004 00000000 c026ff60
[   17.041131] 9f80: 00000000 00000000 00000000 3841aac4 00000003 00000015 005a8fb8 b6f1fbb0
[   17.049304] 9fa0: 00000004 c0100060 00000015 005a8fb8 00000001 005a8fb8 00000015 00000001
[   17.057476] 9fc0: 00000015 005a8fb8 b6f1fbb0 00000004 00000000 0057cdb0 00000000 00000000
[   17.065649] 9fe0: 00000004 beb0aa08 b6ec0d0f b6e3d5e6 40000030 00000001 00000000 00000000
[   17.073818] Call trace:
[   17.073828]  dw_pcie_read_dbi from dw_pcie_ep_init_registers+0x2c/0x3bc
[   17.082978]  dw_pcie_ep_init_registers from artpec6_pcie_probe+0x164/0x1dc
[   17.089867]  artpec6_pcie_probe from platform_probe+0x5c/0xb0
[   17.095621]  platform_probe from really_probe+0xe0/0x3cc
[   17.100937]  really_probe from __driver_probe_device+0x9c/0x1e4
[   17.106865]  __driver_probe_device from driver_probe_device+0x30/0xc0
[   17.113313]  driver_probe_device from __device_attach_driver+0xa8/0x120
[   17.119934]  __device_attach_driver from bus_for_each_drv+0x90/0xe4
[   17.126208]  bus_for_each_drv from __device_attach+0xa8/0x1d4
[   17.131961]  __device_attach from bus_probe_device+0x88/0x8c
[   17.137626]  bus_probe_device from device_add+0x5f0/0x804
[   17.143030]  device_add from of_platform_device_create_pdata+0xa8/0xec
[   17.149568]  of_platform_device_create_pdata from of_platform_notify+0xf4/0x168
[   17.156886]  of_platform_notify from blocking_notifier_call_chain+0x6c/0x90
[   17.163861]  blocking_notifier_call_chain from of_reconfig_notify+0x38/0xa0
[   17.170831]  of_reconfig_notify from __of_changeset_entry_notify+0x130/0x14c
[   17.177882]  __of_changeset_entry_notify from __of_changeset_apply_notify+0x44/0xa8
[   17.185542]  __of_changeset_apply_notify from of_overlay_fdt_apply+0x8f4/0xa74
[   17.192771]  of_overlay_fdt_apply from overlays_store+0x160/0x21c
[   17.198872]  overlays_store from kernfs_fop_write_iter+0xfc/0x1e8
[   17.204978]  kernfs_fop_write_iter from vfs_write+0x244/0x414
[   17.210731]  vfs_write from ksys_write+0x6c/0xdc
[   17.215347]  ksys_write from ret_fast_syscall+0x0/0x54
[   17.220485] Exception stack(0xf0819fa8 to 0xf0819ff0)
[   17.225533] 9fa0:                   00000015 005a8fb8 00000001 005a8fb8 00000015 00000001
[   17.233706] 9fc0: 00000015 005a8fb8 b6f1fbb0 00000004 00000000 0057cdb0 00000000 00000000
[   17.241877] 9fe0: 00000004 beb0aa08 b6ec0d0f b6e3d5e6
[   17.246926] Code: e3530002 0a000005 e3530001 1a00000a (e5d10000)
[   17.253013] ---[ end trace 0000000000000000 ]---
[   17.257624] note: sh[1] exited with irqs disabled
[   17.262440] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[   17.274976] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---
=============

As you might see, I trigger loading with some overlay magic for debugging,
but it's the same if I have it compiled in.

>   - artpec6 is only used in-house

Correct.

>   - the DTBs are either already OK or OK after [PATCH 1/2]

After my patch, yes.

>   - everybody in-house is OK with updating to the new DTB.

OK for me.

> I haven't seen anything about the endpoint part, and haven't seen
> confirmation of the others.
> 
> Bjorn

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com

