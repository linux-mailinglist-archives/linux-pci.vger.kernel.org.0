Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B616764FA
	for <lists+linux-pci@lfdr.de>; Sat, 21 Jan 2023 08:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjAUHei (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 21 Jan 2023 02:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjAUHeh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 21 Jan 2023 02:34:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052A27135D;
        Fri, 20 Jan 2023 23:34:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B1182B80967;
        Sat, 21 Jan 2023 07:34:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B272FC433EF;
        Sat, 21 Jan 2023 07:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674286473;
        bh=bJ0CXR3r1BYYKPNARKc/Pw8CQLUJuFyDf4P7y0d3azM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VfqAMkqqqcUrR2XiDd7yjEi1PcaJlIc8l5bVzSfEgIw1a+rJgo2g/7CBUCFdw05yC
         HUGN4KclAuxcHeAGqBp/zxBqXjjNUr1xgwuHTDtVdseGX09fo5qdz/ZpnlK6pRE+Xz
         LEjy0IlmYFJJwxJC42iw3GQT3Hmy0xliuD02NQuw=
Date:   Sat, 21 Jan 2023 08:34:30 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Russ Weight <russell.h.weight@intel.com>,
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
Message-ID: <Y8uVho0UDP/1A1JG@kroah.com>
References: <20230119013602.607466-1-tianfei.zhang@intel.com>
 <Y8lGxqjuLS8NfJtg@kroah.com>
 <a896be81-e482-9d52-ece5-a2ef28822072@intel.com>
 <20230120184253.GA25018@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120184253.GA25018@wunner.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 20, 2023 at 07:42:53PM +0100, Lukas Wunner wrote:
> On Fri, Jan 20, 2023 at 08:28:51AM -0800, Russ Weight wrote:
> > On 1/19/23 05:33, Greg KH wrote:
> > > On Wed, Jan 18, 2023 at 08:35:50PM -0500, Tianfei Zhang wrote:
> > > > This patchset introduces the FPGA hotplug manager (fpgahp) driver which
> > > > has been verified on the Intel N3000 card.
> > > >
> > > > When a PCIe-based FPGA card is reprogrammed, it temporarily disappears
> > > > from the PCIe bus. This needs to be managed to avoid PCIe errors and to
> > > > reprobe the device after reprogramming.
> > > >
> > > > To change the FPGA image, the kernel burns a new image into the flash on
> > > > the card, and then triggers the card BMC to load the new image into FPGA.
> > > > A new FPGA hotplug manager driver is introduced that leverages the PCIe
> > > > hotplug framework to trigger and manage the update of the FPGA image,
> > > > including the disappearance and reappearance of the card on the PCIe bus.
> > > > The fpgahp driver uses APIs from the pciehp driver. Two new operation
> > > > callbacks are defined in hotplug_slot_ops:
> > > >
> > > >   - available_images: Optional: available FPGA images
> > > >   - image_load: Optional: trigger the FPGA to load a new image
> > > 
> > > Why is all of this tied into the pci hotplug code? Shouldn't it be
> > > specific to this one driver instead?  pci hotplug is for removing/adding
> > > PCI devices to the system, not messing with FPGA images.
> > >
> > > This feels like an abuse of the pci hotplug bus to me as this is NOT
> > > really a PCI hotplug bus at all, right?
> > 
> > While it is true that triggering an FPGA image-load does not involve
> > hotplug specific registers to be managed, the RTL that comprises
> > the PCIe interface will disappear and then reappear after the FPGA
> > is reprogrammed. When it reappears, it_could/_/have a different PCI
> > ID. The process of managing this event has a lot of similarity to a
> > PCIe hotplug event; there is a lot of existing PCIe hotplug related
> > code that could be leveraged.
> 
> It sounds like the N3000 is a PCI endpoint device which, when reprogrammed,
> briefly disappears from the bus and then may reappear under a different
> device ID.
> 
> What you want to do then is make sure that the slot into which the N3000
> is plugged is hotplug-capable.  In that case, pciehp will handle
> disappearance and reappearance of the card just fine.  Once the N3000
> disables the link, pciehp will bring down the slot.  Once it re-enables
> the link, it will bring the slot up again.  It's as if the card was
> removed and replaced with a different one.  pciehp will bind to the
> Root Port or Downstream Port associated with the hotplug slot.
> 
> The pci_hotplug_port infrastructure is for hotplug controllers which
> handle devices disappearing and reappearing *below* them.  It is not
> for endpoint devices.

Yes, thank you for expressing my concerns about this design much better
than I originally did.  I totally agree.

thanks,

greg k-h
