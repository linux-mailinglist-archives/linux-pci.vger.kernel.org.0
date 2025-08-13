Return-Path: <linux-pci+bounces-33896-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F15BB23EAA
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 04:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 556063B2C6B
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 02:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A6423ABA8;
	Wed, 13 Aug 2025 02:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4p0VwWVu"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2054.outbound.protection.outlook.com [40.107.96.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FD4199230;
	Wed, 13 Aug 2025 02:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755053844; cv=fail; b=kn2cOJZDuHBWEGJMGsw3JS2qwF53SdAzuKhPooVEDSnaUaFsIeC9P28uhDnB1bSq18fI4oybfPeuSto3AjLrOPP/qN+fz4TS7r8GR5WmHOXJrHac3Z+vYR6FF00GB/IioR/3+QqbtjNQBrZUgQmeNBadOzegIFfQpy384F2PEPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755053844; c=relaxed/simple;
	bh=yAZQ7Cm9SDmSfoSgnrNiJW1cwBeq/+IHkobWjSJwrtI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KpepPzQHsm4Zu3So4/ubNrcl3nVo83dyaOg4CEUY0Ba00qZa6R0xfWnnQzxLwmwxNo7CqjnLesx4l9cY+8oip0sdaT2Ew94oOWOZbCti23jqkq/sLyksMJKUtw5rAY5aX0mUs6tg2Fn/+abbwNnsysAHIvX3T4F/gX552YQwp9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4p0VwWVu; arc=fail smtp.client-ip=40.107.96.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nd7/MJFy/Z/po4i7wHGizXBcrtSeaYh389TsyHMST6Or8PRpq6s+A5321vqFxcDs2aU2xu8eNCRG89a5z690TX1lSKcb/9f2eUiqVh6CKssmUbkKf6YuAJQeGmtETiHtbBYaShxbicVA/qy5X3OGFxMY6sKvWVyvpw6FrXIW5WFZ5MfxWXiysvlqKCnmZNo2khByzm5xXbkl/FaI25JNVbt+zK048FFqTQQB6FqTOWdXdTzJD/xr4jjNjjW854wFeVGNUNBRN23x0v66psVHfUp3Xehlb3koPv0FwBdycUQzF+ui2kUukAcdMvKv1sAE9Lzpj7AP6YayymNa0tPQbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6BawrR9jl68GXkmbQqRwxno+sNuiIocharzt0/IG7/4=;
 b=enlt9zmDUeTuQVwLuZQ4gR8vjFwK/ZNrpS1WOXH4Ykt6Rhjcwy6D8fdVTA4SvJiOV5N86u7f5TngJBLnBWsCIR9qwv56fBslP+p+rpPDz7Mj9pYvNFmuLKQ84CnvFncUkNSNMREbPMqiyj9ow5xHjwf2MoQ2DcKS9qimF9upiZ9l7LjsNgCTopGIHiZIEWkO4Lllkf02OAoNEB7UOOMV+KZo78oqeHhfkruYxtofIKsK0eIl5kwOAkBCXqen5Z6jAOlEASb+yD5oH/MYfhRKvW3Bti+NXG4T3rPKGtX+tPoQnZVUmzFlcJ0V8rhbPdU69xzJeqo/WqiWWY8BLXf7Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6BawrR9jl68GXkmbQqRwxno+sNuiIocharzt0/IG7/4=;
 b=4p0VwWVuomcidxznTmHriKX5qbM7S0Mo2eIjFhAg/EwzHU4N7SQER9TKnWupR7r+x4QwvZVNg+k4KlYr6qieHrrEzfF6XAm/579OVPDzMxU8M7RHxaya1yIdwfGPpo1X8k/dzcaqskp0KyA+z6JuF/xhYnaq8zgrDmOomGiU8II=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by MN2PR12MB4438.namprd12.prod.outlook.com (2603:10b6:208:267::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Wed, 13 Aug
 2025 02:57:16 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.9009.021; Wed, 13 Aug 2025
 02:57:16 +0000
Message-ID: <7b6782da-1318-4dab-8230-e59a729f8f11@amd.com>
Date: Wed, 13 Aug 2025 12:57:10 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v4 04/10] PCI/TSM: Authenticate devices via platform TSM
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, bhelgaas@google.com, lukas@wunner.de,
 Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun <yilun.xu@linux.intel.com>
References: <20250717183358.1332417-1-dan.j.williams@intel.com>
 <20250717183358.1332417-5-dan.j.williams@intel.com>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <20250717183358.1332417-5-dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5P282CA0141.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:205::19) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|MN2PR12MB4438:EE_
