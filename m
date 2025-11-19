Return-Path: <linux-pci+bounces-41580-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 53ECCC6C952
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 04:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D4AF04EFFB6
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 03:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D242F6191;
	Wed, 19 Nov 2025 03:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NlW5nF9e"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CB522D4E9;
	Wed, 19 Nov 2025 03:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763522428; cv=fail; b=hGnbrB8dz6XXULXD5sIaBdPThyWxyLKm00boU4cWfFrwNzD4e8tS0kj8WlkGqSFizShCL5s2rPpl9duymsNwUwP5SttQtN9eASpzvDfmp3CjJ+lN/l0q2r9owyB+ztzGc7epFkwZm1wxr9CxfCEq38FkaHQdGsqaP6A5kxdnwYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763522428; c=relaxed/simple;
	bh=+57JhCfxf70mjBPxDUEvOLgybhn2fcgKI7nOGb+12eQ=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=F3DIlOCzU5HR8ONIj2tWg5M2HOrfR6gh+z7dIJcV5aRgC6KN0RfVqN4/7xkw1oDCvdxzbFmQB0MWcBZiqTnmoCLzE+ZwPacxMW4j7P2v5y+PcwZMH5oMDhbeB/TZP12S1DXXbrZEAcPaXN9LYBGGFWFnsPKjBdq60GSYbY7T2H0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NlW5nF9e; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763522427; x=1795058427;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=+57JhCfxf70mjBPxDUEvOLgybhn2fcgKI7nOGb+12eQ=;
  b=NlW5nF9eLcsuIr2GWVK6eP5nv+GjyAdeMXwXzKM2xsormJzjpPn4Z1C2
   FGtNKJTW7GUzUTfglyL6mHo406tXeNmFnGe1+mkc2aAS0/F/Yd4I4va52
   VXNoZYwPFPaIe7ko928j8IWVWapjX6reaITEHtHUqQfQjul5C0FGvVFje
   URW97opbygUn9cvp/owsWO2VlwCAAChlt/tXJbv34RcWFsp1301oo+ybl
   F8r0+/A4faHIEYYbmBhnSUhZx62uPHk5P12Z95d9syu4oSoL6vGsvgfWl
   FE5a24+8QBmewSF8bA7mhRpSt3ckjsBKqmUtCWz1WNAK7AqH5S9PTDOt4
   Q==;
X-CSE-ConnectionGUID: x4WIV0YFSIKQjLP7TLlVLg==
X-CSE-MsgGUID: E2blF1OUQTaHDOxlVw6TCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="65497576"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="65497576"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 19:20:26 -0800
X-CSE-ConnectionGUID: ZhU1B2GvT0OYiANoSVb3rg==
X-CSE-MsgGUID: /kREiTQcQrW9+FNZTXth/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="196067622"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 19:20:26 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 19:20:25 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 18 Nov 2025 19:20:25 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.46) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 19:20:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sZwOCYJQoBO62vsNHXFYEjUEQ+tklGKoIaTDWBGVwa4ORnj0jkze4ojg7lBHoV7H2XGU9okb891o9F0brN4Doq/hjtMcvJga1F0Q1iyp3VCqZxL30yODG3xwES+aZO6NmU/Pj+Zm2SsWeF/4lL1NAKve+pTc6UtHXT/KvJ+nTQvNKAi5+ARnzjkN8VcoQyln2Vaq7ig/1b4TD47iPXjhofBAKAfNa9LpKNYygbUhFKGIbidP8OtLwmtATilKfX9I+41BZYTy0AOfMKspxhpr5yA/04hoTRRxO6vrB/0ypKz2FlmlCjVrzebBS3qfZ5kx9npKorUdEphpOsZLe9+1mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Ob4c/SECEqb2tPtTUZdT0D0QDOwkWZTBPC+qtpsvbU=;
 b=X4Vja7eQk/kCZ+hBNwl4IRe/nmRN7IAB8BcPL9JPzFDomDNWz/SDoSxGRTdb+hahL31G/RW4YRUui13xABWYEt2DI9vjNuAIEv9uVs6A2hvIDu2EzY1HR5qVHf8P6qZ/3br5ILCS+RjnEtDJJekn8inFpXDJIlBDIdVrYgtalP0koyLuISkvcDwkGq4xQJFENiTpX5SS3zjkjYdwlrFC3JMfzJ52FfUGE1tNPpwvnszCYj9qjE0+IOspzsO7dk2Q0iXnhOb+ZSVKQCrERtg4wi78inn9pMMUxMBTiKbOYx96zpSJ7j1wHI0GQcj7XwOr7r2nnVrsKi/AjKjUTamYyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ5PPF99DB14780.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::847) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 03:20:24 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9320.021; Wed, 19 Nov 2025
 03:20:24 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 18 Nov 2025 19:20:22 -0800
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
Message-ID: <691d377611d7b_1a37510056@dwillia2-mobl4.notmuch>
In-Reply-To: <20251104170305.4163840-9-terry.bowman@amd.com>
References: <20251104170305.4163840-1-terry.bowman@amd.com>
 <20251104170305.4163840-9-terry.bowman@amd.com>
