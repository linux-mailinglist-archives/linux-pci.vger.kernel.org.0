Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63FA58017D
	for <lists+linux-pci@lfdr.de>; Mon, 25 Jul 2022 17:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236271AbiGYPQj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Jul 2022 11:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236284AbiGYPQK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Jul 2022 11:16:10 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B181AF24;
        Mon, 25 Jul 2022 08:13:37 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id c13so3968904pla.6;
        Mon, 25 Jul 2022 08:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=edERAY+W+H8xhkt0YCtw/+TrmSGvoLSrgsbiPZWxo1M=;
        b=UDP6QyDPlufFmbTy8VQCrHP42wyCskSWjF2zPuud5pMczdl6GbM6D8bN89NWSZ4hQQ
         tF/pJakz0tYHrYxexzU1aNRfQ9TLRFKRLCglMYcW77K2Ydx1qN76V3huI1jU7X6KdqRr
         OLPib1LuuE6so0BUWiDxC+aL6Sm7aITXo0OH8zzr+CiFaOWuIBi8pg/J1QiHSHD7yWUj
         bgEohqYHOk0z7Znhfd1hO0uO91Ul9KvTsgqw8UdP7W0AxXhTdtxotsgObo/uwtXPUqT+
         FRc7Teddza1fGCnJSsGHp+uArSwJoaPMHrt5EKmlBPV4aI2rObaSZkJhC+QABPcB3JSQ
         4+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=edERAY+W+H8xhkt0YCtw/+TrmSGvoLSrgsbiPZWxo1M=;
        b=KOjBZkAPF2rQIq2+EtMFqGkH00cqO9HjLBM1+FlfEV4Svm7xIooi9ZA3v36a3ko226
         O3inarzO65BWZ+N1o5mUwuKRXcL8Iq5zUY4T8gpLoVhVsLfbypcOlSOGKGvl9ByqLc7W
         gYy3s+2LkR9HYixwNk8V1FYonRPXPiaXYF4DYz39iwZByQAgKkGpfpWt4xRVQakFgne7
         LTAs+e6l+fET/d5dsn28KuYm7/o13lMuWjY6fXK37pZRL8qms8IKKk4KOFgWzfGOI+H3
         ppO21dczYdtpe5jy6eV2nT8eTmzL4HK7Ie1PiSRJeDSlR9GoLiEdULJRdhI8fAeBrVtM
         gE+A==
X-Gm-Message-State: AJIora+ksyUvEewbg/Ze2kXWYe7UEINvVDuqn7UA4lNaoXYUXtEMFSn9
        QF2PDk0xVhCyhScSARdYHZnaj9816Is=
X-Google-Smtp-Source: AGRyM1sSUDuX+xnwkkAVMFJXj5KVqkNcQeCnhtjYu7jL33O/Td6gUjb2DbJFnpP9PujuFAk2qrMr7Q==
X-Received: by 2002:a17:90a:9b03:b0:1f1:85b2:c52b with SMTP id f3-20020a17090a9b0300b001f185b2c52bmr33387441pjp.159.1658762013809;
        Mon, 25 Jul 2022 08:13:33 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902ecc900b001641b2d61d4sm6649667plh.30.2022.07.25.08.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 08:13:33 -0700 (PDT)
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
Subject: [PATCH v3 4/7] PCI: brcmstb: Add mechanism to turn on subdev regulators
Date:   Mon, 25 Jul 2022 11:12:53 -0400
Message-Id: <20220725151258.42574-5-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220725151258.42574-1-jim2101024@gmail.com>
References: <20220725151258.42574-1-jim2101024@gmail.com>
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
off/on standard PCIe regulators.  Typically, the drivers of endpoint
devices are stock Linux drivers that are not aware that these regulator(s)
exist and must be turned on for the driver to be probed.  The simple
solution of course is to turn these regulators on at boot and keep them on.
However, this solution does not satisfy at least three of our usage modes:

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

[1] The 99% configuration of our boards is a single endpoint device
    attached to the PCIe controller.  I use the term endpoint but it could
    possibly mean a switch as well.

Link: https://lore.kernel.org/r/20220106160332.2143-6-jim2101024@gmail.com
Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 96 +++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 3443206d2a95..1be6e71142d8 100644
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
@@ -1065,6 +1071,92 @@ static int brcm_pcie_start_link(struct brcm_pcie *pcie)
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
@@ -1336,12 +1428,16 @@ static struct pci_ops brcm_pcie_ops = {
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

