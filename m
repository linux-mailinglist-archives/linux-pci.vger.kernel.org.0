Return-Path: <linux-pci+bounces-40349-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0927BC363B7
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 16:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEDC056779B
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 14:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C6532E69E;
	Wed,  5 Nov 2025 14:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QjaPVzJH"
X-Original-To: linux-pci@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012030.outbound.protection.outlook.com [52.101.53.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108313128D0;
	Wed,  5 Nov 2025 14:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762354750; cv=fail; b=sClYNbAm+yyqghypAqCy5I2VkdBU853Y1XNvyAcrO2ve17W1guyehX4yfZp3YG41ZoakKa3jRl9MnHZ/wFo1oWly9qtAYkug0jgo8mTZx26Zr6+0rix50uIpodkbNFEmmPszyyd98dTTPM27H+q2YezkTDWu6YuNiRjM7AenPQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762354750; c=relaxed/simple;
	bh=N6yBdGAuScQYgv9jQ0BntElVWzqiXX65/6UUIEMnnkk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aRWoWLeF38bTswSQRDiff1ZI7fU4uq66X77Orgh8BYuNRrCr+fAXbATfsVa21KLRckAkh3j4UYyQRz8VVmhtnoImvG3SGAvPACot75DCT9NAG0oziiYlMTXSbx4c117E1MRsyxrfB78NW0KOC6+v0SxdnAa4fe+cMUuj5+oLnU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QjaPVzJH; arc=fail smtp.client-ip=52.101.53.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TOX5I8sy/pEK2D0SQRH1zvtBIrtdIm05k+IqA6OUZ9J7y3UoXeRPNM/BHybIz9Q7Xa7YNpUCxBnMOGdUZi3r5S4n1aOEc7HD+WzKRSdxprEpmUDIL3EE8jqfQtIUHNKUIRWZvLDFjgTOP5IrGrV3LoEFSgC3z9ZMobO/IbiIm8DVEpH8wkEBx9D3kAk2Mcv1RG9vZOD1GpUzJ/27KZDWerbiJa4q2FtTmzdG1j5CCTSqrk/P5bO8wy/yG0aY56ZHbxCQzDuIVqg699sn3mYl+rHxJRFwlarcUlPdeohqY2ZAaJaIobQDqaB3kZF6QSoiTKJlD9pCFApgRnqxGiX1Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b7cVJ7BEbhHGU2oeKVgPAaIG2CFH9Mpds/a3nIjxoqU=;
 b=RUuTF0mCzIvb8qFhNhUaxCey2z5u/zhrNBy/85owPUKrukfxGUAzxLbTutrIp1OmyY/CEHk3QABVoK0LkyJ/f7ADLZLrql/17EynppBAeK/QPBeqKqJh06giIj7GMlQuQZIfBNSasQohWP/sFRAwFo6MACWEf7RcXFKnmyUO6UJHNbV0EksCu73aj2TknEbkQL6YnhD3mhi172d5B86YKE7rr1RynRJEfSEytjNudoLv3/02PNxAY9sImvpMn33erMempXPkxCesDzAu/Bjb5lLlPdaIWRtiChawYa7h8STsgAm/KiLOGQK2dek9lEIjuaRbk2iS3f1oU9kRs/MeMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7cVJ7BEbhHGU2oeKVgPAaIG2CFH9Mpds/a3nIjxoqU=;
 b=QjaPVzJHmPV+IZeMVA3v9JCCv0R7Ivhc2Hmt/k9BFizH2cG69mQoCDdgCz6qx612VquWOJ9eu0iENDh8+bEPqc5XjPclVSitcbhXcy2oJam63mhPsQfa81uWCPoMDWyMkefZACRCUz2fRfQGUt15uOiHWijDCj6clNAVgfinNMw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by IA1PR12MB9032.namprd12.prod.outlook.com (2603:10b6:208:3f3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 14:59:03 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14%5]) with mapi id 15.20.9275.013; Wed, 5 Nov 2025
 14:59:03 +0000
Message-ID: <5246e21b-d226-4faf-936b-d3dffe2cc45e@amd.com>
Date: Wed, 5 Nov 2025 08:59:00 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND v13 23/25] CXL/PCI: Introduce CXL uncorrectable protocol
 error recovery
