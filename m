Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66AD33EEB77
	for <lists+linux-pci@lfdr.de>; Tue, 17 Aug 2021 13:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236683AbhHQLTu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Aug 2021 07:19:50 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:55890 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231515AbhHQLTu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Aug 2021 07:19:50 -0400
X-UUID: dbcb470c89a149709a094139ebe5c298-20210817
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Tr7tuitzJilGkvLYD5l+l36XytZgtqS/B3bOfn2WYkQ=;
        b=XZMTFL5yPQkLgfMVFXrd9TkJJyMtmpIDNbkuu3eq9BAKqN1o9Bpol/r1S+m+aS4d6zw78N3cQqiNB7CFULZpCI/P6tIFlQYjbdfQWCV9wzFIL0FRwDur2/bkIGaq60U9U24cX5KmduFnaKRBG2YbNc0Gspkm4iyfoeFaBWZhEpI=;
X-UUID: dbcb470c89a149709a094139ebe5c298-20210817
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <chuanjia.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1960029609; Tue, 17 Aug 2021 19:19:10 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 17 Aug 2021 19:19:09 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 17 Aug 2021 19:19:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HtYTQhEJ3NxGNHd/AuTA8o+/2SdZctCArnljiIIf73SJsryGVd4zIUM8SQLO87A+azPDKqRXtC46v3O9C86bgaLuK6B/OhWfAO12SrX2lmPs/k7fqeH9YAjIft2Tb6YDdQtpXVQpgJMWSOUwljFrJsGgCtDUWohdiViQIKiXwyH0P0cBU0+42pj/yzOwJ0HHgGugmR6ELgWCY2NNRfQz6J3LI7FTkE2pqsTf9ayiCz1kLuOTlqbO2dOXpgq5SJ5BTcUehG4rVjTc5PMPcfFio4J+zjPhKz2uwTGqIlQZV/PjQz2AT4JxTaFSiRsI4FHjpVygLKPANNgRg8R+0jOHXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tr7tuitzJilGkvLYD5l+l36XytZgtqS/B3bOfn2WYkQ=;
 b=eFjhxfyoEHSorjTIN5Mj63G/CPZQlg7d3ddiPBPpS/a0rY29ZO8uuYvxGy5oq4I+lqn8O8wxcydp0PS8N4lssn1Up1NrcbjztT/FTo9dxlj1sEa7YtytZJ2C5DP+H7qA/amRoNbFnFrxFlkCHZLJQyZzUx34vlROGVlKc/c7qOgcFmgVpaYA6QQU/2R5FjwXp9/WDsCFOmP0DX4L2kewsUCv4vU/YvRT4evs70YqwSY4Gax5lpviptTm1u5rs/cUn16S181O7rNSqTgFmQu+IWucZOa8jstocGL1SYV4BHCVDBDHrObajpMeVKieEVXzjjAjypgEpa1+qkk79rkLmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tr7tuitzJilGkvLYD5l+l36XytZgtqS/B3bOfn2WYkQ=;
 b=YRfmusK8oA5GBufw0yBP+rtpoOICHB7mRVP1X2ZZrQvneA4HrmLZ5okKVjY6BLGa5zQW3gzx2PWx37PnX0uD6Pl5YjKR4uSAh5pAIav+C82Mk9pSeDO8x0H249CnWEwsoCiEtJan8dBx2Udt60qnPNh1uYqg15A+yVSZxCoOOxQ=
