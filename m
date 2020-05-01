Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3BA61C1294
	for <lists+linux-pci@lfdr.de>; Fri,  1 May 2020 15:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbgEANKH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 May 2020 09:10:07 -0400
Received: from verein.lst.de ([213.95.11.211]:46158 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728586AbgEANKH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 May 2020 09:10:07 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9444168BFE; Fri,  1 May 2020 15:10:01 +0200 (CEST)
Date:   Fri, 1 May 2020 15:10:01 +0200
From:   "hch@lst.de" <hch@lst.de>
To:     "Williams, Dan J" <dan.j.williams@intel.com>
Cc:     "hch@lst.de" <hch@lst.de>,
        "david.e.box@linux.intel.com" <david.e.box@linux.intel.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
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
Message-ID: <20200501131001.GA6600@lst.de>
References: <20200428003214.3764-1-david.e.box@linux.intel.com> <20200428051312.GB17146@lst.de> <de052d30cc881ac67f9410b50b0760ee5bf9a623.camel@linux.intel.com> <20200428142247.GB5439@lst.de> <de2d78556fcb10f97364201256ac8f342a58eb75.camel@linux.intel.com> <296064bbcf702744bf603932c9d849307db2e5b7.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <296064bbcf702744bf603932c9d849307db2e5b7.camel@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 29, 2020 at 05:20:09AM +0000, Williams, Dan J wrote:
> > The platform can know which pm policies will save the most power. But
> > since the solution doesn't apply to all PCIe devices (despite BIOS
> > specifying it that way) I'll withdraw this patch. Thanks.
> 
> Wait, why withdraw? In this case the platform is unfortunately
> preventing the standard driver from making a proper determination. So
> while I agree that it's not the BIOSes job, when the platform actively
> prevents proper operation due to some ill conceived non-standard
> platform property what is Linux left to do on these systems?
> 
> The *patch* is not trying to overrule NVME, and the best I can say is
> that the Intel Linux team was not in the loop when this was being
> decided between the platform BIOS implemenation and  whomever  thought
> they could just publish random ACPI properties that impacted NVME
> operation [1].
> 
> So now David is trying to get these platform unbroken because they are
> already shipping with this b0rkage.

So can we please clearly mark this as a quirk and warn in the kernel
log about a buggy BIOS?
