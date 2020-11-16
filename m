Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF652B4F2A
	for <lists+linux-pci@lfdr.de>; Mon, 16 Nov 2020 19:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731865AbgKPSXv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Nov 2020 13:23:51 -0500
Received: from mga01.intel.com ([192.55.52.88]:49905 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731610AbgKPSXv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Nov 2020 13:23:51 -0500
IronPort-SDR: mKS1E5/UZgRUbc7CErbtsJiSS45RMt4YOfKiKRoihVh8UgzniiBYZXcCQgycLKTaaH5a4Mr4JO
 VENN7USS7BCA==
X-IronPort-AV: E=McAfee;i="6000,8403,9807"; a="188840208"
X-IronPort-AV: E=Sophos;i="5.77,483,1596524400"; 
   d="scan'208";a="188840208"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 10:23:50 -0800
IronPort-SDR: tji9soBUDFbC7cfuCDXv0VIwXEOCzHWBN1UXOWhqvKu1BdtyoAo+BhemwT4o93jLGpCnwh2XF1
 Kg8smV43+5SA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,483,1596524400"; 
   d="scan'208";a="324880434"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga003.jf.intel.com with ESMTP; 16 Nov 2020 10:23:49 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 16 Nov 2020 10:23:45 -0800
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 16 Nov 2020 10:23:45 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 16 Nov 2020 10:23:45 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 16 Nov 2020 10:23:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gouIKBaCRrCg6tMCrzRS0yQosYo3N+a2rd22GDntCFWMJdDm4l/s0z47QHHxupcl9QBCQMPKgnKHhhnDsZrDCXeg+QKF2Gi9r1jrQyzlqUAZ8VhyVlaPgg4Y75Xra5K+c7wWkQLQ0NK78hVdijxKwuADTI96U4k0hKQ5o5QxeGbjQb2aKrnvjflDRc/BcmwQB6BaA/YBcOHCMKVPkoWTFwSmthUAw9+0EZOIazk7cetZgOmYlDe7hdJh8xfIIBJINk3D5KgWYHJvqasH2dWmRWi1pt3gvx0oU3w8ANej2eTpkHkv4vGjEL15L25my6B1Ri5GMYHkEy3DNm3xboXbDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7a1mO8vYoJm8dEqHEwOq5ZmRHCvFT40FN0BTj9fTWg=;
 b=GpdiWDUjCM1AU73YlHxRheFNWpSbs5jn7RYGbzUUP43kwDGRhg8CQEdJAamNCoajTL3z8HqQLytLPiT+poy8hW7zj7QVLLWpR/YLqJk5iZLvLt85opaZ1TRYgif/UMyj+Ujrx5Qb7hen7qIQJ5BZ3oXig7aRrCaIJeWZpcguJsCOvzY+uLy7xOpU74173JmJsTbTqmxKECuhRul7lMP5bWiwkzXhLkbgA5KDo5BlxQkHqU3pV1VNO/r9IytIUz6qGbm48zRSPchhOjnRqqh4odGiwRw3CQ5AoH/BUYifKlGONmJC5hpsuo4WveCL4vtlyc9TYbAoVPWOuVqb4Qqz2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7a1mO8vYoJm8dEqHEwOq5ZmRHCvFT40FN0BTj9fTWg=;
 b=LIl8aX3IDt5NoVNughgJ3RjuocFt752cVQGaq7/uxZ7TkSm/KvdG3AY5o1cRmKfaa7eJiGXXZZlJRH3vJuzkb1CwdT65G78sKwEAT2IHzmj3XFy868A7il84j9iKzJep0jhSInqLEJzNl/ahi+lXEh+/QntwP9rK+pSVj3bD+9Y=
Received: from BYAPR11MB3448.namprd11.prod.outlook.com (2603:10b6:a03:76::21)
 by BYAPR11MB3767.namprd11.prod.outlook.com (2603:10b6:a03:fd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Mon, 16 Nov
 2020 18:23:43 +0000
Received: from BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::14fe:76f0:df82:d27f]) by BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::14fe:76f0:df82:d27f%5]) with mapi id 15.20.3541.028; Mon, 16 Nov 2020
 18:23:42 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Widawsky, Ben" <ben.widawsky@intel.com>,
        "Jonathan.Cameron@Huawei.com" <Jonathan.Cameron@Huawei.com>
CC:     "Kelley, Sean V" <sean.v.kelley@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [RFC PATCH 1/9] cxl/acpi: Add an acpi_cxl module for the CXL
 interconnect
Thread-Topic: [RFC PATCH 1/9] cxl/acpi: Add an acpi_cxl module for the CXL
 interconnect
