Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A236FA103
	for <lists+linux-pci@lfdr.de>; Mon,  8 May 2023 09:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbjEHH3R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 May 2023 03:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjEHH3Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 May 2023 03:29:16 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2046.outbound.protection.outlook.com [40.107.21.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6425F3;
        Mon,  8 May 2023 00:29:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZAe5mnXbsbzpthUeyMMzBfhr5to3piMLssFIscghjruUoOE5RAN7FRf4DPtuhlkVa/7eKFHkNeHfhnzDV0GPrFk2+J015e8wpOhGFWmHuoMYS8gjomx9D+ozqpXocAfXuHn/VNAy0PJ0zv2P/EQyf3+E1mpnDCuXMY59WFONQwqP6jwJ76p/qwPvGu8uQrf669reNNcK/g5/+Dnycg+rfUfhvIhR5ZWzeP3It4DA+ujcqngGRKaMeOTzyx62p661wraZWBYJmTO9Cl657p3eKNEdivNAKXv1cF2UaBAI2z6CPKwPwYdfajTDIKxtZmhgcSTVSmRh/n0U8rH8QKOANA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UEQ6JA1H5pFrVBqiIra4kDDtZOj8eLx0OhAv4i6/TRY=;
 b=Tq7+cNoEpw3LNkTTrfHsxpdOS1JNhhg+ZjAlF2Acj8/pHx7rE1C3b2BwJK1WC2biyMFa53gQ6kGXs3Uvg7d2nyj/tpQ6fIPnfBkz5sODwHRbtxPmQV1RWeTnAFknP5Mp+n5EbBxbIuV3lIDSrAnZFneve3yMi5AoCRd6CiCw7hwKW2mghJWqJrtBU4PlkcZPYgdQWRS6Sy/0iufoQNdHd7iNbkwSlj1vO5zkcIsr/YIyNdZrIRs19LG7HCxNpB3++OOddD/qj/YK/a4eR/kIRgDLXvznPIm7JcMDYG28UKxqSVuQuguqaq6RC6lbBIvqZ9BSQFLx695LjoxJYFbyKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UEQ6JA1H5pFrVBqiIra4kDDtZOj8eLx0OhAv4i6/TRY=;
 b=b8QSiB7jxXF8RS82jB/6Wm/CR3fWVtVtmEQE7cEqpGM/NJ839kh/jvuGLTCNg8P7xUA8MclvliLmkoH5/4ITnWjU8G/v/ax8NKaZPOZSVKf9mUwqWqKDNdZJDSGX31RVq4upLHpR2/lL/5KY1V9ezyslT6i0acrJn2oqDpstxNg=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS1PR04MB9429.eurprd04.prod.outlook.com (2603:10a6:20b:4db::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 07:29:11 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::242b:ff61:ac0e:bb05]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::242b:ff61:ac0e:bb05%5]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 07:29:11 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        Peng Fan <peng.fan@nxp.com>, "marex@denx.de" <marex@denx.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        Frank Li <frank.li@nxp.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [RESEND v10 1/4] dt-bindings: imx6q-pcie: Restruct i.MX PCIe
 schema
Thread-Topic: [RESEND v10 1/4] dt-bindings: imx6q-pcie: Restruct i.MX PCIe
 schema
Thread-Index: AQHZQQj5JSkQUx9DV0SmslS44COXC69QcHKAgAAKOwCAAAB8UA==
Date:   Mon, 8 May 2023 07:29:11 +0000
Message-ID: <AS8PR04MB86766374110153EF79C44AC88C719@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1676441915-1394-1-git-send-email-hongxing.zhu@nxp.com>
 <1676441915-1394-2-git-send-email-hongxing.zhu@nxp.com>
 <4853c769-e1ec-f2e7-aaf7-5b67a2cd6b5f@linaro.org>
 <8c7c69c1-33de-8634-4482-50f5dfcbf35d@linaro.org>
