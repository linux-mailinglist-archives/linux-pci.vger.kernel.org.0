Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4385AAACC
	for <lists+linux-pci@lfdr.de>; Fri,  2 Sep 2022 11:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234698AbiIBJCZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Sep 2022 05:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiIBJCY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Sep 2022 05:02:24 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2042.outbound.protection.outlook.com [40.107.21.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010FAA1A7D;
        Fri,  2 Sep 2022 02:02:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oGbepYLQCgX0bCAuuNG+2KfNKPWdKzAegBBM6JuUosqRSfNv+L56Vuj+/4RJVo+r9hYA8QApV6M9PLE7ACPU0QBtq5+arhYDV6MOOlqWrUmkQoynEshpFVW8RfSBCAAlo++DfvWQJ2PpHtc2Oo6b0P3ITKZtMIqmVI3qbIKbVsUlaLx55f47mNuOaBNY5Hs4+r4SbPhfqtnV5dCkvTjnwf8YaItanogQ6XlqWT7Ht4dv+uZVzqEWk85kU6LvV7wAYhOqS3HY/g9Cmttdv+SSIwYsJdoaVnnLeqLAoy4D5XNlaqKJMZJe167EJBvvsh4GBrDYjp/2Pr9yG4yOLMNFXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iUEpVqRz7V4FQxTPBXvjOPICXfKI4alaMx0r33Wr7qk=;
 b=Mr1iOBpYXkKjmSDp/ZkCd9ASxyXwLJVvBET21Av5PvcHVJwVWQgqzUATj/q2Aw/j5by1eKqqGB78JixHyQUGQ9FtYCtn8jtXS7Dji87sYZqtWrtWn6jlVndR0snm/8ZsIc/iVUJmRZ56yqE/v2CYcOxHAe34TEMIaaAlNVD126mSDqh75b0s2yPrzLXPNt0+M7UHEPyk6YBqiWIgoO/LxTfXVF0dx9YN8VKdgWVMF7bnzXlE+Py29n2IpgP6taZe4vzF2RAt1HGmfoM//elLp2TnA40jgWFnavqPZw+/PKj0/sRScLa2v/BqCyl0NkrqQu7bykB2R/R8PBsjb/iNJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUEpVqRz7V4FQxTPBXvjOPICXfKI4alaMx0r33Wr7qk=;
 b=S5HfBE36I5Axct+yc09GONCOwLOEAd6bema7QPPdGQk8mgaWu0DbquXcbBaqCGLxJ92yminLjpwdpAJlOVEJ3S0kQ57lk6jOV1V4Xgmek6w8qeidXNXPzxu70kqvuCOaQjQ3IYWJbLJVkFjn7pwAvSwS1HoCdpl+HqVJd5tvH4c=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM0PR04MB4033.eurprd04.prod.outlook.com (2603:10a6:208:5b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.15; Fri, 2 Sep
 2022 09:02:15 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::13c:5622:af8a:b2da]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::13c:5622:af8a:b2da%9]) with mapi id 15.20.5588.014; Fri, 2 Sep 2022
 09:02:15 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        "marex@denx.de" <marex@denx.de>,
        "richard.leitner@linux.dev" <richard.leitner@linux.dev>
CC:     "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v6 7/7] PCI: imx6: Add i.MX8MP PCIe support
Thread-Topic: [PATCH v6 7/7] PCI: imx6: Add i.MX8MP PCIe support
Thread-Index: AQHYvbowypRU1o3SbEyZai0vkB9QEa3L1DCAgAAFVKA=
Date:   Fri, 2 Sep 2022 09:02:15 +0000
Message-ID: <AS8PR04MB8676FE52BDAF913858F581878C7A9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1662004960-14071-1-git-send-email-hongxing.zhu@nxp.com>
         <1662004960-14071-8-git-send-email-hongxing.zhu@nxp.com>
 <b4add7855fe7154c65728efe22461c0fbc6937bb.camel@pengutronix.de>
