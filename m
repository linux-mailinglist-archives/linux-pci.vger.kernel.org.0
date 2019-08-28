Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 873129F8DD
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 05:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfH1Dn5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Aug 2019 23:43:57 -0400
Received: from mail-eopbgr130043.outbound.protection.outlook.com ([40.107.13.43]:53376
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726178AbfH1Dn5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Aug 2019 23:43:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SmVOoMAG4Ik1RCTfSUzsMEvb/Bx6qo+lfvqgUdDGbELoBeSlOO7jKUUw4C4CxDCxfXdbPSlw6FzWblCDfGm2oXWfjdglp2kbL0410i5NmREA0Epy+iSfLmbMq/bCTCXfwVl0uAN70JrCgKI8dxrbCc4mim2/f3WKuIX9M3FWEKh5/R+4H7UlZ+ZPkjA5Y8raHVr7HFnsBglHWK269dhNpjCtoi3OeM00Djp42WWOrQJLoEdxjOMUP4nwfuRqevhbvl3eEwgd91Il6bQCyWG8AELLQAxaiIuAa+wulwBax2CQR9tU2e+F6UtykNp7oGsprC+83A4E8B2JFVqgrpMSSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kEZr4SiNMRoPjYeE1aaabfwR2khzVuISHKTWDJjhU78=;
 b=YBCR4M3lNR6nUYkjZ4/fl5IvgVcR0z43jufQ5hIY9Cms7V9n/pdOihYPt5n0T8vlTypOLzuCiwv9U7UAmHlXXKfMXDM3HHdKspUaXDbWL0x/ZmPpx56b+ohbOQsUrh6pZYfGWyQ0obt29FPvxSwjknv40YHO+FERGu8VfWmgbCJ9gKJ8WS7KE8aYKS6+1yhS/5njwdvfK6qtv8dY0l4jUGXlFPrJZYeAoBn3Tkx2lXZ6EpsNzqVnyctSu1HiD7o7YeHoDYBW6MjcrE4cA78UdIvRoKdq2sxG+LyobMxEnHKkAVNm2/1vu2dEV89pMJ5eQ7bmc8e9UPsa4oGKnw4tHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kEZr4SiNMRoPjYeE1aaabfwR2khzVuISHKTWDJjhU78=;
 b=j+yQ8b1PwRJfN70dV7JoVlO0NtBj2tRuTn6UTHIvbPkWG/nACzvSvxVAqr+RH30TkNhH1koLDYdT96kqfgXtpVtZCLAtOO9jeiV4Xl847PjnqEHNPhapMYX9gHWLOfY8+n4HeJwUUbwufAixK/wkq5UoFAvSvTkAnP83MIKrsgw=
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB5722.eurprd04.prod.outlook.com (20.179.10.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Wed, 28 Aug 2019 03:43:12 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::7c8a:ab5d:dc27:be5f]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::7c8a:ab5d:dc27:be5f%6]) with mapi id 15.20.2199.021; Wed, 28 Aug 2019
 03:43:11 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     Rob Herring <robh@kernel.org>
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
        "andrew.murray@arm.com" <andrew.murray@arm.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>
Subject: RE: [PATCHv2 1/4] dt-bindings: PCI: designware: Remove the num-lanes
 from  Required properties
Thread-Topic: [PATCHv2 1/4] dt-bindings: PCI: designware: Remove the num-lanes
 from  Required properties
Thread-Index: AQHVXPiOk3lFUfdm50+iCwpTtpVxrqcP61Ww
Date:   Wed, 28 Aug 2019 03:43:11 +0000
Message-ID: <DB8PR04MB674721E7EE7491BCFBBC890C84A30@DB8PR04MB6747.eurprd04.prod.outlook.com>
References: <20190820073022.24217-1-Zhiqiang.Hou@nxp.com>
 <20190820073022.24217-2-Zhiqiang.Hou@nxp.com> <20190827165742.GA5083@bogus>
