Return-Path: <linux-pci+bounces-25291-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B4AA7BCFE
	for <lists+linux-pci@lfdr.de>; Fri,  4 Apr 2025 14:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8598189C63B
	for <lists+linux-pci@lfdr.de>; Fri,  4 Apr 2025 12:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B331EB5F1;
	Fri,  4 Apr 2025 12:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M5q9yJJG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201411EA7F9;
	Fri,  4 Apr 2025 12:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743771220; cv=fail; b=gqtJerW9XylmcWR0JQ6PAksPJc7/e0md9kUvr02YNMUU9OUbqV9RfQf4BQGOnKLpsSssbEJ74JDL5SEBzMonFr36kDN6tZrcr/lyaBnYbeuGsJOFDaxunnEmtpIA4oz5OJwej4rTYrJrFHvNSCUmVpf3Wn0noRW1RUuq0EOWhII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743771220; c=relaxed/simple;
	bh=YdFHSpY05ucSPL9LllVZblOI0yEW1rMIWHzdP2lgGgI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Cgw69m1CM5G1lrnqfKgKwX0tG8WZ3X6RBS9qHvhYYdjLk32RWfGUHPf/KBTtW32DqqFfq1aR2RxdlgciFF1+W6SG/GFjthILdj0jAIKVShjZaak+nU5/yBfA9mvrZNAB7t+rrAd/Egj47QRwjaaMWDK/UxdE4YhrmpLVDkH/Hzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M5q9yJJG; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743771218; x=1775307218;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YdFHSpY05ucSPL9LllVZblOI0yEW1rMIWHzdP2lgGgI=;
  b=M5q9yJJGXv2r6dOONRE1TrSCpbq1UCrDOAFFXrgGgJh74IIfMv4+mn54
   w+QHotLghVLi0zdLWNNvVcFygYTpVQh0UxUKINhZsSq/sGjGzrOQg6rr+
   mBfUODYDxzDMePLOKmausqFoCeOWD3zmMsFaRmqzgmppH4Nw8ySCcjB4O
   rLoqts93ISgec0KL4GuixstQgwSDTp9OMAW7egovJnlT3KMFextz0Hcuf
   buoH97lQ8wO/K+yA04SsUxIHTkIJqLhzSAweLaIWQSleD/pFspPcXbMK3
   VNnL4ZGcy4voFu8m2jyhSo5rpmohg/qyIihTG+JVTen2MOJGINpEUxbZY
   A==;
X-CSE-ConnectionGUID: vQUVm4/SSZW2XaA4iworGQ==
X-CSE-MsgGUID: 9XBkpPESQQqUqEepnsJwng==
X-IronPort-AV: E=McAfee;i="6700,10204,11393"; a="55873437"
X-IronPort-AV: E=Sophos;i="6.15,188,1739865600"; 
   d="scan'208";a="55873437"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 05:53:37 -0700
