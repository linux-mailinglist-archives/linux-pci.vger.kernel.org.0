Return-Path: <linux-pci+bounces-1538-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1520781FE07
	for <lists+linux-pci@lfdr.de>; Fri, 29 Dec 2023 09:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76CDC1F23716
	for <lists+linux-pci@lfdr.de>; Fri, 29 Dec 2023 08:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A97163D2;
	Fri, 29 Dec 2023 08:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g+DqME4b"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB8B747B;
	Fri, 29 Dec 2023 08:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703837219; x=1735373219;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=L9YnlQO1srpO2eVzKzyudCgCzCp9Wxgrhl7+z6m2T4w=;
  b=g+DqME4balaVC2C6JV9oZPiTJQfSHmhVjkJbYjapK5Y1KLamWSvKZNRy
   NQxhExfNzWrcZIIbi9vAzK63NfQAQv4iZ3NQteK4UGvdqDZAmPtX5FIQ7
   gXzZqmYey1hchE+C2UyAySi8nBaDLYDZCP5juzyexvzgbEfV1ciH3YhE3
   qF6aix1VJd+H+TLYXoKIhzZywgaN5tgcqCA8EpI5L2OY0NOLZAaqwssWB
   6kTv2pc06X8c2WOPpElgvrMIlvYKX7ve9jIsoGXEw4f/GmVEUFhqwgGA4
   GcL5SPca2HMZLO6WIid/esIW/QQtZCHjeYHRfwCc+gdi5cCayGnefUUnv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="381604699"
X-IronPort-AV: E=Sophos;i="6.04,314,1695711600"; 
   d="scan'208";a="381604699"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2023 00:06:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="812998078"
X-IronPort-AV: E=Sophos;i="6.04,314,1695711600"; 
   d="scan'208";a="812998078"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Dec 2023 00:06:18 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 29 Dec 2023 00:06:18 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 29 Dec 2023 00:06:17 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 29 Dec 2023 00:06:17 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 29 Dec 2023 00:06:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NYKY2B1iiGXcJHKf4t+iSbU9gGuZRNECItbLpLR8nwOiY+Kvo4Wtr6whL7EIGYI+ElZRwRT0RU3P00Uz1yYXS2Z3kQ1q3nR5ABjmrWZ9+3g4wykUqHiTji4bSDlylfPls+p0ncbYS/BCGYqAQFd0RlYkWXpnOg2bNMi4jrUeazguTKCpawkbwNJ50c96SuJSmWwENZNL2vANI+Qi+VI56gBvmXy1Z4jIXKp+6Al0/kjGVzXTLdVrV6m1VOF57xfnqVgujWsoT4Ho04Pl9r+g0NAtqcmfJMjQ0rmfCrI36eEaLrYTt7f1niX0m3v29bELlL9ipIs8+aNxTho6v3no2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L9YnlQO1srpO2eVzKzyudCgCzCp9Wxgrhl7+z6m2T4w=;
 b=LvSWuAY+cRkwvLY1D4vPIAMQprVuDUz24uSAFhqzx0i936n7dVdyylrY7y0HTa87yfe4TzvEulxRPHeabGtsxJ582rxT5PCFHWAOkX/r2ZgxyD2cuzPmOLLzq2AwB4Fxt/tRKiP1MdyHZdD5N5+sgsCtqnrfsauLnBfr1k7nHLhUWv6fAH7HUJ+bRiIOqmnuiA401+68Q+ywcoyw1bVzsEUsUdjJ/DKd6XXJq4BdQDImv8Es1CCPUe8spghNE8owEUr2a2kKSeAg7xKlFFwdxhKzNyo7knfHJhBiwfsFD7+RLw8NkocCNTrcwI5mD9f/ZdH+MfiZP1PJj/1fsHd8Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW4PR11MB8290.namprd11.prod.outlook.com (2603:10b6:303:20f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.19; Fri, 29 Dec
 2023 08:06:15 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb%3]) with mapi id 15.20.7135.019; Fri, 29 Dec 2023
 08:06:15 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Ethan Zhao <haifeng.zhao@linux.intel.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>, "will@kernel.org"
	<will@kernel.org>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"lukas@wunner.de" <lukas@wunner.de>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH v9 2/5] iommu/vt-d: break out ATS Invalidation if
 target device is gone
