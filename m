Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB21A4D7A57
	for <lists+linux-pci@lfdr.de>; Mon, 14 Mar 2022 06:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236158AbiCNF1V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Mar 2022 01:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234664AbiCNF1U (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Mar 2022 01:27:20 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70057.outbound.protection.outlook.com [40.107.7.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1551DF21;
        Sun, 13 Mar 2022 22:26:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lnUYwjNWuliBD0Ce2fJaCpnAucC25TSCmd4J4+F2RFnptUkZlEHGVkE2vWnLKC6wNm1zpqoTuNlDsbR2Hx54l6s4ee+wJtu8vbO0kOxWgH4s0fBWA2sUGtaSZkb+66lgV8w4yFsgs4myAPIrpkH1uguXgBdUkgAKOffBUziCeFTcer1jZ90Ntx8LMzGlpA4OE94aBP1EDlBAqJbAnBQ4KskR/T/6O4B6eFjsGz3vkphhRglwFHfgv8nUlHLgAVWmuzIjloZEEWDmpLYB2kd+iFAFDAoWL1m66qZTMFmcH4bzhY/qygtPuhpaGqtmFr9VDpOciK/r7593SU4cYSlZGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pBt3A6RvdXScTi1m9vBUN/Uk9ZP7OIBDHMp2a2mXB+E=;
 b=BB976o3wLBqRVLdK0ynz/Iubs3cLqqCpjK2n7BbmT2obYUVk8ZXmhUjxnJqDFUKbtxGDx9VqszP0MVeuIk/y7racbKXhIO95K7L5PepAxlUKS20hdTvYN/hNfmhFuXoPuLUA94O4/ceNhPJqdXEGazevHtPCs4w5VKhJ67QtB2biisKxKEFtiRQ74p4/HTgeMxZm9mFtSVSZf6z4/Ljmjq4HR5jiSjIrDhlQy41kCfHqHNUuKuJJSjZ8pamH7OMRCtLK629c7i42WEq5m2Az2EePRP8FLVJVbaDe5zN5IqrjP7Wp4jh8yNms56EZg/uVo6beY52j6jLE5f5YLeUfdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBt3A6RvdXScTi1m9vBUN/Uk9ZP7OIBDHMp2a2mXB+E=;
 b=ODjXLHVVt6N8DqXdNGNutqGShDoiA1C/dO7LLIYkPnn4oCsM2TVxSCYpUfArICiXp18ep9P+xe+jqhPv0vpEda3Dv3W5CK6elfIkgFrNgfixgOtcbYdb0Rq4IZ/7OkQ8z0ta+uFgeZ9fxaGc8auErdT8DVSnTVzVlKDT/5z3MR8=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM9PR04MB8337.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.28; Mon, 14 Mar
 2022 05:26:06 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::f4f1:fe49:d19e:4770]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::f4f1:fe49:d19e:4770%9]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 05:26:06 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Hongxing Zhu <hongxing.zhu@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "francesco.dolcini@toradex.com" <francesco.dolcini@toradex.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v8 0/8] PCI: imx6: refine codes and add compliance tests
 mode support 
Thread-Topic: [PATCH v8 0/8] PCI: imx6: refine codes and add compliance tests
 mode support 
