Return-Path: <linux-pci+bounces-32433-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14ACAB093F9
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 20:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2907A470DD
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 18:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E06CA4B;
	Thu, 17 Jul 2025 18:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BNabQrlY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFE41F0992;
	Thu, 17 Jul 2025 18:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752777254; cv=fail; b=ooICEuoq1HsOYRG7gpq2vtrvk19JDbaQ+qep5YsWahezpvd1LKKE9r/pfy6+yEUiZUSHSo/R+Sw0KojpOM/eQnXghwKFDlP6zZhZv8ZDm8Q/wxtfZEvCV+r1b8nIvPFEgrVIVjSPB6zXiUed0cVqO4VDzWNDPq4t3NQOTrNFqmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752777254; c=relaxed/simple;
	bh=hFfdt0obhROOKqI9i6ZQYwzVbCGEFeLY9WWd4U86zyQ=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=o0l6D2NRh4BfR/1YWitPxWomRcWn8bbb6Q/uAsT+SjYLAUb/peBmWXrX9loIcmoqnRz86BoiSXGSNfrSw75lm8OB5ahXgryCQ0Jrr9lWcr4JsuGlngIafobkLVrsud6asZXiPcwGr2WvHb4WIOj2MtO89v30QY0HJUQ1+OmEYTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BNabQrlY; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752777252; x=1784313252;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=hFfdt0obhROOKqI9i6ZQYwzVbCGEFeLY9WWd4U86zyQ=;
  b=BNabQrlY0SGQ5xM3MtFke93uaS4su9PQk5C7/9hEnoh08FrUhiVgeu/V
   eLYvvULEBs4+10uApaEInksgw72YC/iL+tRTvFAfufV89R3OxB3uJI/j8
   2LKa37mr4Qj1+JRfbPtCLqDyuMTLhRPhRsPk9qpd6HqO4zWNd8I1F4/uI
   s975sZ6OnVdiz4T0uMgFpCuITzFOnl8zQKX3NqmwTwZcoIKGjUFqResGt
   7a4WSs0Ds8vPto3hNg49LA0GDwiwIIdwv4bO66JJBCtIEZjbzwm7Nprmj
   Sm0VxNxEFj1MwisC3RUaq4t1mIoHGtJCWyA4A4mmvVj1ebtrZWRyqXzRv
   w==;
X-CSE-ConnectionGUID: BDzSFhpeSquME7APAE+uwA==
X-CSE-MsgGUID: 0qy7A/V8TLKKTgD7JZYGEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="54945670"
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="54945670"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 11:34:12 -0700
X-CSE-ConnectionGUID: 4M7ywLwoRjKnmhObPBv4nA==
X-CSE-MsgGUID: QIe1viDrQESVBH8ttqbirg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="158222610"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 11:34:10 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 11:34:09 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 11:34:09 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.52)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 11:34:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yQI2HKFjxgi4bjj/gTkTKvHpx+DGjaZ949ChF6+2shX1GeExMDhtBf5A38tSjrJJ2RVLCi2qiZP9mYr7gUmycQAuwaWPQUN7xzh2kgWFmBJvsiz4V/9SktYtuFnlj0MK5y0U6kyanhQsjIN2HDoHmocq6BDxSuI6XtpWLLRh39oSaYZD9zaOCOhl89T+HpOsXrjrxdWSsijVHQAQ4L8gFkzBbXYKpZm8yYigNl1H2FmS6N05Jl7pXLbwpFob/h1Ih2upHWEcENitZ9+GiSmRwDTHCCUg8GEuc1ZG0zti/TiQprXTFRt/Fjy+wU5uFVaFGjhg0Wz/syjO/lVgJ0PvKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vblZYofOPE+KnTIQwpqMbvB8U/IE8WZxJhlvzMubuww=;
 b=YsKlHwRDlVYqcx78WvQHSnoPOaqO//gg1Y7Dku6Fihrj1QTAdduB24FF0wPf18yKki86yiDoLjgVs0SrPnEKQSuDSSHTlLKt4r8G0qJAGirI8vZYJ9T8C+UCYU2f3uiTCCz5ZUaDvKw+e5rnL7U0TEhr56gSM29mipLW0EMvo9CNb9ZZH9AZh6vdg1Jkgq0yN5a5obO5spKgP4EyJRs50ilZg0WyRH0k/4DD2NrzzyF5JVG6fHPB07ZSw7tnVttyYl2gZqRhrzMn7gfnoDHPmO/HKYkfwXednVvr0LrA+ftGOWl2uLauDjiD2xBtf9aVQ6cWk3csfE3e5W6k3ipJlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7066.namprd11.prod.outlook.com (2603:10b6:806:299::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Thu, 17 Jul
 2025 18:34:02 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8922.028; Thu, 17 Jul 2025
 18:34:02 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>, <aik@amd.com>,
	<lukas@wunner.de>, Aneesh Kumar K.V <aneesh.kumar@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, "Isaku
 Yamahata" <isaku.yamahata@intel.com>, John Allen <john.allen@amd.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Samuel Ortiz
	<sameo@rivosinc.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>, Xu Yi lun
	<yilun.xu@linux.intel.com>, Yilun Xu <yilun.xu@intel.com>
