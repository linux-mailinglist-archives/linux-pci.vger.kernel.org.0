Return-Path: <linux-pci+bounces-21291-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD860A32B66
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 17:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 088D11886822
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 16:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BDB211297;
	Wed, 12 Feb 2025 16:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iuvHRKS+"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39BA1D516D;
	Wed, 12 Feb 2025 16:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739377238; cv=fail; b=laOA/wFjudAVXAI+mIbAY/RzIXimkq9NKd4e7E0npNJM92fkuczAo3W1m79RoOmCU+nqDkIr0dpGPtxyzjxTT7EMKp7Bzu3BYj/NWPKzcAekrL6cFsg5Y3I7pkt0KiVQoWeZttY+zZthX+ZEvud0WwOC6ThJbub6Ue6Q8CC2FOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739377238; c=relaxed/simple;
	bh=vY7lFWPZ8SIkAlPfgfI4Lmta1bkg9/pP39xsrmamkpg=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=shsNJ0XUGlY+dEPjA82Zdw7JtXExQkJpbUAhgf5DGIYgzmKeARn/244ZvL9ZHgGGkid3l2RLmBJHOnhLlq8FG4DM0zoiKDZ0lneXtcbQOfpokL+TkiVftggxMA69nrtQdz+fnS1pV+PN6K3ep1VCYyp+SjVD47rLJXr8q+HX10c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iuvHRKS+; arc=fail smtp.client-ip=40.107.223.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FOZUP+dMxJQeNTrVVHP8FYZfWVIO6TnxMZwyVhLWK2nUOTlAz20ZLb6E7KbfpFSGdaD+ZDyzr1uctz5wK5BsrWWBdwSvtWoi0U/xEy4fscu9+LGrjWVEuofDz727BXDnavcYY+1UPAGaJCMb/k16fM52ot6hBKi+3pAUS3NVBv2S5kpFStpjT7YWJCz8V4xEov8dWqI8Y94tv5NUopCLC8U1r7OvvsMfDBPPYEbIZzGsxJneSpr/EdNhNcm4957qly97zTKcGUpJSzDiQqrwaopyv4dsNa+aNz8XAdMNOJIkV8Njm822j1OR9mDJ1Ja6UzycPow5xH2pWJKRwichIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FUIHPwb6KItmUzUaRtVcrNw00YsFT4POS1Az5E0en4c=;
 b=oS9WHH07O8CufaBTBCbVQ5UqdSqdtYCx6Tnts/t+lYBSchYF0yN0Y6U2rvhpvk02cdByPr+5y+lmZUJ8G9gbqX/uZXIKTep8MlRQYOa+ksf5FwZRtga+ctIs0SB2ZKRfWyE2Ua8F/MYcmZ9OlGOGmsza0shkJmQOL9jY/6rEw7gdW16rwhgkvzyOOlCcCP+JGeqnv7Z2vJBpwqC4NFecvyOn/hRQWBdJWm/2NzodogDqy9QKUb57qrWuGvvyQTE7rE9uGSLFbdgITA6c8q77gso6uJGwV6S9kWY74EG7yRiAu3GufC0xbONyejzKOCVuQRtak/GVXcvbyWCqxTW9cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FUIHPwb6KItmUzUaRtVcrNw00YsFT4POS1Az5E0en4c=;
 b=iuvHRKS+OWu2ZeSiWsomjarTGzW5UmqxdYuSPnxTUSeTEQIgDLm/dtxaAXEmzKfYACab7H3CIrOKGyFf+GxuZSSJMGlonUGPBHByQp+6luIIYcPgPRqixUQhAIDXW6h/n3tH1KAGrIOhuC13Nvb1XBkvYsETJomZauviyLrdc+s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 BL4PR12MB9508.namprd12.prod.outlook.com (2603:10b6:208:58e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Wed, 12 Feb
 2025 16:20:33 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%3]) with mapi id 15.20.8422.010; Wed, 12 Feb 2025
 16:20:33 +0000
Message-ID: <84ef3743-5f55-4278-995b-bc9ff013be4b@amd.com>
Date: Wed, 12 Feb 2025 10:20:29 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 14/17] cxl/pci: Update CXL Port RAS logging to also
 display PCIe SBDF
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 nifan.cxl@gmail.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
 ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com
