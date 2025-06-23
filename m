Return-Path: <linux-pci+bounces-30461-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C70FAAE5424
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 23:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 510FB446846
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 21:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B84C21FF2B;
	Mon, 23 Jun 2025 21:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eKlRUhQj"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2055.outbound.protection.outlook.com [40.107.102.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58ABF224AFA
	for <linux-pci@vger.kernel.org>; Mon, 23 Jun 2025 21:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750715973; cv=fail; b=K1M7Ev5SfU1rtf/hMcHtiU8reU2yXIrWo7lx7uRZw3DjTb7k/QLyCv/6y9q7MH31AiX82gcrZO8aAGULjCYAG2D5JYKqkK2HYeELhoZ8hcWyKIWrnrv1/AVog6Q1hAp9O3xj2/Z//4DQmCB8dCtzEzXQ9coZHPpJQ2p71d7P2CA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750715973; c=relaxed/simple;
	bh=a1DhTieHFc4lnqCprYaAfyb5KaQ/IOwPRlFUxFMI6oQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BltKPwSsmcocLccbLhO3WQxhDRKWRNZtXOIr8fkHs1BH0tSKdrALC3VJN2ZJ1PwvUBXACaBdxRjWVClvaqAcgO+P93LEU/IE/I6cY1dKnCFvVEUv2AoP6I+Jq/WcZYEFGZj+k+C+RHgFKS+Mn3QwAa43/D+KDE6S6i24qQlD2RQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eKlRUhQj; arc=fail smtp.client-ip=40.107.102.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QJd1i3EcDUq2pKZDtLACuhaNOFWYcBOfBdkom84Vl/rR1qBbxnUNoz1ffhqszPfgYpqgC5QkFE+tgJGsij52QEkJnLpFgNQBnapxHUfxkn/lueispkCGv6t5t1ywF/x+Tdtd4SUMO8JxXzfgYwt5h/9RGUkcn2valHaPixlkktBBNJEG1QC9X5U9z6viU1hP0zctZ2rqpwZKcOZ6zmUgVsfdRtYvRpNgnnOqabmPLZDXKfWD2K4ZbRwHoUWK7rwMuaBVx0ySHDpCT+i3HCfblFbMaMy2X4GpnWHi8aJbYH9bdh7sKTYFnkOo+vdMmtU0FxoPdfsvEVmuj6IQ75rDbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PD5HiYeMGAUjqs1CY3AV87jXZdBibmKZ3i5ttKza2M4=;
 b=tglZlGyvRDp023ksvPL3AAfVWuOjbIRFpVP3zqw1y+672YiJPPjEmd69x8nNX849YMg9/ZT6VN1Gt2KAudq9+/sG8WOrspdLVsmPcr9ZdrHcu/JZwPrurI30RP4i46itE+WJk/+oczjmAHQHfeeTLuxrOK+DHrAN6VlIXMA5iEK/b2+q3vEmf+5sCFw0KiYuIHxZ1FbSohVrkN4Anxqm/mjkutX2SeX1CokBC1E5jvDE0FUOlWt7wKlfiTr5ENjVE5fbYl7252tDe87cv5Xt0wjVJcxGIHdI62/DslVHm48aX3h1l+HiCAMSQo61ynzqJxcDISVnGe1sj8vGNeMlHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PD5HiYeMGAUjqs1CY3AV87jXZdBibmKZ3i5ttKza2M4=;
 b=eKlRUhQjQ5B/Z8l85V3PfkvmHAjXGUpXy7cOCnSmgzCArOr1fH3PKJp73TyGDP7FaK4jULJ/BaBQ+2QNCD1QwZch3P1WKvviGKNEgHzP3buQXlX/e5+C1fF1rIoF1ZIs3DIzTJR8uHmiO32oHhhm4SV61vV2rAnbuqsuhRjSzxU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH8PR12MB7133.namprd12.prod.outlook.com (2603:10b6:510:22e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 23 Jun
 2025 21:59:28 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 21:59:28 +0000
Message-ID: <1277bf56-28c4-422b-973f-b1f152b4e92d@amd.com>
Date: Mon, 23 Jun 2025 16:59:26 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/ACPI: Fix runtime PM ref imbalance on hot-plug
 capable ports
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>
Cc: Laurent Bigonville <bigon@bigon.be>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Mika Westerberg <westeri@kernel.org>,
 linux-pci@vger.kernel.org
References: <86c3bd52bda4552d63ffb48f8a30343167e85271.1750698221.git.lukas@wunner.de>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <86c3bd52bda4552d63ffb48f8a30343167e85271.1750698221.git.lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR10CA0014.namprd10.prod.outlook.com
 (2603:10b6:5:60::27) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH8PR12MB7133:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f3a2831-2b64-48d3-3f06-08ddb2a139bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z2NLaVJZNTJNVFF5c1E1c1NWd0p4OHFkYk1lYjFzb3Q4emhYdTZTVGcxVHh0?=
 =?utf-8?B?aTdpNWRSM05sQTZ3V0dqMHc4VU9XSk8vVnI1Wld2ZnRBQU00MmJVZTJiaGE0?=
 =?utf-8?B?OWc3Qyt6R1RNM3UyVGVKcS8wZmpRVTRaQ3hhWU12RU4vc1V3WWc3Z1lpdHFN?=
 =?utf-8?B?eUkwdWhyMHNHSVVXb21sb1dUWkpldm15V2tKQlpNUXJUUDh5aVJzY0Q0cE5p?=
 =?utf-8?B?a0JoaXJKWkZLRW1JdlcrV2VRbzhvcy8yeitYS0xjSkhLWXRiK25NaXF5WmFS?=
 =?utf-8?B?ZzZDNFM3Nm9oZUFtWHluSmc4NEgzQUNjNWRGOFptallJZERQaXEvVExWaGhy?=
 =?utf-8?B?NXRaQVdxd0t0dGJYVmQwajN5eUlpbWVIbVNDLzV2ek9hbWRMZnNVZ3ZjcVZi?=
 =?utf-8?B?OFZNdmZhcWpTenVVd0VHQ2RHTTQ5d0w5alhlbHM3RENSd3ZkWU5XdXZJczNV?=
 =?utf-8?B?Q1FBWjJqNzNJSVdHUkpXdFJtczRpTXdoSGJnUkx6Y0NVMFN0dTJwYVZ2b0FS?=
 =?utf-8?B?c1M5cmUrZ29xOTlnUUhKQlpZRnk4dTVtdGlDSEhYOER1d2dvMTVRQ3g2YlZv?=
 =?utf-8?B?bFU5SlE2RGM2bEdtN2lnbDFXa3h2OExlcllPVXJ4SWFwV1pRMTVRYVpJYjRU?=
 =?utf-8?B?MVlJc1FNQnU4eEpwOGxyQ1lFR1BFSnNvYkUya3k2aEdrMzdMcXRXVFZ0VFd4?=
 =?utf-8?B?VWNrdmp1S1lLbVBaM080cWJWdHVsYi9MRjlCSFptMEE5NDQrazhSRVRyWjVz?=
 =?utf-8?B?RTZTNzdBaWYydE9HRzc0ZEViTXlWeGlxcnc3WWJZeXdOQVJvcmJ6RkV6Z1M2?=
 =?utf-8?B?UUFvMjcrd29raEpzbnZ3K0dIUEZITmZlVDVLRVBwMjdIODFBbGk2aGE3TzAv?=
 =?utf-8?B?ZmxPQm93cmtJRGFJcGJaeWV3R2ptYUlqWEJscm03bE9IMVZFendicjVJaVNS?=
 =?utf-8?B?Q3RucTFqTEdrQ2FHYzJDWFkvTmJ1cHN6VFJ4S3FQUEw5RjYrSy85bThDOVNa?=
 =?utf-8?B?YzI5VzEyM3dJK0s5Z1NwTE9ackt6ZCs2cUIrL1lhOUpHVG5YMHEzdTBJMmQ5?=
 =?utf-8?B?dWNtZ2s2RFVuWWZtWDUwUHRKcjMzYjd0ZGpIK0dMakNUSzUxM2NHaW5zK1lM?=
 =?utf-8?B?Um10eWJqcTFwYm1kZkQ0VjFFWDRPTi9wdVR4clBmdXkwT0VNaXh4eXFpMC9h?=
 =?utf-8?B?M0pTQTJvNzRkTWRHK0g0WUZHT0IyQklCczN3N3NsN0VGZFlNbTJWdHBoZW15?=
 =?utf-8?B?SXFPTkxkUFlBOGpla2NxcCt3RWxNMmdRUktKY0tlOWU3OUxRY3lwTThza0lq?=
 =?utf-8?B?ZHJGc2tWdXJLV3dyM1dnSzluNHQ3OFNtZzB1LzBWbW5QNVhlN0ZpVGFXeWNi?=
 =?utf-8?B?U201SXNvUjdSOTA3V3JaNU42ODlEdzR2VWhKd1AzcWZBaU9CWkg2THlQNTcr?=
 =?utf-8?B?bUhlaFY1emszNkF6U0VQamtrTHNyeGdURUw1QjBjaWI1cytsUkQ4cEFqNkx6?=
 =?utf-8?B?VkFJM2RhSEgxZUJWSDJML3hGSU1NelN2QTFNbVBoQ3JWTWRKVXltNGVrdEhp?=
 =?utf-8?B?Mld2NDRnc2pMN0sreXU5YS8wMThzT3FheGI0YkE2bkgzRTAvU0RVRkc3VXp3?=
 =?utf-8?B?djJERzY5a21KM1VGYzN6akpYaGE3MEtaeXo0U0pUclFTK1dFNnEvbFEwMzMx?=
 =?utf-8?B?YmI3M3g0aytsNFhmYXZxUHFwT0tPWGgrUGtwRngrcCt4T08zMmhCaGMwb1Mw?=
 =?utf-8?B?bFc0aEhWU01mZ1NCN1hBdStkZXIvSm9kL21iYUhpYmI1UzFwdE1PWWpnRDRl?=
 =?utf-8?B?dk1ZbExTcTdtVXEwTkRjSjl1aTBpaktNUjlFd3FIUEZpbDBjNzNWdHVvZUw2?=
 =?utf-8?Q?P4qzLcum6iIW9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3hEa2xid0lrcU1aYW5ramRqU1NxcllVT2I5VDg0anJ2WXp5bnlHdUkzL3I1?=
 =?utf-8?B?VFlQT0J2aXo5MUZMRnRLSHEwS0tEMHhDR3MxNWVTU29xald6R2hGbGc2THBn?=
 =?utf-8?B?TmRWd1dmTDVVNVlkSFJ4NXF5dDBnSVNEUzdLMVk1MTVkZVh3NFZEaXlKMVRJ?=
 =?utf-8?B?RXdDOXpxRkNiRy9haWU2T2YwVllocDlacFVrQWxHbXhreDZiYysydGNUbzRV?=
 =?utf-8?B?OVdGMEtHOTdkL2xYQjVaTzJlRFYwSzhXZkJyRHVDMFlwZ1UyTForVFZrdjRD?=
 =?utf-8?B?YzRkeGZGNkowOTgxaS9ReVFpQzJ1RFl3c0FHSVErbW9vOVZYczVjMzh0YWJ3?=
 =?utf-8?B?Qko0NEVXZzl4TGZ4RWhHN0FzdzJ5NjN1b0M5Yks5dEh6L0YxQ0JsTCtJMld6?=
 =?utf-8?B?OUhENkFobUhUckQ2aGtmVktQeDQwRUpoYTFUaFNuaE9KUzFKOUZqRDluNlZx?=
 =?utf-8?B?MWpFTEhlV1NsL3dXQVFSNXQ1L2E1azFoS2hJeHZnelZhdXk0WW55Yk1nTlZC?=
 =?utf-8?B?Q0dtdTFIUVJ1UnJDSWVOZXVJSWV6VEFicDlHR1Z2NzlOQ0h0bU1TYUZPUUs3?=
 =?utf-8?B?Nk9BZjIrNG5Va0IxWU9kQml3aDFaUFNjTktIdlhHRlplYmhSaERvUm0wTzRP?=
 =?utf-8?B?VXhBQ2RxRWdOa2xNeXZibCtSY2lHU1B1WTloK3NXT0lEMmc4dWE5TXltWERF?=
 =?utf-8?B?bG8zelRZUWUrdW91K3lpQjJBcjQ1L3BOM0hGV2tHTFQwNTdSRVVoU1QwRk5K?=
 =?utf-8?B?eDVzY1RoV3RGSGNBa09HOFJIeUVvY3hmV1BJMGpuYkZMVG5aVFNycmF3RDdP?=
 =?utf-8?B?SEJTaTIvM1FialJUVW9lcTk0MS93WjNOK2laeElReGQyRnVLSjZNRmx2Z1Ju?=
 =?utf-8?B?amx2SXJwdmxrc3llTW51VFRXdmdETmwraUM2MEJNa3grZzF4Kzk3UDIwY0o2?=
 =?utf-8?B?cWp2UmVtcTdKbjBVOGs3Ry9mV0NBaytXb2oxaHd6K2hLckhJaWFiVWkydE1k?=
 =?utf-8?B?cjNkT3JjWm84TFNlWGdWaTBKZU9MWjc2RWd1Zk0wWG0rcnZ4S2U1d2F2Vy9x?=
 =?utf-8?B?UXR5RytSZTVhVW90NkVXVG1YTEV6dHQ5Sk5DQlFRKzkwWTVJNjJvaGY1Zysw?=
 =?utf-8?B?bmNSNWJDTDB6WGQ2OWI4cy9TTmJmY1FmUC9Cb1lIMksyZWorbi9mNUVldysr?=
 =?utf-8?B?bnBtQmVFRTJzOTllbW5WSEJhUVRsVnZTVmR2bVViSEMzTktXQm1CUmRQMGNX?=
 =?utf-8?B?U0R0cFQxaVpjY0JBaVpLd25zWXNHSWZwdlU3Z0VvblhNbHJYVUNhUXAwckpp?=
 =?utf-8?B?RUhUb3lZSkMrcXdqSEhCZlF4d1FjRU5raSt4UVhwdmhGSkhwdmhPNGNQNFpr?=
 =?utf-8?B?SFV4QnZ6UnVNQ2IySG1PbkZ6eDJDNS9YRDhtMGd1c2FkdjJGdHFVdHM5N0FJ?=
 =?utf-8?B?YWJBM2pPTGQ4YnZITlpUbXVjb01UVHVlTjF0VHBoZmtDdklGK1hZemMwa2tq?=
 =?utf-8?B?eXl2UDhvT2FZTVphVmgyN0J5ajNXaXIvQXMyNzl2MEZXZTVwcE1MaU0wT2FI?=
 =?utf-8?B?UHV4OHpOZEF2L3VBVExOTUczQ1R4ckxGajFyM3QvOGhNb21wdm85TWtud0RE?=
 =?utf-8?B?cmFZZ2RpMnE2Mm1BcmtGV052ODFMV0tXNVdLME9yanNERkw3VThnVytxWEJs?=
 =?utf-8?B?OCt3V3BzMTBtSzJrZ3pCcVFhNWovbGNhTVhaYmVKc05XWG1CTGhtdzQ2M1dQ?=
 =?utf-8?B?SGMxcjc1MURqa1UvL1RwR2RiblJRdXVGVWVBb1RTQktlWUpFZ0VqSEsxeTB1?=
 =?utf-8?B?bG9lV3hKRGJmbVZCSWlRalQzMG9IcStBdE82eUJiNjJweUV0ZTJWUmw2MStV?=
 =?utf-8?B?R0R3bU9xQnBsS0tDZmNGVVlCeWc4Rk42S2thVEYyT0VMbHp4K3RvK1ROUmNR?=
 =?utf-8?B?RE15eExmbjZEZisxTE43R0Zzb3V0aWdJZ0x2RFpRajRWL3B3bnFRbXVybTdC?=
 =?utf-8?B?Q1JvdDZ0bGJLUDJmVW8zQ05OUTRoT3EyV256MTk0Z2tFMWM3WUQ1aWw0M0J2?=
 =?utf-8?B?UU9XWmt4QkEweHF6ajB2c0d0RnhURmJ3OXIyTXVnVS9GUDhhYkVzWWRIcEs1?=
 =?utf-8?Q?oX5adoaYIqXnul0LTYFsk9Acw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f3a2831-2b64-48d3-3f06-08ddb2a139bf
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 21:59:28.6193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: epHXZ8IybfRPYBIbPEkY6t0zJ0NLDNhhSne6nAPqmq2zJ1L+V8+gqEGa3x+5HsXENd0Q6vbklvd/wtIVlHG2rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7133

On 6/23/2025 12:08 PM, Lukas Wunner wrote:
> pcie_portdrv_probe() and pcie_portdrv_remove() both call
> pci_bridge_d3_possible() to determine whether to use runtime power
> management.  The underlying assumption is that pci_bridge_d3_possible()
> always returns the same value because otherwise a runtime PM reference
> imbalance occurs.
> 
> That assumption falls apart if the device is inaccessible on ->remove()
> due to hot-unplug:  pci_bridge_d3_possible() calls pciehp_is_native(),
> which accesses Config Space to determine whether the device is Hot-Plug
> Capable.   An inaccessible device returns "all ones", which is converted
> to "all zeroes" by pcie_capability_read_dword().  Hence the device no
> longer seems Hot-Plug Capable on ->remove() even though it was on
> ->probe().
> 
> The resulting runtime PM ref imbalance causes errors such as:
> 
>    pcieport 0000:02:04.0: Runtime PM usage count underflow!
> 
> The Hot-Plug Capable bit is cached in pci_dev->is_hotplug_bridge.
> pci_bridge_d3_possible() only calls pciehp_is_native() if that flag is
> set.  Re-checking the bit in pciehp_is_native() is thus unnecessary.
> 
> However pciehp_is_native() is also called from hotplug_is_native().  Move
> the Config Space access to that function.  The function is only invoked
> from acpiphp_glue.c, so move it there instead of keeping it in a publicly
> visible header.
> 
> Fixes: 5352a44a561d ("PCI: pciehp: Make pciehp_is_native() stricter")
> Reported-by: Laurent Bigonville <bigon@bigon.be>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220216
> Reported-by: Mario Limonciello <mario.limonciello@amd.com>
> Closes: https://lore.kernel.org/r/20250609020223.269407-3-superm1@kernel.org/
> Link: https://lore.kernel.org/all/20250620025535.3425049-3-superm1@kernel.org/T/#u
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v4.18+

Tested-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/pci/hotplug/acpiphp_glue.c | 15 +++++++++++++++
>   drivers/pci/pci-acpi.c             |  5 -----
>   include/linux/pci_hotplug.h        |  4 ----
>   3 files changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> index 5b1f271c6034..ae2bb8970f63 100644
> --- a/drivers/pci/hotplug/acpiphp_glue.c
> +++ b/drivers/pci/hotplug/acpiphp_glue.c
> @@ -50,6 +50,21 @@ static void acpiphp_sanitize_bus(struct pci_bus *bus);
>   static void hotplug_event(u32 type, struct acpiphp_context *context);
>   static void free_bridge(struct kref *kref);
>   
> +static bool hotplug_is_native(struct pci_dev *bridge)
> +{
> +	u32 slot_cap;
> +
> +	pcie_capability_read_dword(bridge, PCI_EXP_SLTCAP, &slot_cap);
> +
> +	if (slot_cap & PCI_EXP_SLTCAP_HPC && pciehp_is_native(bridge))
> +		return true;
> +
> +	if (shpchp_is_native(bridge))
> +		return true;
> +
> +	return false;
> +}
> +
>   /**
>    * acpiphp_init_context - Create hotplug context and grab a reference to it.
>    * @adev: ACPI device object to create the context for.
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index b78e0e417324..57bce9cc8a38 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -816,15 +816,10 @@ int pci_acpi_program_hp_params(struct pci_dev *dev)
>   bool pciehp_is_native(struct pci_dev *bridge)
>   {
>   	const struct pci_host_bridge *host;
> -	u32 slot_cap;
>   
>   	if (!IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
>   		return false;
>   
> -	pcie_capability_read_dword(bridge, PCI_EXP_SLTCAP, &slot_cap);
> -	if (!(slot_cap & PCI_EXP_SLTCAP_HPC))
> -		return false;
> -
>   	if (pcie_ports_native)
>   		return true;
>   
> diff --git a/include/linux/pci_hotplug.h b/include/linux/pci_hotplug.h
> index ec77ccf1fc4d..02efeea62b25 100644
> --- a/include/linux/pci_hotplug.h
> +++ b/include/linux/pci_hotplug.h
> @@ -102,8 +102,4 @@ static inline bool pciehp_is_native(struct pci_dev *bridge) { return true; }
>   static inline bool shpchp_is_native(struct pci_dev *bridge) { return true; }
>   #endif
>   
> -static inline bool hotplug_is_native(struct pci_dev *bridge)
> -{
> -	return pciehp_is_native(bridge) || shpchp_is_native(bridge);
> -}
>   #endif


