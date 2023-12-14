Return-Path: <linux-pci+bounces-1027-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A3D813E5F
	for <lists+linux-pci@lfdr.de>; Fri, 15 Dec 2023 00:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 701C21F22ACC
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 23:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA996C6F9;
	Thu, 14 Dec 2023 23:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="DoRaQdN3"
X-Original-To: linux-pci@vger.kernel.org
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2126.outbound.protection.outlook.com [40.107.114.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C5C6C6C3;
	Thu, 14 Dec 2023 23:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g8PbzL7kAiMyxygfeVgBr0afYjoaB1AOipqOfXpTQsL39Oqqd1HcOhWZcwGlaJzMGkW5XRPmS/1Ii10r5XLtjc+fuxAcKcumzKplFHDiXJ7pT4aF9mxP8t5K0S4i/wdF2E7E1AbQtxdpEXHiuAx0cTSeC5n26pY47aa1BDL1eswYZb03fQXyKi3oGPP/mfHu8wyh9Y8UF1zOb85heA5CJjT6b1fnjYD3xDfzPtEutRPhkWOWIwbNEVlOsKG9pHWAm3mny54oeADY4nVRPlz7fneadjhquLCT/c2Wvt20nowKvWyYk/ef8XuLYio068FP34MJtjCzUlNjue5y6ccdcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P6H/GXmlF3sRtIf4UIncvHt6T0yDn9g5ZT6vpeqkJA8=;
 b=XrgIuZPNrCGfHjYV6lGRs3qaRjxvqhVR1/K6noNevJw3BsvhIh767xFM4mtOQyAwodGybq66/qZ+AzWrODWzXLrhX8v9WbdNnnbZvkcgqDWadzDyb1mr2mYYtaUM0tzDH/+gayrIhKb4ClgovS5PEyzz1+74tUsMe733RfpPPAVv4hjEFp8TVF85seXPzr7bVfAICPjWtEvLMV+Yjp0sBbqHZ1CBSc0kFeZ32A1eTgmLi95pm5euymLJYOtDmYLRrsR4IDPXT6j4PBU+5uDu0+Jj3Pkq8ah2ko5/g6H2qxVcSSiSIL6c0rw/GnubKOnR8zWB3Vyeo55S2vpJpXgNaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6H/GXmlF3sRtIf4UIncvHt6T0yDn9g5ZT6vpeqkJA8=;
 b=DoRaQdN30mKzJ9mpO5irJMOKlRLmTO+sElzenGvTDgyQpH+KcH3MYRPlS7j1SPCBARDFrNdxDwMPf5/w7Wxl0TRfBxxtUb4YAhSrcJANYHsWJWDYbupxxc78UHTAvZd7PGN93QWVplDIxnA7beY6P1oDLm9DkO43cnoyL00nR94=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYWPR01MB8872.jpnprd01.prod.outlook.com
 (2603:1096:400:16f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Thu, 14 Dec
 2023 23:44:53 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::50f5:eb2b:710a:b7c7]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::50f5:eb2b:710a:b7c7%7]) with mapi id 15.20.7113.010; Thu, 14 Dec 2023
 23:44:53 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: Manivannan Sadhasivam <mani@kernel.org>, Serge Semin
	<fancer.lancer@gmail.com>
CC: "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com"
	<kw@linux.com>, "robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2 0/6] PCI: controllers: tidy code up
Thread-Topic: [PATCH v2 0/6] PCI: controllers: tidy code up
Thread-Index: AQHaFr8c7F9KjBCkD0OuoYfB8iOexbCoPaMggAB38YCAAAzQgIAA3png
Date: Thu, 14 Dec 2023 23:44:53 +0000
Message-ID:
 <TYBPR01MB5341C6AD3B0E3EE66F2C7FABD88CA@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20231114055456.2231990-1-yoshihiro.shimoda.uh@renesas.com>
 <TYBPR01MB5341F846948DB6CFECA62187D88CA@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <rrgcf2jagjkiczb5tt56qm2jwvfyaor2mzjdqxrodrhzrn5j65@m7orqtcay3gg>
 <20231214102605.GK2938@thinkpad>
