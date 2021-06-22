Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE74E3AFA4A
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jun 2021 02:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbhFVAnq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Jun 2021 20:43:46 -0400
Received: from mail-eopbgr70057.outbound.protection.outlook.com ([40.107.7.57]:56455
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231322AbhFVAnq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Jun 2021 20:43:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l6nN3pZSrssOyfRtVfiKEXist5wdJYGaSkSEIGPBos4AhLAGL6DDkfOVLVBQU9BxCiTZWzLQnrQUpYNHwRPgMgKcFDrNKgyobMEPyu/7voTlHcK4WdJYbXMuxMENLX/DQfTd69wXKDxv4ez2GmzQrnmyJ2X9Badl6DivVmELV7RZ++xcoW60EcO+7mB6AjDryFl8Mcf8yZVCZYXTMZujK6SIaruHn/UhR2fjG1YiUOzzPQ7kw3JxhDRWKgwwJkLliYn3Ift9V3RnZSqUZ5D9Uepu8Rt/VyGduMTAthgd6ZTEHsy4JUDAp4lSK0qeWiBb57Wn5ET5bNezGTF5Y9g+/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQw0sTLwpn6gksdYomQyTM7E8xpq5mx+n/h1WjqZlyE=;
 b=not9YlZKbRvVn5nGUKgSbiv7naUwMWUP6bo6ffOklkB7Ee8W5+pS3ZrfmIu95czofc3P55Ikqa6PrQLi0eKsPqzHNIZGwXx0tvzE5i9LCNrv2NAIs+1PJ9cFFC3kBu+XBk4HNhoSok94t/IRX4i/4fECtlXd29MO/GpaPBSkYoUlh5JgPOE9J1u6Rt0d45wkwQCfb1TmycI673aO92Wy1i9GTyO8n67H/shJ79yatxVutSI721S93I+5UchLPjR7sL/6pQRNkuSKHkFHX8ebbUjU1WJwEXJ5kK0w0y2m4pqHvH3lWJWJD5a85tMrXjnEJ8503d411EoSBQGO/G22og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQw0sTLwpn6gksdYomQyTM7E8xpq5mx+n/h1WjqZlyE=;
 b=p1DVhnn9YgRl0ycDUDlAU0gKAhJA9qzvEScAZ7OufQmgb40gQK2X+ecguTlYg7q1DJZXI+HdDRQjznl1AkMw/9VZwL0E7CMnyJyZBdgjoh4SmLYL75gPb87pyLoEW4W42cMRR6DUpszcry6Ys9A1RbLjQZ7Y47gr4b7MdFnq4L4=
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com (2603:10a6:803:e3::25)
 by VE1PR04MB6510.eurprd04.prod.outlook.com (2603:10a6:803:127::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Tue, 22 Jun
 2021 00:41:29 +0000
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::50a3:f548:9c83:b50d]) by VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::50a3:f548:9c83:b50d%7]) with mapi id 15.20.4242.023; Tue, 22 Jun 2021
 00:41:29 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH v2] PCI: imx6: Limit DBI register length for imx6qp PCIe
Thread-Topic: [PATCH v2] PCI: imx6: Limit DBI register length for imx6qp PCIe
Thread-Index: AQHXBzS8PiWJUkyaQUCrfLgNXqfifKsfQ88AgACsLPA=
Date:   Tue, 22 Jun 2021 00:41:28 +0000
Message-ID: <VI1PR04MB5853A0D38C80BAB27663F3C28C099@VI1PR04MB5853.eurprd04.prod.outlook.com>
References: <1613789388-2495-1-git-send-email-hongxing.zhu@nxp.com>
 <1613789388-2495-2-git-send-email-hongxing.zhu@nxp.com>
 <20210621142414.GB27516@lpieralisi>
