Return-Path: <linux-pci+bounces-27586-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86159AB3B4C
	for <lists+linux-pci@lfdr.de>; Mon, 12 May 2025 16:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 041197A3693
	for <lists+linux-pci@lfdr.de>; Mon, 12 May 2025 14:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA58619C569;
	Mon, 12 May 2025 14:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GEhXKQ5O"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80E322A4E0;
	Mon, 12 May 2025 14:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747061314; cv=fail; b=Ga8hilWhN42d9XvT2vPDbULTesKjSmDswv2H2kaezYb7dq0ONgrU/Xruz6sXVIsKtmq3xcxWoJb96HzrBkcRq6/HXsg03L2cVhybr9R1+uyAKnIJKoFCgtgopkKjI1ahGS8otR77p8EjofW68LuTNqzhNWZ3NmbMwcIX80ARDrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747061314; c=relaxed/simple;
	bh=HnZSvlZn6mqbgA9rjUYQ1iSiTsre5uXBE+mNPXJH5g4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V/iNFjL0SEzJltI8C8T+0qRR6apeYbD3jNmxPnSLUSi6rhVaqfnPGsMqtbYeASnX/FqHzZIMmkN96zpzICmCDMTzymCa83XwUENpq7D2wVbshmZvrmtKDlTVDFwvYIbEQT/X9HwjjT/yscpQUGhbaCEiKR7Q8WNXROiaKyNQDsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GEhXKQ5O; arc=fail smtp.client-ip=40.107.93.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xXSOFFiVvqLOgMrXoMrLEJ0Oz/wScxH++RiFtz1c95mH1LAoucc3QPl67ROUPSU2SksUy+x0lRYhsPqfqJiXc3TMKZsUJx2EkWJ7/nAd/8h4i2sxuyjcvuMgtwrYoqqAoMky0a70SruGGL3kw+LTf7xAPcNED8D04LyuZShyz6bNwsU77ms2LUD8LCwQIP6D+hovsLB+n9d/5+ZdCBonwqmSnCytgwtkGhiFzya/eCb51SH7A/kpJQ9d/GVz8zGHB2X04VUHwt5ZxGiCbl5JrTeTkfEFCVHcW/uWN0lMxMhYYqPVKpYpfJqQ7/JjhtGMz1tqUxq2sZwky44Qfr1K/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4QFxREBgFeLuqizlfUd0ID/manMGUydBjjdQtqGG6Oo=;
 b=uDH4B5FGGdNeyOH/MScOkutx7YaEILyxAuL27CNHw7W9qOvChdiSlyfac1WVkkL49KO2x0oqd64Fu/XjgbQkBQy42Htw1g0kfcEGj82/qvzy6YPg7Zer6esHqn8dwl7phok1ZMjpJhMr00PXpfEbXU/x6Jzl+LzwSQvQEjBIVdhUe7QGz8+47abLWJNjzYQJgcd3dIhFeBVvFETXAPxG9le+D3eqXcm9SP6y1hdn+00IraSeOZJESvdOqz1Q+VEBERKJb4NAFgdwOqGL9SJnQiMA2vFLadmKfdWN8lxIqWKbEKn/FkMujHuEY5n+Kep9+kW/Uxk+CpIr0tsjtTCBjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4QFxREBgFeLuqizlfUd0ID/manMGUydBjjdQtqGG6Oo=;
 b=GEhXKQ5OwaNpvB3NJY1Oo1PWwhJgCmGSZsM05t3mRb5UJ1P+ZczE1qig+eGgyKqRT2VOeHijH3D1VAh+1mIOnYPSii1RMGE4jz7Vcdv072PIDNqtGb/wqCp/hAdNZkI7HxqqPGkPGRxyw5wXnMFFn5+nvwnKpw+rvgFCcWu7Bjk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 MN0PR12MB6272.namprd12.prod.outlook.com (2603:10b6:208:3c0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Mon, 12 May
 2025 14:48:28 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%7]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 14:48:28 +0000
Message-ID: <ac699592-b64f-44ec-9e0a-8ad232f809c7@amd.com>
Date: Mon, 12 May 2025 09:47:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 07/16] cxl/pci: Move existing CXL RAS initialization to
 CXL's cxl_port driver
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
 ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com
References: <20250327014717.2988633-1-terry.bowman@amd.com>
 <20250327014717.2988633-8-terry.bowman@amd.com>
 <20250417111857.0000224c@huawei.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20250417111857.0000224c@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7P220CA0054.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:8:224::28) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|MN0PR12MB6272:EE_
