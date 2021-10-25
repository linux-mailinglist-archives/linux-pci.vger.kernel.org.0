Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77C3C438D80
	for <lists+linux-pci@lfdr.de>; Mon, 25 Oct 2021 04:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbhJYCiB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 24 Oct 2021 22:38:01 -0400
Received: from mail-eopbgr80042.outbound.protection.outlook.com ([40.107.8.42]:15451
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231938AbhJYCiA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 24 Oct 2021 22:38:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OB/QlfmGVxlk+gjV4zd2LDwPBxQ3TWkGb4zm/e+XnJedOon6TZiSMAAxNcI2bst2uV1guGPuPYBRsdMZv1mbf1O5OOu0OK5QpTapieIzTcFCJDj9L/Fkk9nmJnzZPS5nkNbyPjtI+WsxBzLQChMdvPby/j8izVcG2vK2wy/boTQyyYuWu80FN9UvM2tsCOJ++gDPCmwBFshUm1mTbLdLD0iNA8ZEQWFoP/PC5AEGT8E0FwMBahaIDGyhShXCD8MT1soqpCvRX/z01XYP2kLd6wDB1xKxDHNZVE6gBABI4pLGtihN4UePNd810Sn5nPIpQLlLAeDDWlDUDAMD36FziQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0r2NF0hm4/JgGHZBrf8ZKPjeVlOi6HVVlMlv0+yLkjY=;
 b=m2411SoDO4uQuq5BRv/JvrrV4ff7YHiXr70wEIb+Wq3rsBODTaLFnvf0AEUp1G2vzKRi1CesMYylBl3vI8OITl7nQclPWwA2xKpvSMnVL9aM9ghiYTFRHu0oOg9k7SOClBFD9739iYFGFphKbmlQmR8BbV6rWMklDBQBm5KG3A2PdEdE5ewt6pYd6BsSVuUeuIGrFd7BSD/cs9HWJyi4CDlyUvOjNFAxih8coIWhryU440lYMUUhky2b9RmGdLViE92MLS/gd8KAqhVBohdxwtoFwDT4Cbk9iEdFuHu+c6s6JxHiMDaOjRqPCA39tvQD3w3CTVrn0tq/gTVD5mXE0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0r2NF0hm4/JgGHZBrf8ZKPjeVlOi6HVVlMlv0+yLkjY=;
 b=qivFNbyPTiTkJrCenJkP/MJIc1pw0MW3kiYXCjpnh+cxhhB2Zwg5Lbkmdnv3CzdC2in5q/CMUHR/VLcjy6purSFKl9V1oedIQo/OkjWHKAeumHRBa06bGNXV8rGtv++cPRtlRxxXNjse/Ze0tm5z5YAFx3lRD9fvluGSjlXb8Hc=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8657.eurprd04.prod.outlook.com (2603:10a6:20b:428::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 02:35:37 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc%4]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 02:35:37 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kw@linux.com>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [RESEND v2 4/5] PCI: imx6: Fix the clock reference handling
 unbalance when link never came up
Thread-Topic: [RESEND v2 4/5] PCI: imx6: Fix the clock reference handling
 unbalance when link never came up
Thread-Index: AQHXwY4ue+QOjCGA8ESB+dHo+5+VOqvUZ7iAgAAAjYCABY9dgIAEuu9QgAGyB4CAAqmKcA==
Date:   Mon, 25 Oct 2021 02:35:36 +0000
Message-ID: <AS8PR04MB867639048E1F4F0AAC2347048C839@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20211015184943.GA2139079@bhelgaas>
 <20211015185141.GA2139462@bhelgaas>
 <AS8PR04MB86767ADAB5021E1C320094148CBD9@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <AS8PR04MB867697359A6D51903D0098308C809@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <YXPbozFVw25gVGvW@rocinante>
In-Reply-To: <YXPbozFVw25gVGvW@rocinante>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f36e8698-0e16-4dc8-9ac1-08d9976020a8
x-ms-traffictypediagnostic: AS8PR04MB8657:
x-microsoft-antispam-prvs: <AS8PR04MB8657B9177B9062D26AF5640C8C839@AS8PR04MB8657.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:569;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xs4ZXUSZfZhIhenrXTyZvrdCjYvO6zKPOy67hsiBiiTBmVf2hgTWvl3Ck9l8fWd/tTmsJirvgarQU3XLH0RdBJNGOQhPmcH7WUCRoW7P7r4q3f/7oWgDOQ97bmsSbJ2q22Jg6F8znNWrEHk7u+e7w1W87nrmiLI/cwl7jlZwsZ3imfho30+egaUnJYKDfPK5Dit3a4ZxjBYasD9FdQZEfRYYF3n7iX43tyYdgy/Mcxeu1PctsqSxRV4KMOzCsIpRol/uT4U8K7JvX+us8jZP5pAB1uUrbau2wg4ZMGtJbMiCwvZPWNEpjGE0XZlFNHvAjXVVo+O3kqLIqP6cDDppzD9THCBKMLMQ37ZcMyx1Qqk+nFxZT25a5QAB/TxubbY06quhw8tfugJGB2R7LqtieBbLl878bSIJC18oaLOUnYCyUcfJUb6e0lvUdwHbVk8s3Y46mjXFfhsq+CvHDPIJo1TJ+kqA2j98/zsvgIK1hNl+XN82MSVrKBW8+zdxNw5NDOHAPMIqcQi8EK0Cv38hqN8HnkNa1qQ7zL7K9z4RMRNdy+W6mtz3vtJm3Ok2LbFz1uKfhbi9ze+58elMlE0bu5T6/5n/rheVXIHK8BZhSHEHXYZX16NtNS+/sXBCBPLsW7I0vLJKq0cUfs7j90iibeZRNJfaLliDpr8lVLRUXDFeB0auXEj1Sqg2TFgacjFJRSp5mlewr1V0c+AiDbkiFw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(33656002)(83380400001)(2906002)(6916009)(5660300002)(53546011)(9686003)(38100700002)(8936002)(64756008)(186003)(55016002)(66446008)(71200400001)(66946007)(8676002)(122000001)(66476007)(26005)(6506007)(66574015)(52536014)(7696005)(4326008)(54906003)(316002)(508600001)(86362001)(66556008)(38070700005)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eEh0Q0VIMWpub0ppM1hpTXErU2ZvRkpRYmt3U0EzZDhTUnFSOTZmR2JVbWtp?=
 =?utf-8?B?Zk81WEZxMjhXVDZSODhkUjY1SnRyb1JSbjdSVXc0TTV4UjJ4WkJoVGtCaGc4?=
 =?utf-8?B?eWdCbk5JdG4rN2hsU0VvS1p6NzVQeWVmUlcxVk5PVWNaekJ1clJFbzAvOWt0?=
 =?utf-8?B?NUlhZDNMajVaN1BzNXhqNXZJZ2Q4Wmx6L3ZoMis2V2VlOU84K0dSZFhjQUZK?=
 =?utf-8?B?NXMvMTl4NnR3TzQwSW9EN3JORFJlSnFIUzFTNll2VStubHQvTXFWTUlEYmpu?=
 =?utf-8?B?WGZWNGJ3NXE2aW8vNUVxUkVOY1VkSWpNanFZbjB1WWhSRGJiNGlXL29ZUWpM?=
 =?utf-8?B?bU52SzFhSlJmTDhPdjBud2lBSnlzYjlLbTQzSFpnQ09xSmdUSE0yVGtvc2M3?=
 =?utf-8?B?TGZ4WjAzSjViOXIyNFVZaTRVeUVLYWpMa0RmaXZHa21zejJtVEtvblVIK0JF?=
 =?utf-8?B?NitBU2FVS01iREZ1MmNZVWtyWGtLYitXTzBOT1A5ZTdDT0dBUnBjZmVwWjVB?=
 =?utf-8?B?MEpIZncwdkk1dTZDQXJ2ZkRYWnI1bDhRckk2YUk3dFRIaE9WNXZuZDJvRjdz?=
 =?utf-8?B?ajMxMGRIdFhkeVIrcHRrT1NtU1FNZkdRaFNRNEJWVEVrV1o1VXdoNVZjTnRY?=
 =?utf-8?B?dEFjZjI3cXZMN0FtYTlYTlNOeGVJT2xFQXhhbTdBUXVvZTdJckF5WkpyTE14?=
 =?utf-8?B?V1FaeVlQMXdkQ1Z2YzAxM2ljUUhuaEVtTGtEcGR5NkdXZWRDWjhveXcwZHVK?=
 =?utf-8?B?TkVhY1MwOTNNcGlGM2FiTGpIUitKdnI3ek8zKzZCVVQ5QU9NcU1nZFFseGky?=
 =?utf-8?B?WG4vNDY1enZ0aUJHT1FLejFrTjF5TnR2R25KbG5idHRVVnlxUmY1TkpjbEF4?=
 =?utf-8?B?bHpmaTVhRVFITEhLNUM4TW5mcGJ1QTVMUVB0dXJnVlJScEkvRk1GeGxVeEpr?=
 =?utf-8?B?cTBBUzI3d2hRV09kdjl2OXVJbGVtVXMzL0VGVDJtNDZiV2tzSGZuQ2NXSWlJ?=
 =?utf-8?B?Uk1MV3lLVzZWRDljWU1ROE1ac01PdU1vQ2dUbGZyY2IyckVCVzZjNEdqeDVP?=
 =?utf-8?B?dzRpWVFYSGc1ZmxKOVMwZHRmL3lSWnQ3MTFpaHNpSjBaZnp1V1R2SUhvc1dX?=
 =?utf-8?B?TEd1Z041S2dkb0d0NktYZU5YMkhMVTZLUFRuTkdNL2RTZ2tYd0FOd3dPa3Vs?=
 =?utf-8?B?L1FpSGxFY2xxcGRBUXBuOS8xaVVTQjJYRnBScFd2akFoZW1Qa1pPUlJsOWp1?=
 =?utf-8?B?MldmRVNIR0Uwdm9nbzQ5djVtQTZkNHNJRktlVnRkQlhoemduaE9NNDZySzQv?=
 =?utf-8?B?TVFtMjNjUkpNVmJwMFpheW5kSWxkcUY2V3UzMy9WekhHRWJPd05GUmJIQ3Nh?=
 =?utf-8?B?NXZWSjI1VE9EVGQ2NXJFMEkzZmIxZk4raDdMQmRtREFmcllZK1pkSldSWmgr?=
 =?utf-8?B?THNSMkFBaE9mTU9vK3R2QjlXK0NxM3hkdUlnOTN2eEQ0NTIzQlY4ZzNxVEts?=
 =?utf-8?B?dEwvaDdvcnZON0hGUFFySGlsa05JMGx2aDdVbFNuSG0wWGFsYXRwMXZOcThq?=
 =?utf-8?B?QzRvZ2FKd3dnVkRTSk9PNHhXeDB6Y3VlTFpWbUJ5QkR5Q2xrRi90aWQ3R1ZS?=
 =?utf-8?B?N0JibFNIWFlHeksvaU5Mc3VLWGE2ZElqVVNtN3BWY0hwSlpZSWR0eEl5YStG?=
 =?utf-8?B?ZlpkWkZRSVNxOTNKWVp4OHhNWmFCWjNOTmJHT1cwVDJ2N3lIZ05IL0pEanZ0?=
 =?utf-8?B?NFYwa1lGNVdxdnkyNDZ0eE5tN1B4dGRyZDN5cHJaYXNrVVJiQ2dVTjVyMDJ4?=
 =?utf-8?B?ZDZwQVNOOUNoeUpDa3A3ZXhjSXMrdm5DSUpBR3UzOFNJTXkyaFg1b2MvTHEy?=
 =?utf-8?B?YnJlcUhMaXNXTWFuTTRtMUlrSlZUMlhRTWphRE9Ed2M5U2Jaa3dQNDdCSXBF?=
 =?utf-8?B?MWNsdUpibXhGWEhtZFdaYlM2V0JRMzUrRG50RTZaT2xRZm15alV3YkhsTjh1?=
 =?utf-8?B?SlRScU0vY2ZOZXBveXBKSkZLUkp0Y0Q1eGRIM0NKZHN0NXA5SUd4MVlkandj?=
 =?utf-8?B?SksrendiMENkNk02RWNxZXJjTnFnQ3NjZjV6VnRybmFBQklIdytQUlFpa3lY?=
 =?utf-8?B?NUtoSlNXTVdtMnMxc1dhb0NhWUIwK1FJL1gvdXlHTGUrSHJiYXNoMmM4M0w1?=
 =?utf-8?B?cmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f36e8698-0e16-4dc8-9ac1-08d9976020a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2021 02:35:36.8906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fnBHtBWqO/TSEPGqogxVbPOthk89xea6LXpr0scAl+A0fayFRFGSH6a9kTR4xnrfU/f8jOfelDFsK0r0FK2E2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8657
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgV2lsY3p5xYRz
a2kgPGt3QGxpbnV4LmNvbT4NCj4gU2VudDogU2F0dXJkYXksIE9jdG9iZXIgMjMsIDIwMjEgNTo1
NCBQTQ0KPiBUbzogUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiBDYzogQmpv
cm4gSGVsZ2FhcyA8aGVsZ2Fhc0BrZXJuZWwub3JnPjsgbC5zdGFjaEBwZW5ndXRyb25peC5kZTsN
Cj4gYmhlbGdhYXNAZ29vZ2xlLmNvbTsgbG9yZW56by5waWVyYWxpc2lAYXJtLmNvbTsgbGludXgt
cGNpQHZnZXIua2VybmVsLm9yZzsNCj4gZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47
IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsga2VybmVsQHBlbmd1dHJvbml4LmRlDQo+IFN1YmplY3Q6IFJlOiBbUkVT
RU5EIHYyIDQvNV0gUENJOiBpbXg2OiBGaXggdGhlIGNsb2NrIHJlZmVyZW5jZSBoYW5kbGluZw0K
PiB1bmJhbGFuY2Ugd2hlbiBsaW5rIG5ldmVyIGNhbWUgdXANCj4gDQo+IEhpLA0KPiANCj4gWy4u
Ll0NCj4gPiA+ID4gPiA+IC0JZGVmYXVsdDoNCj4gPiA+ID4gPiA+IC0JCWJyZWFrOw0KPiA+ID4g
Pg0KPiA+ID4gPiBXaGlsZSB5b3UncmUgYXQgaXQsIHRoaXMgImRlZmF1bHQ6IGJyZWFrOyIgdGhp
bmcgaXMgcG9pbnRsZXNzLg0KPiA+ID4gPiBOb3JtYWxseSBpdCdzIGJldHRlciB0byBqdXN0ICpt
b3ZlKiBzb21ldGhpbmcgd2l0aG91dCBjaGFuZ2luZyBpdA0KPiA+ID4gPiBhdCBhbGwsIGJ1dCB0
aGlzIGlzIHN1Y2ggYSBzaW1wbGUgdGhpbmcgSSB0aGluayB5b3UgY291bGQgZHJvcA0KPiA+ID4g
PiB0aGlzIGF0IHRoZSBzYW1lIHRpbWUgYXMgdGhlIG1vdmUuDQo+ID4gPiA+DQo+ID4gPiBbUmlj
aGFyZCBaaHVdIE9rYXksIGdvdCB0aGF0LiBXb3VsZCByZW1vdmUgdGhlICJkZWZhdWx0OmJyZWFr
IiBsYXRlci4NCj4gVGhhbmtzLg0KPiA+IFtSaWNoYXJkIFpodV0gSSBmaWd1cmUgb3V0IHRoYXQg
dGhlIGRlZmF1bHQ6YnJlYWsgaXMgcmVxdWlyZWQgYnkNCj4gSU1YNlEvSU1YNlFQLg0KPiA+ICBT
byBJIGp1c3QgZG9uJ3QgZHJvcCB0aGVtIGluIHYzIHBhdGNoLXNldC4NCj4gDQo+IEkgaG9wZSB5
b3UgZG9uJ3QgbWluZCBtZSBhc2tpbmcsIGJ1dCBob3cgaXMgYW4gZW1wdHkgZGVmYXVsdCBjYXNl
IGluIHRoZQ0KPiBzd2l0Y2ggc3RhdGVtZW50IGhlbHBpbmcgSU1YNlEgYW5kIElNWDZRUD8gIFdo
YXQgZG9lcyBpdCBhY2hpZXZlIGZvcg0KPiB0aGVzZSB0d28gY29udHJvbGxlcnMgc3BlY2lmaWNh
bGx5Pw0KPiANCltSaWNoYXJkIFpodV0gTmV2ZXIgbWluZC4g8J+Yii4NClRoZXJlIG1pZ2h0IGJl
IGZvbGxvd2luZyBidWlsZGluZyB3YXJuaW5nIGlmIHRoZSAiZGVmYXVsdDpicmVhayIgaXMgcmVt
b3ZlZC4NCiIgIENDICAgICAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYubw0K
ZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYzogSW4gZnVuY3Rpb24g4oCYaW14
Nl9wY2llX2Nsa19kaXNhYmxl4oCZOg0KZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlt
eDYuYzo1Mjc6Mjogd2FybmluZzogZW51bWVyYXRpb24gdmFsdWUg4oCYSU1YNlHigJkgbm90IGhh
bmRsZWQgaW4gc3dpdGNoIFstV3N3aXRjaF0NCiAgNTI3IHwgIHN3aXRjaCAoaW14Nl9wY2llLT5k
cnZkYXRhLT52YXJpYW50KSB7DQogICAgICB8ICBefn5+fn4NCmRyaXZlcnMvcGNpL2NvbnRyb2xs
ZXIvZHdjL3BjaS1pbXg2LmM6NTI3OjI6IHdhcm5pbmc6IGVudW1lcmF0aW9uIHZhbHVlIOKAmElN
WDZRUOKAmSBub3QgaGFuZGxlZCBpbiBzd2l0Y2ggWy1Xc3dpdGNoXSINCg0KQmVzdCBSZWdhcmRz
DQpSaWNoYXJkIFpodQ0KDQo+IAlLcnp5c3p0b2YNCg==
