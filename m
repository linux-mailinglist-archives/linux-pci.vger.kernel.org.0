Return-Path: <linux-pci+bounces-37682-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D31EBC2619
	for <lists+linux-pci@lfdr.de>; Tue, 07 Oct 2025 20:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC9C840082E
	for <lists+linux-pci@lfdr.de>; Tue,  7 Oct 2025 18:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C5321CC56;
	Tue,  7 Oct 2025 18:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cMVPGhVt"
X-Original-To: linux-pci@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013048.outbound.protection.outlook.com [40.107.162.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC472D5408;
	Tue,  7 Oct 2025 18:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759861584; cv=fail; b=PfeWL37Gi7BMkfxPVbs22+Q2vFk8+xtr+JxYrr0CbXnyvyqDH+olJngVqljJ5R7EJzfN3brEC4HiPebJ+o4cVi4wFh79zlYLCz0yyzSbE9s1vFHON89C+wues2kQ+lVOuk0gXR+0LK3FUGtubiFxM36kLuQVNcO5wC9mHx+3GB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759861584; c=relaxed/simple;
	bh=PNe/cT1RW5Q+VAQBCuvtPWRiQlgDo0Q4fsslGQdmG6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dj6119IjvCNTzHka4O2P/QaiqcHhdBF5yH7OuWo2+HpgM/R8TO7jy7cpofRwpWyqUkBATCugxifthKJjzp3YGQEALVeV8P6dtqDvSj5BqH6cEAyMLbog+WFTLk2eOTDZDN6ynj3YAOr93NoFY0I8xmsd0SnUN2gS3d5k8Lv+6oU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cMVPGhVt; arc=fail smtp.client-ip=40.107.162.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OhLvGrFdDYjoh2GOL10sW5dPckRpU9DvSUqcceDZVJC3lDrdXsJ+bzQaB02AZCQM9WITvkCFco8qgqh6v2DCOSFtu3Y2WGiHSM20SKaoJwnVP3vSJOagDJfll4YFY/xUYp7B5edLFCvomS1k1XlhvBbCb9PDpCP1GQhpmBefB4DWQdZ/r8NyD9Rvv764JTbYtjpqZBx0cr+pj0hXedSba7+yzxPugf6S0jU5GbiAbIuat4MDbBB7N/V4YrcZa/WdOcz47b1XpY8zndRbE746GC1cwzuFS/osu32a8SEwaPSswRh1eG8RIYLPAxWuEZuJ3BY5wecEt3DemRTQj8eGqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=seSysImWzuOYGM6c0sowXSPZ6gFr0hKF3miAN0iNZBU=;
 b=n73IiFeim5D2WsTLS3S63BE1rvuErsq4DWwGxNBJSio8Bh41dwVqkk7MoL68qSKCryQ+Ya5EHs8pSO1/mjp78VastuuBtzGvURlTWHczfR3QqAT5uUX+i7UeolutS/dAUEL2lszxdD+Vx1BsCNJ8Wt2o/DI/3RTnhOUX213W7AK0uVTbbcDlL2wJ/BRtczEjNjACaLX0RpIiT0rsrHWcf7PMamvsmW1UZAKYj+U4a0oxegw9Lk0p0B8NhOmDCAXerOfyrgCnzKtFVzdjwvTtatl9JSBpiusdG2WLjjwNqQtFZafye0y4EQ47z/1gnRrxv5N+8JOHJSBmZbdrK+yMFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=seSysImWzuOYGM6c0sowXSPZ6gFr0hKF3miAN0iNZBU=;
 b=cMVPGhVt0m5nYw6M8+bQRU120rKZGQ6qxkyd0KlJdu3ma8d7RGmrYPR/Dn77PaJQH3d4e4MWc+isokJyJGGyNCe0R9L0pyApNfTLQgCQYGJVbvqtzmfxaYpPxI76QYXwZm8RgK4XSBMJ9wsJwKlH6Bw3dmzrR+lOd10HAty5Lmb8G/h+W7fgWX9Vb2BdbWUWm4eyFiz19SGEySAO/KLN+qn2E3gUgBN7BnAoP5sztevWn2UTdwgUob6VyEfi+moRvXj5lpT1QVCEo1+Di7WBJhge40VZ2tNWtbp+SWJ/hPX/1JAIvoMwCDi84PFHnpvAuxMQFOO7YwlSBMPj4VfAHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by PAXPR04MB8350.eurprd04.prod.outlook.com (2603:10a6:102:1ce::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 18:26:19 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%2]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 18:26:18 +0000
Date: Tue, 7 Oct 2025 14:26:01 -0400
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev, imx@lists.linux.dev
Subject: Re: [PATCH v4 1/3] PCI: endpoint: Add helper function
 pci_epf_get_bar_required_size()
Message-ID: <aOVbOb5UyhM7c7p1@lizhi-Precision-Tower-5810>
References: <20250930-vntb_msi_doorbell-v4-0-ea2c94c6ff2e@nxp.com>
 <20250930-vntb_msi_doorbell-v4-1-ea2c94c6ff2e@nxp.com>
 <aOOdaDdxCAkmGbkd@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOOdaDdxCAkmGbkd@ryzen>
X-ClientProxiedBy: PH7P220CA0176.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:33b::29) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|PAXPR04MB8350:EE_
X-MS-Office365-Filtering-Correlation-Id: b1831636-a329-45cf-02be-08de05cefc97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Sn7urrUWZlbfKVSTqOMPGoOC3n2+vZLsDD0psZnvlZkfv5Bk807CBY5vyIQP?=
 =?us-ascii?Q?QlhIRmlelNM/6Yu9kdcbi4S/9P8O9FK6Mm7uohz9LNh7oNK9P/8mahH8j9TC?=
 =?us-ascii?Q?/J5cFLqwOihVf3D/Ph+kBS++4aDDMM88YjvkHJOmZg4sCnYncm8fmSX4eaZk?=
 =?us-ascii?Q?NX8mGBIUlLUW19Yqf1XUUjRAelCIMdmOAalazcnHL+Lh6LnRkfArWL/xibUF?=
 =?us-ascii?Q?eIfYMTIdgJrRZWdCuc+8N501g7BOvhTC6SbTExIuNXs3tC4rZZ9oIrZ1LrIc?=
 =?us-ascii?Q?pIxkBdkIKGht8dPg2OWVQ95ZsHbuH5TONnkLnQnPIdUAdeOr419+ifum/bI3?=
 =?us-ascii?Q?FPWQdMywhOVyqgVJGKVepDkG14UWFTVZ7vXydQmfMxIa2c+0ITrMGIrXKSNA?=
 =?us-ascii?Q?wziezk7SKtL790TOuS+6uuIJpqCP3J73YItA1x1FGvv/dmtx+8J6X0lfNApP?=
 =?us-ascii?Q?9CovNDgcZUATunBulaOIsBQ6kJgsNhOXkpGgbyLhTDFgD2tYkx1+W1YOunGP?=
 =?us-ascii?Q?u2XIu03LcTQrUnB+F5d1jqUV9B+sVVl+9jQt5UstTAIhuO6iIFidgkgWRrJo?=
 =?us-ascii?Q?4omXWJjO6LHG1LxyG6dLzuGxrxFGuLq04/7e+YEoAjSGM1Pu4vSv/xGU7YgA?=
 =?us-ascii?Q?i/GOW9R2bpUwI7wQE5vbXN9HR1a9QY7WyLyr7WHwE8+T6kZgY4/EaQcpqfee?=
 =?us-ascii?Q?KdTG9q4v7b5ZpwtmfHlcCW8ex8DYt5V3LmkDxOqVhAaReMHOY/BkqUgzw/dT?=
 =?us-ascii?Q?dH1GIcjZMiYz7mX1Ii7b9BQ9E9hR4WWjG4m5HaQBb75Sf5YFScKzNZDhUgKn?=
 =?us-ascii?Q?1OUmSYL2xcUaH2mfCjEb5Rq2AGdonRLGFs347L7ntIk6e+WJm8wU9tFbNeen?=
 =?us-ascii?Q?ee2cI1Vzgsvd4rHwqzhP5Gz3bfJi+dSW4dPHDzZ3RDijkJwiySiRQdCcQtPQ?=
 =?us-ascii?Q?6A0QFAy/SRnIVTOvpkk5igPLvNo47iCFpBhTCYlmdzQqhjC54DyFzb/j4m96?=
 =?us-ascii?Q?1r7e3DNTaJrQmNg5j4d+yRSE33AAF/bufGIJZKjbB9Zw2OBPpHwf3ZeCYptP?=
 =?us-ascii?Q?UsZPOiuhlpBrCNwuPwTSSDdLJm3sH4qWqJ546Ss9EoaCpek3jHIrbfwElPIk?=
 =?us-ascii?Q?wGGjjUt1+Xfdi9fHLOvnV5gn66W811zRi84VLKNtXH6h8AKKtqv9Ggm53cpA?=
 =?us-ascii?Q?pVhGNB1Vsj5uN6YiJJ5X0MWnHCWhFgtFITKZ3R8qCXf6hc0UtILiz5Ch6del?=
 =?us-ascii?Q?4se4XcDCqpHgF71ARmpxH0x0La2HZE/IfqvLkGcjFlpf1deVE3krnYPSNTBo?=
 =?us-ascii?Q?7Bv0kTr7wq/SytWhAjdzqNRXpS/ikfENZjVZRCPg9uecUVRUocgIjMwCoKLo?=
 =?us-ascii?Q?wxAl6tVp2WxyXFtQGIzl1aLT4E4VS1cUMasjvbFMAlwbI1VO575Kkz9sPpyw?=
 =?us-ascii?Q?fPBB2dcB8zCZDl/XUJ2ZxnxaZ7VRyRyRekio1V3wWixk/Qb4Car0y3prinlw?=
 =?us-ascii?Q?4J6GLPvaCGbcdqCLrZkV/VPSmGmRiI2f77hF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hJ5S+Yt8OhmWfuOlcwjKySaRrkRl7NVrrgjN2irjpyqmzaVCmFxSJxzvxTmn?=
 =?us-ascii?Q?Q59Hwby2KdEFEUlvBXEEoC0b7MPvD2EJAAFtv3KrL9Qma5B1Dnv+iSQywRV6?=
 =?us-ascii?Q?1qR1JXvDt1wF8vhJs2m3g8xDbHHoOu2YRpsViNt+iWL1SWXioy481g3IHSr7?=
 =?us-ascii?Q?b5+h2JdIAc9FWYBlc8YdaXp6TyczmmYN33RbgKDhT1Wt62IRVoKxBXkX+t7o?=
 =?us-ascii?Q?hdmeziboHpKEF6l7LjfvdxagK6o5wYbpQUsLHhXfTdrpOvr+2oAKCZInez4I?=
 =?us-ascii?Q?M6LlnZ/Vo8xsA2qOTViJ7A21pe+wsP+fkMNSGdNsK7oR9I7FntpzPhDde+iU?=
 =?us-ascii?Q?qQtyailrZZrrJmdqH6VVg+F/iROrEA9B4OnWHZja58nFU299gBZMCb4Hqrgw?=
 =?us-ascii?Q?u1Fsp+GnfZIDwkLy5dShuYUfWBynoX4IQge0a/ibOkL7oJbgXQQML4/VT4MR?=
 =?us-ascii?Q?u+yTzQlg+q4TCUZPKpjd1a14+vt3qhxOd6HpIvZ7nmICrCAT3ShoGis+UJ79?=
 =?us-ascii?Q?5L6ytzasGDlILAy0zzUp/mL5az+KCic5GOd8878fTjrxZrTH5W/TH5HL2t0s?=
 =?us-ascii?Q?/2hNRJvk7JSTcRHsCvR/Uo71+6LSj3pFDoM9gAGwVruwRsGGeHOmiMcsTuq2?=
 =?us-ascii?Q?AnkH/UEZj+6P1R9n6qkhbAxuKZKWQLIW1q8HIAv8oEYvLLwxxoIZA59PrxZM?=
 =?us-ascii?Q?qxbs7r5UfCNug852dFKJnHirLSdIIf27pJ9pvcme1DEVwr+pAiaA2lb6M2Oi?=
 =?us-ascii?Q?WPHsawnRmbFGrEvz1yBc7mPGNWBScyc6D/AEcflIisDMhyhmMz/MhFEuEi/l?=
 =?us-ascii?Q?cqSRy/a2eF4KnEY8PhkrH8tqrxXaQm+u6EyTYYWb7NjjWdWCkgDbO8fDAwgG?=
 =?us-ascii?Q?Ef2IFsm5DgFw9CHgeHCVDjiuJ0lOqMpkixGWCZhoVXVkTgO3fdtWn8mQbsQi?=
 =?us-ascii?Q?BEmYHJy3KJ+w3nnojHj7iYfes20YyUm2vRLPOhfaF/a2fHX5F0bBtG/sGSsT?=
 =?us-ascii?Q?ILw5Ipl6T8f+6hRVheCwOyDvWuKl65E7ZgI8QzLhLTLSCh8UL6tXzbGSDn5j?=
 =?us-ascii?Q?s6nfxvnB3vQGRdh+LqGpvNDf1yAZwgTeRCDSpikHHr7m5gwxoymovkBdE3sc?=
 =?us-ascii?Q?eMjzksxhep5b++6Inn5++Q9Kt3wSt5q5AuX/Y4n4PsIPTMDqGv+eDkoCbCqs?=
 =?us-ascii?Q?cxC+AGqt1wSJow3QlcoliPv5N2T31312E2ekvbzxqsTRyYhqZzxOB2Y55kx4?=
 =?us-ascii?Q?hLzz28pdk0Gx/u8uDF4iKKwTzQbxNyHd7FCkpmiAwlfYiXH4D4oRqATG3JCV?=
 =?us-ascii?Q?XlyXMG1jJNTi+o/UILwGZWFxfeUbcZoe6nl+LAqQaUjIRSPtKO8TbMiwCFEj?=
 =?us-ascii?Q?eriu5AFposGQybmhxBR62LBgL3bG1FiTTnsk04MBeG+kvof7snYorkinVdtU?=
 =?us-ascii?Q?YgfF+0LmtkK546OIvqdJIF/XwZOj3vZ6Ludl0VBmJcet6khzlZ94jsNnxlc2?=
 =?us-ascii?Q?cQoklS5aGemOshb3g5O6AVhWjA9MmwKf/FlgVL4WyQ161pQXWkqyijCKdekF?=
 =?us-ascii?Q?9/vSf34KHjNtb1+ihPs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1831636-a329-45cf-02be-08de05cefc97
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 18:26:18.9051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oiuo0rhKofdy/dNJ/1UhwwZnEWNsdLxOyH4I9x3AcscxmWhfUO3ZmB3E/BRZmy7MLkLFUbEn5XG1ju4KMYORag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8350

