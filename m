Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F03C7390B1
	for <lists+linux-pci@lfdr.de>; Wed, 21 Jun 2023 22:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjFUUXr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Jun 2023 16:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjFUUXq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Jun 2023 16:23:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDF9199D;
        Wed, 21 Jun 2023 13:23:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35D0A6152D;
        Wed, 21 Jun 2023 20:23:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67FC7C433C0;
        Wed, 21 Jun 2023 20:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687379022;
        bh=aaLUcxEP56OuOzyu02GfU4Copg1pPFMxPa6rXNRiL+M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=cHjyMXrhJ0W2drFpcsgseDpB69zb7lEpDZR5sc1VpGtxeW/6OjxfhECkOh7vkChlo
         XIpP5FmPF2zLUHMd+WzU243Xlm91TVA7bzqIey2keFfdBYgc7acecf5IMWqXOtS0/U
         JhragsT3aedvOzFm7fe4gxS+MRkBIVSvnzejjGPxzwby8+X20vQGXb6fxBkuiZV1bw
         8BJvjjvaEjEDQhQhPCjB3QIQbFWbGmV51i76Iya//NxcdKFppGerKLiRX2wvkyl3sW
         2+865c0sL8rb4yNUu+WtS32s2V4fGA5jM2qDIw8Pbo4ztO+N5jDbz8XRGem4DDVqcC
         2Y7QFv7wT+AGw==
Date:   Wed, 21 Jun 2023 15:23:40 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lizhi Hou <lizhi.hou@amd.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh@kernel.org, max.zhen@amd.com,
        sonal.santan@amd.com, stefano.stabellini@xilinx.com
Subject: Re: [PATCH V9 0/5] Generate device tree node for pci devices
Message-ID: <20230621202340.GA115806@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1687368849-36722-1-git-send-email-lizhi.hou@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 21, 2023 at 10:34:04AM -0700, Lizhi Hou wrote:
> This patch series introduces OF overlay support for PCI devices which
> primarily addresses two use cases. First, it provides a data driven method
> to describe hardware peripherals that are present in a PCI endpoint and
> hence can be accessed by the PCI host. Second, it allows reuse of a OF
> compatible driver -- often used in SoC platforms -- in a PCI host based
> system.
> 
> There are 2 series devices rely on this patch:
> 
>   1) Xilinx Alveo Accelerator cards (FPGA based device)
>   2) Microchip LAN9662 Ethernet Controller
> 
>      Please see: https://lore.kernel.org/lkml/20220427094502.456111-1-clement.leger@bootlin.com/
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
> This patch series is made up of three patches.
> 
> The first patch is adding OF interface to create or destroy OF node
> dynamically.
> 
> The second patch introduces a kernel option, CONFIG_DYNAMIC_PCI_OF_NODEX.

In case this log becomes part of the merge commit or something,

s/CONFIG_DYNAMIC_PCI_OF_NODEX/CONFIG_PCI_DYNAMIC_OF_NODES/

> When the option is turned on, the kernel will generate device tree nodes
> for all PCI bridges unconditionally. The patch also shows how to use the
> PCI quirks infrastructure, DECLARE_PCI_FIXUP_FINAL to generate a device
> tree node for a device. Specifically, the patch generates a device tree
> node for Xilinx Alveo U50 PCIe accelerator device. The generated device
> tree nodes do not have any property.
> 
> The third patch adds basic properties ('reg', 'compatible' and
> 'device_type') to the dynamically generated device tree nodes. More
> properties can be added in the future.
> 
> Here is the example of device tree nodes generated within the ARM64 QEMU.

It's not obvious to me what was there originally and what was added
because of this series.

> # lspci -t
> -[0000:00]-+-00.0
>            +-01.0
>            +-03.0-[01-03]----00.0-[02-03]----00.0-[03]----00.0
>            +-03.1-[04]--
>            \-04.0-[05-06]----00.0-[06]--
> # tree /sys/firmware/devicetree/base/pcie\@10000000
> /sys/firmware/devicetree/base/pcie@10000000
> |-- #address-cells
> |-- #interrupt-cells
> |-- #size-cells
> |-- bus-range
> |-- compatible
> |-- device_type
> |-- dma-coherent
> |-- interrupt-map
> |-- interrupt-map-mask
> |-- linux,pci-domain
> |-- msi-map
> |-- name
> |-- pci@3,0
> |   |-- #address-cells
> |   |-- #size-cells
> |   |-- compatible
> |   |-- device_type
> |   |-- pci@0,0
> |   |   |-- #address-cells
> |   |   |-- #size-cells
> |   |   |-- compatible
> |   |   |-- device_type
> |   |   |-- pci@0,0
> |   |   |   |-- #address-cells
> |   |   |   |-- #size-cells
> |   |   |   |-- compatible
> |   |   |   |-- dev@0,0
> |   |   |   |   |-- #address-cells
> |   |   |   |   |-- #size-cells
> |   |   |   |   |-- compatible
> |   |   |   |   |-- ranges
> |   |   |   |   `-- reg
> |   |   |   |-- device_type
> |   |   |   |-- ranges
> |   |   |   `-- reg
> |   |   |-- ranges
> |   |   `-- reg
> |   |-- ranges
> |   `-- reg
> |-- pci@3,1
> |   |-- #address-cells
> |   |-- #size-cells
> |   |-- compatible
> |   |-- device_type
> |   |-- ranges
> |   `-- reg
> |-- pci@4,0
> |   |-- #address-cells
> |   |-- #size-cells
> |   |-- compatible
> |   |-- device_type
> |   |-- pci@0,0
> |   |   |-- #address-cells
> |   |   |-- #size-cells
> |   |   |-- compatible
> |   |   |-- device_type
> |   |   |-- ranges
> |   |   `-- reg
> |   |-- ranges
> |   `-- reg
> |-- ranges
> `-- reg
