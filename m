Return-Path: <linux-pci+bounces-42669-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6B3CA5D6F
	for <lists+linux-pci@lfdr.de>; Fri, 05 Dec 2025 02:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 283BA3031CD0
	for <lists+linux-pci@lfdr.de>; Fri,  5 Dec 2025 01:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FC51E3DE8;
	Fri,  5 Dec 2025 01:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OBBOSv3l"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3861BEEC0;
	Fri,  5 Dec 2025 01:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764898397; cv=fail; b=t1krC7WlEsHkJs5jWDS94euwwcSnEQtSEeXBi23hStfbJZCwx7hbxQ4LqdOBsDAfq3f56wdWZ2SdaVl18k8iHpnTKgON1yfIrjqNeHsjhLsBfR9+uUzFt8nFc06MB0dtCFx2tFvyi3QzC0xf/Ey2KOFR7o1E3ZSToXKesZcDbtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764898397; c=relaxed/simple;
	bh=LK9G6gsPdqxYGETQbhhmJV5YkWLKopYCKUrPU4UDTaA=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=pPLdylmEcVqMki1NP7sPhPl7bezUxKYayIswdtaI5Gweu+LXDGPhZ5DcDxKNFo+XNFWdMIpaUZ08VzSWXtfejYUEf93xenSMuIHO3LdSZcb4dUMXYTQdFhNFLvv43dBYpDW2lhmkEFaVoBf1CFrp4FQN/CUPfozQHC/VG07sId0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OBBOSv3l; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764898396; x=1796434396;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=LK9G6gsPdqxYGETQbhhmJV5YkWLKopYCKUrPU4UDTaA=;
  b=OBBOSv3lQ8A/NBiLG7yqXx78HVgb5hHYxEKcjaAIbCl3BvEMQbfq0jt5
   Z/uAvsbZMoWokrCvauMGVJ9pyRC/qev2VIlNaWwp7LEuJoZBciPLOq5e3
   7yxXusn64cgw1iSNAxO4xkTMoZrO07p5mekn8yIM01n9bSnU6+yQ+OQsT
   6183sWEYGH9074g8KLLmS3TrvzjU/4YrwZdLFR9WbnMZD1rdthz0417UC
   kO94Q4zqwfjuq22DGXINFFuN8JzQJruPjPqxCDfI6vMR8WaBsN1fFgXuP
   zyzEhqdgLhrAgufOW1zwwKGJ/lr9z4rlOAmBIPWy9fOyFWgi+Un/U8MzA
   A==;
X-CSE-ConnectionGUID: D7GB8OfaTRCisCI8UQgALw==
X-CSE-MsgGUID: TnsuDTSwSi2JaxfSPgGDYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="84338412"
X-IronPort-AV: E=Sophos;i="6.20,250,1758610800"; 
   d="scan'208";a="84338412"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 17:33:15 -0800
