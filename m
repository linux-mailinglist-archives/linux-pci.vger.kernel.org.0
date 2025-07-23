Return-Path: <linux-pci+bounces-32810-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C42FFB0F3D8
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 15:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D69E33AF377
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 13:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0457728C86D;
	Wed, 23 Jul 2025 13:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oo/2FWDJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E9F24EF7F;
	Wed, 23 Jul 2025 13:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753276890; cv=fail; b=KNXfOHx22MWsx7EpIE08WHt4gpovJl3FN8B7eIjboKT0jv8RYnatahHxYJxXX7AzAzoKmFy5BFP8I8HR08unq2W5iJw+toTZfGtCrq4BJNudV186wUStsY2S7TVSkbM27brXFTYvemYrIzb1MsWI7SeirRmf6rPB6ECZxs2u0xg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753276890; c=relaxed/simple;
	bh=cNGBXvZSRF+wEsKBvvn84BKHKmweefbLuJiL6e9emvc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ld0wtrn4++Wm71f6roksMJZEfLbvyFYZ6952X4amiiJ3jxKA7lAyATlBMPMDgSzsKt800PsYFgqAqcdYt97LBZiuDxxurkfXNx7bviCfTpv5tBWEBAWCOLlzhyuUrNQxPRkarezAXDgUjmwS2NKqvmKy2Df38w88ll7DIKBZm+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oo/2FWDJ; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753276889; x=1784812889;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cNGBXvZSRF+wEsKBvvn84BKHKmweefbLuJiL6e9emvc=;
  b=Oo/2FWDJIUFJjqjrSlQIsVpfR1oXBOKeKSicZvdXOU7kvMLYo9VvgIlh
   bhoO/KB0TrScVjPIVftb17QYLhlDvC+jd4eJpGyAqLfhHROBTq1Bw+RBK
   SjEr16qi+Eri4jUQbw8sqA45l0945mbExW0Sk+/HKplqVjHDWUA3B/sL3
   EV/TjTyG3ql+WFPVkbeDdiOHp0cYQQdoaHX0qy99vwIuXPW3TZe4YVPWn
   zZy6FBC8BOO72IobXPiNFK0P9Tlisl1p/+49yiGFQ1C5HbCrY0W8JZpv1
   giPzrKkmuYxOngKyQZkK5vukkEcslm4vuhZFiZLopqdtoLsihhMGXba5d
   Q==;
X-CSE-ConnectionGUID: xeRs4aRPQv6iqqmO7XaFDA==
X-CSE-MsgGUID: uNyp5L4bQJiahRquuOX9Tw==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="55436966"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="55436966"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 06:21:14 -0700
X-CSE-ConnectionGUID: BW+BXtnkREGkXz/BqP5fsA==
X-CSE-MsgGUID: C5e0ISzCS5azpOFDKcym5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="160044404"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 06:21:14 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 06:21:12 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 23 Jul 2025 06:21:12 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.87) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 06:21:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nvyMvA4GSf0IvdsQBvA2kWN0hfwpPQCA/a2V4BnglrlalLpIVh22hmpSgFDpK4kYz9wAFOXisicPrtbFfMZwbFGJ2vncLblanmFLaEnx/HxhuMqEBd7aErLZrrfOHapAO5l4G3whDz0VtAwGZ627Nt2vQ3+f2w1+OvySzTc3AKHnCHQzbGk9Gjhkm0jBCo1YBezM0E3+JvBtvPdpO8TbGOnxc5ScfQDAjWOUR20AJYWB8XoNhWmj0JZmbOpzz84SE8tAwGL+m/qcOuGYp3iHw6wAQQxLXui0xd6vObVC5+FUtOFNdMItlHSKDHTBMKUEzjmCQBcld0uPrvI098EBLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cNGBXvZSRF+wEsKBvvn84BKHKmweefbLuJiL6e9emvc=;
 b=ktQIS9qmxGnu9RvcjGd9gs8aNg3uPpbDCciwTkzmshHvhi/s7UqE+MkojgUzemt2pLHmAZ4muygN1lr8PrkAVihzNVnvMRe5mZ112H7/0NRHybGeF41Kg09BHZQSwUj8UG0UjzMvbzaf2Tz1u/MZ4otMIbIK+KfDiBgtwktAsc+tKtdT7XRHbMivK2B1fgmwXcfCloCeAEezKv7OEF+0TRUoTl2/PJEY5MjHS3OeZ8pGyfLfacem7xK02gp6Q7eaL1PYs2NkSfUpoqI7K+8P8oyEp0JFFdiS8RMpwxAINpCo/CaHqNyge4nnaYugYhHuugRGraD2ocL9xVtQ9+SDfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by LV8PR11MB8533.namprd11.prod.outlook.com (2603:10b6:408:1e5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Wed, 23 Jul
 2025 13:20:30 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010%2]) with mapi id 15.20.8943.028; Wed, 23 Jul 2025
 13:20:30 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>, "Devegowda, Chandrashekar"
	<chandrashekar.devegowda@intel.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "Srivatsa, Ravishankar"
	<ravishankar.srivatsa@intel.com>, "Tumkur Narayan, Chethan"
	<chethan.tumkur.narayan@intel.com>
