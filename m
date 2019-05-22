Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27EB1265BD
	for <lists+linux-pci@lfdr.de>; Wed, 22 May 2019 16:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbfEVOaf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 May 2019 10:30:35 -0400
Received: from mail-oln040092255016.outbound.protection.outlook.com ([40.92.255.16]:6036
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728744AbfEVOaf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 22 May 2019 10:30:35 -0400
Received: from HK2APC01FT049.eop-APC01.prod.protection.outlook.com
 (10.152.248.56) by HK2APC01HT057.eop-APC01.prod.protection.outlook.com
 (10.152.248.228) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1922.16; Wed, 22 May
 2019 14:30:31 +0000
Received: from PS2P216MB0642.KORP216.PROD.OUTLOOK.COM (10.152.248.53) by
 HK2APC01FT049.mail.protection.outlook.com (10.152.249.218) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1922.16 via Frontend Transport; Wed, 22 May 2019 14:30:31 +0000
Received: from PS2P216MB0642.KORP216.PROD.OUTLOOK.COM
 ([fe80::1c5e:7ea0:b90c:65c9]) by PS2P216MB0642.KORP216.PROD.OUTLOOK.COM
 ([fe80::1c5e:7ea0:b90c:65c9%10]) with mapi id 15.20.1922.016; Wed, 22 May
 2019 14:30:31 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH v6 0/4] PCI: Patch series to support Thunderbolt without any
 BIOS support
Thread-Topic: [PATCH v6 0/4] PCI: Patch series to support Thunderbolt without
 any BIOS support
Thread-Index: AQHVEKroekXmwO/8K0mZzVmJDM4t6Q==
Date:   Wed, 22 May 2019 14:30:30 +0000
Message-ID: <PS2P216MB0642AD5BCA377FDC5DCD8A7B80000@PS2P216MB0642.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SY2PR01CA0014.ausprd01.prod.outlook.com
 (2603:10c6:1:14::26) To PS2P216MB0642.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:1c::16)