Subject: Re: [RESEND v13 08/25] CXL/AER: Move AER drivers RCH error handling
 into pcie/aer_cxl_rch.c
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::37) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ5PPF99DB14780:EE_
X-MS-Office365-Filtering-Correlation-Id: c44f826a-4dde-4bef-055c-08de271a93fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MjdwUEt2SDFpUUZGT1lBNEwzaWlhVDlXME9xQWhjVVFsd01KMmZCVnlMWlZr?=
 =?utf-8?B?VnloWmVLMmlxUDFzWTVpTHByN1RuL3JSVHNnaG5PUDd5VlR6dzhjaXZKUHM2?=
 =?utf-8?B?ZDN1ZkNLNUJBbmNCWndobUdSdlkzT1pSQzdyOXA4dUFnd2ovRUNyVVFRQ05X?=
 =?utf-8?B?Y2JiWENwNnJ2aXVpL1k4TWpKcGNEeEl3SytMSitQcmJCTGpFSzdUajdQYmNX?=
 =?utf-8?B?c1RLdnA5SzV3TittTmEvNmF1NURza0FQUG9xc0M2YzA1R1hCLzhEWVY2eFRE?=
 =?utf-8?B?U2F6TFVpcHZpUzR6WWRIbzdmMWUyQ1c3Sm0xMUFZMU1jYmpzdmgrL3lIb2Ez?=
 =?utf-8?B?eC9vZ1hEN3N2TVpWUEE5Z3dDaWhTaWN6cWNVTHowVUFTK3g5RzFkcGFuN28z?=
 =?utf-8?B?amRJR0ozN0RXZVNqVFEvdGcyNGk0V2VYcHpEWTRqa3ZPUk9KVFgrZ3hGdnAv?=
 =?utf-8?B?VEpyN0Fxby9TY1puVUI5SlVEWWFpekZKOFdvTWNHR2hiRG1YZ25Jc2I4RHZ0?=
 =?utf-8?B?SnJTSDRaeU5oOFU0VXhGTk0vUlV3N2tuWXdRUlEyck9ReTJUaStOcXpxekdj?=
 =?utf-8?B?K05IRTllTllxOS9CaEV3WW5ZQ2tWbVZoeGZvaGMwcDZBRXJDWVNCeExYem5K?=
 =?utf-8?B?RVNMaWJPRUlIRGZ3Tisva2NlQXVxR052bVJjWHUzdm40ejV6Z0Y0TTA5SzYw?=
 =?utf-8?B?N1Q0S3ZiUk42bkxrK0RKdUdScnRSSmU4M0p3Y2wwWEp4Q2ZtRkdwczNUS3Yz?=
 =?utf-8?B?SGljNWw4d0hUb1BFRmNySlJQR0RkTDhxKzJ4MTV3MGwrYnpJczE0UkJuVzRa?=
 =?utf-8?B?T1AwSEZ2SFA0OU9KNmpBMEZuK05zVFZqRHYrLzdVdUhqaUp5MUswTE15clZE?=
 =?utf-8?B?NmFaNUQyd2hsSGFET0g1enRIWUlSK1QwQnVNb2FlYlJjZUdMa0grWXFCMS92?=
 =?utf-8?B?YUNJeWJsZkxJVUcwYVAyNXFRS1Q4eFJId1Q4ajN0SkhrdHd0UkFPMkhua2lR?=
 =?utf-8?B?VjZ4SXdOUCs3OFg2cExpRTh2dWNBaVFTanRLclZsZys0WUhZbDBlOVM2UjlP?=
 =?utf-8?B?aE9CRnRoWldWMW5UL1RjMVFaZUtJbGc5ZXRpVFlrWG9ETXBIK3BGbGtlWVhW?=
 =?utf-8?B?aHdta2lRTzl6QlRuOEFRbWRJRUNQWUl3bGNvTFErbjNzWWYrdGVTSE9KSmpY?=
 =?utf-8?B?NzRTeXgrMFJEVmxHSTNaTmFmbjZrcWpHTG43ZkljZ3I0ZzU4UGJBZDBBTmFO?=
 =?utf-8?B?VU03bWVoenAwVmtkMStFY05Rb1JwbDl5S0tYeFMyQlNMbkd0WUlxaWxPdzVT?=
 =?utf-8?B?QjlrRVV0Y2ZRWVJVRmpUV0wrQ0xYZFNJNmdWZGdEODNDaUkvN293VUIvelQ5?=
 =?utf-8?B?anVDSFMyTlJQU2hVVG9EMEdVOHQ0V2svZDFCYjJrYStWSE5OVk1CbFYxeE5r?=
 =?utf-8?B?cUpXUXlWenovdTRuK3BqV3RwejlhbXV5LzdzR0VxWHVHUXlZaHFydHdZTk5u?=
 =?utf-8?B?VjFxOFB1Qzkrd2x2b25JeGNFZFNzMFZNcU1Iak5tNWFOdGJlUHdzTnRRSlF4?=
 =?utf-8?B?eEx0UWF2LzBnSUd2RVY5ck0zRld2aForZGt5U0g0NWZwcmRPeWhOS1NVQlZT?=
 =?utf-8?B?S1QwbDF0NUx5VFhkd2ZrSlNaWGl0SVo2Q1hpZE90VGpVeUQ1VThqM2NHbS95?=
 =?utf-8?B?dXZ6YTM3b2ZXcFVYMXNDT3hmdnY3R0pnVTNhWVM4OHU4VGtrSzh6UUtZVDRL?=
 =?utf-8?B?R25ud3oyS2d0Zm9OeWt1eTNTTTdjdXhZcmo3YnIwS0NxUkVJZ1pva2cweFNF?=
 =?utf-8?B?cXNtaTFJejBMOFdCZ3VPVW4reEZidnh6K0dRdnZXbzIvOXJ5djAwMG5INXkr?=
 =?utf-8?B?cjhPdzhIQVA0K0hHci8xalIxYUJXMkl6SU1IMVJBR1IvYnBxZEg2QnlUYno3?=
 =?utf-8?B?Y1BBa1F2VUYybmd5MmE1cFkxd292VndtL1VZOGZaRlg5bDF4VUFxb214Q1hP?=
 =?utf-8?Q?yit04znTsW7eohE2KPkpDs6sq/4OJI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzVWTkNnZ3c1eUREOEd3aDJ2WmJDZ0lDWXFOdWxqdlVpNnowYXdYcWc3SEU0?=
 =?utf-8?B?eHBKMGowT3p2bGc1ZTdaQTdYeEszNmZnak5YZDQrWjBieGt4ZUE4NWtVM3NC?=
 =?utf-8?B?ZUtINklhbFFUbC8rNkgxbko0TjFRR1NXNDdHRVNWS3FKZTg3MnhXbDNBUjFM?=
 =?utf-8?B?SnIvN0d6RTVRRjFydkd0TmtNWGRITUE0WXM2ME4yVStJSnFpTzVmVHpGS0FQ?=
 =?utf-8?B?Ri9EdURVbjdsMHVIQkRjMG40QWRtbXA0ZHUzS0M4MytKQVJDWFg3czNXc2Y1?=
 =?utf-8?B?WEFaNG9xYzF4MlZCeU1TVVoxTU9ScUJMNmRDNGVURXZJS1JiVm9rMjhNdnVR?=
 =?utf-8?B?Vk9pRXBZeHREVFp3NUQzcTljR21UMkZXRnlibWlkOFYwSHJUVzc4SG5rNVhp?=
 =?utf-8?B?MGU1eGFiREFtZ1RtRFh3NWxwYUJ1TmtPcFI4VGIzOEpzaDlqa0dNNXRkZVd0?=
 =?utf-8?B?cENOSWljdkprMGNGd2J0czA1clBQcnNQVUFwbHJ2SDhhMTNkTS9zNDBUTTF3?=
 =?utf-8?B?NEJwYTduSjRRWVhVSUM5dlRkQTR4WFdnYUdMVWdBM0R0b05QcEc3QmZKMHJk?=
 =?utf-8?B?bG5DSEdrQXRCRm5MdFFiRFM2blJLb2hJeWdrL3dVaXdwRDR2MFl2TUpQYndW?=
 =?utf-8?B?WUtWTHBNNGZYWXp1b1AzZ3VNTHlvTDQ3SzRhcXJpZXMvVjBRM1NDRVd6RVFR?=
 =?utf-8?B?WG42dFR6SERMd2RYV24wa2FUWnZCOWVLR1JTNm5XUFBkVlU1Y29UTHduWHRR?=
 =?utf-8?B?eVNNdU9VMHQybmliWEt0cGV1Y2REWGtIZGZWSUNoVmcrV1VzOGJ5S2Z1enJX?=
 =?utf-8?B?UnVHd1ZibktMdVNJZnhzd0pjWUIxOUx4c2lGM1lsWkRMRTdQbTVRTURKVXE0?=
 =?utf-8?B?bkJhT2tlNmIvZjZBNzlJclBDQk1aSVlnNi9oZ0lnWkJmTDBtd3pBR2huS2F1?=
 =?utf-8?B?RUtzRmZxTkZCbk5tZ05WeU1NQXpKUTExei80R1JwUUsxNXpkUThxT1crRkpB?=
 =?utf-8?B?QlNldXByRjB1VFBQM29XdVp4MHdvN20rQ01HWXhYS3NEckp6ZlcwMUMySHNI?=
 =?utf-8?B?V2UreTU2OGQ1dzM2QmhPb2piU0w4M2l4N0RhL1dQZVV1WXdTK2JoYm5FdEgx?=
 =?utf-8?B?U0M0MEVzM0RKOFI5YUVkSC8yRnhscGx2cDJIUWhuRWlpSUxac0lBeHpNOEN6?=
 =?utf-8?B?a3VDWEZ5cWdDaUVSUGMrY1FPY28wNHhHaGNBMkNmTHBZS2dxakhOUjFBMEdw?=
 =?utf-8?B?RnREY0o2QzV1cHRYcllBT1E4UlVkbUhIc0hLU1h2OHkyK0FEaVBFdDAxWlk4?=
 =?utf-8?B?NUVIMXZTUEFrQWJQOGJwSHFzRVhwclR1TXJRZGlQWGlFR0QwdDFUeHo3T1ZR?=
 =?utf-8?B?bGdSWDhIRjZid1N1RHJpNGJzMExNbUNuVmVJZWMvM1VwR0NPSytXN3ZzYTYx?=
 =?utf-8?B?SUs5aGRwb3dNNnR1eTQrcGc1cHNiWXRzZE12WHl5V01JcGdMcjFhbGdmOXBi?=
 =?utf-8?B?SkhybGNuMFlEc2Uxc3hnSlQvbVJ1eW5FOFhZUzJIMmlhM0ZmUTdablJZNGs0?=
 =?utf-8?B?MTM1eDc3YVlUSnFjaXVGZmVZdnlvTmF3K29HT3V1U3U0ZXBURWVuOHJFcVZX?=
 =?utf-8?B?bFlWTW9xSkE2N3czTXFabDIwU3E0WGxSSmRzN3k1RUxOZVZYanJSc0Z2anU1?=
 =?utf-8?B?TUxHNFFoekZvczB3MkI3ZEhqMXpDclNCTzZMUzRSdHFaVzBSZG5mWjU4M2Fr?=
 =?utf-8?B?d21qRUpoWGZwRlM5cHBFRjM0NUZ5RER5amFkY2kvQjhmQ2NvZ3pEZ0p1MlA3?=
 =?utf-8?B?T2pyV1liZDBQV0FmM0c1T0pONWk2NDFKMFpjdEZXWTRhV2k0S1NrVDlZTHBL?=
 =?utf-8?B?WDhiaVZ5RFZNMmloYVZ5SnowNVpSbFU1S3FCbmhGdUQrUDBHSUxmNGd5Y09G?=
 =?utf-8?B?V1pJZHJqMlpyeEVMWmh5cjJBeEJ2bitkWldyUHhsdzM1cmg3d1o1UFBNc0FJ?=
 =?utf-8?B?NGtWT0Z0YlgwTXk5WXRxZ1VMdWJ4QVFkRkdGbmFwUm1sM2tpTC9NMDRmSHFm?=
 =?utf-8?B?Wkw2eDZEdnU3Y0ZPUVd3SDU1LzdQajRXOEo4NWZuVm9vczgxQnVEWHJueTJq?=
 =?utf-8?B?ZlR4L0xXZE5mMktReDdIcWxkK3dKQVZZdkM5SUFhc0Q5TEN2YlJtL3Rqd3FO?=
 =?utf-8?B?SHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c44f826a-4dde-4bef-055c-08de271a93fb
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 03:20:24.0145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y2V/CpdGTZHYtPh96xdT99iHqJgGsAHZhEiMFHATBhw3rpMceI/pef/dfXxrZ2sIAVkswPCsJ/spSWIr1lYi1qtqzNcQ/FlvWuYbFiIlA/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF99DB14780
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> The restricted CXL Host (RCH) AER error handling logic currently resides
> in the AER driver file, drivers/pci/pcie/aer.c. CXL specific changes are
> conditionally compiled using #ifdefs.
> 
> Improve the AER driver maintainability by separating the RCH specific logic
> from the AER driver's core functionality and removing the ifdefs. Introduce
> drivers/pci/pcie/aer_cxl_rch.c for moving the RCH AER logic into.

