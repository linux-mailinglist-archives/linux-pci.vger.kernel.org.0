Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6501AC2F
	for <lists+linux-pci@lfdr.de>; Sun, 12 May 2019 14:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfELMvG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 12 May 2019 08:51:06 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44312 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfELMvG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 12 May 2019 08:51:06 -0400
Received: by mail-pl1-f193.google.com with SMTP id d3so5026106plj.11;
        Sun, 12 May 2019 05:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wHpKh9yZv40w8cL9famlaYd8tdLmsvVuNyVSl3VwE34=;
        b=e0y2ReiIz0PO3tdHDa+/AstCBw+lIfDnaOOcx8w9u454srBpCJiTMcJa/kMTLrSn3U
         dyIy2QBYzqVy32u+lO+8PIiE8G0dHB0hTnx3ljwYIagqKIr59WwjLmMze2Ut7T0SvuoZ
         hs16yE5XmJu0Rz/gyvv77x9/Lr2jTcJkk91QeKAPVTBvVUmFC2306EckxsMttjcFeUF9
         lbwT3uWWcymhMDF6VCsSPl+eHe9AYgs9L2moWLI0HDi+C+FkXQhxgM1hAYSqyE++eRoy
         kU1kKsqz1i5GkuHyDRqZQvaxJXxRjtV6rUBvyJBwABu+BQZy3gZCx5Iv4G1p/c5TvZIe
         Nhzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wHpKh9yZv40w8cL9famlaYd8tdLmsvVuNyVSl3VwE34=;
        b=GbpKPEql3UpkmmnmjsKrmZf6wKZD5tiWGG++uESDix3dBnbgXeat2BXPhWMDwgQ+Fw
         2jm3idIWnKhBXQQqk7j572qIDySt+ExBfCArV0Trcmfa0tGgvIbLVFObWa5IouvUVVs8
         9pMv+C7Wjcy3k5jqv6QiFDkZ3SHUbGzPpSKAT4Gwms7JmPSPZfpSqVOxGwM+2tSbQwZQ
         bSOwjBcLzUFc0MUB8wqt+SXBVwjaDk/4O5H9fTnMzuzcVwRHcrHx9acx3XSubEF6/hYj
         tAP6TvNbCyOSefFtxWZE3kghkdMgeAJU5CTXE4z+tuBWRr6GkCHAREVA5GzUsfBny3Ea
         oLCQ==
X-Gm-Message-State: APjAAAX6mY6//VPokNeNUEB7aAB3nULkVIp6pek3PaHkyIA8Jt339cnX
        Kl8bLuHjGKIVcayRWLV5qr/4bmSW
X-Google-Smtp-Source: APXvYqyr80ubo7FVbbURSTiYd0hxX/o47fsFgrKnxys/7OPXiXw+XGg02q1f7QYy1hSpWTX3WDx8hA==
X-Received: by 2002:a17:902:7047:: with SMTP id h7mr25535464plt.177.1557665465118;
        Sun, 12 May 2019 05:51:05 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id n2sm146426pgp.27.2019.05.12.05.51.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 12 May 2019 05:51:04 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     bhelgaas@google.com, corbet@lwn.net
Cc:     linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v4 07/12] Documentation: PCI: convert pci-error-recovery.txt to reST
Date:   Sun, 12 May 2019 20:50:04 +0800
Message-Id: <20190512125009.32079-8-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190512125009.32079-1-changbin.du@gmail.com>
References: <20190512125009.32079-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This converts the plain text documentation to reStructuredText format and
add it to Sphinx TOC tree. No essential content change.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/PCI/index.rst                   |   1 +
 ...or-recovery.txt => pci-error-recovery.rst} | 287 +++++++++---------
 MAINTAINERS                                   |   2 +-
 3 files changed, 151 insertions(+), 139 deletions(-)
 rename Documentation/PCI/{pci-error-recovery.txt => pci-error-recovery.rst} (67%)

diff --git a/Documentation/PCI/index.rst b/Documentation/PCI/index.rst
index 6f573f3df993..92e62d0fc9e6 100644
--- a/Documentation/PCI/index.rst
+++ b/Documentation/PCI/index.rst
@@ -13,3 +13,4 @@ Linux PCI Bus Subsystem
    pci-iov-howto
    msi-howto
    acpi-info
