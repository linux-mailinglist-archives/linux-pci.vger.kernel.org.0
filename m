Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 770F657A2D7
	for <lists+linux-pci@lfdr.de>; Tue, 19 Jul 2022 17:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239023AbiGSPV5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Jul 2022 11:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiGSPVz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jul 2022 11:21:55 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5273550B1;
        Tue, 19 Jul 2022 08:21:53 -0700 (PDT)
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LnMsv75gxz689SS;
        Tue, 19 Jul 2022 23:18:27 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 19 Jul 2022 17:21:48 +0200
Received: from localhost (10.81.209.49) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 19 Jul
 2022 16:21:47 +0100
Date:   Tue, 19 Jul 2022 16:21:45 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V14 0/7] CXL: Read CDAT
Message-ID: <20220719162145.000054bc@Huawei.com>
In-Reply-To: <20220715030424.462963-1-ira.weiny@intel.com>
References: <20220715030424.462963-1-ira.weiny@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.209.49]
X-ClientProxiedBy: lhreml749-chm.china.huawei.com (10.201.108.199) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 14 Jul 2022 20:04:17 -0700
ira.weiny@intel.com wrote:

> From: Ira Weiny <ira.weiny@intel.com>
> 
> Details of changes are in the individual patches.
> 
> Major changes from V13:[10]
> 	Dan minor updates
> 	Willy's suggestion of documentation is good but I'm deferring it until
> 	we get the location of the PCI mailboxes settled.
> 	Drop retry CDAT patch
> 	Drop DSMAS patch
> 	Rebased on latest cxl-pending
> 
> CXL drivers need various data which are provided through generic DOE mailboxes
> as defined in the PCIe 6.0 spec.[1]
> 
> One such data is the Coherent Device Attribute Table (CDAT).  CDAT data provides
> coherent information about the various devices in the system.  It was developed
> because systems no longer have a priori knowledge of all coherent devices
> within a system.  CDAT describes the coherent characteristics of the
> components on the CXL bus separate from system configurations.  The OS can
> then, for example, use this information to form correct interleave sets.
> 
> To begin reading the CDAT the OS must have support to access the DOE mailboxes
> provided by the CXL devices.
> 
> Because DOE is not specific to DOE but is provided within the PCI spec, the
> series adds PCI DOE capability library functions.  These functions allow for
> the iteration of the DOE capabilities on a device as well as creating
> pci_doe_mb structures which can control the operation of the DOE state machine.
> 
> For now the iteration of and storage of the DOE mailboxes is done on memdev
> objects within the CXL stack.  When this is needed in more generic code this
> can be lifted later.
> 
> This work was tested using qemu.
> 
> [0] https://lore.kernel.org/linux-cxl/20211105235056.3711389-1-ira.weiny@intel.com/
> [1] https://pcisig.com/specifications
> [2] https://lore.kernel.org/qemu-devel/20210202005948.241655-1-ben.widawsky@intel.com/
> [3] https://lore.kernel.org/linux-cxl/20220201071952.900068-1-ira.weiny@intel.com/
> [4] https://lore.kernel.org/linux-cxl/20220330235920.2800929-1-ira.weiny@intel.com/
> [5] https://lore.kernel.org/linux-cxl/20220414203237.2198665-1-ira.weiny@intel.com/
> [6] https://lore.kernel.org/linux-cxl/20220531152632.1397976-1-ira.weiny@intel.com/
> [7] https://lore.kernel.org/linux-cxl/20220605005049.2155874-1-ira.weiny@intel.com/
> [8] https://lore.kernel.org/linux-cxl/20220610202259.3544623-1-ira.weiny@intel.com/
> [9] https://lore.kernel.org/linux-cxl/20220628041527.742333-1-ira.weiny@intel.com/
> [10] https://lore.kernel.org/linux-cxl/20220705154932.2141021-1-ira.weiny@intel.com/
> 
> 
> Previous changes
> ================
> 
> Changes from V12:[9]
> 	A couple of bug fixes in the new XArray stuff
> 	Remove the IRQ support because I did not realize how that worked and it
> 	was complicating things.
> 	Remove busy retries and replace with an error as there is no good way
> 	to ensure it will work.

This is fine for userspace access, but I think we probably will want retries
once we are using it in kernel.  Whilst we'd not expect it to be common as
per (very late) reply I sent to v13 discussion, the CDAT table can change
all on it's own (as far as software can see).  I'd expect it to be a once in
a blue moon thing though.


