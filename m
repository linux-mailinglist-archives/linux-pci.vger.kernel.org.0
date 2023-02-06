Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A58468C7E8
	for <lists+linux-pci@lfdr.de>; Mon,  6 Feb 2023 21:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjBFUt1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Feb 2023 15:49:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjBFUtZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Feb 2023 15:49:25 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D6F1DBB8;
        Mon,  6 Feb 2023 12:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675716564; x=1707252564;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oAQH9+a1F3+Z9lfOsRPCje7dNsi+nuaOseGb4Sm3t+E=;
  b=S3uIduuDU8YCPARYbU8IhkoHWJAw5Qpg3+pphra8SpDiP9sAmT60aPqI
   kQYJ2LPNEQs2eMr0BhM+fS5Stk7CY/BTMG9RI+7cWnAbhp4f1lyiqdCum
   z9iRGFHibBRmb+wc4UdbDR6cI9i3TYiT88Eq5j6E4ya8XHeXUJqTpjz8W
   jr4bx1PoCOHGGe6FepeqUpJnNxznjOQpLXNJp5zU4Rdvm3/GBa07hWgL0
   pQ833s9xHspzBYgdB0dMUO2p2Ia3THD1CIrTEpx3BmmiLLfioFH5dgbze
   QceB1izgg+XCmLfQ1YWcvZXlmsobiHKLdqvNuY5B8xLP8pn8JV6mQPrVx
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="393911766"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="393911766"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 12:49:24 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="616559303"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="616559303"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO djiang5-mobl3.local) ([10.212.111.195])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 12:49:23 -0800
Subject: [PATCH 00/18] cxl: Add support for QTG ID retrieval for CXL subsystem
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rafael@kernel.org, bhelgaas@google.com, robert.moore@intel.com
Date:   Mon, 06 Feb 2023 13:49:21 -0700
Message-ID: <167571650007.587790.10040913293130712882.stgit@djiang5-mobl3.local>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn, please review the relevant patches to the PCI subsystem: 10/18, 11/18. Thank you!
pcie_get_speed() and pcie_get_width() are created in order to allow CXL driver to calculate
the bandwith and latency for the PCI links.

Hi Rafael, please review the relevant patches to the ACPI: 2/18, 5/18. Thank you!
acpi_ut_verify_cdat_checksum() is exported to allow usage by a driver.

This series adds the retrieval of QoS Throttling Group (QTG) IDs for the CXL Fixed
Memory Window Structure (CFMWS) and the CXL memory device. It provides the QTG IDs
to user space to provide some guidance with putting the proper DPA range under the
appropriate CFMWS window.

The CFMWS structure contains a QTG ID that is associated with the memory window that the
structure exports. On Linux, the CFMWS is represented as a CXL root decoder. The QTG
ID will be attached to the CXL root decoder and exported as a sysfs attribute (qtg_id).

The QTG ID for a device is retrieved via sending a _DSM method to the ACPI0017 device.
The _DSM expects an input package of 4 DWORDS that contains the read latency, write
latency, read bandwidth, and write banwidth. These are the caluclated numbers for the
path between the CXL device and the CXL host bridge (HB). The QTG ID is also exported
as a sysfs attribute under the mem device memory type:
/sys/bus/cxl/devices/memX/ram/qtg_id or /sys/bus/cxl/devices/memX/pmem/qtg_id

The latency numbers are the aggregated latencies for the path between the CXL device and
the CXL HB. If a CXL device is directly attached to the CXL HB, the latency
would be the device latencies from the device Coherent Device Attribute Table (CDAT) plus
the caluclated PCIe link latency between the device and the HB. The bandwidth in this
configuration would be the minimum between the CDAT bandwidth number and link bandwidth
between the device and the HB.

If a configuration has a switch in between, then the latency would be the aggregated
latencies from the device CDAT, the link latency between device and switch, the
latencies from the switch CDAT, and the link latency between switch and the HB. Given
that the switch CDAT is not easily retrieved on Linux currently, a guesstimated
constant number will be used for calculation. The bandwidth calculation would be the
min of device CDAT bandwidth, link bandwith between device and switch, switch CDAT
bandwidth, and link bandwidth between switch and HB.  And without the switch CDAT,
the switch CDAT bandwidth will be skipped.

