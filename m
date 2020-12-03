Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 150442CCD72
	for <lists+linux-pci@lfdr.de>; Thu,  3 Dec 2020 04:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgLCDtS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Dec 2020 22:49:18 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:51275 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726734AbgLCDtS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Dec 2020 22:49:18 -0500
X-UUID: abc59549ce8f44e1a23c93508b954a8a-20201203
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=egwE3BGfFnVU42RB8G4cDpSLIosNS6Hpw+CGdp7GE4A=;
        b=JoFETGIITk3xxYGUSEELhsvLMpKEcfAQthxQIoAIJnguHQxvN3ThP/MFYtoRK3wDD4S9zuoyg6Sc+6HOA2XX0OOVF6P6+St0sx2GQxEb772Izjv9qvkD92s8OSKfnEWyh75sQC4/q6u+vrExbe78fKsk7stV56Kt6sDjDiIKQBM=;
X-UUID: abc59549ce8f44e1a23c93508b954a8a-20201203
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 742371175; Thu, 03 Dec 2020 11:48:25 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 3 Dec
 2020 11:48:18 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 3 Dec 2020 11:48:18 +0800
Message-ID: <1606967298.14736.67.camel@mhfsdcap03>
Subject: Re: [v1] PCI: Export pci_pio_to_address() for module use
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <youlin.pei@mediatek.com>,
        Sj Huang <sj.huang@mediatek.com>
Date:   Thu, 3 Dec 2020 11:48:18 +0800
In-Reply-To: <20201202134903.GA1419281@bjorn-Precision-5520>
References: <20201202134903.GA1419281@bjorn-Precision-5520>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: B083340B9C9A9BFA0D69806F47BFEE28F5C6E5BE94BE9DD35B07D24188C0507B2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gV2VkLCAyMDIwLTEyLTAyIGF0IDA3OjQ5IC0wNjAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0K
PiBPbiBXZWQsIERlYyAwMiwgMjAyMCBhdCAwOToxMjo1NVBNICswODAwLCBKaWFuanVuIFdhbmcg
d3JvdGU6DQo+ID4gVGhpcyBpbnRlcmZhY2Ugd2lsbCBiZSB1c2VkIGJ5IFBDSSBob3N0IGRyaXZl
cnMgZm9yIFBJTyB0cmFuc2xhdGlvbiwNCj4gPiBleHBvcnQgaXQgdG8gc3VwcG9ydCBjb21waWxp
bmcgdGhvc2UgZHJpdmVycyBhcyBrZXJuZWwgbW9kdWxlcy4NCj4gPiANCj4gPiBTaWduZWQtb2Zm
LWJ5OiBKaWFuanVuIFdhbmcgPGppYW5qdW4ud2FuZ0BtZWRpYXRlay5jb20+DQo+IA0KPiBQbGVh
c2UgaW5jbHVkZSB0aGlzIGluIGEgc2VyaWVzIHRoYXQgYWRkcyBhIG1vZHVsYXIgaG9zdCBkcml2
ZXIgb3INCj4gY29udmVydHMgYW4gZXhpc3Rpbmcgb25lIHRvIGJlIG1vZHVsYXIuICBUaGF0IHdh
eSB3ZSBrbm93IHdlIGhhdmUgYXQNCj4gbGVhc3Qgb25lIHVzZXIgYW5kIHRoaW5ncyBnZXQgbWVy
Z2VkIGluIHRoZSByaWdodCBvcmRlci4NCg0KSGkgQmpvcm4sDQoNCk9LLCBJIHdpbGwgaW5jbHVk
ZSB0aGlzIHBhdGNoIGluIHRoZSBuZXh0IHZlcnNpb24gb2YgcGNpZS1tZWRpYXRlay1nZW4zDQpz
ZXJpZXMuDQoNCnRoYW5rcy4NCj4gDQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvcGNpL3BjaS5jIHwg
MSArDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiA+IA0KPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3BjaS9wY2kuYyBiL2RyaXZlcnMvcGNpL3BjaS5jDQo+ID4gaW5kZXgg
YTQ1OGM0NmQ3ZTM5Li41MDkwMDg4OTkxODIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kv
cGNpLmMNCj4gPiArKysgYi9kcml2ZXJzL3BjaS9wY2kuYw0KPiA+IEBAIC00MDAzLDYgKzQwMDMs
NyBAQCBwaHlzX2FkZHJfdCBwY2lfcGlvX3RvX2FkZHJlc3ModW5zaWduZWQgbG9uZyBwaW8pDQo+
ID4gIA0KPiA+ICAJcmV0dXJuIGFkZHJlc3M7DQo+ID4gIH0NCj4gPiArRVhQT1JUX1NZTUJPTChw
Y2lfcGlvX3RvX2FkZHJlc3MpOw0KPiA+ICANCj4gPiAgdW5zaWduZWQgbG9uZyBfX3dlYWsgcGNp
X2FkZHJlc3NfdG9fcGlvKHBoeXNfYWRkcl90IGFkZHJlc3MpDQo+ID4gIHsNCj4gPiAtLSANCj4g
PiAyLjI1LjENCj4gPiANCg0K

