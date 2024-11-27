Return-Path: <linux-pci+bounces-17428-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 103109DAE86
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 21:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97BE6163F44
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 20:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C203202F89;
	Wed, 27 Nov 2024 20:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="boux5PYA"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B1C202F84;
	Wed, 27 Nov 2024 20:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732739409; cv=fail; b=n55noDiTjPowixci5pLTg5zT7qRXoG0wlmAWFdEkyHtL65ZVdN+CE1pyIhr5TGr21wmLNaiOzJJc5spc4A9bBmdG+Q1TBiqN54DGCI4s1jKfBFwscseH0+AzUCo+e6F98nQRAGstXKKX+ZFLZPMx0XhYqwD9g4B/gEV+/D9gMQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732739409; c=relaxed/simple;
	bh=ijXcS4VIb2vH9X9wU42UXaOKUNs2Lpk9JfLEPkT5+9Q=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kd1WROqlku2S+pcfg4Yo3krOhzZ9xDhsk/6loVHCmt1w+IUeNZjIGxn7fObKPxcX1zrnDaNguOr/zzU18KiJtc1xyNSvfrj5cz6uADtR+k7qBEgxHo0xvSHN3I0C5dR24q4CWzVUpqBYoT4knu9XanlN0sJTM0EfhjCaqMxL0+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=boux5PYA; arc=fail smtp.client-ip=40.107.237.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bwgwrzF9E6ZkglraSr15oE+xKTVGTE/iwsphNfREVGKY/p8K82iMkD5czy3lP4Oq+ns7Pgg6etBA0Ww0R+P19qv5XJca6Wo/VnDw4ApPWyQ7Fmp3OUcmwRy2oAzeaQ5ZF7ZlsKbvLzmFLmHmOtgTosB5Zb7LrnukgGT339w6wgOEbo5nUKqTeAsntXgV6904b4kjrDiGbVDS1F0m0u8T3ZmfPMLI0FUE1s5SjcqCp8UQLKd+C8pDI24MVlkz2Q4i1/cBcBhvHWqNWlWFxsJ01BaTNYxgihT9DM6omkEGG+AgJ6nb9gf8PI88Q95uZdiTzVNlFaE4rFVXZkm7bPd53Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3GE7Zu82DMfxOFgTUKE3na/+wm0NSXr2hqdlzpTOPcQ=;
 b=U88kwHPG8pcsSI1/vQM9YwWE7E52VM0MBowncquJBWAP2zSewkU65EDplEJu3cOv1tY4kzvLx2TbM+seiAmIWjCGEO7Me/RovhrSCwd8y+qXDqQslCYeP80sApj0l8d01UA7Wn+Vc0E78GFzBPJNAcsvgPVjUpcwlJnQCV2YKD2Jl36AH4aDeJuC4BRGcj2CWvSN/4IrIiAIzZV2VHPbMszlMb0BFjP7PWhO4KRE5QSYtfnZCj0wBfPMn854bKLdxUEyvpOsuTLnrFa5QOi+gX2mxlsdE3EMjQy3efaiQwWNWEhzS3+Q+STdg/YSDcabkas6HKEUV+Px/yWzsj2uiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3GE7Zu82DMfxOFgTUKE3na/+wm0NSXr2hqdlzpTOPcQ=;
 b=boux5PYAzGHj4cKRAGe4io5STaipaSoN22gOWnDbCIaoygmPg37fHU0G4fb8npUH4JvehTizCJBSJYeV0iI8dkSqxx8TWm8tbpFB1sRy4xnG3VVkO1di2wmiTi9qtu9SlUuQr8jre6D3GBzBGelP0njhpbW8UkpapHR1TxWvKL0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 PH8PR12MB6723.namprd12.prod.outlook.com (2603:10b6:510:1ce::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Wed, 27 Nov
 2024 20:30:02 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%3]) with mapi id 15.20.8182.019; Wed, 27 Nov 2024
 20:30:02 +0000
