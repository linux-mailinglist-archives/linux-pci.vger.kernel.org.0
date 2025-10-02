Return-Path: <linux-pci+bounces-37431-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F711BB413D
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 15:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B57E21891530
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 13:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BA32FFF86;
	Thu,  2 Oct 2025 13:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DLVbD5yq"
X-Original-To: linux-pci@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013017.outbound.protection.outlook.com [40.93.196.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5553D279DD3;
	Thu,  2 Oct 2025 13:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759412548; cv=fail; b=kJboAqtbdbJQPhCKQSe+M6O+UmdfBqOa8yGv0H2w3Uegvrk3sSyiGXMAsvXpYaL1hyGhA+n8Hu7GKJkTToYgSunALZU5xkLTlXur3sf7ZOFmtSE48PdJsGWfzhglowopKi3KXDbg0/XeQX6uT0FD+Z15NFyxouclCZHeWq4Dpoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759412548; c=relaxed/simple;
	bh=hvToXLAGvngHik1JQAqfkBRVI+UZ3fIr0rw83lL2VTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q3TGgfVrS4Z1qNRQLcZCKPuaZPWp3NKPjzsO2s4UPtJdQYjeVNBZFgpVpxhhyI33o4pklE9kcaYa/H7SPiCV/sA+jYaEo+TQaqPDSLKc3dg7P9RGQi4POEO0AXAzwmz2Nr+jM0CQ+3uSheTRu0VCezGBwSuJLrnovjvOqGjbZy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DLVbD5yq; arc=fail smtp.client-ip=40.93.196.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=abWblL4oEE9ZQR53p26hUGyuUZXCOVS/mf7BhYFcy3e2HkTaQDOc7ZCkoQ+wlnhZa/xVt0Xcggg/3ZzPI5IPo6g9QY0StKnrTB/O2CP3TbvxTrESgXL3azqFbz0CSaazHlFC8Jrf7xH74fMHopidy4dumiu8eoxqJvToF4BG3t8VurGs8sDiwa4wCmIc4Kn3WNkzpRWLelKdRjpi8N1ddStPq3yrTFAwQdqL2xP66fJ/Fx4m0JF+26OCFuRpeycWhHnMz7ASbopDg3ekhJYP7aMBEVepxxcvzQsAcC/gSJUkcShNJVtoiTMtEoEw6Xmpe0XBkUTFrVJ4r33pKMnu9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPW+f9QVI2n1N8G5TGUiw+3k6HIscInUjGLMYwwZD/Y=;
 b=ViuqNi85b3hxfXI061pNn4wqj9fjoXIEH/qu1TDtK/024C1nT9sp7bkoVuvf7m0nic7QczyWmN48OF6QMsuE2MMXuhDNU6A6DO1C4cdDaxsSEWNyz0ahElHv8sOGnRrAbTY64E0aNcquf55nirVT5Y0h3mkQFCOX3ab2HHaneXzHQBzYTneQ4qouaG0th1XWvQHLG40XbGZD6z3I4xJgDZFR4HBttif20i99emzIr+9kAG5An0Lenvq1pBQw+DhPpYOpg76UoVmV9ECQ32BHblpjc7JLY7jL8PeDW5ZZS8bMEOJVcGKA4N1OzS41mscp7fQssmT9tG1g2yY1OT5umQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPW+f9QVI2n1N8G5TGUiw+3k6HIscInUjGLMYwwZD/Y=;
 b=DLVbD5yqvSDtXJLoNN1WhjUY17DPKmZga3sYXHbRQX47NEjhbpOTkgEWNzAQsl8y/q2l7oK2OnYaen/KTsfXqJtjVGtYhLHvRXqp1MoWvUsTQPHG1Rv+wzelWCIDbo2vgD25in9tSkEDGw7UzKHPqtxYqI6i3Eax0yG53Nsm0WfHn25U74TzFNTFjg22DA1UX9IlB1Iw5AaD1Ikikye5lWV2DbUH6Tu//4nUeEZQ2pVWypya0CR4XKngIRahMitFP2REHZZmsnuTkFKg2jM1i7M0vufjIajo0NlsZ4IgjisWIfLahUM2jwK5oLZiRxn01PQbciJVwxxOWUPtd0Rn+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by MW4PR12MB7168.namprd12.prod.outlook.com (2603:10b6:303:22d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 13:42:23 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9160.015; Thu, 2 Oct 2025
 13:42:23 +0000
Date: Thu, 2 Oct 2025 10:42:21 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Zhi Wang <zhiw@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Timur Tabi <ttabi@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
	Surath Mitra <smitra@nvidia.com>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	"nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 0/2] rust: pci: expose is_virtfn() and reject VFs in
 nova-core
Message-ID: <20251002134221.GA3266220@nvidia.com>
References: <20250930220759.288528-1-jhubbard@nvidia.com>
 <DD6K5GQ143FZ.KGWUVMLB3Z26@nvidia.com>
 <fb5c2be5-b104-4314-a1f5-728317d0ca53@nvidia.com>
 <DD6LORTLMF02.6M7ZD36XOLJP@nvidia.com>
 <12076511-7113-4c53-83e8-92c5ea0eb125@nvidia.com>
 <5da095e6-040d-4531-91f9-cd3cf4f4c80d@nvidia.com>
 <20251001144814.GB3024065@nvidia.com>
 <c56bd720-d935-4b51-b507-d794df3f66f4@nvidia.com>
 <20251002115851.GB3195801@nvidia.com>
 <ea82af0d-663f-4038-b8c9-cf1eba5bc4df@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea82af0d-663f-4038-b8c9-cf1eba5bc4df@nvidia.com>
X-ClientProxiedBy: DM6PR03CA0091.namprd03.prod.outlook.com
 (2603:10b6:5:333::24) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|MW4PR12MB7168:EE_
X-MS-Office365-Filtering-Correlation-Id: d283150b-829e-4642-643a-08de01b98464
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5wf1ASRQkuXlsA5SapXxD7GuuIENN1bcxGvl8x8K1cam0ZyELoXbRtr5VAOY?=
 =?us-ascii?Q?wSnY+eBga84cSIm6ZqH22GdI9s++EgIk1Ocv3Cwez/hBhnzFMydId8iMe8hD?=
 =?us-ascii?Q?SX/fqGABA+QMraULtrTQh77mbrjGG/4mct9hwTGsh5YaG89PpbeVGgO9KSzQ?=
 =?us-ascii?Q?l6+y/fD1uEvfe+hQrh2E6OcPEv1AyZJqy+2HVyImGR3nZOZD8HIEpxo9B/oM?=
 =?us-ascii?Q?T8asE2WElvQoia7PO9IPV/gZ11Rzkiza7Cu54gbtznmH8OuhTGwKS1temfJD?=
 =?us-ascii?Q?yvz8hGdUoyq8Vp8p4ZgOIWYmJUX0XbwYw533IVNSca/FOZVPfocYihJGkeq/?=
 =?us-ascii?Q?zvTfc10PQZSvVKBkLAxftUO8T2kHLUwFaG99QHmJbxEGAgog22QKKqA7vEIf?=
 =?us-ascii?Q?G0noeGUdAXQB+FhMSdAzPxzvxgNtWn5iiNhr6djuIjbO3oVgK/H3u8K+CMyX?=
 =?us-ascii?Q?cUXVfcF84hPQ1itzLiNUZm9rutR4qRax3W9WLESlAZfJ6UOMOA7EnAAHDqaw?=
 =?us-ascii?Q?slvnqNbQpL9ryC74UIRtN5TU6n6+FUAjFN7CpvW0tEb6PIpXINzrH+uqDpyW?=
 =?us-ascii?Q?9/TluQyVBWO+KSMgv1fhsqpUd7KKNQvlMUA1qgUNgkW1pXxJbeKl/ozxPI3P?=
 =?us-ascii?Q?GMJdTmDzKE0ufeTm3m6N+lQ8Q3bdOjl0arUDerGmvwFstgeEgfPd1kT15b/W?=
 =?us-ascii?Q?hu0NJGUnQIHHVdpnG2tpFjysXCwx1MHl8lqelZWLbZJ/Z3w7lAUauNJI8UdQ?=
 =?us-ascii?Q?EMRv/Mt3pUxGMrO7ayPctuv8o0k21geBJcr4qyD7tdBCAWvWZ1+WBTqdlWTY?=
 =?us-ascii?Q?kwfCSJJ1K4v9XmKxBt6jM8ImriQp4QE3T55Ku3gvbUDw/A0rAvpv8Ue4X6Yo?=
 =?us-ascii?Q?CkzNaxqtw4XMy0dXKvLEiEwCDnG3T5u/EWRIPqUs46k5fgTN4cWxZ1s+egeo?=
 =?us-ascii?Q?oM7ApzBOKW2cCirk4/Xi2mYXsHl9wjyVAOo97p1XpGUb6+ZpbBDRR+JuozaA?=
 =?us-ascii?Q?fq3NwgebjujyntMVpQ1algv+irR3En14AhRg+SFAT0DT2nL73gzAsA1uFkK/?=
 =?us-ascii?Q?r8//zMnxIVa9sJgjdV6E/82Kxv210/57UClKJn7+h2UkN+BGVd1+mbVEu1i5?=
 =?us-ascii?Q?mqKW/eb3jK/3U4M6i5VkiGMguQy9O6pUKz6DkU7jkqVE+Ql4YmbCXpbD4tEV?=
 =?us-ascii?Q?mfXwnQtSuU00nBON7VkaFfpyPb7MoTVqC1iX+RHK7Pm4bUCLoHquHBt3Eizw?=
 =?us-ascii?Q?DUYHieXqkdksAwOaPKxgr1GolSAdxuaSHJMgSUVdY19BfNTxS1OcqhWYumbK?=
 =?us-ascii?Q?vC+pe2KFVwRXRxpM1SzVcXPLBX9cX/9usE8HTxg8OhTE6WUgVvqhMf0qfFNh?=
 =?us-ascii?Q?R2dHSpk5oBtqXu1cERd044YJfpf4uZs74/ljbvF3fPkYzHJ6VH0pANV+yLxK?=
 =?us-ascii?Q?tEMMOYdXDMjw9KADxVacieId7MLzQHn6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LdMeAVmL7+Un1Fmfil9RkgVsW4q7WBHu+Y9pjJobOxkwSuzctDbQ13dTAOSF?=
 =?us-ascii?Q?XNWSrm/Rxr0z8aR1DXrhLLLwZILZ5QVzo3rTR/PFv2yjbXR4F8szk0M3dH0G?=
 =?us-ascii?Q?dtUe0xQnb/cz0Lv3+v3KLW8mNvZb8J64fgauZM4SjJyAYZIlmLN1Ndn7TSbe?=
 =?us-ascii?Q?+6GQgdLA33Y/MExyCx3jwp6F5VNQb4y5l0+DAbJoYH0CE9URuFDB+/V5lLS0?=
 =?us-ascii?Q?0LjhqWPKIwgAIenW71g7pHxWPYPxJdbosU6mAesXDDh83posh0AbHwlncqhy?=
 =?us-ascii?Q?CGUvBUnfXmzzkJQb9udOoxCy1SuO8EaULN2cWLC3X/FEHQWMehaMaBACrAZU?=
 =?us-ascii?Q?Ppq0+1vCCEiqPpbxsJnr8PSyPRhjW6wwIxTSDlM++O5SaLhoatUyOTxNWuL/?=
 =?us-ascii?Q?pYabpeguh5KiQhxWqthNtunsknj4QpiWtngQgy+wN9pmW5aT7/557KGdZ9bu?=
 =?us-ascii?Q?d0BOKiYbrFN+Kgn8s3BI64z9zsQ3WRv1LhQ4imCpNsmbJzqPCqUkSRf5OgHI?=
 =?us-ascii?Q?Q3fhT0a7wFj8IH18D+4M03DDMmxBJOrNdbgcpa4R9h9h+gNv+3vBosr7J+yB?=
 =?us-ascii?Q?0527w76tggAfGCURc+XKC0PbXaNltLusgb/YwwJK38u3FFzeXiE/8JsthqPq?=
 =?us-ascii?Q?bU5ceCTSXIwoN1VKAESin6RJNezTFAxO45UTjHJ5+6YiEVGbIfM4D8OMpwU3?=
 =?us-ascii?Q?moSD3CYbu5zRtVY6fDAg0t8+Xi+MucGQevX32/n8Vj7edNLu+1L2ZePzVBmG?=
 =?us-ascii?Q?tzzlPBJ38vil68R5aTIx9HS57aWUDN8Yov6GZYNzcpc8dtr7eoCH4NHoDPIc?=
 =?us-ascii?Q?LCX2CMME8oyjkhKLR7/DY+9dRP4Q9xj1fgsgXKJ9DvtqHoDHisSaDrxerz42?=
 =?us-ascii?Q?ak9iuDUaPcPgxJmQc9eH4n2wdtgejgwShPEULRgehbke17Ki0iajv8YZmcLv?=
 =?us-ascii?Q?Wc+Cwzqze3o5ka7FwjhdD0bUrvXIeM98Kx6gn9M4c7S+j0cWFfzibMH38Jdl?=
 =?us-ascii?Q?979wK+2SULkJYmGOD5GCj8UzSEbwP+ygvfAWOLrT3NUnCJ++NrRtzDlo7q2s?=
 =?us-ascii?Q?d3NF7K+Vn6Sa/56Wft9Ts24UAJO4LorxWvnJW8dT94VJxyJNEc3x31Zv+qFE?=
 =?us-ascii?Q?l/xR5NGbyRH2pAw4YPLkQNlfUlT+sCrOr8imPxTdahC0NNc2Ys2lI5eyiuCb?=
 =?us-ascii?Q?GCyLlsYFJ5ZLNuezyUxlppdQEuaUZKQYJsIOSo4tkwrQbBhsJKlhaWBpFFYC?=
 =?us-ascii?Q?r07Lodg40F9TjkOl4X6Mws8vyEE6Vrt8NScfLio/krG3/0QWQTm4tNrKDsGA?=
 =?us-ascii?Q?+559rCy3OTeKUGiBVyc2Y+jGHbXidcFL58WKeh5FDCXddYoSa8rPZlz0QQ+d?=
 =?us-ascii?Q?e8Bnn8dj+/hwEipESTx8kEzQCXN1d16wsIlId5YN49iXAO3NfwVxRk+2azVl?=
 =?us-ascii?Q?cjlT5euwFT5ooM++kI3cqqarxv04TLvpr6rl6G5YBamqkpV1FjMVXo4ZRpVo?=
 =?us-ascii?Q?BkME9sHh6s8p+My6PXg88ftIXZztYraZ56kH7ZDiSqISEqun0/BjPbYwfc0g?=
 =?us-ascii?Q?oGrU9icP5QTxPD9PweNLXC/jU2x94X8jlnmQ+LN2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d283150b-829e-4642-643a-08de01b98464
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 13:42:23.7177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jLx+FZe8r8mUW/TZN/mm86aHA5uu7VTkhFNq+bWT75zU160Gg1FLD0mYK5LK4klm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7168

On Thu, Oct 02, 2025 at 12:59:59PM +0000, Zhi Wang wrote:
> On 2.10.2025 14.58, Jason Gunthorpe wrote:
> > On Wed, Oct 01, 2025 at 09:13:33PM +0000, Zhi Wang wrote:
> > 
> >> Right, I also mentioned the same use cases of NIC/GPU in another reply
> >> to Danilo. But what I get is NVIDIA doesn't use bare metal VF to support
> >> linux container, 
> > 
> > I don't think it matter what "NVIDIA" does - this is the upstream
> > architecture it should be followed unless there is some significant
> > reason.
> 
> Hmm. Can you elaborate why?
> 
> From the device vendor's stance, they know what is the best approach
> to offer the better the user experience according to their device
> characteristic.

You can easially push the code to nova core not vfio and make it work
generically, some significant reason is needed beyond "the vendor
doesn't want to".

Jason

