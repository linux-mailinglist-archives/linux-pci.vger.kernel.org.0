Return-Path: <linux-pci+bounces-25034-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB935A773CF
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 07:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6793516B6F5
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 05:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F421684B0;
	Tue,  1 Apr 2025 05:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZPPya6AJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4406117588;
	Tue,  1 Apr 2025 05:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743484833; cv=fail; b=XLS+2Hkax3EmJ+tq4tviMDMA6ZsDP43/2LlQ1t21+irMnfxXjuMFUuJMIgbBEOzzuEh2Ne0E9T4VGsKGErhZE6BiYO6XAo6BjpzGqerfLeCtoNM2GkT5lM6GtJcl40APy5LtRpyHYMjUcExid64AkT2olR/jNa1/keSkI+us+rA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743484833; c=relaxed/simple;
	bh=hJh31O4AcRAhT92kye5ygTZUQqM7lyZ0Hc9Qm97scBM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eEGeGUHQU0LA2E+pmG1T6Ysw2W4r3yAb7scUXqp3RzSvor6IzJTG/ICBEUnZB7v0Hl1sOFlk2qDJwh9HBRM7/QlWu56J7JtzNKFqHrLtXAhwr8VyIjKhg886YxcBhd3Wmc5o4BJKCLwB2NzHMvn7ah5Zksj2s5Ug/snnRkPJr88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZPPya6AJ; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743484831; x=1775020831;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hJh31O4AcRAhT92kye5ygTZUQqM7lyZ0Hc9Qm97scBM=;
  b=ZPPya6AJ9rM72mSNMzf7sSs7TW82bd8qruxRlak8dBLVt0AQJh8tAGXE
   Un7gh/g+8NVrroRs5F/dgW01EPSR4WEPNV6tyNO8dTBEPSfvmTq8HGAfT
   iKom78Ak6MtNgml11rz8F1qKjkFL/ail4Yqm5ZksM8IiP1Xvigy+PPBa8
   se9kxnNWzVPeIWplfoQmaPUx5csaMwb69hoiNJbcsYvLT8ZPgbT7lFTYW
   LU+kPN1UVXOeLnH2bxaQsFKv8HtJhkOk5cAyEahib5Mz9uoyW+YFlImUT
   ysLdQDYFScRftCwYJHbZo8s3+p1xPloJXfBf8h/Lm4/hCxLsOLC/w//O/
   w==;
X-CSE-ConnectionGUID: WHA1GyqhR7G/bNwnLcCmEQ==
X-CSE-MsgGUID: Wd83smveT4edQDnvoOimuQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11390"; a="48455883"
X-IronPort-AV: E=Sophos;i="6.14,292,1736841600"; 
   d="scan'208";a="48455883"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2025 22:20:30 -0700
