Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87C9244EEB
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2019 00:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbfFMWBN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jun 2019 18:01:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59552 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbfFMWBN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Jun 2019 18:01:13 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8D0C4307D90D;
        Thu, 13 Jun 2019 22:01:12 +0000 (UTC)
Received: from x1.home (ovpn-116-190.phx2.redhat.com [10.3.116.190])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0EB305C54A;
        Thu, 13 Jun 2019 22:01:09 +0000 (UTC)
Date:   Thu, 13 Jun 2019 16:01:09 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, KarimAllah Ahmed <karahmed@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/IOV: Fix VF cfg_size
Message-ID: <20190613160109.23e1747c@x1.home>
In-Reply-To: <20190613212039.GL13533@google.com>
References: <155966918965.10361.16228304474160813310.stgit@gimli.home>
        <20190604143617.0a226555@x1.home>
        <20190613212039.GL13533@google.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 13 Jun 2019 22:01:12 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 13 Jun 2019 16:20:39 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Tue, Jun 04, 2019 at 02:36:17PM -0600, Alex Williamson wrote:
> > On Tue, 04 Jun 2019 11:26:42 -0600
> > Alex Williamson <alex.williamson@redhat.com> wrote:
> >   
> > > Commit 975bb8b4dc93 ("PCI/IOV: Use VF0 cached config space size for
> > > other VFs") attempts to cache the config space size of VF0 to re-use
> > > for all other VFs, but the cache is setup before the call to
> > > pci_setup_device(), where we use set_pcie_port_type() to setup the
> > > pcie_cap field on the struct pci_dev.  Without pcie_cap configured,
> > > pci_cfg_space_size() returns PCI_CFG_SPACE_SIZE for the size.  VF0
> > > has a bypass through pci_cfg_space_size(), so its size is reported
> > > correctly, but all subsequent VFs incorrectly report 256 bytes of
> > > config space.
> > > 
> > > Resolve by delaying pci_read_vf_config_common() until after
> > > pci_setup_device().
> > > 
> > > Fixes: 975bb8b4dc93 ("PCI/IOV: Use VF0 cached config space size for other VFs")
> > > Link: https://bugzilla.redhat.com/show_bug.cgi?id=1714978
> > > Cc: KarimAllah Ahmed <karahmed@amazon.de>
> > > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > > ---
> > >  drivers/pci/iov.c |    6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> > > index 3aa115ed3a65..34b1f78f4d31 100644
> > > --- a/drivers/pci/iov.c
> > > +++ b/drivers/pci/iov.c
> > > @@ -161,13 +161,13 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
> > >  	virtfn->is_virtfn = 1;
> > >  	virtfn->physfn = pci_dev_get(dev);
> > >  
> > > -	if (id == 0)
> > > -		pci_read_vf_config_common(virtfn);
> > > -
> > >  	rc = pci_setup_device(virtfn);
> > >  	if (rc)
> > >  		goto failed1;
> > >  
> > > +	if (id == 0)
> > > +		pci_read_vf_config_common(virtfn);
> > > +
> > >  	virtfn->dev.parent = dev->dev.parent;
> > >  	virtfn->multifunction = 0;  
> > 
> > Would it actually make more sense to revert 975bb8b4dc93 and just
> > assume any is_virtfn device has PCI_CFG_SPACE_EXP_SIZE for cfg_size?
> > Per the SR-IOV spec, VFs are required to implement a PCIe capability,
> > which should imply 4K of config space.  The reachability of that
> > extended config space seems unnecessary to test if we assume that it
> > has the same characteristics as the PF, which must be reachable if
> > we're able to enable SR-IOV.  Thoughts?  Thanks,  
> 
> I like this idea.
> 
> I first thought maybe we'd still be susceptible to the gotchas
> described in the pci_cfg_space_size_ext() comment, i.e., we might not
> have a way to generate extended config space accesses, or the device
> might be behind a reverse Express bridge.
> 
> But as you say, SR-IOV is an extended capability that must be located
> at config offset 0x100 or greater, so the fact that we have a VF at
> all means we must be able to reach it.

Cool, I'll send a patch shortly.  Thanks,

Alex
