Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86498EDAB
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2019 02:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729310AbfD3A05 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Apr 2019 20:26:57 -0400
Received: from mail-eopbgr60057.outbound.protection.outlook.com ([40.107.6.57]:2436
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729214AbfD3A05 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Apr 2019 20:26:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnsRza46SUrTQW6/mLKeLE4hV8fFPcf7xPC5TdZgn4g=;
 b=KLM+OxKh9kl1UgXis26ihSHOgr0yZCYTjAjgAGefEU1rqVHbUaCGJ/1szzOr79twprX9rRI963i04ZxEPXTFdSWW7zF7ON6Mw2cAkei0/7fpxIC/rlLuCtdT8USBs6U0pnezSpNZDAAkbDwr0VcEuVSTclhFHblCFNFLw1YowUY=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB5400.eurprd04.prod.outlook.com (20.178.95.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Tue, 30 Apr 2019 00:26:40 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::f9db:ed86:614e:460]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::f9db:ed86:614e:460%4]) with mapi id 15.20.1835.018; Tue, 30 Apr 2019
 00:26:40 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: RE: [EXT] Re: [PATCHv5 4/6] PCI: mobiveil: Add PCIe Gen4 RC driver
 for NXP Layerscape SoCs
Thread-Topic: [EXT] Re: [PATCHv5 4/6] PCI: mobiveil: Add PCIe Gen4 RC driver
 for NXP Layerscape SoCs
Thread-Index: AQHU8RV9MHdz0yaFRUW6+R/81XqWJaY4mY2AgBtajEA=
Date:   Tue, 30 Apr 2019 00:26:40 +0000
Message-ID: <AM6PR04MB57817E6C29731F6A96C3CAAB843A0@AM6PR04MB5781.eurprd04.prod.outlook.com>
References: <20190412095332.41370-1-Zhiqiang.Hou@nxp.com>
 <20190412095332.41370-5-Zhiqiang.Hou@nxp.com>
 <CAK8P3a1rkBP4Hzy+=j8Ds_MoZU0K1_kh5YA0-ogOAG9TZ5fDNQ@mail.gmail.com>
