Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4C72F6128
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jan 2021 13:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbhANMlu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jan 2021 07:41:50 -0500
Received: from mail-oln040092067050.outbound.protection.outlook.com ([40.92.67.50]:2529
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726376AbhANMlt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 Jan 2021 07:41:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mgxym60UtiiIc1lX2SNO59Qu+FkTXkFkRFiwl2VvLrnS6I5rcM7vdBXj80Ctnij+BkVLTKFx+K23erKQyzgnL0ZnbTEuFK5Qy96vtW0uNMJhKIaH6DUWdt9xhuynfO4Km6bsHEVl3B6/MfIIO4W14GeVKejEPi2yuNlccTQTmh9HeJDojykiOg42CcKBs3rt//wSL09feYIG0CWEXpXaTZzeYTIyjMrBeO7gAeVyaUovqxMJF6QNVfF+42OlLDnQPj/PpYRmDNDU50dIgxQVYhfNbFS2DUzMnaClk27h5bm8nQChAZCtYlRB5HKtQJavHnxIivQHeQSK72Tl1Kh5HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U0tDmiZQ3s4isfSpHI+JcMMk+gfNL/rvbe6w2vJL2kI=;
 b=QzWvs8tBs66FpP26Q+ESMWK62ylXV56cCfpMn2vtPdLV2TShKDAULCd/qY9cYXeNBWE2LGgar3yoWQqEvc9FFyOtQlJAOU67jxiMlPCQGron37v6lSKDXGzvhT+EAqdBS5NvZqxzYpeqrkpABW8rurzTo1iB1SZmAglvw85CKJ9cyQP6/V/tlKbxdwwxNkHBEM2Hdhro9rW/Ciij34ZjaO2ShTDDbDqzD3/TE0MKM49hfzt6ottuySl6fmJB/cc03goXIXWI3zbxf8qHECXOUPUVYY1O8jfVL3QmMhueFavW1y6xfPgc2E39W3rpnzLe/2jMVD4YLrmFLMIAAm1nJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from HE1EUR02FT029.eop-EUR02.prod.protection.outlook.com
 (2a01:111:e400:7e1d::42) by
 HE1EUR02HT155.eop-EUR02.prod.protection.outlook.com (2a01:111:e400:7e1d::321)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Thu, 14 Jan
 2021 12:41:01 +0000
Received: from PA4P190MB1375.EURP190.PROD.OUTLOOK.COM (2a01:111:e400:7e1d::41)
 by HE1EUR02FT029.mail.protection.outlook.com (2a01:111:e400:7e1d::147) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend
 Transport; Thu, 14 Jan 2021 12:41:01 +0000
Received: from PA4P190MB1375.EURP190.PROD.OUTLOOK.COM
 ([fe80::6d7c:5d4b:3397:9328]) by PA4P190MB1375.EURP190.PROD.OUTLOOK.COM
 ([fe80::6d7c:5d4b:3397:9328%7]) with mapi id 15.20.3742.012; Thu, 14 Jan 2021
 12:41:01 +0000
From:   Tomek LECOCQ <tomek.lecocq@hotmail.fr>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: How to reverse engineer a PCI-Express driver under Linux ?
Thread-Topic: How to reverse engineer a PCI-Express driver under Linux ?
Thread-Index: AQHW6nKDdB0L3XAHNUCE0Mko98j1+A==
Date:   Thu, 14 Jan 2021 12:41:01 +0000
Message-ID: <54A07AB3-806B-4010-99FA-688676497DF3@hotmail.fr>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: OriginalChecksum:C7E59DFD751EAF18025820794E87D6AEF5D610B76F1492E40561435301A80452;UpperCasedChecksum:9DCE1C1C0545F7742F8DBF4AEB92D6E5FFDA63F1DB2B32783D88CC60186AA1F8;SizeAsReceived:6806;Count:42
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [Fvuyi8VJ6LXW74wgEf3ToJAeUPq6aS66HwDE2Oxq2UQJ0HjfbGjKXzT7nm3T+2Tj]
x-ms-publictraffictype: Email
x-incomingheadercount: 42
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 4d46eefb-f7d3-4eb9-d4df-08d8b889a66c
x-ms-traffictypediagnostic: HE1EUR02HT155:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mwwlctb4IFzNGP3G5WrIz5sGg7QKEH0HdmVGT6DKS+RqWbX7aPNZLnVDG3TdRQ2LDTplrZpnd0uJilD6dsA6pdqvC4p6xF45dJwa19z8AwaLkErBoCO1L7FWYwMlfhxmApZR7pJK9wgZaLRBGX4Dt/WgInz7Ona5wBwiIXkQyMUoNnX9iuqjF8hSRtohrc7Ay2M4mCiNqi6KWeKPF1wiuB7dyR0WqyCupkG34uFdIQ6RXR7lRSEy8eRWpauVIKep
x-ms-exchange-antispam-messagedata: HgMCzQle7E3hz0wfPZ9cqT2+lZukzs/UtKbvNGRnW2mKFG3Ds6gAP2fPn3FLILcJLRQtgkZiQDF3QH9Mn1QlkBgwged5KoEF+3m+deNzH1vUJK5ksKGt2eoy42P0qRZgA1efyviXhPZ+6WkZemOJuzmI8+ywmaXUiADrNoOV78tDVkAvdMHUThRyKtr+Rybw/Sn+8TAbF1ea7qpfCa93qA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B0DBB66534A87D4988989562115E3EDF@EURP190.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT029.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d46eefb-f7d3-4eb9-d4df-08d8b889a66c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2021 12:41:01.4159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1EUR02HT155
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGVsbG8sDQoNCkkgaGF2ZSBhIFBDSS1FIHZpZGVvIGNhcHR1cmUgY2FyZCB0aGF0IGhhcyBhIHBy
b3ByaWV0YXJ5IGRyaXZlciBmb3IgTGludXguDQpJIGhhdmUgc29tZSBleHBlcmllbmNlIHdpdGgg
cHJvZ3JhbW1pbmcgaW4gQywgYW5kIHNvIEkgd291bGQgbGlrZSB0byBzdGFydCBhIGhvYmJ5IHBy
b2plY3QgdG8gZGV2ZWxvcCBhIGZyZWUvbGlicmUgZHJpdmVyIGZvciB0aGlzIGRldmljZSBmb3Ig
TGludXguDQpPZiBjb3Vyc2UgSSBkb27igJl0IGhhdmUgYWNjZXNzIHRvIGFueSBkb2N1bWVudGF0
aW9uIGFib3V0IGhvdyB0byBjb21tdW5pY2F0ZSB3aXRoIHRoaXMgZGV2aWNlLCBzbyBJIHRoaW5r
IEkgd2lsbCBuZWVkIHRvIHJldmVyc2UtZW5naW5lZXIgdGhlIHdheSB0aGUgZXhpc3RpbmcgZHJp
dmVyIGNvbW11bmljYXRlcyB3aXRoIHRoZSBoYXJkd2FyZS4gSG93IGNvdWxkIEkgYWNoaWV2ZSB0
aGlzID8NCkFsc28sIHRoZSBsb25nIHRlcm0gZ29hbCBvZiB0aGlzIHByb2plY3Qgd291bGQgYmUg
dG8gaGF2ZSB0aGlzIGRyaXZlciBtZXJnZWQgaW50byBtYWlubGluZSwgc28gd2hhdCBpcyBhbGxv
d2VkIG9yIG5vdCB3aGlsZSBkb2luZyB0aGlzIHRvIGF2b2lkIHByb2JsZW1hdGljIGxlZ2FsIHJh
bWlmaWNhdGlvbnMgPw0KVGhhbmsgeW91IGZvciB5b3VyIGhlbHAuDQoNCkJlc3QgcmVnYXJkcy4N
ClRvbWVrIExlY29jcQ==
