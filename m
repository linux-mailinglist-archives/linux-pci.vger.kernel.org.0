Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF55944E46
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2019 23:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbfFMVUn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jun 2019 17:20:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:43982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfFMVUn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Jun 2019 17:20:43 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEC2321473;
        Thu, 13 Jun 2019 21:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560460842;
        bh=Z+dlfQ+ctdx1EZOVcyaPL/M3KC9IFJCZZQf6DaOItA8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HhcbtQcq5QR7cOc09f+ozD33NfZaEOy1Qy0TGzGi2LQCEsVwvf5m7yl9KdtncBTde
         8oDTNA6pUU+R7pJHHchh1X29sM3oQzK4kQ/lw6ggbMqnVT/ze3Gr/pkw6EB/+Vq5OR
         YIYLFzDSDAOwfaH4a8Om7PTRuzslwtedAuvZCr6I=
Date:   Thu, 13 Jun 2019 16:20:39 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     linux-pci@vger.kernel.org, KarimAllah Ahmed <karahmed@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/IOV: Fix VF cfg_size
Message-ID: <20190613212039.GL13533@google.com>
References: <155966918965.10361.16228304474160813310.stgit@gimli.home>
 <20190604143617.0a226555@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604143617.0a226555@x1.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 04, 2019 at 02:36:17PM -0600, Alex Williamson wrote:
> On Tue, 04 Jun 2019 11:26:42 -0600
> Alex Williamson <alex.williamson@redhat.com> wrote:
> 
> > Commit 975bb8b4dc93 ("PCI/IOV: Use VF0 cached config space size for
> > other VFs") attempts to cache the config space size of VF0 to re-use
> > for all other VFs, but the cache is setup before the call to
> > pci_setup_device(), where we use set_pcie_port_type() to setup the
> > pcie_cap field on the struct pci_dev.  Without pcie_cap configured,
> > pci_cfg_space_size() returns PCI_CFG_SPACE_SIZE for the size.  VF0
> > has a bypass through pci_cfg_space_size(), so its size is reported
> > correctly, but all subsequent VFs incorrectly report 256 bytes of
> > config space.
> > 
> > Resolve by delaying pci_read_vf_config_common() until after
> > pci_setup_device().
> > 
> > Fixes: 975bb8b4dc93 ("PCI/IOV: Use VF0 cached config space size for other VFs")
> > Link: https://bugzilla.redhat.com/show_bug.cgi?id=1714978
> > Cc: KarimAllah Ahmed <karahmed@amazon.de>
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > ---
> >  drivers/pci/iov.c |    6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> > index 3aa115ed3a65..34b1f78f4d31 100644
> > --- a/drivers/pci/iov.c
> > +++ b/drivers/pci/iov.c
> > @@ -161,13 +161,13 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
> >  	virtfn->is_virtfn = 1;
> >  	virtfn->physfn = pci_dev_get(dev);
> >  
> > -	if (id == 0)
> > -		pci_read_vf_config_common(virtfn);
> > -
> >  	rc = pci_setup_device(virtfn);
> >  	if (rc)
> >  		goto failed1;
> >  
> > +	if (id == 0)
> > +		pci_read_vf_config_common(virtfn);
> > +
> >  	virtfn->dev.parent = dev->dev.parent;
> >  	virtfn->multifunction = 0;
> 
> Would it actually make more sense to revert 975bb8b4dc93 and just
> assume any is_virtfn device has PCI_CFG_SPACE_EXP_SIZE for cfg_size?
> Per the SR-IOV spec, VFs are required to implement a PCIe capability,
> which should imply 4K of config space.  The reachability of that
> extended config space seems unnecessary to test if we assume that it
> has the same characteristics as the PF, which must be reachable if
> we're able to enable SR-IOV.  Thoughts?  Thanks,

I like this idea.

I first thought maybe we'd still be susceptible to the gotchas
described in the pci_cfg_space_size_ext() comment, i.e., we might not
have a way to generate extended config space accesses, or the device
might be behind a reverse Express bridge.

But as you say, SR-IOV is an extended capability that must be located
at config offset 0x100 or greater, so the fact that we have a VF at
all means we must be able to reach it.

Bjorn
