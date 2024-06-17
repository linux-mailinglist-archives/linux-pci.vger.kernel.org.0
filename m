Return-Path: <linux-pci+bounces-8896-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC31390BF54
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 00:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65C9D1F21E5B
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2024 22:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8570319B3C5;
	Mon, 17 Jun 2024 22:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MN/n/wpO"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23AE19A282;
	Mon, 17 Jun 2024 22:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718664722; cv=fail; b=C1nZ1SIY1DCwcpXp1TXpWgPPNNjiKc9qf/HYvsy7sAVR7Y1hY63KimhUexCCX0wP69FskB8Tdr8OnQz7ljSrXxzGPqLiyU/wkmyaF+kGb8zQYLnKEN+tHHr40m6MTS12iOBg1g1ujDw8jPSy9CYpZpErzG+4xg32XAuzy9KJmEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718664722; c=relaxed/simple;
	bh=2s23qpNUXSjZZcWxWOkmTcLzF3Ie4wrHVTvVSm+eXfY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=WiXPgR7RqypKnEi1bZKBOY0xCI7N5mSaqYJyR1e9DJ0CltAsysVarKcH/jMMVqCEDLNwWm3/h3etOnzSYXO16ObKfpHg0EL6V87o3lLWHuA0C0ougVj6cRn+FWNs/4RM6p2VD5H/14M7zmyTR+Hef9Bw631Q52rJJBHJ2ER+qk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MN/n/wpO; arc=fail smtp.client-ip=40.107.220.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GBEpuvYKw7kK1MUsVGUqhoFgUF00ASSax1vjez0UtZSfJwZQ7rUOb2M9FbnQKkOqq1RnrzVyw8TcENA7JQZXF+dtjo6DgPi+KaqrOFfdPYHxvzXLzniESkLwq8Qte/l1IVTwZEShVv//yeh2gNLVbkOo86dhrpzN+K+q/3NZNDYCPPxUB1iXz1OPkHYLPWzC8KsVuxbFotNgz8EQBM66O+I9aYWASbDubRTIv+VNjQELpco6lZV6nr26rLWM4SbAjOkKM6LxUXhC21kZIjgER8Dlhtf4SLM7IYa+9a16TAa+evdDy9jYsZd1H5QJklX8xwNZX56aa1sCSt8zPfBMZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bbw3Z5BWfR8u9qBBr8qn8k4IGWvP/0tk5ylKRMimHyA=;
 b=BrNt5Ucdl4xd3hBTi7kpgBEJd20txBZHm2stJMP/QSgLu6L6GGrg6PIEMxN5C6tcFlQCKy6pYoSMTFPoV6hr6wnfTBmV2k+WN2U60bxvHAU8KJemuqE2weZfUGQoqT6q2n+7pXRMaQjPywRwZ/SQXbP49hiNhusn/Om5tggsN8wl6c4m91O7hZVS4v2yfTMs50k9iO56yY5pdMbMNdHfH13LW7zjdIJ9jqy2exWnYUFzzF/WUlUdBSZkeHt2IzQxSvXMlwgmSvODCUBewTq4lALNCF2HDeORi4zYrF4uZbwlWUt6letTvuZ2YdUzIKbYspxSBRjIpevFmNnalUUTCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bbw3Z5BWfR8u9qBBr8qn8k4IGWvP/0tk5ylKRMimHyA=;
 b=MN/n/wpOoPEClgDJ6KlbTekvw3jT+1oifiwZJeFP7xnFwIbg3ZIm69LCOk8BHYJymZk0G2SwtP+zpPGEwOGVf2Xrh89M2/y2DGa4xWLZiG1clGRI67Us+ZRtLjgue1bEkJIU9qkwC3ZHktF88MucruxEoRomwG0D2WS1rr1iUGA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by CYYPR12MB8922.namprd12.prod.outlook.com (2603:10b6:930:b8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 22:51:58 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::56a2:cd83:43e4:fad0]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::56a2:cd83:43e4:fad0%5]) with mapi id 15.20.7677.026; Mon, 17 Jun 2024
 22:51:58 +0000
