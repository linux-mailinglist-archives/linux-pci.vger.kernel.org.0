Return-Path: <linux-pci+bounces-6504-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E80F8AC2C3
	for <lists+linux-pci@lfdr.de>; Mon, 22 Apr 2024 04:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF4231F214C7
	for <lists+linux-pci@lfdr.de>; Mon, 22 Apr 2024 02:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B11D4C6F;
	Mon, 22 Apr 2024 02:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Inoi+wgT"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80DE4C65
	for <linux-pci@vger.kernel.org>; Mon, 22 Apr 2024 02:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713752487; cv=fail; b=Oy4NLRAKjtZY89hKwlfuOWw/aFPcy0eYmT11HBFNyrW6pPy/8TIRUB/eK8vMmTrhJ4CrRzzDo+IEWzFM44f01j7crojE1s7+akN6+S4e5TvaY85YjWXAZ5wHPv8y/iVJPLlAZBuBfF+ROOUGaAl1kld2YUXBByA/wCz535ekv5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713752487; c=relaxed/simple;
	bh=/QUK+Jsg0xt2EWnDZAGpDf/dYWF8/mp2JvtQwNHv/nE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QYmy2qrgkTYPZ3qa+jeZY+6Dk7iNt8AMsvpLVZzDKfrhTDY0VzE7rabsXcP8TDv/0BePuwiF03SgRQZn0QM4orLKfBk0FL7byb/8d2uwYTTX0yWfGU0wiPUtyRhIatmkQUdOgY2zn2aL5fWQuHIsC2KvaNGdm+iNwSZnRD7srdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Inoi+wgT; arc=fail smtp.client-ip=40.107.236.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EeVlOuXxcJH2z7NMHdazU08tfSMUkO1BA2oXyyogMzBj2vb3XG+1T7UgGBAbi5I+zRzA/yM7k3MbA9PbpAndANYVyEMwG4kUgmeg5MQ+Ms1hA+wmIPaCgnm+iirYNHvrd1Vq8t/7+rurPsZ1jjnZrYSDMRq4TIWMghQ/koDzYcTXrmk2jC9u0HoXe4MmfiKAU/RJyEsHlubF8vFj8Kmvt3b7lmcUVW32jrxq3A7cg7qOSF36mIp9pjWymhJcEoMS9Elv2YSJujgA5cfAtoN5UYZn1D8keVGKz4m0qRjRUe5CEfSDUBgZ2IeVMAR1dQWOxn9r8TzRlyKTTp/O9SIrTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fgQMBfggmupVqJfmAyj+jNPJfWCcYnLrIJYdun9wZ78=;
 b=O1Uo3UVc1X14z0EsHa4NxEEuA9AFaK4zWO7F3mnyejHw+0bsvJmR5pgzrXPqkxeyLvsogURa2fFvz933j/WT7ZXwfpkCaWRZgiIPPL51dqSX+RcmHjSyf8rN3gA0dSlvY6V3S9G4hfIdWgGofX3EiFBSAsfUZa6iZXi198B/xAfc/1k1T955sp0JTU+oY79vAcM1ItINKazMLgDGEy1v5PdObs6DO1EGXDG6s6hUHoOs0GdCmsJHe83p+7sOOEA/Hwq4elt9wrvMgUOm0ScdHoK+V7Ga/x3ARXkrgUwYf4nhfppy32LXft4yPHeuxfIH4QSOxDfKgYlp6RU3N8b6tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fgQMBfggmupVqJfmAyj+jNPJfWCcYnLrIJYdun9wZ78=;
 b=Inoi+wgTRp3lrKpnG9Wsv4f00bb+LJ6ZoIQs2swElpbUsN1Uuefrp3/yt94SPLvkV90IWBz0M7AZF0XmwXsg8Y4y5EY3Iy/5aL70m3aNHdSl8g7X5YBhlZEPI2DilPGu4pWnMkD+RV1Mox9r+QEFGbcRsdxy/CEm8x/eA/o2JEA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by CH3PR12MB8356.namprd12.prod.outlook.com (2603:10b6:610:130::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 02:21:17 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%4]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 02:21:17 +0000
Message-ID: <fc201452-080e-4942-b5a0-0c64d023ac6b@amd.com>
Date: Mon, 22 Apr 2024 12:21:08 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC PATCH v2 5/6] PCI/TSM: Authenticate devices via platform TSM
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev
Cc: Wu Hao <hao.wu@intel.com>, Yilun Xu <yilun.xu@intel.com>,
 Lukas Wunner <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Xu Yilun <yilun.xu@linux.intel.com>,
 kevin.tian@intel.com, gregkh@linuxfoundation.org, linux-pci@vger.kernel.org
References: <171291190324.3532867.13480405752065082171.stgit@dwillia2-xfh.jf.intel.com>
 <171291193308.3532867.129739584130889725.stgit@dwillia2-xfh.jf.intel.com>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <171291193308.3532867.129739584130889725.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5P300CA0093.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:248::25) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|CH3PR12MB8356:EE_
