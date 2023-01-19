Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8AF674C11
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jan 2023 06:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbjATFXh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Jan 2023 00:23:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbjATFXZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Jan 2023 00:23:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B89C63A3;
        Thu, 19 Jan 2023 21:13:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DC9BEB8211C;
        Thu, 19 Jan 2023 08:06:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 302EFC433EF;
        Thu, 19 Jan 2023 08:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674115569;
        bh=mmNC5usq3dcfjKDDeNe5L068d60kufdrTpBgZh6LUo0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D3PiU4gMUxK9ZVPKRN+V28pH5GXHrbzcZF1RoTn+EZBouV3fVBDs4ik1dE10lkcd6
         Y1KGqciV2Wd11SBHAJFOfQgfO2p3Ud5+aZhPFw6f9tBUiy9L0d5RWF6jjScp3tMVxD
         rmbNk1vPYWwO1v9xbqJdXPn7gbLKjQjeOh0uJDm59nBMh+B8pYreKVFDi3rFYGhGRA
         iVKSME3jxjNSLjuN4OCPoK+BUaXL24gg8YvgwpDnbO+6sUxaRMwuIeC6PB0tJPggjn
         QNwmKCXL9BPAhUaxp68zyMa3yIzcJSyhP5A/FTf5wDBVrv0gzkFj2DuIXqJreVEEJh
         UPULwonnBTt1A==
Received: by pali.im (Postfix)
        id 3407A6EB; Thu, 19 Jan 2023 09:06:06 +0100 (CET)
Date:   Thu, 19 Jan 2023 09:06:06 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Tianfei Zhang <tianfei.zhang@intel.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-fpga@vger.kernel.org, lukas@wunner.de, kabel@kernel.org,
        mani@kernel.org, mdf@kernel.org, hao.wu@intel.com,
        yilun.xu@intel.com, trix@redhat.com, jgg@ziepe.ca,
        ira.weiny@intel.com, andriy.shevchenko@linux.intel.com,
        dan.j.williams@intel.com, keescook@chromium.org, rafael@kernel.org,
        russell.h.weight@intel.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
        lee@kernel.org, gregkh@linuxfoundation.org,
        matthew.gerlach@linux.intel.com
Subject: Re: [PATCH v1 00/12] add FPGA hotplug manager driver
Message-ID: <20230119080606.tnjqwkseial7vpyq@pali>
References: <20230119013602.607466-1-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119013602.607466-1-tianfei.zhang@intel.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

On Wednesday 18 January 2023 20:35:50 Tianfei Zhang wrote:
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
> The fpgahp driver uses APIs from the pciehp driver.

Just I'm thinking about one thing. PCIe cards can support PCIe hotplug
mechanism (via standard PCIe capabilities). So what would happen when
FPGA based PCIe card is also hotplug-able? Will be there two PCI hotplug
drivers/devices (one fpgahp and one pciehp)? Or just one and which?

> Two new operation
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
> 
> Tianfei Zhang (12):
>   PCI: hotplug: add new callbacks on hotplug_slot_ops
>   PCI: hotplug: expose APIs from pciehp driver
>   PCI: hotplug: add and expose link disable API
>   PCI: hotplug: add FPGA PCI hotplug manager driver
>   fpga: dfl: register dfl-pci device into fpgahph driver
>   driver core: expose device_is_ancestor() API
>   PCI: hotplug: add register/unregister function for BMC device
>   fpga: m10bmc-sec: register BMC device into fpgahp driver
>   fpga: dfl: remove non-reserved devices
>   PCI: hotplug: implement the hotplug_slot_ops callback for fpgahp
>   fpga: m10bmc-sec: add m10bmc_sec_retimer_load callback
>   Documentation: fpga: add description of fpgahp driver
> 
>  Documentation/ABI/testing/sysfs-driver-fpgahp |  21 +
>  Documentation/fpga/fpgahp.rst                 |  29 +
>  Documentation/fpga/index.rst                  |   1 +
>  MAINTAINERS                                   |  10 +
>  drivers/base/core.c                           |   3 +-
>  drivers/fpga/Kconfig                          |   2 +
>  drivers/fpga/dfl-pci.c                        |  95 +++-
>  drivers/fpga/dfl.c                            |  58 ++
>  drivers/fpga/dfl.h                            |   4 +
>  drivers/fpga/intel-m10-bmc-sec-update.c       | 246 ++++++++
>  drivers/pci/hotplug/Kconfig                   |  14 +
>  drivers/pci/hotplug/Makefile                  |   1 +
>  drivers/pci/hotplug/fpgahp.c                  | 526 ++++++++++++++++++
>  drivers/pci/hotplug/pci_hotplug_core.c        |  88 +++
>  drivers/pci/hotplug/pciehp.h                  |   3 +
>  drivers/pci/hotplug/pciehp_hpc.c              |  11 +-
>  drivers/pci/hotplug/pciehp_pci.c              |   2 +
>  include/linux/device.h                        |   1 +
>  include/linux/fpga/fpgahp_manager.h           | 100 ++++
>  include/linux/mfd/intel-m10-bmc.h             |  31 ++
>  include/linux/pci_hotplug.h                   |   5 +
>  21 files changed, 1243 insertions(+), 8 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-fpgahp
>  create mode 100644 Documentation/fpga/fpgahp.rst
>  create mode 100644 drivers/pci/hotplug/fpgahp.c
>  create mode 100644 include/linux/fpga/fpgahp_manager.h
> 
> 
> base-commit: 5dc4c995db9eb45f6373a956eb1f69460e69e6d4
> -- 
> 2.38.1
> 
