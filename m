Return-Path: <linux-pci+bounces-21359-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C17AA348E2
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 17:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8497188F67A
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 16:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42D91531C8;
	Thu, 13 Feb 2025 16:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aqpbcDTk"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2063.outbound.protection.outlook.com [40.107.249.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D3A166F32;
	Thu, 13 Feb 2025 16:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739462586; cv=fail; b=fxf0NwhIBoPKsMqFHvhW9+hX69P6oDmIpRT3i68YmblbMpAV1mnvKmZI/5Sbx2lRfe0zAy83P1FiueYb/lrSeuF07PpG5qkEbJgHbfhIjOuPnacIOJeI5F1RijneSvoxeTMX8l+AXEQxRdFFD/8uo3CUuiqqcCS5x3eltMDooLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739462586; c=relaxed/simple;
	bh=aEDPIN4WRO18r8gul80gu0SirfF8Ou6oVDc6CCfMxxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=akWeUwLTXEft+MSJwcPa6Xamkfz75Lnhg0Dh2UbVmoSKD5guhIeyHIu1BR0aSH6tB7dYPrGRRIZs5/jg46TQ9eB+myCHBJO9HVV71+VwkQXBLQlPtZloXPRpER7ksEmxe7e0/apy1w3GCB2ebGTHITtEGxuFWG6oAwOwhZjlNyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aqpbcDTk; arc=fail smtp.client-ip=40.107.249.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bF+TIpn5S9khT+tqGGndPWk3PPPMDXaPUMuGrhh6dtNgOrpwJm08/zsrdogWMNkXdD9GOrMSIVR1uUaoI3ZikFMJrvmx1Zy3k7zj6o8iMUsY7FLPXWjuWDQl0hFvWAEvA3Lh8+PU62KtENSkksiGhueJVPR1uB3GRoqzLFcIVEX9WcE3NfOWn/K8e3HJRZVSbOIR5K7gqAvBYQffmJQzuuqQMqSd7b3PrdBuibTjrmUgosWHljer4Wc7RZT2JvnCRAHBA02lPEwj4RwUj1hRXjCjZpEPB8tLGdvOPamIg7XPV/84pJtPasalkI4dOHDgtRKFCk3WVRiUYMZIaVFbzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8XIjYZKid5PRsFmU/Lq4QXBxTtvZrSOaIUDUSbaAmaE=;
 b=V72SZYN9ulqvY2HEfwD1+lQ3qQqKVRyJ64PWrHY81Syh+Zfr2JX21CfChdksVox7HOKh+NMze+2JQsqlTWYiPnrFUnHkJqKk2hiwS/Vv7j3JyPgczwwMC4jPf+JOS/efuy4Md6VjxdtnuENt/A8uzqaCJ/MMyPufiTvioI9vGwUkT/C3+J4EkZNn1Zcw8FqMA0QIgdYBqyxKdHaVKovr+fqi78NJ4lFW79lGamjqjAMoExaoWJlSqo+RNqAXzcwais+eJnR+2GsBj/nenSMCMfucj8exk1sXFXs9KaPzyS+CIw1eCeehfPkAvaGcDOrH7YsN5scxcG57uV0HiS/FCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8XIjYZKid5PRsFmU/Lq4QXBxTtvZrSOaIUDUSbaAmaE=;
 b=aqpbcDTkDYbtIfmtIuKbFBTzjZfL4GDcXa0x1d2w76T8Vbx1ExH5eqo7cnmDPbAh6NpM9JKaqjQ82lvrZcFRQG7k751k9a9gniIxisR//+Kj9IFdcGnJMMui7pih1OIJh0Hr823m/cltk9d0Lql+QI1ymawYXBxs3UaR/IS3enlUALfg0miWHA88C/v5/QL7lng+wIaKW4s2vo1194STx5X9ecbT0ALp5RgiiVV72RjCVSd1qAvUDLHY+t80QuQ4/2sOvfrZJgYJfQn1vQrMAkGDIrYkK/OKFePDYtH3jG3BwO5vqM7fmS1cMagPLeLsrK6iQashl7LcYP0oUJCTuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7658.eurprd04.prod.outlook.com (2603:10a6:10:20d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 16:03:01 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8445.015; Thu, 13 Feb 2025
 16:03:01 +0000
