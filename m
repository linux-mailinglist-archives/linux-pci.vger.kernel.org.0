Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11FF8295848
	for <lists+linux-pci@lfdr.de>; Thu, 22 Oct 2020 08:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503505AbgJVGUX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Oct 2020 02:20:23 -0400
Received: from mail-eopbgr80080.outbound.protection.outlook.com ([40.107.8.80]:40750
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2503487AbgJVGUX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Oct 2020 02:20:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gLhf625KaedDyAaDXB6v2iVVFT3GZoxurFuXTedp8+hCKNzow2jI4vmFZlzkLcm2NmhbUJLB5uzkFuu2Ogrq5CQiu7TWUS+Gs7AA68XQVJQYbXlBQagXUbEh/J8XKQ7PXiHzbh6bRtyHgq/jxNmSyLzCQUODkgjT5ZVG9VAqZTcxI9/4kEtprumhVHgPjIlU7Mb0kvfWQzPeqfEkKOKlZAO/q2UDN6ysjtMwNGggdKaAiLf0oRZnU9ecHEYnBo8ngQqKDPCmViDKz5YcCtDM5SX9j2pXnYYzHAMzc5Zejei3SPWi6RU+xn5Ylt8Qt+Fe+Pjj8Y+hyPAhY8podjeLxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJsFPQynYzEWjwW0vMD2j+WPa5FH92+04GTdrOMx4IA=;
 b=jBMKD7HW7uX2n8AHXtBdKubGS32M24xewUQHC0CirYVHc20gqnErVvSe06cXUWd0BCt2UPmsRHKQpMNe8J0lI2dxhPic7LTtE7iCIx+J//JJcaItuuVACO906UQN6gZHz0HYJqpqvrBSMotosg7iGxDq6TYnHgCHsHAqvAllawv0npbqG3riof9v2iEj4nkvAffy10YImFnmcnVzzP/iPEZwb0/7ilD78ta/R6fHZI7jsQaTYgBlYgzkGm3vBFERIoZ5kUYCLpBfVHGR0w71HSqU45EHTz2v+qiikTXDpEym2NJ25sSyD9FkTSz7qKzFvEmrRqu+vYYinZt9ntNs5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJsFPQynYzEWjwW0vMD2j+WPa5FH92+04GTdrOMx4IA=;
 b=JkE6jtxAIGTdkHYNdfOq1sMmdhRChK6LZvy/3Dk1PZf0aY9/uer00TXgEIJoypmz2kVkxYNJOi2dp8ogibFAEcdUa90CQK7qx0NBm0BnfH3I+tcmFPBHfdBeTGy9tpU0MpO0LVIr7OxYZd5vT6sMIl8/QaxPUwiTD20njFyUzpg=
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com (2603:10a6:803:e3::25)
 by VI1PR0402MB3839.eurprd04.prod.outlook.com (2603:10a6:803:21::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.27; Thu, 22 Oct
 2020 06:20:19 +0000
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::ac50:7ca5:4296:8018]) by VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::ac50:7ca5:4296:8018%7]) with mapi id 15.20.3499.018; Thu, 22 Oct 2020
 06:20:19 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>
Subject: RE: [PATCH] PCI: dwc: Added link up check in map_bus of
 dw_child_pcie_ops
Thread-Topic: [PATCH] PCI: dwc: Added link up check in map_bus of
 dw_child_pcie_ops
Thread-Index: AQHWi+0seUdQCD5Vd0CU4riR8OTpR6mZcoIAgAUfDCCAAAuOgIABVTAQgACEH4CAAXl4QIABbo4g
Date:   Thu, 22 Oct 2020 06:20:18 +0000
Message-ID: <VI1PR04MB5853E16DDAC5A382779F63F38C1D0@VI1PR04MB5853.eurprd04.prod.outlook.com>
References: <20200916054130.8685-1-Zhiqiang.Hou@nxp.com>
 <20201015224738.GA24466@bjorn-Precision-5520>
 <HE1PR0402MB3371CD54946A513C12A5ABC2841E0@HE1PR0402MB3371.eurprd04.prod.outlook.com>
 <7778161f-b87c-5499-b4e6-de0550bc165c@ti.com>
 <HE1PR0402MB337161161D04C34247C1D876841F0@HE1PR0402MB3371.eurprd04.prod.outlook.com>
 <20201020095527.GA21814@e121166-lin.cambridge.arm.com>
 <HE1PR0402MB3371B927C5704F0C77E0EDB9841C0@HE1PR0402MB3371.eurprd04.prod.outlook.com>
