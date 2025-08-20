Return-Path: <linux-pci+bounces-34400-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF57B2E3F4
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 19:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AF573A9811
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 17:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A954D216E23;
	Wed, 20 Aug 2025 17:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VGkDcQwy"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1F5338F2D;
	Wed, 20 Aug 2025 17:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755710532; cv=fail; b=UeFefIZZTwpq8L8/IYFbBfvVIj5tHiZLlJHOdPMG3x+f5w8bmZpjQJHXXapgW1jDfLKXeeANTGaiCUX7hB6SGba2XqBcblH8iFJufYEXigK7TlBufaZsCHLnSrtuTxABhjboprzU11piaKLyF/dC5I9MUS1zDs93T0FK4sf9duc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755710532; c=relaxed/simple;
	bh=y2YDgUKeGj4jAMNy1RbGX1uwAGbsN9AuFRz96oB3MK8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VzAcDLlXojCy9BRKEr0qaZzz42YCzDgdNDbgv6ujF/9q3vTS+tA73ljCHlxO7iQg6ttOMBZyn/0NW9zUOxJyGkZ+r+Wfv3gITWJiHFD7/cTnSLt/D3Fz9Ga7qHFbl+0qPKbJS2/ZN8I8YzuyJiLishHxv/ro+Vh8VBpF5gN14LU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VGkDcQwy; arc=fail smtp.client-ip=40.107.223.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nPlVYdZTG2mFcbbomFFR0QsJTqomOM13sfgHc1D8axzXK0xMjdhJI9T56aqwIBzjZfVrrM/AbIx+tjPb9RafITR3XUQ0SOE4byuu9Y49ZYrpT8Tbdkq079PSzUHaUubbOoN3DUMcnRVpOXFMFDA8BC2pTT9huMBesak990AHdBLJ7aGXk7Yc8w35739On70z2f2QyOa9r9u2VSrYqzl7UTFWT+nVqyue6jCMyP0oPJbA0OeWSIS//xyuo51cFjzxcXfaP3f01JeZtqaEebtqtyVbIa62XH8CgBi+SPMtGZaXClybHxIojc0954k4LqliUsPT+wEmaDbcjI/6dc6UCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uDZ2OguZt6HyGpKIoQNUUEmiUjlk+zrxIGLC8e0k0Cg=;
 b=cUJ2KZ8G4+LAqaSyJ4y8UJ6keY6X0cg/MRXUHD2MitBI+9s391mStljTWaPG6CxNwX8AKpjh2t8YlAkqY8Z/q/FkA9HqqniCFb+63AO++jurJd/xa8g+i8x2txV+O3EW3ezRfiQ2mE+JRXBXXO4wGC/uoKYYQQRrbwCgAeT92zdyPEL8KzYuhRRW36r+Z80WgKwse6iXt/HWDLspvF2d5B885BakyZiGSAI28FT+5gKUz+MaofN74npqw2vdducOvU2Ru5u052HGPaV24cEtM2Ojp7/KI535luuZMkQ4RmAF4QhLp94WizGwknIRfA22ZyMiEYFCYU1FvgtU9EV+Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDZ2OguZt6HyGpKIoQNUUEmiUjlk+zrxIGLC8e0k0Cg=;
 b=VGkDcQwy/+4bGKpQZQTKK89OuQBvYYkIjya73WrMppDXhL07vtY1B+hBcc9YupM4L32RdShdBuXkYJb6P9Z6STb8YSpumQEaP9H+MQPtm6AH3JgUi6VzvD5ku6BJro+KO9dV6PiIhxc7gEh4wXeJv9zv4FPSgXq52r5eo+wPqzpZWK6KT98IOA1rqduA1fhptw6oW4g+6MUVtPLj6rl+YEsw6lGz27AieBC/uukVmzKb4vruIeHzVqZqbBWWtH2csFCce6AHBLK+falgH0x7YIqhfImMRLYfbhvdhH2Aloapxp7JQr9rNqW0FgiGrT7S+n5SElLxTYwiakHYSC2EAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0SPRMB0001.namprd12.prod.outlook.com (2603:10b6:8:cf::8) by
 IA1PR12MB7758.namprd12.prod.outlook.com (2603:10b6:208:421::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 17:22:04 +0000
Received: from DS0SPRMB0001.namprd12.prod.outlook.com
 ([fe80::49ad:aa8b:a8b2:450e]) by DS0SPRMB0001.namprd12.prod.outlook.com
 ([fe80::49ad:aa8b:a8b2:450e%4]) with mapi id 15.20.9052.012; Wed, 20 Aug 2025
 17:22:04 +0000
Message-ID: <b7063e19-e917-41e4-85fb-b566fc89f301@nvidia.com>
Date: Wed, 20 Aug 2025 10:22:02 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] rust: pci: provide access to PCI Class, subclass,
 implementation values
