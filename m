Return-Path: <linux-pci+bounces-33444-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDF5B1BABC
	for <lists+linux-pci@lfdr.de>; Tue,  5 Aug 2025 21:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EECC628121
	for <lists+linux-pci@lfdr.de>; Tue,  5 Aug 2025 19:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1972989B5;
	Tue,  5 Aug 2025 19:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H3V+oeqQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F8B29B23C;
	Tue,  5 Aug 2025 19:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754420808; cv=fail; b=avSYiSVTN5DG+5pUhHplHoefwIGhoRjGtjrYKQz7+Ll25NIlFSDcJ7E+qB+W2KJrBgtrd0U33Pyv+O5O/pH/UEM6NpNUcatj47Ho/Y7rRMH+qqSFfJ7HLnREUbr22w7fOsGRv0MXx1pc43GX9kW1h9c4SNqQBMnuG5TAYVkJYHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754420808; c=relaxed/simple;
	bh=Ufakgg3GTJ0bmMnb/PfYe7qL8vIsi4lfj/PLS0olFl0=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=Cuave1kmMIAs3mFlR1SJ9Gj1WCedEXAgnYRhptnwLcLqVyXjAlrw7bFlgRHPCbWfQ6ph7eDLKYPA1fLNPz8JYGZ2OY9ecSatcjtGmnUVINKA1ZzhxBpTfXdp9HoL7XnWPSve9nn0YNrT/elz25vS78eQ7PtbKRLnTtJ0qqTD5FA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H3V+oeqQ; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754420807; x=1785956807;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=Ufakgg3GTJ0bmMnb/PfYe7qL8vIsi4lfj/PLS0olFl0=;
  b=H3V+oeqQa0sV5gcP2s/DvOpiQPuZjbEWSnihFgeLzddy+oGqqxcAdGjc
   WaCKUL27wI+3A6z8ZOHQ24dmmyX+LrpPEU7TTx69Odg1VOO+upGlGGBh1
   d+BO4RipxNw+PxqCLuBtlEDctIe3ltss4aQTJ+NPKfopLgCDc9M8Qhsgj
   1efaa19kCwMq52HMkdDFxu8LoPDyJ23DzzwVwOTcj6DSDngORwemg1H+6
   9svYAO32aN/V7iG3tTzLLzh1w06hENXl+PbYaM9gtKXD0hxD43jgr8xny
   GAS8tzcPpUIdZ16cneSIsCTVknlex5TYlLyBH23pMX+twRwTYVJ7bzimu
   g==;
