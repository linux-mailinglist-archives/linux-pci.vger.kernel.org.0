Return-Path: <linux-pci+bounces-14057-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 435519965FE
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 11:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD6EE1F2580C
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 09:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A629B18B48B;
	Wed,  9 Oct 2024 09:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X+iICrd8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD9F18B472;
	Wed,  9 Oct 2024 09:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728467583; cv=none; b=Rul4A/5SvWvP76sHcB7L2JHqb7nwrj277W8lGbFEA0kxuFCuwWYzOyyWIq90XftToGMZARRuQo81asPmBiiys6U5eKkfSv5oJZMWyi0vsdPv5MktGUWGdMk2p2BHVa0nItrV39FallKxYlBngGg1inJFdsmyG0boXV17TeTv05M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728467583; c=relaxed/simple;
	bh=DPnc1fi/Miq14chejWMvakLKQuUVitxVsXIQ2PVm3wQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mLm3M0rf0lcOc31hVhis7Ep3hW4giqzIUZvcSY8hWtXmAVCUrEisLHmpKAFJvv8pjHr8mFwtj8N/E3blHM8K6jnY2ZpHdKDR5IaiUimNsuth8M3cJjNdmfVONnZXzh3NPSOGiy7SrtkYMCSTP4NBinGGO6U0WLQctgy6rcYIOxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X+iICrd8; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728467582; x=1760003582;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DPnc1fi/Miq14chejWMvakLKQuUVitxVsXIQ2PVm3wQ=;
  b=X+iICrd8nd5ExWySqsnYkqEcJt36B86yZRAkM/iV/52jefcbSq2CTilm
   witkx6s8M4e0BJFFUSwsHd2h9t9fmfAIQpUvZcmyCRxWTReh7ehkaP/fZ
   LkZoPlTNI/jAPIy9kgzLp70tIIrNl7dLpuHBdgY3pCOj2a3TIU/N5LGIb
   3iFq9COAPd7MngFpllSztxmsM+LDBYeOefwqGOQ0YzQPLXQGQm8dP51lQ
   v8Nv3yekUx9aXx14I1oMPfyUbJmwMoceXm2FvqBYMN1Y/W21riyHAGvfX
   VAZmDrIcfe3fvOxhQWnddk4Wqqz57BvpbYJIW3zmARl2UpHLL4eLBmMy7
   Q==;
X-CSE-ConnectionGUID: VfwiCl+RQQyHWTfK2+v2DA==
X-CSE-MsgGUID: 0Kb7uHHKQ0G/cl5gqInyjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="38322508"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="38322508"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 02:53:01 -0700
X-CSE-ConnectionGUID: ge/ag1YbQD+6f4fklORFjQ==
X-CSE-MsgGUID: MbokNGl4Qb2JcF7Zcix+VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="76506766"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.41])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 02:52:56 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
	Lukas Wunner <lukas@wunner.de>,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	linux-kernel@vger.kernel.org
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Amit Kucheria <amitk@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v8 2/8] PCI: Store all PCIe Supported Link Speeds
Date: Wed,  9 Oct 2024 12:52:17 +0300
Message-Id: <20241009095223.7093-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241009095223.7093-1-ilpo.jarvinen@linux.intel.com>
References: <20241009095223.7093-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

PCIe bandwidth controller added by a subsequent commit will require
selecting PCIe Link Speeds that are lower than the Maximum Link Speed.

The struct pci_bus only stores max_bus_speed. Even if PCIe r6.1 sec
8.2.1 currently disallows gaps in supported Link Speeds, the
Implementation Note in PCIe r6.1 sec 7.5.3.18, recommends determining
supported Link Speeds using the Supported Link Speeds Vector in the
Link Capabilities 2 Register (when available) to "avoid software being
confused if a future specification defines Links that do not require
support for all slower speeds."

Reuse code in pcie_get_speed_cap() to add pcie_get_supported_speeds()
to query the Supported Link Speeds Vector of a PCIe device. The value
is taken directly from the Supported Link Speeds Vector or synthetized
from the Max Link Speed in the Link Capabilities Register when the Link
Capabilities 2 Register is not available.

