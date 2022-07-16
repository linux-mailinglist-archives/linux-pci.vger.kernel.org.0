Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78AF5771E0
	for <lists+linux-pci@lfdr.de>; Sun, 17 Jul 2022 00:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbiGPWZO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Jul 2022 18:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbiGPWZN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Jul 2022 18:25:13 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4261C929;
        Sat, 16 Jul 2022 15:25:11 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id e132so7480578pgc.5;
        Sat, 16 Jul 2022 15:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YCCHTmPrjFPoXWIObp+DoXXMNj6V9VB8iJetGZDjDyo=;
        b=W0iTid3GIlgSl8tEhYcV3CiF/KNSKIs/AlOb5ieLoO6+hWHsgN/osRIZC1ShlZtQk8
         jdGbh4X1Ef7jYShQpvVXUoIDR7yIK1ryZtYGi/K4QFJspur4+WoGP9MQCt5diPKdB/2n
         dpfWzb+g5hwQw9luJeecY18txYfovOy+NLxtO49SpkUKxJeKt5ns3pK9IZ7vDVuqCRCD
         U8xh7PZwJxwTt+VOXVQiwR39LsNjUPwThm3vr5PRM2ob0zDgLXjNXAWgznh3ZDT2PIGT
         WhqzVXeYjdIHFO0z1t/ywm76gMY/XKh9ZRz6rwgrWYRsnctD3Zb8qI4It/goIm3B+Aws
         psHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YCCHTmPrjFPoXWIObp+DoXXMNj6V9VB8iJetGZDjDyo=;
        b=mHw6P+ZMlLY/n7QD98pvZ1gdAkYOB9ytztHsnHaEBev3o/5P5MVWTy8WEI/7TEcS+z
         WQxRpOw/8ilxwGn0voIQGERsHaOtmfh3FgcR9VltjQK95zdGfRcl4ag1mfxC/lKnxcwI
         AWmoot+4CmS0LXkZ5OuWm2b4JeEOsswyNenTpSGWXNrs9jCYlYEcep60FuOnuDgeypU/
         /92wgsucAZx9jpXMJ0EqPE6PT3heyOWc2iF8KliQf6mEcXcsZs/HGq65leWXWwmjMT6Y
         Gimy5F0hx8yZXVQgnB0Pp+ng5DxoX61/hNHd3ZJAyIy/rKfFRcGqQatgT2Vo9fwENUGQ
         YZJQ==
X-Gm-Message-State: AJIora/P2tK2tvCBMkwNfv8Dk7Xp0lZgavC9+rCGxX9X/exT3dh4Bai0
        JORMlTF1rT6FuKKyCONZYJpl8AdCniU=
X-Google-Smtp-Source: AGRyM1vrhJm+8UkdAemyHNNVwZM4IaN8qX0rGATqambmGBHFmI61p6o1vOt1eEDzB1lxBo+asdY7gg==
X-Received: by 2002:aa7:9e84:0:b0:52a:e224:a0d0 with SMTP id p4-20020aa79e84000000b0052ae224a0d0mr21218760pfq.13.1658010311182;
        Sat, 16 Jul 2022 15:25:11 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id y12-20020aa78f2c000000b00528c149fe97sm6318662pfr.89.2022.07.16.15.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jul 2022 15:25:10 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 4/6] PCI: brcmstb: Add mechanism to turn on subdev regulators
Date:   Sat, 16 Jul 2022 18:24:51 -0400
Message-Id: <20220716222454.29914-5-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220716222454.29914-1-jim2101024@gmail.com>
References: <20220716222454.29914-1-jim2101024@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a mechanism to identify standard PCIe regulators in the DT, allocate
them, and turn them on before the rest of the bus is scanned during
pci_host_probe().

The allocated structure that contains the regulators is stored in the port
driver dev.driver_data field.  Here is a point-by-point of how and when
this mechanism is activated:

