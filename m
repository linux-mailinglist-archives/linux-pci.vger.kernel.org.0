Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B2063C6B5
	for <lists+linux-pci@lfdr.de>; Tue, 29 Nov 2022 18:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235857AbiK2RsK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Nov 2022 12:48:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235866AbiK2RsJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Nov 2022 12:48:09 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950915F85B;
        Tue, 29 Nov 2022 09:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669744088; x=1701280088;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jj4APkjn2NrCYJRo5Yx2a1n2LpW1mmdojxIg7widFIw=;
  b=YeWGJ2olX5Sv05uPyNJ02Z8yZ9MEu/s+PPthR69y/pnh2GrSK9wWYA3V
   nGdZERWRyjW0IhC5VKN0yGfDZMrpP4RqQ9h2uD/+FI7ebaqrPXbA41wxK
   z/OM26zMdrZqWS6NLtnyOOaiTvY3cF6mAOzsBlIgamkRDVdaq64ed3IlA
   OMwiAkgos4Daf9TSpDKUwKtcuIHlpi8e1OBJ1AT0iJv1oBaJSONh41qtN
   PMn/DiB11M3fOMVRu3akv4YtIsUz1cqobjMm5OwyZLEEW3C2wqPj01KqS
   ccDOKxDhSDYcHXtG8qPdiuzSAwbrI2JXj+LuRiFNjKcwKt0kgegy6icre
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="342104729"
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; 
   d="scan'208";a="342104729"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 09:48:07 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="972772663"
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; 
   d="scan'208";a="972772663"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 09:48:07 -0800
Subject: [PATCH v4 00/11] cxl/pci: Add fundamental error handling
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com, rostedt@goodmis.org,
        terry.bowman@amd.com, bhelgaas@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, shiju.jose@huawei.com
Date:   Tue, 29 Nov 2022 10:48:06 -0700
Message-ID: <166974401763.1608150.5424589924034481387.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,
I added a new optional callback for AER error handler to allow the PCI
device driver to do additional logging. Please Ack the patch if it looks
reasonable to you and Dan can take the series through cxl tree. Thank you!

Hi Steve,
Please review the trace event implementation and Ack if it looks ok.
Thank you!

v4:
- Change header log for eventtrace to static array (Steve)
- Fix CE status bits (Shiju)
- Fix ECC capitalization (Shiju)
- Add PCI error handler callback documentation (Sathyanarayanan)
- Clarify callback as additional information capture only (Jonathan)
- Clarify need of callback to clear CE by CXL device (Jonathan)
- Fix 0-day complaint of __force __le32.

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


 Documentation/PCI/pci-error-recovery.rst |   7 +
 drivers/cxl/core/hdm.c                   |  33 ++--
 drivers/cxl/core/memdev.c                |   1 +
 drivers/cxl/core/pci.c                   |   3 +-
 drivers/cxl/core/port.c                  |   2 +-
 drivers/cxl/core/regs.c                  | 172 ++++++++++--------
 drivers/cxl/cxl.h                        |  38 +++-
 drivers/cxl/cxlmem.h                     |   2 +
 drivers/cxl/cxlpci.h                     |   9 -
 drivers/cxl/pci.c                        | 213 ++++++++++++++++++-----
 drivers/pci/pcie/aer.c                   |   8 +-
 include/linux/pci.h                      |   3 +
 include/trace/events/cxl.h               | 112 ++++++++++++
 13 files changed, 453 insertions(+), 150 deletions(-)
 create mode 100644 include/trace/events/cxl.h

--

