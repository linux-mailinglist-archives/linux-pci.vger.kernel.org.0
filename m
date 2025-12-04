Return-Path: <linux-pci+bounces-42664-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0F4CA594E
	for <lists+linux-pci@lfdr.de>; Thu, 04 Dec 2025 23:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C6BC308C79D
	for <lists+linux-pci@lfdr.de>; Thu,  4 Dec 2025 22:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACAE31C862E;
	Thu,  4 Dec 2025 22:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Db7Vq1E2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D6719F40B;
	Thu,  4 Dec 2025 22:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764885772; cv=fail; b=ZsStMn97c2Ylv69WJyRd53ZukSktBY1iT5g+tXxJ/XQOhc0QRnQcA+0O71wqRxUt3AgF0+CieIYNKLyF7D4BBB1qpXfOajywhT3HP7PXfwhNUQKQVMd/3/GUIn/QrKueIffB1cwYPStEN/w+5sv3NvwPXFlGwpR5Hse5BXv3/oI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764885772; c=relaxed/simple;
	bh=3TkRzkCGzwhiYrE6LiKN6FrGPEHjin5lQdJzymajYjI=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=D91ruPBjsJEE2Deyqj0s6aiys6ikRsTRZL60FmDOdLvbqzqo+7nT83E1dTRpzRrMpQDwQUZOXnyOwxnxX+QqV3895keTSdw0rYEETyGH1DY1SPOxekmuCPZ0JZ280+vTZskNETIR3RnuGF+LIF+DWvbt8boVwTEvGzUfOluf0xk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Db7Vq1E2; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764885771; x=1796421771;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=3TkRzkCGzwhiYrE6LiKN6FrGPEHjin5lQdJzymajYjI=;
  b=Db7Vq1E2i5+ac115kz1Mj4O2qNW8g0ra4nK+/nApo/KKLhmZYWv5MhNk
   6kS3So7EoDLmXee9OnpCDAAJQmCB+duu+U4aCoaBwcS6CP2j+HamDQHUC
   SrM7tMggpKZWmIIFN3N+6Mf8zI8uxY+Ef/TA9InRAkjirPo0bbNOBIP/n
   Zz78ImInfoIc2p8XtpWCYUPnu0GnjW5EwXHWYRUVywumu2+tWvvzs8bg7
   XQ2dDlOX2nHSRTQW0VQ7xGs7nieCO1gCKLPNrBD2fCiqJxN6u52il4glf
   BqEDRMtnZ2N8hXPc+X5mhhD7p9iR6gXXPUvB4asq6Lu/4apyiNz7wTs+G
   Q==;
X-CSE-ConnectionGUID: 1yUut0AlROC3pH0MyRmwig==
X-CSE-MsgGUID: UjDDjV6ITO23c6mQanxaTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="70768279"
X-IronPort-AV: E=Sophos;i="6.20,250,1758610800"; 
   d="scan'208";a="70768279"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 14:02:50 -0800