Thread-Topic: [RFC PATCH v9 2/5] iommu/vt-d: break out ATS Invalidation if
 target device is gone
Thread-Index: AQHaOSNKMi5mz6+zfkaNoEyCzumA+7C+XMEwgABNZwCAATsksA==
Date: Fri, 29 Dec 2023 08:06:15 +0000
Message-ID: <BN9PR11MB5276ED0949E04BD25A4F91428C9DA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231228001646.587653-1-haifeng.zhao@linux.intel.com>
 <20231228001646.587653-3-haifeng.zhao@linux.intel.com>
 <BN9PR11MB5276D70FD60FD1E0733B35AE8C9EA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <17725ef5-d777-420b-9586-4aade103282e@linux.intel.com>
In-Reply-To: <17725ef5-d777-420b-9586-4aade103282e@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW4PR11MB8290:EE_
x-ms-office365-filtering-correlation-id: 50c27d41-579d-43ad-60b0-08dc084507d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xwFnYFbtoIQIM3igifFV45oL1Lez0ZCIidhEpaskCc1CA+HcgjhtgtdVtFSgpfq1Rwu6OC+Ev32Cw1JQhiJHJxzSe8jvLewc/sSrDJTgJoBNIBlhExsHytu7TJHVZcYw3St7z3M2gv427fozJdofL80+f+SxcpTW3YKwobKzKz4tXWMajY7EzlqmAMuw+VwFD9skKVu/t0C9gmpt4a3oQ6s+GUAtqvRC63iRmBu2O9nwGBO2rRCoc27YJt/V9iF4gG02Bv5UTrgQJoUGyw+/pUZ5GzoQiUrPbOvVp6m8K4mNXivkNdfhhHTo9wYRXg5stzL9ZO5a65f8Mju+1wUViKvcT5AnmoOm5HugmpXeepYBfmEitEuKKDOwf+UFKM4d7v+hWTkfiDmvvjaZxEzldKO987QOywW4XtHLuOtcq6DZiDhIX4Krhm2kMGdrMKmfPZFY+o76YrhMSNeEnD29waCPNJPaOda1tBnuEpNJ82BI6TLAAkQqalzIggTf7xCXW3UiLAcmTI/jU0s0fpf36lnjZuH9rw04cQicXxhVf0UzKa4xYzA9KyPdNutMejcdsC/Fp6DhzDC9Q4yRefioXCiDKDbkEVwtL46yF+LMXuZvmBXYewHOQxXNPLvqrQ6s
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(136003)(376002)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(316002)(8676002)(8936002)(478600001)(86362001)(33656002)(26005)(71200400001)(7696005)(9686003)(6506007)(53546011)(82960400001)(122000001)(38070700009)(83380400001)(38100700002)(41300700001)(110136005)(54906003)(64756008)(76116006)(66946007)(5660300002)(2906002)(66446008)(7416002)(66556008)(66476007)(55016003)(4326008)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y3kranFINTNaaUttVW01YjV4eEd0MEhuaktlelp4N09tYllwWm0xNk1nRnBo?=
 =?utf-8?B?Tk9qMXVNNENQNEg0UzFRcWtOWVFGRnpjYXNnMElHZFJpKzMreHFCc1UrL25p?=
 =?utf-8?B?S1RPQXZHL3FabWJ5RTFTeXc5Slh5KzFNRW1paUVCWW9qNExIMW1wYmZhYXVl?=
 =?utf-8?B?aFl3RTAwdWZhbjFGNjdJNmh3M0I3MVpkMTVWSWVJRlFvNnBGSnpCQjFRNkUx?=
 =?utf-8?B?VUxkamhTRVNUT2JCeXpqNVJ5THpZYnJ5MDc0YTJtSG1Ya1JPbmE5MUszRWFJ?=
 =?utf-8?B?cHptTlp5MHRHSVpDM0JaM0w0Z3kvUWU2RStOZmxFcVQvUGV3U3FPaFcxUTBF?=
 =?utf-8?B?bWxrbldpZXd4YWdtSTk4Vjl3eCtHWWxGY3pab3RPb1lnRGRaZzVWNWJ3SlNB?=
 =?utf-8?B?NmlmT2NUUGJ3QUVyKzZzZTdzUWYrc3RZbTNydEN6emZ1SG1scDNCbkNBYTdU?=
 =?utf-8?B?SVROOFMvMmdSd1FUQ2dSNWFlWHQwL0I1eEVoaEtnSVdMV1Z5RnlkUWVsMi92?=
 =?utf-8?B?V3JhdnkwN3A3Mm1ERUFETncrY3NBY0NtZXRBZjlQTU5VQUxGOWxObDUwd0dv?=
 =?utf-8?B?MjZTT3dQcGNQK3M3cERBS2dQaUk4MUtXTU03VTYxY1dUa2hhajZQTGlTd2pX?=
 =?utf-8?B?TnVSQkJsV0RwbW1XNzZMUUlVRERBRWhnMnYzS2R5bUVmRWZ3QmI3RDh5TjJI?=
 =?utf-8?B?VkpFQzBKVFdjQmhiV1NmR05qK3NSeENreEVxQi96cXkrd1NHbUZrY0xuVksx?=
 =?utf-8?B?Z1dTK08yZHRKSzNJaGRwRTZ1Mk5xRks2a2htUTRaTU9EWHRudnBFSGpORXYv?=
 =?utf-8?B?VDc5a245QS9ya3QzVU5WZGNvT21CaENDSmFNY1c5aVJCSW5MY25BNUltT1B3?=
 =?utf-8?B?TEQ3dGVFSnAxUVprYkpHUWplUnJQL1lFc1FJblNybWVTZVEyZXJzMGsyM3Mx?=
 =?utf-8?B?ZnlTTGc4NmhnNkNnQndHLzVMUjJHaCtteWVkM2RoZmswNmRTc2hidHVNdmNq?=
 =?utf-8?B?RnJZSUxoZjJZRHNIN08reCtpTDZRTjJDaU96UW0ra2FNZWtnZWx4ZXdRMytq?=
 =?utf-8?B?U2tHdjBxWWdrZXRKcFlsS2pvQ2hWd0phczdxMUVHcXpzSlFCek9OOFZvalpl?=
 =?utf-8?B?STFMellrK1ptcVRZUVhYSklXZTBRNkREU0RSOTAzbDJ5VWNMbXNST3ljaXND?=
 =?utf-8?B?MHkzQVhPVDF3ZFNJVERGWk5aZG1pZVZEWXdPYjZVM2JNSkhMV2tFc3loQWlp?=
 =?utf-8?B?aU5WY2dLYTVQVkZSem9uUm1qUDV6SlU0NGNReWRGM0dRZ3lZL09wYmRVT1Fn?=
 =?utf-8?B?ZmpmQzF3NmVCRlE4SXBVdE9IMUYydzlSU1FrU1dxblQwYlYxajlpeUZYeGkr?=
 =?utf-8?B?dSt6U2h5NHpXdk5zVW1GWFNBNDFkL2lwbC9zdmRXS3JsMWJ3N3hzOWJxVE9R?=
 =?utf-8?B?VWhIVE5SMDZwd3U4bVg5ZVRZZ3lIdTZiU01XZU1qUDhPMHVtUk54cTB0a093?=
 =?utf-8?B?R3VzTW5WY2Z0V2dORFAzK0JMYWZid3hyU1hwTlBGVkFZNnBTTmxGZlZTRXRa?=
 =?utf-8?B?U0xObEdhWis2U2VCOU1CTlBDTmFLY2xVTjJkQWRhT3NMaWMrcjkrdVZiRUIz?=
 =?utf-8?B?bURlR3g1Y1pGdjV6MVJtVHNKcXlncFpic081Q1JWazlvbkNLUURFMGlKK1Zs?=
 =?utf-8?B?eWJaVnBOM1hFQ3BqM2FqTDd6WEFiWWdhb1N1TUtXZTdSOXdjeXlLSVhjc1Rp?=
 =?utf-8?B?cHB1SHc0YU9MQ0lDQTNabWx0TExDM3hUanpsay90RXRaSkFUbkhzdytqbUFC?=
 =?utf-8?B?QzYvMjN0RnBmNXBSd3o3Q216K0wrMkdNYnhJV1VMVDBOMEgzVTV0amM4anFa?=
 =?utf-8?B?MGwyVkp2bURYNzVxYmVwWjBiUzhWUFZBMkhMdkppTWo0SVU5ZTBaVFBYbjRv?=
 =?utf-8?B?UXBzN2RYb0NYdUlIeEZOYStDSFB0UklGQVJYLzh1NUFZYUorYk5kOHJQTHFG?=
 =?utf-8?B?R3JMQUpBa0k2Kyt4TGJITVY0a3pBcDRlc2VHMFhIVWV3UmpiZUF3em9JalA5?=
 =?utf-8?B?LzU0a2ZPWXdVTDU2UVNhS1pHdVJuNTBFaTRMakp2NmtBSlZBKzJNaS9PMUJ2?=
 =?utf-8?Q?E3mHLSsfbuTdI8VkaRRf4reio?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50c27d41-579d-43ad-60b0-08dc084507d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2023 08:06:15.6609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4dteqw/L5vKIKOUzrmKOwHH/72UIqnhfLRMURBXeVN1I3j1vT6HhLxh1xX0j+vXFOvSsRT3ekukperDHX5cq9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB8290
