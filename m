Return-Path: <linux-pci+bounces-11671-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE68C951AD3
	for <lists+linux-pci@lfdr.de>; Wed, 14 Aug 2024 14:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 299FAB21F07
	for <lists+linux-pci@lfdr.de>; Wed, 14 Aug 2024 12:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9631C1A00F3;
	Wed, 14 Aug 2024 12:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="duvx8Jj3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC1C1B0111
	for <linux-pci@vger.kernel.org>; Wed, 14 Aug 2024 12:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723638491; cv=none; b=esqprrtcqALm7UBrf2uoflIjUo8P+IdHBPi75hOhfFh9q5Y6z5C2gwZhcVGKPLaoKVEr1D/24zoxGIyiv1XWW65q3QHQuVOPizgSNugNmaqEx2oZmf5DD6dOWFmsvZCTXBhNtTIC5mlF3myXc/k+VdVb3vfpvu7bzC3lqzo+Mwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723638491; c=relaxed/simple;
	bh=J/VdIvr/5t5Dsc3rEUeR2k5gEMxNSR8smgFYF55IECo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FrBHWCUWQcP9oPlcpi+UfWUcYefp1nHI506KZ0K9wc5AL4cnhXplPtsQCuDsb4552wNnvIZlEFXEmdsijDmkirIz4w9968lFpM3cxEc22stMarxLfAzSCnD87Y7ylpXSxNvBQotK6Fr102dJqp2q/8F52IuvaOtPexysziT5eus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=duvx8Jj3; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723638490; x=1755174490;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J/VdIvr/5t5Dsc3rEUeR2k5gEMxNSR8smgFYF55IECo=;
  b=duvx8Jj3lWdneoWm6pkfTbVEdzkBaNMaqyqNjzl/IPUiAGoyueoeI+Zk
   55vhM3SATs2KaLWkRDJQ8/rZw09OQcFiOagUqPMif9EATyqgM/Y05j/fx
   xCT747cQ/b8CMdx9YLeesjkQc3NDHu5veNFPYGlLapt+EALneHgCwS5mf
   UVZdqKQOAhS2e9ii3gM0tUVXBE8UXIMJlRgoIQT/ABGAxLDLbA9B2lcyo
   eNRXv7WyZ22oTnlJ6HGc+gRWXvPatK5eadG26IPtvz5A/dDYxxNsHw+04
   cC0eGqGtfPUoTgkhFCpNk/s/QxrMui8pF94MBg6QijOTERBd8xzdsnIYx
   A==;
X-CSE-ConnectionGUID: z+aszE9ySteGyz7O+tmPFg==
X-CSE-MsgGUID: LUJmQzR7QYeFY2vkFAnrVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="33256506"
X-IronPort-AV: E=Sophos;i="6.10,145,1719903600"; 
   d="scan'208";a="33256506"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 05:28:09 -0700
X-CSE-ConnectionGUID: osnyL4siT8Snf+vPZ03NmA==
X-CSE-MsgGUID: 5uDUJZDrQJOxxECii9es5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,145,1719903600"; 
   d="scan'208";a="82233018"
Received: from mtkaczyk-dev.igk.intel.com ([10.102.108.41])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 05:28:06 -0700
From: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To: linux-pci@vger.kernel.org
Cc: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Christoph Hellwig <hch@lst.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Stuart Hayes <stuart.w.hayes@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Keith Busch <kbusch@kernel.org>,
	Marek Behun <marek.behun@nic.cz>,
	Pavel Machek <pavel@ucw.cz>,
	Randy Dunlap <rdunlap@infradead.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v6 3/3] PCI/NPEM: Add _DSM PCIe SSD status LED management
Date: Wed, 14 Aug 2024 14:29:00 +0200
Message-Id: <20240814122900.13525-4-mariusz.tkaczyk@linux.intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240814122900.13525-1-mariusz.tkaczyk@linux.intel.com>
References: <20240814122900.13525-1-mariusz.tkaczyk@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Device Specific Method PCIe SSD Status LED Management (_DSM) defined in
PCI Firmware Spec r3.3 sec 4.7 provides a way to manage LEDs via ACPI.

