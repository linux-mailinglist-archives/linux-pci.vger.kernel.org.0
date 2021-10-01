Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E19C241E6D4
	for <lists+linux-pci@lfdr.de>; Fri,  1 Oct 2021 06:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351826AbhJAEkL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Oct 2021 00:40:11 -0400
Received: from mo-csw1114.securemx.jp ([210.130.202.156]:36328 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbhJAEkK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Oct 2021 00:40:10 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 1914c618000687; Fri, 1 Oct 2021 13:38:06 +0900
X-Iguazu-Qid: 2wHHK91O80cgnP4a2e
X-Iguazu-QSIG: v=2; s=0; t=1633063085; q=2wHHK91O80cgnP4a2e; m=EpApnWM8hPEw23A4vPVH79YQokC0TvNZfNwMaVE+474=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
        by relay.securemx.jp (mx-mr1112) id 1914c4dY010174
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 1 Oct 2021 13:38:05 +0900
Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id A624A1000DF;
        Fri,  1 Oct 2021 13:38:04 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 1914c40R023125;
        Fri, 1 Oct 2021 13:38:04 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DxQZGS5w7lqal+pyqNf0iYYjRx/F11cRq+3ZwCOPKcdVrhOPBr17p7Ac17xHA7fbNO7TugUiSOfZgQ9A3UItQCC5PotuvJ3FLDPuL2CQX7beq4TZnsGAuA/CPESqz1OzzfWnIgP+CijfIMMzhDJARrS/q58IlGy+/ZCyISdJIauF3CeesrFu7Dej/77/fX5FspH/nK5MErqhM1xuQDGF7N09Tb6EwAzwx68Z8rnxqqnZ67MjXva/roWWeFjP4MsPzJgVZvtCpiXrKhJWoXZeDWUvhdeVJNxjwycMuEfJra7GIrLmICz7nAfkODZhcTTc7NvFLKc9yi9ajUZ/Phm95w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3vjQvD8leAfRWytlli9ruoWwgQ4Wll4u89DGD1H8DE=;
 b=Djcnh9P1X+q+b1VZOhShvX1J95QDyQ54CYxe0OgzqVt4SCglA3LTM0pZo6cV4bXRSKPPTwIOIJ4oYEgEX8zXwcwzEcGmh59gQnvHwRGB88aUBexzqv/I/g+19VMzvcwDLjsK0lqt6VIPR3g2YcKUXxeyWCpW1QAoFnEIaQIcL1sQveKJusuTP105Hc3rOE9h95FgkKFl7yJCcIjHvPwrinBhEG9Q6q2AJz8Lh0OtzRldO0dzgmWXn5PzXT0EMRKdufO8E4S2qSgISiyGVQawFg13LrlCQb8ENTnpOmbYztay/LaOLr6lyZ5Gd/Skzt0R84AIyDbmxGrCihPEATdClw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From:   <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     <kw@linux.com>, <bhelgaas@google.com>
CC:     <lorenzo.pieralisi@arm.com>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] PCI: visconti: Remove surplus dev_err() when using
 platform_get_irq_byname()
Thread-Topic: [PATCH] PCI: visconti: Remove surplus dev_err() when using
 platform_get_irq_byname()
Thread-Index: AQHXtmIGGBk9ENLDC0mTe/5ij2RIR6u9jxzw
Date:   Fri, 1 Oct 2021 04:38:01 +0000
X-TSB-HOP: ON
Message-ID: <TYAPR01MB625260E97AF183E0B580C5B192AB9@TYAPR01MB6252.jpnprd01.prod.outlook.com>
References: <20211001011626.132286-1-kw@linux.com>
In-Reply-To: <20211001011626.132286-1-kw@linux.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
authentication-results: linux.com; dkim=none (message not signed)
 header.d=none;linux.com; dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2aa1957-8c21-409e-6062-08d984954068
