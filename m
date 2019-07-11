Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8360E65AA5
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2019 17:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbfGKPoK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Jul 2019 11:44:10 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:24466 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728068AbfGKPoK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Jul 2019 11:44:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1562859849; x=1594395849;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cXsWhyai1acE7HFTmBeuqY4fcd00qt25CKfGa+mnBNA=;
  b=cNr7b8ciPvoaV+ietisXq/h4+UfDg80TYUqDUSmS1yHEpVwGSyijfb4n
   qJHM4lJghzbImJ5pI17kZmoIBQZq90mcZ9H1tX3CxhgZyktuL9Mdv6sBE
   PymOzCHDZQ2Rn3qJ2ce+bx2bBfLcEAsfRUBrjvZGFTcDAHADWOJlhsb38
   Y=;
X-IronPort-AV: E=Sophos;i="5.62,479,1554768000"; 
   d="scan'208";a="815651803"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1d-37fd6b3d.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 11 Jul 2019 15:44:06 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-37fd6b3d.us-east-1.amazon.com (Postfix) with ESMTPS id BED6F281F5D;
        Thu, 11 Jul 2019 15:44:03 +0000 (UTC)
Received: from EX13D02UWB001.ant.amazon.com (10.43.161.240) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 11 Jul 2019 15:44:03 +0000
Received: from EX13D13UWA001.ant.amazon.com (10.43.160.136) by
 EX13D02UWB001.ant.amazon.com (10.43.161.240) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 11 Jul 2019 15:44:02 +0000
Received: from EX13D13UWA001.ant.amazon.com ([10.43.160.136]) by
 EX13D13UWA001.ant.amazon.com ([10.43.160.136]) with mapi id 15.00.1367.000;
 Thu, 11 Jul 2019 15:44:02 +0000
From:   "Chocron, Jonathan" <jonnyc@amazon.com>
To:     "Shenhar, Talel" <talel@amazon.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "Hanoch, Uri" <hanochu@amazon.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "Wasserstrom, Barak" <barakw@amazon.com>,
        "Saidi, Ali" <alisaidi@amazon.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "Hawa, Hanna" <hhhawa@amazon.com>,
        "Krupnik, Ronen" <ronenk@amazon.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>
Subject: Re: [PATCH 5/8] dt-bindings: PCI: Add Amazon's Annapurna Labs PCIe
 host bridge binding
Thread-Topic: [PATCH 5/8] dt-bindings: PCI: Add Amazon's Annapurna Labs PCIe
 host bridge binding
Thread-Index: AQHVNz7sM84qVxUGzEGLjbSa8Pyh36bFAYmAgAAm/wCAAGfkAA==
Date:   Thu, 11 Jul 2019 15:44:02 +0000
Message-ID: <44bf0c96505bb3620bec10d378eac3f6d60ceb4f.camel@amazon.com>
References: <20190710164519.17883-1-jonnyc@amazon.com>
         <20190710164519.17883-6-jonnyc@amazon.com>
         <36e8c3b0-feeb-db8f-3808-0218b54adcec@amazon.com>
         <20190711093210.GA26088@e121166-lin.cambridge.arm.com>
In-Reply-To: <20190711093210.GA26088@e121166-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.160.245]
Content-Type: text/plain; charset="utf-8"
Content-ID: <712B7F4B1C184E4E9F1C6E079F224C5B@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVGh1LCAyMDE5LTA3LTExIGF0IDEwOjMyICswMTAwLCBMb3JlbnpvIFBpZXJhbGlzaSB3cm90
ZToNCj4gT24gVGh1LCBKdWwgMTEsIDIwMTkgYXQgMTA6MTI6MzVBTSArMDMwMCwgU2hlbmhhciwg
VGFsZWwgd3JvdGU6DQo+ID4gDQo+ID4gT24gNy8xMC8yMDE5IDc6NDUgUE0sIEpvbmF0aGFuIENo
b2Nyb24gd3JvdGU6DQo+ID4gPiBEb2N1bWVudCBBbWF6b24ncyBBbm5hcHVybmEgTGFicyBQQ0ll
IGhvc3QgYnJpZGdlLg0KPiA+IA0KPiA+IFRoYXQgaXMgdGhlIHdheSEgKGJlc3QgdG8ga2VlcCBz
YW1lIHdvcmRpbmdzIChBbWF6b24ncykNCj4gDQo+IEd1eXMsDQo+IA0KPiBhcyBhIGhlYWRzLXVw
LCB0aGUgb3JpZ2luYWwgcG9zdGluZywgZm9yIHdoYXRldmVyIHJlYXNvbiwgZGlkIG5vdCBoaXQN
Cj4gbGludXgtcGNpQHZnZXIsIHdoaWNoIG1lYW5zIHRoYXQgZnJvbSBhIFBDSSBwYXRjaGVzIHF1
ZXVlIHJldmlldw0KPiBwb2ludA0KPiBvZiB2aWV3IGl0IGRvZXMgbm90IGV4aXN0Lg0KPiANCj4g
SXQgb3VnaHQgdG8gYmUgZml4ZWQgb3RoZXJ3aXNlIHdlIHdvbid0IGJlIGFibGUgdG8gcmV2aWV3
IHRoZSBjb2RlLg0KPiANCj4gTG9yZW56bw0KPiANCg0KSSd2ZSBzdWNjZWVkZWQgdG8gcmVkaXJl
Y3QgdGhlIG9yaWdpbmFsIGVtYWlscyB0byBsaW51eC1wY2lAdmdlciwgc28NCnBsZWFzZSBwcm9j
ZWVkIHdpdGggcmV2aWV3aW5nIHRoZSBwYXRjaGVzLg0KDQpUaGFua3MsDQogICBKb25hdGhhbg0K
