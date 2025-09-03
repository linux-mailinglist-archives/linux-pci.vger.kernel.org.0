Return-Path: <linux-pci+bounces-35349-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF9BB41244
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 04:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 701F51B24D36
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 02:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A414A1339A4;
	Wed,  3 Sep 2025 02:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="x8QvDU9k"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8332AF00
	for <linux-pci@vger.kernel.org>; Wed,  3 Sep 2025 02:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756865875; cv=fail; b=p38CvQ0xwSrozuoFMgo2RJmxQS75mxNbGhuHlFCSd1bxrGF85sHCEKemBlVTPoifb/my+PPXoSQCt+RZ4ODNpHW1IQIL9ERDHYGqADlsCxNKuG9RZMLjVrlcQ/7+NvQYv8OyLxfaVFUeEnGp0qCnkrez639/9vUKu7rRvkSoEvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756865875; c=relaxed/simple;
	bh=UqYWaYKbuVu2wL99C2sCKCQPTnl3vZ7OxciV244GKHE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XyWqNKSsUOoLuPgPPkWrAcAeEpeVWJIeNPjBCAQ5qUMNSy7Ohkl+IQdTp/hAvRjiIl1wqEhWtoaJAxNHAlUq6WPG70jhAg5m1bQuCJXj6k8qmBqOhXlRpFzgPdI6Cl+Ei0glFQPvTwxrJfBKzYo69rtQ+QnrbJ95MfQye6vys/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=x8QvDU9k; arc=fail smtp.client-ip=40.107.93.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aD3bBFM8rstPfnBAe+3Qfn30BtjWNXkWGidp9BjDRvjn9vLhHGxeCxPPoqXKPCH1ArAJodvXrxEDyNjTjJIm+aNDctJyQsxeG1abLfeNWSpeNLaYsg7oQDxZtss+GjCj2lobNklYFMjmNy+lfIFku25Xbr6W4zmtV/+j/jVCISEFnH76ZEDmmnskiG5UzgO0nyflSZa0q6Iqu/erb9fsLD21lAMVx8THKowuMBQHzxUoK2gVvyzXCSUXM9wD5s/lBYIrmYzunESHsZeMjlrt5qJtKoGySZad4ce75VT8rSPJq0A74lD9/mY32AEuuiRuSDiD4svyGXJd4WNVPtIqog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yP9uK4kj+osH5k2BmMuFWxJ8c27fGqjuwsbnWyZvwKk=;
 b=GAXT0siyxmJ8QgWD9tLeDnnmyeNActpP/PkpCS722Gl1UzfgX/9YAQ8WLzaF4M18Yw8hpQAnr6UHOZcm2HsThY4Ogr2N0mzswXyc3bI/OOdvhWgcEVbuT2pr9VapwqtkHSx0rEH4RIAmV2z/onPUcKKhlmAcKDL/DfnqF8TWJYkl7hpruTmDTRY1bHLNfy1u+PRv86vsWcRQWOSSIEHcP4e7W9OyrR45i+G2fUh3TLb+hQR5yk53n2rzpERU5/Pm8ZiwWFXPl8hoBfgy4eWN2LypRiaUsTnREkbJ9Vd8wcG+u0oWPMTH91YuDfM4bhqALLTWN/E10St01tU6l+zgZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yP9uK4kj+osH5k2BmMuFWxJ8c27fGqjuwsbnWyZvwKk=;
 b=x8QvDU9kZdooBfiPrVLsXmjOSbqiKmK3np07RJOPhY5OqAPQzAiH+yu1x+IiMBsjla1ei3895TsgWUEOwzYjTYJhiJqm/fdIGr9ZcbGdGlcAe15juipcoPFnt87GSONMrF6OmAG16GaK9HjndB2ra4eMf4L1QiO4cpcCKEGCTlE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by SA1PR12MB8965.namprd12.prod.outlook.com (2603:10b6:806:38d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 02:17:51 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.9094.015; Wed, 3 Sep 2025
 02:17:51 +0000
Message-ID: <ae564552-e0e8-4d97-9578-d19871697ca5@amd.com>
Date: Wed, 3 Sep 2025 12:17:45 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v5 04/10] PCI/TSM: Authenticate devices via platform TSM
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org
Cc: yilun.xu@linux.intel.com, aneesh.kumar@kernel.org,
 gregkh@linuxfoundation.org, Lukas Wunner <lukas@wunner.de>,
 Samuel Ortiz <sameo@rivosinc.com>, Bjorn Helgaas <bhelgaas@google.com>
