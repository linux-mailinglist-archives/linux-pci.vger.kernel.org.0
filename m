Return-Path: <linux-pci+bounces-23635-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD8DA5F768
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 15:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A19D19C293D
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 14:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E27A2E3379;
	Thu, 13 Mar 2025 14:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="J1P2WXvc"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011058.outbound.protection.outlook.com [52.101.70.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C782261389;
	Thu, 13 Mar 2025 14:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741875467; cv=fail; b=M96fGYz7NU90B6bZ99rD/4xyduWwsBzoauVNvooB0vGUFnBgwYnRp4cVNa+j5bdmbKeJeZdgtBvDivGoyA3My1LPQdhXuMU5EZqhZypWSQYb+oGexOrNfa7nJ9Y7FcTgyALBgW91ECZv7cm6D+7EBHoxwBP4JLIu9UViF8wp0hg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741875467; c=relaxed/simple;
	bh=OnB6bbg87R/lUPafqwbo9ZvWmOy9ljQk2XGi/0OBozM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RXrTh3OFQdNj3DkJd9Z80pNwHcMPfNZI43jUJg0ItUT/MlXENpH8yKD3SbxSMQNF//41MAhen3P6Za3yFNKsoB8hg2J4Fsmtb191YVBPTu4kgEdGRXfLwMRyP33thBFyjPkp2ZDSL+c5aHeX//zUUv1EVUtGcYd6iG5MTNf2AZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=J1P2WXvc; arc=fail smtp.client-ip=52.101.70.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iviQKc0BIC3OWSo+XQ5DL0dFS4mC3geXNH5jzMNzP6JR5yxGB8Fn9CBA+XooCTDWOt1yzgpZAUiBinobqK9qw3ce3f3DoplBqKTDtukqXu9h5CX3Vx+pp/pF6RwDLo/Whqy7JBiu0fN2amRboYr9iRb/sMRWmz0e3pmQWYdMa5pVl+HWwG9V9xXq+3pQZsnzojJoayjtKOd19LgsmG1ydZB+tPv7HahcdWCUlXRJpzBEKj6D6VRdb28lKs3w3Jhq/adb635j3SnljTA5tpMdIsnOf1cm95+seR4YDuwS9JO1BKRWYfYVb9/HVfhoZ5PcL5f1ogcdjrIfnwANEBKyTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+P7lHCUhJrJCfiE+VvN+6LIYdITyAQT/N0PRRaD6I8=;
 b=qx6Eq+dV0OGGWR9nvR8UDVGXLAGbE4CmWPX/Yte64ewlqxwpeugcJE8b0lfKg5z+BspCOYYf9oLib5z0rDckN74+uE/U11bzmStoxHghzoNt2VmGFo7h7/uMM2Grnt7sRXUWISsB9hDTBZ6Ew6jICK4GnZM3Mss6PBUKGic++62F4GLX1BsGMYMLMwjqn4tngwGjnHE3OL7LjvXFaVlv0CjToj4avAmp8dFh1skfE/xJx/y6GVRZoDSMMKbPx04kln5RtIQTyX56Bx4VFiVQED9N/ypw5j+7rECw2elcpBTSL+pkKU86Fm+8m7hbXAGcOTXAA7FWPgcZyzbireaSPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+P7lHCUhJrJCfiE+VvN+6LIYdITyAQT/N0PRRaD6I8=;
 b=J1P2WXvcVY46yFyUeYdpotEKxZNSdmKkjLT3mlTlQBHOzgJ1l/FYNYNTX8TTAiPcARIdfKFgUAoLTYewj2YruLzYtfTa9/wUWkg571lYd//CNxjDazlh+BoWhAJ/svPt5iWiAmyFT2yhQ+yzo8MkCoSvwrwGGJE5VBbiD+ROP38lxvVdHlaCD+/03LHxp28eC+ds0DLsmq6r4mtEnlczXjXq9V65YqRVnv3CXPj0Pu8jxv8mco0UO7UmWCDhUryblN9wklDrnuV0Ea/D1QIHF2FXhiQhdkmD0349OBOsdg4926YiUVyPEYvWO1OsKRI22hVvkuhs6+E+jK4QvqGIyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB10385.eurprd04.prod.outlook.com (2603:10a6:10:56d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Thu, 13 Mar
 2025 14:17:41 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 14:17:41 +0000
Date: Thu, 13 Mar 2025 10:17:32 -0400
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
Subject: Re: [PATCH v10 05/10] PCI: dwc: Use devicetree 'ranges' property to
 get rid of cpu_addr_fixup() callback
Message-ID: <Z9Lo/PWsjE5Yq0Du@lizhi-Precision-Tower-5810>
References: <20250310-pci_fixup_addr-v10-5-409dafc950d1@nxp.com>
 <20250312213757.GA709739@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312213757.GA709739@bhelgaas>
X-ClientProxiedBy: BYAPR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::25) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB10385:EE_
X-MS-Office365-Filtering-Correlation-Id: 617b5df0-4244-4525-d385-08dd6239d0e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/bfzK8CHhujc1wl4QKP55xXX6vNja8XM3GvH3dmvoLgHbU4xPKBSc/0qfyvl?=
 =?us-ascii?Q?KnTrAcYXPfpywjwMYSyP6Wrrj8pdtGA5BIER92N/ViOk1aQuW8sENiuuUQth?=
 =?us-ascii?Q?15bctZL9tWJkN6PM1aGB55vhDjNpvjko5r1QF0Nt9LBnyxyVfmFC0bJvn45I?=
 =?us-ascii?Q?ZsOM3+lRuAF0Mkpd2bKGjo4to7amkza8xU8XuU4fsimdqM52y7dnX1hbLWlv?=
 =?us-ascii?Q?XuYo7FZ02VD9Bj3RlfWMqPs1ILIqrwxC4o1cBZbm3nhlWgr2/RffvRtvfX2K?=
 =?us-ascii?Q?dmtug2cxtsQ9JTFB7kRjYzBBlzRFrd3yqvwBiUT3rIbwIBltcXXuPz1DRTf9?=
 =?us-ascii?Q?csiU5ADMXBsDHbCk4caSW5akBak7cXIDcGSqj3KfjTL2TAmYiyLqctUDBk8l?=
 =?us-ascii?Q?cTHGf1UoiGwrZsKgx3cpHwncsNtkcFTkmieEPnbrfIyZd0VVFx9AiiOyPE3R?=
 =?us-ascii?Q?EgMW1Mlc6IoQjZI8S54WzPmZ9YT/SRIjPBMjGOBmqSuDxheOviO3NttST0WM?=
 =?us-ascii?Q?b81DO+fJjxfNy352gRn4vHDeCK8y8h189S516K8qf81L36ebLYrxQpUGmrNA?=
 =?us-ascii?Q?w63J07e9oA0mlQw0y64nL2TJ/n/Lvho8dNxvCOXbUOG24RkMDe/F26Jz7iG+?=
 =?us-ascii?Q?UsISuzl+OlfqHcXSzR9Df8rtmTLjI3iuI3uUQyDwpjiMAtOUkIiE5YJI7eJv?=
 =?us-ascii?Q?+U4k41Q1NI3O5Sua8YZ5RHokCakmtrvlk65bdz1BJL1tyKU51COo9BAHpeYG?=
 =?us-ascii?Q?IeS3LdazOqbWT3oiwQuJ7tNod9KTEFyY3gvTblr6l5Gri55Gi83U8OMAok8U?=
 =?us-ascii?Q?fmBQFoiaF8ih79N7EmzcGeZkP/aDLV90wYLsjnoBsWTm33Y1Wl0WXNXsesgj?=
 =?us-ascii?Q?s5+GHBqBoY4bzwLSLG+00ksNPCckABM97C5VuD6KxZMjRmQd0GOrUeamHlIN?=
 =?us-ascii?Q?qDRPrJTqEKHw9bGolR35+9NYr4hQu3HHg0vypmS5Dc2CL0pU3E6i7J4dl190?=
 =?us-ascii?Q?o1h2k3tKmcSscXPIVstWcZgkDF5aochavc6E0D1b8ok7Bv5Ov9z9qKtqO8zo?=
 =?us-ascii?Q?mAommMsJt15o7c2UdpyZk/nTslT2XBGQatS7GcB56BZ6UguvF31ZWueaKBRj?=
 =?us-ascii?Q?IiwHwAIYsN4q9vYc82sjUFpTrKCWv3S2mGYyiQy+8h++a2r9ZHhDgfvL1EFR?=
 =?us-ascii?Q?akHNXSRxLVDmFcAN2NnnDjCeGqz2QW2kpMJm8OFyLw5byICGqa21KEq1FJ8g?=
 =?us-ascii?Q?Hr8dT8NzG/LzwcqDMAyKuo+jVFmDG6y/XGtM55/IQsjk0xrBdpjQOUgFBk6i?=
 =?us-ascii?Q?IJcY3NAdYvA56inJlD3cnzSAP+B1Bn+I8h3xlK4Ger9qVpW7oxF8wYnrUqxh?=
 =?us-ascii?Q?ImE9ulApMCIesCjtPOw62ciQMkDOD2168OY+z/0gsrH2wwoR8JzDGtgwBR3k?=
 =?us-ascii?Q?aVpQtNORtUpVn24KXf6JVpj+wmBsVLwE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cYoUQBi3TvH8z8NKwdqpF7m5U7d9EhMMI8LmSUiv34KB30gaqVpSOVbMUiPd?=
 =?us-ascii?Q?zfqycVZQXwnOx+dUUxBLg8BG9G/82Jr/c+P2rRz2NLgll8ZDEyyJ6kwX9lDP?=
 =?us-ascii?Q?hLl8Xqupsz+OUDnA3SBKjrOusonH5JH3slhww8MOuKrWuCFYmcShzDncnuht?=
 =?us-ascii?Q?slxqKb52oPORv7YQCy52HKT5zq76Wyb7UohEVKBeLKZPL/Fhz0Qzb6L7b+uq?=
 =?us-ascii?Q?RfDEhSm/SzvxnE0Et4FG/H9E4+J4ecNw4CQa7IrFAg/Lyq3hsZ06XMqQD6bM?=
 =?us-ascii?Q?A5GIn+Z68A9XdhLs05nylWDsT0pyRhTZOQzob5OKahSbUo76z9VC+8hT5ugH?=
 =?us-ascii?Q?jw+ookImuDSW7lzHfPAeq5RpOaCRP60xnCrxbK0VCyoTOVqy7KswIAlubL5f?=
 =?us-ascii?Q?ktEYNGREQbjp4icnyRYku6CCcAF7Dfmye8InqQOxeFFjtl6VXbWxj0iyxc5i?=
 =?us-ascii?Q?GVtXM0XfamEFLDbWA0r71BtBoKvOqVfam5Q3E/TmVlDCotePWFSdFwcyGz3s?=
 =?us-ascii?Q?aF5V2BEOITAXH2Lh/u8LPo8axir+xP/afHFGxSMMJyi23mmEBW5q4yFoQOdY?=
 =?us-ascii?Q?xvgzUdCfx/hF/IQoc/TQEqkzzT6ketOIPPoHtK9Xq4NsNJJ0k1HFZ+mD4u1P?=
 =?us-ascii?Q?4bBIN+plo9u6Cetg1e/K+IeaVp2+u6TefU9oJTxQunP36Ur90B8fWRLim9Rs?=
 =?us-ascii?Q?TLOuNG5FuHwSv0E463iCXs/mZmprSNKGQ/gizqUo0IWjCZEOsmGSxKq8G7Dc?=
 =?us-ascii?Q?4frJYRz0Fj/bwVC2jdIfoan9BcUwxCXvFUoIpggd0wNPAFRDhRchfWttaL2y?=
 =?us-ascii?Q?BYluLyqdVZXzFJvwqBkKsnGeW9w+Y0HIu2Uj0/jQ5xmd3VSl0YPtxwauJgM1?=
 =?us-ascii?Q?OEm3AOBahP8JM2ItWF+sXTTC0ELweNM8RboTw/2fWV5CYAAfBDC1dRuW6OwM?=
 =?us-ascii?Q?5FxPzOI8pHzvbUd3o6Zyms/bHT4N6cUo22nWQmqwZaSgnW/mCCnpZbEkpofH?=
 =?us-ascii?Q?xX1zU+4PyMeOCXlu/ymsANAyXG2eKEB2ytAmWt2AZnSfYR/4I9SK5S8Ga5/6?=
 =?us-ascii?Q?0aYugTK0JTOllt3D8DytlN7gSbHTV2kFT0kZE81AnzHv7KNEPtkSFsuW+59w?=
 =?us-ascii?Q?4S+5HKERXcZG73BzvQAebitU5ARyYn5/vUayJcxqS8nuTdFc+IcoB9JTEPcq?=
 =?us-ascii?Q?UqgESgoxpwvMMDk83o1s44O90HzcPn+lNCykej1RCf2xvdcUBndcubZalV0U?=
 =?us-ascii?Q?lPHYQ416qF1T9mLFvzWhL6Rak9vSzJKbTMeTVc1Fq0t0vxsU+zbYC1Xof5Zu?=
 =?us-ascii?Q?IbHj3vs/nerS5+v9rmiXGm3ZAtu79t9BnvVWATMrrn+NqV8Rzof3mfwwtgrj?=
 =?us-ascii?Q?HBbzWY1L3dCYBHdlUbH0rLOKWeASFRINrUFlooerw4DCKVo+1j6LKlzs7VgC?=
 =?us-ascii?Q?lXm0jxFosjktdg2inu4Q6MrIPLotCbS+hUNV1trC+zkoYGGVFh3S8vFZ2gtK?=
 =?us-ascii?Q?+wW3ZrqK+9vMc/lQfdNfk0LojcvBhPgKXDxLjdJuYLFusFma4koAruoDdez9?=
 =?us-ascii?Q?6VT9igcTM16o9Z4FCemIpmX5eep213uxZp4xKv4+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 617b5df0-4244-4525-d385-08dd6239d0e6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 14:17:41.7095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tjcOuO5Vn+ZSsq7iMl9SvHRG6kvOFRQcrD1GNAddqivpE7XY6wmbmfy60cAoI5tsgn68TPA+OqwmGugP8eQ2/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10385

