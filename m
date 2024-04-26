Return-Path: <linux-pci+bounces-6703-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7E98B417D
	for <lists+linux-pci@lfdr.de>; Fri, 26 Apr 2024 23:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0B9F1C21027
	for <lists+linux-pci@lfdr.de>; Fri, 26 Apr 2024 21:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BB063AE;
	Fri, 26 Apr 2024 21:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DfItoXrP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DEB364A0
	for <linux-pci@vger.kernel.org>; Fri, 26 Apr 2024 21:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714167972; cv=fail; b=Uresez3z53MziMpmTnan0tT5zK0lAvhqiwN6L5vR2puOO3GFXpN4e+QpNbl9c1k0jvjPFyQFWlnN1RL8xudkoEqpsqvAv/8ZWVTcAxcpr81EMqavq99GbPI03JXmHD4BharcxKSEMp3kDm6T1O2RTBrr7HS8voKRPWdtitVefeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714167972; c=relaxed/simple;
	bh=/YHjVF9Rrb+0W7BgXX9qvtCS3WzFhTJvNO3d2JXknlo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lVc231R9cgQ++1RlDl3VvlKwnisttVzvV5Aw9TEKEDU1dpJCKA+1IMamm0lWiVu/ZEzWXWm7DwgJyyLwRdxze5OEf3t9nH6tCRUyWxlZYAhLV/vExAH2aDLAoxrzGFxfLUhva+CtLnNWKtXb87zwnAWY/brbMSjoz4Pq4lvqNaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DfItoXrP; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714167968; x=1745703968;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/YHjVF9Rrb+0W7BgXX9qvtCS3WzFhTJvNO3d2JXknlo=;
  b=DfItoXrPCDzeTe/7efNmYVQjIohVnDY5KaYMqjKLxYfuWpZwEEJ0Ku/k
   l77EMFtFydleJhk0qTe7h2NNDwQ7ts0OAqUTzSLxLwhR0C4iiKAclRFeU
   nP8GDc8FgQfPpiBjRHWkbA9548N61vIS8gGckn0RZt9hZATCmxOQ9Snjs
   j7f9YHedvCom92g2T7uk8K6YJiQMVCm8LQeFz5ZswMOJRBTI0b8MOsPsg
   f4LhE6H9C0wglH+ENo+2e+pmP+bO58jXTdc5epHYcNv/uriKWfVipaDd3
   QA/cM7fDec0kTcPw9NxfNDo+esEPvVsY6XiMKA5itkML01Mfc2U9lbpJX
   w==;
X-CSE-ConnectionGUID: 4OAnaM1ASlylAEGrk3vF7Q==
X-CSE-MsgGUID: wdh4Ebb6S3qdhT3WpzIcFQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="20471327"
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="20471327"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 14:46:07 -0700
X-CSE-ConnectionGUID: oSXveiVST1Wr2eHRPlS0cQ==
X-CSE-MsgGUID: qchH0YYGRTmkty1Qy78DYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="56717986"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Apr 2024 14:46:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Apr 2024 14:46:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 26 Apr 2024 14:46:06 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Apr 2024 14:46:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gdLIIlvWZM/f66e3xYc4BjsKjcwArV6lCSKg/W1o9Y8Br+xnp/+X3DSwdMkrM2wXY+f0lwou44Y1BvRv5aQJ+ATEHpwl1FnfcjA+J8L0vzR9M42+6aNeb+iOG6OXJU1yKiOJvKVjVXzF046euVcxbU1w4UiExwvKRGw4P7YeP48zJkoGVfvnZ7JChGF7NSQtQLc7bafFHaQLHccNn42ROc4ufyGBnPTpZPpFUsqZXXKHEyqYRtZQwUnaAAAxn7RL9NgctoRFwZ2iSMDVxH6M6qbk/hrIIHyQOZ+xp30/2vPAG0sfgz+w77zsmvR5ghkDfzH3ZhL9g/kpXUOfHAs/PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9t2Omr5DLbE28OyLmYStrZVXFXKBIT0lrokRdaWvZ8=;
 b=TyWKzTBwqXfStIVKQT/Z3cXUOfUDfV9bNq00I/4+nAl1hJVn1EwhIqk4w3mf0WQI8K3V8zc45gCblvAiFE16Wh4ql3Wjo8IYL4VB17hBQgpmTHAcRbmCvCWaKfRvSxd/B6Sx7DVTY0/A5jn9/yc5gGkaihy7TytXZeHmfwyd7HzZ+vvVU0epT1LH7M9jlkumkuu/E/fBylIfe/Ch5+Romu1aJMvzxqjNRK1V0dAKViIERxmHAF4qzH8VSU//Aw4yH8Az188tjtKUJpBFrBsjz1fTC1sU4ffuEmOv8KRNjtL/A3FOekf77pnSfdOk86jiHOWj43AoAQ3iOpKC5o5Vpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5636.namprd11.prod.outlook.com (2603:10b6:5:357::21)
 by DS7PR11MB6077.namprd11.prod.outlook.com (2603:10b6:8:87::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Fri, 26 Apr
 2024 21:46:03 +0000
Received: from CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::7c48:3345:4ed4:85e2]) by CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::7c48:3345:4ed4:85e2%6]) with mapi id 15.20.7519.021; Fri, 26 Apr 2024
 21:46:03 +0000
