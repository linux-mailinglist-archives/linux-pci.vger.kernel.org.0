Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58DC633999D
	for <lists+linux-pci@lfdr.de>; Fri, 12 Mar 2021 23:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235529AbhCLWZm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Mar 2021 17:25:42 -0500
Received: from mga18.intel.com ([134.134.136.126]:14462 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235528AbhCLWZc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Mar 2021 17:25:32 -0500
IronPort-SDR: ZKQLJpq7vKgvRu6bRrDtENCPMAkjMJmsa9w0gzyIEGmp276tizCjrrvcvDfGCiUBwKUkHkyktU
 cs902iEwk8KQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="176487218"
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="176487218"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 14:25:29 -0800
IronPort-SDR: xAbD8wN2iEXjduAeNxdsS43eRJoUFYpRA7fZjAQihA7ox3uKshYCtrY2dquSEl/sT9zXjvfEVc
 RoDTqeyzytAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="600737185"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP; 12 Mar 2021 14:25:27 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 12 Mar 2021 14:25:27 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Fri, 12 Mar 2021 14:25:26 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.48) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Fri, 12 Mar 2021 14:25:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lBHBH2iCqjByuZclr7PQvPSZAtTpH5l6+kdshI+suXBSK2Dl0AthXljTs9lZApbmyDxhvlswgukmcz1zNKUGxEY0oy8OpQmhC10pN9bhkN/D4Z6x5FcV3tqMsmjPYiZpik0mq1upyoFgFVZC8PHhHQaEwDaAIlpzgJGm1VwBP1nV5nMOVbnuUBwKQ6acn2k2lCH0XhwobZR2MXwahdFUuVNC1jYnHe+9+kYGN6hB5gBIazcPI8YyRz0lFrmGXrXmH6KPJnrz++gStqTGdoS7uKz622oxwPyfmzY/vgbZix2jsmcjk0Ab9m3Y5Yw5rNX7B0yHgJZisx0Gaf4ufFfpTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4R48VsOIHEToDY/aVimc4WUKBusU8IvDL8jghi0k0ZU=;
 b=EjoEGcuWE4JmwaFtPzsM8NDAnVLwdQPSq6R8qtRJyXRzu3o2o+GF1dr5lPcdxkYYfcMGHnAd0m9wqv/Wu/XaCJpeuJD658YPPsBbqtwqWrdOPdF9WMrUI4nq0IPU67SnjEXkKaoUwcHOVeUK5+9PH6U8jes5UIyMDBOWhhyrKbEBywJ2MDDjJM3nrQCt9YhIiz96gkFRGh6bntsYcdU2iTRjBOxTkBGdz4PRtMqb1WdThDz9qsu0Jzcpni7vmwDfc3on7tfiNdrsjVGpEOmSzdPBP29J+updLCR31kmo3PVQ7dO0iJqLjsLXJGF0ww4B4LNaYKPJA+Yi6HLwptEl7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4R48VsOIHEToDY/aVimc4WUKBusU8IvDL8jghi0k0ZU=;
 b=jEPq+ROjPqE6tLPZ8K5lJ5zamMODDfAcIwbaDeVwQYXITuv+uCnkrsdIhZs6oJOatT/u0LbpVSsSCFEvuY9hcybAhXTlPa/0Id+LT0+WuqJuZOjH+ppjPCu9CQ22FyeGBq2kqg1/lUYEGZW76ABPP90XRdeUz/vRbS/xq0q6VAQ=
