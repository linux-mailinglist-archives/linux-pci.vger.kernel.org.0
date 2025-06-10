Return-Path: <linux-pci+bounces-29276-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A50AD2CDE
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 06:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96DE67A7AF6
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 04:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DCE20FAB9;
	Tue, 10 Jun 2025 04:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sr+7qzJm"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDF11DE88C
	for <linux-pci@vger.kernel.org>; Tue, 10 Jun 2025 04:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749530861; cv=fail; b=IXe5q+rWIPCnyLO3WBvlQI1c5AHLxOm9OVaE1CMzbdw5GI3QA9VAVxK0xfvloHQsbxI5cbsuILm0xoytmgVcaW8WppUPQmBmEbbR/+/qJ2H7ekaWoJLEtZIEEYKvu6phVah+dM7mCiQieLxA378OngB/Zx/PonJ4Dc5PZV9Cncs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749530861; c=relaxed/simple;
	bh=dm903k1n/uGalWXhGNJVy2pEZ8iDc2HrAmFKmE+n/gs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p3I7AN4IT0o8B0BctO6lIMdc4wC6pVUJlEQYlyJGXxFWqyV0+aeiB/LTqajv7hkXMxVQSx/78ivXwtVSWuIcP65FGJNO2cs/qhhtQecSDyIpanxZnFxgmaJIdPRTpiSogMkSXla3VsqTjvRjzJ/3whLseQLuBOeAY9ME1def4I4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sr+7qzJm; arc=fail smtp.client-ip=40.107.244.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gu046j2PR5XEas/UKCNexjPrkyOtTEjhROhVVVj4ALYuNrHrrztfHtOeNWwYvyQIvNUOHqF1+LfUSg9DM84jaukYRBayR5crLRvruUTgd9N1Jm45EN0n04oRZKBuWYrmSgxj1w48iL7IqLge3PfoVbI0QScBN0JxZSULBMUa2BTSQ0ev5MbFM3ravWKs2N64TyrL73bUhd9bpwd4Dc+o5eUX6bTyxsgQ6HhWeILF+yADVIg2UUV2fpaPSqvuLIceCWIfDGDdQOnNLCJQSClb9OdJrYt8reHf8mPCMXqZVBHBXsxFLZh57/7ZAbiLZeBCVcWGPS9lGthkdLEV32EfCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wMysf0go4cNqWVjPeaSbhMRgvp7x/3UAu/qUVshAn70=;
 b=K/ULchdhsciJHaGDh9K10w2GZkhvJBQ2mn5LBrfFUnib/AXDsViNnkhnB7CpthEkovvumA10jFy3ACeOZ70u/OrGJ8ImQn++7/SqWqHUwfOMTS6rxEejw15CX68QXuuAFMl1gF9sJkXI+JaKbNwzYJLD44ldThN/8847NZ3TN4el9oEmwBq7pP54D2Fe6z54dMRiiQA10hRp7Lpqw473wYOJZq8GD9FRljeXpED/w9Xxcz1EmBUEvSFG5+2WOZcPnTrdA8Dkc6TrxSmmxZWG8jmdNnEws8ucYkOqDyVogMCRu7GUpWgqoy+5DPk8GlE8w578GijtYIwDarsgDWvTLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMysf0go4cNqWVjPeaSbhMRgvp7x/3UAu/qUVshAn70=;
 b=sr+7qzJmY5fuqw9RwxEz40OZjGLX113OD+0+qLeAbVU1gA5A4TGb6wPA9vEIF0j2FoGfpYPeRtdPFs7BJ0Y6FYINzf8Z5R2jIOlbGUdw4Q59cm7JWXesQza1G9eybLewCAOJ9zYuPhfPqRp4Bsk4WLfjQrwG5/sB+rHX3aQGFM4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by CY8PR12MB7196.namprd12.prod.outlook.com (2603:10b6:930:58::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.42; Tue, 10 Jun
 2025 04:47:38 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.8792.038; Tue, 10 Jun 2025
 04:47:38 +0000
Message-ID: <efd630b0-d08d-46a6-a5ef-8a448eb19993@amd.com>
Date: Tue, 10 Jun 2025 14:47:32 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC PATCH 3/3] iommufd/tsm: Add tsm_bind/unbind iommufd ioctls
To: Xu Yilun <yilun.xu@linux.intel.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org, gregkh@linuxfoundation.org, lukas@wunner.de,
 suzuki.poulose@arm.com, sameo@rivosinc.com, zhiw@nvidia.com
