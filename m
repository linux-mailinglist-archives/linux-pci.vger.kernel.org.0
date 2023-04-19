Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E2D6E7FF7
	for <lists+linux-pci@lfdr.de>; Wed, 19 Apr 2023 19:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbjDSRA2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Apr 2023 13:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjDSRA1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Apr 2023 13:00:27 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2088.outbound.protection.outlook.com [40.107.105.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D485C6E85;
        Wed, 19 Apr 2023 10:00:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YciTBWSx2SHpbIr5JzO5W73bPNPNS69LLwNM56ykbm2zBmH1bf1cLvxcipjWNmpGteUn/RL9KEWyJd52DjnfvGt/R27ctJbkOXYk9WMUZmw9HCgiRrSvy9/rqDoT5airxY4nZ7DH7ttEz/sjkCi41JCMDxTreZAspCqX6qaP0lm4Kk5TJ/zyourVLRS7fvuFPGWvfamEnD/r5CwiAA62Tu37cwFv+5j/Mx4iULKLLKv1T6Vt7w0DEw2SZA8Ol1IoZ0vp7ujyKvFkQ54I8onLeRsN3u8uU+BTedRYfZZvDS4ZUE7eTc+sK+rO/X8O2MHZyg1BBplFA/q02bjIgr1WXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PNcZZjQDcdAxgGK9W6b7pD/tlBt19yBAg+qk1pNrOJU=;
 b=QmwFVqq2WWRpeZx3L7NGMoALwp0Yf29oKx4CFx5A7DD+tsrChF/ZD1V5fW3xPK7A0aoasRYvF8u3jlJJ7CgJVJXl3qkyvlk9dzETBlnZ8lF9T7JIP3O3z4eMZsMxQOHhX9+X0QajxS44bsZTap1tZZ2P0qeL2qw5IfoLynODGuFB0TCDT1XEyTrhixenj8AtJwsXOq/T8cqxyF5oBnHc311hNA8ysrj+sVcI1/2p0audqLmuQiK6jiUlQdb/TwnnwIeUgZw6oKGE9GtChB+xelIH7/Dcebv1q5nzy/7N7ONz/3qHbq+UvvE49uYqV9rdN6p78G+n34Rtzf/ni82qwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PNcZZjQDcdAxgGK9W6b7pD/tlBt19yBAg+qk1pNrOJU=;
 b=BPBGfGXFyxy4TwebZWg8+v8iQbjqidj4Yrb8t9xdvS6wsDLtvoEL0iDzlHlE7wl6hLVyz4iwG3OiCcE56NU2hv6uiFgvD4MG+IP4VeQWvc30RNQBxFK5NDl/ZZwfudKkaJFtpUx5DPbJ77Ip9Fw+d0X8NPwAxyXfqsBi2d0ZqB8=
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM9PR04MB8907.eurprd04.prod.outlook.com (2603:10a6:20b:40a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.21; Wed, 19 Apr
 2023 17:00:23 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::f1d6:f05f:b8c6:4353]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::f1d6:f05f:b8c6:4353%6]) with mapi id 15.20.6319.021; Wed, 19 Apr 2023
 17:00:23 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Manivannan Sadhasivam <mani@kernel.org>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>
CC:     "allenbh@gmail.com" <allenbh@gmail.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "jdmason@kudzu.us" <jdmason@kudzu.us>,
        "kw@linux.com" <kw@linux.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "ntb@lists.linux.dev" <ntb@lists.linux.dev>
Subject: RE: [EXT] Re: [PATCH 1/1] PCI: endpoint: pci-epf-vntb: fix typo span
 in comments
Thread-Topic: [EXT] Re: [PATCH 1/1] PCI: endpoint: pci-epf-vntb: fix typo span
 in comments
Thread-Index: AQHZD+C/PN18RSdcf02dRof7zAQM1K8h24EAgBHFQkA=
Date:   Wed, 19 Apr 2023 17:00:23 +0000
Message-ID: <AM6PR04MB48382B6FDA347EE8A0E65F7B88629@AM6PR04MB4838.eurprd04.prod.outlook.com>
References: <20221214172254.668282-1-Frank.Li@nxp.com>
 <20230408093644.GG11124@thinkpad>
