Return-Path: <linux-pci+bounces-34319-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B471B2CBCD
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 20:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FC7A1B68B88
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 18:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4428430F53D;
	Tue, 19 Aug 2025 18:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FJRfA0xQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA49530E0EB;
	Tue, 19 Aug 2025 18:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755627831; cv=fail; b=MVCCw6bQG42Mc2y+aIru7i6+Sx0vqRBz23aEsJ2s9eSz68pWZYAG8dvixY2XfD+nsRneY7SfyaZNjenXtxmUnCkjGkJyb3upEpDvmISIPuze2SSOxyx4r6zLifFf0m1CvnuvWD0SU1+yj3phGdAgrxV4YhstgMkXSTQQDjLVuQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755627831; c=relaxed/simple;
	bh=eAFhiRcGElhNNcYNEBJU2VQ+FcyHJPtp/x6CWWBf9Pw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hSVdyITGTpF81iR304mR8UnQ65uQuINRg27qubxI+xNo9hCIpruWsGzcOOd8x9tD6FntWfyGOrTpa6ndBhc6/KsKF7Bs9FvhbvEhNpMdtl28kw8AcExiitiQIAzcDAkHhcXkCwgzX9NukYaVFb6Yn9dmWlwTCmYB6do1VilnE2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FJRfA0xQ; arc=fail smtp.client-ip=40.107.223.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eLL/fiY1aUrL0/y+LdV/AqYxYXH/Dn7XdcMqLmdBmJdjPLoW7DWKt7LQUwSsFTQKlFxJ/KICO6Tb1jweVpQfj/FOkWz1g08HB2sngSJOdoZTu9pkTP9xtxVKQlWjfWQLpBIdS3qbv81HS2Y+5yEFE6XeeHR723kKR/FI3+XnhOzQ1vYb1kU+R2S5yXnEkVcBZu2p/SGLdnO0dTi1rT4RsO2+VGOxt/iJwwAuuMuUoj7AqpEbAuJyAXgoMTTjjrU05TaLgI8LTQkjE+i1F0sqYSMX8rMVgHMxw9vcQFFLJ5SZm4yESJs0OloDRWS2QRKXV9fH+ZceAqFAxMMR2MkgBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPwarxDHYNuprMkVgWpsHel0md3jDETrQwHlKT9Y6J4=;
 b=ys4wVc+ORxWn/xqGm297NOil9dUkr/C/NaA1UR3TaMn2NyBNauFqq1C/wM3Ei2Jk1gmx+9NSLwfHKiCloASDmWX+3G1tFzlUkughmVKkptn+BLks8FSuOn/kSvpqARG2BeYtbYmBAigCSWHmVJPl0wrDcsehuYbdY9jAYJakjVx/jv3HH3WkAASAasz0XnX6z20KeFwnE5HUxk8X8h2ek3y7trgNPDP78rXQ0qX4miSwft/GVK0gEPlNOh10wNwHX3F64WJyWAQJPnEdGW4sJVoW36QyE3K3xC6dLg5NGKZ4u0w1mjYXIqlUczO6iVX3O9sCVxAvbQBQDYE9PwDLDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPwarxDHYNuprMkVgWpsHel0md3jDETrQwHlKT9Y6J4=;
 b=FJRfA0xQNBSvvCoWWLRL+kTHNplXDp5E69FndFUi3pTKQq4ALYl62stIh5fljpa/6biNYxmbF8OceILwm/vjKEImmgnI+0nXa2POyNYeySdYkI+D1l21QYOhbfwypg/9JMeNR530ZeR7FBaKD7sRIOzSaRovU+hgruwhWDEE7bWlaaO9GVfkUUcIIxandyVbHEa/FSnGwtOJ+iT7TmbAxgzvTeUKN61VjhvJPyBJW0vraxwF1GjrF15IyH8S7f4ZgAbAghJzXdXAON9+OD6x4DtRGeXsZIIwBa/EGs6SApAdt1Y24v9fWnDUHPQQ+wm5BjumROUPIvEIZFH9vFimGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by PH7PR12MB6468.namprd12.prod.outlook.com (2603:10b6:510:1f4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 18:23:43 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%6]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 18:23:43 +0000
