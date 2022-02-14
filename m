Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF0594B4019
	for <lists+linux-pci@lfdr.de>; Mon, 14 Feb 2022 04:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbiBNDHp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 13 Feb 2022 22:07:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235337AbiBNDHp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 13 Feb 2022 22:07:45 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60071.outbound.protection.outlook.com [40.107.6.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EEAC07;
        Sun, 13 Feb 2022 19:07:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S3WDwFlLmL3S9wMeyxlIAZv2lA2fWif6zkCzHanlNhkArQRPDAUu9/Pb0d4OlFieaShDD95e7im85M0OYpKwh4f3wRrlUNlp8xQ2uIerqaTGuvhAaTLR6VrBGe4nYIYVcPJZPb9MEjf2+dV2ZmTtNYGjRXpyj968ZHS2AdSSVrG1LnaBzX6LkcquFlsJ7sSz3bdnvSZWV279iceHb2/R2u7kgCIwWLwaxjAOHtPnGMsr+RknYQaVI09IEdGgbRanHA1fV2zZqbrVexCfYR03wCi+zTGh/wvcDmVMzF/kJf/3tM39Qcc3IZgB6q0nqO/VV672GTD4rSkLDZDyUXuBWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ELIzBdYIEfcHzIKlyvfeeASHD/ckgWzSfBZXQ9yFOu0=;
 b=MquRx2l4EthZB7JmwUSEYH18j/8DiAQyn9//zM5McUkBXLmgK10dIZAlTi6fnXzuhF/Y5FGCeMwaK/xlXWDrGqxQDwpaQt8raxmT1xsA3GQ2m7ul0Jh95zsVbPwRKgTO9QRmze1QGDbT3z/Gymzu6atRRRoXVQkD35k0bNJULONkuMW9BxObZq9+sLAY/e8/r+2ZNys90JpRCquYwhGZG82X+D3OO7hn23kZ/9bs+ceYrf2A9EgeWbykes5PJiXyGi98+arMhyIC31a9NlnB8PluadYO2gmNsOeFBnV0XVaj5Ii3dxcTD00oXKUWs4nj8zeBrCZxuSQFvWkr9rR72w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELIzBdYIEfcHzIKlyvfeeASHD/ckgWzSfBZXQ9yFOu0=;
 b=a9t3EsJnfYniFSWbjZorNjnz7/FeeG+fMkjzvS7u4jJAU6KzlLxDU+K3cMV18RrmqlsfQcHKzTq5zBsHEFi5hc2veuQgc5UoBGgDFKg/hYTnJQmuxb3lsCIsTrLi0ABQ6VTozeQv0FIkhRk+E6v4aoiXkQyoPDJNShrey2hK6Vc=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM4PR0401MB2322.eurprd04.prod.outlook.com (2603:10a6:200:50::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12; Mon, 14 Feb
 2022 03:07:36 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::3d1c:b479:1c58:199]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::3d1c:b479:1c58:199%7]) with mapi id 15.20.4975.018; Mon, 14 Feb 2022
 03:07:35 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Francesco Dolcini <francesco.dolcini@toradex.com>
CC:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH v6 5/8] PCI: imx6: Refine the regulator usage
Thread-Topic: [PATCH v6 5/8] PCI: imx6: Refine the regulator usage
Thread-Index: AQHYHJ/uzu66Zs8raEChP5mwivzPZ6yOj2gAgAPHxTA=
Date:   Mon, 14 Feb 2022 03:07:35 +0000
Message-ID: <AS8PR04MB8676479F3B292252F3A7406E8C339@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1644290735-3797-1-git-send-email-hongxing.zhu@nxp.com>
 <1644290735-3797-6-git-send-email-hongxing.zhu@nxp.com>
 <20220211162758.GA287827@francesco-nb.int.toradex.com>
