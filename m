Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 249AE292C87
	for <lists+linux-pci@lfdr.de>; Mon, 19 Oct 2020 19:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730581AbgJSRTB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Oct 2020 13:19:01 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:48028 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729916AbgJSRTB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Oct 2020 13:19:01 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09JHGsfb011158;
        Mon, 19 Oct 2020 10:18:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=rSbEo4+J27Syqrq1HT/PmMzx92TTVdCuoc7qNANfZYU=;
 b=LxsFwEMQNzpGwe59nxdb8NJQcD1YR0i4HkTXb3KF02nGzqpT2wPUT2SSHpWVrY7YCJfd
 s6+6GYHDGgGhh7wzX0O7KR1M519vZJ4zv5qPpkorE0No7RbgigPH5JPnkuHarjRKww1h
 ZF/XyIXNd9KbJKhpYPlsXoUhO1G8QJJ0fiIrbSG2FbC+8z3QAQcW1q+YgBJxHNTR2sGr
 XpuC5njKJa3sAV6hAsWpmPzl559EEi1ipyLSmcQ/OFRFl50SOIns343Pv6P/BJKjFrbF
 sv2kQQZeJ8xOCuTmz65rQs86kb8fLeF6N6mlscz0p4fXKW8fpGcFKFu/dyzTg8PrcCgT 9w== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by mx0a-0014ca01.pphosted.com with ESMTP id 347w5xy4e8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Oct 2020 10:18:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZhcsZbUwbwlDy7ItughYOGvCpcn9BzMHT4XYtKL/9Tt3MXthXUnmu9Y66Yo6zOTzZi+GqA5Dv4txp0Umgic0e5ce07v9EDLYHoZ5EYalUTTtTATHwTnmMwHjnYDsLjt91DeDhwsBJ3W7RuDmfqi/5fMYjX7BzGbVKNQUlreiuuX/mjvj4cR7y7naHHebu6lrKoU3eWkUsioVVJDAq4mtZhiED2H23omi9zQILoWDNomMHgcT23EGLTzablVmGC5TXVk9WYBAC67x0ZbhxRkfsfEyUowa5YGakojmUHfRDMLusYI8582V6Iyct7qLjmkWLBsalU8VkotGmr3QAGa/6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSbEo4+J27Syqrq1HT/PmMzx92TTVdCuoc7qNANfZYU=;
 b=Pk+eym0eB+RZO9ICCsKvXGpI3A6y26BNjueW0Mt4QZMp1X3CTuP9L5nbvsmFYHWUdWIZ42iGEPKx2z0hzRfGq83/gw94iyORb6I37H7bbyi9S2BWLjLy8aGcFqT9uYw9HIldauafpBh2Dgls4aPDCnUW0x30Hnsu75H4AfB0iyiUQOd9IY2wdl4CrngtvOiAqf1FBZQUlnhBpOqvXIgBGVn0lW4POuUPBiffNARBR1k8iTLvuXmvZdSUhhGlV/nGOU21j7sE2Rk2aH0t+LHcRoLxsx1Jd/m5/Lin7BJHkobVogB8vEoTN3tU625PIR5p+Y6YhKid8W2S5VC9tRsTMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSbEo4+J27Syqrq1HT/PmMzx92TTVdCuoc7qNANfZYU=;
 b=QvIgsu2OGqlkxr4pbBKun2R6CrjZk/ZIT/pHOn9BaE/OlEslSrz8nak/+nZ/XY5xkfDCck61ADY6ICcuO6sKjb+HBPzGgslsZ8ipaLIRt0T2i60NENpRdvuk4KTLM80KUdZO41j9aBWhYn/B+jCnLko4nsB9O9ewjskvkXbXdr0=