X-MS-Office365-Filtering-Correlation-Id: ebfd36db-d57c-4814-59a7-08ddda151bff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZU1kYVpCTVBVR2s2SW90ODFCaWNkU09yUjBRVFMwNk1hY0tSSlNoVTYrTEhl?=
 =?utf-8?B?MXlnYVA4Wi9CK0RFZlUxOEN2WHdBYkFWc3h1VWR0ZnYzMGdGL25oazM1aEd4?=
 =?utf-8?B?Sy93bFNmRjBvdWFxYy9WaklyNW1nR0ZUSitsUlNKSmUwYVU3UTVDbEJUa3ZY?=
 =?utf-8?B?ZHhabkYvVmordW1LTGN6VjZDSGhqamQ1WGhlM3Y5U3hvQmh0U09QRUFlT0Mv?=
 =?utf-8?B?dnFFRkRVS1lmVkZWMXRoRkQvU3NrZHJSUXVJa052bjNNRzFzRlBySHRuNW5i?=
 =?utf-8?B?bGJ6cjFVRnNGb2V2WUhseGd2NlB0cnZvZElEOEQrUmliOHdaWTRRRnNYT0FQ?=
 =?utf-8?B?M2Q5NnJGN1BHMDlDMmJLR0gwUlBvWE51SGxtbU0rUjQ1RldwZjUwQUF6WlI4?=
 =?utf-8?B?NzBJU2lBOFNiNzRiVWYvRHVZYWlSWUVHYXRCNlB3dCtBbzluNGZUd25HdmJi?=
 =?utf-8?B?bmpqVmsvQmQyOEk3WVlrbjlnSHhrNHBmWHNjdm9KTVhoOW1HRm5CTFZnaUR4?=
 =?utf-8?B?VTZUYklCcGF0cVNkQ0VoOXIzdUpTTnYyV0JVMmh0WXRndndxTCsvOUsxSEEx?=
 =?utf-8?B?ZXljNGsrMCtzVzZ5a0x4UDNVOG13ODQ4ZTFPVFRiV3FDWlNWbjFZazNpMkV2?=
 =?utf-8?B?R3pabVMrYzB3OWVyaFBncFM2di9wYXY5ZXNJRExkY3AvNkVGdFlsKy8veS8x?=
 =?utf-8?B?Tnk4VlhsNkR4LzkyeDRNVHdBL2pZbkY4WFdTbEhmeHdOdngySmpUekVNbHRN?=
 =?utf-8?B?S2hLcE9oZ3lqR3pEaTYxSFl1KzEwRjZhUGVaOGlsaHpYcU5aMFl4TEZXZlJ1?=
 =?utf-8?B?a2tUNGVUVkdXNlVpbmFZS1NtRmhocWNveDVDNnNncE9vMThEZmJNaGZROC9s?=
 =?utf-8?B?NXlJQ2JzNXBxenlSdXpJWERCemxVVmJJOE95MGVGZVJmdFZYTWczVU1MWlQ1?=
 =?utf-8?B?ZTFuL3hHNDlOL2VQSStQQXlpU2MxNFZkNlZrYTFBblVPWDhpcnE4YVVLVldz?=
 =?utf-8?B?L0ZrMFZxOXJoSFlVT2dGYUU2MTk0ZFhLbHJhTitqbjlFcUd3aVhtUDd2aVor?=
 =?utf-8?B?S21RSTd0MGIxd0JZSFZKMGdKaUZHZ1ZydW4yVWQ3cVZZZWVTdVV5L2Z4RzFW?=
 =?utf-8?B?LzlzU3ZPN3poWGxYZEJNM00zclRPcFlVVU1XTGFMMzRJVVhIeDJPSnlnUGoz?=
 =?utf-8?B?TStNSVVHa2hVeHpMZHpuRG1QVzViQVlUR2l6cFZwTmkvY3BwYmFhT216OWZC?=
 =?utf-8?B?WEJGMFB0MXJtSUtLUXV3cnBhbE1CZnhzUU5mdTJITXFwSkRXeEpPWGF3NFB6?=
 =?utf-8?B?R3lUSHorVzQyeVJXeHdLNytkYlNSSzNqTG1QWnRKdXo1SGlpSzA5ZTliY3dE?=
 =?utf-8?B?S0dEUWlNSWUyaDg1dDZzSGhzbFQ1T2Jza0drRzF6Q2l5Wjk1RkdKVWNmV3M2?=
 =?utf-8?B?NkpISkdvZk1pTU1uVDE0TDlmWkJTanVQbWhIdGxZcXVrZzZiNk9pd0dlTDdr?=
 =?utf-8?B?Wlg2T1JWVlRsbm1xekJsMWJLUXNQa2tCaEEyeXFNejEvengwcmkyUTBFQy95?=
 =?utf-8?B?UzBKVHAyZkJhNXYvdW5pSS9mTFB2NCtSUk5mS0lqaXI2azlSWTAwMVNUbU9n?=
 =?utf-8?B?NWxtcmtGVE4zNlVBamlGbWlqYU0zOC9PVGQ1VjVIbFNqUXpDWTdYVzhrWU5S?=
 =?utf-8?B?blQzZkRiSzdtcGk5MUJCMG9zcUdQdzR3ZkhsOWV1QXk4MzFrSzBWZE1xWWR0?=
 =?utf-8?B?elVXZnlvU2x1SnRkM3dRTjM5WVh4SFQ2c01oQzlUZEdwd2ptbVd1azBJZ1hV?=
 =?utf-8?B?NXhmWU5RenFidzh1MWJHNjdGZXNwRXBndk1oOVVVaXhkeTRJaDlPTE5BbEhh?=
 =?utf-8?B?RkluY3J5TVBwYUlaY0lkOE5oSWN0TmliSUl5c2o1dnIzdEpCNjVDNTJqbUh3?=
 =?utf-8?Q?/oZF0SdY3QA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WEVFNnRDVUpZT1dkVHQzdnBlRzh5OGVEbEM5MjZJRjh1OWYva3JCTXBOOWVi?=
 =?utf-8?B?YnRFNi9TTk5WTG5qeXE3OWxnRlZma3lUcjQ5OHo3dkFlOGt1RldNSHVVbHVM?=
 =?utf-8?B?K1ZvemZnazlQakFpT0gwVTFsVVI4bUxEa2NuZThnQ29xR1UzeVJjcjhHNlh5?=
 =?utf-8?B?RjFMREE3L2ROYWp3RE9IVW9wTGRPSHJTRDNqMmRYMStCbWhZMXVYNlZTRkEw?=
 =?utf-8?B?M3pWUmVMaFY0akVPVmtXY0FsUDVuR05BKy9Sc1BaVEpvNnhSQ3dWRUFzNWlw?=
 =?utf-8?B?R28zR0NDbTNDZUVHUzhOeGVaMzBkczFwZXVmZDBPUnpmR3U1bS83V3RQZWVN?=
 =?utf-8?B?V3ZWTXlLS3A4Q0MvbDZ0cE40Z0ZCR2d6TnlobzdXMGo1NUsvZlNwMkxvblhu?=
 =?utf-8?B?eVRvckxSOEk0YnNQNjVkNFJ5Skczalp6UlhOS1NvS2JHNVp1WFNObWF0a2FU?=
 =?utf-8?B?V2tTaXBrYUJIRXgrMEdlYUVoNnE4amcxOERreGFwWlpCQVZZaDM4YUFWdTJ5?=
 =?utf-8?B?bzlMQnRPYTZscDl0ajNJZ09yUk1jbzlZTVJIa3FQd04xZEM3ZWFjRm55cG80?=
 =?utf-8?B?U1BLZ1lVdDN3dHBaUE96T053bzhwYTVVeTIyV2JkK2hmTHBncGxqUDBnMlh2?=
 =?utf-8?B?SGFDai8xNFhHeHBLeUZIM0s2QzUyb25NeGllblRrN3lldnpxajhWdjRXUnJJ?=
 =?utf-8?B?UXRUWFY3SW4xemtJV1RaMy9rRW8yUFBqMS9Fd1N2ZDdBQ05LdTZzWU1mMzE2?=
 =?utf-8?B?MGEweHdPTENhanpBYXRyc3ZpVXM0UXhnTFFtaTlFb0tzbFNFb1pPNEhLd0lI?=
 =?utf-8?B?dDhNQzY5L2UwaHQ3S0FSdXRleEYyTWJ5cVJ2b1pwRG4veWVtVDBTMFJybTND?=
 =?utf-8?B?VWJIWGwrbDdhQ1R0dE9LNUtJRWhEN0VoSkFLbnBOU1ZBODFjcVhiSzY1UDVs?=
 =?utf-8?B?UE9SQVY3bER1emI2MGQ3MDhFRzY4ZkRHRXk4R2hnRjN3N2xocCs4MDRLcFlu?=
 =?utf-8?B?d2QyVmlPVWJoc1pneDF3QUYxSzl5U3dPK21JZzQrbVp2d3pySWdBNkZnTFRB?=
 =?utf-8?B?UjN0UG0wSzZxMWlHOVRQTks0cEhkSWgrK1dqSitzc0k0VmNoR2UyUVN2dUlO?=
 =?utf-8?B?QXBBYWc3VlI4bCtaa2c0VklwWkRKT1lwYXBoTlVoOXFjUU4rMm5OaDRKRVhh?=
 =?utf-8?B?elN0UGI0WXVUdlBRa3hiOEx6NTJvS2J2YTVtcjBDOCtXTzVraUM0L0xDTFoz?=
 =?utf-8?B?eWxQWDVtU1lwTFppRHBlcE11NlJXek4yV0tjZVRpYzFGK2VpbXFDdWVpMnB2?=
 =?utf-8?B?MFFEUzJzYlZCU3BMZlVBSnloOWt3K0Y1RTFaNzhCWWR4SkU5WWhIbGZhei9W?=
 =?utf-8?B?SEU1WXJGNk03MUsyYzBpRmlEQjc3WW52dlB3bEZHbWsxVmsxYVVCWWpmYkFT?=
 =?utf-8?B?WVpuVyt1N0hDdjk0OTVEeDVZNFUzQW1wU3hqb2VSOXVlZVNEeVp5ZW5Nd3F1?=
 =?utf-8?B?OGxOTXZQSUdneWUvU1p3VEEyczdsODJ0MEhybnVkY2I2VmRkOWdrNUNUYkgw?=
 =?utf-8?B?dFFBeUN1cWExZnlsQWNLc3A4MjNqelJaVlErZnd6SFQzQ2IyMTdkeVE1MzZS?=
 =?utf-8?B?MFl6cjNHVEFMS3IwelZsOGlrQmdqT3pXR0FobHowMVcyUHF2N0laZzBsN2pB?=
 =?utf-8?B?QkZ5cXdmVU4yenNkTEhaSTMrSFJ6QXhNTXhqYlg2cFNtU1k3V0hHaElkZHJ6?=
 =?utf-8?B?dVZMQ3hWaVQ0ZnVTMDFvVEw3QzgraVNoUkVIcC9USzN4Z2o3NWNWNVZ5VzVX?=
 =?utf-8?B?dHQ4aEdyeE1YR29YeTVVTDFGOWtvR1lTeURDSVdIRlpHbERGZFZKSmlLdWRv?=
 =?utf-8?B?QlU0RGg5MGduQStGdkxiZ29wYnhmenh2VWhzdFJ6RUhDSTZUZU5KaTFwRzU5?=
 =?utf-8?B?TTBMQmhYSlFUSERwb29lN1B0RmN6cVVmY0lvOEg4OU5nZjhLck5QWnE2L2ZH?=
 =?utf-8?B?NzgxRkdiQTQyTGVqZTNvVXh5QXF4K090MGJ4VCtKZEZoK09ONHpvdGNBMVRD?=
 =?utf-8?B?Y3BkV09FMjFMNnh4cEQ0RmkzeWc1L1JCcUlhbis4OVoxU2x5bVVsU0o1a014?=
 =?utf-8?Q?UYRVFhkmyu/w70JLozmXq3a3m?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebfd36db-d57c-4814-59a7-08ddda151bff
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 02:57:15.9091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SrZVYX5v+cwMMHzi8g9WUBi0vOOPgRGAFOkqR+REJRCjoBzW7pL3yZmJw98ec7FxQh4GwINHii4XNrZyjpWjJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4438



