Return-Path: <linux-pci+bounces-37434-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1250BB42BC
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 16:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ABD13C528C
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 14:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A50145355;
	Thu,  2 Oct 2025 14:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TL/pCP9k"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012004.outbound.protection.outlook.com [40.107.209.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E432D1936;
	Thu,  2 Oct 2025 14:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759415487; cv=fail; b=orXiLA+fy+3/Eho9Li0ekFIb0pk3pAWm+8JMPz0LSTqLlCgyalcMXOD5wHME4RT7je35r7opw86JjLKoKCl1scthgRVjnqXVvYOm9ixuUNP/Y95exIBOy7mtqjcfFTdTDgg3ZZYrlIAZ6akvFK4OfURe/4fRxORR9lxiZB+b2OI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759415487; c=relaxed/simple;
	bh=twavF4/fGwVxEFe26pB1KXro/sXS9+HzkRh+S91Zr50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O7URFucZjWjQ5iabe52OzneUnyWL2L7EAgWKzQspncFaQUsqiedkFzGiSp6HILC+HL8v3QsSCOGIWcGMfI1oPNkAIKF5LU3S4N8wwwwiqwAUVTsOMsxs/sjL/N9EP5+gjy5GqihY8Oou/nnezDO1y4I7jPFtt9vUl607Q7EiGhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TL/pCP9k; arc=fail smtp.client-ip=40.107.209.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R/ZnDmXRcCo6hcv8A8EPhDV/FRTBBalga2i07ZYGZLYiEefs163XL1cUXIlbIFmQowlEH0GJ6DoyoX4o480PNuort8AuAbjMCkFrIxrr0oWME+/oBLajpPGhZHLLg824+ke/2hX4J2nZ1srPSBeJ9K1vu1K+W3Jfv+rs8/0hH6hBedFZ4FtheznyxYESH6SCNvdUYxF0Pu+b1g5s/csiQWm6nO1wjS82KIL5v1HweuGIFTvZ4UsCj4WULkC21UTLt0S8sXSN1/uqAqZDgk7dD6gmwABn+uFaJakHaydbaZff6+Wfu8vz+GXDOodlQD0FXQgj5raGMgmGKoPjeUaMbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pTNTVl+NOIfDdZO9le8eN54h37UK/RJ0AazPZE/5yHA=;
 b=TO8Gbt7pl6c4e23AWdAIxsNFT0n4mnTy4LQNu/C/oyxjChG1JGk4HOceG2m7MFueuw9CruX70EpeQMhPVW8zN/IKnPfXrKm8NdzLzO5lyom/oBi+mnJfkey8432w8syJdsMNQH4+k4tUm39dGTux8e0QZP6kB+pYsJh/wWOXedzcD0AyxgVHHySIQS5VfsN70zXgkDu1/h8vkJL3xkXxxPV+kSG633EdJIhyjTgbTfucgllnbGYAJf7f9/LeUODS5tcRL4tKAND4aicvckXPIzKWsgPQYTJn5q2pslOnseaXLyydCS4NOVro2uGItwsP+RXW/j6ZQhqwDR9QWllm/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pTNTVl+NOIfDdZO9le8eN54h37UK/RJ0AazPZE/5yHA=;
 b=TL/pCP9k0tswmCe1PF8PCdosU/lOKSPfnN6Wd0CnTskHZHa4AhfkXkY9dWl0vUZioY1emPFQprtvpbnYDBMt8upg+lTEQsmpLd6Dqt2yYtyBrLTVlZvtUe6VAS90fdIeZjhH1kdcA5arOVbX7PYD94SSFk/bTJC1c2MJpWKYgDtVCBpyAoKwhhcPejDg/EEJ/kprXnBgJioguXiVSDYz0cD9pZN4K5jsrxCg5tC/kXRRbuL40DhXv0KjE9Wv4OH4GgpzYMtE7fHJEE0UWPjQfTh1Ze+ZbypfcZwRdvM6D2FDr9l/p5WGWM7YlG0VYswNGDYFLzlaftEdOvgToiy4QA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by IA1PR12MB8288.namprd12.prod.outlook.com (2603:10b6:208:3fe::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 14:31:19 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9160.015; Thu, 2 Oct 2025
 14:31:18 +0000
Date: Thu, 2 Oct 2025 11:31:16 -0300
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
Message-ID: <20251002143116.GA3268803@nvidia.com>
References: <fb5c2be5-b104-4314-a1f5-728317d0ca53@nvidia.com>
 <DD6LORTLMF02.6M7ZD36XOLJP@nvidia.com>
 <12076511-7113-4c53-83e8-92c5ea0eb125@nvidia.com>
 <5da095e6-040d-4531-91f9-cd3cf4f4c80d@nvidia.com>
 <20251001144814.GB3024065@nvidia.com>
 <c56bd720-d935-4b51-b507-d794df3f66f4@nvidia.com>
 <20251002115851.GB3195801@nvidia.com>
 <ea82af0d-663f-4038-b8c9-cf1eba5bc4df@nvidia.com>
 <20251002134221.GA3266220@nvidia.com>
 <0c94b94b-68a7-47e2-acde-0a2082ed36bf@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c94b94b-68a7-47e2-acde-0a2082ed36bf@nvidia.com>
X-ClientProxiedBy: DM6PR02CA0106.namprd02.prod.outlook.com
 (2603:10b6:5:1f4::47) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|IA1PR12MB8288:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ecc0317-e99f-4d5e-feb8-08de01c059e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YXa8+m9gv96ARaL9s8IwDre4YtmeN9fx0QU40cdRKFm3G6bLSpZjb3gIrty7?=
 =?us-ascii?Q?hIJrxrZBklVPm2RETCjLWygl2axxw7HvYMaB2W0rjJriCHLHTW1nPR1oO+s7?=
 =?us-ascii?Q?zid7j+Y88E0SByVhREGOhQPH3PqhNGWu03pwFh+lOg6zCv6kxqlQ4euK17VQ?=
 =?us-ascii?Q?jySVfA9V27DqROfwbsoA4MN9dW5hV8Bsnu13HG4AeqFxnZQ2nW6kQm3tC9cM?=
 =?us-ascii?Q?GEHC4kVxi9YDAyJOOUnSH6C09i/vtNT5l2FKiWQF2xFHh1yPY+VGOKIvhKQv?=
 =?us-ascii?Q?SQmU/w54EwPzZeW8vi2rNIdWWLgdEMKZMKF6shW3ho+Qp5AFcSAx3z8Bjgbu?=
 =?us-ascii?Q?v9kbDqIWOePpM1TJFWpE1y1Fi8snTOrCgkbvyNzm9xp6YSu/VS3rdILUtBq4?=
 =?us-ascii?Q?LHQ7FKqxSzB+1uvu2f3APTEG0Kzhd/TqUV7/GrA8GkKnJgB5hljELhwRDFmt?=
 =?us-ascii?Q?kXMlGcrZpsYmSAlFcSyxQhPP1oWMqroKuBHWsWysPtd8S6j5Fx+elEryldUN?=
 =?us-ascii?Q?ye4bvpEl+NzIxbAXozvzcDxVxuJTyOdHbi3ID4LCRazH2fWKLtlLTVaZ8ebd?=
 =?us-ascii?Q?mjq53CWUpL3a+lTGcP1OHmJMUkJ7B+n0FJPR/8DASiGOHw2xIfloC3Zrc9fa?=
 =?us-ascii?Q?IbfYibYsdATGYgzWlYL7IchBJ+YcUhLyBFWmD0pDymvv24VLIVIi2XEMm0tr?=
 =?us-ascii?Q?zXWLd4blQ9MRjQsHzdoIvRKkIYVpOqjWrzgjJ6ayqh0SQ+NiRX25gkkzVRFR?=
 =?us-ascii?Q?tJmZfUfg4U/3PLnsiwF26D1bXSBJe6jOgee0Dj98eqpV+x+tAwNhtMnDJLUZ?=
 =?us-ascii?Q?/1u1xTkAbVsJ+Z8+rusNFuKYiLLNtFn+NtYv858yuya8OtAP/oNMZTzxHo81?=
 =?us-ascii?Q?ukO5TIviWzT3oEE29OESFZZTH9LP+lor66iU4K0aWKKMoWO6yGxUU69RZ8h1?=
 =?us-ascii?Q?WGEPzF9siss2RaX1rLJ9JEDNQdBd0ijUrM/vVSxIP+ZKgDCCRkvOaK2V+9h5?=
 =?us-ascii?Q?a0rSoBJQwRcYcQaItlvMmR+EqJpXiG2/UIHTLydApU/+QcfHMxFyM4hRf0f2?=
 =?us-ascii?Q?h5qmheilJlk0hpBASlEcQ/x8zBbHzTGRLuWjVGrFqIFBpMbvGbr+5IaiFp84?=
 =?us-ascii?Q?aZ1EZ63fn3Rx9v3A+ndeJY1hrQ0xfzuPm2FQoc1brVwsHETNpruYAWCKCSvu?=
 =?us-ascii?Q?OxN6Iqmcicjpm4nhcMHZ9ZjkYcqJygAMILiPO5sbPl0EVsjEwDibBdZn9D3V?=
 =?us-ascii?Q?J08BVxdtIq6Lm8BYgDTPpEAGZRk51OvycdAoc/tSs4NY012ADE9+9kkD80tU?=
 =?us-ascii?Q?wsE8xf7VRYnHyJRk6BuwGmgRIdXor5CBR3+mQ1Wagcl7Spz3FKXwCZoIiAPi?=
 =?us-ascii?Q?vOQGFAuMxlUF+aTTLj4FeCBndCtlLnEqrIMVJklolQHTuZHkz5gYDgzcYqk6?=
 =?us-ascii?Q?va0ZARzIFteTIxuc0IXc98PeqrFwIdot?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hetiIfo+sYN4LdMpVnXNPzw9Uw4eM1Lsxx5NDjO5XcZ+3Bbn8d94tUOhpcw4?=
 =?us-ascii?Q?sENTFIqd7h0ixB+CXWwI2oErkZWFB3b8kel/UfJ7UcZYesMrYWYlHqpFtNaF?=
 =?us-ascii?Q?fUTl03PVsd9i6SErLwNxatsRfAhFZyln1VlHUvI7mHgkD1w77Z06oNhrI+0m?=
 =?us-ascii?Q?hlAtqWD5NDGM+nJBGhZhBg4epMpiPJVfciRB2Zkyxyil/2t0nKxYSPqw3Gz7?=
 =?us-ascii?Q?q8QqGvPFNgiEkJpb3DtReYf2wRjI5Nis9Rb3IqzEWkEBAkjb9+3qIG01EkKP?=
 =?us-ascii?Q?bl5S/bqI2S44icvcTxe8c4JMBCTAUn3it17YocLIPMmCyNXDJv1RnsAy9maF?=
 =?us-ascii?Q?SrElB8UzJq6gdWZ+1yN5tmLyF7tblpssAq3VtGLleoAitR20d2LMN02Og0N5?=
 =?us-ascii?Q?D9FR5nIF2U7Nklu9d3pIK+I8GHmSFeSrAjcNjwbqayI17dEtXzICHUC6aaST?=
 =?us-ascii?Q?jpIQQlHD7sIN0+7pC3wK/gb2M7h45/25hs06tPJpYeF5NkJ41PJCse4NXNsg?=
 =?us-ascii?Q?D8OylUokb4IzaOxN0a1oZGgB26RH0IkvVzXIhYLqo86ogPR6O7YR/5kxJM6j?=
 =?us-ascii?Q?6YKUezC/K5+r5ZkYrPYUntUF+t+OziQWhUpcLza+0jccrpJzgp6MTeo6AeTF?=
 =?us-ascii?Q?QHFLoRkHXlxyUWS9pSMQOXvwP/yQ7327yVxOsE7PkI8o26xzOzsX2AY0ft+8?=
 =?us-ascii?Q?il9uf5XMI7jBs+8Ed2hSZESk0I5NfumLoFqxXid3EiHQgj1yfxLx84zMgJlH?=
 =?us-ascii?Q?ywcYnED4bLRbIJoFBtOChSqIQ+l/Wc+SPNf68AXYxHnaY9HCijxrRNTvzdgr?=
 =?us-ascii?Q?b0b0cUqFL3vW7FyNBzHo4UttC/U203H6t+Dz0Z21dSVhhuswM0U5r88rhuEc?=
 =?us-ascii?Q?/ppfQKWcI4Nnq+vT4Fkc2cnhCToq0dxv1ja4cwg91OkatQ/6qdcte0lSeXnO?=
 =?us-ascii?Q?a2s08nUPnoGHLoDPpByQcifbLdL6vbgsTXtzW9B4FQaryJMIqmhCQHjAHDjj?=
 =?us-ascii?Q?cJquoQIpj5NOQmcz1WZ1LsqAowhrZAtO4QuD/0va63eA6WgWo4v9pqcH6Nbu?=
 =?us-ascii?Q?Snn37/5ORJJf9CtMLbbDc1rEEwX9tD3+Blvu9Wmxq6MgSbWt3csWwK6cuRiU?=
 =?us-ascii?Q?BrzHlPxDKLiC6/O1I1VHL4KJ5Nv5QCGJe1Z0n4XkEcskF2FmOE5VOtpA82hZ?=
 =?us-ascii?Q?WsujHbYwQF/xLHdW5acuPx6EM6IgL1Dox4/A1RWme58ReXAvT5JskLPFu5JX?=
 =?us-ascii?Q?FFUdvL8iAFHjn0X0jQCx/ljhSrEx7nOu5m6FuaPr9Y0vv344jyXruiuh5Of/?=
 =?us-ascii?Q?enu2G6D5afo2YpiIUToyHg7Mj1IXXP75AWJM9u5iIVB/TSBSkMHCW8nY7CmK?=
 =?us-ascii?Q?knC0umiIvxPxFmBaEyK3wlzKj93QIgtCGXXKTvDldpS36lVLpWf60Kw6c0Jc?=
 =?us-ascii?Q?YJubRb8EBsrll9wAUp7pS9Fv2dePhv2nWUsGCINK07U343rhUeviCZgx1guL?=
 =?us-ascii?Q?p+JG1wij+RJ75LyLeSjUBvwamKbx/VmCFoTE6do6wfQDXWkE1gXgqEP9fjhV?=
 =?us-ascii?Q?vFEp3vm4Bxi3OlbphsHf+LZukaWwbfALJc1OIz6Y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ecc0317-e99f-4d5e-feb8-08de01c059e2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 14:31:18.8754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i1xiWaYfVp6vFdhnGKPbRwbl89aCANDURXh3NvVegxgYPiiywmojXf05Qr/W/k39
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8288

On Thu, Oct 02, 2025 at 02:29:09PM +0000, Zhi Wang wrote:
> On 2.10.2025 16.42, Jason Gunthorpe wrote:
> > On Thu, Oct 02, 2025 at 12:59:59PM +0000, Zhi Wang wrote:
> >> On 2.10.2025 14.58, Jason Gunthorpe wrote:
> >>> On Wed, Oct 01, 2025 at 09:13:33PM +0000, Zhi Wang wrote:
> >>>
> >>>> Right, I also mentioned the same use cases of NIC/GPU in another reply
> >>>> to Danilo. But what I get is NVIDIA doesn't use bare metal VF to support
> >>>> linux container, 
> >>>
> >>> I don't think it matter what "NVIDIA" does - this is the upstream
> >>> architecture it should be followed unless there is some significant
> >>> reason.
> >>
> >> Hmm. Can you elaborate why?
> >>
> >> From the device vendor's stance, they know what is the best approach
> >> to offer the better the user experience according to their device
> >> characteristic.
> > 
> > You can easially push the code to nova core not vfio and make it work
> > generically, some significant reason is needed beyond "the vendor
> > doesn't want to".

You'd have to be more specific, I didn't see really any mediation
stuff in the vfio driver to explain why the VF in the VM would act so
differently that it "couldn't work"

Even if there is some small FW issue, it is better to still structure
things in the normal way and assume it will get fixed sometime later
than to forever close that door.

Jason

