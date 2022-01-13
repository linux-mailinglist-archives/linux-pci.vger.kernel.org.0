Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31CAB48D35B
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jan 2022 09:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbiAMIHP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jan 2022 03:07:15 -0500
Received: from mail-zr0che01on2135.outbound.protection.outlook.com ([40.107.24.135]:38529
        "EHLO CHE01-ZR0-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229991AbiAMIHO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Jan 2022 03:07:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AWlkbvcVjzkhiNpe2yBpW0Nizbg9QAneXz54vs8wZRjWFm7jRyzUjIUc+cvrf0ff3msGD1BEczhwmz+GJpn7CXdQFDfglMTV1seQd0nYibFAQP2bHOKdZfgZi+rdiecr7/llqe4qs/HQuScfOr5RiQDYV/n5LgQlY7m3GM4gFP8WHda9ejPVjviUo1lom8OJc4j3yJ62Au24pG/ztTZMOgwIptVrg9AywFDASH5J0M4qnR4WgYHSwWiHECKbTuIT+apjTNGjA273/m4v4iEGnfYmquK/vzhqc+CymOBwtubLn91W6z0GSckGz3HueKgei9OXeo6rnVccRfAV3KAVgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Ddg9SCpWbbYyK+wFkpkB1r0zPwHCKLN55oBfFVidNQ=;
 b=j0f+EN4uFNNn7Ktb2IbYsMTmDu5dqMf1cw1HjzKqL8eWWd/pGnIJuKotCZwP7/h44JGsr6LQ4t35R7P7Uj5rYjCPRMbkyJOcap53RSYwWWS99ukNkLF+BHr98yT0bWMnTqHGDlRcnHMjR921FVKopzQPaMWxU+KrJARtvmD4ttvaHRsNpWyi2GwpwmJpjR5cfgQyI313DOzhs7+t0XbnZd6ptI52ys9oTYBPVEbhi1QYsyv3hSZuHHs+lVYfFtsB1bFV9iOtqh8deytl8Yg7w3wv6gy6QqEME1x0bEN5CGpwLSnlHaH0bHpbZ4wbs9ZC0/UwWjG8BnjVT/vMTgwePQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Ddg9SCpWbbYyK+wFkpkB1r0zPwHCKLN55oBfFVidNQ=;
 b=jIsBTGQkO7R3RBhRMRf9iyAh1UhlKGn5dsVCqdN2JKRNh0wCEDtvQ+hRRo6bFXa13J5etiDMohhM/x3+UrtSJ3cHOkVGrfwpLhssCr0oIGp0iALwaSEOfzNLctoXspT2MeG3u3cdhMYK6wMYJI7ah2PlTA8Sem3L7UdMAxQkDbg=
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 ZRAP278MB0336.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1e::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.11; Thu, 13 Jan 2022 08:07:11 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::7067:aadd:1aa2:85ee]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::7067:aadd:1aa2:85ee%8]) with mapi id 15.20.4888.011; Thu, 13 Jan 2022
 08:07:11 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "kishon@ti.com" <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "galak@kernel.crashing.org" <galak@kernel.crashing.org>,
        "hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v7 0/8] Add the imx8m pcie phy driver and imx8mm pcie
 support
Thread-Topic: [PATCH v7 0/8] Add the imx8m pcie phy driver and imx8mm pcie
 support
