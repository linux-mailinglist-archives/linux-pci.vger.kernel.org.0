Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F945734C3
	for <lists+linux-pci@lfdr.de>; Wed, 13 Jul 2022 12:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235567AbiGMK5P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Jul 2022 06:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235687AbiGMK5O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jul 2022 06:57:14 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2079.outbound.protection.outlook.com [40.107.20.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74CE1FFE03;
        Wed, 13 Jul 2022 03:57:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bolx64UD3wtoOmUoe9YUhriKTcemgMawTUe57mkq2K4aHMdAMkMf36q2qGKaA9P8lC6rXP5IWyVo35I1On07vR/Y9iWxaCkkBVPoU/0C4NcGzBBUuudIxJ0EEqPn6wXE2VPAjAfNAcLeRcxPRuIrIX/MgeEj7WDHB9AvRxISW8Ih/QQkA6jEAHKe5JJDcuhE5somFHVqJNb+k787JS/+NFSaxKAgQcPPNird92w2DL3ECHp/CLg3DaSOA9AmkQNRqK19VEBs5sMDJOmRKYNJzUjZnx7e5mtsBhhyijN7YJrBXh58xkmj0iBwPf/vwkE1LDCwgf+4XE3k5aEvEblvOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c4MoV9ovCP1JOhE5GQ0gq1aNRKcjt61dIPqeA00Mzt0=;
 b=kpCmR7gHHsQh9Iw1NUWUqQpiDqnaOSt61ervrx6Pxs0SR7JuLWrdeRq7MJhVV/aK0RyiWvjFwcJsAI0CsypZHuYwMrbYz/vOCKzuoQjqo/q33WjTXFLThnGDwDCXj7lv/Y5zTc/mJEsXYpCoUw/5q5IIHNyPguAf8dAw5zlAA4jpREorGFcaUPxynsfAHF6V+/q5Sh1AowO0GwtwiUs4KX+ize90HxPge52Wq8wMmB94Wd0aQWEpaIh4p4hTiwhsstAOCY0r8lFG4teabUpzxv9RhNzHm1o3y6c9hXRTiKyLg302VQtI0N2Mw4diKsC/4xf8wQ1dhMoquK4IpG8Z3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c4MoV9ovCP1JOhE5GQ0gq1aNRKcjt61dIPqeA00Mzt0=;
 b=nB8IN4wkgBrG8WIsfk0g9bM9oypBdwbBCiIm4wN/glAcI36nd573GQzKXVeObMMko/Gd9E3xgggcJj+iBqwD3/hxHrolHu+sc5v+3v/jjONxW8b+nZkvq4o1g36D71mNIr6F7CSg7sdpcHnHqvcgm5fOg7JVmx/zgfUcUC2lilo=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM9PR04MB8522.eurprd04.prod.outlook.com (2603:10a6:20b:431::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Wed, 13 Jul
 2022 10:57:10 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::75c6:afbf:7972:6c6f]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::75c6:afbf:7972:6c6f%7]) with mapi id 15.20.5438.012; Wed, 13 Jul 2022
 10:57:10 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "francesco.dolcini@toradex.com" <francesco.dolcini@toradex.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v14 11/17] PCI: imx6: Move regulator enable out of
 imx6_pcie_deassert_core_reset()
Thread-Topic: [PATCH v14 11/17] PCI: imx6: Move regulator enable out of
 imx6_pcie_deassert_core_reset()
Thread-Index: AQHYjPxPXNphtyVYFUiQog8mClKjr618Dp2AgAAR13A=
Date:   Wed, 13 Jul 2022 10:57:10 +0000
Message-ID: <AS8PR04MB86769857515B8B199F4F3F578C899@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1656645935-1370-1-git-send-email-hongxing.zhu@nxp.com>
         <1656645935-1370-12-git-send-email-hongxing.zhu@nxp.com>
 <2cfe481fdbd074ef6ff7e95bf32b5c99e6a26aca.camel@pengutronix.de>
