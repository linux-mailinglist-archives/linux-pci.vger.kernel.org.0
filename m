Return-Path: <linux-pci+bounces-37376-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 602D7BB2019
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 00:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E6E317CC67
	for <lists+linux-pci@lfdr.de>; Wed,  1 Oct 2025 22:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A769B285417;
	Wed,  1 Oct 2025 22:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CtJepROR"
X-Original-To: linux-pci@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011004.outbound.protection.outlook.com [52.101.52.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB10827F4C7;
	Wed,  1 Oct 2025 22:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759358351; cv=fail; b=uyKkFkX/wP8i2xWhsM+ku8rF+lx3ba4tHGzG05RGNdtSPKXSZArrJnDv+t/hJk9LRwYcRqM88JrluEwS9A5XXP6C2n7kvgMtJ64VkueBrKvx2JJq9+KNaJH21MqNHdiMr732xZJitdU0c3mxH7RiCHz10v/+SVNYad2def+vxd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759358351; c=relaxed/simple;
	bh=n6z7zCnBr2qVZZvConOJxqnCwgyuJX4Ui5zHZZyNpog=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZM29rAE3IdlqeUgJM6UfK7s9vDFIZw+TnoEzwLD4aaeYyftOXymv5PFTDmvdod/sUcgVf60K9wx4u/iqjLsXWpwqTTnNUPeDQ2zlBbtU4Ysc/si/j1HKsx+Ro5u4RdKPvhFadVMQUKAupULiLuT7UpcGItkFVu+KKVg9DAIxZ8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CtJepROR; arc=fail smtp.client-ip=52.101.52.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BVwFj/GY/WkeQtXHfYFueqFDqe3idA/17F9rYIJTZ2LFSveakhFmtt9ojz4A3D11dBZcrw1zmA0Rx/7Oq2QrQzSi0Q1n5/MKG/lPFS3Xz1OKC4mj2beWcz8zMl0rU6Ypkw7Xum+P1W1xqk74pVqceBQ6p+tMUJbENJWEh58jlYteObhsAOwyohQtL7peUR5ZaVcVLhlmIIbWHROV9bYVW9AIiyNkz4GzqFw4jg1u8CSZ3NQ9xVVU1ZyNto1wTTZkNH7BCi0g73/YusuTqClh9jlI1+iQbhVgdZWnXuu5vcD7AhvKNCDiin7faZ6j0yEAon1YaFqY1HbMuDQa5uPzyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gsd33f4qO9cKjfL+qeta0AzSQvTUZDWDG6OekblZdXU=;
 b=K0R4ZxIM2NyDOQCoqb+gkMl6nxKCzVEO6qdYIn7LpLO95VbNka5usSFSrF/1q/PwS0ZX2PkqWu6GkMleQqtVMnB7hJHl0rPoGC3iq1rq6+YUG9vMy3gobqnuuTRJL/G09+tJHA/DA4+6Q68omwJJxWSn+u3XoDfeblCxevKlDXP36MxbAuicees0k7VoD+zM4hwYQGYU4GZHsoVIgJ51lCjy2uW0653IhBAeKGU4YZ/pOuu93YEjGNtzGqLIeFIjmaEm2FY6RTOigGF0zlWjZypYC/b15JKWdxmShb8O0JzPX/6is77QCHN8dE9HMOA9XapVBFzOW4GWAKmx/ljBLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gsd33f4qO9cKjfL+qeta0AzSQvTUZDWDG6OekblZdXU=;
 b=CtJepRORqL3hUYyJhXZUvMvzjCEPHB5JRzxFR7GvcDr6q4exRISprjWbtp42COH3aXne/qaLmtJCqDT5k3xu6aeH/SMQWs7dJcu1ejFvnIN9VxiWupcU71xZG+o0oqgZd1yB5xm6Gf7avdr/FmVzdgTJL1rq8dF5R/TLbjua8CJU/VjrPQZVljs+Ti56o86JehYBN1q6xB8KyKzvY9acZcpn8EJsAtopv/QicV4J+Wtq0uL4NL3toGgK8IThgZJhcg52ritPse3zN3eiB5eCKAmyplVAOae3K18XIqnEQyvhWsW7htLWvrXE1m1wZJybg+LDwVgsBOkBBwVscQmmyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13)
 by DM4PR12MB8449.namprd12.prod.outlook.com (2603:10b6:8:17f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 22:39:05 +0000
Received: from BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4]) by BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4%4]) with mapi id 15.20.9160.017; Wed, 1 Oct 2025
 22:39:04 +0000
