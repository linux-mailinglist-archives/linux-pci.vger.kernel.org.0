Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C171A4C6A4
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2019 07:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731488AbfFTFNz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jun 2019 01:13:55 -0400
Received: from mail-pg1-f175.google.com ([209.85.215.175]:43545 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbfFTFNu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jun 2019 01:13:50 -0400
Received: by mail-pg1-f175.google.com with SMTP id f25so910263pgv.10
        for <linux-pci@vger.kernel.org>; Wed, 19 Jun 2019 22:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DwjIUbZI6XrLVZXngoHyb1nJEnqXQ8wZy4HOV6PoeSc=;
        b=XUzH400ExQFQZYmBWBWyM/kEDYRVphyEk8d7EB0zffgil9iJrCwEKd6J+6bztX8cQM
         Awarii9N0Ld740/V8/V3y6fByH7H+MzGKLn2ee33f+ofAX1xG7aHGlG+gmE2dKbQ9Kue
         7q6VqHidGtooa1QPHIWWhra8Q2UlsTpXIGzU9JvroWjX+NOmVjfrSwa1s0vZXuNa7hUi
         mkDSWGMj80c5YkqEhErdonsiImJY4D6aXz4L42Kdm28YN61CQY8vpyMDHksgOiCzlfOp
         /6CDuMA8bJyeDNILxgMyAix1MHUlR1WZFbJGwwE4a8YZVQq8ssY56zTBDtcbwhcBlhj3
         j7Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DwjIUbZI6XrLVZXngoHyb1nJEnqXQ8wZy4HOV6PoeSc=;
        b=OKj5BKAPVq4dIBg3inwuTf1T425yqPJNYxSvXvLK3asBXj/U2e8eC2t+cT7vgAuC0b
         dSsaCOeR9qNrlPclwdPd/vRMiN/ykbfO/BFVA1eDyKkdlRKtrYGDBLjkyNQlthyN+kXV
         BBOMt85at14hLgjD/6bSP/VVc7kPDp0fKjBXX00gu9hmtO9mQhr7HrozZUNVae+K2rRg
         y4w80ySimQZDPw+EKQPIE9t2lO48WxE3mRUAboxtGiR0HdxWnxb+sXN+zNejOPIUKyEt
         ko15ZpJFlbBafsgI+ZmIW3sav3iEnRMtpMuFi0z2A1TLy5Z8KZS1wc9LZXbw2twCWLwF
         bFcQ==
X-Gm-Message-State: APjAAAWrLn4h0Qa/Oyd/W3K0wnRqlPYPqms2KIVU6S9WW8W4ltb9l+fC
        rW8pmPYW/eIYvlIhUE/hbie7Nw==
X-Google-Smtp-Source: APXvYqyxsrsNm/odNEYXRnh4T67omunw7EsliVUtLx1ch/qBhDSop/BAcBt1J7Dcx1n8gB8tsV22hQ==
X-Received: by 2002:a63:8d4a:: with SMTP id z71mr673352pgd.346.1561007629321;
        Wed, 19 Jun 2019 22:13:49 -0700 (PDT)
Received: from limbo.local (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.gmail.com with ESMTPSA id j2sm26383423pfn.135.2019.06.19.22.13.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 22:13:48 -0700 (PDT)
From:   Daniel Drake <drake@endlessm.com>
To:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
Cc:     linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com, linux-ide@vger.kernel.org, linux@endlessm.com,
        linux-kernel@vger.kernel.org, hare@suse.de,
        alex.williamson@redhat.com, dan.j.williams@intel.com
Subject: [PATCH v2 1/5] ahci: Discover Intel remapped NVMe devices
Date:   Thu, 20 Jun 2019 13:13:29 +0800
Message-Id: <20190620051333.2235-2-drake@endlessm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190620051333.2235-1-drake@endlessm.com>
References: <20190620051333.2235-1-drake@endlessm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Intel SATA AHCI controllers support a strange mode where NVMe devices
disappear from the PCI bus, and instead are remapped into AHCI PCI memory
space.

Many current and upcoming consumer products ship with the AHCI controller
in this "RAID" or "Intel RST Premium with Intel Optane System Acceleration"
mode by default. Without Linux support for this remapped mode,
the default out-of-the-box experience is that the NVMe storage device
is inaccessible (which in many cases is the only internal storage device).

Using partial information provided by Intel in datasheets, emails,
and previous patches, extend the AHCI driver to detect the remapped NVMe
devices and create corresponding platform devices, to be picked up
by the nvme driver.

Our knowledge of the design and workings of this remapping scheme
has been collected in ahci-remap.h, which can be considered the best
spec we have at the moment.

Based on earlier work by Dan Williams.

Signed-off-by: Daniel Drake <drake@endlessm.com>
---
 drivers/ata/Kconfig        |  32 +++++++
 drivers/ata/ahci.c         | 173 ++++++++++++++++++++++++++++++++-----
 drivers/ata/ahci.h         |  14 +++
 include/linux/ahci-remap.h | 140 +++++++++++++++++++++++++++---
 4 files changed, 329 insertions(+), 30 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index a6beb2c5a692..6e82d66d7516 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -109,6 +109,38 @@ config SATA_MOBILE_LPM_POLICY
 	  Note "Minimum power" is known to cause issues, including disk
 	  corruption, with some disks and should not be used.
 
+config SATA_AHCI_INTEL_NVME_REMAP
+	bool "AHCI: Intel Remapped NVMe device support"
+	depends on SATA_AHCI
+	depends on BLK_DEV_NVME
+	help
+	  Support access to remapped NVMe devices that appear in AHCI PCI
+	  memory space.
+
+	  You'll need this in order to access your NVMe storage if you are
+	  running an Intel AHCI controller in "RAID" or "Intel RST Premium
+	  with Intel Optane System Acceleration" mode. This is the default
+	  configuration of many consumer products. If you have storage devices
+	  being affected by this, you'll have noticed that such devices are
+	  absent, and you'll see a warning in your kernel logs about remapped
+	  NVMe devices.
+
+	  Instead of enabling this option, it is recommended to go into the
+	  BIOS menu and change the SATA device into "AHCI" mode in order to
+	  gain access to the affected devices, while also enjoying all
+	  available NVMe features and performance.
+
+	  However, if you do want to access the NVMe devices in remapped
+	  mode, say Y. Negative consequences of remapped device access
+	  include:
+	  - No NVMe device power management
+	  - No NVMe reset support
+	  - No NVMe quirks based on PCI ID
+	  - No SR-IOV VFs
+	  - Reduced performance through a shared, legacy interrupt
+
+	  If unsure, say N.
+
 config SATA_AHCI_PLATFORM
 	tristate "Platform AHCI SATA support"
 	help
diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index f7652baa6337..b58316347539 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -23,6 +23,7 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/dma-mapping.h>
+#include <linux/platform_device.h>
 #include <linux/device.h>
 #include <linux/dmi.h>
 #include <linux/gfp.h>
@@ -1499,11 +1500,11 @@ static irqreturn_t ahci_thunderx_irq_handler(int irq, void *dev_instance)
 }
 #endif
 
-static void ahci_remap_check(struct pci_dev *pdev, int bar,
+static int ahci_remap_init(struct pci_dev *pdev, int bar,
 		struct ahci_host_priv *hpriv)
 {
 	int i, count = 0;
-	u32 cap;
+	u32 supported_devs;
 
 	/*
 	 * Check if this device might have remapped nvme devices.
@@ -1511,33 +1512,68 @@ static void ahci_remap_check(struct pci_dev *pdev, int bar,
 	if (pdev->vendor != PCI_VENDOR_ID_INTEL ||
 	    pci_resource_len(pdev, bar) < SZ_512K ||
 	    bar != AHCI_PCI_BAR_STANDARD ||
-	    !(readl(hpriv->mmio + AHCI_VSCAP) & 1))
-		return;
+	    !(readl(hpriv->mmio + AHCI_VS_CAP) & AHCI_VS_CAP_NRMBE))
+		return -ENODEV;
 
-	cap = readq(hpriv->mmio + AHCI_REMAP_CAP);
-	for (i = 0; i < AHCI_MAX_REMAP; i++) {
-		if ((cap & (1 << i)) == 0)
+	supported_devs = readl(hpriv->mmio + AHCI_REMAP_RCR_L)
+			 & AHCI_REMAP_RCR_L_NRS_MASK;
+	for_each_set_bit(i, (unsigned long *)&supported_devs, AHCI_MAX_REMAP) {
+		struct ahci_remap *rdev;
+		u32 dcc;
+
+		/* Check that the remapped device is NVMe */
+		dcc = readl(hpriv->mmio + ahci_remap_dcc(i));
+		if ((dcc & AHCI_REMAP_DCC_DT) != AHCI_REMAP_DCC_DT_NVME)
 			continue;
-		if (readl(hpriv->mmio + ahci_remap_dcc(i))
-				!= PCI_CLASS_STORAGE_EXPRESS)
+
+		dcc &= AHCI_REMAP_DCC_CC_MASK;
+		if (dcc != PCI_CLASS_STORAGE_EXPRESS)
 			continue;
 
-		/* We've found a remapped device */
 		count++;
+		if (!IS_ENABLED(CONFIG_SATA_AHCI_INTEL_NVME_REMAP))
+			continue;
+
+		/*
+		 * Note the memory area that corresponds to the remapped
+		 * device.
+		 */
+		rdev = devm_kzalloc(&pdev->dev, sizeof(*rdev), GFP_KERNEL);
+		if (!rdev)
+			return -ENOMEM;
+
+		rdev->id = i;
+		rdev->mem.start = pci_resource_start(pdev, bar)
+			+ ahci_remap_base(i);
+		rdev->mem.end = rdev->mem.start + AHCI_REMAP_MMIO_SIZE - 1;
+		rdev->mem.flags = IORESOURCE_MEM;
+
+		/*
+		 * This will be translated to kernel irq vector after
+		 * ahci irq initialization.
+		 */
+		rdev->irq.start = 0;
+		rdev->irq.end = 0;
+		rdev->irq.flags = IORESOURCE_IRQ;
+
+		hpriv->remap[i] = rdev;
 	}
 
-	if (!count)
-		return;
+	if (count == 0)
+		return -ENODEV;
 
 	dev_warn(&pdev->dev, "Found %d remapped NVMe devices.\n", count);
+
+	if (!IS_ENABLED(CONFIG_SATA_AHCI_INTEL_NVME_REMAP)) {
+		dev_warn(&pdev->dev,
+			 "To use these, switch your BIOS from RAID to AHCI mode for fully featured NVMe access, or alternatively enable AHCI Remapped NVMe support in your kernel for access in reduced features mode.\n");
+		return -ENODEV;
+	}
+
 	dev_warn(&pdev->dev,
-		 "Switch your BIOS from RAID to AHCI mode to use them.\n");
+		 "These devices will be made available, but with reduced features and lower performance. Enable full NVMe functionality by switching your BIOS from RAID to AHCI mode.\n");
 
-	/*
-	 * Don't rely on the msi-x capability in the remap case,
-	 * share the legacy interrupt across ahci and remapped devices.
-	 */
-	hpriv->flags |= AHCI_HFLAG_NO_MSI;
+	return 0;
 }
 
 static int ahci_get_irq_vector(struct ata_host *host, int port)
