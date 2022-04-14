Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C86501CB0
	for <lists+linux-pci@lfdr.de>; Thu, 14 Apr 2022 22:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346327AbiDNUfK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Apr 2022 16:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346325AbiDNUfJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Apr 2022 16:35:09 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F768AACBE;
        Thu, 14 Apr 2022 13:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649968363; x=1681504363;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FGQSUPr61CrJ3mKDxUVwvrPPytbiptuHCa5PtNvibyQ=;
  b=NfXpBCrpb6oSpFGUBhLsKqsYn400GuPdq/GJQnKXaer4M7o0H+Fb+aYs
   Kf9mciIwssoZP8AgvudFOMgCYSxhrvHpMCz0LBU0mmCTvkzcfRYFr8uD+
   Mg1qXZueMlo7ZErJ8Ex2zD8G0wfeZ7HM2XT6Z87ZqVjyrXcsNOIOJSWTI
   bZ27E7YtS8af9IWw/UtIcw04GFgET0pFSv83iajnJzvXQqvGD/1jjzGFm
   fDoouLfJybbFmGGuZ9fr9W2D+YyR6iylIZcCbXj6tpTnN3rAGhyCK95VZ
   B4Tl5IKfGy7CmZxwMe+WH5rKyrQ3QDb04gh/sQgSysPG0cVXGB7NubDp6
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="349460354"
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="349460354"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 13:32:43 -0700
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="725514035"
Received: from aimeehax-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.113.132])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 13:32:42 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH V8 00/10] CXL: Read CDAT and DSMAS data from the device
Date:   Thu, 14 Apr 2022 13:32:27 -0700
Message-Id: <20220414203237.2198665-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Changes from V7:[4]
	Avoid code bloat by making pci-doe.c conditional on CONFIG_PCI_DOE
		which is auto selected by the CXL_PCI config option.
	Minor code clean ups
	Fix bug in pci_doe_supports_prot()
	Rebase to cxl-pending

Changes from V6:[3]
	The big change is the removal of the auxiliary bus code from the PCI
	layer.  The auxiliary bus usage is now in the CXL layer.  The PCI layer
	provides helpers for subsystems to utilize DOE mailboxes by creating a
	pci_doe_mb object which controls a state machine for that mailbox
	capability.  The CXL layer wraps this object in an auxiliary device and
	driver which can then be used to determine if the kernel is controlling
	the capability or it is available to be used by user space.  Reads from
	user space via lspci are allowed.  Writes are allowed but flagged via a
	tainting the kernel.

	Feedback from Bjorn, Jonathan, and Dan
		Details in each patch

Changes from V5:[0]

	Rework the patch set to split PCI vs CXL changes
		Also make each change a bit more stand alone for easier review
	Add cxl_cdat structure
	Put CDAT related data structures in cdat.h
	Clarify some device lifetimes with comments
	Incorporate feedback from Jonathan, Bjorn and Dan
		The bigest change is placing the DOE scanning code into the
			pci_doe driver (part of the PCI codre).
		Validate the CDAT when it is read rather than before DSMAS
			parsing
		Do not report DSMAS failure as an error, report a warning and
			keep going.
		Retry reading the table 1 time.
	Update commit messages and this cover letter



CXL drivers need various data which are provided through generic DOE mailboxes
as defined in the PCIe 6.0 spec.[1]

One such data is the Coherent Device Atribute Table (CDAT).  CDAT data provides
coherent information about the various devices in the system.  It was developed
because systems no longer have a priori knowledge of all coherent devices
within a system.  CDAT describes the coherent characteristics of the
components on the CXL bus separate from system configurations.  The OS can
then, for example, use this information to form correct interleave sets.

To begin reading the CDAT the OS must have support to access the DOE mailboxes
provided by the CXL devices.

Because DOE is not specific to DOE but is provided within the PCI spec, the
series adds PCI DOE capability library functions.  These functions allow for
the iteration of the DOE capabilities on a device as well as creating
pci_doe_mb structures which can control the operation of the DOE state machine.

CXL iterates the DOE capabilities creates auxiliary bus devices.  These devices
are driven by a CXL DOE auxiliary driver which calls into the PCI DOE library
functions as appropriate.

The auxiliary bus architecture allows for root users to control which DOE
mailboxes are controlled by the kernel and which should be allowed for
unrestricted access by user space.  One such use case is to allow for CXL
Compliance Testing (CXL 2.0 14.16.4 Compliance Mode DOE).  By default the
kernel controls all mailboxes found.

After the devices are created and the driver attaches, CDAT data is read from
the device and DSMAS information parsed from that CDAT blob for use later.

This work was tested using qemu with additional patches.


[0] https://lore.kernel.org/linux-cxl/20211105235056.3711389-1-ira.weiny@intel.com/
[1] https://pcisig.com/specifications
[2] https://lore.kernel.org/qemu-devel/20210202005948.241655-1-ben.widawsky@intel.com/
[3] https://lore.kernel.org/linux-cxl/20220201071952.900068-1-ira.weiny@intel.com/
[4] https://lore.kernel.org/linux-cxl/20220330235920.2800929-1-ira.weiny@intel.com/


Ira Weiny (7):
PCI: Replace magic constant for PCI Sig Vendor ID
cxl/pci: Create auxiliary devices for each DOE mailbox
cxl/pci: Create DOE auxiliary driver
cxl/pci: Find the DOE mailbox which supports CDAT
cxl/cdat: Introduce cxl_cdat_valid()
cxl/mem: Retry reading CDAT on failure
cxl/port: Parse out DSMAS data from CDAT table

Jonathan Cameron (3):
PCI: Add vendor ID for the PCI SIG
PCI: Create PCI library functions in support of DOE mailboxes.
cxl/mem: Read CDAT table

drivers/cxl/Kconfig | 14 +
drivers/cxl/Makefile | 2 +
drivers/cxl/cdat.h | 116 +++++++
drivers/cxl/core/memdev.c | 38 +++
drivers/cxl/cxl.h | 8 +
drivers/cxl/cxlmem.h | 28 ++
drivers/cxl/cxlpci.h | 35 ++
drivers/cxl/doe.c | 90 +++++
drivers/cxl/pci.c | 423 +++++++++++++++++++++++
drivers/cxl/port.c | 65 ++++
drivers/pci/Kconfig | 3 +
drivers/pci/Makefile | 1 +
drivers/pci/pci-doe.c | 607 ++++++++++++++++++++++++++++++++++
drivers/pci/probe.c | 2 +-
include/linux/pci-doe.h | 119 +++++++
include/linux/pci_ids.h | 1 +
include/uapi/linux/pci_regs.h | 30 +-
17 files changed, 1580 insertions(+), 2 deletions(-)
create mode 100644 drivers/cxl/cdat.h
create mode 100644 drivers/cxl/doe.c
create mode 100644 drivers/pci/pci-doe.c
create mode 100644 include/linux/pci-doe.h


base-commit: 4f497e0dd3530981f8c897d5d47ee880b62baefb
--
2.35.1