On 18/7/25 04:33, Dan Williams wrote:
> The PCIe 6.1 specification, section 11, introduces the Trusted Execution
> Environment (TEE) Device Interface Security Protocol (TDISP).  This
> protocol definition builds upon Component Measurement and Authentication
> (CMA), and link Integrity and Data Encryption (IDE). It adds support for
> assigning devices (PCI physical or virtual function) to a confidential
> VM such that the assigned device is enabled to access guest private
> memory protected by technologies like Intel TDX, AMD SEV-SNP, RISCV
> COVE, or ARM CCA.
> 
> The "TSM" (TEE Security Manager) is a concept in the TDISP specification
> of an agent that mediates between a "DSM" (Device Security Manager) and
> system software in both a VMM and a confidential VM. A VMM uses TSM ABIs
> to setup link security and assign devices. A confidential VM uses TSM
> ABIs to transition an assigned device into the TDISP "RUN" state and
> validate its configuration. From a Linux perspective the TSM abstracts
> many of the details of TDISP, IDE, and CMA. Some of those details leak
> through at times, but for the most part TDISP is an internal
> implementation detail of the TSM.
> 
> CONFIG_PCI_TSM adds an "authenticated" attribute and "tsm/" subdirectory
> to pci-sysfs. Consider that the TSM driver may itself be a PCI driver.
> Userspace can watch for the arrival of a "TSM" device,
> /sys/class/tsm/tsm0/uevent KOBJ_CHANGE, to know when the PCI core has
> initialized TSM services.
> 
> The operations that can be executed against a PCI device are split into
> 2 mutually exclusive operation sets, "Link" and "Security" (struct
> pci_tsm_{link,security}_ops). The "Link" operations manage physical link
> security properties and communication with the device's Device Security
> Manager firmware. These are the host side operations in TDISP. The
> "Security" operations coordinate the security state of the assigned
> virtual device (TDI). These are the guest side operations in TDISP. Only
> link management operations are defined at this stage and placeholders
> provided for the security operations.
> 
> The locking allows for multiple devices to be executing commands
> simultaneously, one outstanding command per-device and an rwsem
> synchronizes the implementation relative to TSM
> registration/unregistration events.
> 
> Thanks to Wu Hao for his work on an early draft of this support.
> 
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Samuel Ortiz <sameo@rivosinc.com>
> Cc: Alexey Kardashevskiy <aik@amd.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>   Documentation/ABI/testing/sysfs-bus-pci |  51 +++
>   Documentation/driver-api/pci/index.rst  |   1 +
>   Documentation/driver-api/pci/tsm.rst    |  12 +
>   MAINTAINERS                             |   4 +-
>   drivers/pci/Kconfig                     |  14 +
>   drivers/pci/Makefile                    |   1 +
>   drivers/pci/pci-sysfs.c                 |   4 +
>   drivers/pci/pci.h                       |   8 +
>   drivers/pci/remove.c                    |   3 +
>   drivers/pci/tsm.c                       | 554 ++++++++++++++++++++++++
>   drivers/virt/coco/tsm-core.c            |  61 ++-
>   include/linux/pci-tsm.h                 | 158 +++++++
>   include/linux/pci.h                     |   3 +
>   include/linux/tsm.h                     |   8 +-
>   include/uapi/linux/pci_regs.h           |   1 +
>   15 files changed, 879 insertions(+), 4 deletions(-)
>   create mode 100644 Documentation/driver-api/pci/tsm.rst
>   create mode 100644 drivers/pci/tsm.c
>   create mode 100644 include/linux/pci-tsm.h
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> index 69f952fffec7..99315fbfbe10 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -612,3 +612,54 @@ Description:
>   
>   		  # ls doe_features
>   		  0001:01        0001:02        doe_discovery
> +
> +What:		/sys/bus/pci/devices/.../tsm/
> +Contact:	linux-coco@lists.linux.dev
> +Description:
> +		This directory only appears if a physical device function
> +		supports authentication (PCIe CMA-SPDM), interface security
> +		(PCIe TDISP), and is accepted for secure operation by the
> +		platform TSM driver. This attribute directory appears
> +		dynamically after the platform TSM driver loads. So, only after
> +		the /sys/class/tsm/tsm0 device arrives can tools assume that
> +		devices without a tsm/ attribute directory will never have one,
> +		before that, the security capabilities of the device relative to
> +		the platform TSM are unknown. See
> +		Documentation/ABI/testing/sysfs-class-tsm.
> +
> +What:		/sys/bus/pci/devices/.../tsm/connect
> +Contact:	linux-coco@lists.linux.dev
> +Description:
> +		(RW) Write the name of a TSM (TEE Security Manager) device from
> +		/sys/class/tsm to this file to establish a connection with the
> +		device.  This typically includes an SPDM (DMTF Security
> +		Protocols and Data Models) session over PCIe DOE (Data Object
> +		Exchange) and may also include PCIe IDE (Integrity and Data
> +		Encryption) establishment. Reads from this attribute return the
> +		name of the connected TSM or the empty string if not
> +		connected. A TSM device signals its readiness to accept PCI
> +		connection via a KOBJ_CHANGE event.
> +
> +What:		/sys/bus/pci/devices/.../tsm/disconnect
> +Contact:	linux-coco@lists.linux.dev
> +Description:
> +		(WO) Write '1' or 'true' to this attribute to disconnect it from
> +		a previous TSM connection.
> +
> +What:		/sys/bus/pci/devices/.../authenticated
> +Contact:	linux-pci@vger.kernel.org
> +Description:
> +		When the device's tsm/ directory is present device
> +		authentication (PCIe CMA-SPDM) and link encryption (PCIe IDE)
> +		are handled by the platform TSM (TEE Security Manager). When the
> +		tsm/ directory is not present this attribute reflects only the
> +		native CMA-SPDM authentication state with the kernel's
> +		certificate store.
> +
> +		If the attribute is not present, it indicates that
> +		authentication is unsupported by the device, or the TSM has no
> +		available authentication methods for the device.
> +
> +		When present and the tsm/ attribute directory is present, the
> +		authenticated attribute is an alias for the device 'connect'
> +		state. See the 'tsm/connect' attribute for more details.
> diff --git a/Documentation/driver-api/pci/index.rst b/Documentation/driver-api/pci/index.rst
> index a38e475cdbe3..9e1b801d0f74 100644
> --- a/Documentation/driver-api/pci/index.rst
> +++ b/Documentation/driver-api/pci/index.rst
> @@ -10,6 +10,7 @@ The Linux PCI driver implementer's API guide
>   
>      pci
>      p2pdma
> +   tsm
>   
>   .. only::  subproject and html
>   
> diff --git a/Documentation/driver-api/pci/tsm.rst b/Documentation/driver-api/pci/tsm.rst
> new file mode 100644
> index 000000000000..59b94d79a4f2
> --- /dev/null
> +++ b/Documentation/driver-api/pci/tsm.rst
> @@ -0,0 +1,12 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. include:: <isonum.txt>
> +
> +========================================================
> +PCI Trusted Execution Environment Security Manager (TSM)
> +========================================================
> +
> +.. kernel-doc:: include/linux/pci-tsm.h
> +   :internal:
> +
> +.. kernel-doc:: drivers/pci/tsm.c
> +   :export:
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cfa3fb8772d2..8cb7ee9270d2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -25247,8 +25247,10 @@ L:	linux-coco@lists.linux.dev
>   S:	Maintained
>   F:	Documentation/ABI/testing/configfs-tsm-report
>   F:	Documentation/driver-api/coco/
> +F:	Documentation/driver-api/pci/tsm.rst
> +F:	drivers/pci/tsm.c
>   F:	drivers/virt/coco/guest/
> -F:	include/linux/tsm*.h
> +F:	include/linux/*tsm*.h
>   F:	samples/tsm-mr/
>   
>   TRUSTED SERVICES TEE DRIVER
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 4bd75d8b9b86..700addee8f62 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -136,6 +136,20 @@ config PCI_IDE_STREAM_MAX
>   	  platform capability for the foreseeable future is 4 to 8 streams. Bump
>   	  this value up if you have an expert testing need.
>   
> +config PCI_TSM
> +	bool "PCI TSM: Device security protocol support"
> +	select PCI_IDE
> +	select PCI_DOE
> +	help
> +	  The TEE (Trusted Execution Environment) Device Interface
> +	  Security Protocol (TDISP) defines a "TSM" as a platform agent
> +	  that manages device authentication, link encryption, link
> +	  integrity protection, and assignment of PCI device functions
> +	  (virtual or physical) to confidential computing VMs that can
> +	  access (DMA) guest private memory.
> +
> +	  Enable a platform TSM driver to use this capability.
> +
>   config PCI_DOE
>   	bool "Enable PCI Data Object Exchange (DOE) support"
>   	help
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index 6612256fd37d..2c545f877062 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -35,6 +35,7 @@ obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
>   obj-$(CONFIG_VGA_ARB)		+= vgaarb.o
>   obj-$(CONFIG_PCI_DOE)		+= doe.o
>   obj-$(CONFIG_PCI_IDE)		+= ide.o
> +obj-$(CONFIG_PCI_TSM)		+= tsm.o
>   obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) += of_property.o
>   obj-$(CONFIG_PCI_NPEM)		+= npem.o
>   obj-$(CONFIG_PCIE_TPH)		+= tph.o
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 268c69daa4d5..23cbf6c8796a 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1815,6 +1815,10 @@ const struct attribute_group *pci_dev_attr_groups[] = {
>   #endif
>   #ifdef CONFIG_PCI_DOE
>   	&pci_doe_sysfs_group,
> +#endif
> +#ifdef CONFIG_PCI_TSM
> +	&pci_tsm_auth_attr_group,
> +	&pci_tsm_pf0_attr_group,
>   #endif
>   	NULL,
>   };
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 1c223c79634f..3b282c24dde8 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -521,6 +521,14 @@ void pci_ide_init(struct pci_dev *dev);
>   static inline void pci_ide_init(struct pci_dev *dev) { }
>   #endif
>   
> +#ifdef CONFIG_PCI_TSM
> +void pci_tsm_destroy(struct pci_dev *pdev);
> +extern const struct attribute_group pci_tsm_pf0_attr_group;
> +extern const struct attribute_group pci_tsm_auth_attr_group;
> +#else
> +static inline void pci_tsm_destroy(struct pci_dev *pdev) { }
> +#endif
> +
>   /**
>    * pci_dev_set_io_state - Set the new error state if possible.
>    *
> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> index 445afdfa6498..21851c13becd 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -55,6 +55,9 @@ static void pci_destroy_dev(struct pci_dev *dev)
>   	pci_doe_sysfs_teardown(dev);
>   	pci_npem_remove(dev);
>   
> +	/* before device_del() to keep config cycle access */
> +	pci_tsm_destroy(dev);
> +
>   	device_del(&dev->dev);
>   
>   	down_write(&pci_bus_sem);
> diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
> new file mode 100644
> index 000000000000..0784cc436dd3
> --- /dev/null
> +++ b/drivers/pci/tsm.c
> @@ -0,0 +1,554 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * TEE Security Manager for the TEE Device Interface Security Protocol
> + * (TDISP, PCIe r6.1 sec 11)
> + *
> + * Copyright(c) 2024 Intel Corporation. All rights reserved.
> + */
> +
> +#define dev_fmt(fmt) "TSM: " fmt
> +
> +#include <linux/bitfield.h>
> +#include <linux/xarray.h>
> +#include <linux/sysfs.h>
> +
> +#include <linux/tsm.h>
> +#include <linux/pci.h>
> +#include <linux/pci-doe.h>
> +#include <linux/pci-tsm.h>
> +#include "pci.h"
> +
> +/*
> + * Provide a read/write lock against the init / exit of pdev tsm
> + * capabilities and arrival/departure of a tsm instance
> + */
> +static DECLARE_RWSEM(pci_tsm_rwsem);
> +static int pci_tsm_count;
> +
> +static inline bool is_dsm(struct pci_dev *pdev)
> +{
> +	return pdev->tsm && pdev->tsm->dsm == pdev;
> +}
> +
> +static struct pci_tsm_pf0 *to_pci_tsm_pf0(struct pci_tsm *pci_tsm)
> +{
> +	struct pci_dev *pdev = pci_tsm->pdev;
> +
> +	if (!is_pci_tsm_pf0(pdev) || !is_dsm(pdev)) {
> +		dev_WARN_ONCE(&pdev->dev, 1, "invalid context object\n");
> +		return NULL;
> +	}
> +
> +	return container_of(pci_tsm, struct pci_tsm_pf0, tsm);
> +}
> +
> +static void tsm_remove(struct pci_tsm *tsm)
> +{
> +	struct pci_dev *pdev;
> +
> +	if (!tsm)
> +		return;
> +
> +	pdev = tsm->pdev;
> +	tsm->ops->remove(tsm);
> +	pdev->tsm = NULL;
> +}
> +DEFINE_FREE(tsm_remove, struct pci_tsm *, if (_T) tsm_remove(_T))
> +
> +static int call_cb_put(struct pci_dev *pdev, void *data,
> +		       int (*cb)(struct pci_dev *pdev, void *data))
> +{
> +	int rc;
> +
> +	if (!pdev)
> +		return 0;
> +	rc = cb(pdev, data);
> +	pci_dev_put(pdev);
> +	return rc;
> +}
> +
> +static void pci_tsm_walk_fns(struct pci_dev *pdev,
> +			     int (*cb)(struct pci_dev *pdev, void *data),
> +			     void *data)
> +{
> +	struct pci_dev *fn;
> +	int i;
> +
> +	/* walk virtual functions */
> +        for (i = 0; i < pci_num_vf(pdev); i++) {
> +		fn = pci_get_domain_bus_and_slot(pci_domain_nr(pdev->bus),
> +						 pci_iov_virtfn_bus(pdev, i),
> +						 pci_iov_virtfn_devfn(pdev, i));
> +		if (call_cb_put(fn, data, cb))
> +			return;
> +        }
> +
> +	/* walk subordinate physical functions */
> +	for (i = 1; i < 8; i++) {
> +		fn = pci_get_slot(pdev->bus,
> +				  PCI_DEVFN(PCI_SLOT(pdev->devfn), i));
> +		if (call_cb_put(fn, data, cb))
> +			return;
> +	}
> +
> +	/* walk downstream devices */
> +        if (pci_pcie_type(pdev) != PCI_EXP_TYPE_UPSTREAM)
> +                return;
> +
> +        if (!is_dsm(pdev))
> +                return;
> +
> +        pci_walk_bus(pdev->subordinate, cb, data);
> +}
> +
> +static void pci_tsm_walk_fns_reverse(struct pci_dev *pdev,
> +				     int (*cb)(struct pci_dev *pdev,
> +					       void *data),
> +				     void *data)
> +{
> +	struct pci_dev *fn;
> +	int i;
> +
> +	/* reverse walk virtual functions */
> +	for (i = pci_num_vf(pdev) - 1; i >= 0; i--) {
> +		fn = pci_get_domain_bus_and_slot(pci_domain_nr(pdev->bus),
> +						 pci_iov_virtfn_bus(pdev, i),
> +						 pci_iov_virtfn_devfn(pdev, i));
> +		if (call_cb_put(fn, data, cb))
> +			return;
> +	}
> +
> +	/* reverse walk subordinate physical functions */
> +	for (i = 7; i >= 1; i--) {
> +		fn = pci_get_slot(pdev->bus,
> +				  PCI_DEVFN(PCI_SLOT(pdev->devfn), i));
> +		if (call_cb_put(fn, data, cb))
> +			return;
> +	}
> +
> +	/* reverse walk downstream devices */
> +	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_UPSTREAM)
> +		return;
> +
> +	if (!is_dsm(pdev))
> +		return;
> +
> +	pci_walk_bus_reverse(pdev->subordinate, cb, data);
> +}
> +
> +static int probe_fn(struct pci_dev *pdev, void *dsm)
> +{
> +	struct pci_dev *dsm_dev = dsm;
> +	const struct pci_tsm_ops *ops = dsm_dev->tsm->ops;
> +
> +	pdev->tsm = ops->probe(pdev);
> +	pci_dbg(pdev, "setup tsm context: dsm: %s status: %s\n",
> +		pci_name(dsm_dev), pdev->tsm ? "success" : "failed");
> +	return 0;
> +}
> +
> +static void pci_tsm_probe_fns(struct pci_dev *dsm)
> +{
> +	pci_tsm_walk_fns(dsm, probe_fn, dsm);
> +}
> +
> +static int pci_tsm_connect(struct pci_dev *pdev, struct tsm_dev *tsm_dev)
> +{
> +	int rc;
> +	struct pci_tsm_pf0 *tsm_pf0;
> +	const struct pci_tsm_ops *ops = tsm_pci_ops(tsm_dev);
> +	struct pci_tsm *pci_tsm __free(tsm_remove) = ops->probe(pdev);
> +
> +	if (!pci_tsm)
> +		return -ENXIO;
> +
> +	pdev->tsm = pci_tsm;
> +	tsm_pf0 = to_pci_tsm_pf0(pdev->tsm);
> +
> +	ACQUIRE(mutex_intr, lock)(&tsm_pf0->lock);
> +	if ((rc = ACQUIRE_ERR(mutex_intr, &lock)))
> +		return rc;
> +
> +	rc = ops->connect(pdev);
> +	if (rc)
> +		return rc;
> +
> +	pdev->tsm = no_free_ptr(pci_tsm);
> +
> +	/*
> +	 * Now that the DSM is established, probe() all the potential
> +	 * dependent functions. Failure to probe a function is not fatal
> +	 * to connect(), it just disables subsequent security operations
> +	 * for that function.
> +	 */
> +	pci_tsm_probe_fns(pdev);
> +	return 0;
> +}
> +
> +static ssize_t connect_show(struct device *dev, struct device_attribute *attr,
> +			    char *buf)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	int rc;
> +
> +	ACQUIRE(rwsem_read_intr, lock)(&pci_tsm_rwsem);
> +	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &lock)))
> +		return rc;
> +
> +	if (!pdev->tsm)
> +		return sysfs_emit(buf, "\n");
> +
> +	return sysfs_emit(buf, "%s\n", tsm_name(pdev->tsm->ops->owner));
> +}
> +
> +static ssize_t connect_store(struct device *dev, struct device_attribute *attr,
> +			     const char *buf, size_t len)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	const struct pci_tsm_ops *ops;
> +	struct tsm_dev *tsm_dev;
> +	int rc, id;
> +
> +	rc = sscanf(buf, "tsm%d\n", &id);

