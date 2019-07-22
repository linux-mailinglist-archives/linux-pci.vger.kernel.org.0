Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCF50703F5
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2019 17:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbfGVPiw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Jul 2019 11:38:52 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:28619 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727364AbfGVPiw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Jul 2019 11:38:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1563809931; x=1595345931;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=p+BFPwGgmyuthzqKYX1LJhl13bUmA6xYC+bpOYReBp0=;
  b=S6d3yn/mFul4AJMAyI0sojVQWI6OLaGv8u7VO0KVDemA3UW31QqMb6xA
   jo3sXSoLoAN3lq2nvDhxILktjBjmuazrOlMQ/ZNCSt1yo/WReRzB+bLse
   n18FuPCCKRgRxTVP1/t9BETwLE4OncAZb9wy786VBDm/YHVg/YVdqgdG1
   Y=;
X-IronPort-AV: E=Sophos;i="5.64,295,1559520000"; 
   d="scan'208";a="686990785"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2c-397e131e.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 22 Jul 2019 15:38:48 +0000
Received: from EX13MTAUWA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-397e131e.us-west-2.amazon.com (Postfix) with ESMTPS id 0B3F1A06CE;
        Mon, 22 Jul 2019 15:38:47 +0000 (UTC)
Received: from EX13D13UWA001.ant.amazon.com (10.43.160.136) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 22 Jul 2019 15:38:47 +0000
Received: from EX13D13UWA001.ant.amazon.com (10.43.160.136) by
 EX13D13UWA001.ant.amazon.com (10.43.160.136) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 22 Jul 2019 15:38:47 +0000
Received: from EX13D13UWA001.ant.amazon.com ([10.43.160.136]) by
 EX13D13UWA001.ant.amazon.com ([10.43.160.136]) with mapi id 15.00.1367.000;
 Mon, 22 Jul 2019 15:38:46 +0000
From:   "Chocron, Jonathan" <jonnyc@amazon.com>
To:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "Gustavo.Pimentel@synopsys.com" <Gustavo.Pimentel@synopsys.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "Hanoch, Uri" <hanochu@amazon.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Wasserstrom, Barak" <barakw@amazon.com>,
        "Saidi, Ali" <alisaidi@amazon.com>,
        "Hawa, Hanna" <hhhawa@amazon.com>,
        "Shenhar, Talel" <talel@amazon.com>,
        "Krupnik, Ronen" <ronenk@amazon.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "Chocron, Jonathan" <jonnyc@amazon.com>
Subject: Re: [PATCH v2 6/8] PCI: al: Add support for DW based driver type
Thread-Topic: [PATCH v2 6/8] PCI: al: Add support for DW based driver type
Thread-Index: AQHVPU3XMXwgBID7IUCMB4MzIhERXqbRpMwAgAOM1wCAASn+AIAAcNuA
Date:   Mon, 22 Jul 2019 15:38:46 +0000
Message-ID: <27d8e8a8bba4aeb845d6c953f3a07a29875fef02.camel@amazon.com>
References: <20190718094531.21423-1-jonnyc@amazon.com>
         <20190718094718.25083-2-jonnyc@amazon.com>
         <DM6PR12MB4010913E5408349A600762CADACB0@DM6PR12MB4010.namprd12.prod.outlook.com>
         <d323007c6bf14cb9f90a497a26b66dac151164fc.camel@amazon.com>
         <DM6PR12MB40101465C6D032B025473EFADAC40@DM6PR12MB4010.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB40101465C6D032B025473EFADAC40@DM6PR12MB4010.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.161.8]
