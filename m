Return-Path: <linux-pci+bounces-35492-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C063B44B84
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 04:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 978C0188F0E8
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 02:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811AA2163B2;
	Fri,  5 Sep 2025 02:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tGi3mqHz"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FF71F239B
	for <linux-pci@vger.kernel.org>; Fri,  5 Sep 2025 02:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757038487; cv=fail; b=DdZANHUQaNIf5wUXcphjduq1Pzj3MNtXhow7s0DDVoApIKvKWTyLBJ/1e6zT+0lvFkO5OqSUU1mp6waYt0NG5yJ99C9FqnZf4pAhJuIaX6qCgZe2ZkwS76ej56jjauDdDZ1CErtHZq/RfkFvISB+x5UA6/QyrCKf7qkKpdNpaCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757038487; c=relaxed/simple;
	bh=R5AmJaim5UtqGTIm73rPwAPWuZCdZHxpk38BdRh1odQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UaLcfrxcLxEXmA3KJVUlDCAqd4oO176Fq1ksJC9M2CpHS2R0YhEzxKI+D8/pFWF/Znx0YToAf9FcXuPj26ZYvfP7WFFKC+zhPpFAJ9oUh2flI9ZrwGE3qhenEUxn90m/BMvUBCBQvwLBkqKDJBJhLneSFk5rD/itHoJs/hZ0dWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tGi3mqHz; arc=fail smtp.client-ip=40.107.220.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VTlLnXjo0q+Ma2GThVQ+haOy5Lpbghmvp48K+t45u49G1WqHHEvsr7MKzDHaF0kYWZ5AEVZJlQnaSmKQZKNQuYVU/D1kRvFYhM1UOX9a/i+oMiERPC1eteZ8mstms6w2yVGVxcKFOoYFK5DHmzNBsGpBH/U5u9jLz5e5IYsaT2dAnhxwA6PRrGTHIxwaqhj1GPkMfseJecNH1+RUr/gYVEUNjgsSPAjBgiMtJAkPHqKSjC8+mDm5jlknjhROnyUwWZQhZfnVkPTXzrVIaXwf1lJS+IEcFv5RofFtgqd6NA0z7itWTjAuEx3llM3o4+x0LEwBcXjYthlpBi7k9YRmqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9AlPctCQmAj7S0ExyqN8d+OLc96112cOOaPVAxpJY94=;
 b=o50PkbmZGVYnCCE9aUqvnVWVuzrQgPmN+nsNgSCtBqSPpUF9Lg3DBTMBxgjGlzGW5+ebnD7pxAKuZI1LnRoY0E3FH0ePdB8Lj7BAuJ3HFI9peYWhmxgvDufOs4YRMjjVUlxA4IGoDs9vkp1QOZl2mfTJ3zavaF6fhjHKUGzEFax7HmY6OET1R1aTVkNeCdFT8Z4LajV9jMRWP4muSaLAv8aJa0zW3lNHZiwlz6q2o5y0TW4ZqvVU0H+F7DBxKw2b32kPtH/7YLGHlZVEtKNB1W/R21t2njhcKuyCbOZ7/8tkYqZFVhnljmwAYDUeahlVyp4W8d3jkF6Fj7irb9SGMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9AlPctCQmAj7S0ExyqN8d+OLc96112cOOaPVAxpJY94=;
 b=tGi3mqHzv2rw4isdcQLXy3p+lBHkFnp9FZ7E43dsBtAMjYez23xKM0Jfm1gszOdCFcSVPFKLJ/99nIkfcfAqfDyVbCkuxT9nKLUByMgp1zmaety5EQXjwMqxaQ42E3awbEHkUzhPV9pL+YFwIikoeDf2h4oHokFvLfMtszTjIUI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by DM6PR12MB4249.namprd12.prod.outlook.com (2603:10b6:5:223::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Fri, 5 Sep
 2025 02:14:43 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.9094.018; Fri, 5 Sep 2025
 02:14:43 +0000
Message-ID: <14144093-c3e3-49a1-96d3-acd527cfe32a@amd.com>
Date: Fri, 5 Sep 2025 12:14:35 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v5 07/10] PCI/IDE: Add IDE establishment helpers
To: dan.j.williams@intel.com, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org
Cc: yilun.xu@linux.intel.com, aneesh.kumar@kernel.org,
 gregkh@linuxfoundation.org, Bjorn Helgaas <bhelgaas@google.com>,
 Lukas Wunner <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>
