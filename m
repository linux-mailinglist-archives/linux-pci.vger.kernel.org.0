Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86BA42728E5
	for <lists+linux-pci@lfdr.de>; Mon, 21 Sep 2020 16:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgIUOs3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Sep 2020 10:48:29 -0400
Received: from mail-eopbgr70083.outbound.protection.outlook.com ([40.107.7.83]:12912
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727030AbgIUOs2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Sep 2020 10:48:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VY5tpA0YLkLi75UN65K990cBb/fhm5i+hZu2gG9rN1CLFpLYnEq9YvGZeYgWKzamRPbL0SXTnj9CuADfJvaaSYGkqIMnBRhXxc9/NVqAKTav4g681DSmRNTEumQw6iCJP64dj0xNiqWZTvBSvMsG5cVJr0yV52hCin4ODCecASpkHAt83SucAk1Zps1LnvYxl9Lhn6Iw5WKJUTAP0R71aAIIJQYH/ESyor6te5O3AU4GbnLm/GSZuBVpaWHjc0OWcFhbR6VqNeg85lrQrKoqBT4Jv+Zz3KVV0FGx4V6/FqV0ebX+E3qRWH3XD0WPvRoWR0mGoOZp3qgB+fBaVysFdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djYurb92To2ZF1vAPKTLuK5vreqKoG+XatluiKuiWYs=;
 b=klcyXMrlli7nt9TigASxJAoYBU2+TjQuei3gT8HqBTAyBXERf53vOEBCZrOuUNybezJFvmxdDhrYGbT0t+G7YyDtdTl70ol3SWsYSMBqT1d1W6wxOrjhFGe4c4M8nKo5RaQBmN9lgv3ZjG4p/e094Q0p5tRdxi2IYg56bUOPJZPq8JlRDWJT/6wLdcrRtvkzvlEBOg4e/dI+Gtctdw/VAWKMcFyiGSyQCe4M3O5X2QikNf3mgvsVlFqwszCLn68lwmjZdMj6G3XZgJl6kM5p3Hv5vrvC1gFk1PpHIEZZ8vja472Ja3nm6jFUXUa6WwbiSLplirp3OPG6/Iyc9+EoGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djYurb92To2ZF1vAPKTLuK5vreqKoG+XatluiKuiWYs=;
 b=jpOo5g20pC3kv5WPX8KP2WEY4hksV0E2EmPOO8l66B0iabamG7Ie+1C8irih0zwItHSgtROGZjUkOzWkML7aa8rp5BJjWkrF/MpDRqUCHe8cR+0t668y+6wLCyoQlcJh29oP/IvSIR6iqROX19xzaPF/+vlFeyOfNov5TkAU57o=
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
 by HE1PR0402MB3370.eurprd04.prod.outlook.com (2603:10a6:7:7e::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.22; Mon, 21 Sep
 2020 14:48:24 +0000
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::c872:d354:7cf7:deb9]) by HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::c872:d354:7cf7:deb9%3]) with mapi id 15.20.3391.026; Mon, 21 Sep 2020
 14:48:24 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     Michael Walle <michael@walle.cc>
CC:     Rob Herring <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: RE: [PATCH] PCI: dwc: Added link up check in map_bus of
 dw_child_pcie_ops
Thread-Topic: [PATCH] PCI: dwc: Added link up check in map_bus of
 dw_child_pcie_ops
Thread-Index: AQHWi+0seUdQCD5Vd0CU4riR8OTpR6lruCmAgAJdkFCAACwiAIAE7n/A
Date:   Mon, 21 Sep 2020 14:48:24 +0000
Message-ID: <HE1PR0402MB3371D5A66BFC7153514FF063843A0@HE1PR0402MB3371.eurprd04.prod.outlook.com>
References: <20200916054130.8685-1-Zhiqiang.Hou@nxp.com>
 <CAL_JsqJwgNUpWFTq2YWowDUigndSOB4rUcVm0a_U=FEpEmk94Q@mail.gmail.com>
 <HE1PR0402MB3371F8191538F47E8249F048843F0@HE1PR0402MB3371.eurprd04.prod.outlook.com>
 <cb8b32463679c208b394879636451c77@walle.cc>
In-Reply-To: <cb8b32463679c208b394879636451c77@walle.cc>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: walle.cc; dkim=none (message not signed)
 header.d=none;walle.cc; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8cfa88a9-d102-4bb8-5492-08d85e3d64ba
