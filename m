Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 442D84403BA
	for <lists+linux-pci@lfdr.de>; Fri, 29 Oct 2021 22:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbhJ2UGH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Oct 2021 16:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbhJ2UGE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Oct 2021 16:06:04 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DB0C061714;
        Fri, 29 Oct 2021 13:03:35 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id v193so10186395pfc.4;
        Fri, 29 Oct 2021 13:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/xsefYqdfGM3gwTzp77+CzGEQFr/OK+AwnRYV+MylP4=;
        b=i0hWrQt4+laf0kcnMMYOv5YQ8hXTLb7pCnihggTiTil+fi/zsZ8JgL/rhL/w5ysYhb
         JceYMx8kbnySVv7amLjMbHI5byLOSptkC0zxDeFSGBiXYsW1nECeaTXY80ugXvyHIuZk
         Uq7Dr6NH9fgsZW589AThogunzmrsJMx9PCEnjYHgHRqZkqi6Y/Du+w1lmOKSzmEGE/tq
         QC8Cu6iEnxj71MAIZopzo/6zUIdlr8P5wgZItfZ6OJ4LaAxdhZZd+MyN3W7BrTHnj80d
         UjxIc/BoIln8U78CNGJnUstDVzzxzRGQNrL0jxJlSsja22aZPBAW9JrInCAltB5B+Wvk
         D6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/xsefYqdfGM3gwTzp77+CzGEQFr/OK+AwnRYV+MylP4=;
        b=S1gK77T3cL9/TgPvYEYeVko/xwqlgag+JyEXmDBo1Ix9usZZTyIEaeGEdrGsaBWEK+
         5jlf4lp1zZVnUXtKqR86V66JmmfOePoMCSaRMSg0iY2y2/stzTQx9Mm3oY35XnK/Jfq4
         de/v/mUAjQhVrdJQgFWO1g46VCBQitl0w4nH8jV7vgpBlqWz2lvOomxusPyud7fleLVC
         ep3SeLGCqIU8xJkclAft4WmKDl2y+iisP83Wyht++0erpHFAf15TtD4J4BGvaYKVtYAY
         FZpl2UIf5QoX0IZxPFBH6KLff1KsenAPBDTYfzLsHQJ/Sp9kmHCG5Jx+cD9g/md2mS4a
         1PEw==
X-Gm-Message-State: AOAM530lgUgAYaH/xXgHACwR9TPkZKtGwURf76HsRvY/oxGtb6ICsMpS
        WwI9RXFO3ogRdNEi4M2sXSl+efoZv0wtHw==
X-Google-Smtp-Source: ABdhPJxrDHmn9JZ3WxPtmokBaTHvh3WyD7lqBFP1ofhcVzk1p2e94AiCbFGCt2CUPnHz2RyaZ8ImTQ==
X-Received: by 2002:a63:9348:: with SMTP id w8mr9876745pgm.325.1635537814688;
        Fri, 29 Oct 2021 13:03:34 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id j16sm8775041pfj.16.2021.10.29.13.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 13:03:34 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 5/9] PCI: allow for callback to prepare nascent subdev
Date:   Fri, 29 Oct 2021 16:03:13 -0400
Message-Id: <20211029200319.23475-6-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211029200319.23475-1-jim2101024@gmail.com>
References: <20211029200319.23475-1-jim2101024@gmail.com>
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
 drivers/pci/probe.c | 52 ++++++++++++++++++++++++++++++++++-----------
 include/linux/pci.h |  4 ++++
 2 files changed, 44 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 0f092882b33f..8a58a9975ff6 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2372,29 +2372,57 @@ EXPORT_SYMBOL(pci_bus_read_dev_vendor_id);
  */
 static struct pci_dev *pci_scan_device(struct pci_bus *bus, int devfn)
 {
-	struct pci_dev *dev;
+	struct pci_host_bridge *hb = pci_find_host_bridge(bus);
+	struct pci_dev *dev = NULL;
+	bool device_initialize_called = false;
 	u32 l;
 
-	if (!pci_bus_read_dev_vendor_id(bus, devfn, &l, 60*1000))
-		return NULL;
+	/*
+	 * If the host bridge has a pci_subdev_can_prepare() function, call
+	 * it to see if it "cares" about this device.  If it does,
+	 * partially allocate some of the device and call
+	 * pci_subdev_prepare().  This tells it to allow the host bridge
+	 * driver to pre-allocate some resources such as voltage
+	 * regulators so that the pcie linkup can be established.
+	 */
+	if (hb->pci_subdev_can_prepare
+	    && hb->pci_subdev_can_prepare(bus, devfn)) {
+		dev = pci_alloc_dev(bus);
+		if (!dev)
+			return NULL;
 
-	dev = pci_alloc_dev(bus);
-	if (!dev)
-		return NULL;
+		dev->devfn = devfn;
+		device_initialize(&dev->dev);
+		device_initialize_called = true;
 
+		if (hb->pci_subdev_prepare(bus, devfn, hb, dev)
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
-	device_initialize(&dev->dev);
+	if (pci_setup_device(dev))
+		goto err_out;
+
+	if (!device_initialize_called)
+		device_initialize(&dev->dev);
+
 	pci_device_add(dev, bus);
 
 	return dev;
+
+err_out:
+	pci_bus_put(dev->bus);
+	kfree(dev);
+	return NULL;
 }
 
 void pcie_report_downtraining(struct pci_dev *dev)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index cd8aa6fce204..45ba24537ef2 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -552,6 +552,10 @@ struct pci_host_bridge {
 	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* Platform IRQ swizzler */
 	int (*map_irq)(const struct pci_dev *, u8, u8);
 	void (*release_fn)(struct pci_host_bridge *);
+	bool (*pci_subdev_can_prepare)(struct pci_bus *bus, int devfn);
+	int (*pci_subdev_prepare)(struct pci_bus *bus, int devfn,
+				  struct pci_host_bridge *hb,
+				  struct pci_dev *pdev);
 	void		*release_data;
 	unsigned int	ignore_reset_delay:1;	/* For entire hierarchy */
 	unsigned int	no_ext_tags:1;		/* No Extended Tags */
-- 
2.17.1

