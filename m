Return-Path: <linux-pci+bounces-37460-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B05BB4DFE
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 20:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AE093C380C
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 18:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393E8274B40;
	Thu,  2 Oct 2025 18:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sfdPL+0D"
X-Original-To: linux-pci@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010018.outbound.protection.outlook.com [52.101.193.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF74199BC;
	Thu,  2 Oct 2025 18:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759429887; cv=fail; b=B0kHuygDfk6jwKLep/Rv3vo+HlwPMk4Oy2R/S6l9qa7MOtMNuPTSQfimB6DxJBkXZ8fC/G2FTJHbw03nziZauyNemvoRkiFY/SuUX4VuM2o3JxZk+lPtOGqccPvM/PbTGeFHPdy/FLAA+sZ0+URlnQMZVbIxNl9Kn5X0jNBTHE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759429887; c=relaxed/simple;
	bh=X8T4ezzHgEvN7kuT0sQfKjPR+2ijuNbZLywcYzZt54c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=N8v17z+QC/9cQC7jKfS7KCWxtA3RSHFDAlwhrwu/RC0nLhp27eL2uG1H3Eq7TTC0kBmy0rOLrjG9o8I0AC5E7BM4XlQ35F7KJC50nFOL9CqofYljpr2KeCe9BucE347B9xDSqX0AIkYQ4Kn/im7C8NyY9f2qVPqRe1ZWjvCKPSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sfdPL+0D; arc=fail smtp.client-ip=52.101.193.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hUWX/BrW7pQFq5Ldk195oSh88Cxxow6DJmTVnM8ey8EeRoiw7tMcl9AUVW5/LdQZsWuaItiUnxerotMOkAEqKJziJR6VeJEEOjk71m4JHDVc/D950gbHH4ZvfOUhGOwyp7R7UlJMGGybpArxs9ZFt8zgcnTpPHlMbyY4Mw42EiNt5Yl3Vbckrx/dBFnTNYZhfK5RfQ8LDNuzbV1jWt0CS2+t2qnAgQHZPOJfJfB/E6qYncI1OvbqJz/0zppmTxI5nAGKGaQnFnxvLPDmQo6OKsI4zcd9RViW7/k9cPcbaDyNklIdOWttNi11jBCSb3ynlyXidtAqzAOf3bI5IPGSxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lwfRXPYbApZcfhfnHiuw97QXlT0W/FslXnqkSO98Ukg=;
 b=uyXHbei/oWV5J2NJKosJ/KJtTjKjNX5mWiFw2XBw3Gy8vluUL28stnTuDw/WIDdEHHNBH00U5ZykrZblAiuqPKp377ZXcs2Fl4MqvGKkJ3p85FmFTae775Jc/K2tt0zxGQfls7Dku0evtsXq+fNx/mAJb2kA2+6wdMwpf4nTY93/1M5hOk2A2Xx38vF1nhScBjQhPpoi/u1iQ83C/+dMBHVlQlC7zoEud6D4IREo0xEVUpTB9GEKAFCbtqKDHrxIdlnXaFhnvItOdRp6BkSeC1bia2NNSi82b9QLpH42z4zm4F57KhJ+rFRxQICdt8q9aq5RKHBGFnxSy6qMzDXVCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lwfRXPYbApZcfhfnHiuw97QXlT0W/FslXnqkSO98Ukg=;
 b=sfdPL+0DZRl7lemeRI+Ep3eakZhCBi7g+z1sBf3Jkt7Z3fl+f5ls8IagbmGvg+3UR8qgLooDzBoo6ZDndqPMUfJORjYJD0eqdqw+wA92ACFiD9/Z8VBBZF0kgAj1pJJamCRekhUsv1cNg59nRYRW/s23KMXqGJUS6bdGb+EUw5dMXB2y/sdEj8Apft7BSeETOxXb+RB0yhddD0/eSZb+k2J2Sz/8oAhzggRy5FoY8fXfq5x/qwZvt7D6S2+QBoifJLnqXRWFagThJxVenf2M+8yrzX+znwLQ3svLR6TUpe+qwXdpd6bHKqpMJzfICavb5xC736mjAAgW+W7Zan94uA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by CY8PR12MB7611.namprd12.prod.outlook.com (2603:10b6:930:9b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.19; Thu, 2 Oct
 2025 18:31:16 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9160.015; Thu, 2 Oct 2025
 18:31:16 +0000
Date: Thu, 2 Oct 2025 15:31:14 -0300
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
Message-ID: <20251002183114.GD3299207@nvidia.com>
References: <20251002135600.GB3266220@nvidia.com>
 <DD7XKV6T2PS7.35C66VPOP6B3C@kernel.org>
 <20251002152346.GA3298749@nvidia.com>
 <DD7YQK3PQIA1.15L4J6TTR9JFZ@kernel.org>
 <20251002170506.GA3299207@nvidia.com>
 <DD80P7SKMLI2.1FNMP21LJZFCI@kernel.org>
 <DD80R10HBCHR.1BZNEAAQI36LE@kernel.org>
 <af4b7ce4-eb13-4f8d-a208-3a527476d470@nvidia.com>
 <20251002180525.GC3299207@nvidia.com>
 <3ab338fb-3336-4294-bd21-abd26bc18392@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ab338fb-3336-4294-bd21-abd26bc18392@kernel.org>
X-ClientProxiedBy: BN0PR04CA0034.namprd04.prod.outlook.com
 (2603:10b6:408:e8::9) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|CY8PR12MB7611:EE_
X-MS-Office365-Filtering-Correlation-Id: bc20e23b-7109-4158-b9e9-08de01e1df67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dHxyIUy58J8Pj/eMuPsyxR2Q3dUaqecnIFj8vd3nbm6UvJ92s5SXSpmm89k5?=
 =?us-ascii?Q?9VfVY3efXyD3hRW96aE/yv1n6oT7v1EG6ga1uBjTYc5zyOkrbflUu78AFWPP?=
 =?us-ascii?Q?CxBywqUAUhE60PsUttxJqWeId1P14ICy8fYSBqL5FmNcyOTHLY9RJsBKIp1l?=
 =?us-ascii?Q?R9K6eodW74od2qmIyGY64zmMZwNf3VMPjqfIR+4p7V7a+VKt0zsourDfSibO?=
 =?us-ascii?Q?K1FRDD5Cl4xd7jwYUIPRpQRYFzmEPq/76yhBdmQheXe4rRHQhFwE+CWF2gQv?=
 =?us-ascii?Q?8t90o8HhiloQt8SvXAa7gdN4Oi6WymMvhtdd5m4yqDQnFKU7QBxxa1gxKk3a?=
 =?us-ascii?Q?pFn8zchSMXjVPmVKTHqJ0Eec+TT1c2rIMHZE0/b1cAnkUFRSN4/7e6pTByCd?=
 =?us-ascii?Q?pxYSLNr9EffKgLOp3toWbD3Lnu+5pV+LhuzQlSFqRCF5h5kfNBu55FKukbF4?=
 =?us-ascii?Q?4bFL3h9Dp6btdPnFJ21bA2NCs2E/NCAaY4TfqfT4nmfxhac5g/fywtcYEPAt?=
 =?us-ascii?Q?XsZD6xLg777j0zswVW0jilyxjxwuQLA/Yhdfxd+7qQhR0K7l+LJdCBHHQEf4?=
 =?us-ascii?Q?0jCI6OibwyZ70YRraXxxRtkMznXlnmqNY1zQq54tMqSBF8pV1x0N/WfZcuuV?=
 =?us-ascii?Q?JgrI6kgTl6anKVyBUfbrVkS0qfdDIgdzZchBuzJwtN8I9RCGdrTtF4+y7yJh?=
 =?us-ascii?Q?MeNLAd+t4tdURx3S40EohnxByC7rqWSQPNhnmKbu7drOYTq3Poqb7kjzUQaL?=
 =?us-ascii?Q?xfinX9TDfHegOUKgU014gnltunjflxaYYsJt3xfmF0wa4j+Ai0uWbsjT+fnQ?=
 =?us-ascii?Q?ASkJDqD7KAQreaGEQBOftFKK8wCQKcBI0UzfR7YNjt8CKycoZ77OjFFA8VZn?=
 =?us-ascii?Q?PokHkPDOAHwajfEbdsPpiSK44fhJ0fjrYY/hypJYeKaiEhcX5spVocIpE0KZ?=
 =?us-ascii?Q?nU1CX145z5dhhyhfS0MRBURFpwz7/xeZ2iv2yT2NH7lXKbWVPy6oUBfwjwen?=
 =?us-ascii?Q?nyQ5mu1CzLlg0hZfqXeqgeFX8Ccl5gjJ9P9Z8ASxifcaluAfayPFMVhlBDHG?=
 =?us-ascii?Q?IUzqdnwg+yEzuP1P/YYfGlxBZwhJjOrWWtEWcQMRgQ1b8LF/9SBJ3kTz0zBC?=
 =?us-ascii?Q?V5xhS6RFO0mD9DQbVczch2D6D0GnyqO+/7Ec3Yjs7M6UYyKNaDvVTzUy3Xrb?=
 =?us-ascii?Q?TwBSLNjj9EgTERrkcPuTj+UL1icmhuCWllb+v0HO5gO5RDkhK0wxCcA093mt?=
 =?us-ascii?Q?JZbCC3zsnJjYfWbgvTvdBCzdKl57V6qnhWYPSwJKqjfWoSWHI4zdkw2BS71/?=
 =?us-ascii?Q?ZWQJZa+MLRUyRydcZoUZIo+U3ZfcKDZ0rTEdDjhBbXG5LlG9PPdM4TO8tscE?=
 =?us-ascii?Q?8GqvI7h48FbxMcrf0eJcCZvAgXiQnTE+TpEQQ93d5xYBwI68WUZ3gAbEmIxl?=
 =?us-ascii?Q?Ay6Oil27+VX4pSIVkUR0OKFYn2YDigHY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?82BAwumX11uAJDMGaQnXMDVGs+N4qN84NgRelQvETHQ0FFEia3UBlCzpoXXm?=
 =?us-ascii?Q?dbsEZtjm8gAQkHW2e+ir1kUCJxIbH+8VDFcbrFQO6LJYcdtV5hLSlBh5VjiN?=
 =?us-ascii?Q?rAGff0Lc2IEI/B7yFzLgOUigkuab4KG1K1n+CGiVj7MnI0Fs8x5pTktols7c?=
 =?us-ascii?Q?gKqDydJqJCQAqT1kIJbgAXFvXrGA48MUgP6JCA5Dwbn1sv3p284woLOCuKGC?=
 =?us-ascii?Q?vXzSjWBGepO3YQNKnjACUn1PHh18WeGiorsPLeGTQBH0DxOpxG4/8V3o03xm?=
 =?us-ascii?Q?HahoPj9hiw9H1W0uhsmcG1xdCphMa/KcTFx2yo+GbUZQV/ZNUIwIm3pytnVT?=
 =?us-ascii?Q?5SFvZtpboQCBWB65qB5RHppoa51MVfOEudhtBlTx61raCDHAXgCPqzxMfILd?=
 =?us-ascii?Q?2RxKu7J98rEpj8gciNV60GJam8l7pcRVfFZL6jy5pQBUfmrQHurXdd5tF2bP?=
 =?us-ascii?Q?97SQx+1Gec+/q1ABE+r94iTx4ghD34vov9gVpP4nenv+Q1okXINXRVYk2Gh3?=
 =?us-ascii?Q?EJit08jDARedJW1D42Fx0tsDq54Np/eHFLwphB8w95ZZbmeuvJ6Rf9uiLtDI?=
 =?us-ascii?Q?gyoXvt89eXz82ZxzkC1UR2Hkftoi0CZfyT2szuXYStfjnYwUlcMD4c9i7evn?=
 =?us-ascii?Q?aVrqzuG/EJlty02ycTXwNXcPpv0Tm/CJ0Wi8pu/1GbcGTIhIJNhmq7dwmjBI?=
 =?us-ascii?Q?zcvvoZh6CzOeSQ9t7RtFvqWjk/ArHHyy0GovJjJ7Dlb7YLELU2fsD7x3WjKM?=
 =?us-ascii?Q?S2aaZVacah4U154Xi44B66JU8YqBP0+++H7OcqucD8Vf6cl2T425PQ3qIL4f?=
 =?us-ascii?Q?JPNYwh1dBNs4zmKdYl6SVa3F7Iy5lLDQxCAGFRouMRQMSj5ZyZUaCw7ZLwTD?=
 =?us-ascii?Q?+6gyc+nV8fZ5UIimpbrCtoZpS/1PfjzN6Wf41Sdz0feA/N7HI5TcUgaLoGCk?=
 =?us-ascii?Q?2WVaKkBVH9k2ds3hUeE57JHNzL0+0dYv4lFoHCO+1X+/yukkwybB8hAr9hc+?=
 =?us-ascii?Q?WR2lJf6/rgp3mmVDePQpnWirDYopshW1vdUN1iGnfTgkv6BSSb+d3cj4FxOA?=
 =?us-ascii?Q?T4ZEHgDptxNgh1D1Dn+DCNhyEnXD5kkYtSV67bGN0d3ZUL4fCpDNc0yLw9Xk?=
 =?us-ascii?Q?qrbeHtPDdxjlu94NZ7L/faaIptab/TCygMEVv5meBSlZAc5aUpgE3+vrcd8L?=
 =?us-ascii?Q?n33YORS4z2EzwYT9J6lKdvL8QzBIx8y3uHwxEd8ilwPz+dAZqXfxuhifGaWe?=
 =?us-ascii?Q?79vDXBHGuaVewUHQo/jHo8UFbc+zwW+uZNfPCOrkSmtlLYawHJ4M291IvFUN?=
 =?us-ascii?Q?fae/6A0mLTOfdZjZVwXhjiI7aLf2hD2idnUCvCRbbRaHLyivJVJWX6otTEkE?=
 =?us-ascii?Q?ZQ1PGzyA5XBhIi7Jddbrczcw23LE7Y2q9dr59MnjjREX7jyA05bm4yOoCLAI?=
 =?us-ascii?Q?qXSPjFu/UF9Wd8JzEBECpkcy8s9b7GzScpF7FHPAv/oQHW0wsHP7dAwDB8MS?=
 =?us-ascii?Q?w8ypq2+611BZheaV82J397qgAs338E79CcvMqceFBaBOhkcJ3eKCsGrVM74n?=
 =?us-ascii?Q?8/7+hdur4PUx+LSJRdM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc20e23b-7109-4158-b9e9-08de01e1df67
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 18:31:16.4504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BfKc9jd0VRRb+IdsNiZnY9SJu1VMZliP3FReJi0RQBkTuC7c1AdI3gk/FBF2OOeT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7611

On Thu, Oct 02, 2025 at 08:17:10PM +0200, Danilo Krummrich wrote:
> On 10/2/25 8:05 PM, Jason Gunthorpe wrote:
> > On Thu, Oct 02, 2025 at 10:49:21AM -0700, John Hubbard wrote:
> >>> Forgot to add: But I think Zhi explained that this is not necessary and can be
> >>> controlled by the VFIO driver, i.e. the PCI driver that binds to the VF itself.
> >>
> >> Yes, this is the direction that I originally (3 whole days ago, haha) had in mind,
> >> after talking with Zhi and a few others: nova-core handles PFs, and the VFIO driver
> >> handles the VFs, and use the "is virtual" logic to sort them out.
> > 
> > To be clear, no matter what the VFIO driver bound to the VF should not
> > become entangled with any aux devices.
> > 
> > The VFIO VF driver uses pci_iov_get_pf_drvdata() to reach into the PF
> > to request the PF's help. Eg for live migration or things of that
> > nature.
> 
> Ick! The VF driver should never mess with the PF driver's private data.

> Instead the PF driver should provide an API for the VF driver to get things done
> on behalf.

This exactly how this function is used.

The core PF driver provides an API:

struct mlx5_core_dev *mlx5_vf_get_core_dev(struct pci_dev *pdev)

Which takes in the VF as pdev and internally it invokes:

	mdev = pci_iov_get_pf_drvdata(pdev, &mlx5_core_driver);

Which asserts the PF is bound to the right driver, which asserts the
format of the drvdata is known, and now we have a proper handle to use
in the rest of API surface the VF driver will use.

By forcing the ops into the signature we strongly encourage people to
follow this design pattern and provide APIs, otherwise you have to
export the ops to call pci_iov_get_pf_drvdata()

There really isn't another good way to obtain the 'struct
mlx5_core_dev' from a simple VF pci_dev.

> It also has the implication that we need to guarantee that PF driver unbind will
> also unbind all VFs, but we need this guarantee anyways. 

This is another reason why pci_iov_get_pf_drvdata() exists.

/**
 * pci_iov_get_pf_drvdata - Return the drvdata of a PF
 * @dev: VF pci_dev
 * @pf_driver: Device driver required to own the PF
 *
 * This must be called from a context that ensures that a VF driver is attached.
 * The value returned is invalid once the VF driver completes its remove()
 * callback.
 *
 * Locking is achieved by the driver core. A VF driver cannot be probed until
 * pci_enable_sriov() is called and pci_disable_sriov() does not return until
 * all VF drivers have completed their remove().
 *
 * The PF driver must call pci_disable_sriov() before it begins to destroy the
 * drvdata.
 */

Meaning nova-core has to guarentee to call pci_disable_sriov() before
remove completes or before a failing probe returns as part of
implementing SRIOV support.

Userspace cannot create VFs until those calls are done.

Jason

