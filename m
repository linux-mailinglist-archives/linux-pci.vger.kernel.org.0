Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE142932B3
	for <lists+linux-pci@lfdr.de>; Tue, 20 Oct 2020 03:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390048AbgJTBdZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Oct 2020 21:33:25 -0400
Received: from mail-vi1eur05on2047.outbound.protection.outlook.com ([40.107.21.47]:4984
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728778AbgJTBdZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 19 Oct 2020 21:33:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cGO1KEJhDTGQtM3Bq/z3nY0eOc6HLJTc+LCVRzLYgYQeZLlRUn006dkJNR4yWk/pjplTmCDtzT+z9qkArjeYRoUK6Yy4NiVlZIVn6TwDNJopEKuI2ChWAEL1CcZXeIZYly/nlgiXnj4OkfKyVEOp7lugru63YHJ52oQ+MGPYkf2Brfrw78LVXzhxq8bJzZcrGniPP1q91s36johTkBEHSRqgx+uLIkqPq7GdAAIcWRMgp4U17EkkXFPyRlN5p8P5j6fOcdSgPr2q/4RGjpETp1j16c+FjIjLEit5FLhZvBFTgK32liqmtO6sOjRRKqDXYDD/LUCPKTLX6Vd0ACwGyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/t1ZNjd5ZIxRofHdahSn4htPF0lD8rmJBx8KVFPWf4=;
 b=oeaRbOO4nXPPlEAnXWJDZHcwseUkpg7G2w0NPUSGIjTaCkBmDmUjPut9vUW5+gdYlHSWep1bWMxN5JvJYv2w9gehWeehcWvbBmyqv2ysDKKtKbWwvW12tVMgHQfl03YbEYCgjSQR1LVyLRCvNGuA87DyJZAYe+OYw61IkWXSa5sCZFLrw9XeiDCl0YomAYbt0RFEpfcLA7+rdnSF/4spMY6zABIQslacgJ+LIQYyZoExnJI32W0jF/T+RRwZFXeFACoFkfr3+abCdqwT+AIBvVkaQijmBwXyth08aJlTPzD4JBxCoNmVIBd3hX3ZYUu7VP+IVuivp1kzLtsG0vko6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/t1ZNjd5ZIxRofHdahSn4htPF0lD8rmJBx8KVFPWf4=;
 b=HQBITc+7ZhWmPkrFmNVgLHyg5EKThkSDL8Ktg2HsZmdOTGbAOj34jAlN+cyB0ntkTQ0WJLRT/vr/byjUfleE/DrMjs434zwKA1p2yM/LoeiW9PWQA3DRTls+3rEdVwVu/B83+V0AZkil8dUPf+/ZUmY0QApYHl338SpVqyCNRJ4=
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com (2603:10a6:803:57::21)
 by VE1PR04MB7279.eurprd04.prod.outlook.com (2603:10a6:800:1a5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.27; Tue, 20 Oct
 2020 01:33:21 +0000
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6]) by VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6%3]) with mapi id 15.20.3477.028; Tue, 20 Oct 2020
 01:33:21 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     'Christoph Hellwig' <hch@infradead.org>
CC:     "sudeep.dutt@intel.com" <sudeep.dutt@intel.com>,
        "ashutosh.dixit@intel.com" <ashutosh.dixit@intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Andy Duan <fugang.duan@nxp.com>,
        David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH V2 4/4] misc: vop: mapping kernel memory to user space as
 noncached
Thread-Topic: [PATCH V2 4/4] misc: vop: mapping kernel memory to user space as
 noncached
Thread-Index: AQHWljz7wk3xSbVt5k2cDIsd1UpdEql/ahaAgABWwICAFRK/UIALAJZA
Date:   Tue, 20 Oct 2020 01:33:20 +0000
Message-ID: <VI1PR04MB49605610DD1D4983EAB0EC67921F0@VI1PR04MB4960.eurprd04.prod.outlook.com>
References: <20200929084425.24052-1-sherry.sun@nxp.com>
 <20200929084425.24052-5-sherry.sun@nxp.com>
 <20200929102833.GD7784@infradead.org>
 <38d86b352ed6452ea225aa45e81af390@AcuMS.aculab.com>
 <VI1PR04MB49601B933254E881097575CC92040@VI1PR04MB4960.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB49601B933254E881097575CC92040@VI1PR04MB4960.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2fe7fccc-d11e-4215-4a4e-08d8749820fa
