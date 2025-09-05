Return-Path: <linux-pci+bounces-35575-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC07B4646F
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 22:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6EF4AA1F68
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 20:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540272848B4;
	Fri,  5 Sep 2025 20:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xdca7nYt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6C228488D
	for <linux-pci@vger.kernel.org>; Fri,  5 Sep 2025 20:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757103210; cv=fail; b=hAvaam1L6jGvBanoZDzldPMx2AqshFzXWv3p9aIqDQtwOm8UqflTnFjvQ9kPNemegG0lVBMnclI0tyIKwUwqklbZJ7QhK+DCfYgwJ0Kidln9GDQ8u+GKVOBYezv6aXZ/Z+rAczezFj1aJ5L9lx8VVx07dsg9Xq3Z8ebfoVCNm2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757103210; c=relaxed/simple;
	bh=M0Akl4ElmKgJH+FHkSqlMQzccVoQgMXn8shC7aDEQpw=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=YNwKnvCmyjwkrroxB/bHMszTZT1SoRgBV8ZwNql8lokVZNh7WA2a6DoWzTKZD3QyVo9lS08W2djNKFHTBM9AwIlPIG1AxeuTu2QPubrAFx+dTiHzKGID3wZxHtcPYykxRp0XY9ulGgaU9EgcT3q/NMOsbL+cuVUgPmLnwnRn6Wo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xdca7nYt; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757103208; x=1788639208;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=M0Akl4ElmKgJH+FHkSqlMQzccVoQgMXn8shC7aDEQpw=;
  b=Xdca7nYt3au1aZIMLbWryiPBb3C7ZW29ZuygC2QAJJXQA0aUXJj/fUQE
   k+hupDBTzb+Cpqnr2kyNH+X43Av1evm4s62lidgTVgLSiV4T/6xaYxK6Y
   Hy4ppv70uskao3lmyZDDyKkSHz/LdKZaYMmmszGjbjCKRwJTomyqZ+Mo8
   njU7dVsaTqi6XdhObmJri3TaxEBLGiGoYOhizF+Q5IqMVuUZ+4LmKKXj6
   wyFeGa9NTjPLzOW1Woy9IAEwLKZU9i6a1grMQW1eOpCIBUrHj34OpR7ot
   Gi8lvDcGiGMrisAuVEIqjdv8jVomp3wCOg9/WVmXKzskUDp62DkeYf3RI
   g==;
X-CSE-ConnectionGUID: jP4G31rES7aUQO0Bmti7xg==
X-CSE-MsgGUID: 6K04xlWvQ/GTQYCYusQS4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11544"; a="76914798"
X-IronPort-AV: E=Sophos;i="6.18,242,1751266800"; 
   d="scan'208";a="76914798"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 13:13:28 -0700
X-CSE-ConnectionGUID: FxOdFJiDQv6Hv4D376elkA==
X-CSE-MsgGUID: mQxJnwI+ReSVSfpxGuZnZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,242,1751266800"; 
   d="scan'208";a="172356381"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 13:13:28 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 13:13:27 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 5 Sep 2025 13:13:27 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.42)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 13:13:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WTEmRoQTTtXqF178es30PPnQtEUK1jRt/IXLi8e8Kcn5U2mDOGwf7FL6Y95lP1DpMNm8kLcXujFJ9BaTHxOXpz330dzrJOUWABwk84UD5Ilhpw78P5bycxIB3uh/yqUl5fPjm5Jr0jSZJ8sL9RPlrqwTt36KPILzhR0O9mW9Tdps9Jli267JB1nUGDHw2DvH/mJKNJS/5v0SVliHWUj0obs9hgG9bmW1oEfhfUT0iT9zv/c7ufoPol2Hy8QwoqOd8U7i3UTM+X3Up390CRf1nlqVqEG5HF16rYWCWBD3W3D6djixbY2pJNu7b+e/CwebmR3AevhtZ0cZIVrEC5mR0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rXCODDTXtfkT7MQYF9JfyeZN3URWuIA9Mi6Cxh8h5GU=;
 b=RmjVRthnYePYmE+tvf49xDAmpPUHN/Qww3Hc5g7y1D4wbItu49h5Ou/FHHlQXMqvzuAzx+pRhgqWVVgVfLBH0zY3I0gVlY7zcjYHyvzrxty35DK6xGktNgRHwO6Dzsfuaa4sQaYDOCYVtnNU5mUYbFIoF6OdkkNsvaE0cvw8g/5FqL2sco+AjRQNF0aLlJVenwBIp5RxJRj+Y/VxwjvMtolwnLEIGD8DDKEtJ3+Iwwe+iF9zHy8T2usSdIElUSA7HQFgN+uIn06JmxFdvcB6/ubExounZXzbmA2ZV/PE7GHV4IqnVU2tjD0t4vgAc694fgnWI0CQ5tFhFkmTXBjZUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by IA1PR11MB8802.namprd11.prod.outlook.com (2603:10b6:208:598::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Fri, 5 Sep
 2025 20:13:25 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec%4]) with mapi id 15.20.9073.026; Fri, 5 Sep 2025
 20:13:25 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 5 Sep 2025 13:13:23 -0700
