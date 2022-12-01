Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E6963F9C6
	for <lists+linux-pci@lfdr.de>; Thu,  1 Dec 2022 22:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbiLAV1l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Dec 2022 16:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiLAV1k (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Dec 2022 16:27:40 -0500
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B0A11458;
        Thu,  1 Dec 2022 13:27:38 -0800 (PST)
Received: by mail-oi1-f173.google.com with SMTP id c129so3499220oia.0;
        Thu, 01 Dec 2022 13:27:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dj0X/cgIRdzA9X8MaAiSgQ8IQIvJqEsW1E/SH7uOhAc=;
        b=8NnssgGDimV249OpBqoU/S6CXd695qoEUjUbIl6dCX5WZq9hTJoaSDrQX5jYsv/m+c
         dVanzHjU1r3iNd4oQYiOj9zKwBGz22ZWC+s/IGCxdpQo5Vo5Pvs+IBMVTScd0Nn5e0vB
         afwqdb6lvB/hrDLa7oYjBHTCAQ8RfSX2vJbt4b5PZHeLrhhIEpokeEsYbojslI/cHimB
         NXnDn/hS9pcbH58xEWCv9r5/hFLPeg+T8Al1l4CStWs3R+NIMjCn6jMVoI1w4znebrp5
         kngaTMl9Jm8g6pAdKpZGXdY4W56BF9cUvY/kmUOPtH9209dXAB9xWVkwR83GIMbktLFJ
         /Hlw==
X-Gm-Message-State: ANoB5pk+5YBYhUTHJFEHB4fmlk8cOa2IUXBond22RQeLm3Wr2phPI1mf
        lSVzqYi/R1ah7JnNg2XU+Q==
X-Google-Smtp-Source: AA0mqf4cecGy5n8P7THiVs09tNFE2eEpF6icE6MFbjl/YV7Fo/7CpjcTb7Q1w6k01nE5ZiA/uqXmdg==
X-Received: by 2002:a05:6808:1a18:b0:35b:dac6:cc84 with SMTP id bk24-20020a0568081a1800b0035bdac6cc84mr3780814oib.116.1669930057593;
        Thu, 01 Dec 2022 13:27:37 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ca19-20020a056830611300b00661a3f4113bsm2598515otb.64.2022.12.01.13.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 13:27:36 -0800 (PST)
Received: (nullmailer pid 1472667 invoked by uid 1000);
        Thu, 01 Dec 2022 21:27:35 -0000
Date:   Thu, 1 Dec 2022 15:27:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sonal Santan <sonal.santan@amd.com>
Cc:     Lizhi Hou <lizhi.hou@amd.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        frowand.list@gmail.com, helgaas@kernel.org,
        clement.leger@bootlin.com, max.zhen@amd.com, larry.liu@amd.com,
        brian.xu@amd.com, stefano.stabellini@xilinx.com, trix@redhat.com
Subject: Re: [RESEND PATCH RFC V4 0/3] Generate device tree node for pci
 devices
Message-ID: <20221201212735.GC1225112-robh@kernel.org>
References: <1669048984-56394-1-git-send-email-lizhi.hou@amd.com>
 <9d21aa8f-6581-a4bf-644a-6e273373afc4@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d21aa8f-6581-a4bf-644a-6e273373afc4@amd.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 30, 2022 at 09:50:56PM -0800, Sonal Santan wrote:
> On 11/21/22 08:43, Lizhi Hou wrote:
> > This patch series introduces OF overlay support for PCI devices which
> > primarily addresses two use cases. First, it provides a data driven method
> > to describe hardware peripherals that are present in a PCI endpoint and
> > hence can be accessed by the PCI host. Second, it allows reuse of a OF
> > compatible driver -- often used in SoC platforms -- in a PCI host based
> > system.
> > 
> > There are 2 series devices rely on this patch:
> > 
> >   1) Xilinx Alveo Accelerator cards (FPGA based device)
> >   2) Microchip LAN9662 Ethernet Controller
> > 
> >      Please see: https://lore.kernel.org/lkml/20220427094502.456111-1-clement.leger@bootlin.com/
> > 
> > Normally, the PCI core discovers PCI devices and their BARs using the
> > PCI enumeration process. However, the process does not provide a way to
> > discover the hardware peripherals that are present in a PCI device, and
> > which can be accessed through the PCI BARs. Also, the enumeration process
> > does not provide a way to associate MSI-X vectors of a PCI device with the
> > hardware peripherals that are present in the device. PCI device drivers
> > often use header files to describe the hardware peripherals and their
> > resources as there is no standard data driven way to do so. This patch
> > series proposes to use flattened device tree blob to describe the
> > peripherals in a data driven way. Based on previous discussion, using
> > device tree overlay is the best way to unflatten the blob and populate
> > platform devices. To use device tree overlay, there are three obvious
> > problems that need to be resolved.
> > 
> > First, we need to create a base tree for non-DT system such as x86_64. A
> > patch series has been submitted for this:
> > https://lore.kernel.org/lkml/20220624034327.2542112-1-frowand.list@gmail.com/
> > https://lore.kernel.org/lkml/20220216050056.311496-1-lizhi.hou@xilinx.com/
> > 
> > Second, a device tree node corresponding to the PCI endpoint is required
> > for overlaying the flattened device tree blob for that PCI endpoint.
> > Because PCI is a self-discoverable bus, a device tree node is usually not
> > created for PCI devices. This series adds support to generate a device
> > tree node for a PCI device which advertises itself using PCI quirks
> > infrastructure.
> > 
> > Third, we need to generate device tree nodes for PCI bridges since a child
> > PCI endpoint may choose to have a device tree node created.
> > 
> > This patch series is made up of three patches.
> > 
> > The first patch is adding OF interface to create or destroy OF node
> > dynamically.
> > 
> > The second patch introduces a kernel option, CONFIG_DYNAMIC_PCI_OF_NODEX.
> > When the option is turned on, the kernel will generate device tree nodes
> > for all PCI bridges unconditionally. The patch also shows how to use the
> > PCI quirks infrastructure, DECLARE_PCI_FIXUP_FINAL to generate a device
> > tree node for a device. Specifically, the patch generates a device tree
> > node for Xilinx Alveo U50 PCIe accelerator device. The generated device
> > tree nodes do not have any property.
> > 
> > The third patch adds basic properties ('reg', 'compatible' and
> > 'device_type') to the dynamically generated device tree nodes. More
> > properties can be added in the future.
> > 
> > Here is the example of device tree nodes generated within the ARM64 QEMU.
> > # lspci -t    
> > -[0000:00]-+-00.0
> >            +-01.0-[01]--
> >            +-01.1-[02]----00.0
> >            +-01.2-[03]----00.0
> >            +-01.3-[04]----00.0
> >            +-01.4-[05]----00.0
> >            +-01.5-[06]--
> >            +-01.6-[07]--
> >            +-01.7-[08]--
> >            +-02.0-[09-0b]----00.0-[0a-0b]----00.0-[0b]--+-00.0
> >            |                                            \-00.1
> >            +-02.1-[0c]--
> >            \-03.0-[0d-0e]----00.0-[0e]----01.0
> > 
> > # tree /sys/firmware/devicetree/base/pcie\@10000000
> > /sys/firmware/devicetree/base/pcie@10000000
> > |-- #address-cells
> > |-- #interrupt-cells
> > |-- #size-cells
> > |-- bus-range
> > |-- compatible
> > |-- device_type
> > |-- dma-coherent
> > |-- interrupt-map
> > |-- interrupt-map-mask
> > |-- linux,pci-domain
> > |-- msi-parent
> > |-- name
> > |-- pci@1,0
> > |   |-- #address_cells
> > |   |-- #size_cells
> > |   |-- compatible
> > |   |-- device_type
> > |   |-- ranges
> > |   `-- reg
> > |-- pci@1,1
> > |   |-- #address_cells
> > |   |-- #size_cells
> > |   |-- compatible
> > |   |-- device_type
> > |   |-- ranges
> > |   `-- reg
> > |-- pci@1,2
> > |   |-- #address_cells
> > |   |-- #size_cells
> > |   |-- compatible
> > |   |-- device_type
> > |   |-- ranges
> > |   `-- reg
> > |-- pci@1,3
> > |   |-- #address_cells
> > |   |-- #size_cells
> > |   |-- compatible
> > |   |-- device_type
> > |   |-- ranges
> > |   `-- reg
> > |-- pci@1,4
> > |   |-- #address_cells
> > |   |-- #size_cells
> > |   |-- compatible
> > |   |-- device_type
> > |   |-- ranges
> > |   `-- reg
> > |-- pci@1,5
> > |   |-- #address_cells
> > |   |-- #size_cells
> > |   |-- compatible
> > |   |-- device_type
> > |   |-- ranges
> > |   `-- reg
> > |-- pci@1,6
> > |   |-- #address_cells
> > |   |-- #size_cells
> > |   |-- compatible
> > |   |-- device_type
> > |   |-- ranges
> > |   `-- reg
> > |-- pci@1,7
> > |   |-- #address_cells
> > |   |-- #size_cells
> > |   |-- compatible
> > |   |-- device_type
> > |   |-- ranges
> > |   `-- reg
> > |-- pci@2,0
> > |   |-- #address_cells
> > |   |-- #size_cells
> > |   |-- compatible
> > |   |-- device_type
> > |   |-- pci@0,0
> > |   |   |-- #address_cells
> > |   |   |-- #size_cells
> > |   |   |-- compatible
> > |   |   |-- device_type
> > |   |   |-- pci@0,0
> > |   |   |   |-- #address_cells
> > |   |   |   |-- #size_cells
> > |   |   |   |-- compatible
> > |   |   |   |-- dev@0,0
> > |   |   |   |   |-- compatible
> > |   |   |   |   `-- reg
> > |   |   |   |-- dev@0,1
> > |   |   |   |   |-- compatible
> > |   |   |   |   `-- reg
> > |   |   |   |-- device_type
> > |   |   |   |-- ranges
> > |   |   |   `-- reg
> > |   |   |-- ranges
> > |   |   `-- reg
> > |   |-- ranges
> > |   `-- reg
> > |-- pci@2,1
> > |   |-- #address_cells
> > |   |-- #size_cells
> > |   |-- compatible
> > |   |-- device_type
> > |   |-- ranges
> > |   `-- reg
> > |-- pci@3,0
> > |   |-- #address_cells
> > |   |-- #size_cells
> > |   |-- compatible
> > |   |-- device_type
> > |   |-- pci@0,0
> > |   |   |-- #address_cells
> > |   |   |-- #size_cells
> > |   |   |-- compatible
> > |   |   |-- device_type
> > |   |   |-- ranges
> > |   |   `-- reg
> > |   |-- ranges
> > |   `-- reg
> > |-- ranges
> > `-- reg
> > 
> > Changes since RFC v3:
> > - Split the Xilinx Alveo U50 PCI quirk to a separate patch
> > - Minor changes in commit description and code comment
> > 
> > Changes since RFC v2:
> > - Merged patch 3 with patch 2
> > - Added OF interfaces of_changeset_add_prop_* and use them to create
> >   properties.
> > - Added '#address-cells', '#size-cells' and 'ranges' properties.
> > 
> > Changes since RFC v1:
> > - Added one patch to create basic properties.
> > - To move DT related code out of PCI subsystem, replaced of_node_alloc()
> >   with of_create_node()/of_destroy_node()
> > 
> > Lizhi Hou (3):
> >   of: dynamic: Add interfaces for creating device node dynamically
> >   PCI: Create device tree node for selected devices
> >   PCI: Add PCI quirks to generate device tree node for Xilinx Alveo U50
> > 
> >  drivers/of/dynamic.c        | 187 ++++++++++++++++++++++++++
> >  drivers/pci/Kconfig         |  12 ++
> >  drivers/pci/Makefile        |   1 +
> >  drivers/pci/bus.c           |   2 +
> >  drivers/pci/msi/irqdomain.c |   6 +-
> >  drivers/pci/of.c            |  71 ++++++++++
> >  drivers/pci/of_property.c   | 256 ++++++++++++++++++++++++++++++++++++
> >  drivers/pci/pci-driver.c    |   3 +-
> >  drivers/pci/pci.h           |  19 +++
> >  drivers/pci/quirks.c        |  11 ++
> >  drivers/pci/remove.c        |   1 +
> >  include/linux/of.h          |  24 ++++
> >  12 files changed, 590 insertions(+), 3 deletions(-)
> >  create mode 100644 drivers/pci/of_property.c
> > 
> Hello,
> 
> This RFC patch set has been patiently waiting for attention. If there
> are no additional comments can it move forward?

Note that "RFC" means "here's my patches I don't think are ready to be 
merged". That should have a list of issues/todo.

I'm not getting a good sense that possible issues are being thought 
about here. If I'm supposed to do that, then you'll just have to wait.

Rob
