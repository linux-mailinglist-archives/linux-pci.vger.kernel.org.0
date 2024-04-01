Return-Path: <linux-pci+bounces-5473-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1288938E2
	for <lists+linux-pci@lfdr.de>; Mon,  1 Apr 2024 10:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F10D1C20C85
	for <lists+linux-pci@lfdr.de>; Mon,  1 Apr 2024 08:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA408BF0;
	Mon,  1 Apr 2024 08:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mnn8ahkH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7ED1B671;
	Mon,  1 Apr 2024 08:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711959580; cv=fail; b=Zwbdjm/9xRtx/dac/mIQ/Z76bgCPNGTgjta49iP1ZR+HF2oEDUXMROvsjq6UkytFgA9eRtnbOinh3EOtdMqch8uep7mI2jdSnWBmE0sIyIMy60EkE6pKXuy0DgM41BhySq1WgwySM8PDc61OPkkHYhNZ6xwxqrS8n4JFJU8T5yE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711959580; c=relaxed/simple;
	bh=Dkyr23tDZO5BysELTC1b/oIQJpfAcfFK4NNUqUGaObY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GBImCYdtGCZ9c7HA7E1c5jjkiD1UnUrooejOEEbLJVf+iqc6liC7oxnOoJasSS4ozr4lQuUGvVPtmCYllXIlrjP7gXAaHlVHvHzoafkCgrTS6J2tB6QkUJuVBx7Ak/oPfUurbO8P4/vNxFQw6/ojEodzlKSSGa97+OiDQOT8940=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mnn8ahkH; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711959579; x=1743495579;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Dkyr23tDZO5BysELTC1b/oIQJpfAcfFK4NNUqUGaObY=;
  b=Mnn8ahkHDKuj1oZmyqbn+kfesM5EMcasI4/SQPSK3WxYGKwQr3e7bp51
   E6e0Jz9wg4Wnmu7Q1xofMuNosTveizk7Ag00No/l772Viq+av3nvHqMGu
   p4yoX81Qdtdv3Twz3c0aUnHYhMRq1Wtke1jB0sqQTT1fWIuZnFU+fRoTe
   vmLEu2DDe7sf11+E5G3ZMhw5P762nnmjoVzguznDC3fzHeHKVjT91ZVnc
   i7sTx1UDbK/PaP/IC4eAFZlxHrx42H4FheqBZdTYrXSMoOc35aS2i6R+S
   1zeEwi3IeEcG+TkuNIW72IzlK7TWKOCtBXPg6G2s5T5mTqvzyYWf9DLYb
   A==;
X-CSE-ConnectionGUID: qVCzzyz6TlOZNjMFyH6sUw==
X-CSE-MsgGUID: 3qzUjCHgTFaZXqy8hzfevA==
X-IronPort-AV: E=McAfee;i="6600,9927,11030"; a="7206651"
X-IronPort-AV: E=Sophos;i="6.07,171,1708416000"; 
   d="scan'208";a="7206651"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 01:19:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,171,1708416000"; 
   d="scan'208";a="17726588"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Apr 2024 01:19:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 1 Apr 2024 01:19:37 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 1 Apr 2024 01:19:37 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 1 Apr 2024 01:19:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W521OR2Q1xk9ciYf+RA5NI/vQ9Qfu/HpbJYZZIqnsZRl2lcY7xxmt3KSnDDypIgYgHJU0W5gFIL0cg1NrD+Kbm5uQ4dLQW+FaEvroh5CtfLzmhIdnA4lliznYtP3Fnyi6T7+xR330e87puTEVaTeN9eguKf3fo4fegM+QHZVbIAKH2xD43ndm1JTGdHIgiki716PWTzoIC7Yu2T+Hk94e2OvDVHcqybWOJaEAXpUfQI4kCUy2Zyum53hvRk/OzbOhvyTHUivRqN/Y1lkZkT65H5er0nHpbU6RDGzAA0Ca+mKCMYFVCtcFCuMxCCDas8JSequIr1IB5C2Sfe9trC4vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dkyr23tDZO5BysELTC1b/oIQJpfAcfFK4NNUqUGaObY=;
 b=d8PEZeRkOorSGDp19a0Fa6Uf+m7UVlMnIYISAWg3MyCYRVkudE6twIpoqwuecuiEIM8slNdkAB31rWRdUYLnp+35m4rspkk+DorZfRgmJQ3Z9q4uG+XjDb8ohj36v72pu8RNulMnb7hwHN9wn+9WB2UciOTK0VynCgGVqACoIFBvJ9PB55Rm2Je47MV4+B95VyqYMXlgOIwHFb/wN8vL9eevGMQlZmVY4IguSmpbmuNkmZXtcp2WxwqJSyE2VTCpGh/VgrYE4mpgSMlpRR4PtIdysM70JsGfTx+Ob+zhRb2Hao3n6I5xuoQ13CfGOVc/Uf/hHvPgkJgSOpdHeRxR7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by SJ0PR11MB4957.namprd11.prod.outlook.com (2603:10b6:a03:2df::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Mon, 1 Apr
 2024 08:19:35 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::21c:ed31:369e:d9c1]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::21c:ed31:369e:d9c1%6]) with mapi id 15.20.7452.019; Mon, 1 Apr 2024
 08:19:35 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "torvalds@linux-foundation.org"
	<torvalds@linux-foundation.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
	=?utf-8?B?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, "Lukas
 Wunner" <lukas@wunner.de>, Jonathan Corbet <corbet@lwn.net>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: RE: [PATCH v3] cleanup: Add usage and style documentation
