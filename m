Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B59FA2C19A7
	for <lists+linux-pci@lfdr.de>; Tue, 24 Nov 2020 01:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgKWX5l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Nov 2020 18:57:41 -0500
Received: from mga03.intel.com ([134.134.136.65]:14378 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727931AbgKWX5k (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 23 Nov 2020 18:57:40 -0500
IronPort-SDR: SDzPuZlclfGeD/aIcm+54HSM+6mom3JtMOjUH2EyT/4IE3p6S1I8FoAJx11gtdI9/yzU/7Biv+
 LglOHOjiIbwg==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="171961508"
X-IronPort-AV: E=Sophos;i="5.78,364,1599548400"; 
   d="scan'208";a="171961508"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 15:57:38 -0800
IronPort-SDR: yhUa19RbJYOQSdxu8VQz0x1+Dq86sQ/uBH8pEgepUiC8KvqwTJXv9ImA2/i4StTQgEdgt2X73o
 nGS5ibFjY3FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,364,1599548400"; 
   d="scan'208";a="358628017"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 23 Nov 2020 15:57:38 -0800
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 23 Nov 2020 15:57:37 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 23 Nov 2020 15:57:37 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 23 Nov 2020 15:57:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n3yHzw1mQn0dI/qOGiUrhyS9GiIevamC8R4b+GM0ZW7pl511JMUIu/g1QTEQ0tWJMbi1EbjoPMcF229e92rgaWAVM7cgAyql4e6QPC6ZynEKRw6nSChnQWydutpH88cDuFHFxHSKjRogviaZ0APJQCt11eFjtZ2nDRVqA9Y1fPwSZIChI0DeS7ws+8AyuBw2v9fIGKMaIqDhgmKXdsovNqwgP1eK00dc+jNjWR4yPYhoTW+pzRu9ooi45FlKSRHzFtbGvd830DuUGkt9DF12ulm1zGFWvy3UdmfsamK/nWgmWyVC78agaFav5wu/wvnC3RxL6wmU3ZVb7t5I3vGWAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=olUcHu2hP4GU0wzmYubmQF5WKjkDbLFMxeL8sVNxJ04=;
 b=Jf2hEeI3gQsLHRgARLTbxSmh9MBzwIscV/c3O0Bqq6t8iVFsViMDZ5RXtzEeRu5JqEHOi5fgMg42UfnC2yhWR/4c/f0hrqkN1eJ9P8jim242X5Rw71pyTUFtyD6HNEhk96JyaK8e1waeFTSGYVvQMylxnPFSvmIqFkeu2uzQMiWGDNCXkV3ylpTgLub7Wpefq7upYmFDXp+shs9m2Wxf51fWILQM1WYwPE7dVzkPaD4CcJ5lXvuu6Ym/P5en+IHeG9CW3fPVchhFdPzpL5DndHo4+2r/NhSkjaSrqn5wy8QO8ZXWbG9DFzihRh83WQrs+fFj/dXz/GQvw+G2uPkdjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=olUcHu2hP4GU0wzmYubmQF5WKjkDbLFMxeL8sVNxJ04=;
 b=ttBxU+a7mkV6JryVSfn6CmxLzSomhUlOM63asnC2suTIfRBStPHcZm5i2E6GDiEppgMrQsKYpMW/jPm67Wy+lm5/4/N1HI+K9SRO/RcVb8JV+iVjMCTEYqw5rfOCwmK5308fLMGMl1prpH9ExATc4gEkiHaYrnxr59ToAW8nPGk=
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com
 (2603:10b6:405:50::16) by BN6PR11MB1282.namprd11.prod.outlook.com
 (2603:10b6:404:4a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.30; Mon, 23 Nov
 2020 23:57:35 +0000
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::bcaa:2da8:af5e:4b51]) by BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::bcaa:2da8:af5e:4b51%11]) with mapi id 15.20.3589.030; Mon, 23 Nov
 2020 23:57:35 +0000
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
Thread-Index: AQHWv5rIZhXHzDUE4UiIgzOenVpmfKnWYYcAgAAIFgA=
Date:   Mon, 23 Nov 2020 23:57:35 +0000
Message-ID: <93D815E0-3100-4AAC-B9EE-AA6736A0419F@intel.com>
References: <20201123232838.GA498923@bjorn-Precision-5520>
In-Reply-To: <20201123232838.GA498923@bjorn-Precision-5520>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.20.0.2.21)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [24.20.148.49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e0102fad-61d9-4bcd-ea3f-08d8900b8cbb
x-ms-traffictypediagnostic: BN6PR11MB1282:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB1282385B37154AE2A0EF9054B2FC0@BN6PR11MB1282.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6b/V4JyMSvOvQzL8h6V6a8zp2uMJG4TOlvKZb5/uFtpbvHP/UGWhCQauK2jI3KH99vGpSbIzvXbM8+LTJsXRvczFAKysgh1iso0vR1juIYhJFzxrTwQwYy+6z9GWyZzWTmWbLWsFTGaSfB2q1S10ovUZ9pei80J0OvW9IbFo4xCRFdFx+0VQ9ekmvha+M272PgDYOb2uTO1eWEGtCGtTHkWGak5EEnVYskpsi36v09Fb90+ZZVxdq3cYbrzOGeMd9VVYgTcxBukZm3v8iwItJxcmsVrxevdIT+GK228JSm/kjIsTQV5cCIrUnE0DHbI1Ywx2jWXEncPE+xLNb4OiusBz/iZO8dTKG+cRll4vUTzSFKk1j2iVQZMOY/9eMVZeUDcKcsjFQSxiM2P3gWgJxw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1101MB2243.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(316002)(54906003)(33656002)(6512007)(6486002)(8676002)(8936002)(26005)(186003)(966005)(6916009)(6506007)(53546011)(478600001)(2616005)(4326008)(2906002)(5660300002)(91956017)(76116006)(83380400001)(66946007)(86362001)(64756008)(66556008)(66446008)(71200400001)(66476007)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: IBa4ukAavtxnNQ6qDkavR5mm0UWKG2QCdGDNmKfzdLvgsJtehoxTXERwM62qQJSRf/9U9N30aH+PvQ5Ryzgb0hMIAxdnc1ps8aOSTB4sviNdWvH/eIC8bolx6RZJct06MTXWV59SKfIEZ1lrMCGifYMH6x3vcQgDm0LNmhE1c7XtOD4e4Uljedr+v+ChlFbshKICbEm19fN1tLD+ymdn2yALl6bXvupdEdU+0OJK2T7U5YMBD2BtA1pcWGb6gklHUQ46n2ySPl4B5Z8rX8GGrSyJLGq4TFELzZGAViYOvgjDSYalm0SWaG8kV3EGtzkZY90h6ZF9yn7599ct+qJLdZktQrGdlasOKzEQbBuckjaL/PIkaQeLRcWQNhP3jC1Zzn24OmN2swqYD09oHsJ7DbmDqJ+sGL9/IEps+0y3mF4KP4W+xooHeudB0Uj/G+S+trMt1T9TgONIdmANRu1S+RXiNpRxkU4+erTRCJFwh/cxifbZuNN3EWn/u465dzrvt48f98bxJUJrJ1qbvBsUcrOgtv1h+8em/pQK2+WdwB7nHsr5VeuzQ7pDiC10GXaG0A577ApeINPobaF82iTm/tKrIHvDObcj7lvGUyb0CYQftwAhu6QCF+/3IdnKTp9RL+M8nU9Jp8YBEPHhsmJPJcxyeCgX4e//vkgnJ1hIexezY6qdGN+fVFki7HzYSflqSGDt1K7UJ6FLc6eNUGCNhJVndwRYchmuNJbwoscNjYc4w53asvey/H9SB97tbGLSJhN7xxhO5KAidwVdTHWL5Fvnk8FQ0sPzPTeVtSfm/F0h/rs4SwtY1V9eLYgQglERK5TbsjEfUm+bvlS/EjPrHhRWzZakET+8m6DXUiiPa4hl/08ffYbdD9yOcz/Zmvff8pndYocY8OUmbBS8L3e55w==
Content-Type: text/plain; charset="utf-8"
Content-ID: <5D61484BDBA70E429DC9203A4C909668@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1101MB2243.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0102fad-61d9-4bcd-ea3f-08d8900b8cbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2020 23:57:35.0921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XyQxbskcelJyQIHkzQhfIn+W7a8nmfEOjBxwx26kVQkFFC1xU3E1rmxnHVB+UmIlrvFozGnPy2Wrxb+tUtTtzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1282
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgQmpvcm4sDQoNCj4gT24gTm92IDIzLCAyMDIwLCBhdCAzOjI4IFBNLCBCam9ybiBIZWxnYWFz
IDxoZWxnYWFzQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gRnJpLCBOb3YgMjAsIDIwMjAg
YXQgMDQ6MTA6MzFQTSAtMDgwMCwgU2VhbiBWIEtlbGxleSB3cm90ZToNCj4+IEluIHNvbWUgY2Fz
ZXMgYSBicmlkZ2UgbWF5IG5vdCBleGlzdCBhcyB0aGUgaGFyZHdhcmUgY29udHJvbGxpbmcgbWF5
IGJlDQo+PiBoYW5kbGVkIG9ubHkgYnkgZmlybXdhcmUgYW5kIHNvIGlzIG5vdCB2aXNpYmxlIHRv
IHRoZSBPUy4gVGhpcyBzY2VuYXJpbyBpcw0KPj4gYWxzbyBwb3NzaWJsZSBpbiBmdXR1cmUgdXNl
IGNhc2VzIGludm9sdmluZyBub24tbmF0aXZlIHVzZSBvZiBSQ0VDcyBieQ0KPj4gZmlybXdhcmUu
DQo+PiANCj4+IEV4cGxpY2l0bHkgYXBwbHkgY29uZGl0aW9uYWwgbG9naWMgYXJvdW5kIHRoZXNl
IHJlc2V0cyBieSBsaW1pdGluZyB0aGVtIHRvDQo+PiBSb290IFBvcnRzIGFuZCBEb3duc3RyZWFt
IFBvcnRzLg0KPiANCj4gQ2FuIHlvdSBoZWxwIG1lIHVuZGVyc3RhbmQgdGhpcz8gIFRoZSBzdWJq
ZWN0IHNheXMgIkxpbWl0IEFFUiByZXNldHMiDQo+IGFuZCBoZXJlIHlvdSBzYXkgImxpbWl0IHRo
ZW0gdG8gUlBzIGFuZCBEUHMiLCBidXQgaXQncyBub3QgY29tcGxldGVseQ0KPiBvYnZpb3VzIGhv
dyB0aGUgcmVzZXRzIGFyZSBiZWluZyBsaW1pdGVkLCBpLmUuLCB0aGUgcGF0Y2ggZG9lc24ndCBh
ZGQNCj4gYW55dGhpbmcgbGlrZToNCj4gDQo+ICsgIGlmICh0eXBlID09IFBDSV9FWFBfVFlQRV9S
T09UX1BPUlQgfHwNCj4gKyAgICAgIHR5cGUgPT0gUENJX0VYUF9UWVBFX0RPV05TVFJFQU0pDQo+
ICAgICAgcmVzZXRfc3Vib3JkaW5hdGVzKGJyaWRnZSk7DQo+IA0KPiBJdCAqZG9lcyogYWRkIGNo
ZWNrcyBhcm91bmQgcGNpZV9jbGVhcl9kZXZpY2Vfc3RhdHVzKCksIGJ1dCB0aGF0IGFsc28NCj4g
aW5jbHVkZXMgUkNfRUMuICBBbmQgdGhhdCdzIG5vdCBhIHJlc2V0LCBzbyBJIGRvbid0IHRoaW5r
IHRoYXQncw0KPiBleHBsaWNpdGx5IG1lbnRpb25lZCBpbiB0aGUgY29tbWl0IGxvZy4NCg0KVGhl
IHN1YmplY3Qgc2hvdWxkIGhhdmUgcmVmZXJyZWQgdG8gdGhlIGNsZWFyaW5nIG9mIHRoZSBkZXZp
Y2Ugc3RhdHVzIHJhdGhlciB0aGFuIHJlc2V0cy4NCkl0IG9yaWdpbmFsbHkgY2FtZSBmcm9tIHRo
aXMgc2ltcGxlciBwYXRjaCBpbiB3aGljaCBJIG1hZGUgdXNlIG9mIHJlc2V0IGluc3RlYWQgb2Yg
Y2xlYXI6DQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXBjaS8yMDIwMTAwMjE4NDcz
NS4xMjI5MjIwLTgtc2VhbnZrLmRldkBvcmVnb250cmFja3Mub3JnLw0KDQpTbyBhIHJlcGhyYXNl
IG9mIGNsZWFyaW5nIGluIHBsYWNlIG9mIHJlc2V0cyB3b3VsZCBiZSBtb3JlIGFwcHJvcHJpYXRl
Lg0KDQpUaGVuIHdlIGFkZGVkIHRoZSBub3Rpb24gb2YgYnJpZGdlc+KApmJlbG93DQoNCj4gDQo+
IEFsc28gc2VlIHRoZSBxdWVzdGlvbiBiZWxvdy4NCj4gDQo+PiBMaW5rOiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9yLzIwMjAxMDAyMTg0NzM1LjEyMjkyMjAtOC1zZWFudmsuZGV2QG9yZWdvbnRy
YWNrcy5vcmcNCj4+IFNpZ25lZC1vZmYtYnk6IFNlYW4gViBLZWxsZXkgPHNlYW4udi5rZWxsZXlA
aW50ZWwuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogQmpvcm4gSGVsZ2FhcyA8YmhlbGdhYXNAZ29v
Z2xlLmNvbT4NCj4+IEFja2VkLWJ5OiBKb25hdGhhbiBDYW1lcm9uIDxKb25hdGhhbi5DYW1lcm9u
QGh1YXdlaS5jb20+DQo+PiAtLS0NCj4+IGRyaXZlcnMvcGNpL3BjaWUvZXJyLmMgfCAzMSArKysr
KysrKysrKysrKysrKysrKysrKysrLS0tLS0tDQo+PiAxIGZpbGUgY2hhbmdlZCwgMjUgaW5zZXJ0
aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNp
L3BjaWUvZXJyLmMgYi9kcml2ZXJzL3BjaS9wY2llL2Vyci5jDQo+PiBpbmRleCA4YjUzYWVjZGI0
M2QuLjc4ODNjOTc5MTU2MiAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvcGNpL3BjaWUvZXJyLmMN
Cj4+ICsrKyBiL2RyaXZlcnMvcGNpL3BjaWUvZXJyLmMNCj4+IEBAIC0xNDgsMTMgKzE0OCwxNyBA
QCBzdGF0aWMgaW50IHJlcG9ydF9yZXN1bWUoc3RydWN0IHBjaV9kZXYgKmRldiwgdm9pZCAqZGF0
YSkNCj4+IA0KPj4gLyoqDQo+PiAgKiBwY2lfd2Fsa19icmlkZ2UgLSB3YWxrIGJyaWRnZXMgcG90
ZW50aWFsbHkgQUVSIGFmZmVjdGVkDQo+PiAtICogQGJyaWRnZToJYnJpZGdlIHdoaWNoIG1heSBi
ZSBhIFBvcnQNCj4+ICsgKiBAYnJpZGdlOglicmlkZ2Ugd2hpY2ggbWF5IGJlIGEgUG9ydCwgYW4g
UkNFQyB3aXRoIGFzc29jaWF0ZWQgUkNpRVBzLA0KPj4gKyAqCQlvciBhbiBSQ2lFUCBhc3NvY2lh
dGVkIHdpdGggYW4gUkNFQw0KPj4gICogQGNiOgkJY2FsbGJhY2sgdG8gYmUgY2FsbGVkIGZvciBl
YWNoIGRldmljZSBmb3VuZA0KPj4gICogQHVzZXJkYXRhOglhcmJpdHJhcnkgcG9pbnRlciB0byBi
ZSBwYXNzZWQgdG8gY2FsbGJhY2sNCj4+ICAqDQo+PiAgKiBJZiB0aGUgZGV2aWNlIHByb3ZpZGVk
IGlzIGEgYnJpZGdlLCB3YWxrIHRoZSBzdWJvcmRpbmF0ZSBidXMsIGluY2x1ZGluZw0KPj4gICog
YW55IGJyaWRnZWQgZGV2aWNlcyBvbiBidXNlcyB1bmRlciB0aGlzIGJ1cy4gIENhbGwgdGhlIHBy
b3ZpZGVkIGNhbGxiYWNrDQo+PiAgKiBvbiBlYWNoIGRldmljZSBmb3VuZC4NCj4+ICsgKg0KPj4g
KyAqIElmIHRoZSBkZXZpY2UgcHJvdmlkZWQgaGFzIG5vIHN1Ym9yZGluYXRlIGJ1cywgY2FsbCB0
aGUgY2FsbGJhY2sgb24gdGhlDQo+PiArICogZGV2aWNlIGl0c2VsZi4NCj4+ICAqLw0KPj4gc3Rh
dGljIHZvaWQgcGNpX3dhbGtfYnJpZGdlKHN0cnVjdCBwY2lfZGV2ICpicmlkZ2UsDQo+PiAJCQkg
ICAgaW50ICgqY2IpKHN0cnVjdCBwY2lfZGV2ICosIHZvaWQgKiksDQo+PiBAQCAtMTYyLDYgKzE2
Niw4IEBAIHN0YXRpYyB2b2lkIHBjaV93YWxrX2JyaWRnZShzdHJ1Y3QgcGNpX2RldiAqYnJpZGdl
LA0KPj4gew0KPj4gCWlmIChicmlkZ2UtPnN1Ym9yZGluYXRlKQ0KPj4gCQlwY2lfd2Fsa19idXMo
YnJpZGdlLT5zdWJvcmRpbmF0ZSwgY2IsIHVzZXJkYXRhKTsNCj4+ICsJZWxzZQ0KPj4gKwkJY2Io
YnJpZGdlLCB1c2VyZGF0YSk7DQo+PiB9DQo+PiANCj4+IHBjaV9lcnNfcmVzdWx0X3QgcGNpZV9k
b19yZWNvdmVyeShzdHJ1Y3QgcGNpX2RldiAqZGV2LA0KPj4gQEAgLTE3NCwxMCArMTgwLDEzIEBA
IHBjaV9lcnNfcmVzdWx0X3QgcGNpZV9kb19yZWNvdmVyeShzdHJ1Y3QgcGNpX2RldiAqZGV2LA0K
Pj4gDQo+PiAJLyoNCj4+IAkgKiBFcnJvciByZWNvdmVyeSBydW5zIG9uIGFsbCBzdWJvcmRpbmF0
ZXMgb2YgdGhlIGJyaWRnZS4gIElmIHRoZQ0KPj4gLQkgKiBicmlkZ2UgZGV0ZWN0ZWQgdGhlIGVy
cm9yLCBpdCBpcyBjbGVhcmVkIGF0IHRoZSBlbmQuDQo+PiArCSAqIGJyaWRnZSBkZXRlY3RlZCB0
aGUgZXJyb3IsIGl0IGlzIGNsZWFyZWQgYXQgdGhlIGVuZC4gIEZvciBSQ2lFUHMNCj4+ICsJICog
d2Ugc2hvdWxkIHJlc2V0IGp1c3QgdGhlIFJDaUVQIGl0c2VsZi4NCj4+IAkgKi8NCj4+IAlpZiAo
dHlwZSA9PSBQQ0lfRVhQX1RZUEVfUk9PVF9QT1JUIHx8DQo+PiAtCSAgICB0eXBlID09IFBDSV9F
WFBfVFlQRV9ET1dOU1RSRUFNKQ0KPj4gKwkgICAgdHlwZSA9PSBQQ0lfRVhQX1RZUEVfRE9XTlNU
UkVBTSB8fA0KPj4gKwkgICAgdHlwZSA9PSBQQ0lfRVhQX1RZUEVfUkNfRUMgfHwNCj4+ICsJICAg
IHR5cGUgPT0gUENJX0VYUF9UWVBFX1JDX0VORCkNCj4+IAkJYnJpZGdlID0gZGV2Ow0KPj4gCWVs
c2UNCj4+IAkJYnJpZGdlID0gcGNpX3Vwc3RyZWFtX2JyaWRnZShkZXYpOw0KPj4gQEAgLTE4NSw2
ICsxOTQsMTIgQEAgcGNpX2Vyc19yZXN1bHRfdCBwY2llX2RvX3JlY292ZXJ5KHN0cnVjdCBwY2lf
ZGV2ICpkZXYsDQo+PiAJcGNpX2RiZyhicmlkZ2UsICJicm9hZGNhc3QgZXJyb3JfZGV0ZWN0ZWQg
bWVzc2FnZVxuIik7DQo+PiAJaWYgKHN0YXRlID09IHBjaV9jaGFubmVsX2lvX2Zyb3plbikgew0K
Pj4gCQlwY2lfd2Fsa19icmlkZ2UoYnJpZGdlLCByZXBvcnRfZnJvemVuX2RldGVjdGVkLCAmc3Rh
dHVzKTsNCj4+ICsJCWlmICh0eXBlID09IFBDSV9FWFBfVFlQRV9SQ19FTkQpIHsNCj4+ICsJCQlw
Y2lfd2FybihkZXYsICJzdWJvcmRpbmF0ZSBkZXZpY2UgcmVzZXQgbm90IHBvc3NpYmxlIGZvciBS
Q2lFUFxuIik7DQo+PiArCQkJc3RhdHVzID0gUENJX0VSU19SRVNVTFRfTk9ORTsNCj4+ICsJCQln
b3RvIGZhaWxlZDsNCj4+ICsJCX0NCj4+ICsNCj4+IAkJc3RhdHVzID0gcmVzZXRfc3Vib3JkaW5h
dGVzKGJyaWRnZSk7DQo+PiAJCWlmIChzdGF0dXMgIT0gUENJX0VSU19SRVNVTFRfUkVDT1ZFUkVE
KSB7DQo+PiAJCQlwY2lfd2FybihicmlkZ2UsICJzdWJvcmRpbmF0ZSBkZXZpY2UgcmVzZXQgZmFp
bGVkXG4iKTsNCj4+IEBAIC0yMTcsOSArMjMyLDEzIEBAIHBjaV9lcnNfcmVzdWx0X3QgcGNpZV9k
b19yZWNvdmVyeShzdHJ1Y3QgcGNpX2RldiAqZGV2LA0KPj4gCXBjaV9kYmcoYnJpZGdlLCAiYnJv
YWRjYXN0IHJlc3VtZSBtZXNzYWdlXG4iKTsNCj4+IAlwY2lfd2Fsa19icmlkZ2UoYnJpZGdlLCBy
ZXBvcnRfcmVzdW1lLCAmc3RhdHVzKTsNCj4+IA0KPj4gLQlpZiAocGNpZV9hZXJfaXNfbmF0aXZl
KGJyaWRnZSkpDQo+PiAtCQlwY2llX2NsZWFyX2RldmljZV9zdGF0dXMoYnJpZGdlKTsNCj4+IC0J
cGNpX2Flcl9jbGVhcl9ub25mYXRhbF9zdGF0dXMoYnJpZGdlKTsNCj4+ICsJaWYgKHR5cGUgPT0g
UENJX0VYUF9UWVBFX1JPT1RfUE9SVCB8fA0KPj4gKwkgICAgdHlwZSA9PSBQQ0lfRVhQX1RZUEVf
RE9XTlNUUkVBTSB8fA0KPj4gKwkgICAgdHlwZSA9PSBQQ0lfRVhQX1RZUEVfUkNfRUMpIHsNCj4+
ICsJCWlmIChwY2llX2Flcl9pc19uYXRpdmUoYnJpZGdlKSkNCj4+ICsJCQlwY2llX2NsZWFyX2Rl
dmljZV9zdGF0dXMoYnJpZGdlKTsNCj4+ICsJCXBjaV9hZXJfY2xlYXJfbm9uZmF0YWxfc3RhdHVz
KGJyaWRnZSk7DQo+IA0KPiBUaGlzIGlzIGhhcmQgdG8gdW5kZXJzdGFuZCBiZWNhdXNlICJ0eXBl
IiBpcyBmcm9tICJkZXYiLCBidXQgImJyaWRnZSINCj4gaXMgbm90IG5lY2Vzc2FyaWx5IHRoZSBz
YW1lIGRldmljZS4gIFNob3VsZCBpdCBiZSB0aGlzPw0KPiANCj4gIHR5cGUgPSBwY2lfcGNpZV90
eXBlKGJyaWRnZSk7DQo+ICBpZiAodHlwZSA9PSBQQ0lfRVhQX1RZUEVfUk9PVF9QT1JUIHx8DQo+
ICAgICAgLi4uKQ0KDQpDb3JyZWN0LCBpdCB3b3VsZCBiZSBiZXR0ZXIgaWYgdGhlIHR5cGUgd2Fz
IGJhc2VkIG9uIHRoZSDigJhicmlkZ2XigJkuDQoNClRoYW5rcywNCg0KU2Vhbg0KDQo+IA0KPj4g
Kwl9DQo+PiAJcGNpX2luZm8oYnJpZGdlLCAiZGV2aWNlIHJlY292ZXJ5IHN1Y2Nlc3NmdWxcbiIp
Ow0KPj4gCXJldHVybiBzdGF0dXM7DQo+PiANCj4+IC0tIA0KPj4gMi4yOS4yDQoNCg==