X-MS-Office365-Filtering-Correlation-Id: 574d3af2-f680-4e0b-f6b7-08dd91640e18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UTNIVndzUUp0N3ZIbW1aaENFVW9peHF1UGJiOEtCMkpvcjRyWEcwU09uRjdM?=
 =?utf-8?B?MUFwMzlhemJ1MzU0MnZyeWtYcnM3enJnSTlOTzdJbGFyZ1QzazZBWnAwV2k2?=
 =?utf-8?B?UE13aHFJS2ZvZ1ZDc3lGOWhHWGFSclhKZXNCZXlEZFJuWmQ1SCt4Rk9Rcmcr?=
 =?utf-8?B?YktoMTB1ZmVkdWoycEd2WjBCY0hFQTVXTllqeENBK3J1aUk2UDVVY0hFaGpo?=
 =?utf-8?B?aVg2Q1I4dnhpak5qemNlblJrTDR5SVl2YkFmVXA5UzBNdWRlTTIvN0NEeURD?=
 =?utf-8?B?ODUzTk85eXFjSEl4UlR2a0ZzK1lRbExzcko2aEZzNWp1dEVxdFdsVkZsaDdH?=
 =?utf-8?B?cnVGbWRFdkk3WXRCcnVoWlZ3NzlFK1J6anNSUk9EN1VwYnlmajhuZkZwc09q?=
 =?utf-8?B?WHBnblBjNm04aFJIRlB2K2NRb3kvOWVwV1JienI5R2F0cEQ3NVNHSEFKSERQ?=
 =?utf-8?B?OFk0clRMNGYzNnBUTkg1WVZRRy8ya2hGVTJwRlpSSm9jNTFsSTNMSCtoSTZY?=
 =?utf-8?B?RzZHSUUwZHZaUWdWakVGdU5lb2QzMXUzMXRpTUI1NE50TEwwYXR0STVpY3NB?=
 =?utf-8?B?TnRZTldhTWRqMHlkck5ZQmlycVhWNDYzVG1IYlBXZmRySHFxeFhoYWRpWDJp?=
 =?utf-8?B?eEpGV1h5VG1BYzI5QVJDY0xsNWhyNU5mUSswRjNJS3BYUzlsNTFSd1JNdDdu?=
 =?utf-8?B?SXljaVlrQjVBbWQ3MUt5NUlsT2dJdEVRSlZvSzNFWmlXN0YyMkZiZy9HaDBv?=
 =?utf-8?B?NnQzd0c2UzZ1a0tYRS9qYkxJK2lmV01uTFo3RTBlZlprd3duTlV5c2xzckt4?=
 =?utf-8?B?em9tanlXZ0g3dlhIY25hWXVmaWdWcTlaSFYyZU5tQ3RodVl5a2piMVU1T0w5?=
 =?utf-8?B?cGlkRE1ZcGxIMzN6YXk3UjNrNnc4N0Q4RVRTY3Qxb1JWeU9uWWNpNVlhakpE?=
 =?utf-8?B?L0hMWUY1c2xUT2dsSnFhTVpkR0YrTURJTTZnTTRVeFNmRWlBbjNiSGFjSUNy?=
 =?utf-8?B?QzFhSXFxaWNUK0c1TkNDSStJTmFDR1JucEtvZ3IybG1ob1VNQ1NuWk1abkxL?=
 =?utf-8?B?cmdFNGdUOWtSTUJVTTFIY3hPazlVMkFzSVErZ3BBWmJ3NGo1b2Q5dEhTd0xx?=
 =?utf-8?B?T1RKclNmRjhBV0hLbWZIVXdtckIwd0UzSGZ1VEdCdER3LzY1MVJ1TXo3b0tQ?=
 =?utf-8?B?MU9ySXE4c3NsR0VObHd3Sm5HU3FMOXBvdVA3ektLUXRvMzU4OGl2SjdNQVdP?=
 =?utf-8?B?S3JybTJPcmI3RFRPSE1JN2h2UCtxUWtyNWxEbm0rTURZQjB0WFRuRTBxbHZM?=
 =?utf-8?B?S0tER3JLLzFycUJqMEsxNlUzOWl6WHU5NCs5VnkwVGNaYzVmRUgxUXF1SFZv?=
 =?utf-8?B?Q0pwUVI3WTZFckFkQWxvaDlMZ25FQ2diK0VHbWNVaml5NTZqTkxSMW5CTFJn?=
 =?utf-8?B?SUtKeEwxQVRHQ0hQN3dtL3MrVDUxR1d1WDBlQ3JJamNSbzhHaHpHWHQvcndX?=
 =?utf-8?B?QTZuK0hyS1lwMlFQbzdobWMzVmVxaTR0NXVPSzBSSWd0aWpFdERJRWNISUxK?=
 =?utf-8?B?aW1WcXNyZkZyMVQxU2kwbUt2ZnE0SlFYNEVXYnFTZm1YTGpLbDFna1p0QTFM?=
 =?utf-8?B?OFRzN25KclZERk04R1owZlhSZmdBa2gxT3phZGtKQUxzbWhMNEdieS9WZndX?=
 =?utf-8?B?Y0ttRi90b0hzMnVYL1dsVG40NTNvVUJNNit3NHdCcVJuSUxHemREdmxDS216?=
 =?utf-8?B?MGwyeHBtYUZIamFZZnYzNmdGYmJhcnRmajZ2RkFvUzBuM0FpREFKemZEc0dk?=
 =?utf-8?B?eC9GaGc4SDNBSFJRVXNtTko1RmIvaWdpMDIwbklxcjB0Q3o4VktrUFA1TWZn?=
 =?utf-8?B?VjgxTGtRZC9IYjFQZ1ozWXptTWtDYyt0aU16RzRMMWFMTDFRYnF3T3hodEtU?=
 =?utf-8?Q?rKn/Pj530rY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFRBbXlqN3hGemhjMjhrT1FseEZBRi9EbEpzNkJLdFRRL293N3RndE1qb3px?=
 =?utf-8?B?b2owM3BPZk91dkl6QUhQNHBRaGRHOEwyL1hFS1lkNGwyMjZTL2pCQkdyR1BW?=
 =?utf-8?B?QXNYajhvUnM5QVptVjhFUlFIS3h1c3dIVFV3R3BxZ2l3Vzl0a1hJU0ZJeGlZ?=
 =?utf-8?B?aFdxTDJ6TkVCY05nRjZzUDVaeGJVQVRVZCt5a1h4eG4yVU9RYjNZU2duS2Ex?=
 =?utf-8?B?WFo4T1pKb0hCeDBmMTlDZ3hZN2VmQStQN3VMb1Q3Y05heHpZR0JEMVBrc29q?=
 =?utf-8?B?ZzRicjYvamlidWt5a0FrYXFWbFArdVZsN0hEalRyVG5ZRThYbStST05qT1p6?=
 =?utf-8?B?enJpOG5RSC95cVhGVkpiR2VMSjNyNUwzWExjNmRPZWcxdHBpa1BtR1ptZS8x?=
 =?utf-8?B?RC8vMkN0VktqZnpkMm0zYlEyaThCeW5EOTBvbGpFcEVHQkhDbndTUDZZVklI?=
 =?utf-8?B?ZStYSzBmZUN3Q05TM1FzRHR3bUgyaHBoVXY3c25pNHBkRVNiekFDcWQxMy9W?=
 =?utf-8?B?M1EreUhQeERNZkdwZVdJWXhOWEoxcTRZOERvbThhNUNtVkE4NXNRbnByakFB?=
 =?utf-8?B?SzliSUZvRm5uN3RuRGJqdk5ISTFmRzlveWxBZHFCTmxDU1liUU5jbGRrazNz?=
 =?utf-8?B?cTVrWlJ1Zk1JYXduQUNSemxQYTRKSnJLM1M3M01DTUVkMVRXYWoyYjA3aTUr?=
 =?utf-8?B?b2tySGttVTMxU0xzS0lhZ1BkanVPazgxRXJCWHkzSnBaYWRIM3k3elpYNjFQ?=
 =?utf-8?B?ZE9LYXFHWGpkNlVrRGRzcGFBSXAreHp2TEJQRndTQ0lFQU9SQ2pkUVE0VGJm?=
 =?utf-8?B?UFBrWVY0eDdZNXFVbXlCRGQrRnBLY1NNT2tSNk5GVFE0QWxOM1FMemlrSFA3?=
 =?utf-8?B?QlhwRlZlSHZhNVdNUVpvckNnYVZsaWwyajQxa2c0MmFUaTIyeU9WTVRBUjBD?=
 =?utf-8?B?V0Q1VzIzL1lRZTF0OXoyVDBIQUhWa0Mrc01LR2c4M2ZTcFM2V0pvQWFueHRn?=
 =?utf-8?B?Tld6NW92UGR6bEtibmk2cDZONm9CUnlTZVo4NjNCZi8yMGU0UWVQeVV4bVVm?=
 =?utf-8?B?ak5xWmhDdlZZWThMRng4ZzNidS94Skdsam5kL1VuQnZoVGFRU3pPUVNjZFFS?=
 =?utf-8?B?OWRqeTNyOThva25uMSt1TWlVVHk1WnA4NEtmSWQ4cUtSY2x5VE5pSGd0enZM?=
 =?utf-8?B?eEVtMnoydE5YQjRCV0hCQlFPai8rRE5XQmc0bDdnZ1M3ZnQvbExSZXlISXc4?=
 =?utf-8?B?eDc4TWsyV2JaZDhuK3VPWm9NUjNvWEw4c2FZaldETVZ2ZzExczRNQTdlOXg1?=
 =?utf-8?B?R3ZRM1B1VnRzeXpmWnU4ZzB4OWM2SHB2L1NxQ1QxSGt4VU9aUzZEY2dIM3g0?=
 =?utf-8?B?NEdDRDNMS2RTMy9iVXlvcWlweUpzV3VHOGxBVTl2OGhLTFU4K3VqWjRGTU9p?=
 =?utf-8?B?MXhoWmluYy9NVUNsdlM2bFk0cXBTREJuZ1U2dVhIRXdkdzc3QnhySUpiWTdm?=
 =?utf-8?B?UWJkR08wYkRCSTZ4TDgvWDhTYzYrSnJWSzI1US90bUdVMkRLc3c2d1Q5SWJ3?=
 =?utf-8?B?QS9TL05SVTVoSW9KWjdIdDZCT0dlVGJqRFFHNkZnSVFRYjg4a0dCaVBLKzJk?=
 =?utf-8?B?Y0FXSGdNd3RQZ0xucjloeHo3NXVwV1Y2ZFExVVJURUdOSURZMTNwNDU1cUEx?=
 =?utf-8?B?c0NWMENLY3pQL2RpWmVFVUdwVkw4TmpFaDJ6QkdVQi9sNjlrZnAxRk9XNWpu?=
 =?utf-8?B?NlRWaXNPRGR5QW1xSVVpRjJwRWp3RzZnQ3FoMFJwTXY2elJ0bVJtMFZrMkls?=
 =?utf-8?B?Vk5hWVRGNVlGTWY0bXY1MzFFUXIrVHR3ZXJ1YlQ0dk1hWkJxM1lQR3c2MXZB?=
 =?utf-8?B?Wm4yby9xeVpyOVQvSytYclIxMEpFSFh1ZDBlR01UZVBVSkdjVUNNMDJJQkZx?=
 =?utf-8?B?Zks2TXc4UTRLL2tsa3VoR3hpakppWUpTampHL0FZekVYVkl2TjF2TTVSQ0Zx?=
 =?utf-8?B?bm1MTnVibjVvTis4NzBrZ2FnVitLaDRyNTdaWlhPaDdlRTdxWkpJdERZeS9z?=
 =?utf-8?B?Z1RCck4zS0NRbFBnUzlqdk53dEw3ZXFBVUtXZDJvNDl3T3MzandRNGZNcStl?=
 =?utf-8?Q?cqS1Iz/tZ84QKGdYB75PquiHG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 574d3af2-f680-4e0b-f6b7-08dd91640e18
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 14:48:28.0845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V7N5B2Ewl9FIWEZ+kXjgrF0pL3r31rkWcMR+J1kkLhly1kxQhbHkPw2PTCQF5FHsz+fUdkMoe1eoupBqapVJPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6272



On 4/17/2025 5:18 AM, Jonathan Cameron wrote:
> On Wed, 26 Mar 2025 20:47:08 -0500
> Terry Bowman <terry.bowman@amd.com> wrote:
>
>> Restricted CXL Host (RCH) Downstream Port RAS initialization currently
>> resides in cxl/core/pci.c. The PCI source file is not otherwise associated
>> with CXL port management.
>>
>> Additional CXL Port RAS initialization will be added in future patches to
>> support CXL Port devices' CXL errors.
>>
>> Move existing RAS initialization to the cxl_port driver. The cxl_port
>> driver is intended to manage CXL Endpoint and CXL Switch Ports.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Hi Terry,
>
> Sorry for the interrupt nature of reviews on this. Crazy week.
>
> Anyhow getting back to this series...
>
> I'm not a fan of ifdefs in a c file.  Maybe we should consider
> a port_aer.c and stubbing in the header as needed?
>
> I think it ends up cleaner both in this patch and even more so later
> in the series.
>
> Jonathan
>
> p.s. And now I need to run again.  I'll be back!

Yes, I will try to add to the next revision.

-Terry