In-Reply-To: <20231214102605.GK2938@thinkpad>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYWPR01MB8872:EE_
x-ms-office365-filtering-correlation-id: c1655dae-70c1-41b6-9ea4-08dbfcfeab78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 0bTbPsFj1a1p1eVsgdzf0DoEd2SOatT/sssb2WsIhbxeNmaFmSsqSvEcGOrlbhtFcAODhIQ/bCJjksRps0/7cdCe4neqNgsgdPuf/b88xFewYddi1MAjJY4DWBHbPGyQpZAkYc0CLN/d5PrU92DKFQcrCMYVXAa+IOT5Zm+MGrA1qSOUXCvPY9/YjAMkMdFiTognVSg4e+K+4LRIeiuEBKFIKy3C8UknkUdUBXt8noqWZPT/5jDgZJSLgu+e4J2Wipku3qTP16NbynKH/ul3ZP/pEUujf45YkFdNrseMvGooyGQe+zLQzGhv0gWAMGVjI5ETvc5VIGHAPgGgMdr4ptra5+VMm5Rtnd/l9biprnCmtiUbhCsHWNcZBf14Mc2TgdPVund8dTzt03ITYsDOihmO8Hr99ZxxTmUUeh50VroUUepCC3QAXcaMuCbGYQznRIK0gxkHuvXEQJlImTDrNeS7GhU6s1Rg3MO/bM0jcmnobSAfzFNUeu8hQqta58vUtFoZuNR5swJHDrRn7uw0FITcWzE975lyRWZKPIaNHEZR6swWpEKk6wbCk2LP8mK9f6GSRVv8m8XVhssoaas3iwWSG00qAMsMn43WMBBsHrlZj12DtlR6xNHfz4VY7FejEzJvS2cGKL4qK2QWzGYZ/Q==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(366004)(136003)(230922051799003)(230273577357003)(230173577357003)(1800799012)(451199024)(64100799003)(186009)(110136005)(54906003)(83380400001)(76116006)(316002)(66556008)(66476007)(66946007)(64756008)(38100700002)(122000001)(52536014)(7416002)(86362001)(5660300002)(41300700001)(33656002)(2906002)(38070700009)(8936002)(66446008)(4326008)(9686003)(45080400002)(478600001)(55016003)(966005)(7696005)(6506007)(8676002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MTJtT0VJL2dnL2V3OEhySHBkUDlDb1E3Yk1rTlh3bEtaaXNyNzFnMHk4VXNy?=
 =?utf-8?B?REZ3S3BXL29KM0s1S2Z3bU1IdFVXMDlCUXh3L2Y4NjJQdWtxVXh0WFN4QUFk?=
 =?utf-8?B?cFdwN0g0akJuVTR5QURybmRaUHExZGgwQW1pdUJlM01PTG0xREErcmdpajNJ?=
 =?utf-8?B?M1psZ1JTd3BlRU5nSGNSYVV2UHJibGgxVEFjbzB6TXlkNDBVTjRmbEw4eFQ1?=
 =?utf-8?B?cGtJUFIyTTV5M2hxNXBVeW5URkpqSDR4Y1dRSzBuQWsrWW9oOC9seWcvNE1a?=
 =?utf-8?B?Sm5KQThqTUllRFdpUzRUQ3lKWklYZXc3YkNNdFZWalhSUy9FcUJtR3VFMk5Z?=
 =?utf-8?B?N2ZLeUd4TWlzYTBnazVNYUlvSGV3TE83b2RuQmFmN016V0xTcmxXdkNxV3BU?=
 =?utf-8?B?RUZnZHlDekhrVEYyY0pKeVFGcWEwZ3RkMkpuMHpPUktVUGVDcmRpeXdHcFNh?=
 =?utf-8?B?UU9SYUx4b0VZOElibVgxMnZiR1I5RmNnSWd2TGdzcnR0UVlkV21mbE0yRm1m?=
 =?utf-8?B?QndnT2FJWVZEUkwrMWFnUHY0QUtLUERuWkZsUXdmYlF6bHp4U3FGd3ZiQ25E?=
 =?utf-8?B?dmxFT05DbVcweGFxT1RDM3EzVGlWZEFmelZwQjRuNW5jU0xEdVo4ZDE3cDlH?=
 =?utf-8?B?ejhtNXcyMGczQWdROVZlWnEvaUhmUjVpdDV3bE43OWlJWDJPLy9qYVd5N1k2?=
 =?utf-8?B?bDlmZFRwWjVNbG5HcTlhbEJjZTRiNWJWQlhETzRjM1dCWWhBcWZDQ29naklI?=
 =?utf-8?B?VXNzRUpqM0VVOUhTUlg2YUdpWE5VUkJPTDJHM2NkeXErd2tJazV0NU1IQWRW?=
 =?utf-8?B?RENDMGtkeFQxZFZ6bFNLcU01dEZoK1hYU3ppR2xjYlN5VHNNSWJ4S08wWkYy?=
 =?utf-8?B?OWNUZ2YrN3pRdklqS1ZDT0UzQnNzRnhOK0t3dUVqWlJRK1FZbW5WeDNsOWQ2?=
 =?utf-8?B?dTRrOTdFNnFldFlLb0dNcGVKM2dqT09TRVFCUEtPWGxnRE9IbTVBMVlnNmta?=
 =?utf-8?B?eUcvQ3dWRTh1cVlBa1MvckM4ZHBPblBra0ZCOHUvQlRMaWsrWmdrU0xEd0l6?=
 =?utf-8?B?SXpTbE10c25QTDIyVExDT2R6RWpmazBTQlh1d2tmRktWeklxU2xLbGJSTXZr?=
 =?utf-8?B?SDd5R01GR3kzQTZaa2pXOFhZOTFWTy8wcThYcThGZ2YwYVhmTGExV1o2cWth?=
 =?utf-8?B?UG13QkZOQzkvTk1WSmpIVUEvRlJrV1R0aElvOGQxYW5wZ2VueE5XNE5EWExi?=
 =?utf-8?B?c2pKdkFpY2FtVDVDQUwzZlJFMGV3V3BOQ2FDWU5Pckg4SXBEYmYvQi9PaEdm?=
 =?utf-8?B?ODBDZTRkSkVqYUgxVW1ZK0lnTVJsRW9CUXFpTEgyUkF4V1RPc2lUcmMxcFJF?=
 =?utf-8?B?TFdBejVveWp5TS9MR2I0TUdqb1RFTWVrS1N2cDE0bkZGNkZhTXZkRWJQclpw?=
 =?utf-8?B?akE5UkFtNlNGN2dSVlBuamtGbWFjOE15dEl2VjA0SnJSV3lUTE5mY1doWFRY?=
 =?utf-8?B?K0l5enF0YTJmRmpSZmZkV21FZWxjNGwxemFGdURnb1B5U2hnLzR2R1pzUno4?=
 =?utf-8?B?RTMrMFprek9wOWVrNHFxeTNGdzgyTXlyWGdWd25wdmdzdnpINitmeXA0Sm9l?=
 =?utf-8?B?NWZBUjBFaldmNmpmbkJPZTlWaEtZK2FKRDJiRkRRNUNXUFRGM3VQSFlxVkpS?=
 =?utf-8?B?SFMzaW9RMEtacTJzelNiS2c0TFMxc0VSSlJ4NnFFVC9TVWREQW5NYStoeVVD?=
 =?utf-8?B?VmxIaU1WUHBGWFRpOGJ6RS85eDNPT0lxMlFnN0RVbXNRUlY4SVpBUiszam0z?=
 =?utf-8?B?cnREeHMvcHJaaUFleWNvRk1aM3BVdlNrNCttck5PdjVveFlra3MvaFZaU2J4?=
 =?utf-8?B?WFN3bE8rZUpHeXFWZXdWRGR4VlFsRkF5L3dHbkRmOWo2b3dBS013K1htWWRy?=
 =?utf-8?B?bVlCekxvd29qQTlTdjJyeVE3am00aGZ3ZHYwaHRjaVcrWWFmcyt6V2FJR1ZO?=
 =?utf-8?B?am93MkZCaHJhTFI5ZHZ5REVGbG1PaUxTNDZRWWFObEMxb2tuS0NUbkx3VExs?=
 =?utf-8?B?cHJmWVBaVGNUZW5rK1BwY2I4UXRXZUlGc1U3WWcyOTdVMWpCb1Fra3ZNK0FP?=
 =?utf-8?B?c0RldVJ5WVE1ZG5VZXlBdEN6NW80RUFKVW5qU1MycENZSTRTTFNUTHRNN0FD?=
 =?utf-8?B?WEQzYkFtaC9NbkxjeS80eTkxdlVweitiekRkcGtCSWtET3cwczRJU3BVVkU5?=
 =?utf-8?B?Mmg1U2t3UTVkM2NTWktERzlnYTBRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1655dae-70c1-41b6-9ea4-08dbfcfeab78
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2023 23:44:53.1701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xe+km5XpokSHavnOVkWqwnmew/m4lUshKFGColgob+Mw69JJavbcE/bdzKiWfE4hUXpPd04Z6VoOHU5d0OOHOubQzhFSlST5Ypz7rqhZt8PadNKLCjxP6bo7/wThB1i1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8872

SGVsbG8gTWFuaXZhbm5hbiwgU2VyZ2UsDQoNCj4gRnJvbTogTWFuaXZhbm5hbiBTYWRoYXNpdmFt
LCBTZW50OiBUaHVyc2RheSwgRGVjZW1iZXIgMTQsIDIwMjMgNzoyNiBQTQ0KPg0KPiBPbiBUaHUs
IERlYyAxNCwgMjAyMyBhdCAxMjo0MDoxM1BNICswMzAwLCBTZXJnZSBTZW1pbiB3cm90ZToNCj4g
PiBIaSBZb3NoaWhpcm8NCj4gPg0KPiA+IE9uIFRodSwgRGVjIDE0LCAyMDIzIGF0IDAyOjM1OjU2
QU0gKzAwMDAsIFlvc2hpaGlybyBTaGltb2RhIHdyb3RlOg0KPiA+ID4gSGVsbG8gUENJZSBtYWlu
dGFpbmVycywNCj4gPiA+DQo+ID4gPiA+IEZyb206IFlvc2hpaGlybyBTaGltb2RhLCBTZW50OiBU
dWVzZGF5LCBOb3ZlbWJlciAxNCwgMjAyMyAyOjU1IFBNDQo+ID4gPiA+DQo+ID4gPiA+IFRoaXMg
cGF0Y2ggc2VyaWVzIHRpZGllcyB0aGUgY29kZSBvZiBQQ0llIGR3YyBjb250cm9sbGVycyBhbmQg
c29tZQ0KPiA+ID4gPiBjb250cm9sbGVycyB1cC4NCj4gPiA+ID4NCj4gPiA+ID4gQ2hhbmdlcyBm
cm9tIHYxOg0KPiA+ID4gPg0KPHNuaXAgVVJMPg0KPiA+ID4gPiAgLSBCYXNlZCBvbiB0aGUgbGF0
ZXN0IHBjaS5naXQgLyBuZXh0IGJyYW5jaC4NCj4gPiA+ID4gIC0gQWRkIGEgbmV3IHBhdGNoIHRv
IGRyb3AgaG9zdCBwcmVmaXggb2YgbWVtYmVycyBmcm9tIGR3X3BjaWVfaG9zdF9vcHMNCj4gPiA+
ID4gICAgaW4gdGhlIHBhdGNoIDEvNi4NCj4gPiA+ID4gIC0gQWRkIFJldmlld2VkLWJ5IHRhZyBp
biB0aGUgcGF0Y2ggMy82Lg0KPiA+ID4gPiAgLSBEcm9wIHVubmVlZGVkIGxvY2FsIHZhcmlhYmxl
IGluIHRoZSBwYXRjaCA0LzYuDQo+ID4gPiA+ICAtIEFkZCBuZXcgcGF0Y2hlcyB0byByZXNvbHZl
IGlzc3VlcyBvZiBjbGFuZyB3YXJuaW5ncyBpbiB0aGUgcGF0Y2ggWzU2XS82Lg0KPiA+ID4gPg0K
PiA+ID4gPiBKdXN0aW4gU3RpdHQgKDEpOg0KPiA+ID4gPiAgIFBDSTogaXByb2M6IGZpeCAtV3Zv
aWQtcG9pbnRlci10by1lbnVtLWNhc3Qgd2FybmluZw0KPiA+ID4gPg0KPiA+ID4gPiBZb3NoaWhp
cm8gU2hpbW9kYSAoNSk6DQo+ID4gPiA+ICAgUENJOiBkd2M6IERyb3AgaG9zdCBwcmVmaXggZnJv
bSBzdHJ1Y3QgZHdfcGNpZV9ob3N0X29wcw0KPiA+ID4gPiAgIFBDSTogZHdjOiBSZW5hbWUgdG8g
LmluaXQgaW4gc3RydWN0IGR3X3BjaWVfZXBfb3BzDQo+ID4gPiA+ICAgUENJOiBkd2M6IFJlbmFt
ZSB0byAuZ2V0X2RiaV9vZmZzZXQgaW4gc3RydWN0IGR3X3BjaWVfZXBfb3BzDQo+ID4gPiA+ICAg
UENJOiBkd2M6IEFkZCBkd19wY2llX2VwX3tyZWFkLHdyaXRlfV9kYmlbMl0gaGVscGVycw0KPiA+
ID4gPiAgIFBDSTogcmNhci1nZW40OiBmaXggLVd2b2lkLXBvaW50ZXItdG8tZW51bS1jYXN0IHdh
cm5pbmcNCj4gPiA+DQo+ID4gPiBBY2NvcmRpbmcgdG8gdGhlIHBhdGNod29yayBbMV0sIGFsbCBw
YXRjaGVzIGhhdmUgUmV2aWV3ZWQtYnkgdGFncy4NCj4gPiA+IFNvLCBJIHRoaW5rIHRoZSBwYXRj
aGVzIGFyZSBhY2NlcHRhYmxlIGZvciB1cHN0cmVhbSwgYnV0IHdoYXQgZG8geW91IHRoaW5rPw0K
PiA+ID4gSSBjb25maXJtZWQgdGhhdCB0aGUgcGF0Y2hlcyBjYW4gYmUgYXBwbGllZCBpbnRvIHRo
ZSBsYXRlc3QgcGNpLmdpdCAvIG5leHQgYnJhbmNoLg0KPiA+DQo+ID4gV2hhdCBhY3R1YWxseSBt
YXR0ZXJzIGlzIHRvIGdldCBhbGwgTWFuaXZhbm5hbiBvciBKaW5nb28gb3IgR3VzdGF2bw0KPiA+
IGFja3MgKHRoZSBsYXRlciB0d28gbWFpbnRhaW5lcnMgYXJlIHVubGlrZWx5IHRvIHJlc3BvbmQg
dGhvdWdoKSBvciBhbnkNCj4gPiBoaWdoZXIgbWFpbnRhaW5lcnMgYXBwcm92YWwuIEFGQUlDUyB0
aGlzIHBhdGNoIHN0aWxsIGhhc24ndCBnb3QgYW55DQo+ID4gbWFpbnRhaW5lcnMgYWNrOg0KPiA+
DQo8c25pcCBVUkxzPg0KPiA+IEkgZ3Vlc3MgaXQncyBjb25uZWN0ZWQgd2l0aCBhIHJlcXVlc3Qg
dG8gbW92ZSB0aGUgaGVscGVycyB0byB0aGUNCj4gPiBoZWFkZXIgZmlsZS4NCj4gPg0KPg0KPiBZ
ZXMuIEkgcmVjb21tZW5kZWQgbW92aW5nIHRoZSBoZWxwZXJzIHRvIGhlYWRlciBmaWxlIHRvIGtl
ZXAgdGhlIGNvbnNpc3RlbmN5IGFuZA0KPiB0aGVyZSB3YXMgbm8gcmVwbHkgZnJvbSBZb3NoaWhp
cm8uDQo+DQo+IFlvc2hpaGlybywgc2hvdWxkIHlvdSBoYXZlIGFueSBvYmplY3Rpb25zLCBwbGVh
c2UgY291bnRlciBpbiB0aGUgcGF0Y2ggdGhyZWFkDQo+IDQvNi4gT3RoZXJ3aXNlLCBwbGVhc2Ug
aW1wbGVtZW50IHRoZSBwcm9wb3NlZCBjaGFuZ2UuDQoNClRoYW5rIHlvdSB2ZXJ5IG11Y2ggZm9y
IHlvdXIgcmVwbHkuIEkgY29tcGxldGVseSBvdmVybG9va2VkIHRoZSBNYW5pdmFubmFuJ3MgcmVw
bHkgaW4NCnRoZSBwYXRjaCB0aHJlYWQgNC82Li4uIEknbGwgY2hlY2sgaXQuDQoNCkJlc3QgcmVn
YXJkcywNCllvc2hpaGlybyBTaGltb2RhDQoNCj4gLSBNYW5pDQo+DQo+ID4gLVNlcmdlKHkpDQo+
ID4NCj4gPiA+DQo+ID4gPiBbMV0NCj4gPiA+DQo+IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5v
cmcvcHJvamVjdC9saW51eC1wY2kvbGlzdCUyNQ0KPiAyRiUzRnNlcmllcyUzRDgwMDkwMSZkYXRh
PTA1JTdDMDIlN0N5b3NoaWhpcm8uc2hpbW9kYS51aCU0MHJlbmVzYXMuY29tJTdDMWI1YmVjZGI2
NTQ3NDAzYThmNjEwOGRiZmM4ZjFlNDklN0M1M2Q4MjU3MQ0KPiBkYTE5NDdlNDljYjQ2MjVhMTY2
YTRhMmElN0MwJTdDMCU3QzYzODM4MTQ2MzgzNjgzNTIxMyU3Q1Vua25vd24lN0NUV0ZwYkdac2Iz
ZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQw0KPiBKQlRpSTZJazFoYVd3
aUxDSlhWQ0k2TW4wJTNEJTdDMzAwMCU3QyU3QyU3QyZzZGF0YT1DekdMVlQ1OUMlMkJsNFpTS21Z
Sm1vdXU1NjRwRlhPdURiblVWS1lRTldMaE0lM0QmcmVzZXJ2ZWQ9MA0KPiA+ID4NCj4gPiA+IEJl
c3QgcmVnYXJkcywNCj4gPiA+IFlvc2hpaGlybyBTaGltb2RhDQo+ID4gPg0KPiA+ID4gPiAgZHJp
dmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWRyYTd4eC5jICAgICAgIHwgICA0ICstDQo+ID4g
PiA+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktZXh5bm9zLmMgICAgICAgfCAgIDIg
Ky0NCj4gPiA+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMgICAgICAg
ICB8ICAgNiArLQ0KPiA+ID4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWtleXN0
b25lLmMgICAgIHwgICA4ICstDQo+ID4gPiA+ICAuLi4vcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1s
YXllcnNjYXBlLWVwLmMgICAgfCAgIDcgKy0NCj4gPiA+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xs
ZXIvZHdjL3BjaS1sYXllcnNjYXBlLmMgICB8ICAgMiArLQ0KPiA+ID4gPiAgZHJpdmVycy9wY2kv
Y29udHJvbGxlci9kd2MvcGNpLW1lc29uLmMgICAgICAgIHwgICAyICstDQo+ID4gPiA+ICBkcml2
ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWFsLmMgICAgICAgICAgfCAgIDIgKy0NCj4gPiA+
ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtYXJtYWRhOGsuYyAgICB8ICAgMiAr
LQ0KPiA+ID4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1hcnRwZWM2LmMgICAg
IHwgICA0ICstDQo+ID4gPiA+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWJ0MS5j
ICAgICAgICAgfCAgIDQgKy0NCj4gPiA+ID4gIC4uLi9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1k
ZXNpZ253YXJlLWVwLmMgICB8IDI0OSArKysrKysrKysrLS0tLS0tLS0NCj4gPiA+ID4gIC4uLi9w
Y2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWhvc3QuYyB8ICAzMCArLS0NCj4gPiA+
ID4gIC4uLi9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLXBsYXQuYyB8ICAgMiAr
LQ0KPiA+ID4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmgg
IHwgIDEyICstDQo+ID4gPiA+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWR3LXJv
Y2tjaGlwLmMgfCAgIDIgKy0NCj4gPiA+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3Bj
aWUtZnU3NDAuYyAgICAgICB8ICAgMiArLQ0KPiA+ID4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxl
ci9kd2MvcGNpZS1oaXN0Yi5jICAgICAgIHwgICAyICstDQo+ID4gPiA+ICBkcml2ZXJzL3BjaS9j
b250cm9sbGVyL2R3Yy9wY2llLWludGVsLWd3LmMgICAgfCAgIDIgKy0NCj4gPiA+ID4gIGRyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUta2VlbWJheS5jICAgICB8ICAgMiArLQ0KPiA+ID4g
PiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1raXJpbi5jICAgICAgIHwgICAyICst
DQo+ID4gPiA+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLXFjb20tZXAuYyAgICAg
fCAgIDIgKy0NCj4gPiA+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtcWNvbS5j
ICAgICAgICB8ICAgNiArLQ0KPiA+ID4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNp
ZS1yY2FyLWdlbjQuYyAgIHwgIDEyICstDQo+ID4gPiA+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVy
L2R3Yy9wY2llLXNwZWFyMTN4eC5jICAgfCAgIDIgKy0NCj4gPiA+ID4gIGRyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvZHdjL3BjaWUtdGVncmExOTQuYyAgICB8ICAgMiArLQ0KPiA+ID4gPiAgZHJpdmVy
cy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS11bmlwaGllci1lcC5jIHwgICAyICstDQo+ID4gPiA+
ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLXVuaXBoaWVyLmMgICAgfCAgIDIgKy0N
Cj4gPiA+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtdmlzY29udGkuYyAgICB8
ICAgMiArLQ0KPiA+ID4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLWlwcm9jLXBsYXRm
b3JtLmMgIHwgICAyICstDQo+ID4gPiA+ICAzMCBmaWxlcyBjaGFuZ2VkLCAyMDMgaW5zZXJ0aW9u
cygrKSwgMTc3IGRlbGV0aW9ucygtKQ0KPiA+ID4gPg0KPiA+ID4gPiAtLQ0KPiA+ID4gPiAyLjM0
LjENCj4gPiA+DQo+ID4gPg0KPiA+DQo+DQo+IC0tDQo+IOCuruCuo+Cuv+CuteCuo+CvjeCuo+Cu
qeCvjSDgrprgrqTgrr7grprgrr/grrXgrq7gr40NCg==

