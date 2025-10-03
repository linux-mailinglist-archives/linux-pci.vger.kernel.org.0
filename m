Return-Path: <linux-pci+bounces-37536-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAF1BB6902
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 13:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EFB7A4E6549
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 11:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A0926B2AD;
	Fri,  3 Oct 2025 11:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CLkmFcKd"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013060.outbound.protection.outlook.com [40.93.201.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4008E25A340;
	Fri,  3 Oct 2025 11:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759492353; cv=fail; b=cKmZ4aogp7exa2xCMBJzRiUb6VFAuYINlGOHimEtlNP55Rj7b5AKvEhV9x0e9YweosQcOaQehQZmqyS++t4y2lQwYBMRwvMrOrZdyMGbMY8fZJ8dY+eT34KKAYKadJ6x8cp+bgSK4SzAiuzdi9pe7uN7BGb94SRR+elvVdCpZPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759492353; c=relaxed/simple;
	bh=I02UnwbWR9qBhYSsiK6vJzb7Mb9ylbx9c7kHcj7cf0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aev3+pNQKjSz0usgrLk1Jr1WaHr1r8f6CjeL4+H7bTsOavm1KSLOGU6REcp3ELWexn3iaIqh0vLSDQoA8u1ucu1GAnSXXLfEzfGeZVzvlN0cyhtwI4XLZ1c1LJ5UXUYSI3dGsexRNtalspnTdhBcf4ObtdceeuBPyoSl2e82jpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CLkmFcKd; arc=fail smtp.client-ip=40.93.201.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nIHYmsSOBgqxkwqEFfSjlsktJle1kXygHdkAetCQWT7z+Wf4osMDQeomlkOZm4XvgjqUjtT/o9dz67m8WYwnXpypynLXs9x2BPBJCcLAyOy3thy+Fp2iQCQK22HvfAyUN4EGOKKo9rJdHTbrhbyLIeiBf6Hvq41I3G200/1Hq485ADycb0kjeG+tpcpbP/+WKupZi5XcpiCTKpsUmmQEuwXeYA+QTI2lstVsjZBcOnk3Mf5n7d1vLO56XRZgejq/vrxdVRNdygalC0SPStWFq8KVvhCod6p9fp7p53qEiHbecsCNhoOojiRNjoG+ECO47e4nTDRYIO6LFWM+9fatgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I02UnwbWR9qBhYSsiK6vJzb7Mb9ylbx9c7kHcj7cf0Y=;
 b=rWxcJEN+E0Bzy1EAR0vHTqIpYCSi/wXB+mc5ddgJYqQsOPoy06BiNNTSpu0JcYNH2B2GQWG+Yx99T6tvLLgygDPzZ2k80JXV5ygkkER6NNt08Pk5QRpkfjTd1x4LeW9f2GXE3Hf7SY7d1mxkNNU1idT1hNrglsxJumsY/PIHGOFvPl941Y5TuOjgeiDCh9vRXBl7an91DfaB0/bNgKx96P+aNPi/V8l66nMSI/5V/TF9504aLZuOPeWe/U68QCZtdwCW2I0pK5lL1/b9K6ldLKgAWMQyRGt5dWfiKPdFfXXQwOL1H5mSrYp7s/k3cKMdlum//oFfrEe4kKysoU9rDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I02UnwbWR9qBhYSsiK6vJzb7Mb9ylbx9c7kHcj7cf0Y=;
 b=CLkmFcKdWTzyrN7alJ8ITbcZrwWdZ4Qke2lkJH1twMFEyu8zpjqvsM4IbFSKLXwKY7xM9inDzIAUey73Kls8VF5OoNxOz4GtC7qjCtlwbSGgU4i0PdyomfRhfgIBk4QY+7kXzaN5Lbwe465jFRg9qg0gguwsm7AdYoUoeCB/RDgMHARC721zwR+5QgttiXX7R0fme9M9nV55ntqv7FGSQKhqI5zhIrni6dbNY3vXUyptnez4rZWTXlHRr1VaRRAnNUuTJIMHUXEIJdtlYpE5YZ8KUzNZZomDaCiELqLll5X6kAHOzhEKt5OPT/TWXG8LeEqB9tkmqKwgoCK0rs7XaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by MW3PR12MB4460.namprd12.prod.outlook.com (2603:10b6:303:2f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Fri, 3 Oct
 2025 11:52:28 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9182.015; Fri, 3 Oct 2025
 11:52:28 +0000
Date: Fri, 3 Oct 2025 08:52:26 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: John Hubbard <jhubbard@nvidia.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Timur Tabi <ttabi@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
	Zhi Wang <zhiw@nvidia.com>, Surath Mitra <smitra@nvidia.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Alex Williamson <alex.williamson@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	nouveau@lists.freedesktop.org, linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] rust: pci: skip probing VFs if driver doesn't
 support VFs
