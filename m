Return-Path: <linux-pci+bounces-37313-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6853BAEE22
	for <lists+linux-pci@lfdr.de>; Wed, 01 Oct 2025 02:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 357A019436E4
	for <lists+linux-pci@lfdr.de>; Wed,  1 Oct 2025 00:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD801A704B;
	Wed,  1 Oct 2025 00:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YwpwXnit"
X-Original-To: linux-pci@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011027.outbound.protection.outlook.com [52.101.62.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4493F1A4F3C;
	Wed,  1 Oct 2025 00:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759278652; cv=fail; b=hNqTd67nsEYFDlEgQVrHCSBFpOEcG0/plWin6SEs+XrmDifj/ummCxOLN6CYb1aSiHtoDzr/GkPtj/2JbaxsBQ3hKCkLXRvUswpLxJg7W58bVWxl7FodqZsBCZwqqIBX5lyBeDxfQJafUWZlEIcSSCNVdpic58yXSbA9fs2scX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759278652; c=relaxed/simple;
	bh=wTbtCpyyxEEtkrPFiMYVvYi/RIHVSN26voojH54jEo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QzYAi9NGukrEJnue4BHVg2evtFBk+RbHVyil7mabQ+4ZRGITkWxWHeTfeDcB4Z30MYR2VRivAvH0KPCu1W687MzkNGOrkEUyKoGpjFipCX3JGlRX5uf6CSr4KclsNMUOsdyj+HWc7KhBxJqiNODpShDaWtM80A6ZEa/0lVW7V0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YwpwXnit; arc=fail smtp.client-ip=52.101.62.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=idVpvFHmbkxomXjkeffogYLZNVWzLbabC1/BJFoZERYTS9jXFzb+enbcD/GzsMGMhCbAJC0CHEjfFDpG0wdfTVg2Rlj/TobClC+zHdcPXiGklvg39QONR6fhLxMIV2+tRk3KZq+y+nu19QgVSZ0VJ2Y6PyU2RjMpIPaq0hK2LaNgfxoqpLhDJiLEdIpWuNWRJ9wl2JUF1EQgtzU8o7uvt93Z+X6wrb0Q7vf9zn349L/XdfQTqkCtcjDC6krbw5Umq8LrhGTrfZ62lBemqzRVY6pLWt5Gh/6uvdkM9UuCk2vHMy3KLwvTw62KsD1Z+6Q6+MN9lja0isa4Hh1Yo1F0Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MNY527GGFTxfYRairyytLm9e2diyWmFXKC7MYGIsGLw=;
 b=hdB7fParYHBO43RbnPmGnjQ1OaeJLk5v6w80g5DC4XUMxDNiErB0C7xJcrlSrgiESqoSZZBdStBPKmAHJ+JhuZIm6cmclEy0GqZnKRJG9/cmdMiH1/D/bADHB3shjwblFYvHyqs6fJvc1KRD31YozqmXlQW0O+yZufSS0mQfXE0XESja2+mRgD2uLVMnI92lxLnmXb1kjW5ACSzcY62/ktZDaQld8ErWWxtf95JyukP1UuwA2IAifCqxbUukOFJpxAfGbECeCBJkgc1iURxN+0sp2a+IgkwoXFnsfL728Cjx5RmVCjzgWe57i1eIvGbxcbxtvSLDVpvsOfDi+0b6hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MNY527GGFTxfYRairyytLm9e2diyWmFXKC7MYGIsGLw=;
 b=YwpwXnituFM/yW9n6b5m/yIesxY9XyDmFmjfvUoLCsf/MfiBteYxpC/jnXqcZuC5lWdc19g2DVBGA5As814Q5y4Mv6XI+c5yj8inG13HxrK758DfKNwVtpJwW8SEDGqKuSgF+fO2CIasQjDirw8wCbbvFG/TL6GOIvb9+I9+7eI6McQPD9n+bHkwYWUIIXwdeky9kVyW/pOky9foXsgqoY1q8nCEV39vZna/+ARsXNuX2/Gq0hfJ8hoFodLEQfq5BEAOsxDTfcOBKJjAxDi5euceLXZdLGI28nhl7qXtVaDGewlqFHDKXVqgv1RfLJjIDEXJTGW4phj9TbtoNQLFiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CH1PPF0316D269B.namprd12.prod.outlook.com (2603:10b6:61f:fc00::604) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Wed, 1 Oct
 2025 00:30:48 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.9160.015; Wed, 1 Oct 2025
 00:30:48 +0000
Date: Wed, 1 Oct 2025 10:30:43 +1000
From: Alistair Popple <apopple@nvidia.com>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Timur Tabi <ttabi@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, Surath Mitra <smitra@nvidia.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, nouveau@lists.freedesktop.org, linux-pci@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] rust: pci: add is_virtfn(), to check for VFs
Message-ID: <zqogmf4mnadxkthhzyfhzesk3pdafnr7jqf5i22ahkdo5ugt63@gvb5xhgjylku>
References: <20250930220759.288528-1-jhubbard@nvidia.com>
 <20250930220759.288528-2-jhubbard@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930220759.288528-2-jhubbard@nvidia.com>