X-CSE-ConnectionGUID: JNHmJxe9Q3u8sJAdJUFH3A==
X-CSE-MsgGUID: tl5vWGEzSEKVgteKXeujWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="56873187"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="56873187"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 12:06:46 -0700
X-CSE-ConnectionGUID: 0MNU73izR1qbZzdajB0IDA==
X-CSE-MsgGUID: 4diIMIahTiGJ5hBOAp54aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="168744146"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 12:06:46 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 5 Aug 2025 12:06:45 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 5 Aug 2025 12:06:45 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.44)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 5 Aug 2025 12:06:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B7OG6fWReQhx3wov/IcuA3zfaebM+LTzNbVdkYFo1xOXCBbYW+un2YryCIOsgojm2tjvAJuvmJYLXIHAAiwQLAtBatFh0jfT2ktYdALoZWy0MuQvz1NuKNp9XzS42Kse0ldKwwNb//g0fnzZwV7rrgTuQUEi5b1CrE1PIzDFANDQB+ut1YNfxC/Bkret0PAaZ0QaSt2N4VwY3hchcEGiNTKDO0siJ9Srl/uZzQ5mDCM6pdIKdVL1kd567CBNFV4HjvT8foYA2U+Tw0RYqWvtNktFMsHGCiwvVEfXqNcFiQTteg5WklEQ3nXtVzI6ZHJCLZnp026FVJ/nAgZVmnh4JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ufakgg3GTJ0bmMnb/PfYe7qL8vIsi4lfj/PLS0olFl0=;
 b=Dd3Wax5iTsAEfhfNnl/qeW/0l7o6DA5hVciMlsymDMcEDDrr0OzGkcC0pp08yuYAlc/h0M7wpuZ2uNUVUlZQVEeLEb1JN5rloAHZ5QN5uml1PJWoVaZm4m0Rdi3NLrlyofyLqqLoNshZjXNN78q9MA/ytAzm56SXFJVk+Y4sNRsN5aCrodSqLPDoizdXCgFy326nVs5hrlxayIiz1IH5g5wnEjcLR2Uoqw1Fe+qpXpG57GVjDspz0UFZk3wGgbyInYPm+n7T9QjSFAJ4CCe6+M+ig5jAsfH7y2uV4UqvuDcLYv9yaFYrDoZW/5L5KmJ6rUstimJYT3cUjBkE263qPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB4824.namprd11.prod.outlook.com (2603:10b6:510:38::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Tue, 5 Aug
 2025 19:06:13 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 19:06:13 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 5 Aug 2025 12:06:11 -0700
To: Jason Gunthorpe <jgg@ziepe.ca>, <dan.j.williams@intel.com>
CC: Aneesh Kumar K.V <aneesh.kumar@kernel.org>, <linux-coco@lists.linux.dev>,
	<kvmarm@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <aik@amd.com>, <lukas@wunner.de>, "Samuel
 Ortiz" <sameo@rivosinc.com>, Xu Yilun <yilun.xu@linux.intel.com>, "Suzuki K
 Poulose" <Suzuki.Poulose@arm.com>, Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
	Will Deacon <will@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Message-ID: <6892562356e53_55f0910010@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250805184219.GZ26511@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <688c2155849a2_cff99100dd@dwillia2-xfh.jf.intel.com.notmuch>
 <20250801155104.GC26511@ziepe.ca>
 <688d2f7ac39ce_cff9910024@dwillia2-xfh.jf.intel.com.notmuch>
 <yq5acy9a8ih6.fsf@kernel.org>
 <20250805172741.GX26511@ziepe.ca>
 <68924d18a68d4_55f091004d@dwillia2-xfh.jf.intel.com.notmuch>
 <20250805184219.GZ26511@ziepe.ca>
Subject: Re: [RFC PATCH v1 00/38] ARM CCA Device Assignment support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::23) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB4824:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d14c44d-daf5-4677-8130-08ddd453256d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SmEzSWdVRW1lRjcwdHZXdXV5LzEwMFNmeisyMi9nRU5qWGVrWU03OVlsYjla?=
 =?utf-8?B?aGtpckdoTXF0TzM4S2IzVC9HUDI4ZmFvdkpvZmpLUEcvNDlDRXRBY3VCY244?=
 =?utf-8?B?Nm1pK0JybGptendKV1NTQTBVQ3o1Z2RYTVdEUlkzeW9KQTF4YVhQS0Fsdndo?=
 =?utf-8?B?R2RqYjlQNE1WVFA1cVAwUk85WTFubEMwa3pkTmtMakVPV0RqMFhQZUNxampq?=
 =?utf-8?B?ZDdCQlh2K2RHV2NQQ1JBT3NLKzhLSEJ6TWIyY0VKdjBPYUdEWTEvUk5JYXNL?=
 =?utf-8?B?aEJZS1lHa3VxUEhoRlVaZ2R4aHY3aTIycUZxZFFNRGg1MTNhdXQwbmVxdk5T?=
 =?utf-8?B?V2o1MTlQb0JmeHNQNVRtcWNHUThzZ0lnMDdrWVhkY0RObWdwR09idHNjT1pI?=
 =?utf-8?B?T3lJOWowb29NSjNOQXRIM2FDSC9MRFpBMUVVc0h1M0d1NmhpanlxTG92REFH?=
 =?utf-8?B?dG11MmVrTDU5ZStJbW5EU3RBak5WeW1lUis4UU5zRTl2cHFDbG8xVWE3UWRr?=
 =?utf-8?B?ekZyNWtLOHFJWGxZYUQvRm15L3lFajRWZHZwV0F3S2lPNGNtMlpOR3BuQmZH?=
 =?utf-8?B?UTZtVG5zOUREajdkS1p3cm5yNGt5Y21tMUJ1YkRRazFLQmlreGdJRE1ISzBa?=
 =?utf-8?B?RnpBWVMzWm5CTEFJQ3pmSUVvRUdQR2ZxZk9POFdObXg5TmE2VVhjZ3BDODFB?=
 =?utf-8?B?RGdSRy9kdHVlcEZLOEVuWDVsRVlXNkQyMFByei9oUjY0NWdIbGlkbFM1Yzc3?=
 =?utf-8?B?NzZyZXBMK3NCejY4eGQ3VTRTRmJrVDJibGhLU3lQTmtqd1UwMGcrb2hycE5z?=
 =?utf-8?B?K1BsZ3FPZUR1bk4wdWo5TWdaSWhWL2hrU2Z1TkJHZ1A1aGxWeTA1S3lsS3Rn?=
 =?utf-8?B?Q3ZlZjZLZVNZTWMwdE44eXhSaS9VWE1kS1BoRkdtSFROU0Qya2JEbG5pUmls?=
 =?utf-8?B?RXFwdXhsUUZuakdhRDYycGVLOVNVb1N4ZElBdEY0YTJZSzBMRExqVm1iZDND?=
 =?utf-8?B?eU55aFhrZ2swaEdnOTNJbVVRSjZ3OXpJSGt6R1FrQUNuNVBmbFVPNlppOVIw?=
 =?utf-8?B?a3pCSzQ5U2xPTGN6U3creUZaQ3FnOEFiK01hNytiOHVBUEhBK2hZamtTSkYv?=
 =?utf-8?B?SlNFV0R2YWcwMFRMQ210ZUFuTkdPRGdlM283TkRwYnhoa0pOQVJkYUk5bUV5?=
 =?utf-8?B?YWFEdm1PeFo1SnVJYjVDaXpzb1I4dXZMcTZ6Q1l1bW1ZSDJaczJqd3lyajhl?=
 =?utf-8?B?Wm8yRWJTeVVRWVFkekxGTGRVTWl2ZHBpSS9UdzkxbTNhVFhqSndlY1ppR3dr?=
 =?utf-8?B?RGNiOUlWbmoxWHE0eXVCQk1Lay9zOGEvdTRCVHFtVXkxMjBOMEQwOXZDTEpX?=
 =?utf-8?B?MWljWEtJekVvYmFyYnBybytnV0pRTUVZSXRkTzhDYVNYKzZMT085YVdMdHdR?=
 =?utf-8?B?NmdxUUVIUUNkMi9JaDFHQmU2RVJzaGp1SnRPOVJjUGpRODdWV293YUNUUWVH?=
 =?utf-8?B?ZjhRbkhWK20xLzZHb0VBQWdid0dMRnpQZEVUNjJUQnU0N0w1eWVyN0dMZ2U3?=
 =?utf-8?B?bWwxMElKaWtyeWtBc25MY2hZb1JFaDVMbDVlNVZjZTUvWDVJSWtlaE5HNHNB?=
 =?utf-8?B?a1hPTEc0OUJvWWNqeldRclY3ZWVnNllXMFJpcE1xZzgxUHoySmhwaDVFUEpM?=
 =?utf-8?B?SmhBLzBBTDB6V0xnNjV5akdtN2FySWRLTjRDQW9abURsOWtoTWxoSythZ2Fl?=
 =?utf-8?B?SmlhNytOLzB2TE80VElodS82QnJaTHRFNTNSOTRxSkxPSWREb2NRTjVsWFdC?=
 =?utf-8?B?SmtXeVNpb0owTjhCRG5FdlNjZVhzNDZHZzBpTXZVd0I4RVViQWh2VHA4Qk9n?=
 =?utf-8?B?N0hQZzR5d2V4SW8rY1c5RlJXR0F1Ry9jVnFTVG5WSjZsWU1uN0pOampFWGds?=
 =?utf-8?Q?YHQGOLZgooo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEtvSllQVGdxZmcyM0dObXFxSG9USEdHdDhVQ0l4L2c4MHc1bWVIcGI1VmNM?=
 =?utf-8?B?TEdVL0tmY0ZUSlh3bDhTTklJcnNXbVNWMUpycG5xZDl3QVE4a0pRNGp4QmdF?=
 =?utf-8?B?VWtYZkpJYmpXakl1VWZiUHIxWlRoaGU3Tm5ENitMaGFUUFlINjBKVkNxV1R0?=
 =?utf-8?B?TjZ5RStoK0YreHpRMnc0enRPNHFoRzlEU2J5ZG1Md0w1VmJmazViUDZOcm5F?=
 =?utf-8?B?Si9PM1RBcXllRzl4SWJFNGg2VFFPa1Fubmp3bDdhQ21wcHM2WW5tSXVEY2U4?=
 =?utf-8?B?K0JLN2RjZ2RLUkdJSHBhYW93M3Ezd0RwcEhpSnIrOVprd3IrZk43Y29FNmpy?=
 =?utf-8?B?OFo5NHlBZWVFUVBWeDVFeHhOOTlJeVpIWHgzQW5TWVlGQmRkWnEva1p2bWhI?=
 =?utf-8?B?ZVZxN1JOeGcxQmNnTHNXUGQvYXU5WXNaUVNIcHYrZ2p0LzJ5Y3RvRU1obUNY?=
 =?utf-8?B?VzNMZitpeERjUzRwOWtpM3dYTjRxTmNuSWxuVkpQbWhHeFk3WG9PeDV4V2d3?=
 =?utf-8?B?NGJDa1d4bXpHNzJwOTQyYjlXMDNPWU5ZaTBDMVU1aGhUdEJRMjZuRjVnMWRT?=
 =?utf-8?B?WlFNSEZCaFhWVEwwbEtkK2VKVE5tMTczbjB0REc2SXdGcjVtT0tIMDQyT0tU?=
 =?utf-8?B?QTVFTk9DYnRRUlY1NFJMZUM2c0pHb1Q5c0xFSU9pQ2VhZk1nZmJIWWN6VWQ1?=
 =?utf-8?B?Yzh4RTJWR3pJanQ0VTVaR3ovVm5lbHY1NnBpNHpYRTNpWGUrMDJGczhGV29s?=
 =?utf-8?B?Y1J2TjBBQ3EyRmJoL28weWczT2NrYkNyWnI5VVpJSHd0eXU3YUc2RXJDNGVT?=
 =?utf-8?B?UXpPYTVCQ0Z2R0hqbWlQcnYwWWhaYTRPYytuRTZyVzNzK0xOS0hJYklyTklm?=
 =?utf-8?B?S013WE41QVhLdDRoMytvWi8zY04rUFNBTlRtZlVJTk14b3NhTFpYOG05RStI?=
 =?utf-8?B?SldWV3haaTF1Mm1FQkp2RmVjVDFxTDRSRnJSbGpNaVdwZjdYcjZwK2g4N3E5?=
 =?utf-8?B?UnBQUXNGTDdKeVVtMGdRREs1a2JiS045YUxyaUFsb1Y3dy8xcDdJZUowbEI2?=
 =?utf-8?B?akh3bDdSWkt0TEFmTVJ5M0VKVE44cTZkZlh6a3RHQ1Q1RG8vY3hMY2xBMURl?=
 =?utf-8?B?ekJ4YTVxZ21vamd2Ti9CWVJDWVp1cnhrWkJqMU9aNlgzMVkrV2UrclV5bWRa?=
 =?utf-8?B?d1pxRkVXMUF2Smx5UEdrWnRqOGx2eC9zT1l5NEtVemxOWUJOYmFVb0YyK3di?=
 =?utf-8?B?KzdWME9sdFpXRW4yb2tNOXVtbnM0UWpKNFo5dlQwUktJT1I1TVFZcDY3RitP?=
 =?utf-8?B?KzV2dkVvWnNvbmJHekcvTnpFUWo0aFRGV0xlTXNkcTBJVjYwQWxYUnJhd014?=
 =?utf-8?B?NDdQU1lMSUZsbmF4RVJkMXJoMFE3bVBxaGRrZ3gxZ0pWN3o2VTNubEc5Ym1Z?=
 =?utf-8?B?ZElvRWxLeFV3MkUza2oycFJZSWRpcWZkQ0kzRTEyRGN6eTY2QVorLzB6eVp0?=
 =?utf-8?B?ZVFKdlQvNU8zY1NEc3ExYU93STR0aHBtTkdaTW13QVhFM1dqOXc3bmM3WmpB?=
 =?utf-8?B?NEpzZytBaXI2MG1sZURnUEFnS0xBWmxaT25yV3Ezek53VkNhMmFPdVF1Y3lG?=
 =?utf-8?B?eTNZSEl1bUtSSElLVEUyaUlLM3FOays0dndUMzJSUlo5ZWEzZDVISHBwanBE?=
 =?utf-8?B?dU9JLzZ2TTJ4dkxMaEgzK09SWmw3TlhNWTEvakszaU50ckgxemFzTHREb0hK?=
 =?utf-8?B?WkErNHpKZjZ3MjFGNVBGYS9hRCt6bHcxTEdORjVjRDhBRUcwSWpXNmRrYyt3?=
 =?utf-8?B?SGwwRXdBRFBwN0oza1BOM01XK1FIeXlIcWJxWGdBcC9hMlNkS2JKK2FMakZ0?=
 =?utf-8?B?NDBkOTFOVzhCRnB1d1cxNzh0WEZVS1Vmc09UMFd2VDZsYWJPSjgvOEFlMnRF?=
 =?utf-8?B?Sk9JaVU3Y1NaclpBZFNqcUNSY2pZSjZocUZCQWRtRUYrQlVTRS9Ed25MQldP?=
 =?utf-8?B?VFJvKytrNmtPdGp3WldhTFhBdkEwRWc4MGlndGNyWU1sKzRNUjRkRWJjMk82?=
 =?utf-8?B?aHF1YkFuZ0NWdnZvL2ZPaHZhMytObDBBL21jMFhncWFjanFtSVZyVDhEalI3?=
 =?utf-8?B?cUQ4ZzNMbTRlazZZQ1ZXakMwN09VU29BWXlrVjU3TUhhUDV5UlFiNmV5amxq?=
 =?utf-8?B?YXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d14c44d-daf5-4677-8130-08ddd453256d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 19:06:13.4564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e8MEV0nk6Q068LszJR+8ZXkm/meJIBhmfEJwO42/x9R2qlo3/tg0AkBjWF3NQbC/gsFxalnH5gCVDBsDIlz2dgyemfbSAtwzLHfKYOPHVZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4824