@@ -1550,7 +1586,7 @@ static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
 {
 	int nvec;
 
-	if (hpriv->flags & AHCI_HFLAG_NO_MSI)
+	if (hpriv->flags & (AHCI_HFLAG_NO_MSI | AHCI_HFLAG_REMAP))
 		return -ENODEV;
 
 	/*
@@ -1619,6 +1655,65 @@ static void ahci_update_initial_lpm_policy(struct ata_port *ap,
 		ap->target_lpm_policy = policy;
 }
 
+static void ahci_remap_restore(void *data)
+{
+	struct pci_dev *pdev = data;
+	int bar = AHCI_PCI_BAR_STANDARD;
+
+	/* Restore the full AHCI BAR */
+	pci_resource_end(pdev, bar) = pci_resource_start(pdev, bar)
+				      + SZ_512K - 1;
+}
+
+static void ahci_remap_unregister(void *data)
+{
+	struct platform_device *pdev = data;
+
+	platform_device_del(pdev);
+	put_device(&pdev->dev);
+}
+
+/* Register platform devices for remapped NVMe storage */
+static void ahci_remap_register_devices(struct device *dev,
+		struct ahci_host_priv *hpriv)
+{
+	struct platform_device *pdev;
+	int i;
+
+	if ((hpriv->flags & AHCI_HFLAG_REMAP) == 0)
+		return;
+
+	for (i = 0; i < AHCI_MAX_REMAP; i++) {
+		struct ahci_remap *rdev = hpriv->remap[i];
+
+		if (!rdev)
+			continue;
+
+		pdev = platform_device_alloc("intel_ahci_nvme",
+					     rdev->id);
+		if (!pdev)
+			continue;
+
+		if (platform_device_add_resources(pdev, &rdev->mem, 2) != 0) {
+			platform_device_put(pdev);
+			continue;
+		}
+
+		pdev->dev.parent = dev;
+		if (platform_device_add(pdev) != 0) {
+			platform_device_put(pdev);
+			continue;
+		}
+
+		if (devm_add_action_or_reset(dev, ahci_remap_unregister,
+					pdev) != 0)
+			continue;
+
+		dev_info(dev, "remap: %s %pR %pR\n", dev_name(&pdev->dev),
+				&rdev->mem, &rdev->irq);
+	}
+}
+
 static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	unsigned int board_id = ent->driver_data;