X-CSE-ConnectionGUID: vFV42eo8QHuYuKqW9u30Xg==
X-CSE-MsgGUID: cmNPBSTNSbKMXrgBd28c9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,250,1758610800"; 
   d="scan'208";a="200108425"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 17:33:14 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 4 Dec 2025 17:33:14 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 4 Dec 2025 17:33:14 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.20) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 4 Dec 2025 17:33:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JwH+oXnE424tblHJK+2k0AHGHXc5cemYqDnZRB2ozLikn+qcWk3JVmsx5eFgpWxONHCAyMncWiKZfnIezZH8/KY5aiIjAUWY3HMjJRGnkdhUrmCWCZ3RNZG/oldgJkyZnLXZZKUshZz2wEZYAPYyp1ijTczqNXfsd3QL9JNJ1XHjRZbEaWIc2Mu5kPyniLrCbtQWufqS7CT+AJ64xPo/DcTzYBW3OaEnsBtf7bdOd6y+jA1sc7r94tZZndfa8miHGdmJOdQeC95mST3v4pEceX2tYA/cUrmDrIY6+IMoKrkKw9OuSa4s3eomweBqWAiYYrWeq0YucOAX3PlN22VCRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QPTM4aXJK5xa0Q7OHdSgNproIUMdtzXGeoKNJGlRdUo=;
 b=H4aiy6dhwNpZxOsW/7OybACmuI0FY9Skj6g716DK1aLb8vOuYp9fQjd49TOM1vQt+sMcGoTsfNyo3ZKxa38R+c0xtn7IjSOkBWINF/4/EVfq6KkTC2LA8MQwpcojf93t6wVHvBQiVX5vJdBD9hfHRG19kv4m0f1f3/PdIbvSKUDK3gnlbsltWnUIKOid3Oi8nv8A7jR9+K4WFvDf3b3ZYtOHlhu9mIoNgKqEB5xk4SDoZNDSEUHkioaJYMuAGPBZdHt8BS6l9uL9f1ig0P6To4EQFawIkv6NjqSIjAh7fSpOa9QgU63YgzyOE1+Kz1BgEBxR05dxxV9QEafdfaKkpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN0PR11MB6009.namprd11.prod.outlook.com (2603:10b6:208:370::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 01:33:11 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9366.012; Fri, 5 Dec 2025
 01:33:11 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 4 Dec 2025 17:33:10 -0800
To: Nathan Chancellor <nathan@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>
CC: Jonathan Cameron <jonathan.cameron@huawei.com>,
	<linux-pci@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, kernel test robot <lkp@intel.com>, "Nathan
 Chancellor" <nathan@kernel.org>
Message-ID: <693236567384d_1b2e1001@dwillia2-mobl4.notmuch>
In-Reply-To: <20251203-fix-pci-tsm-select-tsm-warning-v1-1-c3959c1cb110@kernel.org>
References: <20251203-fix-pci-tsm-select-tsm-warning-v1-1-c3959c1cb110@kernel.org>
Subject: Re: [PATCH] virt: Fix Kconfig warning when selecting TSM without
 VIRT_DRIVERS
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0069.prod.exchangelabs.com (2603:10b6:a03:94::46)
 To PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN0PR11MB6009:EE_
X-MS-Office365-Filtering-Correlation-Id: 7de590e6-830a-4f1a-5157-08de339e40b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VHY2MWR5KzlGZngzaFV3SWkrdURSYUJ0a2krM1JTWkpGakh6bVJ2OVFBaWJQ?=
 =?utf-8?B?ZjA1c1hZZUQrUVRIdkhrdVByMk9LRVlzSXpnaFI0dG9WMldmMGlETjQ0cllF?=
 =?utf-8?B?MXZLMXJxaVk4MUpVaXg1Z01BVVFRbzNGcEc4ZWEwOHEyMnJ0ZHliSERrZTgr?=
 =?utf-8?B?TXlJcEdMY01PTEc0Y1M0TFZkM2hqSzVuVkdGUjZOeERiWkJGUytDUHFMd3pv?=
 =?utf-8?B?M1pQeUdBaXRHZWlPNm9pMmxlLyswcUkvYzRSOTI5N3lEK3NNcDI5SnZOSnhq?=
 =?utf-8?B?aHhYNXB6UHZzLzdjZUROY0FIVnlxdUE3Z05FalErWTBDR2Zyby9JQ0xnNDgr?=
 =?utf-8?B?V1BwMGlXT1NxY0NrN3hzeFBSMmEyaUVJam0vTUVrQmQ5cVdzdlRwbHp1Y0Zm?=
 =?utf-8?B?VEplQUhkbjlkS21iM1V6c0lEM0tDR0Z0bTM5VHFvb284TjZRbHJCZ3F2VHUx?=
 =?utf-8?B?MUtjcjBQemI4UXd6VzZSNExyRDI5RmJFVVROZ1NBNTlFWElMVHlHTlc5Mm1I?=
 =?utf-8?B?Wlcyd01xcFZOaFZhTkpxSjBGOFVhSnc3WmtHMDhxSm5WTHhKOGc1SUtTWFJI?=
 =?utf-8?B?NzVzaHFhRDdzWUxyc1BqK2cxR1NkTFpYaFhMQmhaQVRpRGJ5ZEFSQnNCWUdx?=
 =?utf-8?B?NmRRSTVuQklxUUZUWGlxUlVYa0U5bzhpVEdzZmF0QVZldlVTbzdJOEpWd2RR?=
 =?utf-8?B?akNUWUZyaEFySjljWXJWcUlEMCtsS0RFUkNucDBpWjN3bGUzc0xIVSs1THNF?=
 =?utf-8?B?Q2RCWVV6TWdIcGZKSnRUcWI4OE5oMG9DQ0FGYWR6RjFGTUVXOTV4MlA1ZXhS?=
 =?utf-8?B?dGY4UytJc3JTdnd0QjhQSFdSc1BRNUJJSFpiR2hSUFdITmU4UHIxTk5EeUlX?=
 =?utf-8?B?alE5SWY0MkRYemdoak9sUFFPa21aeVdWWkw2M2JnUVRka3RyeHRReTZYY045?=
 =?utf-8?B?ckswcGpnVDN5VnJsUDRKck9zUzFmOGdsYk1ibFRvUUEySFl1UEF6a0szV3li?=
 =?utf-8?B?c1lXS2N5RzR0Z0VQUjB1TTlqRUR6MjQzeFYwZzdGVDJsM3dsVkVDdmhtYnUz?=
 =?utf-8?B?TkJIWVFrdzdMTGdvRGsvOTJsZFlGYWlPWnpxTjl3dzlHS0QyTmwwcVVSQUFu?=
 =?utf-8?B?RHlTdmNMWVJ6NmFhSyt3c3Q5TzVxd29SN3BNRXFXbHRrRXoyUjZLRS92ZnBX?=
 =?utf-8?B?aW1vKzh6TkxMK21jZVNVUW1yVkZYUm03K2ZScmtuVmp0NUZIODErMTByREht?=
 =?utf-8?B?QUpybG1kTHp1d2pKYmQzaS82MVNPUzVNQzNJbE9yOU51MkFnMm1vSGlDdXhF?=
 =?utf-8?B?R3hBalF1NTFPdUdGSDIyT0xsZVgxTjFYY2IzQ1paOFU3QUpPZDZpeGlCaUxy?=
 =?utf-8?B?bzhyc3NkcXJzQjJNdjZMWXVKUDcvVTBXNXBWQXFnOG1nUHB3UmtZOEZyb2pC?=
 =?utf-8?B?WGNyOFZwVGNjeTNLaWRTTXh3WnRrWDJTb3p5OG4rQ3RxeEFBVnlwMFl6YkQy?=
 =?utf-8?B?Lzd0Y2FxeFZQaFBXdUJzVTZTejNnMG5WUmdEVFlUT1pNWiszTURDQk9PUnhB?=
 =?utf-8?B?aWFCQzg3bndCelhCRFBRVmRsalkvTGhOU0VMTFNxWThqY1N1T3M0Q2ZkV0M4?=
 =?utf-8?B?YUJVdmlFb1gyaFpFUWxlNFZEM2RmaVY3OUkvZFIydlQ5eWNkVmVFcTZOcmNh?=
 =?utf-8?B?MXhyLzFIVklHME1XQkJLQnBOTVZoSCsvMmJYa0VNc09vMTN0WGRhcHU3ZVk0?=
 =?utf-8?B?Q0lxc0o3bEN2ZEFrOW1iWmJpYWxWTlJMOXYweFRjekw2d2FnNmk3a09saHlV?=
 =?utf-8?B?MENoSGVhYXJpRHBxengxOUFZV1VuVkhGTVNwZ3UvSUVaczRleDE1SmRxdjNq?=
 =?utf-8?B?OFdWcThROUZ5UGoyYndodHF3cmhYOGIxdVROL1UybFY5UU5KbGlxd0FwVkl4?=
 =?utf-8?B?b0wycWxYeis4Y3VEVlZBZHJRMjRxVTkxcUIzRmZxbXZDTFhJQ2IxQTNnQk9r?=
 =?utf-8?B?cnhRTFB4YktRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDg0a09EWU16QjdZa0xQTytGblRScWpYbUNpT0g1N0xick9zdmRtTFU5YWtW?=
 =?utf-8?B?bFpWTGVPYUU5WnRQTUoyTTN5NnpkUDhmTFJJL0xoWU1XcEhsM0JBcjA3dWx4?=
 =?utf-8?B?cXhzM2hsZ3czN3NxUjBDV0VhbmVuRlFacnlabFZTTDhjTk5IOTJubVJIam05?=
 =?utf-8?B?RDZpZ3o3ZTlIcG4wWHFKa2Z5RFJtTGZFb0VLNGVPSit4UVVtQkM5QjFSempo?=
 =?utf-8?B?OFc5N1UzcWlDYlI4TXU4aEh0ajNOMFJ6ZUZuZXkzWkZRbDI1U1ZycTRJQ2hU?=
 =?utf-8?B?Wnc3M29xbFV4UVYyV1JCN2M1VmQ5TUptYkxYM0FUVnVYc3ViM0syZm9vTnJz?=
 =?utf-8?B?M1QrcEg2TWZiU3FEMHk0emZuWHYxb0hzQy9KdDZYMndVVnFKYldHazNjSS9S?=
 =?utf-8?B?b1FJQWV4dWJJdWdNZzkvL1M5QlkwTUVJc01WTzVhTEU5bEw1YUtZTkhZRFc4?=
 =?utf-8?B?dnhlSmljR3ZTSlhOR2p1RWVOZmtydk9md1ZSMGxJT1Z0YVhNMjdVSlBzVUpS?=
 =?utf-8?B?RUtkLzVaMENZS2VNTmtFRG1xcFVIbUxVbVZFdW1jQXJmQUNaWmhZVmRpNEd1?=
 =?utf-8?B?WnplWHk5Vlc2UXFNVTBLNHVBSUIwRnY5Rnl4bm9SQVIyaWNUTjVEZkdSdkR4?=
 =?utf-8?B?dEloRFh2L2J3UHRXdEFOWGtxMWFVVUo1NmFMamlRUDJEWWdPL0I1Umd0YUZW?=
 =?utf-8?B?Tk9ZMTF3eE9sRTF5bGUzdVJzQ0JQT2p1NndHNG5WdE5uVHFUQ3VqUTdZaDNQ?=
 =?utf-8?B?cVZDUldtRDJFTUhOek9mQnRTSVdTVmZGNDFRNVdzVDNFbklnV2ZNWXF0ajhC?=
 =?utf-8?B?ZDRMeXVIdFo3RFdCa3V6QU84TjY2aWVqNk9BNHdnU0ZmRzRhZHQ0M016ZCtk?=
 =?utf-8?B?UmVmYzYrWVpaa3pmNUEzRUdabDRFVS9tdE1UckszcXlmRTJyV1RUcklhWEI0?=
 =?utf-8?B?dENIcWhZVkl6SGdWZ09qdmY5Ylh2VUk3YjYrSFhWQWFVdHpkUjR5d2RMNGhj?=
 =?utf-8?B?U1FVQWgzaGdmSnJTUS96T0xVOHhHZktvT3ArM3YrU3ZoL0pxM25kZk1nUWVT?=
 =?utf-8?B?UlloUHdqdGVrSHMyeFN1SGZYck9jNWZTc2VnZzFyeUhoc0JEUnJhSng4Zytw?=
 =?utf-8?B?eDNxT1VWUDR1UDd6b0VEOXVneGp1RjE2MVBremJ2dG9GMDA3RklXZVZCVlVm?=
 =?utf-8?B?T1VMMFhTam1tK1QvRXl1S0hJRHE2bzhaTXUrejVXSFlKOUVPb1R3T1hoZXQ0?=
 =?utf-8?B?SHBKcjZBb2tRbTVJMXdmSjQ2KzBZSHZnWTVkN2FDaUpZbVB0WkwzMzJpb2Rh?=
 =?utf-8?B?dDhIYkRkdDgwVGw2R0ZJWnZxdzBRc1Fta0I4SzNsMEpGYTdwdUU1WUxmWjZM?=
 =?utf-8?B?NUlFUFNuR1V4MHZTZzJOQU1NMTdJazhneko1bDNXREFOZGV3anRuL1o5YW5U?=
 =?utf-8?B?UWJTSURWcGVaUnJRSnJadENhcVRLcFd6ZW1nTW9OT21sQ01pMmR2cWdDZnBr?=
 =?utf-8?B?Q2w0TUp4MkIyVHRrdzJINjhwUjRkeFlST3dFd0NBVkpkcG9MMHlzdGZQejR1?=
 =?utf-8?B?YUF5Q1ovQU10amdVaHpCMDVHanF2aFN4S0dIeEtPNmVlbnE1MnJUcmg2dFhF?=
 =?utf-8?B?QTZrWEhIWFpYUmhpVG1wOTVrWk1aSm1XRE0rT3lpTm9IekhmZS9LVC9IdnlT?=
 =?utf-8?B?M1lqL3ptVzZCYVZVOStwTEJDelZBL2ZBMHh1bHFHZTRtTG5LZnMzSDQrUlJS?=
 =?utf-8?B?OG5pR0xBbDRNV25tWnYvRmNzWXhRSlBKZFBpZ0d4c29zcllqL09Pb1kzN1Bq?=
 =?utf-8?B?MXRqTGF0SFJPdlJNQ2JrRXFWejZKUWhoWXQ3Qm5NRXRYN1FhblcyQ2ppYTdu?=
 =?utf-8?B?NnlNT3FYM01VTkFQbUZpMVpNL3FzNjFzQXIyZHk3TlVsUnpZaVBVUjZEcG5w?=
 =?utf-8?B?L3dBcGlWOWROenpJakh6S0UyV0Uvc1ZWbE5vV2ZOK0tiZDlPNmNVMXhWOU05?=
 =?utf-8?B?djZmakd2eEZqMGZxdlVTREZ4R29uWXBjcTQzaFFmdW8yMlZWR1NxUWFuVGFZ?=
 =?utf-8?B?dzlvM2JMellVOWJDWmdLbmliSlV4amFHV3loMWpOR1ova2ZHa2RTOGt6Tkh1?=
 =?utf-8?B?SU9OY0dMRUJtazNRN29YcnNnKzE0YlQ3UGQ4TUFaRGcwYnZ3eUJGZHVocjdn?=
 =?utf-8?B?QkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7de590e6-830a-4f1a-5157-08de339e40b6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 01:33:11.8136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8SYixta8E0BRKtmX8S7C7AIgrn9I4T9fTFrDUiZ+TrVJ5AhgZSfdiNE52G8/3NRCSK7xNZRTxh2GxT66uA7ZpdB1MZGcToTdsY/65/IMC0A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6009
X-OriginatorOrg: intel.com

Nathan Chancellor wrote:
> After commit 3225f52cde56 ("PCI/TSM: Establish Secure Sessions and Link
> Encryption"), there is a Kconfig warning when selecting CONFIG_TSM
> without CONFIG_VIRT_DRIVERS:
> 
>   WARNING: unmet direct dependencies detected for TSM
>     Depends on [n]: VIRT_DRIVERS [=n]
>     Selected by [y]:
>     - PCI_TSM [=y] && PCI [=y]
> 
> CONFIG_TSM is defined in drivers/virt/coco/Kconfig but this Kconfig is
> only sourced when CONFIG_VIRT_DRIVERS is enabled. Since this symbol is
> hidden with no dependencies, it should be available without a symbol
> that just enables a menu.
> 
> Move the sourcing of drivers/virt/coco/Kconfig outside of
> CONFIG_VIRT_DRIVERS and wrap the other source statements in
> drivers/virt/coco/Kconfig with CONFIG_VIRT_DRIVERS to ensure users do
> not get any additional prompts while ensuring CONFIG_TSM is always
> available to select. This complements commit 110c155e8a68 ("drivers/virt:
> Drop VIRT_DRIVERS build dependency"), which addressed the build issue
> that this Kconfig warning was pointing out.
> 
> Fixes: 3225f52cde56 ("PCI/TSM: Establish Secure Sessions and Link Encryption")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202511140712.NubhamPy-lkp@intel.com/
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

This looks good to me Nathan, thanks. I will include it for the v6.19 update.