To: Dave Jiang <dave.jiang@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: dave@stgolabs.net, alison.schofield@intel.com, dan.j.williams@intel.com,
 bhelgaas@google.com, shiju.jose@huawei.com, ming.li@zohomail.com,
 Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
 dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
 lukas@wunner.de, Benjamin.Cheatham@amd.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, linux-cxl@vger.kernel.org,
 alucerop@amd.com, ira.weiny@intel.com, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20251104170305.4163840-1-terry.bowman@amd.com>
 <20251104170305.4163840-24-terry.bowman@amd.com>
 <20251104184732.0000362f@huawei.com>
 <10115294-8be9-42af-a466-40a194cfa4e8@intel.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <10115294-8be9-42af-a466-40a194cfa4e8@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR02CA0016.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::22) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|IA1PR12MB9032:EE_
X-MS-Office365-Filtering-Correlation-Id: 500c5df2-fd34-4b1c-928d-08de1c7bdc52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MzVxNjVpM2daZy85MjlRcFh4djlXMVB1ejh0OXBHZ05VZ0FNNU5wUXd1WjRJ?=
 =?utf-8?B?eENJS0lzRU9TOGF1TU9EQmJ1K3I5N3BjNXhNRFJIcTBwaFhRZXRZMDZyaEx2?=
 =?utf-8?B?OHBsR3IwQmNGcUxaVURYWm1rdWd0UDVhUGJTd3hxRnVtMzVYRTlsV0tjMUdP?=
 =?utf-8?B?TE1YYTJLTTZKZTk4ZUI2QmRtZWhFbVZ5QmFHSWxhWXNCa1JFSDF6ZVV4OERv?=
 =?utf-8?B?S05pcWp1WFlUSkMxNnJJSU1CT3NlVGN6UlRRK0h5d1VjbTM4aW9QZ055cTl4?=
 =?utf-8?B?aGkrZU52WTByeThTazVWVGpWTmVTZ1pHenFzUU5ERzNQWWpaV0hkNmE0dUx3?=
 =?utf-8?B?ZnZwNTEzQ2ZNbEF5bzRLVUJhamRQcTBiTUFqaUFSTGYxTGo2UDFwM0FUb3Vy?=
 =?utf-8?B?c0VOc1dySkJWaXFxRFN3OXBIaXZZaXZ3Uk55QkJyQldTWlF2b1h2WnVRR0Jq?=
 =?utf-8?B?VEVXdnBDbmNVV1pBWGVTQ2JXTTBUNUJ4ajRxZTNYbkt1SjBUTGZrZFdrTmlm?=
 =?utf-8?B?YmRmeHpRTEo0bWVpN3FXY21EaUQ0QTg2WG1tampjejY4RUI2cXhTNi81bDNi?=
 =?utf-8?B?NVpPbURjU08razRFVnU4UitSNTBFQjdDMyttV3BQRnQ2UW1TSHVPUEUzR1R5?=
 =?utf-8?B?MEd2VytyL1pncStUNFp1WEhjRVRlcnkyb1FGZ2o4aGV1RWFyUUthbGVnQytI?=
 =?utf-8?B?RHJScFBFTG5tM0ZXaUg3disvdklsVzFDTzhmcVBzT0tDdEFkcHAxVWtBY0Zm?=
 =?utf-8?B?NnlKdFhhUG9mQm5MWHh5T0twVGFVVWlwQlFybG13MXNJbEtuVXo4SGE0RWVs?=
 =?utf-8?B?aURBdXJrUGN1dTNXTE5LNnI2TWYwWEZ5RXUyRHA2c3FheUd4YjgxSldBL0tF?=
 =?utf-8?B?U3E5ZzJod0x6REhUWFI1dzNRbjB5cGlhQlBEaUxQdUt3TWJNSlFrU3lNN0RK?=
 =?utf-8?B?VjludWRKOGplaGduTU5HcXdrczAxbnpZaWpTSjBZbUFzaFcyVm5IQnN5RmtR?=
 =?utf-8?B?UUQ2a0RCL3lSTzQzYytiS0xqOXU5V05PVFFjS3RIT0tyWGZxS3JxNmx5VGMv?=
 =?utf-8?B?R1MrRElra2lydzhINk5zNVc4VHRDRzZwT1UrbUFyeWpKalp0dGc4cmFrWWxk?=
 =?utf-8?B?dnVpZUJ2cmlOVC8rR2pMdTlTaXRvcWRseFJ6SXZzWWpQVjhIR0tYenpiQmM1?=
 =?utf-8?B?aHJyRE12OUlycmRGWWNqVWFpcG9ZL1BrTWNWS1FIQ20vZFpQYXlLcjFXWSsr?=
 =?utf-8?B?WEZ1NlZReGw5VmpEWk5XeU9Uc045Ylc2SDNDeTU2dzhKelZzZzBIcG02Z3Nn?=
 =?utf-8?B?MFBxN245TWwwOHZZWXZRVjRJRWJRdm1keDR1YUR1dzV6ekZVNE85MmUzbGxD?=
 =?utf-8?B?RU81S3RGdjRZSFIvaDhvQ0xBekhZcnpMZnFOVThwYm9jdEVoRmdRVDBWMWVy?=
 =?utf-8?B?Mk8zY0d4K05VR2s4SStZcFlyaDAzbEdpRWFaVzFuZnplazY5VE9hN25IejVU?=
 =?utf-8?B?WVR0bzBISm0vTmV2dFJ2SDc2ZCtDUENHL29sNGtuYkdXUjVyL0ZCVjJWVWpI?=
 =?utf-8?B?eXRiWlZzUEIwY3BoNEx0RXFOU3oxK0NYRlFkUVBOSzdKRHVsQzA4UU1Hcnha?=
 =?utf-8?B?clkxWERsNzVmWm5JR2dzSW03M0dJd1hHK1QzOXliZUxRT1VrK0hFV3hiOUZM?=
 =?utf-8?B?K0R5S1BtWUNYbXlseDZqemhpVHZUdlhwQ0hQTkNXRFozcmpNbjczdUlxZENl?=
 =?utf-8?B?c05CWnZQK29CdFVISHljQmZQSXhHMHc3UzZWZkZJaHdQMkhZSGpGbThlcjhU?=
 =?utf-8?B?L1hXcEphUTVNMUhhRFdzMjN1TXZPLzY2UkJaK0V2Qk5VL2xHNzVaYXNaUHp6?=
 =?utf-8?B?MFgxaDZBMEpiSEJabnIvdlY2cTk1dzlTUUI0d3RzZTRGdDZ5QldSbUJ6WkpD?=
 =?utf-8?Q?o9U0MEq4rFGUXRwtrNI7wDBrs34dal3b?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OVdqSmlwNkZja1JPMSsyK3d2YWdRREdQV3d5M1JtditYeksvM3RxL2gySTV3?=
 =?utf-8?B?U1I1WldWelVDUHBYQjg5SGJnRmVVcTBzbDVlUHJWcHBBVnU3SU9FMHlkRzJU?=
 =?utf-8?B?R21iOE5qUlVhaFdiQm9YSElSZDhJYytYajB4dTJOZTFtb3NYbFRqTWZxc3Ra?=
 =?utf-8?B?cGpZUkkyTE1veDNZN2dlWTNDZkMrdXd1WTdTdjZFQWw4VlJGRjY2WlF3K3hy?=
 =?utf-8?B?YkdFZU1jWlJRNEVuNm1xekcxa2xUaGpVOUV6TkRTVVpoL1lpRGF0NURVWU1u?=
 =?utf-8?B?RGx0QXQyeEQ2L2xJY2ZmTFNXazEvWmcrS01zQjBvYlFSNXdrRDFhdW1CK1lY?=
 =?utf-8?B?RVkyaW8xRmpCVXBtL1JVVkVBZUZVQ2QrOUZGRFFFWkR2djIzYU1OQThpakp6?=
 =?utf-8?B?QnlEeHV5TnE1aVVzbHRQaXU3c1pwMW9HNVVXRHFqeEQvSytXV1ZsSFIzeW5t?=
 =?utf-8?B?OWpFRlBmUmNBQmNEZDQyajBheStUOS9WYTJWamY1Yis3VE1IWjB1SUtiV2Ur?=
 =?utf-8?B?aDl0bTZoY0w4ZlFKZ2dydEFjODM0THJ2TGtOcll1ZjNiZzFBZDBjSk5yT0ZW?=
 =?utf-8?B?ZGF4MXRnbGJSR0VvTmRxOENNL2FyenlQR0VlcFdweHRlejk1YlQ0RnJjT1hH?=
 =?utf-8?B?T0VpNTFYdnJ3RUtQOE1tQzVaTHQ0Y25iWTFnSjhoRXNpOXlHTXZhK3JxbUhY?=
 =?utf-8?B?elRIUGMrdW9NTDFINGZOTEZOMnpuUWcvTnQyZTBVbUE5eWs1QU9ITjBybHJy?=
 =?utf-8?B?U3AzZzUrWEhpWnRUbUkwajB3Vko4QlJHcXg0QkNSeWJ1NEtydVRTOC9PZ1RZ?=
 =?utf-8?B?YTM2ZTBjSDRmOXluMnhIT2ZGZnAxZEVMUEliK2M4MHlPWnBRQzQzVmJpU0Ir?=
 =?utf-8?B?ZTNvVjFhRUdJTGRuUE9JTFlySDE4ZlVzZW9tWlNQZHpncU9aYktSOHowM0k1?=
 =?utf-8?B?bW5CVnlFVUlzb1Y0bWIyR0JZckVCWThjbVAvNStiTkhrRXgzL2h3eE1wWlRy?=
 =?utf-8?B?K3VXR1RPeEsxQVBqV29QM2ZPMkNnczQ0RUt5YXBtL0pEL2FxVnBPNlpSTEJn?=
 =?utf-8?B?d3RKcHE4U3NTeTZSd09XTXhmdkZoYXduM3NXVmZZWDlhdkpmQ3FaVElXZXVE?=
 =?utf-8?B?dnVuNDdlcG1UcmgwWi81QW02ZmtmaWNPYVAwaHJkQTVndlp0NHVkMEZqTFNO?=
 =?utf-8?B?RVRqSitLUGhnYjl3d1dicXk3Rmw5cVA1RHZJVCtvQ0E2cHNkdldSdG8xcHRP?=
 =?utf-8?B?bHptejNkUDBKYlgvNDVVcERycFVBNTBDOG5UamVmeWFKaTNyeVM4clBUL001?=
 =?utf-8?B?eHRFTzQwSDlvNUlKNlk4NlkxS1JuVzRBOFFSbHNTQzhSV3Zvam5mVlhONTZK?=
 =?utf-8?B?VVFpR2tzQkQ5cG5kMWs5cytHQUdiQ3A4eWgvR0hqb2hSR3ZPZE5va1RLZXFq?=
 =?utf-8?B?L1RTUUJOMUx0MXBFZ1pHZ3hKN3JKN25VTzZwVnAvZ2o5OUVqeTczRm5XQVpx?=
 =?utf-8?B?S0JuN2pUYVdFWXoxa0tFN2ExQXFIQ0hTSlUrM2Z0ZnA1SVo3ODVHNHBTbGl2?=
 =?utf-8?B?R3pkUmx5SFFQNWliMklQcjhXYkFIcEVTL1c3dUpuQm9xMTFXQzNGOGpDUE5h?=
 =?utf-8?B?bFppR3RoN1RwMEV1U1Z6VHhDUVg0c2lRbGFBM0prQ0NnWVRJSERyS2hIWGlB?=
 =?utf-8?B?SzlmYUpIcGk2ODJ0ZmFjTEk0eURycm11RnFCQnRPWExreDZkclI2RjV1MjRL?=
 =?utf-8?B?bXJhRHVqMU1JSzBicW50OS9OK08rendEU3BXbGlTdEl0TzNwRFZmU1QwSURE?=
 =?utf-8?B?WU9BMnl3VWFBd0lrYmVzTC92STdCa1lmcEx5TUwwUUZOcGErVk5JYTViUm45?=
 =?utf-8?B?aUdZTnJvNm9vVldsd2RPTkNwRFR2UmFaM2FSeTRKd254NWJzL3ZLY0pJZ1Ni?=
 =?utf-8?B?QXJjRExiV1pLOHBTcUxuTkd5Qk1hSnVyM0p0THpqTGptL09VNGlFL1MzdWg4?=
 =?utf-8?B?VUorQjduQW1FU201eDU4Q1ByN0hub2Zhc3hpVUJkbHI5VEF0aGdOYmtVOGQ1?=
 =?utf-8?B?eGVuUURjUytSQnp1cFZDZlYrSWpsRElJRW9naFAzeU9raGlGak15SFVEck1O?=
 =?utf-8?Q?TylfWE6AS+qoO6FZYZnrNcFhH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 500c5df2-fd34-4b1c-928d-08de1c7bdc52
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 14:59:03.7960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cw38j/H49HI2Mh2gK0GYmnkdPFLEFSUf34tJ4+U9jZpmo8Lw+jCuD4ypzyqJkCFnnFyj9Ouk/VD3LVXBmCTzlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9032



