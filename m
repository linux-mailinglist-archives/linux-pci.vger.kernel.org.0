Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4CB427AF22
	for <lists+linux-pci@lfdr.de>; Mon, 28 Sep 2020 15:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgI1New (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Sep 2020 09:34:52 -0400
Received: from mga02.intel.com ([134.134.136.20]:18550 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbgI1New (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 28 Sep 2020 09:34:52 -0400
IronPort-SDR: besA7ihrN2PO25VvdcLJ7fjWTiETJPXoTkYZjT3ig6nvN4j79n+YlOCPrsMYM8xqiAi28txYDF
 2DdvcNnnSKOA==
X-IronPort-AV: E=McAfee;i="6000,8403,9757"; a="149657772"
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="149657772"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 06:34:52 -0700
IronPort-SDR: QmUDGt96bmK2EPvzC19UfH3oZnC9c2SCN0qF+5Zj4y4o3KzyWw2pb44CStDt8pPm4TnshO1Pqz
 qumeEOS8lAiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="324286556"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 28 Sep 2020 06:34:52 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 28 Sep 2020 06:34:51 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 28 Sep 2020 06:34:51 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.1713.004;
 Mon, 28 Sep 2020 06:34:51 -0700
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "andrzej.jakowski@linux.intel.com" <andrzej.jakowski@linux.intel.com>,
        "Fugate, David" <david.fugate@intel.com>
Subject: Re: [PATCH 2/3] PCI: Introduce a minimizing assignment algorithm
Thread-Topic: [PATCH 2/3] PCI: Introduce a minimizing assignment algorithm
Thread-Index: AQHWlTZiZAz7l230vUSUAOJgffRmeql+GeSAgABpTwA=
Date:   Mon, 28 Sep 2020 13:34:50 +0000
Message-ID: <5062649eee1c179245c435a415da8dad87ef6325.camel@intel.com>
References: <20200928010609.5375-1-jonathan.derrick@intel.com>
         <20200928010609.5375-3-jonathan.derrick@intel.com>
         <20200928071755.GB24862@infradead.org>
In-Reply-To: <20200928071755.GB24862@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="utf-8"
Content-ID: <800A82B3CC60EB4BAF70ECC1408D7D14@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgQ2hyaXN0b3BoLA0KDQpUaGFua3MgZm9yIHlvdXIgdmFsdWFibGUgZmVlZGJhY2sgYXMgYWx3
YXlzDQoNCk9uIE1vbiwgMjAyMC0wOS0yOCBhdCAwODoxNyArMDEwMCwgQ2hyaXN0b3BoIEhlbGx3
aWcgd3JvdGU6DQo+IFBsZWFzZSBrZWVwIHRoaXMgY29kZSBpbiBWTUQgaWYgd2UgcmVhbGx5IGhh
dmUgdG8gZG8gaXQgKGFsdGhvdWdoIEknZA0KPiBiZSBwZXJmZWN0bHkgZmluZSB0byBsZXQgcGVv
cGxlIGR1bWIgZW5vdWdoIHRvIGVuYWJsZSBWTUQgZGV2aWNlcyB0bw0KPiBsaXZlIHdpdGggdGhl
IHByb2JsZW1zKS4NCkdyZWF0ISBTb3VuZHMgbGlrZSB5b3UncmUgbW9yZSBvcGVuIHRvIHVzIHdv
cmtpbmcgb3Blbmx5IHdpdGhpbiB2bWQuYw0KdGhlbj8NCg0KPiAgIFlvdSBhcmUgYWRkaW5nIGxv
dHMgb2YgY29kZSB0aGF0IGdldHMNCj4gY29waWxlZCBpbnRvIGV2ZXJ5IExpbnV4IGtlcm5lbCB0
aGF0IHN1cHBvcnRzIFBDSSBqdXQgdG8gd29yayBhcm91bmQNCj4gYSBjb3BsZXRlbHkgaWRpb3Rp
YyBpbnZlbnRpb24gZnJvbSBJbnRlbCB0aGF0IG1ha2VzIGxpZmUgcGFpbmZ1bCBmb3INCj4gdXMg
Zm9yIG5vIGdvb2QgcmVhc29uLg0KV2VsbCB0aGlzIGZpeCBpbiBwYXJ0aWN1bGFyIG1heSBub3Qg
YmUgbmVlZGVkIG9uY2UgdGhlIGR5bmFtaWMgaG90cGx1Zw0KcmVzb3VyY2UgcmVzaXppbmcgc2V0
IGlzIGluIGFuZCBidWlsZCBvbiB0aGF0LiBCdXQgZnJhbmtseSB0aGUgZ2VuZXJpYw0KcmVzb3Vy
Y2UgYXNzaWdubWVudCBjb2RlIGl0c2VsZiBpcyB2ZXJ5IGRpZmZpY3VsdCB0byB3b3JrIHdpdGhp
biBhbmQNCmhhcyBiZWVuIGRpc2N1c3NlZCBhdCBzZXZlcmFsIExQQyBvdmVyIHRoZSB5ZWFycy4g
SSBkb24ndCBzZWUgYSBwcm9ibGVtDQp3aXRoIGFub3RoZXIgYWxnb3JpdGhtIHdoaWNoIGNvdWxk
IGJlIHJlbGllZCB1cG9uIGJ5IG90aGVyIGhvc3QgYnJpZGdlDQpjb250cm9sbGVyIGRyaXZlcnMg
aWYgdGhleSB3YW50IGl0Lg0KDQpJIGFsc28gc3BlbnQgYSBnb29kIGRlYWwgb2YgdGltZSB0cnlp
bmcgdG8gZ2V0IHRoZSBtaW5pbWl6aW5nIGFsZ29yaXRobQ0KaW50byBwY2lfYXNzaWduX3VuYXNz
aWduZWRfcm9vdF9idXNfcmVzb3VyY2VzLCB3aGVyZSB0aGUgb25seSBpbnN0YW5jZQ0Kb2YgcGNp
PXJlYWxsb2MgZGV0ZWN0aW9uIHRha2VzIHBsYWNlICh3aG8ga25ldyB0aGVyZSB3ZXJlIHNvIG1h
bnkNCm9yaWdpbmF0aW5nIGRpZmZlcmVudCBwYXRocyBmb3IgcmVzb3VyY2UgYXNzaWdubWVudD8p
LiBJIGNvdWxkbid0IG1ha2UNCmhlYWR3YXkgdGhlcmUgc28gc3RhcnRlZCBmcmVzaC4gTWF5YmUg
c29tZW9uZSB0YWxlbnRlZCBjb3VsZCByZWZhY3Rvcg0KbWluZSBpbnRvIGl0IGFuZCBzYXZlIGEg
ZmV3IGluc3RydWN0aW9uIGJ5dGVzLg0K
