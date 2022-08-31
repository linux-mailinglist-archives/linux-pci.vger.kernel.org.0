Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E7A5A736C
	for <lists+linux-pci@lfdr.de>; Wed, 31 Aug 2022 03:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiHaBhI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Aug 2022 21:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiHaBhH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Aug 2022 21:37:07 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80085.outbound.protection.outlook.com [40.107.8.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F3F62D0;
        Tue, 30 Aug 2022 18:37:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TRSv866qK7y9xwMNAfVJnSaEfw2Au8jWkYcJmhp0qjawW5qAz+yC7FzAouMTLXkhyi01cvEHkxx7M2A3Ap6yXmROQHV9X7qpO+fLRafGsNf1Eorpkhe58wJNOnKNlLpK13CLZ4PfvbAfb9XZabWTvGGnorTZ27GXQkdNY3fhHEh3OKdBPqXpLsHpa5lenIi9MFgaVrqbM1FbJQorJhgyXPH7WRaaOpYMIs6vGOAvjFPhZEMPYLDGN7GSNRbBTBlJIGt8xrkfpWTAp0v2SXm4jbV45aQfeby6sD2kcVIXKhUrIn3ss7RWqA5jvGu7MtrAK5sD0t76FLENAGrcuxa60Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vxrXosPwD3AyPHbT6cgBoyGBTOi/U/wYlAeBok+OWi4=;
 b=f5iv6+gQjZIMiPf4+2doFj1MSpSW++oAbFajMpur0XvDChtC7JVnwgKydtQYo7hhvyLLEhRW5/NcfU/5gvSrIqUIatrj8Ud+6qRHLGrAcY28JvLNSbC2fdJOkYxbhyAI+qw59TKyOXhBtaHS+IjsUfPs7G6HKc8uv3FrGfCtmrUM787YhSwN3hM4qn7DvB8IFRt+/kMkqDe2hw3g2SWYZSg71+keSXe/6MkdzhtHNIOf7pNWhkTt4iEJBvKkPWXt2/dh6XeEcewQrN5AyR0O5wRRFCsUBJ59j4yPZp4j2pCaQ4jhfezsVb8JSBdD1BAMkTR8aFma0NSx55I6vq1JnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vxrXosPwD3AyPHbT6cgBoyGBTOi/U/wYlAeBok+OWi4=;
 b=SFB4Nv6N3WjEGRn6aclc4qU2moEc4TYiAhAoiqLM7RwqQR255hyDp80h0zQZRLBWVJwbyxSdaPu9MBKpDOYQkRhvQeahf/ZKIETJMJQXXiSZ1vxPVo3jYAwXZMYSuizredQb53imk+eevwjQHc9h4REwoJ8qP1vp9lMqQhHe1T4=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8085.eurprd04.prod.outlook.com (2603:10a6:20b:3f9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Wed, 31 Aug
 2022 01:37:02 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::13c:5622:af8a:b2da]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::13c:5622:af8a:b2da%9]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 01:37:02 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v1 0/2] Fix the wrong order of phy callbacks