Received: from SN2PR07MB2557.namprd07.prod.outlook.com (2603:10b6:804:12::9)
 by SN6PR07MB4879.namprd07.prod.outlook.com (2603:10b6:805:2c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25; Mon, 19 Oct
 2020 17:18:44 +0000
Received: from SN2PR07MB2557.namprd07.prod.outlook.com
 ([fe80::9506:77c:74e4:caf8]) by SN2PR07MB2557.namprd07.prod.outlook.com
 ([fe80::9506:77c:74e4:caf8%11]) with mapi id 15.20.3477.028; Mon, 19 Oct 2020
 17:18:44 +0000
From:   Athani Nadeem Ladkhan <nadeem@cadence.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tom Joseph <tjoseph@cadence.com>
CC:     Swapnil Kashinath Jakhade <sjakhade@cadence.com>,
        Milind Parab <mparab@cadence.com>
Subject: RE: [PATCH v3] PCI: cadence: Retrain Link to work around Gen2
 training defect.
Thread-Topic: [PATCH v3] PCI: cadence: Retrain Link to work around Gen2
 training defect.
Thread-Index: AQHWl1Z6N6ovEDY5sUuQSkxKtmQChqmegrmAgADESIA=
Date:   Mon, 19 Oct 2020 17:18:44 +0000
Message-ID: <SN2PR07MB255715C886C2DC5B9044BC01D81E0@SN2PR07MB2557.namprd07.prod.outlook.com>
References: <20200930182105.9752-1-nadeem@cadence.com>
 <a3a89720-6813-b344-630d-4cd2d6ccf24f@ti.com>
In-Reply-To: <a3a89720-6813-b344-630d-4cd2d6ccf24f@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbmFkZWVtXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMjBhNDdmN2MtMTIyZi0xMWViLWFlOGQtZDQ4MWQ3OWExZmRlXGFtZS10ZXN0XDIwYTQ3ZjdkLTEyMmYtMTFlYi1hZThkLWQ0ODFkNzlhMWZkZWJvZHkudHh0IiBzej0iNDc2NSIgdD0iMTMyNDc2MDE1MTk1ODIzMjI1IiBoPSJNOWZXQm1xMm5tTTNNMi9CeEQ0TkFLcmRrWGs9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [59.145.174.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4b511080-9cfd-406e-2d69-08d874530868
x-ms-traffictypediagnostic: SN6PR07MB4879:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR07MB487929174968B634C38EA63AD81E0@SN6PR07MB4879.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1CA3jND0H/mogkpCX1UigxLIbVW4N499ajTB6dGvpEtAvqjToE8ZzMUGmPS537ZZd8+BRU03eKeTjNl7x56ssiXCm93aXqc+8z7lYH/B1yS/yhUGA10sgctMO/6xxQPvsLYDmbJtLvbo/AwmsgRRrAybznxHiPWtUjbWdC42E63J4MdNrzz/ZTVG77MC36TrQGYyC5Gu0e0if5ZRdQLimMt75XQPB/YN8inhqpPeXuya5S8f6d51uy3ob7lU48+CBcz5+JbAmIg6V2kIGgiq9/Ec1XZYUqi2rigCERDrruPdiIjYl8BzIwcrQJ1GMbpeQ6hUc7j+UAOMbM77Np0sOgDWnULwEW/OHK8RHTxYGIjb0XIejA5NETWs4aKIaEu7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN2PR07MB2557.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(366004)(39860400002)(346002)(36092001)(478600001)(6506007)(55016002)(53546011)(33656002)(107886003)(8676002)(7696005)(83380400001)(2906002)(8936002)(66446008)(71200400001)(54906003)(86362001)(64756008)(186003)(6636002)(316002)(110136005)(9686003)(26005)(4326008)(76116006)(5660300002)(52536014)(66556008)(66476007)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: UoYDzTWbURjayJzx4SPYGks2cBdAvDaquu8Gx75sS0xd7tZyTkgbr7sdQzR1urnKDbUBFPhQDnFt+/ru52rPGTm6yR2Xt6EzB+tj0ZiVuc8idBOmJ2nMjxh/x/os+fhsy/2L5yIn5YZqurmPJK5yr3WWIOAxwS7Wtwli8RIz1Z64Z9DmKJG4hGiLlVqErAafiVyCtQ6kYfdcVfkhJ0384LPD9WKinJiDy1nKl4bkavnv9tWRmNxl50YyWPxsLVUrUohnz7gcn5mz1+Spr0UlEwDwpbgCx21Ihn3FX3r6t4Qa6DUduIsj1OAU+l2Djmu7EWB34uMmKvKcqEyFzsOAHwcvPjqa9GgYw1iP4wddm3XP8s7RtMklWe9PvRWhO7PxyWnhVWowRFDDrrstwEKbD7B6kJf6F4wFjs4pMNGJihug3sq3kUJ7+KKm8F2Q5dV9uXcfRwh5HXTqaXb34+28Xz0JdInioVKCcn5dtVD+lfBqQfP7AWw2FYYZ6g6QVKiRk5mH5jbCYMHRIv92V79REdqzdcpTLs+/fb1UCBjBkNYSsvZd9qyn0WEdZNzNroR4HBZpLxKw5n7m2lAvz/yZnzhSq1AYnObUSJ3wyCgZBLdsU6PHbuZ2SveVVNZxUgEO1JPL6yrIGWgJAu9BxE5Zrw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN2PR07MB2557.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b511080-9cfd-406e-2d69-08d874530868
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2020 17:18:44.3418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qJkbrwQwx8YK5foDDEH1IA7FlcJvVA7V4jaQb0Vi/c9nXZZt+PyNn6rx6h/ixGYRvPt76pMhMMEBlIwQ3hqdk1B/JaDpqQgyitK4JqlCXuo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4879
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-19_08:2020-10-16,2020-10-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999 spamscore=0
 phishscore=0 suspectscore=0 impostorscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010190118
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgS2lzaG9uLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEtpc2hv
biBWaWpheSBBYnJhaGFtIEkgPGtpc2hvbkB0aS5jb20+DQo+IFNlbnQ6IE1vbmRheSwgT2N0b2Jl
ciAxOSwgMjAyMCAxMDo1OSBBTQ0KPiBUbzogQXRoYW5pIE5hZGVlbSBMYWRraGFuIDxuYWRlZW1A
Y2FkZW5jZS5jb20+Ow0KPiBsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tOyByb2JoQGtlcm5lbC5v
cmc7IGJoZWxnYWFzQGdvb2dsZS5jb207IGxpbnV4LQ0KPiBwY2lAdmdlci5rZXJuZWwub3JnOyBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBUb20gSm9zZXBoDQo+IDx0am9zZXBoQGNhZGVu
Y2UuY29tPg0KPiBDYzogU3dhcG5pbCBLYXNoaW5hdGggSmFraGFkZSA8c2pha2hhZGVAY2FkZW5j
ZS5jb20+OyBNaWxpbmQgUGFyYWINCj4gPG1wYXJhYkBjYWRlbmNlLmNvbT4NCj4gU3ViamVjdDog
UmU6IFtQQVRDSCB2M10gUENJOiBjYWRlbmNlOiBSZXRyYWluIExpbmsgdG8gd29yayBhcm91bmQg
R2VuMg0KPiB0cmFpbmluZyBkZWZlY3QuDQo+IA0KPiBFWFRFUk5BTCBNQUlMDQo+IA0KPiANCj4g
SGkgTmFkZWVtLA0KPiANCj4gT24gMzAvMDkvMjAgMTE6NTEgcG0sIE5hZGVlbSBBdGhhbmkgd3Jv
dGU6DQo+ID4gQ2FkZW5jZSBjb250cm9sbGVyIHdpbGwgbm90IGluaXRpYXRlIGF1dG9ub21vdXMg
c3BlZWQgY2hhbmdlIGlmDQo+ID4gc3RyYXBwZWQgYXMgR2VuMi4gVGhlIFJldHJhaW4gTGluayBi
aXQgaXMgc2V0IGFzIHF1aXJrIHRvIGVuYWJsZSB0aGlzIHNwZWVkDQo+IGNoYW5nZS4NCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IE5hZGVlbSBBdGhhbmkgPG5hZGVlbUBjYWRlbmNlLmNvbT4NCj4g
PiAtLS0NCj4gPiBDaGFuZ2VzIGluIHYzOg0KPiA+IC0gVG8gc2V0IHJldHJhaW4gbGluayBiaXQs
Y2hlY2tpbmcgZGV2aWNlIGNhcGFiaWxpdHkgJiBsaW5rIHN0YXR1cy4NCj4gPiAtIDMyYml0IHJl
YWQgaW4gcGxhY2Ugb2YgOGJpdC4NCj4gPiAtIE1pbm9yIGNvcnJlY3Rpb24gaW4gcGF0Y2ggY29t
bWVudC4NCj4gPiAtIENoYW5nZSBpbiB2YXJpYWJsZSAmIG1hY3JvIG5hbWUuDQo+ID4gQ2hhbmdl
cyBpbiB2MjoNCj4gPiAtIDE2Yml0IHJlYWQgaW4gcGxhY2Ugb2YgOGJpdC4NCj4gPiAgZHJpdmVy
cy9wY2kvY29udHJvbGxlci9jYWRlbmNlL3BjaWUtY2FkZW5jZS1ob3N0LmMgfCAzMQ0KPiArKysr
KysrKysrKysrKysrKysrKysrDQo+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvY2FkZW5jZS9w
Y2llLWNhZGVuY2UuaCAgICAgIHwgIDkgKysrKysrLQ0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDM5
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3BjaS9jb250cm9sbGVyL2NhZGVuY2UvcGNpZS1jYWRlbmNlLWhvc3QuYw0KPiA+IGIvZHJp
dmVycy9wY2kvY29udHJvbGxlci9jYWRlbmNlL3BjaWUtY2FkZW5jZS1ob3N0LmMNCj4gPiBpbmRl
eCA0NTUwZTBkNDY5Y2EuLjJiMmFlNGUxODAzMiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3Bj
aS9jb250cm9sbGVyL2NhZGVuY2UvcGNpZS1jYWRlbmNlLWhvc3QuYw0KPiA+ICsrKyBiL2RyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvY2FkZW5jZS9wY2llLWNhZGVuY2UtaG9zdC5jDQo+ID4gQEAgLTc3
LDYgKzc3LDM2IEBAIHN0YXRpYyBzdHJ1Y3QgcGNpX29wcyBjZG5zX3BjaWVfaG9zdF9vcHMgPSB7
DQo+ID4gIAkud3JpdGUJCT0gcGNpX2dlbmVyaWNfY29uZmlnX3dyaXRlLA0KPiA+ICB9Ow0KPiA+
DQo+ID4gK3N0YXRpYyB2b2lkIGNkbnNfcGNpZV9yZXRyYWluKHN0cnVjdCBjZG5zX3BjaWUgKnBj
aWUpIHsNCj4gPiArCXUzMiBsbmtfY2FwX3NscywgcGNpZV9jYXBfb2ZmID0gQ0ROU19QQ0lFX1JQ
X0NBUF9PRkZTRVQ7DQo+ID4gKwl1MTYgbG5rX3N0YXQsIGxua19jdGw7DQo+ID4gKw0KPiA+ICsJ
aWYgKCFjZG5zX3BjaWVfbGlua191cChwY2llKSkNCj4gPiArCQlyZXR1cm47DQo+ID4gKw0KPiAN
Cj4gSXMgdGhlcmUgYSBJUCB2ZXJzaW9uIHRoYXQgY2FuIGJlIHVzZWQgdG8gY2hlY2sgaWYgdGhh
dCBxdWlyayBpcyBhcHBsaWNhYmxlPw0KVGhlcmUgaXMgbm8gc3VjaCBwcm92aXNpb24uDQo+ID4g
KwkvKg0KPiA+ICsJICogU2V0IHJldHJhaW4gYml0IGlmIGN1cnJlbnQgc3BlZWQgaXMgMi41IEdC
L3MsDQo+ID4gKwkgKiBidXQgdGhlIFBDSWUgcm9vdCBwb3J0IHN1cHBvcnQgaXMgPiAyLjUgR0Iv
cy4NCj4gPiArCSAqLw0KPiA+ICsNCj4gPiArCWxua19jYXBfc2xzID0gY2Ruc19wY2llX3JlYWRs
KHBjaWUsIChDRE5TX1BDSUVfUlBfQkFTRSArDQo+IHBjaWVfY2FwX29mZiArDQo+ID4gKwkJCQkg
ICAgICBQQ0lfRVhQX0xOS0NBUCkpOw0KPiA+ICsJaWYgKChsbmtfY2FwX3NscyAmIFBDSV9FWFBf
TE5LQ0FQX1NMUykgPD0NCj4gUENJX0VYUF9MTktDQVBfU0xTXzJfNUdCKQ0KPiA+ICsJCXJldHVy
bjsNCj4gPiArDQo+ID4gKwlsbmtfc3RhdCA9IGNkbnNfcGNpZV9ycF9yZWFkdyhwY2llLCBwY2ll
X2NhcF9vZmYgKw0KPiBQQ0lfRVhQX0xOS1NUQSk7DQo+ID4gKwlpZiAoKGxua19zdGF0ICYgUENJ
X0VYUF9MTktTVEFfQ0xTKSA9PSBQQ0lfRVhQX0xOS1NUQV9DTFNfMl81R0IpDQo+IHsNCj4gPiAr
CQlsbmtfY3RsID0gY2Ruc19wY2llX3JwX3JlYWR3KHBjaWUsDQo+ID4gKwkJCQkJICAgICBwY2ll
X2NhcF9vZmYgKyBQQ0lfRVhQX0xOS0NUTCk7DQo+ID4gKwkJbG5rX2N0bCB8PSBQQ0lfRVhQX0xO
S0NUTF9STDsNCj4gPiArCQljZG5zX3BjaWVfcnBfd3JpdGV3KHBjaWUsIHBjaWVfY2FwX29mZiAr
IFBDSV9FWFBfTE5LQ1RMLA0KPiA+ICsJCQkJICAgIGxua19jdGwpOw0KPiA+ICsNCj4gPiArCQlp
ZiAoIWNkbnNfcGNpZV9saW5rX3VwKHBjaWUpKQ0KPiANCj4gU2hvdWxkIHRoaXMgcmF0aGVyIGJl
IGEgY2Ruc19wY2llX2hvc3Rfd2FpdF9mb3JfbGluaygpPw0KVGhlIHVzZSBvZiB0aGlzIGFwaSBj
ZG5zX3BjaWVfbGlua191cCB3YXMgbWVudGlvbmVkIGluIGVhcmxpZXIgcmV2aWV3cy4NClRoZSBt
ZW50aW9uZWQgYXBpIGNkbnNfcGNpZV9ob3N0X3dhaXRfZm9yX2xpbmsgaXMgYSB3cmFwcGVyIGlu
IHdoaWNoIHRoZXJlIGFyZSBtdWx0aXBsZSBjaGVja3MuDQpJZiBpbnNpc3QsIHdpbGwgcmVwbGFj
ZSB3aXRoIGl0Lg0KVGhhbmtzLA0KTmFkZWVtDQo+IA0KPiBUaGFua3MNCj4gS2lzaG9uDQo+IA0K
PiA+ICsJCQlyZXR1cm47DQo+ID4gKwl9DQo+ID4gK30NCj4gPg0KPiA+ICBzdGF0aWMgaW50IGNk
bnNfcGNpZV9ob3N0X2luaXRfcm9vdF9wb3J0KHN0cnVjdCBjZG5zX3BjaWVfcmMgKnJjKSAgew0K
PiA+IEBAIC0xMTUsNiArMTQ1LDcgQEAgc3RhdGljIGludCBjZG5zX3BjaWVfaG9zdF9pbml0X3Jv
b3RfcG9ydChzdHJ1Y3QNCj4gY2Ruc19wY2llX3JjICpyYykNCj4gPiAgCWNkbnNfcGNpZV9ycF93
cml0ZWIocGNpZSwgUENJX0NMQVNTX1BST0csIDApOw0KPiA+ICAJY2Ruc19wY2llX3JwX3dyaXRl
dyhwY2llLCBQQ0lfQ0xBU1NfREVWSUNFLA0KPiBQQ0lfQ0xBU1NfQlJJREdFX1BDSSk7DQo+ID4N
Cj4gPiArCWNkbnNfcGNpZV9yZXRyYWluKHBjaWUpOw0KPiA+ICAJcmV0dXJuIDA7DQo+ID4gIH0N
Cj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2NhZGVuY2UvcGNp
ZS1jYWRlbmNlLmgNCj4gPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvY2FkZW5jZS9wY2llLWNh
ZGVuY2UuaA0KPiA+IGluZGV4IGZlZWQxZTMwMzhmNC4uNWYxY2YwMzJhZTE1IDEwMDY0NA0KPiA+
IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvY2FkZW5jZS9wY2llLWNhZGVuY2UuaA0KPiA+
ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvY2FkZW5jZS9wY2llLWNhZGVuY2UuaA0KPiA+
IEBAIC0xMTksNyArMTE5LDcgQEANCj4gPiAgICogUm9vdCBQb3J0IFJlZ2lzdGVycyAoUENJIGNv
bmZpZ3VyYXRpb24gc3BhY2UgZm9yIHRoZSByb290IHBvcnQgZnVuY3Rpb24pDQo+ID4gICAqLw0K
PiA+ICAjZGVmaW5lIENETlNfUENJRV9SUF9CQVNFCTB4MDAyMDAwMDANCj4gPiAtDQo+ID4gKyNk
ZWZpbmUgQ0ROU19QQ0lFX1JQX0NBUF9PRkZTRVQgMHhjMA0KPiA+DQo+ID4gIC8qDQo+ID4gICAq
IEFkZHJlc3MgVHJhbnNsYXRpb24gUmVnaXN0ZXJzDQo+ID4gQEAgLTQxMyw2ICs0MTMsMTMgQEAg
c3RhdGljIGlubGluZSB2b2lkIGNkbnNfcGNpZV9ycF93cml0ZXcoc3RydWN0DQo+IGNkbnNfcGNp
ZSAqcGNpZSwNCj4gPiAgCWNkbnNfcGNpZV93cml0ZV9zeihhZGRyLCAweDIsIHZhbHVlKTsgIH0N
Cj4gPg0KPiA+ICtzdGF0aWMgaW5saW5lIHUxNiBjZG5zX3BjaWVfcnBfcmVhZHcoc3RydWN0IGNk
bnNfcGNpZSAqcGNpZSwgdTMyIHJlZykNCj4gPiArew0KPiA+ICsJdm9pZCBfX2lvbWVtICphZGRy
ID0gcGNpZS0+cmVnX2Jhc2UgKyBDRE5TX1BDSUVfUlBfQkFTRSArIHJlZzsNCj4gPiArDQo+ID4g
KwlyZXR1cm4gY2Ruc19wY2llX3JlYWRfc3ooYWRkciwgMHgyKTsgfQ0KPiA+ICsNCj4gPiAgLyog
RW5kcG9pbnQgRnVuY3Rpb24gcmVnaXN0ZXIgYWNjZXNzICovICBzdGF0aWMgaW5saW5lIHZvaWQN
Cj4gPiBjZG5zX3BjaWVfZXBfZm5fd3JpdGViKHN0cnVjdCBjZG5zX3BjaWUgKnBjaWUsIHU4IGZu
LA0KPiA+ICAJCQkJCSAgdTMyIHJlZywgdTggdmFsdWUpDQo+ID4NCg==
