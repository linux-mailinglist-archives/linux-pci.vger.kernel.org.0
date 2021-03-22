Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81FA93452A5
	for <lists+linux-pci@lfdr.de>; Mon, 22 Mar 2021 23:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhCVW4J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Mar 2021 18:56:09 -0400
Received: from mga12.intel.com ([192.55.52.136]:57523 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229854AbhCVWzu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Mar 2021 18:55:50 -0400
IronPort-SDR: K+aZhq/DU+NqMHdKZIp2W3jELkUWIP88l3q+GF7MIIjLwEaihVLR3yldYeDnNg/N7s2tyQGqMK
 MkMCv6eDJNhg==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="169695211"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="169695211"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 15:55:50 -0700
IronPort-SDR: BssIbhqRzOJph8uk8GBi10Xr6YbQb1TFdq06/blY2VChBatHeEgctadd/e06sU5QUmXtFOGGXn
 uLjqlbFEp1Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="441382204"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 22 Mar 2021 15:55:49 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 22 Mar 2021 15:55:47 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 22 Mar 2021 15:55:47 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2106.013;
 Mon, 22 Mar 2021 15:55:47 -0700
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "hch@infradead.org" <hch@infradead.org>
CC:     "Kalakota, SushmaX" <sushmax.kalakota@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Patel, Nirmal" <nirmal.patel@intel.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>
Subject: Re: [PATCH 0/5] Legacy direct-assign mode
Thread-Topic: [PATCH 0/5] Legacy direct-assign mode
Thread-Index: AQHWv4+9xH1gXYcWf0W+ts3rSqbAv6qRI/2AgAB60ICAADRogA==
Date:   Mon, 22 Mar 2021 22:55:46 +0000
Message-ID: <804d2bff5bbe8e80004cbcbeaed3245b1acedf28.camel@intel.com>
References: <20201120225144.15138-1-jonathan.derrick@intel.com>
         <20210322122837.GC11469@e121166-lin.cambridge.arm.com>
         <20210322194811.GA2141770@infradead.org>
In-Reply-To: <20210322194811.GA2141770@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.22.254.132]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D74815433A0A0348B6EC36B1E8177837@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gTW9uLCAyMDIxLTAzLTIyIGF0IDE5OjQ4ICswMDAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gT24gTW9uLCBNYXIgMjIsIDIwMjEgYXQgMTI6Mjg6MzdQTSArMDAwMCwgTG9yZW56byBQ
aWVyYWxpc2kgd3JvdGU6DQo+ID4gPiBjb3JyZWN0bHkgcHJvZ3JhbSBicmlkZ2Ugd2luZG93cyB3
aXRoIHBoeXNpY2FsIGFkZHJlc3Nlcy4gU29tZSBjdXN0b21lcnMgYXJlDQo+ID4gPiB1c2luZyBh
IGxlZ2FjeSBtZXRob2QgdGhhdCByZWxpZXMgb24gdGhlIFZNRCBzdWJkZXZpY2UgZG9tYWluJ3Mg
cm9vdCBwb3J0DQo+ID4gPiB3aW5kb3dzIHRvIGJlIHdyaXR0ZW4gd2l0aCB0aGUgcGh5c2ljYWwg
YWRkcmVzc2VzLiBUaGlzIG1ldGhvZCBhbHNvIGFsbG93cw0KPiA+ID4gb3RoZXIgaHlwZXJ2aXNv
cnMgYmVzaWRlcyBRRU1VL0tWTSB0byBwZXJmb3JtIGd1ZXN0IHBhc3N0aHJvdWdoLg0KPiANCj4g
VGhpcyBzZWVtcyBsaWtlIGEgYmFkIGlkZWEuICBXaGF0IGFyZSB0aGVzZSBvdGhlciBoeXBlcnZp
c29ycz8gIEFGQUlLDQo+IHRoZXJlIGFyZSBubyBwdXJlbHkgdXNlcnNwYWNlIGh5cGVydmlzb3Jz
LCBzbyBpbiBvdGhlciB3b3JkcyB3aGF0IHlvdQ0KPiBwcm9wb3NlIGhlcmUgaXMgb25seSBmb3Ig
dW5zdXBwb3J0ZWQgZXh0ZXJuYWwgbW9kdWxlcy4NCkFueSBvZiB0aGUgdHlwZSAxIGh5cGVydmlz
b3JzIGhlcmU6DQpodHRwczovL2VuLndpa2lwZWRpYS5vcmcvd2lraS9IeXBlcnZpc29yDQoNCj4g
DQo+IEkgZG9uJ3QgdGhpbmsgd2Ugc2hvdWQgbWVyZ2Ugc29tZXRoaW5nIGxpa2UgdGhpcy4NCg==