References: <20250827035126.1356683-1-dan.j.williams@intel.com>
 <20250827035126.1356683-5-dan.j.williams@intel.com>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <20250827035126.1356683-5-dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5P282CA0186.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:249::9) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|SA1PR12MB8965:EE_
X-MS-Office365-Filtering-Correlation-Id: af0b5f5c-6f02-4741-8dcc-08ddea901573
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OVRxSnoyc055NGpoUU1veTdDSjN0eDd3UUlDT2pGbTY4L1R0cWp5MWVKQnVV?=
 =?utf-8?B?TktjSU13VjBuc1VPb0YwbHZEQmFiUWJyd25pSW9lbTM4WlJ3Z3lGUXNEekQ3?=
 =?utf-8?B?WjlyTHhnNkVKeHE0em9mbFJRSGVsSVFYNndvWGRhNm5rQ1JrcFoyelNtM240?=
 =?utf-8?B?aFhXblU3MFY2ejRSOTFPZWdIbU1pMkdDcFZWTTcvWVhvQzNvQWwrUWszYjZL?=
 =?utf-8?B?cmkvUzZkRzhJT0JoclZJcnllL0RPVUxQakVvSDJJLzdXQ3RZWlVuU25Pc2Jx?=
 =?utf-8?B?R05MU1RzYkgwb29NV0tDUlRyVzJGU3JZTXl4enhjeVBOZVpqL3FvS2JhMWRC?=
 =?utf-8?B?cnNHT29aNEYrRG9pWTJhTGxEMS9sSmptQXJaMWtJQnNhY0NReUx3NEI5YjdC?=
 =?utf-8?B?WmZzcDBQV3k2clRFZEQxVk1SUXRTU3BpRXNFdmZaTmwyM0hiVGt1bnhXSVA1?=
 =?utf-8?B?QStqZ2tIMGxSZjFrRWdtMW5sb3lxRE0yTWk2eFdxY0Rwc28vUC85djd1cWx3?=
 =?utf-8?B?MXI1dTl1ZEJkVUhuMEkycE9yOVc3TnErL252OXA5ZzdGWDg0MjZNTmxBRVlq?=
 =?utf-8?B?bi9FOTJEMS9xaWNyTkVIbXZ5ME1PeG1RM2syWXNWTGFEeEx4NUYxN3lnaVkw?=
 =?utf-8?B?dUJ5aE5LSndCaHdQSHoyKzFWZnJWVDhOMklkaHdGYUt2OEFSS2lYbWdEcEw4?=
 =?utf-8?B?R0M4TytXNEozUlV2cmNra1hUS3pocTJLeVB1cnh3cVdqZ3B1K3ZDeXdYNEt3?=
 =?utf-8?B?WjVWZ3BvVVVwUmNKdEpuL2gyV2F6NGw5RnFYbU9TVnRjOFdURWJtdktVMWUz?=
 =?utf-8?B?WWtUQWVOL2NoVW9LTkpOdEpFc01pWmZqbDdMdGpzOXBDMW9icVFnL2pHUmoz?=
 =?utf-8?B?ODRFMUowK0VVZm40dm05dVNSVDlGZmxJN1hVMXNBTlJtN01ZSExuaG8zend6?=
 =?utf-8?B?OGZNSm5lejg5M2VYWStmRHF4ZzdacUhweGtEdXo1NklmL1RCajc5WlMyU0RX?=
 =?utf-8?B?TFltazc4WC96REhRZ3NZbHJoQTFmZlpOOVkxajI3S21tMnVSZ2hWcmNsK2ZU?=
 =?utf-8?B?dkM1VGpneTc5MkczdWg0emFDQzNRSzRObVpzSHVuWUcrdWJNK284UUpYTVc3?=
 =?utf-8?B?QUVQa3RnZkNDblFIalVndGtEZmFhSG9EV1R5QlJldTlYMU9WSUpaV1prdXNU?=
 =?utf-8?B?YzNBaS9hMThXNUlqV0ZTbUVHUjF6dlpucENtSnF1cmpPc0N5RVRaeEJwMHpX?=
 =?utf-8?B?d1pXcUV6T3o5RUorcGZza05hblVhR2RwKy8vWE1uT1VVeXlMYStqVm5IRjRD?=
 =?utf-8?B?bkplWXhjOHpkV0JMVklKTEVvUjhZd2ZQNmF3Wkk1T0pDUzMwR0Q5L3hyZHJW?=
 =?utf-8?B?VHJWOEdNYkdCVmEyM25lUnM1aDM3M3pXbXJPUXh3WUJJd0dld08zQVdZMUxB?=
 =?utf-8?B?QmlEbTVGVDNNdWE0cCtldjBGQWRVRStNKzFVK0I1MHJSWUg4N2x6SUFyZDlw?=
 =?utf-8?B?SncrU21rV045YkltRTVXRi9uaDdzM294cEFCQlVqQVdFSzhBWHQvN2w0RGhZ?=
 =?utf-8?B?aFdDY0ZOU2dVR2Q1L3RaWXlZN1p5TDhxYnhDYXVsOWZDdGRqS2c0NXR0SkdU?=
 =?utf-8?B?dlNvUC93MTBnQWp6NW5XMnFqUndZT2FJckRSSEZDNVpjdzJ2UnBrbkt1TXNn?=
 =?utf-8?B?aitKZ2R6dTFOOFdSUWIwL3c2dVZDVHRucjVraVRVMXJuUGtYYXpwQTNGWEky?=
 =?utf-8?B?TzBwNVhUS1JLQXNyZzRRaXNPamVCWUZaSFVTTWY1NzZBanM1TjcxOERGeUtG?=
 =?utf-8?B?RS9vNE1kYmhYcW4zZmJsTWVtQ0RGRDZLNXRJdkF0a3BSbFdkQ0tjYTFmQ1h4?=
 =?utf-8?B?N3k2WFJaaWJ3UGlVUjFXYjFDbCs2YktkTFB5UVJwamlPSmE4TTJJVzErZnlw?=
 =?utf-8?Q?hBvB4L3frf0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzRzMC8zUk1ZeVFHUC9MR2t4VmRNVjI4b1gvc2RIeDJ2czlSVEVjQXYwRlRO?=
 =?utf-8?B?YnVadlAvWmtkbHYyQzBwTWE5ekhXMnA2dURFUEVyTk5Sb2hsVVMrdWFqY2x0?=
 =?utf-8?B?M0NNaXpjOExDcDAwazVpeUFBWGd6cjJlZkdvVmsyUThmNVRhaW56NjNqclQw?=
 =?utf-8?B?SnphTWJiOWVFQ0M1UXgrRDMwYnZlb2hVVWhNYmpYSElVdmwreEt4MDJ2K3NX?=
 =?utf-8?B?SEJ1YlloQ04zazY4Ky90Z1l2cXYxNENaaEU4NXg5MVlNczJqd3FGUFhSdFl0?=
 =?utf-8?B?cEdha1phZ1hyWXhTMGVVMjZhYzU5TWMyeS9FcEtJMEJDSFY0VHdBUUNYcS9U?=
 =?utf-8?B?ZU9yMDhOVERTWTlZcUc4V3dUa3dZcWxIRzRFeVdmZXpBRXQ2ZVhaKzd3Mk9E?=
 =?utf-8?B?bGN2dHRnTUkyNElHRmdYUzc3UnNvR0cyOE9XU2l5ald0Q05WelZsZzEzQnIv?=
 =?utf-8?B?bmowZTFvZGsybjVwdldhbElFdDF2dlJVQlB1N25KTTVTODBYNmdMOWwzUER1?=
 =?utf-8?B?OVhDbTkrUTVzUEhiM0svb0F1bE9sanQ3M2VkVTZ6UFFhWTR2M1QvUW1nczhK?=
 =?utf-8?B?MVJrNFo4enFDSlJoNWxlMWpJY0psd3d0UTI4aTJPUUhkZWtyT0RMeWZzRDVM?=
 =?utf-8?B?YldmRVJMSmxpdkhlOHhtOUFVWTgxOW9obmE5ZU90YlRkazFZaXN0T3VaV1pF?=
 =?utf-8?B?LzY5Y0xSQ0VjckY3dWtKOVpTNmorWmpleVZxQTNuSFFNbEdWNmpVak9uU0dK?=
 =?utf-8?B?b2Q5aXUyOUZTKzFnR1hmWWNuaE05NDZGRC96TlBpN2hXaGVaMlR0ZXJnN01Q?=
 =?utf-8?B?NDUrdUdtSVJrVnZUU2xxNnBPQk5KQUR3UkRSOEF5a3UzQWNVdjlBUGVkWjdG?=
 =?utf-8?B?c2o4S0VjTXZNNzY2WkthMnFSVmVPYzBIc2MxakI0ZU9KRmJJbG9uYkswVmxl?=
 =?utf-8?B?R1RvekV5MlVTbnNBbmlLNS9xa3BtQjNaeFlIQnhQVXFSTG1NaVg4U1V5LzZN?=
 =?utf-8?B?U0Z4QVhaeTcxNmhIV1l3VHNYMnRqQ0VUYVpyMVRkTURMR0VtUm5BY1lkZDFw?=
 =?utf-8?B?V0c3cWVHRHQwRnpkdFRqRmpFbmIrN3RnR2ZXRWtDMEpFallNLytOUnJMSURv?=
 =?utf-8?B?ampjd1ZtaFpkYXZPRmgvR1A3SytsSzdJeWdaZTE3dHVIdEhrWm41cFdmMDUy?=
 =?utf-8?B?Nm1aaTJuaFFjRFVXeXNvUVhzM3NDQnRKZk53WUErOHF6RlBkYUQwNm5PNys1?=
 =?utf-8?B?WFdublNBRnJ6NXZVYmlFODV1S04xbW54VnorUXhHM0J6aXNWZk9zbytZUzN1?=
 =?utf-8?B?Q1YySWdLdVFwR0lCQ2lBajBmOExkMHFrWVlqTlBhU25uREUvVkhkRUpPckYy?=
 =?utf-8?B?c2hRNTRWZE1HNlMxekgwRncweHFOTzJJQ2t3T3Y0ajc0WGJNc3paRUtCT3Zn?=
 =?utf-8?B?SVVFSVFiWWJ5dm50ejRwenJLeXJDTTZ3Z1pDbmZrQ0M3ZnpzcE1HT1RCYS8y?=
 =?utf-8?B?bUtYUnJjNDdLRkxTUkJiVWk1bFpNNDIwMGp5MkFNWWRLS2k4emdLNTdsM3kv?=
 =?utf-8?B?VnI2T0hpM1JTYyt1ZitLalBOQnBKNEJaQldteGdiNDZ5MjIxTVdnZVdIYkQv?=
 =?utf-8?B?YUxWSHdVR29rVzJWRlVOOUMwSDkyNjUrQTgweTRMbUp2ZXNzM29IdWdubVJu?=
 =?utf-8?B?ZWRxS3JxSEVCRlN2dmVEZ0FiTER0dmJCUmJjY3ZTVHBRWjcvODRiVENpMTc1?=
 =?utf-8?B?SytQYWtoVGxXWTVMQlArMkNUaTMxdndxcnZyQUF5TmFZdnRRZEVBQ1hKT0lU?=
 =?utf-8?B?cGlxc2E1eldXdjVRZWxsbHNFU01DZ241bEhmUC83bzMvNmxKTGZ4bUt0SElP?=
 =?utf-8?B?TTZXNm8vR0FiZWR1MThwL25ZZ2dHeFVNZmEyNE1Ka3Y3MHBHYitCL09JSXhZ?=
 =?utf-8?B?OC9nK09FckdUd2dNR1RQOER0cmNOVXZ5akZYVHJ5Ny9Lc0ovN0FUUGo0ODJH?=
 =?utf-8?B?cFg0TmU1QkljV2xnQTEyTEthb0tpU3JtTUowQzk2ZWFFeVJVZmVDWEdYVWZh?=
 =?utf-8?B?UHYwcnVWY29UMUxKRU4rd1Y5MDVUdmlPK1J1V0YxNjF3eDdWSW50RTZqV3ky?=
 =?utf-8?Q?3A+uglYMEE1JseqKqOugQdKEb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af0b5f5c-6f02-4741-8dcc-08ddea901573
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 02:17:51.5871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CBAzlHf/ySSQRe3I8lTX/7T6DLKYIP+mypO+AvQ3n/uOuUuNCYoGmQRIsV1aBTvwB21lEnoKPYQy0Tuh05WN9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8965