Why is id needed here? Are there going to be multiple DSMs per a PCI device?

I am missing the point of tsm_dev. It does not have sysfs nodes (the pci_dev parent does), tsm_register() takes attribute_group but what would posibbly go there? certificates/meas/report blobs? The pci_dev struct itself has *tsm now so this child device is not that. Hm.


> +	if (rc != 1)
> +		return -EINVAL;
> +
> +	ACQUIRE(rwsem_read_intr, lock)(&pci_tsm_rwsem);
> +	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &lock)))
> +		return rc;
> +
> +	if (pdev->tsm)
> +		return -EBUSY;
> +
> +	tsm_dev = find_tsm_dev(id);

When PCI TSM loads, all it does is add "connect" nodes. And when write to "connect" happens, this find_tsm_dev() is expected to find a tsm_dev but what is going to add those in the real PCI? devsec_tsm_probe() does not really explain.

> +	if (!tsm_dev)
> +		return -ENXIO;
> +
> +	ops = tsm_pci_ops(tsm_dev);
> +	if (!ops || !ops->connect || !ops->probe)
> +		return -ENXIO;
> +
> +	rc = pci_tsm_connect(pdev, tsm_dev);
> +	if (rc)
> +		return rc;
> +	return len;
> +}
> +static DEVICE_ATTR_RW(connect);
> +
> +static int remove_fn(struct pci_dev *pdev, void *data)
> +{
> +	tsm_remove(pdev->tsm);
> +	return 0;
> +}
> +
> +static void pci_tsm_remove_fns(struct pci_dev *dsm)
> +{
> +	pci_tsm_walk_fns_reverse(dsm, remove_fn, NULL);
> +}
> +
> +static void __pci_tsm_disconnect(struct pci_dev *pdev)
> +{
> +	struct pci_tsm_pf0 *tsm_pf0 = to_pci_tsm_pf0(pdev->tsm);
> +	const struct pci_tsm_ops *ops = pdev->tsm->ops;
> +
> +	/* disconnect is not interruptible */
> +	guard(mutex)(&tsm_pf0->lock);
> +	pci_tsm_remove_fns(pdev);
> +	ops->disconnect(pdev);
> +}
> +
> +static void pci_tsm_disconnect(struct pci_dev *pdev)
> +{
> +	__pci_tsm_disconnect(pdev);
> +	tsm_remove(pdev->tsm);
> +}
> +
> +static ssize_t disconnect_store(struct device *dev,
> +				struct device_attribute *attr, const char *buf,
> +				size_t len)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	bool disconnect;
> +	int rc;
> +
> +	rc = kstrtobool(buf, &disconnect);
> +	if (rc)
> +		return rc;
> +	if (!disconnect)
> +		return -EINVAL;
> +
> +	ACQUIRE(rwsem_read_intr, lock)(&pci_tsm_rwsem);
> +	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &lock)))
> +		return rc;
> +
> +	if (!pdev->tsm)
> +		return -ENXIO;
> +
> +	pci_tsm_disconnect(pdev);
> +	return len;
> +}
> +static DEVICE_ATTR_WO(disconnect);

