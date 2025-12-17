Return-Path: <linux-pci+bounces-43169-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B44CC79D1
	for <lists+linux-pci@lfdr.de>; Wed, 17 Dec 2025 13:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C51C301EFA6
	for <lists+linux-pci@lfdr.de>; Wed, 17 Dec 2025 12:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B794339710;
	Wed, 17 Dec 2025 12:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jHUTU/sy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F4F17B425;
	Wed, 17 Dec 2025 12:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765974445; cv=fail; b=S8mUJIBG3yDRA96eWevW16aWnvpQncqfru9OmLTfKiIAmUHwZm0UQNJfw37+L7AGtwL3bvkTZ5tkvAyhE9ULvJ5r6hAkeALXyILRp5iTHOp0tkSzotaZ05BpIrsqICkrmxzszqvamYO6/3M3gq29S9+xVP5hs5jP686simhEVBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765974445; c=relaxed/simple;
	bh=VJbhqckpT3bn+k2ep86dzgAdxFXjxhs2MuME7YwIies=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DnVMIHg8WVgUeGoURH2O6LWqwoRufjDCx0Mqxi+6CYTXTMINUKuenawa1IWUC58tPYL7cSlwZwBSeyV7xb51afds6QDw9SXQZ+Bfp4SJybp7snEkveNhapieCeV5LWGisaAlLv5UwdD+kYbZ4ln+o5PhQV80ubcY9ewCY0S8ZOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=fail smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jHUTU/sy; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765974443; x=1797510443;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VJbhqckpT3bn+k2ep86dzgAdxFXjxhs2MuME7YwIies=;
  b=jHUTU/syPD9rvONA6sJVtW7wD7ycqpFsVK/jBYQeGOTznYmQXylocG+t
   7XJesjo8WiyoSGH3Niyt2I0aeqtubFQaSve+bnqaCGB67dE+AZvxoQWmE
   t/BWz4ejygqAuk7+OhKo3WlSipkNDM5rfKGoNavScCqID6bYWnROITHm1
   jbikmi+ph54AHAITXwfYT1XsoEgAJl2STfJxDqqaU7kw0NlUtgdiwMBdT
   jgAmZ7C0RC2h++nYEbw4h8M68XtXqGynL7PnxSpREVyylAkckkQMWcy33
   P26lz1Ak+kqL4SrCmICdUx8ZWpIaq5Og+nb3Jsqu33jbaf23aexzv5oCc
   g==;
X-CSE-ConnectionGUID: qRcphyuYS06/3ydmOlDxZw==
X-CSE-MsgGUID: yfIMHEP4QVOXEeiILpfuGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11645"; a="93385154"
X-IronPort-AV: E=Sophos;i="6.21,155,1763452800"; 
   d="scan'208";a="93385154"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 04:27:22 -0800
