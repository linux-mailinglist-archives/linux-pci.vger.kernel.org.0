Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3EE504C13
	for <lists+linux-pci@lfdr.de>; Mon, 18 Apr 2022 06:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234620AbiDRE6a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Apr 2022 00:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbiDRE63 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Apr 2022 00:58:29 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00071.outbound.protection.outlook.com [40.107.0.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CC59FD5;
        Sun, 17 Apr 2022 21:55:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=llxHnkzIDA770cwIbnMq1oCHZGr0u6KRgmX519e+Ma6duJHHjb7q+c7ylLh4R+Ou4CYAeuHEBhiw/K6JpgV5Ml6gMLrpb4FGZnPwu8bS6rvoE4XB+xf0YHpGI5MCXeQW+eKpWdcTI86l8jx9nJn3V7aLrlaBhnPgpnPg/1s15y4/jpE+QiifXTucTmBbK/+D9NCfg/O4j0h6Hol5sYW27GTM+sLiqhVGcj1nqWAMmJICtqxqg0ebIGxI0pliTjnos/izSarsKB92x3n4Ca8x5XhvqQxRc8eKiY22G0tM7IuPWESQV2Aezfv3t4KSCRQXwT/eahxcx+/NV+jHc2qwQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8WhQ8wv/kvceJNbjUG+CeTC6Zup0Bpdeb+vr6jzw0xA=;
 b=k9p9k8Hd9+jfUSdQkUnLHyQDcg28OUzr7rN5mqcYZEo2Tf9YgCi9Bna2J/mArZIo/fulPzMkmZFjTah11d7iDeV680N5pvug6/Wpz7JRyaH4NObFxwUmjQHVC88euKKQ+HUz2Dwo9193GjRgrWRa7e/UBa9i7r2drTp1mCWRBI2hEIOCUag7Wd6TscC2kvBV0X56JItPySwUGJF/3g78NU+VTjCKiQWxYqIDtEaAcrX+IUb/HCzjsKW5KtPmDNzHipbWQGk83f/WN5qrLlIvy1YjC4HuFFijZrATZFwxuT/JiJ9HohkzMnAp0L2MNfYUaHqnV36n2xqaB/N5zojBYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WhQ8wv/kvceJNbjUG+CeTC6Zup0Bpdeb+vr6jzw0xA=;
 b=O0RjNsvBwvUz8o1e3IMrouoEKQEA9m/Kv1okB2O6TZMwNGjvnPdN8EdzUX2kE55k2KKs7GJn4cAWZRKicB85yOHuPu23bMnTA0vQhfwRfLbilF+Gtvp1r2xR4PlTTui8XfgKwUr+M7ajgEKYq/wzCGFdi6WnQzk9Ii83ihFvheY=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DBBPR04MB6266.eurprd04.prod.outlook.com (2603:10a6:10:ce::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Mon, 18 Apr
 2022 04:55:49 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::ecea:cb09:5ff2:1800]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::ecea:cb09:5ff2:1800%5]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 04:55:49 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>
CC:     "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v2 6/7] arm64: dts: imx8mp-evk: Add PCIe support
Thread-Topic: [PATCH v2 6/7] arm64: dts: imx8mp-evk: Add PCIe support
Thread-Index: AQHYMgQOjiRgAbocuEmOYPQXoupihazwIneAgAUuH/A=
Date:   Mon, 18 Apr 2022 04:55:49 +0000
Message-ID: <AS8PR04MB86768CC849A35D5B1EF75DEE8CF39@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1646644054-24421-1-git-send-email-hongxing.zhu@nxp.com>
         <1646644054-24421-7-git-send-email-hongxing.zhu@nxp.com>
 <542969d58ad05c496ae19256f87ea217eb9b7642.camel@pengutronix.de>
