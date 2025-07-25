Return-Path: <linux-pci+bounces-32922-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1EAB11999
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 10:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 032375A0974
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 08:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064362BEC25;
	Fri, 25 Jul 2025 08:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LfuOaqkw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06DA220F2D;
	Fri, 25 Jul 2025 08:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753431193; cv=fail; b=Hg9fDRH8B1/zNFxCy5v3DzTZxErQwtdmnVqmkxbzkofGjVKczQOR2V94xlWezl9GG8AG28xSpK6Xn5FlXNvLZIjQdu0PMVtMZsZqqeEA1SVVN1ZFLrU6ZdKA3j7dDAmtLbkLWU+9LDaYDrEb4Cm9O3Gmc1kprSrZVVeGUaTwR2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753431193; c=relaxed/simple;
	bh=+elzqPpd4dkHDEFQZm7es+IF818sFrf/wJWbcv+IWoU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DxYFasQ/NX0erFE/Q+T9TBUYgZaabo8Htm52ok1m3KiMlYURRafaQYad4jOXC4P8HBI59QM+MGXRIXZ1J1d+KlefNtE9tOH4uLhoyARYI/paN3/x8FNaPFoFgM1Ot4HVVph7hS+NB5RQyLHo840qYaq4Ce6a2EQlcAnJpV9/u9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LfuOaqkw; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753431192; x=1784967192;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+elzqPpd4dkHDEFQZm7es+IF818sFrf/wJWbcv+IWoU=;
  b=LfuOaqkwggLfPx+AiWWwg+XHw1SIK1ULTU3h3QKvMJ2LJ0H5XFZeuVRH
   4YK6cXKmwh5LcVnZ8S/yLbdfdJT7FeR5ir6VrFH3b81Ck5ts392bFDuAX
   J9jAUTzUi1Ezn+x39R4hLidZYLUN/z6LBRLLU6K4fmUSX9j6cZA+Vg328
   8DMO1zD7RQefz28pCdIt6bsGt9CfpoXuloGjERIsGGhMlGcFNaEZHJL+1
   TpLj76ptge+KhUaWNhp14x0ei741zF+kQVCMMk4dp3lMva79alYftN+P9
   azRAGbWUPZAAhZD5+mMadCAXwKGiLF2o5s8+obbH+N8mbZSnlKH0rXGJS
   g==;
X-CSE-ConnectionGUID: WUoU/hy1RX6cpoPmgS6alw==
X-CSE-MsgGUID: obbfOwuzRYqWkKXL40yE8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="55640813"
X-IronPort-AV: E=Sophos;i="6.16,338,1744095600"; 
   d="scan'208";a="55640813"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 01:13:11 -0700
X-CSE-ConnectionGUID: 4l+lK3bYT16Jry941aCiew==
X-CSE-MsgGUID: C/hHp+70QieS8bin1xfaww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,338,1744095600"; 
   d="scan'208";a="165274806"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 01:13:11 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 01:13:10 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 25 Jul 2025 01:13:10 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.71) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 25 Jul 2025 01:13:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gDH76phNpCtrCBKBPN4DXlNcUIBmXGaPPyfnCfig7tz8As9m92kdymSWIls7Wmw1EYftLhkA7GDqDIWFwGejv3bugyRBMDuFKwMzd+vWL//GvwbOYuJwUdLmreKT/KgpNKKu5gy6egA9iBToMwt7BtsM+DLoyeRYKXkMNYv3gN3ubvBQgpMP/LyUJR1HS3LR+gW/9SOhS4DOxaLH7VhrXLDr79ahk8dJt1kz1A91dn292Dtb6/q5B9lXzUEybfnkGf8KvVeAZbvNdT4liObo5FnFFpAsROVvglsOyYJFpOo5lqAfzKpmbeCukZsDVsRlpdM3gYRCeB7LCwHO5jJNwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+elzqPpd4dkHDEFQZm7es+IF818sFrf/wJWbcv+IWoU=;
 b=VRMDuyPuv0E61o0zYYXxc5IPS164xa1qPFx8QHE2Zn2TU/lQJcerylBaN0+or+5XurY7ErHm/0Guaj16pA8Sk5ciqVtXohvj4/ISaO/891WixnqNF61Ny22zDFnEGI/7OkgjIM+s+Vo4nlZulDb8DBQuBG+rAVXvE0FbXykmIOLazRVnCFTmq3SyDFgw/xeqGRCfz/7tYaWqHOA6F1UKDixdAc4yQrPR/Dd0CVLw2FKrlEBfErQ8lj1vATdTpsCkuhWYactBEdsFz7IHGZVKS3mTQhvEITXrxQXOPh8e8oem4fFi0+F5kmkZVK1sK4YPRuX46G2ZoEDB00F472lpRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by DM3PR11MB8684.namprd11.prod.outlook.com (2603:10b6:0:4a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.23; Fri, 25 Jul
 2025 08:13:08 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010%2]) with mapi id 15.20.8964.019; Fri, 25 Jul 2025
 08:13:08 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>, "Devegowda, Chandrashekar"
	<chandrashekar.devegowda@intel.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>, "Tumkur Narayan,
 Chethan" <chethan.tumkur.narayan@intel.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: RE: [PATCH v5] Bluetooth: btintel_pcie: Add support for _suspend() /
 _resume()
Thread-Topic: [PATCH v5] Bluetooth: btintel_pcie: Add support for _suspend() /
 _resume()
Thread-Index: AQHb+9dtOes1mInNPkalf/M6FIzy4bRAzaWAgAGTrGA=
Date: Fri, 25 Jul 2025 08:13:08 +0000
Message-ID: <PH0PR11MB75853B0B14DED3754669CA5EF559A@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20250723135715.1302241-1-kiran.k@intel.com>
 <5323f487-0060-4396-b08e-b68a18f1893d@molgen.mpg.de>
