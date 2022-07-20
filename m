Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98DC857AD3D
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jul 2022 03:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239785AbiGTBkx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Jul 2022 21:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239664AbiGTBkn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jul 2022 21:40:43 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2057.outbound.protection.outlook.com [40.107.21.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98F169F09;
        Tue, 19 Jul 2022 18:31:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehcUdjbCQbcOnjA/AE5M1tvBZnIJOtH4xfdyfKrQRkIt7WTYWxEfJl/hrKSP0a4yrVgKlYQBDMqNb83JVT6tCeHcXwyXs0At50WxcCz9PSC+TfPCTi5ejN8bFa5/vzAdjr0/e6ejuRaACIgUr47JBwbVFz3LNOxSsP0aIQLJ/D2h0FmN9GuiR+vdkdF7+pZpDs2HHy+wIsH+Bpyu+TwvbpQ4w4a3l2cFGypd+j4NFfwqlfHMjqglDQEWI6SB3oK5zQBwBjNOzpLf944g/jHMRHzKeJ4NbQkTsSgmslBulDo1PdRtsdsVI4wP2tuolFE4gAhSDx6uDoSCjNWEp3JZbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZjRPCqQLNyr2KA+qyDaHWOMBmUkd2fYjHDZn9tJDzHk=;
 b=IWMpdbshLY8V2v9vTh1Kj5MAaGaLtSHTT7ubksNrIriEvIT9agqrVp7uIrpSq6gWmxc+3Z3qKz42guXKozqflzzgNKJEYLMnz7DMeHDJxI2Avl2T2lkeorfck8K7Mofza7dDos9KhuQHgCfQsLWjydNjPtyIlFzBO71NuIZHCARMFgVKakE8VUE5FH+lJt5VoF8dJez7aLa8mvIpaf6jlSUo7Z4jKeEQx9swFTrha2fI9bHR8RWmFyvQM1mAAPp5ewWczJQ3mnido5bCTR0YsX0FnJRswjY5PY/wGXhXIFSmkboX9EXXVbuudLaIox2ZvK+qD84W90tntITNbULkUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZjRPCqQLNyr2KA+qyDaHWOMBmUkd2fYjHDZn9tJDzHk=;
 b=YZZsSLE83M5IRerc1yQX76RKLO9zhCXxr0Rb1ChQ2olNXYbloxSlUv//1pwQ9EWzkH9SCa2aSUng8aaKxkt9r+YVrhNOjTGFNBzUgIuBNnr/E1w0koQMVB9biRYYWnBaXAdpIBxtKqZm9uOrCY9Iaki4ztTgY0pfPlejRgQvEcE=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by VE1PR04MB7310.eurprd04.prod.outlook.com (2603:10a6:800:1a2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Wed, 20 Jul
 2022 01:31:41 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::75c6:afbf:7972:6c6f]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::75c6:afbf:7972:6c6f%9]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 01:31:40 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Rob Herring <robh@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: PCI: fsl,imx6q-pcie: Add missing type for
 'reset-gpio-active-high'
Thread-Topic: [PATCH] dt-bindings: PCI: fsl,imx6q-pcie: Add missing type for
 'reset-gpio-active-high'
