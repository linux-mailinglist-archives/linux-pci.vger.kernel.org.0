Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C65E1F4C01
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jun 2020 06:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725844AbgFJEHl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Jun 2020 00:07:41 -0400
Received: from mail-eopbgr10064.outbound.protection.outlook.com ([40.107.1.64]:64143
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725270AbgFJEHk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Jun 2020 00:07:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i2TrnHAxtOx8IG/N8XwINtwrlKsgsnDueutPpvptfT0eptZ+/gfvfRzbVmLIUP6XU4Cz5Gn3XL3aqjCBaJ1wkiILC1XNcbyqjk9/2V5Q2xBNrnysIRIZp3rNgPrF6EZSIV/dY+YQLSvWW+AsXiEznm6/NR+U7E7us1g2ouA8NliUYNi9tlF4qWs5T86iH11FP8C84lfnLooCUvWLac46p2aymLFN4w1DyFP2+5uRodft1K47uNWWEGMxdl7RnujlUMv/VH2AGgj7qP794WRFaw10G5xkmIL2iMJMkd83DADilG3q9GTdxHnLqFhHqAP3kSelJkVWGasYb/tu0QR6qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxixJP4C21Jr0YnA7urpszL5QP1bNJLeLeRHlFg1RbU=;
 b=Di3NFGaBsclKhMjBEsZIWor9yacZ2hfBQwsZtdadwB+rHA4ofBywE0IW3Nc/bpYLt99o6sTDTRc6IyldVmZGWZumVhdv74zrewE8Wkl4nGZOwsk+W2o0B233hkSQHlT7tGwJbzKheCrXy0t2bIHohHwiV+uY6wrcNUnUftwERqtqZMYxPS1jX7DkPoCe1ftGtVSWVQX5FL6DeQsf78IEKSBp0gGj8sTjjC3FyqXjsJAD79kBGeDX+cOk/O1G4zU/yXGJMOkkrbN7FTMQiUenNn5vUI/go0BLdO5xA5paMYZ8VcDHXFpdS2KCT2zF0cRCbqonS73oN0rW1KuM5PxiQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxixJP4C21Jr0YnA7urpszL5QP1bNJLeLeRHlFg1RbU=;
 b=f/KLNy0NYIUs4ua5agAHndkQrp5sF7mDkTIZVmSzOTZ/6XsF7LRYNPPkspTcLzjDA6u0y7paC3FMj42szT4IxntjISAnrhkmal5w2vV6ceoI5sJV8TLU0LYjJKVVCAdmuMlhdQTdUXEC7VSzuWUTZwSv/f9jTEPqBZYgpoRZU3o=
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
 by HE1PR0402MB2876.eurprd04.prod.outlook.com (2603:10a6:3:d5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Wed, 10 Jun
 2020 04:07:35 +0000
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::418b:e236:d88e:a9f9]) by HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::418b:e236:d88e:a9f9%7]) with mapi id 15.20.3066.023; Wed, 10 Jun 2020
 04:07:35 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ruscur@russell.cc" <ruscur@russell.cc>,
        "sbobroff@linux.ibm.com" <sbobroff@linux.ibm.com>,
        "oohall@gmail.com" <oohall@gmail.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Subject: RE: [PATCH] PCI: ERR: Don't override the status returned by
 error_detect()
Thread-Topic: [PATCH] PCI: ERR: Don't override the status returned by
 error_detect()
Thread-Index: AQHWNAHzFjO0ECXP406SozGQGSeUD6i+AxqAgABouVCAAA5QgIAS1bwA
Date:   Wed, 10 Jun 2020 04:07:35 +0000
Message-ID: <HE1PR0402MB3371231EDD66A938F650269584830@HE1PR0402MB3371.eurprd04.prod.outlook.com>
References: <20200527083130.4137-1-Zhiqiang.Hou@nxp.com>
 <84a2bc7e-7556-96ff-6cd5-988d432ad8e3@linux.intel.com>
 <AM6PR0402MB3367BCFF5A55D4096CD652FF848F0@AM6PR0402MB3367.eurprd04.prod.outlook.com>
 <29e53d60-0782-7afb-ba8a-b4affb54644f@linux.intel.com>
