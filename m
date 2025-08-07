Return-Path: <linux-pci+bounces-33595-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A0BB1DFBF
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 01:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FF5862591B
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 23:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6E822A4D8;
	Thu,  7 Aug 2025 23:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HOsJXpz1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0872321CA1C;
	Thu,  7 Aug 2025 23:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754608686; cv=fail; b=PdXyrEH1WM1MihGk5TFAQnthDyQZ45S5oJ1GF6npEMZ49eCUXP7K9Qr8XPFXZqut5SPCQ+BtJLAHkQKwB8NwhekTdiUgeCeD0hK9k6SGg5x/K5aHT5IIp+z8xZDKG9vbcA5EbYSiPRD7wbNmUHzfWpNhU7H+9T8QjX3jRALSW14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754608686; c=relaxed/simple;
	bh=OkvVU7rqqHIAbEnVoD1eb5ljkSkF+RtjhNHstYLr8mM=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=JvClZZJRIfT5Uaa17UyIa0913ADuSPpaChngvR3QoFR2lcD5nmk/niMDkzIJx8/PMo/z+6NkBfkoH/EU6H01Fl2nW1r44TS2F2VvY+4qF2HsnSTAP7s0nYNaJXRTZgI1iR0zqJ6ApIWIRqkoMoCbikvWcrTfxdtBgl6R0jz9vf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HOsJXpz1; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754608685; x=1786144685;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=OkvVU7rqqHIAbEnVoD1eb5ljkSkF+RtjhNHstYLr8mM=;
  b=HOsJXpz1awPpjwQBzxLmTGNBU2S30hVZHjwbd5JPtR8kDQ992JlFUwuq
   YkVVDFyTul6lMkd34DJmTvoyXIX7XukGLak9SncxOLLGeIJloNEyCLOlu
   f9CnzNT7hdtsPZ77MLYYdxvQvAZUqOqsRRhw6A0/KUsHLpRLLbcKM/Q51
   dAr8Dc7aLHKtJs7QhQxuUM3Ec2VP7VLkGVXQktaLlD/FYl7Pmygm6kZHp
   WC1+TpOEAvt5E5yrEb2hg0VbGkZ0ZNntOAMP1oPazeRyeEIJnp82c4apQ
   Kvo354h7vAiiws4js9LO8xq/XYa7/gIQNJ49LdrdetinljNbFv0uF5tVm
   w==;
X-CSE-ConnectionGUID: g5HT9xuLT/WsnatIAXjzEw==
X-CSE-MsgGUID: xbGsZuilTruxQueeeSxMwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="74412438"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="74412438"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 16:18:04 -0700
X-CSE-ConnectionGUID: 5DILPUJaT4C4CNxWhBoaLw==
X-CSE-MsgGUID: UCL2Cp63Ri2irxFjzNrG+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="170439307"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 16:18:04 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 7 Aug 2025 16:18:04 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 7 Aug 2025 16:18:04 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.56)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 7 Aug 2025 16:18:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ocbsKmZXiuR/f40WQjd9GjadfoA66vNozLn9J2MQ7oOcW9ExjWtAnT3zlNwzNK8XCuMfmLP8x2ioVCNTN6WCH+pouNgtctcL7b9+UJA2g7Rp1Z58q+yRsnb+eTfFIebaxaxBpy+62FAI/Q+aU3+dU9udQnDKD+sQnGwNYZ73ATm8iiA6sbEJxD0chp3KwNfmfzJmU38oNihZe2qUvpiiqMgw43kEqEC6mAlGXERy3/Hgao/D/rtvBMXWOzkrOTpO3hOm6mRhOf9G2cS7+VWmYtqyZyzuUglAjLXXdTHXUafO+nxLyi/79JE4jUrwgjU1AVAGYR8pH67C0Un4mOSVGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UG1eHEr4hxeFCrdfJro8d+THDlH24Yj7C/Y0dQGtzT8=;
 b=cbsp6tdrtN+O0ilqdP6mW3Fu9rbhsCFR3R0ZRVzz1Uz+qyVCLDRDqovpgFwW8d+0wPg+u3jk5hSJmNwsrw0CLfkBkYhKYv/9VBODvfx4RdskZEiFMYj3Dayh1tSOpXqOKkqFmZ+ZNHwpXBAfDhBs32dgGec/gv+tJ5LraTQ8Ikk8B/PcvkvoNfoOwumwbWmmlH1yAy0QgKGoaLH3OvPgr1H/Pic8l97J0gnC/z3qHVUO/pG+mhZssmjO3ttQAoAkyZTrThPY7u5ngk1XO7VAhkiVmJqu+WNWIyTteyFAXSETWv0+GG7y3g9cT15Is3+8gXA8t75y3rF230HmzC3wEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ5PPFD25B21260.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::856) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Thu, 7 Aug
 2025 23:17:56 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 23:17:56 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 7 Aug 2025 16:17:54 -0700
