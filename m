Return-Path: <linux-pci+bounces-36383-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D402CB81F8E
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 23:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EAD53A291E
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 21:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7D32BE035;
	Wed, 17 Sep 2025 21:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RYG1TM0n"
X-Original-To: linux-pci@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012064.outbound.protection.outlook.com [40.107.200.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E6230C357
	for <linux-pci@vger.kernel.org>; Wed, 17 Sep 2025 21:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758144620; cv=fail; b=HiqAIKA/SFN6JsW+ejtMm+z4vl2iNzawnyzPz+v//P/zlsZj7rZ8XAQdqazHjfBIVGCDjR9FrA1Ph7zrs9klbI0XaY6tWC2fmLEK2czfZg343XEHXbgLVKNfR+j8x5+y1TfOqBtRzLx4d0UZuJU0OUdYgOR6yM9AJJ0wUTkZosw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758144620; c=relaxed/simple;
	bh=9LvBqHojkI3xUEJGLXzP/nKMIYoW3AgR5y9z0i5WylQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HrLcfa7j9CUPXAYRDBzyJo/nC5JUjek1vXHAmX6h7aFojdTnx1Jc5+eurew/RuSbOl2Y+Pj1r/TAZElUSPkX/nyMNuPfe7u0yxjJvlpLRQOgbFs/JODLWGLJ0e23ZmS2S6oHtMAa+EbYI02yUsiMCtEaW/pvVQzUoV+pOnuitTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RYG1TM0n; arc=fail smtp.client-ip=40.107.200.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K3F1w7794y9OYJmr2qKFEP//LiqxWlZdFgLjqQ3hSpg02qXlyqe0Cmv+MhUs7nXi+zIIS/DGpvSvS8QZcyBkOrkFKf8S173pxo4wdFjdqshrmhDE2HEArM1yw9zL9LSD0O3qXoINO3Ee+swi2BtPCS4Nr8hkK9S77BBETUdvmBQkyQYiFOznkUsUtTVZd8PLYxtROWgtnPt5yKvIO5zEXv+h0sHoq1ThhbrKdik1w+i1qk+Hn6ouSTVxuZ9aMRqPzW7I/IVullmdak3QVPdS08IiSZYb76SeBjuREBUpjjA77tpaFEL3DW0d4MGy5pTwc6i23NWRLjLH2REh93vsuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2b1FYT2fbzUbnhNGDFvVqbARuhO+6QYOvXLkFFEOpFo=;
 b=q+2ICRgZ+QueweJfJSceSB7zouUebQKP7RYe/x60CMlVqqUenb8LGXomVus6SYofyP/O0UOQtu4Ajoi7LzGS6f04oyfo2UvcPvm5RmPifD7PVEg9Eb9U8ets1KvWs5BppXb0a0zvrYxhmTgc2jkdZsO3C4upQRZE2EG96uAT0A+sfSgc0CZzxR7NtoyIf0qMxCUpEqcCRW60R6InJuG0gnR/BvwmEFWkcasF3bCYYUMMO+FT1HuueCQmqhriXFQtWuNmrotq5yPt6lk0d3ZcrC7QTLmXuFHGsLn0GzkWCm5JeeXhPluE6bMGkjQssCV/2LdQJ0BfxCS7i1C2msFcSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2b1FYT2fbzUbnhNGDFvVqbARuhO+6QYOvXLkFFEOpFo=;
 b=RYG1TM0nobbIjuuAMYFGh/V5fdpScdOVJM8BBVW6HJ8lOtq3K+VtlsAwUNexw/mQ9FKPNehbCtruXt7SKNozpBWCCJN5xTRXT2RYLvAWagkgrOq/eqiZO72zHVZteJh1fiOxf430p7KNXAQPQfT3eItLaxpAFEyoVvDny3EkH5o+XdIyZyg7lEw5kW984/j1/P4hfNPcCemqYfAi28SQqjjYLJ5IDnSCV+XLgXh+20X13FSTLRrvORE22EGO6q5viKWCdnnlHPGZb85lVD/sHb44MJM/p+jlAqxx7MILXq2A7wHWUTuUzNFQJdwo85dqCcnRZ8FjbSDbpF4Oe/lXNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 21:30:14 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9115.022; Wed, 17 Sep 2025
 21:30:13 +0000
Date: Wed, 17 Sep 2025 18:30:11 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org, bhelgaas@google.com,
	yilun.xu@linux.intel.com, aneesh.kumar@kernel.org, aik@amd.com,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 4/7] x86/ioremap, resource: Introduce
 IORES_DESC_ENCRYPTED for encrypted PCI MMIO