In-Reply-To: <CAK8P3a1rkBP4Hzy+=j8Ds_MoZU0K1_kh5YA0-ogOAG9TZ5fDNQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 044ae0f9-14b9-4c01-ba68-08d6cd0283fa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM6PR04MB5400;
x-ms-traffictypediagnostic: AM6PR04MB5400:
x-microsoft-antispam-prvs: <AM6PR04MB5400662784BF61163BB01D24843A0@AM6PR04MB5400.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 00235A1EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6029001)(396003)(39860400002)(366004)(346002)(376002)(136003)(13464003)(199004)(189003)(66446008)(66476007)(64756008)(66556008)(2906002)(73956011)(81166006)(102836004)(86362001)(229853002)(54906003)(14454004)(81156014)(66946007)(4326008)(53546011)(52536014)(11346002)(476003)(8676002)(76116006)(26005)(8936002)(316002)(6436002)(478600001)(99286004)(446003)(486006)(25786009)(76176011)(6506007)(6246003)(186003)(71200400001)(7736002)(256004)(74316002)(7696005)(55016002)(53936002)(5660300002)(5024004)(9686003)(3846002)(6116002)(14444005)(305945005)(68736007)(66066001)(33656002)(7416002)(6916009)(97736004)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5400;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MOoUCvak8272YM7zjPvpZgWZL1Fh039he+c4HVnW3cbUkQhJzMC4DI11ST4u/ijBTd2nXVS1k/EjrfSZTJxnlt52gsJfezjC9NW8pgY0bbpRj/VIUEP0N7v/Z4LfH63HsOGCtGo5YkBIMm+/U7GnKckWyAyZyMXGkzBr9zRevoO4BZcWLR424rGpZYWnpev50RFZyEeXG1KmIf6dMg1BLzDKOqAlv/mTkpvQoekoeUw196As8TVMPk4syIVT4pOuLEEO0PYrYQbRVsPsxaKM+1ywIiIMVNnzJUlKRL+11eu314YuuUOM5ygR2JzrMqMQpz5EihfHXvlL050N6D6NLceeR9mooFXhOwF6N7Q5s0LtmPXMVlaDoRIKUi0i+I7uM+uS18cIpLJbGzfekf4r54BJenRt917uf3bp8m30Zsg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 044ae0f9-14b9-4c01-ba68-08d6cd0283fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2019 00:26:40.6088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5400
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgQXJuZCwNCg0KVGhhbmtzIGEgbG90IGZvciB5b3VyIGNvbW1lbnRzIQ0KDQo+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFybmQgQmVyZ21hbm4gW21haWx0bzphcm5kQGFy
bmRiLmRlXQ0KPiBTZW50OiAyMDE55bm0NOaciDEy5pelIDIyOjQyDQo+IFRvOiBaLnEuIEhvdSA8
emhpcWlhbmcuaG91QG54cC5jb20+DQo+IENjOiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBs
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBiaGVsZ2Fhc0Bnb29n
bGUuY29tOyByb2JoK2R0QGtlcm5lbC5vcmc7IG1hcmsucnV0bGFuZEBhcm0uY29tOw0KPiBsLnN1
YnJhaG1hbnlhQG1vYml2ZWlsLmNvLmluOyBzaGF3bmd1b0BrZXJuZWwub3JnOyBMZW8gTGkNCj4g
PGxlb3lhbmcubGlAbnhwLmNvbT47IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207DQo+IGNhdGFs
aW4ubWFyaW5hc0Bhcm0uY29tOyB3aWxsLmRlYWNvbkBhcm0uY29tOyBNaW5na2FpIEh1DQo+IDxt
aW5na2FpLmh1QG54cC5jb20+OyBNLmguIExpYW4gPG1pbmdodWFuLmxpYW5AbnhwLmNvbT47IFhp
YW93ZWkgQmFvDQo+IDx4aWFvd2VpLmJhb0BueHAuY29tPg0KPiBTdWJqZWN0OiBbRVhUXSBSZTog
W1BBVENIdjUgNC82XSBQQ0k6IG1vYml2ZWlsOiBBZGQgUENJZSBHZW40IFJDIGRyaXZlciBmb3IN
Cj4gTlhQIExheWVyc2NhcGUgU29Dcw0KPiANCj4gV0FSTklORzogVGhpcyBlbWFpbCB3YXMgY3Jl
YXRlZCBvdXRzaWRlIG9mIE5YUC4gRE8gTk9UIENMSUNLIGxpbmtzIG9yDQo+IGF0dGFjaG1lbnRz
IHVubGVzcyB5b3UgcmVjb2duaXplIHRoZSBzZW5kZXIgYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMg
c2FmZS4NCj4gDQo+IA0KPiANCj4gPiArICAgICAgIHBjaWUgPSBkZXZtX2t6YWxsb2MoZGV2LCBz
aXplb2YoKnBjaWUpLCBHRlBfS0VSTkVMKTsNCj4gPiArICAgICAgIGlmICghcGNpZSkNCj4gPiAr
ICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07DQo+ID4gKw0KPiA+ICsgICAgICAgbXZfcGNp
ID0gZGV2bV9remFsbG9jKGRldiwgc2l6ZW9mKCptdl9wY2kpLCBHRlBfS0VSTkVMKTsNCj4gPiAr
ICAgICAgIGlmICghbXZfcGNpKQ0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsN
Cj4gPiArDQo+IA0KPiBKdXN0IGZvbGQgdGhlIHR3byBzdHJ1Y3R1cmVzIGludG8gb25lLCBhbmQg
dXNlIHBjaV9hbGxvY19ob3N0X2JyaWRnZSgpIHRvDQo+IGFsbG9jYXRlIGV2ZXJ5dGhpbmcuDQoN
Ckl0J3MgYSBnb29kIHN1Z2dlc3Rpb24sIHdpbGwgY2hhbmdlIGluIHY2Lg0KDQpUaGFua3MsDQpa
aGlxaWFuZw0K
