Return-Path: <linux-pci+bounces-37686-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A54BC2C10
	for <lists+linux-pci@lfdr.de>; Tue, 07 Oct 2025 23:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D423189F1F1
	for <lists+linux-pci@lfdr.de>; Tue,  7 Oct 2025 21:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B376E225762;
	Tue,  7 Oct 2025 21:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yAS2KqEC"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010058.outbound.protection.outlook.com [40.93.198.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D12248886
	for <linux-pci@vger.kernel.org>; Tue,  7 Oct 2025 21:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759872751; cv=fail; b=osWp4EGjTZfJ/l2vAoZuoX/7YRNPvqjdNYXIne/XZ5sN9zpvWeXzRS4bBY0gxSEnfYVJPLfI4VvJN9rs5LpmHGwLrZ4GLm4YeODmZiQfdEgic1JgDIe3E/ojDmvVm2gmaqwzpi7ag664eLngvXfTyoT4X7GByVd1GrUy37H8S9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759872751; c=relaxed/simple;
	bh=mONg+bDmXoQ28GAmcTp1ywIx23y/6QE/66zXlRp0t14=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rQHBFphWEZyeU5pbcCgqUAefapKGzM0HSgxoXoz3GUl9Jbm8y8HctY3X2oLPaWw0Xy6Q0hFFj1/9akCfIcrkI2PPJdb8ReDnJM3thxotgLhfRVeQlwp0yzILZa4xZN87HyAi8jylVShD9ZYL6Q31aOp159M9cj8cdakAHYBGWTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yAS2KqEC; arc=fail smtp.client-ip=40.93.198.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OMj3toEcwHNc26fPDA8J6rSUBZWMqyLwevEDKDNmr+u/NbKsa2on7lJarbEkZD0dH6bRnjECs2BlByoYz6YEDV48gtoRU6dGTk2IIvmBFeVJ0pFhA5OHD1a6e9I03bol4/wtaK2ftklx5P98BY6ncbGHhobtT9WtoUOiOn1nBd7IZVkNHRnoWr+EEqK3U6jQwoQRQ9LixA6KfUMzBTLw+KvCSimFflmDUuuT+vP3MkbcSbaHin3hYG78nHFjWUUmFqCB8YHfIyBKBTXdb2A2hR+allMaz472O2Vuj2FfZAx/O5FPCpB7OnGQbFc82u/0fqUwc4I03sIkIFTsFe5MFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4m9EIofkPexkgje/WiMkmSTxXthg7qYJzSJqD9plZ3Y=;
 b=I8hxVKJSn0G8XpTzjVcrlmhYX/38Pcap757tqhdR4/RzxldERnF2I+x4V+6d5sN5ksJ6XvZPVk6wpApRl8CqcxQCHbTYi8HhcU5QiAkn8aYMJKtgOKAwCO6qmnoz3KWflJqcmVI91z9JMj7iPVFlQ60Yu30iyUQ33FEP7tcMGgl/KOlZ0x6agiWbb1jEioPxZ0cP47rgmDlF6Q5LPG/cSKZnQZw6JXCSZW4esrPB9mMHXTRfo1MQG0QWObdLZqFUPqSLGdC/yHyAU1cXgc6pxTOFyxMSkoGihToRUvagGt/AW4HW0t05qMwTM6ij2aIS5CYXFHPf3CqzLlcrNosj8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4m9EIofkPexkgje/WiMkmSTxXthg7qYJzSJqD9plZ3Y=;
 b=yAS2KqECUFziRzAvQ24Oi0+LOpuIz7kQU0gafRnwlOP0Xkbw9V7O4pZgCHdf76VLfd+kObBKRiSQXXuXf2YxBcIKSKIDhipImiiiYIrx8BFWrmkAEiJg4Q/I8JHXdEvXR1aU1iVp6Z2iVAbN1n1BIr4wrQs1KQ804NwzlkVSNlw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by IA1PR12MB7544.namprd12.prod.outlook.com (2603:10b6:208:42c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 21:32:23 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::1e6b:ca8b:7715:6fee]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::1e6b:ca8b:7715:6fee%6]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 21:32:22 +0000
