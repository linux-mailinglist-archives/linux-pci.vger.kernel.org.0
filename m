Return-Path: <linux-pci+bounces-44989-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F74FD288F4
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 21:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 78F6130006DB
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 20:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681692EBDDE;
	Thu, 15 Jan 2026 20:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RqwUuyHu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17562DE6E3;
	Thu, 15 Jan 2026 20:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768510583; cv=fail; b=OiSu8RrYjcsYpCZuedEjHfQR1il3OZmoKHC6SrcSm9sCtjhBJcQaFwzz/ZMy484WkvgwMxuWJ30XREsBN4IHvaf7F2k4Xs/VUoNIUadCv8NCQ5EScE8w3tvvCFBwnPA5nefwmd8aGLabAz4asandCDG1+yHVD8pHGs4aVX6wLCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768510583; c=relaxed/simple;
	bh=7quruZffd8B0CBitMsIH0qwG1mXmRLYRb6ok/k2gJTc=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=XAqSxR6iRiB1FvggI+Krkkj25liiCQQn43Z+C6veUGidxG2Ccsv8s7ZXm8/IJLaeiGTKGG+qsObBFGvjywFraKsHkWRhUdBptbR9o0itE1LN8VLzcovLEUDLr7dNMNy/G7BAUgc3DpUoXtSrUxuokFMsX7izCQxBa1mC5Eo3maM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RqwUuyHu; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768510581; x=1800046581;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=7quruZffd8B0CBitMsIH0qwG1mXmRLYRb6ok/k2gJTc=;
  b=RqwUuyHuNi3TizLNJV2mFVDDfoBa7ADEDVICrdDJydD1XEbmO55WPIsM
   F6+gSilWRNkOxKAqllbfpWqDluiDXHkIrr6xi92yZIuJMUBgBtfyil9Ce
   kmT/Z2N4QHFeOZh+MST/n/lQqSNXpNUKqUoB/j1jO+d5XhNr2EQkxKeyX
   x+oi2tk0v8S3ePx7abg7EKjV8p7B6Xse4PV021HnoPOpgHVMPwt5orxdg
   NZKCNS2segM0UkEmSJHHNGV8yOIlavLCslxJvw6kM6U87105oWvoaKwGw
   2y/KLDDHBLZQt/YIEEIu1nLzzXJ+NCyYJRWn0Qvs94Z7FaBnlgH+hkcd5
   Q==;
X-CSE-ConnectionGUID: nxFWrFH7SiCd6mcqFefezw==
X-CSE-MsgGUID: r1mk6uSoRsC4BaDb8YDqFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="69881203"
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; 
   d="scan'208";a="69881203"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 12:56:20 -0800
