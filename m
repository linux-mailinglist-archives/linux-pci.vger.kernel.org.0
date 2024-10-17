Return-Path: <linux-pci+bounces-14807-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B01E49A2879
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 18:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D37481C20FD0
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 16:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA5F1DE2DD;
	Thu, 17 Oct 2024 16:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EOmfiBV7"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958571DED70;
	Thu, 17 Oct 2024 16:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729182106; cv=fail; b=ctfFb4c8I5JvyttNMibV4hamYmcK0jCDjQLBv4k+/bop4hNJVIliyXyyKm+pXkZ7z7CUTPC//PcesksE2SlODYAes+H+un+pLLuraLUZJKm6kCMlQaIJETNGqrMnUZ/9Ong0quceUXfEswL3Lg6vaijnEGUxeBXaNxtVzXCak8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729182106; c=relaxed/simple;
	bh=oERP7EMZUsJCisaSaoRb/lE0F/D1Yh3XqW0H9Sn7e/k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QdUsXt6Qm2EB9bVD1YFfHOeZzgV2hI2bH8pXYP70NvTcjoGRh6vUcFHqkJV4t9adBodUO3nEuSHWH7GNVyU9QHSTozh8xJAbJ0GyX/uSaiNQYeLpCiFZF2OLWccaCThxiJYZ13A2nXIhZwj4a/vADNnN2Qf7MrEr0bhhOhMz8ME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EOmfiBV7; arc=fail smtp.client-ip=40.107.243.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WuaaX1kxXnePwrNhDAkJhrxcLwndcVbRjyzRBLP3O1fhX3Zgor+iPpxZTxYT/tG+3RfrqvYA/E0rEqGpoaLqKSBkrzx6++PnaWVmvgieRicsO0rddtXGAwVh+XOhX/UwqyEroUf+7wejfIEjNNCsVth7S/IxcerunqKzPw+KDzf6T+9v2ALtJsxV6c/QSVvpkTzZe6Xb/ih+0v6gQPo8QLLEO42DPe3Dq6g3lyu5nih7yKPV5LjKGh1KIMjwGALEeUujxUYV8t72OO8S6xMH1U3IMADSKCtbo/qsksgj0Gl9/QGhlKPIDLNedAuSY0cYjCQmzP08zynvXCpxSLVGJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aNv2pqDUa8rf8kw3Zft7jyvIgfYBQW5dnZnUgpdpN94=;
 b=pFcr3tqxoPlWWAZQ4nHeOTHO5sJqoyPFZUmJvEWadmMn8B/edJ0oNhxyENkijSrFlgWz8Nv4ax18s+LqG3PXa6L1lJpqSoeqTDbtN3AVmKiac8T3VjAYm8JXgid8zcEenYPbFKLJpkOqtsEGlBHguuCJhMH9jZ6Hv0caoBLHNeudTac8nHpLTnK0WOkZ/UhFQ61jprfCTziTA9MR2/tHTpSFB/Pn3BXDoineDTVPRrTMC1iKNv7VYn4uXWMsarrywJsg0Ra2EOFMJ2JT3jJDPz6BmT8PXoxHVtaqLHqU7Wd9OHo4fUIxHTRAWg0JQPV64ilgJR3GAs2iwzGcCoz/oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aNv2pqDUa8rf8kw3Zft7jyvIgfYBQW5dnZnUgpdpN94=;
 b=EOmfiBV7hVrz8mKW5XT9flQiP8Ttb2H9TmEicIQ0PsxVqVDnRhh3o7vHHaxI+cSHIgg7ClvyOy88EORUI0ivHa+LODJdGSvbtw3+LynEGom+xFya/gQdqbrSJC+zCxuT4kQBObDiAAlWkrFcIfFLIFoJW+XgROUkbCb1jBcmK2k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 DS0PR12MB8785.namprd12.prod.outlook.com (2603:10b6:8:14c::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.20; Thu, 17 Oct 2024 16:21:39 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%6]) with mapi id 15.20.8069.018; Thu, 17 Oct 2024
 16:21:38 +0000