Date: Thu, 13 Feb 2025 11:02:52 -0500
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
Subject: Re: [PATCH v9 2/7] PCI: dwc: Rename cpu_addr to parent_bus_addr for
 ATU configuration
Message-ID: <Z64XrD2a5iHmLyRM@lizhi-Precision-Tower-5810>
References: <20250128-pci_fixup_addr-v9-2-3c4bb506f665@nxp.com>
 <20250129232350.GA527937@bhelgaas>
 <Z5uifr5+JE0xSi2l@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5uifr5+JE0xSi2l@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: SJ2PR07CA0023.namprd07.prod.outlook.com
 (2603:10b6:a03:505::9) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7658:EE_
X-MS-Office365-Filtering-Correlation-Id: b0b4c0de-b43f-4006-feb2-08dd4c47e466
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BGXID2Oak03/FJLcyxj7pNufiuDws/AAIkLPF31xsSA48+zEkwujXn5/L0Qx?=
 =?us-ascii?Q?3gP88fKORG0j7NyC0H1ldZzXeXdsi9nsFp7JfD1Dtw1yboKJKpnuBzn4Wm/A?=
 =?us-ascii?Q?NLeDNDmUJJvkfxj04kD4tut7bmo8qhGL+mxSi4qOZPPtEkhuC8s/WA/leaPx?=
 =?us-ascii?Q?7ZnXlLL6okfUwwf2KBNlQyudOdBP7dxiwEZSm0GdxhyOIS09tiNzK6p3aYL7?=
 =?us-ascii?Q?tHbDwb5Z9AkwE0akzjjnHJjOKiWDtZkNv1CvvEmi0IIpwl8I0ZBUgPa6F3E7?=
 =?us-ascii?Q?FxwZQfwYAdiXztAbwDtSwe9DJ7L+UNJ46BAaDTIFqZ+0uI4kR1GjpmFp1ZKc?=
 =?us-ascii?Q?iwQmUhGQlFvCZqj8GHtNcSqPtzs8AYDsP2C3bqH+p7vJ4aHbkuy34KOl7xTi?=
 =?us-ascii?Q?A+BIFVuXabSDByaAcq2I1k674gGSnfn3thKUJ8H8l1a3pQ1Qey4Sfadwo44M?=
 =?us-ascii?Q?a1UYuOfaNkIQBUnXVdD086tAoU5b+EC70D/K9b3nYSEDPT1TXE0rpFu+sHdI?=
 =?us-ascii?Q?NeiKFLHofpUpfQaTrYgzP0C1s5sJ5jauHIM47XwuKXzmNgB9dthqK9LcT5yH?=
 =?us-ascii?Q?EiVrsnDmgE0lVidm76mHNkFBrKBF5UAhPbyMmyM5i1ylCkWf+Df20W2tJb6b?=
 =?us-ascii?Q?RahC/tc0rqOA4goIOT/JEFIYU1zxmrkQbh907K8LzjMpMij3geCs2qrzhODx?=
 =?us-ascii?Q?GsMtm0q1Af9M1oq4ijqSog4D1b7AXbSer3hwT8r5ZFyGk0JVmMm2LuQGrXGk?=
 =?us-ascii?Q?nzFGP4QH8DvMTgOFMjS6JX0KEK5yl/lZ8lQ8i5qRlf5UxpIqmtGm8gojCKdX?=
 =?us-ascii?Q?6qDxIHmyo7allB6RdjNyTodXKXkFBOgKQ6foxmUJ6pXo6TqWUGJqTF0CCIMs?=
 =?us-ascii?Q?X1GZou0TLL2jl0PSc9ldHZW4I/jsCs2taQTTgZwvzwRchQYytvHkvnxpBy6+?=
 =?us-ascii?Q?84OKVpTCXmpfWnhE/ZQlPp0+Na7RKrzCvCi92X/THIhYJTR3qX5z/85L3NkY?=
 =?us-ascii?Q?Z0VnrANwt90iusvddd1YC0RLvusv8FeKws9/VoS8DVDOOTtoAJRNG9aFINsU?=
 =?us-ascii?Q?1usW04QTapComtGdkZvxB0es+gfxBslu2ONxMTYpWNGsV7n23KcypugwFcSp?=
 =?us-ascii?Q?MkDZXi3h++OJLEPhVoMSaTgpcZkLbhzyLZBbYZLY+HQcW6MwvB94scaqdSgN?=
 =?us-ascii?Q?kM/6OYhjqb8GtRQomIgmr80mlSg405FZJ7z2YV/wCcjRK7FQFOijuqHaG4kR?=
 =?us-ascii?Q?PpwLj3tK3B/O3ApK2i0WtQ6+V6opW/KXEcWb5R+sdW1h4CTFzL5xc5Qfis2J?=
 =?us-ascii?Q?PaOh1fGe486iDlFQxIY8jcvnreh5z/1DZM5OopfcIidgf+ndd5AUWuLwYFPU?=
 =?us-ascii?Q?/gkH3XHCtpfkogPvvHmM6g+MTflo5UhEvxThPKsS3na7U2gqh1IJc/B63yXY?=
 =?us-ascii?Q?BmW7w6XHQYI6Tu5RTOOO2z4XWaKFfEPK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uLyrIk+k38XrlkFgFPAXyEakwoXPRKOd4eDubI8e7osXoKvxcMvE/HwbkEdr?=
 =?us-ascii?Q?YUtXWBfVmbzLEVw/OiQNjAEHQucjQcD8LW7k6F5HIR+qwuCZ9vom8/rScPGM?=
 =?us-ascii?Q?o1OAYqWUbMIf/jzVRsrpDS5fN/SLVYAeUm5cAfna+gcU/gInkJj3yp69ttHp?=
 =?us-ascii?Q?d2Dtpvn0lplEJaReYPmI4+DFAOplk6uUe4LMmcflN2ZmGWS+hkfM1GS0tChf?=
 =?us-ascii?Q?Gzr6LzS0E5wW45gIGjst9xAO/1J8HAojHnD4ttVgj7F+ln6bYuo57g/hlKDS?=
 =?us-ascii?Q?t7yK/qM/VIGS/mNWPgw8kUcMCdL/sQFG3vihWuExepJUSZTbfnQ4wSQo5egI?=
 =?us-ascii?Q?FVqhSaOl5XAQudYXF7L6+zZTeZAXTQHmeAhQsbKUPKbkBDT0IC6vZWptNDpp?=
 =?us-ascii?Q?PZ/7cXqU8WJo2x4e/Ivwn1AR+N6hCJqYZKwVcATFDpO51FnGbIOC7C5NdpTf?=
 =?us-ascii?Q?R8ay2PME/Cnw3b5RyK4l3d3O6OVYw5U/NApvpY7xTjBSZb0s7KemCbG8aeLH?=
 =?us-ascii?Q?dTv/AdAZWvqSVh/FgNDB7HGECfkA8wNntDS+kFqzELja7R9ernPLBN3yCpFu?=
 =?us-ascii?Q?TVDMdYvdonsgDsYiQGdjB126XQUnJHnxhEmJ8KuQ7wAabG5JXvsYdJY2l8Z0?=
 =?us-ascii?Q?6A3Qe5jGaFnBJVYDsY/n9syfdvd7xiD4rHnrceV8bhXd0rqYFIQovIBgf6vB?=
 =?us-ascii?Q?ZQ4c/MWFaBeY4DxgzPu8dWJzfdA+MBk2i0/5PhVEDVy5FGWuN2JHEMCNCvnr?=
 =?us-ascii?Q?OriAFoSguM0STpA1K7ekOu1x+o7ZsZejJgw1Pw9dSet189CgpNN1QdDCaIH5?=
 =?us-ascii?Q?7wGikOtRSs83H0SdaE2StQxl0BRX06u2XNFlLvzk89e9loAJYlktBRzUnQht?=
 =?us-ascii?Q?nsbKYRn4dWmTfgZZl4FDWyOIsvc82zMoGT6NtIKOGPoNxNc6J+RPZAWGPWxd?=
 =?us-ascii?Q?bLDwVLfedFhxNWBMTrSglWBZbkpVdNUc+pM5+wGoaqWOW5b2W7qmcNuBTyOT?=
 =?us-ascii?Q?xvU+q06I3gNMIKZzQO/DervdLBT0HqGgLAcmf6FHYhRcmyOlTI4JVfyJJaJK?=
 =?us-ascii?Q?gck85QP7A0q7cyNIsSyHopH665kJcY73N69Oi3pgy9ELBW56q7tt5+MV8sVn?=
 =?us-ascii?Q?C1WT66btwRyExEmK/T4RA3fJ5lAVzj3FruUpxh6LTDw1sixvldcDi51m48bq?=
 =?us-ascii?Q?mpmbQ7Bjnc2F24fmHAjqyrXsf25/cncPyfSUY+QZDUb2bFHsDpeCEuUokcEr?=
 =?us-ascii?Q?G9Wvx/bVMatWGZ+3o/orMZqXK63cDuG1PV9A6NWosbi0T/dVMbBKWTTtTVF6?=
 =?us-ascii?Q?GzSg+2VzTRCcaDnyMQ90v/U+P6ALR6NhD6UwVI7iw6V7mu0KPX/irkap8eX8?=
 =?us-ascii?Q?CKN1MGQinZUupKNvCVE7i4IVTWpy9zEze69vosJcTdeq8uyoMKmJEgKQ9anq?=
 =?us-ascii?Q?7W77TYdU63DxjkQobcnGL79078mG5MnP+1W2d/NcvnpQXHfJ+T88zYu+VWnO?=
 =?us-ascii?Q?z1torQfA8r2fJCQF1lHc20a2Qz1Fbt0Xy73rIKDGsWI6zb7XsrA3uYXUWW4I?=
 =?us-ascii?Q?USGWduVIO6NwWtDxHS0ryn4iBYnO807IlPphgvR0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0b4c0de-b43f-4006-feb2-08dd4c47e466
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 16:03:01.6547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GTUO/aEDUsVk+fCy/DnqKmmt4pag4mpr2KX/zAgdg0TO2L570lo5ADqoY4qlVvSDiqtodgDOU4as8/x+Y2UmgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7658

