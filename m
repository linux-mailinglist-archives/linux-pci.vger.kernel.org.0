Return-Path: <linux-pci+bounces-14686-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF819A115F
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 20:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A922828201D
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 18:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D352420C493;
	Wed, 16 Oct 2024 18:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KpT/w1+i"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED8618DF6E;
	Wed, 16 Oct 2024 18:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729102600; cv=fail; b=gq/rEQWWeRpSny1ymBX/zYc75jIKbSUPpyxlrQCHJzefsEKClVcSZNW5qCQmInB0VKHaTwUU4az8JB7sg98s+KfqFsSoWGoxusFXX9LfOHGZ6Q4xNcjNRuDgSnNEYK8BlUMt7OxXLsDpl/We4VzYdD4D05nIXcBnTt2or90K+bM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729102600; c=relaxed/simple;
	bh=VSEXTE7nB7w50KpjQFIE71SkKdIDYjS5wMw8m6Y6I2Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CsC5CWbd88i6xiMUfTsK/5X1+eqhOPAhoq2bBlOlTxbjDeAUCcvMGWLVFZGGb7lo6KIF9SibVn/zGQ22ECqELlNslOILPVVvT28g0thVISXHrs+vWssTucn1w/j5ksTdh3uPre06E9f8wfmj4p3Jd7W5UQPZqgaVrGflCRkzQbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KpT/w1+i; arc=fail smtp.client-ip=40.107.243.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=buO20J4FOpcR+1FQB9e0oQNAjfWYZmS7SClpB8dIRygj6NKSx9M4jJwgfmfaUs+ZV4aFCGZRyGQqctU87xX5yrRrX7UvYTSqZ+EILgewoDeiRHYWF0KSldQha6PjVNxakihDpoTMP95ZxqJyA6RTdRIIj2+Z3va9F6meLjilxZI3mkl1NofIYlZ/4YDMNOkJg44GSNL97LN5SKw0uyX3iSqBKI2WEzf3tgxR44CSkgm//8MPzX0sv6knvSvNMdlG6mDPA2wJS0T8ag/i2duRXpOcLGF53/EGdp/uSrlh0rsLEHy70zzurf6HV8jlodb8ePztICVsCLYm3zWf9rLD4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d8soGce1iuRNNkzJ9cgm20/zFtW9IG5N+vbbjhJ+ADM=;
 b=JB/knEC+diFTvFmn0ZN/Bl9chIY6YA7hMY0de8hcJLJSaXz+qLKjLYO/VL4g8l/ZTPqC6qkqjM1zCSsGEgIvEurZIkTd9lIJe+ytDUiPsY6fdoVMmObaH2PuM0ujFCwLcBohe+QBjg7Le2RyYRc9X2Hjv52VbRJQKnBOajnZTTzxkWakS4+9gfjLNKRDOaB97hI05ZLHoezjQe7WxXpenKEC6I8J98AQAC8RjcZrajmLFfqqQ9cM8cfN69yv0kB2BEM5P+y80vnuOO5d/Cl7Tjhcxk1DPVNRr5L+Rms90dKn4s+Hvr6HZ/yRoplnxveMcpd9yDo2ZiRxKgF/JWHL/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8soGce1iuRNNkzJ9cgm20/zFtW9IG5N+vbbjhJ+ADM=;
 b=KpT/w1+iwMrfFk6j06LCEE+kjHXougTLmLLeCbwIwxhq5tNsHq+F+RlXvQRsmJpCty2LOy6fVc0iw/tIZqN2J/uzJd97DyxHCtAfC+iHxOrimpzzx0YxMLcVS+9kuvQTpbYRjxZSX2aXpFFu5xkAjtLwzX78ztE7UsgMRmC2ie4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 IA1PR12MB7517.namprd12.prod.outlook.com (2603:10b6:208:41a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Wed, 16 Oct
 2024 18:16:36 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%6]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 18:16:36 +0000
Message-ID: <4a298643-28f0-4aac-be2d-32b8ff835e2a@amd.com>
Date: Wed, 16 Oct 2024 13:16:34 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/15] cxl/pci: Map CXL PCIe downstream port RAS registers
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: ming4.li@intel.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, dave@stgolabs.net,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 oohall@gmail.com, Benjamin.Cheatham@amd.com, rrichter@amd.com,
 nathan.fontenot@amd.com, smita.koralahallichannabasappa@amd.com
References: <20241008221657.1130181-1-terry.bowman@amd.com>
 <20241008221657.1130181-10-terry.bowman@amd.com>
 <20241016181459.00000b71@Huawei.com>
