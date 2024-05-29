Return-Path: <linux-pci+bounces-8024-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 257DB8D3858
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 15:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E8F21F27A39
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 13:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B187418E28;
	Wed, 29 May 2024 13:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bo5eHXLy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929BB1BC43
	for <linux-pci@vger.kernel.org>; Wed, 29 May 2024 13:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716990536; cv=fail; b=CkacnR5hvQz4OInoa6+AVRJCPm4g7Q+zGVjOnOJgPuW51oS601vrb+qQxnu5EkvPYNWYio8Lwq0KpOPirEkWU0SIjq3Oz3AIsXatsi2MI8ODCu4bF7wjGxGpsfHPqBLHmOzDBcUPgkAABKtge2qBrTImPMzQeHogz8yEDUrQod0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716990536; c=relaxed/simple;
	bh=tdZquTHcKauIi/xtlcgmOqJmrQCgbeQDNPpPNUX7C2g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uT4rcr2Ukn0VHd8UeQrEI/Czo4g/HKZh64qJyCLNJ9SPnJDZDS+T+p8tx5IbGrOtdCc/nsQCsqJVrK2QOwLUcU5HYvF/lBir3Q/VXgbSnQwM3MHQsiCYmODrjp2jz38yriroArsT+lzJrv6oy0br1VwLF5eIC++2yunqzNdBjVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bo5eHXLy; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716990534; x=1748526534;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tdZquTHcKauIi/xtlcgmOqJmrQCgbeQDNPpPNUX7C2g=;
  b=Bo5eHXLyAKMLXZW0SX+oJ+GxLjMg2by8MWNnVlTK/x1ApIIIqp6BLitQ
   DBxFgdDUhbVCI3lnF5QrBEkUEzxU6rJ7KrR47MEu+KKKEiwQ9jT0UYznC
   7vsCk/akxThF7eGn/OxQgYgCdW+9Cd0BoQnpe5T6wVZhlxZ2UGbLClJGX
   8rviUozfPV6522uajFjuBP4J8qS6SGv9nMM4PnG2of9XiRwNupaApM7K4
   IWUY5S4AbnuMAjBlNNhs3Y6JkwpPK5WkHhFfBoxEA+kXcJByBLR4bAWJf
   scU9QlzktDXbgrusel5NBmwHqRmnJTrLoSRYZMNElUUUv940XYTZmIpNa
   g==;