In-Reply-To: <8c7c69c1-33de-8634-4482-50f5dfcbf35d@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|AS1PR04MB9429:EE_
x-ms-office365-filtering-correlation-id: 49501484-31e8-441e-3f39-08db4f95eb34
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b3uhiX7NG7Uv8eci0WjBbE1QxQXfYbBwGlw6p5YW0MSvoRumv0lN7G8jmcYDEhYMfb6GSpsytgFVEQKkMQwFWeivvwL6kGyWOmoaba57PdmdBbhpOtCr65uri6c9kqJlKiVJBuwXxTq/qPkxtiIMYvIKp6C1n0DtqhLsfaKCGUUfQp1ZKeAEpx0IjMeHwoQ+v4Gkcx3m/GfCQdg0sRBN2lkz4o2CabS0u/VZF3jQhyzYCGNgcNIDfi5wcqn8iwcWkBR2zF6qqT3VyOU4M7bJgwilTmbyZ9Btz0jgiZYRViY1aCahMs4zIFMcPcX/I2SaqBYd2eVaBrnpEOZiTgONFQUU8Puo30tslTdd/ephBl+grzQE5gk0EwfvO8LSLknF/rjLRYBhRldvR4CnWClsOE0CuPjuFEN8JhchQt0gE838acZJ0XEWDRbSEeAtChs6nUIG1SwPoKke8gsquwpWohJLqHU8FtvzMzdwLdkxRW/R23SG3xHknTIH9o+WZFB7gYS/7FVKgRR+iRnexYJADXGhwpmkGbMrfl3NPm85ouMebzNz3drDfV6oj3PNfPmW+Aipf5Z0s8XPJKcMQmvG6XMK4RIX+J8DruNADYlYZfo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(396003)(39860400002)(376002)(451199021)(83380400001)(966005)(45080400002)(7696005)(478600001)(54906003)(71200400001)(110136005)(9686003)(6506007)(53546011)(186003)(44832011)(2906002)(7416002)(38100700002)(33656002)(52536014)(66946007)(76116006)(64756008)(6636002)(4326008)(122000001)(41300700001)(66446008)(66556008)(921005)(66476007)(8676002)(8936002)(38070700005)(55016003)(86362001)(5660300002)(316002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?aVNxYTdBKzFZaTA4UGJCY1VRc3d3Z1pQK0pmZUhYbDE5S2NGbWhPTndXWktT?=
 =?gb2312?B?TTNIYXl2V1NnY3NmWFd1YkRXMGpFTWF0Z0pua2lSRWVVeWh1eTlPTm5YeTky?=
 =?gb2312?B?aFlDc3ZnL1lmcy94Z3JIWUh1VXJkOVNqNXA2VDJDOE5QOXl5NGR3b2pYZ2dZ?=
 =?gb2312?B?VnFXUTltRE8vM2RyWmc5N1UrOEJFNHZqcGdYRkxsZkN0aU8rV2oyaFVDUDdt?=
 =?gb2312?B?ZTZhUmpuY3VlVmZQbkVLYUtkTDlBTjJiZ3FOOWxvR1lSUytuOUNNbXRyU0ZD?=
 =?gb2312?B?N1hJMGtSbktrRXRkeS9xM0YxTUJSeUU4d2EwN1E2R094NEZLWXdsK1N0UzJl?=
 =?gb2312?B?TFpOdVhNTTVaRkUxT3Z3NWRqVnFjelRZQzA5MkdTSUlMSEhERVJDcHJTTHN5?=
 =?gb2312?B?WTVGc3J0ZDBVTDhVQW9na0hjdWhaeWJLSDB1RVU5UDN6cHRudW5ub0g2L2VW?=
 =?gb2312?B?a1hCTzdXRm9SaEVuVGY5NWpkUkdPbFQ4cVY3Z2pNaUcxMHZWWG1UOUZPTWJV?=
 =?gb2312?B?L29lV1pNbWFtdk9TcjR6OCtWaFBVOE1memZadFdFbzNKNjlmOU9kRkZjdFAw?=
 =?gb2312?B?eUtzaTZIblA0anliRzV4ckZBOHN4VVovYVU5VWRldnFFbU5WbjRiUnowcmFM?=
 =?gb2312?B?cXVQMU9BaE42S3hlaVZsZGFaK2ZSTUxXY21CWUZBZWpSdW9lY1lpWHU4Sll4?=
 =?gb2312?B?c2ZOTmJwc2llVzJ5WHJibVBHSDNCM3NZaXlMeTRuKzgyOE5tYTdyU3R6WUpi?=
 =?gb2312?B?U3pNMFBqNEhDUXhwQWZabU9QdjN4aHp1ZDQ2cE5FMWJJTXZuMWdqSFEzSi9j?=
 =?gb2312?B?emhIbFJtbS9jZGsxaXRwQWVZSlVBVFpEWmorS3lWZmF5US9rQVh4QU5WeDZW?=
 =?gb2312?B?Tkt4cXpLbjkrQzQ1S2NUODBzNUZPTDhib3NESFEwZ0NyVWFSR1BIZXdJdDdZ?=
 =?gb2312?B?aTV0dkJwYm02WnZONGFBZUtJRmFrbVh4Vjd2SnZPZzRVVjNTdXdhTnp3WkRC?=
 =?gb2312?B?eXVsU3l1NEliZU42N1JhLzU3RExRQXpWOHplQWRxT1JYazZDczV4YVhxaVhs?=
 =?gb2312?B?RzY3d2U2c3VtL0lRUTZjVnpPc1RxMDU4VVNCV1BjOXRYVkJkK1F3T2c2NUFx?=
 =?gb2312?B?OFhsMXBBUmRITzBSYWZTUkp4NnJuMnpiRTJHcWkyUDBUVlpjdDYvbTVnTmVL?=
 =?gb2312?B?K25uV1k3akdlamxPd0JoOGhJcGJ2cmc0OStKQUhsQjRKQVlBMlB3TDRZK01N?=
 =?gb2312?B?MjEzekJ1YmZEVW9tQ1RwSW1ZSnRvdWVZQUI3KzYrZzdkZFlsUng5a1FIRUo2?=
 =?gb2312?B?MlJjQnkveGJjQjR3TjF0RVJVUUQwanArNEJISlNGUlByOGI1cmJkdjVNMGM5?=
 =?gb2312?B?bDE0VWRYTTZMR2F3eVJsM1JoVk5TQ3hmM0k4Y2NlcGV5U3ZRbHZPbW85R0RT?=
 =?gb2312?B?SU5wd2xhaEdHUTVyUGdwRHhpWXBQMnJ4dGttanRic1V3d3JWNmo0cFFlNVpk?=
 =?gb2312?B?R2FrNTMzYitoanRGYVBkY09NYXlINTFlbys4ZDQzZ0svRlkwWStYaVNSUmlM?=
 =?gb2312?B?VWF2b1hoSHFHMUNxTlMwV01YYnRzSTNZWGsvVlBmNFF5NEFRc20zZjlTRlpY?=
 =?gb2312?B?bUZ6VlVRRk1QYWdRZW9XRUlWMW01cFBXTVBVcXp6b3NrUU43OWljY3ZQdFJH?=
 =?gb2312?B?ZU5UYUxjTFB0M0pKZ3FNeFFEa0FPNWlRNjJYQWNLYzZxcDNGTnAyVkl0c2Jj?=
 =?gb2312?B?U0tEZHhGajVSUFJSd3FYMG9Gb2JnSFNIMlRCeDVhcTVaeENzU0hvTGZqT1ZI?=
 =?gb2312?B?enlFdm5ycGJsS29ESlloM1pDQnVBNHZkUlRELzlqVGxBVkE3OWpVamgxL0Fh?=
 =?gb2312?B?TkFGMzZBMjhPckdsRk9xZHJjMlNKZFV2Q2FrUjVKbWVGSXV1L0N3OVVWSjht?=
 =?gb2312?B?MzlxVXpNRkhiLzYyenFuSGQ0T1ZmN3A5dkk1NURMYi9OT29hQnF2cWJyZWdR?=
 =?gb2312?B?ZUZTQmJVR2xRSlgxTk43TG43VkxBWU90eEk0Um1LU3dLeU5vZHRaZVYxQ1JQ?=
 =?gb2312?B?VDRPeDh2OWRqNkRXRDl2Z1JGZ29rc0xzWm92QT09?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49501484-31e8-441e-3f39-08db4f95eb34
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2023 07:29:11.7402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9V+zViAyCPl+2f3KvgubLmrfwpHhZiUMAMKByLB9tXEXW0iHxlgD6hgTKW0bOoyFtHjqa4vJk1tsUW/vr/ymrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEtyenlzenRvZiBLb3psb3dz
a2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4gU2VudDogMjAyM8TqNdTCOMjV
IDE1OjI2DQo+IFRvOiBIb25neGluZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPjsgcm9iaCtk
dEBrZXJuZWwub3JnOw0KPiBrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc7IGwuc3Rh
Y2hAcGVuZ3V0cm9uaXguZGU7DQo+IHNoYXduZ3VvQGtlcm5lbC5vcmc7IGxvcmVuem8ucGllcmFs
aXNpQGFybS5jb207IFBlbmcgRmFuDQo+IDxwZW5nLmZhbkBueHAuY29tPjsgbWFyZXhAZGVueC5k
ZTsgTWFyY2VsIFppc3dpbGVyDQo+IDxtYXJjZWwuemlzd2lsZXJAdG9yYWRleC5jb20+OyB0aGFy
dmV5QGdhdGV3b3Jrcy5jb207IEZyYW5rIExpDQo+IDxmcmFuay5saUBueHAuY29tPg0KPiBDYzog
bGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+
IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsNCj4ga2VybmVsQHBlbmd1dHJvbml4LmRlOyBkbC1saW51eC1pbXggPGxpbnV4
LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1JFU0VORCB2MTAgMS80XSBkdC1iaW5kaW5n
czogaW14NnEtcGNpZTogUmVzdHJ1Y3QgaS5NWCBQQ0llDQo+IHNjaGVtYQ0KPg0KPiBPbiAwOC8w
NS8yMDIzIDA4OjQ5LCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPiA+IE9uIDE1LzAyLzIw
MjMgMDc6MTgsIFJpY2hhcmQgWmh1IHdyb3RlOg0KPiA+PiBSZXN0cnVjdCBpLk1YIFBDSWUgc2No
ZW1hLCBkZXJpdmUgdGhlIGNvbW1vbiBwcm9wZXJ0aWVzLCB0aHVzIHRoZXkNCj4gPj4gY2FuIGJl
IHNoYXJlZCBieSBib3RoIHRoZSBSQyBhbmQgRW5kcG9pbnQgc2NoZW1hLg0KPiA+Pg0KPiA+PiBV
cGRhdGUgdGhlIGRlc2NyaXB0aW9uIG9mIGZzbCxpbXg2cS1wY2llLnlhbWwsIGFuZCBtb3ZlIHRo
ZSBFUCBtb2RlDQo+ID4+IGNvbXBhdGlibGUgdG8gZnNsLGlteDZxLXBjaWUtZXAueWFtbC4NCj4g
Pj4NCj4gPj4gQWRkIHN1cHBvcnQgZm9yIGkuTVg4TSBQQ0llIEVuZHBvaW50IG1vZGVzLCBhbmQg
dXBkYXRlIHRoZSBNQUlOVEFJTkVSDQo+ID4+IGFjY29yZGluZ2x5Lg0KPiA+Pg0KPiA+PiBTaWdu
ZWQtb2ZmLWJ5OiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+ID4+IFJldmll
d2VkLWJ5OiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPg0KPiA+PiAtLS0NCj4gPj4gIC4u
Li9iaW5kaW5ncy9wY2kvZnNsLGlteDZxLXBjaWUtY29tbW9uLnlhbWwgICB8IDI3OQ0KPiArKysr
KysrKysrKysrKysrKysNCj4gPj4gIC4uLi9iaW5kaW5ncy9wY2kvZnNsLGlteDZxLXBjaWUtZXAu
eWFtbCAgICAgICB8ICA4NSArKysrKysNCj4gPj4gIC4uLi9iaW5kaW5ncy9wY2kvZnNsLGlteDZx
LXBjaWUueWFtbCAgICAgICAgICB8IDI0MCArLS0tLS0tLS0tLS0tLS0NCj4gPj4gIE1BSU5UQUlO
RVJTICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMiArDQo+ID4+ICA0IGZp
bGVzIGNoYW5nZWQsIDM3MiBpbnNlcnRpb25zKCspLCAyMzQgZGVsZXRpb25zKC0pDQo+ID4NCj4g
PiBUaGlzIGtlZXBzIHJlcG9ydGluZyBlcnJvcnMgc2luY2UgYSBtb250aCwgc28gSSB3b3VsZCBh
c3N1bWUgYXV0aG9yDQo+ID4gd291bGQgZml4IGhpcyBwYXRjaC4uLiBOb3cgZmFpbHVyZXMgYXJl
IGluIExpbnVzJyB2Ni40LXJjMS4NCj4NCj4gU2VudCBhIGZpeDoNCj4NCj4gaHR0cHM6Ly9sb3Jl
Lmtlcm4vDQo+IGVsLm9yZyUyRmFsbCUyRjIwMjMwNTA4MDcxODM3LjY4NTUyLTEta3J6eXN6dG9m
Lmtvemxvd3NraSU0MGxpbmFyby5vcmclDQo+IDJGJmRhdGE9MDUlN0MwMSU3Q2hvbmd4aW5nLnpo
dSU0MG54cC5jb20lN0NhMGY4ODk5MjQwZDE0NTRmMjQ1NQ0KPiAwOGRiNGY5NTg0YTQlN0M2ODZl
YTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM4MQ0KPiA5MTI3NTgxOTQy
MDc1NCU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUwNCj4gQ0pR
SWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdDMzAwMCU3QyU3QyU3
QyZzZA0KPiBhdGE9bCUyQlg4OTJBVk5NWktDTVA3VTM5TTRSdDZRb0NLUGp5N0g2UXdON3FBNjgw
JTNEJnJlc2VydmUNCj4gZD0wDQoNClNvcnJ5LCBJIGp1c3Qgbm90aWNlIHRoaXMuIFdvdWxkIGdp
dmUgbXkgcmV2aWV3ZWQtYnkgaW4gYW5vdGhlciBtYWlsLWxvb3AuDQoNCkJlc3QgUmVnYXJkcw0K
UmljaGFyZCBaaHUNCj4NCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K