Message-ID: <c756f2e4-2fa8-413a-b6b8-2f3ca8ec27a5@amd.com>
Date: Thu, 17 Oct 2024 11:21:36 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/15] cxl/aer/pci: Add CXL PCIe port uncorrectable error
 recovery in AER service driver
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 Terry Bowman <Terry.Bowman@amd.com>
Cc: ming4.li@intel.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, dave@stgolabs.net,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 oohall@gmail.com, Benjamin.Cheatham@amd.com, rrichter@amd.com,
 nathan.fontenot@amd.com, smita.koralahallichannabasappa@amd.com
References: <20241008221657.1130181-1-terry.bowman@amd.com>
 <20241008221657.1130181-8-terry.bowman@amd.com>
 <20241016175426.0000411e@Huawei.com>
 <ac5f05ec-5017-4ac7-b238-b90585e7a5bc@amd.com>
 <20241017144315.0000074c@Huawei.com>
Content-Language: en-US
From: "Bowman, Terry" <kibowman@amd.com>
In-Reply-To: <20241017144315.0000074c@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR01CA0014.prod.exchangelabs.com (2603:10b6:805:b6::27)
 To DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|DS0PR12MB8785:EE_
X-MS-Office365-Filtering-Correlation-Id: 8064d394-f4c9-4d7c-ff1f-08dceec7c711
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWdkbW9NMENmNkdxaU1rRkNTOU1rcmdINlg0UTBPZjlRUW1xUnZHdDlUSk8y?=
 =?utf-8?B?MndCSE5CbE1lV2t0TUluVkFlVklyemdEY2ZoelBNUGNCek5zaGVGRFJrc3c4?=
 =?utf-8?B?WDNYK3I2MDUvK1Job1pXQk1YOGhreTltYTNxdkFCWW5JaEs4cE9UUjBpbjV4?=
 =?utf-8?B?VkxoSHV2bFZBeDI1OVN0TzFZZzBpVCtROFBWWFZtWEpxQ1h6MWkrT2xodG96?=
 =?utf-8?B?d1ljTlU0MCtSQlNXRkZtV1REZEIvTnJRMjFlNjlCWk1qY2k1RkwyY1RkbVBV?=
 =?utf-8?B?bk5ISnNmK2liT21vamNmOGZ5ZzFuTTB2T2cxR3lmWFN2VDA0RDMra3pOM3FL?=
 =?utf-8?B?TWlEeGxEUEdtVnhCSENUL0ZsbnhqOUwzRnY3ZXIrUE94aENvUEtXU2M0ZWJI?=
 =?utf-8?B?cE90ZWJmamVwcFltZG5GYU41MTNjeXRUUDRZSGRsQXZQTnhTM3FtckdBU1Yz?=
 =?utf-8?B?MzNHV2ZvODNnZUEvVVNHMnR6UFlhc1VxVUVEamtQeXdpWXRsSjBsNTk0dXdw?=
 =?utf-8?B?OUNtMnRyU2tQeDdTdmo2c2M2THZqS2tlZVVqRyszbkg1VUlPY05QYThzbUQ2?=
 =?utf-8?B?eXk3YmhUdktHMHhFcUdsL2VIMlZ5WDFBSmxjU2J3L0V2NStQK09lVXBYUEx1?=
 =?utf-8?B?L0RmVDhvQ0ZicXdaeVZpWVBwQ2xvUnpjdnZ2eUtLS3NBazFrVmRSUmxBSWJw?=
 =?utf-8?B?UnFHZnBPWXNqUTM2WEllN2RSdXQvMEh6dTF0dERvR29DMGNyWVlaQmZXeTMw?=
 =?utf-8?B?cWlyVk1oQkxqMk5XTlNjU1RsQlZFNEF4dWhlT08xbWYwaDZYYm9vTkpZYTFH?=
 =?utf-8?B?RTQ0cGE0ODBvYitoU0lCZ29MU2lPQWlEK0pPbDBRdnB6alQvWEF6dEl2NWZB?=
 =?utf-8?B?cTRUbjVTTGJ2S1h0M0FlN0NEamU0OE9YaEhBSGMvR3hnR1ZtWWlEbUM2Uysz?=
 =?utf-8?B?ZytSRFdxZkNFVkNxdW13bk80T0V0VVRFb1VxUHZwY2xnOWRycEpKRFdnMVN6?=
 =?utf-8?B?cTlHUTBNT25CUTVGOHFzd0tWZ2U4Yzg4SitXY1Ftc3l6ZmdUdy9nbXZRVy9L?=
 =?utf-8?B?cGg0ZkRnVlJGMHZpK1hnTUFhdUlMdFF3NHpYVTZuUWxwV0dvTzA0VHFzRVlJ?=
 =?utf-8?B?UmIzV0g5eG00ellOUVlUdVhFS3FlMFVkeGRTd0o1Q3VYTWVwaUdwRWdUcW11?=
 =?utf-8?B?WGtrdVovTWR4anh5c0wyZkt2ZDhCcmdmSGU3bGtEd05qaiswaEFLRWdWOWh2?=
 =?utf-8?B?K2czU082VHNiejREMXpnQndPcG9YSkdSWitRdGVHSmVlRElCeXRYRlY5cklS?=
 =?utf-8?B?c0pBRzhpcUJ6b3E4eU5BT0N2UHg2VWV2YUxtUW9RWGZ4Q2lBdzJvSHFtUXo2?=
 =?utf-8?B?SXBFL0VFWkloc1pXNDl1TVZuN28zSTh5a1dlb29VTFkwWGpPVTIwM0kwL2o5?=
 =?utf-8?B?RGgwR21oaXhHZklkS1k0L0U1SWlLVlQ2VzFpdEVtK2l1VnJkd05lcm4rbXpN?=
 =?utf-8?B?Mit3QUFDYXVxWnVuQmVoU3o5VUNiRkJWWHZZOUpWbko3cSsyaW5XV0xBMWVY?=
 =?utf-8?B?U2VXN0VWL1UwWFRsNGM0QURkS1FTaFFTV0hTZ2o3ekZLdk1rd2RDNVd6bi8r?=
 =?utf-8?B?blc1a0ZoNSt3RExBcnlqZ2lzQTRnVHJRaFNtQTcxeEFIZlBwazVwTVE3NW0r?=
 =?utf-8?B?Q0FFODJSY253dU1hNEtYcUZ5UHpXT2syTTkwWTAxSEU1UDBLYSsrLzdNSUEx?=
 =?utf-8?Q?oKP6qNTT68/975FNn3YZaBiwTWf7pG0C2bKo7dU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UnE3UHJxYzIwdGtGeFcwaWFiWDNHcXpab1pwZEFGT2hIaUdrTGdLZXB3cTdV?=
 =?utf-8?B?dEI4eGJ1dlp0ekdlNDlZd1p5a3ZEVjVMbDd1NE0vcVFqaG1SOVZEZEFLR1F3?=
 =?utf-8?B?UGZnRzV3dnZyMFc4Zk1MZktDdXZCOVkxQjY0b0RrL1FXSzdXMWVxUzh4OStj?=
 =?utf-8?B?NHkvcWtUNlVVSlZWMUZOdlF5Y3dzOGtGeEhjbTRMOER0bk12aUFJRnp2a1N0?=
 =?utf-8?B?MlZzZHZzMVJOOGMyVnV2SjViNzJlQ2d0OFk1M3o1SGtCS1haWFRYTWYwZFR5?=
 =?utf-8?B?RnQ4eWR6M0QveXZTVVJzSG1ldEVnRzZkTW8yZ1JoVlBacjdKSUNiNGpOTDZW?=
 =?utf-8?B?M3pzMGt6Tkt6aWtWK0ZPSlY2R1VvdHV5VTNna2lWNjZDNythNVVQdzBONkN0?=
 =?utf-8?B?ek9kOHlESEZGekpvUzdzc2grRnE2cTE4dkYrV21qU21MT0JBeVRmLzFuaE9y?=
 =?utf-8?B?UU9RRU5vMjNmQlpHd0d0Tlp2ZlU5MmYxVzdHNUVDMFVTRjRHVTEvMGZkSy9I?=
 =?utf-8?B?WFhyTjFtT3czOStqRjVQeHFBTkhiNC9qVExRZlNrSng2Mm9TQkpDOHlVOWdP?=
 =?utf-8?B?bDRNUFNvdjczbVpHTUtJT1QreHdwTXVKWU5pMFczclVNVEhlc3FKRFducWVY?=
 =?utf-8?B?Q0dvaFg1blA0T3ZLOWRNYlJMSTFhRTJjdTA4aEVwdWdVNE53cW4xU2IyRUdj?=
 =?utf-8?B?ZDhNMDc5bFJueEVWc2haa2Y0RWRDdDd6d2krc3pTRzlCWjlHbUR2ak4yWWtO?=
 =?utf-8?B?YVBoaW1idXN0aEphdGdtSGxlbnZONWZ3MnpZR1FGNkRWRG1UeTJoL2ZSY2dE?=
 =?utf-8?B?TFBOanhFZDVrenFDSjkwQ0JJNm0vaXFnR0pJSFVCbjAyNURteHNsQ3JTVHBK?=
 =?utf-8?B?US9ibWxmQnVCMVBTNGpFYmRWb3J2WTVwdDBMMTN3dlVwS0JVTFU4K1VaZXRy?=
 =?utf-8?B?WXRVeUlPNkR2bXhKMjNRUmZFQ3hIdm9qTko0Ym5IN1BNUVhYa3RGaHBOaVFS?=
 =?utf-8?B?UXNyTmtlY2VtV2hlSDNyREpiUFZtQnVrV1V4eUU4VkRlUkQzMWJYR1U3Ny9i?=
 =?utf-8?B?Q1I5ZlF1SGpEZmtIV2FwT1MxUStweEY2Z2svNzlrSEVyNWwyWS9YUE15SFFh?=
 =?utf-8?B?Y0E4dHdoaWoyQVNGVVRBN09YSEJQbHBna1BjT3RVekJQdVdpdDkvcjJtblJX?=
 =?utf-8?B?am5XZWxQbllRQWtNVHVHcUQzZml3bVZWbkRJUG55NGY2MThwMjVsNnh0NGRL?=
 =?utf-8?B?UE9pZ01PWUhkNjlCWTFkblpVckF3NDdQS2ZIQUlVaFZGa1RHQ3NYTVlPMlMv?=
 =?utf-8?B?Wld6WWt6REZHeU0yV3BFeG9UN1Evay92aFJDQjRBaDB1UWxhc2RDMDRNcXor?=
 =?utf-8?B?YXRZdGprQUg3b3Y1Zm5kb2ZEUjR6c0hpSTQvYzRXMGxSSEtKWjdwcFArYzFG?=
 =?utf-8?B?MkNvL1cxKzJsSkpDeHF2Z0M5S2NqWUowSTkxK2VDMGhVL2tFQTRqOHhZakNZ?=
 =?utf-8?B?cU9Xcm5xTDdNNWpsNGI4M2l2U2MyRU1jWTdYaFZkSExxelBFQ1NQV3lNY05v?=
 =?utf-8?B?UGxZZjRBVlBqb2ZPKzQ1bWJ4cGErYWJsVndNNzlEL2NPRFpUWXoxMU9lR1lM?=
 =?utf-8?B?TFBXOEE2bVRDZXZydXZVY2lTYmdjSjFmMDF0UWtHcnkzalZHVVNVSUZCa3ZP?=
 =?utf-8?B?M0lTamlnNnNtTHVuc3luSi9CbG95SUxCemppZ2J3TWRQdGJGVytFaGVOSWtH?=
 =?utf-8?B?YWhvRGIvaHd6Zk5mSVlhUVNrUGFENFVqcXQ0WVRkMHFjTlRzWkZTV0dVWFpI?=
 =?utf-8?B?SVZhTDNzM3pEeVFWbm5KSSt5S1lCMGdVajg1TWlrWWE5N00vV0R6VmQ5cktS?=
 =?utf-8?B?bkFOZXN6dTFCdEt5emFvUHZFRm5CbzVVaGhSWGVuanB4ZW9GM005OWdTYkVw?=
 =?utf-8?B?bDE5bldCS2lMbHVERUE5cXY3UmF3S21mU3lYMlpnZ2xzTWNoMDJsa1AvSkJ4?=
 =?utf-8?B?V0d4ZXdRTTZKdjByS09sZTRQMGFWcEk0dDJYM1dXRk1iejVEekQybTNtRC9z?=
 =?utf-8?B?N09SbEczZFZUbzhVRWQwbnBMOUYzOWFHZjNpYzhhRU5UOGtWNnIxQUo5RzZQ?=
 =?utf-8?Q?fz6W5oTWTV/pnFBaEQPnKWQMg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8064d394-f4c9-4d7c-ff1f-08dceec7c711
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:21:38.7829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sk6CT7eQmvfR64+AfZBYAMevf96Y6GqjhHxKYrInuxxntRLzTCOLcyiPMQwnp1RR+37quup2lUDpN4v27QA5rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8785

