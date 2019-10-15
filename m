Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11116D8107
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2019 22:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbfJOUa3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Oct 2019 16:30:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:43770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727994AbfJOUa3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Oct 2019 16:30:29 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBB7220872;
        Tue, 15 Oct 2019 20:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571171428;
        bh=f1U9OX+iCP4z8AJSrKneFtP475IqeMrFKyKimqU+Aeg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=k5ddW1F0HpOhT5Lp+UnxLwmTZro6HhItRvSJqJ+Ufb3NXb2MLYhJv3gZltLq58Ixy
         ySg2xbtr0AP9Lcv+amNUoS5mMpZJ4vdsuGrsUcG/0EkDz/n+TDWFVpkDJRTNN6ZcD2
         eqtvI2DeKb7LVYCySmM1kVmHMmd9UwTuAPDZ3yDc=
Date:   Tue, 15 Oct 2019 15:30:26 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Frederick Lawler <fred@fredlawl.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatja@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v7 0/5] PCI/ASPM: Add sysfs attributes for controlling
 ASPM
Message-ID: <20191015203026.GA130300@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a13d431-2b6f-4874-c959-9d0bad4fba53@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 10, 2019 at 10:45:52PM +0200, Heiner Kallweit wrote:
> On 10.10.2019 15:22, Bjorn Helgaas wrote:
> > On Tue, Oct 08, 2019 at 05:10:40PM -0500, Bjorn Helgaas wrote:
> >> On Sat, Oct 05, 2019 at 02:02:29PM +0200, Heiner Kallweit wrote:
> >>> Background of this extension is a problem with the r8169 network driver.
> >>> Several combinations of board chipsets and network chip versions have
> >>> problems if ASPM is enabled, therefore we have to disable ASPM per
> >>> default. However especially on notebooks ASPM can provide significant
> >>> power-saving, therefore we want to give users the option to enable
> >>> ASPM. With the new sysfs attributes users can control which ASPM
> >>> link-states are disabled.
> >>>
> >>> v2:
> >>> - use a dedicated sysfs attribute per link state
> >>> - allow separate control of ASPM and PCI PM L1 sub-states
> >>>
> >>> v3:
> >>> - patch 3: statically allocate the attribute group
> >>> - patch 3: replace snprintf with printf
> >>> - add patch 4
> >>>
> >>> v4:
> >>> - patch 3: add call to sysfs_update_group because is_visible callback
> >>>            returns false always at file creation time
> >>> - patch 3: simplify code a little
> >>>
> >>> v5:
> >>> - rebased to latest pci/next
> >>>
> >>> v6:
> >>> - patch 3: consider several review comments from Bjorn
> >>> - patch 4: add discussion link to commit message
> >>>
> >>> v7:
> >>> - Move adding pcie_aspm_get_link() to separate patch 3
> >>> - patch 4: change group name from aspm to link_pm
> >>> - patch 4: control visibility of attributes individually
> >>>
> >>> Heiner Kallweit (5):
> >>>   PCI/ASPM: add L1 sub-state support to pci_disable_link_state
> >>>   PCI/ASPM: allow to re-enable Clock PM
> >>>   PCI/ASPM: Add and use helper pcie_aspm_get_link
> >>>   PCI/ASPM: Add sysfs attributes for controlling ASPM link states
> >>>   PCI/ASPM: Remove Kconfig option PCIEASPM_DEBUG and related code
> >>>
> >>>  Documentation/ABI/testing/sysfs-bus-pci |  14 ++
> >>>  drivers/pci/pci-sysfs.c                 |   6 +-
> >>>  drivers/pci/pci.h                       |  12 +-
> >>>  drivers/pci/pcie/Kconfig                |   7 -
> >>>  drivers/pci/pcie/aspm.c                 | 252 ++++++++++++++++--------
> >>>  include/linux/pci.h                     |  10 +-
> >>>  6 files changed, 199 insertions(+), 102 deletions(-)
> >>
> >> I applied these to pci/aspm for v5.5.  Thank you very much for all the
> >> work you put into this!
> >>
> >> There are a couple questions that are still open, but I have no
> >> problem if we want to make minor tweaks before the merge window opens.
> > 
> > To resolve these open questions, I propose the diff below, which:
> > 
> >   - Makes pcie_aspm_get_link() work only when called for an Upstream
> >     Port (Endpoint, Switch Upstream Port, or other component at the
> >     downstream end of a Link).  I don't think there's any caller that
> >     needs to supply the upstream end.
> > 
> >   - Makes pcie_aspm_get_link() check that both ends are PCIe devices.
> >     This might be overkill, but we can't rely on the PCI topology
> >     being "correct", e.g., we have to deal gracefully with a
> >     virtualization or similar scenario where a bridge is PCI and the
> >     child is PCIe.  In that case, we shouldn't try to manage ASPM, so
> >     we don't need a link_state, but I couldn't quite convince myself
> >     that pcie_aspm_init_link_state() handles these cases.
> > 
> >   - Removes the aspm_lock from the sysfs show functions.  Per the
> >     discussion with Rafael, I don't think it's necessary there:
> > 
> >       https://lore.kernel.org/r/20191007223428.GA72605@google.com
> > 
> >     I didn't remove it from the store functions because they do ASPM
> >     reconfiguration and I didn't try to figure out the locking there.
> > 
> > Let me know what you think about this.  If it looks right, I'll just
> > squash these changes into the relevant patches.
> > 
> Looks good to me. Thanks, Heiner

Thanks, I squashed these in and updated pci/aspm.
