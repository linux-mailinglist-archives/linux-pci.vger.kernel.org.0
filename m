Return-Path: <linux-pci+bounces-28691-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA1FAC86C5
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 04:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78B2A7A1BEB
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 02:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D081A23AA;
	Fri, 30 May 2025 02:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="u4XskfQy"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2070.outbound.protection.outlook.com [40.107.212.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1671E19F471
	for <linux-pci@vger.kernel.org>; Fri, 30 May 2025 02:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748573696; cv=fail; b=hhM3F7iu7tEElw/9GFORXJ8ALIYPJY/eg3n5lM31jLuz3YDSCgRH4YmhmEaK2W6VB5reWCcNWXsleQKCu3QQRrCAracCc7aI91Gf22oAokLtbGdjGKtHd5WsDVjh740OS9M+qUe11plA6Z4Ty5uLB58FPdvz1OsHpm2iOQ6CIWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748573696; c=relaxed/simple;
	bh=1GpR0vNO7abLvEIKxQKowKYXIfNq9Whey4ZDSRjX/Qs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=crCM/SZHZMsaa4TmZKQOzP1sOfAuwUBk6beLYfLVJfs4gIQhBWQemexc2tLuAUhguFLmjuk3+72IBXyg5n5FmM40iZJuDJi/rI1JSpEd43DXqAb1kg2yGciyCfr1EMMPhXu8aiPkUdageZibQ9vMO7ZYzxo3kRwUJq/gvDGyEII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=u4XskfQy; arc=fail smtp.client-ip=40.107.212.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FxqGiT6ZNHGj5o0+Y0DmWc6volMJ6f60CGFCOpJ6OA5lgfOOwfJ/8ecbZg9g5PhljYyQi+JVDoZ5cOvNq8FvcU54oEJAUX09AW3LlYDR3xjDV3oB60hchcw+bFGHfbBN24YxFhut+UKuqQkfHkRk78pq27yOqpD5sm0AgMjrS+pa2ipuSBBwIIEDZ9tHF4R5l1a6nvYmFvDJ6cZDmsn6KPlbJRWJJef5b2FDb1jDT1yWD+z2l8oQ/Tt0f65vE3iofyYTZVDyZVtbvUEselsYgfSo8tRmDYiBjaz2z7efRCokOKpreCHYaxloKMCxNPC0shuM2/JDGzdCO7/zefBRtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9ivrxTT5pqEu/3WUX1K4u1kWxbS013yRkAILqKUHSQ=;
 b=qR2Wipaum0ONBDXj/4YFgtXBln3UdXupjpI0eT5ax8qDxCnyBJQ/RN4Yc80DTVlTWa+rthis38IbQvpqIyQR+dvi6qwEXPWcPZCpJh502zljfJJxtuuufB6GIyp1Mc51Ed4iNDpBbrDPTxoS4NO6LhjhMT80UVthyALc62jsEBqqmJK1xXXkQbkRxNjllKu8IkIH+9Kdh5Bmtr0kVzqpCgqhveyOV1mydPK+WlX+bqt83H+A3kqce7UcgPutZX9skF+qRoMHPSQi94oqVfI4G5KK6EB4cxKkS4X2I0tCcMu14U690uKf6Cw4lYN16d7kHWex+WM7dfF+8DDbA66AHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9ivrxTT5pqEu/3WUX1K4u1kWxbS013yRkAILqKUHSQ=;
 b=u4XskfQyXbM4bpR1VKePdWddMzfGVrZZ2BgiqPc2YOPtqCFxd0WwxZ7TBnhGCgqCSrhNaAwcgnpOkRWkpJ5xPbGToAY8fpom5UqlAsb9jZVylbyHehb84WliUB7jfAAPL6Hl1bye9+UEHjlftEctQ5PO7x708MC+txe6pI1IGJ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by PH7PR12MB6609.namprd12.prod.outlook.com (2603:10b6:510:213::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Fri, 30 May
 2025 02:54:51 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.8769.022; Fri, 30 May 2025
 02:54:51 +0000
Message-ID: <4b3621d7-4bed-44c7-8139-57de5825e968@amd.com>
Date: Fri, 30 May 2025 12:54:44 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v3 12/13] PCI/TSM: support TDI related operations for host
 TSM driver
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org, gregkh@linuxfoundation.org, lukas@wunner.de,
 aneesh.kumar@kernel.org, suzuki.poulose@arm.com, sameo@rivosinc.com,
 jgg@nvidia.com, zhiw@nvidia.com
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-13-dan.j.williams@intel.com>
 <153d5223-169d-4379-bc2c-6ad279489560@amd.com>
 <682ce21c17363_1626e1004e@dwillia2-xfh.jf.intel.com.notmuch>
 <aC2c1SggkqKSO1st@yilunxu-OptiPlex-7050>
 <2fb2de7a-efc2-4ab0-8303-833dd2471d9f@amd.com>
 <aDhtLn2ySm/pgeab@yilunxu-OptiPlex-7050>
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <aDhtLn2ySm/pgeab@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5P282CA0170.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:24a::25) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|PH7PR12MB6609:EE_
X-MS-Office365-Filtering-Correlation-Id: 76e7ee41-9199-4501-33da-08dd9f2558fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YmFjcUZ1YjljczA0UXNDbnRqLytTZ2dpakJCa3NlMENrb2ZFM3JrNEd1czR1?=
 =?utf-8?B?dzJSYjhtVWZQWEFlMGVUcEM4c01vTjJwaXBITTkwcXdUQ01PQUJRRmprVDht?=
 =?utf-8?B?aWY3N2tDVEU5Zm14NVQ0dWxJekxQbHFHaWlGZU5WUW52bVNZQmhZVTNwOE82?=
 =?utf-8?B?c1RvYWlteDlnVitGeDR2SXVHbFRMZWVoaHF4QWxHcDBoY0V2dVhKNEZ0Z0Zh?=
 =?utf-8?B?YmlwdVY4ajJiTW85VWNRSUZsd01NVVI4V3Z6U1JnOVlMZXp2UTY0OVFXdWJu?=
 =?utf-8?B?ZWdaMm51Z2tCREZtcjVZTm5CSDhucXJoNVBKUXFJbm9zclpqYTFvYldXZFlR?=
 =?utf-8?B?ZkVpL0dsRTRMVmpETEsvb3dzaG9ESENxQkZPbm52RDZuUUwvS2FkM09UaUdY?=
 =?utf-8?B?S2NsVEdhQkpuRzJ6aklrQTdMNVR5NVpGWExkSjMrMkpJbmN6ak52NlpNREFV?=
 =?utf-8?B?ZzZVMkZDajJQbmNyOC9mbk5FTmZQYmRPT2tTekdWNitMYmpiLzFrY2hCSy9B?=
 =?utf-8?B?RHJ1UmlqMDVhOW9pWnFLTGY2MVVyWjlaTFdVenowd0pUNmVOcC9OVGVXTG9C?=
 =?utf-8?B?R2NUb0VCUDFRVzNyQ0dMUG1ySWdDT0IrbTg0UWc0VHg1ZTBLUFVsRndCNElt?=
 =?utf-8?B?dS82VTc4bkt1Smt3U3pmQjZiMmNyS0I5QW5uMFREWENyN2JGbVRQYjdnOVRh?=
 =?utf-8?B?RHdXazBVUnRmS0IwZmVBcmkxM3Z5NmE5UEpyL21ETmlwWk5KbzNTcFN3VExv?=
 =?utf-8?B?dVZYbGtweHA2eVBUVWNXcndKOW1OdHZQcjlzN0FHazRaVjY0NmQvK2YrY2tv?=
 =?utf-8?B?dGtBeGlNSTRSeGkrbXlqYmlra2dNcWVraHR0OGZxczJtekhERVlBZStkRC9a?=
 =?utf-8?B?YVFPdzVuMnpMREtaMENUaDVSY3hid3QyNkxXU3Vqd0RzaXgxM3dpTi9BQ0o3?=
 =?utf-8?B?V3VGY0FXQnZFWHljTjJ6MFdWWXY0WnQ0ckhkSWYxSGxLdEpxdGNiT0dOTWxn?=
 =?utf-8?B?dSt6cGVidEJZQ09GTDNlcTBOUVFFVFVCUGJueU9qa2xEOU9ObmtsL2NQblQ2?=
 =?utf-8?B?R0RqeDhuOVplbm84RTVJTFdNenoza2ZESituempWNkhHQ2I3SXlUam56L1Fy?=
 =?utf-8?B?eG44NTlxTUlXQWQxWTcwd2VnSHQxZWNDUitrUjBEczBuVWtNK0IrTUp2c2Z5?=
 =?utf-8?B?WDFoZzVVYjFWdGJRc2tPL0lTQjBnR3JXV2daR1FlbkdJVVBpZzRTdzY2VHFu?=
 =?utf-8?B?R29yZncyZmRjN3hhc1lDc2IrSjRGMmU4SjQwL3RQV2ZFZ25PZEtubHNPbEFU?=
 =?utf-8?B?Y1U5QjNIaUtZUWc0QmlmTVgyeW1rQlVYZ1Q2d2hRd2ZkMGxQd09Vdnduczkz?=
 =?utf-8?B?d1RMUVpCcVg3U0R0UmZJdFVQZjFQeDh4empnWmNkOTZZY1JNMmxranJVTWlP?=
 =?utf-8?B?WXUvYUEzTkpvdTNNMmpiOWo0S3B6VjgzK2xySFJnZFdtY0tTa1dLeGhlV3lC?=
 =?utf-8?B?K01wQlRwRWpwWGdSM1djcUx1dG5TQURKOWVVQ1RSRkJQeUJuOWk2RjNhYkpO?=
 =?utf-8?B?eW9JSHhSamdFeXZBb1JZZ1JLZUVublJTaXRkV1V6ejdkcXBQSjlwL3ljOVRu?=
 =?utf-8?B?eVR0MkZvYTdYMHBaTTNmTGtYTWNPeFluc2tCNzk0NVZRdWE2eWJvNFJmc0lQ?=
 =?utf-8?B?NHpldlVoMGZrRVVkb25ZQkdDS2RqVmg3U1dINFBwSHlHQkF2TE5TQjlTQWEy?=
 =?utf-8?B?c1lsYjlaVFlqeVZBbWFkTUkrMzRYYUJvYkQram00T3R3alh3Y2xKREdsTFZh?=
 =?utf-8?B?cTF0MU83TXVsUDVqQXByejZDREU0bSt0M2lTZ0ZiVW1jR2FzNkhXTUlLTUNR?=
 =?utf-8?B?czlLVFZiV2tmNUcvNERGRnZXV2MyTGhkcWxHQWs0dHZHN2xVK0h4MGhQd1pT?=
 =?utf-8?Q?U2ntsavRqDI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUJOSmY3WHpSTk8vSmluZjljTlQrcTUvRDdpUVN0eDlIUjlqbkZSZElwQ1Yv?=
 =?utf-8?B?MzFMSXZSMTVJUHlFRnVkTmFPWE1YcmdqZm9udEluRHZ1M3dtNlIrcmw4bzZj?=
 =?utf-8?B?aGNMU3UyZWZ2ZCtGaXhHSUFLUEQwN1d1N0dXMlFYUngzSHJFVTg2dG9DaTJx?=
 =?utf-8?B?YklpRjk3aDZTdVpCQnVKUGx0d2QzNVp0WElMcnE5M2NMOFJFQzV5ZDN5c1JL?=
 =?utf-8?B?Vmd1S29MODM5MUJQR3J2bVd1MmNNNkN4MmVIb2l0OTMvSmw3WXVHY0NSNWdQ?=
 =?utf-8?B?R0oxZzl1MmpWb0FienNZaUdLV1VFTnBGTVQ5YzhpMFdmeEF6V01rdW5WVWcv?=
 =?utf-8?B?Zm5TL1kxNUFmYThCSXh6OXZNUGphUmY2V0hXQ1BMQTNNd1F6NjBzL0d0SWZt?=
 =?utf-8?B?MmV5bHJQZjIzVXJTREJjOGgxZWk5anUzS3ZMemRIT2Y4NkdFYkU4WmVkUXpr?=
 =?utf-8?B?RXBRY1pzbzdDODBCa1k3dXk3NXZmdDdKNUdJS3JaYm52R2RzVUVtWWpWZEtO?=
 =?utf-8?B?R2lFRkQzWGtPQ3p3WWMzenNhMXV5dDZZLzV0Mjd5aUlycEozVUl1dWdCZVVm?=
 =?utf-8?B?MlM4WGhDd2FSbG05aXVMMUlmQnRsSHVWZDRCQVRSRS9Jei9LR2t3Ylg3NnlV?=
 =?utf-8?B?aHdrcU5qNVBkQTRoOGQ0ZnJHSytFNG1NaFQ2N3ZBSStZVDZ0dzRVdXVzZDdZ?=
 =?utf-8?B?MjE1WVZoZngyeWVaeDZWVjU2VnV5TzkyNnN3OEJEMm1PdkpISURxUnVjUGdC?=
 =?utf-8?B?WTNZWkhYcElGNDdFWTVMclVwVDN1R0FBcDc5aW5qc0F6YWMxSi9Eb01mclo5?=
 =?utf-8?B?VElnOVAwcGxDallvdkh1TEZLY0tUWUkyM2kvZDZZVlU0RDJSRENTV2gwQ2Zy?=
 =?utf-8?B?ZEFtK1BHakZpVklwLzFHb29jZFFVMWNlc2VVeUZ5eVpiQ0JNaTRZdXVxVllr?=
 =?utf-8?B?bjZJOE1RNHdXVXQrUmdlQ1M1eXMyUXdUYlZvZjFUamhERmlCRDdPaS8zdmE5?=
 =?utf-8?B?dXlXdjdYaTZEVFJMYTgwaTNBODlGM05SMjJzWDdmazcrWGV0WEVuczVCcmR0?=
 =?utf-8?B?RnkrcGlLVkFVSjNiMlg5NGF1SlF3R2ZqQXlzYWk2S0pOOEJuemREWDJBS3Zv?=
 =?utf-8?B?L1hTQklxMWdGQkIvcmwwVHMyVk94UGp3d0gyTWFFNnV6RVdIeENVUkxxWUM4?=
 =?utf-8?B?ZGQ5K2ZkMk0vQUF0Wkt2UG1oREJlbTVaYVFFbG1XdlJOUkJpK1Mza2NqM0gx?=
 =?utf-8?B?YVhlWnhDQ2w0UXFUeklxTmFLWVBTeitNbkduNDdWWFpOYzBSeWRaTWdNei8v?=
 =?utf-8?B?VTdIVmdycUgyQVJuRmk5aDlsdmlSc0NwNXFESkFhbzE5L2YzM0VxQ3FjcEE5?=
 =?utf-8?B?bjhXdGRVYmVaNnRKUlZOekxITUtLajRSdHcxLzR1cFBSWnYrakdYWkY3V1ZI?=
 =?utf-8?B?c1Jma1lrWHp4RkljZENVbWtqSXMzS1kxUFlFWmpPSCs5S25kNnZDSis2U2tN?=
 =?utf-8?B?bGliQ0Q5enc4V3pQMXNmaktvcnNTQmFRbmRRb0tJMFpyZDIvTVo3S3VKMVJr?=
 =?utf-8?B?OG1FRTdmeE5JQVRGQnk5MTduWWpNQ1FmcEFUV1BON2xWamFVaG1lZzVOaW1P?=
 =?utf-8?B?UTk1Y1UzRjlUc29NeEJVdEJpbnVKUzdLaUdrYjdLV0VEY1J2MXFHcWdtZGlR?=
 =?utf-8?B?K1N6QW5DQ0hVYitzcm1VTUY5bUxCbk9MYnJLU0g1RUgwTHN6QU1UWWN4S21D?=
 =?utf-8?B?TFBQNXNmbzBoVVhmL21SRHl2b2RERXlWM3RjZ1Vqc0VsRjR5T1dENkluWXdn?=
 =?utf-8?B?aUt6MDVBdmZnTzNsUVVtMWZLSm1wSFRYVy9RVi9uSkF4VDRNL1Bqay9sNG1X?=
 =?utf-8?B?aU53M3hGTGFwNXBvdkxjM0Z6VzdJZUFMRnplMmtJUVhoQ04rYkRybUxqNmQy?=
 =?utf-8?B?ZlBnRkRTQWYyMW4yTE56ekRVN3MvaU5vY0o2dmNiSHkyWVBjUGpsQTVvTE5J?=
 =?utf-8?B?Vm5ScFcrT3VTV2d3KzNNblZuTmp5Y1FrZWdVUFhVeFlkYnFnU0tBWSsxaWV2?=
 =?utf-8?B?UFEwSzliUGhjZWVwaEJ2K2IwZ1JnRVRPOEpsMElPR3liR2FaQklNcm9Vc0xE?=
 =?utf-8?Q?kbjU480D4rORd4mAUpJ68YM9N?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76e7ee41-9199-4501-33da-08dd9f2558fc
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 02:54:51.5923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iS6y0wzTo71aqEiIfKAsDqVQVEs759pYtZPdYC8iMzlGQDt3xs70F9qpkuk8cZA9WFrk5fYEA0qFbmhW0UgU5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6609



