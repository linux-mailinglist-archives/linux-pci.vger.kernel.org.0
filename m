Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63342546E37
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jun 2022 22:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350480AbiFJUXG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jun 2022 16:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240289AbiFJUXF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jun 2022 16:23:05 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9A02A97F;
        Fri, 10 Jun 2022 13:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654892584; x=1686428584;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zoQP38bXu51zIjhijgSb38PIa89Sy1jQuBhhFQxrEkA=;
  b=GPvkE6Ng2MSW6YUvrIfWCW4tgQ/pQmeuyuZpmkwH2K9oQ24TK6q4nQIy
   Wf2huQqJ+83JE+4AToljJPEth3rqZoVi0i4aGq35lzyVKpSHnaszEkmmv
   OUXZEVUYQPj3ghGdeJoz7XbrX4AqPTHbqDN1zt2v2rx/XmVcymdkvR5fb
   MHXNevMgrS4Kvr2tOOfqadGy6jA+aD1n1kMSlCA5vtS2TvbVyG1fDg7ex
   XFOEr4f+KiBTj6gw/j/g/s5ZAR0gRJbkihA6DhayDTHsDdoYIY3pGZBTC
   W6ZxTgrGz0ezhfT30nap/uMvM9RiCp+vt5iTOBQRXC4/AeghKMV0pj/Rr
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="275268536"
X-IronPort-AV: E=Sophos;i="5.91,291,1647327600"; 
   d="scan'208";a="275268536"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 13:23:03 -0700
X-IronPort-AV: E=Sophos;i="5.91,291,1647327600"; 
   d="scan'208";a="828422389"
Received: from pleung-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.33.34])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 13:23:03 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH V11 0/8] CXL: Read CDAT and DSMAS data
Date:   Fri, 10 Jun 2022 13:22:51 -0700
Message-Id: <20220610202259.3544623-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>


Changes from V10:[7]
	Address Ben Widawsky's comments
		Protect against potentially malicious devices.
		Fix ownership issue of cdat_mb

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


Previous changes
================

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



Ira Weiny (6):
  PCI: Replace magic constant for PCI Sig Vendor ID
  cxl/pci: Create PCI DOE mailbox's for memory devices
  cxl/port: Read CDAT table
  cxl/port: Introduce cxl_cdat_valid()
  cxl/port: Retry reading CDAT on failure
  cxl/port: Parse out DSMAS data from CDAT table

Jonathan Cameron (2):
  PCI: Add vendor ID for the PCI SIG
  PCI: Create PCI library functions in support of DOE mailboxes.

 drivers/cxl/Kconfig           |   1 +
 drivers/cxl/cdat.h            | 125 ++++++
 drivers/cxl/core/pci.c        | 302 +++++++++++++++
 drivers/cxl/cxl.h             |   5 +
 drivers/cxl/cxlmem.h          |  10 +
 drivers/cxl/cxlpci.h          |   2 +
 drivers/cxl/mem.c             |   1 +
 drivers/cxl/pci.c             | 114 ++++++
 drivers/cxl/port.c            |  51 +++
 drivers/pci/Kconfig           |   3 +
 drivers/pci/Makefile          |   1 +
 drivers/pci/doe.c             | 693 ++++++++++++++++++++++++++++++++++
 drivers/pci/probe.c           |   2 +-
 include/linux/pci-doe.h       |  65 ++++
 include/linux/pci_ids.h       |   1 +
 include/uapi/linux/pci_regs.h |  29 +-
 16 files changed, 1403 insertions(+), 2 deletions(-)
 create mode 100644 drivers/cxl/cdat.h
 create mode 100644 drivers/pci/doe.c
 create mode 100644 include/linux/pci-doe.h

-- 
2.35.1