To: Bjorn Helgaas <helgaas@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bhelgaas@google.com>, <aik@amd.com>,
	<lukas@wunner.de>
Message-ID: <6895342226a99_cff9910086@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250807202413.GA61777@bhelgaas>
References: <20250717183358.1332417-4-dan.j.williams@intel.com>
 <20250807202413.GA61777@bhelgaas>
Subject: Re: [PATCH v4 03/10] PCI: Introduce pci_walk_bus_reverse(),
 for_each_pci_dev_reverse()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0159.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ5PPFD25B21260:EE_
X-MS-Office365-Filtering-Correlation-Id: d0cb34b0-4542-4cca-d57f-08ddd608a489
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RVNvT2hHTFZMbjIwZG40aHhsdG9YRWQ4TG1kdlBPLzVxVTZkQzdkRExWVzBQ?=
 =?utf-8?B?Y0VGSmxmRXlqSEFwMk5OWHlNVDA5aVhlQlRhZ1RoYWNycytaWEtsUy9mUFBm?=
 =?utf-8?B?aHgvNUZwSDJVVDlqL1hrNFRtMWgreWtXeCs3ZVBNNUs4NHdOeWEzTnQ3OGRp?=
 =?utf-8?B?MzlNcXIyY2ZDQjRSSEZQQSsvNXo4Q3RtR1lDdUEraWh6M2N6ZDJPNXlVNE5n?=
 =?utf-8?B?L2trYVhXTUtWTitTa3EvSWFGR1EwNlFyMDJsZE4rT3U0dDhLbVJOSzl6OG9l?=
 =?utf-8?B?TThUQ3ZXSHBrdmxGNFRhNW5qK1YyRCtXVGV5Q1hkZmR5WVlQcTVOZnJpVjhX?=
 =?utf-8?B?VGUxN245Z3o3aHVNSDM2MHdRMWFIWkl0azVOcnpzOG9ORzkrdHVCSjBCSG5N?=
 =?utf-8?B?RzRFRmtVdWUzY1IwTm1MSzJHWTV2SUNibVFncU9UbGRibytRVDc1MU1PZklM?=
 =?utf-8?B?bEF0OUtsK0Y3OEsyK09EdWQ5Nm1Va0N6Znd6TjdYY1dFOGlQNVlnNTBmNnF1?=
 =?utf-8?B?MFFPUDl3eFh2c09hZG10d1BWTGt0SHBNdzNHam1sQXV6UnFoNUQ5T1NsSGZn?=
 =?utf-8?B?RFVxVzluSnQ5SnpMaXl5Vm1kU2VOenVXcDlWRFUyaDZtN3R1MUo2bE5pcWFx?=
 =?utf-8?B?N1h2L3JJSHV4NUV3M01TcmN0SHgzZEVaSTJqQjh5aWpxQi9RYys3R1htbHdQ?=
 =?utf-8?B?bzRkUG5NZnkxV3hjM3h3UndQckxHcmhCczl4R3FFQ2V3SGNqbnpEQ2Z0U3Bn?=
 =?utf-8?B?S2xOczlaZHZBZS9rWTg0eEZJN29OUUdpTm9kR2ZadHQxSmZYZzA3Uld1Ui95?=
 =?utf-8?B?N3NuU0VTUFB6cGNCNW9hMnc4WjhUeXBlMFVJeHNUUHlVem1NcHY4Ni85QTRL?=
 =?utf-8?B?bzArbk1MNTdFb0Mxc1pYU2pWM3hxRk5LWE1jUUNTNjk0emw2NjFGZzh6WDdI?=
 =?utf-8?B?a3c4d0pEajZtdUdtYjBPVVdyUStzWUlUc290Vm1LeWtDYzV2ck43ZlV5Ujhw?=
 =?utf-8?B?aGo1RkFBSTA4TkhYeWRNcmpLMUhwcW44TkdnMmt1Y2dSTTdkK0g0L0xhdzVn?=
 =?utf-8?B?OW1TMU1LOU8zaTViTWc5eVpDbVozem1ZT005NTNHcG9sQTEzdXVxSFdzaWlG?=
 =?utf-8?B?VGtvb1VuYVVUNHZheHR6OHNKQ0NjYThGMm43WjBhM29SeWYwbDlNcEFaQTFh?=
 =?utf-8?B?NnV4QnNNTS9NUWRRNmR1cWhDeFY3MDFBd0pCY2RUWE1iQ21Mb0krcHRBa0o0?=
 =?utf-8?B?Z3Fud2NwajNIMEpQVDhKMVdLeWxyelp5Tzk1UXQyUU1SZVVPNFN5QUdzVFRE?=
 =?utf-8?B?ODA0eWlDVnRJY201MXhZa3JNUm1qNnUrUE5iYThZYnB0ZUx2MSt1c0IzT1Bx?=
 =?utf-8?B?elZLQi82ZlEySHFZQXQyQWRzS3U5eUduRkxtWjhsQ2pNaXVKUHhPTUhWTk9n?=
 =?utf-8?B?MWxoVHZ4bmxmbXduMVF5c2J5Tms0NS9hRlBFejkxejVKV21uakRDV3YrYjVl?=
 =?utf-8?B?bWhRdDZNdFRrMzE5b2NLVDRwaU5qbUN3WFhjOEZLa0xOMnA0d09OSWhucGJT?=
 =?utf-8?B?RzdqeUE2R3A1QXZxdk5XbEdhLzdPRmVCekpaaG0xbXgzcVloVjRjU2hmVTB3?=
 =?utf-8?B?SUc4OERnL3RmN0dVak0rZGxpNDhJLzV0ZEFwN3prcjhLNjR5OGgzNExwUWEy?=
 =?utf-8?B?Vy9Zd2dRbmE0UVZucnJpeFMzRHBDYitxbG05UURzVnY0cHlHZnVLNUNRWDhV?=
 =?utf-8?B?djlTbWlySVdwS1gyRk9EVWVtdDNWR0paRmMxMWdMTzhMMnJFMnA0VkdsU2dz?=
 =?utf-8?B?QThmbDlvdm0zUlRVVE1lQkw0NzJEbnRCSjk3UHdHdXBsZ3NiSlRDaFQ2SWlr?=
 =?utf-8?B?UGo0RFhSSmhubHJEbnZ0NkhiL0RhOFpLYU9qNTFMZFE0KzRKRERzNGV4Rm9B?=
 =?utf-8?Q?xhnOcxIKe5g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVd3c2tnUDlEQzN5bWY4RWorTDlhSE5ENmJUTlBzbyt1bFdBNGQwdE5CZ1BI?=
 =?utf-8?B?UWNsTG82TWRoUTlpczVteVFJUEdPbXdLcmVPakQ4MEhoNXVCMTNSWVIvdGhN?=
 =?utf-8?B?L3JNRUlCSk5CWUNpYWdJK0N0VDdqc29zRWdWVEk2clVHbE9ZMTBFcSt0d0hQ?=
 =?utf-8?B?MjdoYy9LYTJvaVIwTDY2WkdETG1CRE9tZnJIbTM0NzhTc090YWVEdEVBVU9W?=
 =?utf-8?B?TUdKdDZsMWZLN3UzVEl0V09lSG1OWnVTdWRUVGZCN3VTanV6UWRjZTJISTho?=
 =?utf-8?B?VTlvTTlRV05IY3hLSk5RU0ZacFJ2OVFabk94UE1EWGNXUkJDckVpTS8xTE8r?=
 =?utf-8?B?T1NHSWlQTkYySENpNHdSdFFrS05pVXV0T20rQ0c2REUwczFXZjM4U29pWjMr?=
 =?utf-8?B?bERnV1hhQzc0Qk1JbWdFUGRvYm95MUlsMTdjdmkvOU4zd2Z3SjRUUDZGNllE?=
 =?utf-8?B?bkhPRHFLYzdSRE5wVHViOW05bHdzQjZBNXBNOHVUeG1SU1NHT2JqNVZ6QXRx?=
 =?utf-8?B?by9EZWFvZ1JnMC9hYWVhWFlRRlpxaHFYZ0FINTEvN1NvVjlLazVmVTF6Nk9H?=
 =?utf-8?B?Y0psa3JNS09OMWxFSmJUQllQbm9DemJhbnRKWGRiVTNENmMyQ0RobHErbTNl?=
 =?utf-8?B?L1QxemYwVWFoM2R5MEQwTkRqM1dMQk00d2dGTWdQQ2I2WjhtQWROQi9VWndZ?=
 =?utf-8?B?Y1dYdGttUkI0c2NoaTVLblQ0bndhY21qcllwUy9LemVmVnZXL0RVcHFDV29p?=
 =?utf-8?B?ellwNEVNSEdRWkNPTXR6NkRMaFNzQ1NkSW5UZjRhTTh5eVpiZW50WUxDbzlU?=
 =?utf-8?B?bnhscCs4NDBVOVpPdElCOHBDa01zam5Hc1NBYzlOU2srNFBEVTYvaktodGZs?=
 =?utf-8?B?S3lybjU3dzRRMCtIOXVZQ3JyN1M0NjJobUVDc2d4L3VCTDZrZTJCSWlXNzFW?=
 =?utf-8?B?dG5TdXdxNFc1YitTTWtMNDhtckNRRzEvRzdQa0p0ZnpMWTlKdi9vdDRObndL?=
 =?utf-8?B?c1NXVHpyZnlaVjNMT2l5VTQwU1lyNnkzeng2U3R4SkVxaVl5UlhCaVcrOXhs?=
 =?utf-8?B?cStsZ2RKek9Od2hRSWNwQ2gvdHdSNVQva3lxQjRERTlFdkN5UldEb1ExdVJS?=
 =?utf-8?B?dzNZTnlDWVQ1QVF6N3FRTTlTVThWcmJNZDZlVEhOejN5UGFjRUZZK0lTZ3lo?=
 =?utf-8?B?RTUxVUJrODRxenVRYjRCeWYzcXh0UHNPSEg2ZFNlVGlMQmdwcTZwdEZxTXFH?=
 =?utf-8?B?Sk1lRUFhZmpDNkRoYm5EbEV4MXA0clpxUHUxdzdDNThYUW9mSlJCWVlsOG1v?=
 =?utf-8?B?K09xWmpobUZsL2I1cDdoVUJlVUdOYjJmUEkyeko0cTNvZFpTbGVBTzFybWxG?=
 =?utf-8?B?R1NqaWpoc3RBVFdINjdHcFNaa2xIVm84T0dWb3MwUVdvUmk2OFNCRitTR3Zs?=
 =?utf-8?B?VS95YmxrYnN5Vzg0eTRXNEJzY2VEdStGdVhHdmZHZlJHSVpFZ1BKUXNYamd3?=
 =?utf-8?B?YVp1bHNNYWtFcVhxUGh5VFpNQkJYSkp4aUNLU2U3YjFLY1UyNTdGejdBN2Z5?=
 =?utf-8?B?QVR4a1Npa0xET1crVlNnSjZZbzlKNll6bnJkTFRvTFBLZGdpZ2toWEsyalFD?=
 =?utf-8?B?ZVpqbHRzRTJXNUN2OGxmV3F0eWpDS0JQb0h1TnM5QVFYQU9Gc1V6R0Y0V042?=
 =?utf-8?B?MllsMUJ5NHJrTWZLUHdPQkdxU1h5SkFOQ0lWY09paFNUakFhRlhhRDdxWGdx?=
 =?utf-8?B?TFB0eGhTMUc2enVaZm5zSW50TG8wS3BtNi85THhHQTlxVXN2T2lka1FrUTd0?=
 =?utf-8?B?YU91YjVJNktHMHhBTWZZbTlncHhBT1hkN2M2Nmw3TVhJTXU5c3NoQkdzL0N5?=
 =?utf-8?B?M0JoMmpmdStZKzhFWkxPOCtVakFxWFVDT21tYUVJb3JSc2NQd3Y4LzBPNmR1?=
 =?utf-8?B?L2JUQjFuODU4SytOWGVGQzM0WHBiWnFoK2NRL3lvQTh2aER6VitNK3V4R3p4?=
 =?utf-8?B?UnFpNHZuL1BqeC9wcEg0S3d5enBOZndYN3pGaGpSMTZkR2FLUmg4cWxFOTA1?=
 =?utf-8?B?TVo0eVBKV3E1NjBUbGlXREFzUlZyNGFKZGtLUStBTGlIR0RSWFM4VzJibTJj?=
 =?utf-8?B?TE9sTTh0OGRORFhTclpQaUwyY2JIR1pWQlVoUHZIYndWU1NZcGUzdmhRdXBU?=
 =?utf-8?B?NlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d0cb34b0-4542-4cca-d57f-08ddd608a489
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 23:17:56.6861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OGRAfYqLY1SjyQNX9TsvOKSi+GI/fqxswsIH5QqLFCHRV1g3tqFo8T/fFgNGDKyC7+N2ilrqVYQYQ/s1hiJPfhK0zxI9eyhtjwD4OBGHk28=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFD25B21260
X-OriginatorOrg: intel.com

