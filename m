Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42EC35A59A5
	for <lists+linux-pci@lfdr.de>; Tue, 30 Aug 2022 04:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiH3C66 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Aug 2022 22:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiH3C64 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Aug 2022 22:58:56 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10069.outbound.protection.outlook.com [40.107.1.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB33A0255;
        Mon, 29 Aug 2022 19:58:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gussYX9DX0s4ARUO6nuY82L6YiLOOnQgK68Qw7t5ufsWOoSGvN8icbHDSvESbE3vb/yMtHUnPQAfBpIBRyIGZKqK5AsEIJ/93iLDDXw7GWn1crwk9uOA0FE5TEp1Y1DDwFtZDorYQ5T0irbIgl1vaCRRWVZPS6prV+6bQv2n+V5zTrS+W8KyxdfjgLIVqsatGuhDU/Wjk1xYUtOKnNPy0cu38XGSgW7VYAfekDCg7ADRA54ce/Stu4B4iuYuL9GRSZ5HjNVVNO9b5wjkJYdylfG7SOQDVtli4mUepHNSUd8wuzi2POixLefFThlpv5UlJHTQ3+88cM8i2/4y12QIwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hwh5ybRE1SmGjfHGHUFNOZhH9wU1iqUV+SbRrZgL/h0=;
 b=TMleBA7n82g3Rfi6jgrgOXq+0PPavAO6v5cx38Kru450F4zXtfsDHV4E0RI96M/qsaH8/KjZ9S+GGlcHT0kpk4SY0U+7ERjXScc2vC+3wHYqwvrIy0diYrap9zQESc3qRrqKHb7wBig6Qb2PY+wATdYN/t6v3Bm7PvkvqxZGlJkWA9hiV8ddLO/FufCIKLuZoTON+wq50oPjsixxd6syEhHorn87h6cXRSXMfoC72KHM/IW6Rue6ksHxVXTfdGliSURX6SSvy7BMzduE1BaC64PQFOlbpc2NNvL2TsasyTjJpp5Ey1J+PsmHl59+gvz94BcriPBr9GUIza7kpTQ05A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hwh5ybRE1SmGjfHGHUFNOZhH9wU1iqUV+SbRrZgL/h0=;
 b=EYAoLt6sa66npBPtvMnfiNZEiS3v3mrWQhCjta+t1a/V2/mVXOyTqk+jN9uSlIfyC8P8cp50LibxGVMimpPC4MQbPbQQ7SIXh4Hxwd5+7RB1YBwVYcfA6hGWWd6ygnA6Uhcn1Q3CJdsRJnmorz2/vAYojVN/NU7456Q8icT/ZQA=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM8PR04MB7380.eurprd04.prod.outlook.com (2603:10a6:20b:1d5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Tue, 30 Aug
 2022 02:58:51 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::13c:5622:af8a:b2da]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::13c:5622:af8a:b2da%9]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 02:58:51 +0000
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
Subject: RE: [PATCH v4 4/6] arm64: dts: imx8mp: Add iMX8MP PCIe support
Thread-Topic: [PATCH v4 4/6] arm64: dts: imx8mp: Add iMX8MP PCIe support
Thread-Index: AQHYu4Hym8ah0hwxXkqBpbR3hsNKAa3F/4mAgADAL2A=
Date:   Tue, 30 Aug 2022 02:58:51 +0000
Message-ID: <AS8PR04MB8676DA6A04D76F10FFDE81B28C799@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1661760917-9558-1-git-send-email-hongxing.zhu@nxp.com>
         <1661760917-9558-5-git-send-email-hongxing.zhu@nxp.com>
 <9b2eba50b41e19d3f71a08416b295ba2e7bcc1ee.camel@pengutronix.de>
