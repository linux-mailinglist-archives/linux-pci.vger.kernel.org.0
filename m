Return-Path: <linux-pci+bounces-21868-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C03B0A3D05D
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 05:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9329F1779A4
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 04:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D066B1DF992;
	Thu, 20 Feb 2025 04:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gnjy0MwI"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36571DEFFC
	for <linux-pci@vger.kernel.org>; Thu, 20 Feb 2025 04:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740025191; cv=fail; b=UMfwEE+kBrmOSBuY1q1UkdFgJTQaNQVkT1KrVit9vzCdUJ7+ek67DweHe/uf2T74/kcCjD0WXPreKNzgzlmDFBCG5IWnNS5/lcBVIYZAu2vYwofWPTBZfPIsbRwgwgNn2wX0/CaXniMBzQW9lnWiGnMvOSj059h6TkHXwN1YA8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740025191; c=relaxed/simple;
	bh=0F9Fz6Iv5IXSBaG+Wczpe9l/k3iJvNCkZ4rSctwSvg4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ageGgHBhr5WhQrcROr72HX+KjEMxpYJkuM/4iI0dm0MQSMeF32k1G/kRBdzyXJSF/wAjhdSFfMoQ8XIHNL0Ge/BQ1ypc/D2D2tM3wYGfkNQvmYiIfGn0Bu42TIfWuFpmJkt+BfIMLD42jiZafGeY4lW97+nt53CVbz6Lq5XxNmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gnjy0MwI; arc=fail smtp.client-ip=40.107.92.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AfH1a5rE4pDCjjNUViDIzYo18uOVRp41+J3ut+xfHJhcyY+GpE7gqGCIGB6DCaPa3M7KXWAD5viRmvx/rkQiucZryCcDtWrD6NOQR/5gp6S4Qz1Vp4/p6oV1cwnJV4+BhqUOGwJj6e7f1LhNPHWyTyOk8R984SBgHdckd8Pm8n9B9REW8p3Vfd7Hm3kgkuSeMSfuXscQExLcUGEm6g+ROcz+lUXBoTklWtcJC2KHsbTCISfnippEHPtEbkKGWgWdTqLCggZCW+6bwO8q+1PY7MGy+QndRP4AbCBAban1Vr5udUGaH2m5kOyjX0lhWu7v38ItcyWAmVIKPE6a9fo+eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zEQ1ujIi79LqyqJ6kw36dlrsmB+G+0mqSc8DevuTQBY=;
 b=xo/4QKX/OK+0MjXNmLmC3oOFIbqYssA+WDZ+FTVyJh58Us33HmJOxPbnWsQp6GNHEaDf3yj38keQGY98nUaD4xEz5kvagClr4edX3tZy8OoZAyIRgzTlfLIdOYoBQOwqwVeZec2x+ELa+rUKXIQuqqfeUx1/0B4oofxj3CClOL5qmiV+F4uLw/ZTvhiUTaOgHUNROGL3GMfL8velAouu06cidGGC1xDBOitpv8EY17Md2njayPKlEjNtp/mNGrYT60cKurxSeob0v8L2VFTP7tOZlSMIwgf3C73noMDVRM+UR3Mb4rjsX0n19mylmZMr/matJtbMH8FBVZSICwO/vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zEQ1ujIi79LqyqJ6kw36dlrsmB+G+0mqSc8DevuTQBY=;
 b=gnjy0MwIHMd0LdSHl5V51mt/S2etAEN6dacLRTwcH2eJEc4JtUKTFBwNst7p8XitNZHGHhsBpzQj8qXuxrPh4bkUnL3R5mBRCBrJPkmJwB7iM7G3hEG5TqCuZHcbpfw7o04MnU2/yq8Yko+VTK8Qkr0+0EPqwbkODVrTuSvtuYs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by CH0PR12MB8579.namprd12.prod.outlook.com (2603:10b6:610:182::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 20 Feb
 2025 04:19:47 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.8445.016; Thu, 20 Feb 2025
 04:19:47 +0000
Message-ID: <56d0c785-2094-49f1-8dd2-be28eae3c758@amd.com>
Date: Thu, 20 Feb 2025 15:19:40 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 08/11] PCI/IDE: Add IDE establishment helpers
Content-Language: en-US
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
 Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
 Samuel Ortiz <sameo@rivosinc.com>, linux-pci@vger.kernel.org,
 gregkh@linuxfoundation.org
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343744264.1074769.10935494914881159519.stgit@dwillia2-xfh.jf.intel.com>
 <9f151a74-cc5c-4a7c-8304-1714159e4b2c@amd.com>
 <6d50f215-93c4-49a5-9ee2-f9775b740f92@amd.com>
 <Z32H2Tzd1UHCQEt5@yilunxu-OptiPlex-7050>
 <d71dd5c5-4c20-4e8e-abaa-fe2cdea4f3b2@amd.com>
 <Z4A/g5Yyu4Whncuu@yilunxu-OptiPlex-7050>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <Z4A/g5Yyu4Whncuu@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ME3PR01CA0011.ausprd01.prod.outlook.com
 (2603:10c6:220:19e::13) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|CH0PR12MB8579:EE_
