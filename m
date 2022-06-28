Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549E555CA0A
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 14:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233184AbiF1EPh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jun 2022 00:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243426AbiF1EPh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2022 00:15:37 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A035C286DE;
        Mon, 27 Jun 2022 21:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656389735; x=1687925735;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nUdvLjSvvq3d9ypjGx2+R+9aKmtVxibInZ+b+ZCqPHc=;
  b=Brzcoq5xM0D+Csqyo5Ob8IkLIRW6tuGpXRCIigLLoDiUt9ZEbGNLoTfA
   Ml5/H52C07Ub730C71YiSpCv7pbx9puZ2lafbPAjFS/Uc5y9BaLoDiOO5
   o75tMsBdQkdfgCV7L5tuCDV9KA29wwNcU1arj9I5jnRcBEVh9eemqOBW0
   uKIOIwelAkyJRVTm1MOuHgjZR23BMCDKc8tdt3PAwuFHW0I/Jp5VGl1Zs
   Niw2F3L3KPB6M+P3iPFM1sBuxXKaiwCnznUcQg82lRtCCY5gMm1ib07UQ
   +JpfoBi85chv0w5Zjfj73DUvTLQF3Cq+1hPHrhtv2s1X/EGvleq6AwlKv
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="279174172"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="279174172"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 21:15:35 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="679865074"
Received: from nakedgex-mobl.amr.corp.intel.com (HELO localhost) ([10.255.3.161])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 21:15:32 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Lukas Wunner <lukas@wunner.de>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH V12 0/9] CXL: Read CDAT and DSMAS data
Date:   Mon, 27 Jun 2022 21:15:18 -0700
Message-Id: <20220628041527.742333-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>


Changes from V11:[8]
	The major change in this version is to remove the workqueue from the
	internal implementation of the state machine.  A single ordered
	workqueue within each mailbox processes tasks submitted.  This
	workqueue takes care of all locking and guarantees that tasks are
	completed in the order submitted.  Any synchronization which is
	required between tasks will need to be handled by the user of the
	mailbox.  However, the user can depend on work items being completed in
	the order they are submitted.  So a single thread submitter is
	guaranteed to get all work items completed in order.  This also aids in
	the support of a single mailbox supporting multiple protocols.  Each
	protocol could have a separate thread submitting tasks for that
	protocol.  The mailbox object will ensure that each protocol task is
	complete before another task starts.  But multiple user threads can be
	submitting tasks for different protocols all at the same time without
	regard to other protocols being used.

	XArrays are used throughout the series.

	Other minor changes are noted in the individual patches.

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

For now the iteration of and storage of the DOE mailboxes is done on memdev
objects within the CXL stack.  When this is needed in more generic code this
can be lifted later.

This work was tested using qemu.

[0] https://lore.kernel.org/linux-cxl/20211105235056.3711389-1-ira.weiny@intel.com/
[1] https://pcisig.com/specifications
[2] https://lore.kernel.org/qemu-devel/20210202005948.241655-1-ben.widawsky@intel.com/
[3] https://lore.kernel.org/linux-cxl/20220201071952.900068-1-ira.weiny@intel.com/
[4] https://lore.kernel.org/linux-cxl/20220330235920.2800929-1-ira.weiny@intel.com/
[5] https://lore.kernel.org/linux-cxl/20220414203237.2198665-1-ira.weiny@intel.com/
[6] https://lore.kernel.org/linux-cxl/20220531152632.1397976-1-ira.weiny@intel.com/
[7] https://lore.kernel.org/linux-cxl/20220605005049.2155874-1-ira.weiny@intel.com/
[8] https://lore.kernel.org/linux-cxl/20220610202259.3544623-1-ira.weiny@intel.com/


Previous changes
================

Changes from V10:[7]
	Address Ben Widawsky's comments
		Protect against potentially malicious devices.
		Fix ownership issue of cdat_mb

Changes from V9:[6]
	Address feedback from
		Lukas Wunner, Davidlohr Bueso, Jonathan Cameron,
		Alison Schofield, and Ben Widawsky
		Details in each individual patch.

Changes from V8:[5]
	For this version I've punted a bit to get it out and drop the auxiliary
	bus functionality.  I like where Jonathan is going with the port driver
	idea.  I think eventually the irq/mailbox creation will need to be more
	generic in a PCI port driver.  I've modeled this version on such an
	architecture but used the CXL port for the time being.

	From Dan
		Drop the auxiliary bus/device
	From Jonathan
		Cleanups
	From Bjorn
		Clean up commit messages
		move pci-doe.c to doe.c
		Clean up PCI spec references
		Ensure all messages use pci_*()
		Add offset to error messages to distinguish mailboxes
			use hex for DOE offsets
		Print 4 nibbles for Vendor ID and 2 for type.
		s/irq/IRQ in comments
		Fix long lines
		Fix typos


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



Ira Weiny (7):
  PCI: Replace magic constant for PCI Sig Vendor ID
  cxl/pci: Create PCI DOE mailbox's for memory devices
  driver-core: Introduce BIN_ATTR_ADMIN_{RO,RW}
  cxl/port: Read CDAT table
  cxl/port: Introduce cxl_cdat_valid()
  cxl/port: Retry reading CDAT on failure
  cxl/port: Parse out DSMAS data from CDAT table

Jonathan Cameron (2):
  PCI: Add vendor ID for the PCI SIG
  PCI: Create PCIe library functions in support of DOE mailboxes.

 .clang-format                 |   1 +
 drivers/cxl/Kconfig           |   1 +
 drivers/cxl/cdat.h            | 125 ++++++
 drivers/cxl/core/pci.c        | 293 +++++++++++++++
 drivers/cxl/cxl.h             |   7 +
 drivers/cxl/cxlmem.h          |   7 +
 drivers/cxl/cxlpci.h          |   2 +
 drivers/cxl/mem.c             |   1 +
 drivers/cxl/pci.c             |  37 ++
 drivers/cxl/port.c            |  51 +++
 drivers/pci/Kconfig           |   3 +
 drivers/pci/Makefile          |   1 +
 drivers/pci/doe.c             | 689 ++++++++++++++++++++++++++++++++++
 drivers/pci/probe.c           |   2 +-
 include/linux/pci-doe.h       |  81 ++++
 include/linux/pci_ids.h       |   1 +
 include/linux/sysfs.h         |  16 +
 include/uapi/linux/pci_regs.h |  29 +-
 18 files changed, 1345 insertions(+), 2 deletions(-)
 create mode 100644 drivers/cxl/cdat.h
 create mode 100644 drivers/pci/doe.c
 create mode 100644 include/linux/pci-doe.h


base-commit: 34e37b4c432cd0f1842b352fde4b8878b4166888
-- 
2.35.3

