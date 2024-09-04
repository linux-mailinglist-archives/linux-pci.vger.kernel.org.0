Return-Path: <linux-pci+bounces-12744-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1965496B8ED
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 12:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FAB51F25110
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 10:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C1B19ADA3;
	Wed,  4 Sep 2024 10:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C9nyS4ns"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD8717BECC;
	Wed,  4 Sep 2024 10:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725446862; cv=none; b=MKsWMycYkibJOtWwZq/mj8gW5J9RlJ37QsLAXB7pE0oCp+KJrYoyLwl1J1+mLdVlwzLvbG8opdUQdB+F/pRLJQ9vTniOTZ/8s1uzU+eaWGTfMQyBt6XYXQ+Aswr00iq6YR/TxNZX2okTENoicU6LzoL9KvDftjqL7D+aZN48BtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725446862; c=relaxed/simple;
	bh=6qdI2z0/qhYJovmw8KL/m3csnNZ79Qr15565u36+m8w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QKzY6xie8wldA9p9GYQQAgvRjbWXk/fD+3vKmbtTrXnpvjU+f6PYpBsvDEBEoG68Xtsos3DRk3mMBAAsxgEonMMMN/2YbgvLxFDmjJ+nH+IPnamXjhEulYvKpxTGbMCB+N+3ip34cOHeaEinZ5HG7R8Po56zJDB9XjFDNfRLBow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C9nyS4ns; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725446861; x=1756982861;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6qdI2z0/qhYJovmw8KL/m3csnNZ79Qr15565u36+m8w=;
  b=C9nyS4nsQZF6vU8ffP54By0u+Fep7uknSvPzltXKfYIbyQJpF4hc1q/c
   8Vo7vyUxxY8uM0ony/ENNg4Olrt+XTod0a4dTT9pSpn+aIjr8sbgrudLX
   6KUcMI5psWyPbzBwAvbbpN21YsEN9hbZqBD401NZsOUum9DCkiEVfToAN
   QEFRa2MVfk/8Qi/nZNy75RUznmxsnpNKIdlGuy23R3Yn0r/wwHNXRAKer
   adEFdqElZwv67laDPG5Yl31TJE0lQkPCF5hhjXQcROgYOOJhdAmD2X1LB
   eBcNo8aYxNTKpc7hEdylExdUUNdw25l9DLxu0y5KSKM8NHVBdM/uzLj2c
   Q==;
X-CSE-ConnectionGUID: tcvdcWhOQrO6qXlXdmORiw==
X-CSE-MsgGUID: dgThtAb/ROKuZWHm2mCaIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="24261272"
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="24261272"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 03:47:40 -0700
X-CSE-ConnectionGUID: vGJ3yTaLRmmpT567mYfyIA==
X-CSE-MsgGUID: OMRmIpGRSSizgVbX1pgzWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="102636671"
Received: from mtkaczyk-dev.igk.intel.com ([10.102.108.41])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 03:47:36 -0700
From: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To: linux-pci@vger.kernel.org
Cc: linux-leds@vger.kernel.org,
	Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Christoph Hellwig <hch@lst.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Stuart Hayes <stuart.w.hayes@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lee Jones <lee@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Marek Behun <marek.behun@nic.cz>,
	Pavel Machek <pavel@ucw.cz>,
	Randy Dunlap <rdunlap@infradead.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v7 3/3] PCI/NPEM: Add _DSM PCIe SSD status LED management
Date: Wed,  4 Sep 2024 12:48:48 +0200
Message-Id: <20240904104848.23480-4-mariusz.tkaczyk@linux.intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240904104848.23480-1-mariusz.tkaczyk@linux.intel.com>
References: <20240904104848.23480-1-mariusz.tkaczyk@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
in background is logged with info priority. The interface is accessed
same as NPEM.

According to spec, _DSM has higher priority and availability  of _DSM
in not limited to devices with NPEM support. It is followed in
implementation.

DELL implementation of DSM is using acpi ipmi, which is not available
imediatelly (in fact it tooks up to 10s for this interface
to be avialable). It can determine if DSM is supported
(GET_SUPPORTED_STATES_DSM is working) but it cannot serve GET_STATE_DSM
or SET_STATE_DSM commands in this time.
From userspace application perspective (primarly configured by systemd
service) it is better to have not working but configured interface rather
than have it available after few seconds.
For that reason, npem->active_indications cache is now loaded lazily
i.e. any GET or SET request want cache to be updated if it is not
done yet.

Suggested-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
Signed-off-by: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
---
 Documentation/ABI/testing/sysfs-bus-pci |   9 ++
 drivers/pci/npem.c                      | 188 +++++++++++++++++++++++-
 2 files changed, 189 insertions(+), 8 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index 9ddbb1364698..7f63c7e97773 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -563,3 +563,12 @@ Description:
 		indication is usually presented as one or two LEDs blinking at
 		4 Hz frequency:
 		https://en.wikipedia.org/wiki/International_Blinking_Pattern_Interpretation
