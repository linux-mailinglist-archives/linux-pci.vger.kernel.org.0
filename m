Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44BEC5F2822
	for <lists+linux-pci@lfdr.de>; Mon,  3 Oct 2022 07:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbiJCFPZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Oct 2022 01:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJCFPW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Oct 2022 01:15:22 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2056.outbound.protection.outlook.com [40.107.22.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261EF1EEC1;
        Sun,  2 Oct 2022 22:15:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UKamkUVnetURQ/FGraXVu6gRURHDRTXklmExwcZhzF+ipAvxfUZKZ4z/XhrzuDzO7T+pZCOOLNRK/eKpP/7YPmEk8dGhwyV2Znl167QhpOe2J8CjamuUxY+XTZFkctmXMhQ/0SbU7U6+M5xf+p58RZU/E7nuYf/Vl6M86lw7ksNvtgvSzVRPQocCOdW3IdqzVGo4NfZSDc38zyHKbpfUOnC+F0jVamrVgaLcwJN8Kb1Vfjon4286tdzAGHgB18L8V0k4JWdjhhUVEKLHNMhhcA8AcHdit9gSg+N08SBJw4rUxCd8vQxAPTp7lrV+PidM3qov83pS4A243d1tLsL5vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t6up7nsltgFBeM8mUJlz8wK2CPeF1PrczxOc9B6djOQ=;
 b=bD7jk5+lEDRuwKunm7t9SQIJmLrRsXGz9Q9NAIJXvk3KOdTn5o/ZrAfEb5nHwy4LXpcDfza0AggptqyQCecbS9zWU2Cb5PU46pHMoqqxO3rKZX+FOWKSA99mt8NQgflUY+qIkOzPkxujLD87IUq1dTMMHtBCgRi7iSwC5U3f63CPsYK+L0njf06o4Qek9hshwUj0F0pjjHSVFGNtZS0qH44IjkMTgLzFef7Qh3LNOS63djj1UxKfq0OBvC0Wn0ah6mL8hFhWZTId5CbBpU4WPh7V3nVD+oqGcZRznLximSmM/mAl5l1X13S+opBrySxkb40TniQF85VIb4b42Irjww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t6up7nsltgFBeM8mUJlz8wK2CPeF1PrczxOc9B6djOQ=;
 b=d7/mwN9xXGUe/zt9omLPuVUlxfcpLmYkERAgGw3nPEN4O6myMG99KHh60lhTc8M2ITRztmFt5jjnGFal4DSwGD4PDhVBhYg7W8RrsZZGNro3hcfRk7XzD9neqS5++qenT0L1AjzCb1vr9xlVoqxFI4nzdPVbxsXookBJpB8TKXM=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB7896.eurprd04.prod.outlook.com (2603:10a6:20b:2a2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Mon, 3 Oct
 2022 05:15:17 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::1abe:67d2:b9fe:6b63]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::1abe:67d2:b9fe:6b63%4]) with mapi id 15.20.5676.028; Mon, 3 Oct 2022
 05:15:17 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        "marex@denx.de" <marex@denx.de>,
        "richard.leitner@linux.dev" <richard.leitner@linux.dev>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v10 4/4] phy: freescale: imx8m-pcie: Add i.MX8MP PCIe PHY
 support
Thread-Topic: [PATCH v10 4/4] phy: freescale: imx8m-pcie: Add i.MX8MP PCIe PHY
 support
Thread-Index: AQHY0+FW9QJ+tB0TZ0aI8HqaA+Y3Oa33qm8AgAR7n3A=
Date:   Mon, 3 Oct 2022 05:15:17 +0000
Message-ID: <AS8PR04MB8676DE9867EB42F493120C4E8C5B9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1664440622-18556-1-git-send-email-hongxing.zhu@nxp.com>
 <1664440622-18556-5-git-send-email-hongxing.zhu@nxp.com>
 <070a4442-6fd0-c63c-65d9-caca18eea20a@pengutronix.de>
