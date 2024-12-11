Return-Path: <linux-pci+bounces-18092-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E74F59EC594
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 08:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75F7E168CC3
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 07:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F331D7E35;
	Wed, 11 Dec 2024 07:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="a2aQeRcH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2756C1D7999
	for <linux-pci@vger.kernel.org>; Wed, 11 Dec 2024 07:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733902180; cv=none; b=GE4y+MpflCljfOfvpi5lWOc+OA3El7ISSTxHeihGFQ23eGP4pFkd8qHNCrqKhGRkgGshdXdTPfXhktBMxkw7Aupak5y5CaXTYm1gI6ymUbZh3mYY0ZhblrOjt6x1VZwZlZHeH1qm9tVP8MNwU+xGqszxcDW9h/ji1kAabeYD60E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733902180; c=relaxed/simple;
	bh=8ZF3IvLOoCySiy26jAiaBMhwtx/fbaQ7BUyUvNa93+A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=SSsjzCQ8CsHMk6IH0+SnQr6ZsfpbDkZwLoJDv69ATfLG5zggP9lw0Fn23eaofcSmPe8WDZ/J6uGYZiR/d5RLZLJx1z3GEqng9hW3f6s07b31WV0enjm7YhgR0QXU5BQjCK9Qwlyou0LKzuXRnFo6mj7r34uuTo6GnpgcgJAE97c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=a2aQeRcH; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-725ed193c9eso2647928b3a.1
        for <linux-pci@vger.kernel.org>; Tue, 10 Dec 2024 23:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733902178; x=1734506978; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PiPHPeh/DIT/I/+W6imeBkqTsSXlAJ4XQ5pXfZr/wes=;
        b=a2aQeRcHpcPxxUXorOpUaU56DPD9hQqcbrxCHZ7Gf578bj+XIUMqikINz96JJhYHCd
         5lkaFKCgbWyPegTP2mbKR5l2iVO4R+whimznprflvFSCL713lmAzjYPs+bihImAlQEmB
         kN6K7s7SnMjS57Dyk7QpNkKwNU/qYVwQlKH4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733902178; x=1734506978;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PiPHPeh/DIT/I/+W6imeBkqTsSXlAJ4XQ5pXfZr/wes=;
        b=TA0Xvh0XG9DGBKDRnzUwFBkXXimI6ajMSBqDxx+s0B3JVyg20h1UbTvzOpBnPrKfRS
         yXon4BpBpWVdDAnKuS8AwSJEeWlQaiE7CObFfTedVUrZPVKAM8xxMQ+A5AvmPqd9AAJu
         bI7lTDiEzEnPE3Is2j1Vzt4AnGlxXEJU309G8Nc89cwG3gmQGgHl/JrtvBdBC9W8Z5ef
         bhAiMk7uRNuoI61UNToI9Vc6M3kX5CosI2gGQ1NYK9wnGQhEvZpEiAsdf7CfFmBDeSZI
         DQ7maj68ml92pkYfarUyGdEkrbr6u/kZmDpMKgvXgqs0qktieDsReZD+h3HadesRKtF4
         V6Tg==
X-Gm-Message-State: AOJu0YxNS87BmCOd18XFwihIQ98qBaphjZ3Vagd1C0a7XCwJHUCYHM5D
	+cJcks7MmIuW3VS+Gn7suxPEpFKyznb6cxNAx/i1HKwtgB6oGK+yWhQnmR0F/PVLAOG+G1U1ZrG
	sitGqyi13FBpXPUXdIH1d8sHeEbMA9U96LA5HfexvXVYVAdCynXk1HjCAqM8t0bMYGf2b8c7PQz
	zlHEMkbWrN8+FngDMfXrQxB7a+g/9bPgs/lBfFvr32sJpNjR9VrhQsOHyFhtdSk4f8jw==
X-Gm-Gg: ASbGncuvtu2dyW+KhpoalTp4Tv+oK88zAdFP+ez6WbBdShZudFu4cCSCCxxcYAvnC9V
	94LvvjGzdM1whnIrNfPxT78i/xZgSpZs7kfw7SpwwBWjFkeW2GIVSY6knJAnJ/roBzBPHBrkLZX
	cX2FKWP6QolWq2gHwG4HESoQcxc29n9SMI0arB5aMYTkJE0eYa9hn4PpQgKkeiGPoNqznJwIkZO
	0cBNXqvMMBCuMMPGA/EX9kpvqlJnCUJZAqpsRGX6TVWPwW+U77xhULYydAfQ+Q4hGKMGVxh6o7b
	3vY64iAJhg7yID2uGw0IhBmOJd4iryjMCv1/wZn/hFxBSrfJfFWzRn6M9yEn+A==