X-CSE-ConnectionGUID: eYQf1KLjTlC0djF4sVveew==
X-CSE-MsgGUID: YQwjD144SwW51J1fz9kizg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,292,1736841600"; 
   d="scan'208";a="130994416"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2025 22:20:30 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 31 Mar 2025 22:20:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 31 Mar 2025 22:20:29 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 31 Mar 2025 22:20:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P8zgMOKD/jdlGO1xmKC1DMd59asn39qhvrSsw3yAVXJxkeG0e5+4M3brVtuIeD5uNgbVWpVCtoH6Y/TftVar9aOLZrS3syB8kYYaTNhe69LDu9JQm/SsWQ02GXKbiXJLQSF5h4ibxm3SdTgfDIK3gX7Cq7Vi1isLRIVID/mosFl/ze3kBCUe6aTkJ0sMyldKUGlD1ZCG+UASdmkODbRyAf5IrzgcHfEtEYGVbCDjsbxoCupAcPRbwP3SiJkE2Vn9zPOA7H57SUfEQrmmjTcE7vUJXBFQcu5qkbgiPiTs/y2OE/dRri0/NSm6cArf3xdM5EJH1sb7bnDEuHJnsoEWpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0dImPhJgnAYm17hWuGFXntm+a7p+KvkATE7zszr9I+k=;
 b=mLbnvT+QHd359wiObylxb0QvTXYa3j4tyNBjD8aKfIsNBU61VsiaTZyomRKevb3fPuM09U1m4LsRsutPju0YDACCxA5SuYMP4z97gbT5cSvx2D5PCz4FxEr74XBjn1mySL8Foj4uPut6RvE6quewa7s/rD6dGjPCS3GaE23tf6Af+dZbLo12z+ELB1aUX9eWveqFe/Je4vSnFShSEBdimXSFtKMakjg6iwzi3q9aQeWNq5Uu0Kn47OTDLKsLCVSfmSai5ci6NhEyudG/EhskLliEJMjIxt/R8ByNPlu8E5AuO5STmBtSbFD0aPNMFyxYbUAbrCPOkcwXdyP7Q1124w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5703.namprd11.prod.outlook.com (2603:10b6:8:22::5) by
 DS0PR11MB8764.namprd11.prod.outlook.com (2603:10b6:8:192::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.44; Tue, 1 Apr 2025 05:19:47 +0000
Received: from DM8PR11MB5703.namprd11.prod.outlook.com
 ([fe80::f734:e507:3083:e454]) by DM8PR11MB5703.namprd11.prod.outlook.com
 ([fe80::f734:e507:3083:e454%4]) with mapi id 15.20.8534.043; Tue, 1 Apr 2025
 05:19:46 +0000
Message-ID: <f3dbbd0a-adc7-426c-b476-e66059ae601c@intel.com>
Date: Tue, 1 Apr 2025 10:49:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC,6/6] drm/xe/vrsr: Enable VRSR
Content-Language: en-GB
To: Anshuman Gupta <anshuman.gupta@intel.com>,
	<intel-xe@lists.freedesktop.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
CC: <rafael@kernel.org>, <lenb@kernel.org>, <bhelgaas@google.com>,
	<ilpo.jarvinen@linux.intel.com>, <lucas.demarchi@intel.com>,
	<rodrigo.vivi@intel.com>, <badal.nilawar@intel.com>, <kam.nasim@intel.com>
