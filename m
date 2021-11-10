Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6D5144CC69
	for <lists+linux-pci@lfdr.de>; Wed, 10 Nov 2021 23:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233888AbhKJWUr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Nov 2021 17:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233634AbhKJWUZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Nov 2021 17:20:25 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD966C0797BB;
        Wed, 10 Nov 2021 14:15:18 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id t21so4169339plr.6;
        Wed, 10 Nov 2021 14:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q7xWPiqvj4XKHulLL1eHGbq1NYyNecAyqUmvtMj9j7w=;
        b=QR6XZHmd0BXUwooTKVbLqU2AwFFmj6g69MCF+N2YBxp/jaM7bPyzg8K5Gg3NvdXlyt
         nibfLpKWNpQ6a7dfhoYMAWOer8FpC6Ry+OmWxo3QVf1kusc35j75rnOHrGttrdZWZse7
         6bs6L5iAeCTqCp/almtWS9LNJCXtAeIw61gkeY+yO6M9AWqCezquoJ8CS4KShEmOcq0T
         iGkjtX7rlqJNdwOJpxeE3cT3gaLQcKB7F70T8m96TfRxHLLNPkumSYeqi9HejX7jqM0F
         3kYjfklE8ouhTuIHKiOwaq0QbcpqMjF8uw6vFYlGh+6aUTNSMY76fYU+cOfTQ8NbF6M/
         JVbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q7xWPiqvj4XKHulLL1eHGbq1NYyNecAyqUmvtMj9j7w=;
        b=V+LzDT7v6e9foPXb4SLftyAgtFDop84W/q12JIVYpcMfh4G3uuFSuFksa9eC5MGAg5
         JIH1lOVKrdBI48TmwdfqlZYKVm0PX3ZkfxNpiknZG+Ckk/mZcxHOME5nSYlHZOjDYeMo
         7bjS1KA5V1vKZ9xP9MWgkXO91b/BTssBPhNxzx56qAAqD/njGVZYrnG8an27c7CAa7Yt
         Wwfh8xhFxeAfxJN9ysCasDF2dSj/HT9ZfNgkUgtzA/NjHrYo+FCCSFO63IOe2+N1WPyZ
         PcvDpa9uOCoufYKsxKKjOpOTaMJZjkt6F5/mRpevYmKu8+NIUCPmHpOyM34yt9MKwfY8
         weeQ==
X-Gm-Message-State: AOAM532nu0YULT0Wy9KpRCweYs/B8GiDsjPAxzWsT7oRIjY/bvif13ft
        sz/W3uP3TSfisd4Ktl0ypcdRTyA6UGqHyw==
X-Google-Smtp-Source: ABdhPJwLPOD4QxrDI9PlH7wLItzHcT6GvwnsdoaBPqIc3Vf7Izp64gYM5DaA7CtcrNhLATsZFHePgg==
X-Received: by 2002:a17:902:d2cd:b0:141:fbe2:b658 with SMTP id n13-20020a170902d2cd00b00141fbe2b658mr2726438plc.49.1636582518017;
        Wed, 10 Nov 2021 14:15:18 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id q11sm611774pfk.192.2021.11.10.14.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 14:15:17 -0800 (PST)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Sean V Kelley <sean.v.kelley@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Keith Busch <kbusch@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v8 5/8] PCI/portdrv: add mechanism to turn on subdev regulators
Date:   Wed, 10 Nov 2021 17:14:45 -0500
Message-Id: <20211110221456.11977-6-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211110221456.11977-1-jim2101024@gmail.com>
References: <20211110221456.11977-1-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Adds a mechanism inside the root port device to identify standard PCIe
regulators in the DT, allocate them, and turn them on before the rest of
the bus is scanned during pci_host_probe().  A root complex driver can
leverage this mechanism by setting the pci_ops methods add_bus and
remove_bus to pci_subdev_regulators_{add,remove}_bus.