In-Reply-To: <20220211162758.GA287827@francesco-nb.int.toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 58e997cb-0f29-4cc5-f1e1-08d9ef672694
x-ms-traffictypediagnostic: AM4PR0401MB2322:EE_
x-microsoft-antispam-prvs: <AM4PR0401MB2322AB687485CF702AA4A8E28C339@AM4PR0401MB2322.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0Scqwe5v8IPlCLDxAdDUBjO2bA9+rbkXGtt6YZHKKTZuggJAZEmGzOzm8iOBg658LsV2EBleGjqCqOZx8H0J6FLg7nxN4QeyBcn8tLTvvmw2rNhVYcVF94wFFFgS4TODPBOULmDKpSXAjdMYG9YsXiFBS5firUUMHapY+xfixdqP3J3W72s3BKFZ0VCajWMft0457tXyH1R/zkX6lpvXC8ZZ1dLfQmv+kOh7ya3IimM3WfTcCPuPZCo0isFfCd+nPBe50VgaUu24drcBBW6oOlrm3V4zciaIBpOJiALuNGAty4Htu/nx9ULXvf3Mcx5nzEyRtd8WWIOCVLmvl5yy1c8j8kmgSI05Ab1hBGtF0H5qfrgryVtC/2PIoN/kokxEpzefArmcbLmu0hiAihC5B9y+JgR4D4ram1bYYpTh0ja10J/E2a4wF05pfHmd7q+PJu6RXdMQbRQFEpRADX5sxQpujtLuwXe6ZH5MesxWJCQdtM6qqA5LYEvQFBttq3eB3EKBv+l6ORPLokgJ0g3dgwGNU1Vfrmaq2ayarGSiyDc18r3PYIUGHVlWHeVPPGWKokJwZwZPaxAzZ47ZRatYmb4u8ZHqeViwvYaXHwTw3oepxvGK5onLoaXxoy6CkrazNgLH3Cege4JpsSWAYrbhgwvgh4bPvTqqoyu4G/kmlKIg3eXVhnszEd5l9FFgohGi0paUdzXust/h5bRofqtmOA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(33656002)(71200400001)(508600001)(44832011)(83380400001)(5660300002)(7416002)(55016003)(6916009)(316002)(76116006)(86362001)(4326008)(66946007)(66476007)(8676002)(66556008)(8936002)(66446008)(38100700002)(64756008)(38070700005)(54906003)(9686003)(122000001)(186003)(52536014)(26005)(7696005)(6506007)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?d1U1QjJ4TTEwOE1LSlA1Z291ZEY3RVJtTUpJc2V1dmtzK0tYdVF6UnlBSXdw?=
 =?gb2312?B?RGt4ZkI0T0srdjdvMmFzdVpjMzBFTDhMMkF5Y0ZxRWViekNxenpIWjd1RWxE?=
 =?gb2312?B?Wm0xUXN2UC9jNURPa29XVG93bGxoYkZMbVBnUGZDYytNR1dRS2RlUThXQkNl?=
 =?gb2312?B?K20vWmkyWG1jMTUrUGNaODRnNEQ3RlhjeTFSR2hDWUxrYkc1NDJZS1pCTEha?=
 =?gb2312?B?OTlUbGdJU1IxanhZdWlsbEpqa3FHeUVSSlRRQ0FSTUNyekp2all3L1BjaGJ1?=
 =?gb2312?B?emdPQXhBeHZtaUhKd24zOXUyQkN0d2ZNa2xYbm5Jamk5Y0grcGlRZHY3ak1k?=
 =?gb2312?B?ZzloOCtuOTJVNklLeEJ2eWdUTHdaSXlNKzRpNStKejZ1SE5pSDhHWEl0aEpS?=
 =?gb2312?B?eDB4T1RmV2VheWJFLzYxMTZocnNWSmxHVGlTQUg0bVRhUEhoVjRJNHpOaWxQ?=
 =?gb2312?B?bW1TN3Q5M0pBTGtveml1ZWE0eWNVZGdZYStVNkJoeHV4cjJNSUl3b1hyS2RI?=
 =?gb2312?B?czFqZ09PUnlVWTRjVUxwQWtXQTBsaGZLUElSRjZiblRpelpFSHBZN3NRWnFz?=
 =?gb2312?B?TXg2WHNHWk9QbHZDelMzVW5SbnJOK1NMK005R3hQRWZxOGxxZEdTN3EzTEMw?=
 =?gb2312?B?SnVIUWl2SVc5M0tUb0YrMGtSZEY4TURZMGh5bDErc2tpNHpMcUpiK1ZHY0x2?=
 =?gb2312?B?LzVFM0pzRjJUNFp5UUpNRlhTSERGTEFibUhIUC9YKzZJdGxVK3hpSmMwckhD?=
 =?gb2312?B?T3dPN0VuMTZhT0JwYTdjOVRNQ2ZidjhqN0lLT0FYQ3VNY3ZZa01rMEVYYlQ3?=
 =?gb2312?B?Yzl4bmJoM1hkM2lGUzVoZE1mZkdHVGhITnFuNzIvcFVrbkJrRTI5ajJaMjRM?=
 =?gb2312?B?K0kzZWFjSFNSczMrMXpDYUJ3d1czcW5ZRGpTZFRGakxRSFhQR2JaL0hkUEJI?=
 =?gb2312?B?T3E4NUlmZGhKWllhNjdSYUpuTHkwWkZtaDRZT3BYQ2x5THlIUG5yck9CRUd0?=
 =?gb2312?B?c2FIYmlEOFBsQXJtT3Q3a3pVSy9zalpjek5sY1dLTUlCNThGK1VORzV3T0ts?=
 =?gb2312?B?MHI0TUNCVFVsV1cvTmlaeUcrZjlSUnczWDRuaVkxVTFmZWFMN0VKdWVhS0h1?=
 =?gb2312?B?b2JPaW5BWlZVaXJRM2t0UlUwMzFaRTZLK2ZWS3BtMFk0OVpSeUpFTmRkb1la?=
 =?gb2312?B?Smdjd1R0SVlJSTlPZDVJMjhBUkhyUzdaUWV3aEpHNWtaSk91VFY4OXl3ck9Q?=
 =?gb2312?B?VFU4Q1hBSVpHZHZjM2lNU0dBZEtPS2xFWG9mK0ROeThCNG1wc1RlWHF4SUxp?=
 =?gb2312?B?REVRTmp6QUcwcDNXOFBYSXNmUjdmNHlhYlF5eWc1VWNUbktjdk9Gait5ME82?=
 =?gb2312?B?RUZlRE1rSEJ6UytFU3RCYWtSYVkxeUR0bXdmeXBOaUFpTi8yUCtKZW5pRmV2?=
 =?gb2312?B?TWRpZkNINzNYWW4yRXAvS0lmNzdaZmFRSEt6MmNiZkpjN2UyQnBneXVJRk05?=
 =?gb2312?B?eHViZlZUaHB0b3RXbXc0SFZHZFg2UktURncvU3BzUlFZZXd5SzdTUkl5Rllp?=
 =?gb2312?B?dysrbnRDcHRLb3plR2xGa3JmY05nelQvMnFhKy9jcFg4WFJQdEdRTmR5aDZy?=
 =?gb2312?B?QmpNWkZ2eHlNVUxCYmFmM20vdTlxSXM4OVg4aDA2UHFvL3daWS8xcFZ1MEpW?=
 =?gb2312?B?Snhxa1ZnRWcvT3d5ekc1YUx4K0hUWDQ4ZEo4NHJtczFpZ2dXSVlkUVdkQXNE?=
 =?gb2312?B?a3U1ZW1hZitxdVI3dUtWSDlLK2s0aXlYT1RxMFVQTnhUUGhNN3FoNWIvYm5K?=
 =?gb2312?B?Q2NadTZhSGoxWnRqOFpqSHhWaXZlN0VkaHprc0N4SXA2c1pyZjVjNGQvbzM2?=
 =?gb2312?B?M2d4RHNYT3pVSlR6NW9QS0tadlo3T0pWczFBdXpvOUswdU1QajQrODVjU0FF?=
 =?gb2312?B?VTJWSUFiMVhCa1RUSXhLSk4rNzJsYjFTNjVwcjJkVXZacTU3ck5OV09OcVVl?=
 =?gb2312?B?eDZ3Q2VaU0pkZENJa1Yrd0grcnp2T21MTVVTT010N0hyRkVZUE1FQXlqVEU5?=
 =?gb2312?B?dWc0MHZoSVFMYWJPRUFjYVR4SzBoQVY0ZklvamswV25SUGZvWEJsVG5OVlpV?=
 =?gb2312?B?cW1SckxLOHZUSjBTeS9yMXJJQU9rQjFta1BlNnoxVTUwZ0VqbCtrM2RBTUl1?=
 =?gb2312?B?M2c9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58e997cb-0f29-4cc5-f1e1-08d9ef672694
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2022 03:07:35.6663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YAIl7MMO2XJtCowS8UKOz/GGYCfNLcWjkW4enbo88eJv+1nJ+0X1syLWuPp0xNa1amPW5UgMRdWilDEv3J2d8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0401MB2322
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGcmFuY2VzY28gRG9sY2luaSA8
ZnJhbmNlc2NvLmRvbGNpbmlAdG9yYWRleC5jb20+DQo+IFNlbnQ6IDIwMjLE6jLUwjEyyNUgMDoy
OA0KPiBUbzogSG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IGwuc3Rh
Y2hAcGVuZ3V0cm9uaXguZGU7IGJoZWxnYWFzQGdvb2dsZS5jb207IGJyb29uaWVAa2VybmVsLm9y
ZzsNCj4gbG9yZW56by5waWVyYWxpc2lAYXJtLmNvbTsgamluZ29vaGFuMUBnbWFpbC5jb207IGZl
c3RldmFtQGdtYWlsLmNvbTsNCj4gbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgZGwtbGludXgt
aW14IDxsaW51eC1pbXhAbnhwLmNvbT47DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4ga2VybmVsQHBlbmd1dHJv
bml4LmRlDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjYgNS84XSBQQ0k6IGlteDY6IFJlZmluZSB0
aGUgcmVndWxhdG9yIHVzYWdlDQo+IA0KPiBIZWxsbyBSaWNoYXJkLA0KPiANCj4gT24gVHVlLCBG
ZWIgMDgsIDIwMjIgYXQgMTE6MjU6MzJBTSArMDgwMCwgUmljaGFyZCBaaHUgd3JvdGU6DQo+ID4g
VGhlIGRyaXZlciBzaG91bGQgdW5kbyBhbnkgZW5hYmxlcyBpdCBkaWQgaXRzZWxmLiBUaGUgcmVn
dWxhdG9yDQo+ID4gZGlzYWJsZSBzaG91bGRuJ3QgYmUgYmFzaW5nIGRlY2lzaW9ucyBvbiByZWd1
bGF0b3JfaXNfZW5hYmxlZCgpLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUmljaGFyZCBaaHUg
PGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3BjaS9jb250cm9s
bGVyL2R3Yy9wY2ktaW14Ni5jIHwgMTQgKystLS0tLS0tLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5n
ZWQsIDIgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+IGIvZHJpdmVycy9w
Y2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+IGluZGV4IDBhY2E3NjJkODhhMy4uZTE2
NWFkMDA5ODljIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3Bj
aS1pbXg2LmMNCj4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5j
DQo+ID4gQEAgLTM2OSw4ICszNjksNiBAQCBzdGF0aWMgaW50IGlteDZfcGNpZV9hdHRhY2hfcGQo
c3RydWN0IGRldmljZSAqZGV2KQ0KPiA+DQo+ID4gIHN0YXRpYyB2b2lkIGlteDZfcGNpZV9hc3Nl
cnRfY29yZV9yZXNldChzdHJ1Y3QgaW14Nl9wY2llICppbXg2X3BjaWUpDQo+ID4gew0KPiA+IC0J
c3RydWN0IGRldmljZSAqZGV2ID0gaW14Nl9wY2llLT5wY2ktPmRldjsNCj4gPiAtDQo+ID4gIAlz
d2l0Y2ggKGlteDZfcGNpZS0+ZHJ2ZGF0YS0+dmFyaWFudCkgew0KPiA+ICAJY2FzZSBJTVg3RDoN
Cj4gPiAgCWNhc2UgSU1YOE1ROg0KPiA+IEBAIC00MDAsMTQgKzM5OCw2IEBAIHN0YXRpYyB2b2lk
IGlteDZfcGNpZV9hc3NlcnRfY29yZV9yZXNldChzdHJ1Y3QNCj4gaW14Nl9wY2llICppbXg2X3Bj
aWUpDQo+ID4gIAkJCQkgICBJTVg2UV9HUFIxX1BDSUVfUkVGX0NMS19FTiwgMCA8PCAxNik7DQo+
ID4gIAkJYnJlYWs7DQo+ID4gIAl9DQo+ID4gLQ0KPiA+IC0JaWYgKGlteDZfcGNpZS0+dnBjaWUg
JiYgcmVndWxhdG9yX2lzX2VuYWJsZWQoaW14Nl9wY2llLT52cGNpZSkgPiAwKSB7DQo+ID4gLQkJ
aW50IHJldCA9IHJlZ3VsYXRvcl9kaXNhYmxlKGlteDZfcGNpZS0+dnBjaWUpOw0KPiA+IC0NCj4g
PiAtCQlpZiAocmV0KQ0KPiA+IC0JCQlkZXZfZXJyKGRldiwgImZhaWxlZCB0byBkaXNhYmxlIHZw
Y2llIHJlZ3VsYXRvcjogJWRcbiIsDQo+ID4gLQkJCQlyZXQpOw0KPiA+IC0JfQ0KPiANCj4gVGhp
cyBjb21taXQgaXMgbm90IGp1c3QgY2xlYW5pbmcgdXAgdGhlIHJlZ3VsYXRvciB1c2FnZSBhcyB5
b3Ugc3RhdGUgaW4gdGhlDQo+IGNvbW1pdCBtZXNzYWdlLCB0aGlzIGlzIHJlbW92aW5nIHRoZSB2
cGNpZSByZWd1bGF0b3JfZGlzYWJsZSBmcm9tDQo+IGlteDZfcGNpZV9hc3NlcnRfY29yZV9yZXNl
dCgpLg0KPiANCj4gSSB3b3VsZCBub3QgZG8gaXQsIHRoaXMgaXMgY2FsbGVkIGZvciBleGFtcGxl
IG9uIHRoZSBzaHV0ZG93biBjYWxsYmFjayB3aGVyZSBpdA0KPiBtYWtlcyBzZW5zZS4NCkhpIEZy
YW5jZXNjbzoNClRoYW5rcyBmb3IgeW91ciByZXZpZXcuDQpEbyB5b3UgbWVhbnMgdGhhdCB3ZSBz
aG91bGQga2VlcCByZWd1bGF0b3JfZGlzYWJsZSgpIGhlcmU/DQpPa2F5LCBJIHdvdWxkIGNoYW5n
ZSBpdCBsYXRlci4NCg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0KDQo+IA0KPiBGcmFuY2Vz
Y28NCg0K
