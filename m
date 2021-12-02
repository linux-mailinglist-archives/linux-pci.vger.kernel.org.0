Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C54CD465B63
	for <lists+linux-pci@lfdr.de>; Thu,  2 Dec 2021 01:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235337AbhLBAvr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Dec 2021 19:51:47 -0500
Received: from mail-eopbgr50047.outbound.protection.outlook.com ([40.107.5.47]:22860
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344564AbhLBAvp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 Dec 2021 19:51:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bTw/wXjPOkyaXuIc47mNLX36zpd9qrRoH19AXsStiq53P4iPB/7KJ0Nc+yyd+vx4I3xAwfJBEdb59j7WC9/xWiDAab99Pk1fKjXZjlVTlVJ6BrnPg0rMDekY05h/OHG5pExUTXpAvmQWjmuWNEVFeLi+lWvg8VjjOZK1vJ8GlBw8PAWECur1q+3FtTgt5+cjkQTBmznhTe5f1CKFBCbMDTbw2QreK9jhrbfHSHXd2x6CWEVRr2kF4w9vwngyZtcsOaJ5MVKtN5C7htz0v3ZKXz4fEBDpPgbRoepaY2krL0tomuS8lSXYTjUEQgNFG8a5+vItxdADs45KcuDgqyAt1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0uL8rUez3UanpTZ8grAd8IsR6SibdHAxWOa75zHloq8=;
 b=d41RcWEDo9K9crGrs6kbu5+6TeyNqe2btjM8110mihsOC3XRM5XqB/2iJ2VQSqjZMbBKjG3oGDJsta1/W/FvK/xMuvT7lFesygGuvx7HYHZtEpmrC7HI8UMtbKvqeYk5ASdmelGdoduIs3pmrqYlIxc9yVIs++331aRDafctuCIPwqauDYsGWVvmK2RSHdcATtDDiq3iznEnaZlsErPahzEvNP7Lr1KdKKbuscDXsCJfsZ2rMv9d0aZ1rtS/J2YywM0fJg5CjP3EOmU413JUV8Jgt6KxBbh4LHzugXGMMVugKb3SoXetrrtsJHW3854laVDKF7jjNpEQU3LP57CXgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0uL8rUez3UanpTZ8grAd8IsR6SibdHAxWOa75zHloq8=;
 b=LXwhiXloQ0SJfKPfeG3zc9fT/kHPxuDhEW9PYUBMWkh8417vtlDeDrHAGmnkoGzgj4E7mUsq4XizcKfy1flca7kk1DoEGV0dFyhVBm49g7PcDBOGpM3UkfE6Ck27XcLT18DaS4TdS/KJW5mW/q4hWu16Z0VyB73QIky2gbIWp4E=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8802.eurprd04.prod.outlook.com (2603:10a6:20b:42d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Thu, 2 Dec
 2021 00:48:22 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc%5]) with mapi id 15.20.4734.027; Thu, 2 Dec 2021
 00:48:22 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     "tharvey@gateworks.com" <tharvey@gateworks.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC:     open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] PCI: imx: do not remap invalid res
Thread-Topic: [PATCH] PCI: imx: do not remap invalid res
Thread-Index: AQHX5v/DAupsrcqHe06C8ej53cpd9qweXjuA
Date:   Thu, 2 Dec 2021 00:48:22 +0000
Message-ID: <AS8PR04MB86769FC6021C2C137776D7A68C699@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20211101180243.23761-1-tharvey@gateworks.com>
 <CAJ+vNU2Pfwz5e0Jj6c5npceOwuNTB_dTVuL4NMD2qxr0CGyeGQ@mail.gmail.com>
