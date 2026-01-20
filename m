Return-Path: <linux-pci+bounces-45229-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E4620D3BD7D
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 03:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6483E3001BD8
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 02:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AC71CAA68;
	Tue, 20 Jan 2026 02:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OpDDz0xM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6121A238F;
	Tue, 20 Jan 2026 02:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768875635; cv=fail; b=olnn+ZZte83CEMi+bbScHl8zn6hGoes33gwFOT59t3wi6kv2cKKAc3aOBFzJO9i7yeHmtMY1ImLzo5/TklVlzMFoFqYZXViLBpJTvSduLKQGey9DseoNlpeSnH2K/p+e9gnUscIa1xVzR37DWuYP06NlY37lu2g0InJZy6rLZzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768875635; c=relaxed/simple;
	bh=QpqehQs4YqfDqnX04Es3KKUhlyue6QdKVeKJrJkGsSU=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=t+EaDTpE3KqBPpuS7YM/aMVsia1n7yv5VE1Bt7nD4uTNSxt8ZCsOAS1sE4JwsVoW/RcyIWb7Gd/+Fh4mPrb8wxkaHcqhCnEVfVhLLW/XxPXwYQzOYg7CabyUSSez7flfYXM2srzNQ+RqEJidOLnyeHxsX6mAzFFdF+8kGHFaYWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OpDDz0xM; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768875634; x=1800411634;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=QpqehQs4YqfDqnX04Es3KKUhlyue6QdKVeKJrJkGsSU=;
  b=OpDDz0xMYpJpRk4fv9bNHzTQ+nz1sHjZRQs7Sj+Nr3+HUjxUEIn8nixN
   aLrwdQ0QLb7lo1brLJEiYlQ97joG10kIWkUdWHJYJKNSIVMOqgsZsisbM
   Nyg52g4Babg2u6Xua0Bzjev6c8TaLbV4ABw5FIQuaO9e5wQWOheCeIFMP
   Qt7eFWZyFHzRnpwqD4Wk4OcEOWn7dAGQkta/kvAgGmiKPVdE2pt/EyJeL
   l5YoJwQNcXYOiBNmtQj6bfz1LhnQEVSnLIJfJxEtjfCQJpGVN8Uum66ki
   QSoJjO7CiyhFPKNjoQcjokOBcYATtGEYxUzfW3qoJqsJkT4NmMYjMuhMZ
   A==;
X-CSE-ConnectionGUID: dPPYRnkUTIKcCkLgNCOkWA==
X-CSE-MsgGUID: YwHlafULRcGo6Ys+YB+mtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="73936103"
X-IronPort-AV: E=Sophos;i="6.21,239,1763452800"; 
   d="scan'208";a="73936103"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 18:20:33 -0800