+   pci-error-recovery
diff --git a/Documentation/PCI/pci-error-recovery.txt b/Documentation/PCI/pci-error-recovery.rst
similarity index 67%
rename from Documentation/PCI/pci-error-recovery.txt
rename to Documentation/PCI/pci-error-recovery.rst
index 0b6bb3ef449e..83db42092935 100644
--- a/Documentation/PCI/pci-error-recovery.txt
+++ b/Documentation/PCI/pci-error-recovery.rst
@@ -1,12 +1,13 @@
+.. SPDX-License-Identifier: GPL-2.0
 
-                       PCI Error Recovery
-                       ------------------
-                        February 2, 2006
+==================
+PCI Error Recovery
+==================
 
-                 Current document maintainer:
-             Linas Vepstas <linasvepstas@gmail.com>
-          updated by Richard Lary <rlary@us.ibm.com>
-       and Mike Mason <mmlnx@us.ibm.com> on 27-Jul-2009
+
+:Authors: - Linas Vepstas <linasvepstas@gmail.com>
+          - Richard Lary <rlary@us.ibm.com>
+          - Mike Mason <mmlnx@us.ibm.com>
 
 
 Many PCI bus controllers are able to detect a variety of hardware
@@ -63,7 +64,8 @@ mechanisms for dealing with SCSI bus errors and SCSI bus resets.
 
 
 Detailed Design
----------------
+===============
+
 Design and implementation details below, based on a chain of
 public email discussions with Ben Herrenschmidt, circa 5 April 2005.
 
@@ -73,30 +75,33 @@ pci_driver. A driver that fails to provide the structure is "non-aware",
 and the actual recovery steps taken are platform dependent.  The
 arch/powerpc implementation will simulate a PCI hotplug remove/add.
 
-This structure has the form:
-struct pci_error_handlers
-{
-	int (*error_detected)(struct pci_dev *dev, enum pci_channel_state);
-	int (*mmio_enabled)(struct pci_dev *dev);
-	int (*slot_reset)(struct pci_dev *dev);
-	void (*resume)(struct pci_dev *dev);
-};
-
-The possible channel states are:
-enum pci_channel_state {
-	pci_channel_io_normal,  /* I/O channel is in normal state */
-	pci_channel_io_frozen,  /* I/O to channel is blocked */
-	pci_channel_io_perm_failure, /* PCI card is dead */
-};
-
-Possible return values are:
-enum pci_ers_result {
-	PCI_ERS_RESULT_NONE,        /* no result/none/not supported in device driver */
-	PCI_ERS_RESULT_CAN_RECOVER, /* Device driver can recover without slot reset */
-	PCI_ERS_RESULT_NEED_RESET,  /* Device driver wants slot to be reset. */
-	PCI_ERS_RESULT_DISCONNECT,  /* Device has completely failed, is unrecoverable */
-	PCI_ERS_RESULT_RECOVERED,   /* Device driver is fully recovered and operational */
-};
+This structure has the form::
+
+	struct pci_error_handlers
+	{
+		int (*error_detected)(struct pci_dev *dev, enum pci_channel_state);
+		int (*mmio_enabled)(struct pci_dev *dev);
+		int (*slot_reset)(struct pci_dev *dev);
+		void (*resume)(struct pci_dev *dev);
+	};
+
+The possible channel states are::
+
+	enum pci_channel_state {
+		pci_channel_io_normal,  /* I/O channel is in normal state */
+		pci_channel_io_frozen,  /* I/O to channel is blocked */
+		pci_channel_io_perm_failure, /* PCI card is dead */
+	};
+
+Possible return values are::
+
+	enum pci_ers_result {
+		PCI_ERS_RESULT_NONE,        /* no result/none/not supported in device driver */
+		PCI_ERS_RESULT_CAN_RECOVER, /* Device driver can recover without slot reset */
+		PCI_ERS_RESULT_NEED_RESET,  /* Device driver wants slot to be reset. */
+		PCI_ERS_RESULT_DISCONNECT,  /* Device has completely failed, is unrecoverable */
+		PCI_ERS_RESULT_RECOVERED,   /* Device driver is fully recovered and operational */
+	};
 
 A driver does not have to implement all of these callbacks; however,
 if it implements any, it must implement error_detected(). If a callback