Message-ID: <20250917213011.GA2101646@nvidia.com>
References: <20250827035259.1356758-1-dan.j.williams@intel.com>
 <20250827035259.1356758-5-dan.j.williams@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827035259.1356758-5-dan.j.williams@intel.com>
X-ClientProxiedBy: YT3PR01CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::32) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|SJ2PR12MB8690:EE_
X-MS-Office365-Filtering-Correlation-Id: 74f598d4-02ec-4870-9561-08ddf6316319
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I3NudpCutEL0phR6NRO0MTwNtmkbNZDyV2KRW+yKdqH5o6tnNvwsY1JKUVPi?=
 =?us-ascii?Q?hyTENYiumOCR9O2N3/eLKs3k53FPZJh1y17RarNzKuJykmgI1m33huQ736as?=
 =?us-ascii?Q?pAHiiZS0RMK8q8rLCmPAVgsyXclSzHsSZtR3ECrEunqm5YSx/CjD1kHeaVQY?=
 =?us-ascii?Q?w72Ifiep5d6HO2MsXbPqRRWAtG8Rpr21QrUqAs+Ye37sIsRTQXIi0wJ8pGhX?=
 =?us-ascii?Q?qagulUcqJSb/nsSkIGEhdgTmgwci7Swwhw2GRcm2s+C/rR6plZaBIBvLlr0V?=
 =?us-ascii?Q?2WkRdTNN99n0pf5XubnkMockdLNVkd/+EY4CTrsnLd7TzFBR8C95LaLGbPuo?=
 =?us-ascii?Q?fXa8OjBiqrLDFH7leGY2GKdkfwe68os9sLrxkwNeYHjcmAOjNhhtt6S05vxo?=
 =?us-ascii?Q?20bwflFZ2lvD5gwrMzKisxqjgBabJrGsmaqEao8K5ai1vWIh7iS0GqER4Kul?=
 =?us-ascii?Q?0O2+ZOhfwBB7thpP5S0VaqGV5ZmDIAZdm+tFbz48L6G+TqbicZ3VM/h/6c8R?=
 =?us-ascii?Q?L6VaOVUVxt7VQqQh8tlpcF29+dbKOaQUePLen8Q85wy+wQ5h68tAxQDv5KaN?=
 =?us-ascii?Q?Z+IqN53Oatl6HL+YEflskPAKEJDziBr6XL2ltHjCahuzHYSg7l6/LqnO5epw?=
 =?us-ascii?Q?QY2zE7xAorfEQ0yIWCHWVRr9stnMJf3UJvCF3RPmMyw54UfHKPJ5nSe8aOI5?=
 =?us-ascii?Q?qRdm1MSy71EjVQ6wwI9NxzuviHYlGYqw0lgxlgfCElD8gG3zRd3PF5aRSUUu?=
 =?us-ascii?Q?BQt1UE+dVfTlR5Y1xCro3j6sJF2haZlTFA88AdTkNXdMxFhDzcxZIJUeYOPU?=
 =?us-ascii?Q?td7mLpiOJZ5i/sMylczmXVt0uHkks6a6jVikCq/Cd2SdWAjcGOQRJM4Lu/P6?=
 =?us-ascii?Q?+1KvJb3loUaM0v1Hlnbeg51sRQCCTnE42qjf7dKMuBcMSv4qXXZ6WwYpGLvr?=
 =?us-ascii?Q?GbE2uOjFbj0Q0RXU9r50dPklFtn28VlIeuhBZrmVj+OSklPCz4yvTGJSN643?=
 =?us-ascii?Q?jdjnAatL9q5kSh8RjNBdtgdKRFpUJuos426/I1W3sHAHpcgoCfMsQm/Oeijk?=
 =?us-ascii?Q?dwEkbFORP1/eSot1wvhkbewbKXUA45iVWF6h3sUzCz7lgThDtgA58cLQCi5d?=
 =?us-ascii?Q?f5fu33QtzBubMY3Vrwp3py3dG86VW1KHyCqRAF8kL75bjiczPLdFnYOXM6HD?=
 =?us-ascii?Q?g058ZK/smFhQZ17SMYbtWjAQg+qa1+z1uaHemCDf08ujMh4svoC2V7F7onSQ?=
 =?us-ascii?Q?WRezhEdc7WnUe4fau+NdiCkwENfx5JtEXYEVO4boYnYRp4vHRUQUh2Voorio?=
 =?us-ascii?Q?8qp52lsAj03eXps39deTsV+2AbBNDMDePOd6CBsvNiuqWHX/ZhJDRyBDwm0L?=
 =?us-ascii?Q?HrTLBBvwRJmr7RV79D2XWLa9hwhWa8o4sV+jV0bxUyu3JkscyBue65JuBPTk?=
 =?us-ascii?Q?gc8vZQO7dp4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?09D5t7KFW5US39VfgwFZkycHN3DFpGG+z150F5cp1lSCmpZVrpVOhVRG9chY?=
 =?us-ascii?Q?8xpIH3yUju5OhoPjNkAuTdTaOvdQ81C6FbopjdAg0x1+aAH06IPnPBOQEOUK?=
 =?us-ascii?Q?YO845i2JCIl9dJHHDs95H99yayVDLUaktToaW27LiE/P14x5EhX2CVcWSrIt?=
 =?us-ascii?Q?0Hlv4mVEh6XN5DiCTwSyuzPdrQSKCDeAXGi1IPB8RTn4lN9sdBfkmhmwUTcY?=
 =?us-ascii?Q?+I2V12MJROM9uQZgcGllZNeF8F7Y/HFskBvCIjBJQniP/GOURGOfK6RyEsde?=
 =?us-ascii?Q?DFzXJBIj8yEwKEcic2xDwuxbbKWypH5lB3AZVLxbhVpGvardLVIdTd9LZAvr?=
 =?us-ascii?Q?N2RAxIVcO565duQlPonLpMesNBFfZXzxtP60IusO8oJWmapn54Sthb8o06MA?=
 =?us-ascii?Q?6fGcxPXVvLqzJBE//GT5KyN+vPNRHV7e51Bf2pJCak+lY/LpUhj/aTLngP86?=
 =?us-ascii?Q?bf5yCmtjg4rcrQV3nw7AXXcUYQidRYgFLkvVliJ7LtxvG2SzCkvslBgdfEMq?=
 =?us-ascii?Q?AX9H6WbAK9ApnwToEqlK0Ei1S2BmYJHk+tjrBIGGm7Ai/eb3Lgpi2uOY/M4D?=
 =?us-ascii?Q?g08/imAeqQNw44pQoYYoZAirj5UTDa4WB2+6XgZAj4MRryGIQV3pLWD9acwR?=
 =?us-ascii?Q?m3Hix/Nx9fzEIWI05y+aEwt7vwitrvCQH7oYYOGw6LPxGbac7AFn4+IUh7Pi?=
 =?us-ascii?Q?hueUX8foz4256r6Z1+6y8on/14nnfKmud9yMMcX+8smkkTnbU06cBGSU5pV3?=
 =?us-ascii?Q?B412n1gXor91zjLwXQ3NoE16L5BM4z+TutBEA/z6d0T9YHGnStwW38+Mh1W3?=
 =?us-ascii?Q?SRQKCCwAIXBNxh2RZJHJJS7FTBeVQ6LypHKVZJ/NN1wPDsjkyShYrc34cN2E?=
 =?us-ascii?Q?88BaIjJkc+YykaAwWn3RhQazsQrQ2lS5hLUcfpoWV34wZVhCvm8XsMS5AAYf?=
 =?us-ascii?Q?em1vadN+dIuEzW2Mh7ZL27dRABa7C32UKlyQn6SVIN5vIkMIRChFx5zpLPSS?=
 =?us-ascii?Q?qSA5rK+Acmw/0FENzwQBSsDzRSNwxpdcm0/MpCiYL9jpiAc9a+eKbb1D09v8?=
 =?us-ascii?Q?AuM8bKL273iKZKSiqbILgwTqiQ+oBKOodPYqCNmHkKZ1KX2CKSDKqL2bWAOO?=
 =?us-ascii?Q?/cZtHVVttu9JK3F/J2fUb7QbvglFwKtn6d0xMORDSnbKvRY5A5rNjk6F5fdM?=
 =?us-ascii?Q?Eu3RMxzgLTEUsAC/1r9bE1Qe8fwvdD7lwnXL+oJ1QGp6z+/IpG6Xtk86BudP?=
 =?us-ascii?Q?yz70m8I7OAK0oTg2m+wcZagAfbHFIs/hq+bLra8d1SAKWboU1Kv18uNO760y?=
 =?us-ascii?Q?wOXQq9YiMHCbhW+9PugG4M+lLJCuJjvMD80F7w5KyfsTJhsok1ltQ3nXORC8?=
 =?us-ascii?Q?eaC8I42bT+3opVm+PZbQK0Jb4ti82kEUiBW1YX1dH0zl0CN6LteqUTc1VhN9?=
 =?us-ascii?Q?uXzlvzE2wShQjPtStPSYTj9wLwFhGGTz6sy1fLVt1ssc3fU/tMGtcU7fvri/?=
 =?us-ascii?Q?P1pPqu68scr68cYPUhsuPaLra3OuJXJ6VR0bj1RplWdCfwrBkwjyZyb6/4fN?=
 =?us-ascii?Q?CEyEp3DBt0vAa51seEc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74f598d4-02ec-4870-9561-08ddf6316319
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 21:30:13.4238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ebdx9D3JO2+FehTf6jz8RAh9Q44yC1GOWl0FPo1kpWQM0ZCTqVXrexETiAzZQxnA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8690

