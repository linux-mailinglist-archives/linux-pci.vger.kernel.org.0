Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD97C27EFFA
	for <lists+linux-pci@lfdr.de>; Wed, 30 Sep 2020 19:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731218AbgI3RLm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Sep 2020 13:11:42 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:27502 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725385AbgI3RLm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Sep 2020 13:11:42 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08UH8Tvq024000;
        Wed, 30 Sep 2020 10:11:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=9BHND8AcemmPrCm95LBUkwrHsqT4LOLHjEFr9NY8kT4=;
 b=nUe+KxFih82WRBZcY15/30BnMN7U9CddF01mSdl8cuueBM+YaljOGxfanjbidcs1mGTa
 Sn0/eSEiyyMJVvc/pZyQ5KPCKKIGK/9Ekif82pr+lS11W56rgRgrQOvXZtqS7PPagxVo
 PIUfFlM1C4UP4BDYJodPFyvDwZHJqimp9VjQ871fhfrtebdAVtQQm8WN9GMfwzsTaQnC
 4/6sVIzrSUjjvtLWIlET9DUh+yMhrlf1E/DTykXiRYfDpQrZolMpp2rJ1VYP8XmKFbfx
 3nGCsmCKFX7DbJVQHvqIHNh/8oIRCRNAraX47szGe1WDEgNEZGXu1+CZ7D0qRoWAlj29 LA== 
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2051.outbound.protection.outlook.com [104.47.38.51])
        by mx0a-0014ca01.pphosted.com with ESMTP id 33t26xq4bt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Sep 2020 10:11:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TncMBB0qqWt/Ici48uqnKgBbmFc+5hvYjh9VKfT0Pwy+QFi3kGiw3Kc1gDWyK09lInegQBkSNJUmimPUnST95LE309s9dBF+Hzn9caVTDTgNpzYBEzsQH1DwF6ZdgZFOUUu4yk3ERdTQs02W7W46f91zo5palvYul+64kpf8tVsBFTeXHLXUI8+QU3hsaq3SygVDQDSq/cVoAPoKiIuA4ncKFowCgwURnO/+CikYnNqL8a8rvZE2uEmSeasV8NRfHq3Nv0IYsJ3DTyOCOOJy+vda2LejDRQEWiMgnHsxwuqYojGX9yR0i+KLzaTUDR7d2W0ouXat15GaNRfNkYHpUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9BHND8AcemmPrCm95LBUkwrHsqT4LOLHjEFr9NY8kT4=;
 b=gmjWZaMuTH1dw9547MjYmMDptdAP8rRIj5Z9Blxtj7MAjaly/cgoWkhJ0Al9RZAYTiaB7KSDLQxiwVk1P7m5dYMIE1KxIE4m2DbYJbx8nTbmhxfCvWCLEtmhXnteKjMrKLWdDh5xIhcjY7Wx4X1ZTKmRnfyZfMOZFGsO5Q6mD/Am8EHfaKD4X4X4HeK5rKZkBZaKNjopIbCLDf/qObcn82I+kPJypDKK3q9prqQAhoq4SMdxMbUmvRe+RtwTYCZPMDQJaMhFUcnxTWwn+2PdF+w/rRbQOLNoyckYTQUiYwK3Y2Zb8enoXJJePNIJr3gPinnQS1Pj9ioaP21hZUEmbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9BHND8AcemmPrCm95LBUkwrHsqT4LOLHjEFr9NY8kT4=;
 b=eO5hbIvR8/uN//1vaLocyj9pHjVKfdtrGzwBi/3p6E4Z2pjKPIKVRBhmuxNl9oOqAv1itjvc4Q3f7GGgYti33OtzCkAmUQyik87a44p/NGSoS05rQZ2Yb1tzWGex5BzU7ovz2uDZtuXUrL52l2FzdrkkxHyPn+vHxL6JQOpiZbY=