In-Reply-To: <9b2eba50b41e19d3f71a08416b295ba2e7bcc1ee.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 859ddd19-51d6-4450-df71-08da8a3391a4
x-ms-traffictypediagnostic: AM8PR04MB7380:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JTdAklAEc1Es/czDqLJtONSk6x1YbAYY4ta8dQ1NeIsB22Omh8pb2s1oYRTKAD7YQQ+uM3tUwyBL4Lwq54cz70QTRKtaphjIaakq8qhlztaQneIFaYkwJNCOvmNcsu3aaQeaQiEn+lgdKnsRa/NKZ8v1b7RMCv/7l9pSEsJ+SUsqQ/X131meRJ+Uj8Idw9TlOc1K7qrEEO23Bdjv1Q2biL7l6OtroGfdO6KwTNSL0866vV9B3NCOC9oIU+W/iiFRwKtx8xBhz0L70InrXBZahfKxhojP70LMiSKG3yeN3/by1PQAzW3wXyu67ftMw5YRe6Vn8+ehlSI8MkoPCT1jzuGQA+tiUU3dFEY2IL1Xk2soQlpm+6a2n1NLxMvONtEL+lZO40GVbdHrICUvVapkqqZj4S17qtB9g1yEz6WdGPAxdDtLZsKqSYIEDM3TEliYCaVpvqwB6pauAYPUx2Bihz6hLgYwtawtYXowuR+ntM+eK03130k1SANFrfWAzFMnqAcUdUn/1BcBWck+BBALc6aDH9Rc7vG52jjvnbpKdo5dFijNAzblA8dljaonzcImHtXXh2Y/9QHw2bnV2NEts8eebYscAvmW0Np/SNgLQ8yHFbdzOkYqQ/vjrfcueoO60lJ5gOu5fehhGWyWBRKjBsU2t4tDkXgjBivUnor7tplLyJ78DUBKbfIE27Bzbteq4V/ymeYU7Tz5RcsL3XQBXNLmq9ja+VORqqA/ka542BkPtSFhKN1Rv3+U8M6iYRdTu1yzYJLQX/XPBzHBqzu8/NKlqJj2/Als4Ow1R3jesh0FY18boLuyvnUU+fj/PPkv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(376002)(136003)(346002)(366004)(64756008)(76116006)(66446008)(66946007)(2906002)(53546011)(66556008)(66476007)(52536014)(8676002)(8936002)(33656002)(4326008)(6506007)(7416002)(41300700001)(7696005)(186003)(5660300002)(44832011)(55016003)(83380400001)(86362001)(478600001)(921005)(110136005)(9686003)(26005)(122000001)(38100700002)(54906003)(316002)(71200400001)(38070700005)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0J6bVJLY2c5V3ZGNGJVQlBxYVZ6VWkrTWsyWFpZbDAvZS9sS3EyRGlxV3Fo?=
 =?utf-8?B?d24wUzJzcENLMHFjbnhvTiszTm9QVFFiWTQyV0pMMEdrN0t2aEQ3SmY1VDNH?=
 =?utf-8?B?VDNPT1JlbEhBYWRnbUY1ZHpJZ1paK3ZLcnZZWXduRnVQWGRoZ1hBRTlTTnVa?=
 =?utf-8?B?czExK3RHK1JEaWN6NEhzZ083VkdRaXp4ZDlRREFra292SWFvYWtFYnI5dWdR?=
 =?utf-8?B?RUJSeTB1a3lZWmVxV3ZUZDhiaWRuSTY3SkZZTnU2dUc3UmZhUVNkSFZYNysy?=
 =?utf-8?B?NHZEemFhcWpmMmozWS93TVc1SkkveGFZMUUrQmY0bkwwVXd0OC93d2l2ZDE2?=
 =?utf-8?B?SlZGcTdTeWc5bk9Ody9takpGNEQ0QTFiWEpYamduZWJMaWpqTnNhaXFNT29X?=
 =?utf-8?B?T2tSMEt2Y25OQTJDZTVQQjlNMTRBaDdjdjBpVUJGWVVwb2dPS3R1N2dZYXJi?=
 =?utf-8?B?cUR3b29oNGNpbitXWHFLSXc3clRrUjNTcnIvdTJadVE1WG40QVh2a0tjNmZZ?=
 =?utf-8?B?KzBVYkQ0dlk0OTg2S2JwZ0hsdCtmYTh6Y2h4TzdEL21IUE1tcnZTZGk2Q3Nh?=
 =?utf-8?B?c1ZSOU9OR3k5V240VlZZWDVtek0wYVZJaXVwMEI2RTByR0NNajhJaEtaNFdR?=
 =?utf-8?B?LzdZRzBCQU1COE9VUVlVajZ5VDA2aUNCZWs2elFWUFkxQ01mbVNTSHJIUEcv?=
 =?utf-8?B?UGluU3RWUExMRldMdVQ5Vy9oZ0tzbmlRczBpamMxYVJ5VnZEM0hhSlRxRjJp?=
 =?utf-8?B?elN1VjZRKzk5UHNiU2VkckVweUhXR1VXSVUwaTBPQWFxamZXeE9MbWNDbFdi?=
 =?utf-8?B?L3p1THhvcVpHSGl6a3pCcys4ck4vdXZnNE9UVThmUGZXam5GN2RORDNxNExw?=
 =?utf-8?B?RG15RWppTFpJcnI4Z3N1cTJMKytqRENYNXBsNGZrbzlJYWF5WXlNSDZ5K2RL?=
 =?utf-8?B?V1hob012Y3NmeXR0Vi9KVzBEQUt1VnA3UDdncEgrVkVhT1YxekN3NERnb3JZ?=
 =?utf-8?B?aDcvd0dEMjkvTTlpUUNiYi8yTW9wdFMxNlk1QTdkdElUSUJMNS8yRXJwblFZ?=
 =?utf-8?B?OGF3ayt5U2d0T245bjhpYStjREtZWW1WNU9XSFBaRURyYzBsNllqckFUMXNB?=
 =?utf-8?B?WEJZTTNYc0hOaWZkeXRRcVB5ekJ1Z1plSm5SamhVdElVOUdWbTNIeDgzQ2Zl?=
 =?utf-8?B?VUNkaVl3aU55VUUrYVNNM1BPc3VJdkxpb3VwaUdGQ1NxVC9iUGR0MlRoSEdq?=
 =?utf-8?B?YnBmR0Z3RHUwZmxmYTRWRVl0Uy9jdmpmZjVSUW9IcnY3ZjVNNWVGZXA1Mm9M?=
 =?utf-8?B?bmR3YXRFNzZham41Vm9rR3gzRTlOd0FXQjk2ZXRPNi9xZS9FSENYZXBPL0Ev?=
 =?utf-8?B?Y2p1ZXd3T3ZZZVA5YXZnaVVyN3FSY1hsRFZTU2F2aHliVU1waUptTXZ5ZkQv?=
 =?utf-8?B?VW9sSTljWTdVaXNTN0FqTE5BeGNKV3JTRXZtTG9KczFza3UwVXluaUU4RHha?=
 =?utf-8?B?UUc1MVpySG0zc2djYWU3UVZXaVc2QUZpeHIrdTI3V1ptbU96dkREY2ZEOXpo?=
 =?utf-8?B?NXFWL3NSM1RseHplbXphSG9qRjRLdUtsU1JNUUVBdW9OTEhaN3FOWGxMQWht?=
 =?utf-8?B?eXVod0o2WGdrNWFTWjJnOHpGYlBia2FIZnc1MlZjMEY5bTA4ZUpKUDRMYVU1?=
 =?utf-8?B?bnNwcStJTXBMWk54SmZPNVMvaHVUWWdEdUZjNGl4elBDa1ROZmZVVVJxSWVo?=
 =?utf-8?B?T1V6ZDJBbzIvWFdlVTJoeXlKVU9RVjlYeCttdjY0T3BkcDhGZlpHaFYxOTFr?=
 =?utf-8?B?NUlPd3A5cTgzL0JpOFlXdXcvNHpiOHBOZ1N5VmU0UFlmOStFUUpRUk52ZStE?=
 =?utf-8?B?cTcrcFZKZDVvcllyQkZLbFZ5aXoxemhLNG1DQ01wSVF3WDdnVVNvQStFYmhY?=
 =?utf-8?B?eVdSdnNKc1RlcVNnRlJHK253U3hHS1JzNDFxdnphV1RORitXSGxHMm4vUjdy?=
 =?utf-8?B?dWo0KzlkMTFGR1JQS2ltVmVsVjRwTUVKUTNveEJ1bjRCbFBUWlBWU09Xdmkx?=
 =?utf-8?B?RmV3aHN0cEVJQWxhcndiaHVFSitHNjl2ckN6VlhNMmdJdi9hcGFqVTMxVU0v?=
 =?utf-8?Q?EWDNUI2p1dDvab14JwIrkmVqR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 859ddd19-51d6-4450-df71-08da8a3391a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 02:58:51.7343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GIRJZKzCsjGVDXTUrrqlmwutP5I2mmRTibTNSR0rf3AMF7XaaDi4p0mnEgbmRDJ+XQjRJ6WaJK5FvB3z859Qxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7380
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
aEBwZW5ndXRyb25peC5kZT4NCj4gU2VudDogMjAyMuW5tDjmnIgyOeaXpSAyMzoyMw0KPiBUbzog
SG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT47IHAuemFiZWxAcGVuZ3V0cm9uaXgu
ZGU7DQo+IGJoZWxnYWFzQGdvb2dsZS5jb207IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207IHJv
YmhAa2VybmVsLm9yZzsNCj4gc2hhd25ndW9Aa2VybmVsLm9yZzsgdmtvdWxAa2VybmVsLm9yZzsg
YWxleGFuZGVyLnN0ZWluQGV3LnRxLWdyb3VwLmNvbTsNCj4gbWFyZXhAZGVueC5kZTsgcmljaGFy
ZC5sZWl0bmVyQGxpbnV4LmRldg0KPiBDYzogbGludXgtcGh5QGxpc3RzLmluZnJhZGVhZC5vcmc7
IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZGwtbGludXgtaW14DQo+IDxs
aW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCA0LzZdIGFybTY0OiBk
dHM6IGlteDhtcDogQWRkIGlNWDhNUCBQQ0llIHN1cHBvcnQNCj4gDQo+IEFtIE1vbnRhZywgZGVt
IDI5LjA4LjIwMjIgdW0gMTY6MTUgKzA4MDAgc2NocmllYiBSaWNoYXJkIFpodToNCj4gPiBBZGQg
aS5NWDhNUCBQQ0llIHN1cHBvcnQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJkIFpo
dSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+ID4gVGVzdGVkLWJ5OiBNYXJlayBWYXN1dCA8bWFy
ZXhAZGVueC5kZT4NCj4gPiBUZXN0ZWQtYnk6IFJpY2hhcmQgTGVpdG5lciA8cmljaGFyZC5sZWl0
bmVyQHNraWRhdGEuY29tPg0KPiA+IFRlc3RlZC1ieTogQWxleGFuZGVyIFN0ZWluIDxhbGV4YW5k
ZXIuc3RlaW5AZXcudHEtZ3JvdXAuY29tPg0KPiA+IC0tLQ0KPiA+ICBhcmNoL2FybTY0L2Jvb3Qv
ZHRzL2ZyZWVzY2FsZS9pbXg4bXAuZHRzaSB8IDQ2DQo+ID4gKysrKysrKysrKysrKysrKysrKysr
Ky0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDQ1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkN
Cj4gPg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4
bXAuZHRzaQ0KPiA+IGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1wLmR0c2kN
Cj4gPiBpbmRleCBmZTE3OGI3ZDA2M2MuLmQxMWYwNzlmZDFmMyAxMDA2NDQNCj4gPiAtLS0gYS9h
cmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAuZHRzaQ0KPiA+ICsrKyBiL2FyY2gv
YXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcC5kdHNpDQo+ID4gQEAgLTUsNiArNSw3IEBA
DQo+ID4NCj4gPiAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2Nsb2NrL2lteDhtcC1jbG9jay5oPg0K
PiA+ICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvcG93ZXIvaW14OG1wLXBvd2VyLmg+DQo+ID4gKyNp
bmNsdWRlIDxkdC1iaW5kaW5ncy9yZXNldC9pbXg4bXAtcmVzZXQuaD4NCj4gPiAgI2luY2x1ZGUg
PGR0LWJpbmRpbmdzL2dwaW8vZ3Bpby5oPg0KPiA+ICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvaW5w
dXQvaW5wdXQuaD4NCj4gPiAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2ludGVycnVwdC1jb250cm9s
bGVyL2FybS1naWMuaD4NCj4gPiBAQCAtNDEwLDcgKzQxMSw4IEBAIGlvbXV4YzogcGluY3RybEAz
MDMzMDAwMCB7DQo+ID4gIAkJCX07DQo+ID4NCj4gPiAgCQkJZ3ByOiBpb211eGMtZ3ByQDMwMzQw
MDAwIHsNCj4gPiAtCQkJCWNvbXBhdGlibGUgPSAiZnNsLGlteDhtcC1pb211eGMtZ3ByIiwgInN5
c2NvbiI7DQo+ID4gKwkJCQljb21wYXRpYmxlID0gImZzbCxpbXg4bXAtaW9tdXhjLWdwciIsDQo+
ID4gKwkJCQkJICAgICAiZnNsLGlteDZxLWlvbXV4Yy1ncHIiLCAic3lzY29uIjsNCj4gDQo+IEkg
ZG9uJ3QgbGlrZSB0aGlzIHBhcnQuIFRoZSBpb211eCBHUFIgaW4gdGhlIGkuTVg4TSogaXMgbm90
IHJlYWxseSBjb21wYXRpYmxlDQo+IHdpdGggdGhlIGkuTVg2USwgc28gSSB0aGluayBpdCdzIGEg
cHJldHR5IGJhZCBpZGVhIHRvIGNsYWltIGl0IGlzLiBXaHkgY2FuJ3Qgd2UNCj4gaGF2ZSB0aGlz
IHN5c2NvbiBsb29rZWQgdXAgYnkgcGhhbmRsZSwgbGlrZSB3ZSBkaXNjdXNzZWQgaW4gc29tZSBl
YXJseSB2ZXJzaW9uDQo+IG9mIHRoZSBpLk1YOE1NIHBhdGNoc2V0PyBTb3JyeSwgZm9yIG5vdCBj
YXRjaGluZyB0aGlzIG9uIHRoZSA4TU0gc3VibWlzc2lvbiwNCj4gSSB3YXMgcHJldHR5IGJ1c3kg
YmFjayB0aGVuLg0KT2theSwgZ290IHRoYXQuIFRoYW5rcy4NCldvdWxkIGJlIGNoYW5nZWQsIGFu
ZCBmZXRjaCB0aGUgZ3ByIHJlZ21hcCBieSBwaGFuZGxlIGluIHY1IGxhdGVyLg0KDQpCZXN0IFJl
Z2FyZHMNClJpY2hhcmQgWmh1DQoNCj4gDQo+IFJlZ2FyZHMsDQo+IEx1Y2FzDQo+IA0KPiA+ICAJ
CQkJcmVnID0gPDB4MzAzNDAwMDAgMHgxMDAwMD47DQo+ID4gIAkJCX07DQo+ID4NCj4gPiBAQCAt
MTA4NCw2ICsxMDg2LDE3IEBAIG1lZGlhX2Jsa19jdHJsOiBibGstY3RybEAzMmVjMDAwMCB7DQo+
ID4gIAkJCQkjcG93ZXItZG9tYWluLWNlbGxzID0gPDE+Ow0KPiA+ICAJCQl9Ow0KPiA+DQo+ID4g
KwkJCXBjaWVfcGh5OiBwY2llLXBoeUAzMmYwMDAwMCB7DQo+ID4gKwkJCQljb21wYXRpYmxlID0g
ImZzbCxpbXg4bXAtcGNpZS1waHkiOw0KPiA+ICsJCQkJcmVnID0gPDB4MzJmMDAwMDAgMHgxMDAw
MD47DQo+ID4gKwkJCQlyZXNldHMgPSA8JnNyYyBJTVg4TVBfUkVTRVRfUENJRVBIWT4sDQo+ID4g
KwkJCQkJIDwmc3JjIElNWDhNUF9SRVNFVF9QQ0lFUEhZX1BFUlNUPjsNCj4gPiArCQkJCXJlc2V0
LW5hbWVzID0gInBjaWVwaHkiLCAicGVyc3QiOw0KPiA+ICsJCQkJcG93ZXItZG9tYWlucyA9IDwm
aHNpb19ibGtfY3RybA0KPiBJTVg4TVBfSFNJT0JMS19QRF9QQ0lFX1BIWT47DQo+ID4gKwkJCQkj
cGh5LWNlbGxzID0gPDA+Ow0KPiA+ICsJCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCj4gPiArCQkJ
fTsNCj4gPiArDQo+ID4gIAkJCWhzaW9fYmxrX2N0cmw6IGJsay1jdHJsQDMyZjEwMDAwIHsNCj4g
PiAgCQkJCWNvbXBhdGlibGUgPSAiZnNsLGlteDhtcC1oc2lvLWJsay1jdHJsIiwgInN5c2NvbiI7
DQo+ID4gIAkJCQlyZWcgPSA8MHgzMmYxMDAwMCAweDI0PjsNCj4gPiBAQCAtMTA5OSw2ICsxMTEy
LDM3IEBAIGhzaW9fYmxrX2N0cmw6IGJsay1jdHJsQDMyZjEwMDAwIHsNCj4gPiAgCQkJfTsNCj4g
PiAgCQl9Ow0KPiA+DQo+ID4gKwkJcGNpZTogcGNpZUAzMzgwMDAwMCB7DQo+ID4gKwkJCWNvbXBh
dGlibGUgPSAiZnNsLGlteDhtcC1wY2llIjsNCj4gPiArCQkJcmVnID0gPDB4MzM4MDAwMDAgMHg0
MDAwMDA+LCA8MHgxZmYwMDAwMCAweDgwMDAwPjsNCj4gPiArCQkJcmVnLW5hbWVzID0gImRiaSIs
ICJjb25maWciOw0KPiA+ICsJCQkjYWRkcmVzcy1jZWxscyA9IDwzPjsNCj4gPiArCQkJI3NpemUt
Y2VsbHMgPSA8Mj47DQo+ID4gKwkJCWRldmljZV90eXBlID0gInBjaSI7DQo+ID4gKwkJCWJ1cy1y
YW5nZSA9IDwweDAwIDB4ZmY+Ow0KPiA+ICsJCQlyYW5nZXMgPSAgPDB4ODEwMDAwMDAgMCAweDAw
MDAwMDAwIDB4MWZmODAwMDAgMA0KPiAweDAwMDEwMDAwPiwgLyogZG93bnN0cmVhbSBJL08gNjRL
QiAqLw0KPiA+ICsJCQkJICA8MHg4MjAwMDAwMCAwIDB4MTgwMDAwMDAgMHgxODAwMDAwMCAwDQo+
IDB4MDdmMDAwMDA+OyAvKiBub24tcHJlZmV0Y2hhYmxlIG1lbW9yeSAqLw0KPiA+ICsJCQludW0t
bGFuZXMgPSA8MT47DQo+ID4gKwkJCW51bS12aWV3cG9ydCA9IDw0PjsNCj4gPiArCQkJaW50ZXJy
dXB0cyA9IDxHSUNfU1BJIDE0MCBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCj4gPiArCQkJaW50ZXJy
dXB0LW5hbWVzID0gIm1zaSI7DQo+ID4gKwkJCSNpbnRlcnJ1cHQtY2VsbHMgPSA8MT47DQo+ID4g
KwkJCWludGVycnVwdC1tYXAtbWFzayA9IDwwIDAgMCAweDc+Ow0KPiA+ICsJCQlpbnRlcnJ1cHQt
bWFwID0gPDAgMCAwIDEgJmdpYyBHSUNfU1BJIDEyNg0KPiBJUlFfVFlQRV9MRVZFTF9ISUdIPiwN
Cj4gPiArCQkJCQk8MCAwIDAgMiAmZ2ljIEdJQ19TUEkgMTI1IElSUV9UWVBFX0xFVkVMX0hJR0g+
LA0KPiA+ICsJCQkJCTwwIDAgMCAzICZnaWMgR0lDX1NQSSAxMjQgSVJRX1RZUEVfTEVWRUxfSElH
SD4sDQo+ID4gKwkJCQkJPDAgMCAwIDQgJmdpYyBHSUNfU1BJIDEyMyBJUlFfVFlQRV9MRVZFTF9I
SUdIPjsNCj4gPiArCQkJZnNsLG1heC1saW5rLXNwZWVkID0gPDM+Ow0KPiA+ICsJCQlsaW51eCxw
Y2ktZG9tYWluID0gPDA+Ow0KPiA+ICsJCQlwb3dlci1kb21haW5zID0gPCZoc2lvX2Jsa19jdHJs
IElNWDhNUF9IU0lPQkxLX1BEX1BDSUU+Ow0KPiA+ICsJCQlyZXNldHMgPSA8JnNyYyBJTVg4TVBf
UkVTRVRfUENJRV9DVFJMX0FQUFNfRU4+LA0KPiA+ICsJCQkJIDwmc3JjIElNWDhNUF9SRVNFVF9Q
Q0lFX0NUUkxfQVBQU19UVVJOT0ZGPjsNCj4gPiArCQkJcmVzZXQtbmFtZXMgPSAiYXBwcyIsICJ0
dXJub2ZmIjsNCj4gPiArCQkJcGh5cyA9IDwmcGNpZV9waHk+Ow0KPiA+ICsJCQlwaHktbmFtZXMg
PSAicGNpZS1waHkiOw0KPiA+ICsJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiA+ICsJCX07DQo+
ID4gKw0KPiA+ICAJCWdwdTNkOiBncHVAMzgwMDAwMDAgew0KPiA+ICAJCQljb21wYXRpYmxlID0g
InZpdmFudGUsZ2MiOw0KPiA+ICAJCQlyZWcgPSA8MHgzODAwMDAwMCAweDgwMDA+Ow0KPiANCg0K