In-Reply-To: <070a4442-6fd0-c63c-65d9-caca18eea20a@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|AS8PR04MB7896:EE_
x-ms-office365-filtering-correlation-id: 23c70b45-15d9-4547-a982-08daa4fe42e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cCDF53AmAQU6ZabC/ocG+WnHtbYam/qkSVjpIxAisXaxgZqvBJI5y1U8EH8MQa618G8p/MBX/Kio5Zy2Ml1JxRfm9qoGjvs7tzGuKLe+7kR0yoQazDGXesVZeBYAHpvSKJR/qHvnGUOq64ZcGhFKrcBhn/wqddvq2Msco8HSMCO6mb7jZFPqgkwNI1gkA+Z43kBYNRxj36G5yI2HnigJB5SOwJNaOZwezw12pZGrSRxyOSkX6flO+qBDUu8ysuzfbUw6/Mh2eQWhjjMnwkhOSXkzWsolb3S+twk2JsVeLEaeMUpthlVtkkfxzTCmMh6EUVcv5Kb9CEEsik3/TgRVp6hDhObuqzD6aEWCMlwwVMDELEdgosGZ6Fy/VGiUBjO/Q6vfCmFZ1Qcx0bBopiNYGZhOcuTReo4/lKbMed1KYFwi4FahHbsaIoa1noyOhreM4ePvnLw35l+mb92SxNfdib8fRRPCCLWCBdUGSlL5NLTaLenZOHBsl96bJ6wkj+FRWk1I1TTJo0PEHms/w87yvYPHYni66pmhK42kaHshExsNGxXFVeysF37RG3pf43CGYGcSc7LP17lqdluEpXUovcaBRKREBJRXy5By6/ToqzMknGd308Se12vQp1v8/tW6ahV8ykvq7UFg61oKez426KAkpa3fyz31Qm9jClPY/EilArkHTrQMKV1iMZcJG6CCjgYJuMYIitSyxc7o5NNQ+PcjXpeC4nyhIOMG6TozAMNcrFaDfTXEhy2IKvW124BUsVNiEu61X7klCr+f77fKUGNlU0NNtkdT+60zv5Zl0a8ohvCWqNivFCe63V9l40/Ad3VFiSF4jAFkekizMMw3ig==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(376002)(136003)(366004)(451199015)(66476007)(66556008)(66446008)(64756008)(8676002)(33656002)(110136005)(54906003)(86362001)(122000001)(966005)(44832011)(83380400001)(186003)(2906002)(66946007)(38100700002)(7416002)(4326008)(921005)(26005)(7696005)(53546011)(45080400002)(478600001)(71200400001)(316002)(52536014)(38070700005)(6506007)(8936002)(76116006)(9686003)(5660300002)(41300700001)(55016003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?QlhNbDhPd2t2NTVaZk9odFdBc21SakdPTXZRRDBTRmp0R0dGN1dHbWZtNG5O?=
 =?gb2312?B?UGk0TEVvNWVPTUlBZEZjd3JFaitUWURoOTF2OWN5N3RieWh1SGN4aERoaW5m?=
 =?gb2312?B?dnkvMXEyd2tFVkFXNEhxbmFmcElkRndqSmRYMjg1KzNSbFNaUGhKOXJHYlNi?=
 =?gb2312?B?Z2I2a01rSm1QRENGeVhpdXh2TnloNGUrVHVidDY1dEhGQXRhMmdHMFZNSFN2?=
 =?gb2312?B?L2QvMnhuOFpsb1o3S0d2bG9zZFlWN05DTWtWdSs2aXB3dkxmQWdmbkpHaWlM?=
 =?gb2312?B?V05tcmxpM2R3QzI1aVYwZ0pIeXdPZVlITHdYRTBlRnNvSEdYejJ2Yys1Szdx?=
 =?gb2312?B?ejRvZnNlWGc2MkZYeW9lMFFITGtIMlVKbnVSYlI4WVVOQzBKQ3VhVk5XMEYz?=
 =?gb2312?B?dUorR3ZUQUpNUDA5OCsvME5lcHdxTXBhbG5FNGRXcGd1aVNsZ0hBZnVPTWZi?=
 =?gb2312?B?a2h2bXBISURUbTgxWXMyQVl1ZHpCVzVrZ1N6SGNYbGdOWDZ6VWR6NVZZUEh6?=
 =?gb2312?B?clljVHVTWmtEdGxEZGRhbEhodlVIeVQrTjNIdG8vOE1DVTVVYTB2ZEN4RVcz?=
 =?gb2312?B?d2lmZ3Q3T3NmVVJYWDlhMGdUNG5mcnVZTWRIN28xR1BURTRNM0xiWjZSS2l3?=
 =?gb2312?B?NEpQcGJaSU1OLzJoL3B1ak1YQXgrK0VrQ2NwaUo2Q1BRWjNrVXBYcXdGbStZ?=
 =?gb2312?B?M1JoTlNOcUY4S1Z1TGZNS1p3SmQ2ZXlwMC9sd1diRW5yT1N3RXhpZmZPYnNn?=
 =?gb2312?B?RTVKV0lxSWJoR1ByaDNFcDVGMEpNSkJFbWlTekliSzA4eUVOZDA1TStZWEZI?=
 =?gb2312?B?QWZIYk50djZFREsvYVhJcjR6Q0llVWhZT0ZlQXRSbDBlajU2RENJK0hBL2ht?=
 =?gb2312?B?ME9ab1RKWHBOb0srd3dVQmpQaW0rbjBKdkFIRUpjOEt6b0p3YVk0aXFLMTJI?=
 =?gb2312?B?dk8yVEhyYkMrU3A0dThZaER3STVLZ2l6TGpxMDRWSTZQejlGQXV4WDhlOWNt?=
 =?gb2312?B?azIwRklLYkxrZG00NENzWm9tZUFkcFlZY3A5eE9rcWVHcEh2NUhTUDJWQ3ox?=
 =?gb2312?B?SXpZeC9MbXhyR0xsZ2E2SmpYeEpZSXZFTjVpY0tRN1FSZ242UzRtTXo3ejZM?=
 =?gb2312?B?Y3Y5d25RZ1FrUlBBTS9xUWdSQ1o0a3E5a3Fsb0QzK1dBVUxTTGp1ekxUZUxI?=
 =?gb2312?B?dUF5aXc2YmFyb1F3eW9xbkhzSkwxbnhic0lrVHlMcXZpUjJJTXZ5T2hDcUNQ?=
 =?gb2312?B?SWtjLzNhallDekZ6K1FxUWYyZFYxTVByRkFGU2U3OU92VWRiS09zY3RyblNG?=
 =?gb2312?B?OU1tZnhQTHdKa2xCeVB4NTEvdVp1VzBaRnJ0S00wbjZuVUdya2Qzanc4VSt4?=
 =?gb2312?B?bG0wWTVGcjEvVWVYT3RFUUtHOGF2bHVLYmx4UDVIM082R1RDdkZWTm5aQXp4?=
 =?gb2312?B?WEhKUEtkc0ZtLytlWFQxV1JlSi9FVytXNDlzTk56MWxxK3RMU0t2QXpFMDg2?=
 =?gb2312?B?ZWtLckZMZWZCcUZHT0VpSDMyUTczTU8xeThDa09SOW1MdDl4c0RvTnFLcXUz?=
 =?gb2312?B?LzZhcUtwc1ZsS3RBdkpyR2Y3aW9GWmYxcTVBSmNvd3A1RXArMkFuVWdTWnpl?=
 =?gb2312?B?Uy9sVHRqbVJTUGs5c1hTOEFBL252OStKa2ZwRE4xRlZXSjRPRlJaTWxLUytJ?=
 =?gb2312?B?NUdmd2xNT3pJYjR6Y2lhbmZsRUhQZUVEdVFoMXJEd0xzcjZUak14U3UwelM2?=
 =?gb2312?B?ZjFWMksrM3BpcXJscnNqbHc3T0YrRlBCYTdZaGpxajFqRkJkR3FqbEVBMFV3?=
 =?gb2312?B?OFJZaEJVRldBQnpNMkxwb3JOY0tPSXZOeFNJa24wa3NERkJLNGx3YUU5M1N5?=
 =?gb2312?B?ZGdOUWR5K0VhVk1VYkNlem4zSGZEYU9NcUZneE1MeW5lZnlsMm1tZGZsTVFp?=
 =?gb2312?B?dmk5bG1jQk9aWE1ybUJxZmJSckUzbXlxUjlvM2s0NmJ0cVE0MHJKWFZ4NTFp?=
 =?gb2312?B?bjZHN0lTeXRlR3k1ejJlRjlwbStJdVNaWDQ4a3RVQUlwSzU1ZzNvSDdjZ1gw?=
 =?gb2312?B?enByZ0NBU1VRK29wL2hnSTdITUtPbHA1WEtDQlBqWU5wSzhNcVlPSzR4aXlL?=
 =?gb2312?Q?ZaFGXRenRB/LBDqmPZCW7tFlB?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23c70b45-15d9-4547-a982-08daa4fe42e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2022 05:15:17.6520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VDVMG/tZ3KOtZyjO0o24NEN19K42q9niXJYl6tDmLFOUGCYVhJCfCpoEdo879LxPKH52GGMLCODW91aTCKeN2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7896
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBaG1hZCBGYXRvdW0gPGEuZmF0
b3VtQHBlbmd1dHJvbml4LmRlPg0KPiBTZW50OiAyMDIyxOo51MIzMMjVIDE2OjQ2DQo+IFRvOiBI
b25neGluZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPjsgdmtvdWxAa2VybmVsLm9yZzsNCj4g
cC56YWJlbEBwZW5ndXRyb25peC5kZTsgbC5zdGFjaEBwZW5ndXRyb25peC5kZTsgYmhlbGdhYXNA
Z29vZ2xlLmNvbTsNCj4gbG9yZW56by5waWVyYWxpc2lAYXJtLmNvbTsgcm9iaEBrZXJuZWwub3Jn
OyBzaGF3bmd1b0BrZXJuZWwub3JnOw0KPiBhbGV4YW5kZXIuc3RlaW5AZXcudHEtZ3JvdXAuY29t
OyBtYXJleEBkZW54LmRlOyByaWNoYXJkLmxlaXRuZXJAbGludXguZGV2DQo+IENjOiBkZXZpY2V0
cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZzsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47
DQo+IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgbGludXgtcGh5QGxpc3RzLmluZnJhZGVhZC5vcmc7
DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIHYxMCA0LzRdIHBoeTogZnJlZXNjYWxlOiBpbXg4bS1wY2llOiBBZGQgaS5NWDhNUCBQ
Q0llDQo+IFBIWSBzdXBwb3J0DQo+IA0KPiBIaSwNCj4gDQo+IE9uIDI5LjA5LjIyIDA5OjM3LCBS
aWNoYXJkIFpodSB3cm90ZToNCj4gPiBBZGQgaS5NWDhNUCBQQ0llIFBIWSBzdXBwb3J0Lg0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IEx1Y2FzIFN0YWNoIDxsLnN0YWNoQHBlbmd1dHJvbml4LmRlPg0K
PiA+IFRlc3RlZC1ieTogTWFyZWsgVmFzdXQgPG1hcmV4QGRlbnguZGU+DQo+ID4gVGVzdGVkLWJ5
OiBSaWNoYXJkIExlaXRuZXIgPHJpY2hhcmQubGVpdG5lckBza2lkYXRhLmNvbT4NCj4gPiBUZXN0
ZWQtYnk6IEFsZXhhbmRlciBTdGVpbiA8YWxleGFuZGVyLnN0ZWluQGV3LnRxLWdyb3VwLmNvbT4N
Cj4gPiBSZXZpZXdlZC1ieTogTHVjYXMgU3RhY2ggPGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU+DQo+
ID4gLS0tDQo+ID4gIGRyaXZlcnMvcGh5L2ZyZWVzY2FsZS9waHktZnNsLWlteDhtLXBjaWUuYyB8
IDIzDQo+ID4gKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMjMg
aW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGh5L2ZyZWVzY2Fs
ZS9waHktZnNsLWlteDhtLXBjaWUuYw0KPiA+IGIvZHJpdmVycy9waHkvZnJlZXNjYWxlL3BoeS1m
c2wtaW14OG0tcGNpZS5jDQo+ID4gaW5kZXggNTliNDZhNGFlMDY5Li5iZTVlNDg4NjRjNWEgMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9waHkvZnJlZXNjYWxlL3BoeS1mc2wtaW14OG0tcGNpZS5j
DQo+ID4gKysrIGIvZHJpdmVycy9waHkvZnJlZXNjYWxlL3BoeS1mc2wtaW14OG0tcGNpZS5jDQo+
ID4gQEAgLTQ4LDYgKzQ4LDcgQEANCj4gPg0KPiA+ICBlbnVtIGlteDhfcGNpZV9waHlfdHlwZSB7
DQo+ID4gIAlJTVg4TU0sDQo+ID4gKwlJTVg4TVAsDQo+ID4gIH07DQo+ID4NCj4gPiAgc3RydWN0
IGlteDhfcGNpZV9waHlfZHJ2ZGF0YSB7DQo+ID4gQEAgLTYwLDYgKzYxLDcgQEAgc3RydWN0IGlt
eDhfcGNpZV9waHkgew0KPiA+ICAJc3RydWN0IGNsawkJKmNsazsNCj4gPiAgCXN0cnVjdCBwaHkJ
CSpwaHk7DQo+ID4gIAlzdHJ1Y3QgcmVnbWFwCQkqaW9tdXhjX2dwcjsNCj4gPiArCXN0cnVjdCBy
ZXNldF9jb250cm9sCSpwZXJzdDsNCj4gPiAgCXN0cnVjdCByZXNldF9jb250cm9sCSpyZXNldDsN
Cj4gPiAgCXUzMgkJCXJlZmNsa19wYWRfbW9kZTsNCj4gPiAgCXUzMgkJCXR4X2RlZW1waF9nZW4x
Ow0KPiA+IEBAIC04Nyw2ICs4OSw5IEBAIHN0YXRpYyBpbnQgaW14OF9wY2llX3BoeV9pbml0KHN0
cnVjdCBwaHkgKnBoeSkNCj4gPiAgCQkJd3JpdGVsKGlteDhfcGh5LT50eF9kZWVtcGhfZ2VuMiwN
Cj4gPiAgCQkJICAgICAgIGlteDhfcGh5LT5iYXNlICsgUENJRV9QSFlfVFJTVl9SRUc2KTsNCj4g
PiAgCQlicmVhazsNCj4gPiArCWNhc2UgSU1YOE1QOg0KPiA+ICsJCXJlc2V0X2NvbnRyb2xfYXNz
ZXJ0KGlteDhfcGh5LT5wZXJzdCk7DQo+ID4gKwkJYnJlYWs7DQo+ID4gIAl9DQo+ID4NCj4gPiAg
CWlmIChwYWRfbW9kZSA9PSBJTVg4X1BDSUVfUkVGQ0xLX1BBRF9JTlBVVCB8fCBAQCAtMTQxLDYg
KzE0Niw5DQo+IEBADQo+ID4gc3RhdGljIGludCBpbXg4X3BjaWVfcGh5X2luaXQoc3RydWN0IHBo
eSAqcGh5KQ0KPiA+ICAJCQkgICBJTVg4TU1fR1BSX1BDSUVfQ01OX1JTVCk7DQo+ID4NCj4gPiAg
CXN3aXRjaCAoaW14OF9waHktPmRydmRhdGEtPnZhcmlhbnQpIHsNCj4gPiArCWNhc2UgSU1YOE1Q
Og0KPiA+ICsJCXJlc2V0X2NvbnRyb2xfZGVhc3NlcnQoaW14OF9waHktPnBlcnN0KTsNCj4gPiAr
CQlmYWxsdGhyb3VnaDsNCj4gPiAgCWNhc2UgSU1YOE1NOg0KPiA+ICAJCXJlc2V0X2NvbnRyb2xf
ZGVhc3NlcnQoaW14OF9waHktPnJlc2V0KTsNCj4gPiAgCQl1c2xlZXBfcmFuZ2UoMjAwLCA1MDAp
Ow0KPiA+IEBAIC0xODEsOCArMTg5LDE0IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaW14OF9wY2ll
X3BoeV9kcnZkYXRhDQo+IGlteDhtbV9kcnZkYXRhID0gew0KPiA+ICAJLmdwciA9ICJmc2wsaW14
OG1tLWlvbXV4Yy1ncHIiLA0KPiA+ICB9Ow0KPiA+DQo+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qg
aW14OF9wY2llX3BoeV9kcnZkYXRhIGlteDhtcF9kcnZkYXRhID0gew0KPiA+ICsJLnZhcmlhbnQg
PSBJTVg4TVAsDQo+ID4gKwkuZ3ByID0gImZzbCxpbXg4bXAtaW9tdXhjLWdwciIsDQo+ID4gK307
DQo+ID4gKw0KPiA+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBpbXg4X3BjaWVf
cGh5X29mX21hdGNoW10gPSB7DQo+ID4gIAl7LmNvbXBhdGlibGUgPSAiZnNsLGlteDhtbS1wY2ll
LXBoeSIsIC5kYXRhID0gJmlteDhtbV9kcnZkYXRhLCB9LA0KPiA+ICsJey5jb21wYXRpYmxlID0g
ImZzbCxpbXg4bXAtcGNpZS1waHkiLCAuZGF0YSA9ICZpbXg4bXBfZHJ2ZGF0YSwgfSwNCj4gPiAg
CXsgfSwNCj4gPiAgfTsNCj4gPiAgTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgaW14OF9wY2llX3Bo
eV9vZl9tYXRjaCk7IEBAIC0yMzgsNg0KPiArMjUyLDE1IEBADQo+ID4gc3RhdGljIGludCBpbXg4
X3BjaWVfcGh5X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gIAkJcmV0
dXJuIFBUUl9FUlIoaW14OF9waHktPnJlc2V0KTsNCj4gPiAgCX0NCj4gPg0KPiA+ICsJaWYgKGlt
eDhfcGh5LT5kcnZkYXRhLT52YXJpYW50ID09IElNWDhNUCkgew0KPiA+ICsJCWlteDhfcGh5LT5w
ZXJzdCA9DQo+ID4gKwkJCWRldm1fcmVzZXRfY29udHJvbF9nZXRfZXhjbHVzaXZlKGRldiwgInBl
cnN0Iik7DQo+ID4gKwkJaWYgKElTX0VSUihpbXg4X3BoeS0+cGVyc3QpKSB7DQo+ID4gKwkJCWRl
dl9lcnIoZGV2LCAiRmFpbGVkIHRvIGdldCBQQ0lFIFBIWSBQRVJTVCBjb250cm9sXG4iKTsNCj4g
PiArCQkJcmV0dXJuIFBUUl9FUlIoaW14OF9waHktPnBlcnN0KTsNCj4gDQo+IE5pdHBpY2s6IGRl
dl9lcnJfcHJvYmUgaGVyZSB3b3VsZCBiZSB1c2VmdWwgaWYgdXNlciBmb3JnZXRzIHRvIGVuYWJs
ZSBQSFkNCj4gZHJpdmVyLiBBbnl3YXlzOg0KPiANCj4gUmV2aWV3ZWQtYnk6IEFobWFkIEZhdG91
bSA8YS5mYXRvdW1AcGVuZ3V0cm9uaXguZGU+DQo+IA0KT2theSwgZ290IHRoYXQuIFRoYW5rcy4N
CkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCg0KPiBDaGVlcnMsDQo+IEFobWFkDQo+IA0KPiA+
ICsJCX0NCj4gPiArCX0NCj4gPiArDQo+ID4gIAlyZXMgPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2Uo
cGRldiwgSU9SRVNPVVJDRV9NRU0sIDApOw0KPiA+ICAJaW14OF9waHktPmJhc2UgPSBkZXZtX2lv
cmVtYXBfcmVzb3VyY2UoZGV2LCByZXMpOw0KPiA+ICAJaWYgKElTX0VSUihpbXg4X3BoeS0+YmFz
ZSkpDQo+IA0KPiANCj4gLS0NCj4gUGVuZ3V0cm9uaXggZS5LLiAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwNCj4gfA0KPiBTdGV1ZXJ3YWxkZXIgU3RyLiAyMSAgICAgICAgICAgICAgICAgICAg
ICAgfA0KPiBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91
cmw9aHR0cCUzQSUyRiUyRnd3dy5wZQ0KPiBuZ3V0cm9uaXguZGUlMkYmYW1wO2RhdGE9MDUlN0Mw
MSU3Q2hvbmd4aW5nLnpodSU0MG54cC5jb20lN0NhNWIxDQo+IDhlYjNjNTU1NDM1Zjc5MzUwOGRh
YTJjMDQxY2IlN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNQ0KPiAlN0MwJTdDMCU3
QzYzODAwMTI0Mzg3MTIwMDk4MyU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpXDQo+IElqb2lN
QzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wJTNE
JTdDMw0KPiAwMDAlN0MlN0MlN0MmYW1wO3NkYXRhPUdZZ2h0dTJNMnRSVzBZODFsMEZyNHFHeFJJ
NU5HMGhrb3JqWjh0akMNCj4gSGJnJTNEJmFtcDtyZXNlcnZlZD0wICB8DQo+IDMxMTM3IEhpbGRl
c2hlaW0sIEdlcm1hbnkgICAgICAgICAgICAgICAgICB8IFBob25lOg0KPiArNDktNTEyMS0yMDY5
MTctMCAgICB8DQo+IEFtdHNnZXJpY2h0IEhpbGRlc2hlaW0sIEhSQSAyNjg2ICAgICAgICAgICB8
IEZheDoNCj4gKzQ5LTUxMjEtMjA2OTE3LTU1NTUgfA0K
