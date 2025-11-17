Return-Path: <linux-pci+bounces-41464-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD29C6673A
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 23:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 28D24296FB
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 22:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7046F2BD5B9;
	Mon, 17 Nov 2025 22:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="il9jxIzn"
X-Original-To: linux-pci@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013028.outbound.protection.outlook.com [40.107.201.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C341927E060;
	Mon, 17 Nov 2025 22:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763419454; cv=fail; b=Z3Gpygl8YxUJ2+JjWeWiXZxMmpAecJug/0PQdNAiot3dML+598Junp7suOD52rmrlpy0nCmxM62S3k89R9VHW0YDsJptVse2D53QAnBo/e4tQVqpAVl3Q8r5LyGUyB2tegY4WycS291djvK3ByeX8RKDfmBnVbJnf8WX5di0Wyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763419454; c=relaxed/simple;
	bh=E1AcQmJXPVAN7Y1hZ0nc4+A1sTTfE1MVQDNN1UStHek=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RebuBmrxDAW4Au4jI7efPXV90HjNdjz2FD41aZ3y71rl3eRea9EEcBCY5YZJh12Iqe0G2vwaYOY3WoaCERqwzR59rOg1jGlEslKeGLMFEu2q+AmcLeN93hS+HW2w0aJkTrvnbcz82BxEJk6eLSu6Dno65fx/v5bXLBxgm72mtt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=il9jxIzn; arc=fail smtp.client-ip=40.107.201.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A1MbYCXMHrG97GwY1KhaQN4UurWc2gNpxgON/yst6ob2ITom4ImhazfM+aylgpWliagm8A8H4bdmZSZ4jVtnZE5QL2zFJxcgXuEeDOSqTnE1zPku5YJeCS1DcFti4eXeDj+lpnE/ViD/8nfphEXw93pMGSKTiQ9Pm/8lvMWOy+SezcvgF96fhZqxXMrTSmH+n+v1WfFf2nzu+Qw5mNqos6NeQ6GxptE+00gDc9I4cwqraHQsshNQpUYEU1QG5/QSrLpj1usnPhlakns+VV5/1jjX19Zp2wPKA2zzowLU5Y08e+wJWo7TVC7Zx0KC8Kyiqz8wrs+Hghlx7IDouNzzsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZuoLxCnm6QPKVzFCHYoaiWZc5zCasz0lC6KExw286qU=;
 b=dqCrdF2h3CjQ1WST8LV0KvV3KmAbINnnd7Z7m+N/p7qdhOZMBFuKiNzPsWJ22qdmLhuKk62Pga9+VtZWhdqzHRmVTd7SiAOWWng0nz8tvDqjseTrfYXAcUGhS8/u4xogzw1f9x3RUVwLOrOWMc8jdJ4SCEqkWfMUea80odBxczyM3EhdmVKVXessvPDToWNgjXlz9y8q0053fcD0rAiuOosg1aua9rsXu8RhIElClRfs30VKEnKxb2upSaqeZa8OIpdNAI2uxiVqYSeI3OE7oG4YpmwpMMrma5gVJb4J00m8WhNPP2qc+1aTEvUv/rmmzOnxE/XwL8V9tsX+04AB9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZuoLxCnm6QPKVzFCHYoaiWZc5zCasz0lC6KExw286qU=;
 b=il9jxIznEL1zfI1HDcYEaR9ryBLYRID4ltkQ2HBYH+ejo7m6Nbks2WkkFb2PViWKJckL/tqmjvZDvSQ5MiFONxyWXL/z98Jf+xgGJ8tjSgQqvAvyxYQ3R/QymRvqogpVtkm9IyJ1WHbSYvKqcoreqtvNNKuS1/t0mGVddTzU7v3kBXn6JEcWwMSAI/EuHTIWmv9ZUdDXXBe8v6n5YnLf8XE3XliuADRNafNYs6FyVolh1oQvb7sZUkX6fs7C0634TmaXCLp2tVYnaxeSWmRkHbXlvDunprzMSIhmHzW5YAl3DqzHHIrSX6ppqaz617V91HxvLI2qCmoePzk0EpIpAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 BN7PPF7B4E3DFF8.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Mon, 17 Nov
 2025 22:44:08 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::d622:b3e9:bfe1:26bb]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::d622:b3e9:bfe1:26bb%7]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 22:44:08 +0000