X-MS-Office365-Filtering-Correlation-Id: f42c8688-8acb-43eb-e05a-08dd5165cfaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QktxZmRIdENjbUpWL1Z3bXV2R2lRUHloeDhlVXlHUEQycXFZdVBxOGx0TFlW?=
 =?utf-8?B?TTl5ZlMwQmhBb3luV3JLcWJGTjZXV1VOT1JTYy9HTmRIeFB6RTlDeUFtaGJU?=
 =?utf-8?B?b0RwNlp6QWNncUhXZXoyN0dhWHorM0U1MHpTR2dtN2Y1MDRlVldtak1UMlNh?=
 =?utf-8?B?enZKaDZZVmNsUzNMMnpEVm5rZUFrREJlMkVJZUZNa3RGWkl5V2l0UXNyeGhh?=
 =?utf-8?B?NWl6enpvTDV3ZjJVcllJNkRhbXJuNHRXeE94dHhzajRzUnNTYlpjeWM1WTFQ?=
 =?utf-8?B?SVVHZzZKdG12blVxY2RLRHVQaVpGUDRTa1Q2SGN2djVmaFpHOUp4dklLT3lN?=
 =?utf-8?B?akd1N05zbHlqYlB0Nk5rZTFZNldHaXBRcXgvMnVSYkRGV2FWVDdXc0RlODdP?=
 =?utf-8?B?dXBzTWkxZzYwdTl2dmdKc0xTZHM2TVlvSXpCb1RSMEFGYXFzempEQjI3WlB3?=
 =?utf-8?B?d2FQU3d2Y2lmRnNqOEM0V1M3YXVpN3pOODI2MkxlcTJXMEJZVFNWUGdTZUhk?=
 =?utf-8?B?ZFRMcG83WTNwZ1BHaHozZVhka0x0VFZrV1VaK25QaUxqS2J1WGx5SmJaTnlR?=
 =?utf-8?B?NDk0RGVUR2twQlVsam9RWHNMdzd3dzVHbVBaRTN1Z1VhdUp4WXo3SHpFdlpx?=
 =?utf-8?B?N005bWxSWFhhVHd6cmZseUZpcFhvaUV3QzV3Sm44cC96azRFQUxvemhLYkQx?=
 =?utf-8?B?TXhQV1c0eFZHY0o4QnlnMVl1YWNPdkhPVDRsTmdCTWFBNXRuTXZVbWlIU0kw?=
 =?utf-8?B?ZlNRZ1JEaERpNGU2TUV6WjNKUUU0ZTZHV0R2L3ZsU1FtNFNKTnJsUE5rRW44?=
 =?utf-8?B?bCtpRkttTTN4UW5KeUtoSi8vSkUrWGhwV2p3dWxVMXQvRkdEb01NcVMzQS9Z?=
 =?utf-8?B?WkVab0g3SWlQbHhEajd4TTE5NE1EbjI1eWF5QUVvVmpZQmhrWERwREJVYTdQ?=
 =?utf-8?B?ZWZIbzAwb08zMkV3WSt0OVBjYnNSMHF0bFlwSFU4VFM1WnhETmgxZmhoWXYw?=
 =?utf-8?B?ZW9ER2h1Znk4TU41M1hjT0NvVlRFNWxyTXBONkd2K0RhRzJyMHZIZ1pVSUdU?=
 =?utf-8?B?MGlVTG5DSHFIb3VyeVZ3MCtQV1dBRXhKOUhRSmsxSW9XUnQwQlJ4OTJENno3?=
 =?utf-8?B?ZWZmSnQyU09lNkk4Y1RQbG1ORmtURVlLdS8xdTNpRlFVeFgrOHlWakNuY3Zk?=
 =?utf-8?B?dllwWVRXbnJqSnUwWWkyMUUrcjJkb1FLbjV6TzRRck8zbFVGQ0hDbno5am0x?=
 =?utf-8?B?dDZBK3Z1ZUZCanJPL2JOVlhjS2lqdktCMlFYR1NiRWN2ekczdlNPZjdwNXpU?=
 =?utf-8?B?RnpaNFBpeFRjN2Fwd0RQZzF6Vk5yMGxtNmdHMXFXQmNxeTZmSHhHZ2xrU1VD?=
 =?utf-8?B?eXNac09wOWRNZGNmZHM5a1BIQkpWbWhocTdITGlzbW5iZWkxWkgzT3pJWTQr?=
 =?utf-8?B?eVc4WTVVOG5OdVBudVRqR3AwRXoxQWREb2ZpQ0dNZ3NuWDJYQW9obkMvYXR5?=
 =?utf-8?B?OGZaMW5ZNEdVdVFkcmpvWWU2RDFRMi9WckZaKzhRMUpNTDVrbEtURUJOSmxi?=
 =?utf-8?B?eStCN0g5aEFEYXBNa2pkazljWkdlZkxWa0E3YURYNVVYVjh5VlFwVXlreXkx?=
 =?utf-8?B?dVZaY2dzUkJtS0krV3NrcGQ2NGVKWnA2TUJtSklma1lySlp4ZTV3UlFKRXIx?=
 =?utf-8?B?RzErbzJXckc0VURac1hyVk9kM3BKYVZKL2VUdlpRNkNUdHNTcDBVVlRZa2RO?=
 =?utf-8?B?WU1BUng1ckEzZHloNmljbzBWbmNISDlIa1paVUp2WnR5Y3VVWTlKNHF2UXFB?=
 =?utf-8?B?Q0grYVVZVUFNV3llTUNMRjdBSFg0TmEvLzJuSCtqbUd3Szlab3o3ZkU3ZGpX?=
 =?utf-8?Q?zpcpXmXecySZc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bFJMRlZaSDIzQkpGOTB0MS9MY0xuRy9BK1BxbkhXSDd5eUh3K1E5enlBV0Jo?=
 =?utf-8?B?TDcwTSt1elBlMWpwdnhBdXFwQUs0TkorVVFIeFdrMmdKVWxQRGtKVVV5TlZr?=
 =?utf-8?B?Tm5VV0QyTllHTDBmZlNWbDlaRVdLMldOOHIyYW9OQkF0bUVKQkFZQkdnRi80?=
 =?utf-8?B?M25uZlRmemMzaTFUQmh5SHF6QUF1S2RiYXpLOW5ZVzlWTk9hQloxZ2hkYzJN?=
 =?utf-8?B?bjFzSFQwczlmK25sUFNTKy9kYkdQZU0xbktXY1owcUJRdlBySkRobmFXRzF0?=
 =?utf-8?B?YzNJM1RQS2RXVm0yc0JDdnpJWHYwK1huWStOS0F1YVl2VlBPUEljeDkreWpq?=
 =?utf-8?B?KytXYkhMYkwxZWJCaDJBVkRKbHUvekNJWmkzaFpjTGJRYU5pVUVvNFVHQ2NN?=
 =?utf-8?B?QUx2a0ROWW9rdlNvZHJLWllvbWk0NHU0cktUekRYZ2trak96U1BaZ2cvZmpF?=
 =?utf-8?B?eUpqOXo1Z0tveElORVRCaWNEOGFDUTJQLzhRWTF2NkVPaDk4WXBmUHdGQ1hO?=
 =?utf-8?B?UUJ2b2JaUmtvbHZBYk5DVkZ4TXVtd3ZQRk9xdFZOdFN4SmQ2UjFBUE5OWmFF?=
 =?utf-8?B?OFpiNW9KTXkrS3RHc3dnSnp0TmQvaWVIM3dGNU9GclBkSVhrRUtTZENzUUJJ?=
 =?utf-8?B?NUNyU2RjQkJRaU5VbFJPRHhzVTlQL2JFeUVzekpuMVE1dmowS2pmVFNQSXBv?=
 =?utf-8?B?UVlZVnRwcU5lMmxHVmdGK1VDcmtzRitlNnladjVKVXlGbTd4eXlhYjFZOTZ4?=
 =?utf-8?B?QzlBYjNFYlBxWWFSZ0JIOCtONndFZlp0dXVHN1UzY0FiOE1KT0xiTmlWYVBs?=
 =?utf-8?B?MUJXVlQzK3NVVHFrT0Nmc2VmdkU4UStzcWE4NTczUkVlTmo1OHNBSmlxTDMz?=
 =?utf-8?B?TWFZcDVyMllzd3oxN2JxcmNzdzNrRE9TalBPaGZoa2FYUjh5UHlBSmZKNWc1?=
 =?utf-8?B?M00xQ3RLRnZ1ZGxEZFZuREZ2RWhiU1JmSCtBQnA0cFZNZWdOK0dtRDlZVC9n?=
 =?utf-8?B?d24xd2tnbDZUZ3QySnExdkZOSGk4R1BhQnR0anpTWFppZFkvZTFIdGsrSG9p?=
 =?utf-8?B?U05PbjdNbjg1M1lIOEE4cnhFQ2l2dGFrRmZ1VlUraTVJeVh5SGswQ1VBZERp?=
 =?utf-8?B?SzVCR0F6dlVFWVJPejVwMStKTEwwR05RR2NXWWxDT1lhR3ExeG5XUUlVVHBz?=
 =?utf-8?B?OE5zREgvSWtWRVJJbm8wSDUvTm9JQTRJRkJjWG53cmcxSWEzcDVKUmRzWTJL?=
 =?utf-8?B?cERJYW91a3VRY01LemFZZzI2Qm1vQWJrUXBGL1BRMm1xSllZcHpxZnliUk5m?=
 =?utf-8?B?T01udTJ1TTVOOWcyTlp4K3I0RGlMN203ZmNNbUhJVkJkNFBDdEdYeDdORXhB?=
 =?utf-8?B?QnY0L3dIOVQwQ0NEcWVpU2N5TW0yWENXanNTcnJlVzF4VXZmT3dobjBxS1M0?=
 =?utf-8?B?dkdYOEV0QzJsL0VyVkFNUW1ycGcrd2FJWDlGT1NXT281Vm9LZ2hXRVQ0N3Yz?=
 =?utf-8?B?ZDdseXcrb2w2VTFRWnhzcWhUaVRVQWRRcnIvbkZQZEVjUVBGd3Z5TFN5SXJt?=
 =?utf-8?B?N0N5M1VnNUlHcHh2OGc2WWZBVnNFMVFKU0tlam1pdHI1LzRhaml4ZVRvcU82?=
 =?utf-8?B?MlJrUmQ5MitCTEhnenlOL1hjeDZnbmZIY3lPeng3NUw2aEwyWVc4c2x0Uk4z?=
 =?utf-8?B?c0hZZndHUmRWNVEwY3EwQ003SWRCdUU4T0x3LzM2a3hiM3dwWkxBaThYZW9a?=
 =?utf-8?B?M0lkN3NCYmFjSVZsSWJEUmljenhUMGgwbXJOdlNRVUllazlKcXRTZmVGMjN3?=
 =?utf-8?B?UDA0NFhqcjhEeDhrK01YWE55NGxidTRoMFZOMUZRU1dYRU55VHNHS0JQdWk0?=
 =?utf-8?B?Y1hUZ0xQMkwrYmRVQXoydXB5UUFGajJxOVgyaWRsTDNEYVJlbVg1aEVPUEs0?=
 =?utf-8?B?N3I0bk53T0xXZkdJOGV3NmIyTjNGSm0yaDA2a0p1M04yRmRIbVUyRStHTGRr?=
 =?utf-8?B?Q0FIRFBaUTBHUTZ3OXlYaHprOEE1MUE5bTg5TW5Nb3hBeTJ6YWhKdG9SeFEv?=
 =?utf-8?B?eUpSZ25TajZ3Q0lPdU05cytQOHRjNm9RTzBKTDA1RnF0b0k5blNQcjdQMTBa?=
 =?utf-8?Q?LXKQa6Y6/GHtvAKSMBLxC5lbx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f42c8688-8acb-43eb-e05a-08dd5165cfaa
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 04:19:47.5595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NlF3Ng4YSE8rGuZj5VWRWjVv5DPT/JXNiK8bhbTaNAaEM4ujoH3DjQW/zL8nWvkl8Iz4wgxmeuz+/tUNRYIr9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8579



