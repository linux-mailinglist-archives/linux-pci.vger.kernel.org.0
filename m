Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDFB61AC1B
	for <lists+linux-pci@lfdr.de>; Sun, 12 May 2019 14:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbfELMuf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 12 May 2019 08:50:35 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37406 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfELMuf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 12 May 2019 08:50:35 -0400
Received: by mail-pf1-f195.google.com with SMTP id g3so5679768pfi.4;
        Sun, 12 May 2019 05:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vYu/407M8S1qkyUUpb3iTm4J/kHMSZ10UPqCtM2J2yY=;
        b=u0kUrNKWTLjq7HTWKxtICn++2k1d/k0Pq8tkKmeikZQDi6eEfffR1nfkCd554edgPX
         2MUwxnhYtJV4kfv9fdOGImb5tXHNYQLrEDYyCpSw40xafsMKzBIxE0fsn6WIb/jdXfQE
         +XQm+VMEdCfWYpkcTOcpW8wiImH49HL2b6C/QCd6flY9SqjKOl7nRrNcnLHfBlaXwC5Y
         l4wJ/0YUFaFQtRB99o2MXv/LYVgqrp5QN6g8eihGfhkR92RLDROuLw50blnJyiiYOZBL
         pqhISAU3Bxjko4cmX+tD1JR3glax5ceuA66bWkmrzc666e4iyex2CPafdxICo8X2Mqgm
         SKXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vYu/407M8S1qkyUUpb3iTm4J/kHMSZ10UPqCtM2J2yY=;
        b=WGd/1Sq803gaw6JAsX8jpZekJQWsc1S0AfdoT8T5ir27BC2z48rZybr5SYCF0/nWOP
         tdMIg7Crjd+QbRNXWP24gFt7NR7OwyLpeRWswMQgzlCEZZV9dpJhT06WW6mxx5nfgdhG
         2+WNAgq0YdmybSPqW4L2U0jIa5fFxOMoHgMRkFXFGUBEsC6mWjU1J5M6DFl/CUJw3yL6
         Tj488V08RuHfMEd4oNEkJjBpf/LgY1ID3LTO7RCDsQAKlJdOzOtlHMwBwxra7l2ZgF0H
         W24CLFlzuLiyWLRkFizmePXwc1Gu+yqMcfc5a/mm5/JchC0DVlOoD+DD4SYTlVANsYdv
         ah3A==
X-Gm-Message-State: APjAAAUmZtkmLq5di/TT+dHwhQotATfRhaEipecwj5ziNhPRRsVoRVZ0
        qbYoNvWo5323m15o261fIm0=
X-Google-Smtp-Source: APXvYqxNrHCNOz4+P8sYo1pUjw7vEKuMGT9Tr8rR7/YFLrHmV5ocTORtRmWBwsr2j4IhGfXnCnNN9w==
X-Received: by 2002:aa7:93ba:: with SMTP id x26mr27177321pff.238.1557665433490;
        Sun, 12 May 2019 05:50:33 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id n2sm146426pgp.27.2019.05.12.05.50.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 12 May 2019 05:50:33 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     bhelgaas@google.com, corbet@lwn.net
Cc:     linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v4 02/12] Documentation: PCI: convert pci.txt to reST
Date:   Sun, 12 May 2019 20:49:59 +0800
Message-Id: <20190512125009.32079-3-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190512125009.32079-1-changbin.du@gmail.com>
References: <20190512125009.32079-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This converts the plain text documentation to reStructuredText format and
add it to Sphinx TOC tree. No essential content change.

The description about struct pci_driver and struct pci_device_id are moved
into in-source comments.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/PCI/index.rst            |   2 +
 Documentation/PCI/{pci.txt => pci.rst} | 356 +++++++++++--------------
 include/linux/mod_devicetable.h        |  19 ++
 include/linux/pci.h                    |  37 +++
 4 files changed, 207 insertions(+), 207 deletions(-)
 rename Documentation/PCI/{pci.txt => pci.rst} (68%)