In-Reply-To: <20190827165742.GA5083@bogus>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8067a688-e7ae-4f66-bacd-08d72b69d9aa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB8PR04MB5722;
x-ms-traffictypediagnostic: DB8PR04MB5722:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB5722722B9089BFED9F61A38584A30@DB8PR04MB5722.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 014304E855
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(199004)(189003)(13464003)(54534003)(53936002)(229853002)(99286004)(25786009)(76176011)(316002)(305945005)(7736002)(54906003)(102836004)(33656002)(14454004)(53546011)(6506007)(7696005)(71200400001)(4326008)(71190400001)(8936002)(74316002)(86362001)(6246003)(2906002)(14444005)(256004)(186003)(5660300002)(8676002)(478600001)(76116006)(26005)(81156014)(66476007)(66556008)(81166006)(66946007)(55016002)(52536014)(6436002)(66446008)(6916009)(64756008)(7416002)(11346002)(446003)(486006)(9686003)(3846002)(476003)(6116002)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB5722;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vdDjVgwdqjntmbECxFNVRFvH4if5L8NS3Eut6l2HKrLynTNBtpxJPyf+1gF12kxf+q1Fb+yAFN4XMd53cvgNe4S5Q7b4aI/7TQYAv3RxJrh1mWz2EISYXS6LFoex2uGmQnYd5Uxa7ogxmVwoNbOO93H1ghFZKhCPftNYzFghBtOFgy8Lqh9eQVntQZ4HKTtSkT/qpaNjd5Bb0OKzVMikh8SP9BprMeLTBQZ38wQF3NlWNRDKTBWIyN41jFHf33Dmp+DFKQiEBrNL+oJrPhstaPuDw9rgJXWGTn56prr2qA0ZZ0e5kAVn7w/+fomDzO3IAcycurhIzC/c3sW2pdoGffLxDQ/OHNl9l/zaxyt6+wny7HT17RfxdKqnJ6GzHseB0ZKdM/PIaN5UOzpp0LvPebSkW5up1luYGaIisTdEAic=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8067a688-e7ae-4f66-bacd-08d72b69d9aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2019 03:43:11.8350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dBURenvYppamDlRXx39kp0dLyBGd8CUMrfJFYgvza4+OyZ48lwh7OmldPx4zDsjFl90nDGZEJJyITc5CMSSkgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5722
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgUm9iLA0KDQpUaGFua3MgYSBsb3QgZm9yIHlvdXIgcmV2aWV3IQ0KDQpUaGFua3MsDQpaaGlx
aWFuZw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJvYiBIZXJyaW5n
IDxyb2JoQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMTnE6jjUwjI4yNUgMDo1OA0KPiBUbzogWi5x
LiBIb3UgPHpoaXFpYW5nLmhvdUBueHAuY29tPg0KPiBDYzogbGludXgtcGNpQHZnZXIua2VybmVs
Lm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IGd1c3Rhdm8ucGltZW50ZWxAc3lub3BzeXMuY29tOw0KPiBqaW5nb29oYW4xQGdt
YWlsLmNvbTsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsgcm9iaCtkdEBrZXJuZWwub3JnOw0KPiBtYXJr
LnJ1dGxhbmRAYXJtLmNvbTsgc2hhd25ndW9Aa2VybmVsLm9yZzsgTGVvIExpDQo+IDxsZW95YW5n
LmxpQG54cC5jb20+OyBsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tOw0KPiBhbmRyZXcubXVycmF5
QGFybS5jb207IE0uaC4gTGlhbiA8bWluZ2h1YW4ubGlhbkBueHAuY29tPjsgWi5xLiBIb3UNCj4g
PHpoaXFpYW5nLmhvdUBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIdjIgMS80XSBkdC1i
aW5kaW5nczogUENJOiBkZXNpZ253YXJlOiBSZW1vdmUgdGhlDQo+IG51bS1sYW5lcyBmcm9tIFJl
cXVpcmVkIHByb3BlcnRpZXMNCj4gDQo+IE9uIFR1ZSwgMjAgQXVnIDIwMTkgMDc6Mjg6NDMgKzAw
MDAsICJaLnEuIEhvdSIgd3JvdGU6DQo+ID4gRnJvbTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5I
b3VAbnhwLmNvbT4NCj4gPg0KPiA+IFRoZSBudW0tbGFuZXMgaXMgbm90IGEgbWFuZGF0b3J5IHBy
b3BlcnR5LCBlLmcuIG9uIEZTTCBMYXllcnNjYXBlDQo+ID4gU29DcywgdGhlIFBDSWUgbGluayB0
cmFpbmluZyBpcyBjb21wbGV0ZWQgYXV0b21hdGljYWxseSBiYXNlIG9uIHRoZQ0KPiA+IHNlbGVj
dGVkIFNlckRlcyBwcm90b2NvbCwgaXQgZG9lc24ndCBuZWVkIHRoZSBudW0tbGFuZXMgdG8gc2V0
LXVwIHRoZQ0KPiA+IGxpbmsgd2lkdGguDQo+ID4NCj4gPiBJdCBpcyBwcmV2aW91c2x5IGluIGJv
dGggUmVxdWlyZWQgYW5kIE9wdGlvbmFsIHByb3BlcnRpZXMsIGxldCdzDQo+ID4gcmVtb3ZlIGl0
IGZyb20gdGhlIFJlcXVpcmVkIHByb3BlcnRpZXMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBI
b3UgWmhpcWlhbmcgPFpoaXFpYW5nLkhvdUBueHAuY29tPg0KPiA+IC0tLQ0KPiA+IFYyOg0KPiA+
ICAtIFJld29yZGVkIHRoZSBjaGFuZ2UgbG9nIGFuZCBzdWJqZWN0Lg0KPiA+ICAtIEZpeGVkIGEg
dHlwbyBpbiBzdWJqZWN0Lg0KPiA+DQo+ID4gIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9wY2kvZGVzaWdud2FyZS1wY2llLnR4dCB8IDEgLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwg
MSBkZWxldGlvbigtKQ0KPiA+DQo+IA0KPiBSZXZpZXdlZC1ieTogUm9iIEhlcnJpbmcgPHJvYmhA
a2VybmVsLm9yZz4NCg==
