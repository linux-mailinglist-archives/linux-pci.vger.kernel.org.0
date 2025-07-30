Return-Path: <linux-pci+bounces-33146-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F00A3B156FF
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 03:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A0D05A044F
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 01:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8401531C1;
	Wed, 30 Jul 2025 01:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gLDd+tCV"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E05FC13D;
	Wed, 30 Jul 2025 01:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753839276; cv=fail; b=ULRIsFlQW1ZArSrrxHDUh8pJE+q9i0uCzbvTbjMDSlM35rCQR2ii6vWtQE66oclfccPmecshO7U4SxUbOnj2nu5cx1VDG1eblgU3Euv+HgEhIFhGsd/YUW/wi/rQT9UCkenYk6voyAQ5+3v4GVRUUsfWYBXeEQV/fB0OKxS7/gY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753839276; c=relaxed/simple;
	bh=r0xLVuvuHIDk6NpOeUZrcBufF8SN+0KqZU76YdY2uh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s2CJDRDEzL737XrMWAElGzD4k0sJ3YuqyHVZcmypy3+a0FX4n+iVGqSEy92rPX1IvxDfne9dVCxG6GjTDQiy/UER+VR3y/hgXt+HVN4dJtXOp7TCdjA36pR4xCfal8PrQ/Q1Z542rqAPFECo2nceLfpb+HoSEOZ6LTc8Db9Nw/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gLDd+tCV; arc=fail smtp.client-ip=40.107.243.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n1hpNIZyv+DVEm1hL/6MH7Moj6HhfNCuga/7sOpCL/lwcOJ8SfxAFGe1XFsQRUQ54DHAWLLuTPN3RYb5lX8wQ2hO8lgPjx1/9+TJ0gI6AEL9EUCqYIuCKCVAbioxJxnzqwptEUl7RhVIE9USlbBzhIXZwSEhvrM43hkycfFbrI4WGadhewUOZ62oojpvOZPQT84B4HZfY99PLyKc9CUwxtI31QKc8ZwNvP1MpkjV3p4n+t04LfqtBso/nBjrG3QQXfCdkJtQZTuqQfsOHXGs1aEDUsgzwqXZH9kMCwI6SfEFcjRauU0FjTE/+UKFrIUt29Yajw/sT6JUeqmgCOq7Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nxlf9garnQyXH1VL5bDcYPUnP3vPJUAi1kmgvoEEx+g=;
 b=JbdylwMcGNIF4ApmLx3rfRPidl+UpVJXaM9k3FA8RLhUIG/PwyjMF4mRZiTMyIY1yXKJaoh1ONbQE/px1wRQCaJNY3SC1nh7+SpK7m/WPN2QR1h0vhj8H+Q7+lojsTPNcNp59Dw0oiRUDSQCJ9H9J0zJEMvG0NuzdP0O5mpfmxFS0Aol0Dbkx843FMnOaY0mvssbK/1Iu3JUOWS3vWb1cGV6CizhVK0fF+5yy+nFG8UTQ4mDEQYeshHElZLEtyn00+1u76D9Ax9nUkw5ZsMVX7OLuSLazD76GxIbH7b8pp1Sx9OCQ7ivltuj6gYCelvOcpysvk19Macch5fqijIe9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nxlf9garnQyXH1VL5bDcYPUnP3vPJUAi1kmgvoEEx+g=;
 b=gLDd+tCVJSfZwUUekUAPCax1pI6HPgv7YytSRqf1BpMvVlrE6WADhZfYPmiq2kGxfoiigId4LkbXADjUthVS5q74BbWEkSyNuJfXyISXXPb7FC0ijh89isB+6n+yH8eFU6DBsTMEKPy8sbatAkCReDu/ueOpQkJGNvSWvMo0lpXNAcdUCkCTNVax/11JOnrV1f5foE6+OnbWJTzv9X/jzNUVg6ITNYftnTdURED6drGQWPeASORfEHwVRTWxii/DDgO2j45KE17yjAIEkMyx2arNEGFOhL2u9IUAtRQD2UOyUS9JDYo8c8q3Q3ChVRdFwMPBkbsHPJ7kvxHiYN/U6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SN7PR12MB8147.namprd12.prod.outlook.com (2603:10b6:806:32e::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.11; Wed, 30 Jul 2025 01:34:31 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%3]) with mapi id 15.20.8964.024; Wed, 30 Jul 2025
 01:34:31 +0000