References: <20250827035126.1356683-1-dan.j.williams@intel.com>
 <20250827035126.1356683-8-dan.j.williams@intel.com>
 <eeca3820-01dd-4abc-a437-cf46dc718ab6@amd.com>
 <6608a45f-b789-48c9-9418-5d6c2956975f@amd.com>
 <68ba3f725b284_75e3100a5@dwillia2-mobl4.notmuch>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <68ba3f725b284_75e3100a5@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGAP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::32)
 To CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|DM6PR12MB4249:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d0445d8-8244-4b74-44a1-08ddec21f9f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bUtET3RaamtGd0dGUGpOdy93Nnc1ZXljNkxHZkhiRGtVcXFkR0JIL1ZUbWtv?=
 =?utf-8?B?Z1lqdFdqdmpkc3hZdGVUSXVnbWtLWm5Rd293U3dhZUEveTE5NG9SQms4OUd4?=
 =?utf-8?B?T25SaWVZVTNqckpBTG0vVi9wWDJoUDdKNVJRNXFkTWtyTGRVZTBQV1YrMkc2?=
 =?utf-8?B?UjZ6c1BEMkQyMlg3REFFWmdEUzRUUFd0ZThrdGJzVDRJdUgwSDlEZXd6YXk1?=
 =?utf-8?B?UUJxcC9hWk51d1ZUcEVVZHBaYk1nNTU0cTJxVHJaTkw0elFIcnBKdzh1STRC?=
 =?utf-8?B?d00wWVpIRytzU3pEb1ZZU0NDeHNoNklCc291NXdmUmEwcHpHQnBhUlVCMS83?=
 =?utf-8?B?c2RweWVTQW9BVmpKdXNZNDdqRDVOYktpbWQvMThYSElUVHhUOEx4NVpUTTY3?=
 =?utf-8?B?bzI2aUQvbFNVdDhad0RTbEpHMXdCc2I0SnhWbUlsZW1oT1lUUkx1ZnVOcWRY?=
 =?utf-8?B?TGo0c1NlVng2SS9LZklQZVc1a3dtRWdOSW03aWJtNDJqSDFSWWZ1RzczcTM1?=
 =?utf-8?B?RXhCdlA5dDRaaS95NXdnK0JHKzBWdjNzQlRHUVBPckNaOUhCd25heGYyMTdC?=
 =?utf-8?B?amVsZlg2dUE2cVFDMmFLeFBzVnVHcHNZc3BpVk9NNzllUjd0bmFHVjZHVzRj?=
 =?utf-8?B?UWl6UzJpWlcrNFBVZE4zOHlsODlHeW1Cc2RLYlFuTTZUS1lEQmpZWFVJekEw?=
 =?utf-8?B?WGFsZ2tBM2MyT0dmNVY3c3dhQXhCcm4zNGh5SklyRDRmenlDaXJlNUdoZlJp?=
 =?utf-8?B?Ym82K1I4YmtnN2tWdFVMZzNxRjJaaVNOazlpNFhhTmR0MjZPQjk5eWo4bk1T?=
 =?utf-8?B?V1BKcXlxa0taUXRvM2JYYXNJQ3h6bDg5ZEZFU0QrNGpobHVHRHBSNGdLZzNp?=
 =?utf-8?B?N3VHOEE1VTJ1NlZYelJpZG1mcnd6bnBGUGhLcnp2VVdJNVZ1bUV2Ny9oakpX?=
 =?utf-8?B?TW9IdXh6bFpwRCtTRlBTTEVXRit0OFZxU0N6em5FUGtBcjZiZEdhR0NUa0h2?=
 =?utf-8?B?czIzVTkxZkcwSitnTDNSc3ZmS2N3WGp1TGljTnVveDhFa2JKckh3MmFwSzlr?=
 =?utf-8?B?cGo2ZGNSQUZ4endUQk9rYkhtOC9mSnVMcHR1b2tJL2syVENNU253M3BZeGM3?=
 =?utf-8?B?MG5IQ2FsR044MEVvVnEvZXBDdmdlc1daY1AzVWhvQWEvUmJZdXEvTFJkdkhZ?=
 =?utf-8?B?T0ttc0pOOHMrM1RlNUpxbTNrNElMUytpeEJMcU1IUndUcUdqZmFwSEFQU1M1?=
 =?utf-8?B?NituNFgzL1hPbGxXNlo2SkNKQ1AvZ1VUUS9XVncybW82ZWsyMlNPTWplbjVN?=
 =?utf-8?B?cy9GYjliZUE1OCtLc3BkNXlGUjVFRm4vMjdScmxSZEV2a01XT1NJTGhabjIv?=
 =?utf-8?B?RlZqYVZGU1ZmQk1zM1piUG4vd3NhcThDZ0NqeHl0N1RTSVAzMGdHZ3NVQTA1?=
 =?utf-8?B?ak9VQVR4SHFYWUs0YnY0RE9vNEVkK3BRYlpTelAyZ0Q1ZWRxeTFXOW1odWJo?=
 =?utf-8?B?YWhVR0dxU0lUMEtDdHFDV1Y0ZExOaHUvSXNIT2lSVUtlenR0U2pkZk91amFW?=
 =?utf-8?B?UlpmWlBUWkh6cDVVWlp1TTZ0a2JhVEpabjRPNXJneVNibGRhQzRjTG4wMDAz?=
 =?utf-8?B?M1RkZ29BOWthNy9tNDFmVlY2Y0VwTER2S0owVjBDOEhzQi9INXpLSFVjTnpV?=
 =?utf-8?B?OEdNcmhKQzRGYTlwNTMwZGxUdi9uZ0hjMHBYREdzM1lPR3paUXRkSWZHU01q?=
 =?utf-8?B?ZHFKWHlndENEZEplbUJIa0RxaTR1L0dlNnZGdkpsYzBUSkdsSWplMDN4L3E3?=
 =?utf-8?Q?DH4lSyuThf6dy+BHs7l6TD8UqrYxnhyKqqt08=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YitJY3NjMCtZaGZMcHRleGUxUGVnN1BsMVEybWIrSDJXODdnYTNLaFFVbFJy?=
 =?utf-8?B?NEFGUUF2MjZmeG1KNXJYUFF2OXk1SHUyOEYzRkF5UVRjeW5zTVY4YTdZKzJR?=
 =?utf-8?B?Q0k4MVdBM0QrRXVGT3BDOUljbjJFT1VWY0U1SjlQZzBHYWVRR3RWTEQ1bXZJ?=
 =?utf-8?B?K0RIKzBhTHFSUEY1c1o0WlpQbnp3Wm5sRjhpWTI4T040eWYxRVlQZ0tWUVpm?=
 =?utf-8?B?SFhHSUY4TEROekxzUHJsaWxyYmZuRmNOampYUG4wME90VjZKUElOcnRMaTRS?=
 =?utf-8?B?OEtDQWtkMlN6OFBmRWxwdk4zUEpOQk1TeG94eFJINit0dUplN2lpc1BuZzhO?=
 =?utf-8?B?MFVURlN0S0l4SkU1YlEzcm9UQytjdERaQjIxV0trazVsMGZ2MXlSOGFHWGU1?=
 =?utf-8?B?TDhmQVJpZ21Mak92QXA3WUoyYnRjYW9vUG1lNkFrN2VRajlnZUlMemllWnp0?=
 =?utf-8?B?YnZ2U0gvbDVHekFONlBwLzE4blZhYnVQK2ZtYWRMVEhseVJEdnlHTzQrVmxE?=
 =?utf-8?B?ZDliM0hSVnlFUmF2NU9ZWWdudTBsODJTU2pSQmtEWHZSa29RWWVDNmVybzdk?=
 =?utf-8?B?bElVdnM1VGxKUUl0ZFhOejFRS2E5dlp0YnRSbW96NzRWVUJhNUtwZ2hScnpC?=
 =?utf-8?B?TlBOTWdMZzk1bDh5VmovSWc4MER5NkpnT2IzbnJLbFd3V3Buc0JPY0pEWVRD?=
 =?utf-8?B?R2VuV0N6OW9yNWhJTXVsY2ZERFh2TkVMaUdUQUZ3R2ROWGVBbGFJN3ZtTGJo?=
 =?utf-8?B?Z3lBYlkzT0V2cWNMRGxVMjVneVNxUjl5d3p6MmV5U0dTaTdkYlBmL0hYR1po?=
 =?utf-8?B?NWtBMTV5a3IvQXB0M242M3cyZWRHR1owOWpnT1JPT0dKOW54Z3oyQ2lxa1Fx?=
 =?utf-8?B?R1dDVmJxQjJwc2xvc25pVEhuQnpiTi9lZ0Nrc09yTkhWWXF4dUoyeGM0dGM2?=
 =?utf-8?B?RERTZG95Z1IzOG1DOFJRbUswTjJtZzloQ0RLVm9FWjFRTHFnWmh0Sm5CU01K?=
 =?utf-8?B?cDhFVXVDUDI4THlyaVgrVHErMDdWRmdpdmZkZ2Z4V2diSm45VUxYbXMzSzE1?=
 =?utf-8?B?TzRmWGZoSDlHZHVXNEI5bXZlaHQySkZla3UzZXVjQVExV2luOEo3VEJHZVdV?=
 =?utf-8?B?RDhkY05Ib2FXYSswRVJYcDN4N3pPdTNzTElKbTFReTdBcTBWNUJWS0Q0Vmgv?=
 =?utf-8?B?R0RMa21CMXZLQVptZzVuTEVnN2ROd3p3MWxKR1B0YkZXajkwcmlOVk9Sc2Ns?=
 =?utf-8?B?Nnh3V1g5V3A0Y1RCUHRJWkVleHNvOGVpamlHcnFvblhUS1ZDSVhEa0tMa2pt?=
 =?utf-8?B?VEk2MEpuS1UyQTE3Z1ZHeDQwZzBzR3g5YU5VMnRUdnNoM05KVk1CTElrNlFy?=
 =?utf-8?B?YTJqTi9pUnF1RHlaL3NOVmcxa1B0SGlaUmkrVWRWWkpVK0lZQ2Q0VFNJUHhx?=
 =?utf-8?B?ODVUdFhGRzlTdkZ6d2xadHRsOUszeFc0OVVrcG1DUmtXaXpyWlFucVFIRGJl?=
 =?utf-8?B?amh4dEJYNFBEeDNnTGl2V29YWmRwN2FmTzVrVlhneWw3UnphMVZkalV0NDBv?=
 =?utf-8?B?djROeGplMGlmTlYyQ3Qrd1NUck1QNTkveWMrMUYraGV6bWRWbEM4U0RGM1lJ?=
 =?utf-8?B?ZjZkc0hqNFBPZ3lVTTl2enZpaTVNaU5uc3JZWFBXaHpSM1BTYUlmTVVuUFVh?=
 =?utf-8?B?bDZMcTRySC9UV1ZFZ2prWjVPNnBuZUlkVnE2NlVFaTV0UlVzZlhrTmJNMEFB?=
 =?utf-8?B?SnpmeXd4V2E0MVFwQzhpN3EzNjhiUFhTSmRFK3BnUzd5SkJONU9yZkQ2T3hD?=
 =?utf-8?B?KzFyMTFhZ3gyZ1VST3AwUFRWbE4wYUMrbmI1RDgyVURWMzU1OGJ2bHI5RC81?=
 =?utf-8?B?UXJZOVQ5WEM2RHF0YUpEc1lSK3JVUW9LK016YVp0WTZrejVHTEl5VENIL1ZD?=
 =?utf-8?B?NUw4UzFkaVZLbUgvRGlzMXJjeG5QUE8wN2JJVlhjR0VSNWt3c1NSN2VGL0dj?=
 =?utf-8?B?TnJZY1czdkpBKytNNHB2dVNLZHYzREFDeTl6akNhaHROaCtqWXBTZUpGMURo?=
 =?utf-8?B?OWxmWnlYZ3JkY053a1BjSWFXZkNUMlhVb3RNNE9qMTJzZjlPaDlwOHhEenF1?=
 =?utf-8?Q?hNpZ79bJxeOt+xv3NOL7Qt3Iw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d0445d8-8244-4b74-44a1-08ddec21f9f2
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 02:14:42.9822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PeSATYztPlF92WUCCMgIpRzGW/kqsEMqL3eMK3e4eSs1gJ1HfPuckzFfAYIf5wypvST3R8gHkrtmgsL5tC+arw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4249