X-CSE-ConnectionGUID: QZNNgr9HTTOLJuZKa5qgmg==
X-CSE-MsgGUID: jL6Cj0d1Tx2UKFFH18mkTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,239,1763452800"; 
   d="scan'208";a="236672794"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 18:20:33 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 19 Jan 2026 18:20:32 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 19 Jan 2026 18:20:32 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.69) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 19 Jan 2026 18:20:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DKWqmao6Nh3sjnV5KrWP4UZr5OgCVSwM0EJb59qf++6wV8idGoWe59nZ33LtSmxWny5/09kT74qq0lIUpFczezmr5w0GfWDKvlJbPzZUy2AbcWS3n3QqkvHwNr9fTE80lVjvBEXni4XRi9EzPhKSO9rt/GZVsuFWa8E/ioVrn0N4EP+Dow6nhyquUoysQCNzP/hBxM+a7MNKkXF219c2o5uLwO9tX3h3bh9+zlYeYVTp0GdvXDIhFRt47wpo6IdV/v62EYrU6zUqzEbKivhA0K5IQzFONgh9W0yoOe4ccCuUJ3bcTvGlif1cK8OIdefKEhKYJdoTYbu09QEma2Uiiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ts7UYNc8GbSraurg2YtaAQFkhKhmwNUJGpt1/TRw/XE=;
 b=hFgmLk9RB7rfgj7nnjq4U+Zk38B0nRzcYYvqh2xc0yE3881pfnZVMXvU7FLpLZe+Fn0v8fG/lbtZnQy7IOQKhs9So5qFSn/qbs6qUSzuD5e/av2a1/VclOVwPW11fmcqiBSDOZBD6QEj2QGhPP7Blm8eWLoVesVJmdd7aMjKOu0m1JbyNMa63QU7YTWm3QTGXAWcgjWVFmRKMKdsmjNRKY6uvFL0fY/9QvlDvmRLbfXVxqEO1tBzHVW4C1JOn2Jml5rD594jaN+VIboloQELRI9biNziVCO1xdh4W3e5R1rJnMJ9xCSbLCkh1viYjP3yFoK1DsEpxHu797Kr0Imypw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB7443.namprd11.prod.outlook.com (2603:10b6:8:148::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 02:20:30 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9520.005; Tue, 20 Jan 2026
 02:20:29 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 19 Jan 2026 18:20:28 -0800
To: Terry Bowman <terry.bowman@amd.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <shiju.jose@huawei.com>, <ming.li@zohomail.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <rrichter@amd.com>,
	<dan.carpenter@linaro.org>, <PradeepVineshReddy.Kodamati@amd.com>,
	<lukas@wunner.de>, <Benjamin.Cheatham@amd.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<vishal.l.verma@intel.com>, <alucerop@amd.com>, <ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Message-ID: <696ee66c85a1_34d2a10020@dwillia2-mobl4.notmuch>
In-Reply-To: <20260114182055.46029-11-terry.bowman@amd.com>
References: <20260114182055.46029-1-terry.bowman@amd.com>
 <20260114182055.46029-11-terry.bowman@amd.com>
Subject: Re: [PATCH v14 10/34] PCI/AER: Update is_internal_error() to be
 non-static is_aer_internal_error()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::8) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB7443:EE_
