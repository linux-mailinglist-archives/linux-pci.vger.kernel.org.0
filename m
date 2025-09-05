Return-Path: <linux-pci+bounces-35495-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12851B44C5A
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 05:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B22E81C806AD
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 03:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033981339B1;
	Fri,  5 Sep 2025 03:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aV6Aj1iQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203D31C27
	for <linux-pci@vger.kernel.org>; Fri,  5 Sep 2025 03:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757043260; cv=fail; b=MixrnADeXyQJjxOOLmDuFRa4SjY3z0T8jr1pX6vyfgk0OuAcc96utSaOqR+/kKi769qV7NLcIhcSw0dEZ19nXF+Lnq5136AA4TRkMUjeyh7OVQDQ2nQNwjE57D1bUXLW1e8hfUH8LY/S3P1YiOtj2QGwyXi/h7a2GopoxbgvaM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757043260; c=relaxed/simple;
	bh=N0GQEXlVWtZGIVcRnW4+4kJg8DhOo5vjP0ViuXMLz2E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Gy5c5se/6B+xb+L/LIs+Tmbis6jCLRQZh0pRmB263atfjb8msdwav6zm5yxOijlU/CMK1ZUxin0CLYIptAyf9l8lU/u1arRWBGLZ4uBgPhvHrLAxXuJor+pjBfDbMjE/Flc5K6DHl4I9JwOvw72iGXSY0prM896tEMmYAAew9EY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aV6Aj1iQ; arc=fail smtp.client-ip=40.107.243.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G3thtldOVcVekUW5TjTjqLpd//tJ5pIis/SF8AXsDvYPP08RgEswEHMc/lRB4EpgM1F9QRQ2ThGcgPFPkym3VoFLXuQsZRMsSdkfWmoR0xB3z5Rq4TdHzkyY954QlQ5wY8Lp46AxrwvXCaXg5tgK25RoncwZM/BgZQR4TLD8srR89+8cF+8kyKVpIepnoP58aq82FyBQlFx32XCQj3a7m1AoOxCMOpmaCaStlk1Ry78mlPQ0Htv+IdO1xIjQokBxvUX6SN7h7j1wY/tp5j6rtmJX8+yHZakcMS3m2BP+gaxa0hMjXg+xUgwtMpzzzHWnCko0uB+c7Mo+o0GwuQIwhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uFR7g3UofwQvgjk3EYInq9l8Xp2ivQYlB+lxC3knBmo=;
 b=oX9/RuRcZE85u6l2dW0YsUnxXrluI2xpxOMm0jtpDEEUModb2DZkSGOjbLyZoxJoUno1QwQAjJ7xh8vNkMudVjWR2F2Vf6D+2B5FvaZd5AG6MOinaWMdPfv7ivkj7eGnEevIikmXHtITA4pWnlZvbfy3x0a2CDN/lM4pUMpnCbjybMecpSp1mdkiQOEHQuaCbIqHyYigKC6TXiemxVYyt4gyJaRtGFNNn7jrpPBHQyswNzbHA42b6X6uunbhxqCgV9mcQ/g7bwySXjlykRJdNYGIuk+Z4xxGOoSdyKZSkC13V2Qwnp9MFBhGtB+ZTKBlh/2g/tgwkDozbiNZOhWlkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFR7g3UofwQvgjk3EYInq9l8Xp2ivQYlB+lxC3knBmo=;
 b=aV6Aj1iQz69UFH3qXasLzDaLn9s0enILrTuWr2T15hnFLN5WwZj/ZSONURvAFdcRsRL3gDjXH6IwREp87Bg0Sn/sgN/eYensF65FN1r6RPWEvRjGSnjYRRCFpVzjNQl8rfWJY5f1WITBZ0/GUwsKNOmQK+XeY+HcsF+0/NqfOQg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by IA1PR12MB7494.namprd12.prod.outlook.com (2603:10b6:208:41a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Fri, 5 Sep
 2025 03:34:15 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.9094.018; Fri, 5 Sep 2025
 03:34:15 +0000
Message-ID: <67382369-d941-48dd-92f6-8bbad7b26b60@amd.com>
Date: Fri, 5 Sep 2025 13:34:09 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v5 04/10] PCI/TSM: Authenticate devices via platform TSM
To: dan.j.williams@intel.com, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org
Cc: yilun.xu@linux.intel.com, aneesh.kumar@kernel.org,
 gregkh@linuxfoundation.org, Lukas Wunner <lukas@wunner.de>,
 Samuel Ortiz <sameo@rivosinc.com>, Bjorn Helgaas <bhelgaas@google.com>