Message-ID: <7b30a8a5-ec0b-4cc6-9e9a-2ff2b42ca3cf@nvidia.com>
Date: Mon, 17 Nov 2025 14:44:05 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 RESEND 4/7] rust: io: factor common I/O helpers into Io
 trait
To: Alice Ryhl <aliceryhl@google.com>, Zhi Wang <zhiw@nvidia.com>
Cc: rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, dakr@kernel.org, bhelgaas@google.com,
 kwilczynski@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu,
 markus.probst@posteo.de, helgaas@kernel.org, cjia@nvidia.com,
 smitra@nvidia.com, ankita@nvidia.com, aniketa@nvidia.com,
 kwankhede@nvidia.com, targupta@nvidia.com, acourbot@nvidia.com,
 joelagnelf@nvidia.com, zhiwang@kernel.org
References: <20251110204119.18351-1-zhiw@nvidia.com>
 <20251110204119.18351-5-zhiw@nvidia.com> <aRcnd_nSflxnALQ9@google.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <aRcnd_nSflxnALQ9@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0020.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::33) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|BN7PPF7B4E3DFF8:EE_
X-MS-Office365-Filtering-Correlation-Id: a82d86c8-cea9-4699-4db1-08de262ad1d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bjU4NkVTbmM5YjhxMXhqSTUveThHcmc2QXU0bkVOeW5CV25rQ3J4bEg4ZERx?=
 =?utf-8?B?VmNuQlpZcUNjOFFqa3U0ZVdWaWxUOXJMZTRDTEJRY09ZdWNHVFFQbzk1dW1q?=
 =?utf-8?B?QytnS1ZCaHFXUitnTmlwS1Y1bjB6dGo2TTdqSzBjd0JMWEhZOTVmakUvVUZR?=
 =?utf-8?B?Q1JwMUVHamVSVURZd0R4dC9WYUR5bENTVEpuckpKZTM2Tkp1c21ZMDNZTGNs?=
 =?utf-8?B?TG5JUmJmWFJWRHJ2WXUzNkpqWTh4Y2xXVjEvVzNGSndVMmplVGxqZEE4UHR6?=
 =?utf-8?B?dVFXUkxnNzdoMkN2SU5XZ3ZhNlozOGVxSXA1OUdBRVpPU2lyaXZGZG9hUE9q?=
 =?utf-8?B?S3ZLL1Vpcy9Ta0drMjREQWdtcTJkUVo2MHIrdkUyUllxVXorRVdkakYwUzdZ?=
 =?utf-8?B?UlZlbHlrWGlaMXdHZUNtN3gzU3JNcTgyR2lUaG9pOG1aSXMvS1Z3MmtsWDRG?=
 =?utf-8?B?aDBvSWNkZk40RTQ4Yms3UWZ3b0NGNlphcWRsWTQ5Mkx1V29FQzlwOEJubnlu?=
 =?utf-8?B?Qm5vYkYvMFVEaVFJcW5Ed3I0RVpMcFRBQXhWTmtkTHRnYnVEa2VBUDFGYmMw?=
 =?utf-8?B?cVUzbXhjb0pmc2NLcXhLaTdzRjhqM1hCMWViblR1Z0tlZXR1a1ZwKzI0Z0pO?=
 =?utf-8?B?VDZSbWVNYU1jWkk2RTdBcEZ3T3YwbFhoWnp6cldnNTJuTXY0ZmxFdk9kazhj?=
 =?utf-8?B?c090cWZnQlczb1NQUUNZMkVBQjJQRWVSYm8yTEZMVElvV1UvMlB4aGgrMEhB?=
 =?utf-8?B?RnRaaFVwaXZOOWhIQUZPSElBc2ZoL2hyU2FJMXpBbFNqZndOVlJGT0plalFS?=
 =?utf-8?B?cytWNll0dFREMTVLeUQ4SkFIbjJuSTlHVzFybDJldkxaWnlzOXdNSW5uVjlq?=
 =?utf-8?B?RlE5djFYbC9kdkpuTnFCalBEcG5GNUMzT2NWbHNiNTB1T1pMdjljWFROSlFh?=
 =?utf-8?B?ai95d2tEc01BZXpUL09IUytidm9haGlsMkJEa3hkcS83ckpCdjEzdnpQM3Bz?=
 =?utf-8?B?d2Q1QWpsRmVhREI3Z3lHdlF3VVVsUjJIMFdXR3Q4QXMyNWVsTklIb2V3S0lX?=
 =?utf-8?B?K2l6UmVyM0t6YktTMzQ2dXBvbkVMeUtqbm4rRW5IRmo1SFZtWUlJNTZhKzBZ?=
 =?utf-8?B?LzJ6OGF1U2kydlZHeGY3TEpEakpGMDYydDhxeHhZSnN6UGpRNFB1Ni91akRS?=
 =?utf-8?B?TDhsY1RIUGFhR3E5NHlqQkd0Y0xXK0hycEFmYk5iWTdRamdlZUdDZ1QyQ2xS?=
 =?utf-8?B?RnNOdVhqMkxkUkhsUFNaU1NwSFZ4VVFOWHVMbzBRd0VjWmZ0VmZPQlVFNysw?=
 =?utf-8?B?SjFRQlcyaDFueFpzVjFoNDdQSTZqSjhYbzBKdS9TS2VvWmZ1NVB4aHBMWm9x?=
 =?utf-8?B?RUMzWlN4aDZLaE9yR2doYTVNVm8rN1R6ZzBOS3RkdVdkejAzL2NrQWdENjNC?=
 =?utf-8?B?L1dQZFBoYXBCVXFpUEY4TGk1VHZMcWV5ZW12cG5qM2k4UlloL082OHMvOFAr?=
 =?utf-8?B?VGlCS3lWRzBvY08zUjhlYnJVRGpwalJLTmFYV1I0VGVDU2dXZWNKYnppZFo5?=
 =?utf-8?B?a0hvcWNzQVI1cUs3Qk96U01QeStybFU1bkhGa09ZSEY4NXUwN3RocWk3YVJY?=
 =?utf-8?B?NGlia0xnUjZrRVhjaUdHQjdlaWpMR3lDL0F1bDFZaS9XdXJNZTBPeVNmbzkx?=
 =?utf-8?B?Y0s2L2NUcmhZWThZTjgzelN2QXFJdzIxL3VPQXdvRnhBRUpFc3lQQ0tyMkMz?=
 =?utf-8?B?YWkzVmo3VHFIaHdBSlhxVk1lbEFZY3UzMmVGSTQvVG9BM1BZZzQ4SXF3YjM5?=
 =?utf-8?B?czR6M3hLYVZuQjdoblVTNTlHVHl3WVJkbktlVFpLQU1FM0dKV0c0cEJjT1VM?=
 =?utf-8?B?Nks4S1A2WGRHbjU1azVGYVk0Q0JXUkgrWTI5WUVCUWJ2cVg2dVV5SnJvNkRW?=
 =?utf-8?Q?YR7PXttS0kF2bgo6obSeOhuPzqGk7o7q?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR12MB9416.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVA5dHJNOXFmRkNHTzJDTGRhdmJHQkk4SlM1enRja3YzRG5nNE03OTBwMG11?=
 =?utf-8?B?dnI2SmNwZUtXSEhFNUJLYVh1Y3A2Rk5yeC9oSm1ySnVISjBUZ1B4aWgxZ0xs?=
 =?utf-8?B?RDR4QzAzTWFXSHJoRTlIaUludk9CczUraTgzS25obU9hZ05YTmFYYzdOZmRU?=
 =?utf-8?B?ZnU4ZVhpRDZSQmhHVVZIYXEzT0FFRGROb3QzNElSbGRHVWV6aExSUDFUWnVy?=
 =?utf-8?B?cDR5MzdqczZGUEhmcy96TW1nZW1YeUNSV0lVcTB5YVowcGlRaDZsd2dwMEZW?=
 =?utf-8?B?U3JQVVpTenRzTW93MWtXSkNYbFBxSXZCN0pMYTlpTnl5RmtETHV1SjJISVc0?=
 =?utf-8?B?VXVBa2Y5QVVrN25uNGRXZExGdVY2WXgyZ3I0eEowdm5FU1psdlpnYXJHZk1m?=
 =?utf-8?B?U21tT0xzM3EvQTNYNWlSUTRwR01odzN3SUFYSTNsMVZwVEs3OW9YeituTnR5?=
 =?utf-8?B?T255ZFJHQmltcWQxMkc3Mm0xZ0RxTDdnZW9wKzhMU3hpODNjT1ZVVjhiVWdC?=
 =?utf-8?B?eHVJMWJiV1RGOU1FOUZTYitlM250aXdpK0ZOdEl3VkN3MWlVSENGU1Q1dG43?=
 =?utf-8?B?aUk4NHN0ZlcyTDErbVJoRk90UWhVaGlPUzlsVWdJdzBuUFhHTVhaMzVUZ05o?=
 =?utf-8?B?dUtrdXI4SVRjbzYvWU8yL2ZjcDR3OER0dk5xdzhiUEFHOGZtZFhoSVpUN1du?=
 =?utf-8?B?dG5nQ0JraWtKdGVVczQxWVcwSVZkS0lzVUJMUmVaSnJPTnNIZHBvZVI2Yk9x?=
 =?utf-8?B?QnZHcXRTZ0trb0xpd3RtWDdsK3lCcCtSNFFvVW9RcVBGWktRU3VWRW5KSzla?=
 =?utf-8?B?YkVaMmxHQm9tV3lxVVZ0Z21jK0lKbWdHb3pYeGUvS0twZ0NKVVZCREhpTTNR?=
 =?utf-8?B?N0pQTGVZRzVJMEYzTmpDZmp0T2NNRmJGN08wSmpTdkdQc25KQ3o3cldQTkF5?=
 =?utf-8?B?NWJzWTVaMUNJakRYdml2RVBqaUNGVldlL3MwdFFKTlpiMnEzR3IzK0lsamxj?=
 =?utf-8?B?cHAxZUp0aURqYTcwWTNQMVRSS2k0Tm9CanVHZWgza2Rsa1dYQjZRNHcyR3VO?=
 =?utf-8?B?a3F1Q2N6Tm8xZGI3YUNtUExPaHZhZ2Yrcm5Sd3doVDhQUG5lS2pyemdHaFRO?=
 =?utf-8?B?OXVXcDJyUVNIbHIwYzR4VG4zNWJVZkFBZ0dKeGozZVc0bkhvMU93QzdJTVFq?=
 =?utf-8?B?cXdYTVdoWUorUDVNOWIxbTZDWE10bWo4dUNadFkxd0ZMcnVRNGF0RGRSU3oz?=
 =?utf-8?B?ZVN3MkdER3dMaU9HMVEreGROa0hXRUxvRDNvbUkzZU9tWndMWlpPdGo0ZEZj?=
 =?utf-8?B?cUdhTlNHbzlyZmxpVUhyWlNjRVpqeFFmSG5iNGNCMThmRTRYZVpncVJjRlI1?=
 =?utf-8?B?RTJUSVd5SFcwQVQzQWtMaXB6QVA3dXVWUk9zeDg2ZERWeWRXYytReTFuTkNC?=
 =?utf-8?B?SHp2U2JPSXNhdC83UkxpeXZEdW4wOTBUcDU3WE5DR1pYbHo3VXFoeUdvMGtO?=
 =?utf-8?B?aWk1SHlPSFVhVEc5ZDViNnZFWG9FZGFFTFpXK3N6RFF6OUZEampyS2lOcHYv?=
 =?utf-8?B?eUljaFNDQnVZSUN4TzJTTDBNTjdoYnkxMUhlVTQvR3pmdFp5eEZqN0pXZlVY?=
 =?utf-8?B?dDVvYVYrU0YwQ1I0OFhhVXdUdGhoSk5SaWZJTjVsQlg5NDY4VS90Y2xlNm0r?=
 =?utf-8?B?ZE1GS2RrdW9DbENxVzByQ1hrS0p6bmFZam43YldLQU5SU1IvenNwWkdUbE0z?=
 =?utf-8?B?U3VsSVpCYXlJQVRZS2NUWVJYVHg4Nzd3Um5PUk5xdTJJYktDVlY2eVpkK2x5?=
 =?utf-8?B?emI0Skc2YU1FVkVrS1ZrVXF5OXBESHB6SXRudW9NbW5rQUhJTE50MzlMaDNs?=
 =?utf-8?B?azJiWUR1YmlkYzZsdVRQdDN4YWVHK2xCK05RakhNT2ZBOWliNWhURWRERG1B?=
 =?utf-8?B?bTlOaVdlTFN3YUk4T0hydjZoa1dwdU8xRW5sNXpjN3ZadE5GSGc5K09WV05w?=
 =?utf-8?B?OEFiM0VnemFkU1IraTRsOTU3dXJHWVNtNVY2RTliTW1pbVBlaGZDVi9GdnZN?=
 =?utf-8?B?SG9iZUV5Q0pnNjM0eUgzSjBoTEYzYkVTb25nbFhsd212cjdhSkZDS1UzNWNM?=
 =?utf-8?Q?KN6wjG/jlHxRLpS0p6mcS6HfW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a82d86c8-cea9-4699-4db1-08de262ad1d0
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 22:44:08.5529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UDTj5Rq2iwBmrhRggD246+/yrUhOTPfQK/fuiCcJQqDOnXgPJ0p6D9CujT4mRW8f/IxB2a8rpOgfGNXfjAyjHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF7B4E3DFF8