X-MS-Office365-Filtering-Correlation-Id: c2d42f48-71fc-4c69-40e7-08de57ca7b4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dzFsNU5VOWhGZUV5RDVlb3RvdmNaaTVmcW53N2xlTEticmhvTzEwTFRCd3NF?=
 =?utf-8?B?cjdUU3REbS9tUHZXbWw1eTJrRFg2U1FBdXNXRGlMUmZEcnl6LzZRWklmTXJ6?=
 =?utf-8?B?RC9xTmpiYWxIV2Z2MHI0MXp3WmtLOTdKVkl3TitnMENpZnJxamRnSWttSytz?=
 =?utf-8?B?ZDZtaUk3R2xLNnI1bHFkd1FIcVNyT2ZMbDJidkdJWnJ0eXR3Q3hkeUZXT2JU?=
 =?utf-8?B?M3BNNnpHZGtBTlMzZDdacnpkUU9lVUpyd2k4WFBnTGZmK2w1NFZrdEZYUWZ0?=
 =?utf-8?B?S0pDbFcySUVVN0xGMUNxcFFvV0l0bWx2T0o0ZkpwangwSjgxcENUS0xqaHpO?=
 =?utf-8?B?dW1RbElEbWNEWEFUQVdiWUhlVmlpZHJ5djNsUW5Yb0tWSjF6dFRua2pqeFg3?=
 =?utf-8?B?WVJjWlFFNFdWaUN0bXFHMkhVN0Nya0lDOFVSWnVleGhPTjdRTjRoY2tpYi9Z?=
 =?utf-8?B?SjJJK0NQTjBucjFIVWhOMFFTL3VTT3dXaEdZakNmMElpaVd3cDNFeWRvLzhF?=
 =?utf-8?B?NXErZXFtUEF0M2QreWF2ZTRuQjJTSnlQWm5ueUFKa0Z4UHBiTDFEZmw1V3oz?=
 =?utf-8?B?SnV5Y2RSSmJ0UjViVGVOdFcyZm1TS2MxRUJ3Uld6ZTBKd0o0M2ZxTFFZRTJw?=
 =?utf-8?B?dm5hREtPeW5OcUtiQzdpTTA0eHBHQTlMQlhPM3dxV0hSTERPNGl6WC9WbVBs?=
 =?utf-8?B?UFY1TGsrS25QZ1RLdngyT3A3dnJTODRlVWQwRFhGckpqem1qWGp1SWM3QVpF?=
 =?utf-8?B?Uk42NVJvSjZGOFUwM3NhQU9ad2V6MXFYR09nalo4ZzRTZDMybFNFeC9iMk9Y?=
 =?utf-8?B?cXdlU20xUTZUcmh4OEF0NGlvZ241T1h6QzdMOXorNjJ1VVpYZ0lLbHJvTWFO?=
 =?utf-8?B?NWxvVnphejMzYnJtbGtuVE5IcWZCNDU2aUFkZHRnWVk4U1Zwa240U3pJV2ZF?=
 =?utf-8?B?Mll5M3VKSzZVUUpYTnB4OGQ3RysvbEVzaWd2czJrUlJBU004RFphK1BUTzIv?=
 =?utf-8?B?UW4rckREbTcvSWpyV0crTXh3dkY5b2xHL0hsVGNuZzhrNnViSzVtMVlGcWd1?=
 =?utf-8?B?cDdGaUM0YjFpRDlKbUxzZTl5R2U1VS81b1hsNW53QlZxSXd0ZGFtSHBJbU1I?=
 =?utf-8?B?akwrTWl3LzhKNHVxc3ZlQzhnc3gzeXpQd0RBTnhjSkJmTTFkMDRsSnQ1OFU3?=
 =?utf-8?B?bmJWbmVqN2IzSU1tb200OWtVTEpuUEtUaERvRzZFN2E0cXdNa2RYQ0dXSmNP?=
 =?utf-8?B?RFRLYnVHNGhPTGRZTWRuRUJOaXJNT1pEdVFOZDlPa0tPL3NyMHYxTXoxMlFm?=
 =?utf-8?B?Y1lINW5OY1NIcWFMZ2hBeDJFaTB1RWhydHUvV3hKV0pyOWlUR0lLTGM5S05Y?=
 =?utf-8?B?RmFCdmtjelRMSzdiRzZrVnVFT0ZzcVZqbGdoOWU1QnltMXNTYkRlbGxRNDg5?=
 =?utf-8?B?a0s0eFg4cDl6RENPQU5zeEZ6RytYU3NjUVRzdjFDTVRKeTZJdW5sVS83QVMz?=
 =?utf-8?B?Q1IvTFZvMWE3V2tET0FjSUdmUTJvditoSDVSd0creHJscGRaVEdtQVg2ZUt0?=
 =?utf-8?B?TTB3b0ptOThGZVRna01tc25qdUkxTVZEU2lkMGZycnlTdkU0NFp3cjcwUmty?=
 =?utf-8?B?U2hMTnhPcXluU3BCcitVODdqQkY5anhsSncyMWEvM3ZXS09mYVBickc2STlC?=
 =?utf-8?B?SDRXNVVONXlDNEViUlRDaCs0S3VkWlZSTUErbVNOVCtsakdIUjVRQWN6c05V?=
 =?utf-8?B?ZEZxSmJsbkhRdDFyRERPa291aTgvUHZOVzJBYy9rUkh2bFJUUnVlRG5qNmFH?=
 =?utf-8?B?a1F6UlBNM2hneVEyckVmUmEvMEFHdGlFSnkrVzJ3dW52dUFlOFN0ZzgwTGpu?=
 =?utf-8?B?azMrQWVtNXJXQ1pNeUlGT04xZkc5T0JCS0VQQkRYWGd3TU12QUJkRGJGUWtO?=
 =?utf-8?B?MVo5T3U3Vmg1Ni9hZnV3eXpDNHM3NlU4dytnaWw2eWNPZjltcFlXd2lZRHdw?=
 =?utf-8?B?SDIyWUFKZyszNXdVcCtIeDgvd1ZZWkhJaHNNeUFPaFo4Vk1YRy9rRkV5ZXVx?=
 =?utf-8?B?U3pvOHRiWmFrdFc4Nk00NS9YVDVtM0U2a25oSHZtM0NDODUzZ3hPMmlYOHF5?=
 =?utf-8?B?Z0VtY0Q3S05meEdhNzN0TWNlalFYcjIxZHNPQlZQb3BMZHVNL05FQlpWNjhC?=
 =?utf-8?B?bnc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzNFYkhBLzlKVVVYa2MzRVhwalRWTkxrTUk0S3dwNjNIQ2VBcXRuNlQzQmxq?=
 =?utf-8?B?cENySG9aRTU5ekgwemh0NFpqejdnVm41WXQ4eW8vU1BzL3NaWDUvb25lT0Ez?=
 =?utf-8?B?clNNd0I2T0ZHV3JodHYwVWp2SWNQeHNYdlBmbzJZdEhnbVJFM0EwWWVkbHYr?=
 =?utf-8?B?U0QxbXZqVFZJbU15MWNZT3JyYWdCZVExMkZPNEFZT2loejNoa2hEa0JIWkZE?=
 =?utf-8?B?OUlONXZ3cW9udjFVcUN2RFF6YjkvQkhXdlYwZnhUNFpuRWpYWnFtQVR2WFNS?=
 =?utf-8?B?eHBHbktCTVZaV2xBdzErOERjckNEYzE1ZkhtWG8vcEdSalA3VFVNUkU4SXds?=
 =?utf-8?B?OU9DZHBDd093bXlweS9XdjhPWkZWZitnYXRiNW9CQzhXNkRUMXNNSS9HRXY1?=
 =?utf-8?B?NGhVeFp4cS92MGV1SlNFTWZwR095MFlGdkJVZG5ZMkxJZUxqSTZPblpMdkFm?=
 =?utf-8?B?QWdacnA1bi9Fb2YxSmNqN2VxWEFEdkVXZzdPTmN6anpVRUUrNUFvOU1la29i?=
 =?utf-8?B?Y1VUcjNsdGVSeWJLOTRNUE1JOG9CTWZSdjdNaXA4LzRXNzJCSFhhWG5xdDBv?=
 =?utf-8?B?SHR4L1NJanA2MTlEWjR1M0RSQ2xRZUFoUEJlSFNwVE5JQUsxQmNqckpLVUlq?=
 =?utf-8?B?Y2dQYnZiSGRpTVNJUm45RXVxWVhITGFkZ1F3SnAyZklRdzBUUGNJQXNWRmo2?=
 =?utf-8?B?dG1adlJWenpTWXhXQXUvaTFjVDNjSXlHajJGazExajh4amhqejBSTm9GZDJy?=
 =?utf-8?B?ZW9RWVBaSG5JR2xKR25SSzRGK0dURDhsd1RubnZWeUhhMExHVlhpQkdUVUZm?=
 =?utf-8?B?WUc4eDhBY3g5dWpZcUZ6RXNVb0xUcnNJS1FVUzhCY2xoT1hpckZXNTR2UjAy?=
 =?utf-8?B?b2EyT25EaHRXakVnRnhaYlN5cUY1NXJKdklvN3B6YzJ6dXpYcjdRRUxBOERC?=
 =?utf-8?B?Ny9tckdvTmpsVmx2RW1QdGZrZHJHNSt3VDVoQUppalRSZEIydkxobnNnd2FI?=
 =?utf-8?B?clF5V2dtNkJQdXhWZEJiL3Zrd3pIakZJWFJ2eXcrVkt5d0V3bHdxaXlhNE9h?=
 =?utf-8?B?cGpDeitNZmJobmM4UHJSYnNqV1U0QmZlNU56ZG1qQWFHVWNuajVyRWV5cmxq?=
 =?utf-8?B?K1NIUHAwSDdsa2k2WmxTUGJsK3Q2ZTJFajZJUzByU01McDNiL1A5SGwyZVpx?=
 =?utf-8?B?dVIxQmJsR005M2JkT0Y4WFBhd2NSb0tpRHZYa1RrK2k0dWZpT3ZKTDNybVAz?=
 =?utf-8?B?MTlDM3Z0QSs2SjVqdVJ6L01qWlBwSEdFTGwrcjVmRC9NTU1Ta1RKZnkxdzha?=
 =?utf-8?B?dzNKcGVoakFyUVRnUGY3TnkzVmQyMXNTZUsycU8xRjJVVG5VS1ZlTEpPUFFJ?=
 =?utf-8?B?bVVjYWpqWUlwZTg2cWJFUURteFhHR09sNVRYcUxYam9RbXZBUnFUWDJPSkp3?=
 =?utf-8?B?QU9ZOGtYRzlCdDBYVURVU3laZDNpUVVBYUY4THZuSnZ4ak1URHFxYi9xQWF5?=
 =?utf-8?B?bk1MVUFUcHRhSm93eFdWaDAzSE4wb283ZGNWUTNzTFJnRDhrZjVMTzZESDZV?=
 =?utf-8?B?N1h4OUh5VGg2NzRtNlBRc0VRRHllK0ZoeU5MUEpRb29FR0xQeHBtN0JzcjQ5?=
 =?utf-8?B?bW5tcGZjWTgveC9aYk1UaFRIYzEycEJRWERBeDlCRmxzdFBydzlZdE5uVzRz?=
 =?utf-8?B?RnZGUFRTU0UyZkgxNjg0RXRvUmRUVjJicWJ3eFIzQldkMjlJbWwyV1FSQUF5?=
 =?utf-8?B?YndFaWV6MnZhSzlGZkVSa1p6YzN1MGtvTFVCYWttQUgwV0UvTGVIcFlFYXFW?=
 =?utf-8?B?TzZHRmoydkZHeU5GOXhVTEVpcTJnMjJtWUVzOWZJZEMxM3N1bkJqMllYMlE4?=
 =?utf-8?B?U09xYTVsMnJvOXN1Vm4wbGRsTVZmQTlycUlxK0F0U1IwNFB3QmlDRjVQUkxH?=
 =?utf-8?B?eFd3UTVLclJFN0lIUXBNc1NjVGZKbTl1RkdaUVBKMS9qbzVqbjdqemV2cGFp?=
 =?utf-8?B?ejAzbENSNjdXUG00bjFhd1FYY0JIOUQrTlJiZm84KzJXYUhDbi9mK3B1Mjhu?=
 =?utf-8?B?ZlFTbU92MXZqM3NCWkU1STd4Q2R4NGpmSllYTlNwdEg4RngrWmJJVmN4aXpG?=
 =?utf-8?B?Z09PLzBNb1dDVEpVakJWSFVRL1hTRFIzQTFHb0VjVVZsSGxuWE9nVXJ6OEsv?=
 =?utf-8?B?azNNdm1DOFFlVFRINWJJS2M4eGZTckF0cTJFaUJYL0F0QXZ4ckhYV3cxTE9h?=
 =?utf-8?B?VW1ibUlxZnVTNXJVYTBZUDk0dGlGL01aZW5XVGw4c3NsOUlHVWQ0QTJIN1dU?=
 =?utf-8?B?czd3THh2OEtKbjFhY2NCNWxzeFZhY1poODdEcEppbWJsTG5TMDZDVTlTNFN6?=
 =?utf-8?Q?n3VEBQlB9hEmpViY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d42f48-71fc-4c69-40e7-08de57ca7b4d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 02:20:29.8666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8qGrrG84GE1xkLdt3o8fzrtt2rmZcDIenNFPSme4xgC7/h/muTgJdTnkvsu6/5PEsl411AClvRfaLTWwp6Nz9IAWNYOK/b7r+cbodFnk4mA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7443
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> The AER driver includes significant logic for handling CXL protocol errors.
> The AER driver will be updated in the future to separate the AER and CXL
> logic.
> 
> Rename the is_internal_error() function to is_aer_internal_error() as it
> gives a more precise indication of the purpose. Make is_aer_internal_error()
> non-static to allow for other PCI drivers to access.

Not even sure this rename is needed given that it is private to
drivers/pci/pcie/ and the sharing is only for cxl_{rch,vh}.c, not for
"other PCI drivers". Consistent with the idea that internal errors are
not going to become a first-class citizen let us keep this a CXL-only
consideration.

I'll update the changelog to drop the "other PCI drivers" comment.