diff --git a/Documentation/PCI/index.rst b/Documentation/PCI/index.rst
index c2f8728d11cf..7babf43709b0 100644
--- a/Documentation/PCI/index.rst
+++ b/Documentation/PCI/index.rst
@@ -7,3 +7,5 @@ Linux PCI Bus Subsystem
 .. toctree::
    :maxdepth: 2
    :numbered:
+
+   pci
diff --git a/Documentation/PCI/pci.txt b/Documentation/PCI/pci.rst
similarity index 68%
rename from Documentation/PCI/pci.txt
rename to Documentation/PCI/pci.rst
index badb26ac33dc..6864f9a70f5f 100644
--- a/Documentation/PCI/pci.txt
+++ b/Documentation/PCI/pci.rst
@@ -1,10 +1,12 @@
+.. SPDX-License-Identifier: GPL-2.0
 
-			How To Write Linux PCI Drivers
+==============================
+How To Write Linux PCI Drivers
+==============================
 
-		by Martin Mares <mj@ucw.cz> on 07-Feb-2000
-	updated by Grant Grundler <grundler@parisc-linux.org> on 23-Dec-2006
+:Authors: - Martin Mares <mj@ucw.cz>
+          - Grant Grundler <grundler@parisc-linux.org>
 
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 The world of PCI is vast and full of (mostly unpleasant) surprises.
 Since each CPU architecture implements different chip-sets and PCI devices
 have different requirements (erm, "features"), the result is the PCI support
@@ -15,8 +17,7 @@ PCI device drivers.
 A more complete resource is the third edition of "Linux Device Drivers"
 by Jonathan Corbet, Alessandro Rubini, and Greg Kroah-Hartman.
 LDD3 is available for free (under Creative Commons License) from:
-
-	http://lwn.net/Kernel/LDD3/
+http://lwn.net/Kernel/LDD3/.
 
 However, keep in mind that all documents are subject to "bit rot".
 Refer to the source code if things are not working as described here.
@@ -25,9 +26,8 @@ Please send questions/comments/patches about Linux PCI API to the
 "Linux PCI" <linux-pci@atrey.karlin.mff.cuni.cz> mailing list.
 
 
-
-0. Structure of PCI drivers
-~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Structure of PCI drivers
+========================
 PCI drivers "discover" PCI devices in a system via pci_register_driver().
 Actually, it's the other way around. When the PCI generic code discovers
 a new device, the driver with a matching "description" will be notified.
@@ -42,24 +42,25 @@ pointers and thus dictates the high level structure of a driver.
 Once the driver knows about a PCI device and takes ownership, the
 driver generally needs to perform the following initialization:
 
-	Enable the device
-	Request MMIO/IOP resources
-	Set the DMA mask size (for both coherent and streaming DMA)
-	Allocate and initialize shared control data (pci_allocate_coherent())
-	Access device configuration space (if needed)
-	Register IRQ handler (request_irq())
-	Initialize non-PCI (i.e. LAN/SCSI/etc parts of the chip)
-	Enable DMA/processing engines
+  - Enable the device
+  - Request MMIO/IOP resources
+  - Set the DMA mask size (for both coherent and streaming DMA)
+  - Allocate and initialize shared control data (pci_allocate_coherent())
+  - Access device configuration space (if needed)
+  - Register IRQ handler (request_irq())
+  - Initialize non-PCI (i.e. LAN/SCSI/etc parts of the chip)
+  - Enable DMA/processing engines
 
 When done using the device, and perhaps the module needs to be unloaded,
 the driver needs to take the follow steps:
-	Disable the device from generating IRQs
-	Release the IRQ (free_irq())
-	Stop all DMA activity
-	Release DMA buffers (both streaming and coherent)
-	Unregister from other subsystems (e.g. scsi or netdev)
-	Release MMIO/IOP resources
-	Disable the device
+
+  - Disable the device from generating IRQs
+  - Release the IRQ (free_irq())
+  - Stop all DMA activity
+  - Release DMA buffers (both streaming and coherent)
+  - Unregister from other subsystems (e.g. scsi or netdev)
+  - Release MMIO/IOP resources
+  - Disable the device
 
 Most of these topics are covered in the following sections.
 For the rest look at LDD3 or <linux/pci.h> .
