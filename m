Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB95C403649
	for <lists+linux-pci@lfdr.de>; Wed,  8 Sep 2021 10:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348242AbhIHIsB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Sep 2021 04:48:01 -0400
Received: from mail-eopbgr60042.outbound.protection.outlook.com ([40.107.6.42]:41991
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348047AbhIHIsA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Sep 2021 04:48:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BO1SyngENH4Cdnx03fiUCiXzMHvHHeH86xjOzzgf9kChhS5+erOR0AAvc3mI8T2b3xf0RS2NNw/hLWkwcCEeroaTxN1Y2DdLAh2Qioog86y2RuHXfHu8AM4rfNIYmMuN9AvqAMamGzAhGB6qx+D5V7xcK6LGoXS6qcmCwLto/sA3xMV8c0WUeLyoyUohHX5NVvF6FgQIhj/vod+vPIUFEI7u5m6mH7MDhC61P/kj92XJkpmEgutpaeg5uX7nDkUdmc1Rz+1dYYgf4PDaKbRy5cQnHPie3cRT5qRyZVL8yfwYtZX/AT6ay8ix45VOU+7798uLhE0LbahbHD6GisW9vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=NjOjg9Iw+X32uVQa3+hmUvbdym3sk5WMUbupkTUO79o=;
 b=UCAW726uc2hnRqTMoMPI6E2slPbbbcQ2D9+J3obQJgfsOWiV/t9bjeyG/Dh3Ne+fpS9KU5JQwp9muahPET8S+x6Qs0/1dwMoxyHnKDPTqmKNsGVqTjS7a7yzkv6Y11kfHioGYyD1oZAW+2GLE1dYhvPtEFx/DD0M7L56nEoYMORYZVKFqqOPufyc8Egl8xE6oCsBtsHHyfsC+RHtFOrOSmrFEUi/sxNJtN86EEJyellKxHvl2Zlz1H4I60DCIMEXOlAe50iZk4L+GTiWiYzFCtMA2sk90E9zxae0GkEPF2aSXCo688kqE8QMgygScD1XWMChvKni3+CSGuxnPS0cOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NjOjg9Iw+X32uVQa3+hmUvbdym3sk5WMUbupkTUO79o=;
 b=h+0QZW/3B7b92+Eny0/bCAgKr9uvG9O/GZocefpidQCMV895LyKg23JqAHfCEefsYHh8JijuEmQdJ1yMvbDUTryUYueVuMEibppAx7+jJ6zLgJvQsyeaA+cpm6/i85XDjQPIpylZwgugI7b7r52jcLGVwN7nUggwBMZdHZLdcFg=
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com (2603:10a6:803:e3::25)
 by VI1PR04MB5855.eurprd04.prod.outlook.com (2603:10a6:803:de::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Wed, 8 Sep
 2021 08:46:47 +0000
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::f8b3:2cb9:4c85:9bef]) by VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::f8b3:2cb9:4c85:9bef%5]) with mapi id 15.20.4457.025; Wed, 8 Sep 2021
 08:46:47 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH 3/3] PCI: imx: add compliance tests mode to enable measure
 signal quality
Thread-Topic: [PATCH 3/3] PCI: imx: add compliance tests mode to enable
 measure signal quality
Thread-Index: AQHXpIJEdlbE9pM6qkCW8mNFWXLRm6uZz6GAgAACJjA=
Date:   Wed, 8 Sep 2021 08:46:47 +0000
Message-ID: <VI1PR04MB5853A0C4C064E51DCF58B71E8CD49@VI1PR04MB5853.eurprd04.prod.outlook.com>
References: <1631084366-24785-1-git-send-email-hongxing.zhu@nxp.com>
         <1631084366-24785-3-git-send-email-hongxing.zhu@nxp.com>
 <bd4ead76c27afbb3d089bc355d8d3f62b4ad269e.camel@pengutronix.de>
