Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADF8C5C81D
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2019 06:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725789AbfGBEYF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Jul 2019 00:24:05 -0400
Received: from mail-eopbgr690103.outbound.protection.outlook.com ([40.107.69.103]:55173
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725780AbfGBEYF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Jul 2019 00:24:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uwy.onmicrosoft.com;
 s=selector1-uwy-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVT8WKMN/8PWHEJUuwx9PWGzRmzZ3bUEOc+u1nThTgQ=;
 b=D6EglCVJtRGIovvYrWscNeuX5K8f4e4hln92bZCsycPB/NZv7wF5VbkKjwGEG8sEw5NLJ1Ut45DGKd7AI/ckox2DYwyDSxG231l3JWqjgqz61ZpZFrjIhJIkHsMFyj6p+L0vHUPJ95LYgJju7OLKlz2iwnvdVmDyYDBIob3FDN4=
Received: from DM6PR05MB5259.namprd05.prod.outlook.com (20.177.223.223) by
 DM6PR05MB6346.namprd05.prod.outlook.com (20.178.224.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.14; Tue, 2 Jul 2019 04:24:01 +0000
Received: from DM6PR05MB5259.namprd05.prod.outlook.com
 ([fe80::95c9:c4b0:38da:1d83]) by DM6PR05MB5259.namprd05.prod.outlook.com
 ([fe80::95c9:c4b0:38da:1d83%3]) with mapi id 15.20.2052.010; Tue, 2 Jul 2019
 04:24:01 +0000
From:   "Robert R. Howell" <RHowell@uwyo.edu>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
CC:     Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans De Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 1/5] PM: ACPI/PCI: Resume all devices during
 hibernation
Thread-Topic: [PATCH v2 1/5] PM: ACPI/PCI: Resume all devices during
 hibernation
Thread-Index: AQHVL/v28vh16XJ3m0qx4puqb8Ydeqa2vBmA
Date:   Tue, 2 Jul 2019 04:24:01 +0000
Message-ID: <848e9c1b-7775-58bf-ac12-a8618b526876@uwyo.edu>
References: <4976412.ihyb9sT5jY@kreacher> <6191578.xJk2HsE5MX@kreacher>
In-Reply-To: <6191578.xJk2HsE5MX@kreacher>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
x-originating-ip: [208.45.12.32]
x-clientproxiedby: SN4PR0401CA0033.namprd04.prod.outlook.com
 (2603:10b6:803:2a::19) To DM6PR05MB5259.namprd05.prod.outlook.com
 (2603:10b6:5:7f::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=RHowell@uwyo.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6339e9d4-8340-449a-8a62-08d6fea51bf8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM6PR05MB6346;
x-ms-traffictypediagnostic: DM6PR05MB6346:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DM6PR05MB634642DB878CCD13E132E995D3F80@DM6PR05MB6346.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 008663486A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(136003)(366004)(39850400004)(346002)(376002)(396003)(189003)(199004)(7736002)(99286004)(386003)(68736007)(71190400001)(71200400001)(6506007)(6116002)(64756008)(66556008)(14454004)(66476007)(8936002)(478600001)(305945005)(52116002)(4326008)(81166006)(76176011)(64126003)(3846002)(186003)(66446008)(36756003)(102836004)(786003)(75432002)(66946007)(966005)(26005)(58126008)(31696002)(6486002)(31686004)(486006)(54906003)(81156014)(110136005)(6436002)(229853002)(6306002)(256004)(476003)(6246003)(2616005)(53936002)(25786009)(53546011)(86362001)(66066001)(65806001)(14444005)(6512007)(65956001)(72206003)(5660300002)(65826007)(80792005)(88552002)(316002)(73956011)(8676002)(446003)(2906002)(11346002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR05MB6346;H:DM6PR05MB5259.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: uwyo.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 67W75RFvffcHoimGd+1janQ59zcxekVGIllxUnHBcEJVwdEgx6TfzQKziWpPvYrGIAG3Aj/XK9dnkyt8znWnECOzm0956F5+CVPuXIfiuCy96GaeNWiN+U0OW+buRDBL+/ZtDeMHK+APv9fD2QbTEtxDFKFE4M+KwlHm7iJiC2NbLURv2IZPC778XniVsbSlihKBEwTNJfG/784y+XB+x0AdsgVEMTVIgsR8RlaNuke63cvHgMenD7bBq4g1m8+6HCZxk48VLIYWrBL5m664mseCp3kpYIsOQ9w6UuINn2VfYjStZ6ZPEn0hZJXbKeIHcqZ3f72nIIkhs9409MTGFRLWG/7ane2cxquwxyiRPkuGq5mBzFOdMtWsWa9wPczeUQq1B1kw0Tp7aF2236XnpDwdzvT7MXYX5TqELelkvSA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <88B73A52E40DD64FA4630658FA6B968E@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: uwyo.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6339e9d4-8340-449a-8a62-08d6fea51bf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2019 04:24:01.3734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f9cdd7ad-825d-4601-8e9c-a325e02d52da
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RHowell@uwyo.edu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB6346
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gNy8xLzE5IDQ6NDQgQU0sIFJhZmFlbCBKLiBXeXNvY2tpIHdyb3RlOg0KPiBGcm9tOiBSYWZh
ZWwgSi4gV3lzb2NraSA8cmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb20+DQo+IA0KPiBCb3RoIHRo
ZSBQQ0kgYnVzIHR5cGUgYW5kIHRoZSBBQ1BJIFBNIGRvbWFpbiBhdm9pZCByZXN1bWluZw0KPiBy
dW50aW1lLXN1c3BlbmRlZCBkZXZpY2VzIHdpdGggRFBNX0ZMQUdfU01BUlRfU1VTUEVORCBzZXQg
ZHVyaW5nDQo+IGhpYmVybmF0aW9uIChiZWZvcmUgY3JlYXRpbmcgdGhlIHNuYXBzaG90IGltYWdl
IG9mIHN5c3RlbSBtZW1vcnkpLA0KPiBidXQgdGhhdCB0dXJucyBvdXQgdG8gYmUgYSBtaXN0YWtl
LiAgSXQgbGVhZHMgdG8gZnVuY3Rpb25hbCBpc3N1ZXMNCj4gYW5kIGFkZHMgY29tcGxleGl0eSB0
aGF0J3MgaGFyZCB0byBqdXN0aWZ5Lg0KPiANCj4gRm9yIHRoaXMgcmVhc29uLCByZXN1bWUgYWxs
IHJ1bnRpbWUtc3VzcGVuZGVkIFBDSSBkZXZpY2VzIGFuZCBhbGwNCj4gZGV2aWNlcyBpbiB0aGUg
QUNQSSBQTSBkb21haW5zIGJlZm9yZSBjcmVhdGluZyBhIHNuYXBzaG90IGltYWdlIG9mDQo+IHN5
c3RlbSBtZW1vcnkgZHVyaW5nIGhpYmVybmF0aW9uLg0KPiANCj4gRml4ZXM6IDA1MDg3MzYwZmQ3
YSAoQUNQSSAvIFBNOiBUYWtlIFNNQVJUX1NVU1BFTkQgZHJpdmVyIGZsYWcgaW50byBhY2NvdW50
KQ0KPiBGaXhlczogYzRiNjUxNTdhZWVmIChQQ0kgLyBQTTogVGFrZSBTTUFSVF9TVVNQRU5EIGRy
aXZlciBmbGFnIGludG8gYWNjb3VudCkNCj4gTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bGludXgtYWNwaS85MTdkNDM5OS0yZTIyLTY3YjEtOWQ1NC04MDg1NjFmOTA4M2ZAdXd5by5lZHUv
VC8jbWFmMDY1ZmU2ZTQ5NzRmMmE5ZDc5ZjMzMmFiOTlkZmFiYTYzNWY2NGMNCj4gUmVwb3J0ZWQt
Ynk6IFJvYmVydCBSLiBIb3dlbGwgPFJIb3dlbGxAdXd5by5lZHU+DQo+IFRlc3RlZC1ieTogUm9i
ZXJ0IFIuIEhvd2VsbCA8Ukhvd2VsbEB1d3lvLmVkdT4NCj4gU2lnbmVkLW9mZi1ieTogUmFmYWVs
IEouIFd5c29ja2kgPHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29tPg0KPiAtLS0NCj4gDQo+IC0+
IHYyOiBObyBjaGFuZ2VzLg0KDQpJJ3ZlIHRlc3RlZCB5b3VyIHYyIHBhdGNoIHNldCBvbiBteSBB
U1VTIFQxMDBUQSwgYXBwbHlpbmcganVzdCB0aG9zZSA1IHBhdGNoZXMgdG8gdGhlIA0KNS4yLXJj
NyBrZXJuZWwsIGFuZCB0aGV5IGRvIGZpeCB0aGUgaGliZXJuYXRpb24gcHJvYmxlbS4gIFRoZSBp
MmNfZGVzaWdud2FyZSANCnRpbWVvdXQgZXJyb3JzIGFyZSBub3cgZ29uZSBhbmQgc291bmQgZG9l
cyBub3cgd29yayBhZnRlciByZXN1bWUgZnJvbSBib3RoIA0Kc3VzcGVuZCBhbmQgaGliZXJuYXRl
LiAgDQoNCkFzIGJlZm9yZSBJIHN0aWxsIHNlZSB0aGUgImkyY19kZXNpZ253YXJlIDgwODYwRjQx
OjAwOiBUcmFuc2ZlciB3aGlsZSBzdXNwZW5kZWQiIGVycm9yIA0Kb24gdGhlIGZpcnN0IHJlc3Vt
ZSBmcm9tIGVpdGhlciBzdXNwZW5kIG9yIGhpYmVybmF0ZSwgYnV0IGFsc28gYXMgYmVmb3JlIHRo
YXQgDQpwYXJ0aWN1bGFyIGVycm9yIGRvZXNuJ3Qgc2VlbSB0byBjYXVzZSBhIHBlcnNpc3RlbnQg
cHJvYmxlbSBhbmQgdGhlIHN5c3RlbSB3b3JrcyANCm5vcm1hbGx5IGFmdGVyIHRoZSByZXN1bWUu
DQoNCkJvYiBIb3dlbGwNCg==
