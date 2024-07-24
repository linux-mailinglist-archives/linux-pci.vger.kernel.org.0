Return-Path: <linux-pci+bounces-10726-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7047B93B309
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 16:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27DEF2817A5
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 14:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFB316D9A6;
	Wed, 24 Jul 2024 14:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nJecBpjf"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F6D15DBD8;
	Wed, 24 Jul 2024 14:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721832377; cv=fail; b=TIqwxLiWKCbMqOVPLrh4hxh8Qoc7vuIM3TkF0CSMAeWwerLLR1ZbfXPNWpQuuXwedma/d7uyVwzUzWWz0DdeYEQhEPKARPS/dIjlSRLSrgwurkdwaZuyj1c2UiStHJHxx+CkrG3GmnpHi8oUnhxukDggxj+jLWn6oGWR8SZ+G/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721832377; c=relaxed/simple;
	bh=1ubtEBBz5sLzTmOVjQPcMPEixfucGh7Y7MnDNiFgPDA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O4H1UlFI8lEul0frbVQjFYnmWaxXON/+T6Gs+0mDyMcAj7Xgf0ugxq6wkUQ4C5eHzax1GMsMyGFyOi2KK4a/v0ie/joAbpXS1gmTsPxVCB3MHLPDGrbOfSVqHtkZS7X4EjRHtBlRwa9DoOMQnk9OMfdnJt1wWSyazurqzw+dTqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nJecBpjf; arc=fail smtp.client-ip=40.107.236.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=frsLlEs9is6XhzJiNlKfqLv+uUoxxW7zN+I9zkTgnPeDYRql8LMEBYOncJvKUr3BgOweJkyBVNIcOvjA4HlVJK8Vww4ppdnGD94cdSFzjTkbAqdifuizrrtNQqPaDVAMi0ZJ5MRtbJsyKrnGKZSh1lS6GOkI3hERJtAZVimKsByxRK6eGy6ZIswBTXri+OxwSzAlzD5nXSVH8R6wGnq45DsdamDqJVTJOuOfifS+zif6FsolPjc9Ok35qgMOY0Au+yElxZ4Fjrp3LKAdu+mD7FzTPRrKnxP2D8qCSL46R+2+a0XegK2eVPNFboJoplcxKUNTxDXW7lwtiezjvW9l1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dSGXonjZLOEP34DtYrGn/A/HPWgwhjfNd3GpxEa2eI4=;
 b=OE5+WeC3KUMlp7jzMVZh3pAKgUQc7EKnuilyU8b2BOdSgbg4kho35+I2iOrQbJLYiL/g9IcmlCO500RUf1f+vYw99+hCJCGrUf/9OYYjmjLqVdQe+IEtCRR5P6kWyxzH3tBpcyI97sxNCIJ9FImVltmgpFnR/Wd3+Flm/D6mtCg6q2Zfl8Xi1E/tXsGjNcsvnbiKDGQJp5MgmNa95VfLhfN7dBxlF3f9fp5ORLsf1J/2VHEODOrlWV70o06wL8xZNbHhzd/oAEgOggX4XWWBrFvebEJ4kSn1aQEThlrcxui1RpnUVUaPcznzsL/KhJm0hQ/R4bBFZw2aKg24mC+t+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSGXonjZLOEP34DtYrGn/A/HPWgwhjfNd3GpxEa2eI4=;
 b=nJecBpjfFuUkrFihTn1VaMC6VC7A4tKaA+epqRKmpGIydq+Jj6toZCjFW1MdEorarh7Q9sa0UBxKa8BkjMhKFHNsJaJB0lnme9rICmOdiYTW1AizkqjbI6z8j+zeWD1UbInyDLuIqCWx7Gk/zV/ct9h+VCQVCgKpNjOK2+GoInY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DM3PR12MB9433.namprd12.prod.outlook.com (2603:10b6:0:47::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Wed, 24 Jul
 2024 14:46:09 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.7784.013; Wed, 24 Jul 2024
 14:46:09 +0000
Message-ID: <fc94330f-1ef0-8b84-ebb8-44fd74c4a3c9@amd.com>
Date: Wed, 24 Jul 2024 15:45:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V3 03/10] PCI/TPH: Add pci=notph to prevent use of TPH
Content-Language: en-US
To: Wei Huang <wei.huang2@amd.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Jonathan.Cameron@Huawei.com, helgaas@kernel.org, corbet@lwn.net,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, alex.williamson@redhat.com, gospo@broadcom.com,
 michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
 somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
 manoj.panicker2@amd.com, Eric.VanTassell@amd.com, vadim.fedorenko@linux.dev,
 horms@kernel.org, bagasdotme@gmail.com, bhelgaas@google.com
