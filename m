Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4534549F637
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jan 2022 10:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237929AbiA1JZP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Jan 2022 04:25:15 -0500
Received: from mail-eopbgr70078.outbound.protection.outlook.com ([40.107.7.78]:54171
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236088AbiA1JZO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 Jan 2022 04:25:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZYxNYxRqcQyWhMUzVzrMPBR8/jHTLTXGexkjwVbf+B/THhHumlDlZiEOTdwh3m77sDY2v/FGp2YVusDARX1E3VlTpfFNiqrp8BiKIAtpUhzPJaDiBls6nVCkms0YtZNjluuqYgfWVhq8rC3tNj+ihHWsdxINzHMWOfKMlasH3wTa0CfXQzzOMQSIrezb9H0JOiWC6ouJjuWq5+SGTcNy96kM2ur/XKeL/8HLLuriy6rs6121sE0TMmB9KABOfuVSUIE2G9LQ8slNslklRCWDUw70eufI2qe6yK5/M/c+RfzaOfw4+gCyu7zNF8KLaj1Bs0/SknZiuBD3iwfTVBj18A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=snMkWmwVdgd0E9v4HuUPgPkcbfP7lQubjHpa58cFnVY=;
 b=eir0qtzYPJqluL7I/CeImJfqdOH7OuUd1zle8U2FWidNgnD/najbxhmxz8+oFRTUz34D+J6Kkg3a4fnSwE0scsBVbELRSQpumHj0+/PyMZBXKEK1vv7N0pabtr4Xnxw3aJlf6axnj2AuRRgqVM7cNJ50hB6fDkdb869Sx2mfzpUeKSt6H7r7uNu6rRb6dUT8frYQIsnEfJkQ35ebW0oo9sVWN4zrHh53trsV+2wXBipf1b0wKmcQMbKerBugMAffxWNyeOgpQhA5U2xc0GWUFys6kO514MNsU/MxWOJZ0nZpd9oQAYXTWdAE96XkfXNrOzamZB6+9a/StbG2Dqql+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=snMkWmwVdgd0E9v4HuUPgPkcbfP7lQubjHpa58cFnVY=;
 b=SWYDVbiDH+l88Scs8UPRRA1Sw2T0FWS2j/JOQK1p+fM8j+fbd4YZOoTQnz9x7nyKPlDRetqd5RUwXHTBGJFkfEhBuwqmqLYpaPU17ADZFGtuUkAiV2+GlMBuvVMaPq2Vi5c375OHdI6/rbCaEDN1b+puE9crq0b3JlXY7YaJuu8=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8200.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Fri, 28 Jan
 2022 09:25:12 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::4197:4263:c1f7:4e24]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::4197:4263:c1f7:4e24%4]) with mapi id 15.20.4930.018; Fri, 28 Jan 2022
 09:25:11 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?gb2312?B?S3J6eXN6dG9mIFdpbGN6eai9c2tp?= <kw@linux.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Jason Liu <jason.hui.liu@nxp.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: RE: [RFC PATCH] PCI: imx6: Handle the abort from user-space
