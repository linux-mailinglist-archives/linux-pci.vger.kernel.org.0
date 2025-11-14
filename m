Return-Path: <linux-pci+bounces-41273-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B0DC5F36B
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 21:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6B8FC35AF10
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 20:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A6D3431F2;
	Fri, 14 Nov 2025 20:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kzMVnhaV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6C42F9995
	for <linux-pci@vger.kernel.org>; Fri, 14 Nov 2025 20:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763151556; cv=fail; b=juDGxV7d1/Yy9Yl/CtHXLPQ5o2c2PJdy/XHrCoThIPY1Qoz3w6p0S3l8eiSx1Uk7BZMxqJRpzrbLolJ4bRyk4C1siimK7z7882rumS5xdTJF9mCpb4Mt7rx+py4/6fN9bAFc77i/g5u+2YLmSgN/q0GXBmZ/YeFil043E/kPxro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763151556; c=relaxed/simple;
	bh=TzWk6a2IUZh6P10oM1A27yARimClJ2LfaY4rXs5e5iE=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=csK09Nc5yIT8xNomGLXfTZt7fJtn1C2w6BiOkBrM0vz6cePfQChrMzqMTRbzYGv+pcJQjIi5gH2fDYVrIDw2OHp7dFOHFn0GaM7fBpEA79G05DJl7PWtql+xjR/e9plH3eLW5Ku68nAW+gvqD2OcIE2+TFKkHXOpH/AYcJYq4DY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kzMVnhaV; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763151554; x=1794687554;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=TzWk6a2IUZh6P10oM1A27yARimClJ2LfaY4rXs5e5iE=;
  b=kzMVnhaVGw3ITNuaPEOp3Oklej1yswdN/Vu+kh8WYhPxv2F+GUV33Omi
   79HunRQjUTNQCQdQLOi2vAJmZmD4qLRFKjOpd51DgcCGQVKEnfqZuk3Mx
   S/IgR3ZwsQ6gpmB3K29z0Y6m6NJ2qMT5/xaVjS1ouOnLTzeBXc4E5NOIX
   wQxytDAelDsqewuoUPgPE6vSsfy1suPVUelf6pCLHQq8+iEcREb/X4UoW
   bYOnZqSS4MoJAwFDpMDBSh7/RVqnjvmMjOb6K/1eUWZyd0AiRRwnzsR21
   PlC8ZLzQBb7CcicT9mN9tMxVM4RSTp5hJ0syurdmQgPyjUsI2S7JNnvYm
   Q==;
X-CSE-ConnectionGUID: +8YcYMkmTYOD8KsQEXx+Wg==
X-CSE-MsgGUID: FQJv4iXoTfSNuvErh+K2JQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11613"; a="52824988"
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; 
   d="scan'208";a="52824988"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 12:19:14 -0800
