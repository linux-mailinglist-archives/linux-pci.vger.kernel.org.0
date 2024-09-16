Return-Path: <linux-pci+bounces-13242-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E72197A782
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2024 20:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8324A1F21194
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2024 18:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B1F15B57C;
	Mon, 16 Sep 2024 18:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1nc+MIM8"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1CA15B0EC;
	Mon, 16 Sep 2024 18:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726512969; cv=fail; b=vEeajOHV3k2ZhXa5LlAJI+S7i7skuZB3cYwTWZaAa4VzseQD9SZsWWWhvROoe6DE6AmiS0Tc1Sr5rUrtE0FOGcwk3niFg1InQOyhUY4ohzIcMqLPkF5ElNoC2DVOi3fd6RAfnzbTCIhCCaV1UG/jzODJydm4/pPRSdBWJTVG1bg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726512969; c=relaxed/simple;
	bh=YcGXcme5+t7C07kpqMPLYgB2wDqWSNOtnjss1352vUc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cImMD4XxQptrOdKW6ELPNgcJwfeC5HPfjZuPZsH2c1EZIgjfg/kqKncuOuOrKyv+fwYi2JD/BEDK+bP4pdbKyRRdMzGMW1docwK82R0p5LzcDkJFOlJ12nsWDC2djIRG5vCyZwXPoqaxmFQrIwFaUe9FWyPZuXprXuC/OOF4TCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1nc+MIM8; arc=fail smtp.client-ip=40.107.93.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YfQMBHRu73R+a21ZiAZ+iWkMq1bjfUqzAGOMVN+p5K90BFQO8JZ5V9ywNVLMX7oONamr7SEFnHgCBhL7RYSfMPI8gQRqYP5Mm1MWRbUmkwftb0SrWQveOAOsF10wxthd6hvpE7GKIJDumIAWnteYgQyBQ96MaWntLu17FtOlkLbQsraWfpi8D1ZiUeEkNkJvIp/NRyuYTx9RqBpP15kq0Gigi6OUvPl8YvxPLHzQRfYexH/FAtgqzqY2Uwa6ctimBpHoEhhlM2jwXhf3PEf3KyWG0s5va0DkoP/ouqZ2RkKThNlkNvycw9GLAmvrGWxjf2YPbjMekSOX5Pph55rd+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ha4W59NpmqlhByj8U0MO+0pRl6hub+eIzj17TKynH5w=;
 b=r2fmTnA4CoML5ssL5llfwJ2jgAFHg+6m5R/T1styovI359HzpcGvsADwCBz6HIFqh++VL59ixFzGCUzn7/q5YpYkT0oRFQlC+j+qR3+EPVM+bfElw/oNd3c9dl1OAjKNq13f2WuDdATuUCK/4CogQfoVFe84yrCsln0/VzpvlWwAkxrna+UVbqrxXoyKMH2U2xi4gVAlUelcoFa7CduDY2m2D13f1c9hFNh2dxaiIL5q1JwFI00pITFWQUuQtMZs88aRbhAkU3GtyffkeNg9qjsTJmokzo0l0QVozSzJ7+I9Hl1HBLL/oTcQ7Md6y7ClZyC9hKGoXA+dZm9rTa8MOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ha4W59NpmqlhByj8U0MO+0pRl6hub+eIzj17TKynH5w=;
 b=1nc+MIM8UAf+6cQrPuf5C7RsbrvggAKVd22rYHvv7RO5LMzmah1CbdHksW1VCUdtb92H96ftMvuFfiB9PghzTfe2lcNHQR+M8eulmG6Jq15HXLdKXtSj6kd9plDSRFv0D8fc/HgooQPP/5ial6hCkqMOerNVXVe0f3tG2nwnXq0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4877.namprd12.prod.outlook.com (2603:10b6:5:1bb::24)
 by DM4PR12MB7576.namprd12.prod.outlook.com (2603:10b6:8:10c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Mon, 16 Sep
 2024 18:56:01 +0000
Received: from DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::92ad:22ff:bff2:d475]) by DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::92ad:22ff:bff2:d475%5]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 18:55:59 +0000
Message-ID: <6fb7e2cf-e26d-4af5-84e4-2c56c184a1df@amd.com>
Date: Mon, 16 Sep 2024 13:55:55 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 11/12] bnxt_en: Add TPH support in BNXT driver
To: Alejandro Lucero Palau <alucerop@amd.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Jonathan.Cameron@Huawei.com, helgaas@kernel.org, corbet@lwn.net,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, alex.williamson@redhat.com, gospo@broadcom.com,
 michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
 somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
 manoj.panicker2@amd.com, Eric.VanTassell@amd.com, vadim.fedorenko@linux.dev,
 horms@kernel.org, bagasdotme@gmail.com, bhelgaas@google.com,
 lukas@wunner.de, paul.e.luse@intel.com, jing2.liu@intel.com
