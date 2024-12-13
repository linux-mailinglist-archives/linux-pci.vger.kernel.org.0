Return-Path: <linux-pci+bounces-18393-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 585B29F1110
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 16:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E42F1634C3
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 15:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2291E0E10;
	Fri, 13 Dec 2024 15:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2OQSgMfS"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DFC1DF988;
	Fri, 13 Dec 2024 15:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734104109; cv=fail; b=KrX07e1o4w+rFVwhLDxpmF321MiZMiqlIY0mgZlP1usOy3JSYzpCNrQn8qpW4Rf8S3/ugg1hvnv3xak5v0Zoqfpdpm6D36kJ0wiPCsX7DFlSvL06Iam+YwD7Lh55KQ0vdVhZvjjv9rQs+0Zcb+/8iG87wg98M1cIkiTvryjM/Sg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734104109; c=relaxed/simple;
	bh=f5wTeQvBEXmfp4dRkg0AKKFFr8ptfHNdpZoBhjHZUAk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dEZ8KRxrsKdUorJFIhy0JXy3Ulp3Qaelf42vEFk/6HGCSiPyrBdeeVrkx6Ah0Oe/XmVixvuhdeFB327eY1GPjKvA7yvy+5vooDdTJasxexT1j6Ee+NrtUTHMWiCgzrpXFee2RxGUpiUnwAt2CN+lhYhLvxjCjUOU7FGBMgPzUJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2OQSgMfS; arc=fail smtp.client-ip=40.107.243.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kjQ8Dpnc8S6EU4Up0hzgvnZznMPzESw5JokFWa93DY/6p8ogEtB7JvlRHh5N8sGIpZDPpNBU3mogazvl3cp+HMd4ItnJF401kuo6RZaZtxf1U0hxIc/uGJoTbxQ3tE5xKOkqtAuRDOiqcI291r6qkh+3h93bdSYluw3yvNtQw6G6qlrb0a82TyQ4SfzLmB/xK7WmzpyI2pu5GcGP6E8oB7zvJB6FSBNwaGMn8G5K0EtlJYZLlOH7CXYr5BkMoXHOjXpDIPThhESVpviQvHzZ5RznwmkAtodT2Ck/GIhCV+BBj3WEyXxbOWb3g9pCrxBKvRXvn1j/iWSGOI/5Lse5gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fsmsHCCJsCfUvKGzuT8Q0f+Ir2MaXDLbkiNvO/0/02Y=;
 b=YT8LMMo/kCyzErk77yw5krvw1Z1atMN0eSufKX3tqi6evrfcbOMadzl+bpxDsW3Er4YB5HxW5GB+tUxHZjJG6asoRd9IjcqYNlzgK3co/SB7dhALi77bdnGJwFYEZNyBFDZKsufIzzvcPOaem/gWsTjRxSy9hvQXX0z7lr8M83hHi7addcprTnhN6jPbJZdA92eNnQh8JKr2IfJw4gH0cqllWMaYNINGZSGgRh5hN2K2t3W5E/9SG50Gxbt1jjX4xsXtB4zDNWII65E+Z1zS9qFjcbK9plrgUCklnLM+XsPX5nntQAgdKfmFiQN61rc0ogDOED0URTixDJ1bI0kNhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fsmsHCCJsCfUvKGzuT8Q0f+Ir2MaXDLbkiNvO/0/02Y=;
 b=2OQSgMfSimgrQ+X3j2KuuRu1hp1RGbGZYrc4r7vp47wrZUDXLjUkv1sa1SrJLPzvkArSH9beBC4Mkzk6RjKe9HLSakjkK10eKXzB5I87XUW1ir35l6bhnBtKZPARLa06RQk6B5U+eM78QANT0/VsJyKVvejAFsXeDHHW1e5/Xu8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 MW6PR12MB8706.namprd12.prod.outlook.com (2603:10b6:303:249::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.19; Fri, 13 Dec 2024 15:35:05 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%3]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 15:35:04 +0000
Message-ID: <6525e2ba-b9d3-4f3b-8c7f-8e0b69cf096e@amd.com>
Date: Fri, 13 Dec 2024 09:34:59 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/15] PCI/AER: Enable internal errors for CXL Upstream
 and Downstream Switch Ports
