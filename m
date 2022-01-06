Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5D3486744
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jan 2022 17:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240890AbiAFQD4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jan 2022 11:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240910AbiAFQDz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jan 2022 11:03:55 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F20DC0611FF;
        Thu,  6 Jan 2022 08:03:54 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id ie13so2836541pjb.1;
        Thu, 06 Jan 2022 08:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1Pufw6nuD1iiGPOOR6CrXzd6obJQKvUivxb5DzcAVo8=;
        b=WJkCr0NI+weYPB03yxMI8QdWRUE5FQ4an4olw9yYV01JF11DaiV+EP4Hs9Lpk7HJwV
         UTPTlRGiepdGbXWEc7P6T8nzuN+tkdvcf3WCxmwfhOQ2J8wXaYa/Ejnn4mcMs92cb5Da
         61YgUfXdUakdwO3gpsncQ+OFHXdFD2TdclZn3MM6i0HoEYptRuqxdqCy0bkUF/OPc1Yz
         yDRqGuMeM9OxNAet/KG1SJt0YJeHH70YZgbeh1CY5bK8kHfmTkD/lvvmzA24lVcpKIKA
         iYPLLfV17hk4pYjmdK69Bi4/sk8P/gG1Y8OvpFRuHzzTgaDH6ydrkX4Th3Q17MYj3Xzy
         9U5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1Pufw6nuD1iiGPOOR6CrXzd6obJQKvUivxb5DzcAVo8=;
        b=0YfP9mLiud9ItKXH1cRWpx+IPXDVeurUDIPaMGjfl7qcccZ49YlFXWmb9VXAWealIy
         t1lN6pWVrzkjzAFZac0quMvnbDcVfydqrDNBmZGD1OYYeEByBSeWwytr5Iku1RYObOc8
         SDuLm5yN1bTZAj37U4FJ0K26qk5bWFvTEXJliFlIlpXWrI11QAtf3OXxNWdV27NQHpIr
         ZKp7XHgxXuKtvGrT9PZOwb/thiVz1V8yCiehxb5rhJ3kcZXZL09V9HBGDTRJwUznpaUV
         rg6shdEAAaosY83afwlD54T80mMJxgNJuFPFvkzBvAMRzcbELbXUDV3E5QVA3Yb6i0ui
         gUIQ==
X-Gm-Message-State: AOAM532BOVzGzW/tT1TdEXSY1W1fce3T5BoVOo6esbl0jRKUEwxllRim
        L60Bk6fVr7KM1zQs4YBNOyPu9y0zyfk=
X-Google-Smtp-Source: ABdhPJxItDbWZOLh45lBkX134F/h811hcKjhUGFwo7SSgb97M6YZESoQt9a3SsklrwbR0V4dxJtw6g==
X-Received: by 2002:a17:90a:1919:: with SMTP id 25mr10847464pjg.181.1641485033651;
        Thu, 06 Jan 2022 08:03:53 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id q19sm2376316pgb.77.2022.01.06.08.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 08:03:53 -0800 (PST)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v11 5/7] PCI: brcmstb: Add mechanism to turn on subdev regulators
Date:   Thu,  6 Jan 2022 11:03:28 -0500
Message-Id: <20220106160332.2143-6-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220106160332.2143-1-jim2101024@gmail.com>
References: <20220106160332.2143-1-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a mechanism to identify standard PCIe regulators in the DT, allocate
them, and turn them on before the rest of the bus is scanned during
pci_host_probe().

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
 drivers/pci/controller/pcie-brcmstb.c | 76 +++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 5f373227aad6..7d46eccf17ff 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -24,6 +24,7 @@
 #include <linux/pci.h>
 #include <linux/pci-ecam.h>
 #include <linux/printk.h>
+#include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
@@ -257,6 +258,14 @@ static const struct pcie_cfg_data bcm2711_cfg = {
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
 };
 
+struct subdev_regulators {
+	unsigned int num_supplies;
+	struct regulator_bulk_data supplies[];
+};
+
+static int pci_subdev_regulators_add_bus(struct pci_bus *bus);
+static void pci_subdev_regulators_remove_bus(struct pci_bus *bus);
+
 struct brcm_msi {
 	struct device		*dev;
 	void __iomem		*base;
@@ -406,6 +415,71 @@ static int brcm_pcie_set_ssc(struct brcm_pcie *pcie)
 	return ssc && pll ? 0 : -EIO;
 }
 
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
+static int pci_subdev_regulators_add_bus(struct pci_bus *bus)
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
+
+static void pci_subdev_regulators_remove_bus(struct pci_bus *bus)
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
+
 /* Limits operation to a specific generation (1, 2, or 3) */
 static void brcm_pcie_set_gen(struct brcm_pcie *pcie, int gen)
 {
@@ -722,6 +796,8 @@ static struct pci_ops brcm_pcie_ops = {
 	.map_bus = brcm_pcie_map_conf,
 	.read = pci_generic_config_read,
 	.write = pci_generic_config_write,
+	.add_bus = pci_subdev_regulators_add_bus,
+	.remove_bus = pci_subdev_regulators_remove_bus,
 };
 
 static inline void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie, u32 val)
-- 
2.17.1