On 30/5/25 00:20, Xu Yilun wrote:
>>>>
>>>>>> + * struct pci_tsm_guest_req_info - parameter for pci_tsm_ops.guest_req()
>>>>>> + * @type: identify the format of the following blobs
>>>>>> + * @type_info: extra input/output info, e.g. firmware error code
>>>>>
>>>>> Call it "fw_ret"?
>>>>
>>>> Sure.
>>>
>>> This field is intended for out-of-blob values, like fw_ret. But fw_ret
>>> is specified in GHCB and is vendor specific. Other vendors may also
>>> have different values of this kind.
>>>
>>> So I intend to gather these out-of-blob values in type_info, like:
>>>
>>> enum pci_tsm_guest_req_type {
>>>     PCI_TSM_GUEST_REQ_TDXC,
>>>     PCI_TSM_GUEST_REQ_SEV_SNP,
>>> };
>>
>>
>> The pci_tsm_ops hooks already know what they are - SEV or TDX.
> 
> I think this is for type safe check to some extend. The tsm driver hook
> assumes the blobs are for its known format, but userspace may pass in
> another format ...

The blobs are guest_request blobs, they enter the kernel via iommufd's viommu ioctl and viommu already has  iommu_viommu_type which is (in my tree):

enum iommu_viommu_type {
         IOMMU_VIOMMU_TYPE_DEFAULT = 0,
         IOMMU_VIOMMU_TYPE_ARM_SMMUV3 = 1,
        IOMMU_VIOMMU_TYPE_AMD_TSM = 2,
        IOMMU_VIOMMU_TYPE_AMD = 3,
  };


