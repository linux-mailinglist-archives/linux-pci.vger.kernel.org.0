Return-Path: <linux-pci+bounces-42608-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D77CA2683
	for <lists+linux-pci@lfdr.de>; Thu, 04 Dec 2025 06:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75F9C303370C
	for <lists+linux-pci@lfdr.de>; Thu,  4 Dec 2025 05:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096782FA0D3;
	Thu,  4 Dec 2025 05:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="N8T0JlPq"
X-Original-To: linux-pci@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011071.outbound.protection.outlook.com [52.101.52.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B33C2C21DA;
	Thu,  4 Dec 2025 05:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764826191; cv=fail; b=NjAh4AwpzZAETBMQ5OVGt4i2b0U5Tw8XJ0eQBO5kLoBbcHhxFjo4pMif4q7LB8+n0Z/5LdVJTKIpSZKtOCb8zk7YRpGGXog6N/rmasdbHdsXFKC+mhkios8jKqtZTPDav2mbiQJW8EK+1JSXmBgvzt/LmPtmAavq0J/0NOhYK64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764826191; c=relaxed/simple;
	bh=xxit2n9QK0jXLBigAQWMVvwrPFibofmNQ7B03V1X6jg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qNp6KaNuodua1AOWrqcfIll8mfwXhtTXsnO7NVZ+9wockIDA8otSIiZH/RoiyHHRnPqCVfW+onOT+Evg8FYASWlKIyQCE6zeEqoNHwTKDQ0O0b5A+jN7ulPCW67sNj1q740F41aEnFyVxclEc/41N+FJoj4r+Es/H9EnvXyzmeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=N8T0JlPq; arc=fail smtp.client-ip=52.101.52.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xY/XmeYBxjNj2diFfR9KioIKR1lWIaduL76nz4x2JWa3FZZ1xzT5UaU692CeoIaNKroYJFBnd1ntNRmfCjahFoDcejLGbdEQnE2LYBiNrEgRp+pLfeZ3NCg2YPMrUZdJj0SAVr2xllg+eydz0+QT5YAlpJ1PslifY+uuTOlJrf/hbDH83psbbvq2gAFNoGLp7t72A8N75WZGINvIGFsA+gR3BeY67i/vAm9nUKvn4p3LGXGqYZYw0AqKGC5V+AEldaittOiCaAuLDBrleBA7W/Ga1Z1bkebVwfGUwDoA2IIr8vpncnjlMAic1TP29iNw1BBsKj1RERjXhJHRJPBjTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hjJnGCYV6S0Dv/eNffstGfh/u51RzLHiEgZy/OhvSYg=;
 b=f1ciNhSIILP2b7T1gDWefO2+/i1JQG2Du9axc8lBFaiaBXwHzLjhOaPU9zobPBPXUsrIRQcUQ38qCdToRlc+z/V+K7/NgiKh1Xt2DMSasBf7dz2NOFh07adKFmL4w0tpJHmFsbRpKv+AA6vjmfSHPB6rRjl8aSSXS2/ueiADqS3zbzMtu0IHW6XdW8b51FEj0yLS0oIe+iU7QxLFrrdWkGdAdpMausMw0xLsqYqkkiWAT70beqfwau0dxDndfqWL3lgXgvYKrLdPxjb++3ODLzesxHPSKwlA6OHz/qo1kIfOQA9QG2bBeAfTdV1cJeFEdvW2wQrI/fJm5QHTn0BdsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjJnGCYV6S0Dv/eNffstGfh/u51RzLHiEgZy/OhvSYg=;
 b=N8T0JlPqcv9c/75mhm/2y9rL3hUZz9gbtkESNpP9KQSBd+foLAzjS2zAhccqkPRPe1YcB4rOKTEyStN/7Y0Awmh+2k7XreizTxVxIyohAzF1w2ppnYm/FigitvCWSaEcWlQ84kXCQtgFs+KvxKNRq/n3TzeV48AHHA7GinrMCDE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH2PR12MB4232.namprd12.prod.outlook.com (2603:10b6:610:a4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 05:29:44 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9366.012; Thu, 4 Dec 2025
 05:29:44 +0000
Message-ID: <222da706-19c5-485c-be90-2ebda20c1142@amd.com>
Date: Wed, 3 Dec 2025 23:29:42 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PROBLEM] c5.metal on AWS fails to kexec after "PCI: Explicitly
 put devices into D0 when initializing"
To: Matthew Ruffell <matthew.ruffell@canonical.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 lkml <linux-kernel@vger.kernel.org>,
 Jay Vosburgh <jay.vosburgh@canonical.com>
References: <CAKAwkKvmdKxRRA4cR=jJEdyadon6uKXe+aFXaGSe=PNSgwDf9g@mail.gmail.com>
 <cecdf440-ec7b-4d7f-9121-cf44332702d4@amd.com>
 <CAKAwkKvmZUGi+gEhr1nw5MV+rfyVP=Exu4AW1_WOPHDH6tSYug@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAKAwkKvmZUGi+gEhr1nw5MV+rfyVP=Exu4AW1_WOPHDH6tSYug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR07CA0041.namprd07.prod.outlook.com
 (2603:10b6:5:74::18) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH2PR12MB4232:EE_
X-MS-Office365-Filtering-Correlation-Id: e3c95288-094a-46a8-4dd0-08de32f621c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bldIeHZ4WWh5ZkVnbjRtWHJEOFRWNkkxMVlHeXNBc2JsbzJRTzBmZVN4V3gw?=
 =?utf-8?B?ZnBRQ2g1QXRmdFdJMGRWVlhVY1doMjZJSEpuTE5IYlZLTzBFeWt2bndTeUZN?=
 =?utf-8?B?WDJwRC9uSVlST1lWSmNidEZGV1JFVHoxMk8razg3TDJoQ0pYa280ejJYM2pQ?=
 =?utf-8?B?aWt3TFJhNGpHS0pKWm1GY0NMRHdkQm1DOXdBRTdUWERGVkR4Kzg4QlYwNUtr?=
 =?utf-8?B?TER1ZjRKWlJ2Y2wycWUxNlFaM0xPcllwYmtVYTZSM0pUOHVONjVlMVg5VGpH?=
 =?utf-8?B?RFhJa3ozU2tKUVZJR0JOMW9INWFqcnRNdmhPYjJoemUvZzhhd0pxenEveklJ?=
 =?utf-8?B?WnE5dm81c29ud2lnK3ZKWlFMTHJhR29yZklUbkNhREJvYXJKb2QzZU1JeVUz?=
 =?utf-8?B?U1ZoK0ovZkhwM2pKQ3NBQTZ2K3dYRmdoSmY3Qy9MQXAwL1Zqbm84czVkT2Q5?=
 =?utf-8?B?NEFLcndVS0JhWlgraGZPUnU4UlQ4aFptTVUxMU91MVFiTFBURTV5Um51bkV3?=
 =?utf-8?B?dklrY1Vza0ZMUHpHaVNlUVFmYndCQ1gxbytXUVdxSDJNYVpiTFdWM05UZnRC?=
 =?utf-8?B?NlN0V1VXUTVPY0JFRFhodXVMbFpIWWhESjk3YmhZN1NEY3ZRcytrUkxCTC9U?=
 =?utf-8?B?V3IrOXY2TE01Q3VuQXNWOXM3WGlUeHlBVmp4dWRYaFRoVmRsaXVLelphaU5N?=
 =?utf-8?B?WFk3YkcxQU1iVWU4eS9rRFdURStCT3Q3U3pNTFByeTg5K2lkQnM3bmdDaWNH?=
 =?utf-8?B?cFFJaENGd2tidVRjVkpFZ2pMSzR4ZGsrQTNvZFVNZzkwY3V6ZFRpZ0xHRUVY?=
 =?utf-8?B?S0Z6a3NzcVlBWmd5YW5ZbEFxWGg3cHlGMXkxMEVKSUNFYkFVRkhua1YwS1pz?=
 =?utf-8?B?cDdWV3p2RUFqN1VZcTlRU3V0VGdyTVdSK3B4OWswOENETWhVemphNHU1OGZP?=
 =?utf-8?B?K0RjbEpQaGJGRGhidmdpQXA2ZW82TnJHZU56Y0kvT0VXRWxzSWQ5WEF5ZEw3?=
 =?utf-8?B?L3BDV3FIMEdWaWJ3aHhLckZqR0tRR2QrNlVRbkRFMm5kaUhpcHp4QVQ1VE53?=
 =?utf-8?B?M3JrM2xub1I2S3h5eDZmamx1Z0Z2aU1ZbUFsaW05NW8vOHRLK3JCNUY4SkF2?=
 =?utf-8?B?V1ZFMEhsbzJSU0d5R0IvOXNsT25UUVl5NFVOSkRkdVdXWlJzQ1poall4ZklF?=
 =?utf-8?B?T3crRENnWXJES3lSbGlNU3drclU1WldNWjhGbjljMmdBQngxQlhjblNSQVY2?=
 =?utf-8?B?MEo1WmNCdXJGTEZJVTZtS1YzNTBSdDZ4WnRkWlREV1gwazVtZUtmZ2ZCQ3Bt?=
 =?utf-8?B?N05MVllaYzFHMzkzY0xwdndMUFdzdDBYZnNCYTEwdHJ6dkl6V3FwMnZDUUl3?=
 =?utf-8?B?a2xVdzAyRmdQdU5NRVo3anpWTkg3UFBpWGh1ZFJlR0JRcHZ1L2NIQUNMOVNN?=
 =?utf-8?B?ZFZSbG1pM3NKbnZ4eUk4QjZPWk1Wb1dZdjBMazdHV1BRWjhBeTRvMU5zNEN6?=
 =?utf-8?B?a3N1UmJ2NC8yY1FmS2owZ2Vic3M3bGUrc1JCdkg0NjJ1R3dUZlF1ajZNWC9o?=
 =?utf-8?B?MmFCS3UzdXJXT0t0K2F2YW5mdGxhOS9KS3hMcW82eFpCMXc5K3REU256RlBD?=
 =?utf-8?B?Mkl1elYrL2pzUi80dnVCV1Zad3I0ZGpWQy9SaWY1RUg4WG82WU9RVzJSeXBO?=
 =?utf-8?B?WVptVmlRR1BFUEtXNXNYeGZ2aWtabVhMd2xCcTJUV1FDREJXbHp2NHN5RHpT?=
 =?utf-8?B?dm85VUtnZjEwZE13NVh2eks5Z1RoYXJaVVFzSWtaM1R6b3crUjM3OXA4d01p?=
 =?utf-8?B?RVFKSWJFODZ0RHpQekIzWHRsWit2SXZTSE5LK1A5dzVyaVJudHRXZEF0NUdu?=
 =?utf-8?B?Nys5ZW1Cb1RKeHlLVGdvaXQyMUoxVzZubnpJelQybHkwMStmS1ExYlIrdWt1?=
 =?utf-8?Q?uGDf7QDkXOAWn/+an11iTX+q/Zl+1pje?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aTVoV0oyRFBZSkRYVDdLaTNVcDNGTWlxZ3h4c3JaclNHT3F0a3REWUo1OTRV?=
 =?utf-8?B?MFF0NnVndVRIVUtNc3RHc1ZTMjRPelc3UnZwVDltUFJiOXQzNmM0VkhlZ3hO?=
 =?utf-8?B?Wm5mdzVHMHZnYi8wWnJTRFhuUDdnMzNRakZhREpnYjVXdU42dkkwZ2o0cmZI?=
 =?utf-8?B?cU9RVzBxK0VaS1BVYkZSdHpiQUQySmxWeks1LzFnd2FFcGEvK1RoRGlTK3JO?=
 =?utf-8?B?WGlaK0VOZjhhWXhQdWdRYW9DWEVWb2cyZlpuVUxmNURzMGNsTWZQTEorMDFm?=
 =?utf-8?B?MTFkcTdtQWRxQjQwWTBVWktTR3NDdFVPRS9ad1pSUGFwWGRTQUxIN0lTOGVK?=
 =?utf-8?B?MXVQYi9WWUZaU3hIem9IMldlTU9tV2ZTczBNLzFEZ3doL3hna05uakg4K2o5?=
 =?utf-8?B?aDdGV081aHpLMjdnT0NRb1FwSnd5V3U0RG1OVEtvTXk1SW5QTmZ0bEpyMEpr?=
 =?utf-8?B?ZFFvNXltY1h6MzVGSVVmMjJVSGd4djJGcnRZNnE1ajByVUc4SGxmVmhock1L?=
 =?utf-8?B?MkdNMVoxQzJDYWVySmlLWW5qL1JLYjczbForRUN5cXEyclpIakJxdGVQWjVa?=
 =?utf-8?B?ZDUxK1pSZHZsNEhIeDN6SHVzSlFFRjVTY0xNbkdnMCt2VytacVpnRUhDYWF5?=
 =?utf-8?B?c3NWMVk5ZFY3aThqTWMwbEJoaTRDWGtpbEhHNDdvMTdGZjlwcnltNWMxVjRs?=
 =?utf-8?B?RGpHYWZubDBqNi9PbTM3QmZ3Z3hydzBFTFRMcFlzWllkZjFPOWl6Vk9YeTQ5?=
 =?utf-8?B?OWFPY0xmMjU2R1FzMU5XQnFXMGxCVlgxQlV2UjdVMk9BRUJYdy9sOFlQQmEz?=
 =?utf-8?B?bDlNTTUyUFBTMG9zTjFod0hlZVV4Rnhlb3NrSnZiM056a3hiSE5ZZTFlUnFi?=
 =?utf-8?B?aTB3UE02ZFZTUlMzYjVJVXFwUFNzak9PNVZrQ1pDWGI4c0oxYXFoY3dDa3dK?=
 =?utf-8?B?M2FSRHAwekd4bEM0dEIyNVVEdHFKM3F6dlZ2Q3RkT2hseEcxbzlMbE11OG05?=
 =?utf-8?B?cWdnUFh0dnBVTy9oa2hHREpaeHh3dUs3ditBZnBJeGVyaXdvTGdhTmZLMU5j?=
 =?utf-8?B?NlJvTitFRFpvbGl3WTdQK3prZEJsR2hrdm1SYTFXclNnNHJvbDZpN2I2V0J0?=
 =?utf-8?B?YXQ2RFVuRHhpUTZJNXNlK0FyWEpYRTZOcit1d1VINmNDTkhQdWtDZ08rSXdZ?=
 =?utf-8?B?cFZYRnZGT2VXVXp3T0VqNS9XdWhXdFlUNTdFb2hRc0JxSjZrTEJEa2tzc2pr?=
 =?utf-8?B?SjFCVFh0UmM5bFNMbTRucDNnd0pjYXB2aHl6ZlJJNFEvQjVtQXBSa2VrYUxX?=
 =?utf-8?B?T092SVAydTMyNFVNR21sQkZ2cUoyajQxeVhYVjlDUnordjR4R3hFR2dFRlpJ?=
 =?utf-8?B?WVZDcVpXRVduSklIc3hSMnUrb3hvOGJKK08rcUExdjlpRldyYVhpQ0xaLzVr?=
 =?utf-8?B?Y0FXcW9NZ1lEQlY3eklFczVONm45aHQvT2psSzVrWG4xQmFHdFNUVS9vT3ha?=
 =?utf-8?B?N1hNeEJCRkFCOUlnYllJRGZnTlFtOEpCcTMxSERpK3oyU0c3ODZnTEtILzdP?=
 =?utf-8?B?a1ZDMEZpeDZab1Y1Qmd2YStMemlDUGZtNUdZRC9OWmFLZ1ZLQUZPUzl0VmU4?=
 =?utf-8?B?M0RhSHBDN3QwR1FwRVAwNDJNYk1LYkV6b0tlMmZ3c1cvOEhieVN3UFo4VHow?=
 =?utf-8?B?R25reW53RGhMYkVNQmgyZk92cytEeEpqTmZiOUh3ZGFUcGYwKzFhN0FQdTc0?=
 =?utf-8?B?K21ONzY3SEtYNEFwUzIxbkhmRGVNb3RKcjhQSVMrbk5vTWE4NEVRUmpSLzVS?=
 =?utf-8?B?U0h3dlprc203a3FQcExVYWpvZnpqZkdDcnJhdjg0S2M3VEFlMFNmSGNpQjRi?=
 =?utf-8?B?dUFad3B4U0lqWkVVVTMwL1VCYnd0Y2oyQVBDQmVLaXlVQ0x1M2wvand3NVN3?=
 =?utf-8?B?L2hrUVdXb0JYQld1YXBTcm12dHhrcWFqMldUZ3VyUW55MWFKOUg0Y2dGMzFJ?=
 =?utf-8?B?b0hTVUVaWWR1eFhOTHpIMEo3UDJGbmFsUkgyNzJJTjcraTIvTzNRb1pGS1FU?=
 =?utf-8?B?U2Z1dzFnZ3dzYW10VDhMc29tcWdtOWZlbGQ1eFBUYlJoNi9ITTR6VWZlOGlX?=
 =?utf-8?Q?Fp2PT8fQWQK59QtNwdrhtN+91?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3c95288-094a-46a8-4dd0-08de32f621c1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 05:29:44.4376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kk2IyH8GfeO0c3eWwgM8tIYCBfEw5LGx/EO1m5AIFC/M74cwqFutsoWavKU4U3XlaV1T91otGQ/TVkJ/eG1ZOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4232



On 12/3/2025 11:04 PM, Matthew Ruffell wrote:
> Hi Mario,
> 
> I thank you for your prompt reply, and apologise for my delayed reply.
> Answers inline.
> 
>> When you say AWS specific patches, can you be more specific?  What is
>> missing from a mainline kernel to use this hardware?  IE; how do I know
>> there aren't Ubuntu specific patches *causing* this issue.
> 
> I can reproduce the issue with the current HEAD of Linus's tree, with no
> additional patches applied. My current HEAD for testing is the 6.19 merge
> window, commit 51ab33fc0a8bef9454849371ef897a1241911b37.
> To get the mainline build to work on c5.metal on AWS I needed to edit a few
> config parameters, and I have attached the config I used.
> 
>> Now I've never used AWS - do you have an opportunity to do "regular"
>> reboots, or only kexec reboots?
>>
>> This issue only happens with a kexec reboot, right?
> 
> We can do regular and kexec reboots with the c5.metal instance type. The issue
> only happens with a kexec reboot.
> 
>> The first thing that jumps out at me is the code in
>> pci_device_shutdown() that clears bus mastering for a kexec reboot.
>> If you comment that out what happens?
> 
> I commented out the code that clears bus mastering, diff below, and kexec boots
> correctly now, and the NVME drive appears just as it did before
> "4d4c10f PCI: Explicitly put devices into D0 when initializing".
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 302d61783f6c..0cb14ff32475 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -517,8 +517,9 @@ static void pci_device_shutdown(struct device *dev)
>           * If it is not a kexec reboot, firmware will hit the PCI
>           * devices with big hammer and stop their DMA any way.
>           */
> -       if (kexec_in_progress && (pci_dev->current_state <= PCI_D3hot))
> -               pci_clear_master(pci_dev);
> +/*     if (kexec_in_progress && (pci_dev->current_state <= PCI_D3hot))
> + *             pci_clear_master(pci_dev);
> + */
>   }
> 
>   #ifdef CONFIG_PM_SLEEP
> 
> Since this works, does that mean that the bus master bit isn't being set on the
> NVME device on the other side of kexec?