Message-ID: <e6301274-c439-4c1a-8e90-ccdcb10f21b3@amd.com>
Date: Wed, 27 Nov 2024 14:29:59 -0600
User-Agent: Mozilla Thunderbird
From: "Bowman, Terry" <terry.bowman@amd.com>
Subject: Re: [PATCH v3 05/15] PCI/AER: Add CXL PCIe port correctable error
 support in AER service driver
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, nifan.cxl@gmail.com, ming4.li@intel.com,
 dave@stgolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, dan.j.williams@intel.com, bhelgaas@google.com,
 mahesh@linux.ibm.com, ira.weiny@intel.com, oohall@gmail.com,
 Benjamin.Cheatham@amd.com, rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de
References: <20241113215429.3177981-1-terry.bowman@amd.com>
 <20241113215429.3177981-6-terry.bowman@amd.com>
 <20241127170327.00000374@huawei.com>
Content-Language: en-US
In-Reply-To: <20241127170327.00000374@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::6) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|PH8PR12MB6723:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e7b1104-f265-4486-9cd3-08dd0f224539
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UUZiVVpGSzA5d1lXNWdSclBZTkxYRnc4YnhyQ2tUVVdXNXVZd0tObVJmZTlX?=
 =?utf-8?B?dUZCTHJabkpLeFVOVWZTNHpuZW5abXFVWkdYQ0xQRklISU1qVjVKNzF6TnNX?=
 =?utf-8?B?aW04dGNWWjFtVHBJQk5pWWM4bWx5bWt2UDFDOFE4VUY2cWxlbzRpbDVXS2ZD?=
 =?utf-8?B?aEIxdysyYkVRVEgxQTF1ZnJaYXJtRzd4NGpYSjkyai9MRzAvdlltT2J2RUxr?=
 =?utf-8?B?cHhlLzBwSFZDRkZBbjh6T2NTbEx3cFlFeWFoZmtXODM2Z21ZdUl2RkhncUQ4?=
 =?utf-8?B?NmlzNWhZdFlWU0licGFlcWlRTE9lanJDZEwzUGJKREc2VTh2aitYTytWN0Rn?=
 =?utf-8?B?NzdwV3lNR0xaOTR1VlpHdlIzbnJod242bkFLUWI5NnpLOUdYUXhNajcvM3Bq?=
 =?utf-8?B?VkNMeTc1SDFpa0RwQUxySkJzMGhuTXQzS2l2bHBFVk5iOGdtVjRRZldQZWs3?=
 =?utf-8?B?WDVncUR2YnE0U2lUa3pUZ1pDRlk1eDJpT2ZVNDgzc0M2V0Q5czcwck1MWGpJ?=
 =?utf-8?B?TEl6SnVJMnRPdGk5UnNQWnJNZmJ5cmMxRlh4WmpKZjV3S3ZzYVVZdDR3dWN1?=
 =?utf-8?B?VFQ1UGlVY3IwajBVeDcyTDN5V0RkVDBQdDluRGNFYmNONVVUQW5PYzhPZkF5?=
 =?utf-8?B?RVlvYXhPZHhOL3RNY1I2MW9xSFRTdTZyMDYvYXRCYXVWTDg3WFkvL3dYenht?=
 =?utf-8?B?UEc1YllPOTR6S2tiWlp0U245UldnMjBUVzFHZkxqbG5GUENNcFhMRHFCMjNj?=
 =?utf-8?B?bm5USUFXYlpYd3owL2tNbUxlY25qQU1JamwrbVJXQSswQi91cmk0QUtabXdq?=
 =?utf-8?B?NnZPUkFCUHBRcldXdGdJS24xRWtRWjNZM2ZCd0hrZzZjRTlJMVBLemlFQnEr?=
 =?utf-8?B?VkJxdWF1WUVpZW05NFVNVmhra2FxL0M5SkVZT2d1MU9GYmkrY1RPWmlUL25y?=
 =?utf-8?B?R0R5VzNwdm1uaXBiT3Q0TXM1dm1iZkZCVFhtSVJmU0IrWVFhaUh1ODJtVWNI?=
 =?utf-8?B?dHlNcDZ1VHh1cjBVUkVXQnp4amRaS2ttVkMreVFaMUwydUdhVmNaNTFHVXpa?=
 =?utf-8?B?UFFRWGFoaDhSM0RiNnBwVVpJYmRSdFh0QkttcW4wODBBWmh2b2JLNWw0cFh1?=
 =?utf-8?B?a01kRkI3UG1ZRnhUcnZ0MmR5QjZOOThHUHJINmtVaXljcTd0aTg2VE1TUTV3?=
 =?utf-8?B?Q1VsSG8zTjF1aVpPWS9MNXZENGlIVFJXK2F1WmtFM0hjVEZoV0FMZzdIU2Y5?=
 =?utf-8?B?QTd2NHBaT0Q2bUJIaGZIZVc0U2F3RC8rWWNOSzh5VnExbVpRbDJqcjNiQWZ0?=
 =?utf-8?B?cmVZSE43RU9CM0JmTHgwam9PUXRENndpWjhVakNLOFUrNEVoUUljUDNkalNE?=
 =?utf-8?B?NXpUTUQrVkIxeUI4ZERWT3hMRjRpZGtFVGFGQ2M5eDBYNXJJcXg3Y3dVZFpo?=
 =?utf-8?B?clNPL0d6SlVFY3FkYm9MUmpTY2NzalRRNUM2TU1nQWJTdDgzUzIyU0x1eVF3?=
 =?utf-8?B?RUJOcmZkYjhOSTNLZzJMUFcvWkdlcUh0VDNWZWRFOTd6VDJVaUVsd05xalZB?=
 =?utf-8?B?SGlXaWp4YWxNaDR2NXBqemR3cnhzUzhodHVHa3RwQTc3SGxJTFU5VGJqbnFP?=
 =?utf-8?B?bFNSSFNFaDZDeDZ4dERpaVl5QnRoYWdWQ0Z5SkU0Skc4Y1l1Ryt4My9WdnZR?=
 =?utf-8?B?N1BEVUxCbXZKc2YrSmExaWtoWGdtbVRyYXpQL2c2SDlBZ1dLMnBkeUVva0lM?=
 =?utf-8?B?d2hPMnpXYy9iWnRxRmVscS9GeWlRZXh1Y2VyYVZraHhHRnRRdFNaUjNSK3hG?=
 =?utf-8?B?S0xJSDNvem9yWEtBTmhKQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?enhJMVRKekovYTNKTTBqQmw2Q1Vacm9taVZDNFVBaTRKMGloTjA5Z1RZREll?=
 =?utf-8?B?WUJ0ZzMrbDFBK0ZYb2hNT09OMVhpazl3ZVFHTjRJTVJiRkdZeFQ2VmRIenpG?=
 =?utf-8?B?SStSbkplQTJjdzRTbC9iUXpucHZLUkRzWXpwa2crWnpCMjZ0QlMzQ29xbGxX?=
 =?utf-8?B?aldTaWVSaWlwTm1qQ1gweWhNbWZMWGR1Ump6aHBRSUpmK2lwL1k5cE9GWFg3?=
 =?utf-8?B?dDNNMFY0NzBSVzNHdVBHczVyREFtYmg2ODVVSHJTS2FOeHM0Y0RLSSsrMUxK?=
 =?utf-8?B?ZW16MG1UM0NVdkhkMkFQcGxYZ2llMEZNRk1PaCtHNERLVkk3bVdmbVp3aGFC?=
 =?utf-8?B?T3k4YkhLYXE5ZHp5dE01NW1hSGlwS0w2YzRpS00wMG13VGltZkY4Zk8zRDU0?=
 =?utf-8?B?dS9mSllRQ0lCWW5tamttZGYzUHhsSUZOUWxST3ZDZXREUG5kaUlOQ0N5czE5?=
 =?utf-8?B?dS9IRHV4Z2JmeitPb3I2NXdURUtuSW5CVitWUVo2THNZVHB6emoxeTNVWkZr?=
 =?utf-8?B?eW5TK3pZSzUrcUxESWx0Yi8xODIxTUR2SWdWeW5vcmZwTTUxeXpWUzU5TndP?=
 =?utf-8?B?KzhBRnZvTUp5TFZSTElFR3JXWGg0YmltaGxlZzNaeDduRDhQSjd2djg3UEhu?=
 =?utf-8?B?NkdtaHhxWlh4Y3VaMmU5NmdCUmlGcmpFRE4zNldYdFBnd3VXMlk0RWt3U09P?=
 =?utf-8?B?aVNRSno5RmtJcjJxR05ZSTdxTkdLTldSY21PZ05FNGJVcXBVSWxOOHFISUI4?=
 =?utf-8?B?b2hkMkVzNTAzdy9aYlRNSmxNS0E2VE9keUJNQ1NrcHFPdWlvSEtyRXB1WjBW?=
 =?utf-8?B?clJuL21LY1JqVGhvTVZNWkhhMytBdEJHb1N0QXBPMXZuRU9wQTQvWk9zOUJD?=
 =?utf-8?B?VThSTDFMek55aEpxOTZkYTNCTGZKck9qYTBTbjg5ZnNQMlRBNUc4MDJibjF6?=
 =?utf-8?B?ZzdyZ3d3Vkd4ZFl5Y2QzL3lqTjdHWTRlZ21ZSWpZRTlWYzE3UFR3VllFeGlm?=
 =?utf-8?B?U3B6VlkvRE1OU0R5K1FnTEl3ck9FbzZKOEJGV1luSkVNZFF1cDg0K29ZZHE3?=
 =?utf-8?B?UDVkUmZDTVpDUjZZS2JPQ0djNzZIeHgxdEdheG5qa3FYMTI1N1piNCtyb2tx?=
 =?utf-8?B?S2ZDOHJPMWVkeXZEOEQwUjZDSlIyK2hteXVCZFFDMjIveDFTMGRaQkluL0JZ?=
 =?utf-8?B?bS85NFZHVWttcHhPb1EyMUVjNTlmN25HRzFKSUgwSmhGYU9JR1ErYVY3Qm4z?=
 =?utf-8?B?c2ZFa1FjRHgzTEM2UDFiM2tGelNBdmlaUEhBRnpteGh5MWJRbkpNdzZ0WWR2?=
 =?utf-8?B?Q2JoSHptZVUreFR5WnpSZjJvejNvb3I3RUpMR0greVFEZ0V2RlYwUHdRRUNH?=
 =?utf-8?B?WTJ3aVU4T0lFcTNEa05UQm9yT3JLVXdNYUYrU3F6VXQ5V0FqQ01FM3B3N09R?=
 =?utf-8?B?VzA2OVBnTUhEZCtZQnlpbVgra3JTRzJBcThkNjdqR0ljSGRSWHFuTHBVbDJW?=
 =?utf-8?B?Y0xMSjA4bDlHQnpkVGFsNzd4cDZWbnBZNnZ2TVIxM3hUbEVVNC9tczlzdG84?=
 =?utf-8?B?VHVLSHhRd1NXakxrVTE0dXVWUVhIZFMzdWs2RXFEVkFESXRzUlZGbVZ0QkpN?=
 =?utf-8?B?ZXdSY2Z1RU1rNmVtR3l0ck5MdHpHWGZtNHRGWUZhSTRNUHBhRnplM1g5d2dM?=
 =?utf-8?B?S2p6c0pBeHR1akd3NmJrR1IrUzhQdnpYNmwwdU80ZEg3aDZtYklaR1M0MVcr?=
 =?utf-8?B?Rlo1djBwZzBidnJBaVc0L3dtU2xXd2l2dWJRY3QrYTlOUlQwdTFTNnZSMlRQ?=
 =?utf-8?B?alJPanAyWXdTaXpwVTNMYmdOUm9pVE1Zc2FYdHJHQ3ZvZTF2blRVaktoZ3ln?=
 =?utf-8?B?a09EazZsUjFINnZ2RWR3bnhBOWFQd2MyWEZyZU0rTnV1d0dCbk1TT0Q0V0k0?=
 =?utf-8?B?Ulp4eldhc3ladkdtZzNXNWNPSXpoQndkOGhleElTRGtSMXVXQ0k5eU9TcGo0?=
 =?utf-8?B?Vis4alBmY204U3d1SDNqUENpUVE4ampHSGxscytreTM0cGNDb083Ny9oZnp1?=
 =?utf-8?B?SE12b2hZSk9xZHFoOWg4VUZTMittcXlVclo1M3pWdmUzNFZ5TGRMaHZQZmlj?=
 =?utf-8?Q?wyRZ1MFAP2qd17yrAt44hznTV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e7b1104-f265-4486-9cd3-08dd0f224539
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 20:30:02.3225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k/M9GqEqYGuM/hbIyIul53ZPWo1UXEQ78eKRHkVHblpc+ae9pc+mTURejtajiY+Xh7f1fLQcfkfK7bKucSoODg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6723