On Mon, Oct 06, 2025 at 12:43:52PM +0200, Niklas Cassel wrote:
> On Tue, Sep 30, 2025 at 04:39:37PM -0400, Frank Li wrote:
> > Introduce pci_epf_get_bar_required_size() to retrieve the required BAR
> > size and memory size. Prepare for adding support to set an MMIO address to
> > a specific BAR.
> >
> > Use two variables 'aligned_bar_size' and 'aligned_mem_size' to avoid
> > confuse.
>
> 'aligned_bar_size' has been renamed, so this sentence should be updated.
>
>
> (snip)
>
> > @@ -308,7 +327,9 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
> >  	}
> >
> >  	dev = epc->dev.parent;
> > -	space = dma_alloc_coherent(dev, aligned_size, &phys_addr, GFP_KERNEL);
> > +
> > +	space = dma_alloc_coherent(dev, aligned_mem_size,
> > +				   &phys_addr, GFP_KERNEL);
> >  	if (!space) {
> >  		dev_err(dev, "failed to allocate mem space\n");
> >  		return NULL;
> > @@ -317,7 +338,7 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
> >  	epf_bar[bar].phys_addr = phys_addr;
> >  	epf_bar[bar].addr = space;
> >  	epf_bar[bar].size = size;
> > -	epf_bar[bar].aligned_size = aligned_size;
> > +	epf_bar[bar].aligned_size = aligned_mem_size;
>
> I like that this local variable is now named aligned_mem_size
> to more clearly highlight that it is the aligned _memory_ size.
>
> Perhaps you could also rename the struct pci_epf_bar struct member
> 'aligned_size' to 'aligned_mem_size' or perhaps even better,
> 'backing_mem_size' or 'mem_size' ?

How about alloc_mem_size ? which actually used for dma_free() function.

Frank
>
>
> Kind regards,
> Niklas

