Return-Path: <linux-pci+bounces-18987-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 052B89FB831
	for <lists+linux-pci@lfdr.de>; Tue, 24 Dec 2024 02:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3D58164705
	for <lists+linux-pci@lfdr.de>; Tue, 24 Dec 2024 01:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E61E946C;
	Tue, 24 Dec 2024 01:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="w/RE6DQ9"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9B54C9A;
	Tue, 24 Dec 2024 01:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735002876; cv=fail; b=pAsQU5GanzQquOEPXSBY7ub0DrMGInHyeWqdVhz5891xXRwiA1BHzDUBySUE4WX+BWnUybEWmsnJ84vzjRvauoQx9lxT2PF8JwiVm7AFHDIxAiB/7AoCl0p4seR+Es1f6Hg6c7Y8dAfEGgTyFXfJeYe+MQhC3m/QurvBL9yN76E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735002876; c=relaxed/simple;
	bh=1P15F79iRCnWYr3NSkczSiirKmW7+BVyA71BxAmBPr0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NtJH1SND24/SLNuLITjc6RMoj6O031epHaJZaEpbnN8QKXiN8qczfToK6DXswS/mFU+NjT4WUdO/weP5bWPTY116oIJNuiUDLCT9oDS0rXd/yCn3cytOKFcTmou3Yb3m9nXw3dyKaZYej+JyZFPdRzcqiq9pVRFVltRcXtu1gsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=w/RE6DQ9; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ArYDyl2zTL0iOyB1AEUUwC9c8J6qRcA8ei5Qfx5uQHlZD2fzufiQU7FirDhrOsGnijoJbspPYqlJ2BmEGyr4sN2iyMpXSDf4jMiYshHUW+HOG+rD0pM+6TzMSEQnaRRincrlxva8PVndmh4ljjDcRaUuUkL9bo4MRAtzs0TSzV6tHzxIcdJGwoFrqBn1aQEf72WYX3O0Gh1WVftiJzwzgIr3kdIAoic6dvBGGMjs/zKZ4HL8GyPMras+j3R7ifuhBgfm/+gAG1hjn3RN02PteiCpcIKt7kpGt6TcOCOTbV8sZD7w+rOEfL3GrZn/QKNO81I1CEiae6g4HC3dCBVNjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PaTPjpNJpbgW4V/FjN8u80rygVCk+JlEp+87Nw7e+a8=;
 b=OA+Hg/NQtAnlqVjMDXrN20PpdR+22TrsCp/yRJ50uhaS61t/+EVww5ZAJZhO/1wEdbuuzK+QeWXiRqqpNY6aIiswGmDUvM6VheKRVd0uMcO7Ue9ll2pUadfF34DqEAC7hadHH5WF9agi4k+0RyHh0Lu0d7NdH6p4p5rOf7sHof24Kxlo3IkQUTgnhHdJtUJaY00AwFKBR0/Y9EcCtRGWnobX4B9naLRMVIRHv2PgjeqjYe5HU96q3we5RYrvj+adtQC89tM0xQfKoXv5e3I43g5ZkxPh5kgv2hG40THOmkStwzka+LUv10jdrqLI+0ObivhA9aW4/7qJhKbkQpUu3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PaTPjpNJpbgW4V/FjN8u80rygVCk+JlEp+87Nw7e+a8=;
 b=w/RE6DQ9u0zgGAn7R+KSSSWCZ2iu3+rexOksJbUr1lv+XKBLP6bvnInUVi5pH3vAMgWbsWt87j2g9i/PhR1LD74MRiGEdL/Qb/67KS/uQ9PVO6ghsGeAlFCh3WMC4yjyx+UnuI0xCCtxT3BGWI24Ziy/4yvTKAqxRuq5vO+G6OI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV2PR12MB5966.namprd12.prod.outlook.com (2603:10b6:408:171::21)
 by DM6PR12MB4185.namprd12.prod.outlook.com (2603:10b6:5:216::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.21; Tue, 24 Dec
 2024 01:14:27 +0000
Received: from LV2PR12MB5966.namprd12.prod.outlook.com
 ([fe80::7c1b:5fa1:7929:fd81]) by LV2PR12MB5966.namprd12.prod.outlook.com
 ([fe80::7c1b:5fa1:7929:fd81%5]) with mapi id 15.20.8272.013; Tue, 24 Dec 2024
 01:14:27 +0000
Message-ID: <3a616457-7f8e-4add-a363-58dea914e3da@amd.com>
Date: Tue, 24 Dec 2024 06:44:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2.2] x86/amd_node, platform/x86/amd/hsmp: Have HSMP use
 SMN through AMD_NODE