If:
    -- PCIe RC driver sets pci_ops {add,remove)_bus to
       pci_subdev_regulators_{add,remove}_bus during its probe.
    -- There is a root port DT node under the host bridge DT node.
    -- During the RC driver's pci_host_probe() the add_bus callback
       is invoked where (bus->parent && pci_is_root_bus(bus->parent)
       is true

Then:
    -- A struct subdev_regulators structure will be allocated and
       assigned to bus->dev.driver_data.
    -- regulator_bulk_{get,enable} will be invoked on &bus->dev
       and the former will search for and process any
       vpcie{12v,3v3,3v3aux}-supply properties that reside in the
       root port DT node.
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

  1. For example, one customer uses multiple PCIe controllers, but wants
     the ability to, by script invoking and unbind, turn any or all of them
     and their subdevices off to save power, e.g. when in battery mode.

  2. Another example is when a watchdog script discovers that an endpoint
     device is in an unresponsive state and would like to unbind, power
     toggle, and re-bind just the PCIe endpoint and controller.

  3. Of course we also want power turned off during suspend mode.  However,
     some endpoint devices may be able to "wake" during suspend and we need
     to recognise this case and veto the nominal act of turning off its
     regulator.  Such is the case with Wake-on-LAN and Wake-on-WLAN support
     where the PCIe endpoint device needs to be kept powered on in order to
     receive network packets and wake the system.

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

Link: https://lore.kernel.org/r/20220106160332.2143-6-jim2101024@gmail.com
Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 96 +++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 72219a4f3964..f98a5338fa8e 100644
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
@@ -218,6 +219,11 @@ struct pcie_cfg_data {
 	void (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
 };
 
+struct subdev_regulators {
+	unsigned int num_supplies;
+	struct regulator_bulk_data supplies[];
+};
+
 struct brcm_msi {
 	struct device		*dev;
 	void __iomem		*base;
@@ -1077,6 +1083,92 @@ static int brcm_pcie_start_link(struct brcm_pcie *pcie)
 	return 0;
 }
 
+static const char * const supplies[] = {
+	"vpcie3v3",
+	"vpcie3v3aux",
+	"vpcie12v",
+};
+
+static void *alloc_subdev_regulators(struct device *dev)
+{
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
+	if (dev->driver_data) {
+		/*
+		 * Oops, this is unfortunate.  We are using the port
+		 * driver's driver_data field to store our regulator info
+		 * and it appears that another driver started using it as
+		 * well.  If so, be a team player do not overwrite it.  We
+		 * may still be okay if there are no regulators.
+		 */
+		dev_err(dev, "root port dev.driver_data non-NULL; something wrong\n");
+		return 0;
+	}
+
+	sr = alloc_subdev_regulators(dev);
+	if (!sr)
+		return -ENOMEM;
+
+	/*
+	 * There is not much of a point to return an error as currently it
+	 * will cause a WARNING() from pci_alloc_child_bus().  So only
+	 * return the error if it is -ENOMEM.  Note that we are always
+	 * doing a dev_err() for other erros.
+	 */
+	ret = regulator_bulk_get(dev, sr->num_supplies, sr->supplies);
+	if (ret) {
+		dev_err(dev, "failed to get regulators for downstream device\n");
+		return 0;
+	}
+
+	ret = regulator_bulk_enable(sr->num_supplies, sr->supplies);
+	if (ret) {
+		dev_err(dev, "failed to enable regulators for downstream device\n");
+		regulator_bulk_free(sr->num_supplies, sr->supplies);
+		return 0;
+	}
+
+	dev->driver_data = sr;
+
+	return 0;
+}
+
+static void pci_subdev_regulators_remove_bus(struct pci_bus *bus)
+{
+	struct device *dev = &bus->dev;
+	struct subdev_regulators *sr = dev->driver_data;
+
+	if (!dev->of_node || !sr || !bus->parent || !pci_is_root_bus(bus->parent))
+		return;
+
+	if (regulator_bulk_disable(sr->num_supplies, sr->supplies))
+		dev_err(dev, "failed to disable regulators for downstream device\n");
+	regulator_bulk_free(sr->num_supplies, sr->supplies);
+	dev->driver_data = NULL;
+}
+
 /* L23 is a low-power PCIe link state */
 static void brcm_pcie_enter_l23(struct brcm_pcie *pcie)
 {
@@ -1351,12 +1443,16 @@ static struct pci_ops brcm_pcie_ops = {
 	.map_bus = brcm_pcie_map_conf,
 	.read = pci_generic_config_read,
 	.write = pci_generic_config_write,
+	.add_bus = pci_subdev_regulators_add_bus,
+	.remove_bus = pci_subdev_regulators_remove_bus,
 };
 
 static struct pci_ops brcm_pcie_ops32 = {
 	.map_bus = brcm_pcie_map_conf32,
 	.read = pci_generic_config_read32,
 	.write = pci_generic_config_write32,
+	.add_bus = pci_subdev_regulators_add_bus,
+	.remove_bus = pci_subdev_regulators_remove_bus,
 };
 
 static int brcm_pcie_probe(struct platform_device *pdev)
-- 
2.17.1

