Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 153541BE37B
	for <lists+linux-pci@lfdr.de>; Wed, 29 Apr 2020 18:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgD2QLO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Apr 2020 12:11:14 -0400
Received: from mga05.intel.com ([192.55.52.43]:55638 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726580AbgD2QLO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Apr 2020 12:11:14 -0400
IronPort-SDR: YUm3PqD1sz9z329ebCkWLr8Sx5Wqt/gEXJjdfSjVAOqcNIUJnm5YgFuUBdNPrdzYgB908uDrzB
 rLkjAluXueSw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2020 09:11:13 -0700
IronPort-SDR: lx2KkyTZPhRl1sD40I4Y7gLUcq7I5rdu5EFyb/8mWtnfuMy8EnenzMatqwkSikUnQqCqGtHMR3
 hmFSOvd9wCxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,332,1583222400"; 
   d="scan'208";a="249494877"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 29 Apr 2020 09:11:13 -0700
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com [10.7.201.137])
        by linux.intel.com (Postfix) with ESMTP id 52DD8580613;
        Wed, 29 Apr 2020 09:11:13 -0700 (PDT)
Message-ID: <537edbfaa088a655eb22e7eba05075aa61d941be.camel@linux.intel.com>
Subject: Re: [PATCH 0/2] Add support for StorageD3Enable _DSD property
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "hch@lst.de" <hch@lst.de>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Date:   Wed, 29 Apr 2020 09:11:13 -0700
In-Reply-To: <296064bbcf702744bf603932c9d849307db2e5b7.camel@intel.com>
References: <20200428003214.3764-1-david.e.box@linux.intel.com>
         <20200428051312.GB17146@lst.de>
         <de052d30cc881ac67f9410b50b0760ee5bf9a623.camel@linux.intel.com>
         <20200428142247.GB5439@lst.de>
         <de2d78556fcb10f97364201256ac8f342a58eb75.camel@linux.intel.com>
         <296064bbcf702744bf603932c9d849307db2e5b7.camel@intel.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2020-04-29 at 05:20 +0000, Williams, Dan J wrote:
> On Tue, 2020-04-28 at 08:27 -0700, David E. Box wrote:
> > On Tue, 2020-04-28 at 16:22 +0200, Christoph Hellwig wrote:
> > > On Tue, Apr 28, 2020 at 07:09:59AM -0700, David E. Box wrote:
> > > > > I'm not sure who came up with the idea to put this into ACPI,
> > > > > but
> > > > > it
> > > > > belongs into NVMe.  Please talk to the NVMe technical working
> > > > > group
> > > > > instead of trying to overrules them in an unrelated group
> > > > > that
> > > > > doesn't
> > > > > apply to all of PCIe.
> > > > 
> > > > Agreed that this is not ideal since it does not apply to all of
> > > > PCIe.
> > > > But as the property already exists on shipping systems, we need
> > > > to
> > > > be
> > > > able to read it in the NVMe driver and the patch is consitent
> > > > with
> > > > the
> > > > way properties under PCI ports are read.
> > > 
> > > The point is that it is not the BIOSes job do decide how Linux
> > > does
> > > power management.  For example D3 has really horrible entry and
> > > exit
> > > latencies in many cases, and will lead to higher power usage.
> > 
> > The platform can know which pm policies will save the most power.
> > But
> > since the solution doesn't apply to all PCIe devices (despite BIOS
> > specifying it that way) I'll withdraw this patch. Thanks.
> 
> Wait, why withdraw? In this case the platform is unfortunately
> preventing the standard driver from making a proper determination. So
> while I agree that it's not the BIOSes job, when the platform
> actively
> prevents proper operation due to some ill conceived non-standard
> platform property what is Linux left to do on these systems?
> 
> The *patch* is not trying to overrule NVME, and the best I can say is
> that the Intel Linux team was not in the loop when this was being
> decided between the platform BIOS implemenation
> and  whomever  thought
> they could just publish random ACPI properties that impacted NVME
> operation [1].
> 
> So now David is trying to get these platform unbroken because they
> are
> already shipping with this b0rkage.

Not drop completely. This patch copied the code used to read _DSD
properties under PCI root ports. But I agree that such properties
should apply to all devices on those ports and unfortuntely that's not
the case here. BIOS got it wrong. My thought in dropping this patch is
to rewrite it to read the property directly from the nvme driver. Not
the way it's typically done either but it would avoid a global change
in the pci core while allowing us to deal with the firmware we have.

David