Subject: RE: [PATCH v4] Bluetooth: btintel_pcie: Support suspend-resume
Thread-Topic: [PATCH v4] Bluetooth: btintel_pcie: Support suspend-resume
Thread-Index: AQHbcImZWQhWyg71LUaY9upu7sI80LMqSUCAgRZ+DBA=
Date: Wed, 23 Jul 2025 13:20:29 +0000
Message-ID: <PH0PR11MB758541D91FB3ACF199575BF2F55FA@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20250127124908.1510559-1-chandrashekar.devegowda@intel.com>
 <4dbe15ea-eb68-4096-b900-e30c3d114735@molgen.mpg.de>
In-Reply-To: <4dbe15ea-eb68-4096-b900-e30c3d114735@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|LV8PR11MB8533:EE_
x-ms-office365-filtering-correlation-id: 1533d1e7-d658-4d25-7b93-08ddc9ebb227
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NVphU05udkdUd0NkMjhVQmtjZDF5VEFucjNocUFQeTNmSnJ4OTY1Y2RWVmMx?=
 =?utf-8?B?MU5XUnlXNm1XcXkwTWVMeEs2L244TEw1aW1wQWhDTmc1MDBBdVNscHJuTjli?=
 =?utf-8?B?b3NvdnFhR3FnUmhsU2hxL1dVdXB1NnF2UnVJalg3T2gwU2FHS2k4Q3UzS2Ev?=
 =?utf-8?B?enFCL3VGTjFqZXdrTVRKSTM4N1lUeC9iVDFBR3E0VGlBalFaeXVRd1BhTXhG?=
 =?utf-8?B?emwvUUl4OUZLSXl1aXVROERjcnBEcjNKak8wN3hSb1EzbHdpcXNpeldxSmFM?=
 =?utf-8?B?clBwQTI5dGlFRWk4SUk1dW00dkJpRjhXa09CTXFleTV6a3MvLzdTZ1EzYmpV?=
 =?utf-8?B?Qld3cEZQdkhiY3hpay91cUdLNTBYMkQ4WUlGTkRxdWNpejdjQ1BrY2RYazh3?=
 =?utf-8?B?MzQzZDNjNy80ME1CS21wa2tKOXdUNVhQeWExd3MwUFhxUHY1RmtwbDJmaWZT?=
 =?utf-8?B?a3lML3RrdHRrL0k3NTBQRDlDaSt1QzFVcnQ1SFZXTGkwVGJrcU4ySGd4TE5k?=
 =?utf-8?B?Y0RGZ1kxTHVFSmZmd0NFMkZrZXpiSnRwSHhHdkVpbGhxZGxEWDFZVkN2NnRu?=
 =?utf-8?B?Y3RqM0d0NHMybXQ3ZVBPcWg1eU91STNlUHBQV015cmliTkkvV0JJUVNVeklh?=
 =?utf-8?B?YjFtMmpTaVN2VXZEdzBMWHk5SHlFWTUvdThUR3F1cVBWSGRONjhDMWNHbXNy?=
 =?utf-8?B?WGw2TkZ2eG0waXVtd2JiejF0b0Z3R0NXTDZ3UndET0ZTWVU5NVFsb0ZmQTdq?=
 =?utf-8?B?YXZDRy80MUF4NURKaVBTODJVSHJmWWc4Sm1LbmpFOVRobWRVYmhCU2FlS0JU?=
 =?utf-8?B?SjNYaUZEcngvWHRpRnpzbU4reURRSlkxOXpzL2Q0VmkvcjgzMTlYR2Y0bUFy?=
 =?utf-8?B?Z2xZZ21sQzFsQmhBajB0dEZoaUVZNlJ2cFNBUE9oTTgvYzZPNmZLVGhjNEg0?=
 =?utf-8?B?MWhwVjk1TlBicE1QTE9rWndLUUpqUTlIYVJqU05NRnl5UXNHaWFyWldTRXl2?=
 =?utf-8?B?Tys4TzJ2TkQrbnUraVgvQjNneUZNeXpBa3d4Ti96R1hVcHhYRi9aL3l6a1cw?=
 =?utf-8?B?NG1YTm9HaDcrc2dZUVI1UEtvTGZlVWtlK3IzL0g4N2FlVGpWSjdZZmpYL0sv?=
 =?utf-8?B?SmFwSzM2Z25kRWZVVC94WTFTM29FaSt0N1k5em5qWEFnNFMzRGVLZUhuVm9o?=
 =?utf-8?B?ZzlZMTc2R1NXRDhoK3RxeUhtVFFJQjZwQWlEaU8zTTdEUE50RHVsMnhub3h0?=
 =?utf-8?B?M0lIZ3NEZ0MvTWxjRy9uNDR6elpVQXpYMHMyTExXdzcwQW1hcFQzckFYQjVw?=
 =?utf-8?B?dGJ4V0pFUXUwVmI2Mmc3ZzJ5bkVYMG9rMk5aOFgra3YvRFFkL20vVGhkQ3FY?=
 =?utf-8?B?ZGxTY1BpVDBqQWlYb2F3dlVhYU01ekJNbHFOeGgvaFphem42VytNMTVUU3Vz?=
 =?utf-8?B?QzdISUQwZDBxenFpS3NLbjFUR1dhaVRMclMyU0s2Sy9sRWF5bnlPSVNrb2t6?=
 =?utf-8?B?SzlSY3hGRXdYN0VPVFI4Z0pjZ0pzR3poTDBtbS9PZngvRjBrc1gwcW16RE1v?=
 =?utf-8?B?WDBPc1dXTTAwNDlYRjAvWXpYQzVOUG1mbmtpVlJESWhreHZ6VDFoRnlnR2Fj?=
 =?utf-8?B?RjJsUXBsM2srUXJaR2xUUkN3eUdmdlkrd2VKSXpKTXQ0ZGV0WnU3aHhiU0x3?=
 =?utf-8?B?a2RuOHZuNmt5b2MyQXJyRHVjcUVmc1M2ZGkwVkJxenpKdWQ5TEtQVlQ1RU13?=
 =?utf-8?B?Rzc0Unp5ZEltNSs3eTlZUmpQaU1pQVVQcGo1TTlxQkxnK1ZKSmdBWFlKM09U?=
 =?utf-8?B?TmdJcjN1cWlnV0JZVitUV29td1U5YTFBY0xzZWk3WGRkajZkdUZ6UUtjcmlp?=
 =?utf-8?B?OGFLNzdNVW9tMFBudUgyL25NUkg0OGd6NXR6dkRZZjZCeWJWSVo5Y0tJbnpV?=
 =?utf-8?B?SWw3MWx1dVYrL29YWHFVWjhkWW1rRmJjNTlFRUE0RXlZY0Z2MmJqOTRWZEFr?=
 =?utf-8?B?N1BYbDVlUDR3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c081MmIyQWZrR1ZYNmJpbjdsT3MyVXIvR0RHcDVBM3d2WVlZZjhiQ2hYVUFP?=
 =?utf-8?B?VnZjY3MxM3lqeDNVK1hIOHdXby94ZTNyVFA3UGg2WTZsOHllWW9TbWZEQ0h1?=
 =?utf-8?B?L1JGY2JKb09vaWswVVpoMmd0ZmtXTDk0OE8xayt5bGRIWVBJSytTWDBRd0JP?=
 =?utf-8?B?MjFFaDhIZW12QzVQMnZIYlR1TmtiRWllZmlFM2NtTnNpSVpxUTlSQTAwRnZ6?=
 =?utf-8?B?eXlxWlJwUi9xaWhpNGtGRXNlK094MlF4RUNBYmlLalpuMTJSdDVrdmhGbGVM?=
 =?utf-8?B?MHJWb2g2Q1dMUmNhL0RQeXRNWGtxY0drSjE5cjRJcEMzT0VycCs3STU4WUZa?=
 =?utf-8?B?a2VZSHlGUy9IUWZ6SU9lZzNlSHRPRElPRE5WWlJMeFBBUjNOT0ZZbkVoU3h3?=
 =?utf-8?B?ZVZHNkQ4UDdmREpoN0p4b1VnMlZ3ZnIrNE9nNkJ1WFJqQ1hKNzFzSHFibkkw?=
 =?utf-8?B?WjczMFZuenpYTFJmTG1CdWJSc2lvcHNPejg1dVFzZzIyQ3VoMkZjcTh4Qjlm?=
 =?utf-8?B?ckNwMUZIanhuSzR5NDU4SHRmOGErUWsxVU1JbThVd216b0VIOFNOVnd6RmNX?=
 =?utf-8?B?L2UrUzdrMjdZNzV2RHBId1orK005RlR0cVpTSG1DQkNMNGcyazFlanJ4eHBH?=
 =?utf-8?B?QW9qUkl6dUUyOGdhNUY1bEpzQlBKRG9vNFJRM0hVVTZYSUZRY3FmWTFqSXRn?=
 =?utf-8?B?WnpVd2dpT1AyVkJxMVBRM1dYVHdLVWFQM1FuTTVmbGFIVi9Ec2VtSXRCdmNT?=
 =?utf-8?B?cUlBTnJtc0FJNEVEUmlQT3NnQjhRbm93VDRpTDRJZVhBZTU3amgyZFc4SDF4?=
 =?utf-8?B?M3VNZU43cGRaeU1hS2RXMEE2eTFzckJLWlJLREdhTUowczVlSnVNYnZhRk1T?=
 =?utf-8?B?RjlrQ0RwWG1jN3VVM1dIUlNGL3I2KzZtYVE5aklTVzlMWDU1SzZvTExUNWln?=
 =?utf-8?B?OHYzVUpNd2o1K3haajl4RUZDY2ErbGhZWUVVOHI3N1d0VVZTL3FlZXB4UnMx?=
 =?utf-8?B?allzUkFSM3llUUh2REpGbTEzUlloT2x1RStVUUg3ekhJWmk3c2lXS3NsMGtw?=
 =?utf-8?B?cUszTXpkZGRBSmluTFcrYTk3M3JWME9HRkltRDFUU0ZWWno0WE50SlZyY2hn?=
 =?utf-8?B?UTZ5MVFKZk5YUmc0SVFHamNBRlJtakhzT1JpYVczalpQRjFnL2ZyeDgyblYv?=
 =?utf-8?B?V2NaRFNrTmtMeFFIVjFqM2F0cXMrRFZvSU5wVUlWK1Y4TThJMHNUdzNSTVE5?=
 =?utf-8?B?cjl3NHpieVBPenRHUVh1MThvajFHd1BLUVdzamtpQXorZDBuaTdKazBDQVVr?=
 =?utf-8?B?UjcwMGswK2xDNlYzZlpNK1pnOEpQU1RpQ1ZXR21lMHpOSE02VzNBT2tWbk5I?=
 =?utf-8?B?N3BLUTBrWHgvMWM0ZVJudG5BTkdpa0dyWDhWSVdtRk5zWTV1TEpmMElNTVds?=
 =?utf-8?B?dE9OMjRnTVl5QmdUU0dWME9BOXhCeUt3d09RLzVieGltUVNIMWpGZDUrOWd1?=
 =?utf-8?B?R1NGOWJtQUhoRDFWb2xGTFVId0M3Z2YzN2FCRm9ZN1NoSk9uVm9OTWFQOUdL?=
 =?utf-8?B?b2RnRktOeW9pRWdNTTFsZHFLRzJ2SGM1ZFdqalR2S01wMG9zaDVURUNQNndy?=
 =?utf-8?B?VWFBUEFKTGlrK1BVUVBuYTlPWjA4WncrdW50Y2VZejJhR250SUJLYjRHQTNE?=
 =?utf-8?B?cTUwSVk0YnVXVkM3QkppeEtteGQ1amNSTHIwMC9iSXZBb1JSVVg4VTJnS0I1?=
 =?utf-8?B?UUtYZjZnQTZON2toYnRmSTN5R1ZVZDkvYXBnUXB3TVhkQnBZVnhHRkJpcms3?=
 =?utf-8?B?Y294WXN5N3BYalRjejZ6UUxZanFRYnFTOXd4YlhYSE8zeDB2djExUXpPQzJF?=
 =?utf-8?B?MWNkZnhDR2lqR3dza1BEQXVwU0JyK285aUZVcmN6bGJ6MEQyT3lsWUdPZWRQ?=
 =?utf-8?B?cml0cTByMnhhTG9kc2xRVjJrVHpQL1EvS01XMk1NTXlDb3hIUHNUQzNOaS9M?=
 =?utf-8?B?L3hKUFhMNXBwV3drbjZjaEhWNUlNWDRabWl1blh4MFNwREtjOExIS3p5VVlu?=
 =?utf-8?B?Q1Nua0hpSWZyMXhNc3p4K2VYVFljV2RGQlN6THA3N0RBaTNuSXo0Q0h4MjZ2?=
 =?utf-8?Q?LK1M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7585.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1533d1e7-d658-4d25-7b93-08ddc9ebb227
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2025 13:20:29.9467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YGooYsHuSGLnivewNBP2bmWvMawJ61s4DMViO2lr+xaVAz0v/MbXwn75gA4UYEFxvjiF7TEQWbu3Hxw/uPsWvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8533
X-OriginatorOrg: intel.com

