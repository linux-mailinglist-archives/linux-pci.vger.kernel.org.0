Return-Path: <linux-pci+bounces-24872-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BF7A73A3D
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 18:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC199171DE6
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 17:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6472192E1;
	Thu, 27 Mar 2025 17:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qYUGOPpf"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA14213E7E;
	Thu, 27 Mar 2025 17:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743095719; cv=fail; b=I+E/Lno4ibgwTH/KI1HxdQqFf2wwq2oeyeQDihXiikgMuUFJpnXVU7EAp1IhuK1EQyJ1BMNjhAYSYObaUFXUBao+5QQ3DhjHZIGGZTN5LP8OweBkyIkSoXKkKW9FtcV3wOWv40Msi5WANIHPtE1R75WH+MGPa6MJnPUMZHoqBL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743095719; c=relaxed/simple;
	bh=LTyy7S5Qq3O3qzaYAynwDaOElZsVhqtuNXxLafG4YRQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lX4ZgivOfTjCX8jXpl/92MO3uEZyIdMNvLUMZpQzg4v/pfExJXVU6KR1+TihLeQVx4BkkBojI5JEf0TpR8A/0hVRBZycpL/9iJJRys8hXZelrmfUL+GWIK7hUORPJOO4Xx9nfz6bgZ9zJvFc6iu8NEhmdvTWLbh+d+Yi/8frrP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qYUGOPpf; arc=fail smtp.client-ip=40.107.237.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oKXJaaBqkYW1CNGtM49jxH6lvx4KUvoowHfbaMZanNndGkVZ0nt6LZYv82E+jl91VmtAGOqbQyAxqhKhgW7Go9hllEO6olDwjoPox+Ar4JJ7oBOS0yu625d0rWqrEm7OGnwc+OgyOj23+kBaQH/3zMVQa/3YT+VWwcs4XdeHZG2TsEJp2N0gBETpXYzSoTzTJN3yhZZEvXEe3MmAJQtiCeGCLgGZMdwjAEDS12UTBe462JQlQs9Bk5soVICXGG74x3QwedAKrJBvL1TU2OMIkE4nrIDina19Ml+dkWZo2YDGgDsF3e70oG4m2ZBcTps2EYD4dAyj3HZPfrPktvY89g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yEXRUiub8zadt9D0ZTLte/wUNy0cupGlOpTXIOXqGDw=;
 b=q8eaGW+NJ2cq0GuxK//DXSD2bIomyaaS9+iJbsskf39/l7f3ZxdzPZSC8aL47kJbHTIL7tOK6caMgFlSTnuWb9hhhD7dOW1FuaaT5uX6o9TeiD/pttO4XwIYtxaEQnH65VIN4Mstr0xRU6ADlhPX2yyJPWUkDd/fAoh9egLh8NUOPuqALbZ5um57m+bnla8XSnG6fYj9dC7kwXmWwb5T3fea8nV3EbM2AnS1UCDknfcQ0VnQBWkx/KJ0T03Rp4Eh4Y1ylL4kKHAzlwki1RqkLfu4elQKJJghRYPOwHQrljsD6FdRdMO4H2NtZrpOz4C08G9r8Q8lNuXE4/LbtKgs8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yEXRUiub8zadt9D0ZTLte/wUNy0cupGlOpTXIOXqGDw=;
 b=qYUGOPpfmsVR01wTtdWc4GcOO/d9w/CJopqiGf8s3VKFgj4kmGVQsAUOr5kouZ8gkYFB2OoLnpDxV8BZKQUQ3TEXUMYm35KXiMMnm8WMz+kOUH3mheNlAWUBd7I1qbcnG1bLOIp+krcHUs1WdyVESP9e4ys6qhMqD1GV/uIj2DI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 SA1PR12MB8162.namprd12.prod.outlook.com (2603:10b6:806:33a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 17:15:14 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 17:15:13 +0000
Message-ID: <327b4da6-07d8-4f44-a3f0-32b4e5460719@amd.com>
Date: Thu, 27 Mar 2025 12:15:10 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/16] PCI/AER: Modify AER driver logging to report CXL
 or PCIe bus error type
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
 ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com
