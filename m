Return-Path: <linux-pci+bounces-38179-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0640EBDD78E
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 10:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4095E19C1420
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 08:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202FA22A4DA;
	Wed, 15 Oct 2025 08:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mG2YInG6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672AE311966;
	Wed, 15 Oct 2025 08:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760517801; cv=fail; b=lff1NWMOpAUHNeklcTJygfcqOm5wsvtr6u7Q3n1aN7+q4B/DxmZmMyKfAVwlD0K6FKkvf6dB8cjbvnpY5aKdZq+KfJR3hHif42laRNvvJ1hJjdJ0faAxDwhzH5pGXBzWPyAb1eOmbFn1u+bPIvBozWfd/MSQnFEpomPqmxjyzdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760517801; c=relaxed/simple;
	bh=GSkca5iAWPG5JtNr6RmoTqxtl8KmErWyDB8hYCHligM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VSm6yOVov34aNZ4Gd3SqbtJvTXkvAlA8uxjvBowJi1gIBCi0L2ppj/Wly70DOylym6Yk0mPh4VkcbShU7E51CNixsb05DY4P1PYgykkSCDFh3eKQgveDKs8OjPJpf+Xk67xsI3HBkPl6Aa4APj0QCqWKfA+mFpBJpsaZWud3F/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mG2YInG6; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760517799; x=1792053799;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GSkca5iAWPG5JtNr6RmoTqxtl8KmErWyDB8hYCHligM=;
  b=mG2YInG6iEGCqOvP5DFlxv3wC0CqPIAAjopr211GAoOxYfVcrneNJ0xs
   +EBSDtmAPkoKuFDg4GoYT6yBRCWdDOd/UmDyFjB3gjpKJE4jpa7S8gZUl
   M0eGrOOpqDhJTDEa41ck1W9bhrjXMTuKO+qIW5RRP+BzSf+SxTp0LGqeW
   dM2b//MvvKxMjpKZaQ+ee/faDJtQzjAY2VXizdVHI7zSqXaHonNlHa7++
   7qUpWTHGIN4VW2mmYs+P9Dz11pKfYi4isRTulWrIgBaJyiFhG/qzRIKEU
   EULvqvPOQTDX5T+TYQsVSW3Gzfe0ZxbwGR+ReZfYP8i5ZV06AWpXs8w5T
   Q==;
X-CSE-ConnectionGUID: upekVC5dQ7KrWLlOWU9YnQ==
X-CSE-MsgGUID: FH21A+h2S3m5vTm2bIFKeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="62723537"
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="62723537"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 01:43:19 -0700
X-CSE-ConnectionGUID: H+SINIfMQiexPsmeu/N/HQ==
X-CSE-MsgGUID: v9bXWEDJRi2z7yjjWbKBAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="186371044"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 01:43:19 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 01:43:18 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 15 Oct 2025 01:43:18 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.46) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 01:43:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TWGa0t6aYDrInwaqMn1EakeKU9N4c/7b1MsotHIEoMeYvBb03XnjviLALezz0jSCFUC95bMgtalYZ0qA8G/IufNVdlo9ObpsdQ1b9ZtK0sQX25/Z6FOa++PtwsKgzAzJbeSztRk9I/5rVwOFJcG9rOjUd8rnGUcmr8GvQ4T+54+ZZpOfXDHchy3C7RfeJLRkzcfKPWZnd2O6UFWAQAMwrDtmGM4F0mvN+NyVB5NyQR86E+LrHWXPvv7GOUs3Q/DBqgLrGgju99CDc9HVaReK3tRPPdJOBXl+F2ELjuwdH1xPeWpHPTlCI3sx4mNSjIltCXhg4GKFV63x/Idkz1Fdjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ufoP4rnZTPSMghG7GQBtxKxpzl7bdMh1Fg6eBVSX8e8=;
 b=U5JP6AyFZBKsHRerJXqGJC616sFVQ9JVxseCFaw/OYzY5IkFS9EhRxUdGHs4fZHLoYGyj2npBIP0j+f9Rqsz2I7VDnip+8d/BINuVyFJon615eYs7IsBqSSq6Xg1DWhQknsAmK5t0EuB/kH4AkFLTPGaRQPff/0tOm0JIashjEquAXTaGO4+Mdttow04bDO4dHM6iTQaCNY5VFcvl45Fh4MKQt8Cq4awj4a+397TYjaET4FEENHLwuF31mwCSWcI6IddYkta3VDkm01K8ngoPZUIt2Zb5/jsTy4IZ3MZmMtpaFlQIe5PPeMgcDULjs2dE0FIBHqX7Fk7FZQvYK/cBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5254.namprd11.prod.outlook.com (2603:10b6:208:313::16)
 by SJ2PR11MB8470.namprd11.prod.outlook.com (2603:10b6:a03:56f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 08:43:15 +0000
Received: from BL1PR11MB5254.namprd11.prod.outlook.com
 ([fe80::bf0c:ea27:d51f:1625]) by BL1PR11MB5254.namprd11.prod.outlook.com
 ([fe80::bf0c:ea27:d51f:1625%5]) with mapi id 15.20.9228.009; Wed, 15 Oct 2025
 08:43:15 +0000
Message-ID: <a34b8881-f296-4d69-8ada-dc9cb66672ad@intel.com>
Date: Wed, 15 Oct 2025 14:13:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/12] drm/xe/vrsr: Introduce a debugfs node named
 vrsr_capable
