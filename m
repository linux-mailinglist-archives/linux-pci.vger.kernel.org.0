Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C134A7764
	for <lists+linux-pci@lfdr.de>; Wed,  2 Feb 2022 19:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239093AbiBBR7g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Feb 2022 12:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbiBBR7e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Feb 2022 12:59:34 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70374C061714;
        Wed,  2 Feb 2022 09:59:34 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id y23so41057373oia.13;
        Wed, 02 Feb 2022 09:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KHokDnc5z5J/K/wLU1PbiasxitJZZ/hOyhpCkiqT9Eg=;
        b=WS3jZQoFT5Oki+reNrvD/1ntzi04uiB0b6gvVYfJShm4/rEsBL60lxYJx4y+tK4AZZ
         0vpXb3cuFMNSDUVqcAaTwx0jnCCTPmTijdNpIqPXveHMjMEgXBbuyDV9Cs2drhSVoNvY
         PGeDNUbVdH2Edd5HqKZWY+iNVcv1wUhnWu0KphYbQO10gI+7JexbOnbYBQiVezENtoM3
         EchYUPYc7ytZq4zwmXvJf5ZbyE4eNph7nRz6io++1DVDmJOVyvjJ4Jb30tTPY1j1ze16
         tjSf5PYGFP7emu8yJgOkXN559uGkpCBpSqzlqHonN8xIGIovzzvXynnBbKpn6F5tJ23q
         AB/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KHokDnc5z5J/K/wLU1PbiasxitJZZ/hOyhpCkiqT9Eg=;
        b=WzdWuz4VR7gJSk7MofJs2yStuIGwPS5kQ2bL+/GX8/3sYn0bfGpRD+wuniJGD01ga9
         jpJHTnj+e9CKEG2km9W70fVfavqperAs3VdpTJcI86EKnhndrWdeSFtt+nyL+MupPPHH
         OfmXUtbrOyTgW2ZCjJ/2MnxJ5tV3VikNULPlhsUJIjaOCVpUTIJWiSEUJQaMi/KXVPVZ
         Gfd1LTNtHbIyza+3l/riwPL2F8vsTlOSzB9rrU7hz+Wgj5uEztbZsB6EmG6aMSA837y1
         ALAnpKGO9YnLYLRtxGE97NVZ+yzcd07dhMohPzS8UV/EOC5zA9cvVdQnh+w2qPatmSKi
         1bJg==
X-Gm-Message-State: AOAM530nkYWOk4L/pUZg6FE/CeyIQZmvtNk8faoD6O6m/b+jkvxI6XZ7
        dLNZ6ecI7TCwh9MZ8nGJoQw=
X-Google-Smtp-Source: ABdhPJx/dCSzRgyRJmn4xag0MU3RV/SAP3FvwEI4kxy8iLw3KfvRukKpp9ZzlNqdAfOWmQDlZitpHA==
X-Received: by 2002:a05:6808:3012:: with SMTP id ay18mr5289883oib.331.1643824773698;
        Wed, 02 Feb 2022 09:59:33 -0800 (PST)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id v10sm16122725oto.53.2022.02.02.09.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 09:59:33 -0800 (PST)
From:   Stuart Hayes <stuart.w.hayes@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Keith Busch <kbusch@kernel.org>, kw@linux.com,
        mariusz.tkaczyk@linux.intel.com, helgaas@kernel.org,
        lukas@wunner.de, pavel@ucw.cz, linux-cxl@vger.kernel.org,
        martin.petersen@oracle.com, James.Bottomley@hansenpartnership.com,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [RFC PATCH v2 2/3] Add PCIe enclosure management auxiliary driver
