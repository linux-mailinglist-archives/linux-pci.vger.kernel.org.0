Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1399D76A65F
	for <lists+linux-pci@lfdr.de>; Tue,  1 Aug 2023 03:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbjHABcA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jul 2023 21:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbjHABb7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jul 2023 21:31:59 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2117.outbound.protection.outlook.com [40.107.113.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20E01996;
        Mon, 31 Jul 2023 18:31:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SG/H5l7LACJ8BEa0AxB8bEquH0LlvVTbgzNQu95INhAYOpCxxmJNOzbqVelzoRJ++pVuvInKHKR2VdoYxWx0PWYWfyQsqMdoW1TJRKaX2X6x8SfztKot2fYA9Ds72vAAwRZuak52bsBwFrv0g540ePMeWe5jI6W6cCHh91BDtCNk0KrqyEmkqQJHEDhfLFlo+7LxHDEsNR06YrKYZSFfx8h4dH+FlWymZ0/w5sv16DjaRVPNeaZrb2Yv4IsDZByrdOxbncnRBBUUJ0fMtNOEvPPkZnoRKKDffFZBjsRA6Dd8HTsmCMUlze12RcO3AvltckyUcRbS9Ih3ebJXWbalaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GoLeJSIQNA7v36gHDFjQj0LrNwrVQuHtTdEeAn0GPaU=;
 b=DjZIX6imgL5VfefmMaK2dhn9XPKlo4qMQf20AnuCOkxTTr2R+q5++t69TOd1s1grff/JnSC2pEPmLYE5aEtYWcH/WPGBJeG2KllGaIYhfiFVy2Cd+IXurLWrCU7Bt0wiou21uILOGPX1dVBtQAhQr3YGW9YIyBwgnUL/AUYhT8eQYDJ4C68hKTH9M1izFr9EkVzNQ7uhCkip/eMSF3sgqSC8JXFD4yyFoO9gqronIXFBSrAdzyMhkeGEV7yUXc+TSGEoHmhq4W2aS8V3yTw5wAiexhjoo7nR2R6tgjqAg918KFys9Xa7JdDwP8fUqQZDgZfKMi1xl0gHl6PEIcFtmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GoLeJSIQNA7v36gHDFjQj0LrNwrVQuHtTdEeAn0GPaU=;
 b=VKoksP7aBCb4G4pEUbOFSt2CV3mYHMcLVYaIDcZC9Zm0+vdcS0H6suAi6bDTSUCni9D3nsd/Soojgeb4tCv9dEHXdzRBThW10lYAN7n/uZLZ2ADdjQ60C5Oyi9toiVMSVo7HwMss2BbHOXNZnGsOu+tZy4f1gjVhC2AQfNv6G6w=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYCPR01MB10650.jpnprd01.prod.outlook.com
 (2603:1096:400:292::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Tue, 1 Aug
 2023 01:31:46 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::e5cd:66a0:248f:1d30]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::e5cd:66a0:248f:1d30%4]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 01:31:46 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Serge Semin <fancer.lancer@gmail.com>
CC:     Manivannan Sadhasivam <mani@kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v18 05/20] PCI: dwc: Add outbound MSG TLPs support
Thread-Topic: [PATCH v18 05/20] PCI: dwc: Add outbound MSG TLPs support
Thread-Index: AQHZu6dC88y+jhK0xEGeyF85x0cdRa/IlfcAgAduIgCAAx3zsIABXqIAgAA3apA=
Date:   Tue, 1 Aug 2023 01:31:46 +0000
Message-ID: <TYBPR01MB5341792705C603E70AAB1CA4D80AA@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230721074452.65545-1-yoshihiro.shimoda.uh@renesas.com>
 <20230721074452.65545-6-yoshihiro.shimoda.uh@renesas.com>
 <20230724081250.GD6291@thinkpad>
 <qckzwhgcx7eux7qi6a27hww7wbva6r4nylxo437gnohpsxuja3@6dj2ld7qlvix>
 <OSYPR01MB5334600364096E6FDE573394D805A@OSYPR01MB5334.jpnprd01.prod.outlook.com>
 <b6jzau7mwbnomy2whhwfbtww6p5hiikiay5jvcz5em422q2ycb@pe3au6vvcygc>
