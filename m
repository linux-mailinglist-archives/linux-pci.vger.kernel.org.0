Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6EE646F5BF
	for <lists+linux-pci@lfdr.de>; Thu,  9 Dec 2021 22:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbhLIVSA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Dec 2021 16:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbhLIVR7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Dec 2021 16:17:59 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCF6C061746;
        Thu,  9 Dec 2021 13:14:25 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id k6-20020a17090a7f0600b001ad9d73b20bso5878295pjl.3;
        Thu, 09 Dec 2021 13:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HMfxv0VUowhSTWkfqtHKWA4mWDsGxDgikeURaapabM0=;
        b=hY7DqIE1K242zaJ9ws+SQ+gdXVFPCsEK8c+MfuIuTWfX39U3lh9PNMUfSNzo0Yl/Gb
         wkirUweAjf8yEkrlV2xDEyZd8teJRsbXUEKWBicr6b26U+oO1GrAjBvhTq9kVo4t9iHb
         r3K2JCgXJu8yT+QUayn4N3yATRVwF1S04EiRnHUxJ56J6uuwgTkdAdXtE8a62Mfj8zUZ
         fdEZYLF6NT48TvAhu8NM4kjsM1X8bYgHWXLGasVIlPPc0KkMG2E2P0dc1svVlwm0rP6l
         QeaduXHfQsZ4H1i7gMfzjG9Rabhu+ybYclq+Yu8uIvoRaGjXz30uNzpws8fPlY3kYR8J
         LK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HMfxv0VUowhSTWkfqtHKWA4mWDsGxDgikeURaapabM0=;
        b=ksTe+jI+w+w0I21k8EwEgV2wHXq1jgEm5F5TvzvMGQtDyIqb9F7bf67AA3bEK4cC+Z
         b4cBQw5e5sbBOKYL8KNsOASzr/BKtrbT7znE5MQeiPQX/VXOGV7Xix/afvmFqbjBZ9T7
         Mk7yRkNtqpYFeEWoiawzq2w2BkGbALKVIN9ro0s0Z0pTkW0iOt3MtBmSx4UwZ6Q4V7Mx
         7frw8I9PHJ8ihPVvVLW8YNJVEz1xuKuKcYKQY3IvQRtsAdI+RvooSM6lL4ntoYWmOXo1
         sQlEMejF05u22/6XFgqVhdV3hgwctO27XDV9x7cqHQjtJoSakjh5ZvTyZruiCS5nzb/f
         Eg2A==
X-Gm-Message-State: AOAM5338HqsyNtKgak4N9PJawUNbuW8Q34lNhyfTxBYW9EBxCcdD6aQ+
        jiQvwoDz15KJ9yXqUyaJCAgZ4PDeHM8=
X-Google-Smtp-Source: ABdhPJxV1OJS8CTkEVfoVqgG8fjDm5IYkTeuJbcEHZpzV8xH1z5AkqGy6rQDasLrX6skRlSTDpka1A==
X-Received: by 2002:a17:90b:2252:: with SMTP id hk18mr18771621pjb.36.1639084464837;
        Thu, 09 Dec 2021 13:14:24 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id y4sm617800pfi.178.2021.12.09.13.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 13:14:24 -0800 (PST)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v10 4/7] PCI: Add mechanism to turn on subdev regulators
Date:   Thu,  9 Dec 2021 16:14:02 -0500
Message-Id: <20211209211407.8102-5-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211209211407.8102-1-jim2101024@gmail.com>
References: <20211209211407.8102-1-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a mechanism to identify standard PCIe regulators in the DT, allocate
them, and turn them on before the rest of the bus is scanned during
pci_host_probe().  A root complex driver can leverage this mechanism by
setting the pci_ops methods add_bus and remove_bus to
pci_subdev_regulators_{add,remove}_bus.  If the root complex driver needs
to control the regulators on suspend or resume, it must grab the regulator
object pointer during the add_bus call by wrapping
pci_subdev_regulators_bus() with its own add_bus function.

The allocated structure that contains the regulators is stored in the port
driver dev.driver_data field.  Here is a point-by-point of how and
when this mechanism is activated:

If:
    -- PCIe RC driver sets pci_ops {add,remove)_bus to
       pci_subdev_regulators_{add,remove}_bus during its probe.
    -- There is a DT node "RB" under the host bridge DT node.
    -- During the RC driver's pci_host_probe() the add_bus callback
       is invoked where (bus->parent && pci_is_root_bus(bus->parent)
       is true

Then:
    -- A struct subdev_regulators structure will be allocated and
       assigned to bus->dev.driver_data.
    -- regulator_bulk_{get,enable} will be invoked on &bus->dev
       and the former will search for and process any
       vpcie{12v,3v3,3v3aux}-supply properties that reside in node "RB".
    -- The regulators will be turned off/on for any unbind/bind operations.
    -- The regulators will be turned off/on for any suspend/resumes, but
       only if the RC driver handles this on its own.  This will appear
       in a later commit for the pcie-brcmstb.c driver.

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
    endpoint chip.  Sometimes they may be the official PCIe socket
    power -- such as 3.3v or aux-3.3v.  Sometimes they are truly
    the regulator(s) that supply power to the EP chip.

[2] The 99% configuration of our boards is a single endpoint device
    attached to the PCIe controller.  I use the term endpoint but it could
    possibly mean a switch as well.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 drivers/pci/bus.c | 67 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h |  8 ++++++
 2 files changed, 75 insertions(+)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 3cef835b375f..c2d867d19491 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -419,3 +419,70 @@ void pci_bus_put(struct pci_bus *bus)
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
+	if (sr) {
+		sr->num_supplies = ARRAY_SIZE(supplies);
+		for (i = 0; i < ARRAY_SIZE(supplies); i++)
+			sr->supplies[i].supply = supplies[i];
+	}
+
+	return sr;
+}
+
+int pci_subdev_regulators_add_bus(struct pci_bus *bus)
+{
+	struct device *dev = &bus->dev;
+	struct subdev_regulators *sr;
+	int ret;
+
+	if (!dev->of_node || !bus->parent || !pci_is_root_bus(bus->parent))
+		return 0;
+
+	if (dev->driver_data)
+		dev_err(dev, "dev.driver_data unexpectedly non-NULL\n");
+
+	sr = alloc_subdev_regulators(dev);
+	if (!sr)
+		return -ENOMEM;
+
+	dev->driver_data = sr;
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
+	struct subdev_regulators *sr = dev->driver_data;
+
+	if (!sr || !bus->parent || !pci_is_root_bus(bus->parent))
+		return;
+
+	if (regulator_bulk_disable(sr->num_supplies, sr->supplies))
+		dev_err(dev, "failed to disable regulators for downstream device\n");
+	dev->driver_data = NULL;
+}
+EXPORT_SYMBOL_GPL(pci_subdev_regulators_remove_bus);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 3d60cabde1a1..7798a5d65ad2 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -3,6 +3,7 @@
 #define DRIVERS_PCI_H
 
 #include <linux/pci.h>
+#include <linux/regulator/consumer.h>
 
 /* Number of possible devfns: 0.0 to 1f.7 inclusive */
 #define MAX_NR_DEVFNS 256
@@ -761,4 +762,11 @@ static inline pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
 }
 #endif
 
+struct subdev_regulators {
+	unsigned int num_supplies;
+	struct regulator_bulk_data supplies[];
+};
+int pci_subdev_regulators_add_bus(struct pci_bus *bus);
+void pci_subdev_regulators_remove_bus(struct pci_bus *bus);
+
 #endif /* DRIVERS_PCI_H */
-- 
2.17.1