Subject: [PATCH v4 00/10] PCI/TSM: Core infrastructure for PCI device security (TDISP)
Date: Thu, 17 Jul 2025 11:33:48 -0700
Message-ID: <20250717183358.1332417-1-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR21CA0030.namprd21.prod.outlook.com
 (2603:10b6:a03:114::40) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB7066:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f051278-7f3c-460f-5f25-08ddc560806b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UXUxeUJlSzBkVStNUHkwMUpHRjgzamZQWndvaGt3MHRGOHQvN1FhWTE3VXk2?=
 =?utf-8?B?TWpHWWJRem5UOGFIczNOTEdCTnkrMU9ucUdXUHppQXBBdUc4NEQ3Rm5SSVJk?=
 =?utf-8?B?R3dyWmV1aGhucks1WXp4M05wZ1BRdWRYRjZaRkJ3NHFibXVCMWFrUkNJRHFY?=
 =?utf-8?B?R0FSaE5EdHptL3hlU3RZbXFVdzk2Z0pwaXBJb1gybS8vZU82OHN4RVFZWTB6?=
 =?utf-8?B?anJRbTNiZE41MFhHaDUyV0t3ZEpjUTdMaXJGZ3JMNVhqWEIyMFdPL1BtNk1r?=
 =?utf-8?B?WUF2T1h3S2R0eW5ZUEdmK1pyY0dCTEVUM1N4UkFRQ0dGZk9yd3N0em1rUy9L?=
 =?utf-8?B?R1lWTGJjN2Nrc0FqQ3g0RTRndlNkNkg1ME12cnp0WW81bWUzWWl3akZ6SHZ0?=
 =?utf-8?B?S21WbWR5UTZoV1pQa2FJL2NNR3R6TURPbE5uUjhpeW52bFRibllDQTZjZlcx?=
 =?utf-8?B?R1BCc1ZvakttWWd4OTJaTnh4dU1jUU0vc2tzeTVuRkZqSjZjR3p2Z0ozSUlI?=
 =?utf-8?B?dkZCZzBEVGVnSUFqU1Z5enJ0bk9YZCs2V1kxbFRhVDVGT3lBc1NkUjZNWlQ0?=
 =?utf-8?B?NStCdzl2SWtSR2NZQWpjSXBxZHZ2TVFvMTdNZUxObFNiUEJPaTdqczlhV0Q4?=
 =?utf-8?B?Tzg3UTZWaGN6VnBQUG5WTk1PRGkvVkc5OWVMVVh4bEJucW5iRWxudFlFZWZh?=
 =?utf-8?B?Zmd4WWRsdWI2VS9PdjcycTRjSkJFTE5EZW94THZ4czFCNVJxNVNWTEcyU3dD?=
 =?utf-8?B?WEhTN3Z3b01yZW5LcHMrZE5Mb3M2c215dVRoQTZ2WktjMEFNQjJBU0J1VW42?=
 =?utf-8?B?dVJYMXhrUDJhaFUrUHBTcEl6SlRsUjFlRlRTbFFnVWo1SlhIZnYwa3hyUEFS?=
 =?utf-8?B?YjE0MHZpQ0k4UGRhNkNvT3pYYkREaXE3RVVyc09NUkdodXFrVytEMEVGU09w?=
 =?utf-8?B?TVlLdU1zSVYxdC9YQ3pCM0RCYlNQVitOOTJHa2JieXdRNFBVdG9Mam5hK2tr?=
 =?utf-8?B?NGNtT295c0NScHB3OVBVZjRLaUQrN0xKMHA1ajFHQzkweTNKdmR6aXo4Yyto?=
 =?utf-8?B?VWxGT3p5UHZCeWtjUEZoV2JBNiswY2dXTVltL3o3b2JCRUpVMGl5a3hNU2g0?=
 =?utf-8?B?cHZpazRZNnhreFJGdkw4V3BLd1I4MzI4eXFXWFYyaHNpZTA5WFVUQ2E2Z0lH?=
 =?utf-8?B?VFM1YitncVNPeGdxdU0ySG8rSGRmeS9rRDE5dEVIQ0dGSEg3eXBXQmNrbHdD?=
 =?utf-8?B?alY1QlhKMmxsSWR3MVU0MUVNcVNTQXl3cnF3ZXgyN1dVaVFsdHl0UkVqVVc2?=
 =?utf-8?B?K0E0YnNPcWJLNzdYWkZIU2hadVExSWJLd2JFSGp0ZlJGelJub3JZSm1DN3lw?=
 =?utf-8?B?bkIxSCt3MEdrY1EveTVDck4rZ2l1QkRiSXVKU05raFNJbTRJMEJraDloSWJO?=
 =?utf-8?B?R2hyNFJHOHlmRmF1bk9ISWdsUDk4bytPbXYrU1JIN2ZCOHpuT3ZoTUdsc2U5?=
 =?utf-8?B?ZzBneXVJbVA4Y1ZIbzdrVG10MzN3dVh0RzA2NTJwdjZQNjZvZnNQdTQ2RHh4?=
 =?utf-8?B?T3dmYk14dlE1QVRxTkJOdVdBUTJrTW9xNjRDTDVlMWJhR1AxR1hocEpQMDRR?=
 =?utf-8?B?SHUxSXhON1hGZFZJODJRL05yZUpQc0Q0MHdrYVdvNEhkeTVlaXhJRmhFcjlN?=
 =?utf-8?B?S0VEdElQN29uWXFTaEFFZFZ2NjRycm5NZEZCWlkvYWZOMnVFd0RHQ0U2SUdI?=
 =?utf-8?B?K1RqcnRobjRmZk5mK1Y1d2trenJiaGJYNWtGdENEUU9KMDRFUTJIVkVja3Z4?=
 =?utf-8?B?aElkYVJWcEFmeWh3ZDN3c09JamxheUU3a0lBTy9oKytwTnNGejltQ3l5ajV5?=
 =?utf-8?B?bG5Mek1BR1QwMVllRFFFcGFmbVlQV3F0b2d1eWo0Sk1VbG9ZY0t6b3NtTk1s?=
 =?utf-8?Q?uS7vLLRuAnQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXczYnBrNGRyeCszTTJBYUFWakQ2ZWNmSnF3R3ZLTWRmRkNIK2R6N3JXNHR6?=
 =?utf-8?B?azhLVFJTWjNXclo4R1lrTmpGWStlNEQ3dHJ0VUM0L21mMUY3cEtWbFZkSTQ1?=
 =?utf-8?B?Y0dqV0dyWmg4ZFFmU2tyM3NpOUQ2OW5ZU1RXeGl1ZDlrSkF0emhXeUZRbmtm?=
 =?utf-8?B?QkV3N1RvQUVlVlkwa1lPcXkraVBTZkFlZExJR00xN2dMUGdkOGpaWnJuNnFF?=
 =?utf-8?B?cCtSVjdmaGpsRWhNMEJXSkswdUFQWG5Hb1NwSStaalNMNTUvTlVFMS9nc3du?=
 =?utf-8?B?anZsOVZteHd2ejdyZFZsOE9DNUJCK0VITDhveHJNSTI0Yk9NWUVZVFJFVHlF?=
 =?utf-8?B?WW16bzJ2VHpybVRTRDZwV2h0ZThHOEk3UThweTNvSUxBRzZsdUxMT3JBbGZt?=
 =?utf-8?B?dDcvZ2FFZ0J3Q2dPTExTMnJzZXZYVlYrb3MxNWxDRGRpQ3pPc29BbWQreGVx?=
 =?utf-8?B?R0w1ZWtTZS9DYU1EMDJFMlExZE0rMFkxampIdzEzcG52ekRSMUErVXV4WENr?=
 =?utf-8?B?QXFlYncxcmJoOGZ0aExlMWdUM1RUNjNWS3lVOWp0YmFVMW9sVURMR2FqZmZ6?=
 =?utf-8?B?dFhHSXhLcXBTTHZjUTdQL1lvY21uSU9RUmdxREtGNDRSK05yaDB3RHVTVWJR?=
 =?utf-8?B?NkRNZXRRQ3VwVklubm55MHd0dGhibGd6MHFRaTFWM2NVMjFYUUlzWE5CWWRu?=
 =?utf-8?B?aGNiVXVWU2dXVEI5alhqdGcycGR6b29OWjhPa2RLeS92MlAyZW5BUy9oSUE3?=
 =?utf-8?B?bVFFSllJWVN4Sm1ZQlg0Nk81QmJXdFhwRGZoOFNzTnV5Y2wzRmxycjNiOE56?=
 =?utf-8?B?eUxDTEVDNmJOTkJsT1lWZVRiODBWV2NpMU44R29MendJVGpaa0xhVXRjdUJE?=
 =?utf-8?B?V0kwQ1loRzFhS0VZQjV6NGYvK3QyUGV5S0NkWG9xdy9ZdlhEcW0yWHZCVHlZ?=
 =?utf-8?B?R2d1dFhkV0xHZE9CQW1TenYrdldGVm1tVGpTTUJFaFV2R2pFaUZhQithSXJT?=
 =?utf-8?B?QURvYVJrVEg2RzVMS1VhbnFUNnBFQWpydEFHUG13Ny8xT3Izb0NlSjZDVGlo?=
 =?utf-8?B?emFtdUIvOWtTbmZVZGlxTVJXYzUxbDlqUEgyTDF4MzFaSmZPK29TSXdJNnpk?=
 =?utf-8?B?VUovOWlzMm9UNG5BWFlVbUY1K0R1NFpIcWdkWlQ1SzdicGhVTWU2VVlUcEY2?=
 =?utf-8?B?T0tuTFhmMXgwSnoyS3hua2NIOGNnVmRHKzRDSkZ0eUp0UVMrVjl0WHJnTmJa?=
 =?utf-8?B?TWxtQTlaOTYvZC85MzRBdDJDNzZXMitrdnJZeDQwVlZ0U0VqRUh4c3p3YUt6?=
 =?utf-8?B?TU5IT2JwUXNvUkdSVUlNZWRNYW81Ky82SXdZZm9JVUdyUjB3MHNQd1lXT2xx?=
 =?utf-8?B?WmVKOVBrL3B3NjN3QmRsYThEWkh5emtkcEJrd1Z1NW9XY2g0enE5QjZXYkEy?=
 =?utf-8?B?dkcrWDBLa3A3aGIvVWJnSWF0OGpWNVpPN0VxTTJER3l3d3RubnhreHB2ZWk1?=
 =?utf-8?B?cm85SjZwbU1jaFd2NEc4U21XWS83ZGFBeWNRR3Z0eXJCLzFzTDlMbzlQc0xE?=
 =?utf-8?B?VCtXWUJIdFJIcmlvSTI3NSs5bEZBanJGeWJjei96dUpjbTJBV2dhcXVnRHNv?=
 =?utf-8?B?WGRvQVdPMDdITTlKaDVySDRUUnRZM1NFYnRCazFUc0ZlMTdLRGFmZDZ0cGh6?=
 =?utf-8?B?V3pZVEpSMzJCT3FRRjhpemdhdjRlZktvc0IvMkl1WUkzZitVcnFjTUg0WXBv?=
 =?utf-8?B?V3hMR0RkbUl2b05PSkR5L1J6OHZrMm4wNW5UbEpTcFFCdjFSRDRvNEx1OFVu?=
 =?utf-8?B?WWJ4UUJDakNsY2ZtazBsZzhxNThGYUVPSElBQzdjUllkajNqdldjN2pxRkE0?=
 =?utf-8?B?U1BoVVF4Q0ZTR0RLZnNVWkhNbkx1RkZvbVJUWThZcFpWZkFIZmozYllNay93?=
 =?utf-8?B?RmtEdUo1dTczc0ZEcTVtLzdVa3dobTh3VGFsUHY0MDlwTVdaTGM5NitRY3ZX?=
 =?utf-8?B?K2hycmdEZVNaR2RmU2NLMGJuRjlpZnZTUnBKVW13NlFWS1pCemFPVlVaYXBj?=
 =?utf-8?B?aG91QkZQNmJsL3RXUlptOW1MdFBWTGNhVW5tUE9wbWxCYjVlb1BvTFBUWGh6?=
 =?utf-8?B?cTQra2xadmpUbFB6SUlzaXdUZ3R0ay9jd0xTL2pXMzUrdVhsUHZURW84NVRK?=
 =?utf-8?B?Wnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f051278-7f3c-460f-5f25-08ddc560806b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 18:34:02.0822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MFJ6DbvkDNGXcEoBiX4wahr0jm2whC6i/DAfZjD1nmF+NL9TJCF7qC3y/5ioGJUol2KvRQWivCOIjgXgKGFRTKKyv9VM5SmjS3s8Sane/3s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7066
