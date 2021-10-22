Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA5514378B3
	for <lists+linux-pci@lfdr.de>; Fri, 22 Oct 2021 16:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbhJVOJz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Oct 2021 10:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233000AbhJVOJr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Oct 2021 10:09:47 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61403C061766;
        Fri, 22 Oct 2021 07:07:28 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id i1so2744179plr.13;
        Fri, 22 Oct 2021 07:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=duetiEhwSVYHkkfTTxUM0W/FKCKHqjSaMJJk7U7j23k=;
        b=bVC9gPQqE4Bjgv4jnXvQO7GDQK7llbwnwuwaLac4eINXKJbXUGTzdNWHoB4xt40FaF
         GdFni/gAVl9wJ0Z0wxAkIDyV1EwpQ8Bd+e/0naoOpSs4POOuCqYF9ICKaPvLLMO+RURt
         asAmcrnutEzwfxI39WZkdiIf6A/BPiXLEKZ2NtDuEa8NecV+pgNj/yBb9BGvTzSDAdio
         iUCIdZYI2nLA6GgwKraQHmWRKRHY3UsTOGiT7g0DiKlAdX+dWpDnVBMgrbgijp2jdmsr
         oEawzOaDpWTNWvtrCQZNIxGyRWaLQxuGgeXApa8ppgjy52YHlZ4YkZDX8MB9Zar0Ix0Y
         Z8Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=duetiEhwSVYHkkfTTxUM0W/FKCKHqjSaMJJk7U7j23k=;
        b=3tnLkm9/kmx0gZN27C2DIbWoFcckQ+FNWF7XDOwUbnWImPwNzU5WerorFY0e5/+bMR
         2NOhxi1q8Mz6NgSzvbfbCVgQW3h98RZuao4yjvcJOlZrm8SDrS3sfmeCRZphf0IrPvfi
         TCSLo4m0Qi5axMlxt4UhvnvFa5u2tOn194S8ECjD9m8jYDeGCP9L8d3RxOKDg9WDN4IL
         2tXD69hn6iLx80RNbswu6sJuH0x1gfKRTYsYBjOMAMxf3QyaNZywilXjI++RSIKSEiFR
         TMNk0UIkoq0ZOlTZhJi+8wGieJ3aWmCk1AaLVS1GOgHCYVkpoBlZ9G6/9FmsbBzjiFp+
         KKLg==
X-Gm-Message-State: AOAM530ep8m7kMfafd23WQvEZ+6khrlrCF+DhzVpILbJqTK+jfutW+q8
        HomRp3Vnp+1ESn4DQywVEdAjpQXId/cw8Q==
X-Google-Smtp-Source: ABdhPJyBFb8lfUSQnw4cFxMhJ77DSP5jR2lhKCfHtI2jejGGPqWEcEKODrJqbrYlNex2ihHM7OcUwg==
X-Received: by 2002:a17:90a:6b0a:: with SMTP id v10mr14910616pjj.130.1634911647521;
        Fri, 22 Oct 2021 07:07:27 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id e12sm9482990pfl.67.2021.10.22.07.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 07:07:26 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Rajat Jain <rajatja@google.com>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Claire Chang <tientzu@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 2/6] PCI: allow for callback to prepare nascent subdev
Date:   Fri, 22 Oct 2021 10:06:55 -0400
Message-Id: <20211022140714.28767-3-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211022140714.28767-1-jim2101024@gmail.com>
References: <20211022140714.28767-1-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We would like the Broadcom STB PCIe root complex driver to be able to turn
off/on regulators[1] that provide power to endpoint[2] devices.  Typically,
the drivers of these endpoint devices are stock Linux drivers that are not
aware that these regulator(s) exist and must be turned on for the driver to
be probed.  The simple solution of course is to turn these regulators on at
boot and keep them on.  However, this solution does not satisfy at least
three of our usage modes:

1. For example, one customer uses multiple PCIe controllers, but wants the
ability to, by script, turn any or all of them by and their subdevices off
to save power, e.g. when in battery mode.

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

This commit solves the "chicken-and-egg" problem by providing a callback to
the RC driver when a downstream device is "discovered" by inspecting its
DT, and allowing said driver to allocate the device object prematurely in
order to get the regulator(s) and turn them on before the device's ID is
read.

[1] These regulators typically govern the actual power supply to the
    endpoint chip.  Sometimes they may be a the official PCIe socket
    power -- such as 3.3v or aux-3.3v.  Sometimes they are truly
    the regulator(s) that supply power to the EP chip.

