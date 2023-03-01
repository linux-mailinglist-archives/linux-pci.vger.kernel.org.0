Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2CC16A65DF
	for <lists+linux-pci@lfdr.de>; Wed,  1 Mar 2023 03:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjCAC5w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Feb 2023 21:57:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjCAC5v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Feb 2023 21:57:51 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2055.outbound.protection.outlook.com [40.107.249.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A951199CA;
        Tue, 28 Feb 2023 18:57:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ERTQBAqBCiZg4Ys3eFPLohLGu3qPKdxkQb1tKj0OgHFJRKVU+x5TKME1rBYrHTDXE3qFofH72m7Ktjb1No1fcZCn2uuLmQKSZ8Ug5PHVgJ1EnczyUwWNL44VoU3dyjpPx/JDgMCmu4GVIc6t0JJYH7ChJ1SI89+L6bVaOTtk9tHR3UPxz2ujPiLZ7ubTuniYVZh+UPvTMxD9lZcFaWnf9T/OKPpj9TdAUXuDJVo45m/x48/w3+qWBGSd4oBogZ4BLKX9EsXFnLf8gas4RaGYxVHMTUVHUztcLdsj6Cs39a6s8NK/+FODjh5Y3+cYKkYt+z3tMl44CopOhMQJ/AKz+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gAaXQTk/8lpbkEVKa6lX7Oi6aqRmIoqzdiGaZuT1ogg=;
 b=X/GGRvSKGZH5gavIC5/ST7cp3Vl2hWm0XAwHNrUgYbJVsXzQRHz3+qyqkZKlF2JdxCYs93aBotD8YDdEoUChKXwdd4D2UzG/uU2JRvmSMYrwCvi6bqeV73pHcJMlAot/x33GjK9cvFmqsYfKmKCUCcJmQwZYh0Wv+T6JGAFHP31yfqNk1ZjR38CNnX60H+x9F0nAtxEFcSUST9637dFwpkOi5RBcCAF/6hY0VWNpB0QwWrlObZhUayOESYz+t6+VUSuRYi9QoA1/WyrPxRKnmWcg+wd7jM8tYHfinmiq9V7g0/vCv5FLmcN3C8y7RuKCSgJbluTwzj0VpwJ2PQvXFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAaXQTk/8lpbkEVKa6lX7Oi6aqRmIoqzdiGaZuT1ogg=;
 b=mlnJpgrwEk9zAUQHLaXEB+NV+zBbCn36ApgMIPZZgeGN5qPPmE32sWu9xNFkI/ZmvqG9SDEnHgKOTUl0RoivuwZ3eiz/EG2fWZeUoSveSEkJ54G0428hvvXhT9M3qtjF4/sZTl065OUAxQpGjwDs+P2NUjYhA0krsxtOaEuRs1E=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM9PR04MB7539.eurprd04.prod.outlook.com (2603:10a6:20b:2da::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Wed, 1 Mar
 2023 02:57:48 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::4dcb:740c:bf92:954a]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::4dcb:740c:bf92:954a%9]) with mapi id 15.20.6134.030; Wed, 1 Mar 2023
 02:57:47 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?gb2312?B?S3J6eXN6dG9mIFdpbGN6eai9c2tp?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
CC:     Rob Herring <robh@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "letux-kernel@openphoenux.org" <letux-kernel@openphoenux.org>,
        "kernel@pyra-handheld.com" <kernel@pyra-handheld.com>
Subject: RE: [PATCH] PCI: imx6: install the fault handler only if we are
 really running on a compatible device
Thread-Topic: [PATCH] PCI: imx6: install the fault handler only if we are
 really running on a compatible device