There can be 0 or more switches between the CXL device and the CXL HB. There are detailed
examples on calculating bandwidth and latency in the CXL Memory Device Software Guide [4].

The CDAT provides Device Scoped Memory Affinity Structures (DSMAS) that contains the
Device Physical Address (DPA) range and the related Device Scoped Latency and Bandwidth
Informat Stuctures (DSLBIS). Each DSLBIS provides a latency or bandwidth entry that is
tied to a DSMAS entry via a per DSMAS unique DSMAD handle.

[1]: https://www.computeexpresslink.org/download-the-specification
[2]: https://uefi.org/sites/default/files/resources/Coherent%20Device%20Attribute%20Table_1.01.pdf
[3]: https://uefi.org/sites/default/files/resources/ACPI_Spec_6_5_Aug29.pdf
[4]: https://cdrdv2-public.intel.com/643805/643805_CXL%20Memory%20Device%20SW%20Guide_Rev1p0.pdf

---

Dave Jiang (18):
      cxl: Export QTG ids from CFMWS to sysfs
      ACPICA: Export acpi_ut_verify_cdat_checksum()
      cxl: Add checksum verification to CDAT from CXL
      cxl: Add common helpers for cdat parsing
      ACPICA: Fix 'struct acpi_cdat_dsmas' spelling mistake
      cxl: Add callback to parse the DSMAS subtables from CDAT
      cxl: Add callback to parse the DSLBIS subtable from CDAT
      cxl: Add support for _DSM Function for retrieving QTG ID
      cxl: Add helper function to retrieve ACPI handle of CXL root device
      PCI: Export pcie_get_speed() using the code from sysfs PCI link speed show function
      PCI: Export pcie_get_width() using the code from sysfs PCI link width show function
      cxl: Add helpers to calculate pci latency for the CXL device
      cxl: Add latency and bandwidth calculations for the CXL path
      cxl: Wait Memory_Info_Valid before access memory related info
      cxl: Move identify and partition query from pci probe to port probe
      cxl: Move reading of CDAT data from device to after media is ready
      cxl: Attach QTG IDs to the DPA ranges for the device
      cxl: Export sysfs attributes for device QTG IDs


 Documentation/ABI/testing/sysfs-bus-cxl |  22 ++++
 drivers/acpi/acpica/utcksum.c           |   4 +-
 drivers/cxl/acpi.c                      |   3 +
 drivers/cxl/core/Makefile               |   2 +
 drivers/cxl/core/acpi.c                 | 129 +++++++++++++++++++
 drivers/cxl/core/cdat.c                 | 157 ++++++++++++++++++++++++
 drivers/cxl/core/cdat.h                 |  15 +++
 drivers/cxl/core/mbox.c                 |   2 +
 drivers/cxl/core/memdev.c               |  26 ++++
 drivers/cxl/core/pci.c                  | 103 +++++++++++++++-
 drivers/cxl/core/port.c                 |  76 ++++++++++++
 drivers/cxl/cxl.h                       |  50 ++++++++
 drivers/cxl/cxlmem.h                    |   2 +
 drivers/cxl/cxlpci.h                    |  14 +++
 drivers/cxl/pci.c                       |   8 --
 drivers/cxl/port.c                      | 105 +++++++++++++++-
 drivers/pci/pci-sysfs.c                 |  21 +---
 drivers/pci/pci.c                       |  40 ++++++
 include/acpi/actbl1.h                   |   7 +-
 include/linux/acpi.h                    |   7 ++
 include/linux/pci.h                     |   2 +
 21 files changed, 760 insertions(+), 35 deletions(-)
 create mode 100644 drivers/cxl/core/acpi.c
 create mode 100644 drivers/cxl/core/cdat.c
 create mode 100644 drivers/cxl/core/cdat.h

--