Date:   Wed,  2 Feb 2022 11:59:12 -0600
Message-Id: <644e380e0fa53c541db25d38ce7fee7ef3fd717b.1643822289.git.stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1643822289.git.stuart.w.hayes@gmail.com>
References: <cover.1643822289.git.stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch adds a new auxiliary driver to support PCIe enclosure
management (NPEM and _DSM).  Drivers whose PCIe devices could have
NPEM and/or _DSM enclosure management support could register an
auxiliary device, and this driver will attach to that and register an
enclosure to allow user space control of the associated state
indicators.

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
---
 drivers/pci/pcie/Kconfig      |   8 +
 drivers/pci/pcie/Makefile     |   1 +
 drivers/pci/pcie/pcie_em.c    | 473 ++++++++++++++++++++++++++++++++++
 include/linux/pcie_em.h       |  97 +++++++
 include/uapi/linux/pci_regs.h |  11 +-
 5 files changed, 589 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pci/pcie/pcie_em.c
 create mode 100644 include/linux/pcie_em.h

diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index 45a2ef702b45..deaaf00c0d38 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -142,3 +142,11 @@ config PCIE_EDR
 	  the PCI Firmware Specification r3.2.  Enable this if you want to
 	  support hybrid DPC model which uses both firmware and OS to
 	  implement DPC.
+
+config PCIE_EM
+	tristate "PCIe Enclosure Management support"
+	depends on ENCLOSURE_SERVICES
+	help
+	  Auxiliary driver for PCI Express enclosure management (support
+	  for Native PCIe Enclosure Management (NPEM) and the related _DSM
+	  interface for status LED management).
diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
index 5783a2f79e6a..3b2b160b6f13 100644
--- a/drivers/pci/pcie/Makefile
+++ b/drivers/pci/pcie/Makefile
@@ -13,3 +13,4 @@ obj-$(CONFIG_PCIE_PME)		+= pme.o
 obj-$(CONFIG_PCIE_DPC)		+= dpc.o
 obj-$(CONFIG_PCIE_PTM)		+= ptm.o
 obj-$(CONFIG_PCIE_EDR)		+= edr.o
