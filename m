Return-Path: <linux-pci+bounces-41573-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 97634C6C901
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 04:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9C8F64EDB51
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 03:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3838224D6;
	Wed, 19 Nov 2025 03:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ofewqfj9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D588E28B7D7;
	Wed, 19 Nov 2025 03:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763522405; cv=fail; b=tVeB8vhWQqTLvtMVH2ieW7qBTSp/eZdhVZGmR9VDrs7f3+oa8C3NoXrLJmk3mozhMSDqzhZodu6RQWZkw5pW+nSwIOQx29TuusfxkodK0G3JZNhz6QALDAmlmRutDc40Bq59JbDTn/72EC4zerT4wX0UEvyey8ItFh03XUnSSWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763522405; c=relaxed/simple;
	bh=H6Hh+vXau7bvssoR67z9bo75j8KJ7n9ceItETiyYBjk=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=jK9/aqHw254h6plTu7/PTZXmpenJrEiAdeguGchP59NsG8e0Odr5hq2haiRjPZtsCs4b+5UHmpO175dasyY8Gw/nWLLIUO5zngHquBdz3Ns6wxTZF3PTUySwrY9/5hcG8CdvoLLrL1zlbcAY/jjXxyrIPedDmkxYYsB5UfpvaFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ofewqfj9; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763522404; x=1795058404;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=H6Hh+vXau7bvssoR67z9bo75j8KJ7n9ceItETiyYBjk=;
  b=Ofewqfj9FIGrH0+jg9KT54rQaXWaXO94U7lIg6Nl1NxMt/ME1EFjY7da
   jtzSPjygn1PHcyDvYnosBk1aom/tLqB5/cd9Wu1APV5dR4EIwTYebYh2f
   GwfJCL1qEc6mLYjcpL1UkbDa8NKidh600zbkPEKjCRl0gDhDnKxqK6Wuw
   KKR1BEzYm7UlKMA5HE4JBD8cFwh9dKGFYYn53Uy0tYkH3y5xpFWN8oYkN
   AFPSmT84Bikmm74K3BoMsGQ9/4a1QS8kQCJwPBn/fxGT1gzsEA2XWIecd
   6cneaRSFaDx/NDCHbvAClWw+5eZUa3BXc5onAGxSftOjR4BxzUnM3vuHp
   w==;
