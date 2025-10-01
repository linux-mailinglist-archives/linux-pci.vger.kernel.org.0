Return-Path: <linux-pci+bounces-37381-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8BCBB2164
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 01:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86E5119C5642
	for <lists+linux-pci@lfdr.de>; Wed,  1 Oct 2025 23:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5D7283CB5;
	Wed,  1 Oct 2025 23:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hTNxvbXH"
X-Original-To: linux-pci@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010044.outbound.protection.outlook.com [52.101.61.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB83B2222B4;
	Wed,  1 Oct 2025 23:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759362747; cv=fail; b=sLjpfgo986kFVLA+brJkPDwpwrY2DlK9xsdlsrVqLnRc86kwelnkGu4x4Ftzd9BJIznP9GTdLolxuqPXnQBzYsSftWCoQupXH/RKm5vuavjamnMzSw7SnkIkbLE+G/RJzLHCl25WRhonNjLFVm7W9YfFUyJJBHof2wKhKGdjGJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759362747; c=relaxed/simple;
	bh=OiHSgRox4CTxnaTjaxuRFpHx9GFpPDFthNrhbFVF80c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q0S0mtiIUcuIk7xmFZXKFTRvn2GkTN+g0sLn8cYB6Ks72BerP+YnEFDcqn3UWEAsi09b62G3E/P77d7DR+TrugJEGsIQnu5pzULpAfM3nuR9ybo3CEy+nLh/mhc8EMp4OPEWlS+6YGVsCQjrXt8fGxgn+CkKQYgJ1uzCOO5kQVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hTNxvbXH; arc=fail smtp.client-ip=52.101.61.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FMOoqoTzlhrpr16n0Wp4U0k7bHZK7HaD7PKyu6BdSq54x0fdr1CLEVxytVE8m17hlMX1zzX4DSybpHbE68x4PZ7S3ZVvXJuconCZpQtb+Ms31GBL4tB5ju1RmXA09lqjDPiUwEr8eoD8zksnE+L9DL9v5nMnbnu3U5k/4+7PQUwcTPfwE6XFYzlmdc+XSInhxsrE51XiwqWw8qN+pNBZd15UA6jq0lFsCCifbJTDrqsOq5Ttd0rSTFpsIe0jv3CwK9wD2OmjOTa03a+qcmOTulH10VpKsPw+5mAY2Yd6iCIC0k0DqEpsC6me7yxCmt+o/7mptT2lz/FNh32677K5MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1PxLNikme6Lp0vkYz4puVZ0qT6u1oXdg1FkmEs3UkQ=;
 b=jSGZEBerVLykOKwkNSVAx2Q497mpMpOR81B8Mac+ZzuJrn5H8gumlGD5MCzJRVTXbL3qFT8oC146Srxs4fnBdTnBE9ZPs4PRHIFJ5+sXjMlFzuJeoMeQPNuVHqb+gou5oooTJfN1CsQos0D/LAJwS1P86t3jYjlblDbWAy+4veOahBsKrSl0qOQ1XRvHb9Pp1DBTH/mU/bybwDDGePqDKSEiNP9My4XBF/P5ZqKJDa8jDeI2mFFjCONnCTC7ToGZAtGY0/SD/M4dQYse11P3XJjeRtj3MfEfvlvWwsum/HKKNZLwE9oXINnsk/03Ft+SQ/+hBrPOFN8QqXVz7iflXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1PxLNikme6Lp0vkYz4puVZ0qT6u1oXdg1FkmEs3UkQ=;
 b=hTNxvbXHtflk+46WOqo6xod411jRejvq7SSN5Hoj+Bm0JTsk6ch3orUI83KeMA9SZfSBfiMkkhVByGbohqsq3D5qfY8TEQYv7hxhNtEhjhopcErD4ec7dvXSeohQyOPwQW4eb1iH5JecHEpJM8xlMbRMyu0Tlg5tkXdfawZj5I00Ih1ZpJDDku+B20F5FzNtcRMOKNqroXsiGMTZ9PIOuJo2Tiwo8Fn9BeQ3q7yswDCX4z9TdzTJHDsvPlLGa2DJPon9UJtjSI9H5lnfzyFLGIwscFp4x4NEHX9wNO2r3iTj51KIhgmxg7PHUF3sETkfVrR42s/MNsz66wAU4ODy0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13)
 by BN7PPF683A477A9.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Wed, 1 Oct
 2025 23:52:21 +0000
