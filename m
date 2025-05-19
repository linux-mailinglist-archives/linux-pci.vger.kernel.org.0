Return-Path: <linux-pci+bounces-28005-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9353AABC571
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 19:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC95A3AAE2C
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 17:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6A32882C6;
	Mon, 19 May 2025 17:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="chaGXU8e"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB6EBA4A;
	Mon, 19 May 2025 17:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747675102; cv=none; b=lX7kFWQyfnKrxWprGHBxB0QOOo8JRr8nYZBsXFNYlO5GLWxZeGsK6bRDSlNAOE5lB2fXhFrY9RkEDLKf9yeH8qgjHDNQVA/pt5wZulycq6ro0wpjaNlumzs9on5yctBtwP+B7vqquQ2400aioFGY6G/Or6R1i1qHo+tYmW/QO+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747675102; c=relaxed/simple;
	bh=ZWI/O2uLPWx3Ea/6iFeC3EM9v8ftibEtU9uleiarHaY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VbdMoj5ccRJn3I8MfhhAkawG76vKPz+1IFCChntPCDE6V0uQLzs0+FL7iwcaaZ0jk9XTjpvdfKq+9XKwHO3ZbKL5rkE9n1sEyZqKWcHpE5jUOGsrMGSwmVWepv3d1aua5YXAs3vkhyAcyHCYxB5zemPz3Z7AsLxZamZKvuNFiic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=chaGXU8e; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747675100; x=1779211100;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZWI/O2uLPWx3Ea/6iFeC3EM9v8ftibEtU9uleiarHaY=;
  b=chaGXU8enkNcesdoXYR++6+iOVKLjCov5MCEBrKkXAu9Z3C73a4bxRVO
   QPx/57CXnQRbKpNtrBZyZxV7rLC2agHu0fmz0QNUyJ3if9g9B3SAphcu+
   rIbB+j47HBV6hZuJG7pSDVGUumFOAH5AkVaACEUkqNvBKZkXZJ2XDv5X5
   wFyfO4r1/EWCvhPzIMEsaRZMU/QqP/4i0N9p4C4wN1LNrzxirdJ1z5Eyh
   dAE/RfA9D8t66romXw+N+lOj8llcR4tQSXU22C9vvpDeqer5+7pENsIws
   mexvvmOQfuuZaHi0ZlLf+EISFBA8k88iDQBQ22b9n7uuyHzRbbJkJCuVh
   w==;
X-CSE-ConnectionGUID: NlcFYY9eTGC8a/WKUREt7Q==
X-CSE-MsgGUID: OWYX91bPQvm/7KuWJhI/VA==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="48698994"
X-IronPort-AV: E=Sophos;i="6.15,301,1739865600"; 
   d="scan'208";a="48698994"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 10:18:19 -0700
X-CSE-ConnectionGUID: T45elrMfRkiQoO7FarPL8A==
X-CSE-MsgGUID: eslF8iBjRyeGROstMN8M1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,301,1739865600"; 
   d="scan'208";a="139172048"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.35])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 10:18:16 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Shawn Anastasio <sanastasio@raptorengineering.com>
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 2/2] PCI: Move link related code into link.c
Date: Mon, 19 May 2025 20:17:39 +0300
Message-Id: <20250519171739.3575-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250519171739.3575-1-ilpo.jarvinen@linux.intel.com>
References: <20250519171739.3575-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Move PCIe Link (and legacy bus speed) related code into link.c to
reduce the number of lines in pci.c and probe.c that are the two
largest C files under drivers/pci/.

The moved functions relate to:

 - Link Speed and Width (including arrays)
 - Link status
 - Link Training
 - Waiting for the Link to come up
 - Legacy AGP & PCI-X Bus speed (including arrays)

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/Makefile |   2 +-
 drivers/pci/link.c   | 578 +++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.c    | 369 ---------------------------
 drivers/pci/pci.h    |   3 +-
 drivers/pci/probe.c  | 194 ---------------
 5 files changed, 580 insertions(+), 566 deletions(-)
 create mode 100644 drivers/pci/link.c

diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 62c68c9cbb9e..aa1ebdf12943 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -2,7 +2,7 @@
 #
 # Makefile for the PCI bus specific drivers.
 
-obj-$(CONFIG_PCI)		+= access.o bus.o probe.o host-bridge.o \
+obj-$(CONFIG_PCI)		+= access.o bus.o probe.o host-bridge.o link.o \
 				   remove.o reset.o pci.o pci-driver.o \
 				   search.o rom.o setup-res.o irq.o vpd.o \
 				   setup-bus.o vc.o mmap.o devres.o