Subject: Re: [PATCH v2] PCI: pciehp: Clear LBMS on hot-remove to prevent link
 speed reduction
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Lukas Wunner <lukas@wunner.de>,
 Yazen Ghannam <yazen.ghannam@amd.com>,
 Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
 Bowman Terry <terry.bowman@amd.com>, Hagan Billy <billy.hagan@amd.com>,
 Simon Guinot <simon.guinot@seagate.com>,
 "Maciej W . Rozycki" <macro@orcam.me.uk>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20240617200945.GA1224924@bhelgaas>
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Message-ID: <4241291f-7e83-c878-6bff-59649d630410@amd.com>
Date: Mon, 17 Jun 2024 15:51:57 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <20240617200945.GA1224924@bhelgaas>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0107.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::48) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|CYYPR12MB8922:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cacb5df-2588-42ad-d77a-08dc8f2017e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|1800799021|376011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?akxwVTVicERKRHpmZmdWR1Z0Rlg5RW9oamRqWWROaHF6S2w1bDhTYUFHNS9B?=
 =?utf-8?B?M3JsWnBhV3Z0bzN4VFgyVnp4SVRQbGZmZjE0OWpWaC9Nbk1TeUdEajQ3UFpr?=
 =?utf-8?B?RUtXTWJ0WENBR2RaOUc0a21DNFRxQU9QOFV6bVpBMmd5TGNpQlhBeTVqQW1H?=
 =?utf-8?B?bGtRYVk3VldVZkxMRVc0amE2Mm5rMzEzd0w5VVIvaVJKQ05sdFhRRThYLytz?=
 =?utf-8?B?NVVFQi94aGNXOExSakcyUGl0NUJNWmhvdnZ1a1ZPOU9kZ014OEVISkhzVG85?=
 =?utf-8?B?YWpRekNBaGlHMGdNbGQ0MVhydmd1YlFYM05nclR6WHNvbE1oVzJUejZyQitz?=
 =?utf-8?B?Mkl5eStaVTRSL05SVXJvYXlQQkJxaDBpVE13c0FWS1VaUXZYa0FieVBJNFZ5?=
 =?utf-8?B?b2pwN1lhQ25nZW5ON1FLNUZRRHVCN1NRQ2U2S3NNQWZGQkQ2U2RFaEtjQUx1?=
 =?utf-8?B?N3hLSHp5VUhyTjl4ZDlSNTg1c0M5dlhkSUErRk15cG1IWG9hYzhNcmlSWnov?=
 =?utf-8?B?dVhpMXlydFFDQkRnZ1N0bHFpNmRadm04NXRFQ1BUbGI3c3hoYlB6NDZsVnZ3?=
 =?utf-8?B?Y1ZPbXcxSzVGUHlCMk5QNGRtVytXR3g4bjhUbzIxbDI2K3dYSTFMbVU0N2tz?=
 =?utf-8?B?MVB1UXA2SkYxY2h4Uk9ORDNHT3M4MmYxYnhNV2x5ZmhTbUQrYjcycUdNTjJh?=
 =?utf-8?B?dkhhdTU2VzE4WGRUYmpTdXJmem1BcHlaemI4VTBFaXEzaHJGUFV6OEpZaHV1?=
 =?utf-8?B?eXRMNm9lRHNHcnRPV0RjOE53RnRzemFSOXphVWFpVDYyNVArWlhQdlplZlBu?=
 =?utf-8?B?L1VtMzYxaXA4cVJSVkpPSjljL2V3UjArajAwV29uYzdoYnpjcDBXTHZhbmgx?=
 =?utf-8?B?NWZMdVdMbmlJZitMZEl3SHNpZWZRZUhFVzV1ZmNtNERLNFJPdC9oM3dMRFpG?=
 =?utf-8?B?KzBUbWV2V0xqZ1VDVGJaYTJneWZGbFdIZm1rR3U4N1U3M0pMQ0VobEM5L29s?=
 =?utf-8?B?dGZib0Mrck1oZ3luY0MrVHpVRHdaLytZZWlQSmozOGUyR1hWRmhYZ2RCZnky?=
 =?utf-8?B?RFpUM1BqN3NMNHZjcUdJQk03Nmt6eGJhWklkTEVQTkxvRWlhUFcweWkvL1I2?=
 =?utf-8?B?enlWeW93YjJ5N2JtL0VhU1FIZ3pzaFZRRE0zUUs0Q0dTbW12dVdWU05uNHZZ?=
 =?utf-8?B?dzZGQXZLWTh3VW1mVnllR05Ub2FCdDVSQjJaUWRWb3RScDNQekt1L0VuRjJI?=
 =?utf-8?B?V2RkaDFTMHE2UXB3T3JLdDNKVW8remdiUEFZK0w4WHcwZ1RONzZsM0FZUG5J?=
 =?utf-8?B?dXZUUExQaTRReUVzSUdPUk9NbUpQZVNCNnAyOE80WExPT3FFdGgvTis3YmdX?=
 =?utf-8?B?NWlDV0g3c1Jzb1lKYlh2eDlIYTdHamFXelBPZnU4YStBdUtWM0hXZWg4VFV1?=
 =?utf-8?B?YWhXTjY3UmJNN3NNRHEza3ZvN0dOOU5VcFVvM29PTzMxK05HSVZTZlh1bzlY?=
 =?utf-8?B?UnYxRkI0SFJjL29JVDF0ZWEwc2tyTVNQbUUxWHdPRHdBb0hEajFMVnRSMkRv?=
 =?utf-8?B?Y3hyb0hWVTZGYXRRRDlXWlJkWUI2UVBFN3lZN3hucFluQ2hSSnJra09SWFJZ?=
 =?utf-8?B?RFRxODBMRGpSdk0vS2NRT3VOa3hBaGhjYkFzOWQ1bEprbHZrY044Z1pkS2tK?=
 =?utf-8?B?N295Z003UXFBYVhJU1BUeURBdlROaXNDeGJ4T0RDNFJkRlVvSlpzN3hRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QWV2RVE5QTFaSFh6V0tsdXZUeWMrd1BXOHZaYzBTdUFKRGYyd0luejR4WVkw?=
 =?utf-8?B?MFNlclJnWDBWRTEya1JqWmplcHZtSTRXZEdBUUx3NDJKbDdDSHR4NEc0TW5W?=
 =?utf-8?B?aFhFaXZkUFpJSmJaNW0wS1orU2Q5K1dWd0kvUjJweE1lMWQ1eHFub2I2VnNl?=
 =?utf-8?B?OGFwVHM3SUR4U3ZiMnYybHFYeDBOV0c4MXlEZGdRVkx3RWZUdmJjb2hnR09O?=
 =?utf-8?B?eEhFbzk3V2wxdFVKU3V0a0dtOXEyMHc1MTBtQmJSK2ZCeUhWaTFKWWtQUDRN?=
 =?utf-8?B?eGdxMW5SenhCZkZvclJVcGJraHN4VTJJMVFkYWNYMi9kUzMwbGpJUmYwRURZ?=
 =?utf-8?B?OGpJSTNQTGJ0dEZIcFJEWXFLQ2VHR2V1eUVrcUxnZkg5MzVXNTgwTFI0NG9w?=
 =?utf-8?B?dlY4VWE4T2k1ZFkxcnZzRU9vYVNpTjFFY0lXYnMyczgxRUJkVmdWaWZZbXpZ?=
 =?utf-8?B?UFJ4MmYycTIzeCtPTzY3MXQxZ1MybjQwZWVibVNRcU4rUklFYTluRUFVV1p4?=
 =?utf-8?B?M3dLaHZqSzZwdDl0M0ZSS2NvZFNka000SWI0b0E2a1JEWklVZ0k5amRIdFhF?=
 =?utf-8?B?OXJYN1Y5K0NkQ0tIOFhyUnJ3V2xvSUtuUmhZVEhIRjgzYm9jSHRFZGNlZEVD?=
 =?utf-8?B?QXNHaFppNmFlQ3N0TU4weHlPUVpnRzBwTzJEaWVRSEY2TjJURTJua1gzanlm?=
 =?utf-8?B?Rkx1dkZoM1JvdEpsTk9jdCtpZm1vNnN0U29JSlgrUHhwWnNoUTVwNkVEMUp4?=
 =?utf-8?B?RWs3NlhXeGh4eVlCY2Z5RUsxMk9rRllFb3Vud3N3ckcwbFJ3bmJKMlJaWUkx?=
 =?utf-8?B?ZXRzSEhQcTlsRmRMS3JVZTBDZUVJYUZrREpzQTN4OUE3RGU2VzR0aUk0RGFz?=
 =?utf-8?B?Q09hTlRDbFpnKzlHeFdVaklqOHJpSXZrdGxpQ3QyZkJUMzNYd1g1c2tnWlZT?=
 =?utf-8?B?M0VpWXpVOU9QQTJWZUlrZU9jaTJ0REtlN0VJd2JkWElIQjJ6UXVwRnRrVjdx?=
 =?utf-8?B?TUtYS281TXdIOHlwOElTZzdhRjZVZ203MjdJRkw0eVZqZE9sQzZRRXJyM1Vq?=
 =?utf-8?B?b1dtNG1iTWUyWUZKL29nMjVYTmFGamQzc1ZqaCs4dWoxUFhpQ2Nka2hZSWNN?=
 =?utf-8?B?UGs5Rm5vRGV0dFBCMllYUmpXZ1JsMTNEU05uMGZiOXQwZTgrRUFaUURvd0w1?=
 =?utf-8?B?cmRuVEY4ZTN6bHozR09kL0kvdkpMMkI1Q001L1d5V28vaG9WN2tWcWQ2bHBB?=
 =?utf-8?B?Nm1BWjhPMXlYVkN6VFZwQ2Z2b2hqcU1ZUk9oZFo5SCtlSWFTN0FVUDlrZGd0?=
 =?utf-8?B?WWVOcDRMMkdyWjdMcVhSQ0w1OXdiR2YwY2NXRzdvSUg1elk1SGF2aWZxNjJD?=
 =?utf-8?B?ZkZtbFRoWVlXYzdzaWV2V0o1UitmQnZGSG0vZnRuZitNMGxjTDBralhVVUFL?=
 =?utf-8?B?OUtqeThkczZRUGdHSDMrSEtaajVOek9xZVE0a3BrNnp6SkVlSkY1cHpwa3hq?=
 =?utf-8?B?SU41cVhjTEdQbFNpUmVXclZDN3ErUzlSVDk1RjNPWUttTW9VWk5PeVNrYjcz?=
 =?utf-8?B?amRQWXVNOXNXZjBkeUg1TXB2MTJCeTJua09SN0tid3d2QjBzaStVOTNHVkNT?=
 =?utf-8?B?Yk1HNUlLSHI0bEVOb3Q5N0ZCZU1TdkRlWDZmZzg2WEhGRE9ZaUE1dEdiM0Ja?=
 =?utf-8?B?bXRlUXdFd1dHZ0VUcDNMMHQ5S2FyMFhMNFNSRHplL1JhR1dvUmVaZ1llM0M3?=
 =?utf-8?B?ZXFUeXBHRnQrcGZEQWhEc1RTWGsyaWo3UWhUWUIxYlJ4d2s5czVGVWUvQ1NI?=
 =?utf-8?B?WXFaVU01Vys3Z2YvZWhiMXpmdkRUQjhhellweG1ydThTWC9GMmhNVkhrR3VF?=
 =?utf-8?B?VjVpWmJWUks0S0QrWlFsUzNOd0VpT3pkenlQSEhyRVBtOWhIYy9BV3JDYlZR?=
 =?utf-8?B?WlVuTWMwL1Y0RTVGZ0QvbFJYZmJQcjZsZldMeVZ2dG9hQXVnUlozQjFtNS8x?=
 =?utf-8?B?SExkRlZLSzArMnVITkhnbW1QWHU2dlpnbFJROVVnbFVNOWhUdVByc21TOU1Q?=
 =?utf-8?B?TjFOYWFYaWNSbnBRSjY5NlJHd2d3T3dKSnNiSHJoekl3TmJXaC9PMFlZYmVV?=
 =?utf-8?Q?g0M822F8oxnHIphXoK+IKh6kN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cacb5df-2588-42ad-d77a-08dc8f2017e8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 22:51:58.3733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jUyJ7Uhq+j3aj/Nkh/oJCE/XRc2AU6CjZA26ejDgdERrd8ZymaHUFCAhMjHfFUqYhIz45gYJtrh5FAC5cOwdNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8922