X-OriginatorOrg: intel.com

PiBGcm9tOiBFdGhhbiBaaGFvIDxoYWlmZW5nLnpoYW9AbGludXguaW50ZWwuY29tPg0KPiBTZW50
OiBUaHVyc2RheSwgRGVjZW1iZXIgMjgsIDIwMjMgOTowMyBQTQ0KPiANCj4gT24gMTIvMjgvMjAy
MyA0OjMwIFBNLCBUaWFuLCBLZXZpbiB3cm90ZToNCj4gPj4gRnJvbTogRXRoYW4gWmhhbyA8aGFp
ZmVuZy56aGFvQGxpbnV4LmludGVsLmNvbT4NCj4gPj4gU2VudDogVGh1cnNkYXksIERlY2VtYmVy
IDI4LCAyMDIzIDg6MTcgQU0NCj4gPj4NCj4gPj4gRm9yIHRob3NlIGVuZHBvaW50IGRldmljZXMg
Y29ubmVjdCB0byBzeXN0ZW0gdmlhIGhvdHBsdWcgY2FwYWJsZSBwb3J0cywNCj4gPj4gdXNlcnMg
Y291bGQgcmVxdWVzdCBhIHdhcm0gcmVzZXQgdG8gdGhlIGRldmljZSBieSBmbGFwcGluZyBkZXZp
Y2UncyBsaW5rDQo+ID4+IHRocm91Z2ggc2V0dGluZyB0aGUgc2xvdCdzIGxpbmsgY29udHJvbCBy
ZWdpc3RlciwgYXMgcGNpZWhwX2lzdCgpIERMTFNDDQo+ID4+IGludGVycnVwdCBzZXF1ZW5jZSBy
ZXNwb25zZSwgcGNpZWhwIHdpbGwgdW5sb2FkIHRoZSBkZXZpY2UgZHJpdmVyIGFuZA0KPiA+PiB0
aGVuIHBvd2VyIGl0IG9mZi4gdGh1cyBjYXVzZSBhbiBJT01NVSBkZXZpY2UtVExCIGludmFsaWRh
dGlvbiAoSW50ZWwNCj4gPj4gVlQtZCBzcGVjLCBvciBBVFMgSW52YWxpZGF0aW9uIGluIFBDSWUg
c3BlYyByNi4xKSByZXF1ZXN0IGZvciBkZXZpY2UgdG8NCj4gPj4gYmUgc2VudCBhbmQgYSBsb25n
IHRpbWUgY29tcGxldGlvbi90aW1lb3V0IHdhaXRpbmcgaW4gaW50ZXJydXB0IGNvbnRleHQuDQo+
ID4gaXMgYWJvdmUgZGVzY3JpYmluZyB0aGUgYmVoYXZpb3Igb2Ygc2FmZSByZW1vdmFsIG9yIHN1
cnByaXNlIHJlbW92YWw/DQo+IA0KPiBicmluZyB0aGUgbGluayBkb3duIGlzIGEga2luZCBvZiBz
dXJwcmlzZSByZW1vdmFsIGZvciBob3RwbHVnIGNhcGFibGUNCj4gDQo+IGRldmljZS4NCg0KdGhl
biBpdCdzIGJldHRlciB0byBtYWtlIGl0IGNsZWFyIGZyb20gYmVnaW5uaW5nIHRoYXQgdGhpcyBp
cyBhYm91dCBzdXJwcmlzZQ0KcmVtb3ZhbCBpbiB3aGljaCBkZXZpY2UgaXMgcmVtb3ZlZCBhbmQg
Y2Fubm90IHJlc3BvbmQgdG8gb24tZ29pbmcNCkFUUyBpbnZhbGlkYXRpb24gcmVxdWVzdCBpbmN1
cnJlZCBpbiB0aGUgcmVtb3ZhbCBwcm9jZXNzLg0KDQpzYWZlIHJlbW92YWwgc2hvdWxkIGJlIGlt
bXVuZSBmcm9tIHRoaXMgcHJvYmxlbSBhcyB0aGUgZGV2aWNlIGlzIHN0aWxsDQpyZXNwb25zaXZl
IGluIHRoZSB3aG9sZSByZW1vdmFsIHByb2Nlc3MuDQoNCj4gPj4gWyA0MjIzLjgyMjYyOF0gQ2Fs
bCBUcmFjZToNCj4gPj4gWyA0MjIzLjgyMjYyOF0gIHFpX2ZsdXNoX2Rldl9pb3RsYisweGIxLzB4
ZDANCj4gPj4gWyA0MjIzLjgyMjYyOF0gIF9fZG1hcl9yZW1vdmVfb25lX2Rldl9pbmZvKzB4MjI0
LzB4MjUwDQo+ID4+IFsgNDIyMy44MjI2MjldICBkbWFyX3JlbW92ZV9vbmVfZGV2X2luZm8rMHgz
ZS8weDUwDQo+ID4+IFsgNDIyMy44MjI2MjldICBpbnRlbF9pb21tdV9yZWxlYXNlX2RldmljZSsw
eDFmLzB4MzANCj4gPj4gWyA0MjIzLjgyMjYyOV0gIGlvbW11X3JlbGVhc2VfZGV2aWNlKzB4MzMv
MHg2MA0KPiA+PiBbIDQyMjMuODIyNjI5XSAgaW9tbXVfYnVzX25vdGlmaWVyKzB4N2YvMHg5MA0K
PiA+PiBbIDQyMjMuODIyNjMwXSAgYmxvY2tpbmdfbm90aWZpZXJfY2FsbF9jaGFpbisweDYwLzB4
OTANCj4gPj4gWyA0MjIzLjgyMjYzMF0gIGRldmljZV9kZWwrMHgyZTUvMHg0MjANCj4gPj4gWyA0
MjIzLjgyMjYzMF0gIHBjaV9yZW1vdmVfYnVzX2RldmljZSsweDcwLzB4MTEwDQo+ID4+IFsgNDIy
My44MjI2MzBdICBwY2llaHBfdW5jb25maWd1cmVfZGV2aWNlKzB4N2MvMHgxMzANCg0KSSdtIGN1
cmlvdXMgd2h5IHRoaXMgZG9lc24ndCBvY2N1ciBlYXJsaWVyIHdoZW4gdGhlIGRldmljZSBpcw0K
ZGV0YWNoZWQgZnJvbSB0aGUgZHJpdmVyLiBBdCB0aGF0IHBvaW50IHByZXN1bWFibHkgdGhlIGRl
dmljZQ0Kc2hvdWxkIGJlIGRldGFjaGVkIGZyb20gdGhlIERNQSBkb21haW4gd2hpY2ggaW52b2x2
ZXMNCkFUUyBpbnZhbGlkYXRpb24gdG9vLg0KDQo+ID4+DQo+ID4+ICAgCXdoaWxlIChxaS0+ZGVz
Y19zdGF0dXNbd2FpdF9pbmRleF0gIT0gUUlfRE9ORSkgew0KPiA+PiArCQkvKg0KPiA+PiArCQkg
KiBpZiB0aGUgZGV2aWNlLVRMQiBpbnZhbGlkYXRpb24gdGFyZ2V0IGRldmljZSBpcyBnb25lLCBk
b24ndA0KPiA+PiArCQkgKiB3YWl0IGFueW1vcmUsIGl0IG1pZ2h0IHRha2UgdXAgdG8gMW1pbis1
MCUsIGNhdXNlcw0KPiA+PiBzeXN0ZW0NCj4gPj4gKwkJICogaGFuZy4gKHNlZSBJbXBsZW1lbnRh
dGlvbiBOb3RlIGluIFBDSWUgc3BlYyByNi4xIHNlYw0KPiA+PiAxMC4zLjEpDQo+ID4+ICsJCSAq
Lw0KPiA+PiArCQlpZiAoKHR5cGUgPT0gUUlfRElPVExCX1RZUEUgfHwgdHlwZSA9PSBRSV9ERUlP
VExCX1RZUEUpDQo+ID4+ICYmIHBkZXYpDQo+ID4+ICsJCQlpZiAoIXBjaV9kZXZpY2VfaXNfcHJl
c2VudChwZGV2KSkNCj4gPj4gKwkJCQlicmVhazsNCj4gPiBJJ20gbm90IHN1cmUgaXQncyB0aGUg
cmlnaHQgdGhpbmcgdG8gZG8uIFN1Y2ggY2hlY2sgc2hvdWxkIGJlIHB1dCBpbiB0aGUNCj4gPiBj
YWxsZXIgd2hpY2ggaGFzIHRoZSBkZXZpY2UgcG9pbnRlciBhbmQgY2FuIGFscmVhZHkga25vdyBp
dCdzIGFic2VudA0KPiA+IHRvIG5vdCBjYWxsIHRob3NlIGNhY2hlIGludmFsaWRhdGlvbiBoZWxw
ZXJzLg0KPiANCj4gSGVyZSBpcyB0byBoYW5kbGUgc3VjaCBjYXNlLCB0aGUgaW52YWxpZGF0aW9u
IHJlcXVlc3QgaXMgc2VudCwgYnV0IHRoZQ0KPiANCj4gZGV2aWNlIGlzIGp1c3QgcHVsbGVkIG91
dCBhdCB0aGF0IG1vbWVudC4NCj4gDQoNCm9uZSBwcm9ibGVtIC0gdGhlIGNhbGxlciBjb3VsZCBw
YXNzIG11bHRpcGxlIGRlc2NyaXB0b3JzIHdoaWxlIHR5cGUNCm9ubHkgcmVmZXJzIHRvIHRoZSAx
c3QgZGVzY3JpcHRvci4NCg0KYnR3IGlzIGl0IGFuIEludGVsIHNwZWNpZmljIHByb2JsZW0/IEEg
cXVpY2sgZ2xhbmNlIGF0IHNtbXUgZHJpdmVyDQpzdWdnZXN0cyB0aGUgc2FtZSBwcm9ibGVtIHRv
bzoNCg0KICBhcm1fc21tdV9hdGNfaW52X2RvbWFpbigpDQogICAgYXJtX3NtbXVfY21kcV9iYXRj
aF9zdWJtaXQoKQ0KICAgICAgYXJtX3NtbXVfY21kcV9pc3N1ZV9jbWRsaXN0KCkNCiAgICAgICAg
YXJtX3NtbXVfY21kcV9wb2xsX3VudGlsX3N5bmMoKQ0KICAgICAgICAgIF9fYXJtX3NtbXVfY21k
cV9wb2xsX3VudGlsX2NvbnN1bWVkKCkNCg0KLyoNCiAqIFdhaXQgdW50aWwgdGhlIFNNTVUgY29u
cyBpbmRleCBwYXNzZXMgbGxxLT5wcm9kLg0KICogTXVzdCBiZSBjYWxsZWQgd2l0aCB0aGUgY21k
cSBsb2NrIGhlbGQgaW4gc29tZSBjYXBhY2l0eS4NCiAqLw0Kc3RhdGljIGludCBfX2FybV9zbW11
X2NtZHFfcG9sbF91bnRpbF9jb25zdW1lZChzdHJ1Y3QgYXJtX3NtbXVfZGV2aWNlICpzbW11LA0K
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgYXJt
X3NtbXVfbGxfcXVldWUgKmxscSkNCg0KaXMgdGhlcmUgYSBtb3JlIGdlbmVyYWwgd2F5IHRvIHNv
bHZlIGl0Pw0K