To: Yazen Ghannam <yazen.ghannam@amd.com>, Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, tony.luck@intel.com, mario.limonciello@amd.com,
 bhelgaas@google.com, jdelvare@suse.com, linux@roeck-us.net,
 clemens@ladisch.de, Shyam-sundar.S-k@amd.com, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, naveenkrishna.chatradhi@amd.com,
 linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-hwmon@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
References: <20241212172711.1944927-1-yazen.ghannam@amd.com>
 <20241213152206.385573-1-yazen.ghannam@amd.com>
 <20241214100507.GAZ11YU_9llLRq5AoD@fat_crate.local>
 <20241216183338.GA542682@yaz-khff2.amd.com>
Content-Language: en-US
From: Suma Hegde <Suma.Hegde@amd.com>
In-Reply-To: <20241216183338.GA542682@yaz-khff2.amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0222.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::12) To LV2PR12MB5966.namprd12.prod.outlook.com
 (2603:10b6:408:171::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5966:EE_|DM6PR12MB4185:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a5c55de-30da-4695-5770-08dd23b84fa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OW5RaXZWNTdySm82bHNlTEk3ZVcwd0h1SENNL1hEa2lTbXdsZlFlbThkTFps?=
 =?utf-8?B?YnZ1MFRKWlk5ODZMVXVkYTJtY3FYaFphdk5jWXVadFNJVmZjVDBuZWRVVFkv?=
 =?utf-8?B?ZCtOcmlGMXJVNWJ1Yk4yVVFpL0JhZTZjZldPVmkybUhuNmN0N0FDNnBxeHpH?=
 =?utf-8?B?VUR4YWdiMkhnRjBqVzg4N0NRdTRBMzRrTFp3Q3BPOUp0OXZRcHVQQzdqNE5t?=
 =?utf-8?B?R2V0c1NMM2xGajFuNENlNGJEekxkVnl1OW5aemxsTE5ITFAzc0YwYUJUd1pm?=
 =?utf-8?B?NC9sQ2c3dGUxMGUxMW1IVngyOG9rRTVETVJIRG9sNzhTOW9UcTgwbzl4cTJS?=
 =?utf-8?B?ZXRDUGJDWCtIOERwQWdiRG5maHFkeFNqU2VvT0FwSnhuenhCd0JCeUQ0ZW5t?=
 =?utf-8?B?TU03bHZWZkNKY29jeGJOKy96eW9TRGpteVE0L1UxeEZlV3dwSWZycmlCblg3?=
 =?utf-8?B?UCtEeXB4Q1FndklPcmIvWGRsS1BwTk4xekNOVVY5MmgyRXZKZlVoRUpPT0M1?=
 =?utf-8?B?d3RBQ1hjY2ZrbXp5MkIrMld5Z1l0Ty9OK09wd3Z4SWJvUkJOU29mdGhsYVQ5?=
 =?utf-8?B?OEl6S2t0SkxaQ3lDYTdsUVltRTFTbWIxbFU4Wkx3c1ZxSXR6Q3U3dXJ4RE5r?=
 =?utf-8?B?VCtBTEFuejZoamlkcnBrQ2NCT0VjRmtJa21zRE90NXpmVEtZM09nM0J1akp1?=
 =?utf-8?B?Y2szZGF0WVJYWnoyaVorc2N4K2VpckxyYjFBNmJhTnoyM011N2pwQnFxb3Ba?=
 =?utf-8?B?TWtyaHI0bXRycUF0NzE3OG45OGZXK01OUkIreTdMa3ZGYlVTOTJmY2lpTmx3?=
 =?utf-8?B?R1JwNUpsbmpIbFozVGFIV25uMDNtS0t0c1R1TW1PczRhYmJBdjBnQ2prdXkr?=
 =?utf-8?B?Kzh6UHpkeVVnYzdCNjA0MExOYUhJU0ROMHJDVzBCM3VQNkduTi9yUDFsTnl0?=
 =?utf-8?B?Y0ZlcThVVThKUjRGZFpDV0duNjF2RE16YWF1Y2w4VU0vdWtxNDd6Y1RjYzM4?=
 =?utf-8?B?Ri9HVTBpaWhNNFBJdnFWaXFWOUwrR2k0YVJJWmg4UDhOTnJ0Y1JpQS80NFBl?=
 =?utf-8?B?Y3NXc1FQanFaN3Z2WVVOMkZ3L0RBanQ3UlJqNHo2dndaSzNSYzAzMWZTWU1q?=
 =?utf-8?B?SDZHd1FnblVrVytKdTdwbkFmQWczbitEa241K3NUSFREaVZNMEd5b0Y4KzRM?=
 =?utf-8?B?a0h3OXhhRVVJSmk2a3NyVUg4dzdYak1qVnBSVUl1K0lha2l6aVBSNnZlbzNS?=
 =?utf-8?B?Q0FkbG1jQlZieWkzMXlGRG1nQ24vck0vMm9PSmExaWZxUEF5WVVGam9vbG5u?=
 =?utf-8?B?KzYxelF3WDQvb3dmaW1yYTdxSVVlQVFKYTY1YTRrc1ZTeUtnTTdTNDVtQTZh?=
 =?utf-8?B?N0VBYWpVVHpwMG5ZWEdKbGVKTUNtSDRkRDRGMTROVnJteHhRWGdsWTc3QjBP?=
 =?utf-8?B?Ty9uQnZ4RWFwM3BWYlNDT2pmWXMvK0FrWUFBSElrQitEdGJvUUxaSnBzSGxV?=
 =?utf-8?B?dzZlVkR1ZnNZU0w5d0pIdjBVa3lreXArQlBkZC9POW9sSURCby9xWnFESnFM?=
 =?utf-8?B?Q3hEVmlqajllbFNCblI5OUd4Q3FjayttT1ZEUzFwT3orK3NyeVRjMllsdnVa?=
 =?utf-8?B?UE9QWHdJL1VxakhVOHMzbmFCMDJRdVlKamVuQXpFVjd2M0JITHg0ZWZaUzhO?=
 =?utf-8?B?M0FRY3lQZ3NjNGxqUURXb3lXMXl4SGIzNzNiMklET1dJWkNsVUZ6U0ZDVWJJ?=
 =?utf-8?B?VkFJZTFUVm9LV0tPajJ5ZEJnZzFpeld6TWFkc3NxbE1veTZFYzBBaUpWNURn?=
 =?utf-8?B?MDRObTFZTm1UZGRhM3UyVXNTcTU4ZXdaWkR3UDY5MXdSUzZ6WTBrOUE5bzBN?=
 =?utf-8?Q?2JnAwJxcy389z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5966.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a1pOWmZ0aDBTVUJ3R1BXRTBnblRqZlJULzZUWWJCMnNzYloralhtQk5RUlFT?=
 =?utf-8?B?TXBqSjdZTG1iZEdwU1ZJdFhTTElWaERGc2h5T1B2Zzdia3M3SDl2NURFNVR5?=
 =?utf-8?B?Zm9oWFJTUU1TUk4xZ2dqSFdKR0t1MGZXWUx6WXB0U2JHd0JQUjkwdjBaRmhE?=
 =?utf-8?B?YThjUnY0U1Uwam9tN1YzOExvVTJqczdsb044Y0crbEhlb2dFMWdOUUNCQ2lR?=
 =?utf-8?B?Uno0UHIzOGk4VFRNaE05OHU0aE5VRS81Q1Vxc2FKMWJaNnY5d0VVZXQ4dmN2?=
 =?utf-8?B?WGQ0V0tIdktLSXlFdGNmVXJOaEpqUTlzWVdKQnZqbTd1eUQ3UDV6QTBwWllX?=
 =?utf-8?B?aGIySnR6U1FOWnNQcE0rYm4xNUh6c1hvN2pqOFVudzhuZDI5aXhOSk1kM1VR?=
 =?utf-8?B?WndpUkNyMmhrNzlYeUtFS0pkdUlQT3B2ZnV3dnhnNGtPWCt4MzJZTDBQRFFP?=
 =?utf-8?B?Q3N2VVpnUE4vSEllYzVwTHdMMDFpZ25mbWtneDhwMDBKVk1pbEhmQ3pRM2Ru?=
 =?utf-8?B?dllJTEpqV3V3aGN0NSt3YW5zUXZGbWhxWkxLQUtjZTBOR012dzdWZC9VUlIr?=
 =?utf-8?B?elhHOG1NRG52MHV6MU1RNDRNMmpra3JKeldmbXpqbWhOQ0hiNWlZRWxoZVgw?=
 =?utf-8?B?S0VNQ3hKcXpieTI3TTJyY2MydFh5bGdTaEFSMitsM3NuQ2pkYUlKZS9jcXV2?=
 =?utf-8?B?aHRjbnlsdXhOVzFXcFd5U3JPa1JaUGxGZitLVWhsRjZiTDlNbnZya2k2RU1V?=
 =?utf-8?B?REtxVDBuUTU3NkkwYnkwa09pWWZpa01VbzVBOXFhMFFYTnBDMmRuT1djVDgv?=
 =?utf-8?B?ampQTndTWFAxWTZIbk5TanlsNnRZRzcwY3BDNUJSMS93N0QzSXY0RUdIMEtu?=
 =?utf-8?B?WTdja3RHNEdLdldHKzVsU09hbzdpUFlKTUtVMWFiNEovNGYwdGE1b01FTFBD?=
 =?utf-8?B?dnNIb0tERVRZUjlCZGx3RXhVVk4vVFUybkt4TG0wNE5ac050QjNUS1dFN1Br?=
 =?utf-8?B?TktkK3gzVmkyN3JocTdSQWxNdWNRdkg3c1VZNFJsb0RSRnBhaFdIcDBidVhW?=
 =?utf-8?B?MkpKMFZIZzhLamZiUk44YTZaR2Job2ZWOEFlS1NMWlpJMWtNN09DQ0RuNFZ3?=
 =?utf-8?B?eURhbzVvaXVYK2VjOEZVZXI4QWRONzl5QWdUbXBDUXlyaGp2REZmeUgwQlV3?=
 =?utf-8?B?VHdWdzF0OXg3UWR2bm8xUzF3dzNTZ3ZvRFEzVkhhb04wVTJEczhFblU2VDRP?=
 =?utf-8?B?bVM1akVCaDhZTVBiZFA4akw4aWNEUVBLTXp4MmE2Y2hhNTQxS1lyL2plWEsy?=
 =?utf-8?B?a2ROcTRkVm85bUREMVZpbStTM2xBS05PcDBJQWRrVzNTWmFnMjhWOEE5TWw4?=
 =?utf-8?B?WkJHekQvOTF4elU0akdKd3JjUUplNzNSTFlaTjA1R1ZEUFFNOE5CeFdMWjMy?=
 =?utf-8?B?LzJhL2dQdm9VckhLRWpiT1E5SlpyaXN2cTFDVEtGalRHRTUvTHpNQ3lBd0ZH?=
 =?utf-8?B?WVE0SmJRZTYxQ0VZMDc5VU4vNVNLNzdmaXNuRUFhQ2hTNTlEUmFtLzBLcDZ6?=
 =?utf-8?B?Q0lGcG1Ya1hldThTemtlM3MvdWpMemt5dDhoQWpXR1g0K0NEaGJzUjBRVjg0?=
 =?utf-8?B?c0pwNVREVHlZMWlEcHJuQ3V2Zms3ZjZlM0lSVTV5Z29GZjRKL3l6cGludFo5?=
 =?utf-8?B?YmJmN283SkZzYXZGUitDbXg1TDN6MGFWM1JXY2NSWFRPUUV2V0Fmd2FPbXJI?=
 =?utf-8?B?QlpHYk0yRkRZQWZDMkRnUEdITGoyL2pBTldzZ0w1RC9YcGdORXhlekhqNkp3?=
 =?utf-8?B?ZjFqZm5YdjZ6N0diL3FCbmg2OGFnSm1ncGV3UkxJV3FMQWdLTWFnWXRrRHMr?=
 =?utf-8?B?YVVsbUN5U3J4dnFENU1mQVAzR2FvTjNWMVROYkNUd05TQ1k2M1dZQ094eDlX?=
 =?utf-8?B?RGJNaHQvbFRKZk4yc1U1Vk9hV2E5NjhZdVBhaW1FVkVpMzRjak01ZWQ3TDZ1?=
 =?utf-8?B?YTRaYy91UkpDVERRcitXSzkyREllcGFjMlNlR2pwYVYvM0JuZllNY3E1NHFh?=
 =?utf-8?B?VjBzRHJIYnY5MGo1b1hXS01lL3BGRG1xemYvcHBVbVhJZDI2K3ZrbGFJMDhD?=
 =?utf-8?Q?1DlddsKtfaicp8HwpqnxVBP8C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a5c55de-30da-4695-5770-08dd23b84fa6
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5966.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2024 01:14:27.8008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BVwckl5Az4E0E42gA4WqXy3DnKIutVHi5LFAHY0QwlGx7usfTuQ+m1ncrLz8RSmiMUf2ZxVFQO5MK78MXxZuvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4185

Hi Yazen,


On 12/17/2024 12:03 AM, Yazen Ghannam wrote:
> On Sat, Dec 14, 2024 at 11:05:07AM +0100, Borislav Petkov wrote:
>> On Fri, Dec 13, 2024 at 03:22:06PM +0000, Yazen Ghannam wrote:
>>> The HSMP interface is just an SMN interface with different offsets.
>>>
>>> Define an HSMP wrapper in the SMN code and have the HSMP platform driver
>>> use that rather than a local solution.
>>>
>>> Also, remove the "root" member from AMD_NB, since there are no more
>>> users of it.
>>>
>>> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
>>> ---
>>>
>>> Notes:
>>>      Link:
>>>      https://lore.kernel.org/20241212172711.1944927-1-yazen.ghannam@amd.com
>>>      
>>>      v2.1-v2.2:
>>>      * Include <linux/build_bug.h> for static_assert()
>>>      
>>>      v2->v2.1:
>>>      * Include static_assert() and comment for sysfs attributes.
>>>      
>>>      v1->v2:
>>>      * Rebase on recent HSMP rework.
>>>
>>>   arch/x86/include/asm/amd_nb.h         |  1 -
>>>   arch/x86/include/asm/amd_node.h       |  3 +++
>>>   arch/x86/kernel/amd_nb.c              |  1 -
>>>   arch/x86/kernel/amd_node.c            |  9 +++++++
>>>   drivers/platform/x86/amd/hsmp/Kconfig |  2 +-
>>>   drivers/platform/x86/amd/hsmp/acpi.c  |  7 +++---
>>>   drivers/platform/x86/amd/hsmp/hsmp.c  |  1 -
>>>   drivers/platform/x86/amd/hsmp/hsmp.h  |  3 ---
>>>   drivers/platform/x86/amd/hsmp/plat.c  | 36 +++++++++------------------
>>>   9 files changed, 29 insertions(+), 34 deletions(-)
>> ld: drivers/platform/x86/amd/hsmp/plat.o: in function `amd_hsmp_pci_rdwr':
>> /home/amd/kernel/linux/drivers/platform/x86/amd/hsmp/plat.c:44: undefined reference to `amd_smn_hsmp_rdwr'
>> make[2]: *** [scripts/Makefile.vmlinux:77: vmlinux] Error 1
>> make[1]: *** [/home/amd/bpetkov/kernel/linux/Makefile:1225: vmlinux] Error 2
>> make[1]: *** Waiting for unfinished jobs....
>> make: *** [Makefile:251: __sub-make] Error 2
>>
>> Config attached.
>>
> I think the fix is this:
>
> diff --git a/drivers/platform/x86/amd/hsmp/Kconfig b/drivers/platform/x86/amd/hsmp/Kconfig
> index d6f7a62d55b5..fc90ef11a8ad 100644
> --- a/drivers/platform/x86/amd/hsmp/Kconfig
> +++ b/drivers/platform/x86/amd/hsmp/Kconfig
> @@ -7,7 +7,6 @@ config AMD_HSMP
>   	tristate
>   
>   menu "AMD HSMP Driver"
> -	depends on AMD_NODE || COMPILE_TEST
>   
>   config AMD_HSMP_ACPI
>   	tristate "AMD HSMP ACPI device driver"
> @@ -29,6 +28,7 @@ config AMD_HSMP_ACPI
>   
>   config AMD_HSMP_PLAT
>   	tristate "AMD HSMP platform device driver"
> +	depends on AMD_NODE
>   	select AMD_HSMP
>   	help
>   	  Host System Management Port (HSMP) interface is a mailbox interface
>
> With all the recent rework, only AMD_HSMP_PLAT has a hard dependency on
> AMD_NODE due to needing the SMN register access interface.
>
> Various HSMP files still pull in <asm/amd_node.h>, but they just need
> defines and an inline function.
>
> It seems COMPILE_TEST is not needed, since this change allows
> AMD_HSMP_ACPI to build without AMD_NODE which seems like the intent.

COMPILE_TEST was added to provide build coverage to HSMP based on Ilpo's 
suggestion.

We can probably add #ifdef CONFIG_AMD_NODE and #else as below to fix 
this instead of removing COMPILE_TEST?

#ifdef CONFIG_AMD_NODE
/* Should only be used by the HSMP driver. */
int __must_check amd_smn_hsmp_rdwr(u16 node, u32 address, u32 *value, 
bool write);
#else
static int amd_smn_hsmp_rdwr(u16 node, u32 address, u32 *value, bool write);
{
         return 0;
}

#endif

May be Ilpo can comment more.

>
> Thoughts from Platform/HSMP folks? I can send another revision if this
> is okay.
>
> Thanks,
> Yazen

Thanks and Regards,

Suma


