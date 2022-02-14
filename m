Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2FC4B40FE
	for <lists+linux-pci@lfdr.de>; Mon, 14 Feb 2022 05:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbiBNEwh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 13 Feb 2022 23:52:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233318AbiBNEwg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 13 Feb 2022 23:52:36 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70053.outbound.protection.outlook.com [40.107.7.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF0750E36;
        Sun, 13 Feb 2022 20:52:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qm7WETDFbio7ZI7XrSEm9RtP4r5z3veOevAXBKOaERSFiWXcm1TrmUuGe4Y0+NFKcd4qbiCS4uF3X86/2bNU3AQBank1PmLPOXHXFaLbPqIFAyuhHpdk6arW4EbaIoeg+IoM2CQXzxplTeZ/wuiD6yxisjtHBZLL39KAhVNA5pzGRPhavvVUA8s8of0bakWwV7TPFj81IHFsKVovdFc4UgpiY+9hMcGMNoyUH3TwdffPEBsaejqgkNP7HY28NTQOYkR7a7YdeW/MxevCkpx405S0EdSL4bCAOkJyF/TtcsLLMuJQBlANxNt68zgZFRJ8t7Sl4F6t8rNzwS9PpYpwFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hgB+06BdG9jH/nlEmeGtJHFpbYYRWqRy/bA/NG4hS3k=;
 b=UMunvIF4OOv6kd0wWgL3RY8rpt26eJjhVhDpL6Ywvsr4A9YEfpBaRc2yrR0y1KPgXLyol9RxTUh3PSxt5NhZjZAT9D+eH23CT2CKtop4tJFopPsJtCpSpJXxjlOfM5PeWtylbbV8t/fwnJFR6taPzVvKurWp6Dztw11Y8aQVPwjimd9Vj7rz+VRQFJuqp7qdF65mdYf9iXhCTUV65eYVnqEHlb6OnzVcjPlkKJdoVQqae2cbBBH6QkfDXVSnqwxJSYWvS8U5hu5DxrWaJdE+OPqdR8z7Vt6E1mxradY27P7gavjoSRcIIh/Ik0Kc4G+2olDZJssyy42YPHWiguDC1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgB+06BdG9jH/nlEmeGtJHFpbYYRWqRy/bA/NG4hS3k=;
 b=DGUDPOZNAFF/evqD5o/PxMfU7CNflfN8QwO9ZO/jDiz+YQnEyimFiYTikhFNSJZObkUfQjb113i+On91AnNMvbQ3AU9TekrUpb4Pf2cz1MZlVlWC8ZGtl2CQcHas8ZNftEdt3gQ9/r/V/tia0pjskubq209CubUXPjPj5PYZcW8=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by VI1PR04MB5599.eurprd04.prod.outlook.com (2603:10a6:803:de::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Mon, 14 Feb
 2022 04:52:25 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::3d1c:b479:1c58:199]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::3d1c:b479:1c58:199%7]) with mapi id 15.20.4975.018; Mon, 14 Feb 2022
 04:52:25 +0000
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
Thread-Index: AQHYHJ/uzu66Zs8raEChP5mwivzPZ6yOj2gAgAPHxTCAACicgA==
Date:   Mon, 14 Feb 2022 04:52:25 +0000
Message-ID: <AS8PR04MB8676706D379F3B66D486D2358C339@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1644290735-3797-1-git-send-email-hongxing.zhu@nxp.com>
 <1644290735-3797-6-git-send-email-hongxing.zhu@nxp.com>
 <20220211162758.GA287827@francesco-nb.int.toradex.com>
 <AS8PR04MB8676479F3B292252F3A7406E8C339@AS8PR04MB8676.eurprd04.prod.outlook.com>