On Thu, Jan 30, 2025 at 11:02:06AM -0500, Frank Li wrote:
> On Wed, Jan 29, 2025 at 05:23:50PM -0600, Bjorn Helgaas wrote:
> > On Tue, Jan 28, 2025 at 05:07:35PM -0500, Frank Li wrote:
> > > Rename `cpu_addr` to `parent_bus_addr` in the DesignWare ATU configuration.
> > > The ATU translates parent bus addresses to PCI addresses, which are often
> > > the same as CPU addresses but can differ in systems where the bus fabric
> > > translates addresses before passing them to the PCIe controller. This
> > > renaming clarifies the purpose and avoids confusion.
> >
> > Based on dw_pcie_ep_inbound_atu() below, I guess the ATU can also
> > translate PCI addresses from incoming DMA to parent bus addresses?
>
> Yes, but root complex don't use it. Only EP use it. because most PCI root
> complex system doesn't transfer incoming address, which generally use iommu
> to do that. Linux already allow a simple map by use dt's dma-ranges and dma
> API already handle it.
>
> previous 'cpu_addr' is actually 'dma_bus_addr'.
>
> >
> > It's worth noting here that this patch only renames the member, and
> > IIUC, parent_bus_addr still incorrectly contains CPU physical
> > addresses.
>
> Anyway, call 'cpu_addr' for dw_pcie_ep_inbound_atu is wrong. Only one place
> call dw_pcie_ep_inbound_atu(), that's dw_pcie_ep_set_bar(), which use
> epf_bar->phys_addr, I think name 'phys_addr' is okay because most case it
> is refer to dma address space.

Bjoin:
	Do you any concern/comments about my reply?  how to move forward?
keep old cpu_addr or rename to parent_bus_addr, or futher work need be done.

Frank

>
> Frank
> >
> > > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > @@ -128,7 +128,7 @@ static int dw_pcie_ep_write_header(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> > >  }
> > >
> > >  static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
> > > -				  dma_addr_t cpu_addr, enum pci_barno bar,
> > > +				  dma_addr_t parent_bus_addr, enum pci_barno bar,
> > >  				  size_t size)