On Tue, Aug 26, 2025 at 08:52:56PM -0700, Dan Williams wrote:
> PCIe Trusted Execution Environment Device Interface Security Protocol
> (TDISP) arranges for a PCI device to support encrypted MMIO. In support of
> that capability, ioremap() needs a mechanism to detect when a PCI device
> has been dynamically transitioned into this secure state and enforce
> encrypted MMIO mappings.
> 
> Teach ioremap() about a new IORES_DESC_ENCRYPTED type that supplements the
> existing PCI Memory Space (MMIO) BAR resources. The proposal is that a
> resource, "PCI MMIO Encrypted", with this description type is injected by
> the PCI/TSM core for each PCI device BAR that is to be protected.
> 
> Unlike the existing encryption determination which is "implied with a silent
> fallback to an unencrypted mapping", this indication is "explicit with an
> expectation that the request fails instead of fallback". IORES_MUST_ENCRYPT
> is added to manage this expectation.
> 
> Given that "PCI MMIO Encrypted" is an additional resource in the tree, the
> IORESOURCE_BUSY flag will only be set on a descendant/child of that
> resource. Adjust the resource tree walk to use walk_iomem_res_desc() and
> check all intersecting resources for the IORES_MUST_ENCRYPT determination.

I was just looking at the ioremap stuff from the core mm side, and I
really don't understand this patch. I agree with the commit message
though..

What I expect to see in this series is not x86 code (that should be in
a series enabling x86 TSM!) but code to update the pgprot_decrypted()
calls in io_remap_pfn_range() so they are conditional.

And futher code to validate that the pfn range requested by
io_remap_pfn_range() on a TEE secured device is one that has been
checked and validated with the TSM as being actually authentic and
private.

Bascially when a driver on a T=1 struct device calls
io_remap_pfn_range() it must be private MMIO, enforced by core code.

That probably does involve a new IORES_DESC_ENCRYPTED flag..

Jason