Message-ID: <b3be3792-6dbc-4ec7-af34-f80ecb516de7@amd.com>
Date: Wed, 8 Oct 2025 08:31:44 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 4/7] x86/ioremap, resource: Introduce IORES_DESC_ENCRYPTED
 for encrypted PCI MMIO
From: Alexey Kardashevskiy <aik@amd.com>
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org
Cc: gregkh@linuxfoundation.org, bhelgaas@google.com,
 yilun.xu@linux.intel.com, aneesh.kumar@kernel.org,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>
References: <20250827035259.1356758-1-dan.j.williams@intel.com>
 <20250827035259.1356758-5-dan.j.williams@intel.com>
 <f6d07595-0009-447f-b694-605625c04b8f@amd.com>
Content-Language: en-US
In-Reply-To: <f6d07595-0009-447f-b694-605625c04b8f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SY5P282CA0167.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:24a::23) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|IA1PR12MB7544:EE_
X-MS-Office365-Filtering-Correlation-Id: 94002e02-0191-4065-b5f9-08de05e8ffe6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MzBwenJYMUNQVkR0T1g1Y0dTREpsd3NuSVBpNFNodFlTRHBTeW1vTVBFbmF6?=
 =?utf-8?B?QThYZm5ZYVVtRGZyUG9CU1pnM243cVRKb2Y5cE1XMHBvcEUyVzZGclRQTVdB?=
 =?utf-8?B?dnB3eEZZWCtTR0NKR0dMaElpZVc0Rmx2YmkyT2pja05ZUWNYZW5IMlpHZThq?=
 =?utf-8?B?bU5QemZlekQraVlQVnFZbTdOY3FLK3pUMStVdXltZXJpajRLQlRYeGlBdFZC?=
 =?utf-8?B?ckVJQ1JmaTR0Y0RrVi95S3FnUlZsSmdjS3hDM251Ry8wZlpDK0ZkQWJCdnNu?=
 =?utf-8?B?akdIcGlKRVFHSTQvWFhwbk5vWXZ5NEgrTFNka1Yzc1p1bTBrWlJVMldmOHpa?=
 =?utf-8?B?eXNxY1dFNUNuaEFoWUlOK0p6b1RQcC93cTczTUNVSk9EaHhsc0RxTEYyWVNW?=
 =?utf-8?B?cGxIazJwMUZCRzBhMkQxVDkyQklPbEpORXNvaENuU1kzajR0cTgvRzJCK2tQ?=
 =?utf-8?B?SHFkNW82YU44QzBxdldPWHFud3RDdDZ0K3J1cDI2YmFiM0Z6Sk1LTUpURXQ0?=
 =?utf-8?B?a0haYk10M29LbHRLaS92K2poY2RIc01uVWZ6ZU5zSTFDNEFNR00yckoyeVBh?=
 =?utf-8?B?Q3pGNnlQd00zN1RDdlJLaEdDai9sMzZZZGdrdUV4TEhMaUFBUXFVcTlTclQ1?=
 =?utf-8?B?ZlowblNCdFNFQ1c3bERWNnkrUFJIQkF2NXZMSTY0TlRkMlE1dG9lZXdaR29M?=
 =?utf-8?B?RU5sTUZpUm1xQWZ3RUxYSHVoWThjUExLbWhNTzFiRjdlcVpiMEZJZ2NmK21x?=
 =?utf-8?B?UlEyV1JzVlpzcVozRFluc2pQK1hHTXE4Qy84bDRXWFVYNUh2bDRoQjZYRTR3?=
 =?utf-8?B?WGZmdU9VUmlOV3U4akhObEFmTDdJVTFOUGhtQXErSHdneEl5VkRHL2JJUHMz?=
 =?utf-8?B?bjJWYXNTZ1B4dmxwYzZ6dERqMUYrZXVyM3M2THVmR0hPMmlJWXZWTDNvQkc0?=
 =?utf-8?B?bEJZdjVhVHhEeEVWdE1Sczc2aXliS3dkOFp3OWdDci9wZTIvU3A5eTB3bTlm?=
 =?utf-8?B?UlQ1WEIzM0VtU3MreHpmTHBNclhSV0Z3TEw2elcwZmE3U2Vjc3MvbWp5eHV4?=
 =?utf-8?B?Q2FIQy9vM0I2VzZsNXIwV3phVkR3Sjg3S1loVVZ5SG05aFNNUncrSE1qdzF1?=
 =?utf-8?B?aVhITjcyTXVJRzUxUmE3SGgzT2lSNmc0SDBRT0RUZFlPVzJJeXlZbjNmWDJq?=
 =?utf-8?B?Y1JsQVJjK2VodG1sdGNrNGhxVlkyQUdxVHg1cGVmSW9NR2xkbW1YSVJuRXRn?=
 =?utf-8?B?UHI4U0ZiSEtnanpuQnYxTzJCK3pGaVJoRU8wZ2VJZ2pyL256S1RhYUY5WXVB?=
 =?utf-8?B?RjZZYm1VYnpRcjZPWGl3eStpdUtUYk5HRGp0YUlpVVlOWE1TNUY4cHdDK0Mv?=
 =?utf-8?B?d1VCTkNVZEtUVm5sSGs1Qld6cEhycmpUandYSVlSOU85UTBrenRNVVVXY0ll?=
 =?utf-8?B?QVMxSUc3Tm8zT1hVYVl2Mm43LzlrOHRqSEN1RGd0LytyandyMVY2RjZ1VXlk?=
 =?utf-8?B?WGlTUHpxeS9KU2Z4dGFiL0hlcGYzRjlFWUQ0VjltR2lOYXpGNnV4SWVvcy9t?=
 =?utf-8?B?NCtkL2dMNS93Z0tzVkVtN0RKQ2t3VjB1eHEyc2JmSkFBL1N5bjlpSGNmL0Mz?=
 =?utf-8?B?aTYvemVMYXJyVVdrT1BlTHNVQVlUc3FRUDlRMkk4TW82bEpBNWFycUxvQTR2?=
 =?utf-8?B?bFpCOWhwQ0RhSkdYYXBPY3cvOVlEZllLRXZQb0tYOHhnYkRaa3Q4WHI4Ky9Z?=
 =?utf-8?B?S3g1cUJUS01tTjRiOG9yWHhOS1AyeHRYNjdOM0t0SHdMQ1pycm9NdGtVTFUx?=
 =?utf-8?B?YWtrMHJHbWZyMllJVWFvTmoxdkI1aStFTXpNYTgzNHlGTW45NEJ0QTcrTEY2?=
 =?utf-8?B?R3FRcENxbHBhU25GYi9JKzc0NUNDSkFIMUh0TDZOVjZ6UldVM1VlQTRYTmhQ?=
 =?utf-8?Q?9baLAtpefvFikBguQsyCPhr5CnRJ5Qjb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1JwOXltMzdvdnU2NkRjV1NUSUJQcS9sc1lHWkVpU0NtdkMyczM3c3VuZFk5?=
 =?utf-8?B?b1JBYktRdDdVVXpsR1dQckhuM1dYN0NudWtvY1hmVDBvamZNaXpFb3MyRlRk?=
 =?utf-8?B?QmNHbEdrdjhVc0ZRcmFyK05tUjhneldOSHJnTzJEcW5aU2JuaGFpZXYrRmV6?=
 =?utf-8?B?OEJGVzdtbGpHeVNTU3d4cGY0YlNiR0l6Tnhxc2x2Vk0vT09HWEhxT05iTnU5?=
 =?utf-8?B?MVhXb2hLT2U4d2dFcjF2ZGkrNURvY01RZnIwZFJnd3FoMC96bVFRcmNrOFds?=
 =?utf-8?B?T0JCcTIwQ1RyRjVFYmg5UFVFcUJuYUpaTmFrQThxYVNrV1k5N1E0dmVhOUVy?=
 =?utf-8?B?c1pYRXE3WHZkdk8xS2Q3S0xjNFhQMkF0NzR4dnJzWmREalVwZVRvZm5LOHFR?=
 =?utf-8?B?UDdUbzg4bGI0S05VaHZDc2VicHR1SnpJQzJ6cVdFeHVDSkpML1JwNjZhL29X?=
 =?utf-8?B?czRWWFA3a0VuVHJubzdoU0dDN0RuY2xmN1hwOHBTNUpHUW5mMUg5dnBYZW9M?=
 =?utf-8?B?MURsMXFRdDBjMGJsNitmY0RBK2F5SEhuN3F1M2NJSzE1YU1oeVVyNUhoRGFt?=
 =?utf-8?B?OW9YOXVwNytFbjFJb1VlSnhaTm9abDRMM1lFZjU0eFVRSlBPS0VMbkRQVU1m?=
 =?utf-8?B?bkszNWp1TmpLN1VCc2lNWEphaDJVYUNVZXVIcDJJMUFISmpSR2xWcThYYXN6?=
 =?utf-8?B?OGNFd2NRWEI1Q3NibzNYeFprK2hTOWJYdmNIUWwrYmpCby9NcEJNYzU1bWVm?=
 =?utf-8?B?VWxqdGovQ2NLZ2I1ZHh0SzJZSzkvZGdHalNXVE9IWTlsckNRZklOMFgrM0ZD?=
 =?utf-8?B?VjZRWHh5ZTdMM1lxQnA5bU5HUjJvaXNrUUYzUnltdVFWaWJ1MlhFZFJ3VHla?=
 =?utf-8?B?enBaY0MxVFp0V0tPSlVtNDN0dE1aRWxSYzFKMnp3dGh0cjhLdmlLcEVUOGJ2?=
 =?utf-8?B?NmtGUGkrSDZ6eWZUeTRaN1IvZWw4K1YyK21LZStMdC9Bc1B2UUNHRG5NdjR5?=
 =?utf-8?B?K2Vpa3hmYU5PbW5ENDNIdGZEdjVKcUpCd2huMitRTnowKyt2Ui9Hekd5blZy?=
 =?utf-8?B?bTVxTU1jdmk0b0MvYmwrNHBmSmpTY0lqQk5nbjhkcmJDTzdXdzZJNVBmSmhz?=
 =?utf-8?B?M3RGRGV4MjRXZ2VHOWZVUFJsYzI2YWs2VVlseDJySWNQTlE4ZzNSRFBmVzJS?=
 =?utf-8?B?ZEJ6OUNLQWZza1l5VVZhT3p2UThERUx0ckZ2ZVZZdXlkZ3hDanJycmpYa2pr?=
 =?utf-8?B?RjZpTHpWeExhZmtvbzJPUGNGYVNYa3JUUkR5cXkySDBVc09FdEUrem5BN1A5?=
 =?utf-8?B?ZHl1UlpuVVAwZmNjamNpVlRDdFlPbmRGMUwycEo2Uy9QYk9LZGJFbGxtUE0w?=
 =?utf-8?B?WlJZWndKZUJoL3VKWGF0WHRGK05HZ1FER0dsT2I3Z09NTFI0cnRFR0dHdEht?=
 =?utf-8?B?ZGx4UVRKanIvWEhkK2pMTDBnUzZCYkkwTXpTeU4ycis3OHN6TEkrc3RPMnkr?=
 =?utf-8?B?WXl3bWhBSnZwRmd2Q1Z4a2VURFp5alh5Sm5wM2JZSy9YUlZtcllVREQvUHRD?=
 =?utf-8?B?Vk1sOUd0NEs2OTAwellGYW9Mb1RkZlZFeHI0NVpldnFUV3ZlN2VBZVMvWUFu?=
 =?utf-8?B?N05pSkJ3RCtUdit0cDRkY2k5NWhYcEZZTWFFRVE1RWNIaWF1T2R3REVsazRO?=
 =?utf-8?B?ZmhBenV6Ymd2TzdsVWFvNGZjWW5wWllNdW5FcTRVU1EvOGxndUVIRW9WSmNa?=
 =?utf-8?B?VTZzWGpWQmVHU2tEdlIrWld3NlhtcHZNUWdURFdyNzUzZ1JtaEk4RGFqMUdB?=
 =?utf-8?B?Si8zR08yVkRpNHBoUS9waWlyUnN4UjhYTEdzNi9hMjd3WG1udjl5T1B4T0tU?=
 =?utf-8?B?dEU0OG1pelhiWUk0MC9IYjQ0a1F5RWh3OHhyKzU4RVpxK28wRWo4NENGdE1S?=
 =?utf-8?B?bjZlZWJJclQ1UWluUndERGVGc1Flb0hnZExiSzNadmRobWhDcmtEMmRDWlJB?=
 =?utf-8?B?d2ZOdE5uYk5WR05jQkZ6Rk9HMDEwNU1KNHBOOGxqdjZvbDZyZ3pNV010cTg5?=
 =?utf-8?B?TG1pcGJUYmhiOEI0R1ZsSUlZTXJlcEp3MEJnL0ZmdE1uaWVzbVVXeGFIY2tL?=
 =?utf-8?Q?8YwXOrT+TPSASfSzKDpsjShyF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94002e02-0191-4065-b5f9-08de05e8ffe6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 21:32:21.9823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VE3l8cyz5b1OM5nddCx7kjyBxq5qiLrJftGgkqw1Mf02pZpftjLmzHPHFSRIxxxQB5oHBoZ5BK4uMBiJeJjuVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7544



