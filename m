Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF6D2B7D67
	for <lists+linux-pci@lfdr.de>; Wed, 18 Nov 2020 13:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgKRMKY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Nov 2020 07:10:24 -0500
Received: from mga05.intel.com ([192.55.52.43]:5285 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726696AbgKRMKY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Nov 2020 07:10:24 -0500
IronPort-SDR: 4/oclUUnjl8+yKAWI2vOiM0zxyrYi5SbsNSps/gl1UXf36lp+LGNR1jExZfIunaYcwCqAhaNzV
 m4y4M8S3c/Mw==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="255816451"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="255816451"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 04:10:22 -0800
IronPort-SDR: Q3cNW2ttJF1XyqIv85r7bww9P5qoPdYPQLDCAxbWSV9kWJBBBMHPeO/275leotcAWYpGjl/6v2
 LfDDNcn6/q5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="356968386"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga008.jf.intel.com with ESMTP; 18 Nov 2020 04:10:21 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 18 Nov 2020 04:10:21 -0800
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 18 Nov 2020 04:10:20 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 18 Nov 2020 04:10:20 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.54) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 18 Nov 2020 04:10:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=na51tfG1qeBiSJbv7uMLYpLRMRi3sorNz05aZ1fIM+6QjmWOOd3BvWrh5IDsO4hXtcHkIDO4Hzn/79aguwsMTOfI/2dzgWvOnOdt0QRPjQCJ809ZmonCwEcl3w5EFHbsiYFU4qPKhdxhO8aAal03Hh3fRaDp3/cggbNOfaVkCjL68keJ9RFY3UFha4VrhTAKYxx2hKPpw8VQIzkNTQVACMHBy/2CbCJzsYPwpkHKztTV0I+wn7nv1KzSmjX0XB+YjwGNnsH3j6q+o6O7I+jEFqwx4tV42Zd9j4a2/cWUQs73Dkg/5VeLZXfJh8SMlZXDEMN2hRZFbPGQjkk5NwH4Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMC6RNExbCMAtbBnUtGPPoF2UrDgJsv4jKpOTVWGi68=;
 b=iI0FLAK96KehvMrkCJ4JwuIR6T8OTuROxFaHDgrfMZw03EnY0fX+0PacoxuP0iIYycmoemlc2UQI1gUxBodP6c5oWxJSohrT48MAOyZ4nAKoJGPy84GKKuRmB44TCv+kFVT53bIZYQY4Kb5cpQitfMNMDra/jdG6H/Ch5s/Q/RsJ+3RFNN/3O7JY4uHOM1IqQ8qXZmQaZMFbJlxhfCtMtmTpYLhGG7wmkjwIErtWrd5YWzGf4rTjQ1a8UzgMGBNIiAxpaXCNC8TtY1aNNiVyEs0gyYgLHxmuONI+95IQ1jIeUAxikCTpSanUjbXeLazdB3+/6qvLQL7ciZQUWxUPYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMC6RNExbCMAtbBnUtGPPoF2UrDgJsv4jKpOTVWGi68=;
 b=nDrnp+5/Af7gmHRSTprXHADewCJZ1Nt5iDgy+YPgifZyy85Oq0mxOiTWemlBHQHQBmACJqo/0O697dbtv8MMxJt/fmx01RRQWmhmO5v4bu8AQwBENrfuWe/Zft/0d6uY9YcqA2lVxDTg6MFeLjoZFgenTFCxJH4ib4LYXLBD9QQ=
