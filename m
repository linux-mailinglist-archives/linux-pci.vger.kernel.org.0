Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21E1E4A9CEF
	for <lists+linux-pci@lfdr.de>; Fri,  4 Feb 2022 17:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240883AbiBDQ2B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Feb 2022 11:28:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiBDQ2A (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Feb 2022 11:28:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7382DC061714;
        Fri,  4 Feb 2022 08:28:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0859B61821;
        Fri,  4 Feb 2022 16:28:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B8D0C004E1;
        Fri,  4 Feb 2022 16:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643992079;
        bh=K0wsGaRUgHqugNIBiOxA+CA/nfIWkTeOxknPSc3roNE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=fRI/gmo4W3SpODPA+ggjubgEXctvWCzxuxwXUeOwF2plfITawzJnIIdfx1zVlsBUd
         +FLpO9INbKjf3DvT/Srl5tiCxvSq5yMYq4VChxU+ZIPJjHEA5ZA1tNhCWXX6ylYEo0
         p0a1G1px+N36bIrqhRgDaow7h5Dm4uIPGsby0oYcVLH4f2YPjdsVuruvKNum5YEeDD
         bRie+vwp7aLC64k8RSlhgS7m0JxMoSy/1eMMH+Fr3I4JzZ0q2Rjj1Krx3g0wwYhDgu
         rK6rWKb6WTo83T+JZxZJHCD+UYnmLC2Zi/HhYirPYlEYtf5sX66VY/74uQS+6l55/y
         z0gFP0gLy8h2w==
Date:   Fri, 4 Feb 2022 10:27:56 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     ira.weiny@intel.com, Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH V6 04/10] PCI/DOE: Introduce pci_doe_create_doe_devices
Message-ID: <20220204162756.GA187525@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204145116.00000f5c@Huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 04, 2022 at 02:51:16PM +0000, Jonathan Cameron wrote:
> On Thu, 3 Feb 2022 16:44:37 -0600
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Mon, Jan 31, 2022 at 11:19:46PM -0800, ira.weiny@intel.com wrote:

> > > + * pci_doe_create_doe_devices - Create auxiliary DOE devices for all DOE
> > > + *                              mailboxes found
> > > + * @pci_dev: The PCI device to scan for DOE mailboxes
> > > + *
> > > + * There is no coresponding destroy of these devices.  This function associates
> > > + * the DOE auxiliary devices created with the pci_dev passed in.  That
> > > + * association is device managed (devm_*) such that the DOE auxiliary device
> > > + * lifetime is always greater than or equal to the lifetime of the pci_dev.  
> > 
> > This seems backwards.  What does it mean if the DOE aux dev
> > lifetime is *greater* than that of the pci_dev?  Surely you can't
> > access a PCI DOE Capability if the pci_dev is gone?
> 
> I think the description is inaccurate - the end of life is the same
> as that of the PCI driver binding to the pci_dev.  It'll get cleared
> up if that is unbound etc.

I don't know much about devm, but I *think* the devm things get
released by devres_release_all(), which is called by
__device_release_driver() after it calls the bus or driver's .remove()
method (pci_device_remove(), in this case).

So in this case, I think the aux dev is created after the pci_dev and
released after the PCI driver and the PCI core are done with the
pci_dev.  I assume some refcounting prevents the pci_dev from actually
being deallocated until the aux dev is done with it.

I'm not confident that this is a robust situation.

> > > +		 * done later within the DOE initialization, but as it
> > > +		 * potentially has other impacts keep it here when setting up
> > > +		 * the IRQ's.  
> > 
> > s/IRQ's/IRQs/
> > 
> > "Potentially has other impacts" is too vague, and this doesn't
> > explain why bus mastering should be enabled here rather than
> > later.  The device should not issue an MSI-X until DOE Interrupt
> > Enable is set, so near there seems like a logical place.
> 
> I can't remember what lead to that comment so hopefully moving to
> just before the enable would be fine - if there was somewhere to do
> it.  I'm not sure there is as the IRQ enable is in the Auxilliary
> Bus driver.  If we pull the pci_alloc_irq_vectors() out of here into
> the caller, then the pci_set_master() should go with it.

I think pci_set_master() is tied to setting PCI_DOE_CTRL_INT_EN, not
to pci_alloc_irq_vectors().

Bjorn
