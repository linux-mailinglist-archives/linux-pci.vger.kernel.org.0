Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABA9523C533
	for <lists+linux-pci@lfdr.de>; Wed,  5 Aug 2020 07:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgHEFpS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Aug 2020 01:45:18 -0400
Received: from mail-eopbgr60049.outbound.protection.outlook.com ([40.107.6.49]:35908
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725887AbgHEFpP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Aug 2020 01:45:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I8xxedFSa3aopBkr9q4s/qOFfKe2oJX54zMWXhV+ForA26yEpI/vKQaI1pPf76ymZR0UUwBbjVB7sKr42Dlba2W2sGO466RNfPZpIftTyDGuz4+78IPUCuD0wncUtSmqaYYIh+PDzUz/OnfknIs4kxt+6IiaixhfdSlEITNwFkmLsEp9ZBLBGxZiZi9WTEcfWnRgBhrkpcR2T7GiOZYopk/EIZKRSeE0R5Wr4FdPmyXqWUc0iUhcNCGxO53eUnDhh5cgHePFqk2kuveWZoSQravQp+qaQk7rNRIApWbuHn2Cpu8OMoD/Eqw6+2ZXxvDrFVqUtJqQ/lYXMKk9XGiVzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQLsie+wNKuPQaZsHUX9TJg5vNRvDb5OimhlNmgvTQM=;
 b=efeGVI2msVaUbontRNcPuiZYGc/RN1MNpHbzs3a5vkyg22n2S2801Rf2fZ9KLH2Xr4DJ/dgaPEtTIljZhSuCfAf7qoOZ7k4sQqH6+016RtF/tB1imF+BNTP6Zz2SKzXQslbS3dHpiF0lHlV+wVBDreOMd1/8UCOsE4BFCf4Axw+btbZIsVpayle4KwT1zJ/y7yuPplGfNxgEhTG/vFqxE/wy1GAzfKWTuJ9rpMa631FOudikI7C2tYWNRlUfhtNJRRNJYLf9UQUM0CsOrxcUrGG4D3cy6D/mufAZBGpEn/3rqOveamzW3/5+RJ1q+qyXVB1hTkT1+0wf8XYgDECczg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQLsie+wNKuPQaZsHUX9TJg5vNRvDb5OimhlNmgvTQM=;
 b=i+XqBB42tpbXcyQpUqGilEmDYKUJE3nkYepUabIMUu2UOGZbtMrRXW5m5clGw2bfwcZXUjqqwV8pNcaKVEht7NR9WN+rofHXoEe7z24I1/k5/A0UW1NGDfK54EIpgZECHnKfyiWgWcg9t6BVLyaVYqJWgGP+xT06jUCvInE++N0=
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com (2603:10a6:803:e3::25)
 by VI1PR0402MB3838.eurprd04.prod.outlook.com (2603:10a6:803:20::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Wed, 5 Aug
 2020 05:45:11 +0000
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::1de7:774:144c:e60f]) by VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::1de7:774:144c:e60f%6]) with mapi id 15.20.3261.016; Wed, 5 Aug 2020
 05:45:11 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] PCI: imx6: Do not output error message when
 devm_clk_get() failed with -EPROBE_DEFER
Thread-Topic: [PATCH] PCI: imx6: Do not output error message when
 devm_clk_get() failed with -EPROBE_DEFER