X-Google-Smtp-Source: AGHT+IG4Zr1ijzrENhB4oOQb9Ap8QRgMjKffSbfyJFXrpHH/MFZ6zv8pnC7K8ubx1x8PMoUaMAl4mw==
X-Received: by 2002:a05:6a20:72a4:b0:1e0:d89e:f5bc with SMTP id adf61e73a8af0-1e1c126aec2mr4018537637.11.1733902177790;
        Tue, 10 Dec 2024 23:29:37 -0800 (PST)
Received: from dhcp-135-24-192-142.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725cc7fcfb2sm7540539b3a.141.2024.12.10.23.29.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2024 23:29:37 -0800 (PST)
From: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
To: linux-pci@vger.kernel.org,
	bhelgaas@google.com,
	manivannan.sadhasivam@linaro.org,
	logang@deltatee.com,
	Jonathan.Cameron@huawei.com
Cc: linux-kernel@vger.kernel.org,
	sumanesh.samanta@broadcom.com,
	sathya.prakash@broadcom.com,
	sjeaugey@nvidia.com,
	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Subject: [PATCH v3 1/2] PCI/portdrv: Enable reporting inter-switch P2P links
Date: Tue, 10 Dec 2024 23:17:47 -0800
Message-Id: <1733901468-14860-2-git-send-email-shivasharan.srikanteshwara@broadcom.com>
X-Mailer: git-send-email 2.4.3
In-Reply-To: <1733901468-14860-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
References: <1733901468-14860-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Broadcom PCI switches supports inter-switch P2P links between two
PCI-to-PCI bridges. This presents an optimal data path for data
movement. The patch exports a new sysfs entry for PCI devices that
support the inter switch P2P links and reports the B:D:F information
of the devices that are connected through this inter switch link as
shown below:

                             Host root bridge
                ---------------------------------------
                |                                     |
  NIC1 --- PCI Switch1 --- Inter-switch link --- PCI Switch2 --- NIC2
(2c:00.0)   (2a:00.0)                             (3d:00.0)   (40:00.0)
                |                                     |
               GPU1                                  GPU2
            (2d:00.0)                             (3f:00.0)
                               SERVER 1

$ find /sys/ -name "links" | xargs grep .
/sys/devices/pci0000:29/0000:29:01.0/0000:2a:00.0/p2p_link/links:0000:3d:00.0
/sys/devices/pci0000:3c/0000:3c:01.0/0000:3d:00.0/p2p_link/links:0000:2a:00.0

Current support is added to report the P2P links available for
Broadcom switches based on the capability that is reported by the
upstream bridges through their vendor-specific capability registers.

Signed-off-by: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Signed-off-by: Sumanesh Samanta <sumanesh.samanta@broadcom.com>
---
Changes in v3:
Moved the link detection code to separate file that can be enabled with
config option CONFIG_PCIE_P2P_LINK

Changes in v2:
Integrated the code into PCIe portdrv to create the sysfs entries during
probe, as suggested by Mani.

 Documentation/ABI/testing/sysfs-bus-pci |  14 +++
 drivers/pci/pcie/Kconfig                |   9 ++
 drivers/pci/pcie/Makefile               |   1 +
 drivers/pci/pcie/p2p_link.c             | 143 ++++++++++++++++++++++++
 drivers/pci/pcie/p2p_link.h             |  27 +++++
 drivers/pci/pcie/portdrv.c              |   5 +-
 6 files changed, 198 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pci/pcie/p2p_link.c
 create mode 100644 drivers/pci/pcie/p2p_link.h

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index 5da6a14dc326..200cb3f214bf 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -583,3 +583,17 @@ Description:
 		enclosure-specific indications "specific0" to "specific7",
 		hence the corresponding led class devices are unavailable if
 		the DSM interface is used.