X-CSE-ConnectionGUID: 0RlWOl66QyaKIlzTt3G1lw==
X-CSE-MsgGUID: 5VxekKf8RIm/O3x09uCS9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="68163017"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="68163017"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 19:20:02 -0800
X-CSE-ConnectionGUID: UpBCtUdXRUqOPmw3BzUFLg==
X-CSE-MsgGUID: MPlnT7MdSkSgk3vjAAT+fw==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 19:20:02 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 19:20:01 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 18 Nov 2025 19:20:01 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.27) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 19:20:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QrmH/aaPk3DTrqe6m+s0Ma4XMQYVE63r2nxvZaceQ/LofFCVJJzzpNdMpHfhYOs36NAIuXXhdB44wWgDk4VQlvvZ8R51/BhEKgjKxOjD8qStBeqwlNtIRg9W68MmSFYuysdetDQ7n/WqnBiIX2xQBeFknh7TcxHtQ2E4qlFBfaCdY8A700PDKiahiXbnhMj5HXcx5p6UsP8b+ILnIoYtyvZaSdbyvxoRuGIi0vDwP0JA/ubLrbVU7vuxlREl1LkKHnsjneQZv6ici4xgPfVF/9cKnhzX30aWTZJ+NKNPWG6rhOZt3UQPhouIrp1s/9MuSjb07A1rN/RWV4nS6X9n3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XZZI/UzBFH+7ZnRt7hHbeyeb5p3czaq33wLUB38P210=;
 b=SAfpVfCd1qzsXdEOvxXoBDsFmuPRC0qjhqKC83Ml4a+Xc0KExY0iZt94Zloj5PhDkC/Iqrr0IW9KAIUCVbUav2+hD8fknXKkiaGsW41oQSTiBTtTLb0i4Ip1hCTu7Oy8D984eSo+9nyxg1it5J39y3zYd27qhEYyc1nljui71XUkP9IwMROb8ALFXt3ejtBALvF8icIM4iRQtvSupleuM1PfYlUDPoSqSSGt3YtwPhwCOdz3wgj/DypYN9CAgpCpF7JznCmRLOtdSjpxKFOkwdlHnvqFFJt26s0fa67Lb8EB5wO2BxE3rIiTegsa4lTF0R1ruGBHaIdyqkdId1L/SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA3PR11MB8937.namprd11.prod.outlook.com (2603:10b6:208:57c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 03:19:53 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9320.021; Wed, 19 Nov 2025
 03:19:53 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 18 Nov 2025 19:19:51 -0800
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
Message-ID: <691d3757809af_1a37510086@dwillia2-mobl4.notmuch>
In-Reply-To: <20251104170305.4163840-2-terry.bowman@amd.com>
References: <20251104170305.4163840-1-terry.bowman@amd.com>
 <20251104170305.4163840-2-terry.bowman@amd.com>
Subject: Re: [RESEND v13 01/25] CXL/PCI: Move CXL DVSEC definitions into
 uapi/linux/pci_regs.h
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0099.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::40) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA3PR11MB8937:EE_
X-MS-Office365-Filtering-Correlation-Id: a8f02ceb-52c0-4479-6be7-08de271a81d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WUhzbVFzZFBNYUVQOWZvMGdUa3F6R2dvUWRBMzFITThBd0ttQ1lzd0NmUHpx?=
 =?utf-8?B?UGFwM1Q5MG5hQVRzSGFtUG1rVS9JU2J2OUlIeUR4QVhGMkYwSUY0THFVaW1G?=
 =?utf-8?B?TXFBVkRpcDFVbE9QSlJsVU03VlcrQVhjTjQwNjJHL25NNzh6dlU0bEUvVGxZ?=
 =?utf-8?B?QVBYTm94UCtsaG5KK0FNeGFoTy9EVzRYTkxwY1J3UVJLd1BkeStxNngyRk9V?=
 =?utf-8?B?Ulp5STFJcDdFelRhNml3NmtvSHRUV0s4QjVvWkQzMlpFVkVCQTJNeE84RnFk?=
 =?utf-8?B?VXlXaWlEajdMK2U0bHpTU0NRRVlKemFUUDJxdS9wNHRsMkRnZzZkcEpmTkNh?=
 =?utf-8?B?aGFEdURidVBrR3J6SUFweHJPRlo5VDNob0lTWkI5MTA5U0cxRGY5TDNHYjN4?=
 =?utf-8?B?TWN5V3h3cVRVTklPOHpmc2pYd3pCUVdodjFBWE1ZL09SVk4vbC81TXZyc0Nx?=
 =?utf-8?B?aEVNamhqZ1NwQlZobHRqamN4UnpFVGVxbFd1VW9VejZRQmtvVGpkbUVwdG4w?=
 =?utf-8?B?T2FBRWpZS1hoTTkvUnhuRW9vaEIvMkZtaEdSUWNQdThlT2JHTG5hMzZZK2h1?=
 =?utf-8?B?bkFqWFlHVGxGSDRtQ21JYUMvRTRwVG50UGdHMjdqeEpGYUx6UzhJbnZvS1RS?=
 =?utf-8?B?ZGNlenVleWhaemRiWTlvWDZPSXVUWkRTbithSnZLNzFCbmpTOE9Zd0Z5UFBr?=
 =?utf-8?B?ZjdtWjRGWWM2akRxNGpUWmdzaUZMeWVJWWU3aCtwczFiOFZKbC9KMGViMzZM?=
 =?utf-8?B?Y3pEV0ZwNE00THArVWErMGpwZ1o1Titmbko1czUvc0NRTDVNMnNBemJqSldr?=
 =?utf-8?B?YmdGTVR1dS84WkVyU3g0VUVaS0NIQXdpUkNBOGlRRmdJaVZjTGE5dmJvanFk?=
 =?utf-8?B?TmtsU1pWd0czY29sU053ZHg0Rkkwc2MycEtxMkU2V2VTQk56aVpxM01NUEc0?=
 =?utf-8?B?NG9NdEJ0Ym9WQVZZTzVSck1TUVV0MHhSMFYxUys2Y2hoYmJXVVR2K0ROa2tH?=
 =?utf-8?B?Y2lYSlFTakdMNVlvZlAvSC9hdkJ1aVdVcWJMTVo1ck5BMkQ0QXBNcnUzb2VN?=
 =?utf-8?B?VEJYTS9GVFAwS05aYVViaGNiRUhrbG14TUR6V2k4cTVoOC9qak43ZnhkNzdK?=
 =?utf-8?B?WXkrZmpKVk1yT1d2QVA4K2hWOW9hbm1zMktza2thK0FsNG1FajUzYzh4VWI1?=
 =?utf-8?B?eG14ZHFUd1FYZURIWkdna0FWWHBPNGd1VmlTRUVTYUZkWlUwb0Q5MjZlWTJz?=
 =?utf-8?B?SlFNYWJGZCtTVmRKTTk1SzNGenVDZDNJMkp5SmNGVUJ6UnJVMVZsQ3lKclpF?=
 =?utf-8?B?Y1lCRHoyVGkyL2VCWUc2YXNGS1ZmdE81YUtWNnBkdVkyanM0NHlHQVVIRklu?=
 =?utf-8?B?S2VYM3dsODZTZFc4QUdua0taMXJlU3BqWHYrY0dIb3IxS2Z3YWptaEl2WUds?=
 =?utf-8?B?anB1YXNuWFJ2aXhyT2tIYzBFRHUyMlQ3WEhHbjRoUEg3N2cvdFBsRXhZWnl0?=
 =?utf-8?B?TTNueFJhNTVKRTFNdUpaMWw1QmlBb2c0YnR4ampCSlB4YVFkdmJKWUpOcFA2?=
 =?utf-8?B?RGVEdTVUNEh1ME5ydGovb3lhS21HRysxMWwxZUE4Q3RReEIrcDlOZjNZNFll?=
 =?utf-8?B?UTRPQ1JFSEhNdWVJbHExV2NBS1lBZWhUVE5MZ3A0QWxjNzdtdmMvOVNOVlM4?=
 =?utf-8?B?RTFtejBKeGYyMWdTdkNacXNZVDVadXZaWWF5cDd1MTRHK0Z0THBBL3B5aUlO?=
 =?utf-8?B?dDJGeXRCbTRtY3c2Y2hSOFU4TlczaWNpcnhXaTJucjZuWDh0eG9sdER3ZmVE?=
 =?utf-8?B?ZW1iVGZ2RkVscWVYNzBJUmdkTjhKVWlOK2NQK29hczVKTjhHOTVta0MrcXdp?=
 =?utf-8?B?QkVqZzZ6ZFY5VWdOc2s1R09Da1ExdFF3dENkZFpzOE9LOHd2K2pxZVUyak9a?=
 =?utf-8?B?MDVNSHNyZ1VaZnJ1cTQzQmg2TjBFaHo1RlpkOUMvdWp3TGc2L0ZRbkpxeTF5?=
 =?utf-8?B?OTNIcFNDMFFhdmxFaDVJUGw1cEJ4UUwvMEVodC9aU0p2ZVVxK2FpN3dMYkR4?=
 =?utf-8?Q?ALItJx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkJmUWhKa1Mzdk51enlPZVhiUTFUVmxrdnA1SmhvTUNyREw1anNuUXpUNE1R?=
 =?utf-8?B?cDI1TWpuTWdMaGo5TCtCYWhRdXJZNFJCc1VKaDB1c3plZy9maGxSMndZZVho?=
 =?utf-8?B?S0RCaGNVakpWL2VFUzhpai92ck9WSGpVLzhFTHVKNmlIY0VtSGdidmNMaTA2?=
 =?utf-8?B?ajJSdFhoQ1hiK0lCbFNjcDE0NUpMTnJudXR1dTM2L2wzUEM1K05qbVBmYStu?=
 =?utf-8?B?R0ZMNXpvZ3ZxTW5LZEFkcjF6Zk40Z0RFK2U0WUVXYnJHc3FOZHBtNGhpK3Vw?=
 =?utf-8?B?SEg0Wk9wOWxkenBtNy9JczJJaDZoaWtKbngyaGZJaXgxQ3RXVWcxNjRmZ2FH?=
 =?utf-8?B?aWFRR1AzVDdjYjJNdUd2QkZCVll0aDM1NWRxWUhlbHJVTFQzOFoza3Q2Y0o5?=
 =?utf-8?B?aDBjeXNBRHlvcWFuNGtITTlra0VrT0h6L1gvWjhuN25iNFl4QloraW5MZ0lu?=
 =?utf-8?B?eUpxbzd6anJ5dHlHc0xrNHl1LzhWSHZURHhQRXI1czZsZkgzdUR5a2FiYzhP?=
 =?utf-8?B?RDBCMndsYmF0bTJQQUZ1NFVHWHdZWjVnUGdlSm1MVUlOU2pLRUgwWHdWYjdF?=
 =?utf-8?B?Y1pnenpCWCt5ZVFGSWRGQWZBa21UMG10c21QQnY4SG9PRTJkRzR5K1ZJakNE?=
 =?utf-8?B?azhncHRqTGtLM0prdk4zZzBzTUhrenFZV1kzWWM2RTYxay8rMmRuT1AwOUIy?=
 =?utf-8?B?Njl6NTIwTVZDdmpCZnNDY0EzbDRtdnY3ME1DVXB5RTBhYkl0K1BJQUZ1WjFl?=
 =?utf-8?B?ZUNzVW5MWXdiSmRLNzRscFNIMzhuRVBxSjArTktndmQ4dzEzVE1iSnNWdnVS?=
 =?utf-8?B?UmVoYk16dVpwbEdkSk9uSXo0MnlkQ0FTRjBKcnFPV3JmQkpNcWt4YVl0RFBU?=
 =?utf-8?B?d3MvNUg5OUFRdW1tYmRwaE1RdUN1SS9kMDNVWVpHSnJsWG9kc3FUTUN1ZGlU?=
 =?utf-8?B?U3ZUZjY1TVo2QW9pakdMUFhiWThuZHNxeTRrR05iTzJZRElza2RUd2piUG1B?=
 =?utf-8?B?RU1acTkzYTRjM25ubG9hRkpCZjk4NEd6RXB5VCsyTmhmQlhYdUZld25xQnZ1?=
 =?utf-8?B?T0JtWlB5QnFmZlJsRDlwSldGMyttRUJLczVJRUd6UEd6YjBCR0ROQWdteGdh?=
 =?utf-8?B?MTNZeVhhemdiM1dLSnlERGpRTXdBVGhDSUY5aXRLOFdCZXZEN0U5UWdOd2lj?=
 =?utf-8?B?ZGg3b2dpbGx2bFl2TzVmTHd2UWxTWU1IWXdoc2JHbE1KdUZxUFhISUdkdUth?=
 =?utf-8?B?dGpqRTI3dGZyQ1d1bk9KQnNLcG4xaTVwVnpIL0FFYldFeEdoV0pIQlgvNmtZ?=
 =?utf-8?B?TjdzUG1XSFJkRkU0K2lqOHhyalNZenVKVEhlVlZqMXRicTF2WGs1ZWtXVDJK?=
 =?utf-8?B?UW1aWnFPTGhLYXhPeGRibk1BYTZvRUFQZVVONmhPV3hNN0JMRjJOYXhUN0Ew?=
 =?utf-8?B?K0NDR3NaTllvTjFkdDZ5ZDhiL3FhZFJsbXRobWZ0UmRCb3pTRzk1dXVLZ0I1?=
 =?utf-8?B?VFRKdENvK0RFd3FSTHlKYU1BTjF4OVJkMU9renJJYStQNEZiQ2dYVzJDVUFR?=
 =?utf-8?B?YytqOHlraDlOYjFsay9UaVppc3pwUlRTU1hLRlFsOWJDbFJ3aktyaFJaNGVB?=
 =?utf-8?B?L1J4cWREVnNRc09MTEtpS0hQR1Vta0IzK3NMY0VOeXd4LzUzWlhtSk1iTlBL?=
 =?utf-8?B?cUY4V09WYW1tWUdKS09JcHVJRVBxV2RJampDblpLTzRNMUVmZXpaNkdFN1Fy?=
 =?utf-8?B?V1hlNGM1eTNYNmZKYjBTcTNzZGxLOEV4Qk1jNEIzeHNnQXZyUmFQYW8yMzBU?=
 =?utf-8?B?WTdOWXgwVGRNTTVNVVNwQmlyTjlYK1J4ekZZZW02WkhjLzFZMjlHNEZldUgz?=
 =?utf-8?B?cWhhRmN4ME1VbDhobEYzTlBDeFFkR3dQaDdOS3ZTaktBNUt2OHpsaGVJOVFC?=
 =?utf-8?B?VVRaRXlTWlZJem01WHFHMzlKVnRjaUd1THF3dlVMMlJwcU5HZ3lhcnRQdFpt?=
 =?utf-8?B?ekw2UGdNY0VKMHU5Qm1SblRCNHpORTVBencwaitnWjd3VnpDQUZncnAvN3Fm?=
 =?utf-8?B?MFBHTHpxRFlhM0tlSW1zOWlvcjJEcjZJMHdZU0czZDNOSjVEbUFHd1F2Q1ZI?=
 =?utf-8?B?eUkvSTVYNG1QU2JkRVVPMkd1V0JMbGJma013Q2EvWXd5MFl4SWhhREIxV1E5?=
 =?utf-8?B?Rmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a8f02ceb-52c0-4479-6be7-08de271a81d3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 03:19:53.5508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ufJkUgc9H6eJy63ZbE63sMkaUdSj33usQYtYlUYx/DZptNlVKIEEDa/n5YRJbNdHvW1EHZa/r0qvxhzBisVRTvx0ltH9vx1jEzm8h+zGCy8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8937
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> The CXL DVSECs are currently defined in cxl/core/cxlpci.h. These are not
> accessible to other subsystems. Move these to uapi/linux/pci_regs.h.
> 
> Change DVSEC name formatting to follow the existing PCI format in
> pci_regs.h. The current format uses CXL_DVSEC_XYZ and the CXL defines must
> be changed to be PCI_DVSEC_CXL_XYZ to match existing pci_regs.h. Leave
> PCI_DVSEC_CXL_PORT* defines as-is because they are already defined and may
> be in use by userspace application(s).
> 
> Update existing usage to match the name change.
> 
> Update the inline documentation to refer to latest CXL spec version.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
[..]
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b14dd064006c..53a49bb32514 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5002,7 +5002,9 @@ static bool cxl_sbr_masked(struct pci_dev *dev)
>  	if (!dvsec)
>  		return false;
>  
> -	rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_PORT_CTL, &reg);
> +	rc = pci_read_config_word(dev,
> +				  dvsec + PCI_DVSEC_CXL_PORT_CTL,
> +				  &reg);

Patch looks ok,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

...but going forward please be careful to not reflow whitespace when no
other content is changing (no need to respin for this comment).