imho "echo 0 > connect" is more descriptive than "echo 1 > disconnect", and one less sysfs node.


> +
> +static bool pci_tsm_pf0_group_visible(struct kobject *kobj)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	return pci_tsm_count && is_pci_tsm_pf0(pdev);
> +}
> +DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(pci_tsm_pf0);
> +
> +static struct attribute *pci_tsm_pf0_attrs[] = {
> +	&dev_attr_connect.attr,
> +	&dev_attr_disconnect.attr,
> +	NULL
> +};
> +
> +const struct attribute_group pci_tsm_pf0_attr_group = {
> +	.name = "tsm",
> +	.attrs = pci_tsm_pf0_attrs,
> +	.is_visible = SYSFS_GROUP_VISIBLE(pci_tsm_pf0),
> +};
> +
> +static ssize_t authenticated_show(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
> +{
> +	/*
> +	 * When device authentication is TSM owned, 'authenticated' is
> +	 * identical to the connect state.
> +	 */
> +	return connect_show(dev, attr, buf);
> +}
> +static DEVICE_ATTR_RO(authenticated);
> +
> +static struct attribute *pci_tsm_auth_attrs[] = {
> +	&dev_attr_authenticated.attr,
> +	NULL
> +};
> +
> +const struct attribute_group pci_tsm_auth_attr_group = {
> +	.attrs = pci_tsm_auth_attrs,
> +	.is_visible = SYSFS_GROUP_VISIBLE(pci_tsm_pf0),
> +};
> +
> +/*
> + * Retrieve physical function0 device whether it has TEE capability or not
> + */
> +static struct pci_dev *pf0_dev_get(struct pci_dev *pdev)
> +{
> +	struct pci_dev *pf_dev = pci_physfn(pdev);
> +
> +	if (PCI_FUNC(pf_dev->devfn) == 0)
> +		return pci_dev_get(pf_dev);
> +
> +	return pci_get_slot(pf_dev->bus,
> +			    pf_dev->devfn - PCI_FUNC(pf_dev->devfn));
> +}
> +
> +/*
> + * Find the PCI Device instance that serves as the Device Security
> + * Manger (DSM) for @pdev. Note that no additional reference is held for
> + * the resulting device because @pdev always has a longer registered
> + * lifetime than its DSM by virtue of being a child of or identical to
> + * its DSM.
> + */
> +static struct pci_dev *find_dsm_dev(struct pci_dev *pdev)
> +{
> +	struct pci_dev *uport_pf0;
> +
> +	if (is_pci_tsm_pf0(pdev))
> +		return pdev;
> +
> +	struct pci_dev *pf0 __free(pci_dev_put) = pf0_dev_get(pdev);
> +	if (!pf0)
> +		return NULL;
> +
> +	if (is_dsm(pf0))
> +		return pf0;
> +
> +	/*
> +	 * For cases where a switch may be hosting TDISP services on
> +	 * behalf of downstream devices, check the first usptream port
> +	 * relative to this endpoint.
> +         */
> +	if (!pdev->dev.parent || !pdev->dev.parent->parent)
> +		return NULL;
> +
> +	uport_pf0 = to_pci_dev(pdev->dev.parent->parent);
> +	if (is_dsm(uport_pf0))
> +		return uport_pf0;
> +	return NULL;
> +}
> +
> +/**
> + * pci_tsm_constructor() - base 'struct pci_tsm' initialization
> + * @pdev: The PCI device
> + * @tsm: context to initialize
> + * @ops: PCI operations provided by the TSM
> + */
> +int pci_tsm_constructor(struct pci_dev *pdev, struct pci_tsm *tsm,
> +			const struct pci_tsm_ops *ops)
> +{
> +	tsm->pdev = pdev;
> +	tsm->ops = ops;

These should go down, right before "return 0". Thanks,


> +	tsm->dsm = find_dsm_dev(pdev);
> +	if (!tsm->dsm) {
> +		pci_warn(pdev, "failed to find Device Security Manager\n");
> +		return -ENXIO;
> +	}
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_tsm_constructor);
> +
> +/**
> + * pci_tsm_pf0_constructor() - common 'struct pci_tsm_pf0' initialization
> + * @pdev: Physical Function 0 PCI device (as indicated by is_pci_tsm_pf0())
> + * @tsm: context to initialize
> + */
> +int pci_tsm_pf0_constructor(struct pci_dev *pdev, struct pci_tsm_pf0 *tsm,
> +			    const struct pci_tsm_ops *ops)
> +{
> +	struct tsm_dev *tsm_dev = ops->owner;
> +
> +	mutex_init(&tsm->lock);
> +	tsm->doe_mb = pci_find_doe_mailbox(pdev, PCI_VENDOR_ID_PCI_SIG,
> +					   PCI_DOE_PROTO_CMA);
> +	if (!tsm->doe_mb) {
> +		pci_warn(pdev, "TSM init failure, no CMA mailbox\n");
> +		return -ENODEV;
> +	}
> +
> +	if (tsm_pci_group(tsm_dev))
> +		sysfs_merge_group(&pdev->dev.kobj, tsm_pci_group(tsm_dev));
> +
> +	return pci_tsm_constructor(pdev, &tsm->tsm, ops);
> +}
> +EXPORT_SYMBOL_GPL(pci_tsm_pf0_constructor);
> +
> +void pci_tsm_pf0_destructor(struct pci_tsm_pf0 *pf0_tsm)
> +{
> +	struct pci_tsm *tsm = &pf0_tsm->tsm;
> +	struct pci_dev *pdev = tsm->pdev;
> +	struct tsm_dev *tsm_dev = tsm->ops->owner;
> +
> +	if (tsm_pci_group(tsm_dev))
> +		sysfs_unmerge_group(&pdev->dev.kobj, tsm_pci_group(tsm_dev));
> +	mutex_destroy(&pf0_tsm->lock);
> +}
> +EXPORT_SYMBOL_GPL(pci_tsm_pf0_destructor);
> +
> +static void pf0_sysfs_enable(struct pci_dev *pdev)
> +{
> +	pci_dbg(pdev, "Device Security Manager detected (%s%s )\n",
> +		pdev->ide_cap ? " ide" : "",
> +		pdev->devcap & PCI_EXP_DEVCAP_TEE ? " tee" : "");
> +
> +	sysfs_update_group(&pdev->dev.kobj, &pci_tsm_auth_attr_group);
> +	sysfs_update_group(&pdev->dev.kobj, &pci_tsm_pf0_attr_group);
> +}
> +
> +int pci_tsm_register(struct tsm_dev *tsm_dev)
> +{
> +	const struct pci_tsm_ops *ops;
> +	struct pci_dev *pdev = NULL;
> +
> +	if (!tsm_dev)
> +		return -EINVAL;
> +
> +	/*
> +	 * The TSM device must have pci_ops, and only implement one of link_ops
> +	 * or sec_ops.
> +	 */
> +	ops = tsm_pci_ops(tsm_dev);
> +	if (!ops)
> +		return -EINVAL;
> +
> +	if (!ops->probe && !ops->sec_probe)
> +		return -EINVAL;
> +
> +	if (ops->probe && ops->sec_probe)
> +		return -EINVAL;
> +
> +	guard(rwsem_write)(&pci_tsm_rwsem);
> +
> +	pci_tsm_count++;
> +
> +	/* PCI/TSM sysfs already enabled? */
> +	if (pci_tsm_count > 1)
> +		return 0;
> +
> +	for_each_pci_dev(pdev)
> +		if (is_pci_tsm_pf0(pdev))
> +			pf0_sysfs_enable(pdev);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_tsm_register);
> +
> +/**
> + * __pci_tsm_destroy() - destroy the TSM context for @pdev
> + * @pdev: device to cleanup
> + * @tsm_dev: TSM context if a TSM device is being removed, NULL if
> + * 	     @pdev is being removed.
> + *
> + * At device removal or TSM unregistration all established context
> + * with the TSM is torn down. Additionally, if there are no more TSMs
> + * registered, the PCI tsm/ sysfs attributes are hidden.
> + */
> +static void __pci_tsm_destroy(struct pci_dev *pdev, struct tsm_dev *tsm_dev)
> +{
> +	struct pci_tsm *tsm = pdev->tsm;
> +
> +	lockdep_assert_held_write(&pci_tsm_rwsem);
> +
> +	if (tsm_dev && is_pci_tsm_pf0(pdev) && !pci_tsm_count) {
> +		sysfs_update_group(&pdev->dev.kobj, &pci_tsm_auth_attr_group);
> +		sysfs_update_group(&pdev->dev.kobj, &pci_tsm_pf0_attr_group);
> +	}
> +
> +	if (!tsm)
> +		return;
> +
> +	if (!tsm_dev)
> +		tsm_dev = tsm->ops->owner;
> +	else if (tsm_dev != tsm->ops->owner)
> +		return;
> +
> +	if (is_pci_tsm_pf0(pdev))
> +		pci_tsm_disconnect(pdev);
> +	else
> +		tsm_remove(pdev->tsm);
> +}
> +
> +void pci_tsm_destroy(struct pci_dev *pdev)
> +{
> +	guard(rwsem_write)(&pci_tsm_rwsem);
> +	__pci_tsm_destroy(pdev, NULL);
> +}
> +
> +void pci_tsm_unregister(struct tsm_dev *tsm_dev)
> +{
> +	struct pci_dev *pdev = NULL;
> +
> +	guard(rwsem_write)(&pci_tsm_rwsem);
> +	pci_tsm_count--;
> +	for_each_pci_dev_reverse(pdev)
> +		__pci_tsm_destroy(pdev, tsm_dev);
> +}
> +
> +int pci_tsm_doe_transfer(struct pci_dev *pdev, enum pci_doe_proto type,
> +			 const void *req, size_t req_sz, void *resp,
> +			 size_t resp_sz)
> +{
> +	struct pci_tsm_pf0 *tsm;
> +
> +	if (!pdev->tsm || !is_pci_tsm_pf0(pdev))
> +		return -ENXIO;
> +
> +	tsm = to_pci_tsm_pf0(pdev->tsm);
> +	if (!tsm->doe_mb)
> +		return -ENXIO;
> +
> +	return pci_doe(tsm->doe_mb, PCI_VENDOR_ID_PCI_SIG, type, req, req_sz,
> +		       resp, resp_sz);
> +}
> +EXPORT_SYMBOL_GPL(pci_tsm_doe_transfer);
> diff --git a/drivers/virt/coco/tsm-core.c b/drivers/virt/coco/tsm-core.c
> index 1f53b9049e2d..093824dc68dd 100644
> --- a/drivers/virt/coco/tsm-core.c
> +++ b/drivers/virt/coco/tsm-core.c
> @@ -9,6 +9,7 @@
>   #include <linux/device.h>
>   #include <linux/module.h>
>   #include <linux/cleanup.h>
> +#include <linux/pci-tsm.h>
>   
>   static struct class *tsm_class;
>   static DECLARE_RWSEM(tsm_rwsem);
> @@ -17,8 +18,39 @@ static DEFINE_IDR(tsm_idr);
>   struct tsm_dev {
>   	struct device dev;
>   	int id;
> +	const struct pci_tsm_ops *pci_ops;
> +	const struct attribute_group *group;
>   };
>   
> +const char *tsm_name(const struct tsm_dev *tsm_dev)
> +{
> +	return dev_name(&tsm_dev->dev);
> +}
> +
> +/*
> + * Caller responsible for ensuring it does not race tsm_dev
> + * unregistration.
> + */
> +struct tsm_dev *find_tsm_dev(int id)
> +{
> +	guard(rcu)();
> +	return idr_find(&tsm_idr, id);
> +}
> +
> +const struct pci_tsm_ops *tsm_pci_ops(const struct tsm_dev *tsm_dev)
> +{
> +	if (!tsm_dev)
> +		return NULL;
> +	return tsm_dev->pci_ops;
> +}
> +
> +const struct attribute_group *tsm_pci_group(const struct tsm_dev *tsm_dev)
> +{
> +	if (!tsm_dev)
> +		return NULL;
> +	return tsm_dev->group;
> +}
> +
>   static struct tsm_dev *alloc_tsm_dev(struct device *parent,
>   				     const struct attribute_group **groups)
>   {
> @@ -44,6 +76,29 @@ static struct tsm_dev *alloc_tsm_dev(struct device *parent,
>   	return no_free_ptr(tsm_dev);
>   }
>   
> +static struct tsm_dev *tsm_register_pci_or_reset(struct tsm_dev *tsm_dev,
> +						 struct pci_tsm_ops *pci_ops)
> +{
> +	int rc;
> +
> +	if (!pci_ops)
> +		return tsm_dev;
> +
> +	pci_ops->owner = tsm_dev;
> +	tsm_dev->pci_ops = pci_ops;
> +	rc = pci_tsm_register(tsm_dev);
> +	if (rc) {
> +		dev_err(tsm_dev->dev.parent,
> +			"PCI/TSM registration failure: %d\n", rc);
> +		device_unregister(&tsm_dev->dev);
> +		return ERR_PTR(rc);
> +	}
> +
> +	/* Notify TSM userspace that PCI/TSM operations are now possible */
> +	kobject_uevent(&tsm_dev->dev.kobj, KOBJ_CHANGE);
> +	return tsm_dev;
> +}
> +
>   static void put_tsm_dev(struct tsm_dev *tsm_dev)
>   {
>   	if (!IS_ERR_OR_NULL(tsm_dev))
> @@ -54,7 +109,8 @@ DEFINE_FREE(put_tsm_dev, struct tsm_dev *,
>   	    if (!IS_ERR_OR_NULL(_T)) put_tsm_dev(_T))
>   
>   struct tsm_dev *tsm_register(struct device *parent,
> -			     const struct attribute_group **groups)
> +			     const struct attribute_group **groups,
> +			     struct pci_tsm_ops *pci_ops)
>   {
>   	struct tsm_dev *tsm_dev __free(put_tsm_dev) =
>   		alloc_tsm_dev(parent, groups);
> @@ -73,12 +129,13 @@ struct tsm_dev *tsm_register(struct device *parent,
>   	if (rc)
>   		return ERR_PTR(rc);
>   
> -	return no_free_ptr(tsm_dev);
> +	return tsm_register_pci_or_reset(no_free_ptr(tsm_dev), pci_ops);
>   }
>   EXPORT_SYMBOL_GPL(tsm_register);
>   
>   void tsm_unregister(struct tsm_dev *tsm_dev)
>   {
> +	pci_tsm_unregister(tsm_dev);
>   	device_unregister(&tsm_dev->dev);
>   }
>   EXPORT_SYMBOL_GPL(tsm_unregister);
> diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
> new file mode 100644
> index 000000000000..f370c022fac4
> --- /dev/null
> +++ b/include/linux/pci-tsm.h
> @@ -0,0 +1,158 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __PCI_TSM_H
> +#define __PCI_TSM_H
> +#include <linux/mutex.h>
> +#include <linux/pci.h>
> +
> +struct pci_tsm;
> +
> +/*
> + * struct pci_tsm_ops - manage confidential links and security state
> + * @link_ops: Coordinate PCIe SPDM and IDE establishment via a platform TSM.
> + * 	      Provide a secure session transport for TDISP state management
> + * 	      (typically bare metal physical function operations).
> + * @sec_ops: Lock, unlock, and interrogate the security state of the
> + *	     function via the platform TSM (typically virtual function
> + *	     operations).
> + * @owner: Back reference to the TSM device that owns this instance.
> + *
> + * This operations are mutually exclusive either a tsm_dev instance
> + * manages phyiscal link properties or it manages function security
> + * states like TDISP lock/unlock.
> + */
> +struct pci_tsm_ops {
> +	/*
> +	 * struct pci_tsm_link_ops - Manage physical link and the TSM/DSM session
> +	 * @probe: probe device for tsm link operation readiness, setup
> +	 *	   DSM context
> +	 * @remove: destroy DSM context
> +	 * @connect: establish / validate a secure connection (e.g. IDE)
> +	 *	     with the device
> +	 * @disconnect: teardown the secure link
> +	 *
> +	 * @probe and @remove run in pci_tsm_rwsem held for write context. All
> +	 * other ops run under the @pdev->tsm->lock mutex and pci_tsm_rwsem held
> +	 * for read.
> +	 */
> +	struct_group_tagged(pci_tsm_link_ops, link_ops,
> +		struct pci_tsm *(*probe)(struct pci_dev *pdev);
> +		void (*remove)(struct pci_tsm *tsm);
> +		int (*connect)(struct pci_dev *pdev);
> +		void (*disconnect)(struct pci_dev *pdev);
> +	);
> +
> +	/*
> +	 * struct pci_tsm_security_ops - Manage the security state of the function
> +	 * @sec_probe: probe device for tsm security operation
> +	 *	       readiness, setup security context
> +	 * @sec_remove: destroy security context
> +	 *
> +	 * @sec_probe and @sec_remove run in pci_tsm_rwsem held for
> +	 * write context. All other ops run under the @pdev->tsm->lock
> +	 * mutex and pci_tsm_rwsem held for read.
> +	 */
> +	struct_group_tagged(pci_tsm_security_ops, ops,
> +		struct pci_tsm *(*sec_probe)(struct pci_dev *pdev);
> +		void (*sec_remove)(struct pci_tsm *tsm);
> +	);
> +	struct tsm_dev *owner;
> +};
> +
> +/**
> + * struct pci_tsm - Core TSM context for a given PCIe endpoint
> + * @pdev: Back ref to device function, distinguishes type of pci_tsm context
> + * @dsm: PCI Device Security Manager for link operations on @pdev.
> + * @ops: Link Confidentiality or Device Function Security operations
> + *
> + * This structure is wrapped by low level TSM driver data and returned
> + * by probe()/sec_probe(), it is freed by the corresponding
> + * remove()/sec_remove().
> + *
> + * For link operations it serves to cache the association between a
> + * Device Security Manager (DSM) and the functions that manager can
> + * assign to a TVM.  That can be "self", for assigning function0 of a
> + * TEE I/O device, a sub-function (SR-IOV virtual function, or
> + * non-function0 multifunction-device), or a downstream endpoint (PCIe
> + * upstream switch-port as DSM).
> + */
> +struct pci_tsm {
> +	struct pci_dev *pdev;
> +	struct pci_dev *dsm;
> +	const struct pci_tsm_ops *ops;
> +};
> +
> +/**
> + * struct pci_tsm_pf0 - Physical Function 0 TDISP link context
> + * @tsm: generic core "tsm" context
> + * @lock: protect @state vs pci_tsm_ops invocation
> + * @doe_mb: PCIe Data Object Exchange mailbox
> + */
> +struct pci_tsm_pf0 {
> +	struct pci_tsm tsm;
> +	struct mutex lock;
> +	struct pci_doe_mb *doe_mb;
> +};
> +
> +/* physical function0 and capable of 'connect' */
> +static inline bool is_pci_tsm_pf0(struct pci_dev *pdev)
> +{
> +	if (!pci_is_pcie(pdev))
> +		return false;
> +
> +	if (pdev->is_virtfn)
> +		return false;
> +
> +	/*
> +	 * Allow for a Device Security Manager (DSM) associated with function0
> +	 * of an Endpoint to coordinate TDISP requests for other functions
> +	 * (physical or virtual) of the device, or allow for an Upstream Port
> +	 * DSM to accept TDISP requests for switch Downstream Endpoints.
> +	 */
> +	switch (pci_pcie_type(pdev)) {
> +	case PCI_EXP_TYPE_ENDPOINT:
> +	case PCI_EXP_TYPE_UPSTREAM:
> +	case PCI_EXP_TYPE_RC_END:
> +		if (pdev->ide_cap || (pdev->devcap & PCI_EXP_DEVCAP_TEE))
> +			break;
> +		fallthrough;
> +	default:
> +		return false;
> +	}
> +
> +	return PCI_FUNC(pdev->devfn) == 0;
> +}
> +
> +enum pci_doe_proto {
> +	PCI_DOE_PROTO_CMA = 1,
> +	PCI_DOE_PROTO_SSESSION = 2,
> +};
> +
> +#ifdef CONFIG_PCI_TSM
> +struct tsm_dev;
> +int pci_tsm_register(struct tsm_dev *tsm_dev);
> +void pci_tsm_unregister(struct tsm_dev *tsm_dev);
> +int pci_tsm_doe_transfer(struct pci_dev *pdev, enum pci_doe_proto type,
> +			 const void *req, size_t req_sz, void *resp,
> +			 size_t resp_sz);
> +int pci_tsm_constructor(struct pci_dev *pdev, struct pci_tsm *tsm,
> +			const struct pci_tsm_ops *ops);
> +int pci_tsm_pf0_constructor(struct pci_dev *pdev, struct pci_tsm_pf0 *tsm,
> +			    const struct pci_tsm_ops *ops);
> +void pci_tsm_pf0_destructor(struct pci_tsm_pf0 *tsm);
> +#else
> +static inline int pci_tsm_register(struct tsm_dev *tsm_dev)
> +{
> +	return 0;
> +}
> +static inline void pci_tsm_unregister(struct tsm_dev *tsm_dev)
> +{
> +}
> +static inline int pci_tsm_doe_transfer(struct pci_dev *pdev,
> +				       enum pci_doe_proto type, const void *req,
> +				       size_t req_sz, void *resp,
> +				       size_t resp_sz)
> +{
> +	return -ENOENT;
> +}
> +#endif
> +#endif /*__PCI_TSM_H */
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index b8bca0711967..0e5703fad0f6 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -539,6 +539,9 @@ struct pci_dev {
>   	u8		nr_link_ide;	/* Link Stream count (Selective Stream offset) */
>   	unsigned int	ide_cfg:1;	/* Config cycles over IDE */
>   	unsigned int	ide_tee_limit:1; /* Disallow T=0 traffic over IDE */
> +#endif
> +#ifdef CONFIG_PCI_TSM
> +	struct pci_tsm *tsm;		/* TSM operation state */
>   #endif
>   	u16		acs_cap;	/* ACS Capability offset */
>   	u8		supported_speeds; /* Supported Link Speeds Vector */
> diff --git a/include/linux/tsm.h b/include/linux/tsm.h
> index a90b40b1b13c..ce95589a5d5b 100644
> --- a/include/linux/tsm.h
> +++ b/include/linux/tsm.h
> @@ -111,7 +111,13 @@ struct tsm_report_ops {
>   int tsm_report_register(const struct tsm_report_ops *ops, void *priv);
>   int tsm_report_unregister(const struct tsm_report_ops *ops);
>   struct tsm_dev;
> +struct pci_tsm_ops;
>   struct tsm_dev *tsm_register(struct device *parent,
> -			     const struct attribute_group **groups);
> +			     const struct attribute_group **groups,
> +			     struct pci_tsm_ops *ops);
>   void tsm_unregister(struct tsm_dev *tsm_dev);
> +const char *tsm_name(const struct tsm_dev *tsm_dev);
> +struct tsm_dev *find_tsm_dev(int id);
> +const struct pci_tsm_ops *tsm_pci_ops(const struct tsm_dev *tsm_dev);
> +const struct attribute_group *tsm_pci_group(const struct tsm_dev *tsm_dev);
>   #endif /* __TSM_H */
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index ab4ebf0f8a46..1b991a88c19c 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -500,6 +500,7 @@
>   #define  PCI_EXP_DEVCAP_PWR_VAL	0x03fc0000 /* Slot Power Limit Value */
>   #define  PCI_EXP_DEVCAP_PWR_SCL	0x0c000000 /* Slot Power Limit Scale */
>   #define  PCI_EXP_DEVCAP_FLR     0x10000000 /* Function Level Reset */
> +#define  PCI_EXP_DEVCAP_TEE     0x40000000 /* TEE I/O (TDISP) Support */
>   #define PCI_EXP_DEVCTL		0x08	/* Device Control */
>   #define  PCI_EXP_DEVCTL_CERE	0x0001	/* Correctable Error Reporting En. */
>   #define  PCI_EXP_DEVCTL_NFERE	0x0002	/* Non-Fatal Error Reporting Enable */

-- 
Alexey


