Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F81B6CEC24
	for <lists+linux-pci@lfdr.de>; Wed, 29 Mar 2023 16:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjC2OvZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Mar 2023 10:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjC2OvY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Mar 2023 10:51:24 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2073.outbound.protection.outlook.com [40.107.247.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC7D8E;
        Wed, 29 Mar 2023 07:51:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/lG2GxH5i4gOye8eyrKm5TyoIQVnsQAzOrvFR2o9aupXRTxIhFg4CobizH2IUnS6nNyYBL+jvxSysnq2gO+cTGn8FcyXF0sJMZt/sTr4pZlUHnOb35y0ZNreoTY/3K1gaPKIrqZmWI5Kq01HPw5YJDx6vUNU+uokRXjJHeBLiUswBLAsP5DGkR/9dqwvb64wDvw0KXOy/h279ymKlGhvbeN4tUYPNqgYb1n5UVDLVO9WoxJWzzSDKueQ69d6mii90Lu7T9OpI/u4y5xLl+A53Y6ujxqcwZmMIL3pHm6urIvn2aqy9JoK2iG0gQJpBMiveWK7VKBq9HjjyHVlWaubA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X5uGx3BVIyXd1fUAmkJrY0sd100ZPW0mySJJ/sKSj90=;
 b=nzGfTL5GVcG49Cgd6rPH9vowR+Gihocs47+WTKEGJWCeuP+wbHuyQs2mYegH9RgewYFeNh1nhgZVYR9jFc5e9zPbm/ZZItkphbQPoCg0bcdWR8U9s58/eKjUSWS/8dvEgfnj9X7/z9FqOO4Fo+yAoO6i0XVYXFJ8AOsx7WxB4nlhap0hnIfYRKlUwsiBo4ZX91XRDhSJ2xDHoEVZ00JyGfTNrfgyOyrUJ+O/7AUJGo7tv0mqYe+v+TqE+nXiJyrI06rmp4YXFzGwu1CI8PX67WNxq5qHvlUWit09imanyx4Z0KJ5woNqOH1TWObRDFSv2XNnTHtZSJYCQGH25iP1fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5uGx3BVIyXd1fUAmkJrY0sd100ZPW0mySJJ/sKSj90=;
 b=iRYtmmR3DZKSFyWLiSw90726N0LFuNEXfjtTZLXMJcZd0x3nn0sue914YqLuTG9OyQJfdEHfPqAgQf8esaSJLsCn7ozb/GSg7/c35dRXCKmcEEnAB+rM2eEc5DQakVkOjFzAt3DMk2ds3WqPJ9OQy0BdFdJ56VXjDhwpBdgwTZM=
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DU2PR04MB8823.eurprd04.prod.outlook.com (2603:10a6:10:2e2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Wed, 29 Mar
 2023 14:51:18 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5%4]) with mapi id 15.20.6222.034; Wed, 29 Mar 2023
 14:51:18 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "konrad.dybcio@linaro.org" <konrad.dybcio@linaro.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "quic_krichai@quicinc.com" <quic_krichai@quicinc.com>,
        "johan+linaro@kernel.org" <johan+linaro@kernel.org>,
        "steev@kali.org" <steev@kali.org>,
        "mka@chromium.org" <mka@chromium.org>, Dhruva Gole <d-gole@ti.com>
Subject: RE: [EXT] [PATCH v3 1/1] PCI: qcom: Add support for system suspend
 and resume
Thread-Topic: [EXT] [PATCH v3 1/1] PCI: qcom: Add support for system suspend
 and resume
Thread-Index: AQHZYLF+mMMfa+oi40SnGUc9tSektK8OvhoggAL9+4CAABzWwA==
Date:   Wed, 29 Mar 2023 14:51:18 +0000
Message-ID: <AM6PR04MB483881374BA94940E8F0EDC588899@AM6PR04MB4838.eurprd04.prod.outlook.com>
References: <20230327133824.29136-1-manivannan.sadhasivam@linaro.org>
 <20230327133824.29136-2-manivannan.sadhasivam@linaro.org>
 <AM6PR04MB4838C84574BE534DDB0428D0888B9@AM6PR04MB4838.eurprd04.prod.outlook.com>
 <20230329130237.GC5575@thinkpad>