x-ms-traffictypediagnostic: HE1PR0402MB3370:
x-microsoft-antispam-prvs: <HE1PR0402MB3370D98AC908C2A53FBF499E843A0@HE1PR0402MB3370.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7L02u5etrR8LLEGcrEC/F3Wftq1NCe4rUE8Ai4KpgIkTp3gc00s6oj6ZaQ5HpSAsewsXQxoG5LM/gCoeBlT6ZGCI72bM0xbG7Is4ZvTk2aW7cTb2l2dIGOXMuJs4TIHWA6v9M04ChGYxfBWxyLf89aGPoRNPHtI/RC19rKDSBru+CMCe9fJZJQ+CITgU5stIaSYv8pJKGEgX5WpKt+o7U6Oh484UPItOBepno0Fuhev7TrvkXtURqi2vF1/s4pPQ3UuAIL3ITjhKloOAD94Ia8uDwiG91oOb8OqfyfjKDzLZ3sZsIgSA3u3Jskyp5dsXVYBvgfdExoJ1LEBxWSVZDQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3371.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(346002)(136003)(39860400002)(83380400001)(55016002)(6506007)(9686003)(52536014)(7696005)(186003)(316002)(8676002)(53546011)(26005)(33656002)(4326008)(4744005)(2906002)(6916009)(478600001)(8936002)(66946007)(5660300002)(76116006)(54906003)(66556008)(66446008)(64756008)(66476007)(71200400001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: S0UIdLXuRpCSfM9Uc5H0fL/IHzRflxWVIrTIF36gOBI9mNn5LSfcYuwznQPtxhV4aBwEBRqBS8+a5kdQhZ6lSh5jVnZ2rXB/V+FvPPpwZjYa2LIZlJnBa/tbM5bmnVj+GnZYhshSvav1k3xyNxo2xYG7p0apzIX8TZQM65RglLCOQ6o37vgBRtc9HcRbT1j+WtoKa7Keq8po43JrbhCstvJ5icg1Em0Zww5kA1vp1UCOrXvVgNDjGRmS3P5DSsDiNk+Zh4mxzOsbf1vqePbFLzEUTdqUB/CKVkG4+E07WSs7otBBIsNmheOpnnc4ggzpRpnwvpyM7lK3m31GEmL6adGxO2uFAAp0yRZSzCqYUn0wGc1AiBa8RC1xEX107tmFhODOg6hhszcoqvfnAPU0cR//UTVuGA6bXwlDEebQdgrzOZPE6QLCIzwv7nDSINj1pXU/ITGcBfyxjBNILDwM/FNjzTsBv2A/oQg4l5ZoHVAZYGKNJ+Cd7+jyLuaA92/qP37aBLlyxAFrRU7/g7A4AGcwtGF75UD5Z53nVBHwc25pIu65quKs64yO21kNYF09zZeLAtHXII8m1c3gAHVbKnXwR8nIKfp4yhCa/4oXKDwhYi1XvdDGNXtSXw6SKSjKdhwarjTbSi1U39o6Rkm+Mg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3371.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cfa88a9-d102-4bb8-5492-08d85e3d64ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2020 14:48:24.7624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v8ilHW/Y2OKuhg0n4GlNg+o4HlEWMcoEmrq0q7U4crZ7mNNZ/aNTirJIZ0ZU01B+lisSXQzlyg3ZmZk/4J80ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3370
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgTWljaGFlbCwNCg0KVGhhbmtzIGEgbG90IGZvciB5b3VyIGNvbW1lbnRzIQ0KDQo+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1pY2hhZWwgV2FsbGUgPG1pY2hhZWxAd2Fs
bGUuY2M+DQo+IFNlbnQ6IDIwMjDE6jnUwjE4yNUgMTk6MTQNCj4gVG86IFoucS4gSG91IDx6aGlx
aWFuZy5ob3VAbnhwLmNvbT4NCj4gQ2M6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+OyBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBQQ0kNCj4gPGxpbnV4LXBjaUB2Z2VyLmtlcm5l
bC5vcmc+OyBMb3JlbnpvIFBpZXJhbGlzaSA8bG9yZW56by5waWVyYWxpc2lAYXJtLmNvbT47DQo+
IEJqb3JuIEhlbGdhYXMgPGJoZWxnYWFzQGdvb2dsZS5jb20+OyBHdXN0YXZvIFBpbWVudGVsDQo+
IDxndXN0YXZvLnBpbWVudGVsQHN5bm9wc3lzLmNvbT47IEFyZCBCaWVzaGV1dmVsIDxhcmRiQGtl
cm5lbC5vcmc+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIFBDSTogZHdjOiBBZGRlZCBsaW5rIHVw
IGNoZWNrIGluIG1hcF9idXMgb2YNCj4gZHdfY2hpbGRfcGNpZV9vcHMNCj4gDQo+IEhpIFpoaXFp
YW5nLA0KPiANCj4gPiBTbyB0aGUgYWx0ZXJuYXRpdmUgc29sdXRpb24gc2VlbXMgdG8gY29ycmVj
dCB0aGUgUENJZSBlbnVtZXJhdGlvbiwgSQ0KPiA+IHdpbGwgc3VibWl0IGEgcGF0Y2ggdG8gbGV0
IHRoZSBmaXJzdCBhY2Nlc3Mgb25seSByZWFkIHRoZSBWZW5kb3IgSUQuDQo+IA0KPiBQbGVhc2Ug
cHV0IG1lIG9uIENDIG9mIHRoYXQgcGF0Y2guDQoNClNhdyBtb3JlIGNvbW1lbnRzIG9uIHRoaXMs
IEknbGwgZGlzY3VzcyBtb3JlIHdpdGggUm9iIGFuZCBCam9ybiwgYW5kIG11c3QgYWN0IHBydWRl
bnRseS4NCg0KUmVnYXJkcywNClpoaXFpYW5nDQoNCj4gDQo+IFRoYW5rcywNCj4gLW1pY2hhZWwN
Cg==