@@ -1717,7 +1812,28 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	hpriv->mmio = pcim_iomap_table(pdev)[ahci_pci_bar];
 
 	/* detect remapped nvme devices */
-	ahci_remap_check(pdev, ahci_pci_bar, hpriv);
+	if (ahci_remap_init(pdev, ahci_pci_bar, hpriv) == 0) {
+		/*
+		 * Modify the AHCI BAR to exclude the memory regions that
+		 * correspond to remapped NVMe devices.
+		 */
+		pcim_iounmap_regions(pdev, 1 << ahci_pci_bar);
+		pci_resource_end(pdev, ahci_pci_bar)
+			= pci_resource_start(pdev, ahci_pci_bar) + SZ_16K - 1;
+
+		rc = devm_add_action_or_reset(dev, ahci_remap_restore, pdev);
+		if (rc)
+			return rc;
+
+		rc = pcim_iomap_regions(pdev, 1 << ahci_pci_bar, DRV_NAME);
+		if (rc == -EBUSY)
+			pcim_pin_device(pdev);
+		if (rc)
+			return rc;
+
+		hpriv->mmio = pcim_iomap_table(pdev)[ahci_pci_bar];
+		hpriv->flags |= AHCI_HFLAG_REMAP;
+	}
 
 	/* must set flag prior to save config in order to take effect */
 	if (ahci_broken_devslp(pdev))
