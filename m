Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B85BB8ACF7
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2019 05:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfHMDH2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Aug 2019 23:07:28 -0400
Received: from mail-eopbgr80053.outbound.protection.outlook.com ([40.107.8.53]:40838
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726236AbfHMDH2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Aug 2019 23:07:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BKWYFLaqCIXnqpLTUKV/J7pfm3+BMWzhbuAmwXNvDnRIxl/n5NypsrsqkCrEsTdoxPGPjl3EoKHcym4Ti/BWq3QqXyHTstQ7/2eCPfJ84xVtDMYbaDqF5RDVjQEVwT0BZvGz9PAyXl8rwVIJ06DCnLwtPdFSgoshoBOYBVUGy6WAxMkR8z5KfwCRuWhpeL8lgsmgzNjHhWNp0AF/zxFieR7bERmKbA9zHjIeRD+mVoz6hjGDGU+P+0GngBZIwsKPyV5NUaQBmamG2MppVQz7ShSRN/PmDC1dPBvNqGxMkBQeGSOada1/W3lwi64j71gRaYnAavwIOuvZ0NhLec7EIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mMqYSJDquH25j2ml7Ca23LdywNq6CNECaFZ/xC78f6E=;
 b=TRAEgZa7qBGW+LdDR0Uny6QtdM+MFAVQPN/qLjaxmoGcyvYpnlgWHLsbfGcKXRQObp/oVAtNOOdKNH60BKDTUOWG3cnXcFICqcrUq0rf3f3zMlw2Y3GDv84mJ8+dzfK1k5wwpv6XXkF9gUxtlY1oBPIzM/Bpzo3xBt0j4cmhIu/vioz58/q09Yta/d/1ODgjyQQde5WTyP2cX5qm8XJVeSwfszBJyhO25hu2/o3xy8MFRyhH//3gA8Av+zkUSTjqRA9noR1CtmRBGVRaa6VRkk97RipJXz2ZrcuJ2nUZq5kiRBQZwgWC5hIyt0Os9luhAMdINRQJfL3FGkHMMYWtwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mMqYSJDquH25j2ml7Ca23LdywNq6CNECaFZ/xC78f6E=;
 b=N8sUjtuT2XUtV3ZZ4vaclUmVUIBkalj8z43eS9m69V9+mVNZcWR9LQf2jBDNJyAy5ikF7MF9sXffMbyAg9t5DF3K6Ep3KKh/GVFAPvjUpwZDiAv4iQ82E1ePcnTRZnQPURHYQjosZRNOYYsVYwZJxYN6ssYeaHYlHJuG8edbLZU=
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB7050.eurprd04.prod.outlook.com (52.135.62.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.18; Tue, 13 Aug 2019 03:07:22 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::19ec:cddf:5e07:37eb]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::19ec:cddf:5e07:37eb%3]) with mapi id 15.20.2157.015; Tue, 13 Aug 2019
 03:07:22 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     Andrew Murray <andrew.murray@arm.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>
Subject: RE: [PATCH 1/4] dt-bingings: PCI: Remove the num-lanes from Required
 properties
Thread-Topic: [PATCH 1/4] dt-bingings: PCI: Remove the num-lanes from Required
 properties
Thread-Index: AQHVUMWGvFlksd6l7UqMedZRUuiO6Kb3MvyAgAEydZA=
Date:   Tue, 13 Aug 2019 03:07:22 +0000
Message-ID: <DB8PR04MB67476309D3F7E30FE35C47DF84D20@DB8PR04MB6747.eurprd04.prod.outlook.com>
References: <20190812042435.25102-1-Zhiqiang.Hou@nxp.com>
 <20190812042435.25102-2-Zhiqiang.Hou@nxp.com>
 <20190812084517.GW56241@e119886-lin.cambridge.arm.com>
