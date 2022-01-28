Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 906A149EFAF
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jan 2022 01:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344723AbiA1A3D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jan 2022 19:29:03 -0500
Received: from mga18.intel.com ([134.134.136.126]:64771 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344600AbiA1A2n (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Jan 2022 19:28:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643329723; x=1674865723;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2YVm7dGPgwEGBc9zcHb6l8y0LZ9qiKIiu+WGd7yYGuQ=;
  b=NPtUGy0MnxYou7gNaOLE5V5b0s0JJD3XDixwOLEMacZBTbDt+CRIuPoP
   elJcJYZZP203LFTT/+06Vpl9N7fr4jeBCO5O/JMv36GK0wR/TaFoSI1vA
   3nICy4n78JoBpzARB86oYdQwHjH4GgNJ92YUrBehi98Esu0NlQLoGVakM
   v8HzfXjChwoWXbgF/U8VolQ/YkhYbdQKEwJzub2EIWJQ6F41xykCRLf1w
   rTf6lEh6/UKW2LmdDDY1xpq8+66BxQHL9P8/WCrMGuFQlZayNhmvNZGNW
   ynPCDnjVw8lsVhgOer08LDmZrvxWY4pw1gi7GPGzgGKQkETSIypNFA7fp
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="230580000"
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="230580000"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 16:27:22 -0800
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="674909594"
Received: from vrao2-mobl1.gar.corp.intel.com (HELO localhost.localdomain) ([10.252.129.6])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 16:27:21 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     patches@lists.linux.dev, Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>, nvdimm@lists.linux.dev,
        linux-pci@vger.kernel.org
Subject: [PATCH v3 00/14] CXL Region driver
Date:   Thu, 27 Jan 2022 16:26:53 -0800
Message-Id: <20220128002707.391076-1-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.35.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Major changes since v2:
- Clarify encoded region/granularity from raw values
- Rename "region" to cxlr everywhere
- Kconfig for the region driver
- Several small bug fixes

https://gitlab.com/bwidawsk/linux/-/tree/cxl_region-v3

Original commit message follows with minor updates for correctness.

---

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
consumer of the CXL Port [3] and CXL Mem drivers introduced previously [4].

The patches for the region driver could be squashed. They're broken out to aid
review and because that's the order they were implemented in. My preference is
to keep those as they are.

Some things are still missing and will be worked on while these are reviewed (in
priority order):
1. Volatile regions creation and enumeration (Have a plan)
2. multi-level switches
3. Decoder programming restrictions (No plan). The one know restriction I've
   missed is to disallow programming HDM decoders that aren't in incremental
   system physical address ranges.
4. CXL region teardown -> nd_region teardown
5. Stress testing

[1]: https://www.computeexpresslink.org/download-the-specification
[2]: https://cdrdv2.intel.com/v1/dl/getContent/643805?wapkw=CXL%20memory%20device%20sw%20guide
[3]: https://lore.kernel.org/linux-cxl/164298424635.3018233.9356036382052246767.stgit@dwillia2-desk3.amr.corp.intel.com/T/#u
[4]: https://lore.kernel.org/linux-cxl/164298429450.3018233.13269591903486669825.stgit@dwillia2-desk3.amr.corp.intel.com/T/#u

---

Ben Widawsky (14):
  cxl/region: Add region creation ABI
  cxl/region: Introduce concept of region configuration
  cxl/mem: Cache port created by the mem dev
  cxl/region: Introduce a cxl_region driver
  cxl/acpi: Handle address space allocation
  cxl/region: Address space allocation
  cxl/region: Implement XHB verification
  cxl/region: HB port config verification
  cxl/region: Add infrastructure for decoder programming
  cxl/region: Collect host bridge decoders
  cxl/region: Add support for single switch level
  cxl: Program decoders for regions
  cxl/pmem: Convert nvdimm bridge API to use dev
  cxl/region: Create an nd_region

 .clang-format                                 |   3 +
 Documentation/ABI/testing/sysfs-bus-cxl       |  64 ++
 .../driver-api/cxl/memory-devices.rst         |  14 +
 drivers/cxl/Kconfig                           |   5 +
 drivers/cxl/Makefile                          |   2 +
 drivers/cxl/acpi.c                            |  30 +
 drivers/cxl/core/Makefile                     |   1 +
 drivers/cxl/core/core.h                       |   4 +
 drivers/cxl/core/hdm.c                        | 209 +++++
 drivers/cxl/core/pmem.c                       |  28 +-
 drivers/cxl/core/port.c                       | 105 ++-
 drivers/cxl/core/region.c                     | 529 +++++++++++
 drivers/cxl/cxl.h                             |  76 +-
 drivers/cxl/cxlmem.h                          |   9 +
 drivers/cxl/mem.c                             |  35 +-
 drivers/cxl/pmem.c                            |   2 +-
 drivers/cxl/port.c                            |  62 +-
 drivers/cxl/region.c                          | 866 ++++++++++++++++++
 drivers/cxl/region.h                          |  47 +
 tools/testing/cxl/Kbuild                      |   1 +
 20 files changed, 2077 insertions(+), 15 deletions(-)
 create mode 100644 drivers/cxl/core/region.c
 create mode 100644 drivers/cxl/region.c
 create mode 100644 drivers/cxl/region.h


base-commit: e783362eb54cd99b2cac8b3a9aeac942e6f6ac07
prerequisite-patch-id: 90de8aefc2999f55c7534fefa971d95653c4220c
prerequisite-patch-id: 32a5b56d83bf3372b6ed4b40f621eafb33a7201b
prerequisite-patch-id: f827831bb7a23e0789d16d7b8979b165253c6301
prerequisite-patch-id: 08b8febd42d3ab508b618937473807e553589e36
prerequisite-patch-id: 18049f47c948582c1dc26348d9765c934eb82a75
prerequisite-patch-id: 8f66d52af297449fa007a0ba963c5239b153ef5b
prerequisite-patch-id: 3e2e86cbc2631b99c1b5c0179f35799d3df31f91
prerequisite-patch-id: b88becd4997320a34e918cdef1b620e6dea14917
prerequisite-patch-id: c61df81018f2a93b87d10965b418afa659d9d6d6
prerequisite-patch-id: 73b31df62e00bb7af7082e2ca4d40023a7962abd
prerequisite-patch-id: 207abfcd5028c41df8875ee795a8ab697cd7c688
prerequisite-patch-id: 26978f021b3b0f4a6734ef8c0100c724dc88742e
prerequisite-patch-id: bf229ca5aab5c5dffe69ba5b9380749a66cf20ba
prerequisite-patch-id: 20ebefe1acfdecf184d048cb605368e1863646c1
prerequisite-patch-id: f34c26e902dd868dc1c3ef8ba8246cc063cf991a
prerequisite-patch-id: bcc59db1c6528244b649ced35eab015699c410fa
prerequisite-patch-id: 2f9f6cfbd6b73a563498c6b6d721bbc169a0a414
prerequisite-patch-id: dc8fb216dc8ff4f813bfc689273d9c5f5124e789
prerequisite-patch-id: da83e8074d339426c886c481070366afb189b561
prerequisite-patch-id: 501fe71f19065ba9f31cabd86756fedda853c414
prerequisite-patch-id: ceeef31c2ca85a426d507563b886347d28acc322
prerequisite-patch-id: f876c09942ae5a3223a36329c23262a05b2669f4
prerequisite-patch-id: 44fa61c5569614c8d9df854cde6fedfc2bc78c12
prerequisite-patch-id: 04ad90e1bbb5646125c4633fbe5341f572bc9548
prerequisite-patch-id: f4dbf89d99917f50c30e1ee56bfeff8d8dd6b0f3
prerequisite-patch-id: 2d7c3aacefcb8133897e3256ed6f76952555c2f1
prerequisite-patch-id: 7454df4bdb07381f02717845eb3b17011a89ab18
prerequisite-patch-id: 52ec0dfd506bb6a3f8d11a914cfc7320193a6445
prerequisite-patch-id: 9de14fa54cfba412e09d7b41f392c0f6d55d6a01
prerequisite-patch-id: ae39a482c2067a1f04baee5ce9131901e6d359ec
prerequisite-patch-id: 446240d2ed24d9e55ac9edfc65b511495659464a
prerequisite-patch-id: ba6bf6450e47df5e95e2fb1780d9edd126bc0eb2
prerequisite-patch-id: 3c0865b6dd062e677ef8e160e14f823622eafb9f
prerequisite-patch-id: 4503f5507cbdeb0770b420b4c26d87be2b173813
prerequisite-patch-id: c5a8cbda77c95b052040770eca0dc5b99876dc66
prerequisite-patch-id: e064003a6c48131fac401d9a48d4d6204fea6123
prerequisite-patch-id: b4c7213971c981dd5ca0fda992643a7c61548fef
prerequisite-patch-id: 2bd09e27f8a8df144a8ad386822390c87ef46ec5
prerequisite-patch-id: 60b3fafbd3bfa225405a6762bdb6b89c044b0b86
prerequisite-patch-id: 620068ae417bf0784809107e0dae3ec9793632df
prerequisite-patch-id: c3415fe92e29cd4afc508f8caf31cb914be09261
prerequisite-patch-id: 4c01f305244036afa9aaa918c8215659327dd0f3
prerequisite-patch-id: 034aeb7e124c5a34785c963bf014aa5380f00a2e
prerequisite-patch-id: 26f18c2ca586e6d734cd319e0e7f24398b17217f
prerequisite-patch-id: ef97136efb8c077232fe39a0465389565803a7b7
prerequisite-patch-id: 6a63e03117287b748cfec00e2c16a41ed38f4f9a
-- 
2.35.0

