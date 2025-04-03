Return-Path: <linux-pci+bounces-25233-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CB8A7A1EC
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 13:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 676EE1767B8
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 11:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4799224C077;
	Thu,  3 Apr 2025 11:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FIDiuvCD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05408161320;
	Thu,  3 Apr 2025 11:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743679856; cv=fail; b=H5XJwGhrmFHHWQ9OaBrlBcdDemtLF1pMAQkKt78IauQnTK1boF8M2zvsiszddz0HJUtUl71iXU8ZET1CpKL/rp+A2KK1KBmpbJqsjF+wue/24RoSCVckuJ4YkH/HxJHNpeTlvB7jDogBUi/IdrBM5/N4cDmITecV0YG0BMPMgXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743679856; c=relaxed/simple;
	bh=8Qmo9M7Skwce/qHmTI3wQqQd0rttttYU/K+vliV8T/k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p7SatHgAvvS/8SKwOAE2lfjXlSh0X8rwGRVmJ0kWQ2MVi15sLHfaPh05NMD85Rifvg0vzNuPiyLdpY8VLkJaGZ5eQXmeHqHA8iJMQE3ricSYcjzayLlMKnDs2HYYSPKFc1FcOh8qIJtGC3FMavDz0JXW19EC//KPJWmerl+Bo9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FIDiuvCD; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743679855; x=1775215855;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8Qmo9M7Skwce/qHmTI3wQqQd0rttttYU/K+vliV8T/k=;
  b=FIDiuvCDAN/gTlNDxZiWKpTwQZNIOELAXD0LkfoNsSN1FHozB4bpB55i
   EdTYD/QqsnepUIN4Aco0VMqTX0/PmyxBtE4ZuYfOdZ0ViBeiZwM9yXS0e
   qvXdzx/0fAcwv6cnKXxgJv4ExGxFmmqpKBOZ3xh9F6FAItZj/EgNiZeeo
   ObvlxdNtPnbLqiQ8bgU4Rn7Zr64GiUbXDluN87yjmc1QzgR4q+BpboJIi
   mYqEOgj/F/H2sfBG8mr/3abtXd2iSEbGp8U16tlZJFcWS7z2PaWbDYdvS
   pgXhD88XEE1A+YU36/LP8FX72lerRC3IWrAe+lPIhDKP/4mUI+LHqA9+m
   Q==;
