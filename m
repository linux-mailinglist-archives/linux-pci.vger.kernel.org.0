Return-Path: <linux-pci+bounces-40152-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 405ECC2E634
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 00:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6BDC188BBE8
	for <lists+linux-pci@lfdr.de>; Mon,  3 Nov 2025 23:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CF6296BAF;
	Mon,  3 Nov 2025 23:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y6TgepT3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABDE218AA0
	for <linux-pci@vger.kernel.org>; Mon,  3 Nov 2025 23:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762211873; cv=fail; b=jTMkxPFZoK3TVt2e7xH0JNUcSszkVlB5bHSUSE+WzAfS2NjZv7ZbA6xeVhhiimGNuJzXJ0FNrd3JMADSSu+QZUi22vt6z4Ib1lhPWxvX7dnuQRDbW8idEAy4UXW3LwV/NCvEjFy0ifHAv5C8WZJCD7wRDRZo0FjjSPt/7RD56pE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762211873; c=relaxed/simple;
	bh=Gc4yXDDkNUPG1iDPZCODTHML5HNjRYnhARwQKHTXg9A=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=QtpU/PbMZ28cDvUYso+FF2vr5uo/PZjZmfUt0cwpRnjgXichJTatmm5gJBlr7M98k0FSENwVyUkhQ2v3qEBeVKkTpzFZKtUOFeRmoDgTQQClNlAzUOB4xAC8sJtvjI+g5OH2Pk/wtHkihvww1sdoC7sKigHmlWzpTL6QShPFSg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y6TgepT3; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762211872; x=1793747872;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=Gc4yXDDkNUPG1iDPZCODTHML5HNjRYnhARwQKHTXg9A=;
  b=Y6TgepT3tHBw8EBWFi6F05PFeRqNcVAdKIUw/TWmDS2IN6MhlYRDSPgM
   x/VLY/gCoI9UggSNkykTe9XG7hBmOLtg2TnBB7TIc92hKqcF6N3D2NYEr
   4sJGdmpYk/6vatHJRQzmdGzRvA83k639JT9hcqWt/PMHGV9NHuyuaUeHp
   egNRRekdCvmXHa3RTUkqZT3M21S6wUrDNqSZUSqntn8jnD/+VL18Y6RdZ
   owSQlCf7UUP1R+ujeL9K4g45nF3x+9HXCVKYg/PTAN9F9crHOzBuADIyP
   tscr5evex5Vf44NOK5c7+YYDZQBqf/g2Cjjs25491Us643hRPI9pV+rI+
   Q==;