On Wed, Mar 12, 2025 at 04:37:57PM -0500, Bjorn Helgaas wrote:
> On Mon, Mar 10, 2025 at 04:16:43PM -0400, Frank Li wrote:
> > parent_bus_offset in resource_entry can indicate address information just
> > ahead of PCIe controller. Most system's bus fabric use 1:1 map between
> > input and output address. but some hardware like i.MX8QXP doesn't use 1:1
> > map. See below diagram:
>
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -478,6 +478,15 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
> >  	bridge->ops = &dw_pcie_ops;
> >  	bridge->child_ops = &dw_child_pcie_ops;
> >
> > +	/*
> > +	 * visconti_pcie_cpu_addr_fixup() use pp->io_base,
> > +	 * so have to call dw_pcie_init_parent_bus_offset() after init
> > +	 * pp->io_base.
> > +	 */
> > +	ret = dw_pcie_init_parent_bus_offset(pci, "config", pp->cfg0_base);
> > +	if (ret)
> > +		return ret;
>
> The ordering in dw_pcie_host_init() doesn't look right to me.  We have
> this:
>
>   dw_pcie_host_init
>     dw_pcie_get_resources
>     dw_pcie_cfg0_setup
>     devm_pci_alloc_host_bridge
>     win = resource_list_first_type(&bridge->windows, IORESOURCE_IO)
>     pp->io_base = pci_pio_to_address(win->res->start)
>     bridge->ops = ...
>     bridge->child_ops = ...
>     dw_pcie_init_parent_bus_offset
>     pp->ops->init
>
> devm_pci_alloc_host_bridge() is generic, so it obviously can't depend
> on any dwc-specific things.  I think the ordering should be more like
> this:
>
>   dw_pcie_host_init
>     devm_pci_alloc_host_bridge             # generic
>     dw_pcie_get_resources                  # dwc RP and EP
>
>     dw_pcie_cfg0_setup
>     win = resource_list_first_type(&bridge->windows, IORESOURCE_IO)
>     pp->io_base = pci_pio_to_address(win->res->start)
>     dw_pcie_init_parent_bus_offset
>
>     bridge->ops = ...
>     bridge->child_ops = ...
>     pp->ops->init
>
> and everything in the second block (dw_pcie_cfg0_setup() through
> dw_pcie_init_parent_bus_offset()) is strictly DT-related resource
> setup and could all go in a dw_pcie_host_get_resources() or similar.

It is not related with these patch series. I can change it if you like.

Frank

>
> >  	if (pp->ops->init) {
> >  		ret = pp->ops->init(pp);
> >  		if (ret)
> >
> > --
> > 2.34.1
> >