On 27/8/25 13:51, Dan Williams wrote:

[...]

> +static int pci_tsm_connect(struct pci_dev *pdev, struct tsm_dev *tsm_dev)
> +{
> +	int rc;
> +	struct pci_tsm_pf0 *tsm_pf0;
> +	const struct pci_tsm_ops *ops = tsm_pci_ops(tsm_dev);
> +	struct pci_tsm *pci_tsm __free(tsm_remove) = ops->probe(pdev);
> +
> +	/* connect()  mutually exclusive with subfunction pci_tsm_init() */
> +	lockdep_assert_held_write(&pci_tsm_rwsem);
> +
> +	if (!pci_tsm)
> +		return -ENXIO;
> +
> +	pdev->tsm = pci_tsm;
> +	tsm_pf0 = to_pci_tsm_pf0(pdev->tsm);
> +
> +	/* mutex_intr assumes connect() is always sysfs/user driven */
> +	ACQUIRE(mutex_intr, lock)(&tsm_pf0->lock);
> +	if ((rc = ACQUIRE_ERR(mutex_intr, &lock)))
> +		return rc;
> +
> +	rc = ops->connect(pdev);
> +	if (rc)
> +		return rc;
> +
> +	pdev->tsm = no_free_ptr(pci_tsm);
> +
> +	/*
> +	 * Now that the DSM is established, probe() all the potential
> +	 * dependent functions. Failure to probe a function is not fatal
> +	 * to connect(), it just disables subsequent security operations
> +	 * for that function.
> +	 */
> +	pci_tsm_walk_fns(pdev, probe_fn, pdev);
> +	return 0;
> +}
> +
> +static ssize_t connect_show(struct device *dev, struct device_attribute *attr,
> +			    char *buf)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	int rc;
> +
> +	ACQUIRE(rwsem_read_intr, lock)(&pci_tsm_rwsem);
> +	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &lock)))
> +		return rc;
> +
> +	if (!pdev->tsm)
> +		return sysfs_emit(buf, "\n");
> +
> +	return sysfs_emit(buf, "%s\n", tsm_name(pdev->tsm->ops->owner));
> +}
> +
> +/* Is @tsm_dev managing physical link / session properties... */
> +static bool is_link_tsm(struct tsm_dev *tsm_dev)
> +{
> +	const struct pci_tsm_ops *ops = tsm_pci_ops(tsm_dev);
> +
> +	return ops && ops->link_ops.probe;
> +}
> +
> +/* ...or is @tsm_dev managing device security state ? */
> +static bool is_devsec_tsm(struct tsm_dev *tsm_dev)
> +{
> +	const struct pci_tsm_ops *ops = tsm_pci_ops(tsm_dev);
> +
> +	return ops && ops->devsec_ops.lock;
> +}
> +
> +static ssize_t connect_store(struct device *dev, struct device_attribute *attr,
> +			     const char *buf, size_t len)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct tsm_dev *tsm_dev;
> +	int rc, id;
> +
> +	rc = sscanf(buf, "tsm%d\n", &id);
> +	if (rc != 1)
> +		return -EINVAL;
> +
> +	ACQUIRE(rwsem_write_kill, lock)(&pci_tsm_rwsem);
> +	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &lock)))
> +		return rc;
> +
> +	if (pdev->tsm)
> +		return -EBUSY;


In one of my previous RFC, I had an IDE key refresh call and it's been suggested [1] to ditch that and use connect() instead and the clause above prevents it. I am hacking something around this anyway (need to validate the PSP support for it) and may be this may be generalized now rather than later. Thanks,


[1] https://lore.kernel.org/r/66d7a10a4d621_3975294ac@dwillia2-xfh.jf.intel.com.notmuch

> +
> +	tsm_dev = find_tsm_dev(id);
> +	if (!is_link_tsm(tsm_dev))
> +		return -ENXIO;
> +
> +	rc = pci_tsm_connect(pdev, tsm_dev);
> +	if (rc)
> +		return rc;
> +	return len;
> +}
> +static DEVICE_ATTR_RW(connect);
> +


-- 
Alexey