X-ClientProxiedBy: SY5P282CA0006.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:208::11) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CH1PPF0316D269B:EE_
X-MS-Office365-Filtering-Correlation-Id: f6f58f9d-cdf3-46db-eebd-08de0081c4ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m4PBSlkHbQYc9CBEASvFvppcCxwUGn706Pr4J2jQ9agtLjKDljqApQNFJ59p?=
 =?us-ascii?Q?CWv/nQVslrCqLRUl2PZdqxbfQEDZXwnnuMBc9lG6YxVkBiPEe+bNFe1PVOc/?=
 =?us-ascii?Q?ytNtmzLGHo/wvaetFLN2N7mgrLBJdpQh2thpm9Pap7X85A/pICX0Ib3sQhl/?=
 =?us-ascii?Q?P1LxnqpP3su4wqI5UW08NrUJALg9htY68SAj/u4RBCDiuCWgPRnJFOxRndZb?=
 =?us-ascii?Q?avbbHe3dsKN9cQzcx5YPE7UFZP+v02uc02pDYwgqW5ubEBNgTQVDpRH3jINg?=
 =?us-ascii?Q?x7XBhnwoLyVW5pzwhIM1exzbqpe3vjkebD0wqTlU+QrUPK4PplueAB1L5dAr?=
 =?us-ascii?Q?Sx9tixkv02FOfjAABsDcxl6l+wfhSoSVEvltYrUiLiPTCchiQhfuwarwQqhI?=
 =?us-ascii?Q?uDnA6oS2DSMZ81THo7/v99Ga4UST980l7BulqUloTYEZpOoHSte8ha6KiRXK?=
 =?us-ascii?Q?ivjSO5XFwvn4mia58Et1TmsBEjDZP3rB1yb2UoppB+TmLFshQlJ+fth60dIs?=
 =?us-ascii?Q?7xrrjmaRmd+ZKNsmLXe/fVYPD2LcOnYFkbON3Jcnje+Va2qBhSm4H5hjxM+f?=
 =?us-ascii?Q?1ve+zbAbgy/cfD9GZOTK/HxrNnuHzthlKp5mDCYgYFJ9CTtpghwMZdScE6jk?=
 =?us-ascii?Q?g6BliVcSG3CwI8jl8yadb1J/kgkmFWJcdri4G0B2Qvw/ZF3LP5PKWyD4W0ZE?=
 =?us-ascii?Q?Hc+bNVUN40DY7FtwFVYU/liVMmBT7YjL7Ipeiuj+zX7tRvDzgyS7NAggXDsW?=
 =?us-ascii?Q?JMHFXuO921t9Xsra7fubZWn9MQPqJXwyPy1phDzGH42JgAst1XqwbeYxK5Lc?=
 =?us-ascii?Q?WXOdVXeQ+q2e9E6IwAJv6p+ED6bRi5PiYV27fixXuClMjG7hbrOPzcUJPhtn?=
 =?us-ascii?Q?MuMWDtMVrLNWKKHspl6LbU/FZf/GFwqPevkoFSLbJveCnLCOdb51HKexSTVF?=
 =?us-ascii?Q?XdCla3aBooOlZpW7agValGirQqWxjDbB4RgOJxK5hvcH55f3FlSx770jbcMW?=
 =?us-ascii?Q?EBoNs/OnL28BwFnYP5UmzKu5O4oGMnRuZMAVhXNlSY7vzOOvqWtUYjjpI7Xr?=
 =?us-ascii?Q?6ura6zc1QpjCd9tohUW9YuxU/1HgAbPiipQVW73JQx3jsgtcVljrivmdJL2Y?=
 =?us-ascii?Q?3K3+inewaZt1mTryXZpdK9/t8PR6+6iNkIjv7gv02unToxaIFH05qnTSg1/D?=
 =?us-ascii?Q?M8FO789pQn6zbXs8ZhDXL7Ynq1qjKq2RYiBjBtu+pGSjnGqDRfSSkwY3ktma?=
 =?us-ascii?Q?XgvPxXdKH5zg9OGAUojth/aArRabthdytNc8A3n4jNWUTavU3xfK4QE1sWg1?=
 =?us-ascii?Q?RoM77yLKQncgKqV8vD/huN8dFYzIk17lZJvXeBBz+iYlURP8kYgeuvwsMRbf?=
 =?us-ascii?Q?mxYM9tbYOOsruK/pRhEPMZ8sYStMQHjb3nvIUQzahrNhAPUIiU0dgRweKtS2?=
 =?us-ascii?Q?n6q6SHqa1Xaofed0QjmE48VTYnIBtPIG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qZNNWDMZxxPpqDmexjWVM3m0JTC6qSx5nkNBwPNdcCMxCvp1B/pFcSyaMKjF?=
 =?us-ascii?Q?BFE2ZnKO2Tx9IfmQmtth2FfzFYBdbUQR8rkqvnIqJycVm2iCj0dFD97swj4T?=
 =?us-ascii?Q?EYw7rSW7g/fXrI3Ae7ZUTBWJYAdUsvmlt11414oeDhG6DwQcJq90eNlscqQz?=
 =?us-ascii?Q?cZviN7+EOEU3SIRCS/jomL4UG0CbhBCUYTSs0u8yjXiZHdpBI/aKEKj5zw8b?=
 =?us-ascii?Q?5si7uQRG6yFuxmSoUUQH2UmFUbAnQ1q75OVU4DpKtvkSjNjRb2sQFby6wUFZ?=
 =?us-ascii?Q?9V8IWBOdGkHQBQWCEM7Ckpf4e/dHNh8HjixbrJ6FfJvEJa8JASROzU6G3D+R?=
 =?us-ascii?Q?44tEloyUoPG8Lns1EdGau3ZLDFtRSY6jAqdEgUnxSIPKtX8p9TefVGLNwhhc?=
 =?us-ascii?Q?8UFZVS1QRMrI1n+HnCWXVbdblzJh6zr4UOzYJf+8LfHaO65DTrn4SPyQPQCP?=
 =?us-ascii?Q?WBCzPoOLKkd4EwsamImard1eIA9xj/iRmhV905x2fu072uhF4wtPposV5cEL?=
 =?us-ascii?Q?CWNDlBZiNk4C4TTaM8kU10t5qwhI5XyCTRYg+Gt6RDsnW+rfs8ZodKqCFTsj?=
 =?us-ascii?Q?VMUP6j8efeHaM23Rua9Ho4q7rwTRsoC2l8dC4Hi+6fqu5v7J6cxeH1l1qMd0?=
 =?us-ascii?Q?MGBj2b8jQqJEl0vkn1+gnQozZ8uQO/1r1GHf+DRZfY/B7xyAxwjPLdn23vT4?=
 =?us-ascii?Q?KYy5d464z22bwumKeCsCyzAMySJzwzTkU+7NOQC+h/g9v32Qt4ags/bpdNGx?=
 =?us-ascii?Q?R/gWrpWO6S8txqfZ0y84K8FWD4P0twhditz1vxa/GgARmZYuVP39KtMlSfub?=
 =?us-ascii?Q?IYA3acwhKGWzGhLI5ybSaznKxlr8IbHjcHxRicv2pGS1RhMLah7rxTYlSFEF?=
 =?us-ascii?Q?ddorDc9dbH5ULRpzlsXBolzd22rpmy/lHgZZSLEiZK3WSLeoPODIX192LNp2?=
 =?us-ascii?Q?R6gp65Hr5vLVtGDeWLF7ZXQhmDBcJbDV6TT6w21mqfTNrIa0RF53E8xLm6rK?=
 =?us-ascii?Q?3s0UUhs7GfSleijTEsI1U64AmK4p4ZvZTcZ7hInxGb6VzndGdeG1EG8fR9ic?=
 =?us-ascii?Q?P2oQSo0B3lvUaF+F3h5SUVIw4btt6AviJMwqUtGysBLEnSIyJw8ip16W9VaP?=
 =?us-ascii?Q?1AfX5WyD+57rO23lknotO84W4KZPBzicRTj+WfiH/UmR/uMXU7PhwG5oP35a?=
 =?us-ascii?Q?CZ031fAEYlR3DAdAX8k8rRqmUvIakXQYkCkBRW72+WvXu2EpjqcJyP2Q82IG?=
 =?us-ascii?Q?SyeWZ73sxMCtCYrW3gIeb+iod5PUQ89v6GwajU40kbT0nmr2sonZU5bJpUJg?=
 =?us-ascii?Q?nhGbdAtjFvNcht3J9RJWWvZoLQSc5DBavewZSDeeWrLzJDzPnMKCeh2XeEyj?=
 =?us-ascii?Q?uGtAj/+v0jjhYK+CG0MBRFEfrpoVKvhCOUDaEPONCUMmMwP7xURzmkEsA0zW?=
 =?us-ascii?Q?xx+uOi4sTcs7aDlWn2jmDpWAB99cfaZUPQD1q7SxtDmgrSFndCodw4YPsm8O?=
 =?us-ascii?Q?zl6u6+wCiTdmIDhtJaxRP8aMP1bxegrRm4MPQ9Pd8FJfeLkcAEQHetK6CWSG?=
 =?us-ascii?Q?KdrqbwMhCH2ceqzR5BjU3Hl1noUeyBsDwieaIVWa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6f58f9d-cdf3-46db-eebd-08de0081c4ae
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 00:30:48.5767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +U/7GjBzTTfDHxi7wwNa1y3YzVKgP6tRCnV+9uQgVqlq8SAioboX+xpHg1HYbBKykjHjqZUaB+oEMGmqX0hqOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF0316D269B

