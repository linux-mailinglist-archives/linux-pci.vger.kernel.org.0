Return-Path: <linux-pci+bounces-32966-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 530CEB12B60
	for <lists+linux-pci@lfdr.de>; Sat, 26 Jul 2025 18:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D96D1899409
	for <lists+linux-pci@lfdr.de>; Sat, 26 Jul 2025 16:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED1E224AEB;
	Sat, 26 Jul 2025 16:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KCz2E9cl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F65B1A08BC;
	Sat, 26 Jul 2025 16:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753546279; cv=fail; b=Ug4p19Uw8rpRnknhVtwklyuXCa5ht7a1OJCKzYDY8oIs5jcwwmiy6Jt6v0F0FKRvPS4QrrF/mtsamkz99HMxDwTOyM391yg9c6ARP52tjjJztcMTS2D3u0VhtU9s+EIdsdYMAdEZfngRk/wznq/Ax9eLgHP15gNaL6DCEf34GJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753546279; c=relaxed/simple;
	bh=BjPqUU43Ag97CsmOfzERa+vTD/M6cCfsrPIm9rnIwwQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nyOD4IT9TayFYgHB4+t+kBgUYwlf2wUe8dvyhqqFQiieq+T9DTVQiyLydNd5l7kgD+zDwKd1ik83WRg4+fTKhxw00gh255i19ERFg61CnigfTmy90Nc3XkQKs4Rju+4Qxm0FVVUslPPXoI6G3EhAV6+/hqxU++wi7WNgBGrJuks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KCz2E9cl; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753546278; x=1785082278;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BjPqUU43Ag97CsmOfzERa+vTD/M6cCfsrPIm9rnIwwQ=;
  b=KCz2E9clP4ggWQjyEpCpalFpmz/3/L437ca/d43ZLMddwuCjOmp/h/jy
   rJoDuifS5uWUmpwpie/7OURK3btBB5TpKDWed0cuFnLIeIGxLbn+4yfST
   9tMKUY89EQSLtNlMLk9gFI6tHcfSca7mmCLmNLwldxSq5YngbsVk9da3M
   fqG9fMuBcyVpjo4OQKtghcwgeurU1JoESq7B7SriJRl6r/W1nbS9W0qp+
   DXfYw9b6WrdgF31JTvMG7CaKy6s1WgvsL04Gtq6APMfBomPlqsPnv03u9
   qv+rwocx83dHOMwlTLi9Ikauk5VyMEQJECSx/pOpGUp1DcELVti6ex3Kv
   Q==;
X-CSE-ConnectionGUID: MAjYwL6tSr2iFW9KTZ3Uzw==
X-CSE-MsgGUID: Yug2wJI3QISSBYCYJ5W8vA==
X-IronPort-AV: E=McAfee;i="6800,10657,11504"; a="55555194"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="55555194"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2025 09:11:16 -0700
X-CSE-ConnectionGUID: qSoIp6I6SDudMAofY/OAhw==
X-CSE-MsgGUID: ae7SfopcT5y0XVy+F5EEiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="192519581"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2025 09:11:16 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Sat, 26 Jul 2025 09:11:15 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Sat, 26 Jul 2025 09:11:15 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.86) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Sat, 26 Jul 2025 09:11:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=si6fkXu79QPsTs2D1AOQYPMjR1378Gyg5GZDbYdlVOO4M6WWuzK988Qw5d+94h+esaO1ycGgdi9P7zAohHgdxpzpCO1bWWqeNsKoxhLSymjnyIVII9kfzzY1aIEJ1M9REDE+/PopqbVHY8nla2OztwQ5DlZMTVj9X7FZCk9yP8nFg6yA4dNPE/X3SEmqDvdCm4bUW1vYtYH3JRWwM6SRYegJFAuO8XkarA3125pFfw+Kxbj4ENHVYnU3XuD19ea9qsI9Xq+FZUuFpXH2yDPcHZZVeyynmewYFxyeeq6PHavwKONjN194XCIsby0LR/0Ba3CAdnBaA4YaR/DQgdbFYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BjPqUU43Ag97CsmOfzERa+vTD/M6cCfsrPIm9rnIwwQ=;
 b=EA3aERiFWB5bZf8YyhOsYzo67hLibDgonF4o6EgBzmN+NdaO6fWPW8ZETwmg5jJjQ0BO9xNOxU7vSpfH/8CoRIsSneAzIHgnvjXljT+LAmncgOr3xP6FdkN/FKTfmH2lCY/EYrhmjKwFZErg7QG0UjMHAQavMsR6CybdtmIrsY3FpozjzCHJBsctFmHbA+EL9nsojD4YOJIW12IVRyPsiOHnaSmw01KSaQb8Vbpws9flViSzBUgiJk3KKRibD4Jsdkqz+Bh78Op/hEdktvI6ofUn4loLSa3/gBAVe0PnR7IXAfEhOtjePpuxB0vYF8+sxJYF9yg51dIBje/x1s8HCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by PH0PR11MB4837.namprd11.prod.outlook.com (2603:10b6:510:41::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.25; Sat, 26 Jul
 2025 16:10:45 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010%2]) with mapi id 15.20.8964.019; Sat, 26 Jul 2025
 16:10:45 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>, "Tumkur Narayan,
 Chethan" <chethan.tumkur.narayan@intel.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "Devegowda, Chandrashekar"
	<chandrashekar.devegowda@intel.com>
Subject: RE: [PATCH v6] Bluetooth: btintel_pcie: Add support for _suspend() /
 _resume()
Thread-Topic: [PATCH v6] Bluetooth: btintel_pcie: Add support for _suspend() /
 _resume()