From: Alistair Popple <apopple@nvidia.com>
To: rust-for-linux@vger.kernel.org
Cc: Alistair Popple <apopple@nvidia.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	John Hubbard <jhubbard@nvidia.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] rust: Add several miscellaneous PCI helpers
Date: Wed, 30 Jul 2025 11:34:17 +1000
Message-ID: <20250730013417.640593-2-apopple@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250730013417.640593-1-apopple@nvidia.com>
References: <20250730013417.640593-1-apopple@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SY5P300CA0099.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:248::10) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SN7PR12MB8147:EE_
X-MS-Office365-Filtering-Correlation-Id: 7da00a81-3e3d-4977-a15d-08ddcf093b21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R2lVb1hSK2tvOFBrV2o3S2xiNm5iRlFPdXdxOGxLSjBGd3FQTXYxamtNM2Fr?=
 =?utf-8?B?c05PZWkxU0srNHk2YzdiRW9LUVVuMkxNdyszd1dlZHE2M3RCKzFhVnZZOGhW?=
 =?utf-8?B?dG5tVkNwQktTV2tPUE5EMDZsaXgzdDZ0RHF0RVgwdEVhQkxUcGkyRzA0RUV0?=
 =?utf-8?B?Q1NVRGg1enZ3Z0xGR2p4TEVObzZVWmg2Q1VsRHIzeG83SkJ6Y0p0ZEV6VmlB?=
 =?utf-8?B?YnhUUTBueEF5Ync4VThMVHpsRm03TWpqSWxiYktiTzNOdFExOW1nRmltRzMw?=
 =?utf-8?B?VDcyMG92RWJkYmlNYmRKZ3lUSzE5MGVvOTdwang5WXkxMzYvYzAxbUtmSUZa?=
 =?utf-8?B?T3RWSEVueWtUUXo5ZW9aQ0JwUVBTQ1ZGdGRlS1pnVmpoVHhHdGVJS2psRmF5?=
 =?utf-8?B?QlhhelFKK3AwN1UzNTlPRUh3YmUxQ3hhYkR2ZTdkYm1Fa25uVnFHcjhuc3NE?=
 =?utf-8?B?cjFtVmdRMUFsSi9IeGtqVkowd2xTd3VrWlFTbHhtUW5MZUpRcVJQeVZQU0VB?=
 =?utf-8?B?MDRkMEdJeEpzM0hWZ1FZNzltS01yZWg4SmlYMEJxU2FnZ0tGTjR1WitKOVJn?=
 =?utf-8?B?THFFMEdkWmN3YVUwOXc1NGhNU0tGMWpJNjRTaC9Eem0zRXF2a1RiTURjdHVB?=
 =?utf-8?B?TkVGd3lwYldQMis3ZDNXM25NMi91T3lTOEtvdDBJcmNFY3c3b0UzeWhnZTJ6?=
 =?utf-8?B?azJZamMyMTZqSVFSRU1FVndOdG4zSEl5d1BVcVFkY2xmM3UzbXhzVXJwWnZY?=
 =?utf-8?B?YjRlZ05DNFNLYk96bTFCR3ZEMDRUUllzNXdDTUFPY0ZlWDQvMFgzaU40RCth?=
 =?utf-8?B?OUxJS0R0a3dYeXphQkQxUnJsN3p1VjdOZlRReVBuMWhjUjJyMFhQNFdvTEZQ?=
 =?utf-8?B?QTBmblRXNkNhU0xKc3hOZjZIM2Vxano4b3JYaFBtTFFmbjNPMkI2K2dyaG1l?=
 =?utf-8?B?ZUJ6dmI3ZHMxV0J2bDZUekh3anUrYmxkOWREYm1pNStndlMwRjgwYlFnUy81?=
 =?utf-8?B?aDdxV3FVWElyRUNEWDNTenNaTEFxZzhnM3RITkNNU0RDZ0lKZDBpc1ovWDM5?=
 =?utf-8?B?REcyRGdXMnRVV2xYV0VZTy9xMDVRdS9CMGFaYVllenA2c0xGeEcwcjdmTlJP?=
 =?utf-8?B?V0UxL2xYZ2w4VnRTeXVOeTlkUk9kMFhqQWdUYzExVnlubFlQYzNFTFZ2U3lh?=
 =?utf-8?B?YzhGeDFhSllMUTQzS05NaCtRdVFGL0FVVnoyMWkwSWhnZDcxaVdpWHM0Tjcy?=
 =?utf-8?B?Wkw4N0tsYTM3TFlxcE8rY3oxMHNRZ0FKUldCV3ZQOGVIUit3bHYyT0ZuUHl1?=
 =?utf-8?B?ZFlhSXNUVnBITWRGbU9qbFByODEwdFdvaWQva21uWWZrV0laWm15MkFhRVgw?=
 =?utf-8?B?dDM0Q0I1SjhkcnZaQlF3NnFKYkdrZTU0ZWVqSU1vY254S2xsSzJNa0x2ZThE?=
 =?utf-8?B?YmpKaUg0UXdDblN2eGJEVGd0ckNlT0JNTVAwOGRRaEpEV3ZZTDlyekVBUUR3?=
 =?utf-8?B?V2tuZjV0cDQ1RjBqa2Z3d2pzS1kwY1k4YStsZFVFQVRkTW9uTkhaekZQRUpp?=
 =?utf-8?B?L2tPcktOYjNTclEwVWFLbndzSDFxL3FvYjR3T1JrQ2c0TlJCVXZoSjFEeWJj?=
 =?utf-8?B?Y2dXU0EwR2JQWm12WjI4bDFJaXFaSDZDUFdkRGNvYlZFMFdRRmJTSXVGVFNK?=
 =?utf-8?B?QnNzczM3UWJHV1h3REhqREZHaE90cDJTUit3MnJkd1JwYmlFeDJVVEpGWFJm?=
 =?utf-8?B?TDhsazNKZENHa1JFLzk1a3pmMmdhMFVhUENZU043SFB3V0xhL1VLdjVZWkRa?=
 =?utf-8?B?NWRpSWVRUkF3bmh0RERWNHJGU1czUml2V0p2QytJQVRoVXV6RE1samVoUktB?=
 =?utf-8?B?WmpYbGxZd1F3djFRaERRSXJlalZ5Z3h3a0VoZVdQckUvMHQ0OG1DNHFNZ2tp?=
 =?utf-8?Q?HPIYsPP9SBg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SXlUZGxNUnh3WDQ5cksvaFJzOGlob3lDNk1TQ09RbktCNGZDejRqRGUzeVlU?=
 =?utf-8?B?b3pjcDhrUE5rYmV1QlpYaGp6bEZRM21YZk9yNGJLU09jY0Q1QjBMQWtwQk1a?=
 =?utf-8?B?V29mdVorRGdrNzA5KzlwYkNHQWtESGtvWjNyekhVQm9lMkRtZnJBWDV3L3hx?=
 =?utf-8?B?SjJwM3l5QUFxQVdIaWNoVVNZRG1XQjF0eDNwamFqbEZVMTV6TXNkMTAxQ2pk?=
 =?utf-8?B?bjlqemV0ZU9JSjFOS0FVRHJpZDkzV2R4aExqUVM5RmVjbjFlWi9sNE96OFdN?=
 =?utf-8?B?cDFOZzZydGJ6bWNmRk9zWldUekgrUURLd2lLQXhUQzNnVUFocFArTEdYQmRW?=
 =?utf-8?B?V2c1NWNWVWxFZXV1S0pXcVBUdFdwbHI2VTlnNnhxSVZtemFmZzNTVzlzRGRC?=
 =?utf-8?B?VTRvYzVtL3NGdlFaSDJjcDhiS0JuZG9NeWhmRFloVG5MK0ZkSElTdnkwRE9D?=
 =?utf-8?B?RWJ1OWhFemJJV2VvOHdjWWFEbVJvdTlOamplc1hsRVdiZVVMd1lleFY2dGtq?=
 =?utf-8?B?QU9wZHRyTlNiWmVqSVhuSWN3WUU1bkVtT1ErTGI4TjVKRmRsNDdOWEJSZnhs?=
 =?utf-8?B?ZUtOekhRbytZRmxnZWZoUHhpeWw0YlU1M1VqZ0FvV00vWlBrS1NPL0ZhUDQ1?=
 =?utf-8?B?VzJQMmZ5NnZ4bVB0b2pOajA2SG85WnZwUUhBRE41QVlhYW43RElJVUFzMlFJ?=
 =?utf-8?B?ZHdIZ250OEJKUEVpeFliYmx0NEhzY0c1NXNhcHYrY0M5am1NeFBxYm5XYjJF?=
 =?utf-8?B?VDYweE13UFhXVlAyenAwaHFjaExwOGh2S0w2ZnRGZXRTTmJEaVhXRkNnd05M?=
 =?utf-8?B?aWU0STJRQWhWcmFGclhxb1d4a0dNTVZ3cEdQMzdaYjdrNndsSlNIK1JyQURR?=
 =?utf-8?B?b25LamJKMGc3WjFxRGx2NUxHcEhZVlFHeDI5ZVcyYm0wUVRxeUwwa2lGTUk5?=
 =?utf-8?B?bkF5dlVvSUk5WUl0dnRZRCtqMWpyNzB4U0ZLc3pLd1FodHdNZnlza0p3STda?=
 =?utf-8?B?LzF2TW5ubnZzOU9JdElyV1lHSUdJb2JkdDdXRHlmUlg3K3ZoRFVZd21pUm9E?=
 =?utf-8?B?MWREL0RkeElwSjV2L3E4RVl3ZGg4bDJiQmtmUU4raERpQXhoYSt4amU2czhP?=
 =?utf-8?B?VFlRc2NzL1R5UHUrTnI0dFUrays3ZnZKK3ZEaXgzT0tuY2dES2ppdVVsNUh4?=
 =?utf-8?B?bFVWVmRqTlNqdERhNlNxWFlBbEZYNVdKbWw2UW5DcWxQV3IvcEU0TUVpYmcx?=
 =?utf-8?B?OWtmQ2hsQVM0SEVGOGdYemtSZXQxU29CektWY3NwU3NJeWl5aEJRM08yZTlJ?=
 =?utf-8?B?akJkc0lkbnRPY2EzdGgvbUt4NWhNTnkrVEhHbU9FVWYrMCtqcHk5VUFVK3Vp?=
 =?utf-8?B?cUtiZTh0YU1HUzdWOUhZWVVVUHZCcHNXVE1BK2pHRzRENmc5ZSsrVVJWc0lT?=
 =?utf-8?B?bzRONFA5VjRseDNuZHYyQ0d5a21sSWVEYkVkMWxBZVYzY3ZIVVdxRVVUQkox?=
 =?utf-8?B?VHVzNGdabHV1cXYrRnFJUzN4b2c2d29zdEZTUDVIS0RjcE4wQmhGZHdpYUxy?=
 =?utf-8?B?aXVwWFFydy8vSnA0aXozN2dTUFhQV0pid2pNditnUCtKdW10MnUyMjhYZUxt?=
 =?utf-8?B?WE9wWTk4Yjd6dU5BaEl3SkJhY3Y3bStmZDM2Mkg5NTNMRW1icUFaRTVDZ2hj?=
 =?utf-8?B?NmxLRk5oSkpSS2wwSjBKU2QrWmQwK1NlQ2IvaGdsMEtVWVFSWU1ndXhQZ3R4?=
 =?utf-8?B?a2JFOWk1NGgvUjZwTGE0ZG0xS2RyYnlJNFBxWnI1VUF5RmNYVmpjbDltUG1n?=
 =?utf-8?B?djFhVlI1cnMvWVA4T3JuekJoZXlqK0NZRG5UUXcxb3d6aEtHdG5PQzA0bXRx?=
 =?utf-8?B?c01EWk94cVpiRXhldm9idlFDbWtYeGl4bFBxUmZpdit2TVByQWtjcEQrZ296?=
 =?utf-8?B?V1VJMjRvVVp3WHhxOStIYlRmRTAyOFcrdkl1NVVRVXlIKzBlQVRLUGhUcnBH?=
 =?utf-8?B?dXhBbGRXQUFLRURFVjVuMUxRSklZMXBWWFRRQUZWbm5DMzZkZGtnSmJvcDAr?=
 =?utf-8?B?Njh5T2tvRlcrcVdEbFhaRmVKblRMd3Q0QW9UY2hPVWRCZThORkxuSU05QjZN?=
 =?utf-8?Q?ICqOJQvcyMzzDDIdSyhbRjar8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7da00a81-3e3d-4977-a15d-08ddcf093b21
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 01:34:31.3166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1MSGlcdG18x23dZFnaftphGhyN6fQL4ymXuFxAesZPpaAMb0IEw78ZJ7Z0Wwiawa9JXvINVYv+5cYhwc7gT/Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8147

