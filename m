Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA1627EFCE
	for <lists+linux-pci@lfdr.de>; Wed, 30 Sep 2020 18:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgI3Q6z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Sep 2020 12:58:55 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:63558 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725872AbgI3Q6y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Sep 2020 12:58:54 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08UGsQ0L011117;
        Wed, 30 Sep 2020 09:58:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=cPV01dy1u27EnyKY3acYZMtG9HEZXWJgbvVWtWYnzXM=;
 b=AhRIUgj0qYTDkq9hDdTOAbWJxhqlEcNK6oOLe8w7ytFvb4c+wGvVBYVSU0hLHlmP0Vsj
 C3CTUcfLL7aKlkqDBsmB9hKq+pfxYihrOWFqYPBMtTlBUEnMRd8t0e06bvzxPy1GiATk
 WD9Rthht0Y4H5EP8P9iXFhna7Pc6aLPnsppfTa5SA8Rhq1P69oE+SPIk5lqs3V2ZfWS5
 6iLYNWN64Uw3yRvWuasfkGOWEXRmxLM4kGuK5CtRlYVxtVjrkVEOfiADlhUI5sr8ZJxc
 sE2QVTUL8Cc33SNC9UkGagudDeNKjOE9mpSBkm2VEcTwXYH6MzUl+qJa+tgx87KM8Rxc gQ== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2045.outbound.protection.outlook.com [104.47.74.45])
        by mx0b-0014ca01.pphosted.com with ESMTP id 33t17x7r3g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Sep 2020 09:58:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HAj6UBVFs2Y/4rMnS0oEIXiu4b5ATJfJ9NMRnFeXvzPzwz7cG5KaJOfWB3ArGmO2wuLmXgwr7KJAeZRAA+W10kTns7L5WmDgHw220zRaVMwfxq5Vo6wYRAWPB7QS6nA/t+X7FpWRc02qjNC4on6gryROUz/g/y+LMO0SF73ouyQjZJBG7DSWHKZlj7Pu1ZVcEi3HGLbhJ/A8Zo9Mk4gGa7jP+agE9ghzm2ZuUZKHhHna/wMxB1Zb5T6TOHATOgUi/dv2DuK+lfaWc+LD5HKDg28DemLy+sCeWoUYJnlC17bcsUaxWGeK89FHAclVFD+kSgxh85RBGQGlFTBLYuwfUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPV01dy1u27EnyKY3acYZMtG9HEZXWJgbvVWtWYnzXM=;
 b=Qix7Gv2p1A7c0QABVSsBS1vYcH6kGnXwm/tqwPv4hxrQJ+PYZ9hWr4K2ErKLZLI4kT/HSuZmjEuf/UI6Sf5uZgD2t1H9ar8F7M0VVgOOCMKi4hAga6jIBpdIN0fwai6pK7HNqSyjAbeo1rmmEQYcLynNf6l4Qnm3N4pAKhhAw7CktMSMJ7Y/DQPPdCZHnBGnGO3QbGmbL0Vgp1KdAYwjqSLFBxhkr2x+jJHmKbrRPagKqRzJ/L6gMlMPhedkJE//ZRKTE+8J+7gbEYesqVY1n+SIUB3Wg2OXwMLi04QCyvnqj31jgauICOJfVA1Z3NLz94Uygt++yu+8N0P314E3Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPV01dy1u27EnyKY3acYZMtG9HEZXWJgbvVWtWYnzXM=;
 b=ZQqG48CFYepaCpxE1W2ByDgTHIyyaGQgyF3HQoWR7MkX3pxg1YXYTmOCJnaYiAynaO7Wec8gv0gJXTtsN+1rueb896NWyNRllSCZ3MsHZFDQU2jo/5LGraOw2QfP2RFKvN2RUcrsm1IAHZxGJnFYYw3gb0drSEx9ogkRmSJsIJc=