The Supported Link Speeds Vector in the Link Capabilities Register 2
corresponds to the bus below on Root Ports and Downstream Ports,
whereas it corresponds to the bus above on Upstream Ports and
Endpoints (PCIe r6.1 sec 7.5.3.18):

	"Supported Link Speeds Vector - This field indicates the
	supported Link speed(s) of the associated Port."

Add supported_speeds into the struct pci_dev that caches the
Supported Link Speeds Vector.

supported_speeds contains a set of Link Speeds only in the case where
PCIe Link Speed can be determined. The Root Complex Integrated
Endpoints do not have a well-defined Link Speed because they do not
seem to implement either of the Link Capabilities Registers, which is
allowed by PCIe r6.1 sec 7.5.3 (the same limitation applies to
determining cur_bus_speed and max_bus_speed that are PCI_SPEED_UNKNOWN
in such case). This is of no concern from PCIe bandwidth controller
point of view because such devices are not attached into a PCIe Root
Port that could be controlled.

supported_speeds field keeps the extra reserved zero at the least
significant bit to match the Link Capabilities 2 Register layouting.

An attempt was made to store supported_speeds field into the struct
pci_bus as an intersection of the both ends of the Link, however, the
subordinate struct pci_bus is not available early enough. The Target
Speed quirk (in pcie_failed_link_retrain()) can run either during
initial scan or later requiring it to use the API PCIe bandwidth
controller provides to set the Target Link Speed in order to co-exist
with the bandwidth controller. When the Target Speed quirk is calling
the bandwidth controller during initial scan, the struct pci_bus is not
yet initialized. As such, storing supported_speeds into the struct
pci_bus is not viable.

Suggested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pci.c             | 58 ++++++++++++++++++++++++-----------
 drivers/pci/probe.c           |  3 ++
 include/linux/pci.h           | 11 ++++++-
 include/uapi/linux/pci_regs.h |  1 +
 4 files changed, 54 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7d85c04fbba2..b28ab4761b18 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6189,38 +6189,60 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
 EXPORT_SYMBOL(pcie_bandwidth_available);
 
 /**
- * pcie_get_speed_cap - query for the PCI device's link speed capability
+ * pcie_get_supported_speeds - query Supported Link Speed Vector
  * @dev: PCI device to query
  *
- * Query the PCI device speed capability.  Return the maximum link speed
- * supported by the device.
+ * Query @dev supported link speeds.
+ *
+ * Implementation Note in PCIe r6.0.1 sec 7.5.3.18 recommends determining
+ * supported link speeds using the Supported Link Speeds Vector in the Link
+ * Capabilities 2 Register (when available).
+ *
+ * Link Capabilities 2 was added in PCIe r3.0, sec 7.8.18.
+ *
+ * Without Link Capabilities 2, i.e., prior to PCIe r3.0, Supported Link
+ * Speeds field in Link Capabilities is used and only 2.5 GT/s and 5.0 GT/s
+ * speeds were defined.
+ *
+ * For @dev without Supported Link Speed Vector, the field is synthetized
+ * from the Max Link Speed field in the Link Capabilities Register.
+ *
+ * Return: Supported Link Speeds Vector
  */
-enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev)
+u8 pcie_get_supported_speeds(struct pci_dev *dev)
 {
 	u32 lnkcap2, lnkcap;
+	u8 speeds;
 
-	/*
-	 * Link Capabilities 2 was added in PCIe r3.0, sec 7.8.18.  The
-	 * implementation note there recommends using the Supported Link
-	 * Speeds Vector in Link Capabilities 2 when supported.
-	 *
-	 * Without Link Capabilities 2, i.e., prior to PCIe r3.0, software
-	 * should use the Supported Link Speeds field in Link Capabilities,
-	 * where only 2.5 GT/s and 5.0 GT/s speeds were defined.
-	 */
 	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP2, &lnkcap2);
