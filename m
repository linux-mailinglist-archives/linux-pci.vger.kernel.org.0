Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 647A941DB74
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 15:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350452AbhI3NvV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Sep 2021 09:51:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:49708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350901AbhI3NvU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Sep 2021 09:51:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 603936187A;
        Thu, 30 Sep 2021 13:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633009777;
        bh=U9iiEkqwLSIMx5qFueAE+WdXrbQNjtowDTehHAGMyMw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=arqSlanbgqlgNfeZnJyDO5TTSOWckEPTV6037BqAX1Oo8Dp6/LdUnXNOKFZoLgwX+
         24sWxMcDrtnlE/p2kjHOyZE4vtzM6WKa4tqjc84ZNdsX5z+/euJ/RscKpMwcFl3Frb
         A2IBrCokTmoxJCxJjnoYtyjZxHGiv8AMjacbbWl4=
Date:   Thu, 30 Sep 2021 15:49:35 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jason Wang <jasowang@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 4/6] virtio: Initialize authorized attribute for
 confidential guest
Message-ID: <YVXAb4C51e/L2sGv@kroah.com>
References: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930010511.3387967-5-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930065953-mutt-send-email-mst@kernel.org>
 <CAPcyv4hP6mtzKS-CVb-aKf-kYuiLM771PMxN2zeBEfoj6NbctA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hP6mtzKS-CVb-aKf-kYuiLM771PMxN2zeBEfoj6NbctA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 30, 2021 at 06:36:18AM -0700, Dan Williams wrote:
> On Thu, Sep 30, 2021 at 4:03 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Sep 29, 2021 at 06:05:09PM -0700, Kuppuswamy Sathyanarayanan wrote:
> > > Confidential guest platforms like TDX have a requirement to allow
> > > only trusted devices. By default the confidential-guest core will
> > > arrange for all devices to default to unauthorized (via
> > > dev_default_authorization) in device_initialize(). Since virtio
> > > driver is already hardened against the attack from the un-trusted host,
> > > override the confidential computing default unauthorized state
> > >
> > > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > > Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> >
> > Architecturally this all looks backwards. IIUC nothing about virtio
> > makes it authorized or trusted. The driver is hardened,
> > true, but this should be set at the driver not the device level.
> 
> That's was my initial reaction to this proposal as well, and I ended
> up leading Sathya astray from what Greg wanted. Greg rightly points
> out that the "authorized" attribute from USB and Thunderbolt already
> exists [1] [2]. So the choice is find an awkward way to mix driver
> trust with existing bus-local "authorized" mechanisms, or promote the
> authorized capability to the driver-core. This patch set implements
> the latter to keep the momentum on the already shipping design scheme
> to not add to the driver-core maintenance burden.
> 
> [1]: https://lore.kernel.org/all/YQuaJ78y8j1UmBoz@kroah.com/
> [2]: https://lore.kernel.org/all/YQzF%2FutgrJfbZuHh@kroah.com/
> 
> > And in particular, not all virtio drivers are hardened -
> > I think at this point blk and scsi drivers have been hardened - so
> > treating them all the same looks wrong.
> 
> My understanding was that they have been audited, Sathya?

Please define "audited" and "trusted" here.

thanks,

greg k-h
