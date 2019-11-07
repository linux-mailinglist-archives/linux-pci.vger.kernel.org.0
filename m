Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89236F338C
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2019 16:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730041AbfKGPkR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Nov 2019 10:40:17 -0500
Received: from mga17.intel.com ([192.55.52.151]:38354 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726810AbfKGPkQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Nov 2019 10:40:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2019 07:40:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,278,1569308400"; 
   d="scan'208";a="201069529"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by fmsmga008.fm.intel.com with ESMTP; 07 Nov 2019 07:40:16 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.212]) by
 ORSMSX106.amr.corp.intel.com ([169.254.1.210]) with mapi id 14.03.0439.000;
 Thu, 7 Nov 2019 07:40:16 -0800
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     "kbusch@kernel.org" <kbusch@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>
Subject: Re: [PATCH 0/3] PCI: vmd: Reducing tail latency by affining to the
 storage stack
Thread-Topic: [PATCH 0/3] PCI: vmd: Reducing tail latency by affining to the
 storage stack
Thread-Index: AQHVlMmF1+r/rt0/GUWDTuwxcG2u7ad/+yUAgABMKgCAABfJAIAAALSA
Date:   Thu, 7 Nov 2019 15:40:15 +0000
Message-ID: <c0d62e0f1f8d1d6f31b2a63757aad471ced1df28.camel@intel.com>
References: <1573040408-3831-1-git-send-email-jonathan.derrick@intel.com>
         <20191107093952.GA13826@infradead.org>
         <bfc69a54dc394ffb7580d14818047ec6a647536f.camel@intel.com>
         <20191107153736.GA16006@infradead.org>
In-Reply-To: <20191107153736.GA16006@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.7.176]
Content-Type: text/plain; charset="utf-8"
Content-ID: <26B8398982F08B479E81D6C050549F12@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVGh1LCAyMDE5LTExLTA3IGF0IDA3OjM3IC0wODAwLCBoY2hAaW5mcmFkZWFkLm9yZyB3cm90
ZToNCj4gT24gVGh1LCBOb3YgMDcsIDIwMTkgYXQgMDI6MTI6NTBQTSArMDAwMCwgRGVycmljaywg
Sm9uYXRoYW4gd3JvdGU6DQo+ID4gPiBIb3cgZG9lcyB0aGlzIGNvbXBhcmUgdG8gc2ltcGxpZnkg
ZGlzYWJsaW5nIFZNRD8NCj4gPiANCj4gPiBJdCdzIGEgbW9vdCBwb2ludCBzaW5jZSBLZWl0aCBw
b2ludGVkIG91dCBhIGZldyBmbGF3cyB3aXRoIHRoaXMgc2V0LA0KPiA+IGhvd2V2ZXIgZGlzYWJs
aW5nIFZNRCBpcyBub3QgYW4gb3B0aW9uIGZvciB1c2VycyB3aG8gd2lzaCB0bw0KPiA+IHBhc3N0
aHJvdWdoIFZNRA0KPiANCj4gQW5kIHdoeSB3b3VsZCB5b3UgZXZlciBwYXNzIHRocm91Z2ggdm1k
IGluc3RlYWQgb2YgdGhlIGFjdHVhbCBkZXZpY2U/DQo+IFRoYXQganVzdCBtYWtlcyB0aGluZ3Mg
Z28gc2xvd2VyIGFuZCBhZGRzIHplcm8gdmFsdWUuDQoNCkFiaWxpdHkgdG8gdXNlIHBoeXNpY2Fs
IFJvb3QgUG9ydHMvRFNQcy9ldGMgaW4gYSBndWVzdC4gU2xvd2VyIGlzDQphY2NlcHRhYmxlIGZv
ciBtYW55IHVzZXJzIGlmIGl0IGZpdHMgd2l0aGluIGEgcGVyZm9ybWFuY2Ugd2luZG93DQo=
