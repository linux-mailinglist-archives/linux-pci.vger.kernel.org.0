Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73B69198CB6
	for <lists+linux-pci@lfdr.de>; Tue, 31 Mar 2020 09:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729682AbgCaHKz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Mar 2020 03:10:55 -0400
Received: from mail-eopbgr1400091.outbound.protection.outlook.com ([40.107.140.91]:19757
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726001AbgCaHKz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 31 Mar 2020 03:10:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aAnLGC1WcApvKire/arP5TY06Rf//4knBVbCQvdH/jeL4llg22XVjtFthpLLDzw6HNXaO/qSAQqwdUynKk/xx9LVXyOmDBpj0+d6aL2l35N223Ytut9oJWprSB2v4EJsFvddfaFl+YpHtIoDTW9Kyftz0PIU30UdkPuRbU+psh1DEjn7wXP65saL477dVZoADdNjlwsNbWhrtY8BZXkVHT8EpjbslOVu6XaHlDTr3JhCWgW2U5Z7DTYJDno2ai36YqWGXvr6MJrBXydVWfqPcDnOnl0mLmf7l4+2yepCvxDS57j39nPcPgOcX+88/s1RbENwG4FyF2u5CSYhOZPnYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4tF1Wp8pGFayfIFyLVERgCpPRgkw9z90CAuioiLNoZc=;
 b=jH5UbBL4boZSAGFLZBSj5fwQL+QGG3/STSWc1C7McHBgtN4v/qcmA8GEpG90Djo7enwfuUFFa0RONmh5xVZAdKaPMHha4cZs+LvQwoJkwPL6+7wSaEPLLT1F0YziUPEhwzxTdliedPdtaw38lFmeHLgdqHS2wWY0yEU3PAggVvZO/rqlD5dsyMkAYRt/T0ObDNZouyUdisk/+1Oanrt/yskP2ygRHCrIyH7UiWXmS6o2Ly33NIsxf53peWWPz+VqRuQ0r305k7fQ7U9ABrgfG3RkhDs4M/SWxAwTG9yY/cpXB+JvPutY/20fA0vYDdGYSJ4LbUFVAYgfPbEUcvnX8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4tF1Wp8pGFayfIFyLVERgCpPRgkw9z90CAuioiLNoZc=;
 b=l+IXZoFoxIQ7cLEuxOwSXWS6VYtIDZttVZAfO1iisrZFbX+d6JbwFxi4W0uyxhvGZN6TntFZiu+p1cZli20mRZPFx05dO39NT56a6hTArFy7Ngcd3oad9q5QoypqCd009O0FXJn1wLcWE3zbVIcBKuyQzzpyIoOOwBSl1J0DODg=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
 TYAPR01MB4928.jpnprd01.prod.outlook.com (20.179.175.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.19; Tue, 31 Mar 2020 07:10:52 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::ed7f:1268:55a9:fc06]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::ed7f:1268:55a9:fc06%4]) with mapi id 15.20.2856.019; Tue, 31 Mar 2020
 07:10:52 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci <linux-pci@vger.kernel.org>
Subject: RE: PCIe EPF
Thread-Topic: PCIe EPF
Thread-Index: AQHV/Rm8Pc6E7UbBNUC7Q13GpqZQQKhQ9oaAgAK1PACAA1lugIAA1U4AgAaNB4CAAUQ/AIABb1+AgAATpYCAAAMegIAABzuAgAEWMpA=
Date:   Tue, 31 Mar 2020 07:10:52 +0000
Message-ID: <TYAPR01MB45446ABD97A846045FD2B896D8C80@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <CA+V-a8vOwwCjRnFZ_Cxtvep1nLMXd5AjOyJyispg1A1k_ExbSQ@mail.gmail.com>
 <e5570897-0566-6cce-9af2-8be23fb0d3ef@ti.com>
 <CA+V-a8ssdO9R_wHbJM8RinzP5d7YX5KWES20G-TV0XnCx4SUeA@mail.gmail.com>
 <83024641-7bd3-b47f-cd2c-0d831279086d@ti.com>
 <CA+V-a8sBC5+v+BsVSjkfLvYzddPs2jj1roFaDO4Tz4q9CWnGSg@mail.gmail.com>
 <CA+V-a8t15gotL1v-PRO1fGjL0WKTO2fOa69qZ5rctYn08XY=BA@mail.gmail.com>
 <CA+V-a8sNcdC8SO6pXGUH3TkM7B6dX-xxcqtZjRZ_496qyG1h+Q@mail.gmail.com>
 <60deaab7-fe56-0f30-a8bd-fbeea9224b11@ti.com>
 <CA+V-a8uxAD5-BovZPrKi_a6DPJVJPpez4V45C7YY-Rh3QjN8ag@mail.gmail.com>
 <e34a54f2-af3a-b760-c7d2-1da836e8fb4d@ti.com>
 <CA+V-a8t6WuBsMaW4WTCDHihUFv69WpwqJgOYH+rL7ndJ2NhrDQ@mail.gmail.com>
