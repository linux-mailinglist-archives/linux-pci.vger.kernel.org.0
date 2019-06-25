Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE71F54DEF
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2019 13:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfFYLst (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jun 2019 07:48:49 -0400
Received: from gate.crashing.org ([63.228.1.57]:38787 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726931AbfFYLst (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Jun 2019 07:48:49 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x5PBmJOK032045;
        Tue, 25 Jun 2019 06:48:20 -0500
Message-ID: <c4daf43a302eeb1c507b9cf4a353200669e04ad8.camel@kernel.crashing.org>
Subject: Re: [PATCH 2/2] PCI: Skip resource distribution when no hotplug
 bridges
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Date:   Tue, 25 Jun 2019 21:48:19 +1000
In-Reply-To: <20190625100534.GZ2640@lahna.fi.intel.com>
References: <20190622210310.180905-1-helgaas@kernel.org>
         <20190622210310.180905-3-helgaas@kernel.org>
         <20190624112449.GJ2640@lahna.fi.intel.com>
         <8a53232416cce158fad35b781eb80b3ace3afc08.camel@kernel.crashing.org>
         <20190625100534.GZ2640@lahna.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2019-06-25 at 13:05 +0300, Mika Westerberg wrote:
> > We only every distribute resources when using
> > pci_assign_unassigned_bridge_resources which we only use some cases,
> > and it's completely non obvious why we would use it there and not in
> > other places.
> 
> We added it only for native PCIe hotplug path with the assumption that
> the boot firmware takes care of the initial resource allocation. I don't
> see any particular reason why it could not be called for other paths as
> well, though.

Ok, we need to look into this for all the platforms who just reassign
everything in Linux (ie, ignore whatever the boot firmware did, if it
did anything).

I feel like all these platforms today will have a hard time getting
anything useful out of hotplug with our default "2M" add to the hotplug
bridges :)

> > We also don't distribute during the initial root survey meaning afaik
> > that we get toast for any hotplug bridge that has stuff already there
> > at boot.
> 
> The boot firmware obviously needs to follow the same logic. AFAICT
> recent PCs and Macs using native PCIe hotplug handle it.

What's your experience in that area ? How (well) do they handle it in
the boot firmware ? at least on arm64, boot firmwares are rather
catastrophic when it comes to PCI, and on other embedded devices they
are basically non-existent.

> > Also, distributing the "available" space means we leave nothing for
> > potential SR-IOV siblings... have we ended up bloting the very PCIe-
> > centric assumption that it's "unlikely" that a hotplug bridge has an
> > SR-IOV sibling ?
> 
> Looking at the code, I'm not sure we reserved any additional resource
> space for the SR-IOV even before pci_bus_distribute_available_resources()
> was introduced. We do reserve extra bus numbers for SR-IOV in
> pci_scan_child_bus_extend() so maybe we can add something similar to
> resource allocation path.

Ok. I'll look more. I think we do somewhat cater for SR-IOV in in the
bridge sizing code actually. It's a bit obscure...

I also need to look a bit more closely at what happens with
Thunderbolt.

Thanks !

Cheers
Ben.

