Return-Path: <linux-pci+bounces-43490-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB551CD4BCE
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 06:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C8EB3006AA9
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 05:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877A930275F;
	Mon, 22 Dec 2025 05:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1EZXjqEv"
X-Original-To: linux-pci@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010007.outbound.protection.outlook.com [52.101.85.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8570C35975
	for <linux-pci@vger.kernel.org>; Mon, 22 Dec 2025 05:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766382779; cv=fail; b=fnCiZyrFvzTgHoaBzq+O05+/4pyZwt6P9h3ZyjzwPTnvkJiwYXa+tOF06ECLR8bvuCG9pizI4nDxaN0MIsM448u9Hjgt7nhTFuXgA2yadADVrJPaiOhwSK6IATIPMokzdf93NBJpDn4UaHD2KXxv3KDraX8q6GiylvUc4SsJ68w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766382779; c=relaxed/simple;
	bh=dgMOYktaZP4ep8i4g4gfXmXbLYGICIaf+iIHF+nvh/4=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CD+wMCdJ6TcuCy9XeooOizRsbS1jFZRm+P5TkGV/LnGs1kFqcXnFgcrj0Z0RPya718dgzp0H/jwRIokJA2yx70goVr9+uvlPrNgovw8fpTlRotBEQt2qRBsZb6p/QNM3jY6+qdgY1+NP/wHXWJVIVFFmNLelO7Qvz40Zw0Ka+ic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1EZXjqEv; arc=fail smtp.client-ip=52.101.85.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qf2+i3rmbzCWBpda0QYqlVDdK2dMgSi5/bIWg12/yuUYNUAhdp4xVqajHAFZ/G9JXZB8j7bXSTRdLVZ7hQf6Ecbg6U9s9G1KcV3FPHcXNGZGaIU53vYObJvmTn88pkMDUIaN+3QJqDOupmmP3IzsmeBfky+Z2nXIBAD18xVN2y1R9VD/V2JoLTFgJt9eFuN4TZidFEaTSl09ekqF4FuMM+5zwz+cak26frcF6Y+Q0J2B2TOwaZerWHjWP5zzDUZnNIZUNC6lipy+g1EHCfmHyhTelAZFe6DV+xFb3mKUmmUg7KeK8TrDW6Q2aV9fXyPneaCL5bsdYWewg20H/Er69g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UzZDhaUlwF/+aB/yhkaYaeIsi5l1flhL74Aoe4BBSkw=;
 b=g+yJje1SJLOz2XPhkGueQhlBJ8WHOfk75sSz+acLz+ABRIBkUOXUwAM9a4CLZUqf4N0zOtXATWNGZUSx0wAwDFr+jyYDM/cVym6l5KJvEwM8MGrILken/qGuXOzdvu2pAFMnAZWCEs4z+M8Ml8ygLHhtRTiyaZVRKZkI+65bI+SQ9tzxzbmA+5LaQwJAZuNxXCD1GiBHFpfHUKfakMlG6UE3CmB0xoGNbNojM3myA7UHbjz63f3nkG1NoFT/xzD2+26zFLikTpOmgZUTTCeA3Hsk7dsUXBpKS3duh2rtuYlws7zf2GlBAcg3FjikBfPMDkDmHGf7nDMbOXTe0X7FtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UzZDhaUlwF/+aB/yhkaYaeIsi5l1flhL74Aoe4BBSkw=;
 b=1EZXjqEvqW8I9ZQNHXEgELjmMk+Sevylwx6HYT5BmGbg9sh7wxzwKPvZPCkWJ+iBugBA+I3bMWr7CmYRDuMrsZjpqZb3+lQ68i/CVfjW5FmoWh+3vmXqPoeVn5yPMje+UOJYgaPAeI9Rj5XYQ7qIiXXoqkg+oG3vlSGuCxXi/GE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by DS0PR12MB9347.namprd12.prod.outlook.com (2603:10b6:8:193::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Mon, 22 Dec
 2025 05:52:55 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::1e6b:ca8b:7715:6fee]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::1e6b:ca8b:7715:6fee%4]) with mapi id 15.20.9434.009; Mon, 22 Dec 2025
 05:52:55 +0000
Message-ID: <29ee93a3-02ee-4747-a75f-109911f8b99b@amd.com>
Date: Mon, 22 Dec 2025 16:52:50 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH pciutils] ls-ecaps: Add XT and TEE-Limited support
 reporting
