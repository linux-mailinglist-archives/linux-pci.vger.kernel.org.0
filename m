Return-Path: <linux-pci+bounces-28856-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22382ACC639
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 14:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5462F188D2BD
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 12:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC7422A1D5;
	Tue,  3 Jun 2025 12:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DfYvgpYK"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2073.outbound.protection.outlook.com [40.107.212.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADE622F763
	for <linux-pci@vger.kernel.org>; Tue,  3 Jun 2025 12:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748952903; cv=fail; b=XPumWwP3i6oJf6WOiubHXYUvVweB1AAp+cQnmgio1MLGQF2/jSxhhEnmPeXb61tvlMOepSxUHDls364LjiR/RRxJ5pBJt5Bs7yyFDyRXGAWakZnXuKvWATtH8neR7ynJsIS4QhRpQzNbNNsHzlZpjKPfYC1WQTTFlerLfR2Ve8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748952903; c=relaxed/simple;
	bh=MJX/liZEANmAHRzWlxP1q18moBB4Kx9R2SwAZ//E2dM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rw6AEy1ig0RfS4ySxUazzG7kXU/J3RQRaIJrIo0jdJkDwuDaj70JbMms2UyW75FU4YIyVpHINiOKP8SJtK24k4pNrLo3aQxVlX7nXfuvg5zBEH3nV+fxlN7PY2RXajzcRCD0NtMHwS+6/dBdEF4n/dTPZtzNw3jfoNPOH4l+ufU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DfYvgpYK; arc=fail smtp.client-ip=40.107.212.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NjK+n3hge0LhzGZm1KAJwHaAnRhVABvi6X2qz3zLU2gcGAQs8nvmVdZRsQDeIK8hc5L0e/1vIJNfU6jE9dizykjFBV6rrh0JLKA8hojnY2+Oi7H2fTy/lKoxCXB+4CdQEYFtoS4MeYyU9zpT+SUBGdWUXyxKLPl0LiAcEH5dKw3H6DjLap1sJCLgyBpBchmZlBqeSYr0QfGlo/2wHqI+zwvJgX9xel7nkHddTuMw11rzUAWvxah0f3Au1b0ME1B1yKtmr8lwB/yhklViu9NmyTJlQE+9bRwhynPOPyCn0iyF/SokBxCyXaq3gwoFvN6tApGRYNs90Jc+vj5S9FisZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJX/liZEANmAHRzWlxP1q18moBB4Kx9R2SwAZ//E2dM=;
 b=pu+v3P9ZffrJINhvTkR3P79oTsYwHoIV7OAJgojSi/Z8evsosqMz7TeZW42bmuHkSDzJ3AP0TmniqcJ+bgxbIDEtIhNBpeRCPnFPQZG6+SBDbuw8CfZJAwobhPGFlgNGvQsULpTSwKDs3hYDW7wjAeDBKGSxFPelDHWQUruoS0egq+Hfq5JoH/Gom+ssmTfZsSEa/fyM77bTDk0ieoRgmLZsGB5F80P3YvtV0EZeY8bsYjcIlN6Ez/bHsS/zog3nIEoxuj+PzCC4zJ5djYCvMlFU6hcGXsGeG+Oxbg6oFIN1QMdZ9WF3t0m0EMhyBETpfT3xPP/8HE373elwf1GwCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJX/liZEANmAHRzWlxP1q18moBB4Kx9R2SwAZ//E2dM=;
 b=DfYvgpYKbiz1SB9uQ3S5UJUfqgXM3gizIapPodT9n/6pz2rw0z1V26z9eLpdWDC0FlOMjYLdxnQzgzsP08W4G2YAFznp6D+Qz5CiuYNH7WdXx15Gl7eOJaFA3NzhHpv+qexXHA/em1S6ID3JCqUrtQ18rG0FakaSQYmGo/9RaoPwX8+4GIfWLkEZKcdlJC331ljWF+YMOkhGN81GYw8HTJ6BShXhgRgiOxaacmaax5/E6sZe/Xpj3ARYJphl0vv4blSf04+gw/TrjeMlDxfNdQAEPtk4KliwLRE7U+D6oA9jPZlnGkQ4V9wJXJhsdb6nHa5uPX42x9jh57jEh2Lafw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM4PR12MB5818.namprd12.prod.outlook.com (2603:10b6:8:62::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Tue, 3 Jun
 2025 12:14:58 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8792.034; Tue, 3 Jun 2025
 12:14:58 +0000
Date: Tue, 3 Jun 2025 09:14:56 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, suzuki.poulose@arm.com, sameo@rivosinc.com,
	zhiw@nvidia.com
Subject: Re: [RFC PATCH 3/3] iommufd/tsm: Add tsm_bind/unbind iommufd ioctls
Message-ID: <20250603121456.GF376789@nvidia.com>
References: <yq5a5xhj5yng.fsf@kernel.org>
 <20250529133757.462088-1-aneesh.kumar@kernel.org>
 <20250529133757.462088-3-aneesh.kumar@kernel.org>
 <aDsta4UX76GaExrO@yilunxu-OptiPlex-7050>
 <yq5azfeqjt9i.fsf@kernel.org>
 <aD3QcQxtjoYXrglM@yilunxu-OptiPlex-7050>
 <yq5ao6v5ju6p.fsf@kernel.org>
 <aD7TZRnFualizeXk@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aD7TZRnFualizeXk@yilunxu-OptiPlex-7050>
X-ClientProxiedBy: BN9PR03CA0710.namprd03.prod.outlook.com
 (2603:10b6:408:ef::25) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM4PR12MB5818:EE_
X-MS-Office365-Filtering-Correlation-Id: 86b50652-cca2-475a-6e8e-08dda29841b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B56zYuAWlYQupATYPFJtnHX9alKyDT0w4DIrawAXBtmwg+4h/q1w7fxDodpl?=
 =?us-ascii?Q?v21XqUMFvpXujPQrqrGEEd2fA4S4v2Rdrw8Qn/k1imfQbdJqm+B/yR9YcyAs?=
 =?us-ascii?Q?qgqx88mGCcirB8+7Xi6BbnkXDIzg6+2tL2lTCyq0S8l6SPypUFvi+OeI4FF0?=
 =?us-ascii?Q?c9C7QI2xz1wvETYgy/Ubr/v33+5/k0nU/PHdzZujYjkMa2ZOylFwWNDxFbUl?=
 =?us-ascii?Q?4suSiRfl/P+915vZK2Tt3yBSqsU0xj8W3yAmy21kbFAoV4+I7LokLshTQgGu?=
 =?us-ascii?Q?d1euvtaCWZby0QTdmipNgucb0a1lNXBRpLmN3Mk1Ao9hj3uNpIAE3ehRB1XA?=
 =?us-ascii?Q?OtoA4PzvggcMzAEDMU6ZALmBHKL2V3RazQqoIZFzKujplUy8DnvKESM1hkpW?=
 =?us-ascii?Q?4RXCRNt58lneH1UbEQCHroJGZcCBEVZbwHtQpuf+awbJodyzyIAE2I8b0FP2?=
 =?us-ascii?Q?RKTRQ71rCF2OZY71bLRxvxyOHvhDQj2RpxpQZrnwjVoAIRYXNrRzJc7BaVuA?=
 =?us-ascii?Q?8DwSxwoyxmPjecuu2PeZga2ytNu4ICPelpe4T0uUyg76Rr/ShdtfV8a0o8Wj?=
 =?us-ascii?Q?HW2XwCSqoglmL5Zo5tI2VmlUfOpQB2KbCTcn7qTWQb5HnoL055Wzc+95/Q7y?=
 =?us-ascii?Q?ebVEzumnIqjQvROcvBiH8IG+5DViWhY+aw4fsDm5TG80zNH5RjLDxt1fYcUu?=
 =?us-ascii?Q?F1BWn+sKI3rBoIUGZNlyulx1tcDqq+N71Ho8EIHa68WQjhtafigzdWLWXLoL?=
 =?us-ascii?Q?W/CuuDEHwf3b8VJTcf4WmmScFdI7pdVvsdSI2r6JesQFqpt73uG1qLdzMCQ+?=
 =?us-ascii?Q?/57CAnBzC+ziNu2YQLjePK4ZP3gLDqisyb6yDL3+qDjTovYJyjIL5fHWWNxP?=
 =?us-ascii?Q?Lsany2g5iQthYp+SHVseF981lYqLMosFt8M+kyKb9PT72CnqFL/CeHIzwULe?=
 =?us-ascii?Q?EubNtyh45JNKYHbLg7IukDasA071Puz5BAmPTRVuExHoWBtVkmU8hoVwoXRB?=
 =?us-ascii?Q?BXUoYA7InQ+3WJOOoM04okyGZMjXhiFiStOE+GqQ6RS1pE1dDs+3SgzGzyYv?=
 =?us-ascii?Q?9n6vfP/HeIHeVbzBz2CkgeuXw32zvdf6r7pyXp9DeZQ+cobkn3NCawOBCgSd?=
 =?us-ascii?Q?0n+6u099VHKGLs6HwrL53vqEQxa7C1UUT5JMeozc418LGGw1Poc8pt+4ab2I?=
 =?us-ascii?Q?YobwHjSM3ezYX9E/J+1FCAr65A1czHc3mBhZtvzfaGplwIKdm8StKP4b+idP?=
 =?us-ascii?Q?hHEkdlRMUy+H7C3FciDx48PKuvhyBW3YmTXnECKciIrbTn+Ga5pubiDJREE0?=
 =?us-ascii?Q?c1YgkG1K8cSuJGPtbBD4iyEJv0DNTnhvjQ/0mJxpH1Tknug8T5IkWk2WAOpE?=
 =?us-ascii?Q?SJh/8Iu08HEJbOrYf8jYau6ydVheiNqk5mnBBvOspl1MXkeDMz0sjSe9Hr4N?=
 =?us-ascii?Q?95erPGV95dY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2aVXuE5QHb6I9IB5fZjsV3pNaqvlXbEoriWw+EM0DdRiSHeaVuiH9NKcXDz6?=
 =?us-ascii?Q?+E6cflAtsbZlmTD43kS2UOri6BrE6JM5lPzdXXrEYmzk/c8WbYztqq5L4XLg?=
 =?us-ascii?Q?MBSRhcCJ84ThhcQvH+AvEgnPgtjOBrP/ovi0bH6ZllzDI9H4LE9aBml7aZch?=
 =?us-ascii?Q?bIqu4XjrXS1MTUNKi/z8wlJ/OYAKOIowLDcZmffVGalDQ555w6BPqHf3H+fr?=
 =?us-ascii?Q?ycaMrpOCOPnvDjlc+LZ7Uu2Lb+vIqpc0Q2XrhtXmVx94Xol3vkaWaedvIGQY?=
 =?us-ascii?Q?jNjZku1LY9b22g3LAPOez/YUQnFCIGASlf0ytmc6AvkrBDRuXvA4+8juPvxV?=
 =?us-ascii?Q?sWwvryV0Bool95zD0gnemFSM4yADv8WUBOTMmA+Z3mlasC9JU5b52n9WLQ8g?=
 =?us-ascii?Q?i9ALuwPB5NQ0MkVxxYfYyOccuFNPQmGNyhBG+biCXu7nz2W2abyQem3FWXUQ?=
 =?us-ascii?Q?GesxSOEiyBod5V1aTNQPNLKd1XthSJnufCF04QpSrK/CBJPLUBwrY+3Zc5m2?=
 =?us-ascii?Q?ecnrz1BZWub0nZEZppq5w73BUcr4y2J2QAb8DWIlo/iR+BmjsD3TMu5JbV8M?=
 =?us-ascii?Q?JlF7Yu3QQCOgVcwsm60u4X8HWmVYbovFPXgUnUzZ6S3phK0VN/RVGJk30JRE?=
 =?us-ascii?Q?fmr14xgvDmuBoYfubjbejjOXk58+/kIcxdjxF3zA5SkM3jNrwpdVrBHKN14R?=
 =?us-ascii?Q?pmlsmCAQcHY/ySFEKk0NFeFSqOyY4BWvPQ+pwMWsVe3eS9icPcPCpSN5JOdj?=
 =?us-ascii?Q?v5J4oruFFj37m3Tajyp+NnOfFDs/HGplj6vuL1w+5SG9VGv9Cs6eDyV78xpT?=
 =?us-ascii?Q?0LR7vbGJ6P7q+56UtTiu8VAG8ZPv9t1+aLxSGkKo07TSKlVWXK4C2gX64xts?=
 =?us-ascii?Q?sXYpPIFhvBn8on/QL6XZ6zpsOAQ3VzctX5BnVqGXGzaABOP6miQfFPN5Mt5z?=
 =?us-ascii?Q?Wm1NS8jT2i99is7WZp+MMWEZjQpc3hajRLBRsICMhAw4S1z46AO00YXwoh/n?=
 =?us-ascii?Q?Aw8jQGKDxilev0S6YZkFpgAYIPxQJ8+nT6TI+RQX87QsaBJ5hacQzlJQYxZ/?=
 =?us-ascii?Q?MJ2YHfzSRh4954q5R6qdfYyoCk939FWXyHxzOMWvR0Xv4g3KXmt6u6gtM+ci?=
 =?us-ascii?Q?rxQA0zun69TkaoCH5zFf+2DVTt1OVEs/5wS18ZbubV8ZoHEZ3xGB0Edbtx7c?=
 =?us-ascii?Q?6MnWCiLnwWBqTEAUzSvG1CK9gBbuPgaDA7HR+p5EfGQATduaLQ524aBZq8xe?=
 =?us-ascii?Q?OB9lJJnd4n+IeQvIPVihgTxF2S6T/AuP2T7FilAJAIJ+PqUCSBHh7sjjih0O?=
 =?us-ascii?Q?AOq8Bdz3F0mqRoa0L0JacVj17L/7PFt/9aGzVEAEFcmrSmt06ZmUfXgmVp6R?=
 =?us-ascii?Q?o1wVrw+NfL6wlb4M0MmdHUbGcfxQXXHF/yTlWnZe9zDp5/xBcTmXLOg++vRL?=
 =?us-ascii?Q?fbOBbXqoNaOoISzwfL/ljlAMZDuKNJdtzlGKawXG7u5GWyq6/aNWvh7B+vIk?=
 =?us-ascii?Q?5taLadqZl4j5QFCf8lyl9w0uaAjwO3QgO6iq7/UIYy3vmlhymXv57d75lb89?=
 =?us-ascii?Q?HMigEK7ViHN1K0JuEVpwe+s7GEGCDPIBCYVi2LWT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86b50652-cca2-475a-6e8e-08dda29841b7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 12:14:57.9338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: giZYCxM9cDuFvXEUeJIwTbYdNMflxrtzkTBTfrUF5jee8F4ZCGDBwytIDrhxjr7r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5818

On Tue, Jun 03, 2025 at 06:50:13PM +0800, Xu Yilun wrote:

> I see. But I'm not sure if it can be a better story than ioctl(VFIO_TSM_BIND).
> You want VFIO unaware of TSM bind, e.g. try to hide pci_request/release_region(),
> but make VFIO aware of TSM unbind, which seems odd ...

request_region does not need to be done dynamically. It should be done
once when the VFIO cdev is opened. If you need some new ioctl to put
VFIO in a CC compatible mode then it should do all this stuff once. It
doesn't need to be dynamic.

I think all you want is to trigger VFIO to invalidate its MMIOs when
bind/unbind happens.

Jason