Thread-Index: AQHYKfsrRRIbYVuh5Ey5cmRW5VhbQay+cqtQ
Date:   Mon, 14 Mar 2022 05:26:06 +0000
Message-ID: <AS8PR04MB8676681E7DD647788F070FB48C0F9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1645760667-10510-1-git-send-email-hongxing.zhu@nxp.com>
In-Reply-To: <1645760667-10510-1-git-send-email-hongxing.zhu@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f5298fb7-5c6f-40e2-744f-08da057b23a1
x-ms-traffictypediagnostic: AM9PR04MB8337:EE_
x-microsoft-antispam-prvs: <AM9PR04MB83370AA070ECCDC9826F98208C0F9@AM9PR04MB8337.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i18RlV6GpX9yqSZKwt52Jzdzc/jcQvcmCfeLAXApNSUHCcfQ0tDyz0uF+7WxfeaVr8gI+bLTK5Wa0dJGpyIzWRMfAxvMpcbEagbSycRB3ufWnnjJ4qO6gbsJF86kY24PQAMTgScC5YRazKk+bKLMRq5ZmQgXOZV4Sn5c/xPeViielkO5gssuqI2/EqUrpTEDocFnYCevQOUFcCK64uxIT4T1tkJ5X5j9D7OtibmWUzUuo03IUhp+6pCw9YqlfvH0+fEvFap41TjXU9oq6+GvGzGrakEzVg2zQtOJc6e701g4GzaVbRElFIRR2VBgV5DLZFgbxM4JRrDSSwmXs2hZp97mcMdXKIXsvWVFHILoZSsBiYIuTNjgj/xctGIZOQohO226ESkBSJ7x2ecvw8woohSfnkN1sgtoaTuFru4q165daCt9ZJ04bDYtZ4oiCmbf/jh+ObYyr8jGa15SxSPRqTlz01uPhjR6YYa33o6R2qqk3TBPRJssickUIo4zwMbhSVXBf9yPiP8uC/ygk1iZUUjBUPUioyUtRf0lupIixgZfLLQxa/4nEVWhor07m3Ayo9yfdHwraRaqeQk7Ya0d0x2Xjv515afw9XDiyE9K2ejjG8KY+QBgiHfIN9ysUKXCaPkZzCR8xktGmavfVmJhfx68GWkvObdQI21d/Bzu47/DFbKAAcOPC9SlH3HgNz+S3VuxBYiIjhynKOijSOWqCadpA0WIyaSDHeKVWphlEYeCQ6VMnLyloErDXRIfPX/I9MQDaxtYkHBMKHGBQquN1o+rI1iQKL2QKczjeeKHAHE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(84040400005)(53546011)(66476007)(7696005)(4326008)(6506007)(9686003)(4743002)(66946007)(64756008)(38100700002)(76116006)(8676002)(55016003)(66556008)(122000001)(2906002)(66446008)(186003)(26005)(45080400002)(83380400001)(54906003)(498600001)(110136005)(966005)(52536014)(44832011)(38070700005)(71200400001)(33656002)(86362001)(8936002)(7416002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?UWFieVF5Y2UrTittUFJuS0gxMklZc2JlNVduWWZ1VDE4RWhVV2JVcVZsZVlE?=
 =?gb2312?B?eXBQR1c0cmlHTk9nbnE3Q2cwYlQ0b0lIUXdUS0RyL0dxSGNUOGFOTHdZN2pa?=
 =?gb2312?B?RVJySnVacTViQkxNRlRnbHd6TDR3YU1rZlU4YTlUeTBocE1oZ3pHNzZwVHk2?=
 =?gb2312?B?TzJ6VFR3SDYxTE5aRjFuUU1FVnFYUjAyQ1BnNDZrT3M1UDFoYWhNSXdSVFhn?=
 =?gb2312?B?MEtnMnlNUzFNZkl6c1FKSWo4UzJnaWs2YUk1NFpneFd2cEx2THlNa295YjJQ?=
 =?gb2312?B?N05tbjBBZ1ZMc0Z2TTlhU1pqRFVWUHpxZWpmNmhKaG42b00yTTZQT0p4ekx4?=
 =?gb2312?B?cldBb2hJVTJNQlB4SWFaOElNWjNqWGFnL1lUV25JcWFRZFp6eitRMFpBaFBs?=
 =?gb2312?B?RDByOGZxd1I3Z2VuNmR1U0M3QU40Y1VFOVBPaHY5WlRPOXpNQllFamlpbDNP?=
 =?gb2312?B?cXl5aGpCTStDYkU3SXZyNkh6QklxdnJvbWw3Y0VSUjNvR09RUHdjSnBlWTZB?=
 =?gb2312?B?K3YvWXdRSWtkREo5dmxxZklpSVpWc1piQldOUitXQ3hRSkRwanlHZ1d3aUpm?=
 =?gb2312?B?dEU0UjhTemtTWENPWU9tL1lVSitmMlkrbE9udmlsS21DUEZ4Uzh0N09qamtt?=
 =?gb2312?B?RnNPVTJTd01mSmVLeTNUNDdwVEFDcitWVUVIQ01RMTh2WVVjMWdDcXpjZFRh?=
 =?gb2312?B?TFA3VkRScXpmYVdzbURYRjdkMkI3T3o1N0ZsaEFwYVBzVWI1MUREZGJJbStq?=
 =?gb2312?B?WlNMd1FDdVJVcHNvdUhCTDhsSzJ4dWVzbnN1ZUtGUVE1T3lidXNmRFdEMy92?=
 =?gb2312?B?aTBvY0xaYVNuYmJSSExlU3g4WFh2bUtmK2pOZmhnZ3R5RFR6R2pabjRCYXox?=
 =?gb2312?B?NHpUajJUUHF3dWwvREtoVHdWZ0RIN21zMzhlNzYwR1h6b3RNYXgrSkx1ekx0?=
 =?gb2312?B?YTRmSkp2TmlqUFV2N1lXOXA2dUZBS2F2Z1pyVHRZUC93N1gzeVR6ZnJIaUJp?=
 =?gb2312?B?UkpEL3FTVkJhWUtLNTFjR0g4STFqcDNuYVVOOXpaMEQycXZwZmdwR2FGZ1pR?=
 =?gb2312?B?RXRTdWk5VDRPa0NiSmd5R0d6NWNvUE9jRHBycFZsdE54aDIrZUxpQW9ic0Fj?=
 =?gb2312?B?aDdBbkxadnNYVlVwRFZkZjRSazRvT0JhL2toT1lhWklPTC8rME4vVTZybGxp?=
 =?gb2312?B?YllpdXc2RHlNT1F3K1VEWlBCd05LYmc1cXh5TXRzVy90clpTaU9wZGhNTzRO?=
 =?gb2312?B?K2kwMkNRbWhiQWZLVSs0VlA5SGhTWFgyVTNEVGkxWWgvclQwOVJoSWIwNTZa?=
 =?gb2312?B?RENtbFhkLzlkYjFubko4OFRyN0FaVHpuUExSV1d1eEtNSFdHWWlFVkQrdzl4?=
 =?gb2312?B?ZmRYbWhLQzZtSUxIUWJKbzhZamhuNmMvQ1VOK051aGgxdGJFRzJ2SkNDNDNp?=
 =?gb2312?B?RDdoa3RxOUJkN1pzSk1XaU5JSEI2MjBveW5Md3BrMHhmOTVuSEVDMTZRQkdh?=
 =?gb2312?B?RmpMUEJ1Zy9wZTVvVlppWVNROFhWRFZ6S09ybkVPUjViT3k3UStOM0JSckdL?=
 =?gb2312?B?NkxITWdBVnpOMFVuT3JULzJaODJaeGVtVmtpOStlTFJWTTZwZDdFU21sZjRE?=
 =?gb2312?B?ekpFSnVTNy82eU5XakZUM1ZNS1paV2dpK3RpMkxEc0dSZHJoQ0dvNjhmb2FQ?=
 =?gb2312?B?cTF0VU1NN0JRUTdFekVZVWl2NlB2SkFmVGxkUjZ1aU42MXFDUU1MREU4YXpw?=
 =?gb2312?B?N0djTkZ4VG90bmJuMWJscmErYjhjM2Q4cTNSODFDT2NlR3BGS2xVWHZjTDNr?=
 =?gb2312?B?Mm01VU9zMEh6MHYrSjFJVjltOG9ZVm0ybEptcERBQkttbXlXdlZGZ2k5N0JO?=
 =?gb2312?B?QjFNekFYM3NsQ0R1VWxJM29FN2pLV1g4ZDRiTjNHNE1RUXBrMzhYTnc3eFoy?=
 =?gb2312?Q?P0unDQwYdXDQ+K9AjRJaKZGmHcN8CknY?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5298fb7-5c6f-40e2-744f-08da057b23a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2022 05:26:06.2309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 15IWbzE9Dbjx6v4sJRjHCdm5LTEpHRCsB296o2TgymSUCqluI4c+92k5pLont4HKNWjD1UKqvjhW691RZ8I7Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8337
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgTHVjYXM6DQpTaW5jZSB0aGlzIHY4IHNlcmllcyBwYXRjaGVzIGFyZSBwZW5kaW5nIGZvciBh
IHdoaWxlLCBhbmQgbm8gcmV2aWV3IGNvbW1lbnRzIGFueW1vcmUuDQpDYW4geW91IGhlbHAgdG8g
dGFrZSBsb29rIGF0IHRoZSBvdGhlciBwYXRjaGVzIG9mIHRoaXMgc2V0Pw0KDQpCZXN0IFJlZ2Fy
ZHMNClJpY2hhcmQgWmh1DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog
UmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiBTZW50OiAyMDIyxOoy1MIyNcjV
IDExOjQ0DQo+IFRvOiBsLnN0YWNoQHBlbmd1dHJvbml4LmRlOyBiaGVsZ2Fhc0Bnb29nbGUuY29t
OyBicm9vbmllQGtlcm5lbC5vcmc7DQo+IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207IGppbmdv
b2hhbjFAZ21haWwuY29tOyBmZXN0ZXZhbUBnbWFpbC5jb207DQo+IGZyYW5jZXNjby5kb2xjaW5p
QHRvcmFkZXguY29tDQo+IENjOiBIb25neGluZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPjsg
bGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBrZXJuZWxAcGVuZ3V0
cm9uaXguZGU7IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+DQo+IFN1YmplY3Q6IFtQ
QVRDSCB2OCAwLzhdIFBDSTogaW14NjogcmVmaW5lIGNvZGVzIGFuZCBhZGQgY29tcGxpYW5jZSB0
ZXN0cw0KPiBtb2RlIHN1cHBvcnQNCj4gDQo+IFRoaXMgc2VyaWVzIHBhdGNoZXMgcmVmaW5lIHBj
aS1pbXg2IGRyaXZlciBhbmQgZG8gdGhlIGZvbGxvd2luZyBjaGFuZ2VzLg0KPiAtIEVuY2Fwc3Vs
YXRlIHRoZSBjbG9jayBlbmFibGUgaW50byBvbmUgc3RhbmRhbG9uZSBmdW5jdGlvbg0KPiAtIEFk
ZCB0aGUgZXJyb3IgcHJvcGFnYXRpb24gZnJvbSBob3N0X2luaXQNCj4gLSBEaXNhYmxlIHRoZSBy
ZWd1bGF0b3JzIGFuZCBjbG9ja3Mgd2hlbiBsaW5rIG5ldmVyIGNvbWVzIHVwDQo+IC0gQWRkIHRo
ZSBjb21wbGlhbmNlIHRlc3RzIG1vZGUgc3VwcG9ydA0KPiANCj4gTWFpbiBjaGFuZ2VzIGZyb20g
djcgdG8gdjg6DQo+IFJlZ2FyZGluZyBCam9ybidzIHJldmlldyBjb21tZW50cy4NCj4gLSBBbGln
biB0aGUgZm9ybWF0IG9mIHRoZSBkZXZfaW5mbyBtZXNzYWdlIGFuZCByZWZpbmUgY29tbWl0IGxv
ZyBvZg0KPiAgICM2LzcvOCBwYXRjaGVzLg0KPiAtIFJlbmFtZSB0aGUgZXJyX3Jlc2V0X3BoeSBs
YWJlbCwgc2luY2UgdGhlcmUgaXMgbm8gUEhZIHJlc2V0IGluIHRoZSBvdXQuDQo+IA0KPiBNYWlu
IGNoYW5nZXMgZnJvbSB2NiB0byB2NzoNCj4gLSBLZWVwIHRoZSByZWd1bGF0b3IgdXNhZ2UgY291
bnRlciBiYWxhbmNlIGluIHRoZSAjNSBwYXRjaCBvZiB2NiBzZXJpZXMuDQo+IA0KPiBNYWluIGNo
YW5nZXMgZnJvbSB2NSB0byB2NjoNCj4gLSBSZWZlciB0byB0aGUgZm9sbG93aW5nIGRpc2N1c3Np
b24gd2l0aCBGYWJpbywgZml4IHRoZSBkdW1wIGJ5IGhpcyBwYXRjaC4NCj4gDQo+IGh0dHBzOi8v
ZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUy
RnBhdGNodw0KPiBvcmsua2VybmVsLm9yZyUyRnByb2plY3QlMkZsaW51eC1wY2klMkZwYXRjaCUy
RjE2NDEzNjg2MDItMjA0MDEtNi1naXQtcw0KPiBlbmQtZW1haWwtaG9uZ3hpbmcuemh1JTQwbnhw
LmNvbSUyRiZhbXA7ZGF0YT0wNCU3QzAxJTdDaG9uZ3hpbmcueg0KPiBodSU0MG54cC5jb20lN0Mx
MDA3NzI3OThiZWQ0NGVjMzYyZjA4ZDlmODEyNGQ5YyU3QzY4NmVhMWQzYmMyYg0KPiA0YzZmYTky
Y2Q5OWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM3ODEzNTc5NzUzMzMxMzcwJTdDVW5rbm93biUNCj4g
N0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJ
NklrMWhhV3dpDQo+IExDSlhWQ0k2TW4wJTNEJTdDMzAwMCZhbXA7c2RhdGE9bTRYaExnTzBlN0gx
TXpTMUtQc2tXaEsxTGMxZw0KPiB1VXF6WXB1ZHJMMDNwQ1ElM0QmYW1wO3Jlc2VydmVkPTANCj4g
ICBSZWZpbmUgYW5kIHJlYmFzZSB0aGlzIHBhdGNoLXNldCBhZnRlciBGYWJpbycgZHVtcCBmaXgg
cGF0Y2ggaXMgbWVyZ2VkLg0KPiAtIEFkZCBvbmUgbmV3ICM0IHBhdGNoIHRvIGRpc2FibGUgaS5N
WDZRREwgUkVGIGNsb2NrIHRvbyB3aGVuIGRpc2FibGUgY2xvY2tzDQo+IC0gU3BsaXQgdGhlIHJl
Z3VsYXRvciByZWZpbmUgY29kZXMgaW50byBvbmUgc3RhbmRhbG9uZSBwYXRjaCAjNSBpbiB0aGlz
IHZlcnNpb24uDQo+IA0KPiBNYWluIGNoYW5nZXMgZnJvbSB2NCB0byB2NToNCj4gLSBTaW5jZSBp
Lk1YOE1NIFBDSWUgc3VwcG9ydCBoYWQgYmVlbiBtZXJnZWQuIEJhc2VkIG9uIExvcmVuem8ncyBn
aXQgcmVwb3MsDQo+ICAgcmVzZW5kIHRoZSBwYXRjaC1zZXQgYWZ0ZXIgcmViYXNlLg0KPiANCj4g
TWFpbiBjaGFuZ2VzIGZyb20gdjMgdG8gdjQ6DQo+IC0gUmVnYXJkaW5nIE1hcmsncyBjb21tZW50
cywgZGVsZXRlIHRoZSByZWd1bGF0b3JfaXNfZW5hYmxlZCgpIGNoZWNrLg0KPiAtIFNxdWFzaCAj
MyBhbmQgIzYgb2YgdjMgcGF0Y2ggaW50byAjNSBwYXRjaCBvZiB2NCBzZXQuDQo+IA0KPiBNYWlu
IGNoYW5nZXMgZnJvbSB2MiB0byB2MzoNCj4gLSBBZGQgIlJldmlld2VkLWJ5OiBMdWNhcyBTdGFj
aCA8bC5zdGFjaEBwZW5ndXRyb25peC5kZT4iIHRhZyBpbnRvDQo+ICAgZmlyc3QgdHdvIHBhdGNo
ZXMuDQo+IC0gQWRkIGEgRml4ZXMgdGFnIGludG8gIzMgcGF0Y2guDQo+IC0gU3BsaXQgdGhlICM0
IG9mIHYyIHRvIHR3byBwYXRjaGVzLCBvbmUgaXMgY2xvY2sgZGlzYWJsZSBjb2RlcyBtb3ZlLA0K
PiAgIHRoZSBvdGhlciBvbmUgaXMgdGhlIGFjdXRhbCBjbG9jayB1bmJhbGFuY2UgZml4Lg0KPiAt
IEFkZCBhIG5ldyBob3N0X2V4aXQoKSBjYWxsYmFjayBpbnRvIGR3X3BjaWVfaG9zdF9vcHMsIHRo
ZW4gaXQgY291bGQgYmUNCj4gICBpbnZva2VkIHRvIGhhbmRsZSB0aGUgdW5iYWxhbmNlIGlzc3Vl
IGluIHRoZSBlcnJvciBoYW5kbGluZyBhZnRlcg0KPiAgIGhvc3RfaW5pdCgpIGZ1bmN0aW9uIHdo
ZW4gbGluayBpcyBkb3duLg0KPiAtIEFkZCBhIG5ldyBob3N0X2V4aXQoKSBjYWxsYmFjayBmb3Ig
aS5NWCBQQ0llIGRyaXZlciB0byBoYW5kbGUgdGhpcyBjYXNlDQo+ICAgaW4gdGhlIGVycm9yIGhh
bmRsaW5nIGFmdGVyIGhvc3RfaW5pdC4NCj4gDQo+IE1haW4gY2hhbmdlcyBmcm9tIHYxIHRvIHYy
Og0KPiBSZWdhcmRpbmcgTHVjYXMnIGNvbW1lbnRzLg0KPiAgIC0gTW92ZSB0aGUgcGxhY2VtZW50
IG9mIHRoZSBuZXcgaW14Nl9wY2llX2Nsa19lbmFibGUoKSB0byBhdm9pZCB0aGUNCj4gICAgIGZv
cndhcmQgZGVjbGFyaXRpb24uDQo+ICAgLSBTZXBlcmF0ZSB0aGUgc2Vjb25kIHBhdGNoIG9mIHYx
IHBhdGNoLXNldCB0byB0aHJlZSBwYXRjaGVzLg0KPiAgIC0gVXNlIHRoZSBtb2R1bGVfcGFyYW0g
dG8gcmVwbGFjZSB0aGUga2VybmVsIGNvbW1hbmQgbGluZS4NCj4gUmVnYXJkaW5nIEJqb3JuJ3Mg
Y29tbWVudHM6DQo+ICAgLSBVc2UgdGhlIGNvdmVyLWxldHRlciBmb3IgYSBtdWx0aS1wYXRjaCBz
ZXJpZXMuDQo+ICAgLSBDb3JyZWN0IHRoZSBzdWJqZWN0IGxpbmUsIGFuZCByZWZpbmUgdGhlIGNv
bW1pdCBsb2dzLiBGb3IgZXhhbXBsZSwNCj4gICAgIHJlbW92ZSB0aGUgdGltZXN0YW1wIG9mIHRo
ZSBsb2dzLg0KPiANCj4gZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYyAgICAg
ICAgICAgICB8IDIyMw0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKystLQ0KPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
DQo+IGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS1ob3N0LmMgfCAg
IDUgKystDQo+IGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5oICAg
ICAgfCAgIDEgKw0KPiAzIGZpbGVzIGNoYW5nZWQsIDE1MCBpbnNlcnRpb25zKCspLCA3OSBkZWxl
dGlvbnMoLSkNCj4gDQo+IFtQQVRDSCB2OCAxLzhdIFBDSTogaW14NjogRW5jYXBzdWxhdGUgdGhl
IGNsb2NrIGVuYWJsZSBpbnRvIG9uZSBbUEFUQ0ggdjggMi84XQ0KPiBQQ0k6IGlteDY6IEFkZCB0
aGUgZXJyb3IgcHJvcGFnYXRpb24gZnJvbSBob3N0X2luaXQgW1BBVENIIHY4IDMvOF0gUENJOiBp
bXg2Og0KPiBNb3ZlIGlteDZfcGNpZV9jbGtfZGlzYWJsZSgpIGVhcmxpZXIgW1BBVENIIHY4IDQv
OF0gUENJOiBpbXg2OiBEaXNhYmxlDQo+IGlNWDZRREwgUENJZSBSRUYgY2xvY2sgd2hlbiBkaXNh
YmxlIFtQQVRDSCB2OCA1LzhdIFBDSTogaW14NjogUmVmaW5lIHRoZQ0KPiByZWd1bGF0b3IgdXNh
Z2UgW1BBVENIIHY4IDYvOF0gUENJOiBkd2M6IEFkZCBkd19wY2llX2hvc3Rfb3BzLmhvc3RfZXhp
dCgpDQo+IGNhbGxiYWNrIFtQQVRDSCB2OCA3LzhdIFBDSTogaW14NjogRGlzYWJsZSBjbG9ja3Mg
YW5kIHJlZ3VsYXRvcnMgYWZ0ZXIgbGluayBpcw0KPiBbUEFUQ0ggdjggOC84XSBQQ0k6IGlteDY6
IEFkZCBjb21wbGlhbmNlIHRlc3RzIG1vZGUgc3VwcG9ydA0K