In-Reply-To: <5323f487-0060-4396-b08e-b68a18f1893d@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|DM3PR11MB8684:EE_
x-ms-office365-filtering-correlation-id: 059d9fc5-8efe-44b8-607f-08ddcb5316ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZU1HWVg1LzhrWURhN0x2WThGbkc1THpsalFGakhqQkRzUnQ2Q1pVZXVLT2Vx?=
 =?utf-8?B?WUNLVnlFYktvQ3hIaEVkUnZvaFRydHZsOXh2cHpabUluakI1c05VVnZDZDli?=
 =?utf-8?B?YVRxNzFHMk5jSGR2OEJBM2xlTkdwMmNVblY1K1lYSXBDR0VGbW5ZVjRsekRU?=
 =?utf-8?B?TWJOM1BZc2R4T0VvKy9PdlBTZE10Um5sRFNzUW41VkpFN08yTzBobWx6R0V1?=
 =?utf-8?B?WWxoNFdpTHNHVUpQWEExaGdpditubE1Yc200aERxTk50REhaTU56bDgxS0dQ?=
 =?utf-8?B?SEVJdmQ5SVhGZjNhSXR6U3FhZ1RyS2ptcTN5cUd6T1BTV2xIMUZnNXNHK0VE?=
 =?utf-8?B?djczMFh3U3laTGFSZkhPZXY3UW02RW52bjZycTlZSjY2WkdsUHVUWU5rbWlK?=
 =?utf-8?B?RC9jT0lTQk5wVW0wR01WdVF0TkZlQnhEOGRYdndrMnRuc1MyNWF6Wm5FdFFF?=
 =?utf-8?B?UlpMYkl3RmtNbHB1V1piS3ZWSFhhN1czQm1SY3A3U043dGluMFdyMHJSd1pk?=
 =?utf-8?B?N1R2VjVSc21Ecll4dEZHUTJhNmR3MUpnWXpmQ2Z3RUZNa0ZoOGFWM2MzY0Vh?=
 =?utf-8?B?azlHck5xVzgzdnUrQ3k3dWVCeU9heG9UMHRpMklCNkZadHpVb0FXR3E0N2Js?=
 =?utf-8?B?MW05Nk50UGY5WGZPSFp4eGhucXMxaWZoZHk3SFJHem1Xd0x6MVJEOFF1cElN?=
 =?utf-8?B?ZHhCTDZIbmtHWnZBcUJsdGNiQ0tvU0Q3RWVBakt2bWxXQmJJaURrQzBTRDdM?=
 =?utf-8?B?eDVrcjFWQXY3ZEFUdHkxV01kYVNoS1BSVE5nNWtnd2RuUGN4b0tpVGM0MjhD?=
 =?utf-8?B?S3hNT3FUUVZNL0xBQnNDd1pXZnpMZWJFQVJVb29NR2pkOTZUTTJUYmVXNEpi?=
 =?utf-8?B?WmUva3RpQmVidlNUd1VMSklKaEZURmpTZktCMy9OeU9CQnpxYVdrRkgwWFR0?=
 =?utf-8?B?Q2hNblkwWnVmbHRxVnJkaktENVhYMDZiWHlwUlF6NmUxNzlPc3o5bnAzM2dl?=
 =?utf-8?B?M1drbWUyVkw2RUwzMjRLT1hraUJWZmw3bGIvOGlLN0x3RFRuNUM2cjdOVzJD?=
 =?utf-8?B?dld2QU9TWFNzY0VoWE9oM2RJY3Q3ak1SaUU2di9CRUtMZHlNNEZ0U1dybzlL?=
 =?utf-8?B?NHhRTzdlVEQ5TEpMOVBQMlFtNHdDeEFNaHZtQ3M5UU9JMWtVcGp4MEVDTGFx?=
 =?utf-8?B?TzZNd2M0cEpoWEwyYWlCaHVZTUZKZlJxNGFhZ2pRbEREZ3ozdzVaSE5OWnEy?=
 =?utf-8?B?bVBEb05POTh3dWNOSTZZcmM5NlliRG1nUzFGNDMvMUtXbXloMVR6bHZRRi9j?=
 =?utf-8?B?eGkxZEFuc09WYm1XSW1WM0p4UWVDNXFLak5ES3E0dm51N05ZdjB3Zmh5Rkls?=
 =?utf-8?B?QTdqbzFxbGp0UXpOUHN5Rmg0ZGtPLzV2YW90bHRnY2FkcmN1cWhnQUo2SzA5?=
 =?utf-8?B?dmdseHRabTdYdzlXWDRhVFRGRkV6a091YVZZQkE0V3ZkcGNXS0k1dVhwSmF1?=
 =?utf-8?B?Q2dSWUYxWFFIWkkzTmJLOXloZmJ0MGR5RjdVQnJnY3N2NytuYzRHK2xoTS91?=
 =?utf-8?B?cUVWL0RUZHBqc1h2c001bm5wbEJkY2pGUXh6UFhBcVJnRElna3BINnFNMWhq?=
 =?utf-8?B?RHh4QjRzWXpkRGh2NFdJSXZnVk1WdWl0WElMZ0lOY0VqYWRzRkR1Z2RQbTJn?=
 =?utf-8?B?OFRUUTU5QlVRZkVIUjdZVzFDTzhicTlGY0Q1MzhHc0h2VE0yMDU1djJnUmhK?=
 =?utf-8?B?ajI0TzRTRHhidTl5SkRnZGVJVVZNbmJRR3R0V3FXN1VUNFp3a3UzbHRIQjg0?=
 =?utf-8?B?ZXF6dWxZTVUxSkp2UHFmRjVYUU5NUVVjZ1NZVThwUTZMMW5QSm1NTmxYbDNY?=
 =?utf-8?B?ZWgyMnU0aWdDWE1pUGlyRDRXMUV5Rmh5MzJNZXNZV1BDdmhtZ0ZUNld5ckJF?=
 =?utf-8?B?S0tFbUVJUTBvUTlyeWFUSTJ2MEdEenlGd09oZHZCcWNjdG9la1czY0pqNjYz?=
 =?utf-8?B?WllpVXF6VG5RPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZitBNWJhOG53UnZwelJXa1BwSTZlT1V1bG5Wcit5dFdXMlptVjUwc3hhNnhS?=
 =?utf-8?B?Vy95SXNOVFJqNTVxNlBMUnljUjBSWW1XWjduU1JIWEIvdGNzbEM4bktzU1Vn?=
 =?utf-8?B?TmNaS2FkeGw0WHV1SGN0d3ZFZ2hweXlmSE9IN3ltbk1ERCtTRjBlcGw2NVMy?=
 =?utf-8?B?WmpMdUJHcGFqSmVpVkhkYTRMd0dGd2RVRGQyYVNHN05YUnR6Vk1PMkhhc3JP?=
 =?utf-8?B?UFJSYnZXK2ZvMjljeGtOWHZFTE1mVmhUVzRwQ1libjFmWGcxVG1vQXBiSnhX?=
 =?utf-8?B?OXh1cWZlVXNBZmJ6MVB1czYvbHlHaDF0dktDMEk2TTNEaC9JaEFWUlptVnB6?=
 =?utf-8?B?N1c1L2NoRCtWVXRGMFBxbFhnSkFjRmV4THpnbjMybTN5ZzBRVCtZK1dYaW83?=
 =?utf-8?B?S3JFcktjRTZXTHNkbzRoNjZSUGptdXlmMU12RXZGWUdvdEVlaExHcUdQOWVW?=
 =?utf-8?B?cnQxNTBMRWFoNnlZTHVNZHRXNUIzb2d4TkQxTk1mLzQ2ZExKWlVGVkpvbGVh?=
 =?utf-8?B?dWZBSWFPTW1KZnpnNm0rS2t3dkhIODhUNUlIbHFMc29iakNnZjYvVCtLUmJU?=
 =?utf-8?B?MGo0ekRSakpoSVpwelBvVlY0c2RoVmRZYnduNHFybTNDaWNqNTdOYnB5NGha?=
 =?utf-8?B?MXB3Q09UN2E3Qkp5WTZ6RDRrK3IvNWtXbUJnMHpXZkhtNXl1MmRTS2FIVEsx?=
 =?utf-8?B?cllrU0YxN2xlRDZkd1VjNmdNZzJMNi9rZXMwM0JKRFd2U1RXT3VXUlhpb2l6?=
 =?utf-8?B?cWI5Z0xsR3A1bVVVU2FkS01DTjVSLzUzNC9FTkZIODJvYVdQdHlGNENwak5J?=
 =?utf-8?B?T0VXb0YvWWpsTTNyVE1RcmNCT0xnRU1UbHZMaVlwcW1MbVVESFdycnFpb09x?=
 =?utf-8?B?cEl3a0VZbGZBUUNwUGFPbkFEaXlNeDl5OXRvQVplZlprU0MyVmhsWHNQL1pD?=
 =?utf-8?B?YUlkUk1uZVA5d1FWaUNGNmZWMkpGYmpxdFZZdkpJTWdBa0l5UGVpbjdxdkZ2?=
 =?utf-8?B?UG1IaDU3REkvdVpjUTVITm8rSFprMmdVMzJnbXl1N2hQUjJnSjBUZzBCVGJ4?=
 =?utf-8?B?T29RMUg1V054d3VZYUlteGpERkhOaGVBY2pOUXNaMm1ONGtvYW92a3RNbFBX?=
 =?utf-8?B?cWhYbXlmVXpOeGdqVW05dUQ0eVpkUlM3Rk9vekRpT205eTFXREdOUWgvNDFa?=
 =?utf-8?B?M1hYT25nbVFJazYwQ2RsRkswdmFZVFY1ejFNUDhsaGNyTWJ5UkJLZ0g4ZFNH?=
 =?utf-8?B?aW1MSjdRVFQvdW9FMjFGSlVqSHpKTDdZUkE0MjlTTkVsZG8xdDMrZi81ZW1m?=
 =?utf-8?B?czhpMFpFNUt1aEJ2T0lKNitLbVZxd3YrYXpGcDRIbVhZOWF4WGZJL3p0b1FT?=
 =?utf-8?B?LzJJeXF4bi84bVRqTk5mN1MyNUhOVkJ5bFgwR0xXeCt4N3Y1MFRBVUYrWm9N?=
 =?utf-8?B?cU5KR0RQdnU2TzFxenhGbkZmNTFmTXNuZHk0cEQya0EwMDJYQW1nN1REcHJF?=
 =?utf-8?B?MTBWY2xhNEtiMlA1UnEyZTZRNEhPa0c5US9aZDlrRTQyUkFxVmRZTXNKaFZr?=
 =?utf-8?B?UVZsbG9UdUpGdXJJejhpZnlyVnd6QUdKMEhFbnVOSUdnWHdJWm40YXU4RHRS?=
 =?utf-8?B?Qk43aTVUbzF6UkgzV1FvQkRwUlN1Lzlna2M5VHE1OElBTkpJd2ZCeWhrRUhX?=
 =?utf-8?B?S1pJUGUxeFBkYXpXaXZNbFBFUVZCK0FEYUFYUFNqVDRwa2xzWW82ZmFPRU1w?=
 =?utf-8?B?K0RENFNrZS9mWUdLUW5zbWh0a01peEdjSDhNZlJmUWFoY2FWdHVDeFZsRGdB?=
 =?utf-8?B?TTRyYTJWTjZUSWVVS1NpbjlvZ0huNW9FZGxBcXdzYWtoOVY0OE0xTktyYzI5?=
 =?utf-8?B?K0pMZWZsWGphR0VBZ3BFU1hZWEFOUmJ1RnIyZEJtVTFJTmV1TUtiaDZub1lx?=
 =?utf-8?B?NGh1TVp2TjJNRDVTUVcxbHgzc25kTWhKb3NoblRIQWViSzUvaElIekg1RmpZ?=
 =?utf-8?B?RVNBRUJVRHJIL1lnN3RmNitEZm1oOHcxeTczcTRGZUJmcnlrdlZDRUxOclZX?=
 =?utf-8?B?eXlwYm9KdUsvc29zZ2wzb0c2NjI0Qk1BUnAya1J5bnZaN0RkSTJHeTVPbFdM?=
 =?utf-8?Q?IEqA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 059d9fc5-8efe-44b8-607f-08ddcb5316ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2025 08:13:08.0447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4ii7DWfM0nUV4zfiQpApk+Amu052NUQk0AFlnlAFHu3LGGfZ/sOYTrAhOWQTTSyO0YSXeTT0oJJE3ribwvuJyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8684
