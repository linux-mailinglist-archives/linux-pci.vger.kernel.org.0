Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9E754040F8
	for <lists+linux-pci@lfdr.de>; Thu,  9 Sep 2021 00:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbhIHWZe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Sep 2021 18:25:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:43558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229997AbhIHWZd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Sep 2021 18:25:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E16BB60F23;
        Wed,  8 Sep 2021 22:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631139864;
        bh=lUuy1M9gczWX+77XX6OSC4WjGDl1dvvvOMoa7ctmFCc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=rxx8ZX1lsBpGBltoVuurEpBDcyNxGxZNUMZnaWI9cOb6Op7O+sNqOG5lM5bO+aGJD
         bfVYjmC5cCExfvhvJISfISjfoQ78bXY7ibHxbcE4NKoIGb8Q6XgDn0m3giaqSEq6nY
         yCjQSbarTIDrgMVy09+8FlagCnN29hkqlsRAykYb6lpXdlLQZi+YLzZ/8aG5KBRIKx
         xBxLVNz/kb8lav3LFqSMZvlqfL8bbbNdLfr5/o6jq4OQr+l+CTF7ZN0FlhsxJlp8FF
         PKi/8OXAvZWnWYxRslrXJ3uuYLDUS9IXdp/j1ko3awOjtQ7BXYfxsAWrATfmbaBRUf
         +FIyb1LKWbvnA==
Date:   Wed, 8 Sep 2021 17:24:22 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nathan Rossi <nathan@nathanrossi.com>
Cc:     Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        Nathan Rossi <nathan.rossi@digi.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] PCI: Add ACS errata for Pericom PI7C9X2G404 switch
Message-ID: <20210908222422.GA911514@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+aJhH1qagpz6qPEYLnO6UMuh_U5uCK3tzdoGJyR9Y73MOmneQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Alex, beginning of thread:
https://lore.kernel.org/r/20210903034029.306816-1-nathan@nathanrossi.com]

On Mon, Sep 06, 2021 at 04:01:20PM +1000, Nathan Rossi wrote:
> On Fri, 3 Sept 2021 at 16:18, Lukas Wunner <lukas@wunner.de> wrote:
> >
> > On Fri, Sep 03, 2021 at 03:40:29AM +0000, Nathan Rossi wrote:
> > > The Pericom PI7C9X2G404 PCIe switch has an errata for ACS P2P Request
> > > Redirect behaviour when used in the cut-through forwarding mode. The
> > > recommended work around for this issue is to use the switch in store and
> > > forward mode.

Is there a URL for this erratum?  What is the issue?  Does the switch
fail to redirect P2P requests upstream?  How would someone recognize
that they are affected by it?

> > > This change adds a fixup specific to this switch that when enabling the
> > > downstream port it checks if it has enabled ACS P2P Request Redirect,
> > > and if so changes the device (via the upstream port) to use the store
> > > and forward operating mode.
> >
> > From a quick look at the datasheet, this switch seems to support
> > hot-plug on its Downstream Ports:
> >
> > https://www.diodes.com/assets/Datasheets/PI7C9X2G404SL.pdf
> >
> > I think your quirk isn't executed if a device is hotplugged to an
> > initially-empty Downstream Port.
> 
> The device I am testing against has the ports wired directly to
> devices (though can be disconnected) without hotplug so I will see if
> I can find a development board with this switch to test the hotplug
> behaviour. However it should be noted that the downstream ports are
> probed with the switch, and are enabled with the ACS P2P Request
> Redirect configured regardless of the presence of a device connected
> to the downstream port.
> 
> > Also, if a device which triggered the quirk is hot-removed and none
> > of its siblings uses ACS P2P Request Redirect, cut-through forwarding
> > isn't reinstated.
> 
> The quirk is enabled on the downstream port of the switch, using the
> state of the downstream port and not the device attached to it. My
> understanding is that the only path that enables/disables the ACS P2P
> Request Redirect on the downstream port is the initial pci_enable_acs.

pci_enable_acs() is called during enumeration of each device
(including the switch, of course):

  pci_init_capabilities
    pci_acs_init
      pci_enable_acs

and your quirk is DECLARE_PCI_FIXUP_ENABLE(), so it runs later, during
pci_enable_device().  I don't think we ever turn on ACS P2P Request
Redirect after enumeration.

But we do also call pci_enable_acs() from pci_restore_state(), so this
happens during resume.  I assume your quirk would also need to run
then?  Is there a pci_enable_device() somewhere in the resume path
that will do this?

> This means that devices attached to the downstream port either
> initially or with hotplugging should not change the ACS configuration
> of the switches downstream port.
> 
> Which means nothing can cause the switch to need to be reinstated with
> cut-through forwarding except the switch itself being hotplugged,
> which would cause reset of the switch and the enable fixup to be
> called again.

Seems right to me, since we enable ACS P2P Request Redirect regardless
of whether any downstream device exists.

> > Perhaps we need additional pci_fixup ELF sections which are used on
> > hot-add and hot-remove?
> >
> > Thanks,
> >
> > Lukas
