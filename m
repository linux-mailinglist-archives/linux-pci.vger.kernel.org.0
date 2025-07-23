Return-Path: <linux-pci+bounces-32787-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3C1B0EF92
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 12:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 104EF562DD5
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 10:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A58280A5E;
	Wed, 23 Jul 2025 10:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HPgbOEzC"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BD326C391;
	Wed, 23 Jul 2025 10:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753265824; cv=fail; b=OD93MWqAIt7W4mC+WAKlEkcglyia2p0/Yp092bKK+P78hsqgvgVmjNgbvom4sfRBktj+ahDOUw6Bi9D5bg75GUwid59ABEnAzBgzh3lwt8sVBH+uYw7RrO1dxMMulF1xu22Tn0Zfg9pHlHSAN9ys3xLi9x3RMosTE0EBExMNkrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753265824; c=relaxed/simple;
	bh=T4YCCjPQv6BE07x4Pb7xLo+2SzOHuJGHP6C7iRB7I40=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u9Q/hyg7bpCJzRKbaYgiSCLrsKmXyoYRLQCgZPwHUrznQkNNjLlJL3E7ZKOJX6D2GkMmRggngdmjuqSVh2nA0yQ76Unv0yy9D/pa2L4vRB3xOpyd8SmW2NmVTVPXDM4AfTuIlh9PihsNKPasm4G095oU+tiopPgwNTMCm0PdiPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HPgbOEzC; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xiiwPi2zquswvEGJxgIovY1N7oBgUhC+J/LkuLY9XSToQdFf+UOk9o7rhqByexsXLjkMBeeVa7+DOrG+uvWx0WlT1//TNlX5XZ3IwOEBDCqOriRSKdnfxchA0DRUXIMbC2YTBAOq7kHomdoIX0wgm/04zvje+vqv663J7cG78PvU3Q5RRzOLGrrCJ6VkeWOPP5Eew4rqVMPc6T37ZoQaY7nm3L+/li9Kox0gE8vi2GD3UBBKT8SPmQI9+gXZo+sgWBIpc0aZ1WMUTWJmnPMjd3hM1Jt/IRCWUGLTsPKCmAeqQWsxqedqJJH0W8RkY0wbmu66u/wAyomIvOwQJvqAFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EHQqioVlb8nJ466RE7Fo6xV35t7D/pi475OuoAEfUTs=;
 b=p6GVwkMsKxrW+TpiAxkz+u/Sw+PizzDGuqSxPfKy6dIp4zuBiQ1lgZnwZJaPIDZVSUlwadaRozPT806k4ZPneaE5QAHbEOs5KBt2AxcDNoVjoT+oRmQ4h2mBy78s30ZsoI+M8W91f9qWz0MU4XPKEJvPTkH+JyrvndcNVWX3U2I8g32klYd9eDWlbMabWbw+pRo3mFwQcBh8pfoq6J2QPHrvrTd+I2ieqQ5YDbxTI9rQhXGyN2I8F7q3oe8u8PDpu8IqbOHkxAuF6h7PW2RLDadmzMKk7LhpcGiX6Fj6LfCg4HWUrF6blw+xkGq7Sbn/xD85OaG2nwImocaYQ2yNxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHQqioVlb8nJ466RE7Fo6xV35t7D/pi475OuoAEfUTs=;
 b=HPgbOEzCoIoc3Ks9dpXiLeSiDp21cUhDmawq5tQyg2O7dh2r1KTnKhp48PtbVpPpWHPpHFxoAwHz25YkOk1EIzaz2N44q45FttqHwu6/MBz3DrUS3JrUVk2EDNpQT9wao8Gw1zQ0MHrOUbisomZhKjh2r1QadKdxoHfU1Q7hpuY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14)
 by IA1PR12MB6116.namprd12.prod.outlook.com (2603:10b6:208:3e8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Wed, 23 Jul
 2025 10:17:00 +0000
Received: from PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421]) by PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421%4]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 10:17:00 +0000
Message-ID: <eda6c473-dde8-4a56-8422-278971fa970f@amd.com>
Date: Wed, 23 Jul 2025 15:46:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] PCI: Add PCI vendor ID for ASMedia USB4 devices
To: Bjorn Helgaas <helgaas@kernel.org>, Chloe_Chen@asmedia.com.tw
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, andreas.noever@gmail.com,
 michael.jamet@intel.com, westeri@kernel.org, YehezkelShB@gmail.com,
 bhelgaas@google.com, Sanath.S@amd.com
