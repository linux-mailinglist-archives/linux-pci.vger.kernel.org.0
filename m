Return-Path: <linux-pci+bounces-32740-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5FDB0DFBB
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 16:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21D0F1CC0B5A
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 14:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D4C2EA469;
	Tue, 22 Jul 2025 14:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ptXWn+w6"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCE6288C39;
	Tue, 22 Jul 2025 14:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753195933; cv=fail; b=tD6SqmJGOruCBtvPK0K9aoauv2LE8XDhQhSVJGAIxVF3REd82VeKqiMbec2GUlMrjgf+S2qz2jVdczUExk69RZ4BHrADseSK+kaq82GWLUPZWJe56tBBw3sgty21P28l7PVxI1viD8tHP9g3KVxjnPFjkUyHmMGn9sNryOn576I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753195933; c=relaxed/simple;
	bh=NQbIRcEdy/LV5H0ahahE1srXL79N20FhNReiToHWzrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lILgdvB6HEU7k8gS6Er1VUYCpCrmdXIYggKetGvydRPWqjmt9V9kRMyFoE5dzjvrut17rWodDvZmrNiA1qenpvOSXVrDWuILmKVYDav9Z8Hp+qzGmrSZImx63eWH7JERlaG/gUxDzS1GCl4lbWzFw0IlWsGMivwXxAk9ARfmk0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ptXWn+w6; arc=fail smtp.client-ip=40.107.244.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AGkaXiLsYz2q4tTnwlQlu7nrOVslBg6ouzC0+OtLL/7TxnNaQxGF6ofPTb0dRB77OMtcAAJv+vmkLiWckhCbmkyVwWtNUt5uqpezOLiXjoDjQkm5CtyDQwn6tK5ebhbHjs3W6H24Pk8FtJhX+xtzQWEWoCUPFeeZYjt880qEptblclyIH82m7zZWNvO1gyLlMKRov9Rutc7X7kYNjt3Uh9qZjupDIVMkqsEi5cymOVB/+2KUik96+lpniHgBWkWqwtoPOtMVq2QsZArIoE2y9ExfkrdjbOnL4ZVYk+EZU9cE/vq0JxIT31XIv6st2GqKBtvH+QMBuwg3whhorZenpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I1CIL+ArnKtwMHzKplnrsf4CY83tSc7aZ+ccwmzpXUc=;
 b=tbxdsN7QYrpKghGpcHmaqjK/34GkrqZ/dj8dsHWQs96xFypxcIw5RwC96lo4cRKhrEiZNTEwGwInqEYR35IPQmrDAwvCb/slx+9HHsJgHFaEwNnBKBpDs5q9TfouRAIdDjzLgoCBnim+YQAtPGOavklpsW7hFTDw0O9xGIBUZckhWszbd0izhk0/oAPD7MRlowd0bSc6soajex/mWTTazSXqbd6QayzsTex+Cl1h348M2oy1rLHtwT1jWJC+ZgQGjal2IyAeAhzDOknHIWkHKqfOk3uIrm6lYGqSuNgBIha8bDfJAl67B0E7w7KNGR0tIlrQwZNbly2lkrum5U8MdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1CIL+ArnKtwMHzKplnrsf4CY83tSc7aZ+ccwmzpXUc=;
 b=ptXWn+w6cAwYfJ2LnvsD6HELHLR4Ke8Wd2fiybA/LBKLEcxIVGUtgMbbNVGKY1tp0ROPAyGEkn4A+hbqzaH43t2uqisuPcYZPrl6lei/6onDAA7X6ekCVUtrzynr2ee20zjjmRhXrYWunG3auAMf7ah0QnDXNQd097aYzqHC8opgnqQwVEnWqgrmyqL0dUc7xXEHDmiSpH2VfLyMxQ68jBo/gLg8tRmVvIhzswbC3aOAM1BzFQq1dKvv/mrXKfU5lgcFyxfz2zx5Wmk1vocj0EY2zkFrn1aiwoESkgfkh/3B5HLZU7yrxrqjFIiHua3lPpx75t7tjmcIKIOnvXw38Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by DS0PR12MB8219.namprd12.prod.outlook.com (2603:10b6:8:de::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 14:52:09 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.8943.028; Tue, 22 Jul 2025
 14:52:08 +0000
Date: Tue, 22 Jul 2025 10:52:06 -0400
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Benno Lossin <lossin@kernel.org>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v7 0/6] rust: add support for request_irq
Message-ID: <20250722145206.GA1474658@joelnvbox>
References: <20250715-topics-tyr-request_irq2-v7-0-d469c0f37c07@collabora.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715-topics-tyr-request_irq2-v7-0-d469c0f37c07@collabora.com>
X-ClientProxiedBy: BL1PR13CA0291.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::26) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|DS0PR12MB8219:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c07c24b-41ee-4743-a801-08ddc92f553c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WL/8u8QxIlKndnIQUU9TCfUOP8qX6I7E12wu/CjyHG9aTq3632UYdVFNMK16?=
 =?us-ascii?Q?sp90GAqCc/6KjgeRHYXVpdL2+0QXbaVQRZS712vDRa1HcW/Yk9wnOvCmxv+S?=
 =?us-ascii?Q?wKSOP4DeVJm4QBYwnDayrhmNbRJCompKNNbiMTqsAabt8/7EvPY4t6g2t3uQ?=
 =?us-ascii?Q?oT+kAx1c0ztQanbp707iFNBjB0rIDIDHNKDcgn4IS1o75wtps4mgMYoK7acJ?=
 =?us-ascii?Q?79mXhzb/gIkXmRzT2TanIrsbjkxnGCOgWs0aDM6r9/HiI0q0tAguGxR5cUtt?=
 =?us-ascii?Q?14yLndG6sbeE3fBtuhL41UR6otT/H8UUj9AU1ZUUDaBNlHGmACEpmhoAaJm5?=
 =?us-ascii?Q?287PLmu7aUKj+3PnUxt+y00p9ia22dLGALd7+q11jhDFM4y1Z91clyl4ulHi?=
 =?us-ascii?Q?VGlZq9Moh+Xzyv6b0RmrZXWnmWMzi+Qf+1p6YVrqPqVF9uIn6ofKMgZ2GZOp?=
 =?us-ascii?Q?fcETmPmRY5xs+jcDCz/PKcf7MsCSGvqgFQGIg1+9wF4xNWlVoKRc5mr2kfLW?=
 =?us-ascii?Q?oqwLgjdMTX781Y6hVYtUGHhR/kJQR4K9AlWKGc0N9TGOX+Z34LECwWHrf24S?=
 =?us-ascii?Q?su5ApNdd4vRWRlVMh4CJi3BhIbZnZMu9U3J1O5LvFyHvvLSpmrWlqWoGIC/D?=
 =?us-ascii?Q?OgN+tpk2z+zplU84kncpPa8hL6ihG84WD5AtxLuHb7iXfD7oBVzi5GzSGNfz?=
 =?us-ascii?Q?0qJbb4OyQhVerrZjlXXRNWv7rldcg8Lxy2daYVOmuY9ooK8A9grTP+VMzSMl?=
 =?us-ascii?Q?jHvqUYvAejMh3KOU2qz+tdrWESSfb50Etsg1uwg0t9ywqJut1d5PBN50EHi8?=
 =?us-ascii?Q?bqCisJ/WrVaC/cfKQLlEBQGCa5kXYilgx1H6OFVtZMGiCp4d+HRmYMn0zho7?=
 =?us-ascii?Q?WN2UID69UbToGp+vFItHCAjLQXtJw+QWzFpldUE4Jn/zUnmsd0ilokc6Kv49?=
 =?us-ascii?Q?BkTeLML5tLDhRlh9CovBozjA6g7tihWOx48fXkCBIBO5L29jjTq+ZHjV6r3D?=
 =?us-ascii?Q?ObN0azZ7yBZvarnWYfKB83d0rFl7s/A+aJrlsuUtmwBuFQOHkwis5QSEPVJR?=
 =?us-ascii?Q?1+cM7MJeipAqkREUgVgM552nxo63rKDTHvt3hHMhKYWudQe8TEZxxuotZjj3?=
 =?us-ascii?Q?4AQ+9a6eLxvsZNjPuRiBxal3dFTXTGhPZ0wrF8w9zN85nItGbeAkgLybuQ4k?=
 =?us-ascii?Q?Z3fXziKy2gytaAO1W8krGMglZDxeAARafPgjO/jcnBHySFZRBP/fySS5HMG7?=
 =?us-ascii?Q?Z9WKbKMJL0SEP0f0f/1/CgyYfCHQxNPMijfg2sOxoCWAF/WwHBrPRlk/1RVF?=
 =?us-ascii?Q?qTee5yTBREpBxN2fhTfZicsjjyOz0I8XgLp+lf9rl07LvL3bFwNRHcmBr76+?=
 =?us-ascii?Q?qhHkIx4ZygTeyLPUbe6I6pTEWpaJAAQeJ15LkpA66V7naWkek3pcJ+zOacXw?=
 =?us-ascii?Q?Vki2ofeSyG4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BZrTf/JTuvYdCCnCLPUhY9Z+ggapBTHMIGT4ET1Rd7B8xIX7Xih+PidyiqqB?=
 =?us-ascii?Q?MnCY4YHoyhNT5VnN7fyflBcG7Swr/ySihe7Kk9i0+rAQArEhTVjFuv12YAS3?=
 =?us-ascii?Q?wx7b1csFrz/lD/7c4aw1AZJ8L9KEN3Do97FNisDzplsuVliX0gfzT/ZaV3u/?=
 =?us-ascii?Q?q8KZiHA6P2BkYPmBAkf5LPeACDdi2H77uEOlAS3p0HN5GqKp8z4n4NVgRrpC?=
 =?us-ascii?Q?Bj5lQ0RBifXMO8P5uY/XNO0VVMTPP+y9xuethVR5qsUbpEt/7iUQdDC8yEr6?=
 =?us-ascii?Q?VSNK91R176V7CTX4xugGKhqBwuzIQshBZgnonrXdN38LpK01261/IRqidJxi?=
 =?us-ascii?Q?zGCeUuLb+1kL1U52RQ3/lQ1HfK9XXJGgrY/I6bUmrxUKATvuQLaC9Jkw/40p?=
 =?us-ascii?Q?W8UaMR2+7DBmoYwPRM8Sh7Ux3jcdEDw83K7mKN4lj2bYlVAv/Hh1E2pD9TK8?=
 =?us-ascii?Q?/K1+Zj8wIWnpgifwsbR6lz/VGKZ1YbPOE8y/ZLyge1D0hG9IAuC0UCestaSj?=
 =?us-ascii?Q?pZY5zveq8/m3X7ISk2O7VOOHBhfKbifirQMHHn5vUJ97hm2A+OC5UsKc/y0a?=
 =?us-ascii?Q?w21E651fRggmG2Db+3antqoFk1iHuH+zxI6mwJicDoHz+PMq2F6we5I3RbRx?=
 =?us-ascii?Q?8Os54SRRmluC36SPxYsDhL+dV8FmhSSlbfAcBIa4uAscU6tE8/lxjY4XDAgL?=
 =?us-ascii?Q?aQsfxVjBT93chgOa9GfmohRM2ZUpzZLPO96k+zNsJkkmN9/owYGIjB9Zv/fO?=
 =?us-ascii?Q?76dXUIiSlhQBB/cu2nBnUt1zSyJfCQa7IhXcWMKmRyNy0zOzWGoxdTJdG7MK?=
 =?us-ascii?Q?5vJOBq7V3krNZC3twS+R4W1Gw74mnl8pcoBokew4+vmDQ3G7kmd/ND/hHzCK?=
 =?us-ascii?Q?ocrWMBFhPQ8znfCSADZjfuLTKZaqQEqJfxHMvmMH/s8wus9OEmiM7yLOnFj6?=
 =?us-ascii?Q?aHjmo4PaWeQjw5JtYO1YLrqZJbcfxjLTLz09OfuY2FVFzm+7L1HfbjeiajCw?=
 =?us-ascii?Q?C3Vc/iuv+lV9v7LykTbuaPUNG/yxsfHNi6ceiC+/qrSsAlDTODz1dVWhRecb?=
 =?us-ascii?Q?PRgiLgj2Vzj444vcfXfNJ+1qT0Rlyf9VewIFGk6GDNTWEYvxXprs9Av4o+PG?=
 =?us-ascii?Q?O9j+U50+A/50fL4Dq9SePIIaE/4F/+bkEOyWxJRhQhsup4WtQQZQkAhxjQvB?=
 =?us-ascii?Q?bDfF9CoS5BmcxEARULthfK5+K0dbxLZcW3dxPYuFqcdd/XYg9imPSFAemMfV?=
 =?us-ascii?Q?q/Bfoq6HW4GcS1URZWYSOo2adhZ4rT54Bjl5A7rPX+S6WTmos6TwCK0+e98n?=
 =?us-ascii?Q?bEs0bypdAdzCGDSDRP5DVfvIvyh0t/IipLF4y864Yey8e4jDQygkwCxIxCQY?=
 =?us-ascii?Q?QVkWaEOhLI0ylQ5aCposOOiAHTjPge6avg3+0GIkore1uT9K9h4bzO59ikqb?=
 =?us-ascii?Q?KdaKI+DGLc8jgDOEdghVRUlt26gMNnIWYlmUPp6Diu5GR9tu3bN87G0DAm0g?=
 =?us-ascii?Q?cNyXLe3vTZNf+hw+mpjQD3GZILG011sHxdd5AI2GPV2140fxdBMCw1mYBr29?=
 =?us-ascii?Q?DibnVKcQ70BL5TZlJ517jLPu9MmyGvXG2lyQNDha?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c07c24b-41ee-4743-a801-08ddc92f553c
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 14:52:08.8565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Otbs34XH3pSGPB9y513CXZzbEV1y1odeV3Zh6V/v6MKj5BQr7NoAflsJdPrhzpA2UIuManhvehoHuToGjLncSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8219

