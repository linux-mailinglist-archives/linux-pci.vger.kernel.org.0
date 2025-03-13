Return-Path: <linux-pci+bounces-23686-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BD7A602ED
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 21:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89CD38814A8
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 20:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4241F3BB9;
	Thu, 13 Mar 2025 20:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="W+CuQAWX"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013046.outbound.protection.outlook.com [52.101.67.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB5B1F37C5;
	Thu, 13 Mar 2025 20:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741898743; cv=fail; b=GJ8ipzzgj8ZqHXqx7T/Ae1ToRXyz4Lq73f1zkt9aqHDu3wnCo1QjAI8GE0xDxvARSXMUeZCjmgKNh/fj3qOPwSdzk4+xudARzwz6epFxucZQAdhzglD15LSMwVkL4rFtSwhCtfoteyR+BJ3aIA88wAfLGkYmz+n4boqMafwXeb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741898743; c=relaxed/simple;
	bh=IfvwgIjmkSIsaatioYU3Sdzbp0qN/F9ZSZV14/Y8g/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SM7ZSyOLpSAxu2rO8l66o+Vpwv5Ebrtu5YtCKntM6rhoQToPJJeMpmGggAmdvL14ESIXgO6/xlgxnrH6uhNrR+qUmfsUiM+FtHvxy97HKHKNZ+sJsAl39LIrxP7KSGB/FpIh5SkzagsmymwObtWyZMFSf3WUVDnvMBO9TUluupw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=W+CuQAWX; arc=fail smtp.client-ip=52.101.67.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ATKqOUG6GHT0V/JWaGSksAFUWLrwfQnRN7qtEIMh4iJ9T/WZj87kWlQVr5p+c3MABOEVDP10DspWcqaheBID7epAfXn9ZXNUTB+A6vG06ppeir+tyvDTlL1tnRu05OqDQEYTTAVI2WZnZy6n+Sb3Ch3C1GEA4RoGInIBZqFiiPZEgDb8aBPTzacAMJw0q4ipfUt0I1sm7YrU1K4GXQQP1DgaKIib0zq72fTVNM3nOJoLYPp3XyFxcugoicUWwyEwbdfmEje0XMV2tFyG/37UEVwasLkQK7lXZR9A9+dqZSMHSdzxLMLfonNqvaM94abMLQ4GGrgMOXKVWhzlvElqPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SJYvvswhIBKLMo4PBjAdgYS5okGNAlsPnsdeAl4fXSw=;
 b=BX1DrrKi/0/FJJ8L5+NouHNx2wd/ZmfoyamatWPXs94PI89fzEJq7qryr0yQsegKNX/DgxAmOvU+L1ttyan5+eGCgQ7ypo+wZxwedyzoN15/njQfUx3D9OfUrye8zPzlmkWb35QpDhmVNB0Yq/cGI6XJU4+xZzoUeKlA9p6/OFvRn/2TapA02q+9/EWshyveJRaAhm8egCQvhbzo1293kW4UFerPuef1yStf3+StqYjlfLICOE5hKqzqXF8O6oEdS1pdBGyfu52JgPGpnv9cTRhWdMuWZn2+XhXVl/3eVL9yT5KM84ArwYP3tPHCC7oKMMhkyU2rDt/iglTDLYflnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJYvvswhIBKLMo4PBjAdgYS5okGNAlsPnsdeAl4fXSw=;
 b=W+CuQAWXmAJX2naShk+itCE6Trp9NKQwa/5FmYi0nRmu0MH6FzZA+fB5S7CbwOGT982KymDhOhjdzrIZcny44F4128opPGkLhboWqvV3vPBS3oU864XpVgD7JDDSk3oiWilWPK9fyyVKWrpAIQAKyO71FyPcu0AA5KxXy487x+sw73kkM0ojtw17/phJpkd7WFF/xydnA7BwD2WohXyg+h/hJbvMZ2c4rBBPm18Pg8KM340mJsHsMpGwOAe9ob5yjJexhE/dDn2z2Xp2VTfplyBzw7FOOZ3ZW66RvIjGFB0FeZ2UriLE/C1gka55Kti9Q6t2DL0g6Lr7TYL/E2RvVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI2PR04MB10642.eurprd04.prod.outlook.com (2603:10a6:800:27f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 20:45:36 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 20:45:36 +0000
Date: Thu, 13 Mar 2025 16:45:26 -0400
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v11 04/11] PCI: dwc: Move devm_pci_alloc_host_bridge() to
 the beginning of dw_pcie_host_init()
Message-ID: <Z9ND5vARXpL8g1t/@lizhi-Precision-Tower-5810>
References: <20250313-pci_fixup_addr-v11-4-01d2313502ab@nxp.com>
 <20250313192254.GA745234@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313192254.GA745234@bhelgaas>
X-ClientProxiedBy: SJ0PR03CA0339.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI2PR04MB10642:EE_
X-MS-Office365-Filtering-Correlation-Id: 95a92601-1c4e-4118-2426-08dd627001c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+5Q5lazD8voXHyw2c5dIPnHGyZfoPsc4JSUZgpPZnxAkFVHVYiWUSNde1ZT8?=
 =?us-ascii?Q?S1gX0Dayi5VkWubu63MmKdD+LNUU3tN+jQFbDt7RnDomzIy0xKAJb1ARsx9e?=
 =?us-ascii?Q?V88U1fNuJGBMwxbolrDnYDRVJ87rLnQZsgbfU7JcPTXX8e9O7GjpOfxViafJ?=
 =?us-ascii?Q?nNZJyizngYMqvcxV9IlItur2RidHAhs3Vo4hJi3GpYsxNpKVrn6KsJxrcJyI?=
 =?us-ascii?Q?TV1D9AdKOPPLg9T+TxOO9TzG57oNbB1WSblr0BzYQF1aF0PMAM0OU7AFkqnZ?=
 =?us-ascii?Q?ooecD3C5JwN723YcRy6Cldz9GfKYd0by2H0x1JSCmjlT1Z0V9NX/swmv3Ng5?=
 =?us-ascii?Q?yYaj8jACd9FwA2vdxiK+oMh5TkUClfE9OgyQZmoW1lY9Hwqi5d3cW2ZC7Bs8?=
 =?us-ascii?Q?lelfvWDXdWVRHnZZywmTCNiz3hhKtQ/iFhYV44C9U7u25n/nf6ezU2EHhBJW?=
 =?us-ascii?Q?s1uGXhsLqOoniJjCcA14CnD/s1/RGDIxNEU4mlkwr+V9WTEqXG9xAkh2aEyK?=
 =?us-ascii?Q?OaA8YuosimLLcEHRvkXhdx7eTwrMRlzHFVL4i5PKLVyRqmX1Bl2j1uLqFe2N?=
 =?us-ascii?Q?LDjQy7teN8osc+JzGsBEa3LigB5GTulXPxAUu3ybfqCkUkVPhnaOz1XduAZB?=
 =?us-ascii?Q?VDBqt7R0p7XJFtj8Dsxc1lbQPWzvDrzBf+XLPmMpaagMUNWYGl1GnADk6yUI?=
 =?us-ascii?Q?ZlZjmDJl7FmkX1FULE1GB3Ez+VlZXtXbegq4ky/NWojrVS/IUsXQePoKJrsJ?=
 =?us-ascii?Q?u9hHJbK16iBqtzPnpTaMcEagnJQ2P9HoDV8eeTaIeR0j8xkGvWHUStl+kJY/?=
 =?us-ascii?Q?w3I91AgrbX26eOB2toG5OFDLTuSvBg/8RcE++LzG82qQJbbx+OJNQk1mpLQH?=
 =?us-ascii?Q?WBuTXr8JWhZzjVHag3cgQIYHClnjzL6e9/chfwr1mfl/8Ww4yOAZ9mitSoxM?=
 =?us-ascii?Q?T53zc9RGhXPW+RflBqi4ISEhzWI8hIcCnbsL79v++T/gdQ6X4OVnKLPYGZG9?=
 =?us-ascii?Q?lt/RxjFtbByLnc0Le6pK6mmi07+GJ9qbtAY2xk8LY+HTgU3m3li5oe3VjGMe?=
 =?us-ascii?Q?oaCa23TyNNlNBqxAXskUyo6xUMWG8DKB2qp7f36NlQDFY08tsGfmHSaozEnn?=
 =?us-ascii?Q?hd+iFPFGVrLqGAxuqspjNRFPygZvUFngVetzCfeRlpIuDeTBm8zDYvrEtGNj?=
 =?us-ascii?Q?FvmXJwyL4TRbGEpkZqFNf6qmGVn6cno+xKbb/1Qpzhk7fp9LsH3iSVl22ySv?=
 =?us-ascii?Q?zxeWpa/g39s2fwIn3y1dr1v5/qfICqxz5PDICa0cTnOa8a5oDaOWEbZgms+8?=
 =?us-ascii?Q?A1ob+sFCXRIFnTXy7KOpNWBX6U1eeRARU7GP2tFhuiA3uuZR8Z2Jk3DUFdQj?=
 =?us-ascii?Q?2XiYbetZblcqo2Qq/3x4YCQmzDahefOP4xzMtB3py8SXSd1Y3HnHVdVWtBUV?=
 =?us-ascii?Q?CSP2DncakHAGeee7dZM0KyEctteHlkPH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NpiD9EY3NgRFrjpcFMtCF11EHiKPVXnvYJKiHgUqzCWtVtRe5Rw8SoEekjWo?=
 =?us-ascii?Q?DpdC9nLmR5rPmplBNFOriz4vqp42pY4DcBAePV4GeadtzWSKxl+Yfh/Jof14?=
 =?us-ascii?Q?k2gYgcHs2I4sKaAxXI6ea+mop7+zymAYo++GvAjSYivjXjjCm90hYVICsNA8?=
 =?us-ascii?Q?I9nNUk67szDL16C2hLS5mLjwnfusMhYi/E7aERjY2b1QRrjVp4xD/Y5TaBbk?=
 =?us-ascii?Q?WgAwkr/FWylsJWjsrI3Z6OlkA2IwySKKIaWpD+rvgmnBEQriztXbgrfBQvun?=
 =?us-ascii?Q?tswGYlaaLJUr8mqjSbmiQCJqiqPM7YFBottew/CpAeLY+HA0ZnCWqSJZjLor?=
 =?us-ascii?Q?YgfBdfz/lq+/GtjjsMU5Kbh3UOBSUD2BoXnnskr3JazCrea9ikbYni5PZDAa?=
 =?us-ascii?Q?3Rf+IKrQOYcOOGAXk/fhhWPisb3JFqWOvPu3PEMzH083ZHhUgVD8gmM/yLXI?=
 =?us-ascii?Q?Qsc/sKmD6GRbwlWO6pztgD9XQfE6DvqPEiNOmREfTORxhKKz+MN9fxp3w00F?=
 =?us-ascii?Q?cswYX5QrsdG/5BP44TVWAnF93xtg2pvmsVpcDYlmQBABrKE/DrDwSpY+9UG3?=
 =?us-ascii?Q?lQlmxWiVs++rMP3VAI9Y/76GSMdPP6CqMUietNP9R/G07ZvI3v+ugS3f+urZ?=
 =?us-ascii?Q?gVM2TPlVoTdBwx7s0Mf2zKpLiiwBhGkfjFyI/FUoXO7o0sZ+UlhjDl7wS6GW?=
 =?us-ascii?Q?Id5bu6EGq9JuBlRjQakiACFiJ1pxysspfkI4UgNWvnE+AqodBMnAJmPz4KZn?=
 =?us-ascii?Q?ExrYPQqpqv1kyYPAyjxetd3clNUiKf/KOLR6VXOcguY4SAUMD4YEmJtjqwj1?=
 =?us-ascii?Q?XrXl3JSxGjhlRlWuVMSymkE0h8nV7skN3JHJHn3snjFfXi4VsesqsoyV2ei8?=
 =?us-ascii?Q?RaNRIOZLCAOtTUbiccXSf1XQHTAkaFL9AyGFqeeGggaSaSG3JVWSYSSEhobY?=
 =?us-ascii?Q?YGRzvZo6ix1w9gub1OnCjezmSDH7+JejLZ+fix7D80czoL1I+Kog5XfYi4N4?=
 =?us-ascii?Q?sAanbK8WxsllwpRl0b7ftZ9u5dz4ABRMHAWH5EMKm/XP9689gGHSKMa4ccwt?=
 =?us-ascii?Q?UNiKt+jIRMZN7Vp8rL0Q02FRJsu3D0GxXrykkxYUXJVYMYxH1TBw+GERPHsP?=
 =?us-ascii?Q?L40s5rbF9ZaN/AZRvxoQefRYer5Uy2VUrIug080nm4imPYpMWbG/EESLXRTQ?=
 =?us-ascii?Q?ThCJ5cA23ORnBmAD0X01xeA/VKsACPoEnykN4ncei/ZCiCgbXRaDZR6WEL3Q?=
 =?us-ascii?Q?5OwMnneAMKAlTEI1uYggocFtZI0poTtAbeRzSCV9RNZffyV+BAT0JRiTiGbt?=
 =?us-ascii?Q?krPGdl4WlYOat4GsSq2NzH0o0qsujNeJGxCCRFrP5upyBqaKa0myMr1IneUr?=
 =?us-ascii?Q?RYFiV7WXzWhVV32AwJRYLMJFatdKE0/DaORt22URhsX90f3z/5R5GBmCXVoP?=
 =?us-ascii?Q?XcJNxQjIQejZLD8S5vXHIxDyVIeMcjlYlTLsp3ygtpYYTbz86tZoX/GUGr5i?=
 =?us-ascii?Q?BikeaR/moWCAL7BFmzLk0nK+/EbUH2D4kESW3/5Jyx/dhyBEguEk82dMbCSP?=
 =?us-ascii?Q?khiUO6gTVUdsvh/B7rA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95a92601-1c4e-4118-2426-08dd627001c0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 20:45:36.3221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BA+CfOpxS9ffXIHit4ioM6QUvvmZ4uwBukA/wnPEdvQtdQeaajisTp9hCSWXpDyzNEMmqGWYUW+FmzQ4vA1Reg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10642

On Thu, Mar 13, 2025 at 02:22:54PM -0500, Bjorn Helgaas wrote:
> On Thu, Mar 13, 2025 at 11:38:40AM -0400, Frank Li wrote:
> > Move devm_pci_alloc_host_bridge() to the beginning of dw_pcie_host_init().
> > Since devm_pci_alloc_host_bridge() is common code that doesn't depend on
> > any DWC resource, moving it earlier improves code logic and readability.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware-host.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index c57831902686e..52a441662cabe 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -452,6 +452,12 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
> >
> >  	raw_spin_lock_init(&pp->lock);
> >
> > +	bridge = devm_pci_alloc_host_bridge(dev, 0);
> > +	if (!bridge)
> > +		return bridge;
>
> This returns NULL (0) where it previously returned -ENOMEM.  Callers
> interpret zero as "success", so I think it should stil return -ENOMEM.

It should be -ENOMEM. Sorry for that. Strange, not sure what happen when
I copy/past code.

Do you need respin it or you can fix it?

Frank

>
> I tentatively changed it back to -ENOMEM locally, let me know if
> that's wrong.
>
> > +	pp->bridge = bridge;
> > +
> >  	ret = dw_pcie_get_resources(pci);
> >  	if (ret)
> >  		return ret;
> > @@ -460,12 +466,6 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
> >  	if (ret)
> >  		return ret;
> >
> > -	bridge = devm_pci_alloc_host_bridge(dev, 0);
> > -	if (!bridge)
> > -		return -ENOMEM;
> > -
> > -	pp->bridge = bridge;
> > -
> >  	/* Get the I/O range from DT */
> >  	win = resource_list_first_type(&bridge->windows, IORESOURCE_IO);
> >  	if (win) {
> >
> > --
> > 2.34.1
> >

