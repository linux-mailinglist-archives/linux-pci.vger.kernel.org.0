Return-Path: <linux-pci+bounces-17185-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C19D9D5561
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 23:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D55F283DDB
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 22:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168571D0E20;
	Thu, 21 Nov 2024 22:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HfS9cCsi"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FF61ABEB0;
	Thu, 21 Nov 2024 22:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732227941; cv=fail; b=d/mD9FTZGCoDXg3IV1QCqkQgClAK8dGBlqmAiq0E8kerCaruwREg0TGgFwQ+XOZpT/XIbdSJoGsUcq70uvrazwoNV0fhjH4Dt4azxMkcwX77ElVuZFfgkQLD/lzr/zf+4wfUsepFeDbQXoltcacP/G6vRIdg+0cFcUFnUgcPYrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732227941; c=relaxed/simple;
	bh=QnrBzTNYTVwFZ0pgWZGTP+l4M9JE8Qbqb5SBXQGQlLQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QAEvjV2WSbBNG7JpNvHEEEQ+nLNJ9MSlpkUMAh9GtFNidFjuZ+2qvU4coyheGTSLHD/VFDUyuoduSC72HDGs4vP8CqQjGSIDI3vnP8r1IIM+c9HKumR0H7LKtLtChcbhD26QXTmECCGY6UMipqZil7QCO6TF6Us+1AgJDvVVJFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HfS9cCsi; arc=fail smtp.client-ip=40.107.220.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T41mOzW5RyKWAhDfVlvvlrpIM8bNzs+1QfT5W5EXcVaBakSmtdBb+FadwuBWG74YQezMJ4A+DJFQQTNxAwSNBiGdYfDtpirUEBZgQMk44VvDNKIXn09NWf3bH1vqrEHfCbQRXpi/2n78xbCjb+7sT/CAp3JIMkBq5qzYKb3GFtIaP7FlTOEfbhwaxuwcLxtc1PqUQ4hMOugcA5OHnGA+fuGL6TG1SZctawpjMoM3eApxs017FjsGd6E80g2Oj0/IQpTHhV7hLU7KB93Wn5Q0Yvfpu8vhcHKRzRZVIWbxwgo70Fizxtc9v7keg3+PZhR0xCEsFBq37rdjkx5Sg55g2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVd4qNzH1goORaLOX7vgkVKoFHcKbkMXgIKcS3IQwS8=;
 b=hzHatyTeXsfmXP2mtfhYLFv3ITLvCQiZHIaTBgSy1rewH5F5rSPUpsH1XKbaR6Dp8goZ166tFKZ9wdW0leBGxUDv1d/MVRZhWKcucpx0p+5p9vsrjWkgee3Mkr4adOAo6xea72O2sj7gMksbN6Wjec1Ioo2aGzbYMe7/2YaUiZpENXGHmrO0XoeQ94UcgGv89o2ygRwyvvg9GBG5VjDp+912Qawd6/jgOLJ/P2sYe7N4/ABn7BKSVDgV28mPS5dN63hOSpI5Iimdxo4yy2a7dMevC8PeRCosdFkn71FuWgEh/PNS3KpuNiohyrofDsyQ4bFnX6eQTu/PMmDEfd63qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVd4qNzH1goORaLOX7vgkVKoFHcKbkMXgIKcS3IQwS8=;
 b=HfS9cCsif3IhF9GlURgXUMgFNvM7hfFjpjdwHQkMaeD7bGhZRyWf4s4bIrIH70o5KAekisH6KScTzL9z6C4gStsYqCxI2EeBU0j+6PYCHLMIjnDI8wJQO97wa9kWpRuL9MCrOyONbzzYDHcovV36c3Q8UswtEczyjnFusnxM2hc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 BY5PR12MB4305.namprd12.prod.outlook.com (2603:10b6:a03:213::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.27; Thu, 21 Nov
 2024 22:25:35 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%3]) with mapi id 15.20.8158.023; Thu, 21 Nov 2024
 22:25:35 +0000
