Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC01D302D1C
	for <lists+linux-pci@lfdr.de>; Mon, 25 Jan 2021 22:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732060AbhAYU7N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Jan 2021 15:59:13 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:46712 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732425AbhAYU6e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Jan 2021 15:58:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1611608315; x=1643144315;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=StUkdEEE0J310rS81PX8zY+TsfyCJ9STur4fZ0/lAok=;
  b=r3jXb2z/jMMJh62qaUrlGWbQnRJ/of1gF7QIAiS+EFD1/X37wTraGPmi
   Z7LvzfNftKyY+dM1LgsTmqMjtqsWnxrMi46Z4oKwGFtUKv/SJhIGBPtub
   fpwU3OpTEBk2JR9ZFnrJ6FZ4QkVqb782Oe4QqfQ+0CMw06Og49Hm3OLjY
   Y=;
X-IronPort-AV: E=Sophos;i="5.79,374,1602547200"; 
   d="scan'208";a="114678178"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-c7f73527.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 25 Jan 2021 20:57:47 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1e-c7f73527.us-east-1.amazon.com (Postfix) with ESMTPS id C055AA5892;
        Mon, 25 Jan 2021 20:57:43 +0000 (UTC)
Received: from EX13D13UWA004.ant.amazon.com (10.43.160.251) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 25 Jan 2021 20:57:42 +0000
Received: from EX13D13UWA001.ant.amazon.com (10.43.160.136) by
 EX13D13UWA004.ant.amazon.com (10.43.160.251) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 25 Jan 2021 20:57:42 +0000
Received: from EX13D13UWA001.ant.amazon.com ([10.43.160.136]) by
 EX13D13UWA001.ant.amazon.com ([10.43.160.136]) with mapi id 15.00.1497.010;
 Mon, 25 Jan 2021 20:57:42 +0000
From:   "Chocron, Jonathan" <jonnyc@amazon.com>
To:     "robh@kernel.org" <robh@kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "Jisheng.Zhang@synaptics.com" <Jisheng.Zhang@synaptics.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH dwc-next v2 2/2] PCI: dwc: al: Remove useless dw_pcie_ops
Thread-Topic: [PATCH dwc-next v2 2/2] PCI: dwc: al: Remove useless dw_pcie_ops
Thread-Index: AQHW81y5+LQF22LzXkarAWfdj0BAjw==
Date:   Mon, 25 Jan 2021 20:57:42 +0000
Message-ID: <d9df69aa9373451f6ccb8884f72eda2623343168.camel@amazon.com>
References: <20201120191611.7b84a86b@xhacker.debian>
         <20201120191720.5a2320cf@xhacker.debian>
In-Reply-To: <20201120191720.5a2320cf@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.161.253]
Content-Type: text/plain; charset="utf-8"
Content-ID: <2E693A6BA779C14B96DA1B346D00CFF4@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gRnJpLCAyMDIwLTExLTIwIGF0IDE5OjE3ICswODAwLCBKaXNoZW5nIFpoYW5nIHdyb3RlOg0K
PiBDQVVUSU9OOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9mIHRoZSBvcmdh
bml6YXRpb24uIERvDQo+IG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVz
cyB5b3UgY2FuIGNvbmZpcm0gdGhlIHNlbmRlcg0KPiBhbmQga25vdyB0aGUgY29udGVudCBpcyBz
YWZlLg0KPiANCj4gDQo+IA0KPiBXZSBoYXZlIHJlbW92ZWQgdGhlIGR3X3BjaWVfb3BzIGFsd2F5
cyBleGlzdHMgYXNzdW1wdGlvbiBpbiBkd2MNCj4gY29yZSBkcml2ZXIsIHdlIGNhbiByZW1vdmUg
dGhlIHVzZWxlc3MgZHdfcGNpZV9vcHMgbm93Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSmlzaGVu
ZyBaaGFuZyA8SmlzaGVuZy5aaGFuZ0BzeW5hcHRpY3MuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtYWwuYyB8IDQgLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQs
IDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxl
ci9kd2MvcGNpZS1hbC5jDQo+IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1hbC5j
DQo+IGluZGV4IDdhYzhhMzdkOWNlMC4uMzY5NzdjNDhhN2FlIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWFsLmMNCj4gKysrIGIvZHJpdmVycy9wY2kvY29u
dHJvbGxlci9kd2MvcGNpZS1hbC5jDQo+IEBAIC0zMjIsOSArMzIyLDYgQEAgc3RhdGljIGNvbnN0
IHN0cnVjdCBkd19wY2llX2hvc3Rfb3BzDQo+IGFsX3BjaWVfaG9zdF9vcHMgPSB7DQo+ICAgICAg
ICAgLmhvc3RfaW5pdCA9IGFsX3BjaWVfaG9zdF9pbml0LA0KPiAgfTsNCj4gDQo+IC1zdGF0aWMg
Y29uc3Qgc3RydWN0IGR3X3BjaWVfb3BzIGR3X3BjaWVfb3BzID0gew0KPiAtfTsNCj4gLQ0KPiAg
c3RhdGljIGludCBhbF9wY2llX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+
ICB7DQo+ICAgICAgICAgc3RydWN0IGRldmljZSAqZGV2ID0gJnBkZXYtPmRldjsNCj4gQEAgLTM0
Miw3ICszMzksNiBAQCBzdGF0aWMgaW50IGFsX3BjaWVfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rl
dmljZQ0KPiAqcGRldikNCj4gICAgICAgICAgICAgICAgIHJldHVybiAtRU5PTUVNOw0KPiANCj4g
ICAgICAgICBwY2ktPmRldiA9IGRldjsNCj4gLSAgICAgICBwY2ktPm9wcyA9ICZkd19wY2llX29w
czsNCj4gICAgICAgICBwY2ktPnBwLm9wcyA9ICZhbF9wY2llX2hvc3Rfb3BzOw0KPiANCj4gICAg
ICAgICBhbF9wY2llLT5wY2kgPSBwY2k7DQo+IC0tDQo+IDIuMjkuMg0KPiANCg0KQWNrZWQtYnk6
IEpvbmF0aGFuIENob2Nyb24gPGpvbm55Y0BhbWF6b24uY29tPg0KDQoNClRoYW5rcywNCiAgIEpv
bmF0aGFuDQo=
