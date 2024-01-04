Return-Path: <linux-pci+bounces-1670-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDD882424F
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jan 2024 14:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BD72281DA1
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jan 2024 13:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3143D24A03;
	Thu,  4 Jan 2024 13:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="QVSdXkKS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3C7241F6
	for <linux-pci@vger.kernel.org>; Thu,  4 Jan 2024 13:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3374eb61cbcso454537f8f.0
        for <linux-pci@vger.kernel.org>; Thu, 04 Jan 2024 05:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1704373330; x=1704978130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C0/NJ7KYEulil2Xeyr0vkcKQVIe4dXTk2WHu1Aal+GM=;
        b=QVSdXkKSrGsr/Oael23krHCfZal44tTq1nlfWdZZHrbCwSePZZM9VdnKpJS0ssNA2D
         gTpPNYMRrg7t6O2KPZWDqj0lZD+PoNlHkUKzzKRp7GCMWa4KzBY4F5yRz9fnVno1emGL
         jDMQVB8/C8zsMvpY+WRj2fSdL5wPhEU0sHT81qfAOvVaxZiQKwwDM/boHYRy0ZvqXoi8
         lzT0JjScoJt8MsJeeWWs3IkS+ZVdP9ZY8SmnyYuxXpqJxXvXq7K89oRhD0JCSZ+e8fnE
         O5UctSqi6JDo9rtbjHS0jSHddF6ZiI/tJ71PX/nPrUdUKx+A9fhqx2puXedraOtIDloe
         rD9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704373330; x=1704978130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C0/NJ7KYEulil2Xeyr0vkcKQVIe4dXTk2WHu1Aal+GM=;
        b=sSYeZf8bocnIeFe5/gDPJp5+OhngFQHPaZIYaoZHmrFbG0nKEqaB3MpaZW4K/G0zMD
         tfAndVha9Zi1olOqPKtqc27/nHjrZzoEVflq5tB8YLOyv3YjGoIOonoq/IA44srxPCfy
         L1ePxv+Ma9QSIYa8r1/KkGpkTt8j28DWAKiIFlU4luNPhccpFo6v9TsOgy8l0cWsg4Vl
         Yemvva70yixTuRo7+XWnJcuOIQr+U117oN5Jtx47ReePwm8w9Sf8Ktk/tU6o3Ch2kN4e
         JtiXx/3jlM1FgDtdIq/jdljB40yzmfJgFUG9LOsv9yy8cnoAASg+FR4VkBzWHcaxwfH8
         3U5g==
X-Gm-Message-State: AOJu0Yz22KpO/gyazG/MaOouwI+wwnluTKyreoZAwkwDgHVgrAbSoNKl
	SfI6+iAXDFP3Ox/V7D8GL/cnRU6Zy341ZA==
X-Google-Smtp-Source: AGHT+IH1sAH1RUXIP7DjQNVAHdST7oR7mT24OIBd+gWvZXVas72o61+b25pqunGvVU+Vz6z5WhqhXQ==
X-Received: by 2002:adf:ce88:0:b0:336:7590:bd34 with SMTP id r8-20020adfce88000000b003367590bd34mr378455wrn.6.1704373330194;
        Thu, 04 Jan 2024 05:02:10 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:5b69:3768:8459:8fee])
        by smtp.gmail.com with ESMTPSA id w5-20020a5d5445000000b0033660f75d08sm32887387wrv.116.2024.01.04.05.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 05:02:09 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Kalle Valo <kvalo@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Arnd Bergmann <arnd@arndb.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	=?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= <nfraprado@collabora.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Peng Fan <peng.fan@nxp.com>,
	Robert Richter <rrichter@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [RFC 5/9] PCI/pwrseq: add pwrseq core code
Date: Thu,  4 Jan 2024 14:01:19 +0100
Message-Id: <20240104130123.37115-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240104130123.37115-1-brgl@bgdev.pl>
References: <20240104130123.37115-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Some PCIe devices must be powered-on before they can be detected on the
bus. Introduce a simple framework built around the PCIe port driver
which now instantiates its child devices from device-tree.

The way this works is: a DT node representing a PCIe device connected to
the port can be matched against its power sequencing platform driver. If
the match succeeds, the driver is responsible for powering-up the device
and calling pcie_pwrseq_device_enable() which will trigger a PCI bus
rescan as well as subscribe to PCI bus notifications.

When the device is detected and created, we'll make it consume the same
DT node that the platform device did. When the device is bound, we'll
create a device link between it and the parent power sequencing device.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pci/pcie/Kconfig         |  2 +
 drivers/pci/pcie/Makefile        |  2 +
 drivers/pci/pcie/pwrseq/Kconfig  |  8 +++
 drivers/pci/pcie/pwrseq/Makefile |  3 ++
 drivers/pci/pcie/pwrseq/pwrseq.c | 83 ++++++++++++++++++++++++++++++++
 include/linux/pcie-pwrseq.h      | 24 +++++++++
 6 files changed, 122 insertions(+)
 create mode 100644 drivers/pci/pcie/pwrseq/Kconfig
 create mode 100644 drivers/pci/pcie/pwrseq/Makefile
 create mode 100644 drivers/pci/pcie/pwrseq/pwrseq.c
 create mode 100644 include/linux/pcie-pwrseq.h

diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index 8999fcebde6a..064843ab6866 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -155,3 +155,5 @@ config PCIE_EDR
 	  the PCI Firmware Specification r3.2.  Enable this if you want to
 	  support hybrid DPC model which uses both firmware and OS to
 	  implement DPC.
