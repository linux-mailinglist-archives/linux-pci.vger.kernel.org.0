Return-Path: <linux-pci+bounces-41181-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B652CC59FF7
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 21:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C753E3550DA
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 20:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB7E31CA7E;
	Thu, 13 Nov 2025 20:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="etxOQbk1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECC531A042
	for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2025 20:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763066508; cv=fail; b=tbBAWzB6OlCDqkkgw5MildyMoD1BCsA065iX2jY4yG7h4gfAM8VcQopbE9M64tId/PnfpcWG5IWG/a/ZhTT77k8t7kEJham1JtORZfIaTjXsZQGY6RBGFUvxugfRD9g35NsHESe8B7kaUhZyHnJzZ5BDkbwWEIWMgF22sImjIa4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763066508; c=relaxed/simple;
	bh=8Rf7QNbIeeNWBzyGdXjvWXxdMPVUuFC+4oajhwRBiDk=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=Y0SJEvqqyJIHrhHGs2g/5XsusLn+AdJg3KaeTtwnQNIF9JIRkI9atn3ZJGMeD62q1ac9pFCgQVAj1xv0tEj9vtPxafgReSgzqSCkGpn4W/8adtNKLaGqtzq3ZGnsI4QQHATRavuJRdSGixaz8WQBcnN5Q9ZM2bXcQdKjOJOG5yo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=etxOQbk1; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763066507; x=1794602507;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=8Rf7QNbIeeNWBzyGdXjvWXxdMPVUuFC+4oajhwRBiDk=;
  b=etxOQbk1LLpeSnmMjvXhZ82JBG536DR0C4G7Y4UnRW6ukzK/WUy/Yi4I
   L88E5apXzkn///pj617vQp0rFONPRz8rap1BsYsZFCtoIRSCJ6QNXS2gD
   qRMnWTlAtP9VLuiWwf4CNDAVrLIb9J/NM21IY/hICoO01eDOrUJmKF84P
   5X6aAHKdfZTON7Pi2cfp+Dh2UYTNEewzSoXVLWl0LtTUhwdF8uywl0mpe
   h+vR/lMeRGzxyeBfN8IYdLq1z3O2/ffiYRN9IZV+NhAUs8lsIePvHFf8F
   3oUZrHPbnQWat9ynodiPQxqBvivkwAq7ocw2b0n+wWDnLbNDUC5SwI4D6
   w==;
