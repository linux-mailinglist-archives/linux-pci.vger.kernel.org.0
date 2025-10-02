Return-Path: <linux-pci+bounces-37483-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1112CBB59FD
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 01:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE0243A1DF8
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 23:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294A62BEC53;
	Thu,  2 Oct 2025 23:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qBfWYK6g"
X-Original-To: linux-pci@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011054.outbound.protection.outlook.com [52.101.62.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CAB2BE658;
	Thu,  2 Oct 2025 23:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759448421; cv=fail; b=EPPx+ycpj97zDQeLZu30P2NUB+OvU+Psk+4KM+AZTrl9fyB4s9i+s8yd++ljoCjqRrIB/ZngheRqm2q/vLjCbNdXLqBUsRiQM3PcrtUrFmjYnLZayHiKgTvuSR5cKy1t3JieSaId4JxVDI/U8YMNzPWaF9Iu9/8e/keot6ytU8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759448421; c=relaxed/simple;
	bh=CeW84A12FFe57zRNYA6qftgr+HVe9S3Lfd50AnOMGqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kMDSm8CAwlSCNbtVd3nUVuBTIHAPTC1IzoVOIouQNzGB7oKaWHfvJygMNimbB3DdzU6cAbA/5x13WeZs1Dqvg5AUhetGcufkAEap9cofDWdYDcHZ382NjT0ImtCfkUNKTG4z0zjViCVVxEmXeoYngkhjhvea9gc9iEpowAeIYCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qBfWYK6g; arc=fail smtp.client-ip=52.101.62.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EKQLKlZb7gmxgShKpcMdRqir13ylBYJjagnLH51JZZtwwKSyvIGgncRRN4INQ0txjwhLWZ+C3SS3sl95G6ffdsDsyEJWl4RG/AUtM66mX16SZf+qoiBiUetagZX8Nv9PKMpUmZmhFxoN620mucUVO0Fe43H9ROPylNLEJ43+D6MV/NBnmNooht5sY3VKyDcsFc7sOB5kjJ0EoJbVS5/ZHIFj60WFDvN80l3SrBJkSA23qtOW4GvKXmtUDgn2VO+GhnsgOWBlY2iQUw88mRrQH54eBkyIeknA6anU2zlKcaStxy6jzPiy9/Hg2+mROsZRdYZ49OBjeFEK2DJqd3rWEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CeW84A12FFe57zRNYA6qftgr+HVe9S3Lfd50AnOMGqk=;
 b=QECNunHRDtWqq2qjZ0SJHvsDZLeyfSqfGwNLO7BgY38Wt3mhB9M0Mkxqapea3GRHhhV/zp6+Z+RmgX99oLVaChId5MkqMCrLsHuqADXbZwR1j+byy9EK18cj7dg/hZ1WCrkBqXg+xxRfUiAgVN9mqQLixgXfkJjL3m75aYJ4u5UsKpYYCZHzIjDHV3a7eKyVPhc0uwj7p1JHtbn3xHdHJeE3VR5/26sbybpIuOOghZtAZQgsYV8P6YssgJxyx36NY4DD5b7tW99C/2KlG0ZTVyTYDnligOzolkz2DhXWyeA/YMVh5KP5pnraXxNDYOe6o68TGqkSdtS86gm7jVhMBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CeW84A12FFe57zRNYA6qftgr+HVe9S3Lfd50AnOMGqk=;
 b=qBfWYK6gLVKeEejalIgWt7N7QkO8dYp09N3VI5JGVYGmeBHKCw+Yte7Qa6qjJ4RJzP7OGFeWQhEFfdlRIjq4w3AmOXBf6SCB3iDvWjYOBWDNbxy5ouc3hhQQA78Psi6yaz/cRjh8kFVv55KinJs7hS++tgpbf7hNcSH+EqJj/BOZPXg60FYe7+0031NLcGXEj1660jjfyLxGWf/vWSDLB5o+/w8uoQ5vBD0s9xX4muM1sAnEEHe9ZrqXcAb+v1mY9F2K0bY80roWBBMxzDK/U3Q+VaSmzPHsON697M1apJ2Wj68oXBjn4M4H0qLoiAyYnVB1/4SXa1jB2XBrzPqR1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by SJ1PR12MB6313.namprd12.prod.outlook.com (2603:10b6:a03:458::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 23:40:12 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9160.015; Thu, 2 Oct 2025
 23:40:12 +0000
Date: Thu, 2 Oct 2025 20:40:10 -0300
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
Message-ID: <20251002234010.GI3299207@nvidia.com>
References: <af4b7ce4-eb13-4f8d-a208-3a527476d470@nvidia.com>
 <20251002180525.GC3299207@nvidia.com>
 <3ab338fb-3336-4294-bd21-abd26bc18392@kernel.org>
 <20251002183114.GD3299207@nvidia.com>
 <56daf2fe-5554-4d52-94b3-feec4834c5be@kernel.org>
 <20251002185616.GG3299207@nvidia.com>
 <DD837Z9VQY0H.1NGRRI2ZRLG4F@kernel.org>
 <20251002210433.GH3299207@nvidia.com>
 <bba17237-2401-4e9b-912b-29d31af748e1@kernel.org>
 <DD85P4NV5B5Y.367RGWFHBR0RF@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DD85P4NV5B5Y.367RGWFHBR0RF@kernel.org>
X-ClientProxiedBy: BL1PR13CA0212.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::7) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|SJ1PR12MB6313:EE_
X-MS-Office365-Filtering-Correlation-Id: 070d147e-6b57-439b-d3c7-08de020d079e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VUqhrln5cDKJJMosPz0tEJWpd0AtJ0Tqks21LkckKZjXoBbidfbJbHfABrQY?=
 =?us-ascii?Q?NdPihrMuTBc7l9PWjxfhOZfRr0nvQya0J7TtFztOow5P13Q/7v116t9rMVeQ?=
 =?us-ascii?Q?AVsCQ0BBrP69xsNT1WzUHrHn33C9E5o5vWM+6S0dQlxT8RBMWEIpNL93CBae?=
 =?us-ascii?Q?hgBGTyhZPV28ozqUoORdNy2gSNdu6F7zQJiFt/1W4v8d1pQodyHNB+yNhixC?=
 =?us-ascii?Q?LZCbBZO+VcXqaWdzgrjC/06mufteGHTaczi4sRTes/B9+wJFn6x57/iUyZpy?=
 =?us-ascii?Q?h03lMniyDoN8/yoYOmT/e6Z7xH02VAkctSrwWRaP0igzVsY56cY8DJQynQYO?=
 =?us-ascii?Q?5E1dXeKalzUcuQjZ/g6GNmcA/KMcHojU+WO86uuni++qm9fZAGq85ZBcoGT8?=
 =?us-ascii?Q?+eA1N/tBWGtz7A2eq0BugvCHx8kvFh8yQLu1KczBznxP42sDL21fGuGuVh9U?=
 =?us-ascii?Q?4RzAAZboDkPpcWwkygVFFqvYUJbyFgiYPoBIElVcktGU4nSwFxsgBJBExMmn?=
 =?us-ascii?Q?QyR/PzBQ0Xql2t+wEIxUKvnxMhJeLSswypc+auaBs4C8yxajSKSmU2SIIwHC?=
 =?us-ascii?Q?oTRz6HqvvdCosDbpL8y87xqLh3JpMiMHC5pacoF/LQHjkH2a+fSTUPm+tas2?=
 =?us-ascii?Q?GxUNlRL//OWcIg7bGzlrJn/D6b3eADCyoXp6tpotMf6YK+2KI7C5lL1OA+S+?=
 =?us-ascii?Q?mzj1/Vz+K4M8lIDza709RqdtnDjliGJ95SGf60lyn6M7PmNAy29JysnsfV4K?=
 =?us-ascii?Q?auy0Q3Msai6KfTZpkp4xzA3rX7TqnBIPIVvznryj2yg7KHACdri3Ymihzlag?=
 =?us-ascii?Q?IUWPTyvvVXaSyh36ikKNmR2NTTMA34QPbrM+ulIG3PYt78pEBMeib5A1MhHd?=
 =?us-ascii?Q?ujxxrOkrwDIqFUcYYKjRn2fIS0x+rxMZA8NAX8ef5vY2Q+vWTjjc1+jSepsY?=
 =?us-ascii?Q?v0xGUEZfUXAJdFYwd2slY7C0WQ9q2Yn2VG14fggWGXFyk/h+Ez9dtZl/xyIA?=
 =?us-ascii?Q?xTVRHNWQQyA/8WEWF87bB/9UUE0UyvoBbAKkWKdQTaNqSaI0OTRQnqp9+VPv?=
 =?us-ascii?Q?ePr4bUOpwMvxFGtXPyW6CBfLrBNGi04gxuCWs5D73Y+yg9XAd4zIk/+Yo/ag?=
 =?us-ascii?Q?dLh1eIeGz6Uu0vrrjLoz34cEpVWS0i6Iy69yM3LJLBnQKq9nOIxvKTWzI03i?=
 =?us-ascii?Q?fkjgN8oeutgSTdAHZmhRhIjxsWCJla5GUKgLjOna2NyLrTKljuoCfSVqUxjd?=
 =?us-ascii?Q?5Hce1O46eoUWqC3p+J0Kc6nZt1r/ln1yt17Aj3inV3fNuMA3hnhIFAXN0Mci?=
 =?us-ascii?Q?GKiGuUykz9Ea8zFMG9uUJsG8q9sEOzPsK4vKd46P4L8XsrSlUxv1w1Pi3vA8?=
 =?us-ascii?Q?1Zpf6xX9NaEk6zvFuSGSfAMNPEI0FR3GxqgMZruHiE93XGrEEl20p5PfJDhP?=
 =?us-ascii?Q?s1vBLzbYdUbnDOCOTNvCSNsHNRUizkjx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l/KjK1DgsZxSd+ncTZuCPW5B3Mw/RDI0W1OVe+z8SPzFDV+rSvZm30zuG1R+?=
 =?us-ascii?Q?pPli5TV/6iFlPyajnK7Ru3hO+hVm+9zTMC+LRboc5IdAjTYhB3aC77PzsObA?=
 =?us-ascii?Q?l+/F9MT6IHUHjxqLbc+Y7+GrCSN61x/6DpAaraaSblp6MUn5fqh9ypW8dbF3?=
 =?us-ascii?Q?jewZPBi3QCWPD7+v1M15IcP+490yCJawrXzemiiCZpR2FOfaTYcYRk6Utrl5?=
 =?us-ascii?Q?qvf0hNn4e0+sh3LwQP4vL73FnsbjTgolEHiel3k+c1EZ5uwjkFIKV678456v?=
 =?us-ascii?Q?x0VfgtA0tZDAfsuEwRO4sXeSqu/apzgV8kw4DL45guk4CoN93Vp8zg3p/WoB?=
 =?us-ascii?Q?2pbdfYnHqd3IltPkUVyzZIdUckavu/5MhhKm0NuwqsVjdzEuzMf88OYqaXa7?=
 =?us-ascii?Q?6DK/6Fg442crYhWN4fgObq/bKMSL18Bz0mXsdLLjZHEqgWeX8GtgzRzyHqR6?=
 =?us-ascii?Q?rT3cLEBtOBbbFULZg0v3idNLK4kjgoMrS+O/PBAbWn6aQ3mJZLIOgliQAn3a?=
 =?us-ascii?Q?bmu955i2hjaZ//hl4dPFRvEFG7UIcv55bbQn9URaIvlg/qGgelkNuYbdbbGq?=
 =?us-ascii?Q?VRFXUj1boOHO0eI3mSZEJemFnHqvAyodEQ+yFj7tQ+xg0Hf3IUVjpzulLTmg?=
 =?us-ascii?Q?BC9KM9w+ybD3vkP406vKBj5AzB7k8xO05ilZDI+r5QvyC/hvPGqgEKx5RFwQ?=
 =?us-ascii?Q?RcocKY56WEL2yFfbJUjBZEiIeHqZ3/rTvDa+0d3C+CLe4fVatHEYZHqsaymt?=
 =?us-ascii?Q?afDDZsdDCVVvcS3GEbHpHqUhjLc797U34fHMDXbxYT0B//T4LPMI/JZfp0So?=
 =?us-ascii?Q?PtlIVhV2wpAn/nXv5sxPTdiB/X5F0tHS/nmOkoGj+4SS0/8JP4TlAkKtt6wa?=
 =?us-ascii?Q?rz2t91eGwU2S2FC1UkqJ9ipmW4sIrmbwPPyNjg0pD5MqVCK9wCJKlI1EmSJv?=
 =?us-ascii?Q?byOAp6HEnsvDcLiojpRTCaQv6IafppcD42lnkiK8DTMdA7bL1wYDm3gOvyom?=
 =?us-ascii?Q?mNZXIFCypZo57p3yRfFIza4XEMQHHwm/G3LnMY+Q/zKwLWLrhL82sP9Eqg9F?=
 =?us-ascii?Q?I8xkK1e7VIsdWoDdffvaPnwFbK0qnMI5P9earSTHc4gzit1pJUsSyvYn6exw?=
 =?us-ascii?Q?TyCqc/JPNUq8p9MRTXg0OhtWqgbBUsO6yBrlkt94WZI3ts+pdok1+j/qfm6X?=
 =?us-ascii?Q?9P5d7/0UbfGK39KMChlqOjCZnl3g1K5dDYuRh0dNndnc93cMzIw8HIUrqi8Q?=
 =?us-ascii?Q?S3On0dWTeB1j+q+Qu6B0QaAQGxF55SxBPXHNUjSg7O37/lhsu8wjPlnB9boJ?=
 =?us-ascii?Q?gZ8Ue2PovIxTo8ITx4lalKEnQAvLG0hrrqY+AopN+nvZogCAcpYeN7UWu2SG?=
 =?us-ascii?Q?w3yZhAgpId5GOtYjr9pVpzd+JLxb6TJLLr05ar/xamNZ/K1H2w/jOd4fWDEH?=
 =?us-ascii?Q?IdcY//Ed2ZEbvWB2WxRXSraompw5bRHi5Z7SC0mUDX3q+gDsQKq/5EGN76Kv?=
 =?us-ascii?Q?XdqMH2YIFblzL41sVFjNBPhLgnBoqI/a8sxNMGlrlxJ9R+L8W1TIURqDRDuJ?=
 =?us-ascii?Q?Oco81pSMBrzF+g4w32o=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 070d147e-6b57-439b-d3c7-08de020d079e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 23:40:12.0903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vYRvegDYbQNtH1pAaoa3TyphnnMxXC218tRiBBzXIL3wnT38emSp2KW/bQzqptwQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6313

On Thu, Oct 02, 2025 at 11:32:44PM +0200, Danilo Krummrich wrote:

> So, when we call pdev.physfn().drvdata_borrow::<NovaCore>() the checks are
> included already.

I'm not keen on hiding this reasoning inside an physfn() accessor like
this. ie one that returns a Device<Bound>. The reasoning for this is
tricky and special. We have enough cases where physfn won't be a bound
driver. I think it is big stretch just to declare that unconditionally
safe.

There is a reason pci_iov_get_pf_drvdata() has such a big comment..

So I'd rather see you follow the C design and have an explicit helper
function to convert a VF bound device to a PF bound device and check
the owner, basically split up pci_iov_get_pf_drvdata() into a part to
get the struct device and an inline to get the drvdata. Rust still has an
ops pointer it can pass in so it can be consistent with the C code
even if it does another check inside its drvdata_borrow.

This way we keep the reasoning and explanation in one place.

Jason