Received: from SN2PR07MB2557.namprd07.prod.outlook.com (2603:10b6:804:12::9)
 by SN6PR07MB4254.namprd07.prod.outlook.com (2603:10b6:805:59::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.24; Wed, 30 Sep
 2020 16:58:33 +0000
Received: from SN2PR07MB2557.namprd07.prod.outlook.com
 ([fe80::9506:77c:74e4:caf8]) by SN2PR07MB2557.namprd07.prod.outlook.com
 ([fe80::9506:77c:74e4:caf8%11]) with mapi id 15.20.3412.029; Wed, 30 Sep 2020
 16:58:33 +0000
From:   Athani Nadeem Ladkhan <nadeem@cadence.com>
To:     Rob Herring <robh@kernel.org>
CC:     Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Milind Parab <mparab@cadence.com>,
        Swapnil Kashinath Jakhade <sjakhade@cadence.com>
Subject: RE: [PATCH v2] PCI: Cadence: Add quirk for Gen2 controller to do
 autonomous speed change.
Thread-Topic: [PATCH v2] PCI: Cadence: Add quirk for Gen2 controller to do
 autonomous speed change.
Thread-Index: AQHWkdgyO198gx0BFk+Kvm6f02xHwql2oLeAgArRBPA=
Date:   Wed, 30 Sep 2020 16:58:32 +0000
Message-ID: <SN2PR07MB25577CF3F0F2B51E14AF34AAD8330@SN2PR07MB2557.namprd07.prod.outlook.com>
References: <20200923183427.9258-1-nadeem@cadence.com>
 <CAL_Jsq+2Q+7H_DMqYSWSBV2y3==ABXxhL6NVxTHTujWR6iTsJg@mail.gmail.com>
In-Reply-To: <CAL_Jsq+2Q+7H_DMqYSWSBV2y3==ABXxhL6NVxTHTujWR6iTsJg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbmFkZWVtXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMjgyOWM1ZTQtMDMzZS0xMWViLWFlOGMtZDQ4MWQ3OWExZmRlXGFtZS10ZXN0XDI4MjljNWU2LTAzM2UtMTFlYi1hZThjLWQ0ODFkNzlhMWZkZWJvZHkudHh0IiBzej0iNDM2NyIgdD0iMTMyNDU5NTg3MDcxNzY1NjYxIiBoPSJnMHlUT2VUdHpGdjJtdFFKK3lMWjlYcm5YQzA9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [59.145.174.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f2e569a3-d614-4392-d2c4-08d86562107f
x-ms-traffictypediagnostic: SN6PR07MB4254:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR07MB42540066DA2961952076A659D8330@SN6PR07MB4254.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 97XJyAYWkEcHtSTfZORzKarrukffrS444IdRZqcO3wJmzpK9GC6g770+geOIyU0RKKuGQ9qDqNTQlrrd75kDWw/t2Dk0DLMhwnR4ly0uXCd2ULuZoFTT5alckVPE13LSP6pOMNGLwiG2yO58AsYmqybp/+5wyR3sm1rwpWw6Rsf5fhH18s/G8T90rYlwaveUusrP0dpsxepqgUboB8vNT9VdPXXRzIlzTVxBq/G+sB1Bh1TclAtIjsrKSpB83s56BdeE7pHx+AHMn5nTtX3FpwCbjxkJYzbproBddKHBC/Jlgjtcka870tkZ5f/M2MxXKfPCIEADsVJGg7KXcQjBnsgxxWhOqHYGOJUBKuCk5ybb7575gLN1apfmtTemIvCcDDccVMvRle6AkgwzmsKHmLypHBNxF05omz2yoBcTIYI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN2PR07MB2557.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(36092001)(6506007)(26005)(55016002)(5660300002)(9686003)(71200400001)(83380400001)(6916009)(86362001)(186003)(52536014)(53546011)(478600001)(7696005)(2906002)(8676002)(64756008)(66556008)(66446008)(66476007)(54906003)(316002)(33656002)(76116006)(107886003)(4326008)(8936002)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: XLkiAXoQRQbJcUUXdbSk+pA+JsSXTNnHjIsklIWWh/qt3nq62eYJlCAU/ECdWmTZzVqpX0+6/cWKFvazq8tAKRXdfiPwDPu6zR5bf5JWKKo3JIMivj49HOKXGcgTRK2VkOCcwU2zhPufBm8KEsMSr4xnKI7j03IXZMoNL0BDx3jXkGFPrDxibx3F0IrUxB1JH240k+t16NnZIJlhB1dSt0jZKfPqd1jvuP/8rvnidEwyQJjcXmYetz6xFpH9ltdGch6jcnA2Fo9iXh8UuYyUZFx5YcQCgj6iiYXOqGy03Ftou1YGJVqlcYbM5qL5XrNSz31pRjwCY1rAneqvHboDdQpvPOuaf3415GpymwVC6mTwG2Cr4V6PdfbaRcw89rljnr3j7d4AhHoVz3xD9/XHLTnmYCFUPw/aEyEGZbrkdHH9VKLW4KTXjUK2qvKh3HE/ohFgoy6B5BAeylN/puRYYBFWPnj1tTrJFxd/12cPWefVerL6OatZ2yAcBgUrzotRjizLXU7RPCmp1ZPT6Ds5vU+YfVyv6Dv3VWLHJIgycvy5/syMcmObjpURalKBf1Gb+t7Zd6a+cPY7rCsR2BWaXC2HgfvhzifV9Ts+6VbSOHtjQMKCaY19vWjh1pWmKeczQuQcdf88hTtMcbX1b2qGXg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN2PR07MB2557.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2e569a3-d614-4392-d2c4-08d86562107f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2020 16:58:32.9438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vf+GqKizI2ETAH9/ONc6chQhJseiSpk6AeyP0R1gCXRP5adEnG6q01u5q50T1llF3zwH144eawOYsLPC9VRLFkGxurURkSluUSLgrFj2Qis=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4254
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-30_09:2020-09-30,2020-09-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 adultscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 phishscore=0 mlxlogscore=999 clxscore=1015
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009300133
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgUm9iLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJvYiBIZXJy
aW5nIDxyb2JoQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFRodXJzZGF5LCBTZXB0ZW1iZXIgMjQsIDIw
MjAgMToxNiBBTQ0KPiBUbzogQXRoYW5pIE5hZGVlbSBMYWRraGFuIDxuYWRlZW1AY2FkZW5jZS5j
b20+DQo+IENjOiBUb20gSm9zZXBoIDx0am9zZXBoQGNhZGVuY2UuY29tPjsgTG9yZW56byBQaWVy
YWxpc2kNCj4gPGxvcmVuem8ucGllcmFsaXNpQGFybS5jb20+OyBCam9ybiBIZWxnYWFzIDxiaGVs
Z2Fhc0Bnb29nbGUuY29tPjsgUENJDQo+IDxsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnPjsgbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgS2lzaG9uIFZpamF5DQo+IEFicmFoYW0gSSA8a2lz
aG9uQHRpLmNvbT47IE1pbGluZCBQYXJhYiA8bXBhcmFiQGNhZGVuY2UuY29tPjsNCj4gU3dhcG5p
bCBLYXNoaW5hdGggSmFraGFkZSA8c2pha2hhZGVAY2FkZW5jZS5jb20+DQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggdjJdIFBDSTogQ2FkZW5jZTogQWRkIHF1aXJrIGZvciBHZW4yIGNvbnRyb2xsZXIg
dG8gZG8NCj4gYXV0b25vbW91cyBzcGVlZCBjaGFuZ2UuDQo+IA0KPiBFWFRFUk5BTCBNQUlMDQo+
IA0KPiANCj4gT24gV2VkLCBTZXAgMjMsIDIwMjAgYXQgMTI6MzQgUE0gTmFkZWVtIEF0aGFuaSA8
bmFkZWVtQGNhZGVuY2UuY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+IENhZGVuY2UgY29udHJvbGxl
ciB3aWxsIG5vdCBpbml0aWF0ZSBhdXRvbm9tb3VzIHNwZWVkIGNoYW5nZSBpZg0KPiA+IHN0cmFw
cGVkIGFzIEdlbjIuIFRoZSBSZXRyYWluIGJpdCBpcyBzZXQgYXMgYSBxdWlyayB0byB0cmlnZ2Vy
IHRoaXMNCj4gPiBzcGVlZCBjaGFuZ2UuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBOYWRlZW0g
QXRoYW5pIDxuYWRlZW1AY2FkZW5jZS5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvY2FkZW5jZS9wY2llLWNhZGVuY2UtaG9zdC5jIHwgMTQgKysrKysrKysrKysrKysN
Cj4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9jYWRlbmNlL3BjaWUtY2FkZW5jZS5oICAgICAg
fCAxNSArKysrKysrKysrKysrKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAyOSBpbnNlcnRpb25z
KCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9jYWRlbmNl
L3BjaWUtY2FkZW5jZS1ob3N0LmMNCj4gPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvY2FkZW5j
ZS9wY2llLWNhZGVuY2UtaG9zdC5jDQo+ID4gaW5kZXggNDU1MGUwZDQ2OWNhLi5hMjMxNzYxNDI2
OGQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9jYWRlbmNlL3BjaWUt
Y2FkZW5jZS1ob3N0LmMNCj4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2NhZGVuY2Uv
cGNpZS1jYWRlbmNlLWhvc3QuYw0KPiA+IEBAIC04Myw2ICs4Myw5IEBAIHN0YXRpYyBpbnQgY2Ru
c19wY2llX2hvc3RfaW5pdF9yb290X3BvcnQoc3RydWN0DQo+IGNkbnNfcGNpZV9yYyAqcmMpDQo+
ID4gICAgICAgICBzdHJ1Y3QgY2Ruc19wY2llICpwY2llID0gJnJjLT5wY2llOw0KPiA+ICAgICAg
ICAgdTMyIHZhbHVlLCBjdHJsOw0KPiA+ICAgICAgICAgdTMyIGlkOw0KPiA+ICsgICAgICAgdTMy
IGxpbmtfY2FwID0gQ0ROU19QQ0lFX0xJTktfQ0FQX09GRlNFVDsNCj4gPiArICAgICAgIHU4IHNs
czsNCj4gPiArICAgICAgIHUxNiBsbmtfY3RsOw0KPiA+DQo+ID4gICAgICAgICAvKg0KPiA+ICAg
ICAgICAgICogU2V0IHRoZSByb290IGNvbXBsZXggQkFSIGNvbmZpZ3VyYXRpb24gcmVnaXN0ZXI6
DQo+ID4gQEAgLTExMSw2ICsxMTQsMTcgQEAgc3RhdGljIGludCBjZG5zX3BjaWVfaG9zdF9pbml0
X3Jvb3RfcG9ydChzdHJ1Y3QNCj4gY2Ruc19wY2llX3JjICpyYykNCj4gPiAgICAgICAgIGlmIChy
Yy0+ZGV2aWNlX2lkICE9IDB4ZmZmZikNCj4gPiAgICAgICAgICAgICAgICAgY2Ruc19wY2llX3Jw
X3dyaXRldyhwY2llLCBQQ0lfREVWSUNFX0lELA0KPiA+IHJjLT5kZXZpY2VfaWQpOw0KPiA+DQo+
ID4gKyAgICAgICAvKiBRdWlyayB0byBlbmFibGUgYXV0b25vbW91cyBzcGVlZCBjaGFuZ2UgZm9y
IEdFTjIgY29udHJvbGxlciAqLw0KPiA+ICsgICAgICAgLyogUmVhZGluZyBTdXBwb3J0ZWQgTGlu
ayBTcGVlZCB2YWx1ZSAqLw0KPiA+ICsgICAgICAgc2xzID0gUENJX0VYUF9MTktDQVBfU0xTICYN
Cj4gPiArICAgICAgICAgICAgICAgY2Ruc19wY2llX3JwX3JlYWRiKHBjaWUsIGxpbmtfY2FwICsg
UENJX0VYUF9MTktDQVApOw0KPiANCj4gQSAzMi1iaXQgcmVnaXN0ZXIsIHJpZ2h0Pw0KUmlnaHQs
IHRoaXMgd2lsbCBiZSBjb3JyZWN0ZWQgaW4gcGF0Y2ggdmVyc2lvbiAzLg0KPiANCj4gPiArICAg
ICAgIGlmIChzbHMgPT0gUENJX0VYUF9MTktDQVBfU0xTXzVfMEdCKSB7DQo+ID4gKyAgICAgICAg
ICAgICAgIC8qIFNpbmNlIHRoaXMgYSBHZW4yIGNvbnRyb2xsZXIsIHNldCBSZXRyYWluIExpbmso
UkwpIGJpdCAqLw0KPiA+ICsgICAgICAgICAgICAgICBsbmtfY3RsID0gY2Ruc19wY2llX3JwX3Jl
YWR3KHBjaWUsIGxpbmtfY2FwICsgUENJX0VYUF9MTktDVEwpOw0KPiA+ICsgICAgICAgICAgICAg
ICBsbmtfY3RsIHw9IFBDSV9FWFBfTE5LQ1RMX1JMOw0KPiA+ICsgICAgICAgICAgICAgICBjZG5z
X3BjaWVfcnBfd3JpdGV3KHBjaWUsIGxpbmtfY2FwICsgUENJX0VYUF9MTktDVEwsIGxua19jdGwp
Ow0KPiA+ICsgICAgICAgfQ0KPiA+ICsNCj4gPiAgICAgICAgIGNkbnNfcGNpZV9ycF93cml0ZWIo
cGNpZSwgUENJX0NMQVNTX1JFVklTSU9OLCAwKTsNCj4gPiAgICAgICAgIGNkbnNfcGNpZV9ycF93
cml0ZWIocGNpZSwgUENJX0NMQVNTX1BST0csIDApOw0KPiA+ICAgICAgICAgY2Ruc19wY2llX3Jw
X3dyaXRldyhwY2llLCBQQ0lfQ0xBU1NfREVWSUNFLA0KPiA+IFBDSV9DTEFTU19CUklER0VfUENJ
KTsgZGlmZiAtLWdpdA0KPiA+IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9jYWRlbmNlL3BjaWUt
Y2FkZW5jZS5oDQo+ID4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2NhZGVuY2UvcGNpZS1jYWRl
bmNlLmgNCj4gPiBpbmRleCBmZWVkMWUzMDM4ZjQuLmZlNTYwNDgwYzU3MyAxMDA2NDQNCj4gPiAt
LS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2NhZGVuY2UvcGNpZS1jYWRlbmNlLmgNCj4gPiAr
KysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2NhZGVuY2UvcGNpZS1jYWRlbmNlLmgNCj4gPiBA
QCAtMTIwLDYgKzEyMCw3IEBADQo+ID4gICAqLw0KPiA+ICAjZGVmaW5lIENETlNfUENJRV9SUF9C
QVNFICAgICAgMHgwMDIwMDAwMA0KPiA+DQo+ID4gKyNkZWZpbmUgQ0ROU19QQ0lFX0xJTktfQ0FQ
X09GRlNFVCAweEMwDQo+ID4NCj4gPiAgLyoNCj4gPiAgICogQWRkcmVzcyBUcmFuc2xhdGlvbiBS
ZWdpc3RlcnMNCj4gPiBAQCAtNDEzLDYgKzQxNCwyMCBAQCBzdGF0aWMgaW5saW5lIHZvaWQgY2Ru
c19wY2llX3JwX3dyaXRldyhzdHJ1Y3QNCj4gY2Ruc19wY2llICpwY2llLA0KPiA+ICAgICAgICAg
Y2Ruc19wY2llX3dyaXRlX3N6KGFkZHIsIDB4MiwgdmFsdWUpOyAgfQ0KPiA+DQo+ID4gK3N0YXRp
YyBpbmxpbmUgdTggY2Ruc19wY2llX3JwX3JlYWRiKHN0cnVjdCBjZG5zX3BjaWUgKnBjaWUsIHUz
MiByZWcpDQo+ID4gK3sNCj4gPiArICAgICAgIHZvaWQgX19pb21lbSAqYWRkciA9IHBjaWUtPnJl
Z19iYXNlICsgQ0ROU19QQ0lFX1JQX0JBU0UgKyByZWc7DQo+ID4gKw0KPiA+ICsgICAgICAgcmV0
dXJuIGNkbnNfcGNpZV9yZWFkX3N6KGFkZHIsIDB4MSk7IH0NCj4gPiArDQo+ID4gK3N0YXRpYyBp
bmxpbmUgdTE2IGNkbnNfcGNpZV9ycF9yZWFkdyhzdHJ1Y3QgY2Ruc19wY2llICpwY2llLCB1MzIg
cmVnKQ0KPiA+ICt7DQo+ID4gKyAgICAgICB2b2lkIF9faW9tZW0gKmFkZHIgPSBwY2llLT5yZWdf
YmFzZSArIENETlNfUENJRV9SUF9CQVNFICsgcmVnOw0KPiA+ICsNCj4gPiArICAgICAgIHJldHVy
biBjZG5zX3BjaWVfcmVhZF9zeihhZGRyLCAweDIpOyB9DQo+ID4gKw0KPiA+ICAvKiBFbmRwb2lu
dCBGdW5jdGlvbiByZWdpc3RlciBhY2Nlc3MgKi8gIHN0YXRpYyBpbmxpbmUgdm9pZA0KPiA+IGNk
bnNfcGNpZV9lcF9mbl93cml0ZWIoc3RydWN0IGNkbnNfcGNpZSAqcGNpZSwgdTggZm4sDQo+ID4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdTMyIHJlZywgdTggdmFs
dWUpDQo+ID4gLS0NCj4gPiAyLjE1LjANCj4gPg0K
