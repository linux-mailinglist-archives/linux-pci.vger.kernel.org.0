Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1F1C183BC0
	for <lists+linux-pci@lfdr.de>; Thu, 12 Mar 2020 22:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgCLVwd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Mar 2020 17:52:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:39450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbgCLVwd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Mar 2020 17:52:33 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4B37206FA;
        Thu, 12 Mar 2020 21:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584049952;
        bh=xetrKM6LDYJ9gs1w1p1i3KvxcG9WdpkyTnxKOTfJ158=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=iZDruLD/esx01jsUaVmBEENE8s1u6DrLkuszVaBGC2W54LhJI9AiseKPc1pJfacrE
         /PZ5njJR4xDh9yofvVSEWRDLrJNTSGIB/O145PIkSJOpjW9gbsS+rLI2eVSWENjm67
         8pV7sF+5vdHXa2d42HQahTtTvprQ3Ei21Ytsgunk=
Date:   Thu, 12 Mar 2020 16:52:30 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Austin.Bolen@dell.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com
Subject: Re: [PATCH v17 09/12] PCI/AER: Allow clearing Error Status Register
 in FF mode
Message-ID: <20200312215230.GA195113@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f07d850f-473f-6fa0-81f3-b38a104a5e86@linux.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 12, 2020 at 02:29:58PM -0700, Kuppuswamy Sathyanarayanan wrote:
> Hi,
> 
> On 3/12/20 2:02 PM, Austin.Bolen@dell.com wrote:
> > On 3/12/2020 2:53 PM, Bjorn Helgaas wrote:
> > > On Wed, Mar 11, 2020 at 04:07:59PM -0700, Kuppuswamy Sathyanarayanan wrote:
> > > > On 3/11/20 3:23 PM, Bjorn Helgaas wrote:
> > > > > Is any synchronization needed here between the EDR path and the
> > > > > hotplug/enumeration path?
> > > > If we want to follow the implementation note step by step (in
> > > > sequence) then we need some synchronization between EDR path and
> > > > enumeration path. But if it's OK to achieve the same end result by
> > > > following steps out of sequence then we don't need to create any
> > > > dependency between EDR and enumeration paths. Currently we follow
> > > > the latter approach.
> > > What would the synchronization look like?
> > > 
> > > Ideally I think it would be better to follow the order in the
> > > flowchart if it's not too onerous.  That will make the code easier to
> > > understand.  The current situation with this dependency on pciehp and
> > > what it will do leaves a lot of things implicit.
> > > 
> > > What happens if CONFIG_PCIE_EDR=y but CONFIG_HOTPLUG_PCI_PCIE=n?
> > > 
> > > IIUC, when DPC triggers, pciehp is what fields the DLLSC interrupt and
> > > unbinds the drivers and removes the devices.  If that doesn't happen,
> > > and Linux clears the DPC trigger to bring the link back up, will those
> > > drivers try to operate uninitialized devices?
> > > 
> > > Does EDR need a dependency on CONFIG_HOTPLUG_PCI_PCIE?
> >   From one of Sathya's other responses:
> > 
> > "If hotplug is not supported then there is support to enumerate
> > devices via polling  or ACPI events. But a point to note
> > here is, enumeration path is independent of error handler path, and
> > hence there is no explicit trigger or event from error handler path
> > to enumeration path to kick start the enumeration."
> > 
> > The EDR standard doesn't have any dependency on hot-plug. It sounds like
> > in the current implementation there's some manual intervention needed if
> > hot-plug is not supported?
> No, there is no need for manual intervention even in non hotplug
> cases.
> 
> For ACPI events case, we would rely on ACPI event to kick start the
> enumeration.  And for polling model, there is an independent polling
> thread which will kick start the enumeration.

I'm guessing the ACPI case works via hotplug_is_native(): if
CONFIG_HOTPLUG_PCI_PCIE=n, pciehp_is_native() returns false, and
acpiphp manages hotplug.

What if CONFIG_HOTPLUG_PCI_ACPI=n also?

Where is the polling thread?

> Above both enumeration models are totally independent and has
> no dependency on error handler thread.

I see they're currently independent from the EDR thread, but it's not
clear to me that there's no dependency.  After all, both EDR and the
hotplug paths are operating on the same devices at roughly the same
time, so we should have some story about what keeps them from getting
in each other's way.

> We will decide which model to use based on hardware capability and
> _OSC negotiation or kernel command line option.