From: Alexey Kardashevskiy <aik@amd.com>
To: linux-pci@vger.kernel.org
Cc: =?UTF-8?Q?Martin_Mare=C5=A1?= <mj@ucw.cz>
References: <20251023071101.578312-1-aik@amd.com>
 <d8ea14c0-857e-4e83-9440-cf590e8b2b4b@amd.com>
Content-Language: en-US
In-Reply-To: <d8ea14c0-857e-4e83-9440-cf590e8b2b4b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SYCP282CA0012.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:80::24) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|DS0PR12MB9347:EE_
X-MS-Office365-Filtering-Correlation-Id: e04e61b8-639f-4ec5-d05c-08de411e59fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VDhJRjV2clZMTmRkNVg1b0RUNmhyaFF3N2gydFdZRUhQUmp5N3NVRnFaMjlz?=
 =?utf-8?B?V1A0Q0V2KzI4d1FHVTFBR1AzZk1sWHNDeGJtdEhua1JtZjFlRERWK3hVQTBU?=
 =?utf-8?B?NTNPNWEwdHozb0d0S2NaM0hNOW1CRlE4aklzZE1iaVNqR2NVUGNNY2E0UDRV?=
 =?utf-8?B?MEZkSE9CaVVKS21UVERkcHFxYlpNNFdLT1VDQ0xlcmZPYzBNQWpWeGo3bVRW?=
 =?utf-8?B?YVNVc29xc3dRYzlXRDNwcGd2MlZPWjdpemhKWWpmMVU1M0VRSXo3RzJVSW0w?=
 =?utf-8?B?c0RVVEdHRnd2T2tTQTNPM3BuQ3JyQTZNNXdnbVJxMkhsakxKOEV3VHlva3NL?=
 =?utf-8?B?ZGc0VHg5RE5zbytvZGxFZm9uMkF2VUROTlF6UldiZit4bDNUTUlZL1hOc0pW?=
 =?utf-8?B?NnpFSmRSRkY4N1M3cEZrUXM0M0puV1E5SWhHV0xSTmp6eElmY0xyaXNSdlY4?=
 =?utf-8?B?R1FTMnVYQkhYVitUS3Q4NGIrNWhZK2VSSG0zSDZQa05jRWtieXo4M0RZa0xi?=
 =?utf-8?B?TlRNWHZwbjl1ZWxreEtwSmUzbEFicGU2OXZDa0pZZnFGL3d0alJjSkdPS1Jo?=
 =?utf-8?B?RW9rNlYzRFcwUzJHdHFCeTVPcGE5ME9HeEJIeUh2R29sLzNrRHJkM1VmSUV3?=
 =?utf-8?B?QzNuTEliNTVVRkVaR1V5OHFhVEhvczF6RTE0NHBKK2lkemZ6Z0FpZXBnT2R3?=
 =?utf-8?B?czkwdkVrazJNRnFHNnZjVDA0b3hTKzMvbW5YbG44ZkNTa0hmQW01RWYwUkZM?=
 =?utf-8?B?WDRBZ3c4dWJNcXFZeENrZGlVWGp1K3J3OWt3Mnpla2gybFVVQk9mbWFyWXVL?=
 =?utf-8?B?b0MvbzdGdWdUTTNXWlNlT1BnWTc4ejVPbEk2NU1oemZMaWZiekJFekxoSS9z?=
 =?utf-8?B?TW1LSlhqOTBndjV4MDI4Mm1oSGF0bGVHQkZVSzJkZ3FlL1RMM2U5UTFLSUhJ?=
 =?utf-8?B?YVBlYmV4ZVo3WnR2Nkt4QjNEU1l4cXVaeDlVams4M2dXOFpwZ2hBa0pnTWF2?=
 =?utf-8?B?Y05WVVVjanlGMEpmRU9tUGY0YjJNMWpHaFZvYlRXcnlJS2ppZUFpUmJEbWpQ?=
 =?utf-8?B?Mm1DQ0pEc3VxaTlyNjJkNHZCVG9qZVRudlBHdjU2SHNadi90a29HcUdlSU5T?=
 =?utf-8?B?M2ZRdTUvK0ZDeStSRHVXVzRwbmZCKzRUVzRZdVFXUHhtRmtGSUxReWFMK3pK?=
 =?utf-8?B?UEM2b1JHV051YXJzQk1RZnV4bW1SVW5WWXJDY3d2em9NQ3hUS1ZkUFdTNG5q?=
 =?utf-8?B?U2lRS0pGY2Y3WEc0MnpGQ2xpbVdpdENBTEZXM0crWDlHUTUzdnpZMDdYL203?=
 =?utf-8?B?bWZBeDBoVkh6c1FubThsNnc2ZHFGT0dpK0cvTm1PV1F0ODUvV3h0NjBLaEN6?=
 =?utf-8?B?aVRvc2xuNk9MbUpQUWZpTGlzU1p2UHk1cHY3UVN2djE4a0NrZ1pzb295Ums2?=
 =?utf-8?B?K0pBUVQ3U2VKUDZlSXdhZ0NrZ0FRK1NKMVIrQ2VielQzMm9rdisySHM0N0FO?=
 =?utf-8?B?TS9wNnU3bHFtc21wQjVrZkQyT3Z3MUtFVm82S3dkRnQ5cmNPN003cFJ5UWNM?=
 =?utf-8?B?K1F0Q2w2dGZWakVyVXBsZ1IxeHVNSEdPYVlsVWRFbnN5VWprLzdjcnZMalhE?=
 =?utf-8?B?WC9JY2o2L3lDYmRNMUdoU3o0MGNIa09FUTBFN0JyemplMDAxYkVCWHkxakhD?=
 =?utf-8?B?K3RvT0xUYW9VZ0ZyalgwT1p5TElHVTNBV1o5TE1LaGx4MmhMUXFmUEFKM2xO?=
 =?utf-8?B?ajNwTm9za0NMU29mcDExZmM0dHNxNTRObGV6WnhiRVBRUEVnamlKR1pKa0Uw?=
 =?utf-8?B?TDlrdC81TVFGNEM0UnZtb0luK0pLWVJDcjZEU01vUWEvSG9aaUwvUDIwK3Yv?=
 =?utf-8?B?S2xxV0kvcDJacHR5QWM4NDBhc040dytnOVZoT3lMd0pHZ1EwL1orMmpvMllP?=
 =?utf-8?Q?nlsY2/UqxvOOGR5GULcwlO5RuVLyW3Ov?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NHFOYm1iMjVnNERuUFJ5WGRDWERKSDlCdERTZWM1YTAvaVpoaGhrMVlHWjB4?=
 =?utf-8?B?eDRmZ0JhRmxqL0d6UWREc2hCVWlJa21scmxnWWswTVl6QmlFV2Y3NGxyWGJK?=
 =?utf-8?B?SmoyN084Mkk5QVhwRnBiVEVpdER0L05FN29kd3kvcUVPd1M1SnN2cmRnUnJT?=
 =?utf-8?B?b1piZnVoSzlTMENRaWhrK0ZuOUYvWTNrdWViR29yRWVEZUJ5QStJeHE3Ulh4?=
 =?utf-8?B?VXBSelFWZW9hc3FrTmwweGJ3NkZhbjB4RXJqMWZkeTRHWEZHTjNoQ2RDeStv?=
 =?utf-8?B?WjczUEc4ZTlCeUpvLzBIN1Z2WmlwZ2RTbXJUbFlZNXlreVFZdzZ4SHFkU1Mz?=
 =?utf-8?B?ek1UYXB0M0xnY3lHTytabnpHL2Vha1BVcGRqeCtBa1dXSitScnlUa3dQYm5v?=
 =?utf-8?B?RS80aHJueFA3K3V3a2F3bWRZR2ljZTdZRGxQZXhLQUpiUFVlODZMTFo1a2tz?=
 =?utf-8?B?U3hrSk1lTkx0MHQ0bTllbERyZHlSbXpOQjF4elUvQVlISkxBMzczUnJWdkd2?=
 =?utf-8?B?b0NFeWUvZXdkVGs0RVB3RnJCUlZHWnVZbG42UEZvUHF6WnBjY29FcHgyS3RJ?=
 =?utf-8?B?SmRuWk4ra1RxVjRpVzFMcVowVGxkR0wvSlRYdkI5Rk9KanNQMjBPZVRFQ3dt?=
 =?utf-8?B?SG1xTkFSNUo3eEtnc0VwS253UllZQmJLb2tsLzJ3eXYwNU1hZVVpOVRLRHJP?=
 =?utf-8?B?NnhvSmlRNnhnem1Gci9XSXlKMjQ5bHh6eFpwMWNpQlpWcUhlSjVvT0hFZXJm?=
 =?utf-8?B?U2FzZkhiOHVCRFRCVk9vc2FDNkZScXhXbmU0akUyUEszb2pESWtnU3p5dTBB?=
 =?utf-8?B?M1Z3Z2xQTTFMOHdYZGRKeTlBNGNlRjRaYkx5VzNCa0tuN21zMkV1aUNydEhD?=
 =?utf-8?B?cFE3RHBnK016SjVrY2lMYmpsdDZ6RzlIMVVISit0UkNMcWZPcnEyOHRPWjBN?=
 =?utf-8?B?UmdNenZUUVBEMEF2WHU1SkttaSt6MmVoeFc3N0xGQStJbEhxeTIzQ1RPT216?=
 =?utf-8?B?NlViZ1FYTkhZbjA5S2oxSDFJQlpndjdWOGdFbXpqdFF2Szl4bzNiVFI5amtF?=
 =?utf-8?B?aUMwaUkyTkxDOEp2dFNEK0syMFVGaG5RMDRqV2IvYWhBOG00WHFGcTFjSVVL?=
 =?utf-8?B?RElzMDJsNHNpVVpFbFVJRDBxb1VSbzdYVXA5dm9YaVpsQmZGMjMyVHY2Smtm?=
 =?utf-8?B?NUNGWWdCVzhIM043cWxZTWFDa1BPWUVuQmp2UUwyOFlIeW5KZ0oyUU1yU3do?=
 =?utf-8?B?Z2R4VnhnMUgrNEtoREJYZ3VpZ25ISXV0dms0dFJOMTRtT1NSYjZ3eHd1Y3gw?=
 =?utf-8?B?djFpbGhHTzM3Q1VWUEx3ZG4xQ3pHUGpVT1Zyb202bXNKMXdBWFpidEUyR1gw?=
 =?utf-8?B?eG9SSEVvajU2bWJQSTdsMURobnQ0Z0VReFFTL3V6WGtwZEE0K1N0bmdBY0w0?=
 =?utf-8?B?Q2ZjNFl5MDd3amlTdXBhdjhZR1o2TzQ5S1JxWCs1QUZzSTBHRkREbWQrUnpm?=
 =?utf-8?B?TFhqc2dTODViUVFoT0N3RE51T2UyYXNveTQzS1d1R2phWHRQRjhkQUhtUjc5?=
 =?utf-8?B?ZXF2Mlhxb3NiaXVLUGFUM2dKc3NKRUZxaWJxVlo0aEc5N01KSS9OZ1hCNVNq?=
 =?utf-8?B?RUQzeDhuK2poc3I5ejhVcWhNaGYvL3dLa1lZRzQ0Y3p4RWtIQVZsczBIVkVM?=
 =?utf-8?B?VWgydG1qVVdvOUxFUm4yREl5TUgzLzdjQTljVWFQS0ROblBocm9kU1lwdGU4?=
 =?utf-8?B?bkVKL3Z0WURWRk9mOXJVVU1wZ0tOZUJZbE9TZExQTUYvS1lVOHB5Ym5pak80?=
 =?utf-8?B?c0htZk1VNUVJdE1WY3paN0VWeFNlakJkNXN2eTZIakF5M0VpbjJzNUtubFAr?=
 =?utf-8?B?RW1CNm9DRC9lUEtJS1RLYndrZEYrNkR2cUhCYmoxVzA4YjdkVmxicFcvNnBy?=
 =?utf-8?B?aWx4WHFRMS9xMGE5Sm1Xc1FDa2t2LzlLdXRKL3JlZWUwOVN2bmFiazcvYW1V?=
 =?utf-8?B?ZVIyMkc2c1UyWVRaYzBLdVJ0U1hyYWw5NGZ6UU42UG54UFN4MHpsdmU5UkxR?=
 =?utf-8?B?Y01jZ1UrTmxKMWJyWGI3MW1jd0FrbkNpejF3SHl0SGw1ZEhmanpCeGFVc0dO?=
 =?utf-8?B?YSs1dllKZExiZEVTQWdFcWdpc3owdUR6RnFYMXg2cE1MZWZsaFRpOFlGWSt2?=
 =?utf-8?B?SlYrOTNtcEpEM0hValZKcW0wZ0RuNnlJZHRMaEpGdWxWNUhTN2dqZGtyYkdm?=
 =?utf-8?B?aXRGSHRJWmRWWW1wRGFTTWozNUtkV2FEckNEWEM2SHdSS1pWWDgvWjZ0d1hH?=
 =?utf-8?B?VXZLODd0OGRCV3luK2pEbFJKRkp3b2xuelJ6YVFYa2M3QkhRYlBQQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e04e61b8-639f-4ec5-d05c-08de411e59fa
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2025 05:52:54.9851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QoE2BLVdFe2mA8i+zu9u+zsAZh1LdMTTm65I4BB4sppPhlvAr1mvACHVRYL2FlmVtQBBQYTrfI4I0ezWbsKCTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9347