X-OriginatorOrg: intel.com

Jason Gunthorpe wrote:
> On Tue, Aug 05, 2025 at 11:27:36AM -0700, dan.j.williams@intel.com wrote:
> > > > Clearing any of the following bits causes the TDI hosted
> > > > by the Function to transition to ERROR:
> > > >=20
> > > > =E2=80=A2 Memory Space Enable
> > > > =E2=80=A2 Bus Master Enable
> > >=20
> > > Oh that's nice, yeah!
> >=20
> > That is useful, but an unmodified PCI driver is going to make separate
> > calls to pci_set_master() and pci_enable_device() so it should still be
> > the case that those need to be trapped out of the concern that
> > writing back zero for a read-modify-write also trips the error state on
> > some device that fails the Robustness Principle.
>=20
> I hope we don't RMW BME and MSE in some weird way like that :(

Yeah, I would like to say, "device, you get to keep the pieces if you
transition to ERROR state on re-writing on already zeroed-bit."

> > > Here is where I feel the VMM should be trapping this and NOPing it, o=
r
> > > failing that the guest PCI Core should NOP it.
> >=20
> > At this point (vfio shutdown path) the VMM is committed stopping guest
> > operations with the device. So ok not to not NOP in this specific path,
> > right?
>=20
> What I said in my other mail was the the T=3D1 state should have nothing
> to do with driver binding.