Thread-Index: AQHWaiIRYG5KaLfjNUWjAQst5+ssEako+/2g
Date:   Wed, 5 Aug 2020 05:45:10 +0000
Message-ID: <VI1PR04MB58535C5DF3141EA35674A7CF8C4B0@VI1PR04MB5853.eurprd04.prod.outlook.com>
References: <1596519481-28072-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1596519481-28072-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8224913b-62e3-4352-f52f-08d83902b7f2
x-ms-traffictypediagnostic: VI1PR0402MB3838:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB38385C0FA5BB1B6E9C676C5E8C4B0@VI1PR0402MB3838.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:239;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XEiHcnNYmC87tofy2+biz8Z27OgOAGNq6/RqjcVBNVVAMBFu0DJSv8rE8ysjkwVxkplBaPJP9j7fqMGrxDk5dRVWzOyEfMJRLclugNGjBDzqgIpOcESmsrzkbCr081rlBLmH+wBCHXk0j7ipBWuLY6kdE456nAom6csrxhr+GE1+e6UuIRzsfnPShVjM5Q0WNKpMZmdAbt5IV/0JVitYwgl3rM7UVUkL8sU75ZtxBxbLSq01cHkbUn0H5TsOBvaDknuJ8Y79KRCUkGZn7kLhIFvuVrE5oA6bHLtYHW50J70OTEOnsXV0wt83yhhpetnFgBBgxwHehvkZ1t+i1Xd8Guj8s3KbsjcLLPmB7RJ7UsFTs5yjVSBuzzgIcldgxu9V
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5853.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(110136005)(86362001)(52536014)(64756008)(8936002)(76116006)(8676002)(5660300002)(316002)(66476007)(66556008)(66446008)(33656002)(66946007)(7416002)(9686003)(478600001)(2906002)(4326008)(186003)(71200400001)(83380400001)(53546011)(7696005)(26005)(6506007)(55016002)(15650500001)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: rfDKTI6j/uBFXzalmOBDotj86QSTOJFiLhB8JKZj1GURmF7VhWK9TVqglBMitB5X8Ezk6U32fkMqFPD0NbX2VNWcRCwkNdqTmhD8rejVNxiJFxdkjXEnSS3zJR4rY0kRt8zLAVBBetPKW21qol4DP5GfiGXBT0cpRGqWWxWE/+rMnrbtdFuvtO6obqENZjMxYOuKgE7vNut0YGquVDPJQF95qo1hGM7UE3ICdEOJvMkffgFoRH9e2bGXWC5TNFoafd9bZp11SddQvWAGeUeRVYhlYi1UwYxbdThp/ToR0d0F1pzR2hCyeLML1dfk6QuDtedOvU6awABhLWlRW64KpqP9MWIyqserpPEawKxV4YJdjn6uim+ti1jOR7G+4KbXjGgP9ObbmY2nXK279T1XyfcPhgaIzwNc66kD0ttwP1MmbG9JcERYgUchmJQjKX+L+Dc5pEDENHPe3H+xQIsm6ZTXkHU/gKRQXjNnE/p9syh7d/Blswks/Malgaxb6GbxqBrXboHfSDoxZkk8imCXbM2eBgffPgkVX6PHQhop1SvFbEA9e4I2737O5ws30tSTsVBgt6HNfr+IpJEm+1RGCF2DROrK+kKuGJltL9qBilrEmOq+E0aPXqYZooxU9Wg2CUN1rnj7EJ250/A1Y3FQqw==
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5853.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8224913b-62e3-4352-f52f-08d83902b7f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2020 05:45:10.9927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uorXSibLLeYAUYKYFkYEu45jPqvYjSjqGlJf/fBSnng1ajfEYjSzSLBPaXp6x1oVP8dqhKes6eE5VWglHpuFfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3838
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbnNvbiBIdWFuZyA8QW5zb24u
SHVhbmdAbnhwLmNvbT4NCj4gU2VudDogMjAyMMTqONTCNMjVIDEzOjM4DQo+IFRvOiBSaWNoYXJk
IFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+OyBsLnN0YWNoQHBlbmd1dHJvbml4LmRlOw0KPiBs
b3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tOyByb2JoQGtlcm5lbC5vcmc7IGJoZWxnYWFzQGdvb2ds
ZS5jb207DQo+IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtl
cm5lbEBwZW5ndXRyb25peC5kZTsNCj4gZmVzdGV2YW1AZ21haWwuY29tOyBsaW51eC1wY2lAdmdl
ci5rZXJuZWwub3JnOw0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGRsLWxpbnV4LWlteCA8bGludXgtaW14
QG54cC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSF0gUENJOiBpbXg2OiBEbyBub3Qgb3V0cHV0IGVy
cm9yIG1lc3NhZ2Ugd2hlbiBkZXZtX2Nsa19nZXQoKQ0KPiBmYWlsZWQgd2l0aCAtRVBST0JFX0RF
RkVSDQo+IA0KPiBXaGVuIGRldm1fY2xrX2dldCgpIHJldHVybnMgLUVQUk9CRV9ERUZFUiwgaS5N
WDYgUENJIGRyaXZlciBzaG91bGQgTk9UIHByaW50DQo+IGVycm9yIG1lc3NhZ2UsIGp1c3QgcmV0
dXJuIC1FUFJPQkVfREVGRVIgaXMgZW5vdWdoLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW5zb24g
SHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQoNCkknbSBmaW5lIHdpdGggdGhlc2UgY2hhbmdl
cy4gVGhhbmtzLg0KUmV2aWV3ZWQtYnk6IFJpY2hhcmQgWmh1IDxob25neGluZy56aHVAbnhwLmNv
bT4NCg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0KDQo+IC0tLQ0KPiAgZHJpdmVycy9wY2kv
Y29udHJvbGxlci9kd2MvcGNpLWlteDYuYyB8IDMwICsrKysrKysrKysrKysrKysrKysrLS0tLS0t
LS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2
LmMNCj4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+IGluZGV4IDRl
NWMzNzkuLmVlNzVkMzUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdj
L3BjaS1pbXg2LmMNCj4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYu
Yw0KPiBAQCAtMTA3NiwyMCArMTA3NiwyNiBAQCBzdGF0aWMgaW50IGlteDZfcGNpZV9wcm9iZShz
dHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+ICpwZGV2KQ0KPiAgCS8qIEZldGNoIGNsb2NrcyAqLw0K
PiAgCWlteDZfcGNpZS0+cGNpZV9waHkgPSBkZXZtX2Nsa19nZXQoZGV2LCAicGNpZV9waHkiKTsN
Cj4gIAlpZiAoSVNfRVJSKGlteDZfcGNpZS0+cGNpZV9waHkpKSB7DQo+IC0JCWRldl9lcnIoZGV2
LCAicGNpZV9waHkgY2xvY2sgc291cmNlIG1pc3Npbmcgb3IgaW52YWxpZFxuIik7DQo+IC0JCXJl
dHVybiBQVFJfRVJSKGlteDZfcGNpZS0+cGNpZV9waHkpOw0KPiArCQlyZXQgPSBQVFJfRVJSKGlt
eDZfcGNpZS0+cGNpZV9waHkpOw0KPiArCQlpZiAocmV0ICE9IC1FUFJPQkVfREVGRVIpDQo+ICsJ
CQlkZXZfZXJyKGRldiwgInBjaWVfcGh5IGNsb2NrIHNvdXJjZSBtaXNzaW5nIG9yIGludmFsaWRc
biIpOw0KPiArCQlyZXR1cm4gcmV0Ow0KPiAgCX0NCj4gDQo+ICAJaW14Nl9wY2llLT5wY2llX2J1
cyA9IGRldm1fY2xrX2dldChkZXYsICJwY2llX2J1cyIpOw0KPiAgCWlmIChJU19FUlIoaW14Nl9w
Y2llLT5wY2llX2J1cykpIHsNCj4gLQkJZGV2X2VycihkZXYsICJwY2llX2J1cyBjbG9jayBzb3Vy
Y2UgbWlzc2luZyBvciBpbnZhbGlkXG4iKTsNCj4gLQkJcmV0dXJuIFBUUl9FUlIoaW14Nl9wY2ll
LT5wY2llX2J1cyk7DQo+ICsJCXJldCA9IFBUUl9FUlIoaW14Nl9wY2llLT5wY2llX2J1cyk7DQo+
ICsJCWlmIChyZXQgIT0gLUVQUk9CRV9ERUZFUikNCj4gKwkJCWRldl9lcnIoZGV2LCAicGNpZV9i
dXMgY2xvY2sgc291cmNlIG1pc3Npbmcgb3IgaW52YWxpZFxuIik7DQo+ICsJCXJldHVybiByZXQ7
DQo+ICAJfQ0KPiANCj4gIAlpbXg2X3BjaWUtPnBjaWUgPSBkZXZtX2Nsa19nZXQoZGV2LCAicGNp
ZSIpOw0KPiAgCWlmIChJU19FUlIoaW14Nl9wY2llLT5wY2llKSkgew0KPiAtCQlkZXZfZXJyKGRl
diwgInBjaWUgY2xvY2sgc291cmNlIG1pc3Npbmcgb3IgaW52YWxpZFxuIik7DQo+IC0JCXJldHVy
biBQVFJfRVJSKGlteDZfcGNpZS0+cGNpZSk7DQo+ICsJCXJldCA9IFBUUl9FUlIoaW14Nl9wY2ll
LT5wY2llKTsNCj4gKwkJaWYgKHJldCAhPSAtRVBST0JFX0RFRkVSKQ0KPiArCQkJZGV2X2Vycihk
ZXYsICJwY2llIGNsb2NrIHNvdXJjZSBtaXNzaW5nIG9yIGludmFsaWRcbiIpOw0KPiArCQlyZXR1
cm4gcmV0Ow0KPiAgCX0NCj4gDQo+ICAJc3dpdGNoIChpbXg2X3BjaWUtPmRydmRhdGEtPnZhcmlh
bnQpIHsgQEAgLTEwOTcsMTUgKzExMDMsMTkgQEAgc3RhdGljDQo+IGludCBpbXg2X3BjaWVfcHJv
YmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIAkJaW14Nl9wY2llLT5wY2llX2lu
Ym91bmRfYXhpID0gZGV2bV9jbGtfZ2V0KGRldiwNCj4gIAkJCQkJCQkgICAicGNpZV9pbmJvdW5k
X2F4aSIpOw0KPiAgCQlpZiAoSVNfRVJSKGlteDZfcGNpZS0+cGNpZV9pbmJvdW5kX2F4aSkpIHsN
Cj4gLQkJCWRldl9lcnIoZGV2LCAicGNpZV9pbmJvdW5kX2F4aSBjbG9jayBtaXNzaW5nIG9yIGlu
dmFsaWRcbiIpOw0KPiAtCQkJcmV0dXJuIFBUUl9FUlIoaW14Nl9wY2llLT5wY2llX2luYm91bmRf
YXhpKTsNCj4gKwkJCXJldCA9IFBUUl9FUlIoaW14Nl9wY2llLT5wY2llX2luYm91bmRfYXhpKTsN
Cj4gKwkJCWlmIChyZXQgIT0gLUVQUk9CRV9ERUZFUikNCj4gKwkJCQlkZXZfZXJyKGRldiwgInBj
aWVfaW5ib3VuZF9heGkgY2xvY2sgbWlzc2luZyBvciBpbnZhbGlkXG4iKTsNCj4gKwkJCXJldHVy
biByZXQ7DQo+ICAJCX0NCj4gIAkJYnJlYWs7DQo+ICAJY2FzZSBJTVg4TVE6DQo+ICAJCWlteDZf
cGNpZS0+cGNpZV9hdXggPSBkZXZtX2Nsa19nZXQoZGV2LCAicGNpZV9hdXgiKTsNCj4gIAkJaWYg
KElTX0VSUihpbXg2X3BjaWUtPnBjaWVfYXV4KSkgew0KPiAtCQkJZGV2X2VycihkZXYsICJwY2ll
X2F1eCBjbG9jayBzb3VyY2UgbWlzc2luZyBvciBpbnZhbGlkXG4iKTsNCj4gLQkJCXJldHVybiBQ
VFJfRVJSKGlteDZfcGNpZS0+cGNpZV9hdXgpOw0KPiArCQkJcmV0ID0gUFRSX0VSUihpbXg2X3Bj
aWUtPnBjaWVfYXV4KTsNCj4gKwkJCWlmIChyZXQgIT0gLUVQUk9CRV9ERUZFUikNCj4gKwkJCQlk
ZXZfZXJyKGRldiwgInBjaWVfYXV4IGNsb2NrIHNvdXJjZSBtaXNzaW5nIG9yIGludmFsaWRcbiIp
Ow0KPiArCQkJcmV0dXJuIHJldDsNCj4gIAkJfQ0KPiAgCQkvKiBmYWxsIHRocm91Z2ggKi8NCj4g
IAljYXNlIElNWDdEOg0KPiAtLQ0KPiAyLjcuNA0KDQo=