SGkgUGF1bCwNCg0KQXBwcmVjaWF0ZSB5b3VyIGNvbW1lbnRzLiBBcG9sb2dpZXMgZm9yIHRoZSBk
ZWxheWVkIHJlc3BvbnNlLCBhcyBJ4oCZdmUgYmVlbiB0aWVkIHVwIHdpdGggb3RoZXIgcHJpb3Jp
dGllcy4NCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogUGF1bCBNZW56ZWwg
PHBtZW56ZWxAbW9sZ2VuLm1wZy5kZT4NCj5TZW50OiBNb25kYXksIEphbnVhcnkgMjcsIDIwMjUg
MTo1NiBQTQ0KPlRvOiBEZXZlZ293ZGEsIENoYW5kcmFzaGVrYXIgPGNoYW5kcmFzaGVrYXIuZGV2
ZWdvd2RhQGludGVsLmNvbT4NCj5DYzogbGludXgtYmx1ZXRvb3RoQHZnZXIua2VybmVsLm9yZzsg
bGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsNCj5iaGVsZ2Fhc0Bnb29nbGUuY29tOyBTcml2YXRz
YSwgUmF2aXNoYW5rYXINCj48cmF2aXNoYW5rYXIuc3JpdmF0c2FAaW50ZWwuY29tPjsgVHVta3Vy
IE5hcmF5YW4sIENoZXRoYW4NCj48Y2hldGhhbi50dW1rdXIubmFyYXlhbkBpbnRlbC5jb20+OyBL
LCBLaXJhbiA8a2lyYW4ua0BpbnRlbC5jb20+DQo+U3ViamVjdDogUmU6IFtQQVRDSCB2NF0gQmx1
ZXRvb3RoOiBidGludGVsX3BjaWU6IFN1cHBvcnQgc3VzcGVuZC1yZXN1bWUNCj4NCj5EZWFyIENo
YW5kcmFzaGVrYXIsDQo+DQo+DQo+VGhhbmsgeW91IGZvciB5b3VyIHBhdGNoLiBTb21lIG1vcmUg
bWlub3IgdGhpbmdzLg0KPg0KPg0KPkFtIDI3LjAxLjI1IHVtIDEzOjQ5IHNjaHJpZWIgQ2hhbmRy
YXNoZWthciBEZXZlZ293ZGE6DQo+PiBGcm9tOiBjaGFuZHJhc2hla2FyIERldmVnb3dkYSA8Y2hh
bmRyYXNoZWthci5kZXZlZ293ZGFAaW50ZWwuY29tPg0KPg0KPlBsZWFzZSBjYXBhdGlsaXplIHRo
ZSBmaXJzdCBuYW1lLg0KQWNrDQoNCj4NCj4+IFRoaXMgcGF0Y2ggY29udGFpbnMgdGhlIGNoYW5n
ZXMgaW4gZHJpdmVyIGZvciB2ZW5kb3Igc3BlY2lmaWMNCj4+IGhhbmRzaGFrZSBkdXJpbmcgZW50
ZXIgb2YgRDMgYW5kIEQwIGV4aXQuDQo+DQo+TWF5YmUgc3RhdGUgdGhlIHByb2JsZW0gYXQgdGhl
IHZlcnkgYmVnaW5uaW5nLCBhbmQgc2F5IHRoYXQgYWxsIEludGVsIEJsdWV0b290aA0KPmRldmlj
ZXMgZG8gbm90IGVudGVyIEQwLg0KPg0KPj4gQ29tbWFuZCB0byB0ZXN0IGhvc3QgaW5pdGlhdGVk
IHdha2V1cCBhZnRlciA2MCBzZWNvbmRzDQo+PiAgICAgIHN1ZG8gcnRjd2FrZSAtbSBtZW0gLXMg
NjANCj4+DQo+PiBsb2dzIGZyb20gdGVzdGluZzoNCj4+ICAgICAgQmx1ZXRvb3RoOiBoY2kwOiBC
VCBkZXZpY2UgcmVzdW1lZCB0byBEMCBpbiAxMDE2IHVzZWNzDQo+DQo+T24gd2hhdCBkZXZpY2Ug
ZGlkIHlvdSB0ZXN0IHRoaXM/IFdlcmUgeW91IGFibGUgdG8gbWVhc3VyZSBhIHBvd2VyDQo+Y29u
c3VtcHRpb24gcmVkdWN0aW9uPw0KPg0KPkkgYW0gYWxzbyBhc2tpbmcgdGhpcywgdGhpbmtpbmcg
dGhhdCByZWNlbnQgSW50ZWwgZGV2aWNlcyBvbmx5IHN1cHBvcnQgQUNQSSBTMGl4DQo+YW5kIG5v
dCBBQ1BJIFMzLg0KDQpUaGlzIHdhcyB0ZXN0ZWQgb24gdGhlIFdoYWxlIFBlYWsyIG92ZXIgdGhl
IFBhbnRoZXIgTGFrZSBwbGF0Zm9ybS4gVGhpcyBwYXRjaCBub3RpZmllcyB0aGUgY29udHJvbGxl
ciBhYm91dCB0aGUgcGxhdGZvcm0gcG93ZXIgc3RhdGUgY2hhbmdlLCBhbGxvd2luZyBpdCB0byBw
ZXJmb3JtIGhvdXNla2VlcGluZyB0YXNrcy4gVGhlcmUgd2lsbCBub3QgYmUgYW55IHBvd2VyIHNh
dmluZ3MgZnJvbSB0aGlzIHBhdGNoLg0KPg0KPj4gU2lnbmVkLW9mZi1ieTogQ2hhbmRyYXNoZWth
ciBEZXZlZ293ZGENCj4+IDxjaGFuZHJhc2hla2FyLmRldmVnb3dkYUBpbnRlbC5jb20+DQo+PiBT
aWduZWQtb2ZmLWJ5OiBLaXJhbiBLIDxraXJhbi5rQGludGVsLmNvbT4NCj4+IC0tLQ0KPj4gY2hh
bmdlcyBpbiB2NDoNCj4+ICAgICAgLSBNb3ZlZCBkb2N1bWVudCBhbmQgc2VjdGlvbiBkZXRhaWxz
IGZyb20gdGhlIGNvbW1pdCBtZXNzYWdlIGFzDQo+Y29tbWVudCBpbiBjb2RlLg0KPj4NCj4+IGNo
YW5nZXMgaW4gdjM6DQo+PiAgICAgIC0gQ29ycmVjdGVkIHRoZSB0eXBvJ3MNCj4+ICAgICAgLSBV
cGRhdGVkIHRoZSBDQyBsaXN0IGFzIHN1Z2dlc3RlZC4NCj4+ICAgICAgLSBDb3JyZWN0ZWQgdGhl
IGZvcm1hdCBzcGVjaWZpZXJzIGluIHRoZSBsb2dzLg0KPj4NCj4+IGNoYW5nZXMgaW4gdjI6DQo+
PiAgICAgIC0gVXBkYXRlZCB0aGUgY29tbWl0IG1lc3NhZ2Ugd2l0aCB0ZXN0IHN0ZXBzIGFuZCBs
b2dzLg0KPj4gICAgICAtIEFkZGVkIGxvZ3MgdG8gaW5jbHVkZSB0aGUgdGltZW91dCBtZXNzYWdl
Lg0KPj4gICAgICAtIEZpeGVkIGEgcG90ZW50aWFsIHJhY2UgY29uZGl0aW9uIGR1cmluZyBzdXNw
ZW5kIGFuZCByZXN1bWUuDQo+Pg0KPj4gICBkcml2ZXJzL2JsdWV0b290aC9idGludGVsX3BjaWUu
YyB8IDY2DQo+KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+ICAgZHJpdmVycy9i
bHVldG9vdGgvYnRpbnRlbF9wY2llLmggfCAgNCArKw0KPj4gICAyIGZpbGVzIGNoYW5nZWQsIDcw
IGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ibHVldG9vdGgvYnRp
bnRlbF9wY2llLmMNCj4+IGIvZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbF9wY2llLmMNCj4+IGlu
ZGV4IDYzZWNhNTJjMGUwYi4uNDYyNzU0NGEyYTUyIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9i
bHVldG9vdGgvYnRpbnRlbF9wY2llLmMNCj4+ICsrKyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50
ZWxfcGNpZS5jDQo+PiBAQCAtMjc0LDYgKzI3NCwxMiBAQCBzdGF0aWMgaW50IGJ0aW50ZWxfcGNp
ZV9yZXNldF9idChzdHJ1Y3QNCj5idGludGVsX3BjaWVfZGF0YSAqZGF0YSkNCj4+ICAgCXJldHVy
biByZWcgPT0gMCA/IDAgOiAtRU5PREVWOw0KPj4gICB9DQo+Pg0KPj4gK3N0YXRpYyB2b2lkIGJ0
aW50ZWxfcGNpZV9zZXRfcGVyc2lzdGVuY2VfbW9kZShzdHJ1Y3QNCj4+ICtidGludGVsX3BjaWVf
ZGF0YSAqZGF0YSkgew0KPj4gKwlidGludGVsX3BjaWVfc2V0X3JlZ19iaXRzKGRhdGEsDQo+QlRJ
TlRFTF9QQ0lFX0NTUl9IV19CT09UX0NPTkZJRywNCj4+ICsNCj5CVElOVEVMX1BDSUVfQ1NSX0hX
X0JPT1RfQ09ORklHX0tFRVBfT04pOw0KPj4gK30NCj4+ICsNCj4+ICAgLyogVGhpcyBmdW5jdGlv
biBlbmFibGVzIEJUIGZ1bmN0aW9uIGJ5IHNldHRpbmcNCj5CVElOVEVMX1BDSUVfQ1NSX0ZVTkNf
Q1RSTF9NQUNfSU5JVCBiaXQgaW4NCj4+ICAgICogQlRJTlRFTF9QQ0lFX0NTUl9GVU5DX0NUUkxf
UkVHIHJlZ2lzdGVyIGFuZCB3YWl0IGZvciBNU0ktWCB3aXRoDQo+PiAgICAqIEJUSU5URUxfUENJ
RV9NU0lYX0hXX0lOVF9DQVVTRVNfR1AwLg0KPj4gQEAgLTI5OCw2ICszMDQsOCBAQCBzdGF0aWMg
aW50IGJ0aW50ZWxfcGNpZV9lbmFibGVfYnQoc3RydWN0DQo+YnRpbnRlbF9wY2llX2RhdGEgKmRh
dGEpDQo+PiAgIAkgKi8NCj4+ICAgCWRhdGEtPmJvb3Rfc3RhZ2VfY2FjaGUgPSAweDA7DQo+Pg0K
Pj4gKwlidGludGVsX3BjaWVfc2V0X3BlcnNpc3RlbmNlX21vZGUoZGF0YSk7DQo+PiArDQo+PiAg
IAkvKiBTZXQgTUFDX0lOSVQgYml0IHRvIHN0YXJ0IHByaW1hcnkgYm9vdGxvYWRlciAqLw0KPj4g
ICAJcmVnID0gYnRpbnRlbF9wY2llX3JkX3JlZzMyKGRhdGEsDQo+QlRJTlRFTF9QQ0lFX0NTUl9G
VU5DX0NUUkxfUkVHKTsNCj4+ICAgCXJlZyAmPSB+KEJUSU5URUxfUENJRV9DU1JfRlVOQ19DVFJM
X0ZVTkNfSU5JVCB8IEBAIC0xNjQ5LDExDQo+PiArMTY1Nyw2OSBAQCBzdGF0aWMgdm9pZCBidGlu
dGVsX3BjaWVfcmVtb3ZlKHN0cnVjdCBwY2lfZGV2ICpwZGV2KQ0KPj4gICAJcGNpX3NldF9kcnZk
YXRhKHBkZXYsIE5VTEwpOw0KPj4gICB9DQo+Pg0KPj4gK3N0YXRpYyBpbnQgYnRpbnRlbF9wY2ll
X3N1c3BlbmQoc3RydWN0IGRldmljZSAqZGV2KSB7DQo+PiArCXN0cnVjdCBidGludGVsX3BjaWVf
ZGF0YSAqZGF0YTsNCj4+ICsJaW50IGVycjsNCj4+ICsJc3RydWN0ICBwY2lfZGV2ICpwZGV2ID0g
dG9fcGNpX2RldihkZXYpOw0KPj4gKw0KPj4gKwlkYXRhID0gcGNpX2dldF9kcnZkYXRhKHBkZXYp
Ow0KPj4gKwlkYXRhLT5ncDBfcmVjZWl2ZWQgPSBmYWxzZTsNCj4+ICsJLyogVGhlIGltcGxlbWVu
dGF0aW9uIGlzIGFzIHBlciB0aGUgSW50ZWwgU0FTIGRvY3VtZW50Og0KPj4gKwkgKiBCVCBQbGF0
Zm9ybSBQb3dlciBNYW5hZ2VtZW50IFNBUyAtIElPU0YgYW5kIHRoZSBzcGVjaWZpYyBzZWN0aW9u
cw0KPmFyZQ0KPj4gKwkgKiAzLjEgRDBFeGl0IChEMyBFbnRyeSkgRmxvdy4NCj4+ICsJICovDQo+
PiArCWJ0aW50ZWxfcGNpZV93cl9zbGVlcF9jbnRybChkYXRhLCBCVElOVEVMX1BDSUVfU1RBVEVf
RDNfSE9UKTsNCj4+ICsJZXJyID0gd2FpdF9ldmVudF90aW1lb3V0KGRhdGEtPmdwMF93YWl0X3Es
IGRhdGEtPmdwMF9yZWNlaXZlZCwNCj4+ICsNCj5tc2Vjc190b19qaWZmaWVzKEJUSU5URUxfREVG
QVVMVF9JTlRSX1RJTUVPVVRfTVMpKTsNCj4+ICsJaWYgKCFlcnIpIHsNCj4+ICsJCWJ0X2Rldl9l
cnIoZGF0YS0+aGRldiwgImZhaWxlZCB0byByZWNlaXZlIGdwMCBpbnRlcnJ1cHQgZm9yDQo+c3Vz
cGVuZCBpbiAlZCBtc2VjcyIsDQo+PiArCQkJICAgQlRJTlRFTF9ERUZBVUxUX0lOVFJfVElNRU9V
VF9NUyk7DQo+PiArCQlyZXR1cm4gLUVCVVNZOw0KPj4gKwl9DQo+PiArCXJldHVybiAwOw0KPj4g
K30NCj4+ICsNCj4+ICtzdGF0aWMgaW50IGJ0aW50ZWxfcGNpZV9yZXN1bWUoc3RydWN0IGRldmlj
ZSAqZGV2KSB7DQo+PiArCXN0cnVjdCBidGludGVsX3BjaWVfZGF0YSAqZGF0YTsNCj4+ICsJc3Ry
dWN0ICBwY2lfZGV2ICpwZGV2ID0gdG9fcGNpX2RldihkZXYpOw0KPj4gKwlrdGltZV90IGNhbGx0
aW1lLCBkZWx0YSwgcmV0dGltZTsNCj4+ICsJdW5zaWduZWQgbG9uZyBsb25nIGR1cmF0aW9uOw0K
Pj4gKwlpbnQgZXJyOw0KPj4gKw0KPj4gKwlkYXRhID0gcGNpX2dldF9kcnZkYXRhKHBkZXYpOw0K
Pj4gKwlkYXRhLT5ncDBfcmVjZWl2ZWQgPSBmYWxzZTsNCj4+ICsJLyogVGhlIGltcGxlbWVudGF0
aW9uIGlzIGFzIHBlciB0aGUgSW50ZWwgU0FTIGRvY3VtZW50Og0KPj4gKwkgKiBCVCBQbGF0Zm9y
bSBQb3dlciBNYW5hZ2VtZW50IFNBUyAtIElPU0YgYW5kIHRoZSBzcGVjaWZpYyBzZWN0aW9ucw0K
PmFyZQ0KPj4gKwkgKiAzLjIgRDBFbnRyeSAoRDMgRXhpdCkgRmxvdw0KPg0KPk1pc3Npbmcgc3Bh
Y2UgaW4gRDAgRW50cnkuDQpBY2sNCj4NCj4+ICsJICovDQo+PiArCWNhbGx0aW1lID0ga3RpbWVf
Z2V0KCk7DQo+PiArCWJ0aW50ZWxfcGNpZV93cl9zbGVlcF9jbnRybChkYXRhLCBCVElOVEVMX1BD
SUVfU1RBVEVfRDApOw0KPj4gKwllcnIgPSB3YWl0X2V2ZW50X3RpbWVvdXQoZGF0YS0+Z3AwX3dh
aXRfcSwgZGF0YS0+Z3AwX3JlY2VpdmVkLA0KPj4gKw0KPm1zZWNzX3RvX2ppZmZpZXMoQlRJTlRF
TF9ERUZBVUxUX0lOVFJfVElNRU9VVF9NUykpOw0KPj4gKwlpZiAoIWVycikgew0KPj4gKwkJYnRf
ZGV2X2VycihkYXRhLT5oZGV2LCAiZmFpbGVkIHRvIHJlY2VpdmUgZ3AwIGludGVycnVwdCBmb3IN
Cj5yZXN1bWUgaW4gJWQgbXNlY3MiLA0KPj4gKwkJCSAgIEJUSU5URUxfREVGQVVMVF9JTlRSX1RJ
TUVPVVRfTVMpOw0KPj4gKwkJcmV0dXJuIC1FQlVTWTsNCj4+ICsJfQ0KPj4gKwlyZXR0aW1lID0g
a3RpbWVfZ2V0KCk7DQo+PiArCWRlbHRhID0ga3RpbWVfc3ViKHJldHRpbWUsIGNhbGx0aW1lKTsN
Cj4+ICsJZHVyYXRpb24gPSAodW5zaWduZWQgbG9uZyBsb25nKWt0aW1lX3RvX25zKGRlbHRhKSA+
PiAxMDsNCj4+ICsJYnRfZGV2X2luZm8oZGF0YS0+aGRldiwgIkJUIGRldmljZSByZXN1bWVkIHRv
IEQwIGluICVsbHUgdXNlY3MiLA0KPj4gK2R1cmF0aW9uKTsNCj4NCj5NYXliZSBhbHNvIGFkZCAq
ZnJvbSBEMyouDQpBY2sNCg0KPg0KPj4gKw0KPj4gKwlyZXR1cm4gMDsNCj4+ICt9DQo+PiArDQo+
PiArc3RhdGljIFNJTVBMRV9ERVZfUE1fT1BTKGJ0aW50ZWxfcGNpZV9wbV9vcHMsIGJ0aW50ZWxf
cGNpZV9zdXNwZW5kLA0KPj4gKwkJYnRpbnRlbF9wY2llX3Jlc3VtZSk7DQo+PiArDQo+PiAgIHN0
YXRpYyBzdHJ1Y3QgcGNpX2RyaXZlciBidGludGVsX3BjaWVfZHJpdmVyID0gew0KPj4gICAJLm5h
bWUgPSBLQlVJTERfTU9ETkFNRSwNCj4+ICAgCS5pZF90YWJsZSA9IGJ0aW50ZWxfcGNpZV90YWJs
ZSwNCj4+ICAgCS5wcm9iZSA9IGJ0aW50ZWxfcGNpZV9wcm9iZSwNCj4+ICAgCS5yZW1vdmUgPSBi
dGludGVsX3BjaWVfcmVtb3ZlLA0KPj4gKwkuZHJpdmVyLnBtID0gJmJ0aW50ZWxfcGNpZV9wbV9v
cHMsDQo+PiAgIH07DQo+PiAgIG1vZHVsZV9wY2lfZHJpdmVyKGJ0aW50ZWxfcGNpZV9kcml2ZXIp
Ow0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2JsdWV0b290aC9idGludGVsX3BjaWUuaA0K
Pj4gYi9kcml2ZXJzL2JsdWV0b290aC9idGludGVsX3BjaWUuaA0KPj4gaW5kZXggZjlhYWRhMDU0
M2M0Li4zOGQwYzhlYTJiNmYgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2JsdWV0b290aC9idGlu
dGVsX3BjaWUuaA0KPj4gKysrIGIvZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbF9wY2llLmgNCj4+
IEBAIC04LDYgKzgsNyBAQA0KPj4NCj4+ICAgLyogQ29udHJvbCBhbmQgU3RhdHVzIFJlZ2lzdGVy
KEJUSU5URUxfUENJRV9DU1IpICovDQo+PiAgICNkZWZpbmUgQlRJTlRFTF9QQ0lFX0NTUl9CQVNF
CQkJKDB4MDAwKQ0KPj4gKyNkZWZpbmUgQlRJTlRFTF9QQ0lFX0NTUl9IV19CT09UX0NPTkZJRw0K
PgkoQlRJTlRFTF9QQ0lFX0NTUl9CQVNFICsgMHgwMDApDQo+PiAgICNkZWZpbmUgQlRJTlRFTF9Q
Q0lFX0NTUl9GVU5DX0NUUkxfUkVHDQo+CShCVElOVEVMX1BDSUVfQ1NSX0JBU0UgKyAweDAyNCkN
Cj4+ICAgI2RlZmluZSBCVElOVEVMX1BDSUVfQ1NSX0hXX1JFVl9SRUcNCj4JKEJUSU5URUxfUENJ
RV9DU1JfQkFTRSArIDB4MDI4KQ0KPj4gICAjZGVmaW5lIEJUSU5URUxfUENJRV9DU1JfUkZfSURf
UkVHDQo+CShCVElOVEVMX1BDSUVfQ1NSX0JBU0UgKyAweDA5QykNCj4+IEBAIC00OCw2ICs0OSw5
IEBADQo+PiAgICNkZWZpbmUgQlRJTlRFTF9QQ0lFX0NTUl9NU0lYX0lWQVJfQkFTRQ0KPgkoQlRJ
TlRFTF9QQ0lFX0NTUl9NU0lYX0JBU0UgKyAweDA4ODApDQo+PiAgICNkZWZpbmUgQlRJTlRFTF9Q
Q0lFX0NTUl9NU0lYX0lWQVIoY2F1c2UpDQo+CShCVElOVEVMX1BDSUVfQ1NSX01TSVhfSVZBUl9C
QVNFICsgKGNhdXNlKSkNCj4+DQo+PiArLyogQ1NSIEhXIEJPT1QgQ09ORklHIFJlZ2lzdGVyICov
DQo+PiArI2RlZmluZSBCVElOVEVMX1BDSUVfQ1NSX0hXX0JPT1RfQ09ORklHX0tFRVBfT04NCj4J
KEJJVCgzMSkpDQo+PiArDQo+PiAgIC8qIENhdXNlcyBmb3IgdGhlIEZIIHJlZ2lzdGVyIGludGVy
cnVwdHMgKi8NCj4+ICAgZW51bSBtc2l4X2ZoX2ludF9jYXVzZXMgew0KPj4gICAJQlRJTlRFTF9Q
Q0lFX01TSVhfRkhfSU5UX0NBVVNFU18wCT0gQklUKDApLAkvKg0KPmNhdXNlIDAgKi8NCj4NCj4N
Cj5LaW5kIHJlZ2FyZHMsDQo+DQo+UGF1bA0KDQpUaGFua3MsDQpLaXJhbg0KDQo=

