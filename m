Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38C0D432F9A
	for <lists+linux-pci@lfdr.de>; Tue, 19 Oct 2021 09:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhJSHfm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Oct 2021 03:35:42 -0400
Received: from mail-db8eur05on2050.outbound.protection.outlook.com ([40.107.20.50]:4161
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229551AbhJSHfl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Oct 2021 03:35:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cD7qgeTn83oUiXR+5a34jW6JdXqH5pqnBFZ8sI10Nt6/m2ct5qmLhOfe7f7teAbeAtFArro6KXyPV5fQv1UjWvODhMD4xMaPByR+cdwsdkzaJVWy5T/c6Wk0e/98YqrblBbNb5jcY+vBzQC94V4ggUv5V0wAWt3KzUOhE5jhLT8Ko4w2ehzGkNfYiIgBset0pR1MdMHTNP2FekajzEnRDoz7o5C710skx46bWqTW096KhDHOD0VXuX++wC4QfW9jDGvh5BgDvK5nrwcmN6hyxAp9MvSBqmrh2aZGxYLDqtBD4cIkfaTdml/dNBcOK/9V8E12QXYxAEToNOEyC+Vo1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nv/hbpGay08UMLdzDYXjdajnWLtO039JnLFKSqxagKQ=;
 b=DseZfZ9y/z+6HvZY6NxiGDkapjX2IeZdkKP/uRBueuKteflrLDjPzWAEj4aXFC+buN38f3RsYKyx5s8E/O/24jBZxSFhLgUF278z8HJnj3bHJI1Ma1BLHz/IUsoQOzyunFzOa0PE71/VNeHCkbeSzbxdkERpD9twKm0imQ8qBtMj75g2BN2fPeFTE4uEex11QF8kQ6QlvIJD2HCSJeeE9t6drurb+1OXEbaI7H31NAd4QR78r6PSpURj951BxLa11NDSA6kpXLwJafMWAD+OUnd3FSpFiQZvR9qgP0vSRuOXS5frfpgPZ9nKgKWawiviN2gWlIG5i6HkMJY/OpSelw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nv/hbpGay08UMLdzDYXjdajnWLtO039JnLFKSqxagKQ=;
 b=CfLjVcAtINAH4YhIcGId2FEkpXjurSMpsjmsJtfnYJscQTJf/5Zem6O+tOUMlVK2XyzMYMNqFET8x58PxLiyoxDHxRSaNVh4NEFmBghnUjQ3/jvxoavAshmi5UkuVDXDjzOEoqgf14fSSS7yZ/IP3fj5/FJc2aurSlfcfAHjYnk=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Tue, 19 Oct
 2021 07:33:27 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc%4]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 07:33:27 +0000
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
Subject: RE: [RESEND v2 2/5] PCI: imx6: Add the error propagation from
 host_init
Thread-Topic: [RESEND v2 2/5] PCI: imx6: Add the error propagation from
 host_init
Thread-Index: AQHXwY4t5QY3npANVU+HtgYQzhHu06vUXlyAgAWVmAA=
Date:   Tue, 19 Oct 2021 07:33:27 +0000
Message-ID: <AS8PR04MB8676A9F86C108916FA9729B58CBD9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1634277941-6672-1-git-send-email-hongxing.zhu@nxp.com>
         <1634277941-6672-3-git-send-email-hongxing.zhu@nxp.com>
 <6c2cd328dfd407002339d1c83ebd5b832d4f377d.camel@pengutronix.de>