Understood what you meant, but:

"Introduce drivers/pci/pcie/aer_cxl_rch.c for the RCH AER logic."

> Conditionally compile the file using the CONFIG_CXL_RCH_RAS Kconfig.
> 
> Move the CXL logic into the new file but leave helper functions in aer.c
> for now as they will be moved in future patch for CXL virtual hierarchy
> handling. Export the handler functions as needed. Export
> pci_aer_unmask_internal_errors() allowing for all subsystems to use.
> Avoid multiple declaration moves and export cxl_error_is_native() now to
> allow access from cxl_core.
> 
> Inorder to maintain compilation after the move other changes are required.
> Change cxl_rch_handle_error() & cxl_rch_enable_rcec() to be non-static
> inorder for accessing from the AER driver in aer.c.
> 
> Update the new file with the SPDX and 2023 AMD copyright notations because
> the RCH bits were initally contributed in 2023 by AMD.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> 
> ---
[..]
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index cbaed65577d9..f5f22216bb41 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1130,7 +1130,7 @@ static bool find_source_device(struct pci_dev *parent,
>   * Note: AER must be enabled and supported by the device which must be
>   * checked in advance, e.g. with pcie_aer_is_native().
>   */
> -static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
> +void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>  {
>  	int aer = dev->aer_cap;
>  	u32 mask;
> @@ -1143,116 +1143,25 @@ static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>  	mask &= ~PCI_ERR_COR_INTERNAL;
>  	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
>  }
> +EXPORT_SYMBOL_GPL(pci_aer_unmask_internal_errors);

I can not imagine any other driver but the CXL core consuming this
symbol, so how about:

EXPORT_SYMBOL_FOR_MODULES(pci_aer_unmask_internal_errors, "cxl_core")

...ditto for all the new exports.

[..]
> +EXPORT_SYMBOL_NS_GPL(is_internal_error, "CXL");

Perhaps pci_aer_is_internal()?

Otherwise "is_internal_error()" seems too generic a name for a new
global symbol.

With those fixups:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

