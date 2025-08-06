Return-Path: <linux-pci+bounces-33488-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D21B1CE8E
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 23:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B55E418C3A38
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 21:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921CA22B584;
	Wed,  6 Aug 2025 21:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iNnWdMvc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D6B226D1D;
	Wed,  6 Aug 2025 21:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754516423; cv=fail; b=fPeTQBgwrMjDUNQw6mJYV8+Gdc7si0Kl/jul9bARjdO4V5G5X4SmRX68SI0h4o6y7CAnUzj1xIul0IKRcYFIcXoag7NY/LAHu8RZ/rRgTvhGwTVMc+WhWvoTTsVuyU7H9Zx0l4S/KBFEpDrSdjvXyls8yZNcrQ1SadZSAmgOqzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754516423; c=relaxed/simple;
	bh=YGPWDEqosLRqXMnRK8F7js9qJCjmkqQL191DTinFd3w=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=EL73bV3B7zifZdwmJ2v9ylVRUCQo8L/EfEEaWn8xnnR+xaeK24V/pRBdKPy5J+Y4yiCtXV9lFLYBGGTwb0GAb0KlClByIU2lMkSz1TQO1BFtQCMYXLSlHPjjT7gzk7E9IkkrZjBiWRiHcWaeznZtB2yVDHzs5q+cMFDNARGRG9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iNnWdMvc; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754516422; x=1786052422;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=YGPWDEqosLRqXMnRK8F7js9qJCjmkqQL191DTinFd3w=;
  b=iNnWdMvceduEdwfpRczPJluPiOoLudmTrMLEV85o2LKNOFw2hN7qzoke
   EIriWCCjBms8wvxu7G88I9X1Hss9d3L8Pnw0PJzwFE9VlSoPFI/Dx9KfI
   WfwljZFKB9VklWnD8TK+UWEkG450oJIndkBBkYSBxzUhmc4FIYCOajMjB
   vPvOs1OhfivoJ6f4ZtGeR4+PYJEwUuA82VbdZs5m2T9Yg4ZTlNOPIjM/D
   bObil99rSwnD+LW8vPn6x30iEKrEc7YDaJ5IdrIENr3xYF11FOfHdmBSE
   cGl+dImzipNiMz96/qgCjlCd5REujnhcy9yYKXh/pgFQjeoadRCOIpSFH
   g==;
X-CSE-ConnectionGUID: VmLNoRZQQYi10h2fPDtL1g==
X-CSE-MsgGUID: y1NCq+DKQjSOMKqgnhRaRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56810658"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="56810658"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 14:40:20 -0700
X-CSE-ConnectionGUID: GrGztojoQdOifUdDqRH+rQ==
X-CSE-MsgGUID: pCfVR/txTpamvYNS7QuM0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="195859095"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 14:40:19 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 6 Aug 2025 14:40:18 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 6 Aug 2025 14:40:18 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.41) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 6 Aug 2025 14:40:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ood9JyYKzOx8tS0OD2y0fd59UIXP7PkrU4WRfYxCqNPpR4HrEr9Wrs7Y4CDED9dcsWgZYQHWAwSS+6TFmJbWZYGNn/STGCicE3+uIFCaaQuyq/v+R/Fr2Jw26nTqfhggOAjsLH40CQkzj1Spm814uFxvljJ99DSSDtwUISpWVj58yz1wWThHc3sz4rhuuRDCu0qAZI/b/F0R8D3YmkvQjIaShCSnOMTwPVk2YFPL6Sm1PivCComl9TWlfjWJQ2b/67P5yr6YMzKy5qC0QvXoaNCw+bFjJYvO+ZdDbte7elOh4HXnFL60M7rVRUKHTUO9tYaEEWSI4cleYFzijnL46w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxIDFAM+lgBp/+ZbAHctTKaspCYvvxhciKohXTKuZ9k=;
 b=yCaq3vYuTa6XpHAOEta5dOPHfY4rgmXEjpSKZjozmDINyhdigBs716Z3btV7SgyFuIoIVcb2AzWhZJmm8i9SL+iKZzZrNLAtJ2ujnsydOAp39rfm5WlSTxB31RWN28JEewuBqb2/zqvrYRx7jRTTz88x28LRYgS2zXpLWge1wGBxvCgAXP9E+PMzUL08iByg1SpYEd/EUQit3MGIvLCU2ruMp/+YSitzng9GeET9JdY+JPYQhWZCJbyrF/eSrZ9CNGV+jx2D5axAe0cNxk//kvyu+YF+bn3msOxqEGd4XRerJF5UioU/Pzk2tflWL7uFTzlE9m+YDz4g7G++sjybXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB7294.namprd11.prod.outlook.com (2603:10b6:208:429::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Wed, 6 Aug
 2025 21:40:15 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 21:40:15 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 6 Aug 2025 14:40:13 -0700
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bhelgaas@google.com>, <aik@amd.com>,
	<lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, Yilun Xu
	<yilun.xu@linux.intel.com>