Hi Bjorn,

On 6/17/2024 1:09 PM, Bjorn Helgaas wrote:
> On Thu, May 16, 2024 at 08:47:48PM +0000, Smita Koralahalli wrote:
>> Clear Link Bandwidth Management Status (LBMS) if set, on a hot-remove
>> event.
>>
>> The hot-remove event could result in target link speed reduction if LBMS
>> is set, due to a delay in Presence Detect State Change (PDSC) happening
>> after a Data Link Layer State Change event (DLLSC).
>>
>> In reality, PDSC and DLLSC events rarely come in simultaneously. Delay in
>> PDSC can sometimes be too late and the slot could have already been
>> powered down just by a DLLSC event. And the delayed PDSC could falsely be
>> interpreted as an interrupt raised to turn the slot on. This false process
>> of powering the slot on, without a link forces the kernel to retrain the
>> link if LBMS is set, to a lower speed to restablish the link thereby
>> bringing down the link speeds [2].
> 
> Not sure we need PDSC and DLLSC details to justify clearing LBMS if it
> has no meaning for an empty slot?

I'm trying to also answer your below question here..

 >I guess the slot is empty, so retraining
 > is meaningless and will always fail.  Maybe avoiding it avoids a
 > delay?  Is the benefit that we get rid of the message and a delay?"