References: <20250211192444.2292833-1-terry.bowman@amd.com>
 <20250211192444.2292833-15-terry.bowman@amd.com>
 <0f8f7891-5d2a-4470-8427-6282f7bc3351@intel.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <0f8f7891-5d2a-4470-8427-6282f7bc3351@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0157.namprd13.prod.outlook.com
 (2603:10b6:806:28::12) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|BL4PR12MB9508:EE_
X-MS-Office365-Filtering-Correlation-Id: 4139be68-9179-409e-331f-08dd4b812cb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eG5sY0tzZmRvektIbUNXcVVDakhqajMzYVZOUzZZdkllSzVzdVVTcGthTkg2?=
 =?utf-8?B?Nmh2cU9YWmZ1Ylg5Uk83T3pyRENUajBVN0lJcVNzOVZvYTZGOU1MakpEL2FT?=
 =?utf-8?B?d1djcTdoenJ1a2ZlS2R0RU1TNUt5NDg0cHJ2cXNzNmdjcklvZFZyTFR6Z1Y5?=
 =?utf-8?B?UUhhTTVTVFVOT1UvYVFGNFl4Slo3ZVhiUm9SQnV3SGFYMUZGY1Qza3JDVGZw?=
 =?utf-8?B?S0t1K2dvK1Z5ZlQzOS8vTE4vQ2Vkd21Vc0syRHV2NHVISGdxWlIrRThhaGp5?=
 =?utf-8?B?OEVIUlY2S3JrazM4cDRrZVdKdHpSRHVEWUpvU2UzWE9xZGNrSzBhdnl5Mmlj?=
 =?utf-8?B?T3RhK3pRa1pqTUFRdjU1aUhsVmtyMHE5aXFlcFdTYmNGVnBpVks1bGVzNGk0?=
 =?utf-8?B?NXgvNDVISjVaUXBTMkNMdWRTdFdZMWJxRmNkQWR6NlUxeU12cmQxQkVKR2Fp?=
 =?utf-8?B?cHNHZlRudzR3eUZZU1ZnTGFLcmN0S2MzRjZJdHQ0SDFWK1Y2YXZIMnFXajRl?=
 =?utf-8?B?TlUzbDhsc2czYWRWTWM1ZHRXQjZyYm1yQ0NXZWxnaXlrUFVRVDVnbWN0cVZw?=
 =?utf-8?B?SHk2RmlYSEU5TGZEdGVNMEkxNHdrTzkvcjdiMDlQRFFhVGZiTkdsRm1EOEZJ?=
 =?utf-8?B?MzFnNFJuVDduWDNXSWMzdlk2RGZ2eU4yd0xsNkd3cDNHcGhQc1drbHJtcS9y?=
 =?utf-8?B?QzdhZ2x4TUdkb2RDOGwxWmd2NEl2QWhSVHkxOTdHS1M4dCtvZUd2UUlPcVpm?=
 =?utf-8?B?eTFQcmFGMGM4YitJTlhTYkhyWTBqMlp6WS9DeVRqY0h4WUxCNm5jQmVSdG9j?=
 =?utf-8?B?cndjR1FMNzVPaGZiOVh2b1BrUktRVVMrVDBXT1V0d1lVYVd2RE5RTXBTV05P?=
 =?utf-8?B?R3g5Mlp6NjFadmN2bEh1R0JBWCs3Z2ovYzFhVFJqN28zbjV0K1dlV252UW1k?=
 =?utf-8?B?U1VoV1oyUkt0cjFZU29YS1dEdENPZmp5dzBsQnU4Y2lsOUFFUkZHSDhXTjlT?=
 =?utf-8?B?QXdaVUNTMWdmcVBYY1JOeklRRGJreFBVWDFlTFpOU3ptSjNXOEcyd0hZVkF0?=
 =?utf-8?B?Qi9XcjZ4bytGY2dGd2FiRzdpSGl4Nk1LMzBTRGNRMWdqaWdSSytnZ2NBck8x?=
 =?utf-8?B?VDl1eUlMYTZHK0NvVXIwaGRtaUVIdXh6ZEhhWnJ4NTdwSFV1UDRlSUhoR0E0?=
 =?utf-8?B?dDV6b2dFUFZ6aE9hTjBKeDU2OVJVaTM0cTUyWjFPdkJmSlg4YkRaVXUzUTZC?=
 =?utf-8?B?elBKZlpZNndPVGN0bHU3eER0NTgzSXhqb3E0bytkR0Zyb2QvdGhsMmYvZDFM?=
 =?utf-8?B?czNnVFliN08wMStWU05NSXJhQWt0TlQ3YUFaMnpuM2J5UWZ2SExIWnZvTE5Y?=
 =?utf-8?B?Q1ZFNlIzWHJkY2xONnBPaVNIak5ZUjEyTStoVm5QdGllREpJKzg5Q0dsUTJD?=
 =?utf-8?B?V2cvaW9abndvTHFZR2xqVGpaZWc5bFNjbENFVHU4eXA1SnovMjFCcE05M3oz?=
 =?utf-8?B?YlFNZTNWZm41OFIxWjBCZzZxdWo3ekJxTEg0cHI2K2FVMDZDWHFDU2IxVkRI?=
 =?utf-8?B?K2I4K2FkQTNkSlRHcTdxQkNrK0UvK1VCbEc2M2IzTklVWUhSbkh2WElNRjhX?=
 =?utf-8?B?d3RyMUlzWWE3SnJOeDkydUMzZlM5T2VOTTZYRzdDMFlwQTZaQ1ZlZnJDbWRM?=
 =?utf-8?B?S2lNcU5QK1puZHJpMmVXWWZqUGdaNjlSRzlqT1M2SDc1eFZaOHpCdFIyc3JY?=
 =?utf-8?B?Y29xOUhRVmxFNGRWbjBvdHJEL0pnSWtCRTlGT3JpRERtUGdjNVZTb0xrWU1p?=
 =?utf-8?B?UmJIMWN4MTRKSE5kQURlOVVOemtCZ3pwVU1oTVJJWG5hZTExbE4wSVNqL1JU?=
 =?utf-8?B?bVczOGlmZ1hMVWZDMFJ6ckpxci9GQ0ZlZUt6TFhhUVpiM0p1MERwNTR4SUYr?=
 =?utf-8?Q?x/vc61cwxl4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHd1akxWUUVEWW51K0FkL0t5L3lJKzV2VmNqTGJtK1p5Q3NDcUVEcEZPSDVG?=
 =?utf-8?B?b2tDbHlCajdDS2tsM1N4RktlNC9YRnZ0azNvYWFEajZzSUhqRDdhaDVmMFUv?=
 =?utf-8?B?TC9USFYySGxqNnY2SWxaM0xEUlNyZjlIYUFjaURzTDA3clZmODI4V3Z4S0pQ?=
 =?utf-8?B?UXl3UnpadzRXcy91Q3drQXdXdFhpSzJHV01vZEFIYWNZTHFTQVBzdEIrdDU2?=
 =?utf-8?B?SjUzcG5Hc21DWm5RR1lpZHRWNXoycjhJRytaTHUvbkRpQXR5aVZkWTAyS1Za?=
 =?utf-8?B?c0NNSEY5WGx2U0ZJcE1jbWRlZ1cvWldvRFFyQ1drNkpUeHRad01yRkdwa20w?=
 =?utf-8?B?Zk95Y3hjRklzMW9YRGU1UDdrb1FqekRGNkNtSFVTYjAzN1JXaGRDT2s2Y1Bw?=
 =?utf-8?B?ZjhxSzNpMkRZZTNPZWlUdkpxYnppU24zN08wK2VxWll2RGVpcURhSmdUOWxY?=
 =?utf-8?B?Y0Y1aXZWUTZSS0lyK3grTDhYV0pvam5CcTJ1UThuK0xMTEUyMDdBcWpMcVlS?=
 =?utf-8?B?b0ZHRUZXYkFCczhoSTBEMTBBZC9WendzK253cmgvbEt2MXVtVzFkV2pzNEtj?=
 =?utf-8?B?TC9ZdFR5UW10YzdLT3QzYVJxeHo1L0VWbjlTMmhqMmYrbEdFbnZtTU5qMGlv?=
 =?utf-8?B?WVpPUTVkRnduczN0WVEvSkZiM3dLaS9HajIyRXR4eEV5Y05LV2NRQnR4NEMw?=
 =?utf-8?B?QmxKZDQzMDRsblc1NUdSTnJZSEY4czBRYWl6eWRvUkJic1ZTWnlyU3IyZkQ1?=
 =?utf-8?B?MGdzZ0tpK3VhV1VONDhCNW12K2d1KzJKd3hCbEwrbTQvSFZLYTFLWXBjZWVv?=
 =?utf-8?B?Rk4zQ1JFY3hTcDA1VVNzNUdvQS9Nd0U0MDZXbWJLOExjSlZESzgvNTdsellL?=
 =?utf-8?B?Sm55OUJsL3MxL1dJTnJsc3ptcjZsRXBLQkViN0FBMVYvTlhrSXQ0bk9kL3Nj?=
 =?utf-8?B?WU05U3l6U1J0VzBYbDZTeDBJcWkxa1FSajhvV01jaDRMMkpNdmY5Y3VZODNp?=
 =?utf-8?B?T2tPYm5CTnZSVm1wM3N1RjUyY2M3R0xzYmFnWmRJUWVQVk5sT05TMEF3Y2R3?=
 =?utf-8?B?VlE0alEwRlAzNG1EQk54VFhxNjIra2RQczU4RVBIWHZ3SnlKbnMvdTl6ZzVX?=
 =?utf-8?B?eStCL29HNTltSDliN2RZc2E2cUs3Q1VsWFZYbTI0K3dJMGllTUlUS0VPS3ZQ?=
 =?utf-8?B?aW5HTDhwL0h1TFN3c2hLYi85ZGxEM3QyTXNZcENPTTBnS3VIQ3lydTA2OXdB?=
 =?utf-8?B?M0cxRHV2RXV3K3RKTWcrZm5yLzc2V3J6YjJKWHZ2S3UwSWRZNmZ6dFUyUDE5?=
 =?utf-8?B?MFJETUZLc005ekpodThEY09KUnBtckw1R0pWb21hQnFSZDFxU25NaDNxV0RV?=
 =?utf-8?B?OFoxNzFJbHo5U1B2ajJ3UmFxRU81eldxa0R3YzB5RkVLRHV1NkJhVHpzMXNw?=
 =?utf-8?B?YkFyNXdkdVJhaWN5cWtHT2xtYVJKYVNnSXlod0RVNHhFSWYrS2dIYkpWT3Rq?=
 =?utf-8?B?akdhUjZ4SlFvZDFyUDVsV3JiQ0hVZGlaRUFVSUpNNHBybkVJTG5WUENHQVQv?=
 =?utf-8?B?RE9xQzRCamhoT2lmNlMzSWM0bVVMSlFoUXJFVlNtVlp3TFh5Z1ZMQTZCTFVn?=
 =?utf-8?B?ZWxZWThKUzBqRVdUZ1p0QllPQmVhZzB6M094Y3dRNC9iZEd6ellEWnhiTHR3?=
 =?utf-8?B?ZStPSjdFM2EvSjU4djkvQlVDREg1dnp3MzF0dGYxSkI3eVU4VTlENEhQc1Zx?=
 =?utf-8?B?Z3I4ZFhPZXpSMFhMcEkwU3kwdlcyeXBkaDM2WnQvNmZvR2FsUTdmdEJ3blZX?=
 =?utf-8?B?a3lCeElaN2c0dlVpbWVRWDZpUE9wNFBObUkrU0tQWVZGNllXYTN6VXViSmdw?=
 =?utf-8?B?MzFPdk5vM25rbmRRREUvOWlhZTBPd1ZPSHQ4L2djSlBya09NT2I1RDRmZTRO?=
 =?utf-8?B?NTJoT25KeWlveDNwOU9GV2tybEE3ZTAwZmFXSU8yQlYrRmVUVURHK0s4ZFph?=
 =?utf-8?B?RFVJMVpKLzNwc1FRZFZvOFpJdklSQU80V2YwNk9RVkpWQXpJa3ZNbm1oWlpL?=
 =?utf-8?B?UGYrOTRUd2lvSXQvWTk0WFRBbHZTMVZFd0RYa21SNE9IR3hlNW1FNEU4WS9n?=
 =?utf-8?Q?h36GNIl95KCYiXUdm+aehD1o0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4139be68-9179-409e-331f-08dd4b812cb0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 16:20:33.0964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YN8NXRQmsVQl5CS2sBL81/2tC12DeGhwULn/lGFyp26po+Y1MsgNHD9Nb/Il2Kq+wJsLsYF86o5Dm3+qyh2UhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9508



