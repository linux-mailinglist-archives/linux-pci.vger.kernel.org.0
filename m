Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF692FD991
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jan 2021 20:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387921AbhATTXw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Jan 2021 14:23:52 -0500
Received: from mga17.intel.com ([192.55.52.151]:54598 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388189AbhATTWC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Jan 2021 14:22:02 -0500
IronPort-SDR: vhpXnr3JSRQ0fsHYyRQe/I3Nxz4rpiH9M3jQ7MoH+HY+BFr8SkwbuuJ5MZ4WvpWInY7DYOIQ0l
 ekqrjX6Yu0LA==
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="158939705"
X-IronPort-AV: E=Sophos;i="5.79,361,1602572400"; 
   d="scan'208";a="158939705"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2021 11:21:13 -0800
IronPort-SDR: BEhcdnIKH/x9tNaLFDQ0dkBbh9hoJZ+U7l3dYurNH2k9k7m03mVUBVuxLZLo9lNPCOsBRatumr
 w5JkU+feD1Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,361,1602572400"; 
   d="scan'208";a="391662394"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP; 20 Jan 2021 11:21:13 -0800
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 20 Jan 2021 11:21:12 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 20 Jan 2021 11:21:12 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 20 Jan 2021 11:21:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/131XQFJm8t3b09EjEwMSGZ6lgbE3OJAyV/y/qOaulo3lZqxKhWY6vwp19j616pCHdFZAUWF60xc3xqOAG/MvRAMcsy9RlzNPbPqxTya61dZLasozCaUuQnZldW228D4ezv/0aPeYY/MIHudSIy/WQpa26ZnUcFagLvLt6hrQvV9y43ZFotxMlIqMddMVGI8BvakQgsktJuav5qNRym+Pmw1ICMlFCWrtwqQ7T+yFpp7uvWB35qqt9G4Qcp6L6mMtjKD4fenlZMYR/UKeTAu9pH7eqLAMiLHL2CbyR1XN0fPyeXg6WfcOW0O/QLRSZRN4dJ5JscTrFEmQxwp3qcFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HfaIkItcBxq0Ex6m0FeeMnSLyVguXsEMpqclQYLJwg4=;
 b=RstyZjV7Xn9EOOtxwFeSd8gG5JVb0t/JW7qin3v5E44Y3VtcroAWuW29GLjPNN8ySBmQV8nJ343BCCas2hwoRGqp6oOy9mctCY8ZJBNMbo8Xi9Wv9CeN+pZu3S0fet6b7XJ/nevZnYB0bdzFWHJ5IvigWeb4XkLJZMhkQm1BGTShBusFqCJsUD1sWt80lZ8eBKNNvixbisNCkFxGGWvTAMti2mAI2yRfEt6rU7i8M8YW9GMsNiGCvcznz/m1q6KFFc3qxu/mliTTwl16tkFqyDEptO6fdaaZC2likeoRngJeFjCRMLq+VeVJ8MkoOJivacY0AjPgV99Euq6l2KYEHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HfaIkItcBxq0Ex6m0FeeMnSLyVguXsEMpqclQYLJwg4=;
 b=mub/q8sxQe/lDrBSxLbHOkRF1Tsgf+vEfzA0anoX1qzNMLx3emTkhbUR94Yv1l22hVnaIo/WJDUYMFDL3ZFDAE1o1p+BC+QE5HSvnccsTAvCeWJ604WdKhS07pW0FqQbyoeiL69XVtDoxBGjdmGRQZnOykoOvAJG5GhwIynNXVM=
Received: from BYAPR11MB3448.namprd11.prod.outlook.com (2603:10b6:a03:76::21)
 by BYAPR11MB2838.namprd11.prod.outlook.com (2603:10b6:a02:cc::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Wed, 20 Jan
 2021 19:21:09 +0000
Received: from BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::8004:3bed:cc13:e8ae]) by BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::8004:3bed:cc13:e8ae%7]) with mapi id 15.20.3763.014; Wed, 20 Jan 2021
 19:21:09 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Widawsky, Ben" <ben.widawsky@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>
CC:     "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "jcm@jonmasters.org" <jcm@jonmasters.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "daniel.lll@alibaba-inc.com" <daniel.lll@alibaba-inc.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "cbrowy@avery-design.com" <cbrowy@avery-design.com>,
        "Weiny, Ira" <ira.weiny@intel.com>
Subject: Re: [RFC PATCH v3 02/16] cxl/acpi: Add an acpi_cxl module for the CXL
 interconnect
Thread-Topic: [RFC PATCH v3 02/16] cxl/acpi: Add an acpi_cxl module for the
 CXL interconnect