[2] The 99% configuration of our boards is a single endpoint device
    attached to the PCIe controller.  I use the term endpoint but it could
    possible mean a switch as well.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 drivers/base/core.c    |  5 +++++
 drivers/pci/probe.c    | 47 ++++++++++++++++++++++++++++++++----------
 include/linux/device.h |  3 +++
 include/linux/pci.h    |  3 +++
 4 files changed, 47 insertions(+), 11 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 249da496581a..62d9ac123ae5 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2864,6 +2864,10 @@ static void klist_children_put(struct klist_node *n)
  */
 void device_initialize(struct device *dev)
 {
+	/* Return if this has been called already. */
+	if (dev->device_initialized)
+		return;
+
 	dev->kobj.kset = devices_kset;
 	kobject_init(&dev->kobj, &device_ktype);
 	INIT_LIST_HEAD(&dev->dma_pools);
@@ -2892,6 +2896,7 @@ void device_initialize(struct device *dev)
 #ifdef CONFIG_SWIOTLB
 	dev->dma_io_tlb_mem = &io_tlb_default_mem;
 #endif
+	dev->device_initialized = true;
 }
 EXPORT_SYMBOL_GPL(device_initialize);
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index d9fc02a71baa..12947e972b7b 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2372,27 +2372,52 @@ EXPORT_SYMBOL(pci_bus_read_dev_vendor_id);
  */
 static struct pci_dev *pci_scan_device(struct pci_bus *bus, int devfn)
 {
-	struct pci_dev *dev;
+	struct pci_host_bridge *hb = pci_find_host_bridge(bus);
+	struct pci_dev *dev = NULL;
 	u32 l;
 
-	if (!pci_bus_read_dev_vendor_id(bus, devfn, &l, 60*1000))
-		return NULL;
+	/*
+	 * If the host bridge has a pci_subdev_prepare() function, first
+	 * call it with true as the first argument to see if it "cares"
+	 * about this device.  A non-zero return value indicates it cares,
+	 * so in that case partially allocate some of the device and call
+	 * pci_subdev_prepare() again, with false as the first argument.
+	 * This tells it to allow the host bridge driver to pre-allocate
+	 * some resources such as voltage regulators.
+	 */
+	if (hb->pci_subdev_prepare
+	    && hb->pci_subdev_prepare(true, bus, devfn, NULL, NULL)) {
+		dev = pci_alloc_dev(bus);
+		if (!dev)
+			return NULL;
 
-	dev = pci_alloc_dev(bus);
-	if (!dev)
-		return NULL;
+		dev->devfn = devfn;
+		device_initialize(&dev->dev);
 
+		/* Call again, this time for actual prep work */
+		if (hb->pci_subdev_prepare(false, bus, devfn, hb, dev)
+		    || !pci_bus_read_dev_vendor_id(bus, devfn, &l, 60*1000))
+			goto err_out;
+	} else {
+		if (!pci_bus_read_dev_vendor_id(bus, devfn, &l, 60*1000))
+			return NULL;
+		dev = pci_alloc_dev(bus);
+		if (!dev)
+			return NULL;
+	}
 	dev->devfn = devfn;
 	dev->vendor = l & 0xffff;
 	dev->device = (l >> 16) & 0xffff;
 
-	if (pci_setup_device(dev)) {
-		pci_bus_put(dev->bus);
-		kfree(dev);
-		return NULL;
-	}
+	if (pci_setup_device(dev))
+		goto err_out;
 
 	return dev;
+
+err_out:
+	pci_bus_put(dev->bus);
+	kfree(dev);
+	return NULL;
 }
 
 void pcie_report_downtraining(struct pci_dev *dev)
diff --git a/include/linux/device.h b/include/linux/device.h
index e270cb740b9e..cf175684a270 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -461,6 +461,8 @@ struct dev_links_info {
  *		and optionall (if the coherent mask is large enough) also
  *		for dma allocations.  This flag is managed by the dma ops
  *		instance from ->dma_supported.
+ * @device_initialized: true if device_initialize(dev) has already been
+ *		invoked, false otherwise.
  *
  * At the lowest level, every device in a Linux system is represented by an
  * instance of struct device. The device structure contains the information
@@ -575,6 +577,7 @@ struct device {
 #ifdef CONFIG_DMA_OPS_BYPASS
 	bool			dma_ops_bypass : 1;
 #endif
+	bool			device_initialized : 1;
 };
 
 /**
diff --git a/include/linux/pci.h b/include/linux/pci.h
index cd8aa6fce204..7a72b3af1e33 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -552,6 +552,9 @@ struct pci_host_bridge {
 	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* Platform IRQ swizzler */
 	int (*map_irq)(const struct pci_dev *, u8, u8);
 	void (*release_fn)(struct pci_host_bridge *);
+	int (*pci_subdev_prepare)(bool query, struct pci_bus *bus, int devfn,
+				  struct pci_host_bridge *hb,
+				  struct pci_dev *pdev);
 	void		*release_data;
 	unsigned int	ignore_reset_delay:1;	/* For entire hierarchy */
 	unsigned int	no_ext_tags:1;		/* No Extended Tags */
-- 
2.17.1