+
+source "drivers/pci/pcie/pwrseq/Kconfig"
diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
index 8de4ed5f98f1..ace91384113d 100644
--- a/drivers/pci/pcie/Makefile
+++ b/drivers/pci/pcie/Makefile
@@ -13,3 +13,5 @@ obj-$(CONFIG_PCIE_PME)		+= pme.o
 obj-$(CONFIG_PCIE_DPC)		+= dpc.o
 obj-$(CONFIG_PCIE_PTM)		+= ptm.o
 obj-$(CONFIG_PCIE_EDR)		+= edr.o
+
+obj-$(CONFIG_PCIEPORTBUS)	+= pwrseq/
diff --git a/drivers/pci/pcie/pwrseq/Kconfig b/drivers/pci/pcie/pwrseq/Kconfig
new file mode 100644
index 000000000000..010e31f432c9
--- /dev/null
+++ b/drivers/pci/pcie/pwrseq/Kconfig
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+
+menuconfig PCIE_PWRSEQ
+	bool "PCIe Power Sequencing support"
+	depends on PCIEPORTBUS
+	help
+	  Say yes here to enable support for PCIe power sequencing
+	  drivers.
diff --git a/drivers/pci/pcie/pwrseq/Makefile b/drivers/pci/pcie/pwrseq/Makefile
new file mode 100644
index 000000000000..da99566594f6
--- /dev/null
+++ b/drivers/pci/pcie/pwrseq/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_PCIE_PWRSEQ)		+= pwrseq.o
diff --git a/drivers/pci/pcie/pwrseq/pwrseq.c b/drivers/pci/pcie/pwrseq/pwrseq.c
new file mode 100644
index 000000000000..c4f7958074c9
--- /dev/null
+++ b/drivers/pci/pcie/pwrseq/pwrseq.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 Linaro Ltd.
+ */
+
+#include <linux/cleanup.h>
+#include <linux/device.h>
+#include <linux/export.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/pcie-pwrseq.h>
+#include <linux/property.h>
+#include <linux/slab.h>
+
+static int pcie_pwrseq_notify(struct notifier_block *nb, unsigned long action,
+			      void *data)
+{
+	struct pcie_pwrseq *pwrseq = container_of(nb, struct pcie_pwrseq, nb);
+	struct device *dev = data;
+
+	if (dev_fwnode(dev) != dev_fwnode(pwrseq->dev))
+		return NOTIFY_DONE;
+
+	switch (action) {
+	case BUS_NOTIFY_ADD_DEVICE:
+		device_set_of_node_from_dev(dev, pwrseq->dev);
+		break;
+	case BUS_NOTIFY_BOUND_DRIVER:
+		pwrseq->link = device_link_add(dev, pwrseq->dev,
+					       DL_FLAG_AUTOREMOVE_CONSUMER);
+		if (!pwrseq->link)
+			dev_err(pwrseq->dev, "Failed to add device link\n");
+		break;
+	case BUS_NOTIFY_UNBOUND_DRIVER:
+		device_link_del(pwrseq->link);
+		break;
+	}
+
+	return NOTIFY_DONE;
+}
+
+int pcie_pwrseq_device_enable(struct pcie_pwrseq *pwrseq)
+{
+	if (!pwrseq->dev)
+		return -ENODEV;
+
+	pwrseq->nb.notifier_call = pcie_pwrseq_notify;
+	bus_register_notifier(&pci_bus_type, &pwrseq->nb);
+
+	pci_lock_rescan_remove();
+	pci_rescan_bus(to_pci_dev(pwrseq->dev->parent)->bus);
+	pci_unlock_rescan_remove();
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pcie_pwrseq_device_enable);
+
+void pcie_pwrseq_device_disable(struct pcie_pwrseq *pwrseq)
+{
+	bus_unregister_notifier(&pci_bus_type, &pwrseq->nb);
+}
+EXPORT_SYMBOL_GPL(pcie_pwrseq_device_disable);
+
+static void devm_pcie_pwrseq_device_disable(void *data)
+{
+	struct pcie_pwrseq *pwrseq = data;
+
+	pcie_pwrseq_device_disable(pwrseq);
+}
+
+int devm_pcie_pwrseq_device_enable(struct device *dev,
+				   struct pcie_pwrseq *pwrseq)
+{
+	int ret;
+
+	ret = pcie_pwrseq_device_enable(pwrseq);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dev, devm_pcie_pwrseq_device_disable,
+					pwrseq);
+}
+EXPORT_SYMBOL_GPL(devm_pcie_pwrseq_device_enable);
diff --git a/include/linux/pcie-pwrseq.h b/include/linux/pcie-pwrseq.h
new file mode 100644
index 000000000000..6abb5796754e
--- /dev/null
+++ b/include/linux/pcie-pwrseq.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2024 Linaro Ltd.
+ */
+
+#ifndef __PCIE_PWRSEQ_H__
+#define __PCIE_PWRSEQ_H__
+
+#include <linux/notifier.h>
+
+struct device;
+
+struct pcie_pwrseq {
+	struct notifier_block nb;
+	struct device *dev;
+	struct device_link *link;
+};
+
+int pcie_pwrseq_device_enable(struct pcie_pwrseq *pwrseq);
+void pcie_pwrseq_device_disable(struct pcie_pwrseq *pwrseq);
+int devm_pcie_pwrseq_device_enable(struct device *dev,
+				   struct pcie_pwrseq *pwrseq);
+
+#endif /* __PCIE_PWRSEQ_H__ */
-- 
2.40.1