In-Reply-To: <20190812084517.GW56241@e119886-lin.cambridge.arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d5cb7af9-1182-4a7d-8076-08d71f9b5c26
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB8PR04MB7050;
x-ms-traffictypediagnostic: DB8PR04MB7050:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB7050975CF7930E95F4827C1E84D20@DB8PR04MB7050.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01283822F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(39860400002)(366004)(396003)(376002)(13464003)(189003)(199004)(76176011)(6436002)(478600001)(5660300002)(6246003)(8936002)(7696005)(52536014)(53936002)(99286004)(3846002)(6506007)(6116002)(53546011)(25786009)(55016002)(66446008)(2906002)(14454004)(66066001)(4326008)(256004)(64756008)(71190400001)(71200400001)(446003)(76116006)(54906003)(66946007)(66556008)(33656002)(66476007)(6916009)(8676002)(102836004)(81156014)(86362001)(81166006)(74316002)(316002)(26005)(7736002)(9686003)(476003)(486006)(186003)(11346002)(229853002)(305945005)(14444005)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB7050;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yljjz/kAcocvHUjJQFAbBHEXONJ8hWLd6WIU5WlSowM2hsUISCMziir8ul1O0BDYICIuS1aVlpazks3vRfz7NR9XG8UrMi5hYi+LqCLyoS3UZsKA+3XwkAgxwwNEz2rRK2emgfE2r65IQ7h2++MVx+9V5Fm8Cj/Eo4D0O6+JMxyTbI/QaYCLSXWSidsDawXRqalHegrw94yAYXUjqeYIU2egir1kkzleqG75C4/JLuNvinG9kcmbjGxgNUeiIb3Z5TCFuyOJjEW82VfQvTOk/4+BgGdJulukd3/cqEMatwk/iyKYL8O2h9HgjVPaaaYs6uplKFcZrJ2oAnni8QSQxO+Crd/9yF6pPJb0ksm3YZIhEaif9kvQ88NY3tgea8RwXzyAfnfOtk+hXa3SSq0QY0O90ScsDzxY6fOGh1cIqfY=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5cb7af9-1182-4a7d-8076-08d71f9b5c26
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2019 03:07:22.1454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 07JB+ZNKVaxJpXrYmj3KpyL8+5UHj0/WpHAEq3e3jGkwsdV4NFUBQar0NSZGYyHk/rLK+RFHv81J4u3KZc0jOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7050
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgQW5kcmV3LA0KDQpUaGFua3MgYSBsb3QgZm9yIHlvdXIgY29tbWVudHMhDQoNCj4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5kcmV3IE11cnJheSA8YW5kcmV3Lm11cnJh
eUBhcm0uY29tPg0KPiBTZW50OiAyMDE5xOo41MIxMsjVIDE2OjQ1DQo+IFRvOiBaLnEuIEhvdSA8
emhpcWlhbmcuaG91QG54cC5jb20+DQo+IENjOiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBk
ZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZzsgZ3VzdGF2by5waW1lbnRlbEBzeW5vcHN5cy5jb207DQo+IGppbmdvb2hhbjFAZ21haWwuY29t
OyBiaGVsZ2Fhc0Bnb29nbGUuY29tOyByb2JoK2R0QGtlcm5lbC5vcmc7DQo+IG1hcmsucnV0bGFu
ZEBhcm0uY29tOyBzaGF3bmd1b0BrZXJuZWwub3JnOyBMZW8gTGkNCj4gPGxlb3lhbmcubGlAbnhw
LmNvbT47IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207IE0uaC4gTGlhbg0KPiA8bWluZ2h1YW4u
bGlhbkBueHAuY29tPjsgS2lzaG9uIFZpamF5IEFicmFoYW0gSSA8a2lzaG9uQHRpLmNvbT47DQo+
IEdhYnJpZWxlIFBhb2xvbmkgPGdhYnJpZWxlLnBhb2xvbmlAaHVhd2VpLmNvbT4NCj4gU3ViamVj
dDogUmU6IFtQQVRDSCAxLzRdIGR0LWJpbmdpbmdzOiBQQ0k6IFJlbW92ZSB0aGUgbnVtLWxhbmVz
IGZyb20NCj4gUmVxdWlyZWQgcHJvcGVydGllcw0KPiANCj4gT24gTW9uLCBBdWcgMTIsIDIwMTkg
YXQgMDQ6MjI6MTZBTSArMDAwMCwgWi5xLiBIb3Ugd3JvdGU6DQo+ID4gRnJvbTogSG91IFpoaXFp
YW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCj4gPg0KPiA+IFRoZSBudW0tbGFuZXMgaXMgbm90
IGEgbWFuZGF0b3J5IHByb3BlcnR5LCBlLmcuIG9uIEZTTCBMYXllcnNjYXBlDQo+ID4gU29Dcywg
dGhlIFBDSWUgbGluayB0cmFpbmluZyBpcyBjb21wbGV0ZWQgYXV0b21hdGljYWxseSBiYXNlIG9u
IHRoZQ0KPiA+IHNlbGVjdGVkIFNlckRlcyBwcm90b2NvbCwgaXQgZG9lc24ndCBuZWVkIHRoZSBu
dW0tbGFuZXMgdG8gc2V0LXVwIHRoZQ0KPiA+IGxpbmsgd2lkdGguDQo+ID4NCj4gPiBJdCBoYXMg
YmVlbiBhZGRlZCBpbiB0aGUgT3B0aW9uYWwgcHJvcGVydGllcy4gVGhpcyBwYXRjaCBpcyB0byBy
ZW1vdmUNCj4gPiBpdCBmcm9tIHRoZSBSZXF1aXJlZCBwcm9wZXJ0aWVzLg0KPiANCj4gRm9yIGNs
YXJpdHksIG1heWJlIHRoaXMgcGFyYWdyYXBoIGNhbiBiZSByZXdvcmRlZCB0bzoNCj4gDQo+ICJJ
dCBpcyBwcmV2aW91c2x5IGluIGJvdGggUmVxdWlyZWQgYW5kIE9wdGlvbmFsIHByb3BlcnRpZXMs
ICBsZXQncyByZW1vdmUgaXQNCj4gZnJvbSB0aGUgUmVxdWlyZWQgcHJvcGVydGllcyIuDQoNCkFn
cmVlIGFuZCB3aWxsIGNoYW5nZSBpbiB2Mi4NCg0KPiANCj4gSSBkb24ndCB1bmRlcnN0YW5kIHdo
eSB0aGlzIHByb3BlcnR5IGlzIHByZXZpb3VzbHkgaW4gYm90aCByZXF1aXJlZCBhbmQNCj4gb3B0
aW9uYWwuLi4NCj4gDQo+IEl0IGxvb2tzIGxpa2UgbnVtLWxhbmVzIHdhcyBmaXJzdCBtYWRlIG9w
dGlvbmFsIGJhY2sgaW4NCj4gMjAxNSBhbmQgcmVtb3ZlZCBmcm9tIHRoZSBSZXF1aXJlZCBzZWN0
aW9uICg5MDdmY2UwOTAyNTMpLg0KPiBCdXQgdGhlbiByZS1hZGRlZCBiYWNrIGludG8gdGhlIFJl
cXVpcmVkIHNlY3Rpb24gaW4gMjAxNyB3aXRoIHRoZSBhZGl0aW9uIG9mDQo+IGJpbmRpbmdzIGZv
ciBFUCBtb2RlIChiMTJiZWZlY2Q3ZGUpLg0KPiANCj4gSXMgbnVtLWxhbmVzIGFjdHVhbGx5IHJl
cXVpcmVkIGZvciBFUCBtb2RlPw0KDQpLaXNob24sIHBsZWFzZSBoZWxwIHRvIGFuc3dlciB0aGlz
IHF1ZXJ5Pw0KDQpUaGFua3MsDQpaaGlxaWFuZw0KDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBBbmRy
ZXcgTXVycmF5DQo+IA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSG91IFpoaXFpYW5nIDxaaGlx
aWFuZy5Ib3VAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3BjaS9kZXNpZ253YXJlLXBjaWUudHh0IHwgMSAtDQo+ID4gIDEgZmlsZSBjaGFu
Z2VkLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9kZXNpZ253YXJlLXBjaWUudHh0DQo+ID4gYi9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL2Rlc2lnbndhcmUtcGNpZS50eHQNCj4gPiBp
bmRleCA1NTYxYTFjMDYwZDAuLmJkODgwZGYzOWE3OSAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL2Rlc2lnbndhcmUtcGNpZS50eHQNCj4gPiAr
KysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL2Rlc2lnbndhcmUtcGNp
ZS50eHQNCj4gPiBAQCAtMTEsNyArMTEsNiBAQCBSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPiA+ICAJ
ICAgICB0aGUgQVRVIGFkZHJlc3Mgc3BhY2UuDQo+ID4gICAgICAoVGhlIG9sZCB3YXkgb2YgZ2V0
dGluZyB0aGUgY29uZmlndXJhdGlvbiBhZGRyZXNzIHNwYWNlIGZyb20NCj4gInJhbmdlcyINCj4g
PiAgICAgIGlzIGRlcHJlY2F0ZWQgYW5kIHNob3VsZCBiZSBhdm9pZGVkLikNCj4gPiAtLSBudW0t
bGFuZXM6IG51bWJlciBvZiBsYW5lcyB0byB1c2UNCj4gPiAgUkMgbW9kZToNCj4gPiAgLSAjYWRk
cmVzcy1jZWxsczogc2V0IHRvIDwzPg0KPiA+ICAtICNzaXplLWNlbGxzOiBzZXQgdG8gPDI+DQo+
ID4gLS0NCj4gPiAyLjE3LjENCj4gPg0K