On 2/11/2025 6:21 PM, Dave Jiang wrote:
>
> On 2/11/25 12:24 PM, Terry Bowman wrote:
>> CXL RAS errors are currently logged using the associated CXL port's name
>> returned from devname(). They are typically named with 'port1', 'port2',
>> etc. to indicate the hierarchial location in the CXL topology. But, this
>> doesn't clearly indicate the CXL card or slot reporting the error.
>>
>> Update the logging to also log the corresponding PCIe devname. This will
>> give a PCIe SBDF or ACPI object name (in case of CXL HB). This will provide
>> details helping users understand which physical slot and card has the
>> error.
>>
>> Below is example output after making these changes.
>>
>> Correctable error example output:
>> cxl_port_aer_correctable_error: device=port1 (0000:0c:00.0) parent=root0 (pci0000:0c) status='Received Error From Physical Layer'
>>
>> Uncorrectable error example output:
>> cxl_port_aer_uncorrectable_error: device=port1 (0000:0c:00.0) parent=root0 (pci0000:0c) status: 'Memory Byte Enable Parity Error' first_error: 'Memory Byte Enable Parity Error'
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> I wonder if there's any benefit in identifying if the PCIe device is USP or DSP...
>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

That would be nice for the user. I'll add it to the TODO list.
Thanks for reviewing.