Hi Jonathan,

On 10/17/2024 8:43 AM, Jonathan Cameron wrote:
> On Wed, 16 Oct 2024 13:07:37 -0500
> Terry Bowman <Terry.Bowman@amd.com> wrote:
> 
>> Hi Jonathan,
>>
>> On 10/16/24 11:54, Jonathan Cameron wrote:
>>> On Tue, 8 Oct 2024 17:16:49 -0500
>>> Terry Bowman <terry.bowman@amd.com> wrote:
>>>    
>>>> The current pcie_do_recovery() handles device recovery as result of
>>>> uncorrectable errors (UCE). But, CXL port devices require unique
>>>> recovery handling.
>>>>
>>>> Create a cxl_do_recovery() function parallel to pcie_do_recovery(). Add CXL
>>>> specific handling to the new recovery function.
>>>>
>>>> The CXL port UCE recovery must invoke the AER service driver's CXL port
>>>> UCE callback. This is different than the standard pcie_do_recovery()
>>>> recovery that calls the pci_driver::err_handler UCE handler instead.
>>>>
>>>> Treat all CXL PCIe port UCE errors as fatal and call kernel panic to
>>>> "recover" the error. A panic is called instead of attempting recovery
>>>> to avoid potential system corruption.
>>>>
>>>> The uncorrectable support added here will be used to complete CXL PCIe
>>>> port error handling in the future.
>>>>
>>>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>>>
>>> Hi Terry,
>>>
>>> I'm a little bothered by the subtle difference in the bus walks
>>> in here vs the existing cases. If we need them, comments needed
>>> to explain why.
>>>    
>>
>> Yes, I will add more details in the commit message about "why".
>> I added explanation following your below comment.
>>
>>> If we are going to have separate handling, see if you can share
>>> a lot more of the code by factoring out common functions for
>>> the pci and cxl handling with callbacks to handle the differences.
>>>    
>>
>> Dan requested separate paths for the PCIe and CXL recovery. The intent,
>> as I understand, is to isolate the handling of PCIe and CXL protocol
>> errors. This is to create 2 different classes of protocol errors.
> Function call chain wise I'm reasonably convinced that might be a good
> idea.  But not code wise if it means we end up with more hard to review
> code.
> 
>>
>>> I've managed to get my head around this code a few times in the past
>>> (I think!) and really don't fancy having two subtle variants to
>>> consider next time we get a bug :( The RC_EC additions hurt my head.
>>>
>>> Jonathan
>>
>> Right, the UCE recovery logic is not straightforward. The code can  be
>> refactored to take advantage of reuse. I'm interested in your thoughts
>> after I have provided some responses here.
>>
>>>    
>>>>   static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
>>>> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
>>>> index 31090770fffc..de12f2eb19ef 100644
>>>> --- a/drivers/pci/pcie/err.c
>>>> +++ b/drivers/pci/pcie/err.c
>>>> @@ -86,6 +86,63 @@ static int report_error_detected(struct pci_dev *dev,
>>>>   	return 0;
>>>>   }
>>>>   
>>>> +static int cxl_report_error_detected(struct pci_dev *dev,
>>>> +				     pci_channel_state_t state,
>>>> +				     enum pci_ers_result *result)
>>>> +{
>>>> +	struct cxl_port_err_hndlrs *cxl_port_hndlrs;
>>>> +	struct pci_driver *pdrv;
>>>> +	pci_ers_result_t vote;
>>>> +
>>>> +	device_lock(&dev->dev);
>>>> +	cxl_port_hndlrs = find_cxl_port_hndlrs();
>>>
>>> Can we refactor to have a common function under this and report_error_detected()?
>>>    
>>
>> Sure, this can be refactored.
>>
>> The difference between cxl_report_error_detected() and report_error_detected() is the
>> handlers that are called.
>>
>> cxl_report_error_detected() calls the CXL driver's registered port error handler.
>>
>> report_error_recovery() calls the pcie_dev::err_handlers.
>>
>> Let me know if I should refactor for common code here?
> 
> It certainly makes sense to do that somewhere in here.  Just have light
> wrappers that provide callbacks so the bulk of the code is shared.
> 

Ok, Ill start on that. I have a v2 ready to-go without the reuse changes.
You want me to wait on sending v2 till it has reuse refactoring?

>>
>>
>>>> +	pdrv = dev->driver;
>>>> +	if (pci_dev_is_disconnected(dev)) {
>>>> +		vote = PCI_ERS_RESULT_DISCONNECT;
>>>> +	} else if (!pci_dev_set_io_state(dev, state)) {
>>>> +		pci_info(dev, "can't recover (state transition %u -> %u invalid)\n",
>>>> +			dev->error_state, state);
>>>> +		vote = PCI_ERS_RESULT_NONE;
>>>> +	} else if (!cxl_port_hndlrs || !cxl_port_hndlrs->error_detected) {
>>>> +		if (dev->hdr_type != PCI_HEADER_TYPE_BRIDGE) {
>>>> +			vote = PCI_ERS_RESULT_NO_AER_DRIVER;
>>>> +			pci_info(dev, "can't recover (no error_detected callback)\n");
>>>> +		} else {
>>>> +			vote = PCI_ERS_RESULT_NONE;
>>>> +		}
>>>> +	} else {
>>>> +		vote = cxl_port_hndlrs->error_detected(dev, state);
>>>> +	}
>>>> +	pci_uevent_ers(dev, vote);
>>>> +	*result = merge_result(*result, vote);
>>>> +	device_unlock(&dev->dev);
>>>> +	return 0;
>>>> +}
>>>    
>>>>   static int pci_pm_runtime_get_sync(struct pci_dev *pdev, void *data)
>>>>   {
>>>>   	pm_runtime_get_sync(&pdev->dev);
>>>> @@ -188,6 +245,28 @@ static void pci_walk_bridge(struct pci_dev *bridge,
>>>>   		cb(bridge, userdata);
>>>>   }
>>>>   
>>>> +/**
>>>> + * cxl_walk_bridge - walk bridges potentially AER affected
>>>> + * @bridge:	bridge which may be a Port, an RCEC, or an RCiEP
>>>> + * @cb:		callback to be called for each device found
>>>> + * @userdata:	arbitrary pointer to be passed to callback
>>>> + *
>>>> + * If the device provided is a bridge, walk the subordinate bus, including
>>>> + * the device itself and any bridged devices on buses under this bus.  Call
>>>> + * the provided callback on each device found.
>>>> + *
>>>> + * If the device provided has no subordinate bus, e.g., an RCEC or RCiEP,
>>>> + * call the callback on the device itself.
>>> only call the callback on the device itself.
>>>
>>> (as you call it as stated above either way).
>>>    
>>
>> Thanks. I will update the function header to include "only".
>>
>>>> + */
>>>> +static void cxl_walk_bridge(struct pci_dev *bridge,
>>>> +			    int (*cb)(struct pci_dev *, void *),
>>>> +			    void *userdata)
>>>> +{
>>>> +	cb(bridge, userdata);
>>>> +	if (bridge->subordinate)
>>>> +		pci_walk_bus(bridge->subordinate, cb, userdata);
>>> The difference between this and pci_walk_bridge() is subtle and
>>> I'd like to avoid having both if we can.
>>>    
>>
>> The cxl_walk_bridge() was added because pci_walk_bridge() does not report
>> CXL errors as needed. If the erroring device is a bridge then pci_walk_bridge()
>> does not call report_error_detected() for the root port itself. If the bridge
>> is a CXL root port then the CXL port error handler is not called. This has 2
>> problems: 1. Error logging is not provided, 2. A result vote is not provided
>> by the root port's CXL port handler.
> 
> So what happens for PCIe errors on the root port?  How are they reported?
> What I'm failing to understand is why these should be different.
> Maybe there is something missing on the PCIe side though!
> That code plays a game with what bridge and I thought that was there to handle
> this case.
> 

PCIe errors (not CXL errors) on a root port will be processed as they are today.

An AER error is treated as a CXL error if *all* of the following are met:
- The AER error is not an internal error
    - Check is in AER's is_internal_error(info) function.
- The device is not a CXL device
    - Check is in AER's handles_cxl_errors() function.

Root port device PCIe error processing will not call the the pci_dev::err_handlers::error_detected().
because of the walk_bridge() implementation. The result vote to direct handling
is determined by downstream devices. This has probably been Ok until now because ports have been
fairly vanilla and standard until CXL.


>>
>>>> +}
>>>> +
>>>>   pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>>>>   		pci_channel_state_t state,
>>>>   		pci_ers_result_t (*reset_subordinates)(struct pci_dev *pdev))
>>>> @@ -276,3 +355,74 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>>>>   
>>>>   	return status;
>>>>   }
>>>> +
>>>> +pci_ers_result_t cxl_do_recovery(struct pci_dev *bridge,
>>>> +				 pci_channel_state_t state,
>>>> +				 pci_ers_result_t (*reset_subordinates)(struct pci_dev *pdev))
>>>> +{
>>>> +	struct pci_host_bridge *host = pci_find_host_bridge(bridge->bus);
>>>> +	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
>>>> +	int type = pci_pcie_type(bridge);
>>>> +
>>>> +	if ((type != PCI_EXP_TYPE_ROOT_PORT) &&
>>>> +	    (type != PCI_EXP_TYPE_RC_EC) &&
>>>> +	    (type != PCI_EXP_TYPE_DOWNSTREAM) &&
>>>> +	    (type != PCI_EXP_TYPE_UPSTREAM)) {
>>>> +		pci_dbg(bridge, "Unsupported device type (%x)\n", type);
>>>> +		return status;
>>>> +	}
>>>> +
>>>
>>> Would similar trick to in pcie_do_recovery work here for the upstream
>>> and downstream ports use pci_upstream_bridge() and for the others pass the dev into
>>> pci_walk_bridge()?
>>>    
>>
>> Yes, that would be a good starting point to begin reuse refactoring.
>> I'm interested in getting yours and others feedback on the separation of the
>> PCI and CXL protocol errors and how much separation is or not needed.
> 
> Separation may make sense (I'm still thinking about it) for separate passes
> through the topology and separate callbacks / handling when an error is seen.
> What I don't want to see is two horribly complex separate walking codes if
> we can possibly avoid it.  Long term to me that just means two sets of bugs
> and problem corners instead of one.
> 
> Jonathan
> 

I understand. I will look to make changes here for reuse.

Regards,
Terry