In-Reply-To: <b6jzau7mwbnomy2whhwfbtww6p5hiikiay5jvcz5em422q2ycb@pe3au6vvcygc>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYCPR01MB10650:EE_
x-ms-office365-filtering-correlation-id: a33bc754-374d-41da-352c-08db922f11c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vb66ZHDT8iBCglky0q+BgmNT3F3wcxV7qCb3shSuguA3GNb0JDniuiq8Fz2tqPoJms4Q8FuEl2INs6fi85zO3dwI7txdPQ6qndbci+HKWpKYY5Sz8dGiHWMbf6iWxvyZBv3qX6WRoPT0HV3loKYuwJdNbzbIDlbRi5/2M6IaN+i7lg5p6AXpWsYQAcBGYBOezkFkT/3Fz+SfhsWzddK5AjRoXPkbGXfFtyTpr7af61hdeLPuzhK3DIz3u8Ep8zEjXmP4u5sFhQxnuMQHGXlNmp1j3ex4aqUoKVfF+p/WvyM5EoJMyeXku1Z4OmnjtmeqMa7tZx7Ln6D7uhkt+/4hltYtGg8P85JEeN1ypMjPLsCjsEeJ+chlHHzDV7k5SpJ67rMWslyl9f9C/GFCXB6NLHLCQZh36iK7lohkmIppIb2f7fra/uNkfzsPUQ/EbbjfMiJxySE3uorPQIPgekKGCffTvFcUqHwH19zRXbcXeA6YRXVKDcy6wXQCcBnjoFucy9yvdrcPxtWWiZHJZX6iDtWoIR7/4kSJE2jpG+s1iER1gN18McX50Ng5lLMlydd5P436TPKX6mTYtLB70T27U0ZHd1n6gsdZkHSsoGry13hzvIlGKZ6iOu8lneRTL3uR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(366004)(39860400002)(346002)(451199021)(9686003)(71200400001)(7696005)(33656002)(83380400001)(86362001)(38070700005)(186003)(122000001)(38100700002)(6506007)(55016003)(52536014)(5660300002)(64756008)(4326008)(41300700001)(8936002)(8676002)(76116006)(6916009)(66946007)(66476007)(2906002)(7416002)(316002)(66899021)(66446008)(478600001)(54906003)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFZnZlZZdjJPNDlnVDN2V3lOejVTVGptWVZKM0xpWkZVcWkxSlo0ODNVTzdt?=
 =?utf-8?B?Rm9VVlFkTjczSUJZMW1jYmsvbS9MUDdKc2lVd2s3MFE5dG5CZ2hHUFdac25K?=
 =?utf-8?B?WG9CN3dqYWNHS0ROS3EyakFOTUk0VWxFODJNeVFKKy9WVG9FVmxmWW9zWHVL?=
 =?utf-8?B?VHlKc0pldTd5TUVoTUpoR0VIV3lmRkZ2QVdVNURmR2I3NU92MG4xV2Y0V2JP?=
 =?utf-8?B?RTVMaCsvMDR1NytoRlF4N1Z1TFdRKzFkOUhzNFhGNXF5Skk3OGdlWldDQWtZ?=
 =?utf-8?B?Y2pBRjNEWkF6T25iMmdqVHVLdVN5RHp3KzdPdVZkMjNXaEpkenF0MjBrTzY1?=
 =?utf-8?B?aVE3SGVaS280YXA3SlF6WjN0TTVrdmYxK3NLM3ltYlBQRWJlWm1DczNSMHhG?=
 =?utf-8?B?MzlCQS95Skt1V0Y0czIzL20ybC9RVllYVFpadm1yaTE0RnRONDBaanJRckxa?=
 =?utf-8?B?OHp3WVJyVmJDcC82S1RGMVFmZ2RBTGtVVjBmOVNRQTlFRmJSNGU4VjBQa0sy?=
 =?utf-8?B?S3VCVWw4VVI5YWl2MnVXYVZ1RkpNTjdEd1N4RjNKanpvQVhMVDZOcWlrMVo4?=
 =?utf-8?B?L01MZ0JIdGNZK1E4ejJFempBZjRaaG50NVBUamZvVHVxbHQzeUJlL09NSHIz?=
 =?utf-8?B?MkxJWFBtSjY0YmFPQXFSN2xpZC9xeDJQYVBQdHVzeHkyYVN2TlM4MkIrcllR?=
 =?utf-8?B?OGMxNmNzVzR6REg4cEhQMkZzR3AyRDVvNUgvUExqODBha0RZQW80eEwwbndY?=
 =?utf-8?B?WnBNN01ZdnpQcklZblZDaGRwM2RBdDlEZ0tZZmpZR1MrclJXZHFlR2FZOWIy?=
 =?utf-8?B?czdEWGJNZnM1VkFNd1VEcUh3SldCY3Q4NW9oVjR0UlordkJtS2JxbHRNdnFJ?=
 =?utf-8?B?QnpXSkdjckwvVEpOSkZqL2FLdEwrVG5IK3lxTWRZMUsyS3IveGdjU000VVpE?=
 =?utf-8?B?UkRncWFUL1ZCZXY5VkZpa2UwVTlRcHkzZ29ENTRDVVJrcFVwd1AxUHdLM2ov?=
 =?utf-8?B?N0RNTXRGTjkreFFydTRVUDRPWVYxNGdhTEg3YU9tZDdIRmZwNm5aRWUzSXVT?=
 =?utf-8?B?bGpYSDFhelp2ZjJXbzU3Y3ZrNzlzWk44RnpXT0lYck9QOHhBVGVSbnJZeHp5?=
 =?utf-8?B?V1ZWcndkUTA1N25lUzV1U1hlamduVFROdkc2a0lwbW1DRmgxYVU5R002V0Qv?=
 =?utf-8?B?dXgzbXl2c0NPYTlGLzdjdmlMc1VKL09QTEYwUklOcmg3aUo0eWZSU200bi9H?=
 =?utf-8?B?V2VoNVlpbzhPQVRzWFJPb29FNnZ4ekxNc3dSL2pVTlVZNU5xencyTm5FY2Ux?=
 =?utf-8?B?clJnVEtPSVJCemxJdE9KOGE3K3VQTm9FNVpvUTMrdGwyd21Rb3NaOS9NWEs4?=
 =?utf-8?B?cVJpVTZPRnh1cWpyekt0cVYrcTFBb1FUQUhjR3BkUitsVzhSZlUxMUE0VFRK?=
 =?utf-8?B?blk4R0hLRVNJVXh0YzI2aWpRa0tJMDFVdzlZRFVIdGF2RjEvZmt1dTJrUUk1?=
 =?utf-8?B?TFVEOEp3RDIycmM4VHZxdkM2dm9Vc0wybElHUTB3b3hhbldTbVIxckwvRjNr?=
 =?utf-8?B?Z2YrVWVaWDZwb0xvREc0TWQram1MWlhmcnBaNEh1MENIZ3lPVGtOdjBJRzkv?=
 =?utf-8?B?RktEUzVES1ZTS3hSbSs3Z2RMVlJzSmUvZVNqRDF2TUQrNnFTOXA1QUNvYzN3?=
 =?utf-8?B?SlpkUDJBUCtEMm1wSjkzdmF3dXBFR0NBNExtZTQrakJPOUI1NXgxQm1OSW1l?=
 =?utf-8?B?aDhRSzhPaVY3TjZkM0lGL3cvWTJTZExwS2hOclRJdWVsWklraGZOc1pqaHhW?=
 =?utf-8?B?OXJXNmVjR0ZWZVpoYkNiSzhia0hxOHFHSzYxWjlrTW05cTFGMFlqRy9OM08x?=
 =?utf-8?B?NkxET1g5T0pyM3daUFF3V1FTWHhZbkFoTWd2dytuVzFlSUhCY3JIdjc1ZFVM?=
 =?utf-8?B?VkRlcmZ5N1ViZ2VsVERZaHdibGhEN095cTVxVk9sb0tzWGhPS2FuWHJtdE94?=
 =?utf-8?B?MExkeGJPZHlYakFrSEFwZHowb2NWMEFUZVRCUWhlSzk0MWkwWDJPeDJFZHFy?=
 =?utf-8?B?YnUwSHVvNU9iZ285Q0xTVzhQQ21sMTRSWlBWbXVQaDltb2tOaFBvTXdQVkhp?=
 =?utf-8?B?anlvMERSVFliTVFUeFlNc1o5YjA2aVVxaDRISHZnVGxaKzhibURqYzRMckk1?=
 =?utf-8?B?V3dmeWZUblRZTkM4K05panBkS3l3a05qeW40ZnN1dzB6MFZINDFGejdUODRB?=
 =?utf-8?B?a0d5QUhjZGdhNnJLcW42ZVpQWU93PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a33bc754-374d-41da-352c-08db922f11c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 01:31:46.1726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: um8cfc2Xb58+8Fb2Ln+J5ntvBldXJiQov8bDPIUHeUaDCe/sXvD491Fqlis9Leu1msFLQdQbtdG9IP9w3Zihya7jwljn7J2Rsl4dHm8ELIYLHMWn3avJsFclzEAKa3CX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10650
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgU2VyZ2UsDQoNCj4gRnJvbTogU2VyZ2UgU2VtaW4sIFNlbnQ6IFR1ZXNkYXksIEF1Z3VzdCAx
LCAyMDIzIDc6MTIgQU0NCj4gDQo+IE9uIE1vbiwgSnVsIDMxLCAyMDIzIGF0IDAxOjE4OjMwQU0g
KzAwMDAsIFlvc2hpaGlybyBTaGltb2RhIHdyb3RlOg0KPiA+IEhpIFNlcmdlLA0KPiA+DQo+ID4g
PiBGcm9tOiBTZXJnZSBTZW1pbiwgU2VudDogU2F0dXJkYXksIEp1bHkgMjksIDIwMjMgMTA6NDEg
QU0NCj4gPiA+DQo+ID4gPiBPbiBNb24sIEp1bCAyNCwgMjAyMyBhdCAwMTo0Mjo1MFBNICswNTMw
LCBNYW5pdmFubmFuIFNhZGhhc2l2YW0gd3JvdGU6DQo+ID4gPiA+IE9uIEZyaSwgSnVsIDIxLCAy
MDIzIGF0IDA0OjQ0OjM3UE0gKzA5MDAsIFlvc2hpaGlybyBTaGltb2RhIHdyb3RlOg0KPiA+ID4g
PiA+IEFkZCAiY29kZSIgYW5kICJyb3V0aW5nIiBpbnRvIHN0cnVjdCBkd19wY2llX29iX2F0dV9j
ZmcgZm9yIHNlbmRpbmcNCj4gPiA+ID4gPiBNU0cgYnkgaUFUVSBpbiB0aGUgUENJZSBlbmRwb2lu
dCBtb2RlIGluIG5lYXIgdGhlIGZ1dHVyZS4NCj4gPiA+ID4NCj4gPiA+ID4gSXQncyBiZXR0ZXIg
dG8gc3BlY2lmeSB0aGUgZXhhY3QgcmVxdWlyZW1lbnQgaGVyZSAidHJpZ2dlcmluZyBJTlR4IElS
UXMiDQo+ID4gPiA+IGluc3RlYWQgb2YgaW1wbHlpbmcuDQo+ID4gPiA+DQo+ID4gPiA+ID4gUENJ
RV9BVFVfSU5ISUJJVF9QQVlMT0FEIGlzIHNldCB0byBpc3N1ZSBUTFAgdHlwZSBvZiBNc2cgaW5z
dGVhZCBvZg0KPiA+ID4gPiA+IE1zZ0QuIFNvLCB0aGlzIGltcGxlbWVudGF0aW9uIHN1cHBvcnRz
IHRoZSBkYXRhLWxlc3MgbWVzc2FnZXMgb25seQ0KPiA+ID4gPiA+IGZvciBub3cuDQo+ID4gPiA+
ID4NCj4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBZb3NoaWhpcm8gU2hpbW9kYSA8eW9zaGloaXJv
LnNoaW1vZGEudWhAcmVuZXNhcy5jb20+DQo+ID4gPiA+DQo+ID4gPg0KPiA+ID4gPiBTYW1lIGNv
bW1lbnQgZm9yIHBhdGNoIDQvMjAgYXBwbGllcyBoZXJlIGFsc28uIFdpdGggdGhhdCBmaXhlZCwN
Cj4gPiA+DQo+ID4gPiBZb3NoaWhpcm8sIGFzIHdlIGdyZWVkIHdpdGggTWFuaSBpbiB0aGUgUEFU
Q0ggNC8yMCBkaXNjdXNzaW9uIHBsZWFzZQ0KPiA+ID4gaWdub3JlIHRoaXMgcmVxdWVzdC4NCj4g
Pg0KPiANCj4gPiBCeSB0aGUgd2F5LCBkbyB5b3UgaGF2ZSBhbnkgY29tbWVudCBhYm91dCBteSBz
dWdnZXN0aW9uPyBbMV0NCj4gPg0KPiA+IFsxXQ0KPiA+DQo8c25pcCBVUkw+DQo+ID4NCj4gPiBJ
ZiB5b3UgZG9uJ3QgYWdyZWUgbXkgc3VnZ2VzdGlvbiwgSSdsbCBpZ25vcmUgdGhpcyByZXF1ZXN0
Lg0KPiANCj4gWW91ciBzdWdnZXN0ZWQgaXMgbm90IGdvb2QgZm9yIHNldmVyYWwgcmVhc29uczoN
Cj4gDQo+IDEuIFlvdSBzdWdnZXN0IHRvIGFkZCB0aGUgZnVuY3Rpb24gY2FsbGVyIGNvbnRleHQt
d2lzZSBjb21tZW50cyB0byB0aGUNCj4gc3RydWN0dXJlLiBJdCB3aWxsIGNhdXNlIHRoZSBtYWlu
dGFpbmVycyB0byBrZWVwIHRoZSBjb21tZW50cyBhbmQgdGhlDQo+IGNhbGxlcnMgc2VtYW50aWNz
IGluIHN5bmMgd2hpY2ggaXMgYWxtb3N0IGFsd2F5cyBnZXRzIHRvIGJlIGRpdmVyZ2VkDQo+IGF0
IHNvbWUgcG9pbnQuDQo+IA0KPiAyLiBkd19wY2llX3Byb2dfb3V0Ym91bmRfYXR1KCkgZG9lc24n
dCBrbm93IHdoZXRoZXIgaXQgaXMgY2FsbGVkIGZvcg0KPiBhbiBFbmQtcG9pbnQgb3IgYSBSb290
IFBvcnQgY29udHJvbGxlci4gSXQganVzdCBtYXBzIHRoZSBDUFUtPlBDSWUNCj4gc3BhY2VzIGJ5
IG1lYW5zIG9mIHRoZSBvdXRib3VuZCBpQVRVIGVuZ2luZSB3aXRoIHRoZSBzcGVjaWZpZWQgbWFw
cGluZw0KPiBwYXJhbWV0ZXJzLiBUaGlzIG1ha2VzIHRoZSBjb21tZW50cyB5b3Ugc3VnZ2VzdCBt
aXNsZWFkaW5nLiBNb3Jlb3Zlcg0KPiBkZXBlbmRpbmcgb24gdGhlIGFwcGxpY2F0aW9uIHRoZSBs
b3ctbGV2ZWwgZHJpdmVycyBvciBldmVuIHRoZSBEVyBQQ0llDQo+IGNvcmUgZHJpdmVyIG1heSBk
ZWNpZGVkIHRvIG1hcCB0aGVtIGluIGFueSB3YXkuIEluIHRoYXQgY2FzZSB0aGUNCj4gcmVzcGVj
dGl2ZSBjaGFuZ2Ugd2lsbCBuZWVkIHRvIHVwZGF0ZSB0aGUgY29tbWVudHMgdG9vLCBvdGhlcndp
c2UNCj4gdGhleSdsbCBnZXQgdG8gYmUgd3Jvbmcgd2hpY2ggZ2V0cyB1cyB0byB0aGUgcmVhc29u
IDEuDQo+IA0KPiAzLiBUaGUgY3VycmVudCBhcmd1bWVudHMvZmllbGRzIG9yZGVyIG1vcmUtb3It
bGVzcyBwcmVzZXJ2ZXMgdGhlDQo+IG5hdHVyYWwgc2V0dGluZ3Mgc2V0dXA6IGZpcnN0IHlvdSBz
cGVjaWZpZXMgdGhlIGVudGl0eSBpbmRleCwgdGhlbiB5b3UNCj4gc3BlY2lmeSB0aGUgbWFwcGlu
ZyBzZXR0aW5ncywgdGhlbiB5b3Ugc3BlY2lmaWVkIHRoZSBtYXBwaW5nIGl0c2VsZg0KPiAoYWRk
cmVzc2VzIGFuZCBzaXplKS4gSWRlYWxseSB0aGUgImZ1bmNfbm8iIGZpZWxkIHNob3VsZCBiZSBt
b3ZlZCB0bw0KPiB0aGUgaGVhZCBvZiB0aGUgc3RydWN0dXJlIHNpbmNlIGl0IGFsc28gcmVwcmVz
ZW50cyB0aGUgbWFwcGluZyBlbnRpdHkNCj4gaW5kZXggYnV0IGl0IHdpbGwgY2F1c2UgaGF2aW5n
IHRoZSBwYWRzIChzbyBjYWxsZWQgImhvbGVzIikgaWYgd2UNCj4gZGlkbid0IGNoYW5nZSBpdCB0
eXBlLiBBbnl3YXkgaW52ZXJ0aW5nIHRoZSBvcmRlciBzbyB0aGUgbWFwcGluZw0KPiBpdHNlbGYg
Z29lcyBmaXJzdCB3aWxsIGJyZWFrIHRoYXQsIHRoZSBzdHJ1Y3R1cmUgd2lsbCBsb29rIGFzIGlm
LCBmb3INCj4gaW5zdGFuY2UsIHRoZSBkZXZpY2UtbWFuYWdlZCBmdW5jdGlvbiB0YWtpbmcgdGhl
IGRldmljZSBwb2ludGVyDQo+IHNvbWV3aGVyZSBpbiB0aGUgbWlkZGxlIG9yIGF0IHRoZSB0YWls
IG9mIHRoZSBhcmd1bWVudHMgbGlzdHMuIFRoZQ0KPiBtb3N0IGltcG9ydGFudCBzZXR0aW5ncyB3
aGljaCBhcmUgbm9ybWFsbHkgaW5pdGlhbGl6ZWQgZmlyc3Qgd2lsbCBiZQ0KPiBkZWZpbmVkIGF0
IHNvbWUgcmFuZG9tIHBsYWNlIGluIHRoZSBzdHJ1Y3R1cmUuDQo+IA0KPiBTbyB0byBzcGVhaywg
aXQncyBiZXR0ZXIgdG8ga2VlcCB0aGUgc3RydWN0dXJlIGZpZWxkcyBhcyBpcyBmb3INCj4gbm93
Lg0KDQpUaGFuayB5b3UgZm9yIHlvdXIgcmVwbHkuIEkgdW5kZXJzdG9vZCB0aGF0IG15IHN1Z2dl
c3Rpb24gaXMgbm90IGdvb2QuDQpJJ2xsIGtlZXAgdGhlIG9yZGVyIGFzLWlzIG9uIHYxOS4NCg0K
QmVzdCByZWdhcmRzLA0KWW9zaGloaXJvIFNoaW1vZGEgDQoNCj4gLVNlcmdlKHkpDQo+IA0KPiA+
DQo+ID4gQmVzdCByZWdhcmRzLA0KPiA+IFlvc2hpaGlybyBTaGltb2RhDQo+ID4NCj4gPiA+IC1T
ZXJnZSh5KQ0KPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gUmV2aWV3ZWQtYnk6IE1hbml2YW5uYW4g
U2FkaGFzaXZhbSA8bWFuaXZhbm5hbi5zYWRoYXNpdmFtQGxpbmFyby5vcmc+DQo+ID4gPiA+DQo+
ID4gPiA+IC0gTWFuaQ0KPiA+ID4gPg0KPiA+ID4gPiA+IFJldmlld2VkLWJ5OiBTZXJnZSBTZW1p
biA8ZmFuY2VyLmxhbmNlckBnbWFpbC5jb20+DQo+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gIGRy
aXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5jIHwgOSArKysrKysrLS0N
Cj4gPiA+ID4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmgg
fCA0ICsrKysNCj4gPiA+ID4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAy
IGRlbGV0aW9ucygtKQ0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5jIGIvZHJpdmVycy9wY2kvY29udHJv
bGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmMNCj4gPiA+ID4gPiBpbmRleCA0OWI3ODU1MDk1NzYu
LjJkMGY4MTZmYTBhYiAxMDA2NDQNCj4gPiA+ID4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9s
bGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuYw0KPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5jDQo+ID4gPiA+ID4gQEAgLTQ5OCw3ICs0OTgs
NyBAQCBpbnQgZHdfcGNpZV9wcm9nX291dGJvdW5kX2F0dShzdHJ1Y3QgZHdfcGNpZSAqcGNpLA0K
PiA+ID4gPiA+ICAJZHdfcGNpZV93cml0ZWxfYXR1X29iKHBjaSwgYXR1LT5pbmRleCwgUENJRV9B
VFVfVVBQRVJfVEFSR0VULA0KPiA+ID4gPiA+ICAJCQkgICAgICB1cHBlcl8zMl9iaXRzKGF0dS0+
cGNpX2FkZHIpKTsNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IC0JdmFsID0gYXR1LT50eXBlIHwgUENJ
RV9BVFVfRlVOQ19OVU0oYXR1LT5mdW5jX25vKTsNCj4gPiA+ID4gPiArCXZhbCA9IGF0dS0+dHlw
ZSB8IGF0dS0+cm91dGluZyB8IFBDSUVfQVRVX0ZVTkNfTlVNKGF0dS0+ZnVuY19ubyk7DQo+ID4g
PiA+ID4gIAlpZiAodXBwZXJfMzJfYml0cyhsaW1pdF9hZGRyKSA+IHVwcGVyXzMyX2JpdHMoY3B1
X2FkZHIpICYmDQo+ID4gPiA+ID4gIAkgICAgZHdfcGNpZV92ZXJfaXNfZ2UocGNpLCA0NjBBKSkN
Cj4gPiA+ID4gPiAgCQl2YWwgfD0gUENJRV9BVFVfSU5DUkVBU0VfUkVHSU9OX1NJWkU7DQo+ID4g
PiA+ID4gQEAgLTUwNiw3ICs1MDYsMTIgQEAgaW50IGR3X3BjaWVfcHJvZ19vdXRib3VuZF9hdHUo
c3RydWN0IGR3X3BjaWUgKnBjaSwNCj4gPiA+ID4gPiAgCQl2YWwgPSBkd19wY2llX2VuYWJsZV9l
Y3JjKHZhbCk7DQo+ID4gPiA+ID4gIAlkd19wY2llX3dyaXRlbF9hdHVfb2IocGNpLCBhdHUtPmlu
ZGV4LCBQQ0lFX0FUVV9SRUdJT05fQ1RSTDEsIHZhbCk7DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiAt
CWR3X3BjaWVfd3JpdGVsX2F0dV9vYihwY2ksIGF0dS0+aW5kZXgsIFBDSUVfQVRVX1JFR0lPTl9D
VFJMMiwgUENJRV9BVFVfRU5BQkxFKTsNCj4gPiA+ID4gPiArCXZhbCA9IFBDSUVfQVRVX0VOQUJM
RTsNCj4gPiA+ID4gPiArCWlmIChhdHUtPnR5cGUgPT0gUENJRV9BVFVfVFlQRV9NU0cpIHsNCj4g
PiA+ID4gPiArCQkvKiBUaGUgZGF0YS1sZXNzIG1lc3NhZ2VzIG9ubHkgZm9yIG5vdyAqLw0KPiA+
ID4gPiA+ICsJCXZhbCB8PSBQQ0lFX0FUVV9JTkhJQklUX1BBWUxPQUQgfCBhdHUtPmNvZGU7DQo+
ID4gPiA+ID4gKwl9DQo+ID4gPiA+ID4gKwlkd19wY2llX3dyaXRlbF9hdHVfb2IocGNpLCBhdHUt
PmluZGV4LCBQQ0lFX0FUVV9SRUdJT05fQ1RSTDIsIHZhbCk7DQo+ID4gPiA+ID4NCj4gPiA+ID4g
PiAgCS8qDQo+ID4gPiA+ID4gIAkgKiBNYWtlIHN1cmUgQVRVIGVuYWJsZSB0YWtlcyBlZmZlY3Qg
YmVmb3JlIGFueSBzdWJzZXF1ZW50IGNvbmZpZw0KPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuaCBiL2RyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5oDQo+ID4gPiA+ID4gaW5kZXggODVkZTBkODM0
NmZhLi5jNjI2ZDIxMjQzYjAgMTAwNjQ0DQo+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29u
dHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmgNCj4gPiA+ID4gPiArKysgYi9kcml2ZXJzL3Bj
aS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuaA0KPiA+ID4gPiA+IEBAIC0xNDcsMTEg
KzE0NywxMyBAQA0KPiA+ID4gPiA+ICAjZGVmaW5lIFBDSUVfQVRVX1RZUEVfSU8JCTB4Mg0KPiA+
ID4gPiA+ICAjZGVmaW5lIFBDSUVfQVRVX1RZUEVfQ0ZHMAkJMHg0DQo+ID4gPiA+ID4gICNkZWZp
bmUgUENJRV9BVFVfVFlQRV9DRkcxCQkweDUNCj4gPiA+ID4gPiArI2RlZmluZSBQQ0lFX0FUVV9U
WVBFX01TRwkJMHgxMA0KPiA+ID4gPiA+ICAjZGVmaW5lIFBDSUVfQVRVX1RECQkJQklUKDgpDQo+
ID4gPiA+ID4gICNkZWZpbmUgUENJRV9BVFVfRlVOQ19OVU0ocGYpICAgICAgICAgICAoKHBmKSA8
PCAyMCkNCj4gPiA+ID4gPiAgI2RlZmluZSBQQ0lFX0FUVV9SRUdJT05fQ1RSTDIJCTB4MDA0DQo+
ID4gPiA+ID4gICNkZWZpbmUgUENJRV9BVFVfRU5BQkxFCQkJQklUKDMxKQ0KPiA+ID4gPiA+ICAj
ZGVmaW5lIFBDSUVfQVRVX0JBUl9NT0RFX0VOQUJMRQlCSVQoMzApDQo+ID4gPiA+ID4gKyNkZWZp
bmUgUENJRV9BVFVfSU5ISUJJVF9QQVlMT0FECUJJVCgyMikNCj4gPiA+ID4gPiAgI2RlZmluZSBQ
Q0lFX0FUVV9GVU5DX05VTV9NQVRDSF9FTiAgICAgIEJJVCgxOSkNCj4gPiA+ID4gPiAgI2RlZmlu
ZSBQQ0lFX0FUVV9MT1dFUl9CQVNFCQkweDAwOA0KPiA+ID4gPiA+ICAjZGVmaW5lIFBDSUVfQVRV
X1VQUEVSX0JBU0UJCTB4MDBDDQo+ID4gPiA+ID4gQEAgLTI5Miw2ICsyOTQsOCBAQCBzdHJ1Y3Qg
ZHdfcGNpZV9vYl9hdHVfY2ZnIHsNCj4gPiA+ID4gPiAgCWludCBpbmRleDsNCj4gPiA+ID4gPiAg
CWludCB0eXBlOw0KPiA+ID4gPiA+ICAJdTggZnVuY19ubzsNCj4gPiA+ID4gPiArCXU4IGNvZGU7
DQo+ID4gPiA+ID4gKwl1OCByb3V0aW5nOw0KPiA+ID4gPiA+ICAJdTY0IGNwdV9hZGRyOw0KPiA+
ID4gPiA+ICAJdTY0IHBjaV9hZGRyOw0KPiA+ID4gPiA+ICAJdTY0IHNpemU7DQo+ID4gPiA+ID4g
LS0NCj4gPiA+ID4gPiAyLjI1LjENCj4gPiA+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiAtLQ0KPiA+
ID4gPiDgrq7grqPgrr/grrXgrqPgr43grqPgrqngr40g4K6a4K6k4K6+4K6a4K6/4K614K6u4K+N
DQo=
