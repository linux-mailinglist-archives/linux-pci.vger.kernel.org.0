Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE794328AF2
	for <lists+linux-pci@lfdr.de>; Mon,  1 Mar 2021 19:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239839AbhCASZx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Mar 2021 13:25:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:40754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238512AbhCASXh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Mar 2021 13:23:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A498C6501E;
        Mon,  1 Mar 2021 17:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614618743;
        bh=7oft8byjZEvDx0jfepFsMduaQb1utc8hp7/rStQeiso=;
        h=Date:From:To:Subject:From;
        b=tUoyFTal3LblOuFLcsEjs1D2/Ef3sgjmo17HEwqo+UsnINhYRool/V5//z5JTJ42w
         TijnP37QZoDS5C8DIUYHHNxH2WSLPr8dm0avsagjqCDm+sEznLIBMHDsi+g0VpehDX
         4wiVJriJrGSX4HEMk1vR0rGL0O/GS9UGZ9IluAywDZXus4yNaVurNQIYObm2jW34z2
         rFYYfbbgsaAwfEe6ekL94FsESr+R2LC3DuX8JvVlr1S2HcUt5/O1Fhc1NHldPOYTtM
         K22fkKDcPjo/GYGbQG4m99ZBkqrTKcSDybKBzcH1fVevhHg4NJ6YcuLzjDwVMiMEQ2
         l/eU65yypUrdA==
Received: by pali.im (Postfix)
        id 382F8A32; Mon,  1 Mar 2021 18:12:21 +0100 (CET)
Date:   Mon, 1 Mar 2021 18:12:21 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: RFC: sysfs node for Secondary PCI bus reset (PCIe Hot Reset)
Message-ID: <20210301171221.3d42a55i7h5ubqsb@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

PCIe card can be reset via in-band Hot Reset signal which can be
triggered by PCIe bridge via Secondary Bus Reset bit in PCI config
space.

Kernel already exports sysfs node "reset" for triggering Functional
Reset of particular function of PCI device. But in some cases Functional
Reset is not enough and Hot Reset is required.

Following RFC patch exports sysfs node "reset_bus" for PCI bridges which
triggers Secondary Bus Reset and therefore for PCIe bridges it resets
connected PCIe card.

What do you think about it?

Currently there is userspace script which can trigger PCIe Hot Reset by
modifying PCI config space from userspace:

https://alexforencich.com/wiki/en/pcie/hot-reset-linux

But because kernel already provides way how to trigger Functional Reset
it could provide also way how to trigger PCIe Hot Reset.


diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 50fcb62d59b5..f5e11c589498 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1321,6 +1321,30 @@ static ssize_t reset_store(struct device *dev, struct device_attribute *attr,
 
 static DEVICE_ATTR(reset, 0200, NULL, reset_store);
 
+static ssize_t reset_bus_store(struct device *dev, struct device_attribute *attr,
+			       const char *buf, size_t count)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	unsigned long val;
+	ssize_t result = kstrtoul(buf, 0, &val);
+
+	if (result < 0)
+		return result;
+
+	if (val != 1)
+		return -EINVAL;
+
+	pm_runtime_get_sync(dev);
+	result = pci_bridge_secondary_bus_reset(pdev);
+	pm_runtime_put(dev);
+	if (result < 0)
+		return result;
+
+	return count;
+}
+
+static DEVICE_ATTR(reset_bus, 0200, NULL, reset_bus_store);
+
 static int pci_create_capabilities_sysfs(struct pci_dev *dev)
 {
 	int retval;
@@ -1332,8 +1356,15 @@ static int pci_create_capabilities_sysfs(struct pci_dev *dev)
 		if (retval)
 			goto error;
 	}
+	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
+		retval = device_create_file(&dev->dev, &dev_attr_reset_bus);
+		if (retval)
+			goto error_reset_bus;
+	}
 	return 0;
 
+error_reset_bus:
+	device_remove_file(&dev->dev, &dev_attr_reset);
 error:
 	pcie_vpd_remove_sysfs_dev_files(dev);
 	return retval;
@@ -1414,6 +1445,8 @@ static void pci_remove_capabilities_sysfs(struct pci_dev *dev)
 		device_remove_file(&dev->dev, &dev_attr_reset);
 		dev->reset_fn = 0;
 	}
+	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
+		device_remove_file(&dev->dev, &dev_attr_reset_bus);
 }
 
 /**