The benefit of this patch is to "avoid link speed drops" on a hot remove 
event if LBMS is set and DLLLA is clear. But I'm not trying to solve 
delay issues here..

I included the PDSC and DLLSC details as they are the cause for link 
speed drops on a remove event. On an empty slot, DLLLA is cleared and 
LBMS may or may not be set. And, we see cases of link speed drops here, 
if PDSC happens on an empty slot.

We know for the fact that slot becomes empty if either of the events 
PDSC or DLLSC occur. Also, either of them do not wait for the other to 
bring down the device and mark the slot as "empty". That is the reason I 
was also thinking of waiting on both events PDSC and DLLSC to bring down 
the device as I mentioned in my comments in V1. We could eliminate link 
speed drops by taking this approach as well. But then we had to address 
cases where PDSC is hardwired to zero.

On our AMD systems, we expect to see both events on an hot-remove event. 
But, mostly we see DLLSC happening first, which does the job of marking 
the slot empty. Now, if the PDSC event is delayed way too much and if it 
occurs after the slot becomes empty, kernel misinterprets PDSC as the 
signal to re-initialize the slot and this is the sequence of steps the 
kernel takes:

pciehp_handle_presence_or_link_change()
   pciehp_enable_slot()
     __pciehp_enable_slot()
         board_added
           pciehp_check_link_status()
             pcie_wait_for_link()
               pcie_wait_for_link_delay()
                 pcie_failed_link_retrain()