In-Reply-To: <542969d58ad05c496ae19256f87ea217eb9b7642.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d4a86e39-3111-43e5-793d-08da20f7b4f3
x-ms-traffictypediagnostic: DBBPR04MB6266:EE_
x-microsoft-antispam-prvs: <DBBPR04MB62664ABA24DCD4FB53624E3F8CF39@DBBPR04MB6266.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iIFazrfTwIsyWVf+6m1K31TjRZs6Op9PPqe/M+Pqm/1f3K/xM0L3lOrbsJJV5uMhwPgeK11cTuC7VhtHKGKPGxpAVyWcaMVMBqAyny1vjwc4uVVxtvwZ+JwLqxjUE1ptuU2LrHnrTgN3AqahaLAAMXoucpKcobsrncLYJX3jP3Af2HHEV8KKMy4Jc6s0kF3G0yD6ta+kSE3kmh7aHwjqudX7B8cayU/VM3j9W+V4gM4T6Py/Wf4C3nnNclpP8N26oJCONaVWf6jqi2k/Of0aW2GFU2ezlRKM22UpO7zdwjRl0e73pWFlrBTwue6p3b5VWKnnv81yKGfGBQqpssIhnz6oaGUrarcisxNY8jLPFszgtAJrQ3uxdBBWDLkgbLdVypIO6RB79guW6OfRp8BEW3GJ+ZnKdt90ouxEVQG7wwmEJEyCc+Jc081j/RJGLcEPV6X/O2kxbIJlwYqYd0EwDDjNbAkmFVGVHN7w5SUz+m4KIF+gceh1CWnJQTSUcxqJQOrf4nliv+td1eQMq7YJcSOaBsCjjRlhlFWA+0pOaE0Shcp5syXWu8NLUY7+wM1Uaxj8z+UKFv0tSaOS0yAmKDqVfsPz8z/pJfiQLTZTfd6SD3AaAVmwhezroRusv5Cskrw9FhYwfhS58IoXNFGzPn9MMOQOXY7xmpHfbawv6SQL8hVCsBjj84SHkB93OUoJ193zB7s3twSYS+INa6YkC3AONBko9ugvu+SSDGnHyp8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(53546011)(86362001)(7696005)(186003)(122000001)(8936002)(33656002)(4326008)(8676002)(26005)(9686003)(38100700002)(38070700005)(83380400001)(6506007)(52536014)(44832011)(7416002)(66556008)(66476007)(66446008)(64756008)(66946007)(76116006)(5660300002)(55016003)(2906002)(54906003)(110136005)(71200400001)(316002)(508600001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0xCSjdNVVZ0bVVlL21WdVQ3RVRqeEt5STdyTFZkMmdhRW1LeUJVTDhwYWpU?=
 =?utf-8?B?cXpCTHRQbURnTm4zSGVvSGFyRGdVZVB5YjNEZXNkRXFLdTJNNTV1QSs0MExO?=
 =?utf-8?B?KzQ2M3AySWE1S3h5Z1FkMklBbmFpNWEyOUJUdUtLZ1NwYjdkN3dlOGpNS0pC?=
 =?utf-8?B?WjFGWGd1UXhjeFl6bnk5VEYxTHFaWHVtKys1c0VOMXBINUFDRGJmelg1dmFz?=
 =?utf-8?B?YkpzQmNjNlBCRXRZSFVYbVVUSWVUMWt0b0RnR1FndWd6aFk2d3c1U2x6MHIz?=
 =?utf-8?B?aUtKQ1c0SVNuc2dXVnp6M2h0dy9oK0t2WURmM0VYMGtZRVB0UjZPY3Q2Q3lv?=
 =?utf-8?B?UmFhRTE1cU1xdml0dk11Q3hzd00zQkhid0NYTWNjM2hnUlUrZXVkU0FLVjJZ?=
 =?utf-8?B?MkJSOTkyOHpYK093azcwMWlGdWdVNmRJQ2p6VTNHdHlTQzNqREdOb09kZWlV?=
 =?utf-8?B?QW0zWnhDNkJFMGYxWVBQSlVxeDJkUlBjTUJFYmx5NlpoTXA4ZDdBVE9EdVpD?=
 =?utf-8?B?enU4V1ZmL3ErU3RHSG1QWHdQYnpDQTRqZzZxNUtMM2xGdElqU2E1RDJaMHJP?=
 =?utf-8?B?UnozN21sTzQ3N1lBeUtMdTZzUE56cXByS0c0ZFJLR2xLRHhsbmRjWEdnUC82?=
 =?utf-8?B?WXkycmRLQXpSSkNXaWpIck4xTFhzQU51MTk5L2t2bElCRGltYjJzSnJ5WkRZ?=
 =?utf-8?B?ak1rbkhTUGQ1aWFRSStUSk5WZG9Uc1ZZMERNSm9UUi9keFNFMG9LejFnYk1z?=
 =?utf-8?B?SjNISXNmOElJN012Myt0WmY1OHJua3ZhZW5mZ1Y5Z0JoMGIyMjhPNGI2Y1dr?=
 =?utf-8?B?RnJwaUhmT2xTdk81M3pLeTVFcVZ5RFNIeTJoOGp0T0h2VUp4b3U5S0hucE01?=
 =?utf-8?B?NFJOeHVYM1JTamI0RmZLUnVZVVdXazhtczdCMFREVHBtYlBqTGVWTWhOUHVW?=
 =?utf-8?B?RDh6Z3puZG1pSldwSzVYc3FIL25Ec0NSVDZmWHZvYXh2S0QxbW9KZnAwZUdp?=
 =?utf-8?B?OWZaVEN5RmkvVURiWEVuMVFXbHdxOTR2ZUt5YmFZc05wYkh1NldVY2xQQ2tk?=
 =?utf-8?B?T1RGVDcrUU4zcVl5TlVZUGVTQisrc1J1ZkxEcm9ZMG1DdmZDeTcyeFBEK05r?=
 =?utf-8?B?ZmhOQTZaMmw1WmpEbU5CbU93bXNZUHdzeGp0ZDZWa21QeTBnaDBRVG0vd3NP?=
 =?utf-8?B?WFJYZkNZZnFoTW9xUlRXQzRoWDlZTnRaaElpVjYzVUo2QXc3OXhwV0VtdzR5?=
 =?utf-8?B?VldpOUhhVjYwSHFiamQwTVN4UlRwT1pwWHV2UkpUcXhkSkI3ajN0Mm1kY1pZ?=
 =?utf-8?B?TFhxcWJJU0J2VGdjRGFzemRwSWkzdC9VdTZMbVNxb0s0K1ZEN2h1VXpqY2h6?=
 =?utf-8?B?RDU2dGc3U09mc0NZYy9zQkE4aDVuSEljaHlVK3VxenAwZWdMMDB3UmJRYld4?=
 =?utf-8?B?VDlRclpQQzRQUkY4TUJlRXJsWDF4eldkWE54MlpFaUhCa3ZLaHQ1UkxyOUlN?=
 =?utf-8?B?bFFsbXUxQ0tTWWhkZkFKS1kvQ015WWIzaEoySlVRVEtGL1Rwa3RZc24yTlFO?=
 =?utf-8?B?b3IwOVo0TTgvMndVL3M3bldvTzdLUVVWZ041cFZ5ZytaekIwdmhQaWV2UW1r?=
 =?utf-8?B?Y0dnajc3UVNDQzI3YlFkRWhjd2wxMXlaSDhrWm1PVXZvSi84a0J3K3hpaXZ5?=
 =?utf-8?B?T3psR1NXeE9ieW5RdUtuUjJkYUNGdmhpYWkzcm9XS0JqVk9yckJwdUhsc2k3?=
 =?utf-8?B?RGFTRkNiQkxpZHBYamoxUWgwTlpxN2hHalBCTCtRNS9PeFg1WFAxZFdWSW5q?=
 =?utf-8?B?cTFPdmlCM3V0a1RzL3Njd3B4bFp5bXVNZU8zUE53SEZ6TklpNHZPMkZGZHR4?=
 =?utf-8?B?ZnRVczV0ZDhnc1o0UTdjNzVtK2tKeVNmbXBaWlE1MzhCV2dMdEdWaHlJZnVv?=
 =?utf-8?B?YlBDSXpxcTNDSTZmVTNVbHNnNUdkYTNXRmdhTVZSUVRuTWhZd3hzS0FPLzZT?=
 =?utf-8?B?ZFlmTlZjWVJ1NGNyR2FDRmUrSDVuQ2VWQU5wUGxibWtQVkc0TlVna085QmRh?=
 =?utf-8?B?VGVtRm8wS0crZ3l6RWlBVCt1L3dBNVNvK0J3YUdsVEkxblpXQkhMRU9ILzNC?=
 =?utf-8?B?TzUzTnZWaklObnJjWGZ5WDdRcVc4ZVdKVWpHaXRoOU5zOHd0Q3JKN3l6NjVx?=
 =?utf-8?B?NlNQRW9ndVBiZ2RSL1dDUjIyUDBvSjNSdEFBQW9KNlJVRStoS1haNml1b1Yx?=
 =?utf-8?B?WG01RWdodUxIeUg5NW5qbWZoaWx4YmR3ZnFtWmV3NDV4VWRIb2w1eW04VFR0?=
 =?utf-8?B?RWw2L1JiNFRCUkNIdllXTVlBaVEvMmZlOXZ5clZXK24xWnh6L0p5Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4a86e39-3111-43e5-793d-08da20f7b4f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2022 04:55:49.0275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: akQkncXj7tmQtvTD4yKyyO0Pgw+9oMRCuUEbLgxUf1NhVEA07JlDIhWhPlJR6vFWJj25i0kzPOsjYBArLMoKcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB6266
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMdWNhcyBTdGFjaCA8bC5zdGFj
aEBwZW5ndXRyb25peC5kZT4NCj4gU2VudDogMjAyMuW5tDTmnIgxNeaXpSA1OjA1DQo+IFRvOiBI
b25neGluZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPjsgcC56YWJlbEBwZW5ndXRyb25peC5k
ZTsNCj4gYmhlbGdhYXNAZ29vZ2xlLmNvbTsgbG9yZW56by5waWVyYWxpc2lAYXJtLmNvbTsgcm9i
aEBrZXJuZWwub3JnOw0KPiBzaGF3bmd1b0BrZXJuZWwub3JnOyB2a291bEBrZXJuZWwub3JnOyBh
bGV4YW5kZXIuc3RlaW5AZXcudHEtZ3JvdXAuY29tDQo+IENjOiBsaW51eC1waHlAbGlzdHMuaW5m
cmFkZWFkLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LXBjaUB2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsga2VybmVsQHBlbmd1dHJvbml4LmRlOyBkbC1saW51
eC1pbXgNCj4gPGxpbnV4LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDYv
N10gYXJtNjQ6IGR0czogaW14OG1wLWV2azogQWRkIFBDSWUgc3VwcG9ydA0KPiANCj4gQW0gTW9u
dGFnLCBkZW0gMDcuMDMuMjAyMiB1bSAxNzowNyArMDgwMCBzY2hyaWViIFJpY2hhcmQgWmh1Og0K
PiA+IEFkZCBQQ0llIHN1cHBvcnQgb24gaS5NWDhNUCBFVksgYm9hcmQuDQo+ID4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+ID4gLS0tDQo+
ID4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcC1ldmsuZHRzIHwgNTUNCj4g
PiArKysrKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNTUgaW5zZXJ0aW9u
cygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxl
L2lteDhtcC1ldmsuZHRzDQo+ID4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4
bXAtZXZrLmR0cw0KPiA+IGluZGV4IDJlYjk0MzIxMDY3OC4uZWQ3NzQ1NWEzZjczIDEwMDY0NA0K
PiA+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcC1ldmsuZHRzDQo+
ID4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1wLWV2ay5kdHMNCj4g
PiBAQCAtNSw2ICs1LDcgQEANCj4gPg0KPiA+ICAvZHRzLXYxLzsNCj4gPg0KPiA+ICsjaW5jbHVk
ZSA8ZHQtYmluZGluZ3MvcGh5L3BoeS1pbXg4LXBjaWUuaD4NCj4gPiAgI2luY2x1ZGUgImlteDht
cC5kdHNpIg0KPiA+DQo+ID4gIC8gew0KPiA+IEBAIC0zMyw2ICszNCwxMiBAQCBtZW1vcnlANDAw
MDAwMDAgew0KPiA+ICAJCSAgICAgIDwweDEgMHgwMDAwMDAwMCAwIDB4YzAwMDAwMDA+Ow0KPiA+
ICAJfTsNCj4gPg0KPiA+ICsJcGNpZTBfcmVmY2xrOiBwY2llMC1yZWZjbGsgew0KPiA+ICsJCWNv
bXBhdGlibGUgPSAiZml4ZWQtY2xvY2siOw0KPiA+ICsJCQkjY2xvY2stY2VsbHMgPSA8MD47DQo+
ID4gKwkJCWNsb2NrLWZyZXF1ZW5jeSA9IDwxMDAwMDAwMDA+Ow0KPiA+ICsJfTsNCj4gPiArDQo+
ID4gIAlyZWdfY2FuMV9zdGJ5OiByZWd1bGF0b3ItY2FuMS1zdGJ5IHsNCj4gPiAgCQljb21wYXRp
YmxlID0gInJlZ3VsYXRvci1maXhlZCI7DQo+ID4gIAkJcmVndWxhdG9yLW5hbWUgPSAiY2FuMS1z
dGJ5IjsNCj4gPiBAQCAtNTUsNiArNjIsMTcgQEAgcmVnX2NhbjJfc3RieTogcmVndWxhdG9yLWNh
bjItc3RieSB7DQo+ID4gIAkJZW5hYmxlLWFjdGl2ZS1oaWdoOw0KPiA+ICAJfTsNCj4gPg0KPiA+
ICsJcmVnX3BjaWUwOiByZWd1bGF0b3ItcGNpZSB7DQo+ID4gKwkJY29tcGF0aWJsZSA9ICJyZWd1
bGF0b3ItZml4ZWQiOw0KPiA+ICsJCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+ID4gKwkJ
cGluY3RybC0wID0gPCZwaW5jdHJsX3BjaWUwX3JlZz47DQo+ID4gKwkJcmVndWxhdG9yLW5hbWUg
PSAiTVBDSUVfM1YzIjsNCj4gPiArCQlyZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDwzMzAwMDAw
PjsNCj4gPiArCQlyZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDwzMzAwMDAwPjsNCj4gPiArCQln
cGlvID0gPCZncGlvMiA2IEdQSU9fQUNUSVZFX0hJR0g+Ow0KPiA+ICsJCWVuYWJsZS1hY3RpdmUt
aGlnaDsNCj4gPiArCX07DQo+ID4gKw0KPiA+ICAJcmVnX3VzZGhjMl92bW1jOiByZWd1bGF0b3It
dXNkaGMyIHsNCj4gPiAgCQljb21wYXRpYmxlID0gInJlZ3VsYXRvci1maXhlZCI7DQo+ID4gIAkJ
cGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4gPiBAQCAtMjk3LDYgKzMxNSwzMCBAQCBwY2E2
NDE2OiBncGlvQDIwIHsNCj4gPiAgCX07DQo+ID4gIH07DQo+ID4NCj4gPiArJnBjaWVfcGh5IHsN
Cj4gPiArCWZzbCxyZWZjbGstcGFkLW1vZGUgPSA8SU1YOF9QQ0lFX1JFRkNMS19QQURfSU5QVVQ+
Ow0KPiA+ICsJY2xvY2tzID0gPCZwY2llMF9yZWZjbGs+Ow0KPiA+ICsJY2xvY2stbmFtZXMgPSAi
cmVmIjsNCj4gPiArCXN0YXR1cyA9ICJva2F5IjsNCj4gPiArfTsNCj4gPiArDQo+ID4gKyZwY2ll
ew0KPiA+ICsJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4gPiArCXBpbmN0cmwtMCA9IDwm
cGluY3RybF9wY2llMD47DQo+ID4gKwlyZXNldC1ncGlvID0gPCZncGlvMiA3IEdQSU9fQUNUSVZF
X0xPVz47DQo+ID4gKwljbG9ja3MgPSA8JmNsayBJTVg4TVBfQ0xLX0hTSU9fUk9PVD4sDQo+ID4g
KwkJIDwmY2xrIElNWDhNUF9DTEtfUENJRV9ST09UPiwNCj4gPiArCQkgPCZjbGsgSU1YOE1QX0NM
S19IU0lPX0FYST47DQo+ID4gKwljbG9jay1uYW1lcyA9ICJwY2llIiwgInBjaWVfYXV4IiwgInBj
aWVfYnVzIjsNCj4gPiArCWFzc2lnbmVkLWNsb2NrcyA9IDwmY2xrIElNWDhNUF9DTEtfSFNJT19B
WEk+LA0KPiA+ICsJCQkgIDwmY2xrIElNWDhNUF9DTEtfUENJRV9BVVg+Ow0KPiA+ICsJYXNzaWdu
ZWQtY2xvY2stcmF0ZXMgPSA8NTAwMDAwMDAwPiwgPDEwMDAwMDAwPjsNCj4gPiArCWFzc2lnbmVk
LWNsb2NrLXBhcmVudHMgPSA8JmNsayBJTVg4TVBfU1lTX1BMTDJfNTAwTT4sDQo+IA0KPiBZb3Ug
ZG9uJ3QgbmVlZCB0byBzZXQgdGhlIElNWDhNUF9DTEtfSFNJT19BWEkgY2xvY2sgcmF0ZSBoZXJl
LCB0aGF0J3MNCj4gYWxyZWFkeSBkb24ndCBieSB0aGUgcG93ZXItZG9tYWluLCBhcyBpdCBpcyBr
ZWVwaW5nIHRoaXMgYnVzIGNsb2NrIGFjdGl2ZS4gT25seQ0KPiBuZWVkIHRvIHNldCB0aGUgUENJ
RV9BVVggcmF0ZSBoZXJlLg0KVGhhbmtzLCBmb3IgeW91ciByZXZpZXcgY29tbWVudHMuDQpXb3Vs
ZCBiZSBjaGFuZ2VkIGluIG5leHQgdmVyc2lvbi4NCg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpo
dQ0KPiANCj4gUmVnYXJkcywNCj4gTHVjYXMNCj4gDQo+ID4gKwkJCQkgPCZjbGsgSU1YOE1QX1NZ
U19QTEwyXzUwTT47DQo+ID4gKwl2cGNpZS1zdXBwbHkgPSA8JnJlZ19wY2llMD47DQo+ID4gKwlz
dGF0dXMgPSAib2theSI7DQo+ID4gK307DQo+ID4gKw0KPiA+ICAmc252c19wd3JrZXkgew0KPiA+
ICAJc3RhdHVzID0gIm9rYXkiOw0KPiA+ICB9Ow0KPiA+IEBAIC00NDIsNiArNDg0LDE5IEBAIE1Y
OE1QX0lPTVVYQ19JMkMzX1NEQV9fSTJDM19TREENCj4gCTB4NDAwMDAxYzMNCj4gPiAgCQk+Ow0K
PiA+ICAJfTsNCj4gPg0KPiA+ICsJcGluY3RybF9wY2llMDogcGNpZTBncnAgew0KPiA+ICsJCWZz
bCxwaW5zID0gPA0KPiA+ICsJCQlNWDhNUF9JT01VWENfSTJDNF9TQ0xfX1BDSUVfQ0xLUkVRX0IJ
MHg2MSAvKiBvcGVuDQo+IGRyYWluLCBwdWxsIHVwICovDQo+ID4gKwkJCU1YOE1QX0lPTVVYQ19T
RDFfREFUQTVfX0dQSU8yX0lPMDcJMHg0MQ0KPiA+ICsJCT47DQo+ID4gKwl9Ow0KPiA+ICsNCj4g
PiArCXBpbmN0cmxfcGNpZTBfcmVnOiBwY2llMHJlZ2dycCB7DQo+ID4gKwkJZnNsLHBpbnMgPSA8
DQo+ID4gKwkJCU1YOE1QX0lPTVVYQ19TRDFfREFUQTRfX0dQSU8yX0lPMDYJMHg0MQ0KPiA+ICsJ
CT47DQo+ID4gKwl9Ow0KPiA+ICsNCj4gPiAgCXBpbmN0cmxfcG1pYzogcG1pY2dycCB7DQo+ID4g
IAkJZnNsLHBpbnMgPSA8DQo+ID4gIAkJCU1YOE1QX0lPTVVYQ19HUElPMV9JTzAzX19HUElPMV9J
TzAzCTB4MDAwMDAxYzANCj4gDQoNCg==