X-CSE-ConnectionGUID: aEihdTx6T3uKLQISdiGAUQ==
X-CSE-MsgGUID: zMJ+ezPhQy6IksQFX8ABzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="44993871"
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="44993871"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 04:30:54 -0700
X-CSE-ConnectionGUID: +1l80m6tS6OCKqnK60QS/g==
X-CSE-MsgGUID: f+4jHdWWRTyuF4p1cmcOSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="132188593"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 04:30:53 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Thu, 3 Apr 2025 04:30:53 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 3 Apr 2025 04:30:53 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 3 Apr 2025 04:30:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eruwrf7dAtLuXmjxZ7yVQnPe5lRJrsZn/sw+NwfAB3cawhM2YtzrvQuZ1ZNYX52sVrHp/NPNEOdJkgaH+cYx34VcP5Cni5WrG1pbAJUCi3L9TAAoU4to29ikbU1n+Pd636DXaF+vPWPGPxbFhsbketycBOgoVC37m8GVC/HmQn1bMzOsGZC4tQL3KUimymxhZAfE8GEejlyqSMvDnv5Qap27VxejbxjqPjNgGLjuRDZPj6SPQUBCy+cdaecbgmWt9F+FXb/Xygqoa7aru61iCOw4vGrhhzwKnSLtww7IMzWVzhQ9DWjdX/fXi6KteHlbzbywawalNyo7jPF5bax8dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Qmo9M7Skwce/qHmTI3wQqQd0rttttYU/K+vliV8T/k=;
 b=B4RunV9B8WeGmwxhE9itqfkkgOaNGkkF84J/+bUx98QcPZccoc9XvGvgJwiFWtudc3bJZ06ikNY+ZPCQ0oGJJuJZDRLau+Nu2pbfk7PHZF85nsCET770spRcNm0R5z4vDpTkFfkEQsaT8J96g0MvG1JKfQZ2vV00MneEIYUC9FnglFAML/DN+DkoahSPmr4x/kz/BsCBiXj+Bw6ObZb8kVYgox7rGhqlfolnhRc0nOqaz+hUNVD1NHhOYuA60CaknIonpJCeDY2fMD+nOyxpbgamJyGUGHTX0NczLZo78z1bPybJ5EdRsYd6N/RmV8SS2cRx1rkhIqTVKuqf/QGLUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6211.namprd11.prod.outlook.com (2603:10b6:930:25::6)
 by LV1PR11MB8841.namprd11.prod.outlook.com (2603:10b6:408:2b2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 3 Apr
 2025 11:30:50 +0000
Received: from CY5PR11MB6211.namprd11.prod.outlook.com
 ([fe80::df5a:a32c:8904:15f1]) by CY5PR11MB6211.namprd11.prod.outlook.com
 ([fe80::df5a:a32c:8904:15f1%7]) with mapi id 15.20.8534.045; Thu, 3 Apr 2025
 11:30:50 +0000
From: "Gupta, Anshuman" <anshuman.gupta@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Bjorn Helgaas
	<helgaas@kernel.org>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "lenb@kernel.org"
	<lenb@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>, "De Marchi,
 Lucas" <lucas.demarchi@intel.com>, "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
	"Nilawar, Badal" <badal.nilawar@intel.com>, "Gupta, Varun"
	<varun.gupta@intel.com>, "ville.syrjala@linux.intel.com"
	<ville.syrjala@linux.intel.com>, "Shankar, Uma" <uma.shankar@intel.com>
Subject: RE: [PATCH 03/12] PCI/ACPI: Add aux power grant notifier
Thread-Topic: [PATCH 03/12] PCI/ACPI: Add aux power grant notifier
Thread-Index: AQHboxvW09BLofS39EOnp6kodPmC7rOPPvGAgAD+SACAAZJksA==
Date: Thu, 3 Apr 2025 11:30:50 +0000
Message-ID: <CY5PR11MB6211021207DE5ECAA43BF26595AE2@CY5PR11MB6211.namprd11.prod.outlook.com>
References: <20250401153225.96379-4-anshuman.gupta@intel.com>
 <20250401201349.GA1676401@bhelgaas>
 <CAJZ5v0irNFX6dFrStinNXamrhP143=yjjfx4iK0pY+-dTEkviw@mail.gmail.com>
In-Reply-To: <CAJZ5v0irNFX6dFrStinNXamrhP143=yjjfx4iK0pY+-dTEkviw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6211:EE_|LV1PR11MB8841:EE_
x-ms-office365-filtering-correlation-id: eaca8ca5-dabe-4dfa-3b04-08dd72a2fc71
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cmFZYklRZkZNUjNPbldjTUtPS3hmYkhBZElMS1pmZHVlZmVLM3VEcWNNYkVF?=
 =?utf-8?B?YTdnR1REb1dzSk4ySnoxL1hKUzFZc2hjZGhTRVJNSlRhbFR0YVpjemV2OGRT?=
 =?utf-8?B?MHVzQm9maXVpZXk1QXFmQ1p0algySlpET0pKT09qdk5Eamc0T2xVVnVVMmRR?=
 =?utf-8?B?R1BBenFaQkFmYUtaUVJVdDNtS0ZZZExwYWxZaGhYRUpiMnlSVTZjaVhqc1pV?=
 =?utf-8?B?K1k1RnpsMzNuVVRrNC9FQjJyL0dZWEUwTGV3TXZqMkdUdjgzL29JRUNVNEpr?=
 =?utf-8?B?d3MxMngxY1lXVGdGZC8vN2dtZ1p5ZHhkRndudmdGLytubWdjM0JLMTMrZDB2?=
 =?utf-8?B?TXlvR1llemhDK2hBeW1aRmhtUTE4NEYrdWpDZmFXMEVqKzVJbmM0clFxenJC?=
 =?utf-8?B?L3g4bUo1Mm5OaWtrdGNkSzgwdDlzMVNLNHUyR1YvYWpyS3B4V28xSG5CQVQ0?=
 =?utf-8?B?UUkyUU1qdEg2OCszVjZqSDQ1YnQ0d002TFJLbGs2SDM1MnROWXdwYU81SElN?=
 =?utf-8?B?b1FkbDZlZ0kxWitMQlArMUFLSVFqdzNQZHByTFJtakRCSTZ3TThVbHhMdkZa?=
 =?utf-8?B?SkVPdEhYanFCKzFaZ3ROMW5BYXo3MlZUTGlQS1V6TXZ0emRZWTA3a1FGN0hm?=
 =?utf-8?B?b2M5OEh4aW1CbzI4cnF4Z1ZqU0JDemZ2ZzFJallKUXl4M0pHOU12MHNiemZy?=
 =?utf-8?B?SHdJbDU5Q0d5L3FsdENWanRBWXdUNFBPT3NCTUsxSkZWVzRxV0NQREZZaVQ4?=
 =?utf-8?B?aHR3anFlRlhSRlJRNmk0eGlTbm1oUkltVUtubGtvSGNaMVh3R2lWdmNuNXV3?=
 =?utf-8?B?QnhXQmtwY3JVNG9GL2RCWWUwa3hGbkYraTJRTG5CeXIzQkhndE0yNUNyZWs2?=
 =?utf-8?B?Vmo4bENXclpmK1ZOc2RXa2E4T1FJQk1STER2Z3RpWnJRYkFTeXUwSDQybG0y?=
 =?utf-8?B?aFAvMzQyK3BvMWVwTCtlVkVLOS85cEczbnlYckF4dm93clAyRUlPSUZBb0I2?=
 =?utf-8?B?czJwWFRyOUJzOVl0VEx3L2R5OG1JU0FleHdMalFvZ21WaVQ1Lzh6V28yWFV4?=
 =?utf-8?B?Wmp1aDBOSnVRZDlnRi90QUJjeEtoTXRlVUFQMm9TWU5zS2NCZjhFWTVidmp1?=
 =?utf-8?B?ZVZ1Y3V3aWxyV3V4Q1RnUlpUY0NiZFpybHVwZ3U3NVVscWo3cGh0KzBjRlZQ?=
 =?utf-8?B?N2drbW1DQ1NlSDQ5dHNCWTNJcGxLMEI3U3N2M0RvQlVFbFA4VGJlKzZlN09w?=
 =?utf-8?B?a1NieVVkcm9VUlNGdnNrVThGTkNVb3NIQno5dUxmZXlEcXlmSVBqY3UzaFlu?=
 =?utf-8?B?dEZ5OTZXcDR5UFB0QUk0cmNTb24yYW5tNnl4azJWVmRFVk9KSXpjK1dnSGNZ?=
 =?utf-8?B?T1Jaa1hkUW8ycmhpcnREaEUybUpTUmVpWUczekRNYVAySkJtVWdHRS9ueDdZ?=
 =?utf-8?B?MmFsK3dhckF6bUdKOVgwY2RjMHlLY002bVZORlRsYmsydXNvcFRnUWxDR0gx?=
 =?utf-8?B?NHM5M0xUYjFxdUJjL2VUdE9qWWVDSkhWSXNQN0I5ZHJrMkhNSEovSmVtaUN1?=
 =?utf-8?B?VDFrNktDVmRWTDZaVjFhYlJhZkFXcTRiSVdXQjE3VVhZa0hYYjJmVS9tWExP?=
 =?utf-8?B?b1A5ekp1clBuRDc2WXgyWHdxUTNKNkFXb2xoTVF2Sno1NjNEeTk4cVFIc2RX?=
 =?utf-8?B?OUtkUHBzVEJLN0ZpbktFaDBOWnVHOGlqYXBPUlVOM1dDZzU4ZnpWSEtjMWNx?=
 =?utf-8?B?eUhZM1MrSXdQVnF3Y0JMUklsbm55Wk5hSittM3p0REJsSXB3cWdSRGFvOURL?=
 =?utf-8?B?aEtmZEtUdVJxU3EyTlRvSU03UzR3bFQ5UFZpS2lIcGJCQnZSZGhCbTV4dFBv?=
 =?utf-8?B?NFZtaXFCTXY4U0xQYjUreGZHZUNPVmtjZDhMYXg1cUhyUExHUUV2Zk55YjI2?=
 =?utf-8?Q?8B/V2qW1myGVnXa4XCAqh2t272vSeR44?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6211.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0tIRnNtTjhxWHBZZHE0aW1XQkZQZnh4d2hycDBTcmxXdzVkeWk0bTlrZWZw?=
 =?utf-8?B?UVNBRDhIQ1RpQWFOMGM1T2tMMU11clE2Z2kyQ2Y0VnRkN3JYV2JVeUEyby9a?=
 =?utf-8?B?NFdNdElWSVQyOTUveWZKZXpabHlUT2xHalQ0cnF3R1lWcERRcjljZWc4M2N4?=
 =?utf-8?B?eHMxdzM0bGdqMkJXeWRQdXpwWVhPdTF3amNWcDg0OTBDOW9nYnMwNStkRmVJ?=
 =?utf-8?B?d2MwYm9XbGZwbmp1aFZjMXVNN242WlQvYStGQnhyUlpoZ09ZSGk1aEs2dm1m?=
 =?utf-8?B?bEt3N2R2VUtyZ21nMkFNemJidWUxR25NWXZVRjMwbUVnOGRkN2hETXpKQW9V?=
 =?utf-8?B?QzNlcHFsejNUUzZ1NElpeVhvdVFscUpYYlBQdi85blhsRXdza1VxN2NoVURB?=
 =?utf-8?B?QmwyU3J3MXFJSzJ0U0FvZ1gydkxUQm9mRXhMbTA5WnUvNW15Z1U4Zk9pVjhK?=
 =?utf-8?B?M09IRm5VRkp6OFJ0dVptdzdxOGZPcnhwWGxLVW80RVVTQXlRNm9iekxOVFRl?=
 =?utf-8?B?ZTlHcVRBT0taUkRnRUoxcmoyZnhyb2dzSk1XRUdqT3pDTTBYcWhKU0cweDU3?=
 =?utf-8?B?Um81RURUaHlFT0k5Y1dRT0t5UkNycFV6UUwxU3cyRXhXQTE3SE9sbTRHRU0v?=
 =?utf-8?B?Z2p2TzZGdDRvQlVNOTUwRjZqNUtLU2FIczF4T2ZNNHRvSjA4UUVZV1JBZzU3?=
 =?utf-8?B?UDRJVmhaZ2g0cXkvQlVNcnk2Vnp2cS9EUE5UbitIczdEWlFaZHBjNzRpVnIy?=
 =?utf-8?B?azcvbjloZVY1dDFOMGtES1VqMXVYeER0YVg2ZHZCQ3l5K2hyY0Q3NllDSlI1?=
 =?utf-8?B?dTkxNEhqVS9iazZyMi9NTnFOYlhNaDJpaDQ0SXBaNUdsNFZkM283enRMeSto?=
 =?utf-8?B?VkxEWmlCQS9TRU5NblVEWHF3MmlzTkNHZ3dZa2QwRTVqOWtXeThwY2pMeDFK?=
 =?utf-8?B?TGdMb1k0d2FwdkZEOGp6UmZldE1veWt3WTZ1NVFNVWVmMXhTL21RSHZnYlhz?=
 =?utf-8?B?YjM0THFVSVFwTmNnNTdiTVdjNEc0RW9kWFdnUGhISmt0WkcxUks5L2NBSWhh?=
 =?utf-8?B?TjhsRzVTc1FTdEFGNk5CZlk3RVEwOU1ia2tGVy8vQ0FESVc0TkdNaWt6T0tN?=
 =?utf-8?B?VWJkU0VlUStqclNzT2p0a050VWQvUzJNV0dYTWpZb0xJd1dlYjlxTkRLZlNa?=
 =?utf-8?B?MWFvcVhncE56WGlZSzJ1a2hUL1ptV245Rzl1Rnk3WEg4cjlER1ZvMmcxQWE4?=
 =?utf-8?B?U2lyRFcwQ2kyWUExT0I2dmltbm1nWnNDeUtDZkt3T0pIQXd3VzZ3OHhlWnRN?=
 =?utf-8?B?UFA5NkJ1amxkKzl6dG1GM2Q5bzZiYXhiVWVqRkJibXBER1Q1akJ6VVg5UEdE?=
 =?utf-8?B?cFJ1elpNTUpBNE8vSlcvQ1JKUnhodjA5TXM0bGY3RytRODBLaEQ1NVFTOStz?=
 =?utf-8?B?bHlaaXZQOWJPaUk0MlZaaFUrV1owa0JFYWlWdWxFZGlGbzAyZUZxQXh4anpP?=
 =?utf-8?B?dy8yQUI5QTZhZ3M1dnZDekxIMGlTbmJvYkY5V1RYaW1KQlF5ZmwvcTBqdFBv?=
 =?utf-8?B?K2VXSmI3NGFqV0hTcGtSRHdSQm8yWkN0RnlZT1VqNnM0ZExJeThEVG9JOW0x?=
 =?utf-8?B?RThtdFJsZkwzRGlRcWxJM2FuWUdnYmlzdlFEZHIzZmwxOXRoVFhZbmNkaHRj?=
 =?utf-8?B?VkxzbTlhbFllcHo3b3JWL0NOWnN6Z0dOSVYwYzFSc0lyK3NyUkdCMXdHbm1C?=
 =?utf-8?B?Y3VMZ1kzUi9SSGhRcXZrTUxCQWl1K1MrRFpTemdFSW1EcXFjRlJwOXBMbUdH?=
 =?utf-8?B?bE5rOFBSRWhFa09MOFlVVkxVR3huZlZEVk95VEQ5Q2l1L0VoYTRzN2dqTEhl?=
 =?utf-8?B?a1FIWXUwSURVL3ZWSExlQ3R4ZXROOUxkdWlmQkZJa3pRaWdCcjdTV3YrZWpn?=
 =?utf-8?B?aDh2S0xCbnl1MzlQQndhVDhTMFErWkVhMkl3NE03RUpTWDFDYkRRZEVJWitv?=
 =?utf-8?B?N0I2RTVHSWNZZGNLZVpYcFpqVkQ3Mk15L01jSzdUdkFsa1ozZUttYU1Rei90?=
 =?utf-8?B?ZnpFQ3dtSlJCNnJwa1hTc3dvWmJDRTVpeFdncU5hMWp6V3R1elUxMDA3NmlX?=
 =?utf-8?Q?ue49CsEBSU6AWBryBkpythRYm?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: eaca8ca5-dabe-4dfa-3b04-08dd72a2fc71
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2025 11:30:50.1410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eU8DFzAdyzRmnd9OSkUqrIVaLzk9XmSYl7lZQtNqmH3s2mPjsh3G5oOvrArxR7gOWykHxyFCMNiAZ0oztrEoZzVBbGSlSm2dzZGIoM5Cn3M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR11MB8841
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmFmYWVsIEouIFd5c29j
a2kgPHJhZmFlbEBrZXJuZWwub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIEFwcmlsIDIsIDIwMjUg
NDo1NCBQTQ0KPiBUbzogQmpvcm4gSGVsZ2FhcyA8aGVsZ2Fhc0BrZXJuZWwub3JnPjsgR3VwdGEs
IEFuc2h1bWFuDQo+IDxhbnNodW1hbi5ndXB0YUBpbnRlbC5jb20+DQo+IENjOiBpbnRlbC14ZUBs
aXN0cy5mcmVlZGVza3RvcC5vcmc7IGxpbnV4LWFjcGlAdmdlci5rZXJuZWwub3JnOyBsaW51eC0N
Cj4gcGNpQHZnZXIua2VybmVsLm9yZzsgcmFmYWVsQGtlcm5lbC5vcmc7IGxlbmJAa2VybmVsLm9y
ZzsNCj4gYmhlbGdhYXNAZ29vZ2xlLmNvbTsgaWxwby5qYXJ2aW5lbkBsaW51eC5pbnRlbC5jb207
IERlIE1hcmNoaSwgTHVjYXMNCj4gPGx1Y2FzLmRlbWFyY2hpQGludGVsLmNvbT47IFZpdmksIFJv
ZHJpZ28gPHJvZHJpZ28udml2aUBpbnRlbC5jb20+OyBOaWxhd2FyLA0KPiBCYWRhbCA8YmFkYWwu
bmlsYXdhckBpbnRlbC5jb20+OyBHdXB0YSwgVmFydW4gPHZhcnVuLmd1cHRhQGludGVsLmNvbT47
DQo+IHZpbGxlLnN5cmphbGFAbGludXguaW50ZWwuY29tOyBTaGFua2FyLCBVbWEgPHVtYS5zaGFu
a2FyQGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAwMy8xMl0gUENJL0FDUEk6IEFk
ZCBhdXggcG93ZXIgZ3JhbnQgbm90aWZpZXINCj4gDQo+IE9uIFR1ZSwgQXByIDEsIDIwMjUgYXQg
MTA6MTPigK9QTSBCam9ybiBIZWxnYWFzIDxoZWxnYWFzQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiA+
DQo+ID4gT24gVHVlLCBBcHIgMDEsIDIwMjUgYXQgMDk6MDI6MTZQTSArMDUzMCwgQW5zaHVtYW4g
R3VwdGEgd3JvdGU6DQo+ID4gPiBBZGRpbmcgYSBub3RpZmllciB0byBub3RpZnkgYWxsIFBDSWUg
Y2hpbGQgZGV2aWNlcyBhYm91dCB0aGUgYmxvY2sNCj4gPiA+IG1haW4gcG93ZXIgcmVtb3ZhbC4g
SXQgaXMgbmVlZGVkIGJlY2F1c2UgdGhlb3JldGljYWxseSBtdWx0aXBsZSBQQ0llDQo+ID4gPiBF
bmRwb2ludCBkZXZpY2VzIG9uIHNhbWUgUm9vdCBQb3J0IGNhbiByZXF1ZXN0IGZvciBBVVggcG93
ZXIgYW5kDQo+ID4gPiBfRFNNIG1ldGhvZCBjYW4gcmV0dXJuIHdpdGggODAwMDAwMDBoIHNpZ25p
ZmllcyB0aGF0IHRoZSBoaWVyYXJjaHkNCj4gPiA+IGNvbm5lY3RlZCB2aWEgdGhlIHNsb3QgY2Fu
bm90IHN1cHBvcnQgbWFpbiBwb3dlciByZW1vdmFsIHdoZW4gaW4NCj4gPiA+IEQzQ29sZC4NCj4g
Pg0KPiA+IEkgd2lzaCB0aGUgc3BlYyB1c2VkIGRpZmZlcmVudCBsYW5ndWFnZSBoZXJlLiAgIkQz
Y29sZCIgKm1lYW5zKiAibWFpbg0KPiA+IHBvd2VyIGlzIHJlbW92ZWQiIChQQ0llIHI2LjAsIHNl
YyA1LjMuMS40LjIpLCBzbyBpdCBkb2Vzbid0IG1ha2Ugc2Vuc2UNCj4gPiB0byBzYXkgdGhhdCAi
dGhlIHNsb3QgY2Fubm90IHN1cHBvcnQgbWFpbiBwb3dlciByZW1vdmFsIHdoZW4gaW4NCj4gPiBE
M2NvbGQiLiAgSWYgYSBkZXZpY2UgaXMgaW4gRDNjb2xkLCBpdHMgbWFpbiBwb3dlciBoYXMgYmVl
biByZW1vdmVkIGJ5DQo+ID4gZGVmaW5pdGlvbi4NCj4gPg0KPiA+IEkgc3VwcG9zZSB0aGUgc3Bl
YyBpcyB0cnlpbmcgdG8gc2F5IGlmIHRoZSBkcml2ZXIgaGFzIGNhbGxlZCB0aGlzIF9EU00NCj4g
PiB3aXRoIDgwMDAwMDAwaCwgaXQgbWVhbnMgdGhlIHBsYXRmb3JtIG11c3Qgbm90IHJlbW92ZSBt
YWluIHBvd2VyIGZyb20NCj4gPiB0aGUgZGV2aWNlIHdoaWxlIHRoZSBzeXN0ZW0gaXMgaW4gUzA/
ICBJcyB0aGF0IHdoYXQgeW91IHRoaW5rIGl0DQo+ID4gbWVhbnM/DQo+ID4NCj4gPiBUaGUgMmgg
cmV0dXJuIHZhbHVlIGRlc2NyaXB0aW9uIHNheXMgaXQgImluZGljYXRlcyB0aGF0IHRoZSBwbGF0
Zm9ybQ0KPiA+IHdpbGwgbm90IHJlbW92ZSBtYWluIHBvd2VyIGZyb20gdGhlIHNsb3Qgd2hpbGUg
dGhlIHN5c3RlbSBpcyBpbiBTMCwiDQo+ID4gc28gSSBndWVzcyB0aGF0IG11c3QgYmUgaXQuDQo+
ID4NCj4gPiBJbiB0aGlzIHNlcmllcywgcGNpX2FjcGlfYXV4X3Bvd2VyX3NldHVwKCkgb25seSBz
dXBwbGllcyBhIDE2LWJpdA0KPiA+IGF1eF9wd3JfbGltaXQgdmFsdWUsIHNvIHRoZSBkcml2ZXIg
Y2Fubm90ICpyZXF1ZXN0KiB0aGF0IHRoZSBwbGF0Zm9ybQ0KPiA+IG5vdCByZW1vdmUgbWFpbiBw
b3dlci4NCj4gPg0KPiA+IFNvIEkgZ3Vlc3MgdGhlIG9ubHkgc2NlbmFyaW8gd2hlcmUgdGhlIF9E
U00gcmV0dXJucyA4MDAwMDAwMGggaXMgd2hlbg0KPiA+IHRoZSBwbGF0Zm9ybSBpdHNlbGYgb3Ig
b3RoZXIgZGV2aWNlcyBwcmV2ZW50IHRoZSByZW1vdmFsIG9mIG1haW4NCj4gPiBwb3dlci4gIEFu
ZCB0aGUgcG9pbnQgb2YgdGhlIG5vdGlmaWVyIGlzIHRvIHRlbGwgZGV2aWNlcyB0aGF0IHRoZWly
DQo+ID4gbWFpbiBwb3dlciB3aWxsIG5ldmVyIGJlIHJlbW92ZWQgd2hpbGUgdGhlIHN5c3RlbSBp
cyBpbiBTMC4gIElzIHRoYXQNCj4gPiByaWdodD8NCj4gPg0KPiA+ID4gVGhpcyBtYXkgZGlzcnVw
dCBmdW5jdGlvbmFsaXR5IG9mIG90aGVyIGNoaWxkIGRldmljZS4NCj4gPg0KPiA+IFdoYXQgc29y
dCBvZiBkaXNydXB0aW9uIGNvdWxkIGhhcHBlbj8gIEkgd291bGQgdGhpbmsgdGhhdCBpZiB0aGUg
X0RTTQ0KPiA+IHJldHVybnMgODAwMDAwMDBoLCBpdCBqdXN0IG1lYW5zIHRoZSBkZXZpY2Ugd2ls
bCBub3QgaGF2ZSBtYWluIHBvd2VyDQo+ID4gcmVtb3ZlZCwgc28gaXQgd29uJ3Qgc2VlIHRoYXQg
cG93ZXIgc3RhdGUgdHJhbnNpdGlvbi4gIFRoZSBvbmx5DQo+ID4gImRpc3J1cHRpb24iIHdvdWxk
IGJlIHRoYXQgd2UncmUgdXNpbmcgbW9yZSBwb3dlci4NCj4gPg0KPiA+ID4gTGV0J3Mgbm90aWZ5
IGFsbCBQQ0llIGRldmljZXMgcmVxdWVzdGVkIEF1eCBwb3dlciByZXNvdXJjZSBhbmQgTGV0DQo+
ID4gPiBQQ0llIEVuZCBQb2ludCBkcml2ZXIgaGFuZGxlIGl0IGluIGl0cyBjYWxsYmFjay4NCj4g
Pg0KPiA+IFdyYXAgdG8gZmlsbCA3NSBjb2x1bW5zLg0KPiA+DQo+ID4gcy9BZGRpbmcvQWRkLw0K
PiA+IHMvTGV0J3Mgbm90aWZ5L05vdGlmeS8NCj4gPiBzL2FuZCBMZXQvYW5kIGxldC8NCj4gPiBz
L0VuZCBQb2ludC9FbmRwb2ludC8gKHNldmVyYWwgcGxhY2VzIGhlcmUgYW5kIGJlbG93KQ0KPiA+
DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBbnNodW1hbiBHdXB0YSA8YW5zaHVtYW4uZ3VwdGFAaW50
ZWwuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgZHJpdmVycy9wY2kvcGNpLWFjcGkuYyAgIHwgMzQg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLQ0KPiA+ID4gIGluY2x1ZGUvbGludXgv
cGNpLWFjcGkuaCB8IDEzICsrKysrKysrKysrKysNCj4gPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDQ0
IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvcGNpL3BjaS1hY3BpLmMgYi9kcml2ZXJzL3BjaS9wY2ktYWNwaS5jIGluZGV4DQo+
ID4gPiAwNDE0OWYwMzc2NjQuLmQxY2ExNjQ5ZTZlOCAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZl
cnMvcGNpL3BjaS1hY3BpLmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvcGNpL3BjaS1hY3BpLmMNCj4g
PiA+IEBAIC0xNDIxLDYgKzE0MjEsMzIgQEAgc3RhdGljIHZvaWQgcGNpX2FjcGlfb3B0aW1pemVf
ZGVsYXkoc3RydWN0DQo+IHBjaV9kZXYgKnBkZXYsDQo+ID4gPiAgICAgICBBQ1BJX0ZSRUUob2Jq
KTsNCj4gPiA+ICB9DQo+ID4gPg0KPiA+ID4gK3N0YXRpYyBCTE9DS0lOR19OT1RJRklFUl9IRUFE
KHBjaV9hY3BpX2F1eF9wb3dlcl9ub3RpZnlfbGlzdCk7DQo+ID4gPiArDQo+ID4gPiArLyoqDQo+
ID4gPiArICogcGNpX2FjcGlfcmVnaXN0ZXJfYXV4X3Bvd2VyX25vdGlmaWVyIC0gUmVnaXN0ZXIg
ZHJpdmVyIG5vdGlmaWVyDQo+ID4gPiArICogQG5iOiBub3RpZmllciBibG9jaw0KPiA+ID4gKyAq
DQo+ID4gPiArICogVGhpcyBmdW5jdGlvbiBzaGFsbCBiZSBjYWxsZWQgYnkgUENJZSBFbmQgUG9p
bnQgZGV2aWNlIHJlcXVlc3RlZA0KPiA+ID4gK3RoZSBBdXgNCj4gPiA+ICsgKiBwb3dlciByZXNv
dXJjZSBpbiBvcmRlciB0byBoYW5kbGUgdGhlIGFueSBzY2VuYXJpbyBncmFjZWZ1bGx5DQo+ID4g
PiArd2hlbiBvdGhlcg0KPiA+ID4gKyAqIGNoaWxkIFBDSWUgZGV2aWNlcyBBdXggcG93ZXIgcmVx
dWVzdCByZXR1cm5zIHdpdGggTm8gbWFpbiBwb3dlcg0KPiByZW1vdmFsLg0KPiA+ID4gKyAqIFBD
SWUgZGV2aWNlcyB3aGljaCByZWdpc3RlciB0aGlzIG5vdGlmaWVyIHNoYWxsIGhhbmRsZSBObyBt
YWluDQo+ID4gPiArcG93ZXINCj4gPiA+ICsgKiByZW1vdmFsIHNjZW5hcmlvIGFjY29yZGluZ2x5
Lg0KPiA+DQo+ID4gVGhpcyB3b3VsZCBhY3R1YWxseSBiZSBjYWxsZWQgYnkgdGhlICpkcml2ZXIq
IChub3QgYnkgdGhlIGRldmljZSkuDQo+IA0KSGkgUmFmYWVsLA0KVGhhbmtzIGZvciByZXZpZXcu
DQo+IEFwYXJ0IGZyb20gdGhpcywgdGhlcmUgc2VlbXMgdG8gYmUgYSBkZXNpZ24gaXNzdWUgaGVy
ZSBiZWNhdXNlIGl0IHdvbid0IG5vdGlmeQ0KPiBldmVyeSBkcml2ZXIgdGhhdCBoYXMgcmVxdWVz
dGVkIHRoZSBBdXggcG93ZXIsIGp1c3QgdGhlIG9uZXMgdGhhdCBoYXZlIGFsc28NCj4gcmVnaXN0
ZXJlZCBub3RpZmllcnMuDQpJTUhPIHRoYXQgaXMgd2hhdCBpbnRlbmRlZCwgaWYgYW55IGRldmlj
ZSBoYXMgZnVuY3Rpb25hbCBpbXBhY3QgaW4gb3VyIGNhc2UgaXQgaXMNCklOVEVMIEdQVSBoYXMg
ZnVuY3Rpb25hbCBpbXBhY3QgaWYgb3RoZXIgUENJZSBkZXZpY2UncyAob24gc2FtZSByb290IHBv
cnQpIEF1eA0KUG93ZXIgcmVxdWVzdCByZXR1cm5zIHdpdGggMHgyLiBXZSBuZWVkIHRvIGhhbmRs
ZSBzdWNoIGNhc2UgdG8gaGFuZGxlIGl0IGdyYWNlZnVsbHkuDQo+IA0KPiBTbyB0aGlzIGFwcGVh
cnMgdG8gYmUgYW4gb3B0LWluIGZyb20gZ2V0dGluZyBub3RpZmljYXRpb25zIG9uIEF1eCBwb3dl
cg0KPiByZXF1ZXN0IHJlamVjdGlvbiByZXNwb25zZXMgdG8gcmVxdWVzdHMgZnJvbSBvdGhlciBk
cml2ZXJzIHJlcXVlc3RpbmcgQXV4DQo+IHBvd2VyIGZvciB0aGUgc2FtZSBSb290IFBvcnQsIGJ1
dCB0aGUgY2hhbmdlbG9nIG9mIHRoZSBmaXJzdCBwYXRjaCBhbHJlYWR5DQo+IGNsYWltZWQgdGhh
dCB0aGUgYWdncmVnYXRpb24gb2YgcmVxdWVzdHMgd2FzIG5vdCBzdXBwb3J0ZWQuICBTbyBpZiBv
bmx5IG9uZQ0KPiBkcml2ZXIgd2lsbCBiZSBhbGxvd2VkIHRvIHJlcXVlc3QgdGhlIEF1eCBwb3dl
ciBmb3IgdGhlIGdpdmVuIFJvb3QgUG9ydCwgd2h5DQo+IHdvdWxkIHRoZSBub3RpZmllcnMgYmUg
bmVjZXNzYXJ5IGFmdGVyIGFsbD8NClBsZWFzZSBndWlkZSB1cywgaWYgd2UgcmVtb3ZlIHRoZSBh
Ym92ZSBsaW1pdGF0aW9uIGZyb20gdGhlIGNvbW1pdCBsb2cuDQpUaGVuIGRvIHdlIGhhdmUgYW55
IGRlc2lnbiBpc3N1ZSB3aXRoIG5vdGlmaWVyIGFwcHJvYWNoID8NClRoYW5rcywNCkFuc2h1bWFu
Lg0K

