Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48742379571
	for <lists+linux-pci@lfdr.de>; Mon, 10 May 2021 19:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbhEJRZk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 May 2021 13:25:40 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3054 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbhEJRZj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 May 2021 13:25:39 -0400
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ff74g16Zmz6sp42;
        Tue, 11 May 2021 01:16:19 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 10 May 2021 19:24:32 +0200
Received: from localhost (10.52.123.16) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 10 May
 2021 18:24:31 +0100
Date:   Mon, 10 May 2021 18:22:49 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v3 0/8] CXL Port Enumeration and Plans for v5.14
Message-ID: <20210510182249.0000267f@Huawei.com>
In-Reply-To: <162042787450.1202325.5718541949681409566.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <162042787450.1202325.5718541949681409566.stgit@dwillia2-desk3.amr.corp.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.123.16]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 7 May 2021 15:51:14 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Changes since v2 [1]:
> - Add some rationale for moving definitions out of mem.c into mem.h
>   (Jonathan)
> 
> - Fixup CXL_DEVICE_REGS kernel doc and declare the fixup for the
>   struct cxl_mem kernel-doc in the changelog (Jonathan)
> 
> - Fixup cxl_setup_device_regs() kernel-doc (Jonathan)
> 
> - Cleanup comment in cxl_root_alloc() (Jonathan)
> 
> - [not changed] refactor device creation into alloc_and_add()
>   anti-pattern.
> 
> - Add kernel doc to cxl_address_space_dev_add() to clarify why @host is
>   needed as an arg. (Jonathan)
> 
> - Describe what the port devices are representing in "cxl/port:
>   Introduce cxl_port objects" (Jonathan)
> 
> - Explain the rationale for /sys/bus/cxl (Bjorn)
> 
> [1]: http://lore.kernel.org/r/161728744224.2474040.12854720917440712854.stgit@dwillia2-desk3.amr.corp.intel.com

Hi Dan,

What's the base for this series?  Given it was nearly ready to go
(as far as I'm concerned anyway), I thought I'd give it a spin but
seems it doesn't have some changes from fixes that have gone upstream.

Thanks,

Jonathan

> 
> ---
> 
> Plans for v5.14:
> 
> This series is a starting point for the persistent memory and dynamic
> HDM decoder manipulation support targeting the v5.14 kernel. Among the
> tasks to complete in that timeframe are:
> 
> - Region creation including CXL label support
> - LIBNVDIMM integration for surfacing /dev/pmemX and /dev/daxX.Y devices
>   on CXL resources
> - HDM decoder enumeration and programming for setting up PMEM mappings
>   alongside any "System RAM" mappings established by platform firmware
> - CDAT-DOE support in support of dynamically created NUMA nodes
> - CXL PMEM Shutdown semantics (global persistence flush coordination)
> 
> Contributions to cxl.git targeting the next merge window require a
> non-author Reviewed-by. A patch with a Reviewed-by, no outstanding
> objections, and a 3-5 day quiet period on the list is subject to be
> applied to a non-rebasing cxl.git branch and merged into cxl.git/next.
> Contributions targeting a current -rc (fixes) may go in on an expedited
> schedule with only an Acked-by.
> 
> ---
> 
> CXL Port Topology:
> 
> The enumeration starts with the ACPI0017 driver registering a 'struct
> cxl_root' object to establish the top of a cxl_port topology. It then
> scans the ACPI bus looking for ACPI0016 instances. The cxl_root object
> is a singleton* anchor to hang "address-space" objects and be a parent
> device for the downstream 'struct cxl_port' instances. An address-space
> has a 1:1 relationship with a platform defined memory resource range,
> like _CRS for PCIE Host Bridges. Use module parameters to model a
> root-level HDM decoder that all downstream ports further decode, to be
> replaced with a Code First ECN to do the same.
> 
> Each address space is modeled as a sysfs object that also shows up in
> /proc/iomem as "CXL Address Space". That iomem resource is functionally
> equivalent to the root-level 'PCI Bus' resources for PCIE.mmio while
> 'CXL Address Space' indicates space for CXL.mem to be mapped. "System
> RAM" and "Persistent Memory", when mapped by HDM decoders, will appear
> as child CXL.mem resources.
> 
> Once a 'struct cxl_root' is established the host bridge is modeled as 1
> upstream 'struct cxl_port' and N downstream 'struct cxl_port' instances
> (one per Root Port), just like a PCIE switch. The host-bridge upstream
> port optionally has the HDM decoder registers from the CHBCR if the
> host-bridge has multiple PCIE/CXL root ports. Single-ported host bridges
> will not have HDM decoders in the CHBCR space (see CHBCR note in
> 8.2.5.12 CXL HDM Decoder Capability Structure), but the 'struct
> cxl_port' object is still needed to represent other CXL capabilities and
> access port-specific component registers outside of HDM decoders.
> 
> Each 'struct cxl_port' has a 'target_id' attribute that answers the
> question "what port am I in my upstream port's HDM decoder target
> list?". For the host-bridge struct cxl_port, the first tier of ports
> below cxl_root.port, the id is derived from the ordinal mapping of the
> ACPI0016 id (instance id, _UID, or other handle TBD), for all other
> ports the id is the PCIE Root Port ID from the Link Capabilities
> register [1]. The mapping of ordinal port identifiers relative to their
> parent may change once libcxl and cxl-cli prove out region creation, or
> a better option is found to establish a static device path / persistent
> naming scheme. System software must not assume that 'struct cxl_port'
> device names will be static from one boot to the next.
> 
> See patch7 for a tree(1) topology picture of what QEMU is producing
> today with this enabling.
> 
> * cxl_root is singleton only by convention. A given cxl_root could
>   represent 1 to N address spaces, this patch set chooses to implement 1
>   cxl_root for all address spaces.
> 
> [1]: CXL 2.0 8.2.5.12.8 CXL HDM Decoder 0 Target List Low Register
>      (Offset 24h) ...The Target Port Identifier for a given Downstream Port
>      is reported via Port Number field in Link Capabilities Register. (See
>      PCI Express Base Specification).
> 
> ---
> 
> Dan Williams (8):
>       cxl/mem: Move some definitions to mem.h
>       cxl/mem: Introduce 'struct cxl_regs' for "composable" CXL devices
>       cxl/core: Rename bus.c to core.c
>       cxl/core: Refactor CXL register lookup for bridge reuse
>       cxl/acpi: Introduce ACPI0017 driver and cxl_root
>       cxl/Kconfig: Default drivers to CONFIG_CXL_BUS
>       cxl/port: Introduce cxl_port objects
>       cxl/acpi: Add module parameters to stand in for ACPI tables
> 
> 
>  Documentation/driver-api/cxl/memory-devices.rst |    6 
>  drivers/cxl/Kconfig                             |   16 +
>  drivers/cxl/Makefile                            |    6 
>  drivers/cxl/acpi.c                              |  215 +++++++++
>  drivers/cxl/bus.c                               |   29 -
>  drivers/cxl/core.c                              |  561 +++++++++++++++++++++++
>  drivers/cxl/cxl.h                               |  148 ++++--
>  drivers/cxl/mem.c                               |   97 +---
>  drivers/cxl/mem.h                               |   82 +++
>  9 files changed, 999 insertions(+), 161 deletions(-)
>  create mode 100644 drivers/cxl/acpi.c
>  delete mode 100644 drivers/cxl/bus.c
>  create mode 100644 drivers/cxl/core.c
>  create mode 100644 drivers/cxl/mem.h
> 
> base-commit: a38fd8748464831584a19438cbb3082b5a2dab15

