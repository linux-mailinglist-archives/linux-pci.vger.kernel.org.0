Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27142269CA0
	for <lists+linux-pci@lfdr.de>; Tue, 15 Sep 2020 05:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgIODja (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Sep 2020 23:39:30 -0400
Received: from mail-am6eur05on2074.outbound.protection.outlook.com ([40.107.22.74]:16448
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726019AbgIODj2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Sep 2020 23:39:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WTb089dwZdgjWYKYx0fdTILoPRrnhZwzz/fnZNmt2QMTO4I2NCM7qYukvbR56eXO0RW5Z/2oCIEk0oDearNqqA56MyQRGqCbI0WzUPGO64QZIVcLy91LBOoYYNnuvM9H0J2irliWs0blLgzBeehC9d6BJMEjgjmLD4tc+pIph6MgfTe9v/qXoxoanEohzTPmmziQtlThcXm9VMkbqOC8rJl4gKfUJuFg61dI8ewqXnhLs7pfDpsjgcfdyUomGsv7sQ3ZHS74fp5RkO5fVi+j32pzh679/k9qcstUOgmmHbVgu/9yZvt26BLHTKs3A6IAQ0+cNMzi/Ts0ai+ui2y2YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pdQMZa2p2MYKfZiPb20NsXHQ6LqDawo0FBSYTlJQg8M=;
 b=BswIC8D9Jx+nnPC58tFA2d+TJEWER99T0P3uQ1NIOQ2RHk8IpEFOq2a5bm2+GlnPC9Iud4EmCoZmM6uCQ30fO9MJjU6WAx+Ania+Epq11nIoTTHibbodr4Y8x4K8H/yH1smXCuyqe5y2+rRTwvmTLei2ADLffXBOu5k151Th4FNmNYfhqtaM1ihLA0g0JyDDKrdGHw2bufntyt1sKmg2Kq2xR5i3XnQ2quZy9NWGbLWxZJd4FcukOsZeHVGOyuYE6UwaiyX+Wk01a8mxAQmWgfCH+ydRyKPe7/Dq8U1ta/FOvl3HQ8vFgNin/bmAdecOY9j5N6VKer6IvMPXVXioFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pdQMZa2p2MYKfZiPb20NsXHQ6LqDawo0FBSYTlJQg8M=;
 b=n0RfAMoSW2v1QLtLN6IppuC72HLc7waJf1plQFlQJT1X0qdzUsM/4Dv9NY4Uk6LzSBCA7hH3q2S/E9V8Gv4UJwAfBqQJqQM6kfbqNbbqDkTWCKchm0QhR2ms0aQOSXldM6QfyNSH5C+UjLc7KLy2f+bZFNlr0L/8Gnz2INbLCi4=
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
 by HE1PR04MB3081.eurprd04.prod.outlook.com (2603:10a6:7:1e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Tue, 15 Sep
 2020 03:39:24 +0000
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::c872:d354:7cf7:deb9]) by HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::c872:d354:7cf7:deb9%3]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 03:39:24 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        Roy Zang <roy.zang@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH 3/7] dt-bindings: pci: layerscape-pci: Add a optional
 property big-endian
Thread-Topic: [PATCH 3/7] dt-bindings: pci: layerscape-pci: Add a optional
 property big-endian
Thread-Index: AQHWhNosYnhH6b26s0a8JKbbSeYUpKlo9e6AgAAjq2A=
Date:   Tue, 15 Sep 2020 03:39:24 +0000
Message-ID: <HE1PR0402MB337196C77599A3A5E95E742884200@HE1PR0402MB3371.eurprd04.prod.outlook.com>
References: <20200907053801.22149-1-Zhiqiang.Hou@nxp.com>
 <20200907053801.22149-4-Zhiqiang.Hou@nxp.com> <20200915013039.GA667506@bogus>