+obj-$(CONFIG_PCIE_EM)		+= pcie_em.o
diff --git a/drivers/pci/pcie/pcie_em.c b/drivers/pci/pcie/pcie_em.c
new file mode 100644
index 000000000000..fe6ec3aaa561
--- /dev/null
+++ b/drivers/pci/pcie/pcie_em.c
@@ -0,0 +1,473 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Auxiliary driver providing support for PCIe Native PCIe Enclosure
+ * Management, supporting both the PCIe NPEM extended capability and the
+ * _DSM interface (as defined in the PCI Firmware Specification Rev
+ * 3.3, chapter 4.7, "_DSM Definitions for PCIe SSD Status LED".
+ *
+ * Copyright (c) 2021 Dell Inc.
+ *
+ * TODO: Actually add NPEM extended capability support
+ *       Add pcieport & cxl support
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/acpi.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/pci.h>
+#include <linux/enclosure.h>
+#include <linux/auxiliary_bus.h>
+#include <linux/delay.h>
+#include "../pci.h"
+#include <linux/pcie_em.h>
+
+#define DRIVER_NAME	"pcie-em"
+#define DRIVER_VERSION	"v1.0"
+
+#define NPEM_EXT_CAP_H
+/*
+ * NPEM & _DSM use the same state bit definitions
+ */
+#define	NPEM_STATE_OK		BIT(2)
+#define	NPEM_STATE_LOCATE	BIT(3)
+#define	NPEM_STATE_FAILED	BIT(4)
+#define	NPEM_STATE_REBUILD	BIT(5)
+#define	NPEM_STATE_PFA		BIT(6)  /* predicted failure analysis */
+#define	NPEM_STATE_HOTSPARE	BIT(7)
+#define	NPEM_STATE_ICA		BIT(8)  /* in a critical array */
+#define	NPEM_STATE_IFA		BIT(9)  /* in a failed array */
+#define	NPEM_STATE_INVALID	BIT(10)
+#define	NPEM_STATE_DISABLED	BIT(11)
+#define NPEM_ALL_STATES		GENMASK(11, 2)
+
+static const u32 to_npem_state[ENCLOSURE_LED_MAX] = {
+	[ENCLOSURE_LED_FAULT]		= NPEM_STATE_FAILED,
+	[ENCLOSURE_LED_LOCATE]		= NPEM_STATE_LOCATE,
+	[ENCLOSURE_LED_OK]		= NPEM_STATE_OK,
+	[ENCLOSURE_LED_REBUILD]		= NPEM_STATE_REBUILD,
+	[ENCLOSURE_LED_PRDFAIL]		= NPEM_STATE_PFA,
+	[ENCLOSURE_LED_HOTSPARE]	= NPEM_STATE_HOTSPARE,
+	[ENCLOSURE_LED_ICA]		= NPEM_STATE_ICA,
+	[ENCLOSURE_LED_IFA]		= NPEM_STATE_IFA,
+	[ENCLOSURE_LED_DISABLED]	= NPEM_STATE_DISABLED,
+};
+
+/*
+ * pcie_em_dev->pdev could be the drive itself or the downstream port
+ * leading to it
+ */
+struct pcie_em_dev {
+	struct pci_dev *pdev;			/* dev with controls */
+	struct pcie_em_led_state_ops *ops;	/* _DSM or NPEM ops */
+	struct enclosure_device *edev;
+	u32 states;				/* last written states */
+	u32 supported_states;
+	u16 npem_pos;				/* position of NPEM ext cap */
+	struct work_struct npem_work;		/* NPEM control write work func */
+	unsigned long last_ctrl_write;		/* time of last NPEM ctrl write */
+};
+
+struct pcie_em_led_state_ops {
+	void (*init)(struct pcie_em_dev *emdev);
+	int (*get_supported_states)(struct pcie_em_dev *emdev);
+	int (*get_current_states)(struct pcie_em_dev *emdev, u32 *states);
+	int (*set_current_states)(struct pcie_em_dev *emdev);
+};
+
+static struct mutex pcie_em_lock;
+static int pcie_em_exiting;
+
+#ifdef CONFIG_ACPI
+/*
+ * _DSM LED control
+ */
+static const guid_t pcie_pcie_em_dsm_guid = PCIE_SSD_LEDS_DSM_GUID;
+
+struct pcie_em_dsm_output {
+	u16 status;
+	u8 function_specific_err;
+	u8 vendor_specific_err;
+	u32 state;
+};
+
+static void dsm_status_err_print(struct pci_dev *pdev,
+				 struct pcie_em_dsm_output *output)
+{
+	switch (output->status) {
+	case 0:
+		break;
+	case 1:
+		pci_dbg(pdev, "_DSM not supported\n");
+		break;
+	case 2:
+		pci_dbg(pdev, "_DSM invalid input parameters\n");
+		break;
+	case 3:
+		pci_dbg(pdev, "_DSM communication error\n");
+		break;
+	case 4:
+		pci_dbg(pdev, "_DSM function-specific error 0x%x\n",
+			output->function_specific_err);
+		break;
+	case 5:
+		pci_dbg(pdev, "_DSM vendor-specific error 0x%x\n",
+			output->vendor_specific_err);
+		break;
+	default:
+		pci_dbg(pdev, "_DSM returned unknown status 0x%x\n",
+			output->status);
+	}
+}
+
+static int dsm_set(struct pci_dev *pdev, u32 value)
+{
+	acpi_handle handle;
+	union acpi_object *out_obj, arg3[2];
+	struct pcie_em_dsm_output *dsm_output;
+
+	handle = ACPI_HANDLE(&pdev->dev);
+	if (!handle)
+		return -ENODEV;
+
+	arg3[0].type = ACPI_TYPE_PACKAGE;
+	arg3[0].package.count = 1;
+	arg3[0].package.elements = &arg3[1];
+
+	arg3[1].type = ACPI_TYPE_BUFFER;
+	arg3[1].buffer.length = 4;
+	arg3[1].buffer.pointer = (u8 *)&value;
+
+	out_obj = acpi_evaluate_dsm_typed(handle, &pcie_pcie_em_dsm_guid,
+				1, SET_STATE_DSM, &arg3[0], ACPI_TYPE_BUFFER);
+	if (!out_obj)
+		return -EIO;
+
+	if (out_obj->buffer.length < 8) {
+		ACPI_FREE(out_obj);
+		return -EIO;
+	}
+
+	dsm_output = (struct pcie_em_dsm_output *)out_obj->buffer.pointer;
+
+	if (dsm_output->status != 0) {
+		dsm_status_err_print(pdev, dsm_output);
+		ACPI_FREE(out_obj);
+		return -EIO;
+	}
+	ACPI_FREE(out_obj);
+	return 0;
+}
+
+static int dsm_get(struct pci_dev *pdev, u64 dsm_func, u32 *output)
+{
+	acpi_handle handle;
+	union acpi_object *out_obj;
+	struct pcie_em_dsm_output *dsm_output;
+
+	handle = ACPI_HANDLE(&pdev->dev);
+	if (!handle)
+		return -ENODEV;
+
+	out_obj = acpi_evaluate_dsm_typed(handle, &pcie_pcie_em_dsm_guid, 0x1,
+					  dsm_func, NULL, ACPI_TYPE_BUFFER);
+	if (!out_obj)
+		return -EIO;
+
+	if (out_obj->buffer.length < 8) {
+		ACPI_FREE(out_obj);
+		return -EIO;
+	}
+
+	dsm_output = (struct pcie_em_dsm_output *)out_obj->buffer.pointer;
+	if (dsm_output->status != 0) {
+		dsm_status_err_print(pdev, dsm_output);
+		ACPI_FREE(out_obj);
+		return -EIO;
+	}
+
+	*output = dsm_output->state;
+	ACPI_FREE(out_obj);
+	return 0;
+}
+
+static int get_supported_states_dsm(struct pcie_em_dev *emdev)
+{
+	return dsm_get(emdev->pdev, GET_SUPPORTED_STATES_DSM, &emdev->supported_states);
+}
+
+static int get_current_states_dsm(struct pcie_em_dev *emdev, u32 *states)
+{
+	return dsm_get(emdev->pdev, GET_STATE_DSM, states);
+}
+
+static int set_current_states_dsm(struct pcie_em_dev *emdev)
+{
+	return dsm_set(emdev->pdev, emdev->states);
+}
+
+static struct pcie_em_led_state_ops dsm_pcie_em_led_state_ops = {
+	.get_supported_states	= get_supported_states_dsm,
+	.get_current_states	= get_current_states_dsm,
+	.set_current_states	= set_current_states_dsm,
+};
+
+/*
+ * end of _DSM code
+ */
+
+#endif /* CONFIG_ACPI */
+
+/*
+ * NPEM LED control
+ */
+
+static inline int npem_write_ctrl(struct pcie_em_dev *emdev, u32 reg)
+{
+	struct pci_dev *pdev = emdev->pdev;
+
+	emdev->last_ctrl_write = jiffies;
+	return pci_write_config_dword(pdev, emdev->npem_pos + PCI_NPEM_CTRL, reg);
+}
+
+static int get_supported_states_npem(struct pcie_em_dev *emdev)
+{
+	struct pci_dev *pdev = emdev->pdev;
+	u32 reg;
+	int ret;
+
+	ret = pci_read_config_dword(pdev, emdev->npem_pos + PCI_NPEM_CAP, &reg);
+	if (!ret)
+		emdev->supported_states = reg & NPEM_ALL_STATES;
+	return ret;
+}
+
+static int get_current_states_npem(struct pcie_em_dev *emdev, u32 *states)
+{
+	struct pci_dev *pdev = emdev->pdev;
+	u32 reg;
+	int ret;
+
+	ret = pci_read_config_dword(pdev, emdev->npem_pos + PCI_NPEM_CTRL, &reg);
+	if (!ret)
+		*states = reg & NPEM_ALL_STATES;
+	return ret;
+}
+
+static void npem_set_states_work(struct work_struct *w)
+{
+	struct pcie_em_dev *emdev = container_of(w, struct pcie_em_dev, npem_work);
+	struct pci_dev *pdev = emdev->pdev;
+	u32 status;
+
+	/*
+	 * per spec, wait up to 1 second for command completed status bit to be high
+	 */
+	while (true) {
+		if (pci_read_config_dword(pdev, emdev->npem_pos + PCI_NPEM_STATUS,
+					  &status))
+			return;
+		if ((status & PCI_NPEM_STATUS_CC) ||
+		    time_after(jiffies, emdev->last_ctrl_write + HZ)) {
+			break;
+		}
+		msleep(20);
+	}
+	npem_write_ctrl(emdev, emdev->states | PCI_NPEM_CTRL_EN);
+}
+
+static int set_current_states_npem(struct pcie_em_dev *emdev)
+{
+	schedule_work(&emdev->npem_work);
+	return 0;
+}
+
+static void npem_init(struct pcie_em_dev *emdev)
+{
+	struct pci_dev *pdev = emdev->pdev;
+
+	emdev->npem_pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_NPEM);
+	npem_write_ctrl(emdev, PCI_NPEM_CTRL_EN);
+	INIT_WORK(&emdev->npem_work, npem_set_states_work);
+}
+
+static struct pcie_em_led_state_ops npem_pcie_em_led_state_ops = {
+	.init			= npem_init,
+	.get_supported_states	= get_supported_states_npem,
+	.get_current_states	= get_current_states_npem,
+	.set_current_states	= set_current_states_npem,
+};
+
+/*
+ * end of NPEM code
+ */
+
+static void pcie_em_get_led(struct enclosure_device *edev,
+			     struct enclosure_component *ecomp,
+			     enum enclosure_component_led led)
+{
+	struct pcie_em_dev *emdev = ecomp->scratch;
+	u32 states = 0;
+
+	emdev->ops->get_current_states(emdev, &states);
+	ecomp->led[led] = !!(states & to_npem_state[led]) ?
+		ENCLOSURE_SETTING_ENABLED : ENCLOSURE_SETTING_DISABLED;
+}
+
+static int pcie_em_set_led(struct enclosure_device *edev,
+			 struct enclosure_component *ecomp,
+			 enum enclosure_component_led led,
+			 enum enclosure_component_setting val)
+{
+	struct pcie_em_dev *emdev = ecomp->scratch;
+	u32 npem_state = to_npem_state[led], states;
+	int rc;
+
+	if (val != ENCLOSURE_SETTING_ENABLED
+	    && val != ENCLOSURE_SETTING_DISABLED)
+		return -EINVAL;
+
+	states = emdev->states & ~npem_state;
+	states |= val == ENCLOSURE_SETTING_ENABLED ? npem_state : 0;
+
+	if ((states & emdev->supported_states) != states)
+		return -EINVAL;
+
+	emdev->states = states;
+	rc = emdev->ops->set_current_states(emdev);
+	/*
+	 * save last written state so it doesn't have to be re-read via NPEM/
+	 * _DSM on the next write
+	 */
+	return rc;
+}
+
+static struct enclosure_component_callbacks pcie_em_cb = {
+	.get_led	= pcie_em_get_led,
+	.set_led	= pcie_em_set_led,
+};
+
+static void pcie_em_remove(struct auxiliary_device *adev)
+{
+	struct pcie_em_dev *emdev = dev_get_drvdata(&adev->dev);
+
+	emdev->edev->scratch = NULL;
+	enclosure_unregister(emdev->edev);
+	dev_set_drvdata(&adev->dev, NULL);
+	kfree(emdev);
+}
+
+static int add_pcie_em_dev(struct auxiliary_device *adev,
+				struct pcie_em_led_state_ops *ops)
+{
+	struct pcie_em_dev *emdev;
+	struct pci_dev *pdev = to_pci_dev(adev->dev.parent);
+	struct enclosure_device *edev;
+	struct enclosure_component *ecomp;
+	int rc = 0;
+
+	mutex_lock(&pcie_em_lock);
+	if (pcie_em_exiting)
+		goto out_unlock;
+
+	emdev = kzalloc(sizeof(*emdev), GFP_KERNEL);
+	if (!emdev) {
+		rc = -ENOMEM;
+		goto out_unlock;
+	}
+	emdev->pdev = pdev;
+	emdev->ops = ops;
+	emdev->states = 0;
+	if (emdev->ops->init)
+		emdev->ops->init(emdev);
+
+	if (emdev->ops->get_supported_states(emdev) != 0)
+		goto out_free;
+
+	edev = enclosure_register(&pdev->dev, dev_name(&adev->dev), 1, &pcie_em_cb);
+	if (!edev)
+		goto out_free;
+
+	ecomp = enclosure_component_alloc(edev, 0, ENCLOSURE_COMPONENT_DEVICE, dev_name(&pdev->dev));
+	if (IS_ERR(ecomp))
+		goto out_unreg;
+
+	ecomp->type = ENCLOSURE_COMPONENT_ARRAY_DEVICE;
+	rc = enclosure_component_register(ecomp);
+	if (rc < 0)
+		goto out_unreg;
+
+	ecomp->scratch = emdev;
+	emdev->edev = edev;
+	dev_set_drvdata(&adev->dev, emdev);
+	goto out_unlock;
+
+out_unreg:
+	enclosure_unregister(edev);
+out_free:
+	kfree(emdev);
+out_unlock:
+	mutex_unlock(&pcie_em_lock);
+	return rc;
+}
+
+static int pcie_em_probe(struct auxiliary_device *adev,
+			  const struct auxiliary_device_id *id)
+{
+	struct pci_dev *pdev = to_pci_dev(adev->dev.parent);
+
+	/*
+	 * The PCI Firmware Spec Rev 3.3 says that the _DSM should be used
+	 * in preference to NPEM if available.
+	 */
+#ifdef CONFIG_ACPI
+	if (pci_has_pcie_em_dsm(pdev))
+		return add_pcie_em_dev(adev, &dsm_pcie_em_led_state_ops);
+#endif
+	if (pci_has_npem(pdev))
+		return add_pcie_em_dev(adev, &npem_pcie_em_led_state_ops);
+
+	/*
+	 * should not get here
+	 */
+	return -ENODEV;
+}
+
+static const struct auxiliary_device_id pcie_em_id_table[] = {
+	{ .name = "nvme.pcie_em", },
+//	{ .name = "cxl.pcie_em", },
+//	{ .name = "pcieport.pcie_em", },
+	{},
+};
+
+MODULE_DEVICE_TABLE(auxiliary, pcie_em_id_table);
+
+static struct auxiliary_driver pcie_em_driver = {
+	.name = "pcie_em",
+	.probe = pcie_em_probe,
+	.remove = pcie_em_remove,
+	.id_table = pcie_em_id_table,
+};
+
+static int __init pcie_em_init(void)
+{
+	mutex_init(&pcie_em_lock);
+	auxiliary_driver_register(&pcie_em_driver);
+	return 0;
+}
+
+static void __exit pcie_em_exit(void)
+{
+	mutex_lock(&pcie_em_lock);
+	pcie_em_exiting = 1;
+	mutex_unlock(&pcie_em_lock);
+	auxiliary_driver_unregister(&pcie_em_driver);
+}
+
+module_init(pcie_em_init);
+module_exit(pcie_em_exit);
+
+MODULE_AUTHOR("Stuart Hayes <stuart.w.hayes@gmail.com>");
+MODULE_DESCRIPTION("Support for PCIe SSD Status LEDs");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/pcie_em.h b/include/linux/pcie_em.h
new file mode 100644
index 000000000000..26b6d68cccd3
--- /dev/null
+++ b/include/linux/pcie_em.h
@@ -0,0 +1,97 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef DRIVERS_PCI_PCIE_EM_H
+#define DRIVERS_PCI_PCIE_EM_H
+
+#include <linux/pci.h>
+#include <linux/acpi.h>
+
+#define PCIE_SSD_LEDS_DSM_GUID						\
+	GUID_INIT(0x5d524d9d, 0xfff9, 0x4d4b,				\
+		  0x8c, 0xb7, 0x74, 0x7e, 0xd5, 0x1e, 0x19, 0x4d)
+
+#define GET_SUPPORTED_STATES_DSM	0x01
+#define GET_STATE_DSM			0x02
+#define SET_STATE_DSM			0x03
+
+static inline bool pci_has_pcie_em_dsm(struct pci_dev *pdev)
+{
+#ifdef CONFIG_ACPI
+	acpi_handle handle;
+	const guid_t pcie_ssd_leds_dsm_guid = PCIE_SSD_LEDS_DSM_GUID;
+
+	handle = ACPI_HANDLE(&pdev->dev);
+	if (handle)
+		if (acpi_check_dsm(handle, &pcie_ssd_leds_dsm_guid, 0x1,
+				   1 << GET_SUPPORTED_STATES_DSM ||
+				   1 << GET_STATE_DSM ||
+				   1 << SET_STATE_DSM))
+			return true;
+#endif
+	return false;
+}
+
+static inline bool pci_has_npem(struct pci_dev *pdev)
+{
+	int pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_NPEM);
+	u32 cap;
+
+	if (pos)
+		if (!pci_read_config_dword(pdev, pos + PCI_NPEM_CAP, &cap))
+			return cap & PCI_NPEM_CAP_NPEM_CAP;
+	return false;
+}
+
+static inline bool pci_has_enclosure_management(struct pci_dev *pdev)
+{
+	return pci_has_pcie_em_dsm(pdev) || pci_has_npem(pdev);
+}
+
+static inline void release_pcie_em_aux_device(struct device *dev)
+{
+	kfree(to_auxiliary_dev(dev));
+}
+
+static inline struct auxiliary_device *register_pcie_em_auxdev(struct device *dev, int id)
+{
+	struct auxiliary_device *adev;
+	int ret;
+
+	if (!pci_has_enclosure_management(to_pci_dev(dev)))
+		return NULL;
+
+	adev = kzalloc(sizeof(*adev), GFP_KERNEL);
+	if (!adev)
+		goto em_reg_out_err;
+
+	adev->name = "pcie_em";
+	adev->dev.parent = dev;
+	adev->dev.release = release_pcie_em_aux_device;
+	adev->id = id;
+
+	ret = auxiliary_device_init(adev);
+	if (ret < 0)
+		goto em_reg_out_free;
+
+	ret = auxiliary_device_add(adev);
+	if (ret) {
+		auxiliary_device_uninit(adev);
+		goto em_reg_out_free;
+	}
+
+	return adev;
+em_reg_out_free:
+	kfree(adev);
+em_reg_out_err:
+	dev_warn(dev, "failed to register pcie_em device\n");
+	return NULL;
+}
+
+static inline void unregister_pcie_em_auxdev(struct auxiliary_device *auxdev)
+{
+	if (auxdev) {
+		auxiliary_device_delete(auxdev);
+		auxiliary_device_uninit(auxdev);
+	}
+}
+
+#endif /* DRIVERS_PCI_PCIE_EM_H */
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index ff6ccbc6efe9..375540065c29 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -736,7 +736,8 @@
 #define PCI_EXT_CAP_ID_DVSEC	0x23	/* Designated Vendor-Specific */
 #define PCI_EXT_CAP_ID_DLF	0x25	/* Data Link Feature */
 #define PCI_EXT_CAP_ID_PL_16GT	0x26	/* Physical Layer 16.0 GT/s */
-#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_PL_16GT
+#define PCI_EXT_CAP_ID_NPEM	0x29	/* Native PCIe Enclosure Management */
+#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_NPEM
 
 #define PCI_EXT_CAP_DSN_SIZEOF	12
 #define PCI_EXT_CAP_MCAST_ENDPOINT_SIZEOF 40
@@ -1098,4 +1099,12 @@
 #define  PCI_PL_16GT_LE_CTRL_USP_TX_PRESET_MASK		0x000000F0
 #define  PCI_PL_16GT_LE_CTRL_USP_TX_PRESET_SHIFT	4
 
+/* NPEM */
+#define PCI_NPEM_CAP		0x04
+#define  PCI_NPEM_CAP_NPEM_CAP		0x00000001  /* dev is NPEM capable */
+#define PCI_NPEM_CTRL		0x08
+#define  PCI_NPEM_CTRL_EN		0x00000001  /* Enable NPEM */
+#define PCI_NPEM_STATUS		0x0c
+#define  PCI_NPEM_STATUS_CC		0x00000001  /* NPEM command completed */
+
 #endif /* LINUX_PCI_REGS_H */
-- 
2.31.1

