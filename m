Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE638C92AD
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2019 21:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbfJBTzp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Oct 2019 15:55:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:47696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728428AbfJBTzp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Oct 2019 15:55:45 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7CD22133F;
        Wed,  2 Oct 2019 19:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570046144;
        bh=k7uI8oOKDXg+B+RG7jgWe6X7b/Iv2JUU9lk3BI5jEIQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=AJ2Yt+6+1x+QFqMtm605hydnSr5kqq10gZooH1WyMnZn9gA/HGNmzKmtXUaQSJkK7
         w8K4f+vQ9nHG4hYhJR5GQKt3ZooPErsuW1fNkWs+Csk/u/SAJFLVwRPawlg/FkEpch
         xL42HNsNpacP/W8f76KlvzIklyWmjvULLWtW9U3U=
Date:   Wed, 2 Oct 2019 14:55:41 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Frederick Lawler <fred@fredlawl.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatja@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v5 3/4] PCI/ASPM: add sysfs attributes for controlling
 ASPM link states
Message-ID: <20191002195541.GA49632@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a12e0e2c-dcb8-9ec5-cf10-1029732a00fb@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Sep 29, 2019 at 07:15:05PM +0200, Heiner Kallweit wrote:
> On 07.09.2019 22:32, Bjorn Helgaas wrote:
> > On Sat, Aug 31, 2019 at 10:20:47PM +0200, Heiner Kallweit wrote:
> >> Background of this extension is a problem with the r8169 network driver.
> >> Several combinations of board chipsets and network chip versions have
> >> problems if ASPM is enabled, therefore we have to disable ASPM per default.
> >> However especially on notebooks ASPM can provide significant power-saving,
> >> therefore we want to give users the option to enable ASPM. With the new
> >> sysfs attributes users can control which ASPM link-states are
> >> enabled/disabled.
> >>
> >> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> >> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >> ---
> >> v2:
> >> - use a dedicated sysfs attribute per link state
> >> - allow separate control of ASPM and PCI PM L1 sub-states
> >> v3:
> >> - statically allocate the attribute group
> >> - replace snprintf with printf
> >> - base on top of "PCI: Make pcie_downstream_port() available outside of access.c"
> >> v4:
> >> - add call to sysfs_update_group because is_visible callback returns false
> >>   always at file creation time
> >> - simplify code a little
> >> v5:
> >> - rebased to latest pci/next
> >> ---
> >>  Documentation/ABI/testing/sysfs-bus-pci |  13 ++
> >>  drivers/pci/pci-sysfs.c                 |   7 +
> >>  drivers/pci/pci.h                       |   4 +
> >>  drivers/pci/pcie/aspm.c                 | 184 ++++++++++++++++++++++++
> >>  4 files changed, 208 insertions(+)
> >>
> >> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> >> index 8bfee557e..49249a165 100644
> >> --- a/Documentation/ABI/testing/sysfs-bus-pci
> >> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> >> @@ -347,3 +347,16 @@ Description:
> >>  		If the device has any Peer-to-Peer memory registered, this
> >>  	        file contains a '1' if the memory has been published for
> >>  		use outside the driver that owns the device.
> >> +
> >> +What		/sys/bus/pci/devices/.../aspm/aspm_l0s
> >> +What		/sys/bus/pci/devices/.../aspm/aspm_l1
> >> +What		/sys/bus/pci/devices/.../aspm/aspm_l1_1
> >> +What		/sys/bus/pci/devices/.../aspm/aspm_l1_2
> >> +What		/sys/bus/pci/devices/.../aspm/aspm_l1_1_pcipm
> >> +What		/sys/bus/pci/devices/.../aspm/aspm_l1_2_pcipm
> >> +What		/sys/bus/pci/devices/.../aspm/aspm_clkpm
> >> +date:		August 2019

I didn't notice this before, but I wonder if one "aspm" in these paths
would be enough?  E.g., /sys/bus/pci/devices/.../aspm/l0s?