On 5/9/25 11:40, dan.j.williams@intel.com wrote:
> Alexey Kardashevskiy wrote:
> [..]
>>>> +/**
>>>> + * pci_ide_stream_enable() - enable a Selective IDE Stream
>>>> + * @pdev: PCIe device object for either a Root Port or Endpoint Partner Port
>>>> + * @ide: registered and setup IDE settings descriptor
>>>> + *
>>>> + * Activate the stream by writing to the Selective IDE Stream Control
>>>> + * Register.
>>>> + *
>>>> + * Return: 0 if the stream successfully entered the "secure" state, and -ENXIO
>>>> + * otherwise.
>>>> + *
>>>> + * Note that the state may go "insecure" at any point after returning 0, but
>>>> + * those events are equivalent to a "link down" event and handled via
>>>> + * asynchronous error reporting.
>>>> + */
>>>> +int pci_ide_stream_enable(struct pci_dev *pdev, struct pci_ide *ide)
>>>> +{
>>>> +    struct pci_ide_partner *settings = pci_ide_to_settings(pdev, ide);
>>>> +    int pos;
>>>> +    u32 val;
>>>> +
>>>> +    if (!settings)
>>>> +        return -ENXIO;
>>>> +
>>>> +    pos = sel_ide_offset(pdev, settings);
>>>> +
>>>> +    set_ide_sel_ctl(pdev, ide, pos, true);
>>>> +
>>>> +    pci_read_config_dword(pdev, pos + PCI_IDE_SEL_STS, &val);
>>>> +    if (FIELD_GET(PCI_IDE_SEL_STS_STATE, val) !=
>>>> +        PCI_IDE_SEL_STS_STATE_SECURE) {
>>>> +        set_ide_sel_ctl(pdev, ide, pos, false);
>>
>>
>> Ah this is an actual problem, this is not right. The PCIe r6.1 spec says:
>>
>> "It is permitted, but strongly not recommended, to Set the Enable bit in the IDE Extended Capability
>> entry for a Stream prior to the completion of key programming for that Stream".
> 
> This ordering is controlled by the TSM driver though...

yes so pci_ide_stream_enable() should just do what it was asked - enable the bit, the PCIe spec says the stream does not have to go to the secure state right away.


>> And I have a device like that where the links goes secure after the last
>> key is SET_GO. So it is okay to return an error here but not ok to clear
>> the Enabled bit.
> 
> ...can you not simply wait to call pci_ide_stream_enable() until after the
> SET_GO?
Nope, if they keys are programmed without the enabled bit set, the stream never goes secure on this device.

The way to think about it (an AMD hw engineer told me): devices do not have extra memory to store all these keys before deciding which stream they are for, they really (really) want to write the keys to the PHYs (or whatever that hardware piece is called) as they come. And after the device reset, say, both link stream #0 and selective stream #0 have the same streamid=0.

Now, the devices need to know which stream it is - link or selective. One way is: enable a stream beforehand and then the device will store keys in that streams's slot. The other way is: wait till SET_GO but before that every stream on the device needs an unique stream id assigned to it.

I even have this in my tree (to fight another device):

https://github.com/AMDESE/linux-kvm/commit/ddd1f401665a4f0b6036330eea6662aec566986b

> Are you saying the problem is that the shutdown path needs to do the
> reverse SET_STOP before disabling the stream?

Nah, I did not get that far. Thanks,

>> Was it "Do or do not, there is no try for pci_ide_stream_enable() (Bjorn)" in the changelog? Not very descriptive :-/ Thanks,
> 
> I understand he was taking issue with the comment, but this practical issue
> is much more serious. I will push error detection and cleanup out of this
> helper, and make it return void.
> 
> Thanks for the hardware testing!


-- 
Alexey