In-Reply-To: <20230408093644.GG11124@thinkpad>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB4838:EE_|AM9PR04MB8907:EE_
x-ms-office365-filtering-correlation-id: 0383dc2b-fc42-4693-06bc-08db40f790da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eY+8GyB4aEoSUnKlIIa/cwPuchRrdGQrbpFCVomK2V5FYbX/Sa02StsY9tx/M+GLLEm63p7S3lYAeNGu6J0iZG4bwu1ed87/UZQxg7oR1FcxnDq9e/DoI7iiTWtrDgqmmCFbq+SZ8EeJOu2CmrpKZqjO87ST9ny8ximXL/KkhghP5BtW1app3hRAwQCZBOXoPjXsa/yiOnuRqVkv2KfGbvdL0Px2swXUqzFznVP12MYr/RhlUeZikTV/LL3Bh0kgZW09NZtwHiAwu8x/Rrdk3vHx5uPcL88DM9G8RmpGd+yMlfYUHdK5Law0HxaVxunf8KhMaELHJU3w6K4imlHlfdcmbi5EgvInwREHNMynq4KNq9WUHxQgXBF0lUNlLbyORn2jT0rgLkqT4I7fdbahYSL6RchTSGOeSQaAF+Woo1IDIclV73R3/tZHkOqGhzem7UjMMQJ8lilxFva4nsJA+bZKUvlppC7q/ZE22pDZfxZpDvCzseydilkmBdqCY4xFZzO2u4LxIO2rKzeWPNMDmsPMdLqZ76FCDc1u3Vwsd0/KptWDM7/AHaO60tbofXHd5LwzSVlFeqoESgV60iNAZ31vqQLxs3B4Xg9thVL5urrOTeKoLWemCsZvVgmZfI/P
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199021)(66946007)(76116006)(66476007)(7696005)(110136005)(83380400001)(4326008)(66446008)(71200400001)(52536014)(5660300002)(64756008)(7416002)(2906002)(316002)(66556008)(186003)(122000001)(41300700001)(86362001)(54906003)(33656002)(38100700002)(8936002)(8676002)(6506007)(9686003)(26005)(55236004)(38070700005)(478600001)(55016003)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWRNcHJsS1lwTytFWlhaajh4enF3SEZRbW5wa1lqZEpZaVp6S1I5L2U1c0dn?=
 =?utf-8?B?Nk85ZUYxV1RRK0NiOTduMU1obEhkaXJVRllTaEtQUlVBU3AyajhiTFBtUkVx?=
 =?utf-8?B?amZPNDVFc2JhNzBCeXdGeWZ3Y2EvWEltbVE0aGNobEM0dnlxdVhZRGIrS0hQ?=
 =?utf-8?B?WjlhejhMclo3TjAzemtkMFpkcFZldEFyKzI2TFc4WFhzZXZETTFid3lvS0NJ?=
 =?utf-8?B?M2VGakthK1psSUlZSDlhTjZHNmdiRG1UWXhFeThJNzI3L1AxUWh4ZFo3aElS?=
 =?utf-8?B?bEluNmgzRDd0c3VZVWFlQXlQNFBVMVhsek4xVld2emd4UTd2MzR5TDAxd2Rm?=
 =?utf-8?B?cnBEbGZuckhhQ3JwMjM2UHNxWVVPbmYrOE5xYVUrZXg1bXY3a1N3SXJQV0ZU?=
 =?utf-8?B?bGRNY2wwUEVPWG0vQ0x4bys4WHluVkIxMUhSbTRyNkxwMnVlSjJGaFRVbUxK?=
 =?utf-8?B?L1VTa0U1U0doeTFiNjFQMVlHZFRRZEt2ZHpFWEFteVNXbTlvZHgzWFIxNUJL?=
 =?utf-8?B?a01xY2RvcHJBTEhNQlNIeHllV3dscDFpWGlLa2ZtL3A1STdIRHgzVXh4NHFn?=
 =?utf-8?B?M0J4cVF2SXJ2TVFEUVJnTzhEeFU1aHFYYUJWa2ZkSUYzbjhzbzVHeXM2cHRJ?=
 =?utf-8?B?cDUwMmQrMUovNnBIUGRUODBVZGV5cnBuY2Ftd3dlNWZIcmc0MVo1b04rSWV4?=
 =?utf-8?B?QW9aek9JaWFaOXMxalJraS9zMmUxNUtoalVPSG8zSTF2OWp6ZklReitVWFRW?=
 =?utf-8?B?TkxTaklzcTdoN1F0MUl6NHpnN3JLbklpZnN2d2FDUTdqSjBkT2ttTlQ2bjd0?=
 =?utf-8?B?WDRlVGxlWmRwVWoyeFAveVlxdzdQeUZlU0c2RFRyUFBIUEVIcTdUcnNRUmlX?=
 =?utf-8?B?UGRaOUNwczZ4UG1Kd0NFbEo1U2UrMFhPeVg1TC9TRFFvbGJaTFJ5NC9JK05m?=
 =?utf-8?B?cHlubWVOY2N4OGFFWTQydy9kVUJxellWRmttblR0a1k3NGVsUUQ5MkdYWmR3?=
 =?utf-8?B?b1Ewdm5ydmE2YTNJWDdoV3d6OXpsTGU3YTdaUnBBOGJGSExhNkZUanhqQkla?=
 =?utf-8?B?MDVORTZtSWFYMWZlN0I0WUtwOFEvVFZRR0EvdjVzd3dEZ2VyQlRNL1UvSE94?=
 =?utf-8?B?RkJZR1BKVWtXa3djSUErMVJObngxa1krS05IdktuRXM1U25iZE0xUGpwRmVS?=
 =?utf-8?B?SWJDazhlc2dIM0JxczFCMlltWkRUL1g5akRGQkxpNXdwWU1BRzFjNW1HWUxE?=
 =?utf-8?B?d0FXQVZvQ2NmRG1teWNLR1JNRHdLd1U5ZDl5d2xORVBKaWlIb3JTeUxYUk9K?=
 =?utf-8?B?NmIydnl3eWdBU280SjlrUXArSTduQVhXTE5jSkZmV21ORHpUeXVncWdoUmVq?=
 =?utf-8?B?TlNMRE1STDFHeUFCUHQ2VnVIVEVPOVdvOFBqeEVjZmd6Y2VlL0lhMWVlVnpG?=
 =?utf-8?B?bFltYVJRd3V0VFhxcU82eWd0L2FhdFJSS2R3V3g3OC9OS3NDTE1oK3lwS0ti?=
 =?utf-8?B?ak9tWWdnNitqU1dsN1NQeEN6M0dmT3llSVJwUUZ0NG5tSC9oelBpMSt3eUdQ?=
 =?utf-8?B?TE4xY0JXZ2kwNm41NWUwdDZUakU0NXBicHZlUFZaUDU0bnk0ZkNYTzZkU2R2?=
 =?utf-8?B?MEl0MzJTNHVJZmxWNGNJVFU5aW90S0JoTURNYVVDSmVhZk9weEdUQVZRaUtE?=
 =?utf-8?B?MVVFejBEQXNsTmN0WHkxdkpKNkVYZ3BkTWNVL0pYTjh0OW5ScWJUdUt2cER0?=
 =?utf-8?B?N2dzaWpoMkpRNElrd1lBQU55Q2thaVZGdTNDYi9qejB4WGMvVEQ0MzVJM2xB?=
 =?utf-8?B?K3RvanRPZWJsbFVQTDBzaUFEbmpnU0QwZS9Qb2NRSVltOTB4Vms4R0tZdjFI?=
 =?utf-8?B?RkhPU3JudFpsbWxBSkUwMEt0aUo1OS9PYVdEWWU0MVpWWFJwQk1pbk1BU3lT?=
 =?utf-8?B?SnlvYjhORG9ma1h1WTJmQkJzaE5YaHJ3YWRBRnYxVWdtZm8xV21VV3h0TXpk?=
 =?utf-8?B?S1ROWW5FRS9pSGRDWXI2ZFVxNGUreWdEenRLNDNPcCtZZDJnL1dNMmY5OXdu?=
 =?utf-8?B?a2JaQ1d2Tm9keWFiVm42REZsWDBvQ2ZMYUFqOW0xbmxMVkgyQUhrQzVRUk9L?=
 =?utf-8?Q?c/eA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0383dc2b-fc42-4693-06bc-08db40f790da
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2023 17:00:23.4277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mNQmvvSo4wEc3fR0RY4IxPLsM5qWOL+YIg5dTxY0NCClQKIQ8kwzz4E39MGCmmn5BNB08oQw27at//9+XPPRXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8907
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2
YW0gPG1hbmlAa2VybmVsLm9yZz4NCj4gDQo+IE9uIFdlZCwgRGVjIDE0LCAyMDIyIGF0IDEyOjIy
OjU0UE0gLTA1MDAsIEZyYW5rIExpIHdyb3RlOg0KPiA+IFJlcGxhY2Ugc3BhbiB3aXRoIHNwYWQu
DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBGcmFuayBMaSA8RnJhbmsuTGlAbnhwLmNvbT4NCj4g
DQo+IFJldmlld2VkLWJ5OiBNYW5pdmFubmFuIFNhZGhhc2l2YW0gPG1hbmlAa2VybmVsLm9yZz4N
Cg0KW0ZyYW5rIExpXSBGcmllbmRseSBQaW5nLCBqdXN0IGNvbW1lbnRzIGNoYW5nZS4gDQoNCj4g
DQo+IC0gTWFuaQ0KPiANCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9wY2kvZW5kcG9pbnQvZnVuY3Rp
b25zL3BjaS1lcGYtdm50Yi5jIHwgMTAgKysrKystLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwg
NSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvcGNpL2VuZHBvaW50L2Z1bmN0aW9ucy9wY2ktZXBmLXZudGIuYw0KPiBiL2RyaXZlcnMv
cGNpL2VuZHBvaW50L2Z1bmN0aW9ucy9wY2ktZXBmLXZudGIuYw0KPiA+IGluZGV4IDU4YTIzZWY0
YjU3Mi4uOTM1NzQ4MjQ0MDc4IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2VuZHBvaW50
L2Z1bmN0aW9ucy9wY2ktZXBmLXZudGIuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2VuZHBvaW50
L2Z1bmN0aW9ucy9wY2ktZXBmLXZudGIuYw0KPiA+IEBAIC04NCwxNSArODQsMTUgQEAgZW51bSBl
cGZfbnRiX2JhciB7DQo+ID4gICAqIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwNCj4gPiAgICogfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfA0KPiA+ICAgKiB8ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB8DQo+ID4gLSAqICstLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLSstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSsgQmFzZStzcGFuX29mZnNldA0KPiA+ICsg
KiArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rIEJh
c2Urc3BhZF9vZmZzZXQNCj4gPiAgICogfCAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAg
ICAgICAgICAgICAgICAgICAgfA0KPiA+IC0gKiB8ICAgIFBlZXIgU3BhbiBTcGFjZSAgICB8ICAg
IFNwYW4gU3BhY2UgICAgICAgICAgICB8DQo+ID4gKyAqIHwgICAgUGVlciBTcGFkIFNwYWNlICAg
IHwgICAgU3BhZCBTcGFjZSAgICAgICAgICAgIHwNCj4gPiAgICogfCAgICAgICAgICAgICAgICAg
ICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgfA0KPiA+ICAgKiB8ICAgICAgICAgICAg
ICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICB8DQo+ID4gLSAqICstLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSsgQmFzZStzcGFuX29m
ZnNldA0KPiA+IC0gKiB8ICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAg
ICAgICAgICB8ICAgICArc3Bhbl9jb3VudCAqIDQNCj4gPiArICogKy0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKyBCYXNlK3NwYWRfb2Zmc2V0DQo+ID4g
KyAqIHwgICAgICAgICAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgIHwg
ICAgICtzcGFkX2NvdW50ICogNA0KPiA+ICAgKiB8ICAgICAgICAgICAgICAgICAgICAgICB8ICAg
ICAgICAgICAgICAgICAgICAgICAgICB8DQo+ID4gLSAqIHwgICAgIFNwYW4gU3BhY2UgICAgICAg
IHwgICBQZWVyIFNwYW4gU3BhY2UgICAgICAgIHwNCj4gPiArICogfCAgICAgU3BhZCBTcGFjZSAg
ICAgICAgfCAgIFBlZXIgU3BhZCBTcGFjZSAgICAgICAgfA0KPiA+ICAgKiB8ICAgICAgICAgICAg
ICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICB8DQo+ID4gICAqICstLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSsNCj4gPiAgICogICAg
ICAgVmlydHVhbCBQQ0kgICAgICAgICAgICAgUENJZSBFbmRwb2ludA0KPiA+IC0tDQo+ID4gMi4z
NC4xDQo+ID4NCj4gDQo+IC0tDQo+IOCuruCuo+Cuv+CuteCuo+CvjeCuo+CuqeCvjSDgrprgrqTg
rr7grprgrr/grrXgrq7gr40NCg==
