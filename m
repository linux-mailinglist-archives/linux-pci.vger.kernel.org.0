Return-Path: <linux-pci+bounces-9255-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A7091729C
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 22:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76A0F1F228BD
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 20:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73628176254;
	Tue, 25 Jun 2024 20:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R6oZZrh0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6E24C6E
	for <linux-pci@vger.kernel.org>; Tue, 25 Jun 2024 20:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719348152; cv=fail; b=ot639HuExMwLfM/iX8ZwK6MA46pdBqtOtPs8qHn7Mrve0hFynLaRLsBy3VtoVMi6HJeoCRK5smVxV1RLMBEbC1hZb6Ynt5BbwORoNOp3ZuMKHnNwMuGZFXXGuA5oBXm9K/vZs16uXCMb++6cxfc4ram1N9kyLtRdLZBrrYXsZWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719348152; c=relaxed/simple;
	bh=jGxPS5yw1cWzUeIgAaJ0LXy0rN+uETL+knhbj2F7rWE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MeLdhjpiduT1pHMjmyu3Us+tQ2PrwX0xruYIyjpjnazUzz5An8SfT0//ot/gRwFZLZda4u35AvfcFLlmC2siioc0V7q2pMcHVWU/BpRyVGHiiIhNV0iyICV1OIsuLxB/5PPZwLKpbV0Y54SlttD6BTV0hXIL0qol0iF3NgL0D5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R6oZZrh0; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719348150; x=1750884150;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jGxPS5yw1cWzUeIgAaJ0LXy0rN+uETL+knhbj2F7rWE=;
  b=R6oZZrh0EtOF7PGtrG/c5m3HZas+4+zt1bLM43hYYwIDAMWRZhrZcbc2
   yi+d/GYYZXRihYCBZY3nygcStW1BQ9fNzYx90cCwbat1KDe4xM9nJBpa1
   7D3IE6I10Zliql6cIcdCJbsKyqT5sKPH+/793XyUFCIzc+mHMfbLod6Ns
   eY2HnAs4/9u2B9EP91GnhnULR4ZdgblCtwwWgD0/ajERNFECNItbbWDfZ
   byJVTY+YKPR8AhBWtXrIOm0m1YlYNg/KI72bYv4zJ0SjZfjpsM40Rc4bY
   sdj9nXLYwJ6WwjetwVjUcxKBldDH25z4vYC2feXbaljQCBNx0tMe0ZTsW
   Q==;
X-CSE-ConnectionGUID: IwSv+r0YTVef/LMcOPPCdQ==
X-CSE-MsgGUID: Bfws97TbQ1aFrMd8iDIxfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="27796173"
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="27796173"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 13:42:29 -0700
X-CSE-ConnectionGUID: AKoyqqg6T/W3ekHAK3NuxQ==
X-CSE-MsgGUID: fnihZKBoQE6HxWO354UqCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="43663633"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jun 2024 13:42:30 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Jun 2024 13:42:29 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Jun 2024 13:42:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 25 Jun 2024 13:42:29 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 25 Jun 2024 13:42:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RSqFVbrvCm0YC4MQAcR6rxRE0UuT3CI+jXsTpbEZG5zZjZF/M/gSQWPXPIb9So4FAP8deY9kWNVj/FSgkOapBgcw3bElh86GHkx16LqkteUdAa98bNPDCzzZVbuCahJyscLqH6mbJiBRe5wonIEQ7zIy5qDjdYhCK0oSQcFAHI6RsFVZXvSQXMUofbvREv+FliBn6zMWKjm4qmL3OnPISJh7lTciCyNgnXhdbhFr647WuAKZ4tBEr8O+RnnDsP39zVt5dmTWCzTwQkllXI1RX8vaGwqUniPs4mxT26OayxnQy1jwdyW6kJjDOhV9EWrfFUn0ggHYYUnEEuZEHoEXzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HLY3TdBUdIZlfZ8i44QYdaIrIvgw5gIMpwuWL0oKWx0=;
 b=Di4iJTHxih09EC1fyJDyZsKSflJQOMRAutXVEnTN5ssh5ReiCvn9NuCkkEqHvU1aFt5X07AMeVAUaWos6nVWdF/MdrWRd9X3OE6EDghWthc9tw+/8vN3hykXfXxJeTOYECRqNhJZKbo1CtdtO4wuWZsxpE88S1Gig04UwCYs7BASjOpypMXg994yU3+OaGp8OSO5K1t4DQWACi4ZIWEXLBMrNqSQ+R/qtgeVfZAQQBVSv9Bkjitn6WDuNxGs0g4CUefmc75A6ESPLOpS0kZpVspj4imzi9Wp+zMK0Dd/bvqA4etqmPsOuguwynqvBjrqiP+v2NAmFY8K7zH2/R+i6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5636.namprd11.prod.outlook.com (2603:10b6:5:357::21)
 by PH7PR11MB6953.namprd11.prod.outlook.com (2603:10b6:510:204::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.24; Tue, 25 Jun
 2024 20:42:19 +0000
Received: from CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::6e1a:9fd8:2300:d3f9]) by CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::6e1a:9fd8:2300:d3f9%4]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 20:42:18 +0000
Message-ID: <048d8fd9-e91f-4e15-80a7-380b4179fb0d@intel.com>
Date: Tue, 25 Jun 2024 13:42:15 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI: vmd: always enable host bridge hotplug support
 flags
