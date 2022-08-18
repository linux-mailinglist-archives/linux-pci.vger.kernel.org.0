Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962695981AF
	for <lists+linux-pci@lfdr.de>; Thu, 18 Aug 2022 12:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244180AbiHRKxd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Aug 2022 06:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243923AbiHRKxa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Aug 2022 06:53:30 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70041.outbound.protection.outlook.com [40.107.7.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755DD3F1DA;
        Thu, 18 Aug 2022 03:53:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f24qOiYHcBqwSpQm4y3R7CwMTzOQo4ohwb+Hdf6PuTjcfmWzs5kRRxDTUTSRX8uTUmn3J+tytwfcp04f0tE1Iymm4XOJjKSiSg1o2kwQMl68Npl6FS8rRy+ujCObltOmUhisaDHRpcD6OGuDeqBdNpEE1411u/p/EZ+hIORpErJJG10D6YGiSGVK4NcAlMMSaRAga45jf5VfXH5ptlL17CM/GWxki3dgor5Z8U1Tc0ZyrGIegpj/rzZ5xOxlO497DQhMarP8tVWyrWv9ABzIy2uzTiIRq98KC6ry3xiS/O/3a1K2+tUNLJOqtyP3M9N+5jWc2JNJFNGW13qKogQ6ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6qmZLjcEsDRiabVudTivWqj0gL1mNTTDL4Xh9YWufBk=;
 b=UfwmULNVoVkXvN8iiYE9ujBvu7/M/aK+BlYO0L0BNvzS3HGakRCqw2dHy01cJ4uOOz2NBe5WBZZckCiPvVmYcKcbANZ6i4lWeJfFg6X8oecjigbDRXXhHYoxFQDz+136aHAMYjJ7V7DSaBy1RqiZm9KxXnmbZQMBcum1nOt4dn0w78AWl0qAsxzdFO+b2I4Dh6OjyvjjiamJm+ESjxEExQRnw0PIjk42L0Ov5kDTtE/M3rcSmHsatxZE+cIQGfAlfDFzQGc/++eyyPsjgoq/QOkbm54tcKIRIyKO92MPGtjiz1PuFIRC2dpXrxjKaYsfa4GEncAk9nNaqIrMc05gww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6qmZLjcEsDRiabVudTivWqj0gL1mNTTDL4Xh9YWufBk=;
 b=Wk70SMsgaAFlLBx0qOD4MZq6y9yNwwWoenxl6vHF/UJ5WQKyb2BOXWp1yjhv+dgqopU1OxH8DCoGaXeswzJyywuCv2S6qEytaHwSYT/wqu30YM7FUTM8H9FISWzOVDblhqft/Eyyq7Cl3QGhOSYiVP7tj/YjYvfPV0pFBVwyGDU=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM5PR04MB3281.eurprd04.prod.outlook.com (2603:10a6:206:f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Thu, 18 Aug
 2022 10:53:24 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b478:43c4:f1df:d1ff]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b478:43c4:f1df:d1ff%5]) with mapi id 15.20.5546.016; Thu, 18 Aug 2022
 10:53:24 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        "marex@denx.de" <marex@denx.de>
CC:     "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v3 1/6] reset: imx7: Add the iMX8MP PCIe PHY PERST support
Thread-Topic: [PATCH v3 1/6] reset: imx7: Add the iMX8MP PCIe PHY PERST
 support
Thread-Index: AQHYstLgBFLirUeLGU22SE2/uWNoMa20WZmAgAAh0YA=
Date:   Thu, 18 Aug 2022 10:53:24 +0000
Message-ID: <AS8PR04MB867626BC5C32AA75466BB9E78C6D9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1660806153-29001-1-git-send-email-hongxing.zhu@nxp.com>
         <1660806153-29001-2-git-send-email-hongxing.zhu@nxp.com>
 <ddbcd90419e9bb4ce7c5b7b3055ee3227c179321.camel@pengutronix.de>