References: <20240822204120.3634-1-wei.huang2@amd.com>
 <20240822204120.3634-12-wei.huang2@amd.com>
 <c7b9cafc-4d9d-f443-12b5-bf3d7b178d2c@amd.com>
From: Wei Huang <wei.huang2@amd.com>
Content-Language: en-US
In-Reply-To: <c7b9cafc-4d9d-f443-12b5-bf3d7b178d2c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P223CA0021.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::26) To DM6PR12MB4877.namprd12.prod.outlook.com
 (2603:10b6:5:1bb::24)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4877:EE_|DM4PR12MB7576:EE_
X-MS-Office365-Filtering-Correlation-Id: fa97b492-058a-4215-c875-08dcd6813416
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QXBpdElBNW5xZ3BpNlVXYmU0ZW4wczkyaXZXVEwwOGxsZnY2Y2VFTmNHTE1T?=
 =?utf-8?B?cVBuQUdHRi9Jb2pzUHBTMk9wbXYxOHp3VW1TemlyaEdtQTVWZEdIQ2pqVUdV?=
 =?utf-8?B?Wll2Y1hFb3FoYmNqT1drWGVycEN2blJjWkZsYm0xQ21iS3VvWjJZQ2cxQWRp?=
 =?utf-8?B?c3ExWnFMOGZObXhCWEJDMUlaM3M5TTRZNjlvQ1F0TnRGdDV3TzdpYkdqZ2w4?=
 =?utf-8?B?K3hjbjUrWDZQbkhiNW5wQ2NaL05WbEVLa3RITVhYajBJTDhNNXdZckQ2ZkpJ?=
 =?utf-8?B?azBpby9MSHc1U1RwTFNQcExkUmNoVGNVb09uWXhnUjdzZnFhYTE1ZlFQWVhj?=
 =?utf-8?B?WnpyNUIvV216VW42UEhxdUg2M050eStmZ0s0d09oKzVGQlJnWGhxV3cwOTRI?=
 =?utf-8?B?Q2VTM2FVOHNOMldGMjZhdGxrMTFWdGFtSEVtUjVwbGJIQWNqRGdJQUJMQmUx?=
 =?utf-8?B?NklRSUdMTngwVHdFMW9ldk9pMkV4bHpsMENVRXMrWmp4a1lKN0lobW5NRkd1?=
 =?utf-8?B?N0hXeXNobzlreWJVYXpDQU5KSG9ncDUxQ1c5RXFydkFtQTVOZDA3K29Gb2ht?=
 =?utf-8?B?S0JneEY0S0wyQk5pZGRjYzVlTzcrTlZCOHpsV3daYll5bTNINWw3dnR4OTFx?=
 =?utf-8?B?MzBJcEN6MGk5L0NPZmIvYjNxVXNHU1JXaVRMVXZXSS8vbU41TnFTdWF2NWpG?=
 =?utf-8?B?bjdhdjFySmFQeVNMMHR4M2JMMUJvVkswRTlxT1dTVkZrazVEMC93NU5oMURx?=
 =?utf-8?B?Mk92S1I4YzRyb2c2SElIZmpuWktSNm01VlVvY0FvY29RVnBVRHdzUjI5c3Bk?=
 =?utf-8?B?eXA1VDhKWTh4V3VKZkNHN0lVbXB4UVRzQ20rbUJqV3p4OElSL25PQk9xQys1?=
 =?utf-8?B?Y0VoTmFhRGJjRFJmaktZZElybTFsOHNiVmxXbmxpakxQV0VLVHRZMFg4YllX?=
 =?utf-8?B?dzVaOTByb3p0NVhjYytUSHdna09Cb2NmeUlxd2tMNGdHcjFlNHp6WHlObjNJ?=
 =?utf-8?B?TWxycllsNm9McmNjNWp4SldYM2ZLbEk1dHNZcDd6cEJTRnRKZFo3cFBJZGl0?=
 =?utf-8?B?b3FMRHBIZFdkUkpjRmpqclZkN3R5bUdQSnhjVTN6Vm55QW80SHpKSzhXYlJJ?=
 =?utf-8?B?RlQ3RzBoL2pXSCtUblRrRi9pM0Z1MHluR3gwUjVxNU4yTzBGTGhDZlNzSzFV?=
 =?utf-8?B?MWl3eUVZNnRzQzl3emppN2RYS2U2WUpyRWZFM01xM3NMTklPenE2SjV4Y21V?=
 =?utf-8?B?TWZHeUE2ODlmMVhSQk55Y2s5MWRadlhYczkwOXNRWThJc3MvMU84dGFYbkV5?=
 =?utf-8?B?VVpyMzE1dWtEdTZsOTBpRk5OU3pBbmlFUmN1bkRVNEIvc1dnanNxRlo5d2Q2?=
 =?utf-8?B?S0ZGcUpTVGFpcEJvSmtVZzUvWWpObWJ5RFcrVFVDS3p0aEo2c1pGS01kV0lY?=
 =?utf-8?B?UmlSQjYxNmdGVXJnWTVCOTFPVzFTUWsrb1M4dldNOGFDalRRVVAzZHBaeVA0?=
 =?utf-8?B?anBxd3NQZUVuS2hpVG5kNGtLWU1UcTlIaWFPYXFxNGQ0TW5oRmhySXRwekNQ?=
 =?utf-8?B?YzdMbzZOemtMWHUybGdhSUZXVlowekhPLzdCTzdQb0I1ekYwcHU5WEtqSlRO?=
 =?utf-8?B?VG1qME1UNERVUVF5VTlVdmcvUEtVWDlpcWJhTmV3OVdvOHpmZ3h3VTMrNm41?=
 =?utf-8?B?YkFXMDZuM3ltQzRZc1JCQkNLK24xdzBVVmxRUzd1alZGSE9POE9qYU5GU1cx?=
 =?utf-8?B?YlZQd1NxK1lNTUc2RVBMdTNiUzY3d1luTzY1ZmJlcWorYVVUMWdOSGw3RDUw?=
 =?utf-8?B?bHIrRmJ0RW1jTkxRc3QzUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4877.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SDdJWGpSVFlxZU41bHZ4Tkl4UEVacnJoekwwS2pMZ21nTUFtQkp0dTdBN21l?=
 =?utf-8?B?N0lDdDMxQ0QwNzROTjJ5WnRIZ1o2L3c5RWtwaTZSWGtFNkNzZjFySDd0T2dy?=
 =?utf-8?B?TTlpcmJsL1ExSmw0Q2VwM1ZSZlR4TGRhYitSNXhTUzR4bWtnZk5xeG1qRG8w?=
 =?utf-8?B?OENoc2lwbmdYMXVOQVhJdzV4NUQzcS8wZjJUM29EUU16dWdiSXhXaE9sMFRs?=
 =?utf-8?B?am4zaEVoNGtINThYSW8wVi9kb21MMDJqb3NEUWxITFFDNUF1SDJGTEVmUjk2?=
 =?utf-8?B?T05tR1drMXVJTFZLdWhka2tBS0hTNEl1MHBHU3lmQnk3RDhiaXZ1SUtOSFE4?=
 =?utf-8?B?SU1ZN1VBc1lSb3R6R3FvMFYwMnFZME9LY2tpb0h5SmxQTXBNQ3BZb3JwRmtp?=
 =?utf-8?B?TUVUOGNZUWk1K1NkM1EyTUNjUW1jS09TRlZ1V29ETFRySGVmUVUrN1RPaDMw?=
 =?utf-8?B?WENqWEdaWG9ZMFRFOFNIdk44S29QSm1BZHJkcW0wcm9XWGl3NW5BTDhNdndP?=
 =?utf-8?B?dE5ObEwrNHNGVUJVZTQybUtHekJCOUNCcmo5RnNucHJXbUptazQ0dVZVUkhy?=
 =?utf-8?B?MlFDWmtQTnZtU2Z3UE5kN3ovclRhN216TTk3OGhVa1dpL3R1bmtqTk9SSjRR?=
 =?utf-8?B?cUNDZHE4b1NreDBwV1dlNmI1R09rNVEremp1MUpTcTZ1L05qZ2p0cVIrV2pT?=
 =?utf-8?B?aHlCaTlGZ3hBZk9DaE0yTmlMSFhiQWRIclVIVjdjRld2YTlrM0t1WmQ4akI3?=
 =?utf-8?B?UUd1TU8rbEJUWkxZamd5M3JKOEJOYWtYQ3RsTXg1ZjMyRHRaME96MnRPV0N0?=
 =?utf-8?B?OVdZNXdOZ0NWVUFQOFppSCt5ZFUwQUpsZUdjTyt3bVBRUC9mNmNEeHlJdFdt?=
 =?utf-8?B?ZFBmOWR4L3l0NHdneWY2cld6YWI2V2laVUM2MVg3K1g0QXNYQlF0cmY5aVRD?=
 =?utf-8?B?M0xCU0ZhNEtEZnRqODNiaHpMbnYydWo3QlVnSDRqbFNvemR4NkJIaS9nS2FY?=
 =?utf-8?B?ekFQNkxFcmlodXdaRVpDck1hdE1WbjRxbThISWZ1MlVkZ3JFV1lWN2c4M2h1?=
 =?utf-8?B?b3BxaXBRcUJoYldKUXlsVllQakpTem95Z0MyVGdueGxNeDhSaFd2bXQxUWhJ?=
 =?utf-8?B?SFVJUDg3NXZXU1FIWVR2OXg0bGkya1gvWDFNWEdydTZpbWgzLzFtaW9OZjlm?=
 =?utf-8?B?QlpIZkV5TUdDbFVtYklRYW9tV0t4dUJ0MnU4TDlZdU44T0s1UXF3Tm1WTFdF?=
 =?utf-8?B?VTRvcEpKRzhFN0IydXFGMk4ySUNaU244dGQ4RENZRGthQUZidmQ3cWk5b1Bx?=
 =?utf-8?B?N1hEWDB4SXNBTVowWjIxeWZoT1RVUFF3dnNnUVQrMENxZ3FCYlBQaDZHcUZS?=
 =?utf-8?B?OUo0N3dSN2ZKenBKdHo0OGM4VzVwY1RLZkNyb2ZWa05aNzY2a2NrU3RsQ09B?=
 =?utf-8?B?a21PVnUzWEZ5YUhUb0lOZnBsck0vU2luTlpXSUkxbjc1Y1FKclp3S0NGeWJJ?=
 =?utf-8?B?WVFhNjYrOE9Xd0hwdW1STCtsRFBFOGVLVkNubkFFakQ4VHJMeDM4a1ZmV2dS?=
 =?utf-8?B?S09jSWtMc0xxb1NGU1E3TlkxZ1NpRWYzWlVYL0IvUURKUlRHU0xHRldjKzB3?=
 =?utf-8?B?TU5WbEVhVTAxR0lhQ1BQdVNYaklMZEY4SCtKUHFZYlJXampoMDkzVDEyZ3h1?=
 =?utf-8?B?L1p6bEJZMlQ5WWpvcHVPZWI2Y1RZWjdzendXVTc0ZCtlc004MEpzSzJtV3VP?=
 =?utf-8?B?NkdwMnNNMzBVeURaMm1mclJKMGI2MW4zOG9wNzk3U3hCbi9GQ2phaEJTWnlK?=
 =?utf-8?B?OSttYUhQVWh3M2Z4NGxtMzIzUXczRGhrMEtBbFZEcTV1UnlVeHZ1b1psdWVa?=
 =?utf-8?B?alFwbEdpc0JmU050eXFCWDc3SHV3cm1QTzlnLzZFQ1JQVDZDZHprN1IxRlYy?=
 =?utf-8?B?SW9MNUlDS3BIVXdQK3NNd284WFR3OU5zVVdleC9JcUVvY3AzWXJ6WHJyS0Y0?=
 =?utf-8?B?YnRPV3lyRUl6MEhwalN2SlB0V1hSbjJvdVpJN1V0Zms0L25UMlBPdXpjZkI2?=
 =?utf-8?B?elMySE55d3NNdE9wRWRMQmpINkVGN0FTbDIyR05iRE4vR21CdkJMUXZDMXg1?=
 =?utf-8?Q?kMLQULm7GAJkmI8QN0A7f5PAG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa97b492-058a-4215-c875-08dcd6813416
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4877.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 18:55:59.7804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i1nWBj070rDgAvxm8q+4w1gwCge4TStH6zRayQIb/c1JI0hLRpLSEuX6QYjd8bur
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7576