On 11/4/2025 5:43 PM, Dave Jiang wrote:
>
> On 11/4/25 11:47 AM, Jonathan Cameron wrote:
>> On Tue, 4 Nov 2025 11:03:03 -0600
>> Terry Bowman <terry.bowman@amd.com> wrote:
>>
>>> Implement cxl_do_recovery() to handle uncorrectable protocol
>>> errors (UCE), following the design of pcie_do_recovery(). Unlike PCIe,
>>> all CXL UCEs are treated as fatal and trigger a kernel panic to avoid
>>> potential CXL memory corruption.
>>>
>>> Add cxl_walk_port(), analogous to pci_walk_bridge(), to traverse the
>>> CXL topology from the error source through downstream CXL ports and
>>> endpoints.
>>>
>>> Introduce cxl_report_error_detected(), mirroring PCI's
>>> report_error_detected(), and implement device locking for the affected
>>> subtree. Endpoints require locking the PCI device (pdev->dev) and the
>>> CXL memdev (cxlmd->dev). CXL ports require locking the PCI
>>> device (pdev->dev) and the parent CXL port.
>>>
>>> The device locks should be taken early where possible. The initially
>>> reporting device will be locked after kfifo dequeue. Iterated devices
>>> will be locked in cxl_report_error_detected() and must lock the
>>> iterated devices except for the first device as it has already been
>>> locked.
>>>
>>> Export pci_aer_clear_fatal_status() for use when a UCE is not present.
>>>
>>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Follow on comments around the locking stuff. If that has been there
>> a while and I didn't notice before, sorry!
>>
>>> ---
>>>
>>> Changes in v12->v13:
>>> - Add guard() before calling cxl_pci_drv_bound() (Dave Jiang)
>>> - Add guard() calls for EP (cxlds->cxlmd->dev & pdev->dev) and ports
>>>   (pdev->dev & parent cxl_port) in cxl_report_error_detected() and
>>>   cxl_handle_proto_error() (Terry)
>>> - Remove unnecessary check for endpoint port. (Dave Jiang)
>>> - Remove check for RCIEP EP in cxl_report_error_detected(). (Terry)
>>>
>>> Changes in v11->v12:
>>> - Clean up port discovery in cxl_do_recovery() (Dave)
>>> - Add PCI_EXP_TYPE_RC_END to type check in cxl_report_error_detected()
>>>
>>> Changes in v10->v11:
>>> - pci_ers_merge_results() - Move to earlier patch
>>> ---
>>>  drivers/cxl/core/ras.c | 135 ++++++++++++++++++++++++++++++++++++++++-
>>>  drivers/pci/pci.h      |   1 -
>>>  drivers/pci/pcie/aer.c |   1 +
>>>  include/linux/aer.h    |   2 +
>>>  4 files changed, 135 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>>> index 5bc144cde0ee..52c6f19564b6 100644
>>> --- a/drivers/cxl/core/ras.c
>>> +++ b/drivers/cxl/core/ras.c
>>> @@ -259,8 +259,138 @@ static void device_unlock_if(struct device *dev, bool take)
>>>  		device_unlock(dev);
>>>  }
>>>  
>>> +/**
>>> + * cxl_report_error_detected
>>> + * @dev: Device being reported
>>> + * @data: Result
>>> + * @err_pdev: Device with initial detected error. Is locked immediately
>>> + *            after KFIFO dequeue.
>>> + */
>>> +static int cxl_report_error_detected(struct device *dev, void *data, struct pci_dev *err_pdev)
>>> +{
>>> +	bool need_lock = (dev != &err_pdev->dev);
>> Add a comment on why this controls need for locking.
>> The resulting code is complex enough I'd be tempted to split the whole
>> thing into locked and unlocked variants.
> May not be a bad idea. Terry, can you see if this would reduce the complexity?
>
> DJ 

I agree and will split into 2 functions. Do you have naming suggestions for a function copy 
without locks? Is cxl_report_error_detected_nolock() OK to go along with existing 
cxl_report_error_detected()? 

Terry

>>> +	pci_ers_result_t vote, *result = data;
>>> +	struct pci_dev *pdev;
>>> +
>>> +	if (!dev || !dev_is_pci(dev))
>>> +		return 0;
>>> +	pdev = to_pci_dev(dev);
>>> +
>>> +	device_lock_if(&pdev->dev, need_lock);
>>> +	if (is_pcie_endpoint(pdev) && !cxl_pci_drv_bound(pdev)) {
>>> +		device_unlock_if(&pdev->dev, need_lock);
>>> +		return PCI_ERS_RESULT_NONE;
>>> +	}
>>> +
>>> +	if (pdev->aer_cap)
>>> +		pci_clear_and_set_config_dword(pdev,
>>> +					       pdev->aer_cap + PCI_ERR_COR_STATUS,
>>> +					       0, PCI_ERR_COR_INTERNAL);
>>> +
>>> +	if (is_pcie_endpoint(pdev)) {
>>> +		struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
>>> +
>>> +		device_lock_if(&cxlds->cxlmd->dev, need_lock);
>>> +		vote = cxl_error_detected(&cxlds->cxlmd->dev);
>>> +		device_unlock_if(&cxlds->cxlmd->dev, need_lock);
>>> +	} else {
>>> +		vote = cxl_port_error_detected(dev);
>>> +	}
>>> +
>>> +	pcie_clear_device_status(pdev);
>>> +	*result = pcie_ers_merge_result(*result, vote);
>>> +	device_unlock_if(&pdev->dev, need_lock);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +/**
>>> + * cxl_walk_port
>> Needs a short description I think to count as valid kernel-doc and
>> stop the tool moaning if anyone runs it on this.
>>
>>> + *
>>> + * @port: Port be traversed into
>>> + * @cb: Callback for handling the CXL Ports
>>> + * @userdata: Result
>>> + * @err_pdev: Device with initial detected error. Is locked immediately
>>> + *            after KFIFO dequeue.
>>> + */
>>> +static void cxl_walk_port(struct cxl_port *port,
>>> +			  int (*cb)(struct device *, void *, struct pci_dev *),
>>> +			  void *userdata,
>>> +			  struct pci_dev *err_pdev)
>>> +{
>>> +	struct cxl_port *err_port __free(put_cxl_port) = get_cxl_port(err_pdev);
>>> +	bool need_lock = (port != err_port);
>>> +	struct cxl_dport *dport = NULL;
>>> +	unsigned long index;
>>> +
>>> +	device_lock_if(&port->dev, need_lock);
>>> +	if (is_cxl_endpoint(port)) {
>>> +		cb(port->uport_dev->parent, userdata, err_pdev);
>>> +		device_unlock_if(&port->dev, need_lock);
>>> +		return;
>>> +	}
>>> +
>>> +	if (port->uport_dev && dev_is_pci(port->uport_dev))
>>> +		cb(port->uport_dev, userdata, err_pdev);
>>> +
>>> +	/*
>>> +	 * Iterate over the set of Downstream Ports recorded in port->dports (XArray):
>>> +	 *  - For each dport, attempt to find a child CXL Port whose parent dport
>>> +	 *    match.
>>> +	 *  - Invoke the provided callback on the dport's device.
>>> +	 *  - If a matching child CXL Port device is found, recurse into that port to
>>> +	 *    continue the walk.
>>> +	 */
>>> +	xa_for_each(&port->dports, index, dport)
>>> +	{
>> Move that to line above for normal kernel loop formatting.
>>
>> 	xa_for_each(&port->dports, index, dport) {
>>
>>> +		struct device *child_port_dev __free(put_device) =
>>> +			bus_find_device(&cxl_bus_type, &port->dev, dport->dport_dev,
>>> +					match_port_by_parent_dport);
>>> +
>>> +		cb(dport->dport_dev, userdata, err_pdev);
>>> +		if (child_port_dev)
>>> +			cxl_walk_port(to_cxl_port(child_port_dev), cb, userdata, err_pdev);
>>> +	}
>>> +	device_unlock_if(&port->dev, need_lock);
>>> +}
>>> +
>>>  
>>>  void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
>>> @@ -483,16 +613,15 @@ static void cxl_proto_err_work_fn(struct work_struct *work)
>>>  			if (!cxl_pci_drv_bound(pdev))
>>>  				return;
>>>  			cxlmd_dev = &cxlds->cxlmd->dev;
>>> -			device_lock_if(cxlmd_dev, cxlmd_dev);
>>>  		} else {
>>>  			cxlmd_dev = NULL;
>>>  		}
>>>  
>>> +		/* Lock the CXL parent Port */
>>>  		struct cxl_port *port __free(put_cxl_port) = get_cxl_port(pdev);
>>> -		if (!port)
>>> -			return;
>>>  		guard(device)(&port->dev);
>>>  
>>> +		device_lock_if(cxlmd_dev, cxlmd_dev);
>>>  		cxl_handle_proto_error(&wd);
>>>  		device_unlock_if(cxlmd_dev, cxlmd_dev);
>> Same issue on these helpers, but I'm also not sure why moving them in this
>> patch makes sense. I'm not sure what changed.
>>
>> Perhaps this is stuff that ended up in wrong patch?
>>>  	}
>>


