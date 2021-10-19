Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCDA1432FC6
	for <lists+linux-pci@lfdr.de>; Tue, 19 Oct 2021 09:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234458AbhJSHls (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Oct 2021 03:41:48 -0400
Received: from mail-eopbgr150085.outbound.protection.outlook.com ([40.107.15.85]:55800
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229967AbhJSHls (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Oct 2021 03:41:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qjqv+rM6ElU0UWjXazDqWE5Y5np2leNLVn4rgvD4H33q0LHTuI3nTk0YwAuhkJ/BeNBtN0ZrzyT/u9fn8nPcD1qCmTbPkZjuaZO0P10Q0VPywwkkdAFUBy08gfw/u266LyudADRo0KkVHqKpNuiXXTAkrpxNOgcJyQIYVWxNZg+ycysNFkUd0H/G2EvSYOrXYbGivSzXprQCVLYOvGwRKdd97bAiBhcK98EQfXOSK+9/FjNkeg+gfZhr7Fb+BeGPyC4QowpLoCh9Bb/X6DcjBo9I7Eo3MpFo1IkpZwU15viMpwnx//B7nBN7rGeq2knTfnTh1ji6Pybi09Nt0JsCrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UReRh/hoHeiyYTsqbYLWo87tW5OUmXTwt5sEO3qqUhU=;
 b=ZxaluVU7dq7ivhcpqHOPtNZ6bZ9XWZ2Mj4txdJQaG9LVaGi+ZRl6wD8FR9DFZDWkoGbxLHpF805m8ewTIuKe/Cns5qyF17qs3JSPx/ch/iFhYgsNY9I7gTv15h6aQrVxwZl2y7rgKINDJabsVj5eaY5gFWFMCUzGhSUvvYJIgzZtIR0VTDm19ZB2e3G9vKETU9aF9H5nPJ5s1/xHOFM8RVak30ZV7lm+Zys3YmvmElVs+1req94HEvlW+M9AIQFuapuoc4pne8XIIpf9QCp+Zkejn0/AULtWmD3WdV3V6Zr50rG53vS1UzWbXDDFQYUC8cvKaIiLxqXYTwLTJ6YacA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UReRh/hoHeiyYTsqbYLWo87tW5OUmXTwt5sEO3qqUhU=;
 b=GjzO9JrreycUqyyD67A9l6/7hw4GWvDvc3y7r+r0Joxg9vLJlKYlGcwGeh7MbPqarZDvahPBsXaHZqRD+pTlwEhQds3GshqGpH7NOeLJwfP1IEctpoGeScKlJLfLZFhsc8lDvwTp4buT3oQC9zthfws5fywb3IoJ6Lw8HyZsXoY=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8914.eurprd04.prod.outlook.com (2603:10a6:20b:42d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Tue, 19 Oct
 2021 07:39:34 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc%4]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 07:39:33 +0000
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
Subject: RE: [RESEND v2 3/5] PCI: imx6: Fix the regulator dump when link never
 came up
Thread-Topic: [RESEND v2 3/5] PCI: imx6: Fix the regulator dump when link
 never came up
Thread-Index: AQHXwY4tcTr8p7Uwa0qomeYelO+fgavUYCcAgAWT+PA=
Date:   Tue, 19 Oct 2021 07:39:33 +0000
Message-ID: <AS8PR04MB8676CC1AFB9399776F75156F8CBD9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1634277941-6672-1-git-send-email-hongxing.zhu@nxp.com>
         <1634277941-6672-4-git-send-email-hongxing.zhu@nxp.com>
 <8f855cf445e2b7827524d5d4adfba80d3a924c60.camel@pengutronix.de>
In-Reply-To: <8f855cf445e2b7827524d5d4adfba80d3a924c60.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9f6681c0-f418-4f3c-01f5-08d992d3983d
x-ms-traffictypediagnostic: AS8PR04MB8914:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AS8PR04MB891438881ED918977F0148028CBD9@AS8PR04MB8914.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HePAryzDCFpaEOHfgRa2Y5EYjVeLxeu5TbVPkv5VN7FHDAjB4MF5YTJ6H4nqkoAwKBnhauYMXWCVXA1EUJz21SHUr3QT2XAvExjl5dGcWCjqYxXrvIIGULzldWiyOK+HyWDLfTVf42GqxWEp8Rny+A+0D1Ziuz0XeZNU2+G55qmSuv4j+dAWsIzbl6d+U98gl60CXSHFbAEBophIY5c/g7ayWJqQJCNa2bf76Ckz4tKp7nuXL1TDuECfNzx9PAUoFco2t80ZjcRk64o83MXfVeLWkc83sCd071PDZlzfQMkFoJ6WsO956eFuAQTmPFJPQ5ENdKbqCI8TmDloMxq1YkTDgOah5ZigEtlg3NGjXYQFTsCfXaUiECTJ1j7PpeNWOstufvOdMrpbjOcHpH5YjpUIJOgdImL6lWEfV0R4hW837DhoT5TtOYB9kijuEb4g3o2aDU/lq9I3OzQR3AletyU2F+5bDBDudT7u+Ps9J1QVttHNeof1WhQ2IzFeI8n3hua9eaubZBSOZ7cz/MLCmBJ41ByynkC1zwjdh8LBjjZOPo4dHPnrP0jER/1XL25Pbf6B/o4LVlwKNwW4cF/uqUkeH9gCUamQI9TfyvEfuYSGqOA2lRBV+8FQHlcvNyabV1aXuhd6YfOsu9M0yIfx9tRxfJtpDQSodhkGe4HJqEIBUfMRsX2H1BdJzp81JEX/OXPNhUD69YiS7O9UWSdMlQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(66476007)(66556008)(66946007)(66446008)(45080400002)(76116006)(5660300002)(71200400001)(83380400001)(86362001)(54906003)(52536014)(7696005)(55016002)(53546011)(38100700002)(38070700005)(6506007)(9686003)(33656002)(26005)(64756008)(8936002)(110136005)(8676002)(122000001)(2906002)(316002)(508600001)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0FVZnBob3pQcXI4U0YvR3JPcFpjcnhwUjNjaWpoMEtnQjBaYW1lM3hUT0RI?=
 =?utf-8?B?WVBTeFhZbnpnYUVOTGVVN3JMcnl1Wkk0VWNrYUlFMTdUejZnYmNnMjZybFp4?=
 =?utf-8?B?c0x0UDZ4dXRHS21NWU11LzA0M0tTMDh6NWhoaHhrREhKZ0JncFNrRnRXaDF0?=
 =?utf-8?B?d0VDOUcwOUJRMUFTc0xYTjFWK2N2bE51S2dQNGppOE0ybmt3L2hCdFhkVEhO?=
 =?utf-8?B?RWRCT3hqaGdObEk3eC9uaVhnSW0zYWNjdThLSEhUTTRkaDhUZ25PbDVFekc3?=
 =?utf-8?B?WGNWR013ZEFEc1pFeFFCaTVLQTB5bjUyWFhoRGxxSnNTY3dlamJpYnYyZE1Z?=
 =?utf-8?B?M0FENlgydnRBbW82WGo0SXoraHIrQ01hMi8wZDFvanY4VXJqLyt3ekdxOTJp?=
 =?utf-8?B?N1RKdlBUQW8yUVkrQmxHZnU2cVpKTlJFc1lkQkRNcUFnU1RzbDFrd1plekVH?=
 =?utf-8?B?M0FLUEtDZmdJOUI0NjlvallKelY5eFl5bkFhNUVLcXhJRWlyNzVhUUdldnJP?=
 =?utf-8?B?WUN4Qjd6L2RudXlsS3c5NTdLSVZhVWs0MkR2VGd5cGNndEcrU21YYTQyQ3Mz?=
 =?utf-8?B?bnR6QTBGci9haWg4K1B3YkU0dGRpRHc0S0tCTktkUklydWRDTUMvZWx6Lzd1?=
 =?utf-8?B?MUZlSG5kSFZtdzlaNzlLZFdyRGU2djZmcytNVFdIK2daTGNRaXBGL3lRaFdi?=
 =?utf-8?B?NVF1QWlnSHFNZlVJeXdhQ1lRODUwZmFxWDEwamc2YzdUZzN5NVI3YXFNVmZP?=
 =?utf-8?B?OC9SZmErQ0xiQ0xxN0Vlc3lKWWlWR05HTWNSNUNaa3UwOFAxNjF3R09TVHN5?=
 =?utf-8?B?R1ZqaUdnSkRQM2JDRzQ5NXJGOCtYRWtIK2hMb01PUFVNYSsvTkZXK0FtY1BG?=
 =?utf-8?B?alNJZDJVOUZUN3JNWmFISHlNVmpaRlZYZVhpaStzYlU0YTF2emJrR3ZBNEI4?=
 =?utf-8?B?OVZ5R3lhcWc4amVaNW4zbit2N1EvQWVRRFVWMURDZmxwd0FRMGVCZHhQNXdV?=
 =?utf-8?B?T285RGh6ZlFFbGs5MHJHbDNUVmtzOVNtd20wbll1Y3pNcWsyZFFhVUlEVHA4?=
 =?utf-8?B?TENFa2RiclQxK3RrMFIwOE5JcWhWM1BZZWZ3dENmTFBhaStkUG9KZHBTWmpJ?=
 =?utf-8?B?allpL3BCaUhUWTFMMklUSWdWNHBaSERTY1pUUDlLeGFYUWFGMys4UTN4RUMy?=
 =?utf-8?B?ekFkVXN4Si9iL3VPamxMZTBwclVXNm1kU1dRY1FVU2VnejNOSWUzamY4U3lZ?=
 =?utf-8?B?c2Z5WmJ3L3V4VndpbW1pbjZQN3NRdW1kdTFIZ1RjdXNCQlZZRERzT1dKdVN4?=
 =?utf-8?B?NUdETFc0TmU5emdXc0RCUGNsWFNFd2I0Zjh1OXN4dFpIaW9sRzRVWlR2NDlF?=
 =?utf-8?B?dmdSY2pPUTQ2Y1dtUTY2ZEhUejJvNDZ2N2JxWkQyRk9tcHFlMkdzaUlUNS9G?=
 =?utf-8?B?V0xaRmhmQmd1eXZ2MTZxaXdPejFidFp4Ym11cnd4MXNPdUNPcmYrb2MyNEZV?=
 =?utf-8?B?RGMvNDJnTlRNTklzQ0ExcWhnMGpYMzFUN1d2Mk40Z3ZzZitoYkJGSjYxbStX?=
 =?utf-8?B?dUNYRFRVbFpyWWI5SW4zQWZFaDlvUzNrU3RkOEFWUXRaVDRtR2R2QTUxTGNB?=
 =?utf-8?B?dFpnYzFteWZoK0d5UzFuWkZmL1A1RncvbWxpSm1lMk9CUWp0MGIvS1NEWllw?=
 =?utf-8?B?ZXEzTjQrUHFra045SnZsZ1FtVXZrdWQza0xyVXpCUmJ1NXZEcHJEWm93Tldo?=
 =?utf-8?Q?D3OmVENxRvN04h29WJ5puN4JXQ5gmNBpQRtPatz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f6681c0-f418-4f3c-01f5-08d992d3983d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2021 07:39:33.8271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Fx0xL6zpaCi2M0SSDDxEOF92XBp8qw2H+r8zCZCjD3nHNT9qnkfItK6/FPbPK4fMtvuNmmh5zjPsM2VhW+WsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8914
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMdWNhcyBTdGFjaCA8bC5zdGFj
aEBwZW5ndXRyb25peC5kZT4NCj4gU2VudDogU2F0dXJkYXksIE9jdG9iZXIgMTYsIDIwMjEgMjoy
MyBBTQ0KPiBUbzogUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPjsgYmhlbGdhYXNA
Z29vZ2xlLmNvbTsNCj4gbG9yZW56by5waWVyYWxpc2lAYXJtLmNvbQ0KPiBDYzogbGludXgtcGNp
QHZnZXIua2VybmVsLm9yZzsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47DQo+IGxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsNCj4ga2VybmVsQHBlbmd1dHJvbml4LmRlDQo+IFN1YmplY3Q6IFJlOiBbUkVTRU5E
IHYyIDMvNV0gUENJOiBpbXg2OiBGaXggdGhlIHJlZ3VsYXRvciBkdW1wIHdoZW4gbGluaw0KPiBu
ZXZlciBjYW1lIHVwDQo+IA0KPiBBbSBGcmVpdGFnLCBkZW0gMTUuMTAuMjAyMSB1bSAxNDowNSAr
MDgwMCBzY2hyaWViIFJpY2hhcmQgWmh1Og0KPiA+IFdoZW4gUENJZSBQSFkgbGluayBuZXZlciBj
YW1lIHVwIGFuZCB2cGNpZSByZWd1bGF0b3IgaXMgcHJlc2VudCwgdGhlcmUNCj4gPiB3b3VsZCBi
ZSBmb2xsb3dpbmcgZHVtcCB3aGVuIHRyeSB0byBwdXQgdGhlIHJlZ3VsYXRvci4NCj4gPiBEaXNh
YmxlIHRoaXMgcmVndWxhdG9yIHRvIGZpeCB0aGlzIGR1bXAgd2hlbiBsaW5rIG5ldmVyIGNhbWUg
dXAuDQo+ID4NCj4gPiAgIGlteDZxLXBjaWUgMzM4MDAwMDAucGNpZTogUGh5IGxpbmsgbmV2ZXIg
Y2FtZSB1cA0KPiA+ICAgaW14NnEtcGNpZTogcHJvYmUgb2YgMzM4MDAwMDAucGNpZSBmYWlsZWQg
d2l0aCBlcnJvciAtMTEwDQo+ID4gICAtLS0tLS0tLS0tLS1bIGN1dCBoZXJlIF0tLS0tLS0tLS0t
LS0NCj4gPiAgIFdBUk5JTkc6IENQVTogMyBQSUQ6IDExOSBhdCBkcml2ZXJzL3JlZ3VsYXRvci9j
b3JlLmM6MjI1Ng0KPiBfcmVndWxhdG9yX3B1dC5wYXJ0LjArMHgxNGMvMHgxNTgNCj4gPiAgIE1v
ZHVsZXMgbGlua2VkIGluOg0KPiA+ICAgQ1BVOiAzIFBJRDogMTE5IENvbW06IGt3b3JrZXIvdTg6
MiBOb3QgdGFpbnRlZA0KPiA1LjEzLjAtcmM3LW5leHQtMjAyMTA2MjUtOTQ3MTAtZ2U0ZTkyYjI1
ODhhMyAjMTANCj4gPiAgIEhhcmR3YXJlIG5hbWU6IEZTTCBpLk1YOE1NIEVWSyBib2FyZCAoRFQp
DQo+ID4gICBXb3JrcXVldWU6IGV2ZW50c191bmJvdW5kIGFzeW5jX3J1bl9lbnRyeV9mbg0KPiA+
ICAgcHN0YXRlOiA4MDAwMDAwNSAoTnpjdiBkYWlmIC1QQU4gLVVBTyAtVENPIEJUWVBFPS0tKQ0K
PiA+ICAgcGMgOiBfcmVndWxhdG9yX3B1dC5wYXJ0LjArMHgxNGMvMHgxNTgNCj4gPiAgIGxyIDog
cmVndWxhdG9yX3B1dCsweDM0LzB4NDgNCj4gPiAgIHNwIDogZmZmZjgwMDAxMjJlYmIzMA0KPiA+
ICAgeDI5OiBmZmZmODAwMDEyMmViYjMwIHgyODogZmZmZjgwMDAxMWJlNzAwMCB4Mjc6IDAwMDAw
MDAwMDAwMDAwMDANCj4gPiAgIHgyNjogMDAwMDAwMDAwMDAwMDAwMCB4MjU6IDAwMDAwMDAwMDAw
MDAwMDAgeDI0OiBmZmZmMDAwMDAwMjVmMmJjDQo+ID4gICB4MjM6IGZmZmYwMDAwMDAyNWYyYzAg
eDIyOiBmZmZmMDAwMDAwMjVmMDEwIHgyMTogZmZmZjgwMDAxMjJlYmMxOA0KPiA+ICAgeDIwOiBm
ZmZmODAwMDExZTNmYTYwIHgxOTogZmZmZjAwMDAwMzc1ZmQ4MCB4MTg6IDAwMDAwMDAwMDAwMDAw
MTANCj4gPiAgIHgxNzogMDAwMDAwMDQwMDQ0ZmZmZiB4MTY6IDAwNDAwMDMyYjU1MDM1MTAgeDE1
Og0KPiAwMDAwMDAwMDAwMDAwMTA4DQo+ID4gICB4MTQ6IGZmZmYwMDAwMDAzY2M5MzggeDEzOiAw
MDAwMDAwMGZmZmZmZmVhIHgxMjogMDAwMDAwMDAwMDAwMDAwMA0KPiA+ICAgeDExOiAwMDAwMDAw
MDAwMDAwMDAwIHgxMDogZmZmZjgwMDAxMDc2YmE4OCB4OSA6IGZmZmY4MDAwMTA3NmE1NDANCj4g
PiAgIHg4IDogZmZmZjAwMDAwMDI1ZjJjMCB4NyA6IGZmZmYwMDAwMDAxZjQ0NTAgeDYgOiBmZmZm
MDAwMDAwMTc2Y2Q4DQo+ID4gICB4NSA6IGZmZmYwMDAwMDM4NTc4ODAgeDQgOiAwMDAwMDAwMDAw
MDAwMDAwIHgzIDogZmZmZjgwMDAxMWUzZmUzMA0KPiA+ICAgeDIgOiBmZmZmMDAwMDAwM2NjNGMw
IHgxIDogMDAwMDAwMDAwMDAwMDAwMCB4MCA6IDAwMDAwMDAwMDAwMDAwMDENCj4gPiAgIENhbGwg
dHJhY2U6DQo+ID4gICAgX3JlZ3VsYXRvcl9wdXQucGFydC4wKzB4MTRjLzB4MTU4DQo+ID4gICAg
cmVndWxhdG9yX3B1dCsweDM0LzB4NDgNCj4gPiAgICBkZXZtX3JlZ3VsYXRvcl9yZWxlYXNlKzB4
MTAvMHgxOA0KPiA+ICAgIHJlbGVhc2Vfbm9kZXMrMHgzOC8weDYwDQo+ID4gICAgZGV2cmVzX3Jl
bGVhc2VfYWxsKzB4ODgvMHhkMA0KPiA+ICAgIHJlYWxseV9wcm9iZSsweGQwLzB4MmU4DQo+ID4g
ICAgX19kcml2ZXJfcHJvYmVfZGV2aWNlKzB4NzQvMHhkOA0KPiA+ICAgIGRyaXZlcl9wcm9iZV9k
ZXZpY2UrMHg3Yy8weDEwOA0KPiA+ICAgIF9fZGV2aWNlX2F0dGFjaF9kcml2ZXIrMHg4Yy8weGQw
DQo+ID4gICAgYnVzX2Zvcl9lYWNoX2RydisweDc0LzB4YzANCj4gPiAgICBfX2RldmljZV9hdHRh
Y2hfYXN5bmNfaGVscGVyKzB4YjQvMHhkOA0KPiA+ICAgIGFzeW5jX3J1bl9lbnRyeV9mbisweDMw
LzB4MTAwDQo+ID4gICAgcHJvY2Vzc19vbmVfd29yaysweDE5Yy8weDMyMA0KPiA+ICAgIHdvcmtl
cl90aHJlYWQrMHg0OC8weDQxOA0KPiA+ICAgIGt0aHJlYWQrMHgxNGMvMHgxNTgNCj4gPiAgICBy
ZXRfZnJvbV9mb3JrKzB4MTAvMHgxOA0KPiA+ICAgLS0tWyBlbmQgdHJhY2UgMzY2NGNhNGE1MGNl
ODQ5YiBdLS0tDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcu
emh1QG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3Bj
aS1pbXg2LmMgfCAyICsrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5j
DQo+ID4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gaW5kZXgg
MzM3Mjc3NTgzNGEyLi5jYzgzN2Y4YmY2ZDQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kv
Y29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xs
ZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiBAQCAtODUzLDYgKzg1Myw4IEBAIHN0YXRpYyBpbnQgaW14
Nl9wY2llX3N0YXJ0X2xpbmsoc3RydWN0IGR3X3BjaWUgKnBjaSkNCj4gPiAgCQlkd19wY2llX3Jl
YWRsX2RiaShwY2ksIFBDSUVfUE9SVF9ERUJVRzApLA0KPiA+ICAJCWR3X3BjaWVfcmVhZGxfZGJp
KHBjaSwgUENJRV9QT1JUX0RFQlVHMSkpOw0KPiA+ICAJaW14Nl9wY2llX3Jlc2V0X3BoeShpbXg2
X3BjaWUpOw0KPiA+ICsJaWYgKGlteDZfcGNpZS0+dnBjaWUgJiYgcmVndWxhdG9yX2lzX2VuYWJs
ZWQoaW14Nl9wY2llLT52cGNpZSkgPiAwKQ0KPiA+ICsJCXJlZ3VsYXRvcl9kaXNhYmxlKGlteDZf
cGNpZS0+dnBjaWUpOw0KPiANCj4gVGhpcyBkb2Vzbid0IHNlZW0gbGlrZSB0aGUgcmlnaHQgcGxh
Y2UgdG8gYWRkIHRoaXMuIEkgZ3Vlc3MgaXQgd291bGQgYmUgYmV0dGVyIHRvDQo+IGhhdmUgcHJv
cGVyIGVycm9yIGhhbmRsaW5nIGFmdGVyIGR3X3BjaWVfaG9zdF9pbml0IHRvIHJvbGwgYmFjayB0
aGluZ3MgbGlrZSB0aGUNCj4gY2xvY2sgYW5kIHJlZ3VsYXRvciBlbmFibGUuDQpbUmljaGFyZCBa
aHVdIFRoaXMgaXMgZ29vZCBzdWdnZXN0aW9uLiBJdCdzIG1ha2Ugc2Vuc2UgdGhhdCBtb3ZlIHRo
ZSByZWd1bGF0b3IgZGlzYWJsZSB0byB0aGUNCmR3X3BjaWVfaG9zdF9pbml0IGVycm9yIGhhbmRs
aW5nIHNpbmNlIHRoZSByZWd1bGF0b3IgaGF2ZSB0aGUgZW5hYmxlZCBjaGVjaywgYmVmb3JlIHRv
IGRpc2FibGUgaXQuDQpCdXQgaXQgc2VlbXMgdGhhdCB0aGVyZSBhcmUgc29tZSBwb3RlbnRpYWwg
cHJvYmxlbXMgd2hlbiBkbyB0aGUgc2ltaWxhciBvcGVyYXRpb25zIHRvIHRoZSBjbG9ja3MgZGlz
YWJsZSBoZXJlLg0KQmVjYXVzZSB0aGF0IHRoZSBkd19wY2llX2hvc3RfaW5pdCBtaWdodCBoYXZl
IHNvbWUgZXJyb3IgcmV0dXJucyB3aGVuIHRoZSBob3N0X2luaXQgaXMgbm90IGludm9rZWQgYXQg
YWxsLg0KSG93IHRvIGhhbmRsZSB0aGlzIHNpdHVhdGlvbiBhbHRob3VnaCB0aGlzIGlzIG9uZSBj
b3JuZXIgY2FzZT8NCg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0KPiANCj4gUmVnYXJkcywN
Cj4gTHVjYXMNCj4gDQo+ID4gIAlyZXR1cm4gcmV0Ow0KPiA+ICB9DQo+ID4NCj4gDQoNCg==