References: <20240717205511.2541693-1-wei.huang2@amd.com>
 <20240717205511.2541693-4-wei.huang2@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20240717205511.2541693-4-wei.huang2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0663.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::10) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DM3PR12MB9433:EE_
X-MS-Office365-Filtering-Correlation-Id: 88f84c31-e1b2-430a-b968-08dcabef5aeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NHFLam92NllaNUl5QzU4ei8rRTZCTnMxQXdPd3N3dEZPMTBTSlVndXRHaVFa?=
 =?utf-8?B?UlRkMVpYR2dnMWFnbnVxZkJyUnFPOWpENVNlTkFGenFMa2kvNWppeFJQZ2h5?=
 =?utf-8?B?NkZ5blRhcm9uNjQ2bTlyWDNraTRJVnZTektGYWY1L1I0bi83ZjF3RzJZa3ds?=
 =?utf-8?B?bTgyMXBpM2YrU3IrUDQwMlJQWGFnK2JsckJYaXV3NEtJcFdPMWxlbHhhVTdp?=
 =?utf-8?B?bzMzdUR6WXAvK0xlU1pLdDV2Rm9WOC9heXZwbWNCTy9MaSt3SDdmQ28xVEJq?=
 =?utf-8?B?dzNtV2tzNzBiNjVFSnUzR09SOW0wWXBzbHlqR2hTcXNXbzBkMVNiRlRJbUZV?=
 =?utf-8?B?cTZnZk1OMnQxczZLclNSWFlTeGhxVzJQYW1xbUVTQ3FnY055ZFVXd1h5UFl2?=
 =?utf-8?B?OGR1UTYvaFRnTjVQNG9Hb1NKRHZDU2J6WmdLMkMycm5CWUcydWNUV2s4SEV1?=
 =?utf-8?B?RUhlTjE0b3ZKV3JrMjNRTS9kZ0ZpUXZGQVA2enVXRG5FQW8wdzJLWWpjQlRa?=
 =?utf-8?B?b1BWYndGeE1sSXJubmkxTWJnU1V3dy9TWXBYNDJEaElFMUpPRFk4dC9vMklT?=
 =?utf-8?B?ODYydDdaYzJWeG5aeGFRYS9GeEVYVnJjdWIyRWw2aGlSeEVYc1FPZHYxUDBG?=
 =?utf-8?B?ajBJejhIQ1RQQ2E5MHRwWEhaZDNFOEx6TFA4Mm5rVnJsU0NSWVc0eFZjei9H?=
 =?utf-8?B?TXlYMU1CNFBPd21KY3NUT3Y0VmdtR3NxdDZrOFdEODR3elI3SHFBemlYU0Rz?=
 =?utf-8?B?akZreDFFRmtqY2krM0tnU0RRTVFWWlN3eFE0MnJ4WjYzeUlqemtyaTVzVmZx?=
 =?utf-8?B?TEtyUG5WY0tqdWEvN3JFNlFkblN3UkN4SGRBaVlrZEI4K3AvcDA4UXY2WU1H?=
 =?utf-8?B?YjZCR2kxYnZYQjUzOXFIdDVqN2t0a2JqRU01bFMzWWJDRzVKTStIRXdtd1A1?=
 =?utf-8?B?WUlLdnh6UXJSeldWT3BEdGdKaDA1ejN1d1V2YVY4U0duMjVqT0VZS2xQZVdT?=
 =?utf-8?B?ZEQyQXpZQ3E1Z25pa2VtY0NPQzNyTFRMV0JBeU1tUHZBSVNZc3liUFI5VUlG?=
 =?utf-8?B?eUR6MDZwUjVSaW4rWGsxeWhRd0J6Qkc1TWczRHZWVEJidGF3a3dseFZDNys2?=
 =?utf-8?B?dDEvckdIdG5ENE5LUHcwTzVsM09heS9yNHhac2dJKzRjcGlmSm16SEt3aXJX?=
 =?utf-8?B?UkFMeEVzSEhaajdlNnlQYmxKZ2JqMjQvM0dUb09GazlXcGFoSUEvRlNtSkdj?=
 =?utf-8?B?bnZKOFdIUWRRcFNqQlRlNXcxczIvd3JzRnBoUEtqczJ2SldLaEV2STBUYXVa?=
 =?utf-8?B?SjVFbWVuL3h3bTlUNEpnR3RCa2t5YlFXS1hwNExZRFhrWWVwR1dFZmgwdkRG?=
 =?utf-8?B?blBYUFA3ZHhuVm1XVnNLOHY2bk1KT3NyUDVaYS9FeDV0U1BKelM3UllXci9Y?=
 =?utf-8?B?QUpqeGxGNzhybWpyUmlGcDdDWHBPbzhCVUtaZ2h2TFJvRjBTTDRaVnJtS0h5?=
 =?utf-8?B?OWFIOU1tcEJGbjcxR0RhMU52Nlpsc2VncEtKRFlwNWd2NDZLdE5LSUFyWG1Q?=
 =?utf-8?B?dXdDUkNzZVYxZUxjT0lDR2x4UWpzZmYrSFZrMEZleDZYZzFkVlF6OUtsa2Va?=
 =?utf-8?B?QzhyaC8wOGpwWjJZNVhyWGFMRDVtRVNOc3Rpc0N4UlJGU3hYbXRjcGhtaEhO?=
 =?utf-8?B?RlAyeHZENWJhbUovWjEzcjBMNmsrZTRpRTZuamk2Z0ZjejlFME14cVBXd2VP?=
 =?utf-8?B?RGp3OURHK2lYQkRFamtaZnNsZTBOZFNhT3lkMWF2eTFVMDMzZVlXODlXUzl1?=
 =?utf-8?B?SUFBaGVhWEo1NGVrZXBRQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TzA4NVVWZWlBNTc1QjZnNzJkK2xMbENya0NrYkZQUkcyekdTcFR6czg3Sy9N?=
 =?utf-8?B?UDNDYnl5NjNzQ0FON3NJb3ExakNQNTZNaFE4VUNaYVJOUWxLSE9pdHRWWkww?=
 =?utf-8?B?THp6cUNTWXN5K2c1OGlJeXA1UFA4UlVyTkZCbTRGM1ZuNnJqWWM4MzI0VjZR?=
 =?utf-8?B?a2tZL1NjeXdlQ2JHR2F2dlFDU3ZpdHFnNmdMcW1YMkVDRmVscEw4WmROY01v?=
 =?utf-8?B?WElHWUxIK25CcHZ4Nzh3YXN3TC9WUXcySjl5NjlZQU4xZnRXWEhKT0hlOWd2?=
 =?utf-8?B?a2w5emJGR1hHOENlci9DTlpodTRmUTJlTGlYOFo2YXRuMkwvQUhPdk1hTHpN?=
 =?utf-8?B?R0M0a3Jua0dSaVFEYTg3anIyTG1sdjJaTjY0MlpySk1nMDdCdXRBaFpvcDJM?=
 =?utf-8?B?RVJMcUduajJhdkdZSGJIcUdvQlI2R2IyYjYzSG9NbVdjVktwUVlVRitPbXRL?=
 =?utf-8?B?ZWRaSVJ6SURidU1SeFNPM1cyVzhIMzJEVGpUT2hkSlRQOEJFNS84VDYrQjBr?=
 =?utf-8?B?ZUlMZ2RTd0dxenRvUUhZY1VCa0lXblB5T0E5NTNBTW81OFc0Z3FpMzEwdy9E?=
 =?utf-8?B?dVZUelFKVEpkckY5L3VVVFp3SDErL0g3SEpwYmZVM1F3MmZNdUVIOVRpVXI3?=
 =?utf-8?B?WlRURlNOMVNQTVQxZ0VyMkJjczZaWCtad3pwVDVoTHpnZ1hYZm1qOFpJS2pT?=
 =?utf-8?B?cTRaVXpMelVxYWpPbENHYnY3UGw4YTErSjRHZHlldDV1VTdaN0t3ZHhBM3pG?=
 =?utf-8?B?bmEzQklyMzVTSDRpcmxZWC9vSGFGY0h6djd0ZG9PVlBKL1Q2VjZlcW0yaTJx?=
 =?utf-8?B?eHdRZ1FpbE5sOXNhMktXeksyYndpajVVK0VyWURNVkVGSTRsMGhKU01lVldL?=
 =?utf-8?B?WG1jU1NNWGFhVUdjZW1iSWpFdnZPdllqTkNQbmxIUFJvSHdxbGk4TDdXKzYw?=
 =?utf-8?B?K2c1dVFzbzZoMVhhMzJMZ0RQcUJTZTQ1SXU1V1pUN0JFU0xuQ0FBUzBJYUJR?=
 =?utf-8?B?bWk4YlpRMlFvcDVhMzV6eGNHbUdWRjJMTEZxd1cxbElCakQvbTVVaGZUSWNJ?=
 =?utf-8?B?RlBIdnlDOFVFQjR4aFJPRnFjdXh0MkxFcU45WHBpRWRpYklJeS9vRmdVR2xP?=
 =?utf-8?B?N09CMWZueVhGZjBOVUhrWmZucC9IV05lYzM4WW1UTGRJRktqK28vNW8xdk9U?=
 =?utf-8?B?UFdNajVKS2UxV3UrdUFYN3gyUjU0TTNyK2hnNW5raytIYzhLTmkwSHg5RGJV?=
 =?utf-8?B?U2RiZ1pVYnFESVRsRHZ2UlpWbnIxa3VJUWgxUVBKLzM3NUJjNGd0UnZ4Qzhw?=
 =?utf-8?B?ZVdwUTZ3aG1lS3lzV0JtWmJGRklKYnNVOWlIZC9RczNQdWlGK05hZVMvb3Bj?=
 =?utf-8?B?bVg3VS96Ty9vQ1VnQ3RneW9SUVQ1Z056MHBiTC9YL0NxMzNWVVNlWm5aUWo4?=
 =?utf-8?B?SFluaWMwR1h0T0oxWE52eXZleU1jOElsTTJVYjIxWDVSRXpPSzhEc28vVjlo?=
 =?utf-8?B?SjBXN1VmVVhFenR6TWJneHF2cUswQW5pRXd1NGFBTWFZM1M2eVJVaitrTTdC?=
 =?utf-8?B?SHVCSGMwdkhFbjdXZkxSNEpGRG95UkpnMlZjUmZVbnZBdDdhVDF1bzJINWFG?=
 =?utf-8?B?ZlpLWU1Jd1ZnY3hiRHY0Z3FWZ2o2YWhjTHlOZXlISnVRV1pldHl1cTFkeWRD?=
 =?utf-8?B?cWpKaUlMbklRS2R2V0lobmphK3h0T2U2RTlKUEpUMzZKSVRReVlDdUIvQUJl?=
 =?utf-8?B?aG9hS3BLWkFCSU11YkpBSzZ3elJQVHZ5ajZtTjliWkl5MDY0d2VOM2pManF5?=
 =?utf-8?B?YnVrbExhb292YUlIb09IbmZ4N3NIUytoa0V1cUpHb3NjRlYyMy8xSTlsdWVB?=
 =?utf-8?B?eE1aVGhoMkRzMG9BRGRtODQrNG5IWjZueTFTakRxSDNiNHRPUGZzVHZrNlA1?=
 =?utf-8?B?NWVHZ09nWXh1Uk5zYkhKVXBycWVpSHdtT29iTU5SRnc1M0E2YlF4V2l5ZVY0?=
 =?utf-8?B?TnFKZXZvM3dSOTRPRVdrWTZ3ampsNzN3aldYZEZZS09kd3R4elIrTDhndVBn?=
 =?utf-8?B?cnBQZFhOSEFlQU1SUkk2dm1jUGJndnVaSTJMWUZiUnRZa1MzbWVuOUxrQW5D?=
 =?utf-8?Q?DCM+G8W+7bjTPQwWSxxphJjMk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88f84c31-e1b2-430a-b968-08dcabef5aeb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 14:46:09.3171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2tSFWVLt7ofcMa2b+5G0J8idKU1LNWNrfepXWEfTexSdpfDmmvS59/uM+/CwEVQIqEl7KV4kwq6dLjJVXeOt8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9433


