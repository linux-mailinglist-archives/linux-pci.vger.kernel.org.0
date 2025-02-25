Return-Path: <linux-pci+bounces-22282-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB135A433B5
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 04:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 155E717C113
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 03:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B015D146A69;
	Tue, 25 Feb 2025 03:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="t4+l4Wl7"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2048.outbound.protection.outlook.com [40.107.100.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B2F2505B7
	for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2025 03:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740454791; cv=fail; b=OADs1/lfwiT6lqvDXNf3pj7bMpwn6oxftUVqNGWZb3YHew7N5siFKNY3SsOe1bkpVtgHysfHVZI/D15/460GRdfaPgvb84ERzUdvjgvPjmQzuesnISUAp+/6dNASWOoWrKBLTYB2vnxMa1seXLe/iDbpBw7ORhNf9o3nifVsZY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740454791; c=relaxed/simple;
	bh=jq9vR3MoSuArF4OVQFo7cmT4Wvxi/yOjCrxXz8Bpvp4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ncqyHUqoKzRFI1rKwFZiTHtPiWRzWuQi2cXCN3JH+C7HP0+XDkioHk6DWEq7Lp7nNkSI/fIXWxrOdF/tWgLawEfJ5+SyYHK7dqE0cv4qE5vpAw1eWB4u7JU7o9SaettBkN1f8CMZa5bt9wvcj9wjWVS/imnoJ1+7loGGS0z8D3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=t4+l4Wl7; arc=fail smtp.client-ip=40.107.100.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q9Ody5Us2REOzfIuOKfPyQVgW1aAkxNST1aYgbkkreZzDFBbBRC9TNrYT6M2lUU95Yy46nwhFTo+1GvfKk+UveMlrDrF/Ojl4xn/wDdlN7+yvzWMA97oT8A3OR/0B9CGrE3rlOcTq62D2l6qxPhi9wWhlyYf15sIYotYnCp0Fkgjb8Z6PGoXM2abcamo7P2OmSbZy8he7mZIJHEYZASlHgfnrUJa+bhnMVw0zsHxctP620yVk8kQFv62cNkCajdMZIzT9WgEbWiO/KcX8VndPdSwyk3vQEHTQN3Q7OV97EqRxLU9q8F8NzhtM+o7PwzGMqPmzxC0l1G0jh0YJ8uOhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9D+ZM5onaRpJc/RkBaZzPhXFE1ostpj44JdkTwpn374=;
 b=FbyYq6Xjasc3pd2R1wXCTLWNSNh0BPScKh4P7FGY+fiZZnB+zBg2UD9GMqnCAJpZjpnxWpNBM18F6Qp9rD1Sz5J6FUWBM1vF1e39vcFqb7pchllh4TSqGfuFOlEyLp8ml0f7RmKZXfb7O/mZF+3DnPiPD5HZ3pQ3Y9mgeUktx781e5Hkn2GdwLAbitmNbr93bFxGDipgQaCiM5+AxH1FMxHEcyzEzWdfOOEHCKiH9DKP418tidVQX8rhRojxao9xZLoKUodgkKxyFwpZHl+O9uep3WMpUammD3S023mwuGkWTXbVtdMYdIgp3gYKIgjW3skcpi1NbEPKlkI5/iNzlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9D+ZM5onaRpJc/RkBaZzPhXFE1ostpj44JdkTwpn374=;
 b=t4+l4Wl7LqmkvyRZR5bttiZq0rgTL0P7eEMDiSHebmGi4f5vMqn1YYN7FxLNhcsUvUsznlY0vsw5ftIQ+o3IYD5jqFfSNoQ9LdzuF0NYEc7yhKiRAZKXMVpKeHm1iv58+L5supI8rb6cCkFeNX9y9xNFWiSv5IZLZxLwslKMM6Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by SA1PR12MB9492.namprd12.prod.outlook.com (2603:10b6:806:459::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 03:39:43 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 03:39:36 +0000
Message-ID: <cf2f615d-2a28-45ec-8bb9-563c2a5bde73@amd.com>
Date: Tue, 25 Feb 2025 14:39:29 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 08/11] PCI/IDE: Add IDE establishment helpers
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>,
 Xu Yilun <yilun.xu@linux.intel.com>
Cc: linux-coco@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>,
 Lukas Wunner <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>,
 linux-pci@vger.kernel.org, gregkh@linuxfoundation.org
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343744264.1074769.10935494914881159519.stgit@dwillia2-xfh.jf.intel.com>
 <9f151a74-cc5c-4a7c-8304-1714159e4b2c@amd.com>
 <6d50f215-93c4-49a5-9ee2-f9775b740f92@amd.com>
 <Z32H2Tzd1UHCQEt5@yilunxu-OptiPlex-7050>
 <d71dd5c5-4c20-4e8e-abaa-fe2cdea4f3b2@amd.com>
 <Z4A/g5Yyu4Whncuu@yilunxu-OptiPlex-7050>
 <a11c82c3-b5fb-48d9-8c95-047ac4503dc6@amd.com>
 <67bd098f4dcd1_1a7729449@dwillia2-xfh.jf.intel.com.notmuch>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <67bd098f4dcd1_1a7729449@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ME2PR01CA0204.ausprd01.prod.outlook.com
 (2603:10c6:220:34::24) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|SA1PR12MB9492:EE_
X-MS-Office365-Filtering-Correlation-Id: 79486d89-58c9-4bae-b5d1-08dd554e069c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y0JMd24rZ2VuU3E2V3R1cnZKcVQvelNYSTZQemIwWW1FOVJZQ01BMHE3cUda?=
 =?utf-8?B?N3RYZFMydVQxM3NCc2FxNXVwdmJmcThCcEUzWk9WRnNCZ0RVdENZZHl3a1Uv?=
 =?utf-8?B?ZUFIL3JkbGxkUDFYdjJ4MEhHZmU0dXg5cUg3RUZNRkNockgrdnlZTEd0QkJV?=
 =?utf-8?B?dXNsbFlJaWZOam5GSnpXUG1ldm5kdk5YQnl0YUwyOEVzOXVlMWErbEltQmJL?=
 =?utf-8?B?TkZiTjJXQkZMd2ZzM3JERzQxY21KQm14bXM1RHp4aTE5cWV4Q09NV2hOTDF2?=
 =?utf-8?B?Mk1oaW91RW5RbHg3K05vNk5VbDhIYnFBTDV6eXNYK0tKNXVBWHRJY2lJMUZF?=
 =?utf-8?B?WnFRdWIzU3ExY2Uwa1ZMQ0NGQlByc3hxS0oxWGE3NGlDRTlYNHM3YkhiYTVF?=
 =?utf-8?B?ejNSYWVQSExQQzBZcUE1Y1M2VjM4cnVkdDgvWW92dzJteGQzK2tvdTd3ZWph?=
 =?utf-8?B?Q0J3NGNrWGpvL0NyZzNUUlFFdElZWDludkVXL2hlOGEycGh1QnI5RTJzOUlL?=
 =?utf-8?B?QkZwN0Q0MDhVc0xqUmVlditjbzd4ZFhqVHhtV0xaejVXWDJFVmtuNEhHVjNI?=
 =?utf-8?B?dlUrR2FTc1d0dk5NN0RRRklRZE5YQ0p5UEhmeTFSeWNEQzlaa0o2bW1kZi91?=
 =?utf-8?B?SE9tczM3eWcyQ2p2UVQ4WGQ0Q2xtM2xzK0hUVzVra2llR3JlTGppYVRmMGxl?=
 =?utf-8?B?NGRoL0NOTlNjYjNaclFJUXdabHNaOW1EdE55d2NmdURNYkVZR2pzcjlwb0dk?=
 =?utf-8?B?dW9RNldybWpwSHlqbmlOUGlFU0hSUjRkRytWNGhUQ1RrMFRvZ3p0aWdlQWNi?=
 =?utf-8?B?NnJ6MUptMDRDM1hRZTgvR2kzSHlzenNpcVRhNDJBcVpjVXM3VnhIVXRxd29a?=
 =?utf-8?B?Wm9Bcm9JZ1FnWUo2dXZQaHJSWnBobmE4WHZaNU5XcytFWEZPLzRRSklyQVpT?=
 =?utf-8?B?N3VTV2ZmYU9RaUpSdDZkc0JnbDgzdS93MWswMGtZYnQ5YnEzbnJyc25JMGdt?=
 =?utf-8?B?RGlQU3k5ZnJWSTlXTVQrWFNsTFJDYTlCUytsTXZDMFZyVDMybFVVcnYzR08w?=
 =?utf-8?B?cTQ3ampYUWpXMUEvUUl5T2lCWXNCNUxoWlByTmNDRjgxZTJ6OEluZHpKeEFY?=
 =?utf-8?B?Rk5UYlVmcVFBS0pjVmRRRFR6MjF6Rms0WkVOWmt1ZVhoVnhyYXdwRTZWTyth?=
 =?utf-8?B?UVRMMVFLcmtqUGlFdDVSa1BveGtOSlBINm9hTWpmZGZpRlZGZm1JVms0NGlw?=
 =?utf-8?B?Tkg4NzVBNXVpeE5EVEZRekxtMUlUSFlvUXFqTFdmdTRDR09xTTllM1BkUjg3?=
 =?utf-8?B?SGphcXI5cjRNdktMcjNqdWNtWm9hZXl2aWFPS2psNG04ZUI2ZExKV2ZnRmoz?=
 =?utf-8?B?Rm4vRjNDM2xDR254bWdFOURMa1FPVEN5RzNqeXhDQXlHQlBaTllLWmV5clda?=
 =?utf-8?B?WElMVnhvWTVyd0hMTHJnMzBIRXhMcE5Od2RNaFh5dmMwcHB4a25hUjY2VDRx?=
 =?utf-8?B?L25sc0FpNGEzd3V4Wm1vdnJwY0lKcDlzRnBTczB3SnAra2s1NitkeDlYK1J1?=
 =?utf-8?B?czB0b1AxVVQ4MW1lZ0pUaVZwNUgxUzhPeWd6Y095WDJIU2FQNjhBY0pnbWI0?=
 =?utf-8?B?dnRWcU93SGd4eElaU1drTFJLRVNzQVcyRnhGWFNzZ1VZdGJzZzQwVVduODNi?=
 =?utf-8?B?OXdYWHJ0ejZMV1FENXBTeCtpK0t3UnFsUEpuMHh0aU8xdmwxTWZ3VHpSeERl?=
 =?utf-8?B?ZHpxYy85a0lqWnBJSm11MlZsV3U0SlJmNVJRTmhheG1veDM0RThmNlFzSmV3?=
 =?utf-8?B?RjZlc1dwVGdGQUNDc1piZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0lkbHlUVE5QWW4xanF0azZNOXBJeUxQUEJ2VkxQU3lRVFk5bjVGa3Y3Q29Q?=
 =?utf-8?B?MU5TWXpmSFB0YTBManBQS0hDcXpzZk1RcmNlZVBtQW5kWU5Bdm1tT2owK2RC?=
 =?utf-8?B?UDliK3o4QmIyZnJNRzdYWGZGdUFpZlA1bjV1NEV6OHMzcVV0S1lFMEhwaWsx?=
 =?utf-8?B?UTVHWHBxelFFZll5STVpRkZjRW5iUk9XdC9FUWxhemV4dVdaRmlVZUVFKy9N?=
 =?utf-8?B?ZDg0cy94ekc1LzYvanJaMUpDS2ZWUXJ3bHVrUG4yUzBobzdVRFNjTXdTQWJk?=
 =?utf-8?B?b2d0S29nVS9jalo5RDgrVkI2RHNJOHJlSnBBOU56eG5xa1VuK1ZGK3F2L1Fq?=
 =?utf-8?B?bUxYbmZNeEovaytDUG9mbjlSTjVtck9DN1BtaklITCtLcHpPdkx2WktkRTZo?=
 =?utf-8?B?dnlFeE9rZjBvWG1DQ3dpWTlwTVlBbzBraUNWRWs1K0xaRHAxcW5sOVptdUdR?=
 =?utf-8?B?bXZ0dDhkTlV5VUo0alg2eitJbTYzblJSdzJUWlhIOVZScXQrOTJjK1hDMXlG?=
 =?utf-8?B?WWpEN2VtMzV4MllvamNVVFZyKzA0TGVSTzVQLzZ1Rk1uOTA1aVcxTXF2UGU0?=
 =?utf-8?B?c2RXa2ZPdkdOM1JBaVdRMTZPYlNyQjZFZUNPNlB0VXZZRGJDaStnYmRLcExT?=
 =?utf-8?B?U0wvQjBJcHVXRnVFQ2VJWm5Za2pJSm1xZzNSZWp4QStscnBscmJFNGd2bTN3?=
 =?utf-8?B?QjNwMVM5emZlN1FLZDlVWGRqY1hoZEFxUW5pU0tGWVZTRnJCNytQSmJLOExC?=
 =?utf-8?B?SVV6aFlDR3l6eWxTenUwYXJJMnV2b1ppUTJ4UkYrVVlqMmN1dFdFb3JyamE1?=
 =?utf-8?B?UWxzOWVZVXF0a2dyVUNxUUZpOWZBdXN4dFpUbmlUOGR4enBYOExVa2Q1ellh?=
 =?utf-8?B?enV0WkdVcDJMNXJZL2VpQkxiMDJFOWhPRmNqajVaVEtlZmNNTWhvTzYrUk5t?=
 =?utf-8?B?V1NrOHR3K3dpWDJydWU3OFRwYUFvSGVSREc5czJzemtVSWNkNndNejk4T2wr?=
 =?utf-8?B?WE1NaklVdlJlalhjcWh3QlJUTENQT0hNelpYci9hR0tPVm8wYW0ranB6bE1t?=
 =?utf-8?B?SkJzNzVodFZqTllZR0lnZ3k0WjFSU3MvTkNmTEFrZ3FRTFpoRnFXNnNsVE5n?=
 =?utf-8?B?WTBENXplNU1qUmh0U0pCWmp5M2g4UG1aUWd4U1VPc2QvdnRQaGsvdW44RXll?=
 =?utf-8?B?ZzdnK084dmEyZ2I1L1NTSjBvUEJZZnlFbXUzZE9ib2wrR3VJa1l5eExPbGJF?=
 =?utf-8?B?aHMrWXFzSkhTN1U4YzYrdldvR201OU5KUHZsTFoxYnhHTFRLVnNyS1YvclU1?=
 =?utf-8?B?cXZEbVhCblZCQWllclJvNUNIS1Z2bWFnZzl5cnBXYXE2bU1FZG5taFIzY3JE?=
 =?utf-8?B?TThhblgvM3RqemFKTk9JRVNhR0diWHNVOE5YemwvNnBIblZibTd3Z2V1eFk2?=
 =?utf-8?B?RVZidTR2MUpJc09yRmUzKzJ5QUtLUFJ4SVhRcnlUSlVBNTVKQ1hvbTI4Lzlt?=
 =?utf-8?B?RWlsME5vb3NKWmVjUm05R1F3TzFNWll2azl3dHVzV2llcDNRTGdPbXNDK25Q?=
 =?utf-8?B?alFNd1VoTVQ0S3dMTnNKK3V2b1JWekJBblFqWllLdWsrTVBsdDloVmlOdlJy?=
 =?utf-8?B?NGRRQjlzUGtUR0xGSTNwSWhhTjhqK3dERzNQVm5pTnp5MWR0bmVlSUpLV2FX?=
 =?utf-8?B?bzdYVnhaMGg2Z0pwR0hXRkpETEJQN0R5eU1RRG1uVjJ2WTR0Yi85L21WRjNY?=
 =?utf-8?B?cisxTlQwY05KZHUxbGhOc3VCL0pvRzY4d29BMVE3di9oNUcrUEpmc29vVTJX?=
 =?utf-8?B?RWV6b1V2bW95dkhpV3BGNHZiOGw5VkNNZFFsc1B4U3BZTE9xZlhsQXRMOWR5?=
 =?utf-8?B?dDJFQW9CU0FkZjJUVFNOTG5WNEc3aDRtNFRCL0lSMmtMTlVDZFZsalF0M2Rv?=
 =?utf-8?B?RzgyeHV6eUhNZ1V0L0xVRUgva0djTEZ1ZkFkNWNxdXMyamtiN3ZnQkpWMTcw?=
 =?utf-8?B?SWdlcXdTWUJsYUdxcjdHUG4zNGFNY25XdG9MdXRGUVJzeEtTdjZ3ZTcvVFU3?=
 =?utf-8?B?b2RPTWhJMUkyRHdCaWdHNUpOcHliL0dzV3hnSS96UzVqS2IrdTZQcVpJRUxT?=
 =?utf-8?Q?QAAmH/a1SZW73V8so50VQTfY9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79486d89-58c9-4bae-b5d1-08dd554e069c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 03:39:36.8443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j+OjJt/GU4bVK+BtpopXZcpInCLWJdk+ufjV0tMJlj3F+qFfgSv1N/xrunumwEp1rQbSMfs2YpmJ6A2NnKjQrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9492



On 25/2/25 11:06, Dan Williams wrote:
> Alexey Kardashevskiy wrote:
> [..]
>>>> access to set T-bit). The device got just one (which is no use here as I
>>>> understand).
>>>
>>> I also have no idea from SPEC how to use the IDE register blocks on EP,
>>> except stream ENABLE bit.
>>
>> Well, there is another problem.
>>
>> My other test device has 1 link stream and 1 selective stream, both have
>> streamid=0 and enable=0 after reset. I only configure 1 selective stream
>> (write streamid + enable) and do not touch the link stream.
>>
>> But the device assumes 2 streams have the same streamid=0 and when it
>> receives KEY_PROG, it semi-randomly assigns the key to the link stream
>> in my case so things do not work. The argument for it is: every stream
>> needs to have an unique id, regardless its enabled state as "enable" can
>> come before or after key programming (and I wonder if somebody else
>> interprets it the same way).
>>
>> This patch assumes that the selective streamid is the same as its index
>> in the IDE cap's list of selective streams.
> 
> Oh, true that should be separated, and perhaps that is the concern that
> Aneesh has been raising as well?
>   
>> And it just leaves link streams unconfigured. So I have to work around
>> my device by writing unique numbers to all streams (link + selective)
>> I am not using. Meh.
> 
> This sounds like a device-quirk where it is not waiting for an enable
> event to associate the key with a given stream index. One could imagine
> this is either a pervasive problem and TSMs will start considering
> Stream ID 0 as burned for compatibilitiy reasons. Or, this device is
> just exhibiting a pre-production quirk that Linux does not need to
> react, yet.

