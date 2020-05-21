Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 045261DD47B
	for <lists+linux-pci@lfdr.de>; Thu, 21 May 2020 19:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbgEURcv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 May 2020 13:32:51 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2242 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728177AbgEURcv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 May 2020 13:32:51 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id DCDC94BBC3553348FF67;
        Thu, 21 May 2020 18:32:46 +0100 (IST)
Received: from lhrphicprd00229.huawei.com (10.123.41.22) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 21 May 2020 18:32:46 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC:     <linux-acpi@vger.kernel.org>, <linuxarm@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 2/2] PCI/AER: Add partial initial support for RCiEPs using RCEC or firmware first
Date:   Fri, 22 May 2020 01:31:34 +0800
Message-ID: <20200521173134.2456773-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20200521173134.2456773-1-Jonathan.Cameron@huawei.com>
References: <20200521173134.2456773-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.123.41.22]
X-ClientProxiedBy: lhreml737-chm.china.huawei.com (10.201.108.187) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Note this provides complete support for our usecase on an ARM server using
Hardware Reduced ACPI and adds appropriate place for an RCEC driver to hook
if someone else cares to write one, either for firmware first handling on
non Hardware Reduced ACPI or for kernel first AER handling.

For Root Complex integrated End Points (RCiEPs) there is no root port to
discover and hence we cannot walk the bus from the root port to do
appropriate resets.

The PCI specification provides Root Complex Event Collectors to deal with
this circumstance.  These are peer RCiEPs that provide (amongst other
things) collection + interrupt facilities for AER reporting for a set of
RCiEPs in the same root complex.

In the case of a Hardware Reduced ACPI platform, the AER errors are
reported via a GHESv2 path using CPER records as defined in the UEFI
specification.  These are intended to provide complete information and
appropriate hand shake in a fashion that does not require a specific form
of error reporting hardware.  This is contrast to AER handling via the
various HEST entries for PCI Root Port and PCI Device etc where we do
require direct access to the RCEC.

As such my interpretation of the spec is that a Reduced Hardware ACPI
platform should not access the RCEC from the OS at all during AER handling,
and in fact is welcome to use non standard hardware interfaces to provide
the equivalent functionality in any fashion it wishes (as all hidden beind
the firmware).

Hence I am making the provision of an RCEC optional.

The aim of the rest of the code was to replicate the actions that would
have occurred if this had been an EP below a root port. Some of them make
absolutely no sense, but I hope this RFC can start a discussion on what
we should be doing under these circumstances.

It probably makes sense to pull this new block of code out to a separate
function but for the RFC I've left it in place to keep it next to the
existing path.

It appears that the current kernel first code does not support detecting
the multiple error bits being set in the root port error status register.
This seems like a limitation both the normal EP / Root Port case and
for RCiEPs.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/pci/pcie/err.c | 61 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h    |  1 +
 2 files changed, 62 insertions(+)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 14bb8f54723e..d34be4483f73 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -153,6 +153,67 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
 	struct pci_bus *bus;
 
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END) {
+		struct pci_dev *rcec = dev->rcec;
+		/* Not clear this makes any sense - we can't reset link anyway...*/
+		if (state == pci_channel_io_frozen) {
+			report_frozen_detected(dev, &status);
+			pci_err(dev, "io is frozen and cannot reset link\n");
+			goto failed;
+		} else {
+			report_normal_detected(dev, &status);
+		}
+
+		if (status == PCI_ERS_RESULT_CAN_RECOVER) {
+			status = PCI_ERS_RESULT_RECOVERED;
+			pci_dbg(dev, "broadcast mmio_enabled message\n");
+			report_mmio_enabled(dev, &status);
+		}
+
+		if (status == PCI_ERS_RESULT_NEED_RESET) {
+			/* No actual slot reset possible */
+			status = PCI_ERS_RESULT_RECOVERED;
+			pci_dbg(dev, "broadcast slot_reset message\n");
+			report_slot_reset(dev, &status);
+		}
+
+		if (status != PCI_ERS_RESULT_RECOVERED)
+			goto failed;
+
+		report_resume(dev, &status);
+
+		/*
+		 * These two should be called on the RCEC  - but in case
+		 * of firmware first they should be no-ops. Given that
+		 * in a reduced hardware ACPI system, it is possible there
+		 * is no standard compliant RCEC at all.
+		 *
+		 * Add some sort of check on what type of HEST entries we have?
+		 */
+		if (rcec) {
+			/*
+			 * Unlike the upstream port case for an EP, we have not
+			 * issued a reset on all device the RCEC handles, so
+			 * perhaps we should be more careful about resetting
+			 * the status registers on the RCEC?
+			 *
+			 * In particular we may need provide a means to handle
+			 * the multiple error bits being set in PCI_ERR_ROOT_STATUS
+			 */
+			pci_aer_clear_device_status(rcec);
+			pci_aer_clear_nonfatal_status(rcec);
+			/*
+			 * Non RCiEP case uses the downstream port above the device
+			 * for this message.
+			 */
+			pci_info(rcec, "device recovery successful\n");
+		} else {
+			pci_info(dev, "device recovery successful\n");
+		}
+
+		return status;
+	}
+
 	/*
 	 * Error recovery runs on all subordinates of the first downstream port.
 	 * If the downstream port detected the error, it is cleared at the end.
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 83ce1cdf5676..cb21dfe05f8c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -298,6 +298,7 @@ struct pci_dev {
 	struct list_head bus_list;	/* Node in per-bus list */
 	struct pci_bus	*bus;		/* Bus this device is on */
 	struct pci_bus	*subordinate;	/* Bus this device bridges to */
+	struct pci_dev	*rcec;		/* Root Complex Event Collector used */
 
 	void		*sysdata;	/* Hook for sys-specific extension */
 	struct proc_dir_entry *procent;	/* Device entry in /proc/bus/pci */
-- 
2.19.1

