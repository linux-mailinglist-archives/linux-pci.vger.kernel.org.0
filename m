Return-Path: <linux-pci+bounces-42807-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2497CAED37
	for <lists+linux-pci@lfdr.de>; Tue, 09 Dec 2025 04:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 986A73008F8D
	for <lists+linux-pci@lfdr.de>; Tue,  9 Dec 2025 03:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC2A1CEAB2;
	Tue,  9 Dec 2025 03:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dp7KDiKl"
X-Original-To: linux-pci@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010040.outbound.protection.outlook.com [52.101.46.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122221A0712;
	Tue,  9 Dec 2025 03:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765251747; cv=fail; b=lrwOxCy9fQQ1iSf8ZjxBf5lugblWLXBCC7l5qQpbneDny8J0jWXITzseLMvIAdfZm76OBD9Be/eKmFJQ7bQj2i9vH8P9oZJjjPUEzv5TEwx9CVtuUR4AIgSCYeNpC5Uu3b+01b8SIhPcX4kvsNng8+NUeBWc5rmv9fnt8wyJd1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765251747; c=relaxed/simple;
	bh=C+I/tnN6t09i9Lpp5tBN2TKh1hmMjk68i6ulT3eCYcY=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=k0Iilj9Qqu+wWKQWNUosmrKGQNrHQ5BpEYlIjVFe5XtG5XYlBLnrlQyWWHdDCxETx9/bGF1d2MyQrN1ldlD/KZpOkVArhsdW6m6ITN/MA1TaGanNJTRhqtAOHDiU6t2YJpl0fOVTsxbFl8cd/y6qkevsNgSTfUDbVg+jzWoKOPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dp7KDiKl; arc=fail smtp.client-ip=52.101.46.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BkMxz8V5zfbTXlHmBqLxySOS7sMe3HfT9GYYmaxwcIMEkCmPf+osOLDnMuJ2N6v53dJskTKtd89xgn1DWx75CIE1k6ufynMKjczazBet2yhD694M4qZh8fB9K70NRQTulWJ35wbAvojNoai+nMyJz4XKDECc/L4xDh/ybuRBZ+9iw75O7SbUYjX0vbrFdmBMuOfXWczjTYWkCg6f3k0EyC8Ga7TjlykLUUQ+sIpJAqzPvLpCVfcJTFcHBy09Aogf0I3r3/nj8hhTRwUfGtmC5wDrL04Quu+L/oE5+HYMZUutPlRY4o6RNCrvJxTLb+/XyiSkumQV3pFHb5+Yo2olcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQNzs7wdukxT6Zk/nowmshFUYxjG+atedvEAPyJrQcM=;
 b=nmhKRoMZBN5LShZhjGoxz/nZwih5urVncit7F5kVr6VH5plNsCYWlJkVyoNRJLYtnRPar2Fr3nD/zqIDmq3Q8Sgwq/99ra+699+lzoJwm4Q4U9LpatoORDwt0oQn5ERf9SeV8b/4uf+j4Hs70hXGE3kMYgGS/0ZNobCo0wisaU5JSTwsncm8E272moTxbWRxgS+hlnwD9lJieEj4OLwC8ua4JCrM3W4Kow/VKLfz/YSGAIxC9Abc/+g9CG4VXd436EVGT5Dv3/WIxL3Ji2tQBTWGlFUIKflJzEAtSicu5sdB9HWNODjP1xhPUifVXXM9hbvi30U8DQu2B/Equj2QpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQNzs7wdukxT6Zk/nowmshFUYxjG+atedvEAPyJrQcM=;
 b=dp7KDiKljQYPQTkbAScp9sIclTMzq02LQpcumG27QnSuBUbJifM/xpnPwddJl6q5MfRPkhoECgXeNrIuaUYTvC5XleT/WHOpS+X2wYYdEzZf85ftBFlWECh3Ii3ZvDs6ZKuCrZ1kr50i3gEAXAsKuO9uluHl0ls1TNveTVYNEVFlDW+b/8Qz3TsZpa2p+pFXpil32Wfliy6vSl18UwqqEzA7gYIrbeY0Il8pHwvC8GT0oeqLtoCKC+WJ4s8WwZ8RDQmUBJ/ZsTywLHLsSKx8DzVTJeX+0BGKb6KpfYk7Zo+7ECLQUtyVwWyHt+d/ikhFv069SwX3oGZdXieutDuggw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH8PR12MB6746.namprd12.prod.outlook.com (2603:10b6:510:1c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 03:42:23 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9388.011; Tue, 9 Dec 2025
 03:42:22 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 09 Dec 2025 12:42:19 +0900
Message-Id: <DETDILPA1GFY.27WND0TEC5352@nvidia.com>
Cc: <airlied@gmail.com>, <dakr@kernel.org>, <aliceryhl@google.com>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <markus.probst@posteo.de>, <helgaas@kernel.org>,
 <cjia@nvidia.com>, <alex@shazbot.org>, <smitra@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <acourbot@nvidia.com>, <joelagnelf@nvidia.com>,
 <jhubbard@nvidia.com>, <zhiwang@kernel.org>, "Nouveau"
 <nouveau-bounces@lists.freedesktop.org>
Subject: Re: [RFC 1/7] rust: pci: expose sriov_get_totalvfs() helper
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Zhi Wang" <zhiw@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <nouveau@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251206124208.305963-1-zhiw@nvidia.com>
 <20251206124208.305963-2-zhiw@nvidia.com>
In-Reply-To: <20251206124208.305963-2-zhiw@nvidia.com>
X-ClientProxiedBy: TY4PR01CA0091.jpnprd01.prod.outlook.com
 (2603:1096:405:37d::11) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH8PR12MB6746:EE_
X-MS-Office365-Filtering-Correlation-Id: f2f1d7c8-1e49-430b-38f2-08de36d4f62c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bjJyb0duM1hiYWc1b1QyVmFDVWE2ZUlPc1podzhGaVhJVGVScHJkWXB3Y1Fm?=
 =?utf-8?B?NTNVRWJSQUJTOXd0K3V4d3h0TEhFRm5XM0ZScDRDY3JsZDVLVElKbEcrT0pk?=
 =?utf-8?B?V3ROLzNxVDNtT3laNkwyK2c5UEZLeUZWWUpuOTZ4dTJvK05HaWxCelBvbyti?=
 =?utf-8?B?OVFkYzVoSGMyOTR5YkM4S3lSODNyYVQrUVlHT3J1WGI1K2U4K2t5eHU2OU1V?=
 =?utf-8?B?dnNhMjJZSThVd0dtQS9LVHk2R2Y5Q1Y5QS9VcTNNVzZKdjJUcVhCb2M5RjRh?=
 =?utf-8?B?c2JTWERyRVZOU3dNakVNQkkydUt1aFpIZGx6NndIMFBPaFB4WjRKcmpWREkz?=
 =?utf-8?B?czFSUmh0STg1cDZMYi9VV1JJT2M3MW1veWI4YnhKNmhYT3MrMGpYSjVBRXZj?=
 =?utf-8?B?RUV5b2dNWmY2V1oxOE5SS2VCSWR3RmRTMW96TDI1QlZrS1VyVXZwTmRNdnpv?=
 =?utf-8?B?TFZXSXpwWGJUeFhmNVVOL0o0c1pJRUIySW5JOXNIZjhRQnBOS1lqTWJPZ1M2?=
 =?utf-8?B?ckY0cHVNVnJNcHdLbVBqbDFZSGdZQjJxNXB4bnlmLzljaU5oRmcveDVLUHd3?=
 =?utf-8?B?RTBDdSthVnl1YkVJOFRSUmRkWjc1UFlBV3dGUFpyNG85R1JoK2V5SGdrN1hU?=
 =?utf-8?B?dDIxejJrcWpqK25uNVc2QS9FeTZtR01pa0x5aWFYUlpSazk4Sm5VOWoyMXJo?=
 =?utf-8?B?Mjg3SkhPbGZla3lQQkxlYzNGR0l2cDZWZGM5SEp6NXBPWWR1Y1hySUlMb1lW?=
 =?utf-8?B?d3hwMC9scUdVS1RvUFJtVUNtOHdkMFBjSjdQaXZBM3NNVGU3dkdpZXkramtR?=
 =?utf-8?B?WjFnU2FjRGFXWFFVcFZGV0t6Q2JXb2F6YTk2MUZraXlhMFMvL3RWUEdkenkw?=
 =?utf-8?B?RUkvbDBXbnB0d01RUnc5RmlmMHZlNmJNdnNaUlJWcG5LUWNBcWhlbmluM1Ex?=
 =?utf-8?B?elJwWmorWnJzYmZQZm5CVEt0eG1weHR0UytGek8xZERXMkRKYkxaOWxDMXN6?=
 =?utf-8?B?N2xCeC8yZ2VPL0dUS05KVXZadUMrQTN5c0xnYTd1dWRyNFlibWJubzZ4RTBr?=
 =?utf-8?B?VVhsZVVTbjBsUE1ERVVLSWk5dURFd3E4bmc2cmxIMGxkSmhFY2xUdDkxUlFj?=
 =?utf-8?B?bmdyMlR6ZXBMRW1odCtMOU9OcWdKR2pEeVplL0RQSS9WZThtcTh6SThtbXBu?=
 =?utf-8?B?RGNzOFl6ZE9HRHkxT3g1UTZIc2FZczRTMzhwRFAyQm9ocnNRUjNaMmNHOTJv?=
 =?utf-8?B?YVZuZmRDbXg5LzNaQS9JMXp0SUJqMUpJTVFiZDJNTXJHNVB6dzVOakkzQjBR?=
 =?utf-8?B?RnpDcjVEN0hlc1JMdk4yMWdMTjFUZjRtTjc5ajNLRmhtZXpod0I1NVoyWjhU?=
 =?utf-8?B?Y3pSdURMRVhUREF5RnVwWWpkV2lMdDVQVkFuTHg4ekswOTBCa0RZdGxpbThm?=
 =?utf-8?B?c2NZY25aRUFCSG9ETlEyc2Q2NEQ5MVBEbnIveDRVNVJOM1BWV3ZZZ3ppS0ZJ?=
 =?utf-8?B?ZHNRM3hPM09OSUw3ZXpEWXBLN08zcCtJK1B0LzQ5UjdDaFZCKzQyQWExUVYy?=
 =?utf-8?B?S0c5eWJpYWFyeVFHNHhmVWczWXlDZTBxTGczVTQrTnB1MnRSMG05L2w1Mm5L?=
 =?utf-8?B?VDZ2ZWVlVy9KUEJBaklzSHIvci9neFVkdzM0Sk1hVUFTa2xqRzNyRVQrZzZG?=
 =?utf-8?B?R2k0T0xDSm1jUWxOeGRjWVlmMmltQlJPN2NuVGcwcFdHdDVZTjBtTWJGdmFJ?=
 =?utf-8?B?eHNFU3liNVRmaFFIM25GT2hPbDJoSFZZdVpIWFpueWtLdjh4Vk82TEFqWVlz?=
 =?utf-8?B?Z1MrYStQUVgxeE4xL2hCQmtLNEd1dTFCV2NhYW1qbU0waHdEbTI4Y2k1aDRN?=
 =?utf-8?B?MWMvcXlWNkhCRWw5ZTMxUXRkN3QweHdqdmk0TGp1d3FNSFdrajJUeEtmaHZj?=
 =?utf-8?Q?eo/zqlqpBGkDcjlyi/WrP+hRRSdkhFCJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnpuSlBXTDdOYmI1bE5NN1BCU0RYMnR3RHpRVGFzWVNzdjZZS3VnSENzSWM2?=
 =?utf-8?B?MzREUEJrZ1E3Ni9sTmFtVFlncjE3TkZDb1VyMjAwa3dOQWlwOGk1eURJWC9U?=
 =?utf-8?B?aENsdFFzemtDdEwzZHU0eHZwd3Z0dkM0a3BGNkxlSUhGdVpZMGRjdzk5WWgr?=
 =?utf-8?B?QW1zQi9DYmJ0YnM5MGJQVVA1dUJuak92TWc2STQxZVRjc3pqMEVqdXBERy9m?=
 =?utf-8?B?WXplcW9VSERYcm1CWmdueXJoUU9rc01XOHlPY0FHTUZ0Qi9RREtyTkJ6L0tr?=
 =?utf-8?B?dnY3bHhSWEhNNXVzVTZ1U1VySDBxWCtsT0dkdzk3eVB2TWtLVmJOOFNUNzcw?=
 =?utf-8?B?NDRoLzZMdnBJaEx1QStzd2FZRkN3UTZ3MGJBeWJWZnJxQjNsMmh1blRUUU92?=
 =?utf-8?B?bXo2OTN0aVdiQ1RjRzA4VUdFbHllS0paelNWMEdFakNCd3VtQWNKNFFLVDJx?=
 =?utf-8?B?SHV4d3g0Q2tkVHZOQ2tsK1N2elVDdWthRHpUWlF5dm5ITkptSEYwUUNyeWFD?=
 =?utf-8?B?ZFdOSjhrUHFsUGdwelQwcXNsWnMrYkZlMVFzOTRPMmlKa3l4M0k3UmQxNVFl?=
 =?utf-8?B?Y2VKSENYR2sxREpoYmhTQ0NlSE9NWlRiUm5ZNkFJOVVCc05NTXgzOFBFdXpW?=
 =?utf-8?B?SzJRb1ZocVdVcklBdmFrT3kyY3Z5TCtaK0RxNXlZd2RKNWQ5YTVUM1JKMXo0?=
 =?utf-8?B?Rll0Vk9jSGp4c2x6THhVMlArTExTdUcyQ1hFSkF0SVBXUVREYksxWmJQcU8v?=
 =?utf-8?B?dUx2K2VQNnE3NHl2aTdkYUJXNXdVVXlkR29yNTM3ZnJ2aXRKby92b2c0NGJz?=
 =?utf-8?B?NDdWd2prSjVxa1RjRGdENHp5ZERHZGRaTUlCd0dXSzJjbFdybStEUG1DeTVB?=
 =?utf-8?B?NVAyblpTRjNGNXMrSWVjYWR0VDd1TnFUaDZZVzgrS0NBelNES0dwTlBzaENT?=
 =?utf-8?B?Vy9zY2VadHhTWmdhTWVwR28rNUt0NUdFU3k4UXNmZXdWQkVDd3grK3NWQUVL?=
 =?utf-8?B?dW9uVTRGUndrNmZhamlkNmdXN1hRYUF3Z0NzU3dLWnFrYkMvU1V4aTVHT0lG?=
 =?utf-8?B?U3NuSHZCcWVubzNWZnM2VjN3dE8xdEgrem1INlp5SWlLcHU5R3NmK2pscncy?=
 =?utf-8?B?Um1PK09zTFlxWkM4SWtUZmtQditlSEFLaVV3NlplcWMwMVl5KzEwVjhxQ0J1?=
 =?utf-8?B?RUVvU2dIanJRT3F2ZVl2RTdDVGhEek9EUmtWYTRwNWNUa0lZTmtFRDdmZkNX?=
 =?utf-8?B?cjkzMDJjMEZxaFFFYmM3aFpRYTI3WWN2SUlsY1FiZ01PbyszaEdScFBiT3FU?=
 =?utf-8?B?dUgxY2ZZNkhoa1EzSy84UGZxa3VZLzN6QTk1T3k2NXJQQ001WExSdlErakV4?=
 =?utf-8?B?b0I3V2ZsQzlzVXhOUzF4QnNVbDQwZnlWQkMrd0NyL3RUMjdQd2NRWmJYbGpa?=
 =?utf-8?B?L283ZTllVHVpZzNHeDNMdWVrajNUUU94K2d1aFE2eFFHdnhmQUxTUk1meEM2?=
 =?utf-8?B?MGhlbUsrVmM5Y0J2UW0yclQwM2wzMmxIZjR0OVA1MG9WUHpCTVBQcXBZbE4x?=
 =?utf-8?B?WDZ0Wm80c3pkK1UrWjQyZXhrL3JEVkdIR25VTU05ZXd4eC9LRHpNU2ZVNmQv?=
 =?utf-8?B?QTYxN1FlT0tsdEVTRExxRkxQVGd3NW9mUkFOZzQ4VWM3a0Y3M3gxT2R1b3Vt?=
 =?utf-8?B?TlhISXprTERKb1RLVk5qUlFHZmlneDdXSC9HTFhmMGdXSXRSdzR6REFoWjRC?=
 =?utf-8?B?SitFMjJjbU9LaUVEaWhsWDBSamt1N3d4TWlkYmN5NFNEQytORml1Zkd2U2FM?=
 =?utf-8?B?U0o1MGRFS084RDlxRWpzcGZsa3p3TlAvbVI5NUlVL1A4WWduZEhZUW9jMG1E?=
 =?utf-8?B?THFLa3FXNzVVNWdrdGhVQkY0L1ZsMzZkS2dsU3ZzYXVFeDRmYUJGY3p4KzRQ?=
 =?utf-8?B?QjJRNnZXbFZsK0ZmaW0rWmZENEVOMHRFS2t4Z2lockZ5VzlZTHF0MzE2KzZI?=
 =?utf-8?B?d0tKQTJZUlZJcjFKN2ZjN2dFSVNSL3l6UVdoT2p5S3Z0bU94V0llYmtoVzYw?=
 =?utf-8?B?NjI5YzJnczBmc2h2SnVZRGprYWhueXIra0ltQkJ4OFZ6dlFEUFBJamJ6Y2Zi?=
 =?utf-8?B?UWhVN2RYcTdLOG9Gemt6T3hoa2tCUjZ3M0oyakJTSG9IcUxvWXA3cmF2NXVZ?=
 =?utf-8?Q?GODdRDtdLh+EBvTd314Exud9Cuxs7oL06VYPcLgzl2go?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f1d7c8-1e49-430b-38f2-08de36d4f62c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 03:42:22.6658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mXYVQde7LckpcJykHntrTHm6l8I8ZqKmIFGy41KAGFJMmblovxlDJFxSLAEezn0Mf8V0ujTypRTFCPxpFnoFrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6746

On Sat Dec 6, 2025 at 9:42 PM JST, Zhi Wang wrote:
> Add a wrapper for the `pci_sriov_get_totalvfs()` helper, allowing drivers
> to query the number of total SR-IOV virtual functions a PCI device
> supports.
>
> This is useful for components that need to conditionally enable features
> based on SR-IOV capability.
>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> ---
>  rust/kernel/pci.rs | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 7fcc5f6022c1..9a82e83dfd30 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -514,6 +514,18 @@ pub fn pci_class(&self) -> Class {
>          // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev=
`.
>          Class::from_raw(unsafe { (*self.as_raw()).class })
>      }
> +
> +    /// Returns total number of VFs, or `Err(ENODEV)` if none available.
> +    pub fn sriov_get_totalvfs(&self) -> Result<i32> {

The return type if `pci_sriov_get_totalvfs` is a bit unfortunate. It
returns `driver_max_VFs`, which is a `u16` [1], but not before
implicitly converting it to an `int` - even though it doesn't make use
of negative values to indicate errors!

Even its C callers eventually compare its returned value to a `u16` [2].

How about a cleanup patch to fix it to return `u16`, so we can make the
Rust wrapper return a `Result<NonZero<u16>>`?

[1] https://elixir.bootlin.com/linux/v6.18/source/drivers/pci/iov.c#L1281
[2] https://elixir.bootlin.com/linux/v6.18/source/drivers/pci/iov.c#L474