@@ -1800,6 +1916,21 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (ahci_init_msi(pdev, n_ports, hpriv) < 0) {
 		/* legacy intx interrupts */
 		pci_intx(pdev, 1);
+
+		/*
+		 * MSI-X support for the remap case is not yet supported,
+		 * so share the legacy interrupt across ahci and remapped
+		 * devices.
+		 */
+		if (hpriv->flags & AHCI_HFLAG_REMAP)
+			for (i = 0; i < AHCI_MAX_REMAP; i++) {
+				struct ahci_remap *rdev = hpriv->remap[i];
+
+				if (!rdev || resource_size(&rdev->irq) < 1)
+					continue;
+				rdev->irq.start = pdev->irq;
+				rdev->irq.end = rdev->irq.start;
+			}
 	}
 	hpriv->irq = pci_irq_vector(pdev, 0);
 
@@ -1853,6 +1984,8 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (rc)
 		return rc;
 
+	ahci_remap_register_devices(&pdev->dev, hpriv);
+
 	pm_runtime_put_noidle(&pdev->dev);
 	return 0;
 }
diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 0570629d719d..6947c76a78d1 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -22,6 +22,7 @@
 #include <linux/pci.h>
 #include <linux/clk.h>
 #include <linux/libata.h>
+#include <linux/ahci-remap.h>
 #include <linux/phy/phy.h>
 #include <linux/regulator/consumer.h>
 
