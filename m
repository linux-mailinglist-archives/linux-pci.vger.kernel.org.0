Return-Path: <linux-pci+bounces-21081-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0D3A2EC52
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 13:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 189EF16053F
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 12:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A4C215F58;
	Mon, 10 Feb 2025 12:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jYaqPOkD"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDCA1F7095;
	Mon, 10 Feb 2025 12:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739189332; cv=fail; b=ZF6wqSbrY6FPxsRwShd6PpBr8ZRz079EhqCC5MVUK2H8x39kPUWMn0qZMwPUcYGzDzWZS6DWX6XWhE86u4rekUxi3SzPXgOfHAd/NI9pwBuVH+QRAoQgWYsaTMEjuktiZi+fTWQ7Xu5LE9ziXFHt4Zpqu4spLwQ34FOR1GXFIhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739189332; c=relaxed/simple;
	bh=x9ELh3eowQQ3df08hzlE0M7AGAAzeyUNbMuXDOo3wMk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cVwbdkrWQsuI1PItkBZOI+rdh9EGzDiEjChV+vTRlZcQv51dgKndSYgAAJlLEbCcoI7l1xCzFU1Ww1pDtMtCV+ePNaVSxy1J5VNjtqqZh41IUM2axoalq19mu+bL8VxJLN+WqK+A6rO89CY5xwYeu9ltxxO/ckBVQ5X+bYUWYSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jYaqPOkD; arc=fail smtp.client-ip=40.107.243.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nBCuJlggH5GguHz2zh9oKOqo11Xzwjn/tpfzGrpjuwYjB+EK7SXN+4mRsxWkmp3bjUsUp0vpJb0J0RtYgcc7ZYimgs9f2eSfv1A1fzTMcY3HuIRL+bR3MV6f/wHRr5G8jiR1LKDptPFSebPUm6OT9mgEV23b0k2qnvTlOWPTW/1a5MfEBTUcNFKNUTG7cQ+Wrq3PSh8bJz+JehQhW8W0gjnlA28tjWyrw0oNNiy9L6rTy9hq2zxxtQvIn458TEqor0EiMM+BpPlRp2D0Jxyvv9ZgCJBrKCL+4+2ocO7lW13GxdpOzkTrJvL5Ab8c8oL+SNsbbttbVgYDZm3Z4Q1EVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s7d88bHbaeWbMyTCw5nwReDMWsjrKs6jp3bPdlnqO0g=;
 b=l/9BrY5sX3O++9PeZrs/VHhT2z7l8ghzVgXA7LdW8uTe0xBEkx41gYsqKKoOMVGPHKyvhZLUdbYLn2SaEvITJntjPm+9O1ljcuNT+rYUQpI57oRQ71fhkgwlSvsM2BYwP05C6ZTdFihE7mHbSC+nWJZWvWRv/d8jVAO5WatGe1XleXFGaXorQn+DpUrTbDnDxNgpY2JHPmAD3YrXx1AdJhX5ttc0R5Xwv0vhzoJiPUOxKU4iccsRGYum8uLAjd6XTEWa7SmB88hl4n94RUPdwMt9QN3wVR3w67kZANm1bXSa96ETbpQsjXMJRpfmF5l7e86AaWqCl4OIaDs6m32S1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7d88bHbaeWbMyTCw5nwReDMWsjrKs6jp3bPdlnqO0g=;
 b=jYaqPOkDRln48t+KZVhJPbcmrfyShB7ECi4wE3GYXFwwtp2Tj9a+h35Vuk6HoLi5OnXqY94oF5FpKjaBYTJNTZ5rGlYz193nuvKnEuJcyrgy9A2aLfdFzsiuO9UALwtxTI+WXmyeD9QiHMXmOIrAz+6jB33WgLdKv9zmGQO79VeB9a2YovOtHDOY6l880mbpTOyDLIST3y37zNmV/osVLMWx/3yuOiHrgPxumsi/e5ru5fiZMp0Cc7pKttCC2q5IcFKGhmpZGng0yrlRglgCfy0cH733VEfzNH7/PvjPlBPpT9Lv1HTponzbMHK2CvwHXBJ63ZvCk8hqUQiWotTnkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by PH7PR12MB6978.namprd12.prod.outlook.com (2603:10b6:510:1b8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 12:08:47 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%6]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 12:08:47 +0000
