Return-Path: <linux-pci+bounces-32087-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C60BBB048D4
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 22:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBA4C1A66377
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 20:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F8B238C2A;
	Mon, 14 Jul 2025 20:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dyuYM7Ur"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44DA341AA
	for <linux-pci@vger.kernel.org>; Mon, 14 Jul 2025 20:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752526217; cv=fail; b=U8woYKV5Uerguuo5XKlM/6hTozGDEst7ksmI+o2dZFuR2kMeuI5gyUMPsnVGup7grIAPTJpCX2qaeJwUfI/zmFhdGfmYOTf5hBftYmka/G9SnWE2XLM3uj1Jg2U+Tz4xlL/4sEp88f48qWbQxfIjytAURNlourQGtcKwkHRBcTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752526217; c=relaxed/simple;
	bh=UnHCU4CLL1nuH2ljMPC66x84QtC76ALz7Vtoknw2dio=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=WqFA4SB4Cs7I8JiAAB2LN6mfy10j17YXTMVDnAQuY44PXFuCYCrJZOkj/eMM6tT2JsWMPYPCQZs0GeYFnp8jleokByG8eUjprzff2NbO/57GbrQ5EhbK6sYBHSRGVI8XhrZF8DQSAdnEQRfn7UmX3mNoDppidvJJW4dbmHYLd4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dyuYM7Ur; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752526215; x=1784062215;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=UnHCU4CLL1nuH2ljMPC66x84QtC76ALz7Vtoknw2dio=;
  b=dyuYM7UrWZ3C+9P7L01p0k/Gyy2tvV1Pk/8crpLpJgWK78gB8c6dI8jM
   cB7525hd8Ty0W7KAr4ZwXjCX7Lh7koPRgsunQLdpG4YNRWSXpXtA/5P8P
   Nrs9tskyOYh/nsjd8PgrxFvggewWIIUgObf/cnRsA/ZlRvwM3VdKQbLsk
   xFrghAjJwuyXMLJkxq7H8btq4T3jRUkdcbQ4ZI5EXxtN+AQDDwOODfY7Q
   4kb/lJ0oGHIyfXaiEbkfTB2eW/MPECjhcmYxCf4vgjkSAHN+EohH9Awcn
   m9tss4q4WufuJjc9rUIxDY5Ft0M9WLvTkpto7iYLSWGCSGRe5w36H8sqV
   A==;
