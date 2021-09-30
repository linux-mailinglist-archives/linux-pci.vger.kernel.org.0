Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAE241DB81
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 15:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351527AbhI3Nyi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Sep 2021 09:54:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:50426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349986AbhI3Nyi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Sep 2021 09:54:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AA12661440;
        Thu, 30 Sep 2021 13:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633009975;
        bh=L0oLqFNbkPrIbGt+hPB4rGpaRUbo+2TxQ+488ZyaDGU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=deDtdNm2iRzr+xP15sd2vlWMXOpveccNMKkbD3Jx58CbdPRS2Dm3uDK68oBqpaN3f
         IabfV6uV1vpdH6bf0N9RAghufVCjXRZweWO+RKN7Mz9mgWu4SCBOLPa5+jDw/m0mGc
         08AfqNv9wGtLprXDPkT3itEA6jaoWZT5svVNdl2s=
Date:   Thu, 30 Sep 2021 15:52:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
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
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-usb@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 2/6] driver core: Add common support to skip probe for
 un-authorized devices
Message-ID: <YVXBNJ431YIWwZdQ@kroah.com>
References: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930010511.3387967-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930065807-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210930065807-mutt-send-email-mst@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 30, 2021 at 06:59:36AM -0400, Michael S. Tsirkin wrote:
> On Wed, Sep 29, 2021 at 06:05:07PM -0700, Kuppuswamy Sathyanarayanan wrote:
> > While the common case for device-authorization is to skip probe of
> > unauthorized devices, some buses may still want to emit a message on
> > probe failure (Thunderbolt), or base probe failures on the
> > authorization status of a related device like a parent (USB). So add
> > an option (has_probe_authorization) in struct bus_type for the bus
> > driver to own probe authorization policy.
> > 
> > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> 
> 
> So what e.g. the PCI patch
> https://lore.kernel.org/all/CACK8Z6E8pjVeC934oFgr=VB3pULx_GyT2NkzAogdRQJ9TKSX9A@mail.gmail.com/
> actually proposes is a list of
> allowed drivers, not devices. Doing it at the device level
> has disadvantages, for example some devices might have a legacy
> unsafe driver, or an out of tree driver. It also does not
> address drivers that poke at hardware during init.

Doing it at a device level is the only sane way to do this.

A user needs to say "this device is allowed to be controlled by this
driver".  This is the trust model that USB has had for over a decade and
what thunderbolt also has.

> Accordingly, I think the right thing to do is to skip
> driver init for disallowed drivers, not skip probe
> for specific devices.

What do you mean by "driver init"?  module_init()?

No driver should be touching hardware in their module init call.  They
should only be touching it in the probe callback as that is the only
time they are ever allowed to talk to hardware.  Specifically the device
that has been handed to them.

If there are in-kernel PCI drivers that do not do this, they need to be
fixed today.

We don't care about out-of-tree drivers for obvious reasons that we have
no control over them.

thanks,

greg k-h
