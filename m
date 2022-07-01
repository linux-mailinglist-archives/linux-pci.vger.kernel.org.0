Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511865637E0
	for <lists+linux-pci@lfdr.de>; Fri,  1 Jul 2022 18:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbiGAQ1e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Jul 2022 12:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbiGAQ1d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Jul 2022 12:27:33 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE7B41980;
        Fri,  1 Jul 2022 09:27:32 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id f14so2228904qkm.0;
        Fri, 01 Jul 2022 09:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q1bSa1Enxk8dOg3uJ27rswSPHTWqUqGgjCSi/orQLBI=;
        b=lI90fg2LSW0wSCgQN5uwLQptkv/hqAZqred4t+1lg4kyJD6vwV9wWy5ZIMZlJB4gQI
         RCijrLaJbSXEwJsJepfucnqWSzXN4+yNo4XLqNtxx+Nsn2jbAbVy3hQpiUsGrmodOJa5
         TWyP5SUivSSDVIC7dqV0hKRgd2pDp0tnIYMd2ByCr+nZZSvtYG+iRa2uKhhQMPC56zSv
         cIpmu0SMlswPNKv2p7du/P9oMs9FjdXs0o67PwwLDmVCbjLys+wS3kyS4QXciRuQm0+w
         mf7HNUqTltau3uNQpbihAQ0HTJXDosnp+setFHb/xTHLryKzjtPoxNAuUBkeP2ac12VN
         5VZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q1bSa1Enxk8dOg3uJ27rswSPHTWqUqGgjCSi/orQLBI=;
        b=t4X8lP2YFWHNf3Fr9vhftGU3AXQ3RDbRHyhGcevMUa3XVJr+IRSRB3KSQejBOE8zhy
         KvHxKDSwXKlk2PVUaj9QlpyTRr5ew8IhTHouHkOxG+FUcxXYJ/0211rcNmgt9jo750If
         6ZFJQiESw3gxXgTINOelhrRLD6aOWeVPT0v4nsKG7XSNfgxstoSOMTaCanwU9eFG0XQ4
         Y0p8fFtZLNAwObTUgKNoQRVddqs/woPx13RYJhN3/jpynOn3zHdzVxL2DSqNe+ow0vHW
         vLW2aXDDda0z0aQKgyog0DUThr0+aaLiFtqMpESI1M6ohYjEtV2Odk9QM9tpwa4dBGRp
         rCCg==
X-Gm-Message-State: AJIora+px+wIJTaXsLmJYdAxRYuaAll14Mxv/h4Y/lRpDhpKu2JvN8W+
        VPAlDLa3DeyFyUiN8RcJxuO1zMeYzmk=
X-Google-Smtp-Source: AGRyM1uue27+lyNkRF70Hklh8m/RUNbCiTJO/0HHR05P/3ABIeEbYIssGKI7syBdSdnHkgcc37IqXQ==
X-Received: by 2002:a05:620a:371e:b0:6b0:5cde:c60b with SMTP id de30-20020a05620a371e00b006b05cdec60bmr11391956qkb.307.1656692851202;
        Fri, 01 Jul 2022 09:27:31 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id w4-20020a05620a424400b006af08c26774sm17316175qko.47.2022.07.01.09.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 09:27:30 -0700 (PDT)
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
Subject: [PATCH v1 2/4] PCI: brcmstb: Add mechanism to turn on subdev regulators
Date:   Fri,  1 Jul 2022 12:27:23 -0400
Message-Id: <20220701162726.31346-3-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220701162726.31346-1-jim2101024@gmail.com>
References: <20220701162726.31346-1-jim2101024@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/pci/controller/pcie-brcmstb.c | 77 +++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 2bf5cc399fd0..661d3834c6da 100644
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
@@ -283,6 +284,14 @@ static const struct pcie_cfg_data bcm2711_cfg = {
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
@@ -436,6 +445,72 @@ static int brcm_pcie_set_ssc(struct brcm_pcie *pcie)
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
+	regulator_bulk_free(sr->num_supplies, sr->supplies);
+	dev->driver_data = NULL;
+}
+
 /* Limits operation to a specific generation (1, 2, or 3) */
 static void brcm_pcie_set_gen(struct brcm_pcie *pcie, int gen)
 {
@@ -779,6 +854,8 @@ static struct pci_ops brcm_pcie_ops = {
 	.map_bus = brcm_pcie_map_conf,
 	.read = pci_generic_config_read,
 	.write = pci_generic_config_write,
+	.add_bus = pci_subdev_regulators_add_bus,
+	.remove_bus = pci_subdev_regulators_remove_bus,
 };
 
 static struct pci_ops brcm_pcie_ops32 = {
-- 
2.17.1