Thread-Topic: [PATCH v3] cleanup: Add usage and style documentation
Thread-Index: AQHagjO6wPJsWPMJmU6m9/S9PbTAlLFTFiug
Date: Mon, 1 Apr 2024 08:19:34 +0000
Message-ID: <BL1PR11MB5271DB63688BF220D0317AC08C3F2@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <171140738438.1574931.15717256954707430472.stgit@dwillia2-xfh.jf.intel.com>
 <171175585714.2192972.12661675876300167762.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <171175585714.2192972.12661675876300167762.stgit@dwillia2-xfh.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|SJ0PR11MB4957:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z6AdnCg/c2O5XAGQm/632WQNacuUdH3DgcyVyfFkVHZXVMmjAD1L2iSTI0A/bPWjz/Pz2O93w77x1by3br2S2uoi7/10XLckGyXtrGWQ5CkfdZ2HU5p4RK1/OXQ6MUCgaOHfHBbrN/rkeD4eil6DMYsorcGokSXEL1IFzEuiW5uoJL+f1msNX0WtxGoHMtLKc82jzFgQ73Frv56CllYa/Dgu6MJfl7n7KjIZ27ipSdQj1unAg5fFkXFhPge89h4oUA6wuFDYcvI6GVR5BuksEpD30VSaQD3V7Q4EEWcZlcIg9nwwTNLD3vtFTT6vbwrN8crLS7PgQDZB7Yo8mf2pmsYGmm9sVeMQdJGA3Z3j1eUca7LjPBV0IT2+hH5t3W4vjPE+4XVWamWXJ8lU67WvTMNt2KdQM0Smp5f6sjUxtpVVOtjdOLq5MTXcWbCy+5WYvXzDZPNzOWd0cf3i3qWvUFqOcEUxl7yRYAa8VjxCgNLaVfH8qYHkKZZ4zbe8u/RNnfV/FtoeuPyGkaBSCE9x0hhgYckoDe/pHVHVGhJrnlf2QXiOOeCsVK7fNUYAYsf+f4pbz0Mki0yDh19XsG5hRylhKJo8ByM7LuoUKaFtofE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RFd0TTJsRGYrRUxIcHVFaG5yYTVDSE5qaS9kcnd0V2xhZXVEWEpJUFFQaHNq?=
 =?utf-8?B?cVVwamEwS0tjcVRSYjY2Q1Y0RWR6QTFyUmdDTk9QVEVyUVh2YjZaRkJsTTRr?=
 =?utf-8?B?QnhMVVo3ZE5lcXpPNGdYMFNwcllFWnRlR3AxNEp4NkNsbTFmemVoVHI4bXk5?=
 =?utf-8?B?VUlSSnc3dCttMHpvV1U2MUNyUmZ4a0c4bmZ4dDJTdnRldWpmNG04bFBta2Zu?=
 =?utf-8?B?STZ1ZGJtR0lvK3VxRjVpVHNuQ0FNS2YzT2ExOXAyc3FqVXdkZnFpTFQ0LzRj?=
 =?utf-8?B?MEZsQzg4Y1BoekJzOXQwSFF4Y0d4UkZoU0lHWHUwbEJhOUpraytuYU9DVzli?=
 =?utf-8?B?RWZUc3lQSEFKVnc1NnhaUHh2TzdhT2x0ZGFLVCtYb1F1c3lQNVpmMiswZVN1?=
 =?utf-8?B?bnBMLzFmMjlUaDdEZjN6TUdBZTZiTXA5b1lmSlc4RUE1WGFUbGU3bUtVWVJQ?=
 =?utf-8?B?WElheXY5WUh4NlhBMFR4bFZSZm9QYjBTL3RibEQ5Tmpua0tDdjRBU0xqdUJS?=
 =?utf-8?B?c21pWUpvZi9aRHpqSzBiOG92L003WmcxcVNFUysreXV2QUxBck1nd1lVMjFT?=
 =?utf-8?B?dGgxU05iaE5Wc1pSNGhndkNoWFVBU3dldTQ1NllXSjBnaS96SWpDNmFHVjRO?=
 =?utf-8?B?ampOVnRNNWg3U1ZETmt1bTQzUWZLemI3Y0RKZXI4cWFCV1p2V09WamwrcXRJ?=
 =?utf-8?B?MElHbkQ4S0pwTVpyY1prTnd5d0FaYnV0QzFUR3hmWkJ3TWJnMG5BSWxDOEJz?=
 =?utf-8?B?WTJCclhHR2pITitVczVRdnk4akdnNXYxcWdPaXVOaFZ1ZUNpa2Zqb0pRbnUr?=
 =?utf-8?B?T29uREUrN2VNRVZYS05TcS9MMFVUWDNFUUw5THFPSzNHYmg0eC92WFZ2OE1O?=
 =?utf-8?B?QzF0REVwcmxMYnIrK1QxWTBSSlFXVktzUUErZTc2NStSTUF0UGFMajR4dFJO?=
 =?utf-8?B?Y09XbW5GMnJUQUptT3FRMlpWMUVMQUdXZEx1dWQvVmkyZGY5YjVGQVpXTFo1?=
 =?utf-8?B?ck1yZzQ0blhwZVZyc1htY040Z2ppQ3QxU1JGMmxINU5KUldmWDE0UmF4eExi?=
 =?utf-8?B?OGErSWNSc256d3FiVWZiOTVwN1JtMGFMRFA3bjA2UFBubndTWGY2WXpXK0M1?=
 =?utf-8?B?MnVBS1BxbDkrN3RzOTBJVmZNdXhJSGlib2RiWGlBNUlUeTY2TDYwZWFlbFJx?=
 =?utf-8?B?Tnc3SkQ1SHZ3SVVEMmx4ZU9aWUh4VzgzTkJPMXFOY2NrdTZxcjAxWFR2K3JV?=
 =?utf-8?B?VmNxVVE0TXlMTGgwN2I1bS9MNkxpa2pZODM2UGlINmQ4ckdsQkdSK1BFVno3?=
 =?utf-8?B?YjVwODQreDJ5empoRGtUZjNQNk1yOHRkVTJteXV4UWxNQUJsNWJxeDY0VDMy?=
 =?utf-8?B?ME9DYno5UEZtQTFhQXd5RW0ybDFjcU8zRmV6cHRnVlhVTk5HN0ZXYlcxNW83?=
 =?utf-8?B?V2RTZUlTanE5Z3BIbDJDem9MVDdia3NRL253TWdBRDljVndEYi8rQkxOYWh0?=
 =?utf-8?B?YlA0SUM2WUtrQVBYUkk1WlhPYnR0ay9TejdHN2JvdUpMaFZydTVWUlZ2ci9y?=
 =?utf-8?B?V09JRVlNS1BHQUNNNnlOS0NCLzE1cTZuMm9Fek5OejA3SEN2d1llQUQ1U3h5?=
 =?utf-8?B?YW4zWEVuSHVTSmNiU1RJT2d0eGJyclZPQlNaYlRQL24zc3I4MUFjUC83TjdT?=
 =?utf-8?B?dGwwMTVYdlFQS3M3aGdUMjhldHFqK25xaWNFbWQ3bitYQmdVNUI1Nk9ucWk5?=
 =?utf-8?B?Qko0WUhNd0RReXRJdk1HaHkraDc0OU93NFpzWnBqeUIwZVF0M3NMWVNGeVlX?=
 =?utf-8?B?MytqVnUxTFl0WmNOL0ZkZUliR2NlQUxUUWN5OEh5N1RISWc0Q1J5L2xDczU3?=
 =?utf-8?B?SnN6M1ova09MQmdpeHBRQ1hnazFuYUdjbjB5VGIxUFI5clN1RnJ2ajVEOUd0?=
 =?utf-8?B?Nk9xZHBtTklqVGdHZ043L2FJUGZvM2VENG1CK1VKTXkySUo2aDg4VjVjQnFX?=
 =?utf-8?B?MnJjSFBENkZuR0EvaitLL0FXLytPdWdIWnFwd0grUTk2UkJxcEpub1FIYWhl?=
 =?utf-8?B?TFhBZHVxOGhFaGpvdDJsL2JqU1BYa0NKdDVoem1HMHdtbVpzZTB1R0o1SlBu?=
 =?utf-8?Q?nXe5p0IY7axYud7uWZh2/MhxU?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c6bb1df-948f-41f7-a596-08dc52247719
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2024 08:19:34.9786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CcMXtQAmGL+T5lnewSiAJNbRVCQItF1+lY/Ng4P5eoHlpxYI9yVRlpBGgRzmMloMoWxFgkJ5Tt9YTCfi2FCtDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4957
X-OriginatorOrg: intel.com