+
+What:		/sys/bus/pci/devices/.../p2p_link/links
+Date:		September 2024
+Contact:	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
+Description:
+		This file appears on PCIe upstream ports which supports an
+		internal P2P link.
+		Reading this attribute will provide the list of other upstream
+		ports on the system which have an internal P2P link available
+		between the two ports.
+Users:
+		Userspace applications interested in determining a optimal P2P
+		link for data transfers between devices connected to the PCIe
+		switches.
diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index 17919b99fa66..9afa9016cdf3 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -155,3 +155,12 @@ config PCIE_EDR
 	  the PCI Firmware Specification r3.2.  Enable this if you want to
 	  support hybrid DPC model which uses both firmware and OS to
 	  implement DPC.
+
+config PCIE_P2P_LINK
+	bool "PCI Express P2P link detection support"
+	depends on PCIEPORTBUS
+	help
+	  This option enables the PCIe port driver to export sysfs entries
+	  for Inter switch P2P links detected on the PCIe upstream ports.
+	  This option enables user space libraries to detect optimal paths
+	  for data transfers between endpoints connected to PCIe switches.
diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
index 53ccab62314d..d1e71698cbd8 100644
--- a/drivers/pci/pcie/Makefile
+++ b/drivers/pci/pcie/Makefile
@@ -13,3 +13,4 @@ obj-$(CONFIG_PCIE_PME)		+= pme.o
 obj-$(CONFIG_PCIE_DPC)		+= dpc.o
 obj-$(CONFIG_PCIE_PTM)		+= ptm.o
 obj-$(CONFIG_PCIE_EDR)		+= edr.o
