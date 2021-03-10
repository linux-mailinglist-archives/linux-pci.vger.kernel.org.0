Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6FC334646
	for <lists+linux-pci@lfdr.de>; Wed, 10 Mar 2021 19:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbhCJSI2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Mar 2021 13:08:28 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2679 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbhCJSIC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Mar 2021 13:08:02 -0500
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DwfzZ3LFnz67tLR;
        Thu, 11 Mar 2021 02:02:02 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 10 Mar 2021 19:08:00 +0100
Received: from lhrphicprd00229.huawei.com (10.123.41.22) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Wed, 10 Mar 2021 18:08:00 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     Chris Browy <cbrowy@avery-design.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-acpi@vger.kernel.org>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <linuxarm@huawei.com>, Fangjian <f.fangjian@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 1/2] PCI/doe: Initial support PCI Data Object Exchange
Date:   Thu, 11 Mar 2021 02:03:05 +0800
Message-ID: <20210310180306.1588376-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20210310180306.1588376-1-Jonathan.Cameron@huawei.com>
References: <20210310180306.1588376-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.123.41.22]
X-ClientProxiedBy: lhreml703-chm.china.huawei.com (10.201.108.52) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Introduced in an ECN to the PCI 5.0, DOE provides a config space
based mailbox with standard protocol discovery.  Each mailbox
is accessed through a DOE PCIE Extended Capability.

A device may have 1 or more DOE mailboxes, each of which is allowed
to support any number of protocols (some DOE protocols
specifications apply additional restrictions).  A given protocol
may be supported on more than one DOE mailbox on a given function.

The current infrastructure is fairly simplistic and pushes the burden
of handling this many-to-many relantionship to the drivers. In many
cases the arrangement will be static, making this straight forward.

Open questions:
* timeouts: The DOE specification allows for 1 second for some
  operations, but notes that specific protocols may have different
  requirements. Should we introduce the flexiblity now, or leave
  that to be implemented when support for such a protocol is added?
* DOE mailboxes may use MSI / MSIX to signal that the have prepared
  a response. These require normal conditions are setup by the driver.
  Should we move some of this into the DOE support (such as ensuring
  bus mastering is enabled)?

Testing conducted against QEMU using:

https://lore.kernel.org/qemu-devel/1612900760-7361-1-git-send-email-cbrowy@avery-design.com/
+ fix for interrupt flag mentioned in that thread.

Additional testing to be done, particularly around error handling.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/pci/pcie/Kconfig      |   8 +
 drivers/pci/pcie/Makefile     |   1 +
 drivers/pci/pcie/doe.c        | 284 ++++++++++++++++++++++++++++++++++
 include/linux/pcie-doe.h      |  35 +++++
 include/uapi/linux/pci_regs.h |  29 +++-
 5 files changed, 356 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index 45a2ef702b45..f1cada7790fd 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -142,3 +142,11 @@ config PCIE_EDR
 	  the PCI Firmware Specification r3.2.  Enable this if you want to
 	  support hybrid DPC model which uses both firmware and OS to
 	  implement DPC.
+
+config PCIE_DOE
+       bool "PCI Express Data Object Exchange support"
+       help
+         This enables library support PCI Data Object Exchange capability.
+         DOE provides a simple mailbox in PCI express config space that is
+         used by a number of different protocols.
+         It is defined in he Data Object Exchnage ECN to PCI 5.0.
diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
index b2980db88cc0..801fdd5fbfc1 100644
--- a/drivers/pci/pcie/Makefile
+++ b/drivers/pci/pcie/Makefile
@@ -13,3 +13,4 @@ obj-$(CONFIG_PCIE_PME)		+= pme.o
 obj-$(CONFIG_PCIE_DPC)		+= dpc.o
 obj-$(CONFIG_PCIE_PTM)		+= ptm.o
 obj-$(CONFIG_PCIE_EDR)		+= edr.o