diff --git a/drivers/pci/link.c b/drivers/pci/link.c
new file mode 100644
index 000000000000..5481e96495a1
--- /dev/null
+++ b/drivers/pci/link.c
@@ -0,0 +1,578 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCI Link functions
+ */
+
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/export.h>
+#include <linux/pci.h>
+
+#include "pci.h"
+
+#define PCIE_LINK_RETRAIN_TIMEOUT_MS	1000
+
+const unsigned char pcie_link_speed[] = {
+	PCI_SPEED_UNKNOWN,		/* 0 */
+	PCIE_SPEED_2_5GT,		/* 1 */
+	PCIE_SPEED_5_0GT,		/* 2 */
+	PCIE_SPEED_8_0GT,		/* 3 */
+	PCIE_SPEED_16_0GT,		/* 4 */
+	PCIE_SPEED_32_0GT,		/* 5 */
+	PCIE_SPEED_64_0GT,		/* 6 */
+	PCI_SPEED_UNKNOWN,		/* 7 */
+	PCI_SPEED_UNKNOWN,		/* 8 */
+	PCI_SPEED_UNKNOWN,		/* 9 */
+	PCI_SPEED_UNKNOWN,		/* A */
+	PCI_SPEED_UNKNOWN,		/* B */
+	PCI_SPEED_UNKNOWN,		/* C */
+	PCI_SPEED_UNKNOWN,		/* D */
+	PCI_SPEED_UNKNOWN,		/* E */
+	PCI_SPEED_UNKNOWN		/* F */
+};
+EXPORT_SYMBOL_GPL(pcie_link_speed);
+
+static const unsigned char pcix_bus_speed[] = {
+	PCI_SPEED_UNKNOWN,		/* 0 */
+	PCI_SPEED_66MHz_PCIX,		/* 1 */
+	PCI_SPEED_100MHz_PCIX,		/* 2 */
+	PCI_SPEED_133MHz_PCIX,		/* 3 */
+	PCI_SPEED_UNKNOWN,		/* 4 */
+	PCI_SPEED_66MHz_PCIX_ECC,	/* 5 */
+	PCI_SPEED_100MHz_PCIX_ECC,	/* 6 */
+	PCI_SPEED_133MHz_PCIX_ECC,	/* 7 */
+	PCI_SPEED_UNKNOWN,		/* 8 */
+	PCI_SPEED_66MHz_PCIX_266,	/* 9 */
+	PCI_SPEED_100MHz_PCIX_266,	/* A */
+	PCI_SPEED_133MHz_PCIX_266,	/* B */
+	PCI_SPEED_UNKNOWN,		/* C */
+	PCI_SPEED_66MHz_PCIX_533,	/* D */
+	PCI_SPEED_100MHz_PCIX_533,	/* E */
+	PCI_SPEED_133MHz_PCIX_533	/* F */
+};
+
+static unsigned char agp_speeds[] = {
+	AGP_UNKNOWN,
+	AGP_1X,
+	AGP_2X,
+	AGP_4X,
+	AGP_8X
+};
+
+/* Indexed by PCI_EXP_LNKCAP_SLS, PCI_EXP_LNKSTA_CLS */
+const char *pci_speed_string(enum pci_bus_speed speed)
+{
+	/* Indexed by the pci_bus_speed enum */
+	static const char *speed_strings[] = {
+	    "33 MHz PCI",		/* 0x00 */
+	    "66 MHz PCI",		/* 0x01 */
+	    "66 MHz PCI-X",		/* 0x02 */
+	    "100 MHz PCI-X",		/* 0x03 */
+	    "133 MHz PCI-X",		/* 0x04 */
+	    NULL,			/* 0x05 */
+	    NULL,			/* 0x06 */
+	    NULL,			/* 0x07 */
+	    NULL,			/* 0x08 */
+	    "66 MHz PCI-X 266",		/* 0x09 */
+	    "100 MHz PCI-X 266",	/* 0x0a */
+	    "133 MHz PCI-X 266",	/* 0x0b */
+	    "Unknown AGP",		/* 0x0c */
+	    "1x AGP",			/* 0x0d */
+	    "2x AGP",			/* 0x0e */
+	    "4x AGP",			/* 0x0f */
+	    "8x AGP",			/* 0x10 */
+	    "66 MHz PCI-X 533",		/* 0x11 */
+	    "100 MHz PCI-X 533",	/* 0x12 */
+	    "133 MHz PCI-X 533",	/* 0x13 */
+	    "2.5 GT/s PCIe",		/* 0x14 */
+	    "5.0 GT/s PCIe",		/* 0x15 */
+	    "8.0 GT/s PCIe",		/* 0x16 */
+	    "16.0 GT/s PCIe",		/* 0x17 */
+	    "32.0 GT/s PCIe",		/* 0x18 */
+	    "64.0 GT/s PCIe",		/* 0x19 */
+	};
+
+	if (speed < ARRAY_SIZE(speed_strings))
+		return speed_strings[speed];
+	return "Unknown";
+}
+EXPORT_SYMBOL_GPL(pci_speed_string);
+
+static enum pci_bus_speed to_pcie_link_speed(u16 lnksta)
+{
+	return pcie_link_speed[FIELD_GET(PCI_EXP_LNKSTA_CLS, lnksta)];
+}
+
+int pcie_link_speed_mbps(struct pci_dev *pdev)
+{
+	u16 lnksta;
+	int err;
+
+	err = pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnksta);
+	if (err)
+		return err;
+
+	return pcie_dev_speed_mbps(to_pcie_link_speed(lnksta));
+}
+EXPORT_SYMBOL(pcie_link_speed_mbps);
+
+/**
+ * pcie_bandwidth_available - determine minimum link settings of a PCIe
+ *			      device and its bandwidth limitation
+ * @dev: PCI device to query
+ * @limiting_dev: storage for device causing the bandwidth limitation
+ * @speed: storage for speed of limiting device
+ * @width: storage for width of limiting device
+ *
+ * Walk up the PCI device chain and find the point where the minimum
+ * bandwidth is available.  Return the bandwidth available there and (if
+ * limiting_dev, speed, and width pointers are supplied) information about
+ * that point.  The bandwidth returned is in Mb/s, i.e., megabits/second of
+ * raw bandwidth.
+ */
+u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
+			     enum pci_bus_speed *speed,
+			     enum pcie_link_width *width)
+{
+	u16 lnksta;
+	enum pci_bus_speed next_speed;
+	enum pcie_link_width next_width;
+	u32 bw, next_bw;
+
+	if (speed)
+		*speed = PCI_SPEED_UNKNOWN;
+	if (width)
+		*width = PCIE_LNK_WIDTH_UNKNOWN;
+
+	bw = 0;
+
+	while (dev) {
+		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
+
+		next_speed = to_pcie_link_speed(lnksta);
+		next_width = FIELD_GET(PCI_EXP_LNKSTA_NLW, lnksta);
+
+		next_bw = next_width * PCIE_SPEED2MBS_ENC(next_speed);
+
+		/* Check if current device limits the total bandwidth */
+		if (!bw || next_bw <= bw) {
+			bw = next_bw;
+
+			if (limiting_dev)
+				*limiting_dev = dev;
+			if (speed)
+				*speed = next_speed;
+			if (width)
+				*width = next_width;
+		}
+
+		dev = pci_upstream_bridge(dev);
+	}
+
+	return bw;
+}
+EXPORT_SYMBOL(pcie_bandwidth_available);
+
+/**
+ * pcie_get_supported_speeds - query Supported Link Speed Vector
+ * @dev: PCI device to query
+ *
+ * Query @dev supported link speeds.
+ *
+ * Implementation Note in PCIe r6.0 sec 7.5.3.18 recommends determining
+ * supported link speeds using the Supported Link Speeds Vector in the Link
+ * Capabilities 2 Register (when available).
+ *
+ * Link Capabilities 2 was added in PCIe r3.0, sec 7.8.18.
+ *
+ * Without Link Capabilities 2, i.e., prior to PCIe r3.0, Supported Link
+ * Speeds field in Link Capabilities is used and only 2.5 GT/s and 5.0 GT/s
+ * speeds were defined.
+ *
+ * For @dev without Supported Link Speed Vector, the field is synthesized
+ * from the Max Link Speed field in the Link Capabilities Register.
+ *
+ * Return: Supported Link Speeds Vector (+ reserved 0 at LSB).
+ */
+u8 pcie_get_supported_speeds(struct pci_dev *dev)
+{
+	u32 lnkcap2, lnkcap;
+	u8 speeds;
+
+	/*
+	 * Speeds retain the reserved 0 at LSB before PCIe Supported Link
+	 * Speeds Vector to allow using SLS Vector bit defines directly.
+	 */
+	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP2, &lnkcap2);
+	speeds = lnkcap2 & PCI_EXP_LNKCAP2_SLS;
+
+	/* Ignore speeds higher than Max Link Speed */
+	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
+	speeds &= GENMASK(lnkcap & PCI_EXP_LNKCAP_SLS, 0);
+
+	/* PCIe r3.0-compliant */
+	if (speeds)
+		return speeds;
+
+	/* Synthesize from the Max Link Speed field */
+	if ((lnkcap & PCI_EXP_LNKCAP_SLS) == PCI_EXP_LNKCAP_SLS_5_0GB)
+		speeds = PCI_EXP_LNKCAP2_SLS_5_0GB | PCI_EXP_LNKCAP2_SLS_2_5GB;
+	else if ((lnkcap & PCI_EXP_LNKCAP_SLS) == PCI_EXP_LNKCAP_SLS_2_5GB)
+		speeds = PCI_EXP_LNKCAP2_SLS_2_5GB;
+
+	return speeds;
+}
+
+/**
+ * pcie_get_speed_cap - query for the PCI device's link speed capability
+ * @dev: PCI device to query
+ *
+ * Query the PCI device speed capability.
+ *
+ * Return: the maximum link speed supported by the device.
+ */
+enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev)
+{
+	return PCIE_LNKCAP2_SLS2SPEED(dev->supported_speeds);
+}
+EXPORT_SYMBOL(pcie_get_speed_cap);
+
+/**
+ * pcie_get_width_cap - query for the PCI device's link width capability
+ * @dev: PCI device to query
+ *
+ * Query the PCI device width capability.  Return the maximum link width
+ * supported by the device.
+ */
+enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev)
+{
+	u32 lnkcap;
+
+	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
+	if (lnkcap)
+		return FIELD_GET(PCI_EXP_LNKCAP_MLW, lnkcap);
+
+	return PCIE_LNK_WIDTH_UNKNOWN;
+}
+EXPORT_SYMBOL(pcie_get_width_cap);
+
+/**
+ * pcie_bandwidth_capable - calculate a PCI device's link bandwidth capability
+ * @dev: PCI device
+ * @speed: storage for link speed
+ * @width: storage for link width
+ *
+ * Calculate a PCI device's link bandwidth by querying for its link speed
+ * and width, multiplying them, and applying encoding overhead.  The result
+ * is in Mb/s, i.e., megabits/second of raw bandwidth.
+ */
+static u32 pcie_bandwidth_capable(struct pci_dev *dev,
+				  enum pci_bus_speed *speed,
+				  enum pcie_link_width *width)
+{
+	*speed = pcie_get_speed_cap(dev);
+	*width = pcie_get_width_cap(dev);
+
+	if (*speed == PCI_SPEED_UNKNOWN || *width == PCIE_LNK_WIDTH_UNKNOWN)
+		return 0;
+
+	return *width * PCIE_SPEED2MBS_ENC(*speed);
+}
+
+/**
+ * __pcie_print_link_status - Report the PCI device's link speed and width
+ * @dev: PCI device to query
+ * @verbose: Print info even when enough bandwidth is available
+ *
+ * If the available bandwidth at the device is less than the device is
+ * capable of, report the device's maximum possible bandwidth and the
+ * upstream link that limits its performance.  If @verbose, always print
+ * the available bandwidth, even if the device isn't constrained.
+ */
+static void __pcie_print_link_status(struct pci_dev *dev, bool verbose)
+{
+	enum pcie_link_width width, width_cap;
+	enum pci_bus_speed speed, speed_cap;
+	struct pci_dev *limiting_dev = NULL;
+	u32 bw_avail, bw_cap;
+	char *flit_mode = "";
+
+	bw_cap = pcie_bandwidth_capable(dev, &speed_cap, &width_cap);
+	bw_avail = pcie_bandwidth_available(dev, &limiting_dev, &speed, &width);
+
+	if (dev->bus && dev->bus->flit_mode)
+		flit_mode = ", in Flit mode";
+
+	if (bw_avail >= bw_cap && verbose)
+		pci_info(dev, "%u.%03u Gb/s available PCIe bandwidth (%s x%d link)%s\n",
+			 bw_cap / 1000, bw_cap % 1000,
+			 pci_speed_string(speed_cap), width_cap, flit_mode);
+	else if (bw_avail < bw_cap)
+		pci_info(dev, "%u.%03u Gb/s available PCIe bandwidth, limited by %s x%d link at %s (capable of %u.%03u Gb/s with %s x%d link)%s\n",
+			 bw_avail / 1000, bw_avail % 1000,
+			 pci_speed_string(speed), width,
+			 limiting_dev ? pci_name(limiting_dev) : "<unknown>",
+			 bw_cap / 1000, bw_cap % 1000,
+			 pci_speed_string(speed_cap), width_cap, flit_mode);
+}
+
+/**
+ * pcie_print_link_status - Report the PCI device's link speed and width
+ * @dev: PCI device to query
+ *
+ * Report the available bandwidth at the device.
+ */
+void pcie_print_link_status(struct pci_dev *dev)
+{
+	__pcie_print_link_status(dev, true);
+}
+EXPORT_SYMBOL(pcie_print_link_status);
+
+void pcie_report_downtraining(struct pci_dev *dev)
+{
+	if (!pci_is_pcie(dev))
+		return;
+
+	/* Look from the device up to avoid downstream ports with no devices */
+	if ((pci_pcie_type(dev) != PCI_EXP_TYPE_ENDPOINT) &&
+	    (pci_pcie_type(dev) != PCI_EXP_TYPE_LEG_END) &&
+	    (pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM))
+		return;
+
+	/* Multi-function PCIe devices share the same link/status */
+	if (PCI_FUNC(dev->devfn) != 0 || dev->is_virtfn)
+		return;
+
+	/* Print link status only if the device is constrained by the fabric */
+	__pcie_print_link_status(dev, false);
+}
+
+void pcie_update_link_speed(struct pci_bus *bus)
+{
+	struct pci_dev *bridge = bus->self;
+	u16 linksta, linksta2;
+
+	pcie_capability_read_word(bridge, PCI_EXP_LNKSTA, &linksta);
+	pcie_capability_read_word(bridge, PCI_EXP_LNKSTA2, &linksta2);
+	__pcie_update_link_speed(bus, linksta, linksta2);
+}
+EXPORT_SYMBOL_GPL(pcie_update_link_speed);
+
+static enum pci_bus_speed agp_speed(int agp3, int agpstat)
+{
+	int index = 0;
+
+	if (agpstat & 4)
+		index = 3;
+	else if (agpstat & 2)
+		index = 2;
+	else if (agpstat & 1)
+		index = 1;
+	else
+		goto out;
+
+	if (agp3) {
+		index += 2;
+		if (index == 5)
+			index = 0;
+	}
+
+ out:
+	return agp_speeds[index];
+}
+
+void pci_set_bus_speed(struct pci_bus *bus)
+{
+	struct pci_dev *bridge = bus->self;
+	int pos;
+
+	pos = pci_find_capability(bridge, PCI_CAP_ID_AGP);
+	if (!pos)
+		pos = pci_find_capability(bridge, PCI_CAP_ID_AGP3);
+	if (pos) {
+		u32 agpstat, agpcmd;
+
+		pci_read_config_dword(bridge, pos + PCI_AGP_STATUS, &agpstat);
+		bus->max_bus_speed = agp_speed(agpstat & 8, agpstat & 7);
+
+		pci_read_config_dword(bridge, pos + PCI_AGP_COMMAND, &agpcmd);
+		bus->cur_bus_speed = agp_speed(agpstat & 8, agpcmd & 7);
+	}
+
+	pos = pci_find_capability(bridge, PCI_CAP_ID_PCIX);
+	if (pos) {
+		u16 status;
+		enum pci_bus_speed max;
+
+		pci_read_config_word(bridge, pos + PCI_X_BRIDGE_SSTATUS,
+				     &status);
+
+		if (status & PCI_X_SSTATUS_533MHZ) {
+			max = PCI_SPEED_133MHz_PCIX_533;
+		} else if (status & PCI_X_SSTATUS_266MHZ) {
+			max = PCI_SPEED_133MHz_PCIX_266;
+		} else if (status & PCI_X_SSTATUS_133MHZ) {
+			if ((status & PCI_X_SSTATUS_VERS) == PCI_X_SSTATUS_V2)
+				max = PCI_SPEED_133MHz_PCIX_ECC;
+			else
+				max = PCI_SPEED_133MHz_PCIX;
+		} else {
+			max = PCI_SPEED_66MHz_PCIX;
+		}
+
+		bus->max_bus_speed = max;
+		bus->cur_bus_speed =
+			pcix_bus_speed[FIELD_GET(PCI_X_SSTATUS_FREQ, status)];
+
+		return;
+	}
+
+	if (pci_is_pcie(bridge)) {
+		u32 linkcap;
+
+		pcie_capability_read_dword(bridge, PCI_EXP_LNKCAP, &linkcap);
+		bus->max_bus_speed = pcie_link_speed[linkcap & PCI_EXP_LNKCAP_SLS];
+
+		pcie_update_link_speed(bus);
+	}
+}
+
+/**
+ * pcie_wait_for_link_status - Wait for link status change
+ * @pdev: Device whose link to wait for.
+ * @use_lt: Use the LT bit if TRUE, or the DLLLA bit if FALSE.
+ * @active: Waiting for active or inactive?
+ *
+ * Return 0 if successful, or -ETIMEDOUT if status has not changed within
+ * PCIE_LINK_RETRAIN_TIMEOUT_MS milliseconds.
+ */
+static int pcie_wait_for_link_status(struct pci_dev *pdev,
+				     bool use_lt, bool active)
+{
+	u16 lnksta_mask, lnksta_match;
+	unsigned long end_jiffies;
+	u16 lnksta;
+
+	lnksta_mask = use_lt ? PCI_EXP_LNKSTA_LT : PCI_EXP_LNKSTA_DLLLA;
+	lnksta_match = active ? lnksta_mask : 0;
+
+	end_jiffies = jiffies + msecs_to_jiffies(PCIE_LINK_RETRAIN_TIMEOUT_MS);
+	do {
+		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnksta);
+		if ((lnksta & lnksta_mask) == lnksta_match)
+			return 0;
+		msleep(1);
+	} while (time_before(jiffies, end_jiffies));
+
+	return -ETIMEDOUT;
+}
+
+/**
+ * pcie_retrain_link - Request a link retrain and wait for it to complete
+ * @pdev: Device whose link to retrain.
+ * @use_lt: Use the LT bit if TRUE, or the DLLLA bit if FALSE, for status.
+ *
+ * Retrain completion status is retrieved from the Link Status Register
+ * according to @use_lt.  It is not verified whether the use of the DLLLA
+ * bit is valid.
+ *
+ * Return 0 if successful, or -ETIMEDOUT if training has not completed
+ * within PCIE_LINK_RETRAIN_TIMEOUT_MS milliseconds.
+ */
+int pcie_retrain_link(struct pci_dev *pdev, bool use_lt)
+{
+	int rc;
+
+	/*
+	 * Ensure the updated LNKCTL parameters are used during link
+	 * training by checking that there is no ongoing link training that
+	 * may have started before link parameters were changed, so as to
+	 * avoid LTSSM race as recommended in Implementation Note at the end
+	 * of PCIe r6.1 sec 7.5.3.7.
+	 */
+	rc = pcie_wait_for_link_status(pdev, true, false);
+	if (rc)
+		return rc;
+
+	pcie_capability_set_word(pdev, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_RL);
+	if (pdev->clear_retrain_link) {
+		/*
+		 * Due to an erratum in some devices the Retrain Link bit
+		 * needs to be cleared again manually to allow the link
+		 * training to succeed.
+		 */
+		pcie_capability_clear_word(pdev, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_RL);
+	}
+
+	rc = pcie_wait_for_link_status(pdev, use_lt, !use_lt);
+
+	/*
+	 * Clear LBMS after a manual retrain so that the bit can be used
+	 * to track link speed or width changes made by hardware itself
+	 * in attempt to correct unreliable link operation.
+	 */
+	pcie_reset_lbms_count(pdev);
+	return rc;
+}
+
+/**
+ * pcie_wait_for_link_delay - Wait until link is active or inactive
+ * @pdev: Bridge device
+ * @active: waiting for active or inactive?
+ * @delay: Delay to wait after link has become active (in ms)
+ *
+ * Use this to wait till link becomes active or inactive.
+ */
+bool pcie_wait_for_link_delay(struct pci_dev *pdev, bool active, int delay)
+{
+	int rc;
+
+	/*
+	 * Some controllers might not implement link active reporting. In this
+	 * case, we wait for 1000 ms + any delay requested by the caller.
+	 */
+	if (!pdev->link_active_reporting) {
+		msleep(PCIE_LINK_RETRAIN_TIMEOUT_MS + delay);
+		return true;
+	}
+
+	/*
+	 * PCIe r4.0 sec 6.6.1, a component must enter LTSSM Detect within 20ms,
+	 * after which we should expect the link to be active if the reset was
+	 * successful. If so, software must wait a minimum 100ms before sending
+	 * configuration requests to devices downstream this port.
+	 *
+	 * If the link fails to activate, either the device was physically
+	 * removed or the link is permanently failed.
+	 */
+	if (active)
+		msleep(20);
+	rc = pcie_wait_for_link_status(pdev, false, active);
+	if (active) {
+		if (rc)
+			rc = pcie_failed_link_retrain(pdev);
+		if (rc)
+			return false;
+
+		msleep(delay);
+		return true;
+	}
+
+	if (rc)
+		return false;
+
+	return true;
+}
+
+/**
+ * pcie_wait_for_link - Wait until link is active or inactive
+ * @pdev: Bridge device
+ * @active: waiting for active or inactive?
+ *
+ * Use this to wait till link becomes active or inactive.
+ */
+bool pcie_wait_for_link(struct pci_dev *pdev, bool active)
+{
+	return pcie_wait_for_link_delay(pdev, active, 100);
+}
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 48c0b9f7fc89..56951fc493f0 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4414,145 +4414,6 @@ int pci_wait_for_pending_transaction(struct pci_dev *dev)
 }
 EXPORT_SYMBOL(pci_wait_for_pending_transaction);
 
