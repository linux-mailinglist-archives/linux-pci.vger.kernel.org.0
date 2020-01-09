Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20933135E8B
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2020 17:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387468AbgAIQpS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jan 2020 11:45:18 -0500
Received: from mga05.intel.com ([192.55.52.43]:22011 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730708AbgAIQpS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Jan 2020 11:45:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2020 08:45:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,414,1571727600"; 
   d="scan'208";a="216358154"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by orsmga008.jf.intel.com with ESMTP; 09 Jan 2020 08:45:16 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.147]) by
 ORSMSX108.amr.corp.intel.com ([169.254.2.134]) with mapi id 14.03.0439.000;
 Thu, 9 Jan 2020 08:45:16 -0800
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
Subject: Re: [RFC 3/5] x86/PCI: Expose VMD's device in pci_sysdata
Thread-Topic: [RFC 3/5] x86/PCI: Expose VMD's device in pci_sysdata
Thread-Index: AQHVwEr2DDGpqCrTpUazRoVkAefkIKfi+SsAgAAkowA=
Date:   Thu, 9 Jan 2020 16:45:16 +0000
Message-ID: <096f9166b55a8af5911daab0ba8ecc6649e2f0e4.camel@intel.com>
References: <1577823863-3303-1-git-send-email-jonathan.derrick@intel.com>
         <1577823863-3303-4-git-send-email-jonathan.derrick@intel.com>
         <20200109143356.GB22656@lst.de>
In-Reply-To: <20200109143356.GB22656@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.4.146]
Content-Type: text/plain; charset="utf-8"
Content-ID: <83B3277B29EA5A478FE40B4A67278E8D@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVGh1LCAyMDIwLTAxLTA5IGF0IDE1OjMzICswMTAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gT24gVHVlLCBEZWMgMzEsIDIwMTkgYXQgMDE6MjQ6MjFQTSAtMDcwMCwgSm9uIERlcnJp
Y2sgd3JvdGU6DQo+ID4gVG8gYmUgdXNlZCBieSBpbnRlbC1pb21tdSBjb2RlIHRvIGZpbmQgdGhl
IGNvcnJlY3QgZG9tYWluLg0KPiANCj4gQW55IHJlYXNvbiB0byBwcmVmZXIgdGhpcyB2ZXJzaW9u
IG92ZXIgbXkgcGF0Y2hlcyAyIGFuZCAzIGZyb20gdGhlDQo+IHNlcmllcyBpbiBBdWd1c3Q/DQoN
CjIgJiAzIG9mIHlvdXIgc2V0IGlzIGZpbmUuDQo=
