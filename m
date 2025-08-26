Return-Path: <linux-pci+bounces-34810-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E342B375BC
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 01:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D2FF2A0C85
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 23:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800AA2FE069;
	Tue, 26 Aug 2025 23:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RA/4qbvG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87CE23D2BF
	for <linux-pci@vger.kernel.org>; Tue, 26 Aug 2025 23:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756252453; cv=fail; b=l4CBif9YJyswNyBWrpwWkC3m3HppAogKVMbwaIDRf04E9uic3sTDrNkSw3/3kSwFEhCBy3+RNcwYMwPkYM01Tlfep1Xdd6+JPvz7G4nGTETFvNBvI4YdtSHbqQHdg1BzV6uO8bjg4N6RL1FHM91L+YedrEpW6tQs8P8v4QT6LqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756252453; c=relaxed/simple;
	bh=ydE+ViNllk5a621o+YYWVXfiuMKsv8vSm6n6UMnu18k=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=aDJipmA/y8ugAKFhPuQfGVA0N+DqKx7oRmSC7nRVUYB4fwts0CpIZb+tuQupYFoacY93mQCmLTIu1fwIjAOdVdDxBK3pVJjgzRFFq1QY4gonmMFY5+NSFihiE0v1db7k/jx8G0saA2oGVJp2h+Vg/BhvrWUbmVASnlqO1+gB3Yk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RA/4qbvG; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756252452; x=1787788452;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=ydE+ViNllk5a621o+YYWVXfiuMKsv8vSm6n6UMnu18k=;
  b=RA/4qbvGHtwK5Tv3LTeiC3+w60CJa9WQOxSoBEMIFCTwlaD6HmFwUpa5
   dsk6qw3UNJzJmdSuDEWo6OxXW62JYD9xG87qaYAicpGxfEO5wPF3/5lMM
   d3mh3sCi9/mFV46Rl995D+y+iO2Qbk9FXQ3zW9ytERO0P0oRHPmyBzBIm
   EYtgOZ0tUv1Cd8VP2SvP0mrEnrWHfT9hUn878+yZ+itySY+2yJFSsyfTN
   uih3zn/M+9vbtPv8zzQhWIAULpsMOq0r4r+SfL0a2khof1d9v9Df3s5B+
   Qj4HB3FZHW+Z/fqGhWtlNQbIE4iTnfJ/35OaQ5ikIi8EjK4O7n2H+VBeI
   Q==;
