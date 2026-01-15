Return-Path: <linux-pci+bounces-44987-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B30D28790
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 21:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 066D2302CBBB
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 20:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D5A322527;
	Thu, 15 Jan 2026 20:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VsNburvN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C253191C8;
	Thu, 15 Jan 2026 20:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768509763; cv=fail; b=lbmlQkk0lu2+/gsaccnHunR3pVFqBaVpD2kkwPNlbgyqX2vTSZkAZJ9+cTricwxtqGmjWh7Qe2fa73O3+IO2oQ2XKviYCbJchtlHrF5h81gsR4f1Wm+LKkn0R+AhY4TfR1m5/K4HMFaTcq4NfZw54oD33xAU73AyHkr1DkpeWsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768509763; c=relaxed/simple;
	bh=EXdBTMtqIqhyA3TWS2PK9ZkoHjC/5UwJnGWKqByFYhI=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=mk7dLRMrQ4WnFEGwTshMahHwE49MujLeGfN+TqzdprC8hbFQebmDwefD08Q/ikr9BLt/hB9YEca/PkJSnfZr2lTNAs4fdmlIN16nggzuITE76dOdKqQ6wtkyMKXDU+ZrzjihF4JqrZzIodCRd0qRAOJUTojaNqikQw9H5N+aRrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VsNburvN; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768509763; x=1800045763;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=EXdBTMtqIqhyA3TWS2PK9ZkoHjC/5UwJnGWKqByFYhI=;
  b=VsNburvNPBSRC3lq1JfDTxUBHWHPwBKq8QRi0FAMIz1X+4vhn6fIaE+e
   Mn3/W/5Y7ykXHA8tr7tkTCvT6HEmSgl2WjlTtISVDYybvu/5ZJ3HOIFiK
   vDIWTf+/NcTGXeDarD60OBduA9FLl5qbjmu/Om73z9x3/m5keF7Ll5gby
   x9l3HpovyTF4JgSP1CvVSQzMP5FpwCBMkOzHkam96r2lF8eAxcexJTbKX
   GGHc6nhMDS6/Oro1MpXKPAM9FRExdSJcnhag+vE2pcuTK9Wux099VXQYd
   j5faPbbg1qdMdnCHqrVeAYoVIpxCovvuAnkdvia+I8yZzALmOGSviplkD
   Q==;
X-CSE-ConnectionGUID: 4mM48FWKRmWgIVs2rfhfUA==
X-CSE-MsgGUID: 4+G7MllcRoG2pqv/knAL2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="69805406"
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; 
   d="scan'208";a="69805406"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 12:42:43 -0800
X-CSE-ConnectionGUID: xk9afqPURAaYct+fXjk9NA==
X-CSE-MsgGUID: tNmMGipsSqSHC0XkTo1QRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; 
   d="scan'208";a="228113116"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 12:42:42 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 15 Jan 2026 12:42:41 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 15 Jan 2026 12:42:41 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.55) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 15 Jan 2026 12:42:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jlRsK6KIYNxlDFkf0ZA+gJEpUb4cVkQlnZbGTiBPADZdYhaWFkCObzM+ugXiWdUCkqWO+KQJYXkEh+5zJEWSin84xUFgNNTTjtRDxkUneEfkTOF7knByYf4Cq+V1wGhNU+BIeMAm9ZkSXdHI3s5rBdFmoebPlJYoV0XJ83ob+QHX3B1eRVKCisgzNcvTx6Oy/kIXqs97/Bc68UpKpyxwKAwZwDSJBI3wExDrCvSv5bdOrrYX9ftrjJtZAwFDuYpm4fBTCxLEGCMbciaBUhWVuaHDe7ID+DinnxClFvHnHPhFfXKlRzpLOZ6zLXd3QAKDboRhUUb3jTX6Ta8+StK1Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qlnPZsciHOWwZmTZkYyIVkoZ8n53T2COd6kfJWWwXaw=;
 b=dQRy3IbLevIGwZv0N0+ckhSRlgsbJicq3y8HGTHKG3pYazWqx82kZw20W4J8v/h4Hi45iWMMPsPlQ2xs32dTduzerbwdzyzNLvYOQmZ7rqsfDCUV8DaEZFozfxqWuupWQXKOdpWC9o3fbw7TTl8HyOt2b7gaUReIJN3YDKg5sbwEnQTxHO8iPIbUggnYSHBwd1IkcYbVkDYlct6RGArrqB6jgQs2HzeouVbleP63vLxoDJ4myPPVliswqw1SA6TYE54xAF+rsByaQKud7dJzbvVvxUdofEwBFh8/x4Dlj6Y6r6CikrnYKa7QQootmtdbixlMa3szBwLv/7sPua295Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB6688.namprd11.prod.outlook.com (2603:10b6:806:25b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Thu, 15 Jan
 2026 20:42:39 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9499.005; Thu, 15 Jan 2026
 20:42:39 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 15 Jan 2026 12:42:36 -0800
To: Jonathan Cameron <jonathan.cameron@huawei.com>, Terry Bowman
	<terry.bowman@amd.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>, <alucerop@amd.com>,
	<ira.weiny@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Message-ID: <6969513c2b1a4_34d2a1008a@dwillia2-mobl4.notmuch>
In-Reply-To: <20260114190818.00004112@huawei.com>
References: <20260114182055.46029-1-terry.bowman@amd.com>
 <20260114182055.46029-11-terry.bowman@amd.com>
 <20260114190818.00004112@huawei.com>
Subject: Re: [PATCH v14 10/34] PCI/AER: Update is_internal_error() to be
 non-static is_aer_internal_error()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0008.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::13) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB6688:EE_