The hw people call it "the device needs to have an errata" (for which we 
will later have a quirk?).

> Can you say whether this problem is going to escape your test bench into
> something mainline Linux needs to worry about?

Likely going to escape, unless the PCIe spec says specifically that this 
is a bug. Hence 
https://github.com/aik/linux/commit/745ee4e151bcc8e3b6db8281af445ab498e87a70


> 
>> And then what are we doing to do when we start adding link streams? I
>> suggest decoupling pci_ide::stream_id from stream_id in sel_ide_offset()
>> (which is more like selective_stream_index) from the start.
> 
> Setting aside that I agree with you that Stream index be separated from
> from Stream ID, what would motivate Linux to consider setting up Link
> Stream IDE?
> 
> One of the operational criticisms of Link IDE is that it requires adding
> more points of failure into the TCB where a compromised switch can snoop
> traffic. It also adds more Keys and their associated maintainenace
> overhead. So, before we start planning ahead for Link IDE and Selective
> Stream IDE to co-exist in the implementation, I think we need a clear
> use case that demonstrates Link IDE is going to graduate from the
> specification into practical deployments.

Probably for things like CXL which connect directly to the soc? I do not 
really know, I only touch link streams because of that only device which 
is like to see the light of the day though.

> We can always cross that sophistication bridge later.

Today SEV-TIO does not do link streams at all so I am with you :) Thanks,


-- 
Alexey