Thread-Index: AQHX51bayQyryZeqPkW7Q4t4cvqhHKxg2nSA
Date:   Thu, 13 Jan 2022 08:07:11 +0000
Message-ID: <8c11bbded57df020ba0897f7ad0295d60c9ee2cb.camel@toradex.com>
References: <1638432158-4119-1-git-send-email-hongxing.zhu@nxp.com>
In-Reply-To: <1638432158-4119-1-git-send-email-hongxing.zhu@nxp.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toradex.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a41403a9-d137-4570-faa9-08d9d66bb3e1
x-ms-traffictypediagnostic: ZRAP278MB0336:EE_
x-microsoft-antispam-prvs: <ZRAP278MB033610ED24E7514F207EC50CFB539@ZRAP278MB0336.CHEP278.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WC7mc6y2+rRLaHjx4XzxaTLQ94KtqumELDliBLkjJowbml2GMhqeAokLE24sD6eJHrhDtSGyQ0iliNqFfhwVau3OhqUMVB4upHZn7cvukhHOYIug4PpMYZ0RKbsbKxuFiu9DSPjD7BnRQgtCr96N2jxCFqtdMwFGq53cPRSOsNLTikAbFs7VuBTDaxrDS7Jz16JaLGZrjgwo7/L+/PFDHUERgA19+5PrQjhAqSZ314ibdSWgGxxRQl+561czIYA6Q+7RkhuIVBFr0CLnqX/K8JnhPswequGFDjght+jY26DkMbbQCKO3LXc0CHa2qU3f4Q+Ap/4wm8EYf1+z16srwuq+eJrMSRxzLABC9/CG8fGYo+Zc5TUUMZ7ozrdpq8ZNis0sLVLBOfh0VChPu1lQYInWLc7g252D/krXvjK2bPA9joRD1jtH+uBTK2ydZXbg5boxDVN7dlcIdgae34tuc+wmkefVOHg/Yg3LYP85KOCtz//R9XO9nqllhC3btHSa9YVjsHaN3iJlmSJYv1nSq9MbUHuQLooV6OWIGbgxnegn1hwyU1i4HByHutRrwiLbpOmXyCuamfxwKnHNqWa0AMyn7zsridYn9g4DVbKe+5a+k0/ldvMUPW8Ly6rMoCvgnjbTiJA3sPGmNWITtTvzKczktufamSgRbwBEYtlxD/2wnPVvm7VYMTmJzI7WJSkAHg6ubI4QKab0NY8f749ADOsBuLSQKkO4uIAFo8JsWrCJm0TQIbA23strbwwwhsTKIJ0lWF08oLSELfQxLYG97x1WQcsxTv0RVIZ/JnOZIR0zWS4CId8i49ADdV8PuIr1+40Tnx2NPm7KJ3h0BFU3Kw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(376002)(39840400004)(136003)(186003)(2616005)(4326008)(38100700002)(122000001)(2906002)(921005)(508600001)(316002)(83380400001)(71200400001)(66946007)(8936002)(38070700005)(110136005)(26005)(54906003)(6506007)(76116006)(8676002)(36756003)(5660300002)(44832011)(66476007)(66556008)(64756008)(66446008)(7416002)(86362001)(966005)(6512007)(6486002)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFBMN2U3WFNzTWRSOWZIL2VqTHg5UHIrbTJsWUtoRlY4U1cvZnJIQzFXRWYv?=
 =?utf-8?B?N09hUTFtQStnMVducHlNTVJzaGsvYXIvYkxreDhVbVNIdUpJNzJBU3pSeEFM?=
 =?utf-8?B?a1lvK1c5bm5vVFNTbG1JZVcydEtaNWd3WWJmNmt0WDBFdFBGYks4VkROOVo4?=
 =?utf-8?B?a2ZITzRmdGhPZytiSE8yT0xPWWlNZG44ZU5HUE1FblNsVm5SZzhINU5JeTZM?=
 =?utf-8?B?VXVrZjgvNm9PSjIzaVpneWo0ZHZxcFV6aW9rcHB6YnpLK0tVR2tCOHpqYlpZ?=
 =?utf-8?B?UXRPUnBLZVZzK3UyaTNMcTlSM0RwRDczS2hCQmQ5bzlrNFJUNEdncW9SRWo4?=
 =?utf-8?B?dk1CdkUxUGJVWWlhTXdGY1UxOU9UZi8zaG9zUUIwUGFKRFRVWDc2S1UvS29h?=
 =?utf-8?B?V1FDSnUrTzB1cUo0V2FYVTh6VU9zSUNtM2FRVVpWWlRab1JJdFU3RWZkRzNl?=
 =?utf-8?B?MUdIaUZZTVhTeFFnM1I2emNMWnZBT0tzRElyZTlzWXBDQ3RwanNyTFpXOFlC?=
 =?utf-8?B?VmxCbExvK3Jad1BzeWdMcFg2dUJUS3Y1bldrNENqWUxBNWNXWVltbEV1bnRh?=
 =?utf-8?B?aFNDOTNqWWx3WmVjZ3dLZlhpQ3NLSDYwOWpsY0RBR0dFZ3Uwa1BlcExrSkNR?=
 =?utf-8?B?ejlFRTAwRzBxRGxRU0piWHdZN1hPZFBQTXhTeWpvL0NKeWJzN0prbUZ5MjN6?=
 =?utf-8?B?OGw2cWVCbERweDJLYWpSQy95TVBqZy96NUE2dHdyVzhwenRCY2JiNkZYcFVF?=
 =?utf-8?B?Q3IvVHBpRXFSMVR4SCtOQTQzRThhNksyWm9NRmpKU2xtaHVCTjE4UllYTENy?=
 =?utf-8?B?cDVDdTRSdWFQTFliMjVyNks4WU8vVkFqaVVuUURmYW1nRS9DbzBDWU92em51?=
 =?utf-8?B?NWpoeXNobktmT3h6RXlsVWZRYXc0ZXcrQTVDemtPWHliNTIzM0tPTFV1QnVZ?=
 =?utf-8?B?ayt5YThnMDZkS2hMakFZQXhSODhPazd1RExxU3YyYnc2WWlKd3lmRlRySmZw?=
 =?utf-8?B?U2xQLzlkMG1OdTEvV3I4cmF6SUJ6dlR2Z0N2M1lEU3hoZWxLYXU2NXlIOFNH?=
 =?utf-8?B?a2hGaFlhU3Q4U0dtRHRhQnBCNlBlNVQyWjV4SGRGSXYrbVFjSnU4NCtRZnlO?=
 =?utf-8?B?QjJUSVVya3ZuMjh6dHdXc1VNQlZRQjRNREZQcy9TNjNVUk1aaCs4WXZKWEh5?=
 =?utf-8?B?cEtVZnphdEpYMVFTR0ptVWhPdE4rWFAzSDV5R3k2VnhhdnNJMmtvT3REdjUy?=
 =?utf-8?B?SkhkdFJqc0NwNVhIb1NBdGNRTFZhY0dPTFZnczcwejc0K0hWWWx0ZENXZytR?=
 =?utf-8?B?V2wwVVNZUmVTZjZ4UWpPeHF3VE1OTGFsUXRMcU9sSFJGWHlYa2ptdDRDVUhX?=
 =?utf-8?B?cmtaOVRtdElaa2lRSU5lQlVUY0ZIak9JVEN0amovSDQyVzBCRXg0UENaWSs0?=
 =?utf-8?B?MkpEdFdvcllGUlRIaTliSUczT2JMaHh0S0tBemVEVDM3dGMzTGlaQmtlVU0w?=
 =?utf-8?B?V3lGUXh6M3lmRTJmRDNBWWJMVlZQS3ZhbndIR1pYTjdKT2xCaGtnZk1sSWJZ?=
 =?utf-8?B?REtnd1FteFhQZVNpZHU2a2dseHpxTk1aRVlxMEhkb2Vibk5zZ3owRE1XZFdY?=
 =?utf-8?B?UGNhSFpPQ2M3V0JHTnBtN01od1BabXU0UWt1Y3JRSW84eVBCZTZWMUEvMjFm?=
 =?utf-8?B?R0NMYTZsK0VPdkhuTmFuNVJ4aXVIYy9Ma1dFVkFYaldjYW9Yb1pYZk9haHBM?=
 =?utf-8?B?dWdIdlBrVXJSV2lNNzkrWUNUN3VaQlUvUzc0ZzFRNXUzTVZCU0loYjlKZFA0?=
 =?utf-8?B?N1ErZm1Sc1ZteElwT096K3FLRnZMamZQL0lKNTZBMVZiUldnYkpubjVmL0pY?=
 =?utf-8?B?SXppSFU5YWovR0ZCOUN3SGI2bmZvVExwVnhuL3NaNTVzR2xVZEhLK0ttTEtS?=
 =?utf-8?B?TDV0cnJDL3NqcGEwdDR5bTladWFYaGJzZHRhSGdCM0NrZm5oUVhlR0VCenN0?=
 =?utf-8?B?ZFlsUENsSU9pK1F6N2xLKy93SXJqcDFXM1djTjZiemJUOWRiTW9peUFJRW5Y?=
 =?utf-8?B?VXRqREhGdGN4d2FGSzAyYm1TRG11bFo2MkVRTFB4dE1LUTFZRGFoY3M0UHRN?=
 =?utf-8?B?Y25KeEJQWHFPTTRHbWpBWWVYOXJGOU1uQjBZalN4TWIvOEJQUU15dW82dndp?=
 =?utf-8?B?ZzhrSzkvZzV5TFBKVzVwV0hrSklJQ3BZU21vcHdGelhCeHRCNnZYeEdVbVkx?=
 =?utf-8?Q?NNTh9M8qHRIXDqJGuC5vZYS42chXbCtiLOvZwh2op4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <59250E497D5E12468AC52AC62CA1A788@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a41403a9-d137-4570-faa9-08d9d66bb3e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2022 08:07:11.6630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ETPdYo8Jc+iSNJhNXH7RF8I8WDWhafjQ5+BXKEI77wK8MmJrR5ULr2SolTyl9LO6tZfhIr4P7Vf2K0jJcTpTTdH4PeYbfUu6gsRZip+euPw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0336
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgUmljaGFyZA0KDQpPbiBUaHUsIDIwMjEtMTItMDIgYXQgMTY6MDIgKzA4MDAsIFJpY2hhcmQg
Wmh1IHdyb3RlOg0KPiBSZWZlciB0byB0aGUgZGlzY3Vzc2lvbiBbMV0gd2hlbiB0cnkgdG8gZW5h
YmxlIGkuTVg4TU0gUENJZSBzdXBwb3J0LA0KPiBvbmUgc3RhbmRhbG9uZSBQQ0llIFBIWSBkcml2
ZXIgc2hvdWxkIGJlIHNlcGVyYXRlZCBmcm9tIGkuTVggUENJZQ0KPiBkcml2ZXIgd2hlbiBlbmFi
bGUgaS5NWDhNTSBQQ0llIHN1cHBvcnQuDQo+IA0KPiBUaGlzIHBhdGNoLXNldCBhZGRzIHRoZSBz
dGFuZGFsb25lIFBDSWUgUEhZIGRyaXZlciBzdXBvcnRbMS01XSwgYW5kIGkuTVg4TU0NCj4gUENJ
ZSBzdXBwb3J0WzYtOF0gdG8gaGF2ZSB3aG9sZSB2aWV3IHRvIHJldmlldyB0aGlzIHBhdGNoLXNl
dC4NCj4gDQo+IFRoZSBQQ0llIHdvcmtzIG9uIGkuTVg4TU0gRVZLIGJvYXJkIGJhc2VkIHRoZSB0
aGUgYmxrY3RybCBwb3dlciBkcml2ZXINCj4gWzJdIGFuZCB0aGlzIHBhdGNoLXNldC4gQW5kIHRl
c3RlZCBieSBUaW0gYW5kIE1hcmNlbCBvbiB0aGUgZGlmZmVyZW50DQo+IHJlZmVyZW5jZSBjbG9j
ayBtb2RlcyBib2FyZHMuDQo+IA0KPiBbMV0gaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9w
cm9qZWN0L2xpbnV4LXBjaS9wYXRjaC8yMDIxMDUxMDE0MTUwOS45MjkxMjAtMy1sLnN0YWNoQHBl
bmd1dHJvbml4LmRlLw0KPiBbMl0NCj4gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9q
ZWN0L2xpbnV4LWFybS1rZXJuZWwvY292ZXIvMjAyMTA5MTAyMDI2NDAuOTgwMzY2LTEtbC5zdGFj
aEBwZW5ndXRyb25peC5kZS8NCj4gDQo+IE1haW4gY2hhbmdlcyB2NiAtLT4gdjc6DQo+IC0gQWRk
ICJSZXZpZXdlZC1ieTogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4iIGludG8gIzIgcGF0
Y2hlcy4NCj4gLSBSZWdhcmRpbmcgVmlub2QncyByZXZpZXcgY29tbWVudHMgZG8gdGhlIGZvbGxv
d2luZyBjaGFuZ2VzLg0KPiDCoCAtIERvbid0IGJ1aWxkIGluIHRoZSBQSFkgZHJpdmVyIGluIGRl
ZmF1bHQuDQo+IMKgIC0gUmVtb3ZlIHRoZSBleHRyYSBibGFuayBsaW5lDQo+IMKgIC0gQ29ycmVj
dCB0aGUgbGljZW5zZSB0YWcuDQo+IA0KPiBNYWluIGNoYW5nZXMgdjUgLS0+IHY2Og0KPiAtIEFk
ZCAiUmV2aWV3ZWQtYnk6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+IiBpbnRvICMxIGFu
ZCAjMyBwYXRjaGVzLg0KPiAtIE1lcmdlIFJvYidzIHJldmlldyBjb21tZW50cyB0byB0aGUgIzIg
cGF0Y2guDQo+IA0KPiBNYWluIGNoYW5nZXMgdjQgLS0+IHY1Og0KPiAtIFNldCB0aGUgQVVYX0VO
IGFsd2F5cyAxYicxLCB0aHVzIGl0IGNhbiBmaXggdGhlIHJlZ3Jlc3Npb24gaW50cm9kdWNlZCBp
biB2NA0KPiDCoCBzZXJpZXMgb24gTWFyY2VsJ3MgYm9hcmQuDQo+IC0gVXNlIHRoZSBsb3dlci1j
YXNlIGxldHRlciBpbiB0aGUgZGV2aWNldHJlZWUgcmVmZXIgdG8gTWFyY2VsJ3MgY29tbWVudHMu
DQo+IC0gU2luY2UgdGhlIGRlZmF1bHQgdmFsdWUgb2YgdGhlIGRlZW1waGFzaXMgcGFyYW1ldGVy
cyBhcmUgemVybywgb25seSBzZXQNCj4gwqAgdGhlIGRlZW1waGFzaXMgcmVnaXN0ZXJzIHdoZW4g
dGhlIGlucHV0IHBhcmFtdGVycyBhcmUgbm9uZSB6ZXJvLg0KPiANCj4gTWFpbiBjaGFuZ2VzIHYz
IC0tPiB2NDoNCj4gLSBVcGRhdGUgdGhlIHlhbWwgdG8gZml4IHN5bnRheCBlcnJvciwgYWRkIG1h
eGl0ZW1zIGFuZCBkcm9wIGRlc2NyaXB0aW9uIG9mIHBoeQ0KPiAtIENvcnJlY3QgdGhlIGNsb2Nr
IG5hbWUgaW4gUEhZIERUIG5vZGUuDQo+IC0gU3F1YXNoIHRoZSBFVksgYm9hcmQgcmVsYWx0ZWQg
ZHRzIGNoYW5nZXMgaW50byBvbmUgcGF0Y2gsIGFuZCBkcm9wIHRoZQ0KPiDCoCB1c2VsZXNzIGR1
bW15IGNsb2NrIGFuZCBncGlvIHN1ZmZpeCBpbiBEVCBub2Rlcy4NCj4gLSBBZGQgYm9hcmQgc3Bl
Y2lmaWMgZGUtZW1waGFzaXMgcGFyYW1ldGVycyBhcyBEVCBwcm9wZXJ0aWVzLiBUaHVzIGVhY2gg
Ym9hcmQNCj4gwqAgY2FuIHNwZWNpZnkgaXRzIGFjdHVhbCBkZS1lbXBoYXNpcyB2YWx1ZXMuDQo+
IC0gVXBkYXRlIHRoZSBjb21taXQgbG9nIG9mIFBIWSBkcml2ZXIuDQo+IC0gUmVtb3ZlIHRoZSB1
c2VsZXNzIGNvZGVzIGZyb20gUENJZSBkcml2ZXIsIHNpbmNlIHRoZXkgYXJlIG1vdmVkIHRvIFBI
WSBkcml2ZXINCj4gLSBBZnRlciB0aGUgZGlzY3Vzc2lvbiBhbmQgdmVyaWZpY2F0aW9uIG9mIHRo
ZSBDTEtSRVEjIGNvbmZpZ3VyYXRpb25zIHdpdGggVGltLA0KPiDCoCBhZ3JlZSB0byBhZGQgYW4g
b3B0aW9uYWwgYm9vbGVhbiBwcm9wZXJ0eSAiZnNsLGNsa3JlcS11bnN1cHBvcnRlZCIsIGluZGlj
YXRlcw0KPiDCoCB0aGUgQ0xLUkVRIyBzaWduYWwgaXMgaG9va2VkIG9yIG5vdCBpbiBIVyBkZXNp
Z25zLg0KPiAtIEFkZCAiVGVzdGVkLWJ5OiBNYXJjZWwgWmlzd2lsZXIgPG1hcmNlbC56aXN3aWxl
ckB0b3JhZGV4LmNvbT4iIHRhZywgc2luY2UNCj4gwqAgTWFyY2VsIGhlbHAgdG8gdGVzdCB0aGUg
djMgcGF0Y2gtc2V0Lg0KPiANCj4gTWFpbiBjaGFuZ2VzIHYyIC0tPiB2MzoNCj4gLSBSZWdhcmRp
bmcgTHVjYXMnIGNvbW1lbnRzLg0KPiDCoC0gdG8gaGF2ZSBhIHdob2xlIHZpZXcgdG8gcmV2aWV3
IHRoZSBwYXRjaGVzLCBzZW5kIG91dCB0aGUgaS5NWDhNTSBQQ0llIHN1cHBvcnQgdG9vLg0KPiDC
oC0gbW92ZSB0aGUgUEhZIHJlbGF0ZWQgYml0cyBtYW5pcHVsYXRpb25zIG9mIHRoZSBHUFIvU1JD
IHRvIHN0YW5kYWxvbmUgUEhZIGRyaXZlci4NCj4gwqAtIHNwbGl0IHRoZSBkdHMgY2hhbmdlcyB0
byBTT0MgYW5kIGJvYXJkIERULCBhbmQgdXNlIHRoZSBlbnVtIGluc3RlYWQgb2YgcmF3IHZhbHVl
Lg0KPiDCoC0gdXBkYXRlIHRoZSBsaWNlbnNlIG9mIHRoZSBkdC1iaW5kaW5nIGhlYWRlciBmaWxl
Lg0KPiANCj4gQ2hhbmdlcyB2MSAtLT4gdjI6DQo+IC0gVXBkYXRlIHRoZSBsaWNlbnNlIG9mIHRo
ZSBkdC1iaW5kaW5nIGhlYWRlciBmaWxlIHRvIG1ha2UgdGhlIGxpY2Vuc2UNCj4gwqAgY29tcGF0
aWJsZSB3aXRoIGR0cyBmaWxlcy4NCj4gLSBGaXggdGhlIGR0X2JpbmRpbmdfY2hlY2sgZXJyb3Jz
Lg0KPiANCj4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9mc2wsaW14NnEt
cGNpZS55YW1swqDCoMKgIHzCoMKgIDYgKysrDQo+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9waHkvZnNsLGlteDgtcGNpZS1waHkueWFtbCB8wqAgOTIgKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKw0KPiBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0t
ZXZrLmR0c2nCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDU1ICsrKysrKysrKysr
KysrKysrKysNCj4gYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLmR0c2nCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgNDYgKysrKysrKysrKysrKysr
LQ0KPiBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgODMgKysrKysrKysrKysrKysrKysr
KysrKysrKy0tLQ0KPiBkcml2ZXJzL3BoeS9mcmVlc2NhbGUvS2NvbmZpZ8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDgg
KysrDQo+IGRyaXZlcnMvcGh5L2ZyZWVzY2FsZS9NYWtlZmlsZcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAxICsNCj4gZHJp
dmVycy9waHkvZnJlZXNjYWxlL3BoeS1mc2wtaW14OG0tcGNpZS5jwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHwgMjM2DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+IGlu
Y2x1ZGUvZHQtYmluZGluZ3MvcGh5L3BoeS1pbXg4LXBjaWUuaMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMTQgKysrKysNCj4gOSBmaWxlcyBjaGFuZ2VkLCA1
MzIgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkNCj4gDQo+IFtQQVRDSCB2NyAxLzhdIGR0
LWJpbmRpbmdzOiBwaHk6IHBoeS1pbXg4LXBjaWU6IEFkZCBiaW5kaW5nIGZvciB0aGUNCj4gW1BB
VENIIHY3IDIvOF0gZHQtYmluZGluZ3M6IHBoeTogQWRkIGlteDggcGNpZSBwaHkgZHJpdmVyIHN1
cHBvcnQNCj4gW1BBVENIIHY3IDMvOF0gZHQtYmluZGluZ3M6IGlteDZxLXBjaWU6IEFkZCBQSFkg
cGhhbmRsZXMgYW5kIG5hbWUNCj4gW1BBVENIIHY3IDQvOF0gYXJtNjQ6IGR0czogaW14OG1tOiBB
ZGQgdGhlIHBjaWUgcGh5IHN1cHBvcnQNCj4gW1BBVENIIHY3IDUvOF0gcGh5OiBmcmVlc2NhbGU6
IHBjaWU6IEluaXRpYWxpemUgdGhlIGlteDggcGNpZQ0KPiBbUEFUQ0ggdjcgNi84XSBhcm02NDog
ZHRzOiBpbXg4bW06IEFkZCB0aGUgcGNpZSBzdXBwb3J0DQo+IFtQQVRDSCB2NyA3LzhdIGFybTY0
OiBkdHM6IGlteDhtbS1ldms6IEFkZCB0aGUgcGNpZSBzdXBwb3J0IG9uIGlteDhtbQ0KPiBbUEFU
Q0ggdjcgOC84XSBQQ0k6IGlteDogQWRkIHRoZSBpbXg4bW0gcGNpZSBzdXBwb3J0DQoNCldoYXQg
aXMgdGhlIHN0YXR1cyBvZiBwYXRjaGVzIDQsIDYgYW5kIDc/IFdoaWxlIHRoZSByZXN0IGhhcyBi
ZWVuIHB1bGxlZCB0aG9zZSBhcmUgc3RpbGwgbWlzc2luZyBpbiB0b2RheSdzIC0NCm5leHQuDQoN
CkNoZWVycw0KDQpNYXJjZWwNCg==