References: <20250224164849.3746751-7-anshuman.gupta@intel.com>
From: "Poosa, Karthik" <karthik.poosa@intel.com>
In-Reply-To: <20250224164849.3746751-7-anshuman.gupta@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0054.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::6) To DM8PR11MB5703.namprd11.prod.outlook.com
 (2603:10b6:8:22::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR11MB5703:EE_|DS0PR11MB8764:EE_
X-MS-Office365-Filtering-Correlation-Id: 3af5443a-050b-4876-7314-08dd70dcd13a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L3BoQ2N5MzRDbUpBMEhZeXl6NUxLN2piR3RYZ2ppYVRuRWZJaHlVWWJnZWdV?=
 =?utf-8?B?T0RnMEV1NGpYb0RCcHNYK1ErZklSNWpDU29HUDN0bnl0a2swZ2ZtZ2puajdl?=
 =?utf-8?B?QTBBWU1EcjZWZlpYRWlHNUtRaG52RmR0MWJ4TENrUHI0V2pUZUI1UnVvbFZs?=
 =?utf-8?B?czBEdkdxbHd3bDZ2UVFFTkNQa3h1RXovemNhWFNkS0l2bnlQZC8vNEh1aUF2?=
 =?utf-8?B?YlJRNm1ubW9Ta0g2ZjNyU0plRUdzNVZFYTRvaTUyYmRLOGY1OVQ0bkRiaita?=
 =?utf-8?B?WFVXbWNlcU55TSsyT0xjNDdkNjdaMTZMZzN2ekNKNkZWenZSSHRxeDJEYXVO?=
 =?utf-8?B?N3NuWlFRaEJTUFZ4MGU3MndGajhMdW15T0JQdmh1dHZPWFg4dFBkS2tucGt6?=
 =?utf-8?B?d21ZbzVvSzh0ZFVIQVRYMjdZVzhFOFBqck4xcW51SDk4S2hlTitCcXBBSGVs?=
 =?utf-8?B?MjlQdTJIMDNMeis1S3ZYR2NOcDFyZVdYUmgxT2ZSZlZXdE5lR3lGUEZrM0NY?=
 =?utf-8?B?UnI5V2FOaWE1ZVE1Z3JoSG4vdWt6VzdIcjd4ZzVSSjh0NXJnU1RCVllUWUtj?=
 =?utf-8?B?SDJWRUw4WHhJcndnRENlVVljU1k3Y2FWeXRnaWdIenVDRFRQTklGQUtFVHF6?=
 =?utf-8?B?RmlUaDJsRHQvNkRKNkgwNnROSStEQ1RoMWt3enNCdlk4aTgxTTJoRlVhUDR3?=
 =?utf-8?B?emhIay9LL1Z1aWQxMTFrN0ZQbHFtTGtDSjBybnNZYmxpN1ptUDZMS0RnWmth?=
 =?utf-8?B?KzJDNzBobmJTN00zejErS051elBHZkxrN045QzUyMFdMSVltcEdUMUhJeGly?=
 =?utf-8?B?Ry8ySnJPZ0tONnErbWhsZzlFMHVqWDhJOE5lTTlwZU9KbjJhVDZJRG11U3cz?=
 =?utf-8?B?aWVUYUc4bklqS0ZNd3NYaiswUXZFSG5uazZIblQ5SUNuQnoxbDdqNEtEWDJl?=
 =?utf-8?B?dkJZbUZSaktDbTByTDlwVnhvUjA2eG1VVEJscmpDdHVQS1dUSVNWNVI1MWFs?=
 =?utf-8?B?aks3UnhzVjVMV2NSODZualNKT3NlZ1BHalBiNlRpSURJRVBuakx0K0RTWTZq?=
 =?utf-8?B?ZmlXOThUeGw4M1lLcHAyQnVISXdFbHRUczhkQVhzV2V0b2JQUnBXODlzSzJW?=
 =?utf-8?B?TXFtTlFNQVRIVWljRUMvRGxGRjFzcGR0RXRzdG02T0Vhd1JXNnFLeVFyYisw?=
 =?utf-8?B?dFRFT0xkamp0Ky9xOUFxNk1uN2JqQVdLcVdOeW1EOGxOSS9tWnlQRWVEYkpS?=
 =?utf-8?B?RjZ4VWJ2ZFpaeWZBWlVwaGh6UnpoaWJwaHh6NWpxQ0FycW5yQWVBWGh1bUpQ?=
 =?utf-8?B?TzBnaHFkVUNZVEhxazkvazkwNDRKdkNvTWd4SUc1aGZJU1hWUXZ5dHdLVzdt?=
 =?utf-8?B?Y1M0TTZaRGhsTDByTHFiZ2FWYW1FL0VVc09lZExGcWs3ZXIrMDhjVmt0QUlK?=
 =?utf-8?B?enN2dlpNSVpIWm5SaTdwdjZQMytLMFgzeG9yU052dE4vNGprNUNsQzVzZjBu?=
 =?utf-8?B?Y2s2RWhqQTRYdWs1WkRYc3BZMVJWbTlNRWdsTHFlZHRlRXFSaVFqeVF5aUhL?=
 =?utf-8?B?VTkrei8zTnhYKzJwalJUaUlFMTh2OTNjNUhadjVOajFsblUzSm82Z0hteW5F?=
 =?utf-8?B?UjQxc0p2d01rbnBpNzBlOFNENGRPbXFBVWMrcjRaNWRtWHdRcFgyU1lhd0pT?=
 =?utf-8?B?S3RLNEpIQUNYNGU0c1dYY1lweUpRM0hGbWtqbnpmUFoyZzNyUUpMb1RHRVl0?=
 =?utf-8?B?OThKclFlbWtCNlRST2VqNjIyUlJUa0t6Y0xxOFgwbFVpQ0VrcUN5RDQ5TXhB?=
 =?utf-8?B?RStna0RIQkpsbVlrbkd3YTJuaTBQNm5SQTA4cUV1cGtPb2tBalZicWFWbHF1?=
 =?utf-8?Q?7fBA8SfI+6yp0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5703.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWdJeDFMdmtDR00rcTQvUkVFbkR3V1o5eUo4WkU0a2IxWi9md3Nob1RNWTJm?=
 =?utf-8?B?dDhFOGxKdkpYYXBZbFBiTUIzcWZpY2JxWHB3MlZYdGcxdXh1dU1JSWducE12?=
 =?utf-8?B?UUJWa3BhMDZBWXZjdGdBanNtaC92SGJmcE1mdW9GQUJycmdhR2x3ZlcvYWkw?=
 =?utf-8?B?NVBGL3pwSFdhYkswWFRGMFhXV3lEOTVIaXFyK1czNThkd1RFR2xKQ28wV01i?=
 =?utf-8?B?UGF2Rko5UFpLaXBVeS9PeWZWZGdaV3VDcWtwZEpMcFgzWGdMNGtndk9xcnVQ?=
 =?utf-8?B?cytZVEFtdW9qMDBneWxWRWV6dmNvR2FlSjlnaDlxb1dLNk5kWGdIVGRGM2g3?=
 =?utf-8?B?bXlZWStiS0ZLRzBPUk44ZHpteWZHQk1sWHE2b0dIN1FiYzlYNXFPQytNNkxl?=
 =?utf-8?B?M0w3Tmd3bUFCd2NoR0diUitZdytnNUIxWnphNFk1TWdBUXRwbEJCRitKOU1K?=
 =?utf-8?B?eVhRYWxDZXFjc3ZDODEva2tqRUh6V1hYOWM5NzFaVjUvUjMyM3hQekhGMDJu?=
 =?utf-8?B?QTljTUhMck4rYVNkOHU2TlRZMWpqbVhENnVHbURpUlZIcStVZnVMTUN3enNh?=
 =?utf-8?B?QkhDWFEyMExVRkNJQUZINjBZUW0wSUpQK0R3YkRsQ2lQUm1rWW9CcFFvUmZL?=
 =?utf-8?B?YmxaN3Jua1ZOSm1SSDRSZ0RHVUliU0UxZHJURTVYRkg0OXpBWFVPRVhITUpX?=
 =?utf-8?B?eW45RE50TytnS2tuaVhUdnZJWmRWb2U5MVQvVEJBaWo0bkJQVVkvMjh4MEFT?=
 =?utf-8?B?NEVNL3FkcXdETlpmMmJDUnRqQUdMOUJwQjVsMzRHSDU0Ukh2b0pXWEJVVSt2?=
 =?utf-8?B?RGozbEhqQlo0QlRVK1YzL3R0bm9qZW0yUlJqU1dZYmE5eVlGcjJidndBL2VL?=
 =?utf-8?B?T0xGZlBTVUZSSGdZdC9yVVc4R0orQnRwRUFkdzk3Tjd4MTdsejNaeGxJK3ph?=
 =?utf-8?B?UzJodmhkWGpLNTlPTGp5RzdlcU1GUXc0OUZKTHJKbmtHVldHMkNWRnhOZ1Ja?=
 =?utf-8?B?ZEFjbW9tWnZEMGNONzhvdmdROFBPTWxoMDRCaUczbnF5OG5YWjFhTytpSG1D?=
 =?utf-8?B?Z1lZaTc3SkVMZ2k4RTBWcWp4ZXdLT0RQTnh0eTYvOWhqWXB1Mm02Um0wb1Zk?=
 =?utf-8?B?T0xUSmV0ejZXR3p3MG9lNXpwUXd4NU51QVZ1U1pkZVNxWGtoeGF5N3ZGY3ZF?=
 =?utf-8?B?NjhBZ2IwSkdmT0hZVjNKR3AwVi95aURFaGgycHR3UHBVOVpuSDMwS3MxQXkx?=
 =?utf-8?B?czZXeGh3bE9mNTlXWStUak9wKzJReHlPblhyRHZtNDV5TXN3ZWlvSGZpbGY0?=
 =?utf-8?B?WUZNMXcyWndodUdmc2NldFpCc2tUZWpNRlE1d2pjOVNXdEVrRTExOHRuOFpD?=
 =?utf-8?B?dzVrN2pyblJySkY2b1Rub1ZHQ25Cc3J3dnhBNktvTm9Dc3FWVnRDLzNGajFC?=
 =?utf-8?B?SVpJZlVneGRpUVBUajBlUFVDWnJGWUx5UzJGMTZ2VzBvMkRST2NQUlY3N2R5?=
 =?utf-8?B?U1d3N2FPNVhlQ1BVY1RrMHVwSVVsQUFVSTNBd2tqb1g1aURQY21sNW94Yk5i?=
 =?utf-8?B?aDA0dWhFV29GVkxyUzN2Tm5MTkFIcXVHUzJqN3ZLWWdEcEdVY1ZDR3AzWndq?=
 =?utf-8?B?VHZhSEpiRHdqa09VUnhNMzNnVWozUG9WODRCS0lwZEVzUEtsT3VWS1J2RFRT?=
 =?utf-8?B?NnNtQVpRS2k5VVl5TzA4dWZMNGFSZ3ZwcmJ5d281dFFwYVJGLzVJOFlHenNk?=
 =?utf-8?B?RDVyWDlqWUZaWG9ibWNUdlhUNFRFMXI5TzE0OWdKdnRwc3JXLzFIRHU1STh0?=
 =?utf-8?B?VWVSK2hrUERvQ2lmSlkxNlhRWE1vN0M2cnhNb2FWNG5yTFhucnRJM3drS1Vu?=
 =?utf-8?B?S25Xc3N4L0dXU2h0ejRacGpBdWR5bm1lbnhlN2VUN2xZblZOUnBET0NNR2Zm?=
 =?utf-8?B?Tk5BdStjQU5VTVM2UUh6L0pqMFZRaGZNOHI5cm1keERGci9ZWmliajByZHo1?=
 =?utf-8?B?cUo0RjdlYVd0dWZNWlEyTkNwNFpCMzJLUTdNRElzZVlza0NzUlp1YW1aeUc1?=
 =?utf-8?B?VlRTTVFVMitickJJSEx5aUwrbTRTWlhuR0VwVGZ1bi9LQUpvcjRZcjdURTlO?=
 =?utf-8?B?dmdYTzlNVnUranRSQnZqTm9lL2RZeTZQczFFSk00TFVNZnpzbHRvRjhWNnlm?=
 =?utf-8?B?a3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3af5443a-050b-4876-7314-08dd70dcd13a
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5703.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 05:19:46.5744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ftp6tHl8MixQ3QZqef0ENBQ0cobCKGzWjJ67AdqJy2+4z/tWENIzRbNMYK3spbZPV3IB1QDkp9fqPbSo2px0vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8764
X-OriginatorOrg: intel.com


On 24-02-2025 22:18, Anshuman Gupta wrote:
> Enabling VRSR in runtime suspend and also in System wide suspend.
> Also fix couple of typo in xe_pm.c.
>
> Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
> Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
> ---
>   drivers/gpu/drm/xe/xe_pci.c |  4 +--
>   drivers/gpu/drm/xe/xe_pm.c  | 49 +++++++++++++++++++++++++++----------
>   2 files changed, 38 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/xe/xe_pci.c b/drivers/gpu/drm/xe/xe_pci.c
> index 70b697fde5b9..55b42b3a10d2 100644
> --- a/drivers/gpu/drm/xe/xe_pci.c
> +++ b/drivers/gpu/drm/xe/xe_pci.c
> @@ -967,7 +967,7 @@ static int xe_pci_suspend(struct device *dev)
>   
>   	/*
>   	 * Enabling D3Cold is needed for S2Idle/S0ix.
> -	 * It is save to allow here since xe_pm_suspend has evicted
> +	 * It is safe to allow here since xe_pm_suspend has evicted
>   	 * the local memory and the direct complete optimization is disabled.
>   	 */
>   	d3cold_toggle(pdev, D3COLD_ENABLE);
> @@ -983,7 +983,7 @@ static int xe_pci_resume(struct device *dev)
>   	struct pci_dev *pdev = to_pci_dev(dev);
>   	int err;
>   
> -	/* Give back the D3Cold decision to the runtime P M*/
> +	/* Give back the D3Cold decision to the runtime PM */
>   	d3cold_toggle(pdev, D3COLD_DISABLE);
>   
>   	err = pci_set_power_state(pdev, PCI_D0);
> diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
> index 6d28aedcb062..5c96f8629a87 100644
> --- a/drivers/gpu/drm/xe/xe_pm.c
> +++ b/drivers/gpu/drm/xe/xe_pm.c
> @@ -232,10 +232,12 @@ int xe_pm_suspend(struct xe_device *xe)
>   
>   	xe_display_pm_suspend(xe);
>   
> -	/* FIXME: Super racey... */
> -	err = xe_bo_evict_all(xe);
> -	if (err)
> -		goto err_pxp;
> +	if (xe->d3cold.allowed == XE_D3COLD_OFF) {
> +		/* FIXME: Super racey... */
> +		err = xe_bo_evict_all(xe);
> +		if (err)
> +			goto err_pxp;
> +	}
>   
>   	for_each_gt(gt, xe, id) {
>   		err = xe_gt_suspend(gt);
> @@ -247,6 +249,12 @@ int xe_pm_suspend(struct xe_device *xe)
>   
>   	xe_display_pm_suspend_late(xe);
>   
> +	if (xe->d3cold.allowed == XE_D3COLD_VRSR) {
> +		err = xe_pm_enable_vrsr(xe, true);
> +			if (err)
> +				goto err_display;
> +	}
> +
>   	drm_dbg(&xe->drm, "Device suspended\n");
>   	return 0;
>   
> @@ -288,9 +296,11 @@ int xe_pm_resume(struct xe_device *xe)
>   	 * This only restores pinned memory which is the memory required for the
>   	 * GT(s) to resume.
>   	 */
> -	err = xe_bo_restore_kernel(xe);
> -	if (err)
> -		goto err;
> +	if (xe->d3cold.allowed == XE_D3COLD_OFF) {
> +		err = xe_bo_restore_kernel(xe);
> +		if (err)
> +			goto err;
> +	}
>   
>   	xe_irq_resume(xe);
>   
> @@ -299,9 +309,11 @@ int xe_pm_resume(struct xe_device *xe)
>   
>   	xe_display_pm_resume(xe);
>   
> -	err = xe_bo_restore_user(xe);
> -	if (err)
> -		goto err;
> +	if (xe->d3cold.allowed == XE_D3COLD_OFF) {
> +		err = xe_bo_restore_user(xe);
> +		if (err)
> +			goto err;
> +	}
>   
>   	xe_pxp_pm_resume(xe->pxp);
>   
> @@ -543,7 +555,7 @@ int xe_pm_runtime_suspend(struct xe_device *xe)
>   
>   	xe_display_pm_runtime_suspend(xe);
>   
> -	if (xe->d3cold.allowed) {
> +	if (xe->d3cold.allowed == XE_D3COLD_OFF) {
>   		err = xe_bo_evict_all(xe);
>   		if (err)
>   			goto out_resume;
> @@ -559,6 +571,14 @@ int xe_pm_runtime_suspend(struct xe_device *xe)
>   
>   	xe_display_pm_runtime_suspend_late(xe);
>   
> +	if (xe->d3cold.allowed == XE_D3COLD_VRSR) {
> +		err = xe_pm_enable_vrsr(xe, true);
> +			if (err) {
> +				drm_err(&xe->drm, "Failed to enable VRSR: %d\n", err);
> +				goto out_resume;
> +			}
> +	}
> +
>   	xe_rpm_lockmap_release(xe);
>   	xe_pm_write_callback_task(xe, NULL);
>   	return 0;
> @@ -590,7 +610,7 @@ int xe_pm_runtime_resume(struct xe_device *xe)
>   
>   	xe_rpm_lockmap_acquire(xe);
>   
> -	if (xe->d3cold.allowed) {
> +	if (xe->d3cold.allowed == XE_D3COLD_OFF) {
>   		err = xe_pcode_ready(xe, true);
>   		if (err)
>   			goto out;
> @@ -606,6 +626,9 @@ int xe_pm_runtime_resume(struct xe_device *xe)
>   			goto out;
>   	}
>   
> +	if (xe->d3cold.allowed == XE_D3COLD_VRSR)
> +		xe_display_pm_resume_early(xe);
> +
>   	xe_irq_resume(xe);
>   
>   	for_each_gt(gt, xe, id)
> @@ -613,7 +636,7 @@ int xe_pm_runtime_resume(struct xe_device *xe)
>   
>   	xe_display_pm_runtime_resume(xe);
>   
> -	if (xe->d3cold.allowed) {
> +	if (xe->d3cold.allowed == XE_D3COLD_OFF) {
>   		err = xe_bo_restore_user(xe);
>   		if (err)
>   			goto out;

LGTM.

Acked-by: Karthik Poosa <karthik.poosa@intel.com>