The allocated structure that contains the regulators is stored in
dev.driver_data.

The unabridged reason for doing this is as follows.  We would like the
Broadcom STB PCIe root complex driver (and others) to be able to turn
off/on regulators[1] that provide power to endpoint[2] devices.  Typically,
the drivers of these endpoint devices are stock Linux drivers that are not
aware that these regulator(s) exist and must be turned on for the driver to
be probed.  The simple solution of course is to turn these regulators on at
boot and keep them on.  However, this solution does not satisfy at least
three of our usage modes:

1. For example, one customer uses multiple PCIe controllers, but wants the
ability to, by script invoking and unbind, turn any or all of them by and
their subdevices off to save power, e.g. when in battery mode.

2. Another example is when a watchdog script discovers that an endpoint
device is in an unresponsive state and would like to unbind, power toggle,
and re-bind just the PCIe endpoint and controller.

3. Of course we also want power turned off during suspend mode.  However,
some endpoint devices may be able to "wake" during suspend and we need to
recognise this case and veto the nominal act of turning off its regulator.
Such is the case with Wake-on-LAN and Wake-on-WLAN support where PCIe
end-point device needs to be kept powered on in order to receive network
packets and wake-up the system.

In all of these cases it is advantageous for the PCIe controller to govern
the turning off/on the regulators needed by the endpoint device.  The first
two cases can be done by simply unbinding and binding the PCIe controller,
if the controller has control of these regulators.

[1] These regulators typically govern the actual power supply to the
    endpoint chip.  Sometimes they may be a the official PCIe socket
    power -- such as 3.3v or aux-3.3v.  Sometimes they are truly
    the regulator(s) that supply power to the EP chip.

[2] The 99% configuration of our boards is a single endpoint device
    attached to the PCIe controller.  I use the term endpoint but it could
    possible mean a switch as well.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 drivers/pci/bus.c              | 72 ++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h              |  8 ++++
 drivers/pci/pcie/portdrv_pci.c | 32 +++++++++++++++
 3 files changed, 112 insertions(+)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 3cef835b375f..c39fdf36b0ad 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -419,3 +419,75 @@ void pci_bus_put(struct pci_bus *bus)
 	if (bus)
 		put_device(&bus->dev);
 }