References: <yq5a5xhj5yng.fsf@kernel.org>
 <20250529133757.462088-1-aneesh.kumar@kernel.org>
 <20250529133757.462088-3-aneesh.kumar@kernel.org>
 <aDsta4UX76GaExrO@yilunxu-OptiPlex-7050> <yq5azfeqjt9i.fsf@kernel.org>
 <aD3QcQxtjoYXrglM@yilunxu-OptiPlex-7050> <20250602164857.GE233377@nvidia.com>
 <aD50lpgJ+9XMJE/4@yilunxu-OptiPlex-7050>
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <aD50lpgJ+9XMJE/4@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SY6PR01CA0093.ausprd01.prod.outlook.com
 (2603:10c6:10:111::8) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|CY8PR12MB7196:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f5c8eda-09a6-4c2d-ebd8-08dda7d9ecdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NER0Sk1XZDVhVVIzQTd4VmJqMVk5OFQyN2JEYUtpajJVQW9iM2hpdzZxR1JY?=
 =?utf-8?B?RnF0ZS9VUnEwSWhWUHF1QjFzeE4wbERSb1VKNmZ4LytPMG5kRHR2eXpuOEt0?=
 =?utf-8?B?eTM2T2JBekxmUmY0TnhUeURsOWlKQUsrQ3NRQUozN1dQMVBEaTh5TnJtUE1K?=
 =?utf-8?B?Vmx6YmVqRm16M1UrWnpGVnpjNVJSYit1cGV3TGNXcTNHSUdIQUN0S1ozVFZN?=
 =?utf-8?B?anBTcE1Gem1NVVZaVDg5M0lYUG1IOG80UEZ1a1RUNEMzOTVuUjZKa1NiamVN?=
 =?utf-8?B?c2JLTFlYSHJteTNpaHcrQlVoT0dabmh0bGFqYTAzNUhqRjNzT1AwMGprUllM?=
 =?utf-8?B?VHY2dTFCU3QzVHRyUDIzbDJiUUJ4Qk5rOEtEZXk1Z01RZTVvR1REaGtNS3FR?=
 =?utf-8?B?Sk5mQ2Qxd0ppb3JmUDg1UXMzYnBHdm5nWnFIbzN5L08yOVJrYTVkQWtyeG4y?=
 =?utf-8?B?SnNGQ0Z3UENZRWFlcWNNK20veVpPcnJkZDdubWxVOWZPZzlGOFBNWnlyczhH?=
 =?utf-8?B?U1k3S1VtRTJldU9McG1STjJMWWZNNmxCT1NoUUJXNVRhVThjbzBxZUluZjU1?=
 =?utf-8?B?cGcvVDhYMXVlSzkwTituV092WExiSFhYUElONTg2dHBJUUd0aEZjYkpWcWZp?=
 =?utf-8?B?NHJqR3JTVEJOQmtsS2g5ZE40T2ErY0NRUzFUN2svd045QWxDbWkrLzJjaFg5?=
 =?utf-8?B?ZnFaK1gyMXRhc3NRMnR2RzIvaEs3ZjYxbm4xZjVPa3QzeEtxdHVBbnRtMXhO?=
 =?utf-8?B?VHVEUkdyODZtVDBWQ3MwSC85TW9YdGd2L2NlNlNUNVVyVFpEbGhhRVRSZDhC?=
 =?utf-8?B?VFRoMEZTTTNJOTNIdVZVMFVWdmVUNjkzZzhKTjl4Yjl3OFl1eFBUbEU2dTdD?=
 =?utf-8?B?VjVoR2ludEZEb080UjJHY1BkT3cremY3blE2ZlhXT0FQMDZZajNkdzZ0MXJU?=
 =?utf-8?B?TXd3elpueXlXN3QvT1NNOUREaWZvK21hWE16RlZrNGZnZkczM2dPUjhRZU9W?=
 =?utf-8?B?NGkzaW51ZURXVjFyQUlDeEYxaDBxNmpnMFZPeUYzcEJEZFhSSk1FdHQwZ1BI?=
 =?utf-8?B?cVdmczdwelVSOE9uV3Y2Q0ZocFlmbmUxaFRrOU5ybk1nLzNWL3pHRWNvTjho?=
 =?utf-8?B?YXZ3UUVNejJ3RUxjYUpSSm9DRlYvUUR3MkZhWlpZMjN5SENCL0hKTWFoY3lp?=
 =?utf-8?B?Z1J4OHV5eGd5VjJ5a1dyZE5mQlJ2T1lMM0xoeEMyeGUxQ2RSYTdRZU5HWDFR?=
 =?utf-8?B?cmJEcCtoMjV2STk4RW1LTTRadU1aY0dSRkJuV245TGM2QWQyTThrUFJ5V2RQ?=
 =?utf-8?B?Y2pNRzd0enQvTVBHdWxLS2RzNnU5Lzh2eHlsWUhoVDFyREV6V3BueDJwdTNa?=
 =?utf-8?B?aUJCRVNDVGhCaEVwakFMT0U4ckxQcjNDRWUvM1dUbFBIaHVWK0ZtZ1ZiR3Rl?=
 =?utf-8?B?UDFwbXNtbDFBbXlUMVZ2aWNmbUdyNG9HdGJibDhOWC9yaHBKcXEyODU1eXUx?=
 =?utf-8?B?cXdDeDBvdjNlemYzallzbEViY0d4L25va0ppRXV0YWdkODdyMytyenhrVFBB?=
 =?utf-8?B?cG9rVFlrT3NQUitzK2hiTDJWV3B3cXB4bjYwWnlXRm1PRFphOXZwY2IrZGlX?=
 =?utf-8?B?MldEOHNaTnlQUHp6ZjVSOWptN0ZCSlNFN01QSE5vSjFRZGZTcUZKSGtiV2ht?=
 =?utf-8?B?WlhNK3FKOWdLdTBsSXQ1eldQUU9lVjkxMW5PZlJHSlU1QXg1K1BVZHBYYm40?=
 =?utf-8?B?TS9vSlBHOW5NWWNZUjdlYUcrbVJwOGhLL0VxRjJyUkp5aFFUUGlLOHNNOGh3?=
 =?utf-8?B?a3Y3THBLU1FUZVp1eG96WjhDTm9RYTA0WGhkUERFa1MvTnlvRk56SXd3aUkz?=
 =?utf-8?B?VE10eko4VXpTS3pkdHd3Yjk2QlcyZEl2dytxK2JaYnI1QlVnVGpTNFNGQ0dy?=
 =?utf-8?Q?lTSy8ABsMZY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2xYb25uQjFDd05oMnhQYUtiLzBCMmxvVkpGY3RrRTV0ajZBQWx1MFNtY1k4?=
 =?utf-8?B?dzhPdEZhK2w4dmNaMXpuZE5IQk1NeGV2THFMYWVrd1ArRTZwSmhBK1RJeTU2?=
 =?utf-8?B?QVp1TVZVelNEak1CbUd3dmJyei9KcHlyVXJjWEo2VjhobG1kVlJXbmFMcmU4?=
 =?utf-8?B?cG9Ja2tTaUkxNk9lUFo1TDNWMjZyMDdBVzJhZzRSb3RTVG1OeTFZYVJIZ1FF?=
 =?utf-8?B?eUo4Y2k0SVY4aUc3azRDNVpIdkx5cW9jVUNWMFZIUFdCclhpNFBqd1IxYzRN?=
 =?utf-8?B?UHBBSHhsMTNpYktQbWJpRnVFeEtBaDFyY0wzbzJRaDNXanlGMWY5YVFRMlB5?=
 =?utf-8?B?Q2hrakNITzVrejhNRmhhTUhxM3JQRkdmSzhMR2FYS3lzOWZCWU9uUlg5eVFk?=
 =?utf-8?B?Z2kxQmNKRDJtTWlYelQ2anJUZGQ0YkZZbTYrSmhwbFBQTFVvdko1V0lKeFNW?=
 =?utf-8?B?VkxZclZ3eHpUTkJQQmxXOG5uSTMydXREc292SGUzdzFpRGliK0V2OWY4Q25N?=
 =?utf-8?B?OGpCZ29lT1VYVldLYTFpcG83WGZJU3FGdmJ2bk5rSUhybUlTQk5uakdzR3JT?=
 =?utf-8?B?M3B2eDdFRG9WUm1lbTdiRWVGVTFkYnpFdjhBSlg0a3d6UWk1aG5LTkxVZXlT?=
 =?utf-8?B?WXpseTBJbEkwWkdScDJ1YXFkL2FheTlTTEtBSGM0YXp4aGU2VUhEbTlLRVRr?=
 =?utf-8?B?TFhYeGFaaXA0d3hUcGlPSDZVaTJubGNWWE1EVjZqVnJlNUVtYVkyVEhHMGhQ?=
 =?utf-8?B?eWpkSUptYytGMXJBdW5wQXdFZmU1Q2VtVEpMUHl4bnJHNnRidW43TmpwaTdV?=
 =?utf-8?B?MjIrcitLV0tNMWxZSzE0MkdNa3ZVL3B2bXIvK0dOTlRzK1lNVVN2ejd1Ry9x?=
 =?utf-8?B?aFpkOHZNaktwRXpFZjNHZ21jalhVY3N4YmJpQTlFakErL1hrQWp5VW1GSXdl?=
 =?utf-8?B?Z21GNFJoUjZpb2NDaW5RbnJrcVhOK1BORC90N0dGYUtNR1gvWDVYMzJVcEJm?=
 =?utf-8?B?dHBhVnZqRlpCR21oeUkzaUdFY0VoeVpqSGRiSmovN0FxdWZ4SDQrbE9FbGo4?=
 =?utf-8?B?b0RSd0RPeGl6RkYwZXNnWnlyOHRzNjRqaGNrRzFDK2RKamswK25yVTBNdVBw?=
 =?utf-8?B?R21jYi9GVFY4bzBMRDF1akRYY1lSMGMxV2E0K3IzV3hTOGJ3RE1UOEoxa3ZQ?=
 =?utf-8?B?cGg3eStvRC9oWFpoWFBGYk1xRjNTcDZkdEo5WlprN3FUNEx0RHZDVGNxSDVD?=
 =?utf-8?B?SzJ6YWN6bUJadUFNM05wckpSdVhWTStGNkhwRXNNb2t4b2RFU1Zwb1d1MjI4?=
 =?utf-8?B?QUN3aTNsUUcydlN3TjYrbXpxMzJCcWZYK2N6UTJpUit4TTZsU3VIKy9UbWxm?=
 =?utf-8?B?OU90b2tVWXd6dWZ0K2FwbldPZklldlArOGk1SWxINHREZG95ei81YlBERlFk?=
 =?utf-8?B?RE1rOGlscjY0UDBrKy9xaWxyUlRQQVlrRjZIRFdhbFNBR3BsYzMzSGlxYzRr?=
 =?utf-8?B?Ym83OG1PMXl3NHE1RHpXNlZUYkM1TXcvdlJMZVlEUWZWRUY2TDVOM1A1SXpw?=
 =?utf-8?B?V1hNUGlmS3pKaTVyVVMwMTFqYUFvS3lYNWYraEtkbWNtZytaOG5zS1EyVlp0?=
 =?utf-8?B?SHA5VnVLYlJBU3lONnZiSHAzR3JUU3FJaVZ5dlFIbGRjNVd4cUJhd1dEdEI1?=
 =?utf-8?B?RmV2dE0ydHdKVTJIV1dFcUYvQjRoWCt0eUoxemlTVGJqSE5LN1dLTmVCQ2hW?=
 =?utf-8?B?K2s0c21iWTl0UHhwQjVwc0lUNmNjQ0xXaWlxa09aeEM2NkFpcXc3anJHbTZu?=
 =?utf-8?B?dTNHR0lRdWxQQ1MzQkpUUzBhZlFyS01EVlpaSUVFK1RZaVRNRG5DMnA5ekRx?=
 =?utf-8?B?a1pOYzd5eEZ4c0NpNFdrWGtGRTBHL2tkNk1RVkYxUUxORkdTY1Nwb2daQnIz?=
 =?utf-8?B?b1FFdHpqMGppbURFV1Q1RW9kTFlZcWlpYmxKUzZEQzQvcE80ZmhXQTBaZ2wy?=
 =?utf-8?B?VWMwZit6WnphV2pXOFpqUmpnNExTZGIvbjg3Q1hITlBZTnV2V3Z1TDM2TVh4?=
 =?utf-8?B?M3l2Q0U1WU5ZTGtxTEFOaGF1dFRyNFJVNFlZaTNEQTdtN2l6ZXE4cStSdGtp?=
 =?utf-8?Q?5q69RKtosQeKthWlt4QyM422M?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f5c8eda-09a6-4c2d-ebd8-08dda7d9ecdc
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 04:47:38.3993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IByl+Lu1yePItKwq+gbaWenjqWOMu5zPjuSqKXJhbl+lcFmpFj0o951bPQz1XY0k04U983ZUDjzw5Jmi6AUIHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7196



On 3/6/25 14:05, Xu Yilun wrote:
> On Mon, Jun 02, 2025 at 01:48:57PM -0300, Jason Gunthorpe wrote:
>> On Tue, Jun 03, 2025 at 12:25:21AM +0800, Xu Yilun wrote:
>>
>>>> Looking at your patch series, I understand the reason you need a vfio
>>>> ioctl is to call pci_request_regions_exclusive—is that correct?
>>>
>>> The immediate reason is to unbind the TDI before unmapping the BAR.
>>
>> Maybe you should just do this directly, require the TSM layer to issue
>> an unbind if it gets any requests to change the secure EPT?
> 
> The TSM layer won't touch S-EPT, KVM manages S-EPT.

Is not it the TDX fw which manages _S_-EPT? And the TDX host driver (what is it called btw? Intel's "CCP") registers itself as TSM in the TSM core so it is somewhere near S-EPT logic? Thanks,

> 
> Similarly IOMMUFD/IOMMU driver manages IOMMUPT. When p2p is
> involved, still need to unbind the TDI first then unmap the BAR for
> IOMMUPT.
> 
> Thanks,
> Yilun
> 
>>
>> Jason

-- 
Alexey


