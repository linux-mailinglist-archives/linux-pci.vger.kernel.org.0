Return-Path: <linux-pci+bounces-42540-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 031A0C9D87B
	for <lists+linux-pci@lfdr.de>; Wed, 03 Dec 2025 02:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D51044E4C84
	for <lists+linux-pci@lfdr.de>; Wed,  3 Dec 2025 01:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFDC1BC2A;
	Wed,  3 Dec 2025 01:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gw02ysBI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E36E35957
	for <linux-pci@vger.kernel.org>; Wed,  3 Dec 2025 01:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764726720; cv=fail; b=TPMFMdwI/t74f1mHfi0Ns0vf/XvpjGMKrEQVYPv/0cPmlLPt0I0wpetBmsG1P2aeeNzO0pMgmGUI1THR9Q+GaBI+3jspZ/ujMnrKzIbl2ZmaqfONAEWCQs7X+v+EN+35Fg0ksXgH1zQUoKUUHf7Wyc7jqf8q/vkvmbGeXt0g5w8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764726720; c=relaxed/simple;
	bh=kJ5mHjhKKpcGmMxWRudKySXX4JkWAaFHiYmRTh8qz2Y=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=CwAkLOEgqKp0fEbj6hnE2xY1YtaNq7heVpaNR9FYyd1us6PdAENB+W0VMbjejEu/7EVd/VTMFWE1yefy9aGZ1qJYs4j/Zzg5iqRpeFoqJSD8n7VmPMkr4prv1GselmYQwK9XHJpq0sjP3GKQ81v7eIBzm/smbHXtZhzvqYCuXvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gw02ysBI; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764726718; x=1796262718;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=kJ5mHjhKKpcGmMxWRudKySXX4JkWAaFHiYmRTh8qz2Y=;
  b=Gw02ysBIn93/EqnLQh3FKb3CWp4rvXGMM+Iw+ps6hoUOSpIqnCX89Rp1
   OFJAQ0HIPcqiHl9O6RYeO5d5RtBIPH6Pg5yiOG2eoaVA7fLlRaWHWIA++
   6LUjjDrUH6B+6fnnaQyDULX8LtD8O02BjAt7Is1Zrv4olvvelqYCUWmmC
   7Nye2NsFxj6JuAA0ooIP322nA6g1EgBzyDoJZDusZbAYh4Ft4rAJ1N1gd
   SZGbP1AdvJksCuy4rA7vlvRTegfEOk0xPKv0Z2T2/1FDyjTVwQelxwsqi
   iTvZyoTvcK+SKAkPmGxRVfZjofLCP18mSJnbj94NRbmw6sJDjFL2MZD/S
   Q==;
X-CSE-ConnectionGUID: Ws1kXf63R1u7dd/Rj9f6SQ==
X-CSE-MsgGUID: fcRyHL5eQ+mHItYi6Hepyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="66654731"
X-IronPort-AV: E=Sophos;i="6.20,244,1758610800"; 
   d="scan'208";a="66654731"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 17:51:55 -0800
