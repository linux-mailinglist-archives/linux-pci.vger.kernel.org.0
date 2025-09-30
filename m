Return-Path: <linux-pci+bounces-37261-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32510BAD36E
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 16:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CB9A7A02C3
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 14:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACFB21CC4B;
	Tue, 30 Sep 2025 14:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aBDnfQJA"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010067.outbound.protection.outlook.com [40.93.198.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA35D8F7D;
	Tue, 30 Sep 2025 14:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759243119; cv=fail; b=johyj3NPn6x92fEcHFT95a36fVvpXAhusFf+09l1TaIkPBbKDXbkBXYEggMuAefc09ilOguPwtuu8bufsIs8v2ycpL+4H2QZhsnYJb6ZNE0ums9AzRVYA49FUl/o5bIy/uQ5mBaZcTtoJogn92EcCqraxo2eGrIJnaGU4ha5nxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759243119; c=relaxed/simple;
	bh=tMPowJU5U294+3/z46mtAJxkQffvbXqHJZOEVp66vLc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IhOcl15puXQ5aQhtZFiKk0LDvhKsdzVdBkn9Q+j8WGJ+P8HsRXMNlDtsgTsm++xdwW3/VTPeJOxr3let6ulv3gzJsGjU1rzz81Mf4uN7qTfyfOoVbNY+XigcG+bF7weKH/HCNPZRCmdJbGWCYckr++xdXj/jVPEU4RIdSR+KZhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aBDnfQJA; arc=fail smtp.client-ip=40.93.198.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PkWB6O0CQ1NDTELY6/J+rftsQWuh5keuzzKIG9vcuOyExToARsQOIeTy3RPlxZX/1wJgZ3z+GoLTpTV9FsR0C/u0VbQo9jVgKBSR5g3vkTZ4mK3dU4bADDkwxZ4YfPvgBpoq0rdEbIpBdJ70DQ7tzlfEUJuZA7aQrpR120lPcKQmc3fel3aTmRd6EGopHU1pwDiYYUtDVTQPkt0Hj1B61FtrfHmrr1askC2y0JY+/r43Lo7YyagX1lgaoXSMskBCgJePjpuNnE0vARvAaq/A2UdlI91MjIv9WRqdgrCjV+lmm2+eRg0W6vKsy41Oi8geI5iADwr+opMw2zvaKBkX/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5l7eyGneU0Z9wp2nROIroWAf+PLWvccDyvTxWME/zs=;
 b=VDJvAsQxDBCLFyyboQIh4JVPGmxxupoNLZ62nU175YsCg5cCStN8WwNSh//Ivh0rOOestKfPMFdzP3S7yGk+VupKG34UK+y4PDMXoE0Q1/ZxwWvxASewKjPpT6y+kWYufWSXa8NdjWmKbYRimNPwFOucarvTenIBcXTI6CmNlOZQ0brKBiRhX6SyH71XmTpVJmjNFPjXWuq1mRUwInLBpXDwQI7T/qfKrPALp1CCZMkZ/SjCoxMxeExVZT6xF+KP70k6MICxX/FppVX8Kv2WdMf00T7ykT0a3TGGTqmGM6EJvYOTnG6Dn2jr9q/GqX+9HIMOcUhG0fK2fU3phAJ6cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5l7eyGneU0Z9wp2nROIroWAf+PLWvccDyvTxWME/zs=;
 b=aBDnfQJAQZfdjR6JtpWRljYu9T1aVhc8jaOnlKozyZYyT2kIbF/TYHQ3nPCV547REDa3ZxDUfZIQe/gysBf/YzSDpRlF/IzlQI1eRuLZCWw8Sg6uUDpa9CgG1z2eeZHaG3d/GMg7IKCEYiRq2e994D0xAyEBiJZjMLYnDBdt2AI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by DS0PR12MB8319.namprd12.prod.outlook.com (2603:10b6:8:f7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 14:38:35 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14%5]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 14:38:35 +0000