X-CSE-ConnectionGUID: XK2kNV26T0K6RJpWKtiTDg==
X-CSE-MsgGUID: UjaP7YguTvKKzLqq+hIUrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="82791492"
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="82791492"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 12:41:46 -0800
X-CSE-ConnectionGUID: cDg2Uoi6SDGk0iHWWz818w==
X-CSE-MsgGUID: 1GJSk2YVQ+6OHPftlLV32g==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 12:41:46 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 13 Nov 2025 12:41:45 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 13 Nov 2025 12:41:45 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.3) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 13 Nov 2025 12:41:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KPkqi/WHUT/kDEpWnvCoJDi4zycBxaWwUKyU1RwIF6br2Wq9EnoQjvFcVEpR3q/P3u/v5h4YWn/gDv+MoJoA3RC/0SiM0SPxCAJ46Vl9cOyArhSYyiNFUHH4ATqaudAt9eN3BvtYI8CtokWnaLwh2ngaVvGrzvaIB0QWDiCUG0kQmUr281yaM1p63CZshxKlrJwq7XALZJmkmCWFryqsiOBbhyJ5MCYlKidE3CuSpPBHe/TVipdwyko1bzGJKoAbm2S5eHTKKIASsj7UIzlM7j1auwzD7UMeB9FvUrrE60vcxNqluH5bE+GFSDjj/otewhzoHYhsXk9Y8hwsILfngg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j8hBCFJfVgvh4JC2Brm5pwbexkZurANI9e7clfEyI0k=;
 b=NQNx0MhftWwtcESM+unslTxvQ+NgKPdZSe/qfGvM/alwaoCb9Vs9MNBnJ32XmyJ+P2Car6jLrnNXU4DPvZdZNyfM9cwmfhsLscekkMIEA2uBRyDKdtvxehXBfWApCTI7np3nw8i/88hu3X6a7mZBuZEZ6KD3mnMu16ECcL8IhYpV6WqCfQq5yK9GxZMV72UU2d55ODA1Jkb0lKsm2b7ihDFGa3+IKWtCrlfe7JHcXtmFv6Xk3sY3kRf7Gb1ru3Z/wYsyvRPSDVzZarI/2XMDN3nGSwDi2nY/ZSJDox7nzYtqBk3Z8uyX9Q33Je1wAVw9NKytN6B+crQ3Rp2mFjr1pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB7194.namprd11.prod.outlook.com (2603:10b6:930:92::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 20:41:41 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 20:41:39 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 13 Nov 2025 12:41:22 -0800
To: Jonathan Cameron <jonathan.cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-pci@vger.kernel.org>, <linux-coco@lists.linux.dev>, Xu Yilun
	<yilun.xu@linux.intel.com>, Aneesh Kumar K.V <aneesh.kumar@kernel.org>
Message-ID: <69164272efaef_81241007d@dwillia2-mobl4.notmuch>
In-Reply-To: <20251113120111.000038a0@huawei.com>
References: <20251113021446.436830-1-dan.j.williams@intel.com>
 <20251113021446.436830-7-dan.j.williams@intel.com>
 <20251113120111.000038a0@huawei.com>
Subject: Re: [PATCH v2 6/8] PCI/TSM: Add pci_tsm_bind() helper for
 instantiating TDIs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0027.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::40) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB7194:EE_
