Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D448DBC3A
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2019 06:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437922AbfJRE6o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Oct 2019 00:58:44 -0400
Received: from mail-eopbgr30041.outbound.protection.outlook.com ([40.107.3.41]:64899
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728791AbfJRE6n (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Oct 2019 00:58:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gbmIOQ2dQ8l1p1AQPq5/B4/rgvTsy0Hz0RaNIIDNMoUfYLORbRiWFfTQw7AxcBujXGyv3PLwVHjZ4fOnu8BwzxgOH2PVMKATESrYy+7ualvJxJWHzrknnxZP7xyKPLiotgSqnnhmIqlU6LDsTo5rhW1E7/C6Rgedf8gwJh7VHtoDfzfzBdgDh3AbdU4wreWi3E7SeSp+X9LCAZGVe2Trpbbca6TK5zqK45LZf3au2DOq4lI9IxcepsBkVnCIAyObN50Gg53/GBqBjTun5dkbJPAiskemzby4TREElakSIam0krvCc5hU65VsRkGnxqBVKBCWE7pAjUibyEfmig2cOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4G26r3SV86hOTfiqFqyHzH7rcVO+H2/Kt3qNkGg+zYA=;
 b=nHaRyDVQZsjDc6LfCnfLDiLgfd5PSAR6eGGaO7S+tF0zFSeTIQmt/a966C+aXWghu3h6HPJviTZ11fUJGtUFrssROTKngGtkJkpBOU2HYRHSKNL1XQ36ZVYZM7AbMuedLNF6IWCB+WHf2hH+fr0obh1OfA5O5phoLoaKTWbz4HP9GO/t3uKTXHBbb2UWfSbcyroDLWz8l9myweK/CiF2ovb9m2o6GdCBT7LnkwQhY6AbyaPUVRuP0OQa8Bs5cP8Mh+fPFnf43PG1G7uT41MK2tsVMBRouGTlDDk+7RtqKSH9oQN8Bh08copyOL5+cIbGRF6zVAXDRYFJ4RfagUuTtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4G26r3SV86hOTfiqFqyHzH7rcVO+H2/Kt3qNkGg+zYA=;
 b=VFpuAr9FyVApYStP5zVKx7n5WoOUO1pNS8VJugQJgl7UfV5VnPWo/BEh2mRjh1afwglBGnu741eGU570ga3XayixFSxPJInB5z+fdHPS5Yx7ITtr0AdgxcNSF98VHkwGWGFYfZDmvoZ90JTlb5V7+6+33BlnZQYLcn30sCGpOII=
Received: from AM5PR04MB3299.eurprd04.prod.outlook.com (10.173.255.158) by
 AM5PR04MB3220.eurprd04.prod.outlook.com (10.173.255.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.19; Fri, 18 Oct 2019 03:54:18 +0000
Received: from AM5PR04MB3299.eurprd04.prod.outlook.com
 ([fe80::204a:79f8:1bb8:f8a8]) by AM5PR04MB3299.eurprd04.prod.outlook.com
 ([fe80::204a:79f8:1bb8:f8a8%7]) with mapi id 15.20.2347.024; Fri, 18 Oct 2019
 03:54:18 +0000
From:   Xiaowei Bao <xiaowei.bao@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     "Z.q. Hou" <zhiqiang.hou@nxp.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>, "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/6] dt-bindings: Add DT binding for PCIE GEN4 EP of
 the layerscape
Thread-Topic: [PATCH v2 2/6] dt-bindings: Add DT binding for PCIE GEN4 EP of
 the layerscape
Thread-Index: AQHVgzVEXBWX/Rj7DEeiWUf3Yjv8eKdfNJ4AgACT71A=
Date:   Fri, 18 Oct 2019 03:54:17 +0000
Message-ID: <AM5PR04MB3299B26CDCB3528F664AA4D6F56C0@AM5PR04MB3299.eurprd04.prod.outlook.com>
References: <20191015083702.21792-1-xiaowei.bao@nxp.com>
 <20191015083702.21792-3-xiaowei.bao@nxp.com> <20191017190310.GA32063@bogus>
In-Reply-To: <20191017190310.GA32063@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xiaowei.bao@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9df791df-5ec3-4a36-f8f7-08d7537ed9dc
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: AM5PR04MB3220:|AM5PR04MB3220:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM5PR04MB3220516B5D7EC81F8794414FF56C0@AM5PR04MB3220.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01949FE337
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(189003)(13464003)(199004)(54906003)(33656002)(7416002)(9686003)(81156014)(81166006)(316002)(256004)(14444005)(52536014)(25786009)(8936002)(229853002)(6436002)(5660300002)(66066001)(55016002)(66476007)(66556008)(4326008)(3846002)(6116002)(476003)(446003)(11346002)(26005)(186003)(64756008)(6916009)(86362001)(2906002)(66446008)(76116006)(44832011)(6246003)(486006)(66946007)(478600001)(14454004)(99286004)(305945005)(8676002)(7736002)(6506007)(74316002)(53546011)(76176011)(102836004)(7696005)(71190400001)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR04MB3220;H:AM5PR04MB3299.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vvS/qqucSvQcrcB61Zsx7ZuveDY9hFtlrW7oJsfGC7R+ms7QGn8fUJXba7INOqCemZ+vdqI2RgRK6DLJ8iUWWQ4S7ufll8NWzE+lWfZF6gN9QjUc63mr2SrLH9UAl83kzbI9UGH+681yUPgxij6SoG5upFmcxkcEVjcV9lKykw8YAWkqJML5ZDarVscOmYvy9bxhz7o9XSf0QADG7BGBIxdzHjupVAjVrJHTB3HvPCYae0W0yLsXWd5o/W7E0PXgYvNHby+MbxPEh4SHJqPzEJtn/kGm/2z5JvggiKLIp1ezxPLh+I8RsVrqxF+QZIpEsoPI3rRsiOF7VBbaslm82TMLeak98sqiPQVFBA9Zl/rfUyW/BtvRB3jfo3VtKLG9TNcTyqcWlM3T2u4k8pv98tUXvGlHbA5Zu3MB3xpByoU=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9df791df-5ec3-4a36-f8f7-08d7537ed9dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2019 03:54:18.0987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h+n7WyjSZhdD6dLGOAY+BH2ll9+q230wjzLOA1/xQNLneqVKuTpMdshSqQJMwUuDbB0LEYJwtEGlfkLUo/w1XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3220
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iIEhlcnJpbmcgPHJv
YmhAa2VybmVsLm9yZz4NCj4gU2VudDogMjAxOcTqMTDUwjE4yNUgMzowMw0KPiBUbzogWGlhb3dl
aSBCYW8gPHhpYW93ZWkuYmFvQG54cC5jb20+DQo+IENjOiBaLnEuIEhvdSA8emhpcWlhbmcuaG91
QG54cC5jb20+OyBiaGVsZ2Fhc0Bnb29nbGUuY29tOw0KPiBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsg
c2hhd25ndW9Aa2VybmVsLm9yZzsgTGVvIExpDQo+IDxsZW95YW5nLmxpQG54cC5jb20+OyBraXNo
b25AdGkuY29tOyBsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tOyBNLmguIExpYW4NCj4gPG1pbmdo
dWFuLmxpYW5AbnhwLmNvbT47IGFuZHJldy5tdXJyYXlAYXJtLmNvbTsgTWluZ2thaSBIdQ0KPiA8
bWluZ2thaS5odUBueHAuY29tPjsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9y
ZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IHYyIDIvNl0gZHQtYmluZGluZ3M6IEFkZCBEVCBiaW5kaW5nIGZvciBQQ0lFIEdFTjQgRVAgb2YN
Cj4gdGhlIGxheWVyc2NhcGUNCj4gDQo+IE9uIFR1ZSwgT2N0IDE1LCAyMDE5IGF0IDA0OjM2OjU4
UE0gKzA4MDAsIFhpYW93ZWkgQmFvIHdyb3RlOg0KPiA+IEFkZCB0aGUgZG9jdW1lbnRhdGlvbiBm
b3IgdGhlIERldmljZSBUcmVlIGJpbmRpbmcgb2YgdGhlIGxheWVyc2NhcGUNCj4gPiBQQ0llIEdF
TjQgY29udHJvbGxlciB3aXRoIEVQIG1vZGUuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBYaWFv
d2VpIEJhbyA8eGlhb3dlaS5iYW9AbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiB2MjoNCj4gPiAgLSBy
ZW1vdmUgdGhlIHN0YXR1cyBlbnRyeSBpbiBFUCBFeGFtcGxlLg0KPiA+DQo+ID4gIC4uLi9iaW5k
aW5ncy9wY2kvbGF5ZXJzY2FwZS1wY2llLWdlbjQudHh0ICAgICAgICAgIHwgMjcNCj4gKysrKysr
KysrKysrKysrKysrKysrLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdA0KPiA+IGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9sYXllcnNjYXBlLXBjaWUtZ2VuNC50eHQNCj4gPiBiL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvbGF5ZXJzY2FwZS1wY2llLWdlbjQu
dHh0DQo+ID4gaW5kZXggYjQwZmI1ZC4uMDZmOTMwOSAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL2xheWVyc2NhcGUtcGNpZS1nZW40LnR4dA0K
PiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvbGF5ZXJzY2Fw
ZS1wY2llLWdlbjQudHh0DQo+ID4gQEAgLTMsNiArMyw4IEBAIE5YUCBMYXllcnNjYXBlIFBDSWUg
R2VuNCBjb250cm9sbGVyICBUaGlzIFBDSWUNCj4gPiBjb250cm9sbGVyIGlzIGJhc2VkIG9uIHRo
ZSBNb2JpdmVpbCBQQ0llIElQIGFuZCB0aHVzIGluaGVyaXRzIGFsbCAgdGhlDQo+ID4gY29tbW9u
IHByb3BlcnRpZXMgZGVmaW5lZCBpbiBtb2JpdmVpbC1wY2llLnR4dC4NCj4gPg0KPiA+ICtIT1NU
IE1PREUNCj4gPiArPT09PT09PT09DQo+ID4gIFJlcXVpcmVkIHByb3BlcnRpZXM6DQo+ID4gIC0g
Y29tcGF0aWJsZTogc2hvdWxkIGNvbnRhaW4gdGhlIHBsYXRmb3JtIGlkZW50aWZpZXIgc3VjaCBh
czoNCj4gPiAgICAiZnNsLGx4MjE2MGEtcGNpZSINCj4gPiBAQCAtMjMsNyArMjUsMjAgQEAgUmVx
dWlyZWQgcHJvcGVydGllczoNCj4gPiAgLSBtc2ktcGFyZW50IDogU2VlIHRoZSBnZW5lcmljIE1T
SSBiaW5kaW5nIGRlc2NyaWJlZCBpbg0KPiA+ICAgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9tc2kudHh0Lg0KPiA+DQo+ID4gLUV4YW1wbGU6
DQo+ID4gK0RFVklDRSBNT0RFDQo+ID4gKz09PT09PT09PQ0KPiA+ICtSZXF1aXJlZCBwcm9wZXJ0
aWVzOg0KPiA+ICstIGNvbXBhdGlibGU6IHNob3VsZCBjb250YWluIHRoZSBwbGF0Zm9ybSBpZGVu
dGlmaWVyIHN1Y2ggYXM6DQo+ID4gKyAgImZzbCxseDIxNjBhLXBjaWUtZXAiDQo+ID4gKy0gcmVn
OiBiYXNlIGFkZHJlc3NlcyBhbmQgbGVuZ3RocyBvZiB0aGUgUENJZSBjb250cm9sbGVyIHJlZ2lz
dGVyIGJsb2Nrcy4NCj4gPiArICAicmVncyI6IFBDSWUgY29udHJvbGxlciByZWdpc3RlcnMuDQo+
ID4gKyAgImFkZHJfc3BhY2UiIEVQIGRldmljZSBDUFUgYWRkcmVzcy4NCj4gPiArLSBhcGlvLXdp
bnM6IG51bWJlciBvZiByZXF1ZXN0ZWQgYXBpbyBvdXRib3VuZCB3aW5kb3dzLg0KPiA+ICsNCj4g
PiArT3B0aW9uYWwgUHJvcGVydHk6DQo+ID4gKy0gbWF4LWZ1bmN0aW9uczogTWF4aW11bSBudW1i
ZXIgb2YgZnVuY3Rpb25zIHRoYXQgY2FuIGJlIGNvbmZpZ3VyZWQNCj4gKGRlZmF1bHQgMSkuDQo+
ID4gKw0KPiA+ICtSQyBFeGFtcGxlOg0KPiA+DQo+ID4gIAlwY2llQDM0MDAwMDAgew0KPiA+ICAJ
CWNvbXBhdGlibGUgPSAiZnNsLGx4MjE2MGEtcGNpZSI7DQo+ID4gQEAgLTUwLDMgKzY1LDEzIEBA
IEV4YW1wbGU6DQo+ID4gIAkJCQk8MDAwMCAwIDAgMyAmZ2ljIDAgMCBHSUNfU1BJIDExMQ0KPiBJ
UlFfVFlQRV9MRVZFTF9ISUdIPiwNCj4gPiAgCQkJCTwwMDAwIDAgMCA0ICZnaWMgMCAwIEdJQ19T
UEkgMTEyDQo+IElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KPiA+ICAJfTsNCj4gPiArDQo+ID4gK0VQ
IEV4YW1wbGU6DQo+ID4gKw0KPiA+ICsJcGNpZV9lcEAzNDAwMDAwIHsNCj4gDQo+IFRvIHJlcGVh
dCBteSBwcmV2aW91cyBjb21tZW50Og0KDQpTb3JyeSwgSSBtaXNzZWQgdGhpcyBjb21tZW50Lg0K
DQpUaGFua3MNClhpYW93ZWkNCg0KPiANCj4gcGNpZS1lbmRwb2ludEAuLi4NCj4gDQo+ID4gKwkJ
Y29tcGF0aWJsZSA9ICJmc2wsbHgyMTYwYS1wY2llLWVwIjsNCj4gPiArCQlyZWcgPSA8MHgwMCAw
eDAzNDAwMDAwIDB4MCAweDAwMTAwMDAwDQo+ID4gKwkJICAgICAgIDB4ODAgMHgwMDAwMDAwMCAw
eDggMHgwMDAwMDAwMD47DQo+ID4gKwkJcmVnLW5hbWVzID0gInJlZ3MiLCAiYWRkcl9zcGFjZSI7
DQo+ID4gKwkJYXBpby13aW5zID0gPDg+Ow0KPiA+ICsJfTsNCj4gPiAtLQ0KPiA+IDIuOS41DQo+
ID4NCg==
