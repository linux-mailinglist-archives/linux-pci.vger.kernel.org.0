Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86BE650887
	for <lists+linux-pci@lfdr.de>; Mon, 19 Dec 2022 09:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbiLSIWs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Dec 2022 03:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiLSIWr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Dec 2022 03:22:47 -0500
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3C57649;
        Mon, 19 Dec 2022 00:22:44 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id AA62430000CE2;
        Mon, 19 Dec 2022 09:22:40 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 9D60210D88; Mon, 19 Dec 2022 09:22:40 +0100 (CET)
Date:   Mon, 19 Dec 2022 09:22:40 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Parav Pandit <parav@nvidia.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Wei Gong <gongwei833x@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2] pci: fix device presence detection for VFs
Message-ID: <20221219082240.GA5176@wunner.de>
References: <20221110144700-mutt-send-email-mst@kernel.org>
 <20221111234219.GA763705@bhelgaas>
 <20221113034519-mutt-send-email-mst@kernel.org>
 <20221116111619.GA5804@wunner.de>
 <PH0PR12MB54811F4658F068C46E071E81DC069@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20221219005553-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219005553-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 19, 2022 at 12:56:15AM -0500, Michael S. Tsirkin wrote:
> On Thu, Nov 17, 2022 at 05:36:48AM +0000, Parav Pandit wrote:
> > > From: Lukas Wunner <lukas@wunner.de>
> > > Sent: Wednesday, November 16, 2022 6:16 AM
> > > 
> > > [cc += Parav Pandit, author of 43bb40c5b926]
> > > 
> > > On Sun, Nov 13, 2022 at 03:46:06AM -0500, Michael S. Tsirkin wrote:
> > > > On Fri, Nov 11, 2022 at 05:42:19PM -0600, Bjorn Helgaas wrote:
> > > > > On Thu, Nov 10, 2022 at 03:15:55PM -0500, Michael S. Tsirkin wrote:
> > > > > > On Thu, Nov 10, 2022 at 01:35:47PM -0600, Bjorn Helgaas wrote:
> > > > > > > Prior to this change pci_device_is_present(VF) returned "false"
> > > > > > > (because the VF Vendor ID is 0xffff); after the change it will
> > > > > > > return "true" (because it will look at the PF Vendor ID instead).
> > > > > > >
> > > > > > > Previously virtio_pci_remove() called virtio_break_device().  I
> > > > > > > guess that meant the virtio I/O operation will never be completed?
> > > > > > >
> > > > > > > But if we don't call virtio_break_device(), the virtio I/O
> > > > > > > operation
> > > > > > > *will* be completed?
> > > >
> > > > Just making sure - pci_device_is_present *is* the suggested way to
> > > > distinguish between graceful and surprise removal, isn't it?
> > > 
> > > No, it's not.  Instead of !pci_device_is_present() you really want to call
> > > pci_dev_is_disconnected() instead.
> > > 
> > > While the fix Bjorn applied for v6.2 may solve the issue and may make sense
> > > on it's own, it's not the solution you're looking for.  You want to swap the
> > > call to !pci_device_is_present() with pci_dev_is_disconnected(), move
> > > pci_dev_is_disconnected() from drivers/pci/pci.h to include/linux/pci.h and
> > > add a Fixes tag referencing 43bb40c5b926.
> > > 
> > > If you don't want to move pci_dev_is_disconnected(), you can alternatively
> > > check for "pdev->error_state == pci_channel_io_perm_failure" or call
> > > pci_channel_offline().  The latter will also return true though on transient
> > > inaccessibility of the device (e.g. if it's being reset).
> > > 
> > pci_device_is_present() is calling pci_dev_is_disconnected().
> > pci_dev_is_disconnected() avoids reading the vendor id.
> > So pci_dev_is_disconnected() looks less strong check.
> > I see that it can return a valid value on recoverable error case.
> > 
> > In that case, is pci_channel_offline() a more precise way to check that covers transient and permanent error?
> > 
> > And if that is the right check, we need to fix all the callers, mainly widely used nvme driver [1].
> > 
> > [1] https://elixir.bootlin.com/linux/v6.1-rc5/source/drivers/nvme/host/pci.c#L3228
> > 
> > Also, we need to add API documentation on when to use this API in context of hotplug, so that all related drivers can consistently use single API.
> 
> Bjorn, Lukas, what's your take on this idea?

I don't really know what to add to my e-mail of Nov 16
(quoted here in full).

Yes, pci_channel_offline() returns true on transient and permanent
failure.  Whether that's what you want, depends on your use case.
If you want to check for a surprise-removed device, then you only
want to check for permanent failure, so pci_channel_offline() is
not correct and you should rather check for
"pdev->error_state == pci_channel_io_perm_failure" or move
pci_dev_is_disconnected() to include/linux/pci.h.  But again,
I've already explained this in my e-mail ov Nov 16, so I don't
know what's unclear.

Thanks,

Lukas

> > > The theory of operation is as follows:  The PCI layer does indeed know
> > > whether the device was surprise removed or gracefully removed and that
> > > information is passed in the "presence" flag to pciehp_unconfigure_device()
> > > (in drivers/pci/hotplug/pciehp_pci.c).  That function does the following:
> > > 
> > > 	if (!presence)
> > > 		pci_walk_bus(parent, pci_dev_set_disconnected, NULL);
> > > 
> > > In other words, pdev->error_state is set to pci_channel_io_perm_failure on
> > > the entire hierarchy below the hotplug port.  And pci_dev_is_disconnected()
> > > simply checks whether that's the device's error_state.
> > > 
> > > pci_dev_is_disconnected() makes sense if you definitely know the device is
> > > gone and want to skip certain steps or delays on device teardown.
> > > However be aware that the device may be hot-removed after graceful
> > > removal was initiated.  In such a situation, pci_dev_is_disconnected() may
> > > return false and you'll try to access the device as normal, even though it was
> > > yanked from the slot after the pci_dev_is_disconnected() call was
> > > performed.  Ideally you should be able to cope with such scenarios as well.
> > > 
> > > For some more background info, refer to this LWN article (scroll down to the
> > > "Surprise removal" section):
> > > https://lwn.net/Articles/767885/
> > > 
> > > Thanks,
> > > 
> > > Lukas
