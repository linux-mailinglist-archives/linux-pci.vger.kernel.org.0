Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1B8C1C12AA
	for <lists+linux-pci@lfdr.de>; Fri,  1 May 2020 15:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbgEANND (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 May 2020 09:13:03 -0400
Received: from verein.lst.de ([213.95.11.211]:46194 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728720AbgEANND (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 May 2020 09:13:03 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E2AC168BFE; Fri,  1 May 2020 15:12:59 +0200 (CEST)
Date:   Fri, 1 May 2020 15:12:59 +0200
From:   "hch@lst.de" <hch@lst.de>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "hch@lst.de" <hch@lst.de>,
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
Message-ID: <20200501131259.GB6600@lst.de>
References: <20200428003214.3764-1-david.e.box@linux.intel.com> <20200428051312.GB17146@lst.de> <de052d30cc881ac67f9410b50b0760ee5bf9a623.camel@linux.intel.com> <20200428142247.GB5439@lst.de> <de2d78556fcb10f97364201256ac8f342a58eb75.camel@linux.intel.com> <296064bbcf702744bf603932c9d849307db2e5b7.camel@intel.com> <537edbfaa088a655eb22e7eba05075aa61d941be.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <537edbfaa088a655eb22e7eba05075aa61d941be.camel@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 29, 2020 at 09:11:13AM -0700, David E. Box wrote:
> Not drop completely. This patch copied the code used to read _DSD
> properties under PCI root ports. But I agree that such properties
> should apply to all devices on those ports and unfortuntely that's not
> the case here. BIOS got it wrong. My thought in dropping this patch is
> to rewrite it to read the property directly from the nvme driver. Not
> the way it's typically done either but it would avoid a global change
> in the pci core while allowing us to deal with the firmware we have.

I'd be happy to heave less of this crap in nvme actually.  But I'm really
pissed this shit got out in the wild.  It wasn't clear from the mail
that this is something already out there because the idiots coming up
with it just went ahead with it.  Please just update the commit logs
and implementation to clearly mark it as a workaround for buggys
systems, which just happen to at least be nice enough to tell us that
they are buggy as f^$k.
