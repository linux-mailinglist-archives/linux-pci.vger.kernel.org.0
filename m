Return-Path: <linux-pci+bounces-34786-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC16B37307
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 21:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BC9C463206
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 19:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E88F374277;
	Tue, 26 Aug 2025 19:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aT/0Tx0Q"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9557B30E83B;
	Tue, 26 Aug 2025 19:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756236328; cv=fail; b=F1ONvTr3DhSb5uhXdkwvIp+DVIYfKH5pph9VDU6iFr7UV/VJrQMtiy5dEBHy1kqH2Ch9eseP+nsAemmqdjgeNcLO7xkYJdrVCR176Z4mEopt/RfOUfDWrfTgEpLyjct6rzSsksWNQYr+1KPXcr6ApXmIfiJ/6EAVatPusy+BHKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756236328; c=relaxed/simple;
	bh=G33xnzISqLnfGNK5hEVKYxU/Ntr3K0+D6vk5vWyZ9h8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lEHlQydx/zeugSaoTYL/9eF4vCAvG6S9CviEt/rZt5tJ/ETJfEXF2vCT0zS7cYB1d/g9xefSbNt2E3u6FIWoXh4cSmdQD6P1XzFmQYxH40xAcllMc98JyOqx8WwFSX2ufOf6LrdkF+tK1H6Qa1tUy23syP9TPtnjzqLAgq3a3ik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aT/0Tx0Q; arc=fail smtp.client-ip=40.107.237.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TV8fCHMpQT9RcfihbRgCn7+js+fWgLcPKG8UApFZCVRM+Qw66ckzTSMeaIp5/5kGpG4FTWgQ3fiVVSsdzy5TPhfwLg8meFTiR8F/m85/7x3Vd89PWLcY6UngvNXHNTmUl4TG0PffXWB6IBfO7KsYKjuejYevgY27Ycx8KSV1dzj+FyqUcdRLFT1rC/bcKuI7GZnfQcszlFnS2/Derhe8TyytOAXdYhHy1vc6rBqtYkVJUajDkuWesWySzBUmnJM5c22ZM2pWVETAFProtmHWIv7rFd/aGOtaPId9Pb0m9P8C6Kbzrh9vVUVAMY7OQyS6+eD+5hT7KnVak0m8BwyUJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xWLBBXvM9ZPeAhneazv2kHps+jLVWKcJo8H533Wzcm0=;
 b=MAeGSwLZD422PoI7jqHFDHhKIRmqCBn+o8J2jkv0s4I/Gpw06Kc+fFIZwwLiYhWD/Hu8+2TYagqAN21boDbEfkd2dEJGn+9dftH/ft8FYCWDqTx5LQfx9IlQBSIcU3qs2TqoG/0E9QRWm79YPdmVu/J7XePtXPRHb7Zb+ntV0pnVnMTbaycoLjPr56QzSx+ZJpIQWM7jgRfPbfzRnyizrAdegGVW+D44tVtwwOdAj3wDaLR9OWz6ZyIKYjxl+uVFyxTnDVNKg9NyAD2A7QAtBnnDC1RCggoOgexrLLX1ok0SvrcdwHo+24v2jQTYYQkrxdntyeyZsN7Xz9PKRFhRjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWLBBXvM9ZPeAhneazv2kHps+jLVWKcJo8H533Wzcm0=;
 b=aT/0Tx0QapLc1CQ/QKG3+MRukDN0pIWFrsIqFJevqWB+DU5JiPu1H2OkxwhKvSliOUcI6qJzjMluBn+kdd5/q1nWbncaOryEzrxXDGi7e8jlFqct53YA++Y2aAfffs6qlljG1ahXi+DguLNfXMoZycTOPJW/8WpqO14EUHJQQo/j9wKDsmjOioS964h6xb3MiTYalvCGeVNELCBxcXkirdcoUrPKnki/GO0Og6shPa6y1FiNCdrUDG15V1P9iXPB1teEXps6FuwcDZ1MNyEHOSvklzHFVIIN32TqdGdubWIqjcJk4IYlkbe6mE/yeOMXdxiBpnh5Cm0JNjPCZx6ANA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by DM4PR12MB6011.namprd12.prod.outlook.com (2603:10b6:8:6b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 19:25:23 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%6]) with mapi id 15.20.9073.010; Tue, 26 Aug 2025
 19:25:23 +0000