In-Reply-To: <2cfe481fdbd074ef6ff7e95bf32b5c99e6a26aca.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 81f55f83-7d0a-4a03-41f8-08da64be6f7a
x-ms-traffictypediagnostic: AM9PR04MB8522:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 80QO1omiHSmR8o0BM+LnuM9vmBkV11cJRvAvuedbtfZVA0hohxOMHlBZQT7WNhPfHCUv6Sdwc2mNC2ui+kzofY+qKwtvsAmFyU1ALhOS3Q8gXErCGiDyRk3AxH3POVuQoP59Gde5AFr9/0AaxzB1bwcinZ+J/G6CT0Z0kLrKiBiewPclozbP0DCchJeOAMG2c+KpCxdEvbIisey1Pwy4QswkYuFYM9ICb0Lfl0hbjvvWzqwRLMLhTHoLL+L0slsYQwt05Z3Y7uOY5WvAAixoWCNsNtoeWzxJhg7v2RVvaYfNCMn8hDMrIIRlBxyZsv90EO0UWb/6E98jpmj3YtOjrC0tB2vf4qYAzKUcAITdslCJ+dHdOGYsA1OekWcjfoPQOPhc/9ZPVlTmORyJipVSSCAuD/N2iWmwNAitJpTp7ovbEOpbGH5PnS/4fpxMV7q1UrNgtrZ6snq2Psl/xec52rm7GH9fyLEf4neBgZ7I07O+SebnHxeb+WMFdQyv/09iNvL80Ni1MxXsyMWixLj1FGfsRBIy6FbgAKJNTAxNG5K1shRCBXFYj1ux2se9Lnv5Y7+UB3/0V2eWwShduscqeRVnRkM4BeOnNNiqa1LdZc3hZZ1idJFPCYUiU/3yCAo92lMSu3IsCzyBjjaAKQOgNMXuqw6a52aYIvG2+ELoRB5nad20P5Sv7kYBbIRfqIL6PBhNJZFrV5hLWplOodOdAkUWUBd85V7D0wNnqyufswncLAs+d4d1aiBcYMkDSpDDnOMn9LUDAj2qbB8pcYjYVFuCIN4RbzX88OOOKnrF7YcoPY4qw+2+k4e54xRU46QP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(136003)(366004)(396003)(376002)(2906002)(110136005)(41300700001)(54906003)(71200400001)(7696005)(53546011)(26005)(8936002)(52536014)(5660300002)(8676002)(316002)(64756008)(86362001)(33656002)(9686003)(4326008)(6506007)(7416002)(44832011)(66556008)(76116006)(186003)(83380400001)(66476007)(55016003)(66946007)(38100700002)(122000001)(38070700005)(66446008)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?citaZ2E1Z01la1VoQWxxR1ZuWFcwSit6c2FaRThVMk1udWc4UHhKM0hnQWoz?=
 =?utf-8?B?R3BvMHI4UWtSTkhTUjNqM2Z2b1BLUXA4VTBkckhTcjZzRWFRNXhGMUZVbExY?=
 =?utf-8?B?b0pOWnl3cS9nNzdqY0V6MDZqNEZZeng2QzBTTTRxblFqbkRURThubHdBYVlF?=
 =?utf-8?B?cFoySWxLN1FXNjUwTW1ITGNPZWdqUHU0SWRsNjhkOU90TzRrWm1xSlNidHFF?=
 =?utf-8?B?K1hyaHNsbXdBTVJWMVlob2J6QXNwMGlRR0VMc1VydlB5djFiUitub1k3SXFS?=
 =?utf-8?B?ZThWYWpBL00ydmorK3ZmajVHUmxiSVpTZkpoVzFVcDNqclBCaHpEMFJDQ0RQ?=
 =?utf-8?B?VVNHdis3QXVkbnFiUzRiTzZ0c2Y1aGExcFZDdE1Bd1pUNEZvYzRZeUNtNEJw?=
 =?utf-8?B?ZmpoM2d5dldORWtnU0pnRUtJcUs4Ry9MMjNyODZucEZrTGRTbm1zSkNoNW8r?=
 =?utf-8?B?SG02b3FYVWtTRHlJUkpnaFgzM1RBVHVnNzAxSCtqUzVLYU9iQld1bmg5OUlQ?=
 =?utf-8?B?RDh0dWhNaFA3Y2JXeThjTk1JRndWaWFEcjJBQ0tVK1RUZVRPeTlhSE4rS3hL?=
 =?utf-8?B?TUMza2h4WVRuM3k1RDB4bktkL25NRVVteEVnWmxKbGFBdTNQWDFmMHBraThV?=
 =?utf-8?B?VmtzUWtMWVczbjJYbTJzSnl1UkIwc2k2RXJyMWFWTXRpS3IvcFBZa2xPSjdv?=
 =?utf-8?B?YVoxUkZHRXg3UWUzUkh3Rm1zeldIQWpSUnVxWmtSNHRCTFo0WVBOcmFIeHlE?=
 =?utf-8?B?cnN6K3h0RHZCSjJGci9vaWQybDVOWXVqcjVIQ25XSHo1UmhaeEZzOVZJeis5?=
 =?utf-8?B?aFo0TzFRb1R3NDVQcks5b1VhYVpHRDJOdFdDTmhFd3NBc240am40UXF5V0kv?=
 =?utf-8?B?dlpFUU8vaVVGeUd1NHhuazRtc2VkQXh1Z29Jd2plT2ZTVmlzODBsZDlHclU1?=
 =?utf-8?B?a0dCRWhybUZzQjZWOGI2RkEwdktkNUQvaFIySzZwU1dVc1pqWWFNVTlhanJ0?=
 =?utf-8?B?ODdhQjB3dTZDTzYvRk95Z2JJN3ZONWE0c1l6OG9iKzZzZHBROEZFMjhpbnJ2?=
 =?utf-8?B?b2dneEcwYTNZVjBLRU1Kb3M3eVgzVTRuU1h5TERWTFFjZUVmTy9LYkdBb0tn?=
 =?utf-8?B?OElSODB4UEpmS3lwTCt6VVNMSEtyMFREcVVuMW9VVk5ndDNTeVQ0d2ZvMi96?=
 =?utf-8?B?L0FzUk5nNmRnSG9USXpJOEo4QmxNUHBtYjdHeUJjL1pyY1grN2VqWmVSbGF6?=
 =?utf-8?B?TzVqelMvUFhKZk5ZY1lzUDFSRVZtbld1UGk3TVduZVg1R204TGppdXVFbFM5?=
 =?utf-8?B?N0p1MEJCMk5VS1RJcUJabTRtR05tSk5Ld1k3U3BqSzA2T3QyOGdsMC9WMSsz?=
 =?utf-8?B?SXErU1JEU3J5MjJIclhtSUZzcGwrU0NqUEM5dEx2d3EzOElSdnI0Yi9RU0FG?=
 =?utf-8?B?NUdMN2t2OUlQY3VrYUduVHNwckNNSzlOdEI5WHp4TlJHYkxaRzJrVUVuSTRK?=
 =?utf-8?B?ZnZnTllyZ1lBZ2ZrNThGZlRpQVpHcERqY0kzVEVrZGsvSmR4NFhJUjE2QnhR?=
 =?utf-8?B?blRWQjhZRmxaRkVuc1VCUEtIdTYzV3YrVW9sOGo1SXE3dVFGVHlXbE1tZklr?=
 =?utf-8?B?YjJzOG1SQW1Zb0x2Rk13RTE3Sk4rUjEvbDlFQUdYUVVzOHovdGtBTGI5WjdB?=
 =?utf-8?B?UjJrRGJnQUFReTlZdm50WXBuSFZ6UndtUGt1ZUVrcXZYcUozOVRFM2M4V1FU?=
 =?utf-8?B?NlphdlRERDloaDFZaXlRQ2Jpc3hsblFnZUM4L1NQZzRCZHp6ZjdVUEtQczlU?=
 =?utf-8?B?bWw2dmVwWndORmJhUGU5YXhDZ1FaSmtrd3Y1Snk5cVplRkpiOXRCQkoySG1j?=
 =?utf-8?B?UmM4QWJYYnl2ZEhNN3J0Umptb0kzL3VaeFZ0OGlwYzRyUnQ4TjhzcEpZQ2ov?=
 =?utf-8?B?R2dLZ0ZMZWJoYlRBNTNoSFMvZnNTRnQxUG9HMExLaGVLV3UzdCtCVXlVYjRh?=
 =?utf-8?B?OG5oQjNtZkowcjBVMS9Wam1DMzI3bDhmRlNDNG0veHQ0S3pkWmhkZG9vcnJw?=
 =?utf-8?B?VUQvdmNlQzdXNk83akNWWUVTdTYwVW5wRWlPMkkrRXl3c0Z4TzJXaTY0ODVS?=
 =?utf-8?Q?YcGPtw5NgPY1OFRa6bdc7S2cn?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f55f83-7d0a-4a03-41f8-08da64be6f7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 10:57:10.3038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EU9gnsL6icKu6ADQzjFGhTv2bqwZdJZQ5OpE34wIKKemvi2epFdxzfXk5b12exPu0fV5lbneT0D7i1GOGsIcqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8522
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
aEBwZW5ndXRyb25peC5kZT4NCj4gU2VudDogMjAyMuW5tDfmnIgxM+aXpSAxNjo0MQ0KPiBUbzog
SG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT47IGJoZWxnYWFzQGdvb2dsZS5jb207
DQo+IHJvYmgrZHRAa2VybmVsLm9yZzsgYnJvb25pZUBrZXJuZWwub3JnOyBsb3JlbnpvLnBpZXJh
bGlzaUBhcm0uY29tOw0KPiBmZXN0ZXZhbUBnbWFpbC5jb207IGZyYW5jZXNjby5kb2xjaW5pQHRv
cmFkZXguY29tDQo+IENjOiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZGwtbGludXgtaW14DQo+IDxsaW51eC1pbXhAbnhwLmNv
bT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MTQgMTEvMTddIFBDSTogaW14NjogTW92ZSByZWd1
bGF0b3IgZW5hYmxlIG91dCBvZg0KPiBpbXg2X3BjaWVfZGVhc3NlcnRfY29yZV9yZXNldCgpDQo+
IA0KPiBBbSBGcmVpdGFnLCBkZW0gMDEuMDcuMjAyMiB1bSAxMToyNSArMDgwMCBzY2hyaWViIFJp
Y2hhcmQgWmh1Og0KPiA+IE1vdmUgcmVndWxhdG9yIGVuYWJsZSBvdXQgb2YgaW14Nl9wY2llX2Rl
YXNzZXJ0X2NvcmVfcmVzZXQoKSwgc2luY2UNCj4gPiB0aGUNCj4gPiByZWd1bGF0b3JfZW5hYmxl
KCkgaGFzIG5vdGhpbmcgdG8gZG8gaW4gd2l0aA0KPiA+IGlteDZfcGNpZV9kZWFzc2VydF9jb3Jl
X3Jlc2V0KCkuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcu
emh1QG54cC5jb20+DQo+IA0KPiBBaCwgc28geW91IGFyZSBkb2luZyB0aGluZ3MgaW4gdHdvIHN0
ZXBzLiBEaXNyZWdhcmQgbXkgZmlyc3QgY29tbWVudCBvbiB0aGUNCj4gbGFzdCBwYXRjaCB0aGVu
Lg0KVGhhbmtzLg0KDQo+IA0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3
Yy9wY2ktaW14Ni5jIHwgMzYNCj4gPiArKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0NCj4gPiAg
MSBmaWxlIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDIwIGRlbGV0aW9ucygtKQ0KPiA+DQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4g
PiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiBpbmRleCBmNzJl
YjYwOTc2OWIuLjBiMTY4ZjBkNTdiOCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250
cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9k
d2MvcGNpLWlteDYuYw0KPiA+IEBAIC03MTIsMTkgKzcxMiwxMCBAQCBzdGF0aWMgaW50IGlteDZf
cGNpZV9kZWFzc2VydF9jb3JlX3Jlc2V0KHN0cnVjdA0KPiBpbXg2X3BjaWUgKmlteDZfcGNpZSkN
Cj4gPiAgCXN0cnVjdCBkZXZpY2UgKmRldiA9IHBjaS0+ZGV2Ow0KPiA+ICAJaW50IHJldDsNCj4g
Pg0KPiA+IC0JaWYgKGlteDZfcGNpZS0+dnBjaWUpIHsNCj4gPiAtCQlyZXQgPSByZWd1bGF0b3Jf
ZW5hYmxlKGlteDZfcGNpZS0+dnBjaWUpOw0KPiA+IC0JCWlmIChyZXQpIHsNCj4gPiAtCQkJZGV2
X2VycihkZXYsICJmYWlsZWQgdG8gZW5hYmxlIHZwY2llIHJlZ3VsYXRvcjogJWRcbiIsDQo+ID4g
LQkJCQlyZXQpOw0KPiA+IC0JCQlyZXR1cm4gcmV0Ow0KPiA+IC0JCX0NCj4gPiAtCX0NCj4gPiAt
DQo+ID4gIAlyZXQgPSBpbXg2X3BjaWVfY2xrX2VuYWJsZShpbXg2X3BjaWUpOw0KPiA+ICAJaWYg
KHJldCkgew0KPiA+ICAJCWRldl9lcnIoZGV2LCAidW5hYmxlIHRvIGVuYWJsZSBwY2llIGNsb2Nr
czogJWRcbiIsIHJldCk7DQo+ID4gLQkJZ290byBlcnJfY2xrczsNCj4gPiArCQlyZXR1cm4gcmV0
Ow0KPiA+ICAJfQ0KPiA+DQo+ID4gIAlzd2l0Y2ggKGlteDZfcGNpZS0+ZHJ2ZGF0YS0+dmFyaWFu
dCkgeyBAQCAtNzgzLDE1ICs3NzQsNiBAQCBzdGF0aWMNCj4gPiBpbnQgaW14Nl9wY2llX2RlYXNz
ZXJ0X2NvcmVfcmVzZXQoc3RydWN0IGlteDZfcGNpZSAqaW14Nl9wY2llKQ0KPiA+ICAJfQ0KPiA+
DQo+ID4gIAlyZXR1cm4gMDsNCj4gPiAtDQo+ID4gLWVycl9jbGtzOg0KPiA+IC0JaWYgKGlteDZf
cGNpZS0+dnBjaWUpIHsNCj4gPiAtCQlyZXQgPSByZWd1bGF0b3JfZGlzYWJsZShpbXg2X3BjaWUt
PnZwY2llKTsNCj4gPiAtCQlpZiAocmV0KQ0KPiA+IC0JCQlkZXZfZXJyKGRldiwgImZhaWxlZCB0
byBkaXNhYmxlIHZwY2llIHJlZ3VsYXRvcjogJWRcbiIsDQo+ID4gLQkJCQlyZXQpOw0KPiA+IC0J
fQ0KPiA+IC0JcmV0dXJuIHJldDsNCj4gPiAgfQ0KPiA+DQo+ID4gIHN0YXRpYyBpbnQgaW14Nl9w
Y2llX3dhaXRfZm9yX3NwZWVkX2NoYW5nZShzdHJ1Y3QgaW14Nl9wY2llDQo+ID4gKmlteDZfcGNp
ZSkgQEAgLTkxNiwxNSArODk4LDI5IEBAIHN0YXRpYyBpbnQNCj4gPiBpbXg2X3BjaWVfaG9zdF9p
bml0KHN0cnVjdCBwY2llX3BvcnQgKnBwKQ0KPiA+DQo+ID4gIAlpbXg2X3BjaWVfYXNzZXJ0X2Nv
cmVfcmVzZXQoaW14Nl9wY2llKTsNCj4gPiAgCWlteDZfcGNpZV9pbml0X3BoeShpbXg2X3BjaWUp
Ow0KPiA+ICsJaWYgKGlteDZfcGNpZS0+dnBjaWUpIHsNCj4gPiArCQlyZXQgPSByZWd1bGF0b3Jf
ZW5hYmxlKGlteDZfcGNpZS0+dnBjaWUpOw0KPiA+ICsJCWlmIChyZXQpIHsNCj4gPiArCQkJZGV2
X2VycihkZXYsICJmYWlsZWQgdG8gZW5hYmxlIHZwY2llIHJlZ3VsYXRvcjogJWRcbiIsDQo+ID4g
KwkJCQlyZXQpOw0KPiA+ICsJCQlyZXR1cm4gcmV0Ow0KPiANCj4gSWYgdGhlIHJlZ3VsYXRvciBl
bmFibGUgZmFpbHMsIHlvdSBkb24ndCByb2xsIGJhY2sgdGhlIFBIWSBpbml0IGFuZCBjb3JlIHJl
c2V0LiBUaGlzDQo+IHNlZW1zIGhhcm1sZXNzIG5vdywgYnV0IG1pZ2h0IGhhdmUgdW5pbnRlbmRl
ZCBjb25zZXF1ZW5jZXMgaWYgdGhlIFBIWQ0KPiBjb2RlIGNoYW5nZXMuIEkgdGhpbmsgaXQgc2hv
dWxkIGJlIHNhZmUgdG8gbW92ZSB0aGUgcmVndWxhdG9yIGVuYWJsZSBiZWZvcmUgdGhlDQo+IFBI
WSBpbml0IGFuZCBjb3JlIHJlc2V0IGFzc2VydCB0byBhdm9pZCBpbnRyb2R1Y2luZyBtb3JlIGZh
aWx1cmUgY2xlYW51cCBwYXRocw0KPiBoZXJlLg0KVG8ga2VlcCB0aGUgc2FtZSBiZWhhdmlvciwg
SSBqdXN0IHBsYWNlIHRoZSByZWd1bGF0b3JfZW5hYmxlKCkgaW4gZnJvbnQgb2YNCiBpbXg2X3Bj
aWVfZGVhc3NlcnRfY29yZV9yZXNldCgpLiANCkl0IG1ha2VzIHNlbnNlIHRvIG1vdmUgaXQgZWFy
bGllciB0byBhdm9pZCB0aGUgcG9zc2libGUgZmFpbHVyZSBjbGVhbnVwIG9mDQogaW14Nl9wY2ll
X2Fzc2VydF9jb3JlX3Jlc2V0KCkgYW5kIGlteDZfcGNpZV9pbml0X3BoeSgpIGluIGZ1dHVyZS4N
Cg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkDQo+IA0KPiBSZWdhcmRzLA0KPiBMdWNhcw0KPiANCj4g
PiArCQl9DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICAJcmV0ID0gaW14Nl9wY2llX2RlYXNzZXJ0X2Nv
cmVfcmVzZXQoaW14Nl9wY2llKTsNCj4gPiAgCWlmIChyZXQgPCAwKSB7DQo+ID4gIAkJZGV2X2Vy
cihkZXYsICJwY2llIGRlYXNzZXJ0IGNvcmUgcmVzZXQgZmFpbGVkOiAlZFxuIiwgcmV0KTsNCj4g
PiAtCQlyZXR1cm4gcmV0Ow0KPiA+ICsJCWdvdG8gZXJyX3JlZ19kaXNhYmxlOw0KPiA+ICAJfQ0K
PiA+DQo+ID4gIAlpbXg2X3NldHVwX3BoeV9tcGxsKGlteDZfcGNpZSk7DQo+ID4NCj4gPiAgCXJl
dHVybiAwOw0KPiA+ICsNCj4gPiArZXJyX3JlZ19kaXNhYmxlOg0KPiA+ICsJaWYgKGlteDZfcGNp
ZS0+dnBjaWUpDQo+ID4gKwkJcmVndWxhdG9yX2Rpc2FibGUoaW14Nl9wY2llLT52cGNpZSk7DQo+
ID4gKwlyZXR1cm4gcmV0Ow0KPiA+ICB9DQo+ID4NCj4gPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBk
d19wY2llX2hvc3Rfb3BzIGlteDZfcGNpZV9ob3N0X29wcyA9IHsNCj4gDQoNCg==
