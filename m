Return-Path: <linux-pci+bounces-5098-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD23B88A75A
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 16:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A6AC1F6538D
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 15:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B47157A5A;
	Mon, 25 Mar 2024 13:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="WA5MdIJj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCB21509A1
	for <linux-pci@vger.kernel.org>; Mon, 25 Mar 2024 13:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711372641; cv=none; b=t11BCkbwt/wk62FzP2c8Wbh5GQh71U0YdKK9QvErTZXy50nX+RQMWv/dvlgtvQDwEquauDkKB3FMYy5A3x/Z3THREFPQjnWaXFrri8kD5/FzrBPazPmqG0KjP8dM1tD7NvHOsWuAqnzSxEwZvvHBIjGaN5FIrC4b65J0pVdUQ+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711372641; c=relaxed/simple;
	bh=3mCqNjHuoaUHiO0st6ivDZGmPe1iRnSnLzO7cdPvDrI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iVgoNu16D17pmA7Ppffi6PC5E/Cc2UIXXhtciJTSixRkEvf1YqgM6Zxh9xOqbcZDRi4T1uZ3YVsAqrxdXLG9jfRQqGgFqemz794mkcA71BdqeK1FJDBqIrsDixa92wag3jfZpHtw7GR9rRDSh5fAIkgYFbWr3DqrBmz75bj+IE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=WA5MdIJj; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33fd12a06fdso3073495f8f.1
        for <linux-pci@vger.kernel.org>; Mon, 25 Mar 2024 06:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1711372635; x=1711977435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WoDV4sXNx4Iy0QllvGHLAhCC+BDrXl0CdEk2kmG14Eg=;
        b=WA5MdIJjE1sGbhi4+FSFwdqn9r1tcgS3NCLSuN5RrxvqMHL7crCSeNoael4dLyhFIc
         CDDTbzHsNEnIkOPCMdXsDelCCcGL02TtJ90CfpUyXrkmJLQhWO8O/dz4oULrPquTCJuB
         wVQla5QLBQTBk1+7Gohffp3jF+AJputjjEnxy2ZvynNtUm3pq6UmrwZTFBXYx1jWDdD4
         KD/nBi3vQa/fBTV38vWcJKfFcHsdS5HW5oetmvpZCzAsHfwkwww+6m2+qPg9V2wK0K51
         hXunLI+MMwRciNqrYxxEoFhxzW8UaSXWlJFLYVpSfJqZIVfIDVm6MkYIJzXFw2uUQOU9
         J+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711372635; x=1711977435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WoDV4sXNx4Iy0QllvGHLAhCC+BDrXl0CdEk2kmG14Eg=;
        b=TZdjHNwbWeuxhzjemO56Fr3xUOM+S1prD8H02Q16PDx1xrEQ0s+AtjNUxaDgSmA69k
         e/RPycnWPioBip5ythDrE1b/Oacgvv4k/EF9DcWwcnR44udTRHdWzGn8+m+AELyXYxUV
         EtNeaWhekH2h9b6iSZAcpg5BL4+pbZ6bTHpqNsjic9hSBA9hUIH6ORdgzieqTjhLVEi2
         rpdriL/UYDiK01tabA4491ok4UyJddWhPSKWkyyAz/zwP27jM8I5NBkaaUeex+Fl7TOz
         VoXDeXXIWkwtf9UChWaIzAcHNSna7d0sudGawRrfgFXqM4+Tpp5o02kMdvA/lfGGK/hn
         aGXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFEX+3Xd6OB59GB1z/GfcLHJIl3a1JwsT4fdc0WwM6XM+w7TNdw72FHMqWV02b2YjWOnSHZcwij/2Jj/oP0leVihc7SafHzTc0
X-Gm-Message-State: AOJu0Yxm+8k1JjSTs32poE4aQwfeBgFXLmPQbwPN3DDMac+lFAqXeHXL
	nKtP7OxixiTBLi9fBMrGCs0FAjovyPZcZImD8gdtQX116/sYtctQtk0O8Y9hqcc=
X-Google-Smtp-Source: AGHT+IE3ebNMN7m5QZrBKwSYnR5ua8Wq3FQ0JmQyUOhQd5yV7vQWw9/W7N3OtGBdKbdu598LkTtn0w==
X-Received: by 2002:a05:6000:1d8f:b0:341:cf6f:e044 with SMTP id bk15-20020a0560001d8f00b00341cf6fe044mr1713355wrb.62.1711372634903;
        Mon, 25 Mar 2024 06:17:14 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:75a:e000:861d:8b72:a859:4ce9])
        by smtp.gmail.com with ESMTPSA id p11-20020a056000018b00b0033e75e5f280sm9485245wrx.113.2024.03.25.06.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 06:17:14 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Saravana Kannan <saravanak@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Arnd Bergmann <arnd@arndb.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v6 12/16] PCI/pwrctl: add PCI power control core code
