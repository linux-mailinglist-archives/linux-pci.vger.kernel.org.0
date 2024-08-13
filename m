Return-Path: <linux-pci+bounces-11632-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDC4950398
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 13:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D4A81F25440
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 11:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2CD198A3D;
	Tue, 13 Aug 2024 11:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ObIVtDWl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB014C8C
	for <linux-pci@vger.kernel.org>; Tue, 13 Aug 2024 11:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723548574; cv=none; b=oG1epi4oolJ51hBmzc4vTcVUsWGwiQcu8uN94hgl5Vz+diywwhfbVWaDIEDn3QMvVdaS6CVY9iHOj6j+dCGBgoXs6jVmU6rP163ZgQX1vVXBUo9hjeMAPRbgi/Ca3smCPpLD9AfCih2HV6fh7Ge1SWtSdU7KIIH0iSECdJ/cTYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723548574; c=relaxed/simple;
	bh=rRgDtqu2Vq29bX/6Ph1ArhgpidYuz1EJV9azPJFG8Fs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aL628TZYZmRNWB59pg42ZUlEva4Y6xce7UqqNZ73qmITVvUCk0P0cMnnXim/5DU0UANwakdeX2RVOODkXF1+TKFSQQTMEV5qcMcc/ChnECgk8MVYG13/iE7fVLyr5B+Py24C43T0FBxHcZzGKsGCEloOzIwY7deI0lArM+SXIF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ObIVtDWl; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723548573; x=1755084573;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rRgDtqu2Vq29bX/6Ph1ArhgpidYuz1EJV9azPJFG8Fs=;
  b=ObIVtDWl4q6MtgaqOFWpe+aptSnPa6rnH1eyf+LsKVr+IjjskpjS4KbA
   L5H1U30Vd7TjdilqRMR8Z+gZV8UuokdAK2w0fVOE/UtCDXZng+xCud3j/
   NwXFrdbnmM5KjNdlLJFsH32sAno/wapj6AEBZGCuRUCWt5svRbDJf9+BR
   lY5j9ZNibe6x6SFbn9o7qk8cGBWflLLpR1lhQfx1I77+IhoWXSxiSripX
   5s/AQxIFk+7xRSeEY+7v6c9qubITSx9AXxFBcygbcS6xgQANQqpRL+4vR
   tIjb7BzJgvQ1RNNH0lyaGs3P67Vtii0GCFKb0bNYE0HRLaB3liJBmGhLa
   g==;
X-CSE-ConnectionGUID: TmIzwidvR/eCNXb6bWksrw==
X-CSE-MsgGUID: vARxQVBcQgu03gc2SthAfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="21864354"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="21864354"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 04:29:32 -0700
X-CSE-ConnectionGUID: Ekaa+lN0RHOmCnltiA05rA==
X-CSE-MsgGUID: 69mzwqO1ROCDmZJP9t4lLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="89437779"
Received: from mtkaczyk-dev.igk.intel.com ([10.102.108.41])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 04:29:29 -0700
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
Subject: [PATCH v5 3/3] PCI/NPEM: Add _DSM PCIe SSD status LED management
Date: Tue, 13 Aug 2024 13:30:24 +0200
Message-Id: <20240813113024.17938-4-mariusz.tkaczyk@linux.intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240813113024.17938-1-mariusz.tkaczyk@linux.intel.com>
References: <20240813113024.17938-1-mariusz.tkaczyk@linux.intel.com>
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
index 93d22b779d20..62154e549414 100644
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
+		hence the corresponding led class devices are unavailable if
+		the DSM interface is used.
diff --git a/drivers/pci/npem.c b/drivers/pci/npem.c
index cd1c18774747..e5569d9ee446 100644
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
+} __packed;
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


