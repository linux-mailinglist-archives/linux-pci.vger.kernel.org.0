Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD8C675CE9
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jan 2023 19:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjATSm6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Jan 2023 13:42:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjATSm5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Jan 2023 13:42:57 -0500
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D23DBEB;
        Fri, 20 Jan 2023 10:42:55 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id A654830000940;
        Fri, 20 Jan 2023 19:42:53 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 9BAF31D5B81; Fri, 20 Jan 2023 19:42:53 +0100 (CET)
Date:   Fri, 20 Jan 2023 19:42:53 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Tianfei Zhang <tianfei.zhang@intel.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-fpga@vger.kernel.org,
        kabel@kernel.org, mani@kernel.org, pali@kernel.org, mdf@kernel.org,
        hao.wu@intel.com, yilun.xu@intel.com, trix@redhat.com,
        jgg@ziepe.ca, ira.weiny@intel.com,
        andriy.shevchenko@linux.intel.com, dan.j.williams@intel.com,
        keescook@chromium.org, rafael@kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
        lee@kernel.org, matthew.gerlach@linux.intel.com
Subject: Re: [PATCH v1 00/12] add FPGA hotplug manager driver
Message-ID: <20230120184253.GA25018@wunner.de>
References: <20230119013602.607466-1-tianfei.zhang@intel.com>
 <Y8lGxqjuLS8NfJtg@kroah.com>
 <a896be81-e482-9d52-ece5-a2ef28822072@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a896be81-e482-9d52-ece5-a2ef28822072@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 20, 2023 at 08:28:51AM -0800, Russ Weight wrote:
> On 1/19/23 05:33, Greg KH wrote:
> > On Wed, Jan 18, 2023 at 08:35:50PM -0500, Tianfei Zhang wrote:
> > > This patchset introduces the FPGA hotplug manager (fpgahp) driver which
> > > has been verified on the Intel N3000 card.
> > >
> > > When a PCIe-based FPGA card is reprogrammed, it temporarily disappears
> > > from the PCIe bus. This needs to be managed to avoid PCIe errors and to
> > > reprobe the device after reprogramming.
> > >
> > > To change the FPGA image, the kernel burns a new image into the flash on
> > > the card, and then triggers the card BMC to load the new image into FPGA.
> > > A new FPGA hotplug manager driver is introduced that leverages the PCIe
> > > hotplug framework to trigger and manage the update of the FPGA image,
> > > including the disappearance and reappearance of the card on the PCIe bus.
> > > The fpgahp driver uses APIs from the pciehp driver. Two new operation
> > > callbacks are defined in hotplug_slot_ops:
> > >
> > >   - available_images: Optional: available FPGA images
> > >   - image_load: Optional: trigger the FPGA to load a new image
> > 
> > Why is all of this tied into the pci hotplug code? Shouldn't it be
> > specific to this one driver instead?  pci hotplug is for removing/adding
> > PCI devices to the system, not messing with FPGA images.
> >
> > This feels like an abuse of the pci hotplug bus to me as this is NOT
> > really a PCI hotplug bus at all, right?
> 
> While it is true that triggering an FPGA image-load does not involve
> hotplug specific registers to be managed, the RTL that comprises
> the PCIe interface will disappear and then reappear after the FPGA
> is reprogrammed. When it reappears, it_could/_/have a different PCI
> ID. The process of managing this event has a lot of similarity to a
> PCIe hotplug event; there is a lot of existing PCIe hotplug related
> code that could be leveraged.

It sounds like the N3000 is a PCI endpoint device which, when reprogrammed,
briefly disappears from the bus and then may reappear under a different
device ID.

What you want to do then is make sure that the slot into which the N3000
is plugged is hotplug-capable.  In that case, pciehp will handle
disappearance and reappearance of the card just fine.  Once the N3000
disables the link, pciehp will bring down the slot.  Once it re-enables
the link, it will bring the slot up again.  It's as if the card was
removed and replaced with a different one.  pciehp will bind to the
Root Port or Downstream Port associated with the hotplug slot.

The pci_hotplug_port infrastructure is for hotplug controllers which
handle devices disappearing and reappearing *below* them.  It is not
for endpoint devices.

Thanks,

Lukas
