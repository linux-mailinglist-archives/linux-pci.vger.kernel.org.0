Return-Path: <linux-pci+bounces-38182-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AA881BDD9CA
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 11:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 28D2B4FBEAD
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 09:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B6430AAD6;
	Wed, 15 Oct 2025 09:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J0rDQo7R"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5590307ADE;
	Wed, 15 Oct 2025 09:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760519336; cv=fail; b=ejVyXeR8qesFzdPlzIOB3wnKZIb452NmbZuhwohfHEnT1eKBm2wNd9NQsgCc+mcemoDD/L2bKKF2YWhIZfeTMcsY+lHP/T/r6iED1sYGvsET9E4mEvtuvS6WByqk4wyJB2MW5oTHmzfRFzcDbcVtmnLFvv9BTQJYJ1AiMcuCzIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760519336; c=relaxed/simple;
	bh=1ZtKEKCTtudwQU8F31PQCgR1lf4P9A+67ffdVD9NAD4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JqvKCiaZdlFz+aSkwvasJJfZGKSAs9O+HnzFi5sHmpKFGw4YxcwdSWb/hHtyxqFevzeBI14eO6YT8vKkX+W8mJQ3H9IDNS4TDTPzcxEPkGQAJO7GI+lyfuwWLjUFS/F8UsMt/vJjoA/YL2KCkAoaADdzcXtFr2JlJ+iYnnk4EMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J0rDQo7R; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760519334; x=1792055334;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1ZtKEKCTtudwQU8F31PQCgR1lf4P9A+67ffdVD9NAD4=;
  b=J0rDQo7Rj2jagWjRGZZ/elt6dAq1LfeW/UY6QT/BjmH4CZMikvIJdG4s
   N9cnmMe7yHMX6YaNd3glaS0XoTBZ5XgAxnE/U0Je7FNYyv9mtD/yxKnfW
   QP0G2h/a7GwAvuFY6D/KDXbM/RZksmBwXzQsuNGZjmqj55lM9un9VbadV
   o5VFXRqisBY4iQRG3FAeh3/Pv5GuotkxAnhC/9Zf82/GUdeSBdsdf4wBj
   POhcgjRDyyc602sPYvf9cnEk6K2K1zaY6xRJQmK1d+k55PvNOyXoOp3MK
   BhyI5aQ5y4j5sUVgouJvIzS8m0iIysENMIuqsTFPl5BpKIgq8arR9losS
   w==;