References: <20250327164819.GA1435732@bhelgaas>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20250327164819.GA1435732@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0132.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::15) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|SA1PR12MB8162:EE_
X-MS-Office365-Filtering-Correlation-Id: 61c73fc9-d2f9-4d68-0c87-08dd6d52efe1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z0o4dGE2MzRCelF2QUtjcjQ1dmsvSlFoMEN4WGhFU0R1WTM0Rm5BN1FSeEp1?=
 =?utf-8?B?SzRCbU9odEtxV1lqL2t5V25Rd2FYODBzbmpORVh3dERBMG52ZW9PTDdjUnhM?=
 =?utf-8?B?WUtHSnZkakprUEhhWUx6S25yYThFL3ljNHRRVWhnMytPNlhGb0F0QmNXK2Qx?=
 =?utf-8?B?WVYxR2t3bXQ5aDQ2eGNzS1psVXNycW9DKzUvUTZpSkdGWmxMaTZpbzVKWVVr?=
 =?utf-8?B?bHBMSmZoeExveU9YYm1TTnVnaUpIR0UxemhnSFpZMlExZkt1OVQwcjBqUDFp?=
 =?utf-8?B?MDFNQ29CeFN4VFc4U3AybTgrZDE5Ylh2eUdVME5uQzBuZGUrVmFZUVRHdjZQ?=
 =?utf-8?B?cUF4YlpLMUg4SkpJYlgzeTJXUlVybWxzY0VCWGUzUUFHTWhEM3A2c3pDR0VY?=
 =?utf-8?B?V1E3YXd4UytqYVFBM3NFTTBzSzhPKy9xZ3RWSUw4dWhYZjUvaENjVkVVUVZa?=
 =?utf-8?B?WWZaNFdsQlMvSVFDa2J5Y0lSK3FDZFhqK0tkYTg1dGxpN2c3RWdjY3ZVaFdz?=
 =?utf-8?B?ZjhJNy9RVTJ5TlVtK1JqaHlSdTV6aFU0cVVvaHVOZTk0YU1NYjQ3Q0w4WnZl?=
 =?utf-8?B?ZnhXUHhpZkNHa3ZYSmRDOFF4a0wvQTlTeXlmUFkzem1Qd1ZoYnp2WmhnQ01i?=
 =?utf-8?B?Z1hteU40RzJYamdlVlIwOUNVQ045S0t0UTBTVnA2K1hDNXBNL3NTTUlxdDIz?=
 =?utf-8?B?YVB2bkJTMkhXU09VeTdpZjhXR1VxK09DcW80TDJPWkRNNUdGS21saTBaMUdq?=
 =?utf-8?B?Sk53VHZRRGZKT1RHTTdaUkpEUW9QQWJMZ0E0TElQOFNUUVJuMEpLZVZOeDdX?=
 =?utf-8?B?T2I0ektBVGoxV0Fmb3VSMXVjMmlCSnJ0ZUNWTzBaSU1QYmV3NVRLZVZHSWo0?=
 =?utf-8?B?Zll5aW1uNk1Va0RJVERvRWtnT2x5aExLOXVtNFlQVHlrQTY2elNEdDZzcG10?=
 =?utf-8?B?V3RiVGxqR0lTSk9QZjN4YlNNOGVFWlNUMkVacEorcGJVbTdHeFl2d281TW5k?=
 =?utf-8?B?a3hUa1pUQTVMLzNqZ0o4N2hpekw2d2s3dVlkYlRNT1ZSMkxJV29ZZW9xTE9Q?=
 =?utf-8?B?b2RPc2pnYU5OVkF0bmp1NDk3UnhJTGFpdTUvVlZJVnF6ZUNSR3FzY2JiRWhN?=
 =?utf-8?B?dUlxWVJCUTlZcVNuYlZESmxWK3NqQUlPY3R2dEMwQUNDMjhYTTVnWXBuMHUr?=
 =?utf-8?B?M3h4VW1OQng4Q09TejVvVllBVmNMa3hjZDF5SXpDVUFBWU5FQ3Y5NVY4N0Fw?=
 =?utf-8?B?MjloNmVVR1ViNTk0amt4OVV4OTQrbHQya2dtdUZlcHJVSkcwTmRDWnMzOEZO?=
 =?utf-8?B?SDZ0dlZVM05JT0VMQkRTMnVNSE01Sk1LdGt6QXhYeUtmS2JhbERTMWVaTlFR?=
 =?utf-8?B?TFZ5Y1NZS3I1K0hINGpWcGorZXBhbXVrdE9nQkIxaXJydS9wdzFiK1ZwcmFl?=
 =?utf-8?B?SExxcTExdm85THZaNTVGaVRaQ3lRbm01Y1NrbkdBVkU3WWVtWG1Wbnp1aUQ1?=
 =?utf-8?B?QjJzdG9NL2RRdldqVmRiZ21xSnc4NVpJUElmYjJoQVphK3FNbGkzc3d2bU96?=
 =?utf-8?B?V1JBanpMNGNUK1hwSGFJZVVoRmorSUh1WHYvTmNPS3ZQdGQ0amtxLzR3T3hY?=
 =?utf-8?B?NHVTVStZQ2xPdGJtK0V4VEsvUGVhVkxGb1hCUlFJTHFkUllEVFRNd2djS0tD?=
 =?utf-8?B?STVZYUNGMlJzSGxYMUhzbnplNFl4T0puSVJCWVlTbHYvL0pCK0psaEduWTZD?=
 =?utf-8?B?U0orU1ZpSjdheGtobFJnbmhjdERHanE3K3B4VkhCK1dBT1ZtcXF6cndmNjhn?=
 =?utf-8?B?bHQ3M2t6VHNaRFVERHlvOGZhL1h6L0E0ZmxsSHdYcmhUVTNHeit3NVVXTlZR?=
 =?utf-8?B?MVc3RXdVVEExaVlUNER1MGd0T1FPU0F6anFuaVlBTGtvWVhOaHVmMjZ2YUdF?=
 =?utf-8?Q?tmGswqPA/lg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dm41NmVzaWlOUmJseURuQjlhVlJxNGtWMmFoWmVvZWZqZ1diZ2ZLVjhqRnlo?=
 =?utf-8?B?dElWdU4yR3Q0SUZoSE9mUDlMZHhCRVJVYllmY29ZNXh4WDNCZlVWcmYxV3F6?=
 =?utf-8?B?c3c1RjM0anlUZ3BKRkNQU2JvMStaSVJRN0orakRSaHA2MzkwZ1NjZ21QVEY5?=
 =?utf-8?B?V0YrdlZxc3NmOG9lQ05uRU5QL0NIcEhkTVhyTTgxbVM2WXArU2dLdEt0UHRw?=
 =?utf-8?B?UkRwVlJZbkJ5WXF2WWVONVA5Z0dzZXQ4d3BrYWRuUnVCbEpVNk5TZ3JzOHFp?=
 =?utf-8?B?UmJhdU4wRjFmUEVpckJGM2ZjT3hGVlY3SzJoYlBpaWJ6bVpOcy9KeG9ZSUpm?=
 =?utf-8?B?OXpUUWN3U0duSmEzLzJDRGIxMlZ5cGE5RFhpcGp3c3N1elFycGpvQTlQd254?=
 =?utf-8?B?dVdPa25tanBDc05sRXJObUVWcHNtVC92b3k0T0MyTm9aMzZtNzl1OXdwVkhK?=
 =?utf-8?B?alBBeldmWEtydy9kL0FQODJxa3lrdDVYMEtsQ1JETmdXeGQ2TWV3ZEFDdjBh?=
 =?utf-8?B?cDdBVjZiN1RCR2Znckd5OGI3Zks5MEtTa2NHTUtWb1BkMXkvMnFsRmZvcG52?=
 =?utf-8?B?WEdCeVhSN3NqeHo3Qm1XTWlYWWNOM3IzZDJXcnF6OG90MnZTTEdOTkJ2WGM0?=
 =?utf-8?B?c1lsZStETzNadXZWdks4T1UzVEFyOS9ONFhtaG02NUIxT0VqUlpMb1NoOUU5?=
 =?utf-8?B?K2xVVDBTSGMrL3lqQTc4a3R1bFdWNGwybE1LUUZYQlgyTHp5NEI4QkNUd29M?=
 =?utf-8?B?M0ovakV1Sk93N3JOR0pxdWRVWEtqcFJON3hKSXBvSmRvQXJiT1dDM0x3Q09Y?=
 =?utf-8?B?emxuK3d5V1gxU256R3M1N254TmhwZWRPQzJFVldsZ29wSUg4Q21ZSjhaQzcx?=
 =?utf-8?B?dXMzYkl6MGFhQzFDQS9vaU9MOGhqS0hxQk5mdkZJbUJiSGlyTVo0T01UMDlX?=
 =?utf-8?B?akozOGxZeUc0Ykp1cFVXZWR0eFJqSHA1U1JzdkwzM1h6VkthQi9HMlppN2E5?=
 =?utf-8?B?WlkvR2t1cTM4ZS9lU0NVS0JScHU1alNNL0o3TFM3YklxeXhFS2czY2FUWDVi?=
 =?utf-8?B?RmpnWGxTeXdpaHlsdzNJZUN4d2dObXlaSEkwZVFYdVNtQXlEYXc4citnbk5m?=
 =?utf-8?B?QmJsV2NYRWMrYjJabjB0dVZuR0tNTW9SZEZ4cWFnV3ZKU1pvTnd3RUZ2bDVU?=
 =?utf-8?B?U0N3YnNHbVZwT3FCUm9jUjVmb3pFa1hwbm0wQ21LY05KQVFGTURxMGx1a1pQ?=
 =?utf-8?B?UnhlRzdxOVJKNVZMMXphcTFyeDBYT3FmcDcrNk5Qd1B3WWtKN0lWcmtYdWdH?=
 =?utf-8?B?UVdUN1dyRm54YVpSY2s1L2NYOURyb3N3R2twNjIyWXlFS0VVZFcxaUloUFNJ?=
 =?utf-8?B?SE5lcnk5Mm1KNFNLRTJKcklQNCthN1hET1F3SU9uZ2tPaWtTMEhDbUpYSFA4?=
 =?utf-8?B?b0lVWmo4dWNMUFQ5MUlvalZ0aDNYSU5vMXpQZjRYYmFZeld1VHhNZnRJVi9R?=
 =?utf-8?B?SFB2MllZZDJWRmdkenFUclZ4Qkwvbm13SGVMQVJackR3bmZEZzgydUU2WTB5?=
 =?utf-8?B?VFdFd1hEWlo0WnlGWHBsbjZjMDBFUjdhdmJlQjViS1czYmxTdTN6VUdBRFZp?=
 =?utf-8?B?MnZDQ2N2MHkzcW9CN0p6QS9QYVRoaVkxQ2NZOUlpTnp2VzdHdXgyMUZLOUp2?=
 =?utf-8?B?aU80ajR2bFlaTFdtaE5FbkdTU20zVVh1cW5CaGtocEtzei91VDhURFQwSnda?=
 =?utf-8?B?ejQxNnhScTRwbWhXTDZjZ3lldXR5VEJoMUJRMHp3S3FqZTlhOFkvVEpXUXVX?=
 =?utf-8?B?V3pSM09sZ2twZVdONlprai8rMXNPN3JLQTJFWkpiMGJybVcwdDhXMGtaUDJN?=
 =?utf-8?B?YzNhWm1weTZEb3QzdHZNMWovL2h3R3dPUzhzdkVJeDJWZnpTNWl0Smd5VUhB?=
 =?utf-8?B?QWdoS3NSb2xnNklFV010VHJEdE1SYllzVTVHYXFqck9rNnE0czhpb2YyOG9S?=
 =?utf-8?B?L3Y1Wjc1SXlQRzU4c0ZrTEluenV0RDdkaUhrOWRGMm9IdmtQV1VFUnpsMGU2?=
 =?utf-8?B?OUFhZ2M3aUV3MFNwUGxBd295eStxS1QxUVdSRUN3V3ppbk16TzdtTStjZDdl?=
 =?utf-8?Q?qJGDnufP/qL6ecdLOMj+SOokW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61c73fc9-d2f9-4d68-0c87-08dd6d52efe1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 17:15:13.7693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2lU+Cz1jZODkc2PdOPKPX0K1rp4kh0Jf0DKkqeH36h9ogw7+TsRPCTkGgo4NiyLP4jKqEeeOx/PbT+VvPI4tmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8162



