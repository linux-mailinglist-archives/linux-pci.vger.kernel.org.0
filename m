Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49F5557A89B
	for <lists+linux-pci@lfdr.de>; Tue, 19 Jul 2022 22:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237152AbiGSUw5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Jul 2022 16:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239518AbiGSUwz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jul 2022 16:52:55 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34F06112F;
        Tue, 19 Jul 2022 13:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658263974; x=1689799974;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Qlvux+0tJNTc3jDEg7o87kv/2rTQfUAnojQOoPbsRIg=;
  b=RLs2K5pO5FrgFtiTY8nk1OjW8OCb3FmhoylRWo9y1rc/jwE3vgWhKBd6
   6+1Br3dj9mFTKYhtoGd2i60ME+OfrYQOcN4++u6/smimTbrXin51h9Fq0
   0+cAm5IF6jty2uU+gCeDuo/DpqcwR292fvjhduLBvY1fsId1SsvKOZXvd
   Pm64qa5h6GObioajThYPyTNs0eDUcGn1uaQP5LROU74ADG3A2lCJwroVF
   tjjE86jAQNPYlGNJdIS2lH3p7j9zeCp0BPHJhLs0W/FpIS6Dvk6YIgo6R
   kSFym5reCCe7bEGMNnBRCHdyWvZrw44EtRBd1GoIttpD8VKfdzL0cKzjv
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10413"; a="350580090"
X-IronPort-AV: E=Sophos;i="5.92,285,1650956400"; 
   d="scan'208";a="350580090"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 13:52:54 -0700
X-IronPort-AV: E=Sophos;i="5.92,285,1650956400"; 
   d="scan'208";a="655944845"
Received: from kscamus-mobl1.amr.corp.intel.com (HELO localhost) ([10.255.6.221])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 13:52:52 -0700
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
Subject: [PATCH V16 0/6] CXL: Read CDAT
Date:   Tue, 19 Jul 2022 13:52:43 -0700
Message-Id: <20220719205249.566684-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>


Details of changes are in the individual patches.

Major changes from V14:[11]
	Pick up Dan's V15 version of the CDAT patch
	Fix up 3/7 with Jonathans cleanups
	Drop valid check patch and deffer to ACPI vailidation later

CXL drivers need various data which are provided through generic DOE mailboxes
as defined in the PCIe 6.0 spec.[1]

One such data is the Coherent Device Attribute Table (CDAT).  CDAT data provides
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
[9] https://lore.kernel.org/linux-cxl/20220628041527.742333-1-ira.weiny@intel.com/
[10] https://lore.kernel.org/linux-cxl/20220705154932.2141021-1-ira.weiny@intel.com/
[11] https://lore.kernel.org/linux-cxl/20220715030424.462963-1-ira.weiny@intel.com/

Previous changes
================

Major changes from V13:[10]
	Dan minor updates
	Willy's suggestion of documentation is good but I'm deferring it until
	we get the location of the PCI mailboxes settled.
	Drop retry CDAT patch
	Drop DSMAS patch
	Rebased on latest cxl-pending

Changes from V12:[9]
	A couple of bug fixes in the new XArray stuff
	Remove the IRQ support because I did not realize how that worked and it
	was complicating things.
	Remove busy retries and replace with an error as there is no good way
	to ensure it will work.
	Other code clean ups mentioned in the individual patches.

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



Ira Weiny (4):
  PCI: Replace magic constant for PCI Sig Vendor ID
  cxl/pci: Create PCI DOE mailbox's for memory devices
  driver-core: Introduce BIN_ATTR_ADMIN_{RO,RW}
  cxl/port: Read CDAT table

Jonathan Cameron (2):
  PCI: Add vendor ID for the PCI SIG
  PCI/DOE: Add DOE mailbox support functions

 .clang-format                           |   1 +
 Documentation/ABI/testing/sysfs-bus-cxl |  10 +
 drivers/cxl/Kconfig                     |   1 +
 drivers/cxl/core/pci.c                  | 173 ++++++++
 drivers/cxl/cxl.h                       |   7 +
 drivers/cxl/cxlmem.h                    |   3 +
 drivers/cxl/cxlpci.h                    |   1 +
 drivers/cxl/pci.c                       |  44 ++
 drivers/cxl/port.c                      |  53 +++
 drivers/pci/Kconfig                     |   3 +
 drivers/pci/Makefile                    |   1 +
 drivers/pci/doe.c                       | 536 ++++++++++++++++++++++++
 drivers/pci/probe.c                     |   2 +-
 include/linux/pci-doe.h                 |  77 ++++
 include/linux/pci_ids.h                 |   1 +
 include/linux/sysfs.h                   |  16 +
 include/uapi/linux/pci_regs.h           |  29 +-
 17 files changed, 956 insertions(+), 2 deletions(-)
 create mode 100644 drivers/pci/doe.c
 create mode 100644 include/linux/pci-doe.h


base-commit: b060edfd8cdd52bc8648392500bf152a8dd6d4c5
-- 
2.35.3