From: Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <20241016181459.00000b71@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0019.namprd13.prod.outlook.com
 (2603:10b6:806:21::24) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|IA1PR12MB7517:EE_
X-MS-Office365-Filtering-Correlation-Id: 01ff8bca-800c-4d47-f599-08dcee0eabcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TTlzTGtPQm1sZzExSGtobUdTb3pwR2c1Z0E2QUR4UzhZY1p5UWRXdXRzZXJp?=
 =?utf-8?B?ZVU0cWRrK1lTOWxnL25hcFFvcUcwTklPNDI3M0RFVmRWZDNlRVcrbldRaFQ3?=
 =?utf-8?B?eXI1dkhPL3ZFcjdVRWxqZUFJVFJkVUxLNHk2NG1PL1BxYTNhR1BsdDlldjht?=
 =?utf-8?B?eURxRjJJYW5YUXlHekpkdGJOUE5GcDI0dERiMHIxUERlNVlSZ1RMSzBDckdp?=
 =?utf-8?B?OUpHYmY0QnlFWG8vK1psZkptQXpHSE9nU0VRdmFaTjVGczg0OWp2QkpaR1RT?=
 =?utf-8?B?WVVtRE4wc3ZxNFZrbGcvYnZ4K21KYnFoUW9EL3REd0NvMmhpck5NSTBBVDhk?=
 =?utf-8?B?V2luV1ZvQ29RYkhrTngwdUxObk5ZU2UwcjRKZHpNdEZ5NFNTSTlDcENWRUtH?=
 =?utf-8?B?ZS9IQUZ5Tmo0RzhhNE51NStBQUlDaXJwZUF3K2ZlOW9heGE2VlZlcUpaSGhO?=
 =?utf-8?B?V2xDY1hLaG82MmNUMmlBU3B0R0VWcW40SnJtRVVONm5NZE9xM2ZlMUVMTCtm?=
 =?utf-8?B?ZElQWkNXL2lnYVhQRVpQbDhub1RnSDRNUTVBZkc4TDRmdlBseWZmaTNhb3g1?=
 =?utf-8?B?QUpRZk9Rdzkwd3docGhOMW5ZMlhvcjZhMjBvYWpuOTVZUzdkTDViNWNYMnVO?=
 =?utf-8?B?TVhVZUp3a0N6MGdJbjJMMm1hV081VC9DclBhWUExNlRlR0dVQ1JQV0xNNDYw?=
 =?utf-8?B?U0ZJUGJST0NUa0lzMW1uMDZRSUZybzBjZkQ1MDRHSkUyd0NLMVBZNUFSM1JH?=
 =?utf-8?B?R1hlRlhGQ2N5dkcyYUtYOGVJNVIrc0xRbFFHS3VKNlVnbUVLaTN3OHk5RDhz?=
 =?utf-8?B?UklXWVhOcWJBWGxZaG1TazN3WmgyRUJ6QjBrOFFvVjhkUGUrOCtrSVUvRWhI?=
 =?utf-8?B?OWVBaDY1UjhPUVNpSmRhcCtxRk1tS3dwajVXTm1HTEFES2hVTXZxN3g0dXJT?=
 =?utf-8?B?Z0d2bWt3WVQ2MHQrVG4zcTFrM0VsNkNvbzA5SnIwSE5BUi9MSWRjR0VTZ09U?=
 =?utf-8?B?TFpWclMrb2dRTVYxQUFKWjdTZWQ3K3UxOWdyeFptdXpxdnkxYlJZQ0ttWmxZ?=
 =?utf-8?B?cEFWT0hZSFhCNEM1OVd5cFpZaTJZZ2JIN3JBc3RFd3NjN3V2RzdlZ3UzRnFP?=
 =?utf-8?B?K2J3R3RNMlNUT21ubUkvSXd1S1NXdm1hS2FGbnduR2svTnpEQk9qT3M4OUkw?=
 =?utf-8?B?ZHNaSDBBNGxzOG9INmdEZU5COFhzSnU1RHFVbWlnTmpFSEN1NWg4VnRybWgw?=
 =?utf-8?B?enkxUVd2WTNJMEVNMzRkSyt1SXVKM1dmUDlKS24yUWlUZC9XVENpb01VZFJF?=
 =?utf-8?B?b2FXUlZPTDUvZjRjTndTQzFmRkZ6eFNaekVhaWU4amRNQml6cEJtOXBlUXpV?=
 =?utf-8?B?OUZHUmYvc2swbGFzZjIxYm5TbjFLZklWU3d3V3NzcmlCR2EwOGpROE9MMEdO?=
 =?utf-8?B?cURueUFjZ0hqdHBYUVQ3L2I3OFZiWjZmZXpvRkZDT3hkdlNwZGxZN0dOTnE0?=
 =?utf-8?B?TC9hTSs4SE1Bait6aGNRQ3hZaG5jTUxjQ2NoaS9tQ0xOcWkrL3hyQWVWQ3oy?=
 =?utf-8?B?Mk9SR2NqSEgzdUVycE1Pc3EwMFFLaGdGWlhxdExISFArVk1sNHNJVlo3UjE5?=
 =?utf-8?B?K0F1TnBCVERiMXZCekl1NDJ2bnZFMGNNcjFYMmg1QWV0V0cvcFR1elhjN1g5?=
 =?utf-8?B?OVVCRWZCOCtySDFJZUUzM2RadTF6U2Vlb2RreWJsRTNFSVU1NUgxNkRBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TnNKNklnZDU4NXM2bTZRenRVOFVnd1p2YXE5dG54TkZ6OS8zcFMwenl1SHdk?=
 =?utf-8?B?VE4rN2JDT2UyRlVhSjFpM3BOUjlUUmJ6eGFVU2FRSnJ4MGFHYnpOc1pUcnps?=
 =?utf-8?B?enVhRWhhOVNNblo3eU43RmhQOEN1Y0NHelY1eHNRYmt4MXYrV21DWk9HOWYr?=
 =?utf-8?B?SVNTM2NsOUFPQXhwcDNaMGhiNGlhak5zQkpySFpOSnlCTC9PNFVJS3NVSVY1?=
 =?utf-8?B?RmYyUEg3SXE4b2tCekxqNm4wL1FFZ2xCRkVTU0VOcWJvcm50a3dxTktwd1Ex?=
 =?utf-8?B?SDF5T3FmaDI4VkZ3a2l6Tk1XWkdVek5PajVNOElaYklWTzloTjFaVjZXeklz?=
 =?utf-8?B?a09yMk5TZ1Q5NTl2TVE0bFpMWWNYcnU3WnUzL3ZTQUZkUllqbnFOODJqdHgz?=
 =?utf-8?B?cm5CaVc0VlVNMy9YSWR4MkdrejE3WjE4ZCtycVFBT2w0QU9PTTBGR3BPMkdr?=
 =?utf-8?B?VXc4clBjN0prYyt0OFFRdjI4SERoWWU4a0Z4UUZZbmxiUk1uNjBqbXBCbnla?=
 =?utf-8?B?YUJJUE1SVTdjRXpzMW9aS09tc2M1TE1yRTh4UlRpWmtsK3kwdHZzQkp4OFFE?=
 =?utf-8?B?MkllbmNnUjNJelF5bkNSY2hKZFZEbVVhVU9jenpHVXErT3dPZHBkNldlU2Ew?=
 =?utf-8?B?NHpSRjVzdEh2aUlkWUtGZVFVVUFqcGtYOWloTHRIbUpIUkMwRkFUOFpJdVBJ?=
 =?utf-8?B?Rzk5YWg5TkxWRnJvTlN4UUxFZ2ZDanJXZ0xSdDVWMHFxVGVsWGhmUU42Mngy?=
 =?utf-8?B?YjN2elJuQ2ZyM3FRdjlXN1JDcndZM0xXU3RIbHYyVVB0YWFLakZROS9pVm9S?=
 =?utf-8?B?djNCa0NUMVppeFpCUTFPTGZIMGErdVgzNTFlbUQ1RkZzTzRya0tqSXRLMUFq?=
 =?utf-8?B?Y2JGT09HQkRyMGxIc2lSSVdGbS9pRGhRS2wwYTh2UjNCTTNxcFhkVFY1T2NY?=
 =?utf-8?B?Q0xzdWEzVkZWaGlkL1hhbFkrS0Zmc0w1TGxKN2tyU085NmMyak9BSkl3TllZ?=
 =?utf-8?B?MGFKUWwyS3ZMUkhsMHJNQ3IwN0wxL0VOeTRMZ2x4UmZhcTE1dXNEeDRUWXZn?=
 =?utf-8?B?Q2F1UE1PMlRBbnFEY3ExT3QrYzc5R1gxYlgrUlBJYXFtWW92NHJhR3VaT1V6?=
 =?utf-8?B?VStGN0dFcnhnZ3ZIWlB0SDV2L2FCNUxna0NFQStDWFZGRUVHQnNHRUZPdllM?=
 =?utf-8?B?UHdXZjkwb0dMT0xadTV5ekFNK2ZSTTBCeisva2ZXZHp6cm9OZFhtTGtXNmJ0?=
 =?utf-8?B?RHord2JKVzg4V3pSdjVCODVxMXhjV2tlOEVFRHUwcnFqOEZlU0lIWG45SFFj?=
 =?utf-8?B?QW1idWJMNnhIc3BxVVZDakhwbFU2R2RFUFYxdm5jcVg0NDRlQWU1UmgwaDF1?=
 =?utf-8?B?R1pBZGtVYzN0YXFhMHovYzJoMmtNa3NTTlU1YUtDVFM3ZTU5aG5kcTRqa0FW?=
 =?utf-8?B?SHQ0OVU0dVNLMWVaamZtTEVSMHByWWVFWGV1YUJINDIrSzhTYnJZODZHOW83?=
 =?utf-8?B?Q1lhWjFXb2N6MkdxTlRRWitVcFhSNm1vclZPRExsRWVzZGpUaHV6OVZmYW4r?=
 =?utf-8?B?TGROU0xEcHlTcHcrZ3NOV0l3TTBFazBxeTg2K1laMFJrVjZtdDlPZEl3MWlD?=
 =?utf-8?B?Nm5STzN6UDlEQmE0cU91Y3pnb2ZMTGxxRHdjTEhpaDM0L3lPOUI1eXgweFc0?=
 =?utf-8?B?QldheEgxT3JtQm5YdVZ5TjN5cVRZVkxteTU0ODJtUGptbHY0K1Nha0FtMHVh?=
 =?utf-8?B?SlJBZzBON3BpdGp6cEVZSGNJQ1VFeENpOHVZNU5xV0hDcnFISGFjMGdKTlhk?=
 =?utf-8?B?Z24xMUdJakJ4dVE5ZW8vcWNwZWFsVU9oM0paVkp2YXBncFRBdE0wMXJwd1du?=
 =?utf-8?B?cDFYa0d0Z05pMFpCd3hPMzZFRk5JZDVaTTByZE92Qmo3ckpoWWZGR2xpaExF?=
 =?utf-8?B?eFBsTUZxZkZWRUJsNWNoUk5hUDFmcTZhYVFINFc5TFR1Z0tGc0VVZW1hSklM?=
 =?utf-8?B?c1F0ejJSaExlR0JhSG40cDFWd3RvOHgxc1crcUt1ZDFBamkwV1VSOWhsVVlP?=
 =?utf-8?B?MnA5R2FDSXN0ZEVOcjZ2UGVETWVrUlFtTHFBM1RrdFJ2b3ZhNmtZQU5DR0NQ?=
 =?utf-8?Q?HxLDpo0HixgZkzd8x2gJVV2Kv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01ff8bca-800c-4d47-f599-08dcee0eabcb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 18:16:36.0478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wi4aZ/t1vPl8F+781hrbYEEr+8ga6QyDZfxOCA92GWh7WEFv61gI0P9Bp2v+y1c7tRcYZivoLqQ6zfQd8HLdWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7517

