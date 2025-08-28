Return-Path: <linux-pci+bounces-34984-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF48FB398DD
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 11:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D51E71C24DB6
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 09:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA1C2FDC40;
	Thu, 28 Aug 2025 09:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XqL/fxrV"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2051.outbound.protection.outlook.com [40.107.101.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675D92FD1D6
	for <linux-pci@vger.kernel.org>; Thu, 28 Aug 2025 09:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756374838; cv=fail; b=tvOr+MlzUeW9T76dn+rtjY+LP6+MKtjHg8kBHYDAwdzK1uSuP0nSVZnm1GcVhcf+hQE4sZMxfQVKAbnz8IfInpxlEWZBufn1Ke6p7630sfyyOmcWzylMAaEt9kUGVYYVI0ElH/snSfyzxxBBEg2GoFO8uQVERccGlQbbJ7G8Q1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756374838; c=relaxed/simple;
	bh=GrYN8UzyulM1YnrK0iJf0RyVd7kc0G8Fap0zDhgYP6g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DamL04PElNhMVCV/v+yyoFxvpQjIjFqRA3Hdv/LnY413fnHA9TG8VzxW9QHOA8/1nW1YfVSbkvPm1lHehOwtEyjR6YgccTYN3iWzMg9r/j2N+oqVeEfuLnLk2Ab3gCDARoFqNYtuTyNT5XJR6U4e1caSC3FWuxYXvP3TfYw66AQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XqL/fxrV; arc=fail smtp.client-ip=40.107.101.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LDYU7iHP9LTKOlBrYe71qCy4PjRGinPOjNvy+qkKu7M/vozl1MF/+lfVLe1zzRaNf/PXKFv48+9s5ImTSjlbGG1DCnN4g+Q015odrfVGU1ra07UBk/L4zJrCcIjXCiyaND1tKudL4ZK2acy87q5Bsia10f63lctzU6LX62hmqU7FT1Odk0ZibZ5YNBh3YuhKQX+HwXqH9V9bnz5dvKStSI3AyGoYS+tne0AXlFlA8Vl4cGWCURgqtH9/xl6Nkri6zwPliUt8jE+bgpuX74yUwtVvBvt9VI+8lh7yypAUUElGOyDiTNkXrbCGmjY6tFLkfSKAsjZ30cUcCJz8dhxQJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yR+uQZ3nKIN5+4PE0BjC08y5SgjxCMaOyADdLjUfirA=;
 b=liPBGOxyCZNLQGDmpKBFiKjVJ9vRGTCH02glpL19mz8RErYpxgsmgW7MhtkmHSlzzkWW/NI2yhxQYuinbIq8weTXGtvxjwr7y/H424JTcH/JWLYgbMiQYPQVcjQjPvUN6NbTCVk4s/8Ix+bdSErCf9MMOn8vV0tgjWZS6TESv+msiqHIH0YV9AprIjhWj/TSqPSdFtSA7Z6yVCFIvNz5+pqP2661q4zWijeIPtKrRMLzq5V/qGJQTisUJo/eAnEhg7HDsGJrgfFOIPwLGavMAQ/D7RmdUIN28IgOaZGSeaHm+1hq+FIFwvHAcXfA+UQvCdOPjhB+aQZYWKLl0/H3sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yR+uQZ3nKIN5+4PE0BjC08y5SgjxCMaOyADdLjUfirA=;
 b=XqL/fxrVdnhLIE3qf+UgboGGc1EXkn/pYWCDId64VffUXuKz8qKunyLI518Y/DH81el8Sc2QR/ldcl0dhOLsyWU9u6Dv2gczCdW5U7NDbihoTuDMEJPZ++Ql2yV/Ia4EbsTzb+KcZCz9ReypaSZ/a2EdNFfvwnCZ8moOLJEalJg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by SJ1PR12MB6217.namprd12.prod.outlook.com (2603:10b6:a03:458::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Thu, 28 Aug
 2025 09:53:49 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.9052.021; Thu, 28 Aug 2025
 09:53:49 +0000
Message-ID: <e680335b-bd40-4311-aa13-58bc2b0b802c@amd.com>
Date: Thu, 28 Aug 2025 19:53:44 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 2/7] PCI/TSM: Add pci_tsm_guest_req() for managing TDIs
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org
Cc: gregkh@linuxfoundation.org, bhelgaas@google.com,
 yilun.xu@linux.intel.com, aneesh.kumar@kernel.org