Message-ID: <6893cbbd7239b_55f091009c@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250729164504.00000ec2@huawei.com>
References: <20250717183358.1332417-1-dan.j.williams@intel.com>
 <20250717183358.1332417-8-dan.j.williams@intel.com>
 <20250729164504.00000ec2@huawei.com>
Subject: Re: [PATCH v4 07/10] PCI/IDE: Add IDE establishment helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0008.namprd05.prod.outlook.com
 (2603:10b6:a03:254::13) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB7294:EE_
X-MS-Office365-Filtering-Correlation-Id: eb88fd86-f543-497a-e16d-08ddd531d4cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TllRY1FyM0dINWh6UVkzWEFiYTlRa1RWTGx5d1RtVFhWdVp4OXlEcGxHQm5U?=
 =?utf-8?B?WnpQaDhrWnZ5dTRFNklQbzlOa0p2VlNNVWpRdVhldkE3bTlWZ21pU251ZjVp?=
 =?utf-8?B?U3FuRlpiTlBiOVRPcWt2ZE5EYnhHUkRVRGkwdHBqTy8wYzZway9FbC9Udk9q?=
 =?utf-8?B?TTdNR3BqVnJYZXRkVzdiM3ZKZnpZbG9GV3JaMTNVaVBlcHArMWRzb3lpZlRs?=
 =?utf-8?B?eWhkQ3phRzFROUxCcDVXVnV0TlBQOE1hbmFJeVQ2bzZSeW1vREwwL3BwaUJ2?=
 =?utf-8?B?akd3VFVYUS9OVlNrMjhKVHI2SDBydDFFRG9uSFYwWWdVcnEreEp6c0JTSjN5?=
 =?utf-8?B?QXk5UXlmcTU5a3JkRTBrSE1oK3NySGV2TktuemFaTEVjK1hGVGRwQ0xjalIy?=
 =?utf-8?B?anN4Nmx2OXg5eHdMYWZCSDlDU0lQUE1sV1YyRVBJVTV0NytmQmFHMzcrVSsr?=
 =?utf-8?B?Z2RUR2ZRZG5YckZhWktTM1V6cklOVzl1L0hNSWt0bWJQSWhnbWNybXRtQzVJ?=
 =?utf-8?B?dHh1Y2pHalNBYXFNOWVONjZFZFZBTFF2YVNoQnhVL0RRaXdacjdiWDZvU1JS?=
 =?utf-8?B?ZzM0NlF4eU5MRmFlWWM4SmhOcDVFckNIQzZUOHJsSERUcmRCV2lLcUVhUUUz?=
 =?utf-8?B?WnNsbFYyUEJncElsMGZZcUl4S3JFak5FS2ZOUW5FcG0wU215aEQreTcveUZo?=
 =?utf-8?B?RWxHQ1BMUTc0aGR0R2xyVDhSRkVBb1c2ejgyWXJ5YWZYbi9sMjREQzhjRUdH?=
 =?utf-8?B?N2VQUndBakJReHdHSXlnRGp0RzQ3TlNrQVFhdFhXLzZ5VGUvWjFzY3NhSGIw?=
 =?utf-8?B?cUl4eWJEcDk0VlEyTklNWm1abkMxVDNVZ2paWWFkbWdrZ25ENmQ1cDg4RHlB?=
 =?utf-8?B?ZGpGZUljL1JObUE1NUczVWN4YTBKamNIdnM5ZENHeS9XMmx4OG9DaTFCQkVp?=
 =?utf-8?B?eGR1dGl0NW93VG54R2lVVmdTQTdudkpsVU1YWk14NnhuZ1VvVHFUQVF0VDVa?=
 =?utf-8?B?aUtqeTU4QzNBaW5YTHQ5Mkp6bXp2R285UWVQU3RlL0R5ZXB4QmNOL2RISkhT?=
 =?utf-8?B?NjVFOEpmc3JBQ2pVU28xRG15eHZEdDlsRzNYd1VRNFJvaDM0cjZBanE4ZHRn?=
 =?utf-8?B?dWZIZVU5Tk5UWWl1aVNBamYyajlMdkh5Wk5BYnl2QVJPc0hwQlRsdXM1S1Jt?=
 =?utf-8?B?cUdLNFdMVjVxU0pFbDN1bEM1RHdYNkkyMCtBeFE2elFKYWNCbXdoSjRCYXYr?=
 =?utf-8?B?WkNGcjlyY3dDaTVidDZzWjgvUC9SS3o3WFI1eVZ0WFlUSDZSMGlxTXNHamRm?=
 =?utf-8?B?YkFiczJZdDVlNHliRVpkWHptNE1jL0xRczFHK2NIRy9semtZanhzK1hYYzlr?=
 =?utf-8?B?dUpyNzZjcHdvOE1BVytDN0xHT0NQWnh1cCt1VE5aWGJPN0xHTVhEbHBXN20z?=
 =?utf-8?B?WmwxYWhpbi9XK0pEU1pWTTY0YlhwWEthUlZRbkgrL2JVRWxQa0YxeUtGbGJU?=
 =?utf-8?B?MElyb0hqTWdhTWVGdHYxR09MU016VTYrWmpjSTRDeERMV2ZnYVlqaWNHcTV3?=
 =?utf-8?B?dDZzTlpOM3VrZnY5Y0dEM1gyQThFaXlNemkwTGczbTFKTFQ2NkxuS25oZUxs?=
 =?utf-8?B?MERlRk5BRnNMblhBYyswemlXeUJMamY5dzg3c2Z1Wmp6WG92clNLNmRNTXFp?=
 =?utf-8?B?WjVqU21sL0F1S1NkT1BvdjRYRnh4NEhZK1hJZFlDcFZVQUJUTWhZZHRZaUJ5?=
 =?utf-8?B?L2hvRTl0TitCcEZTU1p6UGpsYU1RTy9EN21acTlYL1I2TVZlVnJXWFRDeVJh?=
 =?utf-8?B?Q3haUEpJdEhMd3VWbVI0NUowMURTVXNuOFA5dmFaRWY5VStodUNXNldQcWVt?=
 =?utf-8?B?eG5nZFRKelJkNlZRUEsydGpaeUZRSy9MaTBaZXVLUkhVMnNSc3F1emJwUEpT?=
 =?utf-8?Q?g1fsFjaUsds=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2lsMFR0SFcrcEJsQk5oZUlQMjhJM085RDhnbG1vdjM5K2x3SWRDOWs2djVv?=
 =?utf-8?B?T0p5Ukp2d3lZc1pkdzFldVVVWHExdERvZU1uVXM5VDI4a2FLV1JnaHI1QVlm?=
 =?utf-8?B?WEFudVRRTTNYMTVLTGQ0eWsxRDh2MXFydmp0ajl6bFp5ZmdMcDlMQVlSOGZ6?=
 =?utf-8?B?Umc1VUlVS3UxTlZCVTczbjdwQ1dPK3NJN3dYWWV6UlAvOCs5UVN2dHhQbDBF?=
 =?utf-8?B?Qkhmb0p3UWc0L2V0ZnV0amxQQjd0Z2o1dlBYQU9ZcTdIT2VwS1ArVDVWZUJx?=
 =?utf-8?B?K0VONm9Ra2FGRTVQUmZCWDZGS01nT2VnLzRBTkxySHRUYktaZ2hJMUdac0pq?=
 =?utf-8?B?dFY3NEtTS054Qjk4Qkh1aUo3U1FwaFNlNDFFWitXeGVSbFBHRTRDQzllazZU?=
 =?utf-8?B?NEtKUzkwQnBkOU9kRVR0cFR2QTZMYTVHSC9vUmczanZLVm9FYkE5T3FxbkZE?=
 =?utf-8?B?d0czZThOSHRscmNSM2tCUkthQmplaHFsNEcwZlk2QWZqYTJydFdSZHAyUzAz?=
 =?utf-8?B?UE00R1BycjUzS0ovV0tUcXV4emJkWEFIUmZ2OXN2THV3MlhBaG55bG4xbDh5?=
 =?utf-8?B?Rml0Q3BKNHQvTDhmQ1g3MStkZHdmeG53REtjN1dyNEExd3AzVlFxS3k4UVd6?=
 =?utf-8?B?dWVTNDNDMHJrR29iekNGN1dYNHhwQ2pGcHBWSGY2UVJuTk5KaDlSNUQvVkZM?=
 =?utf-8?B?V3BGa3Q5SG5jenJVRUphMmkwdTFVTVU2djhwSHhIS240UWJPTGUxcVlWeGJM?=
 =?utf-8?B?M0ZZcG5zU3pXL3dwNGc3bjNMM0hEUEhvWitzdWJySjNtemtrbDQwWThsWDNT?=
 =?utf-8?B?bERrblZ3MXFvbjB2Y2Y3R2ZXN0Z0RU0vRE5DWTZmMlROd3RRWDhITXQ1a3R5?=
 =?utf-8?B?bGFzZ25FN1RaOFZyc01JNUVjdlBtR1k0OElMWUdoSkpxZC9xSE5MQjJYVm5C?=
 =?utf-8?B?blY2SHpPUlJ4R2NVRHM2MHBreS8vK1J4ZzUyWllwU0orN3cvUEJFbUdYS0RR?=
 =?utf-8?B?ZEZNVFY2aUhlRnRScWUrS25QcmNHMndOSFVsN1RVczFJa3BIM0NnMURPWVdu?=
 =?utf-8?B?Q29OZjZRdUdoenZ4N2VjTzJGc3dYSHdpdGxIaDVXM3dzdjF2aHRrVmQ2bS9l?=
 =?utf-8?B?dGZUSTYyNmFKNTJJdmZYRUZUS3VPWE9ySkl0NU1veldoRXh4MGNXK084aUVr?=
 =?utf-8?B?NGhxVVdQdUM3R0o4VU9YUFMwajVBcStoM0tHSTREem9aTzdBWGJRcnB1K0hq?=
 =?utf-8?B?YnRiN1FGZGxyYTA4TG5tVmttaXZ1MXNLQjZCbFQwMFpQTkNDbjhIR3A0WkM3?=
 =?utf-8?B?ZlB2UlN2QUhCTWs5MldtWkdiSGM4VVhrb2tEY2IwT1VOanlSaGQwZU5sRk9Y?=
 =?utf-8?B?VkltYW5zcGFXSnhnWGtNYVFhb1p6V3d3bElwazFIdDMxOHNsMUVRd1ZFcDE2?=
 =?utf-8?B?QWJ4MStmdEJHWDFTM096Z1d0TE9DdHlnZU5EUUNsZDdXUExScEQzMnREcmo2?=
 =?utf-8?B?a2dsSkdXUm45N2NoUTBRc3Jha1N3d25vM3p5WEdyai9ncnVqVjJCL0JyS1VU?=
 =?utf-8?B?TnZ0d0Y0SW5OR1JOanhkK1V5VlYzVWtPUitUZ1RIMUZxdStLa3FFQXF0emw0?=
 =?utf-8?B?cGRJdEZRL2hoYzkzNlMyMFVYTDZsWW5UbmRkUGRpYlVLd2NvdkVxR0twYmNo?=
 =?utf-8?B?QkxCS29RYm9HMFNvUWdsMjJMVkl4LzZuQ0dEWmN3K1VoQlFzZnBvN0p3VExY?=
 =?utf-8?B?N29jNmZtd2dtanFhb2wyVCtjenk2RHNkZ3pqdnQxMUY5elJqdkhDUTcxU0FD?=
 =?utf-8?B?WlA5RVBVeDA1bzJHaWo0amR2TzFLZ1Zqdngwcmo4clQyTGQ5L0U5RThOSVNE?=
 =?utf-8?B?MndOZkFkcnorSEdrNldwSnp1WnR0RlE1YS84NEZWRWltbnN2bHkyTUdDRDVr?=
 =?utf-8?B?WnUxaGs2VXF1ejNpVWUvc2Zhc3haSFYyWjE2YlppZUJrZDVtblRDbnh4WHhF?=
 =?utf-8?B?bmF0N3p3NU80andvQUVsV3ZiS2dKTHlabnNockM4R3hmLzU5K2g4OGx4OGVl?=
 =?utf-8?B?L3FUSFFtZyt5RWovQXZXVytkY1Z1ZERMZkxvaEYzQWs3UTROMEJoQm5nWFBU?=
 =?utf-8?B?YzZ4bGNEMGJzd0RWNnFEa3hNWFlpKzNlZXkvWTJyeGVoZFFObUtVR2NaR2xI?=
 =?utf-8?B?R2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eb88fd86-f543-497a-e16d-08ddd531d4cb
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 21:40:15.7963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mHIqyMygSXM+dEJ/i7RHxWlIKbbB2L9Z2vuy11qEv90VrlwaTvMtd4timf+JjbF2n873pGVUisAY+eq/4lgi+kACFjpW/g/KXolktmxd2x8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7294
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
[..]
> A few minor things inline.
[..]
> > +/**
> > + * pci_ide_stream_enable() - try to enable a Selective IDE Stream
> > + * @pdev: PCIe device object for either a Root Port or Endpoint Partner Port
> > + * @ide: registered and setup IDE settings descriptor
> > + *
> > + * Activate the stream by writing to the Selective IDE Stream Control
> > + * Register, report whether the state successfully transitioned to
> > + * secure mode.
> and report

ack.

[..]
> > diff --git a/include/linux/pci-ide.h b/include/linux/pci-ide.h
> > new file mode 100644
> > index 000000000000..89c1ef0de841
> > --- /dev/null
> > +++ b/include/linux/pci-ide.h
> > @@ -0,0 +1,70 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
> ...
> 
> > +/**
> > + * struct pci_ide_partner - Per port pair Selective IDE Stream settings
> > + * @rid_start: Partner Port Requester ID range start
> > + * @rid_start: Partner Port Requester ID range end
> > + * @stream_index: Selective IDE Stream Register Block selection
> > + * @setup: flag to track whether to run pci_ide_stream_teardown for this parnter slot
> 
> partner.
> 
> > + * @enable: flag whether to run pci_ide_stream_disable for this parnter slot
> 
> same again.

yes.

> > +/**
> > + * struct pci_ide - PCIe Selective IDE Stream descriptor
> > + * @pdev: PCIe Endpoint in the pci_ide_partner pair
> > + * @partner: Per-partner settings
> per-partner maybe?  Capitalization seems a little random
> as mostly you have used them for spec terms, but Per-partner probably
> isn't one?

true.

> > + * @host_bridge_stream: track platform Stream ID
> > + * @stream_id: unique Stream ID (within Partner Port pairing)
> > + * @name: name of the established Selective IDE Stream in sysfs
> > + *
> > + * Negative @stream_id values indicate "uninitialized" on the
> > + * expectation that with TSM established IDE the TSM owns the stream_id
> > + * allocation.
> > + */
> > +struct pci_ide {
> > +	struct pci_dev *pdev;
> > +	struct pci_ide_partner partner[PCI_IDE_PARTNER_MAX];
> > +	u8 host_bridge_stream;
> > +	int stream_id;
> > +	const char *name;
> > +};
> 
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index a7353df51fea..cc83ae274601 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -538,6 +538,8 @@ struct pci_dev {
> >  	u16		ide_cap;	/* Link Integrity & Data Encryption */
> >  	u8		nr_ide_mem;	/* Address association resources for streams */
> >  	u8		nr_link_ide;	/* Link Stream count (Selective Stream offset) */
> > +	u8		nr_sel_ide;	/* Selective Stream count (register block allocator) */
> > +	DECLARE_BITMAP(ide_stream_map, CONFIG_PCI_IDE_STREAM_MAX);
> >  	unsigned int	ide_cfg:1;	/* Config cycles over IDE */
> >  	unsigned int	ide_tee_limit:1; /* Disallow T=0 traffic over IDE */
> >  #endif
> > @@ -607,6 +609,10 @@ struct pci_host_bridge {
> >  	int		domain_nr;
> >  	struct list_head windows;	/* resource_entry */
> >  	struct list_head dma_ranges;	/* dma ranges resource list */
> > +#ifdef CONFIG_PCI_IDE
> > +	u8 nr_ide_streams;		/* Track available vs in-use streams */
> 
> Which does it do?  Confusing comment.

Oh, true, I was going for a combo comment for nr_ide_streams and
ide_stream_map, but missed on the clarity. Make that relationship
clearer:

-       u8 nr_ide_streams;              /* Track available vs in-use streams */
+       u8 nr_ide_streams; /* Max streams possibly active in @ide_stream_map */