To: Alejandro Lucero Palau <alucerop@amd.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 nifan.cxl@gmail.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
 PradeepVineshReddy.Kodamati@amd.com, Li Ming <ming.li@zohomail.com>
References: <20241211234002.3728674-1-terry.bowman@amd.com>
 <20241211234002.3728674-16-terry.bowman@amd.com>
 <8a87754c-bb27-37d9-2423-cce6170de496@amd.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <8a87754c-bb27-37d9-2423-cce6170de496@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0044.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::19) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|MW6PR12MB8706:EE_
X-MS-Office365-Filtering-Correlation-Id: 51d9aedf-f042-456b-6b8f-08dd1b8bb753
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?alEvaWNUbnQvWnRhb1ZEMnFSYzg5K0k5b3EzbUt1SW5GSHVUblczOFl6YWZz?=
 =?utf-8?B?KzIwbFNJa3pTU0ZNdms3YjEwS2twNzZLc0ExbDBwNGVuME1ZSEVELzlscHZU?=
 =?utf-8?B?YmRkZElQVHBTQytBUHFIREFxTmZNYzV5b1NnWFUyUXkvMEVCWjMySWQ3TGlF?=
 =?utf-8?B?amdRWmNpVHh2YmhVVjJCWHIzWktGMlpkRG1pUjFXRkhRb3dYcU1WeTZsQk8x?=
 =?utf-8?B?WHRLbll1b3J3OE5Nb3pVNlFpRy9qSldPSkVKRnhGNmZYSVFJdUlHWGNpT1Ny?=
 =?utf-8?B?MU0vNkN5ajRIL3hUOUNUQVNJZUdnYVNoR0dZTW5nOVMxM0dKd2RUVmgxMm1U?=
 =?utf-8?B?dEprbDFlNCtnS0FabnZaTWlvNEkwOEdmTDBUZjNFd0NDR1JnRUZxNThtWDZ5?=
 =?utf-8?B?N3h5WTBWVUF4YmYzR2F5YTU2TExXcHRFQmxIZXR4cXhxK3d0UFI3d2NtQ3g4?=
 =?utf-8?B?OG5KS0pwNGNFdzNaeW5ER1B1UWU3ZnpkYXU5d3JtamF4SFp5SXoyd3h3aDBI?=
 =?utf-8?B?RWVVK3FlelZ1VDhrNW9FNUVYdlVYYXJqaTVqRU5QNEhjeXZLR1Z2cXdPWFJl?=
 =?utf-8?B?Uk9TL0hXT2VwUjVWelJ5MHBJTnhSczRpdlZ2VlFtdHZXODdGSTZjZmM1ZjJZ?=
 =?utf-8?B?V0I2NWNqYklwNnczK1daR2hLdEdBRy9reUxoZE8vOW1XTFdOam1kZzgrUWdY?=
 =?utf-8?B?WXAva2VjanV1WVZBYmw5NU51VFVaeXU3MkNLakJKT0JSOUJOUzRNSE82MWlp?=
 =?utf-8?B?YXJ3d0VXOWlSRzZKeS9XUXA2NTlnNHRaWHl0eVgxcU1aZTVBQUx3bUM1akVM?=
 =?utf-8?B?WmliaS82cGEvVjYyTjByejBzbWtBenEvVkVMTjRCSnhhMDR3akcrTVc2TnNG?=
 =?utf-8?B?RW9NTkg2Qmt5YmFYQkhVWTBuT0FTb281elBEVmR5TDdTOHFSWUUzWGJ6a3JE?=
 =?utf-8?B?VFJJTnhJQ1JtT2xZLzBuMVBoODBUWjVlNmlsWDJoaVVKWUR2MUF5R01rVm1N?=
 =?utf-8?B?eEk0Z01zTGE5OE9naWc1aDVFSWtwZFR2VGw3QkhSK25DMDl1bkMzcmU1Z0Fj?=
 =?utf-8?B?dk91VUVtaU5TbFhsTTRmQjVlaVkzblhMUTdBaWdBQ1UyUE9EWmVHSnVJanFB?=
 =?utf-8?B?eXpPcHNScHJkNCsyS1IrdXFGL1ZoMnJEWjRUWmFjUTlkL0QzdUZ6bXJ5VENG?=
 =?utf-8?B?QW5ESEJnWWxwTUhJc0VnWGl3Q0J6MFViczBBTUtIdlpNWWUzK0NmOU1ET3Fo?=
 =?utf-8?B?UkhQMituOEYzUThnL043czlIWVlvNVBON2cyMUVUUUFFaHcrMWFSNXJCSXNJ?=
 =?utf-8?B?aDJGMlpWQm5leUdaZ084cTR1K2l6VW5ZaVNXbVR5L2RJZEhydGx2bEkxTEkw?=
 =?utf-8?B?cVRKalJjeGpGYXZMM1F2MEYyQVNEOTh4aUdvQUl3TEE0VnBwRnI5YkYrc0xZ?=
 =?utf-8?B?MWtJSGtpaGlKNUQxeUZsQ0RFVmlMRUY0R0VTYTcyeURtbUM2VWlDajhVQ2NI?=
 =?utf-8?B?U1ZlaWtrdnBySWVFNDE1TWhyc255ekxwT3BNbEQyTHZUM1dXMUZkQ3BzZktw?=
 =?utf-8?B?YzNQRW0vaUMyY3BWZk8xenVsVXRpbkhidldqSHhRbTdiM2t0VForRkdmQ1JR?=
 =?utf-8?B?eFR3STk0RjdHSGFNeVEvS0VBai9JdmZuTnBhalBLVmhNb2dVdDE4bW5Xd1oz?=
 =?utf-8?B?dkRVTmhKTWV2YytOMGJwajI0M3FEWS9MbEZtNUlYbU1teHQ1L1VTZUFVTnlh?=
 =?utf-8?B?K05KNjlSdlUvdjBUbXdVbDM0ZytvMEtJZUFHa2R0YUVJVjhtN0I4RE5LL1hk?=
 =?utf-8?B?TTJrTmRpMGxZMStMckVocXRRbm93RFRNWUdXZ2x2azA3Y3BMVlcvaGR2VEFY?=
 =?utf-8?Q?wwZvTfMkyGkzr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGloQTZxeUpIWXhQUVBHWmRzdWxBdkVIbWpBZzFwT3YvRHp2RnVyVTZUV1No?=
 =?utf-8?B?ZUU0d1BEaXVTUWV5QzRnTnd4ajkyVXc1blAzY0ZMT1dJTG1QajlvN3BvdU5G?=
 =?utf-8?B?elZUQS9pampZT2prOS9WbHNsb2g3Yk1RWWNMek9GZ0VyTWlnQkY1dlVNNHpr?=
 =?utf-8?B?RXNFN3lrSW50aXRUV1FKcm5adHk4N0xvYnZ1UnIzQnRmZjV2aFQ4VkV0V3Ew?=
 =?utf-8?B?eVl6Yjdsa1hibUt4NG9xakVlbnpxczBoVUpVdzNSdGFlRWluY2lNK0s1blBy?=
 =?utf-8?B?TFNQalhYYmhjTmxIWTRFejExandBMW95K3hhbmxuTDI0S3Irdzl6ZzV4ZVd2?=
 =?utf-8?B?ZGFnSDQ0WHZSaXo2UWtpRlRSSmVGb0ZCV0Yvd3VtVjdsMGtkNFVReEdKNkJm?=
 =?utf-8?B?OUowUU5IZEFWOUZBVkxzaEdOU1VSRkl3TWRsSnJndTdwdE5DUm1tOWhCUHlS?=
 =?utf-8?B?UVJSTVlxT1pjREZIb05nWVpGNG50aDM2QUh0VmlxYVUrVUJEZU81eGZ0bHRq?=
 =?utf-8?B?S1FvU2J6cll1ZWhNMkZXaUJDK0Nqa3M5YjNEcmJjUHdLMGZOaGtRTUZ1cjk1?=
 =?utf-8?B?bFY3aFVJWExPbGhWM1Vyc2V1N0QzRVczYjRuQ2h3cE1xeVgwbFdYb0dOalND?=
 =?utf-8?B?NHRqdTI3eVVKUE9wdkRJQ0g5ek5oRHcrU1JMeFY0cHY4MUtOMjRSR0RDTkRY?=
 =?utf-8?B?Z3VoSWhpTndrNEIrVCtaRmh6MHQ3UStRNE1EMlBoUHhVbVVXZmJKMFowb2Rj?=
 =?utf-8?B?cm1LN0YxaThTZFdDM1RzNjFMZGJNcXVNSXFsY2trT2dzWlJzQkhqYlhqY1lq?=
 =?utf-8?B?N01XZnhpTTQyYUVDVFFCME5BRyt1QXFDb1lMS2Y1SjI2clVOUzU0ZFNrYWcr?=
 =?utf-8?B?d0pwVkNsNVB1RUlMaVdsdjQyY25vRWNRTGRxY1pXNFRqcUlWNXNvc3pCTlBr?=
 =?utf-8?B?OW1QOVNqUXdEY29pTlZFbGhGWEFhTVBjeldQWVBiSlN2ekFZTktNU01ET2tZ?=
 =?utf-8?B?MnArTHVRNmxxdlkvM3RDWEJ2OFEvNzZsNkZQQ25icTBQNjI1TmhFUWtHdnlz?=
 =?utf-8?B?Q1RjT3hvanZoK3ZHbjV5QTBReVJibGJ2YzlJMGxSQk1Jb0cyMzhCQnNHZU9D?=
 =?utf-8?B?MHNVd0FRMWwrZVdiTlF1ZnVOemR4VW4xK1N3bVZYcnl6WDF0QU5Bc2pVYy9Z?=
 =?utf-8?B?dXBHM042eU5DbHRXN1d6bDJPUGR6ckc2R2RYUVJURVR2YnhvMVR0alZSNlRr?=
 =?utf-8?B?T2FKbGlOS011VklLaGxncTZqa2NocGk0UWVqRCtXdW11QjVYL2V1bUx2UFdN?=
 =?utf-8?B?RW83QWJwZk5YZmJSNVRlWWN3UjVrNmZIOUFrSlJDSWZQY0l5dW93bm9lakh0?=
 =?utf-8?B?dExvdHNlOXlBdUJBbjNpRDREanN1OUEvaEFTcTBTRkJSTlcwSkhGOTdtV2Jz?=
 =?utf-8?B?czJEeXdsWkFiT1pDSzlUcFZkTERuN2hnTU1tR3lVMVpiNERXY3ZENGJPVGNE?=
 =?utf-8?B?eHdvbjZ1RWt2SlFyL0hHWklrdm8rdnlkUGppNi9uaHlRYmN1VFZHNTFGaWZu?=
 =?utf-8?B?Vmc2SzFGbGdmS0x6b1FPeE90R3VzeGp3RitWb29vM3NLNWd1RXVkWkRldW81?=
 =?utf-8?B?TFZjNjR6bHRtWjRNalh0S1QvZFIxVW1QTm9TYlVaeVZpTldHTWQ1bWI1V2Zk?=
 =?utf-8?B?ZEk4eUtyRDVMMjlwWnJZOEF3UHZNM2lQVXlDSmR4STQ2MVpSOGN0VDNQQmVF?=
 =?utf-8?B?aTdlZWtpYUZaaGVVTTdzL0lkemdSQzZqb1pIbUlLUVBENlZVUG00SGswOXZV?=
 =?utf-8?B?VjVqSTBEUUxYR1FFalFkM001UkVTSXNTYmdkTS81R3FaM2JCeXpTdGZ1dDkw?=
 =?utf-8?B?b1d1YmpUVUE1eGF5NFFxejRRdldUZHNYYzVjTlc4TGFLNnJtb0JWRzJsbjg3?=
 =?utf-8?B?cEU2K212enZvSW9NOVd3NWVKK1JNY1BUNnprUkZ3aHFYMTlxeGQzMGtzb2xJ?=
 =?utf-8?B?REpRMGhFSUZPdHU0Q21wZDQ2TThMKy9KMmdiZDdIWEtuY3hUS0J6TnZvRXJ0?=
 =?utf-8?B?bit1N2x3V05mUHZlR29ubERFdWdDdVViSWFDNGJLM0ZkSEM5OFFVZmRHb255?=
 =?utf-8?Q?VVvps84TLRtxVDReqTJPKxQG0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51d9aedf-f042-456b-6b8f-08dd1b8bb753
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 15:35:04.8386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NXMv0Du91o4jKPWwrNEsJQbb0+S3/Fwdt+fXIbahCjGyMqnpYgj/mTYCBHclW8tK+z7CQe5yAskPjZVLj+o/Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8706




