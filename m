Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273495A5D69
	for <lists+linux-pci@lfdr.de>; Tue, 30 Aug 2022 09:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiH3Hwg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Aug 2022 03:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbiH3Hwf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Aug 2022 03:52:35 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50050.outbound.protection.outlook.com [40.107.5.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4862D98594;
        Tue, 30 Aug 2022 00:52:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jrQlMcaKXv4qvViY1ftEtlAg/qCNynqaF02OdUB+BsE9vBcEroUCTSggNNBXwApgxPnq2nZrqhJxafG84GP4cOIK2gFHK7OAX1Js1BLa2LIzy2eD/8aZCv43c5NsctiPGK/cEFFegvWaU4I6WrV4+2kGp4QKcYy6O7K8i2tBcbCysSPqa8YtmsHpCtIcVBknrtk4+oNheBqw8qdkfLt/vCiKNeSWG0Wwk7WPn8xs7OxxKTckp30AG9w/b4iMo5cnTL2Yf0aEG7B9iBr/j5Wj3cbL0/fn4cHyHX9nBqh3abts6fi4E1KiqPOt1HUuuTQ+HdtVNaJ7M7IsEfESe0wcPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/AHJTV0fq4BBEpp+XpAj6mR1B2MPQgyRwXRnyXXJzx0=;
 b=HHDyyPYy9d2bjDkwzadceUqBVkc9X/jCmxnDTGmVbSWCuH8Ghnw0OLd9e+hoOvn4Z6G7tqOyF09dwBkXPTHTG08Gd194ai1g+3U6Ta3tN7njm6trG/8uePAQqzHIaAtoWZHfY35rapb8q8NTx1t6mEj7VvkDydclp4nVJ/9+3Vu7PgZXFgT+Wm6n0SZFPMkgrK+E6lmBR05Cq8aVXL4w57IrGTnpBouVQ0xzpwJjAMWhxIyoMHZTkSLmKtOU/8/jVnWRXA/j1enUQ6E+9Hv1p7uZFX6N5rxkLg1tpoQvUyxQGWX+Ls9wHr41gON+BEg6YBbVO4NvdQuuhhtu6I35sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/AHJTV0fq4BBEpp+XpAj6mR1B2MPQgyRwXRnyXXJzx0=;
 b=MweozHh7drY0ijr3eU4JzYghCtFoJUxXsDc9lohxfAK+qFKXOfwoBI66O6rl5Pva6JDZleeMXzIBs1vVIKrLcrJE63LfoTNyQuzFfh0zPKowKEa3jlKFuno9b+eXLbHF5dSk9AdABv/N8ywgRtWOXy+q4LxwBzGE3ZgHQaK1bgg=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DB8PR04MB5913.eurprd04.prod.outlook.com (2603:10a6:10:ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Tue, 30 Aug
 2022 07:52:29 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::13c:5622:af8a:b2da]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::13c:5622:af8a:b2da%9]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 07:52:27 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        "marex@denx.de" <marex@denx.de>,
        "richard.leitner@linux.dev" <richard.leitner@linux.dev>
CC:     "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v4 0/6] Add iMX8MP PCIe support
Thread-Topic: [PATCH v4 0/6] Add iMX8MP PCIe support
Thread-Index: AQHYu4Hu08U8y45hSEKj6wR6lhsy2a3F/qWAgAC8HYCAAFdiAIAAAICQ
Date:   Tue, 30 Aug 2022 07:52:27 +0000
Message-ID: <AS8PR04MB867602E1E563CC8298D340A18C799@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1661760917-9558-1-git-send-email-hongxing.zhu@nxp.com>
         <c668fff254b9f56b699a2714bb8c016e3b0cc5b5.camel@pengutronix.de>
         <AS8PR04MB867602341382CB5D63379DC88C799@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <6c02b8af4c887eb58ccf03d0ee107e2f5c7f17de.camel@pengutronix.de>