References: <20250827035259.1356758-1-dan.j.williams@intel.com>
 <20250827035259.1356758-3-dan.j.williams@intel.com>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <20250827035259.1356758-3-dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY8P300CA0008.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:29d::28) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|SJ1PR12MB6217:EE_
X-MS-Office365-Filtering-Correlation-Id: 072a7ecf-39cc-4bc7-0a04-08dde618c987
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V0hkdzg3eGh3anFzbDB6R29HVWVvQWM2dTZqaXVRME1BVW8xMmtuVGw3OUkz?=
 =?utf-8?B?T1owdnBEeGlnUVRzV1dHY0RUV2l0WHQ0Vmdjb2NkbGlzZFBsbTRkSjdid1ZN?=
 =?utf-8?B?dTR5eHMxTkJDeWlBVU1Db3FOQW5mTkhyeXV0d083Um50OElEU3A1d3FyTG9D?=
 =?utf-8?B?OFN4cnRWYUplcUlpZEJ5bmhuWnpDODNxWDVWUkNNaHA1c3EydVdHVmtaMWtI?=
 =?utf-8?B?K0dMV21ZWTNyeGg1dGVremNvc2V1TXUzUjY5clFoWDA1Z2c3bE9aU2pHTHFz?=
 =?utf-8?B?YXdKVERscjFZdU1uUm8wYjhBdldOb0VSWW4wS0N5M3RVcWM3MlJLQWNUK2d3?=
 =?utf-8?B?MTdncDNkSjRBZHRXNmJ5MEtNOUhxOUE1Q3BPcUlNZjRHZkRCMUtDUlhRZG52?=
 =?utf-8?B?a0NZaTZ3TmNZN2ZhQVBDWDFCN050ODIvY1pJNFZFQVJhN0xwUjdWMzB5MmMv?=
 =?utf-8?B?cncrZUtzTVQyRlZmdEhmb3NNS3JrQzBWZDg2SE0rOXNWWEI4d01QRnVQckc5?=
 =?utf-8?B?ZGFuTWVUSi9CSVVGTzJ6T3poT3hFWituRVFOTlNSaDFCd3lHSTJyMDE3MXcv?=
 =?utf-8?B?b0t0bzQrWlhISC9DdnN2RHJRbDd2enVnajFnblJFa0VycDUzK2ljcFppQ0gv?=
 =?utf-8?B?dEQrTE5mbUVIM25QN2F1SGNKcHpvL0ZxWEJSeU0yenhFU3E3OHU1VzAyUWo5?=
 =?utf-8?B?U3c5SENPSGh3N3Q5K01Ca3BwRkFQTGJYNDQ3NjNPYytSK09JcEFCVFdqRGRo?=
 =?utf-8?B?MTQwdVEwRFd1ek9IdFBvd3VYNnpMWko0ZTFmWmpjRndRYjR1UVczU3VwVlA4?=
 =?utf-8?B?MWxieXE0cURzdTA3NlF3Sk9XbS9lS3lZL3NaYzc5VzRHOFp2TkZvaDJwVHdV?=
 =?utf-8?B?aXpEK3dHb1JYTlIxcUczUmh1R1l6L0tlenREQUxkSW45MUJmUHI3MHJqMmVC?=
 =?utf-8?B?U1VrTzVKSHh4TTl1cmdvTXNQQ25nR3k3cnoyb3hSTzRHaU5abDA2WEE3cHMx?=
 =?utf-8?B?cytSNHRzRjRIMWhMY3ZZU3Q0aDVrbVlvbHNiMW9sbFQ2L2VPZG43UjJCUXVj?=
 =?utf-8?B?UW0wMkhnL2lrdm4vTmMrSERrQUhJUWxpK2cxRUpHbmYyVm95WVBpZ1E3K2Vr?=
 =?utf-8?B?QXE2Z0ZVMi9LenBxTHloczRDalE2emM2WFAzalFrMm1aOFJpeUltWk5QY1Bx?=
 =?utf-8?B?U29JeU5mZ3FHZk8rYklhTnpVcTVpQkQxSWVoU3c2aDFvU1dtT1BNV3pVZC9q?=
 =?utf-8?B?cmtVOEwwY2lnMkE4L2JqejV4Rk45OXo3S1NkNTVnSFlvZnphUE9Jc0ZKb1gz?=
 =?utf-8?B?MFlJRFVzeE4rOEdFbkhoM01jMURWY3FuNmsyY3ovN0lIMjhkU2RKM2lqNUhi?=
 =?utf-8?B?MXo0M3JoWTRhWmZReTJORTN6eE45Vm9kdXJ2anZLMloyWitQMGFMY1d6NVlM?=
 =?utf-8?B?QWRla3dMWUN6R0FzNWYycXRaWWZrYjRuSHJrKzFKWnpXby95QjNUamlkZkpQ?=
 =?utf-8?B?NE83NHFCa3Z0NEhRMFFSbDVFSCswK09ySHFKTFJuakRFaWlvajVTcHZFSnlW?=
 =?utf-8?B?NFhMOVJQVjFEYUJuTHFBY0FqdSt0aEU4RFZDUUhYRDVHbGpqRUVGRktXSUJV?=
 =?utf-8?B?Yllvb3RLTUtMYlY1a3EvT05FRW5UZWVYVkt3bEM4VURNNFJISEE3Ynk4NjIv?=
 =?utf-8?B?Q2J3a0xmMmFHZWRNSGRrV2FSU293a2lqU1ZNS2I5VXUrT1F4NFhwQTRGY0ZW?=
 =?utf-8?B?dVlWenlPT1ZFaVhXYnhMa3lTQVdLWk15TmIrK21mREJPTnp1bXRlWjlmdjI3?=
 =?utf-8?B?ZDBuVVdGNXBTeGZoY0tjQVVZb1pyRkFzbnFrSzlaUkwxcDJQV0FEOHpSMFZm?=
 =?utf-8?B?cnhWcEdxbXMyYTVEQ00weDBYaGxBMUFnYUhobW5FYTdlVUxaWXZHOVRsRUF5?=
 =?utf-8?Q?GjgFVvCY2jo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUpWWHZ0dnNLREdJS2s4WWpha3ZSeGxMUU4vMUVJNXpJU1FyMWsvYnBjY0Qx?=
 =?utf-8?B?aTZJdFdWVzlqSVUzSENDWER6amVtaFJoNWIvVnpOUlQycGgwZDdpcHVJU1Nh?=
 =?utf-8?B?T00ybGpvM1NoczhuK0Q4eWttODNPOElzMjNMNGZtU0RZUjE5a2FaV1pwV3hI?=
 =?utf-8?B?QmplVUp3NjBLVkplVEhxRTlSR2RaWlJhNkdvY080YWVGZldSSE13Z0Q3WFlx?=
 =?utf-8?B?ZFJ6OTNRSDdGZWw1TTc3S2VLUE9FOXU2dXNaZTNyMXdMTDRiZ0VkcjRUVVNQ?=
 =?utf-8?B?R1lGTjNLRndSZDY5MWJKcjRSRTVkZmdUa2R3UWlQV05Qdzk3MW1oanVKZ2lx?=
 =?utf-8?B?Qnp3S1A2OXl1cU9namtNV05VdllJQURBZ0c2cTVlOGpKVVg3L0ROZVBITjdn?=
 =?utf-8?B?ZkZFRGhIb01XbDV2OFJFUG04YThaZHFQVDZtTWtCTEpRUFl1aHVYWlliYjQ2?=
 =?utf-8?B?MEZrYlUxemJYSmh4ZU01RldtaHYzZUU4UWMyVll0UGZqanpCeExzeUhoQ3No?=
 =?utf-8?B?N3lqbHpDc0k4bFVpcitERXRnUlRBL1ZYVTZIWHBUTXY2MjFHd1crUldkREJK?=
 =?utf-8?B?TDV4RjNIRSt4MUxKTmltdWlRaFAyNkU2aWcyZXBCK2tYcTRUcGZ1Tm5HOHVY?=
 =?utf-8?B?WFFxTk8wSzZkM2hyVkxLcDV3QzdReG9Mb3F2MzlYSzJNdEFhRTdUcHpNVmdj?=
 =?utf-8?B?QWk3TDNWRWhITDROSng3aEhjdXpCTlU2K2tsS2lhb0IyTTRmaE5mYkRQL0lE?=
 =?utf-8?B?UE5sTXNQUWVkVmVVZjdCOTlmREJXTUxhcU9QQ2E5QXpCUWJYWEltTVdvWXNU?=
 =?utf-8?B?bkZ0Ym42dnpIT0o0QXQ4a2pXTk5uNHNreDRuclFXc0FSOVlrZ2VFRS9ZaVJC?=
 =?utf-8?B?eG1VWnB5MnB4dDE3RzgwbUJEeW00Qm9DcTJDSDZXRDFlUGl5blVYR2ZxSVls?=
 =?utf-8?B?OUZVVXliR0MvUTNRMEZ4blRxTXNydGdQNHQ1ZW5ieVhickRYWU5pb0dDaitu?=
 =?utf-8?B?bXg3Tjh1NStuNzlBWnVPSjRKY1NOVkY1NjdsaFBkWjFJTXBuWkQwZlJrN2NY?=
 =?utf-8?B?cWg0R083Y0wxUDQxbmhmcm9xaWE2UjZsQ2dMaEFwbGg3WDc0SGphV1l4RElq?=
 =?utf-8?B?N0o3bk5JMTVoalNQeVNRZ1BkWVdCNy8wWWpEN3U0ME9hd3JoeVBhUVFZN3p4?=
 =?utf-8?B?ckFrSzJVL0JoYnRoQTcyUW9ualA3Vi9Lb3M5dVlmUUE1UmlKR0ZpbFN3bnBp?=
 =?utf-8?B?U2RjVnlzNDZLeGlFZ1hWZGVZZVI5c2lic3ZZU2VzUm83Q2ZKVFBTcXpoWUlO?=
 =?utf-8?B?bTltN2FBNGozZ3BGbGJIS1h6amdvTWxiVXN0dkdEZG5Fb1h4TXJJV0JsOGJz?=
 =?utf-8?B?QW5HbEp2MStETHZ0VUxsdGFPNGFUcFAxQ3dTWWZoSGZWdWVPbWNrSWJ6NktP?=
 =?utf-8?B?aE4ybXpITHd4MWpiV3E1MnNudUxWZEo2bFE5UDlmM2EvQ1hMciszRkdHNzdJ?=
 =?utf-8?B?ekpNUkFGMXN2NHZGVEMvRkhOc0JINzZaMDJVMnJad0pocG8yOHlOaXhzTFRC?=
 =?utf-8?B?MHptcmZ4Q1RkdDM0c3Jvb0I3cUxZTzMxUDBtYitQQTkzWlE0cExyNjU3WThM?=
 =?utf-8?B?a2JqQlkwdldWR0pJL2lleHR6TllHMVgyTVh6YlFoQWtEbGtOcGJYUmZobmNy?=
 =?utf-8?B?dkxYeGtTZmRLV2pvRUJ6Rmpnc1J4WG51cHA4K2hLOExiZk5hQ0FFd3htc093?=
 =?utf-8?B?djBhV3RNVmExMmR3TUlBOEtXcmw0dytKK2FPcUtXQ3ZPNUhSOE5mdUFnWjBi?=
 =?utf-8?B?anFUek5GMFE0WXowZDR2UlpvaEhKUStMcEU4dFdiR2hDTDlnRW5TSWtuVkZo?=
 =?utf-8?B?TTI3NXhCRml5bEUxNUxheEpnWUl2cmcxWUVFVU1EanZQSkRhTDZ4OHNrOGN1?=
 =?utf-8?B?WE5XU0dpd0ZOeTdjVXlRR3A2SzJjKzdGS0kwVWFWcEhLTURCU21GYjlscHZm?=
 =?utf-8?B?T0R3ZzAyKzMzbEJOazNDWUM3TGVpaGkrZkZ2eUtFeWtRb0xCcmxlVnI0bE9S?=
 =?utf-8?B?VGllOGdLNXFqM3RtRVhEa2lGKzN2OGhSNWRsZFMzenpDUTFXTGVxV3gxVTNz?=
 =?utf-8?Q?gXIFM08Vdd3Ng3j34dor6VQA6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 072a7ecf-39cc-4bc7-0a04-08dde618c987
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 09:53:49.5101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JCVEsyDq4wPyuHWC1lkch/1A3yQnmfU63CG/RRPOYxUGW+umWBDuYERqndFJFRd8e1Ug1Nd/sW2QLXrg7ytcpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6217



