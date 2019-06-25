Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26588528F9
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2019 12:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfFYKFi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jun 2019 06:05:38 -0400
Received: from mga17.intel.com ([192.55.52.151]:20121 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726274AbfFYKFi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Jun 2019 06:05:38 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jun 2019 03:05:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,415,1557212400"; 
   d="scan'208";a="182854968"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 25 Jun 2019 03:05:35 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 25 Jun 2019 13:05:34 +0300
Date:   Tue, 25 Jun 2019 13:05:34 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/2] PCI: Skip resource distribution when no hotplug
 bridges
Message-ID: <20190625100534.GZ2640@lahna.fi.intel.com>
References: <20190622210310.180905-1-helgaas@kernel.org>
 <20190622210310.180905-3-helgaas@kernel.org>
 <20190624112449.GJ2640@lahna.fi.intel.com>
 <8a53232416cce158fad35b781eb80b3ace3afc08.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a53232416cce158fad35b781eb80b3ace3afc08.camel@kernel.crashing.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 25, 2019 at 09:45:04AM +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2019-06-24 at 14:24 +0300, Mika Westerberg wrote:
> > > 
> > > I'm pretty sure this patch preserves the previous behavior of
> > > pci_bus_distribute_available_resources(), but I'm not sure that
> > > behavior is what we want.
> > > 
> > > For example, in the following topology, when we process bus 10, we
> > > find two non-hotplug bridges and no hotplug bridges, so IIUC we
> > > return
> > > without distributing any resources to them.  But I would think we
> > > should try to give 10:1c.0 more space if possible because it has a
> > > hotplug bridge below it.
> > > 
> > >    00:1c.0: hotplug bridge to [bus 10-2f]
> > >      10:1c.0: non-hotplug bridge to [bus 11-2e]
> > >        11:00.0: hotplug bridge to [bus 12-2e]
> > >      10:1c.1: non-hotplug bridge to [bus 2f]
> > 
> > Yes, I agree in this case we want to preserve more space for 10:1c.0.
> 
> I sitll can't make sense of any of this stuff though.
> 
> We only every distribute resources when using
> pci_assign_unassigned_bridge_resources which we only use some cases,
> and it's completely non obvious why we would use it there and not in
> other places.

We added it only for native PCIe hotplug path with the assumption that
the boot firmware takes care of the initial resource allocation. I don't
see any particular reason why it could not be called for other paths as
well, though.

> We also don't distribute during the initial root survey meaning afaik
> that we get toast for any hotplug bridge that has stuff already there
> at boot.

The boot firmware obviously needs to follow the same logic. AFAICT
recent PCs and Macs using native PCIe hotplug handle it.

> Also, distributing the "available" space means we leave nothing for
> potential SR-IOV siblings... have we ended up bloting the very PCIe-
> centric assumption that it's "unlikely" that a hotplug bridge has an
> SR-IOV sibling ?

Looking at the code, I'm not sure we reserved any additional resource
space for the SR-IOV even before pci_bus_distribute_available_resources()
was introduced. We do reserve extra bus numbers for SR-IOV in
pci_scan_child_bus_extend() so maybe we can add something similar to
resource allocation path.