X-CSE-ConnectionGUID: aO4hxJL6Sdi35e+mEWhRfA==
X-CSE-MsgGUID: gWKDYEwSSYuyZpSmeDubWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; 
   d="scan'208";a="209557648"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 12:56:21 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 15 Jan 2026 12:56:19 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 15 Jan 2026 12:56:19 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.58) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 15 Jan 2026 12:56:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m5qPZ/8JjDCW2YvIRuGBbGYuNSaLe5DGdP3usrTwV4Tf42HmPrJ6zsMAyADrF/IBFzbIoq4fi8wgwq6FR2i3em58KvkgJ29SmHLMtKASFxdQ4ojEoNkftSoZGbah7nwyCcTlceV9C4MtcRi6n2Ipl6cqrPeoyfMYLAp2cI1BXR26gxX9pjfcs3Ma2BKliJ3gGZGGU+SaQnBQ1K40mbdhGbQU5owwow9RUuElhugeGKJV02SqamAQ55Pj2NMTs/a8doPAyYr5VlxBPZQh5VQbPxvF95t9v1iT4wJLybkeNijfAMWgAkgz/1Sso6doPPaKJsAxn1Sopj6MITlbwZZ5gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=70Qf5ThtchP0j8BxdMMzMsVAE5wbZcnbcpzKEuUl7EU=;
 b=cW6lOyWa6ET68evJWg4D7OZ6U3IpzPLZTvdqx/AwEwoHPIEAOh5T9M289/0CoQLAuZW+4ttRaV7DS96FyyUioo94aaV25A0DMbGT8pjfVCwv6MshvG2vl6cT1ERDJQ9UqfNeTR5dS10RNhCxXMJ/PwqoHtGCe/+J82HjQd/uBFF9SWFtn1OXdGli6h7hRN4nB2mOPZtknSlDCNmAEgUynhm/GVTg0H3ehcIoOedJU2s4vq9BPg8QN2jBK1wqxhqXNtTOV53Lg3XrfRkFIkGViC/hJ2c1k4wYQhWL/PXQTC8DAo9KYVwETvv4q9m2QXqR2R3g2JRSYF/PJH4GZsVOYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB4804.namprd11.prod.outlook.com (2603:10b6:303:6f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.5; Thu, 15 Jan
 2026 20:56:17 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9499.005; Thu, 15 Jan 2026
 20:56:16 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 15 Jan 2026 12:56:13 -0800
To: Jonathan Cameron <jonathan.cameron@huawei.com>, Terry Bowman
	<terry.bowman@amd.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>, <alucerop@amd.com>,
	<ira.weiny@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Message-ID: <6969546de683f_34d2a1009e@dwillia2-mobl4.notmuch>
In-Reply-To: <20260114194851.000047bc@huawei.com>
References: <20260114182055.46029-1-terry.bowman@amd.com>
 <20260114182055.46029-16-terry.bowman@amd.com>
 <20260114194851.000047bc@huawei.com>
Subject: Re: [PATCH v14 15/34] PCI/AER: Update struct aer_err_info with
 kernel-doc formatting
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::10) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB4804:EE_
X-MS-Office365-Filtering-Correlation-Id: 39a1e462-dfd7-481e-4852-08de547886b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MTEzSUZRSGdkYlJZRmJ6QmQxZ2RlYWpTTWVWdDRmSDh2ODMrTDhzT2p0ZXh4?=
 =?utf-8?B?QkdNN2tYait1MkJVWnZOVTBVQ0llUThmcXBSVnJFTjltem5xUmhRMklhWGVP?=
 =?utf-8?B?Wmk1TUVNNzhTR0paekw2RXBMckhUdmNWb0dmbjVMRWk3N1hWUlVhcXdiWDkv?=
 =?utf-8?B?TVVMMHVvNG9BdnpkZXR0ZFI2TDFUblV0MVZGV08xVWdscW9WdkNaQW1aa01w?=
 =?utf-8?B?KzlHU08wNi9UMDBBdUdraWZIWmw4RjlycjVSUXdYWWRhSk9QL0pOeFltSVA5?=
 =?utf-8?B?dFl0LzNleXlkbVlrVGprcUoveXJCOEJDSmgzMmlPUHJ3ajhaSkhra043MWt0?=
 =?utf-8?B?NjZLMkxvM3lvV1FwY3dRMGViNXZwcVpIVVRIeGV0M1BrbVdKbEJNWkxaYVpw?=
 =?utf-8?B?bUUyWGRIMmZYTUNkNFY1ZW1iQ0t0QUpOZytyTzdCdW1LVk9kUno4dnRNbGNn?=
 =?utf-8?B?eGtxSGZwcVEwUTF3R0drMWk1SlJtNnhNZ1dEQTBtRjZMRGk0RHhJOFM2cVBB?=
 =?utf-8?B?Z0JNeEcxdzg2b1d1UUJzakZuZEw3aDNSYTROV0ZmMDBWRzFxWXZ4aDFZazdx?=
 =?utf-8?B?VUlsdUtJK1RHRG5wc3F1Q2VqcFRiREVmdFh0ZlVYbkRUcTVmUW9OTzRxYUtq?=
 =?utf-8?B?NmZKS2tsU2I3UzE2S21sWXhabEF4d2E4dFlxUUFLeG8zSTBxc2F0RjB4WTYz?=
 =?utf-8?B?c1Y4MVY2UEt1cFlGM1lJeVJKUnJJclRpMGh3cDFJenpJVGFEaTRiUVFBakxs?=
 =?utf-8?B?STFmNHVqWVpRdkJmSFNteXE2T000OS9jcDhTZUVZbk9MUlRPalM0a2ZxT1RG?=
 =?utf-8?B?ODhSdFlHWEpBVlIzb3pZSHJPM0tLL01ienE0cUMrU1ZkUlBRaUlseHR5VlVK?=
 =?utf-8?B?ek85bGlFT0ZTUXRibFNFdGFyU1g0c290S0tNR2lWQjNzOWhpeWRhNmhsYkM4?=
 =?utf-8?B?SkxDSklYdTYvVlI1Rk9CazdUVlhVWXE3NXZyNHBXaS9CcEhrVFRkVXM2Q08y?=
 =?utf-8?B?eU55ck1aQTY5dkZoYjUwaUVxRjNHTTlWS3FvVFlZdnI0VmxhRktmWUhENW9k?=
 =?utf-8?B?U1Jaa3NSVzFYNlBlN09ZcWw3T1dWMjhtd09VLzZxWlBlYysxYWFRQzBaSi9N?=
 =?utf-8?B?eVFCdzhUOHVUY2o0aTdRZEZDUm9qWTF2aFNDUzdRQ2U1T0NSV054SEdkSGRQ?=
 =?utf-8?B?Q0k3eGZpTWZsd01LMnZxdUprYVVWK3BEVCtxbFVwd2NCUThieVNzdEg0SmV6?=
 =?utf-8?B?UGcxanoxMEh6RTdJd3dkekIzMmxEZjhwdytPTXBFU2p0Y2NnY0NZRGJTZGRi?=
 =?utf-8?B?VUtOYzhST0kwNzgxT1FkT29EQ0Q5RE9qSzUyQ0lZMldOYUZUQUYwMjFvUGhV?=
 =?utf-8?B?cmV2Nkd6cHNHaXhpY3FMZDVlVHM3Qk41dnhqQXcvcy8wWE1xKzN2ODlmY2lj?=
 =?utf-8?B?TGFySi9RWmcrYTlWYkdtUEp2dHNqLzZ3bWJ6NUZ3cWpBWW5WTXhWaThMdVYy?=
 =?utf-8?B?OXFYQ3BYVGh5NVlObERIMEhpNGRuM3l4TnlWRjU2MnZRRzFFaFlWckJiOG9O?=
 =?utf-8?B?aG82a1R2RUkzbDdHeVJNRXhiR2ppbFA4V2pUTTQzdTl4YUZrOGFuaUx5ZUNv?=
 =?utf-8?B?R1h0SnZpNXVJQUhMV2lrUGRFVmx4eFYxVTVvcDBhR3pYaU9SZ2M1WFRtVDNj?=
 =?utf-8?B?TmxLb0NKTDRuZTR6Mm1TYjE5M2U5dGV2L0phT1BsOWtJS1hodFhkN3VDaEdw?=
 =?utf-8?B?OFNqbEtTa2pnMkFUYWFNamJ5MGU2R1ZrbVVhRm9GVjRLT3dibXBnZXJTRy9s?=
 =?utf-8?B?TFRaNXF0dElKZ1Q0TUNTbnI5Sm15SUhkb2cvdVp5MUU5eTAwWnZvKzBtTUNV?=
 =?utf-8?B?alBoeEYzMGNEUys1MmpvaUVUQmdFaFoxQWMvZW40ekdhSkRPRnNDTFFqUENr?=
 =?utf-8?B?bG1XZmdlSWVmL2QxZ2g5ZkwzeUFCdHlOaG16eWowVFlIdFVGbnhxMExyUzNJ?=
 =?utf-8?B?RWtnTGxXcllwRXMxeFdvcFVGbUt2bGdZeVlKZnZaQU9pS24vSzNlMUlsKzZF?=
 =?utf-8?B?NEpocGNyeUw1c09pSXBUQlRXWXBCYndWVFpWRzE4WXBGM2hOcHNaUUc0cmV0?=
 =?utf-8?Q?CAUk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cW1WMGQ3S3dqTGx5YWQ5SURpRlBtZDdkUzB3bTl5aCs5QVVKVnRabUdhUS9l?=
 =?utf-8?B?eCtjbnpPR3VGOWdYNHoxOGFJQnZnZWR0bkl3Vm9VeC9UWUYvT1M5a2ZwN2s2?=
 =?utf-8?B?Yjc5VnRhRXkwbkY2MHFlc05pTElLTy96d1lhaEpyUjkxYTE1dVFzbFFERFpM?=
 =?utf-8?B?cGdNSExDQWZ5bURLeGZ2Wmx1MlF4UVNKWVVKRjkrdU85Q1VrRzZNYnovM1Ev?=
 =?utf-8?B?VFI2dERmVEN0dVh4emdCS01mV0NaUTBuY0hDY3RXMUt1RWYvWW10c1RBWEFl?=
 =?utf-8?B?VXRSRmtvbk52ZjZWYng1Rk9tNTQvYTZwdTFCbHZWYldaUDlGUFl2YmNRMzN6?=
 =?utf-8?B?WkNVNUM1UGN4Q2xyTS90N3lmaU1McVJUQUd5ME5ramI5dEZibHY4NHk3b3lS?=
 =?utf-8?B?cHFrR3dsSUNUeXlQbjgzY25EbytKOVc5Mm9KazZUd2E2dFBIOGM3eWpJZ2Vz?=
 =?utf-8?B?SVNSNEVtL012VEcyeWp1UWhUbnFiQXJ0RFNjU3pxeGhSaFROUVNpR1B3L2pp?=
 =?utf-8?B?R1owY0MvRlNZcDB6aHJReGd0MDg4cjlKY1VlSExnaElEM3FVQnJTMEszNExI?=
 =?utf-8?B?OGxxekdvSzVwbGwwVloxL2RMRzJ6VWhsZmMzSG0xdzJhU1ZqWXJzSWg1NzJS?=
 =?utf-8?B?UkVuekxXcUpUbjMxZW5Rb0g4S2VHNUk2UlZKNUErQnh3ME82LytEWWlIVXVS?=
 =?utf-8?B?VDM3Z2E1THVQTmdjc0wwTFVWVWRCSjRaL2xud2M3UHFBb1hWYVphOWN6R1JL?=
 =?utf-8?B?SzB3VkJpcEZjU2NFaTlzUkhSUzEwRTNuWlozeEw1VlE2ODZzRmxVbW4yQ1l3?=
 =?utf-8?B?SHkyYVZBRlFSa3Uxc2dDb1d0TUxBbXo3T29JbFNFQXZHaHlIVEVUZGszOFRI?=
 =?utf-8?B?SXE1d3hqUU1IOXMzTGxqMldLUU1CYVFsTFExNGdTeU9jWmVVSFExdVQyQ0hr?=
 =?utf-8?B?T0xuSHNpWCt4VHI2QVhXOGNrMmkyWi9TOTlobktNdUxhR29aa2dvWHF5N29a?=
 =?utf-8?B?azF3b3BjVjVkK0FheHJCYW1nZ0hNRlBJUmp6Y2RjQnZVZ3dSV01pZ3FlQ1RX?=
 =?utf-8?B?dFR2Rm1VUCtUVFlMQy9mTHhUU1ZuQzNlL3ZRN216bVU5U0ZaWUxBN2tNRU9h?=
 =?utf-8?B?cXRmeExEZlNXTHVOUHgwZWt4NWs0ZGtSaWFHVHBXVkZOdEJ1RUx5NU9GT3Vv?=
 =?utf-8?B?NytCUHcySkhmeC9uT3puL2xycytDR085NVJMb01SZjBBYkxJSHJ2R3NtTmJJ?=
 =?utf-8?B?L2hVVVozS3R1NzdWYkpheVpiOSswL3lwNlJzMFJ2SDJqMHltWkVac04zK3NV?=
 =?utf-8?B?aXRTampsb3FwOEw0eFhUY25HR0tUd09FZ3phSnBmcVBFRURJSGpiQnQ1cEt5?=
 =?utf-8?B?Y3prVElMbHhEN2xwNmFhcnQyRS83N1dSenNNOC9zejhUQWFtNjBZRzF1Sit1?=
 =?utf-8?B?MG44Q2c3OEUrR1NsRWNZMDlYZFZiUzdSNm03WEZiRWVnbWJEUXhjQTRBZXpF?=
 =?utf-8?B?SmFSRFZXblhxSXEyVStOUzBBbFFRbHFFbWVjRlQwcnRNc0c4OVlaVWZnZ2Vr?=
 =?utf-8?B?SzU5Um5NVjZhV2JneU5RMHZ3Z2JaT1RzOVJqeFowMFJESE5hbmd6di91dldy?=
 =?utf-8?B?NDIxQ0FrOHVpY3NpOTR3dTRuZHJjREVReGpjZVhOM2tnTk1mR2tvdjdHSVlD?=
 =?utf-8?B?dGRGUUMyQzN6NEVHZGVFL2xSYlIzYlRUR1VXdERCSU9mV0pqeTBmbWZrWEMr?=
 =?utf-8?B?cGNuQVp1bENhSHZCR0xVRzZMLzlkQ2g1dmFBUWhUWE1Bd2NaT0Jrd2Z6a0tx?=
 =?utf-8?B?cy94RHBZMEpiS3hSZFdUQ25ZN213eFdENTBmek8vSjdycGljMjQ3bW5KaXc5?=
 =?utf-8?B?aXUxUGdwditNanNCMUZPcXk4VnZrUk93UGlhc2s3a1YzWWdLNW0wQVRoNWpv?=
 =?utf-8?B?aVdaWHJSM1pVSGM2cnJLWkN2Zm82Qmlmc0hKUlJjMjlxMWptNEx4Ly9SQVNr?=
 =?utf-8?B?TGJTOFNKV3R6RUxOcGZaUGJGZ2lVWDV3NE5jK09iSFFQTkJSSi9OdXVod04w?=
 =?utf-8?B?UG54OWZTY2hiaGNZaDdqeW9nbVpUWUJRcW5qL2JlTEpiMHdEZ0wwdFMySUZp?=
 =?utf-8?B?SEJ4dVJzTVdVTFBnbU54VlBZTCswVW9MbHl6SVd0TC9qUUx4MXBpYkFNNVFI?=
 =?utf-8?B?VjI4eVJpY1lCOXFqQ1FMNmJ1ZUtpSjdTVllMSGJRbXJJeDVmck95WFJ6TnU5?=
 =?utf-8?B?UWEzUW02N1RYUElJbzBXVXBvYU0rcnpNOG9HdU1IMFBVT1hGUDJMVTB0a2tk?=
 =?utf-8?B?bENWVlVuRS9uMVYyNVVyQnhKNHlGVW51UUJtL3dTWGtqQmdvTDhWbml1M2t2?=
 =?utf-8?Q?RuN4qNBUM95zKcYI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 39a1e462-dfd7-481e-4852-08de547886b0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 20:56:16.7265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xVhodGO75/65L6Syp48aMKJan0E6wSCFtt1OLmUkbLkIWBVVc9eNCLu8dlHcnIRx5qAQaTSv9/JkPugFurm4r/8JlWF4/a/CUaH0kTWAK4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4804
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Wed, 14 Jan 2026 12:20:36 -0600
> Terry Bowman <terry.bowman@amd.com> wrote:
> 
> > Update the existing 'struct aer_err_info' definition to use kernel-doc
> > formatting. Remove the inline comments to reduce noise and do not introduce
> > functional changes. This will improve readability and maintainability.
> > 
> > Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Hi Terry.
> 
> I didn't check but I think kernel-doc script will complain
> about partial docs.  Other than that possibly needing fixing with
> a trivial entry for __pad1

It does:

Warning: drivers/pci/pci.h:764 struct member '__pad1' not described in 'aer_err_info'
Warning: drivers/pci/pci.h:764 struct member '__pad2' not described in 'aer_err_info'

...those are the only warnings in this set. Btw, this is my hacky script for
checking for new kdoc errors introduced in a patch series. I assume the
0day robot has something similar. Maybe something to cleanup and
contribute to checkpatch:

KDOC=~/git/linux/scripts/kernel-doc
for p in $(stg series -A --noprefix)
do
	echo KERNELDOC $p
        stg goto $p >/dev/null
        for i in $(stg files --bare $p)
        do
                # only show the new errors relative to the contents of
                # the file in the previous commit
                f1=$(mktemp)
                if [ git show HEAD^:$i >$f1 2>/dev/null ]; then
                        f2=$(mktemp)
                        f3=$(mktemp)
                        $KDOC $f1 2>$f2 >/dev/null
                        $KDOC $i 2>$f3 >/dev/null
                        diff -u $f2 $f3
                        rm $f2 $f3
                else
                        $KDOC $i 2>&1 1>/dev/null
                fi
                rm $f1
        done
done