X-CSE-ConnectionGUID: tr6eXx/aS22dsRNjRultmA==
X-CSE-MsgGUID: WNNZqO1kS2aP2sGDKdN9Uw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="68136845"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="68136845"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 15:17:52 -0800
X-CSE-ConnectionGUID: xNqOpuzpQUGS/CeqTC5//Q==
X-CSE-MsgGUID: JCorx5uZQzmBJaqQJjRFUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="186681446"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 15:17:51 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 15:17:50 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 3 Nov 2025 15:17:50 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.17) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 15:17:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mJRsjW4nukrHqDmh5rgBGiJC4Gh67kdC8gWyAhelkekE+NqFx64Grt8Ehe4ZGlodPgoMYPN7fIIb0qvCbb1Qytpl6SR7dnEqH101ZR6eJJiUSEyUOkDnkXHK+9q2sL2fxSjF5ch/t5lNglt6y6ehLGuU7kliS/ycQUKBeYYPw/EO1xEYr5O8JpfqACwB26J1GoXYAPhamHiau0Kc7mDCuAQCyyT0GksKJ59QXL6P4Z5nWnAOf9SCXQ+vfIE6UdpULtC6KngP6hBXPQdNSapMK5/pxFZ4HQ9kIJ4rVVXCoZviu2myhMUCOoI4zrcKvmiITWfZdXn9cujAHeeveH44wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nMbImyVm3n7Ds9ATYzkmDsUaCwJvdegtA7VWGU2aEaU=;
 b=h8noHztGY5ZG0rk1gXnM2Sisf6a5lLyt0L5PJnABg0/NtreaFrP9sPkIZKjWJozjSIfI762X5GN7jmeMfV/e2dEyCxRqmuZyXovsju24loWBcMmg0+H7vAKFiyN5N6cgLk0ozCU/kwTPIZqGCxtTKElvyihMj83QJZOglG8LLj4we90QUXto/VZ011qWjDd1QmV+A31rWnSmmnD5wrzaWM9l8TI8YXwmipWL5f02vQCVJfl4tS1y9gGqx5AGZUokhjIC4CaGtD9k0y6xD8GAOHA6m5aNV++aYOCN/2ymhUnVYrhPDYHehzZfRSmYcmlASZeYkp8soxUYBkkfNFxl7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by LV8PR11MB8770.namprd11.prod.outlook.com (2603:10b6:408:202::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 23:17:45 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 23:17:45 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 3 Nov 2025 15:17:43 -0800
To: Jonathan Cameron <jonathan.cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<xin@zytor.com>, <chao.gao@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>,
	Zhenzhong Duan <zhenzhong.duan@intel.com>
Message-ID: <69093817a5f37_74f591006a@dwillia2-mobl4.notmuch>
In-Reply-To: <20251030104926.000066c3@huawei.com>
References: <20250919142237.418648-1-dan.j.williams@intel.com>
 <20250919142237.418648-6-dan.j.williams@intel.com>
 <20251030104926.000066c3@huawei.com>
Subject: Re: [RFC PATCH 05/27] x86/virt/tdx: Add tdx_page_array helpers for
 new TDX Module objects
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0020.namprd08.prod.outlook.com
 (2603:10b6:a03:100::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|LV8PR11MB8770:EE_
X-MS-Office365-Filtering-Correlation-Id: d97c914a-ad20-45bb-c94b-08de1b2f321f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RnZpRGF0NWNab0ZWOTRZL3ZqQjZtb1BUNDdSMGtzRDhkNnBOd0tOK043c0FI?=
 =?utf-8?B?ZUdoaW4ySEZTTDUybVZ1QzJjc2U2K0s0UW5xd3dNYWpXM20xd1VCT2NsamlQ?=
 =?utf-8?B?NXdUU2lHREtXTmlVeDIrTjlKV0VaVHpVSlcvcEFMU3UveUl3L1FLWEdXNURW?=
 =?utf-8?B?aVphSkE3enVJR1lKNEdVM3NiUUkyUW5PWThmZDc2M2V2WjVvM2xYOGl1SXJW?=
 =?utf-8?B?UytzSE8xdDd4ajU5N3g5c3c3dkFMeGhTSXpEdyt2b0g3eGxPY2s5NWU1d0xs?=
 =?utf-8?B?WVZpVFF4VW9wdWNkZ0hPWVAxRUFhRnlPd1VwYTZBVi9Ld2NDSVNNdmptaFQw?=
 =?utf-8?B?ajE3ZWIyL2ZDTGg1ckk1eGlSRFFBM09WOUxRMWk3Q0N6Ym0ya29iSUFXL3JH?=
 =?utf-8?B?QURKWEpHYVpyZHBYdUk1SHFtdjlYdkV6KzhkalZ5SHV2b3RGL0VwNWR3QnJO?=
 =?utf-8?B?QUdOWmZlZW9hQzVUenVFaE1IL2VEcTMzZ1hWaktGMTZSaTdqa0EraEVBL0RO?=
 =?utf-8?B?d2RuNmFKdlVMYXNKVE9kSXNuclZMdzUzRUt3VVM2RzZRMytMOE5KVDRHRVhk?=
 =?utf-8?B?V1ZQQmpJZVI1Nk5iMGJpdDc4SlNzcmtieGZObnRGdERudnlzWlVkam91MTlI?=
 =?utf-8?B?dmlRS0tRV3BScGlCVnFDWWtTRGUvMWVBZTNIaE1mVUVGN2tpVlFQTkRuMWkr?=
 =?utf-8?B?NTJuZEdCQm1zZFQ2ZDd2SjRBVVlvb1M1ZG5qNlJvY3FMeWtOSFpMdjVFZnN2?=
 =?utf-8?B?MkFsS0RlZlY3Rk9sTHQwQUNEdDE5ZWU4cEQwRkdFOUZsVjhnZzlNUjIvVCtQ?=
 =?utf-8?B?aCtLcGFjWkg5eUx4MXRkN0tpVU1IM2dEemxwZFdsb2RzU3dSakU4aFhsUlBJ?=
 =?utf-8?B?ZWlHdVZubGloYUJyc1RubHlhM0ZrZGwraWV5bWkybnI3dFZFblVpMnpYMUlk?=
 =?utf-8?B?TWxnKzZMQUZPNDd6RlMwM0IrVTVtTEMrMW1NTGNCRTZDL255TSswbGZQakI2?=
 =?utf-8?B?bThjMHlOc0pqN1JlYWtIa3ZyQlNvU3U3WlpOdWJNSVZsSDJ0Z3k4M1dEeGNH?=
 =?utf-8?B?SDZoVDh0S0ZlSHJsajBLbm9Sak5Oek1SbExTNldMRldncmR3dzdVenZzVmpw?=
 =?utf-8?B?ZGkxa2RrVHlFcTNFT3d0ZnZmNTREdWJCY1BqQ0tzRm40aWFObGlwa21DUDlC?=
 =?utf-8?B?ck5EZnhyaDVneGU4OHZ3bFp6MDJmRHVTVFpHdkUwRExRbEM1MElXZ3hXQU4x?=
 =?utf-8?B?MXJTT2dJVDRGVEdaYlIwNlVrVVdZUm43Sm1rVVpYZ1JmRTRrNkJEU213aElP?=
 =?utf-8?B?cG5qNzBMSFZZTi9obG04OEhTKzdqN0pHVVNiWXpkbkt3dkphcCtyTmRDZ09a?=
 =?utf-8?B?MzRyWGV2NWhrdEFwcDhaS0xWV2pqY210WHhDK3V5TlZiWG4wVmVtSW9Tcyt5?=
 =?utf-8?B?K0FaZDAyUVl1TDNWZmJwSUdpSDVlMFgvT0NvU05sZ0VkZUZPVnhtckMya1hD?=
 =?utf-8?B?Z2lVeEhHb2RBYWxLSzdUa1RjNG9RUjMzT0dzQVdBYlhJSWx3NnBDTk0zQ1Vs?=
 =?utf-8?B?b1dqL1FnVVlWYnRxVkMvb3lwMXNSNFdpMjdLVnl5OVBKTUx3aEtuTGtwWXgy?=
 =?utf-8?B?WG5WaFM0U0JPTzcySm9NNHB2dHkvKzFrS2J6dGUwMDZLT005UGFPNmtDOVZa?=
 =?utf-8?B?T3lIaXJ5VG9uOENZYklSWFdNb1RSb0tXNWY5SHVacDEyS1lxMUo4QXVleklT?=
 =?utf-8?B?TlpGdzB2b1dnQ29CVDBXRU80c1BseUw1TTRNNS9OeWYvR1BqQi9EOHVQYjBB?=
 =?utf-8?B?eHdYaUVsSXRqcnFxTlIyNDgxMVZWamtmSlVPY0dHQW9NR2paVHdEZWNsM3Bl?=
 =?utf-8?B?blJZZXZ2a2E2aUVIWDFtYi9XR2d6OXFnbWc2UW91KzhlTEMxemVSZWJZb3NK?=
 =?utf-8?Q?A4jKfo6Tu9rCqQbWsMvo0vCfPCvlo7lP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0JlWGgrNktGaDNRajNpdk5zZUtWc2lzRDB0d3RzeElieUhPL3JxMUppVGJt?=
 =?utf-8?B?VlRhaHNsQ3laQzFyZ2tDMW02L0ExNXlZUFd3UlNTejNQd0RMSGM3OXZocFZ2?=
 =?utf-8?B?d0hrejZyYVpEYU9lNjBTamdiWHN1b2h5OTJMemlkSzFLMTJhdmtyMG84RGlF?=
 =?utf-8?B?TWprSnF0YmxCb0NNcEFQSTErM2VnT010WnFnNy9TTlhiUHo5dkFtQlgvQWgw?=
 =?utf-8?B?WnIza3E3S3llNVRPRDRUUis2V2RSekd2ZElEcnpDQU9YU1FYbll0WnpqZjVq?=
 =?utf-8?B?bDJnajB1dTdxNVdERlY5N1ZyZ013K3lqOElQeEhmQTVmdzR3UFhXcGtjc3Vu?=
 =?utf-8?B?bXdFaHdYeE4wdFJRNTg1Vk9hclUwS3NwSkpjNTM3QnZMMEZGdm9Hc0FxK3FM?=
 =?utf-8?B?VU9STm1ZdEwzMkRJaFBxVFNpcmdldWNRZG9oQW9ZZUU4S0g2NmNSUGw5bmZ5?=
 =?utf-8?B?dWVHMHplTGFKekVHQ0pJV1pWc1FaMUdhMlhLV0VGQkNpK0F6OVJubThFSUwz?=
 =?utf-8?B?cXJDZVdoM2VvNmJtRXAyYjAzazFlM0FWcS9TTjk3SkgvSExYaWpSc3FjanJN?=
 =?utf-8?B?Y3ZEd040RVdiNCs2YzFuZGdwZXlTNUhyRTBab1U0UmIwNkYxajY4QUtlb21r?=
 =?utf-8?B?VlU3Q1hCUVpRcmpNUXExWVJaWllhSUkrMXJYTHZFM1R5V3FKYWw4cWp5ajNJ?=
 =?utf-8?B?LzQxY252c28wbldTUGZwZEZpdXowU2VFQTRnSTBwVDhrdjBYbXN3OTVNL3Ja?=
 =?utf-8?B?dUIzaEJHZmpidkQxTEZaZTM5b3VlTkVJN3krVkIrU2xCaWV0a1hoa2VIY3FR?=
 =?utf-8?B?dzNXUytpbkY4d3I4VFNsT0c3VGRyM0VVR3ZqOEVTS25EU09rYWZvQVFDajlx?=
 =?utf-8?B?QzQ3cXRPdmlhaEdsaHlXNDYvaW9vQkIySlJPN1pkNWE3QmJieUcxMEh1ME82?=
 =?utf-8?B?a01ydG5DYjZhSWtuSEI4Tlh5TWFkNm9zOUxTL29qTDVDWi85QXFxYlB3US9U?=
 =?utf-8?B?TVErZjVMZFBuNDQ0NXZkUlgxZ3R3RWRDZkpEQjdjdUtWendsQnlLeFJ4eG5J?=
 =?utf-8?B?Zkh1Vk1yLzZna25BcGFZcXR1dUhlT1RpbVJoa2tmVWdZUU5WQ0pvbWZycHFV?=
 =?utf-8?B?eXVpVjZYcjJZWndLanl1UTJsdHRVaEZ3dkI3U05TV0NscnNiSWU5UnVlNFAr?=
 =?utf-8?B?QnhQVGJVL2doTFFCT29tMlFGVjV5eldLdlZQMDlhR1JkazR3ZzQrQ2RMN0lO?=
 =?utf-8?B?a3FqZENCbDUzS2pRV2dWYWQ2WGpMN0FZTmRtUzFIck84eG9YVStsVmphaDJS?=
 =?utf-8?B?Z0w0cmZ2aUUvY0JPbWJPUi9qUDYreW1STGVJUkpyWCtOOUcwWFBKK0hYUXpN?=
 =?utf-8?B?TC9oaWhaSmx6VTRDV1VadFcwUE51NU51MXdkb1owOUdhTytOOExnNzEzcGd4?=
 =?utf-8?B?eHFCVENjZGNzLzdoUkFFMW44SDNuNDNSMEdVdHdaV1N1b2F0WlEzM05hTTg4?=
 =?utf-8?B?aHJReGdzRDV5dXZHb2E3Q0w1Q1c5US9YN2diMHRBVmMzVXlGdC9MenZyOEVr?=
 =?utf-8?B?K1k3bFN5QTcvTnZmOUEwYlcyVWRlb0hnNUtoRnNPTGpPcTFLWkIxMVpoUi9q?=
 =?utf-8?B?YlVRTjdEZlhqdFNvdlhMUm1xZmlGVzlGcUhzMk1zQXJlckFiYUFDRDF3R1dT?=
 =?utf-8?B?dGorRStwRUMrSHB2OGN6VXQwdXZudHBDaTBpOE5TbDlBVWhwbXBIKzlQYnUr?=
 =?utf-8?B?TmI4L0dJVGk2cy93S2V6ZTZVRGNsRVFNYWtVaUtkMVYvV3JWOUw4THMzVW0y?=
 =?utf-8?B?ZTZnZHc4WkNIZmwxd3Q0YmRtRktTMnErUzlxVzgxUHFmeHhjOS9GdnJYWkUr?=
 =?utf-8?B?R2VFV1ZndHBSazQ1WFM0eFZzN3hVekJjTDJEeFFzNjZOc0hLamo0MDRqcTN6?=
 =?utf-8?B?b2J6NDljSzNFc1RtVjZldjR6ZjdMWkhTRmtZeHU0Ym00a1o3YXF5YjR0Z0RZ?=
 =?utf-8?B?UXBRWXhnaWw0VUt0RWxIKzVFTGpRZXRTVmgxcW1WdHFhV0U2RXFyN0Y4c01X?=
 =?utf-8?B?dmxWMGtPSUl2bEw4eTF1WWEyUmZXdVVleXFreUN6R0dwbVJ6V1V5Q1o3T2E1?=
 =?utf-8?B?dkdQOE5hbVB4aEM5RzZPMzkxSjkwcW4xNDBxeG9RVzh4a3V6dWVoaVpHRVFY?=
 =?utf-8?B?SlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d97c914a-ad20-45bb-c94b-08de1b2f321f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 23:17:45.3197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YLBxjQP70GScLCRWN5N3EF3MLGrdBHzQmbCub6pFEqG3iqZH4SezHXw5dHIjOL5YjD1WBAjzTrg3lD3aDF1/ZbQRvFMYDdrRFrRUoXEDNZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8770
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
[..]
> > diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> > index ada2fd4c2d54..bc5b8e288546 100644
> > --- a/arch/x86/virt/vmx/tdx/tdx.c
> > +++ b/arch/x86/virt/vmx/tdx/tdx.c
[..]
> > +	if (page_to_phys(array->root) != released_hpa) {
> > +		pr_err("%s released_hpa [0x%llx] doesn't match root page hpa [0x%llx]\n",
> > +		       __func__, released_hpa, page_to_phys(array->root));
> > +		return 0;
> return false

Good catch.

> > diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> > index 5ebf26fcdcfa..f0a651155872 100644
> > --- a/include/linux/gfp.h
> > +++ b/include/linux/gfp.h
> > @@ -385,6 +385,8 @@ extern void free_pages(unsigned long addr, unsigned int order);
> >  #define __free_page(page) __free_pages((page), 0)
> >  #define free_page(addr) free_pages((addr), 0)
> >  
> > +DEFINE_FREE(__free_page, struct page *, if (_T) __free_page(_T))
> 
> This is at least more 'normal' than the CCA set one for free_page.
> Burying it down here means getting an MM review. I'd be tempted to find
> an alternative use somewhere else and post this stand alone to get that
> review done.

Can break it out and front-load it in the series, but I am not expecting
controversy. The __free(kvfree) went upstream without MM comment for
example.

If you have a use case for it ahead of TDX Connect, go for it, but I am
otherwise in no rush.

