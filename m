Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D9D34580C
	for <lists+linux-pci@lfdr.de>; Tue, 23 Mar 2021 07:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbhCWGzY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Mar 2021 02:55:24 -0400
Received: from mail-vi1eur05on2055.outbound.protection.outlook.com ([40.107.21.55]:40896
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229464AbhCWGy5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Mar 2021 02:54:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cu3YMHa/RqYkbVsxZDTdjxeLbPLg7W3drWVwiYRD3GfntOOzP0b9ZMvzGcz+nmZML3lh3jiI9FBpLtbGLFLjB3bgLksJlhrIcxu9RqMHXrFRy54TFmCFV25c8YO++VLfuoQzRwvPKnHQqJV7NK7BoU+ucOFd2Uo6w1kyJGN42f+b6hgVMBCpPDM7ZSJdmhIUO9Z16qyKuPH6DnOWg/ImhOuv6VnH7kfUwwraTDq6vjdM5baezFOOHv6rzEEiZPQpPrUSJv4oWvkwPvcToNlZ4+wRSX8j1jCeBHLdCOoPIdbvg0xgQf/lJXwRB50FnsJhJyWYcNSXSC4/foL86/pZZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dm1Pt8iP4auWm5Q+9eo7kYIRngWgX+L6dlLOBKhjltA=;
 b=BttrUxGkZn2+pEi9/lcwIoj8WXvVdX7Fj3fRl4PqXT4me3jOx1tIhP2MA8Ie8a3lUWWLd8JUHxHLr50Fd05hh6doBs8GlnghCPdNlghMZrdc8X5+getX+yd+8wnSoTqzApbN5T8Pqpw4FNaow274T5MrhsrKaxXkidvTr2vB/on7UWmtAHQwQt8IcwBCYQlSvT0WYIKMFlJVOuDjCGPZCQ5PcF4P2iKIFkyOrN9q+Vpi57NUVGODsNFv4bou5v6GSNsbu3FijjAvbIllxQU3UMw0KTbhmDxZgcQiq7/WRrenT7oFVC3u07Zb7GnhFJnkvQVXe7K1x1Rtb4OnhrziqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dm1Pt8iP4auWm5Q+9eo7kYIRngWgX+L6dlLOBKhjltA=;
 b=WLaW+p4VJnrTfNLzecT72V8+DF6Na2wRRYpIF1qyz3dIvPGUW7rzuIGke9j1DUMWuGzGqQfhNWCGwLblZXdi7d3BG7z4sqEfbV5eqHD8XWxyk7VQe4DiR+HyGBSXy4q+Enn5Hwwwaj/NLj5nvHCbQMweotp/qKIMBOS9rHoc03U=
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com (2603:10a6:803:e3::25)
 by VI1PR04MB4815.eurprd04.prod.outlook.com (2603:10a6:803:5d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.23; Tue, 23 Mar
 2021 06:54:54 +0000
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::8116:97ef:2fd7:251f]) by VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::8116:97ef:2fd7:251f%7]) with mapi id 15.20.3955.027; Tue, 23 Mar 2021
 06:54:53 +0000
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
Subject: RE:  Re: Re: [PATCH 1/3] dt-bindings: imx6q-pcie: specify the imx8mq
 pcie phy voltage
Thread-Topic: Re: Re: [PATCH 1/3] dt-bindings: imx6q-pcie: specify the imx8mq
 pcie phy voltage