To: Elle Rhumsaa <elle@weathered-steel.dev>
Cc: Danilo Krummrich <dakr@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
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
 <20250818013305.1089446-2-jhubbard@nvidia.com> <aKVFVO3wbzClcLwg@archiso>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <aKVFVO3wbzClcLwg@archiso>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::27) To DS0SPRMB0001.namprd12.prod.outlook.com
 (2603:10b6:8:cf::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0SPRMB0001:EE_|IA1PR12MB7758:EE_
X-MS-Office365-Filtering-Correlation-Id: 494345d2-6e3d-4cf4-b33e-08dde00e1536
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SmZndXlwSStjbDZYa0hZcVE1VWlRODBlUUduS2pnV2VRdTFSb1g5TzhUV0ho?=
 =?utf-8?B?aFVXRjM1OUZvMWg1RTJEWC80Zm85N3lYZ2dHUlY1cjlmc0FmbVVrZEIwV2lr?=
 =?utf-8?B?YjJ2OW5IMUFuQjQ2SUZxY2FUN1IydGRtK0hNYUJuTCs5cWVUdDQrQVV1ZGcy?=
 =?utf-8?B?WDdtd2c5VWNvdm9JL3ltTDBBcHdCVGdZY0tJVUI1ZXRaM2dsQ1BQN212c201?=
 =?utf-8?B?aFJNTjNSZXdvNkQzS3VtYktoL1pFVE5BUGJKWG5ZVE92RTVaSmNJUHF5bDdw?=
 =?utf-8?B?NzlyR1RMODV3K1hmMEppTUZIc2Zub3FRL3RUYXhaZjYrZ3JHTkJKYko1anpD?=
 =?utf-8?B?OWtSaHBmWkdKNXVTVXdKc2RhWmczNFUwRmJDWnRENVVhalhWQm96QkZsdmdl?=
 =?utf-8?B?SVM1R0VMb3B6TER4MXozbHlBd3piU3EvVVhWM3RsK2Q0QkVRdGVzaWFGeWtZ?=
 =?utf-8?B?Tml5Y1JYZTRTclQvWTVmYWFBTExvS2FYZ1p4Mmdlb3hPQXJFZUY0MDhXcHR1?=
 =?utf-8?B?a1BoNnBVaFEzd1dXSTdXRHp0VVBpeDkxNGdadVlmVE9TZElNd3k4N3Z6L2JM?=
 =?utf-8?B?YmNzVkVmOXQzdXVBaGV4Tzg5L3NKZjEyL1ZBU1ZCZ0pLcUlsTktiZzhMZVdh?=
 =?utf-8?B?UTlMVjJqczdkMWpXYTNQZmU4QThLVTh5ZzM3OUt2K0F6eXQ1UzB5QVFMb2N2?=
 =?utf-8?B?cHRQaGw4cDN5TkdKeG5JMWc1dlR0YmhRTDNzMzBQRGR5cEZlTVppMVMwU0ow?=
 =?utf-8?B?aG9LQkY0WGF2WTRZYzgybXEzNmJCL1ZzOEtLeXVCZW0raVBsMFJPN0VFcmIz?=
 =?utf-8?B?YnhZNUpBc3d0T0dvVXZpdFJTKzRreFpBQndZOVBIYjVuT294aWtiN0VHSlBG?=
 =?utf-8?B?bzZxTjl1MmJleTA1L1B2eXc2a0pLSG90eS8rZENTN05lQmhiRE4yQURCcmhq?=
 =?utf-8?B?MFBKU1BHa0ZnRmJNUzdkOVk2NFFDd3ZneEl1R3p6WU9QVGtIU2hWdnEwR01h?=
 =?utf-8?B?dm9sRksrRFVadFJDZHBYRUlZaGp0K3N1MTVnbS9ESkhPVTMwY1JKdDF6NnZR?=
 =?utf-8?B?Nm5hYU1sMm5aU01MeGpQeUNYUWRxa0JsbW50RWVwRENod0trZ2tLZkk3S2sz?=
 =?utf-8?B?b21XQkNSbCtiREFQcTRoVE96TWZUcjg2ckcwN0owL2xHU1ZHNEtEcmI5ZEp5?=
 =?utf-8?B?OU1TZnM4UHpqck0rdWh5d0dNd2RhY2xEVytVMDJSdnd3T0Y3REFvUjF1dWV2?=
 =?utf-8?B?Z1FuSURoZWd4cjhmNk5WLzVBaHJoL0NzM2FlUzNHRWhzbXhEWWNMblBHNWRx?=
 =?utf-8?B?UjJKYytqQXk5VHZSNVNnM1crRmVweUtxTGZLVjNlNzVmL1lkNTFoZ2dTZkZ6?=
 =?utf-8?B?OTNlZkVPdUFqU1ZNalE0Si8zWnVtbGRWb3Y3STNZNGgzVmczOEJoK2RyWGsw?=
 =?utf-8?B?emFKY2U0MkN0UGVROEM1dVpsRjZLQ3Y3cDhrVnBPZXc2ZjhlRHdjSkloemM0?=
 =?utf-8?B?ZTFLZkYvdUlCU21kVXI0SGpWSXJQY2lPZ3pjSFh1M3NNRFpvVDBvYVZJUmUv?=
 =?utf-8?B?N3pNQmRFWS9rR0FWS3Y3VHNnQUMrMkVoL241bmZOK0pzdy9mcS9Xb2N1a3Nk?=
 =?utf-8?B?QnFwZjNOVXdvZXBxWFpyZSt0blE4dEI3aDVTMGkrem5XaGVLNWRWUHczdW9T?=
 =?utf-8?B?eW55Vk04VjRHcGtHRm8vMVVxVlkzUG5BR1RFZkdXVWEzR3BlMGNHRVU5NUZK?=
 =?utf-8?B?MEdmQ0VsL2xlNTNYYTNDUlhHWXhmUmJMQkhLa09pY0xuT0M2V0NWTzVOQTZQ?=
 =?utf-8?B?T3ZCTnppQmVMWitRcXl2b05DTituYTdMeW5xSWU0ZXdIVEoxQWJFZld6Nm56?=
 =?utf-8?B?TUt1L1hUMHhoQ283Um1KK3kvM2VrenovVVl4YzVVZEpKUUpMY0xxMjlrWGQ3?=
 =?utf-8?Q?me4Jgu8T6P8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0SPRMB0001.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGYxS1RyWUV2T1VGUHJjSUx4TWhoSzczVUI4YzBBODB2cE1VODUyTHRBeUh3?=
 =?utf-8?B?N1pURk1FMmxWclJ6ZVNBbXhJRG9lekVOTXRmQm02T1l2VmJ2eEJBWWttMDUz?=
 =?utf-8?B?bU1rK3IxMUVhQ3YyMHk0RkR2K3RndHZERlJyN2tHZ05OUE1IazgyQjVxb3lQ?=
 =?utf-8?B?SkhkQ0ZTdk9mMVZhb3F1dkZvWnQwZFppZGM3SDQxeDR2cVMvaktpcGdTd2dp?=
 =?utf-8?B?KzhUSDJNMU9yek9pS2F5ZHdpbVRWQ01sSmp3ajQvbkt6YmRUSEc3WVRmTmwx?=
 =?utf-8?B?bUd0ZU83dGxFdTdyMmxES2VHS0lVTnJLbmgxZkdhcHJxWmZQODhZRHY1OWYz?=
 =?utf-8?B?bWhpNU1sbktwMGNpVTRjaXUyYi9makdzS1lPZjFxNG43VnZzdGlQSFVmQjFL?=
 =?utf-8?B?eE1BU1A3WnpldGNnNldqVzJJZmpYMkI2N0ZzR21TaGVkZS9NMmIxNm5EdVl1?=
 =?utf-8?B?NWsvZzdmSDI0MVc2SFQzejJjMkcwblhpRXNLek5GRVBnQVBuUW9hdmU0aTBl?=
 =?utf-8?B?SExMd3JWSFd2TEl2Y1hUb0NJSmxMOFcrR3V2bnRsc0lUcTRXN1lvRUFlY21J?=
 =?utf-8?B?MW9qWWxveXg0RnJNdXZETkIrSTNFT1VNVDBmcE82L1dEUy9YbGpsTGNFeGcv?=
 =?utf-8?B?T2ZnWkRPUG1zRkw4Sm1hQ1huTlc1ZVlacGZiREJ1dW5xV3dKcjl1cVNNaTJv?=
 =?utf-8?B?a0xqbDlqVGx2NURiOVJZYzk4SGJwckE4YWlLVFpScEp6aFVMTWNvbnluVENS?=
 =?utf-8?B?S2tkTUdGVnFFY2kwSU5tNVJ0RHhXcTQ5dHdadzNTdWxQMlV6RVJjbnhlckl1?=
 =?utf-8?B?T2NtSkMvZXd0M01kVEhyZUxrYStzUjYzZi83U1M3bWxHRVNEdm9Od2tsLzNn?=
 =?utf-8?B?U2g2eUdDZlhCd2pmVlZjWXJSVVh1eDhKd21UaXduUTU2VkhOR0lLL3RTUllF?=
 =?utf-8?B?blZ5MzJOSG5NWEI0N2tNbVhGSENJdExINVlyVTVPRFY3MVJqY3kvTjBTZXhL?=
 =?utf-8?B?TnZVa1VMWkViaHZIM2todGVBMzBuN1RHUDJReC9WTXJ5NXg1RHAvM2ozbjEy?=
 =?utf-8?B?UlY0U0RQdFpqWm83RXJsWnNoUXU2Y2U4SEJXeHpXMHMvRnBCc1BDRW8xY2ZP?=
 =?utf-8?B?L2pyNVNTK1g5V01ZRnlzUWZ1RTlHSjdrWFVBNjEzTDVJTWsvNzQ3SzJ5RS9W?=
 =?utf-8?B?OXpHV0g2TWEwZEVBQlNhSGdoclZYWHV6eGx5em9vbzZMbVBnblVqVHB2ajkx?=
 =?utf-8?B?UGU5dVlORU5XK1BpYURNNDFWTWg5dHEwcXlKL0l5Q00yVHJYbTd0R0RpZnRy?=
 =?utf-8?B?UWt5SVFNb01POFUxMkZaREt1UFRONnJxTVZOZisrM3JNQ045c3ppSlBON0Fy?=
 =?utf-8?B?cHZ0OHNjdEhWTUR5RzRwOXEwbTZ0bVBqVmx3UTh4eC8rR1A2cmZreTE3enln?=
 =?utf-8?B?blY5TkE0SHIvNGg5b3dhMGkyQ3h3S1U5Q1QwMTk1SVhSZ3kyZ0Z2VHJRekhW?=
 =?utf-8?B?RmxWYy9acHpPQWRsdllaSWkwYmtMTDNIOGZ1K3Y5R1cwR1RkeENJeEFjckl0?=
 =?utf-8?B?ZFpob1NjdFJ4UVZIYmpnaGxwUWFQa3ZoNUY2OEtZeG1tTHo1OWVFN3I0VnpS?=
 =?utf-8?B?eUJXYXp2OGxLTHJOL3lNUUQxN2RWdFRpMEhJZlBiSTZkUVFOc3IvQzdVQnpM?=
 =?utf-8?B?NjFyaEV0cENaeHE4anlMUkdKQ2pOK01jaGNKVTJlOHllSlhrUDFZSCs1R1Qz?=
 =?utf-8?B?ODR3M0Z1WUY5SEJpZmR3aVlsQml4VHprU0VJVGErU2lyajRzRjRhQWl1QnYr?=
 =?utf-8?B?dURVeHNBM0NyWjFYNkFqckl0d2NHeFVDckJlS0JEYnZsSmpQNkRkMGlZNnpJ?=
 =?utf-8?B?SzNMTEZSRHdzMVlSM3YwZHVNb05rZ0paNm1PeGJ1dmRCY0RWb3FRenliY28z?=
 =?utf-8?B?N0FIczdFbHFPMEQ0RVBuZ1Y3Q1VjaXYxMHNQQzBmc0l2OGs3V1MxdEtSSVNi?=
 =?utf-8?B?R1RGajhOaDRiditEUDJ4enRTa2tSeSthZ1VEY2tmVXVNbzArREZVQTdlRUpo?=
 =?utf-8?B?MHRTMjNHZE1zM1JUdXVpTWh5ZmNGWFBHL3d3N0krRHB0SnFDWWlXNGdHK01X?=
 =?utf-8?B?NmEzd0JlMTNsalJ0Z1ZGYVRiOVRvdEJlWk5TUU9CUVljRFhmUmxkdWoxVFpR?=
 =?utf-8?B?ckE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 494345d2-6e3d-4cf4-b33e-08dde00e1536
X-MS-Exchange-CrossTenant-AuthSource: DS0SPRMB0001.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 17:22:04.7751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ShMRvk+ZtSJvhANCincUY62MjYJ3HQnw1e2vYQuMsqj4FiwDlSKD4jjNevUpmyuH5x2qO9D6gPb+d5D9MJnb7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7758

On 8/19/25 8:48 PM, Elle Rhumsaa wrote:
> On Sun, Aug 17, 2025 at 06:33:03PM -0700, John Hubbard wrote:
>> Allow callers to write Class::STORAGE_SCSI instead of
>> bindings::PCI_CLASS_STORAGE_SCSI, for example.
>>
>> New APIs:
>>      Class::STORAGE_SCSI, Class::NETWORK_ETHERNET, etc.
>>      Class::from_u32(), as_u32()
>>      Class::MASK_FULL, MASK_CLASS_SUBCLASS
>>      DeviceId::from_class_and_vendor()
>>      Device::class_code_raw(), class_enum()
>>
>> Cc: Danilo Krummrich <dakr@kernel.org>
>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
>> ---
>>   rust/kernel/pci.rs | 202 +++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 202 insertions(+)
>>
>> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
>> index 887ee611b553..9caa1d342d52 100644
>> --- a/rust/kernel/pci.rs
>> +++ b/rust/kernel/pci.rs
>> @@ -23,6 +23,179 @@
>>   };
>>   use kernel::prelude::*;
>>   
>> +macro_rules! define_all_pci_classes {
>> +    (
>> +        $($variant:ident = $binding:expr,)+
>> +    ) => {
>> +        /// Converts a PCI class constant to 24-bit format.
>> +        ///
>> +        /// Many device drivers use only the upper 16 bits (base class and subclass), but some
>> +        /// use the full 24 bits. In order to support both cases, store the class code as a 24-bit
>> +        /// value, where 16-bit values are shifted up 8 bits.
>> +        const fn to_24bit_class(val: u32) -> u32 {
>> +            if val > 0xFFFF { val } else { val << 8 }
>> +        }
>> +
>> +        /// PCI device class codes.
>> +        ///
>> +        /// Each entry contains the full 24-bit PCI class code (base class in bits 23-16, subclass
>> +        /// in bits 15-8, programming interface in bits 7-0).
>> +        ///
>> +        #[derive(Debug, Clone, Copy, PartialEq, Eq)]
>> +        #[repr(transparent)]
>> +        pub struct Class(u32);
>> +
>> +        impl Class {
>> +            $(
>> +                #[allow(missing_docs)]
>> +                pub const $variant: Self = Self(to_24bit_class($binding));
>> +            )+
>> +
>> +            /// Match the full class code.
>> +            pub const MASK_FULL: u32 = 0xffffff;
>> +
>> +            /// Match the upper 16 bits of the class code (base class and subclass only).
>> +            pub const MASK_CLASS_SUBCLASS: u32 = 0xffff00;
>> +
>> +            /// Create a `Class` from the raw class code value, or `None` if the value doesn't
>> +            /// match any known class.
>> +            pub fn from_u32(value: u32) -> Option<Self> {
>> +                match value {
>> +                    $(x if x == Self::$variant.0 => Some(Self::$variant),)+
>> +                    _ => None,
>> +                }
>> +            }
>> +
>> +            /// Get the raw 24-bit class code value.
>> +            pub const fn as_u32(self) -> u32 {
>> +                self.0
>> +            }
>> +        }
>> +    };
>> +}
>> +
>> +define_all_pci_classes! {
>> +    NOT_DEFINED                = bindings::PCI_CLASS_NOT_DEFINED,                // 0x000000
>> +
>> +    ...
>> +
>> +    OTHERS                     = bindings::PCI_CLASS_OTHERS,                     // 0xff0000
>> +}
>> +
>>   /// An adapter for the registration of PCI drivers.
>>   pub struct Adapter<T: Driver>(T);
>>   
>> @@ -157,6 +330,23 @@ pub const fn from_class(class: u32, class_mask: u32) -> Self {
>>               override_only: 0,
>>           })
>>       }
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
>>   }
>>   
>>   // SAFETY: `DeviceId` is a `#[repr(transparent)]` wrapper of `pci_device_id` and does not add
>> @@ -410,6 +600,18 @@ pub fn resource_len(&self, bar: u32) -> Result<bindings::resource_size_t> {
>>           // - by its type invariant `self.as_raw` is always a valid pointer to a `struct pci_dev`.
>>           Ok(unsafe { bindings::pci_resource_len(self.as_raw(), bar.try_into()?) })
>>       }
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
>>   }
>>   
>>   impl Device<device::Bound> {
>> -- 
>> 2.50.1
> 
> All of the functions could probably be `#[inline]`ed, though I'm not
> sure how much it affects the `const` functions, since they're already
> evaluated at compile-time.

These are not in a hot path, which is why the other, similar functions
nearby are not inlined.

> 
> Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>

Thanks for the review of the series!

thanks,
-- 
John Hubbard