Message-ID: <0e673726-709d-45e6-bad2-b75a01c412c9@nvidia.com>
Date: Tue, 19 Aug 2025 11:23:40 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] rust: pci: provide access to PCI Class, subclass,
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
References: <20250819031117.560568-1-jhubbard@nvidia.com>
 <20250819031117.560568-2-jhubbard@nvidia.com>
 <DC6ACCFEBPYR.1R4LQL7EGKM5F@kernel.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <DC6ACCFEBPYR.1R4LQL7EGKM5F@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0044.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::21) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|PH7PR12MB6468:EE_
X-MS-Office365-Filtering-Correlation-Id: 45dc232a-8f6a-4907-5993-08dddf4d8738
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cm5tcGt4L0R1RW9Gc3FRNngxbmtRV21rM0FpREIweE1aQmp3N3k1R0dZNjU1?=
 =?utf-8?B?dXFGL3FtekwvR01TZ3gzU1RsUGdOZ1dtTUdEZm81c0pFa0ZzdVB4bmZNbTdy?=
 =?utf-8?B?RzJNM2ZmTWtJWTMzcFYwZGkwMnhlSVFrQkNDTVBydTdnaU1ZRUdqemF6b2xl?=
 =?utf-8?B?K0ZFdWRsRFltT29uL2lFMUQ5ejR6UGVMVkJaU0xYTVZyUm50cHpMSWxCSjEw?=
 =?utf-8?B?SnU2MDVZNDIyK2xwQ3YyQUp1dFNqb2t4MGpRUG9qMTNWb1Q1TXhvOGFNa2Y2?=
 =?utf-8?B?cjY5TGxKOEdxOEZYd1dFdDYyb0RjaHFQQTR5eWVGZnJ4VjFlbzVWZDBoVWM0?=
 =?utf-8?B?VWN2RFlXdVB0TUpkK09Wa3ZGdTdpTU9WYm9hVHdldFdhNUFFQlVOSU9FM2hG?=
 =?utf-8?B?dTZqVEJ4RnN5Z2ZLbUdBbzQ1Vnl0N3RaQkFDSFV5NWtQNGZ0MG9mNlB5aUYr?=
 =?utf-8?B?U1k0K2p5MkZid1V5TkE0OFJINlJFUmhNcHc1OEhaRzZyeGtOek5yWFZ0M0Qy?=
 =?utf-8?B?TlNjWnZhSUhEdndXMEpSTUFsTVNUOEhXNkJ1cEhHYmN1MldVZWt1OGxoSUN5?=
 =?utf-8?B?OWdyNUplL3dwMDNmT1VTaURRaG5QMThWK3FhVGprYjU0L0NFcEJJQytkb2lK?=
 =?utf-8?B?V09WMThiOEdpK3daQVVNdHhIQWtGcTRxL2hmOUJpYlE3WHdoeHBNVGRPc2Y3?=
 =?utf-8?B?dkdFSU1MSGRBSFNWWUJFRUpwTlU5dnk1bW1zS0Vkbk56WlZCSjBGekZvVkxI?=
 =?utf-8?B?c0t3RHBYMmNXYSsvK2Q3NHNjSnBXR0lBcFRFemhqd0lSZ2hYa05NeUdTZzlo?=
 =?utf-8?B?N29wWjBDb2tMNzY2aUsrbmZ3UWNvRE5MbHJjWTdGUUl6UmJCNi9hbWRscnZy?=
 =?utf-8?B?bUkwSXUybHlRaGlJZGNoUVRRMDdySDFSNXA1eU0xMTBtcVRkZzQ3UUw5Mmx6?=
 =?utf-8?B?NHpYbi9qZ3Fucklnbm1lcGxTd0NMRzVDbGh3VDN2cE5IenQ2NG12YU13MHMx?=
 =?utf-8?B?QXNYdTQybitVQXJic2tjY0Z2UVNmeDlGeVpnS0F5aG9JUnhDZk5qMWZTTHRj?=
 =?utf-8?B?NWVzaERiamhmMTV2QkpycC91Uy9JR2x1eGdBR2xnM3MrU1lIcEE5ZkJNcXcw?=
 =?utf-8?B?NWI3ZTlIVU1DcVNhK0tReHcvWlgwbXhkeGxGSFFHU0tNWC9aNXFzVlkxb2Yv?=
 =?utf-8?B?TTZGc0JuSWpYTUkrbTEwNldGVVQ1cHVYRVhWeS8rUWw1UnlCTXgxUHFmdDVP?=
 =?utf-8?B?Z2xuOGZrMjUrQmJjTEtmYyswSjhzMFU4MXdUZmlTSjRCZVJXNWs1ZlF5SUJp?=
 =?utf-8?B?aGJpTnBPVHdLSEVhaHZ5cGN5RzdkYmpIQ0wwMDVYM0hLVnVET1Jhb3J6TTFs?=
 =?utf-8?B?T29pYTUzYWRLalkxQ25ENFVvZ05LYlpNaGVRTjd4MDVmbVV1SUJnUXVjdVNo?=
 =?utf-8?B?aHZoVHZONFQvNnJ1S0RnVzZUMHdUS1lRcTJLUkV5aUkrU0hRUnlFV1dSVlI2?=
 =?utf-8?B?TUNVb29IQzJMb1RYNWE5L0Zxc216Q3ZBVjA1UGdDQmk4eG1Pdm14VjBESHhV?=
 =?utf-8?B?OG44TUg5ZGxuUVRxeXY1OEh2Q2ZPZ0s4M24zY1dvMGtRRFZ0RjlmSWlpS0tJ?=
 =?utf-8?B?cnN2M3RXNjlucTVhb2owWGhGT2RQYlRKWkhpcmhsODl1bjNvYWNEVVlBTitC?=
 =?utf-8?B?WGVlaHJPN3FibW1rUWZhS283NTNEWW0ybGtyU0F2STRMRVBGbVFOKzdhaGY4?=
 =?utf-8?B?VVJlbzkzTmhHVzVMSGhQKytUSzJsMEwrODA4aUNkSjZsTm1EUEpvOFF6TUEx?=
 =?utf-8?B?MldOOGxSZGRYTVZlT25wUVpaSkxGbXpBVmRiVXowa3VLcXlSOEZjZUNicWwy?=
 =?utf-8?B?bmNGcURleUIvcmJja0JFdmpGRzdoYkxzTXRKYkJWbWU1dFNkWmVNNW55L2Rx?=
 =?utf-8?Q?14HOSK14EUg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a01odFVhQ1BMNHQvK0tDUXRtbWpOanpZbDdhbEVEbWNkSkZWS1Fwd1A0VW1j?=
 =?utf-8?B?d0liS014akNWMjRBMzdBMXhjUm0xdjNYUC9Rd2hpelZ3bk0zSDJRVU0za281?=
 =?utf-8?B?dmlwRUJDMWZoYlZHaUZIOWh1TTljZ3NEK2tlWnBidHh3aE9qbFlqa2ZmUXFo?=
 =?utf-8?B?UW9COHN5Skh1SWJ2WnV6bG5aUDlZL3VkN1d0TEgycWpoRzRuNHVDdFRpTzBH?=
 =?utf-8?B?dlpWcEo1ZkJ1WEhnVnB3bW96QjduT3JlM050RE5zVVdGajBBWkxzbWVHanhk?=
 =?utf-8?B?azIrekNyYmZDbndjcEs0L1VrVTNQV0piQWNvS3JGYjEya0c4WUtZVDdhUmgr?=
 =?utf-8?B?VG1wZzVFOHlnNEVlNnhJNnIwQ2l6Vms2ekwybU80Sk02QUlHeEIydjdBUVdu?=
 =?utf-8?B?c1hlc2oxejdVOXdTZ0M1clRyRjNBYjVyVWtnZmhqcXIweWJSSHI5Uzk4M1NF?=
 =?utf-8?B?VzJWWlFXMUw4ZFZNUnJrS1U4emozRmFnZFUreExBYTNScy9UVWVlVlFQSFF5?=
 =?utf-8?B?UTNMQ3MydGhZb1JtWEl2QXNRaUJ3QjlJRHA0ekMwdSt6ck15WENNakorTXN2?=
 =?utf-8?B?cVhwaG1IR000OUxzWThtY09DRmFrUHd2cFJoUHJOOGZZM2pOTHdSdDB6T3VY?=
 =?utf-8?B?eUhmMndEVyt1OERHYVo0Z1ZOSTBvU0tmdXJPbTlSMUp2akxVNEJJa3RpZ1ha?=
 =?utf-8?B?QjRySHpTWnY3U0RHZjZNaTRUSEF5SzRuVnVMYit2d1J6WmNKZ2t6SjFSb1pw?=
 =?utf-8?B?K1FPUkFVMU9nR0Exd2FvR05La0toTjVPOUQvZ1FmRGlVMXcxZmdLeDExRm5B?=
 =?utf-8?B?QkZGVkhXT2NlMWM5N1p4T2VMSkZ2bTVTQlg5VXp0WGNXeU43VzZ2d2dhYWFJ?=
 =?utf-8?B?TFU1Qk1JT3ZFQTV3VlB4VmRudlNERmE5MHB3M2ZveWFSMEs5MjNMdzVRTVlW?=
 =?utf-8?B?V0pwNWQ3d2w3Ri91VHpYMjVhK1Z5Yy9qY2JuRno2V1RjSTVxc21jQ0ZkbStE?=
 =?utf-8?B?UVozTnlIZUJsU2gvaDZyMjRQSlU0cUUxZHUvSXcxM3o0TjhYU0dCTzZpRWxS?=
 =?utf-8?B?Q3c1NThJb29STUpGc0p3YVZRTGhmOVVjeUQ1KzBwY2dMSVZOOWtZRjQzREdE?=
 =?utf-8?B?bGtKREQ3bGNMUk81a3MvWGNRWkNoaUNRZVQrMDFRMlkvNDJCck4xZUVzV1Bs?=
 =?utf-8?B?djhKNFZaWnRyUlZ2dTI0c2FraVFmTkVhdno3MHJnL3dZdjYzdFIwQ2p2YWlp?=
 =?utf-8?B?QUt1Y0wwbjVodGVnb0dmeHVjY2txRlpJeFFnUFB6SFF5cHJ4WVpZa0pidmhV?=
 =?utf-8?B?MHpRMFFmUXJUMTFDR2F5T2RYNG1reWFJcG1uZE1hR3dSRTY0RlF1enRxUW1N?=
 =?utf-8?B?dnhSTHJQUHBSL25yL3VXTVJIL2ZSYWN0bjR3cWhsZFYvTGhwNk5XZmQ5MUcw?=
 =?utf-8?B?VjJBb1FGektTTFZmRW8zWGY3dTd6cW54Qlo0TTl6Tk5oMW5tQkVRMjVpQWpM?=
 =?utf-8?B?RFRzU1VlbThZeTJGTmUrWnBMWEhnSEFpdmdibTFab3g4VU5PN3kyeG4yRi9W?=
 =?utf-8?B?OXlqbk4rbVo4OFk0SmZTb2p1QlVZVEIwci9iUWpzbDB4bzlISzlxaUVML2Ux?=
 =?utf-8?B?M3dMK05GckF0R1l3SjNUM1NTYVk0Q3o5d2RVb0JVM1Zwc25yN2k2QkltRWNH?=
 =?utf-8?B?bkFpSUlMOUtHQWZKOUoxdG0zejh0NnVWNDA3UGQzVHZKMTVsenFjVXNQekZl?=
 =?utf-8?B?U3FNTGsrU2JwbHJ5YTJvWmJkRy9LUUkyYjB5cHhRSDlHTjRaU0dIUWUzMGVS?=
 =?utf-8?B?ZVVGZUhROE14Q3l1M05kMWJUbGNlY1AwZUZjY01PQXErNmdYS28zR1o2L3RC?=
 =?utf-8?B?disrbzRPRWVOMXJDZDg3aGx0dVVGbG9GMHl6NWdqdlRRMXlLdStrUy9hWmhj?=
 =?utf-8?B?THhjRGZTTmY0MDFIV0JQSStyaktDalhrcG5CMHI0YkJLcEtGN2NaclUzeDRz?=
 =?utf-8?B?b3hvaGwzUDBsMmZYaFZlSTZlcVE5OU44T0tIRUxPWjlYTkNtc3p6MHhvVWcw?=
 =?utf-8?B?ejN4ODIyMHo2dEJyYTBRbXZPdFAvSHpQSkkvMWlvNS9DcCt6dVd4dk9LbW10?=
 =?utf-8?B?eTdvNjJIdWc5aXBUV3MwVGlnVnF1SFF6NldCUEdyN0lyMFJnSC9uRDFSOTd1?=
 =?utf-8?B?VEE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45dc232a-8f6a-4907-5993-08dddf4d8738
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 18:23:43.3386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VGLzs/oq4LY0rWS2u9SeqIOHGF3MyfFM76tQoHPWLFsImpwCxkelxZfOWdDWDRkA1yFjoBKwSSWgPx2BjNfDyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6468