In-Reply-To: <b4add7855fe7154c65728efe22461c0fbc6937bb.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a0744d2-d2fb-4107-9e23-08da8cc1d4fb
x-ms-traffictypediagnostic: AM0PR04MB4033:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fq5A+DcgZnA0/0I+ovzvKQFVCjHINmU1fOrI75JLyNHokxS7ZbjxTIo1BUxXArJMMn/85X2ZM/Kzhn9ofomo1nr3N7TSNsfT37RJFPDKXf5wZ2k/mAVYGtSFAvzr+ZsOWSKLu2bFrsQc8+VTYPlfH28WKhi+MpgBO64XCmXur2dop43DvvlAsOoZ52RZllPiPsJMDoUfXSDjEGJWBjiuiY1eXlqzFlNEzstLTLdI2PF1fq/IuRsE473h2b8dPvfKKeaYNiXGE7bYtlPl+VJSf4SpNImYOwLAfkdziATd0Ega4AZ43wKVsiezCJJGsuuTX4pbDba2U6dVR4G8rsnx6RQ3n1yBe4WcYXJLrvRQG6dz1w9IbFzIK4FINC2DeJ2TJTyOqZ5dHE2l7rogJwEd6eHe2jaWxInxCRVY9XSvjETM5qAdNnUn49iDPH2c2ENYYuPD+CEv3uc3X6qF08UOUcWwqWPtwnuZ+erD+Ha1EEmvueBnt76o7Wx9b+ei9Shi5Z9OzQ1hjjk/c0rv30KSE1ZCXehBRKnK7cm4j0Fc1Yb2BCqhPH3XJoBluMuPKaVvD0l5ZBl4papJCF2KOlTIfkdMjC1MWWoXFUnDhuvevGDTeCmJLLta0usqH+qdun+bf0hyP3C/MkXygI/GurqRo1JSMH+BnermV5ArCjqV4JC/lo3z/sOrjbLP3hWVUdnCCy29upieZCh4hS8PlIAUtCNUDWAfn7rgHqDTF21OMtqhSy3up2yjXItbKFjz1R7OXYbgVOwPnAvKpj/CCCHzeg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(83380400001)(122000001)(921005)(38100700002)(38070700005)(66476007)(66946007)(66556008)(55016003)(76116006)(64756008)(66446008)(8676002)(4326008)(110136005)(54906003)(316002)(2906002)(52536014)(44832011)(7416002)(8936002)(5660300002)(6506007)(7696005)(9686003)(26005)(53546011)(186003)(71200400001)(41300700001)(478600001)(86362001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?czZVMXZVVHNLb3ZTekxIL293cmI3NlVkNGxlc1BJYXFRbDZEakZtclIvbWN5?=
 =?utf-8?B?VmsrQ2ZOVWRkNEFzRVhEaW5mdjNIckVyRGl4MHc4WG95Q29mUDFhSDlOSGJ0?=
 =?utf-8?B?M0NzM2JGUmVjRlc2Yy9KeGhPL2FRc252eFRubEdqcXFtK1ZPdVhIaFEyZ0RI?=
 =?utf-8?B?VEZqOEFUQVJpOFhrcXJlQWtYdjlNZzMxSjR0ZFF6UnVkYUZvS216SFg5R0Q4?=
 =?utf-8?B?S1k1TWhUNWZWazU4czdjRHNLeW05L0g0ODR1K1kvRlgwejJBT0lENWIwRG1u?=
 =?utf-8?B?dUZYdnFrSDhCS25oM0xJSFJEdmJhUnpwQndLMyt3MnZ1LzdsVnRqa0NQbjNw?=
 =?utf-8?B?QlFRM0c1MjExNFZGYm1jZit5SlNYWEYyZWZyT0Q3M1VYb2lsMXVHbUprZW1p?=
 =?utf-8?B?eEN4SCtQaFlpd3h2eWFWSmU4UW4xTXhYKzNvdWk3MUVVYW1oL0xkSnZNUkhh?=
 =?utf-8?B?eWxTSDJ2TzQzVVVzcGtVSGNicGNGNFFFWHpUajFGUmdYMlN6dlJLR0kyWkR0?=
 =?utf-8?B?dHN5RUlrSWhlTDZQNUM4NkQrVmNMeWNpeVlwK2xKMzBqUlRRbkZZRFJ3dWtn?=
 =?utf-8?B?amJvMTRyQ3NvNUlLMHcxMkxiVlI1M0p4NmsxNituMXlCblludURvVEQwV2FQ?=
 =?utf-8?B?bGJtblhzM3U0dnRmUkhJcVMwdDdtL1ZZakhqYUpoOFI2NEU2eU9HZTFua3Qx?=
 =?utf-8?B?ekR4bTRQVWgxODNRYm5GQjBORmlhWWhJc3ZRVGxIdS8xcXhrNEg2bitDYXlT?=
 =?utf-8?B?bnc3ajhCeW5pdnFacTZJZ0NrTGNvMEJzaXJwUVBtYmNHZG9hVWJsMU53L0xs?=
 =?utf-8?B?UmNnNXBMYm9PNDFacHN6ZE9DNzkxbnNvU1YwNjRVSjdmT3lmOEJHOE9VZVE4?=
 =?utf-8?B?WERwN3FqNGxWcFEvRnFtbmpFN290SC9BZDdrQnFRd0VsbWVlZC9Ic2wzNkZu?=
 =?utf-8?B?cUtXcmh5N3lsaFlZNnpQdkJWb3h3dGZGSXZpbTcwbmxkdkhkRHo2ZWg3clMv?=
 =?utf-8?B?Qkt0OUh5QWFzcmJhMXFlUjcrTVR6cjBibTdtU3JqQkV6NHpvTTlwelc1NzRm?=
 =?utf-8?B?YU5Gc09nY1FFZFNmZUZ6aTNoSW45Z1RsZ2lpbFFmNGFlVkdUUHAydTl1NHF1?=
 =?utf-8?B?cWFxb3lsbEg5NHVrbVBsWU5pUVM5ZDNORmJlbEw1ditWYWFLZlRabXlRUEJZ?=
 =?utf-8?B?STNub29SOU5objBWdmJDbHFuMVJKNTR5d3JPbjIvazhhNXBPZGV0MGZoamVq?=
 =?utf-8?B?dmJIcW8zcDdzTHBTUzNPMjBhZStNazRQRWhuTDNuZlVDZ3A3N3ZZQTBLODVi?=
 =?utf-8?B?L3g0ZDJiUUFWY296VWJjcFpTUFAzZlI5R0VOdDVEcjhjYUlObk50cUZOOWVN?=
 =?utf-8?B?SUd6MndZdjlneHhwblQ1OE9kQmZwNmlzMFNVOFRRdVhVb0U2djNwRmd6NURx?=
 =?utf-8?B?Slp1T2VQVHlMQTVNdVU3dE9kWlBXZEwzNi9jWDFZdW02b1NNN0pTSXNJZUMx?=
 =?utf-8?B?dlBGclpVV1FUNjNBSktSR2lMamlRUlRkOFdXV25CNkJSS05nZ3BPOUw5SnJa?=
 =?utf-8?B?cldjemxpRWNLZnE0T2NGaEswZlcwRXFhV250UDgzbFBPY0FORExIelJOeS80?=
 =?utf-8?B?bUx5eHIyWDg2N0UrZ0dmMnpDNm1pNEx5OFY3OTJoT0dhN2ZyWDQ3cnNGajc4?=
 =?utf-8?B?eEkwQXJHTnRPcnlCV0VZRUtaOHh6ckNsdE5IRmhrcGZkN3hsbU0xQkNYY0RR?=
 =?utf-8?B?WEhoT3I0UEFjdmIxdFN0bmZYekFNbGVobnFPb0dETkRxMEwrd0E0Vk5IRi8y?=
 =?utf-8?B?Y1JOYTNhRnkyYmxPaFc2ZGhVNFdaMWJKa3dEb2N4d3Q4THJrbVpoVHZ2L25v?=
 =?utf-8?B?dm9VTU16bDBPWkNRZzRQeExuUHZyNERNYVo0NFFmQkNVcHBEWTEzWllmSDhC?=
 =?utf-8?B?ZU5JQjNUZVJDaGYrbFpEUVpIQjRDdGgvZjZ2SHFteURVQm5oNWRaaklNdUZG?=
 =?utf-8?B?R1ZVbW9vbGd5ZFJGM3E5elc0MUkxeUQ5SGR4OTBkU3Q3a1RlN2dmZW9pY1Bw?=
 =?utf-8?B?NUxhUTN0cUlTa0QwSkhPWitnVzVkUDkvbDFocHIvRDZwMUFRY0dBckh1K2Yx?=
 =?utf-8?Q?VH7JqBEMLHMMYN2y1IkFGSWJo?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a0744d2-d2fb-4107-9e23-08da8cc1d4fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2022 09:02:15.5558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: reylNnIgw6ZSaIAIqOkX44AauGh2/m2hDHdM9SmMkTf+fKsh7vjRfdt9lk/56XrqQLKmpoGTqXty4OFf5DglZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4033
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMdWNhcyBTdGFjaCA8bC5zdGFj
aEBwZW5ndXRyb25peC5kZT4NCj4gU2VudDogMjAyMuW5tDnmnIgy5pelIDE2OjQyDQo+IFRvOiBI
b25neGluZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPjsgcC56YWJlbEBwZW5ndXRyb25peC5k
ZTsNCj4gYmhlbGdhYXNAZ29vZ2xlLmNvbTsgbG9yZW56by5waWVyYWxpc2lAYXJtLmNvbTsgcm9i
aEBrZXJuZWwub3JnOw0KPiBzaGF3bmd1b0BrZXJuZWwub3JnOyB2a291bEBrZXJuZWwub3JnOyBh
bGV4YW5kZXIuc3RlaW5AZXcudHEtZ3JvdXAuY29tOw0KPiBtYXJleEBkZW54LmRlOyByaWNoYXJk
LmxlaXRuZXJAbGludXguZGV2DQo+IENjOiBsaW51eC1waHlAbGlzdHMuaW5mcmFkZWFkLm9yZzsg
ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsga2VybmVsQHBlbmd1dHJvbml4LmRlOyBkbC1saW51eC1pbXgNCj4gPGxp
bnV4LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY2IDcvN10gUENJOiBpbXg2
OiBBZGQgaS5NWDhNUCBQQ0llIHN1cHBvcnQNCj4gDQo+IEFtIERvbm5lcnN0YWcsIGRlbSAwMS4w
OS4yMDIyIHVtIDEyOjAyICswODAwIHNjaHJpZWIgUmljaGFyZCBaaHU6DQo+ID4gQWRkIGkuTVg4
TVAgUENJZSBzdXBwb3J0Lg0KPiA+IFRvIGF2b2lkIGNvZGVzIGR1cGxpY2F0aW9uIHdoZW4gZmlu
ZCB0aGUgc3lzY29uIHJlZ21hcCwgYWRkIHRoZSBpb211eA0KPiA+IGdwciBzeXNjb24gY29tcGF0
aWJsZSBpbnRvIGRydmRhdGEuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJkIFpodSA8
aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+ID4gVGVzdGVkLWJ5OiBNYXJlayBWYXN1dCA8bWFyZXhA
ZGVueC5kZT4NCj4gPiBUZXN0ZWQtYnk6IFJpY2hhcmQgTGVpdG5lciA8cmljaGFyZC5sZWl0bmVy
QHNraWRhdGEuY29tPg0KPiA+IFRlc3RlZC1ieTogQWxleGFuZGVyIFN0ZWluIDxhbGV4YW5kZXIu
c3RlaW5AZXcudHEtZ3JvdXAuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3BjaS9jb250cm9s
bGVyL2R3Yy9wY2ktaW14Ni5jIHwgMjcNCj4gPiArKysrKysrKysrKysrKysrKysrKysrKysrLS0N
Cj4gPiAgMSBmaWxlIGNoYW5nZWQsIDI1IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+
ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYu
Yw0KPiA+IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+IGluZGV4
IDZlNWRlYmRiYzU1Yi4uMzAxOGY5ZDFjMWI4IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9s
bGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gQEAgLTUxLDYgKzUxLDcgQEAgZW51bSBpbXg2X3BjaWVf
dmFyaWFudHMgew0KPiA+ICAJSU1YN0QsDQo+ID4gIAlJTVg4TVEsDQo+ID4gIAlJTVg4TU0sDQo+
ID4gKwlJTVg4TVAsDQo+ID4gIH07DQo+ID4NCj4gPiAgI2RlZmluZSBJTVg2X1BDSUVfRkxBR19J
TVg2X1BIWQkJCUJJVCgwKQ0KPiA+IEBAIC02MSw2ICs2Miw3IEBAIHN0cnVjdCBpbXg2X3BjaWVf
ZHJ2ZGF0YSB7DQo+ID4gIAllbnVtIGlteDZfcGNpZV92YXJpYW50cyB2YXJpYW50Ow0KPiA+ICAJ
dTMyIGZsYWdzOw0KPiA+ICAJaW50IGRiaV9sZW5ndGg7DQo+ID4gKwljaGFyIGdwclsxMjhdOw0K
PiANCj4gU2FtZSBjb21tZW50IGFzIHdpdGggdGhlIFBIWSBwYXRjaDoNCj4gY29uc3QgY2hhciAq
Z3ByOw0KPiANCj4gT3RoZXJ3aXNlIGxvb2tzIGdvb2QuDQpPa2F5LCB3b3VsZCBiZSBjaGFuZ2Ug
dG8gY29uc3QgY2hhciAqZ3ByLg0KVGhhbmtzIGZvciB5b3VyIHJldmlldy4NCg0KQmVzdCBSZWdh
cmRzDQpSaWNoYXJkIFpodQ0KPiANCj4gUmVnYXJkcywNCj4gTHVjYXMNCj4gDQo+ID4gIH07DQo+
ID4NCj4gPiAgc3RydWN0IGlteDZfcGNpZSB7DQo+ID4gQEAgLTE1MCw3ICsxNTIsOCBAQCBzdHJ1
Y3QgaW14Nl9wY2llIHsgIHN0YXRpYyB1bnNpZ25lZCBpbnQNCj4gPiBpbXg2X3BjaWVfZ3JwX29m
ZnNldChjb25zdCBzdHJ1Y3QgaW14Nl9wY2llICppbXg2X3BjaWUpICB7DQo+ID4gIAlXQVJOX09O
KGlteDZfcGNpZS0+ZHJ2ZGF0YS0+dmFyaWFudCAhPSBJTVg4TVEgJiYNCj4gPiAtCQlpbXg2X3Bj
aWUtPmRydmRhdGEtPnZhcmlhbnQgIT0gSU1YOE1NKTsNCj4gPiArCQlpbXg2X3BjaWUtPmRydmRh
dGEtPnZhcmlhbnQgIT0gSU1YOE1NICYmDQo+ID4gKwkJaW14Nl9wY2llLT5kcnZkYXRhLT52YXJp
YW50ICE9IElNWDhNUCk7DQo+ID4gIAlyZXR1cm4gaW14Nl9wY2llLT5jb250cm9sbGVyX2lkID09
IDEgPyBJT01VWENfR1BSMTYgOiBJT01VWENfR1BSMTQ7DQo+ID4gfQ0KPiA+DQo+ID4gQEAgLTMw
MSw2ICszMDQsNyBAQCBzdGF0aWMgdm9pZCBpbXg2X3BjaWVfaW5pdF9waHkoc3RydWN0IGlteDZf
cGNpZQ0KPiA+ICppbXg2X3BjaWUpICB7DQo+ID4gIAlzd2l0Y2ggKGlteDZfcGNpZS0+ZHJ2ZGF0
YS0+dmFyaWFudCkgew0KPiA+ICAJY2FzZSBJTVg4TU06DQo+ID4gKwljYXNlIElNWDhNUDoNCj4g
PiAgCQkvKg0KPiA+ICAJCSAqIFRoZSBQSFkgaW5pdGlhbGl6YXRpb24gaGFkIGJlZW4gZG9uZSBp
biB0aGUgUEhZDQo+ID4gIAkJICogZHJpdmVyLCBicmVhayBoZXJlIGRpcmVjdGx5Lg0KPiA+IEBA
IC01NTgsNiArNTYyLDcgQEAgc3RhdGljIGludCBpbXg2X3BjaWVfZW5hYmxlX3JlZl9jbGsoc3Ry
dWN0IGlteDZfcGNpZQ0KPiAqaW14Nl9wY2llKQ0KPiA+ICAJCWJyZWFrOw0KPiA+ICAJY2FzZSBJ
TVg4TU06DQo+ID4gIAljYXNlIElNWDhNUToNCj4gPiArCWNhc2UgSU1YOE1QOg0KPiA+ICAJCXJl
dCA9IGNsa19wcmVwYXJlX2VuYWJsZShpbXg2X3BjaWUtPnBjaWVfYXV4KTsNCj4gPiAgCQlpZiAo
cmV0KSB7DQo+ID4gIAkJCWRldl9lcnIoZGV2LCAidW5hYmxlIHRvIGVuYWJsZSBwY2llX2F1eCBj
bG9ja1xuIik7IEBAIC02MDIsNg0KPiA+ICs2MDcsNyBAQCBzdGF0aWMgdm9pZCBpbXg2X3BjaWVf
ZGlzYWJsZV9yZWZfY2xrKHN0cnVjdCBpbXg2X3BjaWUNCj4gKmlteDZfcGNpZSkNCj4gPiAgCQli
cmVhazsNCj4gPiAgCWNhc2UgSU1YOE1NOg0KPiA+ICAJY2FzZSBJTVg4TVE6DQo+ID4gKwljYXNl
IElNWDhNUDoNCj4gPiAgCQljbGtfZGlzYWJsZV91bnByZXBhcmUoaW14Nl9wY2llLT5wY2llX2F1
eCk7DQo+ID4gIAkJYnJlYWs7DQo+ID4gIAlkZWZhdWx0Og0KPiA+IEBAIC02NjksNiArNjc1LDcg
QEAgc3RhdGljIHZvaWQgaW14Nl9wY2llX2Fzc2VydF9jb3JlX3Jlc2V0KHN0cnVjdA0KPiBpbXg2
X3BjaWUgKmlteDZfcGNpZSkNCj4gPiAgCQlyZXNldF9jb250cm9sX2Fzc2VydChpbXg2X3BjaWUt
PnBjaWVwaHlfcmVzZXQpOw0KPiA+ICAJCWZhbGx0aHJvdWdoOw0KPiA+ICAJY2FzZSBJTVg4TU06
DQo+ID4gKwljYXNlIElNWDhNUDoNCj4gPiAgCQlyZXNldF9jb250cm9sX2Fzc2VydChpbXg2X3Bj
aWUtPmFwcHNfcmVzZXQpOw0KPiA+ICAJCWJyZWFrOw0KPiA+ICAJY2FzZSBJTVg2U1g6DQo+ID4g
QEAgLTc0NCw2ICs3NTEsNyBAQCBzdGF0aWMgaW50IGlteDZfcGNpZV9kZWFzc2VydF9jb3JlX3Jl
c2V0KHN0cnVjdA0KPiBpbXg2X3BjaWUgKmlteDZfcGNpZSkNCj4gPiAgCQlicmVhazsNCj4gPiAg
CWNhc2UgSU1YNlE6CQkvKiBOb3RoaW5nIHRvIGRvICovDQo+ID4gIAljYXNlIElNWDhNTToNCj4g
PiArCWNhc2UgSU1YOE1QOg0KPiA+ICAJCWJyZWFrOw0KPiA+ICAJfQ0KPiA+DQo+ID4gQEAgLTc5
Myw2ICs4MDEsNyBAQCBzdGF0aWMgdm9pZCBpbXg2X3BjaWVfbHRzc21fZW5hYmxlKHN0cnVjdCBk
ZXZpY2UNCj4gKmRldikNCj4gPiAgCWNhc2UgSU1YN0Q6DQo+ID4gIAljYXNlIElNWDhNUToNCj4g
PiAgCWNhc2UgSU1YOE1NOg0KPiA+ICsJY2FzZSBJTVg4TVA6DQo+ID4gIAkJcmVzZXRfY29udHJv
bF9kZWFzc2VydChpbXg2X3BjaWUtPmFwcHNfcmVzZXQpOw0KPiA+ICAJCWJyZWFrOw0KPiA+ICAJ
fQ0KPiA+IEBAIC04MTIsNiArODIxLDcgQEAgc3RhdGljIHZvaWQgaW14Nl9wY2llX2x0c3NtX2Rp
c2FibGUoc3RydWN0IGRldmljZQ0KPiAqZGV2KQ0KPiA+ICAJY2FzZSBJTVg3RDoNCj4gPiAgCWNh
c2UgSU1YOE1ROg0KPiA+ICAJY2FzZSBJTVg4TU06DQo+ID4gKwljYXNlIElNWDhNUDoNCj4gPiAg
CQlyZXNldF9jb250cm9sX2Fzc2VydChpbXg2X3BjaWUtPmFwcHNfcmVzZXQpOw0KPiA+ICAJCWJy
ZWFrOw0KPiA+ICAJfQ0KPiA+IEBAIC0xMTc5LDYgKzExODksNyBAQCBzdGF0aWMgaW50IGlteDZf
cGNpZV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+ICpwZGV2KQ0KPiA+ICAJCX0NCj4g
PiAgCQlicmVhazsNCj4gPiAgCWNhc2UgSU1YOE1NOg0KPiA+ICsJY2FzZSBJTVg4TVA6DQo+ID4g
IAkJaW14Nl9wY2llLT5wY2llX2F1eCA9IGRldm1fY2xrX2dldChkZXYsICJwY2llX2F1eCIpOw0K
PiA+ICAJCWlmIChJU19FUlIoaW14Nl9wY2llLT5wY2llX2F1eCkpDQo+ID4gIAkJCXJldHVybiBk
ZXZfZXJyX3Byb2JlKGRldiwgUFRSX0VSUihpbXg2X3BjaWUtPnBjaWVfYXV4KSwgQEANCj4gLTEy
MTYsNw0KPiA+ICsxMjI3LDcgQEAgc3RhdGljIGludCBpbXg2X3BjaWVfcHJvYmUoc3RydWN0IHBs
YXRmb3JtX2RldmljZSAqcGRldikNCj4gPg0KPiA+ICAJLyogR3JhYiBHUFIgY29uZmlnIHJlZ2lz
dGVyIHJhbmdlICovDQo+ID4gIAlpbXg2X3BjaWUtPmlvbXV4Y19ncHIgPQ0KPiA+IC0JCSBzeXNj
b25fcmVnbWFwX2xvb2t1cF9ieV9jb21wYXRpYmxlKCJmc2wsaW14NnEtaW9tdXhjLWdwciIpOw0K
PiA+ICsJCSBzeXNjb25fcmVnbWFwX2xvb2t1cF9ieV9jb21wYXRpYmxlKGlteDZfcGNpZS0+ZHJ2
ZGF0YS0+Z3ByKTsNCj4gPiAgCWlmIChJU19FUlIoaW14Nl9wY2llLT5pb211eGNfZ3ByKSkgew0K
PiA+ICAJCWRldl9lcnIoZGV2LCAidW5hYmxlIHRvIGZpbmQgaW9tdXhjIHJlZ2lzdGVyc1xuIik7
DQo+ID4gIAkJcmV0dXJuIFBUUl9FUlIoaW14Nl9wY2llLT5pb211eGNfZ3ByKTsgQEAgLTEyOTUs
MTIgKzEzMDYsMTQNCj4gQEANCj4gPiBzdGF0aWMgY29uc3Qgc3RydWN0IGlteDZfcGNpZV9kcnZk
YXRhIGRydmRhdGFbXSA9IHsNCj4gPiAgCQkuZmxhZ3MgPSBJTVg2X1BDSUVfRkxBR19JTVg2X1BI
WSB8DQo+ID4gIAkJCSBJTVg2X1BDSUVfRkxBR19JTVg2X1NQRUVEX0NIQU5HRSwNCj4gPiAgCQku
ZGJpX2xlbmd0aCA9IDB4MjAwLA0KPiA+ICsJCS5ncHIgPSAiZnNsLGlteDZxLWlvbXV4Yy1ncHIi
LA0KPiA+ICAJfSwNCj4gPiAgCVtJTVg2U1hdID0gew0KPiA+ICAJCS52YXJpYW50ID0gSU1YNlNY
LA0KPiA+ICAJCS5mbGFncyA9IElNWDZfUENJRV9GTEFHX0lNWDZfUEhZIHwNCj4gPiAgCQkJIElN
WDZfUENJRV9GTEFHX0lNWDZfU1BFRURfQ0hBTkdFIHwNCj4gPiAgCQkJIElNWDZfUENJRV9GTEFH
X1NVUFBPUlRTX1NVU1BFTkQsDQo+ID4gKwkJLmdwciA9ICJmc2wsaW14NnEtaW9tdXhjLWdwciIs
DQo+ID4gIAl9LA0KPiA+ICAJW0lNWDZRUF0gPSB7DQo+ID4gIAkJLnZhcmlhbnQgPSBJTVg2UVAs
DQo+ID4gQEAgLTEzMDgsMTcgKzEzMjEsMjYgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBpbXg2X3Bj
aWVfZHJ2ZGF0YSBkcnZkYXRhW10NCj4gPSB7DQo+ID4gIAkJCSBJTVg2X1BDSUVfRkxBR19JTVg2
X1NQRUVEX0NIQU5HRSB8DQo+ID4gIAkJCSBJTVg2X1BDSUVfRkxBR19TVVBQT1JUU19TVVNQRU5E
LA0KPiA+ICAJCS5kYmlfbGVuZ3RoID0gMHgyMDAsDQo+ID4gKwkJLmdwciA9ICJmc2wsaW14NnEt
aW9tdXhjLWdwciIsDQo+ID4gIAl9LA0KPiA+ICAJW0lNWDdEXSA9IHsNCj4gPiAgCQkudmFyaWFu
dCA9IElNWDdELA0KPiA+ICAJCS5mbGFncyA9IElNWDZfUENJRV9GTEFHX1NVUFBPUlRTX1NVU1BF
TkQsDQo+ID4gKwkJLmdwciA9ICJmc2wsaW14N2QtaW9tdXhjLWdwciIsDQo+ID4gIAl9LA0KPiA+
ICAJW0lNWDhNUV0gPSB7DQo+ID4gIAkJLnZhcmlhbnQgPSBJTVg4TVEsDQo+ID4gKwkJLmdwciA9
ICJmc2wsaW14OG1xLWlvbXV4Yy1ncHIiLA0KPiA+ICAJfSwNCj4gPiAgCVtJTVg4TU1dID0gew0K
PiA+ICAJCS52YXJpYW50ID0gSU1YOE1NLA0KPiA+ICAJCS5mbGFncyA9IElNWDZfUENJRV9GTEFH
X1NVUFBPUlRTX1NVU1BFTkQsDQo+ID4gKwkJLmdwciA9ICJmc2wsaW14OG1tLWlvbXV4Yy1ncHIi
LA0KPiA+ICsJfSwNCj4gPiArCVtJTVg4TVBdID0gew0KPiA+ICsJCS52YXJpYW50ID0gSU1YOE1Q
LA0KPiA+ICsJCS5mbGFncyA9IElNWDZfUENJRV9GTEFHX1NVUFBPUlRTX1NVU1BFTkQsDQo+ID4g
KwkJLmdwciA9ICJmc2wsaW14OG1wLWlvbXV4Yy1ncHIiLA0KPiA+ICAJfSwNCj4gPiAgfTsNCj4g
Pg0KPiA+IEBAIC0xMzI5LDYgKzEzNTEsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2Rldmlj
ZV9pZA0KPiBpbXg2X3BjaWVfb2ZfbWF0Y2hbXSA9IHsNCj4gPiAgCXsgLmNvbXBhdGlibGUgPSAi
ZnNsLGlteDdkLXBjaWUiLCAgLmRhdGEgPSAmZHJ2ZGF0YVtJTVg3RF0sICB9LA0KPiA+ICAJeyAu
Y29tcGF0aWJsZSA9ICJmc2wsaW14OG1xLXBjaWUiLCAuZGF0YSA9ICZkcnZkYXRhW0lNWDhNUV0s
IH0sDQo+ID4gIAl7IC5jb21wYXRpYmxlID0gImZzbCxpbXg4bW0tcGNpZSIsIC5kYXRhID0gJmRy
dmRhdGFbSU1YOE1NXSwgfSwNCj4gPiArCXsgLmNvbXBhdGlibGUgPSAiZnNsLGlteDhtcC1wY2ll
IiwgLmRhdGEgPSAmZHJ2ZGF0YVtJTVg4TVBdLCB9LA0KPiA+ICAJe30sDQo+ID4gIH07DQo+ID4N
Cj4gDQoNCg==
