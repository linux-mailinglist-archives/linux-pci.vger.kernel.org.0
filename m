Return-Path: <linux-pci+bounces-31326-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E4FAF686A
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 04:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6310B522554
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 02:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56E8219A95;
	Thu,  3 Jul 2025 02:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TsIG/Rat"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D7B23BE
	for <linux-pci@vger.kernel.org>; Thu,  3 Jul 2025 02:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751511581; cv=fail; b=Z/vTArYtMU3MTERSKwqgiHkXYNYf/3pTcWwgVDpHcHYFk0qPCDXmDVHd4TSRaIQra/tH1hYRaZqHXhRyneYgDqRQknwrgMiGO23MF5X1FgoxiMQ3+/IdPC6g1BX05xln8LaGgN5q5bvYaIB2vkWMKfc7gg8dXYglRdaDR32nc5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751511581; c=relaxed/simple;
	bh=YoDCRtsXzqONxaSq3f13m15GCDOAjCSQdbpv9W73jF4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WCnS4hhVJRK9czSeQNpUhRfbt6jiO9B5TPLj/evRZGeGKeOyacCxS6ZErrhtX63AXfX0+62XaygjQ6IOohEd6JHuOPStxeOZ0kMR7/nYmP1XIVatguqbpwT1mP/woxNjyW7s34mfJlKv/s9tf0o8Uqw7LoCX8lySCd11iloZmm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TsIG/Rat; arc=fail smtp.client-ip=40.107.94.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ysLVNRs7eZC8uQCbPTc1Pj3Y172bck4nNK7EUXNow0YAlQcU0Jg36BeG6Z1PHBepjxvTFg/Cw0doRTbG0CYGn568Z/sfW13/F1wDcSGtqtB1TrU0yqaADbWml6pqYceZXCT+QRo7TLbborY9loAteHL5Z3cwz+rUuuIDPoHkxmfoMHYHaUgIWihWA1cFImmX05DkMxF0oN3Py/ViWDnVojH0mYA34eSBpER/JfyxiBw6+8MZ6HKOhnuFhAQKlhyupdtbteEhKqTZae04qRccOejvjmsFqa/grzOhvsFWmd3O7Ntwt5lx8lZUzG6gaZFZ2ZGmRITQBwBFnWCaDAU9aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bB8ztLFKRDN0bRVzzHf/M2q84Y+CctN/fuiNOEEDIOo=;
 b=CfHLezwPTpqkOnGrO20qXFlcgN0Oq3mgtqeNOSaBt7ewk+f7by6/auvE4+OfQLVULO2384ERjs5BQMvAGT/za/NEGyWLn9G7ZuTtUB9UP+7mZu+5NqslLtmvnbUf5OC1mopxCSsLqrX8VaghkkGzruvxYP8GVUnGhlCop++/NPvcsMsmVmpAGWf+36jhBe9oHvrjb9vAnrw+N07hW+Mwzepv3voIo6tKSHaBXDqi00goqZ/8ScXZKylSQ/BGaRPE3uQnG6kqXs5FP/aDDkSrgLnKBjc+1aU9VY4l93AJya5B9UahlkpVID/NB2oHxkgwCxYfTuzaINXOXZmc4gaueg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bB8ztLFKRDN0bRVzzHf/M2q84Y+CctN/fuiNOEEDIOo=;
 b=TsIG/RatVEXkdCv223XWLJkh4JJYxaVbo22eouqkPw4Tir5FClv/aLw/rHEAC9wQ2eZYUv0Wc40wBuund+DLLSvdEyAtshEGi5M4oDOsZ8fKRG4XL/V5qjd4YNc4mVpLo23IK2JdeEA13LyTOOYE+lyoIm30jwjJPiMTS/Z3FT0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by IA1PR12MB6409.namprd12.prod.outlook.com (2603:10b6:208:38b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 3 Jul
 2025 02:59:36 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::1e6b:ca8b:7715:6fee]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::1e6b:ca8b:7715:6fee%7]) with mapi id 15.20.8901.021; Thu, 3 Jul 2025
 02:59:36 +0000