> >> @@ -1315,6 +1315,10 @@ static int pci_create_capabilities_sysfs(struct pci_dev *dev)
> >>  
> >>  	pcie_vpd_create_sysfs_dev_files(dev);
> >>  	pcie_aspm_create_sysfs_dev_files(dev);
> >> +#ifdef CONFIG_PCIEASPM
> >> +	/* update visibility of attributes in this group */
> >> +	sysfs_update_group(&dev->dev.kobj, &aspm_ctrl_attr_group);
> >> +#endif
> > 
> > Isn't there a way to do this in drivers/pci/pcie/aspm.c somehow,
> > without using sysfs_update_group()?  There are only three callers of
> > it in the tree, and I'd be surprised if ASPM is unique enough to have
> > to be the fourth.
> > 
> At least I didn't find any. Reason seems to be the following:
> Static sysfs files are created in pci_scan_single_device ->
> pci_device_add. And pci_scan_slot calls pci_scan_single_device
> before calling pcie_aspm_init_link_state(bus->self).
> Means the pcie_link_state doesn't exist yet and we have to update
> visibility of the ASPM sysfs files later.

Ah, I see.  I think it's this call graph:

  pci_scan_slot
    pci_scan_single_device
      pci_scan_device
      pci_device_add
	pci_init_capabilities
	device_add
	  device_add_attrs
	    device_add_groups(dev->type->groups)
	      sysfs_create_groups         # <-- sysfs files created
    pcie_aspm_init_link_state(bridge)     # <-- link_states allocated

I think this part of the ASPM code is a little bit broken -- we wait
to initialize ASPM until we've enumerated all the devices on the link.
I think it would be better to initialize it somewhere in
pci_device_add(), maybe pci_init_capabilities(), which would solve
this ordering problem.  That's a pretty big project that can be done
later.

But I *think* we should be able to at least move the
sysfs_update_group() to the end of pcie_aspm_init_link_state().  We'd
have to iterate over the subordinate->devices, but it would at least
be in the ASPM code where we'll see it if/when we rework the
initialization.

> >> +static struct pcie_link_state *aspm_get_parent_link(struct pci_dev *pdev)
> > 
> > I know the ASPM code is pretty confused, but I don't think "parent
> > link" really makes sense.  "Parent" implies a parent/child
> > relationship, but a link doesn't have a parent or a child; it only has
> > an upstream end and a downstream end.
> > 
> I basically copied this "parent" stuff from __pci_disable_link_state.
> Fine with me to change the naming.
> What confuses me a little is that we have different versions of getting
> the pcie_link_state for a pci_dev in:
> 
> - this new function of mine
> - __pci_disable_link_state
> - pcie_aspm_enabled
> 
> The latter uses pci_upstream_bridge instead of accessing pdev->bus->self
> directly and doesn't include the call to pcie_downstream_port.
> I wonder whether the functionality could be factored out to a generic
> helper that works in all these places.

Definitely.  I think your pcie_aspm_get_link() (from the v6 patch)
could be used directly in those places.  You could add a new patch
that just adds pcie_aspm_get_link() and uses it.

> >> +{
> >> +	struct pci_dev *parent = pdev->bus->self;
> >> +
> >> +	if (pcie_downstream_port(pdev))
> >> +		parent = pdev;
> >> +
> >> +	return parent ? parent->link_state : NULL;
> >> +}
> >> +
> >> +static bool pcie_check_valid_aspm_endpoint(struct pci_dev *pdev)
> >> +{
> >> +	struct pcie_link_state *link;
> >> +
> >> +	if (!pci_is_pcie(pdev) || pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT)
> > 
> > Do you intend to exclude other Upstream Ports like Legacy Endpoints,
> > Upstream Switch Ports, and PCIe-to-PCI/PCI-X Bridges?  They also have
> > a link leading to them, so we might want them to have knobs as well.
> > Or if we don't want the knobs, a comment about why not would be
> > useful.
> > 
> My use case is about endpoints only and I'm not really a PCI expert.
> Based on your list in addition to PCI_EXP_TYPE_ENDPOINT we'd enable
> the ASPM sysfs fils for:
> - PCI_EXP_TYPE_LEG_END
> - PCI_EXP_TYPE_UPSTREAM
> - PCI_EXP_TYPE_PCI_BRIDGE
> - PCI_EXP_TYPE_PCIE_BRIDGE
> If you can confirm the list I'd extend my patch accordingly.

Yes, I think the list would be right, but looking at this again, I
don't think you need this function at all -- you can just use
pcie_aspm_get_link().  Then aspm_ctrl_attrs_are_visible() uses exactly
the same test as the show/store functions.  Actually, I think then you
could omit the "if (!link)" tests from the show/store functions
because those functions can never be called unless
aspm_ctrl_attrs_are_visible() found a link.

Bjorn
