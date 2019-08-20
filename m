Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA2B9670C
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2019 19:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbfHTRFS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Aug 2019 13:05:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:40268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725983AbfHTRFS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Aug 2019 13:05:18 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 203682087E;
        Tue, 20 Aug 2019 17:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566320717;
        bh=lS2La92iVqR0WgWZyh7NHtewbo7S76vVutlIVeuo6qw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W8MBUXIgJCStOSxzBkBfrtAWnIqgHxhsQfPRZQSfZLixWQR7fEFm+DbKCCkRJy5mB
         /rpz955u8VkoC5uJCC7ViswK5SU2b4VMqi+2DM5CYS6yDzCuQb3IVtihzXmhaCS8RR
         AvRlwc2MCMBP8ad3fV/aE+P/3uKlMv4zvtlcXPUI=
Date:   Tue, 20 Aug 2019 10:05:16 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Frederick Lawler <fred@fredlawl.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH 3/3] PCI/ASPM: add sysfs attribute for controlling ASPM
Message-ID: <20190820170516.GD3736@kroah.com>
References: <7a6d2f14-f2a6-99ad-3a93-fdaa0726ce86@gmail.com>
 <a0c090cd-e3a4-f667-b99d-f31c48c2e0a3@gmail.com>
 <20190820103400.GY253360@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820103400.GY253360@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 20, 2019 at 05:34:00AM -0500, Bjorn Helgaas wrote:
> [+cc Greg, Rajat]
> 
> On Thu, May 23, 2019 at 10:05:35PM +0200, Heiner Kallweit wrote:
> > Background of this extension is a problem with the r8169 network driver.
> > Several combinations of board chipsets and network chip versions have
> > problems if ASPM is enabled, therefore we have to disable ASPM per default.
> > However especially on notebooks ASPM can provide significant power-saving,
> > therefore we want to give users the option to enable ASPM. With the new sysfs
> > attribute users can control which ASPM link-states are enabled/disabled.
> > 
> > Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-pci |  13 ++
> >  drivers/pci/pci.h                       |   8 +-
> >  drivers/pci/pcie/aspm.c                 | 180 +++++++++++++++++++++++-
> >  3 files changed, 193 insertions(+), 8 deletions(-)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> > index 8bfee557e..38fe358de 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-pci
> > +++ b/Documentation/ABI/testing/sysfs-bus-pci
> > @@ -347,3 +347,16 @@ Description:
> >  		If the device has any Peer-to-Peer memory registered, this
> >  	        file contains a '1' if the memory has been published for
> >  		use outside the driver that owns the device.
> > +
> > +What:		/sys/bus/pci/devices/.../power/aspm_link_states
> > +Date:		May 2019
> > +Contact:	Heiner Kallweit <hkallweit1@gmail.com>
> > +Description:
> > +		If ASPM is supported for an endpoint, then this file can be
> > +		used to enable / disable link states. A link state
> > +		displayed in brackets is enabled, otherwise it's disabled.
> > +		To control link states (case insensitive):
> > +		+state : enables a supported state
> > +		-state : disables a state
> > +		none : disables all link states
> > +		all : enables all supported link states
> 
> IIUC this "aspm_link_states" file will contain things like this:
> 
>   L0S L1 L1.1 L1.2                 # All states supported, all disabled
>   [L0S] L1                         # L0s enabled, L1 supported but disabled
>   [L0S] [L1]                       # L0s and L1 enabled
>   ...
> 
> and the control is by writing things like this to it:
> 
>   +L1                              # enables L1
>   +L1.1                            # enables L1.1
>   -L0S                             # disables L0s
> 
> I know this file structure is similar to protocol handling in
> drivers/media/rc/rc-main.c, but Documentation/filesystems/sysfs.txt
> suggests single values in a file, and Greg recently pointed out that
> we screwed up some PCI AER stats [1].
> 
> So I'm thinking maybe we should split this into several files, e.g.,
> 
>   /sys/devices/pci*/.../power/aspm_l0s
>   /sys/devices/pci*/.../power/aspm_l1
>   /sys/devices/pci*/.../power/aspm_l1.1
>   /sys/devices/pci*/.../power/aspm_l1.2
> 
> which would contain just 1/0 values, and we'd write 1/0 to
> enable/disable things.

Yes, that is much simpler for both userspace to handle as well as the
kernel, as no need for parsing anything "special" at all here.

If the file is present, the state is supported, and the kernel code
should be _much_ easier to write and maintain over time.

> Since the L1 PM Substates control register has separate enable bits
> for PCI-PM L1.1 and L1.2, we might also want a way to manage those.

That sounds good as well.

thanks,

greg k-h
