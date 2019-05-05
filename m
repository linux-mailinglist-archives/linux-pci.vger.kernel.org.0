Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5EE1404B
	for <lists+linux-pci@lfdr.de>; Sun,  5 May 2019 16:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbfEEOk0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 5 May 2019 10:40:26 -0400
Received: from mail-oln040092254013.outbound.protection.outlook.com ([40.92.254.13]:40134
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727325AbfEEOkZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 5 May 2019 10:40:25 -0400
Received: from HK2APC01FT045.eop-APC01.prod.protection.outlook.com
 (10.152.248.58) by HK2APC01HT130.eop-APC01.prod.protection.outlook.com
 (10.152.249.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1856.11; Sun, 5 May
 2019 14:40:20 +0000
Received: from PS2P216MB0642.KORP216.PROD.OUTLOOK.COM (10.152.248.52) by
 HK2APC01FT045.mail.protection.outlook.com (10.152.249.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1856.11 via Frontend Transport; Sun, 5 May 2019 14:40:20 +0000
Received: from PS2P216MB0642.KORP216.PROD.OUTLOOK.COM
 ([fe80::adb3:4c16:60fd:65]) by PS2P216MB0642.KORP216.PROD.OUTLOOK.COM
 ([fe80::adb3:4c16:60fd:65%5]) with mapi id 15.20.1856.012; Sun, 5 May 2019
 14:40:20 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH v5 0/5] PCI: Patch series to support Thunderbolt without any
 BIOS support
Thread-Topic: [PATCH v5 0/5] PCI: Patch series to support Thunderbolt without
 any BIOS support
Thread-Index: AQHVA1B2x9+Qf8tFcUa6+4S7i1Etzg==
Date:   Sun, 5 May 2019 14:40:20 +0000
Message-ID: <PS2P216MB064229018EE9B0CE03EE274380370@PS2P216MB0642.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR03CA0126.apcprd03.prod.outlook.com
 (2603:1096:4:91::30) To PS2P216MB0642.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:1c::16)
x-incomingtopheadermarker: OriginalChecksum:93A2AD3AFD822AE143018C5DE2A7E67B49B4B1EE8945A66EAEEC57276E888982;UpperCasedChecksum:D084C361B9062949C807461D125AEB82921BD047053FEE6C1C4EE3C6110C98CC;SizeAsReceived:7725;Count:48
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.19.1
x-tmn:  [l1jGULHtxO4Tp3Ipu+BTRrELNuctMIeKjEMWXGUC3QgZxTM7ScJe3VVV4kYeya5gJ5FHRk1OUXw=]
x-microsoft-original-message-id: <20190505144001.8106-1-nicholas.johnson-opensource@outlook.com.au>
x-ms-publictraffictype: Email
x-incomingheadercount: 48
x-eopattributedmessage: 0
x-ms-exchange-slblob-mailprops: mBy7Mai7yE4yhl4FRICA9NYl3Rc5hrDwq7CndrygLMMq+8EtKWXX220Qd50u351Iq9Ln4S6Bzce6EwdGKFXxORFXY89UtCym13zeHs975RgIUWeaQKcKAHNKeYBNSXBS2HV0Wu7wL9LGxDIKGymu6QXK0b99P17vpU3C7XbmahVByX2tXMevvjiExs7o10CoDS8xpf+0pWY6r/TbPfg5zGjP9fiWD/QwxaSqkWx0BszIibM/HsfqF1H0whUa4zcPwgjN1LI/g0dAsT61P7O+iUY/Z7ia2SeWAH943vjWmK+lBY0Dc4Cm5XV4IZm/rPuQCEr2brQoBM/lHHcfE6jjlnzpejVWr3jG2oqG0Pnbklc7iaEXGrpSvVZxx61eLg9AlWOMu2ogQK1etu6VuTRRmBb/G0QaMm0QYJLp1Be9EFwvcLcYDGJG7zTHzRrPoam/hy0qRUUuuQ6cpIrc4MEb4y/8ih855mycZthtSaL3KQCFDfvrAOK2V1s7IWFKanodXHICh7PMxgnbT3dPPnqp4yEMKxqrNiS8wqVv3gU3+VXBzwBFvjqdDBerBtCKeTLeCFhJA89+EFc290PONXb0zQ0VHwyZZOSns1OoxL/MPXg++R9M4iLoHTSq3kf/zu6fTYedPSdWwOuOi8K+KHEqTh5bSOBry9Y4Flesl2vrqOGhd6zoEyN400yXbfEaG8OizfS5MKAjQI0n4ylWBJx1obPcC8mZyhgp
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(201702181274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:HK2APC01HT130;
x-ms-traffictypediagnostic: HK2APC01HT130:
x-microsoft-antispam-message-info: Bkb9yhY9HIyKHrLKSps+IHiEWxMNgQtNV6rLYKc10Se/b3Bli45xvjTmU+RNMUcLkb+m9zJVGLH2YNsHIi5p/T2MwMJZT7xwwBbBLpXcn2MhEwWoM6ycQt3dgZbZZRCgVmBglpAXfqaMelWuvvrjkxaLOeaSHMrk2tF2nPrIkv8gnNvc2ZVAChgPleMW5RHY
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: afec406c-ea1f-4544-eaf5-08d6d16798e6
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2019 14:40:20.3566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT130
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

U2luY2UgUEFUQ0ggdjQ6DQoNCkkgaGF2ZSBhZGRlZCBzb21lIG9mIHRoZSBldmlkZW5jZSBhbmQg
YnVnIHJlcG9ydHMgaW50byB0aGUgYXBwbGljYWJsZQ0KcGF0Y2hlcy4NCg0KVXNlcnMgb2YgcGNp
PWhwbWVtc2l6ZSBzaG91bGQgbm90IG5vdGljZSBhbnkgY2hhbmdlcyBpbiBmdW5jdGlvbmFsaXR5
DQp3aXRoIHRoaXMgcGF0Y2ggc2VyaWVzIHdoZW4gdXBncmFkaW5nIHRoZSBrZXJuZWwuIEkgcmVh
bGlzZWQgSSBjb3VsZA0KbWFrZSB0aGUgdmFyaWFibGUgdG8gYWNoaWV2ZSB0aGlzIHJlc2lkZSBp
biBwY2lfc2V0dXAsIHJhdGhlciB0aGFuDQpnbG9iYWxseS4NCg0KUGxlYXNlIGxldCBtZSBrbm93
IGlmIGFueXRoaW5nIGVsc2UgbmVlZHMgY2hhbmdpbmcuDQoNCk5pY2hvbGFzIEpvaG5zb24gKDUp
Og0KICBQQ0k6IENvbnNpZGVyIGFsaWdubWVudCBvZiBob3QtYWRkZWQgYnJpZGdlcyB3aGVuIGRp
c3RyaWJ1dGluZw0KICAgIHJlc291cmNlcw0KICBQQ0k6IE1vZGlmeSBleHRlbmRfYnJpZGdlX3dp
bmRvdygpIHRvIHNldCByZXNvdXJjZSBzaXplIGRpcmVjdGx5DQogIFBDSTogRml4IGJ1ZyByZXN1
bHRpbmcgaW4gZG91YmxlIGhwbWVtc2l6ZSBiZWluZyBhc3NpZ25lZCB0byBNTUlPDQogICAgd2lu
ZG93DQogIFBDSTogQWRkIHBjaT1ocG1lbXByZWZzaXplIHBhcmFtZXRlciB0byBzZXQgTU1JT19Q
UkVGIHNpemUNCiAgICBpbmRlcGVuZGVudGx5DQogIFBDSTogQ2xlYW51cCBibG9jayBjb21tZW50
cyBpbiBzZXR1cC1idXMuYyB0byBtYXRjaCBrZXJuZWwgc3R5bGUNCg0KIC4uLi9hZG1pbi1ndWlk
ZS9rZXJuZWwtcGFyYW1ldGVycy50eHQgICAgICAgICB8ICAgNyArLQ0KIGRyaXZlcnMvcGNpL3Bj
aS5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAxOCArLQ0KIGRyaXZlcnMvcGNpL3Nl
dHVwLWJ1cy5jICAgICAgICAgICAgICAgICAgICAgICB8IDU2OCArKysrKysrKystLS0tLS0tLS0N
CiBpbmNsdWRlL2xpbnV4L3BjaS5oICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDMgKy0N
CiA0IGZpbGVzIGNoYW5nZWQsIDMxNyBpbnNlcnRpb25zKCspLCAyNzkgZGVsZXRpb25zKC0pDQoN
Ci0tIA0KMi4xOS4xDQoNCg==
