Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0AA31BE222
	for <lists+linux-pci@lfdr.de>; Wed, 29 Apr 2020 17:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgD2PKx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Apr 2020 11:10:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:60844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726516AbgD2PKw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Apr 2020 11:10:52 -0400
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 164D72074A;
        Wed, 29 Apr 2020 15:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588173051;
        bh=8A+8vDkMP+/JIF1TdfhS0LnIA8WKy9bVLiwsTDkUSTI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c+2m4Dap45V77moeWAWH+2CYGA+rcZ2K/2OztHOy+BvupHtxBxuOcFzc0f716mlq8
         SRHd7Vuz5ZNEnYuu6ClzWTH5I0Z9AfqndxDyjDcbiHIpD9ASe9sglx4azZrWB6rq68
         aMDBsDpM1DlYf7FagC6/0AkN9e5GAbjA4COdzq3k=
Date:   Thu, 30 Apr 2020 00:10:46 +0900
From:   Keith Busch <kbusch@kernel.org>
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
        "bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [PATCH 0/2] Add support for StorageD3Enable _DSD property
Message-ID: <20200429151046.GA6222@redsun51.ssa.fujisawa.hgst.com>
References: <20200428003214.3764-1-david.e.box@linux.intel.com>
 <20200428051312.GB17146@lst.de>
 <de052d30cc881ac67f9410b50b0760ee5bf9a623.camel@linux.intel.com>
 <20200428142247.GB5439@lst.de>
 <de2d78556fcb10f97364201256ac8f342a58eb75.camel@linux.intel.com>
 <296064bbcf702744bf603932c9d849307db2e5b7.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <296064bbcf702744bf603932c9d849307db2e5b7.camel@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 29, 2020 at 05:20:09AM +0000, Williams, Dan J wrote:
> On Tue, 2020-04-28 at 08:27 -0700, David E. Box wrote:
> > On Tue, 2020-04-28 at 16:22 +0200, Christoph Hellwig wrote:
> > > On Tue, Apr 28, 2020 at 07:09:59AM -0700, David E. Box wrote:
> > > > > I'm not sure who came up with the idea to put this into ACPI,
> > > > > but
> > > > > it
> > > > > belongs into NVMe.  Please talk to the NVMe technical working
> > > > > group
> > > > > instead of trying to overrules them in an unrelated group that
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
> > > The point is that it is not the BIOSes job do decide how Linux does
> > > power management.  For example D3 has really horrible entry and
> > > exit
> > > latencies in many cases, and will lead to higher power usage.
> > 
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

Rather than quirking all these cases, which I get the feeling there
are many more than we've currently got in our quirk list, perhaps it'd
be simpler to default to the simple suspend. AFAIK, the simple suspend
works for all platforms, though it may not realize the best power savings
and/or exit latency.