On 8/19/25 2:09 AM, Danilo Krummrich wrote:
> On Tue Aug 19, 2025 at 5:11 AM CEST, John Hubbard wrote:
>> +/// PCI device class codes. Each entry contains the full 24-bit PCI
>> +/// class code (base class in bits 23-16, subclass in bits 15-8,
>> +/// programming interface in bits 7-0).
>> +///
>> +/// # Examples
>> +///
>> +/// ```
>> +/// # use kernel::{device::Core, pci::{self, Class}, prelude::*};
>> +/// fn probe_device(pdev: &pci::Device<Core>) -> Result<()> {
>> +///     // Get the PCI class for this device
>> +///     let pci_class = pdev.pci_class();
>> +///     dev_info!(
>> +///         pdev.as_ref(),
>> +///         "Detected PCI class: (0x{:06x})\n",
>> +///         pci_class.as_u32()
>> +///     );
> 
> Maybe a bit cleaner to implement Display for pci::Class?

OK, will do.

> 
>> +///     Ok(())
>> +/// }
>> +/// ```
>> +#[derive(Debug, Clone, Copy, PartialEq, Eq)]
>> +#[repr(transparent)]
>> +pub struct Class(u32);
> 
> [ Class impl and lots of pci class ids... ]
> 
> I think we should move all this to a new Rust module (rust/kernel/pci/class.rs)
> to keep this file reasonably small.
> 
> You can add
> 
> 	use self::class::Class;
> 	use self::class::ClassMask;
> 
> in this file to make it appear as e.g. kernel::pci::Class.

