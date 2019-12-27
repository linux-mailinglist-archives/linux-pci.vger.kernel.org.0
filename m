Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44CDF12B024
	for <lists+linux-pci@lfdr.de>; Fri, 27 Dec 2019 02:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbfL0BSO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Dec 2019 20:18:14 -0500
Received: from mail-bjbon0153.outbound.protection.partner.outlook.cn ([42.159.36.153]:61912
        "EHLO cn01-BJB-obe.outbound.protection.partner.outlook.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726193AbfL0BSO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 26 Dec 2019 20:18:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=panyiai.partner.onmschina.cn; s=selector1-panyiai-partner-onmschina-cn;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMpShgRLZyWd6u589EMzSqJVqBNHoOeAG1lQUVi8h8E=;
 b=BxDoiy6Ri+dyGZAWjf7dbuGIns0uC4087pliz3urenZQTZx8lz6YgMviAUjchtMM5ntz88wAOeXKYjVvIjwTsUqbALp9k1I+59zczE4fJ5irBIt28VOAMWr9Wfa4Vq5/sxcLKL4/+606hcZnrcT4Xq5IiDpoJ0UV4ZmbYc96ljg=
Received: from BJXPR01MB0534.CHNPR01.prod.partner.outlook.cn (10.43.32.81) by
 BJXPR01MB0536.CHNPR01.prod.partner.outlook.cn (10.43.32.83) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.11; Fri, 27 Dec 2019 01:18:04 +0000
Received: from BJXPR01MB0534.CHNPR01.prod.partner.outlook.cn ([10.43.32.81])
 by BJXPR01MB0534.CHNPR01.prod.partner.outlook.cn ([10.43.32.81]) with mapi id
 15.20.2581.007; Fri, 27 Dec 2019 01:18:04 +0000
From:   Renjun Wang <rwang@panyi.ai>
To:     Keith Busch <kbusch@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: =?utf-8?B?5Zue5aSNOiBQUk9CTEVNOiBwY2lfYWxsb2NfaXJxX3ZlY3RvcnMgZnVuY3Rp?=
 =?utf-8?B?b24gcmVxdWVzdCAzMiBNU0kgaW50ZXJydXB0cyB2ZWN0b3JzLCBidXQgcmV0?=
 =?utf-8?Q?urn_1_in_KVM_virtual_machine.?=
Thread-Topic: PROBLEM: pci_alloc_irq_vectors function request 32 MSI
 interrupts vectors, but return 1 in KVM virtual machine.
Thread-Index: AQHVusNDElPM46dTzEOgovdUi3IOYafMmUmAgACUOPA=
Date:   Fri, 27 Dec 2019 01:18:04 +0000
Message-ID: <BJXPR01MB0534558D105A21EFAFA3EFC8DE2A0@BJXPR01MB0534.CHNPR01.prod.partner.outlook.cn>
References: <BJXPR01MB053429F1D6CD8E31B55D9D80DE280@BJXPR01MB0534.CHNPR01.prod.partner.outlook.cn>
 <20191226161327.GA35073@dhcp-10-100-145-180.wdl.wdc.com>
In-Reply-To: <20191226161327.GA35073@dhcp-10-100-145-180.wdl.wdc.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is ) smtp.mailfrom=rwang@panyi.ai; 
x-originating-ip: [182.150.24.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae01cad5-5bb5-4e1d-0056-08d78a6a9f8b
x-ms-traffictypediagnostic: BJXPR01MB0536:
x-microsoft-antispam-prvs: <BJXPR01MB0536330F4E23DE90824AE449DE2A0@BJXPR01MB0536.CHNPR01.prod.partner.outlook.cn>
x-forefront-prvs: 0264FEA5C3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39830400003)(396003)(376002)(328002)(329002)(199004)(189003)(71190400001)(71200400001)(8936002)(5660300002)(86362001)(95416001)(76176011)(9686003)(81156014)(476003)(2906002)(486006)(33656002)(6306002)(7696005)(55016002)(316002)(305945005)(59450400001)(66476007)(66066001)(14454004)(966005)(66946007)(4326008)(76116006)(11346002)(66446008)(64756008)(63696004)(446003)(6116002)(3846002)(66556008)(102836004)(224303003)(186003)(7736002)(478600001)(26005)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:BJXPR01MB0536;H:BJXPR01MB0534.CHNPR01.prod.partner.outlook.cn;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:3;
received-spf: None (protection.outlook.com: panyi.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /0EY9mQ1vBbzAyIN4fDjuSMWuo0M+QzdT0Y7Dic5HJnAAGwEfozJ9TuqbYzG86piE7LE1M9r/eazx7CfVZtQ2lhc/u0gHLXvV7vJEbZmbhlpnCLrQmR6ykxCsBd/PuKbmPZJHECKPaw6ywnipwo4jrv+BmkSKK/RiiQ7csZfN4NZ0Mf4Q8v+PUIpkKxxFPLhSgidHKY2amO8QcD24kp6J7nv4RDjUGhOeIz+xkqHypS7xzkYUOuLz/9hr5+0wePPsp9lHLJkBVLKisIa0h952JsPspAU2QDsgmi5yKof2/WXQ7ytkkXCkF6lAel6KEWgVR95ZXZMsCP55kYzDG8NDxz6ZvPVZmTec2AHhQ0PBOFjQXSXNtKJD9VFC25zsmm9c431iDaY3LdBy1vyuIzm6LhySGQLZXLDVBETdUoue21nabNJ6/y1adlOEFkIBG/lmaw55pOSjzfCWxcPyThYJ8BE5TX95Rp9ytxBgBLF8yc=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: panyi.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: ae01cad5-5bb5-4e1d-0056-08d78a6a9f8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2019 01:18:04.1719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ce39a546-bdfb-4992-b21b-9a56b068e472
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m9YwoeZArpEVrD001CmbfmjwLVmadCPELd4HAIYEIm8wGzT02wZC9vBj0DEn/DEr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0536
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgS2VpdGgsIHRoYW5rcyBmb3IgeW91ciByZXNwb25zZS4NClRoZSBmbGFnIGZvciBwY2lfYWxs
b2NfaXJxX3ZlY3RvcnMoKSBmdW5jdGlvbiBpcyAiUENJX0lSUV9NU0kgfCBQQ0lfSVJRX0FGRklO
SVRZIiwgYW5kIG5vdCBpbmNsdWRlICJQQ0lfSVJRX01JU1giIHdoaWNoIG5vdCBzdXBwb3J0ZWQg
Zm9yIG15IFBJQ2UgZGV2aWNlIGN1cnJlbnRseS4gDQpUaGUgdkNQVSBzZXR0aW5nIGZvciB1YnVu
dHUgdmlydHVhbCBtYWNoaW5lIGlzIDggdkNQVSgxIHNvY2tldCwgNCBjb3JlcywgMiB0aHJlYWRz
KS4gDQpBbmQgdGhlIGtlcm5lbCBjb25maWd1cmUgb3B0aW9uICJDT05GSUdfSVJRX1JFTUFQIiBh
cmUgZW5hYmxlZCBmb3IgdGhlIHVidW50dSBndWVzdCBhbmQgS1ZNIGhvc3QgbWFjaGluZS4gSXMg
dGhlcmUgYW55IG90aGVyIGNvbnN0cmFpbnTvvJ8NCg0KLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0K
5Y+R5Lu25Lq6OiBsaW51eC1wY2ktb3duZXJAdmdlci5rZXJuZWwub3JnIDxsaW51eC1wY2ktb3du
ZXJAdmdlci5rZXJuZWwub3JnPiDku6PooaggS2VpdGggQnVzY2gNCuWPkemAgeaXtumXtDogMjAx
OeW5tDEy5pyIMjfml6UgMDoxMw0K5pS25Lu25Lq6OiBSZW5qdW4gV2FuZyA8cndhbmdAcGFueWku
YWk+DQrmioTpgIE6IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmcNCuS4u+mimDogUmU6IFBST0JM
RU06IHBjaV9hbGxvY19pcnFfdmVjdG9ycyBmdW5jdGlvbiByZXF1ZXN0IDMyIE1TSSBpbnRlcnJ1
cHRzIHZlY3RvcnMsIGJ1dCByZXR1cm4gMSBpbiBLVk0gdmlydHVhbCBtYWNoaW5lLg0KDQpPbiBX
ZWQsIERlYyAyNSwgMjAxOSBhdCAwMTozNDoyNkFNICswMDAwLCBSZW5qdW4gV2FuZyB3cm90ZToN
Cj4gSSBoYXZlIGEgdmlydHVhbCBtYWNoaW5lIHdpdGggdWJ1bnR1IDE2LjQuMDPCoCBvbiBLVk0g
cGxhdGZvcm0uIFRoZXJlIA0KPiBpcyBhIFBDSWUgZGV2aWNlKFhpbGlueCBQQ0llIElQKSBwbHVn
Z2VkIGluIHRoZSBob3N0IG1hY2hpbmUuDQo+DQo+IE9uIHRoZSB1YnVudHUgb3BlcmF0aW9uIHN5
c3RlbSwgSSBhbSBkZXZlbG9waW5nIHRoZSBwY2llIGRyaXZlci4gV2hlbiANCj4gSSB1c2UgcGNp
X2FsbG9jX2lycV92ZWN0b3JzKCkgZnVuY3Rpb24gdG8gYWxsb2NhdGUgMzIgbXNpIHZlY3RvcnMs
IGJ1dCANCj4gcmV0dXJuIDEuDQo+DQo+IFRoZSBjb21tYW5kwqAgYGxzcGNpIC12dnZgIG91dHB1
dCBzaG93cw0KPiBNU0k6IEVuYWJsZSsgQ291bnQ9MS8zMiBNYXNrYWJsZSsgNjRiaXQrDQo+IA0K
PiANCj4gdGhlcmUgaXMgYSBzaW1pbGFyIGNhc2UgaHR0cHM6Ly9zdGFja292ZXJmbG93LmNvbS9x
dWVzdGlvbnMvNDk4MjE1OTkvbXVsdGlwbGUtbXNpLXZlY3RvcnMtbGludXgtcGNpLWFsbG9jLWly
cS12ZWN0b3JzLXJldHVybi1vbmUtd2hpbGUtdGhlLWRldmkuDQo+IEJ1dCBub3Qgd29ya2luZyBm
b3IgS1ZNIHZpcnR1YWwgbWFjaGluZS4NCj4gDQo+IEkgZG8gbm90IGtub3duIHdoeSB0aGUgZnVu
Y3Rpb27CoCBwY2lfYWxsb2NfaXJxX3ZlY3RvcnMoKSByZXR1cm5zIG9uZSA/DQoNCkFyZSB5b3Ug
c2V0dGluZyB0aGUgIlBDSV9JUlFfQUZGSU5JVFkiIGZsYWcgaW4geW91ciBhbGxvYyBjYWxsIGxp
a2UgaW4geW91ciBzdGFja292ZXJmbG93IGxpbms/IElmIHNvLCBob3cgbWFueSBDUFVzIGRvZXMg
eW91ciB2aXJ0dWFsIG1hY2hpbmUgaGF2ZT8NCg==