x-incomingtopheadermarker: OriginalChecksum:C4307983063F48440F20EAA09C2EF6BFF2F6D6D33DB1DCB53E327E43DC49AA88;UpperCasedChecksum:30443D57D774F8953EE4467FAF466C77A8A1492E85ED2E4A4F3B362178614567;SizeAsReceived:7732;Count:48
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.19.1
x-tmn:  [dY+zV4YCQko/3G5AxX56s7fTJGFZS24eib++1MX+Lhl5DKbVIgYlZ93oMDKSpAK/ubNGCg3gN4E=]
x-microsoft-original-message-id: <20190522222928.2964-1-nicholas.johnson-opensource@outlook.com.au>
x-ms-publictraffictype: Email
x-incomingheadercount: 48
x-eopattributedmessage: 0
x-ms-exchange-slblob-mailprops: Zv/SX2iM+5Xt13fxl+LEE7dPPA5uzr/vHXTLIGhqyGuljXDuREJuqlOscJaqI7jWlFaf/BjaQbv9GeeNXYeO9fHtKya2HmU9lqQfPWO+briUupy2RJOdFSwWtW5ANehZQyritBxqLFg6FBRbg+6oohvdvVsDORip2zYSvdAcywth8y7iv1EYVvADfo95ze3g3GxyVNvEzckRschQozkxFIW1DReismJ3mjG/WR1Jqhbi8D5qT7K818/wuYw/W76ZlFWlkFTRo5l4LypSHRremV38/uUchBCqTlx/xNaB10yLBJx9uYc1n7nnjCk7FCZdDHsVbmtHsMnbfT4yTjnnJ231XdRzORrP2LT8FaxnZj8PVUkuBsxMlToZcrvLiuTMiEsL0EkKPrOmAbPJhk6RKpp6PCuMW2FtGc5I2Ww6pfQsAbKq+cB0Cf9l1PjgmUD74kgQLaC/ELcTiDbIJWyZkWuKarUmjzWr3FTBylqyBdBjWD6smCDMm33wQ5kD7W603Px9Hye/YJxnJBF2//xpOeEsGrAtgqXekmZyifivnwMaiQ1oUcLlVJNUllNTB9gQAOtxBuy8JjNIbZUDEl1ApStk6YeCXm8XrRSyy87UucBEKeFFBpLPW+I/ml0aodX7YlhAAoJuxmAjmo6/FtIJTfgkDTmMdmLZfLsP4tNbpYdgTLEmCayzKQegNSuKh8nxlmnQwlElSao=
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(201702181274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:HK2APC01HT057;
x-ms-traffictypediagnostic: HK2APC01HT057:
x-microsoft-antispam-message-info: FaAd5nriA33kNc+1q8SdiSoDnQMnh4I/76EjNXEaOYgW3gsp8jebUSOoTR1F546hg/GYUzAbwpAIXLGXij0PW80FsnIC6tb95pbch9FdDMtbJkXZjBph50AjHinvWJL9sErbXIwOwLoRUwWAttmdU62iMVA7Ds0nANFvXr0NK6Ng6bgTnDS7lqbGVR/OVxRI
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: e5be8faa-ccbf-434b-122a-08d6dec20a64
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2019 14:30:31.1646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT057
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

UmViYXNlIHBhdGNoZXMgdG8gYXBwbHkgY2xlYW5seSB0byA1LjItcmMxIHNvdXJjZS4gUmVtb3Zl
IHBhdGNoIGZvciANCmNvbW1lbnQgc3R5bGUgY2xlYW51cCBhcyB0aGlzIGhhcyBhbHJlYWR5IGJl
ZW4gYXBwbGllZC4NCg0KQW55Ym9keSBpbnRlcmVzdGVkIGluIHRlc3RpbmcsIHlvdSBjYW4gZG8g
c28gd2l0aDoNCg0KYSkgSW50ZWwgc3lzdGVtIHdpdGggVGh1bmRlcmJvbHQgMyBhbmQgbmF0aXZl
IGVudW1lcmF0aW9uLiBUaGUgR2lnYWJ5dGUgDQpaMzkwIERlc2lnbmFyZSBpcyBvbmUgb2YgdGhl
IG1vc3QgcGVyZmVjdCBmb3IgdGhpcyB0aGF0IEkgaGF2ZSBuZXZlciBoYWQgDQp0aGUgb3Bwb3J0
dW5pdHkgdG8gdXNlIC0gaXQgZG9lcyBub3QgZXZlbiBoYXZlIHRoZSBvcHRpb24gZm9yIEJJT1Mg
DQphc3Npc3RlZCBlbnVtZXJhdGlvbiBwcmVzZW50IGluIHRoZSBCSU9TLg0KDQpiKSBBbnkgc3lz
dGVtIHdpdGggUENJZSBhbmQgdGhlIEdpZ2FieXRlIEdDLVRJVEFOIFJJREdFIGFkZC1pbiBjYXJk
LCANCmp1bXAgdGhlIGhlYWRlciBhcyBkZXNjcmliZWQgYW5kIHVzZSBrZXJuZWwgcGFyYW1ldGVy
cyBsaWtlOg0KDQpwY2k9YXNzaWduLWJ1c3NlcyxocGJ1c3NpemU9MHgzMyxyZWFsbG9jLGhwbWVt
c2l6ZT0xMjhNLGhwbWVtcHJlZnNpemU9MUcsbm9jcnMgDQpwY2llX3BvcnRzPW5hdGl2ZQ0KDQpb
b3B0aW9uYWxdIHBjaS5keW5kYmcNCg0KICAgIF9fXw0KIF9fLyAgIFxfXw0KfG8gbyBvIG8gb3wg
V2hlbiBsb29raW5nIGludG8gdGhlIHJlY2VwdGFjbGUgb24gYmFjayBvZiBQQ0llIGNhcmQuDQp8
X19fX19fX19ffCBKdW1wIHBpbnMgMyBhbmQgNS4NCg0KIDEgMiAzIDQgNQ0KDQpUaGUgSW50ZWwg
c3lzdGVtIGlzIG5pY2UgaW4gdGhhdCBpdCBzaG91bGQganVzdCB3b3JrLiBUaGUgYWRkLWluIGNh
cmQgDQpzZXR1cCBpcyBuaWNlIGluIHRoYXQgeW91IGNhbiBnbyBudXRzIGFuZCBhc3NpZ24gY29w
aW91cyBhbW91bnRzIG9mIA0KTU1JT19QUkVGIC0gY2FuIGFueWJvZHkgc2hvdyBhIFhlb24gUGhp
IGNvcHJvY2Vzc29yIHdpdGggMTZHIEJBUiB3b3JraW5nIA0KaW4gYW4gZUdQVSBlbmNsb3N1cmUg
d2l0aCB0aGVzZSBwYXRjaGVzPw0KDQpIb3dldmVyLCBpZiB5b3Ugc3BlY2lmeSB0aGUgYWJvdmUg
a2VybmVsIHBhcmFtZXRlcnMgb24gdGhlIEludGVsIHN5c3RlbSwgDQp5b3Ugc2hvdWxkIGJlIGFi
bGUgdG8gb3ZlcnJpZGUgaXQgdG8gYWxsb2NhdGUgbW9yZSBzcGFjZS4NCg0KTmljaG9sYXMgSm9o
bnNvbiAoNCk6DQogIFBDSTogQ29uc2lkZXIgYWxpZ25tZW50IG9mIGhvdC1hZGRlZCBicmlkZ2Vz
IHdoZW4gZGlzdHJpYnV0aW5nDQogICAgYXZhaWxhYmxlIHJlc291cmNlcw0KICBQQ0k6IE1vZGlm
eSBleHRlbmRfYnJpZGdlX3dpbmRvdygpIHRvIHNldCByZXNvdXJjZSBzaXplIGRpcmVjdGx5DQog
IFBDSTogRml4IGJ1ZyByZXN1bHRpbmcgaW4gZG91YmxlIGhwbWVtc2l6ZSBiZWluZyBhc3NpZ25l
ZCB0byBNTUlPDQogICAgd2luZG93DQogIFBDSTogQWRkIHBjaT1ocG1lbXByZWZzaXplIHBhcmFt
ZXRlciB0byBzZXQgTU1JT19QUkVGIHNpemUNCiAgICBpbmRlcGVuZGVudGx5DQoNCiAuLi4vYWRt
aW4tZ3VpZGUva2VybmVsLXBhcmFtZXRlcnMudHh0ICAgICAgICAgfCAgIDcgKy0NCiBkcml2ZXJz
L3BjaS9wY2kuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMTggKy0NCiBkcml2ZXJz
L3BjaS9zZXR1cC1idXMuYyAgICAgICAgICAgICAgICAgICAgICAgfCAyNjUgKysrKysrKysrKy0t
LS0tLS0tDQogaW5jbHVkZS9saW51eC9wY2kuaCAgICAgICAgICAgICAgICAgICAgICAgICAgIHwg
ICAzICstDQogNCBmaWxlcyBjaGFuZ2VkLCAxNjcgaW5zZXJ0aW9ucygrKSwgMTI2IGRlbGV0aW9u
cygtKQ0KDQotLSANCjIuMjAuMQ0KDQo=
