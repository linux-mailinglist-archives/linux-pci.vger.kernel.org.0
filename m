Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEBB5443B5
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jun 2022 08:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237726AbiFIGTa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jun 2022 02:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiFIGTY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jun 2022 02:19:24 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2067.outbound.protection.outlook.com [40.107.21.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0174423B15C;
        Wed,  8 Jun 2022 23:19:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+w0D7tn4G5sfG5aaSaxu3RJsnh1q2ZRCcl44gv7p2Y99LSvXGwGueFpYI5eCfNaJNTgEteuzUkSOjb5ExAYg4fyJW2HwX3r4rJ+EtWDgKS2Jf49B082xqkx0LnoRkvnm6hobOJeWEO85Y0zu6/A/Oermyy1d9l7FuioOUNMh+YRMhP+5TF3nJ/MTl/5MDA4Xlcz/oYOBxuh4a/nrjbyyzxCCIqf3FSq3UDYQT1hZ9uAg8TyjoNEi5BBcSTCaFL8o8IJFx3t21E1PKmS5jQDb34BO7e0/wGo3mHBD/IDRtnn098I9kX3evGn/k5qYBcLbB0ijedBVcCyJhUUITzc/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZBYWszmapn9zECmLxflQQAZFVLpcVXNpUXnH3gdWIyg=;
 b=JF67A2e9C9/rWtjQspb9iO7IxFM6rPX1lSR+qbY2NpNUWdM4znGZh1vaDTNjPlM6evdG5tjhMxc4xxKxSIUAG8O16swRjnMafBgabmqTZM9B3vclDXIzEzjostbGcQhUV80NSpvCwDmC0tkG8la35RmPnBuRUejh8Lpjdm3ncGNFBmvQnFHcwdYTAmLTOAmPYijKTdOjGvHbZY0IPPHISn8H9Ym7H7oj/g+oU5IbJs+A06l1e7GS0pHYRsAB7Lug75LW4gIkr7DEtJuclOTZLbwoLkp3s8RvdaCY5I3E7uOtEQYP8ulI4m63dTkBHNVKnPZ8d3Gc55ps3yaPmEbPhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBYWszmapn9zECmLxflQQAZFVLpcVXNpUXnH3gdWIyg=;
 b=VKMAn69TmvaozK70mTVpjFWaMcGTY8lXXi+9lQfrWifimwZ1R6nitBC9eFLMV8XdRmJReRXTQ9BQPgUDnycTvJ8PyFejRkgjJiXIkp5tayMBA51ewy2RhkQ5/31lTtGuFUXi3ZlUmhKEY4lAQdycSdnphmuzu5BOkXkr46JkvYY=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PA4PR04MB7888.eurprd04.prod.outlook.com (2603:10a6:102:b9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Thu, 9 Jun
 2022 06:19:11 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::983c:b5ce:91b1:447e]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::983c:b5ce:91b1:447e%9]) with mapi id 15.20.5332.012; Thu, 9 Jun 2022
 06:19:11 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "francesco.dolcini@toradex.com" <francesco.dolcini@toradex.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v9 2/8] PCI: imx6: Add the error propagation from
 host_init
Thread-Topic: [PATCH v9 2/8] PCI: imx6: Add the error propagation from
 host_init
Thread-Index: AQHYYOzdBbvnTPloC0idPVwcdkmq/q1GECiAgACF4BA=
Date:   Thu, 9 Jun 2022 06:19:11 +0000
Message-ID: <AS8PR04MB86766B300C242FAC686F58AD8CA79@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1651801629-30223-3-git-send-email-hongxing.zhu@nxp.com>
 <20220608185313.GA410761@bhelgaas>
