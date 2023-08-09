Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA95D776C7E
	for <lists+linux-pci@lfdr.de>; Thu, 10 Aug 2023 00:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjHIW5m (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Aug 2023 18:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjHIW5m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Aug 2023 18:57:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DF0E52;
        Wed,  9 Aug 2023 15:57:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B353364BAC;
        Wed,  9 Aug 2023 22:57:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB10AC433C8;
        Wed,  9 Aug 2023 22:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691621860;
        bh=Ql3to1IJwpgeRfj699MkiCOXh7sBIqi9/cjNmbZWUTk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=RUHWRltkPA12Kj2DgZ8R48fvhAXnicqOstELHQsrAvyvWUBELc4u1PdBAZPAyguWy
         WChH7oCMVkyfBE9uTULypcNdxec1eisFBS3m/KWOIgxWWYscvPTXVIHPzWvu4zUIUn
         bOCK6lLH62yMUBP8j4n40IO6q+EcPoZupQPms4vnT6Ks927I96c+kbuInvK9eeubNT
         xudYXUo6Jit2aI9Wb2qrwiuK6NB00kO3EeDQvFXNkJUYCU8UIvmtMp2L/yUMb/IAEY
         4ER4xpVL4TLFxWMMp/nLlr0NVPe5vKlejv1zI+7pP1wMIk+7qHEvG0G6S50GoYw3cP
         lcNd77Zpvhz1Q==
Date:   Wed, 9 Aug 2023 17:57:38 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh@kernel.org, max.zhen@amd.com,
        sonal.santan@amd.com, stefano.stabellini@xilinx.com,
        Lizhi Hou <lizhi.hou@amd.com>
Subject: Re: [PATCH V12 0/5] Generate device tree node for pci devices
Message-ID: <20230809225738.GA11578@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1690564018-11142-1-git-send-email-lizhi.hou@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Rob, I'm assuming this series is yours; I've acked the drivers/pci
parts.  Let me know if otherwise.

On Fri, Jul 28, 2023 at 10:06:53AM -0700, Lizhi Hou wrote:
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
> The second patch introduces a kernel option, CONFIG_PCI_DYNAMIC_OF_NODES.
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
> 
> # lspci -t
> -[0000:00]-+-00.0
>            +-01.0
>            +-03.0-[01-03]----00.0-[02-03]----00.0-[03]----00.0
>            +-03.1-[04]--
>            \-04.0-[05-06]----00.0-[06]--
> 
> Without CONFIG_PCI_DYNAMIC_OF_NODES
> 
> # tree /sys/firmware/devicetree/base/pcie@10000000/
> /sys/firmware/devicetree/base/pcie@10000000/
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
> |-- ranges
> `-- reg
> 
> With CONFIG_PCI_DYNAMIC_OF_NODES
> 
> # tree /sys/firmware/devicetree/base/pcie@10000000/
> /sys/firmware/devicetree/base/pcie@10000000/
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
> |   |-- #interrupt-cells
> |   |-- #size-cells
> |   |-- bus-range
> |   |-- compatible
> |   |-- device_type
> |   |-- interrupt-map
> |   |-- interrupt-map-mask
> |   |-- interrupts
> |   |-- pci@0,0
> |   |   |-- #address-cells
> |   |   |-- #interrupt-cells
> |   |   |-- #size-cells
> |   |   |-- bus-range
> |   |   |-- compatible
> |   |   |-- device_type
> |   |   |-- interrupt-map
> |   |   |-- interrupt-map-mask
> |   |   |-- pci@0,0
> |   |   |   |-- #address-cells
> |   |   |   |-- #interrupt-cells
> |   |   |   |-- #size-cells
> |   |   |   |-- bus-range
> |   |   |   |-- compatible
> |   |   |   |-- dev@0,0
> |   |   |   |   |-- #address-cells
> |   |   |   |   |-- #size-cells
> |   |   |   |   |-- compatible
> |   |   |   |   |-- ranges
> |   |   |   |   `-- reg
> |   |   |   |-- device_type
> |   |   |   |-- interrupt-map
> |   |   |   |-- interrupt-map-mask
> |   |   |   |-- ranges
> |   |   |   `-- reg
> |   |   |-- ranges
> |   |   `-- reg
> |   |-- ranges
> |   `-- reg
> |-- pci@3,1
> |   |-- #address-cells
> |   |-- #interrupt-cells
> |   |-- #size-cells
> |   |-- bus-range
> |   |-- compatible
> |   |-- device_type
> |   |-- interrupt-map
> |   |-- interrupt-map-mask
> |   |-- interrupts
> |   |-- ranges
> |   `-- reg
> |-- pci@4,0
> |   |-- #address-cells
> |   |-- #interrupt-cells
> |   |-- #size-cells
> |   |-- bus-range
> |   |-- compatible
> |   |-- device_type
> |   |-- interrupt-map
> |   |-- interrupt-map-mask
> |   |-- pci@0,0
> |   |   |-- #address-cells
> |   |   |-- #interrupt-cells
> |   |   |-- #size-cells
> |   |   |-- bus-range
> |   |   |-- compatible
> |   |   |-- device_type
> |   |   |-- interrupt-map
> |   |   |-- interrupt-map-mask
> |   |   |-- interrupts
> |   |   |-- ranges
> |   |   `-- reg
> |   |-- ranges
> |   `-- reg
> |-- ranges
> `-- reg
> 
> Changes since v11:
> - Create interrupt related properties
> 
> Changes since v10:
> - Remove 'dynamic' property
> 
> Changes since v9:
> - Introduce 'dynamic' property to identify dynamically generated device tree
>   node for PCI device
> - Added 'bus-range' property to remove dtc warnings
> - Minor code review fixes
> 
> Changes since v8:
> - Added patches to create unit test to verifying address translation
>     The test relies on QEMU PCI Test Device, please see
>         https://github.com/houlz0507/xoclv2/blob/pci-dt-0329/pci-dt-patch-0329/README
>     for test setup
> - Minor code review fixes
> 
> Changes since v7:
> - Modified dynamic node creation interfaces
> - Added unittest for new added interfaces
> 
> Changes since v6:
> - Removed single line wrapper functions
> - Added Signed-off-by Clément Léger <clement.leger@bootlin.com>
> 
> Changes since v5:
> - Fixed code review comments
> - Fixed incorrect 'ranges' and 'reg' properties
> 
> Changes since RFC v4:
> - Fixed code review comments
> 
> Changes since RFC v3:
> - Split the Xilinx Alveo U50 PCI quirk to a separate patch
> - Minor changes in commit description and code comment
> 
> Changes since RFC v2:
> - Merged patch 3 with patch 2
> - Added OF interfaces of_changeset_add_prop_* and use them to create
>   properties.
> - Added '#address-cells', '#size-cells' and 'ranges' properties.
> 
> Changes since RFC v1:
> - Added one patch to create basic properties.
> - To move DT related code out of PCI subsystem, replaced of_node_alloc()
>   with of_create_node()/of_destroy_node()
> 
> Lizhi Hou (5):
>   of: dynamic: Add interfaces for creating device node dynamically
>   PCI: Create device tree node for bridge
>   PCI: Add quirks to generate device tree node for Xilinx Alveo U50
>   of: overlay: Extend of_overlay_fdt_apply() to specify the target node
>   of: unittest: Add pci_dt_testdrv pci driver
> 
>  drivers/of/dynamic.c                          | 164 ++++++++
>  drivers/of/overlay.c                          |  42 ++-
>  drivers/of/unittest-data/Makefile             |   3 +-
>  .../of/unittest-data/overlay_pci_node.dtso    |  22 ++
>  drivers/of/unittest.c                         | 211 ++++++++++-
>  drivers/pci/Kconfig                           |  12 +
>  drivers/pci/Makefile                          |   1 +
>  drivers/pci/bus.c                             |   2 +
>  drivers/pci/of.c                              |  79 ++++
>  drivers/pci/of_property.c                     | 355 ++++++++++++++++++
>  drivers/pci/pci.h                             |  12 +
>  drivers/pci/quirks.c                          |  12 +
>  drivers/pci/remove.c                          |   1 +
>  include/linux/of.h                            |  25 +-
>  14 files changed, 926 insertions(+), 15 deletions(-)
>  create mode 100644 drivers/of/unittest-data/overlay_pci_node.dtso
>  create mode 100644 drivers/pci/of_property.c
> 
> -- 
> 2.34.1
> 