Received: from KL1PR03MB4694.apcprd03.prod.outlook.com (2603:1096:820:12::14)
 by KL1PR0302MB5380.apcprd03.prod.outlook.com (2603:1096:820:33::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.14; Tue, 17 Aug
 2021 11:18:55 +0000
Received: from KL1PR03MB4694.apcprd03.prod.outlook.com
 ([fe80::88a8:25ac:66d5:5ec1]) by KL1PR03MB4694.apcprd03.prod.outlook.com
 ([fe80::88a8:25ac:66d5:5ec1%7]) with mapi id 15.20.4436.018; Tue, 17 Aug 2021
 11:18:55 +0000
From:   =?utf-8?B?Q2h1YW5qaWEgTGl1ICjmn7PkvKDlmIkp?= 
        <Chuanjia.Liu@mediatek.com>
To:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "frank-w@public-files.de" <frank-w@public-files.de>,
        =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>,
        =?utf-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?= 
        <Jianjun.Wang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        =?utf-8?B?UnlkZXIgTGVlICjmnY7luproq7op?= <Ryder.Lee@mediatek.com>
Subject: Re: [PATCH v11 2/4] PCI: mediatek: Add new method to get shared
 pcie-cfg base address and parse node
Thread-Topic: [PATCH v11 2/4] PCI: mediatek: Add new method to get shared
 pcie-cfg base address and parse node
Thread-Index: AQHXfHE58Vwso+DZ00iND05GAYdwVqttRusAgARuTgCABgU5gA==
Date:   Tue, 17 Aug 2021 11:18:54 +0000
Message-ID: <55495cac6a6f7bd3efc2e2932a2a4b4a76789e94.camel@mediatek.com>
References: <20210719073456.28666-3-chuanjia.liu@mediatek.com>
         <20210810194250.GA2276275@bjorn-Precision-5520>
         <20210813152239.GA15515@lpieralisi>
In-Reply-To: <20210813152239.GA15515@lpieralisi>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dfd1c974-ed0a-4ac2-5368-08d96170cce4
x-ms-traffictypediagnostic: KL1PR0302MB5380:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <KL1PR0302MB5380D83C5BB048EEACB305F0E6FE9@KL1PR0302MB5380.apcprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NJntBDBL3xejjw9Oxw+Vy3UbZ8KF82QztAuQ0ouOu8LKAXuc2U/GfQOpJqaELPZjhMqz5X6XSMbKhSwo6Z36NplBFiAgdE0cA54GNnNbbtM1Q/3QAsQCY2yptOr+jeDwbtZZkfF/7WNhFG8h1bvQfVOjcqiGuQ6BWb9VDHJYbHR3kErnE+Ye/8PI6dRcKYe99m1igmdQQjsM78J4fNn0SyIwSXnZsZDh1SrRgSy13ErGl3uwg9o9nKFxx9JAMMLJJXWcJ2CiiEGKF1JERhc5Dqhs1Ou+NK/Eu/4rol5Xj+wmTVyV5kU7OyFMYZc0LwxBaHXFdSvO2RkI+17pz0pOuQmYTlze+1lms8Kr+KjlKPb7j5hAxrm8z4im1WVz48bOe2zbxZhOHa6vT3ccchsx/Fg2UJH2o3wflwi5+AT4MCyjJ7/cYOTQonN6scP3jH08h0STBn9zPw/6Aje+YJvCnV84veAW9FiSuie65uzmAgr/opdP+Zoqt8b+iedjMOREoLHZg5dDO57kzmLFf2l57OyctQZB8CVqgdifz1mLL+4P6FX6T1VvgT+ThVpXZ7CEOF4gcRDxbVd/NTaeg25XOkdBfMRbeit/gspgFwIxsMlVN8b29A1cC+Ze9Dp74mcw+pDkpcJaE1sOSOzGbPsypU9xsmu+mzC8JuA5nH3MQekdeHdyCztH1p5eA9lvXvPGBF9sBR442fQAcUxuTXcUiA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB4694.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(38070700005)(2906002)(5660300002)(6506007)(36756003)(6486002)(38100700002)(7416002)(6512007)(508600001)(83380400001)(76116006)(91956017)(66446008)(64756008)(66556008)(186003)(8936002)(26005)(2616005)(107886003)(71200400001)(316002)(8676002)(4326008)(86362001)(110136005)(66946007)(122000001)(85182001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjZzZGxmaDNLbEdVUmdmRnhwaU9Ic0g3Y25tRlAzLzZudVVodm1pTDRkU0dJ?=
 =?utf-8?B?MnhQR1lmNmlwZEVOcjlqQzQ3RlFTNkY2Vmx0c2drL25laHhqK2NFMUhsdjg2?=
 =?utf-8?B?eWt6SXRpd1p2YkJ6c0g1dk9nVFd1UHBWN3EwVTdIWlN5VTZVV3IrckZoR2p4?=
 =?utf-8?B?b1VsNDNoVW9HcENLU3Zjb3FHZDdEQ0czL3NsZTVDdDRPOUtxYmlQWkNncmc5?=
 =?utf-8?B?Z0ZlY2IvazluQkJ6U2RuYTJEZUNxWDJXSjVoNS8rdzVWaE5DblEwMUtmeFA0?=
 =?utf-8?B?T0hSL0R1d2tFYXppN3VDQzlHV3pYdTE0aCt1TFZTdWJDTGpadXdPUW52SEJl?=
 =?utf-8?B?bjJML0NOa2RXZGtab1Yrd05veDUyWU4rTGtTS1pNSTB2NTIrTEd1OVZKZU5P?=
 =?utf-8?B?MHFzTmpNT2FFc1FTemZYTUZlWWxLRXAyODFCbFY3ZVlwUitzb0YzRkxvZmZo?=
 =?utf-8?B?WThTVTlOdVpqcWNzczJuazhyY1dIZ0FIRHFVVzdtR0VLT3UxQmlRajFEQkE0?=
 =?utf-8?B?NEE2aXRHVm5TWWVRenpLdVlOSkNLa1pZakM0V0U3L2pOejJwdmFtSm5uVXJH?=
 =?utf-8?B?eWZDeVhKR3Fzbm5CR2wwRFd1RDNUQTRoWFduNFlScWxxT0VjVkJGbDYvcC9y?=
 =?utf-8?B?NGg3YlduL2d4bFozdE5SVXQ4YW1kMnVORFJMbFBCYXhQTmw5VXAwWmF4Nk5k?=
 =?utf-8?B?N2p5OS9WcmNHNTZZTHpUTXJrNnpENmU5YjQxSHhoVUxjMmZRdDlyTExkdUJE?=
 =?utf-8?B?RnlaOGJ6eDZOVy9FUEtHRElCeXVXRjBpSk9BNFV3ZWZvaG9TMXJjUHNqWGlU?=
 =?utf-8?B?N1ZBRVJGNTVtaEYyUUNjMG0yOFBwR3owdkVLVVU4VGU5VVU1OS9BbHFXeTk1?=
 =?utf-8?B?RmpOdG1Bemp3ZDZiejByU3JXWjJXdmQyR1Q0OUtPS0tDa2g5d3VLRXJoWkVB?=
 =?utf-8?B?c2w5VDZhOHQzbFEyVjhaQTVRcytjaWl4c25oTjFoZkpNbS92K2d4bnFpVDdE?=
 =?utf-8?B?MGRrdHdQN2U0TFhlOUFyNmhCaW5JM093OUk2NFF5cTNVdHdpeFBZNmVUM3N1?=
 =?utf-8?B?YzJJZ1Blay8wYWFMNjRVQkxHdEFwcTluckMrVzh0RHNhRlFVOWJZNFgrRU9U?=
 =?utf-8?B?bVZONmtTNUdKcFFhZTBGK21aZnk5N3VkTnZNdytBMk9nVW04TC81VHltVC9q?=
 =?utf-8?B?enYwYWk0VGFiKzNhTlpZOXZ3Y1N3TXAzVGNZWVNUTldSdjZMUnpDaEd0OXZ1?=
 =?utf-8?B?MU52Z2VHYTJqVnBScUxsRmtmd3pBZ0QvRWxsQTd1MUlrWm1IOG5PT3h2SzlY?=
 =?utf-8?B?VytGNGswT3FFRmZWMWxkdnRpTVBCYnQvL2QrWElMQnJXeVoyanpRWkkvOThv?=
 =?utf-8?B?YmNHeW45WFdMbTBvRVNLWUF3a1dxU09yMEw3Sm04QTE1bVJWK0RJTFFNak03?=
 =?utf-8?B?V1dObWc0cUhYYlFaaDIzRU1NMGlMRTRscnZPaUloT3BtVWptZUh3ckt0dTZj?=
 =?utf-8?B?UFZKNnBBUVRZVWFLMG5ncE00blZwa2labDZuQ1dycXRYemZiN01wTStlMjhs?=
 =?utf-8?B?NC9nbzY1THdvQ3JILzN1a1ZJbFE4QnVmbys3c2YyVFczVGtJTlcyNHIzWWdV?=
 =?utf-8?B?ZDhZa2dISE0yYldldGZHZEJsMXhHN3dmSllMalFZZ0dQNTMxUHBxK2lQWmpk?=
 =?utf-8?B?WlppajJYMDVoZHZkMzgxTitaeG5wdGgyUnNISHZsV3pOL01SMXh3TXJxL3Ro?=
 =?utf-8?Q?um1R/oQwP1lhRB3cYwPFAshnHMQV6JQAmFumh+4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D9B7AF417C08384A9E2B4FE5A2B702A0@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB4694.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfd1c974-ed0a-4ac2-5368-08d96170cce4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 11:18:55.0063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4dbWT4rY90MZVbFV4ddg/cqcOS4HrwwE4d30zS20y19cDY6IKzgk45QcsSifwBKCBjQJDcwvKptv4mInWF24aT5aBMroYeNWMk0d1zoSiXQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0302MB5380
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gRnJpLCAyMDIxLTA4LTEzIGF0IDE2OjIyICswMTAwLCBMb3JlbnpvIFBpZXJhbGlzaSB3cm90
ZToNCj4gT24gVHVlLCBBdWcgMTAsIDIwMjEgYXQgMDI6NDI6NTBQTSAtMDUwMCwgQmpvcm4gSGVs
Z2FhcyB3cm90ZToNCj4gPiBPbiBNb24sIEp1bCAxOSwgMjAyMSBhdCAwMzozNDo1NFBNICswODAw
LCBDaHVhbmppYSBMaXUgd3JvdGU6DQo+ID4gPiBGb3IgdGhlIG5ldyBkdHMgZm9ybWF0LCBhZGQg
YSBuZXcgbWV0aG9kIHRvIGdldA0KPiA+ID4gc2hhcmVkIHBjaWUtY2ZnIGJhc2UgYWRkcmVzcyBh
bmQgcGFyc2Ugbm9kZS4NCj4gPiANCj4gPiBUaGlzIGNvbW1pdCBsb2cgZG9lc24ndCBzZWVtIHRv
IHJlYWxseSBjb3ZlciB3aGF0J3MgZ29pbmcgb24NCj4gPiBoZXJlLiAgSXQNCj4gPiBsb29rcyBs
aWtlOg0KPiA+IA0KPiA+ICAgLSBZb3UgYWRkZWQgYSBjaGVjayBmb3IgIm1lZGlhdGVrLGdlbmVy
aWMtcGNpZWNmZyIgKEkgZ3Vlc3MgdGhpcw0KPiA+IGlzDQo+ID4gICAgIHRoZSAic2hhcmVkIHBj
aWUtY2ZnIGJhc2UgYWRkcmVzcyIgcGFydCkuICBQcm9iYWJseSBjb3VsZCBoYXZlDQo+ID4gICAg
IGJlZW4gaXRzIG93biBwYXRjaC4NCj4gPiANCj4gPiAgIC0gWW91IGFkZGVkIGNoZWNrcyBmb3Ig
ImludGVycnVwdC1uYW1lcyIgYW5kICJwY2llX2lycSIuICBOb3QNCj4gPiAgICAgZXhwbGFpbmVk
IGluIGNvbW1pdCBsb2c7IHByb2JhYmx5IGNvdWxkIGhhdmUgYmVlbiBpdHMgb3duDQo+ID4gcGF0
Y2gsDQo+ID4gICAgIHRvby4NCj4gPiANCj4gPiAgIC0gWW91IG5vdyBsb29rIGZvciAibGludXgs
cGNpLWRvbWFpbiIgKHZpYQ0KPiA+IG9mX2dldF9wY2lfZG9tYWluX25yKCkpLg0KPiA+ICAgICBJ
ZiBwcmVzZW50LCB5b3UgcGFyc2Ugb25seSBvbmUgcG9ydCBpbnN0ZWFkIG9mIGxvb2tpbmcgZm9y
IGFsbA0KPiA+IHRoZQ0KPiA+ICAgICBjaGlsZHJlbiBvZiB0aGUgbm9kZS4NCj4gPiANCj4gPiAg
ICAgVGhhdCdzIHNvcnQgb2Ygd2VpcmQgYmVoYXZpb3IgLS0gd2h5IHNob3VsZCB0aGUgcHJlc2Vu
Y2Ugb2YNCj4gPiAgICAgImxpbnV4LHBjaS1kb21haW4iIGRldGVybWluZSB3aGV0aGVyIHRoZSBu
b2RlIGNhbiBoYXZlDQo+ID4gY2hpbGRyZW4/DQo+ID4gICAgIElzIHRoYXQgcmVhbGx5IHdoYXQg
eW91IGludGVuZD8NCj4gPiANCj4gPiAgICAgU2hvdWxkIGJlIGV4cGxhaW5lZCBpbiB0aGUgY29t
bWl0IGxvZyBhbmQgY291bGQgaGF2ZSBiZWVuIGl0cw0KPiA+IG93bg0KPiA+ICAgICBwYXRjaCwg
dG9vLg0KaGksIEJqb3JuLA0KWWVzLCB0aGlzIGlzIG15IGludGVudGlvbiwiTGludXgscGNpLWRv
bWFpbiIgaGFzIHR3byBwdXJwb3Nlcw0KMSlEaXN0aW5ndWlzaCB0aGUgb2xkIGFuZCBuZXcgZHRz
IGZvcm1hdHMsIHRoZW4gcGFyc2UgdGhlbQ0KMilEZXRlcm1pbmUgdGhlIGN1cnJlbnQgcGNpZSBz
bG90IG51bSBpbiBuZXcgZHRzIGZvcm1hdCwgYmVjYXVzZSB0aGUNCm9mZnNldCBvZiBzb21lIHJl
Z3MgbmVlZHMgdG8gYmUgYmFzZWQgb24gc2xvdCBudW0NCg0KSSB3aWxsIHNwbGl0IHRoaXMgcGF0
Y2ggaW50byB0aHJlZSBwYXRjaGVzLCBhbmQgdGhlbiBleHBsYWluIHRoZW0gaW4NCmNvbW1pdCBs
b2csIHRoYW5rcyBmb3IgeW91ciBjb21tZW50Lg0KPiANCj4gSSBhZ3JlZSB3aXRoIEJqb3JuLCB0
aGlzIHBhdGNoIHNob3VsZCBiZSBzcGxpdCAoYW5kIGNvbW1pdCBsb2dzDQo+IHJld3JpdHRlbiku
IEkgd2lsbCBkcm9wIGl0IGZyb20gbXkgdHJlZSwgd2FpdGluZyBmb3IgYSB2MTIuDQo+IA0KPiBM
b3JlbnpvDQoNCmhpLCBMb3JlbnpvDQpUaGFua3MgZm9yIHlvdXIgY29uZmlybWF0aW9uLCBJIHdp
bGwgc2VuZCB0aGUgVjEyIHZlcnNpb24gYXMgc29vbiBhcw0KcG9zc2libGUuDQoNCkNodWFuamlh
DQo+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogQ2h1YW5qaWEgTGl1IDxjaHVhbmppYS5saXVAbWVk
aWF0ZWsuY29tPg0KPiA+ID4gQWNrZWQtYnk6IFJ5ZGVyIExlZSA8cnlkZXIubGVlQG1lZGlhdGVr
LmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tZWRp
YXRlay5jIHwgNTIgKysrKysrKysrKysrKysrKysrKy0NCj4gPiA+IC0tLS0tLQ0KPiA+ID4gIDEg
ZmlsZSBjaGFuZ2VkLCAzOSBpbnNlcnRpb25zKCspLCAxMyBkZWxldGlvbnMoLSkNCj4gPiA+IA0K
PiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tZWRpYXRlay5j
DQo+ID4gPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tZWRpYXRlay5jDQo+ID4gPiBp
bmRleCAyNWJlZTY5MzgzNGYuLjkyOGUwOTgzYTkwMCAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tZWRpYXRlay5jDQo+ID4gPiArKysgYi9kcml2ZXJzL3Bj
aS9jb250cm9sbGVyL3BjaWUtbWVkaWF0ZWsuYw0KPiA+ID4gQEAgLTE0LDYgKzE0LDcgQEANCj4g
PiA+ICAjaW5jbHVkZSA8bGludXgvaXJxY2hpcC9jaGFpbmVkX2lycS5oPg0KPiA+ID4gICNpbmNs
dWRlIDxsaW51eC9pcnFkb21haW4uaD4NCj4gPiA+ICAjaW5jbHVkZSA8bGludXgva2VybmVsLmg+
DQo+ID4gPiArI2luY2x1ZGUgPGxpbnV4L21mZC9zeXNjb24uaD4NCj4gPiA+ICAjaW5jbHVkZSA8
bGludXgvbXNpLmg+DQo+ID4gPiAgI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KPiA+ID4gICNp
bmNsdWRlIDxsaW51eC9vZl9hZGRyZXNzLmg+DQo+ID4gPiBAQCAtMjMsNiArMjQsNyBAQA0KPiA+
ID4gICNpbmNsdWRlIDxsaW51eC9waHkvcGh5Lmg+DQo+ID4gPiAgI2luY2x1ZGUgPGxpbnV4L3Bs
YXRmb3JtX2RldmljZS5oPg0KPiA+ID4gICNpbmNsdWRlIDxsaW51eC9wbV9ydW50aW1lLmg+DQo+
ID4gPiArI2luY2x1ZGUgPGxpbnV4L3JlZ21hcC5oPg0KPiA+ID4gICNpbmNsdWRlIDxsaW51eC9y
ZXNldC5oPg0KPiA+ID4gIA0KPiA+ID4gICNpbmNsdWRlICIuLi9wY2kuaCINCj4gPiA+IEBAIC0y
MDcsNiArMjA5LDcgQEAgc3RydWN0IG10a19wY2llX3BvcnQgew0KPiA+ID4gICAqIHN0cnVjdCBt
dGtfcGNpZSAtIFBDSWUgaG9zdCBpbmZvcm1hdGlvbg0KPiA+ID4gICAqIEBkZXY6IHBvaW50ZXIg
dG8gUENJZSBkZXZpY2UNCj4gPiA+ICAgKiBAYmFzZTogSU8gbWFwcGVkIHJlZ2lzdGVyIGJhc2UN
Cj4gPiA+ICsgKiBAY2ZnOiBJTyBtYXBwZWQgcmVnaXN0ZXIgbWFwIGZvciBQQ0llIGNvbmZpZw0K
PiA+ID4gICAqIEBmcmVlX2NrOiBmcmVlLXJ1biByZWZlcmVuY2UgY2xvY2sNCj4gPiA+ICAgKiBA
bWVtOiBub24tcHJlZmV0Y2hhYmxlIG1lbW9yeSByZXNvdXJjZQ0KPiA+ID4gICAqIEBwb3J0czog
cG9pbnRlciB0byBQQ0llIHBvcnQgaW5mb3JtYXRpb24NCj4gPiA+IEBAIC0yMTUsNiArMjE4LDcg
QEAgc3RydWN0IG10a19wY2llX3BvcnQgew0KPiA+ID4gIHN0cnVjdCBtdGtfcGNpZSB7DQo+ID4g
PiAgCXN0cnVjdCBkZXZpY2UgKmRldjsNCj4gPiA+ICAJdm9pZCBfX2lvbWVtICpiYXNlOw0KPiA+
ID4gKwlzdHJ1Y3QgcmVnbWFwICpjZmc7DQo+ID4gPiAgCXN0cnVjdCBjbGsgKmZyZWVfY2s7DQo+
ID4gPiAgDQo+ID4gPiAgCXN0cnVjdCBsaXN0X2hlYWQgcG9ydHM7DQo+ID4gPiBAQCAtNjUwLDcg
KzY1NCwxMSBAQCBzdGF0aWMgaW50IG10a19wY2llX3NldHVwX2lycShzdHJ1Y3QNCj4gPiA+IG10
a19wY2llX3BvcnQgKnBvcnQsDQo+ID4gPiAgCQlyZXR1cm4gZXJyOw0KPiA+ID4gIAl9DQo+ID4g
PiAgDQo+ID4gPiAtCXBvcnQtPmlycSA9IHBsYXRmb3JtX2dldF9pcnEocGRldiwgcG9ydC0+c2xv
dCk7DQo+ID4gPiArCWlmIChvZl9maW5kX3Byb3BlcnR5KGRldi0+b2Zfbm9kZSwgImludGVycnVw
dC1uYW1lcyIsIE5VTEwpKQ0KPiA+ID4gKwkJcG9ydC0+aXJxID0gcGxhdGZvcm1fZ2V0X2lycV9i
eW5hbWUocGRldiwgInBjaWVfaXJxIik7DQo+ID4gPiArCWVsc2UNCj4gPiA+ICsJCXBvcnQtPmly
cSA9IHBsYXRmb3JtX2dldF9pcnEocGRldiwgcG9ydC0+c2xvdCk7DQo+ID4gPiArDQo+ID4gPiAg
CWlmIChwb3J0LT5pcnEgPCAwKQ0KPiA+ID4gIAkJcmV0dXJuIHBvcnQtPmlycTsNCj4gPiA+ICAN
Cj4gPiA+IEBAIC02ODIsNiArNjkwLDEwIEBAIHN0YXRpYyBpbnQgbXRrX3BjaWVfc3RhcnR1cF9w
b3J0X3YyKHN0cnVjdA0KPiA+ID4gbXRrX3BjaWVfcG9ydCAqcG9ydCkNCj4gPiA+ICAJCXZhbCB8
PSBQQ0lFX0NTUl9MVFNTTV9FTihwb3J0LT5zbG90KSB8DQo+ID4gPiAgCQkgICAgICAgUENJRV9D
U1JfQVNQTV9MMV9FTihwb3J0LT5zbG90KTsNCj4gPiA+ICAJCXdyaXRlbCh2YWwsIHBjaWUtPmJh
c2UgKyBQQ0lFX1NZU19DRkdfVjIpOw0KPiA+ID4gKwl9IGVsc2UgaWYgKHBjaWUtPmNmZykgew0K
PiA+ID4gKwkJdmFsID0gUENJRV9DU1JfTFRTU01fRU4ocG9ydC0+c2xvdCkgfA0KPiA+ID4gKwkJ
ICAgICAgUENJRV9DU1JfQVNQTV9MMV9FTihwb3J0LT5zbG90KTsNCj4gPiA+ICsJCXJlZ21hcF91
cGRhdGVfYml0cyhwY2llLT5jZmcsIFBDSUVfU1lTX0NGR19WMiwgdmFsLA0KPiA+ID4gdmFsKTsN
Cj4gPiA+ICAJfQ0KPiA+ID4gIA0KPiA+ID4gIAkvKiBBc3NlcnQgYWxsIHJlc2V0IHNpZ25hbHMg
Ki8NCj4gPiA+IEBAIC05ODUsNiArOTk3LDcgQEAgc3RhdGljIGludCBtdGtfcGNpZV9zdWJzeXNf
cG93ZXJ1cChzdHJ1Y3QNCj4gPiA+IG10a19wY2llICpwY2llKQ0KPiA+ID4gIAlzdHJ1Y3QgZGV2
aWNlICpkZXYgPSBwY2llLT5kZXY7DQo+ID4gPiAgCXN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBk
ZXYgPSB0b19wbGF0Zm9ybV9kZXZpY2UoZGV2KTsNCj4gPiA+ICAJc3RydWN0IHJlc291cmNlICpy
ZWdzOw0KPiA+ID4gKwlzdHJ1Y3QgZGV2aWNlX25vZGUgKmNmZ19ub2RlOw0KPiA+ID4gIAlpbnQg
ZXJyOw0KPiA+ID4gIA0KPiA+ID4gIAkvKiBnZXQgc2hhcmVkIHJlZ2lzdGVycywgd2hpY2ggYXJl
IG9wdGlvbmFsICovDQo+ID4gPiBAQCAtOTk1LDYgKzEwMDgsMTQgQEAgc3RhdGljIGludCBtdGtf
cGNpZV9zdWJzeXNfcG93ZXJ1cChzdHJ1Y3QNCj4gPiA+IG10a19wY2llICpwY2llKQ0KPiA+ID4g
IAkJCXJldHVybiBQVFJfRVJSKHBjaWUtPmJhc2UpOw0KPiA+ID4gIAl9DQo+ID4gPiAgDQo+ID4g
PiArCWNmZ19ub2RlID0gb2ZfZmluZF9jb21wYXRpYmxlX25vZGUoTlVMTCwgTlVMTCwNCj4gPiA+
ICsJCQkJCSAgICJtZWRpYXRlayxnZW5lcmljLXBjaWVjZmciKTsNCj4gPiA+ICsJaWYgKGNmZ19u
b2RlKSB7DQo+ID4gPiArCQlwY2llLT5jZmcgPSBzeXNjb25fbm9kZV90b19yZWdtYXAoY2ZnX25v
ZGUpOw0KPiA+ID4gKwkJaWYgKElTX0VSUihwY2llLT5jZmcpKQ0KPiA+ID4gKwkJCXJldHVybiBQ
VFJfRVJSKHBjaWUtPmNmZyk7DQo+ID4gPiArCX0NCj4gPiA+ICsNCj4gPiA+ICAJcGNpZS0+ZnJl
ZV9jayA9IGRldm1fY2xrX2dldChkZXYsICJmcmVlX2NrIik7DQo+ID4gPiAgCWlmIChJU19FUlIo
cGNpZS0+ZnJlZV9jaykpIHsNCj4gPiA+ICAJCWlmIChQVFJfRVJSKHBjaWUtPmZyZWVfY2spID09
IC1FUFJPQkVfREVGRVIpDQo+ID4gPiBAQCAtMTAyNywyMiArMTA0OCwyNyBAQCBzdGF0aWMgaW50
IG10a19wY2llX3NldHVwKHN0cnVjdCBtdGtfcGNpZQ0KPiA+ID4gKnBjaWUpDQo+ID4gPiAgCXN0
cnVjdCBkZXZpY2UgKmRldiA9IHBjaWUtPmRldjsNCj4gPiA+ICAJc3RydWN0IGRldmljZV9ub2Rl
ICpub2RlID0gZGV2LT5vZl9ub2RlLCAqY2hpbGQ7DQo+ID4gPiAgCXN0cnVjdCBtdGtfcGNpZV9w
b3J0ICpwb3J0LCAqdG1wOw0KPiA+ID4gLQlpbnQgZXJyOw0KPiA+ID4gKwlpbnQgZXJyLCBzbG90
Ow0KPiA+ID4gKw0KPiA+ID4gKwlzbG90ID0gb2ZfZ2V0X3BjaV9kb21haW5fbnIoZGV2LT5vZl9u
b2RlKTsNCj4gPiA+ICsJaWYgKHNsb3QgPCAwKSB7DQo+ID4gPiArCQlmb3JfZWFjaF9hdmFpbGFi
bGVfY2hpbGRfb2Zfbm9kZShub2RlLCBjaGlsZCkgew0KPiA+ID4gKwkJCWVyciA9IG9mX3BjaV9n
ZXRfZGV2Zm4oY2hpbGQpOw0KPiA+ID4gKwkJCWlmIChlcnIgPCAwKSB7DQo+ID4gPiArCQkJCWRl
dl9lcnIoZGV2LCAiZmFpbGVkIHRvIGdldCBkZXZmbjoNCj4gPiA+ICVkXG4iLCBlcnIpOw0KPiA+
ID4gKwkJCQlnb3RvIGVycm9yX3B1dF9ub2RlOw0KPiA+ID4gKwkJCX0NCj4gPiA+ICANCj4gPiA+
IC0JZm9yX2VhY2hfYXZhaWxhYmxlX2NoaWxkX29mX25vZGUobm9kZSwgY2hpbGQpIHsNCj4gPiA+
IC0JCWludCBzbG90Ow0KPiA+ID4gKwkJCXNsb3QgPSBQQ0lfU0xPVChlcnIpOw0KPiA+ID4gIA0K
PiA+ID4gLQkJZXJyID0gb2ZfcGNpX2dldF9kZXZmbihjaGlsZCk7DQo+ID4gPiAtCQlpZiAoZXJy
IDwgMCkgew0KPiA+ID4gLQkJCWRldl9lcnIoZGV2LCAiZmFpbGVkIHRvIHBhcnNlIGRldmZuOiAl
ZFxuIiwNCj4gPiA+IGVycik7DQo+ID4gPiAtCQkJZ290byBlcnJvcl9wdXRfbm9kZTsNCj4gPiA+
ICsJCQllcnIgPSBtdGtfcGNpZV9wYXJzZV9wb3J0KHBjaWUsIGNoaWxkLCBzbG90KTsNCj4gPiA+
ICsJCQlpZiAoZXJyKQ0KPiA+ID4gKwkJCQlnb3RvIGVycm9yX3B1dF9ub2RlOw0KPiA+ID4gIAkJ
fQ0KPiA+ID4gLQ0KPiA+ID4gLQkJc2xvdCA9IFBDSV9TTE9UKGVycik7DQo+ID4gPiAtDQo+ID4g
PiAtCQllcnIgPSBtdGtfcGNpZV9wYXJzZV9wb3J0KHBjaWUsIGNoaWxkLCBzbG90KTsNCj4gPiA+
ICsJfSBlbHNlIHsNCj4gPiA+ICsJCWVyciA9IG10a19wY2llX3BhcnNlX3BvcnQocGNpZSwgbm9k
ZSwgc2xvdCk7DQo+ID4gPiAgCQlpZiAoZXJyKQ0KPiA+ID4gLQkJCWdvdG8gZXJyb3JfcHV0X25v
ZGU7DQo+ID4gPiArCQkJcmV0dXJuIGVycjsNCj4gPiA+ICAJfQ0KPiA+ID4gIA0KPiA+ID4gIAll
cnIgPSBtdGtfcGNpZV9zdWJzeXNfcG93ZXJ1cChwY2llKTsNCj4gPiA+IC0tIA0KPiA+ID4gMi4x
OC4wDQo+ID4gPiANCg==