x-ms-traffictypediagnostic: VE1PR04MB7279:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB7279FBF089499C4BA04B362B921F0@VE1PR04MB7279.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DjGiYjxog1Um5BnDkCXVLKa0Y8+J5EDCKBfEpCqgYyILtBUrW2xtsbYcWS5eZUJxiLZPeAuChim/j6Qoivf0P6E++NSbLYI8Y/JgKSGZYZkvWtv31jb787+5NH86qYzhcCu5JTNT31yiEkl6zr3oZfcdopxtJ1UrZ7tAwiyq2qvB7B3B+WRIE4Qrz5ziZ+GvHXskVTzaKLPrhkNk7XZdjAcagXKScQj0IodZfLbNtV33pcP26QjfvdLxHdYUykrU3QISBm5sVv8AnBbDQOgqcuShhyl2MzndIFv4xv6Q+Etq187EGeNNJrpgsOxUdVg7Vur8wm2l+kou3EcWuxkuyrVq+sRM6M2wf/qA+Ro5tUIrdGvEFtbxHMoQFcJkUZYIL+q04iRDNiSdS32TXWyJnA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4960.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(39860400002)(346002)(136003)(4326008)(9686003)(76116006)(2906002)(66446008)(66946007)(66556008)(66476007)(64756008)(7416002)(478600001)(52536014)(6916009)(966005)(5660300002)(45080400002)(44832011)(54906003)(6506007)(316002)(33656002)(8676002)(83380400001)(8936002)(55016002)(86362001)(71200400001)(26005)(186003)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: G3mF3usE1BPBqFhKT5p/o7fwVustgsj7DbhX8A4Y8Sb5vBreC45GdwShG8RSMiN+bv3cABCUEtWjjw26TdfE9HB7eZJHQVJx91YpNTbTPhpAH34Dajnv/HFehqfBO/qYUNwQRPHOeue1gBvB8V4LG/kSfgf04D/g/rnimyLF1YjW/RBzx4W/WnzkhwI9UGPE3OtX/VXFZZuXWb00BL4TmSBjW2dAGG9L8IB0bjg6h+dP8Qp/YItp+IeMjQEwZ9vMOUyJqWQ46/v8gdNM+25H4aylUXC8nXUk6YdvSroecPh5FT1uW9xobObWxAUkHR9s55QluNkwNKk5nXcXzaza1m1s16OSMsD4GunZ7u1oVNqSckZlJyI9D/Q0YlPLR42FK+13hOHswj5X3/EO4Wsg93wug/mtlg6pIoeqthSn5HgYfl6/24q0OvsHeDt4+CNj7prJDzc6ISuMIPMGvnOjYeywLYzhBL2c2HvkRi3XqQ6ktkD5BDa6OwJ1VlPWv2imIJxGzjJV+n9S531NY3pF/SQyj08DwKySwf36GaDAOfVF0/UwZ7Xf95Wg/UeFMkO9vC4GmIig5B4pZ33zJZDh6x5QCfTMgIFusAmKbUrkdmUM/4rUV3FsJQ/awMxbOXU6gnCVHOP9r7Lgs1Yd7u7VVQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4960.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fe7fccc-d11e-4215-4a4e-08d8749820fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2020 01:33:20.9060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yr433xikY42oHwY8Bs0ShCQXO/DpGQjYpG2s/B9qcx+eRTYku6R/jYnC4KWWkx+2EtPtJA0Or0YQRSub/nMyTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7279
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgQ2hyaXN0b3BoLA0KDQpHZW50bGUgcGluZy4uLi4NCg0KQ2FuIHlvdSBnaXZlIHNvbWUgc3Vn
Z2VzdGlvbnMgb24gdGhlIGxpbWl0YXRpb25zIG9mIGRtYV9tbWFwX2NvaGVyZW50IGFwaT8NCg0K
QmVzdCByZWdhcmRzDQpTaGVycnkNCg0KPiBTdWJqZWN0OiBSRTogW1BBVENIIFYyIDQvNF0gbWlz
Yzogdm9wOiBtYXBwaW5nIGtlcm5lbCBtZW1vcnkgdG8gdXNlciBzcGFjZQ0KPiBhcyBub25jYWNo
ZWQNCj4gDQo+IEhpIERhdmlkLCB0aGFua3MgZm9yIHlvdXIgaW5mb3JtYXRpb24uDQo+IEhpIENo
cmlzdG9waCwgcGxlYXNlIHNlZSBteSBjb21tZW50cyBiZWxvdy4NCj4gDQo+ID4gU3ViamVjdDog
UkU6IFtQQVRDSCBWMiA0LzRdIG1pc2M6IHZvcDogbWFwcGluZyBrZXJuZWwgbWVtb3J5IHRvIHVz
ZXINCj4gPiBzcGFjZSBhcyBub25jYWNoZWQNCj4gPg0KPiA+IEZyb206IENocmlzdG9waCBIZWxs
d2lnDQo+ID4gPiBTZW50OiAyOSBTZXB0ZW1iZXIgMjAyMCAxMToyOQ0KPiA+IC4uLg0KPiA+ID4g
WW91IGNhbid0IGNhbGwgcmVtYXBfcGZuX3JhbmdlIG9uIG1lbW9yeSByZXR1cm5lZCBmcm9tDQo+
ID4gPiBkbWFfYWxsb2NfY29oZXJlbnQgKHdoaWNoIGJ0dyBpcyBub3QgbWFya2VkIHVuY2FjaGVk
IG9uIG1hbnkNCj4gPiBwbGF0Zm9ybXMpLg0KPiA+ID4NCj4gPiA+IFlvdSBuZWVkIHRvIHVzZSB0
aGUgZG1hX21tYXBfY29oZXJlbnQgaGVscGVyIGluc3RlYWQuDQo+ID4NCj4gDQo+IEkgdHJpZWQg
dG8gdXNlIGRtYV9tbWFwX2NvaGVyZW50IGhlbHBlciBoZXJlLCBidXQgSSBtZXQgdGhlIHNhbWUg
cHJvYmxlbQ0KPiBhcyBEYXZpZCBzYWlkLg0KPiBTaW5jZSB0aGUgdXNlciBzcGFjZSBjYWxscyBt
bWFwKCkgdG8gbWFwIGFsbCB0aGUgZGV2aWNlIHBhZ2UgYW5kIHZyaW5nIHNpemUgYXQNCj4gb25l
IHRpbWUuDQo+IA0KPiAgICAgIHZhID0gbW1hcChOVUxMLCBNSUNfREVWSUNFX1BBR0VfRU5EICsg
dnJfc2l6ZSAqIG51bV92cSwNCj4gUFJPVF9SRUFELCBNQVBfU0hBUkVELCBmZCwgMCk7DQo+IA0K
PiBCdXQgdGhlIHBoeXNpY2FsIGFkZHJlc3NlcyBvZiBkZXZpY2UgcGFnZSBhbmQgbXVsdGlwbGUg
dnJpbmdzIGFyZSBub3QNCj4gY29uc2VjdXRpdmUsIHNvIHdlIGNhbGxlZCBtdWx0aXBsZSByZW1h
cF9wZm5fcmFuZ2UgYmVmb3JlLiBXaGVuIGNoYW5naW5nDQo+IHRvIHVzZSBkbWFfbW1hcF9jb2hl
cmVudCwgaXQgd2lsbCByZXR1cm4gZXJyb3IgYmVjYXVzZSB2bWFfcGFnZXModGhlIHNpemUNCj4g
dXNlciBzcGFjZSB3YW50IHRvIG1hcCkgYXJlIGJpZ2dlciB0aGFuIHRoZSBhY3R1YWwgc2l6ZSB3
ZSBkbyBtdWx0aXBsZQ0KPiBtYXAob25lIG5vbi1jb250aW51b3VzIG1lbW9yeSBzaXplIGF0IGEg
dGltZSkuDQo+IA0KPiBEYXZpZCBiZWxpZXZlcyB0aGF0IHdlIGNvdWxkIG1vZGlmeSB0aGUgdm1f
c3RhcnQgYWRkcmVzcyBiZWZvcmUgY2FsbCB0aGUNCj4gbXVsdGlwbGUgZG1hX21tYXBfY29oZXJl
bnQgdG8gYXZvaWQgdGhlIHZtYV9wYWdlcyBjaGVjayBlcnJvciBhbmQgbWFwDQo+IG11bHRpcGxl
IGRpc2NvbnRpbnVvdXMgbWVtb3J5Lg0KPiBEbyB5b3UgaGF2ZSBhbnkgc3VnZ2VzdGlvbnM/DQo+
IA0KPiBCZXN0IHJlZ2FyZHMNCj4gU2hlcnJ5DQo+IA0KPiA+IEhtbW1tLiBJJ3ZlIGEgZHJpdmVy
IHRoYXQgZG9lcyB0aGF0Lg0KPiA+IEZvcnR1bmF0ZWx5IGl0IG9ubHkgaGFzIHRvIHdvcmsgb24g
eDg2IHdoZXJlIGl0IGRvZXNuJ3QgbWF0dGVyLg0KPiA+IEhvd2V2ZXIgSSBjYW4ndCBlYXNpbHkg
Y29udmVydCBpdC4NCj4gPiBUaGUgJ3Byb2JsZW0nIGlzIHRoYXQgdGhlIG1tYXAoKSByZXF1ZXN0
IGNhbiBjb3ZlciBtdWx0aXBsZSBkbWENCj4gPiBidWZmZXJzIGFuZCBuZWVkIG5vdCBzdGFydCBh
dCB0aGUgYmVnaW5uaW5nIG9mIG9uZS4NCj4gPg0KPiA+IEJhc2ljYWxseSB3ZSBoYXZlIGEgUENJ
ZSBjYXJkIHRoYXQgaGFzIGFuIGluYnVpbHQgaW9tbXUgdG8gY29udmVydA0KPiA+IGludGVybmFs
IDMyYml0IGFkZHJlc3NlcyB0byA2NGJpdCBQQ0llIG9uZXMuDQo+ID4gVGhpcyBoYXMgNTEyIDE2
a0IgcGFnZXMuDQo+ID4gU28gd2UgZG8gYSBudW1iZXIgb2YgZG1hX2FsbG9jX2NvaGVyZW50KCkg
Zm9yIDE2ayBibG9ja3MuDQo+ID4gVGhlIHVzZXIgcHJvY2VzcyB0aGVuIGRvZXMgYW4gbW1hcCgp
IGZvciBwYXJ0IG9mIHRoZSBidWZmZXIuDQo+ID4gVGhpcyByZXF1ZXN0IGlzIDRrIGFsaWduZWQg
c28gd2UgZG8gbXVsdGlwbGUgcmVtYXBfcGZuX3JhbmdlKCkgY2FsbHMNCj4gPiB0byBtYXAgdGhl
IGRpc2pvaW50IHBoeXNpY2FsIChhbmQga2VybmVsIHZpcnR1YWwpIGJ1ZmZlcnMgaW50byBjb250
aWd1b3VzDQo+IHVzZXIgbWVtb3J5Lg0KPiA+DQo+ID4gU28gYm90aCBlbmRzIHNlZSBjb250aWd1
b3VzIGFkZHJlc3NlcyBldmVuIHRob3VnaCB0aGUgcGh5c2ljYWwNCj4gPiBhZGRyZXNzZXMgYXJl
IG5vbi1jb250aWd1b3VzLg0KPiA+DQo+ID4gSSBndWVzcyBJIGNvdWxkIG1vZGlmeSB0aGUgdm1f
c3RhcnQgYWRkcmVzcyBhbmQgdGhlbiByZXN0b3JlIGl0IGF0IHRoZSBlbmQuDQo+ID4NCj4gPiBJ
IGZvdW5kIHRoaXMgYmlnIGRpc2N1c3Npb246DQo+ID4gaHR0cHM6Ly9ldXIwMS5zYWZlbGlua3Mu
cHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbG9yZQ0KPiA+IC5rDQo+
IGVybmVsLm9yZyUyRnBhdGNod29yayUyRnBhdGNoJTJGMzUxMjQ1JTJGJmFtcDtkYXRhPTAyJTdD
MDElN0NzaA0KPiA+DQo+IGVycnkuc3VuJTQwbnhwLmNvbSU3Qzg3NjcyNDY4OTY4ODQ0MDU4MWE3
MDhkODY0OGRjZWIzJTdDNjg2ZWExZA0KPiA+DQo+IDNiYzJiNGM2ZmE5MmNkOTljNWMzMDE2MzUl
N0MwJTdDMCU3QzYzNzM2OTkwNzUxNjM3NjI5NCZhbXA7c2RhdA0KPiA+DQo+IGE9YW1TQ2xRZlZH
aEkwJTJGM2JaZm84SEY3VW1Da3RrUGx1QXJXVzIyWWxRek1RJTNEJmFtcDtyZXNlcg0KPiA+IHZl
ZD0wDQo+ID4gYWJvdXQgdGhlc2UgZnVuY3Rpb25zLg0KPiA+DQo+ID4gVGhlIGJpdCBhYm91dCBW
SVBUIGNhY2hlcyBpcyBwcm9ibGVtYXRpYy4NCj4gPiBJIGRvbid0IHRoaW5rIHlvdSBjYW4gY2hh
bmdlIHRoZSBrZXJuZWwgYWRkcmVzcyBkdXJpbmcgbW1hcC4NCj4gPiBXaGF0IHlvdSBuZWVkIHRv
IGRvIGlzIGRlZmVyIGFsbG9jYXRpbmcgdGhlIHVzZXIgYWRkcmVzcyB1bnRpbCB5b3UNCj4gPiBr
bm93IHRoZSBrZXJuZWwgYWRkcmVzcy4NCj4gPiBPdGhlcndpc2UgeW91IGdldCBpbnRvIHByb2Js
ZW1zIGlzIHlvdSB0cnkgdG8gbW1hcCB0aGUgc2FtZSBtZW1vcnkNCj4gPiBpbnRvIHR3byBwcm9j
ZXNzZXMuDQo+ID4gVGhpcyBpcyBhIGdlbmVyYWwgcHJvYmxlbSBldmVuIGZvciBtbWFwKCkgb2Yg
ZmlsZXMuDQo+ID4gSVNUUiBTWVNWIG9uIHNvbWUgc3BhcmMgc3lzdGVtcyBoYXZpbmcgdG8gdXNl
IHVuY2FjaGVkIG1hcHMuDQo+ID4NCj4gPiBJZiB5b3UgbWlnaHQgd2FudCB0byBtbWFwIHR3byBr
ZXJuZWwgYnVmZmVycyAoZG1hIG9yIG5vdCkgaW50bw0KPiA+IGFkamFjZW50IHVzZXIgYWRkcmVz
c2VzIHRoZW4geW91IG5lZWQgc29tZSB3YXkgb2YgYWxsb2NhdGluZyB0aGUNCj4gPiBzZWNvbmQg
YnVmZmVyIHRvIGZvbGxvdyB0aGUgZmlyc3Qgb25lIGluIHRoZSBWSVZUIGNhY2hlLg0KPiA+DQo+
ID4gCURhdmlkDQo+ID4NCj4gPiAtDQo+ID4gUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBC
cmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsDQo+ID4gTUsxIDFQVCwgVUsg
UmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg0K
