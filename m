Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22EAF320279
	for <lists+linux-pci@lfdr.de>; Sat, 20 Feb 2021 02:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbhBTB2B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Feb 2021 20:28:01 -0500
Received: from mail-db8eur05on2061.outbound.protection.outlook.com ([40.107.20.61]:36192
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229725AbhBTB2A (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Feb 2021 20:28:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c9NtGo0CaR0jSmy1W2ZSfUsS5n5+6+WRqIoOP5dUWuaabV7AQzgnNZjHeSuHx1LbscVRPnVxLRpko2p7IzT8tkNFkB/G1j/RQMnSotTln5jwP95Ket+pYlyQKpZSYZCWwiSwZB395hnUkMY/3/1n5gr8syntRaLac4mS29I7YeZVco2fz39paLpufkL/DqYxGNom3ON5wbybHvnMCIL1jxHz+2I8F82xwF7sMTA50TQTbOvX/d83XCp/O38ITVWE0RuiK8NOsZ8Fal2g2RDIGbQRKJWrTqRPpWpx+nPVIKKSt0YHx0QwzYQCpkW2ZU3k02quRwqaMzt2XWsCSQzi6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqV0UOWCpRfUtqqSnA/7xtNFxU7S4SD7aHXDOubIO+I=;
 b=HIFIkVQSDGL6F+Eqlzl5Z8a0EWLvvoyrlB0SqMU6MVmnhJCk8RkqKsHUkLKtH+dtGnf34LNTpQL551eckbMA5an0hAVAS7Y163RENY+rK/31BKYITfIaF08xxShIoeX4Oc9f+PHXpve0fnUo/SOm8nutonbwX5t/TXmziO40/5vWSJ+lHdrYPj0oWVG4uGAw503CgKPKJXsSeTQPh/vwYXuvkQUUXvYXFu+L1E9pCFPjlzGbuSHN63CDfpfRoqbwE4WdFNjjkfUsHv7Al4h90KE3ZQNFEA4MYpOVAGGiDgrOn6Ft5qdMxcdIbJjglcZphd4T+RzN5AMUVkvQab4Lhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqV0UOWCpRfUtqqSnA/7xtNFxU7S4SD7aHXDOubIO+I=;
 b=nEcop+j0YCLaGhtOjhI7yKXE3ZL/wzOXIoYMwQgyCIjltvwwkNqHBIHQr97VZoyDRKSOUJC8D66sVRHEKDioMSe4aymU7Lu4dHMirJjDQQ2xCL+LmuucVC/Ut0k/Db36Jzi5NCo82yApAvIbLGM1ivHDLimmU2db0AH7SBFWIVc=
Received: from AM6PR04MB5848.eurprd04.prod.outlook.com (2603:10a6:20b:a8::19)
 by AS8PR04MB7702.eurprd04.prod.outlook.com (2603:10a6:20b:23f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Sat, 20 Feb
 2021 01:27:11 +0000
Received: from AM6PR04MB5848.eurprd04.prod.outlook.com
 ([fe80::199b:f05:83f6:965b]) by AM6PR04MB5848.eurprd04.prod.outlook.com
 ([fe80::199b:f05:83f6:965b%7]) with mapi id 15.20.3846.041; Sat, 20 Feb 2021
 01:27:11 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kw@linux.com>
CC:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [EXT] Re: [PATCH] PCI: imx6: Limit DBI register length for imx6qp
 pcie
Thread-Topic: [EXT] Re: [PATCH] PCI: imx6: Limit DBI register length for
 imx6qp pcie
Thread-Index: AQHXBbX7ZIfH2pDTD0qeydZ4yz41Eqpdzl6AgABeuICAAhZGcA==
Date:   Sat, 20 Feb 2021 01:27:11 +0000
Message-ID: <AM6PR04MB5848D5D763FF8EA0CAC9EC868C839@AM6PR04MB5848.eurprd04.prod.outlook.com>
References: <1613624980-29382-1-git-send-email-hongxing.zhu@nxp.com>
 <YC5VmRTIylDHSFPt@rocinante> <YC6lDYG13DhIppmW@rocinante>
In-Reply-To: <YC6lDYG13DhIppmW@rocinante>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.com; dkim=none (message not signed)
 header.d=none;linux.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c5ade57e-471a-457d-753b-08d8d53ea594
x-ms-traffictypediagnostic: AS8PR04MB7702:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AS8PR04MB77025F27286D80D10962E3208C839@AS8PR04MB7702.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KapBiDSUMcgz7PyQxzXWa9Yk0hvXAUJk2YpUrlbxUY3JhNf6KfV4FVo6PTCd18WSaEVOfXrG9KSNHEKz52MIAD2dhEqluc3PTyqWnCzyOPv7YzUBWMzH78/GH4KL+4CVtnyEl9jgDRXUiCsR4AyUWZlIZukE9bkxpwxPCmdzMfpQeHIOgV0KByTJ1xamOsHllRjSxs226ycd6RglvVF8y9fYZxawxEhxA+cNEZd8g8cPLYAZYr4+LMdaegXCbWelDc7CBAcMu5a+eKAWxSLke5EFc1facpXYyTLiLeQQdnLDZ0R3TwVzEeuKr167NGBjBox2kHJFw379MmsPsRLr6ap6SaZrvWHk+WQMSiLkGmlkMcBHe6Hfkv+zsMVwybLi+4/GPGsRXJhFSjdyYjjS4OZfW+ufZZvs071amWelbxuJVSMQZyVZOqctTXpR9XliW0qr7JYvFEtp7y+IrS26A2VdmxETOF6rqrlSSLMSFTktbMACOD922v30OKpBgozVr1HOyAVgvimBxjW58TganKe7DNALMDXUaNHbfFLYfepisd16VAbM/pa2heqK+hT2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5848.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(396003)(39860400002)(376002)(5660300002)(66476007)(66556008)(64756008)(66446008)(52536014)(76116006)(66946007)(54906003)(316002)(33656002)(6506007)(53546011)(55016002)(83380400001)(8936002)(9686003)(71200400001)(86362001)(7696005)(2906002)(186003)(66574015)(4326008)(478600001)(26005)(8676002)(6916009)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?YXdadnp5ZTVXM1EyZmQvMGZ2LzA3MWJGRHo0Rk5HektQdkhKQnBWZFFubFdE?=
 =?utf-8?B?TzQ3eTFOYjNjSXhxOFNjSjlDQ3AvSFZMd3JoQ0RLaTRKUnZseFZjdTZBL1Zy?=
 =?utf-8?B?cXhidm5TdUt4L1dtaGNjbmhReXMza0orTUZ4Rm00c0hyTCtxTzhQZGNDREov?=
 =?utf-8?B?Z1llWmNNUWUyK2ZKQkZDMCtFL3k3dVFLOEtsQUZDOWFqeklOOWFSVWptNmNY?=
 =?utf-8?B?OVRKeFFnOUwzaWVuNS9CZndFbkVnSmljdDZnV0UyZWRrSFdoVWJqaG13RlZK?=
 =?utf-8?B?dmtKcWVnUXZ4M2IrMGZpNGR3Q2t6STRPN3JhLzc3WDk0R2twcjRQY3JOUDA5?=
 =?utf-8?B?dkJEYkE4VDJrWDhUeWdnWmF2RHo1elRTRXZ4OGhMVldSUXJ1WnJ4bTdLMU5Q?=
 =?utf-8?B?V2VlYWhBUnBUMFp2OFZnb0hmYWZ3dHRKK3pxblZqQjY0TkxZZzBTOHd6TnN1?=
 =?utf-8?B?MTYrWE1HQzlIUHlFNE1UdDUxWmdScWw5aGpxRmZXYVovL1hGdytwQlhlREV2?=
 =?utf-8?B?SlN5Q096cFU1S3hTVlhZcDRsVEdRNVVKUTJ6ZUJXRVoybzAzY1pPMDdYZzBn?=
 =?utf-8?B?TDhTVTVSbmkwZzgvaFUrVWk0ZVRNODR4MUNyeHcwU1dQeDNabkNtdDJzR3lT?=
 =?utf-8?B?bVcwNS9WZ0tsQ09ta3VBc1hGOC95Z1BQWE9EZm1ic2t5dzJOQ29xY1ZhdlZ2?=
 =?utf-8?B?a1ZXWkZTcXdlVDk3c05iVnErYnowTmwwbjN1Q0RleVJvY1VUZFU3REhYUFFB?=
 =?utf-8?B?Y293d25iN1g3OWM5UVB4dm85WWxEeUxaSkorT2NXWEZmdVdYaXM2Uk9qOVBi?=
 =?utf-8?B?NTlFQ1pienNqWU41SUNMTlJ6VDg1cEJ3REpmR1lRc2VSTGtuOStodjdjUEps?=
 =?utf-8?B?MEhZSjU0S3liZHYyblptM3ljVFF2RmRsd1FQWDNDSi9PblAwNUV0ZkFZV0Iy?=
 =?utf-8?B?RGgwQzlPK1QxSFh4SzFYL2l6M1VWR0pzT0MzbXN0MThnZm1GazcvMGhGWWFW?=
 =?utf-8?B?cnZqUjJoK01sdGVrcnNaNy9GMVdWVjh1NEUreE1LWFpUV1FLN0RLaUNPNVgv?=
 =?utf-8?B?b25HTCtkQ21JUWV3T0ZadHBkRzJqZnp5bFdaYVFNcDBmNGtxbnhET0FyVU40?=
 =?utf-8?B?THd2YWNHRDl3ZHhPY2YyMG94MEo1K0wvRVJnRG94UXFNQUZLTXplTFR4NnVu?=
 =?utf-8?B?djhsOWpHRXNhZTR5OFY4K0hhODVkKzlUVHEyb3JSTklpYzhNVE1ESUFMSmg5?=
 =?utf-8?B?c0YxTXgzRCtDNEt2b2dVbUoyOUNxUFZ5MHQxQ0QzcERPZ3BRMTViekdzVHlZ?=
 =?utf-8?B?VGluL0R3RlM4TkU0UjNWZlEyK0JwdVQ4OFVWUi9HSHhpVUkwZXdlbDdoQnNi?=
 =?utf-8?B?VDNsY0xjaENzOG04Y3JEWkRXMWVWd0NLVVppR00yc3hGUjdXdjcvcTQrVDJD?=
 =?utf-8?B?VEFzSGc2SERLbHlub2xCRXk4dkRTb3RyRTRoMDJLUExFNTZGRkhtYytzQ0pS?=
 =?utf-8?B?SC81UktRZTVFajRTdDJqQmEveFAyNVhBcFVSK3ZNNGg4T1B3eitORDBWelE2?=
 =?utf-8?B?NFIzRmhWYUg0RWp6NFhkNGx2cjhYQ3hDQTNISDcrd3dWSUxTMjRhZ21HZ2dK?=
 =?utf-8?B?eEIvS3FXTExqTmM1cXpMNlRNRWhtZEJrRnBtNnBaaEduam1IUE5jWitjc2pL?=
 =?utf-8?B?NTZCWmZoZCtSMXlubzUyV3MvN3dkaVZEcGVleFowMUI3c29TU2c3QWJBTDEx?=
 =?utf-8?Q?YJ7z8GOtUbkv+U3AM2kmowzspww+3TBH3vu4hNr?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5848.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5ade57e-471a-457d-753b-08d8d53ea594
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2021 01:27:11.4244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vJMQmDMUu/tU1XoTjJS+y5E7/kjtkigtgj8xEYfOF7UDrX6Pc1WjcqC02I1c5vyH9++sVwnp33k3O5frtf141g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7702
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEtyenlzenRvZiBXaWxjennF
hHNraSA8a3dAbGludXguY29tPg0KPiBTZW50OiBGcmlkYXksIEZlYnJ1YXJ5IDE5LCAyMDIxIDE6
MzQgQU0NCj4gVG86IFJpY2hhcmQgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IGwu
c3RhY2hAcGVuZ3V0cm9uaXguZGU7IGhlbGdhYXNAa2VybmVsLm9yZzsgc3RlZmFuQGFnbmVyLmNo
Ow0KPiBsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tOyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3Jn
OyBkbC1saW51eC1pbXgNCj4gPGxpbnV4LWlteEBueHAuY29tPjsgbGludXgtYXJtLWtlcm5lbEBs
aXN0cy5pbmZyYWRlYWQub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBrZXJu
ZWxAcGVuZ3V0cm9uaXguZGUNCj4gU3ViamVjdDogW0VYVF0gUmU6IFtQQVRDSF0gUENJOiBpbXg2
OiBMaW1pdCBEQkkgcmVnaXN0ZXIgbGVuZ3RoIGZvciBpbXg2cXAgcGNpZQ0KPiBbLi4uXQ0KPiA+
ID4gUmVmZXIgdG8gY29tbWl0IDA3NWFmNjFjMTljZCAoIlBDSTogaW14NjogTGltaXQgREJJIHJl
Z2lzdGVyDQo+ID4gPiBsZW5ndGgiKSwgaS5NWDZRUCBQQ0llIGhhcyB0aGUgc2ltaWxhciBpc3N1
ZS4NCj4gPiA+IERlZmluZSB0aGUgbGVuZ3RoIG9mIHRoZSBEQkkgcmVnaXN0ZXJzIGFuZCBsaW1p
dCBjb25maWcgc3BhY2UgdG8gaXRzDQo+ID4gPiBsZW5ndGggZm9yIGkuTVg2UVAgUENJZSB0b28u
DQo+ID4NCj4gPiBZb3UgY291bGQgcHJvYmFibHkgZmxpcCB0aGVzZSB0d28gc2VudGVuY2VzIGFy
b3VuZCB0byBtYWtlIHRoZSBjb21taXQNCj4gPiBtZXNzYWdlIHJlYWQgc2xpZ2h0bHkgYmV0dGVy
LCBzbyB3aGF0IGFib3V0IHRoaXMgKGEgc3VnZ2VzdGlvbik6DQo+ID4NCj4gPiBEZWZpbmUgdGhl
IGxlbmd0aCBvZiB0aGUgREJJIHJlZ2lzdGVycyBhbmQgbGltaXQgY29uZmlnIHNwYWNlIHRvIGl0
cw0KPiA+IGxlbmd0aC4gVGhpcyBtYWtlcyBzdXJlIHRoYXQgdGhlIGtlcm5lbCBkb2VzIG5vdCBh
Y2Nlc3MgcmVnaXN0ZXJzDQo+ID4gYmV5b25kIHRoYXQgcG9pbnQgdGhhdCBvdGhlcndpc2Ugd291
bGQgbGVhZCB0byBhbiBhYm9ydCBvbiBhIGkuTVgNCj4gNlF1YWRQbHVzLg0KPiA+DQo+ID4gU2Vl
IGNvbW1pdCAwNzVhZjYxYzE5Y2QgKCJQQ0k6IGlteDY6IExpbWl0IERCSSByZWdpc3RlciBsZW5n
dGgiKSB0aGF0DQo+ID4gcmVzb2x2ZXMgYSBzaW1pbGFyIGlzc3VlIG9uIGEgaS5NWCA2UXVhZCBQ
Q0llLg0KPiBbLi4uXQ0KPiANCj4gSWYgeW91IGRvIGRlY2lkZSB0byBzZW5kIGFub3RoZXIgdmVy
c2lvbiwgdGhlbiBhbHNvIHVzZSAiUENJZSIgaW4gdGhlIHN1YmplY3QsDQo+IHJhdGhlciB0aGFu
ICJwY2llIi4gIEkgZm9yZ290IHRvIG1lbnRpb24gdGhpcyBpbiB0aGUgcHJldmlvdXMgbWVzc2Fn
ZSwNCj4gYXBvbG9naWVzLg0KPiANCltSaWNoYXJkIFpodV0gTmV2ZXIgbWluZC4gVGhhbmtzIGEg
bG90IGZvciB5b3VyIGNvbW1lbnRzLg0KV291bGQgaXNzdWUgYW5vdGhlciB2ZXJzaW9uIGEgbW9t
ZW50IGxhdGVyLg0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQoNCj4gS3J6eXN6dG9mDQo=