+
+static void *alloc_subdev_regulators(struct device *dev)
+{
+	static const char * const supplies[] = {
+		"vpcie3v3",
+		"vpcie3v3aux",
+		"vpcie12v",
+	};
+	const size_t size = sizeof(struct subdev_regulators)
+		+ sizeof(struct regulator_bulk_data) * ARRAY_SIZE(supplies);
+	struct subdev_regulators *sr;
+	int i;
+
+	sr = devm_kzalloc(dev, size, GFP_KERNEL);
+
+	if (sr) {
+		sr->num_supplies = ARRAY_SIZE(supplies);
+		for (i = 0; i < ARRAY_SIZE(supplies); i++)
+			sr->supplies[i].supply = supplies[i];
+	}
+
+	return sr;
+}
+
+
+int pci_subdev_regulators_add_bus(struct pci_bus *bus)
+{
+	struct device *dev = &bus->dev;
+	struct subdev_regulators *sr;
+	int ret;
+
+	if (!pcie_is_port_dev(bus->self))
+		return 0;
+
+	if (WARN_ON(bus->dev.driver_data))
+		dev_err(dev, "multiple clients using dev.driver_data\n");
+
+	sr = alloc_subdev_regulators(&bus->dev);
+	if (!sr)
+		return -ENOMEM;
+
+	bus->dev.driver_data = sr;
+	ret = regulator_bulk_get(dev, sr->num_supplies, sr->supplies);
+	if (ret)
+		return ret;
+
+	ret = regulator_bulk_enable(sr->num_supplies, sr->supplies);
+	if (ret) {
+		dev_err(dev, "failed to enable regulators for downstream device\n");
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_subdev_regulators_add_bus);
+
+void pci_subdev_regulators_remove_bus(struct pci_bus *bus)
+{
+	struct device *dev = &bus->dev;
+	struct subdev_regulators *sr;
+
+	if (!pcie_is_port_dev(bus->self))
+		return;
+
+	sr = bus->dev.driver_data;
+	if (!sr)
+		return;
+
+	if (regulator_bulk_disable(sr->num_supplies, sr->supplies))
+		dev_err(dev, "failed to disable regulators for downstream device\n");
+}
+EXPORT_SYMBOL_GPL(pci_subdev_regulators_remove_bus);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index c2bd1995d3a9..3f6cf75b91cc 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -3,6 +3,7 @@
 #define DRIVERS_PCI_H
 
 #include <linux/pci.h>
+#include <linux/regulator/consumer.h>
 
 /* Number of possible devfns: 0.0 to 1f.7 inclusive */
 #define MAX_NR_DEVFNS 256
@@ -744,6 +745,13 @@ extern const struct attribute_group aspm_ctrl_attr_group;
 
 extern const struct attribute_group pci_dev_reset_method_attr_group;
 
+struct subdev_regulators {
+	unsigned int num_supplies;
+	struct regulator_bulk_data supplies[];
+};
+
 bool pcie_is_port_dev(struct pci_dev *dev);
+int pci_subdev_regulators_add_bus(struct pci_bus *bus);
+void pci_subdev_regulators_remove_bus(struct pci_bus *bus);
 
 #endif /* DRIVERS_PCI_H */
diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index 63f2a87e9db8..9330cfbebdc1 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/aer.h>
 #include <linux/dmi.h>
+#include <linux/regulator/consumer.h>
 
 #include "../pci.h"
 #include "portdrv.h"
@@ -35,6 +36,9 @@ bool pcie_ports_native;
  */
 bool pcie_ports_dpc_native;
 
+/* forward declaration */
+static struct pci_driver pcie_portdriver;
+
 static int __init pcie_port_setup(char *str)
 {
 	if (!strncmp(str, "compat", 6))
@@ -107,6 +111,26 @@ bool pcie_is_port_dev(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(pcie_is_port_dev);
 
+static int subdev_regulator_resume(struct pci_dev *dev)
+{
+	struct subdev_regulators *sr = dev->dev.driver_data;
+
+	if (sr)
+		return regulator_bulk_enable(sr->num_supplies, sr->supplies);
+
+	return 0;
+}
+
+static int subdev_regulator_suspend(struct pci_dev *dev, pm_message_t state)
+{
+	struct subdev_regulators *sr = dev->dev.driver_data;
+
+	if (sr)
+		return regulator_bulk_disable(sr->num_supplies, sr->supplies);
+
+	return 0;
+}
+
 /*
  * pcie_portdrv_probe - Probe PCI-Express port devices
  * @dev: PCI-Express port device being probed
@@ -131,6 +155,13 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
 	if (status)
 		return status;
 
+	if (dev->bus->ops &&
+	    dev->bus->ops->add_bus &&
+	    dev->bus->dev.driver_data) {
+		pcie_portdriver.resume = subdev_regulator_resume;
+		pcie_portdriver.suspend = subdev_regulator_suspend;
+	}
+
 	pci_save_state(dev);
 
 	dev_pm_set_driver_flags(&dev->dev, DPM_FLAG_NO_DIRECT_COMPLETE |
@@ -237,6 +268,7 @@ static struct pci_driver pcie_portdriver = {
 	.err_handler	= &pcie_portdrv_err_handler,
 
 	.driver.pm	= PCIE_PORTDRV_PM_OPS,
+	/* Note: suspend and resume may be set during probe */
 };
 
 static int __init dmi_pcie_pme_disable_msi(const struct dmi_system_id *d)
-- 
2.17.1