>>
>>
>>> /* SEV SNP guest request type info */
>>> struct pci_tsm_guest_req_sev_snp {
>>> 	s32 fw_err;
>>> };
>>>
>>> Since IOMMUFD has the userspace entry, maybe these definitions should be
>>> moved to include/uapi/linux/iommufd.h.
>>>
>>> In pci-tsm.h, just define:
>>>
>>> struct pci_tsm_guest_req_info {
>>> 	u32 type;
>>> 	void __user *type_info;
>>> 	size_t type_info_len;
>>> 	void __user *req;
>>> 	size_t req_len;
>>> 	void __user *resp;
>>> 	size_t resp_len;
>>> };
>>>
>>> BTW: TDX Connect has no out-of-blob value, so should set type_info_len = 0
>>
>>
>> No TDX Connect fw error handling on the host OS whatsoever, always return to the guest?
> 
> Always return to guest. The fw error info (not raw fw error code) is
> embedded in response blob.
> 
> For QEMU/IOMMUFD, Guest Request doesn't care blob data, so don't have
> to judge fw_error either. Alway return to the guest and let the guest
> decide what to do.

So whatever is inside such requests, the host is not told about it ever? How does DOE bouncing work on Intel then if the fw cannot ask the host to do DOE? Thanks,

>> oookay, do not use it but the fw response is still a generic thing. Whatever is specific to AMD can be packed into req/resp and QEMU/guest will handle those.
> 
> But for out-of-blob data, it is the same effort as packing into type_info.
> At least we could have a clear idea, which blob is SW defined, which blob
> is GHCI/GHCB defined.
> 
> Thanks,
> Yilun

-- 
Alexey