X-CSE-ConnectionGUID: NqRWuvgZS/+GOxoPMwVn5Q==
X-CSE-MsgGUID: hZmdxRj1TYW9L5k/R7BKzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,155,1763452800"; 
   d="scan'208";a="198177689"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 04:27:22 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 17 Dec 2025 04:27:21 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 17 Dec 2025 04:27:21 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.6) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 17 Dec 2025 04:27:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h4olVUrheOXh47QgfIM+h4pehMmExriIcWGS+X0pYubKT+KRlUmwb+WboofQsDjW54Eq9XpUY5PLV4CZnBVerLqhi4tqeA+X3YHZH6GFcAqkcjttzZNtidYw/hFJWW14H4yO+CvIpLHr7u4WJBjdtYiDctVRowHByzMW0uew6AZGHCQGT8668feNaNZWfQsKfGKeSS/KHOKQii61GOv/XoRtPuU2OyETI4zfC/cf+YwbBj4siuwZuh3dUo+i9UR5JzJ+sdqVFsxAS34ObxtCFvyKqMmNNsKETNHzNQVZbdmiJCNVpDweCKszmaPKjbHv/7JJV5yQxjoxYTzzDNiGvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WpPRMk2w1SaE5v7Xxi7iYk6ibZFVEnDTLqh61Wj4o+g=;
 b=Wbyrcf32MKH3ASDD9jT/NXviiCw2kiYX+qRx4jZUEF8NHdGi2ryNmwlfkvtkhVKXAQGYSAg2vhfULnAqVg+x8Z0sLIMf8pNRqL4kVDypnSglOLjnRcs6jlHZbXaa3JOS1pzUN13HdDFupje9n8cDmR+PxiNqrknctAneGVj5m67cjirkbEuf5ntCv85YWqgg50L1pDhb1N6V7yVKXjK2mnSfgL5j/lFUYA+o9U/QcKhMMyW3Glx/js0wTkH5FvD9Q4hVyQFuzwAK9jfmwpnMbeJEK7JSRPlYXfScFm7epK6LBFH7tbNTTaCvb1A/7k4j9QmRr/ZHSlUBhin+Q7Hvvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN9PR11MB5273.namprd11.prod.outlook.com (2603:10b6:408:132::8)
 by DS7PR11MB6198.namprd11.prod.outlook.com (2603:10b6:8:9a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Wed, 17 Dec
 2025 12:27:17 +0000
Received: from BN9PR11MB5273.namprd11.prod.outlook.com
 ([fe80::bf46:a273:e7a5:bf32]) by BN9PR11MB5273.namprd11.prod.outlook.com
 ([fe80::bf46:a273:e7a5:bf32%5]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 12:27:17 +0000
Message-ID: <ea5d11ef-d201-4062-908b-0da69d2bf955@intel.com>
Date: Wed, 17 Dec 2025 17:57:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] PCI/TPH: Skip Root Port completer check for RC_END
 devices
To: <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<giovanni.cabiddu@intel.com>
References: <20251016082022.1173533-1-george.abraham.p@intel.com>
Content-Language: en-US
From: George Abraham P <george.abraham.p@intel.com>
In-Reply-To: <20251016082022.1173533-1-george.abraham.p@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0119.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a7::7) To BN9PR11MB5273.namprd11.prod.outlook.com
 (2603:10b6:408:132::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR11MB5273:EE_|DS7PR11MB6198:EE_
X-MS-Office365-Filtering-Correlation-Id: c5a393b8-b597-4954-a7f0-08de3d679dc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZklIY2VVTHpad0FLbmVsVU0wR1NYdzUxekpOSkUxUEdkK244K083N2J4bmZO?=
 =?utf-8?B?bXBTSThNNlNFblZhaU1RQlVHUjRjby9IVzBGdTFIcEFkSHZPaUhnb3B4Y3FI?=
 =?utf-8?B?aUlnTmFmZnlwQnphL01MVXFGWFNIMm5QUktzcms2aW9KRVdkL1llYTlhMUlD?=
 =?utf-8?B?aE1xellKeVNRN2pUVHhuQnc0Nnk3NnlUWFRTTVRoczFQMmZNc0ZQS1hqS21m?=
 =?utf-8?B?VGJQQjB2L0JMREN0MVR2KzB5czRmU0VkeEpiNExodnNlQ2Q5TGw5L3R1eGRH?=
 =?utf-8?B?QTBudXNya0lwOCt4VlphK2cyanQ1dFoxUkxVS1kxcStVQlpDT05pTEZydCt6?=
 =?utf-8?B?eFJZR3Q4U2ttL2pOKzAvQ3I2eGNyR0hmL3BlSisxUkYyTElzNzhDTWJ6emhE?=
 =?utf-8?B?ZCtXSHI0ODU3ZGJ4cUU5aS9INExCK3czS3M4RVlpckpkODVZNVNQNEo4cHIw?=
 =?utf-8?B?R25hclZBTnhJU0lQM2JKdHA0amloUGx3cUtPb0I2RWFwWUdMVFNzeDB5VldU?=
 =?utf-8?B?VlM5Z09tUTVYejhMVmlHSG5GMTBhOUJvUWZlMGU1UmhZOWgwSkNBaHpyNGNN?=
 =?utf-8?B?bk1JemloaHk4N2FrUktJNldONm5ZV3lSZGVReXYrU3k1S2JkNDIvZDhlME40?=
 =?utf-8?B?M2hxK3hxK3d5NnM3ZVpiTWZ0d2lhMm1DTUtkOWJKNCt3NmhtS0ticlF0OUhJ?=
 =?utf-8?B?RWxTd283Wm83S2U2bkFlSEFEWG1EYnZLWUF3UjVqbFZqTHlPdm5DQUxGRFJX?=
 =?utf-8?B?MmNweEJjVFZ1QmVKSWdyek4xOWk5QzI3UWhrZ29pMFArQ2Q2NGlOYXlpd1Uy?=
 =?utf-8?B?WWJpVUVNVWMzdlB1Ky9xNVBheVl6cENHY2RyaWkxUlNnYkZNVEt1Y3EwMjc0?=
 =?utf-8?B?aEVLR1dpS3ZnVHQ3RDlJNGxQS2IyWXJENTM0dW9Vb0FXVjRBWnFURExyZjVK?=
 =?utf-8?B?RG1xTkxNbG43MU9VT2Fld3JSalJydG9jbXlwQ0tzcThvMVNNRkxvOXRucGtU?=
 =?utf-8?B?M3J5Z0puZHVCUkVCdVkyeHg3NTZhMllwbTI3RGRIZTArZ1hJc0VPRVlEWHFj?=
 =?utf-8?B?M1hEVU9GQzJYNVVrNWRJbXdOUTZqZ01QdUNDazVPQVhDSFhwRlB0Q0t3dFBB?=
 =?utf-8?B?Zm5hUHNqOGVlRjROUzYxM3d1MkZab0tjRTl4VTBGeGJQVGxwb3dtdXhxVGph?=
 =?utf-8?B?aUFXTnlBeCtkRGsrWWluTS81cUljMGRTSjdZVkU3cDF1NEM1dEtMOEJFazNm?=
 =?utf-8?B?eG5yL1RyUEcxaDN3Q29OTzhYenZ6WjdLNmVHamhDeEdZa05Gc3QwZFp0TXc1?=
 =?utf-8?B?NDNFTmRKaTBNbVY1Q1lRM21INURYb0FxbEloZElIOUs1emFHOC9SL1ZJS0xz?=
 =?utf-8?B?V0tDRGJSbDU2S2JmM24vdWVCY21hT1VyZ3V4MjA1aG5vbXQ0c0l1b2xlekVn?=
 =?utf-8?B?WWkwdTBWL05wbVh0NXRtbENUU0tOd1RjOW5ET1YzUnFCQWI3d3EyUytBenc5?=
 =?utf-8?B?cllUT05oT0kyWVVzLzQ3NVo1MVMwNzdSUitMZzkxa3doYTJIZXF3dGV1Vm9k?=
 =?utf-8?B?NkZyVitsdWNzZTdIRlZmM0p2NTlRdEJJQjJsNHRDaUsxTmt1VHo5WStUVXdv?=
 =?utf-8?B?MnJianVjQmR1STBxM3NYbis0aXBidEN4L3NiU2M3SnVCSTMrUFNLMFZaRFhH?=
 =?utf-8?B?NHRMTkZhN2tzUERQcWQzUlZJemhTMnB6d1ZhQVZLS05sbFVkeXJzbkYxcnFk?=
 =?utf-8?B?T3A4OEk4OVBIYlhQcEtBWHovaUhLWS9KRzZTRGV4RzJOVHYxMXNzMlgyVmR2?=
 =?utf-8?B?UldQM3I3VHc2eU9nYmVyT3M4NjF3dG4zZG9VaVV4a1lIdDcyMTVnVERyblJa?=
 =?utf-8?B?RjVFaEw2VkN4d28rVWVubVdxSjZnTDkrT0tYZHI4clZoa1E0TThJY0V4L2Ux?=
 =?utf-8?Q?JaMm9i2iTfoJiWBjImmQDsT+d4uT2iOy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5273.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWZqKzBFNkZndnAvcHBoWVp2RUhMK2dVL1JUV2k1ZWYvdDFHNHZMZTlPdk1r?=
 =?utf-8?B?aFFqQ0VacW0wbkY0V25Ca1MwY1NVNE55d0pLZDU2b1MrbEFhR3dIc1lWbmla?=
 =?utf-8?B?cHRsK0pNbUIrZ0FNL01IRncyVXdLQUZuTmNhM0pTbWF5dDhtQVpwNmRpVU9O?=
 =?utf-8?B?Y3dBbFNFUDNTOVJLc0pXRm1kUFZFdkFKSGZWWm9sRFJWRVMxakkzNFJNVXhO?=
 =?utf-8?B?a3ZBelJvUnNVdHR5MGp6TnJRVjNnZmlJSkRsUzZKSUh5TW9JYXdrSUlhRmMw?=
 =?utf-8?B?d0IyWWdWbmhUUGJzVkFGcnJUVkF2RjFVWXBDbGR0YXArc1FuNWxhUDdJTTN5?=
 =?utf-8?B?bmNpUVdSUSt1RkxpL2ovYTc2M2JyS0crc2dTZnBTNzdKWlpDRW9zTkc1ZHZh?=
 =?utf-8?B?bG16KzJUdk1paEhCUFp3QUpiaDBsSnBMWVhzZDAxNU91WkZORFBWaTNWSlNV?=
 =?utf-8?B?ZW15VE9MNEhYb1A2UGZKbjFrZlNMbjBqeVBKM01NWERPd0E2ZzlOTlNJaGc5?=
 =?utf-8?B?dGxrRG16VlRkY3RqZGFtZ0U5VExIWUxKc1hnMm5HbGd2cUpQZFc0SFRRREVI?=
 =?utf-8?B?cm9qNGNFc0xsMHVHMEFUZFg1d0ZJNldnNElRdnlHOTZiRlJLY3hHTVJXNlJK?=
 =?utf-8?B?Uytyc1QrVVpYa3BWa2pkV0NEdGNxL25jNnB1ZlJVWGVMYmlFcjVxZFlqZmlj?=
 =?utf-8?B?OWxCYW44cWFyUXV3Q2NSL0JqT1UweUluUEIvdGpmSDdGSndickJDWWpsWTNz?=
 =?utf-8?B?eklYYk9LSUczUlpaNWNqSzZqWUthNVNSaTd1QXFsRDUzWlozV0xHeEhSVkVz?=
 =?utf-8?B?YUZpbnJnMGdhNmNVZzFyUkVyWEg5OWpBcGRaL29zMFUzL0g5K3M1ZVF0cld6?=
 =?utf-8?B?WDZMYW1CU2ZEUXU4QkRpZUt2cVlxZWRjTTduL0dkaEd2SGVTNVMyNEtPSFRF?=
 =?utf-8?B?aWk0cGh4czlnenVlMUlWNFlTQWZENXppSXczbnpnTVUwbUlRUUZkUS9BQ3N2?=
 =?utf-8?B?Rm5oOVU3bldONGVIRnk5Z3Bvd3VjQ3c4Qm4rTjdvQXhrWDVDcGhSR09CNDIv?=
 =?utf-8?B?Z0x1YTRhYXcwdHdoaUFzUllINGMvUVphcGYyV3ZFbmR0emVUdzJHeHF6N201?=
 =?utf-8?B?NEd4cTgwcVgrT290M0hFczNpLytxVk1xUW1PYzdmQldDVkx1ZVluNWVqcno1?=
 =?utf-8?B?dTNsaHJFVWtZUDhLWU5NU3JLaWVzZ1NNQjdrSFNXdHVId015anpFWS8vbDNr?=
 =?utf-8?B?RVlhbERFT2V1dDFiUHVLMU5DSGVSbUtiM3FGZGorWVNHMlNEdk1uOXZzK2I3?=
 =?utf-8?B?TDRDcEtWdUZlZjJIbHRYY3lmRHk3NFptWSt0Y1N0ano4bzJvL016VlN5Ykph?=
 =?utf-8?B?QzRVUWdLVFlHU2pmR1pLWHVhZkw1MDBRYUF5YUlWNCs1Tkl4UW1YUFlBbk1Z?=
 =?utf-8?B?UnZZdWcxd0tWWTZ5V0hwVzFiNHlHSjRuczdXYVN2S1BWUVNqMVFwOFJDUTds?=
 =?utf-8?B?TFdCeTN5VW5vbXlkdm1iOEd3NVVqUThTcSs3RW5ZQkhQSEVRa0hleWhQUzZH?=
 =?utf-8?B?cldMQ0xZSWJjUXF6WHNtWXhYVk50SkpjL2llaG5jZUpFMnRPOHk3cFRjRHpB?=
 =?utf-8?B?djV2ODlpbWZwbENEbzd3N1RYU3hTUmFIZjkrNnp1dlQ4Yk9qMUVvQWJDcG5B?=
 =?utf-8?B?dzAvMzg5cmNYYXR5R0J0Ly9pUWRNMVVnNTBZRG9WV2EvczFXTEV5eWl3L0g4?=
 =?utf-8?B?dFdxbXRRVUtJU29idVNaalk3U1hoSDRQOE1vZHo2TzZRYktaeG81RDlKVFI3?=
 =?utf-8?B?ZXQ4TGEyaDg0ZC9QdXd2LzV3UXllbmwxNHBHTmlZNmNKVXIrajlPRXpzMk0z?=
 =?utf-8?B?eFNGRzBaUWhaM0lHRTZWOXUxd1p0Rjg2UnlyU2VxNDV5MzZ2cFFDSVJObnhO?=
 =?utf-8?B?ZEZObWdXdGhDSUFQS2VBeGxmZGNDZFY1WFBzc2hmMkx3M2tQOFNKdGw5SkUy?=
 =?utf-8?B?MGtUQUpRSStHZElCMS9ha1lwc3dxVCtBRkV5VUZTank4Nms0QmJIU01KUm5v?=
 =?utf-8?B?SndiYXhUWEhIMkhyWXdhbXh0WGlVSnlFNS9CRUVGWC8xL0twTlkvNWZYY0pL?=
 =?utf-8?B?MEgxMU1DQXhTZ2RNamlzK3ZJcmVVY0pQdHU1YVdPeWhUWWVwek91Y2VNaEY4?=
 =?utf-8?B?d3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c5a393b8-b597-4954-a7f0-08de3d679dc6
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5273.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 12:27:17.4709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YRZ3k8E4pLF7OcXgT/9eblvb146EO75L+q3c8z8jZm3YjSBBLuLVmIxCLwJTrN+4Xua2s0I2IlYNbowzz/cm70rnrRqFkZks6jWZpLDCbA8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6198
X-OriginatorOrg: intel.com

Hi Bjorn,

On 16-Oct-25 1:50 PM, George Abraham P wrote:
> Root Complex Integrated Endpoint devices (PCI_EXP_TYPE_RC_END) are
> directly integrated into the root complex and do not have an
> associated Root Port in the traditional PCIe hierarchy. The current
> TPH implementation incorrectly attempts to find and check a Root Port's
> TPH completer capability for these devices.
> 
> Add a check to skip Root Port completer type verification for RC_END
> devices, allowing them to use their full TPH requester capability
> without being limited by a non-existent Root Port's completer support.
> 
> For RC_END devices, the root complex itself acts as the TPH completer,
> and this relationship is handled differently than the standard
> endpoint-to-Root-Port model.
> 
> Fixes: f69767a1ada3 ("PCI: Add TLP Processing Hints (TPH) support")
> Signed-off-by: George Abraham P <george.abraham.p@intel.com>
> ---
> v1->v2:
>   - Added "Fixes:" tag to link the commit hash that introduced the code
> 
>  drivers/pci/tph.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> index cc64f93709a4..c61456d24f61 100644
> --- a/drivers/pci/tph.c
> +++ b/drivers/pci/tph.c
> @@ -397,10 +397,13 @@ int pcie_enable_tph(struct pci_dev *pdev, int mode)
>  	else
>  		pdev->tph_req_type = PCI_TPH_REQ_TPH_ONLY;
>  
> -	rp_req_type = get_rp_completer_type(pdev);
> +	/* Check if the device is behind a Root Port */
> +	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_END) {
> +		rp_req_type = get_rp_completer_type(pdev);
>  
> -	/* Final req_type is the smallest value of two */
> -	pdev->tph_req_type = min(pdev->tph_req_type, rp_req_type);
> +		/* Final req_type is the smallest value of two */
> +		pdev->tph_req_type = min(pdev->tph_req_type, rp_req_type);
> +	}
>  
>  	if (pdev->tph_req_type == PCI_TPH_REQ_DISABLE)
>  		return -EINVAL;
> 
> base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787

Kindly let me know if there is anything i can do to take this patch forward.

Thanks,
George



