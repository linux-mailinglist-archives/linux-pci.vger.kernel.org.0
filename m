Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3F7C9421
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2019 00:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfJBWK4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Oct 2019 18:10:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:51638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726128AbfJBWK4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Oct 2019 18:10:56 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97DD320659;
        Wed,  2 Oct 2019 22:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570054255;
        bh=Y9MkvBqplkZaMVNOADcx0iSmLR1BK1+qhTrHy72V/tk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ls8Rriu+SgP//dE5aghDxFo3hzJH8nqHM9TEs7eCjZScsto9tNFNg370QpemPXcqh
         +hdM6bheGeVESsA2c7iB8PviAag3PlgXnTuOHVC2QeAVYswndtl9ltAG9J0jCKrmCb
         +0F/ezkxmW+VpoQIfpvzgRbboWhh7pIe9OBvqQfg=
Date:   Wed, 2 Oct 2019 17:10:54 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Frederick Lawler <fred@fredlawl.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatja@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v5 3/4] PCI/ASPM: add sysfs attributes for controlling
 ASPM link states
Message-ID: <20191002221054.GA71395@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4d86993-46fc-ef15-8c7a-6e5e049a3065@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 02, 2019 at 11:10:55PM +0200, Heiner Kallweit wrote:
> On 02.10.2019 21:55, Bjorn Helgaas wrote:
> > On Sun, Sep 29, 2019 at 07:15:05PM +0200, Heiner Kallweit wrote:
> >> On 07.09.2019 22:32, Bjorn Helgaas wrote:
> >>> On Sat, Aug 31, 2019 at 10:20:47PM +0200, Heiner Kallweit wrote:

> >>>> +static struct pcie_link_state *aspm_get_parent_link(struct pci_dev *pdev)
> >>>
> >>> I know the ASPM code is pretty confused, but I don't think "parent
> >>> link" really makes sense.  "Parent" implies a parent/child
> >>> relationship, but a link doesn't have a parent or a child; it only has
> >>> an upstream end and a downstream end.
> >>>
> >> I basically copied this "parent" stuff from __pci_disable_link_state.
> >> Fine with me to change the naming.
> >> What confuses me a little is that we have different versions of getting
> >> the pcie_link_state for a pci_dev in:
> >>
> >> - this new function of mine
> >> - __pci_disable_link_state
> >> - pcie_aspm_enabled
> >>
> >> The latter uses pci_upstream_bridge instead of accessing pdev->bus->self
> >> directly and doesn't include the call to pcie_downstream_port.
> >> I wonder whether the functionality could be factored out to a generic
> >> helper that works in all these places.
> > 
> > Definitely.  I think your pcie_aspm_get_link() (from the v6 patch)
> > could be used directly in those places.  You could add a new patch
> > that just adds pcie_aspm_get_link() and uses it.
> > 
> 
> OK
> 
> >>>> +{
> >>>> +	struct pci_dev *parent = pdev->bus->self;
> >>>> +
> >>>> +	if (pcie_downstream_port(pdev))
> >>>> +		parent = pdev;
> >>>> +
> >>>> +	return parent ? parent->link_state : NULL;
> >>>> +}
> >>>> +
> >>>> +static bool pcie_check_valid_aspm_endpoint(struct pci_dev *pdev)
> >>>> +{
> >>>> +	struct pcie_link_state *link;
> >>>> +
> >>>> +	if (!pci_is_pcie(pdev) || pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT)
> >>>
> >>> Do you intend to exclude other Upstream Ports like Legacy Endpoints,
> >>> Upstream Switch Ports, and PCIe-to-PCI/PCI-X Bridges?  They also have
> >>> a link leading to them, so we might want them to have knobs as well.
> >>> Or if we don't want the knobs, a comment about why not would be
> >>> useful.
> >>>
> >> My use case is about endpoints only and I'm not really a PCI expert.
> >> Based on your list in addition to PCI_EXP_TYPE_ENDPOINT we'd enable
> >> the ASPM sysfs fils for:
> >> - PCI_EXP_TYPE_LEG_END
> >> - PCI_EXP_TYPE_UPSTREAM
> >> - PCI_EXP_TYPE_PCI_BRIDGE
> >> - PCI_EXP_TYPE_PCIE_BRIDGE
> >> If you can confirm the list I'd extend my patch accordingly.
> > 
> > Yes, I think the list would be right, but looking at this again, I
> > don't think you need this function at all -- you can just use
> > pcie_aspm_get_link().  Then aspm_ctrl_attrs_are_visible() uses exactly
> > the same test as the show/store functions.  Actually, I think then you
> > could omit the "if (!link)" tests from the show/store functions
> > because those functions can never be called unless
> > aspm_ctrl_attrs_are_visible() found a link.
> > 
> Right, the !link checks can be removed from the show/store functions.
> In pcie_is_aspm_dev() I think we need to check at least whether
> device is PCIe and whether link is ASPM-capable. Making the sysfs
> attributes visible for a non-PCIe device doesn't make sense,
> the same applies to PCIe devices with a link that is not ASPM-capable.

I agree we don't want these attributes visible for non-PCIe or
non-ASPM-capable situations, but I think you can do this:

  static struct pcie_link_state *pcie_aspm_get_link(struct pci_dev *pdev)
  {
    struct pci_dev *bridge = pci_upstream_bridge(pdev);

    if (bridge)
      return bridge->link_state;

    return NULL;
  }

  static umode_t aspm_ctrl_attrs_are_visible(...)
  {
    ...
    if (pcie_aspm_get_link(pdev))
      return a->mode;

    return 0;
  }

We can rely on pcie_aspm_init_link_state() to only set
bridge->link_state if the devices on both ends of the link are PCIe
and support ASPM.
