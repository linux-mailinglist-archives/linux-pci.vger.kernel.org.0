Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B533731E46A
	for <lists+linux-pci@lfdr.de>; Thu, 18 Feb 2021 04:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhBRDBH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Feb 2021 22:01:07 -0500
Received: from mga14.intel.com ([192.55.52.115]:61205 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229806AbhBRDBG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Feb 2021 22:01:06 -0500
IronPort-SDR: gVZyxOgvEY1zk7ovxmtqOjW9xdYXcC24XcGgGX1XA/d3o2FOfVyRsOe7LCv2S7pbNqngrujTIW
 eqBr1/p4NkpA==
X-IronPort-AV: E=McAfee;i="6000,8403,9898"; a="182593810"
X-IronPort-AV: E=Sophos;i="5.81,185,1610438400"; 
   d="scan'208";a="182593810"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2021 19:00:25 -0800
IronPort-SDR: QIR+MLxOB8VxXlWN5qdiUGpSwwUAP+n/VlCJaC8GNkv2uFiQmS7UkuBaEdeV11Uwp1QysXWEpB
 tD5LD/BvBKpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,185,1610438400"; 
   d="scan'208";a="378250822"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga002.jf.intel.com with ESMTP; 17 Feb 2021 19:00:24 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 17 Feb 2021 19:00:24 -0800
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 17 Feb 2021 19:00:23 -0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.2106.002;
 Thu, 18 Feb 2021 11:00:21 +0800
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     =?utf-8?B?J0tyenlzenRvZiBXaWxjennFhHNraSc=?= <kw@linux.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>, "Jin, Wen" <wen.jin@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] PCI/RCEC: Fix failure to inject errors to some RCiEP
 devices
Thread-Topic: [PATCH 1/1] PCI/RCEC: Fix failure to inject errors to some RCiEP
 devices
Thread-Index: AQHW/1FxyeRWMorsOUa/1MhtBDu8kapRGxsAgAwb9fA=
Date:   Thu, 18 Feb 2021 03:00:20 +0000
Message-ID: <a5b1aa8ef91a4c71982ad77234932349@intel.com>
References: <20210210020516.95292-1-qiuxu.zhuo@intel.com>
 <YCQT90mK1kacZ7ZA@rocinante>
In-Reply-To: <YCQT90mK1kacZ7ZA@rocinante>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.239.127.36]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQpTb3JyeSwganVzdCBiYWNrIGZyb20gQ2hpbmVzZSBOZXcgWWVhciBo
b2xpZGF5Lg0KDQo+IEZyb206IEtyenlzenRvZiBXaWxjennFhHNraSA8a3dAbGludXguY29tPg0K
PiAuLi4NCj4gLi4uDQo+IFdvdWxkIHRoaXMgb25seSBhZmZlY3QgZXJyb3IgaW5qZWN0aW9uIG9y
IHdvdWxkIHRoaXMgYmUgYWxzbyBhIGdlbmVyaWMgcHJvYmxlbQ0KPiB3aXRoIHRoZSBkcml2ZXIg
aXRzZWxmIGNhdXNpbmcgaXNzdWVzIHJlZ2FyZGxlc3Mgb2Ygd2hldGhlciBpdCB3YXMgYW4gZXJy
b3INCj4gaW5qZWN0aW9uIG9yIG5vdCBmb3IgdGhpcyBwYXJ0aWN1bGFyIGRldmljZT8gIEkgYW0g
YXNraW5nLCBhcyB0aGVyZSBpcyBhIGxvdCBnb2luZyBvbg0KPiBpbiB0aGUgY29tbWl0IG1lc3Nh
Z2UuDQoNClRoaXMgaXMgYWxzbyBhIGdlbmVyaWMgcHJvYmxlbS4NCg0KPiBJIHdvbmRlciBpZiBz
aW1wbGlmeWluZyB0aGlzIGNvbW1pdCBtZXNzYWdlIHNvIHRoYXQgaXQgY2xlYXJseSBleHBsYWlu
cyB3aGF0IHdhcw0KPiBicm9rZW4sIHdoeSwgYW5kIGhvdyB0aGlzIHBhdGNoIGlzIGZpeGluZyBp
dCwgd291bGQgcGVyaGFwcyBiZSBhbiBvcHRpb24/ICBUaGUNCj4gYmFja3N0b3J5IG9mIGhvdyB5
b3UgZm91bmQgdGhlIGlzc3VlIHdoaWxlIGRvaW5nIHNvbWUgdGVzdGluZyBhbmQgZXJyb3INCj4g
aW5qZWN0aW9uIGlzIG5pY2UsIGJ1dCBub3Qgc3VyZSBpZiBuZWVkZWQuDQo+IA0KPiBXaGF0IGRv
IHlvdSB0aGluaz8NCg0KQWdyZWUgdG8gc2ltcGxpZnkgdGhlIGNvbW1pdCBtZXNzYWdlLiBIb3cg
YWJvdXQgdGhlIGZvbGxvd2luZyBzdWJqZWN0IGFuZCBjb21taXQgbWVzc2FnZT8NCg0KU3ViamVj
dDogIA0KVXNlIGRldmljZSBudW1iZXIgdG8gY2hlY2sgUkNpRVBCaXRtYXAgb2YgUkNFQw0KDQpD
b21taXQgbWVzc2FnZTogDQpyY2VjX2Fzc29jX3JjaWVwKCkgdXNlZCB0aGUgY29tYmluYXRpb24g
b2YgZGV2aWNlIG51bWJlciBhbmQgZnVuY3Rpb24gbnVtYmVyICdkZXZmbicgdG8gY2hlY2sgd2hl
dGhlciB0aGUgY29ycmVzcG9uZGluZyBiaXQgaW4gdGhlIFJDaUVQQmltYXAgb2YgUkNFQyB3YXMg
c2V0LiBBY2NvcmRpbmcgdG8gWzFdLCBpdCBvbmx5IG5lZWRzIHRvIHVzZSB0aGUgZGV2aWNlIG51
bWJlciB0byBjaGVjayB0aGUgY29ycmVzcG9uZGluZyBiaXQgaW4gdGhlIFJDaUVQQml0bWFwIHdh
cyBzZXQuIFNvIGZpeCBpdCBieSB1c2luZyBQQ0lfU0xPVCgpIHRvIGNvbnZlcnQgJ2RldmZuJyB0
byBkZXZpY2UgbnVtYmVyIGZvciByY2VjX2Fzc29jX3JjaWVwKCkuDQpbMV0gUENJZSByNS4wLCBz
ZWMgIjcuOS4xMC4yIEFzc29jaWF0aW9uIEJpdG1hcCBmb3IgUkNpRVBzIg0KDQoNClRoYW5rcyEN
Ci1RaXV4dQ0K