References: <20250827035126.1356683-1-dan.j.williams@intel.com>
 <20250827035126.1356683-5-dan.j.williams@intel.com>
 <c2019b3e-f939-49c8-82e8-400b54a8e71f@amd.com>
 <68b0fd1ac2ade_75db100a3@dwillia2-mobl4.notmuch>
 <a7947c1f-de5a-497d-8aa3-352f6599aaa8@amd.com>
 <68ba33dfac620_75e3100a0@dwillia2-mobl4.notmuch>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <68ba33dfac620_75e3100a0@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5PR01CA0072.ausprd01.prod.outlook.com
 (2603:10c6:10:1f4::8) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|IA1PR12MB7494:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e08c8b8-3637-4774-5c0e-08ddec2d161a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dVpVTHhNR0pFVmxEbnRGRjVNc1draTd2V2VaVmZLWTRoN1RQRXIwVGxzZGlw?=
 =?utf-8?B?Z0RRaEx2VnBlWmh6Y1psRHdNOWNhUUpyelNmSHdESVk1UXo3aHJHck14U29w?=
 =?utf-8?B?SjFJbTZISk9HUitaWkFUVy9EbzhuSGdqdVkxQ3YzUUFpTGwya1RnR1UwTVh1?=
 =?utf-8?B?YTJIV3JFWDYvSFVpMWNMMVFIcTdwVC8xeUQzT0hwdE1jZ3RLb1pLTmR6SDc2?=
 =?utf-8?B?UmJWK3JIRnVNcnN6QVJuY09OcDNOODZkNUcxVXJJSktuN2VaaGs5NWhTeFRF?=
 =?utf-8?B?b2NUcWcrdXN5ajBKVm1PK3R5YnNoS1dqWWJ0Q01wVVB1SEpxa3lBczVnT2J2?=
 =?utf-8?B?NEx2UUJvd1NTRnhiOGM4a2NNazlZMVlYVUMyUUZLSWJHVEd6YmhBRWtTVG51?=
 =?utf-8?B?R2s0Wm84bk9qMWNYcTF0ZVJlN3FOaFhtTjVYakNPMzVld1g0akFpNXNBdWFX?=
 =?utf-8?B?S0dnamd1TFd6Vjl3b3ZOR0pRZndLaXNsaFZUOHVWUW9WQUJrWnMzQ3ZiSXRm?=
 =?utf-8?B?azl4T0dRNGtFQnZiNlZoWkJqSEZqUGREazg1TXFuMUtOU1JtVUdsSWJjWmRr?=
 =?utf-8?B?aVkvOFJQRWFHZXdnZUhid282ZFZHWVA0RzhwV01UMTVEbkE5V2NGbzhKZ2Ni?=
 =?utf-8?B?eS9iYk52NElNTnV0WEVnenFlRW9UU3Z0eTlYK3JEa2pCTWFkQmZNY3VaNS9z?=
 =?utf-8?B?akF6L1FZUzdlbXZMTEZPTTVveDlrbllIUkV5TEVkQXdHenFpVklyN3N5Q0Js?=
 =?utf-8?B?cGs0UXllZ2JoRFBzeUlTeEhRbytHd2I4T1EwYkhsU3Y1N2tSdjNBTUtlQytE?=
 =?utf-8?B?S2VRY05Ya3hLcWdzK1JjR1pDWFRUYWFoUDVuaDNocmdHcHNCNWgwaWFnUEZh?=
 =?utf-8?B?dEFVdktUVEorMXpKc2NWcmN2MDFJUlYrVnlyempuZlVKNC9vVVpsaTQvclhQ?=
 =?utf-8?B?dVhEOEY1NHhsTWNyUnpYKys1T1RGSE82TVJaODA2ODNoc242VUNtWXZBOWE0?=
 =?utf-8?B?K0REOER0UGxtUUMyc0RVSHAwZTVlS05GSjRBcDBYNXNjclBDVTgvVTZlUTNK?=
 =?utf-8?B?QkxFUldUSGxlRC93RzV0TUk1dk5YSnppNzltNjZ6Q1lBcDVFWEZhVlI0aTAr?=
 =?utf-8?B?QitvSEptOWlGd1VYUEpKNkxyOHB5S1FOUmRqdDNQcGdzZjcwVXQzVnEzOXJ5?=
 =?utf-8?B?SXJiMVZVcjkvUUxnMzRmcUN5cWIwR3V2Mmh5ZmgxSUQySmx0YWNrdk9DVC9X?=
 =?utf-8?B?WEpoSEtjZXphd2NwRDJjS1pmM3RmQVZTVnYyLzlUbVBaZ1JkbU9kcFRrS1Vx?=
 =?utf-8?B?dStGYmlwZi84WWI4cW9MUUZkajZldnA5UHpkekZ5NU1LSWhlYm9ZdFpvd2Jk?=
 =?utf-8?B?My9tczNMbE1GVnlOMUwzVEJRZ21YWERVWlpuYUZuajVrYlNQK0p5L2NsYmRX?=
 =?utf-8?B?SWxJT1R5M3hZdVZHaU9KbkNSVjJVQWxNTDJLM3Y1MnJtSk5RWEdOU1ZISStO?=
 =?utf-8?B?Zjk5QlB0MkNrYncrNGJyZ0NhS2xtWUFweHlhV1NNSXFNSGlzekJlUGloSjJ4?=
 =?utf-8?B?Q3cxQXlSNFVuR3pIcE80aXdmTzFNR2hHUHlGVXl5RWhGaE05UjhNU3J6Mkc2?=
 =?utf-8?B?dHlzb25GeFFIK05nQmpWNHhYdWNUcHJLNkUwODE5R3NtRDNlNmVtdjJwTHlo?=
 =?utf-8?B?alhkdnZmRVhuS1pVTDJKaW0rZ2EyeVo2dDltL2IzTUM1R2lLTC9IU2pLYit4?=
 =?utf-8?B?N2l3bnJHWEdNVzAydnZ5U3haY0RGaGpQanhlanJFNmhqYndDMHh1U2ZPMHkz?=
 =?utf-8?B?MFVmR0VLYXZqb1BvQ2hhSVRGYjNoWnNSY0lGWDFtbnB5WFNjQ3FkZkZMRU5G?=
 =?utf-8?B?czNLbWF4T2pET204eVluNUpQTFR3LzdZdjd3a3hvdzFXa2NzaGR2c0NjUFJw?=
 =?utf-8?Q?7rl7jmIcNO4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SnBxTDlnT3ROd0EveEg1ZzlNZDBwV01XbHVzbU5Pc1E3Mks4cUNORmlXQTF5?=
 =?utf-8?B?aDN4VzdHczdPWFZHM3lxU0loZDQ5V0pYRDdWT3ZQbFpKUkZDbDE0bTFaVGE3?=
 =?utf-8?B?NnFPOXRsV01mYjNDR0NITGsyVzlxdlpjdHh2YTQ3cWFrMjdXWE1QK1hzSDRJ?=
 =?utf-8?B?NDQyNElCbXhVbHRGdEl5djArL0NUNm5iSnc1WEw0RU5TSDFsTHpNZmZQenBm?=
 =?utf-8?B?RG0zWHZBcHY5aVUrTU9DdmxaeGFMcVp3bXRBRUpld2JwWVhqN2paTS9WTnBW?=
 =?utf-8?B?NllrUSsrSFVJVHp0bXMwSHVqNXBhMlVrMVROZkgxUis1ZFJoVDYrN0x4WnVs?=
 =?utf-8?B?S2VaNWZSZFJhTkJNU2x5a3FHdGx0UTNOOFZVUXc5QzlTNGFoQ1J0bUJ5bEFo?=
 =?utf-8?B?VXhPd0ZCaC9SMGZhU1d1WXFtT2g0ZWFCS2lVeFplQTlTT0VHOGpzU1RiSzdl?=
 =?utf-8?B?NXIrODlnajlSZmtJR0xINjBFalRlR3NtZUdpV2RXbjM3czA0UUJxWnNqYVpR?=
 =?utf-8?B?VUdDZDVqaXptK3RoblhrVFNFd1VROFlwa3FZdGRVTGpxdnJHdW8wRHhzeWs0?=
 =?utf-8?B?Nk85K2dPcnVvYVBzaGZPOEZsRmMrc2xJQk9VbzVQNEdNU05LY1NLYjU3UkZL?=
 =?utf-8?B?Y0V2WFdsTHJuSGttNkNMaHpYRjMwdGRpRE55SEMwcDVwTjdaSUZvOG1ndFFQ?=
 =?utf-8?B?dno5WENKQWNYTUNBN2YxZU5qQ0JlaUVVVHJDazRIblFQZTc5Z0kwREFUT21h?=
 =?utf-8?B?bnVUL0E4UFZPa09LNjBSOStaNHZ3S3pQQUw2N0tUTXpRcVRiM2UwNEFreVRk?=
 =?utf-8?B?cXpKTVdFYmhuQ1Z6bUplNThuNmU2eEJRS1JUWVpBb2xIL2RjR2hZRE1YUzA2?=
 =?utf-8?B?aW41MG45RVNmbnVtend0ZUNVSGZEaEVmeDlvVzU3Q2NWMmVqdkF5Q0o3RmRy?=
 =?utf-8?B?VzJVYjdtcEpsY3pKMVBnaTV1cHo0b2pvYnJNZmZnYU9WekIxQWgzMFlLWFFj?=
 =?utf-8?B?Y2lsT0dBYjNGbnVPbXF5VU85UWp3OW1JWkdJdG1IbmxYYW1ldVMwTVVWbXBi?=
 =?utf-8?B?aGozUCs0YlJ4bXhCMUg3QmVtUEExL1ZWSlMyUTNWZ3dWSmtNbXZSczY3eVBr?=
 =?utf-8?B?QnlaRXdtRGg1cksyYVdFWk5DYjVRQUcydWdkRk0wS3FWckNxZUgvUC9UeEhx?=
 =?utf-8?B?b3NldXg0SC9wT0MydjJzd1FNck1SZnE5cHFQZ1lyTlRvMEZCTGNadDE4bEJH?=
 =?utf-8?B?SzVnOHA4UmtPMTVLVWRRWVU5RUZMWUJkTksrTVcrTXlwbWQyeTREYy8wZXNZ?=
 =?utf-8?B?VnhmSVJPVisrZi83N0FvK2Zta3VRSm1jaDlFazNuUW1QQUIyTko1SGE1ajdt?=
 =?utf-8?B?M2RQYWVlRkw2VGtZSmNRY1dyT1RNTkNpYlIvQzhaVkIyMFp5K2xiVlcrYWg3?=
 =?utf-8?B?ZnQ2Mks3T3pqbkQ4MXA2ZkMyVXFwUStYVFhIUmFqNStieERoelVkN0l6VEhZ?=
 =?utf-8?B?K3FBN1crRzF2UE15azFLM3pIOGlqb2I5Vkd4MTU4Mk1iUjZZbE9DemhydGJP?=
 =?utf-8?B?VTRhdXA3OVpKelRuU0FwUGllbGovZy84UzV6b0NyekFsSm01bXJ0TGtTcDYv?=
 =?utf-8?B?T1MxZ2tzMTdhOWFVL0ZGdnh0TWxaV0wva1NaUUNKekxPZWc2cTJFTGRaSEdH?=
 =?utf-8?B?MmZwaGtDblZnQW9wNS9tM3BiaDVydmZGRW1tOEMwYjJMRWhrWjVhSm1iVVA0?=
 =?utf-8?B?YUhZR1hlQ3hwWUNmVVk3Si9tdTM0SUNWbys3TzFYR2pPY2ZkRGo0YzB3Wnh2?=
 =?utf-8?B?d0dqTkY2MDhXSDUxdnc0dTFIVElmejRZMXNqdzM0ais4ckt0M2lNVXkzdVZM?=
 =?utf-8?B?M0RNYVNwVVJ6K3lodUt5ZkxhSVB5QVR4Z0VyRlZxNE5JczduOFk5R1hYQzZ6?=
 =?utf-8?B?UjMrRWFOYjBzeDJnNjg0S0ZKdm4vVGdUZUNIZjNlZ0IrREwraHl3U0tnZE5a?=
 =?utf-8?B?eUt5WXplYmh6eHZxcW9XeFNpWE5zd0JNSWtzUnh0MlZFOXAzUHBoQnBZa05w?=
 =?utf-8?B?R1BXdzJ3L3plWXk5MlpJL3RWeG5PSmQ0czRjWisyeXJFTG5lVTZwV05LN2kv?=
 =?utf-8?Q?yd2rKHR9TgZppvRMPx25Jkdw2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e08c8b8-3637-4774-5c0e-08ddec2d161a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 03:34:14.8912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wjj1Q0LxY/oE8NixM9puzZAZ7H7xhMc+sY6cH+xFYlalF5X3uS0T/Sviy6m+BPHS2q7lgwT98Sx/CB8UerBF9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7494