Received: from SN2PR07MB2557.namprd07.prod.outlook.com (2603:10b6:804:12::9)
 by SN6PR07MB5646.namprd07.prod.outlook.com (2603:10b6:805:e3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Wed, 30 Sep
 2020 17:11:23 +0000
Received: from SN2PR07MB2557.namprd07.prod.outlook.com
 ([fe80::9506:77c:74e4:caf8]) by SN2PR07MB2557.namprd07.prod.outlook.com
 ([fe80::9506:77c:74e4:caf8%11]) with mapi id 15.20.3412.029; Wed, 30 Sep 2020
 17:11:23 +0000
From:   Athani Nadeem Ladkhan <nadeem@cadence.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Tom Joseph <tjoseph@cadence.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Milind Parab <mparab@cadence.com>,
        Swapnil Kashinath Jakhade <sjakhade@cadence.com>
Subject: RE: [PATCH v2] PCI: Cadence: Add quirk for Gen2 controller to do
 autonomous speed change.
Thread-Topic: [PATCH v2] PCI: Cadence: Add quirk for Gen2 controller to do
 autonomous speed change.
Thread-Index: AQHWkdgyO198gx0BFk+Kvm6f02xHwql3LseAgApGAUA=
Date:   Wed, 30 Sep 2020 17:11:23 +0000
Message-ID: <SN2PR07MB2557080E99C30824D923E67BD8330@SN2PR07MB2557.namprd07.prod.outlook.com>
References: <20200923183427.9258-1-nadeem@cadence.com>
 <37fca4c0-1cba-866a-27ed-9a0a0cbe69e6@ti.com>
In-Reply-To: <37fca4c0-1cba-866a-27ed-9a0a0cbe69e6@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbmFkZWVtXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctZjI0ZTE4MmQtMDMzZi0xMWViLWFlOGMtZDQ4MWQ3OWExZmRlXGFtZS10ZXN0XGYyNGUxODJlLTAzM2YtMTFlYi1hZThjLWQ0ODFkNzlhMWZkZWJvZHkudHh0IiBzej0iMzE0OCIgdD0iMTMyNDU5NTk0ODAzODU1NDMzIiBoPSIraGVRNW9MN1ZCc3hWd1hHejhBQVRQUCtkYVk9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [59.145.174.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b63ac9a2-e211-4327-bd53-08d86563db9e
x-ms-traffictypediagnostic: SN6PR07MB5646:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR07MB5646853741474F950775F911D8330@SN6PR07MB5646.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y5UMJdDJfnRhQpyvgxLORk21/+nSAx8WEJZc+8u9G07yEhmC//edc8U+K8yH/uTwpTLQOVju1Z2wSP1ZUeaNHveTdco5uGZJH2dTiC2uQQY/wZtPQvbDTmwsPZgxdvpbxsnS1DL4fogoyQUyLz0Vr+ziUgFeld5YAyHCILnHiquHMA7y96fUeF/Bc2dZaihxW0iyCWalvjwZD74L1sW6W94RhBZ0Iw2jOF8S4OxaohFis5wcdMKDyMPYuQOVw6fMIc5Za5SwlkbORLWKr0V/7+Ov3tDJ9Pk1TkvKhcRhc3by7CB9JNtTKA8TEyKK4bRX10D+uglgrHimyVNNzLpDUzp4rDMYPbVht/iE0jUZHmNpI73YBx5Twm/zmIcL5gJBlLSYVo4ys0tyxL0nO1B6/JkYV3aX1uYRdx0dsDEjCGo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN2PR07MB2557.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(36092001)(83380400001)(186003)(7696005)(316002)(6506007)(53546011)(110136005)(26005)(54906003)(52536014)(71200400001)(2906002)(66946007)(8676002)(76116006)(66476007)(5660300002)(66446008)(86362001)(64756008)(66556008)(8936002)(33656002)(478600001)(4326008)(9686003)(107886003)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: oV4Ef7F1Zm5d1N4N57oTslNbtIk/NT8RInLtrJv55a5iIoReAXmy0sg3+Bm3bSRybY43IgvZB5GHeKuyztbmKOD1DkmJ6tRkZoYQmX3n96pEXZoAYEu/F6L4ymMRoh6zbiHUTZDDRrRC5v7IR2h1ztQdWRjk1cKi0nQQV8V+wRLQzyEBAqWZrGx2BcGmanJS7GcS00Oj4TaihBmqQq2dFnmpHkY5X/KLd70Ptw5Q8Pth4zt+ElbGzgQRUErxD9gbNtLW5oYxniJFVmjyrRIEzQCLzvAK3QCGUbB/g6J2W7Zglm5HLtNvrJQY80m6yqjkMlMmAxXzE8XcNZDxs2cbT6GyNr88GW0ErLZiMpQYFS+czKuhyL5gCGbh5/n8lzVgJu0MTAed2/dooiCKObDXYLD/9TWfgvuaAQAknC9yXTYN46b3rfRVVm0aGaJSUG/gU4enp8RSSrTyvQ8XxAoxCGYGS/AoSlTIdm5DTp9ARhGirb+2Y8gVZqJgCOTnXU2hiKH5keF7dJn5lEIlmjKawEC2kyJ3B1/JK7LgLYqEVTkcsl2wT11/ApU5kHp1e9+DzDcvrxUDf8jKmzDv+bmtzjHWjoK2AsQGvqyLF8pJJ93XSr1sNICvW0bNaP3pNug/Y9T2nQ6L/daOfO7hZ41Rhw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN2PR07MB2557.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b63ac9a2-e211-4327-bd53-08d86563db9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2020 17:11:23.1897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QE6bvFWqjdyiNUFeZCnSzg6ER0yA8A6TG5VRIYIZJ37SwU1jefMqxCJMIYxtv+Cjppb44wUWdJ3OJlYIwB8rB5fk5eHkZFkVcIs7oRUig/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB5646
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-30_09:2020-09-30,2020-09-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 adultscore=0 priorityscore=1501 clxscore=1015 spamscore=0 phishscore=0
 malwarescore=0 mlxscore=0 impostorscore=0 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009300135
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgS2lzaG9uLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEtpc2hv
biBWaWpheSBBYnJhaGFtIEkgPGtpc2hvbkB0aS5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBTZXB0
ZW1iZXIgMjQsIDIwMjAgOTo0NSBBTQ0KPiBUbzogQXRoYW5pIE5hZGVlbSBMYWRraGFuIDxuYWRl
ZW1AY2FkZW5jZS5jb20+OyBUb20gSm9zZXBoDQo+IDx0am9zZXBoQGNhZGVuY2UuY29tPjsgbG9y
ZW56by5waWVyYWxpc2lAYXJtLmNvbTsgcm9iaEBrZXJuZWwub3JnOw0KPiBiaGVsZ2Fhc0Bnb29n
bGUuY29tOyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIu
a2VybmVsLm9yZw0KPiBDYzogTWlsaW5kIFBhcmFiIDxtcGFyYWJAY2FkZW5jZS5jb20+OyBTd2Fw
bmlsIEthc2hpbmF0aCBKYWtoYWRlDQo+IDxzamFraGFkZUBjYWRlbmNlLmNvbT4NCj4gU3ViamVj
dDogUmU6IFtQQVRDSCB2Ml0gUENJOiBDYWRlbmNlOiBBZGQgcXVpcmsgZm9yIEdlbjIgY29udHJv
bGxlciB0byBkbw0KPiBhdXRvbm9tb3VzIHNwZWVkIGNoYW5nZS4NCj4gDQo+IEVYVEVSTkFMIE1B
SUwNCj4gDQo+IA0KPiBIaSBOYWRlZW0sDQo+IA0KPiBPbiAyNC8wOS8yMCAxMjowNCBhbSwgTmFk
ZWVtIEF0aGFuaSB3cm90ZToNCj4gPiBDYWRlbmNlIGNvbnRyb2xsZXIgd2lsbCBub3QgaW5pdGlh
dGUgYXV0b25vbW91cyBzcGVlZCBjaGFuZ2UgaWYNCj4gPiBzdHJhcHBlZCBhcyBHZW4yLiBUaGUg
UmV0cmFpbiBiaXQgaXMgc2V0IGFzIGEgcXVpcmsgdG8gdHJpZ2dlciB0aGlzDQo+ID4gc3BlZWQg
Y2hhbmdlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTmFkZWVtIEF0aGFuaSA8bmFkZWVtQGNh
ZGVuY2UuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2NhZGVuY2Uv
cGNpZS1jYWRlbmNlLWhvc3QuYyB8IDE0ICsrKysrKysrKysrKysrDQo+ID4gIGRyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvY2FkZW5jZS9wY2llLWNhZGVuY2UuaCAgICAgIHwgMTUgKysrKysrKysrKysr
KysrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMjkgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvY2FkZW5jZS9wY2llLWNhZGVuY2UtaG9z
dC5jDQo+ID4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2NhZGVuY2UvcGNpZS1jYWRlbmNlLWhv
c3QuYw0KPiA+IGluZGV4IDQ1NTBlMGQ0NjljYS4uYTIzMTc2MTQyNjhkIDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvY2FkZW5jZS9wY2llLWNhZGVuY2UtaG9zdC5jDQo+
ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9jYWRlbmNlL3BjaWUtY2FkZW5jZS1ob3N0
LmMNCj4gPiBAQCAtODMsNiArODMsOSBAQCBzdGF0aWMgaW50IGNkbnNfcGNpZV9ob3N0X2luaXRf
cm9vdF9wb3J0KHN0cnVjdA0KPiBjZG5zX3BjaWVfcmMgKnJjKQ0KPiA+ICAJc3RydWN0IGNkbnNf
cGNpZSAqcGNpZSA9ICZyYy0+cGNpZTsNCj4gPiAgCXUzMiB2YWx1ZSwgY3RybDsNCj4gPiAgCXUz
MiBpZDsNCj4gPiArCXUzMiBsaW5rX2NhcCA9IENETlNfUENJRV9MSU5LX0NBUF9PRkZTRVQ7DQo+
ID4gKwl1OCBzbHM7DQo+ID4gKwl1MTYgbG5rX2N0bDsNCj4gPg0KPiA+ICAJLyoNCj4gPiAgCSAq
IFNldCB0aGUgcm9vdCBjb21wbGV4IEJBUiBjb25maWd1cmF0aW9uIHJlZ2lzdGVyOg0KPiA+IEBA
IC0xMTEsNiArMTE0LDE3IEBAIHN0YXRpYyBpbnQgY2Ruc19wY2llX2hvc3RfaW5pdF9yb290X3Bv
cnQoc3RydWN0DQo+IGNkbnNfcGNpZV9yYyAqcmMpDQo+ID4gIAlpZiAocmMtPmRldmljZV9pZCAh
PSAweGZmZmYpDQo+ID4gIAkJY2Ruc19wY2llX3JwX3dyaXRldyhwY2llLCBQQ0lfREVWSUNFX0lE
LCByYy0+ZGV2aWNlX2lkKTsNCj4gPg0KPiA+ICsJLyogUXVpcmsgdG8gZW5hYmxlIGF1dG9ub21v
dXMgc3BlZWQgY2hhbmdlIGZvciBHRU4yIGNvbnRyb2xsZXIgKi8NCj4gPiArCS8qIFJlYWRpbmcg
U3VwcG9ydGVkIExpbmsgU3BlZWQgdmFsdWUgKi8NCj4gPiArCXNscyA9IFBDSV9FWFBfTE5LQ0FQ
X1NMUyAmDQo+ID4gKwkJY2Ruc19wY2llX3JwX3JlYWRiKHBjaWUsIGxpbmtfY2FwICsgUENJX0VY
UF9MTktDQVApOw0KPiA+ICsJaWYgKHNscyA9PSBQQ0lfRVhQX0xOS0NBUF9TTFNfNV8wR0IpIHsN
Cj4gPiArCQkvKiBTaW5jZSB0aGlzIGEgR2VuMiBjb250cm9sbGVyLCBzZXQgUmV0cmFpbiBMaW5r
KFJMKSBiaXQgKi8NCj4gPiArCQlsbmtfY3RsID0gY2Ruc19wY2llX3JwX3JlYWR3KHBjaWUsIGxp
bmtfY2FwICsNCj4gUENJX0VYUF9MTktDVEwpOw0KPiA+ICsJCWxua19jdGwgfD0gUENJX0VYUF9M
TktDVExfUkw7DQo+ID4gKwkJY2Ruc19wY2llX3JwX3dyaXRldyhwY2llLCBsaW5rX2NhcCArIFBD
SV9FWFBfTE5LQ1RMLA0KPiBsbmtfY3RsKTsNCj4gPiArCX0NCj4gDQo+IElzIHRoaXMgd29ya2Fy
b3VuZCByZXF1aXJlZCBmb3IgYWxsIENhZGVuY2UgY29udHJvbGxlcj8gSWYgbm90LCBlbmFibGUg
dGhpcw0KPiB3b3JrYXJvdW5kIG9ubHkgZm9yIHZlcnNpb25zIHdoaWNoIGRvZXNuJ3QgZG8gYXV0
b25vbW91cyBzcGVlZCBjaGFuZ2UuDQpOby4gVGhpcyBpcyB0YWtlbiBjYXJlIGluIHBhdGNoIHZl
cnNpb24gMy4NCj4gDQo+IEkgdGhpbmsgdGhpcyB3b3JrYXJvdW5kIHNob3VsZCBhbHNvIGJlIGFw
cGxpZWQgb25seSBhZnRlciBjaGVja2luZyBmb3IgbGluaw0KPiBzdGF0dXMgKGNkbnNfcGNpZV9s
aW5rX3VwKCkpLg0KWWVzLiBUaGlzIGlzIHRha2VuIGNhcmUgaW4gcGF0Y2ggdmVyc2lvbiAzLg0K
PiANCj4gQW5kIHRoaXMgaXMgYWxzbyBhcHBsaWNhYmxlIGZvciBHRU4zL0dFTjQgY29udHJvbGxl
ci4gU28gdGhlIGNoZWNrIHNob3VsZCBiZQ0KPiB0byBzZWUgdGhlIGNhcGFiaWxpdHkgb2YgdGhl
IGNvbm5lY3RlZCBQQ0llIGRldmljZSBhbmQgbm90IHRoZSBjb250cm9sbGVyDQo+IGl0c2VsZi4N
ClRoaXMgaXMgdGFrZW4gY2FyZSBpbiBwYXRjaCB2ZXJzaW9uIDMuDQo+IA0KPiBUaGFua3MNCj4g
S2lzaG9uDQo=