On 11/14/25 4:58 AM, Alice Ryhl wrote:
> On Mon, Nov 10, 2025 at 10:41:16PM +0200, Zhi Wang wrote:
...
> This defines three traits:
> 
> * Io
> * IoInfallible: Io
> * IoFallible: Io
> 
> This particular split says that there are going to be cases where we
> implement IoInfallible only, cases where we implement IoFallible only,
> and maybe cases where we implement both.
> 
> And the distiction between them is whether the bounds check is runtime
> or compile-time.
> 
> But this doesn't make much sense to me. Surely any Io resource that can
> provide compile-time checked io can also provide runtime-checked io, so
> maybe IoFallible should extend IoInfallible?

IO is generally something that can fail, so this whole idea of infallible
IO is making me uneasy.

I understand that we're trying to wrap it up into a bound device, but
bound devices are all about whether or not the driver lifetime is OK,
not so much about IO.

For PCIe, it is still possible for the device to fall off of the bus, and 
in that case you'll usually see 0xFFFF_FFFF returned from PCIe reads. The
Open RM driver has sprinkled around checks for this value (not fun, I
know), and Danilo hinted elsewhere that bound-ness requires not getting
these, so maybe that suffices. But it means that Rust will be "interesting"
here, because falling off the bus means that there will be a time window in
which the IO is, in fact, fallible.

Other IO subsystems can also get IO errors, too.

I wonder if we should just provide IoFallible? (It could check for the
0xFFFF_FFFF case, for example, which is helpful to simplify the caller.)

Again, it feels *really* odd to claim infallibility on something that,
almost (but not quite) by it's very nature is going to generate errors
at times.

> 
> And why are these separate traits at all? Why not support both
> compile-time and runtime-checked IO always?
> 
> I noticed also that the trait does not have methods for 64-bit writes,
> and that these are left as inherent methods on Mmio.
> 
> The traits that would make sense to me are these:
> 
> * Io
> * Io64: Io
> 
> where Io provides everything the three traits you have now provides, and
> Io64 provides the 64-bit operations. That way, everything needs to
> support operations of various sizes with both compile-time and
> runtime-checked bounds, but types may opt-in to providing 64-bit ops.
> 
> Thoughts?
> 
> Alice

thanks,
-- 
John Hubbard


