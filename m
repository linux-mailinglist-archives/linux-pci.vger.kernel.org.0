Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F461486EF0
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jan 2022 01:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343983AbiAGAiK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jan 2022 19:38:10 -0500
Received: from mga18.intel.com ([134.134.136.126]:59426 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343881AbiAGAiJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Jan 2022 19:38:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641515889; x=1673051889;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JTW2+0Slo7dKP7CwxOP9ODtSOY8+sQIm7TNbacS3M6g=;
  b=OFC29+UgKCEX1q+4c/BhtaPHenNMHEZyjO2uiHjmStc4XtVnAnFTIY0o
   Gazhb+NXLg7DUu81mDzjzvD33k39HqPa/dn4MTlhb5S1v88LhgCJTfpPV
   gwd2ZLsFngIzMipRZ6/YvGKTynY+zUOP0xmsiQYsgX0eD6HlgZ1S2Eo4a
   woLwUdDQuo6zsy4vTbH5ZTsZ7v8QvcNh1bpRMuiEY2bldSuCrsI5KcDlO
   a1xKm772LHSvfW1aY/J0eSpYiBzgbNutaSbb0Y0b/R+zTJQ5JdXxzESjc
   HBD0eq5fusKalu+EB6cqsFD1Rk+LzAvjholptUSqTEOix7Gtg1cboq/zW
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="229582012"
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; 
   d="scan'208";a="229582012"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 16:38:09 -0800
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; 
   d="scan'208";a="471123166"
Received: from elenawei-mobl2.amr.corp.intel.com (HELO localhost.localdomain) ([10.252.138.104])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 16:38:09 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-pci@vger.kernel.org
Cc:     patches@lists.linux.dev, Bjorn Helgaas <helgaas@kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 00/13] CXL Region driver
Date:   Thu,  6 Jan 2022 16:37:43 -0800
Message-Id: <20220107003756.806582-1-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch series introduces the CXL region driver as well as associated APIs in
CXL core. The region driver enables the creation of "regions" which is a concept
defined by the CXL 2.0 specification [1]. Region verification and programming
state are owned by the cxl_region driver (implemented in the cxl_region module).
It relies on cxl_mem to determine if devices are CXL routed, and cxl_port to
actually handle the programming of the HDM decoders. Much of the region driver
is an implementation of algorithms described in the CXL Type 3 Memory Device
Software Guide [2].

The region driver will be responsible for configuring regions found on
persistent capacities in the Label Storage Area (LSA), it will also enumerate
regions configured by BIOS, usually volatile capacities, and will allow for
dynamic region creation (which can then be stored in the LSA). It is the primary
consumer of the CXL Port [3] and CXL Mem drivers introduced previously [4]. Dan
as reworked some of this which is required for this branch. A cached copy is
included in the gitlab for this project [5]. Those patches will be posted
shortly.

The patches for the region driver could be squashed. They're broken out to aid
review and because that's the order they were implemented in. My preference is
to keep those as they are.

Some things are still missing and will be worked on while these are reviewed (in
priority order):
1. Connection to libnvdimm labels (No plan)
2. Volatile regions/LSA regions (Have a plan)
3. Switch ports (Have a plan)
4. Decoder programming restrictions (No plan). The one know restriction I've
   missed is to disallow programming HDM decoders that aren't in incremental
   system physical address ranges.
5. Stress testing

Here is an example of output when programming a x2 interleave region:
./cxlctl create-region -i2 -n -a -s $((512<<20)) /sys/bus/cxl/devices/decoder0.0
[   42.971496][  T644] cxl_core:cxl_bus_probe:1384: cxl_region region0.0:0: probe: -19
[   42.972400][  T644] cxl_core:cxl_add_region:478: cxl region0.0:0: Added region0.0:0 to decoder0.0
[   42.979388][  T644] cxl_core:cxl_commit_decoder:394: cxl_port port1: decoder1.0
[   42.979388][  T644] 	Base 0x0000004c00000000
[   42.979388][  T644] 	Size 536870912
[   42.979388][  T644] 	IG 8
[   42.979388][  T644] 	IW 2
[   42.979388][  T644] 	TargetList: 0 1 -1 -1 -1 -1 -1 -1
[   42.982410][  T644] cxl_core:cxl_commit_decoder:394: cxl_port endpoint3: decoder3.0
[   42.982410][  T644] 	Base 0x0000004c00000000
[   42.982410][  T644] 	Size 536870912
[   42.982410][  T644] 	IG 8
[   42.982410][  T644] 	IW 2
[   42.982410][  T644] 	TargetList: -1 -1 -1 -1 -1 -1 -1 -1
[   42.985427][  T644] cxl_core:cxl_commit_decoder:394: cxl_port endpoint2: decoder2.0
[   42.985427][  T644] 	Base 0x0000004c00000000
[   42.985427][  T644] 	Size 536870912
[   42.985427][  T644] 	IG 8
[   42.985427][  T644] 	IW 2
[   42.985427][  T644] 	TargetList: -1 -1 -1 -1 -1 -1 -1 -1
[   42.987937][  T644] cxl_core:cxl_bus_probe:1384: cxl_region region0.0:0: probe: 0

