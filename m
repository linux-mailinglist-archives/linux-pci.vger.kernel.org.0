Return-Path: <linux-pci+bounces-6100-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F578A0392
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 00:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B153A28386D
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 22:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079F943ACA;
	Wed, 10 Apr 2024 22:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Qi0KEEFQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2121.outbound.protection.outlook.com [40.107.94.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2BA1E886;
	Wed, 10 Apr 2024 22:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712789188; cv=fail; b=bu6eBWZrJgvRUgs/rwHUrG9a590dJwoGY5beex9r4V+ipRz2fPs5l9zAnt0u7N8/51J9322bKAuJE3kQPgxdKRVVikzAPgbRXypLviehHWyHB+bXsKe6jozzXDd1HSmssDyYn2WweiMeSGgCgS8JHELFG7fxn0lPD5rh90AJ5iI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712789188; c=relaxed/simple;
	bh=gWJZsw4BWLr/jjHvi26BVHHB1HK0PCd27HeoZAvnlPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bKvRZRebuv3GzY38zcP5WlTJ4Q73JzlXDB+TowKt7gNxwmQfC7dsyrDKGCYXtSVq4BnL8480n5UqzzV7TgO2hCTIW6UurRMYkWjWZn8kf/MT8eKlG2FtCaR1eCHwukrFDxLVX9julqyfDQyzFbno4CxiFjJZexruoUret3geGv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Qi0KEEFQ; arc=fail smtp.client-ip=40.107.94.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RmijeYr/dPj1zuvIlunF38aJ9v3DtuN2rF/N761eYvh8o3NATth/pH78L+LMwR92rGWopZ6vnYrglFG+RWWSaixUl4G0KZvdehdoTl6KIHnjjnbREI5F9fei7BUG04sfP99UiD9GHOABJcYC5pwaQ7Xefswh6MxDljcItENqp0pGXEIPgFntBLm1LKnvmiVVfT/OgGtQJucGTFRfQcu+KGHOmJWZH3y3R/H8L41EE8I+VUJ7zSjBxY8O814f8fAZZV/cJCGbDDdXBtBhqp9QPXzrj/WuRqW0jVIcYbUgLVT6e7dP50q4H5e1Ant3Jn8SHv3Gq3iGoBaEPRuas3Saqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=guoTLbhx03urfYE/DkydT8koE9Qi0J98aYRCTQ3N+0w=;
 b=k83zMXLlbTjxcvfBzj5tlq8+DEH4t353exTjKTKRA/GFAzVvykQ3JuCcpcz7RO4wjNuKgdZpZQa2w/8G5N0by6VX+J5sInikkr0fGNh5dNIsLBpxCnPClmshHlmJ5adn+pxXVMlUYnJwcD6bjzogEYnBW9UTRIjGctpRV6L6co7XarzQBylDAPV7blYdVPclfhs1N1BgqBKRoeS4SnWIpP5cu1QeGwQ14T6XhUigAXQhqBht2H8SB1urQyr9urwnT6WK/ZDdm2x0TXS+O1+EEoH0khQfpR1NHvXk6+N5WHk7U/eBsITVVLfrM9ZECW3R/4SuqPdu5ty+gWPUGs1gpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=guoTLbhx03urfYE/DkydT8koE9Qi0J98aYRCTQ3N+0w=;
 b=Qi0KEEFQj9hGLXApuQ7LFPXmaI2glBnvtOBnC+XUmWy55pZfgIIWVeh/5VWDA/zOTJ0PufQsMgIpUguKgQLKi5b8LXYmCgov7QN5tCmdewKnSsM6G/dwknRzPqvd0EIvafDQSJdP0VkPQRAxu/TSFtCp1MA8iS16DSOR2ouewmJuWdw98hu24vuEEtb/t1/qtIUk9AaqLEfyROMW0sKE2QkY9HLDnCzxlGYFrYmWIQE0Fo/peCIdBW0AIOOczCaqNbSe32JcjPlWym0twBSnq59FuLbI7ElOYGr423qvm3wyXeH5euni2Gmkhtnidf4y/tEVnqOWtVeAWx9muOpleA==
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by IA0PR12MB7676.namprd12.prod.outlook.com (2603:10b6:208:432::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.54; Wed, 10 Apr
 2024 22:46:23 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7409.053; Wed, 10 Apr 2024
 22:46:23 +0000
Date: Wed, 10 Apr 2024 19:46:22 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>, Marc Zyngier <maz@kernel.org>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Dave Jiang <dave.jiang@intel.com>, Megha Dey <megha.dey@intel.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Robin Murphy <robin.murphy@arm.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 0/7] PCI/MSI: Remove IMS (Interrupt Message Store)
 support for now
Message-ID: <20240410224622.GP5383@nvidia.com>
References: <20240410221307.2162676-1-helgaas@kernel.org>
 <87wmp425xn.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wmp425xn.ffs@tglx>
X-ClientProxiedBy: BL1PR13CA0209.namprd13.prod.outlook.com
 (2603:10b6:208:2be::34) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|IA0PR12MB7676:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TPb4L6DgQGYdsENFpzKEBPKmtgCTJI185L9XtAhH1idJ8SpMpBXYLRI0ScI75/ZUuahL8HjZQ/JaXpfLVcyp6vHEnNXpFQsgkbs5OMXblTm2EssXppWvJ1htmVeHYNQa1xLxFkD6lPmFwD519WzgB8UgSpJWw7/fFNg6VJBsK1Vml/XaNtPVXzldDB8MguOSCEs3dyErEEMIv1NlO3oGeEXw1LyX3XmP/bMwQJa1PBPoX7NbfaS7f93qamal2WJGqggO7LpmkQbjLGkykYlltaEI1EH/TY9Mwi5SBwE1C5xF9IBbGCQG7AaEbtXHHEv13/2qRvBbMkFmu4Ll02PKI0c5THfzzxV8JvGrA+ByEqFwEROcSohy1olXREsi2OSrW3HMX2RrFdY9ACbgW4Jp3JgpwnAp1f6QUNOKhBDQO11oCiiVsdF46D2e2LYr3VsdvPHgniPJeZy1IP4+yS87J46+xpRKbOYYsHE6o4EJgaWNLgvDGybcisUPg/bB6+YNYBl1QS+KrN673m/VTrJYn+1YjF6hP8BQ4dNT1qaWOQDe8OQNvEnawJhdcnfcZDSDyPSSLHft2yLNXLoxb1lhBb6P/gBzmTuZB7mgbpZJp4UMCBVvTSKSQLjT2oto//2qDCB5aHmYDhPirIjBhhAFLcKKj0UjjXNzqDzdDcVaRns=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6op9RQMslxKqdkR13x/I2IeLxQ76Ud20Z6qm80utvDRdDwobM1lkU3D3Yspk?=
 =?us-ascii?Q?dnQgZOarEiffMpnexmDNBWZ/0JAT9eoENWaE7yVkuujYeB2TLw2jftvViTip?=
 =?us-ascii?Q?nPt/EhjyuF6Yg55gNvly1wYWfeudr+cPnnUArcC/pzrn0O/MoV0+L/fgYj9A?=
 =?us-ascii?Q?3+8Hno9j0WmXbM7lwa60b4hzt8DbKlzOwOY5Ig8yvlix6slPth1yyNXF4eKW?=
 =?us-ascii?Q?daTpPcp2YKeAuSqZ1YSgGnWLfZFiRRv0cWwrXroFwbzFYvYJ+XMf15zl8yC2?=
 =?us-ascii?Q?+7BfV3rRVfChThFeVPknqbebRxAtv+UWBrP5vIE/FP0Q0TUaEfeWlZmrfB/P?=
 =?us-ascii?Q?uox21TJ5MjEdeePNzmAOveVC+yPoiXSWYjsSNUITtg6zp1GiarjivUFNH3YF?=
 =?us-ascii?Q?T5m8iGC5aRfORNaknHC2J9J4r0g4ns7VDl0t2EJvMZdN6eImccWGgV20sQty?=
 =?us-ascii?Q?eflpbgvDXzsDUCatv2UnqF5le7rX5c1zedCCY/8T9IJKp/SzxQbc73er15Px?=
 =?us-ascii?Q?KQm+UdqG7BirsK34kabOGJqUOSGhO6O2eCVZqGSpcjt9LAslt/e8XFzjkvV8?=
 =?us-ascii?Q?Fmo3BOo4fHjuGy7K5MYSikwezMagc/6reXcr5tsmGPn3z3AVHs0ZBt2YDnGe?=
 =?us-ascii?Q?zvhbFA1JVAZckmsg3RDryeZTQTcsnzy8vvoTjBGRUFzmm3W3F8bNDdRPfGHa?=
 =?us-ascii?Q?3OS7R7sKM9XNscQZry6V9bAauWpXTydV7xhGmWZ8ENq8IFFNE28L8Dk3Yq6H?=
 =?us-ascii?Q?ifYq/5/OqmK6xTu5yX9EUrRztzv6ufLEzsKIaPSa2rukXDk+Xef6QMgGo5ZP?=
 =?us-ascii?Q?7XD30TduDJt4ZWgrqAkf418hr0njzoKRMcQN0EkEAkt4TfmQXYVQV5ndRDE2?=
 =?us-ascii?Q?iPLz7unwpcllFEAkmGLC+N3k6gYPHfKT8NVDjR/deOnf8vmEMFJrfd33xhIS?=
 =?us-ascii?Q?e+Pb/g9jizpFuox/idf8jyqcwkpVnRlKZ46/+t1KX9E6rhIDcgiLQwHA5muB?=
 =?us-ascii?Q?Ih+5T5uhzv6aYiriq6tf/SLFGy0hnm6w0E4y2w/3JG+opqwyB4dGVBPN5WWQ?=
 =?us-ascii?Q?w/az2yAmClmDeSiS8jdL19/A+z3WkupSmiZ1NxrUyTWyPQV6EQqNbdpkPtlw?=
 =?us-ascii?Q?qk17G3+Y0z1nQJHpuVOiLS9P5FChXJDWIBUJesJbBlZdZOHnspG3yRzxw9pQ?=
 =?us-ascii?Q?WT6S6qS/ReHwm+uOeSzJQ78xkesJb3A5JjJIQ9HEi72pJ3ZA22gqrWn6tPhA?=
 =?us-ascii?Q?C9uapPYTArEWzcWAbJMdIM6uTP6/j1alpmACTo3Rhw63b19GVNingawbau8s?=
 =?us-ascii?Q?MfM0lVHFBT/pCI2c+e8H9oTY8aOG56izqysj2ix2LJZ3tgyzLK9AeyrIKvLl?=
 =?us-ascii?Q?a9ZPk7svSIvnt9726iUOGFVpdn26V8kVwGN24GgV2M/vxdeGdm/NVRpY66sH?=
 =?us-ascii?Q?m960q2NdGPWBxcn+NPxCmnUKJfgjobcNJKMerIcAf1tE6MFNMEbbakdCk31w?=
 =?us-ascii?Q?Ohc1L/OSPodihojnGMthkYado2tpX7YJfWNVVQ8yFdL1hU83TgfF3IzOcOKA?=
 =?us-ascii?Q?vcYgt17UtWq5GHvsIdKn3tJYkYzCn+QVhuxoRE74?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d2b81c9-7ac9-4396-677a-08dc59b00c5c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 22:46:23.7254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UP7aINVIkj9glkT2I+dSmSgwp75yL5yicqVlptobiLypLRcKp29X04vM2sdFHD1N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7676

On Thu, Apr 11, 2024 at 12:45:08AM +0200, Thomas Gleixner wrote:
> On Wed, Apr 10 2024 at 17:13, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> >
> > IMS (Interrupt Message Store) support appeared in v6.2, but there are no
> > users yet.
> 
> Bah.

Still baking here :|

Not sure what is going on with idxd though.

Jason