X-CSE-ConnectionGUID: RJ+Ww/1MQKqYqS6mU8xjKw==
X-CSE-MsgGUID: VWgpX+xRQPqku1KpIOWsvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,188,1739865600"; 
   d="scan'208";a="132158830"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Apr 2025 05:53:37 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 4 Apr 2025 05:53:36 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 4 Apr 2025 05:53:36 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 4 Apr 2025 05:53:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xyHsgDTYd6szvHV+0J38ACFY4cjt6QB8C4U5+2tZxHtYK/WJ0Y/8HJKxpn+IfzpQn81BjDwIbRTvOMmmQnjiZsuUCFFS+EDzuOi8hcHNx0d6j+2c6mVFHrPmwIXL0rH/mwTaGTgyxYiEFOD+l8K2TrvcHZg6Mddm5EpgIsSJoybGIQanP9f3NcoKJlH8AgMjZrhvQEiY3lpJC54AAAXBai60MwFiwxXsPEOjwhLE0jd6qwHI/CZ5PVe5re/6U4InX7YjyJCOFeY+OuyUi0wdpa4I7qQKjhFo4rykoN17g+VhdVlcUA7wHkwp9z3t4b40cdUnvoSwzA86Gm2amdARSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YdFHSpY05ucSPL9LllVZblOI0yEW1rMIWHzdP2lgGgI=;
 b=bfcw0FJ6qn+Uh+cZgd9yfL1GHT6AtkTJYI6xpvhu1qBCx2FC9wvzXugsgeddq8xfJ4ChOIiucafgl7O9Z3+7Pn5IMcxw4ALqPFU0Tll2V0QlRNqOd4y7wkzCod6d7R/eFUuVdO1lPzbW7gyjEkbgFZNAm8gl2PuqdEb47nO6aRoJ+qQFUPZLhJrShOhls1u02y8DZ/njtcbYxJ6s/NXYxN4qCSD1RgqEAoexZMDiOqlg17s6EXeo70RYqSXSNovJmNsTiq0OpIvWihhFYjf12AnfyKMu/fgzGJDQ2QGDpyei6Wwiq0hwhlGU9hvdPicLzLu7oXHlmxIyHgNc0C+SAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6211.namprd11.prod.outlook.com (2603:10b6:930:25::6)
 by DS7PR11MB6222.namprd11.prod.outlook.com (2603:10b6:8:99::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.47; Fri, 4 Apr
 2025 12:53:34 +0000
Received: from CY5PR11MB6211.namprd11.prod.outlook.com
 ([fe80::df5a:a32c:8904:15f1]) by CY5PR11MB6211.namprd11.prod.outlook.com
 ([fe80::df5a:a32c:8904:15f1%6]) with mapi id 15.20.8606.027; Fri, 4 Apr 2025
 12:53:34 +0000
From: "Gupta, Anshuman" <anshuman.gupta@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Bjorn Helgaas <helgaas@kernel.org>, "intel-xe@lists.freedesktop.org"
	<intel-xe@lists.freedesktop.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "ilpo.jarvinen@linux.intel.com"
	<ilpo.jarvinen@linux.intel.com>, "De Marchi, Lucas"
	<lucas.demarchi@intel.com>, "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
	"Nilawar, Badal" <badal.nilawar@intel.com>, "Gupta, Varun"
	<varun.gupta@intel.com>, "ville.syrjala@linux.intel.com"
	<ville.syrjala@linux.intel.com>, "Shankar, Uma" <uma.shankar@intel.com>
Subject: RE: [PATCH 03/12] PCI/ACPI: Add aux power grant notifier
Thread-Topic: [PATCH 03/12] PCI/ACPI: Add aux power grant notifier
Thread-Index: AQHboxvW09BLofS39EOnp6kodPmC7rOPPvGAgAD+SACAAZJksIAAJF+AgAAErvCAAEnKAIABNnaA
Date: Fri, 4 Apr 2025 12:53:33 +0000
Message-ID: <CY5PR11MB621174B9AF1B5C6EA4FE27F095A92@CY5PR11MB6211.namprd11.prod.outlook.com>
References: <20250401153225.96379-4-anshuman.gupta@intel.com>
 <20250401201349.GA1676401@bhelgaas>
 <CAJZ5v0irNFX6dFrStinNXamrhP143=yjjfx4iK0pY+-dTEkviw@mail.gmail.com>
 <CY5PR11MB6211021207DE5ECAA43BF26595AE2@CY5PR11MB6211.namprd11.prod.outlook.com>
 <CAJZ5v0inCpM2UhzZ_pD52S0Hf8aaEMa40CyE-dwzVmO1n3PMwA@mail.gmail.com>
 <MN0PR11MB6207F55ABAA2187609BB872695AE2@MN0PR11MB6207.namprd11.prod.outlook.com>
 <CAJZ5v0gKBYa_N-dA1JwF0yVbc6XSmQEy1LpVytDM7uc9kbZ8fA@mail.gmail.com>
In-Reply-To: <CAJZ5v0gKBYa_N-dA1JwF0yVbc6XSmQEy1LpVytDM7uc9kbZ8fA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6211:EE_|DS7PR11MB6222:EE_
x-ms-office365-filtering-correlation-id: b93089df-f2ed-4b58-5190-08dd7377b586
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?R0NVdzY0UDBDVmxHTkU5dForWGNVa1JXMTRHTFJ5d1ZMM2lVcG5QeFZjMEhJ?=
 =?utf-8?B?dy9yU3BEdnRLWUJ5RTVGY0pYODN3WEtNbXFtUW9vKzBVeDY4Tjl5eERuWTBo?=
 =?utf-8?B?enNVNVdRb1lYa29JRHMrOFQvcWVjQnhoeTdOemxvaEs1eGMzZ3p2NkYyM0lG?=
 =?utf-8?B?bFZzUEJXSTkvSlk0VGpaUEkxZ0RuZWM3UEkzSkdxbXAxQzFydEpYK1cwc2VL?=
 =?utf-8?B?SjQreFAwZm1JejNGdnI0a3c5Z0RwYWNTNE42bVJYcU9xY1VQb0RLcGF0RDh3?=
 =?utf-8?B?cTFwbjZ3ZnFFNmlkSHRmc05BVGo0cFphNjFlTUFKN3YxdzF5SkQxMUNJekxT?=
 =?utf-8?B?VUc3aXUxaldOOHFYc3I2V1IyRWhxUkR0M0Z5N2V3TlBjVVQwak80bUtpL0Uv?=
 =?utf-8?B?T20ycjlYdlpZc0dZMmdaVnRobEJZOVozaVJ6VlgzaHhUUGlUVDFJNXErZFRq?=
 =?utf-8?B?WnFPbmhzcjJLV0d4NEV1NktWWVBTS1U4VzFZZXEyRkU5L2wwN0lxR1RGVGpk?=
 =?utf-8?B?NFZQbU9uR1lPbUszOUtaMGdmd2lxZWgvdFdxWnhiM2FqQ0RRWk4xOUhHck1j?=
 =?utf-8?B?ZkpLa0lCdFc5V09WTzl0VGtqdHRVUTZ0OVY2RXBPTFRNNytUT05pZkp1Qitw?=
 =?utf-8?B?d0Rtc2RLdkNaN1BlL1dPbmpPY0lMQkp2MXB1c0tJMUp5dVErVHpTdUMrU1Nq?=
 =?utf-8?B?dktENjJPVjNVZzFhMEFiZXNsaEloU1lhT1NtMFFZazduL253Z21vQmFPa2Qw?=
 =?utf-8?B?SVg3Q2NvVklyMnlNL2ppbk14U04wUlBNajFKMnNQdERZMkFob2pIekV4akV2?=
 =?utf-8?B?Vy9JTERNTmgxTitvWDY0RlpZK1pabDF3Wk9LS0MvWUhZbWt5Z2wrK0JmcWlj?=
 =?utf-8?B?WUtHV3h3L01hR0VyWTNMcmIrbkcvM1kyYTNNbS9WVHNmVDIzVk1FbEIvRDRl?=
 =?utf-8?B?cTVEUGZUR3J6by8vdGNlcXJBZWRFSEk3QzBBSlJ1aFZRQkI0YVNYSW8ySWsv?=
 =?utf-8?B?VVF5aDZaVi9KSWNrZGxDa2lFc29jc2plQzVKb0dhMzJXb3lDQ3JsenE4Qkp3?=
 =?utf-8?B?UjBneUNjUlVSVmlFM0htejhvN1NQUFlFdW1tVTlrVDVvd0lMTS90TGVhREJ0?=
 =?utf-8?B?Z0NHby9ZUGtUYTFOclNmd2VWN0VWMVBiQnNCZTVtWlFJOURTUWRweEVVY0JL?=
 =?utf-8?B?d3h1NVJuWWVSWFhIU0VXQmh2UEJRNnVSclgrMFlCdWU2QWloNDFnVWo0Q2JM?=
 =?utf-8?B?bTNrWU9JUnMrNHJUUjdQMXNtb3dVdUdiSDBkd2xoNHZqWEp5eDRiTnFYd0JR?=
 =?utf-8?B?aVhJbVpqYUVvVEhTeEZSc01VRjFJejY0M2tPbWIzd3l3OWxQZG5qZGYwajdo?=
 =?utf-8?B?NmZLSjFjVFFlbkZOUnhDNHp2OEpUNWQ5aVdoR21yazcvY1VybVRmTVk1WktE?=
 =?utf-8?B?cW5WTWx6a0VQZWp5cVB6QnB0Rk5CVGw3VGtvYjhGS1BCU05oRWNzaXBXcW00?=
 =?utf-8?B?ZjVqSlFVWkxxWExLZ3FCVGhmWENUMzhzQ05GNlVuQzFNNURDTTVaRTR1a1cx?=
 =?utf-8?B?RjVnQVdDK3h6WE9ydlpManlKK3R0N0U0UzBlWTFDTmN6dEsrb3dHc3BJRWhu?=
 =?utf-8?B?Nk4xUkhJWC9GVGN4WDRxSWpBNUxpUEthdzRKamh1S2wzVTJaaHp3V3Y5djBi?=
 =?utf-8?B?RDBDU0VvMlVsY01VNTRjK2k4TVRQbGpLNGt4UE85aEFwemtEai9RS0ZiYk50?=
 =?utf-8?B?RDVuZ3ZjQVdyMVB3TlpYUWRHQ2RSb1VTSTBvdWR5MFFIeWpYNjMzbTBjYkdx?=
 =?utf-8?B?ZUYvN2Q2SWljcTFrU1AxNWtXdDFQWDJwblQ3WWRqOTRoZTdDV1gvTHZFM00v?=
 =?utf-8?B?aXlEMFM1SlhuQ24vYUpoamdLOVdBMmNGRjVWNk1SZ3NOajlkR1luK0t3eXEz?=
 =?utf-8?Q?xALdRTfw5U8ZX8FBl6lo2qh5Z0PQiFAp?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6211.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UkdRWEt2UDA2STIyVHNhNHpoN3lFVksyVGYwWENVSFpZNVVnVXVILzYrRnBt?=
 =?utf-8?B?ZHdzb2NMZy9yZDdGdUNWcXlpWFpNNDVhcUJrd3FsZ3o1TURLMGtKRE52VTc0?=
 =?utf-8?B?aTZvUnY0c2ZrV1ZrcGpKMHpydXVlNVRrT1Avc0ZGNFVSdnQwUjd5WVE1cnV1?=
 =?utf-8?B?WXh3dGk5Nmx6cENKT2JPQ3I4RVZkMW85ZGZSblRLTTNIbS9jQWt6d1pDSDBK?=
 =?utf-8?B?UHpCbkN2RnR5bVZTNTNsVUFWR0VGUkFka0JOVzdIdVZNMTNqeDRYT0ZWWUsx?=
 =?utf-8?B?V1N1VnRRY2dJNytBRWVlNTJ4OCtqVldJenRldUZJTHVrejJGN1pNMUx4K3FZ?=
 =?utf-8?B?MlZWc2RCaVE2RkFGNXl6OXprK3ZCNVBzSHVUWS9aOTFtd1dQbnFoa1d3aVQz?=
 =?utf-8?B?YkFQcE8yS0tmYk9oWVlPdThKc1BVVEVMUG5XUkdHK3BEM3EwVGFzZXpCK3lX?=
 =?utf-8?B?MEhOZEIyWFlTVHVGTDdDM0lXQlBVNUsvemZBR2IyQm5IbE0vZXc1Y1VLV3Q2?=
 =?utf-8?B?Z09ESGUxaXNtUDBTYjZQbG85NS9ra0JJMllUSnhESGd5djJkMmw4YmlENDda?=
 =?utf-8?B?dWpXTEZMYVpkK0x1NzZBQk44OWxQRkgwOTF1R2xBNS8yTFdSeXJVZVhDUFh4?=
 =?utf-8?B?M3NRbm9wcU5LNUIrN0huNFpiaG5LaWtwMm5PK1RCSCtwTlJabWMveko4Z1kv?=
 =?utf-8?B?Qlg1ZXkzWWp1ZndQcG5GT3hnQVA1WWc1UWJOK0VGUHBxMWRhRUlycFd2NG9q?=
 =?utf-8?B?dFgvVkRybmR5Y0xWeGcxWnptVWt2Z3JULzhTeHNFWitOK0xWanJXYTYvWSt0?=
 =?utf-8?B?RW5UczRZNHJ5YTJaNDRlMzg0bDd3QWpJL2l2dmZnKzVRUDJ1U3FBZXV4ZVgz?=
 =?utf-8?B?eHRIdS9Fd3dqYUg2MXFiZG5qTVlndWYxeE5wSDlnQjNkTzV2VXVGU3REUWV2?=
 =?utf-8?B?MjBCZXVFN05XdWZPNjYwc0RNZmxDOCtCZGlObDM3U0RRY1JXOEM0RkRyOUNJ?=
 =?utf-8?B?NHRxRFNkdlJnVlR0a0RvWnZoamlLSUFpN2Jiazh2YUFMV2dNbzF4REV0dkFO?=
 =?utf-8?B?KzZvV3I0WUVSR1hyNGVhRE0wQnJtdDdqRDRUOG5TWWJOQXlYSm5GQ0NoSFN2?=
 =?utf-8?B?M0dMUUJDRExoQ3pmZHZ0MzlyZnFGVWVOY2t4SHVBdXRrbUNrYVp0MkRiSzE5?=
 =?utf-8?B?N1ptTGVCeU5LendWMDRYZ3owckpoS0pNWnhRQmhFMXBJM1k4K3c0ZHRkQnIy?=
 =?utf-8?B?UnBWNDlxVmZxNnJMaG0vbDZiNG96eS9Pb0g3c1pWa3E5Vk1Za3pQWlZieFBq?=
 =?utf-8?B?eWVCQnZOcGxLa1VvdGhRbWliWVZOTkl2SlF2SDBQRTd4RGh2STF1YnFFcmlD?=
 =?utf-8?B?T3BLK0RqdjRQcU50VzBRSTFhMXRhYk9QZnBJMk5oOC9zYk9Kdlg3RDBTK2k5?=
 =?utf-8?B?NFZXazVGQ3ZGenlPdVJvNUJ2OGJZRG9VRHo4RmNlVUU4MmQyVW85cUdRT3lB?=
 =?utf-8?B?TW9DZHIxTUxpZEZVdUFLMnMvL0pnUE9YWmwrNk9MbGR0ZDYxMFlCenF1bnp6?=
 =?utf-8?B?Tm1uaHBuM081OGdhZ21nZHBXcWNZdWlsMVFYa1EwaDhUNDgzWExoZkk3VWFp?=
 =?utf-8?B?bzd6NWU4bFRrV1h6ZFhRL1dEQzVIYnhRSWZWb2NpcWVRcmY2SldzbGtJeHox?=
 =?utf-8?B?R3d1QmdvUklPNWRuUkc3ZWJKcERLbVVRSDkyRzRzWncrMTNTM3JwWlhJSVpy?=
 =?utf-8?B?dGlnMTF5VVpTZHo3K1lnblp1SFhBdk9oNDNmdXdKTmxKMytwOWdKcXAxU1ZS?=
 =?utf-8?B?ZVIvNmtxNWJEYzAvUFdFcjRtRW9WMXJ6NkE1VlNxYjZjMUU1VzZibnY1TlNy?=
 =?utf-8?B?eXpEdjhVOTcyTDB3WUtGbXNraUd0Z3Rhd2FVVGo2aFIvK1J4WWx2Z0ZMQlZr?=
 =?utf-8?B?ZXdLTWZoMlhiUGswRUhlVDVaeVc1eitNK1lCajFzZDlwbkpiUDJYNjhLeUZh?=
 =?utf-8?B?ZG5FVVlzZU9zQmhyUFFEWGhXRXZXM0lvamwwdlVBRWpSUk9PZVVUQ1pUVHRw?=
 =?utf-8?B?elA2TngrZS9KRkF5blZqcTBTU3hUMVFUWFVqNFhVL1BLUDJwUi85T2g1eWlQ?=
 =?utf-8?Q?KoR3EGuLW9ZtbSYVhAPvnbd8e?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6211.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b93089df-f2ed-4b58-5190-08dd7377b586
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2025 12:53:33.9943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0RHkTI7QHKB5omPFDSbCd94zmnomQ4XcD8DnfS6OlgoTvJTlXcFy1Qi/YDbBFu8zSbwRVjXflCgjoAbpenAHK69CyUem7490Tsl52TGzuN4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6222
X-OriginatorOrg: intel.com

L3NuaXANCj4gPiA+DQo+ID4gPiBFeGFjdGx5IGxpa2UgSSBzYWlkOiBJZiB5b3Ugb25seSBhbGxv
dyBvbmUgZHJpdmVyIHRvIHVzZSB0aGUgX0RTTSB0bw0KPiA+ID4gcmVxdWVzdCB0aGUgQXV4IHBv
d2VyIGZyb20gYSBnaXZlbiBSb290IFBvcnQsIGl0IHdpbGwgaGF2ZSBhbGwgb2YNCj4gPiA+IHRo
ZSBpbmZvcm1hdGlvbiBhbmQgZG9lcyBub3QgbmVlZCB0byBiZSBub3RpZmllZCBhYm91dCBhbnkg
Y2hhbmdlcy4NCj4gPiA+IFNpbmNlIG5vIG9uZSBlbHNlIGlzIGFsbG93ZWQgdG8gdXNlIHRoaXMg
aW50ZXJmYWNlIGZvciB0aGF0IFJvb3QNCj4gPiA+IFBvcnQsIG5vIG9uZSBlbHNlIHdpbGwgbmVl
ZCBhIG5vdGlmaWVyIGVpdGhlci4gIEZvciB0aGlzIHRvIHdvcmssDQo+ID4gPiB5b3UgbmVlZCBz
b21lIG1lY2hhbmlzbSBhbGxvd2luZyBkcml2ZXJzIHRvIGNsYWltIHRoZSBpbnRlcmZhY2Ugc28N
Cj4gPiA+IG5vIG9uZSBlbHNlIGNhbiB1c2UgaXQgKG9uIGEgcGVyIFJvb3QgUG9ydCBiYXNpcykg
d2hpY2ggaXMgY3VycmVudGx5IG1pc3NpbmcNCj4gQUZBSUNTLg0KPiA+DQo+ID4gSU1ITyBzdWNo
IGtpbmQgb2YgbWVjaGFuaXNtIHdpbGwgcmVxdWlyZSB0byBhZGQgUm9vdCBQb3J0IHNwZWNpZmlj
DQo+ID4gZGF0YSBzdHJ1Y3R1cmUgdG8gY2xhaW0gdGhlIGludGVyZmFjZS4gQnV0IHJlYWwgcHJv
YmxlbSBpcyB0aGUgY3JpdGVyaWEgIHRvIGNsYWltDQo+IHRoZSBpbnRlcmZhY2UuDQo+ID4gSXMg
Zmlyc3QgUENJZSBOb24tQnJpZGdlIEVuZHBvaW50IEZ1bmN0aW9uIDAgZHJpdmVyIGNhbiBiZSBj
cml0ZXJpYQ0KPiA+IHRvIGNsYWltIHRoZSBJbnRlcmZhY2UuIE9yIGZpcnN0IGNvbWUgYW5kIGZp
cnN0IHNlcnZlIGFwcHJvYWNoID8NCj4gDQo+IElNViwgdGhlIGZpcnN0IFBDSWUgTm9uLUJyaWRn
ZSBFbmRwb2ludCBGdW5jdGlvbiAwIGRyaXZlciBhcHByb2FjaCB3b3VsZCBiZQ0KPiBzb3J0IG9m
IGZyYWdpbGUgYW5kIGN1bWJlcnNvbWUgdG8gZW5mb3JjZS4NCj4gDQo+IEZpcnN0IGNvbWUsIGZp
cnN0IHNlcnZlIGlzIG11Y2ggc2ltcGxlciBhbmQgc2hvdWxkIGJlIHN1ZmZpY2llbnQgZm9yIG5v
dyBBRkFJQ1MuDQpXZSBhcmUgZW5hYmxpbmcgVlJTUiBvbmx5IGZvciBkZWZhdWx0IHZnYSBib290
IGRldmljZS4NCkFzIGl0IG5lZWRlZCBvbmx5IEdQVSBkcml2aW5nIHRoZSBkaXNwbGF5IGZvciBi
ZXR0ZXIgdXNlciBleHBlcmllbmNlLg0KQ2FuIHdlIHVzZSBzYW1lIGxvZ2ljIHZnYV9kZWZhdWx0
X2RldmljZSgpIHRvIGNsYWltIHRoZSBpbnRlcmZhY2UgdW5kZXIgcm9vdCBwb3J0Lg0KVGhhdCB3
aWxsIHNpbXBsaWZ5IHRoZSBjcml0ZXJpYSB0byBjbGFpbSB0aGUgaW50ZXJmYWNlLg0KPiANCj4g
PiA+IEkgdGhpbmsgdGhhdCB0aGlzIGlzIHRoZSBvcHRpb24geW91IHdhbnQgdG8gcHVyc3VlLg0K
PiA+ID4NCj4gPiBXZSB3aWxsIHByZWZlciB0byBzdGljayB3aXRoIHRoaXMgb3B0aW9uLCBpZiBp
dCBjYW4gZ3VhcmFudHkgdGhhdA0KPiA+IFhlS01EIHdpbGwgdGhlIG9ubHkgZHJpdmVyIGFsbG93
ZWQgdG8gcmVxdWVzdCBBdXggcG93ZXIgdG8gZW5hYmxlIFZSU1IuDQo+ID4NCj4gPiA+IE9UT0gs
IGlmIHlvdSB3YW50IHRvIGFsbG93IG11bHRpcGxlIGRyaXZlcnMgdG8gdXNlIHRoaXMgaW50ZXJm
YWNlDQo+ID4gPiBmb3IgdGhlIHNhbWUgUm9vdCBQb3J0LCB5b3UgbmVlZCB0byBhZ2dyZWdhdGUg
dGhlIHJlcXVlc3RzIChhcw0KPiA+ID4gcmVxdWlyZWQgYnkgdGhlIHNwZWMgSUlVQykgaW4gdGhl
IGZpcnN0IHBsYWNlLCBvciBlbHNlIHRoZSB1c2VycyBjYW4NCj4gPiA+IG92ZXJyaWRlIGVhY2gg
b3RoZXIncyByZXF1ZXN0LiAgSW4gdGhhdCBjYXNlDQo+ID4NCj4gPiBJTkhPIGhvdyBMaW51eCBL
ZXJuZWwgd2lsbCBhZ2dyZWdhdGUgdGhlIEF1eCBQb3dlciByZXF1ZXN0LCB3aXRob3V0DQo+ID4g
a25vd2luZyB0aGUgdG90YWwgQXV4IHBvd2VyIGJ1ZGdldC4gQUZBSVUgYWdncmVnYXRlZCBBdXgg
cG93ZXIgcmVxdWVzdA0KPiA+IHdpdGhvdXQga25vd2xlZGdlIG9mIHRvdGFsIHBvd2VyIGJ1ZGdl
dCBjYW4gYWxzbyBiZSBkZW5pZWQgYnkgQklPU1sxXS4NCj4gPiBUaGVyZWZvcmUgaG93IGFnZ3Jl
Z2F0aW9uIGNhbiBiZSB1c2VmdWwgPw0KPiANCj4gU2F5IHR3byBkcml2ZXJzIHJlcXVlc3QgdGhl
IEF1eCBwb3dlciBmcm9tIHRoZSBzYW1lIFJvb3QgUG9ydCBhbmQgZWFjaCBvZg0KPiB0aGVtIHBh
c3NlcyBhIGxpbWl0IHN1ZmZpY2llbnQgZm9yIGl0cyBkZXZpY2UuICBXaXRob3V0IGFnZ3JlZ2F0
aW9uLCB3aGF0DQo+IGd1YXJhbnRlZXMgdGhhdCB0aGUgbGFzdCBsaW1pdCBwYXNzZWQgd2lsbCBi
ZSBzdWZmaWNpZW50IGZvciBib3RoIGRldmljZXM/DQpUaGFua3MgZm9yIGV4cGxhaW5pbmcgdGhp
cy4NCj4gDQo+IEFsc28gc2VlIHRoZSBzcGVjIHByb3Zpc2lvbiByZWdhcmRpbmcgcmV0cmllcyBi
ZWxvdy4NCj4gDQo+ID4gWzFdQXMgcGVyIHIzLjMgU2VjdGlvbiA0LjYuMTANCj4gPiBQbGF0Zm9y
bSBGaXJtd2FyZSBCdWRnZXRpbmcgb2YgQXV4IFBvd2VyIEF2YWlsYWJpbGl0eToNCj4gPiBQbGF0
Zm9ybSBmaXJtd2FyZSBtdXN0IG5vdCBncmFudCBtb3JlIHBvd2VyIHRoYW4gd2hhdCBpcyBhdmFp
bGFibGUNCj4gPiB3aXRoaW4gdGhlIHN5c3RlbS4gRm9yIGV4YW1wbGUsIGEgYm9hcmQgbWF5IGJl
IGRlc2lnbmVkIHdpdGggZm91ciBDRU0NCj4gPiBzbG90cyAob25lIHgxNiBzbG90LCBvbmUgeDQg
c2xvdCwgYW5kIHR3byB4MSBzbG90cykuIFRoZSBib2FyZCBtYXkNCj4gPiBpbXBsZW1lbnQgYSBw
b3dlciBkZWxpdmVyeSBjaXJjdWl0IGNhcGFibGUgb2Ygc3VwcGx5aW5nIDIgVyBvZiBwb3dlciBm
b3IgdGhlDQo+IDMuMyBWYXV4IHJhaWwgc3VwcGx5aW5nIGFsbCA0IHNsb3RzLiBUaGUgMy4zIFZh
dXggcGlucyBvbiBlYWNoIENFTSBzbG90IGNhbg0KPiBzdXBwbHkgMSBXIGVhY2guDQo+ID4gUGxh
dGZvcm0gZmlybXdhcmUgbWF5IHVzZSB0aGUgcmV0cnkgbWVjaGFuaXNtIHRvIHByaW9yaXRpemUg
cmVxdWVzdHMNCj4gPiBmcm9tIGRldmljZXMgaW4gcHJlZmVycmVkIHNsb3RzIGluIHRoZSBmb2xs
b3dpbmcgbWFubmVyOg0KPiA+DQo+ID4gLT4gUmVxdWVzdHMgZnJvbSBhIGRldmljZSBpbiB0aGUg
aGlnaGVzdCBwcmlvcml0eSBzbG90IChlLmcuLCB4MTYpIGFyZQ0KPiA+IC0+IGdyYW50ZWQgaW1t
ZWRpYXRlbHksIGlmDQo+ID4gYXZhaWxhYmxlLg0KPiA+DQo+ID4gLT4gUmVxdWVzdHMgZnJvbSBk
ZXZpY2VzIGluIGxvd2VyIHByaW9yaXR5IHNsb3RzIChlLmcuLCB4MiwgeDEpIGFyZQ0KPiA+IC0+
IGluaXRpYWxseSByZWplY3RlZCwgd2l0aCBhIHJldHJ5DQo+ID4gaW50ZXJ2YWwgaW52ZXJzZWx5
IHByb3BvcnRpb25hbCB0byB0aGUgc2xvdCBwcmlvcml0eS4gRm9yIGluc3RhbmNlLCBpZg0KPiA+
IHRoZSB4MiBzbG90IGlzIGhpZ2hlciBwcmlvcml0eSB0aGFuIHRoZSB4MSBzbG90cywgc28gdGhl
IHJldHJ5DQo+ID4gaW50ZXJ2YWwgZm9yIHRoZSB4MiBzbG90IG1heSBiZSA0IHNlY29uZHMsIGFu
ZCB0aGUgeDEgc2xvdHMgbWF5IGJlDQo+ID4gOCBhbmQgMTAgc2Vjb25kcy4NCj4gPg0KPiA+IC0+
QXMgcmVxdWVzdHMgYXJlIGdyYW50ZWQsIHRoZSBncmFudGVkIHZhbHVlcyBhcmUgc3VidHJhY3Rl
ZCBmcm9tIHRoZQ0KPiBhdmFpbGFibGUgYnVkZ2V0Lg0KPiA+ICBSZXRyaWVkIHJlcXVlc3RzIGFy
ZSBncmFudGVkIGJhc2VkIG9uIHRoZSByZW1haW5pbmcgcG93ZXIgYnVkZ2V0IG9yDQo+ID4gZGVu
aWVkIGlmIGluc3VmZmljaWVudCBwb3dlciBidWRnZXQgaXMgYXZhaWxhYmxlLiBBbm90aGVyIHJl
dHJ5IGlzIG5vdA0KPiBwZXJtaXR0ZWQuDQo+ID4NCj4gPiAtPiBXaGVuIHRoZXJlIGlzIGluc3Vm
ZmljaWVudCBwb3dlciBidWRnZXQgZm9yIGEgcmVxdWVzdCwgZmlybXdhcmUgbWF5DQo+ID4gLT4g
Y2hvb3NlIHRvIGtlZXAgbWFpbg0KPiA+IHBvd2VyIG9uIGFuZCByZXR1cm4gbm8gcG93ZXIgcmVt
b3ZhbCAoMmgpLg0KPiANCj4gVGhpcyBtZWFucyB0aGF0IHRoZSBwbGF0Zm9ybSBmaXJtd2FyZSBp
cyBzdXBwb3NlZCB0byBkbyBpdHMgb3duIGFnZ3JlZ2F0aW9uLA0KPiBidXQgYXQgdGhlIHN5c3Rl
bSAoYm9hcmQpIGxldmVsLCBub3QgYXQgdGhlIFJvb3QgUG9ydCBsZXZlbC4NCj4gDQo+IFRoZSBh
bGdvcml0aG0gaXMgZGVzY3JpYmVkIGFib3ZlIGFuZCBteSB1bmRlcnN0YW5kaW5nIG9mIGl0IGlz
IHRoYXQgb25jZSBhDQo+IHJlcXVlc3QgaGFzIGJlZW4gZ3JhbnRlZCwgaXQgY2Fubm90IGJlIHJl
dHJhY3RlZCBsYXRlci4gIEFsc28gaXQgYXBwZWFycyB0bw0KPiBhc3N1bWUgYSAxOjEgY29ycmVz
cG9uZGVuY2UgYmV0d2VlbiBQQ0llIHNsb3RzIGFuZCBSb290IFBvcnRzLg0KPiANCj4gVGhlIGd1
eXMgd2hvIGhhdmVuJ3QgYmVlbiBncmFudGVkIHRoZWlyIHJlcXVlc3RzIGF0IG9uY2UgbWF5IGJl
IGFza2VkIHRvIHRyeQ0KPiBhZ2FpbiBsYXRlciBhbmQgdGhlcmUgbWF5IG5vdCBiZSBlbm91Z2gg
QXV4IHBvd2VyIGZvciB0aGUgbGFzdCBndXlzIGF0IGFsbCwgc28NCj4gdGhleSB3aWxsIG5vdCBn
ZXQgaXQgYW5kIHRoZXkgd2lsbCBzdGF5IG9uIHRoZSBtYWluIHBvd2VyLiAgQW5kIGFnYWluLCB0
aGlzDQo+IGFwcGVhcnMgdG8gYmUgYXQgdGhlIFJvb3QgUG9ydCBncmFudWxhcml0eS4NClRoYW5r
cyBmb3IgZXhwbGFuYXRpb24uDQpUaGFua3MsDQpBbnNodW1hbg0K