On 12/12/2024 3:44 AM, Alejandro Lucero Palau wrote:
> On 12/11/24 23:40, Terry Bowman wrote:
>> The AER service driver enables PCIe Uncorrectable Internal Errors (UIE) and
>> Correctable Internal errors (CIE) for CXL Root Ports and CXL RCEC's. The
>> UIE and CIE are used in reporting CXL Protocol Errors. The same UIE/CIE
>> enablement is needed for CXL PCIe Upstream and Downstream Ports inorder to
>> notify the associated Root Port and OS.[1]
>>
>> Export the AER service driver's pci_aer_unmask_internal_errors() function
>> to CXL namespace.
>>
>> Remove the function's dependency on the CONFIG_PCIEAER_CXL kernel config
>> because it is now an exported function.
>>
>> Call pci_aer_unmask_internal_errors() during RAS initialization in:
>> cxl_uport_init_ras_reporting() and cxl_dport_init_ras_reporting().
>>
>> [1] PCIe Base Spec r6.2-1.0, 6.2.3.2.2 Masking Individual Errors
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> ---
>>   drivers/cxl/core/pci.c | 2 ++
>>   drivers/pci/pcie/aer.c | 5 +++--
>>   include/linux/aer.h    | 1 +
>>   3 files changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 9734a4c55b29..740ac5d8809f 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -886,6 +886,7 @@ void cxl_uport_init_ras_reporting(struct cxl_port *port)
>>   
>>   	cxl_assign_port_error_handlers(pdev);
>>   	devm_add_action_or_reset(port->uport_dev, cxl_clear_port_error_handlers, pdev);
>> +	pci_aer_unmask_internal_errors(pdev);
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_uport_init_ras_reporting, CXL);
>>   
>> @@ -920,6 +921,7 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport)
>>   
>>   	cxl_assign_port_error_handlers(pdev);
>>   	devm_add_action_or_reset(dport_dev, cxl_clear_port_error_handlers, pdev);
>> +	pci_aer_unmask_internal_errors(pdev);
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, CXL);
>>   
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index 861521872318..0fa1b1ed48c9 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -949,7 +949,6 @@ static bool is_internal_error(struct aer_err_info *info)
>>   	return info->status & PCI_ERR_UNC_INTN;
>>   }
>>   
>> -#ifdef CONFIG_PCIEAER_CXL
>
> This ifdef move puzzles me. I would expect to use it when the next 
> function is invoked instead of moving it here.
>
> It seems weird to have such a config but code using those related 
> functions not aware of it.
>