Bjorn Helgaas wrote:
> On Thu, Jul 17, 2025 at 11:33:51AM -0700, Dan Williams wrote:
> > PCI/TSM, the PCI core functionality for the PCIe TEE Device Interface
> > Security Protocol (TDISP), has a need to walk all subordinate functions of
> > a Device Security Manager (DSM) to setup a device security context. A DSM
> > is physical function 0 of multi-function or SRIOV device endpoint, or it is
> > an upstream switch port.
> 
> s/SRIOV/SR-IOV/

ack

> > In error scenarios or when a TEE Security Manager (TSM) device is removed
> > it needs to unwind all established DSM contexts.
> > 
> > Introduce reverse versions of PCI device iteration helpers to mirror the
> > setup path and ensure that dependent children are handled before parents.
> 
> I really don't like these search and iterator interfaces.  I wish we
> didn't need them like this because code that uses them becomes a
> one-time thing that doesn't handle hotplug and has potential locking
> and race issues.  But I assume you really do need these.

The underlying assumption is that the first generation of TDISP capable
devices will have a Device Security Manager (DSM) for all the SR-IOV
virtual functions of the device, or the card will have an embedded PCIe
switch where the Upstream Switch Port has a Device Security Manager for
integrated Dowstream Endpoint functions in the card.