X-OriginatorOrg: intel.com

SGkgUGF1bCwNCg0KQXBwcmVjaWF0ZSB5b3VyIGNvbW1lbnRzLg0KDQo+LS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj5Gcm9tOiBQYXVsIE1lbnplbCA8cG1lbnplbEBtb2xnZW4ubXBnLmRlPg0K
PlNlbnQ6IFRodXJzZGF5LCBKdWx5IDI0LCAyMDI1IDExOjQ4IEFNDQo+VG86IEssIEtpcmFuIDxr
aXJhbi5rQGludGVsLmNvbT47IERldmVnb3dkYSwgQ2hhbmRyYXNoZWthcg0KPjxjaGFuZHJhc2hl
a2FyLmRldmVnb3dkYUBpbnRlbC5jb20+DQo+Q2M6IGxpbnV4LWJsdWV0b290aEB2Z2VyLmtlcm5l
bC5vcmc7IFNyaXZhdHNhLCBSYXZpc2hhbmthcg0KPjxyYXZpc2hhbmthci5zcml2YXRzYUBpbnRl
bC5jb20+OyBUdW1rdXIgTmFyYXlhbiwgQ2hldGhhbg0KPjxjaGV0aGFuLnR1bWt1ci5uYXJheWFu
QGludGVsLmNvbT47IGJoZWxnYWFzQGdvb2dsZS5jb207IGxpbnV4LQ0KPnBjaUB2Z2VyLmtlcm5l
bC5vcmcNCj5TdWJqZWN0OiBSZTogW1BBVENIIHY1XSBCbHVldG9vdGg6IGJ0aW50ZWxfcGNpZTog
QWRkIHN1cHBvcnQgZm9yIF9zdXNwZW5kKCkgLw0KPl9yZXN1bWUoKQ0KPg0KPkRlYXIgS2lyYW4s
IGRlYXIgQ2hhbmRyYXNoZWthciwNCj4NCj4NCj5UaGFuayB5b3UgZm9yIHlvdXIgcGF0Y2guDQo+
DQo+QW0gMjMuMDcuMjUgdW0gMTU6NTcgc2NocmllYiBLaXJhbiBLOg0KPj4gRnJvbTogQ2hhbmRy
YXNoZWthciBEZXZlZ293ZGEgPGNoYW5kcmFzaGVrYXIuZGV2ZWdvd2RhQGludGVsLmNvbT4NCj4+
DQo+PiBUaGlzIHBhdGNoIGltcGxlbWVudHMgX3N1c3BlbmQoKSBhbmQgX3Jlc3VtZSgpIGZ1bmN0
aW9ucyBmb3IgdGhlDQo+PiBCbHVldG9vdGggY29udHJvbGxlci4gV2hlbiB0aGUgc3lzdGVtIGVu
dGVycyBhIHN1c3BlbmRlZCBzdGF0ZSwgdGhlDQo+PiBkcml2ZXIgbm90aWZpZXMgdGhlIGNvbnRy
b2xsZXIgdG8gcGVyZm9ybSBuZWNlc3NhcnkgaG91c2VrZWVwaW5nIHRhc2tzDQo+PiBieSB3cml0
aW5nIHRvIHRoZSBzbGVlcCBjb250cm9sIHJlZ2lzdGVyIGFuZCB3YWl0cyBmb3IgYW4gYWxpdmUN
Cj4+IGludGVycnVwdC4gVGhlIGZpcm13YXJlIHJhaXNlcyB0aGUgYWxpdmUgaW50ZXJydXB0IHdo
ZW4gaXQgaGFzDQo+PiB0cmFuc2l0aW9uZWQgdG8gdGhlIEQzIHN0YXRlLiBUaGUgc2FtZSBmbG93
IG9jY3VycyB3aGVuIHRoZSBzeXN0ZW0NCj4+IHJlc3VtZXMuDQo+Pg0KPj4gQ29tbWFuZCB0byB0
ZXN0IGhvc3QgaW5pdGlhdGVkIHdha2V1cCBhZnRlciA2MCBzZWNvbmRzIHN1ZG8gcnRjd2FrZSAt
bQ0KPj4gbWVtIC1zIDYwDQo+Pg0KPj4gZG1lc2cgbG9nICh0ZXN0ZWQgb24gV2hhbGUgUGVhazIg
b24gUGFudGhlciBMYWtlIHBsYXRmb3JtKSBPbiBzeXN0ZW0NCj4+IHN1c3BlbmQ6DQo+PiBbICA1
MTYuNDE4MzE2XSBCbHVldG9vdGg6IGhjaTA6IGRldmljZSBlbnRlcmVkIGludG8gZDMgc3RhdGUg
ZnJvbSBkMA0KPj4gaW4gODEgdXMNCj4+DQo+PiBPbiBzeXN0ZW0gcmVzdW1lOg0KPj4gWyAgNTQy
LjE3NDEyOF0gQmx1ZXRvb3RoOiBoY2kwOiBkZXZpY2UgZW50ZXJlZCBpbnRvIGQwIHN0YXRlIGZy
b20gZDMNCj4+IGluIDM1NyB1cw0KPg0KPkp1c3QgdG8gYXZvaWQgY29uZnVzaW9uLCBpcyB0aGUg
dGltZXN0YW1wIGNvcnJlY3QsIGFzIHRoaXMgaXMgb25seSBhIDI2IHMNCj5kaWZmZXJlbmNlIGFu
ZCB5b3VyIGNvbW1hbmQgc2F5cyA2MCBzLiAoSSBhbSBvbmx5IGF3YXJlIG9mIGluYWNjdXJhdGUN
Cj50aW1lc3RhbXBzIHVzaW5nIGh1bWFuLXJlYWRhYmxlIGZvcm1hdCAoYGRtZXNnIC1UYCkuKQ0K
VGhlIHN5c3RlbSB3YXMgd29rZW4gdXAgYnkga2V5IHByZXNzIGJlZm9yZSB0aGUgc2xlZXAgdGlt
ZW91dC4gVG8gYXZvaWQgdGhlIGNvbmZ1c2lvbiwgSSB3aWxsIHVwZGF0ZSB0aGUgdHJhY2VzIHRv
IHJlZmxlY3QgdGhlIHN5c3RlbSB3YWtpbmcgdXAgaW5kZXBlbmRlbnRseS4NCj4NCj4+IFNpZ25l
ZC1vZmYtYnk6IENoYW5kcmFzaGVrYXIgRGV2ZWdvd2RhDQo+PiA8Y2hhbmRyYXNoZWthci5kZXZl
Z293ZGFAaW50ZWwuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogS2lyYW4gSyA8a2lyYW4ua0BpbnRl
bC5jb20+DQo+PiAtLS0NCj4+IGNoYW5nZXMgaW4gdjU6DQo+PiAgICAgICAtIEFkZHJlc3MgcmV2
aWV3IGNvbW1lbnRzDQo+DQo+VGhpcyBzaG91bGQgYmUgbW9yZSBkZXRhaWxlZCwgaWYgY29kZSB3
YXMgY2hhbmdlZC4NCkFjay4NCg0KPg0KPj4gY2hhbmdlcyBpbiB2NDoNCj4+ICAgICAgIC0gTW92
ZWQgZG9jdW1lbnQgYW5kIHNlY3Rpb24gZGV0YWlscyBmcm9tIHRoZSBjb21taXQgbWVzc2FnZSBh
cw0KPmNvbW1lbnQgaW4gY29kZS4NCj4+DQo+PiBjaGFuZ2VzIGluIHYzOg0KPj4gICAgICAgLSBD
b3JyZWN0ZWQgdGhlIHR5cG8ncw0KPj4gICAgICAgLSBVcGRhdGVkIHRoZSBDQyBsaXN0IGFzIHN1
Z2dlc3RlZC4NCj4+ICAgICAgIC0gQ29ycmVjdGVkIHRoZSBmb3JtYXQgc3BlY2lmaWVycyBpbiB0
aGUgbG9ncy4NCj4+DQo+PiBjaGFuZ2VzIGluIHYyOg0KPj4gICAgICAgLSBVcGRhdGVkIHRoZSBj
b21taXQgbWVzc2FnZSB3aXRoIHRlc3Qgc3RlcHMgYW5kIGxvZ3MuDQo+PiAgICAgICAtIEFkZGVk
IGxvZ3MgdG8gaW5jbHVkZSB0aGUgdGltZW91dCBtZXNzYWdlLg0KPj4gICAgICAgLSBGaXhlZCBh
IHBvdGVudGlhbCByYWNlIGNvbmRpdGlvbiBkdXJpbmcgc3VzcGVuZCBhbmQgcmVzdW1lLg0KPj4N
Cj4+ICAgZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbF9wY2llLmMgfCAxMDIgKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKw0KPj4gICBkcml2ZXJzL2JsdWV0b290aC9idGludGVsX3BjaWUu
aCB8ICAgNCArKw0KPj4gICAyIGZpbGVzIGNoYW5nZWQsIDEwNiBpbnNlcnRpb25zKCspDQo+Pg0K
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWxfcGNpZS5jDQo+PiBiL2Ry
aXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWxfcGNpZS5jDQo+PiBpbmRleCA2ZTdiYmJkMzUyNzkuLmE5
Njk3NWE1NWNiZSAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWxfcGNp
ZS5jDQo+PiArKysgYi9kcml2ZXJzL2JsdWV0b290aC9idGludGVsX3BjaWUuYw0KPj4gQEAgLTU0
MCw2ICs1NDAsMTIgQEAgc3RhdGljIGludCBidGludGVsX3BjaWVfcmVzZXRfYnQoc3RydWN0DQo+
YnRpbnRlbF9wY2llX2RhdGEgKmRhdGEpDQo+PiAgIAlyZXR1cm4gcmVnID09IDAgPyAwIDogLUVO
T0RFVjsNCj4+ICAgfQ0KPj4NCj4+ICtzdGF0aWMgdm9pZCBidGludGVsX3BjaWVfc2V0X3BlcnNp
c3RlbmNlX21vZGUoc3RydWN0DQo+PiArYnRpbnRlbF9wY2llX2RhdGEgKmRhdGEpIHsNCj4+ICsJ
YnRpbnRlbF9wY2llX3NldF9yZWdfYml0cyhkYXRhLA0KPkJUSU5URUxfUENJRV9DU1JfSFdfQk9P
VF9DT05GSUcsDQo+PiArDQo+QlRJTlRFTF9QQ0lFX0NTUl9IV19CT09UX0NPTkZJR19LRUVQX09O
KTsNCj4+ICt9DQo+PiArDQo+PiAgIHN0YXRpYyB2b2lkIGJ0aW50ZWxfcGNpZV9tYWNfaW5pdChz
dHJ1Y3QgYnRpbnRlbF9wY2llX2RhdGEgKmRhdGEpDQo+PiAgIHsNCj4+ICAgCXUzMiByZWc7DQo+
PiBAQCAtODI5LDYgKzgzNSw4IEBAIHN0YXRpYyBpbnQgYnRpbnRlbF9wY2llX2VuYWJsZV9idChz
dHJ1Y3QNCj5idGludGVsX3BjaWVfZGF0YSAqZGF0YSkNCj4+ICAgCSAqLw0KPj4gICAJZGF0YS0+
Ym9vdF9zdGFnZV9jYWNoZSA9IDB4MDsNCj4+DQo+PiArCWJ0aW50ZWxfcGNpZV9zZXRfcGVyc2lz
dGVuY2VfbW9kZShkYXRhKTsNCj4+ICsNCj4NCj5UaGlzIGh1bmsgaXMgbm90IGRlc2NyaWJlZCBp
biB0aGUgY29tbWl0IG1lc3NhZ2UuDQpUaGlzIHJlZ2lzdGVyIHdyaXRlIGlzIGludGVuZGVkIHRv
IHJldGFpbiBmaXJtd2FyZSBzdGF0ZSBhY3Jvc3MgYSB3YXJtIHJlYm9vdCAoUzUpIGFuZCBpcyBu
b3QgcmVsZXZhbnQgdG8gdGhpcyBwYXRjaC4gQXBvbG9naWVzIGZvciBvdmVybG9va2luZyB0aGlz
IGRldGFpbC4NCj4NCj4+ICAgCS8qIFNldCBNQUNfSU5JVCBiaXQgdG8gc3RhcnQgcHJpbWFyeSBi
b290bG9hZGVyICovDQo+PiAgIAlyZWcgPSBidGludGVsX3BjaWVfcmRfcmVnMzIoZGF0YSwNCj5C
VElOVEVMX1BDSUVfQ1NSX0ZVTkNfQ1RSTF9SRUcpOw0KPj4gICAJcmVnICY9IH4oQlRJTlRFTF9Q
Q0lFX0NTUl9GVU5DX0NUUkxfRlVOQ19JTklUIHwgQEAgLTI1NzMsMTENCj4+ICsyNTgxLDEwNSBA
QCBzdGF0aWMgdm9pZCBidGludGVsX3BjaWVfY29yZWR1bXAoc3RydWN0IGRldmljZSAqZGV2KQ0K
Pj4gICB9DQo+PiAgICNlbmRpZg0KPj4NCj4+ICsjaWZkZWYgQ09ORklHX1BNDQo+PiArc3RhdGlj
IGludCBidGludGVsX3BjaWVfc3VzcGVuZF9sYXRlKHN0cnVjdCBkZXZpY2UgKmRldiwgcG1fbWVz
c2FnZV90DQo+PiArbWVzZykgew0KPj4gKwlzdHJ1Y3QgcGNpX2RldiAqcGRldiA9IHRvX3BjaV9k
ZXYoZGV2KTsNCj4+ICsJc3RydWN0IGJ0aW50ZWxfcGNpZV9kYXRhICpkYXRhOw0KPj4gKwlrdGlt
ZV90IHN0YXJ0Ow0KPj4gKwl1MzIgZHhzdGF0ZTsNCj4+ICsJczY0IGRlbHRhOw0KPg0KPkFwcGVu
ZCB0aGUgdW5pdCB0byB0aGUgbmFtZT8gYGRlbHRhX3VzYD8NCkFjaw0KPg0KPj4gKwlpbnQgZXJy
Ow0KPj4gKw0KPj4gKwlkYXRhID0gcGNpX2dldF9kcnZkYXRhKHBkZXYpOw0KPj4gKw0KPj4gKwlp
ZiAobWVzZy5ldmVudCA9PSBQTV9FVkVOVF9TVVNQRU5EKQ0KPj4gKwkJZHhzdGF0ZSA9IEJUSU5U
RUxfUENJRV9TVEFURV9EM19IT1Q7DQo+PiArCWVsc2UNCj4+ICsJCWR4c3RhdGUgPSBCVElOVEVM
X1BDSUVfU1RBVEVfRDNfQ09MRDsNCj4NCj5J4oCZZCB1c2UgdGhlIHRlcm5hcnkgb3BlcmF0b3Iu
DQpBY2suDQoNCj4NCj4+ICsNCj4+ICsJZGF0YS0+Z3AwX3JlY2VpdmVkID0gZmFsc2U7DQo+PiAr
DQo+PiArCXN0YXJ0ID0ga3RpbWVfZ2V0KCk7DQo+PiArDQo+PiArCS8qIFJlZmVyOiA2LjQuMTEu
NyAtPiBQbGF0Zm9ybSBwb3dlciBtYW5hZ2VtZW50ICovDQo+PiArCWJ0aW50ZWxfcGNpZV93cl9z
bGVlcF9jbnRybChkYXRhLCBkeHN0YXRlKTsNCj4+ICsJZXJyID0gd2FpdF9ldmVudF90aW1lb3V0
KGRhdGEtPmdwMF93YWl0X3EsIGRhdGEtPmdwMF9yZWNlaXZlZCwNCj4+ICsNCj5tc2Vjc190b19q
aWZmaWVzKEJUSU5URUxfREVGQVVMVF9JTlRSX1RJTUVPVVRfTVMpKTsNCj4+ICsJZGVsdGEgPSBr
dGltZV90b19ucyhrdGltZV9nZXQoKSAtIHN0YXJ0KSAvIDEwMDA7DQo+DQo+TW92ZSBpdCBiZWxv
dyByaWdodCBiZWZvcmUgYGJ0X2Rldl9pbmZvYD8NCkFjay4NCg0KPg0KPj4gKw0KPj4gKwlpZiAo
ZXJyID09IDApIHsNCj4+ICsJCWJ0X2Rldl9lcnIoZGF0YS0+aGRldiwgIlRpbWVvdXQgKCV1IG1z
KSBvbiBhbGl2ZSBpbnRlcnJ1cHQNCj5mb3IgRDMgZW50cnkiLA0KPj4gKwkJCQlCVElOVEVMX0RF
RkFVTFRfSU5UUl9USU1FT1VUX01TKTsNCj4+ICsJCXJldHVybiAtRUJVU1k7DQo+PiArCX0NCj4+
ICsJYnRfZGV2X2luZm8oZGF0YS0+aGRldiwgImRldmljZSBlbnRlcmVkIGludG8gZDMgc3RhdGUg
ZnJvbSBkMCBpbiAlbGxkDQo+dXMiLA0KPj4gKwkJICAgIGRlbHRhKTsNCj4+ICsJcmV0dXJuIDA7
DQo+PiArfQ0KPj4gKw0KPj4gK3N0YXRpYyBpbnQgYnRpbnRlbF9wY2llX3N1c3BlbmQoc3RydWN0
IGRldmljZSAqZGV2KSB7DQo+PiArCXJldHVybiBidGludGVsX3BjaWVfc3VzcGVuZF9sYXRlKGRl
diwgUE1TR19TVVNQRU5EKTsgfQ0KPj4gKw0KPj4gK3N0YXRpYyBpbnQgYnRpbnRlbF9wY2llX2hp
YmVybmF0ZShzdHJ1Y3QgZGV2aWNlICpkZXYpIHsNCj4+ICsJcmV0dXJuIGJ0aW50ZWxfcGNpZV9z
dXNwZW5kX2xhdGUoZGV2LCBQTVNHX0hJQkVSTkFURSk7IH0NCj4+ICsNCj4+ICtzdGF0aWMgaW50
IGJ0aW50ZWxfcGNpZV9mcmVlemUoc3RydWN0IGRldmljZSAqZGV2KSB7DQo+PiArCXJldHVybiBi
dGludGVsX3BjaWVfc3VzcGVuZF9sYXRlKGRldiwgUE1TR19GUkVFWkUpOyB9DQo+PiArDQo+PiAr
c3RhdGljIGludCBidGludGVsX3BjaWVfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikgew0KPj4g
KwlzdHJ1Y3QgcGNpX2RldiAqcGRldiA9IHRvX3BjaV9kZXYoZGV2KTsNCj4+ICsJc3RydWN0IGJ0
aW50ZWxfcGNpZV9kYXRhICpkYXRhOw0KPj4gKwlrdGltZV90IHN0YXJ0Ow0KPj4gKwlpbnQgZXJy
Ow0KPj4gKwlzNjQgZGVsdGE7DQo+PiArDQo+PiArCWRhdGEgPSBwY2lfZ2V0X2RydmRhdGEocGRl
dik7DQo+PiArCWRhdGEtPmdwMF9yZWNlaXZlZCA9IGZhbHNlOw0KPj4gKw0KPj4gKwlzdGFydCA9
IGt0aW1lX2dldCgpOw0KPj4gKw0KPj4gKwkvKiBSZWZlcjogNi40LjExLjcgLT4gUGxhdGZvcm0g
cG93ZXIgbWFuYWdlbWVudCAqLw0KPj4gKwlidGludGVsX3BjaWVfd3Jfc2xlZXBfY250cmwoZGF0
YSwgQlRJTlRFTF9QQ0lFX1NUQVRFX0QwKTsNCj4+ICsJZXJyID0gd2FpdF9ldmVudF90aW1lb3V0
KGRhdGEtPmdwMF93YWl0X3EsIGRhdGEtPmdwMF9yZWNlaXZlZCwNCj4+ICsNCj5tc2Vjc190b19q
aWZmaWVzKEJUSU5URUxfREVGQVVMVF9JTlRSX1RJTUVPVVRfTVMpKTsNCj4+ICsJZGVsdGEgPSBr
dGltZV90b19ucyhrdGltZV9nZXQoKSAtIHN0YXJ0KSAvIDEwMDA7DQo+PiArDQo+PiArCWlmIChl
cnIgPT0gMCkgew0KPj4gKwkJYnRfZGV2X2VycihkYXRhLT5oZGV2LCAiVGltZW91dCAoJXUgbXMp
IG9uIGFsaXZlIGludGVycnVwdA0KPmZvciBEMCBlbnRyeSIsDQo+PiArCQkJCUJUSU5URUxfREVG
QVVMVF9JTlRSX1RJTUVPVVRfTVMpOw0KPj4gKwkJcmV0dXJuIC1FQlVTWTsNCj4+ICsJfQ0KPj4g
KwlidF9kZXZfaW5mbyhkYXRhLT5oZGV2LCAiZGV2aWNlIGVudGVyZWQgaW50byBkMCBzdGF0ZSBm
cm9tIGQzIGluICVsbGQNCj51cyIsDQo+PiArCQkgICAgZGVsdGEpOw0KPj4gKwlyZXR1cm4gMDsN
Cj4+ICt9DQo+PiArDQo+PiArY29uc3Qgc3RydWN0IGRldl9wbV9vcHMgYnRpbnRlbF9wY2llX3Bt
X29wcyA9IHsNCj4+ICsJLnN1c3BlbmQgPSBidGludGVsX3BjaWVfc3VzcGVuZCwNCj4+ICsJLnJl
c3VtZSA9IGJ0aW50ZWxfcGNpZV9yZXN1bWUsDQo+PiArCS5mcmVlemUgPSBidGludGVsX3BjaWVf
ZnJlZXplLA0KPj4gKwkudGhhdyA9IGJ0aW50ZWxfcGNpZV9yZXN1bWUsDQo+PiArCS5wb3dlcm9m
ZiA9IGJ0aW50ZWxfcGNpZV9oaWJlcm5hdGUsDQo+PiArCS5yZXN0b3JlID0gYnRpbnRlbF9wY2ll
X3Jlc3VtZSwNCj4+ICt9Ow0KPj4gKyNkZWZpbmUgQlRJTlRFTFBDSUVfUE1fT1BTCSgmYnRpbnRl
bF9wY2llX3BtX29wcykNCj4+ICsjZWxzZQ0KPj4gKyNkZWZpbmUgQlRJTlRFTFBDSUVfUE1fT1BT
CU5VTEwNCj4+ICsjZW5kaWYNCj4+ICAgc3RhdGljIHN0cnVjdCBwY2lfZHJpdmVyIGJ0aW50ZWxf
cGNpZV9kcml2ZXIgPSB7DQo+PiAgIAkubmFtZSA9IEtCVUlMRF9NT0ROQU1FLA0KPj4gICAJLmlk
X3RhYmxlID0gYnRpbnRlbF9wY2llX3RhYmxlLA0KPj4gICAJLnByb2JlID0gYnRpbnRlbF9wY2ll
X3Byb2JlLA0KPj4gICAJLnJlbW92ZSA9IGJ0aW50ZWxfcGNpZV9yZW1vdmUsDQo+PiArCS5kcml2
ZXIucG0gPSBCVElOVEVMUENJRV9QTV9PUFMsDQo+PiAgICNpZmRlZiBDT05GSUdfREVWX0NPUkVE
VU1QDQo+PiAgIAkuZHJpdmVyLmNvcmVkdW1wID0gYnRpbnRlbF9wY2llX2NvcmVkdW1wDQo+PiAg
ICNlbmRpZg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWxfcGNpZS5o
DQo+PiBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWxfcGNpZS5oDQo+PiBpbmRleCAwZmE4NzZj
NWI5NTQuLjViYzY5MDA0YjY5MiAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0
aW50ZWxfcGNpZS5oDQo+PiArKysgYi9kcml2ZXJzL2JsdWV0b290aC9idGludGVsX3BjaWUuaA0K
Pj4gQEAgLTgsNiArOCw3IEBADQo+Pg0KPj4gICAvKiBDb250cm9sIGFuZCBTdGF0dXMgUmVnaXN0
ZXIoQlRJTlRFTF9QQ0lFX0NTUikgKi8NCj4+ICAgI2RlZmluZSBCVElOVEVMX1BDSUVfQ1NSX0JB
U0UJCQkoMHgwMDApDQo+PiArI2RlZmluZSBCVElOVEVMX1BDSUVfQ1NSX0hXX0JPT1RfQ09ORklH
DQo+CShCVElOVEVMX1BDSUVfQ1NSX0JBU0UgKyAweDAwMCkNCj4+ICAgI2RlZmluZSBCVElOVEVM
X1BDSUVfQ1NSX0ZVTkNfQ1RSTF9SRUcNCj4JKEJUSU5URUxfUENJRV9DU1JfQkFTRSArIDB4MDI0
KQ0KPj4gICAjZGVmaW5lIEJUSU5URUxfUENJRV9DU1JfSFdfUkVWX1JFRw0KPgkoQlRJTlRFTF9Q
Q0lFX0NTUl9CQVNFICsgMHgwMjgpDQo+PiAgICNkZWZpbmUgQlRJTlRFTF9QQ0lFX0NTUl9SRl9J
RF9SRUcNCj4JKEJUSU5URUxfUENJRV9DU1JfQkFTRSArIDB4MDlDKQ0KPj4gQEAgLTU1LDYgKzU2
LDkgQEANCj4+ICAgI2RlZmluZSBCVElOVEVMX1BDSUVfQ1NSX0JPT1RfU1RBR0VfQUxJVkUJCShC
SVQoMjMpKQ0KPj4gICAjZGVmaW5lIEJUSU5URUxfUENJRV9DU1JfQk9PVF9TVEFHRV9EM19TVEFU
RV9SRUFEWQkoQklUKDI0KSkNCj4+DQo+PiArLyogQ1NSIEhXIEJPT1QgQ09ORklHIFJlZ2lzdGVy
ICovDQo+PiArI2RlZmluZSBCVElOVEVMX1BDSUVfQ1NSX0hXX0JPT1RfQ09ORklHX0tFRVBfT04N
Cj4JKEJJVCgzMSkpDQo+PiArDQo+PiAgIC8qIFJlZ2lzdGVycyBmb3IgTVNJLVggKi8NCj4+ICAg
I2RlZmluZSBCVElOVEVMX1BDSUVfQ1NSX01TSVhfQkFTRQkJKDB4MjAwMCkNCj4+ICAgI2RlZmlu
ZSBCVElOVEVMX1BDSUVfQ1NSX01TSVhfRkhfSU5UX0NBVVNFUw0KPgkoQlRJTlRFTF9QQ0lFX0NT
Ul9NU0lYX0JBU0UgKyAweDA4MDApDQo+DQo+DQo+S2luZCByZWdhcmRzLA0KPg0KPlBhdWwNCg0K
VGhhbmtzLA0KS2lyYW4NCg0K