Date: Mon, 25 Mar 2024 14:16:20 +0100
Message-Id: <20240325131624.26023-13-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240325131624.26023-1-brgl@bgdev.pl>
References: <20240325131624.26023-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Some PCI devices must be powered-on before they can be detected on the
bus. Introduce a simple framework reusing the existing PCI OF
infrastructure.

The way this works is: a DT node representing a PCI device connected to
the port can be matched against its power control platform driver. If
the match succeeds, the driver is responsible for powering-up the device
and calling pcie_pwrctl_device_set_ready() which will trigger a PCI bus
rescan as well as subscribe to PCI bus notifications.

When the device is detected and created, we'll make it consume the same
DT node that the platform device did. When the device is bound, we'll
create a device link between it and the parent power control device.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pci/Kconfig         |   1 +
 drivers/pci/Makefile        |   1 +
 drivers/pci/pwrctl/Kconfig  |   8 +++
 drivers/pci/pwrctl/Makefile |   4 ++
 drivers/pci/pwrctl/core.c   | 136 ++++++++++++++++++++++++++++++++++++
 include/linux/pci-pwrctl.h  |  51 ++++++++++++++
 6 files changed, 201 insertions(+)
 create mode 100644 drivers/pci/pwrctl/Kconfig
 create mode 100644 drivers/pci/pwrctl/Makefile
 create mode 100644 drivers/pci/pwrctl/core.c
 create mode 100644 include/linux/pci-pwrctl.h

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index d35001589d88..aa4d1833f442 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -296,5 +296,6 @@ source "drivers/pci/hotplug/Kconfig"
 source "drivers/pci/controller/Kconfig"
 source "drivers/pci/endpoint/Kconfig"
 source "drivers/pci/switch/Kconfig"
+source "drivers/pci/pwrctl/Kconfig"
 
 endif
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 175302036890..8ddad57934a6 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_PCI)		+= access.o bus.o probe.o host-bridge.o \
 
 obj-$(CONFIG_PCI)		+= msi/
 obj-$(CONFIG_PCI)		+= pcie/
+obj-$(CONFIG_PCI)		+= pwrctl/
 
 ifdef CONFIG_PCI
 obj-$(CONFIG_PROC_FS)		+= proc.o