X-CSE-ConnectionGUID: fhqVqVP3QzS0FM5l0dOKyw==
X-CSE-MsgGUID: kZ1zXPUmRmio4DCk2aTWyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; 
   d="scan'208";a="227209012"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 12:19:14 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 14 Nov 2025 12:19:13 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 14 Nov 2025 12:19:13 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.0) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 14 Nov 2025 12:19:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AqDYovtzLX69kjc9zjk6et7RG/7NM2PyXxpxXtYa8zXyUnGKQ86FffM5rxzi60b2AOE+UA1IgiLK8cjzYABapOJZBkelvLaZZCS9z9LxdbMoC1e0WPRxdiL/2l+HY1uk86F51fO7qItzDs1TOlJD3oESCop/dCkBXDNs7euF9i7rXz7PQv0PsiRUCZavm8YSYC8XpbozMtG2ujzNMO0YlOb1FcXVGRSZ4GzxGIJ1uR5eHcv60AXcKFIhbDIWg4Jd+qWXizq0FMX08jadTgUjnF+JT/Z5okLzGjtUCrJ8+7zFFr3zZm3skoCK3FjodqlZQvszJXNnVnEkvzdt+dwzkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z60UeC7cUhh4xmN1BL1bYLywbCtFkdOp/NWTTz4iTUM=;
 b=vtUjCcTsp6k5bRVySoSQSlf/dd8VFHFedWpKXuK82V0jtwEj8gl/arcojH61ISDKETZCL+JFVrdiBOOKxQve7fnT6DXUZCoGNAiqYmvVOsRtLQDKitlSZ8kDCkpB+Tf7rJE/BAlaNw9ESKKXq1tvZtj/LOOaznuRjt7aZE5dvZUWpRK5ChLJPKdR0lKr9B4bdFBVF2JkCNGmCFN/PQqVCfyAV+syvssUwwdSDIaitq8sN8gIkeiiiCAqG6/gen9ENvhfBq2V0D0u+tfmxolvNOEQ2CxKRYSryXAzNhrk1BwiHWoDAdiXafgOYPcNLJwVGRi3CjhXN1Vj9ETqgKtP/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB7036.namprd11.prod.outlook.com (2603:10b6:930:50::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Fri, 14 Nov
 2025 20:19:11 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 20:19:10 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 14 Nov 2025 12:19:09 -0800
To: Xu Yilun <yilun.xu@linux.intel.com>, <dan.j.williams@intel.com>
CC: Jonathan Cameron <jonathan.cameron@huawei.com>,
	<linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>, <xin@zytor.com>,
	<chao.gao@intel.com>
Message-ID: <69178ebd69506_10154100a9@dwillia2-mobl4.notmuch>
In-Reply-To: <aRVHpdQ637ltYJku@yilunxu-OptiPlex-7050>
References: <20250919142237.418648-1-dan.j.williams@intel.com>
 <20250919142237.418648-21-dan.j.williams@intel.com>
 <20251030112055.00001fcb@huawei.com>
 <69093bf7d6ee_74f59100fe@dwillia2-mobl4.notmuch>
 <aQwvsbZy50ac+xid@yilunxu-OptiPlex-7050>
 <69128889c6c2d_1d911009f@dwillia2-mobl4.notmuch>
 <aRVHpdQ637ltYJku@yilunxu-OptiPlex-7050>
Subject: Re: [RFC PATCH 20/27] coco/tdx-host: Add connect()/disconnect()
 handlers prototype
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0005.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB7036:EE_
X-MS-Office365-Filtering-Correlation-Id: 8de185d7-63aa-4d94-5ced-08de23bb1249
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TVlvUVlmZHBHS1ljY3dER1Z5ZXFlNkFuMmRpYXl4eDg0TTk5SElwb3VkVGJr?=
 =?utf-8?B?MThOQkdGQjlUcUI2Zk05QjRtUG1XSmlFQTZKN0dzRFp1VVNDQUVtR0h5akpK?=
 =?utf-8?B?V0FjYzUzT2lncnVrUFhrbXhmOGw1dlUvL0JLaG1OZEtPdzlwTEROWGc1RjVQ?=
 =?utf-8?B?YzJxRjIwZVhSbFVna0xwdm9TZFF5c0NlWjBDQWFmaFdlN01Kak05c201TWp0?=
 =?utf-8?B?ZFhRYW4vMlhRZ092V2tyN0pLbEVIU2M1Yk5rMmE1ajVPanp2UjBTWWd5cWNz?=
 =?utf-8?B?TUtwQWUyaXhrS3hJaGM1d1VxM1M1YTlKVkZkNzMrODVkRmtNWVdQUmlpcTN1?=
 =?utf-8?B?Y2gwdzVQVWE0RHYvTElObDd2WGc2RktoS0tHbEtOYnl3UzQ4NmFTS3E3WG5o?=
 =?utf-8?B?UFI5d0laaElvVzJjbnlTNEd4ZDJld0FiK3VKZEsyUTh2VC9vWDEvYllyam1s?=
 =?utf-8?B?NHJvRVlHc1ZuN1IvR2lzN0g4QTVSMkhRaDhWdG1YVjdZWWhSQWZrcHZoZVVB?=
 =?utf-8?B?MDVxdWNvTEhYWExrbWpqcnc5R0I1M1hHQmttdCs0VGNCQmkxaHpBK1U4ZnVZ?=
 =?utf-8?B?Mi9PYTVwc0Z1ejFKZUt4RlZJSFpjZHhhS3dIRld5Mkt4Qkl1OTdoNkpXNUti?=
 =?utf-8?B?NXZ3R1ZWQ0UxNlNXQ0kxYS8vakFHYlB3YytWVUVyZlFGbyt1YzIvdlJHVnpU?=
 =?utf-8?B?aGlDOW5FSmtkcXljWTRYUnlHMXVXc2Zzc2ZmUUtlakd6SEduVTlvMXdINmo3?=
 =?utf-8?B?a3dHSkRBRDV3T2FNUUkzZmN2c2VuM3dyNnROeEtadWRJdHpLWDRrSkpQbUla?=
 =?utf-8?B?cHhXcVlZRUdRamc5eUV1ZmJWdGk1OGl3bVFFMExYN3RQUDgyRHdUcGM0ZGZX?=
 =?utf-8?B?b3RSYW04Y0IvM2I4LzI2VzlRb1RzeFdpN0hGVTFocmRCcWd4VGl4WTJjdGV0?=
 =?utf-8?B?SW1sajFIblM5UGZNNVo5UG14RzltSVJWVTJwelZxaC9SZSthTWRGTkpJU1NW?=
 =?utf-8?B?VjJOejRBdVRjM2g5eU9VdXBwMUVjdWVKTTFjR3RKMzFDUmdPOUhsYWhCV2pu?=
 =?utf-8?B?QnJML29mVHg1OEJRMTF4NXhIN2NaZmhjcjdJZi9UQ0VMRmJ2YXBUUW8yRDRN?=
 =?utf-8?B?eW9aMTJkVnN6SWN1dlVLVWZ1UytzWkVRbWk4L2x5dm9tRmVGOVQvMVd2RWJK?=
 =?utf-8?B?MWRTT3YybTJ5d2ZtUGthTEhMZVU0TmFvUjRyZzZ3VU82b2xJcWdMbnd3SzZ2?=
 =?utf-8?B?aU9TWWhtQkV2clBwc1NWNE12NndCSmJ4SnFwTjdmN1lxUXpoV1U4RkxKRy9i?=
 =?utf-8?B?Q1dDQkIyL092NXNVZW1lc21SWW5Hd1hibVlaWEd2MUdzS0FJd0s5czRqN05t?=
 =?utf-8?B?VGxZTmJHSDkxVUdONEs0MVl5aWRnRElEK21HckNYcDVYVENZSGpJMDdEdmtk?=
 =?utf-8?B?SzBwUk9UWW1aOFRzNHlwcHVzS3BiVStaK29kRmZoUENCZXZZVjNNMTgxM2NI?=
 =?utf-8?B?ODlZS2hSdGZVSkkvdGJLUTYya0pmTnRIb3BRNjgxVDk1WG1UZWFXVHMrTjA3?=
 =?utf-8?B?N3pBQkRuU3RBV0pjWkRkcVRvMEY4dHN1REExVEhqdWNPaVhnTFFNMEVRdmlv?=
 =?utf-8?B?RThIVDArdmFjUXFhTFpjUUYxOUxLSS9pVTlxWWJUdVhsMUZQMFhwTjcrMTVt?=
 =?utf-8?B?QlRuZlVJeW9Zd3F0MkhmTUg1R3JQRzRiSktyMmlZN1FZOFRsbmgrUkJHLzM1?=
 =?utf-8?B?Q0xuZHNyQ0NvRGtmaUcydG9RempBeEVLcXdqVnJ3Q1RybWVRZFdhVGd0MHdi?=
 =?utf-8?B?US9yb29sLzZKQXB6UmlQMXNHekIzZzZ1Y0hDWEZvczNSeUFpU0JId3FLemlp?=
 =?utf-8?B?cTVHNkFXNXlNNHRxSGxscklMZWIvUnVZa21nSlRQSEE4VVRRdkJmbHVCR1BV?=
 =?utf-8?Q?OV7ZGNxDCpDqIsgQbrwSLnjNWYiUSUrQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3RSQ0FMZU5nMzFuOXArZFR1NUphYzhBcU8waDJtVUhEb1h1VTFVRllXYStt?=
 =?utf-8?B?L21leEF5SFFNM0Z1ekZHTXJ4b3hPTjFGRk12QTBLVmJqdzk2R0JFdU5waWxX?=
 =?utf-8?B?WGNDVmJTL0Y3NjhFUmpkV2VNZmxzc2V3U3pjbDk0TlRjRENObkxPQndoSXkr?=
 =?utf-8?B?MkN1ZUN0Q2dQZURXZ1UzVTlraDg2Z0tSNGFMZU9Cei9vbEkwZCswU3kvci9h?=
 =?utf-8?B?ZmV6ZWJ5ZTg4c0dYRjdJakRxbEpCZTJmYnZKWlBBMlpvZlUrUzBiaEwvSXdI?=
 =?utf-8?B?bWpweklKeWJXYnB2SWhVU0RTYjZ0WXVpWUNBU3hOOXQ0MGtsUVpBTXAvTFBZ?=
 =?utf-8?B?NnpCd1VvaUJoYjA4UDF4a0Fudy9FUUhmdW8ralFTQW5lL0ZHNGswU3gvRnNj?=
 =?utf-8?B?MEdHVjJDVUJMMHhDOUVrT3BNQkhxM3NzNzloWmplL2MyU2pYQm9nUXcvL0xk?=
 =?utf-8?B?bHZEUkdUWjBNWFdqbnhJS1VnSzNsZ2N0QTlGVXJVVk5kUVE1b0FyNGErL1B3?=
 =?utf-8?B?bU83K2g1K1JpNmNxTE5uY3hrWDg4MFo4MkltZGVsczRCME1kODZReWZJSGtt?=
 =?utf-8?B?dHFydHZkNkpUelNhMEJsOFpmNzgzdVF6QU1qTk0yWG5lcTE0eURKd1NCZXlM?=
 =?utf-8?B?T3EybU51bS9rNE5TMlVGUmpTbHZ6Sk9iVnRqbzZ2ZDFJdGVaZUR5NW8ydklr?=
 =?utf-8?B?UzR4VXhjUXRTYzhkK1Npd0MzVXV3UGJRVEdQKzIzai9XNm1zZjU0emlJR1hY?=
 =?utf-8?B?QlF1UTRkd1RsYzVTNlBETURVRTd3cXdQc0MzR3Znd1RUR2xsSGI1ZzJYVEIy?=
 =?utf-8?B?T2hNM2hlSFlSZjB0Y1c3K3lMMjJUU29nc3loUmprZjNJUG5YV0UzNFR4c3NW?=
 =?utf-8?B?YVc1U2hEYU1qWnBnaEszcFoyd3VtRVZBMUxtWkc1WlBzS3NRUHpDT3IvNUYx?=
 =?utf-8?B?aWttbWxtOVJBVUVCOVA3RlhUWnZOSHVKUjU3K21yeUlkNE90TzJVR2lRc2Zo?=
 =?utf-8?B?NXFsMlVETm1hcUhJaDBLWUJ3dTlUQnRRQnhYaEhVZ2JmT3FrMXU3WXVZTVh0?=
 =?utf-8?B?cDRqN2l0eUdaWDRJOXFTQmgxQkxUQmhmSm5PRzFBelZSY282SS9uRUY3b1JD?=
 =?utf-8?B?clpjb0VOZ0NNRG9IcHRBOFZGYWRCQnBoUENvQlUweFZrZjB4d2s5T2ZVODJB?=
 =?utf-8?B?NE1RTVpJTkFxcXpCNkJCanhqd0tjc0ZWLzBWSHFLbXQvTW1TS1h1cEZQN2dZ?=
 =?utf-8?B?V2duNG1jMnhWdk9uU2YxZ0ZuRVB4NkZQeDRYWlY3MGl0Y1I3RTQ3OHI1UVYw?=
 =?utf-8?B?Ylk1UDhFd0xaYUEvdmJWa0xnaG84L016OUt2VXFhdmZxQWFnMjlUMWFCYTNu?=
 =?utf-8?B?SnlzVnJYdTlqQW14RG5rQ2c4RkczMFZFNHJZMEtHS3hDZ0pHOGZVN1VpRUU5?=
 =?utf-8?B?bHVDRmZYQzhyV3h4Vmhjc2pUVU1RU1M3VUpuZ003VEtrUTdKZTNHeURrNVFy?=
 =?utf-8?B?MlNmUm1Edm15c1IvdE8wVlc5b2FZdGtuYUp6ZGt6NjBhdXkzUEpDSThCcktL?=
 =?utf-8?B?R01pQ2lXUWtUNUhmT3ExeEthSzI4VnR3MFVCWkhGOTVreU1aaXlkR2xBczEw?=
 =?utf-8?B?TWRySDJFdnM5bUJhRDJlTERpbkJQWjBrUFE5VjJDSG1FOTZ1NjJvZ1JVbVRK?=
 =?utf-8?B?K3F6c1cyKy9WSXpoaWFtS3NFRmpKWC8yMkc2OEdjdGYyVFh0UmR6Lzk5QVFn?=
 =?utf-8?B?TEFiRlcxRi9ueXVxQ3Z3NWdiQkVTeUFjSTNjekhSZ1VLTEhFQ01NRVhHL3c1?=
 =?utf-8?B?bC9FUHRTaW83QVp4bHE4Vk0veGZ5cGxGOFJEM0tMamk3UWxVbGd3UmFvNGpo?=
 =?utf-8?B?WXVmcGsrdkVtQ2tvZVJLU0Q4bkFVVWhYRmhBdjJrZkU4bjhQeDMyTTlrSHdN?=
 =?utf-8?B?QmFPcXZWTm9hZ0MvL1NsUFpHc2czSUZtREYrbTZNYnZKNUZYcCtHU2lrSVRu?=
 =?utf-8?B?Y0t4SU82T0JGRVFYcDAxdTRBd3U0T082L1ZqdGYwYU5sZWQ5TVhUVk1OUmVk?=
 =?utf-8?B?NnVJaTNXWTNrNUhnMDE3eHJzdFkwQUsrMUhmVGpmVzVCeGNPYThRSVFQM3BY?=
 =?utf-8?B?Zm92UmprdTZyRjZEWG1zOFRWbjFIbjZKcFVneFVubElERVZHcVU5VU90TWpR?=
 =?utf-8?B?ckE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8de185d7-63aa-4d94-5ced-08de23bb1249
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 20:19:10.8097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K5CQ8Y/Uf9G8+BI6uUi83KFfqfIGrB+VWkPJnPB1KX0YL7ZACgdTCZil4FgV6hZeLum6j2qBtw9wTvpU9b1/6e3zcR2g2JfTKa+yq8recug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7036
X-OriginatorOrg: intel.com

Xu Yilun wrote:
[..]
> IOW, I like this current piece of code cause it is in perfect balance.
> I don't have to change the mindset much for code design. I get the benifit
> of auto-cleanup, and the local cleanup handlers (tlink_spdm, tlink_ide)
> are cheap but clearly tell me what will happen if any step fails.

I think in this case of conflicting minor preferences the tie goes to
the submitter. While I personally think the discipline of clearly
delineating objects and ownerships yields maintainability benefits, I
also do not hate the model of "extend existing object with scope based
setup".

So,

Acked-by: Dan Williams <dan.j.williams@intel.com>

> > > 	if (IS_ERR(tlink_spdm)) {
> > > 		pci_err(pdev, "fail to setup spdm session\n");
> > > 		return PTR_ERR(tlink_spdm);
> > > 	}
> > > 
> > > 	struct tdx_link *tlink_ide __free(tdx_ide_stream_teardown) =
> > > 		tdx_ide_stream_setup(tlink);
> > > 	if (IS_ERR(tlink_ide)) {
> > > 		pci_err(pdev, "fail to setup ide stream\n");
> > > 		return PTR_ERR(tlink_ide);
> > > 	}
> > 
> > No strict need for scope-based cleanup if this is the last resource
> > acquisition,
> 
> So if we don't do auto-cleanup for the last one, do we still need a
> structure for that? If not,
> 
>  struct tdx_link {
> 	struct tdx_spdm *spdm;
> 	
> 	int ide_stream_field1;
> 	int ide_stream_field2;
> 	...
>  }
> 
> seems so wierd.

Yeah, a little clunky.

> > but maybe there are other PCI/TSM core things to do that
> > are not shown.
> 
> There is no following items for now but I think cleanup for the last one
> is good. Otherwise we may face with the same problem as goto, that we
> see unrelated changes (add cleanup for previous one) when we add a new
> step.

Again, this is a case of I still disagree with shipping the dead code,
but not enough to NAK your preference.