-/**
- * pcie_wait_for_link_status - Wait for link status change
- * @pdev: Device whose link to wait for.
- * @use_lt: Use the LT bit if TRUE, or the DLLLA bit if FALSE.
- * @active: Waiting for active or inactive?
- *
- * Return 0 if successful, or -ETIMEDOUT if status has not changed within
- * PCIE_LINK_RETRAIN_TIMEOUT_MS milliseconds.
- */
-static int pcie_wait_for_link_status(struct pci_dev *pdev,
-				     bool use_lt, bool active)
-{
-	u16 lnksta_mask, lnksta_match;
-	unsigned long end_jiffies;
-	u16 lnksta;
-
-	lnksta_mask = use_lt ? PCI_EXP_LNKSTA_LT : PCI_EXP_LNKSTA_DLLLA;
-	lnksta_match = active ? lnksta_mask : 0;
-
-	end_jiffies = jiffies + msecs_to_jiffies(PCIE_LINK_RETRAIN_TIMEOUT_MS);
-	do {
-		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnksta);
-		if ((lnksta & lnksta_mask) == lnksta_match)
-			return 0;
-		msleep(1);
-	} while (time_before(jiffies, end_jiffies));
-
-	return -ETIMEDOUT;
-}
-
-/**
- * pcie_retrain_link - Request a link retrain and wait for it to complete
- * @pdev: Device whose link to retrain.
- * @use_lt: Use the LT bit if TRUE, or the DLLLA bit if FALSE, for status.
- *
- * Retrain completion status is retrieved from the Link Status Register
- * according to @use_lt.  It is not verified whether the use of the DLLLA
- * bit is valid.
- *
- * Return 0 if successful, or -ETIMEDOUT if training has not completed
- * within PCIE_LINK_RETRAIN_TIMEOUT_MS milliseconds.
- */
-int pcie_retrain_link(struct pci_dev *pdev, bool use_lt)
-{
-	int rc;
-
-	/*
-	 * Ensure the updated LNKCTL parameters are used during link
-	 * training by checking that there is no ongoing link training that
-	 * may have started before link parameters were changed, so as to
-	 * avoid LTSSM race as recommended in Implementation Note at the end
-	 * of PCIe r6.1 sec 7.5.3.7.
-	 */
-	rc = pcie_wait_for_link_status(pdev, true, false);
-	if (rc)
-		return rc;
-
-	pcie_capability_set_word(pdev, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_RL);
-	if (pdev->clear_retrain_link) {
-		/*
-		 * Due to an erratum in some devices the Retrain Link bit
-		 * needs to be cleared again manually to allow the link
-		 * training to succeed.
-		 */
-		pcie_capability_clear_word(pdev, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_RL);
-	}
-
-	rc = pcie_wait_for_link_status(pdev, use_lt, !use_lt);
-
-	/*
-	 * Clear LBMS after a manual retrain so that the bit can be used
-	 * to track link speed or width changes made by hardware itself
-	 * in attempt to correct unreliable link operation.
-	 */
-	pcie_reset_lbms_count(pdev);
-	return rc;
-}
-
-/**
- * pcie_wait_for_link_delay - Wait until link is active or inactive
- * @pdev: Bridge device
- * @active: waiting for active or inactive?
- * @delay: Delay to wait after link has become active (in ms)
- *
- * Use this to wait till link becomes active or inactive.
- */
-bool pcie_wait_for_link_delay(struct pci_dev *pdev, bool active, int delay)
-{
-	int rc;
-
-	/*
-	 * Some controllers might not implement link active reporting. In this
-	 * case, we wait for 1000 ms + any delay requested by the caller.
-	 */
-	if (!pdev->link_active_reporting) {
-		msleep(PCIE_LINK_RETRAIN_TIMEOUT_MS + delay);
-		return true;
-	}
-
-	/*
-	 * PCIe r4.0 sec 6.6.1, a component must enter LTSSM Detect within 20ms,
-	 * after which we should expect the link to be active if the reset was
-	 * successful. If so, software must wait a minimum 100ms before sending
-	 * configuration requests to devices downstream this port.
-	 *
-	 * If the link fails to activate, either the device was physically
-	 * removed or the link is permanently failed.
-	 */
-	if (active)
-		msleep(20);
-	rc = pcie_wait_for_link_status(pdev, false, active);
-	if (active) {
-		if (rc)
-			rc = pcie_failed_link_retrain(pdev);
-		if (rc)
-			return false;
-
-		msleep(delay);
-		return true;
-	}
-
-	if (rc)
-		return false;
-
-	return true;
-}
-
-/**
- * pcie_wait_for_link - Wait until link is active or inactive
- * @pdev: Bridge device
- * @active: waiting for active or inactive?
- *
- * Use this to wait till link becomes active or inactive.
- */
-bool pcie_wait_for_link(struct pci_dev *pdev, bool active)
-{
-	return pcie_wait_for_link_delay(pdev, active, 100);
-}
-
 void pci_dev_lock(struct pci_dev *dev)
 {
 	/* block PM suspend, driver probe, etc. */
@@ -4781,236 +4642,6 @@ int pcie_set_mps(struct pci_dev *dev, int mps)
 }
 EXPORT_SYMBOL(pcie_set_mps);
 