Message-ID: <24958311-8cd7-40d8-a366-3141eae7676e@amd.com>
Date: Thu, 3 Jul 2025 12:59:25 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v3 08/13] PCI/IDE: Add IDE establishment helpers
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org
Cc: gregkh@linuxfoundation.org, lukas@wunner.de, aneesh.kumar@kernel.org,
 suzuki.poulose@arm.com, sameo@rivosinc.com, jgg@nvidia.com, zhiw@nvidia.com,
 Bjorn Helgaas <bhelgaas@google.com>, Yilun Xu <yilun.xu@linux.intel.com>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-9-dan.j.williams@intel.com>
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20250516054732.2055093-9-dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0019.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::14) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|IA1PR12MB6409:EE_
X-MS-Office365-Filtering-Correlation-Id: ea620df4-de1d-4138-84de-08ddb9dda4b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cmJrK0tLM0dLQXgyS0hvK2QrRWNMNkFvVitsRnJTcDljZDh5bW5sNW9OUE0y?=
 =?utf-8?B?TjlJM0p5c2puK0hJQWl5R2JyYUNQTVlFNysxSWgwZkpvbVJSbEw2N0VSTDZG?=
 =?utf-8?B?Mm02ZjhoenpSMW1xOWFGVjBFbkhsL1EwdTZtWTZYZnNuc2o3ZFlIR01oQ3dR?=
 =?utf-8?B?RG5rbU56N3lSaDlZQlJNUVdBaDJXdFNuem1jMnRBdjVBc1IvUzdPbm41Ny9o?=
 =?utf-8?B?YjN2VmVTQnk5RkFibjJrV2txeUZwbmhoTi9pcWdNMlJpTUFuaytKVndiN0xr?=
 =?utf-8?B?MytKSG5Ga1Qydk05bmQ1K1MrY2Z4enlxOURXKzNhQ2JybURpNjRvMXQrOHlx?=
 =?utf-8?B?ZlFFalMweVJYbjV3NFZFNE5iN2dIc0h0VkdNU0FXYUtSMXMwcXdQYkUyUk1u?=
 =?utf-8?B?VDZ5U2JTZnp0QVBKc0RQUTZmVUNuYmowMEg3UzlDdHR0c0Fqd0VYM1h1NVlU?=
 =?utf-8?B?aC9iNGgxa0V4bW5PandBWTZuaEhlV3cwNkpGcmVVOHhYckNvWkRJOVgvaWk2?=
 =?utf-8?B?TXNHR05TTnppZDdjUncrSEY3SmFFWUhJd0hRWkZLVkQ5SHYvYnFtcXF2bWMw?=
 =?utf-8?B?WFc3bFluMGRKZGkxa001UzBkQzhsbFVlUzJ5enBVdnZQR2hMa1dqR0Z4UFpr?=
 =?utf-8?B?dzBIMERRRWdqcGxscUpnMWV2bStUT0RUeXE5ZXlUQk9LTWt1cUdHeUQ5UE0w?=
 =?utf-8?B?Q2ZWclllTXc0eGZXTnUxVTJ6TlpZT2loTEN6MDFHMmxRTXdKMlFtcnk4SGZl?=
 =?utf-8?B?TW1ER1NOTlJKSGFibzR1NWE0V2kvYkFoUFRmWG9rclNWK2JOY0VKZk5pVGRC?=
 =?utf-8?B?NCtRZWdIU3EwU3JiTkdwMXo4MUtZNHhQak5xbzhMTjZRR0ZNdjNLdmc2Q0Rj?=
 =?utf-8?B?aFhTeWhNRTNQNnpKRC8xZDM1ZVVrWEpLU3dVQjJWTHViamwwRStCNXRSclNz?=
 =?utf-8?B?aU9tRVFLT1oyKzBPYmtMU3NSZ2pIU2IrbXhuODRnQURNdzN5WFVFeXRuWXBr?=
 =?utf-8?B?RzBoWE5XbnRmY2FCSnlhVmo2eVgvOWRMcE9qaG5Xb1MrbTYwYSt4ZUZlM3dt?=
 =?utf-8?B?ME5jTVZpd3N2OHhjTnA2VjljOHpydnF1MHJhRGVOVnlBN0FJdEErc094Uy9a?=
 =?utf-8?B?MmNKakxZVFZIN0JaVDlsRFd6UFZsOHR3OXpKaUhlSHpONUtPejNBR3AvamFS?=
 =?utf-8?B?RTZROXUyVXZDZ0tSMkdELzlFUEZZaWJsemh3N3AyYks5OVcwcGxxSlNqY1N2?=
 =?utf-8?B?YjdRbmlaVzc2UFpnYW9lTHhvN0MySVlUWXpBVkM0QTR2Nkp3eE40SmZtcE5t?=
 =?utf-8?B?c2dWeS9hQ2EvTXU3bFpWQlJ6VVA5OHB6VDlrSFMvRlFHVkIydTVOWXc4YTR2?=
 =?utf-8?B?VmdlR1FXYWNMNUZZWndBWlpHdEFZanZlcnNIYnhGNkhFcE4xeTZtMVRJeFlL?=
 =?utf-8?B?SmhlSHdBaHhKdmg4TGJkK1lZbmQ3Q09mK2lzQUswbTZXM0g2SlVsYVNWVmpp?=
 =?utf-8?B?TEZyWmFDb1dGTzd2MHlFNFA2eVBua1F3RlJ0QWtRbi90d1I2OCtqQW91ZEFo?=
 =?utf-8?B?NjduekhMMlhVQnVaSFJEalZvU3hYSHRzTURNV0VPb016Z1UxMkVlZHBIdng5?=
 =?utf-8?B?bit4YzBJa0dTUFUzcWtkS1ZLM0txbE1JekpETjFzRlY0RFkzQk0xblNXQ0ZV?=
 =?utf-8?B?UFByZmM2d1RqdkMzNGdkM0llckE5aUFZRm9hc2hxNkJBd3JsL2JHUDB3SVN6?=
 =?utf-8?B?SnRlNm5qSlFsUHZ3YlMraGdrZFh1RWpFSXU2S0w2SWtISk5MU0F1dWJ1YVdC?=
 =?utf-8?Q?H1cdHUY/tzif/oRbYa3tL8nBizIbybZ82gCdU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTZQbkVkZngyUWdUM0lOeG5wUzFRVDZVc1AwdjVoODM3VVZNcjl4Y3pOTHVm?=
 =?utf-8?B?L0oyaTQ3TElXVzIrL0F0U04xNFNRanVSSGNDd2wzUHRCenZHU0Jua3FUZmpW?=
 =?utf-8?B?K0plek9xeEU3Qnd3K1A5RnNvemhGTG1oQmpDWHB5dHU1eUpEbDNOZER5SWJC?=
 =?utf-8?B?THpLVW5WS0JtcUhhbENIWEtKTnQvRlRzZ3d0MVg2STR2V0paT0ZpY1ZDcE0z?=
 =?utf-8?B?MzdDandMU1ppTDhYa3JzNXhhU1BCRVRJVlFsRGpYaVVIODlHcDJFWFJZYisy?=
 =?utf-8?B?UWwvbCt2M2FqZnF5NFROU0JvSDhmSXBtV3lXcXBuSFl4eHpOajQrMzhGZ2Z3?=
 =?utf-8?B?aG0ydis4VGdaNUJsRUlSMlpCTXJ4U05ObnhiWllqOER2REFDeXpRZm9DeU1H?=
 =?utf-8?B?Zmpwb2wzb3RQT0JBYWlxZjkvdDZPcDJBNVpYTS8rKzUvYWthWWsrMHRMSHdZ?=
 =?utf-8?B?U1JFWEErdHJ1ajE0MDA3SkFGMW9TWHJTVkFPblBuWHhpSHRCMFl4a3pZOWZH?=
 =?utf-8?B?T2ljdktnNjNnSGdGY0psMlkyTHNtblNYbmIrR0hRYzNQT2xFMjVWakZzY2tP?=
 =?utf-8?B?UldpcFV5SjlBQjczTkd6VzdRVzVURWtkTmlPUkRmZ3V5VDVDM01KRWUzT0ZX?=
 =?utf-8?B?T0pveXNHYWQ5N2V4cXlLWkJCU3NMV0tmSnA1THkxYVROWnFHVktFU1YvVStw?=
 =?utf-8?B?NDNoMlVKNWlBMmRsdEllWWtxZXFRWUFtQmUwSU55bDUwSGxWTGZ6RWR0WDlO?=
 =?utf-8?B?eExPWDhiWUZ2VkJtZUNKazhmeUg2UU9IRFFZTzFXSWd5d2hKRzhCSjJpazZy?=
 =?utf-8?B?NjBhNllRNForMm5LNGUyaUxGWFU2dkd2d0hDWjRCdGkwNWVKcDhxd2hJTXNo?=
 =?utf-8?B?T2RReStZL21Ha1lHL1NRdjdHVnlidk5CTktPcFRHeGFFY1hpWU95SEJrRzNC?=
 =?utf-8?B?STNtSFpaamVJK214WW9KT2NZdEVFQUljTmN4ODF2WklxME92Tm5VckZoSWJ0?=
 =?utf-8?B?UmF2VFJKQ0dISVpFS0lvektPRzV4d050Um42K216THRmRHYzYjFYeUtlRFF3?=
 =?utf-8?B?QU8yMmY3WUV2TVdIUXFIS1JNcjV1QnpIMnZGMzl0c09wdThrZmZVdW8xb1FM?=
 =?utf-8?B?TGJONlpZMmpueHdCSDVnQThSa1cva0h2eWh5Q0RvQzh2MEJER1NkY0tNamk1?=
 =?utf-8?B?a01vcnZEcHlWWE8vR0RRZEpnZ25kOWNoSnExRno4d0pTcGFBRndnWjhvYXds?=
 =?utf-8?B?T0w1aU41c2x3L29IRnNvdzFqVjVBT1ZRb0JackpSV2tTMmFlWVV4cC9uUTN1?=
 =?utf-8?B?eDl3SEYvM3RKNHd4Wmw1UDM3TjR1QVBmQnNuL0tBTnVabGo3OG9PeWdmQTYx?=
 =?utf-8?B?SnZMUHlGLy9INVRkYTlhRktPZEZmRE01V1AzSGdweDBaTTRwdWtxaEtHREFh?=
 =?utf-8?B?WVdiaFl2TWZoRnBkK3JtbjlBdmUwdXhyNFNVb2ROZUZSaXdodkg4RWN6blQr?=
 =?utf-8?B?TWZka3FIQm1DTjRtV1VKYTcyV1NGNkJKRy80Z1JBZmQyTUU4YkV6UDJ3Y3NG?=
 =?utf-8?B?Y2x4K1B0YTJ2Z0o5Q0ZVdkYwZmljMGxhbzhHdjZlN3pjZklvMXVkVnpkUTdQ?=
 =?utf-8?B?YjNrcjhrdklVV2RvWXhsSDJuNFU3VmVTUFdaSElEcDd5ME5qNnVMNm1NWmUv?=
 =?utf-8?B?ejZXd09OWWNFUXJ5aE9rUFhvWEdmc2RjU3U1K1B4amlGQTk5Qi9ISnFkZkhR?=
 =?utf-8?B?WlRmUlhNNHhCS04rK2w3M0xvOTdnVGZ6Wm5rTkZvWE1ZYjdRWHhWM1FsQUFT?=
 =?utf-8?B?d3dVTHZ5KzdNWnZ1TFdIZVYyRi90YTdXSUsvZTNacFRGUkhmOWlXR0p0Ulcr?=
 =?utf-8?B?UlIrUUpmeWt0NHZhYTFmNm9ubllaRDVvWUg4Tm1FcUFnRUhwWWVXVGpIVXlB?=
 =?utf-8?B?M2Y0WjAzYjVqRGZDYTl5YmV6ZXh0c09RbndPOUVlUFZheWVVRlZleFB1dWg2?=
 =?utf-8?B?RlZoZmZuVG5Pa0RZVk9oMlZ3NlE5bjdZQUVDaGJsT2g5TUQ2VUROUzlLWmdK?=
 =?utf-8?B?REpieWV1SDZ5MXpqUzhTVWlhOTBHZnVDcUpiKy9Ca1FBNWovaHo0YWFDNENn?=
 =?utf-8?Q?hAO5x6vmeRFpsh5z6czllhTpX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea620df4-de1d-4138-84de-08ddb9dda4b3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 02:59:36.2134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qdn1mfI7ZhwYuLcPCRK5Odd7UmkTYsedzDqN7y6oK1IgdFzWfhhMkzbJiDjBvoWz64MjV2HExahHZVn/zmPbxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6409



