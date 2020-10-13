Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6426628C6FF
	for <lists+linux-pci@lfdr.de>; Tue, 13 Oct 2020 04:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbgJMCCh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Oct 2020 22:02:37 -0400
Received: from mail-eopbgr150044.outbound.protection.outlook.com ([40.107.15.44]:64994
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728511AbgJMCCg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Oct 2020 22:02:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IoaYQ3OKzxzsXlxyJgm4raAtDakWXG+1i8e9rrfZsltuPifWTOGOLeKee6f8Fky1mWEKEAtUEYpaJJ19xeegy7zcQh+8Pf39KNLictJ66ENAKg9CPyzx4nftBLetokUg6/58da6gxlCkOL7JtEDikSX3ane895SIVbICCuTDBEuGNO48CPVFQZiRWayPQVFLMzkifVZCoW8Ncz+UTMaj8gj1JyPtSzUbCliqDpDkjOyR08BSLMxOKHf3AFOgJ9WJZalJdLOmPfpsovVPNKfXKAyfsHXS0HzKYKe+L3NMlv5ksTPXUOn9CTnT56AftBJmoS4Fy9WlPHTdObWc+Dkn5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtoqaSySJL7+FIXcNFws7G/1LQnDLiWs7vAS7hT/M8U=;
 b=j+kzbUofcb3HZB1//0ftT8y8FSSlLFa2PORfqubsrQX30Hnvw4usroc9/9isBO3YOprQbbaRGj1sqX0Hi3auAx6WK1J9JOq1nXgcyJ3cvi9isw42YjlE/kh5/1CYDys4CvsDhM0W2EGx5IqKAeO3Q1/EBvKqGHZSvPU+6jsv2lfXYtzxHJhgddWdLIsGbf2ovVjA1wpXFvR2XaF8Olqiv2YUFBh8xEPH5X3SK4v56WWjRkWG5RKcVMAvSvgjjp15SGX/b21cwoi7yvFJ+ZsFHstGqXgmzDmICAOBch7UdMZvYhBarxYAkvHw6e7LJ2GXlBVU3nc5DhjYoqV7nfOLhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtoqaSySJL7+FIXcNFws7G/1LQnDLiWs7vAS7hT/M8U=;
 b=pRvUoyBI7fbErY5qSSZOeWN2EUZJg7Kqy9OJKCK9ZADs/OwFNeF2UW4yuMHqA9YZCrf61rrqEFE7AAgVXsPaS560JGAqac9fYyZyy4tySBh7sSRixoNE5rm6PtHIMvuOF8yJ1C72+PMCjUQ/FEGKlfulBugy/T68wVnGCF29oPU=
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com (2603:10a6:803:57::21)
 by VI1PR04MB4173.eurprd04.prod.outlook.com (2603:10a6:803:47::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.27; Tue, 13 Oct
 2020 02:02:32 +0000
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6]) by VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6%3]) with mapi id 15.20.3455.030; Tue, 13 Oct 2020
 02:02:32 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     David Laight <David.Laight@ACULAB.COM>,
        'Christoph Hellwig' <hch@infradead.org>
CC:     "sudeep.dutt@intel.com" <sudeep.dutt@intel.com>,
        "ashutosh.dixit@intel.com" <ashutosh.dixit@intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>, Andy Duan <fugang.duan@nxp.com>
Subject: RE: [PATCH V2 4/4] misc: vop: mapping kernel memory to user space as
 noncached
Thread-Topic: [PATCH V2 4/4] misc: vop: mapping kernel memory to user space as
 noncached
Thread-Index: AQHWljz7wk3xSbVt5k2cDIsd1UpdEql/ahaAgABWwICAFRK/UA==
Date:   Tue, 13 Oct 2020 02:02:32 +0000
Message-ID: <VI1PR04MB49601B933254E881097575CC92040@VI1PR04MB4960.eurprd04.prod.outlook.com>
References: <20200929084425.24052-1-sherry.sun@nxp.com>
 <20200929084425.24052-5-sherry.sun@nxp.com>
 <20200929102833.GD7784@infradead.org>
 <38d86b352ed6452ea225aa45e81af390@AcuMS.aculab.com>
In-Reply-To: <38d86b352ed6452ea225aa45e81af390@AcuMS.aculab.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ACULAB.COM; dkim=none (message not signed)
 header.d=none;ACULAB.COM; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b2864f49-f2f2-4f9e-5b8f-08d86f1c0c02
