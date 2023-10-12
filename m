Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF947C7352
	for <lists+linux-pci@lfdr.de>; Thu, 12 Oct 2023 18:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379320AbjJLQnm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Oct 2023 12:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379499AbjJLQnk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Oct 2023 12:43:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBE6CA;
        Thu, 12 Oct 2023 09:43:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E58FC433C9;
        Thu, 12 Oct 2023 16:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697129018;
        bh=kfDTZe6bHsXYEX/cMTdKPK0HJuuqElf7yFpIZAfZdrk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=gpYnHIXtG/AI/50xVzbgYh9ZokHe+LC/HTuonFQ8uuofa9ptBdl+zXb+0i/ZAyT7A
         nnkuqvny8W8DYDl2GaQiS9Pmz1pjdOfpLilw2xnVdxn8waw8ZXkKiQN3vxRvjgZaEh
         PisSURAbi4YwOzw7LaMT+326xWgzSPAE91WS6p77Q4B0QLnvr8K3eI2hRrweV7K3qk
         r6d6B7wpgHFoqR6rdmmaqULxVKtPQ8tKxKzYud1GpmUvPlFYDJvIcNtnewv5Tr1oXp
         Riv7CkBMw6pspHVdC9vDShg5cUBCmrNw30jZ4j/JGqyFW98zghqXY2ZVYtwvriiIcL
         Pj3IZl871HUsg==
Date:   Thu, 12 Oct 2023 11:43:36 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Siddharth Vadapalli <s-vadapalli@ti.com>
Cc:     lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        r-gunasekaran@ti.com, srk@ti.com
Subject: Re: [PATCH] PCI: keystone: Don't enable BAR0 if link is not detected
Message-ID: <20231012164336.GA1072823@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e1f574c-6b36-c6e1-9153-90d599e2aaa7@ti.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 12, 2023 at 10:15:09AM +0530, Siddharth Vadapalli wrote:
> Hello Bjorn,
> 
> Thank you for reviewing the patch.
> 
> On 11/10/23 19:16, Bjorn Helgaas wrote:
> > Hi Siddharth,
> > 
> > On Wed, Oct 11, 2023 at 06:04:51PM +0530, Siddharth Vadapalli wrote:
> >> Since the function dw_pcie_host_init() ignores the absence of link under
> >> the assumption that link can come up later, it is possible that the
> >> pci_host_probe(bridge) function is invoked even when no endpoint device
> >> is connected. In such a situation, the ks_pcie_v3_65_add_bus() function
> >> configures BAR0 when the link is not up, resulting in Completion Timeouts
> >> during the MSI configuration performed later by the PCI Express Port driver
> >> to setup AER, PME and other services. Thus, leave BAR0 disabled if link is
> >> not yet detected when the ks_pcie_v3_65_add_bus() function is invoked.
> > 
> > I'm trying to make sense of this.  In this path:
> > 
> >   pci_host_probe
> >     pci_scan_root_bus_bridge
> >       pci_register_host_bridge
> > 	bus = pci_alloc_bus(NULL)    # root bus
> > 	bus->ops->add_bus(bus)
> > 	  ks_pcie_v3_65_add_bus
> > 
> > The BAR0 in question must belong to a Root Port.  And it sounds like
> > the issue must be related to MSI-X, since the original MSI doesn't
> > involve any BARs.
> 
> Yes, the issue is related to MSI-X. I will list down the exact set of function
> calls below as well as the place where the completion timeout first occurs:
> ks_pcie_probe
>   dw_pcie_host_init
>     pci_host_probe
>       pci_bus_add_devices
>         pci_bus_add_device
>           device_attach
>             __device_attach
>               bus_for_each_drv
>                 __device_attach_driver (invoked using fn(drv, data))
>                   driver_probe_device
>                     __driver_probe_device
>                       really_probe
>                         pci_device_probe
>                           pcie_portdrv_probe
>                             pcie_port_device_register
>                               pcie_init_service_irqs
>                                 pcie_port_enable_irq_vec
>                                   pci_alloc_irq_vectors
>                                     pci_alloc_irq_vectors_affinity
>                                       __pci_enable_msix_range
>                                         msix_capability_init
>                                           msix_setup_interrupts
>                                             msix_setup_msi_descs
>                                               msix_prepare_msi_desc
> In this function: msix_prepare_msi_desc, the following readl()
> causes completion timeout:
> 		desc->pci.msix_ctrl = readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
> The completion timeout with the readl is only observed when the link
> is down (No Endpoint device is actually connected to the PCIe
> connector slot).

Do you know the address ("addr")?  From pci_msix_desc_addr(), it looks
like it should be:

  desc->pci.mask_base + desc->msi_index * PCI_MSIX_ENTRY_SIZE

and desc->pci.mask_base should be dev->msix_base, which we got from
msix_map_region(), which ioremaps part of the BAR indicated by the
MSI-X Table Offset/Table BIR register.

I wonder if this readl() is being handled as an MMIO access to a
downstream device instead of a Root Port BAR access because it's
inside the Root Port's MMIO window.

Could you dump out these values just before the readl()?

  phys_addr inside msix_map_region()
  dev->msix_base
  desc->pci.mask_base
  desc->msi_index
  addr
  call early_dump_pci_device() on the Root Port

Bjorn
