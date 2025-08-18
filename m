Return-Path: <linux-pci+bounces-34223-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BC6B2B10E
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 21:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 908B45828FF
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 19:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4D0273800;
	Mon, 18 Aug 2025 18:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t/RSQv2k"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCB1257854;
	Mon, 18 Aug 2025 18:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755543546; cv=fail; b=qVYVW5JEE7c/j95uT7G5pQZATDWRxrUDcNuCgEba/ufGGTp1gRpGsL/jwJBbgvttFRHmWZQol4frzLW6dyLhV3KooIMZPzuvy3Jp8W7GnwTL0r2hCjK4echQ7Bzhj3zj1Scg0PJWJeswkadhi0tQqJPFZHDtWkovG8AsYAPXhIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755543546; c=relaxed/simple;
	bh=H0DfsLCNUoNlZN1XJU4K6NtIRccX/WZekA7xh3COVD4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BdQO+Ole8fhGKvsPxXL/2LBEXeaDjBtYiUPQX34NPmnDG76v1ttO7BRyXmJQlMWe+fpi5XQUHROCN0QZ9QjReWd3zLM2BdLalgb/tOG/2U/e7FeNZl5ZsnutnR6dlkw2IwyhRvSnCquZhl4TLs7SCtBByiIAnpwijOxogV4lxI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t/RSQv2k; arc=fail smtp.client-ip=40.107.93.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OniSkPxSGXTEXAX5cMnGqvhpRhuUc1xMhqC7vBNDDOIJglys/jNcoVqDMtzBHDRU7SVqiwGuAMuF83w17YlSClvxUvPy/4GhPED7S4JEjSts3s/mZxj2Dis6XXpEnBgv1TCgFt26W854UfggwuktO89ss5qEHJSsiVvjtwSaWX1JVsuElqFjvNnoRaZPnCJmB+A1yFYRud5d6yFcc7EMVHb2v1I77sYyi1SLYMqOWiPemLjkKQ8r2G+WvQ6JxmW4lcUY8eMMpHvAl6gnBAeM0m3quHLm8DJUelblhBNPCdSujyqPBh+OvZ75Eh++j2v1EUs2hV4f/z6viUe+Q3p6Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YdD+I4BoEmy6n1srYmnjL4tw4rw3xQVg07FlawwJ3Xg=;
 b=RB8TUDe8uFo7PlvNnh66SOuAcX8sdMuUdjxzV834OpQh/DziaT5GsNVhyy2grpuUHzIfAXJilq8VVrYNr2XUeqcHwzaDFZcsXyyw7xjb0O1vBWd95CB9fZxbVW7W3KE5HYFfUnjfROEpYT3rWKZ5ch16RR7hgyif9i7aoKhK1zz5t7PEuOqjepWW8nRG/DW3RjyFmc8ktKdIb7SPGBx8C2Xpn2660Kravt0l52jBB1i2mP5UUG7voMBEE4L0sKwmJdwpHqv5aafGkl1fvmcKjt7poNv8j33I/u0jwO55fpibHuJeFARob9MJeKElWnwSl8MtTU4pdUaxfmv1zghmbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YdD+I4BoEmy6n1srYmnjL4tw4rw3xQVg07FlawwJ3Xg=;
 b=t/RSQv2kvS2RTdDxzRpGMJtwlNQPSLcFK6MMdJV540ZGvd4zeanlx/DUobc/JAF3KkKokt/xBp8XkItJaVTd1MKApvm3lu2LbRkae8vfd83jGLWKWs/BgzLyRytvGh0I7gATLeya/jpaoXxYzi+MECqemMFHzbWfo8m9rIqBNAp4cCpJqeRHu4NAY7z+g6a8SI7yHYG+WvqLhCeJrmexTdnFlrt6a7rVp05JyNMmevZJddRljjtQanIYxaIqTxfMaoKE6bVqsMeRcpJ4KU/DnDWFOzJmWi+7WZ23SdPhlfNnHkE429PJrHlHuc3o5GHaZGhaU1A8alu3pkB14pjbew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by IA1PR12MB7661.namprd12.prod.outlook.com (2603:10b6:208:426::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 18:59:02 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%6]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 18:59:02 +0000
