Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBAAC5A8AA6
	for <lists+linux-pci@lfdr.de>; Thu,  1 Sep 2022 03:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbiIAB2V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 Aug 2022 21:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232533AbiIAB2U (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 Aug 2022 21:28:20 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2041.outbound.protection.outlook.com [40.107.21.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D1BF8ECF;
        Wed, 31 Aug 2022 18:28:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=np2nil1/nHkufRYda59d4Z6NBUo7Aqsg0KccYcvuYIK6jUWY3vlq9IMRJe9Xz0uCsf+eOP5eaOTMSsGH4o5FoU28amlQHCrMsSNfQaqqKeCBIXpEnW7A8MQv9gcVtKYZqZEl5686wfbRgiOKjCc+tg0ghHevYOIDGxg28Z2+7H5/Vajqa5v2YYIBiw/ZmDDHH+mV8jyZwjQ02eQWBG4UhzLiMQycdK9L5SDh0UfjpxXgqZrObKlQ8EDTOYCEJFJGsq1r7QwFWYOo6QwN2p+7RlLOh2BBv5Mm77oG++vLzRNKKIx5+d80Gv73ghnj/9jIEd8uioXFREbFVO2L7NCARg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uYW1NQzQLjlNZ3Q4j1aPhvY+vmirciEdINTcBkew2Zs=;
 b=cOgImkia29/ZaGoDu/qJcBEAKIinBWyf7sK7JTjW7H4U4lvuVNv0mkdVeXjBGzHraoAtrvz/9fGiDtUIpWoRxJae73dKcnjnB5uEDPKyRP2nFrspUErmwds5nB2u2O7ZgeDO4DxuTvpVV2kgxIGK2HU8kuNH2mIksRGcEAHwkR06Twp5KPxO9aNNyEaVK9X3/zZOF8HDPiVf4QvufmL7rlStjrOA5fvlfoC2qY67z3jQlLJ9a0U5kfuYvh1B+N9F8r3aV/WBh4xq4OynkGKBdDEFa2McI9riKtZCyI6Q6tIdJ/dtSI5s/MeupEj/fDU+p8UyUwmFuSOpPJGDlQgfKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYW1NQzQLjlNZ3Q4j1aPhvY+vmirciEdINTcBkew2Zs=;
 b=ltivLUBxOFkUkAH4GOT724OrrQ/LX5blx3R/o/XdFKep5YlunW/dDQVbiH/wR5NuFvznD0opNKg2Um1lMP4pSuXJdCHyPjNOjFJAmKfCoXQ+Qli9THh4OVdH6ixjUndwuuMlzoAmZfKx5Qr13DMHYTafEam+yAVFcgbAfU+gSqM=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM0PR04MB5203.eurprd04.prod.outlook.com (2603:10a6:208:c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 01:28:17 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::13c:5622:af8a:b2da]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::13c:5622:af8a:b2da%9]) with mapi id 15.20.5588.011; Thu, 1 Sep 2022
 01:28:17 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "richard.leitner@linux.dev" <richard.leitner@linux.dev>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "marex@denx.de" <marex@denx.de>
CC:     "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v5 3/7] arm64: dts: imx8mp-evk: Add PCIe support
Thread-Topic: [PATCH v5 3/7] arm64: dts: imx8mp-evk: Add PCIe support
Thread-Index: AQHYvEcJa+qW+QsmN0mt2KSs3Mdc9K3IzWIAgAD9goA=
Date:   Thu, 1 Sep 2022 01:28:16 +0000
Message-ID: <AS8PR04MB8676F800BC6D298B218435EE8C7B9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1661845564-11373-1-git-send-email-hongxing.zhu@nxp.com>
         <1661845564-11373-4-git-send-email-hongxing.zhu@nxp.com>
 <1218d5afbbf18f8b5ab9013e08fde84a787d8df3.camel@toradex.com>