Terry
>> ---
>>  drivers/cxl/core/pci.c   | 39 +++++++++++++++++++------------------
>>  drivers/cxl/core/trace.h | 42 +++++++++++++++++++++++++---------------
>>  2 files changed, 46 insertions(+), 35 deletions(-)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 9a3090dae46a..f154dcf6dfda 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -652,14 +652,14 @@ void read_cdat_data(struct cxl_port *port)
>>  }
>>  EXPORT_SYMBOL_NS_GPL(read_cdat_data, "CXL");
>>  
>> -static void __cxl_handle_cor_ras(struct device *dev,
>> +static void __cxl_handle_cor_ras(struct device *cxl_dev, struct device *pcie_dev,
>>  				 void __iomem *ras_base)
>>  {
>>  	void __iomem *addr;
>>  	u32 status;
>>  
>>  	if (!ras_base) {
>> -		dev_warn_once(dev, "CXL RAS register block is not mapped");
>> +		dev_warn_once(cxl_dev, "CXL RAS register block is not mapped");
>>  		return;
>>  	}
>>  
>> @@ -669,15 +669,15 @@ static void __cxl_handle_cor_ras(struct device *dev,
>>  		return;
>>  	writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
>>  
>> -	if (is_cxl_memdev(dev))
>> -		trace_cxl_aer_correctable_error(to_cxl_memdev(dev), status);
>> -	else if (is_cxl_port(dev))
>> -		trace_cxl_port_aer_correctable_error(dev, status);
>> +	if (is_cxl_memdev(cxl_dev))
>> +		trace_cxl_aer_correctable_error(to_cxl_memdev(cxl_dev), status);
>> +	else if (is_cxl_port(cxl_dev))
>> +		trace_cxl_port_aer_correctable_error(cxl_dev, pcie_dev, status);
>>  }
>>  
>>  static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
>>  {
>> -	return __cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->regs.ras);
>> +	return __cxl_handle_cor_ras(&cxlds->cxlmd->dev, NULL, cxlds->regs.ras);
>>  }
>>  
>>  /* CXL spec rev3.0 8.2.4.16.1 */
>> @@ -701,7 +701,8 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
>>   * Log the state of the RAS status registers and prepare them to log the
>>   * next error status. Return 1 if reset needed.
>>   */
>> -static pci_ers_result_t __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
>> +static pci_ers_result_t __cxl_handle_ras(struct device *cxl_dev, struct device *pcie_dev,
>> +					 void __iomem *ras_base)
>>  {
>>  	u32 hl[CXL_HEADERLOG_SIZE_U32];
>>  	void __iomem *addr;
>> @@ -709,7 +710,7 @@ static pci_ers_result_t __cxl_handle_ras(struct device *dev, void __iomem *ras_b
>>  	u32 fe;
>>  
>>  	if (!ras_base) {
>> -		dev_warn_once(dev, "CXL RAS register block is not mapped");
>> +		dev_warn_once(cxl_dev, "CXL RAS register block is not mapped");
>>  		return PCI_ERS_RESULT_NONE;
>>  	}
>>  
>> @@ -730,10 +731,10 @@ static pci_ers_result_t __cxl_handle_ras(struct device *dev, void __iomem *ras_b
>>  	}
>>  
>>  	header_log_copy(ras_base, hl);
>> -	if (is_cxl_memdev(dev))
>> -		trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
>> -	else if (is_cxl_port(dev))
>> -		trace_cxl_port_aer_uncorrectable_error(dev, status, fe, hl);
>> +	if (is_cxl_memdev(cxl_dev))
>> +		trace_cxl_aer_uncorrectable_error(to_cxl_memdev(cxl_dev), status, fe, hl);
>> +	else if (is_cxl_port(cxl_dev))
>> +		trace_cxl_port_aer_uncorrectable_error(cxl_dev, pcie_dev, status, fe, hl);
>>  
>>  	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
>>  
>> @@ -742,7 +743,7 @@ static pci_ers_result_t __cxl_handle_ras(struct device *dev, void __iomem *ras_b
>>  
>>  static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
>>  {
>> -	return __cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->regs.ras);
>> +	return __cxl_handle_ras(&cxlds->cxlmd->dev, NULL, cxlds->regs.ras);
>>  }
>>  
>>  #ifdef CONFIG_PCIEAER_CXL
>> @@ -814,7 +815,7 @@ static void __iomem *cxl_pci_port_ras(struct pci_dev *pdev, struct device **dev)
>>  		struct cxl_dport *dport = NULL;
>>  
>>  		port = find_cxl_port(&pdev->dev, &dport);
>> -		if (!port) {
>> +		if (!port || !is_cxl_port(&port->dev)) {
>>  			pci_err(pdev, "Failed to find root/dport in CXL topology\n");
>>  			return NULL;
>>  		}
>> @@ -848,7 +849,7 @@ static void cxl_port_cor_error_detected(struct pci_dev *pdev)
>>  	struct device *dev;
>>  	void __iomem *ras_base = cxl_pci_port_ras(pdev, &dev);
>>  
>> -	__cxl_handle_cor_ras(dev, ras_base);
>> +	__cxl_handle_cor_ras(dev, &pdev->dev, ras_base);
>>  }
>>  
>>  static pci_ers_result_t cxl_port_error_detected(struct pci_dev *pdev)
>> @@ -856,7 +857,7 @@ static pci_ers_result_t cxl_port_error_detected(struct pci_dev *pdev)
>>  	struct device *dev;
>>  	void __iomem *ras_base = cxl_pci_port_ras(pdev, &dev);
>>  
>> -	return __cxl_handle_ras(dev, ras_base);
>> +	return __cxl_handle_ras(dev, &pdev->dev, ras_base);
>>  }
>>  
>>  void cxl_uport_init_ras_reporting(struct cxl_port *port)
>> @@ -909,13 +910,13 @@ EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
>>  static void cxl_handle_rdport_cor_ras(struct cxl_dev_state *cxlds,
>>  					  struct cxl_dport *dport)
>>  {
>> -	return __cxl_handle_cor_ras(&cxlds->cxlmd->dev, dport->regs.ras);
>> +	return __cxl_handle_cor_ras(&cxlds->cxlmd->dev, NULL, dport->regs.ras);
>>  }
>>  
>>  static bool cxl_handle_rdport_ras(struct cxl_dev_state *cxlds,
>>  				       struct cxl_dport *dport)
>>  {
>> -	return __cxl_handle_ras(&cxlds->cxlmd->dev, dport->regs.ras);
>> +	return __cxl_handle_ras(&cxlds->cxlmd->dev, NULL, dport->regs.ras);
>>  }
>>  
>>  /*
>> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
>> index b536233ac210..a74803f4aa22 100644
>> --- a/drivers/cxl/core/trace.h
>> +++ b/drivers/cxl/core/trace.h
>> @@ -49,18 +49,22 @@
>>  )
>>  
>>  TRACE_EVENT(cxl_port_aer_uncorrectable_error,
>> -	TP_PROTO(struct device *dev, u32 status, u32 fe, u32 *hl),
>> -	TP_ARGS(dev, status, fe, hl),
>> +	TP_PROTO(struct device *cxl_dev, struct device *pcie_dev, u32 status, u32 fe, u32 *hl),
>> +	TP_ARGS(cxl_dev, pcie_dev, status, fe, hl),
>>  	TP_STRUCT__entry(
>> -		__string(devname, dev_name(dev))
>> -		__string(parent, dev_name(dev->parent))
>> +		__string(cxl_name, dev_name(cxl_dev))
>> +		__string(cxl_parent_name, dev_name(cxl_dev->parent))
>> +		__string(pcie_name, dev_name(pcie_dev))
>> +		__string(pcie_parent_name, dev_name(pcie_dev->parent))
>>  		__field(u32, status)
>>  		__field(u32, first_error)
>>  		__array(u32, header_log, CXL_HEADERLOG_SIZE_U32)
>>  	),
>>  	TP_fast_assign(
>> -		__assign_str(devname);
>> -		__assign_str(parent);
>> +		__assign_str(cxl_name);
>> +		__assign_str(cxl_parent_name);
>> +		__assign_str(pcie_name);
>> +		__assign_str(pcie_parent_name);
>>  		__entry->status = status;
>>  		__entry->first_error = fe;
>>  		/*
>> @@ -69,8 +73,9 @@ TRACE_EVENT(cxl_port_aer_uncorrectable_error,
>>  		 */
>>  		memcpy(__entry->header_log, hl, CXL_HEADERLOG_SIZE);
>>  	),
>> -	TP_printk("device=%s parent=%s status: '%s' first_error: '%s'",
>> -		__get_str(devname), __get_str(parent),
>> +	TP_printk("device=%s (%s) parent=%s (%s) status: '%s' first_error: '%s'",
>> +		__get_str(cxl_name), __get_str(pcie_name),
>> +		__get_str(cxl_parent_name), __get_str(pcie_parent_name),
>>  		show_uc_errs(__entry->status),
>>  		show_uc_errs(__entry->first_error)
>>  	)
>> @@ -125,20 +130,25 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
>>  )
>>  
>>  TRACE_EVENT(cxl_port_aer_correctable_error,
>> -	TP_PROTO(struct device *dev, u32 status),
>> -	TP_ARGS(dev, status),
>> +	TP_PROTO(struct device *cxl_dev, struct device *pcie_dev, u32 status),
>> +	TP_ARGS(cxl_dev, pcie_dev, status),
>>  	TP_STRUCT__entry(
>> -		__string(devname, dev_name(dev))
>> -		__string(parent, dev_name(dev->parent))
>> +		__string(cxl_name, dev_name(cxl_dev))
>> +		__string(cxl_parent_name, dev_name(cxl_dev->parent))
>> +		__string(pcie_name, dev_name(pcie_dev))
>> +		__string(pcie_parent_name, dev_name(pcie_dev->parent))
>>  		__field(u32, status)
>>  	),
>>  	TP_fast_assign(
>> -		__assign_str(devname);
>> -		__assign_str(parent);
>> +		__assign_str(cxl_name);
>> +		__assign_str(cxl_parent_name);
>> +		__assign_str(pcie_name);
>> +		__assign_str(pcie_parent_name);
>>  		__entry->status = status;
>>  	),
>> -	TP_printk("device=%s parent=%s status='%s'",
>> -		__get_str(devname), __get_str(parent),
>> +	TP_printk("device=%s (%s) parent=%s (%s) status='%s'",
>> +		__get_str(cxl_name), __get_str(pcie_name),
>> +		__get_str(cxl_parent_name), __get_str(pcie_parent_name),
>>  		show_ce_errs(__entry->status)
>>  	)
>>  );