PiBGcm9tOiBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT4NCj4gU2VudDog
U2F0dXJkYXksIE1hcmNoIDMwLCAyMDI0IDc6NDkgQU0NCj4gDQo+IFdoZW4gcHJvcG9zaW5nIHRo
YXQgUENJIGdyb3cgc29tZSBuZXcgY2xlYW51cCBoZWxwZXJzIGZvciBwY2lfZGV2X3B1dCgpDQo+
IGFuZCBwY2lfZGV2X3tsb2NrLHVubG9ja30gWzFdLCBCam9ybiBoYWQgc29tZSBmdW5kYW1lbnRh
bCBxdWVzdGlvbnMNCj4gYWJvdXQgZXhwZWN0YXRpb25zIGFuZCBiZXN0IHByYWN0aWNlcy4gVXBv
biByZXZpZXdpbmcgYW4gdXBkYXRlZA0KPiBjaGFuZ2Vsb2cgd2l0aCB0aG9zZSBkZXRhaWxzIGhl
IHJlY29tbWVuZGVkIGFkZGluZyB0aGVtIHRvIGRvY3VtZW50YXRpb24NCj4gaW4gdGhlIGhlYWRl
ciBmaWxlIGl0c2VsZi4NCj4gDQo+IEFkZCB0aGF0IGRvY3VtZW50YXRpb24gYW5kIGxpbmsgaXQg
aW50byB0aGUgcmVuZGVyaW5nIGZvcg0KPiBEb2N1bWVudGF0aW9uL2NvcmUtYXBpLy4NCj4gDQo+
IExpbms6IGh0dHA6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI0MDEwNDE4MzIxOC5HQTE4MjA4NzJA
YmhlbGdhYXMgWzFdDQo+IENjOiBCam9ybiBIZWxnYWFzIDxiaGVsZ2Fhc0Bnb29nbGUuY29tPg0K
PiBDYzogSXJhIFdlaW55IDxpcmEud2VpbnlAaW50ZWwuY29tPg0KPiBDYzogSmVzc2UgQnJhbmRl
YnVyZyA8amVzc2UuYnJhbmRlYnVyZ0BpbnRlbC5jb20+DQo+IENjOiBJbHBvIErDpHJ2aW5lbiA8
aWxwby5qYXJ2aW5lbkBsaW51eC5pbnRlbC5jb20+DQo+IENjOiBMdWthcyBXdW5uZXIgPGx1a2Fz
QHd1bm5lci5kZT4NCj4gQ2M6IFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz4N
Cj4gQ2M6IEpvbmF0aGFuIENvcmJldCA8Y29yYmV0QGx3bi5uZXQ+DQo+IFJldmlld2VkLWJ5OiBK
b25hdGhhbiBDYW1lcm9uIDxKb25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+DQo+IFNpZ25lZC1v
ZmYtYnk6IERhbiBXaWxsaWFtcyA8ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tPg0KDQpSZXZpZXdl
ZC1ieTogS2V2aW4gVGlhbiA8a2V2aW4udGlhbkBpbnRlbC5jb20+DQo=