Message-ID: <4529f2a2-e655-4906-8e21-8d5d90db4468@amd.com>
Date: Thu, 21 Nov 2024 16:25:31 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/15] PCI/AER: Enable internal errors for CXL upstream
 and downstream switch ports
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, nifan.cxl@gmail.com, ming4.li@intel.com,
 dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com
References: <20241113215429.3177981-1-terry.bowman@amd.com>
 <20241113215429.3177981-16-terry.bowman@amd.com> <Zzsq6-GN0GFKb3_S@wunner.de>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <Zzsq6-GN0GFKb3_S@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0028.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::30) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|BY5PR12MB4305:EE_
X-MS-Office365-Filtering-Correlation-Id: f11b8842-8af6-44e9-233e-08dd0a7b6b48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dGJ0Nnh2MFB2c1RuMlJNSWdYbXNQSFEzaXE1OXc0d2lEN1NHNW0vY1BqVXd6?=
 =?utf-8?B?MG9GMVU3UTVLTktVZ1cydFNWR2sySHpoMmgyUTlsUmVSQldrNkI3YW55Z0xx?=
 =?utf-8?B?UWUzcjVzNzJUYjdiY0gvTVdiZjRUNG1EdlYrNERkdjFraFQva0UvbzBMNkQr?=
 =?utf-8?B?U3hsVzNwS0thcFM5bjdwMEZIbGJ2NnV1U0x2RTNKOUhuRVh6emFQYzkwVG5Y?=
 =?utf-8?B?NlVzV1RXTzQrck5zeUFKbEVqNUxOZFRERDc5UUVZS1BvZ1pFallnSFVaQlZO?=
 =?utf-8?B?N0I3RjZhcld2bWdlOGcxYjZaM3JzNHkzT3l2K3d1eWVvQXY4N2hhTU9ZWlc4?=
 =?utf-8?B?MVoyL2dUL2JuK0pvbHY0aE5Ja21NOUdCZURPd3FzU0RiVnhrOTZOVFdKN3Ew?=
 =?utf-8?B?ZkgwcEo2bnIycEdhV01QSlBGS2dZK1NQZDMwSzRYMlFPYVJTY1gwSmVFWnM4?=
 =?utf-8?B?NFN5VzZEUGw2ZlhTdXB5WS9oYWlpaHdqTk5BZkdKVHpVeGZwd2hseXZRQ0RP?=
 =?utf-8?B?Mm5OMzN5Z21DQ1RxcEp2UmgxMjRTd1ZSRzJaRWI5dVk0Wk1oTEE2MTJBQ281?=
 =?utf-8?B?bXV0Qy9aenptd0ZrREZWZXJhOXdhb3ByL2FrNEZ3RFBTQURMUFJUTGpNSmpR?=
 =?utf-8?B?MlpvOTRHb1o2NkNEaWsySk16SVd3Qk5HN3RQSGVtN1ZQYUNtQVpIL05XdnZR?=
 =?utf-8?B?VVB5c0JSZ0k1QW4rRDZ0NjNwT0FFQWpWaXU5ejQwdWc5UGZVdzkrU0JMVVVJ?=
 =?utf-8?B?OGU2VEFvMWdyVVhndGlXTGhvODc3bnkzOXJMRlVPanRNYWE2ZUh5aExwdkt4?=
 =?utf-8?B?cWpCK3NBQVlXZGpMZThPYjhubjNkU1N0b2Z0VmxWUGs5TmRUS0V0cmpJcFN1?=
 =?utf-8?B?Zkh2VEIxWko4V0ZhanozdndRKzh6eitxWWg4bWFjVjFhajk4Zmk4ZlJkb3Jy?=
 =?utf-8?B?UGpkY0d6SWlUeFFvZEVwQzZDaWVUcWVmcjVCdDlZRTlyMG01aXRwcDVQVE9J?=
 =?utf-8?B?eXVtak83cnNyM2V1WGo1empmTFNzRXk2RFAxUjhqUDRWM1lCSERYZHA1UTVG?=
 =?utf-8?B?Y0hkQllhdk5YeVZBWENsdUticHRjQUIvOWc1U0ZCZUdMbFR4WTJGNzZRcWpq?=
 =?utf-8?B?V0tKaDJ6cTg0R0hMc3NjTEduOUhlaFNLQ0J2VGJhejNWWGk1RXRmZTdReTJ5?=
 =?utf-8?B?a1MrU1hHYjNCcTRjN0hWQWVoNWdOV2FRUC84Q2pjRFlHZDkwaktQMHpKcDBr?=
 =?utf-8?B?dzQ0Sm9lNTlzenFuVW0vUjNXNlNpTmFMRlZZZlZ0ak5QV0JGdTFoaVVvdmJF?=
 =?utf-8?B?a0JSZWp6dWJyOUt3MGdRcStUcjdWL2NMZlBvTE1aaFF4dWhmVlVaMkp3UDJq?=
 =?utf-8?B?bjJqVUEyT2VjWjlUMERaU1M3eFpVRnYyTi9XbVZWNFVZdk5DaFpCZWJaZWRU?=
 =?utf-8?B?NDdVRTcvQ3JGWkR6L0R4cDI5dFhJbDFGQUIwZU4va0lhSmtHWjg1YjlBMStw?=
 =?utf-8?B?MExVOXg3eHFYekpyWmhlVjJ0Y3dvaEZjUHJUZmpDRStOY1VGbGY4a21Lc1R1?=
 =?utf-8?B?N040cnFtQWNhb0dCV0s1Q05lVDZCS1crVDdVNFEzWVhSeHozc3lGZUJRWGt4?=
 =?utf-8?B?b3hyeEpWa2VJV05oMVZETnFpOVRLYVFZMGdNcmxQL0pSUUcvTlNVdUZkTGhv?=
 =?utf-8?Q?c93p0II1FLywmyrSvR32?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2NjUE5zY3dURUFnZGNrejBLQVZnU3NPdjFwMzBJUEJ3dGNUb2l4YXdHNEZn?=
 =?utf-8?B?eHZmdGpoc2x5a2ozWnNhRGVmR0VNOWMyb0RCZlpOcmZOaG43V2lXbVo2L1dC?=
 =?utf-8?B?YUNRbWd2eXNMcWxtU0VobUViVW54OTBaSWxRZ2lRNzBwbk5KK2M2RWZ6MmE2?=
 =?utf-8?B?b2RzR3lOY2s2QWVzVzZDVEoxeWxSa1VNb0VNdXFhZUNNdnZobEZjOFI4c2dC?=
 =?utf-8?B?dTVITWowTlRxd1h2MlpBYWFSYTdBMnZHQjdFSXhyWGdSTHVvaUpaaDdzYjJS?=
 =?utf-8?B?YjN4ZGJqaFBubEp1N3hDRUx2TTFMNTJ1QXp2dlVwWXNRVzNSeUVCTTdaVFNq?=
 =?utf-8?B?WG5GYjFZVzBpRFlROEpjZFZsNFJYelV3Ukozbkd5ZkFCUEFHbmpTWUt1bTlP?=
 =?utf-8?B?aHhvSitLWjlhSC9MZG5zYkxFL3oydHNuOHY1YTIvcG8xQ0JsTUVZWGpLSkxi?=
 =?utf-8?B?NktUQlVGRG9qTEtqNUsyVGw5cElleExXK2RvdzZ5eUdldjIzOWRKQnVYQ213?=
 =?utf-8?B?UWh0MWtDdHNxeS9STHFnMmlSQnpqMEdFYmIvSllscXpHK1huRlN6dlNPRjRz?=
 =?utf-8?B?MXIzZjhhWW51NEppbE9LbHJBeU5GQm96cEllc2pmZnlPVTZTSmM0UktOdUJC?=
 =?utf-8?B?TkY5aEtRRHhMY3h5UkZhcHcxWFE0RGJvZCtNWlNzaFp3dDVTWktic0hRWTYr?=
 =?utf-8?B?UXpMdGhucEpoanpiWUFIMjVLZmpoZnhQMEs2ZVVNZk9Wek5jMkxVazdPZEhD?=
 =?utf-8?B?WlM3YWo0cmdrZEJab3YvblJXQzk3RHVtTnpKWWJCb2RtNm55MnZEdGdLRDYv?=
 =?utf-8?B?WDNvdTFwWVpiTmViZU16b3owTzhxTlY5bG85OTloTjJRYjBMSFlWTGJ4bEFV?=
 =?utf-8?B?QTdSYjk5UklwanU5S1k5MCs2ODJvR3pZSktlQlk1b3VsQktkeXRMNitGU3hQ?=
 =?utf-8?B?d2ZndDBjSE1GaHdzVUFNc2JYcklkYloxRXArSjJNcEZzZitnWmM5bkpRcE44?=
 =?utf-8?B?T0FhTllSM0owNkxDUzJGcVRHNENlMDNYdkx4WDlkSlk3NE1xSGtkNDV0bkov?=
 =?utf-8?B?R2Z4WWZmRzUvNkJkNnpZbldmQUM3ekFUTitLQmRrUjFsd2J0N3BpbnV1REZl?=
 =?utf-8?B?QnNFVXFTbzZYSFpkcTJkRTk3bnZFbzBLMWtUNGxiZjlUNVM4YkJGVGNFcXZ0?=
 =?utf-8?B?WUp4STNyejNkNTd0elpMdzYzSUZ5SE1iVDhUeE1pSUc2eExTM0tYaTFRZWgy?=
 =?utf-8?B?Zy9kTGFRMDd3cUwxTENFMEdjT2luditpdEhUM0ErZUI1VHd0V0dld1VFT3o0?=
 =?utf-8?B?Z1RsU0tTZ21nMkdrcDBLWGlSeWNhV1lNZk1JZ0diU3BlQ0Z4bTFvOFQzQlJj?=
 =?utf-8?B?Y1ZBVHBKdkVaRlpEVUxFWW56WkZmb2IwTDdiTUFSb3QvKzZ1ZTlZQkFGOUpi?=
 =?utf-8?B?YUJDc2M5bk1FbHQ5UGh1c0kwTlNoZEpRNk5QdDVwclR1Q054OUNIblFseWJN?=
 =?utf-8?B?cTBVS2NmV1hlaFdEaXI0RmxtVXRyLzZuRWVuSktYUFlsa1NzNXRpdzk5aG1T?=
 =?utf-8?B?ejJ3b3ZGUW1yZnVTY1NOb0RlbXhxS3g4V1hMN1l6S2ZnOXhsVTV6S1l2K2tU?=
 =?utf-8?B?VWpqcVN2SE40VSt0YzdVMlVwVVpTcGg5SjJ2Ynpib0hpMllQUzAwYTZDNHJ6?=
 =?utf-8?B?M0x1Ry9lZDljd3IrY2hnL0h0enBPdEpGWDBMZWhWVmdOS0dIVVFxeGxoKzZV?=
 =?utf-8?B?ZVRxc0w0dmZQZWpHRkdBQ0krYjBob3lBWHYzSDBzRXhZVlMzei9xeHFiSldD?=
 =?utf-8?B?Y2NrSGFtaTVrM0Z3dnF1MTZ0OW1CK0hDcDFwaC9HRFpDTXF4MjRtcys5VTJp?=
 =?utf-8?B?aktVTDNGb2JGYms3RG56TjFOYm9qYTZkbnJLZ29KOGNtSG95aFNDMlhzM2Vq?=
 =?utf-8?B?WXJTZzgwK2ViWW1QQjNoVlM2YVFrZVlZVDE2MTZ4eVN6L1g5ZUdiQmt1RDNH?=
 =?utf-8?B?L3crdjAxRTUvQU5CQUhuNFkvak5ENzBjV0l0NlRSYXVBWXVzWFZEb0F2Q3RQ?=
 =?utf-8?B?R0F2K3Y3WjlmYXo1T0FETFI3ellyOTJuUElCUVE4Y3N2Z2FzM2g5eFB1RUFN?=
 =?utf-8?Q?lvtsr3Kpw0M/uzzSJEwG601F8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f11b8842-8af6-44e9-233e-08dd0a7b6b48
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 22:25:35.5458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /uL1cyjHTyDEJgJTVSzniHjxP/shzsnf3gKryxLe12VvN3efPPTssR6LM1A+kc05qgPkPDR8Fd/XzpjchaiSbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4305