-static enum pci_bus_speed to_pcie_link_speed(u16 lnksta)
-{
-	return pcie_link_speed[FIELD_GET(PCI_EXP_LNKSTA_CLS, lnksta)];
-}
-
-int pcie_link_speed_mbps(struct pci_dev *pdev)
-{
-	u16 lnksta;
-	int err;
-
-	err = pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnksta);
-	if (err)
-		return err;
-
-	return pcie_dev_speed_mbps(to_pcie_link_speed(lnksta));
-}
-EXPORT_SYMBOL(pcie_link_speed_mbps);
-
-/**
- * pcie_bandwidth_available - determine minimum link settings of a PCIe
- *			      device and its bandwidth limitation
- * @dev: PCI device to query
- * @limiting_dev: storage for device causing the bandwidth limitation
- * @speed: storage for speed of limiting device
- * @width: storage for width of limiting device
- *
- * Walk up the PCI device chain and find the point where the minimum
- * bandwidth is available.  Return the bandwidth available there and (if
- * limiting_dev, speed, and width pointers are supplied) information about
- * that point.  The bandwidth returned is in Mb/s, i.e., megabits/second of
- * raw bandwidth.
- */
-u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
-			     enum pci_bus_speed *speed,
-			     enum pcie_link_width *width)
-{
-	u16 lnksta;
-	enum pci_bus_speed next_speed;
-	enum pcie_link_width next_width;
-	u32 bw, next_bw;
-
-	if (speed)
-		*speed = PCI_SPEED_UNKNOWN;
-	if (width)
-		*width = PCIE_LNK_WIDTH_UNKNOWN;
-
-	bw = 0;
-
-	while (dev) {
-		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
-
-		next_speed = to_pcie_link_speed(lnksta);
-		next_width = FIELD_GET(PCI_EXP_LNKSTA_NLW, lnksta);
-
-		next_bw = next_width * PCIE_SPEED2MBS_ENC(next_speed);
-
-		/* Check if current device limits the total bandwidth */
-		if (!bw || next_bw <= bw) {
-			bw = next_bw;
-
-			if (limiting_dev)
-				*limiting_dev = dev;
-			if (speed)
-				*speed = next_speed;
-			if (width)
-				*width = next_width;
-		}
-
-		dev = pci_upstream_bridge(dev);
-	}
-
-	return bw;
-}
-EXPORT_SYMBOL(pcie_bandwidth_available);
-
-/**
- * pcie_get_supported_speeds - query Supported Link Speed Vector
- * @dev: PCI device to query
- *
- * Query @dev supported link speeds.
- *
- * Implementation Note in PCIe r6.0 sec 7.5.3.18 recommends determining
- * supported link speeds using the Supported Link Speeds Vector in the Link
- * Capabilities 2 Register (when available).
- *
- * Link Capabilities 2 was added in PCIe r3.0, sec 7.8.18.
- *
- * Without Link Capabilities 2, i.e., prior to PCIe r3.0, Supported Link
- * Speeds field in Link Capabilities is used and only 2.5 GT/s and 5.0 GT/s
- * speeds were defined.
- *
- * For @dev without Supported Link Speed Vector, the field is synthesized
- * from the Max Link Speed field in the Link Capabilities Register.
- *
- * Return: Supported Link Speeds Vector (+ reserved 0 at LSB).
- */
-u8 pcie_get_supported_speeds(struct pci_dev *dev)
-{
-	u32 lnkcap2, lnkcap;
-	u8 speeds;
-
-	/*
-	 * Speeds retain the reserved 0 at LSB before PCIe Supported Link
-	 * Speeds Vector to allow using SLS Vector bit defines directly.
-	 */
-	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP2, &lnkcap2);
-	speeds = lnkcap2 & PCI_EXP_LNKCAP2_SLS;
-
-	/* Ignore speeds higher than Max Link Speed */
-	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
-	speeds &= GENMASK(lnkcap & PCI_EXP_LNKCAP_SLS, 0);
-
-	/* PCIe r3.0-compliant */
-	if (speeds)
-		return speeds;
-
-	/* Synthesize from the Max Link Speed field */
-	if ((lnkcap & PCI_EXP_LNKCAP_SLS) == PCI_EXP_LNKCAP_SLS_5_0GB)
-		speeds = PCI_EXP_LNKCAP2_SLS_5_0GB | PCI_EXP_LNKCAP2_SLS_2_5GB;
-	else if ((lnkcap & PCI_EXP_LNKCAP_SLS) == PCI_EXP_LNKCAP_SLS_2_5GB)
-		speeds = PCI_EXP_LNKCAP2_SLS_2_5GB;
-
-	return speeds;
-}
-
-/**
- * pcie_get_speed_cap - query for the PCI device's link speed capability
- * @dev: PCI device to query
- *
- * Query the PCI device speed capability.
- *
- * Return: the maximum link speed supported by the device.
- */
-enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev)
-{
-	return PCIE_LNKCAP2_SLS2SPEED(dev->supported_speeds);
-}
-EXPORT_SYMBOL(pcie_get_speed_cap);
-
-/**
- * pcie_get_width_cap - query for the PCI device's link width capability
- * @dev: PCI device to query
- *
- * Query the PCI device width capability.  Return the maximum link width
- * supported by the device.
- */
-enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev)
-{
-	u32 lnkcap;
-
-	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
-	if (lnkcap)
-		return FIELD_GET(PCI_EXP_LNKCAP_MLW, lnkcap);
-
-	return PCIE_LNK_WIDTH_UNKNOWN;
-}
-EXPORT_SYMBOL(pcie_get_width_cap);
-
-/**
- * pcie_bandwidth_capable - calculate a PCI device's link bandwidth capability
- * @dev: PCI device
- * @speed: storage for link speed
- * @width: storage for link width
- *
- * Calculate a PCI device's link bandwidth by querying for its link speed
- * and width, multiplying them, and applying encoding overhead.  The result
- * is in Mb/s, i.e., megabits/second of raw bandwidth.
- */
-static u32 pcie_bandwidth_capable(struct pci_dev *dev,
-				  enum pci_bus_speed *speed,
-				  enum pcie_link_width *width)
-{
-	*speed = pcie_get_speed_cap(dev);
-	*width = pcie_get_width_cap(dev);
-
-	if (*speed == PCI_SPEED_UNKNOWN || *width == PCIE_LNK_WIDTH_UNKNOWN)
-		return 0;
-
-	return *width * PCIE_SPEED2MBS_ENC(*speed);
-}
-
-/**
- * __pcie_print_link_status - Report the PCI device's link speed and width
- * @dev: PCI device to query
- * @verbose: Print info even when enough bandwidth is available
- *
- * If the available bandwidth at the device is less than the device is
- * capable of, report the device's maximum possible bandwidth and the
- * upstream link that limits its performance.  If @verbose, always print
- * the available bandwidth, even if the device isn't constrained.
- */
-void __pcie_print_link_status(struct pci_dev *dev, bool verbose)
-{
-	enum pcie_link_width width, width_cap;
-	enum pci_bus_speed speed, speed_cap;
-	struct pci_dev *limiting_dev = NULL;
-	u32 bw_avail, bw_cap;
-	char *flit_mode = "";
-
-	bw_cap = pcie_bandwidth_capable(dev, &speed_cap, &width_cap);
-	bw_avail = pcie_bandwidth_available(dev, &limiting_dev, &speed, &width);
-
-	if (dev->bus && dev->bus->flit_mode)
-		flit_mode = ", in Flit mode";
-
-	if (bw_avail >= bw_cap && verbose)
-		pci_info(dev, "%u.%03u Gb/s available PCIe bandwidth (%s x%d link)%s\n",
-			 bw_cap / 1000, bw_cap % 1000,
-			 pci_speed_string(speed_cap), width_cap, flit_mode);
-	else if (bw_avail < bw_cap)
-		pci_info(dev, "%u.%03u Gb/s available PCIe bandwidth, limited by %s x%d link at %s (capable of %u.%03u Gb/s with %s x%d link)%s\n",
-			 bw_avail / 1000, bw_avail % 1000,
-			 pci_speed_string(speed), width,
-			 limiting_dev ? pci_name(limiting_dev) : "<unknown>",
-			 bw_cap / 1000, bw_cap % 1000,
-			 pci_speed_string(speed_cap), width_cap, flit_mode);
-}
-
-/**
- * pcie_print_link_status - Report the PCI device's link speed and width
- * @dev: PCI device to query
- *
- * Report the available bandwidth at the device.
- */
-void pcie_print_link_status(struct pci_dev *dev)
-{
-	__pcie_print_link_status(dev, true);
-}
-EXPORT_SYMBOL(pcie_print_link_status);
-
 /**
  * pci_select_bars - Make BAR mask from the type of resource
  * @dev: the PCI device for which BAR mask is made
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index fece1bbf690e..649a8fd7d713 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -13,7 +13,6 @@ struct pcie_tlp_log;
 
 #define PCI_VSEC_ID_INTEL_TBT	0x1234	/* Thunderbolt */
 