Hi Jonathan,

On 10/16/24 12:14, Jonathan Cameron wrote:
> On Tue, 8 Oct 2024 17:16:51 -0500
> Terry Bowman <terry.bowman@amd.com> wrote:
> 
>> RAS registers are not mapped for CXL root ports, CXL downstream switch
>> ports, or CXL upstream switch ports. To prepare for future RAS logging
>> and handling, the driver needs updating to map PCIe port RAS registers.
> 
> Give the upstream port is in next patch, I'd just mention that you
> are adding mapping of RP and DSP here (This confused me before I noticed
> the next patch).

Ok. Good point, 

>>
>> Refactor and rename cxl_setup_parent_dport() to be cxl_init_ep_ports_aer().
>> Update the function such that it will iterate an endpoint's dports to map
>> the RAS registers.
>>
>> Rename cxl_dport_map_regs() to be cxl_dport_init_aer(). The new
>> function name is a more accurate description of the function's work.
>>
>> This update should also include checking for previously mapped registers
>> within the topology, particularly with CXL switches. Endpoints under a
>> CXL switch may share a common downstream and upstream port, ensure that
>> the registers are only mapped once.
> 
> I don't understand why we need to do this for the ras registers but
> it doesn't apply for HDM decoders for instance?  Why can't
> we map these registers in cxl_port_probe()?
> 

We have seen downstream root ports with DVSECs that are not fully populated 
immediately after booting. The plan here was to push out the RAS register 
block mapping until as late as possible, in the memdev driver. 


> End of day here, so maybe I'm completely misunderstanding this.
> Will take another look tomorrow morning.
> 

Thanks for your reviews.

Regards,
Terry


