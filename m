Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB195A72D9
	for <lists+linux-pci@lfdr.de>; Wed, 31 Aug 2022 02:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbiHaAmV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Aug 2022 20:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbiHaAmC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Aug 2022 20:42:02 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2061e.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1a::61e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6050A4E601;
        Tue, 30 Aug 2022 17:40:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TcWeQsXFXz/hMIjS+YdKcW0XC3gq0Lix5tUL5xIFUnYKgu26bRBC10PvQapSweGWUNdwFA6derGoHGHu1DvSnyMBG4wyM7yWp2ByxQzhMwHRUTEGOgG31yt6yEE4A98n8i19XohWpsWP+FDrV7M06M+Obsiekeij6iZGgENcLQxKLBPpGlbeGQ7XxhJIv3F74CaLJJJFZOBAe5ZQSncvZp7uunKCXXhFBfZnbI9xeHW1gqK73TQ6Ph8OgiW80cvFw93Hq7SwCxsJxyzeRs0miDfjE5LE1zB9pNrdfSUVksu6Miw4bASZ9xEq4ciHxz3gGkY3dU+m9GEyY8pOb8Rt1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7fn8gNR4BA/nYx2InQ9HjzX0HeWKBOED+aE03xP0VGk=;
 b=eC9hdCESpUZB9nL3slGDLfRSQB9HpZ5iVmbMm4vvvlEw08+hIa+fwbxnpVLl/AX9+ORicpGwaN4Y299Tffb911W1hjjSzh3jFHaftqqS0a+lDLMpCpX9U963c75z/D7dpZ0Pbvtzlrli8silRNC7n1O76O9/IYDC00yOiyLEy2GmSVNxeeR1OMHqCWuqoT6u3eXsEjYtESpXlJFKyq6P5vlSAZB5ukwPWRXYH2biKjzAhqgXJ7/WiTxdmtV9OH1dOHEiwBJ4TeJ6HqlCpYbYWlBeq43+ZazOmwjEsVuMWcLiG9Gx//4LT50zrJ8S+aeybEmhKq5FIDMPVCp0MNShTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7fn8gNR4BA/nYx2InQ9HjzX0HeWKBOED+aE03xP0VGk=;
 b=neiLCSL1j7XsGv2d3BmForXrfoVIYz38yNVjP/hP7Up4j5BtrYwstfuoxH1feuyriYLiVBYtTvS3us40FCMca1cqBkeLEz/kRnikf+xBUnyZFWyYJwadA7iatuw88ta11MahWuySB6hSAXBhtrWGuY9urjxIqmxMVfYcU0q6WqU=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM5PR0401MB2561.eurprd04.prod.outlook.com (2603:10a6:203:37::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 00:38:51 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::13c:5622:af8a:b2da]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::13c:5622:af8a:b2da%9]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 00:38:51 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
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
Subject: RE: [PATCH v5 4/7] reset: imx7: Fix the iMX8MP PCIe PHY PERST support
Thread-Topic: [PATCH v5 4/7] reset: imx7: Fix the iMX8MP PCIe PHY PERST
 support
Thread-Index: AQHYvEcKShZAmDWvjEuC5sg/e29IK63Hp4eAgACDzOA=
Date:   Wed, 31 Aug 2022 00:38:51 +0000
Message-ID: <AS8PR04MB8676D51422818DEB4D8BB1A08C789@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1661845564-11373-1-git-send-email-hongxing.zhu@nxp.com>
         <1661845564-11373-5-git-send-email-hongxing.zhu@nxp.com>
 <569a5d63af850d4180546c2c25220cbb988846eb.camel@pengutronix.de>