-#define PCIE_LINK_RETRAIN_TIMEOUT_MS	1000
 
 /*
  * Power stable to PERST# inactive.
@@ -450,7 +449,6 @@ static inline int pcie_dev_speed_mbps(enum pci_bus_speed speed)
 
 u8 pcie_get_supported_speeds(struct pci_dev *dev);
 const char *pci_speed_string(enum pci_bus_speed speed);
-void __pcie_print_link_status(struct pci_dev *dev, bool verbose);
 void pcie_report_downtraining(struct pci_dev *dev);
 
 static inline void __pcie_update_link_speed(struct pci_bus *bus, u16 linksta, u16 linksta2)
@@ -459,6 +457,7 @@ static inline void __pcie_update_link_speed(struct pci_bus *bus, u16 linksta, u1
 	bus->flit_mode = (linksta2 & PCI_EXP_LNKSTA2_FLIT) ? 1 : 0;
 }
 void pcie_update_link_speed(struct pci_bus *bus);
+void pci_set_bus_speed(struct pci_bus *bus);
 
 /* Single Root I/O Virtualization */
 struct pci_sriov {
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 364fa2a514f8..515e8afe9532 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -710,181 +710,6 @@ void pci_free_host_bridge(struct pci_host_bridge *bridge)
 EXPORT_SYMBOL(pci_free_host_bridge);
 
 /* Indexed by PCI_X_SSTATUS_FREQ (secondary bus mode and frequency) */
-static const unsigned char pcix_bus_speed[] = {
-	PCI_SPEED_UNKNOWN,		/* 0 */
-	PCI_SPEED_66MHz_PCIX,		/* 1 */
-	PCI_SPEED_100MHz_PCIX,		/* 2 */
-	PCI_SPEED_133MHz_PCIX,		/* 3 */
-	PCI_SPEED_UNKNOWN,		/* 4 */
-	PCI_SPEED_66MHz_PCIX_ECC,	/* 5 */
-	PCI_SPEED_100MHz_PCIX_ECC,	/* 6 */
-	PCI_SPEED_133MHz_PCIX_ECC,	/* 7 */
-	PCI_SPEED_UNKNOWN,		/* 8 */
-	PCI_SPEED_66MHz_PCIX_266,	/* 9 */
-	PCI_SPEED_100MHz_PCIX_266,	/* A */
-	PCI_SPEED_133MHz_PCIX_266,	/* B */
-	PCI_SPEED_UNKNOWN,		/* C */
-	PCI_SPEED_66MHz_PCIX_533,	/* D */
-	PCI_SPEED_100MHz_PCIX_533,	/* E */
-	PCI_SPEED_133MHz_PCIX_533	/* F */
-};
-
-/* Indexed by PCI_EXP_LNKCAP_SLS, PCI_EXP_LNKSTA_CLS */
-const unsigned char pcie_link_speed[] = {
-	PCI_SPEED_UNKNOWN,		/* 0 */
-	PCIE_SPEED_2_5GT,		/* 1 */
-	PCIE_SPEED_5_0GT,		/* 2 */
-	PCIE_SPEED_8_0GT,		/* 3 */
-	PCIE_SPEED_16_0GT,		/* 4 */
-	PCIE_SPEED_32_0GT,		/* 5 */
-	PCIE_SPEED_64_0GT,		/* 6 */
-	PCI_SPEED_UNKNOWN,		/* 7 */
-	PCI_SPEED_UNKNOWN,		/* 8 */
-	PCI_SPEED_UNKNOWN,		/* 9 */
-	PCI_SPEED_UNKNOWN,		/* A */
-	PCI_SPEED_UNKNOWN,		/* B */
-	PCI_SPEED_UNKNOWN,		/* C */
-	PCI_SPEED_UNKNOWN,		/* D */
-	PCI_SPEED_UNKNOWN,		/* E */
-	PCI_SPEED_UNKNOWN		/* F */
-};
-EXPORT_SYMBOL_GPL(pcie_link_speed);
-
-const char *pci_speed_string(enum pci_bus_speed speed)
-{
-	/* Indexed by the pci_bus_speed enum */
-	static const char *speed_strings[] = {
-	    "33 MHz PCI",		/* 0x00 */
-	    "66 MHz PCI",		/* 0x01 */
-	    "66 MHz PCI-X",		/* 0x02 */
-	    "100 MHz PCI-X",		/* 0x03 */
-	    "133 MHz PCI-X",		/* 0x04 */
-	    NULL,			/* 0x05 */
-	    NULL,			/* 0x06 */
-	    NULL,			/* 0x07 */
-	    NULL,			/* 0x08 */
-	    "66 MHz PCI-X 266",		/* 0x09 */
-	    "100 MHz PCI-X 266",	/* 0x0a */
-	    "133 MHz PCI-X 266",	/* 0x0b */
-	    "Unknown AGP",		/* 0x0c */
-	    "1x AGP",			/* 0x0d */
-	    "2x AGP",			/* 0x0e */
-	    "4x AGP",			/* 0x0f */
-	    "8x AGP",			/* 0x10 */
-	    "66 MHz PCI-X 533",		/* 0x11 */
-	    "100 MHz PCI-X 533",	/* 0x12 */
-	    "133 MHz PCI-X 533",	/* 0x13 */
-	    "2.5 GT/s PCIe",		/* 0x14 */
-	    "5.0 GT/s PCIe",		/* 0x15 */
-	    "8.0 GT/s PCIe",		/* 0x16 */
-	    "16.0 GT/s PCIe",		/* 0x17 */
-	    "32.0 GT/s PCIe",		/* 0x18 */
-	    "64.0 GT/s PCIe",		/* 0x19 */
-	};
-
-	if (speed < ARRAY_SIZE(speed_strings))
-		return speed_strings[speed];
-	return "Unknown";
-}
-EXPORT_SYMBOL_GPL(pci_speed_string);
-
-void pcie_update_link_speed(struct pci_bus *bus)
-{
-	struct pci_dev *bridge = bus->self;
-	u16 linksta, linksta2;
-
-	pcie_capability_read_word(bridge, PCI_EXP_LNKSTA, &linksta);
-	pcie_capability_read_word(bridge, PCI_EXP_LNKSTA2, &linksta2);
-	__pcie_update_link_speed(bus, linksta, linksta2);
-}
-EXPORT_SYMBOL_GPL(pcie_update_link_speed);
-
-static unsigned char agp_speeds[] = {
-	AGP_UNKNOWN,
-	AGP_1X,
-	AGP_2X,
-	AGP_4X,
-	AGP_8X
-};
-
-static enum pci_bus_speed agp_speed(int agp3, int agpstat)
-{
-	int index = 0;
-
-	if (agpstat & 4)
-		index = 3;
-	else if (agpstat & 2)
-		index = 2;
-	else if (agpstat & 1)
-		index = 1;
-	else
-		goto out;
-
-	if (agp3) {
-		index += 2;
-		if (index == 5)
-			index = 0;
-	}
-
- out:
-	return agp_speeds[index];
-}
-
-static void pci_set_bus_speed(struct pci_bus *bus)
-{
-	struct pci_dev *bridge = bus->self;
-	int pos;
-
-	pos = pci_find_capability(bridge, PCI_CAP_ID_AGP);
-	if (!pos)
-		pos = pci_find_capability(bridge, PCI_CAP_ID_AGP3);
-	if (pos) {
-		u32 agpstat, agpcmd;
-
-		pci_read_config_dword(bridge, pos + PCI_AGP_STATUS, &agpstat);
-		bus->max_bus_speed = agp_speed(agpstat & 8, agpstat & 7);
-
-		pci_read_config_dword(bridge, pos + PCI_AGP_COMMAND, &agpcmd);
-		bus->cur_bus_speed = agp_speed(agpstat & 8, agpcmd & 7);
-	}
-
-	pos = pci_find_capability(bridge, PCI_CAP_ID_PCIX);
-	if (pos) {
-		u16 status;
-		enum pci_bus_speed max;
-
-		pci_read_config_word(bridge, pos + PCI_X_BRIDGE_SSTATUS,
-				     &status);
-
-		if (status & PCI_X_SSTATUS_533MHZ) {
-			max = PCI_SPEED_133MHz_PCIX_533;
-		} else if (status & PCI_X_SSTATUS_266MHZ) {
-			max = PCI_SPEED_133MHz_PCIX_266;
-		} else if (status & PCI_X_SSTATUS_133MHZ) {
-			if ((status & PCI_X_SSTATUS_VERS) == PCI_X_SSTATUS_V2)
-				max = PCI_SPEED_133MHz_PCIX_ECC;
-			else
-				max = PCI_SPEED_133MHz_PCIX;
-		} else {
-			max = PCI_SPEED_66MHz_PCIX;
-		}
-
-		bus->max_bus_speed = max;
-		bus->cur_bus_speed =
-			pcix_bus_speed[FIELD_GET(PCI_X_SSTATUS_FREQ, status)];
-
-		return;
-	}
-
-	if (pci_is_pcie(bridge)) {
-		u32 linkcap;
-
-		pcie_capability_read_dword(bridge, PCI_EXP_LNKCAP, &linkcap);
-		bus->max_bus_speed = pcie_link_speed[linkcap & PCI_EXP_LNKCAP_SLS];
-
-		pcie_update_link_speed(bus);
-	}
-}
 
 static struct irq_domain *pci_host_bridge_msi_domain(struct pci_bus *bus)
 {
@@ -2576,25 +2401,6 @@ static struct pci_dev *pci_scan_device(struct pci_bus *bus, int devfn)
 	return dev;
 }
 
-void pcie_report_downtraining(struct pci_dev *dev)
-{
-	if (!pci_is_pcie(dev))
-		return;
-
-	/* Look from the device up to avoid downstream ports with no devices */
-	if ((pci_pcie_type(dev) != PCI_EXP_TYPE_ENDPOINT) &&
-	    (pci_pcie_type(dev) != PCI_EXP_TYPE_LEG_END) &&
-	    (pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM))
-		return;
-
-	/* Multi-function PCIe devices share the same link/status */
-	if (PCI_FUNC(dev->devfn) != 0 || dev->is_virtfn)
-		return;
-
-	/* Print link status only if the device is constrained by the fabric */
-	__pcie_print_link_status(dev, false);
-}
-
 static void pci_init_capabilities(struct pci_dev *dev)
 {
 	pci_ea_init(dev);		/* Enhanced Allocation */
-- 
2.39.5


