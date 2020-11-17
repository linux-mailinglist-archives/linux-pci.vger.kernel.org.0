Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5EBE2B5A10
	for <lists+linux-pci@lfdr.de>; Tue, 17 Nov 2020 08:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725792AbgKQHGu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Nov 2020 02:06:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:33038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbgKQHGu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Nov 2020 02:06:50 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 643652468B;
        Tue, 17 Nov 2020 07:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605596809;
        bh=8nY/+Dx9Rpa1K9sH7caYooYxMuu+2IkVP4yXeEJM/kk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VYlyMMJOqYbuTUHpNd+NpK7EKDHBakxofPqPYq/fa/CRg4l4HedTx6oPqImNUpdza
         N/RA7xRHfrVw+/L4fv57TsXs+VtTdTajpwOoU9Y41Lwy1zRbbbcm032gOLMQ6+3POY
         Gts1OdmyaXXEN8f+4yz0n84b34RcJc68HaZz/wD8=
Date:   Tue, 17 Nov 2020 08:07:37 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stuart Hayes <stuart.w.hayes@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v2] Expose PCIe SSD Status LED Management DSM in sysfs
Message-ID: <X7N2uU1M4j1k78D1@kroah.com>
References: <20201110153735.58587-1-stuart.w.hayes@gmail.com>
 <20201113213842.GA1135242@bjorn-Precision-5520>
 <X68Ub0rSmUlrRXkm@kroah.com>
 <371228ef-7b31-0c70-c9a4-a0f0082da920@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <371228ef-7b31-0c70-c9a4-a0f0082da920@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 16, 2020 at 04:25:57PM -0600, Stuart Hayes wrote:
> 
> 
> On 11/13/20 5:19 PM, Greg Kroah-Hartman wrote:
> > On Fri, Nov 13, 2020 at 03:38:42PM -0600, Bjorn Helgaas wrote:
> >> [+cc Christoph, Dan, Greg (for "one value per file" question below)]
> >>
> >> On Tue, Nov 10, 2020 at 09:37:35AM -0600, Stuart Hayes wrote:
> >>> This patch will expose the PCIe SSD Status LED Management interface in
> >>> sysfs for devices that have the relevant _DSM method, per the "_DSM
> >>> additions for PCIe SSD Status LED Management" ECN to the PCI Firmware
> >>> Specification revision 3.2.
> >>>
> >>> The interface is exposed in two sysfs files, ssdleds_supported_states (RO)
> >>> and ssdleds_current_state (RW).
> >>>
> >>> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> >>> ---
> >>>
> >>> v2: made PCI_SSDLEDS dependent on PCI and ACPI
> >>>     remove unused variable
> >>>     warn if call to sysfs_create_group fails
> >>>     include header file with function prototypes
> >>>     change logical OR to bitwise
> >>>
> >>> ---
> >>>  Documentation/ABI/testing/sysfs-bus-pci |  14 ++
> >>>  drivers/pci/Kconfig                     |   7 +
> >>>  drivers/pci/Makefile                    |   1 +
> >>>  drivers/pci/pci-ssdleds.c               | 194 ++++++++++++++++++++++++
> >>>  drivers/pci/pci-sysfs.c                 |   1 +
> >>>  drivers/pci/pci.h                       |  11 ++
> >>>  6 files changed, 228 insertions(+)
> >>>  create mode 100644 drivers/pci/pci-ssdleds.c
> >>>
> >>> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> >>> index 77ad9ec3c801..18ca73b764ac 100644
> >>> --- a/Documentation/ABI/testing/sysfs-bus-pci
> >>> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> >>> @@ -366,3 +366,17 @@ Contact:	Heiner Kallweit <hkallweit1@gmail.com>
> >>>  Description:	If ASPM is supported for an endpoint, these files can be
> >>>  		used to disable or enable the individual power management
> >>>  		states. Write y/1/on to enable, n/0/off to disable.
> >>> +
> >>> +What:		/sys/bus/pci/devices/.../ssdleds_supported_states
> >>> +Date:		October 2020
> >>> +Contact:	Stuart Hayes <stuart.w.hayes@gmail.com>
> >>> +Description:	If the device supports the ACPI _DSM method to control the
> >>> +		PCIe SSD LED states, ssdleds_supported_states (read only)
> >>> +		will show the LED states that are supported by the _DSM.
> >>> +
> >>> +What:		/sys/bus/pci/devices/.../ssdleds_current_state
> >>> +Date:		October 2020
> >>> +Contact:	Stuart Hayes <stuart.w.hayes@gmail.com>
> >>> +Description:	If the device supports the ACPI _DSM method to control the
> >>> +		PCIe SSD LED states, ssdleds_current_state will show or set
> >>> +		the current LED states that are active.
> >>> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> >>> index 0c473d75e625..48049866145f 100644
> >>> --- a/drivers/pci/Kconfig
> >>> +++ b/drivers/pci/Kconfig
> >>> @@ -182,6 +182,13 @@ config PCI_LABEL
> >>>  	def_bool y if (DMI || ACPI)
> >>>  	select NLS
> >>>  
> >>> +config PCI_SSDLEDS
> >>> +	def_bool y if (ACPI && PCI)
> > 
> > That only should be set if the machine can not boot without it.
> > 
> > For a blinky light, that's not the case.
> > 
> > And why isn't this code using the existing LED subsystem?  Don't create
> > random new driver-specific sysfs files that do things the existing class
> > drivers do please.
> >
> 
> I did consider the LED subsystem, but I don't think it is a great match.
> 
> In spite of the name, this _DSM doesn't directly control individual LEDs--it
> sets the state(s) of the PCI port to which an SSD may be connected, so that
> it may be conveyed to the user... a processor (or at least some logic) will
> decide how to show which states are active, probably by setting combinations
> of LEDs to certain colors or blink patterns, or possibly on some other type
> of display.  On the system I have, changing the active state(s) sends a
> message via IPMI to an embedded processor, which will decide the colors
> and/or flashing pattern of the LEDs.  So brightness/color/blinking are not
> controlled, or even known, by the OS.

Then I STRONGLY suggest you change the name of all of this code then, as
it is totally confusing.

> Also, not all of the states will necessarily always be available.  For
> example, you may only be able to set the "rebuild" state when a drive is
> actually connected to the pci port that has this _DSM, while the "locate"
> state might be available all the time.  Since there's no notification
> if/when the supported states change, I believe that would mean, to implement
> this using the LED subsystem, the driver would have to register an "LED"
> with the LED subsystem for each possible state, and either make reads or
> writes to that state fail if it isn't supported.
> 
> But I will re-write this using the LED subsystem if you think it's a better
> fit (though I don't think so).

If you are allowing LEDs to be controlled by the user, then yes, you
have to use the LED subsystem as you should never try to create a brand
new driver-specific user/kernel API just for your tiny driver right?
Please work with the subsystems we have, they are unified for a reason.

thanks,

greg k-h