On 11/27/2024 11:03 AM, Jonathan Cameron wrote:
> On Wed, 13 Nov 2024 15:54:19 -0600
> Terry Bowman <terry.bowman@amd.com> wrote:
>
>> The AER service driver supports handling downstream port protocol errors in
>> restricted CXL host (RCH) mode also known as CXL1.1. It needs the same
>> functionality for CXL PCIe ports operating in virtual hierarchy (VH)
>> mode.[1]
>>
>> CXL and PCIe protocol error handling have different requirements that
>> necessitate a separate handling path. The AER service driver may try to
>> recover PCIe uncorrectable non-fatal errors (UCE). The same recovery is not
>> suitable for CXL PCIe port devices because of potential for system memory
>> corruption. Instead, CXL protocol error handling must use a kernel panic
>> in the case of a fatal or non-fatal UCE. The AER driver's PCIe error
>> handling does not panic the kernel in response to a UCE.
>>
>> Introduce a separate path for CXL protocol error handling in the AER
>> service driver. This will allow CXL protocol errors to use CXL specific
>> handling instead of PCIe handling. Add the CXL specific changes without
>> affecting or adding functionality in the PCIe handling.
>>
>> Make this update alongside the existing downstream port RCH error handling
>> logic, extending support to CXL PCIe ports in VH mode.
>>
>> is_internal_error() is currently limited by CONFIG_PCIEAER_CXL kernel
>> config. Update is_internal_error()'s function declaration such that it is
>> always available regardless if CONFIG_PCIEAER_CXL kernel config is enabled
>> or disabled.
>>
>> The uncorrectable error (UCE) handling will be added in a future patch.
>>
>> [1] CXL 3.1 Spec, 12.2.2 CXL Root Ports, Downstream Switch Ports, and
>> Upstream Switch Ports
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> I took another look and so a question inline.
>
> Jonathan
>
>>  static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>>  {
>>  	struct aer_err_info *info = (struct aer_err_info *)data;
>> @@ -1033,14 +1032,23 @@ static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>>  
>>  static void cxl_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>>  {
>> -	/*
>> -	 * Internal errors of an RCEC indicate an AER error in an
>> -	 * RCH's downstream port. Check and handle them in the CXL.mem
>> -	 * device driver.
>> -	 */
>> -	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
>> -	    is_internal_error(info))
>> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)
>>  		pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
>> +
>> +	if (info->severity == AER_CORRECTABLE) {
>> +		struct pci_driver *pdrv = dev->driver;
>> +		int aer = dev->aer_cap;
>> +
>> +		if (aer)
> How do we get here with no aer?
>
> On a PCIe device AER is optional, but not I think on a CXL device
> (I can't find the text but there is a change log entry that says
> to clarify that it is required for CXL devices)
>
> Maybe the optionality is why the PCIe code has this check.
>
> Anyhow, I don't really mind keeping it, was just curious.

Hi Jonathan,

I agree the check can be removed because AER is required for all CXL devices.[1]

[1] - CXL specification v3.1 - Section 3.1.4 'Optional PCIe Features Required for CXL'

Regards,
Terry



