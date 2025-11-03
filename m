Return-Path: <linux-pci+bounces-40150-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B80C2E5B5
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 00:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5274B4E31C3
	for <lists+linux-pci@lfdr.de>; Mon,  3 Nov 2025 23:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BAA2D3731;
	Mon,  3 Nov 2025 23:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nkV3out+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A836A279DAE
	for <linux-pci@vger.kernel.org>; Mon,  3 Nov 2025 23:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762210920; cv=fail; b=mbDYlt0estrPQDhqmCAhQneSkG1X2amtjFljkxkrZT7CKxpQ0qRh7woitur5q3bxBgQqVFbW0SXumObpN2ps0Mi2RRQO9x4bKeg4tWaXDv3u0KYwIu1RG+kpRUapr2K6p+tBPK4sS2sG8nJ0upiXYZqompP8qq3hoXCLr5GZiaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762210920; c=relaxed/simple;
	bh=/CEV7fs2+EEziDc2nhZpM7w0bLyRtltgDAmzTJveEjc=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=EMIZUkZRf66ynSH/4Bj0nzTm63ebOhEA4vS81D9qucFNh5FAsOC1c+do0LV0jNsh9UfP1UFseqzrxneSHq9vlTv7gkHl85kmo3Y3Oj6z/JLxauf8sZEPPjs7xyFoH/wgCTVuZ162E9kP1CbnuoS0jKROM8Zg7gxXxXzXZJad5ko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nkV3out+; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762210918; x=1793746918;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=/CEV7fs2+EEziDc2nhZpM7w0bLyRtltgDAmzTJveEjc=;
  b=nkV3out+FGkYJlsG7hCQd+wWfL20LfGJNmlMXgD9DrANHDVejVLqYB5o
   ekFktq1xQzImHumLPFtxluxyA8uXTJuAUb7qxGYR0SoO1VmelC/S79X/E
   2sSwwiYpDPG7OW+CrLfGLu6CKtO+/rmyTojO5motoPQZMfJzDq4nk+2Ue
   /hfTS3m8/wjp1H3JNgyxrfREStj6IdoTFKekHL/ndDupijaKN6fHbnLup
   BbV6/6uR/Qc7uufA7YgD6p4g05nCQl13SIpZ/s5mPziGq+hRQXmcyihdz
   AD2Z9zFUcmt14dOiYxU6ErRh+IZl9Io8hGlTrU2d4D+6tph1Bg9df7VwQ
   w==;