Guest driver unbind, agree.

> So unbinding vfio should leave the device in the RUN state just fine.

Perhaps my vfio inexperience is showing, but at the point where the VMM
is unbinding vfio it is committed to destroying the guest's assigned
device context, no? So should that not be the point where continuing to
maintain the RUN state ends?

> > > With the ideal version being the TSM and VMM would be able to block
> > > the iommu as a functional stand in for BME.
> >=20
> > The TSM block for BME is the LOCKED or ERROR state. That would be in
> > conflict with the proposal that the device stays in the RUN state on
> > guest driver unbind.
>=20
> This is a different thing. Leaving RUN says the OS (especially
> userspace) does not trust the device.
>=20
> Disabling DMA, on explict trusted request from the cVM, is entirely
> fine to do inside the T=3D1 state. PCI made it so the only way to do
> this is with the IOMMU, oh well, so be it.
>=20
> > I feel like either the device stays in RUN state and BME leaks, or the
> > device is returned to LOCKED on driver unbind.=20
>=20
> Stay in RUN is my vote. I can't really defend the other choice from a
> linux driver model perspective.
>=20
> > Otherwise a functional stand-in for BME that also keeps the device
> > in RUN state feels like a TSM feature request for a "RUN but
> > BLOCKED" state.
>=20
> Yes, and probably not necessary, more of a defence against bugs in
> depth kind of request. For Linux we would like it if the device can be
> in RUN and have DMA blocked off during all times when no driver is
> attached.

Ok, defense in depth, but in the meantime rely on unbound driver =3D=3D DMA
unmapped and device should be quiescent. Combine that with the fact that
userspace PCI drivers should be disabled in cVMs should mean that guest
can expect that an unbound TDI in the RUN state will remain quiet.=