On 3/27/2025 11:48 AM, Bjorn Helgaas wrote:
> On Wed, Mar 26, 2025 at 08:47:03PM -0500, Terry Bowman wrote:
>> The AER service driver and aer_event tracing currently log 'PCIe Bus Type'
>> for all errors. Update the driver and aer_event tracing to log 'CXL Bus
>> Type' for CXL device errors.
>>
>> This requires the AER can identify and distinguish between PCIe errors and
>> CXL errors.
>>
>> Introduce boolean 'is_cxl' to 'struct aer_err_info'. Add assignment in
>> aer_get_device_error_info() and pci_print_aer().
>>
>> Update the aer_event trace routine to accept a bus type string parameter.
>> +++ b/drivers/pci/pci.h
>> @@ -533,6 +533,7 @@ static inline bool pci_dev_test_and_set_removed(struct pci_dev *dev)
>>  struct aer_err_info {
>>  	struct pci_dev *dev[AER_MAX_MULTI_ERR_DEVICES];
>>  	int error_dev_num;
>> +	bool is_cxl;
>>  
>>  	unsigned int id:16;
>>  
>> @@ -549,6 +550,11 @@ struct aer_err_info {
>>  	struct pcie_tlp_log tlp;	/* TLP Header */
>>  };
>>  
>> +static inline const char *aer_err_bus(struct aer_err_info *info)
>> +{
>> +	return info->is_cxl ? "CXL" : "PCIe";
> I don't really see the point in adding struct aer_err_info.is_cxl.
> Every place where we call aer_err_bus() to look at it, we also have
> the struct pci_dev pointer, so we could just as easily use
> pcie_is_cxl() here.

Hi Bjorn,

My understanding is Dan wanted the decorated aer_err_info::is_cxl to capture
the type of error (CXL or PCIe) and cache it because it could change. That is,
the CXL device's alternate protocol could transition down before handling but
the CXL driver must keep knowledge of the original state for reporting. But, the
alternate protocol transition is not currently detected and used to update
pci_dev::is_cxl. pci_dev::is_cxl is currently only assigned during device creation
at the moment.

DanW, please add detail and/or correct me.

Regards,
Terry
>> +}
>> +
>>  int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info);
>>  void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
>>  
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index 508474e17183..83f2069f111e 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -694,13 +694,14 @@ static void __aer_print_error(struct pci_dev *dev,
>>  
>>  void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>>  {
>> +	const char *bus_type = aer_err_bus(info);
>>  	int layer, agent;
>>  	int id = pci_dev_id(dev);
>>  	const char *level;
>>  
>>  	if (!info->status) {
>> -		pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
>> -			aer_error_severity_string[info->severity]);
>> +		pci_err(dev, "%s Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
>> +			bus_type, aer_error_severity_string[info->severity]);
>>  		goto out;
>>  	}
>>  
>> @@ -709,8 +710,8 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>>  
>>  	level = (info->severity == AER_CORRECTABLE) ? KERN_WARNING : KERN_ERR;
>>  
>> -	pci_printk(level, dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
>> -		   aer_error_severity_string[info->severity],
>> +	pci_printk(level, dev, "%s Bus Error: severity=%s, type=%s, (%s)\n",
>> +		   bus_type, aer_error_severity_string[info->severity],
>>  		   aer_error_layer[layer], aer_agent_string[agent]);
>>  
>>  	pci_printk(level, dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
>> @@ -725,7 +726,7 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>>  	if (info->id && info->error_dev_num > 1 && info->id == id)
>>  		pci_err(dev, "  Error of this Agent is reported first\n");
>>  
>> -	trace_aer_event(dev_name(&dev->dev), (info->status & ~info->mask),
>> +	trace_aer_event(dev_name(&dev->dev), bus_type, (info->status & ~info->mask),
>>  			info->severity, info->tlp_header_valid, &info->tlp);
>>  }
>>  
>> @@ -759,6 +760,7 @@ EXPORT_SYMBOL_GPL(cper_severity_to_aer);
>>  void pci_print_aer(struct pci_dev *dev, int aer_severity,
>>  		   struct aer_capability_regs *aer)
>>  {
>> +	const char *bus_type;
>>  	int layer, agent, tlp_header_valid = 0;
>>  	u32 status, mask;
>>  	struct aer_err_info info;
>> @@ -780,6 +782,9 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>>  	info.status = status;
>>  	info.mask = mask;
>>  	info.first_error = PCI_ERR_CAP_FEP(aer->cap_control);
>> +	info.is_cxl = pcie_is_cxl(dev);
>> +
>> +	bus_type = aer_err_bus(&info);
>>  
>>  	pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
>>  	__aer_print_error(dev, &info);
>> @@ -793,7 +798,7 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>>  	if (tlp_header_valid)
>>  		pcie_print_tlp_log(dev, &aer->header_log, dev_fmt("  "));
>>  
>> -	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
>> +	trace_aer_event(dev_name(&dev->dev), bus_type, (status & ~mask),
>>  			aer_severity, tlp_header_valid, &aer->header_log);
>>  }
>>  EXPORT_SYMBOL_NS_GPL(pci_print_aer, "CXL");
>> @@ -1211,6 +1216,7 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
>>  	/* Must reset in this function */
>>  	info->status = 0;
>>  	info->tlp_header_valid = 0;
>> +	info->is_cxl = pcie_is_cxl(dev);
>>  
>>  	/* The device might not support AER */
>>  	if (!aer)
>> diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
>> index e5f7ee0864e7..1bf8e7050ba8 100644
>> --- a/include/ras/ras_event.h
>> +++ b/include/ras/ras_event.h
>> @@ -297,15 +297,17 @@ TRACE_EVENT(non_standard_event,
>>  
>>  TRACE_EVENT(aer_event,
>>  	TP_PROTO(const char *dev_name,
>> +		 const char *bus_type,
>>  		 const u32 status,
>>  		 const u8 severity,
>>  		 const u8 tlp_header_valid,
>>  		 struct pcie_tlp_log *tlp),
>>  
>> -	TP_ARGS(dev_name, status, severity, tlp_header_valid, tlp),
>> +	TP_ARGS(dev_name, bus_type, status, severity, tlp_header_valid, tlp),
>>  
>>  	TP_STRUCT__entry(
>>  		__string(	dev_name,	dev_name	)
>> +		__string(	bus_type,	bus_type	)
>>  		__field(	u32,		status		)
>>  		__field(	u8,		severity	)
>>  		__field(	u8, 		tlp_header_valid)
>> @@ -314,6 +316,7 @@ TRACE_EVENT(aer_event,
>>  
>>  	TP_fast_assign(
>>  		__assign_str(dev_name);
>> +		__assign_str(bus_type);
>>  		__entry->status		= status;
>>  		__entry->severity	= severity;
>>  		__entry->tlp_header_valid = tlp_header_valid;
>> @@ -325,8 +328,8 @@ TRACE_EVENT(aer_event,
>>  		}
>>  	),
>>  
>> -	TP_printk("%s PCIe Bus Error: severity=%s, %s, TLP Header=%s\n",
>> -		__get_str(dev_name),
>> +	TP_printk("%s %s Bus Error: severity=%s, %s, TLP Header=%s\n",
>> +		__get_str(dev_name), __get_str(bus_type),
>>  		__entry->severity == AER_CORRECTABLE ? "Corrected" :
>>  			__entry->severity == AER_FATAL ?
>>  			"Fatal" : "Uncorrected, non-fatal",
>> -- 
>> 2.34.1
>>


