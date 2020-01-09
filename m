Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06294135C34
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2020 16:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731870AbgAIPGU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jan 2020 10:06:20 -0500
Received: from mga06.intel.com ([134.134.136.31]:44758 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728346AbgAIPGU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Jan 2020 10:06:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2020 07:06:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,414,1571727600"; 
   d="scan'208";a="396115887"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by orsmga005.jf.intel.com with ESMTP; 09 Jan 2020 07:06:19 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.147]) by
 ORSMSX106.amr.corp.intel.com ([169.254.1.81]) with mapi id 14.03.0439.000;
 Thu, 9 Jan 2020 07:06:19 -0800
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "hch@lst.de" <hch@lst.de>
CC:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [RFC 5/5] x86/PCI: Remove unused X86_DEV_DMA_OPS
Thread-Topic: [RFC 5/5] x86/PCI: Remove unused X86_DEV_DMA_OPS
Thread-Index: AQHVwEr3S4KIoL/nS0WrreVURfr+T6fi+gYAgAAIKoA=
Date:   Thu, 9 Jan 2020 15:06:18 +0000
Message-ID: <d520cd818840894c043432109104564109f5e67a.camel@intel.com>
References: <1577823863-3303-1-git-send-email-jonathan.derrick@intel.com>
         <1577823863-3303-6-git-send-email-jonathan.derrick@intel.com>
         <20200109143700.GD22656@lst.de>
In-Reply-To: <20200109143700.GD22656@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.4.146]
Content-Type: text/plain; charset="utf-8"
Content-ID: <33DDD8729996C34A9B073A900E677243@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVGh1LCAyMDIwLTAxLTA5IGF0IDE1OjM3ICswMTAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gT24gVHVlLCBEZWMgMzEsIDIwMTkgYXQgMDE6MjQ6MjNQTSAtMDcwMCwgSm9uIERlcnJp
Y2sgd3JvdGU6DQo+ID4gVk1EIHdhcyB0aGUgb25seSB1c2VyIG9mIGRldmljZSBkbWEgb3BlcmF0
aW9ucy4gTm93IHRoYXQgdGhlIElPTU1VIGhhcw0KPiA+IGJlZW4gbWFkZSBhd2FyZSBvZiBkaXJl
Y3QgRE1BIGFsaWFzZXMsIFZNRCBkb21haW4gZGV2aWNlcyBjYW4gcmVmZXJlbmNlDQo+ID4gdGhl
IFZNRCBlbmRwb2ludCBkaXJlY3RseSBhbmQgdGhlIFZNRCBkZXZpY2UgZG1hIG9wZXJhdGlvbnMg
aGFzIGJlZW4NCj4gPiBtYWRlIG9ic29sZXRlLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEpv
biBEZXJyaWNrIDxqb25hdGhhbi5kZXJyaWNrQGludGVsLmNvbT4NCj4gDQo+IFRoaXMgc2VlbXMg
dG8gYmUgYSAxOjEgY29weSBvZiBteSBwYXRjaCBmcm9tIEF1Z3VzdD8NClNvcnJ5IEkgZGlkbid0
IG5vdGljZSB0aGF0LiBJJ2xsIGdpdmUgeW91IGF0dHJpYnV0aW9ucy4NCg==
