Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81E4E279E5E
	for <lists+linux-pci@lfdr.de>; Sun, 27 Sep 2020 07:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbgI0FH6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Sep 2020 01:07:58 -0400
Received: from mail-eopbgr10057.outbound.protection.outlook.com ([40.107.1.57]:32277
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726478AbgI0FH6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 27 Sep 2020 01:07:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FlQt0eOVkm0/SMTCEM62MJhtsSLS02DuHqzPQ4UlK6rxYF38T2v+vj6BwCp3opzC2wuzIgYjqXY+lwzscq2Sk8lSLn67lPU7GDsb+ugpfeCbLRsAjDqVQFh+aMdfjCitN//1FmNP0FByLkk42WoOw5VNMZnLa5ixxptoh1b8buu1W0yC3dSDJDiFmQ4l6D/usMIit0txxPDok1QR3adxFVpr8iIbOgpybhde0hywfekjIhtyJfO6+ZjI1MqFaD4TzEKQj/ZpRB4NvupROdKzYJs5vo6Kqhyrp+b/F8syrim3EECw3cmmSTstextGWWHHGJ+lDiCWYJcL8KNcgsFSDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXgmCYDWyeH8w8zhWl5uJvVLoWijTHcslnY8W4Q8gV8=;
 b=iGzt3U2+1qpQbOMoAfbg88T86GdlCYQJQ/nLje+X8Zr+H0q1Za+QZNEqZL/hETokSTY3dKUBbjMpHY49gntogSu7TvCER7ccNXzRvt76PRVaJGkROKCMum0fK4h+lwR3TSLpksb65NWwIlISEvJT2JOo15p7QoOAZTU81x1G8x1YBAlb7hd9pdcIR2f2zwfrzQWhX2Iun/HOtdDqaovpbCkzO0OA03udp2k/GR6mls+U3uvtkH2Mwl3cLrt0/lMEjsrvSMnV4fNNQSBhMpSWobwbwBQyQRd6Z410twWSTG29Kspwy94GwvJnYlJbZiBgHb0x4BLGqtimbJzzFkgoEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXgmCYDWyeH8w8zhWl5uJvVLoWijTHcslnY8W4Q8gV8=;
 b=ndMvVrrrfBRVyrxIAGNozbdkV9AjVRKuHDOFvAHTtbUYVvQo96LCT3F4WD5NVIG14BFygQxfoFT+Hyc+bg9jGdKbppbtC+blMc0K7eDoS48IwXuKuG3xDoIBBTWKagPZZVgCGTyMrIzBT5wyPEsJYZlYQDi17UOXmjajHSbP8Wk=
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com (2603:10a6:803:57::21)
 by VE1PR04MB6525.eurprd04.prod.outlook.com (2603:10a6:803:120::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Sun, 27 Sep
 2020 05:07:52 +0000
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6]) by VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6%3]) with mapi id 15.20.3412.024; Sun, 27 Sep 2020
 05:07:52 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        gregkh <gregkh@linuxfoundation.org>,
        "wang.yi59@zte.com.cn" <wang.yi59@zte.com.cn>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>
Subject: RE: [PATCH 0/5] Add noncoherent platform support for vop driver
Thread-Topic: [PATCH 0/5] Add noncoherent platform support for vop driver
Thread-Index: AQHWkw1OpmSoLCAf8Eq4qu/02j8Taql5NxUAgAKXe7A=
Date:   Sun, 27 Sep 2020 05:07:52 +0000
Message-ID: <VI1PR04MB496047225BD131296FA8EE0F92340@VI1PR04MB4960.eurprd04.prod.outlook.com>
References: <20200925072630.8157-1-sherry.sun@nxp.com>
 <CAK8P3a3fog3jE_cPUTELDkFKoO2FbCJufQiDZhfL2FsZ5s5q3Q@mail.gmail.com>
