Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE795F793D
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2019 17:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfKKQz1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Nov 2019 11:55:27 -0500
Received: from mga14.intel.com ([192.55.52.115]:21559 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726927AbfKKQz1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Nov 2019 11:55:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Nov 2019 08:55:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,293,1569308400"; 
   d="scan'208";a="403936056"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by fmsmga005.fm.intel.com with ESMTP; 11 Nov 2019 08:55:26 -0800
Received: from orsmsx121.amr.corp.intel.com (10.22.225.226) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 11 Nov 2019 08:55:25 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.229]) by
 ORSMSX121.amr.corp.intel.com ([169.254.10.169]) with mapi id 14.03.0439.000;
 Mon, 11 Nov 2019 08:55:25 -0800
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "kbusch@kernel.org" <kbusch@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>
Subject: Re: [PATCH 0/2] VMD support for 8086:9A0B
Thread-Topic: [PATCH 0/2] VMD support for 8086:9A0B
Thread-Index: AQHVmLCBzM/wSgBcHkKvyqwqwFVLNqeGtkqA
Date:   Mon, 11 Nov 2019 16:55:24 +0000
Message-ID: <140d42b51dc98b4ec7e8b99d7c3ac6772913b43e.camel@intel.com>
References: <20191111165302.29636-1-jonathan.derrick@intel.com>
In-Reply-To: <20191111165302.29636-1-jonathan.derrick@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.232.115.143]
Content-Type: text/plain; charset="utf-8"
Content-ID: <BCE4212B22BFCB40AB43A1945FB7F2C3@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

K0tlaXRoDQpodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtcGNpL2xp
c3QvP3Nlcmllcz0yMDExNDcNCg0KT24gTW9uLCAyMDE5LTExLTExIGF0IDA5OjUzIC0wNzAwLCBK
b24gRGVycmljayB3cm90ZToNCj4gVGhpcyBzZXQgYWRkcyBWTUQgc3VwcG9ydCBmb3IgZGV2aWNl
IDgwODY6OUEwQi4gVGhlIGZpcnN0IHBhdGNoIGFkZHMNCj4gYW5vdGhlciBidXMgcmFuZ2UgcmVz
dHJpY3Rpb24gYW5kIHRoZSBzZWNvbmQgYWRkcyB0aGUgZGV2aWNlIGlkLg0KPiANCj4gSm9uIERl
cnJpY2sgKDIpOg0KPiAgIFBDSTogdm1kOiBBZGQgYnVzIDIyNC0yNTUgcmVzdHJpY3Rpb24gZGVj
b2RlDQo+ICAgUENJOiB2bWQ6IEFkZCBkZXZpY2UgaWQgZm9yIFZNRCBkZXZpY2UgODA4Njo5QTBC
DQo+IA0KPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci92bWQuYyB8IDMyICsrKysrKysrKysrKysr
KysrKysrKysrKy0tLS0tLS0tDQo+ICBpbmNsdWRlL2xpbnV4L3BjaV9pZHMuaCAgICAgIHwgIDEg
Kw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0K
PiANCg==