X-CSE-ConnectionGUID: KO+q2wtYSv6XO9evHLZHWQ==
X-CSE-MsgGUID: 9wY7NsgrR3K6Mmuzj/09Bw==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="63500672"
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="63500672"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 15:01:57 -0800
X-CSE-ConnectionGUID: ZexUAdivSRm4EeS+SRotTA==
X-CSE-MsgGUID: XWZYaZp7Svy2Dc6XXwqO1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="186855832"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 15:01:58 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 15:01:57 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 3 Nov 2025 15:01:57 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.27)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 15:01:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fHAsMGldbPy2kU68sTsBjOOaPXMpvR9yNxMMRa0u48CY5wNuvZ1OdeUCEGCumVAj8py/L6hQJYRmUaQEailoVc8WkahrZ92a2/exWuRRtSlY01JKPLBy7/def+lJoqz023emrExpvXJA6coqpkWCGqbO3dv8fc1s0AqvTCLWKHOwaRYXfKL9i7apRfCjUlPvJGw744sVopBjCZiufEyiAU32A+6Fmuzce1AKGU8QfaqYhqlYGwJ4lqK84EiJEuihJFkavie+tnAMfmeJC2IfYymfvJR6PagwIMx3NicrV6bCs5xgG4Ba0BPVsQ5Xex2FBOZQsWt5gZi7dT8d05nyug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P4gFtYqhdVaxaXGjOMynPxE+MQwfQrtqSyL5m7B4aBk=;
 b=gYkN+ST/xu5we2jsE9e1BzOoj/AE1jWlkxopWA/nt7/1f8GPDTgFbqnEcbcA2r0EcCn+uz0B/OhVHgGfM4gKfl9HNgGn9LEhn466ygDIs6TtY8ZsJTnGQ2rC1KOvAbTdkIpW2YeM1karE+3O59IENiF/pbY/L3C+OArZIGcngsDLFB+sF0MXlacpyIVyzjT9gk5g5mQ2BxMyMz736uZfoEjQfgYf5Zl0Vt9SvnlkQayexL2iobJE2mmIU97wggjwbSIZ2GptfT3wypOrc90rN5tP4RoVpJlmvFtKG2HKBd7EkhGkCifIG16XO7uEhVi6hrm1VlOtjvdu8apTOEi/SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA4PR11MB9130.namprd11.prod.outlook.com (2603:10b6:208:56c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 23:01:49 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 23:01:49 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 3 Nov 2025 15:01:48 -0800
To: Jonathan Cameron <jonathan.cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<xin@zytor.com>, <chao.gao@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>
Message-ID: <6909345c25061_74f59100c6@dwillia2-mobl4.notmuch>
In-Reply-To: <20251030101618.00005011@huawei.com>
References: <20250919142237.418648-1-dan.j.williams@intel.com>
 <20250919142237.418648-2-dan.j.williams@intel.com>
 <20251030101618.00005011@huawei.com>
Subject: Re: [RFC PATCH 01/27] coco/tdx-host: Introduce a "tdx_host" device
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0203.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA4PR11MB9130:EE_
X-MS-Office365-Filtering-Correlation-Id: e3d524af-aaf4-4566-4ddf-08de1b2cf88e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VXY0SFhxOVhvdHZzV0lrMG9xb3ZPMHhCek1kamZNbTRXVTFxT2ZWZnp2QW56?=
 =?utf-8?B?YjNWRHNhclFTaTlSK29MTnNaTG4wMlh0OUtMeTQ1bHlya0JiejFIREZ1NjBE?=
 =?utf-8?B?djZFdzB3enh4cG9XM0NYVzk5djBQdlpvNlk1aHZOWUhVbVF4eVBQY1NYbkxX?=
 =?utf-8?B?bmQ2RlQwS2JEL00zZTEvamloNHpFd1d0dC9nZm1GSnk0cTVQc2NnUktsZ0ow?=
 =?utf-8?B?OW9paCtYeDlmZDhLQlQ4bm1qSmJmK3NxVWJoVUIvUTFjN0MwYUVtc0NTU08y?=
 =?utf-8?B?R0JWbUpFYWEydERxNE1VQ0RvYmd1di9sNWRFZVVnb2dWZ2c5TXNObGxRVmE0?=
 =?utf-8?B?aDdQcGh0WUlEZW5vUFFhbDVtTzFwbkQ4MXFaZHUzMjRPQmQ3V0VyU1JCbENX?=
 =?utf-8?B?U2hPOUpjQjZiNTduRlQxQU9wa1VReUZRVGcvN3BvbCtlYmV4MXRGc3lJRzR5?=
 =?utf-8?B?a0N0MkQ3RlJNemRZOWRqeld3TWNjalNYSUFlclhKSGRNejRsWUZuMExWMC9Y?=
 =?utf-8?B?RjRUUDRzWmJMcHF1MHhjK2JqSmhOSTBOZ1BMMUtueUVBZjJiajVYRGFBazVt?=
 =?utf-8?B?ZWgzS1NqY21Vb1kzNE5ia2lxMUtuL2c3RS9iUTRFcmg0SEdXd20zUmJWbEg3?=
 =?utf-8?B?Y3VKOWdoTDluNksvWGt4dk82N25Xcmx5N2N5YTYrM0VuQ3RNOGpXc285ZHpH?=
 =?utf-8?B?cHlwcVJwZXlOYzNPNjN6dzYzN0k5YWdJb0xwTTJDZW5FZExUeWVlZ3crcE1V?=
 =?utf-8?B?Q2Q0WHM2cFpEbEp6N25HVm9qaW5mWmp5cnNHQm5pWEFpeEtRM1VQd21Udng2?=
 =?utf-8?B?UG5YQUFEeEZHWUY5Y3hZQVpSV0xWRlM5Q05KbUFYODVROEMxOFJtdm1VTnR3?=
 =?utf-8?B?UUlFbTM1VVU0b3NTUm5Ec2dFdndiUSt4THUyUU1QK20rUmh0eTlOWnJVcjNI?=
 =?utf-8?B?bng4cGxFaTNBVGVJZU12eElCbjBXWEE2U2ZNN25RZ0F3cjJHOWFWYTZUMUto?=
 =?utf-8?B?QjdxZW8rc1VTUnF1OXFEZ25tWnpPYWNLNktKUEpjSHBXbTFyYUs2c3pLTXZn?=
 =?utf-8?B?T2FSVUpmWmhVV2w2dUxFYkRoOEYxbldLbXFHWFVhQkVLQldMMUF5alpqY2hB?=
 =?utf-8?B?RWgvRG4xclVaRnMzdE1BUW1zTlU1YTRybWtCNDByRlRlZzY0TWRaZ3hGWElR?=
 =?utf-8?B?SkNBSEUvc2ozK1pwQldkOGgxS3JuditkSWFXUE5CT3d6YW1jOU1uMW1Yc09o?=
 =?utf-8?B?bWdBQ0d3WElhMVpSNTZyOXYxbnNYTkNUNWp3TXlSOVA2NFFkSCt1NWhNUUpy?=
 =?utf-8?B?MWRNRmtKUUUyVmZjV1Bkd2NHcFNWczh4MGxCUVdzRHN2a0F1MHYzY3JLZzBN?=
 =?utf-8?B?NndQSWtuWHlpYW5BVzR1NzFPOGwxOHpmUVdzb1ZVS0ZHQllFQzQwWFFSRGU0?=
 =?utf-8?B?Z0t1T05MSUdZVGhDV2E5b0ZvVUc2QXhtdmkrYUt1clZyQWd0Y3NIWjhkeUpx?=
 =?utf-8?B?NGlkTFl1b2Y0UTBSNUgzZFpsdXRGRDBSd1pRZ3lIS1c2SGhBZXF0NklsaFNi?=
 =?utf-8?B?VHQ0UGx1WHU4RmJNL1RJeC82QlpTT01STkM2TUtvRUphV2JxVGVsR3ExTFda?=
 =?utf-8?B?blE0cngzbHJERmtCc21oc0ppV2ZvN25vYlUzK1dqcVYwZHJ2ZURkNlNVT0lF?=
 =?utf-8?B?TGo4cDNuSjhjNlFOUGIraExmazlUSmFyNG82MS9OT0NQbXpETDFIdVBINjJP?=
 =?utf-8?B?clRReWFSY1d5VnZIZEgvTWJRdVlmZzVFY0VKZlVjSHFIVWtBWUZOMWJyWXls?=
 =?utf-8?B?Ym9QT041aFhBblI5OVJ2U21Bb2llekQ0enpGSFp5SDBjeks2UXBpemJIempz?=
 =?utf-8?B?bGxQNmhXcWVCaW84SkdUSENhcEdxK1M1ZXExVVROeXJkRWtiRzRZRlIvZ0NZ?=
 =?utf-8?B?OEw0d2ppeXFWVmZsajYxTmZ0NVU4aWpQb1JnUm1JaFJKR0Z2WkNuZlROMUJG?=
 =?utf-8?B?RjM0K1djUUlBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUkxaVdEQTJRVlpaRStCVzNYNHVZTnIwelVyQ09CWDA2L1liUmtHa0F3T2Er?=
 =?utf-8?B?WkhRTytlRDdpbENFU2xzWjZMd093aHBGQ0p3MHRuOXhvVkVTSldTRzNtQ05T?=
 =?utf-8?B?WlZiTUlUeVZwYVZVM0FmRDVuUm1EaGlVeVNTUlc0TEpJeHhmWVRuZGdEYkQx?=
 =?utf-8?B?VGNIWllEMmE5RTBiRUREUEx6K2prazhZSENKVURtMFhYd1NjUUlQRHVvM1Fq?=
 =?utf-8?B?d1VDN0llMTl1UUVDTnNFblpKVjVORVdUQUd0QkF0RlZramU1TS9LUHhoa1o1?=
 =?utf-8?B?MFhhWWRmenB5aTNaa1N1UFY1Y0tlcWJnVDRCNzhIZmJyamt1dndPSDhSV0tu?=
 =?utf-8?B?RTJMWVkxMjFtQUk1VkJjbERGL1VJbmhHSTVaS3Mxd1pYYzVRclJ6M3BtWGVH?=
 =?utf-8?B?Y2Z3WFFwckx1NjErM3pDeU9HVC9NY3JuQWJRZitZNDhHaXJub1Vhc0ZRZ2dW?=
 =?utf-8?B?TjNmb3BuQnBrVUd4aWNWNndqdEQ1R0dRMzF2QVRselArNUxEdm1qUCtMNWpQ?=
 =?utf-8?B?RHBKbnNwYmlZWm5BRU5PUkI4aFFUWnpSbkpsNmx6Y0J0VzdBOWpFZzhVMTU4?=
 =?utf-8?B?TXRVR3JKaTdZdERwWXMwZ0Jvd1QrcHRuNmlnRUJyR3NnUE1xQ250L2hJUTN6?=
 =?utf-8?B?THJ1eEJScUFpMmh5T2hUajB4Q2QzMVZGUThPaDNBeXZxYTBQWU1NTWp0eFM1?=
 =?utf-8?B?Rm1heU1JZ3kzZUdTZGZUM2hySFpNRjNQb1Z0OGhheFpEdzBYVjY4d29ZS042?=
 =?utf-8?B?WGJ4TUMvR2k5VE5tVlRkNUwwNHJmREtPUTZ4NmZ4ZHhVNi9wT0NCZGRhTTdU?=
 =?utf-8?B?T0xPNkRzTUZlMlI3a3RiNnFTWjQ4Q3VFWGhGd09FODc3VitDZzN6dTQ0SE4x?=
 =?utf-8?B?Q0krNmdPUHR3Y0VLSDY1bE0xODRNMm5jRFAyWGJmVDNqclZhekFMUWE0Tm5J?=
 =?utf-8?B?UlFCQnhWN1VnTEdoT1Q2TGh6ZVNxRzNoY01KWmZtRlo3VWRSRytiRkk5Z2w3?=
 =?utf-8?B?aEpNZ2lEQzlzcGtnTVlxMmhZS0Jqck5OYjQ4YXZORTI2Y3ppcFk1Z0xXVCs0?=
 =?utf-8?B?UkNlMEw4bnI4UjlsQk9qdUFvYXF5OWQxcTJzT3l3MUloUlNKcUEvYWl3MUdT?=
 =?utf-8?B?VGpkTVYvUTNJVzZ1dDBIL21xV2Z0SVhZNVdOSWZLYUFYc25sSHVqRU9lNzFt?=
 =?utf-8?B?MHB6bW9FdzdpUlR2R2VtMEgzL0JaRXpsWVk5aExndnIxVkRHNGxXajNRbDV1?=
 =?utf-8?B?UVRQdUgzUitoZjJMRjE1RVlZdndicnIyVVFpRFE2SndidXFBWmpRTW1OelA1?=
 =?utf-8?B?ckYrQU41Vit5K3haU1dGcllxdUNnWWtGTEd5K0RKWWVRVlpRVVlud0l3dS9Y?=
 =?utf-8?B?ckl3SmkxYlcvQ2VxbkNmYkN4UkN0WjQ3UitWRGNoRHZMMW9zZGlHTCtGaG1R?=
 =?utf-8?B?V0pZc0N4SS9pWG05T3p5NVRPWGVrVHBpdEx2ZktSelA2MEEvY1V5ZjJYSk8x?=
 =?utf-8?B?dFlRdFNweTlZWE1PdFFJVURYcWlsa1pkeWdMcnAzSlVCSjdDQ21tck5YTVRQ?=
 =?utf-8?B?Q0R0RU53M1RIMlF3SHhnOEZzWGFhUUtySElJRFpmdXJBMndCanBKN0V4eVdh?=
 =?utf-8?B?SGtrVDNMeG1hZklMNUR5M3M4Rm50aTdlQVNnT3JJMzI5VnczbDdNaE9NOGY4?=
 =?utf-8?B?QWpBNzVXSUt4Zjh0QmRXM2Y0OGFKcVZ0MWFwS0RkSVlxbmZnUmo1R1A4cDFy?=
 =?utf-8?B?NFZyOCsxRDlja0srMFNOdURTZ09GSmdXeWhyN3ZjQ2x6WGo5MHlHZUcyaXlz?=
 =?utf-8?B?bEpQQnBUWWN3NEY4eHVPQndlQU1sS1FmYkxNWW1FNng4QkxBelp1MWJvYStU?=
 =?utf-8?B?Uk5mb3BQbDNldUMydDhxUHMvQjRsQVBxL1A0YjZVcVMzc080U3YvZi95MmdI?=
 =?utf-8?B?clFqSGk4dU9DbE16b2o0YUR2M2toQjNxSjhGZzNnK2JWVWNwdGNoRyt3Q1Yy?=
 =?utf-8?B?dU9nRm1jRFlzRnJSa1V5a2hRazM1ZGRFK0ZRY29QUUk4Nzh3bHlCV21Yd092?=
 =?utf-8?B?NHkzTUdMK1hZZUlSd3lSSHd2Y1J1UXFWUml4NDZRUXJxTW9VcFk0ZXJPYVZ5?=
 =?utf-8?B?aldkWGhhUHBHeDhnY3BMSjBJOHdMak9tSFFFQVhIV3ZQcDRESEZ4NmEyMEtT?=
 =?utf-8?B?NWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e3d524af-aaf4-4566-4ddf-08de1b2cf88e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 23:01:49.8185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RRdTtPSGs+FxT229rk6w0vtsq8niyKYP28+jSNQiZx23BDNGqX82z07iRTY31vS1uWgT7TSWJuEmu0TwbRpMP3DAZiaJb2ufwUEuGPb+an0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9130
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Fri, 19 Sep 2025 07:22:10 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > From: Chao Gao <chao.gao@intel.com>
> > 
> > TDX depends on a platform firmware module that is invoked via instructions
> > similar to vmenter (i.e. enter into a new privileged "root-mode" context to
> > manage private memory and private device mechanisms). It is a software
> > construct that depends on the CPU vmxon state to enable invocation of
> > TDX-module ABIs. Unlike other Trusted Execution Environment (TEE) platform
> > implementations that employ a firmware module running on a PCI device with
> > an MMIO mailbox for communication, TDX has no hardware device to point to
> > as the TEE Secure Manager (TSM).
> > 
> > Create a virtual device not only to align with other implementations but
> > also to make it easier to
> > 
> >  - expose metadata (e.g., TDX module version, seamldr version etc) to
> >    the userspace as device attributes
> > 
> >  - implement firmware uploader APIs which are tied to a device. This is
> >    needed to support TDX module runtime updates
> > 
> >  - enable TDX Connect which will share a common infrastructure with other
> >    platform implementations. In the TDX Connect context, every
> >    architecture has a TSM, represented by a PCIe or virtual device. The
> >    new "tdx_host" device will serve the TSM role.
> > 
> > A faux device is used as for TDX because the TDX module is singular within
> > the system and lacks associated platform resources. Using a faux device
> > eliminates the need to create a stub bus.
> > 
> > The call to tdx_enable() makes the new module independent of kvm_intel.ko.
> > For example, TDX Connect may be used to established to PCIe link encryption
> > even if a TVM is never launched.  For now, just create the common loading
> > infrastructure.
> > 
> > Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
> > Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> > Signed-off-by: Chao Gao <chao.gao@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> I'm only taking a look to see a second example of how the core
> code is used as I care mostly about the ARM one.  Anyhow, a
> few passing comments inline.

Thanks for taking a look at a cross-arch RFC.

> 
> > diff --git a/drivers/virt/coco/tdx-host/tdx-host.c b/drivers/virt/coco/tdx-host/tdx-host.c
> > new file mode 100644
> > index 000000000000..49c205913ef6
> > --- /dev/null
> > +++ b/drivers/virt/coco/tdx-host/tdx-host.c
> > @@ -0,0 +1,52 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * TDX host user interface driver
> > + *
> > + * Copyright (C) 2025 Intel Corporation
> > + */
> > +
> > +#include <linux/kernel.h>
> 
> There is general rework ongoing to stop including kernel.h except
> where strictly necessary.  Please check exactly what you need and
> see if one or more more specific headers is appropriate.

Sure, easy enough to clean up.

> > +#include <linux/module.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/sysfs.h>
> 
> Bring headers in with the patch that first uses them. I'm not immediately
> spotting anything from this one in this patch.  Doing that just makes
> it easier to see if there are excess headers included at the end of
> building up the driver across a series.
> 
> > +#include <linux/device/faux.h>
> > +#include <asm/cpu_device_id.h>
> > +#include <asm/tdx.h>
> > +#include <asm/tdx_global_metadata.h>
> > +
> > +static const struct x86_cpu_id tdx_host_ids[] = {
> > +	X86_MATCH_FEATURE(X86_FEATURE_TDX_HOST_PLATFORM, NULL),
> > +	{}
> > +};
> > +MODULE_DEVICE_TABLE(x86cpu, tdx_host_ids);
> > +
> > +static struct faux_device *fdev;
> > +
> > +static int __init tdx_host_init(void)
> > +{
> > +	int r;
> > +
> > +	if (!x86_match_cpu(tdx_host_ids))
> > +		return -ENODEV;
> > +
> > +	/* Enable the usage of SEAMCALLs */
> 
> What's the logic behind doing that here rather than in probe
> for the faux device?  Perhaps add something to this comment.

For this specific case of tdx_enable() it will be obviated by the fact
that the new direction is to always enable TDX early [1].

[1]: http://lore.kernel.org/20251010220403.987927-1-seanjc@google.com

Otherwise there are cases where we might create the device without a
driver. E.g. sysfs ABI only for updates, vs also enabling PCI/TSM
services via a driver attached to this device.

