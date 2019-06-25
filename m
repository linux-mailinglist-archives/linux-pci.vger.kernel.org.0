Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B78554E45
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2019 14:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfFYME7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jun 2019 08:04:59 -0400
Received: from mga11.intel.com ([192.55.52.93]:43656 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726557AbfFYME7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Jun 2019 08:04:59 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jun 2019 05:04:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,415,1557212400"; 
   d="scan'208";a="182873319"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 25 Jun 2019 05:04:56 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 25 Jun 2019 15:04:55 +0300
Date:   Tue, 25 Jun 2019 15:04:55 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/2] PCI: Skip resource distribution when no hotplug
 bridges
Message-ID: <20190625120455.GF2640@lahna.fi.intel.com>
References: <20190622210310.180905-1-helgaas@kernel.org>
 <20190622210310.180905-3-helgaas@kernel.org>
 <20190624112449.GJ2640@lahna.fi.intel.com>
 <8a53232416cce158fad35b781eb80b3ace3afc08.camel@kernel.crashing.org>
 <20190625100534.GZ2640@lahna.fi.intel.com>
 <c4daf43a302eeb1c507b9cf4a353200669e04ad8.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4daf43a302eeb1c507b9cf4a353200669e04ad8.camel@kernel.crashing.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 25, 2019 at 09:48:19PM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2019-06-25 at 13:05 +0300, Mika Westerberg wrote:
> > > We only every distribute resources when using
> > > pci_assign_unassigned_bridge_resources which we only use some cases,
> > > and it's completely non obvious why we would use it there and not in
> > > other places.
> > 
> > We added it only for native PCIe hotplug path with the assumption that
> > the boot firmware takes care of the initial resource allocation. I don't
> > see any particular reason why it could not be called for other paths as
> > well, though.
> 
> Ok, we need to look into this for all the platforms who just reassign
> everything in Linux (ie, ignore whatever the boot firmware did, if it
> did anything).
> 
> I feel like all these platforms today will have a hard time getting
> anything useful out of hotplug with our default "2M" add to the hotplug
> bridges :)

Yeah, at least if Thunderbolt is involved each "daisy-chained" device
adds a complete PCIe switch running out of resources rather quick.

> > > We also don't distribute during the initial root survey meaning afaik
> > > that we get toast for any hotplug bridge that has stuff already there
> > > at boot.
> > 
> > The boot firmware obviously needs to follow the same logic. AFAICT
> > recent PCs and Macs using native PCIe hotplug handle it.
> 
> What's your experience in that area ? How (well) do they handle it in
> the boot firmware ? at least on arm64, boot firmwares are rather
> catastrophic when it comes to PCI, and on other embedded devices they
> are basically non-existent.

Well my experience is quite limited to recent Macs and PCs which usually
handle the initial resource allocation just fine. In case of Thunderbolt
some "older" PCs handle everything in firmware, even the runtime
resource allocation via SMI handler accompanied with ACPI hotplug.