In-Reply-To: <HE1PR0402MB3371B927C5704F0C77E0EDB9841C0@HE1PR0402MB3371.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2822a08d-2731-4b8f-5d08-08d876528c8f
x-ms-traffictypediagnostic: VI1PR0402MB3839:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB3839B53F3F020033E93536C48C1D0@VI1PR0402MB3839.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R8KvwpxMHv4Kx5TV94V6pimVkSvsnHMzuanHEkaTSZHMkp28Gn3tc1zvZEFcu6pqMgR8j7GEkaZqQdPDAHys6DtSICa2jufgIcyYuM5zaR9+4dNBlG92yEaOBzC9cbGkw9f1VgxKRyxJAp300ttnqm3y/irKIlULZLiW8CIXh+by1W+XVXH67RLjIRrf+/5fNP3hd5CtqUHvhVnljhvkF1pXYK026PdlxUAWraQPsGUDNVYmfEAQ22zTScqrDNJy9OfFQn8Qe81AnjkgSc9egQZGjtiATjhVn/vowSkY4wLgeh7/9YMF+j3hgitkUpRRsq32gY5c2PU3lPFGjOmaHA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5853.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(376002)(346002)(39860400002)(55016002)(52536014)(5660300002)(66446008)(66946007)(33656002)(478600001)(66556008)(2906002)(64756008)(66476007)(83380400001)(8936002)(4326008)(76116006)(8676002)(86362001)(9686003)(53546011)(6506007)(54906003)(71200400001)(7696005)(316002)(110136005)(186003)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 6ANyEvTj9huC56RWCQ55CkoOZj+q7CQMnxclldpbwPG0p7tm08rFJv7OSjzla6ylHs32wCviPUCFWyNOxy2JgUzQi6h0H+xsRZWPQT2F9/H/FeFLYhcFc5hEjrTxHDDduVk04VEG04s1zaoR4Yso8rhprhgcOkIuIfBNxY44Jvnxw45N5iiK7xi7fD75McNTLIYfs2Jv52wGqZKkh2jCg4aIpqsURmt+HxxTKC96RXt5rLG+YgTFZFTPHD3dy8GuxMKTiIO/m9WHzD0H/jPDwdir2xZkZjBrlP9HR7RGjEyOKx8i16rL37oImA8LzrYubRFJH79Z5gs6wzOXIa1KvIF08bNh9Kl79SHp2KDKi0kyK8HgbQuSQX3fuIj6d8gj6t9SUrltZOXwi1p3oAxhbBz2VjUF5OwIhNBGDNjtwg4r0grUxiM31xRZJlhZga2WNK+fVH5YgfTpPILb6hxI82yT84KkcFZcnGkEU7LHYrchodppiYLrZ0t5qevUhl7Z+oV9gCwLxzaiEaa8hWOcc0aIIhAkf9qxNE7i//cMPKiP+ch7qZCUHwczbJejGFpU1/NvR5lh+TYQEL8CtutB36S4nCjcanBSb82kdCkCvtWSwLvq+qz7EGIznUPQhmgJXTUs/DRV6PeZO5SJRNrflA==
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5853.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2822a08d-2731-4b8f-5d08-08d876528c8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2020 06:20:18.9697
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MpTNnFL8g7zbkDgpr6MrTtTZyMpPkVSdomeBgWxoTDG3we8wnSWRzKbJUWzu0GtLB+dHRFTBoqjA+XgT/8gGDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3839
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBaLnEuIEhvdSA8emhpcWlhbmcu
aG91QG54cC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgT2N0b2JlciAyMSwgMjAyMCA0OjQ4IFBN
DQo+IFRvOiBMb3JlbnpvIFBpZXJhbGlzaSA8bG9yZW56by5waWVyYWxpc2lAYXJtLmNvbT47IFJp
Y2hhcmQgWmh1DQo+IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IEtpc2hvbiBWaWpheSBB
YnJhaGFtIEkgPGtpc2hvbkB0aS5jb20+OyBCam9ybiBIZWxnYWFzDQo+IDxoZWxnYWFzQGtlcm5l
bC5vcmc+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1wY2lAdmdlci5rZXJu
ZWwub3JnOw0KPiByb2JoQGtlcm5lbC5vcmc7IGJoZWxnYWFzQGdvb2dsZS5jb207IGd1c3Rhdm8u
cGltZW50ZWxAc3lub3BzeXMuY29tDQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0hdIFBDSTogZHdjOiBB
ZGRlZCBsaW5rIHVwIGNoZWNrIGluIG1hcF9idXMgb2YNCj4gZHdfY2hpbGRfcGNpZV9vcHMNCj4g
DQo+IEhpIExvcmVuem8gYW5kIFJpY2hhcmQsDQo+IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+ID4gRnJvbTogTG9yZW56byBQaWVyYWxpc2kgPGxvcmVuem8ucGllcmFsaXNpQGFy
bS5jb20+DQo+ID4gU2VudDogMjAyMMTqMTDUwjIwyNUgMTc6NTUNCj4gPiBUbzogWi5xLiBIb3Ug
PHpoaXFpYW5nLmhvdUBueHAuY29tPg0KPiA+IENjOiBLaXNob24gVmlqYXkgQWJyYWhhbSBJIDxr
aXNob25AdGkuY29tPjsgQmpvcm4gSGVsZ2Fhcw0KPiA+IDxoZWxnYWFzQGtlcm5lbC5vcmc+OyBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiA+IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5v
cmc7IHJvYmhAa2VybmVsLm9yZzsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsNCj4gPiBndXN0YXZvLnBp
bWVudGVsQHN5bm9wc3lzLmNvbQ0KPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIFBDSTogZHdjOiBB
ZGRlZCBsaW5rIHVwIGNoZWNrIGluIG1hcF9idXMgb2YNCj4gPiBkd19jaGlsZF9wY2llX29wcw0K
PiA+DQo+ID4gT24gVHVlLCBPY3QgMjAsIDIwMjAgYXQgMDI6MTM6MTNBTSArMDAwMCwgWi5xLiBI
b3Ugd3JvdGU6DQo+ID4NCj4gPiBbLi4uXQ0KPiA+DQo+ID4gPiA+ID4gRm9yIE5YUCBMYXllcnNj
YXBlIHBsYXRmb3JtcyAodGhlIGxzMTAyOGEgYW5kIGxzMjA4OGEgYXJlIGFsc28NCj4gPiA+ID4g
PiBOWFANCj4gPiA+ID4gTGF5ZXJzY2FwZSBwbGF0Zm9ybSksIGFzIHRoZSBlcnJvciByZXNwb25z
ZSB0byBBWEkvQUhCIHdhcw0KPiA+ID4gPiBlbmFibGVkLCBpdCB3aWxsIGdldCBVUiBlcnJvciBh
bmQgdHJpZ2dlciBTRXJyb3Igb24gQVhJIGJ1cyB3aGVuDQo+ID4gPiA+IGl0IGFjY2Vzc2VzIGEg
bm9uLWV4aXN0ZW50IEJERiBvbiBhIGxpbmsgZG93biBidXMuIEknbSBub3QgY2xlYXINCj4gPiA+
ID4gYWJvdXQgaG93IGl0IGhhcHBlbnMgb24gZHJhN3h4eCBhbmQgaW14Niwgc2luY2UgdGhleSBk
b2Vzbid0DQo+ID4gPiA+IGVuYWJsZSB0aGUgZXJyb3INCj4gPiByZXNwb25zZSB0byBBWEkvQUhC
Lg0KPiA+ID4gPg0KPiA+ID4gPiBUaGF0J3MgZXhhY3RseSB0aGUgY2FzZSB3aXRoIERSQTd4eCBh
cyB0aGUgZXJyb3IgcmVzcG9uc2UgaXMNCj4gPiA+ID4gZW5hYmxlZCBieSBkZWZhdWx0IGluIHRo
ZSBwbGF0Zm9ybSBpbnRlZ3JhdGlvbi4NCj4gPiA+DQo+ID4gPiBHb3QgZmVlZGJhY2sgZnJvbSB0
aGUgaW14NiBvd25lciB0aGF0IGlteDYgbGlrZSB0aGUgZHJhN3h4IGhhcyB0aGUNCj4gPiA+IGVy
cm9yIHJlc3BvbnNlIGVuYWJsZWQgYnkgZGVmYXVsdC4gIE5vdyBpdCdzIGNsZWFyIHRoYXQgdGhl
IHByb2JsZW0NCj4gPiA+IG9uIGFsbCB0aGVzZSBwbGF0Zm9ybXMgaXMgdGhlIHNhbWUuDQo+ID4N
Cj4gPiBPbiBJTVg2LCBlbmFibGVkIGJ5IGRlZmF1bHQgYW5kIHJlYWQtb25seSA/IE9yIGl0IGNh
biBiZSBjaGFuZ2VkID8NCj4gDQo+IFRoZSBBWEkvQUhCIEJyaWRnZSBTbGF2ZSBFcnJvciBSZXNw
b25zZSBSZWdpc3RlciBpcyBhIGNvbW1vbiByZWdpc3RlciBvZiBEV0MgSVAsDQo+IHNvIEkgdGhp
bmsgaXQgc2hvdWxkIGJlIHdyaXRlYWJsZS4gUmljaGFyZCwgY2FuIHlvdSBoZWxwIHRvIGNvbmZp
cm0/DQo+IA0KVGhpcyByZWdpc3RlciBpcyB3cml0YWJsZSwgYnV0IG9ubHkgc29tZSBiaXRzIG9m
IHRoaXMgcmVnIGNhbiBiZSB3cm90ZS4NCg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0KDQo+
ID4gV2hhdCdzIHRoZSBwbGFuIGZvciBsYXllcnNjYXBlIG9uIHRoaXMgbWF0dGVyID8NCj4gDQo+
IEkgdHJlbmQgdG8gY2hhbmdlIGl0IGJhY2sgdG8gdGhlIGRlZmF1bHQgZXJyb3IgcmVzcG9uc2Ug
YmVoYXZpb3Igc28gdGhhdCB3b24ndA0KPiBjYXVzZSBhbnkgZXJyb3Igb24gQ0ZHIGFjY2Vzcywg
YW5kIGhhdmUgc2VudCBvdXQgdGhlIHBhdGNoLg0KPiBBbmQgZm9yIHRoZSBsaW5rIHVwIGNoZWNr
IGJlZm9yZSBDRkcgYWNjZXNzZXMsIGluIHRoZSBEV0MgZGF0YWJvb3QgKDQuNDBhKSwgaXQNCj4g
cmVxdWlyZXMgbGluayB1cCBjaGVjayBiZWZvcmUgZ2VuZXJhdGluZyBDRkcgcmVxdWVzdHMsIHNv
IG5lZWQgR3VzdGF2byBoZWxwIHRvDQo+IG1ha2Ugc3VyZSB0aGUgcmVhc29uIG9mIHRoaXMgcmVx
dWlyZW1lbnQsIGFueSBwb3RlbnRpYWwgaW1wYWN0IHdpdGhvdXQgdGhlIGxpbmsNCj4gdXAgY2hl
Y2suDQo+IA0KPiBUaGFua3MsDQo+IFpoaXFpYW5nDQo+ID4NCj4gPiBMb3JlbnpvDQo=
