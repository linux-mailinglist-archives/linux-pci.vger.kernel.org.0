Return-Path: <linux-pci+bounces-41581-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E2001C6C9C4
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 04:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 54666384F6D
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 03:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C602135CE;
	Wed, 19 Nov 2025 03:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S93bbC7p"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A004F11CAF;
	Wed, 19 Nov 2025 03:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763522842; cv=fail; b=SRMwdXJDDBQF2gjiQlaTnhS2XREMojbKpJ2wYe3ZF+TRtN3XUslTTbqY3IGrBO3HGWTeKFXuH34ICGWt2+5uXaIYecQe4BJeNjr6tXf+srt1BHqafItL2vYwz3kgxfippcuPSInyhtAtb5Rk61vwTtDL5zJKEnVsPmFshGRNmGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763522842; c=relaxed/simple;
	bh=IvGrsXwdMgw8aIp0ccwPBHnj1pm44+OGlB/2UHkojY8=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=izW3I5BLMaW1Pmb4KA9zghFM9vhiF/P7AaQKCAWK5qe+2/Q4n6m2TRVsIL91OPQ7rFG0ZPi+RN7R4yamEh19akmSKWX1b3mQ16NqqEHSqjpZ0ZZ3T5qnv15vCfgY02poMuL9sbPavrtyO2SnIbKwDfmdVmDPL64t52asxQdQUHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S93bbC7p; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763522841; x=1795058841;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=IvGrsXwdMgw8aIp0ccwPBHnj1pm44+OGlB/2UHkojY8=;
  b=S93bbC7pliDCYy+s5M90qoQWkeLDws7Fg6KN1ll0jPPnJRlbO7mk5L1m
   4xRxm2rlS0BMvBgOU7i4rN3VPWmSzNxYFuVuS4AuczjMHd5erecyN+E4S
   B8Ay4s8soaPGvSrivMLFt/nYU6kkJ4zDwLHT1T3Oyb4h6moEHn4MyZXw6
   U8LlKU6Yfz/XjC90c2mk+H01coQ33y8sUQbAUMUfP+yO2gcPkeHAfsxVi
   LxK/F6qLZ4bM4tBuOUv9fQBLIEaf3pS8+2Gt4iurkCdMRqFcyPDoFghvH
   8oKiX93WcR6mWKfKcwN3ST5/J5O9XyIcWhGpTHWZSHx2cz1UWUuDlwsYx
   g==;
X-CSE-ConnectionGUID: Vkm3VYasSeqAV06xIYXOiQ==
X-CSE-MsgGUID: nardy22zTlGXtbqXWhZsSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="76910341"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="76910341"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 19:27:20 -0800
X-CSE-ConnectionGUID: uq7poX+VQMah306VMAA1dA==
X-CSE-MsgGUID: eeXcVBTpQs2CdTkr5okzYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="196068619"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 19:27:19 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 19:27:19 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 18 Nov 2025 19:27:19 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.67) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 19:27:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pFQUvf7Agd2KuGN6NJ5FW9WGs1K4DGoo+W53QgaNnGkn3RIobd/Ws3uxlWAA1BFEptab4Oy3pPLqBLdjeHmHw2BM1Xlx3n5jd0+lsBHxCKJUUbRnC0l6HAbjNPalbkgS46xXimz06VtTlpKQ5/9+BMlZLWiPX3Pbf0TWflJCR15nD1X45aNZ+82invpFZEGOcTFMUwUxsP5ZjbPwobt2Dne0Ytr/bcISlu9nm+HiXU4skQDqW+2oOkOlkOCXxk/FKg3Q9qDhtGcqW4Y/pXpr8WS8zAbpWYG8iL6bjA+tlXkk+sVCFB37JF0ix0Nb8TwOx1xaH7hqOYmvBvuA4HsT/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IvGrsXwdMgw8aIp0ccwPBHnj1pm44+OGlB/2UHkojY8=;
 b=sez3joT0MuQbhH+l2BeR37YaKJvzUn97Y0FSZ+GPQ6WLrRGlCFkj/UcREp1FwnaBXGUJZRini8IKwZj3k/l8dH4m+WseWucDyHNRf6TLWhlu/nWLFjBXIm93FfwCvwmiRVR2MQDRNEE+46sDJO4nAx22py5Ml/iv2kKRz1ttf4cx1OzihOjDeK/hPHHkb/D7g2+qSKFPzGECwck3I4DRLoso6ASHoxQfTKJ9JvSy2i/QukRElrUZuOvdu9MDKkVm49uCk5slFor2RY/UwwAhQfA5nuzyhzVQYZ5qrEMZNtXxWOFmsrsw6EPLMiLcTwhznkdu11/s+GtuV5Gh1fTkeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ5PPF99DB14780.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::847) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 03:27:17 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9320.021; Wed, 19 Nov 2025
 03:27:17 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 18 Nov 2025 19:27:15 -0800
