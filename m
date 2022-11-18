Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10BB62FB4B
	for <lists+linux-pci@lfdr.de>; Fri, 18 Nov 2022 18:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235282AbiKRRMs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 12:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242535AbiKRRMb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 12:12:31 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89F894A4C;
        Fri, 18 Nov 2022 09:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668791550; x=1700327550;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AOUPUafwcDNPcstCUTPlMTYyUtwrTx1nKmLprMS+Uno=;
  b=Io80ruMMt4AwiL6Y8ssILVHfKTZKfYGi8SpNXrgK4C39tQNv0+Zr00WO
   Y6lsVkRxQFQgHH3ceC7bqoz7QK1ikGwWrWZpUmc7KTeEkiEhg44SW9dxf
   T4XWGmlN7XiNFxRVQxyCChZXT6w3Y5s98yCnsaL6E9M37KBfLZeeiXWkI
   uWnMrD/ke/FU4j2zvtUnljrcj192ErQBBCCI4/T9x1rC4hGFApdg6VD+T
   h8GDMKdb7ec+0qi+A1RBTCrG8o6iM1cHaVbkkfAznH8weTUX9n2aPivd7
   KrgmXs7mSgMmv726dInVfTj1mED+bsoANJX8POXqUOgH4nM4F7FmesVxH
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="310814658"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="310814658"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 09:08:03 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="703807300"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="703807300"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 09:08:03 -0800
Subject: [PATCH v3 00/11] cxl/pci: Add fundamental error handling
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com, rostedt@goodmis.org,
        terry.bowman@amd.com, bhelgaas@google.com
Date:   Fri, 18 Nov 2022 10:08:02 -0700
Message-ID: <166879123216.674819.3578187187954311721.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,
I added a new optional callback for AER error handler to allow the PCI
device driver to do additional logging. Please Ack the patch if it looks
reasonable to you. Thank you!

Hi Steve,
Please review the trace event implementation and Ack if it looks ok.
Thank you!

v3:
- Copy header log in 32bit chunks (Jonathan)
- Export header log whole as raw data (Jonathan)
- Added callback in PCI AER err handler for correctable errors (Jonathan)
- Tested on qemu thanks to Jonathan's CXL AER injection enabling!

v2:
- Convert error reporting via printk to trace events
- Drop ".rmap =" initialization (Jonathan)
- return PCI_ERS_RESULT_NEED_RESET for UE in pci_channel_io_normal (Shiju)

Add a 'struct pci_error_handlers' instance for the cxl_pci driver.
Section 8.2.4.16 "CXL RAS Capability Structure" of the CXL rev3.0
specification defines the error sources considered in this
implementation. The RAS Capability Structure defines protocol, link and
internal errors which are distinct from memory poison errors that are
conveyed via direct consumption and/or media scanning.

The errors reported by the RAS registers are categorized into
correctable and uncorrectable errors, where the uncorrectable errors are
optionally steered to either fatal or non-fatal AER events. Table 12-2 
"Device Specific Error Reporting and Nomenclature Guidelines" in the CXL
rev3.0 specification outlines that the remediation for uncorrectable errors
is a reset to recover. This matches how the Linux PCIe AER core treats
uncorrectable errors as occasions to reset the device to recover
operation.

While the specification notes "CXL Reset" or "Secondary Bus Reset" as
theoretical recovery options, they are not feasible in practice since
in-flight CXL.mem operations may not terminate and cause knock-on system
fatal events. Reset is only reliable for recovering CXL.io, it is not
reliable for recovering CXL.mem. Assuming the system survives, a reset
causes CXL.mem operation to restart from scratch.

The "ECN: Error Isolation on CXL.mem and CXL.cache" [1] document
recognizes the CXL Reset vs CXL.mem operational conflict and helps to at
least provide a mechanism for the Root Port to terminate in flight
CXL.mem operations with completions. That still poses problems in
practice if the kernel is running out of "System RAM" backed by the CXL
device and poison is used to convey the data lost to the protocol error.

Regardless of whether the reset and restart of CXL.mem operations is
feasible / successful, the logging is still useful. So, the
implementation reads, reports, and clears the status in the RAS
Capability Structure registers, and it notifies the 'struct cxl_memdev'
associated with the given PCIe endpoint to reattach to its driver over
the reset so that the HDM decoder configuration can be reconstructed.

The first half of the series reworks component register mapping so that
the cxl_pci driver can own the RAS Capability while the cxl_port driver
continues to own the HDM Decoder Capability. The last half implements
the RAS Capability Structure mapping and reporting via 'struct
pci_error_handlers'.

The reporting of error information is done through event tracing. A new
cxl_ras event is introduced to report the Uncorrectable and Correctable
errors raised by CXL. The expectation is a monitoring user daemon such as
"cxl monitor" will harvest those events and record them in a log in a
format (JSON) that's consumable by management applications.

For correctable errors, current Linux implementation does not provide any
means to reach the pci device driver. Add an optional callback with the
PCI aer error handler to allow the pci device driver to log additional
information from the device.

[1]: https://www.computeexpresslink.org/spec-landing

---

Dan Williams (8):
      cxl/pci: Cleanup repeated code in cxl_probe_regs() helpers
      cxl/pci: Cleanup cxl_map_device_regs()
      cxl/pci: Kill cxl_map_regs()
      cxl/core/regs: Make cxl_map_{component, device}_regs() device generic
      cxl/port: Limit the port driver to just the HDM Decoder Capability
      cxl/pci: Prepare for mapping RAS Capability Structure
      cxl/pci: Find and map the RAS Capability Structure
      cxl/pci: Add (hopeful) error handling support

Dave Jiang (3):
      cxl/pci: add tracepoint events for CXL RAS
      PCI/AER: Add optional logging callback for correctable error
      cxl/pci: Add callback to log AER correctable error


 drivers/cxl/core/hdm.c     |  33 +++---
 drivers/cxl/core/memdev.c  |   1 +
 drivers/cxl/core/pci.c     |   3 +-
 drivers/cxl/core/port.c    |   2 +-
 drivers/cxl/core/regs.c    | 172 +++++++++++++++++-------------
 drivers/cxl/cxl.h          |  38 +++++--
 drivers/cxl/cxlmem.h       |   2 +
 drivers/cxl/cxlpci.h       |   9 --
 drivers/cxl/pci.c          | 212 ++++++++++++++++++++++++++++++-------
 drivers/pci/pcie/aer.c     |   8 +-
 include/linux/pci.h        |   3 +
 include/trace/events/cxl.h | 110 +++++++++++++++++++
 12 files changed, 443 insertions(+), 150 deletions(-)
 create mode 100644 include/trace/events/cxl.h

--