On 7/17/24 21:55, Wei Huang wrote:
> TLP headers with incorrect steering tags (e.g. caused by buggy driver)
> can potentially cause issues when the system hardware consumes the tags.
> Provide a kernel option, with related helper functions, to completely
> prevent TPH from being enabled.


Maybe rephrase it for including a potential buggy device, including the cpu.


Also, what about handling this with a no-tph-allow device list instead 
of a generic binary option for the whole system?

Foreseeing some buggy or poor-performance implementations, or specific 
use cases where it could be counterproductive, maybe supporting both 
options.


> Co-developed-by: Eric Van Tassell <Eric.VanTassell@amd.com>
> Signed-off-by: Eric Van Tassell <Eric.VanTassell@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
> Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> ---
>   .../admin-guide/kernel-parameters.txt         |  1 +
>   drivers/pci/pci-driver.c                      |  7 +++++-
>   drivers/pci/pci.c                             | 12 +++++++++
>   drivers/pci/pcie/tph.c                        | 25 +++++++++++++++++++
>   include/linux/pci-tph.h                       | 18 +++++++++++++
>   include/linux/pci.h                           |  1 +
>   6 files changed, 63 insertions(+), 1 deletion(-)
>   create mode 100644 include/linux/pci-tph.h
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index b2057241ea6c..65581ebd9b50 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4655,6 +4655,7 @@
>   		nomio		[S390] Do not use MIO instructions.
>   		norid		[S390] ignore the RID field and force use of
>   				one PCI domain per PCI function
> +		notph		[PCIE] Do not use PCIe TPH
>   
>   	pcie_aspm=	[PCIE] Forcibly enable or ignore PCIe Active State Power
>   			Management.
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index af2996d0d17f..9722d070c0ca 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -21,6 +21,7 @@
>   #include <linux/acpi.h>
>   #include <linux/dma-map-ops.h>
>   #include <linux/iommu.h>
> +#include <linux/pci-tph.h>
>   #include "pci.h"
>   #include "pcie/portdrv.h"
>   
> @@ -322,8 +323,12 @@ static long local_pci_probe(void *_ddi)
>   	pm_runtime_get_sync(dev);
>   	pci_dev->driver = pci_drv;
>   	rc = pci_drv->probe(pci_dev, ddi->id);
> -	if (!rc)
> +	if (!rc) {
> +		if (pci_tph_disabled())
> +			pcie_tph_disable(pci_dev);
> +
>   		return rc;
> +	}
>   	if (rc < 0) {
>   		pci_dev->driver = NULL;
>   		pm_runtime_put_sync(dev);
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 02b1d81b1419..4cbfd5b53be8 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -157,6 +157,9 @@ static bool pcie_ari_disabled;
>   /* If set, the PCIe ATS capability will not be used. */
>   static bool pcie_ats_disabled;
>   
> +/* If set, the PCIe TPH capability will not be used. */
> +static bool pcie_tph_disabled;
> +
>   /* If set, the PCI config space of each device is printed during boot. */
>   bool pci_early_dump;
>   
> @@ -166,6 +169,12 @@ bool pci_ats_disabled(void)
>   }
>   EXPORT_SYMBOL_GPL(pci_ats_disabled);
>   
> +bool pci_tph_disabled(void)
> +{
> +	return pcie_tph_disabled;
> +}
> +EXPORT_SYMBOL_GPL(pci_tph_disabled);
> +
>   /* Disable bridge_d3 for all PCIe ports */
>   static bool pci_bridge_d3_disable;
>   /* Force bridge_d3 for all PCIe ports */
> @@ -6869,6 +6878,9 @@ static int __init pci_setup(char *str)
>   				pci_no_domains();
>   			} else if (!strncmp(str, "noari", 5)) {
>   				pcie_ari_disabled = true;
> +			} else if (!strcmp(str, "notph")) {
> +				pr_info("PCIe: TPH is disabled\n");
> +				pcie_tph_disabled = true;
>   			} else if (!strncmp(str, "cbiosize=", 9)) {
>   				pci_cardbus_io_size = memparse(str + 9, &str);
>   			} else if (!strncmp(str, "cbmemsize=", 10)) {
> diff --git a/drivers/pci/pcie/tph.c b/drivers/pci/pcie/tph.c
> index e385b871333e..ad58a892792c 100644
> --- a/drivers/pci/pcie/tph.c
> +++ b/drivers/pci/pcie/tph.c
> @@ -7,8 +7,33 @@
>    *     Wei Huang <wei.huang2@amd.com>
>    */
>   
> +#include <linux/pci.h>
> +#include <linux/bitfield.h>
> +#include <linux/pci-tph.h>
> +
>   #include "../pci.h"
>   
> +/* Update the TPH Requester Enable field of TPH Control Register */
> +static void set_ctrl_reg_req_en(struct pci_dev *pdev, u8 req_type)
> +{
> +	u32 reg_val;
> +
> +	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, &reg_val);
> +
> +	reg_val &= ~PCI_TPH_CTRL_REQ_EN_MASK;
> +	reg_val |= FIELD_PREP(PCI_TPH_CTRL_REQ_EN_MASK, req_type);
> +
> +	pci_write_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, reg_val);
> +}
> +
> +void pcie_tph_disable(struct pci_dev *pdev)
> +{
> +	if (!pdev->tph_cap)
> +		return;
> +
> +	set_ctrl_reg_req_en(pdev, PCI_TPH_REQ_DISABLE);
> +}
> +
>   void pcie_tph_init(struct pci_dev *pdev)
>   {
>   	pdev->tph_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_TPH);
> diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
> new file mode 100644
> index 000000000000..e0b782bda929
> --- /dev/null
> +++ b/include/linux/pci-tph.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * TPH (TLP Processing Hints)
> + *
> + * Copyright (C) 2024 Advanced Micro Devices, Inc.
> + *     Eric Van Tassell <Eric.VanTassell@amd.com>
> + *     Wei Huang <wei.huang2@amd.com>
> + */
> +#ifndef LINUX_PCI_TPH_H
> +#define LINUX_PCI_TPH_H
> +
> +#ifdef CONFIG_PCIE_TPH
> +void pcie_tph_disable(struct pci_dev *dev);
> +#else
> +static inline void pcie_tph_disable(struct pci_dev *dev) {}
> +#endif
> +
> +#endif /* LINUX_PCI_TPH_H */
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 6631ebe80ca9..05fbbd9ad6b4 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1840,6 +1840,7 @@ static inline bool pci_aer_available(void) { return false; }
>   #endif
>   
>   bool pci_ats_disabled(void);
> +bool pci_tph_disabled(void);
>   
>   #ifdef CONFIG_PCIE_PTM
>   int pci_enable_ptm(struct pci_dev *dev, u8 *granularity);