X-OriginatorOrg: intel.com

Changes since v3 [1]:
- Move the TSM core out of the host/ subdirectory since it is shared
  with the guest (Aneesh)
- Support multiple simultaneous TSM providers (Jason, Alexey)
- Do not reuse the "connect" operation for both Link and Security state
  management (Aneesh, Alexey)
- Derive the pci_tsm instance type from details in the @pdev or @dsm
  properties (Aneesh)
- Delay TSM association until ->connect(), results in removing the need
  for the @state attribute
- Introduce reverse iterators for all PCI bus and function walking.
- Move all per-device context setup/teardown to
  pci_tsm_(constructor,destructor)
- Add pci_ide_stream_release() for scope-based cleanup of IDE setup
- Shorten the name of the "stream" sysfs link (Jonathan)
- misc fixups (Jonathan)
- Note creation of pci_host_bridge_type in changelog (Jonathan)
- Drop now unused PREP_PCI_IDE_SEL_ADDR1() and related macros (Jonathan)
- Open code PREP_PCI_IDE_SEL_RID_2 in its only caller (Jonathan)
- Clarify the specification Stream term from a Linux "stream" object
  (Jonathan)
- Convert samples/devsec/ to faux device (Jonathan)
- Drop Date: from ABI entries
- Add basic driver-api documentation to build kdoc
- Switch to ACQUIRE()
- Add an explicit 'disconnect' attribute
- Clarify the PCI_IDE_STREAM_MAX Kconfig help (Jonathan)
- Use unsigned variables from sel_ide_offset (Jonathan)

