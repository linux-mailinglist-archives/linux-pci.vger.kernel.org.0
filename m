Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE536189848
	for <lists+linux-pci@lfdr.de>; Wed, 18 Mar 2020 10:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbgCRJpA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Mar 2020 05:45:00 -0400
Received: from mail-db8eur05on2040.outbound.protection.outlook.com ([40.107.20.40]:7136
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727566AbgCRJpA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Mar 2020 05:45:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0Xtr/+3YZYe0JvTWPEi3XvnHC3fz1umnNn/Anu/nBnL+rfJQCRHxl7ybZ/8/QjEJtwPoxeRDYphDdBYqN4QUDhJ4+wk+WF51/Gz2Ltp18rvw/4d6KH5iFXO+40sFw9fDVCC+GfB2fndkoIpB1hLsdNxhrxoewpA3WpWVLURuZuH0WeFJnpfZX0c61MyDkZiUtsYjNp9JmIyws3Asxr7JNVPlBb9TNsVWaTxSwB/R/gr0tpGzZlO1QytUlWkEEBrCXjiN1NVoEezTqawyfgdTgfI9uFunJYhxwFO75Jc4EkBRZqnqOiqTw9kMvZQCdXO4d1uRgia9G7IJZntaDU84w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSTETZmAGkRGH7vnf1YsRiiPr9UbftXk+eCuMx3EfQA=;
 b=cTKiwPiA+t2bWOhAsPRkCZuF+oGbo2sRRI/yCXEjcAGe6XGdgBOtQIrYCsl+Koi5gPmsV3CGo0ljfilAfX7pm+TcMdbuyE/ChL2vO7ufjOEGqDO8UaQID3Ldo4/e2xR5whBT7YMHR6VRSa7qAdWz4OgCsXXdnHEQCXCdoJOYCDE9tTMcq49i59HTlH5kfjdkvUyI2UrcpUGqpvjCNI19cn6iU3JmqLnJlr41EOGnaH3hzlwi/kXLqTLphkhIhvYKO1shLj0BYIatS3V21/u4aJX3wnWL96lxQeQKzUZ5y1iYYZ1uBW0ePRIhsoPwmnq4ur7ReCzWsVBJcWnxr5h8Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSTETZmAGkRGH7vnf1YsRiiPr9UbftXk+eCuMx3EfQA=;
 b=ero6PPD0PXl0LrEuyzLWAGEsL43Br3/Qj6z32awygWOEnOBHzpZpsCI2awrqv1M6GuXoXMh9JrBvC3Jugo695VZDcHfVrWO9FqfO2/5MOXrokmDxJi7kE8hhPA20+dv38ywK+URlGoqYDVFCTQDunONsjYN5o/e7GVDpbW5nvo0=
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB5801.eurprd04.prod.outlook.com (20.179.10.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.22; Wed, 18 Mar 2020 09:44:56 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::4528:6120:94a4:ce1e]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::4528:6120:94a4:ce1e%5]) with mapi id 15.20.2814.021; Wed, 18 Mar 2020
 09:44:56 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>
Subject: RE: linux-next: Tree for Mar 12 (pci/controller/mobiveil/)
Thread-Topic: linux-next: Tree for Mar 12 (pci/controller/mobiveil/)
Thread-Index: AQHV+IDZ0AdozfzAfUCC22i6ufIb7KhFWtOAgAbdJrCAAAhtgIAAU7SggABYr4CAATPeEA==
Date:   Wed, 18 Mar 2020 09:44:56 +0000
Message-ID: <DB8PR04MB6747096182E3DDC288866A2884F70@DB8PR04MB6747.eurprd04.prod.outlook.com>
References: <4c0db5d0-1a61-cb80-2bcb-034f5bcd1597@infradead.org>
 <20200312193917.GA160316@google.com>
 <DB8PR04MB6747C1032BF126CFFB5720E084F60@DB8PR04MB6747.eurprd04.prod.outlook.com>
 <e53be1bc-e84d-433a-e9a7-ea442c93f2cf@infradead.org>
 <DB8PR04MB6747E855D3349173CE2AE9F684F60@DB8PR04MB6747.eurprd04.prod.outlook.com>
 <23a2a891-4d69-34a3-4cf6-525e54738b77@infradead.org>
