Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A906F09AA
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2019 23:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729970AbfKEWiG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Nov 2019 17:38:06 -0500
Received: from mga11.intel.com ([192.55.52.93]:4942 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728515AbfKEWiG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Nov 2019 17:38:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2019 14:38:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,271,1569308400"; 
   d="scan'208";a="403523873"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by fmsmga006.fm.intel.com with ESMTP; 05 Nov 2019 14:38:05 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.212]) by
 ORSMSX103.amr.corp.intel.com ([169.254.5.9]) with mapi id 14.03.0439.000;
 Tue, 5 Nov 2019 14:38:05 -0800
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "kbusch@kernel.org" <kbusch@kernel.org>
CC:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>,
        "Paszkiewicz, Artur" <artur.paszkiewicz@intel.com>,
        "Baldysiak, Pawel" <pawel.baldysiak@intel.com>,
        "Fugate, David" <david.fugate@intel.com>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Busch, Keith" <keith.busch@intel.com>
Subject: Re: [PATCH 2/3] PCI: vmd: Expose VMD details from BIOS
Thread-Topic: [PATCH 2/3] PCI: vmd: Expose VMD details from BIOS
Thread-Index: AQHVhHZYe7i9MHwHgU2a4PswmMHji6d3aeMAgAAGmACABIIDAIABDacAgAC9+wCAAA4pgIAABEYA
Date:   Tue, 5 Nov 2019 22:38:05 +0000
Message-ID: <e576c1081dbb05aa5931215a9ea684a40c094b6a.camel@intel.com>
References: <20191101215302.GA217821@google.com>
         <5c4521d26f45cfe01631d14c3d7edc9a10f99245.camel@intel.com>
         <20191104180700.GB26409@e121166-lin.cambridge.arm.com>
         <20191105101208.GA21113@e121166-lin.cambridge.arm.com>
         <5a87add6071259c45522001648b29c9e597ebd69.camel@intel.com>
         <20191105222247.GA890@redsun51.ssa.fujisawa.hgst.com>
In-Reply-To: <20191105222247.GA890@redsun51.ssa.fujisawa.hgst.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.232.115.129]
Content-Type: text/plain; charset="utf-8"
Content-ID: <CFDD4ABFBF8A3448A08E6BD315DEEC86@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gV2VkLCAyMDE5LTExLTA2IGF0IDA3OjIyICswOTAwLCBLZWl0aCBCdXNjaCB3cm90ZToNCj4g
T24gVHVlLCBOb3YgMDUsIDIwMTkgYXQgMDk6MzI6MDdQTSArMDAwMCwgRGVycmljaywgSm9uYXRo
YW4gd3JvdGU6DQo+ID4gV2l0aG91dCB0aGlzIHBhdGNoLCBhIC9kZXYvbWVtLCByZXNvdXJjZTAs
IG9yIHRoaXJkLXBhcnR5IGRyaXZlciBjb3VsZA0KPiA+IG92ZXJ3cml0ZSB0aGVzZSB2YWx1ZXMg
aWYgdGhleSBkb24ndCBhbHNvIHJlc3RvcmUgdGhlbSBvbiBjbG9zZS91bmJpbmQuDQo+ID4gSSBp
bWFnaW5lIGEga2V4ZWMgdXNlciB3b3VsZCBhbHNvIG92ZXJ3cml0ZSB0aGVzZSB2YWx1ZXMuDQo+
IA0KPiBEb24ndCB5b3UgaGF2ZSB0aGUgc2FtZSBwcm9ibGVtIHdpdGggdGhlIGluLWtlcm5lbCBk
cml2ZXI/IEl0DQo+IGxvb2tzIGxpa2UgcGNpIGNvcmUgd2lsbCBjbGVhciB0aGUgUENJX0lPX0JB
U0UgY29uZmlnIHJlZ2lzdGVycyBpbg0KPiBwY2lfc2V0dXBfYnJpZGdlX2lvKCkgYmVjYXVzZSBW
TUQgZG9lc24ndCBwcm92aWRlIGFuIElPUkVTT1VSQ0VfSU8NCj4gcmVzb3VyY2UuIElmIHlvdSBy
ZWxvYWQgdGhlIGRyaXZlciwgaXQnbGwgcmVhZCB0aGUgd3JvbmcgdmFsdWVzIG9uIHRoZQ0KPiBz
ZWNvbmQgcHJvYmluZy4NCg0KSXMgdGhlcmUgYSBjb3JuZXIgY2FzZSBJIGFtIG1pc3Npbmcgd2l0
aCBwYXRjaCAzLzMgdGhhdCByZXN0b3JlcyBvbg0KdW5sb2FkPw0K