On 5/9/25 10:50, dan.j.williams@intel.com wrote:
> Alexey Kardashevskiy wrote:
> [..]
>>>> Looks like this is going to initialize pci_dev::tsm for all VFs under
>>>> an IDE (or TEE) capable PF0, even for those VFs which do not have
>>>> PCI_EXP_DEVCAP_TEE, which does not seem right.
>>>
>>> Maybe, but it limits the flexibility of a DSM for no pressing reason.
>>> The spec only talks about that bit being set for Endpoint Upstream Ports
>>> and Root Ports. In the guest, QEMU is emulating / mediating, the config
>>> space of Endpoint Upstream Ports.
>>>
>>> If the DSM accepts that interface-ID for TDISP requests then the bit
>>> being set on the SRIOV or downstream interface device does not matter.
>>> So the initialization is only to allow future DSM request attempts, it
>>> is not making a claim about those DSM attempts being successful.
>>>
>>> Effectively, Linux can be robust, liberal in what it accepts, with no
>>> significant cost that I can currently see.
>>
>> okay, then may be put a comment there so when I forget and will be about to ask this question again - I'll see the comment and stop.
> 
> Done.
> 
> diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
> index 8fa51eb6dd05..c25935a6c059 100644
> --- a/drivers/pci/tsm.c
> +++ b/drivers/pci/tsm.c
> @@ -180,6 +180,12 @@ static int pci_tsm_connect(struct pci_dev *pdev, struct tsm_dev *tsm_dev)
>           * dependent functions. Failure to probe a function is not fatal
>           * to connect(), it just disables subsequent security operations
>           * for that function.
> +        *
> +        * Note this is done unconditionally, without regard to finding
> +        * PCI_EXP_DEVCAP_TEE on the dependent function, for robustness. The DSM
> +        * is the ultimate arbiter of security state relative to a given
> +        * interface id, and if it says it can manage TDISP state of a function,
> +        * let it.
>           */
>          pci_tsm_walk_fns(pdev, probe_fn, pdev);
>          return 0;
> 
>>> [..]
>>>>> +static ssize_t connect_store(struct device *dev, struct device_attribute *attr,
>>>>> +			     const char *buf, size_t len)
>>>>> +{
>>>>> +	struct pci_dev *pdev = to_pci_dev(dev);
>>>>> +	struct tsm_dev *tsm_dev;
>>>>> +	int rc, id;
>>>>> +
>>>>> +	rc = sscanf(buf, "tsm%d\n", &id);
>>>>> +	if (rc != 1)
>>>>> +		return -EINVAL;
>>>>> +
>>>>> +	ACQUIRE(rwsem_write_kill, lock)(&pci_tsm_rwsem);
>>>>> +	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &lock)))
>>>>> +		return rc;
>>>>> +
>>>>> +	if (pdev->tsm)
>>>>> +		return -EBUSY;
>>>>> +
>>>>> +	tsm_dev = find_tsm_dev(id);
>>>>> +	if (!is_link_tsm(tsm_dev))
>>>>
>>>> There would be no "connect" in sysfs if !is_link_tsm().
>>>
>>> Given this implementation makes no restriction on number or type of TSMs
>>> the "connect" attribute could theoretically be visible and a
>>> "!is_link_tsm()" instance could be requested via this interface.
>>
>> But how? There is this pci_tsm_link_count counter which controls whether "connect" is present or not.
>> "if (!WARN_ON_ONCE(is_link_tsm(tsm_dev)))" at least.
> 
> In "[PATCH 5/7] PCI/TSM: Add Device Security (TVM Guest) operations
> support" [1], it does this:
> 
>   static bool pci_tsm_group_visible(struct kobject *kobj)
>   {
> -       return pci_tsm_link_group_visible(kobj);
> +       return pci_tsm_link_group_visible(kobj) ||
> +              pci_tsm_devsec_group_visible(kobj);
>   }
>   DEFINE_SYSFS_GROUP_VISIBLE(pci_tsm);
> 
> ...which means if both "link" and "devsec" TSMs registered, userspace could
> attempt "connect" with a "devsec" TSM.
> 
> [1]: http://lore.kernel.org/20250827035259.1356758-6-dan.j.williams@intel.com
> 
> This property of being able to register both "link" and "devsec" TSMs at
> the same time is useful for testing.
> 
>>> This is the case with the sample smoke test:
>>>
>>> http://lore.kernel.org/20250827035259.1356758-8-dan.j.williams@intel.com
> [..]
>>>>> +static void pf0_sysfs_enable(struct pci_dev *pdev)
>>>>> +{
>>>>> +	bool tee = pdev->devcap & PCI_EXP_DEVCAP_TEE;
>>>>
>>>> IDE cap, not PCI_EXP_DEVCAP_TEE.
>>>
>>> ??
>> If there is no "IDE", what do we "connect" then? This is all about PCI now, can we have active TDISP without IDE?
> 
> TDISP without IDE still needs to do all of SPDM (Component Measurement and
> Authentication),

Support for PCI_DOE_FEATURE_CMA_SPDM says that then.

>and the TDISP state machine.

I'd think PCI_EXP_DEVCAP_TEE is set on something which allows START_INTERFACE_REQUEST and some SRIOV devices may not want to allow this on PF0. I am likely to be wrong here then. Hm. Thanks,



-- 
Alexey