[1]: http://lore.kernel.org/20250516054732.2055093-1-dan.j.williams@intel.com

This set is available at tsm.git#staging (rebasing branch) or
tsm.git#devsec-20250717 (immutable tag). It passes a basic that
exercises load/unload of the samples/devsec/ modules and
connect/disconnect of the emulated device.

Status (complexity reductions):
-------------------------------

Between the support for multiple TSMs, the split of "Link" and
"Security" operations and inferring the type of 'struct pci_tsm' context
from its properties, the implementation shed complexity.

Now, ->probe() is only called in the sysfs::connect_store() path which
means that there is no need to track the PCI_TSM_INIT and
PCI_TSM_CONNECT states. Simply, when a Device Security Manager (DSM) is
connected, at that point all potential TDIs (assignable functions where
the DSM can manage its security state) are probed.

Now, initial determination of when the "tsm/" sysfs group appears
follows typical expectations. If at least one TSM device has been
registered prior to a DSM device being scanned, its "tsm/" attribute
group will appear. No more need for a pci_tsm_init() call via
pci_init_capabilities().

The pci_tsm_destroy() path is now simply arranging for
pci_tsm_disconnect() of all DSMs after all TDIs have gone through
->remove() callback. This is accomplished with new "reverse" iterators
for all PCI bus walks.