Thread-Index: AQHWt+2uigGgJYIEAkacA1Kck/o98anLFIoAgAAG0oA=
Date:   Mon, 16 Nov 2020 18:23:42 +0000
Message-ID: <c370882b75936d34bd6ebc4319b7f65503cfb9b1.camel@intel.com>
References: <20201111054356.793390-1-ben.widawsky@intel.com>
         <20201111054356.793390-2-ben.widawsky@intel.com>
         <20201116175916.000008bc@Huawei.com>
In-Reply-To: <20201116175916.000008bc@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5 (3.36.5-1.fc32) 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.54.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d36d5202-d8f3-4013-f451-08d88a5cbfa7
x-ms-traffictypediagnostic: BYAPR11MB3767:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB37672D7CA15689545C92B092C7E30@BYAPR11MB3767.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0XRjVUu4AK7qKUbRYa2T9fHTK6ilb57YdLX7ZQDEqnXR1rK8zmINgyRrTYollIC/qhi1Z7q3MEqsJ6qvu9eD1Qr5ge3YDa7ARHhrcTw+aV2D2ki95EaAv/TcHdxv9o472+ycVB/7RHITqiNCDqGl8RH+3lkcZMcV0rEdN5YWG14gc2fKtupSg/x+9txwLNk8dkd4ad3sj4JkOnm8e0XwuSzYqrlHSdY98BEq/yzl+WPWbLTk/cbdKA6ePXm4Go8do2nVyISqsS6tnrN4CY39VU8jTb23uAayde/Oz0vX1tJCXwzm75xsexsHz5Yi0+ANDaQSFdmMCJ76lhLzzQETTw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3448.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(39860400002)(396003)(346002)(136003)(6486002)(4326008)(110136005)(64756008)(54906003)(66446008)(6512007)(66556008)(66476007)(5660300002)(8676002)(478600001)(2906002)(66946007)(76116006)(86362001)(8936002)(186003)(36756003)(26005)(2616005)(4001150100001)(6506007)(83380400001)(316002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: SjeJ7CoY+J9PVOqckx9F2J1gdoKxa4tXB8koTClx2QdW+0qqgZD4kt1jWJYF0qXN0bqUUVS2P4Qtk9wenthhzmfmwbUNVMLIHCk7sKoKpBU2q3ydl/WO+6n1NeyAdqysknIyB9Y8q4CU4UOXk9jLIrKRNQuocF3/vVuepdy279IlNZ64VA5GEs694cRYevjO1TpmOqoI4+5EEY12C9BreABY1y393B82WPq+iNg5CmT5VKIO3qnyGuPcLLN4GrWSRMoiCgwhpH83Xj+aXYvfdResKJLQ3XkHKCgJBcVHMD2JVJGFyTmhbSqHwCAzwfHFXlDMCWFtcNFMK8PMeToMHW+8trqomFsQHakDgywoXQODjZDRSlrDIomg7Sy76YeQg5Cva0k73xPXzRLULMHnyiBKGdW1+CMJ4FCYld27ifuYa/UsptIl/4dmTUerJcW7pJfmAWtSgZdteGPFjQMYlQMqye+Z9auO0+tPEQIXheA/rPnmle6AqZOKDRjWPM3GJ4SWUSbc+Uq2/jbbFCvt9A7/1cv/ZhjqoD5c4iAzpuxv09g0QsMzYds5VXXhQ6dmqHm6txYRCDdcN/rDRNc7AeeOWkWIX4wbh0RxyS3Vp1UqJTnaKyj/Www2d5OtYutjJCAR22h72eWhB0dGK2qzbTobmk2vtwzD8Ho9s5bfr6t1ibZbeawWWWFGvORi5c3QqHPVE6LzCtPY49YAnBEAQ60KTyH4zL2xzH2GlbvQuWWKLaSh4LZFEIwu5Gk02CCPZxWdUM1jIxgeG53hCDxr8O50mJ1V3ZEqGfcGJCTTkXlaDnF7zXfbGYfB9lgD1/BJr8rJB1qjaUGixEp4US7jIqr0Uuy6nmMcfeYgzty3Z/DoCnJ9F9bblgbdkuAWYCsiNAYjOsKr06jWBlJwzQycYA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <57C419418B0D6C4B89F3B35FBDDFEBCA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3448.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d36d5202-d8f3-4013-f451-08d88a5cbfa7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2020 18:23:42.8115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qzOIhEdkG0LUvgZXEk9nxWutlxx6r3GAPmJ0YQK0vzQb5q7jmVba5MymrX1y0aT5TQSMDYEHZbCCeI6OpA1yUF5xw2sLHgYr4vWOlAfozVc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3767
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gTW9uLCAyMDIwLTExLTE2IGF0IDE3OjU5ICswMDAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBPbiBUdWUsIDEwIE5vdiAyMDIwIDIxOjQzOjQ4IC0wODAwDQo+IEJlbiBXaWRhd3NreSA8
YmVuLndpZGF3c2t5QGludGVsLmNvbT4gd3JvdGU6DQo+IA0KPiA+IEZyb206IFZpc2hhbCBWZXJt
YSA8dmlzaGFsLmwudmVybWFAaW50ZWwuY29tPg0KPiA+IA0KPiA+IEFkZCBhbiBhY3BpX2N4bCBt
b2R1bGUgdG8gY29vcmRpbmF0ZSB0aGUgQUNQSSBwb3J0aW9ucyBvZiB0aGUgQ1hMDQo+ID4gKENv
bXB1dGUgZVhwcmVzcyBMaW5rKSBpbnRlcmNvbm5lY3QuIFRoaXMgZHJpdmVyIGJpbmRzIHRvIEFD
UEkwMDE3DQo+ID4gb2JqZWN0cyBpbiB0aGUgQUNQSSB0cmVlLCBhbmQgY29vcmRpbmF0ZXMgYWNj
ZXNzIHRvIHRoZSByZXNvdXJjZXMNCj4gPiBwcm92aWRlZCBieSB0aGUgQUNQSSBDRURUIChDWEwg
RWFybHkgRGlzY292ZXJ5IFRhYmxlKS4NCj4gDQo+IEkgdGhpbmsgdGhlIHFlbXUgc2VyaWVzIG5v
dGVzIHRoYXQgdGhpcyBBQ1BJMDAxNyBpcyBqdXN0IGEgcHJvcG9zYWwgYXQNCj4gdGhpcyBzdGFn
ZS4gUGxlYXNlIG1ha2Ugc3VyZSB0aGF0J3MgaGlnaGxpZ2h0ZWQgaGVyZSBhcyB3ZWxsIHVubGVz
cw0KPiB0aGF0IHN0YXR1cyBpcyBvdXQgb2YgZGF0ZS4NCg0KSGkgSm9uYXRoYW4sDQoNClRoYW5r
IHlvdSBmb3IgdGhlIHJldmlldy4gVGhlIGNvdmVyIGxldHRlciB0YWxrcyBhYm91dCB0aGlzLCBi
dXQgSSBhZ3JlZQ0KaXQgd291bGQgYmUgd29ydGggcmVwZWF0aW5nIGluIHRoaXMgcGF0Y2ggYnJp
ZWZseSBhcyBJIGRpZCB3aXRoIHRoZSBPU0MNCnBhdGNoLiBJZiBpdCBpcyBzdGlsbCBpbiBhIHBy
b3Bvc2FsIHN0YXRlIGJ5IHRoZSBuZXh0IHBvc3RpbmcsIEknbGwgbWFrZQ0Kc3VyZSB0byBhZGQg
YSBub3RlIGhlcmUgdG9vLg0KDQo+IA0KPiA+ICsNCj4gPiArc3RhdGljIHZvaWQgYWNwaV9jeGxf
ZGVzY19pbml0KHN0cnVjdCBhY3BpX2N4bF9kZXNjICphY3BpX2Rlc2MsIHN0cnVjdCBkZXZpY2Ug
KmRldikNCj4gPiArew0KPiA+ICsJZGV2X3NldF9kcnZkYXRhKGRldiwgYWNwaV9kZXNjKTsNCj4g
DQo+IE5vIG5lZWQgdG8gaGF2ZSB0aGlzIHdyYXBwZXIgKyBpdCBoaWRlcyB0aGUgZmFjdCB5b3Ug
YXJlIG5vdCBqdXN0IGluaXRpYWxzaW5nDQo+IHRoZSBhY3BpX2Rlc2Mgc3RydWN0dXJlLg0KPiAN
Cj4gPiArCWFjcGlfZGVzYy0+ZGV2ID0gZGV2Ow0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMg
dm9pZCBhY3BpX2NlZHRfcHV0X3RhYmxlKHZvaWQgKnRhYmxlKQ0KPiA+ICt7DQo+ID4gKwlhY3Bp
X3B1dF90YWJsZSh0YWJsZSk7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgYWNwaV9j
eGxfYWRkKHN0cnVjdCBhY3BpX2RldmljZSAqYWRldikNCj4gPiArew0KPiA+ICsJc3RydWN0IGFj
cGlfY3hsX2Rlc2MgKmFjcGlfZGVzYzsNCj4gPiArCXN0cnVjdCBkZXZpY2UgKmRldiA9ICZhZGV2
LT5kZXY7DQo+ID4gKwlzdHJ1Y3QgYWNwaV90YWJsZV9oZWFkZXIgKnRibDsNCj4gPiArCWFjcGlf
c3RhdHVzIHN0YXR1cyA9IEFFX09LOw0KPiANCj4gU2V0IGJlbG93LCBzbyBkb24ndCBkbyBpdCBo
ZXJlLg0KPiANCj4gPiArCWFjcGlfc2l6ZSBzejsNCj4gPiArCWludCByYyA9IDA7DQo+IA0KPiBT
ZXQgaW4gcGF0aHMgaW4gd2hpY2ggaXQncyB1c2VkIHNvIGRvbid0IGRvIGl0IGhlcmUuDQo+IA0K
PiA+ICsNCj4gPiArCXN0YXR1cyA9IGFjcGlfZ2V0X3RhYmxlKEFDUElfU0lHX0NFRFQsIDAsICZ0
YmwpOw0KPiA+ICsJaWYgKEFDUElfRkFJTFVSRShzdGF0dXMpKSB7DQo+ID4gKwkJZGV2X2Vycihk
ZXYsICJmYWlsZWQgdG8gZmluZCBDRURUIGF0IHN0YXJ0dXBcbiIpOw0KPiA+ICsJCXJldHVybiAw
Ow0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCXJjID0gZGV2bV9hZGRfYWN0aW9uX29yX3Jlc2V0KGRl
diwgYWNwaV9jZWR0X3B1dF90YWJsZSwgdGJsKTsNCj4gPiArCWlmIChyYykNCj4gPiArCQlyZXR1
cm4gcmM7DQo+IA0KPiBibGFuayBsaW5lIGhlcmUgcHJlZmVycmVkIGZvciByZWFkYWJpbGl0eSAo
ZG8gc29tZXRoaW5nLCB0aGVuIGNoZWNrIGVycm9ycyBhcw0KPiBibG9jaykNCj4gDQo+ID4gKwlz
eiA9IHRibC0+bGVuZ3RoOw0KPiA+ICsJZGV2X2luZm8oZGV2LCAiZm91bmQgQ0VEVCBhdCBzdGFy
dHVwOiAlbGxkIGJ5dGVzXG4iLCBzeik7DQo+ID4gKw0KPiA+ICsJYWNwaV9kZXNjID0gZGV2bV9r
emFsbG9jKGRldiwgc2l6ZW9mKCphY3BpX2Rlc2MpLCBHRlBfS0VSTkVMKTsNCj4gPiArCWlmICgh
YWNwaV9kZXNjKQ0KPiA+ICsJCXJldHVybiAtRU5PTUVNOw0KPiANCj4gYmxhbmsgbGluZSBoZXJl
IHNsaWdodGx5IGhlbHBzIHJlYWRhYmlsaXR5Lg0KPiANCj4gPiArCWFjcGlfY3hsX2Rlc2NfaW5p
dChhY3BpX2Rlc2MsICZhZGV2LT5kZXYpOw0KPiA+ICsNCj4gPiArCWFjcGlfZGVzYy0+YWNwaV9o
ZWFkZXIgPSAqdGJsOw0KPiA+ICsNCj4gPiArCXJldHVybiAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+
ICtzdGF0aWMgaW50IGFjcGlfY3hsX3JlbW92ZShzdHJ1Y3QgYWNwaV9kZXZpY2UgKmFkZXYpDQo+
ID4gK3sNCj4gPiArCXJldHVybiAwOw0KPiANCj4gRG9uJ3QgdGhpbmsgZW1wdHkgcmVtb3ZlIGlz
IG5lZWRlZC4NCj4gDQoNCkFncmVlZCB3aXRoIGFsbCBvZiB0aGUgYWJvdmUsIEknbGwgZml4IGZv
ciB0aGUgbmV4dCBwb3N0aW5nLg0KDQo+ID4gKw0KPiA+ICsvKiBWYWx1ZXMgZm9yIENFRFQgc3Ry
dWN0dXJlIHR5cGVzICovDQo+ID4gKw0KPiA+ICtlbnVtIGFjcGlfY2VkdF90eXBlIHsNCj4gPiAr
CUFDUElfQ0VEVF9UWVBFX0hPU1RfQlJJREdFID0gMCwgLyogQ0hCUyAtIENYTCBIb3N0IEJyaWRn
ZSBTdHJ1Y3R1cmUgKi8NCj4gPiArCUFDUElfQ0VEVF9UWVBFX0NGTVdTID0gMSwgCS8qIENGTVdT
IC0gQ1hMIEZpeGVkIE1lbW9yeSBXaW5kb3cgU3RydWN0dXJlICovDQo+IA0KPiBUaGlzIGlzbid0
IGluIHRoZSAyLjAgc3BlYywgc28gSSBndWVzcyBhbHNvIHBhcnQgb2Ygc29tZSBwcm9wb3NlZCBj
aGFuZ2VzLg0KDQpZZXMgdGhpcyBnb3QgaW4gYWNjaWRlbnRhbGx5LCB3aWxsIHJlbW92ZS4NCg0K
DQo=