If you're wondering how I tested this, I've baked it into my cxlctl app [6] and
lib [7]. Eventually this will get absorbed by ndctl/cxl-cli/libcxl.

To get the detailed errors, trace-cmd can be utilized. Until a region device
exists, the region module will not be loaded, which means the region tracepoints
will not exist. To get around this, modprobe cxl_region before anything.

trace-cmd record -e cxl ./cxlctl create-region -n -a -s $((256<<20)) /sys/bus/cxl/devices/decoder0.0

Branch can be found at gitlab [8].

---

[1]: https://www.computeexpresslink.org/download-the-specification
[2]: https://cdrdv2.intel.com/v1/dl/getContent/643805?wapkw=CXL%20memory%20device%20sw%20guide
[3]: https://lore.kernel.org/linux-cxl/20211022183709.1199701-9-ben.widawsky@intel.com/
[4]: https://lore.kernel.org/linux-cxl/20211022183709.1199701-17-ben.widawsky@intel.com/
[5]: https://gitlab.com/bwidawsk/linux/-/commit/126793e22427f7975a8f2fca373764be78012e88
[6]: https://gitlab.com/bwidawsk-cxl/cxlctl
[7]: https://gitlab.com/bwidawsk-cxl/cxl_rs
[8]: https://gitlab.com/bwidawsk/linux/-/tree/cxl_region

---

Ben Widawsky (13):
  cxl/core: Rename find_cxl_port
  cxl/core: Track port depth
  cxl/region: Add region creation ABI
  cxl/region: Introduce concept of region configuration
  cxl/mem: Cache port created by the mem dev
  cxl/region: Introduce a cxl_region driver
  cxl/acpi: Handle address space allocation
  cxl/region: Address space allocation
  cxl/region: Implement XHB verification
  cxl/region: HB port config verification
  cxl/region: Add infrastructure for decoder programming
  cxl/region: Record host bridge target list
  cxl: Program decoders for regions

 .clang-format                                 |   3 +
 Documentation/ABI/testing/sysfs-bus-cxl       |  63 ++
 .../driver-api/cxl/memory-devices.rst         |  14 +
 drivers/cxl/Makefile                          |   2 +
 drivers/cxl/acpi.c                            |  30 +
 drivers/cxl/core/Makefile                     |   1 +
 drivers/cxl/core/core.h                       |   4 +
 drivers/cxl/core/hdm.c                        | 198 +++++
 drivers/cxl/core/port.c                       | 132 +++-
 drivers/cxl/core/region.c                     | 525 +++++++++++++
 drivers/cxl/cxl.h                             |  32 +
 drivers/cxl/cxlmem.h                          |   9 +
 drivers/cxl/mem.c                             |  16 +-
 drivers/cxl/port.c                            |  42 +-
 drivers/cxl/region.c                          | 695 ++++++++++++++++++
 drivers/cxl/region.h                          |  47 ++
 drivers/cxl/trace.h                           |  54 ++
 tools/testing/cxl/Kbuild                      |   1 +
 18 files changed, 1849 insertions(+), 19 deletions(-)
 create mode 100644 drivers/cxl/core/region.c
 create mode 100644 drivers/cxl/region.c
 create mode 100644 drivers/cxl/region.h
 create mode 100644 drivers/cxl/trace.h


base-commit: 03716ce2db3c17ba38f26a88d75049c0472a629e
prerequisite-patch-id: af6a0315e22bfc1099d4f58610b8b897e6e5a060
-- 
2.34.1

