Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 404104330DD
	for <lists+linux-pci@lfdr.de>; Tue, 19 Oct 2021 10:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbhJSIOp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Oct 2021 04:14:45 -0400
Received: from mail-eopbgr150080.outbound.protection.outlook.com ([40.107.15.80]:43141
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231758AbhJSIOp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Oct 2021 04:14:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AJLY0NpJiHgSEkW3ag9I/cSStQG7vwArgW8QyAKvr7D+uIyHrqVVUA5uMBwYbhmzvlL+s3iivhtcm3xGQ/SgpNzEvEqKkd4YryPTiuTZ59yq5bPH76ie+s8w5ve+q0H9BDvtY9ltFVdqOjC3b9RQC7LyiZVfGC9R9pV9vho3iaDXKJAkK3p+vgU2oOlI1x/zQ2aHXnrDnLSqSBL1F/FlX3jZe4pTOQGTo96VLMVhuUWPaownti0dUVzy5Se20PlLEh3Gu7mY6t9Nre0RWddCzB6YUkznwebaEZEuvcBw1wJDbqbnuli3DpnMUixkLdriCM7ThCSVdbnxrATkgR4R5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1S/ZGOtQZ60mLbhmY6/nTvEtFqYCrp3ys8IrpQTZKg=;
 b=ogkVPG/SscvsRTU4IPYkjWWyOJsdI0vH5eyhaWb3rpU/gQJ/xUJxqQASZJdHXIwejj9QOcC9bQatFQ/03Xcd9rIeAuRAY/ya3mYxWMEE0dJbZFU6ocptrZrzDNxkuF5Pl7rMNSASHSK9ZK1V73Y/uiOGAZbki3JsIzZrJQsYA+vjlpOgLydNxDshb+X9IBGsFzfCBskyESOtGFmRd46OQ3eNJIQVJr9SUK++9ab8Wru6nlk7x7lyGLDD+aqW8YD4Rv7vM9oLU/IdUiKhbLT2cVd7hHRyztiunivnbt69e06Y9BUZoKwDMNci1kmctQXXoRX8vjWpkA0h1W7OeYnIXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1S/ZGOtQZ60mLbhmY6/nTvEtFqYCrp3ys8IrpQTZKg=;
 b=Q29zerwUScRGJ41IdPXMmnL430gqX2sqaVtnxILQMDTKKERE9uZqWhCbbUN3ClF/s8Lb/fsI02BhAAxtvscwqQNXhhcI2XXobzn6HXzqMBD7pLwCq3YwyAgwK4uovaSCt8PiM5hRHajlczn5eE/yh0032TIm/Y6h3+9OxP/C0e0=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8436.eurprd04.prod.outlook.com (2603:10a6:20b:347::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Tue, 19 Oct
 2021 08:12:30 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc%4]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 08:12:30 +0000
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
Subject: RE: [RESEND v2 5/5] PCI: imx6: Add the compliance tests mode support
Thread-Topic: [RESEND v2 5/5] PCI: imx6: Add the compliance tests mode support
Thread-Index: AQHXwY4wgyFzpFI0cEKio4xhVLYB7qvUYd2AgAWcudA=
Date:   Tue, 19 Oct 2021 08:12:30 +0000
Message-ID: <AS8PR04MB8676DD2A48EC96B8C2D31DAC8CBD9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1634277941-6672-1-git-send-email-hongxing.zhu@nxp.com>
         <1634277941-6672-6-git-send-email-hongxing.zhu@nxp.com>
 <52a13aa3b7798d0cb77d45b20993f5494c91f014.camel@pengutronix.de>
In-Reply-To: <52a13aa3b7798d0cb77d45b20993f5494c91f014.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7422ec5d-0f6f-432a-d67d-08d992d8322d
x-ms-traffictypediagnostic: AS8PR04MB8436:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AS8PR04MB84363D8996B7DB744059A6E88CBD9@AS8PR04MB8436.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M//R9VV8STrQ1icn9RF16Jate/iVGUiRvRTmaM1AEhqIcZ4CelKLgB/LJkdKqQcl88OAUYFzwxP8gIiKe8WgiOr3D1OBZgorokmm5S2HHMnZ/5tDWrWhA1oYg7BN7PdRM0AZ9rt69J5PS1AsLsXx2RLt6VYlWvxs+Zr3gobc8giEo97muZOXn8UJjHiR6mJO684DkuxQZ2koXI6spDa4rEygFYOIEmwFLix/sic6uxh6E156h2DU2+efmMIkyKlmBAjyh//9j9+tFvPBZ1Mw6CXRfx0OjIlxbAxMZQ90ZUS7WKJaCrSs5xMbpy6vJFo5yac8yzC2hM806AKfSqzXA6S1WCBRqoCQoq6PLwOOhUjSeqC2wtgCAdEZIufxd9yXT5txOKXJhRNSU7XTtQjxumBCBFS2ERpkO5WTUu6FTxBHUqy6BX1aLZi1EJt04O8erulL9dqG0s/2qmDlngbCEDfAavTq9Lb4diDQerUGnuVAMkh8fmARjusJzGet2ObPiuB5E7BWM7VHuOwe/MELtveyPqB4dukMvzmwyksB1ZRvmUCSZ8PsfVRDJwRaZrLl7Rv7JJR4pfzOzPaIjcpDxDK9Dehz6XoyjaCOWHEGBjNlJMGMqKTxXpAoz2zLj5G1G5L90hLE68SB+s+hm9dQGvCl1UtfLuWyzRikOSMdl5TWE+E0dS40KMKeancku+cCnGnAHhKtlPVIDHPogQajLA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(26005)(186003)(4326008)(64756008)(55016002)(54906003)(71200400001)(5660300002)(122000001)(38100700002)(53546011)(6506007)(33656002)(7696005)(8936002)(66946007)(86362001)(83380400001)(76116006)(8676002)(66446008)(66556008)(66476007)(9686003)(52536014)(2906002)(110136005)(38070700005)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bktzSnRFblF6b3huNjdRR05tenhRRitJSzdsK2Y5MVdyU1JQUVdnWDM2ajNl?=
 =?utf-8?B?SjlyMmw5NUNCalA0RVdLcm12NjFQa2xWZ2ZscktCZHFpNWFnYTdVYWpCZDFw?=
 =?utf-8?B?dzdnVVBVaDNJYWxNMXJudk5JOHhnQ3ExVzJpQWZBWmpHN3RZTzdreEcyOGEw?=
 =?utf-8?B?c0dGbnN3elZmVTdRRy9vS0JlTENJdlBPZ2ZQUkQwQ2h0VUF0dC93NmYwUWR0?=
 =?utf-8?B?VHVYekpibXRKT2d2M1dhT1M1L1lXTDZhTzB0dkU5MVBrK0tkZUdnbXFqTmpv?=
 =?utf-8?B?ZGxLSzlwT3ord1BGaGJEVFEzY3dCSFd0dGs2WFJvY1BJd1FrWEVlNWp2L1Z3?=
 =?utf-8?B?dStNVS9aOGozR0Roa1JiczQ1eGlzR2JtMTlWQy9XSFQ3K1BXME8xMHBYazFD?=
 =?utf-8?B?a0RCeGpXU3IyNjA2V1E4cmZpVzFqZ0tPZzF6amdwMXdQRnNsV1dxMUVBc3lQ?=
 =?utf-8?B?MENITW5tK0hMK2xrbHZpK09NcjNZOFp2QnNvc0c1OWpZaTVIZEFNSE1KaHJH?=
 =?utf-8?B?YzJ6b2ZmTzdEWWFaTFV4VzRYNHozSHloVW42WkxLRElrRTllZkRUZWpPU3M3?=
 =?utf-8?B?Y0c1ZDRZbHQ3cnNHRXJFL0o4dnd5WHhKNzJPeTJrYy96NkRreFFZc3QwUy96?=
 =?utf-8?B?OUxPVDl1eWYyYmtFd2Z6TDQyT1BJeDh4bXRuZzQ4MWhEVE1VdTZrZE5PMmVo?=
 =?utf-8?B?d1ZRVGY2MUdGajR0c3hyQjNHL2Fna01RQXdJQ0EvNVB6MDhDWG9qZGF2V2RI?=
 =?utf-8?B?SnAwcW1TZkc2M0lWRlpRS1lyWGgyV0RYYVJFbVpmVUhndDFDaHpEYnFVWHRB?=
 =?utf-8?B?TlhHNGFnRGw2NWxzd1l4R3hUeW9sTjFxcjJIM3B3VnEvRW5HUnVxNWNqTkpG?=
 =?utf-8?B?TUJZOWRLSjJiRHZvVDFwYXpBRmRQVnBrS3NmL2NxWlFYL2xEREJML3JPTStV?=
 =?utf-8?B?T3pBcFpueU5ocXlmRFNXWUVVMmNhTTQwb0VzaEZzc1ZxZHRBWTRjUjRRM1M2?=
 =?utf-8?B?dGpyaURKdnZkU2dKUzYzNDV3NDFMcHFYRW5ObU5CUnBsM1plUHZmb0l6NzVv?=
 =?utf-8?B?S2NJUDQ3OHdYLzQ2b0ZUS1p0NyttSGhRV0lQd291VkJ3bVlxZVFidW11V2E1?=
 =?utf-8?B?eVZBM0h5aVFET2gyZkZncmFxTDdUV256dnRvRExtSVFlUGo1b2lydmhJZ1Bi?=
 =?utf-8?B?UG1YL2k4R1JMSjcrd2dpRi9xVzZSYVQvZjg5MHFMOXU5bUlmYUpXOG9nczMw?=
 =?utf-8?B?ZVJ4ZS9BSUl6dURXelNTUGlqMjh4U3o0R3E0SThmQ1BwZllOZkRLMnhrRkFG?=
 =?utf-8?B?eXpHY1FYMWRrMDRtVmJqdlNuNXEzQldxVWxLa1BaNlhJYTN2SjFObVJOZDZ1?=
 =?utf-8?B?QlhNSjJoQ2pKUEwxYU5yUmxIWEZOS2FWNTl6b1MwMHRQQkhzd09zR1pnSC9R?=
 =?utf-8?B?ZlFSNFY1aC9hcTNlR0hkU2tQbzFPRnJFUkxYNUNBb2o1NDZ5N1VteTZQZEZU?=
 =?utf-8?B?V09ncWtqNVlRNVVscGNNT29JWjU3RnNOVkpUdFhrVVl0NzR0UWhMUGx2RlY1?=
 =?utf-8?B?Uk0rYXNNS3BwejlML01lVUMyRkFiODg3eEVBSTVaVFI2eWxtbUFOZHNtSkpF?=
 =?utf-8?B?Y1VYQVJPLzBTSUFoZUZFTUJwbzRDT1BPYkRXN24zVmg0bnVrVUEyMVRHZTBj?=
 =?utf-8?B?a3pNWFlZR2NxeW5Uczd2Wm4vcEZvWTJwVlYzT0FVc2NFRGJDaXdlcTlOaEJj?=
 =?utf-8?Q?1X7FodVgrrTHbRwntPUTtQzEuCytCLIkSAmXKVI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7422ec5d-0f6f-432a-d67d-08d992d8322d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2021 08:12:30.1474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V8O7b6+JZT535uF68ETfv8RhaBe28GawsqSkc4Z6ykav+M1a0EWG4beeUQDdW0DIdRbqbLt0f7RsG7Q7fSq0fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8436
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMdWNhcyBTdGFjaCA8bC5zdGFj
aEBwZW5ndXRyb25peC5kZT4NCj4gU2VudDogU2F0dXJkYXksIE9jdG9iZXIgMTYsIDIwMjEgMjoy
OSBBTQ0KPiBUbzogUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPjsgYmhlbGdhYXNA
Z29vZ2xlLmNvbTsNCj4gbG9yZW56by5waWVyYWxpc2lAYXJtLmNvbQ0KPiBDYzogbGludXgtcGNp
QHZnZXIua2VybmVsLm9yZzsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47DQo+IGxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsNCj4ga2VybmVsQHBlbmd1dHJvbml4LmRlDQo+IFN1YmplY3Q6IFJlOiBbUkVTRU5E
IHYyIDUvNV0gUENJOiBpbXg2OiBBZGQgdGhlIGNvbXBsaWFuY2UgdGVzdHMgbW9kZQ0KPiBzdXBw
b3J0DQo+IA0KPiBBbSBGcmVpdGFnLCBkZW0gMTUuMTAuMjAyMSB1bSAxNDowNSArMDgwMCBzY2hy
aWViIFJpY2hhcmQgWmh1Og0KPiA+IFJlZmVyIHRvIHRoZSBzeXN0ZW0gYm9hcmQgc2lnbmFsIFF1
YWxpdHkgb2YgUENJZSBhcmNoaWVjdHVyZSBQSFkgdGVzdA0KPiA+IHNwZWNpZmljYXRpb24uIFNp
Z25hbCBxdWFsaXR5IHRlc3RzKGZvciBleGFtcGxlOiBqaXR0ZXJzLA0KPiA+IGRpZmZlcmVudGlh
bCBleWUgb3BlbmluZyBhbmQgc28gb24gKSBjYW4gYmUgZXhlY3V0ZWQgd2l0aCBkZXZpY2VzIGlu
DQo+ID4gdGhlIHBvbGxpbmcuY29tcGxpYW5jZSBzdGF0ZS4NCj4gPg0KPiA+IFRvIGxldCB0aGUg
ZGV2aWNlIHN1cHBvcnQgcG9sbGluZy5jb21wbGlhbmNlIHN0YXQsIHRoZSBjbG9ja3MgYW5kDQo+
ID4gcG93ZXJzIHNob3VsZG4ndCBiZSB0dXJuZWQgb2ZmIHdoZW4gdGhlIHByb2JlIG9mIGRldmlj
ZSBkcml2ZXIgaXMgZmFpbGVkLg0KPiA+DQo+ID4gQmFzZWQgb24gQ0xCKENvbXBsaWFuY2UgTG9h
ZCBCb2FyZCkgVGVzdCBGaXh0dXJlIGFuZCBzbyBvbiB0ZXN0DQo+ID4gZXF1aXBtZW50cywgdGhl
IFBIWSBsaW5rIHdvdWxkIGJlIGRvd24gZHVyaW5nIHRoZSBjb21wbGlhbmNlIHRlc3RzLg0KPiA+
IFJlZmVyIHRvIHRoaXMgc2NlbmFyaW8sIGFkZCB0aGUgaS5NWCBQQ0llIGNvbXBsaWFuY2UgdGVz
dHMgbW9kZSBlbmFibGUNCj4gPiBzdXBwb3J0LCBhbmQga2VlcCB0aGUgY2xvY2tzIGFuZCBwb3dl
cnMgb24sIGFuZCBmaW5pc2ggdGhlIGRyaXZlcg0KPiA+IHByb2JlIHdpdGhvdXQgZXJyb3IgcmV0
dXJuLg0KPiA+DQo+ID4gVXNlIHRoZSAicGNpX2lteDYuY29tcGxpYW5jZT0xIiBpbiBrZXJuZWwg
Y29tbWFuZCBsaW5lIHRvIGVuYWJsZSB0aGUNCj4gPiBjb21wbGlhbmNlIHRlc3RzIG1vZGUuDQo+
ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+
DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMgfCAz
Mg0KPiA+ICsrKysrKysrKysrKysrKysrKysrLS0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwg
MjQgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gYi9kcml2ZXJzL3BjaS9j
b250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gaW5kZXggZDZhNWQ5OWZmYTUyLi5lODYxYTUx
NmQ1MTcgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlt
eDYuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4g
PiBAQCAtMTQzLDYgKzE0MywxMCBAQCBzdHJ1Y3QgaW14Nl9wY2llIHsNCj4gPiAgI2RlZmluZSBQ
SFlfUlhfT1ZSRF9JTl9MT19SWF9EQVRBX0VOCQlCSVQoNSkNCj4gPiAgI2RlZmluZSBQSFlfUlhf
T1ZSRF9JTl9MT19SWF9QTExfRU4JCUJJVCgzKQ0KPiA+DQo+ID4gK3N0YXRpYyBib29sIGlteDZf
cGNpZV9jbXBfbW9kZTsNCj4gPiArbW9kdWxlX3BhcmFtX25hbWVkKGNvbXBsaWFuY2UsIGlteDZf
cGNpZV9jbXBfbW9kZSwgYm9vbCwgMDY0NCk7DQo+ID4gK01PRFVMRV9QQVJNX0RFU0MoY29tcGxp
YW5jZSwgImkuTVggUENJZSBjb21wbGlhbmNlIHRlc3QgbW9kZQ0KPiA+ICsoMT1jb21wbGlhbmNl
IHRlc3QgbW9kZSBlbmFibGVkKSIpOw0KPiA+ICsNCj4gPiAgc3RhdGljIGludCBwY2llX3BoeV9w
b2xsX2FjayhzdHJ1Y3QgaW14Nl9wY2llICppbXg2X3BjaWUsIGJvb2wNCj4gPiBleHBfdmFsKSAg
ew0KPiA+ICAJc3RydWN0IGR3X3BjaWUgKnBjaSA9IGlteDZfcGNpZS0+cGNpOyBAQCAtODEyLDEw
ICs4MTYsMTIgQEAgc3RhdGljDQo+ID4gaW50IGlteDZfcGNpZV9zdGFydF9saW5rKHN0cnVjdCBk
d19wY2llICpwY2kpDQo+ID4gIAkgKiBzdGFydGVkIGluIEdlbjIgbW9kZSwgdGhlcmUgaXMgYSBw
b3NzaWJpbGl0eSB0aGUgZGV2aWNlcyBvbiB0aGUNCj4gPiAgCSAqIGJ1cyB3aWxsIG5vdCBiZSBk
ZXRlY3RlZCBhdCBhbGwuICBUaGlzIGhhcHBlbnMgd2l0aCBQQ0llIHN3aXRjaGVzLg0KPiA+ICAJ
ICovDQo+ID4gLQl0bXAgPSBkd19wY2llX3JlYWRsX2RiaShwY2ksIG9mZnNldCArIFBDSV9FWFBf
TE5LQ0FQKTsNCj4gPiAtCXRtcCAmPSB+UENJX0VYUF9MTktDQVBfU0xTOw0KPiA+IC0JdG1wIHw9
IFBDSV9FWFBfTE5LQ0FQX1NMU18yXzVHQjsNCj4gPiAtCWR3X3BjaWVfd3JpdGVsX2RiaShwY2ks
IG9mZnNldCArIFBDSV9FWFBfTE5LQ0FQLCB0bXApOw0KPiA+ICsJaWYgKCFpbXg2X3BjaWVfY21w
X21vZGUpIHsNCj4gPiArCQl0bXAgPSBkd19wY2llX3JlYWRsX2RiaShwY2ksIG9mZnNldCArIFBD
SV9FWFBfTE5LQ0FQKTsNCj4gPiArCQl0bXAgJj0gflBDSV9FWFBfTE5LQ0FQX1NMUzsNCj4gPiAr
CQl0bXAgfD0gUENJX0VYUF9MTktDQVBfU0xTXzJfNUdCOw0KPiA+ICsJCWR3X3BjaWVfd3JpdGVs
X2RiaShwY2ksIG9mZnNldCArIFBDSV9FWFBfTE5LQ0FQLCB0bXApOw0KPiA+ICsJfQ0KPiA+DQo+
ID4gIAkvKiBTdGFydCBMVFNTTS4gKi8NCj4gPiAgCWlteDZfcGNpZV9sdHNzbV9lbmFibGUoZGV2
KTsNCj4gPiBAQCAtODc2LDkgKzg4MiwxMiBAQCBzdGF0aWMgaW50IGlteDZfcGNpZV9zdGFydF9s
aW5rKHN0cnVjdCBkd19wY2llDQo+ICpwY2kpDQo+ID4gIAkJZHdfcGNpZV9yZWFkbF9kYmkocGNp
LCBQQ0lFX1BPUlRfREVCVUcwKSwNCj4gPiAgCQlkd19wY2llX3JlYWRsX2RiaShwY2ksIFBDSUVf
UE9SVF9ERUJVRzEpKTsNCj4gPiAgCWlteDZfcGNpZV9yZXNldF9waHkoaW14Nl9wY2llKTsNCj4g
DQo+IElzIGl0IGNvcnJlY3QgdG8gcmVzZXQgdGhlIFBIWSBoZXJlIHdoZW4gaW4gY29tcGxpYW5j
ZSB0ZXN0IG1vZGU/DQpbUmljaGFyZCBaaHVdIEl0IGRvZXNuJ3QgbWF0dGVyLiBQSFkgcmVzZXQg
anVzdCBsZXQgdGhlIFBIWSBlbnRlciBpbnRvIGEgZGVkaWNhdGVkIHN0YXQgYWZ0ZXIgbGluayBp
cyBkb3duLg0KVGhpcyB3b3VsZG4ndCBpbXBhY3QgdGhlIGNvbXBsaWFuY2UgdGVzdHMgbW9kZSBs
YXRlci4NCg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0KDQo+IA0KPiA+IC0JaW14Nl9wY2ll
X2Nsa19kaXNhYmxlKGlteDZfcGNpZSk7DQo+ID4gLQlpZiAoaW14Nl9wY2llLT52cGNpZSAmJiBy
ZWd1bGF0b3JfaXNfZW5hYmxlZChpbXg2X3BjaWUtPnZwY2llKSA+IDApDQo+ID4gLQkJcmVndWxh
dG9yX2Rpc2FibGUoaW14Nl9wY2llLT52cGNpZSk7DQo+ID4gKwlpZiAoIWlteDZfcGNpZV9jbXBf
bW9kZSkgew0KPiA+ICsJCWlteDZfcGNpZV9jbGtfZGlzYWJsZShpbXg2X3BjaWUpOw0KPiA+ICsJ
CWlmIChpbXg2X3BjaWUtPnZwY2llDQo+ID4gKwkJICAgICYmIHJlZ3VsYXRvcl9pc19lbmFibGVk
KGlteDZfcGNpZS0+dnBjaWUpID4gMCkNCj4gPiArCQkJcmVndWxhdG9yX2Rpc2FibGUoaW14Nl9w
Y2llLT52cGNpZSk7DQo+ID4gKwl9DQo+ID4gIAlyZXR1cm4gcmV0Ow0KPiA+ICB9DQo+ID4NCj4g
PiBAQCAtMTE4Myw4ICsxMTkyLDE1IEBAIHN0YXRpYyBpbnQgaW14Nl9wY2llX3Byb2JlKHN0cnVj
dA0KPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gIAkJcmV0dXJuIHJldDsNCj4gPg0KPiA+
ICAJcmV0ID0gZHdfcGNpZV9ob3N0X2luaXQoJnBjaS0+cHApOw0KPiA+IC0JaWYgKHJldCA8IDAp
DQo+ID4gKwlpZiAocmV0IDwgMCkgew0KPiA+ICsJCWlmIChpbXg2X3BjaWVfY21wX21vZGUpIHsN
Cj4gPiArCQkJZGV2X2luZm8oZGV2LCAiRHJpdmVyIGxvYWRlZCB3aXRoIGNvbXBsaWFuY2UgdGVz
dCBtb2RlDQo+IGVuYWJsZWQuXG4iKTsNCj4gPiArCQkJcmV0ID0gMDsNCj4gPiArCQl9IGVsc2Ug
ew0KPiA+ICsJCQlkZXZfZXJyKGRldiwgIlVuYWJsZSB0byBhZGQgcGNpZSBwb3J0LlxuIik7DQo+
ID4gKwkJfQ0KPiA+ICAJCXJldHVybiByZXQ7DQo+ID4gKwl9DQo+ID4NCj4gPiAgCWlmIChwY2lf
bXNpX2VuYWJsZWQoKSkgew0KPiA+ICAJCXU4IG9mZnNldCA9IGR3X3BjaWVfZmluZF9jYXBhYmls
aXR5KHBjaSwgUENJX0NBUF9JRF9NU0kpOw0KPiANCg0K