> 	Other code clean ups mentioned in the individual patches.
> 
> Changes from V11:[8]
> 	The major change in this version is to remove the workqueue from the
> 	internal implementation of the state machine.  A single ordered
> 	workqueue within each mailbox processes tasks submitted.  This
> 	workqueue takes care of all locking and guarantees that tasks are
> 	completed in the order submitted.  Any synchronization which is
> 	required between tasks will need to be handled by the user of the
> 	mailbox.  However, the user can depend on work items being completed in
> 	the order they are submitted.  So a single thread submitter is
> 	guaranteed to get all work items completed in order.  This also aids in
> 	the support of a single mailbox supporting multiple protocols.  Each
> 	protocol could have a separate thread submitting tasks for that
> 	protocol.  The mailbox object will ensure that each protocol task is
> 	complete before another task starts.  But multiple user threads can be
> 	submitting tasks for different protocols all at the same time without
> 	regard to other protocols being used.
> 
> 	XArrays are used throughout the series.
> 
> 	Other minor changes are noted in the individual patches.
> 
> Changes from V10:[7]
> 	Address Ben Widawsky's comments
> 		Protect against potentially malicious devices.
> 		Fix ownership issue of cdat_mb
> 
> Changes from V9:[6]
> 	Address feedback from
> 		Lukas Wunner, Davidlohr Bueso, Jonathan Cameron,
> 		Alison Schofield, and Ben Widawsky
> 		Details in each individual patch.
> 
> Changes from V8:[5]
> 	For this version I've punted a bit to get it out and drop the auxiliary
> 	bus functionality.  I like where Jonathan is going with the port driver
> 	idea.  I think eventually the irq/mailbox creation will need to be more
> 	generic in a PCI port driver.  I've modeled this version on such an
> 	architecture but used the CXL port for the time being.
> 
> 	From Dan
> 		Drop the auxiliary bus/device
> 	From Jonathan
> 		Cleanups
> 	From Bjorn
> 		Clean up commit messages
> 		move pci-doe.c to doe.c
> 		Clean up PCI spec references
> 		Ensure all messages use pci_*()
> 		Add offset to error messages to distinguish mailboxes
> 			use hex for DOE offsets
> 		Print 4 nibbles for Vendor ID and 2 for type.
> 		s/irq/IRQ in comments
> 		Fix long lines
> 		Fix typos
> 
> 
> Changes from V7:[4]
> 	Avoid code bloat by making pci-doe.c conditional on CONFIG_PCI_DOE
> 		which is auto selected by the CXL_PCI config option.
> 	Minor code clean ups
> 	Fix bug in pci_doe_supports_prot()
> 	Rebase to cxl-pending
> 
> Changes from V6:[3]
> 	The big change is the removal of the auxiliary bus code from the PCI
> 	layer.  The auxiliary bus usage is now in the CXL layer.  The PCI layer
> 	provides helpers for subsystems to utilize DOE mailboxes by creating a
> 	pci_doe_mb object which controls a state machine for that mailbox
> 	capability.  The CXL layer wraps this object in an auxiliary device and
> 	driver which can then be used to determine if the kernel is controlling
> 	the capability or it is available to be used by user space.  Reads from
> 	user space via lspci are allowed.  Writes are allowed but flagged via a
> 	tainting the kernel.
> 
> 	Feedback from Bjorn, Jonathan, and Dan
> 		Details in each patch
> 
> Changes from V5:[0]
> 
> 	Rework the patch set to split PCI vs CXL changes
> 		Also make each change a bit more stand alone for easier review
> 	Add cxl_cdat structure
> 	Put CDAT related data structures in cdat.h
> 	Clarify some device lifetimes with comments
> 	Incorporate feedback from Jonathan, Bjorn and Dan
> 		The bigest change is placing the DOE scanning code into the
> 			pci_doe driver (part of the PCI codre).
> 		Validate the CDAT when it is read rather than before DSMAS
> 			parsing
> 		Do not report DSMAS failure as an error, report a warning and
> 			keep going.
> 		Retry reading the table 1 time.
> 	Update commit messages and this cover letter
> 
> 
> 
> Ira Weiny (5):
>   PCI: Replace magic constant for PCI Sig Vendor ID
>   cxl/pci: Create PCI DOE mailbox's for memory devices
>   driver-core: Introduce BIN_ATTR_ADMIN_{RO,RW}
>   cxl/port: Read CDAT table
>   cxl/port: Introduce cxl_cdat_valid()
> 
> Jonathan Cameron (2):
>   PCI: Add vendor ID for the PCI SIG
>   PCI/DOE: Add DOE mailbox support functions
> 
>  .clang-format                           |   1 +
>  Documentation/ABI/testing/sysfs-bus-cxl |  10 +
>  drivers/cxl/Kconfig                     |   1 +
>  drivers/cxl/cdat.h                      |  63 +++
>  drivers/cxl/core/pci.c                  | 206 +++++++++
>  drivers/cxl/cxl.h                       |   5 +
>  drivers/cxl/cxlmem.h                    |   3 +
>  drivers/cxl/cxlpci.h                    |   1 +
>  drivers/cxl/pci.c                       |  44 ++
>  drivers/cxl/port.c                      |  54 +++
>  drivers/pci/Kconfig                     |   3 +
>  drivers/pci/Makefile                    |   1 +
>  drivers/pci/doe.c                       | 546 ++++++++++++++++++++++++
>  drivers/pci/probe.c                     |   2 +-
>  include/linux/pci-doe.h                 |  79 ++++
>  include/linux/pci_ids.h                 |   1 +
>  include/linux/sysfs.h                   |  16 +
>  include/uapi/linux/pci_regs.h           |  29 +-
>  18 files changed, 1063 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/cxl/cdat.h
>  create mode 100644 drivers/pci/doe.c
>  create mode 100644 include/linux/pci-doe.h
> 
> 
> base-commit: b060edfd8cdd52bc8648392500bf152a8dd6d4c5