Message-ID: <1ce4af9f-e909-4cf1-84bd-a1c0a8661c13@nvidia.com>
Date: Mon, 18 Aug 2025 11:58:59 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] rust: pci: provide access to PCI Class, subclass,
 implementation values
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 nouveau@lists.freedesktop.org, linux-pci@vger.kernel.org,
 rust-for-linux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20250818013305.1089446-1-jhubbard@nvidia.com>
 <20250818013305.1089446-2-jhubbard@nvidia.com>
 <DC5N439ZNA6E.34LSQ3K5366P7@kernel.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <DC5N439ZNA6E.34LSQ3K5366P7@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0202.namprd05.prod.outlook.com
 (2603:10b6:a03:330::27) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|IA1PR12MB7661:EE_
X-MS-Office365-Filtering-Correlation-Id: d25cba88-d158-4850-2d75-08ddde894bf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RmlFOWltVFcyRnVrZlF1aXpYL1V2WVN5SnZxYTVUekc3eG8wUmdpQXA4ZDIr?=
 =?utf-8?B?eUdDTEhTRGpnNDZ4aWhabEwrQjUwYk00dnZoc0FONVExc21naUxWV2llUXRB?=
 =?utf-8?B?YTAzeGdsa244eVRwVHJlU1pjdkoyckdIelllZUZiQnhJMlV2eEpKVEFyWnBr?=
 =?utf-8?B?NFE5UlNvaTZmN1BVZi9LRlQxMXNFeHQxUjhCaTZEd2lNUVB2MHNtK2pZWXBu?=
 =?utf-8?B?Wm1UY2lrOXNwM0l3V3EvOHJhS3FVZGFCUmNETlhFZFBwVFh5ZlR0V29RMmpa?=
 =?utf-8?B?by9Ka1JzUE94bHVRbnh1V2VpWFVYdDM2YzVZbHhiZUczd0tzQXVkay9hZEtD?=
 =?utf-8?B?dHdudTBnSkFWNVR3aVhKcWVMWnVERnc0U0pVeElGaXdUbThaaGp3am9hZlow?=
 =?utf-8?B?UDBtT2lVUzlQSFluWkR4enY1VUQ2ak1pZExUazQxUGhhYS9hOENyZlFRUk1L?=
 =?utf-8?B?cjRMZUNtMHNsZnp1Uy8vVjRLeE94a0YyTm5jV0lvS1BHNEdYUzhFRklIK0V2?=
 =?utf-8?B?bmJBTm9EemlHUzd5UUh4bjZ6bWNFczVxaWowWmVsNEtmQUxHN0lJbDVCa3VC?=
 =?utf-8?B?MDBRSzBxYStoQkswUnVwMlBmaWFvQjJYV0J4Tk1yRkxFZ0x0NHBCc0xld3Zh?=
 =?utf-8?B?VFdQUXpxcWRnUDlYb3VmYjVxVWlVWmtpVE9ZZWFzd2V1dmVYTzhaMERuZEdB?=
 =?utf-8?B?UGJkeHBxTmc4TU1LZmtLN1FUNFlOQWY0L24yN05IbVZGOG4zdVRXbjJjS2Vk?=
 =?utf-8?B?QzV1d2JuSHI5NGlDc1hoNkpCM21WM1ZiK1BGMFhiQlkyRTh1REhLaW5WdVZ2?=
 =?utf-8?B?cUtvN3A5eDgxVkxocHVwamtMMVUvTGhVOEthOEQxQSs1c2UzM3JtRTNzUGE1?=
 =?utf-8?B?cG93QjdBd25UNmRudEJNanNYZGp0azMvaDVFQzRlZjRiUDJNdkc3d1ZVUS9P?=
 =?utf-8?B?Z0pMd3NBaEEyRjNJdy9PN1hJWVhRMi9PZ3FxVGlFT1drMmVtTFpwckFNMUJK?=
 =?utf-8?B?bWR5cVdEcmJrd1JENTJXQ2k3clh5ZkxKK0R6TFU4a2RHRit6a25zeDYxN0Y3?=
 =?utf-8?B?Skl5cDRXa2F0OHBxQ0E4QzJpNWYyMitkekYzL3ZNM3E4UnJSU2tZZk9Ed2lG?=
 =?utf-8?B?VkhTVmdvb1ZkT3NJVjJEVWxHSEdSMmhYVWF1dzRpazRKWWFoZ01saWZQSzJ3?=
 =?utf-8?B?U3Y1V0JXdWlOZWkxQTVBNWprcXNsdDBSS053amhrbm0zV1ZQOGxoWVg4TVBi?=
 =?utf-8?B?bUJ2dGRPVUR2NXRqQUdlUUxsNFQ0V0ZJMnAwTGhnc2NnNmtaT2NGSXpmN2Q3?=
 =?utf-8?B?RURKRWVKcjdma3hQMmFWNFFPRzVZZlh6MVJoczNWT3JwcXEzekhMam1RVmgv?=
 =?utf-8?B?NWdDYzJSeHh6TU1YcW1rOGtTbDEvQXhyYXNMN2FzK0ZTazQrKzhEcld5TW03?=
 =?utf-8?B?WEE5dXd4R2tUOWVFOWlCOGYzOXZpYjhELzkzY056UUN3K1ZNS0ZISHIvdnVE?=
 =?utf-8?B?Ty80SWxCazl2dlhxaDlsWFZ2cGtia0M0ZVExbG1PU2w0TXdScFZJeUJsd3dD?=
 =?utf-8?B?RGJaSmtkUFh2NFIxMXl0YzNvMkdGeitZU0FMRVQyQ0hwaTNHMTBKakI2KzJH?=
 =?utf-8?B?V0pRVWtjeHQ0WnhDU1VGd0FjaHZiS0J3L2dXWFJVRGhRV2pOWXNjRERIakds?=
 =?utf-8?B?TzlJc2lyMTlPMzVIQzVLd3E2UHo1RUgzVUc0S2pSRzE3Y2dDNGxFZkFJWDJS?=
 =?utf-8?B?bFkzd2hTU3RqMFlyRjRHNldFZkRaUGFVQWRCbkdCeWJjT3EzR3cvVnd5MWhE?=
 =?utf-8?B?b0VKdHVZd0N3VTdTZlRydysyT1p5VWhJamxSUDRXb3MvUHVocmxFeFFveEdo?=
 =?utf-8?B?Z0I5ZlF5WXZSUkgwcGZEbFZhbm00YmxBam9iSHBYU1B1SW9MUDJRNW5OeDEx?=
 =?utf-8?Q?fGGe0EYFCz0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OVQyeFVCREFldWMvd1ByM3UyeGttYytsOFJ0SVdwZGVqbU9UVlJxTFVEaVlU?=
 =?utf-8?B?S2hmR3NYSzVSdnVtRkVhK3RCamRWUGJKbVlQMDczWC9ZRjJNcUlrckwvYkUw?=
 =?utf-8?B?QXJLNUd1dmpFQ0J6bUJxa1pJQ292OU94R0hMeDc3SlN2KytCUm56NnhFMzNE?=
 =?utf-8?B?MkcvTjBadHZwSFBIZ0U5K0orWVRQa2doVXFWVGVTZEMxTW96UWJURnZnQjdo?=
 =?utf-8?B?TklESGQ0UUZMUDZkMzl6TXB0ekVycHo2WHdEeWR0V1RBRjJXSVVpdm5BbE1M?=
 =?utf-8?B?cEVCenZtSzZydDQzTE9QM2I2QjVQUFY0UDhCZlhZdFQ5Z3hVTXI4dUh1RFZD?=
 =?utf-8?B?Z1lxTE5KNDQ0eTYwSWZNK1ZUUjJCdGpVRmlGa1ZKTHJ6cFFvNXdFd1FOOVE4?=
 =?utf-8?B?cTV5WnJ5RVJpK3RabEtZY29JM21ETmdmVmowL2s2eCt0cVNvRm9QRFZueXho?=
 =?utf-8?B?OUNNN2pqd0NmYjVIRzc3WVcwK200OFBFVUhPOU0xU0o3MmVraTQreEU4NXFX?=
 =?utf-8?B?RFY5eEdWSm1KNStIUVBLU2lvc01ZRklxNjF1TmJNNVNNcVFnN3hYM2IvUUx5?=
 =?utf-8?B?ZlJFZFdRRW04c2Yya0hsaFlLQlZ2WlRlVnhHM203Z3pRT2xYWmRNdWZTYjM1?=
 =?utf-8?B?VVZxRHJEVzlvUU9kbXZrb1Nib0NyV0VNSG9OTjFOYkFQNjhjNS9LTFNFSmg4?=
 =?utf-8?B?ZTVmOGJFN2VJS29mOXRDSy9VbmdPKzAxb0ZxTHZheHZxaUNZbUZWbExnNGJl?=
 =?utf-8?B?VjVWNGh2ZFNyQXdDS1Z1akR2V2RaWm8rcHNXTWhoZ0NDR1lSd3JYd1hhYVlC?=
 =?utf-8?B?U3dMdEM2Zjh6bHg2c0Q4VWl4NTJIMm92SGtZMWNjU3RYRGEvaGNYQ2NMSThh?=
 =?utf-8?B?L0RZOTFtQmpQT3htdzdCVzFWWEZxczgrQTFhc2s4eWlqdkU1QmJYVU5oOTMv?=
 =?utf-8?B?RG9wa3E3NTB2OFQxSmhBV3ROWW1HclM5SW1tcmM1c0lWT3pDQ3VBSGYvTDJj?=
 =?utf-8?B?SSttWWdVN2ZKMWllMjdlL1Y3NDBlUEpxaUpQV2huN1dNOUFTeTlRVkhGalg1?=
 =?utf-8?B?U3huSkVxN3B1NEhtL3Z3L1hsbkFjSkxsNnRTbUZiVjFBWGZJanZDUzRsSHBK?=
 =?utf-8?B?NDZsaXJzbmMybFV4cGxONDRocmZibmFQenlQY3pwc3YyOC9PUHpnTjlDYncw?=
 =?utf-8?B?MmFRM2NOMHhZL3VuY2dabVVySVljeVhES2RhZHRQWVBwVysybmo2c2VlaGFL?=
 =?utf-8?B?bGFMWm5QN05sdWJlVW52TFprdUx3YzcvaW94S2gyMDQ3UkFZMTRJbDhSRytv?=
 =?utf-8?B?b3hNV2VRQUtFVjhZS0RoYldManNJaDVMYWlkOVhHRW1nUHFYMnh0SDNYa0w3?=
 =?utf-8?B?Z1BKbHZBMUh3Lyt5ZmYrcFV1TlI3Z2JvaG4rd2pNM2s5Rno4TUhNUERBMS90?=
 =?utf-8?B?WEgva1hZR21NM1puRFRDV2hNK0k2NlVzdVIyWVgrVEJRNkwwa0NmTTNIRFJt?=
 =?utf-8?B?V0phWk9OZmRUaUlUZlRvdWw5NnBTT1c4UC9FZm9ra2ZHQXpxc2w5L3Y4VjQ1?=
 =?utf-8?B?OG5NZitFNXh1VFdZU2dqbzQwL2dUU3J2RjNaNlBHVjc3K3d1WXVmMFZDQjE4?=
 =?utf-8?B?eWZ5S1dDRzRpczlsd1JaOGJ4MllmSEJtUXRrazRzYU1UbUdsVzI3WXR0WGly?=
 =?utf-8?B?Qk1SdzVTblp0QWVQZVI2eWZ0cDVCamZyUFVxTVZYYnlrdHpEK0JTR0ZoNFp6?=
 =?utf-8?B?TUEvRUlkWGRGUm1KcDNBdWlnVlhCRlZtOFdtWWtqU0Zwb3hKc3kzdURTVGxX?=
 =?utf-8?B?SHlnVjhYcEpBMjdRb2FDMTVkWk9oTDg2dlQzZ1dIZWt2T01WV1BpNUx0bExr?=
 =?utf-8?B?TXJwN1gxVko1ZzRKWVk0VWxnb2ZWOUJIbzRzQmxNV3N0ZG8rdlUxNWo1eG40?=
 =?utf-8?B?UnpkMmJQeDcwY3U5VW1HSVQvMW1LQmErelQyTFFkRVljQkpGTEJEZkFLcHhj?=
 =?utf-8?B?R3E4YXVxUFp6WXRjUWJPNExDUmR2Zk9GVnkvR3BsMVNhbkcxays0SW41LzNP?=
 =?utf-8?B?K0dzMWJ4bzdDWGhPaXBLcCt6N2hsV0NtQTJSbHpnTnFlb1FMZUpOWmlwZ3ZW?=
 =?utf-8?Q?TfSGjkDq7RSs7lRiVJmNJ2bPm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d25cba88-d158-4850-2d75-08ddde894bf0
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 18:59:02.4634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b5GGmiaFGNsc7cKHk9EjtkFblqXPrQWSD8io/Jx1udvxHF28q0w4RJStDDiXA7PYv3smdSdorozLWUPGpxf6Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7661