@@ -134,16 +139,17 @@ shouldn't do any new IOs. Called in task context. This is sort of a
 
 All drivers participating in this system must implement this call.
 The driver must return one of the following result codes:
-		- PCI_ERS_RESULT_CAN_RECOVER:
-		  Driver returns this if it thinks it might be able to recover
-		  the HW by just banging IOs or if it wants to be given
-		  a chance to extract some diagnostic information (see
-		  mmio_enable, below).
-		- PCI_ERS_RESULT_NEED_RESET:
-		  Driver returns this if it can't recover without a
-		  slot reset.
-		- PCI_ERS_RESULT_DISCONNECT:
-		  Driver returns this if it doesn't want to recover at all.
+
+  - PCI_ERS_RESULT_CAN_RECOVER
+      Driver returns this if it thinks it might be able to recover
+      the HW by just banging IOs or if it wants to be given
+      a chance to extract some diagnostic information (see
+      mmio_enable, below).
+  - PCI_ERS_RESULT_NEED_RESET
+      Driver returns this if it can't recover without a
+      slot reset.
+  - PCI_ERS_RESULT_DISCONNECT
+      Driver returns this if it doesn't want to recover at all.
 
 The next step taken will depend on the result codes returned by the
 drivers.
@@ -159,25 +165,27 @@ then recovery proceeds to STEP 4 (Slot Reset).
 If the platform is unable to recover the slot, the next step
 is STEP 6 (Permanent Failure).
 
->>> The current powerpc implementation assumes that a device driver will
->>> *not* schedule or semaphore in this routine; the current powerpc
->>> implementation uses one kernel thread to notify all devices;
->>> thus, if one device sleeps/schedules, all devices are affected.
->>> Doing better requires complex multi-threaded logic in the error
->>> recovery implementation (e.g. waiting for all notification threads
->>> to "join" before proceeding with recovery.)  This seems excessively
->>> complex and not worth implementing.
-
->>> The current powerpc implementation doesn't much care if the device
->>> attempts I/O at this point, or not.  I/O's will fail, returning
->>> a value of 0xff on read, and writes will be dropped. If more than
->>> EEH_MAX_FAILS I/O's are attempted to a frozen adapter, EEH
->>> assumes that the device driver has gone into an infinite loop
->>> and prints an error to syslog.  A reboot is then required to
->>> get the device working again.
+.. note::
+
+   The current powerpc implementation assumes that a device driver will
+   *not* schedule or semaphore in this routine; the current powerpc
+   implementation uses one kernel thread to notify all devices;
+   thus, if one device sleeps/schedules, all devices are affected.
+   Doing better requires complex multi-threaded logic in the error
+   recovery implementation (e.g. waiting for all notification threads
+   to "join" before proceeding with recovery.)  This seems excessively
+   complex and not worth implementing.
+
+   The current powerpc implementation doesn't much care if the device
+   attempts I/O at this point, or not.  I/O's will fail, returning
+   a value of 0xff on read, and writes will be dropped. If more than
+   EEH_MAX_FAILS I/O's are attempted to a frozen adapter, EEH
+   assumes that the device driver has gone into an infinite loop
+   and prints an error to syslog.  A reboot is then required to
+   get the device working again.
 
 STEP 2: MMIO Enabled
--------------------
+--------------------
 The platform re-enables MMIO to the device (but typically not the
 DMA), and then calls the mmio_enabled() callback on all affected
 device drivers.
@@ -192,34 +200,36 @@ link reset was performed by the HW. If the platform can't just re-enable IOs
 without a slot reset or a link reset, it will not call this callback, and
 instead will have gone directly to STEP 3 (Link Reset) or STEP 4 (Slot Reset)
 
