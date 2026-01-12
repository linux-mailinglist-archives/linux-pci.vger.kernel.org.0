Return-Path: <linux-pci+bounces-44449-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EE19DD102D9
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 01:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF00A30050A7
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 00:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDFA3A8F7;
	Mon, 12 Jan 2026 00:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iT7WLjVd"
X-Original-To: linux-pci@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010032.outbound.protection.outlook.com [52.101.61.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC383207;
	Mon, 12 Jan 2026 00:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768177424; cv=fail; b=mXcEbw+LF5rBC+imzqg5l0Cj6F6MM1fIF/+To9HHcD7UBLck0h+/255J+Xq0hNo3TbTKipqQTLDv4oStVkwovCHZXy28iKsbAWAyDxy06G4YNI+Hhvq2MAPSYzFm7DrGqObVVTscqqQgbyQKfMElgftpeeMT2e84dfGtkjcmi6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768177424; c=relaxed/simple;
	bh=Qs+dZibC/FMKfxRu+puZTvz5XRZQxlYJnIz7DGSHZxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jUxEFtI/QxzUC5PdSNyx1OlLWt4bwHLwoRrBK7dyMks6ccGcAl4H0b5Z0Yhblwaw+fyzXp6ALPoluq+ejVJBCNGWp6rqyB+VKKaQPZ/xHdTX7g20TEEQyA/bAmsDVmVZKGgr4Md248CObGuI8K5/zXjWsaDPgVerkPLxrh3E5W4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iT7WLjVd; arc=fail smtp.client-ip=52.101.61.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X/i12CFyhaf+aahCOk1z6Ctm7F0OuS9mdAGPF7hKCMFvuLehTr6G3POj5kCczXvfqt71wCZAsKmtHobXw0grrqiL9EZjnAaK8FQAYHWkREsaDPJ/+ZL2M79TiuBcqcQe9Uov06h2LfLtify1Ku+0oJ+Hy/Dm92RC7BHH/6Sx35r4is2XdtzJK8we0F+z8mTFHZsCDkYTpTFVQFY8e43SweGV3gHftz/mL3ECHliFx3ZE2H8SPEr1K14598tbnBzQsKbA4xNS9nXpWsXQL8uFT3uMqNKOugO5vUAhES1ij2yu3cwYMByDRipKl8uspgpnHQfSiRqWiAH8CWWvTL/MKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QvPBb/Ymf/HIKdN7nuWxlyhg4Yb5DnkQDhrEy8X/QOc=;
 b=LU4b6rcdigwKXkwkeCTDPG/tmvCH36UHqH+hgwzZlQFjfElXnvOk1Cid0HXUSrdx1Jshyk57hTQk/gfQunhxcl1KZeRdfCYv1RaqxVJViVSVTc8CIAEE0yXrBzxgmXDB9jIVcM4dJbkFoUtZk421Xc2UnReHiGScSY4vdzX7AO5++YCdFMoGnbrwg6h9ClDVaDnFPYneejkBhtaXnozuzKjHZoYnNaorlS8z2hYpamHzcH/X3LXjfi3lSZNPF1iOAXwnGWPMx8aCFO6f+uWWULuj3m8/PkJRgpfFEjjDNxJbHOJjDN0eSDvlIzTbv/otwi/l3UDdd5o5U8LGv4hDiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QvPBb/Ymf/HIKdN7nuWxlyhg4Yb5DnkQDhrEy8X/QOc=;
 b=iT7WLjVdSfbbPh0OzBXQTNqzlfrM2pTaNTSf/3qtk2rsZhg0xT1UOQV1+LrM6sHdwUDNVydyKKSpEqT6u7Z6sOQBwgmeVqzip0mzfq3RBjaftHlXGtigTHle/UzWGCayN3OCVBJc0VPvr9F7krTFkcK79Nn58Izu7R5AxrDk+nH5QiXt3bC3XEiou0BG0CowK+ccJOsJME2JBFEpOrjnZbWe0d2MfwCqERbBMqwlXTpuZLVdTjiYuXpZsOiKXhA5H/4NopzSq1A4wEKQvTJ8RtmOPeE0/OiZl/ZjkGMiHb057JlExnoQBmkRVesRWI4CxZw6cs2A0Mmz1EAiB5sHSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 PH7PR12MB7233.namprd12.prod.outlook.com (2603:10b6:510:204::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 00:23:38 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 00:23:38 +0000
Date: Mon, 12 Jan 2026 11:23:33 +1100
From: Alistair Popple <apopple@nvidia.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Hou Tao <houtao@huaweicloud.com>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-mm@kvack.org, linux-nvme@lists.infradead.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, houtao1@huawei.com
Subject: Re: [PATCH 01/13] PCI/P2PDMA: Release the per-cpu ref of pgmap when
 vm_insert_page() fails
Message-ID: <n3ex3s3requwlub5lmwl37ia2uqnl23ngic2icvi5qqozrpts7@mwrd5ucdi5mo>
References: <vrti6maahtwfrd6xrdmyupunprioodhl7x5alpi2r6kyi4qcyr@ga6a5yrdvmb2>
 <20260109150342.GA544448@bhelgaas>
 <troogtjpbpaxbx34qu56a3qeu7eat36lzp4pvq4asoejxv3zbp@za7hekzxsgpo>
 <j7uozwnjzvcbhhwlhb6qgwlrve26dfhvwdo3w4uk7lcp57do37@v4dczubjeoy5>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <j7uozwnjzvcbhhwlhb6qgwlrve26dfhvwdo3w4uk7lcp57do37@v4dczubjeoy5>
X-ClientProxiedBy: SY6PR01CA0093.ausprd01.prod.outlook.com
 (2603:10c6:10:111::8) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|PH7PR12MB7233:EE_
X-MS-Office365-Filtering-Correlation-Id: 32278e40-8c9e-4d7d-0ec7-08de5170d4ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IFK7cr9oFWM2c+YHs8ue4vYLl/cRcUHDTTsdDzLjbEAJXgLI/SYAejsE9dHa?=
 =?us-ascii?Q?RPrXTNhFib0DJDniqp0MVmmo4+nKWhxyuZ6fBwlfhXld8PLFEgjBczpWFZP6?=
 =?us-ascii?Q?HeQIFcD+RUmwsoQgR5P2u0BbzuDX2GeuRekioq+d4pVign16e9HrICgb6v5q?=
 =?us-ascii?Q?8J1cSa7LxMWPSTetq4SutxqyCUzWGHgO9Dz8Cf0GSxj9iKy6ZozeLQmyug1+?=
 =?us-ascii?Q?4SCG96CX714iuhr93Os/MEd/gorNd7KxwmsjnBnqmRoAuMe9vc6u5XuMZVwK?=
 =?us-ascii?Q?mYEffZE6pWtgtlH+Lapa/ni1fG8PzUdRjz3/EwPdTnSNyknHrh51ZdnI9yTb?=
 =?us-ascii?Q?8ThCbB+0cWgFsGZOC0v0xPOUPysOxiJWmw9wKaeLJ/ZKex2vd82kcPBd2D1o?=
 =?us-ascii?Q?nUGmv8m9dW6BAZEWSKlLXDef7OUMpZzvLiXu6dSn6eXYk4MvJ6X1pOuvPL/b?=
 =?us-ascii?Q?frBukJoGiCQiDdhrHdAgBI7yzn4/BxOUiEUY5pKH+90aWWDKC/HfmX24sH8l?=
 =?us-ascii?Q?j2F5oWK0oB0CpRMLjunFz+gc3XPThdTVG1b7SuS45U4P0ISiYPKi1Xbo3psI?=
 =?us-ascii?Q?e2Ii/bI8W1GE6c0OUl+o1tDaoTBVnr6xOX0VWp6E1xAOR/X9eSMsJnEJoF31?=
 =?us-ascii?Q?i+6XkQ0cwpQuFzX1STgdCZ6YZzV5vVvyPynJuRwfKSLOgA5nrbnPY3HKOTQP?=
 =?us-ascii?Q?X18/jL1uwIH6f1DmWSSvPiJAYFpd7PoQ19MPeAcsosxb7u4qh/sBpUuQqHVQ?=
 =?us-ascii?Q?GHpO4+Y0IJlctxh4w15zKT+pd17HNBCiDDjSoDemuEpjlhCOptp+19CN5JSn?=
 =?us-ascii?Q?e83Zrktbcd+4yhOD0Qek81va0333WnXQcoZRV1guv2mP5X/IZyF4brhQtpu9?=
 =?us-ascii?Q?RL3jfEK4p88MmMSnw+ohkh0gi1woV+POLLRluEwK7K2irB643mglC8pyKiTm?=
 =?us-ascii?Q?RpFibeN7DZ1ymV+jgkGWga8kM0chkHS4iHWANJs9l5DK6b4HvBB6j+2S3mbG?=
 =?us-ascii?Q?y97bnvIAMe25JC7N6bvRmBjnMEQM6L8n1vR9Lc4KfnhZdhKmvCUxKgE90FI4?=
 =?us-ascii?Q?5Oiy7fHcPlB6L7jQ52BQWuiAf+Lg2cmndGVjLMZBBEf0C48HJz4DkNHpbQ5Z?=
 =?us-ascii?Q?DBbRHdDh4eIiVzb4CCPRWPZWb8WrtsmAx4wGCMBDq47ZAvXMQ8+x7/BjChIr?=
 =?us-ascii?Q?KjyubNIG4QIQfVeXqJexgmE3+krcwyY5qZfGxpLXvwU8vaUEUa0aVapxl40U?=
 =?us-ascii?Q?czHXj603ghMa+E5GoexGge3a30GMNrRrncC/MYzy1flKscEENwsh8UXYT8aT?=
 =?us-ascii?Q?au437Iy6IyiL0ujl0H+1a83vJpZjzXGIaeniHwlpqBW0604ve2rNvR89Huun?=
 =?us-ascii?Q?ynEWSKXCvR6l7JEN4mlnF4TEFirUvLq44k4luZ5DqeCK2SVw149OnwLv2AO8?=
 =?us-ascii?Q?acwPPHrkTtT4PrF32TKLKV5+2NpjI2Ze?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S0/R1Le9lRWMRLkHFO106kdFMR6sBFbOHr8UQKj8VbnRJE2WoAeioIlGLAV1?=
 =?us-ascii?Q?GIuLC+3k/PGlMVBFG+qnirdkGMmfC8iYHcxWc40O0wus532dV/lJ1d9AFdC3?=
 =?us-ascii?Q?VUZzjDwLZ/QxgSkKCepAVuKlLdBbtzO5TBw8wgE6J3jx3+gfOjZk+9XSr3LB?=
 =?us-ascii?Q?54KegXOfE4bE+3xRiBfBacFvTau5tOt+c/P9Lo9qsWLnFmZ/BsSxMn+wjCUv?=
 =?us-ascii?Q?xLE1fBKVEGvuqGk18kExAwN1HmWO9Do6mZEi4U4N/UM5p3f3HTAEisANhr0F?=
 =?us-ascii?Q?cAvEPUwOzI5UhbLJCcJqYxFBE+L14GHhC/20YeYFNw2sU825WzVKKiszW0R+?=
 =?us-ascii?Q?IPUrsVAyjFvYb7Cl+sjMPhYopjlOVuxYQixkf2DerRzAr3C893lXh3stOylg?=
 =?us-ascii?Q?W3LWQmu9Y1Y88SqcSU//YsMCnBMgJxjIEm2KQLUQ/K41ORDqfUC7oQJzKhzt?=
 =?us-ascii?Q?eeli6KUPNyLL7K9GCoH8KXmXqln5WI9m4yMDg46a64RUhpKk2wpht4Og1LMM?=
 =?us-ascii?Q?kol+9ElFuwoH+cdfk3832TM7hXILsOONhKkkahC93rMIi6T8806LIiLEFjOz?=
 =?us-ascii?Q?V/9web+tnq2IRfCMjAZAyQ4aJO4ngCumO4LyqunpsE5xKVFLXCk6l2UvpM9H?=
 =?us-ascii?Q?z/qErylNwWeP3sKsmjgnc7wxo+OtQ+m9HU57omFUp/EAPD7JOY2eA8Wgu1NB?=
 =?us-ascii?Q?RR/PprD59oBH2SSPlzOn9N6UYvvU1vPwlHPgKcJdhNkXtGltEqEK4obUhXS5?=
 =?us-ascii?Q?STAVhx0snFoyz6OV9bNSeP/9GeSFqTxpbFO5DFC5PWbKwJWzp2XgMxp3qBOA?=
 =?us-ascii?Q?EQddhKuu6vsP9dGgnA0ooB7wZ4DvJ9zMlsb96FLKukZh6VR7Bf5wpul3D50q?=
 =?us-ascii?Q?eoCmS3AHe7RzDyjeoefepNM6pBIP7KYryShV30Y5NadqKcQypnJJ+6C6B0J3?=
 =?us-ascii?Q?LX0FCUmfaK8e2fHZ/bcayWvAIEFCHQ/cDG27fd956Pr0QorrhraiYM1R6E7J?=
 =?us-ascii?Q?MHGk+fRcMqO/NLJmL+vsJNkaZlGdKEPckBCtDQnCLpE5whngKxGEAeVKAkTf?=
 =?us-ascii?Q?ishBumXsmwFhQyfHwMHzJ7b9rL3tALdsY2Fmnh/vMBNL+w49Cdmcrb9bIQTV?=
 =?us-ascii?Q?J5Dw0k4jpw8am7grZeyq6MkT8hNtjieKsvd7sYAQffZAshJf7hQvaN3jZhDI?=
 =?us-ascii?Q?DaTlK8ynCAzYPy9sf5x6Ww1GDZpgt45YdWNxQ9NM+bPqrGypuE2/O7jrP3yC?=
 =?us-ascii?Q?4WVwk8JpASQkfosWd8tE0q/entzIQetT43o4YUhqpADV1FXjtvAkcSGn6JmV?=
 =?us-ascii?Q?Kswco3sS86rbx+KuIAmetmRry4VL/DUJtkycTzsy26zpMLCjk52TPrH5TgKR?=
 =?us-ascii?Q?YhUFUHoJPkZwReXMj6+cVsUjC4nHZamzVpPSfcmhIY9Gjj/RbeUK3CRU9rmr?=
 =?us-ascii?Q?cKkN3e1+D/u++z/bFE+k/hT833cWvaPhJ/lc3jV6msBj25np8X6a4Wggtr1I?=
 =?us-ascii?Q?g001CU5Yxx1FsmlHWOgKQ6I2W6HBIeAdMcHKmO/UGNjFCVAqi9OCxJXn3J70?=
 =?us-ascii?Q?defcH+GJXZEoKdqDtT29Zit/Dkst37X03XEdle5asGI/fkbKu+zPUcAOlxpd?=
 =?us-ascii?Q?An7eP9RPANNh7zIkqJy+fCEwlmve5kaCZpi/Gi08DCh7S32ZVJ/DujBg1NKx?=
 =?us-ascii?Q?jg3UqQG8Nb2tLIHeTvzu3Yi2j3XUmModfWPMbAv2U5m8GQoO2rTCDThrNpqm?=
 =?us-ascii?Q?vD3uQP/h9w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32278e40-8c9e-4d7d-0ec7-08de5170d4ab
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 00:23:38.0538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QY34EA9tYBE3l/x+oN4P+JeRkBK5WTqHdYpnUg9SBZYGMGSYqsFyVhFAGmuOABCS3NbZfZg1z59yJRGkifLwTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7233

On 2026-01-12 at 11:12 +1100, Alistair Popple <apopple@nvidia.com> wrote...
> On 2026-01-12 at 10:21 +1100, Alistair Popple <apopple@nvidia.com> wrote...
> > On 2026-01-10 at 02:03 +1100, Bjorn Helgaas <helgaas@kernel.org> wrote...
> > > On Fri, Jan 09, 2026 at 11:41:51AM +1100, Alistair Popple wrote:
> > > > On 2026-01-09 at 02:55 +1100, Bjorn Helgaas <helgaas@kernel.org> wrote...
> > > > > On Thu, Jan 08, 2026 at 02:23:16PM +1100, Alistair Popple wrote:
> > > > > > On 2025-12-20 at 15:04 +1100, Hou Tao <houtao@huaweicloud.com> wrote...
> > > > > > > From: Hou Tao <houtao1@huawei.com>
> > > > > > > 
> > > > > > > When vm_insert_page() fails in p2pmem_alloc_mmap(), p2pmem_alloc_mmap()
> > > > > > > doesn't invoke percpu_ref_put() to free the per-cpu ref of pgmap
> > > > > > > acquired after gen_pool_alloc_owner(), and memunmap_pages() will hang
> > > > > > > forever when trying to remove the PCIe device.
> > > > > > > 
> > > > > > > Fix it by adding the missed percpu_ref_put().
> > > > ...
> > > 
> > > > > Looking at this again, I'm confused about why in the normal, non-error
> > > > > case, we do the percpu_ref_tryget_live_rcu(ref), followed by another
> > > > > percpu_ref_get(ref) for each page, followed by just a single
> > > > > percpu_ref_put() at the exit.
> > > > > 
> > > > > So we do ref_get() "1 + number of pages" times but we only do a single
> > > > > ref_put().  Is there a loop of ref_put() for each page elsewhere?
> > > > 
> > > > Right, the per-page ref_put() happens when the page is freed (ie. the struct
> > > > page refcount drops to zero) - in this case free_zone_device_folio() will call
> > > > p2pdma_folio_free() which has the corresponding percpu_ref_put().
> > > 
> > > I don't see anything that looks like a loop to call ref_put() for each
> > > page in free_zone_device_folio() or in p2pdma_folio_free(), but this
> > > is all completely out of my range, so I'll take your word for it :)  
> > 
> > That's brave :-)
> > 
> > What happens is the core mm takes over managing the page life time once
> > vm_insert_page() has been (successfully) called to map the page:
> > 
> > 	VM_WARN_ON_ONCE_PAGE(!page_ref_count(page), page);
> > 	set_page_count(page, 1);
> > 	ret = vm_insert_page(vma, vaddr, page);
> > 	if (ret) {
> > 		gen_pool_free(p2pdma->pool, (uintptr_t)kaddr, len);
> > 		return ret;
> > 	}
> > 	percpu_ref_get(ref);
> > 	put_page(page);
> > 
> > In the above sequence vm_insert_page() takes a page ref for each page it maps
> > into the user page tables with folio_get(). This reference is dropped when the
> > user page table entry is removed, typically by the loop in zap_pte_range().
> > 
> > Normally the user page table mapping is the only thing holding a reference so
> > it ends up calling folio_put()->free_zone_device_folio->...->ref_put() one page
> > at a time as the PTEs are removed from the page tables. At least that's what
> > happens conceptually - the TLB batching code makes it hard to actually see where
> > the folio_put() is called in this sequence.
> > 
> > Note the extra set_page_count(1) and put_page(page) in the above sequence is
> > just to make vm_insert_page() happy - it complains it you try and insert a page
> > with a zero page ref.
> > 
> > And looking at that sequence there is another minor bug - in the failure
> > path we are exiting the loop with the failed page ref count set to
> > 1 from set_page_count(page, 1). That needs to be reset to zero with
> > set_page_count(page, 0) to avoid the VM_WARN_ON_ONCE_PAGE() if the page gets
> > reused. I will send a fix for that.
> 
> Actually the whole failure path above seems wrong to me - we
> free the entire allocation with gen_pool_free() even though
> vm_insert_page() may have succeeded in mapping some pages. AFAICT the
> generic VFS mmap code will call unmap_region() to undo any partial
> mapping (see __mmap_new_file_vma) but that should end up calling
> folio_put()->zone_free_device_range()->p2pdma_folio_free()->gen_pool_free_owner()
> for the mapped pages even though we've already freed the entire pool.

Oh nevermind, I hit send too soon. Ignore the above paragraph - I hadn't noticed
kaddr/len gets updated at the end of the loop to account for the successful
mappings.

> >  - Alistair
> > 
> > > Bjorn
> > 
> 

