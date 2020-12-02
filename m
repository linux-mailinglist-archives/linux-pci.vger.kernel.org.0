Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0416D2CCA04
	for <lists+linux-pci@lfdr.de>; Wed,  2 Dec 2020 23:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387576AbgLBWzL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Dec 2020 17:55:11 -0500
Received: from mga17.intel.com ([192.55.52.151]:17817 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387566AbgLBWzL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Dec 2020 17:55:11 -0500
IronPort-SDR: XHp+TFYFY10N8r3c6Q+dLApfqnI+14pJWVehwQ3newxa3xGeGphpzaW9ZdkXq398sJ0zGaxkLg
 3gW9lQWTspqg==
X-IronPort-AV: E=McAfee;i="6000,8403,9823"; a="152928054"
X-IronPort-AV: E=Sophos;i="5.78,388,1599548400"; 
   d="scan'208";a="152928054"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 14:54:30 -0800
IronPort-SDR: OLyudm4a2OqqD9S3uiOE0e7axTYXo73TKGcuYZbjnSkrEAwlmsnlg2akOF/2RrfmmokoKNzOTb
 7CZlP0inmohw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,388,1599548400"; 
   d="scan'208";a="335735832"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga006.jf.intel.com with ESMTP; 02 Dec 2020 14:54:29 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 2 Dec 2020 14:54:29 -0800
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 2 Dec 2020 14:54:28 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 2 Dec 2020 14:54:28 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 2 Dec 2020 14:54:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GueSan6cZcGLI3Xh3/NdeHzAb8C9ALVqZ1uGePOyodEC9VTPtW6Av4iam2EoWvby3TpLh9CRgkqLksUuAEP2mex15hV58TC0Ud+c+8vUmj0qQ3c45qCWewwJla9ldOaCdk9Rd13DbyLJWQIjjuspB+exn91a3u5zX+RIBVdDXvKnMSyObNSgT76mj0iDDVE6tFnFtfzoWxYwNP+ozI83yXr8iP+QVkOb2x6Zb7XzubTHibIi3Hf0d37ddg12mBZIITjIPbIgOrVSipVMTYN3wJ5f40SM1kDETH95BEN7uWfc8Kp0S0+fSXQr+jL6t7pcbQGRKIgA5FiI7G1dUJFPZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KjcXlO/DSIqM4KPRoKanwzbnaodlg83UC5qVSLD4L7w=;
 b=AcMyykoK5QWtk/r3KAEqU3eb9NUlmOxv+9V5pThXNzfYRyIiTyHLEjzWU31Jrn+Bv9hdQJx+7+jg0/uZ7KDHWpc9xz6/SwOIefen8UVu35OamxkKgXT1ujJA2Y/GzIAqzl9kZB5wfZIkx+wIk+haYXwj84rNAR+kEIFv4uRbrdtned9fxu65N18/ox65L9yyQx44/t0pk+i/DpfBdXp9L+UvMx7zJtJp08vGEeWDdm96MV1YclA8GcM+tLnDy/oOfXHCmYMJWrm83NvLt8DmJUTnI/k779D6fDnEyrznTC4SvLxBzKCoaS1akJ6eN1AG9aMB0ibwq+2/HSSXaFLnOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KjcXlO/DSIqM4KPRoKanwzbnaodlg83UC5qVSLD4L7w=;
 b=Fu2uDaNfgpaOAGu4UGWhAAgGWw6zLDSu63TRrFcXvMgy7Qo2sfFkzXBo3jo7fcM1YSFwkoLv6KAwpr8XJgKDCVbX2XwjuFNoX4giVethYo2NWFQD3HC6WhTDA0t6eg10BoGFJesNzYKY1PFK0rez2QbCW4EQ89D87MYFQLLXllk=
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com
 (2603:10b6:405:50::16) by BN8PR11MB3618.namprd11.prod.outlook.com
 (2603:10b6:408:90::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Wed, 2 Dec
 2020 22:54:26 +0000
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::bcaa:2da8:af5e:4b51]) by BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::bcaa:2da8:af5e:4b51%11]) with mapi id 15.20.3611.031; Wed, 2 Dec 2020
 22:54:26 +0000
From:   "Kelley, Sean V" <sean.v.kelley@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "xerces.zhao@gmail.com" <xerces.zhao@gmail.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 10/15] PCI/ERR: Limit AER resets in pcie_do_recovery()
Thread-Topic: [PATCH v12 10/15] PCI/ERR: Limit AER resets in
 pcie_do_recovery()