->>> The following is proposed; no platform implements this yet:
->>> Proposal: All I/O's should be done _synchronously_ from within
->>> this callback, errors triggered by them will be returned via
->>> the normal pci_check_whatever() API, no new error_detected()
->>> callback will be issued due to an error happening here. However,
->>> such an error might cause IOs to be re-blocked for the whole
->>> segment, and thus invalidate the recovery that other devices
->>> on the same segment might have done, forcing the whole segment
->>> into one of the next states, that is, link reset or slot reset.
+.. note::
+
+   The following is proposed; no platform implements this yet:
+   Proposal: All I/O's should be done _synchronously_ from within
+   this callback, errors triggered by them will be returned via
+   the normal pci_check_whatever() API, no new error_detected()
+   callback will be issued due to an error happening here. However,
+   such an error might cause IOs to be re-blocked for the whole
+   segment, and thus invalidate the recovery that other devices
+   on the same segment might have done, forcing the whole segment
+   into one of the next states, that is, link reset or slot reset.
 
 The driver should return one of the following result codes:
-		- PCI_ERS_RESULT_RECOVERED
-		  Driver returns this if it thinks the device is fully
-		  functional and thinks it is ready to start
-		  normal driver operations again. There is no
-		  guarantee that the driver will actually be
-		  allowed to proceed, as another driver on the
-		  same segment might have failed and thus triggered a
-		  slot reset on platforms that support it.
-
-		- PCI_ERS_RESULT_NEED_RESET
-		  Driver returns this if it thinks the device is not
-		  recoverable in its current state and it needs a slot
-		  reset to proceed.
-
-		- PCI_ERS_RESULT_DISCONNECT
-		  Same as above. Total failure, no recovery even after
-		  reset driver dead. (To be defined more precisely)
+  - PCI_ERS_RESULT_RECOVERED
+      Driver returns this if it thinks the device is fully
+      functional and thinks it is ready to start
+      normal driver operations again. There is no
+      guarantee that the driver will actually be
+      allowed to proceed, as another driver on the
+      same segment might have failed and thus triggered a
+      slot reset on platforms that support it.
+
+  - PCI_ERS_RESULT_NEED_RESET
+      Driver returns this if it thinks the device is not
+      recoverable in its current state and it needs a slot
+      reset to proceed.
+
+  - PCI_ERS_RESULT_DISCONNECT
+      Same as above. Total failure, no recovery even after
+      reset driver dead. (To be defined more precisely)
 
 The next step taken depends on the results returned by the drivers.
 If all drivers returned PCI_ERS_RESULT_RECOVERED, then the platform
@@ -293,31 +303,33 @@ device will be considered "dead" in this case.
 Drivers for multi-function cards will need to coordinate among
 themselves as to which driver instance will perform any "one-shot"
 or global device initialization. For example, the Symbios sym53cxx2
-driver performs device init only from PCI function 0:
+driver performs device init only from PCI function 0::
 
-+       if (PCI_FUNC(pdev->devfn) == 0)
-+               sym_reset_scsi_bus(np, 0);
+	+       if (PCI_FUNC(pdev->devfn) == 0)
+	+               sym_reset_scsi_bus(np, 0);
 
-	Result codes:
-		- PCI_ERS_RESULT_DISCONNECT
-		Same as above.
+Result codes:
+	- PCI_ERS_RESULT_DISCONNECT
+	  Same as above.
 
 Drivers for PCI Express cards that require a fundamental reset must
 set the needs_freset bit in the pci_dev structure in their probe function.
 For example, the QLogic qla2xxx driver sets the needs_freset bit for certain
-PCI card types:
+PCI card types::
 
-+	/* Set EEH reset type to fundamental if required by hba  */
-+	if (IS_QLA24XX(ha) || IS_QLA25XX(ha) || IS_QLA81XX(ha))
-+		pdev->needs_freset = 1;
-+
+	+	/* Set EEH reset type to fundamental if required by hba  */
+	+	if (IS_QLA24XX(ha) || IS_QLA25XX(ha) || IS_QLA81XX(ha))
+	+		pdev->needs_freset = 1;
+	+
 
 Platform proceeds either to STEP 5 (Resume Operations) or STEP 6 (Permanent
 Failure).
 
->>> The current powerpc implementation does not try a power-cycle
->>> reset if the driver returned PCI_ERS_RESULT_DISCONNECT.
->>> However, it probably should.
+.. note::
+
+   The current powerpc implementation does not try a power-cycle
+   reset if the driver returned PCI_ERS_RESULT_DISCONNECT.
+   However, it probably should.
 
 
 STEP 5: Resume Operations