X-MS-Office365-Filtering-Correlation-Id: 30f2bf6b-5ff6-423d-f1c0-08dc6272e3d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WnFIY21ITW8wdi9pN3BJMlc5Q3Z2WVpBelMzSXNLem9QNk53b0NaRktnVU5V?=
 =?utf-8?B?SzZvVEtqQXVEYWRrQXVxcDlhKy9FYTdvUlVIRmV3ai9tQmRXZjF6MmFDcnhI?=
 =?utf-8?B?SEFheHZ0VzlzUElNYUxCL093QTd2bWFEb2RsZ3hrTWMxT0pUdVh0OUZ5Mzdr?=
 =?utf-8?B?Kzg1WW9MRDNZRGlJZkJDK0ZPa3ZFRmsxZnFTSjRZdloxK1MxOURqNVNUWjIy?=
 =?utf-8?B?cHNtU3h2L2pnUithaGVWQk9KVHdaWGE4Tk9XcCtGa0JNbzdsN0FWL1M1MFFm?=
 =?utf-8?B?MXZleWN5ZE5yZ0JPbUhhK2t3SjNNMFVUL1FqcmFrK0traStWc01BdzFXMzZN?=
 =?utf-8?B?b3pZTENKeldzVnZPNEl0MXE1bVRFWjVxVGVpTXkxb1ZiWDlDVXhtWDZRWmp1?=
 =?utf-8?B?dkF5cXVWbXdPWlNKSFg2U2tuUHZQZ2pPdU1xZENiTk1ZZllRQjQ2ZTZaMCtF?=
 =?utf-8?B?NU1RSFdndmREN0NKSjhOREdtYk5vSXp6TDRMTjV2OVc3T1VCRElER05iMmVV?=
 =?utf-8?B?bFR2TTkyL3NwbVRsWlN1bjlOKzJHamNhZDY1WkJSMDVsL3RSOVplMU5sSmdV?=
 =?utf-8?B?U0ZzcWpscWNGcWI3VmJNQjVnRG9KeFRid1NCZ0g1TzJ0RVpEbm5wVlFGcWRi?=
 =?utf-8?B?QUdWZDlJVUtES25YVGYrb0dIUWlVdll1TklVN3VrMmNXaWlmajJVM0YwUVdE?=
 =?utf-8?B?a3ZuSDlHZjJkRE1DUHpIeFoyTU1IWnRkdmdvc284YjVibjFteGpVMnBBWlJa?=
 =?utf-8?B?dW5nbEVVNEx3MU1LODZ2WDgzdXlWd2puOHRKK1FtblJUZU5nVEtPcjFrSHJj?=
 =?utf-8?B?WlI5V2wvR25sNy9ld0Jra3lDRlNZa1ZMOTVCSy9tNUtaeEtvaVFDeFdpb1NR?=
 =?utf-8?B?RFhGeHVrdHFnR1JMQktBRDFIS1VTa0FQNnRHMUhmTXVqRGg3YXUyMjBaY1ZW?=
 =?utf-8?B?d09EZGVCbnlHTVdiTlF1alI2ZmZoUjIwQ2RMWFl4enpCTHBVZGFBQ0ttZ0xm?=
 =?utf-8?B?YUlzZ2cvd1VyUTdJb2FKbG1mMUZLeUpYTmRKSEo4ZjVIM3d2dFNOb1cxcEo3?=
 =?utf-8?B?SE5HYWF3VzlmN09tUVZHVGRHbGgyRDFsbUFLL0o3MW40ZjFDVFNvTU5XRlBv?=
 =?utf-8?B?Z0QvMDlmcngrakl5endnZWJVWFpUZjVVcHB0MHRlbUZHYzZXYlgxYitHTU5z?=
 =?utf-8?B?eitmbVRsZ1N4Ky9OSzVoSUhQZnFvM3k5WmFyRUlLeVFMKytsb1N4cVlYY0xS?=
 =?utf-8?B?NWpIcldsME8xOUhqNUdYaGZiVy9ua0ZtUllNNStHUnJYTE9Jc2dTQkZEZnFU?=
 =?utf-8?B?Ni9xdGEyNG4zWGJBYTFLYXl6NkhXcTlWcmUzMHZ1UEFPekpnM3R6WGVRNEVr?=
 =?utf-8?B?cFFXc3hpcXB0Q0lsVE9ieGdtN0hQaUVUZVRBZmR5UFZMdWVrTHRNT3NXLzk1?=
 =?utf-8?B?RmNOc2xnODhYcVRhMWtkR2xqbGpDeUx3ZVlQVEo2N0UxWm1EZ0hjdEo4NWRa?=
 =?utf-8?B?VXNWMVk3Q0oyVWNaUS85MW9TUjRPZEhBOGVqbVBOMkhLRWQ5SE1UTDR1NWJj?=
 =?utf-8?B?azNCcXp2aWNBZXRTdVhaY3ZIMTNzV21LUU5uQzJxV0M0TkVXdWVrVVVsUHRa?=
 =?utf-8?B?YjRKWGNFZEMxYjlOUG5CUkVvU3FSSFJqYW12S2wzaG5kNFRmQllFNTJab0Jn?=
 =?utf-8?B?bmI0R1F4T1NpSStMdVYrdDNCWW5VaGF0NXNNZFAvRDRRaVEzVno0SkFRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VWZhK2JVUEh3Qk9KTTRmQnVaMUNzcng1dEpjR2syY2ZBSEY1cDkxUEdkUjJH?=
 =?utf-8?B?c2pOY2pPUkVRUHhWS0hWTko5Mzh2L01rWGhzWm9UWFBJYmR6UVlFWENhK25j?=
 =?utf-8?B?enpkU0tKL1F4b2lrS3hVZlZKTjM5U09iMzhIeEJPNWMwQUJnUGcwNU11aVdp?=
 =?utf-8?B?V0RHUS92OXNnK2c1enl0UmtSZ2ZIbHplaXZhWkxpS2N0V2JJSFQzYk1hWm1Y?=
 =?utf-8?B?NFpZVUpzRVEzK2E0N2ZJQXo4aDg1N29wZE12K2EwdlBrWmk5aU1RcklwdXBa?=
 =?utf-8?B?dUdtcVpUU0lnNXpkUGt0MnZ5cHRGek5JakVmU3dpMUszc0UyeHphTlRtZWJs?=
 =?utf-8?B?MXNuSjZubGkzK3kxRGtUUHRuSHZVcG9nQmxSNFB1Y012WVFNMzdRaUw1SWNZ?=
 =?utf-8?B?UVVLamNDeUQ2OGdCVG1BZjBzbmJUTWpLT1JuZ1FRNmFKcWFQLzdORkZRanoz?=
 =?utf-8?B?VTR4Q2MzYlBBZmlrbmhOQ3RjL3hlRTIzVmtlRDBPY0IwTTc0Y3NOU0o3elRn?=
 =?utf-8?B?NHI3LzZtbkE0V2VuM05ma3hPQmFWMzlHYU8zaW9FTFJqSzM5TVlTMU52VWsy?=
 =?utf-8?B?YXdXWHQyMDBDMks5ZmZFZWk5MldwYjh1ejhmNDErQitIb3B6a3pwNmZGK08x?=
 =?utf-8?B?VEw2NEVFZHd6bU5IdWlFYWRlYzBSUlFRRUFuSm5VaGpsQ2xDL1R6bkxDTmww?=
 =?utf-8?B?RHo4UThrTEJlVDdLM05KeEJPaWprK2tKeVY3NzVBQmVPdVVWckl0LzVsNHdp?=
 =?utf-8?B?NkRWUGkyZmloREZweDlYRmZzTUlUTitNQUxaYmpCNVFBV00ycm9laWRxbVI3?=
 =?utf-8?B?WVdpN2xwNHkrZ3pWUk80WWVmUnNadUN0WlhiU3RVU3ZVME5jMUJ3ZVJ6ODVu?=
 =?utf-8?B?UEJROE0wbFF4b05Renp1NjkzbGdqUTBxWkZWSytZakIxUVhxbG5YUzY4VXRz?=
 =?utf-8?B?L0k3elI4eENtK29QSEJSaitZR09JRXdjRDhOQ256QnVvdkVTY0NWYVpFR01F?=
 =?utf-8?B?d2NrM0tiTkZTVzIvK0hhUVdYV3dCSTRyYUVNa1E4K2ViekcyY3VwRGFOS3p2?=
 =?utf-8?B?WlBSYzArRGhRYzIrVy9xNGR3U3JOR205enJHc0dwRjdxc2ErQ3hYbzkzdUtI?=
 =?utf-8?B?YUFNVnhwY2FySFl2c2YxTFVhZDN2ZEJzblkxQ1I1bTk1UGtTY2lpQTZPaEQ2?=
 =?utf-8?B?ZHd0QU5kS2RBV25LMnBvcE40VjlKWmh0V05GSnYzN2NicWVBa1R6U21zQklC?=
 =?utf-8?B?eGFEd29iazNWdXcreW5iUXlpcmZlUGd6dWQwbGVDME9kZ0FDMnRkb1hlcGdD?=
 =?utf-8?B?MTI4MXh6bmZxd2cvajM5R1VlelVHL0k0R2hrcTNLdnBINStNaEdzWGQ1MEs4?=
 =?utf-8?B?VFNZV1QxY0xsRXNiOVAxVklWd0thcnM3ck5NODlkcXJsaUI1WExtUmhDNTVV?=
 =?utf-8?B?R1lTQ2g3S28vSTVXQkNEeCs0TGF2UTUyWW5RZ3dUbXI3b2UyTDdSdll2VzJJ?=
 =?utf-8?B?aGlvVjRTTUxMUkM4dnBhdHNUTE9GVW5XeFIzQkFvTktqY3lkeFFDK095RVo0?=
 =?utf-8?B?SDhjMnc2SmNqSWwwMkR4aUxKRkZjVXNQejcwN3NtSnRycTRHSWlHMDhWQUNz?=
 =?utf-8?B?azRFN2pvSUdIZUc4MXNGcUg1NVN2UmFhN3F2a3l0V0tDdVozWVpEWGlXYW4v?=
 =?utf-8?B?VkdhWVRCaW44bkVVUW42dGpBM3hoaWh1Ym9OMEc1TERXVlJud3VRaEJ3aktp?=
 =?utf-8?B?V3FmVEEya0Q1K3BnblFUb0g1L1pBeTJWcURZa211RlhGdXlPOWJQZ01qS3RO?=
 =?utf-8?B?cVR1ZWJlR2VjdHRET3dLbGo4aDBydk4rRE1QU2lVdUdzckFqbllSdmEvbkUv?=
 =?utf-8?B?UHpJb1dSWEZoaFZaV3o4UWIxTnlLREFrV0R6VGZpekJCbTFYVHNGR3pGeVVF?=
 =?utf-8?B?ZitBWVVUVFhjUmdKTjRnTURIekV1NE1GTDB1WHgzZWFZaDNBakNGK3dweWFh?=
 =?utf-8?B?TnNDcnRRa0N0dTh5YUwrcUxyY2dYUlJWYWZmeTVTc1VWOEtWUEsrTDNnK1Yr?=
 =?utf-8?B?ako0dUxnYnVYNEFjMjZrME5iRzZBcy9lWUtObldSK1dUa1ZZNlJvZ2owMXhD?=
 =?utf-8?Q?6SUk2rdfDy8M+ZPVFHMdSy3mc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30f2bf6b-5ff6-423d-f1c0-08dc6272e3d6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 02:21:17.1235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W8y6/xvXXerQtSD7GrqDp2nhk0e5oFXSy83YM0RMWLqKizAStATTSXggXPGHU/31eWqEzub0PZiupyGq5Tp5ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8356

