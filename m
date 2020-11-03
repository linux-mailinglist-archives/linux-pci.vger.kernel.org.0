Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE3952A3C6B
	for <lists+linux-pci@lfdr.de>; Tue,  3 Nov 2020 07:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbgKCGCD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Nov 2020 01:02:03 -0500
Received: from mga17.intel.com ([192.55.52.151]:55214 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727389AbgKCGCB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Nov 2020 01:02:01 -0500
IronPort-SDR: OU0o+br139fKtiV2/vjARCp7nSq8HNcajHmn2W8req0N7R6HsHzrsuS5gup7AGaURdwTD1IbuO
 3GyG71jmcF9w==
X-IronPort-AV: E=McAfee;i="6000,8403,9793"; a="148859167"
X-IronPort-AV: E=Sophos;i="5.77,447,1596524400"; 
   d="scan'208";a="148859167"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2020 22:02:00 -0800
IronPort-SDR: NUBxee2qSp33TbNtS18zlqml7FibMToCRwBgc3B28gl5POTV8Iz06dwLQeF1LJWngyK9LHj9T+
 LOqrvpBXZt2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,447,1596524400"; 
   d="scan'208";a="352230341"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP; 02 Nov 2020 22:02:00 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 2 Nov 2020 22:01:59 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 2 Nov 2020 22:01:59 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 2 Nov 2020 22:01:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8Qg1O+bYdE9DsRMcLTiLnRu/vM5HGfiR4BGMK7vu1aZ8Kw/SDAtlygPyBj41djoglzghKLbVGe9Frh7BjcRuzE6gcx2/qxNqgLksHzOtsHfcSYlWZi55SMWz3z0Uy0glJWT0wXtvao96RXLZcnKuAPHy6pFB8J5yskIIP4Vpetc1FAOE/PMktKISEKSxKYwDnsH15sXSzFbCXEbWHJr28VpYxTuJk2khHb/qmX3+Doxt+E/6fuhEIwxwz4mJJ5WsdKIFKHOVl6Z9w7v1cC6FeP0Zu4CL/XwyPnYfN+rG8RlYUaVeWmWlQXugUtD3BxMyla5DL4V4GrzlgsvMq2bIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QO9Fm9b+OJy1G9UBaQSn/tbCuxu3iyAn/NIZmhV66ZM=;
 b=ITW69sZEtJ/cCu5vuHW3/xlykV3A584TZl6a+eI5mSdtePHcKhKy4iB3NuVOR6qTn8Bn17sfi/Oq7EUaP75DdKuFtYUo91I3b5OyMuh9jybQO/ukrLpG5Byy+IhPazadd4mCyxPaBHYSV1H+YhN4x0wA1zVlB/N4L2Cz3sz4UnuIkvDJY4B9z5CZC5VkuUW+XcG7WDmpbJQJPkc0d8kQQACxvkJawo7zPsIxL5/valgdJEHJzV8+E6s6892ab95PZ7iXS+eO5zxpWlmed8oddKSxA9HYvujE4r6i0TdMObvSkptycza+HslOSblybHMZ//BKwccXIxgk+P42dZA2bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QO9Fm9b+OJy1G9UBaQSn/tbCuxu3iyAn/NIZmhV66ZM=;
 b=HZ36Xy1xGc/pLZ7WVlz8tpNos0+b4BnBOhAcWQ47qMhYtsFIzm1cCmUkgLPOHWILNv4TzBN3i9BCozvZE19BtzuklO2jQmKNsVEs7J25B8+pImj1rusFNDoKGp9/jKvdZdV3MkoKHwn1RpTZ0hghRugig35fIJecpI0/QFM2e6Y=
Received: from DM6PR11MB3721.namprd11.prod.outlook.com (2603:10b6:5:142::10)
 by DM5PR11MB1915.namprd11.prod.outlook.com (2603:10b6:3:110::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Tue, 3 Nov
 2020 06:01:57 +0000
Received: from DM6PR11MB3721.namprd11.prod.outlook.com
 ([fe80::5017:4139:6553:ded4]) by DM6PR11MB3721.namprd11.prod.outlook.com
 ([fe80::5017:4139:6553:ded4%6]) with mapi id 15.20.3499.030; Tue, 3 Nov 2020
 06:01:57 +0000
From:   "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     Rob Herring <robh@kernel.org>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>
Subject: RE: [PATCH 1/2] dt-bindings: PCI: Add Intel Keem Bay PCIe controller
Thread-Topic: [PATCH 1/2] dt-bindings: PCI: Add Intel Keem Bay PCIe controller
Thread-Index: AQHWrCaxhZj5grmS3kiKdr1Lx1u9aqmtGMWAgAL7nPCAACzFgIAFsREw
Date:   Tue, 3 Nov 2020 06:01:57 +0000
Message-ID: <DM6PR11MB3721E3877611EEE08E90C2A9DD110@DM6PR11MB3721.namprd11.prod.outlook.com>
References: <20201027060011.25893-1-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20201027060011.25893-2-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20201028144219.GA3966314@bogus>
 <DM6PR11MB3721FA210CD596C4C64306F8DD150@DM6PR11MB3721.namprd11.prod.outlook.com>
 <CAL_Jsq+1HiYK09+piSqJz0Jo+F3XXfg0+qpKQSDL7G32c2P4Eg@mail.gmail.com>
In-Reply-To: <CAL_Jsq+1HiYK09+piSqJz0Jo+F3XXfg0+qpKQSDL7G32c2P4Eg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [14.1.225.240]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dde57809-86be-4fc4-77cb-08d87fbdf8ee
x-ms-traffictypediagnostic: DM5PR11MB1915:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB1915862FA02378044E3F2AC1DD110@DM5PR11MB1915.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /c9of6gmpg5f/eHCAOZT2NfweA7eeHLAUjumv4bkEkaXCGOyrpsvw2twh6VWUXYqfjPB6r+1VjpBS+XSX/PAyZxva2PnO43gpeSqanAiYgoAZ7ylHqQl0rqLkn/rUFP04qqpnF8Ma2B6KfY2VhG84ejbwod0lJz7omc0WSU/iWEQmE+cxX+p28jaRz2CS5qhJ+i2saLBzy9AaSoW6P7/wy/8+VNQiLHMY6E6+6kGExbh9iP51P95JNvr1X8sM+PngbiVkEt/h18A438nxtQVDRs8PADTA3PwtcwvXqIaoQoRHw8FJ3BxUKSDV+dTrHWBH7j2bz9OsGYS8bzhQrG0Ww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3721.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(396003)(39860400002)(136003)(55016002)(7696005)(33656002)(86362001)(6506007)(9686003)(53546011)(4326008)(52536014)(66556008)(6916009)(26005)(316002)(66446008)(76116006)(478600001)(66946007)(54906003)(66476007)(64756008)(5660300002)(8676002)(8936002)(186003)(83380400001)(71200400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: ojr2t4VeAH12q8tN0nP/5YJF0rXq8i2K9DLt6jNepZ3bfe3CUxwZOwfERcZYgtgTYZPZ+REeiTf0WPfKVXY9l6IwNl73+VzhAGX7T1Rhh0hupwii8LOoo2CBpxCksvWWAM81RiBbNHLfkWfOwxIbsL+JYL6Yx8Tliv3eGXTfghN3TgtgZA3EY3lMuQRDZLQMQIO5XqIFKUkdyIFQfJy6Wx6fN+6fDQHP+eLZgxBn4JVnEqYKJQaJEQI0jOZJd6IXU1Rlc9Pp86Mg9jmPj/VNDYacZTxzQ1ldkhbCgoSPeEYT175ft+kt8U0Rkoge6xTtR0qOTnBf/r+bBA4nSoIatfInaD6YNUsYq1RhUUg+fLBHBwr2qlpMexblJTjW1jD39DJQVriN6puwSESbLlZ5EDgtV3Te+oZgN5+ouCABC7WuCQDM9s1i//rOwDJCKJ72VExmMOUqcshkpF4zDMmQvHXVFy7ppJ98uKAp6yhT3wYhFPz9nodgHyGtkwYLQeeymJrvSY9v6AwXFlNnd23XCKSXGLIaHPonsn6tcXwSAg+Ve6ZwpT9N4/2RbjOkZlaEFYKST3RlyR9TKcU7ZORc1XqgBnE+g6zyRQwBhJ4v/kOUMIXkQV1PW6kiHC7ZRZgpyJ5eFUX8c1PT+c6lIYJ9cQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3721.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dde57809-86be-4fc4-77cb-08d87fbdf8ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2020 06:01:57.4199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WJ5P0YdIK5pKCLvcfjINrcXmF45cuKa6zrX0PRJXBh5/IxTlNVQF7Ge4IWe139fedEOH2Or8tIcP0IbETHhwpXClOx7QjXJJNFVWKWsgTMwQ/I/kh7f87eEFqYb6w0Ui
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1915
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgUm9iLg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJvYiBIZXJy
aW5nIDxyb2JoQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IEZyaWRheSwgT2N0b2JlciAzMCwgMjAyMCAx
MDo1NiBQTQ0KPiBUbzogV2FuIE1vaGFtYWQsIFdhbiBBaG1hZCBaYWluaWUNCj4gPHdhbi5haG1h
ZC56YWluaWUud2FuLm1vaGFtYWRAaW50ZWwuY29tPg0KPiBDYzogYmhlbGdhYXNAZ29vZ2xlLmNv
bTsgbG9yZW56by5waWVyYWxpc2lAYXJtLmNvbTsgbGludXgtDQo+IHBjaUB2Z2VyLmtlcm5lbC5v
cmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiBhbmRyaXkuc2hldmNoZW5rb0BsaW51
eC5pbnRlbC5jb207IG1ncm9zc0BsaW51eC5pbnRlbC5jb207IFJhamENCj4gU3VicmFtYW5pYW4s
IExha3NobWkgQmFpIDxsYWtzaG1pLmJhaS5yYWphLnN1YnJhbWFuaWFuQGludGVsLmNvbT4NCj4g
U3ViamVjdDogUmU6IFtQQVRDSCAxLzJdIGR0LWJpbmRpbmdzOiBQQ0k6IEFkZCBJbnRlbCBLZWVt
IEJheSBQQ0llIGNvbnRyb2xsZXINCj4gDQo+IE9uIEZyaSwgT2N0IDMwLCAyMDIwIGF0IDg6MDUg
QU0gV2FuIE1vaGFtYWQsIFdhbiBBaG1hZCBaYWluaWUNCj4gPHdhbi5haG1hZC56YWluaWUud2Fu
Lm1vaGFtYWRAaW50ZWwuY29tPiB3cm90ZToNCj4gPg0KPiA+IEhpIFJvYi4NCj4gPg0KPiA+IFRo
YW5rcyBmb3IgdGhlIHJldmlldy4NCj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gPiA+IEZyb206IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQo+ID4gPiBTZW50
OiBXZWRuZXNkYXksIE9jdG9iZXIgMjgsIDIwMjAgMTA6NDIgUE0NCj4gPiA+IFRvOiBXYW4gTW9o
YW1hZCwgV2FuIEFobWFkIFphaW5pZQ0KPiA+ID4gPHdhbi5haG1hZC56YWluaWUud2FuLm1vaGFt
YWRAaW50ZWwuY29tPg0KPiA+ID4gQ2M6IGJoZWxnYWFzQGdvb2dsZS5jb207IGxvcmVuem8ucGll
cmFsaXNpQGFybS5jb207IGxpbnV4LQ0KPiA+ID4gcGNpQHZnZXIua2VybmVsLm9yZzsgZGV2aWNl
dHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4gPiBhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRl
bC5jb207IG1ncm9zc0BsaW51eC5pbnRlbC5jb207IFJhamENCj4gPiA+IFN1YnJhbWFuaWFuLCBM
YWtzaG1pIEJhaSA8bGFrc2htaS5iYWkucmFqYS5zdWJyYW1hbmlhbkBpbnRlbC5jb20+DQo+ID4g
PiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMl0gZHQtYmluZGluZ3M6IFBDSTogQWRkIEludGVsIEtl
ZW0gQmF5IFBDSWUNCj4gPiA+IGNvbnRyb2xsZXINCj4gPiA+DQo+ID4gPiBPbiBUdWUsIE9jdCAy
NywgMjAyMCBhdCAwMjowMDoxMFBNICswODAwLCBXYW4gQWhtYWQgWmFpbmllIHdyb3RlOg0KDQou
Li4NCg0KPiA+ID4gPiArICBudW0tdmlld3BvcnQ6DQo+ID4gPiA+ICsgICAgZGVzY3JpcHRpb246
IE51bWJlciBvZiB2aWV3IHBvcnRzIGNvbmZpZ3VyZWQgaW4gaGFyZHdhcmUuDQo+ID4gPiA+ICsg
ICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDMyDQo+ID4gPiA+
ICsgICAgZGVmYXVsdDogMg0KPiA+ID4NCj4gPiA+IFByZXR0eSBzdXJlIGl0J3Mgbm90IDIgaWYg
bnVtLWliLXdpbmRvd3MgYW5kIG51bS1vYi13aW5kb3dzIGFyZSA0Lg0KPiA+DQo+ID4gQXMgcGVy
IHBjaWUtZGVzaWdud2FyZS1ob3N0LmMsIGRlZmF1bHQgdmFsdWUgaXMgMiwgaWYgaXQgaXMgbm90
IHNldC4NCj4gDQo+IFllcywgdGhhdCdzIHRydWUuDQo+IA0KPiA+IE15IGV4YW1wbGUgYW5kIHRo
ZSBEVCBpbiBteSBzeXN0ZW0gaXMgNC4NCj4gPiBJIHdpbGwgZml4IGluIHYyLCBieSB1c2luZyBj
b25zdDogNC4NCj4gPiBTaG91bGQgSSBkcm9wIGRlZmF1bHQ/DQo+IA0KPiBZZXMuDQo+IA0KPiBC
VFcsIEknbSBnb2luZyB0byBtYWtlIGFsbCAzIHByb3BlcnRpZXMgb2Jzb2xldGUuIEknbSB3b3Jr
aW5nIG9uIGEgcGF0Y2ggdG8NCj4gZGV0ZWN0IGFsbCB0aGlzLiBJdCdzIHByZXR0eSBzdHJhaWdo
dC1mb3J3YXJkLCBqdXN0IHNlZSBob3cgbWFueSByZWdpc3RlcnMgYXJlDQo+IHdyaXRhYmxlLiBU
aGUgV0lQIHBhdGNoIGlzIG9uIG15IGZvci1rZXJuZWxjaSBicmFuY2guDQoNCkkgd2lsbCB0YWtl
IG5vdGUgb24gdGhpcy4NCg0KSSBhbHNvIHRha2UgYSBsb29rIGludG8gZm9yLWtlcm5lbGNpIGJy
YW5jaC4gSSB3aWxsIHNwZW5kIHNvbWUgdGltZSB0byB0cnkgaXQNCm91dCB3aXRoIG15IHBhdGNo
Lg0KDQo+IA0KPiBUaGUgcHJvYmxlbSB3aXRoIHRoZXNlIHByb3BlcnRpZXMgaXMgdGhleSBhcmUg
ZGVmaW5lZCBhcyBSQyBhbmQgRVAgc3BlY2lmaWMsDQo+IGJ1dCB0aGV5IGFyZSByZWFsbHkgZml4
ZWQgaC93IGNvbmZpZyBpbmRlcGVuZGVudCBvZiB0aGUgbW9kZS4gQW5kIG51bS0NCj4gdmlld3Bv
cnQgaXMgaW5jb21wbGV0ZSBiZWNhdXNlIHRoZSBpbmJvdW5kIGFuZCBvdXRib3VuZCBzaXplcyBh
cmUNCj4gaW5kZXBlbmRlbnQuIFRoZSBkcml2ZXIganVzdCBjdXJyZW50bHkgZG9lc24ndCB1c2Ug
aW5ib3VuZCB3aW5kb3dzIGZvciBSQw0KPiBtb2RlLiBBbHNvLCB0aGUgZHJpdmVyIGNsYWltcyB0
aGVyZSBjYW4gYmUgdXAgdG8gMjU2IHdpbmRvd3MsIGJ1dCBJJ20gbm90DQo+IHJlYWxseSBzdXJl
IHRoYXQncyByaWdodC4gVGhlcmUncyAyIHBsYXRmb3JtcyB1cHN0cmVhbSAobHMxMDg4YSBhbmQg
bHMyMDh4YSkNCj4gY2xhaW1pbmcgMjU2IHdpbmRvd3MgaW4gRFQsIGJ1dCB0ZXN0aW5nIHdpdGgg
dGhlIGRldGVjdGlvbiBjb2RlIGluZGljYXRlcw0KPiB0aGV5IG9ubHkgaGF2ZSAxNiBJQiBhbmQg
MTYgT0Igd2luZG93cy4gUGVyaGFwcyBpZiB5b3UgaGF2ZSB0aGUgRFdDDQo+IG1hbnVhbCB5b3Ug
Y291bGQgY29uZmlybSB3aGF0J3MgcG9zc2libGUuDQoNClVuZm9ydHVuYXRlbHksIEkgZG9uJ3Qg
aGF2ZSBkZXRhaWxzIG9uIERXQyBtYW51YWwuIEFzIGZvciBLZWVtIEJheSwNCmZyb20gdGhlIGlu
Zm9ybWF0aW9uIGluIGl0cyBkYXRhYm9vaywgaXQgaXMgc3ludGhlc2l6ZWQgd2l0aCA4IElCIGFu
ZCA4IE9CDQp3aW5kb3dzLiBUaGUgdmFsdWVzIHRoYXQgSSB1c2VkIGZvciBEVCBpcyBiYXNlZCBv
biByZWNvbW1lbmRhdGlvbiBmcm9tDQpvdXIgYm9vdCBmaXJtd2FyZSB0ZWFtLg0KDQo+IA0KPiBS
b2INCg0KQmVzdCByZWdhcmRzLA0KWmFpbmllDQo=