OK. In patch #3 you suggested combining with Vendor into an id.rs,
which seems like a good layout and naming system, I'll do that.

> 
> Sorry I didn't mention this in the previous version.
> 
>>   /// An adapter for the registration of PCI drivers.
>>   pub struct Adapter<T: Driver>(T);
>>   
>> @@ -157,6 +355,23 @@ pub const fn from_class(class: u32, class_mask: u32) -> Self {
>>               override_only: 0,
>>           })
>>       }
>> +
>> +    /// Create a new `pci::DeviceId` from a class number, mask, and specific vendor.
>> +    ///
>> +    /// This is more targeted than [`DeviceId::from_class`]: in addition to matching by Vendor, it
>> +    /// also matches the PCI Class (up to the entire 24 bits, depending on the mask).
>> +    pub const fn from_class_and_vendor(class: Class, class_mask: u32, vendor: u32) -> Self {
> 
> I think it would be good if class_mask would be a new type ClassMask that only
> has the constants that are applicable for this field, i.e. MASK_FULL and
> MASK_CLASS_SUBCLASS.

Yes, good idea, that will lock it down. We only ever want those two
mask choices here.

> 
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
>> @@ -410,6 +625,18 @@ pub fn resource_len(&self, bar: u32) -> Result<bindings::resource_size_t> {
>>           // - by its type invariant `self.as_raw` is always a valid pointer to a `struct pci_dev`.
>>           Ok(unsafe { bindings::pci_resource_len(self.as_raw(), bar.try_into()?) })
>>       }
>> +
>> +    /// Returns the full 24-bit PCI class code as stored in hardware.
>> +    /// This includes base class, subclass, and programming interface.
>> +    pub fn pci_class_code_raw(&self) -> u32 {
>> +        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
>> +        unsafe { (*self.as_raw()).class }
>> +    }
> 
> Do we need this method? I think drivers can just call pdev.pci_class().as_u32()
> instead (which we could also name as_raw()).

Sounds good.

> 
>> +    /// Returns the PCI class as a `Class` struct.
>> +    pub fn pci_class(&self) -> Class {
>> +        Class(self.pci_class_code_raw())
>> +    }
> 
> This is good! At a first glance the name looks a bit odd or redundant, but
> people would clearly expect something different when this is called as
> pdev.class() (i.e. a struct class representation).


Thanks, that's exactly the reasoning I used, too.


thanks,
-- 
John Hubbard