@@ -240,6 +241,7 @@ enum {
 							as default lpm_policy */
 	AHCI_HFLAG_SUSPEND_PHYS		= (1 << 26), /* handle PHYs during
 							suspend/resume */
+	AHCI_HFLAG_REMAP		= (1 << 27),
 
 	/* ap->flags bits */
 
@@ -317,6 +319,17 @@ struct ahci_port_priv {
 	char			*irq_desc;	/* desc in /proc/interrupts */
 };
 
+struct ahci_remap {
+	int id;
+	/*
+	 * @mem and @irq must be consecutive for
+	 * platform_device_add_resources() in
+	 * ahci_remap_register_devices()
+	 */
+	struct resource mem;
+	struct resource irq;
+};
+
 struct ahci_host_priv {
 	/* Input fields */
 	unsigned int		flags;		/* AHCI_HFLAG_* */
@@ -348,6 +361,7 @@ struct ahci_host_priv {
 	unsigned		nports;		/* Number of ports */
 	void			*plat_data;	/* Other platform data */
 	unsigned int		irq;		/* interrupt line */
+	struct ahci_remap	*remap[AHCI_MAX_REMAP]; /* remapped devices */
 	/*
 	 * Optional ahci_start_engine override, if not set this gets set to the
 	 * default ahci_start_engine during ahci_save_initial_config, this can
diff --git a/include/linux/ahci-remap.h b/include/linux/ahci-remap.h
index 230c871ba084..aa3387936b01 100644
--- a/include/linux/ahci-remap.h
+++ b/include/linux/ahci-remap.h
@@ -1,29 +1,149 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Intel AHCI remapped NVMe device support.
+ *
+ * Intel SATA AHCI controllers support a strange mode where NVMe devices
+ * disappear from the PCI bus, and instead are remapped into AHCI PCI memory
+ * space.
+ *
+ * The reason for the existence of such functionality is unknown, but it
+ * is suspected to be a scheme employed by Intel in order to avoid usage
+ * of the standard Windows device drivers, and instead promote usage
+ * of Intel's own Windows drivers, which are assumed to be more power
+ * efficient[1].
+ *
+ * Many consumer products ship with the AHCI controller in this mode by
+ * default, but this can usually be controlled by the user in the BIOS
+ * setup menu: the SATA controller can be configured to "AHCI" mode
+ * (where AHCI and NVMe devices appear as separate PCI devices, i.e. the
+ * usual case) or the remapped mode which is labelled as "RAID" or
+ * "Intel RST Premium with Intel Optane System Acceleration".
+ *
+ * Linux's support for remapped NVMe devices is based on limited
+ * information shared by Intel. Until something more substantial is
+ * provided, this file can be considered as the spec.
+ *
+ * The Vendor-Specific Capabilities Register (VS_CAP) can be used to
+ * determine if NVMe devices have been remapped (section 16.2.10 of [3]).
+ *
+ * A maximum of 3 devices can be remapped (section 3.2.1 of [2]).
+ *
+ * The configuration space of the remapped devices is not available[5].
+ *
+ * Interrupts are shared between AHCI & remapped NVMe devices[4]. Sharing
+ * the single legacy interrupt appears to work fine. There are some registers
+ * related to MSI-X (see section 15.2 of [3]) but the details are not
+ * completely clear.
+ *
+ * Simultaneous access to AHCI and NVMe devices is allowed and expected[4].
+ *
+ * Changing between AHCI remapped mode does change the PCI ID of the AHCI
+ * controller. However, the PCI ID of the AHCI device is not uniquely
+ * identifiable when in this  mode[4]. The same PCI IDs are shared with other
+ * Intel devices that do not remap NVMe devices.
+ *
+ * The firmware enables the remapped NVMe mode in early boot, via
+ * configuration registers of the the virtual "Intel(R) RST for PCIe Storage
+ * (Remapping)" PCI device (section 15 of [2]), and then uses a write-once
+ * register (once per reset) in order to lock down against further
+ * configuration changes. This virtual PCI device then appears to be
+ * completely inaccessible from Linux. There is no way that Linux could
+ * escape out of this mode[6].
+ *
+ * References:
+ * 1. Microsoft aren't forcing Lenovo to block free operating systems
+ *    https://mjg59.dreamwidth.org/44694.html
+ *
+ * 2. Intel(R) 300 Series and Intel(R) C240 Series Chipset Family Platform
+ *    Controller Hub (PCH). Datasheet - Volume 1 of 2. March 2019.
+ *    https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/300-series-chipset-pch-datasheet-vol-1.pdf
+ *
+ * 3. Intel(R) 300 Series and Intel(R) C240 Series Chipset Family Platform
+ *    Controller Hub (PCH). Datasheet - Volume 2 of 2. June 2018.
+ *    https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/300-series-chipset-pch-datasheet-vol-2.pdf
+ *
+ * 4. Dan Williams (Intel) via linux-ide mailing list
+ *    https://marc.info/?l=linux-ide&m=147733119300691
+ *    Message-Id: <CAPcyv4jSx5c3DzEsbfUph5Akk-XyxQ2sXAgmLZfhvGEOUtBqdQ@mail.gmail.com>
+ *
+ * 5. Dan Williams (Intel) via linux-ide mailing list
+ *    https://marc.info/?l=linux-ide&m=147734288604783&w=2
+ *    Message-Id: <CAPcyv4hHqkFirpaGTjs+iNKB9sr_thYOKN=N58vkLDYcXErOcQ@mail.gmail.com>
+ *
+ * 6. Dan Williams (Intel) via linux-ide mailing list
+ *    https://marc.info/?l=linux-ide&m=147953592417285&w=2
+ *    Message-Id: <CAPcyv4ge6OO+N619t48m_aCNSEX1aEipP18E6_fvurmu5nr40w@mail.gmail.com>
+ */
+
 #ifndef _LINUX_AHCI_REMAP_H
 #define _LINUX_AHCI_REMAP_H
 
+#include <linux/bits.h>
 #include <linux/sizes.h>
 
-#define AHCI_VSCAP		0xa4
-#define AHCI_REMAP_CAP		0x800
+/* Maximum 3 supported remappings. */
+#define AHCI_MAX_REMAP			3
+
+/* Vendor Specific Capabilities register */
+#define AHCI_VS_CAP			0xa4
+
+/*
+ * VS_CAP: NAND Memory BAR Remapped Enable
+ * This is set to 1 if one or more NVMe devices have been remapped.
+ */
+#define AHCI_VS_CAP_NRMBE		BIT(0)
+
+
+/* Remap Configuration register */
+#define AHCI_REMAP_RCR_L		0x800
+
+/*
+ * RCR_L: Number of Remapped Device Supported
+ * A bitmap indicating which of the 3 remappings are enabled.
+ */
+#define AHCI_REMAP_RCR_L_NRS_MASK	0x7
+
+
+/*
+ * Starting at 0x880, there are 3 repeating register maps, one for each
+ * remapping.
+ */
+#define AHCI_REMAP_DEV_BASE		0x880
+#define AHCI_REMAP_DEV_SIZE		0x80
+
+
+/* Device Class Code (offset within AHCI_REMAP_DEV space) */
+#define AHCI_REMAP_DCC_OFFSET		0x0
+
+/* DCC: Device Type. 0 for NVMe, 1 for AHCI */
+#define AHCI_REMAP_DCC_DT		BIT(31)
+#define AHCI_REMAP_DCC_DT_NVME		(0 << 31)
+#define AHCI_REMAP_DCC_DT_AHCI		(1 << 31)
+
+/* DCC: Base Class Code, Sub Class Code and Progamming Interface */
+#define AHCI_REMAP_DCC_CC_MASK		0xffffff
+
 
-/* device class code */
-#define AHCI_REMAP_N_DCC	0x880
+/* Remapped devices always start at this fixed offset in the AHCI BAR */
+#define AHCI_REMAP_MMIO_START		SZ_16K
 
-/* remap-device base relative to ahci-bar */
-#define AHCI_REMAP_N_OFFSET	SZ_16K
-#define AHCI_REMAP_N_SIZE	SZ_16K
+/*
+ * Each remapped device is expected to have this fixed size.
+ * The Intel docs mention a DMBL register that could perhaps be used to
+ * detect this dynamically, however the register description is unclear.
+ */
+#define AHCI_REMAP_MMIO_SIZE		SZ_16K
 
-#define AHCI_MAX_REMAP		3
 
 static inline unsigned int ahci_remap_dcc(int i)
 {
-	return AHCI_REMAP_N_DCC + i * 0x80;
+	return (AHCI_REMAP_DEV_BASE + i * AHCI_REMAP_DEV_SIZE)
+		+ AHCI_REMAP_DCC_OFFSET;
 }
 
 static inline unsigned int ahci_remap_base(int i)
 {
-	return AHCI_REMAP_N_OFFSET + i * AHCI_REMAP_N_SIZE;
+	return AHCI_REMAP_MMIO_START + i * AHCI_REMAP_MMIO_SIZE;
 }
 
 #endif /* _LINUX_AHCI_REMAP_H */
-- 
2.20.1