X-CSE-ConnectionGUID: 2LmzOGj5TKq4a3OIUJwS2Q==
X-CSE-MsgGUID: Y+bL18C6TAa0Vj6D/fAoSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="73366465"
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="73366465"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 02:08:53 -0700
X-CSE-ConnectionGUID: +PgJfpc/T9yB4ogAiBEXhA==
X-CSE-MsgGUID: aDRMwkc8St+tC8C5a2SXiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="181920210"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 02:08:54 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 02:08:53 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 15 Oct 2025 02:08:53 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.1) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 02:08:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ymFs6Sa99yS2NoH4D0C8mHS41gLqD7xIjE9HW5QR7/STRQHt34RJhRK8ips2JvNeOJEj/m77wZ1qJcE7MS6b1qn7HlSjgAoSBXBSlCE658eNN/3xvPPBFhmx+S/8SRnW+mLDyD3EgpzAmpLh2QMsU5DbtvXwARd3wEPHFZ2KZcyxW8ji8tVIgODO5/guAjQFfhl7A+V8odMokkZdITwIToRT/YYVwixhVqjdlamduIzxFy6B4bXRWXLfcVP2da7GYiyV2JmPS+8VVRiZDe0lXa091PMhCc8icBHxqTv5VPafWIzl2x4/CprH7gm3pyb7a1fmt1NtsztYP5HrWiJKUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ZtKEKCTtudwQU8F31PQCgR1lf4P9A+67ffdVD9NAD4=;
 b=LyArMI1TdjVyXgzigWXOjTClKaQWcaiXQgJ2FUlZedTIxhkkpHo81oOtuQSkagGXjG4eRPkfOnR0N7QLCKZLiKniLcM8YGIVv+7JR8GEv1/kemb2K0+TNJAcX4TugLVMaaaBqCN9L6mqcSSIY04kJoP0Q3slMCn7hbfQcyzgNgT7PIJAjlKpA9Bs7PeRbM/ZWo5/sIe/36K1HDdshE36nCrYZugn5ixZq/G7f2scjTCXh3GPs/p5WUUzFqk/bHDaU7exYh0RqPhh0BZaYhUUnYVsOX+JWdAzdWHUpst09v5re7D2bQ4ui6z4wcWSQ6lqB8T5NTcYtW+gKgKdjlHj2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB6207.namprd11.prod.outlook.com (2603:10b6:208:3c5::21)
 by CO1PR11MB4802.namprd11.prod.outlook.com (2603:10b6:303:94::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Wed, 15 Oct
 2025 09:08:51 +0000
Received: from MN0PR11MB6207.namprd11.prod.outlook.com
 ([fe80::b358:b7a0:d076:38d4]) by MN0PR11MB6207.namprd11.prod.outlook.com
 ([fe80::b358:b7a0:d076:38d4%5]) with mapi id 15.20.9228.010; Wed, 15 Oct 2025
 09:08:51 +0000
From: "Gupta, Anshuman" <anshuman.gupta@intel.com>
To: "Nilawar, Badal" <badal.nilawar@intel.com>, "Jadav, Raag"
	<raag.jadav@intel.com>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "rafael@kernel.org"
	<rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "ilpo.jarvinen@linux.intel.com"
	<ilpo.jarvinen@linux.intel.com>, "De Marchi, Lucas"
	<lucas.demarchi@intel.com>, "Vivi, Rodrigo" <rodrigo.vivi@intel.com>, "Gupta,
 Varun" <varun.gupta@intel.com>, "ville.syrjala@linux.intel.com"
	<ville.syrjala@linux.intel.com>, "Shankar, Uma" <uma.shankar@intel.com>,
	"Poosa, Karthik" <karthik.poosa@intel.com>
Subject: RE: [PATCH v5 08/12] drm/xe/vrsr: Refactor d3cold.allowed to a enum
Thread-Topic: [PATCH v5 08/12] drm/xe/vrsr: Refactor d3cold.allowed to a enum
Thread-Index: AQHcPaomtX3jFdbtIkGIf+T/x5+86bTC4woAgAAHFACAAABA0A==
Date: Wed, 15 Oct 2025 09:08:50 +0000
Message-ID: <MN0PR11MB620723916E16C64B0B20C26D95E8A@MN0PR11MB6207.namprd11.prod.outlook.com>
References: <20251015080710.1468409-1-badal.nilawar@intel.com>
 <20251015080710.1468409-9-badal.nilawar@intel.com>
 <aO9dsvZ-SmGlEh4T@black.igk.intel.com>
 <18f84e75-ea8b-4a6e-b1b6-1d07dcd4f778@intel.com>
In-Reply-To: <18f84e75-ea8b-4a6e-b1b6-1d07dcd4f778@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB6207:EE_|CO1PR11MB4802:EE_
x-ms-office365-filtering-correlation-id: 99c59f86-410a-488a-5d1e-08de0bca752c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|7053199007;
x-microsoft-antispam-message-info: =?utf-8?B?WlEvTzZha0V1YTBkVk8xRFNpY2tRby8zY2pvakY0MS95MEdVeEpIblhjL0hi?=
 =?utf-8?B?RlcybGJzYUl5L1pUb2pqa1VDWVVWbjI2SWY0NWJsNi85b1RTdlU5T2Z5WXBh?=
 =?utf-8?B?NnFwbEJFNU91Z3dJMUhvYzA3alMvN3FtQ2RBNU8xVGhkSGdTRmNrNE5ZRDdH?=
 =?utf-8?B?RlhldGN4bzVYZ291eFJkWGI5RnBFWTlidjNFc2lQcGxtVEIxSnZkZnA3S2ha?=
 =?utf-8?B?YjlCdHd6UjZOVmtzTzQvd1lLM09RR0hSOFNkMitGcXhLR2F0N056NUp1alI1?=
 =?utf-8?B?U3BPRFhOcmVlUXNueXREaVdZdTl5QmpvNDMrd1R4dnBrb2VON2VTOGpoRThS?=
 =?utf-8?B?cUN5S2crUWlTb3FHMnN1Slo2WVp1T3NqVUR2VTVYMzZpekpxd0lRQWU3VTRI?=
 =?utf-8?B?NllEaTNPaHB1cHcvcEJSK29aallYclMrQWszNzgyMmllUGtNQThRZTZiWWsv?=
 =?utf-8?B?RHNOWjV0aCtZUXV4MEdGTzNUVUt6TTdMUXVqeEZvQytiWW5UWDFaNkhHMjNz?=
 =?utf-8?B?ZWVVK3dIUEo4WDdwSzl3UDhUcnlhQy90RHhkNUgwcjdIaGcyTUQwaDd1Ukww?=
 =?utf-8?B?RzhoS0pBZldWTlF6UDR4Qjg1MW1yamh3emZ0YThpWTFrZFhza0x2SVhkU3N4?=
 =?utf-8?B?WDdTdGg5SU5BanJJQTAvdDgwckRpU3IyRmtob04wYUdOeXJIOUhneEdrYUZz?=
 =?utf-8?B?L3JnMEh0VjhTZmtPU05EYnFZNVVTV051OGNMOEVjaStVU3dhdW0zZE5YUmlX?=
 =?utf-8?B?K2RwdnowMEhPZ0J3TXdEK3Mvc09LN1lsdWlHcmJuR3BRNE9uQzRHNGNObUN4?=
 =?utf-8?B?QW5ncXo0TGtJSzE5N244dU9ZNVkzcXVFRFdDbTVwMDY0TTBQVW9ZWk02bHZZ?=
 =?utf-8?B?aHlhL0hhZkVNVmxYWGhaWlczL09xdkpXRS9Ga0RSRXNZRmpCMm13a3dRaGFw?=
 =?utf-8?B?dG5FZEtIeXV3WlRCam14NlhRU1ZaWko5elk1aEx6VTc4R0hwVVdRKytENUUz?=
 =?utf-8?B?clh2QmxkKzc2Tk51Z0F0VFcvN2pkTHFONmt5andHT3hxUGZOTnpZNUxUQ01m?=
 =?utf-8?B?cDdFQk52RGtRQnVHNkk4MDNIMTFmY1hWMlgyd0ljOUg1MkFwWEpobndWY0lZ?=
 =?utf-8?B?aUc0dlBlQjFDck50L29lUjBZODFtendIaFBTUEJHd2ZMT3RqeXpYWGthODlZ?=
 =?utf-8?B?ZXZvREZOWXE1dU9iNk5WMVFVMWZqMHRFTzNHbVB0QXdzMERjQWtmRUlHU1U3?=
 =?utf-8?B?TmNWalc4OEFFODVPWEJnNzVJY09EemVPNXJNZW10RzRVQ25QSHRONnpuS0VG?=
 =?utf-8?B?dEg1bmNINXZVQlRybFh4Y0w5T0YyS05tVFRnT1dTc1picXgvY0VLTlVqTXUy?=
 =?utf-8?B?MWJMZEJzVlBjdFo2OVVwenYxVGF2OHROb01xMFRFa21ra2pGSmFBRDZjQkE3?=
 =?utf-8?B?WEptMDFnQ3c5QVhtODQrUmR5bWN5WWdRcGd6WC92czBYTFNWUlVEWUM2d1cx?=
 =?utf-8?B?UHRMWkpnSGxNaG5ZK3VWWHQzbUVtVHFxZm54Nzd1SUFrY2R5azRZcGNPK0Rk?=
 =?utf-8?B?T05VQzVsQ2tCSlpycUdiRDlyNXBiWHF6eHVRMVlQQmk0ZXVFV2NDaitCTFYy?=
 =?utf-8?B?RS9VR3ZqbURuVWJDQmJvYm5DalNLMDE0STR0V1NLVU1ERURoUUpkVS9KSHI4?=
 =?utf-8?B?M1BWSXU1VFJ6M1A0WTlpaU1Id3RpNEpuZEs4cXp1ckFTRGxQeUNwakxwdmVr?=
 =?utf-8?B?bnlEbStCQ3FYK2hsOTRGaVJETm1EY0RoY3dZUm1yZTNmVW16L0NualhSQ0tY?=
 =?utf-8?B?MkRCTml4U1hablBhODdla21ncXVqZmJnL0lNb1BMM3JrNGIzQnV2Tk1kVGJh?=
 =?utf-8?B?SXRld1pVSlZrSWJJWVorZG1iWVFjUkpkYVQ3NnNvZkE3VVQzdXlZRWxZZGhm?=
 =?utf-8?B?RVFUU0trY0FoR2ZVeEc5V0kwZkE5UW85eC9xRU1YVFE0Wm9DOUVzZ2g2b3Rs?=
 =?utf-8?B?aE4weWo0UUFwdU55Yzc5OUw1RFVuUE96dmpteG1yWEdBbkZDSjA3dzJvMWJy?=
 =?utf-8?Q?eVniFb?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6207.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RkhWeXpLSTc5cGY5UWUrRzc5OFNJZFNVT3IwVkNNWi96eEhXRXlKNWxOT1Zv?=
 =?utf-8?B?WW9qYkQ4NU5XSWtoYVZGZkJneEE5UTdHUHhyL3M4MHhpemVyVjdVbEx0TzNI?=
 =?utf-8?B?ZlNLNjhnT2pmUFZqRWRLYkpiQjlRVms4OVMxaE90T1VMdXRTVDE3cXgrbVNp?=
 =?utf-8?B?TzFXL2pzQmJpSWszRzVESG83Y1c0NG5pQlJkVzdQM2VpTjNlS3RreU5Kb1Fm?=
 =?utf-8?B?Y2lSSGN4UUNTcDRlQkxMS21BRUl5NTJxaFdjOUxlMTdsQ3pMUHpBbVhxNmN2?=
 =?utf-8?B?UXNWckR5VkZlMTdDWUNnM29oOURJdUJPWjVyMVRrcXp1UU9sQi9Tb0c0cmNG?=
 =?utf-8?B?bUtUWUFWYjgzczROZDVFN2k3RjBvQkk3cVdTUzkvb0xKOEp1NUE1VWZsWmti?=
 =?utf-8?B?TzFiaWNTUXhGcXdUSmVRRE92bnhDaThLczdiSlJPSDN2T3R4TExmOTlWR1Fr?=
 =?utf-8?B?Q3Z5MzBSdDRvQjMzekVoVUo3eVBCR2VrVDB2bExSRktGYzhLSWNwK3kyY21j?=
 =?utf-8?B?OWJJL0dydnQ4TUY5QXhGai9xNFhtTlVuOXNvb09rSGdYNXRBL3Y1bzFNTURz?=
 =?utf-8?B?Wk1SOG9ocE9pTGphSlUyMk0zRjJ1SEdhbGo3NHBLbWNmTjRacllXek93Vm91?=
 =?utf-8?B?N0dDblh5ekNKL2g2UEtWajNDSnRtcHpxcW5Wbk1mVXExM01SL0ZVaWYzbkVL?=
 =?utf-8?B?WmRLMXB5cTF1eWZKZjJMcDhoUnlyWHpJVFI5YkFwMVpDaHhzSlVyTzFvR2dE?=
 =?utf-8?B?UjQ2ZkMzZ3cyZFRsK1JocDd0bnVjN2RUS3p4cmFkQkh6L1NzNk9wY1lMc3di?=
 =?utf-8?B?ejAxekF4R0tmam91VjJqTzBLYlVUT3J1V3FvanlYbkl6K1JWK3lMdW50ZURn?=
 =?utf-8?B?RUkwZnk3STFIckM2bjVQUlUyeXZ3cm5Fby9JYzh3RmJQWUNsY1RmNnNWSGVh?=
 =?utf-8?B?VG1tTVhkSTFGTzZtRzFyQytPOWxGdUdTQmdsVXpqUGYxN1FBSzk3WTVRUTla?=
 =?utf-8?B?Tk1wQURlSXU0dFpkVnlmcFZRTFFwWTJkNFdCb0hJaVNkMjJMemEzVzFITHZ6?=
 =?utf-8?B?SFNBQVBLQytCUU02UERnUC8vL0pNcW8yUnk0VWhJOUx4VHNLL2ZpcDBlc1NF?=
 =?utf-8?B?bTB0MEFiRWZCbGMrQ21qa05qVzJBamJISUw4SURMVkRQWW5UTy85RC9YK3Z2?=
 =?utf-8?B?ZmNZZjJ4RGFzbWxBQndxRnJRRi9sSUFxUmNaQzBUSWN6RmFjcGhDTWx6dXEr?=
 =?utf-8?B?Z0VmSHR2Z2EzTE5XOWZlNjd6SFl3b1BRaE41YkhMbjBiMkJSQStsZkREYVR4?=
 =?utf-8?B?ckUzamdiMEZVTWp4T2FBVTFzYnRVV3Uxb1BpdGtGdjBtNWpNd1VqWlhxWnow?=
 =?utf-8?B?bno0RkpiNjJReTZjVkJLUnErQ3VuREt5NWZnSjQ1bllGRTgvcENFRit3SlRT?=
 =?utf-8?B?QVJLNm1oU2tjSW42VmF6UFdUVjB0NUxIalZXNlVHbkt4SGxGTDd6NDlwTWZx?=
 =?utf-8?B?N1ZZdlRPbHh6SXNHWDc5dTF0YktpaDdBdlpybGVzUTRaa0NyMnIvcTZrZE9X?=
 =?utf-8?B?Tm40RU9qZVpLQ3RIbGdqd1dxSXJaVCtnUDlFKzljb21SN0RGNnpyWHZXVEZH?=
 =?utf-8?B?eVRHSE94eVJCVzBJWWJVM2d1eENSR0ZQKzcrZTdVTFhia3FNKzR2WHdpTVE0?=
 =?utf-8?B?OXFmUWJ4VWdDVHAwdDIwdkNIZ0JUdHVod0Z0TVRWL2Z2Nm01MXowTzBUYTBa?=
 =?utf-8?B?S1I1bTJaa2s5UnJGSjBtNnBuUlFlYWJaRVJsa0kzc1hzSTh4dnRFd0gzbGxl?=
 =?utf-8?B?SS9CdHQvR0lSZ3picFVTMlFvOWlOWG41UGFXZ25PaUVYL0JwaE5iOStvQU5R?=
 =?utf-8?B?ZTQrTGg5L1hJamNzdDVWRTBrODIzWEZUOEtBMjZLNnNLNlo3ZGlTWnNaTjRz?=
 =?utf-8?B?Z1kzalV6RHRJUVlHSXM0VEt5ckVnV2grdjVMUXRsSXhQemNSVWE3eHpVa1pp?=
 =?utf-8?B?b0tlTGM5dlRHNEZBMlFSTSt4UzNyRDh5aEpzQlRpM3dWNE5oTDlCSWRYUzRO?=
 =?utf-8?B?NzVrT3cyM1ZURXRYdEpQSGtyUUxiQjgrL3h3eisxajlLdnd4K0MwV2prWVRT?=
 =?utf-8?Q?swNVIRmfrE5Bomz1Rc9yN1HH/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6207.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99c59f86-410a-488a-5d1e-08de0bca752c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2025 09:08:51.0258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 976pDnsTKjdPfw83TuBrlvCDEK7wCBmzMBNfKpDKYHq4EhR6Xy6fcfc8TiHstiTC2qjegNUjL6gi9qA7f1mlqMHP84avBLQ6XO+DJpLyZkI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4802
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmlsYXdhciwgQmFkYWwg
PGJhZGFsLm5pbGF3YXJAaW50ZWwuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIE9jdG9iZXIgMTUs
IDIwMjUgMjozNSBQTQ0KPiBUbzogSmFkYXYsIFJhYWcgPHJhYWcuamFkYXZAaW50ZWwuY29tPg0K
PiBDYzogaW50ZWwteGVAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBsaW51eC1hY3BpQHZnZXIua2Vy
bmVsLm9yZzsgbGludXgtDQo+IHBjaUB2Z2VyLmtlcm5lbC5vcmc7IEd1cHRhLCBBbnNodW1hbiA8
YW5zaHVtYW4uZ3VwdGFAaW50ZWwuY29tPjsNCj4gcmFmYWVsQGtlcm5lbC5vcmc7IGxlbmJAa2Vy
bmVsLm9yZzsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsNCj4gaWxwby5qYXJ2aW5lbkBsaW51eC5pbnRl
bC5jb207IERlIE1hcmNoaSwgTHVjYXMgPGx1Y2FzLmRlbWFyY2hpQGludGVsLmNvbT47DQo+IFZp
dmksIFJvZHJpZ28gPHJvZHJpZ28udml2aUBpbnRlbC5jb20+OyBHdXB0YSwgVmFydW4NCj4gPHZh
cnVuLmd1cHRhQGludGVsLmNvbT47IHZpbGxlLnN5cmphbGFAbGludXguaW50ZWwuY29tOyBTaGFu
a2FyLCBVbWENCj4gPHVtYS5zaGFua2FyQGludGVsLmNvbT47IFBvb3NhLCBLYXJ0aGlrIDxrYXJ0
aGlrLnBvb3NhQGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NSAwOC8xMl0gZHJt
L3hlL3Zyc3I6IFJlZmFjdG9yIGQzY29sZC5hbGxvd2VkIHRvIGEgZW51bQ0KPiANCj4gDQo+IE9u
IDE1LTEwLTIwMjUgMTQ6MDksIFJhYWcgSmFkYXYgd3JvdGU6DQo+ID4gT24gV2VkLCBPY3QgMTUs
IDIwMjUgYXQgMDE6Mzc6MDZQTSArMDUzMCwgQmFkYWwgTmlsYXdhciB3cm90ZToNCj4gPj4gRnJv
bTogQW5zaHVtYW4gR3VwdGEgPGFuc2h1bWFuLmd1cHRhQGludGVsLmNvbT4NCj4gPj4NCj4gPj4g
QWRkIHhlX2QzX3N0YXRlIGVudW0gdG8gYWRkIHN1cHBvcnQgZm9yIFZSQU0gU2VsZiBSZWZyZXNo
IGQzY29sZA0KPiA+PiBzdGF0ZS4NCj4gPj4NCj4gPj4gU2lnbmVkLW9mZi1ieTogQW5zaHVtYW4g
R3VwdGEgPGFuc2h1bWFuLmd1cHRhQGludGVsLmNvbT4NCj4gPj4gUmV2aWV3ZWQtYnk6IEthcnRo
aWsgUG9vc2EgPGthcnRoaWsucG9vc2FAaW50ZWwuY29tPg0KPiA+IC4uLg0KPiA+DQo+ID4+IEBA
IC03ODcsNyArNzg3LDggQEAgaW50IHhlX3BtX3J1bnRpbWVfcmVzdW1lKHN0cnVjdCB4ZV9kZXZp
Y2UgKnhlKQ0KPiA+PiAgIAkJCWdvdG8gb3V0Ow0KPiA+PiAgIAl9DQo+ID4+DQo+ID4+IC0JeGVf
aTJjX3BtX3Jlc3VtZSh4ZSwgeGUtPmQzY29sZC5hbGxvd2VkKTsNCj4gPj4gKwlpZiAoeGUtPmQz
Y29sZC50YXJnZXRfc3RhdGUgIT0gWEVfRDNIT1QpDQo+ID4+ICsJCXhlX2kyY19wbV9yZXN1bWUo
eGUsIHRydWUpOw0KPiA+IERvZXMgdGhpcyByZXF1aXJlIGFuIGlmIGNvbmRpdGlvbj8NCj4gDQo+
IEFkZGVkIGl0IHRvIGhhbmRsZSBEM2NvbGQgYW5kIEQzY29sZC1WUlNSIHRhcmdldCBzdGF0ZS4g
QW0gSSBtaXNzaW5nDQo+IHNvbWV0aGluZz8NCkRvIHdlIGhhdmUgc2VwYXJhdGUgZnVuY3Rpb24g
dG8gcmVzdW1lIGkyYyBkdXJpbmcgZDNob3QgPyANCldoYXQgd2lsbCB0aGUgZGVmYXVsdCBzdGF0
ZSBvZiBpMmMgZHVyaW5nIGQzaG90IHJlc3VtZS4NClRoYW5rcywNCkFuc2h1bWFuDQo+IA0KPiBU
aGFua3MsDQo+IEJhZGFsDQo+IA0KPiA+DQo+ID4gUmFhZw0K