On 12/4/24 18:52, Dan Williams wrote:
> The PCIe 6.1 specification, section 11, introduces the Trusted Execution
> Environment (TEE) Device Interface Security Protocol (TDISP).  This
> interface definition builds upon Component Measurement and
> Authentication (CMA), and link Integrity and Data Encryption (IDE). It
> adds support for assigning devices (PCI physical or virtual function) to
> a confidential VM such that the assigned device is enabled to access
> guest private memory protected by technologies like Intel TDX, AMD
> SEV-SNP, RISCV COVE, or ARM CCA.
> 
> The "TSM" (TEE Security Manager) is a concept in the TDISP specification
> of an agent that mediates between a "DSM" (Device Security Manager) and
> system software in both a VMM and a confidential VM. A VMM uses TSM ABIs
> to setup link security and assign devices. A confidential VM uses TSM
> ABIs to transition an assigned device into the TDISP "RUN" state and
> validate its configuration. From a Linux perspective the TSM abstracts
> many of the details of TDISP, IDE, and CMA. Some of those details leak
> through at times, but for the most part TDISP is an internal
> implementation detail of the TSM.
> 
> Similar to the PCI core extensions to support CONFIG_PCI_CMA,
> CONFIG_PCI_TSM builds upon that to reuse the "authenticated" sysfs
> attribute, and add more properties + controls in a tsm/ subdirectory of
> the PCI device sysfs interface. Unlike CMA that can depend on a local to
> the PCI core implementation, PCI_TSM needs to be prepared for late
> loading of the platform TSM driver. Consider that the TSM driver may
> itself be a PCI driver. Userspace can depend on the common TSM device
> uevent to know when the PCI core has TSM services enabled. The PCI
> device tsm/ subdirectory is supplemented by the TSM device pci/
> directory for platform global TSM properties + controls.
> 
> The common verbs that the low-level TSM drivers implement are defined by
> 'enum pci_tsm_cmd'. For now only connect and disconnect are defined for
> establishing a trust relationship between the host and the device,
> securing the interconnect (optionally establishing IDE), and tearing
> that down.
> 
> The locking allows for multiple devices to be executing commands
> simultaneously, one outstanding command per-device and an rwsem flushes
> all inflight commands when a TSM low-level driver/device is removed.
> 
> In addition to commands submitted through an 'exec' operation the
> low-level TSM driver is notified of device arrival and departure events
> via 'add' and 'del' operations. With those it can setup per-device
> context, or filter devices that the TSM is not prepared to support.
> 
> Cc: Wu Hao <hao.wu@intel.com>
> Cc: Yilun Xu <yilun.xu@intel.com>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Samuel Ortiz <sameo@rivosinc.com>
> Cc: Alexey Kardashevskiy <aik@amd.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>   Documentation/ABI/testing/sysfs-bus-pci |   46 +++++
>   MAINTAINERS                             |    2
>   drivers/pci/Kconfig                     |   13 +
>   drivers/pci/Makefile                    |    2
>   drivers/pci/pci-sysfs.c                 |    4
>   drivers/pci/pci.h                       |   10 +
>   drivers/pci/probe.c                     |    1
>   drivers/pci/remove.c                    |    1
>   drivers/pci/tsm.c                       |  270 +++++++++++++++++++++++++++++++
>   drivers/virt/coco/host/tsm-core.c       |   22 ++-
>   include/linux/pci-tsm.h                 |   80 +++++++++
>   include/linux/pci.h                     |   11 +
>   include/linux/tsm.h                     |    4
>   include/uapi/linux/pci_regs.h           |    4
>   14 files changed, 466 insertions(+), 4 deletions(-)
>   create mode 100644 drivers/pci/tsm.c
>   create mode 100644 include/linux/pci-tsm.h
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> index ecf47559f495..4ae50621e65b 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -500,3 +500,49 @@ Description:
>   		console drivers from the device.  Raw users of pci-sysfs
>   		resourceN attributes must be terminated prior to resizing.
>   		Success of the resizing operation is not guaranteed.
> +
> +What:		/sys/bus/pci/devices/.../authenticated
> +Date:		March 2024
> +Contact:	linux-pci@vger.kernel.org
> +Description:
> +		This file contains 1 if the device authenticated successfully.
> +		It contains 0 if the device failed authentication (and may thus
> +		be malicious). There are 2 potential authentication methods:
> +		native PCI CMA (Component Measurement and Authentication) and
> +		PCI TSM (TEE Security Manager). In the PCI TSM case the device's
> +		PCI CMA interface is subsumed by the TSM driver. A TSM
> +		implementation uses its own private certificate store + keys to
> +		authenticate the device. Without a TSM the kernel can
> +		authenticate using its own certificate chain.
> +
> +		In the TSM case, "authenticated" is read-only (0444) and the
> +		"tsm/connect" attribute reflects whether the device is TSM
> +		"connected" which includes not only CMA authentication, but
> +		optionally IDE (link Integrity and Data encryption) if the TSM
> +		deems that is necessary. When the device is disconnected from
> +		the TSM the kernel may attempt authentication with its own
> +		certificate chain. See
> +		Documentation/ABI/testing/sysfs-devices-spdm.
> +
> +		The file is not visible if authentication is unsupported by the
> +		device, or if PCI CMA support is disabled and the TSM
> +		driver has no available authentication methods for the device.
> +
> +What:		/sys/bus/pci/devices/.../tsm/
> +Date:		March 2024
> +Contact:	linux-coco@lists.linux.dev
> +Description:
> +		This directory only appears if a device supports CMA and IDE,
> +		and only after a TSM driver has loaded and evaluated this
> +		PCI device. All present devices shall be dispositioned
> +		after the 'add' event for /sys/class/tsm/tsm0 triggers.
> +
> +What:		/sys/bus/pci/devices/.../tsm/connect
> +Date:		March 2024
> +Contact:	linux-coco@lists.linux.dev
> +Description:
> +		(RW) Writing "1" to this file triggers the TSM to establish a
> +		connection with the device. This typically includes an SPDM
> +		(DMTF Security Protocols and Data Models) session over PCIe DOE
> +		(Data Object Exchange) and may also include PCIe IDE (Integrity
> +		and Data Encryption) establishment.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8d5bcd9d43ac..0e1d995e7a16 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22466,8 +22466,10 @@ M:	Dan Williams <dan.j.williams@intel.com>
>   L:	linux-coco@lists.linux.dev
>   S:	Maintained
>   F:	Documentation/ABI/testing/configfs-tsm
> +F:	drivers/pci/tsm.c
>   F:	drivers/virt/coco/guest/tsm_report.c
>   F:	drivers/virt/coco/host/
> +F:	include/linux/pci-tsm.h
>   F:	include/linux/tsm.h
>   
>   TTY LAYER AND SERIAL DRIVERS
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index d35001589d88..cd863c5e49ca 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -121,6 +121,19 @@ config XEN_PCIDEV_FRONTEND
>   config PCI_ATS
>   	bool
>   
> +config PCI_TSM
> +	bool "TEE Security Manager for PCI Device Security"
> +	help
> +	  The TEE (Trusted Execution Environment) Device Interface
> +	  Security Protocol (TDISP) defines a "TSM" as a platform agent
> +	  that manages device authentication, link encryption, link
> +	  integrity protection, and assignment of PCI device functions
> +	  (virtual or physical) to confidential computing VMs that can
> +	  access (DMA) guest private memory.
> +
> +	  Enable a platform TSM driver to use this capability.
> +
> +
>   config PCI_DOE
>   	bool
>   
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index 175302036890..b9884a669c5f 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -35,6 +35,8 @@ obj-$(CONFIG_VGA_ARB)		+= vgaarb.o
>   obj-$(CONFIG_PCI_DOE)		+= doe.o
>   obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) += of_property.o
>   
> +obj-$(CONFIG_PCI_TSM)		+= tsm.o
> +
>   # Endpoint library must be initialized before its users
>   obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
>   
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 40cfa716392f..c6ea624dd76c 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1661,6 +1661,10 @@ const struct attribute_group *pci_dev_attr_groups[] = {
>   #endif
>   #ifdef CONFIG_PCIEASPM
>   	&aspm_ctrl_attr_group,
> +#endif
> +#ifdef CONFIG_PCI_TSM
> +	&pci_tsm_auth_attr_group,
> +	&pci_tsm_attr_group,
>   #endif
>   	NULL,
>   };
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 17fed1846847..9b864cbf8682 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -335,6 +335,16 @@ static inline void pci_doe_destroy(struct pci_dev *pdev) { }
>   static inline void pci_doe_disconnected(struct pci_dev *pdev) { }
>   #endif
>   
> +#ifdef CONFIG_PCI_TSM
> +void pci_tsm_init(struct pci_dev *pdev);
> +void pci_tsm_destroy(struct pci_dev *pdev);
> +extern const struct attribute_group pci_tsm_attr_group;
> +extern const struct attribute_group pci_tsm_auth_attr_group;
> +#else
> +static inline void pci_tsm_init(struct pci_dev *pdev) { }
> +static inline void pci_tsm_destroy(struct pci_dev *pdev) { }
> +#endif
> +
>   /**
>    * pci_dev_set_io_state - Set the new error state if possible.
>    *
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 1325fbae2f28..d89b67541d02 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2481,6 +2481,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
>   	pci_dpc_init(dev);		/* Downstream Port Containment */
>   	pci_rcec_init(dev);		/* Root Complex Event Collector */
>   	pci_doe_init(dev);		/* Data Object Exchange */
> +	pci_tsm_init(dev);		/* TEE Security Manager connection */
>   
>   	pcie_report_downtraining(dev);
>   	pci_init_reset_methods(dev);
> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> index d749ea8250d6..d94b2458934a 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -39,6 +39,7 @@ static void pci_destroy_dev(struct pci_dev *dev)
>   	list_del(&dev->bus_list);
>   	up_write(&pci_bus_sem);
>   
> +	pci_tsm_destroy(dev);
>   	pci_doe_destroy(dev);
>   	pcie_aspm_exit_link_state(dev);
>   	pci_bridge_d3_update(dev);
> diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
> new file mode 100644
> index 000000000000..9c5fb2c46662
> --- /dev/null
> +++ b/drivers/pci/tsm.c
> @@ -0,0 +1,270 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * TEE Security Manager for the TEE Device Interface Security Protocol
> + * (TDISP, PCIe r6.1 sec 11)
> + *
> + * Copyright(c) 2024 Intel Corporation. All rights reserved.
> + */
> +
> +#define dev_fmt(fmt) "TSM: " fmt
> +
> +#include <linux/pci.h>
> +#include <linux/pci-doe.h>
> +#include <linux/sysfs.h>
> +#include <linux/xarray.h>
> +#include <linux/pci-tsm.h>
> +#include <linux/bitfield.h>
> +#include "pci.h"
> +
> +/* collect TSM capable devices to rendezvous with the tsm driver */
> +static DEFINE_XARRAY(pci_tsm_devs);

