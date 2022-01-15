Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 687FA48F8ED
	for <lists+linux-pci@lfdr.de>; Sat, 15 Jan 2022 20:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbiAOTBC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 15 Jan 2022 14:01:02 -0500
Received: from mga04.intel.com ([192.55.52.120]:65487 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230174AbiAOTBC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 15 Jan 2022 14:01:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642273261; x=1673809261;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5sjtMwaMW3TxVFLwwMKGGQ41h1yf4gG/AEgyto+2auM=;
  b=AxGG8Io57r7AdtevqlpPV8X4zvbPKWegrA8xkbgKEmyEoC+Z/4lV+LOY
   VYw8oPnfRpxT1sG9J4vgFcRreihLkawI3qgTQEcNPjOINtq9lxMYX5EB9
   80zsHQMiNwa+J7bi8D1O5RJbA2XkZ0kAcoQzM6blrLpsWOWmxFE1BIbc7
   MBOo5b4WkPcnmjAlfqmgJhm3enNdL6TFdBraU/FAAnKBi9+YsvtWDBD6O
   fISfybfWXe4KpOP4f2S8wbj/z621XgEQLWB9DpfwmK42XkXYhrOI4Yai0
   nCltyUHPytzbpIaQShgSjDEHXvJUOOFvqyUQHDR05E1OdB9Ibks/a1H/n
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10228"; a="243258484"
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="243258484"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2022 11:01:01 -0800
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="671179329"
Received: from jayitada-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.140.240])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2022 11:01:01 -0800
Date:   Sat, 15 Jan 2022 11:00:58 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-pci@vger.kernel.org
Cc:     patches@lists.linux.dev, Bjorn Helgaas <helgaas@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH v2 00/15] CXL Region driver
Message-ID: <20220115190058.fbenk5doo4yyzyw6@intel.com>
References: <20220112234749.1965960-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220112234749.1965960-1-ben.widawsky@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Dang. Responded to the wrong thread...

v3 coming. Ignore this please.

Thanks.
Ben