To: Alexey Kardashevskiy <aik@amd.com>, Aneesh Kumar K.V
	<aneesh.kumar@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
	<linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>
CC: <yilun.xu@linux.intel.com>, <gregkh@linuxfoundation.org>, Lukas Wunner
	<lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, Bjorn Helgaas
	<bhelgaas@google.com>
Message-ID: <68bb44634e595_75db10066@dwillia2-mobl4.notmuch>
In-Reply-To: <8be9cd2d-6a13-40ed-97af-0a6129b2756b@amd.com>
References: <20250827035126.1356683-1-dan.j.williams@intel.com>
 <20250827035126.1356683-5-dan.j.williams@intel.com>
 <yq5a1poo3n1f.fsf@kernel.org>
 <8be9cd2d-6a13-40ed-97af-0a6129b2756b@amd.com>
Subject: Re: [PATCH v5 04/10] PCI/TSM: Authenticate devices via platform TSM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0008.namprd05.prod.outlook.com
 (2603:10b6:a03:254::13) To SA3PR11MB8118.namprd11.prod.outlook.com
 (2603:10b6:806:2f1::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|IA1PR11MB8802:EE_
X-MS-Office365-Filtering-Correlation-Id: f6a1b558-8adf-48fb-31c4-08ddecb8ab8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WEpiUCtzTENCT3k5QW5QTEcxOHFSa2oyREhNQlVPcWlkeGd6bEVRMnhNME00?=
 =?utf-8?B?NUl3Ui83SExSRkRjY1htSjhhaWdEdmdwUDhEV2dUU01pNGl2eXBiREFCOTEx?=
 =?utf-8?B?UDBLbUpiVndjbHpMdnpEWEVqZ0FuYXp1QzRvcFhtMzN3TWZQV3l5Z2o3dWJ5?=
 =?utf-8?B?Z3dZbHA4dHNLQWN1K2F6aTdLSlk1ZWNUTVdyanQ1cVBSY1J2UTV5MW5sbkFO?=
 =?utf-8?B?a0pJMStCckM4aFlFYjNxVHF3S3gyTXdzcHJsbXd0Tm5PWUpQVjdlb0pHK2xS?=
 =?utf-8?B?bHdiaFFFdTIvL2dFOXc5NGJucXhTeXc2bjBVdStacXc2dTVFRW9UV081NllL?=
 =?utf-8?B?aFNDS0pqdURMWVI1VFdQbVpSWnNpbTRYRkhHbGlNUDBIWmI4QnlCeldRQi9U?=
 =?utf-8?B?Wm5zV0E5bEQxU21WeDY1a0RjMmhFa2tWeTJoMDZHYUNzK0dKMHkrcHdtdkJl?=
 =?utf-8?B?ekNLemd4NE0vOHRhTEs5M2tLMndYYUd0THpLTUUrcjZIZU10WngwakU1TkVY?=
 =?utf-8?B?QStWeEdFdG9DYW8xVGFvSWdHeFhuTFBITU5JOFpMTHJjbU5xMGdtWWtJUVRR?=
 =?utf-8?B?Um9DTERHeDRSRVlYcTYwbUprdVQxVkxTSFdKWGJUNUtxMmpWaEdvSVZISCs1?=
 =?utf-8?B?YkZZdGRPeTRHeTV6RTRWcUFOUG44cTU1eDZvWEdpeUtKc0ExQThscFVpdjRT?=
 =?utf-8?B?MSs4QlRyb0R4dGh2WHNtSzFUbVd1aWxzRXRQWCtqV1ZDNnNGajAxMUZEZG44?=
 =?utf-8?B?bW9vczhXWUVKUm5pTG40WWQ0ZDNoY2JtN1pSZFlDcnFVcVk1T016dHlkd0JG?=
 =?utf-8?B?MHNkcWFUZDgwYXZsQUs2NDQ5TUVraWYzM2FqYW9aSnVCMHNtQmdsUWRoY1c1?=
 =?utf-8?B?cmY0RFIyZU1tOHhiTDV1a1crckN6YzhrbktOYSt6QzZGYWgydW5zU1BLUUp3?=
 =?utf-8?B?UFlkcHoxVmRMSzh6amI4M0U5M0dnZGRWNkxjSzR3aDNvUVVCVnFYTHVCaFAv?=
 =?utf-8?B?V29JRDJlTWVtc0FxYThhMGlPOCtKcjM1Nk9hbGppOW1YcFdxWTFOUG13VW1E?=
 =?utf-8?B?WDdHd1NUdk96RlBJZzk1eW1sN3VnaW55YktFUmpLaE8xTlUwejJaSGV6Y2gz?=
 =?utf-8?B?bzl2SENhV2U2aTFXdHJhTUViNDljOEtPWTNJbVROb1VYa2FIditDd3VnZDBO?=
 =?utf-8?B?c016SU5BREVuUXZHNDNyZWY0SDVURUJxNUc3aSswbDcyc3FNMWJnUzZ4SnhL?=
 =?utf-8?B?MlVqcWxLMmYxYkk1Ym5uanVuNkdaSkdJMjhlQnJ6R3VUTG9XNUxRdjhpeHVn?=
 =?utf-8?B?UUZpelZySGx0c1ZoTC9jOW4wQUpGb3NNODlzRHZkT2dPNHIyZHlUWDcrU0Vy?=
 =?utf-8?B?Zjh6S1FadHliMEREWFB2MGtpR3dZOFNUZks2aWZQSmtkNzIyUkM3djB6NGZo?=
 =?utf-8?B?L2ZMWHFvN2p5QnBUYUh4RDVEVlpnTy9NY01ZVkNKQXI1ajBBc1IwcHZUU1lI?=
 =?utf-8?B?UVkxcFVrZWN1dWw5KzNrN2Z2cld5VHFSMERIL0lOaUVBcEt5R1E4amJReW9N?=
 =?utf-8?B?TnNTVjgxeGwxWFdSVjloZW5BR1JqUjVERjdXLy9kSkFhRnY2eFU4dWtud2t0?=
 =?utf-8?B?YlNFMkkwMEtPYW5RMzNrNHJFSExmUW4wbEx2ODg3c2paTy9IOFJkY004ZXpq?=
 =?utf-8?B?b3JlMW1jVENiMTV4SHo5ZkZoeEtDRWU2VXVaMS9aNnpLYjhoSWFuZFhHdlBs?=
 =?utf-8?B?Z1hPamJXSFhMUnZvQ0NIUGlFZHZMWFNSeW5tUVEyUTVBWjBwSG9EMW5hUmky?=
 =?utf-8?B?QnlyZ2s0Qzg1UU1SSEl2cE43dWluaXcrYkVyNTgzZFFJbC9mSjNsb2d5VGdl?=
 =?utf-8?B?YW1qOC9COUY3ZzhOaHM0a0NkM1RGbjFDSTV0bGxyUzZ6ZlRtaWRWeUVleGpK?=
 =?utf-8?Q?abQ5kwPx044=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b01zSzR0NWZVQWxoeEl6UWZOdnRMOWxtdHFadkxvZ2haK3JPZzg1QXhvWVBP?=
 =?utf-8?B?WlN4ZGVEZzZvNW9lRTFTR01hRlQ2TU5TRU9ab3RYb0hpcVRTUnh1OGdwQloy?=
 =?utf-8?B?ZFltdThDK2hiYUYwcDJibGgzMGpxeEp3ZUFRVXdHMWx3eHVoMXNBS2k0M3dD?=
 =?utf-8?B?K092RmVVcW12MmVxOElldUxGVk93bDlPa3BRdXpkU3VZRWJQclUza2dFUjc0?=
 =?utf-8?B?UXloazVnSGFvUGtyU20ybGtNRVhsOFJERDhZK2ZMcVUxZkpWWGo0RmlZcytG?=
 =?utf-8?B?WTB2a2lFbDNXa3JqKzlpbEN2YWE1MzVTTm16TUYyRGFRNWttMUhTSE1pemtO?=
 =?utf-8?B?Y2pOeTlNL0Y3aS9QT3Q2UGF4VlhwRkg0MHZnanhxYXBJNDNpWG9XRER6cUVk?=
 =?utf-8?B?OElpMTFpOWo2V2hRNnpPYTlEMXpRSU1WTks4OG5MVjlCS0h3S2RJMzR0WkZJ?=
 =?utf-8?B?Q2dQUGtoQUhMUDZhWHBuLzBCSUc3N1BBTlZUV2tjeG1DQWxNU0ZvWkZQMVp1?=
 =?utf-8?B?L01wL1pDTTlCbDBNL1FpZ2h4VXZ2akNyeGI0SmF3dGRlZXhoL2UwemhqVXZB?=
 =?utf-8?B?dDZ4dEg5eW02TmJ2dHpjSDgwcHFSZHpFR29LdVdzUE9XY0hxci91UHVkMmFM?=
 =?utf-8?B?YnZ3dmF0SG1neVFwT2I2ZW0zQ2FaS3UzWHRIWnpuQkN4MGJjQVlaZ1VjQWN1?=
 =?utf-8?B?YUtSVXdiUElEWm80d2ZlNkhTVEpTcVRFZzJKVUVDWmg3VEp1azN6Q3FMUDJR?=
 =?utf-8?B?WEYvUnhaMmhtaytGSDlKOHYyd0pQdGxEU3hLMDBoTmhyOVpyOVFHay9sQzVI?=
 =?utf-8?B?UGNJdjlJV0FRRmxSZkl1dy94NTM1bzlXcDIxWTQ5cENPb0FzVTRqOGlheHNy?=
 =?utf-8?B?Si9MTzRxbkJQb091bGsxZVdheVN2Y0xjZWVsMm1OQkJSdktXWTlsRjIxdU5J?=
 =?utf-8?B?a0pTOGxWdnhiWGt4N084aXd3elNyVjhwRFN2WHhDTG9EWHd0KzV1bzdJR3dk?=
 =?utf-8?B?dnNZNzRsbWxkaVd1SSs0WGpvV2Yxc1FHN2kwL2N4am9vZ0FOYVBsRE1nanBt?=
 =?utf-8?B?T0xtSitOcTN4aGwzVlFvZFpIUG1seGhoN0ZnMnNBeDgrSE0vVFg1WVJJSW1u?=
 =?utf-8?B?TWpTdW1BQ1U3RDAxVmhodWdzbG9IR3loZnZVSWROaGJ5OUYrVXd0Y093NlIx?=
 =?utf-8?B?WVEyQUw4WVhuOFRxbGF5QlJYcFdlalNGc3BpbWUrei9kQmVPYTVPS3VlSnJt?=
 =?utf-8?B?RjhmUUdCWmc3U2NkWTZSTEcrN3JsQ2pBdXBEM3Y0MDQ4bWg2KzVPaHZobVZY?=
 =?utf-8?B?THJZYUY3R0NyOUdBSVFBT3B4S0o4eGZ3eGNvejhLZW5OSGhwU2gvL0Jma3Nr?=
 =?utf-8?B?WTgwbkx5dnN4UHFVOVhzSlM0QTVrU3FudnBxZWhjZXF3dE9PT20ra3lhOG5s?=
 =?utf-8?B?SjNrdWdzakZCcit6TGVsRzR3aHp1QWRudVVxNWdFa0VXNEVtOXdHcGZsUWJT?=
 =?utf-8?B?TlY2eG9lWlFOTDhWdkRTd2pVemtWdTVleFFtL1Y5UUhWMmhhZWpHM3JQRkcv?=
 =?utf-8?B?ZVdFRWRQWVM4MVAvWmNnT0d1amQvMmxzNEF6Q09sWU9qNWcwZi9Xa0NFeTBr?=
 =?utf-8?B?N2MrOWg4c1RCaHZkb2xYY3RRRlF5QzhXMEVuUWxsRXczRER5Z0J0RGs4bGUv?=
 =?utf-8?B?RWx0Y1RTSVYzaUgvNy9sZ3h2VmRpVWwwczFNbWFYSXJPLzJaVisrMUxjcmY3?=
 =?utf-8?B?d292bG4vSklSVGQxcURHVFgrWFAxYlVOeWJydUY1ZkFlQmkxSlZEME0zOWlh?=
 =?utf-8?B?aVJWL0lScTAyc2ZVeXVkZkQ2QzBiOS9lcjlob1RqSFBucVp6RGMzc1FTS2E4?=
 =?utf-8?B?Zy9rNFhNUHE3RWRScUlhMkhXQXhjeG5PUlBkL3ZFQWtRT2pSUm9DTlpLK3JO?=
 =?utf-8?B?NVpqWWtjdkI3dHljaS9PRlVNaS9rYVo1cThWa2pnTHp5ckw1TXJnRjRObXBh?=
 =?utf-8?B?dnNtNFkwTE53UWVVbVBUWXV6Z3FBbm9jd1VEa2thMnRwWWNRSGs3S0FSaVMy?=
 =?utf-8?B?cGdHTFJueFVldVgvbnlsYVlEMytRTlVzZFRJZTFvZ1BUTnQ1OHVpUmlPMDZ5?=
 =?utf-8?B?ZnQ0R3RLcVZnV3AzbnFZMk0wSlltUnZ4eEd0TEg5d3BPcCtlMWVmR1BYNFpl?=
 =?utf-8?B?dUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f6a1b558-8adf-48fb-31c4-08ddecb8ab8a
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 20:13:25.4136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wf/xjSuil3Ear/pIZqxomMo0M9Qlgi1fZ+Srjc3gEADk+QQ32/54LsFeSbVrfO+ee17H76I4twEKkBS/gRzG41x/0J/xAk8Xk8mgraY8e2I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8802
X-OriginatorOrg: intel.com

Alexey Kardashevskiy wrote:
> 
> 
> On 3/9/25 01:13, Aneesh Kumar K.V wrote:
> > Dan Williams <dan.j.williams@intel.com> writes:
> > 
> > ....
> >> +
> >> +/**
> >> + * struct pci_tsm - Core TSM context for a given PCIe endpoint
> >> + * @pdev: Back ref to device function, distinguishes type of pci_tsm context
> >> + * @dsm: PCI Device Security Manager for link operations on @pdev
> >> + * @ops: Link Confidentiality or Device Function Security operations
> >> + *
> >> + * This structure is wrapped by low level TSM driver data and returned by
> >> + * probe()/lock(), it is freed by the corresponding remove()/unlock().
> >> + *
> >> + * For link operations it serves to cache the association between a Device
> >> + * Security Manager (DSM) and the functions that manager can assign to a TVM.
> >> + * That can be "self", for assigning function0 of a TEE I/O device, a
> >> + * sub-function (SR-IOV virtual function, or non-function0
> >> + * multifunction-device), or a downstream endpoint (PCIe upstream switch-port as
> >> + * DSM).
> >> + */
> >> +struct pci_tsm {
> >> +	struct pci_dev *pdev;
> >> +	struct pci_dev *dsm;
> >>
> > 
> > struct pci_dev *dsm_dev?
> 
> Unless we start calling pci_tsm_pf0 instances "dsm", I'd keep it "dsm".

The per device data for the physical function 0 responsibilities is
called pci_tsm_pf0, the actual device that plays the DSM role in the
TDISP specification is dsm_dev.

> >> +	const struct pci_tsm_ops *ops;
> >> +};
> >> +
> >> +/**
> >> + * struct pci_tsm_pf0 - Physical Function 0 TDISP link context
> >> + * @base: generic core "tsm" context
> >> + * @lock: mutual exclustion for pci_tsm_ops invocation
> >> + * @doe_mb: PCIe Data Object Exchange mailbox
> >> + */
> >> +struct pci_tsm_pf0 {
> >> +	struct pci_tsm base;
> >>
> > 
> > struct pci_tsm base_tsm ?
> 
> It is usually pdev->tsm->... so it has "tsm" in the value, having another "tsm" is hardly useful imho.

It only shows up in a few places. I think it is ok.

> >> +	struct mutex lock;
> >> +	struct pci_doe_mb *doe_mb;
> >> +};
> >> +
> > 
> > 
> > Both the above will help when we have names likes
> > 
> > dsm->pci.base.pdev; vs dsm->pci.base_tsm.pdev;
> 
> What type this "dsm" of in this example? Currently it is pci_dev which has no "pci" member. Thanks,

True, not sure what Aneesh was thinking here, but that does not really
change my view of the above renames.

I do want to stop spinning this patch based on trivial naming issues. I
think at this point everyone has had a chance to weigh in with their
preferences. I know I have picked up some from you, Aneesh, and Yilun
against my first choice.

Let's please stop quibbling with the names post v6 unless Bjorn raises a
specific concern.