In-Reply-To: <20200915013039.GA667506@bogus>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1b6c27fa-bf03-4dfc-1a8f-08d85928f0f1
x-ms-traffictypediagnostic: HE1PR04MB3081:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HE1PR04MB30812C1254C086FB3A68A92084200@HE1PR04MB3081.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U61JlKlpk6+kyO+jeQzoN3S43EFEcr8wm2v+tNY7ghpmCEIsDGyNeoLI6+zKLBEDy/qxeqBOJVJlL3/IKdH51x9gCJcNlFzFEac7ziKX1j9sphD4p3eW67gVj1wVLa44F6LySS7jqqRnaDSUg3J8nNWh1foUR5RVVr5dZNdbeM7Fd7E4ZjTo7PU6lfxdY0DD2nF1lQqHavcUjN+YE7xH5Py8RHIPFLFhr+5k9aoJaP7+QclAdVtQ9xpKBgn31uHbP/kkr+qq6/wjFCJv0U6s1VS9FDnQbF/jNFqWF3I0VBz3FJRzPUrLWyyUUImq1w35mSUVlBEGxrhkpMqM5ytpWQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3371.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(5660300002)(71200400001)(316002)(54906003)(4326008)(33656002)(9686003)(4744005)(55016002)(83380400001)(52536014)(8936002)(66476007)(66946007)(76116006)(53546011)(8676002)(86362001)(66556008)(7696005)(26005)(478600001)(64756008)(186003)(66446008)(6506007)(6916009)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: /Cj1DdEvUe4DN9RUEIxk99n4tztC+sjlqMWN374Df4BjJpC9TGtGBQSsiyCViwtjIiusA9VFsZEj3bikV6Sznj7nODHiTavEFHLHp4Hrp+L+c7vvoaiYZZlJucbYB4yIJf5kGWQP3STT4olgVlaiKPMxF4ujC6zDz/dUI2wYsBPgoKbd3uTv9SdR/+CJaC72PwrQPzuty6CpNRm1i0MOg2suJAZlR35uRtys8xiZpBtbSERkr6kOrFQZ5ppVtx5EsFwp7X0BB9JsqM8YGC5MWaCPL1kBXNIqZqSihWMJ2pgboOsPbPqvG914xAO6cq883nVWoxa/Zj3ZJxUwLUlpQKBZ1eST3bmIb1yXG3Rcj6wi6+jgvq1YiYIqqccbFHrm/fb1KEqhyGrudiKMv7RWwMZVHvH1WVRQOnpU0L1i+7dVmnQRI9nwACl5kAG61Dewu8IArEWhExswTrpa4I1Bfn9pK/71aw70mDr9H650vbi1OfJ0cWzLA0VpIM8mSjGAU8r3jPfV2QpV0sObT2uEpu8hF+GJKh8rHnN7t93DlgIyiR2ridXXjcv1ZHaZtlOezCA4eWfMzSATFRsFXdsn+eEHaTzLhbYCio8FhX6y9ursy0DabpN2NFZb25RCcb2g9Ejm3BCInvmUTnBLvelGYg==
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3371.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b6c27fa-bf03-4dfc-1a8f-08d85928f0f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2020 03:39:24.6723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lk4i7UhVz/bO7BVjte2aJbQHWvId6Sygek58YJQ8EAESB3En/csn+47opCqiregTT+8lQRHHU5TLBXyZq2IgTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3081
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgUm9iLA0KDQpUaGFua3MgYSBsb3QgZm9yIHlvdXIgcmV2aWV3IGFuZCBhY2shDQoNClJlZ2Fy
ZHMsDQpaaGlxaWFuZw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJv
YiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjDE6jnUwjE1yNUgOTozMQ0K
PiBUbzogWi5xLiBIb3UgPHpoaXFpYW5nLmhvdUBueHAuY29tPg0KPiBDYzogYmhlbGdhYXNAZ29v
Z2xlLmNvbTsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gc2hhd25ndW9Aa2VybmVs
Lm9yZzsgTGVvIExpIDxsZW95YW5nLmxpQG54cC5jb20+Ow0KPiBsaW51eC1wY2lAdmdlci5rZXJu
ZWwub3JnOyBNLmguIExpYW4gPG1pbmdodWFuLmxpYW5AbnhwLmNvbT47DQo+IHJvYmgrZHRAa2Vy
bmVsLm9yZzsgZ3VzdGF2by5waW1lbnRlbEBzeW5vcHN5cy5jb207DQo+IGxvcmVuem8ucGllcmFs
aXNpQGFybS5jb207IFJveSBaYW5nIDxyb3kuemFuZ0BueHAuY29tPjsgTWluZ2thaSBIdQ0KPiA8
bWluZ2thaS5odUBueHAuY29tPjsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVj
dDogUmU6IFtQQVRDSCAzLzddIGR0LWJpbmRpbmdzOiBwY2k6IGxheWVyc2NhcGUtcGNpOiBBZGQg
YSBvcHRpb25hbA0KPiBwcm9wZXJ0eSBiaWctZW5kaWFuDQo+IA0KPiBPbiBNb24sIDA3IFNlcCAy
MDIwIDEzOjM3OjU3ICswODAwLCBaaGlxaWFuZyBIb3Ugd3JvdGU6DQo+ID4gRnJvbTogSG91IFpo
aXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCj4gPg0KPiA+IFRoaXMgcHJvcGVydHkgaXMg
dG8gaW5kaWNhdGUgdGhlIGVuZGlhbm5lc3Mgd2hlbiBhY2Nlc3NpbmcgdGhlIFBFWF9MVVQNCj4g
PiBhbmQgUEYgcmVnaXN0ZXIgYmxvY2ssIHNvIGlmIHRoZXNlIHJlZ2lzdGVycyBhcmUgaW1wbGVt
ZW50ZWQgaW4NCj4gPiBiaWctZW5kaWFuLCBzcGVjaWZ5IHRoaXMgcHJvcGVydHkuDQo+ID4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBIb3UgWmhpcWlhbmcgPFpoaXFpYW5nLkhvdUBueHAuY29tPg0KPiA+
IC0tLQ0KPiA+ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL2xheWVyc2Nh
cGUtcGNpLnR4dCB8IDQgKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCsp
DQo+ID4NCj4gDQo+IEFja2VkLWJ5OiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPg0K