Thread-Index: AQHb/UBu4h3C8C17uk+M4vpfN3sVfrRC3IaAgAG2EfA=
Date: Sat, 26 Jul 2025 16:10:45 +0000
Message-ID: <PH0PR11MB75853613AF4D8D11EE444B9AF558A@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20250725090133.1358775-1-kiran.k@intel.com>
 <CABBYNZLJyT=z5gLCArU6pMo1sVq-0PSPpvV5yYXHCaxCp2GOZg@mail.gmail.com>
In-Reply-To: <CABBYNZLJyT=z5gLCArU6pMo1sVq-0PSPpvV5yYXHCaxCp2GOZg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|PH0PR11MB4837:EE_
x-ms-office365-filtering-correlation-id: cee90e8a-8fe4-4372-0779-08ddcc5efa67
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MVJud0FmbENoZTNyYmdPaGpaNW83UUVGaVArcHBKaGJEMG45alFCc2M2bjR4?=
 =?utf-8?B?ZWorOTVOUWcranJJeGxkTFpvbnN4Q3ZRSWF6ZHlzVlp2WXlRd0JlS2J1U05R?=
 =?utf-8?B?TGxXTEZ3eGFlRDNjVEZrWXZ3azRpSnNhQkdzUUhyeGVpczg1REYwVjdrY2l0?=
 =?utf-8?B?R2lkRDE5MEVmckZ4aUMwZmJmRUhabXRKcWxEWkQzb2pBQkdnTnlhSEwzSWl3?=
 =?utf-8?B?SS91WWIzYzJzeFpPUDh2WmhwMW5jZFBjcHl1NXZJSDF0QmlUbnhvR0xLUVJ0?=
 =?utf-8?B?aFpkd1NObDNmTUFkTW5sVVM4VTJiaG9uZ3YxeXVwOG1PTVJtY3UvRXB0TDVm?=
 =?utf-8?B?Sk5UV1JTRmNOZVdNMytNcUkzNVUrR1grOUx1Z2VsdUV4ckYyYmJBQ3NCWTRh?=
 =?utf-8?B?MTF3L0VkSHNyUGxoZlgzOHdIZjJuN1dTYjI0YW9MSDdObkplbDdwQW9BOGta?=
 =?utf-8?B?TDdHQ1JtdjFXVVlVZ3VubkZScEQxVXZYMVNGaVJrQ3ZBdThaaXBNd1pkd0RN?=
 =?utf-8?B?OWZqeWs5RTdZdnVhWStnL1RrbVdBZ2dBeVJvN3pXblVXbDM0amQ4UGZkVFZa?=
 =?utf-8?B?Q04xM2tlQmdWaWx5a1ZISUl1ZUtncGgyQ3U2Q0RaNEhXcjBpblNOS1Q5MnIw?=
 =?utf-8?B?R1pSdG53OWptR3R1YjZmQ2ZKTTNIOGR3Z1dCZlV1WUJtN0lMS0grTUQrMWh4?=
 =?utf-8?B?SVRnc2VBcThaVnFxVlk1ME1hTE1aeXJaTUpiR2lOY2JFYzdMZTAzRHhGSHVl?=
 =?utf-8?B?QkVzcWh6ZmI3WnhUMEdPYkNWaWJGRGM5Q254MzZaOCtWN1h6bG8xQkNMZEFh?=
 =?utf-8?B?VlVMVGFTUFVmeFdGb0hxbmVmVU1ybmxKRGRZR2FDMy9zam9Xa0c3VHc0YTVS?=
 =?utf-8?B?TGFNaCtUN09jT0dtbjZxWUZYeDRBN0pVOTNHdGVEQ2RTcjZuc0hVREZNeUpj?=
 =?utf-8?B?NURzQm9YSzRKRmNXNzFDNEU1ZTJQZkdpZ0VhYTRlWlM3c1VuZjBRcVBFYXFV?=
 =?utf-8?B?ejFmTmV4OEc3M1FrVkNWdFJiV3V1S3REQlJuR2ppZ25MUG1WSU1mcGJZNko0?=
 =?utf-8?B?VExEbkhyZ1R3ZWhSRkQyZjBJdlVFeUNmL2ZiUGpNL1laakFjZmVKN1ZMYTMv?=
 =?utf-8?B?RnFseGRNTHdsdkJVYlAwd3gwNlZrbzhEcnZKZTVaSXFzREh4N3dRREVKb0Vu?=
 =?utf-8?B?bXdYZitUMHY2eFBxZnYzeFErNHNoU2tOQVpxVlRkRDUzZFVKWW5ORDFLNEhL?=
 =?utf-8?B?dVVNTlFXQUprOUVoQnQ1d2llRTIyZG1XbmV6MkNiL2R0d1lyREc4aXR3RjFm?=
 =?utf-8?B?bkVPbFhsYXNOK1VybnY1Uy9aelJRcEdnN0dQb3FLRjBFQ1lDTzNaUTZ4RlY3?=
 =?utf-8?B?SXhLWkpJR1NJbnB2RkwzQ0JJbWFZaFJ5MEV2Y2UyNW94RW4zVE1vMHZrdkJq?=
 =?utf-8?B?a2d5MEpzQ29OY25VTVlHd2xVa1cwVjlZYWdUU0k1K1lBcnJaaXVjejBoQnNi?=
 =?utf-8?B?MVh3NDBBa2JVTzVpRW5FQUtpQktSNFd6dXRJbEtobkI0b1RDNGdjcFQ2R3Bo?=
 =?utf-8?B?dUhoYW03WWdRcldRbUZCTXJXLzJBNmdPb0Y0VFY5VEJCTEp1VWRzWUxkWXc0?=
 =?utf-8?B?aGlISmRWZktyNXB1ekJISmk5eENzWjBla08vSkI5UTl3S3pVWEJnREtHRVN6?=
 =?utf-8?B?ZTh6cjdaeUY3VEhNTTJmK1pPTDczcUlNTUhCMFNvWjd3SUsvaVJpTFUwTnRE?=
 =?utf-8?B?bUNWaE9VdDRYNkh2Z0tMYTZZUFdIRWNSWm1QSDFRTzhMVzBFT0tKMDh4WExl?=
 =?utf-8?B?SzF3amJEMG5OdlVQcm1XMFRuZU5OQ0JmNTA3UmxnbWFDSW1JZWxjNXRzdjFk?=
 =?utf-8?B?MUpweVh0YzA5cTRPdnFnTVROR0lHbHJLQ0owa05FWUdkZE51T2pmQVNuUkVv?=
 =?utf-8?B?NVp0VmV3T1UvM0dTaGswZ1JOcDBMbVl1ckhHSDBlZTVSWFdseHFGbVhmMnlH?=
 =?utf-8?B?WVFWNktsT2NRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YjU1SUk2WVVHRHVmZGY4Ly8zTEJNcFA2clE3Q3h1Y0ZLTHptRW5DK09LSTFS?=
 =?utf-8?B?YjFmeVBSUEdaTTF4elhPWW5kdERMOWJ2TU53b2lXTGl4d3F4dzk1Z0hmcXI4?=
 =?utf-8?B?diszZmRPWTJTYS9tZ0xQY0Vxem15M2NveHhtM1ZJUTJhZk9pSHQ4Z3NuNGZH?=
 =?utf-8?B?cElUTzZiTlZ2M1E5V3JSN1N3NHFHMTlMSlVHN2Nvbjc0UzFET3ptYkxlLzBi?=
 =?utf-8?B?emU3eHFLcTM4dlcrTTZacm15MVdBM1RzVWxyTzRiVlh2cEFpN21aMVExZlRM?=
 =?utf-8?B?MDRqbVlRWjZtNWRnUTQwdVFSdm8vN2EwS0lvMmJGTVIreDRQTG52L0U4THlW?=
 =?utf-8?B?MU5jUlJiTU4xcXRrajNEQ1VWQjB6UGVFWVdkMWlxWUd4QUhlMjBwcmNIWGE0?=
 =?utf-8?B?NTZlNW44aTdWQVdzQSs5Ukh3Q0owNGd6UzE4c2JmZGNMNkxBbHdtVG9SN29p?=
 =?utf-8?B?amdDTHlTb29uQlI1V01PSzk0N2VZYjRUcjNVb1J3R3VVWXdPbkdMYVdoaWxl?=
 =?utf-8?B?UHhsdXhseS80TS9RWm1seTZrVzdXL2NrKzRTU25mazNUU1kvcGJZUGFQZ3E3?=
 =?utf-8?B?OHFFL2pIaVpLQ0F4bmJQOGNXR3RVU3k3MTdKVEQvZWEzdEQrRENaWE1FejVI?=
 =?utf-8?B?Zkt1T21YRE0remd0UVBXWEVVdVNPSnEycnA3ejdCcm15YVRzVFhISVMySDA2?=
 =?utf-8?B?VGg4V0tFZnZCeWxiTW50NGgzT1FOejhaVEY5T01xK3h1SE9aQXhhVU5hTndq?=
 =?utf-8?B?LzJ5dzV1MDV5VTRTdDVUd2cxMXZGdlJwTXRmWDdPdUgrMGVkUDkzOERQQVFy?=
 =?utf-8?B?ajdYVlNlSlVoMG1wcDRCdkVWTkN6dHFjSmQvaHlyeVZXWGRkZW1tQTEyR0ZQ?=
 =?utf-8?B?TWRyb2dGTzdZQ0JxeWVSSkFIa0lieTlFTFZVRXQrSFJBMWVTZ1dBZ2FjSExx?=
 =?utf-8?B?QTlXc281S3d6MWpNUXJQU3Vyd2xYSVZ0bzR1UXRKNmNmWkxFNWwzN2dzUGhu?=
 =?utf-8?B?RnVJZjFGNnVKQTlJWkI1UDVCVm1vL3NtYVlCdWJOMFlQZmpZQncxcGtlNTQ5?=
 =?utf-8?B?NnVZamdFdTJGTTU0ZXJJOUJld3puSUlhQWNoS2RxeTEvbFdHU1A5NUZ1bERl?=
 =?utf-8?B?R2VGVUovMlZtclNkUSszODU0aGRROVdiczN5dTVvejU3QWVMSmlGeTU0ODdu?=
 =?utf-8?B?Q3J1cnJaRXlCYTFmMkJKM3hjajdITHY0RmZpdi85dUNLTGZBUlBxcysxaDFU?=
 =?utf-8?B?WjRUQTVsUGhycUdhZENUUTlGUjBxQWZFTkhYRUF3YW5FZzlHeG1aZFJDcmw5?=
 =?utf-8?B?UG44cmR2aWxGSFNtM29lVGNwbFRmVUl5MnZWMmU4WUVGcnovRTBqNnpmK0tO?=
 =?utf-8?B?bTh2eVE2VTUxR0lreWtENVR1WC9qeVIzc1IxbUhBMU4vUzM2VXhNQXhpcGor?=
 =?utf-8?B?dDRtKzlmOEtZYlc1UkpiUTErSkZJSEtaMkxjOTRhT0FvUThZcGpUNDU4UC90?=
 =?utf-8?B?RUIvVm9ML1o1TGNxOGltbE9STWN6b3lLZFEyM2puUzU2Yk9DMk44ajN6b0py?=
 =?utf-8?B?emdOamJoZmNCV2FIMHY5cVBleVI3TWxDVW5RWHFrTk1CT3VRdjc4N2RlWFBN?=
 =?utf-8?B?NkZCc0dtWUdNTXFBcFRmSVVXQ0tqRDMya2hHQXNpTFJVMWNGNUlPckljR2hs?=
 =?utf-8?B?RlQxN2xnSDdYVEs3ak9rdnZFTWt3SklSL2padFlacXdLZ0cvdVpNUCtRVGdV?=
 =?utf-8?B?V083TVAySGVUeENuSjZpNkJIUW05dGFuOU0rUHR0MXRyK09qSm5DYUI4c2E2?=
 =?utf-8?B?cUFsNlVueWRrU1laOWRnNFh5enBuQlo4ZDIrbGRPdjJJbWk2Rk9hdkRKMEhx?=
 =?utf-8?B?ZjR0MFI5UjU2WmpMSGhXMmJoNm0vdUM5c0tDRkdwTVRHaWhGMDdtWHZWSnpv?=
 =?utf-8?B?eTJqNFQxZFUzTlVkdFJWZkpTWlQxRDZ3YmdMa1pKZFpoeEdRa3g5QWdGWktT?=
 =?utf-8?B?RUhycklxZUM2ZmM0UEtVR2p0UnlYTmZXSHFaSnpuRCszNEIrRmRsVWZsNGxU?=
 =?utf-8?B?YW54VS9zc3djTjZTam00VG00YURNNElMUlJzN0R6OHE1WnFYTGhRd1ByaVIr?=
 =?utf-8?Q?ayuU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cee90e8a-8fe4-4372-0779-08ddcc5efa67
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2025 16:10:45.6144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 28QBaooFhw709ald6ogl8SYPYKAmGJ5hLU18egFWxXF8FP6mKELnuI8dky9Z8BRUtExQ3ii00q0LYOkyN+JgLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4837
X-OriginatorOrg: intel.com

SGkgTHVpeiwNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogTHVpeiBBdWd1
c3RvIHZvbiBEZW50eiA8bHVpei5kZW50ekBnbWFpbC5jb20+DQo+U2VudDogRnJpZGF5LCBKdWx5
IDI1LCAyMDI1IDc6MjQgUE0NCj5UbzogSywgS2lyYW4gPGtpcmFuLmtAaW50ZWwuY29tPg0KPkNj
OiBsaW51eC1ibHVldG9vdGhAdmdlci5rZXJuZWwub3JnOyBTcml2YXRzYSwgUmF2aXNoYW5rYXIN
Cj48cmF2aXNoYW5rYXIuc3JpdmF0c2FAaW50ZWwuY29tPjsgVHVta3VyIE5hcmF5YW4sIENoZXRo
YW4NCj48Y2hldGhhbi50dW1rdXIubmFyYXlhbkBpbnRlbC5jb20+OyBiaGVsZ2Fhc0Bnb29nbGUu
Y29tOyBsaW51eC0NCj5wY2lAdmdlci5rZXJuZWwub3JnOyBEZXZlZ293ZGEsIENoYW5kcmFzaGVr
YXINCj48Y2hhbmRyYXNoZWthci5kZXZlZ293ZGFAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjZdIEJsdWV0b290aDogYnRpbnRlbF9wY2llOiBBZGQgc3VwcG9ydCBmb3IgX3N1c3Bl
bmQoKSAvDQo+X3Jlc3VtZSgpDQo+DQo+SGkgS2lyYW4sDQo+DQo+T24gRnJpLCBKdWwgMjUsIDIw
MjUgYXQgNDo0NeKAr0FNIEtpcmFuIEsgPGtpcmFuLmtAaW50ZWwuY29tPiB3cm90ZToNCj4+DQo+
PiBGcm9tOiBDaGFuZHJhc2hla2FyIERldmVnb3dkYSA8Y2hhbmRyYXNoZWthci5kZXZlZ293ZGFA
aW50ZWwuY29tPg0KPj4NCj4+IFRoaXMgcGF0Y2ggaW1wbGVtZW50cyBfc3VzcGVuZCgpIGFuZCBf
cmVzdW1lKCkgZnVuY3Rpb25zIGZvciB0aGUNCj4+IEJsdWV0b290aCBjb250cm9sbGVyLiBXaGVu
IHRoZSBzeXN0ZW0gZW50ZXJzIGEgc3VzcGVuZGVkIHN0YXRlLCB0aGUNCj4+IGRyaXZlciBub3Rp
ZmllcyB0aGUgY29udHJvbGxlciB0byBwZXJmb3JtIG5lY2Vzc2FyeSBob3VzZWtlZXBpbmcgdGFz
a3MNCj4+IGJ5IHdyaXRpbmcgdG8gdGhlIHNsZWVwIGNvbnRyb2wgcmVnaXN0ZXIgYW5kIHdhaXRz
IGZvciBhbiBhbGl2ZQ0KPj4gaW50ZXJydXB0LiBUaGUgZmlybXdhcmUgcmFpc2VzIHRoZSBhbGl2
ZSBpbnRlcnJ1cHQgd2hlbiBpdCBoYXMNCj4+IHRyYW5zaXRpb25lZCB0byB0aGUgRDMgc3RhdGUu
IFRoZSBzYW1lIGZsb3cgb2NjdXJzIHdoZW4gdGhlIHN5c3RlbQ0KPj4gcmVzdW1lcy4NCj4+DQo+
PiBDb21tYW5kIHRvIHRlc3QgaG9zdCBpbml0aWF0ZWQgd2FrZXVwIGFmdGVyIDYwIHNlY29uZHMg
c3VkbyBydGN3YWtlIC1tDQo+PiBtZW0gLXMgNjANCj4+DQo+PiBkbWVzZyBsb2cgKHRlc3RlZCBv
biBXaGFsZSBQZWFrMiBvbiBQYW50aGVyIExha2UgcGxhdGZvcm0pIE9uIHN5c3RlbQ0KPj4gc3Vz
cGVuZDoNCj4+IFtGcmkgSnVsIDI1IDExOjA1OjM3IDIwMjVdIEJsdWV0b290aDogaGNpMDogZGV2
aWNlIGVudGVyZWQgaW50byBkMw0KPj4gc3RhdGUgZnJvbSBkMCBpbiA4MCB1cw0KPj4NCj4+IE9u
IHN5c3RlbSByZXN1bWU6DQo+PiBbRnJpIEp1bCAyNSAxMTowNjozNiAyMDI1XSBCbHVldG9vdGg6
IGhjaTA6IGRldmljZSBlbnRlcmVkIGludG8gZDANCj4+IHN0YXRlIGZyb20gZDMgaW4gNzExNyB1
cw0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IENoYW5kcmFzaGVrYXIgRGV2ZWdvd2RhDQo+PiA8Y2hh
bmRyYXNoZWthci5kZXZlZ293ZGFAaW50ZWwuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogS2lyYW4g
SyA8a2lyYW4ua0BpbnRlbC5jb20+DQo+PiAtLS0NCj4+IGNoYW5nZXMgaW4gdjY6DQo+PiAgICAg
IC0gcy9kZWx0YS9kZWx0YV91cy9nDQo+PiAgICAgIC0gcy9DT05GSUdfUE0vQ09ORklHX1BNX1NM
RUVQL2cNCj4+ICAgICAgLSB1c2UgcG1fc2xlZXBfcHIoKS9wbV9zdHIoKSB0byBhdm9pZCAjaWZk
ZWZzDQo+PiAgICAgIC0gcmVtb3ZlIHRoZSBjb2RlIHRvIHNldCBwZXJzaXN0YW5jZSBtb2RlIGFz
IGl0cyBub3QgcmVsZXZhbnQgdG8NCj4+IHRoaXMgcGF0Y2gNCj4+DQo+PiBjaGFuZ2VzIGluIHY1
Og0KPj4gICAgICAtIHJlZmFjdG9yIF9zdXNwZW5kKCkgLyBfcmVzdW1lKCkgdG8gc2V0IHRoZSBE
M0hPVC9EM0NPTEQgYmFzZWQgb24NCj5wb3dlcg0KPj4gICAgICAgIGV2ZW50DQo+PiAgICAgIC0g
cmVtb3ZlIFNJTVBMRV9ERVZfUE1fT1BTIGFuZCBkZWZpbmUgdGhlIHJlcXVpcmVkIHBtX29wcyBj
YWxsYmFjaw0KPj4gICAgICAgIGZ1bmN0aW9ucw0KPj4NCj4+IGNoYW5nZXMgaW4gdjQ6DQo+PiAg
ICAgIC0gTW92ZWQgZG9jdW1lbnQgYW5kIHNlY3Rpb24gZGV0YWlscyBmcm9tIHRoZSBjb21taXQg
bWVzc2FnZSBhcw0KPmNvbW1lbnQgaW4gY29kZS4NCj4+DQo+PiBjaGFuZ2VzIGluIHYzOg0KPj4g
ICAgICAtIENvcnJlY3RlZCB0aGUgdHlwbydzDQo+PiAgICAgIC0gVXBkYXRlZCB0aGUgQ0MgbGlz
dCBhcyBzdWdnZXN0ZWQuDQo+PiAgICAgIC0gQ29ycmVjdGVkIHRoZSBmb3JtYXQgc3BlY2lmaWVy
cyBpbiB0aGUgbG9ncy4NCj4+DQo+PiBjaGFuZ2VzIGluIHYyOg0KPj4gICAgICAtIFVwZGF0ZWQg
dGhlIGNvbW1pdCBtZXNzYWdlIHdpdGggdGVzdCBzdGVwcyBhbmQgbG9ncy4NCj4+ICAgICAgLSBB
ZGRlZCBsb2dzIHRvIGluY2x1ZGUgdGhlIHRpbWVvdXQgbWVzc2FnZS4NCj4+ICAgICAgLSBGaXhl
ZCBhIHBvdGVudGlhbCByYWNlIGNvbmRpdGlvbiBkdXJpbmcgc3VzcGVuZCBhbmQgcmVzdW1lLg0K
Pj4NCj4+ICBkcml2ZXJzL2JsdWV0b290aC9idGludGVsX3BjaWUuYyB8IDkwDQo+PiArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4gIDEgZmlsZSBjaGFuZ2VkLCA5MCBpbnNlcnRp
b25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWxfcGNp
ZS5jDQo+PiBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWxfcGNpZS5jDQo+PiBpbmRleCA2ZTdi
YmJkMzUyNzkuLmM0MTk1MjE0OTNmZSAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvYmx1ZXRvb3Ro
L2J0aW50ZWxfcGNpZS5jDQo+PiArKysgYi9kcml2ZXJzL2JsdWV0b290aC9idGludGVsX3BjaWUu
Yw0KPj4gQEAgLTI1NzMsMTEgKzI1NzMsMTAxIEBAIHN0YXRpYyB2b2lkIGJ0aW50ZWxfcGNpZV9j
b3JlZHVtcChzdHJ1Y3QNCj4+IGRldmljZSAqZGV2KSAgfSAgI2VuZGlmDQo+Pg0KPj4gKyNpZmRl
ZiBDT05GSUdfUE1fU0xFRVANCj4+ICtzdGF0aWMgaW50IGJ0aW50ZWxfcGNpZV9zdXNwZW5kX2xh
dGUoc3RydWN0IGRldmljZSAqZGV2LCBwbV9tZXNzYWdlX3QNCj4+ICttZXNnKSB7DQo+PiArICAg
ICAgIHN0cnVjdCBwY2lfZGV2ICpwZGV2ID0gdG9fcGNpX2RldihkZXYpOw0KPj4gKyAgICAgICBz
dHJ1Y3QgYnRpbnRlbF9wY2llX2RhdGEgKmRhdGE7DQo+PiArICAgICAgIGt0aW1lX3Qgc3RhcnQ7
DQo+PiArICAgICAgIHUzMiBkeHN0YXRlOw0KPj4gKyAgICAgICBzNjQgZGVsdGFfdXM7DQo+PiAr
ICAgICAgIGludCBlcnI7DQo+PiArDQo+PiArICAgICAgIGRhdGEgPSBwY2lfZ2V0X2RydmRhdGEo
cGRldik7DQo+PiArDQo+PiArICAgICAgIGR4c3RhdGUgPSAobWVzZy5ldmVudCA9PSBQTV9FVkVO
VF9TVVNQRU5EID8NCj4+ICsgICAgICAgICAgICAgICAgICBCVElOVEVMX1BDSUVfU1RBVEVfRDNf
SE9UIDoNCj4+ICsgQlRJTlRFTF9QQ0lFX1NUQVRFX0QzX0NPTEQpOw0KPj4gKw0KPj4gKyAgICAg
ICBkYXRhLT5ncDBfcmVjZWl2ZWQgPSBmYWxzZTsNCj4+ICsNCj4+ICsgICAgICAgc3RhcnQgPSBr
dGltZV9nZXQoKTsNCj4+ICsNCj4+ICsgICAgICAgLyogUmVmZXI6IDYuNC4xMS43IC0+IFBsYXRm
b3JtIHBvd2VyIG1hbmFnZW1lbnQgKi8NCj4+ICsgICAgICAgYnRpbnRlbF9wY2llX3dyX3NsZWVw
X2NudHJsKGRhdGEsIGR4c3RhdGUpOw0KPj4gKyAgICAgICBlcnIgPSB3YWl0X2V2ZW50X3RpbWVv
dXQoZGF0YS0+Z3AwX3dhaXRfcSwgZGF0YS0+Z3AwX3JlY2VpdmVkLA0KPj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgbXNlY3NfdG9famlmZmllcyhCVElOVEVMX0RFRkFVTFRfSU5U
Ul9USU1FT1VUX01TKSk7DQo+PiArICAgICAgIGlmIChlcnIgPT0gMCkgew0KPj4gKyAgICAgICAg
ICAgICAgIGJ0X2Rldl9lcnIoZGF0YS0+aGRldiwgIlRpbWVvdXQgKCV1IG1zKSBvbiBhbGl2ZSBp
bnRlcnJ1cHQgZm9yIEQzDQo+ZW50cnkiLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBCVElOVEVMX0RFRkFVTFRfSU5UUl9USU1FT1VUX01TKTsNCj4+ICsgICAgICAgICAgICAg
ICByZXR1cm4gLUVCVVNZOw0KPj4gKyAgICAgICB9DQo+PiArDQo+PiArICAgICAgIGRlbHRhX3Vz
ID0ga3RpbWVfdG9fbnMoa3RpbWVfZ2V0KCkgLSBzdGFydCkgLyAxMDAwOw0KPj4gKyAgICAgICBi
dF9kZXZfaW5mbyhkYXRhLT5oZGV2LCAiZGV2aWNlIGVudGVyZWQgaW50byBkMyBzdGF0ZSBmcm9t
IGQwIGluICVsbGQNCj51cyIsDQo+PiArICAgICAgICAgICAgICAgICAgIGRlbHRhX3VzKTsNCj4+
ICsgICAgICAgcmV0dXJuIDA7DQo+PiArfQ0KPj4gKw0KPj4gK3N0YXRpYyBpbnQgYnRpbnRlbF9w
Y2llX3N1c3BlbmQoc3RydWN0IGRldmljZSAqZGV2KSB7DQo+PiArICAgICAgIHJldHVybiBidGlu
dGVsX3BjaWVfc3VzcGVuZF9sYXRlKGRldiwgUE1TR19TVVNQRU5EKTsgfQ0KPj4gKw0KPj4gK3N0
YXRpYyBpbnQgYnRpbnRlbF9wY2llX2hpYmVybmF0ZShzdHJ1Y3QgZGV2aWNlICpkZXYpIHsNCj4+
ICsgICAgICAgcmV0dXJuIGJ0aW50ZWxfcGNpZV9zdXNwZW5kX2xhdGUoZGV2LCBQTVNHX0hJQkVS
TkFURSk7IH0NCj4+ICsNCj4+ICtzdGF0aWMgaW50IGJ0aW50ZWxfcGNpZV9mcmVlemUoc3RydWN0
IGRldmljZSAqZGV2KSB7DQo+PiArICAgICAgIHJldHVybiBidGludGVsX3BjaWVfc3VzcGVuZF9s
YXRlKGRldiwgUE1TR19GUkVFWkUpOyB9DQo+PiArDQo+PiArc3RhdGljIGludCBidGludGVsX3Bj
aWVfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikgew0KPj4gKyAgICAgICBzdHJ1Y3QgcGNpX2Rl
diAqcGRldiA9IHRvX3BjaV9kZXYoZGV2KTsNCj4+ICsgICAgICAgc3RydWN0IGJ0aW50ZWxfcGNp
ZV9kYXRhICpkYXRhOw0KPj4gKyAgICAgICBrdGltZV90IHN0YXJ0Ow0KPj4gKyAgICAgICBpbnQg
ZXJyOw0KPj4gKyAgICAgICBzNjQgZGVsdGFfdXM7DQo+PiArDQo+PiArICAgICAgIGRhdGEgPSBw
Y2lfZ2V0X2RydmRhdGEocGRldik7DQo+PiArICAgICAgIGRhdGEtPmdwMF9yZWNlaXZlZCA9IGZh
bHNlOw0KPj4gKw0KPj4gKyAgICAgICBzdGFydCA9IGt0aW1lX2dldCgpOw0KPj4gKw0KPj4gKyAg
ICAgICAvKiBSZWZlcjogNi40LjExLjcgLT4gUGxhdGZvcm0gcG93ZXIgbWFuYWdlbWVudCAqLw0K
Pj4gKyAgICAgICBidGludGVsX3BjaWVfd3Jfc2xlZXBfY250cmwoZGF0YSwgQlRJTlRFTF9QQ0lF
X1NUQVRFX0QwKTsNCj4+ICsgICAgICAgZXJyID0gd2FpdF9ldmVudF90aW1lb3V0KGRhdGEtPmdw
MF93YWl0X3EsIGRhdGEtPmdwMF9yZWNlaXZlZCwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIG1zZWNzX3RvX2ppZmZpZXMoQlRJTlRFTF9ERUZBVUxUX0lOVFJfVElNRU9VVF9N
UykpOw0KPj4gKyAgICAgICBpZiAoZXJyID09IDApIHsNCj4+ICsgICAgICAgICAgICAgICBidF9k
ZXZfZXJyKGRhdGEtPmhkZXYsICJUaW1lb3V0ICgldSBtcykgb24gYWxpdmUgaW50ZXJydXB0IGZv
ciBEMA0KPmVudHJ5IiwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQlRJTlRF
TF9ERUZBVUxUX0lOVFJfVElNRU9VVF9NUyk7DQo+PiArICAgICAgICAgICAgICAgcmV0dXJuIC1F
QlVTWTsNCj4+ICsgICAgICAgfQ0KPj4gKw0KPj4gKyAgICAgICBkZWx0YV91cyA9IGt0aW1lX3Rv
X25zKGt0aW1lX2dldCgpIC0gc3RhcnQpIC8gMTAwMDsNCj4+ICsgICAgICAgYnRfZGV2X2luZm8o
ZGF0YS0+aGRldiwgImRldmljZSBlbnRlcmVkIGludG8gZDAgc3RhdGUgZnJvbSBkMyBpbiAlbGxk
DQo+dXMiLA0KPj4gKyAgICAgICAgICAgICAgICAgICBkZWx0YV91cyk7DQo+PiArICAgICAgIHJl
dHVybiAwOw0KPj4gK30NCj4+ICsNCj4+ICtjb25zdCBzdHJ1Y3QgZGV2X3BtX29wcyBidGludGVs
X3BjaWVfcG1fb3BzID0gew0KPj4gKyAgICAgICAuc3VzcGVuZCA9IHBtX3NsZWVwX3B0cihidGlu
dGVsX3BjaWVfc3VzcGVuZCksDQo+PiArICAgICAgIC5yZXN1bWUgPSBwbV9zbGVlcF9wdHIoYnRp
bnRlbF9wY2llX3Jlc3VtZSksDQo+PiArICAgICAgIC5mcmVlemUgPSBwbV9zbGVlcF9wdHIoYnRp
bnRlbF9wY2llX2ZyZWV6ZSksDQo+PiArICAgICAgIC50aGF3ID0gcG1fc2xlZXBfcHRyKGJ0aW50
ZWxfcGNpZV9yZXN1bWUpLA0KPj4gKyAgICAgICAucG93ZXJvZmYgPSBwbV9zbGVlcF9wdHIoYnRp
bnRlbF9wY2llX2hpYmVybmF0ZSksDQo+PiArICAgICAgIC5yZXN0b3JlID0gcG1fc2xlZXBfcHRy
KGJ0aW50ZWxfcGNpZV9yZXN1bWUpLA0KPj4gK307DQo+PiArI2VuZGlmDQo+PiArDQo+PiAgc3Rh
dGljIHN0cnVjdCBwY2lfZHJpdmVyIGJ0aW50ZWxfcGNpZV9kcml2ZXIgPSB7DQo+PiAgICAgICAg
IC5uYW1lID0gS0JVSUxEX01PRE5BTUUsDQo+PiAgICAgICAgIC5pZF90YWJsZSA9IGJ0aW50ZWxf
cGNpZV90YWJsZSwNCj4+ICAgICAgICAgLnByb2JlID0gYnRpbnRlbF9wY2llX3Byb2JlLA0KPj4g
ICAgICAgICAucmVtb3ZlID0gYnRpbnRlbF9wY2llX3JlbW92ZSwNCj4+ICsgICAgICAgLmRyaXZl
ci5wbSA9IHBtX3B0cigmYnRpbnRlbF9wY2llX3BtX29wcyksDQo+DQo+VGhpcyBkb2Vzbid0IHNl
ZW0gcXVpdGUgcmlnaHQsIGJ0aW50ZWxfcGNpZV9wbV9vcHMgaXMgYmVoaW5kDQo+Q09ORklHX1BN
X1NMRUVQIG5vdCBqdXN0IENPTkZJR19QTSwgc28gaXQgd291bGQgYmUgdW5kZWZpbmVkIGlmIGp1
c3QNCj5DT05GSUdfUE0gaXMgc2V0LCBzbyB3ZSBtaWdodCBhcyB3ZWxsIGRvOg0KPg0KQWdyZWUu
ICBJIHdpbGwgcmVtb3ZlIHRoZSB1c2FnZSBvZiBDT05GSUdfUE1fU0xFRVAgYW5kIGluc3RlYWQg
cmVseSBvbiBwbV9zbGVlcF9wdHIoKSBhbmQgcG1fcHRyKCkuDQoNCj5kaWZmIC0tZ2l0IGEvZHJp
dmVycy9ibHVldG9vdGgvYnRpbnRlbF9wY2llLmMgYi9kcml2ZXJzL2JsdWV0b290aC9idGludGVs
X3BjaWUuYw0KPmluZGV4IDViMzJmNWE2YjBiMC4uMmYxYjFiZTk0MDgwIDEwMDY0NA0KPi0tLSBh
L2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWxfcGNpZS5jDQo+KysrIGIvZHJpdmVycy9ibHVldG9v
dGgvYnRpbnRlbF9wY2llLmMNCj5AQCAtMjY1NCwxMiArMjY1NCwxMiBAQCBzdGF0aWMgaW50IGJ0
aW50ZWxfcGNpZV9yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2KQ0KPn0NCj4NCj4gY29uc3Qgc3Ry
dWN0IGRldl9wbV9vcHMgYnRpbnRlbF9wY2llX3BtX29wcyA9IHsNCj4tICAgICAgIC5zdXNwZW5k
ID0gcG1fc2xlZXBfcHRyKGJ0aW50ZWxfcGNpZV9zdXNwZW5kKSwNCj4tICAgICAgIC5yZXN1bWUg
PSBwbV9zbGVlcF9wdHIoYnRpbnRlbF9wY2llX3Jlc3VtZSksDQo+LSAgICAgICAuZnJlZXplID0g
cG1fc2xlZXBfcHRyKGJ0aW50ZWxfcGNpZV9mcmVlemUpLA0KPi0gICAgICAgLnRoYXcgPSBwbV9z
bGVlcF9wdHIoYnRpbnRlbF9wY2llX3Jlc3VtZSksDQo+LSAgICAgICAucG93ZXJvZmYgPSBwbV9z
bGVlcF9wdHIoYnRpbnRlbF9wY2llX2hpYmVybmF0ZSksDQo+LSAgICAgICAucmVzdG9yZSA9IHBt
X3NsZWVwX3B0cihidGludGVsX3BjaWVfcmVzdW1lKSwNCj4rICAgICAgIC5zdXNwZW5kID0gYnRp
bnRlbF9wY2llX3N1c3BlbmQsDQo+KyAgICAgICAucmVzdW1lID0gYnRpbnRlbF9wY2llX3Jlc3Vt
ZSwNCj4rICAgICAgIC5mcmVlemUgPSBidGludGVsX3BjaWVfZnJlZXplLA0KPisgICAgICAgLnRo
YXcgPSBidGludGVsX3BjaWVfcmVzdW1lLA0KPisgICAgICAgLnBvd2Vyb2ZmID0gYnRpbnRlbF9w
Y2llX2hpYmVybmF0ZSwNCj4rICAgICAgIC5yZXN0b3JlID0gYnRpbnRlbF9wY2llX3Jlc3VtZSwN
Cj4gfTsNCj4gI2VuZGlmDQo+DQo+QEAgLTI2NjgsNyArMjY2OCw3IEBAIHN0YXRpYyBzdHJ1Y3Qg
cGNpX2RyaXZlciBidGludGVsX3BjaWVfZHJpdmVyID0gew0KPiAgICAgICAgLmlkX3RhYmxlID0g
YnRpbnRlbF9wY2llX3RhYmxlLA0KPiAgICAgICAgLnByb2JlID0gYnRpbnRlbF9wY2llX3Byb2Jl
LA0KPiAgICAgICAgLnJlbW92ZSA9IGJ0aW50ZWxfcGNpZV9yZW1vdmUsDQo+LSAgICAgICAuZHJp
dmVyLnBtID0gcG1fcHRyKCZidGludGVsX3BjaWVfcG1fb3BzKSwNCj4rICAgICAgIC5kcml2ZXIu
cG0gPSBwbV9zbGVlcF9wdHIoJmJ0aW50ZWxfcGNpZV9wbV9vcHMpLA0KPiAjaWZkZWYgQ09ORklH
X0RFVl9DT1JFRFVNUA0KPiAgICAgICAgLmRyaXZlci5jb3JlZHVtcCA9IGJ0aW50ZWxfcGNpZV9j
b3JlZHVtcCAgI2VuZGlmDQo+DQo+DQo+PiAgI2lmZGVmIENPTkZJR19ERVZfQ09SRURVTVANCj4+
ICAgICAgICAgLmRyaXZlci5jb3JlZHVtcCA9IGJ0aW50ZWxfcGNpZV9jb3JlZHVtcCAgI2VuZGlm
DQo+PiAtLQ0KPj4gMi40My4wDQo+Pg0KPj4NCj4NCj4NCj4tLQ0KPkx1aXogQXVndXN0byB2b24g
RGVudHoNCg0KVGhhbmtzLA0KS2lyYW4NCg0K