On 16/5/25 15:47, Dan Williams wrote:
> There are two components to establishing an encrypted link, provisioning
> the stream in Partner Port config-space, and programming the keys into
> the link layer via IDE_KM (IDE Key Management). This new library,
> drivers/pci/ide.c, enables the former. IDE_KM, via a TSM low-level
> driver, is saved for later.
> 
> With the platform TSM implementations of SEV-TIO and TDX Connect in mind
> this library abstracts small differences in those implementations. For
> example, TDX Connect handles Root Port register setup while SEV-TIO
> expects System Software to update the Root Port registers. This is the
> rationale for fine-grained 'setup' + 'enable' verbs.
> 
> The other design detail for TSM-coordinated IDE establishment is that
> the TSM may manage allocation of Stream IDs, this is why the Stream ID
> value is passed in to pci_ide_stream_setup().
> 
> The flow is:
> 
> pci_ide_stream_alloc()
>    Allocate a Selective IDE Stream Register Block in each Partner Port
>    (Endpoint + Root Port), and reserve a host bridge / platform stream
>    slot. Gather Partner Port specific stream settings like Requester ID.
> pci_ide_stream_register()
>    Publish the stream in sysfs after allocating a Stream ID. In the TSM
>    case the TSM allocates the Stream ID for the Partner Port pair.
> pci_ide_stream_setup()
>    Program the stream settings to a Partner Port. Caller is responsible
>    for optionally calling this for the Root Port as well if the TSM
>    implementation requires it.
> pci_ide_stream_enable()
>    Try to run the stream after IDE_KM.
> 
> In support of system administrators auditing where platform, Root Port,
> and Endpoint IDE stream resources are being spent, the allocated stream
> is reflected as a symlink from the host bridge to the endpoint with the
> name:
> 
>      stream%d.%d.%d:%s
> 
> Where the tuple of integers reflects the allocated platform, Root Port,
> and Endpoint stream index (Selective IDE Stream Register Block) values,
> and the %s is the endpoint device name.
> 
> Thanks to Wu Hao for a draft implementation of this infrastructure.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Samuel Ortiz <sameo@rivosinc.com>
> Co-developed-by: Alexey Kardashevskiy <aik@amd.com>
> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> Co-developed-by: Yilun Xu <yilun.xu@linux.intel.com>
> Signed-off-by: Yilun Xu <yilun.xu@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>   .../ABI/testing/sysfs-devices-pci-host-bridge |  38 ++
>   MAINTAINERS                                   |   1 +
>   drivers/pci/ide.c                             | 366 ++++++++++++++++++
>   include/linux/pci-ide.h                       |  76 ++++
>   include/linux/pci.h                           |   6 +
>   include/uapi/linux/pci_regs.h                 |   2 +
>   6 files changed, 489 insertions(+)
>   create mode 100644 Documentation/ABI/testing/sysfs-devices-pci-host-bridge
>   create mode 100644 include/linux/pci-ide.h
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-pci-host-bridge b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
> new file mode 100644
> index 000000000000..d592b68c7333
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
> @@ -0,0 +1,38 @@
> +What:		/sys/devices/pciDDDD:BB
> +		/sys/devices/.../pciDDDD:BB
> +Date:		December, 2024
> +Contact:	linux-pci@vger.kernel.org
> +Description:
> +		A PCI host bridge device parents a PCI bus device topology. PCI
> +		controllers may also parent host bridges. The DDDD:BB format
> +		conveys the PCI domain (ACPI segment) number and root bus number
> +		(in hexadecimal) of the host bridge. Note that the domain number
> +		may be larger than the 16-bits that the "DDDD" format implies
> +		for emulated host-bridges.
> +
> +What:		pciDDDD:BB/firmware_node
> +Date:		December, 2024
> +Contact:	linux-pci@vger.kernel.org
> +Description:
> +		(RO) Symlink to the platform firmware device object "companion"
> +		of the host bridge. For example, an ACPI device with an _HID of
> +		PNP0A08 (/sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00). See
> +		/sys/devices/pciDDDD:BB entry for details about the DDDD:BB
> +		format.
> +
> +What:		pciDDDD:BB/streamH.R.E:DDDD:BB:DD:F
> +Date:		December, 2024
> +Contact:	linux-pci@vger.kernel.org
> +Description:
> +		(RO) When a platform has established a secure connection, PCIe
> +		IDE, between two Partner Ports, this symlink appears. The
> +		primary function is to account the stream slot / resources
> +		consumed in each of the (H)ost bridge, (R)oot Port and
> +		(E)ndpoint that will be freed when invoking the tsm/disconnect
> +		flow. The link points to the endpoint PCI device at domain:DDDD
> +		bus:BB device:DD function:F. Where R and E represent the
> +		assigned Selective IDE Stream Register Block in the Root Port
> +		and Endpoint, and H represents a platform specific pool of
> +		stream resources shared by the Root Ports in a host bridge.  See
> +		/sys/devices/pciDDDD:BB entry for details about the DDDD:BB
> +		format.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2fcbd29853a8..e4c3da0b570b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18677,6 +18677,7 @@ Q:	https://patchwork.kernel.org/project/linux-pci/list/
>   B:	https://bugzilla.kernel.org
>   C:	irc://irc.oftc.net/linux-pci
>   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
> +F:	Documentation/ABI/testing/sysfs-devices-pci-host-bridge
>   F:	Documentation/PCI/
>   F:	Documentation/devicetree/bindings/pci/
>   F:	arch/x86/kernel/early-quirks.c
> diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
> index 98a51596e329..a529926647f4 100644
> --- a/drivers/pci/ide.c
> +++ b/drivers/pci/ide.c
> @@ -5,6 +5,8 @@
>   
>   #define dev_fmt(fmt) "PCI/IDE: " fmt
>   #include <linux/pci.h>
> +#include <linux/sysfs.h>
> +#include <linux/pci-ide.h>
>   #include <linux/bitfield.h>
>   #include "pci.h"
>   
> @@ -96,5 +98,369 @@ void pci_ide_init(struct pci_dev *pdev)
>   
>   	pdev->ide_cap = ide_cap;
>   	pdev->nr_link_ide = nr_link_ide;
> +	pdev->nr_sel_ide = nr_streams;
>   	pdev->nr_ide_mem = nr_ide_mem;
>   }
> +
> +struct stream_index {
> +	unsigned long *map;
> +	u8 max, stream_index;
> +};
> +
> +static void free_stream_index(struct stream_index *stream)
> +{
> +	clear_bit_unlock(stream->stream_index, stream->map);
> +}
> +
> +DEFINE_FREE(free_stream, struct stream_index *, if (_T) free_stream_index(_T))
> +static struct stream_index *alloc_stream_index(unsigned long *map, u8 max,
> +					       struct stream_index *stream)
> +{
> +	if (!max)
> +		return NULL;
> +
> +	do {
> +		u8 stream_index = find_first_zero_bit(map, max);
> +
> +		if (stream_index == max)
> +			return NULL;
> +		if (!test_and_set_bit_lock(stream_index, map)) {
> +			*stream = (struct stream_index) {
> +				.map = map,
> +				.max = max,
> +				.stream_index = stream_index,
> +			};
> +			return stream;
> +		}
> +		/* collided with another stream acquisition */
> +	} while (1);
> +}
> +
> +/**
> + * pci_ide_stream_alloc() - Reserve stream indices and probe for settings
> + * @pdev: IDE capable PCIe Endpoint Physical Function
> + *
> + * Retrieve the Requester ID range of @pdev for programming its Root
> + * Port IDE RID Association registers, and conversely retrieve the
> + * Requester ID of the Root Port for programming @pdev's IDE RID
> + * Association registers.
> + *
> + * Allocate a Selective IDE Stream Register Block instance per port.
> + *
> + * Allocate a platform stream resource from the associated host bridge.
> + * Retrieve stream association parameters for Requester ID range and
> + * address range restrictions for the stream.
> + */
> +struct pci_ide *pci_ide_stream_alloc(struct pci_dev *pdev)
> +{
> +	/* EP, RP, + HB Stream allocation */
> +	struct stream_index __stream[PCI_IDE_PARTNER_MAX + 1];
> +	struct pci_host_bridge *hb;
> +	struct pci_dev *rp;
> +	int num_vf, rid_end;
> +
> +	if (!pci_is_pcie(pdev))
> +		return NULL;
> +
> +	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT)
> +		return NULL;
> +
> +	if (!pdev->ide_cap)
> +		return NULL;
> +
> +	/*
> +	 * Catch buggy PCI platform initialization (missing
> +	 * pci_ide_init_nr_streams())
> +	 */
> +	hb = pci_find_host_bridge(pdev->bus);
> +	if (WARN_ON_ONCE(!hb->nr_ide_streams))
> +		return NULL;
> +
> +	struct pci_ide *ide __free(kfree) = kzalloc(sizeof(*ide), GFP_KERNEL);
> +	if (!ide)
> +		return NULL;
> +
> +	struct stream_index *hb_stream __free(free_stream) = alloc_stream_index(
> +		hb->ide_stream_map, hb->nr_ide_streams, &__stream[PCI_IDE_HB]);
> +	if (!hb_stream)
> +		return NULL;
> +
> +	rp = pcie_find_root_port(pdev);
> +	struct stream_index *rp_stream __free(free_stream) = alloc_stream_index(
> +		rp->ide_stream_map, rp->nr_sel_ide, &__stream[PCI_IDE_RP]);
> +	if (!rp_stream)
> +		return NULL;
> +
> +	struct stream_index *ep_stream __free(free_stream) = alloc_stream_index(
> +		pdev->ide_stream_map, pdev->nr_sel_ide, &__stream[PCI_IDE_EP]);
> +	if (!ep_stream)
> +		return NULL;
> +
> +	/* for SR-IOV case, cover all VFs */
> +	num_vf = pci_num_vf(pdev);
> +	if (num_vf)
> +		rid_end = PCI_DEVID(pci_iov_virtfn_bus(pdev, num_vf),
> +				    pci_iov_virtfn_devfn(pdev, num_vf));
> +	else
> +		rid_end = pci_dev_id(pdev);
> +
> +	*ide = (struct pci_ide) {
> +		.pdev = pdev,
> +		.partner = {
> +			[PCI_IDE_EP] = {
> +				.rid_start = pci_dev_id(rp),
> +				.rid_end = pci_dev_id(rp),
> +				.stream_index = no_free_ptr(ep_stream)->stream_index,
> +			},
> +			[PCI_IDE_RP] = {
> +				.rid_start = pci_dev_id(pdev),
> +				.rid_end = rid_end,
> +				.stream_index = no_free_ptr(rp_stream)->stream_index,
> +			},
> +		},
> +		.host_bridge_stream = no_free_ptr(hb_stream)->stream_index,
> +		.stream_id = -1,
> +	};
> +
> +	return_ptr(ide);
> +}
> +EXPORT_SYMBOL_GPL(pci_ide_stream_alloc);
> +
> +/**
> + * pci_ide_stream_free() - unwind pci_ide_stream_alloc()
> + * @ide: idle IDE settings descriptor
> + *
> + * Free all of the stream index (register block) allocations acquired by
> + * pci_ide_stream_alloc(). The stream represented by @ide is assumed to
> + * be unregistered and not instantiated in any device.
> + */
> +void pci_ide_stream_free(struct pci_ide *ide)
> +{
> +	struct pci_dev *pdev = ide->pdev;
> +	struct pci_dev *rp = pcie_find_root_port(pdev);
> +	struct pci_host_bridge *hb = pci_find_host_bridge(pdev->bus);
> +
> +	clear_bit_unlock(ide->partner[PCI_IDE_EP].stream_index,
> +			 pdev->ide_stream_map);
> +	clear_bit_unlock(ide->partner[PCI_IDE_RP].stream_index,
> +			 rp->ide_stream_map);
> +	clear_bit_unlock(ide->host_bridge_stream, hb->ide_stream_map);
> +	kfree(ide);
> +}
> +EXPORT_SYMBOL_GPL(pci_ide_stream_free);
> +
> +/**
> + * pci_ide_stream_register() - Prepare to activate an IDE Stream
> + * @ide: IDE settings descriptor
> + *
> + * After a Stream ID has been acquired for @ide, record the presence of
> + * the stream in sysfs. The expectation is that @ide is immutable while
> + * registered.
> + */
> +int pci_ide_stream_register(struct pci_ide *ide)
> +{
> +	struct pci_dev *pdev = ide->pdev;
> +	struct pci_host_bridge *hb = pci_find_host_bridge(pdev->bus);
> +	u8 ep_stream, rp_stream;
> +	int rc;
> +
> +	if (ide->stream_id < 0 || ide->stream_id > U8_MAX) {
> +		pci_err(pdev, "Setup fail: Invalid Stream ID: %d\n", ide->stream_id);
> +		return -ENXIO;
> +	}
> +
> +	ep_stream = ide->partner[PCI_IDE_EP].stream_index;
> +	rp_stream = ide->partner[PCI_IDE_RP].stream_index;
> +	const char *name __free(kfree) = kasprintf(
> +		GFP_KERNEL, "stream%d.%d.%d:%s", ide->host_bridge_stream,
> +		rp_stream, ep_stream, dev_name(&pdev->dev));
> +	if (!name)
> +		return -ENOMEM;
> +
> +	rc = sysfs_create_link(&hb->dev.kobj, &pdev->dev.kobj, name);
> +	if (rc)
> +		return rc;
> +
> +	ide->name = no_free_ptr(name);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_ide_stream_register);
> +
> +/**
> + * pci_ide_stream_unregister() - unwind pci_ide_stream_register()
> + * @ide: idle IDE settings descriptor
> + *
> + * In preparation for freeing @ide, remove sysfs enumeration for the
> + * stream.
> + */
> +void pci_ide_stream_unregister(struct pci_ide *ide)
> +{
> +	struct pci_dev *pdev = ide->pdev;
> +	struct pci_host_bridge *hb = pci_find_host_bridge(pdev->bus);
> +
> +	sysfs_remove_link(&hb->dev.kobj, ide->name);
> +	kfree(ide->name);
> +}
> +EXPORT_SYMBOL_GPL(pci_ide_stream_unregister);
> +
> +int pci_ide_domain(struct pci_dev *pdev)
> +{
> +	if (pdev->fm_enabled)
> +		return pci_domain_nr(pdev->bus);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_ide_domain);
> +
> +struct pci_ide_partner *pci_ide_to_settings(struct pci_dev *pdev, struct pci_ide *ide)
> +{
> +	if (!pci_is_pcie(pdev)) {
> +		pci_warn_once(pdev, "not a PCIe device\n");
> +		return NULL;
> +	}
> +
> +	switch (pci_pcie_type(pdev)) {
> +	case PCI_EXP_TYPE_ENDPOINT:
> +		if (pdev != ide->pdev) {
> +			pci_warn_once(pdev, "setup expected Endpoint: %s\n", pci_name(ide->pdev));
> +			return NULL;
> +		}
> +		return &ide->partner[PCI_IDE_EP];
> +	case PCI_EXP_TYPE_ROOT_PORT: {
> +		struct pci_dev *rp = pcie_find_root_port(ide->pdev);
> +
> +		if (pdev != rp) {
> +			pci_warn_once(pdev, "setup expected Root Port: %s\n",
> +				      pci_name(rp));
> +			return NULL;
> +		}
> +		return &ide->partner[PCI_IDE_RP];
> +	}
> +	default:
> +		pci_warn_once(pdev, "invalid device type\n");
> +		return NULL;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(pci_ide_to_settings);
> +
> +static void set_ide_sel_ctl(struct pci_dev *pdev, struct pci_ide *ide, int pos,
> +			    bool enable)
> +{
> +	u32 val = FIELD_PREP(PCI_IDE_SEL_CTL_ID_MASK, ide->stream_id) |
> +		  FIELD_PREP(PCI_IDE_SEL_CTL_DEFAULT, 1) |
> +		  FIELD_PREP(PCI_IDE_SEL_CTL_CFG_EN, pdev->ide_cfg) |
> +		  FIELD_PREP(PCI_IDE_SEL_CTL_TEE_LIMITED, pdev->ide_tee_limit) |
> +		  FIELD_PREP(PCI_IDE_SEL_CTL_EN, enable);
> +
> +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, val);
> +}
> +
> +/**
> + * pci_ide_stream_setup() - program settings to Selective IDE Stream registers
> + * @pdev: PCIe device object for either a Root Port or Endpoint Partner Port
> + * @ide: registered IDE settings descriptor
> + *
> + * When @pdev is a PCI_EXP_TYPE_ENDPOINT then the PCI_IDE_EP partner
> + * settings are written to @pdev's Selective IDE Stream register block,
> + * and when @pdev is a PCI_EXP_TYPE_ROOT_PORT, the PCI_IDE_RP settings
> + * are selected.
> + */
> +void pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide)
> +{
> +	struct pci_ide_partner *settings = pci_ide_to_settings(pdev, ide);
> +	int pos;
> +	u32 val;
> +
> +	if (!settings)
> +		return;
> +
> +	pos = sel_ide_offset(pdev, settings);
> +
> +	val = FIELD_PREP(PCI_IDE_SEL_RID_1_LIMIT_MASK, settings->rid_end);
> +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_1, val);
> +
> +	val = PREP_PCI_IDE_SEL_RID_2(settings->rid_start, pci_ide_domain(pdev));
> +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_2, val);
> +
> +	/*
> +	 * Setup control register early for devices that expect
> +	 * stream_id is set during key programming.
> +	 */
> +	set_ide_sel_ctl(pdev, ide, pos, false);
> +}
> +EXPORT_SYMBOL_GPL(pci_ide_stream_setup);
> +
> +/**
> + * pci_ide_stream_teardown() - disable the stream and clear all settings
> + * @pdev: PCIe device object for either a Root Port or Endpoint Partner Port
> + * @ide: registered IDE settings descriptor
> + *
> + * For stream destruction, zero all registers that may have been written
> + * by pci_ide_stream_setup(). Consider pci_ide_stream_disable() to leave
> + * settings in place while temporarily disabling the stream.
> + */
> +void pci_ide_stream_teardown(struct pci_dev *pdev, struct pci_ide *ide)
> +{
> +	struct pci_ide_partner *settings = pci_ide_to_settings(pdev, ide);
> +	int pos;
> +
> +	if (!settings)
> +		return;
> +
> +	pos = sel_ide_offset(pdev, settings);
> +
> +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, 0);
> +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_2, 0);
> +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_1, 0);
> +}
> +EXPORT_SYMBOL_GPL(pci_ide_stream_teardown);
> +
> +/**
> + * pci_ide_stream_enable() - after setup, enable the stream
> + * @pdev: PCIe device object for either a Root Port or Endpoint Partner Port
> + * @ide: registered and setup IDE settings descriptor
> + *
> + * Activate the stream by writing to the Selective IDE Stream Control Register.
> + */
> +int pci_ide_stream_enable(struct pci_dev *pdev, struct pci_ide *ide)
> +{
> +	struct pci_ide_partner *settings = pci_ide_to_settings(pdev, ide);
> +	int pos;
> +	u32 val;
> +
> +	if (!settings)
> +		return -ENXIO;
> +
> +	pos = sel_ide_offset(pdev, settings);
> +
> +	set_ide_sel_ctl(pdev, ide, pos, true);
> +
> +	pci_read_config_dword(pdev, pos + PCI_IDE_SEL_STS, &val);
> +	if (FIELD_GET(PCI_IDE_SEL_STS_STATE_MASK, val) !=
> +	    PCI_IDE_SEL_STS_STATE_SECURE)
> +		return -ENXIO;

The PCIe spec allows (but funnily "does not recommend") enabling the stream before the keys are programmed and one of my test devices insists on doing it this way (the other one is fine) so at least a different code should be used here? Thanks,



> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_ide_stream_enable);
> +
> +/**
> + * pci_ide_stream_disable() - disable the given stream
> + * @pdev: PCIe device object for either a Root Port or Endpoint Partner Port
> + * @ide: registered and setup IDE settings descriptor
> + *
> + * Clear the Selective IDE Stream Control Register, but leave all other
> + * registers untouched.
> + */
> +void pci_ide_stream_disable(struct pci_dev *pdev, struct pci_ide *ide)
> +{
> +	struct pci_ide_partner *settings = pci_ide_to_settings(pdev, ide);
> +	int pos;
> +
> +	if (!settings)
> +		return;
> +
> +	pos = sel_ide_offset(pdev, settings);
> +
> +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, 0);
> +}
> +EXPORT_SYMBOL_GPL(pci_ide_stream_disable);
> diff --git a/include/linux/pci-ide.h b/include/linux/pci-ide.h
> new file mode 100644
> index 000000000000..0753c3cd752a
> --- /dev/null
> +++ b/include/linux/pci-ide.h
> @@ -0,0 +1,76 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
> +
> +/* PCIe 6.2 section 6.33 Integrity & Data Encryption (IDE) */
> +
> +#ifndef __PCI_IDE_H__
> +#define __PCI_IDE_H__
> +
> +#include <linux/range.h>
> +
> +#define SEL_ADDR1_LOWER_MASK GENMASK(31, 20)
> +#define SEL_ADDR_UPPER_MASK GENMASK_ULL(63, 32)
> +#define PREP_PCI_IDE_SEL_ADDR1(base, limit)                    \
> +	(FIELD_PREP(PCI_IDE_SEL_ADDR_1_VALID, 1) |             \
> +	 FIELD_PREP(PCI_IDE_SEL_ADDR_1_BASE_LOW_MASK,          \
> +		    FIELD_GET(SEL_ADDR1_LOWER_MASK, (base))) | \
> +	 FIELD_PREP(PCI_IDE_SEL_ADDR_1_LIMIT_LOW_MASK,         \
> +		    FIELD_GET(SEL_ADDR1_LOWER_MASK, (limit))))
> +
> +#define PREP_PCI_IDE_SEL_RID_2(base, domain)               \
> +	(FIELD_PREP(PCI_IDE_SEL_RID_2_VALID, 1) |          \
> +	 FIELD_PREP(PCI_IDE_SEL_RID_2_BASE_MASK, (base)) | \
> +	 FIELD_PREP(PCI_IDE_SEL_RID_2_SEG_MASK, (domain)))
> +
> +enum pci_ide_partner_select {
> +	PCI_IDE_EP,
> +	PCI_IDE_RP,
> +	PCI_IDE_PARTNER_MAX,
> +	/* pci_ide_stream_alloc() uses this for stream index allocation */
> +	PCI_IDE_HB = PCI_IDE_PARTNER_MAX,
> +};
> +
> +/**
> + * struct pci_ide_partner - Per port IDE Stream settings
> + * @rid_start: Partner Port Requester ID range start
> + * @rid_start: Partner Port Requester ID range end
> + * @stream_index: Selective IDE Stream Register Block selection
> + */
> +struct pci_ide_partner {
> +	u16 rid_start;
> +	u16 rid_end;
> +	u8 stream_index;
> +};
> +
> +/**
> + * struct pci_ide - PCIe Selective IDE Stream descriptor
> + * @pdev: PCIe Endpoint for the stream
> + * @partner: settings for both partner ports in a stream
> + * @host_bridge_stream: track platform Stream index
> + * @stream_id: unique id (within Partner Port pairing) for the stream
> + * @name: name of the stream in sysfs
> + *
> + * Negative @stream_id values indicate "uninitialized" on the
> + * expectation that with TSM established IDE the TSM owns the stream_id
> + * allocation.
> + */
> +struct pci_ide {
> +	struct pci_dev *pdev;
> +	struct pci_ide_partner partner[PCI_IDE_PARTNER_MAX];
> +	u8 host_bridge_stream;
> +	int stream_id;
> +	const char *name;
> +};
> +
> +int pci_ide_domain(struct pci_dev *pdev);
> +struct pci_ide_partner *pci_ide_to_settings(struct pci_dev *pdev, struct pci_ide *ide);
> +struct pci_ide *pci_ide_stream_alloc(struct pci_dev *pdev);
> +void pci_ide_stream_free(struct pci_ide *ide);
> +DEFINE_FREE(pci_ide_stream_free, struct pci_ide *, if (_T) pci_ide_stream_free(_T))
> +int  pci_ide_stream_register(struct pci_ide *ide);
> +void pci_ide_stream_unregister(struct pci_ide *ide);
> +void pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide);
> +void pci_ide_stream_teardown(struct pci_dev *pdev, struct pci_ide *ide);
> +int pci_ide_stream_enable(struct pci_dev *pdev, struct pci_ide *ide);
> +void pci_ide_stream_disable(struct pci_dev *pdev, struct pci_ide *ide);
> +#endif /* __PCI_IDE_H__ */
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index d8dd315d8b4c..d1c901904ee4 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -538,6 +538,8 @@ struct pci_dev {
>   	u16		ide_cap;	/* Link Integrity & Data Encryption */
>   	u8		nr_ide_mem;	/* Address association resources for streams */
>   	u8		nr_link_ide;	/* Link Stream count (Selective Stream offset) */
> +	u8		nr_sel_ide;	/* Selective Stream count (register block allocator) */
> +	DECLARE_BITMAP(ide_stream_map, CONFIG_PCI_IDE_STREAM_MAX);
>   	unsigned int	ide_cfg:1;	/* Config cycles over IDE */
>   	unsigned int	ide_tee_limit:1; /* Disallow T=0 traffic over IDE */
>   #endif
> @@ -605,6 +607,10 @@ struct pci_host_bridge {
>   	int		domain_nr;
>   	struct list_head windows;	/* resource_entry */
>   	struct list_head dma_ranges;	/* dma ranges resource list */
> +#ifdef CONFIG_PCI_IDE
> +	u8 nr_ide_streams;		/* Track available vs in-use streams */
> +	DECLARE_BITMAP(ide_stream_map, CONFIG_PCI_IDE_STREAM_MAX);
> +#endif
>   	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* Platform IRQ swizzler */
>   	int (*map_irq)(const struct pci_dev *, u8, u8);
>   	void (*release_fn)(struct pci_host_bridge *);
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 670314666fdd..0ae7e77313f8 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1286,6 +1286,8 @@
>   /* Selective IDE Stream Status Register */
>   #define  PCI_IDE_SEL_STS		 8
>   #define   PCI_IDE_SEL_STS_STATE_MASK	 __GENMASK(3, 0) /* Selective IDE Stream State */
> +#define   PCI_IDE_SEL_STS_STATE_INSECURE 0
> +#define   PCI_IDE_SEL_STS_STATE_SECURE   2
>   #define   PCI_IDE_SEL_STS_RECVD_INTEGRITY_CHECK	0x80000000 /* Received Integrity Check Fail Msg */
>   /* IDE RID Association Register 1 */
>   #define  PCI_IDE_SEL_RID_1		 0xc

-- 
Alexey