In-Reply-To: <ddbcd90419e9bb4ce7c5b7b3055ee3227c179321.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e9fabd7-e7a3-4ab2-5149-08da8107dfe1
x-ms-traffictypediagnostic: AM5PR04MB3281:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U3e+z/agFKCUbHQvlP+MU3WAOWtVqlP7aN6HuQyVqNV2+JhzTgpzPc1uyp42JqIXfTxO5QEaTSfxQBx0Uhez1X5ZSnIv+aQJj8iDZKE6AF3+zNquejFhRFoXhshlDbfw4dtdxm/K7Qa3veTmpoTpDZzwFb+nO4OQPOnxkim2DXvj84Tbglw2d+DRIyr0UpvnJNYv+yOZSwGSEdaGrwpjufzFu9DnsZwF+eVYbnrzkU4w4ZhL6vuEk3iZ6NPiEo4zhDU5Jz5cICzbqr+0x1mJS4tBAsz+DqXIygQDp5zGy+I7tJqAoVv/B4ZXfj/6ugf3TQDKi1RfoKUedT4DvXpF26SGqZh87Rz27QOASyij+s59B2QzFp8UKHnJRkEzWw9WJ4/JNmJY+p6hx+x6icdCpiSz5o3g7A22FACXFa8YcTaeJXBfi3TNG6bTlrKI03W/oaq8HpWyphEFEpn8GYO0w+q5b+qVWQV21u/CAtpClhxA3bIgK0OiLxIAd2iI2kXT3HuTmMX9FEV76S5phwRE8yIkkgLW77owrwdMU6AzHod6+4igrHx5LJxwfbFcyfeidXWr8F40974pBZr/hd/oNI3M2oVKYwv3tfgqY7LH7iPcv+WqWe5KBUmjCtmqrakzJAW6r2yIeQm3PnMpgkWmByFxzcIFMsntlybQP/88uPuIC7YuiXfN32FK3XnGcCyOfj/JqnYH64CFmqlU0DCN15s8cH+j+tTnpCr7Zlb5VQrnnmzf18Pk7rMtFtgUx6eo4JOZmFa0yx5B5S5+tRefrLHc3N7TNUJNuOtYIl7Kp4g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(136003)(366004)(396003)(376002)(33656002)(7696005)(6506007)(38100700002)(53546011)(41300700001)(44832011)(186003)(110136005)(122000001)(2906002)(38070700005)(54906003)(5660300002)(66946007)(66556008)(66476007)(4326008)(55016003)(64756008)(7416002)(8676002)(52536014)(316002)(86362001)(83380400001)(76116006)(26005)(8936002)(9686003)(66446008)(71200400001)(478600001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0k4VmhaY0VJUUtKVXVSNFBvazdROWpSUklRWUtmQWpHaFo1Sm54ZGNsV0Vu?=
 =?utf-8?B?Y04xeUQrbVgzNGJoT3YxNW9WMDluYVhxUFR1NkpZUWxCWG9BQm1aVzE2K3dC?=
 =?utf-8?B?b3RSZ2QzUmtkbWxQT1JtYzQ4dHFYaVNlSm9jb3ZpRlR4NGh3UG9GZDloRzJV?=
 =?utf-8?B?bWk2aGFxSXN3Mlp5RWJHbUxXdDBySitoTVViUVZ1SE1GbHVKL0RUWXlubGI5?=
 =?utf-8?B?QUpGV2t6Y004REFrdWY5Mmt5QUlnV25MeHBSVzBlU21MNVZGdk9YckptSmxl?=
 =?utf-8?B?aDJrejVublpJbW13bzdRZWxoc0ViKzZuWmtnWVV2WUdnQW9HN1o2dXpLWndn?=
 =?utf-8?B?R25XWXVhRWFVM0dSbWhocnBFUXFaR1llWjNtMG1MVlIzK1l4M25zdnBKUnU4?=
 =?utf-8?B?dU85M0JZTVFnRzFaZnJVVVdlQmRxRkpJNVMxNWNFajhhZ0VmNU1SQnVRcFVl?=
 =?utf-8?B?QVZyUysyYmJoRWFTRzB0cVl1cXJZOXRLZ3I1SEExQXc4V0RBeitCVjhZY014?=
 =?utf-8?B?UEF6ZUt6aTZsQjNPNE9jMVdGRGFNT0pyTlZrMDdoWFRnN0RUeHFkU1I1VWVV?=
 =?utf-8?B?dFdTQUZiOE9UYnpWOUlUNlAyV3V5MXhTRVViOXB5c05TOUh1bVpXUHdCTHlN?=
 =?utf-8?B?VEdBdnFobUxQUXdlSjNGMndia0hrZ3F5bERVSVNiTnFnd0ZhTHZwblVIeHZr?=
 =?utf-8?B?Rm1mVVdKQ1ZORXN1WjQ1NHlpRUZzRGptOVB2RDVCb0ZJSVVuUnlkK2dHaXAw?=
 =?utf-8?B?MzhDWGwvb2lLQVBxZ2FrZEdRQWhhM3NsbzEzSDkzd2NHTkFKc2NvT2NDVVhv?=
 =?utf-8?B?MWVJSE9ZQjlUYk14bWdmZUZZV2J5RGxmUW1EN0k3Q2RpVXhwRzI3RkN3UHRV?=
 =?utf-8?B?dnZIdmdXeGdNOUlQZGIvQW05R1h1UDM3OXpud1RER2lObWx0TEtVeWFDYndC?=
 =?utf-8?B?VjJubTNwN2FEVDRKUlNrNy9OUGhNUC9WUUNvNWtYMVdIeGVNaENaK2kzVnUv?=
 =?utf-8?B?ZitWMHhZVzFkWlhYa2twV0JmOWk0VDUxYTBLdzFoKy90OEVTa0p3QXZZeE95?=
 =?utf-8?B?eEx6L243NkpjdDF5UlQyUUQ1RVRuMFZ0SVl5elIzbVBFVk1UUnNaUFdJbnJW?=
 =?utf-8?B?RjZOOThEQTlQckR0MURxYldZMFY5KzVDWlZLQUJXMmUrU2VYNlp4cG9NNnhN?=
 =?utf-8?B?MCtKRzY1T0ZpTUoxbTVsSWljTEp6bTdRWVVFaFRtMGg2WjlGeWNzOGhCd212?=
 =?utf-8?B?R3dobk1ReFRiUGJsMGVCTDFkOXFielNWVHBiTDNiNEpxVjFGNU9FTTdDVXBC?=
 =?utf-8?B?OEw5RkRJWkdadU04dkQyVXh4Y1lENUhLMEM0bVh6Y2NxZEtEVGxTSkJMME5i?=
 =?utf-8?B?ZGM2WURWY2lEZXRJQ01TOTJZbTlNSGVTOTBkNDdPVzZXNDFPQmJ2NVRGSE5u?=
 =?utf-8?B?dmszU0xPWmpqbStEeWdWYlI3dExsdW5nSUVMejM4NWIraEdOYlJoQ2pza3BR?=
 =?utf-8?B?TUhyZ1hXZkdBUmJEaHA2M0RreTFZcTRNMzAxTytFSDVTVlkzbjZ4U0xzZ2JX?=
 =?utf-8?B?ZDl4amh6MXh1MWRCZldtSzFuRlcyRE9QcGg1T3dNTFdXUHFTYk5iRld1RWUr?=
 =?utf-8?B?VlJ6c1pFUlhIR2VDVU84N3RrV1B5VC9GK0V1WUxuMXhWYzR4RWdXTmRwejFP?=
 =?utf-8?B?S1RRRmU5WWo2eGFqVUN6cExqWDV4YmJvQTd0UGhaUVlpMUNsQnBZVVVHeHdV?=
 =?utf-8?B?SUwzYU1yOGtjNnRmYm15b3ZTQWlaUERqUkRNN0pMMEhsUWM1V3krenpSaEVw?=
 =?utf-8?B?R1dDZ2k0cks1RTFxZDA2Tmd2ekFYOHN4b0hoQUdBQVdLVURnMy9PMmIrV0Nw?=
 =?utf-8?B?VlJtQ2FPekRnTWpZT0FlTXlIUFR1T2lkSHduWEkzellVcEtVeGUwUDNVcm1O?=
 =?utf-8?B?SjMwY1VDY3NVYU54VUlGVXNKZXRad1dvNUNMMklsRVJ1SnR6SDd2STJhaksz?=
 =?utf-8?B?L0xMT1Vxd0c1QndjdEFwdWt6ZVZUVm1kZVpRRS95N3lFeW8vKzk2aHRjSFp0?=
 =?utf-8?B?SmdGRFFFdzFtVitiTVhvZGdvcThkV1RSemljQ0preDU5Q3NJNE12T1dVK0x5?=
 =?utf-8?Q?Wu9ZIQ+Dp92fWv7krA+/WBw8P?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e9fabd7-e7a3-4ab2-5149-08da8107dfe1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2022 10:53:24.6560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DF8hJRqZf7l3pyno6+dyGvTRR8w/4vtcEq4YypDN2YUXyjECwFdi95XjZQfdw1ZyknU+Ge7FsQjpMlncOyWK4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3281
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQaGlsaXBwIFphYmVsIDxwLnph
YmVsQHBlbmd1dHJvbml4LmRlPg0KPiBTZW50OiAyMDIy5bm0OOaciDE45pelIDE2OjUxDQo+IFRv
OiBIb25neGluZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPjsgbC5zdGFjaEBwZW5ndXRyb25p
eC5kZTsNCj4gYmhlbGdhYXNAZ29vZ2xlLmNvbTsgbG9yZW56by5waWVyYWxpc2lAYXJtLmNvbTsg
cm9iaEBrZXJuZWwub3JnOw0KPiBzaGF3bmd1b0BrZXJuZWwub3JnOyB2a291bEBrZXJuZWwub3Jn
OyBhbGV4YW5kZXIuc3RlaW5AZXcudHEtZ3JvdXAuY29tOw0KPiBtYXJleEBkZW54LmRlDQo+IENj
OiBsaW51eC1waHlAbGlzdHMuaW5mcmFkZWFkLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5v
cmc7DQo+IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsga2VybmVsQHBl
bmd1dHJvbml4LmRlOyBkbC1saW51eC1pbXgNCj4gPGxpbnV4LWlteEBueHAuY29tPg0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIHYzIDEvNl0gcmVzZXQ6IGlteDc6IEFkZCB0aGUgaU1YOE1QIFBDSWUg
UEhZIFBFUlNUDQo+IHN1cHBvcnQNCj4gDQo+IEhpIFJpY2hhcmQsDQo+IA0KPiBPbiBEbywgMjAy
Mi0wOC0xOCBhdCAxNTowMiArMDgwMCwgUmljaGFyZCBaaHUgd3JvdGU6DQo+ID4gT24gaS5NWDcv
aU1YOE1NL2lNWDhNUSwgdGhlIGluaXRpYWxpemVkIGRlZmF1bHQgdmFsdWUgb2YgUEVSU1QNCj4g
PiBiaXQoQklUMykgb2YgU1JDX1BDSUVQSFlfUkNSIGlzIDFiJzEuDQo+ID4gQnV0IGkuTVg4TVAg
aGFzIG9uZSBpbnZlcnNlZCBkZWZhdWx0IHZhbHVlIDFiJzAgb2YgUEVSU1QgYml0Lg0KPiA+DQo+
ID4gQW5kIHRoZSBQRVJTVCBiaXQgc2hvdWxkIGJlIGtlcHQgMWInMSBhZnRlciBwb3dlciBhbmQg
Y2xvY2tzIGFyZSBzdGFibGUuDQo+ID4gU28gYWRkIHRoZSBpLk1YOE1QIFBDSWUgUEhZIFBFUlNU
IHN1cHBvcnQgaGVyZS4NCj4gDQo+IHRoZSBkZXNjcmlwdGlvbiBpcyBnb29kIG5vdy4gSXQgd291
bGQgYmUgbmljZSBpZiB0aGlzIGNvdWxkIGFsc28gYmUgbWVudGlvbmVkIGluDQo+IHRoZSBSZWZl
cmVuY2UgTWFudWFsLg0KPiANCj4gUGxlYXNlIHJlcGxhY2UgImFkZCIgd2l0aCAiZml4IiBpbiB0
aGUgc3ViamVjdCwgYXMgSSByZXF1ZXN0ZWQgZWFybGllcjoNCj4gInJlc2V0OiBpbXg3OiBGaXgg
aS5NWDhNUCBQQ0llIFBIWSBQRVJTVCBzdXBwb3J0Ii4NCj4gDQo+IEFuZCBhZGQgYSBmaXhlcyBs
aW5lOg0KPiANCj4gRml4ZXM6IGUwODY3MmMwMzk4MSAoInJlc2V0OiBpbXg3OiBBZGQgc3VwcG9y
dCBmb3IgaS5NWDhNUCBTb0MiKQ0KPiANCj4gV2l0aCB0aG9zZSB0d28gY2hhbmdlcywNCj4gUmV2
aWV3ZWQtYnk6IFBoaWxpcHAgWmFiZWwgPHAuemFiZWxAcGVuZ3V0cm9uaXguZGU+DQo+IA0KSGkg
UGhpbGlwcDoNCk9rYXksIHdvdWxkIGJlIGNoYW5nZWQgaW4gbmV4dCB2ZXJzaW9uLg0KVGhhbmtz
IGZvciB5b3VyIHJldmlldy4NCg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0KDQo+IHJlZ2Fy
ZHMNCj4gUGhpbGlwcA0K