On Tue, Jul 15, 2025 at 12:16:37PM -0300, Daniel Almeida wrote:
> Changes in v7:

Hello, Daniel,

I tested this series on an Nvidia 3090 GPU running the Nova project and I am
able to register and receive interrupts (there are several WIP patches for
Nova that are needed but your series is a dependency). We are looking forward
to having these patches upstream, please feel free to add my tag to the
patches:

Tested-by: Joel Fernandes <joelagnelf@nvidia.com>

thanks,

 - Joel


> - Rebased on top of driver-core-next
> - Added Flags::new(), which is a const fn. This lets us use build_assert!()
>   to verify the casts (hopefully this is what you meant, Alice?)
> - Changed the Flags inner type to take c_ulong directly, to minimize casts
>   (Thanks, Alice)
> - Moved the flag constants into Impl Flags, instead of using a separate
>   module (Alice)
> - Reverted to using #[repr(u32)] in Threaded/IrqReturn (Thanks Alice,
>   Benno)
> - Fixed all instances where the full path was specified for types in the
>   prelude (Alice)
> - Removed 'static from the CStr used to perform the lookup in the platform
>   accessor (Alice)
> - Renamed the PCI accessors, as asked by Danilo
> - Added more docs to Flags, going into more detail on what they do and how
>   to use them (Miguel)
> - Fixed the indentation in some of the docs (Alice)
> - Added Alice's r-b as appropriate
> - Link to v6: https://lore.kernel.org/rust-for-linux/20250703-topics-tyr-request_irq-v6-0-74103bdc7c52@collabora.com/
> 
> Changes in v6:
> - Fixed some typos in the docs (thanks, Dirk!)
> - Reordered the arguments for the accessors in platform.rs (Danilo)
> - Renamed handle_on_thread() to handle_threaded() (Danilo)
> - Changed the documentation for Handler and ThreadedHandler to what
>   Danilo suggested
> - Link to v5: https://lore.kernel.org/r/20250627-topics-tyr-request_irq-v5-0-0545ee4dadf6@collabora.com
> 
> Changes in v5:
> 
> Thanks, Danilo {
>   - Removed extra scope in the examples.
>   - Renamed Registration::register() to Registration::new(),
>   - Switched to try_pin_init! in Registration::new() (thanks for the
>     code and the help, Boqun and Benno)
>   - Renamed the trait functions to handle() and handle_on_thread().
>   - Introduced IrqRequest with an unsafe pub(crate) constructor
>   - Made both register() and the accessors that return IrqRequest public
>     the idea is to allow both of these to work:
> 	// `irq` is an `irq::Registration`
> 	let irq = pdev.threaded_irq_by_name()?
>   and
> 	// `req` is an `IrqRequest`.
> 	let req = pdev.irq_by_name()?;
> 	// `irq` is an `irq::Registration`
> 	let irq = irq::ThreadedRegistration::new(req)?;
> 
>   - Added another name in the byname variants. There's now one for the
>     request part and the other one to register()
>   - Reworked the examples in request.rs
>   - Implemented the irq accessors in place for pci.rs
>   - Split the platform accessor macros into two
> }
> 
> - Added a rust helper for pci_irq_vectors if !CONFIG_PCI_MSI (thanks,
> Intel 0day bot)
> - Link to v4: https://lore.kernel.org/r/20250608-topics-tyr-request_irq-v4-0-81cb81fb8073@collabora.com
> 
> Changes in v4:
> 
> Thanks, Benno {
>   - Split series into more patches (see patches 1-4)
>   - Use cast() where possible
>   - Merge pub use statements.
>   - Add {Threaded}IrqReturn::into_inner() instead of #[repr(u32)]
>   - Used AtomicU32 instead of SpinLock to add interior mutability to the
>     handler's data. SpinLockIrq did not land yet.
>   - Mention that `&self` is !Unpin and was initialized using pin_init in
>     drop()
>   - Fix the docs slightly
> }
> 
> - Add {try_}synchronize_irq().
> - Use Devres for the irq registration (see RegistrationInner). This idea
>   was suggested by Danilo and Alice.
> - Added PCI accessors (as asked by Joel Fernandez)
> - Fix a major oversight: we were passing in a pointer to Registration
>   in register_{threaded}_irq() but casting it to Handler/ThreadedHandler in
>   the callbacks.
> - Make register() pub(crate) so drivers can only retrieve registrations
>   through device-specific accessors. This forbids drivers from trying to
>   register an invalid irq.
> - I think this will still go through a few rounds, so I'll defer the
>   patch to update MAINTAINERS for now.
> 
> - Link to v3: https://lore.kernel.org/r/20250514-topics-tyr-request_irq-v3-0-d6fcc2591a88@collabora.com
> 
> Changes in v3:
> - Rebased on driver-core-next
> - Added patch to get the irq numbers from a platform device (thanks,
>   Christian!)
> - Split flags into its own file.
> - Change iff to "if and only if"
> - Implement PartialEq and Eq for Flags
> - Fix some broken docs/markdown
> - Reexport most things so users can elide ::request from the path
> - Add a blanket implementation of ThreadedHandler and Handler for
>   Arc/Box<T: Handler> that just forwards the call to the T. This lets us
>   have Arc<Foo> and Box<Foo> as handlers if Foo: Handler.
> - Rework the examples a bit.
> - Remove "as _" casts in favor of "as u64" for flags. This is needed to
>   cast the individual flags into u64.
> - Use #[repr(u32)] for ThreadedIrqReturn and IrqReturn.
> - Wrapped commit messages to < 75 characters
> 
> - Link to v2: https://lore.kernel.org/r/20250122163932.46697-1-daniel.almeida@collabora.com
> 
> Changes in v2:
> - Added Co-developed-by tag to account for the work that Alice did in order to
> figure out how to do this without Opaque<T> (Thanks!)
> - Removed Opaque<T> in favor of plain T
> - Fixed the examples
> - Made sure that the invariants sections are the last entry in the docs
> - Switched to slot.cast() where applicable,
> - Mentioned in the safety comments that we require that T: Sync,
> - Removed ThreadedFnReturn in favor of IrqReturn,
> - Improved the commit message
> 
> Link to v1: https://lore.kernel.org/rust-for-linux/20241024-topic-panthor-rs-request_irq-v1-1-7cbc51c182ca@collabora.com/
> 
> ---
> Daniel Almeida (6):
>       rust: irq: add irq module
>       rust: irq: add flags module
>       rust: irq: add support for non-threaded IRQs and handlers
>       rust: irq: add support for threaded IRQs and handlers
>       rust: platform: add irq accessors
>       rust: pci: add irq accessors
> 
>  rust/bindings/bindings_helper.h |   1 +
>  rust/helpers/helpers.c          |   1 +
>  rust/helpers/irq.c              |   9 +
>  rust/helpers/pci.c              |   8 +
>  rust/kernel/irq.rs              |  22 ++
>  rust/kernel/irq/flags.rs        | 124 ++++++++++
>  rust/kernel/irq/request.rs      | 490 ++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs              |   1 +
>  rust/kernel/pci.rs              |  45 +++-
>  rust/kernel/platform.rs         | 146 +++++++++++-
>  10 files changed, 844 insertions(+), 3 deletions(-)
> ---
> base-commit: 3964d07dd821efe9680e90c51c86661a98e60a0f
> change-id: 20250712-topics-tyr-request_irq2-ae7ee9b85854
> 
> Best regards,
> -- 
> Daniel Almeida <daniel.almeida@collabora.com>
> 