To: Terry Bowman <terry.bowman@amd.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <shiju.jose@huawei.com>, <ming.li@zohomail.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <rrichter@amd.com>,
	<dan.carpenter@linaro.org>, <PradeepVineshReddy.Kodamati@amd.com>,
	<lukas@wunner.de>, <Benjamin.Cheatham@amd.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<alucerop@amd.com>, <ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Message-ID: <691d3913781e8_1a3751009b@dwillia2-mobl4.notmuch>
In-Reply-To: <20251104170305.4163840-12-terry.bowman@amd.com>
References: <20251104170305.4163840-1-terry.bowman@amd.com>
 <20251104170305.4163840-12-terry.bowman@amd.com>
Subject: Re: [RESEND v13 11/25] cxl/pci: Log message if RAS registers are
 unmapped
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ5PPF99DB14780:EE_
X-MS-Office365-Filtering-Correlation-Id: ec23f440-5c9c-4681-491e-08de271b8a3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eGJsQmY2MFo5ZDBmUHA3RXA3ZmpMcFROL1FTY1ZYUGdObEFlR1FsMENCc0Jt?=
 =?utf-8?B?bjA0dFBPc3E5dW9oQlllWWQwdVVaaVlra0UwQmh2T3dPalBBcytsZU9mRW9a?=
 =?utf-8?B?ZFhkVy9DOVA2R2hUSjQ0aDh3MmdjNTBzQ1JjQXR0QVNmMk5GSnVURjhQUndG?=
 =?utf-8?B?Vlk3a2oyZnRheThldlpBZEFtY1NCbWg2Z2M4TFIxcHVWR2VQMXR4cXR4VHRO?=
 =?utf-8?B?VDNwbFJWemdHYXlmemlEZ1B3Mkpic25YSmg2c0NTOHduNjF5cmkzNGpxVUY2?=
 =?utf-8?B?b1owN2J3dys4aGhmVVNVN2MyNE1EWXRJcGxiWEtoU2RtTmZtVkdnYUx0Z083?=
 =?utf-8?B?TTNWREp1Z1Q5b0FCZmtaYmJsNGtPKzNjTzA0TmFnckh5WER3VEUxQ1JOV3gy?=
 =?utf-8?B?WHdSc1Z2TmhhU2J0a1lrL2tyTm5aS3U4VXlPVnBsWmdkN1AzYXhXRUsvWnpT?=
 =?utf-8?B?cmdXTU83WEw1Wm92Zk1uZlhobHM5R2JTMVlaZWp0Y3YyRGUvWGRYZGlpTW1E?=
 =?utf-8?B?UENwR3E3VlZwMkVnZTg5ek5DZDNiOGZvcnd6VEpXY1FGSnlBeGM3azByayta?=
 =?utf-8?B?YTlwc3dHSHFEUnlsVXZCcTc1NDFrMjh0UGI1ZjBWVTBpTWNDRTdlQlFrQjJX?=
 =?utf-8?B?RlhQUncrRGZ0QUZQY01VMVFRNjJ6cTd2OGE2LzN4WXhRYjdTU2FWUi9KY0Zt?=
 =?utf-8?B?aFBScVEyYVhCUWp1VW11Vzg1RjVnSkEyWEhNQUZxQ3AxQkZid2NPaDJaamxB?=
 =?utf-8?B?UFhIUkxhc0N5MzhVTysxbVZOYnBGK1hNZG50YVovbTNOK2RNK3hBZlEvaUt3?=
 =?utf-8?B?VnBiRVhoRDZ0QUJ0azNZa3FJZGo0VDBMeGo4bi9lZndSeE44TUdQWDJBYUpr?=
 =?utf-8?B?a2hwWTdzMWVuWWJaZ3lyK3BFVk5PTFU1c0NnU3VESVhjUlNVcEoxUmtBMjIy?=
 =?utf-8?B?dkFINnVpR0MveDhsUjQ4Y01YczEvZnhKMld1VERPSjNVUEpNK0tZYUhlbjAr?=
 =?utf-8?B?Mmpwc1d5ZytVR0RkOU8xalBGcm5ndDZmOEdrcTRvVkV2RG5MRm5SbW51TzFX?=
 =?utf-8?B?SG0zeUo2bmlpbFJFbXBOMlBjaW1yOUZwT2lramI0dWdwSDVWejhyak1wL0VE?=
 =?utf-8?B?ZDNueVBzZTVkN1l4WEQrRUdHL1FKcWtsZUc3Q1ZhNGZrVjdaSllQNWV1WE5J?=
 =?utf-8?B?OXJzeGd3K1BzcHkzMDRNblhrWnpackN6U2cwbHNMVUV2K05NeU12ZFBvLzc3?=
 =?utf-8?B?NE1OdHdUU09iL3RQeDVqKy9iTVBsRnNuVlRtbzNkYTJTeCtjeGVJTktONEk5?=
 =?utf-8?B?eTVyT2Z4TkIvMzQ5R2QxNWFQdjJtTTRCN3c0RFc4anJqd1p3cjh5dFA1T1VJ?=
 =?utf-8?B?R3E1NjJVblZKOEtlSzdaV3NnY2pRSzFRSHB2clFSYWVicHRHVkU3SmpCVmJU?=
 =?utf-8?B?bElZQnJ5N1JaS1d3aDNKRlg1aFdzS1g2cTZOK3JPY0lhTzU2aWR1bFFxMFl3?=
 =?utf-8?B?MzFINmhqeDZrSU9kVlpkbVQ3ZS9wdy83aW91QjlVNGpMY1lYLzFpaDVyenc3?=
 =?utf-8?B?M0RORUhVV3RzRWhXelpYZDF5RTBaUWVRMmtjMU1vOWtMYVZNWnZUNE56Nm04?=
 =?utf-8?B?ajloQkR3byt3MW9xbzBQaTk5WWpKR0VFSVdONUVxV2xJRjZOTlQzLzVMWVMv?=
 =?utf-8?B?YzdFNVljdTZQNUlNY1ZBK01GazM2cTRCR3RzQzVjVWpZU1piQUdTZmNZYUVx?=
 =?utf-8?B?eExjcnVRQnJOR2x2RExyd3pCaWxwT3FORWdDZ2dlZ0hPVkpsNXBTZ0NUbVVT?=
 =?utf-8?B?eVZOaUw4dWtEaFZiaHJ3VmdhbXJ0U3YrMnAyTjdKODZwaXYxWHBUNmxBcEU3?=
 =?utf-8?B?cVBkeE9vaEhJNElxOTBpVkl0d0NMTHBCbHJrQzQ0U3pXTkNsVHo1SkkrRFlX?=
 =?utf-8?B?ZXhXTUlWcGZGdEQ0eWl4ZGlMNThZa1dyWU5WcDBkY0pZNDNsbkR4QUd1a1BV?=
 =?utf-8?B?T3RiaTVkUlNFSmxVOXdrbXhRYUJWc2hrNzVRVmU4Vk9xR3dCczcvUkxKOVM0?=
 =?utf-8?Q?+5/QXH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWJhTUl4MjdaUjBCTU10QVVwdEVVam5PVkd3eHk1dE94RXczWUxyNGhCNFZY?=
 =?utf-8?B?WkpsSkNLTk4wQVBIK0l2NjZMdFJYVG1LcGg5UzhlMEs2N3psYUM3Nll2M3BG?=
 =?utf-8?B?V01xWnF1UDR3WTVOZTRMaFhKNEZ2aXhHNjQwcDJyU3p4YVFaa2tnd3psVG1O?=
 =?utf-8?B?WFFHY1U0RFdXSnpQOG9VbHBpbFJGczV1VThHK0x3N0Z4SnkxckpLK1J3UWlR?=
 =?utf-8?B?TzZ5K1JBaUxXamlmREhidnpOUnUwdFgzUnR3VDdWZ3hXYlgvRzNKenlpcnJO?=
 =?utf-8?B?aHRTTkE2VzQyZ3N4UXpTbW5iZ096ZDRYc0Q0Ymw5b05YVS9QMXdMMGZhV1gr?=
 =?utf-8?B?KzlqSGcxTkZkZTVGeGcvNzVJdzdZUGpodTFIY0V4RmdiS1RUSXptdU9FVCts?=
 =?utf-8?B?OWVJNk5jU2IvR25obkxBTkxqUGw5Y0tqT0pUYkMxeWpRTk9WeGhNYkQ0cTRo?=
 =?utf-8?B?K2hqSm5pTXRUaTczNG1lQ1crZ2pCWktBOEd1bUdjZXdWa1BiazU2MERFNExt?=
 =?utf-8?B?RVNaanZPSFNSWWI3M3BpK3hLUThUTElqM3AzOUxrQ3FXYmtIbzN1Z2pnVFVp?=
 =?utf-8?B?OE4rZEZRTERuTGpNZG1sbzFJaVUxM0pONGlOQkRhZzZnSkR2bWNZK2FXT1Mz?=
 =?utf-8?B?SVdEVVAxUEZHOUoxVU5ibC9uTVA1aitFWmZJZ21aY1YvcXo0ZkxsdXVsT1Bx?=
 =?utf-8?B?b1o0MDN4NmtsS3M3YXpsYzQ0c2RDSGxxWmhvUmFMVUhGNWU2eHVnN1NRUGVJ?=
 =?utf-8?B?UWJDNVZXR1gvTTdxT3JKRURxTVFTTERYaWozOW1TU2RaUmdTM2FzRktuRGRM?=
 =?utf-8?B?VjVXY1h6amNFbzlwQ0VWVG80UVE5NjkzZytQWlp2c0Y0c0hSSzJZY2NFbi9y?=
 =?utf-8?B?UnBmRTJQMWtVcGlrdkc5T1hrRUJ4ZGFvZ0ZiTUVmcTU4dFlUZkZnalJJR0pv?=
 =?utf-8?B?a1hkYTc1VGE0U292UkRwb2IrbFN6eUJrZDRrMWtoOGR2bHR2ZmgrRTNKTkRN?=
 =?utf-8?B?RzJtaFlaeG1QamFYZlF2SVJ0aEhuK2FwOWVaM0lYRGRzTnh6U3VkWFN0aGlt?=
 =?utf-8?B?cmlmRnBSZStFVUlocGFDZ2V4Uk5SOVE2Y1F4L3dqY1hMM09QY0Ryd0lKMG5n?=
 =?utf-8?B?Qm1WTlJMSm1iMGw3SzBtQUo5YWpXaXkrdUdtbDA0ZUhGNk9kTFpRaEtIblda?=
 =?utf-8?B?TlBVSHFydkdLZDdDcVp4cDlPWUxLR0JFSjVaM0R5UWhYRlJhQk40OG9wZU1C?=
 =?utf-8?B?YmFWN3hOVjdMbExuWUZkSWIxamF2MnJkTENDVEFybHRJMmRoT01aelEyc1lv?=
 =?utf-8?B?M0ZxbURvMVd0VklsWWJLMGRHR2FhS1lJdUZ3RTdLNHhoc3NiU2wzcHlPM3da?=
 =?utf-8?B?bVMzdVRFclNFKzU5cEVwRUFOQ3NwT3hEMTBGbDAyNHQ2MzdhaFdPdkxwWXUx?=
 =?utf-8?B?bk9JeVIzR2NhN3hjellBbVI4MUE4MVpuK3d5NE5ockJaZENieXN2RitkRzVr?=
 =?utf-8?B?MERLeXlyRTF3TlR4TGx1UEZZNkd4cExoS05NUytYUjlpSzR6Rk83cGhuWUVB?=
 =?utf-8?B?SWhjYTFnUmZReVVqOWlWWlM3aHVhdDBzOWtnbW0wczZ3WjFRbWxWQUZLU3d1?=
 =?utf-8?B?eVlRMmdYTlJzS0puSnliZnVsSGtkVmZHZ0x0WW04dXlPMmc1QlZNdVhtNkN6?=
 =?utf-8?B?eG0zejliaUdwVTc1ZGg3eGRiRkJOdWplNnhBS0wza3hGM0Vjd3NQamVWZENZ?=
 =?utf-8?B?U3NrbFdVV1U4bmdsTVhvZVVhdmJLQ2tvVG83UUhrYU5mVnkvZm1pWkQ5L0lN?=
 =?utf-8?B?M0QvcHpWVGd4djBBMFlna1NYTUYzelVnTWYyZFhBOCsySnllYjZ3YVNuTTJw?=
 =?utf-8?B?cVpnL0cxQ0hwOTNNeXB0bEs2VWhWV0hXM21DLzRLdjA1VEJTbTlsZjhtOTdo?=
 =?utf-8?B?ak5jUmNPUkg3S2VjQ2xXODR4bjNMczhCNVM3VkpsM2E2cCswN0ZYUzhyYlFR?=
 =?utf-8?B?ZU54U0ZhVUt2K05iRnNpR3BDa3pMQkMxb2lsN2VtdndjdGJlRndhVCtINytx?=
 =?utf-8?B?WEpyNU5LVDlpZjg1U3ZtKy9haGJzQkdKdldsNTJlaWpsUkhlMzR2TXpxb0ps?=
 =?utf-8?B?K0dVSHM3V3c5Y0VoUHV6RjdCTXVOMlhRem84c25qK2lHY2lsczlmc3NRRDVl?=
 =?utf-8?B?VFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ec23f440-5c9c-4681-491e-08de271b8a3c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 03:27:17.2100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T0hV7ZZ1jG8ujBYrD/hObkS9MvvEkpBvqqrKt3ayVH0SegtD+wiJJCpNZxd2iaMaLctT/VLTv7Q3y0r8I0fYcO6nKtonRdZj5R2mOAFnzjM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF99DB14780
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> The CXL RAS handlers do not currently log if the RAS registers are
> unmapped. This is needed in order to help debug CXL error handling. Update
> the CXL driver to log a warning message if the RAS register block is
> unmapped during RAS error handling.

That does not tell me anything about why this patch is needed, how this
scenario is entered and why catching this late is ok.

I do not have a problem with the change:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

...but I would steer away from patches that just say "add debug, because
debug helps debug".

What is more interesting is a story like:

"I lost a bunch of time figuring out why error handling was not working
only to find that in $scenario the RAS registers are not mapped. Save
the next person time by logging this condition".

Otherwise, if I NAK this patch I have no sense that Linux is any worse
off, and fewer patches is a virtue worth considering.