In-Reply-To: <20230329130237.GC5575@thinkpad>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB4838:EE_|DU2PR04MB8823:EE_
x-ms-office365-filtering-correlation-id: b516ffb8-cc7d-481c-c7d5-08db30650d96
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GDwM4KRihWfysO7fZ0EN66Tz8G7a0kphPyufSPQMuauuuyPwYt9uEmJueE+/udryd1+fdZfoQXz3gsECP027t2lMo1xcZ+11EeCSjxsmY3Umr4WUkPuNPv5+pXDxXto0novRy42a2tzz+Cry/ZGhr5hjigjPXCo1ClUqeq2zc3ipK1AH5hRP6kiePjTiBQiRJGx2/YWBLkTLRsOgtB41ExglQyfjqBZJpPaWYk93oHEuouAVSv6B7TsFn9Mq1Nw3h4mjDzoLX/JZQ/DW8zwYuq/4oVkuuh1RqY41Xh6HpDheBEojCOfTVxjRzNOnjDDLlAxFudfd3mrSG3rWG3O/7wOyOp+UZvXMydM+JHb0mbDmAYygrWOu+JJkeK565O/qdk9LC1AVufAq4mqnuOVToOfAuASLB+Iy7jBzOEhEEARYnNmrT0q2487PY3iLOFmZMQIV48KPCwvd9rf/vQSOiwcsiysfEw45ndoMHQgfzszKdLbRTkNTRck2ZioFcxBW+zUl1I47RsTvbBCrPhIRsJr3ZM7TnRhUT1gJXEab9cYufwMrGwOXDSP1e6rdVQzWXuPd9/mAvCOUFviCSGaYvTENmXMaTaZf9PoiAyqyp+BZFChWLClubdw9VtGuXrvR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(366004)(396003)(39860400002)(451199021)(83380400001)(122000001)(26005)(53546011)(55236004)(478600001)(54906003)(52536014)(38070700005)(7696005)(71200400001)(316002)(6506007)(66556008)(66946007)(76116006)(8676002)(64756008)(66446008)(66476007)(7416002)(6916009)(41300700001)(55016003)(86362001)(4326008)(9686003)(38100700002)(33656002)(15650500001)(44832011)(5660300002)(8936002)(2906002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0c2akVuY3FDMWhzaUlSYk5Ca2FaTnhqOHlNZ0dYUk9IczdLbEI3b3RhOTM3?=
 =?utf-8?B?Vm5wVkZtYTZmSENaUjFNeXNkbVB5UjNhV2RXbEc2Y1FFb3JhU2VEbERpd3Z5?=
 =?utf-8?B?WTA2djIrN0JLVzJpYXFSaWZNUHhJYXZsdndKUVNWOEJsTTJIeTBqZ2N6eFVD?=
 =?utf-8?B?Rkh0TElvc2NEazg2ZUFHeml6TE5lVENpb29zSHlnSkZGTGdMcGg2VDVtY0s1?=
 =?utf-8?B?ejRZNS9jbjFTU2p4Q3B4d1FJV1B1L28wV0VwZEtybWtPYjJGd1pOT1V3QjdR?=
 =?utf-8?B?aGwwdWU4cWJ2SVk2TVNQYXF2Tko3SEpVOHNLMXI1U0VVRW44NEVaUDJNL3Fn?=
 =?utf-8?B?ZmQwMWdYam9SYVZTajVCaU1KdDBYM0pPQnltYWYrZ3NvRnc3WWYrbnY3L0NQ?=
 =?utf-8?B?ME5XNXFZVVZISkdtNXIxN3N4b3BwRVdMVjNVTTIwN2R0bExBT25LRVBxNmZx?=
 =?utf-8?B?MnkvMEdMREEwUm9LT2JqdTZXdVFPWTJYS0FDU2FxM2duOTZxVUpWaytGZEtT?=
 =?utf-8?B?ZmFJVVB3R0FlZjZ2RTRkRkF3cEt4ZlQ1WDlRMG1STlJtNXA1TzhyUVFmai9D?=
 =?utf-8?B?OEtaVnBiQjV6VnZnQmtDN1laVnk5ZzdhcTVBTmFQd2k1bkJZeEdnTzk5T1pm?=
 =?utf-8?B?dlIrOTJoZjEraVNxSnplUnlhci9vOGxMWmxtT1BjQ1pLVG1ONkc1TXA5UVhr?=
 =?utf-8?B?L09ocW1MVHMxajRmb3R6TUxHN1pCR1lKTUNDNDNMejR1cWwyRENLYmVleG9q?=
 =?utf-8?B?Uk1iWG40MHJjM21YYURneDk5bTFnSHNzemxSSE8vVFZ3bTE4WERkRlM5cmhr?=
 =?utf-8?B?QXBMS3NYdHV0Rlk5QTdSejNFa2ZRYmVUVWkzNGU5SnhZbE1vWWJaSjNlSm1F?=
 =?utf-8?B?bDE1dDhHTDlkakR5NzdHbWV2V1MwL1hxcURpbEZKTUE4UTh1dXJMNlpISEdJ?=
 =?utf-8?B?Z0ttZTIvWFlvWU1lNlRPTXcvSG9XYUtiZ3FyWnFFM0FDSFVUeFZNeW1McUNu?=
 =?utf-8?B?OE9WVWl6YVpRbnhvRE53RkttanBBT0d4QzlZdzJUbVY2a081bjhNbDN0MG5m?=
 =?utf-8?B?cUpxWjF3dThJMWNDWGtDVWJHb0NwR2lhUVVydzBLYm0wUnJXeVRmcXZFNjFr?=
 =?utf-8?B?ZHlTMSszeVdqVkpTMk5vd2lVR2JQQ2NucGZTa05hNXB5Wms2VUkzQUlUelRC?=
 =?utf-8?B?UlBZL0dLd255bGlTMmR6SXhNUS9CcURidG1SKzE0eXdJTGNZNmVhWWoyNUIr?=
 =?utf-8?B?ZEttL29rYjZYaG8xMlRDelpLbjdnTEI1U2d1K0J2c25VTlFsY1NrVmFQNmZS?=
 =?utf-8?B?Vk53Y3pDbGZUVEFOZ1JvZmx0Tyt3b0NmN2VRNkpmUmtsY1I5cVJJTW9tRlJ3?=
 =?utf-8?B?K1FQUkVKeFE4ZWlONlo2NTU3NjhWNVVPdlN4aUVQRkQyYys0c1BRWFJjeVpS?=
 =?utf-8?B?ZEdwYWtXcWtMUjU2eUI2TW1YNWZNWDdVS1ZpWWxiSG5RUS9DeW1tekh4cTZW?=
 =?utf-8?B?NHhka3lKVW5QTXVZL0VFZzZobkltaWl3V0RVckdkNkp3eXNmVlArSFh1R2hD?=
 =?utf-8?B?U2FDK3NlbGVnbmptQyt2bmhoQlpneGJEYml3bFUvYS8vcllFOUhaWVBBMDBu?=
 =?utf-8?B?SWNaa3NmUXlvK2NaWWt6VVYrZWh4S3AzV3Q1VWZQNUVrMzcrcmZSTm50aWVw?=
 =?utf-8?B?dEZSMm1raWpoYTNmOUNBNHhmR0x1QWdBbzh0d0c2RGZ3NnVzNEVGRHJHaW9O?=
 =?utf-8?B?VG1SRTBDazRvNDdXZUw5NFN5SXdaaTJsMWQrZXZ4a2FHcDNUL291STBKZzRj?=
 =?utf-8?B?SFJJWmZMWGxGMjFXaG5UdWx3dUJRQjRtZFdJcDRsQjByQkpTZDFCZG9iRWRy?=
 =?utf-8?B?bFBkNjlNUmtHYWVvbmx2WGMxUTlmMFFDZFFoOU1vRkgwTFI4VFVRSXZXQlVN?=
 =?utf-8?B?VzRFUEJVS3hxM1ZYTnpTMDZ1eTVuSGdPcG1iYzdKQzBKb2RYQVoyUSsyMmxj?=
 =?utf-8?B?VmFMYXNsWkE2aGNZMEhrcW1aa2Z6ZmVQcUF0b0RLNnUzbmlpV3g0SXIxSFJi?=
 =?utf-8?B?cmJ0V1FhbXo5NWlGSkJsR2VrWVBuY053dUM4ZW1sWFJVcGlxVUlWdkZGTk12?=
 =?utf-8?Q?5Uus=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b516ffb8-cc7d-481c-c7d5-08db30650d96
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2023 14:51:18.0723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rUF3YimiSV2OY8HZWmy/AcN2tKCrQyrrTqZBKDAn5cNVtORMhnYbv+f7ABvVWElfep3gCPxyheJgZmFjYgY2Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8823
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFuaXZhbm5hbiBTYWRo
YXNpdmFtIDxtYW5pdmFubmFuLnNhZGhhc2l2YW1AbGluYXJvLm9yZz4NCj4gU2VudDogV2VkbmVz
ZGF5LCBNYXJjaCAyOSwgMjAyMyA4OjAzIEFNDQo+IFRvOiBGcmFuayBMaSA8ZnJhbmsubGlAbnhw
LmNvbT4NCj4gQ2M6IGxwaWVyYWxpc2lAa2VybmVsLm9yZzsga3dAbGludXguY29tOyByb2JoQGtl
cm5lbC5vcmc7DQo+IGFuZGVyc3NvbkBrZXJuZWwub3JnOyBrb25yYWQuZHliY2lvQGxpbmFyby5v
cmc7IGJoZWxnYWFzQGdvb2dsZS5jb207DQo+IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IGxp
bnV4LWFybS1tc21Admdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVs
Lm9yZzsgcXVpY19rcmljaGFpQHF1aWNpbmMuY29tOyBqb2hhbitsaW5hcm9Aa2VybmVsLm9yZzsN
Cj4gc3RlZXZAa2FsaS5vcmc7IG1rYUBjaHJvbWl1bS5vcmc7IERocnV2YSBHb2xlIDxkLWdvbGVA
dGkuY29tPg0KPiBTdWJqZWN0OiBSZTogW0VYVF0gW1BBVENIIHYzIDEvMV0gUENJOiBxY29tOiBB
ZGQgc3VwcG9ydCBmb3Igc3lzdGVtIHN1c3BlbmQNCj4gYW5kIHJlc3VtZQ0KPiANCj4gQ2F1dGlv
bjogRVhUIEVtYWlsDQo+IA0KPiBPbiBNb24sIE1hciAyNywgMjAyMyBhdCAwMzoyOTo1NFBNICsw
MDAwLCBGcmFuayBMaSB3cm90ZToNCj4gPg0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiA+ID4gRnJvbTogTWFuaXZhbm5hbiBTYWRoYXNpdmFtIDxtYW5pdmFubmFuLnNh
ZGhhc2l2YW1AbGluYXJvLm9yZz4NCj4gPiA+IFNlbnQ6IE1vbmRheSwgTWFyY2ggMjcsIDIwMjMg
ODozOCBBTQ0KPiA+ID4gVG86IGxwaWVyYWxpc2lAa2VybmVsLm9yZzsga3dAbGludXguY29tOyBy
b2JoQGtlcm5lbC5vcmcNCj4gPiA+IENjOiBhbmRlcnNzb25Aa2VybmVsLm9yZzsga29ucmFkLmR5
YmNpb0BsaW5hcm8ub3JnOw0KPiA+ID4gYmhlbGdhYXNAZ29vZ2xlLmNvbTsgbGludXgtcGNpQHZn
ZXIua2VybmVsLm9yZzsgbGludXgtYXJtLQ0KPiA+ID4gbXNtQHZnZXIua2VybmVsLm9yZzsgbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gPiA+IHF1aWNfa3JpY2hhaUBxdWljaW5jLmNv
bTsgam9oYW4rbGluYXJvQGtlcm5lbC5vcmc7IHN0ZWV2QGthbGkub3JnOw0KPiA+ID4gbWthQGNo
cm9taXVtLm9yZzsgTWFuaXZhbm5hbiBTYWRoYXNpdmFtDQo+ID4gPiA8bWFuaXZhbm5hbi5zYWRo
YXNpdmFtQGxpbmFyby5vcmc+OyBEaHJ1dmEgR29sZSA8ZC1nb2xlQHRpLmNvbT4NCj4gPiA+IFN1
YmplY3Q6IFtFWFRdIFtQQVRDSCB2MyAxLzFdIFBDSTogcWNvbTogQWRkIHN1cHBvcnQgZm9yIHN5
c3RlbSBzdXNwZW5kDQo+ID4gPiBhbmQgcmVzdW1lDQo+ID4gPg0KPiA+ID4gQ2F1dGlvbjogRVhU
IEVtYWlsDQo+ID4gPg0KPiA+ID4gRHVyaW5nIHRoZSBzeXN0ZW0gc3VzcGVuZCwgdm90ZSBmb3Ig
bWluaW1hbCBpbnRlcmNvbm5lY3QgYmFuZHdpZHRoIGFuZA0KPiA+ID4gYWxzbyB0dXJuIE9GRiB0
aGUgcmVzb3VyY2VzIGxpa2UgY2xvY2sgYW5kIFBIWSBpZiB0aGVyZSBhcmUgbm8gYWN0aXZlDQo+
ID4gPiBkZXZpY2VzIGNvbm5lY3RlZCB0byB0aGUgY29udHJvbGxlci4gRm9yIHRoZSBjb250cm9s
bGVycyB3aXRoIGFjdGl2ZQ0KPiA+ID4gZGV2aWNlcywgdGhlIHJlc291cmNlcyBhcmUga2VwdCBP
TiBhcyByZW1vdmluZyB0aGUgcmVzb3VyY2VzIHdpbGwNCj4gPiA+IHRyaWdnZXIgYWNjZXNzIHZp
b2xhdGlvbiBkdXJpbmcgdGhlIGxhdGUgZW5kIG9mIHN1c3BlbmQgY3ljbGUgYXMga2VybmVsDQo+
ID4gPiB0cmllcyB0byBhY2Nlc3MgdGhlIGNvbmZpZyBzcGFjZSBvZiBQQ0llIGRldmljZXMgdG8g
bWFzayB0aGUgTVNJcy4NCj4gPg0KPiA+IEkgcmVtZW1iZXIgSSBtZXQgc2ltaWxhciBwcm9ibGVt
IGJlZm9yZS4gSXQgaXMgcmVsYXRlIEFTUE0gc2V0dGluZ3Mgb2YNCj4gTlZNRS4NCj4gPiBOVk1F
IHRyeSB0byB1c2UgTDEuMiBhdCBzdXNwZW5kIHRvIHNhdmUgcmVzdG9yZSB0aW1lLg0KPiA+DQo+
ID4gSXQgc2hvdWxkIGJlIHVzZXIgZGVjaWRlZCBpZiBQQ0kgZW50ZXIgTDEuMiggZm9yIGJldHRl
ciByZXN1bWUgdGltZSkgb3IgTDINCj4gPiBGb3IgYmF0dGVyIHBvd2VyIHNhdmluZy4gIElmIE5W
TUUgZGlzYWJsZSBBU1BNLCAgTlZNRSBkcml2ZXIgd2lsbCBmcmVlDQo+ID4gTXNpIGlycSBiZWZv
cmUgZW50ZXIgc3VzcGVuZCwgIHNvIG5vdCBpc3N1ZSBhY2Nlc3MgY29uZmlnIHNwYWNlIGJ5IE1T
SQ0KPiA+IElycSBkaXNhYmxlIGZ1bmN0aW9uLg0KPiA+DQo+IA0KPiBUaGUgTlZNZSBkcml2ZXIg
d2lsbCBvbmx5IHNodXRkb3duIHRoZSBkZXZpY2UgaWYgQVNQTSBpcyBjb21wbGV0ZWx5DQo+IGRp
c2FibGVkIGluDQo+IHRoZSBrZXJuZWwuIFRoZXkgYWxzbyB0YWtlIHBvd2VyZG93biBwYXRoIGZv
ciBzb21lIEludGVsIHBsYXRmb3JtcyB0aG91Z2guDQo+IEZvcg0KPiBvdGhlcnMsIHRoZXkga2Vl
cCB0aGUgZGV2aWNlIGluIHBvd2VyIG9uIHN0YXRlIGFuZCBleHBlY3QgcG93ZXIgc2F2aW5nIHdp
dGgNCj4gQVNQTS4NCg0KSXQgYXBwZWFycyB0aGF0IG5vdCBldmVyeSBkZXZpY2UgaXMgY29tcGF0
aWJsZSB3aXRoIEwxLjIgQVNQTS4NCg0KVGhlIFBDSSBjb250cm9sbGVyIGRyaXZlciBzaG91bGQg
bWFuYWdlIHRoaXMgc2l0dWF0aW9uIGJ5IHRyYW5zaXRpb25pbmcgZGV2aWNlcyB0byBMMi8zDQp3
aGVuIHRoZSBzeXN0ZW0gaXMgc3VzcGVuZGVkLiBIb3dldmVyLCBJIGFtIHVuc3VyZSBvZiB0aGUg
YXBwcm9wcmlhdGUgbWV0aG9kIGZvcg0KaGFuZGxpbmcgdGhpcyBjYXNlLi4gDQoNCj4gDQo+ID4g
VGhpcyBpcyBqdXN0IGdlbmVyYWwgY29tbWVudC4gSXQgaXMgbm90IHNwZWNpZmljIGZvciB0aGlz
IHBhdGNoZXMuICBNYW55DQo+IHBsYXRmb3JtDQo+ID4gV2lsbCBmYWNlIHRoZSBzaW1pbGFyIHBy
b2JsZW0uICBNYXliZSBuZWVkIGJldHRlciBzb2x1dGlvbiB0byBoYW5kbGUNCj4gPiBMMi9MMyBm
b3IgYmV0dGVyIHBvd2VyIHNhdmluZyBpbiBmdXR1cmUuDQo+ID4NCj4gDQo+IFRoZSBvbmx5IGFy
Z3VtZW50IEkgaGVhciBmcm9tIHRoZW0gaXMgdGhhdCwgd2hlbiB0aGUgTlZNZSBkZXZpY2UgZ2V0
cw0KPiBwb3dlcmVkDQo+IGRvd24gZHVyaW5nIHN1c3BlbmQsIHRoZW4gaXQgbWF5IGRldG9yaWF0
ZSB0aGUgbGlmZSB0aW1lIG9mIGl0IGFzIHRoZSBzdXNwZW5kDQo+IGN5Y2xlIGlzIGdvaW5nIHRv
IGJlIGhpZ2guDQo+IA0KPiAtIE1hbmkNCj4gDQo+ID4gRnJhbmsgTGkNCj4gPg0KPiA+ID4NCj4g
PiA+IEFsc28sIGl0IGlzIG5vdCBkZXNpcmFibGUgdG8gcHV0IHRoZSBsaW5rIGludG8gTDIvTDMg
c3RhdGUgYXMgdGhhdA0KPiA+ID4gaW1wbGllcyBWREQgc3VwcGx5IHdpbGwgYmUgcmVtb3ZlZCBh
bmQgdGhlIGRldmljZXMgbWF5IGdvIGludG8NCj4gcG93ZXJkb3duDQo+ID4gPiBzdGF0ZS4gVGhp
cyB3aWxsIGFmZmVjdCB0aGUgbGlmZXRpbWUgb2Ygc3RvcmFnZSBkZXZpY2VzIGxpa2UgTlZNZS4N
Cj4gPiA+DQo+ID4gPiBBbmQgZmluYWxseSwgZHVyaW5nIHJlc3VtZSwgdHVybiBPTiB0aGUgcmVz
b3VyY2VzIGlmIHRoZSBjb250cm9sbGVyIHdhcw0KPiA+ID4gdHJ1bHkgc3VzcGVuZGVkIChyZXNv
dXJjZXMgT0ZGKSBhbmQgdXBkYXRlIHRoZSBpbnRlcmNvbm5lY3QgYmFuZHdpZHRoDQo+ID4gPiBi
YXNlZCBvbiBQQ0llIEdlbiBzcGVlZC4NCj4gPiA+DQo+ID4gPiBTdWdnZXN0ZWQtYnk6IEtyaXNo
bmEgY2hhaXRhbnlhIGNodW5kcnUgPHF1aWNfa3JpY2hhaUBxdWljaW5jLmNvbT4NCj4gPiA+IEFj
a2VkLWJ5OiBEaHJ1dmEgR29sZSA8ZC1nb2xlQHRpLmNvbT4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6
IE1hbml2YW5uYW4gU2FkaGFzaXZhbQ0KPiA+ID4gPG1hbml2YW5uYW4uc2FkaGFzaXZhbUBsaW5h
cm8ub3JnPg0KPiA+ID4gLS0tDQo+ID4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNp
ZS1xY29tLmMgfCA2Mg0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ID4gIDEgZmls
ZSBjaGFuZ2VkLCA2MiBpbnNlcnRpb25zKCspDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtcWNvbS5jDQo+ID4gPiBiL2RyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvZHdjL3BjaWUtcWNvbS5jDQo+ID4gPiBpbmRleCBhMjMyYjA0YWYwNDguLmYz
M2RmNTM2ZDliZSAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdj
L3BjaWUtcWNvbS5jDQo+ID4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ll
LXFjb20uYw0KPiA+ID4gQEAgLTIyNyw2ICsyMjcsNyBAQCBzdHJ1Y3QgcWNvbV9wY2llIHsNCj4g
PiA+ICAgICAgICAgc3RydWN0IGdwaW9fZGVzYyAqcmVzZXQ7DQo+ID4gPiAgICAgICAgIHN0cnVj
dCBpY2NfcGF0aCAqaWNjX21lbTsNCj4gPiA+ICAgICAgICAgY29uc3Qgc3RydWN0IHFjb21fcGNp
ZV9jZmcgKmNmZzsNCj4gPiA+ICsgICAgICAgYm9vbCBzdXNwZW5kZWQ7DQo+ID4gPiAgfTsNCj4g
PiA+DQo+ID4gPiAgI2RlZmluZSB0b19xY29tX3BjaWUoeCkgICAgICAgICAgICAgICAgZGV2X2dl
dF9kcnZkYXRhKCh4KS0+ZGV2KQ0KPiA+ID4gQEAgLTE4MjAsNiArMTgyMSw2MiBAQCBzdGF0aWMg
aW50IHFjb21fcGNpZV9wcm9iZShzdHJ1Y3QNCj4gPiA+IHBsYXRmb3JtX2RldmljZSAqcGRldikN
Cj4gPiA+ICAgICAgICAgcmV0dXJuIHJldDsNCj4gPiA+ICB9DQo+ID4gPg0KPiA+ID4gK3N0YXRp
YyBpbnQgcWNvbV9wY2llX3N1c3BlbmRfbm9pcnEoc3RydWN0IGRldmljZSAqZGV2KQ0KPiA+ID4g
K3sNCj4gPiA+ICsgICAgICAgc3RydWN0IHFjb21fcGNpZSAqcGNpZSA9IGRldl9nZXRfZHJ2ZGF0
YShkZXYpOw0KPiA+ID4gKyAgICAgICBpbnQgcmV0Ow0KPiA+ID4gKw0KPiA+ID4gKyAgICAgICAv
Kg0KPiA+ID4gKyAgICAgICAgKiBTZXQgbWluaW11bSBiYW5kd2lkdGggcmVxdWlyZWQgdG8ga2Vl
cCBkYXRhIHBhdGggZnVuY3Rpb25hbA0KPiBkdXJpbmcNCj4gPiA+ICsgICAgICAgICogc3VzcGVu
ZC4NCj4gPiA+ICsgICAgICAgICovDQo+ID4gPiArICAgICAgIHJldCA9IGljY19zZXRfYncocGNp
ZS0+aWNjX21lbSwgMCwgTUJwc190b19pY2MoMjUwKSk7DQo+ID4gPiArICAgICAgIGlmIChyZXQp
IHsNCj4gPiA+ICsgICAgICAgICAgICAgICBkZXZfZXJyKGRldiwgIkZhaWxlZCB0byBzZXQgaW50
ZXJjb25uZWN0IGJhbmR3aWR0aDogJWRcbiIsIHJldCk7DQo+ID4gPiArICAgICAgICAgICAgICAg
cmV0dXJuIHJldDsNCj4gPiA+ICsgICAgICAgfQ0KPiA+ID4gKw0KPiA+ID4gKyAgICAgICAvKg0K
PiA+ID4gKyAgICAgICAgKiBUdXJuIE9GRiB0aGUgcmVzb3VyY2VzIG9ubHkgZm9yIGNvbnRyb2xs
ZXJzIHdpdGhvdXQgYWN0aXZlIFBDSWUNCj4gPiA+ICsgICAgICAgICogZGV2aWNlcy4gRm9yIGNv
bnRyb2xsZXJzIHdpdGggYWN0aXZlIGRldmljZXMsIHRoZSByZXNvdXJjZXMgYXJlIGtlcHQNCj4g
PiA+ICsgICAgICAgICogT04gYW5kIHRoZSBsaW5rIGlzIGV4cGVjdGVkIHRvIGJlIGluIEwwL0wx
IChzdWIpc3RhdGVzLg0KPiA+ID4gKyAgICAgICAgKg0KPiA+ID4gKyAgICAgICAgKiBUdXJuaW5n
IE9GRiB0aGUgcmVzb3VyY2VzIGZvciBjb250cm9sbGVycyB3aXRoIGFjdGl2ZSBQQ0llIGRldmlj
ZXMNCj4gPiA+ICsgICAgICAgICogd2lsbCB0cmlnZ2VyIGFjY2VzcyB2aW9sYXRpb24gZHVyaW5n
IHRoZSBlbmQgb2YgdGhlIHN1c3BlbmQgY3ljbGUsDQo+ID4gPiArICAgICAgICAqIGFzIGtlcm5l
bCB0cmllcyB0byBhY2Nlc3MgdGhlIFBDSWUgZGV2aWNlcyBjb25maWcgc3BhY2UgZm9yIG1hc2tp
bmcNCj4gPiA+ICsgICAgICAgICogTVNJcy4NCj4gPiA+ICsgICAgICAgICoNCj4gPiA+ICsgICAg
ICAgICogQWxzbywgaXQgaXMgbm90IGRlc2lyYWJsZSB0byBwdXQgdGhlIGxpbmsgaW50byBMMi9M
MyBzdGF0ZSBhcyB0aGF0DQo+ID4gPiArICAgICAgICAqIGltcGxpZXMgVkREIHN1cHBseSB3aWxs
IGJlIHJlbW92ZWQgYW5kIHRoZSBkZXZpY2VzIG1heSBnbyBpbnRvDQo+ID4gPiArICAgICAgICAq
IHBvd2VyZG93biBzdGF0ZS4gVGhpcyB3aWxsIGFmZmVjdCB0aGUgbGlmZXRpbWUgb2YgdGhlIHN0
b3JhZ2UNCj4gZGV2aWNlcw0KPiA+ID4gKyAgICAgICAgKiBsaWtlIE5WTWUuDQo+ID4gPiArICAg
ICAgICAqLw0KPiA+ID4gKyAgICAgICBpZiAoIWR3X3BjaWVfbGlua191cChwY2llLT5wY2kpKSB7
DQo+ID4gPiArICAgICAgICAgICAgICAgcWNvbV9wY2llX2hvc3RfZGVpbml0KCZwY2llLT5wY2kt
PnBwKTsNCj4gPiA+ICsgICAgICAgICAgICAgICBwY2llLT5zdXNwZW5kZWQgPSB0cnVlOw0KPiA+
ID4gKyAgICAgICB9DQo+ID4gPiArDQo+ID4gPiArICAgICAgIHJldHVybiAwOw0KPiA+ID4gK30N
Cj4gPiA+ICsNCj4gPiA+ICtzdGF0aWMgaW50IHFjb21fcGNpZV9yZXN1bWVfbm9pcnEoc3RydWN0
IGRldmljZSAqZGV2KQ0KPiA+ID4gK3sNCj4gPiA+ICsgICAgICAgc3RydWN0IHFjb21fcGNpZSAq
cGNpZSA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiA+ID4gKyAgICAgICBpbnQgcmV0Ow0KPiA+
ID4gKw0KPiA+ID4gKyAgICAgICBpZiAocGNpZS0+c3VzcGVuZGVkKSB7DQo+ID4gPiArICAgICAg
ICAgICAgICAgcmV0ID0gcWNvbV9wY2llX2hvc3RfaW5pdCgmcGNpZS0+cGNpLT5wcCk7DQo+ID4g
PiArICAgICAgICAgICAgICAgaWYgKHJldCkNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
IHJldHVybiByZXQ7DQo+ID4gPiArDQo+ID4gPiArICAgICAgICAgICAgICAgcGNpZS0+c3VzcGVu
ZGVkID0gZmFsc2U7DQo+ID4gPiArICAgICAgIH0NCj4gPiA+ICsNCj4gPiA+ICsgICAgICAgcWNv
bV9wY2llX2ljY191cGRhdGUocGNpZSk7DQo+ID4gPiArDQo+ID4gPiArICAgICAgIHJldHVybiAw
Ow0KPiA+ID4gK30NCj4gPiA+ICsNCj4gPiA+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2Rldmlj
ZV9pZCBxY29tX3BjaWVfbWF0Y2hbXSA9IHsNCj4gPiA+ICAgICAgICAgeyAuY29tcGF0aWJsZSA9
ICJxY29tLHBjaWUtYXBxODA2NCIsIC5kYXRhID0gJmNmZ18yXzFfMCB9LA0KPiA+ID4gICAgICAg
ICB7IC5jb21wYXRpYmxlID0gInFjb20scGNpZS1hcHE4MDg0IiwgLmRhdGEgPSAmY2ZnXzFfMF8w
IH0sDQo+ID4gPiBAQCAtMTg1NiwxMiArMTkxMywxNyBAQA0KPiA+ID4gREVDTEFSRV9QQ0lfRklY
VVBfRUFSTFkoUENJX1ZFTkRPUl9JRF9RQ09NLCAweDAzMDIsDQo+ID4gPiBxY29tX2ZpeHVwX2Ns
YXNzKTsNCj4gPiA+ICBERUNMQVJFX1BDSV9GSVhVUF9FQVJMWShQQ0lfVkVORE9SX0lEX1FDT00s
IDB4MTAwMCwNCj4gPiA+IHFjb21fZml4dXBfY2xhc3MpOw0KPiA+ID4gIERFQ0xBUkVfUENJX0ZJ
WFVQX0VBUkxZKFBDSV9WRU5ET1JfSURfUUNPTSwgMHgxMDAxLA0KPiA+ID4gcWNvbV9maXh1cF9j
bGFzcyk7DQo+ID4gPg0KPiA+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgZGV2X3BtX29wcyBxY29t
X3BjaWVfcG1fb3BzID0gew0KPiA+ID4gKyAgICAgICBOT0lSUV9TWVNURU1fU0xFRVBfUE1fT1BT
KHFjb21fcGNpZV9zdXNwZW5kX25vaXJxLA0KPiA+ID4gcWNvbV9wY2llX3Jlc3VtZV9ub2lycSkN
Cj4gPiA+ICt9Ow0KPiA+ID4gKw0KPiA+ID4gIHN0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVy
IHFjb21fcGNpZV9kcml2ZXIgPSB7DQo+ID4gPiAgICAgICAgIC5wcm9iZSA9IHFjb21fcGNpZV9w
cm9iZSwNCj4gPiA+ICAgICAgICAgLmRyaXZlciA9IHsNCj4gPiA+ICAgICAgICAgICAgICAgICAu
bmFtZSA9ICJxY29tLXBjaWUiLA0KPiA+ID4gICAgICAgICAgICAgICAgIC5zdXBwcmVzc19iaW5k
X2F0dHJzID0gdHJ1ZSwNCj4gPiA+ICAgICAgICAgICAgICAgICAub2ZfbWF0Y2hfdGFibGUgPSBx
Y29tX3BjaWVfbWF0Y2gsDQo+ID4gPiArICAgICAgICAgICAgICAgLnBtID0gJnFjb21fcGNpZV9w
bV9vcHMsDQo+ID4gPiAgICAgICAgIH0sDQo+ID4gPiAgfTsNCj4gPiA+ICBidWlsdGluX3BsYXRm
b3JtX2RyaXZlcihxY29tX3BjaWVfZHJpdmVyKTsNCj4gPiA+IC0tDQo+ID4gPiAyLjI1LjENCj4g
Pg0KPiANCj4gLS0NCj4g4K6u4K6j4K6/4K614K6j4K+N4K6j4K6p4K+NIOCumuCupOCuvuCumuCu
v+CuteCuruCvjQ0K