In-Reply-To: <20220608185313.GA410761@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3dd7ac51-a602-418b-e09b-08da49dff81f
x-ms-traffictypediagnostic: PA4PR04MB7888:EE_
x-microsoft-antispam-prvs: <PA4PR04MB78885F026237CF6D5961FCB68CA79@PA4PR04MB7888.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8daFqTl7rMp40dDf/sK0tlOerNowYwrw248917CkWJev33/uze3yqYm/GhM1Sp6fzLVXVAtbpJdRFEjlg+s3dnaUfwmiyBK6/4jEQMGNJHlenxA3T8WRXlK6PUgpOpf+ryzNed2cFXOYjMhvqKrSopPLuRxUgKNTKmsR0S5/HaaTMYh4omOEz5M+WBSbPWop2CMDy9UTOazODe0x1eFuUbAB9oq16YcoCJkuYliFJ9h4tHKtBR2zgcOceqhUwm2wfb1Sk1dFsJnUuYNldlUDmoKWE+WGLmLsMlqRV19gUvS3l6hp3qihSjzvcBjQ1vfqgqjz/nZ24D8fajDVv1KmlJwyFB+jPpsarCAEXIWvio4BtokVz8YIQI8gxkJRX367oDcGVEHCaRQ2KSlCMrqB5d/IJePhQLqNHiIzlqv3DIHLAPueqc/g/REHWTAVy40Wsa7YraAXQpE3RMb5UcUlLQz1ckWzKfqG8dSTKYA2bJ0fZZGOB4m41Sn4duXg2Yls7Z1yhPyhbkzVKsg/8tinN4+jcm7g7bzk/R87CyTBK4HVvL+WDWP9eZXrHbNXAB5/8aIL+RgNCicJouPTscGOZ+9vgCpLWSjZyf0OBQeb1cj4ZiKfDHfFlfPmRfP74CVcZ1e69itnUd/kgVoI1J3zwmsDuIoLlzka0tMs9cvPmThEgQ6Y3nKHOQXd7KjCLg1B6EKy0LFA2xCJkRkIunYQtA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(33656002)(316002)(38100700002)(4326008)(8676002)(122000001)(64756008)(66446008)(66476007)(66556008)(76116006)(66946007)(86362001)(54906003)(6916009)(71200400001)(44832011)(186003)(83380400001)(53546011)(7696005)(2906002)(6506007)(7416002)(9686003)(26005)(508600001)(52536014)(55016003)(8936002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?N2k3VW4xRlYxRS93NitxbmFKMVBzTVpUb0gvYVdhRWJVaTRRaHBOd2JSWEJ3?=
 =?gb2312?B?QVhpeUg2Qjg4TkZoM0QxQXJCdFBJTUwzWURIRjVZMStBNWFiaklmVGRKNExE?=
 =?gb2312?B?bkFFdlFmdkhESERTRzArVSt5eXV4MFJaQjdJZjZZenlqOVM1MGdiWWFxdGVS?=
 =?gb2312?B?VmNFYys2bVdZR002SnNLQytpc0ZZMHljZ3lwQTg3aVV0a3I0K2M1bXlHU3lm?=
 =?gb2312?B?akhWdEhlV01DZnZFS1M5eUd6NFEwUDg0S0VmMnJOelJabG9WL1FzVDUvdnZI?=
 =?gb2312?B?MVFBdkM3RldjNktXVlQ5amtFRXVVZGw2M0FGNjJXWFZoellUYnhOYysreEYw?=
 =?gb2312?B?ZHUyNTNVdlFQa1VYdUhNSktBS2JUSXB0QVR4ay9WVkJKRVJnWVNXWlQ0Tmxk?=
 =?gb2312?B?TVNWVUw1TUZTcUxBb0swSXR2TkRZRFVMYTlTb0lob1RSdEtQdTgzOGFnUHhz?=
 =?gb2312?B?OC95WU9iWjAzcnZ5b1F3emQ2eko5YncxeFJkS3JyZ09iRW5IRm8ybHdiczYx?=
 =?gb2312?B?WnJKbEZrK2MweWtGNW9FMDFET3dOZVIreC9nVHRUajBVcGRmTUo1aHlTSmdr?=
 =?gb2312?B?bU5mb2lUOWF4MktPOXVNNEVGUHJwczVWRHRCeVVmMlF4NEJtNEt0NktIbGk4?=
 =?gb2312?B?K1IrNXlDTWhxaUZ0NWtxUld6bEVCdW1CalBWZ21ZYkttOHFQbTFiMUpEMlRi?=
 =?gb2312?B?OTF0MGViWEIvM3kzc1B1cy9wNWZaTStBYk1lMXRXVFlndk1lb3dVRkpZMjJs?=
 =?gb2312?B?UWhWVTZkMFkrc1lpMkdSUWdIdElhaGFaaEVIbnc4UTlDVEd2MGlOWmwybUFp?=
 =?gb2312?B?bXhWWTVDM3ZuNy9ybDdBeXFub0xoeTM3YlVlcmhhVzljUHZaYzVWRnBaT25L?=
 =?gb2312?B?MVB4bVZyY0J4bHg2NVRWOXRQSXRMYWF1bXk0dWQ1UzU3TUF5bnhJdmplR28r?=
 =?gb2312?B?bWtpNnVIKy93Y1JOcXdhZGJ5L0lncnNCcVBJU3RQZzNUSmN2Wm16V083ck9J?=
 =?gb2312?B?N1haZWJOWWNyZjN6MnJZL3lnWTFBVUY4Z1ZYN0ZoS1NYblJOcVFOUXE0SFgr?=
 =?gb2312?B?a09jcjRqZHk0MXpXN3ZIM2hWdWE1UDJiZHRFak4wYUluU0FjLzQvN3Vad1hs?=
 =?gb2312?B?MzUyRkhMMjlrOS84OGU0NGk2VSt0L2tsbW1VS1kwZ1NJb0RoVFpYT1JnRHNC?=
 =?gb2312?B?NWdwZkUzOU53bUxjRTEwSmNDYnJLbDVnTmxwQks1VUxmVVJYdmFaZCtwWitV?=
 =?gb2312?B?MHNWTm93YWxDOGthYjc3NkVaY3g1eXJBTHd2L2wxQ2VWdlJwdnVoaFR2OUox?=
 =?gb2312?B?UllLRkYxQUU0cVREcGlNTnUzc0FHSmFpVFdJTFRTSEFrbTVoYVBSWktncFZ0?=
 =?gb2312?B?emthUWNTT2VGdTUxc2c1TGdSelFNN1ZJcnNPZlpPRGpVVFVMOTh4NHpvMXZN?=
 =?gb2312?B?eHhlUXFSUjE0Y05uT0p5K0t5Q0tvbVp6Q0V5Nkl0Y3dFdEUxbFRqUDZ3dWhp?=
 =?gb2312?B?ZndJNGR1UzNrd2dhMXhMRm41cGc2QjgwazZKWGR6QTAwZ1hjYVZ0UDZPV3Zs?=
 =?gb2312?B?dVdoS3kzOWhocCtnNm0xRmc1VXFGdW9DcytSMUFaYnBnSThhSVdYZGM3NkdV?=
 =?gb2312?B?M0Nrc0s4eXZBNXEySEdRT0JlcmJwMHJ5cVplV0d1eUdPa0p1OXBzcU5qUVdo?=
 =?gb2312?B?UzhkQncvUWpmOEMybTB4Y2cxVjJnTFp1TkoyZTMveHN1ekNLSUgwekFIT3Np?=
 =?gb2312?B?d0pqMkI3aEl0TG8rRVp3cDQzL0EydndxWGgxSWxrS3dHL0FvYTN2TUVBWFlq?=
 =?gb2312?B?S01GYjJwNFhJYTNIR2FxZDJkTXhnM0RtKzZhWTRMVVBOVEdmUUp4S1F5Q3pL?=
 =?gb2312?B?RlpZTVZZWUVOdlRRWjFMbllpU2I0ai9FWVJ5aDNTOXhrTkRnN2I3QmExaFln?=
 =?gb2312?B?aXdSN1FaYnRESmJGNzVHTmNsUjEyWU5rN0FvVTAvN24wOUtWd0l4MGlrWjFu?=
 =?gb2312?B?T2RWL0xFN1p4UDBpMUdKcm9uWnNGZW1JTUlhcFJ3VGIxbDR0ZVIzZlBjZjdQ?=
 =?gb2312?B?cHRZbDJDVE42VUoydExOamwzRFU4WnhBL0ZSRURwV2dYTzEvN0d5cHZiTlFI?=
 =?gb2312?B?ejNVblV3aEJ1ekh0MkFHRDBNVlJZVTduUjdVRlVjTlBOU2JnOWhlcjhKT0ZT?=
 =?gb2312?B?ek9EOGhvUFVvWWhOWU5kMkpqUE54R1Z5SGJYZUJySGJEQ3VkaUJ0bUgyZmxM?=
 =?gb2312?B?UzBmaGxTbTVxMm4vZGJaR005WDJQU0g1TVdBYm9Cbml6V3h6WFh0QXJpcVZa?=
 =?gb2312?B?UjQ0Q3dHWllQUEdoY3owSjM4YTVpS0FPdGl3cHMrZnBHN2N3WUM3Zz09?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd7ac51-a602-418b-e09b-08da49dff81f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2022 06:19:11.5407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ydl1t5gCdGSA64t8avkwWALpUP48NXvMkYUcmvQoa/wp3eKdPn+Oomb39rIt6puVBEE+beCO7KbuISswJfhCug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7888
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCam9ybiBIZWxnYWFzIDxoZWxn
YWFzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjLE6jbUwjnI1SAyOjUzDQo+IFRvOiBIb25neGlu
ZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiBDYzogbC5zdGFjaEBwZW5ndXRyb25peC5k
ZTsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsgcm9iaCtkdEBrZXJuZWwub3JnOw0KPiBicm9vbmllQGtl
cm5lbC5vcmc7IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207IGppbmdvb2hhbjFAZ21haWwuY29t
Ow0KPiBmZXN0ZXZhbUBnbWFpbC5jb207IGZyYW5jZXNjby5kb2xjaW5pQHRvcmFkZXguY29tOw0K
PiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGtlcm5lbEBwZW5ndXRy
b25peC5kZTsgZGwtbGludXgtaW14DQo+IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDog
UmU6IFtQQVRDSCB2OSAyLzhdIFBDSTogaW14NjogQWRkIHRoZSBlcnJvciBwcm9wYWdhdGlvbiBm
cm9tDQo+IGhvc3RfaW5pdA0KPiANCj4gT24gRnJpLCBNYXkgMDYsIDIwMjIgYXQgMDk6NDc6MDNB
TSArMDgwMCwgUmljaGFyZCBaaHUgd3JvdGU6DQo+ID4gU2luY2UgdGhlcmUgaXMgZXJyb3IgcmV0
dXJuIGNoZWNrIG9mIHRoZSBob3N0X2luaXQgY2FsbGJhY2ssIGFkZCBlcnJvcg0KPiA+IGNoZWNr
IHRvIGlteDZfcGNpZV9kZWFzc2VydF9jb3JlX3Jlc2V0KCkgZnVuY3Rpb24sIGFuZCBjaGFuZ2Ug
dGhlDQo+ID4gZnVuY3Rpb24gdHlwZSBhY2NvcmRpbmdseS4NCj4gDQo+ID4gQEAgLTg3OCwxMSAr
ODc5LDE4IEBAIHN0YXRpYyBpbnQgaW14Nl9wY2llX3N0YXJ0X2xpbmsoc3RydWN0IGR3X3BjaWUN
Cj4gPiAqcGNpKSAgc3RhdGljIGludCBpbXg2X3BjaWVfaG9zdF9pbml0KHN0cnVjdCBwY2llX3Bv
cnQgKnBwKSAgew0KPiA+ICAJc3RydWN0IGR3X3BjaWUgKnBjaSA9IHRvX2R3X3BjaWVfZnJvbV9w
cChwcCk7DQo+ID4gKwlzdHJ1Y3QgZGV2aWNlICpkZXYgPSBwY2ktPmRldjsNCj4gPiAgCXN0cnVj
dCBpbXg2X3BjaWUgKmlteDZfcGNpZSA9IHRvX2lteDZfcGNpZShwY2kpOw0KPiA+ICsJaW50IHJl
dDsNCj4gPg0KPiA+ICAJaW14Nl9wY2llX2Fzc2VydF9jb3JlX3Jlc2V0KGlteDZfcGNpZSk7DQo+
ID4gIAlpbXg2X3BjaWVfaW5pdF9waHkoaW14Nl9wY2llKTsNCj4gPiAtCWlteDZfcGNpZV9kZWFz
c2VydF9jb3JlX3Jlc2V0KGlteDZfcGNpZSk7DQo+ID4gKwlyZXQgPSBpbXg2X3BjaWVfZGVhc3Nl
cnRfY29yZV9yZXNldChpbXg2X3BjaWUpOw0KPiA+ICsJaWYgKHJldCA8IDApIHsNCj4gPiArCQlk
ZXZfZXJyKGRldiwgInBjaWUgaG9zdCBpbml0IGZhaWxlZDogJWQuXG4iLCByZXQpOw0KPiANCj4g
T3RoZXIgbWVzc2FnZXMgZnJvbSB0aGlzIGRyaXZlciBkbyBub3QgaW5jbHVkZSBhIHRyYWlsaW5n
IHBlcmlvZC4NCk9rYXksIHRvIGtlZXAgYWxpZ25tZW50LCB3b3VsZCByZW1vdmUgdGhlIHRyYWls
aW5nIHBlcmlvZC4NClRoYW5rcy4NCg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0KDQo=