The design is similar to NPEM defined in PCIe Base Specification r6.1
sec 6.28:
  - both standards are indication oriented,
  - _DSM supported bits are corresponding to NPEM capability
    register bits
  - _DSM control bits are corresponding to NPEM control register
    bits.

_DSM does not support enclosure specific indications and special NPEM
commands NPEM_ENABLE and NPEM_RESET.

_DSM is implemented as a second op in NPEM driver. The standard used
in background is not presented to user. The interface is accessed same
as NPEM.

According to spec, _DSM has higher priority and availability  of _DSM
in not limited to devices with NPEM support. It is followed in
implementation.

Link: https://members.pcisig.com/wg/PCI-SIG/document/14025
Link: https://members.pcisig.com/wg/PCI-SIG/document/15350
Suggested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
Signed-off-by: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
---
 Documentation/ABI/testing/sysfs-bus-pci |   9 ++
 drivers/pci/npem.c                      | 147 +++++++++++++++++++++++-
 2 files changed, 153 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index a2768b24678e..078dd65029a8 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -563,3 +563,12 @@ Description:
 		indication is usually presented as one or two LEDs blinking at
 		4 Hz frequency:
 		https://en.wikipedia.org/wiki/International_Blinking_Pattern_Interpretation
+
+		PCI Firmware Specification r3.3 sec 4.7 defines a DSM interface
+		to facilitate shared access by operating system and platform
+		firmware to a device's NPEM registers.  The kernel will use
+		this DSM interface where available, instead of accessing NPEM
+		registers directly.  The DSM interface does not support the
+		enclosure-specific indications "specific0" to "specific7",
+		hence the corresponding LED class devices are unavailable if
+		the DSM interface is used.
diff --git a/drivers/pci/npem.c b/drivers/pci/npem.c
index cd1c18774747..2485462e76a5 100644
--- a/drivers/pci/npem.c
+++ b/drivers/pci/npem.c
@@ -11,6 +11,14 @@
  *	PCIe Base Specification r6.1 sec 6.28
  *	PCIe Base Specification r6.1 sec 7.9.19
  *
+ * _DSM Definitions for PCIe SSD Status LED
+ *	 PCI Firmware Specification, r3.3 sec 4.7
+ *
+ * Two backends are supported to manipulate indications:  Direct NPEM register
+ * access (npem_ops) and indirect access through the ACPI _DSM (dsm_ops).
+ * _DSM is used if supported, else NPEM.
+ *
+ * Copyright (c) 2021-2022 Dell Inc.
  * Copyright (c) 2023-2024 Intel Corporation
  *	Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
  */
@@ -55,6 +63,21 @@ static const struct indication npem_indications[] = {
 	{0,			NULL}
 };
 
+/* _DSM PCIe SSD LED States are corresponding to NPEM register values */
+static const struct indication dsm_indications[] = {
+	{PCI_NPEM_IND_OK,	"enclosure:ok"},
+	{PCI_NPEM_IND_LOCATE,	"enclosure:locate"},
+	{PCI_NPEM_IND_FAIL,	"enclosure:fail"},
+	{PCI_NPEM_IND_REBUILD,	"enclosure:rebuild"},
+	{PCI_NPEM_IND_PFA,	"enclosure:pfa"},
+	{PCI_NPEM_IND_HOTSPARE,	"enclosure:hotspare"},
+	{PCI_NPEM_IND_ICA,	"enclosure:ica"},
+	{PCI_NPEM_IND_IFA,	"enclosure:ifa"},
+	{PCI_NPEM_IND_IDT,	"enclosure:idt"},
+	{PCI_NPEM_IND_DISABLED,	"enclosure:disabled"},
+	{0,			NULL}
+};
+
 #define for_each_indication(ind, inds) \
 	for (ind = inds; ind->bit; ind++)
 
@@ -252,6 +275,120 @@ static bool npem_has_dsm(struct pci_dev *pdev)
 			      BIT(GET_STATE_DSM) | BIT(SET_STATE_DSM));
 }
 