I was asked to remove the dependency on the KConfig (ifdef) because the function is also being
'exported' and used across multiple subsystems. Because its exported, the function behavior
needs to be consistent and independent of a KConfig.

I'll update the commit message with this reasoning.

- Terry

>>   /**
>>    * pci_aer_unmask_internal_errors - unmask internal errors
>>    * @dev: pointer to the pcie_dev data structure
>> @@ -960,7 +959,7 @@ static bool is_internal_error(struct aer_err_info *info)
>>    * Note: AER must be enabled and supported by the device which must be
>>    * checked in advance, e.g. with pcie_aer_is_native().
>>    */
>> -static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>> +void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>>   {
>>   	int aer = dev->aer_cap;
>>   	u32 mask;
>> @@ -973,7 +972,9 @@ static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>>   	mask &= ~PCI_ERR_COR_INTERNAL;
>>   	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
>>   }
>> +EXPORT_SYMBOL_NS_GPL(pci_aer_unmask_internal_errors, CXL);
>>   
>> +#ifdef CONFIG_PCIEAER_CXL
>>   static bool is_cxl_mem_dev(struct pci_dev *dev)
>>   {
>>   	/*
>> diff --git a/include/linux/aer.h b/include/linux/aer.h
>> index 4b97f38f3fcf..093293f9f12b 100644
>> --- a/include/linux/aer.h
>> +++ b/include/linux/aer.h
>> @@ -55,5 +55,6 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>>   int cper_severity_to_aer(int cper_severity);
>>   void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
>>   		       int severity, struct aer_capability_regs *aer_regs);
>> +void pci_aer_unmask_internal_errors(struct pci_dev *dev);
>>   #endif //_AER_H_
>>   