On 9/11/24 10:37 AM, Alejandro Lucero Palau wrote:
> 
> On 8/22/24 21:41, Wei Huang wrote:
>> From: Manoj Panicker <manoj.panicker2@amd.com>
>>
>> Implement TPH support in Broadcom BNXT device driver. The driver uses
>> TPH functions to retrieve and configure the device's Steering Tags when
>> its interrupt affinity is being changed.
>>
>> Co-developed-by: Wei Huang <wei.huang2@amd.com>
>> Signed-off-by: Wei Huang <wei.huang2@amd.com>
>> Signed-off-by: Manoj Panicker <manoj.panicker2@amd.com>
>> Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
>> Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
>> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
>> ---
>>    drivers/net/ethernet/broadcom/bnxt/bnxt.c | 78 +++++++++++++++++++++++
>>    drivers/net/ethernet/broadcom/bnxt/bnxt.h |  4 ++
>>    2 files changed, 82 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>> index ffa74c26ee53..5903cd36b54d 100644
>> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>> @@ -55,6 +55,7 @@
>>    #include <net/page_pool/helpers.h>
>>    #include <linux/align.h>
>>    #include <net/netdev_queues.h>
>> +#include <linux/pci-tph.h>
>>    
>>    #include "bnxt_hsi.h"
>>    #include "bnxt.h"
>> @@ -10821,6 +10822,58 @@ int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init)
>>    	return 0;
>>    }
>>    
>> +static void __bnxt_irq_affinity_notify(struct irq_affinity_notify *notify,
>> +				       const cpumask_t *mask)
>> +{
>> +	struct bnxt_irq *irq;
>> +	u16 tag;
>> +
>> +	irq = container_of(notify, struct bnxt_irq, affinity_notify);
>> +	cpumask_copy(irq->cpu_mask, mask);
>> +
>> +	if (pcie_tph_get_cpu_st(irq->bp->pdev, TPH_MEM_TYPE_VM,
>> +				cpumask_first(irq->cpu_mask), &tag))
> 
> 
> I understand just one cpu from the mask has to be used, but I wonder if
> some check should be done for ensuring the mask is not mad.
> 
> This is control path and the related queue is going to be restarted, so
> maybe a sanity check for ensuring all the cpus in the mask are from the
> same CCX complex?

I don't think this is always true and we shouldn't warn when this 
happens. There is only one ST can be supported, so the driver need to 
make a good judgement on which ST to be used. But no matter what, ST is 
just a hint - it shouldn't cause any correctness issues in HW, even when 
it is not the optimal target CPU. So warning is unnecessary.

> 
> That would be an iteration checking the tag is the same one for all of
> them. If not, at least a warning stating the tag/CCX/cpu used.
> 
> 
>> +		return;
>> +
>> +	if (pcie_tph_set_st_entry(irq->bp->pdev, irq->msix_nr, tag))
>> +		return;
>> +
>> +	if (netif_running(irq->bp->dev)) {
>> +		rtnl_lock();
>> +		bnxt_close_nic(irq->bp, false, false);
>> +		bnxt_open_nic(irq->bp, false, false);
>> +		rtnl_unlock();
>> +	}
>> +}
>> +
>> +static void __bnxt_irq_affinity_release(struct kref __always_unused *ref)
>> +{
>> +}
>> +
>> +static void bnxt_release_irq_notifier(struct bnxt_irq *irq)
>> +{
>> +	irq_set_affinity_notifier(irq->vector, NULL);
>> +}
>> +
>> +static void bnxt_register_irq_notifier(struct bnxt *bp, struct bnxt_irq *irq)
>> +{
>> +	struct irq_affinity_notify *notify;
>> +
>> +	/* Nothing to do if TPH is not enabled */
>> +	if (!pcie_tph_enabled(bp->pdev))
>> +		return;
>> +
>> +	irq->bp = bp;
>> +
>> +	/* Register IRQ affinility notifier */
>> +	notify = &irq->affinity_notify;
>> +	notify->irq = irq->vector;
>> +	notify->notify = __bnxt_irq_affinity_notify;
>> +	notify->release = __bnxt_irq_affinity_release;
>> +
>> +	irq_set_affinity_notifier(irq->vector, notify);
>> +}
>> +
>>    static void bnxt_free_irq(struct bnxt *bp)
>>    {
>>    	struct bnxt_irq *irq;
>> @@ -10843,11 +10896,17 @@ static void bnxt_free_irq(struct bnxt *bp)
>>    				free_cpumask_var(irq->cpu_mask);
>>    				irq->have_cpumask = 0;
>>    			}
>> +
>> +			bnxt_release_irq_notifier(irq);
>> +
>>    			free_irq(irq->vector, bp->bnapi[i]);
>>    		}
>>    
>>    		irq->requested = 0;
>>    	}
>> +
>> +	/* Disable TPH support */
>> +	pcie_disable_tph(bp->pdev);
>>    }
>>    
>>    static int bnxt_request_irq(struct bnxt *bp)
>> @@ -10870,6 +10929,13 @@ static int bnxt_request_irq(struct bnxt *bp)
>>    	if (!(bp->flags & BNXT_FLAG_USING_MSIX))
>>    		flags = IRQF_SHARED;
>>    
>> +	/* Enable TPH support as part of IRQ request */
>> +	if (pcie_tph_modes(bp->pdev) & PCI_TPH_CAP_INT_VEC) {
>> +		rc = pcie_enable_tph(bp->pdev, PCI_TPH_CAP_INT_VEC);
>> +		if (rc)
>> +			netdev_warn(bp->dev, "failed enabling TPH support\n");
>> +	}
>> +
>>    	for (i = 0, j = 0; i < bp->cp_nr_rings; i++) {
>>    		int map_idx = bnxt_cp_num_to_irq_num(bp, i);
>>    		struct bnxt_irq *irq = &bp->irq_tbl[map_idx];
>> @@ -10893,8 +10959,10 @@ static int bnxt_request_irq(struct bnxt *bp)
>>    
>>    		if (zalloc_cpumask_var(&irq->cpu_mask, GFP_KERNEL)) {
>>    			int numa_node = dev_to_node(&bp->pdev->dev);
>> +			u16 tag;
>>    
>>    			irq->have_cpumask = 1;
>> +			irq->msix_nr = map_idx;
>>    			cpumask_set_cpu(cpumask_local_spread(i, numa_node),
>>    					irq->cpu_mask);
>>    			rc = irq_set_affinity_hint(irq->vector, irq->cpu_mask);
>> @@ -10904,6 +10972,16 @@ static int bnxt_request_irq(struct bnxt *bp)
>>    					    irq->vector);
>>    				break;
>>    			}
>> +
>> +			bnxt_register_irq_notifier(bp, irq);
>> +
>> +			/* Init ST table entry */
>> +			if (pcie_tph_get_cpu_st(irq->bp->pdev, TPH_MEM_TYPE_VM,
>> +						cpumask_first(irq->cpu_mask),
>> +						&tag))
>> +				break;
>> +
>> +			pcie_tph_set_st_entry(irq->bp->pdev, irq->msix_nr, tag);
>>    		}
>>    	}
>>    	return rc;
>> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
>> index 6bbdc718c3a7..ae1abcc1bddf 100644
>> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
>> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
>> @@ -1224,6 +1224,10 @@ struct bnxt_irq {
>>    	u8		have_cpumask:1;
>>    	char		name[IFNAMSIZ + 2];
>>    	cpumask_var_t	cpu_mask;
>> +
>> +	struct bnxt	*bp;
>> +	int		msix_nr;
>> +	struct irq_affinity_notify affinity_notify;
>>    };
>>    
>>    #define HWRM_RING_ALLOC_TX	0x1