+obj-$(CONFIG_PCIE_DOE)		+= doe.o
diff --git a/drivers/pci/pcie/doe.c b/drivers/pci/pcie/doe.c
new file mode 100644
index 000000000000..b091ef379362
--- /dev/null
+++ b/drivers/pci/pcie/doe.c
@@ -0,0 +1,284 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Data Object Exchange was added to the PCI spec as an ECN to 5.0.
+ *
+ * Copyright (C) 2021 Huawei
+ *     Jonathan Cameron <Jonathan.Cameron@huawei.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/jiffies.h>
+#include <linux/mutex.h>
+#include <linux/pci.h>
+#include <linux/pcie-doe.h>
+
+static irqreturn_t doe_irq(int irq, void *data)
+{
+	struct pcie_doe *doe = data;
+	struct pci_dev *pdev = doe->pdev;
+	u32 val;
+
+	pci_read_config_dword(pdev, doe->cap_offset + PCI_DOE_STATUS, &val);
+	if (FIELD_GET(PCI_DOE_STATUS_INT_STATUS, val)) {
+		pci_write_config_dword(pdev, doe->cap_offset + PCI_DOE_STATUS,
+				       val);
+		complete(&doe->c);
+		return IRQ_HANDLED;
+	}
+	/* Leave the error case to be handled outside irq */
+	if (FIELD_GET(PCI_DOE_STATUS_ERROR, val)) {
+		complete(&doe->c);
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
+static int pcie_doe_abort(struct pcie_doe *doe)
+{
+	struct pci_dev *pdev = doe->pdev;
+	int retry = 0;
+	u32 val;
+
+	pci_write_config_dword(pdev, doe->cap_offset + PCI_DOE_CTRL,
+			       PCI_DOE_CTRL_ABORT);
+	/* Abort is allowed to take up to 1 second */
+	do {
+		retry++;
+		pci_read_config_dword(pdev, doe->cap_offset + PCI_DOE_STATUS,
+				      &val);
+		if (FIELD_GET(PCI_DOE_STATUS_ERROR, val) &&
+		    !FIELD_GET(PCI_DOE_STATUS_BUSY, val))
+			return 0;
+		usleep_range(1000, 2000);
+	} while (retry < 1000);
+
+	return -EIO;
+}
+
+/**
+ * pcie_doe_init() - Initialise a Data Object Exchange mailbox
+ * @doe: state structure for the DOE mailbox
+ * @pdev: pci device which has this DOE mailbox
+ * @doe_offset: offset in configuration space of the DOE extended capability.
+ * @use_int: whether to use the optional interrupt
+ * Returns: 0 on success, <0 on error
+ *
+ * Caller responsible for calling pci_alloc_irq_vectors() including DOE
+ * interrupt.
+ */
+int pcie_doe_init(struct pcie_doe *doe, struct pci_dev *pdev, int doe_offset,
+		  bool use_int)
+{
+	u32 val;
+	int rc;
+
+	mutex_init(&doe->lock);
+	init_completion(&doe->c);
+	doe->cap_offset = doe_offset;
+	doe->pdev = pdev;
+	/* Reset the mailbox by issuing an abort */
+	rc = pcie_doe_abort(doe);
+	if (rc)
+		return rc;
+
+	pci_read_config_dword(pdev, doe_offset + PCI_DOE_CAP, &val);
+
+	if (use_int && FIELD_GET(PCI_DOE_CAP_INT, val)) {
+		rc = devm_request_irq(&pdev->dev,
+				      pci_irq_vector(pdev,
+						     FIELD_GET(PCI_DOE_CAP_IRQ, val)),
+				      doe_irq, 0, "DOE", doe);
+		if (rc)
+			return rc;
+
+		doe->use_int = use_int;
+		pci_write_config_dword(pdev, doe_offset + PCI_DOE_CTRL,
+				       FIELD_PREP(PCI_DOE_CTRL_INT_EN, 1));
+	}
+
+	return 0;
+}
+
+
+/**
+ * pcie_doe_exchange() - Send a request and receive a response
+ * @doe: DOE mailbox state structure
+ * @request: request data to be sent
+ * @request_sz: size of request in bytes
+ * @response: buffer into which to place the response
+ * @response_sz: size of available response buffer in bytes
+ *
+ * Return: 0 on success, < 0 on error
+ * Excess data will be discarded.
+ */
+int pcie_doe_exchange(struct pcie_doe *doe, u32 *request, size_t request_sz,
+		      u32 *response, size_t response_sz)
+{
+	struct pci_dev *pdev = doe->pdev;
+	int ret = 0;
+	int i;
+	u32 val;
+	int retry = -1;
+	size_t length;
+
+	/* DOE requests must be a whole number of DW */
+	if (request_sz % sizeof(u32))
+		return -EINVAL;
+
+	/* Need at least 2 DW to get the length */
+	if (response_sz < 2 * sizeof(u32))
+		return -EINVAL;
+
+	mutex_lock(&doe->lock);
+	/*
+	 * Check the DOE busy bit is not set.
+	 * If it is set, this could indicate someone other than Linux is
+	 * using the mailbox.
+	 */
+	pci_read_config_dword(pdev, doe->cap_offset + PCI_DOE_STATUS, &val);
+	if (FIELD_GET(PCI_DOE_STATUS_BUSY, val)) {
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	if (FIELD_GET(PCI_DOE_STATUS_ERROR, val)) {
+		ret = pcie_doe_abort(doe);
+		if (ret)
+			goto unlock;
+	}
+
+	for (i = 0; i < request_sz / 4; i++)
+		pci_write_config_dword(pdev, doe->cap_offset + PCI_DOE_WRITE,
+				       request[i]);
+
+	reinit_completion(&doe->c);
+	pci_write_config_dword(pdev, doe->cap_offset + PCI_DOE_CTRL,
+			       PCI_DOE_CTRL_GO);
+
+	if (doe->use_int) {
+		/*
+		 * Timeout of 1 second from 6.xx.1 ECN - Data Object Exchange
+		 * Note a protocol is allowed to specify a different timeout, so
+		 * that may need supporting in future.
+		 */
+		if (!wait_for_completion_timeout(&doe->c,
+						 msecs_to_jiffies(1000))) {
+			ret = -ETIMEDOUT;
+			goto unlock;
+		}
+
+		pci_read_config_dword(pdev,
+				      doe->cap_offset + PCI_DOE_STATUS,
+				      &val);
+		if (FIELD_GET(PCI_DOE_STATUS_ERROR, val)) {
+			pcie_doe_abort(doe);
+			ret = -EIO;
+			goto unlock;
+		}
+	} else {
+		do {
+			retry++;
+			pci_read_config_dword(pdev,
+					      doe->cap_offset + PCI_DOE_STATUS,
+					      &val);
+			if (FIELD_GET(PCI_DOE_STATUS_ERROR, val)) {
+				pcie_doe_abort(doe);
+				ret = -EIO;
+				goto unlock;
+			}
+
+			if (FIELD_GET(PCI_DOE_STATUS_DATA_OBJECT_READY, val))
+				break;
+			usleep_range(1000, 2000);
+		} while (retry < 1000);
+		if (!FIELD_GET(PCI_DOE_STATUS_DATA_OBJECT_READY, val)) {
+			ret = -ETIMEDOUT;
+			goto unlock;
+		}
+	}
+
+	/* Read the first two dwords to get the length */
+	pci_read_config_dword(pdev, doe->cap_offset + PCI_DOE_READ,
+			      &response[0]);
+	pci_write_config_dword(pdev, doe->cap_offset + PCI_DOE_READ, 0);
+	pci_read_config_dword(pdev, doe->cap_offset + PCI_DOE_READ,
+			      &response[1]);
+	pci_write_config_dword(pdev, doe->cap_offset + PCI_DOE_READ, 0);
+	length = FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH,
+			   response[1]);
+	if (length > SZ_1M)
+		return -EIO;
+
+	for (i = 2; i < min(length, response_sz / 4); i++) {
+		pci_read_config_dword(pdev, doe->cap_offset + PCI_DOE_READ,
+				      &response[i]);
+		pci_write_config_dword(pdev, doe->cap_offset + PCI_DOE_READ, 0);
+	}
+	/* flush excess length */
+	for (; i < length; i++) {
+		pci_read_config_dword(pdev, doe->cap_offset + PCI_DOE_READ,
+				      &val);
+		pci_write_config_dword(pdev, doe->cap_offset + PCI_DOE_READ, 0);
+	}
+	/* Final error check to pick up on any since Data Object Ready */
+	pci_read_config_dword(pdev, doe->cap_offset + PCI_DOE_STATUS, &val);
+	if (FIELD_GET(PCI_DOE_STATUS_ERROR, val)) {
+		pcie_doe_abort(doe);
+		ret = -EIO;
+	}
+unlock:
+	mutex_unlock(&doe->lock);
+
+	return ret;
+}
+
+
+static int pcie_doe_discovery(struct pcie_doe *doe, u8 *index, u16 *vid, u8 *protocol)
+{
+	u32 request[3] = {
+		[0] = FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_1_VID, 0001) |
+		FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE, 0),
+		[1] = FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH, 3),
+		[2] = FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX, *index)
+	};
+	u32 response[3];
+	int ret;
+
+	ret = pcie_doe_exchange(doe, request, sizeof(request), response, sizeof(response));
+	if (ret)
+		return ret;
+
+	*vid = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID, response[2]);
+	*protocol = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL, response[2]);
+	*index = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX, response[2]);
+
+	return 0;
+}
+
+/**
+ * pcie_doe_protocol_check() - check if this DOE mailbox supports specific protocol
+ * @doe: DOE state structure
+ * @vid: Vendor ID
+ * @protocol: Protocol number as defined by Vendor
+ * Returns: 0 on success, <0 on error
+ */
+int pcie_doe_protocol_check(struct pcie_doe *doe, u16 vid, u8 protocol)
+{
+	u8 index = 0;
+
+	do {
+		u8 this_protocol;
+		u16 this_vid;
+		int ret;
+
+		ret = pcie_doe_discovery(doe, &index, &this_vid, &this_protocol);
+		if (ret)
+			return ret;
+		if (this_vid == vid && this_protocol == protocol)
+			return 0;
+	} while (index);
+
+	return -ENODEV;
+}
diff --git a/include/linux/pcie-doe.h b/include/linux/pcie-doe.h
new file mode 100644
index 000000000000..36eaa8532254
--- /dev/null
+++ b/include/linux/pcie-doe.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Data Object Exchange was added to the PCI spec as an ECN to 5.0.
+ *
+ * Copyright (C) 2021 Huawei
+ *     Jonathan Cameron <Jonathan.Cameron@huawei.com>
+ */
+
+#include <linux/completion.h>
+#include <linux/mutex.h>
+
+#ifndef LINUX_PCIE_DOE_H
+#define LINUX_PCIE_DOE_H
+/**
+ * struct pcie_doe - State to support use of DOE mailbox
+ * @lock: Ensure users of the mailbox are serialized
+ * @cap_offset: Config space offset to base of DOE capability.
+ * @pdev: PCI device that hosts this DOE.
+ * @c: Completion used for interrupt handling.
+ * @use_int: Flage to indicate if interrupts rather than polling used.
+ */
+struct pcie_doe {
+	struct mutex lock;
+	int cap_offset;
+	struct pci_dev *pdev;
+	struct completion c;
+	bool use_int;
+};
+
+int pcie_doe_init(struct pcie_doe *doe, struct pci_dev *dev, int doe_offset,
+		  bool use_int);
+int pcie_doe_exchange(struct pcie_doe *doe, u32 *request, size_t request_sz,
+		      u32 *response, size_t response_sz);
+int pcie_doe_protocol_check(struct pcie_doe *doe, u16 vid, u8 protocol);
+#endif
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index e709ae8235e7..4d8a5fee2cdf 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -730,7 +730,8 @@
 #define PCI_EXT_CAP_ID_DVSEC	0x23	/* Designated Vendor-Specific */
 #define PCI_EXT_CAP_ID_DLF	0x25	/* Data Link Feature */
 #define PCI_EXT_CAP_ID_PL_16GT	0x26	/* Physical Layer 16.0 GT/s */
