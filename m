Return-Path: <linux-pci+bounces-41707-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA5BC719DA
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 01:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 1B41128E56
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 00:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D171D8E10;
	Thu, 20 Nov 2025 00:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C1JTK7zX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F67D1A76BB;
	Thu, 20 Nov 2025 00:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763600052; cv=fail; b=hbkv+tvA19BqNSiVRLHeE9HBU2LhmxKxvGMLUYMn2jc1Dw+VlJyvtmbwOTmAb1DFDRGt89KomE+5p3XWoiwNww8UMDSqJ5fPdNW4O2dejfQFpzA/2vDrJBnYj5iuIVZhUmoLCx02/eash2zA5icEpG4uAhxbYyozkkvoVgdtJvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763600052; c=relaxed/simple;
	bh=SvK3l9JTitT5gFyN5/hkqzH59VhRctQWlz8qInVHygk=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=otECA1NMEmpOuvbq6M3OltSC4GG4GQK/uKu4zBZc9acnLXI1mXXPoyYF8heqpEgpxKezFUag8s+Ed36AY8RmnQLzZqdyHQEnBI5MvTdVVozBoi+PsApB1AsohpEBZbGCSzqUsCPWG1XsaUt+17ZWj7i2PJiY/Mux7N5z/6F+xlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C1JTK7zX; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763600050; x=1795136050;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=SvK3l9JTitT5gFyN5/hkqzH59VhRctQWlz8qInVHygk=;
  b=C1JTK7zXOl5xlyITiKy79uTfBm4IHHPxfsme95hXF2Ns/33TQMy+mxWr
   Hwdd97m5J/F8Z+9seMVbqJFpZ18suRVPGi4F7pAzT6A9WTfheAo7P9K+7
   OqbCQMfV6ZuzVtBua3uJNnXem3U9ipC71FXPgt0yJXnVUHAmcgI9DolPX
   uz1Esh5i3aZyRObS2YNJy3n1wsC1UiS8XzaXzjRFkCrxzCwVrs+nJh+MP
   0b5Bb5uqrchGnxE9jOSvCF8nemb98WF5yYDLgeFSAbdAHZ8zXYeML4jYh
   7yWRaGZh+OmCqjg7JGTRVp50cnIdng/SayAKZlbckYznMLVgmvmtu6s5C
   Q==;
X-CSE-ConnectionGUID: VNWMel9FSR+bruU2YCk70A==
X-CSE-MsgGUID: k4YikjhfSQ+2pLIFnNPQwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="53231318"
X-IronPort-AV: E=Sophos;i="6.19,316,1754982000"; 
   d="scan'208";a="53231318"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 16:54:10 -0800