In-Reply-To: <6c02b8af4c887eb58ccf03d0ee107e2f5c7f17de.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4f55ef1d-e92d-45f8-ab73-08da8a5c9561
x-ms-traffictypediagnostic: DB8PR04MB5913:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T/Lzujz70ITVZv+BY4whE1CgEzP97ovM//zYKUFjX8HQIFkOYrfhEWhCrWOqSJcbcGN0juTm63NWPTdmhGdcTDfbd7Shg0dMxVSUyjGdFg5CeC6h9UIkpxjU2/o+pgkJ4WAVyrH5yAQv2nHcYcyEPcYCXnMbCuPAX0g/M+9RexUuJY95W2gdV0o6MYpH3vLfbmTCwR5muyOn3lmuoxErl+9ciOSNO2cwdQyCGHpsjUHPa1gx5s4xgVfjT3ZkgjKYpe2EpjiGdFUK2ZYefi/Z9oeSMjogDH3gAcQPVnij75k/I8CB+WglMGCQZlmv7ZzFKrabwdkD53DRgnbjnpp1U/qsJFy9LOnvzZxQvNfl7mtd0oFL2Tvs25VZhfPCLTED79ZeiILELxzROBGZPnZAQCByXb5CLUHjrnWE00PofVhTkoZsOaZ7PkOOq3Y9KdGf8w0EV6OLHv6PoWF0c5lXn5WxsuH2YaqdN56dxJFSUn8DMHu0ZagkH2ZPYbFhLMQRE9sN06FZVq02whlNjaYcA+NM16CvA4e2yzuGPcxbwj5xLucOCW3WK6DkFeCaKQTdMoa9e42OvmvWisopYOtCsGq7MYy9lKtYESoWpNw7sYa3HD6rpgda79jfyIKwFHTVM7hhi5nVV43/owW5vBKblmfp+GYsyvuF9fAVkgZ8VkxmuQX3wyGs0sO6JIqm8semnsv6y2ILygHb7WbvATk6X6qE7x7jDwxyVT9Cn2z1vhXLFaoxThdBDbpIu9irajnx9S0OylACD5cesxM0B1IYtv3hf34dXQMHf2FwyHS/KtgGt3vs52W4POrIXON5gi65
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(478600001)(53546011)(26005)(7696005)(71200400001)(83380400001)(6506007)(9686003)(186003)(41300700001)(2906002)(5660300002)(52536014)(8936002)(44832011)(7416002)(316002)(66476007)(55016003)(54906003)(110136005)(38070700005)(4326008)(64756008)(66446008)(66556008)(66946007)(76116006)(921005)(8676002)(86362001)(33656002)(122000001)(38100700002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TWwrV3dWaWhKVmR5bS9jQ1FIS3lwUEtwUXI5WTZUaWc5ZGNiQ0hiVlVaSDJD?=
 =?utf-8?B?dlprY0VCWThGZ1ovaTFweXFNeWo4UEhwdC9HZGlMNUJZT0U0MTRFRkFOOGFV?=
 =?utf-8?B?WXRiaWhjeUhRcFBCa3k4cHVHc2RoWStuYlExVU9JK2xTQ09LSTgwd3JFK3Na?=
 =?utf-8?B?YThYOWRza2FwbUdKSTd0anF1dEo3Y1hET2s5eC9QdmU1TjcrZ283VlhQTURn?=
 =?utf-8?B?eWtMMjNiUi9hNGhzcVc0bnBBMlAzSGkybWxpUDlqRmxZMGVUcHF1WTNmVjNW?=
 =?utf-8?B?TlAzT0VoWEMya1BWMjVLSW5iZmxjSTM3Zk8wejdSank0cHI2aGF0clQwcHhD?=
 =?utf-8?B?U2N3ZDNoM2prSjBHenhlaTkvQTh1KzBVWTZuenhxTkpmS29kNHB0eUcvVXR3?=
 =?utf-8?B?REhSYkpiYUc0b3pwZ0duSXdnT2NkTWlZNUN2cklwbmR3QWg5cTFJWmE2TGNm?=
 =?utf-8?B?dG1OZ1Q3ZVlmRzAwanMybTBmNmFBSFBVR3ZrZXR6WTBlQ0FaT2crYWU3VjlI?=
 =?utf-8?B?aVJZalFIMmhQdkVkMmE1NGMwaTBCSVludUNPTDl1SjhsY2NSTDROdlBHMWFT?=
 =?utf-8?B?eHBZTGk0UGhQYXloNlpnRVNxR092WFdlVkxVWkt4b0gyTkx6dXZralM2MGda?=
 =?utf-8?B?M29oUG9zdGpNQ1Fxai9CQy9hWnlybFNJUnBzTXJSUDJlYlRmSGNCSlZ4Mldl?=
 =?utf-8?B?ak9HTVd3MDZmVlNTTVhGRnVOZG9reWtOcUxjWFZoMkVLZmxmb2VCV0FjS3c1?=
 =?utf-8?B?VlB6VTlVdWd6ZUdwcnpGQ2dzWHFKZ3RrbFRTZHI2alNZVTBYS0Fsc3M0NWt1?=
 =?utf-8?B?K05BVUJidVprQlhCRDZRUnN5YTg3YmNhMHZPWWVpSElobDJlU3lYRXRxZk9m?=
 =?utf-8?B?Q1FkZzB0SkV6WWVRNmtrdEU0NTg0RktybnhRUGg2STJCMkw3cStYakpWb3pW?=
 =?utf-8?B?V0x2RlJXVjNOUmg3SFFzTWk0b0lyb0NOcDdFV2ZDdlRNTnlYaEtLT25CQnpk?=
 =?utf-8?B?MS8xcDR3bk1CbG1kdTc4YS9KS2lIYXFJakp3c0FZeWpNUWF3d0dXWTErMHJt?=
 =?utf-8?B?Q2dlVXFyMUtHTjB5b0xXc0NFcHFpNWNLMkhYc3djc01BOXZGZ2hubXNGQVVK?=
 =?utf-8?B?QnN6YU5xejZLaVlnM2dCOU8xTHc4dE82SnpRUVBhd2dSTFVaUkVqT2drcnB5?=
 =?utf-8?B?aWozL2tLanJaUjlsSmFqTVFZZWZodW55YTFlRzNMZWdLRlg2ZzIzS2RYVmJN?=
 =?utf-8?B?a0twc0NPOTRmeXI3VStDenJkWlV5dzN5UFk5aVNoUk9FUnBNYmpzM0FXOWtr?=
 =?utf-8?B?bk9IMjRNcXJSeHVWUUhMdDc2T1ZqYnI1azFtbHZiM1NjbGN0d3hoQmdEaFl6?=
 =?utf-8?B?SjR2NTQ3UC80eUJnQzh0U3ZmbWJwYjQzelR4cmR5NkJGSFZiUkNja2dJWk5Q?=
 =?utf-8?B?U0JPZFpmSHlwTFZWcU94RVJwUFNNaWlZbExxc3k4aER4RXRCajNKcjZWbHNu?=
 =?utf-8?B?cG5zSlo3QzRNY3hqZk5JU2VuMGljcFJINkw5dHB2ZGNJK3NzQXN4dUhiNWNN?=
 =?utf-8?B?em1GL1NWazdVZ29QQllxcXI0b1l6VkpRZDZ2R3V3Wnp6NHhXSnREUjVOSjZz?=
 =?utf-8?B?Qkp6dmdqZXYvdWJlYTRaYUxSZThTMHhFbFR3dThGK0RQSTZnQmJ0Sk5ITHJG?=
 =?utf-8?B?Tk9YMnVzMUhDc29uZlcrNnIxMnE1T0dQUENiOFhJc3Uwa0F4eFE4SEtBTGdm?=
 =?utf-8?B?UDNiT2w4K0FvZHlrcUFrSjhyV1pMOGpua2xLV1Q1NzJQNjd1TXRQWENQWCt4?=
 =?utf-8?B?Q1FRa0JOUzBsYm9LWVFtOXhpRTdmdVNKQ1dmaE5wVDBGemlYMEpUaThkWExR?=
 =?utf-8?B?ZFk4RTZTZmNEdWdSdVozQXpkSGJrNGVMUzZnNTFneW5CRFh5NVR6UkpUSERU?=
 =?utf-8?B?bVJQVmduWjFhcnhkRmwxWkMyenFHbVNRRHJHc1l3TUJFM0pRK1g4UHVxaHlV?=
 =?utf-8?B?RU9YNG5nSkRsODZzTkV3MzBDQy8xSEFXV244aWZJQWxCVGdmUUc2a3B2OEFW?=
 =?utf-8?B?cG9TVFhhK2RWMHhFcWZvYXNaLzBzNm8xTlNXOFVUOW9pc0RmZ2ZZT0pQNFRM?=
 =?utf-8?Q?xjUS3dw+GeMt56q0YQwA/qrha?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f55ef1d-e92d-45f8-ab73-08da8a5c9561
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 07:52:27.3708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FmP7fbgPsVY2zn27CazCYfoPiPnm8krjq49L2ZimMeusO3DsDH+OWQjX8tprn0iyR4j+KuPLh+6X1yhXDZc+NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5913
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
aEBwZW5ndXRyb25peC5kZT4NCj4gU2VudDogMjAyMuW5tDjmnIgzMOaXpSAxNTo0Ng0KPiBUbzog
SG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT47IHAuemFiZWxAcGVuZ3V0cm9uaXgu
ZGU7DQo+IGJoZWxnYWFzQGdvb2dsZS5jb207IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207IHJv
YmhAa2VybmVsLm9yZzsNCj4gc2hhd25ndW9Aa2VybmVsLm9yZzsgdmtvdWxAa2VybmVsLm9yZzsg
YWxleGFuZGVyLnN0ZWluQGV3LnRxLWdyb3VwLmNvbTsNCj4gbWFyZXhAZGVueC5kZTsgcmljaGFy
ZC5sZWl0bmVyQGxpbnV4LmRldg0KPiBDYzogbGludXgtcGh5QGxpc3RzLmluZnJhZGVhZC5vcmc7
IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZGwtbGludXgtaW14DQo+IDxs
aW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAwLzZdIEFkZCBpTVg4
TVAgUENJZSBzdXBwb3J0DQo+IA0KPiBBbSBEaWVuc3RhZywgZGVtIDMwLjA4LjIwMjIgdW0gMDI6
NTggKzAwMDAgc2NocmllYiBIb25neGluZyBaaHU6DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiA+ID4gRnJvbTogTHVjYXMgU3RhY2ggPGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU+
DQo+ID4gPiBTZW50OiAyMDIy5bm0OOaciDI55pelIDIzOjIwDQo+ID4gPiBUbzogSG9uZ3hpbmcg
Wmh1IDxob25neGluZy56aHVAbnhwLmNvbT47IHAuemFiZWxAcGVuZ3V0cm9uaXguZGU7DQo+ID4g
PiBiaGVsZ2Fhc0Bnb29nbGUuY29tOyBsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tOyByb2JoQGtl
cm5lbC5vcmc7DQo+ID4gPiBzaGF3bmd1b0BrZXJuZWwub3JnOyB2a291bEBrZXJuZWwub3JnOw0K
PiA+ID4gYWxleGFuZGVyLnN0ZWluQGV3LnRxLWdyb3VwLmNvbTsgbWFyZXhAZGVueC5kZTsNCj4g
PiA+IHJpY2hhcmQubGVpdG5lckBsaW51eC5kZXYNCj4gPiA+IENjOiBsaW51eC1waHlAbGlzdHMu
aW5mcmFkZWFkLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4gPiBsaW51eC1w
Y2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7
DQo+ID4gPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBrZXJuZWxAcGVuZ3V0cm9uaXgu
ZGU7IGRsLWxpbnV4LWlteA0KPiA+ID4gPGxpbnV4LWlteEBueHAuY29tPg0KPiA+ID4gU3ViamVj
dDogUmU6IFtQQVRDSCB2NCAwLzZdIEFkZCBpTVg4TVAgUENJZSBzdXBwb3J0DQo+ID4gPg0KPiA+
ID4gSGkgUmljaGFyZCwNCj4gPiA+DQo+ID4gPiBpbnN0ZWFkIG9mIHJldmlldyBjb21tZW50cyBJ
IHNlbnQgeW91IGEgdHdvIHBhdGNoZXMgdG8gcmV3b3JrIHRoaW5ncw0KPiA+ID4gbW9yZSB0byBt
eSBsaWtpbmcuIEhvcGUgeW91IGFncmVlIHdpdGggdGhlIGFwcHJvYWNoLg0KPiA+ID4NCj4gPiA+
IE9uZSBxdWVzdGlvbiwgdGhvdWdoOiBkaWQgeW91IHRlc3QgdGhpcyB3aXRoIGRldmljZXMgd2l0
aCBHZW4yLzMNCj4gPiA+IHNwZWVkcz8gVGhlIE1hcnZlbGwgV2lGaSBtb2R1bGUgb24gbXkgRVZL
IGJvYXJkIG9ubHkgbGlua3Mgd2l0aA0KPiA+ID4gR2VuMSwgd2hpbGUgaXQgY2xhaW1zDQo+ID4g
PiBHZW4yIHNwZWVkIGluIHRoZSBMbmtDYXAgcmVnaXN0ZXIuIEhvd2V2ZXIsIGl0IGRvZXMgc2Vl
bSB0byBjb21lIHVwDQo+ID4gPiB3aXRoDQo+ID4gPiBHZW4xIGFzIHRoZSB0YXJnZXQgbGluayBz
cGVlZCBpbiBMbmtDdGwyLCBzbyBtYXliZSB0aGUgZGV2aWNlIGlzIGF0IGZhdWx0DQo+IGhlcmUu
DQo+ID4gSGkgTHVjYXM6DQo+ID4gVGhhbmtzIGZvciB5b3VyIGhlbHAgb24gdGhpcyBzZXJpZXMu
DQo+ID4gSSdtIGFncmVlIHdpdGggeW91ciBhcHByb2FjaCwgYW5kIGxldCBibGstY3RybCBkcml2
ZXIgZG8gdGhlIGhzaW9taXggcmVzZXRzLg0KPiA+IENhbiBJIGluY2x1ZGUgdGhlICMxIHBhdGNo
IGludG8gdGhpcyBzZXJpZXMsIGFuZCByZWJhc2UgdGhlIDIjIGZpeHVwIQ0KPiA+IHBhdGNoDQo+
ID4gwqBpbnRvIHRoZSBwaHkgY2hhbmdlcyBwYXRjaCB3aXRoIHlvdXIgc2lnbi1vZmY/DQo+ID4N
Cj4gU3VyZSwgdGhhdCdzIHdoeSBJIHNlbnQgdGhlbSB0aGlzIHdheS4gRmVlbCBmcmVlIHRvIGlu
Y2x1ZGUgdGhlbSBpbiB5b3VyIHNlcmllcw0KPiB3aXRoIG15IHNpZ24tb2ZmLg0KR290IHRoYXQs
IHRoYW5rcyBhIGxvdC4NCg0KPiANCj4gPiBZZXMsIEkgZGlkIHRoZSBHZW4zIE5WRU0gZGV2aWNl
IHRlc3RzIG9uIGkuTVg4TVAgRVZLIGJvYXJkLg0KPiA+IFRoZSBHZW4zIHdvcmtzIGZpbmUuDQo+
ID4gTG9nczoNCj4gPiAiDQo+ID4gWyAgICAxLjgwODAzM10gcGh5IHBoeS0zMmYwMDAwMC5wY2ll
LXBoeS4xOiBwaHlfcG93ZXJfb24gd2FzIGNhbGxlZA0KPiBiZWZvcmUgcGh5X2luaXQNCj4gPiBb
ICAgIDEuODIyNjA5XSBpbXg2cS1wY2llIDMzODAwMDAwLnBjaWU6IGlBVFUgdW5yb2xsOiBlbmFi
bGVkDQo+ID4gWyAgICAxLjgzNjYyMF0gaW14NnEtcGNpZSAzMzgwMDAwMC5wY2llOiBpQVRVIHJl
Z2lvbnM6IDQgb2IsIDQgaWIsIGFsaWduDQo+IDY0SywgbGltaXQgMTZHDQo+ID4gWyAgICAxLjk1
MDQyN10gaW14NnEtcGNpZSAzMzgwMDAwMC5wY2llOiBQQ0llIEdlbi4xIHgxIGxpbmsgdXANCj4g
PiBbICAgIDIuMDU4MTM4XSBpbXg2cS1wY2llIDMzODAwMDAwLnBjaWU6IFBDSWUgR2VuLjMgeDEg
bGluayB1cA0KPiA+IFsgICAgMi4wNjM3MzFdIGlteDZxLXBjaWUgMzM4MDAwMDAucGNpZTogTGlu
ayB1cCwgR2VuMw0KPiA+IFsgICAgMi4wNjg2MTldIGlteDZxLXBjaWUgMzM4MDAwMDAucGNpZTog
UENJZSBHZW4uMyB4MSBsaW5rIHVwDQo+ID4gIg0KPiBUaGFua3MgZm9yIHRoZSBjb25maXJtYXRp
b24uDQo+IA0KPiBBbHNvIGNhbiB5b3UgcGxlYXNlIHJlb3JkZXIgdGhlIHNlcmllcywgdG8gaGF2
ZSB0aGUgRFQgY2hhbmdlcyBhdCB0aGUgZW5kPw0KDQpPa2F5LCB3b3VsZCByZW9yZGVyIHRoZSBE
VCBjaGFuZ2VzIGF0IHRoZSBiZWdpbiBpbiBuZXh0IHZlcnNpb24uDQoNCkJlc3QgUmVnYXJkcw0K
UmljaGFyZCBaaHUNCg0KPiANCj4gUmVnYXJkcywNCj4gTHVjYXMNCj4gDQo+ID4NCj4gPiBCZXN0
IFJlZ2FyZHMNCj4gPiBSaWNoYXJkIFpodQ0KPiA+ID4NCj4gPiA+IFJlZ2FyZHMsDQo+ID4gPiBM
dWNhcw0KPiA+ID4NCj4gPiA+IEFtIE1vbnRhZywgZGVtIDI5LjA4LjIwMjIgdW0gMTY6MTUgKzA4
MDAgc2NocmllYiBSaWNoYXJkIFpodToNCj4gPiA+ID4gQmFzZWQgb24gdGhlIDYuMC1yYzEgb2Yg
dGhlIHBjaS9uZXh0IGJyYW5jaC4NCj4gPiA+ID4gVGhpcyBzZXJpZXMgYWRkcyB0aGUgaS5NWDhN
UCBQQ0llIHN1cHBvcnQgYW5kIHRlc3RlZCBvbiBpLk1YOE1QDQo+ID4gPiA+IEVWSyBib2FyZCB3
aGVuIG9uZSBQQ0llIE5WTUUgZGV2aWNlIGlzIHVzZWQuDQo+ID4gPiA+DQo+ID4gPiA+IC0gaS5N
WDhNUCBQQ0llIGhhcyByZXZlcnNlZCBpbml0aWFsIFBFUlNUIGJpdCB2YWx1ZSByZWZlciB0bw0K
PiA+ID4gaS5NWDhNUS9pLk1YOE1NLg0KPiA+ID4gPiDCoMKgQWRkIHRoZSBQSFkgUEVSU1QgZXhw
bGljaXRseSBmb3IgaS5NWDhNUCBQQ0llIFBIWS4NCj4gPiA+ID4gLSBBZGQgdGhlIGkuTVg4TVAg
UENJZSBQSFkgc3VwcG9ydCBpbiB0aGUgaS5NWDhNIFBDSWUgUEhZIGRyaXZlci4NCj4gPiA+ID4g
wqDCoEFuZCBzaGFyZSBhcyBtdWNoIGFzIHBvc3NpYmxlIGNvZGVzIHdpdGggaS5NWDhNTSBQQ0ll
IFBIWS4NCj4gPiA+ID4gLSBBZGQgdGhlIGkuTVg4TVAgUENJZSBzdXBwb3J0IGluIGJpbmRpbmcg
ZG9jdW1lbnQsIERUUyBmaWxlcywgYW5kDQo+ID4gPiA+IFBDSWUNCj4gPiA+ID4gwqDCoGRyaXZl
ci4NCj4gPiA+ID4NCj4gPiA+ID4gTWFpbiBjaGFuZ2VzIHYzLS0+djQ6DQo+ID4gPiA+IC0gUmVn
YXJkaW5nIFBoaWxsaXAncyBzdWdnZXN0aW9ucywgYWRkIGZpeCB0YWcgaW50byB0aGUgZmlyc3Qg
Y29tbWl0Lg0KPiA+ID4gPiAtIEFkZCBSZXZpZXdlZCBhbmQgVGVzdGVkIHRhZ3MuDQo+ID4gPiA+
DQo+ID4gPiA+IE1haW4gY2hhbmdlcyB2Mi0tPnYzOg0KPiA+ID4gPiAtIEZpeCB0aGUgc2NoZW1h
IGNoZWNraW5nIGVycm9yIGluIHRoZSBQSFkgZHQtYmluZGluZyBwYXRjaC4NCj4gPiA+ID4gLSBJ
bnNwaXJlZCBieSBMdWNhcywgdGhlIFBMTCBjb25maWd1cmF0aW9ucyBtaWdodCBub3QgcmVxdWly
ZWQNCj4gPiA+ID4gd2hlbg0KPiA+ID4gPiDCoMKgZXh0ZXJuYWwgT1NDIGlzIHVzZWQgYXMgUENJ
ZSByZWZlcnJlbmNlIGNsb2NrLiBJdCdzIHRydWUuIFJlbW92ZQ0KPiA+ID4gPiBhbGwNCj4gPiA+
ID4gwqDCoHRoZSBIU0lPIFBMTCBiaXQgbWFuaXB1bGF0aW9ucywgYW5kIFBDSWUgd29ya3MgZmlu
ZSBvbiBpLk1YOE1QDQo+ID4gPiA+IEVWSw0KPiA+ID4gYm9hcmQNCj4gPiA+ID4gwqDCoHdpdGgg
b25lIE5WTUUgZGV2aWNlIGlzIHVzZWQuDQo+ID4gPiA+IC0gRHJvcCB0aGUgIzQgcGF0Y2ggb2Yg
djIsIHNpbmNlIGl0IGhhZCBiZWVuIGFwcGxpZWQgYnkgUm9iLg0KPiA+ID4gPg0KPiA+ID4gPiBN
YWluIGNoYW5nZXMgdjEtLT52MjoNCj4gPiA+ID4gLSBJdCdzIG15IGZhdWx0IGZvcmdldCBpbmNs
dWRpbmcgVmlub2QsIHJlLXNlbmQgdjIgYWZ0ZXIgaW5jbHVkZQ0KPiA+ID4gPiBWaW5vZA0KPiA+
ID4gPiDCoMKgYW5kIGxpbnV4LXBoeUBsaXN0cy5pbmZyYWRlYWQub3JnLg0KPiA+ID4gPiAtIExp
c3QgdGhlIGJhc2VtZW50cyBvZiB0aGlzIHBhdGNoLXNldC4gVGhlIGJyYW5jaCwgY29kZXMgY2hh
bmdlcyBhbmQgc28NCj4gb24uDQo+ID4gPiA+IC0gQ2xlYW4gdXAgc29tZSB1c2VsZXNzIHJlZ2lz
dGVyIGFuZCBiaXQgZGVmaW5pdGlvbnMgaW4gIzMgcGF0Y2guDQo+ID4gPiA+DQo+ID4gPiA+IERv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvZnNsLGlteDgtcGNpZS1waHkueWFt
bCB8ICAxNg0KPiA+ID4gKysrKysrKy0tDQo+ID4gPiA+IGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJl
ZXNjYWxlL2lteDhtcC1ldmsuZHRzICAgICAgICAgICAgICAgICB8DQo+IDUzDQo+ID4gPiArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ID4gPiBhcmNoL2FybTY0L2Jvb3QvZHRzL2Zy
ZWVzY2FsZS9pbXg4bXAuZHRzaSAgICAgICAgICAgICAgICAgICAgfA0KPiA0Ng0KPiA+ID4gKysr
KysrKysrKysrKysrKysrKysrKysrLQ0KPiA+ID4gPiBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3
Yy9wY2ktaW14Ni5jICAgICAgICAgICAgICAgICAgICAgICAgfCAgMTcNCj4gPiA+ICsrKysrKysr
Ky0NCj4gPiA+ID4gZHJpdmVycy9waHkvZnJlZXNjYWxlL3BoeS1mc2wtaW14OG0tcGNpZS5jICAg
ICAgICAgICAgICAgICAgIHwgMTUwDQo+ID4gPg0KPiArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tDQo+ID4gPiAtLS0tLS0tLS0t
LS0tLS0tLS0NCj4gPiA+ID4gZHJpdmVycy9yZXNldC9yZXNldC1pbXg3LmMgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHwgICAxDQo+ICsNCj4gPiA+ID4gNiBmaWxlcyBjaGFuZ2Vk
LCAyMzIgaW5zZXJ0aW9ucygrKSwgNTEgZGVsZXRpb25zKC0pDQo+ID4gPiA+DQo+ID4gPiA+IFtQ
QVRDSCB2NCAxLzZdIHJlc2V0OiBpbXg3OiBGaXggdGhlIGlNWDhNUCBQQ0llIFBIWSBQRVJTVCBz
dXBwb3J0DQo+ID4gPiA+IFtQQVRDSCB2NCAyLzZdIGR0LWJpbmRpbmc6IHBoeTogQWRkIGlNWDhN
UCBQQ0llIFBIWSBiaW5kaW5nIFtQQVRDSA0KPiA+ID4gPiB2NCAzLzZdIHBoeTogZnJlZXNjYWxl
OiBpbXg4bS1wY2llOiBBZGQgaU1YOE1QIFBDSWUgUEhZIFtQQVRDSCB2NA0KPiA+ID4gPiA0LzZd
DQo+ID4gPiA+IGFybTY0OiBkdHM6IGlteDhtcDogQWRkIGlNWDhNUCBQQ0llIHN1cHBvcnQgW1BB
VENIIHY0IDUvNl0gYXJtNjQ6DQo+IGR0czoNCj4gPiA+ID4gaW14OG1wLWV2azogQWRkIFBDSWUg
c3VwcG9ydCBbUEFUQ0ggdjQgNi82XSBQQ0k6IGlteDY6IEFkZCBpTVg4TVANCj4gPiA+ID4gUENJ
ZSBzdXBwb3J0DQo+ID4gPg0KPiA+DQo+IA0KDQo=