On 11/18/2024 5:54 AM, Lukas Wunner wrote:
> On Wed, Nov 13, 2024 at 03:54:29PM -0600, Terry Bowman wrote:
>> Export the AER service driver's pci_aer_unmask_internal_errors() function
>> to CXL namsespace.
>          ^^^^^^^^^^
> 	 namespace
Yup, thanks.
>> Remove the function's dependency on the CONFIG_PCIEAER_CXL kernel config
>> because it is now an exported function.
> [...]
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -949,7 +949,6 @@ static bool is_internal_error(struct aer_err_info *info)
>>  	return info->status & PCI_ERR_UNC_INTN;
>>  }
>>  
>> -#ifdef CONFIG_PCIEAER_CXL
>>  /**
>>   * pci_aer_unmask_internal_errors - unmask internal errors
>>   * @dev: pointer to the pcie_dev data structure
>> @@ -960,7 +959,7 @@ static bool is_internal_error(struct aer_err_info *info)
>>   * Note: AER must be enabled and supported by the device which must be
>>   * checked in advance, e.g. with pcie_aer_is_native().
>>   */
>> -static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>> +void pci_aer_unmask_internal_errors(struct pci_dev *dev)
> Hm, it seems the reason why you're moving pci_aer_unmask_internal_errors()
> outside of "ifdef CONFIG_PCIEAER_CXL" is that drivers/cxl/core/pci.c
> is conditional on CONFIG_CXL_BUS, whereas CONFIG_PCIEAER_CXL depends
> on CONFIG_CXL_PCI.
>
> In other words, you need this to avoid build breakage if CONFIG_CXL_BUS
> is enabled but CONFIG_CXL_PCI is not.
>
> I'm wondering (as a CXL ignoramus) why that can happen in the first
> place, i.e. why is drivers/cxl/core/pci.c compiled at all if
> CONFIG_CXL_PCI is disabled?
>
> Thanks,
>
> Lukas