In-Reply-To: <CAJ+vNU2Pfwz5e0Jj6c5npceOwuNTB_dTVuL4NMD2qxr0CGyeGQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ccd9d84f-f879-4244-9517-08d9b52d70e8
x-ms-traffictypediagnostic: AS8PR04MB8802:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AS8PR04MB8802403DAEF6B5DAC09D9CCC8C699@AS8PR04MB8802.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:758;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qs9V6JLd/9Ip+ocU5t3lrQYYDEcDkXlc4HM/P/Ke7PwzkXxV+SuS6xKmaoClz0B0suXKXER4yVpCjuMjsFTNOsIYJDsohB1Ml3+ZAApeo5zeCb5yo3l06YJqXcBRiwm4QnU77kOP2t342Vj23PPCvDeyRDj+fLyncioTgoflWA8RyWlAUk5/H/JgejbdHRwNtA+k44WmURSonqwmCr4MEGVw8YAFkEJ9E1aXixWpxRE7dHtawQej+D8LSQ2dmV5aLFSxYsWG6MbwK6WuqkOotAthNFsHw+NvXxoSDpW5d0Lh1g2bvW04jj9XfMj9xikH43BAuAh3f7XhV/k7yAm0n1hQfyzgc6gor/22gsZ9Dka8cv4ZlnbZ4ycTLmN8c5qCo6zTty/QDR8bIFDKMPv/iAUuX1Q6zIdRjdKMMeP6hTVtBiThsBhX7PW+ZIRcZVJX1FbhCq9cpmLUwmLR9Moyz7CW86esvsoa3E+r5WuN/45jRo+DL/rgvDNI5n+rfuWc6Pg7EAbqv+YRPh0exM08U/IHBWReQ2iX2YYWsd7XlsMdKoh1bQUeEXcdiqi/Q1aBefTnSwTTHFvk+gM79hgbg2wmHa/Jr5wG/OPxTboOq3+05GERtNvgWLDlSvPHm9CdthXgN+FGw8gJjoIVsQ1yz1wvYaccARM0gZ1exHcX64Vkb1XP7g1rqG5zbjtRffch/q4fMryiTzOI6Q32VESYrg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(9686003)(508600001)(316002)(71200400001)(8936002)(55016003)(66556008)(110136005)(64756008)(4326008)(7696005)(8676002)(38070700005)(66446008)(66946007)(66574015)(6506007)(2906002)(66476007)(122000001)(5660300002)(53546011)(44832011)(52536014)(26005)(186003)(33656002)(38100700002)(83380400001)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VGtCM25WSnpCUnREeHd2bGRENE1LcFU3dG5qK1MrNW8ralBOMGx3ekVzVFM2?=
 =?utf-8?B?WUd6RTV6TjFTbklna05pQ0psNU40a2ZWVHBscEg4VU9ub0MySmxlNDNYd1h5?=
 =?utf-8?B?S2lFUFlLRlhLdk5hNFBNdGFwRWd0b1ZFZk0ybnEwTTZ3K2Y5a2V3d1ducTcy?=
 =?utf-8?B?dHB2eUlZRmhXY2N6YktnSXFsbkZCbkZwUnF5SlNzQ1k0RXpIdFl1a0xsU0VD?=
 =?utf-8?B?dWlDelJVanF5YndUckxXNCsrcGd1ajBrZVlVSFl0YkQvRUJHeUJRR3d2b3V2?=
 =?utf-8?B?R3hIWDVxaHZ3Q0NHK1JGKzBPbWhnUndYWnZFcDMySGtlRUkzUXN1Tkw1dGpx?=
 =?utf-8?B?dGZ3NjBTT1I3T0MvTUZtakZ5V3NpblRtZnFIRURmZG05UFc4d01FQ1VEc1My?=
 =?utf-8?B?TXoyUEVSdUpsc2tlMWkzMUNvSkxRK0xZSkNUN25iemZYTDdRZUEvRnA4bm42?=
 =?utf-8?B?YnBXVHRrTUJQTXpGRTVXR28yaUlJaUMzZlZ6bk94cDZZcUJaZkhTTW9GYlp6?=
 =?utf-8?B?OExjZEdPbGZWcE9QalM5VmRCSEFXTCs5cW5SdTJlbk03WGgzSy9Vclh6WWxS?=
 =?utf-8?B?MTVvNVRycmVXOCsrVytzUndPVkR5VTd6SElkb2NUMjlFYWlGb2laUGtmRlVK?=
 =?utf-8?B?QmovN1YzMUdIVVYyM1V3dGUzdldUQnc3WjFqT1BQUHh0akhyV3ZZeTJzdUgx?=
 =?utf-8?B?dkt5NERuMTN5UEQ1VnEwbktSZjdXUDVKenBmU0hETjFkUENBL2VFbHNLcVEr?=
 =?utf-8?B?WjZoWG1iRGcvT1hGZmswOUROcGdCWjJWM2h3Z3drakpHN0U0NW54OG5LekdO?=
 =?utf-8?B?YzFyR21LaXcrTllPWWhnODlqM1JoQ3BId09aaFBPS25pTFVDbzlCbmxkMVpr?=
 =?utf-8?B?czJkNytQM3dqUm9yU1FUSjFSN1k2L2tpMDA1QWJSbERYWFd3WHYyYjFJbVJn?=
 =?utf-8?B?aFdVUXRXOWJpYlBSTmpBMnhWbHBUcExpa2FTWHQ5NlljZWZYS1BhdEdQbmFL?=
 =?utf-8?B?R0Mya2Y0emlUN2J3WGVnNEU5UUVxWmlPL0F5bWtDai9wa3BFVW1Pc3lkWDg3?=
 =?utf-8?B?YkdnaUNzQkt4eGdaeUI2YWZsMnkyeHBtR1JEVzdSR095UTR2TVhrS2JrbTlz?=
 =?utf-8?B?TDFVWWN3ZnU3OU9oU3BGMUpCL08wZ084bzg0bnJ3MjlOVzRpWXlKNmtIQzQw?=
 =?utf-8?B?VkZyakJPKzYyblJ0T1BKNDl6d0llNDd2NUlWbWVIWXFjL3pJWnBTWGIvUVZQ?=
 =?utf-8?B?WVdQRGZ4cWlvVlhIOGQzUFhUQVpZU2xqT3VQN0I4Q3hKb2xoUFBMTklXaFBx?=
 =?utf-8?B?R285Y2t2b0ZURStMelBTYitRTDBuMTNRdmtUck03eEdqVUVNTkFsajJNeUZX?=
 =?utf-8?B?bHAvdWJscnluejl2QVR4akpmZGdGeWhnSm1Hai9NNk1wcCtUbEZoK1V5cVZm?=
 =?utf-8?B?N2lva21LNy9zallHaGFscFdoSXpHSzJrdFNIVmR5UDdSV1VtZUptWndWSHdB?=
 =?utf-8?B?Z3J2VkQ3STdRVk5FRHMyUUFSRFU3elg5RVQwUjFVSXN6RWtzcXQ3ZndGcDdy?=
 =?utf-8?B?VHArQk82emFNSmlJbmpBV1dSR285T0pyd3JxdTQwaDFudndaeWEvWkI3cXI2?=
 =?utf-8?B?M243cUxxcGIxSXB5eHpXZ29INlNmaGlEd2dXNjdHZ0JTVjhZUDJlZmR4N2k0?=
 =?utf-8?B?U2FVaG1LUkNnNWl4K2xkN0J4a1NYbm9vRGRYQ21Ed2hTRStyZWU2K1hyOUhJ?=
 =?utf-8?B?RVNDVExNVXRVMVRoOHJqQkNsRDhFTDJuV1g0dUhmZDRrdXBqeTNrazVNdkZ4?=
 =?utf-8?B?akhhVUhQTEpNeXIrekhTaTFFUG1SMW14eUNTeWRudWNvbENOa2prcUVKRVhr?=
 =?utf-8?B?TUhjM3RSVHRpNnV3bitWYUtnN3FBNW5yQnNWakNDYUJNaE5GWTRKQ2ZpSnZV?=
 =?utf-8?B?YzN5eFRZcVYvcDFscTVCU1JJbjdhN24wQ2JDMDI4c3RpbTV0MFBwOEdRZDNV?=
 =?utf-8?B?V0pTWkdFMWo1c0hoeGRGM0I1SVlhcDhRREh4bnFxMVhES0ZhM1dhcnlUa2pS?=
 =?utf-8?B?ZURucFptWWtxZ0ducURUZERGaUwyWmdBY0FldTBNVzJ0RUUveGl5cGovNEMw?=
 =?utf-8?B?MC9ZNHVLVno0Z1Q3TXJWUnhTR3RGVjYvOGZCazgwTjA4ZHBUSDBheUMvaDMr?=
 =?utf-8?B?NWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd9d84f-f879-4244-9517-08d9b52d70e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2021 00:48:22.1265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y1H6Xi8L8rllK2lfubjJgvcdTOsJiSxp691zF+VHhFcLhWOHz+G2+d6szZtH96Z7YdXDIn9N7Um+naowFfzMlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8802
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFRpbSBIYXJ2ZXkgPHRoYXJ2
ZXlAZ2F0ZXdvcmtzLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIERlY2VtYmVyIDIsIDIwMjEgNjow
NyBBTQ0KPiBUbzogSmluZ29vIEhhbiA8amluZ29vaGFuMUBnbWFpbC5jb20+OyBHdXN0YXZvIFBp
bWVudGVsDQo+IDxndXN0YXZvLnBpbWVudGVsQHN5bm9wc3lzLmNvbT47IFJvYiBIZXJyaW5nIDxy
b2JoQGtlcm5lbC5vcmc+Ow0KPiBMb3JlbnpvIFBpZXJhbGlzaSA8bG9yZW56by5waWVyYWxpc2lA
YXJtLmNvbT47IEtyenlzenRvZiBXaWxjennFhHNraQ0KPiA8a3dAbGludXguY29tPjsgQmpvcm4g
SGVsZ2FhcyA8YmhlbGdhYXNAZ29vZ2xlLmNvbT47DQo+IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5v
cmcNCj4gQ2M6IG9wZW4gbGlzdCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47IEhvbmd4
aW5nIFpodQ0KPiA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hd
IFBDSTogaW14OiBkbyBub3QgcmVtYXAgaW52YWxpZCByZXMNCj4gDQo+IE9uIE1vbiwgTm92IDEs
IDIwMjEgYXQgMTE6MDMgQU0gVGltIEhhcnZleSA8dGhhcnZleUBnYXRld29ya3MuY29tPg0KPiB3
cm90ZToNCj4gPg0KPiA+IE9uIGlteDYgYW5kIHBlcmhhcHMgb3RoZXJzIHdoZW4gcGNpZSBwcm9i
ZXMgeW91IGdldCBhOg0KPiA+IGlteDZxLXBjaWUgMzM4MDAwMDAucGNpZTogaW52YWxpZCByZXNv
dXJjZQ0KPiA+DQo+ID4gVGhpcyBvY2N1cnMgYmVjYXVzZSB0aGUgYXR1IGlzIG5vdCBzcGVjaWZp
ZWQgaW4gdGhlIERUIGFuZCBhcyBzdWNoIGl0DQo+ID4gc2hvdWxkIG5vdCBiZSByZW1hcHBlZC4N
Cj4gPg0KPiA+IENjOiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+ID4gU2ln
bmVkLW9mZi1ieTogVGltIEhhcnZleSA8dGhhcnZleUBnYXRld29ya3MuY29tPg0KW1JpY2hhcmQg
Wmh1XSBQbGVhc2UgbWVyZ2UgUm9iJ3MgY29tbWl0IGxvZyBjaGFuZ2VzLg0KVGhlbiwgQWNrZWQt
Ynk6IFJpY2hhcmQgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCg0KQmVzdCBSZWdhcmRzDQpS
aWNoYXJkIFpodQ0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ll
LWRlc2lnbndhcmUuYyB8IDcgKysrKy0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRp
b25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5jDQo+ID4gYi9kcml2ZXJzL3BjaS9jb250
cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuYw0KPiA+IGluZGV4IGE5NDVmMGMwZTczZC4uMzI1
NGY2MGQxNzEzIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3Bj
aWUtZGVzaWdud2FyZS5jDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNp
ZS1kZXNpZ253YXJlLmMNCj4gPiBAQCAtNjcxLDEwICs2NzEsMTEgQEAgdm9pZCBkd19wY2llX2lh
dHVfZGV0ZWN0KHN0cnVjdCBkd19wY2llDQo+ICpwY2kpDQo+ID4gICAgICAgICAgICAgICAgIGlm
ICghcGNpLT5hdHVfYmFzZSkgew0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBy
ZXNvdXJjZSAqcmVzID0NCj4gPg0KPiBwbGF0Zm9ybV9nZXRfcmVzb3VyY2VfYnluYW1lKHBkZXYs
IElPUkVTT1VSQ0VfTUVNLCAiYXR1Iik7DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgaWYg
KHJlcykNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBpZiAocmVzKSB7DQo+ID4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBwY2ktPmF0dV9zaXplID0NCj4gcmVzb3VyY2Vfc2l6
ZShyZXMpOw0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgIHBjaS0+YXR1X2Jhc2UgPQ0KPiBk
ZXZtX2lvcmVtYXBfcmVzb3VyY2UoZGV2LCByZXMpOw0KPiA+IC0gICAgICAgICAgICAgICAgICAg
ICAgIGlmIChJU19FUlIocGNpLT5hdHVfYmFzZSkpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBwY2ktPmF0dV9iYXNlID0NCj4gZGV2bV9pb3JlbWFwX3Jlc291cmNlKGRldiwg
cmVzKTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICB9DQo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgaWYgKCFwY2ktPmF0dV9iYXNlIHx8DQo+IElTX0VSUihwY2ktPmF0dV9iYXNlKSkN
Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBjaS0+YXR1X2Jhc2UgPSBwY2kt
PmRiaV9iYXNlDQo+ICsgREVGQVVMVF9EQklfQVRVX09GRlNFVDsNCj4gPiAgICAgICAgICAgICAg
ICAgfQ0KPiA+DQo+ID4gLS0NCj4gPiAyLjE3LjENCj4gPg0KPiANCj4gcGluZyAtIGFueSBmZWVk
YmFjayBvbiB0aGlzPw0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiANCj4gVGltDQo=