In-Reply-To: <29e53d60-0782-7afb-ba8a-b4affb54644f@linux.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2c19c8ab-4daa-4ea6-a701-08d80cf3ce66
x-ms-traffictypediagnostic: HE1PR0402MB2876:
x-microsoft-antispam-prvs: <HE1PR0402MB2876BDFA601A6AA0261A07A584830@HE1PR0402MB2876.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 0430FA5CB7
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0bKpK3jQxmPJBJhShCVAGuoOBftFl/WDGsoooIpUVADau5XHglMB7kd/9wT81rjhLfiVhq04x4xM6KasE8dGXQv5sYkfUuYOQ+e3rcy+atPbQBsGhWz6OL1YVhbElHcHkDfx2XPP1FTHfvyGOhEP20zJhgapPhF+cjquu/FV8YiWNtr8+RboTltoIqmw+dFk1bIfNaoyrGfM04PWpAtlPD/M5fH7tCMrKgKQR+JihW607WTJ7DmHe3oYIj7EarHKWv7yybTEeImrtUpRQKiKhY2t77Er8TCW+tObP/F9y7ovusJ0iLPbMMtwIegFq2pA3VUVJURrq74D67TZLAaukVb9AAIn+G2h7j73Qa93nUBXYJeAhcDHyWUSqjMrLi80rBpTDrK4eOSqZFICD6RgzQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3371.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(52536014)(5660300002)(71200400001)(64756008)(66476007)(7696005)(2906002)(76116006)(66446008)(53546011)(110136005)(316002)(45080400002)(66556008)(83380400001)(186003)(66946007)(8936002)(6506007)(86362001)(55016002)(33656002)(8676002)(478600001)(9686003)(966005)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: J7lceV3FKm01+NcUq7hn2kJpiVkFxa8mbUdf3yQMQDHfRuQ9EdIM65pmebihqDzHLxNa+rJy3JZypNxgXFdkm6aGXXm0HpgRq11YO5DLbPP0P7tl5uvhFd0PJdIn8Ccsr5XXdvq98RiC5wTURGmIAm2z3jp9g2e2dEPHpuURlehN8w4u88j70511FSkF5pzgTfCd/UsMRxZ/2cFV6XxYG+WuJNtvP1DkDbID91z4qNn3tqLLFbFNItC7tvKzI5X18O/YPZqPczrBo89bZzow+/igbGD2Pc2ePT1lTfuaa78lMoYXZ94m7fhlYTFacQwZaNxFHx7sjcyjfouhpYM7yPKy9a5GgNmBmRttpfgb4TyG7yYvrPDq+j0lLBXi+k19HxdVCmUcXHzH9xdc2gwX4jhBFDcNc0+N03XgAZaL7koFn4a4JZKCTbL9G2ZpuO6/lZwCIPfewm9SibxU0FXEJRg393XyySJnugnAjbmLkqo=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c19c8ab-4daa-4ea6-a701-08d80cf3ce66
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2020 04:07:35.0776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ikE1UfYruLrXdwrAZgXUN72k6PwVoCDL+vqL7+jCPUCkYaVCQkEBSfSwKIit505lAF6nt150IM2c+jboRYSSSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2876
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgS3VwcHVzd2FteSwNCg0KVGhhbmtzIGEgbG90IGZvciB5b3VyIGNvbW1lbnRzIGFuZCBzb3Jy
eSBmb3IgbXkgbGF0ZSByZXNwb25zZSENCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiBGcm9tOiBLdXBwdXN3YW15LCBTYXRoeWFuYXJheWFuYW4NCj4gPHNhdGh5YW5hcmF5YW5hbi5r
dXBwdXN3YW15QGxpbnV4LmludGVsLmNvbT4NCj4gU2VudDogMjAyMOW5tDXmnIgyOeaXpSAxMjoy
NQ0KPiBUbzogWi5xLiBIb3UgPHpoaXFpYW5nLmhvdUBueHAuY29tPjsgbGludXgtcGNpQHZnZXIu
a2VybmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgcnVzY3VyQHJ1c3Nl
bGwuY2M7IHNib2Jyb2ZmQGxpbnV4LmlibS5jb207DQo+IG9vaGFsbEBnbWFpbC5jb207IGJoZWxn
YWFzQGdvb2dsZS5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gUENJOiBFUlI6IERvbid0IG92
ZXJyaWRlIHRoZSBzdGF0dXMgcmV0dXJuZWQgYnkNCj4gZXJyb3JfZGV0ZWN0KCkNCj4gDQo+IA0K
PiANCj4gT24gNS8yOC8yMCA5OjA0IFBNLCBaLnEuIEhvdSB3cm90ZToNCj4gPiBIaSBLdXBwdXN3
YW15LA0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IEt1
cHB1c3dhbXksIFNhdGh5YW5hcmF5YW5hbg0KPiA+PiA8c2F0aHlhbmFyYXlhbmFuLmt1cHB1c3dh
bXlAbGludXguaW50ZWwuY29tPg0KPiA+PiBTZW50OiAyMDIw5bm0NeaciDI55pelIDU6MTkNCj4g
Pj4gVG86IFoucS4gSG91IDx6aGlxaWFuZy5ob3VAbnhwLmNvbT47IGxpbnV4LXBjaUB2Z2VyLmtl
cm5lbC5vcmc7DQo+ID4+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHJ1c2N1ckBydXNz
ZWxsLmNjOw0KPiA+PiBzYm9icm9mZkBsaW51eC5pYm0uY29tOyBvb2hhbGxAZ21haWwuY29tOyBi
aGVsZ2Fhc0Bnb29nbGUuY29tDQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIFBDSTogRVJSOiBE
b24ndCBvdmVycmlkZSB0aGUgc3RhdHVzIHJldHVybmVkIGJ5DQo+ID4+IGVycm9yX2RldGVjdCgp
DQo+ID4+DQo+ID4+IEhpLA0KPiA+Pg0KPiA+PiBPbiA1LzI3LzIwIDE6MzEgQU0sIFpoaXFpYW5n
IEhvdSB3cm90ZToNCj4gPj4+IEZyb206IEhvdSBaaGlxaWFuZyA8WmhpcWlhbmcuSG91QG54cC5j
b20+DQo+ID4+Pg0KPiA+Pj4gVGhlIGNvbW1pdCA2ZDJjODk0NDE1NzEgKCJQQ0kvRVJSOiBVcGRh
dGUgZXJyb3Igc3RhdHVzIGFmdGVyDQo+ID4+PiByZXNldF9saW5rKCkiKSBvdmVycm9kZSB0aGUg
J3N0YXR1cycgcmV0dXJuZWQgYnkgdGhlIGVycm9yX2RldGVjdCgpDQo+ID4+PiBjYWxsIGJhY2sg
ZnVuY3Rpb24sIHdoaWNoIGlzIGRlcGVuZGVkIG9uIGJ5IHRoZSBuZXh0IHN0ZXAuIFRoaXMNCj4g
Pj4+IG92ZXJyaWRpbmcgbWFrZXMgdGhlIEVuZHBvaW50IGRyaXZlcidzIHJlcXVpcmVkIGluZm8g
KGtlcHQgaW4gdGhlDQo+ID4+PiB2YXINCj4gPj4+IHN0YXR1cykgbG9zdCwgc28gaXQgcmVzdWx0
cyBpbiB0aGUgZmF0YWwgZXJyb3JzJyByZWNvdmVyeSBmYWlsZWQgYW5kDQo+ID4+PiB0aGVuIGtl
cm5lbA0KPiA+PiBwYW5pYy4NCj4gPj4gQ2FuIHlvdSBleHBsYWluIHdoeSB1cGRhdGluZyBzdGF0
dXMgYWZmZWN0cyB0aGUgcmVjb3ZlcnkgPw0KPiA+DQo+ID4gVGFrZSB0aGUgZTEwMDBlIGFzIGFu
IGV4YW1wbGU6DQo+ID4gT25jZSBhIGZhdGFsIGVycm9yIGlzIHJlcG9ydGVkIGJ5IGUxMDAwZSwg
dGhlIGUxMDAwZSdzIGVycm9yX2RldGVjdCgpDQo+ID4gd2lsbCBiZSBjYWxsZWQgYW5kIGl0IHdp
bGwgcmV0dXJuIFBDSV9FUlNfUkVTVUxUX05FRURfUkVTRVQgdG8gcmVxdWVzdA0KPiA+IGEgc2xv
dCByZXNldCwgdGhlIHJldHVybiB2YWx1ZSBpcyBzdG9yZWQgaW4gdGhlICcmc3RhdHVzJyBvZiB0
aGUNCj4gPiBjYWxsaW5nIHBjaV93YWxrX2J1cyhidXMscmVwb3J0X2Zyb3plbl9kZXRlY3RlZCwg
JnN0YXR1cykuDQo+ID4gSWYgeW91IHVwZGF0ZSB0aGUgJ3N0YXR1cycgd2l0aCB0aGUgcmVzZXRf
bGluaygpJ3MgcmV0dXJuIHZhbHVlDQo+ID4gKFBDSV9FUlNfUkVTVUxUX1JFQ09WRVJFRCBpZiB0
aGUgcmVzZXQgbGluayBzdWNjZWVkKSwgdGhlbiB0aGUNCj4gPiAnc3RhdHVzJyBoYXMgdGhlIHZh
bHVlIFBDSV9FUlNfUkVTVUxUX1JFQ09WRVJFRCBhbmQgZTEwMDBlJ3MgcmVxdWVzdA0KPiA+IFBD
SV9FUlNfUkVTVUxUX05FRURfUkVTRVQgbG9zdCwgdGhlbiBlMTAwMGUncyBjYWxsYmFjayBmdW5j
dGlvbg0KPiA+IC5zbG90X3Jlc2V0KCkgd2lsbCBiZSBza2lwcGVkIGFuZCBkaXJlY3RseSBjYWxs
IHRoZSAucmVzdW1lKCkuDQo+IEkgYmVsaWV2ZSB5b3UgYXJlIHdvcmtpbmcgd2l0aCBub24gaG90
cGx1ZyBjYXBhYmxlIGRldmljZS4gSWYgeWVzLCB0aGVuIHRoaXMNCj4gaXNzdWUgd2lsbCBiZSBh
ZGRyZXNzZWQgYnkgdGhlIGZvbGxvd2luZyBwYXRjaC4NCj4gaHR0cHM6Ly9ldXIwMS5zYWZlbGlu
a3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbGttbC5vcmcNCj4g
JTJGbGttbCUyRjIwMjAlMkY1JTJGNiUyRjE1NDUmYW1wO2RhdGE9MDIlN0MwMSU3Q3poaXFpYW5n
LmhvdSU0DQo+IDBueHAuY29tJTdDNGYwYWQ4MzZlNDM4NGY0MDQwMGYwOGQ4MDM4ODM4M2MlN0M2
ODZlYTFkM2JjMmI0YzZmYTkyDQo+IGNkOTljNWMzMDE2MzUlN0MwJTdDMSU3QzYzNzI2MzIzMDg3
NTc4MTY3OCZhbXA7c2RhdGE9YXAwUFVNenNlDQo+IHhJdUNuT3BCQ0ZQVyUyQnJVRXdNV2dBWXpU
N3l4R1A4cGppbyUzRCZhbXA7cmVzZXJ2ZWQ9MA0KDQpJJ2xsIHRyeSB0aGlzIHBhdGNoLCBzZWVt
cyBpdCBhbHNvIG92ZXJyaWRlIHRoZSAnc3RhdHVzJyBpbiB0aGUgcGNpX2NoYW5uZWxfaW9fZnJv
emVuDQpDYXNlIGJ1dCBpdCBtYWtlIHNlbnNlIGZvciBtZS4NCg0KVGhhbmtzLA0KWmhpcWlhbmcN
Cg0KPiA+DQo+ID4gU28gdGhpcyBpcyBob3cgdGhlIHVwZGF0ZSBvZiAnc3RhdHVzJyBicmVhayB0
aGUgaGFuZHNoYWtlIGJldHdlZW4gUkMncw0KPiA+IEFFUiBkcml2ZXIgYW5kIHRoZSBFbmRwb2lu
dCdzIHByb3RvY29sIGRyaXZlciBlcnJvcl9oYW5kbGVycywgdGhlbiByZXN1bHQgaW4NCj4gdGhl
IHJlY292ZXJ5IGZhaWx1cmUuDQo+ID4NCj4gPj4+DQo+ID4+PiBJbiB0aGUgZTEwMDBlIGNhc2Us
IHRoZSBlcnJvciBsb2dzOg0KPiA+Pj4gcGNpZXBvcnQgMDAwMjowMDowMC4wOiBBRVI6IFVuY29y
cmVjdGVkIChGYXRhbCkgZXJyb3IgcmVjZWl2ZWQ6DQo+ID4+PiAwMDAyOjAxOjAwLjAgZTEwMDBl
IDAwMDI6MDE6MDAuMDogQUVSOiBQQ0llIEJ1cyBFcnJvcjoNCj4gPj4+IHNldmVyaXR5PVVuY29y
cmVjdGVkIChGYXRhbCksIHR5cGU9SW5hY2Nlc3NpYmxlLCAoVW5yZWdpc3RlcmVkIEFnZW50DQo+
ID4+PiBJRCkgcGNpZXBvcnQgMDAwMjowMDowMC4wOiBBRVI6IFJvb3QgUG9ydCBsaW5rIGhhcyBi
ZWVuIHJlc2V0DQo+ID4+IEFzIHBlciBhYm92ZSBjb21taXQgbG9nLCBpdCBsb29rcyBsaWtlIGxp
bmsgaXMgcmVzZXQgY29ycmVjdGx5Lg0KPiA+DQo+ID4gWWVzLCBzZWUgbXkgY29tbWVudHMgYWJv
dmUuDQo+ID4NCj4gPiBUaGFua3MsDQo+ID4gWmhpcWlhbmcNCj4gPg0KPiA+Pj4gU0Vycm9yIElu
dGVycnVwdCBvbiBDUFUwLCBjb2RlIDB4YmYwMDAwMDIgLS0gU0Vycm9yDQo+ID4+PiBDUFU6IDAg
UElEOiAxMTEgQ29tbTogaXJxLzc2LWFlcmRydiBOb3QgdGFpbnRlZA0KPiA+Pj4gNS43LjAtcmM3
LW5leHQtMjAyMDA1MjYgIzggSGFyZHdhcmUgbmFtZTogTFMxMDQ2QSBSREIgQm9hcmQgKERUKQ0K
PiA+Pj4gcHN0YXRlOiA4MDAwMDAwNSAoTnpjdiBkYWlmIC1QQU4gLVVBTyBCVFlQRT0tLSkgcGMg
Og0KPiA+Pj4gX19wY2lfZW5hYmxlX21zaXhfcmFuZ2UrMHg0YzgvMHg1YjgNCj4gPj4+IGxyIDog
X19wY2lfZW5hYmxlX21zaXhfcmFuZ2UrMHg0ODAvMHg1YjgNCj4gPj4+IHNwIDogZmZmZjgwMDAx
MTE2YmIzMA0KPiA+Pj4geDI5OiBmZmZmODAwMDExMTZiYjMwIHgyODogMDAwMDAwMDAwMDAwMDAw
Mw0KPiA+Pj4geDI3OiAwMDAwMDAwMDAwMDAwMDAzIHgyNjogMDAwMDAwMDAwMDAwMDAwMA0KPiA+
Pj4geDI1OiBmZmZmMDAwOTcyNDNlMGE4IHgyNDogMDAwMDAwMDAwMDAwMDAwMQ0KPiA+Pj4geDIz
OiBmZmZmMDAwOTcyNDNlMmQ4IHgyMjogMDAwMDAwMDAwMDAwMDAwMA0KPiA+Pj4geDIxOiAwMDAw
MDAwMDAwMDAwMDAzIHgyMDogZmZmZjAwMDk1YmQ0NjA4MA0KPiA+Pj4geDE5OiBmZmZmMDAwOTcy
NDNlMDAwIHgxODogZmZmZmZmZmZmZmZmZmZmZg0KPiA+Pj4geDE3OiAwMDAwMDAwMDAwMDAwMDAw
IHgxNjogMDAwMDAwMDAwMDAwMDAwMA0KPiA+Pj4geDE1OiBmZmZmYjk1OGZhMGU5OTQ4IHgxNDog
ZmZmZjAwMDk1YmQ0NjMwMw0KPiA+Pj4geDEzOiBmZmZmMDAwOTViZDQ2MzAyIHgxMjogMDAwMDAw
MDAwMDAwMDAzOA0KPiA+Pj4geDExOiAwMDAwMDAwMDAwMDAwMDQwIHgxMDogZmZmZmI5NThmYTEw
MWU2OA0KPiA+Pj4geDkgOiBmZmZmYjk1OGZhMTAxZTYwIHg4IDogMDAwMDAwMDAwMDAwMDkwOA0K
PiA+Pj4geDcgOiAwMDAwMDAwMDAwMDAwOTA4IHg2IDogZmZmZjgwMDAxMTYwMDAwMA0KPiA+Pj4g
eDUgOiBmZmZmMDAwOTViZDQ2ODAwIHg0IDogZmZmZjAwMDk2ZTdmNjA4MA0KPiA+Pj4geDMgOiAw
MDAwMDAwMDAwMDAwMDAwIHgyIDogMDAwMDAwMDAwMDAwMDAwMA0KPiA+Pj4geDEgOiAwMDAwMDAw
MDAwMDAwMDAwIHgwIDogMDAwMDAwMDAwMDAwMDAwMCBLZXJuZWwgcGFuaWMgLSBub3QNCj4gPj4+
IHN5bmNpbmc6IEFzeW5jaHJvbm91cyBTRXJyb3IgSW50ZXJydXB0DQo+ID4+PiBDUFU6IDAgUElE
OiAxMTEgQ29tbTogaXJxLzc2LWFlcmRydiBOb3QgdGFpbnRlZA0KPiA+Pj4gNS43LjAtcmM3LW5l
eHQtMjAyMDA1MjYgIzgNCj4gPj4+DQo+ID4+PiBJIHRoaW5rIGl0J3MgdGhlIGV4cGVjdGVkIHJl
c3VsdCB0aGF0ICJpZiB0aGUgaW5pdGlhbCB2YWx1ZSBvZiBlcnJvcg0KPiA+Pj4gc3RhdHVzIGlz
IFBDSV9FUlNfUkVTVUxUX0RJU0NPTk5FQ1Qgb3INCj4gPj4gUENJX0VSU19SRVNVTFRfTk9fQUVS
X0RSSVZFUg0KPiA+Pj4gdGhlbiBldmVuIGFmdGVyIHN1Y2Nlc3NmdWwgcmVjb3ZlcnkgKHVzaW5n
IHJlc2V0X2xpbmsoKSkNCj4gPj4+IHBjaWVfZG9fcmVjb3ZlcnkoKSB3aWxsIHJlcG9ydCB0aGUg
cmVjb3ZlcnkgcmVzdWx0IGFzIGZhaWx1cmUiIHdoaWNoDQo+ID4+PiBpcyBkZXNjcmliZWQgaW4g
Y29tbWl0IDZkMmM4OTQ0MTU3MSAoIlBDSS9FUlI6IFVwZGF0ZSBlcnJvciBzdGF0dXMNCj4gPj4+
IGFmdGVyDQo+ID4+IHJlc2V0X2xpbmsoKSIpLg0KPiA+Pj4NCj4gPj4+IFJlZmVyIHRvIHRoZSBE
b2N1bWVudGF0aW9uL1BDSS9wY2ktZXJyb3ItcmVjb3ZlcnkucnN0Lg0KPiA+Pj4gQXMgdGhlIGVy
cm9yX2RldGVjdCgpIGlzIG1hbmRhdG9yeSBjYWxsYmFjayBpZiB0aGUgcGNpX2Vycl9oYW5kbGVy
cw0KPiA+Pj4gaXMgaW1wbGVtZW50ZWQsIGlmIGl0IHJldHVybiB0aGUgUENJX0VSU19SRVNVTFRf
RElTQ09OTkVDVCwgaXQgbWVhbnMNCj4gPj4+IHRoZSBkcml2ZXIgZG9lc24ndCB3YW50IHRvIHJl
Y292ZXIgYXQgYWxsOyBGb3IgdGhlIGNhc2UNCj4gPj4+IFBDSV9FUlNfUkVTVUxUX05PX0FFUl9E
UklWRVIsIGlmIHRoZSBwY2lfZXJyX2hhbmRsZXJzIGlzIG5vdA0KPiA+Pj4gaW1wbGVtZW50ZWQs
IHRoZSBmYWlsdXJlIGlzIG1vcmUgZXhwZWN0ZWQuDQo+ID4+Pg0KPiA+Pj4gRml4ZXM6IGNvbW1p
dCA2ZDJjODk0NDE1NzEgKCJQQ0kvRVJSOiBVcGRhdGUgZXJyb3Igc3RhdHVzIGFmdGVyDQo+ID4+
PiByZXNldF9saW5rKCkiKQ0KPiA+Pj4gU2lnbmVkLW9mZi1ieTogSG91IFpoaXFpYW5nIDxaaGlx
aWFuZy5Ib3VAbnhwLmNvbT4NCj4gPj4+IC0tLQ0KPiA+Pj4gICAgZHJpdmVycy9wY2kvcGNpZS9l
cnIuYyB8IDMgKy0tDQo+ID4+PiAgICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDIg
ZGVsZXRpb25zKC0pDQo+ID4+Pg0KPiA+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL3BjaWUv
ZXJyLmMgYi9kcml2ZXJzL3BjaS9wY2llL2Vyci5jIGluZGV4DQo+ID4+PiAxNGJiOGY1NDcyM2Uu
Ljg0ZjcyMzQyMjU5YyAxMDA2NDQNCj4gPj4+IC0tLSBhL2RyaXZlcnMvcGNpL3BjaWUvZXJyLmMN
Cj4gPj4+ICsrKyBiL2RyaXZlcnMvcGNpL3BjaWUvZXJyLmMNCj4gPj4+IEBAIC0xNjUsOCArMTY1
LDcgQEAgcGNpX2Vyc19yZXN1bHRfdCBwY2llX2RvX3JlY292ZXJ5KHN0cnVjdCBwY2lfZGV2DQo+
ID4+ICpkZXYsDQo+ID4+PiAgICAJcGNpX2RiZyhkZXYsICJicm9hZGNhc3QgZXJyb3JfZGV0ZWN0
ZWQgbWVzc2FnZVxuIik7DQo+ID4+PiAgICAJaWYgKHN0YXRlID09IHBjaV9jaGFubmVsX2lvX2Zy
b3plbikgew0KPiA+Pj4gICAgCQlwY2lfd2Fsa19idXMoYnVzLCByZXBvcnRfZnJvemVuX2RldGVj
dGVkLCAmc3RhdHVzKTsNCj4gPj4+IC0JCXN0YXR1cyA9IHJlc2V0X2xpbmsoZGV2KTsNCj4gPj4+
IC0JCWlmIChzdGF0dXMgIT0gUENJX0VSU19SRVNVTFRfUkVDT1ZFUkVEKSB7DQo+ID4+PiArCQlp
ZiAocmVzZXRfbGluayhkZXYpICE9IFBDSV9FUlNfUkVTVUxUX1JFQ09WRVJFRCkgew0KPiA+Pj4g
ICAgCQkJcGNpX3dhcm4oZGV2LCAibGluayByZXNldCBmYWlsZWRcbiIpOw0KPiA+Pj4gICAgCQkJ
Z290byBmYWlsZWQ7DQo+ID4+PiAgICAJCX0NCj4gPj4+DQo+ID4+DQo+ID4+IC0tDQo+ID4+IFNh
dGh5YW5hcmF5YW5hbiBLdXBwdXN3YW15DQo+ID4+IExpbnV4IEtlcm5lbCBEZXZlbG9wZXINCj4g
DQo+IC0tDQo+IFNhdGh5YW5hcmF5YW5hbiBLdXBwdXN3YW15DQo+IExpbnV4IEtlcm5lbCBEZXZl
bG9wZXINCg==
