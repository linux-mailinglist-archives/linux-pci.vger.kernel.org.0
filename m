Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71EE4673A58
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jan 2023 14:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbjASNeJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Jan 2023 08:34:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbjASNeH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Jan 2023 08:34:07 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EE67C872;
        Thu, 19 Jan 2023 05:34:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5329CCE21DD;
        Thu, 19 Jan 2023 13:34:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D07E6C433D2;
        Thu, 19 Jan 2023 13:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674135241;
        bh=dITm+CH8y++F1rs0SHrEvj9jzhmezGqIi7bACv69SVg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o3V9YAHgRDMHwAQ8cjcr9mkZBkbhJzl0d4G6WmIX8Zq6YgsUGsu+VscOEC9Nf1gnw
         0ew88JSNpD11nmiYCC2YK58oS77V8pah9uvNP5yxB7iJ/71Cwzp9YcVS6rpTzsPS6C
         1dymQ0Pdt0Z69/s38n+H5FetS/hWMI7voN87FTSM=
Date:   Thu, 19 Jan 2023 14:33:58 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tianfei Zhang <tianfei.zhang@intel.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-fpga@vger.kernel.org, lukas@wunner.de, kabel@kernel.org,
        mani@kernel.org, pali@kernel.org, mdf@kernel.org, hao.wu@intel.com,
        yilun.xu@intel.com, trix@redhat.com, jgg@ziepe.ca,
        ira.weiny@intel.com, andriy.shevchenko@linux.intel.com,
        dan.j.williams@intel.com, keescook@chromium.org, rafael@kernel.org,
        russell.h.weight@intel.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
        lee@kernel.org, matthew.gerlach@linux.intel.com
Subject: Re: [PATCH v1 00/12] add FPGA hotplug manager driver
Message-ID: <Y8lGxqjuLS8NfJtg@kroah.com>
References: <20230119013602.607466-1-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119013602.607466-1-tianfei.zhang@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 18, 2023 at 08:35:50PM -0500, Tianfei Zhang wrote:
> This patchset introduces the FPGA hotplug manager (fpgahp) driver which 
> has been verified on the Intel N3000 card.
> 
> When a PCIe-based FPGA card is reprogrammed, it temporarily disappears
> from the PCIe bus. This needs to be managed to avoid PCIe errors and to
> reprobe the device after reprogramming.
> 
> To change the FPGA image, the kernel burns a new image into the flash on
> the card, and then triggers the card BMC to load the new image into FPGA.
> A new FPGA hotplug manager driver is introduced that leverages the PCIe
> hotplug framework to trigger and manage the update of the FPGA image,
> including the disappearance and reappearance of the card on the PCIe bus.
> The fpgahp driver uses APIs from the pciehp driver. Two new operation
> callbacks are defined in hotplug_slot_ops:
> 
>   - available_images: Optional: available FPGA images
>   - image_load: Optional: trigger the FPGA to load a new image
> 
> 
> The process of reprogramming an FPGA card begins by removing all devices
> associated with the card that are not required for the reprogramming of
> the card. This includes PCIe devices (PFs and VFs) associated with the
> card as well as any other types of devices (platform, etc.) defined within
> the FPGA. The remaining devices are referred to here as "reserved" devices.
> After triggering the update of the FPGA card, the reserved devices are also
> removed.
> 
> The complete process for reprogramming the FPGA are:
>     1. remove all PFs and VFs except for PF0 (reserved).
>     2. remove all non-reserved devices of PF0.
>     3. trigger FPGA card to do the image update.
>     4. disable the link of the hotplug bridge.
>     5. remove all reserved devices under hotplug bridge.
>     6. wait for image reload done via BMC, e.g. 10s.
>     7. re-enable the link of hotplug bridge
>     8. enumerate PCI devices below the hotplug bridge
> 
> usage example:
> [root@localhost]# cd /sys/bus/pci/slot/X-X/
> 
> Get the available images.
> [root@localhost 2-1]# cat available_images
> bmc_factory bmc_user retimer_fw
> 
> Load the request images for FPGA Card, for example load the BMC user image:
> [root@localhost 2-1]# echo bmc_user > image_load

Why is all of this tied into the pci hotplug code? Shouldn't it be
specific to this one driver instead?  pci hotplug is for removing/adding
PCI devices to the system, not messing with FPGA images.

This feels like an abuse of the pci hotplug bus to me as this is NOT
really a PCI hotplug bus at all, right?

Or is it?  If so, then the slots should show up under the PCI device
itself, not in /sys/bus/pci/slot/.  That location is there for old old
stuff, we probably should move it one of these days as there's lots of
special-cases in the driver core just because of that :(

thanks,

greg k-h