In-Reply-To: <CAK8P3a3fog3jE_cPUTELDkFKoO2FbCJufQiDZhfL2FsZ5s5q3Q@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bc3cee92-e3d8-465b-6f3d-08d862a3494e
x-ms-traffictypediagnostic: VE1PR04MB6525:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB6525013F912A7B7C4EF11A1B92340@VE1PR04MB6525.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UNbmPV7usbH1+I/8L0YcMRQa0NbYfI41wNrwyjIfEPzgnCv++ufm8uJO2cNmCB2dOorxf49s2yjlyHrHrhBq9bKo2fsGwOShjJh6o3t6A7PDkmN1kq68NP1YXhGJtrBgqfrH9abnheBGz3Ubrnn0BSEW2E5cUwRtopRRo31knVEjeWgEWCGF+sLaq5bzG42YEenrL7ZuBJ1Yoj8ZDlavJ6tael3kfnguNOba46EKcGytPPgZoUjj9oPDDQ6AKkdDBTNaN9N/YekS1OsBS16vZjUUZ0m3+P3L3nxpCoCKVHK4CuzIEYguHZSdZ5LWVn59eTGjoz5GqOjH/c64NTctR9HVdnYJ9ErxUxObPatjYnTGH7zTC7aYR2119OdR2V8Z
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4960.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(366004)(346002)(396003)(39850400004)(316002)(2906002)(5660300002)(186003)(7696005)(53546011)(6506007)(26005)(54906003)(55016002)(71200400001)(9686003)(33656002)(52536014)(44832011)(8936002)(66946007)(478600001)(66446008)(64756008)(66476007)(76116006)(66556008)(8676002)(6916009)(7416002)(83380400001)(86362001)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: qWrrczvJfpGCo6yABRWSD+oDgtywDDBh19vIKAmht260tulyPNiqBl8IBGNF8j6LBPbueMq1BieBIRA2qj4RXkm+J/f8mZu5buYxq7mJ51roxb3XILY87iCSFzNYjggQCnr/eIjQV5APtsxZJc3tDXhlmxZUBvzmThD9EEbRPZQDTksBZjl5YXGZwDxmSB4T4Ev0SmCdtjKEd9AeRGxq4/6xoRgtlFUMwim+amDFs1cxJ2gTFXBN68rnh3wxLou2mg3m7x0wlZksqVyuuU3PaINAhTQNnLIvgg0YkCLdlS2QMU415aKZ3Hut3xeFKk7JM4pyw04jMVrFR04ibGeNLAx6DqbKmC/1UorkvCJM1pK3eYwP7k3U92Gd25av2qs+9fpsMB1+aOqshUOQtgV5Ovm0RY80fPiTRTWjM0LiEgQxdoPBbmKMgimdLBMXIDEIeugVVE8ke5RAmXvPuNq8dRankmJGdnBbZq/n0P1tHDGqL2TtuHQln2NAZoGTFFMD4fhyIDMP2/8/+gad5w6LxgzfkQ6b1IbzE1A+JnX1MXfiLaxWw+P0l3Iowk55hpYqiynW6rrsSOT8CboVly60Qqla4yQenZFPfTq0N5GerASKRkf3IlT1VuGivGwgOferdPo1NcAaPJg2CV+xsBGkaQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4960.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc3cee92-e3d8-465b-6f3d-08d862a3494e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2020 05:07:52.0704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9CKO1LNP6XJFrn1OfqFlT7ja3X/sclThE/HgxXR9+uYzG5/UhXT0i0eyGhMDzfHASTk8RVpB+v+EZQKT0xrIUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6525
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgQXJuZCwNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDAvNV0gQWRkIG5vbmNvaGVyZW50IHBs
YXRmb3JtIHN1cHBvcnQgZm9yIHZvcCBkcml2ZXINCj4gDQo+IE9uIEZyaSwgU2VwIDI1LCAyMDIw
IGF0IDk6MjcgQU0gU2hlcnJ5IFN1biA8c2hlcnJ5LnN1bkBueHAuY29tPiB3cm90ZToNCj4gPg0K
PiA+IENoYW5nZSB0aGUgd2F5IG9mIGFsbG9jYXRpbmcgdnJpbmcgdG8gc3VwcG9ydCBub25jb2hl
cmVudCBwbGF0Zm9ybSBmb3INCj4gPiB2b3AgZHJpdmVyLCBhbmQgYWRkIHNvbWUgcmVsYXRlZCBk
bWEgY2hhbmdlcyB0byBtYWtlIHN1cmUgbm9uY29oZXJlbnQNCj4gPiBwbGF0Zm9ybSB3b3JrcyB3
ZWxsLg0KPiANCj4gQ291bGQgeW91IGRlc2NyaWJlIHdoeSB5b3UgYXJlIGRvaW5nIHRoaXM/IEFy
ZSB5b3UgdXNpbmcgSW50ZWwgTUlDIGRldmljZXMNCj4gb24gQXJtIGhvc3RzLCBvciB0cnlpbmcg
dG8gcmV1c2UgdGhlIGNvZGUgZm9yIG90aGVyIGFkZC1vbiBjYXJkcz8NCj4gDQoNCldlIHdhbnQg
dG8gcmV1c2UgdGhlIHZvcCBkcml2ZXIgYmV0d2VlbiB0d28gaS5NWCBib2FyZHMgd2hpY2ggYXJl
IGFybTY0IGFyY2hpdGVjdHVyZS4gQW5kIGluIGZhY3Qgd2UgaGF2ZSBzdWNjZXNzZnVsbHkgdmVy
aWZpZWQgaXQuIA0KDQpCdXQgdGhlIGJpZ2dlc3QgcHJvYmxlbSB3ZSBjdXJyZW50bHkgZW5jb3Vu
dGVyIGlzIGFib3V0IHRoZSBub25jb2hlcmVudCBtZW1vcnkuDQpTaW5jZSB0aGUgaGFyZHdhcmUg
ZGV2aWNlIG9mIG91ciBwbGF0Zm9ybSBpcyBub3QgZG1hIGNvaGVyZW50LCANCndoZW4gdXNlIHRo
ZSBvcmlnaW5hbCB3YXkoX19nZXRfZnJlZV9wYWdlcyBhbmQgZG1hX21hcF9zaW5nbGUsIGJ1dCB3
aXRob3V0IGRtYV9zeW5jX3NpbmdsZV9mb3JfY3B1L2RldmljZSkgd2lsbCBtZWV0IGVycm9ycy4N
Cg0KRGV2aWNlIHBhZ2VzL3ZyaW5nIHdoaWNoIGFyZSBpbnRlcmFjdCBiZXR3ZWVuIGVwIGFuZCBy
YyBzaG91bGQgdXNlIGNvbnNpc3RlbnQgbWVtb3J5IHdpdGhvdXQgY2FjaGluZyBlZmZlY3RzLCAN
CnNvIGFsbG9jYXRlIHRoZW0gYnkgZG1hX2FsbG9jX2NvaGVyZW50IGlzIGEgYmV0dGVyIHdheS4N
Cg0KPiBOb3RlIHRoYXQgd2UgaGF2ZSBhIGNvdXBsZSBvZiBmcmFtZXdvcmtzIGluIHRoZSBrZXJu
ZWwgdGhhdCB0cnkgdG8gZG8gc29tZQ0KPiBvZiB0aGUgc2FtZSB0aGluZ3MgaGVyZSwgbm90YWJs
eSB0aGUgTlRCIGRyaXZlcnMgYW5kIHRoZSBQQ0kgZW5kcG9pbnQNCj4gc3VwcG9ydCwgYm90aCBv
ZiB3aGljaCBhcmUgZGVzaWduZWQgdG8gYmUgc29tZXdoYXQgbW9yZSBnZW5lcmljIHRoYW4gdGhl
DQo+IE1JQyBkcml2ZXIuDQo+IA0KPiBIYXZlIHlvdSBjb25zaWRlcmVkIHVzaW5nIHRoYXQgaW5z
dGVhZD8NCj4gDQo+ICAgICAgICAgIEFybmQNCj4gDQoNClNvcnJ5IEkgZG9uJ3QgbXVjaCBhYm91
dCBOVEIsIGJ1dCBmb3IgUENJIGVuZHBvaW50IGRyaXZlciwgd2Ugd2lsbCB1c2UgaXQgZm9yIHBj
aSBkYXRhIGludGVyYWN0aW9uIGJlbG93IHRoZSB2b3AgbGF5ZXIuDQoNCkJlc3QgcmVnYXJkcw0K
U2hlcnJ5DQoNCj4gPiBTaGVycnkgU3VuICg1KToNCj4gPiAgIG1pc2M6IHZvcDogY2hhbmdlIHRo
ZSB3YXkgb2YgYWxsb2NhdGluZyB2cmluZyBmb3Igbm9uY29oZXJlbnQgcGxhdGZvcm0NCj4gPiAg
IG1pc2M6IHZvcDogY2hhbmdlIHRoZSB3YXkgb2YgYWxsb2NhdGluZyB1c2VkIHJpbmcNCj4gPiAg
IG1pc2M6IHZvcDogc2ltcGx5IHJldHVybiB0aGUgc2F2ZWQgZG1hIGFkZHJlc3MgaW5zdGVhZCBv
ZiB2aXJ0X3RvX3BoeXMNCj4gPiAgIG1pc2M6IHZvcDogc2V0IFZJUlRJT19GX0FDQ0VTU19QTEFU
Rk9STSBmb3Igbm9jb2hlcmVudCBwbGF0Zm9ybQ0KPiA+ICAgbWlzYzogdm9wOiBtYXBwaW5nIGtl
cm5lbCBtZW1vcnkgdG8gdXNlciBzcGFjZSBhcyBub25jYWNoZWQNCj4gPg0KPiA+ICBkcml2ZXJz
L21pc2MvbWljL2J1cy92b3BfYnVzLmggICAgfCAgIDIgKw0KPiA+ICBkcml2ZXJzL21pc2MvbWlj
L2hvc3QvbWljX2Jvb3QuYyAgfCAgIDggKysNCj4gPiAgZHJpdmVycy9taXNjL21pYy92b3Avdm9w
X21haW4uYyAgIHwgIDUxICsrKysrKysrKy0tLS0NCj4gPiAgZHJpdmVycy9taXNjL21pYy92b3Av
dm9wX3ZyaW5naC5jIHwgMTE3DQo+ID4gKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tDQo+
ID4gIDQgZmlsZXMgY2hhbmdlZCwgMTI1IGluc2VydGlvbnMoKyksIDUzIGRlbGV0aW9ucygtKQ0K
PiA+DQo+ID4gLS0NCj4gPiAyLjE3LjENCj4gPg0K
