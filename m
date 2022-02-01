Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E24234A579D
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 08:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234702AbiBAHUA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 02:20:00 -0500
Received: from mga03.intel.com ([134.134.136.65]:54894 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232736AbiBAHT7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Feb 2022 02:19:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643699999; x=1675235999;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BqXn7pM7b7lRgbxgdbYvk7n8+LbHH6EQAUSCPKirLYE=;
  b=mcDE5SCvAwY+E+jzullDfG3sOS7r7nGCGp39GEjuvCzVR4hknewaNK4W
   VrK2YPSN1mN1H5O2E0xblg9a5T246bB7W07t1HNhlovxIqxJKvwpLl608
   mUtKDP26hOQujAHCUzn7SR2mDE1TQnIhV5z5roROMgu+U22fd3g4WIJHd
   LuYNPOfM+kGYY8f1scUaxHjs/IQlKMZQdwWcD3irqZaRIeG80vxSYOvg2
   Gvh8ii4d5g5uKDBTl2bxaXy5NsN1fceLo/m+3moUeZX4TbyHfTV0nL3e8
   9EW21hKtBVgKO64tjUcTwyDiTNqdjvjM/rIaMOh46DADoYoCJNOWqNbHI
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="247587391"
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="247587391"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 23:19:58 -0800
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="537692673"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 23:19:57 -0800
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH V6 00/10] CXL: Read CDAT and DSMAS data from the device
Date:   Mon, 31 Jan 2022 23:19:42 -0800
Message-Id: <20220201071952.900068-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

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

NOTE: Should we retry more than 1 time?


CXL drivers need various data which are provided through generic DOE mailboxes
as defined in the PCIe r5.0 ECN.[1]

One such data is the Coherent Device Atribute Table (CDAT).  CDAT data provides
coherent information about the various devices in the system.  It was developed
because systems know longer have apriori knowledge of all coherent devices
within a system.  CDAT describes the coherent characteristics of the
components on the CXL bus separate from system configurations.  The OS can
then, for example, use this information to form correct interleave sets.

To begin reading the CDAT the OS must have support to access the DOE mailboxes
provided by the CXL devices.

The series creates a new PCI DOE auxiliary bus driver.  The CXL devices are
modified to create DOE auxiliary devices which are found and driven by the new
PCI DOE driver.

After the devices are created and the driver attaches, CDAT data is read from
the device and DSMAS information parsed from that CDAT blob for use later.

Because DOE is not specific to DOE but is provided within the PCI spec, the DOE
driver is added to the PCI subsystem.  This is part of the reason the auxiliary
bus architecture was used.  It allows for a clean separation between
subsystems.  In addition, and more importantly, the auxiliary bus architecture
allows for root users to control which DOE mailboxes are controlled by the
kernel and which may be optionally used for direct access by user space.  One
such use case is to allow for CXL Compliance Testing (CXL 2.0 14.16.4
Compliance Mode DOE).  By default the kernel controls this mailbox and would
not allow access to it.  But a root user could detach the driver from this
mailbox and gain direct access to the mailbox on a test system.

sysfs shows this relationship.  Starting with a qemu system with 2 memory
devices mem0 and mem1.

$ ls -l /sys/bus/cxl/devices/mem*
lrwxrwxrwx 1 root root 0 Jan 25 16:15 /sys/bus/cxl/devices/mem0 -> ../../../devices/pci0000:34/0000:34:00.0/0000:35:00.0/mem0
lrwxrwxrwx 1 root root 0 Jan 25 16:15 /sys/bus/cxl/devices/mem1 -> ../../../devices/pci0000:34/0000:34:01.0/0000:36:00.0/mem1

$ ls -l /sys/bus/auxiliary/devices/
total 0
lrwxrwxrwx 1 root root 0 Jan 25 16:16 pci_doe.doe.0 -> ../../../devices/pci0000:34/0000:34:00.0/0000:35:00.0/pci_doe.doe.0
lrwxrwxrwx 1 root root 0 Jan 25 16:16 pci_doe.doe.1 -> ../../../devices/pci0000:34/0000:34:01.0/0000:36:00.0/pci_doe.doe.1
lrwxrwxrwx 1 root root 0 Jan 25 16:16 pci_doe.doe.2 -> ../../../devices/pci0000:34/0000:34:01.0/0000:36:00.0/pci_doe.doe.2
lrwxrwxrwx 1 root root 0 Jan 25 16:16 pci_doe.doe.3 -> ../../../devices/pci0000:34/0000:34:00.0/0000:35:00.0/pci_doe.doe.3

$ ls -l /sys/bus/auxiliary/drivers
total 0
drwxr-xr-x 2 root root 0 Jan 25 16:15 pci_doe.pci_doe


This work was built on Jonathan's V4 series here[2].  The big change is a
conversion to an Auxiliary bus infrastructure which allows the DOE code to be
in a separate driver object which is attached to any DOE devices created by any
device.

This work was tested using qemu with additional patches.[3, 4]


[0] https://lore.kernel.org/linux-cxl/20211105235056.3711389-1-ira.weiny@intel.com/
[1] https://pcisig.com/specifications
[2] https://lore.kernel.org/linux-cxl/20210524133938.2815206-1-Jonathan.Cameron@huawei.com
[3] https://lore.kernel.org/qemu-devel/20210202005948.241655-1-ben.widawsky@intel.com/
[4] https://lore.kernel.org/qemu-devel/1619454964-10190-1-git-send-email-cbrowy@avery-design.com/


Ira Weiny (7):
PCI: Replace magic constant for PCI Sig Vendor ID
PCI/DOE: Introduce pci_doe_create_doe_devices
cxl/pci: Create DOE auxiliary devices
cxl/pci: Find the DOE mailbox which supports CDAT
cxl/cdat: Introduce cdat_hdr_valid()
cxl/mem: Retry reading CDAT on failure
cxl/cdat: Parse out DSMAS data from CDAT table

Jonathan Cameron (3):
PCI: Add vendor ID for the PCI SIG
PCI/DOE: Add Data Object Exchange Aux Driver
cxl/mem: Read CDAT table

drivers/cxl/Kconfig | 1 +
drivers/cxl/cdat.h | 120 +++++
drivers/cxl/core/memdev.c | 141 ++++++
drivers/cxl/cxl.h | 3 +
drivers/cxl/cxlmem.h | 27 ++
drivers/cxl/pci.c | 173 ++++++++
drivers/pci/Kconfig | 10 +
drivers/pci/Makefile | 3 +
drivers/pci/doe.c | 798 ++++++++++++++++++++++++++++++++++
drivers/pci/probe.c | 2 +-
include/linux/pci-doe.h | 63 +++
include/linux/pci_ids.h | 1 +
include/uapi/linux/pci_regs.h | 29 +-
13 files changed, 1369 insertions(+), 2 deletions(-)
create mode 100644 drivers/cxl/cdat.h
create mode 100644 drivers/pci/doe.c
create mode 100644 include/linux/pci-doe.h

--
2.31.1