References: <20250722191417.GA2809926@bhelgaas>
Content-Language: en-US
From: "Rangoju, Raju" <raju.rangoju@amd.com>
In-Reply-To: <20250722191417.GA2809926@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0052.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:270::17) To PH7PR12MB6395.namprd12.prod.outlook.com
 (2603:10b6:510:1fd::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6395:EE_|IA1PR12MB6116:EE_
X-MS-Office365-Filtering-Correlation-Id: 475f1675-5a36-4b56-d87b-08ddc9d20f84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RW5aRW9vRGU5N3BubFFncnFVcU1NdzFhSzAvYU1QQjBhcFlYVGVBdVhULzlV?=
 =?utf-8?B?SFA5Wk9NWmNYdWp1YkYzdFJDYm01OFdIS3RCM3lpdk8zbnc1U1hjbkZPcW9z?=
 =?utf-8?B?WVhnVWdpemorNHR3MUl3VDRBUXlDKzRKVjl6Rk9nSCt3V3RxZG1QTzZFbUlt?=
 =?utf-8?B?T1dNU3NoT3pSTUYwaHpMSUZIR3FWWmZBMDdmQ2VXZTRtYTl4TCttbDVaZGxX?=
 =?utf-8?B?QmRXVnlmNVpjVlptRzNxNHE5TU14RUxXRDBVdlRyT3ZzbGszTXk2NHhwa2F4?=
 =?utf-8?B?L2k2U2xla2lvSG9uY05Ta0QwVnJNU3d2bDdQaldhOEFOYnlOMnVuSjB1eTRN?=
 =?utf-8?B?NDZ2cFdtY2NHQ3NjRGdqTklLZlFWQkhrMjRXY0N5TDR5RHU5S1JQNjJudWdI?=
 =?utf-8?B?dU1MS3JieVBYSFVmWUd3TXFGeU8ya3dmTEE1R2VuaUM1TSsxLy9lM2FLd3Uv?=
 =?utf-8?B?UjdGYVNaVkkzSGo1ZlU2ZzdaelUxY25CMExINTZZU1B0S3B6YkVSWkdOVG5G?=
 =?utf-8?B?Y2lkeWpHMjQ1eHhpZUZ5b2ttcnhlRkhWSzNPeHZyZmpySFdra2pjckVaZ0tj?=
 =?utf-8?B?WGI2blZtV2dONUhjYklRbDVXNjF5djN4ZGk5R2xDWDBwMGM0OWozTVhsWkZq?=
 =?utf-8?B?MDFpMk9XN0MreTVPeUxlRnZSM1JSYWxRWEdidmRXSmd6NjBVMnFPM2c3YU1I?=
 =?utf-8?B?SlpVTnJXY1RxK3NsWkY1aE1MVndJOVhMeWg0SVVVV2FESXd0c1Z6MFNFcEtl?=
 =?utf-8?B?clpVTkxYdEFNbEFuWWdYUGZ2bUNxN2paZjF2UUIrMEVkMnlRbEJHeW8vSXpm?=
 =?utf-8?B?R21DSnV6aUhESmdNVzM2ZkwwNmlZQzdLSmZtOFpOZHI4OUg5ZGFCY0svbXJ0?=
 =?utf-8?B?MEp6Uk1taDBIWlhIbWxpUzM0MlVWUUdUY1ZVWm9WNkNnTmlZcXJ3V2dQeXNJ?=
 =?utf-8?B?NHUzYVRKVitMUGNubDltczBseDFjVzRVdmROaGhwb3R2RitWSmY0cGg5QmtZ?=
 =?utf-8?B?ZitEb1BOeldTZWFRbk8wQi9SS2N0SC80UUpUZTVSYnhzNWZJM3EwS0k1QkE3?=
 =?utf-8?B?YjJSZ1ZHS1NHRXYvbFZHOGNSMzV3YjVHVjQwMDd6a0wzMHpJa3oxbGJpbE9X?=
 =?utf-8?B?WFhlZGZrTWlaWDhXN0FBcmhhTm5SS2NCSWhyQVJ6R1N1NEF4bGpSQTVORWx6?=
 =?utf-8?B?OHhGckNkSUxRMmQxNnBibW1zTDl4NXR4eWhVeXM4RWl6Tkk5L1dQQnlyaE40?=
 =?utf-8?B?L3VQb0xWWXQxbWxsbC8reGhlNHhxN05zT2Z4OGFieGJHU240Wk95bE40bFZa?=
 =?utf-8?B?Q09oVEtIcWx0M0VCeEwvdDNUbGxtV2dPdE93OHE0SXJXSW5NYllvbkRkV21Y?=
 =?utf-8?B?clBkVDg4MC91cVhKamcyMjdrN2RaN0hhMjNMbDg4Rkc3UWM0QjBKbFltaThy?=
 =?utf-8?B?Y3paVGlwQkhaQ3R6c0FiWE9VTlduN3JTU3FES3pZU3puaDk1bElnL1BpY0Vu?=
 =?utf-8?B?R2lJR0lFN3Z3WEJXWjEvb2dhY200OUJLUEJtckNVVnZldTlTTmNRQmFIdjNx?=
 =?utf-8?B?a2lWcUxSOVE5WWFnc0Z4ZjBJdGV3UWZ4cTJicmRiNGhGc29qWjNwdDhyVGVM?=
 =?utf-8?B?aGRMeE1jWk5jaVZtbERHQnZ4WUVRSG1ibjFWalI1eWR5VUlYZCtET0lVMUtO?=
 =?utf-8?B?N2piV25weVZZMVo5ZjUzbGYxeEpEVUFwNjU4S1FpMFNjR0Z6MlpFcXc5K01n?=
 =?utf-8?B?bTliQmNGK0JRY1NBeHdWbFZqSHB1SzlNVkNzT1JGemxuVzE2R3oya0paUmZ4?=
 =?utf-8?B?RGFMV28rc2NhV2JNYnJJeGRHMCt0eTBaTkRsWGtWb25Sb1pFY2pDREY4bnhw?=
 =?utf-8?B?S3BJQjA1VFBiUHR2NHlRaktPSEc3QWJraW9mMEs2NkJkVHZEeUpuRUo4TWEv?=
 =?utf-8?Q?d4waJZFXgxs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6395.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3MvM1VwRTkyU1AxcEM5SnQ4VEpVZ0swaGdLaHg1RmdvdnlFcGlMOUI4b1A2?=
 =?utf-8?B?U0JaTVJ4Tm1GRG4vQUFGVXNaMUxYVXZHbTk2UlY4NzcvR3pCNXBsc0k3MVFO?=
 =?utf-8?B?N1ZaT2ltcU52Sm41NHZUMmJlOS9PSTR2MjU3WFZuUXdHclo0ZXVsZ3VrbUpT?=
 =?utf-8?B?SGZVZ0g5NmNCQXRPa0dDenNSVGdtUjFSYVB1a0JpSTBvMmJ0YUsvTVYxRDhq?=
 =?utf-8?B?SVJMOFA5ZVV3VXZLZEhhZ0tOcjBGOWZWbjZqLzg4TWNYYlFQY0pRT0t2TjBB?=
 =?utf-8?B?a1FnRlNBMFY0V1NPaW1naURJVm5YRW1GY3h6Q3d4b1pBUTFFbWVEZEpKakpk?=
 =?utf-8?B?VTZDc25jZ0J3Vm41bzVvR3A2VVV6UE5vLzYrYnZPL2R1Zy9xVzVBSGh1R3RD?=
 =?utf-8?B?bytUaFZJUkRYSnFUNlhFSHlZVlprNUw2Zy85cVVwS2RnclRHMnJGSDR4VUpB?=
 =?utf-8?B?OWk5R0xCZVRlQTFHUG56bjVxVXFHWldtSndZVjZvdCtCZ2FIalpuYmlyYTIy?=
 =?utf-8?B?Z21xcWhHTzZxRGp6eXg3MklDVG9ibUpLTHhpU0xyVEFqWE1ZYlNWME9hNFNl?=
 =?utf-8?B?TC81V2NVYXBWSWNxMjRqbTExdHBLY3pTd0MxQmpCZGluTitDUWxMbGI3MDdU?=
 =?utf-8?B?bXdBRW1ZWXRvRXIvWkl1c1ZrTG43Z2tJYmlEMWJuKy9IWXYveUpHVUNqUzQ3?=
 =?utf-8?B?bTZYakJKUUgxWkxRZWJzWk5Mb0JHTDFNK0pJNTJScGJYdkZwVUQyWU81SWlI?=
 =?utf-8?B?ZkdQVmNVY0FUR2QyVk82dmFodWUwci9vdnFqb2UvY05XbWxWTXJISmF0dFl0?=
 =?utf-8?B?aWpYeTQ1TGwzeGhzTTBLSXVYcTBiUGhnaVpYVGJoaXBHVHF3VStPSmwxS2xn?=
 =?utf-8?B?QVJTQmVUWm5EczdCL2Z1QjJEUjJSR2pzT0p1Qk9pQzBhVkJiM2g5TmZhUHJr?=
 =?utf-8?B?c1Q5MXpQWXpKWUlkQVdLamR4R2pGM0NUYVk3cW8wQktjL2xDTjROMGt6eVJP?=
 =?utf-8?B?QmFsTkFCeVV2WTM2MU80c3JGNWFxb0ZzL3BxTWMyUWNIT1drQUh2dlNiVHhI?=
 =?utf-8?B?cjJoUTRnUjlmREpMNE1BRHlHTzVRMlhhSnBnWmp4N0pyNjR6T1d3WlhwQ25t?=
 =?utf-8?B?L3Nlc3EyNXpIb3h3QzVuT0FHYVBrc2FvRFBRVmFGMk15KzV3eDJVYkdHK2Vo?=
 =?utf-8?B?VUNGajBQRXhrc1JDbklNTllVNXRlVEppNlA1UG5HejlLZ0cyQzQyTEE3a2Mz?=
 =?utf-8?B?Y2h6NkY3N2tmTWg2RGlSZDNwNERCVC9oQ3FFSnRnbVB3U0ZoZmkybm1tYlFC?=
 =?utf-8?B?UTdDaWxzTzluaUtJSUhJZjRFYkJmbkdNTUtVK3g1UTlaL2dqYThkcTY5T2hq?=
 =?utf-8?B?ZEI5L2JsdXR5cGMvSzNPWlJlRUFEWEk0VVYzcVlZN2dNdFRsVU16NWZidnZC?=
 =?utf-8?B?QktGMElycWtNaHpKMjJXL2g1OTZGVkdGclMzNmJsM1huaWJFMGVlem5EcEo4?=
 =?utf-8?B?UDk3Qkc4TmMxNW9KcWZFQ2hJZHc4WUFlMTJwRHo4cWc4Y2ZVbHVySzcxS2p2?=
 =?utf-8?B?akNBUU10UWZrek5LbWtsemt4Qk1aRHhnL1RrSjMrMDdPeVJSUHRRRmtWeHhn?=
 =?utf-8?B?NzViYlIwMTBYbVpIN1RzaVp6dldndXNMWUFtT2I2aW1hZXdvdGJiTXVIVldl?=
 =?utf-8?B?aDBiODl5RnRoV0pKdEZ4NFJsWnFmTU00S3NSa3poSVI5c3I5MkRZN2xrcmVy?=
 =?utf-8?B?SjJBdG93YTNBWEJhc3ZPZVgyTXpTM2R5R0gwUFFiT3hoRXlkWDhNVkN3WU9k?=
 =?utf-8?B?RzV5cTd4YmgvODFpSUxvQkRacUZJaDU0ZDlMR1BNRHZ6UHpXQXNRYUJubG9q?=
 =?utf-8?B?NzJGbnFlcFhCYXllTnBycmZmWHRQRUQxYk5Pbm1sODVPdWIrMjBUanlVTmo0?=
 =?utf-8?B?c3MxZ3FDaW5KbjR1Mm5sdEVFdVpwSThZU1FuaExCMHlvMGxqU096ZTY5RkJF?=
 =?utf-8?B?cGxVTER6OS9yRzlOSHNwVUM1Qi9ONGhKWFMrejcvSlZ5cHB0dTZoeGhKeFBv?=
 =?utf-8?B?c2RnWEN3Y0tkTzJkcHNpNDBnejNkc1ViWHRtZ3lOYjBlQ3BOdVlkdHEvQm1n?=
 =?utf-8?Q?euCrSFZlCtSyGONn4CiUCB/Or?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 475f1675-5a36-4b56-d87b-08ddc9d20f84
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6395.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 10:17:00.1282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OABUxmtkA+9k+MzTSbroC87sQEmNziLMBb2P2wgrOMP698/VaT5JIguCHeMfytfS9BMGS9zHXSmSllPSWyKtjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6116



On 7/23/2025 12:44 AM, Bjorn Helgaas wrote:
> On Tue, Jul 22, 2025 at 11:20:25PM +0530, Raju Rangoju wrote:
>> Add a new PCI vendor ID (PCI_VENDOR_ID_ASMEDIA_USB4) for ASMedia
>> USB4 devices. This change enables proper identification and support
>> for ASMedia USB4 hardware in the kernel.
>>
>> Co-developed-by: Sanath S <Sanath.S@amd.com>
>> Signed-off-by: Sanath S <Sanath.S@amd.com>
>> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
>> ---
>>   include/linux/pci_ids.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
>> index e2d71b6fdd84..3397954ce96e 100644
>> --- a/include/linux/pci_ids.h
>> +++ b/include/linux/pci_ids.h
>> @@ -2592,6 +2592,7 @@
>>   #define PCI_SUBDEVICE_ID_QEMU            0x1100
>>   
>>   #define PCI_VENDOR_ID_ASMEDIA		0x1b21
>> +#define PCI_VENDOR_ID_ASMEDIA_USB4	0x174C
>>   
>>   #define PCI_VENDOR_ID_REDHAT		0x1b36
> 
> Sort by Vendor ID value (not the name), per the comment at the top.
> 
> Use lower-case hex to match style (not universally observed, but
> close).

Sure Bjorn, I'll address these changes in v2.

> 
> Per https://pcisig.com/membership/member-companies, 0x174c is not
> reserved, although the same is true for 0x1b21 and many other Vendor
> IDs.  Do you know the history of 0x174c and 0x1b21, or why these don't
> show up as reserved?

Chloe_Chen@asmedia.com.tw, could you please comment here?

> 
> With these,
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Bjorn