X-CSE-ConnectionGUID: 7j7ZGhVJTaKMJU8+zdizyw==
X-CSE-MsgGUID: BChyNabOSZ6CBXakkqeoEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54878016"
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="54878016"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 13:50:14 -0700
X-CSE-ConnectionGUID: lxZxgSwFSlyls43LUZwIQA==
X-CSE-MsgGUID: MrSa8kwPQnyiGDsz4ZBUAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="188031747"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 13:50:14 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 14 Jul 2025 13:50:13 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 14 Jul 2025 13:50:13 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.71) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 14 Jul 2025 13:50:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pmk8Uiv2XtkRdtO5uO4Td+VPjNi9Xjw6LwBs3LUFCzY3ApsGtg+Bvvwcv+Kh715JEm31YgYz8D1vLrzjbdXRCJjqv85dADp2Whbq4evqO3LvimIkngbei+UMxmfCErUlaDXAyhyQWCw0Nb0+E3ffNLwnLo6FGdcxuj7LYkBaC4MRny9AZZXBQWFJ5UqvgLuJt6xqBqvYr+kxqooDzgjNs2yg0tqxO1Q96fpNU4v2IkwAo3HowJmkqeaYQS/0NiUF8JTP7I+dztw/Kq6vXHKgTybln14YI2LF4KEZ2/ty3+b74MT1RQafrQVMrLKXgtPZkuNYRY+jseAUZAZIXOvCNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YOjgFguVyyWsDTIx3t4FUMIOSmWfoXCTIOugHMU+9uk=;
 b=YDHKUVz/0f2Vk1RAkhOB5AYtpWBZp+gfmCoNsBHKr51ThVnG+VD02GC3scod226xEQoqYbbh8ixL7mzqimJtJF4mHj8wHEg50U8BB8WF1YYg9iw0uIVzyhVN0uNfPof8nUqTUNzNBroJQfmdDy6vBcYzSirP90K6ycRl/jqQiF35OcrcWSY/Irny/cnALkw+Rxsw/DeOGU9aSoBTQn+pxkL8sdoN4KmiaeEzF/vvujawNd79ymMvnGaYHdERSVH9Riy9fTRP0ni2IEH6M80JihDOotSECa4pjZUJu8ASW1u4ZClgv/d9/xBqjOPYjgBMepS+TU2AmziqvtQLtl99CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB7856.namprd11.prod.outlook.com (2603:10b6:208:3f5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.27; Mon, 14 Jul
 2025 20:49:29 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 20:49:29 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 14 Jul 2025 13:49:27 -0700
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, <lukas@wunner.de>, <aneesh.kumar@kernel.org>,
	<suzuki.poulose@arm.com>, <sameo@rivosinc.com>, <aik@amd.com>,
	<jgg@nvidia.com>, <zhiw@nvidia.com>
Message-ID: <68756d5754f81_2ead1000@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250617152157.000048a2@huawei.com>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-11-dan.j.williams@intel.com>
 <20250617152157.000048a2@huawei.com>
Subject: Re: [PATCH v3 10/13] PCI/TSM: Report active IDE streams
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::13) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB7856:EE_
X-MS-Office365-Filtering-Correlation-Id: 00aa3aaa-dd36-4f8d-ec33-08ddc317ed99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S2N2c2EzTHJyYThsRk1UaEkyNDUwb2tJdkZNeXRxNlphV1BFbHNYbU1DeG1p?=
 =?utf-8?B?K29YTmdyUnh2c1NOQU1qMFkrKzBEZGJNOU9OYThCRFN0cjBuMEV4MFpEcEZr?=
 =?utf-8?B?TXY2NzU3WHJSaHpVVFU3UzNyK05wY3I5S0pVdVpjVFR6MGJOWE1xQ3IrMkV1?=
 =?utf-8?B?OU9jcUFKNTk2L0ZLWWhHWUFsQ0ZOYkVHU0xTU1FNZ28reGpmdG83elhYYVlG?=
 =?utf-8?B?MHJhSVhqVTJtenAxK000RmdiaUd5ZlU0T3N3U01RVUJ6SHdrejk1N1FHSnVF?=
 =?utf-8?B?Z1gzRm1waEV3T1U3ZVJUZy85QWV4OGFLTEJNRzRtQ0t2Zm4xY1pSeWF3VVNx?=
 =?utf-8?B?VEtZYTJaRzlBMXcyZTVjd3pUckJNdWdvM0MwSVVaaWwzd2NOc1dMd0xCc1dX?=
 =?utf-8?B?eEI0dEtNV0NSWGY4QkVUNlV2VmFGampwcXJTdXZJa05XL0ZiMGcwbmFESzkr?=
 =?utf-8?B?V0M4Y0hyZVhKWjdDV050d1NkejlaTzZDcVRZeWxDSjBFTjdGcFczM1IrK1hv?=
 =?utf-8?B?eXZkYS92ZzJHN0pzY1hIaFhRN3QrOHlJYUYwZksrTytqZkNIamMrUS9SME5r?=
 =?utf-8?B?bnJ6QmQ5c2QvUy8zaGdqT3JGeStTUjhycDlZRlcyYjltcGVtNzB5d1N1b3Mv?=
 =?utf-8?B?MTJnS3RGMHNDSFZzMm00eFZEN2FGeWNwTjFKQU92WHZJaWhPRWtXOW5NYkFY?=
 =?utf-8?B?RUR6cE5LK3IwV0lGcEtlRjFIcTJodjhFRWhsa3gyS25WSTRnT29IbXp4UDR5?=
 =?utf-8?B?QmFnTHVURGJya3RoRlRnZGREbkI5aGZURzFGbklKTzBWamZUV0p5VHlhQzlJ?=
 =?utf-8?B?eFhLRmU2TEpBUFF0NCtMVmdzNEgrc1FJbHNqOVd5Q1FBK25JTStyYm9TZFZG?=
 =?utf-8?B?V1ZOeXpoQlcxeWtaQkFvOGUrMW9EdDdLank3czliemZFOE0yb1dGUlBWeWQr?=
 =?utf-8?B?MzBtYjMyOGd2OVAweERFMlpNTGhxZCtwWGpHMHR6a01NOTUyRTkzN0JDRTc5?=
 =?utf-8?B?ZlBBNGx1U2x1aG00VGY1dEJhV2ppWU5XeVJHdlF5c1c0WlZ5QVo5QkRIWE1W?=
 =?utf-8?B?M3VObzc3Z2ZINzQycTR4Z3hEWE9LbG1wK3FSd244MXNoUVgwcnZEWGhoR0Z3?=
 =?utf-8?B?MHJnU0ZaRUNreGY5MXNqLzZOOHhHcEsraEVrdnVaWlhFWTQzaWRadkpoMUgy?=
 =?utf-8?B?MWdTUXdQZTd2MjFzT1AwMFF3dGIzdGhwTVRUN25Na2dFcGRha2NjRlAwcHAw?=
 =?utf-8?B?dnJER2dBTmo1YXpsQllHc0FiZmhDNG1TdUgreHN0U0ZJOXBMQWxFNit0U3oz?=
 =?utf-8?B?RVhTOGxSMG4xNkJBNXljTGNyL0J2dGN0bURVTkEyRUxSV25jYXhidWp1WUtP?=
 =?utf-8?B?VWw3cUxnVHFhSHRMNWt6VUlvd1dhcjEwUFlqTUtxUjRZTm5JWktGcTV5YmFD?=
 =?utf-8?B?akdzTmZuSzYzMVVIdzhvNXg0ZVNpT1VUbnh6TVhnTVJ6eVJOTWlqNmlNOTFC?=
 =?utf-8?B?SjJHaTdFQ01WT0JGdGxyY2J6TEZ3ZmkvdEdJQlVuQzNrU1JnMmNFWGUzOVdJ?=
 =?utf-8?B?U0hrUG96ZVJQd2lIZ21NSVAxeTBHdlBQanM1djVQM1FlMm5Hd240RzB3VWlI?=
 =?utf-8?B?SzZkWDVPblVicnd3SU1JTDBhaHR4eVBXMEx1cW1iTzdYaUM4cEtzOVRWOExQ?=
 =?utf-8?B?dEpyZTNUQ1hCMTViUnArRzJsNHVIZ01jZkl6U0dVMDExTTIwdEs0TERlZ1Vq?=
 =?utf-8?B?QzY1Y2cvRFVva29aT1BKYWo4MjZFZzQ2cWluMUFRQnZRUGtONjlQdjR4WDJS?=
 =?utf-8?B?aHJVb3lRMGRrY01TQU1aaTg1VXNtV3RFNmpMMEdmcllBMWFUSXdMcVpzaDdi?=
 =?utf-8?B?ekR1d1IzZFdoRHcrOVNOL2FOZUluK0NZUFlqeTVxbURkeDZQN1cyeDE1MlZR?=
 =?utf-8?Q?bdRua5vvoL4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RCs2bkZ2dmIreEN4NjZSUnQ2bnNVMXZVZDlYTlZYb0VXYWVGcEVEdFprcFFt?=
 =?utf-8?B?US9teU83aTZveTd6NXJRN0t5aVNmaHBXRTZZRjFuVmxjajNwK2Ftc2FZZjhE?=
 =?utf-8?B?UVRxZHR3blFNMHVCQWZ0SjNJbjAzSXVBV2tHM1QxT01NRDM0dkRlK2xodHpG?=
 =?utf-8?B?RzdNZWEwSk9YR3lFRUJYOTNBU2NEazl1clhPZXdhS0FvZ1NlTEhjOUc5MzBZ?=
 =?utf-8?B?ZENrS0tFNWYzY3BWdVViOHh3VGFmK1dDUW1mMVBWSDQ5V0NrNHJicEZlR3BC?=
 =?utf-8?B?RnROdDMveGs5clIzQWQrdjR6dHhsczcrOFhmeVdGQjFzeHBIK01FQVJsNzNQ?=
 =?utf-8?B?UlVwYnZ5SzFHZ3hhUklMZmRNbVFpZTNpTVEvZ3IvMVRzcFlMUFduU1FTbUF1?=
 =?utf-8?B?enhBdkVzM1pDYzkrM0lLWisrTllaNVNIY1JvcSs2UE9KbFdmTFBCNURRVk9Z?=
 =?utf-8?B?UHdENmFubHB3bDd3dm5ScXpVMzFITXlpd2xKWkhxZHI5dmJwdXVBbW8waVNz?=
 =?utf-8?B?V2RNMGtXczFTV1BSdnhlSXduRGVmMzY4RTJmVjRGanYyUFlZSlYyOUEzKzV1?=
 =?utf-8?B?WTBLZy9lSFphNlFPY1hMNHlsQmM2Y3JZdmFrMXM3Ym54c0VNbWRQQlE1M0Y4?=
 =?utf-8?B?ajQ4OHJTSktOUG1tcUltTmQ1SEFyNmdxaDZ1YkJOb2IyY2VNeWlGd3o4SmNR?=
 =?utf-8?B?dTBER3puSUZMTzlYWkYzSnlob2dTVGJOWEZ6WG14RytTOEVTUExyN2dYZEI2?=
 =?utf-8?B?c1JHK1l5ZzlINmRodDE4Q1hTd3cxTVlLVU1SczNnaEdiY2VoRFNJQklkVUNj?=
 =?utf-8?B?ZjZ3dDJackhDLzR2aU9XaW41eGxOODlmS0dyN09yaUVPYmQ2MVZXTi9qeUpa?=
 =?utf-8?B?YldGU0pEUWorb2hZZGFoL2FYaVEwbmJBYnBnNWkxZWhBRGt1QXpSeU5kNkZ6?=
 =?utf-8?B?T0tRdU5neGFpcFRabzc2dDY5T2x0dzlaRUdVdXlXYUxiQlhld1dzK21GdmF2?=
 =?utf-8?B?MkV4R011NG93K2N5ZHpkOEhXT1NkaVBRZ1l3RkZ4c0RPOTROaXJ4OUhUdWRt?=
 =?utf-8?B?d3J1bDhqZ2JYeFNRZWpnZEdZRHIzMGpUZUtWb2lldC8vOU5IWWcyNUU0WXQ2?=
 =?utf-8?B?RWJ6SGV2YUVXdEZSdnlNL2pHWFJVS3IzUFp1Sm9RdmNMOFdQd1ErZS92MDNn?=
 =?utf-8?B?aUNucGNENENkS1FBN2VvMDZIdE9LSE8zU0gxYzlCWnFJYTJUd2pYVU9QU1F5?=
 =?utf-8?B?eDl4Tll3NkE3TGJxS1JLdHdzTXF3eUhpM2ZabEhQK1BOL296YlpGRmZGUHlZ?=
 =?utf-8?B?emJRbkUzZGgyUXZYZWt1NHVLRmhhTzFIRGxsd0l6TTA4Y0x0S3U5eEhZMFI0?=
 =?utf-8?B?T0JvU2J6cXhzZ1FkL0dQWGxITFFWV1dQMUZsaHhVWjY2R1JMeDZ6bDVpL1Vr?=
 =?utf-8?B?bXA5TWY0bml5TjFCa1hONFpOUUVlMzB3T2pWUTdjaEwwY1p4SnVEMjhEejdN?=
 =?utf-8?B?RHZPSVM1M292QzEvOTNnbHJkL0xqRGNPdjIySDgrVEVyMlhMUFY4SW5CSmFm?=
 =?utf-8?B?TVVNblJocnNHNkNNTzFQQ1k5WXBoTTEwdUFvZ1dQbXF0YlFReEUrZmZTVXV4?=
 =?utf-8?B?VTR2YTZSTk5VOWF0MEo5L3Yyb25ZalU4bkFmcnYzQ2FicGNGNlVCV0o1eGcv?=
 =?utf-8?B?WFhORVZnbjJDTDNCK3VxRGs3R1EyQi82ckVjNTZRYThvYU8yOC9Lcmlwc0t6?=
 =?utf-8?B?bWVDdGIyalZ4WXVsM3dUL3U5TUZPMFgreU90TytjVnZjWm9zN1E2MDJKUVZI?=
 =?utf-8?B?MElSUnliZFhNckFRSzlYd04wY01Sdk5MUWJlMlBOWWRqV2FScCtnbTg3M0t5?=
 =?utf-8?B?UzY5ZTJGN0xtZzF1NnkvVmRqUjhqSmJUbElvd2hVbkp3dkxxcU5DQmpCVk9u?=
 =?utf-8?B?SENXVkc1akRBKytWQ1RIR2NZVHhCTDhkS3c1QWVjc0pLWmpQMW5EY3JDSmpG?=
 =?utf-8?B?d2ZlMytvcVJodUp1VWxrU3MvOThhUVNONVBZWG1BMi9sNFpvOG5Fd01xWk1i?=
 =?utf-8?B?YWs3NzNUWEIzQVpxT3BPTithUjN2Z0J0MW0wMWRsdVNralFtNG9UV0NEUk1y?=
 =?utf-8?B?MFR1RmJmak1ocFZYVVlpZFU2OHh6V08rQnhFbnB1MkEzbGFhalVrMjNFNjFJ?=
 =?utf-8?B?WXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 00aa3aaa-dd36-4f8d-ec33-08ddc317ed99
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 20:49:29.7064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6KYNhGqmIq36DZjSGfDzOu+tGdkm1xtJgDjvROZaRqR+tppCF8O8/VNqbESG+EfUjfx6eD3wqCNhVKMwQiqBoMCAlMEgIsx7AJY0QZSx+ME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7856
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Thu, 15 May 2025 22:47:29 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Given that the platform TSM owns IDE Stream ID allocation, report the
> > active streams via the TSM class device. Establish a symlink from the
> > class device to the PCI endpoint device consuming the stream, named by
> > the Stream ID.
> > 
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  Documentation/ABI/testing/sysfs-class-tsm | 10 ++++++++++
> >  drivers/virt/coco/host/tsm-core.c         | 17 +++++++++++++++++
> >  include/linux/tsm.h                       |  4 ++++
> >  3 files changed, 31 insertions(+)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-class-tsm b/Documentation/ABI/testing/sysfs-class-tsm
> > index 7503f04a9eb9..75ee2b9bc555 100644
> > --- a/Documentation/ABI/testing/sysfs-class-tsm
> > +++ b/Documentation/ABI/testing/sysfs-class-tsm
> > @@ -8,3 +8,13 @@ Description:
> >  		signals when the PCI layer is able to support establishment of
> >  		link encryption and other device-security features coordinated
> >  		through the platform tsm.
> > +
> > +What:		/sys/class/tsm/tsm0/streamN:DDDD:BB:DD:F
> > +Date:		December, 2024
> > +Contact:	linux-pci@vger.kernel.org
> > +Description:
> > +		(RO) When a host bridge has established a secure connection via
> > +		the platform TSM, symlink appears. The primary function of this
> > +		is have a system global review of TSM resource consumption
> > +		across host bridges. The link points to the endpoint PCI device
> > +		at domain:DDDD bus:BB device:DD function:F.
> 
> Do we need the name to link to include the sbdf?  Maybe just streamN
> is enough. It's a little fiddly to get the spdf from where that goes, but not
> that challenging.
> 
> For user ls -lf /sys/class/tsm/tsm0/* should work for instance.

I had the target PCI device name in the link name before the rewrite to
name the stream with the tuple of {host_bridge_stream_id,
root_port_stream_id, endpoint_stream_id}. With that in place the stream
name is disambiguated and the PCI device name can be dropped.

> I don't care strongly about this. Maybe one for Bjorn.

The shorter name is less complicated.

