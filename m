Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90BD6135C33
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2020 16:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729758AbgAIPGS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jan 2020 10:06:18 -0500
Received: from mga05.intel.com ([192.55.52.43]:12607 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728346AbgAIPGS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Jan 2020 10:06:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2020 07:06:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,414,1571727600"; 
   d="scan'208";a="246694487"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by fmsmga004.fm.intel.com with ESMTP; 09 Jan 2020 07:06:17 -0800
Received: from orsmsx153.amr.corp.intel.com (10.22.226.247) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 9 Jan 2020 07:06:17 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.147]) by
 ORSMSX153.amr.corp.intel.com ([169.254.12.176]) with mapi id 14.03.0439.000;
 Thu, 9 Jan 2020 07:06:17 -0800
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
Thread-Index: AQHVwEr2DDGpqCrTpUazRoVkAefkIKfi+SsAgAAJAgA=
Date:   Thu, 9 Jan 2020 15:06:16 +0000
Message-ID: <f2493d85ab9cf5fa2622b60c55b20aa4a5a99bcb.camel@intel.com>
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
Content-ID: <8EE5DD1903CFAA46A047845FF7E8AC5B@intel.com>
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
Ck1pbmUgdXNlcyB0aGUgY29ycmVjdCBkZXZpY2UncyBkbWEgbWFzaw0K