Ping? Thanks,


ps. merry xmas :)

On 11/11/25 17:18, Alexey Kardashevskiy wrote:
> Ping? Thanks,
> 
> 
> On 23/10/25 18:11, Alexey Kardashevskiy wrote:
>> PCIe r6.1 added TDISP with TEE Limited bits.
>> PCIe r7.0 added XT mode for IDE TLPs.
>>
>> Define new bits and update the test.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
>> ---
>>   lib/header.h  |  5 +++++
>>   ls-ecaps.c    | 13 +++++++++----
>>   tests/cap-ide |  4 ++--
>>   3 files changed, 16 insertions(+), 6 deletions(-)
>>
>> diff --git a/lib/header.h b/lib/header.h
>> index b68f2a0..c84b7a8 100644
>> --- a/lib/header.h
>> +++ b/lib/header.h
>> @@ -1540,17 +1540,20 @@
>>   #define  PCI_IDE_CAP_AGGREGATION_SUPP    0x10    /* Aggregation Supported */
>>   #define  PCI_IDE_CAP_PCRC_SUPP        0x20    /* PCRC Supported */
>>   #define  PCI_IDE_CAP_IDE_KM_SUPP    0x40    /* IDE_KM Protocol Supported */
>> +#define  PCI_IDE_CAP_SEL_CFG_SUPP    0x80    /* Selective IDE for Config Request Support */
>>   #define  PCI_IDE_CAP_ALG(x)    (((x) >> 8) & 0x1f) /* Supported Algorithms */
>>   #define  PCI_IDE_CAP_ALG_AES_GCM_256    0    /* AES-GCM 256 key size, 96b MAC */
>>   #define  PCI_IDE_CAP_LINK_TC_NUM(x)        (((x) >> 13) & 0x7) /* Number of TCs Supported for Link IDE */
>>   #define  PCI_IDE_CAP_SELECTIVE_STREAMS_NUM(x)    (((x) >> 16) & 0xff) /* Number of Selective IDE Streams Supported */
>>   #define  PCI_IDE_CAP_TEE_LIMITED_SUPP   0x1000000 /* TEE-Limited Stream Supported */
>> +#define  PCI_IDE_CAP_XT_SUPP        0x2000000 /* XT Supported */
>>   #define PCI_IDE_CTL        0x8
>>   #define  PCI_IDE_CTL_FLOWTHROUGH_IDE    0x4    /* Flow-Through IDE Stream Enabled */
>>   #define PCI_IDE_LINK_STREAM        0xC
>>   /* Link IDE Stream block, up to PCI_IDE_CAP_LINK_TC_NUM */
>>   /* Link IDE Stream Control Register */
>>   #define  PCI_IDE_LINK_CTL_EN        0x1    /* Link IDE Stream Enable */
>> +#define  PCI_IDE_LINK_CTL_XT        0x2    /* Link IDE Stream XT Enable */
>>   #define  PCI_IDE_LINK_CTL_TX_AGGR_NPR(x)(((x) >> 2) & 0x3) /* Tx Aggregation Mode NPR */
>>   #define  PCI_IDE_LINK_CTL_TX_AGGR_PR(x)    (((x) >> 4) & 0x3) /* Tx Aggregation Mode PR */
>>   #define  PCI_IDE_LINK_CTL_TX_AGGR_CPL(x)(((x) >> 6) & 0x3) /* Tx Aggregation Mode CPL */
>> @@ -1567,6 +1570,7 @@
>>   #define  PCI_IDE_SEL_CAP_BLOCKS_NUM(x)    ((x) & 0xf) /* Number of Address Association Register Blocks */
>>   /* Selective IDE Stream Control Register */
>>   #define  PCI_IDE_SEL_CTL_EN        0x1    /* Selective IDE Stream Enable */
>> +#define  PCI_IDE_SEL_CTL_XT        0x2    /* Selective IDE Stream XT Enable */
>>   #define  PCI_IDE_SEL_CTL_TX_AGGR_NPR(x)    (((x) >> 2) & 0x3) /* Tx Aggregation Mode NPR */
>>   #define  PCI_IDE_SEL_CTL_TX_AGGR_PR(x)    (((x) >> 4) & 0x3) /* Tx Aggregation Mode PR */
>>   #define  PCI_IDE_SEL_CTL_TX_AGGR_CPL(x)    (((x) >> 6) & 0x3) /* Tx Aggregation Mode CPL */
>> @@ -1576,6 +1580,7 @@
>>   #define  PCI_IDE_SEL_CTL_ALG(x)        (((x) >> 14) & 0x1f) /* Selected Algorithm */
>>   #define  PCI_IDE_SEL_CTL_TC(x)        (((x) >> 19) & 0x7)  /* Traffic Class */
>>   #define  PCI_IDE_SEL_CTL_DEFAULT    0x400000 /* Default Stream */
>> +#define  PCI_IDE_SEL_CTL_TEE_LIMITED    0x800000 /* TEE-Limited Stream */
>>   #define  PCI_IDE_SEL_CTL_ID(x)        (((x) >> 24) & 0xff) /* Stream ID */
>>   /* Selective IDE Stream Status Register */
>>   #define  PCI_IDE_SEL_STS_STATUS(x)    ((x) & 0xf) /* Selective IDE Stream State */
>> diff --git a/ls-ecaps.c b/ls-ecaps.c
>> index 0bb7412..ceeefd7 100644
>> --- a/ls-ecaps.c
>> +++ b/ls-ecaps.c
>> @@ -1665,7 +1665,7 @@ cap_ide(struct device *d, int where)
>>       if (l & PCI_IDE_CAP_SELECTIVE_IDE_SUPP)
>>           selnum = PCI_IDE_CAP_SELECTIVE_STREAMS_NUM(l) + 1;
>> -    printf("\t\tIDECap: Lnk=%d Sel=%d FlowThru%c PartHdr%c Aggr%c PCPC%c IDE_KM%c Alg='%s' TCs=%d TeeLim%c\n",
>> +    printf("\t\tIDECap: Lnk=%d Sel=%d FlowThru%c PartHdr%c Aggr%c PCPC%c IDE_KM%c SelCfg%c Alg='%s' TCs=%d TeeLim%c XT%c\n",
>>         linknum,
>>         selnum,
>>         FLAG(l, PCI_IDE_CAP_FLOWTHROUGH_IDE_SUPP),
>> @@ -1673,9 +1673,11 @@ cap_ide(struct device *d, int where)
>>         FLAG(l, PCI_IDE_CAP_AGGREGATION_SUPP),
>>         FLAG(l, PCI_IDE_CAP_PCRC_SUPP),
>>         FLAG(l, PCI_IDE_CAP_IDE_KM_SUPP),
>> +      FLAG(l, PCI_IDE_CAP_SEL_CFG_SUPP),
>>         ide_alg(buf2, sizeof(buf2), PCI_IDE_CAP_ALG(l)),
>>         PCI_IDE_CAP_LINK_TC_NUM(l) + 1,
>> -      FLAG(l, PCI_IDE_CAP_TEE_LIMITED_SUPP)
>> +      FLAG(l, PCI_IDE_CAP_TEE_LIMITED_SUPP),
>> +      FLAG(l, PCI_IDE_CAP_XT_SUPP)
>>         );
>>       l = get_conf_long(d, where + PCI_IDE_CTL);
>> @@ -1697,10 +1699,11 @@ cap_ide(struct device *d, int where)
>>             {
>>               // Link IDE Stream Control Register
>>               l = get_conf_long(d, off);
>> -            printf("\t\t%sLinkIDE#%d Ctl: En%c NPR%s PR%s CPL%s PCRC%c HdrEnc=%s Alg='%s' TC%d ID%d\n",
>> +            printf("\t\t%sLinkIDE#%d Ctl: En%c XT%c NPR%s PR%s CPL%s PCRC%c HdrEnc=%s Alg='%s' TC%d ID%d\n",
>>                 offstr(offs, off),
>>                 i,
>>                 FLAG(l, PCI_IDE_LINK_CTL_EN),
>> +              FLAG(l, PCI_IDE_LINK_CTL_XT),
>>                 aggr[PCI_IDE_LINK_CTL_TX_AGGR_NPR(l)],
>>                 aggr[PCI_IDE_LINK_CTL_TX_AGGR_PR(l)],
>>                 aggr[PCI_IDE_LINK_CTL_TX_AGGR_CPL(l)],
>> @@ -1744,10 +1747,11 @@ cap_ide(struct device *d, int where)
>>           // Selective IDE Stream Control Register
>>           l = get_conf_long(d, off);
>> -        printf("\t\t%sSelectiveIDE#%d Ctl: En%c NPR%s PR%s CPL%s PCRC%c CFG%c HdrEnc=%s Alg='%s' TC%d ID%d%s\n",
>> +        printf("\t\t%sSelectiveIDE#%d Ctl: En%c XT%c NPR%s PR%s CPL%s PCRC%c CFG%c HdrEnc=%s Alg='%s' TC%d TeeLim%c ID%d%s\n",
>>             offstr(offs, off),
>>             i,
>>             FLAG(l, PCI_IDE_SEL_CTL_EN),
>> +          FLAG(l, PCI_IDE_SEL_CTL_XT),
>>             aggr[PCI_IDE_SEL_CTL_TX_AGGR_NPR(l)],
>>             aggr[PCI_IDE_SEL_CTL_TX_AGGR_PR(l)],
>>             aggr[PCI_IDE_SEL_CTL_TX_AGGR_CPL(l)],
>> @@ -1756,6 +1760,7 @@ cap_ide(struct device *d, int where)
>>             TABLE(hdr_enc_mode, PCI_IDE_SEL_CTL_PART_ENC(l), buf1),
>>             ide_alg(buf2, sizeof(buf2), PCI_IDE_SEL_CTL_ALG(l)),
>>             PCI_IDE_SEL_CTL_TC(l),
>> +          FLAG(l, PCI_IDE_SEL_CTL_TEE_LIMITED),
>>             PCI_IDE_SEL_CTL_ID(l),
>>             (l & PCI_IDE_SEL_CTL_DEFAULT) ? " Default" : ""
>>             );
>> diff --git a/tests/cap-ide b/tests/cap-ide
>> index edae551..eabf5ea 100644
>> --- a/tests/cap-ide
>> +++ b/tests/cap-ide
>> @@ -76,10 +76,10 @@ e1:00.0 Class 0800: Device aaaa:bbbb
>>           PASIDCap: Exec+ Priv+, Max PASID Width: 10
>>           PASIDCtl: Enable+ Exec- Priv-
>>       Capabilities: [830 v1] Integrity & Data Encryption
>> -        IDECap: Lnk=0 Sel=1 FlowThru- PartHdr- Aggr- PCPC- IDE_KM+ Alg='AES-GCM-256-96b' TCs=8 TeeLim+
>> +        IDECap: Lnk=0 Sel=1 FlowThru- PartHdr- Aggr- PCPC- IDE_KM+ SelCfg- Alg='AES-GCM-256-96b' TCs=8 TeeLim+ XT-
>>           IDECtl: FTEn-
>>           SelectiveIDE#0 Cap: RID#=1
>> -        SelectiveIDE#0 Ctl: En+ NPR- PR- CPL- PCRC- CFG- HdrEnc=no Alg='AES-GCM-256-96b' TC0 ID0 Default
>> +        SelectiveIDE#0 Ctl: En- XT- NPR- PR- CPL- PCRC- CFG- HdrEnc=no Alg='AES-GCM-256-96b' TC0 TeeLim- ID0
>>           SelectiveIDE#0 Sta: secure RecvChkFail-
>>           SelectiveIDE#0 RID: Valid+ Base=0 Limit=ffff SegBase=0
>>           SelectiveIDE#0 RID#0: Valid+ Base=0 Limit=ffffffffffffffff
> 

-- 
Alexey