On 10/1/25 08:28, Xu Yilun wrote:
> On Thu, Jan 09, 2025 at 01:35:58PM +1100, Alexey Kardashevskiy wrote:
>>
>>
>> On 8/1/25 07:00, Xu Yilun wrote:
>>>>>> +static void __pci_ide_stream_setup(struct pci_dev *pdev, struct
>>>>>> pci_ide *ide)
>>>>>> +{
>>>>>> +    int pos;
>>>>>> +    u32 val;
>>>>>> +
>>>>>> +    pos = sel_ide_offset(pdev->sel_ide_cap, ide->stream_id,
>>>>>> +                 pdev->nr_ide_mem);
>>>>>> +
>>>>>> +    val = FIELD_PREP(PCI_IDE_SEL_RID_1_LIMIT_MASK, ide->devid_end);
>>>>>> +    pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_1, val);
>>>>>> +
>>>>>> +    val = FIELD_PREP(PCI_IDE_SEL_RID_2_VALID, 1) |
>>>>>> +          FIELD_PREP(PCI_IDE_SEL_RID_2_BASE_MASK, ide->devid_start) |
>>>>>> +          FIELD_PREP(PCI_IDE_SEL_RID_2_SEG_MASK, ide->domain);
>>>>>> +    pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_2, val);
>>>>>> +
>>>>>> +    for (int i = 0; i < ide->nr_mem; i++) {
>>>>>
>>>>>
>>>>> This needs to test that (pdev->nr_ide_mem >= ide->nr_mem), easy to miss
>>>>> especially when PCI_IDE_SETUP_ROOT_PORT. Thanks,
>>>
>>> Yes, but nr_ide_mem is limited HW resource and may easily smaller than
>>> device memory region number.
>>
>> My rootport does not have any range (instead, it relies on C-bit in MMIO
> 
> It seems strange, then how the RP decide which stream id to use.

Oh I thought I replied :-/ The RP gets the stream id from an RMP entry 
corresponding to the MMIO page.


> 
>> access to set T-bit). The device got just one (which is no use here as I
>> understand).
> 
> I also have no idea from SPEC how to use the IDE register blocks on EP,
> except stream ENABLE bit.
> 
> And no matter how I program the RID/ADDR association registers, it
> always work...
> 
> Call for help.

+1.


>>
>>
>>> In this case, maybe we have to merge the
>>> memory regions into one big range.
>>
>>>>>
>>>>>
>>>>>
>>>>>> +        val = FIELD_PREP(PCI_IDE_SEL_ADDR_1_VALID, 1) |
>>>>>> +              FIELD_PREP(PCI_IDE_SEL_ADDR_1_BASE_LOW_MASK,
>>>>>> +                 lower_32_bits(ide->mem[i].start) >>
>>>>>> +                     PCI_IDE_SEL_ADDR_1_BASE_LOW_SHIFT) |
>>>>>> +              FIELD_PREP(PCI_IDE_SEL_ADDR_1_LIMIT_LOW_MASK,
>>>>>> +                 lower_32_bits(ide->mem[i].end) >>
>>>>>> +                     PCI_IDE_SEL_ADDR_1_LIMIT_LOW_SHIFT);
>>>>>> +        pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_1(i), val);
>>>>>> +
>>>>>> +        val = upper_32_bits(ide->mem[i].end);
>>>>>> +        pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_2(i), val);
>>>>>> +
>>>>>> +        val = upper_32_bits(ide->mem[i].start);
>>>>>> +        pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_3(i), val);
>>>>>> +    }
>>>>>> +}
>>>>>> +
>>>>>> +/*
>>>>>> + * Establish IDE stream parameters in @pdev and, optionally, its
>>>>>> root port
>>>>>> + */
>>>>>> +int pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide,
>>>>>> +             enum pci_ide_flags flags)
>>>>>> +{
>>>>>> +    struct pci_host_bridge *hb = pci_find_host_bridge(pdev->bus);
>>>>>> +    struct pci_dev *rp = pcie_find_root_port(pdev);
>>>>>> +    int mem = 0, rc;
>>>>>> +
>>>>>> +    if (ide->stream_id < 0 || ide->stream_id > U8_MAX) {
>>>>>> +        pci_err(pdev, "Setup fail: Invalid stream id: %d\n",
>>>>>> ide->stream_id);
>>>>>> +        return -ENXIO;
>>>>>> +    }
>>>>>> +
>>>>>> +    if (test_and_set_bit_lock(ide->stream_id, hb->ide_stream_ids)) {
>>>>>> +        pci_err(pdev, "Setup fail: Busy stream id: %d\n",
>>>>>> +            ide->stream_id);
>>>>>> +        return -EBUSY;
>>>>>> +    }
>>>>>> +
>>>>>> +    ide->name = kasprintf(GFP_KERNEL, "stream%d:%s", ide->stream_id,
>>>>>> +                  dev_name(&pdev->dev));
>>>>>> +    if (!ide->name) {
>>>>>> +        rc = -ENOMEM;
>>>>>> +        goto err_name;
>>>>>> +    }
>>>>>> +
>>>>>> +    rc = sysfs_create_link(&hb->dev.kobj, &pdev->dev.kobj, ide->name);
>>>>>> +    if (rc)
>>>>>> +        goto err_link;
>>>>>> +
>>>>>> +    for (mem = 0; mem < ide->nr_mem; mem++)
>>>>>> +        if (!__request_region(&hb->ide_stream_res, ide->mem[mem].start,
>>>>>> +                      range_len(&ide->mem[mem]), ide->name,
>>>>>> +                      0)) {
>>>>>> +            pci_err(pdev,
>>>>>> +                "Setup fail: stream%d: address association conflict
>>>>>> [%#llx-%#llx]\n",
>>>>>> +                ide->stream_id, ide->mem[mem].start,
>>>>>> +                ide->mem[mem].end);
>>>>>> +
>>>>>> +            rc = -EBUSY;
>>>>>> +            goto err;
>>>>>> +        }
>>>>>> +
>>>>>> +    __pci_ide_stream_setup(pdev, ide);
>>>>>> +    if (flags & PCI_IDE_SETUP_ROOT_PORT)
>>>>>> +        __pci_ide_stream_setup(rp, ide);
>>>>
>>>> Oh, when we do this, the root port gets the same devid_start/end as the
>>>> device which is not correct, what should be there, the rootport bdfn? Need
>>>
>>> "Indicates the lowest/highest value RID in the range
>>> associated with this Stream ID at the IDE *Partner* Port"
>>>
>>> My understanding is that device should fill the RP bdfn, and the RP
>>> should fill the device bdfn for RID association registers. Same for Addr
>>> association registers.
>>
>> Oh. Yeah, this sounds right. So most of the setup needs to be done on the
>> root port and not on the device (which only needs to enable the stream),
>> which is not what the patch does. Or I got it wrong? Thanks,
> 
> I don't get you. This patch does IDE setup for 2 partners:
> 
> __pci_ide_stream_setup(pdev, ide);  This is the setup on RP
> __pci_ide_stream_setup(rp, ide);    This is the setup on device

Nah, it is the oppositve.

> 
> unless AMD setup IDE by firmware, and didn't set the PCI_IDE_SETUP_ROOT_PORT flag.

The AMD firmware does not access the config space at all, relies on the 
host os instead. Thanks,


> 
> Thanks,
> Yilun
> 
>>
>>>
>>> Thanks,
>>> Yilun
>>>
>>>> to dig that but PCI_IDE_SETUP_ROOT_PORT should detect that it is a root
>>>> port. Thanks,
>>>>
>>
>> -- 
>> Alexey
>>

-- 
Alexey