@@ -70,99 +71,38 @@ completely empty or just returning an appropriate error codes to avoid
 lots of ifdefs in the drivers.
 
 
+pci_register_driver() call
+==========================
 
-1. pci_register_driver() call
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-PCI device drivers call pci_register_driver() during their
+PCI device drivers call ``pci_register_driver()`` during their
 initialization with a pointer to a structure describing the driver
-(struct pci_driver):
-
-	field name	Description
-	----------	------------------------------------------------------
-	id_table	Pointer to table of device ID's the driver is
-			interested in.  Most drivers should export this
-			table using MODULE_DEVICE_TABLE(pci,...).
-
-	probe		This probing function gets called (during execution
-			of pci_register_driver() for already existing
-			devices or later if a new device gets inserted) for
-			all PCI devices which match the ID table and are not
-			"owned" by the other drivers yet. This function gets
-			passed a "struct pci_dev *" for each device whose
-			entry in the ID table matches the device. The probe
-			function returns zero when the driver chooses to
-			take "ownership" of the device or an error code
-			(negative number) otherwise.
-			The probe function always gets called from process
-			context, so it can sleep.
-
-	remove		The remove() function gets called whenever a device
-			being handled by this driver is removed (either during
-			deregistration of the driver or when it's manually
-			pulled out of a hot-pluggable slot).
-			The remove function always gets called from process
-			context, so it can sleep.
-
-	suspend		Put device into low power state.
-	suspend_late	Put device into low power state.
-
-	resume_early	Wake device from low power state.
-	resume		Wake device from low power state.
-
-		(Please see Documentation/power/pci.txt for descriptions
-		of PCI Power Management and the related functions.)
-
-	shutdown	Hook into reboot_notifier_list (kernel/sys.c).
-			Intended to stop any idling DMA operations.
-			Useful for enabling wake-on-lan (NIC) or changing
-			the power state of a device before reboot.
-			e.g. drivers/net/e100.c.
-
-	err_handler	See Documentation/PCI/pci-error-recovery.txt
-
-
-The ID table is an array of struct pci_device_id entries ending with an
-all-zero entry.  Definitions with static const are generally preferred.
-
-Each entry consists of:
-
-	vendor,device	Vendor and device ID to match (or PCI_ANY_ID)
+(``struct pci_driver``):
 
-	subvendor,	Subsystem vendor and device ID to match (or PCI_ANY_ID)
-	subdevice,
+.. kernel-doc:: include/linux/pci.h
+   :functions: pci_driver
 
-	class		Device class, subclass, and "interface" to match.
-			See Appendix D of the PCI Local Bus Spec or
-			include/linux/pci_ids.h for a full list of classes.
-			Most drivers do not need to specify class/class_mask
-			as vendor/device is normally sufficient.
-
-	class_mask	limit which sub-fields of the class field are compared.
-			See drivers/scsi/sym53c8xx_2/ for example of usage.
-
-	driver_data	Data private to the driver.
-			Most drivers don't need to use driver_data field.
-			Best practice is to use driver_data as an index
-			into a static list of equivalent device types,
-			instead of using it as a pointer.
+The ID table is an array of ``struct pci_device_id`` entries ending with an
+all-zero entry.  Definitions with static const are generally preferred.
 
+.. kernel-doc:: include/linux/mod_devicetable.h
+   :functions: pci_device_id
 
-Most drivers only need PCI_DEVICE() or PCI_DEVICE_CLASS() to set up
+Most drivers only need ``PCI_DEVICE()`` or ``PCI_DEVICE_CLASS()`` to set up
 a pci_device_id table.
 
 New PCI IDs may be added to a device driver pci_ids table at runtime
-as shown below:
+as shown below::
 
-echo "vendor device subvendor subdevice class class_mask driver_data" > \
-/sys/bus/pci/drivers/{driver}/new_id
+  echo "vendor device subvendor subdevice class class_mask driver_data" > \
+  /sys/bus/pci/drivers/{driver}/new_id
 
 All fields are passed in as hexadecimal values (no leading 0x).
 The vendor and device fields are mandatory, the others are optional. Users
 need pass only as many optional fields as necessary:
-	o subvendor and subdevice fields default to PCI_ANY_ID (FFFFFFFF)
-	o class and classmask fields default to 0
-	o driver_data defaults to 0UL.
+
+  - subvendor and subdevice fields default to PCI_ANY_ID (FFFFFFFF)
+  - class and classmask fields default to 0
+  - driver_data defaults to 0UL.
 
 Note that driver_data must match the value used by any of the pci_device_id
 entries defined in the driver. This makes the driver_data field mandatory
@@ -175,29 +115,31 @@ When the driver exits, it just calls pci_unregister_driver() and the PCI layer
 automatically calls the remove hook for all devices handled by the driver.
 
 
-1.1 "Attributes" for driver functions/data
+"Attributes" for driver functions/data
+--------------------------------------
 
 Please mark the initialization and cleanup functions where appropriate
 (the corresponding macros are defined in <linux/init.h>):
 
+	======		=================================================
 	__init		Initialization code. Thrown away after the driver
 			initializes.
 	__exit		Exit code. Ignored for non-modular drivers.
+	======		=================================================
 
 Tips on when/where to use the above attributes:
-	o The module_init()/module_exit() functions (and all
+	- The module_init()/module_exit() functions (and all
 	  initialization functions called _only_ from these)
 	  should be marked __init/__exit.
 
-	o Do not mark the struct pci_driver.
+	- Do not mark the struct pci_driver.
 
-	o Do NOT mark a function if you are not sure which mark to use.
+	- Do NOT mark a function if you are not sure which mark to use.
 	  Better to not mark the function than mark the function wrong.
 
 
-
-2. How to find PCI devices manually
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+How to find PCI devices manually
+================================
 
 PCI drivers should have a really good reason for not using the
 pci_register_driver() interface to search for PCI devices.
@@ -207,17 +149,17 @@ E.g. combined serial/parallel port/floppy controller.
 
 A manual search may be performed using the following constructs:
 
-Searching by vendor and device ID:
+Searching by vendor and device ID::
 
 	struct pci_dev *dev = NULL;
 	while (dev = pci_get_device(VENDOR_ID, DEVICE_ID, dev))
 		configure_device(dev);
 
-Searching by class ID (iterate in a similar way):
+Searching by class ID (iterate in a similar way)::
 
 	pci_get_class(CLASS_ID, dev)
 
-Searching by both vendor/device and subsystem vendor/device ID:
+Searching by both vendor/device and subsystem vendor/device ID::
 
 	pci_get_subsys(VENDOR_ID,DEVICE_ID, SUBSYS_VENDOR_ID, SUBSYS_DEVICE_ID, dev).
 
@@ -230,21 +172,20 @@ the pci_dev that they return. You must eventually (possibly at module unload)
 decrement the reference count on these devices by calling pci_dev_put().
 
 
-
-3. Device Initialization Steps
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Device Initialization Steps
+===========================
 
 As noted in the introduction, most PCI drivers need the following steps
 for device initialization:
 
-	Enable the device
-	Request MMIO/IOP resources
-	Set the DMA mask size (for both coherent and streaming DMA)
-	Allocate and initialize shared control data (pci_allocate_coherent())
-	Access device configuration space (if needed)
-	Register IRQ handler (request_irq())
-	Initialize non-PCI (i.e. LAN/SCSI/etc parts of the chip)
-	Enable DMA/processing engines.
+  - Enable the device
+  - Request MMIO/IOP resources
+  - Set the DMA mask size (for both coherent and streaming DMA)
+  - Allocate and initialize shared control data (pci_allocate_coherent())
+  - Access device configuration space (if needed)
+  - Register IRQ handler (request_irq())
+  - Initialize non-PCI (i.e. LAN/SCSI/etc parts of the chip)
+  - Enable DMA/processing engines.
 
 The driver can access PCI config space registers at any time.
 (Well, almost. When running BIST, config space can go away...but
@@ -252,26 +193,29 @@ that will just result in a PCI Bus Master Abort and config reads
 will return garbage).
 
 
-3.1 Enable the PCI device
-~~~~~~~~~~~~~~~~~~~~~~~~~
+Enable the PCI device
+---------------------
 Before touching any device registers, the driver needs to enable
 the PCI device by calling pci_enable_device(). This will:
-	o wake up the device if it was in suspended state,
-	o allocate I/O and memory regions of the device (if BIOS did not),
-	o allocate an IRQ (if BIOS did not).
 
-NOTE: pci_enable_device() can fail! Check the return value.
+  - wake up the device if it was in suspended state,
+  - allocate I/O and memory regions of the device (if BIOS did not),
+  - allocate an IRQ (if BIOS did not).
 
-[ OS BUG: we don't check resource allocations before enabling those
-  resources. The sequence would make more sense if we called
-  pci_request_resources() before calling pci_enable_device().
-  Currently, the device drivers can't detect the bug when when two
-  devices have been allocated the same range. This is not a common
-  problem and unlikely to get fixed soon.
+.. note::
+   pci_enable_device() can fail! Check the return value.
+
+.. warning::
+   OS BUG: we don't check resource allocations before enabling those
+   resources. The sequence would make more sense if we called
+   pci_request_resources() before calling pci_enable_device().
+   Currently, the device drivers can't detect the bug when when two
+   devices have been allocated the same range. This is not a common
+   problem and unlikely to get fixed soon.
+
+   This has been discussed before but not changed as of 2.6.19:
+   http://lkml.org/lkml/2006/3/2/194
 
-  This has been discussed before but not changed as of 2.6.19:
-	http://lkml.org/lkml/2006/3/2/194
-]
 
 pci_set_master() will enable DMA by setting the bus master bit
 in the PCI_COMMAND register. It also fixes the latency timer value if
@@ -288,8 +232,8 @@ pci_try_set_mwi() to have the system do its best effort at enabling
 Mem-Wr-Inval.
 
 
-3.2 Request MMIO/IOP resources
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Request MMIO/IOP resources
+--------------------------
 Memory (MMIO), and I/O port addresses should NOT be read directly
 from the PCI device config space. Use the values in the pci_dev structure
 as the PCI "bus address" might have been remapped to a "host physical"
@@ -304,9 +248,10 @@ Conversely, drivers should call pci_release_region() AFTER
 calling pci_disable_device().
 The idea is to prevent two devices colliding on the same address range.
 
-[ See OS BUG comment above. Currently (2.6.19), The driver can only
-  determine MMIO and IO Port resource availability _after_ calling
-  pci_enable_device(). ]
+.. tip::
+   See OS BUG comment above. Currently (2.6.19), The driver can only
+   determine MMIO and IO Port resource availability _after_ calling
+   pci_enable_device().
 
 Generic flavors of pci_request_region() are request_mem_region()
 (for MMIO ranges) and request_region() (for IO Port ranges).
@@ -316,12 +261,13 @@ BARs.
 Also see pci_request_selected_regions() below.
 
 
-3.3 Set the DMA mask size
-~~~~~~~~~~~~~~~~~~~~~~~~~
-[ If anything below doesn't make sense, please refer to
-  Documentation/DMA-API.txt. This section is just a reminder that
-  drivers need to indicate DMA capabilities of the device and is not
-  an authoritative source for DMA interfaces. ]
+Set the DMA mask size
+---------------------
+.. note::
+   If anything below doesn't make sense, please refer to
+   Documentation/DMA-API.txt. This section is just a reminder that
+   drivers need to indicate DMA capabilities of the device and is not
+   an authoritative source for DMA interfaces.
 
 While all drivers should explicitly indicate the DMA capability
 (e.g. 32 or 64 bit) of the PCI bus master, devices with more than
@@ -342,23 +288,23 @@ Many 64-bit "PCI" devices (before PCI-X) and some PCI-X devices are
 ("consistent") data.
 
 
-3.4 Setup shared control data
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Setup shared control data
+-------------------------
 Once the DMA masks are set, the driver can allocate "consistent" (a.k.a. shared)
 memory.  See Documentation/DMA-API.txt for a full description of
 the DMA APIs. This section is just a reminder that it needs to be done
 before enabling DMA on the device.
 
 
-3.5 Initialize device registers
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Initialize device registers
+---------------------------
 Some drivers will need specific "capability" fields programmed
 or other "vendor specific" register initialized or reset.
 E.g. clearing pending interrupts.
 
 
-3.6 Register IRQ handler
-~~~~~~~~~~~~~~~~~~~~~~~~
+Register IRQ handler
+--------------------
 While calling request_irq() is the last step described here,
 this is often just another intermediate step to initialize a device.
 This step can often be deferred until the device is opened for use.
@@ -396,6 +342,7 @@ and msix_enabled flags in the pci_dev structure after calling
 pci_alloc_irq_vectors.
 
 There are (at least) two really good reasons for using MSI:
+
 1) MSI is an exclusive interrupt vector by definition.
    This means the interrupt handler doesn't have to verify
    its device caused the interrupt.
