Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA8C73773C
	for <lists+linux-pci@lfdr.de>; Wed, 21 Jun 2023 00:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjFTWIX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Jun 2023 18:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjFTWIW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Jun 2023 18:08:22 -0400
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384331A3;
        Tue, 20 Jun 2023 15:08:21 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-77e4126badcso58703239f.0;
        Tue, 20 Jun 2023 15:08:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687298900; x=1689890900;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8xKzKR2Jor9yZCbhpw4RdY2UISdl+Ggxh4g2WL/oLeg=;
        b=WtJlr+dupl9DWA+Wh18J+J4B9GNAft1925aNh0bC8odvMg6yQmSC/uJGUQNvAy4xv/
         BJlFmq6Lw57BE9S/VJUt+NwSKqG/SEVq/jc1tLUremLeu331gHThCScxpuQHONCgbx56
         lRl71AWQeHepbXqo48RssRBxEU/wA03u66eN8rsveh4OCIdklGpAwMtVBafiy1/WKMag
         2zSexwoQ6mhgrRRx7ruhpBHsJ9NvJDRUFujRWLwU4ziti1d7eB3s5sgUUfJzbNc2cOe2
         6JXuyVil5PQ5MPFrPebM8ECOw+6CoxZDec7RN+AlqPToVI+BZ7Z0j4UJNzUE8SrlnROc
         KD9A==
X-Gm-Message-State: AC+VfDwXC+gs1rZoCA3AMMipIvv4yr/c7f1JvfZ6qHujmVi/Ez16btMO
        0HUkOlaveZ4NkKyh5K2BWA==
X-Google-Smtp-Source: ACHHUZ6unWPBNLKgchBLuE7qgRlqFSbqyeauk8e+P+n4dec4D7VMgpColOqNBilDMBuemoSIDpRgKw==
X-Received: by 2002:a5d:9e58:0:b0:774:871d:6a06 with SMTP id i24-20020a5d9e58000000b00774871d6a06mr8353213ioi.2.1687298900431;
        Tue, 20 Jun 2023 15:08:20 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id i25-20020a02ca59000000b0041d759c451asm876162jal.166.2023.06.20.15.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 15:08:19 -0700 (PDT)
Received: (nullmailer pid 424551 invoked by uid 1000);
        Tue, 20 Jun 2023 22:08:18 -0000
Date:   Tue, 20 Jun 2023 16:08:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lizhi Hou <lizhi.hou@amd.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, max.zhen@amd.com,
        sonal.santan@amd.com, stefano.stabellini@xilinx.com
Subject: Re: [PATCH V9 0/6] Generate device tree node for pci devices
Message-ID: <20230620220818.GA418170-robh@kernel.org>
References: <1686847842-33780-1-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1686847842-33780-1-git-send-email-lizhi.hou@amd.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 15, 2023 at 09:50:36AM -0700, Lizhi Hou wrote:
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
> Lizhi Hou (6):
>   of: dynamic: Add interfaces for creating device node dynamically
>   PCI: Create device tree node for selected devices
>   PCI: Add PCI quirks to generate device tree node for Xilinx Alveo U50
>   PCI: Add ranges property for pci endpoint
>   of: overlay: Extend of_overlay_fdt_apply() to specify the target node
>   of: unittest: Add pci_dt_testdrv pci driver
> 
>  drivers/of/dynamic.c                          | 164 ++++++++++++++
>  drivers/of/overlay.c                          |  42 +++-
>  drivers/of/unittest-data/Makefile             |   3 +-
>  .../of/unittest-data/overlay_pci_node.dtso    |  22 ++
>  drivers/of/unittest.c                         | 210 +++++++++++++++++-
>  drivers/pci/Kconfig                           |  12 +
>  drivers/pci/Makefile                          |   1 +
>  drivers/pci/bus.c                             |   2 +
>  drivers/pci/of.c                              |  81 ++++++-
>  drivers/pci/of_property.c                     | 190 ++++++++++++++++
>  drivers/pci/pci.h                             |  19 ++
>  drivers/pci/quirks.c                          |  12 +
>  drivers/pci/remove.c                          |   1 +
>  include/linux/of.h                            |  25 ++-
>  14 files changed, 768 insertions(+), 16 deletions(-)
>  create mode 100644 drivers/of/unittest-data/overlay_pci_node.dtso
>  create mode 100644 drivers/pci/of_property.c

Bjorn, I think this is pretty close to being in shape for merging. Do 
you have any comments on the PCI bits? Would you prefer that I ack the 
DT bit and you take it or vice-versa?

Rob