Thread-Index: AQHYm7md1FHMJ4r4ikaeEhoBsmsmfK2GeDlA
Date:   Wed, 20 Jul 2022 01:31:40 +0000
Message-ID: <AS8PR04MB86765812D480774505C334C38C8E9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20220719215031.1875860-1-robh@kernel.org>
In-Reply-To: <20220719215031.1875860-1-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 64c80b24-4fc7-45c2-07a9-08da69ef98df
x-ms-traffictypediagnostic: VE1PR04MB7310:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NNrYbdxLISdZdW4Nzotdrr6c4xFNozROGzITjS4z6qD6XYyfz09eWU7Xdn925vBgAAuz/Cw2qJHNrCXGuyQwD03mB7lb4vK1HNzTA1U6lGg5eXP7aPnW0XRkVZai9ZZ65EnBqpRUIG1xUjaZ3sueHZbsToFze5GjVKmXe+skYeEpvjqZSzSIn4d5Ms5NBtTl1EZBt1TEUoyhfjHh+6Gytlv7nqxHiDybCVo+NBg3vbaWGm9PY6KN451fq/FcXfpzNDDMRtGOsxPeBissZp3kshdxcoqzeA1dW1DbUOAbebKLcfn9+lafGp9gAJ8X/QviACvM22F6wDCvJnSC71wfa7waz7Tc9yD5KsQRN6i8Uum52RggZRn2rdgY871xkcsHRvujg9evr25U7R3g5Q1IaoYxg9S942FcwelhVVxB+40CxUGAY1Q8IEMzPa+zweIN+lBLTDfdYS87Ohep2houOFfzA0rvBfqCNb+ycfJGqUn/uTKe3p/820VkipfSqWWGfuvTRkUJazpNP1lPhwIj1daBqXdarpa6TFYuJDYxQtyb+yqSACt0RUSf0jLeLpcIEGRMYHULbhA5a1uyQ119uoivIUlkkhtA3PTOrFSYdYKa7EstMOEGkc56g2mt3X2SiYrMFHeIX6qAFeG4rWjWkNqg/pPJlJ45aC/ZgOpaP10B3DdfrJ/LoO/5OHrlfO6CMmD2kJeN/RtMv5xW4zRDaXun7M9k044+c8Dch+9hijEidqiBYGsLTwHx50IdBDxrAOCmVdHvEGeR8Yxp3jnkYk4LzRgv+oSbbe5pyig1+bH0BgoG2Ap0yqJqnF4m8YLK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(136003)(39860400002)(366004)(376002)(86362001)(2906002)(5660300002)(7696005)(41300700001)(9686003)(53546011)(8936002)(71200400001)(122000001)(7416002)(44832011)(33656002)(52536014)(478600001)(38070700005)(6506007)(4326008)(83380400001)(26005)(186003)(55016003)(66556008)(66946007)(6636002)(64756008)(316002)(8676002)(110136005)(76116006)(54906003)(66446008)(66476007)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?TFZzWFdRaFRHcHNnZnlPWi9UdmxzYnFPbitoVWhXSGdrZVhCWGVhSFJEWDI4?=
 =?gb2312?B?Z2t0QWFYdEFJNm02MVJ6Y2tHVDc0bVhyMEppODQzNzZKSk9tZDBlZkZ6THpP?=
 =?gb2312?B?R1BiN1lBbjRlaU80eTZHS3BxSlVDWElvdUIySkQyZHFNL0xiR1RRYmVYejRZ?=
 =?gb2312?B?NlR0OS9JdTIycGRpdFlZZFB2bE53TWkvUEtVL0NaSVlycFRZekFiZmx3M2FX?=
 =?gb2312?B?REJOWnBjb1ZtL2wwUDBsSklZYTB1d2c0cno0QzdHQkN5QWZBR1lOYTJHQ2dS?=
 =?gb2312?B?VHB4dEtOdWRsUWsrZCtsdnRoV1h3TG9jNEpGRGtldE9ROXhJdnVTdGZrWldB?=
 =?gb2312?B?cFFHeTJOQWhTR1lJZ0RUemxkQmRkdklWNDNtOUxjVkVCb1hPMW1WdEFQU3RY?=
 =?gb2312?B?YWsvZ0JHSGdwWmt6cDFrV09NTmdqWE15Y3pibFlyNC9QNHBDSVROR0ZTVi82?=
 =?gb2312?B?UmVVQk9ZSWRvNUU3Qk9MM2lTRDRKdGZEVnB6dGxKbTdGVVlzeE5TWEwxSzZX?=
 =?gb2312?B?Q3ovMmRvK2d1YkxxeFY2aFBDNVNuSkFKWno5YXViOGhBZ2FKUnRXelJGUWtv?=
 =?gb2312?B?Z3I3bThvWGtCMVJTdFBaZ21nU3JITmV4UzlISUkvT3c4WGFGWDFDZkxSd3M1?=
 =?gb2312?B?TWpxNEI2a2dLYi9VNlZ1U1hqYSsvQ2Q2K1E1M2xEMllUdS91TDFBOUptTmJP?=
 =?gb2312?B?NkhZYnJmZnM4dERkV05aT2QraHU1SW4wdEFBanU4dk5FSXk2K05pOWlJQytu?=
 =?gb2312?B?cWQrWlBZRG5Ga0F5OHd5MWpwNStGQUtaQmNCL0d6T2ozM0dLQWs5NXd2Zys0?=
 =?gb2312?B?OGdjNERiZWpveWIzMjRnbjVqSklpY1cyd1Bvb1pXWlp0WEJpZ3h3Q0VqaWY4?=
 =?gb2312?B?dEI4SC9CWUFpWDAvZ0EvTFNNVi9yZ04zQ0FjQVBNekFmS2FDMHIrS0dCMHpY?=
 =?gb2312?B?Mm40eGxXbVlxV2NoWk9GQWpNeVNDRU1ocTRzQWxyNXowU1E2L3NRejJmbjB4?=
 =?gb2312?B?aWEwUWptK3RZdUE0WTVhbzV1S2ZHUThFODdDcWN1TlVoSlg0QmtBbWp4WXht?=
 =?gb2312?B?dzJnYko0KysrNWNVejc0L0NvUm1CcDRaaDIyRDNKcEZESVVQazdHR09VU2Q5?=
 =?gb2312?B?SjFLZVlDMXhkYk5FNTFYQVJyVFBvaEtsbmF5SWlaTUJFSnEzMy95VGpPUWpD?=
 =?gb2312?B?WVNjR1JYOWEyb1VFTk5XUG1QVzhhL1ZjRDk3UjJiTjFxaWRsbnRkTmxGUTlS?=
 =?gb2312?B?WkRLRDVTQUVmNHRJZ0s0c2NWcENja3h5cm9aS083T1NiYUl1UG80SnNleTNs?=
 =?gb2312?B?cnMvRXFKVXhuZmpkYmgrT3NUTzYyVlVNM0xIbFNlQ3VmMmF3d09MZDNpU2h5?=
 =?gb2312?B?YVNMQVNVY1F2SXlOSWpKWkR3QWYyZU1ickhoTUR0cDJOQUhzamFoR0tSdno5?=
 =?gb2312?B?TEFFazVUYWU0WDRtVlVvTlJ2Snd5ZU85MVRDSFZCM2FjdTdZL1F6KzhuWlRp?=
 =?gb2312?B?dE5QOTBJY2p6eFhLV3QvSDFRQlptNHIya3dmZG1SL3Uyb24rTGRkL0wzL3Rx?=
 =?gb2312?B?MW93eksvazdDdjhValh4S0NSdytVa3J0TlZMUDE1YVJYQkZrNHFrT1JDZm5M?=
 =?gb2312?B?YTBYbTdxR1FYM09mYm9iUEhyTXpKYUd6amRCRnRHY2Q4MjdvQkw3U2Vadk0y?=
 =?gb2312?B?K0dKQkJTUTk4RVJ0c2MzdW93czVXODVFZGxLSlprbkpmbjJyck5kN2RyQVRs?=
 =?gb2312?B?RldTa0ZzVWFvOUVlZndheVU2UjBNbHluU1lqemdBS0RYeHBzRTZWUnVtdlFF?=
 =?gb2312?B?U00vZ0dtb09nT3pXZ1hpQUpYTk9xTmNveHFQS3VoN0EwbC90b1E1MFVia2xj?=
 =?gb2312?B?b0lYeXF6aGE4czlSMnZPbzUwKzVlTTNka2V2c0psWG5KWGZzcUQ1WTRxeEVh?=
 =?gb2312?B?N3Exc3BCNVZLOC9RSGpiTkNnWVdIRWtVclZHbkFOaGE4SHBpUklpUnk2WW5i?=
 =?gb2312?B?YWhCc1R2VTVwK0s3QUpNTnRZditmZ3daZUhxRVZXMVZDUjl0ckxIVEUzdHJx?=
 =?gb2312?B?MDNtRjBxYmwyNnJ0OEVLRTZmeDlsN3NCQk5lejVlZk5Oby9wNVZocGROMHZm?=
 =?gb2312?Q?jLz/zb2jkeKQjTfg7I1rhio1a?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c80b24-4fc7-45c2-07a9-08da69ef98df
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 01:31:40.8731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /zxIy5b3O3DcsVA07v89mhhv5LfY9gJRxsrxwH+cTB5TdJfhOGB5KsWazOd+c+fZMZCibr357TT9zsm7OHaJRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7310
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgUm9iOg0KVGhhbmtzIGZvciB5b3VyIGtpbmRseSBoZWxwLg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQo+IFNl
bnQ6IDIwMjLE6jfUwjIwyNUgNTo1MQ0KPiBUbzogSG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVA
bnhwLmNvbT47IEx1Y2FzIFN0YWNoDQo+IDxsLnN0YWNoQHBlbmd1dHJvbml4LmRlPjsgQmpvcm4g
SGVsZ2FhcyA8YmhlbGdhYXNAZ29vZ2xlLmNvbT47IEtyenlzenRvZg0KPiBLb3psb3dza2kgPGty
enlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZz47IFNoYXduIEd1bw0KPiA8c2hhd25ndW9A
a2VybmVsLm9yZz47IFNhc2NoYSBIYXVlciA8cy5oYXVlckBwZW5ndXRyb25peC5kZT47DQo+IFBl
bmd1dHJvbml4IEtlcm5lbCBUZWFtIDxrZXJuZWxAcGVuZ3V0cm9uaXguZGU+OyBGYWJpbyBFc3Rl
dmFtDQo+IDxmZXN0ZXZhbUBnbWFpbC5jb20+OyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAu
Y29tPg0KPiBDYzogbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBs
aXN0cy5pbmZyYWRlYWQub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBbUEFUQ0hdIGR0LWJpbmRpbmdzOiBQ
Q0k6IGZzbCxpbXg2cS1wY2llOiBBZGQgbWlzc2luZyB0eXBlIGZvcg0KPiAncmVzZXQtZ3Bpby1h
Y3RpdmUtaGlnaCcNCj4gDQo+ICdyZXNldC1ncGlvLWFjdGl2ZS1oaWdoJyBpcyBtaXNzaW5nIGEg
dHlwZSBkZWZpbml0aW9uIGFuZCBpcyBub3QgYSBjb21tb24NCj4gcHJvcGVydHkuIFRoZSB0eXBl
IGlzIGJvb2xlYW4uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBSb2IgSGVycmluZyA8cm9iaEBrZXJu
ZWwub3JnPg0KQWNrZWQtYnk6IFJpY2hhcmQgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCg0K
QmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0KPiAtLS0NCj4gIERvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9wY2kvZnNsLGlteDZxLXBjaWUueWFtbCB8IDEgKw0KPiAgMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9mc2wsaW14NnEtcGNpZS55YW1sDQo+IGIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9mc2wsaW14NnEtcGNpZS55YW1sDQo+IGluZGV4
IDI1MmU1YjcyYWVlMC4uMzc2ZTczOWJjYWQ0IDEwMDY0NA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvcGNpL2ZzbCxpbXg2cS1wY2llLnlhbWwNCj4gKysrIGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9mc2wsaW14NnEtcGNpZS55YW1sDQo+
IEBAIC0xNDQsNiArMTQ0LDcgQEAgcHJvcGVydGllczoNCj4gICAgICBkZXNjcmlwdGlvbjogSWYg
cHJlc2VudCB0aGVuIHRoZSByZXNldCBzZXF1ZW5jZSB1c2luZyB0aGUgR1BJTw0KPiAgICAgICAg
c3BlY2lmaWVkIGluIHRoZSAicmVzZXQtZ3BpbyIgcHJvcGVydHkgaXMgcmV2ZXJzZWQgKEg9cmVz
ZXQgc3RhdGUsDQo+ICAgICAgICBMPW9wZXJhdGlvbiBzdGF0ZSkgKG9wdGlvbmFsIHJlcXVpcmVk
KS4NCj4gKyAgICB0eXBlOiBib29sZWFuDQo+IA0KPiAgICB2cGNpZS1zdXBwbHk6DQo+ICAgICAg
ZGVzY3JpcHRpb246IFNob3VsZCBzcGVjaWZ5IHRoZSByZWd1bGF0b3IgaW4gY2hhcmdlIG9mIFBD
SWUgcG9ydCBwb3dlci4NCj4gLS0NCj4gMi4zNC4xDQoNCg==