-#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_PL_16GT
+#define PCI_EXT_CAP_ID_DOE	0x2E	/* Data Object Exchange */
+#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_DOE
 
 #define PCI_EXT_CAP_DSN_SIZEOF	12
 #define PCI_EXT_CAP_MCAST_ENDPOINT_SIZEOF 40
@@ -1092,4 +1093,30 @@
 #define  PCI_PL_16GT_LE_CTRL_USP_TX_PRESET_MASK		0x000000F0
 #define  PCI_PL_16GT_LE_CTRL_USP_TX_PRESET_SHIFT	4
 
+/* Data Object Exchange */
+#define PCI_DOE_CAP		0x04	/* DOE Capabilities Register */
+#define  PCI_DOE_CAP_INT			0x00000001  /* Interrupt Support */
+#define  PCI_DOE_CAP_IRQ			0x00000ffe  /* Interrupt Message Number */
+#define PCI_DOE_CTRL		0x08	/* DOE Control Register */
+#define  PCI_DOE_CTRL_ABORT			0x00000001  /* DOE Abort */
+#define  PCI_DOE_CTRL_INT_EN			0x00000002  /* DOE Interrupt Enable */
+#define  PCI_DOE_CTRL_GO			0x80000000  /* DOE Go */
+#define PCI_DOE_STATUS		0x0C	/* DOE Status Register */
+#define  PCI_DOE_STATUS_BUSY			0x00000001  /* DOE Busy */
+#define  PCI_DOE_STATUS_INT_STATUS		0x00000002  /* DOE Interrupt Status */
+#define  PCI_DOE_STATUS_ERROR			0x00000004  /* DOE Error */
+#define  PCI_DOE_STATUS_DATA_OBJECT_READY	0x80000000  /* Data Object Ready */
+#define PCI_DOE_WRITE		0x10	/* DOE Write Data Mailbox Register */
+#define PCI_DOE_READ		0x14	/* DOE Read Data Mailbox Register */
+
+/* DOE Data Object - note not actually registers */
+#define PCI_DOE_DATA_OBJECT_HEADER_1_VID	0x0000FFFF
+#define PCI_DOE_DATA_OBJECT_HEADER_1_TYPE	0x00FF0000
+#define PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH	0x0003FFFF
+
+#define PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX	0x000000FF
+#define PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID	0x0000FFFF
+#define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL	0x00FF0000
+#define PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX 0xFF000000
+
 #endif /* LINUX_PCI_REGS_H */
-- 
2.19.1