Thread-Index: AQHW6GxRPbm+jgT4lkCUw1EQEEK1kqolgZKAgAtwZAA=
Date:   Wed, 20 Jan 2021 19:21:08 +0000
Message-ID: <dfc13eb2a2a9a3297100bbda34c00f28554a83e2.camel@intel.com>
References: <20210111225121.820014-1-ben.widawsky@intel.com>
         <20210111225121.820014-3-ben.widawsky@intel.com>
         <CAJZ5v0h56q2+1U2DpMoAX-7vxs32hz+SRE_02mucoMY1tiUFiw@mail.gmail.com>
In-Reply-To: <CAJZ5v0h56q2+1U2DpMoAX-7vxs32hz+SRE_02mucoMY1tiUFiw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.2 (3.38.2-1.fc33) 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.54.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 34f6a5fd-0f8c-42ec-69dc-08d8bd788a8d
x-ms-traffictypediagnostic: BYAPR11MB2838:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB28389BBDF9FCECB2D516A9BAC7A29@BYAPR11MB2838.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 34HnJaAP7kT/5ptsPiMSbiqlk57Roa0XRRA/cRgq23qxiSXicZrnZncboJf4rTFREcNdSL2x1arzIutVMOGBnTsxZajhWF6gDdqdv8SgQH2zEPyT9hPANj3xZXk+IwWVsZbULBnPJheP6ewmn2LNy/qEMDMJuxUg+O7NUBIEQzzT3TKnpACvvOCauTt0TKYgEmBZ/5cNpXJ4rI9kIjiSr+Z8keKwFbSB27hgHhRWDSTiCt8D/lU6it3RHhZnfEcYRf+KA980e8DgBZBV4C0hkEUI8ulFU5iGZM95qkXqEEmOQykd0JNpA7zsZ5WVakqoAWnhMxF2/85Y/AFt+PAUFiLa7EuHqBktL93O50oaUWgjig3Y7UzX3hz0z5PIptoBc07bNUrK/hkAg31yWrlCPQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3448.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(366004)(376002)(39860400002)(66556008)(66446008)(64756008)(110136005)(2906002)(83380400001)(5660300002)(2616005)(36756003)(6512007)(316002)(186003)(26005)(53546011)(8936002)(4326008)(6506007)(8676002)(54906003)(6486002)(478600001)(76116006)(71200400001)(66946007)(7416002)(66476007)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?S2FUZlB2a1BDdkoza08yWlJuckJXSlRaZk5wZ2F4cEQ4QU8xbEpFY0R0WGFS?=
 =?utf-8?B?V214M0ltNTF4THA4bVhPNERGN2lpRDlGWE1iWDNyNXlPRHhiWm1YK0hYYjhZ?=
 =?utf-8?B?UzQ5ODJRd3JXQ2V4V0VvZ25DRVltazgxazU4TmxNTVF3RnpVd2R6L3RpQk9W?=
 =?utf-8?B?bXk1OEJsOHdFK01MZzUzNyt6RVdsbnFxczdnQm9Jdm8vdU5Fa29TUUo4YmxO?=
 =?utf-8?B?WWN3NStVMjM5WWp3MGtQTkwwSSt3ZkxER3JFeDJDWWlzK1l4VmUyTDV3MjJv?=
 =?utf-8?B?cmdNTVo1dFF6eWRhUjB6d2RNSHdwMEhIS29WZm01TXErMDU1Q1Q4VHBlUVdt?=
 =?utf-8?B?VGxZVDNFK2RpU1IrL2Y2RnhDdHhxSEprWjE5S24yQk5PVG04N0pNY1Byb2dU?=
 =?utf-8?B?TldrcXhRb0hFM00rWEFha0JXYVBuejIyeTA2Z1hOUHY2QSthb2RicFZqN1ox?=
 =?utf-8?B?VnRIUEVHdkV4M0Q5Wi9BQ2diQzB5a1ZlaHdLV2x6MVowT091aVVUclI4Uzdw?=
 =?utf-8?B?bXo4azlseFpnNTcwVU9uVEdRdy9WdDNMWEV6ODVSZTZZUm5Fd0F5YXdUUkp2?=
 =?utf-8?B?VTdLbGZWcTZTeW1EVmVsZmpsL2lxRnJNWFRxQmhQbWZsSU9HSDZEVEkrNHgw?=
 =?utf-8?B?M1NCcGhJdml2WFhBQ20xRkVhOXhiS3lPcURtWnpwMFV0WnBTdEdzcU94RWpv?=
 =?utf-8?B?NlZOQzQzRHRDaGVqTzA5RHJwUXpPWnB1Z1huaDlEZUk3Y1M1dThqMktjb3Z6?=
 =?utf-8?B?MkNGZjdLYjJoeUhuRmVrREFzcEtjbHVhV2QrTGYyMmdFNnVHc3ljVmx4bVpP?=
 =?utf-8?B?Vm5GWFAzOGdybXlhc0J2ZjJiZHdHVmhIQ1hRSjlwUDg5Qk41MkN4NjNrKzZN?=
 =?utf-8?B?SDZiZWVjQ0p6M3J4eDdvVTQzODB5VUNqV1J0UlRtWXFCRE5ra25udll2ck4w?=
 =?utf-8?B?MHhYNHlYYjk3ZEFCMEg1RlUrbUFpZjFJUC8rUGFMUExFcld0dXNmRWFkNXR5?=
 =?utf-8?B?THVFdzhmelo3bldaVDJBZ0NVaE1QWndwRUNNSmhwSEhIN05FMk9TT2E5QmFQ?=
 =?utf-8?B?NkRuZW9aVnFGOGx5MnA2dnQ0aVFoRlJPSHMvQ0Y5dEFxRjdHR0owNXZsUGdZ?=
 =?utf-8?B?TUVGWEd3NlVPNFpSc0t3bWlvMDd1UFM3cVVMc0V3dG11NVZiUVdrNDI0Mll2?=
 =?utf-8?B?ZTVPcTZnRCthUTlsbkp1UjF6TURWK3pMTVNEdHQxME9wK3BpMDRsMHdGd0oy?=
 =?utf-8?B?bFdsTFdlWFVGUUhtcEpWSUx5dDc0akJHTHViRFdFdWU1YVpNU2RGRnVCbXNF?=
 =?utf-8?B?V1Z1TWt3R2wzUmd3U3VKTzdMOS8wZmc5RUEyZHVjQWYyU0svS3AvMFFFOUZI?=
 =?utf-8?B?VG8yRDFhKzJDOHprVDlDa3NKaXNJWWY0c21PU0lNdlNXQjNKdEo1SzVSZmdD?=
 =?utf-8?Q?kZIMhf5e?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <18B10B5411CE204B961258CE2ECD0969@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3448.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34f6a5fd-0f8c-42ec-69dc-08d8bd788a8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2021 19:21:08.9334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +7NnzbmJYEtVj9K2GKP1lBU4+x9or8dg9DHoYzN11MurfbvwpvwYOtRbvhRqQP8lwQgg+QiG/OWB/fY2UcMA7nXzejEJz57Fg1C+wGVHsB8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2838
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gV2VkLCAyMDIxLTAxLTEzIGF0IDEzOjQwICswMTAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gT24gVHVlLCBKYW4gMTIsIDIwMjEgYXQgMToyOSBBTSBCZW4gV2lkYXdza3kgPGJlbi53
aWRhd3NreUBpbnRlbC5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IEZyb206IFZpc2hhbCBWZXJtYSA8
dmlzaGFsLmwudmVybWFAaW50ZWwuY29tPg0KPiA+IA0KPiA+IEFkZCBhbiBhY3BpX2N4bCBtb2R1
bGUgdG8gY29vcmRpbmF0ZSB0aGUgQUNQSSBwb3J0aW9ucyBvZiB0aGUgQ1hMDQo+ID4gKENvbXB1
dGUgZVhwcmVzcyBMaW5rKSBpbnRlcmNvbm5lY3QuIFRoaXMgZHJpdmVyIGJpbmRzIHRvIEFDUEkw
MDE3DQo+ID4gb2JqZWN0cyBpbiB0aGUgQUNQSSB0cmVlLCBhbmQgY29vcmRpbmF0ZXMgYWNjZXNz
IHRvIHRoZSByZXNvdXJjZXMNCj4gPiBwcm92aWRlZCBieSB0aGUgQUNQSSBDRURUIChDWEwgRWFy
bHkgRGlzY292ZXJ5IFRhYmxlKS4NCj4gPiANCj4gPiBJdCBhbHNvIGNvb3JkaW5hdGVzIG9wZXJh
dGlvbnMgb2YgdGhlIHJvb3QgcG9ydCBfT1NDIG9iamVjdCB0byBub3RpZnkNCj4gPiBwbGF0Zm9y
bSBmaXJtd2FyZSB0aGF0IHRoZSBPUyBoYXMgbmF0aXZlIHN1cHBvcnQgZm9yIHRoZSBDWEwNCj4g
PiBjYXBhYmlsaXRpZXMgb2YgZW5kcG9pbnRzLg0KPiANCj4gVGhpcyBkb2Vzbid0IGhhcHBlbiBo
ZXJlLCBidXQgaW4gdGhlIG5leHQgcGF0Y2guDQo+IA0KPiA+IE5vdGU6IHRoZSBhY3RibDEuaCBj
aGFuZ2VzIGFyZSBzcGVjdWxhdGl2ZS4gVGhlIGV4cGVjdGF0aW9uIGlzIHRoYXQgdGhleQ0KPiA+
IHdpbGwgYXJyaXZlIHRocm91Z2ggdGhlIEFDUElDQSB0cmVlIGluIGR1ZSB0aW1lLg0KPiANCj4g
U28gd2h5IGRvbid0IHlvdSBwdXQgdGhlbSBpbnRvIGEgc2VwYXJhdGUgcGF0Y2ggYW5kIGRyb3Ag
aXQgZnJvbSB0aGUNCj4gc2VyaWVzIHdoZW4gbm90IG5lY2Vzc2FyeSBhbnkgbW9yZT8NCg0KW3Nu
aXBdDQoNCj4gPiArLyoNCj4gPiArICogSWYvd2hlbiBDWEwgc3VwcG9ydCBpcyBkZWZpbmVkIGJ5
IG90aGVyIHBsYXRmb3JtIGZpcm13YXJlIHRoZSBrZXJuZWwNCj4gPiArICogd2lsbCBuZWVkIGEg
bWVjaGFuaXNtIHRvIHNlbGVjdCBiZXR3ZWVuIHRoZSBwbGF0Zm9ybSBzcGVjaWZpYyB2ZXJzaW9u
DQo+ID4gKyAqIG9mIHRoaXMgcm91dGluZSwgdW50aWwgdGhlbiwgaGFyZC1jb2RlIEFDUEkgYXNz
dW1wdGlvbnMNCj4gPiArICovDQo+ID4gK2ludCBjeGxfYnVzX2FjcXVpcmUoc3RydWN0IHBjaV9k
ZXYgKnBkZXYpDQo+ID4gK3sNCj4gPiArICAgICAgIHN0cnVjdCBhY3BpX2RldmljZSAqYWRldjsN
Cj4gPiArICAgICAgIHN0cnVjdCBwY2lfZGV2ICpyb290X3BvcnQ7DQo+ID4gKyAgICAgICBzdHJ1
Y3QgZGV2aWNlICpyb290Ow0KPiA+ICsNCj4gPiArICAgICAgIHJvb3RfcG9ydCA9IHBjaWVfZmlu
ZF9yb290X3BvcnQocGRldik7DQo+ID4gKyAgICAgICBpZiAoIXJvb3RfcG9ydCkNCj4gPiArICAg
ICAgICAgICAgICAgcmV0dXJuIC1FTlhJTzsNCj4gPiArDQo+ID4gKyAgICAgICByb290ID0gcm9v
dF9wb3J0LT5kZXYucGFyZW50Ow0KPiA+ICsgICAgICAgaWYgKCFyb290KQ0KPiA+ICsgICAgICAg
ICAgICAgICByZXR1cm4gLUVOWElPOw0KPiA+ICsNCj4gPiArICAgICAgIGFkZXYgPSBBQ1BJX0NP
TVBBTklPTihyb290KTsNCj4gPiArICAgICAgIGlmICghYWRldikNCj4gPiArICAgICAgICAgICAg
ICAgcmV0dXJuIC1FTlhJTzsNCj4gPiArDQo+ID4gKyAgICAgICAvKiBUT0RPOiBPU0MgZW5hYmxp
bmcgKi8NCj4gPiArDQo+ID4gKyAgICAgICByZXR1cm4gMDsNCj4gPiArfQ0KPiA+ICtFWFBPUlRf
U1lNQk9MX0dQTChjeGxfYnVzX2FjcXVpcmUpOw0KPiANCj4gSSB3b3VsZCBtb3ZlIHRoZSBhZGRp
dGlvbiBvZiBjeGxfYnVzX2FjcXVpcmUoKSBlbnRpcmVseSB0byB0aGUgbmV4dA0KPiBwYXRjaCwg
aXQgbG9va3MgcXVpdGUgY29uZnVzaW5nIHRvIG1lIGFzIGlzLg0KDQpNYWtlcyBzZW5zZSAtIGFu
ZCBhbHNvIGFncmVlZCB3aXRoIGFsbCBvZiB5b3VyIG90aGVyIGNvbW1lbnRzLiBJJ3ZlDQpjbGVh
bmVkIHRoaXMgdXAgZm9yIHRoZSBuZXh0IHJldmlzaW9uLiBUaGFua3MgUmFmYWVsIQ0KPiANCg0K