@@ -410,24 +357,23 @@ See drivers/infiniband/hw/mthca/ or drivers/net/tg3.c for examples
 of MSI/MSI-X usage.
 
 
-
-4. PCI device shutdown
-~~~~~~~~~~~~~~~~~~~~~~~
+PCI device shutdown
+===================
 
 When a PCI device driver is being unloaded, most of the following
 steps need to be performed:
 
-	Disable the device from generating IRQs
-	Release the IRQ (free_irq())
-	Stop all DMA activity
-	Release DMA buffers (both streaming and consistent)
-	Unregister from other subsystems (e.g. scsi or netdev)
-	Disable device from responding to MMIO/IO Port addresses
-	Release MMIO/IO Port resource(s)
+  - Disable the device from generating IRQs
+  - Release the IRQ (free_irq())
+  - Stop all DMA activity
+  - Release DMA buffers (both streaming and consistent)
+  - Unregister from other subsystems (e.g. scsi or netdev)
+  - Disable device from responding to MMIO/IO Port addresses
+  - Release MMIO/IO Port resource(s)
 
 
-4.1 Stop IRQs on the device
-~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Stop IRQs on the device
+-----------------------
 How to do this is chip/device specific. If it's not done, it opens
 the possibility of a "screaming interrupt" if (and only if)
 the IRQ is shared with another device.