The expectation is that physical hotplug for these cases never happens
*within* a security domain. The entire physical function is removed and
by implication all the functions the DSM watches over.

However, this does highlight a miss for logical hotplug of VFs. This
enabling wants to have sriov_init() check if the PF is connected to a
TSM and if so perform a late pdev->tsm->ops->probe() to setup any
context needed to allow the VF to go through secure-device-assignment. I
will add that for the next version.

The reverse is already there... any TSM context for to-be-removed VFs is
cleaned up.

> 
> > +++ b/drivers/base/bus.c
> > +static struct device *prev_device(struct klist_iter *i)
> > +{
> > +	struct klist_node *n = klist_prev(i);
> > +	struct device *dev = NULL;
> > +	struct device_private *dev_prv;
> > +
> > +	if (n) {
> > +		dev_prv = to_device_private_bus(n);
> > +		dev = dev_prv->device;
> > +	}
> > +	return dev;
> 
> I think this would be simpler as:
> 
>   if (!n)
>     return NULL;
> 
>   dev_prv = to_device_private_bus(n);
>   return dev_prv->device;

Agree, in isolation, but next to next_device() the style looks odd. So,
go back and style-fix code from 2008, or make 2025 code look like 2008
code is the choice.

> 
> > +++ b/drivers/pci/bus.c
> > +static int __pci_walk_bus_reverse(struct pci_bus *top,
> > +				  int (*cb)(struct pci_dev *, void *),
> > +				  void *userdata)
> > +{
> > +	struct pci_dev *dev;
> > +	int ret = 0;
> > +
> > +	list_for_each_entry_reverse(dev, &top->devices, bus_list) {
> > +		if (dev->subordinate) {
> > +			ret = __pci_walk_bus_reverse(dev->subordinate, cb,
> > +						     userdata);
> > +			if (ret)
> > +				break;
> > +		}
> > +		ret = cb(dev, userdata);
> > +		if (ret)
> > +			break;
> > +	}
> > +	return ret;
> 
> Why not:
> 
>   list_for_each_entry_reverse(...) {
>     ...
>     if (ret)
>       return ret;
>   }
>   return 0;

Again, for conformance to existing style of __pci_walk_bus(). Want a
lead-in cleanup for that?

