Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5681A79B1A1
	for <lists+linux-pci@lfdr.de>; Tue, 12 Sep 2023 01:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350472AbjIKVir (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Sep 2023 17:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244471AbjIKUho (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Sep 2023 16:37:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02BE127;
        Mon, 11 Sep 2023 13:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694464658; x=1726000658;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=/9BP9zKlaz6FdwO5Fmzt1TO6pHP3R1/+I+S+8iwDxmw=;
  b=iAyO7WCs2SMjE88d1fQKzzCiQVLunzn2pYcZnrd3smarQ2hShLaiCcn5
   sSr/NZL0G0UPXCHKwZwr6TmPALLFc69P3fWyxGwEd7sRrH78+9UYEcSGb
   fYhct1e1uqpoLu5FPKigU8Uv9i2aC0WMveuyjc/dSWNJ7gL0eS/UlK3Sp
   Z8XqBR+8J/CA9eb/15LQkEwf2f3305xwvopeT5vq37c46ar2ve9dHKgzO
   SQb9vVpauWubH7nCNnWUorqsa6fqdNGSQXTnHlETKt/H4C4sfXPdyNeUk
   o/mDyzFaQ1Uycf8+HkRYZyDHjpyIBl1I2w8fiZmg2NKd0IGPXvAlztFAB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="444630933"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="444630933"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 13:37:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="858482054"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="858482054"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 13:37:20 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qfnen-008Q1O-1H;
        Mon, 11 Sep 2023 23:37:17 +0300
Date:   Mon, 11 Sep 2023 23:37:17 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Lizhi Hou <lizhi.hou@amd.com>, Andrew Lunn <andrew@lunn.ch>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh@kernel.org, max.zhen@amd.com,
        sonal.santan@amd.com, stefano.stabellini@xilinx.com
Subject: Re: [PATCH V13 0/5] Generate device tree node for pci devices
Message-ID: <ZP96feVs2ev7098Y@smile.fi.intel.com>
References: <1692120000-46900-1-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1692120000-46900-1-git-send-email-lizhi.hou@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 15, 2023 at 10:19:55AM -0700, Lizhi Hou wrote:
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

I believe you should Cc this to Andrew Lunn for the comments.
IIRC something similar was tried to being solved for DSA (?)
devices where SFP hotpluggable hardware can be attached or
detached at run-time (sorry if I messes / mixing up things,
I wrote this from my memory, might be completely wrong).

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

Can you point out to the ACPI excerpt(s) of the description of anything related
to the device(s) in question?

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
> Changes since v12:
> - Minor fix for kernel test robot warning
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

-- 
With Best Regards,
Andy Shevchenko