That's at least what it seems like.  And I guess trying to set D0 
without bus mastering enabling is causing a problem.

Could you try adding a pci_set_master() call to pci_power_up()?  This is 
what I have in mind (only compile tested):

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b14dd064006c..68661e333032 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1323,6 +1323,7 @@ int pci_power_up(struct pci_dev *dev)
                 return -EIO;
         }

+       pci_set_master(dev);
         pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
         if (PCI_POSSIBLE_ERROR(pmcsr)) {
                 pci_err(dev, "Unable to change power state from %s to 
D0, device inaccessible\n",

> 
>> The next thing I would wonder if if you're compiling with
>> CONFIG_KEXEC_JUMP and if that has an impact to your issue.  When this is
>> defined there is a device suspend sequence in kernel_kexec() that is run
>> which will run various suspend related callbacks.  Maybe the issue is
>> actually in one of those callbacks.
> 
> Yes, Ubuntu kernels set CONFIG_KEXEC_JUMP=y. I did a build with
> CONFIG_KEXEC_JUMP=n and it has the same symptoms.
> 
>> A possible way to determine this would be to run rtcwake to suspend and
>> resume and see if the drive survives.  If it doesn't, it's a hint that
>> there is something going on with power management in this drive or the
>> bridge it's connected to.  Maybe one of them isn't handling D3 very well.
> 
> Unfortunately, this c5.metal instance type doesn't support rtcwake with mode mem
> or disk, as hibernation is disabled on these instance types. But since
> CONFIG_KEXEC_JUMP=n doesn't help,
> 
> I'm going to add some debug statements to pci_device_shutdown() to see what
> state the NVME device is in with and without
> "4d4c10f PCI: Explicitly put devices into D0 when initializing".
> 
> Thanks,
> Matthew

Thanks for the updates.

I have a relatively ignorant question.  Can you reproduce with kdump and 
a crash too?

I don't actually know if you configure kdump and then crash the kernel 
(say magic sys-rq key), does pci_device_shutdown() get called in order 
to do the kexec?  Or because the kernel is already in a crash state is 
there just a jump into the crash kernel image location?