X-MS-Office365-Filtering-Correlation-Id: dda0ec7d-c9f9-42a3-11d2-08de54769f3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MFZjSldWdXk1ZmwrZ1pOckxCempwYkNiSzF4RWRJbWpaSmFhbG5LeW03S2hX?=
 =?utf-8?B?ZmJuNXBUVG5QSmVmOWhRZXdVZHBxaVVFK0NJTkpLbHBHbUJnMER1T0I4enAw?=
 =?utf-8?B?blBiNFYvTFRMMkRmeU1PR3ZIazE1OTQ4cm1GMGxJUHM1NnVna29GcEp1MVc5?=
 =?utf-8?B?RklXd0UxTUlmU0s4aXZKcWFwaXJiN2lOSlpIUVVGNlkzVkl6TjhxTE9pMlJj?=
 =?utf-8?B?ZVFvbUJKM2NnODNGYWQ3UzQ5ZytJdGMvT3NKa2ZNZmc5c1FzdStSQjVNWjRa?=
 =?utf-8?B?MDFIajZUeGlDbTg2WDB6QlBhL2MrNXlNMHg1SFRaTkY1QXdMclY2ZlZneTZs?=
 =?utf-8?B?Y1crbGZGNDRmZXdqZ2lkOXd1cGpIL2labUhSSGNhZjlSN3hTaXIycVVUcW9u?=
 =?utf-8?B?bG1wNzJwZVgrd0VsNDROek9nT0NzaEJ0MU8wcEJjRVpHL1IrZEJnMkJWamhY?=
 =?utf-8?B?VEJUM3JnQ1BkZmZZNXIwbkVsQTRkOHpCb09tU2NXd290Slo2OWNKQUtLVVly?=
 =?utf-8?B?clJ1WitlZmFLQWV6VldJT3dHSmxGTlhkekY2TlU0WERka0FlWlIxcDQ5NzFC?=
 =?utf-8?B?YWZ4OUFTWTVxTXhXV0tJaUwyY3JRQW5hR2J3SGN2eEl2aS9KZGg0aTZ5bk04?=
 =?utf-8?B?UXpXanB2ZVd6dG5tM3U4bUVzZ0RuRUVPVnVkR2NpYlFrRlcwQXg5ZnRkTzN3?=
 =?utf-8?B?TjkxS2VoRGR5QXB5NWdpaU92QS9LQWRydTNRQnZXQ2VKSzRwR2NQZm9RdVFi?=
 =?utf-8?B?ajZ4U0VRbklyY0hwR0dFKzJ5bm9DOHBUNlFmVUFmMWp4NjA2UUQ5MVRIakhB?=
 =?utf-8?B?cTBiSmxPSjgwRXZLQ3lTb1dxZ3pINDBNMTY5bmNMMm42dWEvZmFENUJ4RStv?=
 =?utf-8?B?WXlzSEFxK1kvd05aNzZoQmpXN0E1WUdhdWxrSVJGZlFwVk9keng2Vnkxa29p?=
 =?utf-8?B?ZE1nQkxLSEI1OVRSRk9wUDBmYnZUVEpxbEZYUWkra3NFK29tMmJTWDJrVEJh?=
 =?utf-8?B?TTRDOFAyeDloUHFvaytNQnZjR2RFeGpOOEpobFh3T0FuQUdzUGI4b2tsL05h?=
 =?utf-8?B?UDFFK01JaUVETUErZVN6UGJxKzU0TGYrbFBweXlBUEY5bHhjZ1pBTDlhMG5C?=
 =?utf-8?B?RVBnTUFaK0J6bmpXeUVhNWI5SHpXN0RMU2JweURSUjZzQjB1elE2WHZtbjFB?=
 =?utf-8?B?Q05pMHJ1M0hOYmdhbTB0bWlzL0pRSjQ4VEtpRmdwZnJIanIrVlNaMzJCZEds?=
 =?utf-8?B?cnhBbmpQdlFXRnVzY1NTT2VFL1NGU2FCYXlXbnBQMHppSGJ1dDk5eG1QcS82?=
 =?utf-8?B?R3IwdzJncEZtSjhpWUNReFlTTTZDaTlpR2JBUGVCMG4veWlYKzRzckVIV1kw?=
 =?utf-8?B?Tk92eldFcW9TYlZ1VXdBQlRielJUTkNRQ0hKS09EcmJDZXJYMHd4b1Btc3lH?=
 =?utf-8?B?UENRNkVTQk9jTkN3akhKTkJhYUozaGtWN2lZV1FpeHFQbWpwTlROSG9yck5T?=
 =?utf-8?B?SFhrY0QyNUlpV2paNmRqRFcxSW0vU3ByMEdQSGdLbUlSK05LeUlPMkQ1VFE0?=
 =?utf-8?B?dkVaQ0s2bjUxaC9GMysrMXo5QUpXanBYSzRyM3RUbXkwTGg5cjAwR2MrVG9s?=
 =?utf-8?B?RVhtTVhUdDQvYnNNNGwybGVoRXJPVUJYSm5yRWppVXFObHM3ZGtHM2N1TUYz?=
 =?utf-8?B?azFRWVZ4WVZTTkhvakYyYXd4a1h4dVAxRzIrYlN6RXM2SkdRcFFoeVJOczVu?=
 =?utf-8?B?VWxodHdjdDltZFBLbjQzaWpSdUVUTFUxZ0N6K25NRHh4QkV6NUFReEsxQzdJ?=
 =?utf-8?B?cEJrRnI0Y3BWRlZEaWhCeTJXWCtGcWszbzA4cE9wbTdxRWovbXJobUNYUExi?=
 =?utf-8?B?QlZETUNMUGpHUlNkUkgwTUc4Qi9CUThTYlhYZVl2TTNkTks0WDVlUFdTTkdF?=
 =?utf-8?B?Mlh3VFlaYWJSUFdOWmNUTXlEbHRmRmp0Nm1DNEt4L211N0RwcmFxTWlTL3Y5?=
 =?utf-8?B?eklwN3BwbUxlblJQUkxSMEs2emwySU5UQU41dE9JRzh2NXpyR0xsTERyMVhl?=
 =?utf-8?B?TjJEZUZMVnpNNGFGYmRUc0trS093aVgyejJxbnBJajZkNnV1anRnOG42YkRS?=
 =?utf-8?Q?cxHc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVFzbGMxL3ZGT2g5RXp4bzBaTGw0WS94QkJ6Z1dLZ3BjYXpOcTJoZlRHTk1T?=
 =?utf-8?B?ZmFvNVZmamdrQ2dRM3lBTHM1NjNZYzRBWlE4Tit3ZzZlOSs3UmYrbXpvQzVS?=
 =?utf-8?B?ZlZxRzZjSlYyMGR5NzhQMWZKcGNQa1Y2a1pDcHZjZyt2THlHOXpsb3lFU3Y2?=
 =?utf-8?B?U1hKSStabWMrdVZLM1lWQVRhbWpIQjRpMGVoU29DQ0doODNoYWp6c2pDRUpS?=
 =?utf-8?B?MkVzUUs1MHFsTWdtKyswZFkyektrempmY3BYcGd2OXpZVkNQeWhGVmRZWnhl?=
 =?utf-8?B?K1VHc0ZYN1c0RXZlRDFTN013UkRhVGZOM09DNklUaTZVZFRxcktxTlUySlBV?=
 =?utf-8?B?djN1ZCtrV2Q1SExaWWlXcmF6Qkd1a0tpdkZmZ1NUTE4wM21COXFJVnFFQVkw?=
 =?utf-8?B?Vklqbmx0SGdjditsbE91MEszRlo0VmUzQmVlQmJwc1pWNFhZVlVCMzkxRHhV?=
 =?utf-8?B?M1p3NG5KT1dFZG1DS1VmbVJyY0U1M2FqdWI2RFYrRWJZZUQ0SjkraFBGakxT?=
 =?utf-8?B?RjNqdVd3NkVzYm9vMzNqNXBKSElIMi9TZzc2WXdONXVSREgxRUpkYkgxSGdr?=
 =?utf-8?B?VC9zWFR1anNNL3ZYOW5jWndSUks4QmZaeWdqNmhhOHJCSmRjNjlMWVBOZHhK?=
 =?utf-8?B?YUFLZ0hIUzV3cXlIOTd6dmU4UlZIekpnWUFNNnVkUHZMRlBNSks0cm96QVpw?=
 =?utf-8?B?N0c4UW5POU9wZmdJL2oyOUtLS0RLeHlRMmNqSGN0MUlIa0V3THRKaWYyTzJY?=
 =?utf-8?B?dHRXRVo0b3IxMHQ4RUVRWkJwaEdtM0RMNWRMMTV2Rm1wWC9NNXFFSS82bDF2?=
 =?utf-8?B?MWgwSWViM1JOMEhNS1JSY0RNSmZJTDEyOWVEbTBOamhuU0xHUEhYOVlCU1ZS?=
 =?utf-8?B?Z0ZqeHBPTVpBSXFYNEFRWldBVUIyd1VYYUVUMGlyR2JOQlI3UDB1YlFPcHFt?=
 =?utf-8?B?MDlKeW5CM1NpM3FiZVU2TEJ6cEx4bDI4YUVGR05kUkZUNzN2T3I0Rm1rU296?=
 =?utf-8?B?NDkrZEpuSnR6RzlYS0ZKbnRSTjVoT3V0dVdmc2hHekZRN0MxZlEyeWJCYWtE?=
 =?utf-8?B?SkthZ3FDaEZmZktDd3RqWVRJMlNYbm9RQVgvR2NPM1IzSTBiYnVTOEZZMEh1?=
 =?utf-8?B?SXAwanF0V3NKYXZoZHZHbWF6NHdZUFNTbVZsbUpvVGh4S2xFU0psVzZJaDhp?=
 =?utf-8?B?VDdFUHRJQUdXVVZSMnpJYlBVUFFBdGUwaVNLcGlFQ3NWTGg1OGk1TkZIQ3hk?=
 =?utf-8?B?Ung2dDMweVhPUERCc0JVU3hQUjdUK1daUWV2QURiMlRrRU1XVVdlNmxwL09V?=
 =?utf-8?B?eEhsYjFwcGJlcVBxRWh5ckEwb1p1S292ZFUwNmFqdGdXckFBYzl2NGVpR01B?=
 =?utf-8?B?UGpHaFlzTnU1aEhxUVNlUjhxYXVRVDFvVzVQZHV3TmpuNHlyNDFDUHlESlo4?=
 =?utf-8?B?YktTUWJEN0lnRml0R08vb0M1dEtkSngra0ZkaDc0TkxZVU12VnA0eDgvZkVw?=
 =?utf-8?B?T1VLU3JxSnVMN2VzbkR3bGd4bFY0R3QzWGZzNlZ4NnRCUlJmZjd5TkpZQ29a?=
 =?utf-8?B?SEJlUTRoUEQ5WHRDWlBWNzMrcE9WUEduYm53bDVSSTYvWENzRmFEVlhmNUpI?=
 =?utf-8?B?TmUzdndheHJqcE85YXM5dVpIR29qblR0QXBuSCtWaTF3djB3YzRkNkpZOHIv?=
 =?utf-8?B?YW9wVERLZXJkUlJWMTAxeDdIL1pwSU0yVjVSYzVIdEJRVk5HdlRkUDRVMmZD?=
 =?utf-8?B?d2NRK2hPOUk5YnlZcXNPRHBzdGxXWGI0OC9uRUdaTTE0WjAvencwQjNtZmdV?=
 =?utf-8?B?cFZzcVlCZUxGMUJ4TVFvWjE3Y1pyVUptWEFJdE9vWFZrTzUrUUdmMnM5NEY3?=
 =?utf-8?B?L080UDJRSExVbEN4YkRvVlRNdnJ5RG5UbWVWbGhDaCtBWWJ1bjEzalpFM3Nl?=
 =?utf-8?B?YzNvZklYZFBrVEZ4VzBFYVlCc2JRT1A1QkxncEVCUDNYV3k4R0JRVnk2QXBn?=
 =?utf-8?B?di9HS3FFWlgvZml3eG92cVlwRlAvOVZkaGcvSzI0OGg3Z3VaWjRLazVmMi81?=
 =?utf-8?B?MDYrUzNMbDJ5TzFmSTcrRzRUWk9vMGQ1OERYK25LbGRjUkZmVk55TlJicENu?=
 =?utf-8?B?dlkrcHZmZ3VoVFptWnBUWEh5MGxWMFBLWFI4Y1BINkQ1eWYyZ1ZpdkhpWUFH?=
 =?utf-8?B?T0tFamVIZGtQZFBLenM0U3B4SXJTT3R5amM4QjdqZExtMVFwNjdRZ3h5R3dR?=
 =?utf-8?B?bllMTkNXV1hpUCt2NXplOGl6RWZzbU9ST25aSVJIZE9QZVl4MGxaV0hTNmZa?=
 =?utf-8?B?VURMcDViWVZuOHl0MzY5bktpVGJ1MnpNNDNrajlGWTJJS1NDNStSRWJ2ZGVp?=
 =?utf-8?Q?KlC2mmpGXxepMWus=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dda0ec7d-c9f9-42a3-11d2-08de54769f3a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 20:42:38.9035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JM5OdL4sqbSKph/DZZCINpz3u/fSUw21gVzbFFOI6m76u7TdbRuA/LGvrIuPE9gu13qUUsWKKRc1Fx+HGvsC6BnmZmZhfrCDGiB/7/vkVDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6688
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Wed, 14 Jan 2026 12:20:31 -0600
> Terry Bowman <terry.bowman@amd.com> wrote:
> 
> > The AER driver includes significant logic for handling CXL protocol errors.
> > The AER driver will be updated in the future to separate the AER and CXL
> > logic.
> > 
> > Rename the is_internal_error() function to is_aer_internal_error() as it
> > gives a more precise indication of the purpose. Make is_aer_internal_error()
> > non-static to allow for other PCI drivers to access.
> > 
> > Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Hi Terry,
> 
> I don't see it as sensible to have is_aer_internal_error()
> return false if CXL is not built. That question has nothing to
> do with CXL.  Hence if we are doing generic naming, I think we
> should just always have the function available.  Gating on CXL
> belongs at whatever called it.  Which is the case already for
> cxl_rch_handle_error() which has a stub that doesn't call this for
> when CXL stuff isn't built.
> 
> Should just be a case of moving out of if the ifdef in aer.c
> as part of this patch.

I agree with the general sentiment, but not the conclusion, especially
because this is a private detail. Linux has long ignored internal
errors. The only reason to consider them now is because CXL decided to
multiplex its error model on top of this oft-ignored feature of PCIe
AER.

Specifically, portdrv.h is not in the global include namespace, this is
a private detail of the only conumer of internal errors:
drivers/pci/pcie/aer_cxl_{rch,vh}.c

At most we should have this as a comment to clarify:

/*
 * Note, internal errors are only considered for the CXL error model,
 * not for other implementations.
 */

...and the pci_aer_unmask_internal_errors() export should be:

EXPORT_SYMBOL_FOR_MODULES(pci_aer_unmask_internal_errors, "cxl_core")

...for the same reason. Steer folks away from thinking that it is open
season for adding more internal error support.