X-CSE-ConnectionGUID: 4C61xfHTSq2jQxbIj0cwzA==
X-CSE-MsgGUID: C1TK3RFXS3SLtg6Rc+WX7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="69216612"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="69216612"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 16:54:11 -0700
X-CSE-ConnectionGUID: HeedkkJnQeWYnjZ+qCRcXg==
X-CSE-MsgGUID: 3zzbSG28RSePqC2/S+7t1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="168945163"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 16:54:11 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 16:54:10 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 26 Aug 2025 16:54:10 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.73) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 16:54:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bibmEaPDxSYJfdEe3SpXBQ92LZ2s1q+LdRtdJrZEQy5aBmCM04sZ8xu6XiGAUiSxDrZShiQ54oC8OLfsGlScvV6VdrLT8BNWO5VP90srrR4zg8FKBHM37bz7kWNSRg3PaZE8s2cYz5qVy92A1qmvbAe3vJvBQQSSRBkEkwqlWZuS2PSIH2KBAH48WOadxIVr0DBdfE26ByrtB1u+qgV8XX24aT5bLqg2anxv9/1TMmcyca1kIRphWOe4GLzgK7W6cKzlwkL+FtyeuASrdqb40Dj0p2dDnpy64rSSbGZrqpaoeHSckEFyuxZ5kOTjZ9k+lybVQVbi3j+ALuYgU3g6MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I2C+7u3Ce/IQhAihbLkZhGfacnQvuhpt3D53wU1vRjo=;
 b=QNVTyPxKAvKdSD7BMmGKxKNft3K7rwtFhkhuf+qPy8UhZC++r1RV4tDycrbwp8pmuMNdqZQ8akXuD7A29/XnZebLkwrA9ssnSpS/xP6sTP8X7162cvwp/G9N3FX43VrlEYYSuJTrCzEUi7PCFvGGWZ+MygQTo8F0yu+T/bP+T6xBYNtuCCTaAnyQ5BUqExJyULwvHanwlU/w0Ts21kbr8ByB8T9z0081j2QLxiou/P/efZ05U/UOAD6Qfz9SJqYTq8QdxcpUCWWu6g2Ssk1dB2ilea9HOFx4NxLm1dH539C5u62bMx9K8gBpYT/q64VSr0iAfzAobGoGuvMF2YE+Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN6PR11MB8218.namprd11.prod.outlook.com (2603:10b6:208:47c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 23:54:08 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 23:54:08 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 26 Aug 2025 16:54:06 -0700
To: Alexey Kardashevskiy <aik@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>,
	<linux-pci@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <lukas@wunner.de>,
	<aneesh.kumar@kernel.org>, <suzuki.poulose@arm.com>, <sameo@rivosinc.com>,
	<jgg@nvidia.com>, <zhiw@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, "Xu
 Yilun" <yilun.xu@linux.intel.com>
Message-ID: <68ae491e1348a_75db10072@dwillia2-mobl4.notmuch>
In-Reply-To: <849c12a9-f801-46f8-8fff-09fbc259843e@amd.com>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-4-dan.j.williams@intel.com>
 <849c12a9-f801-46f8-8fff-09fbc259843e@amd.com>
Subject: Re: [PATCH v3 03/13] PCI/TSM: Authenticate devices via platform TSM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0078.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN6PR11MB8218:EE_
X-MS-Office365-Filtering-Correlation-Id: 089574b0-fd33-4182-922b-08dde4fbd885
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NTJUVkw3c25JOEFhVzc3QVhzU0p3TGJ6YW5weUhkTFUydXdNZExheXM4MkxB?=
 =?utf-8?B?UWRvVG9RQjR0VDBlTnFIbzRVMXJJL3Q5bWQzVkw4WUlJM09mM3RtVXptOUN3?=
 =?utf-8?B?MnVNeGgzUlNuVWE4M1FDY1ErMXBtWVFuazhXMEtZSmFGNmlBaWZuKzBvSkl6?=
 =?utf-8?B?OGMzZ1ZKMUUzUkU3c1BYK1BuSUs1UmtVTEVvbGg3NDR0d3ZyMjB1eHh2dDN0?=
 =?utf-8?B?Unc4UHF6YzFha0tnUEhpVkdjVWUxZHJkenZEcHl6L0JYLytMRzV0QVVqekUz?=
 =?utf-8?B?MEVqRStNWGtLRll1TE9JTTZnei9DUXRKNXgvQnlMcm80TG9JOFcwbkYrU2xL?=
 =?utf-8?B?RE5PTVY0SW9yd21QQ0YyNEFHZzJQUWZNZklhRE92SXZra2FBNjZiaENvdVJ0?=
 =?utf-8?B?RmlTZklKZVZlMkpaZlN0K280QkhtZWZlTWlJQWVIZzlTQzZGajY0ZHMxSEww?=
 =?utf-8?B?NTg5bjVJVVltRHZJbHhLdnorQTljejdOZUJPSEtkbXd0Q3lQNUw0ZERUcWJD?=
 =?utf-8?B?NlZoU1BBZTRidEJOalpMNmU5Sk0wdHRJNCt4Q1Q3bmhuSEVubFR4QVNBU0Rs?=
 =?utf-8?B?WXFwYzhhVlgwV1htTUJoWWd0SmErbDAzWS9CQWN1WjEyNkRPZ3AvRURJNFJV?=
 =?utf-8?B?TFNzeVVGNW0yRmxpSHhuYkF3L2Q4WEhNWDgzYzJKbUVNbm5ESjBGNmpzOE9y?=
 =?utf-8?B?S2FJc3ZPdFJjMVNYQ0F6amFacmp3d21hUUlDVHFCOUFucFMvaTl0SWVmNUlo?=
 =?utf-8?B?YzNXaSsrTTJYSFJTMTVQa0NhM1RQRzh5bThCK0x3T1QwUDU5bERNT2tyWmF3?=
 =?utf-8?B?WVlrcE9QMGVYSWFBbmhtVS9UM0s2NWxnSlY4Z3VUamxvZFhHdzVicmowcFAw?=
 =?utf-8?B?bjQ4MEQ1YklLMkRKK3QxK3Y1RWJXbnE0YUlmSFE3ZHB4aGFoRTVxa3FKTXlW?=
 =?utf-8?B?WGRzcXo5d2oybG9aK1gyZ3JCdkZEb0tjL0d4NVk3K2w5enRwVEx1SE0vSTV5?=
 =?utf-8?B?QWpuOXA0SEM3L2loRlc1TTFkTmtyRk9nMWpNU2lxOUdpRkNBSzdKRkpBbWxW?=
 =?utf-8?B?OGg1dTlOUjVrVVcvd3lSYVhoejM3TUNiZDI0aU1FbkJnVjEzS0tXYzBVenNE?=
 =?utf-8?B?WjFzV3RPbU1DNU01QXlhQWpKSksyMmFtZWhxRUViaWVHMkxDVGhld3ZOK2Vj?=
 =?utf-8?B?TVpId3h0TWNRdmRIcUNwRWJkZHgyRzJOUVZyWjR0ZTZLbThLU2RpRnhRWW52?=
 =?utf-8?B?VWp0UTk5bDdKRzBzUjdiUEFDK3dDcE1Zd0dSdTRJc2xiUHdPVlIvK0pyZGRu?=
 =?utf-8?B?M2lMMVdXSm1JVlhjWDRBdXJ4cW9uY0RLTEhtNndUV0FMcFBKaU1HM2Z3a0w4?=
 =?utf-8?B?WDl6R0ljRHhseFpKeDluOEZGR245b3VuUit6TEZSSG83NTFxbFlZUDZGcUhE?=
 =?utf-8?B?SGpLL3ZXVk0xYk5wbi9UYU5nN1ltWlFtSW1FZ2xJcm5OeFpmKzRQdGFDVE5o?=
 =?utf-8?B?Yk02elEvTC85OEdQSWQ3bFhCV3N3K1lyVlJEdkU4Ym1yZXJUVVAzaUhlNDdv?=
 =?utf-8?B?QjRCZnFJdnU0M0I2U29ObzlheFhtSjUvMk51VnlxemJXY3BGNllUa3VwbGZ2?=
 =?utf-8?B?ak1wbEtMVG1Ub0prcDhDV3czRmhoeTdXTjZ3cWpmTmhxR0RwRFl5K2xhNzht?=
 =?utf-8?B?cHJ3L09Od1o5YTJzenFLZnRIQ0czd1hpWTU0ZlJaY0pLNnpjdkhJMk01NE90?=
 =?utf-8?B?V2JqNFhVRngyUC9nTmJVVEgxTXk2N0Y2MnRSTHdZTUk2Vk1FNW55eDd4SEE0?=
 =?utf-8?B?emlBTG92Vk1Ubmgzd05BOTI5eW9ZWVVxMENNS0oycGl6N05lSUtMb1JVNWVR?=
 =?utf-8?B?YTdYb0p2NjhBUHg0cXRXZEtzQTA3ZmpEWlRmczJYd1pwZ0tmUWhUT2prb1cr?=
 =?utf-8?Q?hOBstfbuAFU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QW5JS3VMZHNneXpjY1pzbTc2UDduMitJS0RQSFhRY042azBaVlhKN1RUeEF3?=
 =?utf-8?B?UWlabXNFdWlLYi9KQ0tMcTdaOTFUZWxxb3ovZDJXMXVHSFhoSlZOMjE0L3Yz?=
 =?utf-8?B?YjMxakJjR3VIOEZ2Ny80VmJUMTIxL1V5eWJtdjJZTGk4eGhxMk0za3NjNTZU?=
 =?utf-8?B?SUx1OG5zQVpGSGEzMU1wUnNjTFl4OGtEYzk3bnpqRnNLbm9KMkFMWDdrWUNN?=
 =?utf-8?B?cTlKOTl0ZjNFY2JReU9JYk5IN3lrL2piVHV6c1hab3l6L0RBczZkTklNT0VW?=
 =?utf-8?B?Y2RhWVk4VHVCVGdleldLM3IxekdWUEdUZEVtblR2dW5KR0pkUHVsZGtiYkx6?=
 =?utf-8?B?NERhMnRvRGk4eVNuNWJQUFNYSHVFRVJ3Sjgyd09MTmMvK2cvTjd5Y3BsbnVE?=
 =?utf-8?B?VU82c0xsNXBhVXFIOXFQQkh1bVNFSkxFdEY5cC9seTMzclBJMHZDVjB5aXVK?=
 =?utf-8?B?MkhpeldEcnlBeTRKTWEzTXFyR1M1MXhMbFZGUFYwcU10eVV5R29kTmdlVEVp?=
 =?utf-8?B?RE9wUmNGMlJDcWFBWS9WNkdPM09RRkpWUk1QRXVtQjczbThkaTUySC9GQUZM?=
 =?utf-8?B?YmZyTmNROXpRRDZzdUNkVFFibHBTZGdnc1FhNkhHRm9FYVVDWTdJQUNFMEdG?=
 =?utf-8?B?VWZTZW1MUSt2eXJZTS9QNE9jR0hIMFdMVy9LekR3S293ZjFwcmVvdkRDUFRI?=
 =?utf-8?B?VDJQVWdtN1RGSUJjM0dBUEhhdmVJVjNtaGVSNTcxamZrMU5NZ2lyQ0l4VTZt?=
 =?utf-8?B?dlplSko5NnNadS9rL2ZLbjNHc2ZnUWRJbUdIZ0pvZDlrUnhTRGN6alZ0bHpM?=
 =?utf-8?B?SEVQTkRWOGZTQmtwMmlMRm14NUhYVjV4UHgvV2E4Vzl1clFRL25Dajl0NVM4?=
 =?utf-8?B?MER0bk5vd1VjSGFkT2FLKzN3SENiSnAzOWlUdDN6aWx5Qzc4eFEzOTZoKzQ4?=
 =?utf-8?B?QVRJMFprdmcrM1pZbS9SeE0wNUxrektjeHZwMDhtcXRGbkNLU2dxWjk3MVlt?=
 =?utf-8?B?Y1d3UmIwQm01YldFOHV0M0F0SHdvY3BHNmZ0MW5LUjdUYWVHamZuYnpFQTlE?=
 =?utf-8?B?R2p4bFlDZ3IzbmVVL3pianZGYm1xTlFSbUY1eXkreWhHQW1GR05jMWVmKzIy?=
 =?utf-8?B?a2Fmd3M3WnJLRndlb3JUejZielA0eXFkYzZSa25WWlRzZzhvdDVXWWNCbnhi?=
 =?utf-8?B?R05jcnlEeHQyeVd0bXFhTk11VHdvY2Rzc1llNEZqZlgyUTZvVzYxR0VYcGhh?=
 =?utf-8?B?cFBtRUVKcEFPbm5PeURxYko3VXduRmxsWjgyMllYSEFSb25lTXFMeFY3MnVV?=
 =?utf-8?B?cU8wRlgxdmQ4bVBJa0Z1aWw0dFczNjlYTkNiV0UxaDRjU21BV0Q1SjRiNjJB?=
 =?utf-8?B?S3haWlRZVVlUL25aWTA1THQzODFVV3VHSGs4akNmU3lMYjFFR2dxOXlFUXRT?=
 =?utf-8?B?Q21mS0dLNzF6VWZIU2xqbnVtWmROMEFVRDJ0aEw2YWwrZnlkdzBYaGt4V3ZG?=
 =?utf-8?B?N3JFUURxelZsWjZsWnJCTVpscFdxN0h5czMrbVhvc0E0L3VTQ3lzWEFjMGRW?=
 =?utf-8?B?cVN1Q3ZEM3l6b0hlaFFZck9vTWlPMUFyemMwLzRhYVgwUW0zdnlNWDNNTUhp?=
 =?utf-8?B?TUw5ZWZVanNyVGZFc2pJa2hxS3lpRy9CaGZMaHFKT2N2WThGRytDNUxPZEp2?=
 =?utf-8?B?WFB4aW9oRWpxRCt0dFlydGRkR2pBTVM3dU9WYVROODNRVnY1dE5Rd296QTVN?=
 =?utf-8?B?RThnOTFNNm8vQUcvQitNTXpoMkRDdXBuZ2FkdFpLLytBSHB1ZXdubm9qaWdW?=
 =?utf-8?B?T0tiOU5ZMklDL3p0aDB1YU1BOUg0VG5UUWE4Y1V1UTlDTUxTMXN4U1VzOTBS?=
 =?utf-8?B?MVVuTCtidUZoOGlBd21hZG5sdGJBYi9mQ3dNMGkyM2hsWWdrTThxZVZDZ1BM?=
 =?utf-8?B?T3lFMDIwSVpNYjVYbTdUWkNnakNQbUR5TmxQTFZmZmw3TVdzOFY4QUxJNlZQ?=
 =?utf-8?B?NGw0UUE5Z1d6ekNhMHVCY0Q4NlB3QzVHaFJncDVPM1BGZ0RPY05YaHduWVMv?=
 =?utf-8?B?alQ0aFJqRXBVSDA5VkQ0cnl5aE84N21PM2V0OFdXcUt5Q3ZMQlNGY1RiYlkr?=
 =?utf-8?B?TmllcWR1Y0JqVUhxTTAwM0QzT2o0a1V4OHQ1N1lyaTA5cDIwOHhOQWtyMzhm?=
 =?utf-8?B?VFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 089574b0-fd33-4182-922b-08dde4fbd885
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 23:54:07.9391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wSA0DDhyHYuTIFTqGJBFSCC3ntFqA9eip70XdCLDPEaklpujWas7ERHi0H2Ypb6E1kosceHv3z0QO7ORb2xS1WFjOVCdAuiAfj7ImyiCYB4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8218
X-OriginatorOrg: intel.com

Alexey Kardashevskiy wrote:
[..]
[trim multiple pages of uncommented context, please trim your replies]

> > +/**
> > + * pci_tsm_pf0_initialize() - common 'struct pci_tsm_pf0' initialization
> > + * @pdev: Physical Function 0 PCI device
> > + * @tsm: context to initialize
> > + */
> > +int pci_tsm_pf0_initialize(struct pci_dev *pdev, struct pci_tsm_pf0 *tsm)
> 
> Here it is: struct pci_tsm_pf0 *tsm  (it is really a "dsm")

All of the context returned by the TSM driver is a "tsm" context, the
only time use "dsm" is in referring to the actual pci_dev that runs the
SPDM session.

> In pci_tsm: struct pci_dev *dsm (alright)
> 
> May be we need some distinction between PF0's pci_dev and pci_tsm_pf0 but still these are DSMs.
> 
> In pci_tsm_pf0 it is: struct pci_tsm tsm, imho "base" is less confusing (I keep catching myself thinking it is a pointer to tsm_dev).

Ok, I can change it to base.

> "tsm" would be what you call "tsm_dev" which is ok but seeing short "tsm" used as "dsm" or "TSM data for this pci_dev" is confusing.
> 
> s/pci_tsm/pci_tsm_ctx/ and s/tsm/tsm_ctx/ ? Thanks,

What is a tsm_ctx? The s/pci_tsm/pci_tsm_ctx/ rename is not adding more
clarity for me. If Aneesh or Yilun also find that rename clarifying I
will switch. For v5 I will stick with 'struct pci_tsm' as the PCI object
that wraps TSM driver produced objects.

The reason I do not think of "pci_tsm" as a "tsm_dev" is because PCI is
always a consumer of an outside of PCI TSM service provided, PCI does
not have a TSM concept internal to it.