Next steps:
-----------
The campaign to graduate this out of tsm.git#staging and into mainline
starts in earnest when samples/devsec/ + 1 vendor implementation, or 2
vendor implementations can demonstrate the end-to-end flow (minus
attestation). That is the "consensus" event horizon where prior to that
it seems reasonable for impacted subsystem maintainers to opt-out of
reviewing all the fine details under debate. Suffice to say there are a
lot of fine details flying around.

To that end I expect it would help to have a tracking document in
tsm.git#staging that catalogs the open debates and the current leanings
of the staging tree. That is next in the hopper.

Original Cover letter:
----------------------

Trusted execution environment (TEE) Device Interface Security Protocol
(TDISP) is a chapter name in the PCI specification. It describes an
alphabet soup of mechanisms, SPDM, CMA, IDE, TSM/DSM, that system
software uses to establish trust in a device and assign it to a
confidential virtual machine (CVM). It is protocol for dynamically
extending the trusted computing boundary (TCB) of a CVM with a PCI
device interface that can issue DMA to CVM private memory.

The acronym soup problem is enhanced by every major platform vendor
having distinct TEE Security Manager (TSM) API implementations /
capabilities, and to a lesser extent, every potential endpoint Device
Security Manager (DSM) having its own idiosyncratic behaviors around
TDISP state transitions.