x-ms-traffictypediagnostic: TY2PR01MB2026:
x-microsoft-antispam-prvs: <TY2PR01MB20265A24FE72DA0297CA20D492AB9@TY2PR01MB2026.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ws9ahS8kWzJ8LxoZVDYIqTmAaGnPoYYAbRjhypC3Y2aWf9bNFhcQrhZEOwOYJug54U5qIyGP/0NIABDPcE2oOfF8QPL/cXfjntFB0jcuO+5mk7qevjl429NuWUrjlTs6D4MfFECZwbESLAZZDpkd25PaSOJ6+LguwoxPwSS9VUqD6+vHAx93WdhGvNjsdXrENSEkY3c/hLlCMkAXG/bBjDFUpNlKy46UFYG/fPcnnGyFYd381OraVv76pkvLveub760+QgBOpsZzYSXAtfMHo8GfAysexoWMl0YPhl9c8/oupg85hRYUJoU9QpHXgfdteKa6mcG+vc8+DzlcdVXRNTdm/YgR07SrsU0dX7Z4Cbg0j8xR3wJ0jKQzsR5Mn5EVANGMEyUvt+gouDoTswecCvbePQKVluGQhKmsm+aExR8IT70pABuLD4mQ+C2JWFhRkeN8k9V4IA/MHSOku9wPivefiAqYSPQy+y9UEo33tlNCsdiY5GjFxwCw8zly+q/B9S/N6FqySHT3DBpH9LBHuI3Qxxc4QN1OkhD9xkscjUDEwx83Lz9EK/3f09NOr7EoYRs9K0/+Mx7d8nusup9pk8AXDJqEgilyJEI1UX5p1ysa0r/PU9dSdaGNNO6kmMhxwJvlewDOQ8DU1kCB/viZuEx0HLelT3NT+JlO59XhoVRySzUkNTnk4/xgF1Qan7eXmCpCLQ6KP4KCSo8ReRT8jQKem8T7nUoUuZAljljhT6RWGvjrtoM41woOwSYKjgNjY6cSwWrPHoLYUp1Y98jwiLMtl+Ww/XdFXDfDeUOmvARQB74ggASNMjrSf8XjQ7CIzKmZ8jUWhNzNd98PDYxxDg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6252.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(316002)(2906002)(52536014)(966005)(71200400001)(508600001)(8936002)(186003)(26005)(83380400001)(5660300002)(110136005)(53546011)(8676002)(55016002)(38070700005)(64756008)(6506007)(66946007)(66446008)(76116006)(66574015)(54906003)(7696005)(4326008)(33656002)(38100700002)(66476007)(122000001)(9686003)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NkE1dS9aTWY4YUZad3hxcmVGS0FkbmRtUDhLRmxCMjhwcU1ZbVU3VGxRZCtY?=
 =?utf-8?B?VWFKQVA0V292cGVBaXdjMDhvWGlLTGo1aFBPWUw3ZTB0Z2IxRUxEWXN5a3Rn?=
 =?utf-8?B?MnpTME02RGtvd09QanRuNXFQZEZnM245aVZzZFdHOHpkb2dsaHhqMlFxbFM0?=
 =?utf-8?B?cVVoWkptQ0xwNHRHMUNCejQ1bWI5Z1NyY0hzOGdYUXhpaGlTOFNuVlY1VytJ?=
 =?utf-8?B?SDEyd3g1RUNIbUNzMXVoYlEwMHY2QUdtMlBsWUdON2FlNkg1NkVSWDVXRWlB?=
 =?utf-8?B?aitCZ2NOaDZ0NUl2KytMRG1iYzdZOXJhcDBHR0dPeGtwVmZWQk51WlhMaVBH?=
 =?utf-8?B?QkpTOVpJQjdhdnZaVlhtQXRyOWdYcjdGdFhDdk10SlJDRVkvdFFUMCtIb3Vz?=
 =?utf-8?B?cS8vVTJwanJvZjV2NzVqYktHVmNOZWRjTVg0NWdFdzJXYWVsaE1iNHUvb2g0?=
 =?utf-8?B?RTVCTFNOVStZcEtvc2poSy9wK21sa1J0dDVsR05obitWZzZIWGhudEptUnk1?=
 =?utf-8?B?Y2hiUU9rUlVLVUwwY0RKY3JLeVF3ZmJhQUlxZy9PRmR4QlNXQlZlU2lhblJC?=
 =?utf-8?B?U0tqYTdpWDB6SFVIK0NXMldnRmhGRE5sTFBIb2czd2ZmbjVvRzc1S0h5cDZ4?=
 =?utf-8?B?djA4bmdVemh0bjRDbGpsUndzZXRPRXlRZUEwUU1ySWZhejRCTTI3QmZCQi9j?=
 =?utf-8?B?dlE4YTArd0Uvd1RZWnE5S3lHRUhseElsOGovTDU5cTE0NnU2UUM0QldkUEdV?=
 =?utf-8?B?eGcranRTM1B6bERONzlzb1htL0V6aGVQRy9QOHhmNkFaWGhiNUJuZWdtc091?=
 =?utf-8?B?RTdvYkRxdXJZd2FCakhIemRjeENYQnR4SnYvOFdGcitvQjhmblc5U3orQW5l?=
 =?utf-8?B?UXB3S1pmeW92OFlXeTlVYUVIL0NWZW82cThnVFhwK0pPMStvbDVHOUVRcUgr?=
 =?utf-8?B?MkZzOVdzK3RGdkNwaURSY1V4WC9NUUVuaE9XWkpneVd4STIrdlpVS211Ujll?=
 =?utf-8?B?U2NNaUtFNGdkRjV3cWNpcnozUUtLQ3V3dUFCMUh2UWIvbkl2UHJvNjJqSmIz?=
 =?utf-8?B?WCtNMnBiMExqNTl4eFZQbFNEQTgzM0FpblhzMUs5ZXlUcUIvQTNMYllQUXAx?=
 =?utf-8?B?eUFVTkFmbUhJRGpvQXZLTjlhVnREWkkxVmVhN01kRzF5a1RSZ3NXTTN5TlhY?=
 =?utf-8?B?dkkzcWdXZGtjdGI3YXh5WkpRVVBKazNwQkdMZVFyZmRhL2JIcUc2TitZUkFK?=
 =?utf-8?B?aFJDWGZJU3N6bkZDR0Q2RGRpQ0Q2bGsySXcrdFNoWGgrRjBMclBZb2k1V1Ar?=
 =?utf-8?B?SkJuZDlTcENWb204RS90VlN1TlNTdm9NdmVyM2I0eENwaGdHU2NoVnRESXpP?=
 =?utf-8?B?TmVYYlQyMGQ3MVB5UzlaM0lVaW9NM3VBbXVsdDRVVlV3eHZ2TlN1Wk1UYU5a?=
 =?utf-8?B?WkdtdlA3SFV2RkdxV05rRHQxdk8vWWVUZVhSN2tXM2xEQ2MyalZCM2NxWkVw?=
 =?utf-8?B?QVN4cmNCV3lQdFdZZzlJZ0l3VnhVM2FJT1JpSlZNamNJSGNUSFNRVXhKa1FG?=
 =?utf-8?B?OE9CMTVDNFBYRnJCUGJtOVF1Tkc3dDBnUTVhMERXbVpMSEpxUngzVXhMcDk4?=
 =?utf-8?B?NW94UmVDR29PY3lXM1VySTdkcGRTRlBKdEQ0aTRHdkpEME9CbWQzcWNNS0ps?=
 =?utf-8?B?cUs2NDFMUDJqcFhCQTVUbkJyMlFSdEw1bGlGT2dDa0FuRE9nUkZtQWlnV2xI?=
 =?utf-8?Q?MEpG6/z14zp2nf59t7gdDDAw9OxVkKIkmauAWKG?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2aa1957-8c21-409e-6062-08d984954068
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2021 04:38:01.4086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 55ngDULIwExjvLfo+zVzc6Ppon+LJAOzMic6pYQW5stLy11CcL7ZlL3FjfjHSb5PpLfDz0I7m6wSh665nHqOg+t6r32UBjmKy9HtDxJ9E42BCaRVmag8/Oq8F9RfWho8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2026
MSSCP.TransferMailToMossAgent: 103
X-OriginatorOrg: toshiba.co.jp
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIFdp
bGN6ecWEc2tpIFttYWlsdG86a3dAbGludXguY29tXQ0KPiBTZW50OiBGcmlkYXksIE9jdG9iZXIg
MSwgMjAyMSAxMDoxNiBBTQ0KPiBUbzogQmpvcm4gSGVsZ2FhcyA8YmhlbGdhYXNAZ29vZ2xlLmNv
bT4NCj4gQ2M6IExvcmVuem8gUGllcmFsaXNpIDxsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tPjsg
aXdhbWF0c3Ugbm9idWhpcm8o5bKp5p2+IOS/oea0iyDilqHvvLPvvLfvvKPil6/vvKHvvKPvvLQp
DQo+IDxub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD47IGxpbnV4LXBjaUB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBTdWJqZWN0
OiBbUEFUQ0hdIFBDSTogdmlzY29udGk6IFJlbW92ZSBzdXJwbHVzIGRldl9lcnIoKSB3aGVuIHVz
aW5nIHBsYXRmb3JtX2dldF9pcnFfYnluYW1lKCkNCj4gDQo+IFRoZXJlIGlzIG5vIG5lZWQgdG8g
Y2FsbCB0aGUgZGV2X2VycigpIGZ1bmN0aW9uIGRpcmVjdGx5IHRvIHByaW50IGENCj4gY3VzdG9t
IG1lc3NhZ2Ugd2hlbiBoYW5kbGluZyBhbiBlcnJvciBmcm9tIGVpdGhlciB0aGUgcGxhdGZvcm1f
Z2V0X2lycSgpDQo+IG9yIHBsYXRmb3JtX2dldF9pcnFfYnluYW1lKCkgZnVuY3Rpb25zIGFzIGJv
dGggYXJlIGdvaW5nIHRvIGRpc3BsYXkgYW4NCj4gYXBwcm9wcmlhdGUgZXJyb3IgbWVzc2FnZSBp
biBjYXNlIG9mIGEgZmFpbHVyZS4NCj4gDQo+IFRoaXMgY2hhbmdlIGlzIGFzIHBlciBzdWdnZXN0
aW9ucyBmcm9tIENvY2NpbmVsbGUsIGUuZy4sDQo+ICAgZHJpdmVycy9wY2kvY29udHJvbGxlci9k
d2MvcGNpZS12aXNjb250aS5jOjI4NjoyLTk6IGxpbmUgMjg2IGlzIHJlZHVuZGFudCBiZWNhdXNl
IHBsYXRmb3JtX2dldF9pcnEoKSBhbHJlYWR5IHByaW50cw0KPiBhbiBlcnJvcg0KPiANCj4gUmVs
YXRlZDoNCj4gICBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMTAzMTAxMzE5MTMuMjgw
MjM4NS0xLWt3QGxpbnV4LmNvbS8NCj4gICBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAy
MDA4MDIxNDI2MDEuMTYzNTkyNi0xLWt3QGxpbnV4LmNvbS8NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IEtyenlzenRvZiBXaWxjennFhHNraSA8a3dAbGludXguY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtdmlzY29udGkuYyB8IDQgKy0tLQ0KPiAgMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAzIGRlbGV0aW9ucygtKQ0KDQpUaGFua3MgZm9yIHlvdXIg
cGF0Y2guDQoNCkFja2VkLWJ5OiBOb2J1aGlybyBJd2FtYXRzdSA8bm9idWhpcm8xLml3YW1hdHN1
QHRvc2hpYmEuY28uanA+DQoNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9s
bGVyL2R3Yy9wY2llLXZpc2NvbnRpLmMgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ll
LXZpc2NvbnRpLmMNCj4gaW5kZXggYTg4ZWFiNjgyOWJiLi4wNzZkYTQ2NzI2YTcgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtdmlzY29udGkuYw0KPiArKysg
Yi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLXZpc2NvbnRpLmMNCj4gQEAgLTI4Miwx
MCArMjgyLDggQEAgc3RhdGljIGludCB2aXNjb250aV9hZGRfcGNpZV9wb3J0KHN0cnVjdCB2aXNj
b250aV9wY2llICpwY2llLA0KPiAgCXN0cnVjdCBkZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7DQo+
IA0KPiAgCXBwLT5pcnEgPSBwbGF0Zm9ybV9nZXRfaXJxX2J5bmFtZShwZGV2LCAiaW50ciIpOw0K
PiAtCWlmIChwcC0+aXJxIDwgMCkgew0KPiAtCQlkZXZfZXJyKGRldiwgIkludGVycnVwdCBpbnRy
IGlzIG1pc3NpbmciKTsNCj4gKwlpZiAocHAtPmlycSA8IDApDQo+ICAJCXJldHVybiBwcC0+aXJx
Ow0KPiAtCX0NCj4gDQo+ICAJcHAtPm9wcyA9ICZ2aXNjb250aV9wY2llX2hvc3Rfb3BzOw0KPiAN
Cj4gLS0NCj4gMi4zMy4wDQoNCkJlc3QgcmVnYXJkcywNCiAgTm9idWhpcm8NCg==