imho either this or pci_dev::tsm is enough but not necessarily both.

> +
> +/*
> + * Provide a read/write lock against the init / exit of pdev tsm
> + * capabilities and arrival/departure of a tsm instance
> + */
> +static DECLARE_RWSEM(pci_tsm_rwsem);
> +static const struct pci_tsm_ops *tsm_ops;
> +
> +static int pci_tsm_disconnect(struct pci_dev *pdev)
> +{
> +	struct pci_tsm *pci_tsm = pdev->tsm;
> +
> +	lockdep_assert_held_read(&pci_tsm_rwsem);
> +	scoped_cond_guard(mutex_intr, return -EINTR, &pci_tsm->exec_lock) {
> +		int rc;
> +
> +		if (pci_tsm->state < PCI_TSM_CONNECT)
> +			return 0;
> +		if (pci_tsm->state < PCI_TSM_INIT)
> +			return -ENXIO;
> +
> +		rc = tsm_ops->exec(pdev, TSM_EXEC_DISCONNECT);
> +		if (rc)
> +			return rc;
> +		pci_tsm->state = PCI_TSM_INIT;
> +	}
> +	return 0;
> +}
> +
> +static int pci_tsm_connect(struct pci_dev *pdev)
> +{
> +	struct pci_tsm *pci_tsm = pdev->tsm;
> +
> +	lockdep_assert_held_read(&pci_tsm_rwsem);
> +	scoped_cond_guard(mutex_intr, return -EINTR, &pci_tsm->exec_lock) {
> +		int rc;
> +
> +		if (pci_tsm->state >= PCI_TSM_CONNECT)
> +			return 0;
> +		if (pci_tsm->state < PCI_TSM_INIT)
> +			return -ENXIO;
> +
> +		rc = tsm_ops->exec(pdev, TSM_EXEC_CONNECT);
> +		if (rc)
> +			return rc;
> +		pci_tsm->state = PCI_TSM_CONNECT;
> +	}
> +	return 0;
> +}
> +
> +static ssize_t connect_store(struct device *dev, struct device_attribute *attr,
> +			     const char *buf, size_t len)
> +{
> +	int rc;
> +	bool connect;
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	rc = kstrtobool(buf, &connect);
> +	if (rc)
> +		return rc;
> +
> +	if (connect)
> +		rc = pci_tsm_connect(pdev);
> +	else
> +		rc = pci_tsm_disconnect(pdev);
> +	if (rc)
> +		return rc;
> +	return len;
> +}
> +
> +static ssize_t connect_show(struct device *dev, struct device_attribute *attr,
> +			    char *buf)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	return sysfs_emit(buf, "%d\n", pdev->tsm->state >= PCI_TSM_CONNECT);
> +}
> +static DEVICE_ATTR_RW(connect);
> +
> +static bool pci_tsm_group_visible(struct kobject *kobj)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	if (pdev->tsm && pdev->tsm->state > PCI_TSM_IDLE)
> +		return true;
> +	return false;
> +}
> +DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(pci_tsm);
> +
> +static struct attribute *pci_tsm_attrs[] = {
> +	&dev_attr_connect.attr,
> +	NULL,
> +};
> +
> +const struct attribute_group pci_tsm_attr_group = {
> +	.name = "tsm",
> +	.attrs = pci_tsm_attrs,
> +	.is_visible = SYSFS_GROUP_VISIBLE(pci_tsm),
> +};
> +
> +static ssize_t authenticated_show(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
> +{
> +	/*
> +	 * When device authentication is TSM owned, 'authenticated' is
> +	 * identical to the connect state.
> +	 */
> +	return connect_show(dev, attr, buf);
> +}
> +static DEVICE_ATTR_RO(authenticated);
> +
> +static struct attribute *pci_tsm_auth_attrs[] = {
> +	&dev_attr_authenticated.attr,
> +	NULL,
> +};
> +
> +const struct attribute_group pci_tsm_auth_attr_group = {
> +	.attrs = pci_tsm_auth_attrs,
> +	.is_visible = SYSFS_GROUP_VISIBLE(pci_tsm),
> +};
> +
> +static int pci_tsm_add(struct pci_dev *pdev)
> +{
> +	struct pci_tsm *pci_tsm = pdev->tsm;
> +
> +	lockdep_assert_held(&pci_tsm_rwsem);
> +	if (!tsm_ops)
> +		return 0;
> +	if (pci_tsm->state < PCI_TSM_INIT) {
> +		int rc = tsm_ops->add(pdev);
> +
> +		if (rc)
> +			return rc;
> +	}
> +	pci_tsm->state = PCI_TSM_INIT;
> +	return sysfs_update_group(&pdev->dev.kobj, &pci_tsm_attr_group);
> +}
> +
> +static void pci_tsm_del(struct pci_dev *pdev)
> +{
> +	struct pci_tsm *pci_tsm = pdev->tsm;
> +
> +	lockdep_assert_held(&pci_tsm_rwsem);
> +	/* shutdown sysfs operations before tsm delete */
> +	scoped_guard(mutex, &pdev->tsm->exec_lock)
> +		pci_tsm->state = PCI_TSM_IDLE;
> +	sysfs_update_group(&pdev->dev.kobj, &pci_tsm_attr_group);
> +	tsm_ops->del(pdev);
> +}
> +
> +int pci_tsm_register(const struct pci_tsm_ops *ops)
> +{
> +	struct pci_dev *pdev;
> +	unsigned long index;
> +
> +	if (!ops)
> +		return 0;
> +	guard(rwsem_write)(&pci_tsm_rwsem);
> +	if (tsm_ops)
> +		return -EBUSY;
> +	tsm_ops = ops;
> +	xa_for_each(&pci_tsm_devs, index, pdev)
> +		pci_tsm_add(pdev);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_tsm_register);
> +
> +void pci_tsm_unregister(const struct pci_tsm_ops *ops)
> +{
> +	struct pci_dev *pdev;
> +	unsigned long index;
> +
> +	if (!ops)
> +		return;
> +	guard(rwsem_write)(&pci_tsm_rwsem);
> +	if (ops != tsm_ops)
> +		return;
> +	xa_for_each(&pci_tsm_devs, index, pdev)
> +		pci_tsm_del(pdev);
> +	tsm_ops = NULL;
> +}
> +EXPORT_SYMBOL_GPL(pci_tsm_unregister);
> +
> +int pci_tsm_doe_transfer(struct pci_dev *pdev, enum pci_doe_proto type,
> +			 const void *req, size_t req_sz, void *resp,
> +			 size_t resp_sz)
> +{
> +	if (!pdev->tsm || !pdev->tsm->doe_mb)
> +		return -ENXIO;
> +
> +	return pci_doe(pdev->tsm->doe_mb, PCI_VENDOR_ID_PCI_SIG, type, req,
> +		       req_sz, resp, resp_sz);
> +}
> +EXPORT_SYMBOL_GPL(pci_tsm_doe_transfer);
> +
> +static unsigned long pci_tsm_devid(struct pci_dev *pdev)
> +{
> +	return FIELD_PREP(GENMASK(15, 0),
> +			  PCI_DEVID(pdev->bus->number, pdev->devfn)) |
> +	       FIELD_PREP(GENMASK(31, 16), pci_domain_nr(pdev->bus));
> +}
> +
> +void pci_tsm_init(struct pci_dev *pdev)
> +{
> +	bool tee_cap;
> +	u16 ide_cap;
> +	int rc;
> +
> +	ide_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_IDE);
> +	tee_cap = pdev->devcap & PCI_EXP_DEVCAP_TEE;
> +	if (ide_cap || tee_cap)

I'd swap if with else.

> +		pci_dbg(pdev,
> +			"Device security capabailities detected (%s%s ), init TSM\n",

capabailities

> +			ide_cap ? " ide" : "", tee_cap ? " tee" : "");
> +	else
> +		return;


If (!ide_cap && tee_cap), we get here but doing the below does not make 
sense for TEE (which are likely to be VFs).


> +	struct pci_tsm *pci_tsm __free(kfree) = kzalloc(sizeof(*pci_tsm), GFP_KERNEL);
> +	if (!pci_tsm)
> +		return;
> +
> +	pci_tsm->ide_cap = ide_cap;
> +	mutex_init(&pci_tsm->exec_lock);
> +
> +	pci_tsm->doe_mb = pci_find_doe_mailbox(pdev, PCI_VENDOR_ID_PCI_SIG,
> +					       PCI_DOE_PROTO_CMA);
> +	if (!pci_tsm->doe_mb)
> +		return;
> +
> +	rc = xa_insert(&pci_tsm_devs, pci_tsm_devid(pdev), pdev, GFP_KERNEL);
> +	if (rc) {
> +		pci_dbg(pdev, "failed to register TSM capable device\n");
> +		return;
> +	}
> +
> +	guard(rwsem_write)(&pci_tsm_rwsem);
> +	pdev->tsm = no_free_ptr(pci_tsm);
> +	pci_tsm_add(pdev);
> +}
> +
> +void pci_tsm_destroy(struct pci_dev *pdev)
> +{
> +	guard(rwsem_write)(&pci_tsm_rwsem);
> +	pci_tsm_del(pdev);
> +	xa_erase(&pci_tsm_devs, pci_tsm_devid(pdev));
> +	kfree(pdev->tsm);
> +	pdev->tsm = NULL;
> +}
> diff --git a/drivers/virt/coco/host/tsm-core.c b/drivers/virt/coco/host/tsm-core.c
> index 0ee738fc40ed..994a7f77c5c9 100644
> --- a/drivers/virt/coco/host/tsm-core.c
> +++ b/drivers/virt/coco/host/tsm-core.c
> @@ -8,11 +8,13 @@
>   #include <linux/device.h>
>   #include <linux/module.h>
>   #include <linux/cleanup.h>
> +#include <linux/pci-tsm.h>
>   
>   static DECLARE_RWSEM(tsm_core_rwsem);
>   static struct class *tsm_class;
>   static struct tsm_subsys {
>   	struct device dev;
> +	const struct pci_tsm_ops *pci_ops;
>   } *tsm_subsys;
>   
>   static struct tsm_subsys *
> @@ -40,7 +42,8 @@ static void put_tsm_subsys(struct tsm_subsys *subsys)
>   DEFINE_FREE(put_tsm_subsys, struct tsm_subsys *,
>   	    if (!IS_ERR_OR_NULL(_T)) put_tsm_subsys(_T))
>   struct tsm_subsys *tsm_register(struct device *parent,
> -				const struct attribute_group **groups)
> +				const struct attribute_group **groups,
> +				const struct pci_tsm_ops *pci_ops)
>   {
>   	struct device *dev;
>   	int rc;
> @@ -62,10 +65,20 @@ struct tsm_subsys *tsm_register(struct device *parent,
>   	if (rc)
>   		return ERR_PTR(rc);
>   
> +	rc = pci_tsm_register(pci_ops);
> +	if (rc) {
> +		dev_err(parent, "PCI initialization failure: %pe\n",
> +			ERR_PTR(rc));
> +		return ERR_PTR(rc);
> +	}
> +
>   	rc = device_add(dev);
> -	if (rc)
> +	if (rc) {
> +		pci_tsm_unregister(pci_ops);
>   		return ERR_PTR(rc);
> +	}
>   
> +	subsys->pci_ops = pci_ops;
>   	tsm_subsys = no_free_ptr(subsys);
>   
>   	return tsm_subsys;
> @@ -74,13 +87,18 @@ EXPORT_SYMBOL_GPL(tsm_register);
>   
>   void tsm_unregister(struct tsm_subsys *subsys)
>   {
> +	const struct pci_tsm_ops *pci_ops;
> +
>   	guard(rwsem_write)(&tsm_core_rwsem);
>   	if (!tsm_subsys || subsys != tsm_subsys) {
>   		pr_warn("failed to unregister, not currently registered\n");
>   		return;
>   	}
>   
> +	pci_ops = subsys->pci_ops;
>   	device_unregister(&subsys->dev);
> +
> +	pci_tsm_unregister(pci_ops);
>   	tsm_subsys = NULL;
>   }
>   EXPORT_SYMBOL_GPL(tsm_unregister);
> diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
> new file mode 100644
> index 000000000000..d17f5e0574c4
> --- /dev/null
> +++ b/include/linux/pci-tsm.h
> @@ -0,0 +1,80 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __PCI_TSM_H
> +#define __PCI_TSM_H
> +#include <linux/mutex.h>
> +
> +enum pci_tsm_cmd {
> +	TSM_EXEC_CONNECT,
> +	TSM_EXEC_DISCONNECT,
> +};
> +
> +struct pci_dev;
> +/**
> + * struct pci_tsm_ops - Low-level TSM-exported interface to the PCI core
> + * @add: accept device for tsm operation


What does "accept" means here? "Accept" sounds like some action needed 
from something but this is what exec() for. So far I have not noticed 
that allocating platform-specific structures prior calling a verb is any 
useful, i.e. having a separate state - PCI_TSM_INIT - is just an extra 
noise in the "painfully simple first TSM implementation".


> + * @del: teardown tsm context for @pdev
> + * @exec: synchronously execute @cmd
> + *
> + * Note that @add, and @del run in down_write(&pci_tsm_rswem) context to
> + * synchronize with TSM driver bind/unbind events and
> + * pci_device_add()/pci_destroy_dev(). @exec runs in
> + * @pdev->tsm->exec_lock context to synchronize @exec results with
> + * @pdev->tsm->state
> + */
> +struct pci_tsm_ops {
> +	int (*add)(struct pci_dev *pdev);
> +	void (*del)(struct pci_dev *pdev);
> +	int (*exec)(struct pci_dev *pdev, enum pci_tsm_cmd cmd);


A nit: the verbs seem working (especially reducing the amount of 
cut-n-paste of all this spdm forwarding) until I get to things like 
"get_status" which returns a structure to dump in the sysfs. Doing it 
like this means adding a structure in pci_tsm and manage its state 
(valid/partial/empty/...). Or we might want to generalize some input 
parameters for the verbs, adding u64 params is meh.


> +};
> +
> +enum pci_tsm_state {
> +	PCI_TSM_IDLE,
> +	PCI_TSM_INIT,
> +	PCI_TSM_CONNECT,
> +};
> +
> +/**
> + * struct pci_tsm - per device TSM context
> + * @state: reflect device initialized, connected, or bound
> + * @ide_cap: PCIe IDE Extended Capability offset
> + * @exec_lock: protect @state vs pci_tsm_ops.exec() results
> + * @doe_mb: PCIe Data Object Exchange mailbox
> + * @tsm_data: TSM driver private context
> + */
> +struct pci_tsm {
> +	enum pci_tsm_state state;
> +	u16 ide_cap;
> +	struct mutex exec_lock;
> +	struct pci_doe_mb *doe_mb;
> +	void *tsm_data;
> +};
> +
> +enum pci_doe_proto {
> +	PCI_DOE_PROTO_CMA = 1,
> +	PCI_DOE_PROTO_SSESSION = 2,
> +};
> +
> +#ifdef CONFIG_PCI_TSM
> +int pci_tsm_register(const struct pci_tsm_ops *ops);
> +void pci_tsm_unregister(const struct pci_tsm_ops *ops);
> +int pci_tsm_doe_transfer(struct pci_dev *pdev, enum pci_doe_proto type,
> +			 const void *req, size_t req_sz, void *resp,
> +			 size_t resp_sz);
> +#else
> +static inline int pci_tsm_register(const struct pci_tsm_ops *ops)
> +{
> +	return 0;
> +}
> +static inline void pci_tsm_unregister(const struct pci_tsm_ops *ops)
> +{
> +}
> +static inline int pci_tsm_doe_transfer(struct pci_dev *pdev,
> +				       enum pci_doe_proto type, const void *req,
> +				       size_t req_sz, void *resp,
> +				       size_t resp_sz)
> +{
> +	return -ENOENT;
> +}
> +
> +#endif
> +#endif /*__PCI_TSM_H */
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 16493426a04f..dd4dc8719c5c 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -515,6 +515,9 @@ struct pci_dev {
>   #endif
>   #ifdef CONFIG_PCI_DOE
>   	struct xarray	doe_mbs;	/* Data Object Exchange mailboxes */
> +#endif
> +#ifdef CONFIG_PCI_TSM
> +	struct pci_tsm *tsm;		/* TSM operation state */


I am wondering if pdev->dev.platform_data can be used for this.


>   #endif
>   	u16		acs_cap;	/* ACS Capability offset */
>   	phys_addr_t	rom;		/* Physical address if not from BAR */
> @@ -550,6 +553,12 @@ static inline int pci_channel_offline(struct pci_dev *pdev)
>   	return (pdev->error_state != pci_channel_io_normal);
>   }
>   
> +/* id resources that may be shared across host-bridges */
> +struct pci_hb_id_pool {
> +	int nr_stream_ids;
> +	int nr_cxl_cache_ids;
> +};
> +
>   /*
>    * Currently in ACPI spec, for each PCI host bridge, PCI Segment
>    * Group number is limited to a 16-bit value, therefore (int)-1 is
> @@ -568,6 +577,8 @@ struct pci_host_bridge {
>   	void		*sysdata;
>   	int		busnr;
>   	int		domain_nr;
> +	struct pci_hb_id_pool __pool;
> +	struct pci_hb_id_pool *pool;	/* &self->__pool, unless shared */


What are these for? Something for IDE (which I also have in the works, 
very basic set of wrappers)? Thanks,

>   	struct list_head windows;	/* resource_entry */
>   	struct list_head dma_ranges;	/* dma ranges resource list */
>   	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* Platform IRQ swizzler */
> diff --git a/include/linux/tsm.h b/include/linux/tsm.h
> index 2867c2ecbd11..6481cc99ea6d 100644
> --- a/include/linux/tsm.h
> +++ b/include/linux/tsm.h
> @@ -68,7 +68,9 @@ int tsm_report_register(const struct tsm_report_ops *ops, void *priv,
>   			const struct config_item_type *type);
>   int tsm_report_unregister(const struct tsm_report_ops *ops);
>   struct tsm_subsys;
> +struct pci_tsm_ops;
>   struct tsm_subsys *tsm_register(struct device *parent,
> -				const struct attribute_group **groups);
> +				const struct attribute_group **groups,
> +				const struct pci_tsm_ops *ops);
>   void tsm_unregister(struct tsm_subsys *subsys);
>   #endif /* __TSM_H */
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index a39193213ff2..9aaffa379cae 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -498,6 +498,7 @@
>   #define  PCI_EXP_DEVCAP_PWR_VAL	0x03fc0000 /* Slot Power Limit Value */
>   #define  PCI_EXP_DEVCAP_PWR_SCL	0x0c000000 /* Slot Power Limit Scale */
>   #define  PCI_EXP_DEVCAP_FLR     0x10000000 /* Function Level Reset */
> +#define  PCI_EXP_DEVCAP_TEE     0x40000000 /* TEE I/O (TDISP) Support */
>   #define PCI_EXP_DEVCTL		0x08	/* Device Control */
>   #define  PCI_EXP_DEVCTL_CERE	0x0001	/* Correctable Error Reporting En. */
>   #define  PCI_EXP_DEVCTL_NFERE	0x0002	/* Non-Fatal Error Reporting Enable */
> @@ -742,7 +743,8 @@
>   #define PCI_EXT_CAP_ID_PL_16GT	0x26	/* Physical Layer 16.0 GT/s */
>   #define PCI_EXT_CAP_ID_PL_32GT  0x2A    /* Physical Layer 32.0 GT/s */
>   #define PCI_EXT_CAP_ID_DOE	0x2E	/* Data Object Exchange */
> -#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_DOE
> +#define PCI_EXT_CAP_ID_IDE	0x30	/* Integrity and Data Encryption */
> +#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_IDE
>   
>   #define PCI_EXT_CAP_DSN_SIZEOF	12
>   #define PCI_EXT_CAP_MCAST_ENDPOINT_SIZEOF 40
> 

-- 
Alexey


