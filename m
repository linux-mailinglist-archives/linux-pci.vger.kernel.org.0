Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9135B8938
	for <lists+linux-pci@lfdr.de>; Wed, 14 Sep 2022 15:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiINNfR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Sep 2022 09:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiINNfQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Sep 2022 09:35:16 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9226818E11;
        Wed, 14 Sep 2022 06:35:13 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1112)
        id 1A52E20520AE; Wed, 14 Sep 2022 06:35:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1A52E20520AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1663162513;
        bh=8jdg+ElUih7lPWDRjB06Zln1zyqWp+4LB/sUV1a0h8E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jnDGVNH3ELcX8x2FMzye2pY1hk+YQbgK/DQDmLfTRK5aUe3RyW83rlYBTSeV6NTLe
         snmDYZEiy20LwhcdMmG1QQju4dZf2WCvmy6gEQHn63Xl4IY29ISDMaVPH11YjDdoRb
         SY13OZp7JJkgzID/RjrfrA47RMjBqFLlA1GunXT0=
Date:   Wed, 14 Sep 2022 06:35:13 -0700
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
To:     Lizhi Hou <lizhi.hou@amd.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh@kernel.org,
        frowand.list@gmail.com, helgaas@kernel.org,
        clement.leger@bootlin.com, max.zhen@amd.com, sonal.santan@amd.com,
        larry.liu@amd.com, brian.xu@amd.com, stefano.stabellini@xilinx.com,
        trix@redhat.com
Subject: Re: [PATCH RFC 0/2] Generate device tree node for pci devices
Message-ID: <20220914133513.GA26840@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1661809417-11370-1-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1661809417-11370-1-git-send-email-lizhi.hou@amd.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 29, 2022 at 02:43:35PM -0700, Lizhi Hou wrote:
> This patch series introduces OF overlay support for PCI devices which
> primarily addresses two use cases. First, it provides a data driven method
> to describe hardware peripherals that are present in a PCI endpoint and
> hence can be accessed by the PCI host. An example device is Xilinx/AMD
> Alveo PCIe accelerators. Second, it allows reuse of a OF compatible
> driver -- often used in SoC platforms -- in a PCI host based system. An
> example device is Microchip LAN9662 Ethernet Controller.
> 
> This patch series consolidates previous efforts to define such an
> infrastructure:
> https://lore.kernel.org/lkml/20220305052304.726050-1-lizhi.hou@xilinx.com/
> https://lore.kernel.org/lkml/20220427094502.456111-1-clement.leger@bootlin.com/
> 
> Normally, the PCI core discovers PCI devices and their BARs using the
> PCI enumeration process. However, the process does not provide a way to
> discover the hardware peripherals that are present in a PCI device, and
> which can be accessed through the PCI BARs. Also, the enumeration process
> does not provide a way to associate MSI-X vectors of a PCI device with the
> hardware peripherals that are present in the device. PCI device drivers
> often use header files to describe the hardware peripherals and their
> resources as there is no standard data driven way to do so. This patch
> series proposes to use flattened device tree blob to describe the
> peripherals in a data driven way. Based on previous discussion, using
> device tree overlay is the best way to unflatten the blob and populate
> platform devices. To use device tree overlay, there are three obvious
> problems that need to be resolved.

Hi Lizhi,

We all *love* "have you thought about xxx" questions but I would really like to
get your thoughts on this. An approach to this problem that I have seen in
various devices is to emulate a virtual pcie switch, and expose the "sub
devices" behind that. That way you can carve up the BAR space, each device has
its own config space and mapping of MSI-X vector to device becomes clear. This
approach also integrates well with other kernel infrastructure (IOMMU, hotplug).

This is certainly possible on reprogrammable devices but requires some more
FPGA resources - though I don't believe the added utilization would be
significant. What do you think of this kind of solution?

Jeremi

> 
> First, we need to create a base tree for non-DT system such as x86_64. A
> patch series has been submitted for this:
> https://lore.kernel.org/lkml/20220624034327.2542112-1-frowand.list@gmail.com/
> https://lore.kernel.org/lkml/20220216050056.311496-1-lizhi.hou@xilinx.com/
> 
> Second, a device tree node corresponding to the PCI endpoint is required
> for overlaying the flattened device tree blob for that PCI endpoint.
> Because PCI is a self-discoverable bus, a device tree node is usually not
> created for PCI devices. This series adds support to generate a device
> tree node for a PCI device which advertises itself using PCI quirks
> infrastructure.
> 
> Third, we need to generate device tree nodes for PCI bridges since a child
> PCI endpoint may choose to have a device tree node created.
> 
> This patch series is made up of two patches.
> 
> The first patch is adding OF interface to allocate an OF node. It is copied
> from:
> https://lore.kernel.org/lkml/20220620104123.341054-5-clement.leger@bootlin.com/
> 
> The second patch introduces a kernel option, CONFIG_PCI_OF. When the option
> is turned on, the kernel will generate device tree nodes for all PCI
> bridges unconditionally. The patch also shows how to use the PCI quirks
> infrastructure, DECLARE_PCI_FIXUP_FINAL to generate a device tree node for
> a device. Specifically, the patch generates a device tree node for Xilinx
> Alveo U50 PCIe accelerator device. The generated device tree nodes do not
> have any property. Future patches will add the necessary properties.
> 
> Clément Léger (1):
>   of: dynamic: add of_node_alloc()
> 
> Lizhi Hou (1):
>   pci: create device tree node for selected devices
> 
>  drivers/of/dynamic.c        |  50 +++++++++++++----
>  drivers/pci/Kconfig         |  11 ++++
>  drivers/pci/bus.c           |   2 +
>  drivers/pci/msi/irqdomain.c |   6 +-
>  drivers/pci/of.c            | 106 ++++++++++++++++++++++++++++++++++++
>  drivers/pci/pci-driver.c    |   3 +-
>  drivers/pci/pci.h           |  16 ++++++
>  drivers/pci/quirks.c        |  11 ++++
>  drivers/pci/remove.c        |   1 +
>  include/linux/of.h          |   7 +++
>  10 files changed, 200 insertions(+), 13 deletions(-)
> 
> -- 
> 2.27.0
> 