+
+		PCI Firmware Specification r3.3 sec 4.7 defines a DSM interface
+		to facilitate shared access by operating system and platform
+		firmware to a device's NPEM registers. The kernel will use
+		this DSM interface where available, instead of accessing NPEM
+		registers directly. The DSM interface does not support the
+		enclosure-specific indications "specific0" to "specific7",
+		hence the corresponding led class devices are unavailable if
+		the DSM interface is used.
diff --git a/drivers/pci/npem.c b/drivers/pci/npem.c
index b2beb809bc58..5244f367a6f4 100644
--- a/drivers/pci/npem.c
+++ b/drivers/pci/npem.c
@@ -11,6 +11,14 @@
  *	PCIe Base Specification r6.1 sec 6.28
  *	PCIe Base Specification r6.1 sec 7.9.19
  *
+ * _DSM Definitions for PCIe SSD Status LED
+ *	 PCI Firmware Specification, r3.3 sec 4.7
+ *
+ * Two backends are supported to manipulate indications: Direct NPEM register
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
 
@@ -124,6 +147,14 @@ struct npem_ops {
  * @active_indications: cached bit mask of active indications;
  *	non-indication and reserved bits in the NPEM Control Register are
  *	cleared in this bit mask
+ * @active_inds_initialized: whether @active_indications has been initialized;
+ *	On Dell platforms, it is required that IPMI drivers are loaded before
+ *	the GET_STATE_DSM method is invoked: They use an IPMI OpRegion to
+ *	get/set the active LEDs. By initializing @active_indications lazily
+ *	(on first access to an LED), IPMI drivers are given a chance to load.
+ *	If they are not loaded in time, users will see various errors on LED
+ *	access in dmesg. Once they are loaded, the errors go away and LED
+ *	access becomes possible.
  * @led_cnt: size of @leds array
  * @leds: array containing LED class devices of all supported LEDs
  */
@@ -134,6 +165,7 @@ struct npem {
 	u16 pos;
 	u32 supported_indications;
 	u32 active_indications;
+	unsigned int active_inds_initialized:1;
 	int led_cnt;
 	struct npem_led leds[];
 };
@@ -247,6 +279,139 @@ static bool npem_has_dsm(struct pci_dev *pdev)
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
+	.get_active_indications = dsm_get_active_indications,
+	.set_active_indications = dsm_set_active_indications,
+	.name =  "_DSM PCIe SSD Status LED Management",
+	.inds = dsm_indications,
+};
+
+static int npem_initialize_active_indications(struct npem *npem)
+{
+	int ret;
+
+	lockdep_assert_held(&npem->lock);
+
+	if (npem->active_inds_initialized)
+		return 0;
+
+	ret = npem->ops->get_active_indications(npem,
+						&npem->active_indications);
+	if (ret)
+		return ret;
+
+	npem->active_inds_initialized = true;
+	return 0;
+}
+
 /*
  * The status of each indicator is cached on first brightness_ get/set time and
  * updated at write time.
@@ -263,9 +428,14 @@ static enum led_brightness brightness_get(struct led_classdev *led)
 	if (ret)
 		return ret;
 
+	ret = npem_initialize_active_indications(npem);
+	if (ret)
+		goto out;
+
 	if (npem->active_indications & nled->indication->bit)
 		val = 1;
 
+out:
 	mutex_unlock(&npem->lock);
 	return val;
 }
@@ -282,6 +452,10 @@ static int brightness_set(struct led_classdev *led,
 	if (ret)
 		return ret;
 
+	ret = npem_initialize_active_indications(npem);
+	if (ret)
+		goto out;
+
 	if (brightness == 0)
 		indications = npem->active_indications & ~(nled->indication->bit);
 	else
@@ -289,6 +463,7 @@ static int brightness_set(struct led_classdev *led,
 
 	ret = npem->ops->set_active_indications(npem, indications);
 
+out:
 	mutex_unlock(&npem->lock);
 	return ret;
 }
@@ -361,11 +536,6 @@ static int pci_npem_init(struct pci_dev *dev, const struct npem_ops *ops,
 	npem->dev = dev;
 	npem->ops = ops;
 
-	ret = npem->ops->get_active_indications(npem,
-						&npem->active_indications);
-	if (ret)
-		return ret;
-
 	mutex_init(&npem->lock);
 
 	for_each_indication(indication, npem_indications) {
@@ -411,9 +581,11 @@ void pci_npem_create(struct pci_dev *dev)
 		 * OS should use the DSM for LED control if it is available
 		 * PCI Firmware Spec r3.3 sec 4.7.
 		 */
-		pci_info(dev, "Not configuring %s because _DSM is present\n",
-			 ops->name);
-		return;
+		ret = dsm_get(dev, GET_SUPPORTED_STATES_DSM, &cap);
+		if (ret)
+			return;
+
+		ops = &dsm_ops;
 	}
 
 	pci_info(dev, "Configuring %s\n", ops->name);
-- 
2.35.3