@@ -446,16 +392,16 @@ MSI and MSI-X are defined to be exclusive interrupts and thus
 are not susceptible to the "screaming interrupt" problem.
 
 
-4.2 Release the IRQ
-~~~~~~~~~~~~~~~~~~~
+Release the IRQ
+---------------
 Once the device is quiesced (no more IRQs), one can call free_irq().
 This function will return control once any pending IRQs are handled,
 "unhook" the drivers IRQ handler from that IRQ, and finally release
 the IRQ if no one else is using it.
 
 
-4.3 Stop all DMA activity
-~~~~~~~~~~~~~~~~~~~~~~~~~
+Stop all DMA activity
+---------------------
 It's extremely important to stop all DMA operations BEFORE attempting
 to deallocate DMA control data. Failure to do so can result in memory
 corruption, hangs, and on some chip-sets a hard crash.
@@ -467,8 +413,8 @@ While this step sounds obvious and trivial, several "mature" drivers
 didn't get this step right in the past.
 
 
-4.4 Release DMA buffers
-~~~~~~~~~~~~~~~~~~~~~~~
+Release DMA buffers
+-------------------
 Once DMA is stopped, clean up streaming DMA first.
 I.e. unmap data buffers and return buffers to "upstream"
 owners if there is one.
@@ -478,8 +424,8 @@ Then clean up "consistent" buffers which contain the control data.
 See Documentation/DMA-API.txt for details on unmapping interfaces.
 
 
-4.5 Unregister from other subsystems
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Unregister from other subsystems
+--------------------------------
 Most low level PCI device drivers support some other subsystem
 like USB, ALSA, SCSI, NetDev, Infiniband, etc. Make sure your
 driver isn't losing resources from that other subsystem.
@@ -487,31 +433,30 @@ If this happens, typically the symptom is an Oops (panic) when
 the subsystem attempts to call into a driver that has been unloaded.
 
 
-4.6 Disable Device from responding to MMIO/IO Port addresses
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Disable Device from responding to MMIO/IO Port addresses
+--------------------------------------------------------
 io_unmap() MMIO or IO Port resources and then call pci_disable_device().
 This is the symmetric opposite of pci_enable_device().
 Do not access device registers after calling pci_disable_device().
 
 