Thread-Index: AQHZS1EHICpdYlYwtUmH3LacIYMvOa7lOMuA
Date:   Wed, 1 Mar 2023 02:57:47 +0000
Message-ID: <AS8PR04MB8676676FCDB679626CAB81B48CAD9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <aa1c18c70bea1d6f99c88027dc72c700e8c309a2.1677573834.git.hns@goldelico.com>
In-Reply-To: <aa1c18c70bea1d6f99c88027dc72c700e8c309a2.1677573834.git.hns@goldelico.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|AM9PR04MB7539:EE_
x-ms-office365-filtering-correlation-id: 609b5f6b-dc5f-4d11-5712-08db1a00bd24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HnDOv51d5OPF58A8pSDW+Ww9TmJPMTygGGzErOSg8QWrvKu4mdeO8ut43YZc/P2zCxbLnbXrJ2/SmWUQjHstvdcw7aoEx6MDu4PEY3MGLqs4rJ56bq8XXpgajFxO2O7JQcQnd15JyoJsD0BqtQGZfttjQK3hdsNgg5Yq3De0P4ls0j8DmNi+dyroIacrN8HGrDU5i82wcriAFAgdJ4LuDdW0SA51bvzh6zJNHHbXNYtDJfdNhoYXUWp/2bIrF3/ajur37pFOebSBk9LDvo+FSM2b69bmAtcKc0XtZMsmvidAhZ+QeNvmIM/MJyKEIkEq2Y+oxlWn3nFIMa2SVImjJzknFTOra+yiqO/8M4kMMNb5oEjADM1gth9/2AGiQc/wg76o+Mkwd8Qw6HmeEL9J9i/xVdCscVPleElRzYlt8bWWSvpbifLRrX/KIsT2RaMhn+bjSxWXK7r375fdM3VBaYud7HUiZAtZ/6us+HZC5hsDGgLtrXyb3oeawDyk/KKX5oD4Hq1P5+hsdsVnw4Ir5UYP+pBxHs3+P1qdFx6Fm3NXamJ66OoFVP3Z/RRNm0h67cNqFhD9fCrwbyOlNNeWO0osU5fh7BNAa06SrERjccuqBZFrMvSP3kQ44OV7f6aPac/fD60LDTlj5y0TfA+7Qjx6LfPyvUdEEV/W3N4OoRuxxQnCBHyQfnMVJTBjnk37bzvggBnSaBg3C2AKQ5ZvgQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(376002)(366004)(39860400002)(136003)(451199018)(44832011)(5660300002)(478600001)(7416002)(9686003)(83380400001)(33656002)(53546011)(186003)(38070700005)(6506007)(86362001)(66574015)(55016003)(7696005)(2906002)(71200400001)(316002)(54906003)(41300700001)(38100700002)(122000001)(4326008)(76116006)(66946007)(8676002)(66556008)(66476007)(66446008)(64756008)(8936002)(110136005)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?UWRaS1FqN2JzRzNHUGQyeCtKV0w1WjBmMGdDRk4yQStTcno3ZVZEWlNLYnJp?=
 =?gb2312?B?bm1YcDZOWjVuYXhsSWovUGlaRGpPVENuT0xiSk91Z2RBdGYxUHNUeEtxbWd0?=
 =?gb2312?B?RWM3OFpUM3FlUGEyajZJUEdTazdXSitHUTFEQis5VkFHdStvTDVCSUQ2WlB5?=
 =?gb2312?B?MlFpRWhxVzF6MFNQa2szZ2FEZ0srcENYWFEvelZ3cnRwWUFVZjlHbEE3bkUw?=
 =?gb2312?B?dFJzUHRJMUxoQzJudkhkVHR6c0lHaEtTMUl3bjdIbGxxM0VpT2U1WXViaEJJ?=
 =?gb2312?B?WkhMSlMzazVLbDZ5RHU3dno2VzN3SHd1dGJkQzRFSVEzcDFPM1A0dTNEVWJq?=
 =?gb2312?B?L2gySXdCYW4zMjlnaFpWT3Z6ZU04U01qUUorWm5BTGhhTkJNOXI5MktpeXhq?=
 =?gb2312?B?U05lSkluK1ByUysrMDZaY01JOVdOR1ZjQUVJNWFUWlhQUEJqcXNSMXM2Yklu?=
 =?gb2312?B?RTF1ZEdoa0c0QmRrb0dkNUVsN1FneGJQSDZmL3FzYitJeXFaUDZCZ3Q1QjFN?=
 =?gb2312?B?K0pzNTA2c2hSUlcyeXA4bmp5R3Z0d0VWSXk1QnNRS2NOMWw5ZnppQlp0R0V0?=
 =?gb2312?B?MzRCSnFFT1hGaDVKcU9RNzd4dWU2eG9VR21wQ3l3RXRXNkJiMWtiRjFlTFd4?=
 =?gb2312?B?TkZzMXVIMkNxYkRxWWY4c0RRa01rdE1TQkszM2UxYVBuZmtwZ25JSURDSC9y?=
 =?gb2312?B?ZldIOXNuRTZ5Q2I4ZjVUMm9lWDRod0VoNk1ETEdGVUNxK3hldlNCN2JBVDJX?=
 =?gb2312?B?ZmlQaXB0STJENjRCZ0JUa2tYcGx1K3hBNjl4T0Q2Z05oNG51K1EvM2dzVWxr?=
 =?gb2312?B?eE9tcThaSUJLVHZ1SFp5WFpycHUrSDFLSWEwY0ZscGdIYVdMVGhMd09RamF3?=
 =?gb2312?B?SzZIV0FOeG80enZ0S2N3aW5pdmwrc1hvemFTdDdNUTFEVmsyRzJOalQvZ2oz?=
 =?gb2312?B?RUx3R21wdTg2aVZ4SGc1SlFRQnRiSlRlMWI3VUc4UDdSbzRtZHBkT3Z3dFRv?=
 =?gb2312?B?ME5CUEZJeTQrZXo0NXhLemJPbWxIKzI2bmJCMkJZc2NTQ3ltaGlTZjN2TFAr?=
 =?gb2312?B?TGRtZ3Jhb0FRQTJaUzFaNW9JQzJseHVGRDJkcFRCT1F0VzRkdDcrbjFPV2w0?=
 =?gb2312?B?NnBrNXRqLzdDWlFhZlN6S08xQnp1U2FjNTBXUkx5ekYxVS9GajhsWjQvTnNw?=
 =?gb2312?B?ZU5rbkk5NmdGNGRiSU0rNzQwN2wxSVQrWmJ3czMxcXlEdWdRQyttZmx4WUhz?=
 =?gb2312?B?VHdITUZxK0xKbVllMnVWMXp0UURNVTBJM2pOc2tyTVE4NHQ3Y0lFeVFXWXZp?=
 =?gb2312?B?UTNHNDI3RDhuVXZrY0NRcU43a0pyV0U0N2NVaDM2UVBKK2RDQWhTZTNzREg3?=
 =?gb2312?B?dW14Q0hjZVVoNlQrVkN4UmorVi96RFBma25vWW13NC92WTI0dEFwYWd0WXht?=
 =?gb2312?B?dkRmUVJpMWl2cVhNVmYyWkdkL21HbzNVejlaaDVSQXBRNWRTZndXWHpnUWxz?=
 =?gb2312?B?S2F0ZXY1bkNVRExhcEhQaU1oUk0wbDR2VitFYVlzN2EwMm4vRzZmYzhpcWdp?=
 =?gb2312?B?Q1Rmelg5SVVXVWNJb0RuUlRMaFZROHozK2J4MHFZQStBQSs0RXhkL1QreG1k?=
 =?gb2312?B?aXlSOGw1YnFqdzlHQ0R3QzB2VjdTd1JZMGViMUFna0U3WVJvTU1WN2xkSVk0?=
 =?gb2312?B?VjhSZWw2SkplUk5WWXg0T2V6dEM0N09qeFo4Q1dDQ1IweHJIL25wam5SU0hS?=
 =?gb2312?B?SGRJNnhXMWp6Y0ZDdG43MitKZk5VVlBOYWZGTStoQ1ZmNXB1Mi8waDUwSVFR?=
 =?gb2312?B?ZUdjYWxJbG5FaCsxMWFXZVh3LzZqRmhzeWxvNm05Z3J0ZjR4YUozRFdLSTF5?=
 =?gb2312?B?NHVINFB4UUFVWnh4aEVicCt5bnNaeHBOc0tWU0RUWW5TRmRtcEdMVURRbm00?=
 =?gb2312?B?a2tPZ3ljNExoSG1mWDBMT2RqWUVjS1VFUlJhOGhRTzRLN2dkZ21senpKdjRK?=
 =?gb2312?B?QjNHVjhhMFBTVkV2SDBLTm53Nk5QYTdJaVlPVzhFQUhzSnJwZkQzSUJxL2VP?=
 =?gb2312?B?OFBEcFZUek81THN1YWFYdTVhZlg5ZUxzak5uUXcyempPV3RuTVR3S3RjMW82?=
 =?gb2312?Q?Fsmc=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 609b5f6b-dc5f-4d11-5712-08db1a00bd24
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2023 02:57:47.8029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lfKo2KXKqQ/hWqRXKjmGEgdgByabMHSBbOCwIqfhbf9jLlq4d3S335YluJK+yONlj47q2kBhZy5ic/2n4fWxFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7539
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEguIE5pa29sYXVzIFNjaGFs
bGVyIDxobnNAZ29sZGVsaWNvLmNvbT4NCj4gU2VudDogMjAyM8TqMtTCMjjI1SAxNjo0NA0KPiBU
bzogSG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT47IEx1Y2FzIFN0YWNoDQo+IDxs
LnN0YWNoQHBlbmd1dHJvbml4LmRlPjsgTG9yZW56byBQaWVyYWxpc2kgPGxwaWVyYWxpc2lAa2Vy
bmVsLm9yZz47IEtyenlzenRvZg0KPiBXaWxjenmovXNraSA8a3dAbGludXguY29tPjsgQmpvcm4g
SGVsZ2FhcyA8YmhlbGdhYXNAZ29vZ2xlLmNvbT47IFNoYXduDQo+IEd1byA8c2hhd25ndW9Aa2Vy
bmVsLm9yZz47IFNhc2NoYSBIYXVlciA8cy5oYXVlckBwZW5ndXRyb25peC5kZT4NCj4gQ2M6IFJv
YiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+OyBQZW5ndXRyb25peCBLZXJuZWwgVGVhbQ0KPiA8
a2VybmVsQHBlbmd1dHJvbml4LmRlPjsgRmFiaW8gRXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29t
PjsgZGwtbGludXgtaW14DQo+IDxsaW51eC1pbXhAbnhwLmNvbT47IGxpbnV4LXBjaUB2Z2VyLmtl
cm5lbC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gbGV0dXgta2VybmVsQG9wZW5waG9lbnV4Lm9yZzsg
a2VybmVsQHB5cmEtaGFuZGhlbGQuY29tOyBILiBOaWtvbGF1cw0KPiBTY2hhbGxlciA8aG5zQGdv
bGRlbGljby5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSF0gUENJOiBpbXg2OiBpbnN0YWxsIHRoZSBm
YXVsdCBoYW5kbGVyIG9ubHkgaWYgd2UgYXJlIHJlYWxseSBydW5uaW5nDQo+IG9uIGEgY29tcGF0
aWJsZSBkZXZpY2UNCj4gDQo+IGNvbW1pdCBiYjM4OTE5ZWM1NmUgKCJQQ0k6IGlteDY6IEFkZCBz
dXBwb3J0IGZvciBpLk1YNiBQQ0llIGNvbnRyb2xsZXIiKQ0KPiBhZGRlZCBhIGZhdWx0IGhvb2sg
dG8gdGhpcyBkcml2ZXIgaW4gdGhlIHByb2JlIGZ1bmN0aW9uLiBTbyBpdCB3YXMgb25seSBpbnN0
YWxsZWQgaWYNCj4gbmVlZGVkLg0KPiANCj4gY29tbWl0IGJkZTRhNWEwMGU3NiAoIlBDSTogaW14
NjogQWxsb3cgcHJvYmUgZGVmZXJyYWwgYnkgcmVzZXQgR1BJTyIpIG1vdmVkDQo+IGl0IGZyb20g
cHJvYmUgdG8gZHJpdmVyIGluaXQgd2hpY2ggaW5zdGFsbHMgdGhlIGhvb2sgdW5jb25kaXRpb25h
bGx5IGFzIHNvb24gYXMgdGhlDQo+IGRyaXZlciBpcyBjb21waWxlZCBpbnRvIGEga2VybmVsLg0K
PiANCj4gV2hlbiB0aGlzIGRyaXZlciBpcyBjb21waWxlZCBhcyBhIG1vZHVsZSwgdGhlIGhvb2sg
aXMgbm90IHJlZ2lzdGVyZWQgdW50aWwgYWZ0ZXINCj4gdGhlIGRyaXZlciBoYXMgYmVlbiBtYXRj
aGVkIHdpdGggYSAuY29tcGF0aWJsZSBhbmQgbG9hZGVkLg0KPiANCj4gY29tbWl0IDQxNWI2MTg1
YzU0MSAoIlBDSTogaW14NjogRml4IGNvbmZpZyByZWFkIHRpbWVvdXQgaGFuZGxpbmciKSBleHRl
bmRlZA0KPiB0aGUgZmF1bHQgaGFuZGxpbmcgY29kZS4NCj4gDQo+IGNvbW1pdCAyZDhlZDQ2MWRi
YzkgKCJQQ0k6IGlteDY6IEFkZCBzdXBwb3J0IGZvciBpLk1YOE1RIikgYWRkZWQgc29tZQ0KPiBw
cm90ZWN0aW9uIGZvciBub24tQVJNIGFyY2hpdGVjdHVyZXMsIGJ1dCB0aGlzIGRvZXMgbm90IHBy
b3RlY3Qgbm9uLWkuTVggQVJNDQo+IGFyY2hpdGVjdHVyZXMuDQo+IA0KPiBTaW5jZSBmYXVsdCBo
YW5kbGVycyBjYW4gYmUgdHJpZ2dlcmVkIG9uIGFueSBhcmNoaXRlY3R1cmUgZm9yIGRpZmZlcmVu
dCByZWFzb25zLA0KPiB0aGVyZSBpcyBubyBndWFyYW50ZWUgdGhhdCB0aGV5IHdpbGwgYmUgdHJp
Z2dlcmVkIG9ubHkgZm9yIHRoZSBhc3N1bWVkIHNpdHVhdGlvbiwNCj4gbGVhZGluZyB0byBpbXBy
b3BlciBlcnJvciBoYW5kbGluZyAoaS5NWDYtc3BlY2lmaWMNCj4gaW14NnFfcGNpZV9hYm9ydF9o
YW5kbGVyKSBvbiBmb3JlaWduIHN5c3RlbXMuDQo+IA0KPiBJIGhhZCBzZWVuIHN0cmFuZ2UgTDMg
aW1wcmVjaXNlIGV4dGVybmFsIGFib3J0IG1lc3NhZ2VzIHNldmVyYWwgdGltZXMgb24NCj4gT01B
UDQgYW5kIE9NQVA1IGRldmljZXMgYW5kIGNvdWxkbid0IG1ha2Ugc2Vuc2Ugb2YgdGhlbSB1bnRp
bCBJIHJlYWxpemVkDQo+IHRoZXkgd2VyZSByZWxhdGVkIHRvIHRoaXMgdW51c2VkIGlteDZxIGRy
aXZlciBiZWNhdXNlIEkgaGFkDQo+IENPTkZJR19QQ0lfSU1YNj15Lg0KPiANCj4gTm90ZSB0aGF0
IENPTkZJR19QQ0lfSU1YNj15IGlzIHVzZWZ1bCBmb3Iga2VybmVsIGJpbmFyaWVzIHRoYXQgYXJl
IGRlc2lnbmVkIHRvDQo+IHJ1biBvbiBkaWZmZXJlbnQgQVJNIFNvQyBhbmQgYmUgZGlmZmVyZW50
aWF0ZWQgb25seSBieSBkZXZpY2UgdHJlZSBiaW5hcmllcy4gU28NCj4gdHVybmluZyBvZmYgQ09O
RklHX1BDSV9JTVg2IGlzIG5vdCBhIHNvbHV0aW9uLg0KPiANCj4gVGhlcmVmb3JlIHdlIGNoZWNr
IHRoZSBjb21wYXRpYmxlIGluIHRoZSBpbml0IGZ1bmN0aW9uIGJlZm9yZSByZWdpc3RlcmluZyB0
aGUNCj4gZmF1bHQgaGFuZGxlci4NCj4gDQo+IEZpeGVzOiBiZGU0YTVhMDBlNzYgKCJQQ0k6IGlt
eDY6IEFsbG93IHByb2JlIGRlZmVycmFsIGJ5IHJlc2V0IEdQSU8iKQ0KPiBGaXhlczogNDE1YjYx
ODVjNTQxICgiUENJOiBpbXg2OiBGaXggY29uZmlnIHJlYWQgdGltZW91dCBoYW5kbGluZyIpDQo+
IEZpeGVzOiAyZDhlZDQ2MWRiYzkgKCJQQ0k6IGlteDY6IEFkZCBzdXBwb3J0IGZvciBpLk1YOE1R
IikNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEguIE5pa29sYXVzIFNjaGFsbGVyIDxobnNAZ29sZGVs
aWNvLmNvbT4NCkhpIEguTmlrb2xhdXM6DQpJJ20gZmluZSB3aXRoIHRoZXNlIGNoYW5nZXMuIFRo
YW5rcy4NClJldmlld2VkLWJ5OiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQoN
CkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCj4gLS0tDQo+ICBkcml2ZXJzL3BjaS9jb250cm9s
bGVyL2R3Yy9wY2ktaW14Ni5jIHwgOSArKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA5IGlu
c2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3
Yy9wY2ktaW14Ni5jDQo+IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0K
PiBpbmRleCAxZGRlNWM1NzllZGM4Li44OTc3NGFhMTg3YWU4IDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ICsrKyBiL2RyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gQEAgLTE0MDIsNiArMTQwMiwxNSBAQA0KPiBERUNM
QVJFX1BDSV9GSVhVUF9DTEFTU19IRUFERVIoUENJX1ZFTkRPUl9JRF9TWU5PUFNZUywgMHhhYmNk
LA0KPiBzdGF0aWMgaW50IF9faW5pdCBpbXg2X3BjaWVfaW5pdCh2b2lkKSAgeyAgI2lmZGVmIENP
TkZJR19BUk0NCj4gKwljb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkICpyZWJvb3RfaWQ7DQo+ICsJ
c3RydWN0IGRldmljZV9ub2RlICpucDsNCj4gKw0KPiArCW5wID0gb2ZfZmluZF9tYXRjaGluZ19u
b2RlX2FuZF9tYXRjaChOVUxMLCBpbXg2X3BjaWVfb2ZfbWF0Y2gsDQo+ICsJCQkJCSAgICAgJnJl
Ym9vdF9pZCk7DQo+ICsJaWYgKCFucCkNCj4gKwkJcmV0dXJuIC1FTk9ERVY7DQo+ICsJb2Zfbm9k
ZV9wdXQobnApOw0KPiArDQo+ICAJLyoNCj4gIAkgKiBTaW5jZSBwcm9iZSgpIGNhbiBiZSBkZWZl
cnJlZCB3ZSBuZWVkIHRvIG1ha2Ugc3VyZSB0aGF0DQo+ICAJICogaG9va19mYXVsdF9jb2RlIGlz
IG5vdCBjYWxsZWQgYWZ0ZXIgX19pbml0IG1lbW9yeSBpcyBmcmVlZA0KPiAtLQ0KPiAyLjM4LjEN
Cg0K