In-Reply-To: <6c2cd328dfd407002339d1c83ebd5b832d4f377d.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1a83d02a-fdda-4061-0587-08d992d2bd9b
x-ms-traffictypediagnostic: AS8PR04MB8963:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AS8PR04MB8963A577DA38CFC0B970834E8CBD9@AS8PR04MB8963.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y4pGjpcGrn/boDFTwx/pUh5+NrS7VeeYNkjbArkr8VGDaELS6QwjWA6e61jBsPm+jWpZr3zspuDU9GG2Nca9JYTf488K0Gxymd9Poh2v9/HQYxvYL9hSPbkuZcT4sf6MKypW8YxGUMZB76IvCZkTiNPnFvcD+AAHPMUn3+tHDzPEvlf3TZlhL282InteGD3+VD4ggYVKC1xP5Rfb4XHLh7vIYy95XbeFxMzDVWlc8uiRWJTgD0BHmZpHrtnkWIvrv7EbH6aeXGxoiaGDBxH41JZ8QRhIGbicT4HSDXJGNNx+dgN+k7CXS8rRoz2I3lnUgvo/Vt8tP5bUSyaWRsJSOJXAE7cAwaZUxEyykg/h54D4phbBeZ2abRbsMmTGS6NeJeMuT/aIO2DxjgUXipTLJOLl3ofqrpTNK4B3t2U6fGxaGabO70qTUh40YatwnvDfcQ+caeFhm90dBxFtI1VKZ0R4VTp0khezyzrevhYLcoEb/LH3RxTdZSUve4SsGaYtXekX6v3y/4KDgKplQXKcXWWSTObn4JGxMYk0awBR6ZgPmvtaSBsh9P0C39x0aDaYJho4OnnJ+nM3NYfSkoMS5I758gAv1GGbN1yeufcvjT+BHK3Z4aQKegeA+k9GOGjyQQCjGmOSyIwsi/4RHummad1CiJ9S2d/8S7KfpN07iIGHDDgSa1qF5vCjk+jIHj2dR60ztAOCgix3Lg4cwf28Kg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(508600001)(83380400001)(8676002)(9686003)(86362001)(122000001)(71200400001)(8936002)(5660300002)(55016002)(38070700005)(76116006)(66946007)(7696005)(66556008)(4326008)(64756008)(66476007)(52536014)(6506007)(316002)(66446008)(33656002)(38100700002)(26005)(53546011)(186003)(110136005)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ajdFOUthcGIvbXhVQjA2R1A5blF6bjJ3VHlQVUFrQzZHSlF4N1M2MW1RdUtO?=
 =?utf-8?B?TnJ5MDFVUkhhaTVqTWlIOEE1V3ZjckRJTlcrczYzS0VtWmdvenFjVW1YZ2VN?=
 =?utf-8?B?akZqdzAwb05HZUtra2tWM3R1dDNnb1A2OVhyZ2JrdVd2UUxKV1Z5WFdTcXFK?=
 =?utf-8?B?ZVZLK2NOMWhLYzdiOFRxL2lERlc2MVdPaWY3blhiNmpTenZYd25pZEJrVU41?=
 =?utf-8?B?UEF5dmtDM0xCZ0RHTlZoQjl6UmNTZWRXVVh3UGJkYXBiT2JnTGh6eWNRUXdo?=
 =?utf-8?B?dnhPU0IzYWJ5U2g2NWszQUU2MGlmZk8wWDJtU2hGY2N0ZjVMVVBSampKcmE5?=
 =?utf-8?B?Yzd0RzBxb2JuaUM2dWZqdU14ZzdZK0RreHlEOVB1QlVoMXZ1RzNETTdhdHNK?=
 =?utf-8?B?RHB5Umt5bms3RUk2WDh5VEltNnhyWTMrVTNlYkVaNUc1ZmROc3J3VWRaQU94?=
 =?utf-8?B?d2o1Qk9icFFXVWt1ZjE2bndPZmczTmxpam5rU2tjWXJTLzVhRHRPTGZoUC8x?=
 =?utf-8?B?K2tRMWIvWHlUVnFJTE5JZjZsOVpvelU0VEJBV2R3UlNLUDhMTHN1SW93VHgy?=
 =?utf-8?B?Qjg0ajEzMmlXd2tCbWc4Szc3RVh4K3d3bThxcENFSE52TTlkREhBQ01ZOFl4?=
 =?utf-8?B?L0dtaTBKbXdsSHVoVEVrSm1iSVlnRlhmdGNnUjVETlpaQWcxQ3ZreTMrWXlu?=
 =?utf-8?B?WUg0WnJRcWg5RTljejNTYzdrcnp1RWhrSmdpRWhOUHRQbTVLSGw2V0pWVC9D?=
 =?utf-8?B?U002OVRIajZoVHZLcGJacStIZU9QSlRCN0tPWk9YTzI5ZlhjZStrZEsvK2xq?=
 =?utf-8?B?VmpnRVB3bnBMV0JBSXNIUG5qaDhKUzlKbEhwd3hTM001YUZmY3BVU1B0Nmcv?=
 =?utf-8?B?ajg5MXlTaWRUUHVka25yRlUwbkdkM3RhMDVCcS9DaTYvWXRYL09keGxhTmtN?=
 =?utf-8?B?c0tFRnlEV0pEaUhmR1JrWUp0NUQ4QmlTN2U3TjZFeWl0dkpuMXdpVm01QmpY?=
 =?utf-8?B?bC9Sa1U4MVdXKys0N0h5QU1nMUVqQ3JDMU5aNHpNUWJPdkN2RktpdW1NV2p6?=
 =?utf-8?B?QWFybmFoMUNVaHV2cXplTkZ4UkwxSWphUHJXNC9zSk51KzRvdjZvZTNKeTNx?=
 =?utf-8?B?dmFFMlozaFY3V0hMNTVROHc5SVFHZlZIaG9FS3RGQ2RnT1R2OGlsVVdHajJT?=
 =?utf-8?B?MytZNnFLeVdSa291NndQS1FLYXMydjZmVGtwb04rZnV0b2NZOUFaQ0lNY0pZ?=
 =?utf-8?B?MVlzclpCenRIT2FrcFZpdGozWmgzVEF5QU93Q09LYlhOQ3Z0ME1wN1dLZXc5?=
 =?utf-8?B?VXp1VHBrMW03OWVaVDRQMWVPNmh0UnlYUVVLTVdaUmxsdW1BY05DL3F4Q2ww?=
 =?utf-8?B?bVpYamJWelFMOERnSGJISlBqaTdRV3ZZQytTcVVnM0hXTzB5bmhxYjRYdE5Y?=
 =?utf-8?B?VFJERzBWd05BeHZqampyMnJKMS9rK0dqaThVT2tabnpONUN6YnpZNmpxR3I5?=
 =?utf-8?B?T2dqTy8ydElqNnV3S1huZkRaWXJCQ3M2OUlYZ1R5bzdHbWZ4VUVZWTl1Nlpo?=
 =?utf-8?B?RklWMjFtSmZCekZRZkdMU2c2OFVUME1CZG4wQXhBYTVheTVXZ0dGbU9oSjc5?=
 =?utf-8?B?UG1RUzR0STB2VVJyMUpXKzVKYVF6UlVqcDd4dlhlODBvcU1qSzVidlprYWNE?=
 =?utf-8?B?TXhBQ2xLODdweVozT2tUcWxOQnhSYUpFajBCa2tlMi85ei9kdkJHMWNQekUr?=
 =?utf-8?Q?ERD8C9nn44t1krnd7TB0EDVkClYGp5SUOv/hsat?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a83d02a-fdda-4061-0587-08d992d2bd9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2021 07:33:27.0281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AWsGfa8N+sA+/sEZieZwI0ecWRZc/OWP3iwLLmFmUxsbAGiO077cgaDMrlf7Vpr7qDFXq/5F1djS6tfg3qyPZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8963
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMdWNhcyBTdGFjaCA8bC5zdGFj
aEBwZW5ndXRyb25peC5kZT4NCj4gU2VudDogU2F0dXJkYXksIE9jdG9iZXIgMTYsIDIwMjEgMjox
NiBBTQ0KPiBUbzogUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPjsgYmhlbGdhYXNA
Z29vZ2xlLmNvbTsNCj4gbG9yZW56by5waWVyYWxpc2lAYXJtLmNvbQ0KPiBDYzogbGludXgtcGNp
QHZnZXIua2VybmVsLm9yZzsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47DQo+IGxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsNCj4ga2VybmVsQHBlbmd1dHJvbml4LmRlDQo+IFN1YmplY3Q6IFJlOiBbUkVTRU5E
IHYyIDIvNV0gUENJOiBpbXg2OiBBZGQgdGhlIGVycm9yIHByb3BhZ2F0aW9uIGZyb20NCj4gaG9z
dF9pbml0DQo+IA0KPiBBbSBGcmVpdGFnLCBkZW0gMTUuMTAuMjAyMSB1bSAxNDowNSArMDgwMCBz
Y2hyaWViIFJpY2hhcmQgWmh1Og0KPiA+IFNpbmNlIHRoZXJlIGlzIGVycm9yIHJldHVybiBjaGVj
ayBvZiB0aGUgaG9zdF9pbml0IGNhbGxiYWNrLCBhZGQgZXJyb3INCj4gPiBjaGVjayB0byBpbXg2
X3BjaWVfZGVhc3NlcnRfY29yZV9yZXNldCgpIGZ1bmN0aW9uLCBhbmQgY2hhbmdlIHRoZQ0KPiA+
IGZ1bmN0aW9uIHR5cGUgYWNjb3JkaW5nbHkuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNo
YXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+IA0KPiBSZXZpZXdlZC1ieTogTHVjYXMg
U3RhY2ggPGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU+DQo+IA0KW1JpY2hhcmQgWmh1XSBUaGFua3Mu
DQoNCkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9wY2kv
Y29udHJvbGxlci9kd2MvcGNpLWlteDYuYyB8IDI0ICsrKysrKysrKysrKysrKystLS0tLS0tLQ0K
PiA+ICAxIGZpbGUgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5j
DQo+ID4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gaW5kZXgg
MWZhMWRiYTZkYTgxLi4zMzcyNzc1ODM0YTIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kv
Y29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xs
ZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiBAQCAtNTI3LDI0ICs1MjcsMjQgQEAgc3RhdGljIHZvaWQN
Cj4gaW14N2RfcGNpZV93YWl0X2Zvcl9waHlfcGxsX2xvY2soc3RydWN0IGlteDZfcGNpZSAqaW14
Nl9wY2llKQ0KPiA+ICAJCWRldl9lcnIoZGV2LCAiUENJZSBQTEwgbG9jayB0aW1lb3V0XG4iKTsg
IH0NCj4gPg0KPiA+IC1zdGF0aWMgdm9pZCBpbXg2X3BjaWVfZGVhc3NlcnRfY29yZV9yZXNldChz
dHJ1Y3QgaW14Nl9wY2llDQo+ID4gKmlteDZfcGNpZSkNCj4gPiArc3RhdGljIGludCBpbXg2X3Bj
aWVfZGVhc3NlcnRfY29yZV9yZXNldChzdHJ1Y3QgaW14Nl9wY2llICppbXg2X3BjaWUpDQo+ID4g
IHsNCj4gPiAgCXN0cnVjdCBkd19wY2llICpwY2kgPSBpbXg2X3BjaWUtPnBjaTsNCj4gPiAgCXN0
cnVjdCBkZXZpY2UgKmRldiA9IHBjaS0+ZGV2Ow0KPiA+IC0JaW50IHJldDsNCj4gPiArCWludCBy
ZXQsIGVycjsNCj4gPg0KPiA+ICAJaWYgKGlteDZfcGNpZS0+dnBjaWUgJiYgIXJlZ3VsYXRvcl9p
c19lbmFibGVkKGlteDZfcGNpZS0+dnBjaWUpKSB7DQo+ID4gIAkJcmV0ID0gcmVndWxhdG9yX2Vu
YWJsZShpbXg2X3BjaWUtPnZwY2llKTsNCj4gPiAgCQlpZiAocmV0KSB7DQo+ID4gIAkJCWRldl9l
cnIoZGV2LCAiZmFpbGVkIHRvIGVuYWJsZSB2cGNpZSByZWd1bGF0b3I6ICVkXG4iLA0KPiA+ICAJ
CQkJcmV0KTsNCj4gPiAtCQkJcmV0dXJuOw0KPiA+ICsJCQlyZXR1cm4gcmV0Ow0KPiA+ICAJCX0N
Cj4gPiAgCX0NCj4gPg0KPiA+IC0JcmV0ID0gaW14Nl9wY2llX2Nsa19lbmFibGUoaW14Nl9wY2ll
KTsNCj4gPiAtCWlmIChyZXQpIHsNCj4gPiAtCQlkZXZfZXJyKGRldiwgInVuYWJsZSB0byBlbmFi
bGUgcGNpZSBjbG9ja3NcbiIpOw0KPiA+ICsJZXJyID0gaW14Nl9wY2llX2Nsa19lbmFibGUoaW14
Nl9wY2llKTsNCj4gPiArCWlmIChlcnIpIHsNCj4gPiArCQlkZXZfZXJyKGRldiwgInVuYWJsZSB0
byBlbmFibGUgcGNpZSBjbG9ja3M6ICVkXG4iLCBlcnIpOw0KPiA+ICAJCWdvdG8gZXJyX2Nsa3M7
DQo+ID4gIAl9DQo+ID4NCj4gPiBAQCAtNTk5LDcgKzU5OSw3IEBAIHN0YXRpYyB2b2lkIGlteDZf
cGNpZV9kZWFzc2VydF9jb3JlX3Jlc2V0KHN0cnVjdA0KPiBpbXg2X3BjaWUgKmlteDZfcGNpZSkN
Cj4gPiAgCQlicmVhazsNCj4gPiAgCX0NCj4gPg0KPiA+IC0JcmV0dXJuOw0KPiA+ICsJcmV0dXJu
IDA7DQo+ID4NCj4gPiAgZXJyX2Nsa3M6DQo+ID4gIAlpZiAoaW14Nl9wY2llLT52cGNpZSAmJiBy
ZWd1bGF0b3JfaXNfZW5hYmxlZChpbXg2X3BjaWUtPnZwY2llKSA+IDApDQo+ID4geyBAQCAtNjA4
LDYgKzYwOCw3IEBAIHN0YXRpYyB2b2lkIGlteDZfcGNpZV9kZWFzc2VydF9jb3JlX3Jlc2V0KHN0
cnVjdA0KPiBpbXg2X3BjaWUgKmlteDZfcGNpZSkNCj4gPiAgCQkJZGV2X2VycihkZXYsICJmYWls
ZWQgdG8gZGlzYWJsZSB2cGNpZSByZWd1bGF0b3I6ICVkXG4iLA0KPiA+ICAJCQkJcmV0KTsNCj4g
PiAgCX0NCj4gPiArCXJldHVybiBlcnI7DQo+ID4gIH0NCj4gPg0KPiA+ICBzdGF0aWMgdm9pZCBp
bXg2X3BjaWVfY29uZmlndXJlX3R5cGUoc3RydWN0IGlteDZfcGNpZSAqaW14Nl9wY2llKSBAQA0K
PiA+IC04NTgsMTEgKzg1OSwxOCBAQCBzdGF0aWMgaW50IGlteDZfcGNpZV9zdGFydF9saW5rKHN0
cnVjdCBkd19wY2llDQo+ID4gKnBjaSkgIHN0YXRpYyBpbnQgaW14Nl9wY2llX2hvc3RfaW5pdChz
dHJ1Y3QgcGNpZV9wb3J0ICpwcCkgIHsNCj4gPiAgCXN0cnVjdCBkd19wY2llICpwY2kgPSB0b19k
d19wY2llX2Zyb21fcHAocHApOw0KPiA+ICsJc3RydWN0IGRldmljZSAqZGV2ID0gcGNpLT5kZXY7
DQo+ID4gIAlzdHJ1Y3QgaW14Nl9wY2llICppbXg2X3BjaWUgPSB0b19pbXg2X3BjaWUocGNpKTsN
Cj4gPiArCWludCByZXQ7DQo+ID4NCj4gPiAgCWlteDZfcGNpZV9hc3NlcnRfY29yZV9yZXNldChp
bXg2X3BjaWUpOw0KPiA+ICAJaW14Nl9wY2llX2luaXRfcGh5KGlteDZfcGNpZSk7DQo+ID4gLQlp
bXg2X3BjaWVfZGVhc3NlcnRfY29yZV9yZXNldChpbXg2X3BjaWUpOw0KPiA+ICsJcmV0ID0gaW14
Nl9wY2llX2RlYXNzZXJ0X2NvcmVfcmVzZXQoaW14Nl9wY2llKTsNCj4gPiArCWlmIChyZXQgPCAw
KSB7DQo+ID4gKwkJZGV2X2VycihkZXYsICJwY2llIGhvc3QgaW5pdCBmYWlsZWQ6ICVkLlxuIiwg
cmV0KTsNCj4gPiArCQlyZXR1cm4gcmV0Ow0KPiA+ICsJfQ0KPiA+ICsNCj4gPiAgCWlteDZfc2V0
dXBfcGh5X21wbGwoaW14Nl9wY2llKTsNCj4gPg0KPiA+ICAJcmV0dXJuIDA7DQo+IA0KDQo=