+struct dsm_output {
+	u16 status;
+	u8 function_specific_err;
+	u8 vendor_specific_err;
+	u32 state;
+};
+
+/**
+ * dsm_evaluate() - send DSM PCIe SSD Status LED command
+ * @pdev: PCI device
+ * @dsm_func: DSM LED Function
+ * @output: buffer to copy DSM Response
+ * @value_to_set: value for SET_STATE_DSM function
+ *
+ * To not bother caller with ACPI context, the returned _DSM Output Buffer is
+ * copied.
+ */
+static int dsm_evaluate(struct pci_dev *pdev, u64 dsm_func,
+			struct dsm_output *output, u32 value_to_set)
+{
+	acpi_handle handle = ACPI_HANDLE(&pdev->dev);
+	union acpi_object *out_obj, arg3[2];
+	union acpi_object *arg3_p = NULL;
+
+	if (dsm_func == SET_STATE_DSM) {
+		arg3[0].type = ACPI_TYPE_PACKAGE;
+		arg3[0].package.count = 1;
+		arg3[0].package.elements = &arg3[1];
+
+		arg3[1].type = ACPI_TYPE_BUFFER;
+		arg3[1].buffer.length = 4;
+		arg3[1].buffer.pointer = (u8 *)&value_to_set;
+
+		arg3_p = arg3;
+	}
+
+	out_obj = acpi_evaluate_dsm_typed(handle, &dsm_guid, 0x1, dsm_func,
+					  arg3_p, ACPI_TYPE_BUFFER);
+	if (!out_obj)
+		return -EIO;
+
+	if (out_obj->buffer.length < sizeof(struct dsm_output)) {
+		ACPI_FREE(out_obj);
+		return -EIO;
+	}
+
+	memcpy(output, out_obj->buffer.pointer, sizeof(struct dsm_output));
+
+	ACPI_FREE(out_obj);
+	return 0;
+}
+
+static int dsm_get(struct pci_dev *pdev, u64 dsm_func, u32 *buf)
+{
+	struct dsm_output output;
+	int ret = dsm_evaluate(pdev, dsm_func, &output, 0);
+
+	if (ret)
+		return ret;
+
+	if (output.status != 0)
+		return -EIO;
+
+	*buf = output.state;
+	return 0;
+}
+
+static int dsm_get_active_indications(struct npem *npem, u32 *buf)
+{
+	int ret = dsm_get(npem->dev, GET_STATE_DSM, buf);
+
+	/* Filter out not supported indications in response */
+	*buf &= npem->supported_indications;
+	return ret;
+}
+
+static int dsm_set_active_indications(struct npem *npem, u32 value)
+{
+	struct dsm_output output;
+	int ret = dsm_evaluate(npem->dev, SET_STATE_DSM, &output, value);
+
+	if (ret)
+		return ret;
+
+	switch (output.status) {
+	case 4:
+		/*
+		 * Not all bits are set. If this bit is set, the platform
+		 * disregarded some or all of the request state changes. OSPM
+		 * should check the resulting PCIe SSD Status LED States to see
+		 * what, if anything, has changed.
+		 *
+		 * PCI Firmware Specification, r3.3 Table 4-19.
+		 */
+		if (output.function_specific_err != 1)
+			return -EIO;
+		fallthrough;
+	case 0:
+		break;
+	default:
+		return -EIO;
+	}
+
+	npem->active_indications = output.state;
+
+	return 0;
+}
+
+static const struct npem_ops dsm_ops = {
+	.inds = dsm_indications,
+	.get_active_indications = dsm_get_active_indications,
+	.set_active_indications = dsm_set_active_indications,
+};
+
 static int npem_initialize_active_indications(struct npem *npem)
 {
 	int ret;
@@ -439,11 +576,15 @@ void pci_npem_create(struct pci_dev *dev)
 		 * OS should use the DSM for LED control if it is available
 		 * PCI Firmware Spec r3.3 sec 4.7.
 		 */
-		return;
+		ret = dsm_get(dev, GET_SUPPORTED_STATES_DSM, &cap);
+		if (ret)
+			return;
+
+		ops = &dsm_ops;
 	}
 
 	ret = pci_npem_init(dev, ops, pos, cap);
 	if (ret)
-		pci_err(dev, "Failed to register PCIe Enclosure Management driver, err: %d\n",
-			ret);
+		pci_err(dev, "Failed to register %s PCIe Enclosure Management driver, err: %d\n",
+			(ops == &dsm_ops ? "_DSM" : "Native"), ret);
 }
-- 
2.35.3