In-Reply-To: <bd4ead76c27afbb3d089bc355d8d3f62b4ad269e.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed0dde54-1f8b-42a3-51fd-08d972a5316d
x-ms-traffictypediagnostic: VI1PR04MB5855:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB5855F4072661BC0FDB7721938CD49@VI1PR04MB5855.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WJMRyCFYF076US5fzR+C0mlFZeT7kVWqBsU+YtGiYEi8h7IAoY5+sMCo+AClK0lzRaCsXChXnPjQUqxCe7XUMDdKK68NCANBm2vNfvPk1Yf3zPx513wjgZaavNjh6bjA52pzVmSrGBPTXNN1yEC/cbugiNzl90gD2MskEZj3vSvD5k+YIpcObXbkg+FUIU4AeYr64jTEhUFnitpX3hcsw0WaL/2KyIECUFpIuRyEEOFZb77xAq7rOFSL5c3mfn727ASY3xvFcRNdoal8R6QTlNCCHPMaKHUI5+DLxPbP/gnpnNG865zyqElXfzvCBwesgAJLy2P6a7vIoMV56iNU3Rlglfg8pLd4CuUE/pRl82MKAq+Wg2xWNhBVHXJv9bnbJbHXV3MzUKcW24dHY95tgQtgMj7ZJqvCIOQaluoLiOVQf9HLvpO5n6DFOmaMY23Fzd/iWRPO406RUeKZPNvR3n02gnz6r045ZR8V47r7Kr16hwNsRzwWUR/7BLsZpgv4OTj5UqHShiAQrWELZBSq/MREnsJkOmoL4LJhHahLJuoyog6ilBH5shUYP89OOWk3FPxv1EUlV9e6QdC8qnaZ9P78qBjnoGgxYKUQS/Yj71B+SH4k65up+kWgqjb+IvpDgNkKeI05nKoBlYO7m+A9oQ/+oDl2ceKSNwprvNDyLW6BJMdS2ns2ZBi8MWGE7OJdlAR+Cn9hZOHFyQIywB4/aQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5853.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(8936002)(4326008)(76116006)(52536014)(5660300002)(71200400001)(38070700005)(110136005)(7696005)(66476007)(66446008)(8676002)(64756008)(54906003)(66556008)(33656002)(86362001)(66946007)(2906002)(122000001)(38100700002)(9686003)(53546011)(478600001)(83380400001)(55016002)(316002)(26005)(186003)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWFqUkVlN3I3VVJDQ0JiVlZ2M2xhSmVxb3B3TktNMUNRWThCRzd6bGhEZGJS?=
 =?utf-8?B?Zml1dEFDUGgvWUVwdGQzVlJ4bk16ZERmYlhpaGROUklIZmc2bVFOK0xiMGI1?=
 =?utf-8?B?SlVVbjhkQ1JzY3BOVGpLSXRYWjh4cjFQUmYybjY4U3dtclFHelVwTTdjNmhU?=
 =?utf-8?B?VEk0VGI5WjdQZElRRkVMOHVUK2k0SG1SRlgzUmV4Wkx1K0FTVDlzakFvSjZN?=
 =?utf-8?B?aUVscEdnQjcwU3NUUngxcXdsRjZlTUlPV1N4UUlRTUR4OGtMWVpVZ09KcDAy?=
 =?utf-8?B?Q2NYSlNBMGp4K01GKzFIUGViUVdEa2M0TkQ3UDR6SC82S05IdWcrWlZyTGxj?=
 =?utf-8?B?elBMbnoyVzQ1bElBWTQySlV5YlBseWNoNkhVdmJGSG9EcDErTmhFa25sYUNp?=
 =?utf-8?B?Y0V3aTF1UHVkVGk5RzNPd1A1UklhOXJIcUtSd1h4aEJ3L3FrbkdUeUhoTjhJ?=
 =?utf-8?B?bWVwd1VGWE9lZ3g1dmZGb0pKbEE3Uy9YTzc1WTY1WDhBOXFuU21YcERSQ1hG?=
 =?utf-8?B?OWxDL2dxRWlBTDFNazRPalY4UkhkVFRqZG5JOTZyMElqcXk0MkJIMEpkK0pv?=
 =?utf-8?B?MlJ3YzM5RU04NnRoRDMzU2pJdnJYOVdFNVUvdkhQTVlDV280S0JvbkZSbXZk?=
 =?utf-8?B?OTAwcUplZDl2N1hRREgyNDVqd3d0ZWhjbnBGYnh2RWdqbWUyaDdCTnhPaFY2?=
 =?utf-8?B?VTU5QXhEQlBKRngyZkJ2WThtU0h5R2ZidENSTzMvdXR6L3M0b3VhTnRqWmZE?=
 =?utf-8?B?S2o0aHhhWWpZeG1uL1BBYW9JYkx4MzRDMmhKUkxQMXNoc0tUZklSb3d6UXpU?=
 =?utf-8?B?eFZtNEZRYVZ6ZGcxcmJXelNLb1JMTkx1WlpLZHVybVE1cTdGSEoycWdkdnVW?=
 =?utf-8?B?TThicTRSNDZBVlRYZmJ6Q2pSaVFsdS9NLzVnSWlhSmtvL1ZrY0dHVDltcTFh?=
 =?utf-8?B?WGF3SmFvSm5LdzhWZU5ZZ0ZyYUY3M2VNV2QwaHF3bk1TVVJyYy9XaHdiYjU0?=
 =?utf-8?B?eGozLy9GalNNZndNb3FCcWZGT3RxVm0wMi9HV1BKZFlUa0JsV0NXdUl2TXdk?=
 =?utf-8?B?YWdZU1FOZzhiSFpvNTRBa2F5NFF3WGNiZjVsOHh0M0FVdzdBaXJPQVN4UWFw?=
 =?utf-8?B?SXpYdjZBczBFbzZOUGcxOFI0SmhNZDdoVTNXRVFCd1VEQzJXNDczRW5BTndQ?=
 =?utf-8?B?WjhKRVhkbVFMR0JsRnJ3S0o5WDNUTmFPcUNWblY3NFhOYVgvQXduSkZmb3Ur?=
 =?utf-8?B?M3dtbDdzMUpIc2t1c2VvMGR5OVBWYkNGZjBmcFJhdG1qVS95U0ViRkJFZ1BF?=
 =?utf-8?B?dElEMmZadVQxMFNpOGE2eWJteks2VjdqZlFYMVdBVXNWbzdEcjhCaVRFS2Fa?=
 =?utf-8?B?MWlvd01wYmNoeE1mTTdiSTY3b2Q5TEJKTEZTWXYxZW1ndWVscmJlNzM1STBs?=
 =?utf-8?B?SUZUUzkraXhjK2FpSWIvTWo1RVE0Vk1CWUMybndkWkhmbDJaWkl3bGNsWDk4?=
 =?utf-8?B?TDNqbzJFeEtYcC9oNEFXbHlrY25DYzdhMktwdkEvMmorRCtocHRZenVaOUhN?=
 =?utf-8?B?NVRvVGlubHF5V3BpdWJXMVc3VFU5L0JlZXlXT3JTUDN0c3dYYmNibHBVQU1E?=
 =?utf-8?B?b0k1bHFhcFhBYjd3b21Sd1d4aVF1dHFGK1Z3TElxMU5pekgzb3d2Y2N4ZEUv?=
 =?utf-8?B?RzFJRERFWGw4RUdpR0haeFRXNnVXU042ZElqWHF3M3Z4M2M2elpLK00wWklt?=
 =?utf-8?Q?nuqTB1ArGQjUtyngZYAguo9rirpDMz8PhIi1JsV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5853.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed0dde54-1f8b-42a3-51fd-08d972a5316d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2021 08:46:47.2854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uzMqzjtQvR02RS3gof5umgZcWBBnEqizUnIZEAIn3GLBzVdtxATJl1EkIYucBTh77WJgeFSW9sdkw1VkB6EJ1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5855
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMdWNhcyBTdGFjaCA8bC5zdGFj
aEBwZW5ndXRyb25peC5kZT4NCj4gU2VudDogV2VkbmVzZGF5LCBTZXB0ZW1iZXIgOCwgMjAyMSA0
OjM0IFBNDQo+IFRvOiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+OyBiaGVsZ2Fh
c0Bnb29nbGUuY29tOw0KPiBsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tDQo+IENjOiBsaW51eC1w
Y2lAdmdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsNCj4g
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOw0KPiBrZXJuZWxAcGVuZ3V0cm9uaXguZGUNCj4gU3ViamVjdDogUmU6IFtQQVRD
SCAzLzNdIFBDSTogaW14OiBhZGQgY29tcGxpYW5jZSB0ZXN0cyBtb2RlIHRvIGVuYWJsZQ0KPiBt
ZWFzdXJlIHNpZ25hbCBxdWFsaXR5DQo+IA0KPiBIaSBSaWNoYXJkLA0KPiANCj4gQW0gTWl0dHdv
Y2gsIGRlbSAwOC4wOS4yMDIxIHVtIDE0OjU5ICswODAwIHNjaHJpZWIgUmljaGFyZCBaaHU6DQo+
ID4gUmVmZXIgdG8gdGhlIHN5c3RlbSBib2FyZCBzaWduYWwgUXVhbGl0eSBvZiBQQ0llIGFyY2hp
ZWN0dXJlIFBIWSB0ZXN0DQo+ID4gc3BlY2lmaWNhdGlvbi4gU2lnbmFsIHF1YWxpdHkgdGVzdHMg
Y2FuIGJlIGV4ZWN1dGVkIHdpdGggZGV2aWNlcyBpbg0KPiA+IHRoZSBwb2xsaW5nLmNvbXBsaWFu
Y2Ugc3RhdGUuDQo+ID4NCj4gPiBUbyBsZXQgdGhlIGRldmljZSBzdXBwb3J0IHBvbGxpbmcuY29t
cGxpYW5jZSBzdGF0LCB0aGUgY2xvY2tzIGFuZA0KPiA+IHBvd2VycyBzaG91bGRuJ3QgYmUgdHVy
bmVkIG9mZiBkdXJpbmcgdGhlIGNvbXBsaWFuY2UgdGVzdHMgYWx0aG91Z2gNCj4gPiB0aGUgUEhZ
IGxpbmsgbWlnaHQgYmUgZG93bi4NCj4gPiBBZGQgdGhlIGkuTVggUENJZSBjb21wbGlhbmNlIHRl
c3RzIG1vZGUgZW5hYmxlIG9wdGlvbiB0byBrZWVwIHRoZSBhbmQNCj4gPiBwb3dlcnMgb24sIGFu
ZCBmaW5pc2ggdGhlIGRyaXZlciBwcm9iZSB3aXRob3V0IGVycm9yIHJldHVybi4NCj4gPg0KPiA+
IFVzZSB0aGUgInBjaWVfY21wX2VuYWJsZWQ9eWVzIiBpbiBrZXJuZWwgY29tbWFuZCBsaW5lIHRv
IGVuYWJsZSB0aGUNCj4gPiBjb21wbGlhbmNlIHRlc3RzIG1vZGUuDQo+IA0KPiBBZGRpbmcgInJh
bmRvbSIga2VybmVsIGNvbW1hbmQgbGluZSBvcHRpb25zIGlzbid0IGdvaW5nIHRvIGZseS4gSWYg
YXQgYWxsLCB0aGlzDQo+IHNob3VsZCBiZSBhIG1vZHVsZV9wYXJhbSBzbyBpdCBnZXRzIHByb3Bl
cmx5IG5hbWVzcGFjZWQuIEFsc28gdGhpcyBuZWVkcyBhDQo+IG1vcmUgZGVzY3JpcHRpdmUgbmFt
ZSwgcmlnaHQgbm93IHRoaXMgaXMgYWJicmV2aWF0aW5nIHRoZSBvbmUgdGhpbmcgdGhhdCB3b3Vs
ZA0KPiB0ZWxsIGEgdXNlciB3aGF0IHRoaXMgaXMgYWJvdXQ6IGNvbXBsaWFuY2UgdGVzdGluZy4N
Cj4gDQpbUmljaGFyZCBaaHVdIFRoYW5rcyBhIGxvdCBmb3IgeW91ciByZXZpZXcgY29tbWVudHMu
DQpPa2F5LCBJIHdvdWxkIHVzZSB0aGUgbW9kdWxlX3BhcmFtIHJlcGxhY2UgdGhlIGNvbW1hbmQg
bGluZSBvcHRpb24uDQpBbmQgV291bGQgYWRkIG1vcmUgY29tcGxpYW5jZSB0ZXN0cyBkZXNjcmlw
dGlvbnMod2hhdCdzIGNvbXBsaWFuY2UgdXNlZCBmb3IsDQogYW5kIHRoZSBzaW1wbGUgc2NvcGUg
b2YgdGhlIHRlc3RzKSBsYXRlci4NCg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUmljaGFyZCBa
aHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3BjaS9jb250
cm9sbGVyL2R3Yy9wY2ktaW14Ni5jIHwgNDENCj4gPiArKysrKysrKysrKysrKysrKysrKystLS0t
LS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDMzIGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0p
DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlt
eDYuYw0KPiA+IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+IGlu
ZGV4IDEyOTkyOGU0MmY4NC4uM2FlZjBlODZmMWMyIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250
cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gQEAgLTE0Myw2ICsxNDMsNyBAQCBzdHJ1Y3QgaW14
Nl9wY2llIHsNCj4gPiAgI2RlZmluZSBQSFlfUlhfT1ZSRF9JTl9MT19SWF9EQVRBX0VOCQlCSVQo
NSkNCj4gPiAgI2RlZmluZSBQSFlfUlhfT1ZSRF9JTl9MT19SWF9QTExfRU4JCUJJVCgzKQ0KPiA+
DQo+ID4gK3N0YXRpYyBpbnQgaW14Nl9wY2llX2NtcF9lbmFibGVkOw0KPiA+ICBzdGF0aWMgaW50
IGlteDZfcGNpZV9jbGtfZW5hYmxlKHN0cnVjdCBpbXg2X3BjaWUgKmlteDZfcGNpZSk7ICBzdGF0
aWMNCj4gPiB2b2lkIGlteDZfcGNpZV9jbGtfZGlzYWJsZShzdHJ1Y3QgaW14Nl9wY2llICppbXg2
X3BjaWUpOw0KPiA+DQo+ID4gQEAgLTc0OCwxMCArNzQ5LDEyIEBAIHN0YXRpYyBpbnQgaW14Nl9w
Y2llX3N0YXJ0X2xpbmsoc3RydWN0IGR3X3BjaWUNCj4gKnBjaSkNCj4gPiAgCSAqIHN0YXJ0ZWQg
aW4gR2VuMiBtb2RlLCB0aGVyZSBpcyBhIHBvc3NpYmlsaXR5IHRoZSBkZXZpY2VzIG9uIHRoZQ0K
PiA+ICAJICogYnVzIHdpbGwgbm90IGJlIGRldGVjdGVkIGF0IGFsbC4gIFRoaXMgaGFwcGVucyB3
aXRoIFBDSWUgc3dpdGNoZXMuDQo+ID4gIAkgKi8NCj4gPiAtCXRtcCA9IGR3X3BjaWVfcmVhZGxf
ZGJpKHBjaSwgb2Zmc2V0ICsgUENJX0VYUF9MTktDQVApOw0KPiA+IC0JdG1wICY9IH5QQ0lfRVhQ
X0xOS0NBUF9TTFM7DQo+ID4gLQl0bXAgfD0gUENJX0VYUF9MTktDQVBfU0xTXzJfNUdCOw0KPiA+
IC0JZHdfcGNpZV93cml0ZWxfZGJpKHBjaSwgb2Zmc2V0ICsgUENJX0VYUF9MTktDQVAsIHRtcCk7
DQo+ID4gKwlpZiAoIWlteDZfcGNpZV9jbXBfZW5hYmxlZCkgew0KPiA+ICsJCXRtcCA9IGR3X3Bj
aWVfcmVhZGxfZGJpKHBjaSwgb2Zmc2V0ICsgUENJX0VYUF9MTktDQVApOw0KPiA+ICsJCXRtcCAm
PSB+UENJX0VYUF9MTktDQVBfU0xTOw0KPiA+ICsJCXRtcCB8PSBQQ0lfRVhQX0xOS0NBUF9TTFNf
Ml81R0I7DQo+ID4gKwkJZHdfcGNpZV93cml0ZWxfZGJpKHBjaSwgb2Zmc2V0ICsgUENJX0VYUF9M
TktDQVAsIHRtcCk7DQo+ID4gKwl9DQo+ID4NCj4gPiAgCS8qIFN0YXJ0IExUU1NNLiAqLw0KPiA+
ICAJaW14Nl9wY2llX2x0c3NtX2VuYWJsZShkZXYpOw0KPiA+IEBAIC04MTIsOSArODE1LDEyIEBA
IHN0YXRpYyBpbnQgaW14Nl9wY2llX3N0YXJ0X2xpbmsoc3RydWN0IGR3X3BjaWUNCj4gKnBjaSkN
Cj4gPiAgCQlkd19wY2llX3JlYWRsX2RiaShwY2ksIFBDSUVfUE9SVF9ERUJVRzApLA0KPiA+ICAJ
CWR3X3BjaWVfcmVhZGxfZGJpKHBjaSwgUENJRV9QT1JUX0RFQlVHMSkpOw0KPiA+ICAJaW14Nl9w
Y2llX3Jlc2V0X3BoeShpbXg2X3BjaWUpOw0KPiA+IC0JaW14Nl9wY2llX2Nsa19kaXNhYmxlKGlt
eDZfcGNpZSk7DQo+ID4gLQlpZiAoaW14Nl9wY2llLT52cGNpZSAmJiByZWd1bGF0b3JfaXNfZW5h
YmxlZChpbXg2X3BjaWUtPnZwY2llKSA+IDApDQo+ID4gLQkJcmVndWxhdG9yX2Rpc2FibGUoaW14
Nl9wY2llLT52cGNpZSk7DQo+ID4gKwlpZiAoIWlteDZfcGNpZV9jbXBfZW5hYmxlZCkgew0KPiA+
ICsJCWlteDZfcGNpZV9jbGtfZGlzYWJsZShpbXg2X3BjaWUpOw0KPiA+ICsJCWlmIChpbXg2X3Bj
aWUtPnZwY2llDQo+ID4gKwkJICAgICYmIHJlZ3VsYXRvcl9pc19lbmFibGVkKGlteDZfcGNpZS0+
dnBjaWUpID4gMCkNCj4gPiArCQkJcmVndWxhdG9yX2Rpc2FibGUoaW14Nl9wY2llLT52cGNpZSk7
DQo+ID4gKwl9DQo+ID4gIAlyZXR1cm4gcmV0Ow0KPiA+ICB9DQo+ID4NCj4gPiBAQCAtMTAxMCw2
ICsxMDE2LDE3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZGV2X3BtX29wcw0KPiBpbXg2X3BjaWVf
cG1fb3BzID0gew0KPiA+ICAJCQkJICAgICAgaW14Nl9wY2llX3Jlc3VtZV9ub2lycSkNCj4gPiAg
fTsNCj4gPg0KPiA+ICtzdGF0aWMgaW50IF9faW5pdCBpbXg2X3BjaWVfY29tcGxpYW5jZV90ZXN0
X2VuYWJsZShjaGFyICpzdHIpIHsNCj4gPiArCWlmICghc3RyY21wKHN0ciwgInllcyIpKSB7DQo+
ID4gKwkJcHJfaW5mbygiRW5hYmxlIHRoZSBpLk1YIFBDSWUgVFgvQ0xLIGNvbXBsaWFuY2UgdGVz
dHMgbW9kZS5cbiIpOw0KPiA+ICsJCWlteDZfcGNpZV9jbXBfZW5hYmxlZCA9IDE7DQo+ID4gKwl9
DQo+ID4gKwlyZXR1cm4gMTsNCj4gPiArfQ0KPiA+ICsNCj4gPiArX19zZXR1cCgicGNpZV9jbXBf
ZW5hYmxlZD0iLCBpbXg2X3BjaWVfY29tcGxpYW5jZV90ZXN0X2VuYWJsZSk7DQo+ID4gKw0KPiA+
ICBzdGF0aWMgaW50IGlteDZfcGNpZV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2
KSAgew0KPiA+ICAJc3RydWN0IGRldmljZSAqZGV2ID0gJnBkZXYtPmRldjsNCj4gPiBAQCAtMTE4
Nyw4ICsxMjA0LDE2IEBAIHN0YXRpYyBpbnQgaW14Nl9wY2llX3Byb2JlKHN0cnVjdA0KPiBwbGF0
Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gIAkJcmV0dXJuIHJldDsNCj4gPg0KPiA+ICAJcmV0ID0g
ZHdfcGNpZV9ob3N0X2luaXQoJnBjaS0+cHApOw0KPiA+IC0JaWYgKHJldCA8IDApDQo+ID4gKwlp
ZiAocmV0IDwgMCkgew0KPiA+ICsJCWlmIChpbXg2X3BjaWVfY21wX2VuYWJsZWQpIHsNCj4gPiAr
CQkJLyogVGhlIFBDSUUgY2xvY2tzIGFuZCBwb3dlcnMgd291bGRuJ3QgYmUgdHVybmVkIG9mZiAq
Lw0KPiA+ICsJCQlkZXZfaW5mbyhkZXYsICJUbyBkbyB0aGUgY29tcGxpYW5jZSB0ZXN0cy5cbiIp
Ow0KPiANCj4gVGhpcyBuZWVkcyBhIGJldHRlciBtZXNzYWdlLCBsaWtlICJEcml2ZXIgbG9hZGVk
IHdpdGggY29tcGxpYW5jZSB0ZXN0IG1vZGUNCj4gZW5hYmxlZCIgYW5kIHRoZSBtZXNzYWdlIG5l
ZWRzIHRvIGJlIHNob3duIHVuY29uZGl0aW9uYWxseSwgbm90IG9ubHkgd2hlbg0KPiB0aGUgaG9z
dCBpbml0IGZhaWxzLiBXZSBkb24ndCB3YW50IHRvIGhhdmUgdGhlIHVzZXIgdHJhY2sgZG93biB3
ZWlyZCBpc3N1ZXMNCj4gd2hlbiB0aGUgY29tcGxpYW5jZSB0ZXN0IG9wdGlvbiB3YXMgc3BlY2lm
aWVkIGJ5IGFjY2lkZW50IGFuZCB0aGUgbGluayBpcw0KPiBhbG1vc3Qgd29ya2luZyBkdWUgdG8g
dGhpcy4NCj4gDQpbUmljaGFyZCBaaHVdIFRoYW5rcy4gT2ssIGdvdCB0aGF0LCB3b3VsZCB1cGRh
dGUgdGhlIG1lc3NhZ2UgaW4gbmV4dCB2ZXJzaW9uLg0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQg
Wmh1DQoNCj4gUmVnYXJkcywNCj4gTHVjYXMNCj4gDQo+ID4gKwkJCXJldCA9IDA7DQo+ID4gKwkJ
fSBlbHNlIHsNCj4gPiArCQkJZGV2X2VycihkZXYsICJVbmFibGUgdG8gYWRkIHBjaWUgcG9ydC5c
biIpOw0KPiA+ICsJCX0NCj4gPiAgCQlyZXR1cm4gcmV0Ow0KPiA+ICsJfQ0KPiA+DQo+ID4gIAlp
ZiAocGNpX21zaV9lbmFibGVkKCkpIHsNCj4gPiAgCQl1OCBvZmZzZXQgPSBkd19wY2llX2ZpbmRf
Y2FwYWJpbGl0eShwY2ksIFBDSV9DQVBfSURfTVNJKTsNCj4gDQoNCg==