X-CSE-ConnectionGUID: w3QC1bxCSXCr5W1QRTabpA==
X-CSE-MsgGUID: yZU3tQSkTBWbcim0S4raCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,316,1754982000"; 
   d="scan'208";a="192012306"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 16:54:10 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 19 Nov 2025 16:54:09 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 19 Nov 2025 16:54:09 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.71) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 19 Nov 2025 16:54:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=phf4bVTkXRDcXzEHhdbsMEi7RuG7cND122wSb8fwngifPHgMruaM+1LcFsEEeP4d4sJ7byzeIKBRsnICWJ1fPwPrMg82JM/oMAwTyr5LPamegurrJKTaQbS/vKmWrpNKj9FTp/UC//atruYwrzx4Sq5YCqelNfZ9lm7T8QoorFjRL409ccOVYU5y+O3YLMGSMkyHbHUteITHzRPlNtx87u23WaLRCiLIFU/LlNNJLNweP+l9e4XJmGA3M51KQC474S/WvcdqjYD41sYHx1YYHMfa9yHMPMx/WilbxPRgx9/v8Fz8QPrCDD4dxwSv2mtBNy1sXp/wygXOwjOasBONYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a1bgtVXE+zpBhKlmptOZV790SSth24fKmGbpWQkJrX0=;
 b=yqOv/pjDMY1qEoDnBghE4yqzm0m0c2Zdl1mOFE5oMwDWtSdp2uglp+8nTOmp2zHQijm2RTTVh4llSpXLuYqFNC65d47yFamXFUS84n7njQRuEDuaHQ1N0z/ypOvOulcrcmqM/wH8GJAhQRKdp6MS2sllLaAuN5gra6ec6vumvVhw1MOv1x+w9zN6bmEetS6sE8PU5Ft99zj1pLGplqxIFfcytFQTfGnxj9CLV0TLe0cCYy+t2wEyb6ACq2qpvwNjy49sKRxgTYBPN710muqZNSM4Jl4+0QP8/dabVlJT0XtqmOHUJwKpAvtly7XN2S1vI0L6ovzjqnE5aPJzC9RO8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM6PR11MB4723.namprd11.prod.outlook.com (2603:10b6:5:2a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 00:54:01 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 00:54:01 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 19 Nov 2025 16:53:59 -0800
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
Message-ID: <691e66a7cda6b_1a375100e@dwillia2-mobl4.notmuch>
In-Reply-To: <20251104170305.4163840-17-terry.bowman@amd.com>
References: <20251104170305.4163840-1-terry.bowman@amd.com>
 <20251104170305.4163840-17-terry.bowman@amd.com>
Subject: Re: [RESEND v13 16/25] CXL/AER: Introduce pcie/aer_cxl_vh.c in AER
 driver for forwarding CXL errors
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0045.namprd05.prod.outlook.com
 (2603:10b6:a03:74::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM6PR11MB4723:EE_
X-MS-Office365-Filtering-Correlation-Id: deb03820-7d8f-429b-74de-08de27cf4b83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ditQelNwMVpncndHWkhwRERYcnFIUEwxZk9RSlVSWHZsT0ovWHlwaWx5UFpi?=
 =?utf-8?B?Zk9LeFpHd1VDbk5nNkFsaW1SRmNCOXh0cnNnYndxUGxIWjg5cm1xRWhsUllS?=
 =?utf-8?B?OVBWM01oc2ExZG15QnJMd2UvUi9LQkdzcmdSd295Y2VnZCtuZU9Xa0hzYVZZ?=
 =?utf-8?B?dGtKM1JteFpDNmwvUndKZUUyVi9NTVFmZ2tvM3czc1RZS1M3SXgwdmkyNEZx?=
 =?utf-8?B?YVNGNlNIYVhIN1NiQWpEdnVKYnBLbnVpSGR1Qm4rSjBzU1ovTi9DT3hXTlUy?=
 =?utf-8?B?TXgrVDFWekZnNnhDRzIzVVZXNFRtV3lrUFhZb2dMeXMzc0pNWTNmRzRsYmlO?=
 =?utf-8?B?azA5SW9Wci95V3ZsdU5pMFZ2bnBlbE95ZDEzSFZMQ1Zyd0RrcW02MnRzQXp2?=
 =?utf-8?B?VFRwNkNpSGlkcDFhc1N6SExrZTlSQUN5RnN4TlVjb3habWtpYmhQZEdjcjRs?=
 =?utf-8?B?RWoyWTRORGNSSDhQOEJMbng3bzRLaVdMenNMdVFMeWhNeUdQZlV0bmh5bVRu?=
 =?utf-8?B?T1RtSW8wV2tucUdlZWQzaThiL21pMXdsQlpkRmJvYmFiVFpRTENET25tKzVG?=
 =?utf-8?B?d00wb205dXhPVFpqVExMTFNEYkhjV0J2ZVpFU3p0WFU1eVBxT3pHeitqd0dW?=
 =?utf-8?B?Z0xBOWRFbFN1bUpPY09LZ3hDMlArdlVZZlE3VmpZY0hsWnB2dVlEbTNkZitC?=
 =?utf-8?B?V3lXRzE0YUhJdncwQlZSejViT3VOc1FyU2g0N2YrSjk4Q2gxYWlKYmRGdmZJ?=
 =?utf-8?B?LzhCei8vZWljUEloc1pjYm5valFuVmV1TmczcE9DNzE2bVpuazdlc2F4NDhZ?=
 =?utf-8?B?MEFJdUgvRkxMWWpZODdLVXB4ZEUrakRJOW5Qbm9xVDAranp3eGRUeWVGS1F5?=
 =?utf-8?B?aUZpRmxEVzBTYUR6d1hSd09nKzFoc3dtVzFzU1g2aXhhSXdsTlE1Ukg4Ym9E?=
 =?utf-8?B?YWxKbXJCNmFNTEREdGhjRHdQZkNNUWQvdkVOeDdwN2duZzliS0FmUytxbUtP?=
 =?utf-8?B?QlZ1R0NGK1NxVzY5ZmtQYi9VM1pXRWRpQlRETWxWcmhkVHRYRklpekhKcCtV?=
 =?utf-8?B?WHZhSm1KZXQ3UDBDSzE4K253RWFUWDI3dVo4TnhXMGdBZGZiYXJUOXZGV0JR?=
 =?utf-8?B?ZHhiTmV4c2djQVhUd2VnVGYrTFhYeWx0dkdYTmxwWkYxWlkwZE10WERwYWhk?=
 =?utf-8?B?bmd1T0txa0doRzZYL2Y3eUNURWZCVnBtTE1Jc2tDVmFUWXNjU0tpcHMrWGlS?=
 =?utf-8?B?dUFzMjBPZHlmbEdkMitWN3N0bkE1aWFOY0U3ZE5ZeFRycDhxTkJPcmV5YmhS?=
 =?utf-8?B?d2Z2SHdSOGV2b1BCaFVnTEE3QVRJbjF2Qit2N3p3T25kMUNPbjczZUZOMmZx?=
 =?utf-8?B?bjBGaUVGLzFaQ29sOXhVUTN0eFQvTXZIYmlyZFprYVp3WHRZZE1udGt0eFVn?=
 =?utf-8?B?dFlGTlY1dW5pS0taMkhQckV0S2xJY2M1dG51Tk16eFpVZlBVVTNjVms2bE52?=
 =?utf-8?B?TmFqbXJOV1FwWXVtS2Y0OVE2cEk3V1pMVkRMajlGaGM0dHZqRi80RFFNcmkz?=
 =?utf-8?B?QzdzMVNLRW5iTUV4aHNYNUJVRlhNd1hQV3Yzb2Fiak1yVWxIVkFpUjFpcDQv?=
 =?utf-8?B?d3QxeWFqWGc5aWJ3d1FuNjhVenZ4RStzV0J1T0QyOEJqMTMwQldDRm84SmlP?=
 =?utf-8?B?NXIxemY0OGVzLzhXRDNNVDFib2tqYkF3YWpLQmNMd2UvelVlUG1ndnUraTk4?=
 =?utf-8?B?d1hra3lJcXZxeUJZMEpld2l1bmplYlVQb3prUVZJUURZelFta2Y3a3RjK0FW?=
 =?utf-8?B?MnhwbXJORFMrVlBYV1pGQ3pQQXBKRmF4amNWdHlVK2hZRDhtSDdDMjZVQUI0?=
 =?utf-8?B?V0VCVHZ5Y3lKYmo1M2Zhejd4aXJCRDQ0SnhBMVZtNmhCNlFqQ2Jad29WTlpm?=
 =?utf-8?B?ODF2QnlnT0RRZ1N1R041TTdVQ05rM0dDSWJoOVdHRXJGTmpvc3d0OWRzekxV?=
 =?utf-8?B?TGNid0hNRVRsbzg0Y3NmWThrdUJLNXVnUlptSWVxL3ZBYTJFcGVNekxlTXBp?=
 =?utf-8?Q?ddJYH+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFZvZ0E0LzFCZ0V4RU93Tm0raXg3cnNCYVFGZDE2SllYN3JJeEoydmpJRkNu?=
 =?utf-8?B?NjVHeWVCYUFJZVZWL2dFTEtwLzZJaWkrR3FoV1ZJSHoweERXNStDMCtpMEJB?=
 =?utf-8?B?eWQxNm5JMlNOVXdsTE9teG8xSm9GSm5XbUV6TWp5dVJMbEtmVU1la3VNNWdC?=
 =?utf-8?B?YWhvbmRNMTNFL3YyMUFIV3hoOC80YXdwQnFoRitYSDdjbU56SVFOeE5XN2FU?=
 =?utf-8?B?QTNoOG5FdmJLU0lQbzZGaHEraXF0TjhxRkVMY2YxTFVQcEozVDUrVTVVRVBa?=
 =?utf-8?B?TFFVWlhVK2UrSCsrbFY3TzRtajlxKzhZaW5YREJtR2ZYaWhyZU5Kc3NSWWYr?=
 =?utf-8?B?S0ZYSGlocXpheVVKYS9QK2hRYkhvK3FoZDVSVmdpQzNBWktzUWtUZC8vMkZ1?=
 =?utf-8?B?RW92UUtGdC9xSlBINDA3dHQ4Ujdid0hkS05XbzdHajdDOCtIRHlEcXNoR1pv?=
 =?utf-8?B?bzZHUVROV1RtaVNjQWFTVHJhODNLd0cxSUh0TndEVnZVWEJsUVhYNmFRMEJM?=
 =?utf-8?B?ZWVuTWhEQTFteHB2NHBpTDlyM2NDeWhLM1luVDRHdEtYT1N5UjdqM3NKL21C?=
 =?utf-8?B?dGVYb0lvdmRLSmpDeG02R3dMa2ZablJJNnBaZmd2S3lmZUFrZnNqMXNvRmI1?=
 =?utf-8?B?NW5hdHdDVHNmanViM3NZbE4vMkNnVGdZM0xpSjdHZkdoZ2pJcVowUmNhMjB5?=
 =?utf-8?B?WGpUVHdZeW1IVTk2STk1bXhudDVnVTFUbk5DTi84bWFCWkNaZWxYeDU5WWto?=
 =?utf-8?B?a2dqWUlFaktLci9XeW5MVDNVZEdBTEhabmFFSkErUXNJNDNKeVdiQzJHbDJY?=
 =?utf-8?B?WmkzMDYranAzdXY0bzVvaXlMa3RQWVdadFF4T0Z4SnJCSyszY29KcW9JQW90?=
 =?utf-8?B?YjJLQjZ4ZGRkMlpPcXFJaXp6MXAwa2NwMWRnaHFxcFRzU09nY3RFZ3pKY3ln?=
 =?utf-8?B?bkZDZm90bUUwYUlPdzl2U2NvMjB5WVB3L1FsVTJCQTlKaG1lVnZteGJGbGdX?=
 =?utf-8?B?a0hJSVpKV2ljUU0xdFBLdFJHcHZSalNFOUFJR3JHZjFsQWNBVUhlaEVUUk4v?=
 =?utf-8?B?TG5UYVYzM1Y5Z2hGalYybTFidHFaNlpDNGFiV2ZlQnlobVZNazNuYnZNYmtV?=
 =?utf-8?B?cEYvdG9EVG1TcVRnS0wvUDU1NzA1TFc2dDlhdUdVWnhCb25VNk1ENm1HOTlk?=
 =?utf-8?B?c3FFV1FQTitEZzBZbXVlTExlVU8zMUEzWHBFdWVYVVJheTN5ZUxVVnNjeVRY?=
 =?utf-8?B?bE9oNFNFVit4Yy83TURTR21aUmE5OE1xazM3RzlPdDZ4Y1ozaDJBYWVGZ3Zp?=
 =?utf-8?B?VXNqYkw1T0JZRzVnQm9PSDNJdEYrNHZvSTlRRFM4RW9mQVJ6NVVHVkxwRDZu?=
 =?utf-8?B?dFhzdUl0bVdTaWNMN0g3U2dCWVUwU2dUdnBDdUR2L05wVHNWQUl0REVtblRR?=
 =?utf-8?B?ZnUvaG5jUkFwSzBQd1RLVFg3SUw3Y0laUC9HTWd0bnZUQkNQK0tzRzlBelYz?=
 =?utf-8?B?UmZqR0N0WVpxSmRzcmZGMzYwbko2T3IzTzhmQkZiSjl3cDZzR0I0ZkN5dHph?=
 =?utf-8?B?OXF3Z0JyQXFnYi9MWVFUTXlpbnJJTzRkLytST1BBMVVIN2w2VTg3aGFleGRo?=
 =?utf-8?B?ZkwxQkFpQ1RxaDVmejJYVStqZVROMGlnaEhRZ3o4QkVsdlFVcG8xZ3A1cTFN?=
 =?utf-8?B?Nm1CM0FNWkhpZDd5czMxaWwxb2R4VitwTEgzQk4vK0lSYWVnYVFkaHM1OXR0?=
 =?utf-8?B?YVRXUlg4QmQxVmM2Rm1aM0tid2NZWllmOE5Zc0V1TXNkSjJqSGd1NXZkMDJI?=
 =?utf-8?B?bUdtNngxQ3ZVb2kyMW5CY2FvVXhjRTliU1gyaEt5bm5jNlNEY1FEc3lzQUpG?=
 =?utf-8?B?QUJHY1UybnVBVkJTMGZKZk5LYkFKNkZBSVVEbDFWUnVvdkdTUjgwT1Z5Q3dE?=
 =?utf-8?B?RlhsRnVjYlFNb2VnZkZyajBHYnI3ZlhZb21SWUR1UU1WN3kzdms0SHFORTZ0?=
 =?utf-8?B?L2UyMU5BUDNUNXdGaU01WGJqWlBLckc0di9pWVpnWk9CcGZ2YVJRN05yeDRH?=
 =?utf-8?B?YzdDQmhNcUZpRDJ5T2RFK21oRldNdGlNaGt6a1ExOHVaK0ZhQ1dtd055czVm?=
 =?utf-8?B?b0J2NmE4OWJxUEs2dUhiQVljM1lmV1lmeFVFKzlJNTlzWXAyeTZTYUVPZkJy?=
 =?utf-8?B?N0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: deb03820-7d8f-429b-74de-08de27cf4b83
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 00:54:01.3394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uIsxv1PYM76thtkhGwYFj3HL/MLV4CgTN6NAWhQfk+cCFmE8dM+z2GeumOZhepYoE6ww1aP5gBxr11CzXJQ1DIdPhENhXT3rJgW/E/e50hk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4723
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> CXL virtual hierarchy (VH) RAS handling for CXL Port devices will be added
> soon. This requires a notification mechanism for the AER driver to share
> the AER interrupt with the CXL driver. The notification will be used as an
> indication for the CXL drivers to handle and log the CXL RAS errors.
> 
> Note, 'CXL protocol error' terminology will refer to CXL VH and not
> CXL RCH errors unless specifically noted going forward.
> 
> Introduce a new file in the AER driver to handle the CXL protocol errors
> named pci/pcie/aer_cxl_vh.c.
> 
> Add a kfifo work queue to be used by the AER and CXL drivers. The AER
> driver will be the sole kfifo producer adding work and the cxl_core will be
> the sole kfifo consumer removing work. Add the boilerplate kfifo support.
> Encapsulate the kfifo, RW semaphore, and work pointer in a single structure.
> 
> Add CXL work queue handler registration functions in the AER driver. Export
> the functions allowing CXL driver to access. Implement registration
> functions for the CXL driver to assign or clear the work handler function.
> Synchronize accesses using the RW semaphore.
> 
> Introduce 'struct cxl_proto_err_work_data' to serve as the kfifo work data.
> This will contain a reference to the erring PCI device and the error
> severity. This will be used when the work is dequeued by the cxl_core driver.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
[..]
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index 2ef820563996..6b2c87d1b5b6 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -10,6 +10,7 @@
>  
>  #include <linux/errno.h>
>  #include <linux/types.h>
> +#include <linux/workqueue_types.h>

This is minor, but nothing in this header needs anything from
linux/workqueue_types.h.

I would just forward declare and be done, i.e.:

struct work_struct;
void cxl_register_proto_err_work(struct work_struct *work);