I moved the function out of the 'ifdef' block because it would be used in
another subsystem. Bjorn requested in earlier review that functions used across
subsystems should not use ifdef.

The drivers/cxl/Makefile file shows CONFIG_CXL_PCI gates cxl_pci.c build with:
obj-$(CONFIG_CXL_PCI) += cxl_pci.o 

BTW, CONFIG_CXL_PCI was added in the commit (68cdd3d2af69) below.

commit 68cdd3d2af6964dae2f8d9b53ee94f740dcbda35
Author: Ben Widawsky <bwidawsk@kernel.org>
Date:   Sun Jan 23 16:28:44 2022 -0800

    cxl: Rename CXL_MEM to CXL_PCI

    The cxl_mem module was renamed cxl_pci in commit 21e9f76733a8 ("cxl:
    Rename mem to pci"). In preparation for adding an ancillary driver for
    cxl_memdev devices (registered on the cxl bus by cxl_pci), go ahead and
    rename CONFIG_CXL_MEM to CONFIG_CXL_PCI. Free up the CXL_MEM name for
    that new driver to manage CXL.mem endpoint operations.

    Suggested-by: Dan Williams <dan.j.williams@intel.com>
    Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
    Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
    Link: https://lore.kernel.org/r/164298412409.3018233.12407355692407890752.stgit@dwillia2-desk3.amr.corp.intel.com
    Signed-off-by: Dan Williams <dan.j.williams@intel.com>


Regards,
Terry


