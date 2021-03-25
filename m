Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D61D63486E8
	for <lists+linux-pci@lfdr.de>; Thu, 25 Mar 2021 03:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234538AbhCYCWh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Mar 2021 22:22:37 -0400
Received: from mail-eopbgr80074.outbound.protection.outlook.com ([40.107.8.74]:32386
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234794AbhCYCWG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Mar 2021 22:22:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=my/xCs+HNOpesxG1pN1IaKSQcUL4AWZp1RL2CvnmaNRF+D753jgpDoKdNLGnzDcHHWx8R0kjdkTAjnoH/WO5R71OqyhxCMOq4l2nVqVxyyprIsNlFPG/MW6vjxxRDd670ZKLNPdxYYyQZz/dc1aflGlstX7nwzLuCXVVDB/nU3Rn5T1/xpYpvBh/18RH4eWGmwCpmpKyjcMkfaOrsGpEH/A5TAQ1FnhR8V2CQLkqUcR7g6/hmHyi/ZP/MBRHwwB1qJyB8KkILM9KaDoRDch3cjrE/ZT9o4uuFTgs2aDkYM5mspfSfYgtTOu6G0Raz+PUYgklEOXXnjzRZsAgyh5qqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1dAQZRdIBFyGpUW7xf//F2GMOOhRC67cOYQXnukHf/s=;
 b=X7Qyq0+8BfNvi8hQr7fD8653CpDWMjdEOTsXiMCdW8ujIWdPOhWOFwx9QcHOCyznFppb2abTMGYl6YHV35vmPsFM/tQuQQjtZY2Wpqa91V60jlPMU7duTgnNl4jA6RcgSSgChBi55f75BGr6d8zvljmcC6Ea6FuPE3pLVJnxdhIxJPOioDqSxn3rtACGtLX4fVQjHjKMF/QI3v8MgohllITimNtIihKJFhyLYI6y0gxDk4dWicKj+y6expLKfl0mzKdXw4SocK1QW1Zb7TbouI18YlUDXp0kyhDMj1tVLzTNHKF9lVzkFFSREo8+87yED+77NvJWxWxW+Fwq6eDB7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1dAQZRdIBFyGpUW7xf//F2GMOOhRC67cOYQXnukHf/s=;
 b=SY5Ypjwjiuk7wCZ+Mdy+qXlhm6zZJ5B1QL0GQXiigaggfg8Dw0KUtucMf8znkHlG2hog6Qt9vyfvMvZU9QB+8wIbOK6I+ZszXU7zq2aBDmdQ42BEvid17hmRiiZTEOPaiW9GwHKTi/18I01XcNjoH8M+3o2iZx0eRTfzUR4qS1E=
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com (2603:10a6:803:e3::25)
 by VE1PR04MB6701.eurprd04.prod.outlook.com (2603:10a6:803:124::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Thu, 25 Mar
 2021 02:22:02 +0000
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::8116:97ef:2fd7:251f]) by VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::8116:97ef:2fd7:251f%7]) with mapi id 15.20.3955.027; Thu, 25 Mar 2021
 02:22:02 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [EXT] Re: [PATCH v2 3/3] PCI: imx: clear vreg bypass when pcie
 vph voltage is 3v3
Thread-Topic: [EXT] Re: [PATCH v2 3/3] PCI: imx: clear vreg bypass when pcie
 vph voltage is 3v3
Thread-Index: AQHXIHFEULS67H7UIEevLPo6SZdalKqS37KAgAEVxfA=
Date:   Thu, 25 Mar 2021 02:22:02 +0000
Message-ID: <VI1PR04MB585360F9041FA67CA6D354FF8C629@VI1PR04MB5853.eurprd04.prod.outlook.com>
References: <1616564059-8713-1-git-send-email-hongxing.zhu@nxp.com>
         <1616564059-8713-4-git-send-email-hongxing.zhu@nxp.com>
 <6d31825ab3c47bb2e3440445b1dad3f4f1c53c44.camel@pengutronix.de>