-4.7 Release MMIO/IO Port Resource(s)
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Release MMIO/IO Port Resource(s)
+--------------------------------
 Call pci_release_region() to mark the MMIO or IO Port range as available.
 Failure to do so usually results in the inability to reload the driver.
 
 
+How to access PCI config space
+==============================
 
-5. How to access PCI config space
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-You can use pci_(read|write)_config_(byte|word|dword) to access the config
-space of a device represented by struct pci_dev *. All these functions return 0
-when successful or an error code (PCIBIOS_...) which can be translated to a text
-string by pcibios_strerror. Most drivers expect that accesses to valid PCI
+You can use `pci_(read|write)_config_(byte|word|dword)` to access the config
+space of a device represented by `struct pci_dev *`. All these functions return
+0 when successful or an error code (`PCIBIOS_...`) which can be translated to a
+text string by pcibios_strerror. Most drivers expect that accesses to valid PCI
 devices don't fail.
 
 If you don't have a struct pci_dev available, you can call
-pci_bus_(read|write)_config_(byte|word|dword) to access a given device
+`pci_bus_(read|write)_config_(byte|word|dword)` to access a given device
 and function on that bus.
 
 If you access fields in the standard portion of the config header, please
@@ -522,10 +467,10 @@ pci_find_capability() for the particular capability and it will find the
 corresponding register block for you.
 
 
+Other interesting functions
+===========================
 
-6. Other interesting functions
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
+=============================	================================================
 pci_get_domain_bus_and_slot()	Find pci_dev corresponding to given domain,
 				bus and slot and number. If the device is
 				found, its reference count is increased.
@@ -539,11 +484,11 @@ pci_set_drvdata()		Set private driver data pointer for a pci_dev
 pci_get_drvdata()		Return private driver data pointer for a pci_dev
 pci_set_mwi()			Enable Memory-Write-Invalidate transactions.
 pci_clear_mwi()			Disable Memory-Write-Invalidate transactions.
+=============================	================================================
 
 
-
-7. Miscellaneous hints
-~~~~~~~~~~~~~~~~~~~~~~
+Miscellaneous hints
+===================
 
 When displaying PCI device names to the user (for example when a driver wants
 to tell the user what card has it found), please use pci_name(pci_dev).
@@ -559,9 +504,8 @@ on the bus need to be capable of doing it, so this is something which needs
 to be handled by platform and generic code, not individual drivers.
 
 
-
-8. Vendor and device identifications
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Vendor and device identifications
+=================================
 
 Do not add new device or vendor IDs to include/linux/pci_ids.h unless they
 are shared across multiple drivers.  You can add private definitions in
@@ -575,28 +519,27 @@ There are mirrors of the pci.ids file at http://pciids.sourceforge.net/
 and https://github.com/pciutils/pciids.
 
 
-
-9. Obsolete functions
-~~~~~~~~~~~~~~~~~~~~~
+Obsolete functions
+==================
 
 There are several functions which you might come across when trying to
 port an old driver to the new PCI interface.  They are no longer present
 in the kernel as they aren't compatible with hotplug or PCI domains or
 having sane locking.
 
+=================	===========================================
 pci_find_device()	Superseded by pci_get_device()
 pci_find_subsys()	Superseded by pci_get_subsys()
 pci_find_slot()		Superseded by pci_get_domain_bus_and_slot()
 pci_get_slot()		Superseded by pci_get_domain_bus_and_slot()
-
+=================	===========================================
 
 The alternative is the traditional PCI device driver that walks PCI
 device lists. This is still possible but discouraged.
 
 
-
-10. MMIO Space and "Write Posting"
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+MMIO Space and "Write Posting"
+==============================
 
 Converting a driver from using I/O Port space to using MMIO space
 often requires some additional changes. Specifically, "write posting"
@@ -609,14 +552,14 @@ the CPU before the transaction has reached its destination.
 
 Thus, timing sensitive code should add readl() where the CPU is
 expected to wait before doing other work.  The classic "bit banging"
