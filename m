Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 009E543BF03
	for <lists+linux-pci@lfdr.de>; Wed, 27 Oct 2021 03:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbhJ0Bc3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Oct 2021 21:32:29 -0400
Received: from mail-eopbgr60062.outbound.protection.outlook.com ([40.107.6.62]:64771
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237503AbhJ0Bc2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Oct 2021 21:32:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aaMlpzf8FsjL218PM4b1qHRiHxIkZBQxphbK/538wWdqITZLOTmi+EFx0rCxuDhjaIz97Gdt9sZIilYvjil1xr3C5si3hatC/Ev0qyBHP3QD2KQsofUmp3L9oblEXIvepEbe2cRVGiAkFGh8+KQCtrupgWbc/TQSsxg82egbGH2RY0wQXxiNosIjXpXXta1lvLa68JK6MnHkDTF9+OPNHd2fxenU8ohxIEtpe+9MPGYuSKNuIh0Z55cPPW+kTtM1nTmT6AY/L+kuD/7r5hG0qjgqO4/EppnxsueV2S4HPG85UpyYArYzprLl+520GbnaRRvCQe9c9zd4AEws6ZsWAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PzZDPSASCZ0pNPo4QfKUQ/lt9WetWNdFN+KJQyeZOuk=;
 b=JLCseLEAzKo8RX5S7lqW+0U33E8yguN14udnxJfCVGdad7cxhfYTzmaa9mUccnMFTEpB0OOXXHZ2LpZ7oRFbmEEDfnZ5f3qceHQr/bLTWhzW+LuM9qKU8hf3913R++mzyCmWJkCztREWet2O6XanlDEonTsc1+j3n9jDpi1E3LzhyH+SY7n0nJfD+oA4k/Ji6OhMk4iYhutQgqZLJNLqfLoOcukX787In8QKJrh5gCYcm3qCmcIVGO1dDG6DzmAuvuzncg5yZXNgHwHU/OMJuW3tleHuSzSLru3pvXp1kDhaSnuhPxsnvmsM0cVQfyGo4Kd1MiRBakjnmubxA9uC/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PzZDPSASCZ0pNPo4QfKUQ/lt9WetWNdFN+KJQyeZOuk=;
 b=V4rM1kN7nRq3vYA+NNio7QPg46qHkT48e2sHC2C2406dnuzSM3G/gcFGTS0Cn43ZzMSzbV/EKcMU2+K49xxP/L2s59Z3uCW/sbAjIjdPimxZC6ogPxQYPW6kL/knEZIO+dXADanB29QNjODR9HNUScxk6O+IGf9Z44sNyQ/di54=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8962.eurprd04.prod.outlook.com (2603:10a6:20b:42d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Wed, 27 Oct
 2021 01:30:02 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc%5]) with mapi id 15.20.4649.014; Wed, 27 Oct 2021
 01:30:02 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kw@linux.com>,
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
Thread-Index: AQHXwY4ue+QOjCGA8ESB+dHo+5+VOqvUZ7iAgAAAjYCABY9dgIAEuu9QgAGyB4CAAqmKcIAC3nyAgAA0cfA=
Date:   Wed, 27 Oct 2021 01:30:02 +0000
Message-ID: <AS8PR04MB86769F5EBF9AF10DDC3F7AAD8C859@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <AS8PR04MB867639048E1F4F0AAC2347048C839@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <20211026222147.GA173173@bhelgaas>
In-Reply-To: <20211026222147.GA173173@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b4c71c42-7472-4f92-150e-08d998e94c5e
x-ms-traffictypediagnostic: AS8PR04MB8962:
x-microsoft-antispam-prvs: <AS8PR04MB8962A4873336D40B558341978C859@AS8PR04MB8962.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:175;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 23kYfiFjUX/wz1T3SYABw3PBT62LKY5yLuTRvHGUeHBLHIQVErnZzW5QScGRxrtEQIU4ZeehQVMNe+rwMYjbvCe1v5vS1m431qg1k+42AvjMka31mQSjvkecKjWNPFKHhIuRgU7hqtgHPtv24U1tQKoiHO7C846hfBtfhrnthpd+Ym0evSCFC2LxoJ+I/4wTjE/CeHbb8jlJmsPeGSECFTtROL5YZYi5GJkOB6cF2Vfgmmet/pyJexN6dqGoeGXLuQWFxPcOvyXvG4swwcJRVv63vmexsLCOkpWoPm+qC2roG4PcQUwZlirXyPe1IGI/un0hBVJqzbHFJOstj7isHEw7ZgCalOgOPvN9PTFQB3bVNN3hMb1JpRfrB8ezrOG0Ap0nUfWIWtjk+HEZsFWtvEbNNFDxFvVTdfTUAUEQJlco7S52EhHXdDwEbt69z7sJID7Buz9uK5vE8vuhUQ7N5Mf64Av3I4Dghll89iRM0dX3K6flQB5Klf4Iht24Tk9gsJUIBcfEKJORqtrUODM4SxdwXhvBYAQ+Pw7QlpwueGLg68jaxDFvWg43fR0FFmsAvbWh67KZwZ+DnfxGF2RqvVb1MPPJLOwcm4tECdsD/RlWqR6XVZnfDSPB3trY/as2QAflGEVFdQ2BBjvny75d2CrvVQgr0F7OSugtq9HIRsPt3Z72NWThLTsTIA/blJFnlRa1tFUgX6UgP2M8rbD+Vw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(316002)(54906003)(83380400001)(71200400001)(86362001)(53546011)(26005)(66446008)(66574015)(8676002)(5660300002)(52536014)(66476007)(55016002)(66556008)(6916009)(122000001)(64756008)(76116006)(38070700005)(33656002)(66946007)(9686003)(6506007)(38100700002)(186003)(8936002)(7696005)(508600001)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OXNvakVpR0YrcVZzS3NNWWsvTkVTMEM1eGN0bmRkS0x0L1o3WS9lUGVVeTQv?=
 =?utf-8?B?Y1dyVmR3TzZWVkxQKzE4YmV1VDBGeW9tWUhVQmFuT29Ob2FyWnlxVWtlek5H?=
 =?utf-8?B?YUpEc1dvNVB4Z245bHpKUGJKa21uODA3M2RiN2c2ZlFzK01WVnRySWVudFBz?=
 =?utf-8?B?enJodWYrYkc3cFVGVzVXQlFoZVpiOW1QOTg5ZW8vb0hQbHpveHlyeGFCRytJ?=
 =?utf-8?B?N2VpamJyQVNOSUJMb04yMkNyTnpDUVZsZU5BY2k2dVRqQWlMTVZTdDNRcGwx?=
 =?utf-8?B?YyswQ1FIYjVFdWQ5VjRHL2owS3p2TEhUOU5YbEwrNWp1cFBGZEFTSE41NUJY?=
 =?utf-8?B?eStqSVgrd3RSekhVbHdnZ0hyOFYybWxGenpqamNTRDRkM1BzN3kweE04c1dv?=
 =?utf-8?B?V0hndzZiTzBib3NmMVArZjg1V3BRRnRMaS95U1VaQ0VPcHdZSFB1Q0ZqQ0po?=
 =?utf-8?B?cXZ4TEd1WmE3WEpWRTY3c3lFMERZUTBQRGh5QlBZMm1xbWllK0ZHdlZCYlpJ?=
 =?utf-8?B?WkNwRENOYkcrWWtWY2tjK0dLajFZbHFoV2VndWlHRk44eC9LdjFsU0VDU2JE?=
 =?utf-8?B?NDRwZWpmWjV1WU9XbnU1dFJiME5DeEtCZGR5RGF1R0VZdnJOMnluSUVjWHo5?=
 =?utf-8?B?dG44ZnZrajhKaWJ4dXpJaXRtTWxjUCs5OThoYVFnSTNkd3cydFZIRFpNUXdQ?=
 =?utf-8?B?L25TYUtHZEJ2UUtVbVMvY2lyUTJyN0NodHc5MVg2NWxoaVQ1d29lRk8rMGpF?=
 =?utf-8?B?cUtlRmpsMmp4WnFIaXJySnN5WUJWNk5kemIwa2ZLU0Jtd1lGYktPMzlXV0Z2?=
 =?utf-8?B?SUkxcGlyR1lrV2lYeEh2UzJ4NEp3Z0E1V2JwaGZ4bC8wb2o2MDdBS1Q3NWN0?=
 =?utf-8?B?RmJmZVJyNk9wQkVUb3pIazRNa0ZRNlc1UEozVnF6clhwNDBhU2JoakZuNWI4?=
 =?utf-8?B?dlVUOXpvMUVOaHZ5VkpadXZEWlhpSFpuRzNPNmM4VEh3d1NPTnFoVEtmUEs0?=
 =?utf-8?B?YjJMWFVCZGZ2ZVgxMitKR0xUbTFTcFhCL3MvTEZnMUl4a2xqV2JsV0MvNHpZ?=
 =?utf-8?B?UHViNytHVTRlamR1Qi9LUTZRWDArdG5RVnhMbGwzRW5FajJzSHBBbjNFU0tR?=
 =?utf-8?B?dnB2VmYzUC92Z3JmQUJmbC81eFJyWm94eFFQWlhnMUJWWUVjV0RhRW5iVVdQ?=
 =?utf-8?B?aW9iZ1RwRzIrVXZmVzNXN3FyYzdHYnJ2bDV3Y25OUnVsUkpTM0JYVG52YkFK?=
 =?utf-8?B?dXNwSUVvQ1BMYkwra2RWcHU4eFUwR01TK0hCWk5WR3AzZUgrOEFhbStMWkRj?=
 =?utf-8?B?Yndsd0lZcEtqOHIwd1hDeFBFcjhtZ3lCa2NwYWF6VW1YbTRveU5LdkpmRUtX?=
 =?utf-8?B?OFRFWm0vUHpXVmdPUjUvYVhzeGtvS0N5SU44NWlORHYza2VST2cvOEg1V3c4?=
 =?utf-8?B?ZlZQMTJWeU5CYWUrbU9FbkZMekpiWTViUExQMm9ac1FsN1duMzMyRjBQNW1O?=
 =?utf-8?B?NFJBQlUweGFrSWZvTi8xbFo5UjBKd2FOSmNaZlRpYjZmeU9iWHNsRjZ5eUR5?=
 =?utf-8?B?dUJCdDNCZUQxV1ZhMVFRNisyWnRKL0pITW4xc05MNkNSUVVrakU5bzdvQXdn?=
 =?utf-8?B?YWRHdWhBdmNDelcvUU5wT2g1VkN0SnZMclRMWkx2NDZXYWw1V0QrQWQ0QXg3?=
 =?utf-8?B?RDNjM21wRDJHMTk5Y0ZOajRuSXRIaHdsNVh6dU5QUkloRDlETnFMMmRGSktE?=
 =?utf-8?B?UlpvZ1NUYnk2ekpYYUVtVlJNRDhNNzd5SisyM3ZhaUM5dE1rR3Q0T21MQUZD?=
 =?utf-8?B?ejE5SlV2L2ZtbThlM1YzN3FjY0pWQ2pCMTBjWm1DRXZnSGs1R3NOUGhmY0xV?=
 =?utf-8?B?OVEvRkdGNDJjUWVyWEFOaERuU0hLUFdTdXo3ditFVUlENlBpa1JwRmE2VThQ?=
 =?utf-8?B?VE9HdzJKU1I2Z09PdHd2UDhpeXZkYXVkYXd4SXFDaDNkRmpUcndvYzgvU0p3?=
 =?utf-8?B?N2Rzd1RPNkt0akMrV2hzWkYrNkFSZ2txWUlxRGtzMHllQllmdDZOT281RUNp?=
 =?utf-8?B?TmNpVUxYWDQ2amE2UzNBbm9zNEw4RldUbVVmVXAxWmVDMktxa2t3eEh3bmwr?=
 =?utf-8?B?OXpaSDNNejB1R0w0SEVGYTlPNzU2WjlQZG1hYlpLSVNod2g5WWVWNEkvYldC?=
 =?utf-8?B?V3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4c71c42-7472-4f92-150e-08d998e94c5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2021 01:30:02.4188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +UQufDhvN6+zT/gH1FS+ANNAuNMiOrAEmD2TNQWPctrg8Ur++zow1vUEUiWFQt1BfxbNOfKbJkh9LFkpADw56g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8962
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCam9ybiBIZWxnYWFzIDxoZWxn
YWFzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFdlZG5lc2RheSwgT2N0b2JlciAyNywgMjAyMSA2OjIy
IEFNDQo+IFRvOiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+IENjOiBLcnp5
c3p0b2YgV2lsY3p5xYRza2kgPGt3QGxpbnV4LmNvbT47IGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU7
DQo+IGJoZWxnYWFzQGdvb2dsZS5jb207IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207IGxpbnV4
LXBjaUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+
OyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IGtlcm5lbEBwZW5ndXRyb25peC5kZQ0KPiBTdWJqZWN0OiBSZTogW1JF
U0VORCB2MiA0LzVdIFBDSTogaW14NjogRml4IHRoZSBjbG9jayByZWZlcmVuY2UgaGFuZGxpbmcN
Cj4gdW5iYWxhbmNlIHdoZW4gbGluayBuZXZlciBjYW1lIHVwDQo+IA0KPiBPbiBNb24sIE9jdCAy
NSwgMjAyMSBhdCAwMjozNTozNkFNICswMDAwLCBSaWNoYXJkIFpodSB3cm90ZToNCj4gPiA+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBLcnp5c3p0b2YgV2lsY3p5xYRz
a2kgPGt3QGxpbnV4LmNvbT4NCj4gPiA+IFNlbnQ6IFNhdHVyZGF5LCBPY3RvYmVyIDIzLCAyMDIx
IDU6NTQgUE0NCj4gPiA+IFRvOiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+
ID4gPiBDYzogQmpvcm4gSGVsZ2FhcyA8aGVsZ2Fhc0BrZXJuZWwub3JnPjsgbC5zdGFjaEBwZW5n
dXRyb25peC5kZTsNCj4gPiA+IGJoZWxnYWFzQGdvb2dsZS5jb207IGxvcmVuem8ucGllcmFsaXNp
QGFybS5jb207DQo+ID4gPiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXgg
PGxpbnV4LWlteEBueHAuY29tPjsNCj4gPiA+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZzsNCj4gPiA+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGtlcm5lbEBwZW5n
dXRyb25peC5kZQ0KPiA+ID4gU3ViamVjdDogUmU6IFtSRVNFTkQgdjIgNC81XSBQQ0k6IGlteDY6
IEZpeCB0aGUgY2xvY2sgcmVmZXJlbmNlDQo+ID4gPiBoYW5kbGluZyB1bmJhbGFuY2Ugd2hlbiBs
aW5rIG5ldmVyIGNhbWUgdXANCj4gDQo+ID4gPiBJIGhvcGUgeW91IGRvbid0IG1pbmQgbWUgYXNr
aW5nLCBidXQgaG93IGlzIGFuIGVtcHR5IGRlZmF1bHQgY2FzZSBpbg0KPiA+ID4gdGhlIHN3aXRj
aCBzdGF0ZW1lbnQgaGVscGluZyBJTVg2USBhbmQgSU1YNlFQPyAgV2hhdCBkb2VzIGl0IGFjaGll
dmUNCj4gPiA+IGZvciB0aGVzZSB0d28gY29udHJvbGxlcnMgc3BlY2lmaWNhbGx5Pw0KPiA+ID4N
Cj4gPiBbUmljaGFyZCBaaHVdIE5ldmVyIG1pbmQuIPCfmIouDQo+ID4gVGhlcmUgbWlnaHQgYmUg
Zm9sbG93aW5nIGJ1aWxkaW5nIHdhcm5pbmcgaWYgdGhlICJkZWZhdWx0OmJyZWFrIiBpcyByZW1v
dmVkLg0KPiA+ICIgIENDICAgICAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYu
bw0KPiA+IGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmM6IEluIGZ1bmN0aW9u
DQo+IOKAmGlteDZfcGNpZV9jbGtfZGlzYWJsZeKAmToNCj4gPiBkcml2ZXJzL3BjaS9jb250cm9s
bGVyL2R3Yy9wY2ktaW14Ni5jOjUyNzoyOiB3YXJuaW5nOiBlbnVtZXJhdGlvbiB2YWx1ZQ0KPiDi
gJhJTVg2UeKAmSBub3QgaGFuZGxlZCBpbiBzd2l0Y2ggWy1Xc3dpdGNoXQ0KPiA+ICAgNTI3IHwg
IHN3aXRjaCAoaW14Nl9wY2llLT5kcnZkYXRhLT52YXJpYW50KSB7DQo+ID4gICAgICAgfCAgXn5+
fn5+DQo+ID4gZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYzo1Mjc6Mjogd2Fy
bmluZzogZW51bWVyYXRpb24gdmFsdWUNCj4g4oCYSU1YNlFQ4oCZIG5vdCBoYW5kbGVkIGluIHN3
aXRjaCBbLVdzd2l0Y2hdIg0KPiANCj4gU29ycnksIEkgZGlkbid0IHNlZSB0aGlzIHVudGlsIGFm
dGVyIGFza2luZyB0aGUgc2FtZSBxdWVzdGlvbiBhcyBLcnp5c3p0b2YuDQo+IA0KPiBTaWdoLiAg
VGhhdCdzIGEgcmVhbGx5IGFubm95aW5nIGdjYyB3YXJuaW5nLCBidXQgSSBndWVzcyBJIHdvbid0
IGZpZ2h0IGl0IDspDQpbUmljaGFyZCBaaHVdIE5ldmVyIG1pbmQsIPCfmIouDQoNCkJSDQpSaWNo
YXJkDQo+IA0KPiBCam9ybg0K
