Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D151936B21
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2019 06:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725769AbfFFEtt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jun 2019 00:49:49 -0400
Received: from mail-eopbgr780085.outbound.protection.outlook.com ([40.107.78.85]:36672
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725766AbfFFEtt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Jun 2019 00:49:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GA2eHGpAu1es7HA7iiZ5inAY8Lav75+DHNtIRuBG44g=;
 b=FOOZmwcYzi1amDF2hN1yb3uHyLONXTxevKeM9GmXSK0P79kAZJg04hUD6mjH8wpxIjZ9kZ1msGdXNP9dUj+bDoXPZ7RYqZwb9wf3za2HWwVVk+e5eraSchehSpBMLakGW3K9iA7sQIUJNLfzyaKXs6qED6Yk4K9Umd+cHbpGJSA=
Received: from CH2PR02MB6453.namprd02.prod.outlook.com (52.132.228.24) by
 CH2PR02MB6232.namprd02.prod.outlook.com (52.132.230.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.22; Thu, 6 Jun 2019 04:49:45 +0000
Received: from CH2PR02MB6453.namprd02.prod.outlook.com
 ([fe80::8121:11ae:9021:ba9e]) by CH2PR02MB6453.namprd02.prod.outlook.com
 ([fe80::8121:11ae:9021:ba9e%7]) with mapi id 15.20.1965.011; Thu, 6 Jun 2019
 04:49:45 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ravikiran Gummaluri <rgummal@xilinx.com>
Subject: RE: [PATCH v3] PCI: xilinx-nwl: Fix Multi MSI data programming
Thread-Topic: [PATCH v3] PCI: xilinx-nwl: Fix Multi MSI data programming
Thread-Index: AQHVFhtj/xw1FyY99Ue19JMf95x7KaaFalwAgAQ7/wCABHIyEA==
Date:   Thu, 6 Jun 2019 04:49:45 +0000
Message-ID: <CH2PR02MB6453666163FAF313746EC9C4A5170@CH2PR02MB6453.namprd02.prod.outlook.com>
References: <1559133469-11981-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <20190531160956.GB9356@redmoon>
 <5de53585-e90f-77d2-bd96-025e1b39a573@arm.com>
In-Reply-To: <5de53585-e90f-77d2-bd96-025e1b39a573@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bharatku@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 75c1fe68-9e72-44dc-6b2b-08d6ea3a65e3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:CH2PR02MB6232;
x-ms-traffictypediagnostic: CH2PR02MB6232:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <CH2PR02MB62327FB63EB7A9C6E315083CA5170@CH2PR02MB6232.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00603B7EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(396003)(39850400004)(366004)(199004)(189003)(6246003)(5660300002)(73956011)(54906003)(4326008)(2906002)(229853002)(107886003)(33656002)(25786009)(76116006)(66446008)(66946007)(66556008)(256004)(446003)(99286004)(71190400001)(8676002)(316002)(68736007)(476003)(66476007)(53936002)(64756008)(71200400001)(52536014)(110136005)(81166006)(81156014)(14454004)(8936002)(14444005)(6436002)(86362001)(486006)(6506007)(66066001)(3846002)(7736002)(55016002)(76176011)(102836004)(305945005)(53546011)(74316002)(9686003)(478600001)(26005)(6116002)(2501003)(11346002)(186003)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR02MB6232;H:CH2PR02MB6453.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vvVqAG3Q0HxvmHlVH1M+x1cPg6RZKXrlhKaYlRO9Zd7S+2lUpEr4/j9bC4+jphxgIW99vuPXTIRFISjjnmW69aD+V09U8mzgTFp0BfZc06WOD29pubAryTV2q/dViQSzoKVoS1nCP/jZKb4iUGFrOyWq1DgecHitcL256c+ibKtIJt3iBezSNdQKaAfCoBIhTYr2pbI6lUDjWBy9o/sDDSP2/xpFwDgM5n4NK75Ru0kxOInYxPiRkI0z6Geqa7ejaghjl6ksCbhvnHsH2luU+C+2MxVHTwfDyUuY7EOWkP5Emqbx/EoqAw+Z8lsXMNWBnmNjN10vIrZdmne5xjGIXGrJrN1NBgpqGnN+U7k23pv4H2BdpkBHvSfMwISpA5+IvqOtbnnf48klJX40hMoXhnp3Mn8FMIFgUPnbOoKqrcM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75c1fe68-9e72-44dc-6b2b-08d6ea3a65e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2019 04:49:45.5970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bharatku@xilinx.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6232
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiBPbiAzMS8wNS8yMDE5IDE3OjA5LCBMb3JlbnpvIFBpZXJhbGlzaSB3cm90ZToNCj4gPiBbK01h
cmNdDQo+ID4NCj4gPiBPbiBXZWQsIE1heSAyOSwgMjAxOSBhdCAwNjowNzo0OVBNICswNTMwLCBC
aGFyYXQgS3VtYXIgR29nYWRhIHdyb3RlOg0KPiA+PiBUaGUgY3VycmVudCBNdWx0aSBNU0kgZGF0
YSBwcm9ncmFtbWluZyBmYWlscyBpZiBtdWx0aXBsZSBlbmQgcG9pbnRzDQo+ID4+IHJlcXVlc3Rp
bmcgTVNJIGFuZCBtdWx0aSBNU0kgYXJlIGNvbm5lY3RlZCB3aXRoIHN3aXRjaCwgaS5lIHRoZQ0K
PiA+PiBjdXJyZW50IG11bHRpIE1TSSBkYXRhIGJlaW5nIGdpdmVuIGlzIG5vdCBjb25zaWRlcmlu
ZyB0aGUgbnVtYmVyIG9mDQo+ID4+IHZlY3RvcnMgYmVpbmcgcmVxdWVzdGVkIGluIGNhc2Ugb2Yg
bXVsdGkgTVNJLg0KPiA+PiBFeDogVHdvIEVQJ3MgY29ubmVjdGVkIHZpYSBzd2l0Y2gsIEVQMSBy
ZXF1ZXN0aW5nIHNpbmdsZSBNU0kgZmlyc3QsDQo+ID4+IEVQMiByZXF1ZXN0aW5nIE11bHRpIE1T
SSBvZiBjb3VudCBmb3VyLiBUaGUgY3VycmVudCBjb2RlIGdpdmVzIE1TSQ0KPiA+PiBkYXRhIDB4
MCB0byBFUDEgYW5kIDB4MSB0byBFUDIsIGJ1dCBFUDIgY2FuIG1vZGlmeSBsb3dlciB0d28gYml0
cyBkdWUNCj4gPj4gdG8gd2hpY2ggRVAyIGFsc28gc2VuZHMgaW50ZXJydXB0IHdpdGggTVNJIGRh
dGEgMHgwIHdoaWNoIHJlc3VsdHMgaW4NCj4gPj4gYWx3YXlzIGludm9raW5nIHZpcnEgb2YgRVAx
IGR1ZSB0byB3aGljaCBFUDIgTVNJIGludGVycnVwdCBuZXZlciBnZXRzDQo+ID4+IGhhbmRsZWQu
DQo+ID4NCj4gPiBJZiB0aGlzIGlzIGEgcHJvYmxlbSBpdCBpcyBub3QgdGhlIG9ubHkgZHJpdmVy
IHdoZXJlIGl0IHNob3VsZCBiZQ0KPiA+IGZpeGVkIGl0IHNlZW1zLiBDQydlZCBNYXJjIGluIGNh
c2UgSSBoYXZlIG1pc3NlZCBzb21ldGhpbmcgaW4gcmVsYXRpb24NCj4gPiB0byBNU0kgSVJRcyBi
dXQgQUZBSVUgaXQgbG9va3MgbGlrZSBIVyBpcyBhbGxvd2VkIHRvIHRvZ2dsZWQgYml0cw0KPiA+
IChhY2NvcmRpbmcgdG8gYml0c1s2OjRdIGluIE1lc3NhZ2UgQ29udHJvbCBmb3IgTVNJKSBpbiB0
aGUgTVNJIGRhdGEsDQo+ID4gZ2l2ZW4gdGhhdCB0aGUgZGF0YSB3cml0dGVuIGlzIHRoZSBod2ly
cSBudW1iZXIgKGluIHRoaXMgc3BlY2lmaWMgTVNJDQo+ID4gY29udHJvbGxlcikgaXQgb3VnaHQg
dG8gYmUgZml4ZWQuDQo+IA0KPiBZZWFoLCBpdCBsb29rcyBsaWtlIGEgbnVtYmVyIG9mIE1TSSBj
b250cm9sbGVycyBjb3VsZCBiZSBxdWl0ZSBicm9rZW4gaW4gdGhpcw0KPiBwYXJ0aWN1bGFyIGFy
ZWEuDQo+IA0KPiA+DQo+ID4gVGhlIGNvbW1pdCBsb2cgYW5kIHBhdGNoIHNob3VsZCBiZSByZXdy
aXR0ZW4gKEkgd2lsbCBkbyB0aGF0KSBidXQNCj4gPiBmaXJzdCBJIHdvdWxkIGxpa2UgdG8gdW5k
ZXJzdGFuZCBpZiB0aGVyZSBhcmUgbW9yZSBkcml2ZXJzIHRvIGJlDQo+ID4gdXBkYXRlZC4NCj4g
Pg0KPiA+IA0KSGkgTG9yZW56byBhbmQgTWFyYywgdGhhbmtzIGZvciB5b3VyIHRpbWUuDQpNYXJj
LCBJJ20geWV0IHRvIHRlc3QgdGhlIGJlbG93IHN1Z2dlc3RlZCBzb2x1dGlvbiwNCkdJQyB2Mm0g
YW5kIEdJQyB2MyBzdXBwb3J0cyBtdWx0aSBNU0ksIGRvIHdlIHNlZSBhYm92ZSBpc3N1ZSBpbiB0
aGVzZSBNU0kgY29udHJvbGxlcnMgPw0KDQpSZWdhcmRzLA0KQmhhcmF0DQo+ID4NCj4gPj4gRml4
IE11bHRpIE1TSSBkYXRhIHByb2dyYW1taW5nIHdpdGggcmVxdWlyZWQgYWxpZ25tZW50IGJ5IHVz
aW5nDQo+ID4+IG51bWJlciBvZiB2ZWN0b3JzIGJlaW5nIHJlcXVlc3RlZC4NCj4gPj4NCj4gPj4g
Rml4ZXM6IGFiNTk3ZDM1ZWYxMSAoIlBDSTogeGlsaW54LW53bDogQWRkIHN1cHBvcnQgZm9yIFhp
bGlueCBOV0wNCj4gPj4gUENJZSBIb3N0IENvbnRyb2xsZXIiKQ0KPiA+PiBTaWduZWQtb2ZmLWJ5
OiBCaGFyYXQgS3VtYXIgR29nYWRhIDxiaGFyYXQua3VtYXIuZ29nYWRhQHhpbGlueC5jb20+DQo+
ID4+IC0tLQ0KPiA+PiBWMzoNCj4gPj4gIC0gQWRkZWQgZXhhbXBsZSBkZXNjcmlwdGlvbiBvZiB0
aGUgaXNzdWUNCj4gPj4gLS0tDQo+ID4+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUteGls
aW54LW53bC5jIHwgMTEgKysrKysrKysrKy0NCj4gPj4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4+DQo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3BjaS9jb250cm9sbGVyL3BjaWUteGlsaW54LW53bC5jDQo+ID4+IGIvZHJpdmVycy9wY2kvY29u
dHJvbGxlci9wY2llLXhpbGlueC1ud2wuYw0KPiA+PiBpbmRleCA4MTUzOGQ3Li44ZWZjYjhhIDEw
MDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUteGlsaW54LW53bC5j
DQo+ID4+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS14aWxpbngtbndsLmMNCj4g
Pj4gQEAgLTQ4Myw3ICs0ODMsMTYgQEAgc3RhdGljIGludCBud2xfaXJxX2RvbWFpbl9hbGxvYyhz
dHJ1Y3QNCj4gaXJxX2RvbWFpbiAqZG9tYWluLCB1bnNpZ25lZCBpbnQgdmlycSwNCj4gPj4gIAlp
bnQgaTsNCj4gPj4NCj4gPj4gIAltdXRleF9sb2NrKCZtc2ktPmxvY2spOw0KPiA+PiAtCWJpdCA9
IGJpdG1hcF9maW5kX25leHRfemVyb19hcmVhKG1zaS0+Yml0bWFwLCBJTlRfUENJX01TSV9OUiwg
MCwNCj4gPj4gKw0KPiA+PiArCS8qDQo+ID4+ICsJICogTXVsdGkgTVNJIGNvdW50IGlzIHJlcXVl
c3RlZCBpbiBwb3dlciBvZiB0d28NCj4gPj4gKwkgKiBDaGVjayBpZiBtdWx0aSBtc2kgaXMgcmVx
dWVzdGVkDQo+ID4+ICsJICovDQo+ID4+ICsJaWYgKG5yX2lycXMgJSAyID09IDApDQo+ID4+ICsJ
CWJpdCA9IGJpdG1hcF9maW5kX25leHRfemVyb19hcmVhKG1zaS0+Yml0bWFwLA0KPiBJTlRfUENJ
X01TSV9OUiwgMCwNCj4gPj4gKwkJCQkJIG5yX2lycXMsIG5yX2lycXMgLSAxKTsNCj4gPj4gKwll
bHNlDQo+ID4+ICsJCWJpdCA9IGJpdG1hcF9maW5kX25leHRfemVyb19hcmVhKG1zaS0+Yml0bWFw
LA0KPiBJTlRfUENJX01TSV9OUiwgMCwNCj4gPj4gIAkJCQkJIG5yX2lycXMsIDApOw0KPiA+PiAg
CWlmIChiaXQgPj0gSU5UX1BDSV9NU0lfTlIpIHsNCj4gPj4gIAkJbXV0ZXhfdW5sb2NrKCZtc2kt
PmxvY2spOw0KPiA+PiAtLQ0KPiA+PiAyLjcuNA0KPiA+Pg0KPiANCj4gVGhpcyBkb2Vzbid0IGxv
b2sgbGlrZSB0aGUgYmVzdCBmaXguIFRoZSBvbmx5IGNhc2Ugd2hlcmUgbnJfaXJxcyBpcyBub3QN
Cj4gc2V0IHRvIDEgaXMgd2hlbiB1c2luZyBNdWx0aS1NU0ksIHNvIHRoZSAnJSAyJyBjYXNlIGFj
dHVhbGx5IGNvdmVycyBhbGwNCj4gY2FzZXMuIE5vdywgYW5kIGluIHRoZSBpbnRlcmVzdCBvZiBj
b25zaXN0ZW5jeSwgb3RoZXIgZHJpdmVycyB1c2UgYQ0KPiBjb25zdHJ1Y3Qgc3VjaCBhczoNCj4g
DQo+IG9mZnNldCA9IGJpdG1hcF9maW5kX2ZyZWVfcmVnaW9uKGJpdG1hcCwgYml0bWFwX3NpemUs
DQo+IAkJCQkgZ2V0X2NvdW50X29yZGVyKG5yX2lycXMpKTsNCj4gDQo+IHdoaWNoIGhhcyB0aGUg
YWR2YW50YWdlIG9mIGRlYWxpbmcgd2l0aCB0aGUgYml0bWFwIHNldHRpbmcgYXMgd2VsbC4NCj4g
DQo+IEknZCBzdWdnZXN0IHNvbWV0aGluZyBsaWtlIHRoaXMgKGNvbXBsZXRlbHkgdW50ZXN0ZWQp
Og0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS14aWxpbngt
bndsLmMNCj4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUteGlsaW54LW53bC5jDQo+IGlu
ZGV4IDNiMDMxZjAwYTk0YS4uOGI5YjU4OTA5ZTdjIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3Bj
aS9jb250cm9sbGVyL3BjaWUteGlsaW54LW53bC5jDQo+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvcGNpZS14aWxpbngtbndsLmMNCj4gQEAgLTQ4MiwxNSArNDgyLDEzIEBAIHN0YXRpYyBp
bnQgbndsX2lycV9kb21haW5fYWxsb2Moc3RydWN0DQo+IGlycV9kb21haW4gKmRvbWFpbiwgdW5z
aWduZWQgaW50IHZpcnEsDQo+ICAJaW50IGk7DQo+IA0KPiAgCW11dGV4X2xvY2soJm1zaS0+bG9j
ayk7DQo+IC0JYml0ID0gYml0bWFwX2ZpbmRfbmV4dF96ZXJvX2FyZWEobXNpLT5iaXRtYXAsIElO
VF9QQ0lfTVNJX05SLCAwLA0KPiAtCQkJCQkgbnJfaXJxcywgMCk7DQo+IC0JaWYgKGJpdCA+PSBJ
TlRfUENJX01TSV9OUikgew0KPiArCWJpdCA9IGJpdG1hcF9maW5kX2ZyZWVfcmVnaW9uKG1zaS0+
Yml0bWFwLCBJTlRfUENJX01TSV9OUiwNCj4gKwkJCQkgICAgICBnZXRfY291bnRfb3JkZXIobnJf
aXJxcykpOw0KPiArCWlmIChiaXQgPCAwKSB7DQo+ICAJCW11dGV4X3VubG9jaygmbXNpLT5sb2Nr
KTsNCj4gIAkJcmV0dXJuIC1FTk9TUEM7DQo+ICAJfQ0KPiANCj4gLQliaXRtYXBfc2V0KG1zaS0+
Yml0bWFwLCBiaXQsIG5yX2lycXMpOw0KPiAtDQo+ICAJZm9yIChpID0gMDsgaSA8IG5yX2lycXM7
IGkrKykgew0KPiAgCQlpcnFfZG9tYWluX3NldF9pbmZvKGRvbWFpbiwgdmlycSArIGksIGJpdCAr
IGksICZud2xfaXJxX2NoaXAsDQo+ICAJCQkJZG9tYWluLT5ob3N0X2RhdGEsIGhhbmRsZV9zaW1w
bGVfaXJxLA0KPiBAQCAtNTA4LDcgKzUwNiw3IEBAIHN0YXRpYyB2b2lkIG53bF9pcnFfZG9tYWlu
X2ZyZWUoc3RydWN0IGlycV9kb21haW4NCj4gKmRvbWFpbiwgdW5zaWduZWQgaW50IHZpcnEsDQo+
ICAJc3RydWN0IG53bF9tc2kgKm1zaSA9ICZwY2llLT5tc2k7DQo+IA0KPiAgCW11dGV4X2xvY2so
Jm1zaS0+bG9jayk7DQo+IC0JYml0bWFwX2NsZWFyKG1zaS0+Yml0bWFwLCBkYXRhLT5od2lycSwg
bnJfaXJxcyk7DQo+ICsJYml0bWFwX3JlbGVhc2VfcmVnaW9uKG1zaS0+Yml0bWFwLCBkYXRhLT5o
d2lycSwNCj4gZ2V0X2NvdW50X29yZGVyKG5yX2lycXMpKTsNCj4gIAltdXRleF91bmxvY2soJm1z
aS0+bG9jayk7DQo+ICB9DQo+IA0KDQo=