Add bindings to obtain a PCI device's resource start address, bus/
device function, revision ID and subsystem device and vendor IDs.

These will be used by the nova-core GPU driver which is currently in
development.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Krzysztof Wilczyński <kwilczynski@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Gary Guo <gary@garyguo.net>
Cc: Björn Roy Baron <bjorn3_gh@protonmail.com>
Cc: Benno Lossin <lossin@kernel.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>
Cc: Trevor Gross <tmgross@umich.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Alistair Popple <apopple@nvidia.com>

---

Changes for v3:

 - Fixed capitalisation of SAFETY comments.
 - There was a long discussion about the SAFETY comments on v2 of the
   series[1]. I don't think anything actionable came of it so I haven't
   made any changes as a result of that discussion.

[1] - https://lore.kernel.org/rust-for-linux/20250710022415.923972-1-apopple@nvidia.com/
---
 rust/helpers/pci.c | 10 ++++++++++
 rust/kernel/pci.rs | 44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/rust/helpers/pci.c b/rust/helpers/pci.c
index cd0e6bf2cc4d9..59d15bd4bdb13 100644
--- a/rust/helpers/pci.c
+++ b/rust/helpers/pci.c
@@ -12,6 +12,16 @@ void *rust_helper_pci_get_drvdata(struct pci_dev *pdev)
 	return pci_get_drvdata(pdev);
 }
 