while doing so, it hits the case of DLLLA clear and LBMS set and brings 
down the speeds.

The issue of PDSC and DLLSC never occurring simultaneously was a known 
thing from before and it wasn't breaking anything functionally as the 
kernel would just exit with the message: "No link" at 
pciehp_check_link_status().

However, Commit a89c82249c37 ("PCI: Work around PCIe link training 
failures") introduced link speed downgrades to re-establish links if 
LBMS is set, and DLLLA is clear. This caused the devices to operate at 
2.5GT/s after they were plugged-in which were previously operating at 
higher speeds before hot-remove.

> 
>> According to PCIe r6.2 sec 7.5.3.8 [1], it is derived that, LBMS cannot
>> be set for an unconnected link and if set, it serves the purpose of
>> indicating that there is actually a device down an inactive link.
> 
> I see that r6.2 added an implementation note about DLLSC, but I'm not
> a hardware person and can't follow the implication about a device
> present down an inactive link.
> 
> I guess it must be related to the fact that LBMS indicates either
> completion of link retraining or a change in link speed or width
> (which would imply presence of a downstream device).  But in both
> cases I assume the link would be active.
> 
> But IIUC LBMS is set by hardware but never cleared by hardware, so if
> we remove a device and power off the slot, it doesn't seem like LBMS
> could be telling us anything useful (what could we do in response to
> LBMS when the slot is empty?), so it makes sense to me to clear it.
> 
> It seems like pciehp_unconfigure_device() does sort of PCI core and
> driver-related things and possibly could be something shared by all
> hotplug drivers, while remove_board() does things more specific to the
> hotplug model (pciehp, shpchp, etc).
> 
>  From that perspective, clearing LBMS might fit better in
> remove_board().  In that case, I wonder whether it should be done
> after turning off slot power?  This patch clears is *before* turning
> off the power, so I wonder if hardware could possibly set it again
> before the poweroff?

Yeah by talking to HW people I realized that HW could interfere possibly 
anytime to set LBMS when the slot power is on. Will change it to include 
in remove_board().

> 
>> However, hardware could have already set LBMS when the device was
>> connected to the port i.e when the state was DL_Up or DL_Active. Some
>> hardwares would have even attempted retrain going into recovery mode,
>> just before transitioning to DL_Down.
>>
>> Thus the set LBMS is never cleared and might force software to cause link
>> speed drops when there is no link [2].
>>
>> Dmesg before:
>> 	pcieport 0000:20:01.1: pciehp: Slot(59): Link Down
>> 	pcieport 0000:20:01.1: pciehp: Slot(59): Card present
>> 	pcieport 0000:20:01.1: broken device, retraining non-functional downstream link at 2.5GT/s
>> 	pcieport 0000:20:01.1: retraining failed
>> 	pcieport 0000:20:01.1: pciehp: Slot(59): No link
>>
>> Dmesg after:
>> 	pcieport 0000:20:01.1: pciehp: Slot(59): Link Down
>> 	pcieport 0000:20:01.1: pciehp: Slot(59): Card present
>> 	pcieport 0000:20:01.1: pciehp: Slot(59): No link
> 
> I'm a little confused about the problem being solved here.  Obviously
> the message is extraneous.  I guess the slot is empty, so retraining
> is meaningless and will always fail.  Maybe avoiding it avoids a
> delay?  Is the benefit that we get rid of the message and a delay?
> 
>> [1] PCI Express Base Specification Revision 6.2, Jan 25 2024.
>>      https://members.pcisig.com/wg/PCI-SIG/document/20590
>> [2] Commit a89c82249c37 ("PCI: Work around PCIe link training failures")
>>
>> Fixes: a89c82249c37 ("PCI: Work around PCIe link training failures")
> 
> Lukas asked about this; did you confirm that it is related?  Asking
> because the Fixes tag may cause this to be backported along with
> a89c82249c37.

Yeah, without this patch we won't see link speed drops.

Thanks,
Smita

> 
>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>> ---
>> Link to v1:
>> https://lore.kernel.org/all/20240424033339.250385-1-Smita.KoralahalliChannabasappa@amd.com/
>>
>> v2:
>> 	Cleared LBMS unconditionally. (Ilpo)
>> 	Added Fixes Tag. (Lukas)
>> ---
>>   drivers/pci/hotplug/pciehp_pci.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
>> index ad12515a4a12..dae73a8932ef 100644
>> --- a/drivers/pci/hotplug/pciehp_pci.c
>> +++ b/drivers/pci/hotplug/pciehp_pci.c
>> @@ -134,4 +134,7 @@ void pciehp_unconfigure_device(struct controller *ctrl, bool presence)
>>   	}
>>   
>>   	pci_unlock_rescan_remove();
>> +
>> +	pcie_capability_write_word(ctrl->pcie->port, PCI_EXP_LNKSTA,
>> +				   PCI_EXP_LNKSTA_LBMS);
>>   }
>> -- 
>> 2.17.1
>>