In-Reply-To: <20210621142414.GB27516@lpieralisi>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 38a0d8ba-763b-4783-7158-08d93516794f
x-ms-traffictypediagnostic: VE1PR04MB6510:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB6510D255956C9F169C6B443A8C099@VE1PR04MB6510.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MIbZW0KZPSUQFqXe2yPmLZNzvaUu9vGlpFJuIFsQsE0EHg6XTFKqo1ZQ/pE3B+Qjyj2+q5GcYsJPaJ5t2SpdJmVHyJ0IuvFU6yu9Ow7J/SgTVQ/djNtt436xEqetGTAJSKsb8FhHWqvFYhV7CUQf4IdReNz74ZJt1UqbS5W7lPtzaXG+dbYn0auuAG2VWF3E0mu4bb0cqiQIt8EPvw19FlZY1XmkGeYx3RYz4081w8H/ilWZ7a8wzbrYGQiVGKkxYEOg2vXCF7nYrKoisiZDFmpgOXRzco41IrN2oIprYMxJcbKEKOuJrfyknPCht5GZwm0JMiMKjWJb1BrHoNnSbOG1ZjSCx1/N3Qkxaw0kyIviteON/9T/MjuOxmrjW+7fS0hGhhekpaXs/CPm+9QDlhQs4dmIBEKKFUM8RMh/lrrhMzWkBra0e4dk5v1Bsx3HHMR7FtvtpD+LFEH8R/PQs0VJTbaQJ3LGONfo1t90t3rQRYv5IVGVP7+Z+nnW/Ucjk568rJ28zDXfak/wC/PiGHuniYARuvxjJB9pJ+E62W513iY9MpQ3g3bnMzHFtLq4lhEOEyjSJsgSdJ8Uscb1phq38lrZAHxFQi7s3Y7WF+0Gkij9MdEk8V8PtCRHlEtQ8owPF5+YDv4d45ZViuaI9Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5853.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(71200400001)(66946007)(7696005)(4326008)(55016002)(26005)(6916009)(66574015)(83380400001)(186003)(38100700002)(9686003)(478600001)(8676002)(5660300002)(52536014)(122000001)(316002)(76116006)(33656002)(54906003)(86362001)(66446008)(64756008)(66556008)(66476007)(2906002)(8936002)(6506007)(53546011)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aWJmZTZtNUkyU1VqWU5ycUJ5V2M0ZmVUQWVrMHFGUm44QVNFZUZ0eWwwZ0Yw?=
 =?utf-8?B?V2loUktxMXgxV2VWNFpxdWUzS0tYSW5KSDRmcFNnNXQ4cUkxYmdOL2tPUkxt?=
 =?utf-8?B?eFdVM0IzRFgxZ1pPNWF1eUZ2amdWK0hsWVlFSCtWQTN2VGVZRGppWEJvWXd5?=
 =?utf-8?B?WTJaMWdoV2FFc1N6a0JtOVYrazgzS2dKOGRpUmtCQXUyMC9ZMFViU2cydC8v?=
 =?utf-8?B?eUlKcUNlMGtwMlE4b2NkbkpGY1JQY2c5ckM0ZWhBUDVCTzJ3TVc0STVJang3?=
 =?utf-8?B?amVkenM5VUxsaEdtbjNOb2FMT085eVhOdE1FMC9TY0F4UVBhYnhaZkoxYUkw?=
 =?utf-8?B?bjI5UE85UW1NKzlhZmUrV0lFV1llK1FkL0h4N3J1ZC9ZbVlLSVhiZHVleFNx?=
 =?utf-8?B?NkRRWVo2ZWdzaE5LSG5pZCtSSG42WEU0UFd4ZFl5YkZ4dG00MGpxME9RVXBD?=
 =?utf-8?B?cUxacTMwUmo2Rzh0cWNIRjREVHhaUGJSU09NVzVzZ1c3cWhXNjJaaU1BK0FT?=
 =?utf-8?B?T0tDRnA3aDF1RU1malRUbWFabld1RzBjaDQ0dTJVVGVseFVNbGZXbDluc3Bn?=
 =?utf-8?B?RGJpaWFvRVhFYzlqV1BLVXp4cTl1a3padHExTzRkWkZTRFA1YzV0bXpOeWVL?=
 =?utf-8?B?c1JUbGRrV0dsREJIbmZpekpQeVA4d0Q5dnNEcXZlblFjS1dtL3BQbklvbWEx?=
 =?utf-8?B?NUR1VmdmS3hNTGg0T0xvNFpwbjRheHVUY1FrcDFMYXRPQm41UXo3STM5ZzNZ?=
 =?utf-8?B?Kyt3YlZrakc5dHpDdXF3clFqNko5ZXpkak1id0lCekNQT1graG9JMW9lL0p3?=
 =?utf-8?B?QTFsbDcxUU44SHc1L1NrZW8zeUF6cE9kMjBIYUx5VFRUTVcvRjVpQWtuMVdG?=
 =?utf-8?B?UEVlVHgvNFg3V1NwRHd1Vzk5TkwwdVg2c0pvbUg3YkFXQkJOc2c5KzJlVTRS?=
 =?utf-8?B?SCtKNEh2czV1RkgyWVJPVHlDMWF5enBzYkdqOUQ5ditjb0VodE1SbTgzZzZD?=
 =?utf-8?B?WTNoVURyOFJQMytWMGdFOENmWGVsQm16WWEva1gzaTI2YlFaZS9TcjdrdGlK?=
 =?utf-8?B?WlFnWHhMZWpRR1VHTlpUS2ZodnFYaWMwMENwWDcrSFpzQ3lPRkhnVE14emY1?=
 =?utf-8?B?a242MStkS3J4bzF3emRlNEJqNGZhWUdid09oU1VacDhSZW9KMGtxV1V0SFB6?=
 =?utf-8?B?VWVoY2IyVGtWL0NwMjd4R1pUY1dOTDdhOGpkTE42NjVWSXNVMG0yVTNwS2Iz?=
 =?utf-8?B?bmsvZm5kdzIrMXpoQndiM05OazhTclEwZFRuUUNYbmtHTndPa3Vlemk0ZnRU?=
 =?utf-8?B?aGVrbzhWbjNvYmE2S202TEQ5a3BqT2xaK2s2a2FxZ3lzZmJKVmxyVnFlaS9a?=
 =?utf-8?B?bGFhd2haR3dsZ3FxeTg1b2JuQlJIZ2VtK3IvNE1zdGJnQVdWZUMrcXAwc0Fq?=
 =?utf-8?B?aHB6VFpyMEFxVUtyOWUrYUx0cURJUTh1Y1E2Zm1aZk9CMmVkYlNsVlFzSngv?=
 =?utf-8?B?bnArajlkdjdwQVdhWTU0a1U5MENkR3A0S20xdlpGclNtUy9odmZPTitVcWVG?=
 =?utf-8?B?SHZJSUw4WGRxREpHOVpkRGp6OWNnRXI0QlFXSU5ZODJCUDhNV0poQUhNWk5G?=
 =?utf-8?B?VEZLSEV5MHN5ejlzQ3VhVmwzaFhDaUw5VCtrRVczcnduYUZsWkFYczcxM29E?=
 =?utf-8?B?RjM1MEtCNllBdW15VERZdmM5THlKUFJUdTY3VTJBOGorTjJobjFJYkpaakR3?=
 =?utf-8?Q?4vUkcE1+uKOynuF6dxZCM1CPJIKhek8LtiuTQYR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5853.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38a0d8ba-763b-4783-7158-08d93516794f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2021 00:41:28.9598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SD6k/bZVJ/jVu0Craicxsm8zSLArXje+s4j096jJTBlYv+wyv6QXvSW/Bbvln3iKTPKTXLWgQCUWOzXGWRCZ5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6510
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMb3JlbnpvIFBpZXJhbGlzaSA8
bG9yZW56by5waWVyYWxpc2lAYXJtLmNvbT4NCj4gU2VudDogTW9uZGF5LCBKdW5lIDIxLCAyMDIx
IDEwOjI0IFBNDQo+IFRvOiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+IENj
OiBsLnN0YWNoQHBlbmd1dHJvbml4LmRlOyBrd0BsaW51eC5jb207IGJoZWxnYWFzQGdvb2dsZS5j
b207DQo+IHN0ZWZhbkBhZ25lci5jaDsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgZGwtbGlu
dXgtaW14DQo+IDxsaW51eC1pbXhAbnhwLmNvbT47IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsga2VybmVsQHBlbmd1
dHJvbml4LmRlDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjJdIFBDSTogaW14NjogTGltaXQgREJJ
IHJlZ2lzdGVyIGxlbmd0aCBmb3IgaW14NnFwIFBDSWUNCj4gDQo+IE9uIFNhdCwgRmViIDIwLCAy
MDIxIGF0IDEwOjQ5OjQ4QU0gKzA4MDAsIFJpY2hhcmQgWmh1IHdyb3RlOg0KPiA+IERlZmluZSB0
aGUgbGVuZ3RoIG9mIHRoZSBEQkkgcmVnaXN0ZXJzIGFuZCBsaW1pdCBjb25maWcgc3BhY2UgdG8g
aXRzDQo+ID4gbGVuZ3RoLiBUaGlzIG1ha2VzIHN1cmUgdGhhdCB0aGUga2VybmVsIGRvZXMgbm90
IGFjY2VzcyByZWdpc3RlcnMNCj4gPiBiZXlvbmQgdGhhdCBwb2ludCB0aGF0IG90aGVyd2lzZSB3
b3VsZCBsZWFkIHRvIGFuIGFib3J0IG9uIHRoZSBpLk1YDQo+IDZRdWFkUGx1cy4NCj4gPg0KPiA+
IFNlZSBjb21taXQgMDc1YWY2MWMxOWNkICgiUENJOiBpbXg2OiBMaW1pdCBEQkkgcmVnaXN0ZXIg
bGVuZ3RoIikgdGhhdA0KPiA+IHJlc29sdmVzIGEgc2ltaWxhciBpc3N1ZSBvbiB0aGUgaS5NWCA2
UXVhZCBQQ0llLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUmljaGFyZCBaaHUgPGhvbmd4aW5n
LnpodUBueHAuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBMdWNhcyBTdGFjaCA8bC5zdGFjaEBwZW5n
dXRyb25peC5kZT4NCj4gPiBSZXZpZXdlZC1ieTogS3J6eXN6dG9mIFdpbGN6ecWEc2tpIDxrd0Bs
aW51eC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1p
bXg2LmMgfCAxICsNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+IA0KPiBJ
J2QgbGlrZSB0byBtZXJnZSB0aGlzIHBhdGNoIHNpbmNlIEkgYmVsaWV2ZSBpdCBpcyBzdGlsbCBy
ZXF1aXJlZCwgcGxlYXNlIGxldCBtZQ0KPiBrbm93IGlmIHRoYXQncyBub3QgdGhlIGNhc2UuDQpI
aSBMb3JlbnpvOg0KVGhhbmtzIGZvciBtZXJnaW5nIHRoaXMgcGF0Y2guDQoNCkJlc3QgUmVnYXJk
cw0KUmljaGFyZCBaaHUNCj4gDQo+IExvcmVuem8NCj4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiBiL2RyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiBpbmRleCAwY2YxMzMzYzA0NDAuLjg1M2VhOGU4Mjk1
MiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5j
DQo+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+IEBA
IC0xMTc1LDYgKzExNzUsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGlteDZfcGNpZV9kcnZkYXRh
IGRydmRhdGFbXSA9DQo+IHsNCj4gPiAgCQkudmFyaWFudCA9IElNWDZRUCwNCj4gPiAgCQkuZmxh
Z3MgPSBJTVg2X1BDSUVfRkxBR19JTVg2X1BIWSB8DQo+ID4gIAkJCSBJTVg2X1BDSUVfRkxBR19J
TVg2X1NQRUVEX0NIQU5HRSwNCj4gPiArCQkuZGJpX2xlbmd0aCA9IDB4MjAwLA0KPiA+ICAJfSwN
Cj4gPiAgCVtJTVg3RF0gPSB7DQo+ID4gIAkJLnZhcmlhbnQgPSBJTVg3RCwNCj4gPiAtLQ0KPiA+
IDIuMTcuMQ0KPiA+DQo=