X-CSE-ConnectionGUID: JHX9kYIIStqwh8oVFPCahw==
X-CSE-MsgGUID: Ukc938kNR9SdUpojg9JZlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,244,1758610800"; 
   d="scan'208";a="194224292"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 17:51:55 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 2 Dec 2025 17:51:54 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 2 Dec 2025 17:51:54 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.2) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 2 Dec 2025 17:51:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VjEFybYuWEzFvpC5mC/JGIEmqWYFTmx3UJ/0dqkc+YtHosJ01U6g9YTEziYFEgEmJ5+1m1p0RNI3Dd8s3dN12/8MUZpq6+MkFsYA8DZdfJLY1A9cI+vvoQKgTwwALTgz1Wv8vz62QGSTiTc94CS5Qy6hV5eTWGxOIMte9GM/xwXrOrcvfqKoK5+oHgi/Oj9kTMvzAw28pimNVWqnsse8hVCKe5P2m+YH+Dy6rfkLJS5knxyf0ySRTc0yvpOdRO7NN/5fbMG2YkDpwiuolcvl0oToPgaLYMrz6UnHyYCp5BmcNkEzJcQyb8FcQvWPAszglU0vnXQ5V5d42n+C9Bxrdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8fZh3quIN7Ad/CQyLc6RR9UPEiFN7GtQ5cWkMf7uk2U=;
 b=R7dCcB33bOgqdjP9iLLkCpRiBykdCyVk4e7iKnkt/sVTW1357uZKhzvm0U9wsiGC48aKQHjXAr03whZqT4Nee0PNDa0AiDdATUjiJy44QUXOaJy0ZdIF5Q80UdQe1sCqWPAOW5DL7eMHLBuHPiDNrKzuMqtEtttAH5zNLO3sHE3I4+pQ21cDW/IySa+zlGRkCRZFLXIPh4EmzQsZcz4W+SCUkiM293ppDSLrjD8sXrIMhiQDzM5fxDunJzvJ0mf2Ft4ymGrHgj4FNdOwNsl1itPi2mP386BkSHbBnYE4A3SIV2KPydPFXlVUAN6SvyORFK3DLcChunqzoweiteIqvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS4PPF900531A26.namprd11.prod.outlook.com (2603:10b6:f:fc02::3b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 01:51:52 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 01:51:51 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 2 Dec 2025 17:51:49 -0800
To: Nathan Chancellor <nathan@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-pci@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<Jonathan.Cameron@huawei.com>, kernel test robot <lkp@intel.com>
Message-ID: <692f97b5508f9_261c11005c@dwillia2-mobl4.notmuch>
In-Reply-To: <20251202234435.GA1692217@ax162>
References: <20251113021446.436830-1-dan.j.williams@intel.com>
 <20251113021446.436830-2-dan.j.williams@intel.com>
 <20251202234435.GA1692217@ax162>
Subject: Re: [PATCH v2 1/8] drivers/virt: Drop VIRT_DRIVERS build dependency
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0016.namprd07.prod.outlook.com
 (2603:10b6:a03:505::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS4PPF900531A26:EE_
X-MS-Office365-Filtering-Correlation-Id: 26b857d1-0059-4fe7-6276-08de320e86ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TDVxRnNiWHZaSU9FNjB4ZzhVclNoZFhJemNvZ1hnamNxZHJBVzRUQ0hsbFIw?=
 =?utf-8?B?LzYwRjZVZk80SmtKeVhtVmttakFHU1JDS3NLNkc5eE5OZnNJam5keitHYUZI?=
 =?utf-8?B?MmlRK05WdnFCN0s4aUdlQ1BzNy9mNXpKSlBLUllDb081ZmxZZ3h1MXZseXh5?=
 =?utf-8?B?V1ltVERpSDhjaXd2dmNpYXpYYjY4RGo2clN1ZWRwMUdOWHJVbzJUNUR0bVls?=
 =?utf-8?B?UXZhdy85ZU1xeU1NM25YV0EzTzFaN2hlazU1TkV1Y1dpQTFvN3pZQ3p4Uytm?=
 =?utf-8?B?UkdNSkRkeEJLbnZ2ZGN2MW94ekdEZ2MzQTJBcUwrTUNhMWtPV2ZhazltU2ZO?=
 =?utf-8?B?YWI3eGRVZEgvRm80MlFTbE9FWFlwQVdOT1dyd0llbFJZd0E0emNMTTZMK0V2?=
 =?utf-8?B?SjFNSm1iUWg2ajhLTG55Q2JkUllJa2hwSkUwS09PNFZoakJvVVA4UXJyaEc3?=
 =?utf-8?B?T1A4T241dEN2M1ZleXRtbDNEdVdBUzdOV3hwK2FrSU44SDZiakhVTzREZ2pp?=
 =?utf-8?B?ekNDK1RCWlFPajcwTi8vS2JVWnA2dHpTSkxpMlpLcUpCb1NDMkYwVnM4NXo0?=
 =?utf-8?B?VG1JK0VxNjVvYXMvcGEzdVBYWTdaZ3Z0VUF5NUtQT1VBai9Xb2xqUUJvekFu?=
 =?utf-8?B?ZWQ2eVlsa0d0RXZ5ZFFnVjlUd2V0bWVGU1N5dHhsNEdzekpnZWVaK2R4dHgv?=
 =?utf-8?B?N29lcXQvQWhMNEhsSkNPZHlZQm5EK3Y0b0NPWVUwcmIwZzBwcHpqcDNMS2xQ?=
 =?utf-8?B?cnpOVitIUTRycjhMeFBCcTgxWGRBaUNqUWFNc1ZQbDJhYUdYUU9pdU10Y1Bq?=
 =?utf-8?B?T3B2UmhNL2U3MjdTQWxqcUxaQmJkdE10UGR0enZCNG5adEc0ZC9iOWV2dUFZ?=
 =?utf-8?B?Rk1rOEZHbndkOEZDcVY2TytDbS82cXdFSVhRVXFXUlJBNmdROXg4aklOWk1j?=
 =?utf-8?B?enZXbGpMRkQ3ZUtINFVpNjRoNVl5eUFlZUI4a1VIbUx1WHhBTmJDVGg2bDk0?=
 =?utf-8?B?VnNBSlFGcE52RmN2dUJmd2M5Q0x5WkVWNURjRG5SdnlKRlBYWWV6MUxHRjND?=
 =?utf-8?B?VzdOb2t2U2NVckVOd1RzdnJ6T0QzcnFuQWJESGxiWXpNZUEzMmQ1d0hmOFZM?=
 =?utf-8?B?bkd5RmkwYnIxRVNGKzFtY3NQMmFNb2M4TGlPTG1CT3F0b3lGeVEwS1RlcUlX?=
 =?utf-8?B?bGptU0R4bHNZK2FLalh1YVk2WlJPTkt1TWxVaFQ2L0dONk5yMEUwZi9yQ0F0?=
 =?utf-8?B?Q2ZYcnVHNXZSZnFKeitKU0dRSjYzRzBwcWJYZW1LaDBWQjU4YkxNTEEwUWFI?=
 =?utf-8?B?UE1lem1maUxORUJIaGZtNTg1TFVYRW1iVWJtcGx1K3lrVjdUMFY3aC9LTk1G?=
 =?utf-8?B?L1FBTEVTeUZlaU9IdnBsUWhFUmhYNmZYcU1XTUxDeExkbjdFb1dWbmJZeGwy?=
 =?utf-8?B?V2doNzRjYjVIYStHYll5YUFVSDNDZXppbFNiUml0NmcvRXJUSXBkV3FTZE80?=
 =?utf-8?B?NEUxZ1FXdmEvM3h4bjJwdlNaYmFnQ3RiYlRPNEkvZC9FcFkzN09OdVpvczk4?=
 =?utf-8?B?UmQyNlIrQU5QL2EvNFV5cEZ2R1JMY21oeGJXUnRuMzk3UjJFNHc0aHcrNnNW?=
 =?utf-8?B?S05JeEJEbTdTeVRGNmQwcG4zQU8yLzFvdDU0a1BST2pFdUVsSHpCVEsvN2Mr?=
 =?utf-8?B?cmFLTEl6d2NyRWZYczhjYjFDSXJYa0w5QXRuNmQ5c2R3Y05EM3JyT2puZW5i?=
 =?utf-8?B?aHNFY1BLTzFUYWNPbVZPVjF4cmZHNVFqMkhuZUE2ZXZCYUdQczhwYkt5L1RR?=
 =?utf-8?B?d3Z6Zi9zUjZKMUR1enBUV2hRek5OaHUweDhmdmRhTFJiZHp2dXg4UmZxVS9I?=
 =?utf-8?B?T2E3NzdUeTUvMlFQblI1d1hNazhnbUxpSGVwU2x2dXk2WXVYcktjcEZDMStG?=
 =?utf-8?B?a293b1oxUU9LZWRGcnRJQzNZZ1NzYnRuOXc4Z3pSeUlZdC82YW5wSUlucVQ4?=
 =?utf-8?B?NTRPajQ5QTd3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0NqeWdXdlR3akorKzJTMWFFb2RkWHRDQkhDdzdCdGdqWXdYTld3SmRQTGVR?=
 =?utf-8?B?c0trMFhjcDhZM2poZEJzcC84L1M3eDdsczVONnpOakpGS1RuK3hVVlpqMnNN?=
 =?utf-8?B?L0RyV1pNM1ErQ1c4VnE4aTBiOEpQYVdEcjlHeFkwaUlGYjdOQUFtUmZIWjhm?=
 =?utf-8?B?NTFkTlowUGs1OGNqVUplMndORk54VUh1Ym85TTl1UWJwbmVMd2ZsRGhYMmVR?=
 =?utf-8?B?aG9JTSs2cVFKaXJ3NVl4SEZldnJGREgyY3JnRHdIbk45S3Y1RDYwT25VZTJw?=
 =?utf-8?B?TEJLdmoyS3RudFVFUmh0dnhWRFhiZVl0SGR3ZW1vdmNjYkZIejBXSDZVUllJ?=
 =?utf-8?B?YjlUeEF5eWtBdDRVNTZjTnhtZ0pPSS9Vb0FEQWw0MEFFL25Ba2NZb01GYU16?=
 =?utf-8?B?aERFdE1xMkxuc2M1aEFONkJpRkorTlNxU0Y5WFFrTXNVQVpzanRPS0NUM0hl?=
 =?utf-8?B?VXBDMTVWbnFiMFl4L0VqYUZGdmFUZW5MMHgwZmJIdUdMVHNHemtUcGpHU3lD?=
 =?utf-8?B?aVFUYzNTdmgwSERWY2pNM3JpSGdtajc0OTRTMzNXWEZMV2JYT1FEc2JtQUF6?=
 =?utf-8?B?Z1N5UDJJcVNieHRHVWxQaWxoZlZoUmppY0tLZWZ0RTRCM0FwY29aUjhmRXho?=
 =?utf-8?B?UlcyZkJKUnpTR2daUzJUd3ZTN0VVWUVISDhJWFVwNDI5eWhsei95TVZJelU2?=
 =?utf-8?B?SVVMU3U5VmxnNlIvSkxJVmtmTUtSY1RxWXdOU04xaHFVSHArLzlFa1VRM2Q2?=
 =?utf-8?B?YTNyaHRwWTd1Tnk2OW5BR1diYSt3ekpGT09aZzhNTzl2WVI3M3VObFFSQ2xI?=
 =?utf-8?B?K1FRU0FHamRZTDZvVDBGanlGSmRhTVMrVVJudlRmYk5zcEhTT0hkdzhwY29T?=
 =?utf-8?B?cldQdjV0NUpBMkFzZ0RmQWlNUzB2SG1CU29OdTNIaGFhTjNGMi94SFlYd2Jm?=
 =?utf-8?B?M1BsK0tkTlB4a0dtaUFSQ1VBYjUzOWk2a1NodkFpc21nUmtzN0NzZm9GQkJ1?=
 =?utf-8?B?cFhoQWNtcVNIdUU2T2JaYUordXBOMEZxcm5weEczcVpuZjJFWnZaenlGcHIw?=
 =?utf-8?B?VXc2Z1RKaDBxSStiSytwbnR0TG5wRDhmVHk3em8yQm5FY2NWOFlhLzd5c2sv?=
 =?utf-8?B?ZHhoUDF2SGlLNmdVaU56Zm85S0xKb2c1eS8xa094c1VuU3VjVGpGQVo4YVpz?=
 =?utf-8?B?dlpCZmtxdmx1b2FaVkYwckxqclhSZCsya2pxMnhIOEhPUGlkZWw0NHRhTmxX?=
 =?utf-8?B?OTNySFpST0JnVmJBV2hEcUh2M2lGNGM4cXFLMUtRUnduWmg3M1pnYzEwZGRN?=
 =?utf-8?B?azF3NnRpci9EcGFYWHFRdEwzNjk1YUJ4bnk1TzFVbVB4ZU1IUHM2bFl1WEd3?=
 =?utf-8?B?cjlLUVAyM1FPOVYzZFR6NGFyUHBaNFRQYnNMbGZVcUNFSUU4MWZxTmNYemh0?=
 =?utf-8?B?bk9MZGt6em0rWkNrVUdPVEphbFlGQjVJNFBnNDhQU01nZVp2UmRraXJ1eVlk?=
 =?utf-8?B?eUpWWFJLQ2pFN2JKR2g4RnJHaUZTS0ZieG1SOVpGTjlpd3RqZ3p5MlQ1UjJs?=
 =?utf-8?B?bStSS0tsUFRQbWtEL0hVcHdLeDRHZkx4TldmaXlFc3pmUmdnMGFRckNLQzNo?=
 =?utf-8?B?VmpYTE9UOCtYYzQybnBmUkVkTHVYT0Y0L1lRWjBHTytqVSs0dDl1TjljWC8y?=
 =?utf-8?B?Nml5dnN3QkhzMVhpV2dTL1Eydm1jRi9TS3VFRnFSbnN6YU5icnE5aWd0SHlE?=
 =?utf-8?B?Mlp0cU1BU0ppRlgzRVlvL2h4aVdjQkdWeGtGQlpTWXU2blAyeWZUbFN4TW9l?=
 =?utf-8?B?ZVoxMkdCQzlzYzE1ZzY4VVMxbURudHBpT2FORTNTRnFlSW9NQlZlN1pKaTN3?=
 =?utf-8?B?YjhSN2ZZeUIxYTdSbnpJbHpwdC9vV1oxNmIyOTZScXFqYWtjVjducUVOR1Jw?=
 =?utf-8?B?OXAvUS9YQUtNanQ1R3M5NDFCa1IyTUlXc0dGQ0d1eVc2aHdRMUlvMllDejdi?=
 =?utf-8?B?QjdwZmdNMitKTEVkWU5YOEpKM2ViSjBZUi9kTThCeUszL2xZYlU0TVlDenZk?=
 =?utf-8?B?OW1YSWJtVGY0UDlHclJZbUFHQW9BQ3VkV0xVVDQvMVpqblJ2V0Nua2p6cXI4?=
 =?utf-8?B?dFRORk11QTViN0pzcnFjMFYwalBpWnFtbm0vekRuZ3hhUVlTQjNoQytiaUFB?=
 =?utf-8?B?dEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b857d1-0059-4fe7-6276-08de320e86ee
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 01:51:51.0265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UveT45hGgzszcubgh7flstz3ykPeEKFAPmqCxbep82jlJupBXe5epDsUOuVFy/zEKUUBOu/ZDz4Tgpn6fIBZuurfmQvQbxSMktEeU8x36CU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF900531A26
X-OriginatorOrg: intel.com

Nathan Chancellor wrote:
> Hi Dan,
> 
> On Wed, Nov 12, 2025 at 06:14:39PM -0800, Dan Williams wrote:
> > All of the objects in drivers/virt/ have their own configuration symbols to
> > gate compilation. I.e. nothing gets added to the kernel with
> > CONFIG_VIRT_DRIVERS=y in isolation.
> > 
> > Unconditionally descend into drivers/virt/ so that consumers do not need to
> > add an additional CONFIG_VIRT_DRIVERS dependency.
> > 
> > Fix warnings of the form:
> > 
> >     Kconfig warnings: (for reference only)
> >        WARNING: unmet direct dependencies detected for TSM
> >        Depends on [n]: VIRT_DRIVERS [=n]
> >        Selected by [y]:
> >        - PCI_TSM [=y] && PCI [=y]
> 
> I can still trigger this warning on next-20251202, which contains this
> change as commit 110c155e8a68 ("drivers/virt: Drop VIRT_DRIVERS build
> dependency").
> 
>   $ git merge-base --is-ancestor 110c155e8a684d8b2423a72cfde147903881f765 HEAD
>     echo $status
>   0
> 
>   $ make -skj"$(nproc)" ARCH=arm64 CROSS_COMPILE=aarch64-linux- clean defconfig
> 
>   $ scripts/config -e PCI_TSM
> 
>   $ make -skj"$(nproc)" ARCH=arm64 CROSS_COMPILE=aarch64-linux- olddefconfig
>   WARNING: unmet direct dependencies detected for TSM
>     Depends on [n]: VIRT_DRIVERS [=n]
>     Selected by [y]:
>     - PCI_TSM [=y] && PCI [=y]
> 
> I would think you would need something like this avoid the problem but I
> am not sure if it would be acceptable, hence just the report.

Oh, yes, thanks for that. It turns out I fixed the compilation problem
associated with this report [1].

   ld: drivers/pci/ide.o: in function `pci_ide_stream_release':
   ide.c:(.text+0xffb): undefined reference to `tsm_ide_stream_unregister'
   ld: drivers/pci/tsm.o: in function `connect_store':
   tsm.c:(.text+0x1d42): undefined reference to `find_tsm_dev'

I missed that the report I ended up quoting [2] was only about the
Kconfig problem not the build error.

[1]: http://lore.kernel.org/202511140712.NubhamPy-lkp@intel.com
[2]: http://lore.kernel.org/202511041832.ylcgIiqN-lkp@intel.com

> Cheers,
> Nathan
> 
> diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
> index d8c848cf09a6..52eb7e4ba71f 100644
> --- a/drivers/virt/Kconfig
> +++ b/drivers/virt/Kconfig
> @@ -47,6 +47,6 @@ source "drivers/virt/nitro_enclaves/Kconfig"
>  
>  source "drivers/virt/acrn/Kconfig"
>  
> -source "drivers/virt/coco/Kconfig"
> -
>  endif
> +
> +source "drivers/virt/coco/Kconfig"
> diff --git a/drivers/virt/coco/Kconfig b/drivers/virt/coco/Kconfig
> index bb0c6d6ddcc8..df1cfaf26c65 100644
> --- a/drivers/virt/coco/Kconfig
> +++ b/drivers/virt/coco/Kconfig
> @@ -3,6 +3,7 @@
>  # Confidential computing related collateral
>  #
>  
> +if VIRT_DRIVERS
>  source "drivers/virt/coco/efi_secret/Kconfig"
>  
>  source "drivers/virt/coco/pkvm-guest/Kconfig"
> @@ -14,6 +15,7 @@ source "drivers/virt/coco/tdx-guest/Kconfig"
>  source "drivers/virt/coco/arm-cca-guest/Kconfig"
>  
>  source "drivers/virt/coco/guest/Kconfig"
> +endif
>  
>  config TSM
>  	bool

Yes, I think that looks right to me as core infrastructure pieces are
not user selectable like the leaf drivers.

For now I will note the mixup in the pull request and would be happy to
take an incremental patch fixing this up.