On 7/10/25 19:23, Alexey Kardashevskiy wrote:
> 
> 
> On 27/8/25 13:52, Dan Williams wrote:
>> PCIe Trusted Execution Environment Device Interface Security Protocol
>> (TDISP) arranges for a PCI device to support encrypted MMIO. In support of
>> that capability, ioremap() needs a mechanism to detect when a PCI device
>> has been dynamically transitioned into this secure state and enforce
>> encrypted MMIO mappings.
>>
>> Teach ioremap() about a new IORES_DESC_ENCRYPTED type that supplements the
>> existing PCI Memory Space (MMIO) BAR resources. The proposal is that a
>> resource, "PCI MMIO Encrypted", with this description type is injected by
>> the PCI/TSM core for each PCI device BAR that is to be protected.
>>
>> Unlike the existing encryption determination which is "implied with a silent
>> fallback to an unencrypted mapping", this indication is "explicit with an
>> expectation that the request fails instead of fallback". IORES_MUST_ENCRYPT
>> is added to manage this expectation.
>>
>> Given that "PCI MMIO Encrypted" is an additional resource in the tree, the
>> IORESOURCE_BUSY flag will only be set on a descendant/child of that
>> resource. Adjust the resource tree walk to use walk_iomem_res_desc() and
>> check all intersecting resources for the IORES_MUST_ENCRYPT determination.
> 
> How is this expected to work exactly?
> 
> samples/devsec/tsm.c calls pci_tsm_alloc_encrypted_resources() which essentially does:
> 
> *__res[i] = DEFINE_RES_NAMED_DESC(pci_resource_start(pdev, i),
>                                    len, "PCI MMIO Encrypted",
>                                    flags, IORES_DESC_ENCRYPTED);
> if (insert_resource(&iomem_resource, __res[i]) != 0) {
> ...
> 
> By later on pci_iomap(pdev, N, PAGE_SIZE) on that BAR maps as unencrypted. The resource makes it to (hacked) iomem:
> 
> c000000000-c7ffffffff : PCI Bus 0000:00 fl=200201 desc=0
>    c000000000-c01fffffff : PCI Bus 0000:01 fl=102201 desc=0
>      c000000000-c003ffffff : 0000:01:00.0 fl=14220c desc=0
>        c000000000-c003ffffff : mydrv fl=80000200 desc=0
>      c004000000-c004000fff : PCI MMIO Encrypted fl=14220c desc=a
>        c004000000-c004000fff : 0000:01:00.0 fl=14220c desc=0
>      c004001000-c004001fff : 0000:01:00.0 fl=14220c desc=0
> 
> 
> and btw does not pci_resource_n(pdev, i) make more sense as a parent in insert_resource().
> 
> 
>>
>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>> Cc: Andy Lutomirski <luto@kernel.org>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Borislav Petkov <bp@alien8.de>
>> Cc: x86@kernel.org
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>> ---
>>   arch/x86/mm/ioremap.c  | 32 +++++++++++++++++++++-----------
>>   include/linux/ioport.h |  2 ++
>>   2 files changed, 23 insertions(+), 11 deletions(-)
>>
>> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
>> index 12c8180ca1ba..78b677dadfdc 100644
>> --- a/arch/x86/mm/ioremap.c
>> +++ b/arch/x86/mm/ioremap.c
>> @@ -93,18 +93,24 @@ static unsigned int __ioremap_check_ram(struct resource *res)
>>    */
>>   static unsigned int __ioremap_check_encrypted(struct resource *res)
>>   {
>> +    u32 flags = 0;
>> +
>> +    if (res->desc == IORES_DESC_ENCRYPTED)
>> +        flags |= IORES_MUST_ENCRYPT;
>> +
>>       if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
>> -        return 0;
>> +        return flags;
>>       switch (res->desc) {
>>       case IORES_DESC_NONE:
>>       case IORES_DESC_RESERVED:
>>           break;
>> +    case IORES_DESC_ENCRYPTED:
>>       default:
>> -        return IORES_MAP_ENCRYPTED;
>> +        flags |= IORES_MAP_ENCRYPTED;
>>       }
>> -    return 0;
>> +    return flags;
>>   }
>>   /*
>> @@ -134,14 +140,10 @@ static int __ioremap_collect_map_flags(struct resource *res, void *arg)
>>   {
>>       struct ioremap_desc *desc = arg;
>> -    if (!(desc->flags & IORES_MAP_SYSTEM_RAM))
>> -        desc->flags |= __ioremap_check_ram(res);
>> -
>> -    if (!(desc->flags & IORES_MAP_ENCRYPTED))
>> -        desc->flags |= __ioremap_check_encrypted(res);
>> +    desc->flags |= __ioremap_check_ram(res);
>> +    desc->flags |= __ioremap_check_encrypted(res);
> 
> 
> Here the found "res" is actually "c000000000-c7ffffffff : PCI Bus 0000:00", not c004000000 (from the above example)...
> 
>> -    return ((desc->flags & (IORES_MAP_SYSTEM_RAM | IORES_MAP_ENCRYPTED)) ==
>> -                   (IORES_MAP_SYSTEM_RAM | IORES_MAP_ENCRYPTED));
>> +    return 0;
>>   }
>>   /*
>> @@ -161,7 +163,8 @@ static void __ioremap_check_mem(resource_size_t addr, unsigned long size,
>>       end = start + size - 1;
>>       memset(desc, 0, sizeof(struct ioremap_desc));

Adding this here:

+       walk_iomem_res_desc(IORES_DESC_ENCRYPTED, IORESOURCE_MEM, start, end, desc,
+                           __ioremap_collect_map_flags);


fixed the problem and the encryption bit is set. Thanks,


>> -    walk_mem_res(start, end, desc, __ioremap_collect_map_flags);
>> +    walk_iomem_res_desc(IORES_DESC_NONE, IORESOURCE_MEM, start, end, desc,
>> +                __ioremap_collect_map_flags);
> 
> 
> ... which seems to be the result of passing IORES_DESC_NONE. What do I miss? Thanks,
> 
> 
>>       __ioremap_check_other(addr, desc);
>>   }
>> @@ -209,6 +212,13 @@ __ioremap_caller(resource_size_t phys_addr, unsigned long size,
>>       __ioremap_check_mem(phys_addr, size, &io_desc);
>> +    if ((io_desc.flags & IORES_MUST_ENCRYPT) &&
>> +        !(io_desc.flags & IORES_MAP_ENCRYPTED)) {
>> +        pr_err("ioremap: encrypted mapping unavailable for %pa - %pa\n",
>> +               &phys_addr, &last_addr);
>> +        return NULL;
>> +    }
>> +
>>       /*
>>        * Don't allow anybody to remap normal RAM that we're using..
>>        */
>> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
>> index e8b2d6aa4013..b46e42bcafe3 100644
>> --- a/include/linux/ioport.h
>> +++ b/include/linux/ioport.h
>> @@ -143,6 +143,7 @@ enum {
>>       IORES_DESC_RESERVED            = 7,
>>       IORES_DESC_SOFT_RESERVED        = 8,
>>       IORES_DESC_CXL                = 9,
>> +    IORES_DESC_ENCRYPTED            = 10,
>>   };
>>   /*
>> @@ -151,6 +152,7 @@ enum {
>>   enum {
>>       IORES_MAP_SYSTEM_RAM        = BIT(0),
>>       IORES_MAP_ENCRYPTED        = BIT(1),
>> +    IORES_MUST_ENCRYPT        = BIT(2), /* disable transparent fallback */
>>   };
>>   /* helpers to define resources */
> 

-- 
Alexey