Received: from CO1PR11MB4929.namprd11.prod.outlook.com (2603:10b6:303:6d::19)
 by MW3PR11MB4748.namprd11.prod.outlook.com (2603:10b6:303:2e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Fri, 12 Mar
 2021 22:25:24 +0000
Received: from CO1PR11MB4929.namprd11.prod.outlook.com
 ([fe80::ddb6:ec7f:2548:efdc]) by CO1PR11MB4929.namprd11.prod.outlook.com
 ([fe80::ddb6:ec7f:2548:efdc%4]) with mapi id 15.20.3933.031; Fri, 12 Mar 2021
 22:25:24 +0000
From:   "Kelley, Sean V" <sean.v.kelley@intel.com>
To:     James Puthukattukaran <james.puthukattukaran@oracle.com>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>
CC:     Linux PCI <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: pci_do_recovery not handling fata errors
Thread-Topic: pci_do_recovery not handling fata errors
Thread-Index: AdcXgU62xtCQUzV6Rma22nuKU6yu/wADUkSA
Date:   Fri, 12 Mar 2021 22:25:23 +0000
Message-ID: <B2696632-CB84-420E-B072-044603A6D3B7@intel.com>
References: <MN2PR10MB4093188B8CDC659AE68E5640996F9@MN2PR10MB4093.namprd10.prod.outlook.com>
In-Reply-To: <MN2PR10MB4093188B8CDC659AE68E5640996F9@MN2PR10MB4093.namprd10.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [24.20.148.49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d2fcf52c-9b4e-4a5a-4c51-08d8e5a5bae1
x-ms-traffictypediagnostic: MW3PR11MB4748:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB4748E46DD14AD1662BAD2B47B26F9@MW3PR11MB4748.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oZEY3jGF3XfWC/Dx2z00VX48UB10tuy9HXiFw7yxGpR8u7sVKysONCdTQ4uO3NQbJKKaZEXV8iJQx16WKjVxS0a11rrvQpJr3xDOjGL/46+GFw+V3yE+qiqW/iG+KRr6mgpCfgcQVFZpAafmONU6cCzuTUielLFn7o/iNNfZcfOdQWLLZ7yYlKXbBGQpiUDGrnMaZAd8GvMkcHNC/b7VhFNMaKDspMrs5/QqbMikY9SjtLAQJ5vJzbF0MkbwFXYuiKNwtHKEWmpCw+CtRCC8LDcLxBMeALVy5OSvyB3mNPuTjP/5NMCUOzpBuc5fgd0EtdHGTsKuzFIlEjJfD6l7KJExoKRhTkWEnv7sPqzfjKGf3esab9acR2Due7CQAMTN19QgI8i/SDfWiK5F7BqPGl4zX8JdaFGz6sPMVUNQum5xNsl22JmsOOFWuYw4TCz64FIfpBlCvxlDVbvOwFFxwk5H4np/8WUhmsWaz0RxAau+KIGVvbUVWqITXi7QiKnKPU2rkT0WtxtsireFvDC6OpP0xSc2pdcburJQmsxcBO+7P5VA7n7ZgMD7FgfRfrl5V1ohGOkl3v4x4yEvmu2aZcLuUPJK12/aGvpmo+lP095Mu2j/Pjwx/Q2YIutKZogx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4929.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(376002)(39860400002)(396003)(366004)(86362001)(8936002)(4326008)(8676002)(26005)(36756003)(186003)(71200400001)(5660300002)(91956017)(66446008)(316002)(53546011)(6636002)(76116006)(6506007)(478600001)(54906003)(2906002)(6486002)(110136005)(33656002)(66476007)(2616005)(64756008)(6512007)(66556008)(66946007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?TjZwT1pGMHhZTmxPdStBMUNqVkV1R0lTbFE2T1NIcWxnNlRpUVhacXFXbitw?=
 =?utf-8?B?WUpoOWVSMS9SSXRnc2IvTVNLM3lqQjFna1FVdkRxVVd0S1RUWEM4L3ZLQjRl?=
 =?utf-8?B?WFd4aGhmVGJaQlllRHA4WVp5ZzB4WHVJRzBBNyt6U0NJOTQ0dDhqVElrKzdJ?=
 =?utf-8?B?aGVVS2pXWm9FWDR3QkFsS3V0dWZnbHdQd1J6UDZldXJIdGl1dVI4VVFCLzdR?=
 =?utf-8?B?akFpb3U0UWJ6YWtmcVFVMDFlUlBNcVhXaWN0N1Y2ZXZRREFsYzIrK0M4dVNQ?=
 =?utf-8?B?NWhnQnc0ZEtxZFFPV05Vc0RRMjZOcndnM1AwSjBCQnVwbHNscHNBQzlGOVRh?=
 =?utf-8?B?blNPTkZMVzh6ZlFiTXZ2amRTWXdQQk5zWnJtUzROK0swMmNEVy84bHVRcml0?=
 =?utf-8?B?ekY2Q0ovY3FpdDBIN1FUc1J1YkJWV2NmTjBiWUtreXJSR1podG5ScmxNc2w5?=
 =?utf-8?B?U01xaFJBSkhIL3FLTFJudHlGMWdEYnNZTjhPOFF0YTJIN2lsdzhOSzlkUU12?=
 =?utf-8?B?eWxpMXlva1o0NXZwUGROMHVPdTd5QXVScitTR05FSzhTK0p0UjI3d0U0dm8r?=
 =?utf-8?B?S2ZLeFNhL3BLY0tkcGdobm1UdEdTQUdMOFduNEd5SUFaakNSRmxlcmh1a3Rv?=
 =?utf-8?B?L29MWWRDUFpYamtHU0NkSnJJTTMrRkU0WmNaaDhaUngydUdpcmNIVzM1cmxm?=
 =?utf-8?B?UDJra2lJZ3M2L3pPZEp4anZpOEwydm1jRlp5TFF6V09sVldQbnRVeWp4U0V0?=
 =?utf-8?B?VXAvSXZNdWtMWW1oUklhTW91T0JVQ25WSE05S1pDSHdlZlF1WlRZckpxVVJY?=
 =?utf-8?B?NEJrWmxQeENkZURBM2JsWC8wVjV2WmRoeTdCV1k0SUlyZExMUm9rV3VnazJo?=
 =?utf-8?B?OVNKOWlhTUdYc2VyblRhYTlOdjFmVDA2YXZRWlpVcnNFcHB3RGxFOFdGQTJ6?=
 =?utf-8?B?c1pyS2VqSUpiVmRDdGNXKy9NTkJwYjkxQmlyOE5vTjZkWXoycmxmZkZUc1hH?=
 =?utf-8?B?MC9UV1Y2RGtyVktpMzZXVXQyQ3VUL0wxeGNDK0tIZ24rRUxDVytHVk1kV0dW?=
 =?utf-8?B?WkhDMVBadWx1MkdJTnFWTExDT0h5aDZWYitZM0Y1ZmYwRGlhYmg0VkJ0bFJW?=
 =?utf-8?B?eHFGdng0TTJVbnpDTkxlZWYxL2o4SUo2RnIwNFJvRFZHQ0MvZE90Nm9VbFFS?=
 =?utf-8?B?WnhnWFhNL05rRWNLSTdEaGROZTg4NkdVSHFBSHdrWHdFODZIMnkxSmRsMFM3?=
 =?utf-8?B?VkNRaVFwRlNwem9laDdHTU5PcC9rVTNxM2ZUWTg5aXArejhua2dYOXUyR2Yw?=
 =?utf-8?B?N0NrUFdTaTY0WThlZlc2ZXNFRTZnT0xUQ0JxRmVZL0wzWlp0MnV0cnVDQzE1?=
 =?utf-8?B?K3RLejBVQjhOSVFYV0VlQWs2NS8yNW94VHZBdG0vU1FOamRUVlBJNENnVTd3?=
 =?utf-8?B?R1oyN0JEa1ZSSzRTalFWS2pxSVFUTzAwNDBvTmRXd1ZPR0EvcnBocndFRlJW?=
 =?utf-8?B?SzVmUmg5MThJMXVkdzlDODM5bG05ZXVnVW1JU291aVRkdVlhL1NKQ2tCclUw?=
 =?utf-8?B?QXVHQ2JwOVg1bG85cWdxcitNbGdXZzQ4cEJyTUUxY0o0U0V2TERGZVpMVzNj?=
 =?utf-8?B?clBGL3c4Ty94SlozSG52b0hFc1FMVEkrbDduQ2F1anpNeFdmeWFYYTNZL0Q1?=
 =?utf-8?B?UGd1OTUyUGVGdlJHTFlZRFBWUTRlOU11b1Jzd04xc2h3UGU3QVRNd2FUTzd3?=
 =?utf-8?Q?x7GJKUBOkzpBDASetabVJIwDLt2Vp9wTGAC6Jfe?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7C0DA1F955FDA545837F037A5522FFB6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4929.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2fcf52c-9b4e-4a5a-4c51-08d8e5a5bae1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2021 22:25:23.9641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bKisWliCB4ThSSWXiFg4IzT0r5LWpeCn1nRJmwUH3/ore8A3fzN/ETHZPLy7AEUzzHwArPmT0iYdtaF1UgJ2dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4748
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQoNCj4gT24gTWFyIDEyLCAyMDIxLCBhdCAxMjo1NiBQTSwgSmFtZXMgUHV0aHVrYXR0dWthcmFu
IDxqYW1lcy5wdXRodWthdHR1a2FyYW5Ab3JhY2xlLmNvbT4gd3JvdGU6DQo+IA0KPiBIaSAtDQo+
IEnigJltIHRyeWluZyB0byB1bmRlcnN0YW5kIHdoeSBwY2lfZG9fcmVjb3ZlcnkoKSBvbmx5IGNs
ZWFycyBub24tZmF0YWwgYnV0IG5vdCBmYXRhIGVycm9ycz8gTXkgaW1tZWRpYXRlIGNvbmNlcm4g
aXMgY2FsbCBmcm9tIGRwY19oYW5kbGVyLiBJZiBhIGRldmljZSBzZW5kcyBhbiBFUlJfRkFUQUwg
dG8gdGhlIHJvb3QgcG9ydCwgSSB3b3VsZCB0aGluayB0aGF0IGFzIHBhcnQgb2YgcmVjb3Zlcnkg
dGhlIGZhdGFsIHN0YXR1cyBpbiB0aGUgQUVSIHJlZ2lzdGVycyBvZiB0aGUgZW5kcG9pbnQgZGV2
aWNlIHdvdWxkIGJlIGNsZWFyZWQ/DQo+ICANCg0KDQpBZGRpbmcgU2F0aHlhIHdobyBtZW50aW9u
ZWQgdG8gbWUgdGhhdDoNCg0KRmF0YWwgZXJyb3IgYXJlIGNsZWFyZWQgaW4NCg0Kdm9pZCBkcGNf
cHJvY2Vzc19lcnJvcihzdHJ1Y3QgcGNpX2RldiAqcGRldikNCg0KMjUzICAgICAgICAgICAgICAg
ICAgZHBjX2dldF9hZXJfdW5jb3JyZWN0X3NldmVyaXR5KHBkZXYsICZpbmZvKSAmJg0KMjU0ICAg
ICAgICAgICAgICAgICAgYWVyX2dldF9kZXZpY2VfZXJyb3JfaW5mbyhwZGV2LCAmaW5mbykpIHsN
CjI1NSAgICAgICAgICAgICAgICAgYWVyX3ByaW50X2Vycm9yKHBkZXYsICZpbmZvKTsNCjI1NiAg
ICAgICAgICAgICAgICAgcGNpX2Flcl9jbGVhcl9ub25mYXRhbF9zdGF0dXMocGRldik7DQoyNTcg
ICAgICAgICAgICAgICAgIHBjaV9hZXJfY2xlYXJfZmF0YWxfc3RhdHVzKHBkZXYpOw0KDQpUaGFu
a3MsDQoNClNlYW4NCg0KPiBTbmlwcGV0IG9mIGNvbmNlcm4gaW4gcGNpX2RvX3JlY292ZXJ5IOKA
kw0KPiAgDQo+ICAgICAgICAgLyoNCj4gICAgICAgICAgKiBJZiB3ZSBoYXZlIG5hdGl2ZSBjb250
cm9sIG9mIEFFUiwgY2xlYXIgZXJyb3Igc3RhdHVzIGluIHRoZSBSb290DQo+ICAgICAgICAgICog
UG9ydCBvciBEb3duc3RyZWFtIFBvcnQgdGhhdCBzaWduYWxlZCB0aGUgZXJyb3IuICBJZiB0aGUN
Cj4gICAgICAgICAgKiBwbGF0Zm9ybSByZXRhaW5lZCBjb250cm9sIG9mIEFFUiwgaXQgaXMgcmVz
cG9uc2libGUgZm9yIGNsZWFyaW5nDQo+ICAgICAgICAgICogdGhpcyBzdGF0dXMuICBJbiB0aGF0
IGNhc2UsIHRoZSBzaWduYWxpbmcgZGV2aWNlIG1heSBub3QgZXZlbiBiZQ0KPiAgICAgICAgICAq
IHZpc2libGUgdG8gdGhlIE9TLg0KPiAgICAgICAgICAqLw0KPiAgICAgICAgIGlmIChob3N0LT5u
YXRpdmVfYWVyIHx8IHBjaWVfcG9ydHNfbmF0aXZlKSB7DQo+ICAgICAgICAgICAgICAgICBwY2ll
X2NsZWFyX2RldmljZV9zdGF0dXMoYnJpZGdlKTsNCj4gICAgICAgICAgICAgICAgIHBjaV9hZXJf
Y2xlYXJfbm9uZmF0YWxfc3RhdHVzKGJyaWRnZSk7ICAgPDw8PCBKdXN0IGNsZWFyaW5nIG5vbmZh
dGFsLiBXaGF0IGFib3V0IGZhdGFsPw0KPiAgICAgICAgIH0NCj4gIA0KPiBUaGFua3MNCj4gSmFt
ZXMNCg0K