In-Reply-To: <CA+V-a8t6WuBsMaW4WTCDHihUFv69WpwqJgOYH+rL7ndJ2NhrDQ@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [124.210.22.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8a5d4753-d3d4-40cb-f9f2-08d7d542a5e9
x-ms-traffictypediagnostic: TYAPR01MB4928:
x-microsoft-antispam-prvs: <TYAPR01MB49283A0238A873A899416074D8C80@TYAPR01MB4928.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0359162B6D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB4544.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(52536014)(8676002)(8936002)(9686003)(2906002)(71200400001)(81166006)(33656002)(66476007)(64756008)(66946007)(81156014)(4326008)(55016002)(76116006)(66446008)(66556008)(316002)(7696005)(478600001)(110136005)(54906003)(5660300002)(55236004)(7116003)(86362001)(6506007)(186003)(3480700007)(26005);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0Or7jR89nbg8RSNeEfSpNCkqxAqc5f5tfokAfrQBtrOi3Ish6VgvbcOND8JO8aL6gCfc6Ui5BNg7zV+YQWpWKHt4I6Hvb3SbQ1K7iYuQ+aQQZSe9USBePQ8azEb1/Gsr7xoo7xYnv0SarKRuravWIGQvFczDwF6oV8R20CKj2/5fDwuIkRqQN5WzJC4Q1o8kPw1O4DQGY3w0aksPHqdoJlbimZMRmDDraiJ3zYMXf8HDgUQcCuKp0xnzNRrE0VKABRI1YqrTZ2JlUpLWFJV84pavm8vxxjVfXGzla2aO0yMFtjGBATz30c77S3nqJ0ZbVPT1Mrfa5R+FuGTTmiIEDHl63TnPZdS1jdfkEywhEvufAMW9p82pVsQRZGrxUD/FX2tPfnfqoph0mwaRfDUgvs2ydT8LDSYytRxrPNx8Vh2DRQCxB1bLtFUWU+P0sry0
x-ms-exchange-antispam-messagedata: qFy0OPLCSIG1q8o5ItCLpCUD8zm3znc/Mn9J5BPsDoariC06RHJ/3UtFaS57PlDzTUiEfn3XOKIuY15Rzgb4udxiALv2nltw1x8yh4d446GDxupwf3KuGIp7IXGo72Pcha+ap+pnXa2qBBh3ruqYTg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a5d4753-d3d4-40cb-f9f2-08d7d542a5e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2020 07:10:52.3387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XxWgSH/yPdggppzVx2d9a3wvYnMZXZJb3vfEu4FzmWZr5koaJ5z62Ax7wT2Cj42yTI7UcqxAwuSfNWFRkB+udmXuh6LK4F7/uy/vVDfHkBrhsFlP0j1J9aVjSSNgNUbO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4928
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgUHJhYmhha2FyLXNhbiwNCg0KPiBGcm9tOiBMYWQsIFByYWJoYWthciwgU2VudDogTW9uZGF5
LCBNYXJjaCAzMCwgMjAyMCAxMDo0NyBQTQ0KPHNuaXA+DQo+ID4gPiBBZ3JlZWQuIEJ1dCB3ZSBk
b24ndCBmbHVzaCBpbiBTVyB3aGVuIC1kIG9wdGlvbiBpcyBub3Qgc3BlY2lmaWVkIEkgYW0NCj4g
PiA+IGFzc3VtaW5nICB3aGVuIHdlIHVzDQo+ID4gPiAtZCBkbWEgZW5naW5lIHRha2VzIGNhcmUg
b2YgZmx1c2hpbmcgaXQuDQo+ID4NCj4gPiBUaGUgLWQgb3B0aW9uIHN3aXRjaCBkb2Vzbid0IGNo
YW5nZSBhbnl0aGluZyBvbiB0aGUgU1cgdGhhdCBydW5zIG9uIHRoZSBob3N0DQo+ID4gc2lkZSAo
bWlzYy9wY2ktZW5kcG9pbnQtdGVzdC5jKS4gVGhhdCBvbmx5IHRlbGxzIHRoZSBFUCB0byB1c2Ug
RE1BLg0KPiA+DQo+ID4gV2hlbiB5b3UgdXNlIHN0cmVhbWluZyBBUElzLCBkbWFfbWFwX3Npbmds
ZSgpLCBkbWFwX3VubWFwX3NpbmdsZSgpIHRha2VzIGNhcmUNCj4gPiBvZiBmbHVzaGluZyBvciBp
bnZhbGlkYXRpbmcgbWVtb3J5IGJhc2VkIG9uIHRoZSBwbGF0Zm9ybS4gKFBsYXRmb3JtcyB3aGlj
aCBoYXZlDQo+ID4gY29oZXJlbnQgbWVtb3J5IHdpbGwgaGF2ZSBkbWEtY29oZXJlbnQgcHJvcGVy
dHksDQo+ID4gZG1hX21hcF9zaW5nbGUoKS9kbWFwX3VubWFwX3NpbmdsZSgpIHdpbGwgbm90IGRv
IGZsdXNoIG9yIGludmFsaWRhdGUuDQo+ID4NCj4gTXkgYmFkLCBJIHRob3VnaHQgZG1hX3N5bmMq
KCkgY2FsbHMgZGlkIGl0Lg0KPiANCj4gU2hpbW9kYS1zYW4gZG8geW91IHNlZSBhbnkgcGxhdGZv
cm0gcmVzdHJpY3Rpb25zIHdoaWxlIHVzaW5nIHN0cmVhbWluZyBETUEgYXBpDQo+IGluc3RlYWQg
b2YgY29oZXJlbnQgbWVtb3J5LiBOb3RlIEkgdHJpZWQgdGhpcyBlbmFibGluZy9kaXNhYmxpbmcg
aXBtbXUNCj4gdG9vIGJ1dCB0aGUNCj4gcmVzdWx0cyBhcmUgdGhlIHNhbWUuDQoNCihVbilmb3J0
dW5hdGVseSwgSSBoYXZlIG5ldmVyIHJlcGxhY2VkIGNvaGVyZW50IG1lbW9yeSBBUEkgd2l0aCBz
dHJlYW0gRE1BIEFQSS4NCg0KPiA+IERpZCB5b3UgdHJ5IHRvIHByb2JlIHRoZSBmYWlsdXJlIGZ1
cnRoZXIgYnkgY29tcGFyaW5nIHRoZSBoZXhkdW1wcz8gV2hlcmUgZG9lcw0KPiA+IHRoZSBtaXNt
YXRjaCBoYXBwZW4/DQo+ID4NCj4gSSBzaGFsbCBkdW1wIHRoZSBtZW1vcnkgYW5kIGNoZWNrIHRo
ZSB2YWx1ZXMsIGJ1dCBiYXNpY2FsbHkgY3JjIGlzIGZhaWxpbmcuDQoNCkknbSBhbHNvIGludGVy
ZXN0aW5nIGFib3V0IGNvbXBhcmluZyB0aGUgaGV4ZHVtcCBiZXR3ZWVuIGhvc3QgYW5kIGVwLg0K
VGhpcyBpcyBteSBndXQgZmVlbGluZyB0aG91Z2gsIEknbSBndWVzc2luZyB0aGlzIGlzIGEgdGlt
aW5nIGlzc3VlDQpiZWNhdXNlIHVzaW5nIGNvaGVyZW50IG1lbW9yeSBBUEkgd2lsbCBiZSBvbiBu
b24tY2FjaGUgZXZlbiBpZiBDUFUgYWNjZXNzLA0KYnV0IHVzaW5nIHN0ZWFtaW5nIERNQSBBUEkg
d2lsbCBiZSBvbiBjYWNoZSBpZiBDUFUgYWNjZXNzIGJ5DQpkbWFfdW5tYXBfc2luZ2xlKERNQV9G
Uk9NX0RFVklDRSkgYW5kIGdldF9yYW5kb21fYnl0ZXMoKSBpbiBwY2lfZW5kcG9pbnRfdGVzdF93
cml0ZSgpLg0KDQpJZiBteSBndWVzcyBpcyBjb3JyZWN0LCBhbG1vc3QgYWxsIGhleGR1bXBzIGFy
ZSB0aGUgc2FtZSwgYnV0IGxhc3QNCnNvbWUgYnl0ZXMgKEknbSBub3Qgc3VyZSBob3cgbXVjaCBi
eXRlcyB0aG91Z2gpIGFyZSBub3QgbWF0Y2guDQoNCkJlc3QgcmVnYXJkcywNCllvc2hpaGlybyBT
aGltb2RhDQoNCg==