Message-ID: <20251003115226.GJ3299207@nvidia.com>
References: <3ab338fb-3336-4294-bd21-abd26bc18392@kernel.org>
 <20251002183114.GD3299207@nvidia.com>
 <56daf2fe-5554-4d52-94b3-feec4834c5be@kernel.org>
 <20251002185616.GG3299207@nvidia.com>
 <DD837Z9VQY0H.1NGRRI2ZRLG4F@kernel.org>
 <20251002210433.GH3299207@nvidia.com>
 <bba17237-2401-4e9b-912b-29d31af748e1@kernel.org>
 <DD85P4NV5B5Y.367RGWFHBR0RF@kernel.org>
 <20251002234010.GI3299207@nvidia.com>
 <DD8A27ESH61G.306ZAIGZCMJ97@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DD8A27ESH61G.306ZAIGZCMJ97@kernel.org>
X-ClientProxiedBy: MN2PR05CA0021.namprd05.prod.outlook.com
 (2603:10b6:208:c0::34) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|MW3PR12MB4460:EE_
X-MS-Office365-Filtering-Correlation-Id: 90847167-55e5-4026-8099-08de0273538a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DY3gY0McLo96lWLYfW3XhcMdtjtup3l0dFNsEGbdANa/tt6F6+v435kfRGMz?=
 =?us-ascii?Q?r+/4YnticGhddtkAI4HrimL2L2DfDjAw+Maq651DKYfLzvxm7ulrw6EDfleT?=
 =?us-ascii?Q?ZTMgKeHOdxmmClpn4preytOq7gZtnC4ilZ6vgshNBXvwPqSqfyADNkqjsZDZ?=
 =?us-ascii?Q?6OaLh3fTs6Y+3VfnbcceIVcRP2ny0JN2ciYLuGWyy+PDWFSSkysFvHOSy6gk?=
 =?us-ascii?Q?0mn6zUwYQmnEUkRQGajSTpGZ7oJOHYO4UvYM1jcbbtmRJiOfpy8n9gdXVgIQ?=
 =?us-ascii?Q?HXeQWW1rHt8IRRFBLmYTmEq1kBq4bO4lS4xXlBNYF4V4bu0UGUkS7jxzq/GZ?=
 =?us-ascii?Q?eNLLujjHU9BORt+8Rag/8heGfNUSC9XZmfYlr0W0RHHEhe4EOzgR4PfnWa+w?=
 =?us-ascii?Q?MM4FhM1MNdeXoNNphT5lFnUzhAFMRDd+JeMxi20ARMspvHt+EFaT3HcyNPbm?=
 =?us-ascii?Q?69U1tazsao/2CC6pP/c5En5edAaIO4tZmrhmJzpwECWc2R2LD0//u0K2gBHz?=
 =?us-ascii?Q?VG5vIuVz7PFZWzTLRezWXCX0yge4v7Hg8d7KNDtgvg6r2uBJ97PWOMbqK2U4?=
 =?us-ascii?Q?hRPB2jr7nbsMboO3Wk7zrSSAb5WexAmCPtl/HLdpan4SQYEBksuwTw0p6MFx?=
 =?us-ascii?Q?fAvQfKzbXA2jV+aoW/q0jCBGiKli9OOs3113dQy79V2QURGPxoySA1Whct4p?=
 =?us-ascii?Q?QlitssMJV6SdK1v4srEJAkfeur8QOAtm/opZYe0l3mgPN0QcrmnHBc8sQKEn?=
 =?us-ascii?Q?SiIiDfoZMRO8FtM6aJkpIg1yXJ0H5rdEY6HuG7srF9HsqAb2YQDMTfI8DKaR?=
 =?us-ascii?Q?rXr15caTWPS5udN4YwezxtRLKzAI0Pk/Gvkz4sI9Wmq4pBYFNaANcObAJTTN?=
 =?us-ascii?Q?77YtEZx4lMaeAW78yPvWMgDb9bU/W/gzE4FaZP8lr11VJnpkcrAe/2/BfJYA?=
 =?us-ascii?Q?ExbAn9enQfMnWitvu8a591Tw3DYfzN0Xs6q9T1fyTq2eKo3yPXTMOaUCOP8z?=
 =?us-ascii?Q?SS2l7zf3iQe24JeSqO7PNFkxFtJiseJpPbue7bGrX6ZqO8heeDfkpfnR6YH0?=
 =?us-ascii?Q?nW3fpnZ5r77fOj59tlrED+8HcC/JxPOaMTiZLONaXvK9DCbGaoIDWJ5KP5hx?=
 =?us-ascii?Q?cVLbg/KZg6wqgLQ3KUlPGP0hC7SgDe2HqmLfrhE9hMdExg5IejT7OmeOBo6W?=
 =?us-ascii?Q?hfB3+RIRYwb4YRVD1ykqSf/Jwl9kfAu5uUjbPt6MF6zCKcVWQDzH8I8HZfhN?=
 =?us-ascii?Q?CsN6/ni0npi+Jnx9WSvKlWtFIBXRDQ09wQfW3CQEM/doEmwHiz9XKizg8JBg?=
 =?us-ascii?Q?FABXPcM3+laMdHwdUYvH1Fm8nXpI8mhlhp1WYsHaO7oD5C+3MqVWd347Wgww?=
 =?us-ascii?Q?51cgrrIf5ogRoojQLpVLonmyLz9fywGIMk5UeZUadhUNqBo1OwtYPyDvffrU?=
 =?us-ascii?Q?Go8kwEG82Re/AfZqBkXqy0oSyScaaLFV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VogmJHYv3YxSt0wC2Jf1fjQgqCzHqvZHehu0P7PVqQ98ty+nAXpEY7gjhZfd?=
 =?us-ascii?Q?2pIdu1c1s3aMEVai+FEXPqveG1GG/k7A2xO9LtZ6k0wflBnZXhPanichf/vW?=
 =?us-ascii?Q?iQBNL4yUmHX1nvQrR1tNAySFZHXC1fFCCK4iVDHjL4wGtqqsD05n6kECn+vt?=
 =?us-ascii?Q?z6QY5EqgFckhkIr3p785JCqZQB+8Q4gvyPUl8vrYelnW9ml+EisroXg4HXLu?=
 =?us-ascii?Q?HRglDOgGAljhGDRu1ChS+yeuUKchGRUS69Cy/f6saHyG9QTE6rIxP+MIRrK+?=
 =?us-ascii?Q?qk+5kiGqC70spD1YhfPjtkh7IymNldHMbUppf15Zj6zQTKdE4oksFeABoGf8?=
 =?us-ascii?Q?xBZAcXLiDxl8pWL+eM7Z6Qj7dgl5740VZsXihGzHhCfMi8tV2pQBpiwUPUgx?=
 =?us-ascii?Q?V/LtKnSC1s4hPXfMKgMYXUNiBRImB5+rk2+roTP8jMFk9UWmtqNm/pw5ndvY?=
 =?us-ascii?Q?7tyryicDSrE7aohEK1OJc3cJrM6a7Tjn766BE6eVsDpvdCFlXUnVdRhyoH/r?=
 =?us-ascii?Q?C7liMrQaIf6EzxMvV8nojoJnE9h2NoXqkmoYjcO4u368LLZLDPGBqcqsPj/e?=
 =?us-ascii?Q?VOmIC5vwkb2WY/jmkuQa4R8CcW2DsuNYjp5TLjp2MRaaWN55VWTL33YTB5lA?=
 =?us-ascii?Q?vJk9Jdyk/hzQtjRPIOZt3K5/tDsgikklL2jLMBVHJbHiKsQSO7mVOxtgS191?=
 =?us-ascii?Q?MtgV+r+pRw18AW3ldVeEGTFny7mSfDU1WOMH5gFsZw4pEflJVzqbAL0XQG5Q?=
 =?us-ascii?Q?R02Eb69qPPoiC1FHYInMYrWjEMLmra19gdwVEPQwIhy/lI/18jJogcId9Xx6?=
 =?us-ascii?Q?96stccE0C9q3qdzddacIOO/z2ovzHYyQoAE3SC/zY6KK/B5MX83Jv6OO0IK9?=
 =?us-ascii?Q?7Sjc/Rk9uIiY0p7AQSHwxchQet7j8fjuTnSDT4V7+ZwmfgFZ7HW7C2wBsyEl?=
 =?us-ascii?Q?kbejaNSWLMsV0HGdyHx2mMfHc32R8hu8rALfSF9jpNCvXizapHKxsKJFJAC1?=
 =?us-ascii?Q?bjm0MgLYLM/hKNyYngjGRDy/fKDzGDPYIZybY31J4xMTcx5GQi8fDdzZmXjQ?=
 =?us-ascii?Q?YvZQ1QhTxxRDQJyhKvggJKWz74CKQyOxQAt8FOoQkr7rCPei9jB47Y6n7QyY?=
 =?us-ascii?Q?yd4mUgzku+z8RlTEVTCsUCvzVh5+qwCpEzLNAW4DZrSGjYe99NnBpjL40ZCu?=
 =?us-ascii?Q?WrkvvOGG7Mfo7AlaL8xJ7FKJ3QtekluogbBaSZNeCqmKYMspmNAzrtWsvVdK?=
 =?us-ascii?Q?KLw3D21Vu8Z4/WOwUpPKmOS+9mL+McSV6ewGHzbNmCms3QQnBfcBWb7KpaAO?=
 =?us-ascii?Q?OgViY6wOFE9iWkGnjRVTbVPPB2tEpl3mNpv2RvcPssqxA91TqVyWSc1zB+/+?=
 =?us-ascii?Q?1TkxYlUVY9uCVRp/KKcXac5PAk+sqFKHAxk9NqVWZdhKfm9Vuz6K+a1qUOg2?=
 =?us-ascii?Q?HKDTBe+wMA/1+3t8tgvTOvytwonSBtp15YZsOM0CzpETdnNqjCG+eWSLG0Am?=
 =?us-ascii?Q?UIlqGvNru1tyX/2+yMbyjZar94VH3uX7X7UgtP4WIYMQliUru513RgAIcbXA?=
 =?us-ascii?Q?a4dLIpvrZLe8wCBQjv4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90847167-55e5-4026-8099-08de0273538a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 11:52:28.1491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4HwDs8g8OBlPf5M4drpbiACk+2jVprctFND/PYDNu36KlEcfboEHBE97/G+Y2AKJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4460

On Fri, Oct 03, 2025 at 02:57:53AM +0200, Danilo Krummrich wrote:

> Which ops pointer are you referring to? Do you mean the struct pci_driver
> pointer? If so, no we can't access this one. We could make it accessible, but it
> would result into horrible code, wouldn't make it possible to implement the
> check generically for any device (which we need anyways) and would have some
> other bad implications.

Yes pci_driver. You must confirm the attached driver is following the
right SRIOV protocol otherwise you can't claim the result is
bound. This is where we are with PCI today at least.

It sounds like you plan to come with patches changing how SRIOV
enablement works in PCI susbsytem, if that also comes with a way to
detect that the driver is following the rules without using pci_driver
then great.

But that would make me feel more strongly that this should be a core
helper and the existing users should be converted to the new mechanism
so we don't have two approaches here.

> Even if we'd make it accessible, the driver field within a module structure
> depends on the exact implementation, i.e. it depends on whether a module is
> declared "by hand", or whether it is generated by a module_driver!() macro (e.g.
> module_pci_driver!().

It is kind of a bad place to end up, drivers do occasionally use their
driver pointers for little things, like this for example. It is not
common but it is a technique..

Jason