x-ms-traffictypediagnostic: VI1PR04MB4173:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB4173E86CAADBBB5CF6367C8392040@VI1PR04MB4173.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: opz3GkhiHhioHWk9cKXn8NV5Z2EwubzuYjV6E8BkCCham5JEZlyzk5bOEnqHfCnCTkUJRn+jGcei4LB328bjd3Kgv6SNjUlfX6ajlbX5n6yl9T0Sry11HqVQ8PSbQ9Sn7cN43gwR4Vszdvj/ezh3AYpXfTdYQjb3xXsBl9Yrf8JGdvc5YpmvYRNXRl09gQuoV/tbWCXqA0jEHCI8/MdQN+lKuPrsXlZPAzBtrs8wQ6ogUCokr5p3lakvC6nX9Av4FUqUgIbwoBurOER9tx/Fz1fMYM3wBTi/NxphQy4xcO6PuuQXSS9y05DBfBbPwTZnb4tg4gVrp8e8S5/DZKof08zfBjOzh1yg02yzUqK/woN+Sa8JmqsEM0KjKjTj+Q2QZzE2wUdWrn3oVl2fXtvNLg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4960.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(44832011)(316002)(110136005)(54906003)(52536014)(8676002)(83380400001)(7696005)(83080400001)(9686003)(8936002)(5660300002)(4326008)(76116006)(966005)(7416002)(55016002)(66446008)(64756008)(86362001)(66476007)(66556008)(45080400002)(33656002)(2906002)(6506007)(186003)(478600001)(26005)(71200400001)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 05P0411PJVM7m3aKYk73WwmbblKgnjHY7L75S+yy63wxx1oFkJNlzDH1JCrwweINhufGx8K9Zt4nBW2hVSFThRMIMJM3e/J1dm8aMaNGoHvHqeDbU8iQxGvPes1GvJl4f/8lD9Pz61vrEAbuyWrJLvyMrQ4XFiXHQnvHwtwmMFvnXcexwO1gmeP/yaYRGJWwd7PwtK4i+fwuEBGWowhWZuc9rXYQzcaby99wPrdfqStmPk9sG4C6Hp9r2/InRC2z7qqYe7cIC+/Yn6pwwO14NGnOrbuzEipXey6pmd6drFEwSa8IXzU4c4gVHvI+Drvey2VxXOxixoTSIkhkNlpQtrG6cTKmjd8PNXfatGdd2HX2Nmr6WceSU9N7hRZiUC1cESnt4sVwuDr1SgaLYIKqV89dkJcZwnEs/F86AmPFjx9NNbqBPxJVDWwdwh1nBZZA3rGD5piv0g40ZIMpaqXT+y3fdKeA8RVIlD3xyFFXYTYRA9D0PzbHSOyHaWvnKcn7pSlq79Hydz4R4C9u0innOddbiPq3iUVUfbBPjvQqIHZeh5I10bIIPDg+ifgNrA1ud/el1AAh63++SMMUA1YTS004doptctVJeJKV0upH9uIsT6g5ET+D1kndf6bVBMh3AHmNfvP8R0RT7tJJjSpQYg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4960.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2864f49-f2f2-4f9e-5b8f-08d86f1c0c02
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2020 02:02:32.2374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wwebkaBscqlAU2+be+4Kgp/p508fbazchW6s5jq2AU8Kvr5X+cbwiPHTHBA9rsUza6FYt3DrqR68ClY+6rfp6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4173
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgRGF2aWQsIHRoYW5rcyBmb3IgeW91ciBpbmZvcm1hdGlvbi4NCkhpIENocmlzdG9waCwgcGxl
YXNlIHNlZSBteSBjb21tZW50cyBiZWxvdy4NCg0KPiBTdWJqZWN0OiBSRTogW1BBVENIIFYyIDQv
NF0gbWlzYzogdm9wOiBtYXBwaW5nIGtlcm5lbCBtZW1vcnkgdG8gdXNlciBzcGFjZQ0KPiBhcyBu
b25jYWNoZWQNCj4gDQo+IEZyb206IENocmlzdG9waCBIZWxsd2lnDQo+ID4gU2VudDogMjkgU2Vw
dGVtYmVyIDIwMjAgMTE6MjkNCj4gLi4uDQo+ID4gWW91IGNhbid0IGNhbGwgcmVtYXBfcGZuX3Jh
bmdlIG9uIG1lbW9yeSByZXR1cm5lZCBmcm9tDQo+ID4gZG1hX2FsbG9jX2NvaGVyZW50ICh3aGlj
aCBidHcgaXMgbm90IG1hcmtlZCB1bmNhY2hlZCBvbiBtYW55DQo+IHBsYXRmb3JtcykuDQo+ID4N
Cj4gPiBZb3UgbmVlZCB0byB1c2UgdGhlIGRtYV9tbWFwX2NvaGVyZW50IGhlbHBlciBpbnN0ZWFk
Lg0KPiANCg0KSSB0cmllZCB0byB1c2UgZG1hX21tYXBfY29oZXJlbnQgaGVscGVyIGhlcmUsIGJ1
dCBJIG1ldCB0aGUgc2FtZSBwcm9ibGVtIGFzIERhdmlkIHNhaWQuDQpTaW5jZSB0aGUgdXNlciBz
cGFjZSBjYWxscyBtbWFwKCkgdG8gbWFwIGFsbCB0aGUgZGV2aWNlIHBhZ2UgYW5kIHZyaW5nIHNp
emUgYXQgb25lIHRpbWUuDQoNCiAgICAgdmEgPSBtbWFwKE5VTEwsIE1JQ19ERVZJQ0VfUEFHRV9F
TkQgKyB2cl9zaXplICogbnVtX3ZxLCBQUk9UX1JFQUQsIE1BUF9TSEFSRUQsIGZkLCAwKTsNCg0K
QnV0IHRoZSBwaHlzaWNhbCBhZGRyZXNzZXMgb2YgZGV2aWNlIHBhZ2UgYW5kIG11bHRpcGxlIHZy
aW5ncyBhcmUgbm90IGNvbnNlY3V0aXZlLCBzbyB3ZSBjYWxsZWQNCm11bHRpcGxlIHJlbWFwX3Bm
bl9yYW5nZSBiZWZvcmUuIFdoZW4gY2hhbmdpbmcgdG8gdXNlIGRtYV9tbWFwX2NvaGVyZW50LCBp
dCB3aWxsIHJldHVybiBlcnJvcg0KYmVjYXVzZSB2bWFfcGFnZXModGhlIHNpemUgdXNlciBzcGFj
ZSB3YW50IHRvIG1hcCkgYXJlIGJpZ2dlciB0aGFuIHRoZSBhY3R1YWwgc2l6ZSB3ZSBkbyBtdWx0
aXBsZQ0KbWFwKG9uZSBub24tY29udGludW91cyBtZW1vcnkgc2l6ZSBhdCBhIHRpbWUpLg0KDQpE
YXZpZCBiZWxpZXZlcyB0aGF0IHdlIGNvdWxkIG1vZGlmeSB0aGUgdm1fc3RhcnQgYWRkcmVzcyBi
ZWZvcmUgY2FsbCB0aGUgbXVsdGlwbGUgZG1hX21tYXBfY29oZXJlbnQgdG8NCmF2b2lkIHRoZSB2
bWFfcGFnZXMgY2hlY2sgZXJyb3IgYW5kIG1hcCBtdWx0aXBsZSBkaXNjb250aW51b3VzIG1lbW9y
eS4NCkRvIHlvdSBoYXZlIGFueSBzdWdnZXN0aW9ucz8NCg0KQmVzdCByZWdhcmRzDQpTaGVycnkN
Cg0KPiBIbW1tbS4gSSd2ZSBhIGRyaXZlciB0aGF0IGRvZXMgdGhhdC4NCj4gRm9ydHVuYXRlbHkg
aXQgb25seSBoYXMgdG8gd29yayBvbiB4ODYgd2hlcmUgaXQgZG9lc24ndCBtYXR0ZXIuDQo+IEhv
d2V2ZXIgSSBjYW4ndCBlYXNpbHkgY29udmVydCBpdC4NCj4gVGhlICdwcm9ibGVtJyBpcyB0aGF0
IHRoZSBtbWFwKCkgcmVxdWVzdCBjYW4gY292ZXIgbXVsdGlwbGUgZG1hIGJ1ZmZlcnMgYW5kDQo+
IG5lZWQgbm90IHN0YXJ0IGF0IHRoZSBiZWdpbm5pbmcgb2Ygb25lLg0KPiANCj4gQmFzaWNhbGx5
IHdlIGhhdmUgYSBQQ0llIGNhcmQgdGhhdCBoYXMgYW4gaW5idWlsdCBpb21tdSB0byBjb252ZXJ0
IGludGVybmFsDQo+IDMyYml0IGFkZHJlc3NlcyB0byA2NGJpdCBQQ0llIG9uZXMuDQo+IFRoaXMg
aGFzIDUxMiAxNmtCIHBhZ2VzLg0KPiBTbyB3ZSBkbyBhIG51bWJlciBvZiBkbWFfYWxsb2NfY29o
ZXJlbnQoKSBmb3IgMTZrIGJsb2Nrcy4NCj4gVGhlIHVzZXIgcHJvY2VzcyB0aGVuIGRvZXMgYW4g
bW1hcCgpIGZvciBwYXJ0IG9mIHRoZSBidWZmZXIuDQo+IFRoaXMgcmVxdWVzdCBpcyA0ayBhbGln
bmVkIHNvIHdlIGRvIG11bHRpcGxlIHJlbWFwX3Bmbl9yYW5nZSgpIGNhbGxzIHRvIG1hcA0KPiB0
aGUgZGlzam9pbnQgcGh5c2ljYWwgKGFuZCBrZXJuZWwgdmlydHVhbCkgYnVmZmVycyBpbnRvIGNv
bnRpZ3VvdXMgdXNlciBtZW1vcnkuDQo+IA0KPiBTbyBib3RoIGVuZHMgc2VlIGNvbnRpZ3VvdXMg
YWRkcmVzc2VzIGV2ZW4gdGhvdWdoIHRoZSBwaHlzaWNhbCBhZGRyZXNzZXMNCj4gYXJlIG5vbi1j
b250aWd1b3VzLg0KPiANCj4gSSBndWVzcyBJIGNvdWxkIG1vZGlmeSB0aGUgdm1fc3RhcnQgYWRk
cmVzcyBhbmQgdGhlbiByZXN0b3JlIGl0IGF0IHRoZSBlbmQuDQo+IA0KPiBJIGZvdW5kIHRoaXMg
YmlnIGRpc2N1c3Npb246DQo+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0
bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxvcmUuaw0KPiBlcm5lbC5vcmclMkZwYXRjaHdv
cmslMkZwYXRjaCUyRjM1MTI0NSUyRiZhbXA7ZGF0YT0wMiU3QzAxJTdDc2gNCj4gZXJyeS5zdW4l
NDBueHAuY29tJTdDODc2NzI0Njg5Njg4NDQwNTgxYTcwOGQ4NjQ4ZGNlYjMlN0M2ODZlYTFkDQo+
IDNiYzJiNGM2ZmE5MmNkOTljNWMzMDE2MzUlN0MwJTdDMCU3QzYzNzM2OTkwNzUxNjM3NjI5NCZh
bXA7c2RhdA0KPiBhPWFtU0NsUWZWR2hJMCUyRjNiWmZvOEhGN1VtQ2t0a1BsdUFyV1cyMllsUXpN
USUzRCZhbXA7cmVzZXINCj4gdmVkPTANCj4gYWJvdXQgdGhlc2UgZnVuY3Rpb25zLg0KPiANCj4g
VGhlIGJpdCBhYm91dCBWSVBUIGNhY2hlcyBpcyBwcm9ibGVtYXRpYy4NCj4gSSBkb24ndCB0aGlu
ayB5b3UgY2FuIGNoYW5nZSB0aGUga2VybmVsIGFkZHJlc3MgZHVyaW5nIG1tYXAuDQo+IFdoYXQg
eW91IG5lZWQgdG8gZG8gaXMgZGVmZXIgYWxsb2NhdGluZyB0aGUgdXNlciBhZGRyZXNzIHVudGls
IHlvdSBrbm93IHRoZQ0KPiBrZXJuZWwgYWRkcmVzcy4NCj4gT3RoZXJ3aXNlIHlvdSBnZXQgaW50
byBwcm9ibGVtcyBpcyB5b3UgdHJ5IHRvIG1tYXAgdGhlIHNhbWUgbWVtb3J5IGludG8NCj4gdHdv
IHByb2Nlc3Nlcy4NCj4gVGhpcyBpcyBhIGdlbmVyYWwgcHJvYmxlbSBldmVuIGZvciBtbWFwKCkg
b2YgZmlsZXMuDQo+IElTVFIgU1lTViBvbiBzb21lIHNwYXJjIHN5c3RlbXMgaGF2aW5nIHRvIHVz
ZSB1bmNhY2hlZCBtYXBzLg0KPiANCj4gSWYgeW91IG1pZ2h0IHdhbnQgdG8gbW1hcCB0d28ga2Vy
bmVsIGJ1ZmZlcnMgKGRtYSBvciBub3QpIGludG8gYWRqYWNlbnQNCj4gdXNlciBhZGRyZXNzZXMg
dGhlbiB5b3UgbmVlZCBzb21lIHdheSBvZiBhbGxvY2F0aW5nIHRoZSBzZWNvbmQgYnVmZmVyIHRv
DQo+IGZvbGxvdyB0aGUgZmlyc3Qgb25lIGluIHRoZSBWSVZUIGNhY2hlLg0KPiANCj4gCURhdmlk
DQo+IA0KPiAtDQo+IFJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBN
b3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLA0KPiBNSzEgMVBULCBVSyBSZWdpc3RyYXRpb24gTm86
IDEzOTczODYgKFdhbGVzKQ0KDQo=
