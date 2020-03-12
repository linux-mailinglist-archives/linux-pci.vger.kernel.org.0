Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 175E0183C9B
	for <lists+linux-pci@lfdr.de>; Thu, 12 Mar 2020 23:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgCLWgy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Mar 2020 18:36:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:53676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbgCLWgy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Mar 2020 18:36:54 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D20720716;
        Thu, 12 Mar 2020 22:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584052613;
        bh=Mw6mvQtiU1SMRyM0DpwBs+f6ymAnPty4GMG0fmVIDyU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=AJ4GOOAPB5NDv/dF15aRAnGIPDNGoatoF5uCg0OCidh3mlZDA9IiD8p04viY8CcXl
         bVCIviAu6z7DAyWKsNTLjBD2/lmLeGXaJHOyu4J2jlgbCjBSZwT+Bf+ECFetUC2LVr
         N/mnPmp+9+JDvPtTKXcV8qRFSgmY9j2UiJ5gEnIw=
Date:   Thu, 12 Mar 2020 17:36:51 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Austin.Bolen@dell.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com
Subject: Re: [PATCH v17 09/12] PCI/AER: Allow clearing Error Status Register
 in FF mode
Message-ID: <20200312223651.GA202733@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e710fd4c-4c0e-448a-6791-beed334536ce@linux.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 12, 2020 at 03:02:07PM -0700, Kuppuswamy Sathyanarayanan wrote:
> On 3/12/20 2:52 PM, Bjorn Helgaas wrote:
> > On Thu, Mar 12, 2020 at 02:29:58PM -0700, Kuppuswamy Sathyanarayanan wrote:
> > > On 3/12/20 2:02 PM, Austin.Bolen@dell.com wrote:
> > > > On 3/12/2020 2:53 PM, Bjorn Helgaas wrote:
> > > > > On Wed, Mar 11, 2020 at 04:07:59PM -0700, Kuppuswamy Sathyanarayanan wrote:
> > > > > > On 3/11/20 3:23 PM, Bjorn Helgaas wrote:
> > > > > > > Is any synchronization needed here between the EDR path and the
> > > > > > > hotplug/enumeration path?
> > > > > > If we want to follow the implementation note step by step (in
> > > > > > sequence) then we need some synchronization between EDR path and
> > > > > > enumeration path. But if it's OK to achieve the same end result by
> > > > > > following steps out of sequence then we don't need to create any
> > > > > > dependency between EDR and enumeration paths. Currently we follow
> > > > > > the latter approach.
> > > > > What would the synchronization look like?
> > > > > 
> > > > > Ideally I think it would be better to follow the order in the
> > > > > flowchart if it's not too onerous.  That will make the code easier to
> > > > > understand.  The current situation with this dependency on pciehp and
> > > > > what it will do leaves a lot of things implicit.
> > > > > 
> > > > > What happens if CONFIG_PCIE_EDR=y but CONFIG_HOTPLUG_PCI_PCIE=n?
> > > > > 
> > > > > IIUC, when DPC triggers, pciehp is what fields the DLLSC interrupt and
> > > > > unbinds the drivers and removes the devices.  If that doesn't happen,
> > > > > and Linux clears the DPC trigger to bring the link back up, will those
> > > > > drivers try to operate uninitialized devices?
> > > > > 
> > > > > Does EDR need a dependency on CONFIG_HOTPLUG_PCI_PCIE?
> > > >    From one of Sathya's other responses:
> > > > 
> > > > "If hotplug is not supported then there is support to enumerate
> > > > devices via polling  or ACPI events. But a point to note
> > > > here is, enumeration path is independent of error handler path, and
> > > > hence there is no explicit trigger or event from error handler path
> > > > to enumeration path to kick start the enumeration."
> > > > 
> > > > The EDR standard doesn't have any dependency on hot-plug. It sounds like
> > > > in the current implementation there's some manual intervention needed if
> > > > hot-plug is not supported?
> > >
> > > No, there is no need for manual intervention even in non hotplug
> > > cases.
> > > 
> > > For ACPI events case, we would rely on ACPI event to kick start the
> > > enumeration.  And for polling model, there is an independent polling
> > > thread which will kick start the enumeration.
>
> > I'm guessing the ACPI case works via hotplug_is_native(): if
> > CONFIG_HOTPLUG_PCI_PCIE=n, pciehp_is_native() returns false, and
> > acpiphp manages hotplug.
> > 
> > What if CONFIG_HOTPLUG_PCI_ACPI=n also?
>
> If none of the auto scans are enabled then we might need some
> manual trigger (rescan). But this would be needed in native
> DPC case as well.
> > 
> > Where is the polling thread?
>
> drivers/pci/hotplug/pciehp_hpc.c

Only if CONFIG_HOTPLUG_PCI_PCIE=y, obviously.  My question is about
what happens when CONFIG_HOTPLUG_PCI_PCIE=n.

I'm not as concerned about requiring a manual rescan.  That's
inconvenient, but doesn't seem like a big deal because that's what you
expect with no hotplug driver.

What I *am* worried about is calling driver callbacks on a device that
has been reset but not initialized.  That could cause all sorts of
havoc because the driver thinks it can trust BARs and other
configuration.