On 27/8/25 13:52, Dan Williams wrote:
> A PCIe device function interface assigned to a TVM is a TEE Device
> Interface (TDI). A TDI instantiated by pci_tsm_bind() needs additional
> steps to be accepted by a TVM and transitioned to the RUN state.
> 
> pci_tsm_guest_req() is a channel for the guest to request TDISP collateral,
> like Device Interface Reports, and effect TDISP state changes, like
> LOCKED->RUN transititions. Similar to IDE establishment and pci_tsm_bind(),

s/transititions/transitions/

> these are long running operations involving SPDM message passing via the
> DOE mailbox, i.e. another 'struct pci_tsm_link_ops' operation.
> 
> The path for a guest to invoke pci_tsm_guest_request() is either via a kvm
> handle_exit() or an ioctl() when an exit reason is serviced by a userspace
> VMM.
> 
> Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>   drivers/pci/tsm.c       | 60 +++++++++++++++++++++++++++++++++++++++++
>   include/linux/pci-tsm.h | 55 +++++++++++++++++++++++++++++++++++--
>   2 files changed, 113 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
> index 302a974f3632..3143558373e3 100644
> --- a/drivers/pci/tsm.c
> +++ b/drivers/pci/tsm.c
> @@ -338,6 +338,66 @@ int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u32 tdi_id)
>   }
>   EXPORT_SYMBOL_GPL(pci_tsm_bind);
>   
> +/**
> + * pci_tsm_guest_req() - helper to marshal guest requests to the TSM driver
> + * @pdev: @pdev representing a bound tdi
> + * @scope: security model scope for the TVM request
> + * @req_in: Input payload forwarded from the guest
> + * @in_len: Length of @req_in
> + * @out_len: Output length of the returned response payload
> + *
> + * This is a common entry point for KVM service handlers in userspace responding


KVM will have to know about the host's pci_dev which it does not. I'd postpone mentioning KVM here till it learns about pci_dev, if.


> + * to TDI information or state change requests. The scope parameter limits
> + * requests to TDISP state management, or limited debug.
> + *
> + * Returns a pointer to the response payload on success, @req_in if there is no
> + * response to a successful request, or an ERR_PTR() on failure.
> + *
> + * Caller is responsible for kvfree() on the result when @ret != @req_in and
> + * !IS_ERR_OR_NULL(@ret).

Uff... So the caller (which is IOMMUFD vdevice) has to check and decide on whether to kvfree. ioctl() is likely to have 2 buffers anyway and preallocate the response buffer, why make IOMMUFD care about this?

> + *
> + * Context: Caller is responsible for calling this within the pci_tsm_bind()
> + * state of the TDI.
> + */
> +void *pci_tsm_guest_req(struct pci_dev *pdev, enum pci_tsm_req_scope scope,
> +			void *req_in, size_t in_len, size_t *out_len)
> +{
> +	const struct pci_tsm_ops *ops;
> +	struct pci_tsm_pf0 *tsm_pf0;
> +	struct pci_tdi *tdi;
> +	int rc;
> +
> +	/*
> +	 * Forbid requests that are not directly related to TDISP
> +	 * operations
> +	 */
> +	if (scope > PCI_TSM_REQ_STATE_CHANGE)
> +		return ERR_PTR(-EINVAL);
> +
> +	ACQUIRE(rwsem_read_intr, lock)(&pci_tsm_rwsem);
> +	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &lock)))