Message-ID: <5a552e4d-e8b8-4557-a558-f41ef7639413@nvidia.com>
Date: Mon, 10 Feb 2025 12:08:42 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] PM: sleep: core: Restrict power.set_active propagation
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>, Bjorn Helgaas <helgaas@kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Johan Hovold <johan@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Kevin Xie <kevin.xie@starfivetech.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <6137505.lOV4Wx5bFT@rjwysocki.net>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <6137505.lOV4Wx5bFT@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0659.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::11) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|PH7PR12MB6978:EE_
X-MS-Office365-Filtering-Correlation-Id: b6cfb1d0-9d49-47ab-a768-08dd49cbac32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2kzMC91UXhZVk5YRHhRQmUxcysvR0p5cEhOS2pjT2U2bXRpQlNqOEQ3dVVp?=
 =?utf-8?B?b2lEWkplS2VRQ0VsdG5Ja09uR2RWRmRYVTZwQUFlR0dadEVxaU9CTzkzRjEy?=
 =?utf-8?B?TW9FQUt5N3l2MkdOanpQRllieG9KOHVFU0NWNmZmSFBwMHZ5ZG5FSHN0UWQ1?=
 =?utf-8?B?R29vWmZDQm56MzlYK2RrY1RLQUlRSVNtSGNlZ3lvdjgwKzQ5algyRFBhZTdX?=
 =?utf-8?B?QVFYK2xoZEdOeURhRGFMRzgvTkNWWGRBcitpa1VFZGlDbW95dmZ4WTB2VVdh?=
 =?utf-8?B?Q1NSQTRnWlZjNXlMNFAxQjh1Z21RMnRNQng4UW5QRzV0d0lsTGZvYmk3bVoy?=
 =?utf-8?B?Z2pDcVJvV0pGWDdMeDhqNm1CNG9MajM1S1FkUU1BbU90dGlGVSt1cmNwZ3dt?=
 =?utf-8?B?SEg2T3JHZVoyK25SWGpXU2trQzlHUmdNeWZOM1NFcUFKVWYwVEtEWko3eGJS?=
 =?utf-8?B?MGhVRFV6NGw3ZDVTcG1TYUZUdDM4YWVzTzJTNnFwcVc4RUlLQnFwQjhFQzRK?=
 =?utf-8?B?c000SklhWUtuQWdFWVdZbVFhMDVZb2ZqWUpzK1ZVY1R0alpHdFBaRTFQZFMr?=
 =?utf-8?B?YUY5QkhoMTVkUFZJK1JEYmsvQWhMWldDd1ZPQURLcWpqdVJtZ3BEV2o0TEFI?=
 =?utf-8?B?dzVJQ1BPVjgzYzZTWmY0MWFXSmVPVG9ic2NMN3VuaEl3b3RNWHhqVnhzMzlj?=
 =?utf-8?B?NHBIdmNHRzBEbEFWWkFZaTluVkMzU2N6NXY4KzNPZjBTT29XbVZNUzlhemxS?=
 =?utf-8?B?L2pTcU9mbzhMWUFxTGpLWDJZSk1peENYZHRqeDdMSXhNOUROYmlPWDBtRHFt?=
 =?utf-8?B?YTFRNHB1MGVtYjBpK0lKRFlpUWEwOG5zQ2Y2R2ZMZjBkMjNUSXVPQlFldGg4?=
 =?utf-8?B?YlFSR3BMU0ZIc3Q4cVdzMkM4Q2FpNHdvaE1GTWFnZzRueEczSVhhZ01YSGk1?=
 =?utf-8?B?VVk5UXYrQm10c2lDclUvWEhHcWhiNEhSNU5WK1BhanY1T2RMUW1oR09vMTJ5?=
 =?utf-8?B?YlYvY2tFeVI5OGE0NWY5RmdzWDBwd0krMnhEQWZ2RmlTWFRTS2pIbHJGUWtE?=
 =?utf-8?B?ZGFBeExFajhndTA4UCtWcm9LODVkTG9jWDExT3prUDJVVUhrWTMxSGFEQ2Ez?=
 =?utf-8?B?YUpYSEZIeFFQU2c1MmhmaHZINWt1L2cyd2tMekFQYkYyM2tReFFRVWpUMTVk?=
 =?utf-8?B?SUtmMFlhb2ZjbitWY1BXNzducWRDK3RyTWhFK2NxRTBLc1g5ZUd6RjdwVUpQ?=
 =?utf-8?B?ajl3SGZZazI0VmJZeGlUUEQwWDZrVndvQ3pBbThQUjYzcHdab3ZFODJEcWQ3?=
 =?utf-8?B?SDMzc2VqWWJMbXpTdUtZYWZLMHlTUndCZzRsSWtXRElPVk84WnRTcjl6cTVX?=
 =?utf-8?B?ZFZvcjZ5SWp0M0VTL2tOMndEN2ViU3RQWDhTVUlRVk1pZmF4N0MveUVoYXRm?=
 =?utf-8?B?czBOS1ZLaWorT2ZMYkE0L3lMQmwvekp3TXI5ZnViQW1QOEQ2OGhtcHg5eU03?=
 =?utf-8?B?QTVEQ082OHNQbExTWTVhaW9zRmZVTmkveTJrT09tdit5V3ZYZmxuKzV4d3R0?=
 =?utf-8?B?YVE1cEpoeDVOK2twcUNCdXlIcm1LZjdRZVZNTytQbTYxdGVFd1Nna0Z0N3hR?=
 =?utf-8?B?RkJlUC95SzMrNVB4T2JlbFZZWVd1K0kwWGVnN0d2bHJWTU9yRFVrcGJBRFg5?=
 =?utf-8?B?UGl4WHNIaWRrL3Z4UDNzQkFGUkp6UmdGaWZhWVhHMGFwTXVXcW1kUW9ZdlJB?=
 =?utf-8?B?T25vbmJUVUNXcVk5dlhTcFl1bXYzUFVCS3VlUjhFK1FxRUpqWkY2RFZaZnVO?=
 =?utf-8?B?TTBYTW9YNUFMTVZEYURKNUtqQUlCeHQzd0pXTWM3THFMb1piR2I4OXl1dWpD?=
 =?utf-8?Q?ifLW+sMYX6Nxk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjhxdUp2dDJNSTAydFlwdHQ2NmJRNG12TWJURmhqZ0p5emNBeiswUFdhSHAy?=
 =?utf-8?B?OHVyQUhwSjZhMmtLWkJ6bG9XNTVjcm5WcG16dGp2dEJmSUtETjk5MHdPZXpM?=
 =?utf-8?B?c0I4SEl5KytQVytnMExhOFdwRHI5aWpWbWg4TUZOMjQ0SVd3Y05Udld3M3JC?=
 =?utf-8?B?VWl5RFBwOXhpWW53ZDVINDl1MEpLZGdzS1dBVEltSWlqZkl4anhVcGlCQnhX?=
 =?utf-8?B?Z0VRZ3JIR3ljeDRJUWtMVGpsdHh6ZWJMVzkzeDdPdXZMWE9pZnBkSjU0Y05H?=
 =?utf-8?B?YXh6dWM3MGxVOVAzRW5YZ3pES2d5YmwvZmJpZ2xXTlR1YTRCaVg4MkhYKzR5?=
 =?utf-8?B?R0Z1SUhZdXIvVUMvcHZYTXVmU2NLRWdOUHlHbWhNRE43T2pMM2VlNmxFNFlX?=
 =?utf-8?B?RjMvaksydkRocU5MOVo2T1lvcTlxUVM2Vk5JWVdrRkNkUWR0alYrV2hvMk5F?=
 =?utf-8?B?di9GUmpET1FnSGJQWHNTWFpua2lmSis4cjNzcVFoUTVSY1lZbGpMcnR4ajhX?=
 =?utf-8?B?MlhRVUx6dE9jN0c5aUJpSWVrMlBNKzlVTUJ5VDRsSVQ2akgxV3ZXblk5a0px?=
 =?utf-8?B?SXF2QUFmVmFWUXhPVDdPbENoTXhFWE9SUmFoWGEweDFJdU5Ea1BFRmxSa3Uv?=
 =?utf-8?B?eDVpK1A3WjVJRUQ1THBxTjU5RC9rOEVURzIvaExiNi9pb2d2T3BsSWdtckND?=
 =?utf-8?B?czlTbFQ5VUJWQWRWNHlYUGUxUXJWYTNtZ1I5VjFTY21nUW1ETDE5dGpxbXFP?=
 =?utf-8?B?SGYxMXBFZVAzTGxSdFpXTU5pTGI5R3Y0eE9wUzdEaVA1Q3lUcldCY0NFQ1kw?=
 =?utf-8?B?RU0zc2k5VGQ5TWxCVXhiU0k0Q2krckF4THM5NkhhM2gxY3ozNmZaemNid0hn?=
 =?utf-8?B?dzFZR2tvNHp5VHZudXU5MmdGSFdrMzZLS3IvUmtKN0E2RUJqa0ZLSitlbUM5?=
 =?utf-8?B?bkJLc2FpVTZ3S1dMa090MW1lMFJZQVJMZ3BJTlZaK0c0SXdINzNUS2s2aWRS?=
 =?utf-8?B?QWZSMDVlbXRCOE5NOHRIT2x0cGV2UWZTZE80VEZKZG1xQVBXM1NlVXQ3NGIw?=
 =?utf-8?B?UHovYXpvRFo2Q1llYStZYjJVWXdlV2g3SEdrN1ZBeS9SSUFKVjc3cmtTdUZH?=
 =?utf-8?B?cWhGSXZBTHpYOGRqajFSS0Q3ZCtDSWJ1NlNpdmI5Zzk0L1BhUnpUOEZ0WFRN?=
 =?utf-8?B?cWxaM0dpZ3JscmN3bmxZNmRpMGcyT05PUzlHdWxUYUs1U29LNG04MTRLeWNE?=
 =?utf-8?B?Qy9JY0gzWGEwUGxnQWVFUTBjcWZMcjl4ZW5TNnpLRlFsS2FPQ2ltMGhCZ3Jh?=
 =?utf-8?B?OXBxUUFQZFpOcmNtQWpaTkFFM3VoNWNjZTdYdVIzZE55Ykt0MnpjMDJueXNw?=
 =?utf-8?B?V0t3NytnSk9ZUWV3Uk1NcHBzTDEzenRTSGpmaUdiZzkzeUlQMTdYTnd3ZnB0?=
 =?utf-8?B?Z1NjSmlBL2JrZlFodVFmNVNrTi9XMmZKdzdBTmRtZ0c5TlArcnFxYm01Q2V3?=
 =?utf-8?B?L01WaklYa1U0NXRRdWp2dFMxK2xTZi82RS9TcExuOWU5YnRYRUtxR3hSTnpS?=
 =?utf-8?B?NlRveUtDbHlQQ1RySXdMb1hWWTE5QmxFM2xQMW1KMkp3VmR6MnBZVk0xOGho?=
 =?utf-8?B?QkhZVGJ4MVlHL0hVNFk2em5RZlFvWVRCdGNydGJkVmlpVDZ3bVdsa0xqN1pY?=
 =?utf-8?B?Z3NLWWR1WGNpYmxMMXVNZ0o0NkFYS2pWMzRtUzZyYjI3Q0VBWjk4d01PdGRT?=
 =?utf-8?B?bmFaSVl4MklGUytxWS8wQzBCaUtWYVZmdjBNblpkTlpyczk1SFlPdlNJajMy?=
 =?utf-8?B?ZE5uamZCNTZzc3RoN295ZURlbFFyc0dHY3BIV3BvWmRyc0VFM3RDdXhoZXNJ?=
 =?utf-8?B?VWJFbnpLNC84aTdFNkJnMVk2b1hpOCtvd3FRWUkwK3VPSkJHeGoxMWxMT2tZ?=
 =?utf-8?B?eE1EbmtNZVUrQlFFQTdzeElMVTZSMks5YXdSSE5qSi84NUdiMFR5blZHd1Bn?=
 =?utf-8?B?b054YnRjZXp1bjNRNVV6VXRXZUdjZEpJS2UvOUdSK1dFR2s0alRvaE1SeGxo?=
 =?utf-8?B?NEhWd2lPeDc4dEVwWDh4TmhhODl3RGc3SWM1bzNGZytBRUlmbHBHVzlyTzd1?=
 =?utf-8?Q?wfxMTypeNGrFijhwM0iO3nu93?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6cfb1d0-9d49-47ab-a768-08dd49cbac32
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 12:08:47.5260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pCTdBaqcy8Kxc31oH+3TtqZ+8WZFNjDu1YNmWw2aMdbzmx5dH9wBiFUqNJFwryYtpCUR6jThFeQX1No6p2o/JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6978