Despite all that opportunity for differentiation, there is a significant
portion of the implementation that is cross-vendor common. However, it
is difficult to develop, debate, test and settle all those pieces absent
a low level TSM driver implementation to pull it all together.

The proposal, of which this set is the first phase, is incrementally
develop the shared infrastructure on top of a sample TSM driver
implementation to enable clean vendor agnostic discussions about the
commons. "samples/devsec/" is meant to be: just enough emulation to
exercise all the core infrastructure, a reference implementation, and a
simple unit test. The sample also enables coordination with the native
PCI device security effort [2].

[2]: http://lore.kernel.org/cover.1719771133.git.lukas@wunner.de

Dan Williams (10):
  coco/tsm: Introduce a core device for TEE Security Managers
  PCI/IDE: Enumerate Selective Stream IDE capabilities
  PCI: Introduce pci_walk_bus_reverse(), for_each_pci_dev_reverse()
  PCI/TSM: Authenticate devices via platform TSM
  samples/devsec: Introduce a PCI device-security bus + endpoint sample
  PCI: Add PCIe Device 3 Extended Capability enumeration
  PCI/IDE: Add IDE establishment helpers
  PCI/IDE: Report available IDE streams
  PCI/TSM: Report active IDE streams
  samples/devsec: Add sample IDE establishment

 Documentation/ABI/testing/sysfs-bus-pci       |  51 ++
 Documentation/ABI/testing/sysfs-class-tsm     |  19 +
 .../ABI/testing/sysfs-devices-pci-host-bridge |  29 +
 Documentation/driver-api/pci/index.rst        |   1 +
 Documentation/driver-api/pci/tsm.rst          |  12 +
 MAINTAINERS                                   |   7 +-
 drivers/base/bus.c                            |  38 +
 drivers/pci/Kconfig                           |  28 +
 drivers/pci/Makefile                          |   2 +
 drivers/pci/bus.c                             |  37 +
 drivers/pci/ide.c                             | 578 ++++++++++++++
 drivers/pci/pci-sysfs.c                       |   4 +
 drivers/pci/pci.h                             |  17 +
 drivers/pci/probe.c                           |  25 +-
 drivers/pci/remove.c                          |   3 +
 drivers/pci/search.c                          |  63 +-
 drivers/pci/tsm.c                             | 554 ++++++++++++++
 drivers/virt/coco/Kconfig                     |   3 +
 drivers/virt/coco/Makefile                    |   2 +
 drivers/virt/coco/tsm-core.c                  | 198 +++++
 include/linux/device/bus.h                    |   3 +
 include/linux/pci-ide.h                       |  72 ++
 include/linux/pci-tsm.h                       | 158 ++++
 include/linux/pci.h                           |  36 +
 include/linux/tsm.h                           |  15 +
 include/uapi/linux/pci_regs.h                 |  89 +++
 samples/Kconfig                               |  16 +
 samples/Makefile                              |   1 +
 samples/devsec/Makefile                       |  10 +
 samples/devsec/bus.c                          | 711 ++++++++++++++++++
 samples/devsec/common.c                       |  26 +
 samples/devsec/devsec.h                       |  40 +
 samples/devsec/tsm.c                          | 241 ++++++
 33 files changed, 3078 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-tsm
 create mode 100644 Documentation/driver-api/pci/tsm.rst
 create mode 100644 drivers/pci/ide.c
 create mode 100644 drivers/pci/tsm.c
 create mode 100644 drivers/virt/coco/tsm-core.c
 create mode 100644 include/linux/pci-ide.h
 create mode 100644 include/linux/pci-tsm.h
 create mode 100644 samples/devsec/Makefile
 create mode 100644 samples/devsec/bus.c
 create mode 100644 samples/devsec/common.c
 create mode 100644 samples/devsec/devsec.h
 create mode 100644 samples/devsec/tsm.c


base-commit: df877487cac3509cbae2625181e7ad6748afed24
-- 
2.50.1