Why double braces?

> +		return ERR_PTR(rc);
> +
> +	if (!pdev->tsm)
> +		return ERR_PTR(-ENXIO);
> +
> +	ops = pdev->tsm->ops;
> +
> +	if (!is_link_tsm(ops->owner))
> +		return ERR_PTR(-ENXIO);
> +
> +	tsm_pf0 = to_pci_tsm_pf0(pdev->tsm);
> +	ACQUIRE(mutex_intr, ops_lock)(&tsm_pf0->lock);
> +	if ((rc = ACQUIRE_ERR(mutex_intr, &ops_lock)))
> +		return ERR_PTR(rc);
> +
> +	tdi = pdev->tsm->tdi;
> +	if (!tdi)
> +		return ERR_PTR(-ENXIO);
> +	return ops->guest_req(pdev, scope, req_in, in_len, out_len);
> +}
> +EXPORT_SYMBOL_GPL(pci_tsm_guest_req);
> +
>   static void pci_tsm_unbind_all(struct pci_dev *pdev)
>   {
>   	pci_tsm_walk_fns_reverse(pdev, __pci_tsm_unbind, NULL);
> diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
> index 337b566adfc5..5b61aac2e9f7 100644
> --- a/include/linux/pci-tsm.h
> +++ b/include/linux/pci-tsm.h
> @@ -33,14 +33,15 @@ struct pci_tsm_ops {
>   	 * @disconnect: teardown the secure link
>   	 * @bind: bind a TDI in preparation for it to be accepted by a TVM
>   	 * @unbind: remove a TDI from secure operation with a TVM
> +	 * @guest_req: marshal TVM information and state change requests
>   	 *
>   	 * Context: @probe, @remove, @connect, and @disconnect run under
>   	 * pci_tsm_rwsem held for write to sync with TSM unregistration and
>   	 * mutual exclusion of @connect and @disconnect. @connect and
>   	 * @disconnect additionally run under the DSM lock (struct
>   	 * pci_tsm_pf0::lock) as well as @probe and @remove of the subfunctions.
> -	 * @bind and @unbind run under pci_tsm_rwsem held for read and the DSM
> -	 * lock.
> +	 * @bind, @unbind, and @guest_req run under pci_tsm_rwsem held for read
> +	 * and the DSM lock.
>   	 */
>   	struct_group_tagged(pci_tsm_link_ops, link_ops,
>   		struct pci_tsm *(*probe)(struct pci_dev *pdev);
> @@ -50,6 +51,9 @@ struct pci_tsm_ops {
>   		struct pci_tdi *(*bind)(struct pci_dev *pdev,
>   					struct kvm *kvm, u32 tdi_id);
>   		void (*unbind)(struct pci_tdi *tdi);
> +		void *(*guest_req)(struct pci_dev *pdev,

We have pdev in pci_tdi, pci_tsm and pci_tsm_pf0 (via .base), using these in pci_tsm_ops will document better which call is allowed on what entity - DSM or TDI. Or may be ditch those back "pdev" references?


> +				   enum pci_tsm_req_scope scope, void *req_in,
> +				   size_t in_len, size_t *out_len);


Out of curiosity (probably could go to the commit log) - for what kind of request and on which platform we do not know the response size in advance? On AMD, the request and response sizes are fixed.

And the userspace (which makes such request) will allocate some memory before calling such ioctl(), can "void *req_in" be "void __user *reg_in"? The CCP driver is going to copy the request and response anyway as there are RMP rules about them.

And what is wrong with returning "int" as an error vs ERR_PTR(), is there a recommendation for this, or something?


>   	);
>   
>   	/*
> @@ -143,6 +147,44 @@ static inline bool is_pci_tsm_pf0(struct pci_dev *pdev)
>   	return PCI_FUNC(pdev->devfn) == 0;
>   }
>   
> +/**
> + * enum pci_tsm_req_scope - Scope of guest requests to be validated by TSM
> + *
> + * Guest requests are a transport for a TVM to communicate with a TSM + DSM for
> + * a given TDI. A TSM driver is responsible for maintaining the kernel security
> + * model and limit commands that may affect the host, or are otherwise outside
> + * the typical TDISP operational model.
> + */
> +enum pci_tsm_req_scope {
> +	/**
> +	 * @PCI_TSM_REQ_INFO: Read-only, without side effects, request for
> +	 * typical TDISP collateral information like Device Interface Reports.
> +	 * No device secrets are permitted, and no device state is changed.
> +	 */
> +	PCI_TSM_REQ_INFO = 0,
> +	/**
> +	 * @PCI_TSM_REQ_STATE_CHANGE: Request to change the TDISP state from
> +	 * UNLOCKED->LOCKED, LOCKED->RUN. No any other device state,
> +	 * configuration, or data change is permitted.
> +	 */
> +	PCI_TSM_REQ_STATE_CHANGE = 1,
> +	/**
> +	 * @PCI_TSM_REQ_DEBUG_READ: Read-only request for debug information
> +	 *
> +	 * A method to facilitate TVM information retrieval outside of typical
> +	 * TDISP operational requirements. No device secrets are permitted.
> +	 */
> +	PCI_TSM_REQ_DEBUG_READ = 2,
> +	/**
> +	 * @PCI_TSM_REQ_DEBUG_WRITE: Device state changes for debug purposes
> +	 *
> +	 * The request may affect the operational state of the device outside of
> +	 * the TDISP operational model. If allowed, requires CAP_SYS_RAW_IO, and
> +	 * will taint the kernel.
> +	 */
> +	PCI_TSM_REQ_DEBUG_WRITE = 3,


What is going to enforce this and how? It is a guest request, ideally encrypted, and the host does not really have to know the nature of the request (if the guest wants something from the host to do in addition to what is it asking the TSM to do - then GHCB is for that). And 3 of 4 AMD TIO requests (STATE_CHANGE is a host request and no plan for DEBUG) do not fit in any category from the above anyway. imho we do not need it at least now. Thanks,



> +};
> +
>   #ifdef CONFIG_PCI_TSM
>   struct tsm_dev;
>   int pci_tsm_register(struct tsm_dev *tsm_dev);
> @@ -154,6 +196,8 @@ int pci_tsm_pf0_constructor(struct pci_dev *pdev, struct pci_tsm_pf0 *tsm,
>   void pci_tsm_pf0_destructor(struct pci_tsm_pf0 *tsm);
>   int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u32 tdi_id);
>   void pci_tsm_unbind(struct pci_dev *pdev);
> +void *pci_tsm_guest_req(struct pci_dev *pdev, enum pci_tsm_req_scope scope,
> +			void *req_in, size_t in_len, size_t *out_len);
>   #else
>   static inline int pci_tsm_register(struct tsm_dev *tsm_dev)
>   {
> @@ -169,5 +213,12 @@ static inline int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u64 tdi_id
>   static inline void pci_tsm_unbind(struct pci_dev *pdev)
>   {
>   }
> +static inline void *pci_tsm_guest_req(struct pci_dev *pdev,
> +				      enum pci_tsm_req_scope scope,
> +				      void *req_in, size_t in_len,
> +				      size_t *out_len)
> +{
> +	return ERR_PTR(-ENXIO);
> +}
>   #endif
>   #endif /*__PCI_TSM_H */

-- 
Alexey