In-Reply-To: <23a2a891-4d69-34a3-4cf6-525e54738b77@infradead.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 99778cc1-c1a8-4372-7c99-08d7cb210472
x-ms-traffictypediagnostic: DB8PR04MB5801:
x-microsoft-antispam-prvs: <DB8PR04MB5801485D88FABD1643A4731D84F70@DB8PR04MB5801.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03468CBA43
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(396003)(346002)(376002)(366004)(199004)(33656002)(2906002)(54906003)(110136005)(316002)(26005)(6506007)(53546011)(478600001)(7696005)(186003)(66556008)(66946007)(64756008)(66446008)(66476007)(9686003)(76116006)(8936002)(5660300002)(81166006)(8676002)(81156014)(86362001)(55016002)(52536014)(4326008)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB5801;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u/Xo+JqoRLdTjdJO5MAmf/19PtapllMb9hG/CaepklqzAMNFMJ9cQ7DynVzRfP5pE44SdX7O6NxPZcRbAPGJdT1LCjPceqJVRG1JNvvtRblIehzIPPRFHMIOm6Hclxa4wciufm1MVi7r56ewC0r8zgtFel2R36JIZOyM0V2LxXoSZ7oBctA7uyuw3+/QuGLOZyu0sXIWyCLzcw8YhICd1fWYzoR1HzcNxV8UR6TkNVrzllDZFMAtBT1vhewCRNCHV8nWuVBfuaz5BGN2HLhZUas86gRKSVTxeX/+UyDSHrnFG2Kq2Gmby4b27wPLySVnoF+IdVQ/ifO5/pEudpRSGVk+JCpO+so/vDfiqJOx4m8FzgKtscGTT0+AN3B3E5+hsAaiMxuwJ5CFxE70hM5nGddSnCLl/aRE0Xzfz+hbq4Z7YAmWaKpyoTOaMy5UHrzV
x-ms-exchange-antispam-messagedata: gRiipwTqBgh5qnmd7H1YoKC1ppUepZlWMvP6rRmr/QFGZ0WPi/9JyFt7H1IW9ZVLlrQKElMBI4h8cwQAH9M9M3BuyIiuCP7OoQa81oNYa/Wr4j7vcbuHet6dsgS6B9FoDiZlECH2mC1gbEP9xJlwEw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99778cc1-c1a8-4372-7c99-08d7cb210472
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2020 09:44:56.3846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5O3xGSAWoCetmz6jGc1VmKxkXNJzOrccCz2uBHmX5PapXzER8+hkk+Mpj9Xn5qpeyNEXII2KaAV9yCCgsdFr+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5801
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgUmFuZHksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmFuZHkg
RHVubGFwIDxyZHVubGFwQGluZnJhZGVhZC5vcmc+DQo+IFNlbnQ6IDIwMjDlubQz5pyIMTfml6Ug
MjM6MTYNCj4gVG86IFoucS4gSG91IDx6aGlxaWFuZy5ob3VAbnhwLmNvbT47IEJqb3JuIEhlbGdh
YXMgPGhlbGdhYXNAa2VybmVsLm9yZz4NCj4gQ2M6IFN0ZXBoZW4gUm90aHdlbGwgPHNmckBjYW5i
LmF1dWcub3JnLmF1PjsgTGludXggTmV4dCBNYWlsaW5nIExpc3QNCj4gPGxpbnV4LW5leHRAdmdl
ci5rZXJuZWwub3JnPjsgTGludXggS2VybmVsIE1haWxpbmcgTGlzdA0KPiA8bGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZz47IGxpbnV4LXBjaSA8bGludXgtcGNpQHZnZXIua2VybmVsLm9yZz47
DQo+IEthcnRoaWtleWFuIE1pdHJhbiA8bS5rYXJ0aGlrZXlhbkBtb2JpdmVpbC5jby5pbj4NCj4g
U3ViamVjdDogUmU6IGxpbnV4LW5leHQ6IFRyZWUgZm9yIE1hciAxMiAocGNpL2NvbnRyb2xsZXIv
bW9iaXZlaWwvKQ0KPiANCj4gT24gMy8xNy8yMCAzOjA1IEFNLCBaLnEuIEhvdSB3cm90ZToNCj4g
PiBIaSBSYW5keSwNCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBG
cm9tOiBSYW5keSBEdW5sYXAgPHJkdW5sYXBAaW5mcmFkZWFkLm9yZz4NCj4gPj4gU2VudDogMjAy
MOW5tDPmnIgxN+aXpSAxMjo1OQ0KPiA+PiBUbzogWi5xLiBIb3UgPHpoaXFpYW5nLmhvdUBueHAu
Y29tPjsgQmpvcm4gSGVsZ2Fhcw0KPiA+PiA8aGVsZ2Fhc0BrZXJuZWwub3JnPg0KPiA+PiBDYzog
U3RlcGhlbiBSb3Rod2VsbCA8c2ZyQGNhbmIuYXV1Zy5vcmcuYXU+OyBMaW51eCBOZXh0IE1haWxp
bmcgTGlzdA0KPiA+PiA8bGludXgtbmV4dEB2Z2VyLmtlcm5lbC5vcmc+OyBMaW51eCBLZXJuZWwg
TWFpbGluZyBMaXN0DQo+ID4+IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgbGludXgt
cGNpDQo+ID4+IDxsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnPjsgS2FydGhpa2V5YW4gTWl0cmFu
DQo+ID4+IDxtLmthcnRoaWtleWFuQG1vYml2ZWlsLmNvLmluPg0KPiA+PiBTdWJqZWN0OiBSZTog
bGludXgtbmV4dDogVHJlZSBmb3IgTWFyIDEyIChwY2kvY29udHJvbGxlci9tb2JpdmVpbC8pDQo+
ID4+DQo+ID4+IE9uIDMvMTYvMjAgOTozMSBQTSwgWi5xLiBIb3Ugd3JvdGU6DQo+ID4+PiBIaSBS
YW5keSBhbmQgQmpvcm4sDQo+ID4+Pg0KPiA+Pj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+ID4+Pj4gRnJvbTogQmpvcm4gSGVsZ2FhcyA8aGVsZ2Fhc0BrZXJuZWwub3JnPg0KPiA+Pj4+
IFNlbnQ6IDIwMjDlubQz5pyIMTPml6UgMzozOQ0KPiA+Pj4+IFRvOiBaLnEuIEhvdSA8emhpcWlh
bmcuaG91QG54cC5jb20+DQo+ID4+Pj4gQ2M6IFJhbmR5IER1bmxhcCA8cmR1bmxhcEBpbmZyYWRl
YWQub3JnPjsgU3RlcGhlbiBSb3Rod2VsbA0KPiA+Pj4+IDxzZnJAY2FuYi5hdXVnLm9yZy5hdT47
IExpbnV4IE5leHQgTWFpbGluZyBMaXN0DQo+ID4+Pj4gPGxpbnV4LW5leHRAdmdlci5rZXJuZWwu
b3JnPjsgTGludXggS2VybmVsIE1haWxpbmcgTGlzdA0KPiA+Pj4+IDxsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnPjsgbGludXgtcGNpDQo+ID4+Pj4gPGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5v
cmc+OyBLYXJ0aGlrZXlhbiBNaXRyYW4NCj4gPj4+PiA8bS5rYXJ0aGlrZXlhbkBtb2JpdmVpbC5j
by5pbj4NCj4gPj4+PiBTdWJqZWN0OiBSZTogbGludXgtbmV4dDogVHJlZSBmb3IgTWFyIDEyIChw
Y2kvY29udHJvbGxlci9tb2JpdmVpbC8pDQo+ID4+Pj4NCj4gPj4+PiBPbiBUaHUsIE1hciAxMiwg
MjAyMCBhdCAwODoxMzo1MEFNIC0wNzAwLCBSYW5keSBEdW5sYXAgd3JvdGU6DQo+ID4+Pj4+IE9u
IDMvMTIvMjAgMzowNCBBTSwgU3RlcGhlbiBSb3Rod2VsbCB3cm90ZToNCj4gPj4+Pj4+IEhpIGFs
bCwNCj4gPj4+Pj4+DQo+ID4+Pj4+PiBDaGFuZ2VzIHNpbmNlIDIwMjAwMzExOg0KPiA+Pj4+Pj4N
Cj4gPj4+Pj4NCj4gPj4+Pj4gb24gaTM4NjoNCj4gPj4+Pj4gIyBDT05GSUdfUENJX01TSSBpcyBu
b3Qgc2V0DQo+ID4+Pj4+DQo+ID4+Pj4+IFdBUk5JTkc6IHVubWV0IGRpcmVjdCBkZXBlbmRlbmNp
ZXMgZGV0ZWN0ZWQgZm9yDQo+ID4+IFBDSUVfTU9CSVZFSUxfSE9TVA0KPiA+Pj4+PiAgIERlcGVu
ZHMgb24gW25dOiBQQ0kgWz15XSAmJiBQQ0lfTVNJX0lSUV9ET01BSU4gWz1uXQ0KPiA+Pj4+PiAg
IFNlbGVjdGVkIGJ5IFt5XToNCj4gPj4+Pj4gICAtIFBDSUVfTU9CSVZFSUxfUExBVCBbPXldICYm
IFBDSSBbPXldICYmIChBUkNIX1pZTlFNUCB8fA0KPiA+Pj4+IENPTVBJTEVfVEVTVCBbPXldKSAm
JiBPRiBbPXldDQo+ID4+Pj4NCj4gPj4+PiBUaGFua3MsIFJhbmR5Lg0KPiA+Pj4+DQo+ID4+Pj4g
SSdtIG5vdCBzdXJlIGlmIHRoaXMgaXMgYSBuZXcgcHJvYmxlbSBpbnRyb2R1Y2VkIGJ5IHNvbWV0
aGluZyBpbiBteQ0KPiA+Pj4+ICJuZXh0IiBicmFuY2gsIG9yIGlmIHRoaXMgaXMgYW4gZXhpc3Rp
bmcgcHJvYmxlbSB3ZSBqdXN0IGhhcHBlbmVkDQo+ID4+Pj4gdG8gaGl0IHdpdGggcmFuZGNvbmZp
Zy4NCj4gPj4+Pg0KPiA+Pj4+IEhlcmUgYXJlIHRoZSBjb21taXRzIG9uIHJlbW90ZXMvbG9yZW56
by9wY2kvbW9iaXZlaWwgYnJhbmNoOg0KPiA+Pj4+DQo+ID4+Pj4gICBkMjlhZDcwYTgxM2IgKCJQ
Q0k6IG1vYml2ZWlsOiBBZGQgUENJZSBHZW40IFJDIGRyaXZlciBmb3INCj4gPj4+PiBMYXllcnNj
YXBlDQo+ID4+Pj4gU29DcyIpDQo+ID4+Pj4gICAzZWRlYjQ5NTI1YmIgKCJkdC1iaW5kaW5nczog
UENJOiBBZGQgTlhQIExheWVyc2NhcGUgU29DcyBQQ0llDQo+ID4+Pj4gR2VuNA0KPiA+Pj4+IGNv
bnRyb2xsZXIiKQ0KPiA+Pj4+ICAgMTFkMjJjYzM5NWNhICgiUENJOiBtb2JpdmVpbDogQWRkIEhl
YWRlciBUeXBlIGZpZWxkIGNoZWNrIikNCj4gPj4+PiAgIDAyOWRlYTNjZGM2NyAoIlBDSTogbW9i
aXZlaWw6IEFkZCA4LWJpdCBhbmQgMTYtYml0IENTUiByZWdpc3Rlcg0KPiA+Pj4+IGFjY2Vzc29y
cyIpDQo+ID4+Pj4gICA1MmNhZTRjNzA4MmYgKCJQQ0k6IG1vYml2ZWlsOiBBbGxvdyBtb2JpdmVp
bF9ob3N0X2luaXQoKSB0byBiZQ0KPiA+Pj4+IHVzZWQgdG8gcmUtaW5pdCBob3N0IikNCj4gPj4+
PiAgIGZjOTliMzMxMWFmNyAoIlBDSTogbW9iaXZlaWw6IEFkZCBjYWxsYmFjayBmdW5jdGlvbiBm
b3IgbGluayB1cA0KPiBjaGVjayIpDQo+ID4+Pj4gICBlZDYyMGU5NjU0MWYgKCJQQ0k6IG1vYml2
ZWlsOiBBZGQgY2FsbGJhY2sgZnVuY3Rpb24gZm9yIGludGVycnVwdA0KPiA+Pj4+IGluaXRpYWxp
emF0aW9uIikNCj4gPj4+PiAgIDAzYmRjMzg4NDAxOSAoIlBDSTogbW9iaXZlaWw6IE1vZHVsYXJp
emUgdGhlIE1vYml2ZWlsIFBDSWUgSG9zdA0KPiA+Pj4+IEJyaWRnZSBJUA0KPiA+Pj4+IGRyaXZl
ciIpDQo+ID4+Pj4gICAzOWUzYTAzZWVhNWIgKCJQQ0k6IG1vYml2ZWlsOiBDb2xsZWN0IHRoZSBp
bnRlcnJ1cHQgcmVsYXRlZA0KPiA+Pj4+IG9wZXJhdGlvbnMgaW50byBhIGZ1bmN0aW9uIikNCj4g
Pj4+PiAgIDJiYTI0ODQyZDZiNCAoIlBDSTogbW9iaXZlaWw6IE1vdmUgdGhlIGhvc3QgaW5pdGlh
bGl6YXRpb24gaW50byBhDQo+ID4+IGZ1bmN0aW9uIikNCj4gPj4+PiAgIDFmNDQyMjE4ZDY1NyAo
IlBDSTogbW9iaXZlaWw6IEludHJvZHVjZSBhIG5ldyBzdHJ1Y3R1cmUNCj4gPj4+PiBtb2JpdmVp
bF9yb290X3BvcnQiKQ0KPiA+Pj4+DQo+ID4+Pj4gSSBkcm9wcGVkIHRoYXQgbW9iaXZlaWwgYnJh
bmNoIGZvciBub3csIHNvIEhvdSwgY2FuIHlvdSBwbGVhc2UNCj4gPj4+PiBjaGVjayB0aGlzIG91
dCBhbmQgcmVzb2x2ZSBpdCBvbmUgd2F5IG9yIHRoZSBvdGhlcj8NCj4gPj4+DQo+ID4+PiBJIGRv
bid0IHJlcHJvZHVjZSB0aGlzIGlzc3VlIHdpdGggaTM4Nl9kZWZjb25maWcsIGNhbiB5b3UgaGVs
cCBtZSB0bw0KPiA+PiByZXByb2R1Y2UgaXQ/DQo+ID4+DQo+ID4+IFN1cmUsIHNlZSBiZWxvdy4N
Cj4gPj4NCj4gPj4NCj4gPj4+IFRoYW5rcywNCj4gPj4+IFpoaXFpYW5nDQo+ID4+Pg0KPiA+Pj4+
DQo+ID4+Pj4+IC4uL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvbW9iaXZlaWwvcGNpZS1tb2JpdmVp
bC1ob3N0LmM6Mzc1OjE1OiBlcnJvcjoNCj4gPj4+PiB2YXJpYWJsZSDigJhtb2JpdmVpbF9tc2lf
ZG9tYWluX2luZm/igJkgaGFzIGluaXRpYWxpemVyIGJ1dCBpbmNvbXBsZXRlDQo+ID4+Pj4gdHlw
ZQ0KPiA+Pj4+PiAgc3RhdGljIHN0cnVjdCBtc2lfZG9tYWluX2luZm8gbW9iaXZlaWxfbXNpX2Rv
bWFpbl9pbmZvID0gew0KPiA+Pj4+PiAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn4NCj4g
Pj4+Pj4gLi4vZHJpdmVycy9wY2kvY29udHJvbGxlci9tb2JpdmVpbC9wY2llLW1vYml2ZWlsLWhv
c3QuYzozNzY6MzoNCj4gPj4+Pj4gZXJyb3I6IOKAmHN0cnVjdA0KPiA+Pj4+IG1zaV9kb21haW5f
aW5mb+KAmSBoYXMgbm8gbWVtYmVyIG5hbWVkIOKAmGZsYWdz4oCZDQo+ID4+Pj4+ICAgLmZsYWdz
ID0gKE1TSV9GTEFHX1VTRV9ERUZfRE9NX09QUyB8DQo+ID4+Pj4gTVNJX0ZMQUdfVVNFX0RFRl9D
SElQX09QUyB8DQo+ID4+Pj4+ICAgIF5+fn5+DQo+ID4+Pj4+IC4uL2RyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvbW9iaXZlaWwvcGNpZS1tb2JpdmVpbC1ob3N0LmM6Mzc2OjEyOiBlcnJvcjoNCj4gPj4+
PiDigJhNU0lfRkxBR19VU0VfREVGX0RPTV9PUFPigJkgdW5kZWNsYXJlZCBoZXJlIChub3QgaW4g
YSBmdW5jdGlvbik7DQo+ID4+IGRpZA0KPiA+Pj4+IHlvdSBtZWFuIOKAmFNJTVBMRV9ERVZfUE1f
T1BT4oCZPw0KPiA+Pj4+PiAgIC5mbGFncyA9IChNU0lfRkxBR19VU0VfREVGX0RPTV9PUFMgfA0K
PiA+Pj4+IE1TSV9GTEFHX1VTRV9ERUZfQ0hJUF9PUFMgfA0KPiA+Pj4+PiAgICAgICAgICAgICBe
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCj4gPj4+Pj4gICAgICAgICAgICAgU0lNUExFX0RFVl9Q
TV9PUFMNCj4gPj4+Pj4gLi4vZHJpdmVycy9wY2kvY29udHJvbGxlci9tb2JpdmVpbC9wY2llLW1v
Yml2ZWlsLWhvc3QuYzozNzY6Mzk6IGVycm9yOg0KPiA+Pj4+IOKAmE1TSV9GTEFHX1VTRV9ERUZf
Q0hJUF9PUFPigJkgdW5kZWNsYXJlZCBoZXJlIChub3QgaW4gYSBmdW5jdGlvbik7DQo+ID4+Pj4g
ZGlkIHlvdSBtZWFuIOKAmE1TSV9GTEFHX1VTRV9ERUZfRE9NX09QU+KAmT8NCj4gPj4+Pj4gICAu
ZmxhZ3MgPSAoTVNJX0ZMQUdfVVNFX0RFRl9ET01fT1BTIHwNCj4gPj4+PiBNU0lfRkxBR19VU0Vf
REVGX0NISVBfT1BTIHwNCj4gPj4+Pj4NCj4gPj4+PiBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
DQo+ID4+Pj4+DQo+ID4+Pj4gTVNJX0ZMQUdfVVNFX0RFRl9ET01fT1BTDQo+ID4+Pj4+IC4uL2Ry
aXZlcnMvcGNpL2NvbnRyb2xsZXIvbW9iaXZlaWwvcGNpZS1tb2JpdmVpbC1ob3N0LmM6Mzc3OjY6
IGVycm9yOg0KPiA+Pj4+IOKAmE1TSV9GTEFHX1BDSV9NU0lY4oCZIHVuZGVjbGFyZWQgaGVyZSAo
bm90IGluIGEgZnVuY3Rpb24pOyBkaWQgeW91DQo+ID4+Pj4gbWVhbiDigJhTU19GTEFHX0JJVFPi
gJk/DQo+ID4+Pj4+ICAgICAgIE1TSV9GTEFHX1BDSV9NU0lYKSwNCj4gPj4+Pj4gICAgICAgXn5+
fn5+fn5+fn5+fn5+fn4NCj4gPj4+Pj4gICAgICAgU1NfRkxBR19CSVRTDQo+ID4+Pj4+IC4uL2Ry
aXZlcnMvcGNpL2NvbnRyb2xsZXIvbW9iaXZlaWwvcGNpZS1tb2JpdmVpbC1ob3N0LmM6Mzc2OjEx
Og0KPiB3YXJuaW5nOg0KPiA+Pj4+IGV4Y2VzcyBlbGVtZW50cyBpbiBzdHJ1Y3QgaW5pdGlhbGl6
ZXINCj4gPj4+Pj4gICAuZmxhZ3MgPSAoTVNJX0ZMQUdfVVNFX0RFRl9ET01fT1BTIHwNCj4gPj4+
PiBNU0lfRkxBR19VU0VfREVGX0NISVBfT1BTIHwNCj4gPj4+Pj4gICAgICAgICAgICBeDQo+ID4+
Pj4+IC4uL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvbW9iaXZlaWwvcGNpZS1tb2JpdmVpbC1ob3N0
LmM6Mzc2OjExOg0KPiA+Pj4+PiBub3RlOiAobmVhcg0KPiA+Pj4+IGluaXRpYWxpemF0aW9uIGZv
ciDigJhtb2JpdmVpbF9tc2lfZG9tYWluX2luZm/igJkpDQo+ID4+Pj4+IC4uL2RyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvbW9iaXZlaWwvcGNpZS1tb2JpdmVpbC1ob3N0LmM6Mzc4OjM6DQo+ID4+Pj4+
IGVycm9yOiDigJhzdHJ1Y3QNCj4gPj4+PiBtc2lfZG9tYWluX2luZm/igJkgaGFzIG5vIG1lbWJl
ciBuYW1lZCDigJhjaGlw4oCZDQo+ID4+Pj4+ICAgLmNoaXAgPSAmbW9iaXZlaWxfbXNpX2lycV9j
aGlwLA0KPiA+Pj4+PiAgICBefn5+DQo+ID4+Pj4+IC4uL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
bW9iaXZlaWwvcGNpZS1tb2JpdmVpbC1ob3N0LmM6Mzc4OjEwOg0KPiB3YXJuaW5nOg0KPiA+Pj4+
IGV4Y2VzcyBlbGVtZW50cyBpbiBzdHJ1Y3QgaW5pdGlhbGl6ZXINCj4gPj4+Pj4gICAuY2hpcCA9
ICZtb2JpdmVpbF9tc2lfaXJxX2NoaXAsDQo+ID4+Pj4+ICAgICAgICAgICBeDQo+ID4+Pj4+IC4u
L2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvbW9iaXZlaWwvcGNpZS1tb2JpdmVpbC1ob3N0LmM6Mzc4
OjEwOg0KPiA+Pj4+PiBub3RlOiAobmVhcg0KPiA+Pj4+IGluaXRpYWxpemF0aW9uIGZvciDigJht
b2JpdmVpbF9tc2lfZG9tYWluX2luZm/igJkpDQo+ID4+Pj4+IC4uL2RyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvbW9iaXZlaWwvcGNpZS1tb2JpdmVpbC1ob3N0LmM6IEluDQo+ID4+Pj4+IGZ1bmN0aW9u
DQo+ID4+Pj4g4oCYbW9iaXZlaWxfYWxsb2NhdGVfbXNpX2RvbWFpbnPigJk6DQo+ID4+Pj4+IC4u
L2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvbW9iaXZlaWwvcGNpZS1tb2JpdmVpbC1ob3N0LmM6NDY5
OjIwOiBlcnJvcjoNCj4gPj4+PiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiDigJhw
Y2lfbXNpX2NyZWF0ZV9pcnFfZG9tYWlu4oCZOyBkaWQNCj4gPj4+PiB5b3UgbWVhbiDigJhwY2lf
bXNpX2dldF9kZXZpY2VfZG9tYWlu4oCZPw0KPiA+Pj4+IFstV2Vycm9yPWltcGxpY2l0LWZ1bmN0
aW9uLWRlY2xhcmF0aW9uXQ0KPiA+Pj4+PiAgIG1zaS0+bXNpX2RvbWFpbiA9IHBjaV9tc2lfY3Jl
YXRlX2lycV9kb21haW4oZndub2RlLA0KPiA+Pj4+PiAgICAgICAgICAgICAgICAgICAgIF5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn4NCj4gPj4+Pj4gICAgICAgICAgICAgICAgICAgICBwY2lfbXNp
X2dldF9kZXZpY2VfZG9tYWluDQo+ID4+Pj4+IC4uL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvbW9i
aXZlaWwvcGNpZS1tb2JpdmVpbC1ob3N0LmM6NDY5OjE4Og0KPiB3YXJuaW5nOg0KPiA+Pj4+IGFz
c2lnbm1lbnQgbWFrZXMgcG9pbnRlciBmcm9tIGludGVnZXIgd2l0aG91dCBhIGNhc3QNCj4gPj4+
PiBbLVdpbnQtY29udmVyc2lvbl0NCj4gPj4+Pj4gICBtc2ktPm1zaV9kb21haW4gPSBwY2lfbXNp
X2NyZWF0ZV9pcnFfZG9tYWluKGZ3bm9kZSwNCj4gPj4+Pj4gICAgICAgICAgICAgICAgICAgXg0K
PiA+Pj4+PiAuLi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL21vYml2ZWlsL3BjaWUtbW9iaXZlaWwt
aG9zdC5jOiBBdCB0b3AgbGV2ZWw6DQo+ID4+Pj4+IC4uL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
bW9iaXZlaWwvcGNpZS1tb2JpdmVpbC1ob3N0LmM6Mzc1OjMxOiBlcnJvcjoNCj4gPj4+PiBzdG9y
YWdlIHNpemUgb2Yg4oCYbW9iaXZlaWxfbXNpX2RvbWFpbl9pbmZv4oCZIGlzbuKAmXQga25vd24N
Cj4gPj4+Pj4gIHN0YXRpYyBzdHJ1Y3QgbXNpX2RvbWFpbl9pbmZvIG1vYml2ZWlsX21zaV9kb21h
aW5faW5mbyA9IHsNCj4gPj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fg0KPiA+Pj4+Pg0KPiA+Pj4+Pg0KPiA+Pj4+Pg0KPiA+Pj4+PiBG
dWxsIHJhbmRjb25maWcgZmlsZSBpcyBhdHRhY2hlZC4NCj4gPj4NCj4gPj4gVXNlIHRoZSAuY29u
ZmlnIGZpbGUgdGhhdCB3YXMgYXR0YWNoZWQgaW4gdGhlIHJlcG9ydC4NCj4gPg0KPiA+IE9uZSBx
dWVyeSwgd2hpY2ggZGVmYXVsdCBjb25maWcgeW91IHVzZWQgdG8gZ2VuZXJhdGUgdGhpcyAuY29u
ZmlnPyBJDQo+ID4gY2Fubm90IHNlbGVjdCB0aGUgUENJRV9NT0JJVkVJTF9QTEFUIGluICdtZW51
Y29uZmlnJyB3aGVuIHVzZSB0aGUNCj4gaTM4Nl9kZWZjb25maWcuDQo+IA0KPiBIaSwNCj4gDQo+
IEkgZGlkIG5vdCB1c2UgYW55IGRlZmNvbmZpZy4NCj4gSnVzdCBjcCB0aGF0IGNvbmZpZyBmaWxl
IGludG8geW91ciBidWlsZCBkaXJlY3RvcnkgKGFzIC5jb25maWcpDQo+IA0KPiBhbmQgZG8gc29t
ZXRoaW5nIGxpa2U6DQo+ICQgbWFrZSBBUkNIPWkzODYgb2xkY29uZmlnDQoNCkkgc2VudCBhIHBh
dGNoIHRvIGZpeCB0aGlzIGlzc3VlLCBidXQgSSBhbHNvIHdhbnQgdG8ga25vdyB3aHkgZGlkIHlv
dSBlbmFibGUgdGhlDQpQQ0lFX01PQklWRUlMX1BMQVQgaW4gdGhlIGkzODYgLmNvbmZpZz8gSSBt
ZWFuIHdoYXQgaXMgdGhpcyB0ZXN0IGZvci4NCg0KVGhhbmtzLA0KWmhpcWlhbmcNCg0KPiANCj4g
DQo+IC0tDQo+IH5SYW5keQ0KDQo=