+u16 rust_helper_pci_dev_id(struct pci_dev *dev)
+{
+	return PCI_DEVID(dev->bus->number, dev->devfn);
+}
+
+resource_size_t rust_helper_pci_resource_start(struct pci_dev *pdev, int bar)
+{
+	return pci_resource_start(pdev, bar);
+}
+
 resource_size_t rust_helper_pci_resource_len(struct pci_dev *pdev, int bar)
 {
 	return pci_resource_len(pdev, bar);
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 7da1712398938..d47226a679f6c 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -386,6 +386,50 @@ pub fn device_id(&self) -> u16 {
         unsafe { (*self.as_raw()).device }
     }
 
+    /// Returns the PCI revision ID.
+    #[inline]
+    pub fn revision_id(&self) -> u8 {
+        // SAFETY: By its type invariant `self.as_raw` is always a valid pointer to a
+        // `struct pci_dev`.
+        unsafe { (*self.as_raw()).revision }
+    }
+
+    /// Returns the PCI bus device/function.
+    #[inline]
+    pub fn dev_id(&self) -> u16 {
+        // SAFETY: By its type invariant `self.as_raw` is always a valid pointer to a
+        // `struct pci_dev`.
+        unsafe { bindings::pci_dev_id(self.as_raw()) }
+    }
+
+    /// Returns the PCI subsystem vendor ID.
+    #[inline]
+    pub fn subsystem_vendor_id(&self) -> u16 {
+        // SAFETY: By its type invariant `self.as_raw` is always a valid pointer to a
+        // `struct pci_dev`.
+        unsafe { (*self.as_raw()).subsystem_vendor }
+    }
+
+    /// Returns the PCI subsystem device ID.
+    #[inline]
+    pub fn subsystem_device_id(&self) -> u16 {
+        // SAFETY: By its type invariant `self.as_raw` is always a valid pointer to a
+        // `struct pci_dev`.
+        unsafe { (*self.as_raw()).subsystem_device }
+    }
+
+    /// Returns the start of the given PCI bar resource.
+    pub fn resource_start(&self, bar: u32) -> Result<bindings::resource_size_t> {
+        if !Bar::index_is_valid(bar) {
+            return Err(EINVAL);
+        }
+
+        // SAFETY:
+        // - `bar` is a valid bar number, as guaranteed by the above call to `Bar::index_is_valid`,
+        // - by its type invariant `self.as_raw` is always a valid pointer to a `struct pci_dev`.
+        Ok(unsafe { bindings::pci_resource_start(self.as_raw(), bar.try_into()?) })
+    }
+
     /// Returns the size of the given PCI bar resource.
     pub fn resource_len(&self, bar: u32) -> Result<bindings::resource_size_t> {
         if !Bar::index_is_valid(bar) {
-- 
2.47.2