-sequence works fine for I/O Port space:
+sequence works fine for I/O Port space::
 
        for (i = 8; --i; val >>= 1) {
                outb(val & 1, ioport_reg);      /* write bit */
                udelay(10);
        }
 
-The same sequence for MMIO space should be:
+The same sequence for MMIO space should be::
 
        for (i = 8; --i; val >>= 1) {
                writeb(val & 1, mmio_reg);      /* write bit */
@@ -633,4 +576,3 @@ handle the PCI master abort on all platforms if the PCI device is
 expected to not respond to a readl().  Most x86 platforms will allow
 MMIO reads to master abort (a.k.a. "Soft Fail") and return garbage
 (e.g. ~0). But many RISC platforms will crash (a.k.a."Hard Fail").
-
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 448621c32e4d..c058e5366f06 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -16,6 +16,25 @@ typedef unsigned long kernel_ulong_t;
 
 #define PCI_ANY_ID (~0)
 
+/**
+ * struct pci_device_id - PCI device ID structure
+ * @vendor：		Vendor ID to match (or PCI_ANY_ID)
+ * @device:		Device ID to match (or PCI_ANY_ID)
+ * @subvendor:		Subsystem vendor ID to match (or PCI_ANY_ID)
+ * @subdevice:		Subsystem device ID to match (or PCI_ANY_ID)
+ * @class:		Device class, subclass, and "interface" to match.
+ *			See Appendix D of the PCI Local Bus Spec or
+ *			include/linux/pci_ids.h for a full list of classes.
+ *			Most drivers do not need to specify class/class_mask
+ *			as vendor/device is normally sufficient.
+ * @class_mask:		limit which sub-fields of the class field are compared.
+ *			See drivers/scsi/sym53c8xx_2/ for example of usage.
+ * @driver_data:	Data private to the driver.
+ *			Most drivers don't need to use driver_data field.
+ *			Best practice is to use driver_data as an index
+ *			into a static list of equivalent device types,
+ *			instead of using it as a pointer.
+ */
 struct pci_device_id {
 	__u32 vendor, device;		/* Vendor and device ID or PCI_ANY_ID*/
 	__u32 subvendor, subdevice;	/* Subsystem ID's or PCI_ANY_ID */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 27854731afc4..2b3c3572d1c7 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -767,6 +767,43 @@ struct pci_error_handlers {
 
 
 struct module;
+
+/**
+ * struct pci_driver - PCI driver structure
+ * @id_table:	Pointer to table of device ID's the driver is
+ *		interested in.  Most drivers should export this
+ *		table using MODULE_DEVICE_TABLE(pci,...).
+ * @probe:	This probing function gets called (during execution
+ *		of pci_register_driver() for already existing
+ *		devices or later if a new device gets inserted) for
+ *		all PCI devices which match the ID table and are not
+ *		"owned" by the other drivers yet. This function gets
+ *		passed a "struct pci_dev *" for each device whose
+ *		entry in the ID table matches the device. The probe
+ *		function returns zero when the driver chooses to
+ *		take "ownership" of the device or an error code
+ *		(negative number) otherwise.
+ *		The probe function always gets called from process
+ *		context, so it can sleep.
+ * @remove:	The remove() function gets called whenever a device
+ *		being handled by this driver is removed (either during
+ *		deregistration of the driver or when it's manually
+ *		pulled out of a hot-pluggable slot).
+ *		The remove function always gets called from process
+ *		context, so it can sleep.
+ * @suspend:	Put device into low power state.
+ * @suspend_late: Put device into low power state.
+ * @resume_early: Wake device from low power state.
+ * @resume:	Wake device from low power state.
+ *		(Please see Documentation/power/pci.txt for descriptions
+ *		of PCI Power Management and the related functions.)
+ * @shutdown:	Hook into reboot_notifier_list (kernel/sys.c).
+ *		Intended to stop any idling DMA operations.
+ *		Useful for enabling wake-on-lan (NIC) or changing
+ *		the power state of a device before reboot.
+ *		e.g. drivers/net/e100.c.
+ * @err_handler: See Documentation/PCI/pci-error-recovery.rst
+ */
 struct pci_driver {
 	struct list_head	node;
 	const char		*name;
-- 
2.20.1