Content-Type: text/plain; charset="utf-8"
Content-ID: <BEE06177C9B70F46A85B8E622B3F6BA5@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gTW9uLCAyMDE5LTA3LTIyIGF0IDA4OjU0ICswMDAwLCBHdXN0YXZvIFBpbWVudGVsIHdyb3Rl
Og0KPiANCj4gPiANCj4gPiA+ID4gK3N0YXRpYyBpbmxpbmUgdm9pZCBhbF9wY2llX3RhcmdldF9i
dXNfc2V0KHN0cnVjdCBhbF9wY2llDQo+ID4gPiA+ICpwY2llLA0KPiA+ID4gPiArCQkJCQkgIHU4
IHRhcmdldF9idXMsDQo+ID4gPiA+ICsJCQkJCSAgdTggbWFza190YXJnZXRfYnVzKQ0KPiA+ID4g
PiArew0KPiA+ID4gPiArCXZvaWQgX19pb21lbSAqY2ZnX2NvbnRyb2xfYWRkcjsNCj4gPiA+ID4g
Kwl1MzIgcmVnOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsJcmVnID0gRklFTERfUFJFUChDRkdfVEFS
R0VUX0JVU19NQVNLX01BU0ssDQo+ID4gPiA+IG1hc2tfdGFyZ2V0X2J1cykgfA0KPiA+ID4gPiAr
CSAgICAgIEZJRUxEX1BSRVAoQ0ZHX1RBUkdFVF9CVVNfQlVTTlVNX01BU0ssDQo+ID4gPiA+IHRh
cmdldF9idXMpOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsJY2ZnX2NvbnRyb2xfYWRkciA9ICh2b2lk
IF9faW9tZW0gKikoKHVpbnRwdHJfdClwY2llLQ0KPiA+ID4gPiA+IGNvbnRyb2xsZXJfYmFzZSAr
DQo+ID4gPiA+IA0KPiA+ID4gPiArCQkJICAgQVhJX0JBU0VfT0ZGU0VUICsgcGNpZS0NCj4gPiA+
ID4gPnJlZ19vZmZzZXRzLm9iX2N0cmwNCj4gPiA+ID4gKw0KPiA+ID4gPiArCQkJICAgQ0ZHX1RB
UkdFVF9CVVMpOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsJd3JpdGVsKHJlZywgY2ZnX2NvbnRyb2xf
YWRkcik7DQo+ID4gPiANCj4gPiA+IEZyb20gd2hhdCBJJ20gc2VlaW5nIHlvdSBjb21tb25seSB1
c2Ugd3JpdGVsKCkgYW5kIHJlYWRsKCkgd2l0aCBhDQo+ID4gPiBjb21tb24gDQo+ID4gPiBiYXNl
IGFkZHJlc3MsIHN1Y2ggYXMgcGNpZS0+Y29udHJvbGxlcl9iYXNlICsgQVhJX0JBU0VfT0ZGU0VU
Lg0KPiA+ID4gSSdkIHN1Z2dlc3QgdG8gY3JlYXRpbmcgYSB3cml0ZWwgYW5kIHJlYWRsIHdpdGgg
dGhhdCBvZmZzZXQNCj4gPiA+IGJ1aWx0LWluLg0KPiA+ID4gDQo+ID4gDQo+ID4gSSBwcmVmZXIg
dG8ga2VlcCBpdCBnZW5lcmljLCBzaW5jZSBpbiBmdXR1cmUgcmV2aXNpb25zIHdlIG1pZ2h0DQo+
ID4gd2FudCB0bw0KPiA+IGFjY2VzcyByZWdzIHdoaWNoIGFyZSBub3QgaW4gdGhlIEFYSSByZWdp
b24uIFlvdSB0aGluayBJIHNob3VsZCBhZGQNCj4gPiB3cmFwcGVycyB3aGljaCBzaW1wbHkgaGlk
ZSB0aGUgcGNpZS0+Y29udHJvbGxlcl9iYXNlIHBhcnQ/DQo+IA0KPiBJIGFuZCBvdGhlciBkZXZl
bG9wZXJzIHR5cGljYWxseSBkbyB0aGF0LCBidXQgaXQncyBhIHN1Z2dlc3Rpb24uIElNSE8NCj4g
aXQgDQo+IGhlbHBzIHRvIGtlZXAgdGhlIGNvZGUgY2xlYW5lciBhbmQgbW9yZSByZWFkYWJsZS4N
Cj4gDQoNCkFkZGVkIGFsX3BjaWVfY29udHJvbGxlcl9yZWFkbC93cml0ZWwgd3JhcHBlcnMuDQoN
Ci0tIA0KVGhhbmtzLA0KICAgSm9uYXRoYW4NCg==