Thread-Index: AdcfrmiW5KSF09udSaqJ1pNU91d3Xg==
Date:   Tue, 23 Mar 2021 06:54:53 +0000
Message-ID: <VI1PR04MB585305B11C67D1F24A5D050C8C649@VI1PR04MB5853.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d5f789ad-1447-4bd7-acc1-08d8edc89011
x-ms-traffictypediagnostic: VI1PR04MB4815:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB4815D5A90BD4D30C67A0E1DD8C649@VI1PR04MB4815.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kHWWvMIl7vTUb13TEXIApHRpcfu8vmLlrZEF3eHqrCqhCxfSEYA8ogsOm7LfuYX655hxe3hk6Iyf7MFNPSf2Am2kqkxExs9wXpYaGT3zchdRHHWSj21ubpLf2xgy3yZwKt2sA7yzRuWNS/kreXZOqFAa96qxXL5zfbmo1I7YvuEg3sSas5sbS0XlvTGC2gLNgzD3Y8K1C/JYiu7VWAc8i0VG3nsLZl/mpcSHGCcgyiVky/7xy2BU1I22ziW0If4J0zIllyx9ONp6eafgGsWeGXOfOE7ASS0BO3308YUEmY8IwOZKGTnag5FnxjImkuz8FY5sJQST4W8acPIj6dTNUAn9cwQQoiY1j9yFn3gRrST692nuldQMPgj43TXdgmo0TqbX6UBaXduvt37gOPU2ehetMas7gC2PyOjWvKrejQifsrS7ZUgWnkGr02FJoJ+/S4jgRKwD4Aai4igZtp4FOZ5kc9djuEKo8Fze4uSorCE7MkzFqgUOjpV7zytrnBopyrenoAtoeG5flR2eUvkoer4zm2cvPdF5/k5GwrGI2jO0L1iwv4kAFJ5hyASZsSusWH0MgHVwSToQkctgu9Ui7j2X0EMtAKN9gpERpRTbD+kDOZluVO227EI50Gy1wbi3AFS/Nm9YYZqisBhxpKOZpwr+4n/GkbopYq99goQUPY0dCi+zur6axlwpIUnkSFJJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5853.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(376002)(396003)(346002)(136003)(38100700001)(86362001)(66556008)(478600001)(64756008)(66446008)(6506007)(53546011)(110136005)(8936002)(55016002)(66476007)(54906003)(316002)(26005)(2906002)(66946007)(7696005)(33656002)(8676002)(4326008)(71200400001)(7416002)(9686003)(76116006)(186003)(52536014)(83380400001)(5660300002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?WTRXbW9MM1M2bVhyMWJ5dHhtTGJBeGFmVWtubmxUbFBsU29qeU44T2lsbGYy?=
 =?utf-8?B?dEErZmhYVE9ac0FZQU4zbEduampnR2FKWkJBOUZjM3FCMUlUN1diYVJZNXc4?=
 =?utf-8?B?eWZkalE5U2RsYWdvdUtnZzVxdlQwK1pLdHRjaE1MMnpKSW85Smw2d3BETmJz?=
 =?utf-8?B?UXRLQldwN04rbXVUd0l3aW0zNThUS3c4YWRTNG5EY0FYQmxqMHczbndwdGJm?=
 =?utf-8?B?TG41Zm8vN21Za3dHRTQ2Yk1UTmFzK3B5bEIrTVozUkp0MjE0Z0x4TXFmOE56?=
 =?utf-8?B?MnVVZ3V0TGhlYnBNZEFkTHkzR1M4V1YvV3k3dExORWFDdHdaS3lFQTNJeXJw?=
 =?utf-8?B?Vm40RFl3aDFBOXJsQ1VudlcrdENBdmRTa0VESDZJbDBjaVlkcGc5UTBqMFU3?=
 =?utf-8?B?b0RHMnBSMUcwRTMwblRGblpqUGVxOVdsM0VyYVcwZnJDamFrYkZieGFOZVlh?=
 =?utf-8?B?Mkg0ZGx4R3ExOVNYTWthV0tRcFkySVhoVzRmS0dLK3Y5bmZFM0ZIdTBPcElo?=
 =?utf-8?B?S0MvK2VWMVpqcTdSUWRNVklEWTlCVXBzMTgwaHNmM1FuLzkwc3VudDJFR1k3?=
 =?utf-8?B?b0g5a1J5cGxmWkJHelRCNDI2eDZhdWt6MllUYngxYjJlZlk4c2w2bkJ3UEhh?=
 =?utf-8?B?MGdzdFo3SmxXeEVKTDlXQzcwcHFiZ2ZFaDRzTXZxM0llaktEZVNBMTEwUDdw?=
 =?utf-8?B?eTRnbngzVUFyaDg1RGRWb2ExOVVqc0JTVWN4b0ZXWHp5T0l4Rm1yUU0yQURC?=
 =?utf-8?B?ZklLeVhkTHVYWVhQUURsNjdNajMxZ2tBWGlWS2d2aHorUnNVYVVwMlU3VlRi?=
 =?utf-8?B?SnMxQ2xXSW9QenJoaGY1R0ltKzJCS1l6cTJCbVNqQVkxRlVyTWFGUlZpUE54?=
 =?utf-8?B?SVRydGNaWHNvZkhVc1hYR0QveHIwUE1VM2tOaUovUmdYbS8wc0h4Vm1Xa05l?=
 =?utf-8?B?VTEvR0dIT2UyWC9YY0ZQS0hKaG5OUW9wWGNXdjZQVUhDWldSZ093YXlxYXpy?=
 =?utf-8?B?OUVORDgvclIwL0poSWYrcUhLTXRxK20vd0I4V2xRSHVOVnh3c3poeXdBcTdL?=
 =?utf-8?B?L1hoK0lvdnJHY2N1dVdQMUVaK0FCUG11OHRkUHY5TTdqdkRIU0Y0T09Qa2xF?=
 =?utf-8?B?WUFRaVhQSzFZSDdFTytQRHRzQTNSd3BEV3lPaVc0VXV4SE84WWw1ZFFtZTky?=
 =?utf-8?B?OHBmSXQ1bklYT2ZSenQyalNjRmV4d2RyU2N6a01weGFSN1V5cVN4RlhxSXlw?=
 =?utf-8?B?NEIwMzdoYzZzY1djeWtSL0lObG5oQ1BETi9VZFVFUEdUWXlBVnR6RjY0cnNj?=
 =?utf-8?B?cFRtbmJrSXdnNFFjQ3BjUnlJZDJHV0JNTkhFM3NKS0Jqdnl4U05DL3BlRE5M?=
 =?utf-8?B?YWR6UjBCZysvUlgxWU8xenFDTWVab1RUUlozTy9TZHpZczdQaHc1OTNZZXRR?=
 =?utf-8?B?M3R6aEZKdlVEWnhaOWlqWlRCYndGNHhEN3BXV0VQTDFxUWpMOHZJWGFPK0tL?=
 =?utf-8?B?MHRBYnhZQU9ER004WlZueXpnaWNaa0tCOEpHRTY1K1V6YXVSUjRhMk9DaFEy?=
 =?utf-8?B?WTJHNlJOVUNTNmlJbDk1dCttNGhUMGxCd09Bb1l0UkN3TXFVaUpnNVdXWXkv?=
 =?utf-8?B?bnQ5UFpwZ1l1MHd3ZnB2MklJdENiWmFzYytDRUFmck05Y2ppVjNmdGZyZzg5?=
 =?utf-8?B?aFdGV1FjMDR4ZTNwQW5OQ080U3B1UlNtVlF1L0E0QWhZTVlLNE9LK0xicXls?=
 =?utf-8?Q?O2v7RnDhZRMsVfDIGWIMDoKzRb047SsvdF2YosI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5853.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5f789ad-1447-4bd7-acc1-08d8edc89011
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2021 06:54:53.5676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V/JECxMH8e3+lyew889G9tUH1JmzxqjzrtFYByIywdmrHRKm61+qaj2pDkJQ+vlLtFPDuHXZIO5OATc/omn4Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4815
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMdWNhcyBTdGFjaCA8bC5zdGFj
aEBwZW5ndXRyb25peC5kZT4NCj4gU2VudDogTW9uZGF5LCBNYXJjaCAyMiwgMjAyMSA4OjE1IFBN
DQo+IFRvOiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+OyBhbmRyZXcuc21pcm5v
dkBnbWFpbC5jb207DQo+IHNoYXduZ3VvQGtlcm5lbC5vcmc7IGt3QGxpbnV4LmNvbTsgYmhlbGdh
YXNAZ29vZ2xlLmNvbTsNCj4gc3RlZmFuQGFnbmVyLmNoOyBsb3JlbnpvLnBpZXJhbGlzaUBhcm0u
Y29tDQo+IENjOiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXggPGxpbnV4
LWlteEBueHAuY29tPjsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBrZXJuZWxAcGVuZ3V0cm9uaXguZGUNCj4g
U3ViamVjdDogW0VYVF0gUmU6IFJlOiBbUEFUQ0ggMS8zXSBkdC1iaW5kaW5nczogaW14NnEtcGNp
ZTogc3BlY2lmeSB0aGUNCj4gaW14OG1xIHBjaWUgcGh5IHZvbHRhZ2UNCj4gSGkgUmljaGFyZCwN
Cj4gDQo+IEFtIE1vbnRhZywgZGVtIDIyLjAzLjIwMjEgdW0gMDk6MDYgKzAwMDAgc2NocmllYiBS
aWNoYXJkIFpodToNCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9t
OiBMdWNhcyBTdGFjaCA8bC5zdGFjaEBwZW5ndXRyb25peC5kZT4NCj4gPiA+IFNlbnQ6IEZyaWRh
eSwgTWFyY2ggMTksIDIwMjEgNTo0OSBQTQ0KPiA+ID4gVG86IFJpY2hhcmQgWmh1IDxob25neGlu
Zy56aHVAbnhwLmNvbT47IGFuZHJldy5zbWlybm92QGdtYWlsLmNvbTsNCj4gPiA+IHNoYXduZ3Vv
QGtlcm5lbC5vcmc7IGt3QGxpbnV4LmNvbTsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsNCj4gPiA+IHN0
ZWZhbkBhZ25lci5jaDsgbG9yZW56by5waWVyYWxpc2lAYXJtLmNvbQ0KPiA+ID4gQ2M6IGxpbnV4
LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+Ow0K
PiA+ID4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOw0KPiA+ID4ga2VybmVsQHBlbmd1dHJvbml4LmRlDQo+ID4gPiBTdWJq
ZWN0OiBSZTogW1BBVENIIDEvM10gZHQtYmluZGluZ3M6IGlteDZxLXBjaWU6IHNwZWNpZnkgdGhl
DQo+ID4gPiBpbXg4bXEgcGNpZSBwaHkgdm9sdGFnZSBBbSBGcmVpdGFnLCBkZW0gMTkuMDMuMjAy
MSB1bSAxNjoyNCArMDgwMA0KPiA+ID4gc2NocmllYiBSaWNoYXJkIFpodToNCj4gPiA+ID4gQm90
aCAxLjh2IGFuZCAzLjN2IHBvd2VyIHN1cHBsaWVzIGNhbiBiZSBmZWVkZWQgdG8gaS5NWDhNUSBQ
Q0llDQo+ID4gPiA+IFBIWS4NCj4gPiA+ID4gSW4gZGVmYXVsdCwgdGhlIFBDSUVfVlBIIHZvbHRh
Z2UgaXMgc3VnZ2VzdGVkIHRvIGJlIDEuOHYgcmVmZXIgdG8NCj4gPiA+ID4gZGF0YSBzaGVldC4g
V2hlbiBQQ0lFX1ZQSCBpcyBzdXBwbGllZCBieSAzLjN2IGluIHRoZSBIVyBzY2hlbWF0aWMNCj4g
PiA+ID4gZGVzaWduLCB0aGUgVlJFR19CWVBBU1MgYml0cyBvZiBHUFIgcmVnaXN0ZXJzIHNob3Vs
ZCBiZSBjbGVhcmVkDQo+ID4gPiA+IGZyb20gZGVmYXVsdCB2YWx1ZSAxYicxIHRvIDFiJzAuDQo+
ID4gPiA+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFJpY2hhcmQgWmh1IDxob25neGluZy56aHVA
bnhwLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvcGNpL2ZzbCxpbXg2cS1wY2llLnR4dCB8IDQNCj4gPiA+ID4gKysrKw0KPiA+ID4g
PiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gPg0KPiA+ID4gPiBkaWZm
IC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9mc2wsaW14NnEt
DQo+ID4gPiA+IHBjaWUudHh0DQo+ID4gPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3BjaS9mc2wsaW14NnEtcGNpZS50eHQNCj4gPiA+ID4gaW5kZXggZGU0YjJiYWY5MWU4
Li4yM2VmYmFkOWU4MDQgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9wY2kvZnNsLGlteDZxLXBjaWUudHh0DQo+ID4gPiA+ICsrKyBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvZnNsLGlteDZxLXBjaWUudHh0DQo+ID4g
PiA+IEBAIC01OSw2ICs1OSwxMCBAQCBBZGRpdGlvbmFsIHJlcXVpcmVkIHByb3BlcnRpZXMgZm9y
IGlteDdkLXBjaWUNCj4gPiA+ID4gYW5kDQo+ID4gPiBpbXg4bXEtcGNpZToNCj4gPiA+ID4gIEFk
ZGl0aW9uYWwgcmVxdWlyZWQgcHJvcGVydGllcyBmb3IgaW14OG1xLXBjaWU6DQo+ID4gPiA+ICAt
IGNsb2NrLW5hbWVzOiBNdXN0IGluY2x1ZGUgdGhlIGZvbGxvd2luZyBhZGRpdGlvbmFsIGVudHJp
ZXM6DQo+ID4gPiA+ICAgICAgIC0gInBjaWVfYXV4Ig0KPiA+ID4gPiArLSBwY2llLXZwaC0zdjM6
IElmIHByZXNlbnQgdGhlbiBQQ0lFX1ZQSCBpcyBmZWVkZWQgYnkgMy4zdiBpbg0KPiA+ID4gPiB0
aGUgSFcNCj4gPiA+ID4gKyAgc2NoZW1hdGljIGRlc2lnbi4gVGhlIFBDSUVfVlBIIGlzIHN1Z2dl
c3RlZCB0byBiZSAxLjh2IHJlZmVyDQo+ID4gPiA+IHRvIHRoZQ0KPiA+ID4gPiArICBkYXRhIHNo
ZWV0LiBJZiB0aGUgUENJRV9WUEggaXMgc3VwcGxpZWQgYnkgMy4zViwgdGhlDQo+ID4gPiA+IFZS
RUdfQllQQVNTDQo+ID4gPiA+ICsgIHNob3VsZCBiZSBjbGVhcmVkIHRvIHplcm8gYWNjb3JkaW5n
bHkuDQo+ID4gPg0KPiA+ID4gVWhtLCBuby4gUGxlYXNlIGRvbid0IGFkZCBib29sZWFuIERUIHBy
b3BlcnRpZXMgZm9yIHJhbmRvbSBwYXJ0cyBvZg0KPiA+ID4gdGhlIGJvYXJkIGRlc2lnbi4NCj4g
PiA+DQo+ID4gPiBJZiB3ZSBuZWVkIHRvIGtub3cgdGhlIHZvbHRhZ2Ugb2YgUENJRV9WUEgsIHdl
IHNob3VsZCByZWFsbHkgYWRkIHRoZQ0KPiA+ID4gVlBIIHJlZ3VsYXRvciBhcyBhIHN1cHBseSB0
byB0aGUgUENJZSBjb250cm9sbGVyIG5vZGUsIHRoZW4gd29yayBvdXQNCj4gPiA+IHRoZSB2b2x0
YWdlIHRoZSB1c3VhbCB3YXkgYnkgdXNpbmcgdGhlIExpbnV4IHJlZ3VsYXRvciBBUEkuDQo+ID4g
Pg0KPiA+IFtSaWNoYXJkIFpodV0gSGkgTHVjYXM6DQo+ID4gVGhhbmtzIGZvciB5b3VyIGNvbW1l
bnRzLiBTaW5jZSB0aGUgdmdlbjVfcmVnIGlzIHVzZWQgdG8gcG93ZXIgdXAgUENJZQ0KPiA+IFBI
WSBvbiBpLk1YOE1RIEVWSyBib2FyZCwgIGFuZCBpdCdzIHNldCB0byBiZSAicmVndWxhdG9yLWFs
d2F5cy1vbjsiLg0KPiA+IERpZCBvbmx5IHRoZSByZWd1bGF0b3JfZ2V0X3ZvbHRhZ2Ugb3IgY29t
YmluZWQgd2l0aA0KPiA+IHJlZ3VsYXRvcl9lbmFibGUvcmVndWxhdG9yX2Rpc2FibGUgY2FuIGJl
IHVzZWQgaW4gdGhlIGRyaXZlcj8NCj4gDQo+IFRoZSByZWd1bGF0b3IgQVBJIGRvZXNuJ3QgY2Fy
ZSwgeW91IGNhbiBjYWxsIGVuYWJsZS9kaXNhYmxlIGluIHRoZSBkcml2ZXIgYXMNCj4gbm9ybWFs
LiBJZiB0aGUgcmVndWxhdG9yIGlzIG1hcmtlZCBhcyBhbHdheXMtb24gaXQgd2lsbCBqdXN0IHN0
YXkgZW5hYmxlZCBldmVuIGlmDQo+IHRoZSB1c2UtY291bnQgZHJvcHMgdG8gMC4NCj4gDQo+IFRo
ZSBvdGhlciBxdWVzdGlvbiBob3dldmVyIGlzIGlmIGl0J3MgZXZlbiBhbGxvd2VkIGJ5IHRoZSBT
b0MgZGVzaWduIHRvIGRpc2FibGUNCj4gdGhpcyBzdXBwbHkgb3V0c2lkZSBvZiBkZWVwIHBvd2Vy
IGRvd24uIEEgcXVpY2sgbG9vayBpbnRvIHRoZSByZWZlcmVuY2UNCj4gbWFudWFsIGFuZCBkYXRh
c2hlZXQgZGlkbid0IHlpZWxkIGFueSBpbmZvcm1hdGlvbiBhYm91dCB0aGlzLg0KW1JpY2hhcmQg
Wmh1XSBIaSBMdWNhczogWWVzIGl0IGlzLiBUaGUgUENJZSBQSFkgcG93ZXIgZG93biBtYW5pcHVs
YXRpb25zIGFyZSBub3QNCiBkZXNjcmliZWQgaW4gdGhlIFJNIGRvY3VtZW50Lg0KSG93IGFib3V0
IHRvIGdldCB2b2x0YWdlIGhlcmUgb25seSBjdXJyZW50bHksIGFuZCB0aGUgcmVndWxhdG9yIGVu
YWJsZS9kaXNhYmxlIG9wZXJhdGlvbnMNCndvdWxkIGJlIGFkZGVkIGZ1cnRoZXIgaWYgdGhlc2Ug
ZW5hYmxlL2Rpc2FibGUgb3BlcmF0aW9ucyBhcmUgcG9zc2libGUgYW5kIHJlcXVpcmVkIGxhdGVy
Pw0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQNCj4gDQo+IFJlZ2FyZHMsDQo+IEx1Y2FzDQoNCg==