@@ -370,44 +382,43 @@ The current policy is to turn this into a platform policy.
 That is, the recovery API only requires that:
 
  - There is no guarantee that interrupt delivery can proceed from any
-device on the segment starting from the error detection and until the
-slot_reset callback is called, at which point interrupts are expected
-to be fully operational.
+   device on the segment starting from the error detection and until the
+   slot_reset callback is called, at which point interrupts are expected
+   to be fully operational.
 
  - There is no guarantee that interrupt delivery is stopped, that is,
-a driver that gets an interrupt after detecting an error, or that detects
-an error within the interrupt handler such that it prevents proper
-ack'ing of the interrupt (and thus removal of the source) should just
-return IRQ_NOTHANDLED. It's up to the platform to deal with that
-condition, typically by masking the IRQ source during the duration of
-the error handling. It is expected that the platform "knows" which
-interrupts are routed to error-management capable slots and can deal
-with temporarily disabling that IRQ number during error processing (this
-isn't terribly complex). That means some IRQ latency for other devices
-sharing the interrupt, but there is simply no other way. High end
-platforms aren't supposed to share interrupts between many devices
-anyway :)
-
->>> Implementation details for the powerpc platform are discussed in
->>> the file Documentation/powerpc/eeh-pci-error-recovery.txt
-
->>> As of this writing, there is a growing list of device drivers with
->>> patches implementing error recovery. Not all of these patches are in
->>> mainline yet. These may be used as "examples":
->>>
->>> drivers/scsi/ipr
->>> drivers/scsi/sym53c8xx_2
->>> drivers/scsi/qla2xxx
->>> drivers/scsi/lpfc
->>> drivers/next/bnx2.c
->>> drivers/next/e100.c
->>> drivers/net/e1000
->>> drivers/net/e1000e
->>> drivers/net/ixgb
->>> drivers/net/ixgbe
->>> drivers/net/cxgb3
->>> drivers/net/s2io.c
->>> drivers/net/qlge
-
-The End
--------
+   a driver that gets an interrupt after detecting an error, or that detects
+   an error within the interrupt handler such that it prevents proper
+   ack'ing of the interrupt (and thus removal of the source) should just
+   return IRQ_NOTHANDLED. It's up to the platform to deal with that
+   condition, typically by masking the IRQ source during the duration of
+   the error handling. It is expected that the platform "knows" which
+   interrupts are routed to error-management capable slots and can deal
+   with temporarily disabling that IRQ number during error processing (this
+   isn't terribly complex). That means some IRQ latency for other devices
+   sharing the interrupt, but there is simply no other way. High end
+   platforms aren't supposed to share interrupts between many devices
+   anyway :)
+
+.. note::
+
+   Implementation details for the powerpc platform are discussed in
+   the file Documentation/powerpc/eeh-pci-error-recovery.txt
+
+   As of this writing, there is a growing list of device drivers with
+   patches implementing error recovery. Not all of these patches are in
+   mainline yet. These may be used as "examples":
+
+   - drivers/scsi/ipr
+   - drivers/scsi/sym53c8xx_2
+   - drivers/scsi/qla2xxx
+   - drivers/scsi/lpfc
+   - drivers/next/bnx2.c
+   - drivers/next/e100.c
+   - drivers/net/e1000
+   - drivers/net/e1000e
+   - drivers/net/ixgb
+   - drivers/net/ixgbe
+   - drivers/net/cxgb3
+   - drivers/net/s2io.c
+   - drivers/net/qlge
diff --git a/MAINTAINERS b/MAINTAINERS
index 3c65228e93c5..9b965d5b8efa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12100,7 +12100,7 @@ M:	Sam Bobroff <sbobroff@linux.ibm.com>
 M:	Oliver O'Halloran <oohall@gmail.com>
 L:	linuxppc-dev@lists.ozlabs.org
 S:	Supported
-F:	Documentation/PCI/pci-error-recovery.txt
+F:	Documentation/PCI/pci-error-recovery.rst
 F:	drivers/pci/pcie/aer.c
 F:	drivers/pci/pcie/dpc.c
 F:	drivers/pci/pcie/err.c
-- 
2.20.1