Thread-Topic: [RFC PATCH] PCI: imx6: Handle the abort from user-space
Thread-Index: AQHYFCEoDLKnhR5gjUGQpVQUKSiy/qx4KXWQ
Date:   Fri, 28 Jan 2022 09:25:11 +0000
Message-ID: <AS8PR04MB8676E90C0A394C82BB0A890B8C229@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20220128082920.591115-1-francesco.dolcini@toradex.com>
In-Reply-To: <20220128082920.591115-1-francesco.dolcini@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a76dfeb-836c-481c-1cc0-08d9e24015ac
x-ms-traffictypediagnostic: AS8PR04MB8200:EE_
x-microsoft-antispam-prvs: <AS8PR04MB8200D0239F1F589AF61395888C229@AS8PR04MB8200.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z2EBNZe4YiMaBW59HYwEyEM4SV02IVAmXn50m7zI+/PkwJsoIWw31u96MUC7JqAlMCvrXdXHZOsaxdKQu9cVpK0CXt1Ht5Ot36pG4FS0lEgFGZPWJX67PK7BvEbUQdQdkxWm2oVocypfNqXCnsd7+NtHiVdNIm80Y/lDmt2URSX1GE1UrxnwX7iQo0sS7ikEcIr8unOy87yI2iLGU0iIgsWNCQL+Fxa/3/Pw1J4IfFTemaWvm28ng6g+iBv511aSQaVVQFaN6gqnpWoeneQv1grP30POAN2w/TThbGa2e52bLN9RQvwyj3g3qNz6Gb/HCpmMLljN8AS0QJQ3KL34gbpq6t0a0VuKZyr4lbnTW7cPFjdHp9sr08V3nzBpD3B4AS/qQkjWYSNMuZG4RITn1iQnPhSu3RcX4909Ja8ERBTDRqmZ9pE4A0i/K5JmQ7PCfThTelKIvXBtpWZpI9DbU3z7pFeo7feG6vOKWC8UhN2xW0o5zmbIfu7Ajhi7SacDMRoKROVpvkE9QRSKng9akDF4zUdOhxuMt58vos/jDKhfCS3gED+msBtSm2XcYJ6XA2P1anN/XXhMYDhKANv5khhcIzsOlXihyLCp81vzuMVDRCP1LfBZ7+Mi2e46dSkHIu0FPrtzOAiuHssFSguX1IHZzvfBIvZMIRYJA5hAPGUqQaZ2FFB0RVFTpfOqWEZDaiWCuWA1pUZ43HzUUMejjMPnW8AmgK+7F/jlRfQkMQUOL7WCPNkXwTCrB/8jTE2OQn7OEeVDrpOGJM2QPFIvVpCrWFJtdNoOU/m+BD2d3JU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(8936002)(76116006)(64756008)(7416002)(44832011)(66556008)(8676002)(921005)(316002)(52536014)(122000001)(2906002)(110136005)(66476007)(5660300002)(33656002)(71200400001)(38100700002)(4326008)(54906003)(6636002)(66446008)(55016003)(38070700005)(86362001)(45080400002)(6506007)(7696005)(83380400001)(9686003)(186003)(66574015)(966005)(508600001)(53546011)(26005)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?Y3pEUEFJMHJkYkFGTkxZZm05T25Ea1JFemdwN0xQVytMK2p3MGlYZkNyWWtQ?=
 =?gb2312?B?cHhBUkgreTgzdzBxQzA5TUJDQzlXdU4yc0NIT0NsSmduc05nRjJuclpua1Jy?=
 =?gb2312?B?NDgra0d5S3N5N0tzcFU1M3EweTNkWG4xcDJ3akg2MG51Si9OZlc4bjJsRFh1?=
 =?gb2312?B?UXh4aUZXNUhHREpBcUwzQlhHZktWRk52UW5neDRlRjhUUFF2S3VubDhMa1FW?=
 =?gb2312?B?b3UxNmZ0eHFWWS9Rb285L0ZCZXZ5cTU3cjFXVytpTnBtbERqMFZYYkZLTFNs?=
 =?gb2312?B?NTJLSnptenpZb01RVWJrZGZrZENRYTM5K0RrdTlIcXRXd1hHVmVXTjVaaVZN?=
 =?gb2312?B?ZzJ2dU5VK0NwU1g2VlEweVFvaThqSzA3Z3pwVEdEdkoxV0tnZms4N0FLTk9o?=
 =?gb2312?B?WUFCYklodU12Uk1aekJEOUpBbWVVT0NXelBIUFpFM0FsQVVKWGY4ZkNnKzBE?=
 =?gb2312?B?aXg5bW5aRTA2NUM1Y3VoR0RpNWVJTGRUWVNaS21KaGNhQndQTjJva3J3WVFt?=
 =?gb2312?B?OXF0d0F5NWZwanoyZUd5WlZiVEo3S2NvVzYxNU9MQWNEdGhHRDZ6SEZaSzd3?=
 =?gb2312?B?RjRTTE9jMG9jVFUwWlN0aXZBRWFJWVRpaU00ZjNXUUNLK00vbFNMaUVxYjNU?=
 =?gb2312?B?VDRieGF3MUJKZWhIS0RXRFpFanFyNXZUOEU2d3plV1RXRXJzWDdkdjhkTmp6?=
 =?gb2312?B?QkFjcS96RGNCOHI4NVJpWU02S1RIVm1CK3Zlc3UxVFNUeWwvbWR2ZExJcGU4?=
 =?gb2312?B?NExVcXdLWVdOU0xaUkVpSmduSFZnZlNJZWIvbUtDWmNBaXI1L2lxZEdSb25y?=
 =?gb2312?B?L3ZyVVBUTlBLY2hvTnlRVDR4OVpwdlZscDdHOFpjTnIrYWlTbXhyYVRQY2h1?=
 =?gb2312?B?cDRyYTRyVnAwYU9ZNlF0VnlSTGZpMnBuNXNxajhCT2JKeUc4SWc0WXFQY01t?=
 =?gb2312?B?akp5dTJMdEFlRTloc1U1RFhwWHZvSFNGclRpTVZBNnZBczYzY3lHZ1VKT0F1?=
 =?gb2312?B?YXBrR2RsZ2xZOGFHdEMxN3hEVk81dG0vU0t4Q0c3eDVkMWgyaWExaHFhVzNv?=
 =?gb2312?B?a1pEZndSWGNXazVsajBuMVpCSWl1dGd2VFpnc0VjNHFCM3ZDOTZHYlIzaEVN?=
 =?gb2312?B?VVU2TGR3RDBTS1ZIZi9hdXFoU2xWbXBGUTFuVDFMazljSmpFcEVQOEVjMVVE?=
 =?gb2312?B?Sk5rTy8wd2MyeXJmemdUVGRWUHF6ZThpWmxRZkRLM2gvb0V2UlBOWTBlYVJJ?=
 =?gb2312?B?aVJHZFlvQThkQXk1d2hiaENDdUNXTkVDZlRuN2lxOU9tazcwSmFBa1FRTmpy?=
 =?gb2312?B?Yis0ODFScDRybDU4VEx2alBrdmIyVU9scWwzZHBqMHlGRTBRZzIxY0ZoV1F0?=
 =?gb2312?B?bFpoSDArUVhjSlV0bmU2clI3aFZzQWdJL3d6OVZFaTkzQ1Nzb0pERGsxc01R?=
 =?gb2312?B?cFlJVEVBQUp3emF5OGhncDFnWTFkdEpBUzhWdEpUWmtTQ1JiZDY4U1VJRE1w?=
 =?gb2312?B?L25pdzd6Q0NJY2tQTG1JdDlWOXM4eWMyaGtUeXcyQ0wrNVNTeWNUUnMvNFR4?=
 =?gb2312?B?VytHWEYvdnd6OUo4ZTFOOGZhR0dIOTVzWDNvWHJoMXJOWmo4bDFlY0Exdzk0?=
 =?gb2312?B?UThFcnNTN0h6QVJnWm1VeGdvYUJ1TjAxVXdLTHdvb21vVWdCUG1YRytybmNq?=
 =?gb2312?B?T2dYd1k1ZWhmWmUwUnhzNW8wV3dwbFRnYW5vbG9tdHg3Mkg4bHJZZnFFd2dn?=
 =?gb2312?B?M2hDemQ1eTBQRm1VWEJkbUUyWmtybW1GRWNXRzZYTGp0cE5NR3RkdFdFTlk2?=
 =?gb2312?B?bGM5LzNDNG9uSElyL1dQdlIwM0RsbE9rVWhkRkJESUlabHBTYnlJSTV1NTgw?=
 =?gb2312?B?UWx2azRNQ09iWGhPeFlab09PQXdEc0c3YlhyRm13OHpNZzBDMjlNdisyVUNq?=
 =?gb2312?B?SHA5N3hWbjdrRk9mclZVR28zaXY3U2NXS0dTSHhGVzVUN3pPVFBtdVAxY1Vl?=
 =?gb2312?B?UllFMGJoRnp3UkMzQVNEWVYvVXk0bGIzM3FnZzhMNmtHOWlRaUZGUmZtaVM2?=
 =?gb2312?B?ejIwcDlXTXJ6UEUyekhKdUVMbzFPL0EwR3YrQTcwbnRzNVh2V1pDZHRmOEx0?=
 =?gb2312?B?QkFoN0FFY21MRmlQUmR5dnF5WkRFbUdCVFVGcEVVWFVMRUJaY3NGMkRzeUR1?=
 =?gb2312?B?Nmc9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a76dfeb-836c-481c-1cc0-08d9e24015ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2022 09:25:11.7927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1tojbhUeOusGZb9ToYiRSLr2vCb13tAd4Kvyhp67RbjRSA7WFfPf649jrLgsD/zxcedKzDQb2oRZ5e5TUF4ZPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8200
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGcmFuY2VzY28gRG9sY2luaSA8
ZnJhbmNlc2NvLmRvbGNpbmlAdG9yYWRleC5jb20+DQo+IFNlbnQ6IDIwMjLE6jHUwjI4yNUgMTY6
MjkNCj4gVG86IEhvbmd4aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+OyBMdWNhcyBTdGFj
aA0KPiA8bC5zdGFjaEBwZW5ndXRyb25peC5kZT47IExvcmVuem8gUGllcmFsaXNpIDxsb3Jlbnpv
LnBpZXJhbGlzaUBhcm0uY29tPjsgUm9iDQo+IEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz47IEty
enlzenRvZiBXaWxjenmovXNraSA8a3dAbGludXguY29tPjsgU2FzY2hhDQo+IEhhdWVyIDxzLmhh
dWVyQHBlbmd1dHJvbml4LmRlPjsgUGVuZ3V0cm9uaXggS2VybmVsIFRlYW0NCj4gPGtlcm5lbEBw
ZW5ndXRyb25peC5kZT47IEZhYmlvIEVzdGV2YW0gPGZlc3RldmFtQGdtYWlsLmNvbT47DQo+IGRs
LWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+OyBKYXNvbiBMaXUgPGphc29uLmh1aS5saXVA
bnhwLmNvbT4NCj4gQ2M6IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsg
Qmpvcm4gSGVsZ2FhcyA8YmhlbGdhYXNAZ29vZ2xlLmNvbT47IFNoYXduDQo+IEd1byA8c2hhd25n
dW9Aa2VybmVsLm9yZz47IEZyYW5jZXNjbyBEb2xjaW5pDQo+IDxmcmFuY2VzY28uZG9sY2luaUB0
b3JhZGV4LmNvbT4NCj4gU3ViamVjdDogW1JGQyBQQVRDSF0gUENJOiBpbXg2OiBIYW5kbGUgdGhl
IGFib3J0IGZyb20gdXNlci1zcGFjZQ0KPiANCj4gRnJvbTogSmFzb24gTGl1IDxqYXNvbi5odWku
bGl1QG54cC5jb20+DQo+IA0KPiBUaGUgZHJpdmVyIGluc3RhbGwgb25lIGhvb2sgdG8gaGFuZGxl
IHRoZSBleHRlcm5hbCBhYm9ydCwgYnV0IGlzc3VlIGlzIHRoYXQgaWYgdGhlDQo+IGFib3J0IGlu
dHJvZHVjZWQgZnJvbSB1c2VyIHNwYWNlIGNvZGUsIHRoZSBmb2xsb3dpbmcgY29kZSB1bnNpZ25l
ZCBsb25nIGluc3RyDQo+ID0gKih1bnNpZ25lZCBsb25nICopcGM7IHdoaWNoIHdpbGwgY3JlYXRl
ZCBhbm90aGVyIGRhdGEtYWJvcnQocGFnZSBkb21haW4NCj4gZmF1bHQpIGlmIENPTkZJR19DUFVf
U1dfRE9NQUlOX1BBTi4NCj4gDQo+IFRoZSBwYXRjaCBkb2VzIG5vdCBpbnRlbnQgdG8gdXNlIGNv
cHlfZnJvbV91c2VyIGFuZCB0aGVuIGRvIHRoZSBoYWNrIGR1ZSB0bw0KPiB0aGUgc2VjdXJpdHkg
Y29uc2lkZXJhdGlvbi4gSW4gZmFjdCwgd2UgY2FuIGp1c3QgcmV0dXJuIGFuZCByZXBvcnQgdGhl
IGV4dGVybmFsDQo+IGFib3J0IHRvIHVzZXItc3BhY2UuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBK
YXNvbiBMaXUgPGphc29uLmh1aS5saXVAbnhwLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IFJpY2hhcmQg
Wmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogRnJhbmNlc2NvIERv
bGNpbmkgPGZyYW5jZXNjby5kb2xjaW5pQHRvcmFkZXguY29tPg0KPiAtLS0NCj4gV2UgaGF2ZSB0
aGlzIHBhdGNoIGZyb20gTlhQIGRvd25zdHJlYW0ga2VybmVsIFsxXSBpbiBvdXIga2VybmVsIGJy
YW5jaCBbMl0NCj4gc2luY2UgYSBsb25nIHRpbWUsIHRvIG1lIGl0IHdvdWxkIG1ha2Ugc2Vuc2Ug
dG8gdXBzdHJlYW0gaXQuIEFueSBjb25jZXJuPw0KPiANCj4gWzFdDQo+IGh0dHBzOi8vZXVyMDEu
c2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRnNvdXJj
ZS4NCj4gY29kZWF1cm9yYS5vcmclMkZleHRlcm5hbCUyRmlteHN1cHBvcnQlMkZsaW51eC1pbXgl
MkZjb21taXQlMkYlM0ZpZA0KPiAlM0Q2MmRmYjJmYjk1MzQ2M2RkMWI2NzEwNTY3YzllMTc0Njcy
YTk4ZjI0JmFtcDtkYXRhPTA0JTdDMDElNw0KPiBDaG9uZ3hpbmcuemh1JTQwbnhwLmNvbSU3Q2Ni
ZTE5M2FiNGMzZTRhZDExYmNiMDhkOWUyMzg0YTFmJTdDNjgNCj4gNmVhMWQzYmMyYjRjNmZhOTJj
ZDk5YzVjMzAxNjM1JTdDMCU3QzAlN0M2Mzc3ODk1NTM2NTk1NDkxOTglNw0KPiBDVW5rbm93biU3
Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUDQo+
IGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MzMDAwJmFtcDtzZGF0YT1Nd2h4OERGRjdFREpk
cHFUc0hUDQo+ICUyQkJBR3poUWFkRE9xY2dKblZqZW9pMXlrJTNEJmFtcDtyZXNlcnZlZD0wDQo+
IFsyXQ0KPiBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91
cmw9aHR0cHMlM0ElMkYlMkZnaXQudG9yYQ0KPiBkZXguY29tJTJGY2dpdCUyRmxpbnV4LXRvcmFk
ZXguZ2l0JTJGY29tbWl0JTJGJTNGaWQlM0QyYjQyNTQ3Y2Y2NTlmDQo+IDk3OWJlMmRlZmRmZjZh
OTlmOTIxYjMzZDBmMSZhbXA7ZGF0YT0wNCU3QzAxJTdDaG9uZ3hpbmcuemh1JTQwbngNCj4gcC5j
b20lN0NjYmUxOTNhYjRjM2U0YWQxMWJjYjA4ZDllMjM4NGExZiU3QzY4NmVhMWQzYmMyYjRjNmZh
OTJjDQo+IGQ5OWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM3Nzg5NTUzNjU5NTQ5MTk4JTdDVW5rbm93
biU3Q1RXRnANCj4gYkdac2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlM
Q0pCVGlJNklrMWhhV3dpTENKWFZDSQ0KPiA2TW4wJTNEJTdDMzAwMCZhbXA7c2RhdGE9UUVXMWZy
aDhXYWNDem5pV280bmcxY3kzWjFVWjl1TVJGdw0KPiBHQkt1SWg3ekUlM0QmYW1wO3Jlc2VydmVk
PTANCj4gLS0tDQo+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jIHwgMTIg
KysrKysrKysrKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9w
Y2ktaW14Ni5jDQo+IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiBp
bmRleCA2OTc0YmQ1YWExMTYuLjZiMTc4YTI5ZTI1MyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9w
Y2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9s
bGVyL2R3Yy9wY2ktaW14Ni5jDQo+IEBAIC0yNyw2ICsyNyw3IEBADQo+ICAjaW5jbHVkZSA8bGlu
dXgvcmVzb3VyY2UuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9zaWduYWwuaD4NCj4gICNpbmNsdWRl
IDxsaW51eC90eXBlcy5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L3VhY2Nlc3MuaD4NCg0KW1JpY2hh
cmQgWmh1XSBUaGFua3MgZm9yIHlvdXIga2luZGx5IGhlbHAuDQpUaGlzIGhlYWRlciBpbmNsdWRl
IGlzIG5vdCByZXF1aXJlZCBhY3R1YWxseSwgcGxlYXNlIHJlbW92ZSBpdC4NCkJlc3QgUmVnYXJk
cw0KUmljaGFyZA0KDQo+ICAjaW5jbHVkZSA8bGludXgvaW50ZXJydXB0Lmg+DQo+ICAjaW5jbHVk
ZSA8bGludXgvcmVzZXQuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9waHkvcGh5Lmg+DQo+IEBAIC0y
OTcsOCArMjk4LDE1IEBAIHN0YXRpYyBpbnQgaW14NnFfcGNpZV9hYm9ydF9oYW5kbGVyKHVuc2ln
bmVkIGxvbmcNCj4gYWRkciwNCj4gIAkJdW5zaWduZWQgaW50IGZzciwgc3RydWN0IHB0X3JlZ3Mg
KnJlZ3MpICB7DQo+ICAJdW5zaWduZWQgbG9uZyBwYyA9IGluc3RydWN0aW9uX3BvaW50ZXIocmVn
cyk7DQo+IC0JdW5zaWduZWQgbG9uZyBpbnN0ciA9ICoodW5zaWduZWQgbG9uZyAqKXBjOw0KPiAt
CWludCByZWcgPSAoaW5zdHIgPj4gMTIpICYgMTU7DQo+ICsJdW5zaWduZWQgbG9uZyBpbnN0cjsN
Cj4gKwlpbnQgcmVnOw0KPiArDQo+ICsJLyogaWYgdGhlIGFib3J0IGZyb20gdXNlci1zcGFjZSwg
anVzdCByZXR1cm4gYW5kIHJlcG9ydCBpdCAqLw0KPiArCWlmICh1c2VyX21vZGUocmVncykpDQo+
ICsJCXJldHVybiAxOw0KPiArDQo+ICsJaW5zdHIgPSAqKHVuc2lnbmVkIGxvbmcgKilwYzsNCj4g
KwlyZWcgPSAoaW5zdHIgPj4gMTIpICYgMTU7DQo+IA0KPiAgCS8qDQo+ICAJICogSWYgdGhlIGlu
c3RydWN0aW9uIGJlaW5nIGV4ZWN1dGVkIHdhcyBhIHJlYWQsDQo+IC0tDQo+IDIuMjUuMQ0KDQo=