Received: from SN6PR11MB3421.namprd11.prod.outlook.com (2603:10b6:805:cd::27)
 by SN6PR11MB3103.namprd11.prod.outlook.com (2603:10b6:805:d7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Wed, 18 Nov
 2020 12:10:17 +0000
Received: from SN6PR11MB3421.namprd11.prod.outlook.com
 ([fe80::791d:58e0:ec0d:9d59]) by SN6PR11MB3421.namprd11.prod.outlook.com
 ([fe80::791d:58e0:ec0d:9d59%3]) with mapi id 15.20.3499.034; Wed, 18 Nov 2020
 12:10:17 +0000
From:   "Surendrakumar Upadhyay, TejaskumarX" 
        <tejaskumarx.surendrakumar.upadhyay@intel.com>
To:     Daniel Vetter <daniel@ffwll.ch>, Bjorn Helgaas <helgaas@kernel.org>
CC:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "De Marchi, Lucas" <lucas.demarchi@intel.com>,
        "Roper, Matthew D" <matthew.d.roper@intel.com>,
        "Pandey, Hariom" <hariom.pandey@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>
Subject: RE: [PATCH] x86/gpu: add JSL stolen memory support
Thread-Topic: [PATCH] x86/gpu: add JSL stolen memory support
Thread-Index: AQHWstDzxN2Pwg+4lUqs/o8gwa6wpqm5S1QAgABL34CAAUSNAIATBaJg
Date:   Wed, 18 Nov 2020 12:10:16 +0000
Message-ID: <SN6PR11MB34212AAA9B0409A857BE2261DFE10@SN6PR11MB3421.namprd11.prod.outlook.com>
References: <160456956585.5393.4540325192433934522@jlahtine-mobl.ger.corp.intel.com>
 <20201105141739.GA493962@bjorn-Precision-5520>
 <CAKMK7uFj+5p4XPUnd2Mc3R4i2Umja5-iGgDg+jVzRBhCW-6qbQ@mail.gmail.com>
In-Reply-To: <CAKMK7uFj+5p4XPUnd2Mc3R4i2Umja5-iGgDg+jVzRBhCW-6qbQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: ffwll.ch; dkim=none (message not signed)
 header.d=none;ffwll.ch; dmarc=none action=none header.from=intel.com;
x-originating-ip: [150.129.165.86]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eae65c2d-55e2-41ea-351a-08d88bbae992
x-ms-traffictypediagnostic: SN6PR11MB3103:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB3103DC7DD0DD4F17B4CD3392DFE10@SN6PR11MB3103.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZNiRZqRrmi4s9BhxWDdkoRqL4so2qW41lTLUqbG5TriWr6NUCp6iuSQubJpKc10hnFwBUuc9Vp4tIT4AZms6FilZgPjkVHTouwWzm21OnOJ3oQAbrG2ag9hRrFpRVBlfXAVcmN9L9m4GBSr9PugDLxo6MjOFtTNPqTplMKDXYHdmjMrR2ZJgGaLtUNJqwRg5YF6Z1MC2QxqexLIqArfKUxPWkF5/HHa0ratqj428ed1Zr6foDnhNDwhycM7NldGB9L3CyrFYJLVB4fPKva2h977OQSHV5hyz/3l241UfsczTiLrt2dJL3+Un7+r+ZkJM9FUAl56kEn/qsPNLsq7R4wq7V2lLQuH9qdQK76Lm9xpxC+bXGkaNBuK+dY/z7MFXnRcF09q69tZWNhNl6A/JeGIjJh6hfZLBnVvxQa5Nz8RnMgHhOMsLoRKjSAeD3RCA4onZNW9WIkWuHo9N2ob0aw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3421.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(376002)(39860400002)(396003)(53546011)(316002)(54906003)(110136005)(76116006)(86362001)(7696005)(8936002)(6506007)(66556008)(66476007)(66446008)(2906002)(66946007)(52536014)(4326008)(186003)(966005)(5660300002)(64756008)(8676002)(26005)(9686003)(33656002)(478600001)(83080400002)(71200400001)(83380400001)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Sw1IM7OuJ/YdwEYQQL1b8Htj9xgcYdNDO9tqCmuy1ZLo4C6MgrACqZxKJq5j5yxX2KnHhbFLYKTdcjw86UiKsxhAN7Q13RN8+oAfue2bSHj2obojgKq0Z1WOqzOWqOyOq/pLGEkrTAIGioQ8qO8Q0hWv/AnuF9bCAJq3LB5E7c8eWNHUyy9CUGXisUEl+iceH8AYQ/5kXY+dQIY1LJdfs7UrSMk/+Lps5xzhGYA5kr7aI1YS/GdYGWjQJWKIJV3/PhkuKNMQTkS3JAlFvniUFIVBRx86Gmx2TCDm3TT8yR/96fQbUlwPwPOJ0UXTA4UUkkAeQ0R6GtZgVOtbVzEKgYvi7xJv007UQGKZPbAGfr72gmTWxzgyq+o7voSb7Wnt2vuADQrzlfwpbVm1t28nlMuCjnI40Z2QTKhgDEEwsZFWtUyAFpNoHfq6TVrr0tDhgVxeuCIA/PzQre4/4TLiC40apILGi87KC7uwKpqkXwwv7hvIKtgTXRbZzUKFinD0dVIgtfVRowr1cZzhIfuYPiJOL7i/TDK0Xo3kunNQj8IinGfcKbOxA1hmeRqikhGlS2SSKE/Ax870rVSv77Yon/+CbWpCKzB351XQpy8SMumIM6JdCw461mvf1uNZT6uFPvenDjj97nMEW2yf9g6/4g==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eae65c2d-55e2-41ea-351a-08d88bbae992
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2020 12:10:16.9787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L00q7bMGcWKasvl2YWPdI5xewELdbgChEztnS0M2dkTCTqIU94tl5zqe6iDBwNKe7DGxsbyqBgKNf+7RmiIhkkjE2JVpOAzjw667hdUsNZwL94OtjrhTWL2hlA65r3qYIKZ7va+Pk8HTfphVd58zOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3103
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SnVzdCBjaGVja2luZywgY2FuIHNvbWVib2R5IHJldmlldy9tZXJnZSB0aGUgcGF0Y2g/IA0KDQpU
aGFua3MsDQpUZWphcw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERh
bmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4NCj4gU2VudDogMDYgTm92ZW1iZXIgMjAyMCAx
NTowOQ0KPiBUbzogQmpvcm4gSGVsZ2FhcyA8aGVsZ2Fhc0BrZXJuZWwub3JnPg0KPiBDYzogSm9v
bmFzIExhaHRpbmVuIDxqb29uYXMubGFodGluZW5AbGludXguaW50ZWwuY29tPjsgU3VyZW5kcmFr
dW1hcg0KPiBVcGFkaHlheSwgVGVqYXNrdW1hclgNCj4gPHRlamFza3VtYXJ4LnN1cmVuZHJha3Vt
YXIudXBhZGh5YXlAaW50ZWwuY29tPjsgTGludXggUENJIDxsaW51eC0NCj4gcGNpQHZnZXIua2Vy
bmVsLm9yZz47IExpbnV4IEtlcm5lbCBNYWlsaW5nIExpc3QgPGxpbnV4LQ0KPiBrZXJuZWxAdmdl
ci5rZXJuZWwub3JnPjsgWDg2IE1MIDx4ODZAa2VybmVsLm9yZz47IEJvcmlzbGF2IFBldGtvdg0K
PiA8YnBAYWxpZW44LmRlPjsgRGUgTWFyY2hpLCBMdWNhcyA8bHVjYXMuZGVtYXJjaGlAaW50ZWwu
Y29tPjsgUm9wZXIsDQo+IE1hdHRoZXcgRCA8bWF0dGhldy5kLnJvcGVyQGludGVsLmNvbT47IFBh
bmRleSwgSGFyaW9tDQo+IDxoYXJpb20ucGFuZGV5QGludGVsLmNvbT47IEphbmkgTmlrdWxhIDxq
YW5pLm5pa3VsYUBsaW51eC5pbnRlbC5jb20+OyBWaXZpLA0KPiBSb2RyaWdvIDxyb2RyaWdvLnZp
dmlAaW50ZWwuY29tPjsgRGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPg0KPiBTdWJqZWN0
OiBSZTogW1BBVENIXSB4ODYvZ3B1OiBhZGQgSlNMIHN0b2xlbiBtZW1vcnkgc3VwcG9ydA0KPiAN
Cj4gT24gVGh1LCBOb3YgNSwgMjAyMCBhdCAzOjE3IFBNIEJqb3JuIEhlbGdhYXMgPGhlbGdhYXNA
a2VybmVsLm9yZz4gd3JvdGU6DQo+ID4NCj4gPiBPbiBUaHUsIE5vdiAwNSwgMjAyMCBhdCAxMTo0
NjowNkFNICswMjAwLCBKb29uYXMgTGFodGluZW4gd3JvdGU6DQo+ID4gPiBRdW90aW5nIEJqb3Ju
IEhlbGdhYXMgKDIwMjAtMTEtMDQgMTk6MzU6NTYpDQo+ID4gPiA+IFsrY2MgSmFuaSwgSm9vbmFz
LCBSb2RyaWdvLCBEYXZpZCwgRGFuaWVsXQ0KPiA+ID4gPg0KPiA+ID4gPiBPbiBXZWQsIE5vdiAw
NCwgMjAyMCBhdCAwNTozNTowNlBNICswNTMwLCBUZWphcyBVcGFkaHlheSB3cm90ZToNCj4gPiA+
ID4gPiBKU0wgcmUtdXNlcyB0aGUgc2FtZSBzdG9sZW4gbWVtb3J5IGFzIElDTCBhbmQgRUhMLg0K
PiA+ID4gPiA+DQo+ID4gPiA+ID4gQ2M6IEx1Y2FzIERlIE1hcmNoaSA8bHVjYXMuZGVtYXJjaGlA
aW50ZWwuY29tPg0KPiA+ID4gPiA+IENjOiBNYXR0IFJvcGVyIDxtYXR0aGV3LmQucm9wZXJAaW50
ZWwuY29tPg0KPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFRlamFzIFVwYWRoeWF5DQo+ID4gPiA+
ID4gPHRlamFza3VtYXJ4LnN1cmVuZHJha3VtYXIudXBhZGh5YXlAaW50ZWwuY29tPg0KPiA+ID4g
Pg0KPiA+ID4gPiBJIGRvbid0IHBsYW4gdG8gZG8gYW55dGhpbmcgd2l0aCB0aGlzIHNpbmNlIHBy
ZXZpb3VzIHNpbWlsYXINCj4gPiA+ID4gcGF0Y2hlcyBoYXZlIGdvbmUgdGhyb3VnaCBzb21lIG90
aGVyIHRyZWUsIHNvIHRoaXMgaXMganVzdCBraWJpdHppbmcuDQo+ID4gPiA+DQo+ID4gPiA+IEJ1
dCB0aGUgZmFjdCB0aGF0IHdlIGhhdmUgdGhpcyBsb25nIGxpc3Qgb2YgSW50ZWwgZGV2aWNlcyBb
MV0gdGhhdA0KPiA+ID4gPiBjb25zdGFudGx5IG5lZWRzIHVwZGF0ZXMgWzJdIGlzIGEgaGludCB0
aGF0IHNvbWV0aGluZyBpcyB3cm9uZy4NCj4gPiA+DQo+ID4gPiBXZSBhZGQgYW4gZW50cnkgZm9y
IGV2ZXJ5IG5ldyBpbnRlZ3JhdGVkIGdyYXBoaWNzIHBsYXRmb3JtLiBPbmNlIHRoZQ0KPiA+ID4g
cGxhdGZvcm0gaXMgYWRkZWQsIHRoZXJlIGhhdmUgbm90IGJlZW4gY2hhbmdlcyBsYXRlbHkuDQo+
ID4gPg0KPiA+ID4gPiBJSVVDIHRoZSBnZW5lcmFsIGlkZWEgaXMgdGhhdCB3ZSBuZWVkIHRvIGRp
c2NvdmVyIEludGVsIGdmeCBtZW1vcnkNCj4gPiA+ID4gYnkgbG9va2luZyBhdCBkZXZpY2UtZGVw
ZW5kZW50IGNvbmZpZyBzcGFjZSBhbmQgYWRkIGl0IHRvIHRoZSBFODIwDQo+IG1hcC4NCj4gPiA+
ID4gQXBwYXJlbnRseSB0aGUgcXVpcmtzIGRpc2NvdmVyIHRoaXMgdmlhIFBDSSBjb25maWcgcmVn
aXN0ZXJzIGxpa2UNCj4gPiA+ID4gSTgzMF9FU01SQU1DLCBJODQ1X0VTTVJBTUMsIGV0YywgYW5k
IHRlbGwgdGhlIGRyaXZlciBhYm91dCBpdCB2aWENCj4gPiA+ID4gdGhlIGdsb2JhbCAiaW50ZWxf
Z3JhcGhpY3Nfc3RvbGVuX3JlcyI/DQo+ID4gPg0KPiA+ID4gV2UgZGlzY292ZXIgd2hhdCBpcyBj
YWxsZWQgdGhlIGdyYXBoaWNzIGRhdGEgc3RvbGVuIG1lbW9yeS4gSXQgaXMNCj4gPiA+IHJlZ3Vs
YXIgc3lzdGVtIG1lbW9yeSByYW5nZSB0aGF0IGlzIG5vdCBDUFUgYWNjZXNzaWJsZS4gSXQgaXMN
Cj4gPiA+IGFjY2Vzc2libGUgYnkgdGhlIGludGVncmF0ZWQgZ3JhcGhpY3Mgb25seS4NCj4gPiA+
DQo+ID4gPiBTZWU6DQo+ID4gPiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgv
a2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvYw0KPiA+ID4gb21taXQvYXJjaC94ODYva2Vy
bmVsL2Vhcmx5LXF1aXJrcy5jP2g9djUuMTAtDQo+IHJjMiZpZD04MTRjNWYxZjUyYTRiZWIzDQo+
ID4gPiA3MTAzMTcwMjJhY2Q2YWQzNGZjMGI2YjkNCj4gPiA+DQo+ID4gPiA+IFRoYXQncyBub3Qg
dGhlIHdheSB0aGlzIHNob3VsZCB3b3JrLiAgVGhlcmUgc2hvdWxkIHNvbWUgZ2VuZXJpYywNCj4g
PiA+ID4gbm9uIGRldmljZS1kZXBlbmRlbnQgUENJIG9yIEFDUEkgbWV0aG9kIHRvIGRpc2NvdmVy
IHRoZSBtZW1vcnkNCj4gPiA+ID4gdXNlZCwgb3IgYXQgbGVhc3Qgc29tZSB3YXkgdG8gZG8gaXQg
aW4gdGhlIGRyaXZlciBpbnN0ZWFkIG9mIGVhcmx5IGFyY2gNCj4gY29kZS4NCj4gPiA+DQo+ID4g
PiBJdCdzIHVzZWQgYnkgdGhlIGVhcmx5IEJJT1MvVUVGSSBjb2RlIHRvIHNldCB1cCBpbml0aWFs
IGZyYW1lYnVmZmVyLg0KPiA+ID4gRXZlbiBpZiBpOTE1IGRyaXZlciBpcyBuZXZlciBsb2FkZWQs
IHRoZSBtZW1vcnkgcmFuZ2VzIHN0aWxsIG5lZWQgdG8NCj4gPiA+IGJlIGZpeGVkLiBUaGV5IHNv
dXJjZSBvZiB0aGUgcHJvYmxlbSBpcyB0aGF0IHRoZSBPRU0gQklPUyB3aGljaCBhcmUNCj4gPiA+
IG5vdCB1bmRlciBvdXIgY29udHJvbCBnZXQgdGhlIHByb2dyYW1taW5nIHdyb25nLg0KPiA+ID4N
Cj4gPiA+IFdlIHVzZWQgdG8gZGV0ZWN0IHRoZSBtZW1vcnkgcmVnaW9uIHNpemUgYWdhaW4gYXQg
aTkxNQ0KPiA+ID4gaW5pdGlhbGl6YXRpb24gYnV0IHdhbnRlZCB0byBlbGltaW5hdGUgdGhlIGNv
ZGUgZHVwbGljYXRpb24gYW5kDQo+ID4gPiByZXN1bHRpbmcgc3VidGxlIGJ1Z3MgdGhhdCBjYXVz
ZWQuIENvbmNsdXNpb24gYmFjayB0aGVuIHdhcyB0aGF0DQo+ID4gPiBzdG9yaW5nIHRoZSBzdHJ1
Y3QgcmVzb3VyY2UgaW4gbWVtb3J5IGlzIHRoZSBiZXN0IHRyYWRlLW9mZi4NCj4gPiA+DQo+ID4g
PiA+IEhvdyBpcyB0aGlzICpzdXBwb3NlZCogdG8gd29yaz8gIElzIHRoZXJlIHNvbWV0aGluZyB3
ZSBjYW4gZG8gaW4NCj4gPiA+ID4gRTgyMCBvciBvdGhlciByZXNvdXJjZSBtYW5hZ2VtZW50IHRo
YXQgd291bGQgbWFrZSB0aGlzIGVhc2llcj8NCj4gPiA+DQo+ID4gPiBUaGUgY29kZSB3YXMgYWRk
ZWQgYXJvdW5kIEhhc3dlbGwgKEhTVykgZGV2aWNlIGdlbmVyYXRpb24gdG8NCj4gPiA+IG1pdGln
YXRlIGJ1Z3MgaW4gQklPUy4gSXQgaXMgdHJhZGl0aW9uYWxseSBoYXJkIHRvIGdldCBhbGwgT0VN
cyB0bw0KPiA+ID4gZml4IHRoZWlyIEJJT1Mgd2hlbiB0aGluZ3Mgd29yayBmb3IgV2luZG93cy4g
SXQncyBvbmx5IGxhdGVyIHllYXJzDQo+ID4gPiB3aGVuIHNvbWUgbGFwdG9wIG1vZGVscyBhcmUg
aW50ZW5kZWQgdG8gYmUgc29sZCB3aXRoIExpbnV4Lg0KPiA+ID4NCj4gPiA+IFRoZSBhbHRlcm5h
dGl2ZSB3b3VsZCBiZSB0byBnZXQgYWxsIHRoZSBPRU0gdG8gZml4IHRoZWlyIEJJT1MgZm9yDQo+
ID4gPiBMaW51eCwgYnV0IHRoYXQgaXMgbm90IHZlcnkgcmVhbGlzdGljIGdpdmVuIHBhc3QgZXhw
ZXJpZW5jZXMuIFNvIGl0DQo+ID4gPiBzZWVtcyBhIGJldHRlciBjaG9pY2UgdG8gdG8gYWRkIG5l
dyBsaW5lIHBlciBwbGF0Zm9ybSBnZW5lcmF0aW9uIHRvDQo+ID4gPiBtYWtlIHN1cmUgdGhlIHVz
ZXJzIGNhbiBib290IHRvIExpbnV4Lg0KPiA+DQo+ID4gSG93IGRvZXMgV2luZG93cyBkbyB0aGlz
PyAgRG8gdGhleSBoYXZlIHRvIGFkZCBzaW1pbGFyIGNvZGUgZm9yIGVhY2gNCj4gPiBuZXcgcGxh
dGZvcm0/DQo+IA0KPiBXaW5kb3dzIGlzIGNoaWNrZW4gYW5kIGRvZXNuJ3QgbW92ZSBhbnkgbW1p
byBiYXIgYXJvdW5kIG9uIGl0cyBvd24uDQo+IEV4Y2VwdCBpZiB0aGUgYmlvcyBleHBsaWNpdGx5
IHRvbGQgaXQgc29tZWhvdyAoZS5nLiBmb3IgdGhlIDY0Yml0IGJhciBzdHVmZiBhbWQNCj4gcmVj
ZW50bHkgYW5ub3VuY2VkIGZvciB3aW5kb3dzLCB0aGF0IGxpbnV4IHN1cHBvcnRzIHNpbmNlIHll
YXJzIGJ5IG1vdmluZw0KPiB0aGUgYmFyKS4gU28gZXhjZXB0IGlmIHlvdSB3YW50IHRvIHByZWVt
cHRpdmVseSBkaXNhYmxlIHRoZSBwY2kgY29kZSB0aGF0IGRvZXMNCj4gdGhpcyBhbnl0aW1lIHRo
ZXJlJ3MgYW4gaW50ZWwgZ3B1LCB0aGlzIGlzIHdoYXQgd2UgaGF2ZSB0byBkby4NCj4gDQo+IEFu
ZCBnaXZlbiB0aGF0IHRoaXMgNjRiaXQgbW1pbyBiYXIgc3VwcG9ydCBpbiB3aW5kb3dzIHN0aWxs
IHJlcXVpcmVzIGFuDQo+IGV4cGxpY2l0IGJpb3MgdXBncmFkZSBmb3IgdGhlIGV4cGxpY2l0IG9w
dCBpbiBJIGRvbid0IHRoaW5rIHRoaXMgd2lsbCBjaGFuZ2UNCj4gYW55dGltZSBzb29uLg0KPiAN
Cj4gV2UgaGF2ZSBhIHNpbWlsYXIgdWdseSBwcm9ibGVtIHdpdGgga3ZtLCBzaW5jZSB5b3UgY2Fu
J3QgdXNlIHRoZXNlIHJhbmdlcw0KPiBmcmVlbHkgKHRoZXkncmUgdmVyeSBzcGVjaWFsIGluIGh3
KSwgYW5kIHRoZSBrdm0gbWFpbnRhaW5lcnMgYXJlIGVxdWFsbHkNCj4gYW5ub3llZCB0aGF0IHRo
ZXkgaGF2ZSB0byBrZWVwIHN1cHBvcnRpbmcgUlJNUiB0byBibG9jayB0aGF0IHJhbmdlLCBqdXN0
DQo+IGJlY2F1c2Ugb2YgaW50ZWwgaW50ZWdyYXRlZCBncmFwaGljcy4gQXBwYXJlbnRseSB3aW5k
b3dzIGlzIGFnYWluIHRvdGFsbHkgZmluZQ0KPiB3aXRoIHRoaXMuDQo+IC1EYW5pZWwNCj4gDQo+
IA0KPiA+DQo+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gIGFyY2gveDg2L2tlcm5lbC9lYXJseS1x
dWlya3MuYyB8IDEgKw0KPiA+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykN
Cj4gPiA+ID4gPg0KPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvZWFybHkt
cXVpcmtzLmMNCj4gPiA+ID4gPiBiL2FyY2gveDg2L2tlcm5lbC9lYXJseS1xdWlya3MuYyBpbmRl
eA0KPiA+ID4gPiA+IGE0YjVhZjAzZGNjMS4uNTM0Y2MzZjc4YzZiIDEwMDY0NA0KPiA+ID4gPiA+
IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9lYXJseS1xdWlya3MuYw0KPiA+ID4gPiA+ICsrKyBiL2Fy
Y2gveDg2L2tlcm5lbC9lYXJseS1xdWlya3MuYw0KPiA+ID4gPiA+IEBAIC01NDksNiArNTQ5LDcg
QEAgc3RhdGljIGNvbnN0IHN0cnVjdCBwY2lfZGV2aWNlX2lkDQo+IGludGVsX2Vhcmx5X2lkc1td
IF9faW5pdGNvbnN0ID0gew0KPiA+ID4gPiA+ICAgICAgIElOVEVMX0NOTF9JRFMoJmdlbjlfZWFy
bHlfb3BzKSwNCj4gPiA+ID4gPiAgICAgICBJTlRFTF9JQ0xfMTFfSURTKCZnZW4xMV9lYXJseV9v
cHMpLA0KPiA+ID4gPiA+ICAgICAgIElOVEVMX0VITF9JRFMoJmdlbjExX2Vhcmx5X29wcyksDQo+
ID4gPiA+ID4gKyAgICAgSU5URUxfSlNMX0lEUygmZ2VuMTFfZWFybHlfb3BzKSwNCj4gPiA+ID4g
PiAgICAgICBJTlRFTF9UR0xfMTJfSURTKCZnZW4xMV9lYXJseV9vcHMpLA0KPiA+ID4gPiA+ICAg
ICAgIElOVEVMX1JLTF9JRFMoJmdlbjExX2Vhcmx5X29wcyksICB9Ow0KPiA+ID4gPg0KPiA+ID4g
PiBbMV0NCj4gPiA+ID4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5l
bC9naXQvdG9ydmFsZHMvbGludXguZ2l0DQo+ID4gPiA+IC90cmVlL2FyY2gveDg2L2tlcm5lbC9l
YXJseS1xdWlya3MuYz9oPXY1LjEwLXJjMiNuNTE4DQo+ID4gPiA+DQo+ID4gPiA+IFsyXQ0KPiA+
ID4gPiAgIE1heSAyMDIwIGVmYmVlMDIxYWQwMiAoIng4Ni9ncHU6IGFkZCBSS0wgc3RvbGVuIG1l
bW9yeSBzdXBwb3J0IikNCj4gPiA+ID4gICBKdWwgMjAxOSA2YjI0MzZhZWI5NDUgKCJ4ODYvZ3B1
OiBhZGQgVEdMIHN0b2xlbiBtZW1vcnkgc3VwcG9ydCIpDQo+ID4gPiA+ICAgTWFyIDIwMTkgZDUz
ZmVmMGJlNGE1ICgieDg2L2dwdTogYWRkIEVsa2hhcnRMYWtlIHRvIGdlbjExIGVhcmx5DQo+IHF1
aXJrcyIpDQo+ID4gPiA+ICAgTWF5IDIwMTggZGIwYzhkOGIwMzFkICgieDg2L2dwdTogcmVzZXJ2
ZSBJQ0wncyBncmFwaGljcyBzdG9sZW4NCj4gbWVtb3J5IikNCj4gPiA+ID4gICBEZWMgMjAxNyAz
M2FhNjllZDhhYWMgKCJ4ODYvZ3B1OiBhZGQgQ0ZMIHRvIGVhcmx5IHF1aXJrcyIpDQo+ID4gPiA+
ICAgSnVsIDIwMTcgMmUxZTlkNDg5MzllICgieDg2L2dwdTogQ05MIHVzZXMgdGhlIHNhbWUgR01T
IHZhbHVlcyBhcw0KPiBTS0wiKQ0KPiA+ID4gPiAgIEphbiAyMDE3IGJjMzg0Yzc3ZTNiYiAoIng4
Ni9ncHU6IEdMSyB1c2VzIHRoZSBzYW1lIEdNUyB2YWx1ZXMgYXMNCj4gU0tMIikNCj4gPiA+ID4g
ICBPY3QgMjAxNSAwMGNlNWM4YTY2ZmIgKCJkcm0vaTkxNS9rYmw6IEthYnlsYWtlIHVzZXMgdGhl
IHNhbWUgR01TDQo+IHZhbHVlcyBhcyBTa3lsYWtlIikNCj4gPiA+ID4gICBNYXIgMjAxNSAzMWQ0
ZGNmNzA1YzMgKCJkcm0vaTkxNS9ieHQ6IEJyb3h0b24gdXNlcyB0aGUgc2FtZSBHTVMNCj4gdmFs
dWVzIGFzIFNreWxha2UiKQ0KPiA+ID4gPiAgIC4uLg0KPiANCj4gDQo+IA0KPiAtLQ0KPiBEYW5p
ZWwgVmV0dGVyDQo+IFNvZnR3YXJlIEVuZ2luZWVyLCBJbnRlbCBDb3Jwb3JhdGlvbg0KPiBodHRw
Oi8vYmxvZy5mZndsbC5jaA0K