Thread-Index: AQHWv5rIZhXHzDUE4UiIgzOenVpmfKnWYYcAgAAIFgCAASKhAIAJmc2AgABLoQCAAumagIAACXeAgAAYN4A=
Date:   Wed, 2 Dec 2020 22:54:26 +0000
Message-ID: <6543A0E0-2DFE-4620-8C95-046B4785132C@intel.com>
References: <20201202212745.GA1472565@bjorn-Precision-5520>
In-Reply-To: <20201202212745.GA1472565@bjorn-Precision-5520>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.20.0.2.21)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [24.20.148.49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4f4b6683-b466-41ce-32cb-08d897153847
x-ms-traffictypediagnostic: BN8PR11MB3618:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR11MB36184B36DB71B5261D67FF22B2F30@BN8PR11MB3618.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SI+H+k7NWatAdXPB7assYa9CFchGaZyKCed3XikswR9Vl9CkIIsv3w/yZQ2Bhj4t0pGeV9UVSYKOtNVyTErCl90ZkclQd8YWj7mhKhTGPdrNuWB1bIfVHggQwuRabOgXYLk0zn85STWLEYFNj/s1f8JLyVZmbSb/4k0C1jSxIhs/Rk23CIQw3Kypew9YF8qwoCqW6gHXkWmYnkkvmR23LQPYLTLmhp0ycd+tFIpWLrfkkMtHPlkZs0MW2mV3rI/I3da926q4qyoV979/F20+GmHoT7+4n0kDggfNPb09edQmUPuG6zKtWs2tY0TqZmPKbVqu/hmt517NYpaK8b3zrzeoCjkTSlCiUGlymczdETrUZpIqyrQckQtiXWWzkQQh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1101MB2243.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(366004)(39860400002)(136003)(346002)(316002)(54906003)(64756008)(66446008)(6512007)(5660300002)(8936002)(66946007)(6916009)(26005)(4326008)(86362001)(478600001)(186003)(71200400001)(33656002)(6486002)(76116006)(2616005)(6506007)(91956017)(53546011)(66556008)(66476007)(2906002)(8676002)(36756003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?MnBSZ1laMkNGS2dLcFFMRXZxVnVOVDV3QWRid05IVFBqdld5VDREN3N4cE9G?=
 =?utf-8?B?L09DR3VRZUpxN1czZTZsWU1NTDFkZEd2ZDBKK204ZUJiWTlmQTZwdmVxOWRI?=
 =?utf-8?B?SDJ3SEVBTDFsMmZ3eCtHdFhEN1lWMXNJTFB4ZW1KTVRJbk5KYmlKeUtmSzdj?=
 =?utf-8?B?b1FpMUh1ZXpLclZIcDQ2elNxVFBFVkluWmxyWkc1M3l0V3ZiWHlBaWpEdkxH?=
 =?utf-8?B?Q0RlTGNiTk9zK2RwRWxTQzNKSC9HUVM2NjNrdGNuZnFOc0Y5eEt3ZkRQeEZ2?=
 =?utf-8?B?V05FSFgxMWZkVi9WMVpBaWhhTyt4QkM3YUZXODdkK0xSNThoWlM5bGZBanlw?=
 =?utf-8?B?RjJWSEk1ayt0RHk4OFJyUjhOSHl2R0NzYVQxVXF5T20rc3NzQ2I3cFZ5K0Ft?=
 =?utf-8?B?TnVVbjZjZU5HaXllc0U1dkU0dDJySEdQYnJNTWxLdy9WYk1aYU5MS2lTRXpC?=
 =?utf-8?B?NkFaSmlNWWM0QkovckJzV1R3dWlIeUhOM01BQ3h3ZjBrOFJPSzhLeHNMbi9s?=
 =?utf-8?B?QTlKcDBzK3Bia1RTaTl5SEIwOHBFTjRzWjBnZ0huUitnQ2dxRmwvR1JJT09Y?=
 =?utf-8?B?Wm9ZRXRhUVFMSVR1Y3k1VTJsTUZLSmJ4YkxSSFdtOWU4Lzd5Y3VGNENwS1lR?=
 =?utf-8?B?VkJmQWxtTU9jdHkycjlES0JIMFVieExqZVBhNVFydW5BeE0vUk5sV2pxUTBW?=
 =?utf-8?B?dnhHeU1uVlNRdG9XNm5yR0NhZVBUTDJNMmd1cHUrQU1idTcyemFEUGxJMWkv?=
 =?utf-8?B?ejB6RDFWZGk4dlc0ZUNVRmlvTXplNld2VVUxVE9Ca2RaK2EvcnluK3c3ZXkw?=
 =?utf-8?B?OVl1RjgrWnkyTlpXRWVtMnkrbGRVa2NpRStiNnp1anJTTWM2U0o2MXVqTEg0?=
 =?utf-8?B?U2dpaUJEcUgxZmhUM1psRG4yUk5jYVZwNmVyQ2ErT1N2cnc3UTFva1V3SDdY?=
 =?utf-8?B?UVZ3Y3lGV0Z1YVRqQysyUldBYldGeE9paDcvSjJhMzZFeGlsL1B2eDk2RzdS?=
 =?utf-8?B?akZJZDk1YjU2QXExb3BJS0Z5dUxMYWFTLzRFOHdNWEQ4SnU3MldEdlArbExN?=
 =?utf-8?B?a3FMbE5KeGRyY1JxbGFzalROWUYzR1duRTQ0TGdkdjBuWllJUzFoNG80Vmh0?=
 =?utf-8?B?QWJyUGE4ek94MWs2RUp3WExGUHJXUVYyY3JHaG9BNmY4aHVuNHFLdlR5ZWt0?=
 =?utf-8?B?QmIyTmticW9uRnBZdDFUbk5VTk1INVd0bDQ2TWw1RjFHeko0MEVabXAwc3lm?=
 =?utf-8?B?N3EveTljRENERDhjSGRDTFZaeHdLaGkxQWVHREFzM3Z0bFZ0MVRYd0Fhd2lo?=
 =?utf-8?Q?EHWPAif9wVtSGzghkup9F1Q66DRDhwyFhQ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7D73C597E7AF1A4B9D6C264786B90457@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1101MB2243.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f4b6683-b466-41ce-32cb-08d897153847
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2020 22:54:26.4933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0MAcexqaC0YAOr47wSTfv7Yi3lEI40gX8CXC6RmLOEWVlLhiN+If/CwoTPpfVCvhp+Zczjg/4BAzKUQXH1mkvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3618
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgQmpvcm4sDQoNCg0KPiBPbiBEZWMgMiwgMjAyMCwgYXQgMToyNyBQTSwgQmpvcm4gSGVsZ2Fh
cyA8aGVsZ2Fhc0BrZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIFdlZCwgRGVjIDAyLCAyMDIw
IGF0IDA4OjUzOjU0UE0gKzAwMDAsIEtlbGxleSwgU2VhbiBWIHdyb3RlOg0KPj4+IE9uIE5vdiAz
MCwgMjAyMCwgYXQgNDoyNSBQTSwgQmpvcm4gSGVsZ2FhcyA8aGVsZ2Fhc0BrZXJuZWwub3JnPiB3
cm90ZToNCj4+PiBPbiBNb24sIE5vdiAzMCwgMjAyMCBhdCAwNzo1NDozN1BNICswMDAwLCBLZWxs
ZXksIFNlYW4gViB3cm90ZToNCj4gDQo+Pj4+IC0JaWYgKHBjaWVfYWVyX2lzX25hdGl2ZShicmlk
Z2UpKQ0KPj4+PiAtCQlwY2llX2NsZWFyX2RldmljZV9zdGF0dXMoYnJpZGdlKTsNCj4+Pj4gLQlw
Y2lfYWVyX2NsZWFyX25vbmZhdGFsX3N0YXR1cyhicmlkZ2UpOw0KPj4+PiANCj4+Pj4gKwlpZiAo
dHlwZSA9PSBQQ0lfRVhQX1RZUEVfUk9PVF9QT1JUIHx8DQo+Pj4+ICsJICAgIHR5cGUgPT0gUENJ
X0VYUF9UWVBFX0RPV05TVFJFQU0gfHwNCj4+Pj4gKwkgICAgdHlwZSA9PSBQQ0lfRVhQX1RZUEVf
UkNfRUMpIHsNCj4+Pj4gKwkJaWYgKHBjaWVfYWVyX2lzX25hdGl2ZShicmlkZ2UpKQ0KPj4+PiAr
CQkJcGNpZV9jbGVhcl9kZXZpY2Vfc3RhdHVzKGJyaWRnZSk7DQo+Pj4+ICsJCXBjaV9hZXJfY2xl
YXJfbm9uZmF0YWxfc3RhdHVzKGJyaWRnZSk7DQo+Pj4+ICsJfQ0KPiANCj4gQmFjayB0byB0aGlz
IHNwZWNpZmljIGh1bmssIHdoYXQgaWYgd2UgbWFkZSBpdCB0aGlzPw0KPiANCj4gIHN0cnVjdCBw
Y2lfaG9zdF9icmlkZ2UgKmhvc3QgPSBwY2lfZmluZF9ob3N0X2JyaWRnZShkZXYtPmJ1cyk7DQo+
IA0KPiAgaWYgKGhvc3QtPm5hdGl2ZV9hZXIgfHwgcGNpZV9wb3J0c19uYXRpdmUpIHsNCj4gICAg
cGNpZV9jbGVhcl9kZXZpY2Vfc3RhdHVzKGJyaWRnZSk7DQo+ICAgIHBjaV9hZXJfY2xlYXJfbm9u
ZmF0YWxfc3RhdHVzKGJyaWRnZSk7DQo+ICB9DQo+IA0KPiBQcmV2aW91c2x5LCBpZiAiYnJpZGdl
IiBkaWRuJ3QgaGF2ZSBhbiBBRVIgQ2FwYWJpbGl0eSwgd2UgZGlkbid0DQo+IHBjaWVfY2xlYXJf
ZGV2aWNlX3N0YXR1cygpLiAgSW4gdGhlIGNhc2Ugb2YgYSBEUEMgYnJpZGdlIHdpdGhvdXQgQUVS
LA0KPiBJIHRoaW5rIHdlICpzaG91bGQqIGNhbGwgcGNpZV9jbGVhcl9kZXZpY2Vfc3RhdHVzKCku
DQoNCkFncmVlLCBJIHdhcyBvdmVybG9va2luZyBEUEMgaGVyZSB3aXRoIHRoZSBBRVIgY2hlY2su
DQoNCj4gDQo+IE90aGVyd2lzZSwgSSB0aGluayB0aGlzIHNob3VsZCB3b3JrIHRoZSBzYW1lIGFu
ZCB3b3VsZCBiZSBhIGxpdHRsZQ0KPiBzaW1wbGVyLg0KDQpMb29rcyBmaW5lIHRvIG1lLiAgSXQg
c2ltcGxpZmllcyBpdCBhIGJpdC4NCg0KPiANCj4+PiBJdCBzZWVtcyBsaWtlIHRoZXJlIGFyZSBi
YXNpY2FsbHkgdHdvIGRldmljZXMgb2YgaW50ZXJlc3QgaW4NCj4+PiBwY2llX2RvX3JlY292ZXJ5
KCk6IHRoZSBlbmRwb2ludCB3aGVyZSB3ZSBoYXZlIHRvIGNhbGwgdGhlIGRyaXZlcg0KPj4+IGVy
cm9yIHJlY292ZXJ5LCBhbmQgdGhlIHBvcnQgdGhhdCBnZW5lcmF0ZWQgdGhlIGludGVycnVwdC4g
IEkgd29uZGVyDQo+Pj4gaWYgdGhpcyB3b3VsZCBtYWtlIG1vcmUgc2Vuc2UgaWYgdGhlIGNhbGxl
ciBwYXNzZWQgYm90aCBvZiB0aGVtIGluDQo+Pj4gZXhwbGljaXRseSBpbnN0ZWFkIG9mIGhhdmlu
ZyBwY2llX2RvX3JlY292ZXJ5KCkgY2hlY2sgdGhlIHR5cGUgb2YNCj4+PiAiZGV2IiBhbmQgdHJ5
IHRvIGZpZ3VyZSB0aGluZ3Mgb3V0IGFmdGVyIHRoZSBmYWN0Lg0KPj4gDQo+PiBPbiB0aGlzIGxh
c3QgcG9pbnQgSSB3YW50ZWQgdG8gYWRkIHRoYXQgdGhpcyBpcyBhIHBvc3NpYmlsaXR5IHRoYXQN
Cj4+IGNvdWxkIHByb3ZpZGUgYSBjbGVhcmVyIGRpc3RpbmN0aW9uLCBlc3BlY2lhbGx5IHdoZXJl
IGFjdGlvbnMgbmVlZA0KPj4gdG8gYmUgdGFrZW4gb3Igbm90IHRha2VuIGFzIGEgcGFydCBvZiBw
Y2llX2RvX3JlY292ZXJ5KCksIGkuZS4sDQo+PiBicmlkZ2UgdmVyc3VzIGRldi4gIEluIHRoaXMg
cGF0Y2ggc2VyaWVzIHdlIGhhdmUgdGFrZW4gc3RlcHMgdG8NCj4+IG1pbmltaXplIHRoZSBuZWVk
IGZvciB0aGUgZGlzdGluY3Rpb24gYnkgcHVzaGluZyB0aGUgYXdhcmVuZXNzIGludG8NCj4+IHRo
ZSBkcml2ZXLigJlzIGVycm9yIHJlY292ZXJ5IHJvdXRpbmUsIGkuZS4sIGRldi0+cmNlYy4gIEEg
ZnV0dXJlDQo+PiBldm9sdXRpb24gYWZ0ZXIgdGhpcyBzZXJpZXMgY291bGQgbGVhZCB0byBib3Ro
IGRldmljZXMgb2YgaW50ZXJlc3QNCj4+IGJlaW5nIHBhc3NlZCBleHBsaWNpdGx5IGZvciB0aGUg
bGFyZ2VyIHNjb3BlIEVEUi9EUEMvQUVSL2V0Yy4NCj4gDQo+IFllYWgsIG5vdCB3b3J0aCBkb2lu
ZyBpbiAqdGhpcyogc2VyaWVzLg0KPiANCj4gQmpvcm4NCg0KVGhhbmtzLA0KDQpTZWFuDQoNCg==