Message-ID: <9e2feef5-b088-49a6-959e-64c6d02faced@intel.com>
Date: Fri, 26 Apr 2024 14:46:02 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: PCI: add vmd documentation
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <linux-pci@vger.kernel.org>, Keith Busch <kbusch@kernel.org>, "Kai-Heng
 Feng" <kai.heng.feng@canonical.com>, "Rafael J. Wysocki"
	<rafael.j.wysocki@intel.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20240426213631.GA594688@bhelgaas>
Content-Language: en-US
From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
In-Reply-To: <20240426213631.GA594688@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0330.namprd04.prod.outlook.com
 (2603:10b6:303:82::35) To CO6PR11MB5636.namprd11.prod.outlook.com
 (2603:10b6:5:357::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5636:EE_|DS7PR11MB6077:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f118d71-75fa-4c7f-321e-08dc663a454c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NVBrWkt1ZFJJTVVvR2JOZWw5WGxWYjhmN3RiRGFnWFhRZE50Wmc0Tml4MWxB?=
 =?utf-8?B?NGxBZUlKL2xadU5VK1pxQ2p0UXNPVFMvZm5NOUNkQU5naDFoMWVOc01DMFU5?=
 =?utf-8?B?aE51ejhpUFhwMWVvY0NLV1J0d01BR2ZBWjRSdGZZLzJJOE1sVVFma1hhZktH?=
 =?utf-8?B?L1RneGFpSVNuSFNqVjhqWVlzWU9OTnM3Z1liUnQ0dXRwVFlTUTQrRjByalJJ?=
 =?utf-8?B?U0pKcTAzeDdZL2xxQXZqeGJENWp1d2FCRHVXWTlrOXg3NHhKb2RHK2Vjb0VG?=
 =?utf-8?B?VFJoUzNDckU4TlVTSFlJbGV5QjRNRGNoQUUyNm9PVWUzZnhyNnNid1J4bVhG?=
 =?utf-8?B?bFFGQjZCWFBkVTU2cm5ya3p3MHBhaXlrTGw0NjRDc1p1a3cxTmJ0WUdpTUJD?=
 =?utf-8?B?M1pMSWNxL0R0T1dvdjhmSjhIT0ZiRXR2OW51U1lEb0MxMWNoN2NrTmlrU0dQ?=
 =?utf-8?B?MCs3Zy9UTTVTdWQ2NU9vUjJVS3JKRkhDaTNrdndDLzhBYlI4YStsYS9xMmp3?=
 =?utf-8?B?QUlMWVdDRGprOGtXTG9tTDNaYXh4VHJ2dW9ZaVYyZ05CU1dPUWlBNldhWlJm?=
 =?utf-8?B?dU1JeS9lMWRYUlBodk4xTGV5cmJrTTVDVy9wL3RnRkxlTlppNTcwWXVoeUM1?=
 =?utf-8?B?QkF4Q0orc215cTA3RmlUTUxpQWlLUE1ZTVJZUFRzU0k2MUsxbjVuR2NHUEp2?=
 =?utf-8?B?Yktab01iaGdJRmVPSVBiOEkzTDAyS25Ld2tGNDl4c2x3S01lcU1RenVlVXl2?=
 =?utf-8?B?N2lIL2ZqQ0FpbmZxNEM0TTRmajNqVFA2RkxaR1lZdCtoajc4bkU4ZS9zUXlx?=
 =?utf-8?B?cmxjWUs5SWQ0ejl3aVpPS2FhVnR1c05xY2RSanZqd1hTVjl3dE1TWW5kOFo1?=
 =?utf-8?B?MC93REhxQ1FDY3pORUhXTUFXWWZNN1Foc3AvNEJLN3Jqb0dvYUdKelg5YXBj?=
 =?utf-8?B?Tnh1WUpZU1VPa29oUE9ZU2RKWGgwUkNjZ1NBZWx5VEFZRXlGVUgveVNKaG12?=
 =?utf-8?B?L2tnMGpTUTdwc2VUeUZxZFZ2WmNKeXlQZHY3N0RKdFk0cEJMUys0dWFyWnVQ?=
 =?utf-8?B?Wk1xVm1rWElXMCtUZ3B6OWNDR1FIV29SVU5EalFOSjFSemZCZmVrMWFnU0hC?=
 =?utf-8?B?K0dDNFdoaWhYTm5RU1RZMWtxRDloVjZsTFlaT0tlZWRTYVZhQVpQaXc1TVhh?=
 =?utf-8?B?aGJJbG9maUpHekNOR2RqSjh4NjVFeWxDc0NCa2o2aFFKdGNzM0lPaGhTK21X?=
 =?utf-8?B?U1R6eDZYTHZ3cklUYkpXa1gvVHZIVlN4ZC9PYlRRcndJN0lHWUZraFN6WkJn?=
 =?utf-8?B?WTVTanNOM1gwcGpkdDI2WUI1SExrdnFOVWJVcmF6aFh5c0l3M3B6c0prMjRl?=
 =?utf-8?B?UDV6dThXQitYS1NIaS9EUXRmVGxkNHppbDV0T3VoYjlkMk9Bb1QrQkFUZm11?=
 =?utf-8?B?TkU3VkszRk5jOVJIeUhOZGlWZGxuTnBNdC96anhLR0tzVFNIMlByY0xCRGJD?=
 =?utf-8?B?NmRyRE5EeWhkUmh2K2x3VUNzY0ZNRzFHcGZZdkZFQlYxZnM3VFRqNEl1Z0ts?=
 =?utf-8?B?K0NXVlFWOXRQWjcvWTVscDFvd3NGTnRUR2RTS0c1dURlTDl3TWMwREdxRXg3?=
 =?utf-8?B?Qmp0c2o1cXlHMklSZXZ3Tmx2UFJhdEtSdkxSTGlzTndKOEZqdzJzdWEyeEpr?=
 =?utf-8?B?WnJ2WUlWTWdUdHBXdFB5OWlGazVGQm5VZndrVTdJanI4Q1M0bjExYitRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5636.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NU1FNVd6d3lRK1c5a3g3cnZOOGEwOHF3Y0QyTkpUanR0UzY5RDE1cFBPZllz?=
 =?utf-8?B?NDFydURyeHNTUmVqYUZSSVFwYVo4N2Q5UWpnVG5lTkk2NkRLY2x3OG9TeWpF?=
 =?utf-8?B?cTM2NzFaemFWQjNHc1pSVWF3WVg2bjIrTHBGWGdlQ2dSVXczNGx1Z0x4dGNh?=
 =?utf-8?B?UStKY0xJM0xwRVF6a2VmMEY5ZDhqeEpuUnlQTEx0eVlJWDJhNHMxSXovWThI?=
 =?utf-8?B?a2lwbXI5a2R6MVo1MkgrUDhXaEl5YzJQTTFyOFE1OWs4eHlONTNvODVBaDVK?=
 =?utf-8?B?Vlliby9BekdNU3cyWjRxVEZVWTF4YjMzMWpUbFEvUFgwUnQ4MXh4azAxQ0FS?=
 =?utf-8?B?MGlNQWpJVm1PNEVTNG5VSXBCVW50R1krVlY0cFBvVHZ6K0JDUldJV2U4c2lI?=
 =?utf-8?B?ZjFVcjBxdDhYdkpncGw1Sk55ZGI2cldqUnYyKzEyRzlJQW93RkhtRnlqcXVG?=
 =?utf-8?B?aW14ZGZXcnliL1JqeVNFVmpkcmRSMnZoTkRTMGlxMHQ3Y1ZYenlmQVBHQm5h?=
 =?utf-8?B?Z24yU0ZuOGd5dDdQS3dMWEdhUjZETm9jMnEyWDFXd0xsbUdVd2VQQUE0SU5B?=
 =?utf-8?B?cjRweUxEZFp6RW5NK09ReDFuQjFqU0g1RjNLVjBSdmFXQ2c5cWxrYzE3UTJi?=
 =?utf-8?B?K2tlTzZmWXRMUnd3cE9vUXB6b2pLSWFNVy9OTXMzRUF0TWhZWTU0R2tpT0FW?=
 =?utf-8?B?Y2x1YUdZMkhoc25FZ3JwRm9xbGRQVVBNcWszMDAvNkRPSDh1YnphQm5VMVhw?=
 =?utf-8?B?TlpzTXVUYW9uOVdrSmtueXJXaUw2SkdTR1FBMHluTFFKdGhJOHNWNmdKaVQr?=
 =?utf-8?B?TE5jYnJpeDhUMFV0T3FRVCtWNnYvZVc4OEY0S2RaZzdibWFYZFJtTE85dzQ2?=
 =?utf-8?B?eDZ6TmNDOHRGN3NlNitNY0FUd0pubDFZNW5oZnlONWc1cno3SWRBcjZRNm0v?=
 =?utf-8?B?SFA5UktuQitraGgrYUlscTBNZ0V1Q2pVWGxMYVpmeXdjT1J0MEJISmlJMWVE?=
 =?utf-8?B?V2tiN2xiNW4yeWFtQWprdHJETVF1ZG5HUm5obm1Uak9EejhWaHRBcEpGZ20x?=
 =?utf-8?B?MXg5ZUM0QVJBVlZqQ29jR3F0Z0ZiV3J1b3BoL0NONUpxaWRNcGloRzhoTmpC?=
 =?utf-8?B?clZkaE5SS2lwdlpxMVBhUjVML2RLZUdPaHYrMjVsSFEyUnZZWkZacEZaRDN1?=
 =?utf-8?B?UER2aWVYYkg5WUUxRlAvZXk4MWxxc3ZkQnp0OUF0ZUcwK21RRDBzbWRlRFBm?=
 =?utf-8?B?cDZrK09BUWF0dTIzZG1HWVJNdU5LeElBdEdVRjVubEpKTkxRZmFaL3BvbkxK?=
 =?utf-8?B?bjVCQnJ0UkE3OGk5SVRFV0xHVEN6ME9pNDhHNFpzMHpuMm5HTjNWdHlLTkVt?=
 =?utf-8?B?Q3ptQjIvd0tIWnl4UzRJbTEzMG10K20vUmN4OENBWjI0eDhNZHVwM3dnYnVp?=
 =?utf-8?B?c0xXS1FseC95MlJwZGJ6SFZUcjg3TDJHcERRRWI1blkwNlZlWVVhUGlMcW1R?=
 =?utf-8?B?bW5sNmlrb1FRUmx3Yk9BdWdQWHZrL3llYkV6QURURkJ4amdaaUZoNHQ1NDVW?=
 =?utf-8?B?UEdqQjVCdGFiUFNUdGs0bkUydk14d1hpQ3hwVTZxSGU4bFVIRURyd0l1ejZC?=
 =?utf-8?B?clMzUHVPdEpTWmhrSHRGV0djZDJrQk9MK1ZNS0RLOU1Ib3RrRWJnQlFrZFBj?=
 =?utf-8?B?VXJkNEZKSU5TVE1kdDk3ekEzWXJYSTBPVWVxTmViVUlldFdJblR2eHYwRm85?=
 =?utf-8?B?cVYxc29hbFJzM09XNzhFUkUyUWdhQlV5M2FLRmM4Y281VHhmRHRPeGE5Vkd2?=
 =?utf-8?B?RjlmNHRwbzJzcWNXNzUyaGJjM2Y2T2sxNWlDengraGtZRXN1TTZpWjdjOUt4?=
 =?utf-8?B?WnBHcWdTeUM2c2x4a3dlbzJURlpqWUU3R291VnIrQnZwalFaeFUvaG9hajRJ?=
 =?utf-8?B?Q051WjlxSThmYkV6NEtNS0ZCaXVmY2lUQ1N1NXdaN1A1b0N6YWpEdnRzWFdP?=
 =?utf-8?B?cXp0QmhyT3Z5TmtOMUpNS1RiejBPM3NiYkR2Q0JLbWZxNi9rVGMzaGVORStk?=
 =?utf-8?B?NWlTdExNcXF1RW9IcG9yNTlibG82L3IzUzlWOWVTemNCQ1JoeHlhQ1JoSEdI?=
 =?utf-8?B?TUdOMGNjcWFLK0hzU0xJZDJXcXM1UnNkNGxpdGdzbzBNUGZLQytNdDZ6NTdB?=
 =?utf-8?B?NEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f118d71-75fa-4c7f-321e-08dc663a454c
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5636.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 21:46:03.7460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /pbGgnSlMrCQX7A31kNSMBdAgbq6M4nkjF1YaG948X7EEBpiKAs/VWjtHCP4aoXOTuP6LnTRQkJonO8WdqcS2OzWytfEW4M7zQUlZqaFRYo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6077
X-OriginatorOrg: intel.com

On 4/26/2024 2:36 PM, Bjorn Helgaas wrote:
> On Thu, Apr 25, 2024 at 04:32:21PM -0700, Paul M Stillwell Jr wrote:
>> On 4/25/2024 3:32 PM, Bjorn Helgaas wrote:
>>> On Thu, Apr 25, 2024 at 02:43:07PM -0700, Paul M Stillwell Jr wrote:
>>>> On 4/25/2024 10:24 AM, Bjorn Helgaas wrote:
>>>>> On Wed, Apr 24, 2024 at 02:29:16PM -0700, Paul M Stillwell Jr wrote:
>>>>>> On 4/23/2024 5:47 PM, Bjorn Helgaas wrote:
>>>> ...
>>>
>>>>>>> _OSC is the only mechanism for negotiating ownership of these
>>>>>>> features, and PCI Firmware r3.3, sec 4.5.1, is pretty clear that _OSC
>>>>>>> only applies to the hierarchy originated by the PNP0A03/PNP0A08 host
>>>>>>> bridge that contains the _OSC method.  AFAICT, there's no
>>>>>>> global/device-specific thing here.
>>>>>>>
>>>>>>> The BIOS may have a single user-visible setting, and it may apply that
>>>>>>> setting to all host bridge _OSC methods, but that's just part of the
>>>>>>> BIOS UI, not part of the firmware/OS interface.
>>>>>>
>>>>>> Fair, but we are still left with the question of how to set the _OSC bits
>>>>>> for the VMD bridge. This would normally happen using ACPI AFAICT and we
>>>>>> don't have that for the devices behind VMD.
>>>>>
>>>>> In the absence of a mechanism for negotiating ownership, e.g., an ACPI
>>>>> host bridge device for the hierarchy, the OS owns all the PCIe
>>>>> features.
>>>>
>>>> I'm new to this space so I don't know what it means for the OS to
>>>> own the features. In other words, how would the vmd driver figure
>>>> out what features are supported?
>>>
>>> There are three things that go into this:
>>>
>>>     - Does the OS support the feature, e.g., is CONFIG_PCIEAER enabled?
>>>
>>>     - Has the platform granted permission to the OS to use the feature,
>>>       either explicitly via _OSC or implicitly because there's no
>>>       mechanism to negotiate ownership?
>>>
>>>     - Does the device advertise the feature, e.g., does it have an AER
>>>       Capability?
>>>
>>> If all three are true, Linux enables the feature.
>>>
>>> I think vmd has implicit ownership of all features because there is no
>>> ACPI host bridge device for the VMD domain, and (IMO) that means there
>>> is no way to negotiate ownership in that domain.
>>>
>>> So the VMD domain starts with all the native_* bits set, meaning Linux
>>> owns the features.  If the vmd driver doesn't want some feature to be
>>> used, it could clear the native_* bit for it.
>>>
>>> I don't think vmd should unilaterally claim ownership of features by
>>> *setting* native_* bits because that will lead to conflicts with
>>> firmware.
>>
>> This is the crux of the problem IMO. I'm happy to set the native_* bits
>> using some knowledge about what the firmware wants, but we don't have a
>> mechanism to do it AFAICT. I think that's what commit 04b12ef163d1 ("PCI:
>> vmd: Honor ACPI _OSC on PCIe features") was trying to do: use a domain that
>> ACPI had run on and negotiated features and apply them to the vmd domain.
> 
> Yes, this is the problem.  We have no information about what firmware
> wants for the VMD domain because there is no ACPI host bridge device.
> 
> We have information about what firmware wants for *other* domains.
> 04b12ef163d1 assumes that also applies to the VMD domain, but I don't
> think that's a good idea.
> 
>> Using the 3 criteria you described above, could we do this for the hotplug
>> feature for VMD:
>>
>> 1. Use IS_ENABLED(CONFIG_<whatever hotplug setting we need>) to check to see
>> if the hotplug feature is enabled
> 
> That's already there.
> 
>> 2. We know that for VMD we want hotplug enabled so that is the implicit
>> permission
> 
> The VMD domain starts with all native_* bits set.  All you have to do
> is avoid *clearing* them.
> 
> The problem (IMO) is that 04b12ef163d1 clears bits based on the _OSC
> for some other domain.
> 
>> 3. Look at the root ports below VMD and see if hotplug capability is set
> 
> This is already there, too.
> 
>> If 1 & 3 are true, then we set the native_* bits for hotplug (we can look
>> for surprise hotplug as well in the capability to set the
>> native_shpc_hotplug bit corrrectly) to 1. This feels like it would solve the
>> problem of "what if there is a hotplug issue on the platform" because the
>> user would have disabled hotplug for VMD and the root ports below it would
>> have the capability turned off.
>>
>> In theory we could do this same thing for all the features, but we don't
>> know what the firmware wants for features other than hotplug (because we
>> implicitly know that vmd wants hotplug). I feel like 04b12ef163d1 is a good
>> compromise for the other features, but I hear your issues with it.
>>
>> I'm happy to "do the right thing" for the other features, I just can't
>> figure out what that thing is :)
> 
> 04b12ef163d1 was motivated by a flood of Correctable Errors.
> 
> Kai-Heng says the errors occur even when booting with
> "pcie_ports=native" and VMD turned off, i.e., when the VMD RCiEP is
> disabled and the NVMe devices appear under plain Root Ports in domain
> 0000.  That suggests that they aren't related to VMD at all.
> 
> I think there's a significant chance that those errors are caused by a
> software defect, e.g., ASPM configuration.  There are many similar
> reports of Correctable Errors where "pcie_aspm=off" is a workaround.
> 
> If we can nail down the root cause of those Correctable Errors, we may
> be able to fix it and just revert 04b12ef163d1.  That would leave all
> the PCIe features owned and enabled by Linux in the VMD domain.  AER
> would be enabled and not a problem, hotplug would be enabled as you
> need, etc.
> 
> There are a zillion reports of these errors and I added comments to
> some to see if anybody can help us get to a root cause.
> 

OK, sounds like the plan for me is to sit tight for now WRT a patch to 
fix hotplug. I'll submit a v2 for the documentation.

Paul