In-Reply-To: <1218d5afbbf18f8b5ab9013e08fde84a787d8df3.camel@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a599c61-0be5-4d4f-633d-08da8bb93f17
x-ms-traffictypediagnostic: AM0PR04MB5203:EE_
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v5yJo8EyUiJzAZHVl9ePU59wZfCKlCdMM36IGNA/MveByUa9RJSTkrE0R38X8DDFrpJoW8Qk6m32E/D8rgeTiP7PwWy3dwr+ZoYUM4HrUf5PS/Q1oYlhwBuHiO9PPyb/+kqHEGhhfl00yKnNjA3dK/xDZO5j1zjr46dZSV3rJ6XWto8PuxtNo0jX006QDsjjh06pHvJby/ILbAuORQ6hwUtFShljhvtWsBVq4QfqnYyWtq7jjRheGLplxM8cpOBCXNuY+Ut0fyExdLyevbxmZJKn2ZyvvX/nHUPtAWiow3VkvMdgXm/6x83/U/u4y/apb/LHkwrjaFMSbRRUp9EIq6mY/3kZfl4kLKKpfHbb5YoavakHsotwOFwEdhWq7PRGrto9PeSFSgYm5mfqPg4roBaLRs7zh2ViVi8KoOlRsQw1aX0K6Qn8ow3y54q1KiS1lSMytlWApsQ8N4DpLUJx48PH8qoQJrkpqaytsLHIZueek1ZXoRUWWgpxSmuJSmRvyYPqsEdMlFIyJRSHKvjJXnixspM48h+dwpwZ2UfNYB7phCaVhQVNu/5AijF1UfxeB9YiVys6BuMJS25WxLeB9p70g/JBfxISwSc/ep5K7HlvZVmWCuMSe31q7uL8wxU+AElAejJnl5GQIP5QF0oIaZqD/zCU83D8ShrARJowiy9TiQ18Y8ufISibR767gpGXbbWdN7zkfZB55pqDJd2zx9+QHnJ01u9XL3xgj7MB+s/zb2CNYcivgNS4FZZ+ObnoGw7luwwJhZlYjBQMgElTGrDzYhAp7WPATcfhEHIUOrBnHh5ks3PFNR2JnVGZJOxj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(39860400002)(376002)(366004)(136003)(55016003)(4326008)(76116006)(66946007)(66556008)(64756008)(66446008)(66476007)(8676002)(7416002)(7696005)(54906003)(110136005)(316002)(53546011)(6506007)(33656002)(41300700001)(71200400001)(44832011)(478600001)(9686003)(26005)(38100700002)(921005)(86362001)(186003)(52536014)(5660300002)(2906002)(122000001)(8936002)(38070700005)(83380400001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cTlUMEVLTEtIaWlydHp6VFdoNVpWMjhkdFdhRkZWL1g4VmVtdXd1YklxOSs4?=
 =?utf-8?B?ZnBodlcxQXUveUVOMmhGLzNxWGZVb3NPU2xlZU1tRkVXSUYrTEZkOVBoaXNG?=
 =?utf-8?B?QzRwUHBwVjNwTEtxcmlZS1VhVndwb3F3OUZ1YjIrRFZVQ0hQcGtLcW83ZkJt?=
 =?utf-8?B?aVdzaGJzMC9TMERsdDBuZlhUc0N5cTJEV0JuMk1rMHlYUTNaVjBnMDVIV205?=
 =?utf-8?B?TUhYbGQwZWlVUzF4QmREeFhJa054QnppcWZDYVg0OStvcUhjVGNqTzdhUVVC?=
 =?utf-8?B?UVFQYXJzYkFmRUVUSHdHN1VOc2F6c1N1V0NCcXd4MjZjWkVHMUsrWE5wUzd4?=
 =?utf-8?B?MXpaN1BOL2tNazJxV3VLNHM2ME5jdlUvT2EwbldQZEdSTDk2V2dmVXV2Q2NW?=
 =?utf-8?B?RTNrekZBV2ZELytyQzRpbVJ0N21lSERKd1RPZ3dMcVRhRXlnRHJOQk9ReXdz?=
 =?utf-8?B?SlJwK2xjTVhkTFRyb0hIQ1RLN1NwTldpcmZ2eG4vV1FNUmFSL0xnVTNHQnFP?=
 =?utf-8?B?WHdRVU44Nkhvd2VoMDZUck5kODM2QnZRUlFEYWZzMmVUZU40SUVLaC9GNHpu?=
 =?utf-8?B?a05hY0NZVWRIWFJ3VENkazFtODlWcFIzZmhuVkpjWVJ1eFNtMW1LWCtvYTU1?=
 =?utf-8?B?Tjc0Ykc2eTdjR2tHVnpmdSs0eHNGb3YveFVZWnN4NEs0T1VQZjdnME1Wem4w?=
 =?utf-8?B?VW5FdDE3dGxqQVhBL3NURVR0N1R4ZzBER3N1TUVPUWowUDdCeTl5TFErck54?=
 =?utf-8?B?aEVXQ1lIQ3pXSG5HdlVpRDNnQy9TZnJpTy91MEc0TVE4bUJqWnlhWUpFZGk0?=
 =?utf-8?B?K1BFZmRqbUkraTVoOVlRSzlZZmRHSUJhalFKM2ZRbXdicjRHL1JjU0wrMVho?=
 =?utf-8?B?bk1nMUVuQ1RTS28vZ005dFhFanJUTzJNcmxNb1pjQlcrckw4U1hUaXlRWDFN?=
 =?utf-8?B?Q01jWWMyb1dTUXRmc0o0eW9MMzRDZXBjMTgxUTFvSkVIckNpK1dvMk9RWXlT?=
 =?utf-8?B?bDdPM3V4QUZzOUR4YW5VUFg1R2pzTjFRR2hNaDZmaDR1bkxIZ3ZkSlFNQzVs?=
 =?utf-8?B?RTBsbmZaaEY2d05KY05rL2R6SzNjTGJYL000R0wrSWViS3NEY2dVOVFNNS9p?=
 =?utf-8?B?TTk4NWpnSGlmbDBBQkJtUTROZnhTTTQwOGdMT3oyU1RRNWdJQXRDaDZLUUxx?=
 =?utf-8?B?NWIwRDNzTjlEcGlPNWlzcFBKVDR0MTAyUFhvL2lGU3VNeFhqWSszYUhtMmU1?=
 =?utf-8?B?eFp6YzYrSm9PVUxTNEN6bEJ1bkJvVm43Zmd5SFlCNjl6NE1vSmV6aVorTFZT?=
 =?utf-8?B?YnpxVkVjc2FRQkhybEx0UUhqbTZPZUtwOFpFYmwraTZRRUdGODJORkllZDRD?=
 =?utf-8?B?MlgwdjM1NEtvREQ4RnZJMXNxQU0vWWdxWUVOeTErTXE2MlN4NUMreFBhMU9m?=
 =?utf-8?B?YjIwNUE2VUlRdEFhTTdFS3FLbXBCTERNUDlUeWkzWHowaVVtRGNYTWxBM3I3?=
 =?utf-8?B?UzF3R2ljdjlCM0NLZGJucVpGYVVzMTU3alViNnh0dmlTUjBJTHRPbFQ5ZXVn?=
 =?utf-8?B?clFrczBHOFBqY2tDdGJYV0tRL1dsZUdWdlljVnJsOFdvcjAxdEFva09JTXpx?=
 =?utf-8?B?ZVl4Y2QxRkF3VTlidGtvcXBrNmFxSnFvcy9GSEJtbEpreSs2WDNsRWFyNXQz?=
 =?utf-8?B?NENOU29zZFI0RkRQMk5xSHhBQUJQQ1dRcEM4b2VpcUtqZXZGNzRBcnZ2UGNo?=
 =?utf-8?B?M1VWQ2l1ZlRST24yYUIyWnRuZFl1a3VVYm94N3RvOXY0am1hQ2tqM2ZDbzU3?=
 =?utf-8?B?UzZDSFdXTENoejhvckVCeFVlM3B2cGdISVM3c1FYbEFFUzU0RjlXamxTWFI0?=
 =?utf-8?B?MW1zNEU2NlNVbXFqdFRiellieDk0Nng2UXBocDlEZnF5VUwyNWpRbHgwS0Ux?=
 =?utf-8?B?Wk5tczl4VldIZlRXZkx1OGtuKzJLTWtiaXB5T2plTzlQUjZZOFZMbXIvYXNL?=
 =?utf-8?B?T2l0bmdVOXhoVHBLSXl2eEtMZ1dnS29hbFZxcjhYV2NzeVRjc1hEZ0EvNWts?=
 =?utf-8?B?SHJnZS9nM2hoVUoyeUtISmQ5cXRUUjZWOGFxOGQwRkdHR01ySDdqUTlrUG8v?=
 =?utf-8?Q?I8n36roA+36/bDlAuxp4DvZyI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a599c61-0be5-4d4f-633d-08da8bb93f17
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2022 01:28:16.9586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DkMN3H67KUWidGVjzXhMCTQ7agpex8WDq0ZrUQRs333CZrHKKANPxkw5rZ83IIyMLqsZzCpcp/50xknZpCVs0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5203
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJjZWwgWmlzd2lsZXIgPG1h
cmNlbC56aXN3aWxlckB0b3JhZGV4LmNvbT4NCj4gU2VudDogMjAyMuW5tDjmnIgzMeaXpSAxODox
OA0KPiBUbzogdmtvdWxAa2VybmVsLm9yZzsgcmljaGFyZC5sZWl0bmVyQGxpbnV4LmRldjsNCj4g
YWxleGFuZGVyLnN0ZWluQGV3LnRxLWdyb3VwLmNvbTsgcm9iaEBrZXJuZWwub3JnOyBsLnN0YWNo
QHBlbmd1dHJvbml4LmRlOw0KPiBzaGF3bmd1b0BrZXJuZWwub3JnOyBsb3JlbnpvLnBpZXJhbGlz
aUBhcm0uY29tOyBwLnphYmVsQHBlbmd1dHJvbml4LmRlOw0KPiBIb25neGluZyBaaHUgPGhvbmd4
aW5nLnpodUBueHAuY29tPjsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsNCj4gbWFyZXhAZGVueC5kZQ0K
PiBDYzogbGludXgtcGh5QGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LXBjaUB2Z2VyLmtlcm5l
bC5vcmc7DQo+IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5v
cmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGRsLWxpbnV4LWlteCA8bGludXgt
aW14QG54cC5jb20+Ow0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4g
U3ViamVjdDogUmU6IFtQQVRDSCB2NSAzLzddIGFybTY0OiBkdHM6IGlteDhtcC1ldms6IEFkZCBQ
Q0llIHN1cHBvcnQNCj4gDQo+IE9uIFR1ZSwgMjAyMi0wOC0zMCBhdCAxNTo0NiArMDgwMCwgUmlj
aGFyZCBaaHUgd3JvdGU6DQo+ID4gQWRkIFBDSWUgc3VwcG9ydCBvbiBpLk1YOE1QIEVWSyBib2Fy
ZC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFJpY2hhcmQgWmh1IDxob25neGluZy56aHVAbnhw
LmNvbT4NCj4gPiBUZXN0ZWQtYnk6IE1hcmVrIFZhc3V0IDxtYXJleEBkZW54LmRlPg0KPiA+IFRl
c3RlZC1ieTogUmljaGFyZCBMZWl0bmVyIDxyaWNoYXJkLmxlaXRuZXJAc2tpZGF0YS5jb20+DQo+
ID4gVGVzdGVkLWJ5OiBBbGV4YW5kZXIgU3RlaW4gPGFsZXhhbmRlci5zdGVpbkBldy50cS1ncm91
cC5jb20+DQo+ID4gLS0tDQo+ID4gwqBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4
bXAtZXZrLmR0cyB8IDUzDQo+ID4gKysrKysrKysrKysrKysrKysrKysNCj4gPiDCoDEgZmlsZSBj
aGFuZ2VkLCA1MyBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02
NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1wLWV2ay5kdHMNCj4gPiBiL2FyY2gvYXJtNjQvYm9v
dC9kdHMvZnJlZXNjYWxlL2lteDhtcC1ldmsuZHRzDQo+ID4gaW5kZXggZjZiMDE3YWI1ZjUzLi5k
ZWZjOTJhOGJiNjAgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2Nh
bGUvaW14OG1wLWV2ay5kdHMNCj4gPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2Fs
ZS9pbXg4bXAtZXZrLmR0cw0KPiA+IEBAIC01LDYgKzUsNyBAQA0KPiA+DQo+ID4gwqAvZHRzLXYx
LzsNCj4gPg0KPiA+ICsjaW5jbHVkZSA8ZHQtYmluZGluZ3MvcGh5L3BoeS1pbXg4LXBjaWUuaD4N
Cj4gPiDCoCNpbmNsdWRlICJpbXg4bXAuZHRzaSINCj4gPg0KPiA+IMKgLyB7DQo+ID4gQEAgLTMz
LDYgKzM0LDEyIEBAIG1lbW9yeUA0MDAwMDAwMCB7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIDwweDEgMHgwMDAwMDAwMCAwIDB4YzAwMDAwMDA+Ow0KPiA+
IMKgwqDCoMKgwqDCoMKgwqB9Ow0KPiA+DQo+ID4gK8KgwqDCoMKgwqDCoMKgcGNpZTBfcmVmY2xr
OiBwY2llMC1yZWZjbGsgew0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjb21w
YXRpYmxlID0gImZpeGVkLWNsb2NrIjsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCNjbG9jay1jZWxscyA9IDwwPjsNCj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNsb2NrLWZyZXF1ZW5jeSA9IDwxMDAw
MDAwMDA+Ow0KPiA+ICvCoMKgwqDCoMKgwqDCoH07DQo+ID4gKw0KPiA+IMKgwqDCoMKgwqDCoMKg
wqByZWdfY2FuMV9zdGJ5OiByZWd1bGF0b3ItY2FuMS1zdGJ5IHsNCj4gPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoGNvbXBhdGlibGUgPSAicmVndWxhdG9yLWZpeGVkIjsNCj4gPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJlZ3VsYXRvci1uYW1lID0gImNhbjEtc3Ri
eSI7IEBAIC01NSw2ICs2MiwxNw0KPiBAQA0KPiA+IHJlZ19jYW4yX3N0Ynk6IHJlZ3VsYXRvci1j
YW4yLXN0Ynkgew0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZW5hYmxlLWFj
dGl2ZS1oaWdoOw0KPiA+IMKgwqDCoMKgwqDCoMKgwqB9Ow0KPiA+DQo+ID4gK8KgwqDCoMKgwqDC
oMKgcmVnX3BjaWUwOiByZWd1bGF0b3ItcGNpZSB7DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoGNvbXBhdGlibGUgPSAicmVndWxhdG9yLWZpeGVkIjsNCj4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcGluY3RybC0wID0gPCZwaW5jdHJsX3BjaWUwX3Jl
Zz47DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJlZ3VsYXRvci1uYW1lID0g
Ik1QQ0lFXzNWMyI7DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJlZ3VsYXRv
ci1taW4tbWljcm92b2x0ID0gPDMzMDAwMDA+Ow0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqByZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDwzMzAwMDAwPjsNCj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ3BpbyA9IDwmZ3BpbzIgNiBHUElPX0FDVElWRV9ISUdI
PjsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZW5hYmxlLWFjdGl2ZS1oaWdo
Ow0KPiA+ICvCoMKgwqDCoMKgwqDCoH07DQo+ID4gKw0KPiA+IMKgwqDCoMKgwqDCoMKgwqByZWdf
dXNkaGMyX3ZtbWM6IHJlZ3VsYXRvci11c2RoYzIgew0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgY29tcGF0aWJsZSA9ICJyZWd1bGF0b3ItZml4ZWQiOw0KPiA+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsgQEAgLTM1
MCw2ICszNjgsMjggQEANCj4gJmkyYzUNCj4gPiB7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoCAqLw0K
PiA+IMKgfTsNCj4gPg0KPiA+ICsmcGNpZV9waHkgew0KPiA+ICvCoMKgwqDCoMKgwqDCoGZzbCxy
ZWZjbGstcGFkLW1vZGUgPSA8SU1YOF9QQ0lFX1JFRkNMS19QQURfSU5QVVQ+Ow0KPiA+ICvCoMKg
wqDCoMKgwqDCoGNsb2NrcyA9IDwmcGNpZTBfcmVmY2xrPjsNCj4gPiArwqDCoMKgwqDCoMKgwqBj
bG9jay1uYW1lcyA9ICJyZWYiOw0KPiA+ICvCoMKgwqDCoMKgwqDCoHN0YXR1cyA9ICJva2F5IjsN
Cj4gPiArfTsNCj4gPiArDQo+ID4gKyZwY2llew0KPiANCj4gTWlzc2luZyBzcGFjZSBiZWZvcmUg
dGhhdCBjdXJseSBicmFjZS4NCj4gDQpHb29kIGNhdWdodC4gV291bGQgYmUgY2hhbmdlZCBsYXRl
ciwgdGhhbmtzLg0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQoNCj4gPiArwqDCoMKgwqDC
oMKgwqBwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPiA+ICvCoMKgwqDCoMKgwqDCoHBpbmN0
cmwtMCA9IDwmcGluY3RybF9wY2llMD47DQo+ID4gK8KgwqDCoMKgwqDCoMKgcmVzZXQtZ3BpbyA9
IDwmZ3BpbzIgNyBHUElPX0FDVElWRV9MT1c+Ow0KPiA+ICvCoMKgwqDCoMKgwqDCoGNsb2NrcyA9
IDwmY2xrIElNWDhNUF9DTEtfSFNJT19ST09UPiwNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIDwmY2xrIElNWDhNUF9DTEtfUENJRV9ST09UPiwNCj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIDwmY2xrIElNWDhNUF9DTEtfSFNJT19BWEk+Ow0KPiA+ICvCoMKg
wqDCoMKgwqDCoGNsb2NrLW5hbWVzID0gInBjaWUiLCAicGNpZV9hdXgiLCAicGNpZV9idXMiOw0K
PiA+ICvCoMKgwqDCoMKgwqDCoGFzc2lnbmVkLWNsb2NrcyA9IDwmY2xrIElNWDhNUF9DTEtfUENJ
RV9BVVg+Ow0KPiA+ICvCoMKgwqDCoMKgwqDCoGFzc2lnbmVkLWNsb2NrLXJhdGVzID0gPDEwMDAw
MDAwPjsNCj4gPiArwqDCoMKgwqDCoMKgwqBhc3NpZ25lZC1jbG9jay1wYXJlbnRzID0gPCZjbGsg
SU1YOE1QX1NZU19QTEwyXzUwTT47DQo+ID4gK8KgwqDCoMKgwqDCoMKgdnBjaWUtc3VwcGx5ID0g
PCZyZWdfcGNpZTA+Ow0KPiA+ICvCoMKgwqDCoMKgwqDCoHN0YXR1cyA9ICJva2F5IjsNCj4gPiAr
fTsNCj4gPiArDQo+ID4gwqAmc252c19wd3JrZXkgew0KPiA+IMKgwqDCoMKgwqDCoMKgwqBzdGF0
dXMgPSAib2theSI7DQo+ID4gwqB9Ow0KPiA+IEBAIC01MDIsNiArNTQyLDE5IEBADQo+IE1YOE1Q
X0lPTVVYQ19TUERJRl9UWF9fSTJDNV9TQ0wNCj4gPiAweDQwMDAwMWMyDQo+ID4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqA+Ow0KPiA+IMKgwqDCoMKgwqDCoMKgwqB9Ow0KPiA+DQo+
ID4gK8KgwqDCoMKgwqDCoMKgcGluY3RybF9wY2llMDogcGNpZTBncnAgew0KPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBmc2wscGlucyA9IDwNCj4gPg0KPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoE1YOE1QX0lPTVVYQ19JMkM0X1NDTF9f
UENJRV9DTEtSRQ0KPiBRX0LCoMKgwqDCoDB4NjENCj4gPiArLyogb3BlbiBkcmFpbiwgcHVsbCB1
cCAqLw0KPiA+DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgTVg4TVBfSU9NVVhDX1NEMV9EQVRBNV9fR1BJTzJfSU8NCj4gMDfCoMKgwqDCoMKgwqAweDQx
DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoD47DQo+ID4gK8KgwqDCoMKgwqDC
oMKgfTsNCj4gPiArDQo+ID4gK8KgwqDCoMKgwqDCoMKgcGluY3RybF9wY2llMF9yZWc6IHBjaWUw
cmVnZ3JwIHsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZnNsLHBpbnMgPSA8
DQo+ID4NCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBN
WDhNUF9JT01VWENfU0QxX0RBVEE0X19HUElPMl9JTw0KPiAwNsKgwqDCoMKgwqDCoDB4NDENCj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgPjsNCj4gPiArwqDCoMKgwqDCoMKgwqB9
Ow0KPiA+ICsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgcGluY3RybF9wbWljOiBwbWljZ3JwIHsNCj4g
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGZzbCxwaW5zID0gPA0KPiA+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoE1YOE1QX0lPTVVYQ19H
UElPMV9JTzAzX19HUElPMQ0KPiBfSU8wMw0KPiA+IDB4MDAwMDAxYzANCg==