+	speeds = lnkcap2 & PCI_EXP_LNKCAP2_SLS;
 
 	/* PCIe r3.0-compliant */
-	if (lnkcap2)
-		return PCIE_LNKCAP2_SLS2SPEED(lnkcap2);
+	if (speeds)
+		return speeds;
 
 	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
+
+	/* Synthetize from the Max Link Speed field */
 	if ((lnkcap & PCI_EXP_LNKCAP_SLS) == PCI_EXP_LNKCAP_SLS_5_0GB)
-		return PCIE_SPEED_5_0GT;
+		speeds = PCI_EXP_LNKCAP2_SLS_5_0GB | PCI_EXP_LNKCAP2_SLS_2_5GB;
 	else if ((lnkcap & PCI_EXP_LNKCAP_SLS) == PCI_EXP_LNKCAP_SLS_2_5GB)
-		return PCIE_SPEED_2_5GT;
+		speeds = PCI_EXP_LNKCAP2_SLS_2_5GB;
+
+	return speeds;
+}
 
-	return PCI_SPEED_UNKNOWN;
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
 }
 EXPORT_SYMBOL(pcie_get_speed_cap);
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 4f68414c3086..af153a8e8225 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1947,6 +1947,9 @@ int pci_setup_device(struct pci_dev *dev)
 
 	set_pcie_untrusted(dev);
 
+	if (pci_is_pcie(dev))
+		dev->supported_speeds = pcie_get_supported_speeds(dev);
+
 	/* "Unknown power state" */
 	dev->current_state = PCI_UNKNOWN;
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index be5ed534c39c..a02b77fe7865 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -303,6 +303,7 @@ enum pci_bus_speed {
 	PCI_SPEED_UNKNOWN		= 0xff,
 };
 
+u8 pcie_get_supported_speeds(struct pci_dev *dev);
 enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev);
 enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev);
 
@@ -318,7 +319,14 @@ struct pci_sriov;
 struct pci_p2pdma;
 struct rcec_ea;
 
-/* The pci_dev structure describes PCI devices */
+/* struct pci_dev - describes a PCI device
+ *
+ * @supported_speeds:	PCIe Supported Link Speeds Vector (+ reserved 0 at
+ *			LSB). 0 when the supported speeds cannot be
+ *			determined (e.g., for Root Complex Integrated
+ *			Endpoints without the relevant Capability
+ *			Registers).
+ */
 struct pci_dev {
 	struct list_head bus_list;	/* Node in per-bus list */
 	struct pci_bus	*bus;		/* Bus this device is on */
@@ -522,6 +530,7 @@ struct pci_dev {
 	struct npem	*npem;		/* Native PCIe Enclosure Management */
 #endif
 	u16		acs_cap;	/* ACS Capability offset */
+	u8		supported_speeds; /* Supported Link Speeds Vector */
 	phys_addr_t	rom;		/* Physical address if not from BAR */
 	size_t		romlen;		/* Length if not from BAR */
 	/*
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 12323b3334a9..f3c9de0a497c 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -678,6 +678,7 @@
 #define PCI_EXP_DEVSTA2		0x2a	/* Device Status 2 */
 #define PCI_CAP_EXP_RC_ENDPOINT_SIZEOF_V2 0x2c	/* end of v2 EPs w/o link */
 #define PCI_EXP_LNKCAP2		0x2c	/* Link Capabilities 2 */
+#define  PCI_EXP_LNKCAP2_SLS		0x000000fe /* Supported Link Speeds Vector */
 #define  PCI_EXP_LNKCAP2_SLS_2_5GB	0x00000002 /* Supported Speed 2.5GT/s */
 #define  PCI_EXP_LNKCAP2_SLS_5_0GB	0x00000004 /* Supported Speed 5GT/s */
 #define  PCI_EXP_LNKCAP2_SLS_8_0GB	0x00000008 /* Supported Speed 8GT/s */
-- 
2.39.5