+obj-$(CONFIG_PCIE_P2P_LINK)	+= p2p_link.o
diff --git a/drivers/pci/pcie/p2p_link.c b/drivers/pci/pcie/p2p_link.c
new file mode 100644
index 000000000000..dec5c4cbcf13
--- /dev/null
+++ b/drivers/pci/pcie/p2p_link.c
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Purpose:	PCI Express P2P link discovery
+ *
+ * Copyright (C) 2024 Broadcom Inc.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/pci.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+#include <linux/bitops.h>
+
+#include "../pci.h"
+#include "portdrv.h"
+#include "p2p_link.h"
+
+/**
+ * pcie_brcm_is_p2p_supported - Broadcom device specific handler
+ *       to check if the upstream port supports inter switch P2P.
+ *
+ * @dev: PCIe upstream port to check
+ *
+ * This function assumes the PCIe upstream port is a Broadcom
+ * PCIe device.
+ */
+static bool pcie_brcm_is_p2p_supported(struct pci_dev *dev)
+{
+	u64 dsn;
+	u16 vsec;
+	u32 vsec_data;
+
+	vsec = pci_find_vsec_capability(dev, PCI_VENDOR_ID_LSI_LOGIC,
+					PCIE_BRCM_SW_P2P_VSEC_ID);
+	if (!vsec) {
+		pci_dbg(dev, "Failed to get VSEC capability\n");
+		return false;
+	}
+
+	pci_read_config_dword(dev, vsec + PCIE_BRCM_SW_P2P_MODE_VSEC_OFFSET,
+			      &vsec_data);
+
+	dsn = pci_get_dsn(dev);
+	if (!dsn) {
+		pci_dbg(dev, "DSN capability is not present\n");
+		return false;
+	}
+
+	pci_dbg(dev, "Serial Number: 0x%llx VSEC 0x%x\n",
+		dsn, vsec_data);
+
+	/* Check if the PEX switch has a valid P2P support */
+	if (!(dsn & PCIE_BRCM_SW_DSN_P2P_STATUS))
+		return false;
+
+	return FIELD_GET(PCIE_BRCM_SW_P2P_MODE_MASK, vsec_data) ==
+		PCIE_BRCM_SW_P2P_MODE_INTER_SW_LINK;
+}
+
+/*
+ * Determine if device supports Inter switch P2P links.
+ *
+ * Return value: true if inter switch P2P is supported, return false otherwise.
+ */
+static bool pcie_port_is_p2p_supported(struct pci_dev *dev)
+{
+	/* P2P link attribute is supported on upstream ports only */
+	if (pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM)
+		return false;
+
+	/*
+	 * Currently Broadcom PEX switches are supported.
+	 */
+	if (dev->vendor == PCI_VENDOR_ID_LSI_LOGIC &&
+	    (dev->device == PCI_DEVICE_ID_BRCM_PEX_89000_HLC ||
+	     dev->device == PCI_DEVICE_ID_BRCM_PEX_89000_LLC))
+		return pcie_brcm_is_p2p_supported(dev);
+
+	return false;
+}
+
+/*
+ * Traverse list of all PCI bridges and find devices that support Inter switch P2P
+ * and have the same serial number to create report the BDF over sysfs.
+ */
+static ssize_t links_show(struct device *dev, struct device_attribute *attr,
+			  char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev), *pdev_link = NULL;
+	size_t len = 0;
+	u64 dsn, dsn_link;
+
+	/*
+	 * pdev's DSN has already been verified to be available before creating
+	 * the sysfs entry.
+	 */
+	dsn = pci_get_dsn(pdev);
+
+	/* Traverse list of PCI bridges to determine any available P2P links */
+	while ((pdev_link = pci_get_class(PCI_CLASS_BRIDGE_PCI << 8, pdev_link))
+			!= NULL) {
+		if (pdev_link == pdev)
+			continue;
+
+		if (!pcie_port_is_p2p_supported(pdev_link))
+			continue;
+
+		dsn_link = pci_get_dsn(pdev_link);
+		if (!dsn_link)
+			continue;
+
+		if (dsn == dsn_link)
+			len += sysfs_emit_at(buf, len, "%04x:%02x:%02x.%d\n",
+					     pci_domain_nr(pdev_link->bus),
+					     pdev_link->bus->number, PCI_SLOT(pdev_link->devfn),
+					     PCI_FUNC(pdev_link->devfn));
+	}
+
+	return len;
+}
+
+/* P2P link sysfs attribute. */
+static struct device_attribute dev_attr_links =
+	__ATTR(links, 0444, links_show, NULL);
+
+static struct attribute *pcie_port_p2p_link_attrs[] = {
+	&dev_attr_links.attr,
+	NULL
+};
+
+const struct attribute_group pcie_port_p2p_link_attr_group = {
+	.name = "p2p_link",
+	.attrs = pcie_port_p2p_link_attrs,
+};
+
+void p2p_link_sysfs_update_group(struct pci_dev *pdev)
+{
+	if (!pcie_port_is_p2p_supported(pdev))
+		return;
+
+	sysfs_update_group(&pdev->dev.kobj, &pcie_port_p2p_link_attr_group);
+}
diff --git a/drivers/pci/pcie/p2p_link.h b/drivers/pci/pcie/p2p_link.h
new file mode 100644
index 000000000000..6c4f57841c79
--- /dev/null
+++ b/drivers/pci/pcie/p2p_link.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Purpose:	PCI Express P2P link discovery
+ *
+ * Copyright (C) 2024 Broadcom Inc.
+ */
+
+#ifndef _P2P_LINK_H_
+#define _P2P_LINK_H_
+
+/* P2P Link supported device IDs */
+#define PCI_DEVICE_ID_BRCM_PEX_89000_HLC	0xC030
+#define PCI_DEVICE_ID_BRCM_PEX_89000_LLC	0xC034
+
+#define PCIE_BRCM_SW_P2P_VSEC_ID		0x1
+#define PCIE_BRCM_SW_P2P_MODE_VSEC_OFFSET	0xC
+#define PCIE_BRCM_SW_P2P_MODE_MASK		GENMASK(9, 8)
+#define PCIE_BRCM_SW_P2P_MODE_INTER_SW_LINK	0x2
+#define PCIE_BRCM_SW_DSN_P2P_STATUS		BIT(3)
+
+#ifdef CONFIG_PCIE_P2P_LINK
+void p2p_link_sysfs_update_group(struct pci_dev *pdev);
+
+#else
+static inline void p2p_link_sysfs_update_group(struct pci_dev *pdev) { }
+#endif
+#endif /* _P2P_LINK_H_ */
diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 5e10306b6308..f4ddff78e104 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -21,6 +21,7 @@
 
 #include "../pci.h"
 #include "portdrv.h"
+#include "p2p_link.h"
 
 /*
  * The PCIe Capability Interrupt Message Number (PCIe r3.1, sec 7.8.2) must
@@ -714,7 +715,9 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
 		pm_runtime_put_autosuspend(&dev->dev);
 		pm_runtime_allow(&dev->dev);
 	}
-
+#ifdef CONFIG_PCIE_P2P_LINK
+	p2p_link_sysfs_update_group(dev);
+#endif
 	return 0;
 }
 
-- 
2.43.0