On 8/18/25 7:57 AM, Danilo Krummrich wrote:
> On Mon Aug 18, 2025 at 3:33 AM CEST, John Hubbard wrote:
>> +            /// Create a `Class` from the raw class code value, or `None` if the value doesn't
>> +            /// match any known class.
>> +            pub fn from_u32(value: u32) -> Option<Self> {
>> +                match value {
>> +                    $(x if x == Self::$variant.0 => Some(Self::$variant),)+
>> +                    _ => None,
>> +                }
>> +            }
> 
> Additional to the comments from Alex, I think one should be
> `impl TryFrom<u32> for Class`.

Will do.

> 
>> +
>> +    /// Create a new `pci::DeviceId` from a class number, mask, and specific vendor.
>> +    ///
>> +    /// This is more targeted than [`DeviceId::from_class`]: in addition to matching by Vendor, it
>> +    /// also matches the PCI Class (up to the entire 24 bits, depending on the mask).
>> +    pub const fn from_class_and_vendor(class: Class, class_mask: u32, vendor: u32) -> Self {
>> +        Self(bindings::pci_device_id {
>> +            vendor,
>> +            device: DeviceId::PCI_ANY_ID,
>> +            subvendor: DeviceId::PCI_ANY_ID,
>> +            subdevice: DeviceId::PCI_ANY_ID,
>> +            class: class.as_u32(),
>> +            class_mask,
>> +            driver_data: 0,
>> +            override_only: 0,
>> +        })
>> +    }
>>  }
>>  
>>  // SAFETY: `DeviceId` is a `#[repr(transparent)]` wrapper of `pci_device_id` and does not add
>> @@ -410,6 +600,18 @@ pub fn resource_len(&self, bar: u32) -> Result<bindings::resource_size_t> {
>>          // - by its type invariant `self.as_raw` is always a valid pointer to a `struct pci_dev`.
>>          Ok(unsafe { bindings::pci_resource_len(self.as_raw(), bar.try_into()?) })
>>      }
>> +
>> +    /// Returns the full 24-bit PCI class code as stored in hardware.
>> +    /// This includes base class, subclass, and programming interface.
>> +    pub fn class_code_raw(&self) -> u32 {
>> +        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
>> +        unsafe { (*self.as_raw()).class }
>> +    }
>> +
>> +    /// Returns the PCI class as a `Class` struct, or `None` if the class code is invalid.
>> +    pub fn class_enum(&self) -> Option<Class> {
>> +        Class::from_u32(self.class_code_raw())
>> +    }
> 
> I don't think we have struct pci_dev instances without a valid class code,
> can we? Maybe we should convert infallibly here.

Interesting. Let me un-dizzy myself about the lifetimes here, and verify if 
that claim is true. :)


thanks,
-- 
John Hubbard