In-Reply-To: <AS8PR04MB8676479F3B292252F3A7406E8C339@AS8PR04MB8676.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c401dbd-355b-4abd-b6cd-08d9ef75cb65
x-ms-traffictypediagnostic: VI1PR04MB5599:EE_
x-microsoft-antispam-prvs: <VI1PR04MB55996E5F5D6CEA5E0939DF538C339@VI1PR04MB5599.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z1HTz9Qev/yjQnQhMjpNRVodNB2Ir+cLxDqGEEN7xB+RlNc4dwI2avO6dIJBvbBy7BWcK3pqWD6QwP0SnxmCF/o0YjLcuOuX9rykaq0DDaAftU13+pqYn5CBoia1q55wYf1SW/2j64IaVzLb9/4wug/VXQD1P1JRgBxGpAX+/7XObnucXJVPsrHHjM19AbBX7WQWrI+9pV9eqkVgchmqr6im0ts4jLHZSh63R8TQvj/fFE7bDJ5Aq/ZGD8SlQtelarXingoB3mg1NvEXPYajFCF8tBVvL6xk9qKW5pC1Ab2++mGZngF2kTphP9pH8Ow6kyklwTTnvEmMrjJaoba0kI6XI9QudCcQfgoDuMj0pGnyk60PgcdOs9oqo2bkaixAQFXvb+7ccen5RgMCXnoiZNkrvO1d5WIrzzpAfIv0TQwaaaBoe5RydruZPIuX4SzUh1sR//8t6JCs5oxo0PknzKmYTAV23ggmmmfzkx2IXAebEkcXAULw8IP/PK0SbiaxAcOYVkJV3KsiWCEw+iVegrHk1I1Dqxk18ldGp4bZ3iXH+B9TcNbblTKnX5mbH3Y7Lm3d+q2+bXB1m5X5OCtKWws4zox+G5TWW6bY8mxngmYg/1LYgb0JwOTcVjjx37jICP5mCkeApmWf8bh2Yr5EnOUrNgSK95SC/DGmLRVJT5EkV8nOrpGSzp+A0uSACkG8IY0vhe5CNNxiUhqUfg9E+A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(26005)(44832011)(2906002)(38070700005)(54906003)(122000001)(508600001)(55016003)(38100700002)(71200400001)(9686003)(53546011)(7696005)(8936002)(7416002)(316002)(5660300002)(52536014)(33656002)(6916009)(83380400001)(76116006)(8676002)(2940100002)(64756008)(4326008)(6506007)(66946007)(66476007)(66556008)(86362001)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?SE9qSUx5UEk3Y0Ztb0tBVXhnaFJFeS9pejlqZW5EWnBtY1lZWDdRcXFBdjdq?=
 =?gb2312?B?YVFwbnlRQlJqMGovem9aZXF3Q1hyNkhqN3F6alRmaWxjTmNqak1kcy9RSUZk?=
 =?gb2312?B?UGtlV255SzF1Wk56enF2d24xejRkZnJNMEpKSGVyUG9qTUZYVUI2ZHgwSUJv?=
 =?gb2312?B?UkRoazRaaU0xamNVekV3Qkp4cmQrYUdYK0p0cFVkOW85MThaUmNlSk9WVEx1?=
 =?gb2312?B?OWFVbzhWUjV2Z2t4RDlmYTNudjRtWVBZemMyWlhuLzlDNzIyU1N4MXhVR3pa?=
 =?gb2312?B?YWFBeExWdlJ1ajhjYlQ4bGVlbGVXUmwrd3JWUENuVmY2MmVDQzE3Z2pYN1pU?=
 =?gb2312?B?aXh6RURHMDA4Kzd1Mmk4aWJteHpDQWdrb0x6Skt2dkUyejF3MjlvYllyanNv?=
 =?gb2312?B?QmJNNzhRRTlzMlBQSzdPNE9WSCttZVlMVlJwclY2UzhhTFNXNkFyaVhZZC85?=
 =?gb2312?B?L1cwQ2x4N29QS2ErbTF1cnB4dHVJOWIzZ3gyZk0rdmRFYVJwdlZJc2I2U3pz?=
 =?gb2312?B?UzRLRFh0U3hUM1lZOS9OVG5Xem8vMXlvV3ZrL05UR3RPRHFhWGRXZURjaWll?=
 =?gb2312?B?RkNsRm1pL2svNUdScVNxUmR4b2t1VWZ1dFZzdnR5R05jS1dTUGkyMVNsY1B4?=
 =?gb2312?B?b3NmR0lRQzhrUWt4YlkwNGozVzNMaEViNjNxNTF4WHEzU09KRDZxM09UamVT?=
 =?gb2312?B?WWNibFUwZGc2UXZGRHJMNWsvNVpONHlzN1l1VXN4d29Oc1JIcG1WZ3M3bEQ5?=
 =?gb2312?B?bE5nVlMzek8zWmNhdWpzZXlBU2NHNGVDNHAvU3BNTW9RT1FYWnE0enlBbEl4?=
 =?gb2312?B?Q0xMallra1NPMzVQYXdsdWlXSU5sQXRka21CUFVRU1VTeWxrZGpzVUlGT05x?=
 =?gb2312?B?Nm9ZejhTbnRGNC93MERENDl5bGt6OE9rWHJUWFdMc3FWd3dPR2J0ZnBKSlRy?=
 =?gb2312?B?Y1JaNHZidXpBQUdGY1dUQnF3Mlltb2NqZlY0Nkp6NjZDaEtreDBVSVNldXhi?=
 =?gb2312?B?cGJHWEtUTUduRThTSEZrWmJmVUtmUXVpVE1hV0Y4SUJNQ3V2ZGhTeHM5Y0Vz?=
 =?gb2312?B?cVhGR3l4WlE0MGt0OWNJbHU4clI3Z294c3MrN1BTQ1JUMi9rWWFwdHdTejhQ?=
 =?gb2312?B?dEJRS2dFem5PWlhFdHRFM3VVWUVVK2lvTEgrMjlrWjg0ZEo2SEVSR3FwYTQx?=
 =?gb2312?B?U29pT1hBNFgrQjNJbFhROUN2Q1o2bnduazFoNVJYMFJkb0x1ZlZaYi9LTkR1?=
 =?gb2312?B?SGp1VExkazZJYm13VUREbW5JS0RZdXFwYTJac1V3dzRKRXpaWGtGSFhsa2Zv?=
 =?gb2312?B?TXZNeHA3RjdYc1FqZ2srK2pESi82QUdNT3FWQXlBbEkyQlU5ZXlBeHF3VS9N?=
 =?gb2312?B?eVRWRlE2bFI2ejZmNEtONzl6NkN2NDRoVmxhbWEybkp5TXZNbW9leFd0bjZ2?=
 =?gb2312?B?UHRKOEVlUVBOL3VaMWFqbGZDdngwSXVzcWdUc00rY2F3SzJpMVl0ODJWclpL?=
 =?gb2312?B?UE52VG83MnhDbE55Sjl0RHNiazBTY0gwN0NiTFBwVm9JNS9qalpsQWdqR0ty?=
 =?gb2312?B?aVk4M3FvdlFHRmNOcWVpZXBVNzRBa0EydmZScVVCTE1OYy8rTWZNT21uWS96?=
 =?gb2312?B?VFRjckhDN3RPYVovYitLSW9seStOMzU5NGcvY1dnQ1EzZ2t4NmZKNmJJS1ZK?=
 =?gb2312?B?aVBWVWRub04vayttaGhxdnFhdDRxbmlsbHMwTnVxZ0M1S01sT29GeDFjY05i?=
 =?gb2312?B?Z0xkUCtLSVdSbEFxQ2Q1WVA4dWk4K0NrL0xSSWlSc3BuQ21oQ2VNOE4rWnVV?=
 =?gb2312?B?OXh0b240SVcyZUZ5djh3VnAyNUJaYzdCb3lHZWR1eC9aNmFCdytVQjlYakFp?=
 =?gb2312?B?Tjg1STRPVkFkcXM1SnFYQngrVDg1aCtSTWdlN2xMVklFc056Q2pqbU9hQnFQ?=
 =?gb2312?B?aVpwOHBISGNTdXNKd3FOWUthbVRVbG5RakJsNi9FakFRc1VNU1p3WjlhVkV2?=
 =?gb2312?B?dURlNStxcGEzdTV0MGU5a05tWjJNaVkzem4ybUQ5ckNhdmQvc3hyTS94ZWdE?=
 =?gb2312?B?eEx6R0JrSy81dEIyK2RidXRsZlFCSUZ5TUxaOHpjT0lRTkZoL3B4VTc4bnhv?=
 =?gb2312?B?N0RPbEdCZngxbEFvSE9ObmtvbkRPbFhzUE55WVBnSjRHSU82MTdodkI0TVZp?=
 =?gb2312?B?UEE9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c401dbd-355b-4abd-b6cd-08d9ef75cb65
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2022 04:52:25.1819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3jrDabnY3qEd/DF54b7+49zz+eauAZzD4Ex+/9vcjtj7wJeR87ALz6/lIuMOH7A98wbATQ4LKOeWtL7XnaklUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5599
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIb25neGluZyBaaHUNCj4gU2Vu
dDogMjAyMsTqMtTCMTTI1SAxMTowOA0KPiBUbzogRnJhbmNlc2NvIERvbGNpbmkgPGZyYW5jZXNj
by5kb2xjaW5pQHRvcmFkZXguY29tPg0KPiBDYzogbC5zdGFjaEBwZW5ndXRyb25peC5kZTsgYmhl
bGdhYXNAZ29vZ2xlLmNvbTsgYnJvb25pZUBrZXJuZWwub3JnOw0KPiBsb3JlbnpvLnBpZXJhbGlz
aUBhcm0uY29tOyBqaW5nb29oYW4xQGdtYWlsLmNvbTsgZmVzdGV2YW1AZ21haWwuY29tOw0KPiBs
aW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29t
PjsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOw0KPiBrZXJuZWxAcGVuZ3V0cm9uaXguZGUNCj4gU3ViamVjdDogUkU6
IFtQQVRDSCB2NiA1LzhdIFBDSTogaW14NjogUmVmaW5lIHRoZSByZWd1bGF0b3IgdXNhZ2UNCj4g
DQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBGcmFuY2VzY28gRG9s
Y2luaSA8ZnJhbmNlc2NvLmRvbGNpbmlAdG9yYWRleC5jb20+DQo+ID4gU2VudDogMjAyMsTqMtTC
MTLI1SAwOjI4DQo+ID4gVG86IEhvbmd4aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+
ID4gQ2M6IGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU7IGJoZWxnYWFzQGdvb2dsZS5jb207IGJyb29u
aWVAa2VybmVsLm9yZzsNCj4gPiBsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tOyBqaW5nb29oYW4x
QGdtYWlsLmNvbTsgZmVzdGV2YW1AZ21haWwuY29tOw0KPiA+IGxpbnV4LXBjaUB2Z2VyLmtlcm5l
bC5vcmc7IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+Ow0KPiA+IGxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsN
Cj4gPiBrZXJuZWxAcGVuZ3V0cm9uaXguZGUNCj4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHY2IDUv
OF0gUENJOiBpbXg2OiBSZWZpbmUgdGhlIHJlZ3VsYXRvciB1c2FnZQ0KPiA+DQo+ID4gSGVsbG8g
UmljaGFyZCwNCj4gPg0KPiA+IE9uIFR1ZSwgRmViIDA4LCAyMDIyIGF0IDExOjI1OjMyQU0gKzA4
MDAsIFJpY2hhcmQgWmh1IHdyb3RlOg0KPiA+ID4gVGhlIGRyaXZlciBzaG91bGQgdW5kbyBhbnkg
ZW5hYmxlcyBpdCBkaWQgaXRzZWxmLiBUaGUgcmVndWxhdG9yDQo+ID4gPiBkaXNhYmxlIHNob3Vs
ZG4ndCBiZSBiYXNpbmcgZGVjaXNpb25zIG9uIHJlZ3VsYXRvcl9pc19lbmFibGVkKCkuDQo+ID4g
Pg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29t
Pg0KPiA+ID4gLS0tDQo+ID4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYu
YyB8IDE0ICsrLS0tLS0tLS0tLS0tDQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9u
cygrKSwgMTIgZGVsZXRpb25zKC0pDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiA+IGIvZHJpdmVycy9wY2kvY29udHJv
bGxlci9kd2MvcGNpLWlteDYuYw0KPiA+ID4gaW5kZXggMGFjYTc2MmQ4OGEzLi5lMTY1YWQwMDk4
OWMgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14
Ni5jDQo+ID4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+
ID4gPiBAQCAtMzY5LDggKzM2OSw2IEBAIHN0YXRpYyBpbnQgaW14Nl9wY2llX2F0dGFjaF9wZChz
dHJ1Y3QgZGV2aWNlDQo+ID4gPiAqZGV2KQ0KPiA+ID4NCj4gPiA+ICBzdGF0aWMgdm9pZCBpbXg2
X3BjaWVfYXNzZXJ0X2NvcmVfcmVzZXQoc3RydWN0IGlteDZfcGNpZQ0KPiA+ID4gKmlteDZfcGNp
ZSkgew0KPiA+ID4gLQlzdHJ1Y3QgZGV2aWNlICpkZXYgPSBpbXg2X3BjaWUtPnBjaS0+ZGV2Ow0K
PiA+ID4gLQ0KPiA+ID4gIAlzd2l0Y2ggKGlteDZfcGNpZS0+ZHJ2ZGF0YS0+dmFyaWFudCkgew0K
PiA+ID4gIAljYXNlIElNWDdEOg0KPiA+ID4gIAljYXNlIElNWDhNUToNCj4gPiA+IEBAIC00MDAs
MTQgKzM5OCw2IEBAIHN0YXRpYyB2b2lkIGlteDZfcGNpZV9hc3NlcnRfY29yZV9yZXNldChzdHJ1
Y3QNCj4gPiBpbXg2X3BjaWUgKmlteDZfcGNpZSkNCj4gPiA+ICAJCQkJICAgSU1YNlFfR1BSMV9Q
Q0lFX1JFRl9DTEtfRU4sIDAgPDwgMTYpOw0KPiA+ID4gIAkJYnJlYWs7DQo+ID4gPiAgCX0NCj4g
PiA+IC0NCj4gPiA+IC0JaWYgKGlteDZfcGNpZS0+dnBjaWUgJiYgcmVndWxhdG9yX2lzX2VuYWJs
ZWQoaW14Nl9wY2llLT52cGNpZSkgPiAwKSB7DQo+ID4gPiAtCQlpbnQgcmV0ID0gcmVndWxhdG9y
X2Rpc2FibGUoaW14Nl9wY2llLT52cGNpZSk7DQo+ID4gPiAtDQo+ID4gPiAtCQlpZiAocmV0KQ0K
PiA+ID4gLQkJCWRldl9lcnIoZGV2LCAiZmFpbGVkIHRvIGRpc2FibGUgdnBjaWUgcmVndWxhdG9y
OiAlZFxuIiwNCj4gPiA+IC0JCQkJcmV0KTsNCj4gPiA+IC0JfQ0KPiA+DQo+ID4gVGhpcyBjb21t
aXQgaXMgbm90IGp1c3QgY2xlYW5pbmcgdXAgdGhlIHJlZ3VsYXRvciB1c2FnZSBhcyB5b3Ugc3Rh
dGUNCj4gPiBpbiB0aGUgY29tbWl0IG1lc3NhZ2UsIHRoaXMgaXMgcmVtb3ZpbmcgdGhlIHZwY2ll
IHJlZ3VsYXRvcl9kaXNhYmxlDQo+ID4gZnJvbSBpbXg2X3BjaWVfYXNzZXJ0X2NvcmVfcmVzZXQo
KS4NCj4gPg0KPiA+IEkgd291bGQgbm90IGRvIGl0LCB0aGlzIGlzIGNhbGxlZCBmb3IgZXhhbXBs
ZSBvbiB0aGUgc2h1dGRvd24gY2FsbGJhY2sNCj4gPiB3aGVyZSBpdCBtYWtlcyBzZW5zZS4NCj4g
SGkgRnJhbmNlc2NvOg0KPiBUaGFua3MgZm9yIHlvdXIgcmV2aWV3Lg0KPiBEbyB5b3UgbWVhbnMg
dGhhdCB3ZSBzaG91bGQga2VlcCByZWd1bGF0b3JfZGlzYWJsZSgpIGhlcmU/DQo+IE9rYXksIEkg
d291bGQgY2hhbmdlIGl0IGxhdGVyLg0KSGkgRnJhbmNlc2NvOg0KT25lIG1vcmUgY29tcGxlbWVu
dGFyeSB0aGF0IHdlIGNhbid0IGRpc2FibGUgdGhpcyByZWd1bGF0b3IgaGVyZSwgYmVjYXVzZQ0K
IHRoYXQgdGhlIHJlZ3VsYXRvciBtaWdodCBub3QgYmUgZW5hYmxlZCBhdCBhbGwuDQoNCkJ1dCBp
biB0aGUgY2FzZSBvZiBzdXNwZW5kL3Jlc3VtZSBvcGVyYXRpb25zLCB0aGUgcmVndWxhdG9yX2Rp
c2FibGUoKSBzaG91bGQNCiBiZSBpbnZva2VkIGJlaGluZCBvZiBpbXg2X3BjaWVfYXNzZXJ0X2Nv
cmVfcmVzZXQgKCkgaW4gcmVzdW1lIGNhbGxiYWNrIHRvDQogYmFsYW5jZSB0aGUgZW5hYmxlL2Rp
c2FibGUgdXNhZ2UgY291bnRlci4NCkkgd291bGQgYWRkIHRoaXMgY2hhbmdlIGxhdGVyLg0KVGhh
bmtzIGFnYWluIGZvciB5b3VyIHJldmlldyBjb21tZW50cy4NCg0KQmVzdCBSZWdhcmRzDQpSaWNo
YXJkDQo+IA0KPiBCZXN0IFJlZ2FyZHMNCj4gUmljaGFyZCBaaHUNCj4gDQo+ID4NCj4gPiBGcmFu
Y2VzY28NCg0K