X-CSE-ConnectionGUID: 7bYkDNvlTy6EmphMFCw8tg==
X-CSE-MsgGUID: y6ru+MWTQfCluxigkz/S4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,250,1758610800"; 
   d="scan'208";a="194908348"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 14:02:50 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 4 Dec 2025 14:02:49 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 4 Dec 2025 14:02:49 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.61) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 4 Dec 2025 14:02:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mELk6UKZMtaq5WI5OJhaJVXv00NRmNUEReQAqfNqN9wiZyouThqWz9aYRIhpyxtEayuQzi1KuAJuBs7rMWvZ1UBHLzSfdS+X0QiQRpGjBPNqp9RlZwR7qOPwkTjhdGn9ezKVFTnfne3uY9vziAK1P8evZ7sq/H1icwUeXl2kJuCqgyxDy3+TNd+p4RVeYy32LNyC2jKTwmuzZjItNKdOZJm2zsa+MChVMPvpFm3tFSCV0/Wl/qtBZ+IgRf7Z0TuCql7xmjTaPFXdoBdyJoEz3f3hDmTw08vuKXdFBNXbAVDHT8nEbjLPnz/gdIoVhM6ajiL18+w7ja8x8fBfjaElDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LBNsQQgmqNRrjeFFYMGJXAfVIX5cfvl56QmF+L21ndY=;
 b=P2YsZP0MWHx9sCqsCRBTwxlDssCkK8FscKdPSZWcN9A84FypINJTa+PmzVEDqXT0odWk3Ec8XSCKk6V0RS9z+cxUPxstYxFJ43SuUMCLQGDaBawohPKcN0LB1EhS0kdsmhRDhl9YeqXMgoFiKLZS2D604HowebU7ywK7TWxD7Cyj02Ko2GGCYvMEOohIF0Ep0DjtlrV8pOqrgQQFGnlPpMiYrTOIDwP08+mMbI5zSzdcs2GHQBSs04qclLZaTyS9iG9/F+qsWlkm+3RI4RMcAlrU89TKT6BOOTH3CsD5cY3j5qy5Sqw0SsU3bCBMTK48xuYOJYpJkxh2WCZ7+hzIfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB5972.namprd11.prod.outlook.com (2603:10b6:8:5f::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.10; Thu, 4 Dec 2025 22:02:45 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9366.012; Thu, 4 Dec 2025
 22:02:45 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 4 Dec 2025 14:02:43 -0800
To: <dan.j.williams@intel.com>, "Cheatham, Benjamin"
	<benjamin.cheatham@amd.com>, Dan Williams <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Smita.KoralahalliChannabasappa@amd.com>, <alison.schofield@intel.com>,
	<terry.bowman@amd.com>, <alejandro.lucero-palau@amd.com>,
	<linux-pci@vger.kernel.org>, <Jonathan.Cameron@huawei.com>, Alejandro Lucero
	<alucerop@amd.com>
Message-ID: <69320503ebad3_1e02100e9@dwillia2-mobl4.notmuch>
In-Reply-To: <6931f9127f46a_1e02100a0@dwillia2-mobl4.notmuch>
References: <20251204022136.2573521-1-dan.j.williams@intel.com>
 <20251204022136.2573521-7-dan.j.williams@intel.com>
 <03ec6e1f-bb7d-42e2-a887-70c18dbf4749@amd.com>
 <6931f9127f46a_1e02100a0@dwillia2-mobl4.notmuch>
Subject: Re: [PATCH 6/6] cxl/mem: Introduce a memdev creation ->probe()
 operation
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0012.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB5972:EE_
X-MS-Office365-Filtering-Correlation-Id: 45abcf81-fda6-4dfc-c395-08de3380daef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QklKcWozTnY0bFlYVXFVRjlodWNCWFo5NUdYOE9SdHl0TkpDcmw1eWg4VFNH?=
 =?utf-8?B?RWowYURDUk8xOVBjTnozNXhVODRYMDFOaE8rWlI1R2twcE1SMHNoYkhCeGNV?=
 =?utf-8?B?THBKZnRGWi9WdS9RYU81VG1kTy9wV3k2T09MYm52VXBNTWxtQXQ1bkRwRGp5?=
 =?utf-8?B?bng3ZmdLL1hzSnpLeDlCcVdHKzVkcmNrL25HdENwQll6cGNkK1ozSk0vcFA0?=
 =?utf-8?B?ZTh5dUpxWTFWN2ZyaVE0Vnl0aGdNRjJ6SUpGSW5qVGJJejd5ZEZvQUY0Uk53?=
 =?utf-8?B?anVRSUZIODlzNTNpYzJISmpmTXlManN6amVmcFNWVUtDTDNacVZqdHluU2FB?=
 =?utf-8?B?MDRpQm5vUTZZNXdWNDU2eGdRY3l6N3NGbERyV0hzK0NTTU1PMkxXL0Fud2g4?=
 =?utf-8?B?bnpWeGJpZGJJNFJSSzZmWVdDOVkyRUhodjByYWNYdUdBNHowbmc1TG5BQjR6?=
 =?utf-8?B?L1R4elA4Q0lIRmRIWTVlUjRaTHlGbjl5ODFHM0dod01sTXM3TWo1b2IwRlU1?=
 =?utf-8?B?R3lPcWVrUDZjUFNZclJaMHc3ZHJ3UlVOT2FlNmQ1TUhkMnM4dGtvN1FETXRY?=
 =?utf-8?B?TFFhWkt4Nko4TjRMcDN3b3FuejJZdVc4VWpkU3dLY2NaekZpcko4c045ZkVi?=
 =?utf-8?B?VDBpRVN2STYvenFpVVB1bDMwdDVXSWhWUzdjcS8wTHcyZFRMNytBWFQwejlq?=
 =?utf-8?B?d0FnN2lDaFBaVlNEK0pCMVRGZk85Q29zU1p4MWJOcUFzMk5oenBmcFJyLzZ1?=
 =?utf-8?B?UVVGQ2tuNG9ZdUk1ckZqd2dIeWt4SUdLczZyTHk5YnJTQU9lTU5kOCtsQ2o2?=
 =?utf-8?B?RGxrT2JYSTVUL2FzMnZOczFIYy9ERVRUZXpWWjlZemxZanhkaHRRY0FMeENE?=
 =?utf-8?B?ZUJHMGoybllRdXhLbFJDR0RPVUNEWCtZeGROYTBQY3JkbmhaUFdtellNL0N4?=
 =?utf-8?B?RXQxdEZQd0l1dXR3U2JEWUlqOEFvVS85RmJnVTN5OFZyQVNkM1hWbTVmZU9n?=
 =?utf-8?B?NCtZUGZ6Ymo4b3QzMjBwaVUvTkJhZW5PeXBXVFJ1eDgwR3Z4eGExeUNFTU96?=
 =?utf-8?B?VTlUMml3MHIwdkQ1R1FGdGtjUEJySEg4M01UdU91bHROb3l2MDl1czhPVTlw?=
 =?utf-8?B?Z0t3VUMvcENzTEEyOUlqSDhXOWRvNkcydnhtS1VXWnpEbm9qZTVIYlJrQjNG?=
 =?utf-8?B?VVNzSGM0MXMyYXZCakNyaXJGdUx0N0xjMHl2cHQzSDFuODlNSzZJZWtyNEFj?=
 =?utf-8?B?dUwxemgvOENSU056ajFjYWRySEFVSEdvc2UrTFI5djEvakMzNjJnckt2RnZq?=
 =?utf-8?B?UGRRMEVYS3Boc1RGUFA4bmF3ZnhjckprcXlBT3VRQlBKOGpncDRESmUwVHlR?=
 =?utf-8?B?aWp2YlhiUk8rUVlleUZReGVLL3M4Wk0rbVFrY0liMVFFdUJFa3pvY0lnN015?=
 =?utf-8?B?ZktOKy85SlNpR0NqcUMvOGNXSFVOMkw1ZUJ5d21TV2VEV295ajM4ZjRKbXVX?=
 =?utf-8?B?c2RZU3FMSW0vVThidkp0ZFBTNVFJZzFlaDV1L3JGVHZEV05HNHY2NEp6Z1VG?=
 =?utf-8?B?VWJ1ZjVZRGsxK202REIvVklGdXQ4RENEdkRQNW1namlUalhKKzZ5NCtKMEV3?=
 =?utf-8?B?R0czeWhlTFFjS2oyRnBEQnp2UExZZUVJM0dtTmFwajhvQ1lUWnlvbUxiSzE4?=
 =?utf-8?B?Tk9wRm15cGZPeFUySzViWXpiVm9iNnVBcHlVeG1PWDJnMjB3ZW5nREl0bWJm?=
 =?utf-8?B?MlU1VUY2QVQxN25aQVBvK1JPZVZHd2xGdHU2ZUN2aTB4REIzb09CTmdKQzdG?=
 =?utf-8?B?czVkNm5TazVON3d5N3BBWXFuekYvOVBjVkpkVHFBOXNKN1dCNW4xcHZGL3g2?=
 =?utf-8?B?UGhtd3htcnRpNldjT0RqSE50endYRW5JODI3ZTcwS0U1RmFxdHpKMlpmUmEv?=
 =?utf-8?Q?9fZQ84zU7SGYHOSfaD+L5bRAvxPGD3mY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnRTZVpiaWRqeDI5QWE4SVg3KzZUZEI5VDBZSFd1cjlYY2dGQzh6eDFVL3Uw?=
 =?utf-8?B?Y0hReVZ1MndXWVNTUjlHU2JWQytIbHJnam9HTmlUay83bjAxeFkyWFVrNHk3?=
 =?utf-8?B?bGx2ZVhKcFd1L1ZQR1FPR1NEZnhZTWZsZUdxUG1PaUhWUXdjaU1xS0N2NTZI?=
 =?utf-8?B?MXViazE2MGhJQ1FQVVR0WHVBOHZXYmVMWVpFbVhPdHNzUkdBSEhPRWNKWHYw?=
 =?utf-8?B?SVhTcFluUXBock9XeUtVSFRsQTlwYnErOTVaTm1kbTBzVzdSVXBHVTZWTGY5?=
 =?utf-8?B?SHJ0bXNiKzh1am91KzN3SGRadkFJdk1Dbnhia1BxdjI4MzI5OTU1alJ3YnUv?=
 =?utf-8?B?d0Fld0wxK1JLc1FhQUIzLys5SlJGNEtkNVRBU2xUWm42Z1RxWEN3VCt5Z1Rh?=
 =?utf-8?B?WlJzWmR4UmZPVC9pSWwxSW9SbDV2aGUyQkFvc2o0cmtScy8zTlU5bm1RZEwv?=
 =?utf-8?B?SXJSN2cwaURiVXovZ2xxZ3BNOHlKaDljRURuV09Gb1FrUFEvS0Y1U1dGb0V2?=
 =?utf-8?B?OXFxbXg2bm1zZmRySW5RSVE0eHNiZ3k2QWRYWGVLaE90YXBFZWhPUzFwM1h5?=
 =?utf-8?B?MjNaZUIxQU9NaWxvd1pkdHlJRVY5eWhQRUQ1REdvMGZFV1dYa3hqOU94VEZF?=
 =?utf-8?B?c2dFVnJuRDFsaGtUdXRHbkUxNGFsb3BubG5JclVUY3VlQ3dmNjFpd3lSSlNV?=
 =?utf-8?B?bjBXRFVYb3VoRDVyNGVSTS9xdksxMEs5THZueTJWdEJzMFl1MVJTbGZmbTlO?=
 =?utf-8?B?Q3N3Rlp4V0F6ZkdzQXNrb3Q1MjRVeDhYSXBDSHV4OFRUMU9RYkdudDIreWcw?=
 =?utf-8?B?blZSQ2FBM050bVFZbEhZRk1nejQyYTk2L3dVcExnczBqNGpGTmZteTkybWpJ?=
 =?utf-8?B?NEVZcTJlSkkySVBwbUhqKzdpVFhsS0ZCL0pHeGdsVVlNeFdwTkRGYSt5Q0hs?=
 =?utf-8?B?Wm5pdzB1K1ZhWVJSL0MzZ1NGOFpEWjJpa3pOUmVJcVBmKzZiY2ZFb3pyMmh4?=
 =?utf-8?B?ZHQ2eXg0WnJyV3NDazdrMXZBRElDSXNjZnBWQU9EdllxcmlNK3RkSUR2dWZr?=
 =?utf-8?B?ZG9CYUJDbjZqS0JrUko4R2hLT3dMaFNsUVZENDJoRnQ1a1R0NU9pK1d3Q0pP?=
 =?utf-8?B?SGhYMFNnUlVSSnBXa25Jb0ZWa0N4NDI3cmtuOGR2NFRzd0VNQjhZTkVYZVU5?=
 =?utf-8?B?MjlCS0h6QXEzQnJMbkhUUmIrcUZFK2YzbW9mL1YxUm01L2lJeTRwVE95bFAw?=
 =?utf-8?B?LzVwUWxnQWNNZ0tHZXNhdmlqZHNNU2FOdUJ0a1NRaUlSbGtzMFZsZGpaWGRj?=
 =?utf-8?B?ekVockNCU3dnandYQzZmOHJ5bGdocXNWVkkxbDl4cFFZRW82YThLVSt0RjFN?=
 =?utf-8?B?L2lvTVJ2MkFFVGlQTnpFYm1YWHhEUExra3ZwNWkybUFNN0xxd3dkU1hMMTI5?=
 =?utf-8?B?cW91SGV6RWlVRGRWQjNweVo3UTVMVlZZcXB0NjR5QlBHdGpHZ2pRRDY5bVY0?=
 =?utf-8?B?TDJHY0VSVGhqVElKOENWazQrRG9KaWRTWkdaNE1NeTlTRXZaRzBJOGJ6bk11?=
 =?utf-8?B?c1M4Q0RUcy9Ydk85dzNzcUhIczNSZU1yQ1NnVHlpUGZ5RFp6VENDQS9FekRI?=
 =?utf-8?B?L2FtUjdnZFRXSm5pT3JpYmZDQmlWTXBKaGhuSFdmZTBKWDgvVWZENHNaR2s0?=
 =?utf-8?B?Ni9iQWdRZmF4eTB5aXY0b3BnbE9LNlRuelNIbXlHdUNvOGd4ZUpkMDJXOExq?=
 =?utf-8?B?YzhHVkZsMFEwQWRKdGQzaitramxKOEpSV0k2Y0ZTOTNXUTY4WG10VE04R2Z1?=
 =?utf-8?B?MHNPcnBYOEJ6MHQwRHBUeW9BbGVmWitOUDc0SWJFTXdwdlkzdENUWDc4MnBP?=
 =?utf-8?B?V01WQ1djL0E5Q1lVdGhHOUtLdTVBTzRlVGdjRGo4bnJmM0s1cFdWeHczS0NX?=
 =?utf-8?B?MXNNSXJyR2tQR3BFejNSbUZyWDA5aVkvNCtTMGRlV1ZoZ0czbUlwQWtMQjZw?=
 =?utf-8?B?RldKa0UyTmlrS25qOENTTW9FK1hzTW5MdGIzQ0sySlpoRkhyTVZXSDhJTlJF?=
 =?utf-8?B?UlV6MmNNVlNNczRFYmh3YlRFdXNmRzU1R0NjZktIL2l3V0x4Zmc2amhrK2d2?=
 =?utf-8?B?WDVPN0dXZzFBdGdJbmwwMVVDT01kcTFWcHpNcEp4U3BBbkVEcWxxcnFmbDVZ?=
 =?utf-8?B?Ync9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 45abcf81-fda6-4dfc-c395-08de3380daef
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 22:02:45.6632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bj9s7PgUfSkiy9+nK9BscCQgPuPUFH5L4JsmbSFnvlzHKN8Uv2Byx639+Dh7QFzfhIMuWlPwuoM/dR2wUi9OIc4vAMrmiIn1fPyqgCTcmx8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5972
X-OriginatorOrg: intel.com

dan.j.williams@ wrote:
[..]
> That is functionally equivalent to a new devm_cxl_add_memdev() flag, and
> is something that can come later when such a driver arrives.

Here are the fixups collected for a v2, I added some documentation of
the expectations around @ops:

1:  aa399f4e13c5 = 1:  1368388728fd cxl/mem: Fix devm_cxl_memdev_edac_release() confusion
2:  120ac819e8cb = 2:  f56b7c7ec1cb cxl/mem: Arrange for always-synchronous memdev attach
3:  bcb0109994a3 = 3:  1fe83e925d59 cxl/port: Arrange for always synchronous endpoint attach
4:  74c426d1dd5d ! 4:  9bd03230d6f3 cxl/mem: Convert devm_cxl_add_memdev() to scope-based-cleanup
    @@ drivers/cxl/core/memdev.c: static const struct file_operations cxl_memdev_fops =
     +
     +DEFINE_FREE(put_cxlmd, struct cxl_memdev *,
     +	    if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev);)
    ++
    ++static struct cxl_memdev *cxl_memdev_autoremove(struct cxl_memdev *cxlmd)
    ++{
    ++	int rc;
    ++
    ++	rc = devm_add_action_or_reset(cxlmd->cxlds->dev, cxl_memdev_unregister,
    ++				      cxlmd);
    ++	if (rc)
    ++		return ERR_PTR(rc);
    ++
    ++	return cxlmd;
    ++}
     +
      /*
       * Core helper for devm_cxl_add_memdev() that wants to both create a device and
    @@ drivers/cxl/core/memdev.c: static const struct file_operations cxl_memdev_fops =
     -	 */
     -	cxlmd->cxlds = cxlds;
     -	cxlds->cxlmd = cxlmd;
    -+		return ERR_PTR(rc);
    - 
    +-
     -	cdev = &cxlmd->cdev;
     -	rc = cdev_device_add(cdev, dev);
    -+	rc = cxlmd_add(cxlmd, cxlds);
    - 	if (rc)
    +-	if (rc)
     -		goto err;
     +		return ERR_PTR(rc);
      
     -	rc = devm_add_action_or_reset(host, cxl_memdev_unregister, cxlmd);
    -+	rc = devm_add_action_or_reset(host, cxl_memdev_unregister,
    -+				      no_free_ptr(cxlmd));
    ++	rc = cxlmd_add(cxlmd, cxlds);
      	if (rc)
      		return ERR_PTR(rc);
    - 	return cxlmd;
    --
    +-	return cxlmd;
    + 
     -err:
     -	/*
     -	 * The cdev was briefly live, shutdown any ioctl operations that
    @@ drivers/cxl/core/memdev.c: static const struct file_operations cxl_memdev_fops =
     -	cxl_memdev_shutdown(dev);
     -	put_device(dev);
     -	return ERR_PTR(rc);
    ++	return cxl_memdev_autoremove(no_free_ptr(cxlmd));
      }
      EXPORT_SYMBOL_FOR_MODULES(__devm_cxl_add_memdev, "cxl_mem");
      
5:  b48acca13cdb ! 5:  e636831b1ff9 cxl/mem: Drop @host argument to devm_cxl_add_memdev()
    @@ drivers/cxl/cxlmem.h: static inline bool is_cxl_endpoint(struct cxl_port *port)
      struct cxl_memdev_state;
     
      ## drivers/cxl/core/memdev.c ##
    -@@ drivers/cxl/core/memdev.c: DEFINE_FREE(put_cxlmd, struct cxl_memdev *,
    +@@ drivers/cxl/core/memdev.c: static struct cxl_memdev *cxl_memdev_autoremove(struct cxl_memdev *cxlmd)
       * Core helper for devm_cxl_add_memdev() that wants to both create a device and
       * assert to the caller that upon return cxl_mem::probe() has been invoked.
       */
    @@ drivers/cxl/core/memdev.c: DEFINE_FREE(put_cxlmd, struct cxl_memdev *,
      {
      	struct device *dev;
      	int rc;
    -@@ drivers/cxl/core/memdev.c: struct cxl_memdev *__devm_cxl_add_memdev(struct device *host,
    - 	if (rc)
    - 		return ERR_PTR(rc);
    - 
    --	rc = devm_add_action_or_reset(host, cxl_memdev_unregister,
    -+	rc = devm_add_action_or_reset(cxlds->dev, cxl_memdev_unregister,
    - 				      no_free_ptr(cxlmd));
    - 	if (rc)
    - 		return ERR_PTR(rc);
     
      ## drivers/cxl/mem.c ##
     @@ drivers/cxl/mem.c: static int cxl_mem_probe(struct device *dev)
6:  f7e58dea4878 ! 6:  13c07d702c92 cxl/mem: Introduce a memdev creation ->probe() operation
    @@ drivers/cxl/core/memdev.c: static struct cxl_memdev *cxl_memdev_alloc(struct cxl
      
      	dev = &cxlmd->dev;
      	device_initialize(dev);
    -@@ drivers/cxl/core/memdev.c: static int cxlmd_add(struct cxl_memdev *cxlmd, struct cxl_dev_state *cxlds)
    - DEFINE_FREE(put_cxlmd, struct cxl_memdev *,
    - 	    if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev);)
    +@@ drivers/cxl/core/memdev.c: static struct cxl_memdev *cxl_memdev_autoremove(struct cxl_memdev *cxlmd)
    + {
    + 	int rc;
      
    -+static struct cxl_memdev *cxl_memdev_autoremove(struct cxl_memdev *cxlmd)
    -+{
    -+	struct cxl_memdev *ret = cxlmd;
    -+	int rc;
    -+
     +	/*
    -+	 * If ops is provided fail if the driver is not attached upon
    -+	 * return. The ->endpoint ERR_PTR may have a more precise error
    -+	 * code to convey. Note that failure here could be the result of
    -+	 * a race to teardown the CXL port topology. I.e.
    -+	 * cxl_mem_probe() could have succeeded and then cxl_mem unbound
    -+	 * before the lock is acquired.
    ++	 * If ops is provided fail if the driver is not attached upon return.
    ++	 * Note that failure here could be the result of a race to teardown the
    ++	 * CXL port topology. I.e. cxl_mem_probe() could have succeeded and then
    ++	 * cxl_mem unbound before the lock is acquired.
     +	 */
     +	guard(device)(&cxlmd->dev);
     +	if (cxlmd->ops && !cxlmd->dev.driver) {
    -+		ret = ERR_PTR(-ENXIO);
    -+		if (IS_ERR(cxlmd->endpoint))
    -+			ret = ERR_CAST(cxlmd->endpoint);
     +		cxl_memdev_unregister(cxlmd);
    -+		return ret;
    ++		return ERR_PTR(-ENXIO);
     +	}
     +
    -+	rc = devm_add_action_or_reset(cxlmd->cxlds->dev, cxl_memdev_unregister,
    -+				      cxlmd);
    -+	if (rc)
    -+		return ERR_PTR(rc);
    -+
    -+	return ret;
    -+}
    -+
    - /*
    + 	rc = devm_add_action_or_reset(cxlmd->cxlds->dev, cxl_memdev_unregister,
    + 				      cxlmd);
    + 	if (rc)
    +@@ drivers/cxl/core/memdev.c: static struct cxl_memdev *cxl_memdev_autoremove(struct cxl_memdev *cxlmd)
       * Core helper for devm_cxl_add_memdev() that wants to both create a device and
       * assert to the caller that upon return cxl_mem::probe() has been invoked.
       */
    @@ drivers/cxl/core/memdev.c: static int cxlmd_add(struct cxl_memdev *cxlmd, struct
      	if (IS_ERR(cxlmd))
      		return cxlmd;
      
    -@@ drivers/cxl/core/memdev.c: struct cxl_memdev *__devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
    - 	if (rc)
    - 		return ERR_PTR(rc);
    - 
    --	rc = devm_add_action_or_reset(cxlds->dev, cxl_memdev_unregister,
    --				      no_free_ptr(cxlmd));
    --	if (rc)
    --		return ERR_PTR(rc);
    --	return cxlmd;
    -+	return cxl_memdev_autoremove(no_free_ptr(cxlmd));
    - }
    - EXPORT_SYMBOL_FOR_MODULES(__devm_cxl_add_memdev, "cxl_mem");
    - 
     
      ## drivers/cxl/mem.c ##
     @@ drivers/cxl/mem.c: static int cxl_mem_probe(struct device *dev)
    @@ drivers/cxl/mem.c: static int cxl_mem_probe(struct device *dev)
      /**
       * devm_cxl_add_memdev - Add a CXL memory device
       * @cxlds: CXL device state to associate with the memdev
    -+ * @ops: optional operations to run in cxl_mem::{probe,remove}() context
    ++ * @ops: optional operations to run in cxl_mem_probe() context
       *
       * Upon return the device will have had a chance to attach to the
    -  * cxl_mem driver, but may fail if the CXL topology is not ready
    -@@ drivers/cxl/mem.c: static int cxl_mem_probe(struct device *dev)
    +- * cxl_mem driver, but may fail if the CXL topology is not ready
    +- * (hardware CXL link down, or software platform CXL root not attached)
    ++ * cxl_mem driver, but may fail to attach if the CXL topology is not ready
    ++ * (hardware CXL link down, or software platform CXL root not attached).
    ++ *
    ++ * When @ops is NULL it indicates the caller wants the memdev to remain
    ++ * registered even if it does not immediately attach to the CXL hierarchy. When
    ++ * @ops is provided a cxl_mem_probe() failure leads to failure of this routine.
    +  *
       * The parent of the resulting device and the devm context for allocations is
       * @cxlds->dev.
       */