On 22-01-12 15:47:34, Ben Widawsky wrote:
> Major changes since v1:
> - bug fixes in certain calculations for region programming
> - bug fix in for_each_cxl_decoder_target
> - clarify ENIW and IG from ways and granularity
> - wait_for_commit bug fix
> - use devm management for region removal
> - remove trace points
> - add basic libnvdimm connection
> 
> Original commit message follows with minor updates for correctness.
> 
> ---
> 
> This patch series introduces the CXL region driver as well as associated APIs in
> CXL core. The region driver enables the creation of "regions" which is a concept
> defined by the CXL 2.0 specification [1]. Region verification and programming
> state are owned by the cxl_region driver (implemented in the cxl_region module).
> It relies on cxl_mem to determine if devices are CXL routed, and cxl_port to
> actually handle the programming of the HDM decoders. Much of the region driver
> is an implementation of algorithms described in the CXL Type 3 Memory Device
> Software Guide [2].
> 
> The region driver will be responsible for configuring regions found on
> persistent capacities in the Label Storage Area (LSA), it will also enumerate
> regions configured by BIOS, usually volatile capacities, and will allow for
> dynamic region creation (which can then be stored in the LSA). It is the primary
> consumer of the CXL Port [3] and CXL Mem drivers introduced previously [4]. Dan
> has reworked those drivers which is a requirement for this branch. A cached copy
> is included in the gitlab for this project [5]. Those patches will be posted
> shortly.
> 
> The patches for the region driver could be squashed. They're broken out to aid
> review and because that's the order they were implemented in. My preference is
> to keep those as they are.
> 
> Some things are still missing and will be worked on while these are reviewed (in
> priority order):
> 1. Volatile regions/LSA regions (Have a plan)
> 2. Switch ports (Have a plan)
> 3. Decoder programming restrictions (No plan). The one know restriction I've
>    missed is to disallow programming HDM decoders that aren't in incremental
>    system physical address ranges.
> 4. CXL region teardown -> nd_region teardown
> 5. Stress testing
> 
> Here is an example of output when programming a x2 interleave region
> 
> # ./cxlctl create-region -n -a -s $((256<<20)) /sys/bus/cxl/devices/decoder0.0
> [   57.564475][  T654] cxl_core:cxl_add_region:478: cxl region0.0:0: Added region0.0:0 to decoder0.0
> [   57.608949][  T655] cxl_region:allocate_address_space:170: cxl_region region0.0:0: resource [mem 0x4c00000000-0x4c1fffffff]
> [   57.610056][  T655] cxl_core:cxl_commit_decoder:394: cxl_port port1: decoder1.0
> [   57.610056][  T655]  Base 0x0000004c00000000
> [   57.610056][  T655]  Size 512M
> [   57.610056][  T655]  IG 0 (256b)
> [   57.610056][  T655]  ENIW 1 (x2)
> [   57.610056][  T655]  TargetList: 0 1 -1 -1 -1 -1 -1 -1
> [   57.613584][  T655] cxl_core:cxl_commit_decoder:394: cxl_port endpoint2: decoder2.0
> [   57.613584][  T655]  Base 0x0000004c00000000
> [   57.613584][  T655]  Size 512M
> [   57.613584][  T655]  IG 0 (256b)
> [   57.613584][  T655]  ENIW 1 (x2)
> [   57.613584][  T655]  TargetList: -1 -1 -1 -1 -1 -1 -1 -1
> [   57.617051][  T655] cxl_core:cxl_commit_decoder:394: cxl_port endpoint3: decoder3.0
> [   57.617051][  T655]  Base 0x0000004c00000000
> [   57.617051][  T655]  Size 512M
> [   57.617051][  T655]  IG 0 (256b)
> [   57.617051][  T655]  ENIW 1 (x2)
> [   57.617051][  T655]  TargetList: -1 -1 -1 -1 -1 -1 -1 -1
> [   57.619433][  T655] cxl_region region0.0:0: Bound
> [   57.621435][  T655] cxl_core:cxl_bus_probe:1384: cxl_region region0.0:0: probe: 0
> 
> If you're wondering how I tested this, I've baked it into my cxlctl app [6] and
> lib [7]. Eventually this will get absorbed by ndctl/cxl-cli/libcxl.
> 
> 
> Branch can be found at gitlab [8].
> 
> ---
> 
> [1]: https://www.computeexpresslink.org/download-the-specification
> [2]: https://cdrdv2.intel.com/v1/dl/getContent/643805?wapkw=CXL%20memory%20device%20sw%20guide
> [3]: https://lore.kernel.org/linux-cxl/20211022183709.1199701-9-ben.widawsky@intel.com/
> [4]: https://lore.kernel.org/linux-cxl/20211022183709.1199701-17-ben.widawsky@intel.com/
> [5]: https://gitlab.com/bwidawsk/linux/-/commit/126793e22427f7975a8f2fca373764be78012e88
> [6]: https://gitlab.com/bwidawsk-cxl/cxlctl
> [7]: https://gitlab.com/bwidawsk-cxl/cxl_rs
> [8]: https://gitlab.com/bwidawsk/linux/-/tree/cxl_region-v2
> 
> Ben Widawsky (15):
>   cxl/core: Rename find_cxl_port
>   cxl/core: Track port depth
>   cxl/region: Add region creation ABI
>   cxl/region: Introduce concept of region configuration
>   cxl/mem: Cache port created by the mem dev
>   cxl/region: Introduce a cxl_region driver
>   cxl/acpi: Handle address space allocation
>   cxl/region: Address space allocation
>   cxl/region: Implement XHB verification
>   cxl/region: HB port config verification
>   cxl/region: Add infrastructure for decoder programming
>   cxl/region: Collect host bridge decoders
>   cxl: Program decoders for regions
>   cxl/pmem: Convert nvdimm bridge API to use memdev
>   cxl/region: Create an nd_region
> 
>  .clang-format                                 |   3 +
>  Documentation/ABI/testing/sysfs-bus-cxl       |  63 ++
>  .../driver-api/cxl/memory-devices.rst         |  14 +
>  drivers/cxl/Makefile                          |   2 +
>  drivers/cxl/acpi.c                            |  30 +
>  drivers/cxl/core/Makefile                     |   1 +
>  drivers/cxl/core/core.h                       |   4 +
>  drivers/cxl/core/hdm.c                        | 199 +++++
>  drivers/cxl/core/pmem.c                       |  19 +-
>  drivers/cxl/core/port.c                       | 132 ++-
>  drivers/cxl/core/region.c                     | 525 ++++++++++++
>  drivers/cxl/cxl.h                             |  48 +-
>  drivers/cxl/cxlmem.h                          |   9 +
>  drivers/cxl/mem.c                             |  16 +-
>  drivers/cxl/pmem.c                            |   2 +-
>  drivers/cxl/port.c                            |  42 +-
>  drivers/cxl/region.c                          | 769 ++++++++++++++++++
>  drivers/cxl/region.h                          |  47 ++
>  tools/testing/cxl/Kbuild                      |   1 +
>  19 files changed, 1903 insertions(+), 23 deletions(-)
>  create mode 100644 drivers/cxl/core/region.c
>  create mode 100644 drivers/cxl/region.c
>  create mode 100644 drivers/cxl/region.h
> 
> -- 
> 2.34.1
> 