Message-ID: <90407ba5-d848-4797-af07-1a51911d9b6d@nvidia.com>
Date: Tue, 26 Aug 2025 12:25:20 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] rust: pci: provide access to PCI Vendor values
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
References: <20250821044207.3732-1-jhubbard@nvidia.com>
 <20250821044207.3732-3-jhubbard@nvidia.com> <aKznsxvFqW_2jJkv@archiso>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <aKznsxvFqW_2jJkv@archiso>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0003.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::16) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|DM4PR12MB6011:EE_
X-MS-Office365-Filtering-Correlation-Id: ac23cee9-70e1-447f-cc8b-08dde4d64d97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a3VicDI1RVhXODdrZTZnWGFhdHQyczkyVFpXVWNIQkN2VU5CKzhST0U2TUdH?=
 =?utf-8?B?b1hIdGp2cGI2dGdhZnpuRlN5Y04wc3F4SmIybWhKbHovQVpYbWJqeGhseHlP?=
 =?utf-8?B?WitjcmlaS2pLNjAvUUp6ZmxRdDVlV3Vtb0VTZDJac21ZaGlKMSs0UVpGR3Bx?=
 =?utf-8?B?ck41NUdkeGRHTWhEYm8xTC9BTXlTdC94WDdsZGxrQ2xwbFZkUXVtbFk4dWlK?=
 =?utf-8?B?RndEc2JDSlZxa1JaWWpUU2JQdTdYL2pBUFl2WCtISFdiazZndU9rNzN1cW1H?=
 =?utf-8?B?TjRGQ2pQanA0aVYwZzY5SXlEZ3QvY0NEbVViTG9XKzZyUUlpTEJqMmFpWXJk?=
 =?utf-8?B?c3lDNFhJYUQ2NndPbFdjMVZVWVFHRXRQUUZnMnBCRW1kT1UvSjFVRzhQNmVW?=
 =?utf-8?B?d09tWW5pTjVuL3pUZkszdVUrUU55SGFVOFJxR1c1dlU4T0NjK3JsOTlLeFc4?=
 =?utf-8?B?eTRpbjlTcld4UXlVRlZtREk0ekI3L3Z2YzdkZ1pMUTdOSyt3ZlhMcE1LWGZt?=
 =?utf-8?B?WlRzVXVEQ0EyUWdJRTUyaVBsaWZ3Z3lkOGFyY0wxbXFWVHZ5ZFkzeWlaUllI?=
 =?utf-8?B?elMzSUNIZnRjSmoxN2R0QkorRkhCWTF0TkhqeHFxR1FFU2FSOVhKMVk3cDg5?=
 =?utf-8?B?Z0RiNXRobGVJdGFBaHJmWVBwSkZ4Wk1ZNVBtVjF6dXlpdU5ESFNyZGJVTENu?=
 =?utf-8?B?UG44RXR5Wmcwa3EwY2t5Q21DSEtralpzQStUWkJEN0dDVGg4VkJwbkNmTHY3?=
 =?utf-8?B?U0xnSFRPdUZIRE9CL2tVY3ZLbWp6NVV6ZHo4aUcwS1UrZXNEcjREdkFaWERa?=
 =?utf-8?B?dW5XQW81UEtERURVRE1QNzVEM01NWFNsa09kYjI3ZnpHVnRCM2NadFBOdW9w?=
 =?utf-8?B?K3puWVl5SWlhK29GOUMxcHNKbFlnUW5DTkJJQTNUU1NyZWRXelpJOE85dmM4?=
 =?utf-8?B?dGd1N2I2dkpWT1Y1YTBzT3pYYzlpckFscWRwY20wSElZcnZnOUthSjYxc0Nw?=
 =?utf-8?B?OHVYQ29OOVZvK2wxalhTcjlEb3pQSUxTTTlHZEJxZE1EYU5ram41Y05Gblhs?=
 =?utf-8?B?MlB5akN1OTZNaG5KYWZVWEU4M3JreWR6NGxPQktDOUxLQTM3VFRmRnl2a2FF?=
 =?utf-8?B?MlVxTXlZQnY4N0JVOTR1cHEvSHFpM1I1RGRwbDdqMU83THdjTnRaTUhUdVlo?=
 =?utf-8?B?OFdESWhLSno0OWdacEZQcFU5akQyNW1TQm1YQUJMc0VZVGdmdkRHcWFVemsr?=
 =?utf-8?B?d3d3MlpseWdYK0FBdUdOQ3lPNzVJZnN3WDExZVhldy9CT1VZREdsZmZnVnh0?=
 =?utf-8?B?cmNlOWVRUytHdDlsL0t0TVNqdlhSMTcwdWxGTzdUdDJMc3lEYmUvV0FaUHhI?=
 =?utf-8?B?czVtZ2hxdzdUL0FpMVBHUmNka1FucDI2MkEwQlltNnBrTjYrdzdBOU5tRFdk?=
 =?utf-8?B?STNmMmFrM2d6RTMvejdJVmF4L3llQVFQVjZHelduM3Uyc3N4U2IrallHVnI1?=
 =?utf-8?B?d0tYV0JxTXlYNnkrVjljVWpBK3VBUlNidEJzNSswbW9YcFNmZ2sybmpXNS92?=
 =?utf-8?B?WlFmOHZ1V3ByZTZETWZYd216MHpUODRmMUp5Nm11UERvTGxqam91dVc5c3B5?=
 =?utf-8?B?b1R5K3JYbmo4ckxIR0prcWRLS0hUTktpT1ZyUUtWNU5CZ2pKdmVuRmdsSDFU?=
 =?utf-8?B?MjB3enNGTFJLM0loR0hSSTA2WnRodklMNC9aQWV5Y3UrRlRtWStjY3M1a3k4?=
 =?utf-8?B?UjJvZjBXWkhOZlBsQVQ0b1dSbkpqb3FOREtFYVJ5WVhVaHhCbnp0QURncFFr?=
 =?utf-8?B?RXBQZFVFeGFCdUt1T2pmanlqSUxsazhPdXpJN3crYll2UzIxcEtBWTE3MHZv?=
 =?utf-8?B?ekp3VGtkMTdCdS9wT1VSbkJ5MlRIcDEvdEIyQ3F3VnIyZEp3UVZIZzA1Ynhu?=
 =?utf-8?Q?4jMbMl6Atpc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YlhHNmFqSlVrRDN0T1ZrbmxaY0lRRGZndmJrMGpIM3FMekxORndrRlRnWXpO?=
 =?utf-8?B?ZTdKdzJqNG51ekUzMnk3b2huRWFvd2FBblEwMVdubFBMVzQ1cDlvQUtpeC9Z?=
 =?utf-8?B?RFo0NTYxVnlXQW1TSHVnTVdQc0ZoMVMwR29DM2t2bm9PZGdIYUtaVmh5aTN0?=
 =?utf-8?B?Q0g2WnNLbUhUNWdiYVhqQ1llNE9DTFhrRGIxOHBOemRSL2h1S1VtNVpPUGJy?=
 =?utf-8?B?UHRPSE9lMWxqRDdmN1Rybi96SngxNFVIQzJFWjNreXJ5QWdmYjVRQm9tYSt0?=
 =?utf-8?B?V214Szh0QjRFWEZpRThTRUU3Zmg3dXYyYU5MVVplazhiMG83UHloWkw2b0Iv?=
 =?utf-8?B?VnMwdVFvVFJiWmtmclhYSEFISHZremY0NDB5K1M0cmtzNFlGKzZpOHhZZmhS?=
 =?utf-8?B?RHF0Q1hRbU93TXZzVVZoTXNjekUzWGkybUgxNmEyZTNQL0Y5WW0vV21EL3pX?=
 =?utf-8?B?V0JiR0VMSm9NVmN3MElZaHBaSzRQNHZsVGdJNEpRWkRlNEhWNm9Dc21xdUFa?=
 =?utf-8?B?TFo2MUk2cDhOQUFyNjdzVWFqU29FUVg0SGVkdjdpUzRXVEJ4SFJtNklKTkpW?=
 =?utf-8?B?MUoxK2Y1Mk1pMFBoMG9FVm9UWmlyNTlWMXVnakUxRkpWVVpaOXo0YVJaaC84?=
 =?utf-8?B?bDQ3MmRYTFplaFJGc2R2TTdKa25jQmxYd3JUeXc0UGsyR0VUbnZ2R0cxTElE?=
 =?utf-8?B?VFZ4RHVLZmtmR0xCNzVSTmlIOFpJRFN4TE0vOFFKUmlDcGd4dmhmSXhURnBZ?=
 =?utf-8?B?NS9GT2dBYkROR3c0V3FMeTQ0aWpjdjNDL1dud2tqQ3NYSVlHUmZCS29NdzN5?=
 =?utf-8?B?VFlJOXBIMFJjallzZUV2bEVVdzkrWGxZR04wMkhYMmM0RkJxZWtObE53Rlln?=
 =?utf-8?B?QVZQdHBRYzBpbVVNcisycm9uVVNLdjJoWjYvejRPOThiVlAwQmFpdGNWY0tr?=
 =?utf-8?B?WFRJUE92cm5XdE1PeVBYSHQ5cHhqTE5WWStDYW5LSVJTcTl1b1pTejBFR1M5?=
 =?utf-8?B?dUthcTdtUVNmYmJEU0psOFd3cWdKWnVsNmFob1ozd2NwM2pyNllabnJZb0dj?=
 =?utf-8?B?aGlJb3Z6RmhjK013RXhCUHBvdWlFN0pNYTQ4b2M5UGtjNi8vaVlUMzFEYnR1?=
 =?utf-8?B?Wk9saDdUeEdkQVpmcURqSmlpUmRNd1VIR0ZCL05DT3lMckU3N1ZoT0wvWnhV?=
 =?utf-8?B?cnk0S1NXRGR6SklGbXI0OEphRmNPRll4b3czZkxwck1raVBSSWlJWXluVVdD?=
 =?utf-8?B?NVVHTFAySm9lQ0ZHRW9KK3EzN1ZoZERsT3hueTRiN2NwcTRTU0doMzFJZDB0?=
 =?utf-8?B?WGptWm9qc2RGNlBDUnJNY2dKMUpNckVuWURJOExFSEJvMWMxM3RoK3Bwbk1a?=
 =?utf-8?B?d1FCRmR2NERsckw1bEJWU0FhZDJMbHkzK0poS1BITnJ6M29CU0tKQkI1SHF5?=
 =?utf-8?B?aWozM3RoeUNVV3hOemw1bDhQdW43RmpHOXoxa215dnNvcm91RnhqaHAyQnlD?=
 =?utf-8?B?R0hHVmt3ZFVwRUVCVE5ia2o5UzhoUmVsclhXODI3Q3ROR1dUaGdvMjVJZlZy?=
 =?utf-8?B?Q0M2dVQwL0VNMDdyc1JYQ1Q1aXdRSlB4YVN4NXNVQmYwQm53ZnkrRFZsV3hl?=
 =?utf-8?B?ZWVMQ2s0VkY1dDQxdXhPMzN5M0NxblF4NjlwU0xGdE05NU5nKzg1TW1LRzVr?=
 =?utf-8?B?eXdyNGwzRFFRWG1nNFBZRGJPaTZuUzlKVC8vblFMOGFtZkthaHJWMDc2SkhG?=
 =?utf-8?B?R3B6TXUrZGJXaTkvR0VISUNHd1RsdTlKcXp3YzlQTm01a3Rpb0YzQkUvSnEv?=
 =?utf-8?B?M08wdXhuZTF1UVBJK2lkQnRYVXZad0F1NEFlRTZ6THFxaDZhdVRUK2FlWmRQ?=
 =?utf-8?B?SXRqaEhESkp1ZkpSTTZ0bXVuWGZtU1NDbnFWQ1R3RGtEOFhRWWplN1AzRHNM?=
 =?utf-8?B?NlI5bFl1a0wyOEV6eWdmUFVXb0JudzEyelJiUzlaeTE2YWlrYmZDL0xTcis2?=
 =?utf-8?B?Ym9TVUhQRXVSd09BenBEcTYreXpOUkgzbWpiR0NCVG9NWGhCRzQ5eGFOOVZi?=
 =?utf-8?B?ZnRnSHhDeGlqbU9wVThIZXJLLy9jSTJxbzVueWtYU1FWaWwvMnIxTXVab1l2?=
 =?utf-8?Q?L9cLUjwbEIAZGvdqVbIPg6VUz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac23cee9-70e1-447f-cc8b-08dde4d64d97
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 19:25:23.5406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v6KfA6i7CfDhNTatzkEqeG9nCCSO29MMul9xEtNn8pt+Cu7W48aCO7QgGfF1FC2XyroKY0p83dvoIbv0CrYuJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6011