In-Reply-To: <569a5d63af850d4180546c2c25220cbb988846eb.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c17bacf-c9da-40d7-5d20-08da8ae92d0c
x-ms-traffictypediagnostic: AM5PR0401MB2561:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pzDA7eB4nVAMsHrrGPFigD9PSsG7PAT2ol85AuGv1Fyv06WmNNvq0mDyyZEa12BZNsSLKAnTgCv1hKJ9Af0/fipRQ+CD7mV5pJBSvPKLKt0Y9SvAdZ4mBSYU8HXBc6MGRRQH0KDWR2RPI9azmtX+zcjzt6GbcTlUcC3poZc6tknjc5QDfqSdrj14o+5y6XzTgMA+4cdJvM+BjTX5sB7Ad7gk/OP59Us845y6C7bABfNQMyP8J+Psz2ESw9BTpbpAAtQDt7joAisDrhPX/kpTzOJN758QAx8DETrQ2qAqlDbJGjM+UrIt1edX+dtC4CyK28YqguBPOhNcMqnLUzkuy+vyGOGoA1qbsm/9XAmLe1JSVJPEhq5ycepjoQGhb/CmUa+IyTTQFheDbne26qgL3lpLcoxA07+lFE/fCwKhE5Z/Ep97FUBzNwZgwpNHfNt4XcoeZJjo7y0daSWZwdFh1GR2NCNQsTlsNHw+oGgIJkC8FFBj0OwiNLXPVXtwOJsrU4Fg2DWsZlDeKlEJr8GAdQmBQpmgM4ni9+ilvNjiPJC4jRoB25yJOqXbb1HnWAeqSDI7BkcIUKSpY1n4JeI+XCf3nf0g4F+RrF7PvqLhTGZ40xCdiuoRJXULc1+UzaNfZOqU5ds8o1Nk0nYTd3TuXU5rqQHuLMBaZ7CUA0jJlNGC+i1co6iYQrMKChvyDAotBvfwGpBUP+onhR/bJzRsVlF711ozDiVeThjCcBpGOrP7UHFgC3k7F9SZxI9qPRSsiD6BScBFdrdg3SvARLj6aY+OMs5cRm0hzzP9TKWcwHLfhv1QCwyRx10jLYTVCvXZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(39860400002)(136003)(376002)(346002)(53546011)(122000001)(41300700001)(38100700002)(6506007)(7696005)(83380400001)(2906002)(86362001)(44832011)(33656002)(52536014)(8936002)(26005)(9686003)(7416002)(5660300002)(55016003)(66946007)(66556008)(66446008)(64756008)(8676002)(76116006)(66476007)(4326008)(478600001)(71200400001)(186003)(921005)(110136005)(54906003)(38070700005)(316002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RkE4Q1ZRNk1QQjhrYWVqcE85TjJpWlI2VTFDYVh3cW1NT3pBUlZldTYweXJz?=
 =?utf-8?B?RGtidlhOOWt3ZDF5c1I2TlNhQ1lTOHZXQ3FpMVZZeXBJMzgvUjlxSi8xc000?=
 =?utf-8?B?bVBSbjdRZE1XNWttMWM1YzZLcXlQTTROWXl1VVRCUnlmb3AyZ29TMEhtRTA1?=
 =?utf-8?B?bTAxbzRyQ01Vbzg5Vjc5a0lPMGpraVZlQTJLQkgyVHN5MGUvR2Q1Z2djanB2?=
 =?utf-8?B?TGQ1a290TEJEZnhvUnhzY3pwTVNnTjdVZ0g2TWdBSXFlbm9Wdm9KTDJlUTJw?=
 =?utf-8?B?a1d5bWsxSTV5M2tBQnlmajAvajg3MFZrV0xGYmxkOFBYQkhZUlZWNzZibXZZ?=
 =?utf-8?B?NmVBYnBveDVJN1FubkpUK3dTcURlRllLS0Q4RzJqVy9aWmNDbC9Jc2ZmRXha?=
 =?utf-8?B?SHY4Tjd0dXYybEFaVkpkVmRjYklxWHBwTFd3dktzSW1Uamp2bHBmTElyUk8y?=
 =?utf-8?B?TzJoZXZTMERSRlJaOE9DUG40SEkvSzJ5QUtISE1mSHl5WExRcXZOV1hEVDNm?=
 =?utf-8?B?UjlybGkwRVJCL3JKK3B0ZXlaNWFkM2ZhVElFalNXWjJUMGNoL0hLSno3SkRW?=
 =?utf-8?B?V3pYdHgvRk1xTE0rNkNtL2xraDN1c2dTWHdIMTRoUE0zVnNpOVQram1JL29s?=
 =?utf-8?B?ZkR3MkJ3VUFhYjNzYmp5UldvK2xqUEVRVzBRMGRkYU9RY3VIQ1Y5RWtzZlVV?=
 =?utf-8?B?c1hybS9keUt6WXF1cFRRTHZBZlFteE5LZUUrMmhkUmpSK1JNRDIxYXEvTGEx?=
 =?utf-8?B?Tm4rNHB2MXlScXFtS3RoTXNHdGdjRjFFV1ZWdVV2NnRzckxVU2RIT25VbWNG?=
 =?utf-8?B?cFZvNDJxS2ZhK1pTSW5kS2NFYWV6TFZUNXMxWmRJcVlQSWVKeWw1d3ZSQlZi?=
 =?utf-8?B?UFB1aVJFOTdiODQxdkduWm53dVBaQ01KNCtsYy9hSUZ3dnZ2KzRLSEp4WjBs?=
 =?utf-8?B?Rjc2Mjd6T0NRTjhOUUxMNW5POGxkNlNDZlU4cVFCSVdJdlMyTW5YRnI4U3Fh?=
 =?utf-8?B?TyttaTZXMDNnRXdTY0hNQ2xSczA5SUk3YUIvbWwwSUMvRWVlNHA1eEQ5SFR1?=
 =?utf-8?B?aWdnMjFHNENLYnBrQUsxdHBXTDY1MnBpUDdSN3A0eHU3VzY1QVgrbUpCNWRR?=
 =?utf-8?B?OUY3cGo0YXNKbGpZaWJMSlk0TTJocURhUE5YSThGWHovNlhOckVLQTI2cENW?=
 =?utf-8?B?endYa1VIM2haSkxidVRTVjZicXd2bk9haWlWdVJ2RXpHQm5wdnJtSTd0NERs?=
 =?utf-8?B?TEpyRzFZSUMvMm5LRjZtTTRscEpPeDk5WVFldU9STGJYWTVySEl6ZWwzRFR0?=
 =?utf-8?B?Y2hMMUU1WkpQRGkrbFlXeEhmNmlPTDRRbGpVTUltNjVBdmRpL0JYV2FlOFp1?=
 =?utf-8?B?N0pwb3VRYk5MMnlheTRXUUVPanRKRFlXbjBFYm1UaVlwcG5neWQ5V1B3TG0y?=
 =?utf-8?B?N3pGV3RnVWNwdUtMdWJ2cUpRc29rQ05iMmtaNWVya1k0SGFRZmp5TTNISTF1?=
 =?utf-8?B?Yk5ndmpEYVBzdHNnQndXVWRUTnhCS3JNdFVaN2hTcUZHckxtY0U4ZzRmY2l3?=
 =?utf-8?B?Z3Z6NTdmNTM3UEVyZ0RiUEhVZEg5UHhmZmVibkFzamc1SXNmcXFUS3VGcmVK?=
 =?utf-8?B?WnRlWmxlV01jY1grTWJNbzJwTzEzL1hVRFRrUTBkWmI0U3RDd2RxZ1RET21R?=
 =?utf-8?B?dldCbHZyUWtpcm12ZGlWK3luOXhBSHhEV1J3NXVia3JJWERBdWpXMTlQeEwz?=
 =?utf-8?B?cDJ5NmxvRVFGbXJDdGYxSElBdDRTb2M2M2R3TER5a3AxSTBQdkJxRUUyTGgv?=
 =?utf-8?B?bGdQTk1lcUN6VFJ0MmkrSWRkdE5rMEFvbUQyNkxvb09ORHYwVEtaY2dNVHhx?=
 =?utf-8?B?R3JBVkRaMDVJck1VS05uYXdZS0s1K1FvWU1OY3BWa2RWWm5Fb0hyZmlNV1FD?=
 =?utf-8?B?VVA5Z1ZHSFRKMFIzcWxpODVMcWpyY1J6MmRYNWlveGV0RVBVVTllQVFQbUpJ?=
 =?utf-8?B?anJQcldTTVhEZTc4RFdNRlpJcjdwRXRNRURpTHFrNDVSQk4xM0lpb2lxRWZk?=
 =?utf-8?B?WGZvNkZhRzhVeXJiN0xPSnlIYWZ1VTYvU3M3aW5NdGg3ME1wSXJXK0l0NlE4?=
 =?utf-8?Q?qTlhCXfpLNBXRoMOYyFR/XW11?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c17bacf-c9da-40d7-5d20-08da8ae92d0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 00:38:51.3520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0r2+jYZR90dUuXPxh/nWTYWpZSocA6jKnqZICDdWSlPm/s7i0RxF72ruY4jRXvZm5TEbRR0Bh3NpCCVLJJS4QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2561
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQaGlsaXBwIFphYmVsIDxwLnph
YmVsQHBlbmd1dHJvbml4LmRlPg0KPiBTZW50OiAyMDIy5bm0OOaciDMx5pelIDA6NDYNCj4gVG86
IEhvbmd4aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+OyBsLnN0YWNoQHBlbmd1dHJvbml4
LmRlOw0KPiBiaGVsZ2Fhc0Bnb29nbGUuY29tOyBsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tOyBy
b2JoQGtlcm5lbC5vcmc7DQo+IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHZrb3VsQGtlcm5lbC5vcmc7
IGFsZXhhbmRlci5zdGVpbkBldy50cS1ncm91cC5jb207DQo+IG1hcmV4QGRlbnguZGU7IHJpY2hh
cmQubGVpdG5lckBsaW51eC5kZXYNCj4gQ2M6IGxpbnV4LXBoeUBsaXN0cy5pbmZyYWRlYWQub3Jn
OyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgtcGNpQHZnZXIua2VybmVsLm9y
ZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGRsLWxpbnV4LWlteA0KPiA8
bGludXgtaW14QG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgNC83XSByZXNldDog
aW14NzogRml4IHRoZSBpTVg4TVAgUENJZSBQSFkgUEVSU1QNCj4gc3VwcG9ydA0KPiANCj4gSGks
DQo+IA0KPiBPbiBEaSwgMjAyMi0wOC0zMCBhdCAxNTo0NiArMDgwMCwgUmljaGFyZCBaaHUgd3Jv
dGU6DQo+ID4gT24gaS5NWDcvaU1YOE1NL2lNWDhNUSwgdGhlIGluaXRpYWxpemVkIGRlZmF1bHQg
dmFsdWUgb2YgUEVSU1QNCj4gPiBiaXQoQklUMykgb2YgU1JDX1BDSUVQSFlfUkNSIGlzIDFiJzEu
DQo+ID4gQnV0IGkuTVg4TVAgaGFzIG9uZSBpbnZlcnNlZCBkZWZhdWx0IHZhbHVlIDFiJzAgb2Yg
UEVSU1QgYml0Lg0KPiA+DQo+ID4gQW5kIHRoZSBQRVJTVCBiaXQgc2hvdWxkIGJlIGtlcHQgMWIn
MSBhZnRlciBwb3dlciBhbmQgY2xvY2tzIGFyZSBzdGFibGUuDQo+ID4gU28gZml4IHRoZSBpLk1Y
OE1QIFBDSWUgUEhZIFBFUlNUIHN1cHBvcnQgaGVyZS4NCj4gPg0KPiA+IEZpeGVzOiBlMDg2NzJj
MDM5ODEgKCJyZXNldDogaW14NzogQWRkIHN1cHBvcnQgZm9yIGkuTVg4TVAgU29DIikNCj4gPiBT
aWduZWQtb2ZmLWJ5OiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+ID4gUmV2
aWV3ZWQtYnk6IFBoaWxpcHAgWmFiZWwgPHAuemFiZWxAcGVuZ3V0cm9uaXguZGU+DQo+ID4gVGVz
dGVkLWJ5OiBNYXJlayBWYXN1dCA8bWFyZXhAZGVueC5kZT4NCj4gPiBUZXN0ZWQtYnk6IFJpY2hh
cmQgTGVpdG5lciA8cmljaGFyZC5sZWl0bmVyQHNraWRhdGEuY29tPg0KPiA+IFRlc3RlZC1ieTog
QWxleGFuZGVyIFN0ZWluIDxhbGV4YW5kZXIuc3RlaW5AZXcudHEtZ3JvdXAuY29tPg0KPiANCj4g
SSd2ZSBhcHBsaWVkIHRoaXMgcGF0Y2ggdG8gdGhlIHJlc2V0L2ZpeGVzIGJyYW5jaC4NCj4gDQoN
ClRoYW5rcyBhIGxvdC4NCg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0KDQo+IHJlZ2FyZHMN
Cj4gUGhpbGlwcA0K