In-Reply-To: <6d31825ab3c47bb2e3440445b1dad3f4f1c53c44.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ac3d73a6-4788-4827-481b-08d8ef34c6a3
x-ms-traffictypediagnostic: VE1PR04MB6701:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB6701F641080F72E686ADFB9E8C629@VE1PR04MB6701.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KswVZMC/E4bSAAdLa5u82vmTh9tJWvT9MicedvBbQQhreh55kcn97W8Ty4FFeR9P9Lf3ARn362xTgMty9rt1czFSdiZAUn3zHUG+pbn+I2i3VJOHbLefTh04NyVMhXkzp2OeqCmqLPBJN3Pn3N0lvlkRIZaYlXsTlfi5qVmVn5kUimnE+Djt0Gx9vDai9b8SESaGRvQ1gc1aFgB1ia2cPUkTDPZxKb2LJN8jr+Me4Gwm5c6mPWE+NmWTnLCr/8sItjS3oWUPli2V0OofN9MPCPz3CWKmt7I+dXsur/oygKO5ufQ3Pw8UHtRduKoAUMzjMVTbXpreW00vO84VZtF+ZQWkb/8J5PSwp2va8SQgBFpjieFDDbcefV925Rahin2zHvW0RJDM4IOnODtHUjvSdwhcfApzFpGUTodR5USrhLXvT7fiQ59rJW8v0/B7Xpv+OXT13W84c51Oiip/shgkilVyweWJFjQvdj+WNmaB7sDT9/4z/Cw9p+HLNp5MPHb6rwqe+RmEn7znOYdF4HEoDnnFr+Qx9MC4SgWMt3Y33xYcLoDfYQ/FrkGq+CU4iAhcZEKlDDXguIXoGkx+Gf9b1MK7P31sw5duN6K/L4wv7M/vqagEYrYm5Xsfvcuv4WksSTsMFf6IWEDq195YSOVaDuR1SfqIWJCBdut6Hj+jyiQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5853.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(110136005)(66446008)(38100700001)(7696005)(26005)(86362001)(4326008)(53546011)(5660300002)(316002)(54906003)(478600001)(55016002)(6506007)(33656002)(8676002)(66946007)(71200400001)(52536014)(2906002)(8936002)(83380400001)(186003)(66476007)(66556008)(9686003)(7416002)(76116006)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?YU5IZlZOdGd4cTQ2bTBGSXV6ZkFSU1o3YUtzSFJka0preXBGTFlCbmswRkVW?=
 =?utf-8?B?UVNvS2NscVdXUWJxSUpReFJ2SEh2MHIzS0tzY3dMVHhnZldzeHJwNnUzZVpB?=
 =?utf-8?B?Q3JwdWtJcVlPMnJ2b2lweHdEbktpN2NUdSsya09tVHVIdlQwWlRRZUZ4b3Fv?=
 =?utf-8?B?U3NuMHZLQytjSlBLVHhsMzcvSmYxaEkzTlRXSXkwWU9iZUVWMUVrd1NQTXBx?=
 =?utf-8?B?aUN6V0RObWNZeDJYeTNscVhzMnBlNlEvUXM3bTdTc0hxeUVUbjBLRTA5NFhq?=
 =?utf-8?B?TDZ5SzdaYnZRdkZlRjhoZ2hwTGNKL3ZiV0xtNEFROVhoZGlJZUdoNkkxaHpG?=
 =?utf-8?B?L0wycmFxQmhkR0R3Q2VCdFVIa0xWN3diWTB5ZFI4NXpRVGRWL1VGY3FTUFI5?=
 =?utf-8?B?eTJUSW9IbmhCUGVRMHpxaHJkZ1RNS1A0blBzOE03dTI3YUQ4eHEzOFRablZC?=
 =?utf-8?B?d2lwWGZwZCtNVkJ4Wmxmd0hQTk1Sa2lkQUFLNFZIaWNEYys4cnJsZUppeVkr?=
 =?utf-8?B?MUNRVnhuQWhickp6RGpEeFFqWUVFRmxuTWdlaXJvVGZiYWhUaTZ3TzYyZzZ5?=
 =?utf-8?B?Q0pBQmVoNkZwK1lpdmJQTEh1L3dkb0tjbHVpU2NCMitFZWRMM0VPVzVOVWRK?=
 =?utf-8?B?SEp1VURsZ0M1ZUh0S2VHRDhXaDNIK0pXMWMyTEFiV3JkRTFjQWhQSWZ2UU1S?=
 =?utf-8?B?dmErQnpVL3hockVrZWIvQ1dCRi81ekpSUUlBWTdWZE1hUGNJQUNEN3ZzM2lP?=
 =?utf-8?B?SVVZU2ZqdUZMb0wwNXIzVXdiajh6OVk0QUIwZVYxRVBzMWVxNTNQVFlWL0hP?=
 =?utf-8?B?T01wZGNsdHJ6ZWZaUEZ2bHQzTW1rRHUreGVEQ2JmZUgxcXovck9wbDExRW42?=
 =?utf-8?B?RnZzNmVKK01uakNBMDd2ZDJJSWxYd1FFTVV0THk5N3VtQ2x6UitmWW5JSE1M?=
 =?utf-8?B?UEZFQ3ZYaytXZmt3YUszUDlPQ1JxdnIyY0RIbGZMaU9ad0hQTFlmalJJRXZq?=
 =?utf-8?B?M1Zxb1R2OHZxZ0pvbllibm1aT2FHU2gwRlFESUF2S2p1eEY0UjJoTHMyNEp3?=
 =?utf-8?B?OEpwWklmSlgzMjF0YXl5eXVxTDFHUkZWNDNUNm52bitZdzIxN0VNYWpMVDdy?=
 =?utf-8?B?aERWeHRMQzdQd25qUXZybk95VE9sZ1Z1S0loUTFtZnFEdUh0eEc4elFKSEI3?=
 =?utf-8?B?NkpGRkZuQjFZdGhjWDBZRURkTlBBaUVGS3cxblJDTVh3L1ZSaURTSm0raDlH?=
 =?utf-8?B?Uzk2SkRKaWZMQ1hNbFBmUW9kQlpUTzFmc1ZUNmhZc0dBTVVycXFPK1EwQlFZ?=
 =?utf-8?B?NTZvRUtPSTZoemlTU3FTQkhDY0RuakJHaExYZy92enh3Z0lPUTZjcW1NQjMr?=
 =?utf-8?B?QXgxODUrWG5sdGQxTEZudXMrSDBJWVNTYnlhd2RhUmpicWx0b1AvdDZpQjU4?=
 =?utf-8?B?cHVaYmJKSU15aWdBOFJ4UnZ5aGtrYlJ4ZHFkTis5bWZVRkNYb2JnaFVOWjJT?=
 =?utf-8?B?WVpCRUdEaHRSNzQ1amxFLzdQY25wZk16UWxlK0g0ZXFaTnF2WmxtUmlmTGNZ?=
 =?utf-8?B?TXFvMUx4UDlTK1RMQklieGQ4bklyOTRZNzk3SnUvNUs5QWJlUktEMjRZK0lE?=
 =?utf-8?B?T3lCTkUvUTRWTllqdDQ1alhSeUN4MjBnRXl4QWlmUzc4QUQvWlRIem5oUTVW?=
 =?utf-8?B?emp6RjQ3MzZuUXlKZHpjeDFoTDNLcktpRWpNdUt5RUx2ZXhVUG1NQ1VxdENW?=
 =?utf-8?Q?RGk7gCiNwYvd7r7678HC59ZXSCtG7Ekq2KnijF/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5853.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac3d73a6-4788-4827-481b-08d8ef34c6a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2021 02:22:02.1923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JYuedkishen/SE9zlIZBQdvhpJZQNFuHB/1yX2ybs6aBym1/z9g+jilRjWa/0zsXP6Et1/NcIW9z0kUfNidkvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6701
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEx1Y2FzIFN0YWNoIDxsLnN0
YWNoQHBlbmd1dHJvbml4LmRlPg0KPiBTZW50OiBXZWRuZXNkYXksIE1hcmNoIDI0LCAyMDIxIDU6
MzAgUE0NCj4gVG86IFJpY2hhcmQgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT47IGFuZHJldy5z
bWlybm92QGdtYWlsLmNvbTsNCj4gc2hhd25ndW9Aa2VybmVsLm9yZzsga3dAbGludXguY29tOyBi
aGVsZ2Fhc0Bnb29nbGUuY29tOw0KPiBzdGVmYW5AYWduZXIuY2g7IGxvcmVuem8ucGllcmFsaXNp
QGFybS5jb20NCj4gQ2M6IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IGRsLWxpbnV4LWlteCA8
bGludXgtaW14QG54cC5jb20+Ow0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGtlcm5lbEBwZW5ndXRyb25peC5k
ZQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDMvM10gUENJOiBpbXg6IGNsZWFyIHZyZWcgYnlw
YXNzIHdoZW4gcGNpZSB2cGgNCj4gdm9sdGFnZSBpcyAzdjMNCj4gQW0gTWl0dHdvY2gsIGRlbSAy
NC4wMy4yMDIxIHVtIDEzOjM0ICswODAwIHNjaHJpZWIgUmljaGFyZCBaaHU6DQo+ID4gQm90aCAx
Ljh2IGFuZCAzLjN2IHBvd2VyIHN1cHBsaWVzIGNhbiBiZSB1c2VkIGJ5IGkuTVg4TVEgUENJZSBQ
SFkuDQo+ID4gSW4gZGVmYXVsdCwgdGhlIFBDSUVfVlBIIHZvbHRhZ2UgaXMgc3VnZ2VzdGVkIHRv
IGJlIDEuOHYgcmVmZXIgdG8gZGF0YQ0KPiA+IHNoZWV0LiBXaGVuIFBDSUVfVlBIIGlzIHN1cHBs
aWVkIGJ5IDMuM3YgaW4gdGhlIEhXIHNjaGVtYXRpYyBkZXNpZ24sDQo+ID4gdGhlIFZSRUdfQllQ
QVNTIGJpdHMgb2YgR1BSIHJlZ2lzdGVycyBzaG91bGQgYmUgY2xlYXJlZCBmcm9tIGRlZmF1bHQN
Cj4gPiB2YWx1ZSAxYicxIHRvIDFiJzAuIFRodXMsIHRoZSBpbnRlcm5hbCAzdjMgdG8gMXY4IHRy
YW5zbGF0b3Igd291bGQgYmUNCj4gPiB0dXJuZWQgb24uDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMgfCAyMyArKysrKysrKysrKysrKysrKysr
KysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiBiL2Ry
aXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiBpbmRleCA4NTNlYThlODI5
NTIuLmJlY2EwODVhOTMwMCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVy
L2R3Yy9wY2ktaW14Ni5jDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNp
LWlteDYuYw0KPiA+IEBAIC0zNyw2ICszNyw3IEBADQo+ID4gICNkZWZpbmUgSU1YOE1RX0dQUl9Q
Q0lFX1JFRl9VU0VfUEFEICAgICAgICAgIEJJVCg5KQ0KPiA+ICAjZGVmaW5lIElNWDhNUV9HUFJf
UENJRV9DTEtfUkVRX09WRVJSSURFX0VOICBCSVQoMTApDQo+ID4gICNkZWZpbmUgSU1YOE1RX0dQ
Ul9QQ0lFX0NMS19SRVFfT1ZFUlJJREUgICAgIEJJVCgxMSkNCj4gPiArI2RlZmluZSBJTVg4TVFf
R1BSX1BDSUVfVlJFR19CWVBBU1MgICAgICAgICAgQklUKDEyKQ0KPiA+ICAjZGVmaW5lIElNWDhN
UV9HUFIxMl9QQ0lFMl9DVFJMX0RFVklDRV9UWVBFICBHRU5NQVNLKDExLCA4KQ0KPiA+ICAjZGVm
aW5lIElNWDhNUV9QQ0lFMl9CQVNFX0FERFINCj4gMHgzM2MwMDAwMA0KPiA+DQo+ID4NCj4gPg0K
PiA+DQo+ID4gQEAgLTgwLDYgKzgxLDcgQEAgc3RydWN0IGlteDZfcGNpZSB7DQo+ID4gICAgICAg
dTMyICAgICAgICAgICAgICAgICAgICAgdHhfc3dpbmdfZnVsbDsNCj4gPiAgICAgICB1MzIgICAg
ICAgICAgICAgICAgICAgICB0eF9zd2luZ19sb3c7DQo+ID4gICAgICAgc3RydWN0IHJlZ3VsYXRv
ciAgICAgICAgKnZwY2llOw0KPiA+ICsgICAgIHN0cnVjdCByZWd1bGF0b3IgICAgICAgICp2cGg7
DQo+ID4gICAgICAgdm9pZCBfX2lvbWVtICAgICAgICAgICAgKnBoeV9iYXNlOw0KPiA+DQo+ID4N
Cj4gPg0KPiA+DQo+ID4gICAgICAgLyogcG93ZXIgZG9tYWluIGZvciBwY2llICovDQo+ID4gQEAg
LTYxMSw2ICs2MTMsOCBAQCBzdGF0aWMgdm9pZCBpbXg2X3BjaWVfY29uZmlndXJlX3R5cGUoc3Ry
dWN0DQo+ID4gaW14Nl9wY2llICppbXg2X3BjaWUpDQo+ID4NCj4gPg0KPiA+DQo+ID4NCj4gPiAg
c3RhdGljIHZvaWQgaW14Nl9wY2llX2luaXRfcGh5KHN0cnVjdCBpbXg2X3BjaWUgKmlteDZfcGNp
ZSkgIHsNCj4gPiArICAgICBpbnQgcGh5X3V2Ow0KPiA+ICsNCj4gTm8gbmVlZCBmb3IgdGhpcyB2
YXJpYWJsZS4uLg0KW1JpY2hhcmQgWmh1XSBUaGFua3MsIHdvdWxkIGJlIHJlbW92ZWQgbGF0ZXIu
DQoNCj4gDQo+ID4gICAgICAgc3dpdGNoIChpbXg2X3BjaWUtPmRydmRhdGEtPnZhcmlhbnQpIHsN
Cj4gPiAgICAgICBjYXNlIElNWDhNUToNCj4gPiAgICAgICAgICAgICAgIC8qDQo+ID4gQEAgLTYy
MSw2ICs2MjUsMTggQEAgc3RhdGljIHZvaWQgaW14Nl9wY2llX2luaXRfcGh5KHN0cnVjdCBpbXg2
X3BjaWUNCj4gKmlteDZfcGNpZSkNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBpbXg2X3BjaWVfZ3JwX29mZnNldChpbXg2X3BjaWUpLA0KPiA+DQo+IElNWDhNUV9HUFJfUENJ
RV9SRUZfVVNFX1BBRCwNCj4gPg0KPiBJTVg4TVFfR1BSX1BDSUVfUkVGX1VTRV9QQUQpOw0KPiA+
ICsgICAgICAgICAgICAgLyoNCj4gPiArICAgICAgICAgICAgICAqIFJlZ2FyZGluZyB0byB0aGUg
ZGF0YXNoZWV0LCB0aGUgUENJRV9WUEggaXMgc3VnZ2VzdGVkDQo+ID4gKyAgICAgICAgICAgICAg
KiB0byBiZSAxLjhWLiBJZiB0aGUgUENJRV9WUEggaXMgc3VwcGxpZWQgYnkgMy4zViwgdGhlDQo+
ID4gKyAgICAgICAgICAgICAgKiBWUkVHX0JZUEFTUyBzaG91bGQgYmUgY2xlYXJlZCB0byB6ZXJv
Lg0KPiA+ICsgICAgICAgICAgICAgICovDQo+ID4gKyAgICAgICAgICAgICBpZiAoaW14Nl9wY2ll
LT52cGgpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIHBoeV91diA9DQo+IHJlZ3VsYXRvcl9n
ZXRfdm9sdGFnZShpbXg2X3BjaWUtPnZwaCk7DQo+ID4gKyAgICAgICAgICAgICBpZiAocGh5X3V2
ID4gMzAwMDAwMCkNCj4gPiArICAgICAgICAgICAgICAgICAgICAgcmVnbWFwX3VwZGF0ZV9iaXRz
KGlteDZfcGNpZS0+aW9tdXhjX2dwciwNCj4gPiArDQo+IGlteDZfcGNpZV9ncnBfb2Zmc2V0KGlt
eDZfcGNpZSksDQo+ID4gKw0KPiBJTVg4TVFfR1BSX1BDSUVfVlJFR19CWVBBU1MsDQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAwKTsNCj4gDQo+IC4uLmlmIHlv
dSBqdXN0IGZvbGQgdGhpcyBpbnRvIGEgc2luZ2xlIGNvbmRpdGlvbi4gUmlnaHQgbm93IHBoeV91
diBtaWdodCBiZSB1c2VkDQo+IHVuaW5pdGlhbGl6ZWQgd2hlbiB0aGUgdnBoLXN1cHBseSBpcyBu
b3Qgc3BlY2lmaWVkIGluIHRoZSBEVC4gQmV0dGVyIHdyaXRlIHRoaXMNCj4gYXM6DQo+IA0KPiBp
ZiAoaW14Nl9wY2llLT52cGggJiYgcmVndWxhdG9yX2dldF92b2x0YWdlKGlteDZfcGNpZS0+dnBo
KSA+IDMwMDAwMDApDQpbUmljaGFyZCBaaHVdIFRoYW5rcy4gV291bGQgYmUgY2hhbmdlZCBhcyB0
aGlzIHdheS4NCj4gDQo+IFJlZ2FyZHMsDQo+IEx1Y2FzDQo+IA0KPiA+ICAgICAgICAgICAgICAg
YnJlYWs7DQo+ID4gICAgICAgY2FzZSBJTVg3RDoNCj4gPiAgICAgICAgICAgICAgIHJlZ21hcF91
cGRhdGVfYml0cyhpbXg2X3BjaWUtPmlvbXV4Y19ncHIsDQo+IElPTVVYQ19HUFIxMiwNCj4gPiBA
QCAtMTEzMCw2ICsxMTQ2LDEzIEBAIHN0YXRpYyBpbnQgaW14Nl9wY2llX3Byb2JlKHN0cnVjdA0K
PiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gICAgICAgICAgICAgICBpbXg2X3BjaWUtPnZw
Y2llID0gTlVMTDsNCj4gPiAgICAgICB9DQo+ID4NCj4gPg0KPiA+DQo+ID4NCj4gPg0KPiA+DQo+
ID4NCj4gPg0KPiA+ICsgICAgIGlteDZfcGNpZS0+dnBoID0gZGV2bV9yZWd1bGF0b3JfZ2V0X29w
dGlvbmFsKCZwZGV2LT5kZXYsDQo+ICJ2cGgiKTsNCj4gPiArICAgICBpZiAoSVNfRVJSKGlteDZf
cGNpZS0+dnBoKSkgew0KPiA+ICsgICAgICAgICAgICAgaWYgKFBUUl9FUlIoaW14Nl9wY2llLT52
cGgpICE9IC1FTk9ERVYpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIHJldHVybiBQVFJfRVJS
KGlteDZfcGNpZS0+dnBoKTsNCj4gPiArICAgICAgICAgICAgIGlteDZfcGNpZS0+dnBoID0gTlVM
TDsNCj4gPiArICAgICB9DQo+ID4gKw0KPiA+ICAgICAgIHBsYXRmb3JtX3NldF9kcnZkYXRhKHBk
ZXYsIGlteDZfcGNpZSk7DQo+ID4NCj4gPg0KPiA+DQo+ID4NCj4gPg0KPiA+DQo+ID4NCj4gPg0K
PiA+ICAgICAgIHJldCA9IGlteDZfcGNpZV9hdHRhY2hfcGQoZGV2KTsNCj4gDQoNCg==
