Return-Path: <linux-pci+bounces-28399-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A231AC3B2D
	for <lists+linux-pci@lfdr.de>; Mon, 26 May 2025 10:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EC36174782
	for <lists+linux-pci@lfdr.de>; Mon, 26 May 2025 08:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AA01E261F;
	Mon, 26 May 2025 08:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="k7rcrN3x"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2049.outbound.protection.outlook.com [40.107.100.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4561D6DA9
	for <linux-pci@vger.kernel.org>; Mon, 26 May 2025 08:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748246923; cv=fail; b=T3nIH0aaOY1LmpV3dYYTGZQct2Hrz5iSkpc6s1tLch6XKnZUerxm1zYTuRfobIh45frjOJ1eE66E11F6tnxw6hUQn5ctuqB3676KMCvRC8gv0uDcXlw1HZWV1kzzO5l6ALezQ2uqGNRy4c5fxqrlMRYRcT9MmkSiwmRs7Tyzw6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748246923; c=relaxed/simple;
	bh=uF67+vKwV67rOkUo/0/PfPWytKj55+THVI9wUqACVGo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tzHeUC+EasB6yEX8+cWowmket/dKhoAjgn8S2qDbwSRKicu0MTecywQIwUBfG5JrATSQ0nmpsH2U56dqpLTvBAqPYZrNDZ2JKMlN5bUyLKr7cTVA6kXMPhl/j7xVPyIoF/6Pc4aGP0i+kOz5lM2O5vixuP8+DxKE5/u6y2nFcDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=k7rcrN3x; arc=fail smtp.client-ip=40.107.100.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eCP6quQRz7DT1PS2hEWq8YkhtKeVQ4WZxNwRC8i9SbvSefRls0zJykjH+oRnlHOSRuocdswheT+FacAmk8cQcKSvZauAjwalnkx+XhvXS3Px8wpdjHyHH3Ku7KLgFr2PXIlUpHS+QWWqv4pmwAW/mbP+FrVFHv3LJpwaQPykfDKSJqIyu3Sz8h+w6Kte78AUEDgwRtow+XZ46fQRY0pOGbUC9zYP0fztQvS3xv+iVhRPwy6eSryZvLgtw2b6ItCtYZG3yAT+hx6wXvRAqrX72psI5AEf9M0K7zCw+G39EES39q/lxE3iWbbET/kqJhOtAGjHX5PJ5eTSE/ejVRBsBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6JbUKZDCARzMjgQiEpvvBFuhq5Rjl0GtB1InlOSC7Vg=;
 b=D78QlyyRc2haUs6xNhthyZ62vWFizI6cKANq1iyCw2KLlc1fFqrcG6uyPezIYzsHgPMGK0Cm/XOwfO7n6ft9PrqFGqPpXZhXvBgtKbZRopJH0GbYRSA1nIfVNXQ/WhqyhkvzwnygvbDZwaKzQOGpebThKKm9f95rbBI5grsOtcK33cUynkfLyh/s9TwIjaP6kY0/Lu6a2NHQVby0CReikz1g1hBrJu41qi8MFmaY4pDAYOIUkAchsejQXZ3ycRARXVm24n96zWicdgZ0ksCdEkQYrZ+vFRTBsoFr3rJ+FKDBJNKq5jzQRMO6BlVc5Lfb0RrtihHXn3Hns2+Hvtf4qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6JbUKZDCARzMjgQiEpvvBFuhq5Rjl0GtB1InlOSC7Vg=;
 b=k7rcrN3xMb7zaM+drEaBg2cx/n2274qrzjTyC3hhzuWqyV1syUmbXltVkkdwA2d64yCeIAjBQiHBtyMJ8smrPfltzJHyiQflLFUoxdlYlRO3e2a95EqooQo626AolZbOB90q2iT4f6EUzx+iCrFlpJLtHj+tbC7v0L2RwA83IEE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by CY3PR12MB9679.namprd12.prod.outlook.com (2603:10b6:930:100::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Mon, 26 May
 2025 08:08:39 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.8769.022; Mon, 26 May 2025
 08:08:39 +0000
Message-ID: <2fb2de7a-efc2-4ab0-8303-833dd2471d9f@amd.com>
Date: Mon, 26 May 2025 18:08:33 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v3 12/13] PCI/TSM: support TDI related operations for host
 TSM driver
To: Xu Yilun <yilun.xu@linux.intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
 gregkh@linuxfoundation.org, lukas@wunner.de, aneesh.kumar@kernel.org,
 suzuki.poulose@arm.com, sameo@rivosinc.com, jgg@nvidia.com, zhiw@nvidia.com
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-13-dan.j.williams@intel.com>
 <153d5223-169d-4379-bc2c-6ad279489560@amd.com>
 <682ce21c17363_1626e1004e@dwillia2-xfh.jf.intel.com.notmuch>
 <aC2c1SggkqKSO1st@yilunxu-OptiPlex-7050>
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <aC2c1SggkqKSO1st@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0072.namprd13.prod.outlook.com
 (2603:10b6:806:23::17) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|CY3PR12MB9679:EE_
X-MS-Office365-Filtering-Correlation-Id: df424628-be87-4a87-ef82-08dd9c2c8573
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0FHdWRqZXFnbWJWYXJ6Y05YSUt5SXVxQ2Qxb0tocTlkUzErdnpxLzBEQUk5?=
 =?utf-8?B?WmV1d2Y4dU0wRTFYeUpjTkQrM1dhd25kMS9ORXVNdGNTS3huZHpRbldLWVZZ?=
 =?utf-8?B?SWxZd0NnYVhVM1FWNG80RzJidnQrMExBNUkyQkR6ZUMyejNld0E2Z21CVytD?=
 =?utf-8?B?alJyNVpLYUNKM0MvQ1R3eUpzcDc5UExIcUp6a2c0Z1U4dGJFU1dnTUxaSXlX?=
 =?utf-8?B?Tzh0Y2tLc29kZlBMNFR5cFQ3SGRTMVAwK1ltZ0toNmZPUUd2Z3puVkZpTVpm?=
 =?utf-8?B?ZWpleWp5d2dRVStkUUFXSE5rRUYwVVZjUFZPamg5VGNNQW1ORzV2dVE1NENp?=
 =?utf-8?B?dVVJcEM0SzNidWhrMTdVNFkvQ29KeWp4azh1TXNXUEVCVnVOcCs5V2h3cUQw?=
 =?utf-8?B?eVlKa1ZvajM3d3dNVGVUcHAzenB1Sk1YMndCK2VSbDVSZHBUOCtqd1ZSVTBG?=
 =?utf-8?B?M29iV0ZmanhmUE15ZVBuakVFa0V3WnFPZElmL2wrSUxBOGJsNHZkaE5SY2Zo?=
 =?utf-8?B?WUtlU0RVZkY0Q05LdnF1OWZLMFRnKzBsSDMyTkRCQlZiUFZVVmpqRUJVZGdF?=
 =?utf-8?B?RHVWdFIwb3lYZ0xZQ21XNlAzclhQVnREU0pzSW0rck1hZzVKL2NFTEdtbVRm?=
 =?utf-8?B?U0VTYURDSmJ6bjNsbitvSFZFUjVhYThlZVpEWkd4OWF3T1I0NytETzQ2R3c4?=
 =?utf-8?B?NzdyeFIwT3VZV05xODFKMHRKMXZUV05EVEdhMWp6byt2T2czQkl5Z0E4K29M?=
 =?utf-8?B?SVJXbGhwRUduSm5OK3VUNjdSdkJ4VVA4WHdwYXRzc3FjZDBDaWRzZ1ZNYTB0?=
 =?utf-8?B?TTNoWWUvT0QwZmtKNWVFZFNuVEZKVzRuVGtzRXRnYUJFYU8xbHd2UHUwRVhP?=
 =?utf-8?B?M1lXWlc3TEpPcUdYWVZwVGFZTVdySjNrQXh4ZUFSOTVCeW9kMU91NFZOT3hV?=
 =?utf-8?B?RzlhekdIUGlUZ3NDMlg4bHpmOTRtdWlyRjlkQkpMd0ttM2NwS0QxRTV6eTAz?=
 =?utf-8?B?NUNyeExYVGRaZWk5LzFFUUNFc1B1Wjc2VmtiYzRWZ2RkWE4zdkhWOHhtTDFB?=
 =?utf-8?B?S292L3VZNnR2Z1ZLMWpwRGhxMk5nTmM5ZVNyenFQd2JSR21UejlnbzZCUk9w?=
 =?utf-8?B?SUdoZTFLZlF2YVp4MkVDc2FNLzhZME5qNjc0MUFJaVBwcFJEeGRqUnVmNWE1?=
 =?utf-8?B?Q1JWd0daTUpvK2dhNzhRMFVCZWhxS0tjaVIzYkN6MmZaVVI1cGx6R1JYcWdB?=
 =?utf-8?B?UnFPS09NSklkTUFLKzQzWGpTN1V1RC93dUdMMWc2VU12MThnYkpwNzBaOFdr?=
 =?utf-8?B?U2VyRm9VYnpkVFE2SUpic0NScHFZZ05YemlpcmQzNFA2RzB6Ykw0Wk5QRWQ0?=
 =?utf-8?B?WG1oeE5qczUzcmh3TVFvREtlRysrVHJkaDJwbVdFcWZBZjNVWElMOGxwVnFj?=
 =?utf-8?B?aG1vTlZuRXZKSThVU0JlQUQ1L1RJb0tBaFZDZ0ZzNkV3enJSNVByYkNZMjdx?=
 =?utf-8?B?Mysxbkc5bkhCTlR4N0l2STl4QTVPUFJrRWV4L1VBUUt0dHgrbXpYa3FzTU9D?=
 =?utf-8?B?N3Y4RUdCOTRHOXkxUWlKQWdPQnRIc0hzaHViOWsyNU9CM3c0ZnZVUVdFMVpC?=
 =?utf-8?B?dlRib2plTlFVWUtQWmY2WDNrZGtwcmtHSUpGVmlLekM3S2Q0aERmYXU5MWlJ?=
 =?utf-8?B?S3d5cHQrM3Q1a1RHK3hBaVhpUC9DVjFwZzNBTzFGVXplV2h0a3VWTU9RWmR2?=
 =?utf-8?B?SkdxWjRjMUMvdW4rWGxKbFd5SWxhU0hWMENQK0ZNTEc3d0Z5NHdnbFpVZVJI?=
 =?utf-8?B?TmhqR2ZHQ1dreXBZS1l5d1cvS1NlNTQ5bWlFdkNScFNXT0NYUHZMamNyUmJM?=
 =?utf-8?B?RmFVYjE5L25XOENqUWQzdjc5TnR3NE1wckRBcFVPRnRiYlJsUHpNNVpoY1hW?=
 =?utf-8?Q?JAwsifVGCl4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YjRYYWRubDMzNE9qNUIra3doaEFwU2dZTDJCUDhMcVZCOEJEdEYrY1F3TU12?=
 =?utf-8?B?VFN5WE5jNjFHOXhtMnZRY0ljSlBwSXNOTy8xbW1sSmREdVZoUE5NUEliUlM1?=
 =?utf-8?B?K0QrRmtkNjJKRUVGWXBEU1hCTGJEZWtHRTUyeTU2bjRHZmVBdnVpTW4vQnM0?=
 =?utf-8?B?UnFleTNjbnFVQWNmYlZjaGowbEg4YlNETzQvaGRpcEc2RzhoNDl5bU53K2d0?=
 =?utf-8?B?WTBkYklMdzNySmdkUzVlR1h3SGorM2VWVnZQbzdpaFV1UjJramVGZDk3cU50?=
 =?utf-8?B?bnZwVVl3QThVcVJremRDVUIrRSt2bUpuenpkSEtYL2NzUVNpRmFIRXpIbVY4?=
 =?utf-8?B?cDBUbFBPVWZybVVNMVN6eTcwTEhESHhGUFU3RCtZYjlMM1BoY1FqZjdtOGUw?=
 =?utf-8?B?S3ZYUURlRVZkTDZjbEM5UUQrVmM0aml6S1VxS0pKUHVhR3lnZlNjUjF1TzlE?=
 =?utf-8?B?TjQ0MEFqMTYzbkhZaVV5Rll3UCtDSDl0L3U3QUo5MExPZjJZSk5YamdoNUlC?=
 =?utf-8?B?aFNtdFFQSmU2YjNCRTRtM0lsYnFnRnVIT2tyRnJQL25ZMWh4SS93QUN1UGY2?=
 =?utf-8?B?clowMmpsenJxVXd4akJkODByckduUmN3YU5mQi8zQXl2TmFhb0lSYkpDRFBG?=
 =?utf-8?B?Z1FBdHhQTEp2TWxtUGgvTUNOOUZlVTkrYm92NnpnNHB1R2NscW9raDExK1Zh?=
 =?utf-8?B?N1Y5SnQ5aXlzcXpvYkl0TkY5N3FNWFZwcmRUa0lGcy8yNVZUZkFkdlcxb2p4?=
 =?utf-8?B?eW52TTlVcFlRa2ZwQ2dkeWovSVBoU0V3cDBheWhSdmlZL0htc1lDWlpCbFp1?=
 =?utf-8?B?ZjNZTVY1UGFZaC8xSFZGdk5VWXpXaGh6T1Z6Y25RSjMzaDBkTXlWdVZLOElz?=
 =?utf-8?B?bXdGVVRPRW9xN21ZWHRJQmMvakp5QjBTbFBlcTU0ODYzQWdtbGJhS2l2NWRN?=
 =?utf-8?B?QlBLV3J2dUpaQXMxdi94ODErN3grMU8yeTdQck1uUmg2emtyQmwvNzREV1Ja?=
 =?utf-8?B?QldHYjFjUkRhRzkram1FWFhSamhtWURWdGQzR05oUk5nSmMvVWRiYVpNeFBw?=
 =?utf-8?B?OUp6Mldjamx6QWU2cEIzWkFFQWgza1p0RmxhMTZLeWg0ZGNRdUtCVUpIQ3hU?=
 =?utf-8?B?blVsRTYxVE11VFVqM1o5a0RMVWdmQ29QbWJ4SE5jNEtJdkdCQTQ4OW04WVRS?=
 =?utf-8?B?aDB2OGtvTkVCcVFZa3djeG93bStkWWdLYkJGTDdGaEQrRHpDRkVoUWFsOHBI?=
 =?utf-8?B?azhUUFZZL1Z5WjcrdCt3YVlIc2lyUjd2aSttbGxZZ1gxSEEzQmxWV1NnZVhP?=
 =?utf-8?B?UkpoeWZwdk0vK0hmY2pRMGdBTGsrSlRrL09zUUFtaWhhMmhXeHF2N05iV0Va?=
 =?utf-8?B?MGR1Q2tFaHRtakdCdzRHMytvb2ZzemNQOFRtcFM4VVhBTlVNNUxEV3hndWJ1?=
 =?utf-8?B?TzYvdGE0ZDhwc1pCaGJZcmtyNWVZanMyMlVlUkRHb0plK3Vpd3h4Tlo5elpW?=
 =?utf-8?B?YUNHZHZKVWtqdlZoOGpYN3N2L3JsS1FERytMc3pjM1QzaVU2NENHOXlsWVJG?=
 =?utf-8?B?aDJONnMwbnN0aDNIeE9mT0JVaUxEL21sK2ZNWndldTNHalVoa2l6b1ZJSkIy?=
 =?utf-8?B?T05JVW9rbHJWWXU5K3ZlcFRDRjB3R0tBTUNEM0R0dWdsZnEwUmRub0JmYUtT?=
 =?utf-8?B?bEt5OFlkeDF5VGszRHUwNHBnSWNqR24xdmFtV0FZQkNSRXQzeC9yYnY4Y3cz?=
 =?utf-8?B?RDhXTG4vZ293a1hldFMrTXZFM25qK3FrZ2xmY0hUSG16U2xVa1ZqRkFsNXVl?=
 =?utf-8?B?S2dPZUVzZlQ4RnZlMklBdytTbWNxVmduUndpUjRzRlpuRXRtOG5QOTMwUU4y?=
 =?utf-8?B?VU9EUFJqaFhpaFNYeFV5SmlzWkxVZFdkTFhieVNnTmdHbUJKK0sxMlVvV24r?=
 =?utf-8?B?N3BjaTFxRnh3TlN0eFBSc2ZLcVpGcFI0SC9TZUdHejUyak5CWlN3eHBtMkNS?=
 =?utf-8?B?Snk5c29HN3JTLzgzK0Z3VFJnTFBKbVZTQXAreE9taGgrTWc2di8zNnYzYnpK?=
 =?utf-8?B?cTk4UXZTQUJwWmJzN3ducHFDN2FuUVFUWWdsN1ZsUmViZCtVVkRQV0lhK3By?=
 =?utf-8?Q?+Nlf4I0QaaCiW5hICWMUJZPmZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df424628-be87-4a87-ef82-08dd9c2c8573
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 08:08:38.9761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1zL7pVjtMM5F1615zIZ+xyTRK4a/0WzLAwK2HBhKeSq3r3JkbTxZIP0F0FMJbF01IQAroc91uU/3DtTSY8M5/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9679



On 21/5/25 19:28, Xu Yilun wrote:
> On Tue, May 20, 2025 at 01:12:12PM -0700, Dan Williams wrote:
>> Alexey Kardashevskiy wrote:
>> [..]
>>>> +int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u64 tdi_id)
>>>> +{
>>>> +	struct pci_tdi *tdi;
>>>> +
>>>> +	if (!kvm)
>>>> +		return -EINVAL;
>>>
>>> Does not belong here, if the caller failed to get the kvm pointer from
>>> an fd, then that caller should handle it.
>>
>> Sure.
>>
>> [..]
>>>> +static int __pci_tsm_unbind(struct pci_dev *pdev)
>>>> +{
>>>> +	struct pci_tdi *tdi;
>>>> +
>>>> +	lockdep_assert_held(&pci_tsm_rwsem);
>>>> +
>>>> +	if (!pdev->tsm)
>>>> +		return -EINVAL;
>>>
>>> Nothing checks for these errors.
>>
>> True this function signature should probably drop the error code
>> altogether and become a void helper. I.e. it should be impossible for a
>> bound device to not have a reference, or not be in the right state.
>>
>>>
>>>> +
>>>> +	struct pci_dev *pf0_dev __free(pci_dev_put) = tsm_pf0_get(pdev);
>>>> +	if (!pf0_dev)
>>>> +		return -EINVAL;
>>>> +
>>>> +	struct mutex *lock __free(tdi_ops_unlock) = tdi_ops_lock(pf0_dev);
>>>> +	if (IS_ERR(lock))
>>>> +		return PTR_ERR(lock);
>>>> +
>>>> +	tdi = pdev->tsm->tdi;
>>>> +	if (!tdi)
>>>> +		return 0;
>>>> +
>>>> +	tsm_ops->unbind(tdi);
>>>> +	pdev->tsm->tdi = NULL;
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +int pci_tsm_unbind(struct pci_dev *pdev)
>>>> +{
>>>> +	struct rw_semaphore *lock __free(tsm_read_unlock) = tsm_read_lock();
>>>> +	if (!lock)
>>>> +		return -EINTR;
>>>> +
>>>> +	return __pci_tsm_unbind(pdev);
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(pci_tsm_unbind);
>>>> +
>>>> +/**
>>>> + * pci_tsm_guest_req - VFIO/IOMMUFD helper to handle guest requests
>>>> + * @pdev: @pdev representing a bound tdi
>>>> + * @info: envelope for the request
>>>> + *
>>>> + * Expected flow is guest low-level TSM driver initiates a guest request
>>>> + * like "transition TDISP state to RUN", "fetch report" via a
>>>> + * technology specific guest-host-interface and KVM exit reason. KVM
>>>> + * posts to userspace (e.g. QEMU) that holds the host-to-guest RID
>>>> + * mapping.
>>>> + */
>>>> +int pci_tsm_guest_req(struct pci_dev *pdev, struct pci_tsm_guest_req_info *info)
>>>> +{
>>>> +	struct pci_tdi *tdi;
>>>> +	int rc;
>>>> +
>>>> +	lockdep_assert_held_read(&pci_tsm_rwsem);
>>>> +
>>>> +	if (!pdev->tsm)
>>>> +		return -ENODEV;
>>>> +
>>>> +	struct pci_dev *pf0_dev __free(pci_dev_put) = tsm_pf0_get(pdev);
>>>> +	if (!pf0_dev)
>>>> +		return -EINVAL;
>>>> +
>>>> +	struct mutex *lock __free(tdi_ops_unlock) = tdi_ops_lock(pf0_dev);
>>>> +	if (IS_ERR(lock))
>>>> +		return -ENODEV;
>>>> +
>>>> +	tdi = pdev->tsm->tdi;
>>>> +	if (!tdi)
>>>> +		return -ENODEV;
>>>> +
>>>> +	rc = tsm_ops->guest_req(pdev, info);
>>>> +	if (rc)
>>>> +		return -EIO;
>>>
>>> return rc.
>>
>> Agree.
>>
>> [..]
>>>> @@ -86,12 +101,40 @@ static inline bool is_pci_tsm_pf0(struct pci_dev *pdev)
>>>>    	return PCI_FUNC(pdev->devfn) == 0;
>>>>    }
>>>>    
>>>> +enum pci_tsm_guest_req_type {
>>>> +	PCI_TSM_GUEST_REQ_TDXC,
>>>
>>> Will Intel ever need more types here?
>>
>> I doubt it as this is routing to a TDX vs TIO vs ... blob handler. It is
>> unfortunate that we need this indirection (i.e. missing
>> standardization), but it is in the same line-of-thought as
>> configfs-tsm-report providing a transport along with a
>> technology-specific "provider" identifier for parsing the blob.
>>
>>>> + * struct pci_tsm_guest_req_info - parameter for pci_tsm_ops.guest_req()
>>>> + * @type: identify the format of the following blobs
>>>> + * @type_info: extra input/output info, e.g. firmware error code
>>>
>>> Call it "fw_ret"?
>>
>> Sure.
> 
> This field is intended for out-of-blob values, like fw_ret. But fw_ret
> is specified in GHCB and is vendor specific. Other vendors may also
> have different values of this kind.
> 
> So I intend to gather these out-of-blob values in type_info, like:
> 
> enum pci_tsm_guest_req_type {
>    PCI_TSM_GUEST_REQ_TDXC,
>    PCI_TSM_GUEST_REQ_SEV_SNP,
> };


The pci_tsm_ops hooks already know what they are - SEV or TDX.


> /* SEV SNP guest request type info */
> struct pci_tsm_guest_req_sev_snp {
> 	s32 fw_err;
> };
> 
> Since IOMMUFD has the userspace entry, maybe these definitions should be
> moved to include/uapi/linux/iommufd.h.
> 
> In pci-tsm.h, just define:
> 
> struct pci_tsm_guest_req_info {
> 	u32 type;
> 	void __user *type_info;
> 	size_t type_info_len;
> 	void __user *req;
> 	size_t req_len;
> 	void __user *resp;
> 	size_t resp_len;
> };
> 
> BTW: TDX Connect has no out-of-blob value, so should set type_info_len = 0


No TDX Connect fw error handling on the host OS whatsoever, always return to the guest? oookay, do not use it but the fw response is still a generic thing. Whatever is specific to AMD can be packed into req/resp and QEMU/guest will handle those.



>>
>> [..]
>>>> @@ -102,6 +145,11 @@ struct pci_tsm_ops {
>>>>    	void (*remove)(struct pci_tsm *tsm);
>>>>    	int (*connect)(struct pci_dev *pdev);
>>>>    	void (*disconnect)(struct pci_dev *pdev);
>>>> +	struct pci_tdi *(*bind)(struct pci_dev *pdev, struct pci_dev *pf0_dev,
>>>> +				struct kvm *kvm, u64 tdi_id);
>>>
>>> p0_dev is not needed here, we should be able to calculate it from pdev.
>>
>> The pci_tsm core needs to hold the lock before calling this routine. At
>> that point might as well pass the already looked up device rather than
>> require the low-level TSM driver to repeat that work.
>>
>>> tdi_id is 32bit.
>>
>> @Yilun, I saw that you had it as 64-bit in one location, was that
>> unintentional.
> 
> Intel is also switching to gBDF as tdi_id, so yes 32bit is good.
> 
>>
>> Note that INTERFACE_ID is Reserved to be 12-bytes, but today FUNCTION_ID
>> is indeed only 4-bytes. I will fix this up unless some arch speaks up
>> and says they need to pass a larger id around.
> 
> Yes.

yeah, 4 or 12 bytes make sense but not 8. Thanks,


> 
> Thanks,
> Yilun
> 
>>
>>> Should return an error code. Thanks,
>>
>> Lets make it an ERR_PTR() because the low-level provider likely needs to
>> allocate more than just a 'struct pci_tdi' on bind.

-- 
Alexey