On 08/02/2025 17:54, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit 3775fc538f53 ("PM: sleep: core: Synchronize runtime PM status of
> parents and children") exposed an issue related to simple_pm_bus_pm_ops
> that uses pm_runtime_force_suspend() and pm_runtime_force_resume() as
> bus type PM callbacks for the noirq phases of system-wide suspend and
> resume.
> 
> The problem is that pm_runtime_force_suspend() does not distinguish
> runtime-suspended devices from devices for which runtime PM has never
> been enabled, so if it sees a device with runtime PM status set to
> RPM_ACTIVE, it will assume that runtime PM is enabled for that device
> and so it will attempt to suspend it with the help of its runtime PM
> callbacks which may not be ready for that.  As it turns out, this
> causes simple_pm_bus_runtime_suspend() to crash due to a NULL pointer
> dereference.
> 
> Another problem related to the above commit and simple_pm_bus_pm_ops is
> that setting runtime PM status of a device handled by the latter to
> RPM_ACTIVE will actually prevent it from being resumed because
> pm_runtime_force_resume() only resumes devices with runtime PM status
> set to RPM_SUSPENDED.
> 
> To mitigate these issues, do not allow power.set_active to propagate
> beyond the parent of the device with DPM_FLAG_SMART_SUSPEND set that
> will need to be resumed, which should be a sufficient stop-gap for the
> time being, but they will need to be properly addressed in the future
> because in general during system-wide resume it is necessary to resume
> all devices in a dependency chain in which at least one device is going
> to be resumed.
> 
> Fixes: 3775fc538f53 ("PM: sleep: core: Synchronize runtime PM status of parents and children")
> Closes: https://lore.kernel.org/linux-pm/1c2433d4-7e0f-4395-b841-b8eac7c25651@nvidia.com/
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Tested-by: Johan Hovold <johan+linaro@kernel.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/base/power/main.c |   21 +++++++++------------
>   1 file changed, 9 insertions(+), 12 deletions(-)
> 
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1191,24 +1191,18 @@
>   	return PMSG_ON;
>   }
>   
> -static void dpm_superior_set_must_resume(struct device *dev, bool set_active)
> +static void dpm_superior_set_must_resume(struct device *dev)
>   {
>   	struct device_link *link;
>   	int idx;
>   
> -	if (dev->parent) {
> +	if (dev->parent)
>   		dev->parent->power.must_resume = true;
> -		if (set_active)
> -			dev->parent->power.set_active = true;
> -	}
>   
>   	idx = device_links_read_lock();
>   
> -	list_for_each_entry_rcu_locked(link, &dev->links.suppliers, c_node) {
> +	list_for_each_entry_rcu_locked(link, &dev->links.suppliers, c_node)
>   		link->supplier->power.must_resume = true;
> -		if (set_active)
> -			link->supplier->power.set_active = true;
> -	}
>   
>   	device_links_read_unlock(idx);
>   }
> @@ -1287,9 +1281,12 @@
>   		dev->power.must_resume = true;
>   
>   	if (dev->power.must_resume) {
> -		dev->power.set_active = dev->power.set_active ||
> -			dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND);
> -		dpm_superior_set_must_resume(dev, dev->power.set_active);
> +		if (dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND)) {
> +			dev->power.set_active = true;
> +			if (dev->parent && !dev->parent->power.ignore_children)
> +				dev->parent->power.set_active = true;
> +		}
> +		dpm_superior_set_must_resume(dev);
>   	}
>   
>   Complete:
> 

Thanks for fixing!

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

-- 
nvpublic