X-MS-Office365-Filtering-Correlation-Id: 27446c1b-915c-4db7-4190-08de22f50bed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aDFrQmplYW9nRyt2OUtxbnJyWjE0ZEhuNlIyZk42ZDBSeGVwQ1dab3p1UlBz?=
 =?utf-8?B?L3BlZ1l2NlpFeTljRzMxVURYMTROWUkxMWlDM1FxUWY4U2l4YmZJbVBiYUV3?=
 =?utf-8?B?THBSYkRpT0NhUmxZTG9iM25iQW1ZVU9QbU54M3JMTmw3aDBCT05mcUt6S2ts?=
 =?utf-8?B?cFAzb2pITkJHeUNEU3oyM3lGeEhsWTcrb05OTGhBQkk3R1MrQm5FMS85TVlp?=
 =?utf-8?B?QnEwQmU5WlVDbEc0S1BFS2Ntcm1QUjNmZytXSkxFRXpJMGRJc2krWVVSeDNF?=
 =?utf-8?B?R05GY01PeTBLbGNaWldYOXNDcFNtTHRtSHROTUlaTy8zdUVaWVJmOGhtRnVy?=
 =?utf-8?B?MXFZZGdQZ0JzbHRSWHgvMXhJcktuVXFOTS9YTGk0aWhpcjRHVUJ4anVDSEth?=
 =?utf-8?B?R09FODdxb0cyemtvTjhwQmljemRtbklnUjl2eG82amFuUDBKY3IyTys4QVpk?=
 =?utf-8?B?SWJ4dTZaZ3RnNGVJenhhcHBxUHFKUTlkcjlGcDI1UlVCNUprM2c2OGNHK1R1?=
 =?utf-8?B?SlBVSlM5bHR0amtQQmtnZFgyQll1MDYva2tMQkdCZzd6MDVQNllDeWpnV3Jj?=
 =?utf-8?B?Tktid2RoZ1MwUzQzbVRYaHdRZXp3azVOeFVIazhGWHZ0MWs2bkg3aU1GeXZx?=
 =?utf-8?B?Vkp3OHBVVldFVVN3RE9jTUlMRXpEUGdqYW5yQmczQXlFbkNMTS9ucTRWc3JY?=
 =?utf-8?B?eUtveU44azFvT0tYb1g2S0ZSZTFwelNSa3I4UDlNTFh6T1ArUmwyM1BEdEhT?=
 =?utf-8?B?ZW51OEk1QnNjUys4Q29kQkNPaVBDYmdQMFBHNjE0SEJoSDJ4ZnFmVlNoYXpQ?=
 =?utf-8?B?U1o4ZncvaUJJMXpxL0YxY0VTVGd1c1lpelVNSlovWnQ3Y0xoMkpZSVpVVFhk?=
 =?utf-8?B?a0tvMGxBS2dXZ1dpVzIxeXJEVk5JYWk2ZkVFd0djbzIxM3B6VXdpWU5lSkhT?=
 =?utf-8?B?cVdDbzVid2dnd1ptRVJNWEJPRG9ERjN2S0NCL3VNdndlNFdwQ2xUZllxRG12?=
 =?utf-8?B?anUzYTlOZXQ5bUtMTGd2bmNjVm9mU0VOMEpFUHNmTlVrVGdqYmJnNERFWThj?=
 =?utf-8?B?djF1RTZhdS9WcWJTcWRjQXFBQkRQQ0hnVlRDQmJiVGN3RFY2MTNaV3Vxek9o?=
 =?utf-8?B?VnA3VVNxSmRxdHBmbkZZNGt0NTVISXNpODdaLzNqRGhqTzdOT3VjcjFTM09r?=
 =?utf-8?B?TDMyVjJXZ2hBa2MzUEtCM0VQcDhlK2NvWGZOeXpOV2VpUlZCWVZxNkRneHFy?=
 =?utf-8?B?U3JxSlVBalVaMlZ4TDJBVFJoeGt4MDloaFowMUg1elA3SnY0ekdicjlrUmVU?=
 =?utf-8?B?VFhpaFZiNklKSUlPN2s1QUtCdkdXenZOL2NMTENUNjVHN1VnWFppNzNDdUgv?=
 =?utf-8?B?a1cyMmJ4MGZJVHYyM2ZGbWJNcFV0MFRWNndHV0lmSlBrUUp6aFVnakk2QmRr?=
 =?utf-8?B?VWlBQnRaY1JVYXZWZVBPRDArbzg0anFHbHVvS3NrTk92czQrMTFMTmk1RVVS?=
 =?utf-8?B?TDJWR09jYStYUVp4WkN1VnhBVUIrSnlXYUJWMXFucEFDRmptSENJTnhBajVT?=
 =?utf-8?B?WDJkY1VRYUEvd1FkZGl3eXRGNUl5MDZjazFUbTdYRUpOTlZ1SFBwRHR5RVIz?=
 =?utf-8?B?d090cUZCQUs1RmhRWjJhNTNBd3N6VUdLRXhFRFVvcjNHeFFlcTMxWGZlU3VW?=
 =?utf-8?B?cTYzc2c4bDRRMHRxS1l3RGlQdFd5ZVcvL3hKRFR0eTJhMjgrL3FzMzBjKzVM?=
 =?utf-8?B?RndlNng1SG5MVUx6YzdjTllzMnBHUEYvdG1WRkVIaVNlRVEwVEJ0MnBZK2NF?=
 =?utf-8?B?NUpaUTBjVFE1Rkd6a2k2Q3doUFFUdEZmWUx2cjVqT0VRQzd5cTkwTEloRVpk?=
 =?utf-8?B?dGIrTC9jZVJ2Qm9UU05PalhoRy9zM0lCWUZoekJJU1VTUG4wbElOZUpTUDV0?=
 =?utf-8?Q?eRQbg/MY02MR8yVH5S9967D3ljoMrpg7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGFZMkhOb01HZjgrKzVsVitHU3JiRzl1cmdxdHRxdDBIUFhtWlBaajZwOEE5?=
 =?utf-8?B?cjlYNmNiTGxoR1h4UWUwOUdkZWpQWlRsN0c4Y3JrdUc2TnlrKy96emFjTkZt?=
 =?utf-8?B?blhXU2d6RDNlNk5OYi9KWU1pVklzUzRVN2lDVnM0TU9SaDdUcjh0UTIyaVBn?=
 =?utf-8?B?UTA3ZkJkYnJOMUh6T2FUNExPRmo1bDlsMTczQVI3L2xOcGVXbTlzZVBUVWQ5?=
 =?utf-8?B?VDJoK0wxOW5sYXpIVEM3UUhoZ0Y2aTZaYWJDcEdBSkJuV3poVVFRRFV0Z3A4?=
 =?utf-8?B?QVdDaHNINDkvT29LQldmUVNqTW8rVnFpMjJRVUhTclBoR1pqRk1vU1F6LzJo?=
 =?utf-8?B?Q015UnAzSU8rNzBpaHNwZ253aWFjaXBlalNjVEtsbHNoOWdUYUhhRVYxVWxj?=
 =?utf-8?B?OFF3RFJUNU1KbC9EQVBIRmJpRkFBdE95NEpJNnI4ZDE3ZTdrMjF1Nk5ZVVk5?=
 =?utf-8?B?L2ZtTEc3eHgrMzBYSGcvREhyZGtGSk1kSEJxQXV3NzBkUmJ0OUc0eEQzbXpK?=
 =?utf-8?B?a1pISFV1bjJFOVZBSmxPRStsRXZSdS9SWU9HLzYxSTVNd2lEZUxjOWh2cWhV?=
 =?utf-8?B?emxyK0V2VVE1M2lpZUFTTWJJZkNiVGJRKzFUOWhwUldNcSs1UVFzbHFOeHZP?=
 =?utf-8?B?NzZkKzhMWEZueHVYWlE3ekxUTVhheDFqUCtxRnFlSzdvYmhuNnlvd0NOUllM?=
 =?utf-8?B?VDZUTjFPZm1YeGVyZHNIMlQvQmsrODc2SnBodTRIdHRXT3pOTzJma2R3T1k5?=
 =?utf-8?B?N0hXVUo2WWlWcFg1YVg0OWJ3azVQSEJQSTkxNVRKc25pdXdIWTdsNXJycHBW?=
 =?utf-8?B?T08vQmU3SVJWSnNXQzAwaklQNzFuYUFVNW4yalJucEd1WHhwWllRbWhyc25K?=
 =?utf-8?B?SW1qY04yREExaTZ3bVkzV1RaQnNKc3JaVzl6eU03SVNSMlN2eGpCOTMxMGJY?=
 =?utf-8?B?R2xrdGZjK3pxUER0YjJqSmxJVE4wRzFuRTlTNDJLaFdnd1Z5WW5pcEx4UHRp?=
 =?utf-8?B?RnliT1hqUGsrMk9rTmdGNUc0V1FWY1AraE83VU9HT3dYeHJIZ1FxOWtzUzBN?=
 =?utf-8?B?ZndUZ1l4cTVBQlYxMXdURDMvSUZGVE5BaEU2eVNSUjA5R2M5ZzQ5OUlYMS85?=
 =?utf-8?B?ZjFLVDlRZWwvK0hOZUJWYjRrcm1kekdtZ0pnN3RQTW9SOEJySndQL3lzRU1t?=
 =?utf-8?B?bkN6RDBVa3MwU2VYNUlZb0xDZ2t0Ynl5dFZKcElONkMzWHVhWDZjMFF4aWlT?=
 =?utf-8?B?VmxLeFhyMzRJeVQyamliV2NMY1BLVEI1Qkt2anY0OEE5VjRidmhBTm1oTWR1?=
 =?utf-8?B?c2ZTelI3ZVFpdklFd1JEM2V1QnVReXo0MzRyOXpIWGFxQ3FabHRHNnRiY0ZO?=
 =?utf-8?B?Z1hsMGo4Z0FWdG1PUDJDaEZWNTM5eTVlQ3hOZ1p2RzFvNGRsRWlRZXQwT3Ux?=
 =?utf-8?B?VUhiZnJnK20zbVhYekRTaE1PZGpiNFFvVy9LSCtNSGhmTnVtbG10czBvbHBr?=
 =?utf-8?B?TTVUNWUrLzZuZmxKaTNMWXpuM1lSQ2RMaUdVcHZRSEZkblRmTTBlRGdveUxR?=
 =?utf-8?B?QlNFMjFMREM5UmVWVVRxamNwMEo0T0Z0aXNHMFVhWlZMNWc1WTlQR1lodUtB?=
 =?utf-8?B?b0UvOEFmbFJTTGJWbTk2T05OSmVWWklzSlRqYXd2cEtXWFJnQWZKNUxZejJ4?=
 =?utf-8?B?dGgwMVR5ZksyTFlXc0FuTnZTajQ4UkxzaUpuUDd3dU5FZlBvbjdzdk5weFRU?=
 =?utf-8?B?cEtIUDBmTGRyRUlMTTltbTRHM0tZKzFiM2JCaUdmTllxTUpQWm9nb2JCVitC?=
 =?utf-8?B?YWdrL1R6T2tramJhRWI4ZVNoZWZ4bjJPTHBDTDB4ak5JY21IeCs3c0p1MDRH?=
 =?utf-8?B?UTFudURkblFtWFF4QkZsM244SjV5dEtOc3JYUk9KWUJqTVJGU0dWSmM1Zkl5?=
 =?utf-8?B?ODhmNUtrTXhwd3ZqZzE5emE4L2s0bmZYR3VHQzBLbTlMK3ZyZlVkODhJVHZ1?=
 =?utf-8?B?TWs4d3NselZWeFdGRTQxQlBudEsxaExYd3d4VklsUjJMeHdXdEhRVjgxUlFG?=
 =?utf-8?B?Uyt3NXlyaG1NSTV5MXVOTUw1UUJCT3YvRFIyck1mZjN0cDNKSmtnby9mZ0Fv?=
 =?utf-8?B?V1hEamZST2NJUHNPaUEyK3U5RmJwN1pXTEpnbjZnWmFwL0pmMGFlOFBSamQy?=
 =?utf-8?B?dVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 27446c1b-915c-4db7-4190-08de22f50bed
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 20:41:39.6845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TkrE+G0pBXGt0c+3TE15EwtVBZQuRwH8/ZrAJsBZ/7pEXAbTP4+B1B2i1RvlTsF4LQc43a8LlKI67aVmhTGktbFPRhGU02IcYAZtxHs6jJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7194
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Wed, 12 Nov 2025 18:14:44 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > After a PCIe device has established a secure link and session between a TEE
> > Security Manager (TSM) and its local Device Security Manager (DSM), the
> > device or its subfunctions are candidates to be bound to a private memory
> > context, a TVM. A PCIe device function interface assigned to a TVM is a TEE
> > Device Interface (TDI).
> > 
> > The pci_tsm_bind() requests the low-level TSM driver to associate the
> > device with private MMIO and private IOMMU context resources of a given TVM
> > represented by a @kvm argument. A device in the bound state corresponds to
> > the TDISP protocol LOCKED state and awaits validation by the TVM. It is a
> > 'struct pci_tsm_link_ops' operation because, similar to IDE establishment,
> > it involves host side resource establishment and context setup on behalf of
> > the guest. It is also expected to be performed lazily to allow for
> > operation of the device in non-confidential "shared" context for pre-lock
> > configuration.
> > 
> > Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
> > Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> LGTM to me so
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> though I would like to here from Aneesh on whether the v1 discussion
> answered all questions expressed.

I did follow up with him on the last CCC call and setting tsm->tdi in
the TSM driver as needed is the going forward plan.

Thanks for taking a look at these.