Message-ID: <a2b5d6f0-7f6a-4ac3-b302-73fb3c1a92b2@amd.com>
Date: Tue, 30 Sep 2025 09:38:31 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 23/25] CXL/PCI: Introduce CXL uncorrectable protocol
 error recovery
To: Dave Jiang <dave.jiang@intel.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250925223440.3539069-1-terry.bowman@amd.com>
 <20250925223440.3539069-24-terry.bowman@amd.com>
 <d3d3ab84-8cdd-4386-82dd-de8149159985@intel.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <d3d3ab84-8cdd-4386-82dd-de8149159985@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0054.namprd04.prod.outlook.com
 (2603:10b6:806:120::29) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|DS0PR12MB8319:EE_
X-MS-Office365-Filtering-Correlation-Id: 71897a6c-2b6f-4683-ede8-08de002f0937
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SXdKVTN1aTE3dEZWUlBxNUxqTkQyMUtLRVBHYnVzRVZwMnNvRDZhdTQ5RG0x?=
 =?utf-8?B?MFhZWmJva1hNZHdZZnh0RytCYkMxZm9Rak9WdDJCaTRYU05xQm9wZm9JbEpa?=
 =?utf-8?B?RGZTUWl6bXQwOW4yVHNrTUdQVS9sbTZoZ2pCSWdObnEyQXYxc2ZUZ2pNL2dv?=
 =?utf-8?B?ZXA5ckhxVWhCTVpnbFJBTVk3Y1Y4UGZDS3ZURjBKQnhJdG4wZzNUN2lhZzlY?=
 =?utf-8?B?ZElnZGxyWFlscmc2SnlOUllQVUpvUjYzcGwzZVQ3UjR3M2E2OS8rMHVsejBa?=
 =?utf-8?B?dDZOZXZScENCcklJSVk0Nnh5QnF6eHl4YUdlWk5HU0RDQzd4Skp4OGU0T2lk?=
 =?utf-8?B?elJQSkZzbXRBK2l3SDFsbXNXcDl2RW5kUHdXVWVDaGZQWDdYOXZ5TXNzeHdR?=
 =?utf-8?B?RDNvckV2YTBNanRmb0ZpZGVwV3FheWlXRlh0SUJ1L1JSS0kzZFRtcVhWV0FH?=
 =?utf-8?B?ajBneUpqeFVnS2pyYVkyRDF5aXlGVisyMjZ3RVhkelVORGtBR1NxTmJqWGp6?=
 =?utf-8?B?V0djVU1xWkg3ZWVRTHN2UlA3NG53MW9CZUI4UVljV05FSnBYbEdMVnhrbnAy?=
 =?utf-8?B?WHJJbDdEUFJFNnA0SXZGVEwxWVZxczhJZzVDQi9CcHVyUUtIZDZ0MkZGUTNU?=
 =?utf-8?B?Z0ZRQkFSWGRNWitkVHBQWDBScUFyWTRGbzVKZ1kxNHZwTndVN0ppRkY2YXp2?=
 =?utf-8?B?dlhrV2kwL2FOS21MQ0xKN3hBRTRNZkdZazRlUXk2S3N5M2hvSEE0d29xMmxS?=
 =?utf-8?B?aUEzc2ZmOCs3Vkd4NkJBZ3lPNHVacFpnQkdUS21WbDZEbGtnZ3lIWEdvZ2JY?=
 =?utf-8?B?K1B4d3JXVG9mc3U3anR5Ly9KVjlrcE50aWpkOUU5eVNaOEgzdHVBdStLSVRr?=
 =?utf-8?B?MHZGU29EM05nanZRd1FicS9VUE1meFpROGFYN3RCWFFrek9SdWkxUzUrU2RE?=
 =?utf-8?B?QlFrYm9aOXNSREREMEdxUmpOMmJMV0FPNUplUTFDT1gzKzdKVFVNUzA3RC9k?=
 =?utf-8?B?QnV3SUdkRU1BdEdXQWc1ajR1MnovWUE3YlZXV1I3VERSQXZVeVh0ZXhEeTdL?=
 =?utf-8?B?bmNpMEtnalNPTTF2VVdYK3pKUm0xMUNwZUV4bGUyVDNYS0dQMnZmRTZMMk81?=
 =?utf-8?B?MjdxeEVTUWJXWDJBbDBmZlkrNXlLVEZaZmZkZjZMTVhtWGNuRkd3WXJQdnNU?=
 =?utf-8?B?M0VjR1Y1R25icEpuaEQvNkpvZHNtOFJRc3FwVGtwQVQ0YzhSL0UyemE5K3Qv?=
 =?utf-8?B?MmNlUW5lMWRsdVRlUk8rZEpVSmI4VWZwMXVNVmt3d3FJaUVwRVk1NVdxaXJY?=
 =?utf-8?B?YWNuSmNZTDR4NGUxWXZlZmVFSkV5QXdEQkxLcGJlRUxuOHdhZkVMRWNkQWlo?=
 =?utf-8?B?c0tLK0FJWEd0SGlKYjB6eG11cnRORVE4dFcxWVJjZ2ZiVzAvK3JKMTdsOVNt?=
 =?utf-8?B?SFVUc1NNVFp1dC8vTDFkRGJVUjVySFVCdHBQQ0J4Wk5VdG9rNHV5TVFnK0pv?=
 =?utf-8?B?Wm42Wnc4U29qNnoyQThWUG1LVWJON2JxUE5NNzNKUVRaazFkNUgzWnU1K2xS?=
 =?utf-8?B?Ulo2V0Z4eHpOTzcxME1pK2JuV3pQNEc1a1VobUtwT04vK3N4SWwvTzB4UVVW?=
 =?utf-8?B?dDg2ZkpXTVRkL0diUlhhOENNU3p6WDkrQ21Vb2NVSk90ekVBbkFVNXpqWFFo?=
 =?utf-8?B?R29oa1h6dHBtNUJJUngrS2tSS212WkYwQ0pDRGRRNjlvK09CbmYvcDZtMnRN?=
 =?utf-8?B?U3N3S3Yyd05lM0EwbVZxVHFFYWwzSStRVXc1TUJCWFZzOXNVWDBOano1M3JN?=
 =?utf-8?B?dFkrU3B0NTlQZFpFTkt4YmduYndjd0F4Ym15NXVlcmxPcUdSN0pYVFcxNHFt?=
 =?utf-8?B?U3hJZmFHYVVXaHlrZXVCRStkVk9jdStPSDVxWldaY1ZteVErK3BTN2tZQlJU?=
 =?utf-8?B?RHh0WFVHR1Z5SlBOVzFSUGZSVUlPSkcrM3NwWEtZNWpUci9HSnFUK2Rmc1h0?=
 =?utf-8?Q?KrpG3/10et9RrQWa6e8PO0AFQCNTMk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUFVaE1sRlBjdGRyLzlSK0NHWHpBUG01Rk05MlVRL1ZuSGw5ZE1aZ1RlQmh4?=
 =?utf-8?B?bjdqMzdYWHlRMWZHM1lSeGhDbG54TDJxdTMwY3Y0elQ1Z3JkK09EVGt2OU5o?=
 =?utf-8?B?c04zMU84MDlCajlaeXRzMklrQnpKa2FkRzNZa0NycGd5bHFCNmxibGpmUk1h?=
 =?utf-8?B?UzMvQmVvYWcyUXowM2VoMDlGWUc3Qk5Sem90S2dwcXp6V1hDV1ZxZVZEWFAw?=
 =?utf-8?B?YTJpbmwxeXBIeXZtenpNS3lhaHdOUlZ4RUJmN0VCRkNBVHpNUVVmOWlWYkhR?=
 =?utf-8?B?V29Gb0RjdjdqakRRVGJDcmMvN2Z4OURWaGZnR29ocDN2b21Zc2t4TWp5dzJy?=
 =?utf-8?B?UmNFSTVzSDI2SHhDQmdOQlJ3ODU1TjFRL3RESStPOW1ZWHhONGJSWWlKTUZJ?=
 =?utf-8?B?QTZpaUtFWGtDSzhUV2hNU0xNTHk0ZU1rckFKWmhCRitzTkpKZ0lia2xTUmFI?=
 =?utf-8?B?M3hBMUZaTUZwZFlYUlVBZytOVDh3dm1qUEZPSlcyV1hRN1pvYnNzMFM2eUhH?=
 =?utf-8?B?SDZlaERoNXhyd0R4Nk14TmxSQnBaQW95a1VYV3NsV1pyMWptZmZKVVNNNHZJ?=
 =?utf-8?B?V1JSblJtaXZJZVpsZFNFRXYvR3NsMkFwV004dzcvRnJGUndoQS9VZzFJTVdJ?=
 =?utf-8?B?VW8ydnk0cWE2UDhyaU54NFV5cHZCVW4yanJJZTY4cUxjK0R4ZUJQOEdjVGJu?=
 =?utf-8?B?NXgrYnB4Q01rK2grOUlFOVN5cHNGVnFJNUx4VS9za05PeU81YWUwMDBPQTlZ?=
 =?utf-8?B?dTBtOVBVYloxSnVnR1lxZm9xaXBmamlzMnhtUXg2RUZOZTlKRXI0ZXd6clM2?=
 =?utf-8?B?ditndDhRd00xdGxST2JLaldiaUFsYy9USFJ1MGFGUnZyZ0lHRDRzLzhuanZI?=
 =?utf-8?B?WXBxMllSVWRLdWtJQVU3UXNoV2ZvbFpQWjVuMG8vd01ocEZQUDQ0Zmg1NHhu?=
 =?utf-8?B?emd6ZVBBMVVvRVZRU2dYbTljbklqbjVBSndVeGRHemhIVVM1TndxdElXS0RE?=
 =?utf-8?B?Y3QwbTVPTnQyMFcvZVRkcGVpSjFmVlBIWlhSVk4walViU29GQUIvdW5hcGd2?=
 =?utf-8?B?a0lXdFNZa1NLOUNMMjMzd0FxU2RFcjk5ZXdFZXRkRmlnT2RtVS9vNDRrOEty?=
 =?utf-8?B?cjFGOTM0c1JGQmhNTlFQRDZtUDQvOEZzNXBiYTBnakhnc2dlK2pCQzV3eWJN?=
 =?utf-8?B?TGtYNUZNYUZvUzluanE4aFFNTzBFZVloeFFlTStzWTBlYjJaaW1oYy9FK3FB?=
 =?utf-8?B?czFFT1laYU1JSi9uOFpiWTJpWUNPR0dDbUFWSlVnejVZdkNtVndEeUI2Vnhv?=
 =?utf-8?B?UzAzZ0VGWTVFWjdvaDBDaU5mK0UyTmdLWURnY2IwclkxNWUvSmRVUXJCTzV2?=
 =?utf-8?B?OGpxVUNZbnlPY0tqVGc1ZzlaNjNVMDloS2hoQXBRVFl0Mmp3NjhXbjNWTkxR?=
 =?utf-8?B?eHMwb1d1ZWx0NDNrdWdiMkZ4TGY2Qk01SGs4WjRFRlpXMllGN2tRSGc5dEl3?=
 =?utf-8?B?d1NNME9adXEzMlptQ0h0UzNtUTh5dU5TMzlzaUdwbmt4U3QvMHBJdXBNMmRL?=
 =?utf-8?B?enVaZElCaG5kRHdOWW1kc0dqWDJBRisxc1VSaDg2T1VqVDQ2T1ZjbW9vUVgx?=
 =?utf-8?B?UkxwMFl0UHltVHJ2RmdaY3FGRWEvYlo3VTQwVXIvVlVoVTBzdXR5TGhNbXg1?=
 =?utf-8?B?Z2hOZnRQeFg1T2ZxU2taOVZZaW0rencyWFdwWXZXWmJPMzFsYmVTaHFxNTBF?=
 =?utf-8?B?Mkgwd0twYlJvVitKeVhtSDVKTFNHeG9ZanhETzFKcUJVN2dla1RXOU03aEpZ?=
 =?utf-8?B?TGZ6cjR1TDdJa0FhNXg1dnZlcWdGSThtY0hLRlZ0RGMrZ2l6cm1xTFVaQlBO?=
 =?utf-8?B?TDZRRzhnR3ViSlpKNllFZXBZWHo2b0hGKzViaEYzYTNabnZoUm5STzRLVWpZ?=
 =?utf-8?B?QU16cEpaSnVKUU90N25zb3l4SUIwZlIwZFNNTGtjOHJacytvQmdBNzFMZ0o5?=
 =?utf-8?B?UXdCNHcvWDBrcDJ1Sk9rbTR3RVlCVkdqLzZGZW9qZEVPWk1Td3RXNnM3MHhz?=
 =?utf-8?B?SHpMYlhVUHdIL3MwT1k1OHhSeUROOG1CbGZTK3J3SExvTE1RL1Nzbzl1UnhT?=
 =?utf-8?Q?zQgANuYIZXKNqMrhFm00O3zvz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71897a6c-2b6f-4683-ede8-08de002f0937
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 14:38:35.2828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5WPhgn0kQxXcjIcCzHIvVeH5SihKHXkB14xZkmHnr2DJ8cYG/w4xruYOntb5ImDc4lDXYMZRpglqd8bcRQp0gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8319