On 2025-10-01 at 08:07 +1000, John Hubbard <jhubbard@nvidia.com> wrote...
> Add a method to check if a PCI device is a Virtual Function (VF). This
> allows Rust drivers to determine whether a device is a VF created
> through SR-IOV. This is required in order to implement VFIO, because
> drivers such as NovaCore must only bind to Physical Functions (PFs) or
> regular PCI devices. The VFs must be left unclaimed, so that a VFIO
> kernel module can claim them.
> 
> is_virtfn() returns true if the device's is_virtfn flag is set, matching
> the behavior of the C code.

Seems fine to me so please add:

Reviewed-by: Alistair Popple <apopple@nvidia.com>

> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  rust/kernel/pci.rs | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 7fcc5f6022c1..476b80f05905 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -496,6 +496,12 @@ pub fn resource_start(&self, bar: u32) -> Result<bindings::resource_size_t> {
>          Ok(unsafe { bindings::pci_resource_start(self.as_raw(), bar.try_into()?) })
>      }
>  
> +    /// Returns true if this device is a Virtual Function (VF).
> +    pub fn is_virtfn(&self) -> bool {
> +        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
> +        unsafe { (*self.as_raw()).is_virtfn() != 0 }
> +    }
> +
>      /// Returns the size of the given PCI bar resource.
>      pub fn resource_len(&self, bar: u32) -> Result<bindings::resource_size_t> {
>          if !Bar::index_is_valid(bar) {
> -- 
> 2.51.0
> 

