Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F06164659E3
	for <lists+linux-pci@lfdr.de>; Thu,  2 Dec 2021 00:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353795AbhLAXiQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Dec 2021 18:38:16 -0500
Received: from mail-eopbgr150071.outbound.protection.outlook.com ([40.107.15.71]:13994
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1343755AbhLAXiO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 Dec 2021 18:38:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aK76Cl8ToFiC/NJy23WI6syzgQ/9f/G1qVw623c5TzBZJOk5XH+lsFSOYHXlShnikB6BaGnxW462xTpJCbqRWpNXfdJyLW5e8dX/mkBqeeCC7Q31Hv0MxL3KdFRQEnRBvIgkbliFwkofl25hJZW7nirTseFyqN3pEkcjDMvjRSotK4oOKKbvyDxFBlHZJXhi3A4Xia62oS8YPiBXbcqtSonxm1yZBWDN6nwa6ZQSERCGGlnS0eFl5pEVALcz96LnGhszy2c0ITo86IU+n90subxOxI9kBDGCXVWgb+zMdYaC/4V2IuFRj/nJ2P+4V2bpk/IUGPovZdXkrtjxriPwuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FcW03BH/zECu90BYcNp1PvDfLHU4HHr1Flr/VT6hf58=;
 b=R9Kg0LVCX/hLsIvFanTLRKESPjE2s1kXIZg/RuLauwKSVjHBbFp3OMNIfqSeR/K3rKxP15YuN1vzujHTR9GWF45NiEScmwE5+DMa8qdz7t6/37k9SWu8nHqHAMUpTP9Jujn6jgx6OVPV2W9kkt42zu09lRW1bRPszqoWWTA1gjAtmSrRPN9vqAk0Kq/+t+3MDkWSmosuSwvePwtpUTYMBkfCpMDHu4iEoQBEnewYOlJGESORpK95nB6khNopUknyeYpD+rboKf82jYvgWqQBvjmq/5wIrYu1TPriPCO5rpGNAcsKoeidLkIemqCDqGjs4iGxYVUQPHdGzaAtXE9XNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FcW03BH/zECu90BYcNp1PvDfLHU4HHr1Flr/VT6hf58=;
 b=HtwHKPJ2JmwZjKV7ifF6FtUq8l74oq+K11qOgZMs0T/BN30beLLR81v05yLbu/rZxjcJk14Saoz4TVIXxPFI8oUKyCtRLrOrKYY5ZW+EG4MrtC+DmnZNtyjHdPjnsRsYuG0sGGS694zWcHJF7AykfCFxsbBv5shIV+f8qye6wQo=
Received: from AS8PR04MB8946.eurprd04.prod.outlook.com (2603:10a6:20b:42d::18)
 by AS1PR04MB9501.eurprd04.prod.outlook.com (2603:10a6:20b:4d2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Wed, 1 Dec
 2021 23:34:51 +0000
Received: from AS8PR04MB8946.eurprd04.prod.outlook.com
 ([fe80::60be:d568:a436:894b]) by AS8PR04MB8946.eurprd04.prod.outlook.com
 ([fe80::60be:d568:a436:894b%5]) with mapi id 15.20.4755.016; Wed, 1 Dec 2021
 23:34:50 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Z.Q. Hou" <zhiqiang.hou@nxp.com>
Subject: RE: [PATCH 4/4] dt-bindings: pci: layerscape-pci: define aer/pme
 interrupts
Thread-Topic: [PATCH 4/4] dt-bindings: pci: layerscape-pci: define aer/pme
 interrupts
Thread-Index: AQHX3aPddDH3ddPt8EuZqS4SQ5nFIKwbYVKAgAAXieCAAK1igIACKXUQ
Date:   Wed, 1 Dec 2021 23:34:50 +0000
Message-ID: <AS8PR04MB89468674CFDEF98C6B45039F8F689@AS8PR04MB8946.eurprd04.prod.outlook.com>
References: <20211120001621.21246-1-leoyang.li@nxp.com>
 <20211120001621.21246-5-leoyang.li@nxp.com>
 <YaWGKaBvTpx1pA/x@robh.at.kernel.org>
 <AS8PR04MB89467DDB9BC3217431716D358F679@AS8PR04MB8946.eurprd04.prod.outlook.com>
 <CAL_JsqKdekKnG4CR3aGuOmLCxU9WzOaqLyPwBgUeE5D2WURFnQ@mail.gmail.com>
In-Reply-To: <CAL_JsqKdekKnG4CR3aGuOmLCxU9WzOaqLyPwBgUeE5D2WURFnQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d431558d-7441-4068-a498-08d9b5232b8d
x-ms-traffictypediagnostic: AS1PR04MB9501:
x-microsoft-antispam-prvs: <AS1PR04MB95010D4F4415EC5214F705EB8F689@AS1PR04MB9501.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a9j1igBrkpjKhQWCpcvxgfOV5YvmdocFg32MU13uferTIIjY1mblhbuTPUWhuE0FZXXTSz4rfXABf+QO1UQ91SNlSHrInzYCA+tklT8s1Hc2Ooebd3th9X+W1zmYqL/2fHdHXiKMz+GVSHrGpZr8l6EoU+pPeGKq6s1qLk0XYdMKqFsc1TB0HV1OR/2j5KVKYI7YZAwH3gQfeTi3Kbm3SX3ytTu5irB1DFghWSG+wB+H7DviCU7DOGnqNgN0myEsZnyfvbaSeW7pOrwRL+44b8K8CYJIVsy2WBcOcIyloyQ51WdXcomjVB4lD7VEAlSsA7Gow4PUaMw+OWY8sScmNVyEgmm+VnhtQK3vlg9W7VuF6BWXcG2KyLhzu4RlnANjN1Kjqz5qBvoLC151nIAT6DjywsSBAlGAr+AMnEmpXXGMnAGiMf3sCe0Y/oduKvNbIkNXFCbSMLshX7z7bVXWxmgvzb054SgF74g2zrxQQmsEu04TkRW0mVVWj/qJfhNcE/5bn7za6LYSu4QehbZYcaoyXhWaJtRMlqH7H+uyd8oJD7b8kvWR4HLr/9JwQ0IrJx7bWQOWOF9BAL8NywB/fBhUIfJ5kjQdIUKR4rr6rE+FlXfEQQeWTSB5GBQP9AUNreixWjgH4mr5yc5UTtAXn6Lx/XqhlTiOXDzO3x627uTXXUEQqYF2BMrvBQMYHgTchwEEtIPQhMxCglWJ9m0avA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8946.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(53546011)(7696005)(6506007)(52536014)(5660300002)(9686003)(38100700002)(38070700005)(6916009)(4326008)(508600001)(122000001)(26005)(8936002)(2906002)(86362001)(8676002)(186003)(76116006)(66476007)(66946007)(66446008)(64756008)(66556008)(33656002)(55016003)(316002)(83380400001)(71200400001)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGFWa1A2WGRZWG8rUS9lR3F1OWw4b0lKTVpYTzJvSUVma2NaaDZETzdBY1Ji?=
 =?utf-8?B?UEJsWXZPV0RPUDkwUVBMTkpEbW9TWTZQTGJmaFZUUlBZRlpmZ0hBaEtKMU9o?=
 =?utf-8?B?S3JaMmt5UmRWMFZZN2NZSmREVDJMazd0aEE3RFh3ZVowZ1p6Z2hDQitVdGRo?=
 =?utf-8?B?V0JQM3BySTJnOTVhamtuQ0pLTCsxbE5sYVQ5NklFY0ROQUZoeWlpdWNqdFBV?=
 =?utf-8?B?N2c3RjJ6eFR4MjM4U2FtaFluT3FpVlkzY0ZseGlsR0FQMzQvT0FrdWNtRTJ3?=
 =?utf-8?B?U0lnNlozNC9udEJrYVZEWnB3QlVENDZkTmhPaU5MRlFEd1VuQ3RXRWVicnpC?=
 =?utf-8?B?M0RocWhIT1FWbGM0SGhmUHhUMlZNbXQ2Yk1vNjB6NVUwbytGNDNxNmJ3TUNG?=
 =?utf-8?B?NWcyL1ljYUMrZE03ZDVlZGhqK3VRLzBQeTZXTTZxR3lOZUp5WGZERDhGYkxz?=
 =?utf-8?B?VlNrd0tiL1VNVEJRQ3dHbHVWaUdnWHhkTVJtUFhXenlDeXFTdjJpczE2bHFl?=
 =?utf-8?B?dWlqb0tQUzA1ZlJ4VW5PczJycmNaTjJrZ01aOXdGdXI1WnFmM1hFVXpONzda?=
 =?utf-8?B?SzhLWEFnVi9TTlNOQkVST2NYZmdqd1NrTTJpSWlZbStOaHlZR0ZHYmRETVRo?=
 =?utf-8?B?Skt4WDU3VHpUcnBCa05WZVVHTFVjMFJ4TWc1V3A0TFJHQ0UzWTN2NkI2VGQ2?=
 =?utf-8?B?Yng3T2xxcXNvV3JjbFpUMkk5cjBqRGdDTDFFbGlKeW1KNmc3K2pjUFVhSkNG?=
 =?utf-8?B?NlhVVUQrY3BDWkt3eGFjR1NsY1QxT1BBYm5Dam5jZEtyNTNhMGNUamIySlg0?=
 =?utf-8?B?L2I0K3I3d1ZIUDMvZ3FLcjM3SDJNTFNmK0k3OVlOTFNXc2NLNms1bHpMbk5K?=
 =?utf-8?B?eVdLNEpFVXcvelBsVHVMVlFDOHB1aTEzSWJNVXRrSldMNUlOM0Jvcy9UTzA1?=
 =?utf-8?B?aGxVVW02S1NZSi9tQVhHcHg2WlNaRE9EazQvaWhtTkd4aUJZeFE1ZTRpaUE4?=
 =?utf-8?B?M1lsVzE2ZHJ6Z1RpQ09pR1ZXU3V0MFNuRUgrejJOQ2lVTys4MjBVMTFWS0lR?=
 =?utf-8?B?YjhyUkpsaU8rdFZkaVFMTDYvSzRIcGV4dVNTU1BJaUVBOGhidnozaUhTM3Fs?=
 =?utf-8?B?cVRrMGhvb3dEeS9GcThVYURoczIvaDNiV2RBeVlYYnJyam01NlNqRWFvS2xm?=
 =?utf-8?B?RGlJVi9JK3JpVjJwcHV4U1c5RHlkVjlNcE5CUTF0Vnkrd1Z6YUVhdVFIa2Yr?=
 =?utf-8?B?WlR4Q0pVb0NJN1puSjZ5VjBBYU9pRXpjT0U2ODlNdTllblFhY2tYcklmb0Vq?=
 =?utf-8?B?OVZqM2lYTGczc1IvZllTTEdKMEhUTXdNU1hkb1RYWkJaRWFZaXhlNVBmYnRp?=
 =?utf-8?B?QmJqY3RzeWpNS3RLeTkrZjQxL2VBWkYyNGdSd3Y5UVlZNG1LL0ZBbmpNN1h3?=
 =?utf-8?B?c09TQ3JWeDJYUVM1bXB3VlFHdDk3Sjc1V2VrQnFPaUs3amNnRHF2d1QyMlFO?=
 =?utf-8?B?amo5TW4xc2swbjc4c0NNbDVFalVQT3NZRDB0OGlld0I1NFM0TSt0aEFPbjN6?=
 =?utf-8?B?czhjVCtFMjJhTmg5VGVneUlnb1pMdm05bTZZcGZwL2RwOFl3UXppNzc4cFBK?=
 =?utf-8?B?MDFJTjlablc2eFRyWndLUEgvNUNrRCtDN0VsVGFWMXY3N0JVYmRYQWN0V2NM?=
 =?utf-8?B?ZGx4K0IwVW1mR2NqMm95Zmg3VTl1aDhXVnR3bDU2dzFwS3dqc0k5OTR6L1A3?=
 =?utf-8?B?RlZwbXdYYUhrUlF2M3lMNTM2Nk0wd0tUVHhLeCtsa0dGTFZJTlRuZ2ZOVElZ?=
 =?utf-8?B?UkNtZHExWjhEOHk5blZOSjYyRUxOS1dUKzBjbnFGd0lESExsWDdtTzBGSzk3?=
 =?utf-8?B?NkdsSW1HSmVyT1E4ajNST1owZFlFTHhvcjczZHl5OUZMMDRKd3kyb1BBeFdm?=
 =?utf-8?B?eWR6elp3ZG1NdGRZSktqb3VuYlcxTnZsbk1CUllDZnpaUnl2bDUzTmJGNGMx?=
 =?utf-8?B?bGpLYmpmdkJpUXo1NmE5SkNiTktDQmUyejNUVzMrRVYvcEJTUkZOVEVjZGZt?=
 =?utf-8?B?YWNvbnU5elFaYjJ6djVZN3A0aHZVclVQT1lmWUFsT2xJRWx2WUFVNGRuc1oz?=
 =?utf-8?B?Qk1IV0o1MTNTL1FHT3ZGUHR3VDlOZjhuR0thM3NHTGR5TkRlZTBUNzQ3NU1Y?=
 =?utf-8?B?aFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8946.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d431558d-7441-4068-a498-08d9b5232b8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 23:34:50.7895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nx2ed9wBHVpHIaYX4WqUMk37WiB0is0xEgyElTvlKohR+zT49pH48EcBd1zpF4rn6ByXNooyRGLLqzwDF05ltA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9501
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iIEhlcnJpbmcgPHJv
YmhAa2VybmVsLm9yZz4NCj4gU2VudDogVHVlc2RheSwgTm92ZW1iZXIgMzAsIDIwMjEgNzo0NyBB
TQ0KPiBUbzogTGVvIExpIDxsZW95YW5nLmxpQG54cC5jb20+DQo+IENjOiBCam9ybiBIZWxnYWFz
IDxiaGVsZ2Fhc0Bnb29nbGUuY29tPjsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsNCj4gZGV2
aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFou
US4gSG91DQo+IDx6aGlxaWFuZy5ob3VAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCA0
LzRdIGR0LWJpbmRpbmdzOiBwY2k6IGxheWVyc2NhcGUtcGNpOiBkZWZpbmUgYWVyL3BtZQ0KPiBp
bnRlcnJ1cHRzDQo+IA0KPiBPbiBNb24sIE5vdiAyOSwgMjAyMSBhdCA5OjM1IFBNIExlbyBMaSA8
bGVveWFuZy5saUBueHAuY29tPiB3cm90ZToNCj4gPg0KPiA+DQo+ID4NCj4gPiA+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwu
b3JnPg0KPiA+ID4gU2VudDogTW9uZGF5LCBOb3ZlbWJlciAyOSwgMjAyMSA4OjAyIFBNDQo+ID4g
PiBUbzogTGVvIExpIDxsZW95YW5nLmxpQG54cC5jb20+DQo+ID4gPiBDYzogQmpvcm4gSGVsZ2Fh
cyA8YmhlbGdhYXNAZ29vZ2xlLmNvbT47IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4g
PiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZzsgWi5RLiBIb3UNCj4gPiA+IDx6aGlxaWFuZy5ob3VAbnhwLmNvbT4NCj4gPiA+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggNC80XSBkdC1iaW5kaW5nczogcGNpOiBsYXllcnNjYXBlLXBjaTogZGVmaW5l
DQo+ID4gPiBhZXIvcG1lIGludGVycnVwdHMNCj4gPiA+DQo+ID4gPiBPbiBGcmksIE5vdiAxOSwg
MjAyMSBhdCAwNjoxNjoyMVBNIC0wNjAwLCBMaSBZYW5nIHdyb3RlOg0KPiA+ID4gPiBTb21lIHBs
YXRmb3JtcyB1c2luZyB0aGlzIGNvbnRyb2xsZXIgaGF2ZSBzZXBhcmF0ZWQgaW50ZXJydXB0DQo+
ID4gPiA+IGxpbmVzIGZvciBhZXIgb3IgcG1lIGV2ZW50cyBpbnN0ZWFkIG9mIGhhdmluZyBhIHNp
bmdsZSBpbnRlcnJ1cHQNCj4gPiA+ID4gbGluZSBmb3IgbWlzY2VsbGFuZW91cyBldmVudHMuICBE
ZWZpbmUgaW50ZXJydXB0cyBpbiB0aGUgYmluZGluZw0KPiA+ID4gPiBmb3IgdGhlc2UgaW50ZXJy
dXB0IGxpbmVzLg0KPiA+ID4gPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBMaSBZYW5nIDxsZW95
YW5nLmxpQG54cC5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAgLi4uL2RldmljZXRyZWUvYmlu
ZGluZ3MvcGNpL2xheWVyc2NhcGUtcGNpLnR4dCAgICAgfCAxNCArKysrKysrKysrLS0tLQ0KPiA+
ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+
ID4gPiA+DQo+ID4gPiA+IGRpZmYgLS1naXQNCj4gPiA+ID4gYS9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvcGNpL2xheWVyc2NhcGUtcGNpLnR4dA0KPiA+ID4gPiBiL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvbGF5ZXJzY2FwZS1wY2kudHh0DQo+ID4gPiA+
IGluZGV4IDhmZDYwMzlhODI2Yi4uYmNmMTFiZmM0YmFiIDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL2xheWVyc2NhcGUtcGNpLnR4dA0K
PiA+ID4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL2xheWVy
c2NhcGUtcGNpLnR4dA0KPiA+ID4gPiBAQCAtMzEsOCArMzEsMTMgQEAgUmVxdWlyZWQgcHJvcGVy
dGllczoNCj4gPiA+ID4gIC0gcmVnOiBiYXNlIGFkZHJlc3NlcyBhbmQgbGVuZ3RocyBvZiB0aGUg
UENJZSBjb250cm9sbGVyIHJlZ2lzdGVyIGJsb2Nrcy4NCj4gPiA+ID4gIC0gaW50ZXJydXB0czog
QSBsaXN0IG9mIGludGVycnVwdCBvdXRwdXRzIG9mIHRoZSBjb250cm9sbGVyLiBNdXN0IGNvbnRh
aW4NCj4gYW4NCj4gPiA+ID4gICAgZW50cnkgZm9yIGVhY2ggZW50cnkgaW4gdGhlIGludGVycnVw
dC1uYW1lcyBwcm9wZXJ0eS4NCj4gPiA+ID4gLS0gaW50ZXJydXB0LW5hbWVzOiBNdXN0IGluY2x1
ZGUgdGhlIGZvbGxvd2luZyBlbnRyaWVzOg0KPiA+ID4gPiAtICAiaW50ciI6IFRoZSBpbnRlcnJ1
cHQgdGhhdCBpcyBhc3NlcnRlZCBmb3IgY29udHJvbGxlcg0KPiA+ID4gPiBpbnRlcnJ1cHRzDQo+
ID4gPiA+ICstIGludGVycnVwdC1uYW1lczogSXQgY291bGQgaW5jbHVkZSB0aGUgZm9sbG93aW5n
IGVudHJpZXM6DQo+ID4gPiA+ICsgICJhZXIiOiBGb3IgaW50ZXJydXB0IGxpbmUgcmVwb3J0aW5n
IGFlciBldmVudHMgd2hlbiBub24NCj4gPiA+ID4gK01TSS9NU0ktWC9JTlR4DQo+ID4gPiBtb2Rl
DQo+ID4gPiA+ICsgICAgICAgICAgIGlzIHVzZWQNCj4gPiA+ID4gKyAgInBtZSI6IEZvciBpbnRl
cnJ1cHQgbGluZSByZXBvcnRpbmcgcG1lIGV2ZW50cyB3aGVuIG5vbg0KPiA+ID4gPiArIE1TSS9N
U0ktDQo+ID4gPiBYL0lOVHggbW9kZQ0KPiA+ID4gPiArICAgICAgICAgICBpcyB1c2VkDQo+ID4g
PiA+ICsgICJpbnRyIjogRm9yIGludGVycnVwdCBsaW5lIHJlcG9ydGluZyBtaXNjZWxsYW5lb3Vz
IGNvbnRyb2xsZXINCj4gPiA+ID4gK2V2ZW50cw0KPiA+ID4gPiArICAuLi4uLi4NCj4gPiA+ID4g
IC0gZnNsLHBjaWUtc2NmZzogTXVzdCBpbmNsdWRlIHR3byBlbnRyaWVzLg0KPiA+ID4gPiAgICBU
aGUgZmlyc3QgZW50cnkgbXVzdCBiZSBhIGxpbmsgdG8gdGhlIFNDRkcgZGV2aWNlIG5vZGUNCj4g
PiA+ID4gICAgVGhlIHNlY29uZCBlbnRyeSBpcyB0aGUgcGh5c2ljYWwgUENJZSBjb250cm9sbGVy
IGluZGV4IHN0YXJ0aW5nIGZyb20gJzAnLg0KPiA+ID4gPiBAQCAtNTIsOCArNTcsOSBAQCBFeGFt
cGxlOg0KPiA+ID4gPiAgICAgICAgICAgICByZWcgPSA8MHgwMCAweDAzNDAwMDAwIDB4MCAweDAw
MDEwMDAwICAgLyogY29udHJvbGxlcg0KPiA+ID4gcmVnaXN0ZXJzICovDQo+ID4gPiA+ICAgICAg
ICAgICAgICAgICAgICAweDQwIDB4MDAwMDAwMDAgMHgwIDB4MDAwMDIwMDA+OyAvKg0KPiA+ID4g
PiBjb25maWd1cmF0aW9uIHNwYWNlDQo+ID4gPiAqLw0KPiA+ID4gPiAgICAgICAgICAgICByZWct
bmFtZXMgPSAicmVncyIsICJjb25maWciOw0KPiA+ID4gPiAtICAgICAgICAgICBpbnRlcnJ1cHRz
ID0gPEdJQ19TUEkgMTc3IElSUV9UWVBFX0xFVkVMX0hJR0g+OyAvKg0KPiA+ID4gY29udHJvbGxl
ciBpbnRlcnJ1cHQgKi8NCj4gPiA+ID4gLSAgICAgICAgICAgaW50ZXJydXB0LW5hbWVzID0gImlu
dHIiOw0KPiA+ID4gPiArICAgICAgICAgICBpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMTc2IElSUV9U
WVBFX0xFVkVMX0hJR0g+LCAvKiBhZXINCj4gPiA+IGludGVycnVwdCAqLw0KPiA+ID4gPiArICAg
ICAgICAgICAgICAgICAgIDxHSUNfU1BJIDE3NyBJUlFfVFlQRV9MRVZFTF9ISUdIPjsgLyogcG1l
DQo+ID4gPiBpbnRlcnJ1cHQgKi8NCj4gPiA+ID4gKyAgICAgICAgICAgaW50ZXJydXB0LW5hbWVz
ID0gImFlciIsICJwbWUiOw0KPiA+ID4NCj4gPiA+IFRoaXMgaXNuJ3QgYSBjb21wYXRpYmxlIGNo
YW5nZS4gVGhlIGgvdyBzdWRkZW5seSBoYXMgbm8gJ2ludHInDQo+ID4gPiBpbnRlcnJ1cHQ/DQo+
ID4NCj4gPiBUaGUgb3JpZ2luYWwgJ2ludHInIHdhcyBqdXN0IGEgcGxhY2UgaG9sZGVyIGZvciBh
IEhXIGludGVycnVwdCBzaWduYWwgd2l0aG91dCBhDQo+IGNsZWFyIGRlZmluaXRpb24gb2YgZXZl
bnRzIGFzc29jaWF0ZWQuICBTb21lIGxhdGVyIFNvQyBoYXMgbW9yZSBpbnRlcnJ1cHQNCj4gc2ln
bmFscyB0byBhc3NvY2lhdGUgd2l0aCBtb3JlIHNwZWNpZmljIGV2ZW50cy4NCj4gDQo+ICdMYXRl
ciBTb0MnIG1lYW5zIG5ldyBjb21wYXRpYmxlLCBidXQgeW91J3JlIG5vdCBjaGFuZ2luZyB0aGUg
Y29tcGF0aWJsZS4gSWYNCj4gaXQgd2FzIGp1c3Qgd3JvbmcgZm9yIGFsbCBTb0NzLCB0aGVuIHN0
YXRlIHRoYXQgaW4gdGhlIGNvbW1pdCBtZXNzYWdlLiBQbGVhc2UNCj4gZGVmaW5lIGFsbCB0aGUg
aW50ZXJydXB0cyBvbiBhbGwgU29Dcywgc28gaXQgaXMgbm90IGNoYW5naW5nIGFnYWluLg0KDQpE
aWZmZXJlbnQgU29DcyBjb3VsZCBoYXZlIGRpZmZlcmVudCBudW1iZXIgb2YgaW50ZXJydXB0IGxp
bmVzIGFuZCB0aGUgZXZlbnRzIHJvdXRpbmcgY291bGQgYWxzbyBiZSBkaWZmZXJlbnQgYW1vbmcg
U29Dcy4gIEl0IGlzIHJlYWxseSBoYXJkIHRvIG5hbWUgdGhlIGludGVycnVwdCBsaW5lcyBwcm9w
ZXJseSB0aGF0IHdvcmtzIGZvciBhbGwgU29Dcy4gIFRoYXQgaXMgcHJvYmFibHkgd2h5IHdlIGNo
b3NlIHRvIG5hbWUga2V5IGV2ZW50cyBpbnN0ZWFkIG9mIGludGVycnVwdCBsaW5lcy4NCg0KVGhl
IEhXIGRvY3VtZW50YXRpb24gaXMgYWxzbyBub3QgdmVyeSBjbGVhciBvbiB0aGlzIHBhcnQuICBC
dXQgSSB3aWxsIHRyeSB0byBzdW1tYXJpemUgdGhlIHNpdHVhdGlvbiBiZXR0ZXIgaW4gbmV4dCB2
ZXJzaW9uLCBmb3IgZXhhbXBsZToNCg0KImFlciI6IFVzZWQgZm9yIGludGVycnVwdCBsaW5lIHdo
aWNoIHJlcG9ydHMgQUVSIGV2ZW50cyB3aGVuIG5vbiBNU0kvTVNJLVgvSU5UeCBtb2RlIGlzIHVz
ZWQNCiJwbWUiOiBVc2VkIGZvciBpbnRlcnJ1cHQgbGluZSB3aGljaCByZXBvcnRzIFBNRSBldmVu
dHMgd2hlbiBub24gTVNJL01TSS1YL0lOVHggbW9kZSBpcyB1c2VkDQoiaW50ciI6IFVzZWQgZm9y
IFNvQyhsaWtlIGxzMjA4MGEsIGx4MjE2MCwgbHMyMDgwLCBsczIwODgsIGxzMTA4OCkgd2hpY2gg
aGFzIGEgc2luZ2xlIGludGVycnVwdCBsaW5lIGZvciBtaXNjZWxsYW5lb3VzIGNvbnRyb2xsZXIg
ZXZlbnRzKHdoaWNoIGNvdWxkIGluY2x1ZGUgQUVSIGFuZCBQTUUgZXZlbnRzKS4NCg0KPiANCj4g
PiBJZiBuZWVkZWQsIHdlIGNhbiBrZWVwIHRoZSAiaW50ciIgaW50ZXJydXB0LW5hbWUgdGhlcmUg
anVzdCBmb3IgYmFja3dhcmQNCj4gY29tcGF0aWJpbGl0eSBhbHRob3VnaCBpdCB3YXMgbmV2ZXIg
dXNlZCBpbiBMaW51eC4NCj4gDQo+IFdoYXQgYWJvdXQgb3RoZXIgT1NzPw0KPiANCj4gUm9iDQo=