diff --git a/drivers/pci/pwrctl/Kconfig b/drivers/pci/pwrctl/Kconfig
new file mode 100644
index 000000000000..96195395af69
--- /dev/null
+++ b/drivers/pci/pwrctl/Kconfig
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+menu "PCI Power control drivers"
+
+config PCI_PWRCTL
+	tristate
+
+endmenu
diff --git a/drivers/pci/pwrctl/Makefile b/drivers/pci/pwrctl/Makefile
new file mode 100644
index 000000000000..52ae0640ef7b
--- /dev/null
+++ b/drivers/pci/pwrctl/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_PCI_PWRCTL)		+= pci-pwrctl-core.o
+pci-pwrctl-core-y			:= core.o
diff --git a/drivers/pci/pwrctl/core.c b/drivers/pci/pwrctl/core.c
new file mode 100644
index 000000000000..11bd19519841
--- /dev/null
+++ b/drivers/pci/pwrctl/core.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024 Linaro Ltd.
+ */
+
+#include <linux/device.h>
+#include <linux/export.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/pci-pwrctl.h>
+#include <linux/property.h>
+#include <linux/slab.h>
+
+static int pci_pwrctl_notify(struct notifier_block *nb, unsigned long action,
+			     void *data)
+{
+	struct pci_pwrctl *pwrctl = container_of(nb, struct pci_pwrctl, nb);
+	struct device *dev = data;
+
+	if (dev_fwnode(dev) != dev_fwnode(pwrctl->dev))
+		return NOTIFY_DONE;
+
+	switch (action) {
+	case BUS_NOTIFY_ADD_DEVICE:
+		/*
+		 * We will have two struct device objects bound to two different
+		 * drivers on different buses but consuming the same DT node. We
+		 * must not bind the pins twice in this case but only once for
+		 * the first device to be added.
+		 *
+		 * If we got here then the PCI device is the second after the
+		 * power control platform device. Mark its OF node as reused.
+		 */
+		dev->of_node_reused = true;
+		break;
+	case BUS_NOTIFY_BOUND_DRIVER:
+		pwrctl->link = device_link_add(dev, pwrctl->dev,
+					       DL_FLAG_AUTOREMOVE_CONSUMER);
+		if (!pwrctl->link)
+			dev_err(pwrctl->dev, "Failed to add device link\n");
+		break;
+	case BUS_NOTIFY_UNBOUND_DRIVER:
+		if (pwrctl->link)
+			device_link_del(pwrctl->link);
+		break;
+	}
+
+	return NOTIFY_DONE;
+}
+
+/**
+ * pci_pwrctl_device_set_ready() - Notify the pwrctl subsystem that the PCI
+ * device is powered-up and ready to be detected.
+ *
+ * @pwrctl: PCI power control data
+ *
+ * Returns:
+ * 0 on success, negative error number on error.
+ *
+ * Note:
+ * This function returning 0 doesn't mean the device was detected. It means,
+ * that the bus rescan was successfully started. The device will get bound to
+ * its PCI driver asynchronously.
+ */
+int pci_pwrctl_device_set_ready(struct pci_pwrctl *pwrctl)
+{
+	int ret;
+
+	if (!pwrctl->dev)
+		return -ENODEV;
+
+	pwrctl->nb.notifier_call = pci_pwrctl_notify;
+	ret = bus_register_notifier(&pci_bus_type, &pwrctl->nb);
+	if (ret)
+		return ret;
+
+	pci_lock_rescan_remove();
+	pci_rescan_bus(to_pci_dev(pwrctl->dev->parent)->bus);
+	pci_unlock_rescan_remove();
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_pwrctl_device_set_ready);
+
+/**
+ * pci_pwrctl_device_unset_ready() - Notify the pwrctl subsystem that the PCI
+ * device is about to be powered-down.
+ *
+ * @pwrctl: PCI power control data
+ */
+void pci_pwrctl_device_unset_ready(struct pci_pwrctl *pwrctl)
+{
+	/*
+	 * We don't have to delete the link here. Typically, this function
+	 * is only called when the power control device is being detached. If
+	 * it is being detached then the child PCI device must have already
+	 * been unbound too or the device core wouldn't let us unbind.
+	 */
+	bus_unregister_notifier(&pci_bus_type, &pwrctl->nb);
+}
+EXPORT_SYMBOL_GPL(pci_pwrctl_device_unset_ready);
+
+static void devm_pci_pwrctl_device_unset_ready(void *data)
+{
+	struct pci_pwrctl *pwrctl = data;
+
+	pci_pwrctl_device_set_ready(pwrctl);
+}
+
+/**
+ * devm_pci_pwrctl_device_set_ready - Managed variant of
+ * pci_pwrctl_device_set_ready().
+ *
+ * @pwrctl: PCI power control data
+ *
+ * Returns:
+ * 0 on success, negative error number on error.
+ */
+int devm_pci_pwrctl_device_set_ready(struct device *dev,
+				     struct pci_pwrctl *pwrctl)
+{
+	int ret;
+
+	ret = pci_pwrctl_device_set_ready(pwrctl);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dev,
+					devm_pci_pwrctl_device_unset_ready,
+					pwrctl);
+}
+EXPORT_SYMBOL_GPL(devm_pci_pwrctl_device_set_ready);
+
+MODULE_AUTHOR("Bartosz Golaszewski <bartosz.golaszewski@linaro.org>");
+MODULE_DESCRIPTION("PCI Device Power Control core driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/pci-pwrctl.h b/include/linux/pci-pwrctl.h
new file mode 100644
index 000000000000..ae8324ea7eeb
--- /dev/null
+++ b/include/linux/pci-pwrctl.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2024 Linaro Ltd.
+ */
+
+#ifndef __PCI_PWRCTL_H__
+#define __PCI_PWRCTL_H__
+
+#include <linux/notifier.h>
+
+struct device;
+struct device_link;
+
+/*
+ * This is a simple framework for solving the issue of PCI devices that require
+ * certain resources (regulators, GPIOs, clocks) to be enabled before the
+ * device can actually be detected on the PCI bus.
+ *
+ * The idea is to reuse the platform bus to populate OF nodes describing the
+ * PCI device and its resources, let these platform devices probe and enable
+ * relevant resources and then trigger a rescan of the PCI bus allowing for the
+ * same device (with a second associated struct device) to be registered with
+ * the PCI subsystem.
+ *
+ * To preserve a correct hierarchy for PCI power management and device reset,
+ * we create a device link between the power control platform device (parent)
+ * and the supplied PCI device (child).
+ */
+
+/**
+ * struct pci_pwrctl - PCI device power control context.
+ * @dev - Address of the power controlling device.
+ *
+ * An object of this type must be allocated by the PCI power control device and
+ * passed to the pwrctl subsystem to trigger a bus rescan and setup a device
+ * link with the device once it's up.
+ */
+struct pci_pwrctl {
+	struct device *dev;
+
+	/* Private, don't use. */
+	struct notifier_block nb;
+	struct device_link *link;
+};
+
+int pci_pwrctl_device_set_ready(struct pci_pwrctl *pwrctl);
+void pci_pwrctl_device_unset_ready(struct pci_pwrctl *pwrctl);
+int devm_pci_pwrctl_device_set_ready(struct device *dev,
+				     struct pci_pwrctl *pwrctl);
+
+#endif /* __PCI_PWRCTL_H__ */
-- 
2.40.1