To: Bjorn Helgaas <helgaas@kernel.org>, Nirmal Patel
	<nirmal.patel@linux.intel.com>
CC: <linux-pci@vger.kernel.org>
References: <20240621211643.GA1406072@bhelgaas>
Content-Language: en-US
From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
In-Reply-To: <20240621211643.GA1406072@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0094.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::9) To CO6PR11MB5636.namprd11.prod.outlook.com
 (2603:10b6:5:357::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5636:EE_|PH7PR11MB6953:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fdabe0a-9331-41c5-fafb-08dc95574df7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|376012|1800799022;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cE1tUjh0SEE2NXViaEdWQTNINTNvRkFIWWpBVWFDRTFCR0xEcUVCTFJYOWRt?=
 =?utf-8?B?a1Rjb2oyODVGVnlEeGRzUlhIaVZKcEZJRktpL3lPTVZOckIvRXRkWVhrQlF6?=
 =?utf-8?B?NWtCYllqM25yTnVUNmFMZzl2MmFSdkZ6S2QwQkI1OFhWajJVUDY2YTJwRDlx?=
 =?utf-8?B?dVAzL3FPL2VQY1ZETGFRUEJZbitkdncyWXdtRmZneklTTDN2bjN4dlp3bWto?=
 =?utf-8?B?VXRJbDVlTzlNYXFDMWFBNjc0aFo1elovQmV4cVB4Tm05QlZJbGhEUlNvNGlH?=
 =?utf-8?B?d3lrSlZFRmx1QzkxSUxPUUJDbWZNRFJ1UkJaaXN6TzVQTnZLM0JyUzI0WTFG?=
 =?utf-8?B?ZkJBRmJXdTlpZzZxY0pBNHl5VXh1VHVXQTJNUWZwYWo4WUtrZ1psbDBVNnJZ?=
 =?utf-8?B?SmFkd3V3OW1zalFIUmIxdG5nNWxkb1lnSXEva3o3bkhDOFQvYXlvSlZiQ3lz?=
 =?utf-8?B?QTNubTRlOVNLRDJpMGhSRXA2ZHNPVjM1ZFE5OGczVXdlS0pVUUJCOFlSeHdZ?=
 =?utf-8?B?TnZRbzI0TTVLZ01NQWZPcTd1VmdHeUpNNUhnajBmR1ZZL21RbEJZYXlPcEIw?=
 =?utf-8?B?UUIzeUtVOUFVQ05CbFQ3Wjg3MWxFZ0JxK0d4QWcyUGtRejhvRm5IdVFLb2RG?=
 =?utf-8?B?WlRtaVBBS21BODJncldqMzNWQ093WGcwYVZxQ2laNksxL1dPTURWMWNMN0da?=
 =?utf-8?B?R0ptK0xzck1RWjhadis0dld4YUdnYWRYTXhqdDlaYlJvVGx1WlNtcWJlSXN3?=
 =?utf-8?B?b1V1S0k1S1dIZ1BhVklsZWV6MERaYTcxZzlmd3h4cFdCSCsyRXdiRUZQZ3NQ?=
 =?utf-8?B?cC9zdTN0VXdmUUxybWZiWk16TDlWR2ZMTWtFb3lvNytta2Fscnp3d0lHV1p3?=
 =?utf-8?B?Q0p2dXZ6K05RTXhOTzB5amRCeUpGSnRiSmozMzlFS3ljeFd0bFE3YW4wcU1s?=
 =?utf-8?B?L1BzRXNrWUZ3M1FDcEQ2dWF1QVhwYmtJdlFjdUd0M2RzRGdsaUVFYVZ6YTZt?=
 =?utf-8?B?bkxRaEZ3N0dPZkxiVW5nSUxOalpWTWNyRVdvMnk5MGVTandWdzloZTZabEht?=
 =?utf-8?B?SzJSbDJKdHBNYmVmdjdWV3ZHNG1qOGpHYWJLVDcrb2QzRXV6YW5xR3d2YUpZ?=
 =?utf-8?B?WWpXQXJ6Z2xWVHk4NnprQXpOLytETXJSdWk5ckt1Tmxza015MVI5TkFCcG5o?=
 =?utf-8?B?aGkxRU9vMEZUdmV5QVY2Q1JHMHJVUEdsWnl4MUFGK0h2aFAvOXh1cURNaVJs?=
 =?utf-8?B?UmEvd1FMTGZKcXY2ZGo3N1A3VWtJOUMxeTk2MmJRamlUZ3FBOUc0aHBUVkli?=
 =?utf-8?B?T08zblRYZnNTU0dVbUx0TElSRVJ1MnYyczdKRGcvVXFWMllFZzhwclFsU0F3?=
 =?utf-8?B?QUJqUkVTeWNHc1ByRW9wRmtVYTdZOUkrSDdHdy9uTzViOEpSUWRpVlVybDl6?=
 =?utf-8?B?TDdIMFFsc2xYUDdyUHk0Wmc0SDVLVVBYS0JzWHBwb0kyRHFGU05hYlBYaEF5?=
 =?utf-8?B?VXpqMXgyWmV6MmRXN0kzaklMbEpHT1ZDMVpGYTZwQzZOQkh4MWw4bUtoa1di?=
 =?utf-8?B?Y1lnbm11SklObk95dzBSOFN0cytib0g1dVlQUXA2WWo3bUZSaTZiQjFJT09F?=
 =?utf-8?B?ZWovOUhHUzVmZ1gwbUIxSC9QOFFpOHVWbVJodDZhTVlvWVpTeGgvRFV4REd1?=
 =?utf-8?B?a0gzZjl0QmR4ZDRJRWZKeGJYbTNzcndMRmJwMnFEWW5SbTRaVTlIQnJnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5636.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(1800799022);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R05ITTJCRFB2NW50NWNEeUV0TXVSQUdRYmdSNytudDEzdWVycTdqVzdtblUr?=
 =?utf-8?B?WW53cjd5d2NBYU4wUDZ1ejNvdDg2S1pmZTk0VU11dHhycmlQVkNiUGZHeHd4?=
 =?utf-8?B?Rlc3V1Z3Ync5V2p2SGgrajRxNDVWdkZtRUVDSjdabk1pdWF6azVOK21pQ09B?=
 =?utf-8?B?RXlqUEt1OE9VUFo1RUMwbldBUHRIcjl1L2hsZyswWkVrSjYxTzZlc05SUlgw?=
 =?utf-8?B?ZWNZL21JNGlTVzdvOS9vdFlCdU83djF0MFNUS0gwOXZ0bFlUdHZucitCSVZW?=
 =?utf-8?B?bk1laUJVUG1KQ1BjWW9FY0gzL2N1RzQ0dFgyTmRNdURkbEFZQllmUTRxOXZQ?=
 =?utf-8?B?eU1aR0RaZ1A1SnZqZytBa1ZiT0xRQUlJUUpUWlJ1Tjg2bjcwTkVZbzBKVU9m?=
 =?utf-8?B?SXVuY2NvN21WaVlhVGlLcHZ4WC8vaFhiR3FISzQxaVl0ZEhhQWlPSFdQTnVT?=
 =?utf-8?B?NHBzN3ZRdGYydk5TV3N2b2VEakMxaUxOYnR2N1NCQVlOMVlsSGJyQXRyVHFM?=
 =?utf-8?B?YzFXSEkxUXVCdmlOQ3QvQ0RnSlFVWGFTQUFLVnp6Q1owSGdnVVVaR0t3eGZ6?=
 =?utf-8?B?MHJWTjAxQjUrcU5mVXJQcHNCM2xBeW41SnVURWNoVVJJZElTbkNxYlpNektv?=
 =?utf-8?B?a2xtcmpjdHdhTmZRRkNPS3hzeGpKWEdjakVvQms4YnBQR0hpcjhLRVFPSDla?=
 =?utf-8?B?TU9DaVJPU25DMGZhSituMnpHaGRML0lqRkZ2eUFlTkowc1ByRDVjM1VnTWkw?=
 =?utf-8?B?a05ocXNHUVZyUHd1TDJFSlkra0tDOVFKK1BEbXdDN2N0Y3FuY0xLRzhVS0Uz?=
 =?utf-8?B?cnNHT1NVQWVRUE1HL2laemM2SGJic0JRL2plQlJRYjY4enk1ZEloOUpUVlN4?=
 =?utf-8?B?dmtQcFRWbDkvamRDU2FlN1Z2TmMycG5IZVlEaStJZktCT3k5UE9qVU5WVnNF?=
 =?utf-8?B?b3NxTVMwdkdlV3MvWUFZSjI5eGNxcisyby91cHlWK09DNFZEOTQrenV4Q1Bw?=
 =?utf-8?B?ZVA3R1U5cmE4aUFiVHZHOGZEMmpuajFLWm54MXFWOEZsSzRmNzNJNkVlQlBC?=
 =?utf-8?B?MG8zTzQxZ2ppRmE5NVl6Y283TTQ3Nm83anRtOXo3M0wrSDUwZUNoejRJYUpI?=
 =?utf-8?B?bjBTb25TTEFjWTYxMldDcjNLNWozcGxDTGcrZ2ZVM296b3gwVXN6ZUNRdERa?=
 =?utf-8?B?bjk2aTFaOExmQk1VSC9QZk10SmszdHAzRHFwQkN0ckNJa2NBakRNZmkwS3h0?=
 =?utf-8?B?QWpQdGxNV1I2RG1hN2xxYndkVmw5N1pjYVplT0l0aFFEd2M4Z05IVUdtdHBK?=
 =?utf-8?B?ekVkKzN4REl3dUFRMzhrV3hlV2h1ZUVzNTZUT0hzN3J0YW4rbGdteGlMNkpm?=
 =?utf-8?B?NkJtbXFhU1lHZnk5WEZpRXdxeTR0NmQwdHNkY0cyYy9QTXFmQUxWWkQrMlND?=
 =?utf-8?B?VXdRVGZEVDltdlducDlxSlNCREhoMTcvUjNIWTBRVVRac1E1WlpITUhJd0xk?=
 =?utf-8?B?VE1vNHJLaW0wOE11SGI4NFJpUFFNY1ErY3ZLdk1PQlIyS2d0aVRrWTZXcmVt?=
 =?utf-8?B?dnp4cFRnUzFsYUdBUmVyV0Jxb2VVMzkzdjhJamc4SHZWZnZ5aVlXUmZQKzNl?=
 =?utf-8?B?dSt1ZjcvVlpqYXB2YWhGMmswOHhkbGlNc29uQlJ0cjhVR2EyOUZiK3gvS2Y4?=
 =?utf-8?B?RmVwSUJva3VKS3BmN0o1OVRkaDh4Wmt0TVJTYndTUjVMUVpJMXRiN0Z6dm5B?=
 =?utf-8?B?U3pZMHp1eVpIdERwMEk1bzNJczU0SHd5NHN4SWs1ekRJZ2N2WDZSUmxhWkdF?=
 =?utf-8?B?WDFoakdxWWpsaGprNkQ4ZDdLcmtKY1gzRFRSNk90VENsYmk4SVI3aGVva1oy?=
 =?utf-8?B?eVJrd21MKzFMTmg5b29DMGd1OGlYU3BqbmM1Y2pEejFQeURMZmxiM204QXNV?=
 =?utf-8?B?c2E5YmsxZ0d0YmIyd2JzS0tLUTMwYUZ5ZWlJcE5SSHZ0VnhNRGdFTnpJTGkr?=
 =?utf-8?B?QWJ2eFBHRmgwdVJxVXdldm5KSGdsTHRqTTA4Y0R4bFp5VW01QkJpNDZMYVoz?=
 =?utf-8?B?T3VnQjFudDdpblh5QVl3YWlKTEhyVFRLdmM2WU1RWmZuL2dIdTh5RHA1OStW?=
 =?utf-8?B?RDRhM1NBNDJzaGViWUxBampCM3JkZXRFbGplSVBvS3p4Q0phdE5qVWlLWEdM?=
 =?utf-8?B?VWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fdabe0a-9331-41c5-fafb-08dc95574df7
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5636.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 20:42:18.3255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jl51Bx6uWGXNnGeHbfYYlE/P3rOfXJNUSiqwiIcJ02LbtYmH3rjnUwD8Kxb1fDfbdQM1fZ4FOWrRGHDv2cPm89e+QHVd+7xfq2NpAIKxM3Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6953
X-OriginatorOrg: intel.com

On 6/21/2024 2:16 PM, Bjorn Helgaas wrote:
> On Thu, Jun 20, 2024 at 03:41:33PM -0700, Nirmal Patel wrote:
>> On Thu, 2 May 2024 17:56:08 -0500
>> Bjorn Helgaas <helgaas@kernel.org> wrote:
>>
>>> On Thu, May 02, 2024 at 03:38:00PM -0700, Paul M Stillwell Jr wrote:
>>>> On 5/2/2024 3:08 PM, Bjorn Helgaas wrote:
>>>>> On Mon, Apr 08, 2024 at 11:39:27AM -0700, Paul M Stillwell Jr
>>>>> wrote:
>>>>>> Commit 04b12ef163d1 ("PCI: vmd: Honor ACPI _OSC on PCIe
>>>>>> features") added code to copy the _OSC flags from the root
>>>>>> bridge to the host bridge for each vmd device because the AER
>>>>>> bits were not being set correctly which was causing an AER
>>>>>> interrupt storm for certain NVMe devices.
>>>>>>
>>>>>> This works fine in bare metal environments, but causes problems
>>>>>> when the vmd driver is run in a hypervisor environment. In a
>>>>>> hypervisor all the _OSC bits are 0 despite what the underlying
>>>>>> hardware indicates. This is a problem for vmd users because if
>>>>>> vmd is enabled the user *always* wants hotplug support enabled.
>>>>>> To solve this issue the vmd driver always enables the hotplug
>>>>>> bits in the host bridge structure for each vmd.
>>>>>>
>>>>>> Fixes: 04b12ef163d1 ("PCI: vmd: Honor ACPI _OSC on PCIe
>>>>>> features") Signed-off-by: Nirmal Patel
>>>>>> <nirmal.patel@linux.intel.com> Signed-off-by: Paul M Stillwell
>>>>>> Jr <paul.m.stillwell.jr@intel.com> ---
>>>>>>    drivers/pci/controller/vmd.c | 10 ++++++++--
>>>>>>    1 file changed, 8 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/pci/controller/vmd.c
>>>>>> b/drivers/pci/controller/vmd.c index 87b7856f375a..583b10bd5eb7
>>>>>> 100644 --- a/drivers/pci/controller/vmd.c
>>>>>> +++ b/drivers/pci/controller/vmd.c
>>>>>> @@ -730,8 +730,14 @@ static int vmd_alloc_irqs(struct vmd_dev
>>>>>> *vmd) static void vmd_copy_host_bridge_flags(struct
>>>>>> pci_host_bridge *root_bridge, struct pci_host_bridge
>>>>>> *vmd_bridge) {
>>>>>> -	vmd_bridge->native_pcie_hotplug =
>>>>>> root_bridge->native_pcie_hotplug;
>>>>>> -	vmd_bridge->native_shpc_hotplug =
>>>>>> root_bridge->native_shpc_hotplug;
>>>>>> +	/*
>>>>>> +	 * there is an issue when the vmd driver is running
>>>>>> within a hypervisor
>>>>>> +	 * because all of the _OSC bits are 0 in that case.
>>>>>> this disables
>>>>>> +	 * hotplug support, but users who enable VMD in their
>>>>>> BIOS always want
>>>>>> +	 * hotplug suuport so always enable it.
>>>>>> +	 */
>>>>>> +	vmd_bridge->native_pcie_hotplug = 1;
>>>>>> +	vmd_bridge->native_shpc_hotplug = 1;
>>>>>
>>>>> Deferred for now because I think we need to figure out how to set
>>>>> all these bits the same, or at least with a better algorithm than
>>>>> "here's what we want in this environment."
>>>>>
>>>>> Extended discussion about this at
>>>>> https://lore.kernel.org/r/20240417201542.102-1-paul.m.stillwell.jr@intel.com
>>>>
>>>> That's ok by me. I thought where we left it was that if we could
>>>> find a solution to the Correctable Errors from the original issue
>>>> that maybe we could revert 04b12ef163d1.
>>>>
>>>> I'm not sure I would know if a patch that fixes the Correctable
>>>> Errors comes in... We have a test case we would like to test
>>>> against that was pre 04b12ef163d1 (BIOS has AER disabled and we
>>>> hotplug a disk which results in AER interrupts) so we would be
>>>> curious if the issues we saw before goes away with a new patch for
>>>> Correctable Errors.
>>>
>>> My current theory is that there's some issue with that particular
>>> Samsung NVMe device that causes the Correctable Error flood.  Kai-Heng
>>> says they happen even with VMD disabled.
>>>
>>> And there are other reports that don't seem to involve VMD but do
>>> involve this NVMe device ([144d:a80a]):
>>>
>>>    https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1852420
>>>    https://forums.unraid.net/topic/113521-constant-errors-on-logs-after-nvme-upgrade/
>>>    https://forums.unraid.net/topic/118286-nvme-drives-throwing-errors-filling-logs-instantly-how-to-resolve/
>>>    https://forum.proxmox.com/threads/pve-kernel-panics-on-reboots.144481/
>>>    https://www.eevblog.com/forum/general-computing/linux-mint-21-02-clone-replace-1tb-nvme-with-a-2tb-nvme/
>>>
>>> NVMe has weird power management stuff, so it's always possible we're
>>> doing something wrong in a driver.
>>>
>>> But I think we really need to handle Correctable Errors better by:
>>>
>>>    - Possibly having drivers mask errors if they know about defects
>>>    - Making the log messages less alarming, e.g.,  a single line report
>>>    - Rate-limiting them so they're never overwhelming
>>>    - Maybe automatically masking them in the PCI core to avoid
>>> interrupts
>>>
>>>>>>    	vmd_bridge->native_aer = root_bridge->native_aer;
>>>>>>    	vmd_bridge->native_pme = root_bridge->native_pme;
>>>>>>    	vmd_bridge->native_ltr = root_bridge->native_ltr;
> 
>> Hi Bjorn,
>>
>> Do we still expect to get this patch accepted?
>>
>> Based on the previous comments, even with AER fixed we will still have
>> an issue in Guest OS of disabling all the features which will require
>> making adjustments and/or removing 04b12ef163d1.
>>
>> Is it possible to accept this patch and add necessary changes
>> when AER fix is available?
> 
> I think 04b12ef163d1 is wrong, and we shouldn't copy any of the bits
> from the root port.
> 
> If vmd takes ownership of all those features, you can decide what to
> do with AER, and you can disable it if you want to.
> 
> Bjorn
> 

IIRC we are taking ownership of the flags by (eventually) calling 
pci_init_host_bridge() which sets the native_* bits, right?

One way we could force a re-look at the original issue that 04b12ef163d1 
fixed would be to revert it and break those use cases. I'm not sure I'm 
in favor of that, but right now we have a situation where either VMD is 
broken in some cases or we revert 04b12ef163d1 and break those cases. 
Either way someone is not happy.

Paul

