Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7E951BC0BC
	for <lists+linux-pci@lfdr.de>; Tue, 28 Apr 2020 16:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgD1OKR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Apr 2020 10:10:17 -0400
Received: from mga06.intel.com ([134.134.136.31]:3285 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727837AbgD1OKR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Apr 2020 10:10:17 -0400
IronPort-SDR: ZcHSO9sHC6SOOiltka4d4wNib/U5kpjWgqotIDRlEbkAlwiUNxzO0/13ZsHgXlWoBUt6mKRcvL
 jFDrNYj0pjjw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2020 07:10:00 -0700
IronPort-SDR: Mm9J+5XFNoyA68jB0F0HKKpD1YU7fQMOY9LqQIoJEGkYRAY5YaN7vXK//ElU6ngpEs2/VLIDk9
 vVCiz+6MyA+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,328,1583222400"; 
   d="scan'208";a="247720032"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 28 Apr 2020 07:09:59 -0700
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com [10.7.201.137])
        by linux.intel.com (Postfix) with ESMTP id 0B6675802C8;
        Tue, 28 Apr 2020 07:10:00 -0700 (PDT)
Message-ID: <de052d30cc881ac67f9410b50b0760ee5bf9a623.camel@linux.intel.com>
Subject: Re: [PATCH 0/2] Add support for StorageD3Enable _DSD property
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Christoph Hellwig <hch@lst.de>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, bhelgaas@google.com,
        kbusch@kernel.org, axboe@fb.com, sagi@grimberg.me,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Tue, 28 Apr 2020 07:09:59 -0700
In-Reply-To: <20200428051312.GB17146@lst.de>
References: <20200428003214.3764-1-david.e.box@linux.intel.com>
         <20200428051312.GB17146@lst.de>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2020-04-28 at 07:13 +0200, Christoph Hellwig wrote:
> On Mon, Apr 27, 2020 at 05:32:12PM -0700, David E. Box wrote:
> > NVMe storage power management during suspend-to-idle, particularly
> > on
> > laptops, has been inconsistent with some devices working with D3
> > while
> > others must rely on NVMe APST in order for power savings to be
> > realized.
> > Currently the default is to use APST unless quirked to do
> > otherwise.
> > However newer platforms, like Intel Comet Lake systems, may require
> > NVMe
> > drives to use D3 in order for the PCIe ports to be properly power
> > managed.
> > To make it easier for drivers to choose, these platforms may supply
> > a
> > special "StorageD3Enable" _DSD property under the root port that
> > the device
> > is attached to. If supplied, the driver must use D3 in order for
> > the
> > platform to realize the deepest power savings in suspend-to-idle.
> >     
> > The first patch adds the new _DSD GUID and fowards the property
> > through the
> > pci/acpi layer to the pci device.
> > 
> > The second patch adds support for the property to the nvme driver.
> 
> I'm not sure who came up with the idea to put this into ACPI, but it
> belongs into NVMe.  Please talk to the NVMe technical working group
> instead of trying to overrules them in an unrelated group that
> doesn't
> apply to all of PCIe.

Agreed that this is not ideal since it does not apply to all of PCIe.
But as the property already exists on shipping systems, we need to be
able to read it in the NVMe driver and the patch is consitent with the
way properties under PCI ports are read.

David