Thread-Topic: [PATCH v1 0/2] Fix the wrong order of phy callbacks
Thread-Index: AQHYtisJvWRatmeqJkC37ps54LPbAa3FdjaAgAFfrrCAAD5dAIAABDdwgAB/GgCAAKZ+UA==
Date:   Wed, 31 Aug 2022 01:37:02 +0000
Message-ID: <AS8PR04MB867644D39C15DDEF5CE88E008C789@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <AS8PR04MB86763A2187AED57CFD55625E8C799@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <20220830150534.GA97821@bhelgaas>
In-Reply-To: <20220830150534.GA97821@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e2110cc0-0f61-45e8-32f5-08da8af14dcc
x-ms-traffictypediagnostic: AS8PR04MB8085:EE_
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PvNlp9ZK/TF4ku20qCMHBZ4UFVpq1/wXoXMnQBCTGml1R7gry8D3LqquhFUGqc0PCOa9kgRiMxoOCQ4bCKeeMqBk5BGRyfC4BREXTVsPamKIeV3qa30HMU36zww5bSF4E/6pe0Jg3r6/9qaCksIBRYU4ys64tS7TCIEYdq10IdzXJagu+FLtPTkBull9R3pOCVg7MrNuShZg2XuK7a5jcZYp2s+kwD1cAxzsJdYiBIHAwCiFVerDDbQlt4YvfCTzFYC+INickfVRYcxZjX+53WBhv9aklqYX3X8aA7PmyMHB7XWC8R9sk8eAGoZ+usc2UHXh10v3uEhpeY6uEfh4So401QOcOu9rdibFMroFqYsY0qPNTNi/qvULbTWtUIyawcfGV/MUpl4GFe49NrBgbQTs3dJ5/z3CclHrY8pYN17tI9cebEc9/vEMyhAJaMYzixPWV8FoAhmwFtnGIDbnHd07MKfAicMWIiE13nb8nS+gq3FOHHbAYqpZ1616UWvLp25thMg8Yu9Px7lFZ8fqiEWGdkyf+7aLVNmBypcHvPRGlyQdbJ/kQeHyRQtoDbN3Z2m4EP/yG5fhpQCcXaidDOrGvLMh61M2WBAnbfNsCgjDUCQDJ8l+VqRLUQuI+hmjLBiPDDr2/8sEOhHTj712YvjRg3od1kUxyGhOH1ZKsTP9S7gwk34rCcGetcLNLnfGV3bcAZn6Av4juP6+QdbN+VBcvvwk3O5ehnD/Wvtpi07vyXxfODSQXXM4d16MyOBVnDbgO0bzTkd9hZBpkEQbFHMsZjI5hMrwHOQddn/ttQo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(136003)(376002)(39860400002)(366004)(26005)(6916009)(38070700005)(66476007)(122000001)(38100700002)(9686003)(45080400002)(316002)(71200400001)(54906003)(6506007)(66446008)(33656002)(52536014)(41300700001)(8676002)(7696005)(4326008)(76116006)(966005)(8936002)(66946007)(2906002)(7416002)(53546011)(186003)(64756008)(86362001)(83380400001)(478600001)(55016003)(44832011)(66556008)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?TUt4OW9LcXlUVWN1VVMxcFZtYityNFBvY2Ryaitndmh6OTB2Y0NKdHNIOE00?=
 =?gb2312?B?NzVyZ0E0OE1CdDRhQVFQN2I2bE95Nk9hMDBQZEZlRmEwQU9wWWVNVWI4SFBV?=
 =?gb2312?B?RUhZbTl2TjJaU1ZmbTAxODdpcTl4SUxWU2ZUZDdaY3dueFVyRjl3ek54RmRx?=
 =?gb2312?B?aFg4RWZUaWhxenlNL3E1Y3dLMHowdVlHNmJqODg3cTdYZEhVY1pRUjF0bjAw?=
 =?gb2312?B?Wk1vWVJyZUlLeEdZRWUvSTNwRVBvd1lHVE1ORlUyM00rbEpsZDRXQjNDMGEy?=
 =?gb2312?B?MjFOMjY2a2dZdGVZQVdlRnp6eUw3Z0NNeEgvYmRGQWkxODUvWHpjM0lLZXpT?=
 =?gb2312?B?OThlVkdnbEhkYWdQTVZ5dW5vMWYvRHAvWi9iZ0VzOW4wRUFCNUg5RmhESlRz?=
 =?gb2312?B?RmVxdm5ldkkxZEVFNzFYTmYvYlovSDkvS00wdUJSaHZoY2t0VzBBSkhYdjNO?=
 =?gb2312?B?NnpFNnNFOTlTOW41L3RlblRnS05CVnRDeTNKQ055dzVDOEdjeHhmUHJ5ZWNt?=
 =?gb2312?B?azlXRnNEekZQeU9PRXpDcFRMSGxBMWM5U1Q1WG9xbkVVeWtGSzhEWWhwLzFG?=
 =?gb2312?B?U29zaGppZk9DOWlKRDVKblp4ZXNDUHlaZmFja05meVc1SWJqT0hNdmVSVHBS?=
 =?gb2312?B?bVNQL25QelM2bFpncEEwV0cvT3hERWNScm1UcGVmcm9iK2F3TDRiT01jNkw1?=
 =?gb2312?B?K1FWbGU0ZzlBK0I3dlRUdGlsUDhTczNEQkRnVnNScXdMZVM3MWZVL2pUNHgv?=
 =?gb2312?B?cDhxc081T2tISDhxYkZEMDY4MllndkZvUklKQ2lvMHB1WGkwS2hRZU9ialJu?=
 =?gb2312?B?S2gyY0JSR0ZpTUJidmpRQlNVSWdMWktXdEJ3cnV4VmsreCtVVHIwL0RGNnN1?=
 =?gb2312?B?bUl4Wnp1VVBoZDEya2luRzRkK2FDK3k1QnNHTFZ1THR1L1Vud3NHckFuSzh3?=
 =?gb2312?B?RjNlTllVZEI0cEZBanQreThLbkw1Yzc1dks1KzBwZitybzhlUUZTMFpOZkJq?=
 =?gb2312?B?TE9KRlNUVTdnSmFPT2h1WlNsTEFOek96QTBFOWp3QkxTRys1YUpVMFowN01l?=
 =?gb2312?B?ZDl1QUtXSUdpVVd6OWhvTWlPd3dyekhVeFNYb25jNjlIc3lUKzRQWWVSdDNP?=
 =?gb2312?B?MDNseE9vZll6eGZacU9xYTJkcERZMkdIUmZnWk1XWVhxWHRUc1NBeEhIcFc4?=
 =?gb2312?B?TU9admRiTC9lNndWNGI2dndIQkF4Y2ZKYk5IS3VCaUFaem00WTFWenVFSDdQ?=
 =?gb2312?B?Zm9XYzRDZHNhbHZaUWhYL0dTS0x4Q2phRWhuMVVrMUlTQ1JrdWozNkQ1Qjl4?=
 =?gb2312?B?NTZNalhLYmtrbXdGUVR1RFNaS2IvT0JkbjdmZStuR2Z1c3NjWkFPT2V0UWQv?=
 =?gb2312?B?NXUxL2V3dTlsQzlxcGhSNzI5VHVTWTRNbkl6Znh4MFR5c3hRLytiTHo0QzZq?=
 =?gb2312?B?dzIyUUJhZkVEWmZpcStYRkZDV1grWERoUTVJNWpCZWYvMmNkMlNYM08zbHJP?=
 =?gb2312?B?QkRMMFB3Yll1Vk1xejJ2L3UxbFU1QVRQYVV5bzNIaXBOTXpTb3N5ck5VcFRS?=
 =?gb2312?B?YnZnakNOdEM3eXdQaC9OL3VhSTFETTJ2clVjTlluaGZwTm8zR0FsVWI3NzZz?=
 =?gb2312?B?bUJiWGYrL0VpaDBySHdraStmcFg3TjJPYXBzc0krQ3VFNXZzWjZzdDBsZTJE?=
 =?gb2312?B?RmtIOVVLb25LZkRzOXhMUmZoUk9zeXBYRmszeTRVeklqeDUrRGQ1S3V6alRs?=
 =?gb2312?B?YTRLYWdzeDBpNkpzMEl6OElVQTZvRDU0YUFMOVJqSlJUdW8ydkdTRWZtTzZl?=
 =?gb2312?B?NnVBU0dLeU1ZcDByc3V3Y2htU3lFeTArVzBEMDlWdTJnaVJVR1ZCOVlGaDNx?=
 =?gb2312?B?aFhaZVZUdHpQMlY1Qms5SkUybFZONDVFQWdMeGJIU2VwVXNsdnZOMjBqaW5m?=
 =?gb2312?B?QnZ5Q0xZeERocWFCaGw1VkhkcmRhVkNvUzlHZ3RodmUwSEV0bzROUnJSM0Mx?=
 =?gb2312?B?STdzMm9ZWjhob3NkQ0Fmc2UxRkpFeExNanhIY2NWZmtUaTJOdVgwdUp2WHpY?=
 =?gb2312?B?TS9xWjRGa09CNHBEQzdBVzE5Y2NYblVyd3ZPZGREWklXK1MzY1pzb1hZWUpY?=
 =?gb2312?Q?B2RoZ9A38QMWT1mCcjDAWEnNj?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2110cc0-0f61-45e8-32f5-08da8af14dcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 01:37:02.2857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Zsr+o6q4jHn/NAZRJDcWqtBJG5qCLDaohniMG1mevf+8yjsd8p4PYDUMvr84jHHPv8+c7ZRfbR+Mpu6MF7xIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8085
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCam9ybiBIZWxnYWFzIDxoZWxn
YWFzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjLE6jjUwjMwyNUgMjM6MDYNCj4gVG86IEhvbmd4
aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+IENjOiBBaG1hZCBGYXRvdW0gPGEuZmF0
b3VtQHBlbmd1dHJvbml4LmRlPjsgbC5zdGFjaEBwZW5ndXRyb25peC5kZTsNCj4gYmhlbGdhYXNA
Z29vZ2xlLmNvbTsgbG9yZW56by5waWVyYWxpc2lAYXJtLmNvbTsgdmtvdWxAa2VybmVsLm9yZzsg
TWFyY2VsDQo+IFppc3dpbGVyIDxtYXJjZWwuemlzd2lsZXJAdG9yYWRleC5jb20+OyBraXNob25A
dGkuY29tOw0KPiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOyBkbC1saW51eC1pbXgNCj4gPGxpbnV4LWlteEBueHAuY29tPjsga2VybmVsQHBl
bmd1dHJvbml4LmRlOyBsaW51eC1waHlAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMC8y
XSBGaXggdGhlIHdyb25nIG9yZGVyIG9mIHBoeSBjYWxsYmFja3MNCj4gDQo+IE9uIFR1ZSwgQXVn
IDMwLCAyMDIyIGF0IDA3OjUwOjU1QU0gKzAwMDAsIEhvbmd4aW5nIFpodSB3cm90ZToNCj4gPiA+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBBaG1hZCBGYXRvdW0gPGEu
ZmF0b3VtQHBlbmd1dHJvbml4LmRlPg0KPiA+ID4gU2VudDogMjAyMsTqONTCMzDI1SAxNToxNg0K
PiA+ID4gVG86IEhvbmd4aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+OyBsLnN0YWNoQHBl
bmd1dHJvbml4LmRlOw0KPiA+ID4gYmhlbGdhYXNAZ29vZ2xlLmNvbTsgbG9yZW56by5waWVyYWxp
c2lAYXJtLmNvbTsgdmtvdWxAa2VybmVsLm9yZzsNCj4gPiA+IE1hcmNlbCBaaXN3aWxlciA8bWFy
Y2VsLnppc3dpbGVyQHRvcmFkZXguY29tPjsga2lzaG9uQHRpLmNvbQ0KPiA+ID4gQ2M6IGxpbnV4
LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4g
PiBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsga2VybmVsQHBlbmd1dHJvbml4LmRl
Ow0KPiA+ID4gbGludXgtcGh5QGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZw0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2MSAwLzJdIEZp
eCB0aGUgd3Jvbmcgb3JkZXIgb2YgcGh5IGNhbGxiYWNrcw0KPiANCj4gVGhlIGFib3ZlIHF1b3Rp
bmcgc3R5bGUgbWFrZXMgaXQgaGFyZGVyIHRoYW4gbmVjZXNzYXJ5IHRvIGZvbGxvdyBjb252ZXJz
YXRpb24uDQo+IFNlZSBoaW50cyBhdDoNCj4gDQo+IA0KPiBodHRwczovL2V1cjAxLnNhZmVsaW5r
cy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZlbi53aWtpDQo+IHBl
ZGlhLm9yZyUyRndpa2klMkZQb3N0aW5nX3N0eWxlJTIzSW50ZXJsZWF2ZWRfc3R5bGUmYW1wO2Rh
dGE9MDUlN0MwMQ0KPiAlN0Nob25neGluZy56aHUlNDBueHAuY29tJTdDNzBmMzgyMTRjOGY5NGM1
OTMyYjQwOGRhOGE5OTE5OTYlN0MNCj4gNjg2ZWExZDNiYzJiNGM2ZmE5MmNkOTljNWMzMDE2MzUl
N0MwJTdDMCU3QzYzNzk3NDY4NzQzMzU4OTIwOQ0KPiAlN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4
ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTEMNCj4gSkJUaUk2SWsxaGFXd2lM
Q0pYVkNJNk1uMCUzRCU3QzMwMDAlN0MlN0MlN0MmYW1wO3NkYXRhPWNlWm1EZA0KPiBzTmVDOW5V
NnFtdDJxWFIwM2ZRbjMzdlklMkZxdkJJWXplV1c3bWslM0QmYW1wO3Jlc2VydmVkPTANCj4gDQo+
IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRw
cyUzQSUyRiUyRnBlb3BsZS4NCj4ga2VybmVsLm9yZyUyRnRnbHglMkZub3Rlcy1hYm91dC1uZXRp
cXVldHRlJmFtcDtkYXRhPTA1JTdDMDElN0Nob25neGkNCj4gbmcuemh1JTQwbnhwLmNvbSU3Qzcw
ZjM4MjE0YzhmOTRjNTkzMmI0MDhkYThhOTkxOTk2JTdDNjg2ZWExZDNiDQo+IGMyYjRjNmZhOTJj
ZDk5YzVjMzAxNjM1JTdDMCU3QzAlN0M2Mzc5NzQ2ODc0MzM1ODkyMDklN0NVbmtubw0KPiB3biU3
Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2
SWsxaGENCj4gV3dpTENKWFZDSTZNbjAlM0QlN0MzMDAwJTdDJTdDJTdDJmFtcDtzZGF0YT1Qa2hw
R0dmN0ZjdnNRVGpjMA0KPiBoVU1wcjlRNEpWS2VGb0xSNGZvQTZ6dDZqZyUzRCZhbXA7cmVzZXJ2
ZWQ9MA0KPiANCj4gVGhlIGlkZWFsIHRoaW5nIHdvdWxkIGJlIHNvbWV0aGluZyBsaWtlIHRoaXMs
IHdoZXJlIHRoZXJlJ3MgYSBzaW5nbGUgbGluZSBmb3INCj4gZWFjaCBzZW5kZXI6DQo+IA0KPiBP
biBUdWUsIEF1ZyAzMCwgMjAyMiBhdCAwNzo1MDo1NUFNICswMDAwLCBIb25neGluZyBaaHUgd3Jv
dGU6DQo+ID4gT24gVHVlLCBBdWcgMzAsIDIwMjIsIGF0IDAzOjE2UE0sIEFobWFkIEZhdG91bSB3
cm90ZToNCj4gPiA+IE9uIDMwLjA4LjIyIDA1OjQ3LCBIb25neGluZyBaaHUgd3JvdGU6DQo+ID4g
PiA+IERvIHlvdSBtZWFuIHRvIHNxdWFzaCB0aGlzIGZpeCB0byB0aGUgcHJldmlldyBzZXJpZXM/
DQo+ID4gPiA+IEknbSBhZnJhaWQgdGhhdCBpdCdzIG5vdCBlYXN5IHRvIGRvIHRoYXQuDQo+ID4g
PiA+IEJlY2F1c2UgdGhlcmUgYXJlIGEgbG90IG9mIHBjaS1pbXg2IGNvZGUgY2hhbmdlcyBhZnRl
cg0KPiA+ID4gPiBjb21taXQ6IDFhYTk3YjAwMjI1OCAoInBoeTogZnJlZXNjYWxlOiBwY2llOiBJ
bml0aWFsaXplIHRoZSBpbXg4DQo+ID4gPiA+IHBjaWUgc3RhbmRhbG9uZSBwaHkgZHJpdmVyIiku
DQo+ID4gPg0KPiA+ID4gVGhlIHdheSBJIHVuZGVyc3RhbmQgaXQsIGlmIGEgYmlzZWN0IGVuZHMg
dXAgYmV0d2VlbiB5b3VyIHR3bw0KPiA+ID4gcGF0Y2hlcywgaS5NWDhNIFBDSWUgd2lsbCBiZSBi
cm9rZW4sIHdoZXJlYXMgaXQgd29ya2VkIGJlZm9yZS4gSQ0KPiA+ID4gdGh1cyB3b25kZXIgaWYg
d2Ugc2hvdWxkbid0IGluc3RlYWQgc3F1YXNoIHRoaXMgc2VyaWVzIGhlcmUgaW50byBhDQo+ID4g
PiBzaW5nbGUgcGF0Y2guDQo+ID4NCj4gPiBZZXMsIGl0J3MgYSBwb3NzaWJsZSBjYXNlIHdoZW4g
ZG8gdGhlIGJpc2VjdC4NCj4gPiBTaW5jZSB0aGVzZSBjaGFuZ2VzIGFyZSBiZWxvbmcgdG8gZGlm
ZmVyZW50IGdpdCByZXBvLg0KPiANCj4gSSBkb24ndCB1bmRlcnN0YW5kIHRoZSBwb2ludCBhYm91
dCBkaWZmZXJlbnQgZ2l0IHJlcG9zLiAgUGF0Y2ggMS8yIHRvdWNoZXMNCj4gZHJpdmVycy9wY2kv
Y29udHJvbGxlci9kd2MvcGNpLWlteDYuYywgcGF0Y2ggMi8yIHRvdWNoZXMNCj4gZHJpdmVycy9w
aHkvZnJlZXNjYWxlL3BoeS1mc2wtaW14OG0tcGNpZS5jLiAgVGhleSdyZSBpbiBkaWZmZXJlbnQg
ZGlyZWN0b3JpZXMsDQo+IG9mIGNvdXJzZSwgYnV0IGFyZSBpbiB0aGUgc2FtZSBMaW51eCBrZXJu
ZWwgc291cmNlIHJlcG8uDQo+IA0KPiBUaGV5J3JlIG1haW50YWluZWQgYnkgZGlmZmVyZW50IHBl
b3BsZSwgYnV0IHdlIGNhbiBlYXNpbHkgZGVhbCB3aXRoIHRoYXQgYnkNCj4gZ2V0dGluZyBhbiBh
Y2sgZnJvbSBvbmUgYW5kIG1lcmdpbmcgdmlhIHRoZSBvdGhlci4NCj4gDQo+ID4gSXQgd2lsbCBi
cmluZyBtYWludGFpbiBkaWZmaWN1bHRpZXMgaWYgdGhlc2UgdHdvIHBhdGNoZXMgYXJlIHNxdWFz
aGVkDQo+ID4gaW50byBhICBzaW5nbGUgb25lLg0KPiA+IEl0J3MgZGlmZmljdWx0IHRvIG1ha2Ug
YSBjaG9pY2UuDQo+IA0KPiBXaGF0IG1haW50ZW5hbmNlIGRpZmZpY3VsdHkgZG8geW91IHNlZSBo
ZXJlPyAgSSB0aGluayBpdCBsb29rcw0KPiAqZWFzaWVyKiBpZiB0aGVzZSBhcmUgc3F1YXNoZWQg
LS0gdGhhdCB3b3VsZCBhdm9pZCB0aGUgcG9zc2liaWxpdHkgb2YgYmFja3BvcnRpbmcNCj4gb25l
IHdpdGhvdXQgdGhlIG90aGVyLCB3aGljaCB3b3VsZCBjZXJ0YWlubHkgYmUgYSBwcm9ibGVtLg0K
PiANCj4gSWYgYSBiaXNlY3QgbGFuZHMgYWZ0ZXIgcGF0Y2ggMS8yIGJ1dCBiZWZvcmUgMi8yLCBp
dCBsb29rcyBsaWtlIGkuTVg4TSB3aWxsIGJyZWFrDQo+IHVubmVjZXNzYXJpbHkuDQo+IA0KPiBJ
IHRoaW5rIEFobWFkIGlzIHJpZ2h0IHRoYXQgcGF0Y2hlcyAxLzIgYW5kIDIvMiBzaG91bGQgYmUg
c3F1YXNoZWQgaW50byBhDQo+IHNpbmdsZSBwYXRjaCB0byBhdm9pZCB0aGlzIGJpc2VjdGlvbiBo
b2xlLg0KSGkgQmpvcm46DQpUaGFua3MgZm9yIHlvdXIgY29tbWVudHMuDQpNeSBkZXNjcmlwdGlv
bnMgYXJlIG5vdCBhY2N1cmF0ZSBlbm91Z2guIFRoZXNlIHR3byBmaWxlcyBhcmUgbWFpbnRhaW5l
ZCBieQ0KIGRpZmZlcmVudCBwZW9wbGUsIEknbSBhZnJhaWQgdG8gYnJpbmcgdHJvdWJsZXMgdG8g
dGhlIG1haW50YWluZXJzIGlmDQpJIHNxdWFzaCB0aGVzZSB0d28gcGF0Y2ggaW50byBhIHNpbmds
ZSBvbmUgYmVmb3JlLg0KTm93LCBJIHVuZGVyc3Rvb2QgdGhlIHNpdHVhdGlvbi4NCkknbSBnbGFk
IHRvIHNxdWFzaCB0aGVtIHRvIGF2b2lkIHRoZSBiaXNldGlvbiBob2xlLg0KVGhhbmtzIGFnYWlu
Lg0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQo+IA0KPiBCam9ybg0K