X-CSE-ConnectionGUID: BGkcS7XQQzS4mJiv7BLl4w==
X-CSE-MsgGUID: egJMJ3JPSMyCJ87Utgmdfg==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="24808697"
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="24808697"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 06:48:53 -0700
X-CSE-ConnectionGUID: sMmHpWbNSkWfrs4UaqnA8Q==
X-CSE-MsgGUID: ooa8st6yThquc9ngvJ/K5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="58618855"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 May 2024 06:48:54 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 06:48:53 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 06:48:52 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 29 May 2024 06:48:52 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 06:48:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3qiHWVTa7PD5eP4ERZHDh8COGbVaOCkZoWw5h7b37ksemrqtJWGmw77wOveZcTys99HcMvx58eNmkY8kxytBJXTPL+lLj9EfFfXS8bSsQZBEvKDVJmhYn9VmoJ+nBPdYr1QWRlhPnajoLPDXizuKpuijR6zP5ztlruJKWgrH2jbf3CfvpjaRHn14Y71qi8K5IDiahkfy3Bg8e7KYGV38cOMyAKiEhxlVP7ZkomP4f2C/8YBwkB6Yn0cnEudUEjo5EymkLriBbBrChY3YzIW9da0NuxoBlU6EVlIYv9wziFVBNb91hdCToE9mxAwG7R2H1kHomgejjmDo654YA+bsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tdZquTHcKauIi/xtlcgmOqJmrQCgbeQDNPpPNUX7C2g=;
 b=ayEMxRW4KKHI3AKccm9VoGQNCave49C7nzjUqf+bq0O5dOML0LG3/Fp/elyX6cGphtOnB+Z+Lc/ENXDVm5H1TDokfcIBEbAm0tJU5tUznf3+Wqtjx4N2mX5Y0e730h1XWsCd2aMXF+o+iBdDi6UVOpcdJjVndOLQvtuIWL1UDPyECtY8aqD9HheGUjWzchaco1RmaD84EUepUyz21eG/PSppkaV8N5Exet0Uj/sOzTGJq1ZbGpsHwYGOhYjCKyW3z34WUYX96TJdaCB2rQ6oqEH4fI/dOuQ/sMwXouLNd7BXrnPd7h7LA8wU5xwUftA41f58YEJObWjLe3szj3h9kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5655.namprd11.prod.outlook.com (2603:10b6:8:28::10) by
 SA3PR11MB7487.namprd11.prod.outlook.com (2603:10b6:806:317::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.31; Wed, 29 May 2024 13:48:48 +0000
Received: from DM8PR11MB5655.namprd11.prod.outlook.com
 ([fe80::f6db:9044:ad81:33d9]) by DM8PR11MB5655.namprd11.prod.outlook.com
 ([fe80::f6db:9044:ad81:33d9%3]) with mapi id 15.20.7633.018; Wed, 29 May 2024
 13:48:48 +0000
From: "Saarinen, Jani" <jani.saarinen@intel.com>
To: Jani Nikula <jani.nikula@linux.intel.com>, Nirmal Patel
	<nirmal.patel@linux.intel.com>, "Deak, Imre" <imre.deak@intel.com>, "Jiang,
 Dave" <dave.jiang@intel.com>
CC: =?utf-8?B?5p2OLCDmmJ/ovok=?= <korantli@tencent.com>, Jonathan Derrick
	<jonathan.derrick@linux.dev>, Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
Subject: RE: Lockdep annotation introduced warn in VMD driver
Thread-Topic: Lockdep annotation introduced warn in VMD driver
Thread-Index: AQHasPvGoTC05+utlkaEOOCd4uPGL7GtQa0AgACahYCAAF6cgA==
Date: Wed, 29 May 2024 13:48:48 +0000
Message-ID: <DM8PR11MB565579189DD400BACDF5493CE0F22@DM8PR11MB5655.namprd11.prod.outlook.com>
References: <ZlXP5oTnSApiDbD1@ideak-desk.fi.intel.com>
 <20240528155228.00005850@linux.intel.com> <877cfdkpom.fsf@intel.com>
In-Reply-To: <877cfdkpom.fsf@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5655:EE_|SA3PR11MB7487:EE_
x-ms-office365-filtering-correlation-id: 215bfe75-dc65-483e-04c7-08dc7fe61123
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?MlpCVVBXWThyUzJGc25QYkxSUjJjV01USGxZNktrc280Qmh6SGY2Q2RqRzJx?=
 =?utf-8?B?Rlo4NlBqZ1UrUU9uMVk4OU1wSFp5SThTcFZWWnBtSXhzRkNBcEZNdXFmVXVs?=
 =?utf-8?B?dXpXVm5zcFZLOFpZVWZtTFVXVzJVLzRLR2QzSnZtTEhqOXJQTXZvaE53UFZR?=
 =?utf-8?B?VkI3MTh3enp4Q1A5dy8zNFlZY0RVRExianZQYmJzMTF2NFhPL1kvQklyc1VD?=
 =?utf-8?B?a0J2RE9CV21vaG04THFhOERwb1lEQkpHOVpCY1owMnN5cldJV0lYa3BXQVRr?=
 =?utf-8?B?RUlTdVFiQS9pc3ViOW1kR3dCVVRheGhKT0t5dzVBOXJ1Umtvd0xFdmc4WEht?=
 =?utf-8?B?aFZMTmlORXhQMHJwN1k4SGVpeU5HOU5rek16dHpUYm84aXVvcXp5eS91ay9k?=
 =?utf-8?B?UDJnT3JaQ1U5SU1zWnNFTXlXRExyMkM2VURXT3hUc3AxUy93ekt0azlZUUZR?=
 =?utf-8?B?RDB2VDdVajlsZlN0cmtKSXVsYk5oMmlTUDVxNG05SDM4SE5ITGMrcjNXeFpO?=
 =?utf-8?B?L2JVQUEwdW5RUko5SG9RWjFwTFQ4czQ1cFhBWXNRNWVERU85aHo2RFhFWitT?=
 =?utf-8?B?NTl1WGJvditRQjVXRUs1N0NlNjRVVGo3QVk1am04TEU5Zjg4NnY0VFh3TSt6?=
 =?utf-8?B?a3hBMUZYaVo2SVh3SVIwak1oNCtteHRCcm9PbDd3cFoweG5ZZElwZGVjZElL?=
 =?utf-8?B?NVVQZkM4ZUFDOTRhVkpIVk1RY0ZqWE1PbGZ4UjJpdlJMUTE5cDZKT2srZC9U?=
 =?utf-8?B?OG1iMTBHTUFhbW5HT1ZqZ1o3ZE1ubThpQy9xUFJXbXEwZ2k0czZBenZ4RWNE?=
 =?utf-8?B?blVzVmpNRmYzT0t1UU9Gc1UrM0dTbE1SaHNDWjI1cmZvWE11N2hBQWNSbGZO?=
 =?utf-8?B?amIxcGdTMzJXNlhxNVE2NU9EL3dYNElBMm9MaXJHNjdFOWQ4R0loRnN5OWRR?=
 =?utf-8?B?U1UyLzNZTitBSmFVNmppUG5QR0xrZDBsT1B3VTNxQXJHMlJJY056ZVFNTk5O?=
 =?utf-8?B?MHg5K2Q0WHBqSFNQNTFGSGxKTUdHNUUwbUN5L01aQko4dW02UG0xRXlXNFUr?=
 =?utf-8?B?YUZCVUh5T0p6ZEhFUTdjelpCTFBuQkZ4cnFRcXNKMGx4VlVsWElEWWQzL0RG?=
 =?utf-8?B?SGZlRE1ucW1uWlAxVDdKa29vR3NnSlJYMExxQXNRbWlJVndveDBuWHdZRTRF?=
 =?utf-8?B?T09kMFJaRldEUGQvdTViTGQ4SFYwSUs1NS9qTVpxTGpGVStsREdxSTVzRk5W?=
 =?utf-8?B?QU1wMmpzTStNQ1JDeC9ObDNzdkRDMXhEVjlGcW52VnFheU5PRDIyMW9JeU5q?=
 =?utf-8?B?TlJsY09jaGlJaGpKL292eGx2K2pmSFI0dCtaQXpiV2syaVhkUUFZbHpSUE15?=
 =?utf-8?B?Nzc1d0pPUmk5Q3lBR0NUS1g2cDVZQVQ3K1BwZmZSVW4vTlRwMjVXUHJPM0Fv?=
 =?utf-8?B?WHJKNWdINlhFMlI1MWhNaVNLaGorUGwrRndLZjRjcjlZV3VXM2ZxN0xZSFB0?=
 =?utf-8?B?YU9Ra0RPdlV1Ykdha3NXVHlvdktIQktnMFdhU25VTG1iVmdtdnFmKzJ2Q2hz?=
 =?utf-8?B?OWlGdXRSZzl3NGltdjBUQ0JoQ0QxZkwzMk8zU1o2UkZxcTV3Z0JKNFJ5d2k4?=
 =?utf-8?B?c0owSTBDTW1FRHlwS0phLzdLdG9aNEQ2aVhVTmNUMVgxZEYwa1VyUFRhMlAr?=
 =?utf-8?B?TmVYaVNXdzJGaE5kS3llY2RhZGl2YzlHR3AwQWtBS0dWdHRQSjhLN3Roa0hQ?=
 =?utf-8?Q?p7KJ4/Fwd6AL3ogGJI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5655.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3VQTUNNVnBUY3JLSFlhazVtUkR0enBUOTNrTkY2UE1LRmVkeXhIYlJZdno4?=
 =?utf-8?B?eWtTN0F1d2FVY2lzV0pscGkwRld0Z0FnM3BPQllMWElZTnhqQjloTGpmNU1r?=
 =?utf-8?B?MmFRcE54UmFGS3Y1VE1YUm55c1dydUV2N3FGRUxUZVNuSEh5dnIzWEtCT05U?=
 =?utf-8?B?Z1AvODZ0bGJ3YllNZEprSmNkbDlZd1RYR2J4MUFoeHFac0FBNzArSXUzNGNz?=
 =?utf-8?B?cFp1RmNJdFJzNUNSSHNhVFhwS1d5dnF4Mzh3eEszUitxNHZnZW5uS0pBZVhE?=
 =?utf-8?B?VytpODBkZ0xGOWpQNzhXL0JxbjBGaTh2SlJHMjhlRU9PZXM3STc5QjdJbG52?=
 =?utf-8?B?aVdiYjVROFdpNlI0UldhbnZaSDlXOVYwY3RPdFVOc3RjZ0xlNTJqRjg0b1BK?=
 =?utf-8?B?ZyszTFg4OWFnUVgvQVdQbW5wTU5rNEZCb21uNzg5eWNHNlRYRWN0SHQ4ZEYr?=
 =?utf-8?B?eExRamU0SHk4dkl2K0ZRTlFyL04yUjRTQlptdGRkL0F6NVZESHMzU1dzL1Vn?=
 =?utf-8?B?ZGVJKzVXQjRSRW5RRHFoSkR5eS95RnNNeTlDSy9JNWgvOFR5cEVGdnFhZWlz?=
 =?utf-8?B?WDdqTFRrZVNzaHVhMWlBUmFXbXlLN2U1U0gxWXAvd1I5YU9MUmN2aXlqWE5D?=
 =?utf-8?B?R1VIclpnZldVOFkvSG9KT2RGMlh5L2hWMFBOclFzaklTbVNJQmtUaHhNMVcx?=
 =?utf-8?B?SmJ6Z0R6Vzh5R2p1T3hCOTFhTVZUQzJUVy9WaHdZZFZpZVNjcUh3c0FrdzBR?=
 =?utf-8?B?V0JERCtmSHE4UmpRcWxnL0tCT3NaSldMVVZUTlg3b1J3TGdac3NFN29OV0cy?=
 =?utf-8?B?LzAycWtyd1VTaDhOdWlnM0pLVVFZWVg1M1drbU5kd3Q1alBObFk1RGR0NzNT?=
 =?utf-8?B?UWtaVndmSDB0OXh5UnlxbHQ4M0k4V09XUzJYajJ4YjdxUlh2a0U2Wi9WUWNF?=
 =?utf-8?B?QUw1VTBRSDNvbHRLanBqbDNKYWh6OEZSU3U1SG9VbnU3NVpERWRDT2NybndK?=
 =?utf-8?B?eFNPbjExdEduemdaWW1xRkxDZ3g5WTZsMGZKOUZOSjZnRnl3LzhxV253UGhZ?=
 =?utf-8?B?bDdIUE5NcDdiVlcrNENURCt2SFlzTE54ZWc3YlVRZ0RrOUVXeGVYMWZRVTd6?=
 =?utf-8?B?czE4cHczTWNMVlZ0SW0yZU1FNjN4cUZRU2FJQ3cxcEU2b1Y5Y1NmaUlDVlhJ?=
 =?utf-8?B?SWkzUUI4K1lEeml5Q1g0bXh5TjA0b29kNForWGZ3ZkFGM0pGaEhyWVUxU2Nk?=
 =?utf-8?B?RXhiSlBubEdPTEpyRW5KWnJUb2hDenJQcW14Y0JaOVFURndJQWd0aUFQUytN?=
 =?utf-8?B?dENidFZTRmNoQWdZeExFTTVzYVdYV01CTUVtZ2NBYU9kZVRISTVGZjU3bDRu?=
 =?utf-8?B?U1NhbHRKaGREREZIU3ppNXo1SXlFSkMvZDhhdWhMbDdNaTJsNjZPcEt1akhh?=
 =?utf-8?B?NG5UODRCQzdxSmp4WmQ2UVdXU2tXRTVkTnpQZmxmTUViZDZEVTB0M3NvQXFo?=
 =?utf-8?B?TU9EYzNjV2x0dE02U1pzeDFJbWRHRUFuVk9ZNXN4T2xyNnFVZVVRTE9DeEp0?=
 =?utf-8?B?bjRWYkl2R25kM01sZG5yNTU5VmR6aGZMNU5KbkQzNzd1UjdLMy9Ua2hNNEVa?=
 =?utf-8?B?ZXlNb3Nqc1MycVNBSC9JVVc4ODQ0Y01QaTBhNTJGZWFLMUFsUFhna1FEWW5H?=
 =?utf-8?B?blphVDZVUk92QlNQYnZCeWtNMnhaODVEVFR2bjlyZmxYN1c3b0VLVHhFU1NZ?=
 =?utf-8?B?NmY0RCtvekN0d0NHV21oT2pLbUlyS2xFSW95V3F3aGRSOFlBNytmejdyV3U3?=
 =?utf-8?B?VnVFQ254ZHQ1bGVVYXE3SGl2UjVUeTlpcFRFRGFNSlVFY0ZEakVIcE5jRDFu?=
 =?utf-8?B?aHJjd0RHdUZtbDhwVnI1NjA3YkhLK0hIMWhJSkF3VVg4a3FYQ0ZsbEhHelly?=
 =?utf-8?B?R3lrMGV4TzcvdVR2QXJ4WktpTWc1MGVmaHdtelVCTkJTVVRiRzJmUVRSaGth?=
 =?utf-8?B?QTlSaHdPcDhGd1JBTmI2ZG00RnFqVU43MnRkaktnMmZtNExjNzN3TWhWMXor?=
 =?utf-8?B?NG5kU0YwSlFMZnZ3SklmWlJvL3paV2hYS1pMQTJ2TG1MUHJ6RE50UXAyanJt?=
 =?utf-8?Q?vEJoEdwpdavmnwvAx3K32ngnW?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5655.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 215bfe75-dc65-483e-04c7-08dc7fe61123
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2024 13:48:48.6114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dlnvR/pQgm+60zjPRkS0RGMnrvA4Frhj3oryYT65YQBjNd4LBWJASpOtGJ8RiHZdmUKFCQrG2fJBmyoAwIzzyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7487
X-OriginatorOrg: intel.com

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSW50ZWwtZ2Z4IDxp
bnRlbC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBKYW5p
DQo+IE5pa3VsYQ0KPiBTZW50OiBXZWRuZXNkYXksIDI5IE1heSAyMDI0IDExLjA2DQo+IFRvOiBO
aXJtYWwgUGF0ZWwgPG5pcm1hbC5wYXRlbEBsaW51eC5pbnRlbC5jb20+OyBEZWFrLCBJbXJlDQo+
IDxpbXJlLmRlYWtAaW50ZWwuY29tPg0KPiBDYzogSmlhbmcsIERhdmUgPGRhdmUuamlhbmdAaW50
ZWwuY29tPjsg5p2OLCDmmJ/ovokgPGtvcmFudGxpQHRlbmNlbnQuY29tPjsNCj4gSm9uYXRoYW4g
RGVycmljayA8am9uYXRoYW4uZGVycmlja0BsaW51eC5kZXY+OyBCam9ybiBIZWxnYWFzDQo+IDxi
aGVsZ2Fhc0Bnb29nbGUuY29tPjsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgaW50ZWwtDQo+
IGdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gU3ViamVjdDogUmU6IExvY2tkZXAgYW5ub3Rh
dGlvbiBpbnRyb2R1Y2VkIHdhcm4gaW4gVk1EIGRyaXZlcg0KPiANCj4gT24gVHVlLCAyOCBNYXkg
MjAyNCwgTmlybWFsIFBhdGVsIDxuaXJtYWwucGF0ZWxAbGludXguaW50ZWwuY29tPiB3cm90ZToN
Cj4gPiBPbiBUdWUsIDI4IE1heSAyMDI0IDE1OjM2OjU0ICswMzAwDQo+ID4gSW1yZSBEZWFrIDxp
bXJlLmRlYWtAaW50ZWwuY29tPiB3cm90ZToNCj4gPg0KPiA+PiBIaSwNCj4gPj4NCj4gPj4gY29t
bWl0IDdlODllZmM2ZTllNDAyODM5NjQzY2IyOTdiYWIxNDA1NWM1NDdmMDcNCj4gPj4gQXV0aG9y
OiBEYXZlIEppYW5nIDxkYXZlLmppYW5nQGludGVsLmNvbT4NCj4gPj4gRGF0ZTogICBUaHUgTWF5
IDIgMDk6NTc6MzEgMjAyNCAtMDcwMA0KPiA+Pg0KPiA+PiAgICAgUENJOiBMb2NrIHVwc3RyZWFt
IGJyaWRnZSBmb3IgcGNpX3Jlc2V0X2Z1bmN0aW9uKCkNCj4gPj4NCj4gPj4gaW50cm9kdWNlZCB0
aGUgV0FSTiBiZWxvdyBpbiB0aGUgVk1EIGRyaXZlciwgc2VlIFsxXSBmb3IgdGhlIGZ1bGwgbG9n
Lg0KPiA+PiBOb3Qgc3VyZSBpZiB0aGUgYW5ub3RhdGlvbiBpcyBpbmNvcnJlY3Qgb3IgdGhlIFZN
RCBkcml2ZXIgaXMgbWlzc2luZw0KPiA+PiB0aGUgbG9jaywgQ0MnaW5nIFZNRCBmb2xrcy4NCj4g
Pj4NCj4gPj4gLS1JbXJlDQo+ID4gQ2FuIHlvdSBwbGVhc2UgcHJvdmlkZSByZXBybyBzdGVwcyBh
bmQgc29tZSBiYWNrZ3JvdW5kIG9uIHRoZSBzZXR1cD8NCj4gDQo+IEhhcmR3YXJlIG5hbWU6IElu
dGVsIENvcnBvcmF0aW9uIEFsZGVyIExha2UgQ2xpZW50IFBsYXRmb3JtL0FsZGVyTGFrZS1QDQo+
IExQNSBSVlAuDQo+IA0KPiBLY29uZmlnOiBodHRwczovL2ludGVsLWdmeC1jaS4wMS5vcmcvdHJl
ZS9kcm0tdGlwL0NJX0RSTV8xNDg0Mi9rY29uZmlnLnR4dA0KPiANCj4gSnVzdCBib290aW5nIHdp
dGggdGhlIGFib3ZlIGNvbW1pdCBpcyBlbm91Z2guDQpJdCBzZWVtcyBmaXggZG8gbm90IGZpeCBh
cyBzZWVuIG9uIGh0dHBzOi8vcGF0Y2h3b3JrLmZyZWVkZXNrdG9wLm9yZy9zZXJpZXMvMTM0MTgz
LyANCj0+IGh0dHBzOi8vaW50ZWwtZ2Z4LWNpLjAxLm9yZy90cmVlL2RybS10aXAvUGF0Y2h3b3Jr
XzEzNDE4M3YxL2luZGV4Lmh0bWw/IA0KU2VlIHRob3NlIHJlZCBub3Qgd2hlcmUgYm90aCBhcmUg
cmVkIHN0aWwgYW5kIGFsc28gYm90aCBkbWVzZyAoYm9vdC5sb2cpIGxvb2sgc3RpbGwgaWRlbnRp
Y2FsLiANClNvIGVnOg0KYmFzZSBidWlsZDogICBodHRwczovL2ludGVsLWdmeC1jaS4wMS5vcmcv
dHJlZS9kcm0tdGlwL0NJX0RSTV8xNDg0Ni9iYXQtZGcyLTEzL2Jvb3QwLnR4dA0KcHcgcGF0Y2hl
czogaHR0cHM6Ly9pbnRlbC1nZngtY2kuMDEub3JnL3RyZWUvZHJtLXRpcC9QYXRjaHdvcmtfMTM0
MTgzdjEvYmF0LWRnMi0xMy9ib290MC50eHQNCg0KRGF2ZSwgdGhvdWdodHM/IA0KDQoNCkJyLA0K
SmFuaQ0KIA0KPiBCUiwNCj4gSmFuaS4NCj4gDQo+ID4NCj4gPiAtbmlybWFsDQo+ID4+DQo+ID4+
IGh0dHBzOi8vaW50ZWwtZ2Z4LWNpLjAxLm9yZy90cmVlL2RybS10aXAvUGF0Y2h3b3JrXzEzNDEx
MnYxL2JhdC1hZGxwLQ0KPiA+PiAxMS9ib290MC50eHQNCj4gPj4NCj4gPj4gPDQ+WyAgIDE3LjM1
NDA3MV0gV0FSTklORzogQ1BVOiAwIFBJRDogMSBhdCBkcml2ZXJzL3BjaS9wY2kuYzo0ODg2DQo+
ID4+IHBjaV9icmlkZ2Vfc2Vjb25kYXJ5X2J1c19yZXNldCsweDVkLzB4NzAgPDQ+WyAgIDE3LjM1
NDA5NV0gTW9kdWxlcw0KPiA+PiBsaW5rZWQgaW46IDw0PlsgICAxNy4zNTQxMDRdIENQVTogMCBQ
SUQ6IDEgQ29tbTogc3dhcHBlci8wIE5vdA0KPiA+PiB0YWludGVkIDYuMTAuMC1yYzEtUGF0Y2h3
b3JrXzEzNDExMnYxLWdhYmFlYWUyMDJkZmIrICMxIDw0PlsNCj4gPj4gMTcuMzU0MTI4XSBIYXJk
d2FyZSBuYW1lOiBJbnRlbCBDb3Jwb3JhdGlvbiBBbGRlciBMYWtlIENsaWVudA0KPiA+PiBQbGF0
Zm9ybS9BbGRlckxha2UtUCBMUDUgUlZQLCBCSU9TIFJQTFBGV0kxLlIwMC40MDM1LkEwMC4yMzAx
MjAwNzIzDQo+ID4+IDAxLzIwLzIwMjMgPDQ+WyAgIDE3LjM1NDE1M10gUklQOg0KPiA+PiAwMDEw
OnBjaV9icmlkZ2Vfc2Vjb25kYXJ5X2J1c19yZXNldCsweDVkLzB4NzAgPDQ+WyAgIDE3LjM1NDE2
N10NCj4gQ29kZToNCj4gPj4gYzMgY2MgY2MgY2MgY2MgNDggODkgZWYgNDggYzcgYzYgNzggNTUg
NDQgODIgNWQgZTkgZDggYzYgZmYgZmYgNDggOGQNCj4gPj4gYmYgNDggMDggMDAgMDAgYmUgZmYg
ZmYgZmYgZmYgZTggOTcgMTAgNWYgMDAgODUgYzAgNzUgYjUgPDBmPiAwYiBlYg0KPiA+PiBiMSA2
NiA2NiAyZSAwZiAxZiA4NCAwMCAwMCAwMCAwMCAwMCAwZiAxZiA0MCAwMCA5MCA5MCA5MCA8ND5b
DQo+ID4+IDE3LjM1NDE5OV0gUlNQOiAwMDAwOmZmZmZjOTAwMDAwOTdjYTAgRUZMQUdTOiAwMDAx
MDI0NiA8ND5bDQo+ID4+IDE3LjM1NDIxMF0gUkFYOiAwMDAwMDAwMDAwMDAwMDAwIFJCWDogZmZm
Zjg4ODEwNTYwNDAwMCBSQ1g6DQo+ID4+IDAwMDAwMDAwMDAwMDAwMDAgPDQ+WyAgIDE3LjM1NDIy
NF0gUkRYOiAwMDAwMDAwMDgwMDAwMDAwIFJTSToNCj4gPj4gZmZmZmZmZmY4MjQyMWM0MCBSREk6
IGZmZmZmZmZmODI0NDFjNGMgPDQ+WyAgIDE3LjM1NDIzOF0gUkJQOg0KPiA+PiBmZmZmODg4MTA1
NjAxMDAwIFIwODogMDAwMDAwMDAwMDAwMDAwMSBSMDk6IDAwMDAwMDAwMDAwMDAwMDAgPDQ+Ww0K
PiA+PiAxNy4zNTQyNTFdIFIxMDogMDAwMDAwMDAwMDAwMDAwMSBSMTE6IGZmZmY4ODgxMDA4Yzgw
NDAgUjEyOg0KPiA+PiAwMDAwMDAwMDAwMDAwMDAwIDw0PlsgICAxNy4zNTQyNjRdIFIxMzogMDAw
MDAwMDAwMDAwMDAyMCBSMTQ6DQo+ID4+IDAwMDAwMDAwMDAwMDAwN2YgUjE1OiBmZmZmODg4MTA1
NjE1YzI4IDw0PlsgICAxNy4zNTQyODNdIEZTOg0KPiA+PiAwMDAwMDAwMDAwMDAwMDAwKDAwMDAp
IEdTOmZmZmY4ODgyYTZlMDAwMDAoMDAwMCkNCj4gPj4ga25sR1M6MDAwMDAwMDAwMDAwMDAwMCA8
ND5bICAgMTcuMzU0MzEzXSBDUzogIDAwMTAgRFM6IDAwMDAgRVM6IDAwMDANCj4gPj4gQ1IwOiAw
MDAwMDAwMDgwMDUwMDMzIDw0PlsgICAxNy4zNTQzMzRdIENSMjogZmZmZjg4ODJhZmJmZjAwMCBD
UjM6DQo+ID4+IDAwMDAwMDAwMDY2M2EwMDAgQ1I0OiAwMDAwMDAwMDAwZjUwZWYwIDw0PlsgICAx
Ny4zNTQzNDhdIFBLUlU6DQo+ID4+IDU1NTU1NTU0IDw0PlsgICAxNy4zNTQzNTVdIENhbGwgVHJh
Y2U6IDw0PlsgICAxNy4zNTQzNjFdICA8VEFTSz4gPDQ+Ww0KPiA+PiAgIDE3LjM1NDM2N10gID8g
X193YXJuKzB4OGMvMHgxOTAgPDQ+WyAgIDE3LjM1NDM4MF0gID8NCj4gPj4gcGNpX2JyaWRnZV9z
ZWNvbmRhcnlfYnVzX3Jlc2V0KzB4NWQvMHg3MCA8ND5bICAgMTcuMzU0MzkyXSAgPw0KPiA+PiBy
ZXBvcnRfYnVnKzB4MWY4LzB4MjAwIDw0PlsgICAxNy4zNTQ0MDVdICA/IGhhbmRsZV9idWcrMHgz
Yy8weDcwIDw0PlsNCj4gPj4gICAxNy4zNTQ0MTVdICA/IGV4Y19pbnZhbGlkX29wKzB4MTgvMHg3
MCA8ND5bICAgMTcuMzU0NDI0XSAgPw0KPiA+PiBhc21fZXhjX2ludmFsaWRfb3ArMHgxYS8weDIw
IDw0PlsgICAxNy4zNTQ0MzhdICA/DQo+ID4+IHBjaV9icmlkZ2Vfc2Vjb25kYXJ5X2J1c19yZXNl
dCsweDVkLzB4NzAgPDQ+WyAgIDE3LjM1NDQ1MV0NCj4gPj4gcGNpX3Jlc2V0X2J1cysweDFkOC8w
eDI3MCA8ND5bICAgMTcuMzU0NDYxXSAgdm1kX3Byb2JlKzB4Nzc4LzB4YTEwDQo+ID4+IDw0Plsg
ICAxNy4zNTQ0NzRdICBwY2lfZGV2aWNlX3Byb2JlKzB4OTUvMHgxMjAgPDQ+WyAgIDE3LjM1NDQ4
NF0NCj4gPj4gcmVhbGx5X3Byb2JlKzB4ZDkvMHgzNzAgPDQ+WyAgIDE3LjM1NDQ5Nl0gID8NCj4g
Pj4gX19wZnhfX19kcml2ZXJfYXR0YWNoKzB4MTAvMHgxMCA8ND5bICAgMTcuMzU0NTA1XQ0KPiA+
PiBfX2RyaXZlcl9wcm9iZV9kZXZpY2UrMHg3My8weDE1MCA8ND5bICAgMTcuMzU0NTE2XQ0KPiA+
PiBkcml2ZXJfcHJvYmVfZGV2aWNlKzB4MTkvMHhhMCA8ND5bICAgMTcuMzU0NTI1XQ0KPiA+PiBf
X2RyaXZlcl9hdHRhY2grMHhiNi8weDE4MCA8ND5bICAgMTcuMzU0NTM0XSAgPw0KPiA+PiBfX3Bm
eF9fX2RyaXZlcl9hdHRhY2grMHgxMC8weDEwIDw0PlsgICAxNy4zNTQ1NDRdDQo+ID4+IGJ1c19m
b3JfZWFjaF9kZXYrMHg3Ny8weGQwIDw0PlsgICAxNy4zNTQ1NTVdDQo+ID4+IGJ1c19hZGRfZHJp
dmVyKzB4MTEwLzB4MjQwIDw0PlsgICAxNy4zNTQ1NjZdDQo+ID4+IGRyaXZlcl9yZWdpc3Rlcisw
eDViLzB4MTEwIDw0PlsgICAxNy4zNTQ1NzVdICA/DQo+ID4+IF9fcGZ4X3ZtZF9kcnZfaW5pdCsw
eDEwLzB4MTAgPDQ+WyAgIDE3LjM1NDU4N10NCj4gPj4gZG9fb25lX2luaXRjYWxsKzB4NWMvMHgy
YjAgPDQ+WyAgIDE3LjM1NDYwMF0NCj4gPj4ga2VybmVsX2luaXRfZnJlZWFibGUrMHgxOGUvMHgz
NDAgPDQ+WyAgIDE3LjM1NDYxMl0gID8NCj4gPj4gX19wZnhfa2VybmVsX2luaXQrMHgxMC8weDEw
IDw0PlsgICAxNy4zNTQ2MjNdICBrZXJuZWxfaW5pdCsweDE1LzB4MTMwDQo+ID4+IDw0PlsgICAx
Ny4zNTQ2MzFdICByZXRfZnJvbV9mb3JrKzB4MmMvMHg1MCA8ND5bICAgMTcuMzU0NjQxXSAgPw0K
PiA+PiBfX3BmeF9rZXJuZWxfaW5pdCsweDEwLzB4MTAgPDQ+WyAgIDE3LjM1NDY1MF0NCj4gPj4g
cmV0X2Zyb21fZm9ya19hc20rMHgxYS8weDMwIDw0PlsgICAxNy4zNTQ2NjNdICA8L1RBU0s+IDw0
PlsNCj4gPj4gMTcuMzU0NjY5XSBpcnEgZXZlbnQgc3RhbXA6IDI4NTc3Njg1IDw0PlsgICAxNy4z
NTQ2NzddIGhhcmRpcnFzIGxhc3QNCj4gPj4gZW5hYmxlZCBhdCAoMjg1Nzc2OTMpOiBbPGZmZmZm
ZmZmODExN2MwNjA+XQ0KPiA+PiBjb25zb2xlX3VubG9jaysweDExMC8weDEyMCA8ND5bICAgMTcu
MzU0Njk3XSBoYXJkaXJxcyBsYXN0IGRpc2FibGVkDQo+ID4+IGF0ICgyODU3NzcwMCk6IFs8ZmZm
ZmZmZmY4MTE3YzA0NT5dIGNvbnNvbGVfdW5sb2NrKzB4ZjUvMHgxMjAgPDQ+Ww0KPiA+PiAxNy4z
NTQ3MTNdIHNvZnRpcnFzIGxhc3QgIGVuYWJsZWQgYXQgKDI4NTc3MTc2KTogWzxmZmZmZmZmZjgx
MGRmMjljPl0NCj4gPj4gaGFuZGxlX3NvZnRpcnFzKzB4MmVjLzB4M2YwIDw0PlsgICAxNy4zNTQ3
MzFdIHNvZnRpcnFzIGxhc3QgZGlzYWJsZWQNCj4gPj4gYXQgKDI4NTc3MTY3KTogWzxmZmZmZmZm
ZjgxMGRmYTE3Pl0gaXJxX2V4aXRfcmN1KzB4ODcvMHhjMCA8ND5bDQo+ID4+IDE3LjM1NDc0N10g
LS0tWyBlbmQgdHJhY2UgMDAwMDAwMDAwMDAwMDAwMCBdLS0tDQo+ID4+DQo+ID4+IDw0PlsgICAx
Ny40ODcyNzRdID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4gPj4gPDQ+
WyAgIDE3LjQ4NzI3N10gV0FSTklORzogYmFkIHVubG9jayBiYWxhbmNlIGRldGVjdGVkIQ0KPiA+
PiA8ND5bICAgMTcuNDg3Mjc5XSA2LjEwLjAtcmMxLVBhdGNod29ya18xMzQxMTJ2MS1nYWJhZWFl
MjAyZGZiKyAjMQ0KPiA+PiBUYWludGVkOiBHICAgICAgICBXIDw0PlsgICAxNy40ODcyODJdDQo+
ID4+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0gPDQ+WyAgIDE3LjQ4NzI4
NF0gc3dhcHBlci8wLzENCj4gPj4gaXMgdHJ5aW5nIHRvIHJlbGVhc2UgbG9jayAoMTAwMDA6ZTE6
MDAuMCkgYXQ6IDw0PlsgICAxNy40ODcyODddDQo+ID4+IFs8ZmZmZmZmZmY4MTc2YjM3Nz5dIHBj
aV9jZmdfYWNjZXNzX3VubG9jaysweDU3LzB4NjAgPDQ+Ww0KPiA+PiAxNy40ODcyOTJdIGJ1dCB0
aGVyZSBhcmUgbm8gbW9yZSBsb2NrcyB0byByZWxlYXNlISA8ND5bICAgMTcuNDg3Mjk0XQ0KPiA+
PiAgICAgICAgICAgICAgICAgICBvdGhlciBpbmZvIHRoYXQgbWlnaHQgaGVscCB1cyBkZWJ1ZyB0
aGlzOg0KPiA+PiA8ND5bICAgMTcuNDg3Mjk3XSAyIGxvY2tzIGhlbGQgYnkgc3dhcHBlci8wLzE6
DQo+ID4+IDw0PlsgICAxNy40ODcyOTldICAjMDogZmZmZjg4ODEwMmMxYzFiMCAoJmRldi0+bXV0
ZXgpey4uLi59LXszOjN9LA0KPiA+PiBhdDogX19kcml2ZXJfYXR0YWNoKzB4YWIvMHgxODAgPDQ+
WyAgIDE3LjQ4NzMwNl0gICMxOg0KPiA+PiBmZmZmODg4MTA1NjA0MWIwICgmZGV2LT5tdXRleCl7
Li4uLn0tezM6M30sIGF0Og0KPiA+PiBwY2lfZGV2X3RyeWxvY2srMHgxOS8weDUwIDw0PlsgICAx
Ny40ODczMTJdIHN0YWNrIGJhY2t0cmFjZToNCj4gPj4gPDQ+WyAgIDE3LjQ4NzMxNF0gQ1BVOiAw
IFBJRDogMSBDb21tOiBzd2FwcGVyLzAgVGFpbnRlZDogRyAgICAgICAgVw0KPiA+PiAgICAgICAg
Ni4xMC4wLXJjMS1QYXRjaHdvcmtfMTM0MTEydjEtZ2FiYWVhZTIwMmRmYisgIzEgPDQ+Ww0KPiA+
PiAxNy40ODczMThdIEhhcmR3YXJlIG5hbWU6IEludGVsIENvcnBvcmF0aW9uIEFsZGVyIExha2Ug
Q2xpZW50DQo+ID4+IFBsYXRmb3JtL0FsZGVyTGFrZS1QIExQNSBSVlAsIEJJT1MgUlBMUEZXSTEu
UjAwLjQwMzUuQTAwLjIzMDEyMDA3MjMNCj4gPj4gMDEvMjAvMjAyMyA8ND5bICAgMTcuNDg3MzIy
XSBDYWxsIFRyYWNlOiA8ND5bICAgMTcuNDg3MzI0XSAgPFRBU0s+DQo+ID4+IDw0PlsgICAxNy40
ODczMjVdICBkdW1wX3N0YWNrX2x2bCsweDgyLzB4ZDAgPDQ+WyAgIDE3LjQ4NzMyOV0NCj4gPj4g
bG9ja19yZWxlYXNlKzB4MjBiLzB4MmQwIDw0PlsgICAxNy40ODczMzRdICBwY2lfYnVzX3VubG9j
aysweDI1LzB4NDANCj4gPj4gPDQ+WyAgIDE3LjQ4NzMzN10gIHBjaV9yZXNldF9idXMrMHgxZWIv
MHgyNzANCj4gPj4gPDQ+WyAgIDE3LjQ4NzM0MF0gIHZtZF9wcm9iZSsweDc3OC8weGExMA0KPiA+
PiA8ND5bICAgMTcuNDg3MzQ0XSAgcGNpX2RldmljZV9wcm9iZSsweDk1LzB4MTIwDQo+ID4+IDw0
PlsgICAxNy40ODczNDZdICByZWFsbHlfcHJvYmUrMHhkOS8weDM3MA0KPiA+PiA8ND5bICAgMTcu
NDg3MzQ5XSAgPyBfX3BmeF9fX2RyaXZlcl9hdHRhY2grMHgxMC8weDEwDQo+ID4+IDw0PlsgICAx
Ny40ODczNTJdICBfX2RyaXZlcl9wcm9iZV9kZXZpY2UrMHg3My8weDE1MA0KPiA+PiA8ND5bICAg
MTcuNDg3MzU0XSAgZHJpdmVyX3Byb2JlX2RldmljZSsweDE5LzB4YTANCj4gPj4gPDQ+WyAgIDE3
LjQ4NzM1N10gIF9fZHJpdmVyX2F0dGFjaCsweGI2LzB4MTgwDQo+ID4+IDw0PlsgICAxNy40ODcz
NTldICA/IF9fcGZ4X19fZHJpdmVyX2F0dGFjaCsweDEwLzB4MTANCj4gPj4gPDQ+WyAgIDE3LjQ4
NzM2Ml0gIGJ1c19mb3JfZWFjaF9kZXYrMHg3Ny8weGQwDQo+ID4+IDw0PlsgICAxNy40ODczNjVd
ICBidXNfYWRkX2RyaXZlcisweDExMC8weDI0MA0KPiA+PiA8ND5bICAgMTcuNDg3MzY5XSAgZHJp
dmVyX3JlZ2lzdGVyKzB4NWIvMHgxMTANCj4gPj4gPDQ+WyAgIDE3LjQ4NzM3MV0gID8gX19wZnhf
dm1kX2Rydl9pbml0KzB4MTAvMHgxMA0KPiA+PiA8ND5bICAgMTcuNDg3Mzc0XSAgZG9fb25lX2lu
aXRjYWxsKzB4NWMvMHgyYjANCj4gPj4gPDQ+WyAgIDE3LjQ4NzM3OF0gIGtlcm5lbF9pbml0X2Zy
ZWVhYmxlKzB4MThlLzB4MzQwDQo+ID4+IDw0PlsgICAxNy40ODczODFdICA/IF9fcGZ4X2tlcm5l
bF9pbml0KzB4MTAvMHgxMA0KPiA+PiA8ND5bICAgMTcuNDg3Mzg0XSAga2VybmVsX2luaXQrMHgx
NS8weDEzMA0KPiA+PiA8ND5bICAgMTcuNDg3Mzg3XSAgcmV0X2Zyb21fZm9yaysweDJjLzB4NTAN
Cj4gPj4gPDQ+WyAgIDE3LjQ4NzM5MF0gID8gX19wZnhfa2VybmVsX2luaXQrMHgxMC8weDEwDQo+
ID4+IDw0PlsgICAxNy40ODczOTJdICByZXRfZnJvbV9mb3JrX2FzbSsweDFhLzB4MzANCj4gPj4g
PDQ+WyAgIDE3LjQ4NzM5Nl0gIDwvVEFTSz4NCj4gPj4NCj4gPg0KPiANCj4gLS0NCj4gSmFuaSBO
aWt1bGEsIEludGVsDQo=