Received: from BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4]) by BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4%4]) with mapi id 15.20.9160.017; Wed, 1 Oct 2025
 23:52:18 +0000
Message-ID: <a7bd8285-922e-446f-9b43-a67fff67a505@nvidia.com>
Date: Wed, 1 Oct 2025 16:51:42 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] rust: pci: expose is_virtfn() and reject VFs in
 nova-core
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Zhi Wang <zhiw@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>, Alexandre Courbot
 <acourbot@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
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
 <ae48fad0-d40e-4142-87d0-8205abdf42d6@nvidia.com>
 <DD7CREVYE5L7.2FALGBC35L8CN@kernel.org>
 <e19781f3-1451-4b4d-b4be-c71c9ec8dc63@nvidia.com>
 <1FA2746D-6F73-4D5A-A0DC-803D0563A5D7@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <1FA2746D-6F73-4D5A-A0DC-803D0563A5D7@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR08CA0024.namprd08.prod.outlook.com
 (2603:10b6:a03:100::37) To BY5PR12MB4116.namprd12.prod.outlook.com
 (2603:10b6:a03:210::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4116:EE_|BN7PPF683A477A9:EE_
X-MS-Office365-Filtering-Correlation-Id: 976011c3-2291-4239-5dfb-08de01458e47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?emkxS3Z2bjgvT3ZNellWbW56M0hoVmFDWjNHOSt2cEd5d0Jvd2FramU4Szls?=
 =?utf-8?B?enppWEdPdkNXUjFudlcrTkYrV3JUWDFzNWgyUlZ5WTdwcFluczdGMk9McUZV?=
 =?utf-8?B?MjJDaXRMUm84b2M4V0JkVENidGhxcm40QVo2UVBlRUQ2U3J3c21CU1hqV3Jt?=
 =?utf-8?B?Wi8zMUgvZHEzMFdiUDFYK0xoWFBKNlpxMlNhcmhEZmMyY1E3Sy96YUlURFVn?=
 =?utf-8?B?VkJFSmwrMy9ERFpETEhiSkswLzF0V1Zpd3FkZ1RaNU5LN3E0YTJEOW9MQkxC?=
 =?utf-8?B?Y3NLMHExYXFBRHN3VUU4UW54ZVBoQTREZW4xVDMwRnRyWHplOVFoTnF1TEgz?=
 =?utf-8?B?SHk4SFpLbGlwTm1WOXB2bDE5WWdydWl4UkZKRDVkWVp0ZVpvQWIwSkxoNldr?=
 =?utf-8?B?dHVsanNRdEthWkMxc2hrL3pVSFQxeExTVnRyRjhFd3N6LzhXU0R5VENrL3gx?=
 =?utf-8?B?ZVcwampxR25acXh5VlN5dVJtRG95R2tySmxlZ1dNVk5KNjVYWWphKzNvRDls?=
 =?utf-8?B?engyQ3cwTEhKZ2tJNkRTTzZjcUt6RmR6WDVlaXUyTi9ySVhRbldadXhxS3ZO?=
 =?utf-8?B?SEhpUmhvQzV2UlNlL3k3OUtoQUloaXl3emJHSTdjM2ZXR2tYblpRZ09NN0hF?=
 =?utf-8?B?dTR4UkE3N0lIdjYxK0RMei9ZK0IrVk1RRVJocDhIb3Ria1p6V1NIaU04QXdL?=
 =?utf-8?B?ckU4RnUrZmdzRVJDUDFsVU9FSnFtSDRlOVNnUzVva01OelFsR3ZQV2FrNGJy?=
 =?utf-8?B?YTJ0WUlqNDlEOGYxZnVGNE5JRVJ1ZHpOK3o2Z3g2MHBsZzlqMHA0TUZpQm1a?=
 =?utf-8?B?bytMM2VYMUJSN253dXl6dHYzdmNua0NRQ1o4NURSUkZ0elFUeU9MTFZ2Y2ZK?=
 =?utf-8?B?RmpxVnc0TmZaZ2cwMEo1VXBxd2EybEk2bTM4ODNaODBoVDVDV1RIdEUzc1Q4?=
 =?utf-8?B?dDFJb0NvUGRxd09Id2wreDZMc1JDdEtwZ1dhS3k3UGFSNTlYNGR4YTNZcEFJ?=
 =?utf-8?B?VXJIRy96Q2VTKytselcyeWJ6U3BvMzJNcGhTVjFGVDdlZHFtMjA2enN1eUhp?=
 =?utf-8?B?Q0pCdmNUV2pycEVoa252c1pLZmtPR1hoZis1RzEyTDBKTXVmMGVsdjcxQ3Jn?=
 =?utf-8?B?NlJjdTNZdGplRk9yay84UEk3Wk5qWGNreFBuWnoxUjlkVFI2RnVXOGlVN0ZJ?=
 =?utf-8?B?cVBNVHJnNlM4YlN4cE9HVlUyV1VjTmljSUh5T1RNT0w4bFlDWDJTeXV0QTFx?=
 =?utf-8?B?bVlGS0JCOW5OWDhhb2Mvc0tGZWZxU210bXRzZHBXNVpycDFnT25VWWNub3JJ?=
 =?utf-8?B?VndBbTZUMEp0SHZtOXlmb2htUEJRWVhtUUxoNVZiaFR1QkhOWTdwSUJwZlpo?=
 =?utf-8?B?OWFNZlY3YlIzdHJPUllwcmplL3R0MU5CV3hub09PUlE4c2h6Znc4TmVJL1Nz?=
 =?utf-8?B?eXliV0E4d1A2RG9PMXZJVDB6a2xWVitMamQyWUsrNzJFQkFMWFA2TkNiL3pW?=
 =?utf-8?B?cWhmN1p2Yk5NSmZ2NHg2R2NMbmRuTk1XdU81Yk1CV05ER1dqUWJOUmg5Rk1U?=
 =?utf-8?B?WUJMSnJxNFpPMkEyVTMrcUxNY3Z6bGVmajJZeTZ4bnVNanEwUTh3VGsrVFkz?=
 =?utf-8?B?dFhUN3dnbEg5RnZrYUFZczk0UGoyengwVGNjRDBnRW9zaXRPTnkyaTJCejVT?=
 =?utf-8?B?QlE3MXM4bmUzekxSMVdTbnNCQkpFZE9qaEpCTXdub1ZnVzE2U3c1c09YUkh6?=
 =?utf-8?B?azNraEdhdVE5SEV2SnRuMzA1MkozLzJZQnI3WDZsRDVVMVF0VjdBaUtOMm0r?=
 =?utf-8?B?R1c2eUYxR3IraFZEckVxYlJYNElDT0l2cHFXV3hoTGdJOWRrSXZ5cEdWeXMr?=
 =?utf-8?B?cXgwTEtYMXhkMUJOOXh1YUVXM1gzNkJ4UllUNWRLM0lxbklLa3JrajI3TDlo?=
 =?utf-8?Q?VTAqCuMKtbATjVmO5D5XPSQTeN4f6h0c?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rm9TYzJjaHNWM3FzTllPeTFqYXhXOHBFVFFZZmJ2M084OEpxYmpabDhYdVVX?=
 =?utf-8?B?TTh5WnJhd2NXWE5laDVUd1ljd0xnc1J0dGxuREd4TGpDc3hMM3JkZjFJUldM?=
 =?utf-8?B?dkhZQXl2UWNTMkRDVU1nclIrKzYyeTl4dEJ5SVlwV1BybWVaQkNnL2VmS1k2?=
 =?utf-8?B?ODhBRXJtTlY5L1A2amR0L3NVQVEvOXZVMVRpK0tOdTdUbUJDSi9FUjY5N1E4?=
 =?utf-8?B?K0dPRkR2V3R4Y0loMjdJUEVxVU16N2RsMlE1YUpkV2tBcGpnR0o3ZHMzWjAv?=
 =?utf-8?B?TlR5cjBIZWxraWZPdHZyVk8xRlJPNUd3b2pNYkl1ZTZscnlDc1V6VFJ6L1ZY?=
 =?utf-8?B?aVd4VndHaVpwWkVuU2ZQRnZnd2xsU1lLUm5tVnh0TTNDcEEvWW5WWGxINmFU?=
 =?utf-8?B?aExwUHMzS29vajdVTjhmbFRBZWRyWk8rUDduVnN2ZW5NSXJrc3R0bFd3ZTFI?=
 =?utf-8?B?bjBoNmNiWGkvNUpyMUErMXp3SDd2RUJmNC81S0o4SFEyaTZCcENralY3KzU5?=
 =?utf-8?B?dTErYTF6ZUxDVVB6R2hJcURxdG9nVkc0V0JoUTFNV3NXQTNIYXYvYyt0K3No?=
 =?utf-8?B?dTRPT25TcjNQRHdGc2RyeVhqS1RLUDQvTHpSaUtQY3dRTElVdEVnYzJacitr?=
 =?utf-8?B?V2l1ZE9Ed21SUGNKVURwWUs5OXNvdGQ0eWlIa0hTSkNkL0ZBc2I2ZTdZVFhi?=
 =?utf-8?B?T0JIQlNCM2QrREh6RHZtWnZFcFFheWx5ZlN6cEVwYW15RThSc2h5QXpIMzBR?=
 =?utf-8?B?Q2JGQi9Zd3R4a21lY3p1dmN5dUFBcnhMb0NibzFhbTFmWkZOZzlZV2F2VEs2?=
 =?utf-8?B?WnRlWld1a2tzRHJGNFlHSXhleFNRbWZNbTRRSnBjN1VpdVA3OGhkMUFJMXRE?=
 =?utf-8?B?cGxwWkRyMDZ0RzlkUVR0RFprMEtwSktaN09NT2d2UFJMOGo4ejRyZ1FiNytC?=
 =?utf-8?B?QzZHRnE3eXhHbkpBYW42SC9RUEkzK2RpTUs0MDFzdVpzalB5aUZXRGxvdk84?=
 =?utf-8?B?dU9zUW5HNENuTTdJbTB2MGtQZnNLakhEZFJIem9WRU44eUlzbUpSSUErTHE1?=
 =?utf-8?B?VGVBdkxLWFUzWk1ZZEkvR1djMGNrWUMvT2lJNmlWYTRjdk9aL0ZyT05Lak1N?=
 =?utf-8?B?Qzc4VTVHbWljcXpxYWVlQ1FUSVNzRWJnRk5HWklDRFp5bStYRUt5TElydFI1?=
 =?utf-8?B?U0JwbW4rU0ZLdzRKcnBuTXJhSFJZUHc1NDVlQTcrUzN5NmtyZHRsbk1YNlBD?=
 =?utf-8?B?dFNvQzltQkE0RVNhbWU4NGVnd1lOWXdYK0JjVEpwMjIxZm83aUxyRWdQVXRW?=
 =?utf-8?B?MW56V09adU85QUJ0SUNUWFJPcThYRFZJRW9ac3hMZ2Roa3NFUWVPRmJUT0FU?=
 =?utf-8?B?dWIvT1RnU3JkNHJ6Nzc5OER5bUd4YUYzdlFLZkd6WjA4YnkzR0VMcWRUbVd3?=
 =?utf-8?B?cDU1ditwNFI3UWZ3UTBqbkhrL2swQXZHZDFXbDJEbmwyWnJHKzE0UXg1aHJZ?=
 =?utf-8?B?OURNQmlNVzVDd09MNlQxdUxqWk5KV2JmWjZBV2hkN1pGdnM5UWdEUzliYTIv?=
 =?utf-8?B?OXp2Qy9VMGx5SGpreGtSSlowemNOTVp6elJtcUZNWmhjZGNoV2YyKzc4UC9S?=
 =?utf-8?B?bCtCL1dDVk9tTlJzc2lpZTE5ZmFzNTZSREg2SnRHZ0x1RWUxdXNETWpwcnBV?=
 =?utf-8?B?NFpyS3A3aFM3Y0VQdXNrL0Z4cGkyVWdNUnFHZitheUMxbmtqK1VmQ09DWS9D?=
 =?utf-8?B?UEN0dy82NXpRdGc2VjdJOFVpdkw5MnlnRXhWelN2QU0zRTNqUUdRcGtjQ2tx?=
 =?utf-8?B?MGtiNkwvVnpBdUxySEJGSStEZmV1aGVaV1owZ09BK1F6bENLdEp0RkRFa2dX?=
 =?utf-8?B?L3dTNVp4ZTBkYUdMUlE1TGJzMnJ4Q05rMVdiZ3JjOFQzUHNDZ1BHWnJBMFN6?=
 =?utf-8?B?eVBvZDlsalQ0TURqSzJuRms4WDhkcmpHWUlIVG83aFVUK0FOdmJJZTdtaFZK?=
 =?utf-8?B?VjRveWFNTG8xejBmakpNL3FrTFdtdTlVTzFuM29nem5tcFJBcEx3NlZQWkEv?=
 =?utf-8?B?eCtnODJ6amRxTGptWUtiUFVaU0REZ3YwYzRWR0JvY1NIK0Q1UEhMRkhWUURB?=
 =?utf-8?Q?VrE1BxLWuGpabhADcnwwsKiVu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 976011c3-2291-4239-5dfb-08de01458e47
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 23:52:18.6074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XikghwEzR2jEjzc0IhH1c6SnsNx/hEGrIpWsKmdS9eGDyl843TgeVqzjfh+9LJjsjcTvQZvLt5Xh7wMB0UlXVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF683A477A9

On 10/1/25 4:47 PM, Joel Fernandes wrote:
>> On Oct 1, 2025, at 7:00 PM, John Hubbard <jhubbard@nvidia.com> wrote:
>> ﻿On 10/1/25 3:52 PM, Danilo Krummrich wrote:
>>>> On Thu Oct 2, 2025 at 12:38 AM CEST, John Hubbard wrote:
>>>> On 10/1/25 6:52 AM, Zhi Wang wrote:
>>>>> On 1.10.2025 13.32, Danilo Krummrich wrote:
>>>>>> On Wed Oct 1, 2025 at 3:22 AM CEST, John Hubbard wrote:
>>>>>>> On 9/30/25 5:29 PM, Alistair Popple wrote:
>>>>>>>> On 2025-10-01 at 08:07 +1000, John Hubbard <jhubbard@nvidia.com> wrote...
>>>> ...
> Here is my opinion and correct me if I missed something:
> 
> It feels premature to remove the option of nova-core binding to a VF, since other options to disable auto probing do exist as Jason pointed out.
> 
> Taking a parallel with VFIO pass through for instance, the user already has to do some diligence like preventing drivers from binding and then making vfio-pci bind to the device IDs. This case is similar though slightly different, but VFIO setup requires some configuration anyway so will it really improve anything?
> 
> I quietly suggest holding on till there is a real need or we are sure nova cannot bind to, or operate on a VF. This 

I'm confident that nova-core cannot properly handle a VF with *today's* code.
There is no expectation at all for a VF to show up--yet.

Which is why I think it's appropriate to skip it right now.

thanks,
-- 
John Hubbard


