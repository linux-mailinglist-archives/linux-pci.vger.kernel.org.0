Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF87F4DA92F
	for <lists+linux-pci@lfdr.de>; Wed, 16 Mar 2022 05:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346005AbiCPEPC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Mar 2022 00:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiCPEPA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Mar 2022 00:15:00 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1297331DFF;
        Tue, 15 Mar 2022 21:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647404027; x=1678940027;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HkxuiiMewEe5GHxvJNhs+IrRwLWpzGNBx7XjY8xEF00=;
  b=dltiltzs4AJ1p0Uhl4H2cWbggZiboSNtm2OpBHXgQqRIW9V0ANPV/uiA
   kjKJcgalzCDdRz6vrCkyjjFk+/j3BidNAzn+8mLngCmlrcF/fs14o4BEh
   E1v43vamwGS8xikcxw7hmgHl4oNTZtCbZNn8PwJz3SokVpDX0+WzO0pda
   0OJ1d2gD0Cvzazz0eLGB+/Vh2heEY2GdD6g3cdvhaYraoNnYnufTrKeFS
   baVc+qSwee7ZPl6Vpv3NHBlu4AMCGBaw8u3DSjAtgrbuOyHY2o2lo25Hq
   T3/kAtFY98f3NpWv9A+tm0uQKzTk/x79VNyBkWW5AWN91FFPw7ngogj/L
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="243942220"
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="243942220"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 21:13:42 -0700
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="516166347"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 21:13:42 -0700
Subject: [PATCH 0/8] cxl/pci: Add fundamental error handling
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     ben.widawsky@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, Jonathan.Cameron@huawei.com,
        ira.weiny@intel.com, linux-pci@vger.kernel.org
Date:   Tue, 15 Mar 2022 21:13:42 -0700
Message-ID: <164740402242.3912056.8303625392871313860.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a 'struct pci_error_handlers' instance for the cxl_pci driver.
Section 8.2.5.9 "CXL RAS Capability Structure" of the CXL 2.0
specification defines the error sources considered in this
implementation. The RAS Capability Structure defines protocol, link and
internal errors which are distinct from memory poison errors that are
conveyed via direct consumption and/or media scanning.

The errors reported by the RAS registers are categorized into
correctable and uncorrectable errors, where the uncorrectable errors are
optionally steered to either fatal or non-fatal AER events. Table 224
"Device Specific Error Reporting and Nomenclature Guidelines" in the CXL
2.0 specification outlines that the remediation for uncorrectable errors
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

[1]: https://www.computeexpresslink.org/spec-landing

---


Dan Williams (8):
      cxl/pci: Cleanup repeated code in cxl_probe_regs() helpers
      cxl/pci: Cleanup cxl_map_device_regs()
      cxl/pci: Kill cxl_map_regs()
      cxl/core/regs: Make cxl_map_{component,device}_regs() device generic
      cxl/port: Limit the port driver to just the HDM Decoder Capability
      cxl/pci: Prepare for mapping RAS Capability Structure
      cxl/pci: Find and map the RAS Capability Structure
      cxl/pci: Add (hopeful) error handling support


 drivers/cxl/core/hdm.c    |   33 +++++----
 drivers/cxl/core/memdev.c |    1 
 drivers/cxl/core/pci.c    |    3 -
 drivers/cxl/core/port.c   |    2 -
 drivers/cxl/core/regs.c   |  172 ++++++++++++++++++++++++++-------------------
 drivers/cxl/cxl.h         |   36 +++++++--
 drivers/cxl/cxlmem.h      |    2 +
 drivers/cxl/cxlpci.h      |    9 --
 drivers/cxl/pci.c         |  163 ++++++++++++++++++++++++++++++++-----------
 9 files changed, 273 insertions(+), 148 deletions(-)

base-commit: 74be98774dfbc5b8b795db726bd772e735d2edd4