To: Badal Nilawar <badal.nilawar@intel.com>, <intel-xe@lists.freedesktop.org>,
	<linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC: <anshuman.gupta@intel.com>, <rafael@kernel.org>, <lenb@kernel.org>,
	<bhelgaas@google.com>, <ilpo.jarvinen@linux.intel.com>,
	<lucas.demarchi@intel.com>, <rodrigo.vivi@intel.com>,
	<varun.gupta@intel.com>, <ville.syrjala@linux.intel.com>,
	<uma.shankar@intel.com>
References: <20251015080710.1468409-1-badal.nilawar@intel.com>
 <20251015080710.1468409-13-badal.nilawar@intel.com>
Content-Language: en-GB
From: "Poosa, Karthik" <karthik.poosa@intel.com>
In-Reply-To: <20251015080710.1468409-13-badal.nilawar@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0165.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::35) To BL1PR11MB5254.namprd11.prod.outlook.com
 (2603:10b6:208:313::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5254:EE_|SJ2PR11MB8470:EE_
X-MS-Office365-Filtering-Correlation-Id: f1ca6157-1ec9-4c17-04db-08de0bc6e194
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MGZpckdJQjRWZHFFaHVIWnV3V0hnVEpLOXA5NWFvOXJtOFNiVmgzV290emsw?=
 =?utf-8?B?Z3ZxSXRLRkNaSFVGcUpKeUhUNXhDdjdxMFl3Rmo4UXBKdnVMa3BsSk5lTERs?=
 =?utf-8?B?UVIzQ2pEdWp4Wlk0clZiVVYzV2RkSnF1aEllcXVBQW11L0pvY2thZ2x5K21K?=
 =?utf-8?B?SENZQ0w5S1RFUFY3bEZGckFGblRwNGhsUjNVU1dyMTh1WCs2TUsvNWZJQldI?=
 =?utf-8?B?NGNvNnR0ZkN5RGlhK3RIR0tlWUZQbTA2d0h6UVFoZkUybmZXczBKN091Zysz?=
 =?utf-8?B?cENaRHlYbzNmMzd1T01QWkRWMm15d3VQbmVVVHBRajF0NmZEeU1FdUdFMlpy?=
 =?utf-8?B?bkwwM29JMU9tK3NmYittUWlNQVgwdXpzMkRHYm5QS01vS0RZd0p2S0lYUVB0?=
 =?utf-8?B?WllSREhzTkxvWDMrUjVNTjVYOXlTM2pDUWlxQ0dEcFgxeExiNjI5R2tjZktw?=
 =?utf-8?B?OFVZdkdjWHkzSjVxTTh2L3Q5N1NyYWZyNEc0T2YrV0p1cXhSM2g2SkRmb3k2?=
 =?utf-8?B?WEF2Q0VGSE5nUUVBWTdWRU00L1ZBak9xbTJpQndpUXlYOUpMZStGTnIyM0Rs?=
 =?utf-8?B?RjQ3QW92czVBU1lPSEJJeC8weTJaQnh3YXhyUGUzZmFWcGEwWjJ0bW11UmRx?=
 =?utf-8?B?MmdNUkhrZFdlZW44dlNFU3VxQ0NVUkRPWElLcmhLYmppWmk4bHBSUVM2UVVr?=
 =?utf-8?B?OENWK3ljeFZyLy84b0p5dW9hTTVQY3dWRmlaeVQ3bDF0eDh0ZEczdjFOTDhk?=
 =?utf-8?B?cmVLNjJzeTFXZEZHb2dodHRYakIzRWhNMmNpbytIVDVQaXFRSk8yVUVMakNl?=
 =?utf-8?B?eW1FYTVScmg2a3FvRWFHVzBWN2h1UXlmRUU2Q253bmE5bm1ySmJxOFlxZ2Jq?=
 =?utf-8?B?dXQrOWViam5FSmJrWjlUNER0T2wwaG5jUWJLdWhvVHBsUnpuZ1dRUS9uY1R2?=
 =?utf-8?B?TGdrckdQLzVURjNXa0JZSzUzeE5PZWlEZHNtTFpRS1BSUUdORzYyMEVvTDdN?=
 =?utf-8?B?dnJXL3R4RnEwb0huV3VNRmU3ZVlCK2ZUWjU5ODd1ZnhMaERidGZyYjltQTNm?=
 =?utf-8?B?cFp4NjJKNUpWN21MY3JneTVsdGxINTVGTUNZY1RONEgvRklRTUh6eUhRN1pI?=
 =?utf-8?B?VFBDV2REZ3FBVGdHdEZCT21zZFBpMUFGQWVGaGZ4RExIUzYyYi9SL3JqekVO?=
 =?utf-8?B?WGt3SStkOEhodnYzTHlJdGF3NjBpS0tWaGhOR1Ntbm9lYmxuL2czS01Udm9m?=
 =?utf-8?B?MzhuRHpHSk02Z01ndlUrckNFSDhKbnlnOG8xS3A5YjlhRTMyZFo0VEl5VTdK?=
 =?utf-8?B?RWd6TDBlL3VWaWkvOW9TVVlMYVJYRlZTU01Vc3VnRnJlVkc2cFQ0QlN3Wm5E?=
 =?utf-8?B?RUhwY0hqV0MxcU9rYTRKcGV0SUdpbzNFZUhNMmYxVi9QYzVMWWsyMEtDTW1p?=
 =?utf-8?B?bW1wazJWVHB0eVVhL1V6a1RwNGV3b2h6S1dPTmEzMUVlMFBiZlNta0tQRElM?=
 =?utf-8?B?aWtPMWJETFZ4Q1VDbngxSTJndjk3YStLQ0tJKy9hM25jWHlNMXdRdTlLSklN?=
 =?utf-8?B?WTgrNjN3TFI5Nmd4Mkc3ampJcFBrSVhWZS9CSGR5WjJ4cjczQkZPeVZkMGZz?=
 =?utf-8?B?WGZ3ZzNsKzhhWW9QcE4xSHlzT1lxejBTN0RtRUU2b1lUWE1oZm1zd2o3c0Fs?=
 =?utf-8?B?QUdkY0RYMnkrcTRSMWlTdzlVWmtYZUdLWFZUTVVPdWpwOWpVNDA5T3Fudlps?=
 =?utf-8?B?VENISm43UmdQQlYrSG1Vc25GTU9aUW9qaWJWb0lVL2hFTzQ3VGNoaitwakxz?=
 =?utf-8?B?cHBTaVJJdElOd3F3WVR4SHZ5TFd1cFV3ZmJlbHRpUVYxNjB6eHV5cVpWQ2NZ?=
 =?utf-8?B?VlNBOFBZTnNGRFF1ZTA2UE15R0o2dlVpcXArdDhhMEloSEViOEI1Q1VrUnZV?=
 =?utf-8?Q?SAwQgbYLim/R+pmJL0bz5rjA3uyP/d9Z?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5254.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3o1OCtObjd1NlR3dXUvUzN2dFdGNzF6RENrTTAyUUtSeGh2dWRscWZUeDF3?=
 =?utf-8?B?UmNjUGEwdkVwa1VWelJLcG5kc2VlSUsxRlA1SE9JWUkvZ1dWTW5zeU9mRDgz?=
 =?utf-8?B?dXo3MlZuNzBXc3NGR1hKSEl2bnNvTTNGRVBweXh6dHZRN0xyM0d5S0gwd004?=
 =?utf-8?B?MjVQSUZVbXN2bmlxMWtvZ0QyWGMrbXpNNmFyWHFsVGh4YktZcW9IRHhWTUxQ?=
 =?utf-8?B?ZUUzOWJSUFNqVnpMb3Y0eVA2V09kYmNoYmwwcFQzb21ITTFCS2NUcmdTcFBt?=
 =?utf-8?B?WmhNWjV1dWpOaEVodHZIZVVPdTBSeEFCckN3ajJJMVR5QVN2SlU5SnhvNTVl?=
 =?utf-8?B?Uy8vbU9XaWFtR3VCQnIwbTBTOUFKRlF3UlBKQll5L2wvcE4wWUxZMFcvSnRv?=
 =?utf-8?B?R0R2dDVlV0E0T0MzU3BXaDBIdzRxdHVBMWlxc05uN3U3eUYwTkZtcDNNM0Rm?=
 =?utf-8?B?YzY1VXBWbkdxMVhpVFp5dVNUaXA5UWpjdzVoNzNjVnZ5MW9mKzB5UTVUbjlm?=
 =?utf-8?B?dGRnMzMyRVU4Z0RzdUxQQjNhcnlEVzRlVU8vTWh2WFpTdGdrL1FIWE5hU1gw?=
 =?utf-8?B?bnMyRWl2NFhlakFTS0FzRmJrRXluWUdoTHNiTmVXMVptTkVxUlEyZnZLdjU3?=
 =?utf-8?B?bXFuK3hLckprV2xVeVM5NzhacCtwc1RLYlZicU4wMmJWU05iNHVxbEkvZWMv?=
 =?utf-8?B?dS9xRzYyckpFQXFLMGFxc3ZJM29venNRN3lpRGsyZ29DYVJHSkxhU0NzbXVX?=
 =?utf-8?B?RThkRE5kTmRXYk8wQUNabzBhMThrUnoyNGxSYWxTckRyRVhvdHM3b0lTY0t3?=
 =?utf-8?B?WWc5b1FFYW9ESG5CdkRKaHhzY0dadG94T3FFOEYrc0l3ekp1U3BtWGlzcmNV?=
 =?utf-8?B?L2dkYkx6bGdFd2ZYcVNvdWtaTC94NXd6K2x0eGo4U1NNZUhCTTB0SzFodzJ1?=
 =?utf-8?B?WTJDRUFYdEJFWVBjOS9RYlV4ZWdvbk5rWnZDYkQyeU52eG0weDZ6ZDhBdnpR?=
 =?utf-8?B?Z2tSNStIZTduQTkxMDJFSitNNS9MODV0U3lnNDNnSG5ld2dWbmV2dnZjaTh6?=
 =?utf-8?B?eW9pcDBEZ3lnaWkvbEZFNlU4TTNIV2F1WnhpejVUTENDdjZzbWtidFBrYTBu?=
 =?utf-8?B?YnlEalNyU3ZtQUZqTFlGRGl5YWNIYVFhNkFBcGlOSkpXM0Q0emNobkttay9O?=
 =?utf-8?B?bE9UeFRqVWJUbjZES1FCVzdQNnBIOUJNdWhjTUJNOEZwZHNUSmNwQy82SEcw?=
 =?utf-8?B?cXRFMk1EbHY1WGFnZVo1UVd5THJIamdxY1dma0RqenBOeUVUcUNLSkxtMGEy?=
 =?utf-8?B?QlUxM056S1ZSVzRIcytJY3doQWF2bVU4R04ySVc3N0V4Mysvd3g1a0E2UlRR?=
 =?utf-8?B?bytEcDFqL3BzSkV3SnNXbVhGMjVTQVRDS2VCU0lsQks4d0NnU1VUKzJCTkVo?=
 =?utf-8?B?ckM2ZWdxUVJ3cjBoNmp3VkN4TDdYSVQ4VHVVR2lGRG9vV0xUWlY5NXZmS2Jj?=
 =?utf-8?B?Rmp0cGFVMjFUNytyNUtnbzlGbEVPWCtxWXVEeHBBZ0M3THpzNUZpUklyMnRS?=
 =?utf-8?B?SlVpNnZmLzJGOUFyamUySXpScG9FNHh3T3FFUlFtenVaUDNydEREd3p6R1dH?=
 =?utf-8?B?Y2dHK3krdnpnMllqbFUvN2d3cDRwaG9reDdCUi91bTZVbTNxRGJSNjY4bVVp?=
 =?utf-8?B?TCtKVGlqTGxsSjE5cFA2Sk84NkdUNnlJUUVPT1dXYmE2OXgreEpyalk3R0py?=
 =?utf-8?B?U0x3TDVHaWNzZnRSTE5rWjFMOFpFMUJwYStwY1J3VTNqVjB3MlBLeEZwTUlO?=
 =?utf-8?B?QzBITmRkbUk2alFJYlNxQmxzNmhlakpVejFjdjhzaGRjYkt6YjVNTWRTZzFj?=
 =?utf-8?B?bk81VTV5OThUN3FxdSsyM0x5cjdoRkgyYm1zZER0MkhMVFJ3QzI4bGs5bmRs?=
 =?utf-8?B?bnpid3R6T0VOY2lDNzNITVJONVNIb0Q1bkdYTDRYb1NOaXVDbzVBNjVKbWhs?=
 =?utf-8?B?L2VhdENYTFJuNzFyeXhjczc0M2x3QjFJcXhqYk1mZjhnbzlWdmIrUlNYUndm?=
 =?utf-8?B?MFhmNGVYZVgrVU4vS3NyYklkTXNtYzRBM0N0VDQ0TTNCaEFKV1dsMmJXRVdt?=
 =?utf-8?B?dUt0Q3c4YkRBdktkUkt1M2NrMm9hUmxIWDBlT1BrRzdrcGxRaDVvMGx0d01D?=
 =?utf-8?B?cVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f1ca6157-1ec9-4c17-04db-08de0bc6e194
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5254.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 08:43:15.3375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MLkKdIXXrJiffAKK7op2FlJ5X0WUFD7Vkf4ZazpmSNzs9HLiCUyp6nlRaUK9PgRWfVjEHOfBfzlyMktHNTBKRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8470
X-OriginatorOrg: intel.com


On 15-10-2025 13:37, Badal Nilawar wrote:
> Add a debugfs node named vrsr_capable to check if the device
> supports VRSR.
>
> V2: Use debugfs_create_bool for vrsr_capable node (Karthik)
>
> Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
> ---
>   drivers/gpu/drm/xe/xe_debugfs.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/xe/xe_debugfs.c b/drivers/gpu/drm/xe/xe_debugfs.c
> index 1c3c9557a9bd..11d1942c196d 100644
> --- a/drivers/gpu/drm/xe/xe_debugfs.c
> +++ b/drivers/gpu/drm/xe/xe_debugfs.c
> @@ -402,6 +402,9 @@ void xe_debugfs_register(struct xe_device *xe)
>   	debugfs_create_file("disable_late_binding", 0600, root, xe,
>   			    &disable_late_binding_fops);
>   
> +	debugfs_create_bool("vrsr_capable", 0400, root,
> +			    &xe->d3cold.vrsr_capable);
> +
>   	for (mem_type = XE_PL_VRAM0; mem_type <= XE_PL_VRAM1; ++mem_type) {
>   		man = ttm_manager_type(bdev, mem_type);
>   

Looks good.

Reviewed-by: Karthik Poosa <karthik.poosa@intel.com>