On 8/25/25 3:47 PM, Elle Rhumsaa wrote:
> On Wed, Aug 20, 2025 at 09:42:05PM -0700, John Hubbard wrote:
>> This allows callers to write Vendor::SOME_COMPANY instead of
>> bindings::PCI_VENDOR_ID_SOME_COMPANY.
>>
>> New APIs:
>>     Vendor::SOME_COMPANY
>>     Vendor::as_raw()
>>     Vendor: From<u32> for Vendor
>>
>> Cc: Danilo Krummrich <dakr@kernel.org>
>> Cc: Alexandre Courbot <acourbot@nvidia.com>
>> Cc: Elle Rhumsaa <elle@weathered-steel.dev>
>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
>> ---
>>  rust/kernel/pci.rs    |   2 +-
>>  rust/kernel/pci/id.rs | 355 +++++++++++++++++++++++++++++++++++++++++-
>>  2 files changed, 355 insertions(+), 2 deletions(-)
>>
>> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
>> index 0faec49bf8a2..d4675b7d4a86 100644
>> --- a/rust/kernel/pci.rs
>> +++ b/rust/kernel/pci.rs
>> @@ -25,7 +25,7 @@
>>  
>>  mod id;
>>  
>> -pub use self::id::{Class, ClassMask};
>> +pub use self::id::{Class, ClassMask, Vendor};
>>  
>>  /// An adapter for the registration of PCI drivers.
>>  pub struct Adapter<T: Driver>(T);
>> diff --git a/rust/kernel/pci/id.rs b/rust/kernel/pci/id.rs
>> index 1291553b4e15..dd91e25a6890 100644
>> --- a/rust/kernel/pci/id.rs
>> +++ b/rust/kernel/pci/id.rs
>> @@ -2,7 +2,7 @@
>>  
>>  //! PCI device identifiers and related types.
>>  //!
>> -//! This module contains PCI class codes and supporting types.
>> +//! This module contains PCI class codes, Vendor IDs, and supporting types.
>>  
>>  use crate::{bindings, error::code::EINVAL, error::Error, prelude::*};
>>  use core::fmt;
>> @@ -115,6 +115,74 @@ fn try_from(value: u32) -> Result<Self, Self::Error> {
>>      }
>>  }
>>  
>> +/// PCI vendor IDs.
>> +///
>> +/// Each entry contains the 16-bit PCI vendor ID as assigned by the PCI SIG.
>> +///
>> +/// # Examples
>> +///
>> +/// ```
>> +/// # use kernel::{device::Core, pci::{self, Vendor}, prelude::*};
>> +/// fn log_device_info(pdev: &pci::Device<Core>) -> Result<()> {
>> +///     // Get the raw PCI vendor ID and convert to Vendor
>> +///     let vendor_id = pdev.vendor_id();
>> +///     let vendor = Vendor::new(vendor_id.into());
>> +///     dev_info!(
>> +///         pdev.as_ref(),
>> +///         "Device: Vendor={}, Device=0x{:x}\n",
>> +///         vendor,
>> +///         pdev.device_id()
>> +///     );
>> +///     Ok(())
>> +/// }
>> +/// ```
>> +#[derive(Debug, Clone, Copy, PartialEq, Eq)]
>> +#[repr(transparent)]
>> +pub struct Vendor(u32);
>> +
>> +macro_rules! define_all_pci_vendors {
>> +    (
>> +        $($variant:ident = $binding:expr,)+
>> +    ) => {
>> +
>> +        impl Vendor {
>> +            $(
>> +                #[allow(missing_docs)]
>> +                pub const $variant: Self = Self($binding as u32);
>> +            )+
>> +        }
>> +
>> +        /// Convert a raw 16-bit vendor ID to a `Vendor`.
>> +        impl From<u32> for Vendor {
>> +            fn from(value: u32) -> Self {
>> +                match value {
>> +                    $(x if x == Self::$variant.0 => Self::$variant,)+
>> +                    _ => Self::UNKNOWN,
>> +                }
>> +            }
>> +        }
>> +    };
>> +}
>> +
>> +/// Once constructed, a `Vendor` contains a valid PCI Vendor ID.
>> +impl Vendor {
>> +    /// Create a new Vendor from a raw 16-bit vendor ID.
>> +    pub fn new(vendor_id: u32) -> Self {
>> +        Self::from(vendor_id)
>> +    }
> 
> Reversing this implementation would allow for a signature:
> 
> ```rust
>     pub const fn new(vendor_id: u32) -> Self {
>         ...
>     }
> ```
> 
> Which would allow use in `const` contexts. Until we get a stable
> `const-trait` impl, this is kind of the best workaround.
> 
> Then, the `From<u32>` implementation can call `Self::new`.
> 
> Not really applicable here, but you can also provide a `Default`
> implementation for `Self::new` with no parameters.
> 

I'm going to post a new version, v7, later today, that will
change this area around quite a bit.


thanks,
-- 
John Hubbard