Message-ID: <ae48fad0-d40e-4142-87d0-8205abdf42d6@nvidia.com>
Date: Wed, 1 Oct 2025 15:38:59 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] rust: pci: expose is_virtfn() and reject VFs in
 nova-core
To: Zhi Wang <zhiw@nvidia.com>, Danilo Krummrich <dakr@kernel.org>,
 Alistair Popple <apopple@nvidia.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Surath Mitra <smitra@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20250930220759.288528-1-jhubbard@nvidia.com>
 <h6jdcfhhf3wuiwwj3bmqp5ohvy7il6sfyp6iufovdswgoz7vul@gjindki2pyeh>
 <e77bbcda-35a3-4ec6-ac24-316ab34a201a@nvidia.com>
 <DD6X0PXA0VAO.101O3FEAHJUH9@kernel.org>
 <f145fd29-e039-4621-b499-17ab55572ea4@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <f145fd29-e039-4621-b499-17ab55572ea4@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0056.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::31) To BY5PR12MB4116.namprd12.prod.outlook.com
 (2603:10b6:a03:210::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4116:EE_|DM4PR12MB8449:EE_
X-MS-Office365-Filtering-Correlation-Id: 9825af4a-5c5c-48ca-44df-08de013b5361
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aGR3OWhVeWlUYy9KbmtSVlFocUdWanFvcitYQ0RWYStUUFhYdkhuclg2MFZJ?=
 =?utf-8?B?enh6ekpvVEVILzMzMVZQS3ZGQlVybDdjTXd3czQ5UEpqbXF3VkZ1N3AzMEZr?=
 =?utf-8?B?UnVObm1xVnFnZTdJUEJxcVlLMmMrblJBdVE5bFh5STBreWdSRWRLT21EekMx?=
 =?utf-8?B?blMvOUswRkxWd0EvbmFLaHNzRWZTL0pYcmppTzIrMUhlVVREK2ZRbkNQRm15?=
 =?utf-8?B?RytJdXB4WlNFR0ZIMS9BcXVqM05UTDN3ZWVSRUlidkpESUI5eWJYdDJmanpi?=
 =?utf-8?B?TGxZYWZ4bUlKbG9MbFlWcmI0MTVxNVplaExyZGw1Nk83VzQ1OWRBcFR0eTgx?=
 =?utf-8?B?NlZJNzB1SThDV1Y0L2FQSzJtRDg4NklCYnlnWW9PSnY5N2lNK3lxNEJXNXVS?=
 =?utf-8?B?TURHdG1WTVBBWG9jQU5lYWdHM0JXRUYyNmZ1YllsR1ZyZkhuWFVrc0EyNW5w?=
 =?utf-8?B?MnpYbEFkRWY2WnhoSDliRUJtUDJIRnpGWFNScE9uRVM2Y0VTRzZLaVBoUktE?=
 =?utf-8?B?TkNlOXVtUVRoN3hac1N1cUxFT3RXU3QydmZpOSt4Q2NTYUxRZnpzekdMb25N?=
 =?utf-8?B?QjRCaUlKZ0RJODhIZXMvZ0NzaTRZOWRyVmsrb3dZcG95cUxwam42VDIybFV4?=
 =?utf-8?B?QjVVYXRTTXZIVHBzWHorUGNHNVVVZnZEY1ZpODR5S3FLcWszL3B1NFZ3QVJo?=
 =?utf-8?B?WlgxbXY2MlE5R2k1eDl3eEM3aUJnQ28ydEJSRjZsN0dsRHN3YVRDUmZWQXIv?=
 =?utf-8?B?WVUzdmkweW1RaVl3eVNwRjhpVklGbEJhcnVXanp2OS95ZlZWaGNsN2R5SG03?=
 =?utf-8?B?TlRTQlFaSjRwWE16OWFiSG5zVkpteFAzeXZ6djRyWUhvQVllUjBGZ3l6cTNi?=
 =?utf-8?B?T3RDVG1sY0NaUkRtcDJYcHROT3ltMFZIeVQ1T1UrWFNxNGV1ZEFLM0FKYXM5?=
 =?utf-8?B?OHhnUkVIUWtXMXJnandaSUpMTHYyRElsakl0Q0NUUG9XWk9VSmd5bTVMWTlP?=
 =?utf-8?B?OUZNREZVeVNNaVNwcDBmdFQ5dGtaTWJkaXZ0UHVLc0tuRDhIUFZkVy9IeWVx?=
 =?utf-8?B?aEZUUTgwNStZVzU1S0Y5YUd3NUpsS3BJZVd1YnZLZG8yQ3BhTUdjVllNZHZG?=
 =?utf-8?B?TGw1UEl5ZzJSdFVtc3lBbUJrbzFnM1FmYWRzV2pZNWE3V1BpK0FNdmNzaXdr?=
 =?utf-8?B?dlNCQThST0hSWDFVNnVEcmhVbXFDYlo3bmdUcFRpeEhma3VxT0lQMVBKTVN2?=
 =?utf-8?B?bXJPcFJnRU9mN3hyQ0JPREs2QmRBUDIyKzVnSGx0dXZiT3ljKzkxVWppdGRV?=
 =?utf-8?B?RXdBY1pRSEVRUlVqUHhrYkhIRVZPdlAySm1KalBwWVJiSnhZZzhqTkJ6cFJh?=
 =?utf-8?B?cDVEUTBiK3NieklkVE1RNkY1cmdRU3VQMGJpaVp0SFMvSkM2UE13WnM5bkp4?=
 =?utf-8?B?cDA1OGxzLzExL2h3L211UWpQci9zdmJVT3NwRmp6Qkdxdm40bWxkRXAvcnlx?=
 =?utf-8?B?K1lPdCtlb0lUb2taelU4LzRzRHg3QmpYZWtuM0dYekxCQklyOU41RE9xL0Q5?=
 =?utf-8?B?Nms3c2VyS25pWXhybW1RR0hQSUt0M0JISWxWRGhKampxdlNQaFZFUTNMYWFE?=
 =?utf-8?B?TGV3MHFFcHVkNGdKRlMwT2lFNHdPd3p1ekNkTWtyZHdUc080eU8yQjBBWGdP?=
 =?utf-8?B?Ti83dFBjL0Q3S0FpdjJuRkF6dmsxZU5pYnIxUTZjUkZNbld5UGtudFZVV1lS?=
 =?utf-8?B?R2FHQWluTGM1RTgzamhlRnpUWWFXMXBNTUxQZVRvKzIzYmc5cERZYWxrRWRw?=
 =?utf-8?B?dTJjall4M25XMnpHUVRFYWx1T3VGT1pUSHc3NGZhaExkcGpqMmFObmRoR28v?=
 =?utf-8?B?aExEN2ZQeGd6czVXSWFQNjhTQlMyaXg0MUt1RGNmQkErdlduZVJFR3RWZVhV?=
 =?utf-8?Q?3H8W9Dv83zusQiGuJrY2yP3ENWTOsy8b?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cWlzckFqc2RQenJLMUVnSG5CeEt4cW0vamc5VkdlSGZvN3lDRzljcGpSTGVJ?=
 =?utf-8?B?VUhLV3pHZWcyYkhDbndqcXhEMC9pWGoyRnhwczMvWUdvUUhTVXgzcGtNa09R?=
 =?utf-8?B?SXRvS1ExTDNqemZ3bktrYS94cGNWbjY1WlYrUmFHSytuNjE4WlN2Ry9ocmcz?=
 =?utf-8?B?ZXRsYXBsbC9HWm1qclJtdEF2WW5xSEdXdWltVXQxaFlrbURYZ3NQcTNwWFVC?=
 =?utf-8?B?VzVtVjhvVUlVaGtVNUJDWng0UnpRYTJ6UmtqVFI5L3hGMmRjVUtXVzdpRndG?=
 =?utf-8?B?QmlwZ2hxYXpXUE9icnRvZEN0V0JtcHIzdW41TjNLaWMydXlGMWF6ZDV4Ulln?=
 =?utf-8?B?RUQrWWJDMmRQSFFOcmFESFpaSzVmWW80SzByMkt3ZXlSRmR6R0VKM0NSSW1Z?=
 =?utf-8?B?djRXNEkvWDZmR3lhQjJuQlJYWjNETkVxbHFuT3g5Y082NHplRURhVVRaZXVD?=
 =?utf-8?B?a21zSnRvTCtEWCt6NWtVTjFiTTdMT3VvQWFJaU5abDdVSVFLdENNU0ZBY00w?=
 =?utf-8?B?Ky81TXdlTW5uUE5zSTAzdU9HZFVqcEhGQVVNWk5CQXl6WFZOemVJS3JJS1JO?=
 =?utf-8?B?TWFOUktuMXorVml5UGg2L0REdGdEWi8yQzcxbDg3RjFIV1BURWVDZTZHY25k?=
 =?utf-8?B?b2N5a0sxMnZ4d1lJenhlTnBuN3ZMLzlDZy9rUXZXdS8raHZFQmtFN242cHkw?=
 =?utf-8?B?UEttcllGUmoxbS9xdWl6Z1hQeldSaHA4NDBoa3BZTjdnUUNaUi9iS2hkSmt4?=
 =?utf-8?B?aWxpSkZ6NDI3eFZhZWVEbm95dGJJcVhOTzMzT0laZWpCQndNNWs0M0JRcE5q?=
 =?utf-8?B?SmZsbEt2d2RjL3lzOWNNSkorWmZoREc4czhRa1FvYXVmc1dnZWJxRzlZY0Z1?=
 =?utf-8?B?THN3VnJYSDFYUmMrNkpoTldkMmRMMkVGKzlSN2JyUXFlQVBWeG5OL3MzdkNW?=
 =?utf-8?B?N0gwOVFIcXNYcTV0R1dVcitZOFppK0dmM1dzeGRRSFVRUjJNYldXY1lwSlhB?=
 =?utf-8?B?bXpvOHFSUTAwK0JIM09oUnR3Mm5zbmxWWXYxYU5ZR2dEWlpqZGQyU2d6Wlly?=
 =?utf-8?B?MDFwVmlYVjlFV2o3WU9oTzRQMFAxdEVNclNXcXJDRHJtUW5lOVVDL3hkM3ZK?=
 =?utf-8?B?dTZnak4rdXVjOWFQMmJubnNWaVhaS0RXODZnc0loSjB6R0I4UnU1WjJyTmxE?=
 =?utf-8?B?TU1JZVFmS1ZUOFVJeTRzaUY3TmtYQzIzTGRkRUo5ZWNuSnhuOTdYWmZESlI3?=
 =?utf-8?B?K0NlR3VxRzNrc2p3M0dOVWtKZlBnL3BXbU1tOWxTTzgyc1lBaFlaZ3RUL3pX?=
 =?utf-8?B?REVsWVFBZmpUSXJOVUdpSWNnUzNyUzFaZTBVZlc5bUdyREFsL2ZyVmJ6T0Zl?=
 =?utf-8?B?R3h5S296c05Cd1FWQ2VlQ1BvMFQxREtqQ0YzTEx5ejRCR3Z0bUV3amFLdC94?=
 =?utf-8?B?K09KZ29ucDBMc2FRb09OQldLMW5OMkRBVE5WR1h6M3lQNWhBQnBsUHFYdUZP?=
 =?utf-8?B?VXVHY1Y3cENoOENrT3dVSXpiRWZkR25EUmdyY0g1dTRITTR0Vmc3UlZXbWNu?=
 =?utf-8?B?ZGZZOFFjVFZsZGhtaTc2YzZkZzJhZW41WTNIK3pVTktNYWl0d2VweHF6TFhN?=
 =?utf-8?B?aWNHb1pteUFhT0JwSy9QR1JocE5BMTdPVHJPWUovRytWUUJENDFCcFArSDVF?=
 =?utf-8?B?T2srRW80ODE2RzNGS2ZENzJ0Q1lvTVJRNmQxb0JSbTV6UW9maWlELytRN3dH?=
 =?utf-8?B?bS9wYVc3amo0cVo1OVRKbkR2dXJ3Z3d3K04xRGhOQXFwT1BHNXpYdkJxLzdk?=
 =?utf-8?B?TE5IejQrNXhHSHhGWCtaNzRRalpzUlJQdlBnbjRhTHhMZDBZU1pYWlFqSU41?=
 =?utf-8?B?bnQ0TnhsRnlDQ2x6Y1NVMkduZHlBdGUvcmllTEhZZHJKclluYUUxaFh1ampr?=
 =?utf-8?B?a0FaNTJjWWxtSzlHSXk5ZnZtNjFuRW1qa3lzY04wWHdUU04yOW5oTmRJWEV4?=
 =?utf-8?B?b1NheU5KODN1YU82b1Z6SlJYbi84eEJJZmZuQzVaZXFwS3pRd3lXbGRGZGhF?=
 =?utf-8?B?azN1cW5MSVR4UlBVcVNrcmM5Um9OZDVaTjU1VzN3UHFJOU4wVGhMbzVyYXht?=
 =?utf-8?Q?q+O23S5i0SdK+pk213dxfmhxe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9825af4a-5c5c-48ca-44df-08de013b5361
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 22:39:04.8065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lv9gSpw+BoTxn6uMT8EAi7Vn8k1OuX9iuLxwXr+5JT+GyrXgZPElOpLyhpVfj2WpuiZE3XWKgMGXrqyPOgxGXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8449

On 10/1/25 6:52 AM, Zhi Wang wrote:
> On 1.10.2025 13.32, Danilo Krummrich wrote:
>> On Wed Oct 1, 2025 at 3:22 AM CEST, John Hubbard wrote:
>>> On 9/30/25 5:29 PM, Alistair Popple wrote:
>>>> On 2025-10-01 at 08:07 +1000, John Hubbard <jhubbard@nvidia.com> wrote...
...
>> So, this patch series does not do anything uncommon.
>>
>>>> I'm guessing the proposal is to fail the probe() function in nova-core for
>>>> the VFs - I'm not sure but does the driver core continue to try probing other
>>>> drivers if one fails probe()? It seems like this would be something best
>>>> filtered on in the device id table, although I understand that's not possible
>>>> today.
>>
>> Yes, the driver core keeps going until it finds a driver that succeeds probing
>> or no driver is left to probe. (This behavior is also the reason for the name
>> probe() in the first place.)
>>
>> However, nowadays we ideally know whether a driver fits a device before probe()
>> is called, but there are still exceptions; with PCI virtual functions we've just
>> hit one of those.
>>
>> Theoretically, we could also indicate whether a driver handles virtual functions
>> through a boolean in struct pci_driver, which would be a bit more elegant.
>>
>> If you want I can also pick this up with my SR-IOV RFC which will probably touch
>> the driver structure as well; I plan to send something in a few days.

As I mentioned in the other fork of this thread, I do think this is
a good start. So unless someone disagrees, I'd like to go with this
series (perhaps with better wording in the commit messages, and maybe
a better comment above the probe() failure return) for now.

And then we can add SRIOV support into nova-core when we are ready.

Let me know--especially Jason--if that sounds reasonable, and if
so I'll draft more accurate wording. 

thanks,
-- 
John Hubbard


