Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABFE41BD3F1
	for <lists+linux-pci@lfdr.de>; Wed, 29 Apr 2020 07:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgD2FUM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 29 Apr 2020 01:20:12 -0400
Received: from mga09.intel.com ([134.134.136.24]:2243 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbgD2FUL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Apr 2020 01:20:11 -0400
IronPort-SDR: 9vY+KN+4pTAxQsWP/tIAiD3+AxqWw49yzdwWG+gs/n8qASrZgN6mz0kqLW7dKiZZHg8tYRwWNV
 YpaZl5+4lOLw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2020 22:20:11 -0700
IronPort-SDR: qZAwIGjYFXEwc9gn7eJBUXXY7T9uXzfVFuBF4Ch77I1paTO/rTowIqW+PyVP28RtGTT6YD6skR
 mGvAhhGh3hAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,330,1583222400"; 
   d="scan'208";a="432440250"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by orsmga005.jf.intel.com with ESMTP; 28 Apr 2020 22:20:11 -0700
Received: from orsmsx159.amr.corp.intel.com (10.22.240.24) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 28 Apr 2020 22:20:10 -0700
Received: from orsmsx107.amr.corp.intel.com ([169.254.1.205]) by
 ORSMSX159.amr.corp.intel.com ([169.254.11.195]) with mapi id 14.03.0439.000;
 Tue, 28 Apr 2020 22:20:10 -0700
From:   "Williams, Dan J" <dan.j.williams@intel.com>
To:     "hch@lst.de" <hch@lst.de>,
        "david.e.box@linux.intel.com" <david.e.box@linux.intel.com>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [PATCH 0/2] Add support for StorageD3Enable _DSD property
Thread-Topic: [PATCH 0/2] Add support for StorageD3Enable _DSD property
Thread-Index: AQHWHeXa7+nQtLOpJUmuLMlaOXTLQw==
Date:   Wed, 29 Apr 2020 05:20:09 +0000
Message-ID: <296064bbcf702744bf603932c9d849307db2e5b7.camel@intel.com>
References: <20200428003214.3764-1-david.e.box@linux.intel.com>
         <20200428051312.GB17146@lst.de>
         <de052d30cc881ac67f9410b50b0760ee5bf9a623.camel@linux.intel.com>
         <20200428142247.GB5439@lst.de>
         <de2d78556fcb10f97364201256ac8f342a58eb75.camel@linux.intel.com>
In-Reply-To: <de2d78556fcb10f97364201256ac8f342a58eb75.camel@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.30.10]
Content-Type: text/plain; charset="utf-7"
Content-ID: <70CC327022932945B5FF865EF7EEC18B@intel.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2020-04-28 at 08:27 -0700, David E. Box wrote:
+AD4- On Tue, 2020-04-28 at 16:22 +-0200, Christoph Hellwig wrote:
+AD4- +AD4- On Tue, Apr 28, 2020 at 07:09:59AM -0700, David E. Box wrote:
+AD4- +AD4- +AD4- +AD4- I'm not sure who came up with the idea to put this into ACPI,
+AD4- +AD4- +AD4- +AD4- but
+AD4- +AD4- +AD4- +AD4- it
+AD4- +AD4- +AD4- +AD4- belongs into NVMe.  Please talk to the NVMe technical working
+AD4- +AD4- +AD4- +AD4- group
+AD4- +AD4- +AD4- +AD4- instead of trying to overrules them in an unrelated group that
+AD4- +AD4- +AD4- +AD4- doesn't
+AD4- +AD4- +AD4- +AD4- apply to all of PCIe.
+AD4- +AD4- +AD4- 
+AD4- +AD4- +AD4- Agreed that this is not ideal since it does not apply to all of
+AD4- +AD4- +AD4- PCIe.
+AD4- +AD4- +AD4- But as the property already exists on shipping systems, we need
+AD4- +AD4- +AD4- to
+AD4- +AD4- +AD4- be
+AD4- +AD4- +AD4- able to read it in the NVMe driver and the patch is consitent
+AD4- +AD4- +AD4- with
+AD4- +AD4- +AD4- the
+AD4- +AD4- +AD4- way properties under PCI ports are read.
+AD4- +AD4- 
+AD4- +AD4- The point is that it is not the BIOSes job do decide how Linux does
+AD4- +AD4- power management.  For example D3 has really horrible entry and
+AD4- +AD4- exit
+AD4- +AD4- latencies in many cases, and will lead to higher power usage.
+AD4- 
+AD4- The platform can know which pm policies will save the most power. But
+AD4- since the solution doesn't apply to all PCIe devices (despite BIOS
+AD4- specifying it that way) I'll withdraw this patch. Thanks.

Wait, why withdraw? In this case the platform is unfortunately
preventing the standard driver from making a proper determination. So
while I agree that it's not the BIOSes job, when the platform actively
prevents proper operation due to some ill conceived non-standard
platform property what is Linux left to do on these systems?

The +ACo-patch+ACo- is not trying to overrule NVME, and the best I can say is
that the Intel Linux team was not in the loop when this was being
decided between the platform BIOS implemenation and  whomever  thought
they could just publish random ACPI properties that impacted NVME
operation +AFs-1+AF0-.

So now David is trying to get these platform unbroken because they are
already shipping with this b0rkage.

+AFs-1+AF0-: 
https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/power-management-for-storage-hardware-devices-intro