On 9/29/2025 7:26 PM, Dave Jiang wrote:
>
> On 9/25/25 3:34 PM, Terry Bowman wrote:
>> Populate the cxl_do_recovery() function with uncorrectable protocol error (UCE)
>> handling. Follow similar design as found in PCIe error driver,
>> pcie_do_recovery(). One difference is cxl_do_recovery() will treat all UCEs
>> as fatal with a kernel panic. This is to prevent corruption on CXL memory.
>>
>> Introduce cxl_walk_port(). Make this analogous to pci_walk_bridge() but walking
>> CXL ports instead. This will iterate through the CXL topology from the
>> erroring device through the downstream CXL Ports and Endpoints.
>>
>> Export pci_aer_clear_fatal_status() for CXL to use if a UCE is not found.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>>
>> ---
>>
>> Changes in v11->v12:
>> - Cleaned up port discovery in cxl_do_recovery() (Dave)
>> - Added PCI_EXP_TYPE_RC_END to type check in cxl_report_error_detected()
>>
>> Changes in v10->v11:
>> - pci_ers_merge_results() - Move to earlier patch
>> ---
>>  drivers/cxl/core/ras.c | 111 +++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 111 insertions(+)
>>
>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>> index 7e8d63c32d72..45f92defca64 100644
>> --- a/drivers/cxl/core/ras.c
>> +++ b/drivers/cxl/core/ras.c
>> @@ -443,8 +443,119 @@ void cxl_endpoint_port_init_ras(struct cxl_port *ep)
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_endpoint_port_init_ras, "CXL");
>>  
>> +static int cxl_report_error_detected(struct device *dev, void *data)
>> +{
>> +	struct pci_dev *pdev = to_pci_dev(dev);
>> +	pci_ers_result_t vote, *result = data;
>> +
>> +	guard(device)(dev);
>> +
>> +	if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT) ||
>> +	    (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END)) {
>> +		if (!cxl_pci_drv_bound(pdev))
>> +			return 0;
>> +
>> +		vote = cxl_error_detected(dev);
>> +	} else {
>> +		vote = cxl_port_error_detected(dev);
>> +	}
>> +
>> +	*result = pci_ers_merge_result(*result, vote);
>> +
>> +	return 0;
>> +}
>> +
>> +static int match_port_by_parent_dport(struct device *dev, const void *dport_dev)
>> +{
>> +	struct cxl_port *port;
>> +
>> +	if (!is_cxl_port(dev))
>> +		return 0;
>> +
>> +	port = to_cxl_port(dev);
>> +
>> +	return port->parent_dport->dport_dev == dport_dev;
>> +}
>> +
>> +static void cxl_walk_port(struct device *port_dev,
>> +			  int (*cb)(struct device *, void *),
>> +			  void *userdata)
>> +{
>> +	struct cxl_dport *dport = NULL;
>> +	struct cxl_port *port;
>> +	unsigned long index;
>> +
>> +	if (!port_dev)
>> +		return;
>> +
>> +	port = to_cxl_port(port_dev);
>> +	if (port->uport_dev && dev_is_pci(port->uport_dev))
>> +		cb(port->uport_dev, userdata);
> Could use some comments on what is being walked. Also an explanation of what is happening here would be good.
Ok
> If this is an endpoint port, this would be the PCI endpoint device.
> If it's a switch port, then this is the upstream port.
> If it's a root port, this is skipped.
>
>> +
>> +	xa_for_each(&port->dports, index, dport)
>> +	{
>> +		struct device *child_port_dev __free(put_device) =
>> +			bus_find_device(&cxl_bus_type, &port->dev, dport->dport_dev,
>> +					match_port_by_parent_dport);
>> +
>> +		cb(dport->dport_dev, userdata);
> This is going through all the downstream ports
>> +
>> +		cxl_walk_port(child_port_dev, cxl_report_error_detected, userdata);
>> +	}
>> +
>> +	if (is_cxl_endpoint(port))
>> +		cb(port->uport_dev->parent, userdata);
> And this is the downstream parent port of the endpoint device
>
> Why not move this before the xa_for_each() and return early? endpoint ports don't have dports, no need to even try to run that block above.
Sure, I'll change that.
> So in the current implementation,
> 1. Endpoint. It checks the device, and then it checks the downstream parent port for errors. Is checking the parent dport necessary?
> 2. Switch. It checks the upstream port, then it checks all the downstream ports for errors.
> 3. Root port. It checks all the downstream ports for errors.
> Is this the correct understanding of what this function does?

Yes. The ordering is different as you pointed out. I can move the endpoint 
check earlier with an early return. 
>> +}
>> +
>>  static void cxl_do_recovery(struct device *dev)
>>  {
>> +	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
>> +	struct pci_dev *pdev = to_pci_dev(dev);
>> +	struct cxl_port *port = NULL;
>> +
>> +	if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT) ||
>> +	    (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM)) {
>> +		struct cxl_dport *dport;
>> +		struct cxl_port *rp_port __free(put_cxl_port) = find_cxl_port(&pdev->dev, &dport);
>> +
>> +		port = rp_port;
>> +
>> +	} else	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_UPSTREAM) {
>> +		struct cxl_port *us_port __free(put_cxl_port) = find_cxl_port_by_uport(&pdev->dev);
>> +
>> +		port = us_port;
>> +
>> +	} else	if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT) ||
>> +		    (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END)) {
>> +		struct cxl_dev_state *cxlds;
>> +
>> +		if (!cxl_pci_drv_bound(pdev))
>> +			return;
> Need to have the pci dev lock before checking driver bound.
> DJ

Ok, I'll try to add that into cxl_pci_drv_bound(). Terry
>> +
>> +		cxlds = pci_get_drvdata(pdev);
>> +		port = cxlds->cxlmd->endpoint;
>> +	}
>> +
>> +	if (!port) {
>> +		dev_err(dev, "Failed to find the CXL device\n");
>> +		return;
>> +	}
>> +
>> +	cxl_walk_port(&port->dev, cxl_report_error_detected, &status);
>> +	if (status == PCI_ERS_RESULT_PANIC)
>> +		panic("CXL cachemem error.");
>> +
>> +	/*
>> +	 * If we have native control of AER, clear error status in the device
>> +	 * that detected the error.  If the platform retained control of AER,
>> +	 * it is responsible for clearing this status.  In that case, the
>> +	 * signaling device may not even be visible to the OS.
>> +	 */
>> +	if (cxl_error_is_native(pdev)) {
>> +		pcie_clear_device_status(pdev);
>> +		pci_aer_clear_nonfatal_status(pdev);
>> +		pci_aer_clear_fatal_status(pdev);
>> +	}
>>  }
>>  
>>  static void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)


