Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5B8B2CCB45
	for <lists+linux-pci@lfdr.de>; Thu,  3 Dec 2020 01:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbgLCAw1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Dec 2020 19:52:27 -0500
Received: from mga01.intel.com ([192.55.52.88]:44059 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbgLCAw0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Dec 2020 19:52:26 -0500
IronPort-SDR: 1rjeoFrrTbuXb2da6Ygw4tOY4EFrgRSzkJawMcU0pOwUx9MhD8FAA84j3ZYsuIPMIXTi69mwPp
 hFcZ4WH6syVQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9823"; a="191335504"
X-IronPort-AV: E=Sophos;i="5.78,388,1599548400"; 
   d="scan'208";a="191335504"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 16:51:45 -0800
IronPort-SDR: pKuMVCQr4/h8TA+Q0yffNtqeBz4+/p8jZH0MSqUbaLFkrlwxRZNoB2DDnnD2CNSK4zaWRtyVaQ
 6caGughIRkbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,388,1599548400"; 
   d="scan'208";a="373357539"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 02 Dec 2020 16:51:45 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 2 Dec 2020 16:51:45 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 2 Dec 2020 16:51:45 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 2 Dec 2020 16:51:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kFSEbPHOwnZvwp6TOgc0SIKhGMD6Lvsqs5TKuJiCclzrxXEtxULBD1UjsezmK9TWixUbBWF5oBTiuc6GV9AULoM6TEa5SvQBSi/hbu0+Zwh9AwYKgeLMwLhlCsADKVon5SzPN/mbhFkpXus2UuS6nA0NyTr+5EtRyv7jv9zsLWNCYZGZjGMNMDhe3Zcc10St5l8XOqTsedyNFj6U1tUr8ep1Xyo81DohwmrWdbGHB2hQB573gu0i0nyjWuXb3WhoQqk0/JjTeqsR6EGnSec+H3QWPzbOywlDBDkzvgT65aI9AN7FY+x8rwXiQVAY0ah1j9cWSBwqBofKHFNoILMLPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynYVIhReo1MGgvUxTQ8rmVHN4CrDq2QGxoaMiabJ/X8=;
 b=Vrj1lEC72/NCxPsgliNoJpS5PksZ7990zSAQppsZ0VRat5qeoCfO9EmySBetfuR51nXlYyBDtXyHmJvEGqAp0BvYlZ1upXsxj0Ioc1l0+NKeeo4RtStb8shlxycN2HzYLA/xnOOypRUZwoHaiB8pTW8rPfIo234l9eGzTZlNlhPhWGikngIgYC9ldm5PON3UcfYNWOuDXF+Z6GVEltkmnr0gBtEET7gqfbxRi2alh26ntXJ4goC5ArtKmIAUMA+eW/rMQ1E//SbduCqS+WFN0dTi9EL/91NkR/OSziKXohN9XMWLgAKm+Hk9dsenskP/GBucEf43f21ILOTNAle2fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynYVIhReo1MGgvUxTQ8rmVHN4CrDq2QGxoaMiabJ/X8=;
 b=MnJr9jPpHcnNIhYcZYfDO7VwazJYz7SX5QgtlO/R1SSXrQtsj5MFQM35wIh7FwEEcoXICZEJo/kftNrCvxnkUSls20EkXYTQ0t2O/0TlVwDtHiNuOiuVR/EdEpajZt+ZyZTskOq6GLjGn40jHqSIZ8H2gISXUkobaWlH7Vp0AC4=
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com
 (2603:10b6:405:50::16) by BN6PR11MB1714.namprd11.prod.outlook.com
 (2603:10b6:404:47::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Thu, 3 Dec
 2020 00:51:40 +0000
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::bcaa:2da8:af5e:4b51]) by BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::bcaa:2da8:af5e:4b51%11]) with mapi id 15.20.3611.031; Thu, 3 Dec 2020
 00:51:40 +0000
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
Subject: Re: [PATCH v12 12/15] PCI/RCEC: Add RCiEP's linked RCEC to AER/ERR
Thread-Topic: [PATCH v12 12/15] PCI/RCEC: Add RCiEP's linked RCEC to AER/ERR
Thread-Index: AQHWv5rN3FuVUIpfDEeVuS6r9tww6ankiuyAgAASyYA=
Date:   Thu, 3 Dec 2020 00:51:40 +0000
Message-ID: <6E339ABE-2F55-486B-833A-BDDAF27A114D@intel.com>
References: <20201202234425.GA1486740@bjorn-Precision-5520>
In-Reply-To: <20201202234425.GA1486740@bjorn-Precision-5520>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.20.0.2.21)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [24.20.148.49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 087870bd-81f5-4153-36ff-08d8972598a2
x-ms-traffictypediagnostic: BN6PR11MB1714:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB17148D0B4B00D69F7C7BD4DCB2F20@BN6PR11MB1714.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1THnD+958AvvkX9oPPtgB+oLQYoRi+A0p006Kmp4Dfk39WgUzLu8KdqFX0gqb520b0KY8RO2VMmeLsa3zIwecpRljYoSBypnzcWOVWuWA6UFTUoakTyPktztbga8swSZ3GP35h1PTTdEwC6PZ854r8EvLaRkW2+eLwwei0/ms4O/MiS3gJdZcDBWnXYW4I5xyiyoYEM5ajVxFxe2zrCVOWP/IQx15HbNIGcI3XXiigN0se93RvjErGwHoeUbQTu5injjnsaxbsgDH6VzNzVxvD0z8kNllJFC6Q3npBJVCqAUg3kNnPbmZmGpHNKAyqrDnB+CTFW3csfw7Ep8wKVMhmr3sJJNg5IhK6+kgfQrYrcmwY2AfW6Gq3a9WeqmVnnlkl73zhqwsUhh8CNmjxvXVYYQQDUa615rbgSBvqOEbrJSBUHypii/8pt4OBNj7TzTZ0roXnxeff/UQ17YUmFd6g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1101MB2243.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(376002)(396003)(39860400002)(136003)(316002)(2906002)(71200400001)(966005)(6512007)(6506007)(53546011)(478600001)(8676002)(33656002)(6486002)(2616005)(8936002)(83380400001)(54906003)(6916009)(5660300002)(66446008)(64756008)(66946007)(91956017)(66556008)(66476007)(26005)(36756003)(186003)(86362001)(76116006)(4326008)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ZXF1SjllbytBVEk0V1YralhVdWRvL0I5ZnlxOHhIVHM5UzN3UUFKRFRhcDhX?=
 =?utf-8?B?S1BnTGFvdjhEclBXQkdMK0NaRHFwd25vYzVNNTI2NWJlM2d2VFlXMXBVMjJQ?=
 =?utf-8?B?YzBMazNDUExOUzVvUFo5eG5RUlR2Q0VoZ2hiREZHd0Rnd2JmUW14QTkzUER6?=
 =?utf-8?B?RDJNR2pOeGl3dTcvWTUyMksxdlhBSmtzekduU3djOW1XblNPOE5rd29Bbi9E?=
 =?utf-8?B?ZWtEYnJtL09IUDFPL0ZvNWRsOTVtK3hucVNCcmtIeE4xUjkyWTF6ak50NG9F?=
 =?utf-8?B?bk5DSFZoTGU2ZEJicGd4Z3Rta3BuaTg5YW8wNE1jbHZ5WElRVHcwR3BHS1dU?=
 =?utf-8?B?by9uZ0VobTkwMi94RjdZWDBVYk9TdWlvUkY2SmRnS1gwNTRnZlplM1dibk5P?=
 =?utf-8?B?NndpbHdUZkxlVTVRclNyN0F1bXlYM1pDVEdXZURWdWo4QjZxeGNObWlnREJz?=
 =?utf-8?B?SW1NTUFzYzVrNkhXelB4bndJVjRoNjEwSzNtZ2xpSHd1V1dMNjZiangrTU1k?=
 =?utf-8?B?L2dGNlBDY3ZmZmROamlQRVIyTFl3a2VHQzVhYmJ6UHFSdkx4QUlzZDRjMFNL?=
 =?utf-8?B?YUI0eC9BU3F0VjRqVThBVG85OGpnU3YxSjh2dFlnWEtHNlNReHB6QU1lWUtG?=
 =?utf-8?B?TnJRcVZhQWRGckgrbVQzSGw3WFBMVW1ZTlB1dGlIb1ZTZVN2Q3cxSkNoR3FW?=
 =?utf-8?B?MUpnM2l1b2JZMVVmUEd0Wlk1Qnd3K3QzN0JJaWVQdGRUVmJndEx4MkZGU0t6?=
 =?utf-8?B?MVpleEJadUdKVHVWMGpIS1I5RnJMUllXcXM5NmxyeW1wSmZDakMxdWpqMFNS?=
 =?utf-8?B?Wmh0aVU5bXA4R0xaMUpIVkdhekNWTlp4OTdXTnVoelZuSlhzWU9LVzI3Zld0?=
 =?utf-8?B?V0VrWE9nSkVyM1l2ZGIwaVFjTHBVS2hGMXBHWERrcHI4QWkwZ1drMU5QZUkr?=
 =?utf-8?B?ZGYyR1ZuN1p3MTU0S0gwa0twV25QSXdwSHFBN0hPM25kZjNZY3VQU05Hd3F2?=
 =?utf-8?B?RkpxSFZZU2wwZm54Z2pQTDBFSkFrdkk1S0ZZMG4xYnBsR0J2am92eEdwdnRJ?=
 =?utf-8?B?clZmSUJRaXhOMFhSa2JTK01BLzhCM2g0SmFQelhnWUtSeUwvUURYM3ZQSDYy?=
 =?utf-8?B?K1AzMWlZZnU3Um54bTM0MTBoNXRZbHR4WlVVQm1ScnMzcFFTUC9LVXI0SEQ5?=
 =?utf-8?B?N0lSQlNwbFo5V24xMUFqMlRBZk5yR0JtNmZQMXp1QVM1ZjFReGJldFoxa09o?=
 =?utf-8?B?T2pFMlRReTVxOHR6QXdWOUVBU3VqL3RiQ2dBZmRnUERndUhybFpPZm9JQXBv?=
 =?utf-8?Q?CKKlVa2VXsJfnwyPMm7KS7thD0V8iyArU9?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6775B7D2DC0FE44A97A6CC52BEC830F0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1101MB2243.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 087870bd-81f5-4153-36ff-08d8972598a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2020 00:51:40.1337
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sOQJQTYpZhcX8RHPiXDeIx/vd2StbXr3W9r1P81OaxOZS3/CKsB7ynVJVkPpa2EOYfFZbFUOpXtV02UKL2XSwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1714
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQoNCj4gT24gRGVjIDIsIDIwMjAsIGF0IDM6NDQgUE0sIEJqb3JuIEhlbGdhYXMgPGhlbGdhYXNA
a2VybmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBGcmksIE5vdiAyMCwgMjAyMCBhdCAwNDoxMDoz
M1BNIC0wODAwLCBTZWFuIFYgS2VsbGV5IHdyb3RlOg0KPj4gRnJvbTogUWl1eHUgWmh1byA8cWl1
eHUuemh1b0BpbnRlbC5jb20+DQo+PiANCj4+IFdoZW4gYXR0ZW1wdGluZyBlcnJvciByZWNvdmVy
eSBmb3IgYW4gUkNpRVAgYXNzb2NpYXRlZCB3aXRoIGFuIFJDRUMgZGV2aWNlLA0KPj4gdGhlcmUg
bmVlZHMgdG8gYmUgYSB3YXkgdG8gdXBkYXRlIHRoZSBSb290IEVycm9yIFN0YXR1cywgdGhlIFVu
Y29ycmVjdGFibGUNCj4+IEVycm9yIFN0YXR1cyBhbmQgdGhlIFVuY29ycmVjdGFibGUgRXJyb3Ig
U2V2ZXJpdHkgb2YgdGhlIHBhcmVudCBSQ0VDLiAgSW4NCj4+IHNvbWUgbm9uLW5hdGl2ZSBjYXNl
cyBpbiB3aGljaCB0aGVyZSBpcyBubyBPUy12aXNpYmxlIGRldmljZSBhc3NvY2lhdGVkDQo+PiB3
aXRoIHRoZSBSQ2lFUCwgdGhlcmUgaXMgbm90aGluZyB0byBhY3QgdXBvbiBhcyB0aGUgZmlybXdh
cmUgaXMgYWN0aW5nDQo+PiBiZWZvcmUgdGhlIE9TLg0KPj4gDQo+PiBBZGQgaGFuZGxpbmcgZm9y
IHRoZSBsaW5rZWQgUkNFQyBpbiBBRVIvRVJSIHdoaWxlIHRha2luZyBpbnRvIGFjY291bnQNCj4+
IG5vbi1uYXRpdmUgY2FzZXMuDQo+PiANCj4+IENvLWRldmVsb3BlZC1ieTogU2VhbiBWIEtlbGxl
eSA8c2Vhbi52LmtlbGxleUBpbnRlbC5jb20+DQo+PiBMaW5rOiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9yLzIwMjAxMDAyMTg0NzM1LjEyMjkyMjAtMTItc2VhbnZrLmRldkBvcmVnb250cmFja3Mu
b3JnDQo+PiBTaWduZWQtb2ZmLWJ5OiBTZWFuIFYgS2VsbGV5IDxzZWFuLnYua2VsbGV5QGludGVs
LmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFFpdXh1IFpodW8gPHFpdXh1LnpodW9AaW50ZWwuY29t
Pg0KPj4gU2lnbmVkLW9mZi1ieTogQmpvcm4gSGVsZ2FhcyA8YmhlbGdhYXNAZ29vZ2xlLmNvbT4N
Cj4+IFJldmlld2VkLWJ5OiBKb25hdGhhbiBDYW1lcm9uIDxKb25hdGhhbi5DYW1lcm9uQGh1YXdl
aS5jb20+DQo+PiAtLS0NCj4+IGRyaXZlcnMvcGNpL3BjaWUvYWVyLmMgfCA0NiArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0NCj4+IGRyaXZlcnMvcGNpL3BjaWUvZXJy
LmMgfCAyMCArKysrKysrKystLS0tLS0tLS0NCj4+IDIgZmlsZXMgY2hhbmdlZCwgNDQgaW5zZXJ0
aW9ucygrKSwgMjIgZGVsZXRpb25zKC0pDQo+PiANCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Bj
aS9wY2llL2Flci5jIGIvZHJpdmVycy9wY2kvcGNpZS9hZXIuYw0KPj4gaW5kZXggMGJhMGI0N2Fl
NzUxLi41MTM4OWE2ZWU0Y2EgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL3BjaS9wY2llL2Flci5j
DQo+PiArKysgYi9kcml2ZXJzL3BjaS9wY2llL2Flci5jDQo+PiBAQCAtMTM1OCwyOSArMTM1OCw1
MSBAQCBzdGF0aWMgaW50IGFlcl9wcm9iZShzdHJ1Y3QgcGNpZV9kZXZpY2UgKmRldikNCj4+ICAq
Lw0KPj4gc3RhdGljIHBjaV9lcnNfcmVzdWx0X3QgYWVyX3Jvb3RfcmVzZXQoc3RydWN0IHBjaV9k
ZXYgKmRldikNCj4+IHsNCj4+IC0JaW50IGFlciA9IGRldi0+YWVyX2NhcDsNCj4+ICsJaW50IHR5
cGUgPSBwY2lfcGNpZV90eXBlKGRldik7DQo+PiArCXN0cnVjdCBwY2lfZGV2ICpyb290Ow0KPj4g
KwlpbnQgYWVyID0gMDsNCj4+ICsJaW50IHJjID0gMDsNCj4+IAl1MzIgcmVnMzI7DQo+PiAtCWlu
dCByYzsNCj4+IA0KPj4gLQlpZiAocGNpZV9hZXJfaXNfbmF0aXZlKGRldikpIHsNCj4+ICsJaWYg
KHR5cGUgPT0gUENJX0VYUF9UWVBFX1JDX0VORCkNCj4+ICsJCS8qDQo+PiArCQkgKiBUaGUgcmVz
ZXQgc2hvdWxkIG9ubHkgY2xlYXIgdGhlIFJvb3QgRXJyb3IgU3RhdHVzDQo+PiArCQkgKiBvZiB0
aGUgUkNFQy4gT25seSBwZXJmb3JtIHRoaXMgZm9yIHRoZQ0KPj4gKwkJICogbmF0aXZlIGNhc2Us
IGkuZS4sIGFuIFJDRUMgaXMgcHJlc2VudC4NCj4+ICsJCSAqLw0KPj4gKwkJcm9vdCA9IGRldi0+
cmNlYzsNCj4+ICsJZWxzZQ0KPj4gKwkJcm9vdCA9IGRldjsNCj4+ICsNCj4+ICsJaWYgKHJvb3Qp
DQo+PiArCQlhZXIgPSBkZXYtPmFlcl9jYXA7DQo+PiArDQo+PiArCWlmICgoYWVyKSAmJiBwY2ll
X2Flcl9pc19uYXRpdmUoZGV2KSkgew0KPj4gCQkvKiBEaXNhYmxlIFJvb3QncyBpbnRlcnJ1cHQg
aW4gcmVzcG9uc2UgdG8gZXJyb3IgbWVzc2FnZXMgKi8NCj4+IC0JCXBjaV9yZWFkX2NvbmZpZ19k
d29yZChkZXYsIGFlciArIFBDSV9FUlJfUk9PVF9DT01NQU5ELCAmcmVnMzIpOw0KPj4gKwkJcGNp
X3JlYWRfY29uZmlnX2R3b3JkKHJvb3QsIGFlciArIFBDSV9FUlJfUk9PVF9DT01NQU5ELCAmcmVn
MzIpOw0KPj4gCQlyZWczMiAmPSB+Uk9PVF9QT1JUX0lOVFJfT05fTUVTR19NQVNLOw0KPj4gLQkJ
cGNpX3dyaXRlX2NvbmZpZ19kd29yZChkZXYsIGFlciArIFBDSV9FUlJfUk9PVF9DT01NQU5ELCBy
ZWczMik7DQo+PiArCQlwY2lfd3JpdGVfY29uZmlnX2R3b3JkKHJvb3QsIGFlciArIFBDSV9FUlJf
Uk9PVF9DT01NQU5ELCByZWczMik7DQo+PiAJfQ0KPj4gDQo+PiAtCXJjID0gcGNpX2J1c19lcnJv
cl9yZXNldChkZXYpOw0KPj4gLQlwY2lfaW5mbyhkZXYsICJSb290IFBvcnQgbGluayBoYXMgYmVl
biByZXNldCAoJWQpXG4iLCByYyk7DQo+PiArCWlmICh0eXBlID09IFBDSV9FWFBfVFlQRV9SQ19F
QyB8fCB0eXBlID09IFBDSV9FWFBfVFlQRV9SQ19FTkQpIHsNCj4+ICsJCWlmIChwY2llX2hhc19m
bHIoZGV2KSkgew0KPj4gKwkJCXJjID0gcGNpZV9mbHIoZGV2KTsNCj4+ICsJCQlwY2lfaW5mbyhk
ZXYsICJoYXMgYmVlbiByZXNldCAoJWQpXG4iLCByYyk7DQo+IA0KPiBNYXliZToNCj4gDQo+ICAr
ICAgICAgICAgICAgIH0gZWxzZSB7DQo+ICArICAgICAgICAgICAgICAgICAgICAgcmMgPSAtRU5P
VFRZOw0KPiAgKyAgICAgICAgICAgICAgICAgICAgIHBjaV9pbmZvKGRldiwgIm5vdCByZXNldCAo
bm8gRkxSIHN1cHBvcnQpXG4iKTsNCj4gDQo+IE9yIGRvIHdlIHdhbnQgdG8gcHJldGVuZCB0aGUg
ZGV2aWNlIHdhcyByZXNldCBhbmQgcmV0dXJuDQo+IFBDSV9FUlNfUkVTVUxUX1JFQ09WRVJFRD8N
Cg0KV2UgYXJlIGN1cnJlbnRseSBkb2luZyB0aGUgbGF0dGVyIG5vdyB3aXRoIHRoZSBkZWZhdWx0
IG9mIHJjID0gMCBhYm92ZSBhbmQgc28gIEnigJltIG5vdCBzdXJlIHRoZSBleHRyYSBkZXRhaWwg
aGVyZSBvbiB0aGUgYWJzZW5jZSBvZiBGTFIgc3VwcG9ydCBpcyBvZiB2YWx1ZS4NCg0KDQo+IA0K
Pj4gKwl9IGVsc2Ugew0KPj4gKwkJcmMgPSBwY2lfYnVzX2Vycm9yX3Jlc2V0KGRldik7DQo+PiAr
CQlwY2lfaW5mbyhkZXYsICJSb290IFBvcnQgbGluayBoYXMgYmVlbiByZXNldCAoJWQpXG4iLCBy
Yyk7DQo+PiArCX0NCj4+IA0KPj4gLQlpZiAocGNpZV9hZXJfaXNfbmF0aXZlKGRldikpIHsNCj4+
ICsJaWYgKChhZXIpICYmIHBjaWVfYWVyX2lzX25hdGl2ZShkZXYpKSB7DQo+PiAJCS8qIENsZWFy
IFJvb3QgRXJyb3IgU3RhdHVzICovDQo+PiAtCQlwY2lfcmVhZF9jb25maWdfZHdvcmQoZGV2LCBh
ZXIgKyBQQ0lfRVJSX1JPT1RfU1RBVFVTLCAmcmVnMzIpOw0KPj4gLQkJcGNpX3dyaXRlX2NvbmZp
Z19kd29yZChkZXYsIGFlciArIFBDSV9FUlJfUk9PVF9TVEFUVVMsIHJlZzMyKTsNCj4+ICsJCXBj
aV9yZWFkX2NvbmZpZ19kd29yZChyb290LCBhZXIgKyBQQ0lfRVJSX1JPT1RfU1RBVFVTLCAmcmVn
MzIpOw0KPj4gKwkJcGNpX3dyaXRlX2NvbmZpZ19kd29yZChyb290LCBhZXIgKyBQQ0lfRVJSX1JP
T1RfU1RBVFVTLCByZWczMik7DQo+PiANCj4+IAkJLyogRW5hYmxlIFJvb3QgUG9ydCdzIGludGVy
cnVwdCBpbiByZXNwb25zZSB0byBlcnJvciBtZXNzYWdlcyAqLw0KPj4gLQkJcGNpX3JlYWRfY29u
ZmlnX2R3b3JkKGRldiwgYWVyICsgUENJX0VSUl9ST09UX0NPTU1BTkQsICZyZWczMik7DQo+PiAr
CQlwY2lfcmVhZF9jb25maWdfZHdvcmQocm9vdCwgYWVyICsgUENJX0VSUl9ST09UX0NPTU1BTkQs
ICZyZWczMik7DQo+PiAJCXJlZzMyIHw9IFJPT1RfUE9SVF9JTlRSX09OX01FU0dfTUFTSzsNCj4+
IC0JCXBjaV93cml0ZV9jb25maWdfZHdvcmQoZGV2LCBhZXIgKyBQQ0lfRVJSX1JPT1RfQ09NTUFO
RCwgcmVnMzIpOw0KPj4gKwkJcGNpX3dyaXRlX2NvbmZpZ19kd29yZChyb290LCBhZXIgKyBQQ0lf
RVJSX1JPT1RfQ09NTUFORCwgcmVnMzIpOw0KPj4gCX0NCj4+IA0KPj4gCXJldHVybiByYyA/IFBD
SV9FUlNfUkVTVUxUX0RJU0NPTk5FQ1QgOiBQQ0lfRVJTX1JFU1VMVF9SRUNPVkVSRUQ7DQo+PiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvcGNpZS9lcnIuYyBiL2RyaXZlcnMvcGNpL3BjaWUvZXJy
LmMNCj4+IGluZGV4IDc4ODNjOTc5MTU2Mi4uY2JjNWFiZmU3NjdiIDEwMDY0NA0KPj4gLS0tIGEv
ZHJpdmVycy9wY2kvcGNpZS9lcnIuYw0KPj4gKysrIGIvZHJpdmVycy9wY2kvcGNpZS9lcnIuYw0K
Pj4gQEAgLTE0OCwxMCArMTQ4LDEwIEBAIHN0YXRpYyBpbnQgcmVwb3J0X3Jlc3VtZShzdHJ1Y3Qg
cGNpX2RldiAqZGV2LCB2b2lkICpkYXRhKQ0KPj4gDQo+PiAvKioNCj4+ICAqIHBjaV93YWxrX2Jy
aWRnZSAtIHdhbGsgYnJpZGdlcyBwb3RlbnRpYWxseSBBRVIgYWZmZWN0ZWQNCj4+IC0gKiBAYnJp
ZGdlOglicmlkZ2Ugd2hpY2ggbWF5IGJlIGEgUG9ydCwgYW4gUkNFQyB3aXRoIGFzc29jaWF0ZWQg
UkNpRVBzLA0KPj4gLSAqCQlvciBhbiBSQ2lFUCBhc3NvY2lhdGVkIHdpdGggYW4gUkNFQw0KPj4g
LSAqIEBjYjoJCWNhbGxiYWNrIHRvIGJlIGNhbGxlZCBmb3IgZWFjaCBkZXZpY2UgZm91bmQNCj4+
IC0gKiBAdXNlcmRhdGE6CWFyYml0cmFyeSBwb2ludGVyIHRvIGJlIHBhc3NlZCB0byBjYWxsYmFj
aw0KPj4gKyAqIEBicmlkZ2UgICBicmlkZ2Ugd2hpY2ggbWF5IGJlIGFuIFJDRUMgd2l0aCBhc3Nv
Y2lhdGVkIFJDaUVQcywNCj4+ICsgKiAgICAgICAgICAgb3IgYSBQb3J0Lg0KPj4gKyAqIEBjYiAg
ICAgICBjYWxsYmFjayB0byBiZSBjYWxsZWQgZm9yIGVhY2ggZGV2aWNlIGZvdW5kDQo+PiArICog
QHVzZXJkYXRhIGFyYml0cmFyeSBwb2ludGVyIHRvIGJlIHBhc3NlZCB0byBjYWxsYmFjay4NCj4+
ICAqDQo+PiAgKiBJZiB0aGUgZGV2aWNlIHByb3ZpZGVkIGlzIGEgYnJpZGdlLCB3YWxrIHRoZSBz
dWJvcmRpbmF0ZSBidXMsIGluY2x1ZGluZw0KPj4gICogYW55IGJyaWRnZWQgZGV2aWNlcyBvbiBi
dXNlcyB1bmRlciB0aGlzIGJ1cy4gIENhbGwgdGhlIHByb3ZpZGVkIGNhbGxiYWNrDQo+PiBAQCAt
MTY0LDggKzE2NCwxNCBAQCBzdGF0aWMgdm9pZCBwY2lfd2Fsa19icmlkZ2Uoc3RydWN0IHBjaV9k
ZXYgKmJyaWRnZSwNCj4+IAkJCSAgICBpbnQgKCpjYikoc3RydWN0IHBjaV9kZXYgKiwgdm9pZCAq
KSwNCj4+IAkJCSAgICB2b2lkICp1c2VyZGF0YSkNCj4+IHsNCj4+ICsJLyoNCj4+ICsJICogSW4g
YSBub24tbmF0aXZlIGNhc2Ugd2hlcmUgdGhlcmUgaXMgbm8gT1MtdmlzaWJsZSByZXBvcnRpbmcN
Cj4+ICsJICogZGV2aWNlIHRoZSBicmlkZ2Ugd2lsbCBiZSBOVUxMLCBpLmUuLCBubyBSQ0VDLCBu
byBEb3duc3RyZWFtIFBvcnQuDQo+IA0KPiBJIGRvbid0IHF1aXRlIHVuZGVyc3RhbmQgdGhpcyBj
b21tZW50LiAgSSBzZWUgdGhhdCBpbiB0aGUgbm9uLW5hdGl2ZQ0KPiBjYXNlLCB0aGUgcmVwb3J0
aW5nIGRldmljZSBtYXkgbm90IGJlIE9TLXZpc2libGUuICBCdXQgSSBkb24ndA0KPiB1bmRlcnN0
YW5kIHdoeSB0aGUgY29tbWVudCBpcyAqaGVyZSouDQo+IA0KPiBJZiAiYnJpZGdlIiBjYW4gYmUg
TlVMTCBoZXJlLCB3ZSBzaG91bGQgdGVzdCB0aGF0IGJlZm9yZSBkZXJlZmVyZW5jaW5nDQo+ICJi
cmlkZ2UtPnN1Ym9yZGluYXRlIi4NCg0KV3JvbmdseSB3b3JkZWQuICBUaGUgc3Vib3JkaW5hdGUg
bWF5IGJlIE5VTEwgb3IgdGhlIGFzc29jaWF0ZWQgUkNFQyBtYXkgYmUgTlVMTCwgbm90IHRoZSDi
gJxicmlkZ2XigJ0uDQpIb3dldmVyLCBwZXIgYmVsb3csIHdlIHNob3VsZCBub3QgYmUgdHJ5aW5n
IHRvIGNhbGwgcmVwb3J0X2Zyb3plbl9kZXRlY3RlZCgpLCByZXBvcnRfbW1pb19lbmFibGVkKCkg
dmlhDQp0aGUgYXNzb2NpYXRlZCBSQ0VD4oCZcyBkcml2ZXIsIGJ1dCByYXRoZXIgdGhlIENCIGZv
ciB0aGUgUkNpRVAgaXRzZWxmLg0KDQpHb2luZyBiYWNrIHRvIHRoaXMgY29udmVyc2F0aW9uLA0K
DQpodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1wY2kvMjAyMDEwMTYxNzIyMTAuR0E4NjE2
OEBiam9ybi1QcmVjaXNpb24tNTUyMC8NCg0KIkxvb2tzIGxpa2UgKnRoaXMqIGlzIHRoZSBwYXRj
aCB3aGVyZSB0aGUgIm5vIHN1Ym9yZGluYXRlIGJ1cyIgY2FzZQ0KYmVjb21lcyBwb3NzaWJsZT8g
IElmIHlvdSBhZ3JlZSwgSSBjYW4ganVzdCBtb3ZlIHRoZSB0ZXN0IGhlcmUsIG5vDQpuZWVkIHRv
IHJlcG9zdC7igJ0NCg0KSXQgaXMgYWN0dWFsbHkgdGhlIGNhc2Ugd2UgYXJlIG9ubHkgZGVhbGlu
ZyB3aXRoIHRoZSBhYnNlbmNlIG9mIGEgc3Vib3JkaW5hdGUgYnVzLg0KDQo+IA0KPj4gCWlmIChi
cmlkZ2UtPnN1Ym9yZGluYXRlKQ0KPj4gCQlwY2lfd2Fsa19idXMoYnJpZGdlLT5zdWJvcmRpbmF0
ZSwgY2IsIHVzZXJkYXRhKTsNCj4+ICsJZWxzZSBpZiAoYnJpZGdlLT5yY2VjKQ0KPj4gKwkJY2Io
YnJpZGdlLT5yY2VjLCB1c2VyZGF0YSk7DQo+IA0KPiBBbmQgSSBkb24ndCB1bmRlcnN0YW5kIHdo
YXQncyBnb2luZyBvbiBoZXJlLiAgSW4gdGhpcyBjYXNlLCBJICp0aGluayoNCj4gImJyaWRnZSIg
aXMgYW4gUkNpRVAgYW5kICJicmlkZ2UtPnJjZWMiIGlzIHRoZSByZWxhdGVkIFJDRUMsIHNvIGl0
DQo+IGxvb2tzIGxpa2Ugd2UnbGwgY2FsbCByZXBvcnRfZnJvemVuX2RldGVjdGVkKCksIHJlcG9y
dF9tbWlvX2VuYWJsZWQoKSwNCj4gZXRjIGZvciB0aGUgUkNFQyBkcml2ZXIuICBJIHdvdWxkIHRo
aW5rIHdlJ2Qgd2FudCB0aGUgUkNpRVAgZHJpdmVyLg0KDQpJbmRlZWQsIHRoZSBicmlkZ2UtPnJj
ZWMgaGVyZSBpcyB0aGUgZGV2LT5yY2VjIGluIHdoaWNoIHRoZSBkZXYgaXMgdGhlIFJDaUVQLg0K
DQpBbmQgd2UgZG9u4oCZdCBuZWVkIHRoYXQgY29uZGl0aW9uYWwgaGVyZSwgaXQgc2hvdWxkIGp1
c3QgaGl0IHRoZSBkZXZpY2UgZHJpdmVy4oCZcyByb3V0aW5lcy4NCg0KVGhpcyBpcyBhbiB1bmZv
cnR1bmF0ZSBzaWRlIGVmZmVjdCBvZiB0aGUgUkNpRVAgYmVpbmcgc3Vib3JkaW5hdGUgdG8gdGhl
IFJDRUMgYnV0IGZvcg0KIHB1cnBvc2VzIG9mIGxpbmtpbmcsIGl0IGdpdmVzIHRoZSBpbXByZXNz
aW9uIG9mIHRoZSBvdGhlciB3YXkgYXJvdW5kLg0KDQoNCj4gDQo+IFNvcnJ5IGlmIEknbSBtaXNz
aW5nIHRoZSBvYnZpb3VzLg0KDQpBY3R1YWxseSB5b3VyIG9ic2VydmF0aW9ucyBhcmUgb24gcG9p
bnQuDQoNClRoYW5rcywNCg0KU2Vhbg0KDQo+IA0KPj4gCWVsc2UNCj4+IAkJY2IoYnJpZGdlLCB1
c2VyZGF0YSk7DQo+PiB9DQo+PiBAQCAtMTk0LDEyICsyMDAsNiBAQCBwY2lfZXJzX3Jlc3VsdF90
IHBjaWVfZG9fcmVjb3Zlcnkoc3RydWN0IHBjaV9kZXYgKmRldiwNCj4+IAlwY2lfZGJnKGJyaWRn
ZSwgImJyb2FkY2FzdCBlcnJvcl9kZXRlY3RlZCBtZXNzYWdlXG4iKTsNCj4+IAlpZiAoc3RhdGUg
PT0gcGNpX2NoYW5uZWxfaW9fZnJvemVuKSB7DQo+PiAJCXBjaV93YWxrX2JyaWRnZShicmlkZ2Us
IHJlcG9ydF9mcm96ZW5fZGV0ZWN0ZWQsICZzdGF0dXMpOw0KPj4gLQkJaWYgKHR5cGUgPT0gUENJ
X0VYUF9UWVBFX1JDX0VORCkgew0KPj4gLQkJCXBjaV93YXJuKGRldiwgInN1Ym9yZGluYXRlIGRl
dmljZSByZXNldCBub3QgcG9zc2libGUgZm9yIFJDaUVQXG4iKTsNCj4+IC0JCQlzdGF0dXMgPSBQ
Q0lfRVJTX1JFU1VMVF9OT05FOw0KPj4gLQkJCWdvdG8gZmFpbGVkOw0KPj4gLQkJfQ0KPj4gLQ0K
Pj4gCQlzdGF0dXMgPSByZXNldF9zdWJvcmRpbmF0ZXMoYnJpZGdlKTsNCj4+IAkJaWYgKHN0YXR1
cyAhPSBQQ0lfRVJTX1JFU1VMVF9SRUNPVkVSRUQpIHsNCj4+IAkJCXBjaV93YXJuKGJyaWRnZSwg
InN1Ym9yZGluYXRlIGRldmljZSByZXNldCBmYWlsZWRcbiIpOw0KPj4gLS0gDQo+PiAyLjI5LjIN
Cj4+IA0KDQo=
