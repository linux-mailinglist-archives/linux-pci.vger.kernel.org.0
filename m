Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD69B268675
	for <lists+linux-pci@lfdr.de>; Mon, 14 Sep 2020 09:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbgINHtJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Sep 2020 03:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbgINHtI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Sep 2020 03:49:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0429C06174A;
        Mon, 14 Sep 2020 00:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=m6WNbtJ9v3WJZOtkVTr3be/c+Gvo4fwL7VBMeBG1LwQ=; b=rQMAcYil2Bw2XCeN2chTy7jNBg
        C7jI+VswLGhQhCSyzVJYCo93b8DeQnxWfW0npHt/hpg83Cm1UzxFQeHLVyjnqqBhnF23mQL/54Jkl
        YksogLl8x24IzdwtcCAfcahcCWcn5wYSdIIdJtco62OADFzCEQUME/ZNulaqFPQxlXHNZQ0AodmCr
        l78VWPJWTePkRvc2SnrmmOCHL6lwmTi34Up0fuuJFxZ3QSDKCO6mo9FSCmr3u/vinX6EDbsdUTWsb
        f5WkKMalvdu/CEDnAuURCQ/OLpcgilivtle2xeforMMz7kx4walPUxyp8FBkcfniGm7ZvDidFTMkC
        +nT3zM3Q==;
Received: from 089144214092.atnat0023.highway.a1.net ([89.144.214.92] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kHjES-0000ho-KA; Mon, 14 Sep 2020 07:49:00 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org,
        Russell King <linux@armlinux.org.uk>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jim Quinlan <james.quinlan@broadcom.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 6/6] dma-mapping: introduce DMA range map, supplanting dma_pfn_offset
Date:   Mon, 14 Sep 2020 09:33:43 +0200
Message-Id: <20200914073343.1579578-7-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200914073343.1579578-1-hch@lst.de>
References: <20200914073343.1579578-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Jim Quinlan <james.quinlan@broadcom.com>

The new field 'dma_range_map' in struct device is used to facilitate the
use of single or multiple offsets between mapping regions of cpu addrs and
dma addrs.  It subsumes the role of "dev->dma_pfn_offset" which was only
capable of holding a single uniform offset and had no region bounds
checking.

The function of_dma_get_range() has been modified so that it takes a single
argument -- the device node -- and returns a map, NULL, or an error code.
The map is an array that holds the information regarding the DMA regions.
Each range entry contains the address offset, the cpu_start address, the
dma_start address, and the size of the region.

of_dma_configure() is the typical manner to set range offsets but there are
a number of ad hoc assignments to "dev->dma_pfn_offset" in the kernel
driver code.  These cases now invoke the function
dma_direct_set_offset(dev, cpu_addr, dma_addr, size).

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
[hch: various interface cleanups]
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>
---
 arch/arm/include/asm/dma-direct.h             |  9 +--
 arch/arm/mach-keystone/keystone.c             | 17 ++---
 arch/arm/mach-omap1/include/mach/memory.h     |  4 +
 arch/sh/drivers/pci/pcie-sh7786.c             |  9 ++-
 arch/x86/pci/sta2x11-fixup.c                  |  6 +-
 drivers/acpi/arm64/iort.c                     |  6 +-
 drivers/base/core.c                           |  2 +
 drivers/gpu/drm/sun4i/sun4i_backend.c         |  8 +-
 drivers/iommu/io-pgtable-arm.c                |  2 +-
 .../platform/sunxi/sun4i-csi/sun4i_csi.c      |  9 ++-
 .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 11 ++-
 drivers/of/address.c                          | 73 ++++++++-----------
 drivers/of/device.c                           | 44 ++++++-----
 drivers/of/of_private.h                       | 11 +--
 drivers/of/unittest.c                         | 34 ++++++---
 drivers/remoteproc/remoteproc_core.c          | 24 +++++-
 .../staging/media/sunxi/cedrus/cedrus_hw.c    | 10 ++-
 include/linux/device.h                        |  4 +-
 include/linux/dma-direct.h                    | 52 +++++++++++--
 include/linux/dma-mapping.h                   |  9 ++-
 kernel/dma/coherent.c                         |  7 +-
 kernel/dma/direct.c                           | 51 ++++++++++++-
 22 files changed, 284 insertions(+), 118 deletions(-)

diff --git a/arch/arm/include/asm/dma-direct.h b/arch/arm/include/asm/dma-direct.h
index fbcf4367b5cb1a..436544aeb83405 100644
--- a/arch/arm/include/asm/dma-direct.h
+++ b/arch/arm/include/asm/dma-direct.h
@@ -12,8 +12,8 @@
 #ifndef __arch_pfn_to_dma
 static inline dma_addr_t pfn_to_dma(struct device *dev, unsigned long pfn)
 {
-	if (dev)
-		pfn -= dev->dma_pfn_offset;
+	if (dev && dev->dma_range_map)
+		pfn = PFN_DOWN(translate_phys_to_dma(dev, PFN_PHYS(pfn)));
 	return (dma_addr_t)__pfn_to_bus(pfn);
 }
 
@@ -21,9 +21,8 @@ static inline unsigned long dma_to_pfn(struct device *dev, dma_addr_t addr)
 {
 	unsigned long pfn = __bus_to_pfn(addr);
 
-	if (dev)
-		pfn += dev->dma_pfn_offset;
-
+	if (dev && dev->dma_range_map)
+		pfn = PFN_DOWN(translate_dma_to_phys(dev, PFN_PHYS(pfn)));
 	return pfn;
 }
 
diff --git a/arch/arm/mach-keystone/keystone.c b/arch/arm/mach-keystone/keystone.c
index dcd031ba84c2e0..09a65c2dfd7327 100644
--- a/arch/arm/mach-keystone/keystone.c
+++ b/arch/arm/mach-keystone/keystone.c
@@ -8,6 +8,7 @@
  */
 #include <linux/io.h>
 #include <linux/of.h>
+#include <linux/dma-mapping.h>
 #include <linux/init.h>
 #include <linux/of_platform.h>
 #include <linux/of_address.h>
@@ -25,8 +26,6 @@
 #include "keystone.h"
 
 #ifdef CONFIG_ARM_LPAE
-static unsigned long keystone_dma_pfn_offset __read_mostly;
-
 static int keystone_platform_notifier(struct notifier_block *nb,
 				      unsigned long event, void *data)
 {
@@ -39,9 +38,12 @@ static int keystone_platform_notifier(struct notifier_block *nb,
 		return NOTIFY_BAD;
 
 	if (!dev->of_node) {
-		dev->dma_pfn_offset = keystone_dma_pfn_offset;
-		dev_err(dev, "set dma_pfn_offset%08lx\n",
-			dev->dma_pfn_offset);
+		int ret = dma_direct_set_offset(dev, KEYSTONE_HIGH_PHYS_START,
+						KEYSTONE_LOW_PHYS_START,
+						KEYSTONE_HIGH_PHYS_SIZE);
+		dev_err(dev, "set dma_offset%08llx%s\n",
+			KEYSTONE_HIGH_PHYS_START - KEYSTONE_LOW_PHYS_START,
+			ret ? " failed" : "");
 	}
 	return NOTIFY_OK;
 }
@@ -54,11 +56,8 @@ static struct notifier_block platform_nb = {
 static void __init keystone_init(void)
 {
 #ifdef CONFIG_ARM_LPAE
-	if (PHYS_OFFSET >= KEYSTONE_HIGH_PHYS_START) {
-		keystone_dma_pfn_offset = PFN_DOWN(KEYSTONE_HIGH_PHYS_START -
-						   KEYSTONE_LOW_PHYS_START);
+	if (PHYS_OFFSET >= KEYSTONE_HIGH_PHYS_START)
 		bus_register_notifier(&platform_bus_type, &platform_nb);
-	}
 #endif
 	keystone_pm_runtime_init();
 }
diff --git a/arch/arm/mach-omap1/include/mach/memory.h b/arch/arm/mach-omap1/include/mach/memory.h
index e43697c3297bf2..1142560e0078f5 100644
--- a/arch/arm/mach-omap1/include/mach/memory.h
+++ b/arch/arm/mach-omap1/include/mach/memory.h
@@ -41,6 +41,10 @@
 	   __phys_to_pfn(__dma);				\
 	})
 
+#define __arch_dma_to_virt(dev, addr)	({ (void *) (is_lbus_device(dev) ? \
+						lbus_to_virt(addr) : \
+						__phys_to_virt(addr)); })
+
 #define __arch_virt_to_dma(dev, addr)	({ unsigned long __addr = (unsigned long)(addr); \
 					   (dma_addr_t) (is_lbus_device(dev) ? \
 						virt_to_lbus(__addr) : \
diff --git a/arch/sh/drivers/pci/pcie-sh7786.c b/arch/sh/drivers/pci/pcie-sh7786.c
index e0b568aaa7014c..4468289ab2cac7 100644
--- a/arch/sh/drivers/pci/pcie-sh7786.c
+++ b/arch/sh/drivers/pci/pcie-sh7786.c
@@ -12,6 +12,7 @@
 #include <linux/io.h>
 #include <linux/async.h>
 #include <linux/delay.h>
+#include <linux/dma-mapping.h>
 #include <linux/slab.h>
 #include <linux/clk.h>
 #include <linux/sh_clk.h>
@@ -31,6 +32,8 @@ struct sh7786_pcie_port {
 static struct sh7786_pcie_port *sh7786_pcie_ports;
 static unsigned int nr_ports;
 static unsigned long dma_pfn_offset;
+size_t memsize;
+u64 memstart;
 
 static struct sh7786_pcie_hwops {
 	int (*core_init)(void);
@@ -301,7 +304,6 @@ static int __init pcie_init(struct sh7786_pcie_port *port)
 	struct pci_channel *chan = port->hose;
 	unsigned int data;
 	phys_addr_t memstart, memend;
-	size_t memsize;
 	int ret, i, win;
 
 	/* Begin initialization */
@@ -368,8 +370,6 @@ static int __init pcie_init(struct sh7786_pcie_port *port)
 	memstart = ALIGN_DOWN(memstart, memsize);
 	memsize = roundup_pow_of_two(memend - memstart);
 
-	dma_pfn_offset = memstart >> PAGE_SHIFT;
-
 	/*
 	 * If there's more than 512MB of memory, we need to roll over to
 	 * LAR1/LAMR1.
@@ -487,7 +487,8 @@ int pcibios_map_platform_irq(const struct pci_dev *pdev, u8 slot, u8 pin)
 
 void pcibios_bus_add_device(struct pci_dev *pdev)
 {
-	pdev->dev.dma_pfn_offset = dma_pfn_offset;
+	dma_direct_set_offset(&pdev->dev, __pa(memory_start),
+			      __pa(memory_start) - memstart, memsize);
 }
 
 static int __init sh7786_pcie_core_init(void)
diff --git a/arch/x86/pci/sta2x11-fixup.c b/arch/x86/pci/sta2x11-fixup.c
index c313d784efabb9..324a207f99956b 100644
--- a/arch/x86/pci/sta2x11-fixup.c
+++ b/arch/x86/pci/sta2x11-fixup.c
@@ -133,7 +133,7 @@ static void sta2x11_map_ep(struct pci_dev *pdev)
 	struct sta2x11_instance *instance = sta2x11_pdev_to_instance(pdev);
 	struct device *dev = &pdev->dev;
 	u32 amba_base, max_amba_addr;
-	int i;
+	int i, ret;
 
 	if (!instance)
 		return;
@@ -141,7 +141,9 @@ static void sta2x11_map_ep(struct pci_dev *pdev)
 	pci_read_config_dword(pdev, AHB_BASE(0), &amba_base);
 	max_amba_addr = amba_base + STA2X11_AMBA_SIZE - 1;
 
-	dev->dma_pfn_offset = PFN_DOWN(-amba_base);
+	ret = dma_direct_set_offset(dev, 0, amba_base, STA2X11_AMBA_SIZE);
+	if (ret)
+		dev_err(dev, "sta2x11: could not set DMA offset\n");
 
 	dev->bus_dma_limit = max_amba_addr;
 	pci_set_consistent_dma_mask(pdev, max_amba_addr);
diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index ec782e4a0fe419..de18c07ca02cc4 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -18,6 +18,7 @@
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/dma-mapping.h>
 
 #define IORT_TYPE_MASK(type)	(1 << (type))
 #define IORT_MSI_TYPE		(1 << ACPI_IORT_NODE_ITS_GROUP)
@@ -1184,8 +1185,9 @@ void iort_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
 	*dma_addr = dmaaddr;
 	*dma_size = size;
 
-	dev->dma_pfn_offset = PFN_DOWN(offset);
-	dev_dbg(dev, "dma_pfn_offset(%#08llx)\n", offset);
+	ret = dma_direct_set_offset(dev, dmaaddr + offset, dmaaddr, size);
+
+	dev_dbg(dev, "dma_offset(%#08llx)%s\n", offset, ret ? " failed!" : "");
 }
 
 static void __init acpi_iort_register_irq(int hwirq, const char *name,
diff --git a/drivers/base/core.c b/drivers/base/core.c
index f6f620aa94086d..b893056e39459c 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1792,6 +1792,8 @@ static void device_release(struct kobject *kobj)
 	 */
 	devres_release_all(dev);
 
+	kfree(dev->dma_range_map);
+
 	if (dev->release)
 		dev->release(dev);
 	else if (dev->type && dev->type->release)
diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index 072ea113e6be55..05e9f0d28196d9 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/of_graph.h>
+#include <linux/dma-mapping.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 
@@ -811,8 +812,13 @@ static int sun4i_backend_bind(struct device *dev, struct device *master,
 		 * because of an old DT, we need to set the DMA offset by hand
 		 * on our device since the RAM mapping is at 0 for the DMA bus,
 		 * unlike the CPU.
+		 *
+		 * XXX(hch): this has no business in a driver and needs to move
+		 * to the device tree.
 		 */
-		drm->dev->dma_pfn_offset = PHYS_PFN_OFFSET;
+		ret = dma_direct_set_offset(drm->dev, PHYS_OFFSET, 0, SZ_4G);
+		if (ret)
+			return ret;
 	}
 
 	backend->engine.node = dev->of_node;
diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index dc7bcf858b6d2d..d77e881516a4ab 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -751,7 +751,7 @@ arm_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg)
 	if (cfg->oas > ARM_LPAE_MAX_ADDR_BITS)
 		return NULL;
 
-	if (!selftest_running && cfg->iommu_dev->dma_pfn_offset) {
+	if (!selftest_running && cfg->iommu_dev->dma_range_map) {
 		dev_err(cfg->iommu_dev, "Cannot accommodate DMA offset for IOMMU page tables\n");
 		return NULL;
 	}
diff --git a/drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.c b/drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.c
index 5319eb1ab30927..307997ee7f96a2 100644
--- a/drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.c
+++ b/drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/dma-mapping.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
@@ -182,8 +183,14 @@ static int sun4i_csi_probe(struct platform_device *pdev)
 		if (ret)
 			return ret;
 	} else {
+		/*
+		 * XXX(hch): this has no business in a driver and needs to move
+		 * to the device tree.
+		 */
 #ifdef PHYS_PFN_OFFSET
-		csi->dev->dma_pfn_offset = PHYS_PFN_OFFSET;
+		ret = dma_direct_set_offset(csi->dev, PHYS_OFFSET, 0, SZ_4G);
+		if (ret)
+			return ret;
 #endif
 	}
 
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index 28e89340fed981..e69e14379fc6e4 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
@@ -899,8 +899,15 @@ static int sun6i_csi_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	sdev->dev = &pdev->dev;
-	/* The DMA bus has the memory mapped at 0 */
-	sdev->dev->dma_pfn_offset = PHYS_OFFSET >> PAGE_SHIFT;
+	/*
+	 * The DMA bus has the memory mapped at 0.
+	 *
+	 * XXX(hch): this has no business in a driver and needs to move
+	 * to the device tree.
+	 */
+	ret = dma_direct_set_offset(sdev->dev, PHYS_OFFSET, 0, SZ_4G);
+	if (ret)
+		return ret;
 
 	ret = sun6i_csi_resource_request(sdev, pdev);
 	if (ret)
diff --git a/drivers/of/address.c b/drivers/of/address.c
index da4f7341323f22..a49ef87aaaf21c 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -13,6 +13,7 @@
 #include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/dma-direct.h> /* for bus_dma_region */
 
 #include "of_private.h"
 
@@ -937,33 +938,33 @@ void __iomem *of_io_request_and_map(struct device_node *np, int index,
 }
 EXPORT_SYMBOL(of_io_request_and_map);
 
+#ifdef CONFIG_HAS_DMA
 /**
- * of_dma_get_range - Get DMA range info
+ * of_dma_get_range - Get DMA range info and put it into a map array
  * @np:		device node to get DMA range info
- * @dma_addr:	pointer to store initial DMA address of DMA range
- * @paddr:	pointer to store initial CPU address of DMA range
- * @size:	pointer to store size of DMA range
+ * @map:	dma range structure to return
  *
  * Look in bottom up direction for the first "dma-ranges" property
- * and parse it.
- *  dma-ranges format:
+ * and parse it.  Put the information into a DMA offset map array.
+ *
+ * dma-ranges format:
  *	DMA addr (dma_addr)	: naddr cells
  *	CPU addr (phys_addr_t)	: pna cells
  *	size			: nsize cells
  *
- * It returns -ENODEV if "dma-ranges" property was not found
- * for this device in DT.
+ * It returns -ENODEV if "dma-ranges" property was not found for this
+ * device in the DT.
  */
-int of_dma_get_range(struct device_node *np, u64 *dma_addr, u64 *paddr, u64 *size)
+int of_dma_get_range(struct device_node *np, const struct bus_dma_region **map)
 {
 	struct device_node *node = of_node_get(np);
 	const __be32 *ranges = NULL;
-	int len;
-	int ret = 0;
 	bool found_dma_ranges = false;
 	struct of_range_parser parser;
 	struct of_range range;
-	u64 dma_start = U64_MAX, dma_end = 0, dma_offset = 0;
+	struct bus_dma_region *r;
+	int len, num_ranges = 0;
+	int ret = 0;
 
 	while (node) {
 		ranges = of_get_property(node, "dma-ranges", &len);
@@ -989,49 +990,39 @@ int of_dma_get_range(struct device_node *np, u64 *dma_addr, u64 *paddr, u64 *siz
 	}
 
 	of_dma_range_parser_init(&parser, node);
+	for_each_of_range(&parser, &range)
+		num_ranges++;
+
+	r = kcalloc(num_ranges + 1, sizeof(*r), GFP_KERNEL);
+	if (!r) {
+		ret = -ENOMEM;
+ 		goto out;
+	}
 
+	/*
+	 * Record all info in the generic DMA ranges array for struct device.
+	 */
+	*map = r;
+ 	of_dma_range_parser_init(&parser, node);
 	for_each_of_range(&parser, &range) {
 		pr_debug("dma_addr(%llx) cpu_addr(%llx) size(%llx)\n",
 			 range.bus_addr, range.cpu_addr, range.size);
-
-		if (dma_offset && range.cpu_addr - range.bus_addr != dma_offset) {
-			pr_warn("Can't handle multiple dma-ranges with different offsets on node(%pOF)\n", node);
-			/* Don't error out as we'd break some existing DTs */
-			continue;
-		}
 		if (range.cpu_addr == OF_BAD_ADDR) {
 			pr_err("translation of DMA address(%llx) to CPU address failed node(%pOF)\n",
 			       range.bus_addr, node);
 			continue;
 		}
-		dma_offset = range.cpu_addr - range.bus_addr;
-
-		/* Take lower and upper limits */
-		if (range.bus_addr < dma_start)
-			dma_start = range.bus_addr;
-		if (range.bus_addr + range.size > dma_end)
-			dma_end = range.bus_addr + range.size;
-	}
-
-	if (dma_start >= dma_end) {
-		ret = -EINVAL;
-		pr_debug("Invalid DMA ranges configuration on node(%pOF)\n",
-			 node);
-		goto out;
+		r->cpu_start = range.cpu_addr;
+		r->dma_start = range.bus_addr;
+		r->size = range.size;
+		r->offset = range.cpu_addr - range.bus_addr;
+		r++;
 	}
-
-	*dma_addr = dma_start;
-	*size = dma_end - dma_start;
-	*paddr = dma_start + dma_offset;
-
-	pr_debug("final: dma_addr(%llx) cpu_addr(%llx) size(%llx)\n",
-		 *dma_addr, *paddr, *size);
-
 out:
 	of_node_put(node);
-
 	return ret;
 }
+#endif /* CONFIG_HAS_DMA */
 
 /**
  * of_dma_is_coherent - Check if device is coherent
diff --git a/drivers/of/device.c b/drivers/of/device.c
index b439c1e054349b..6e3ae7ebc33eeb 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -5,7 +5,7 @@
 #include <linux/of_device.h>
 #include <linux/of_address.h>
 #include <linux/of_iommu.h>
-#include <linux/dma-mapping.h>
+#include <linux/dma-direct.h> /* for bus_dma_region */
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
@@ -90,14 +90,14 @@ int of_device_add(struct platform_device *ofdev)
 int of_dma_configure_id(struct device *dev, struct device_node *np,
 			bool force_dma, const u32 *id)
 {
-	u64 dma_addr, paddr, size = 0;
-	int ret;
-	bool coherent;
-	unsigned long offset;
 	const struct iommu_ops *iommu;
-	u64 mask, end;
+	const struct bus_dma_region *map = NULL;
+	dma_addr_t dma_start = 0;
+	u64 mask, end, size = 0;
+	bool coherent;
+	int ret;
 
-	ret = of_dma_get_range(np, &dma_addr, &paddr, &size);
+	ret = of_dma_get_range(np, &map);
 	if (ret < 0) {
 		/*
 		 * For legacy reasons, we have to assume some devices need
@@ -106,26 +106,35 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
 		 */
 		if (!force_dma)
 			return ret == -ENODEV ? 0 : ret;
-
-		dma_addr = offset = 0;
 	} else {
-		offset = PFN_DOWN(paddr - dma_addr);
+		const struct bus_dma_region *r = map;
+		dma_addr_t dma_end = 0;
+
+		/* Determine the overall bounds of all DMA regions */
+		for (dma_start = ~(dma_addr_t)0; r->size; r++) {
+			/* Take lower and upper limits */
+			if (r->dma_start < dma_start)
+				dma_start = r->dma_start;
+			if (r->dma_start + r->size > dma_end)
+				dma_end = r->dma_start + r->size;
+		}
+		size = dma_end - dma_start;
 
 		/*
 		 * Add a work around to treat the size as mask + 1 in case
 		 * it is defined in DT as a mask.
 		 */
 		if (size & 1) {
-			dev_warn(dev, "Invalid size 0x%llx for dma-range\n",
+			dev_warn(dev, "Invalid size 0x%llx for dma-range(s)\n",
 				 size);
 			size = size + 1;
 		}
 
 		if (!size) {
 			dev_err(dev, "Adjusted size 0x%llx invalid\n", size);
+			kfree(map);
 			return -EINVAL;
 		}
-		dev_dbg(dev, "dma_pfn_offset(%#08lx)\n", offset);
 	}
 
 	/*
@@ -144,13 +153,11 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
 	else if (!size)
 		size = 1ULL << 32;
 
-	dev->dma_pfn_offset = offset;
-
 	/*
 	 * Limit coherent and dma mask based on size and default mask
 	 * set by the driver.
 	 */
-	end = dma_addr + size - 1;
+	end = dma_start + size - 1;
 	mask = DMA_BIT_MASK(ilog2(end) + 1);
 	dev->coherent_dma_mask &= mask;
 	*dev->dma_mask &= mask;
@@ -163,14 +170,17 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
 		coherent ? " " : " not ");
 
 	iommu = of_iommu_configure(dev, np, id);
-	if (PTR_ERR(iommu) == -EPROBE_DEFER)
+	if (PTR_ERR(iommu) == -EPROBE_DEFER) {
+		kfree(map);
 		return -EPROBE_DEFER;
+	}
 
 	dev_dbg(dev, "device is%sbehind an iommu\n",
 		iommu ? " " : " not ");
 
-	arch_setup_dma_ops(dev, dma_addr, size, iommu, coherent);
+	arch_setup_dma_ops(dev, dma_start, size, iommu, coherent);
 
+	dev->dma_range_map = map;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(of_dma_configure_id);
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index edc682249c0015..d9e6a324de0a77 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -157,12 +157,13 @@ extern void __of_sysfs_remove_bin_file(struct device_node *np,
 extern int of_bus_n_addr_cells(struct device_node *np);
 extern int of_bus_n_size_cells(struct device_node *np);
 
-#ifdef CONFIG_OF_ADDRESS
-extern int of_dma_get_range(struct device_node *np, u64 *dma_addr,
-			    u64 *paddr, u64 *size);
+struct bus_dma_region;
+#if defined(CONFIG_OF_ADDRESS) && defined(CONFIG_HAS_DMA)
+int of_dma_get_range(struct device_node *np,
+		const struct bus_dma_region **map);
 #else
-static inline int of_dma_get_range(struct device_node *np, u64 *dma_addr,
-				   u64 *paddr, u64 *size)
+static inline int of_dma_get_range(struct device_node *np,
+		const struct bus_dma_region **map)
 {
 	return -ENODEV;
 }
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 9b7e84bdc7d446..06cc988faf78b3 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -7,6 +7,7 @@
 
 #include <linux/memblock.h>
 #include <linux/clk.h>
+#include <linux/dma-direct.h> /* to test phys_to_dma/dma_to_phys */
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/hashtable.h>
@@ -869,10 +870,11 @@ static void __init of_unittest_changeset(void)
 }
 
 static void __init of_unittest_dma_ranges_one(const char *path,
-		u64 expect_dma_addr, u64 expect_paddr, u64 expect_size)
+		u64 expect_dma_addr, u64 expect_paddr)
 {
+#ifdef CONFIG_HAS_DMA
 	struct device_node *np;
-	u64 dma_addr, paddr, size;
+	const struct bus_dma_region *map = NULL;
 	int rc;
 
 	np = of_find_node_by_path(path);
@@ -881,28 +883,40 @@ static void __init of_unittest_dma_ranges_one(const char *path,
 		return;
 	}
 
-	rc = of_dma_get_range(np, &dma_addr, &paddr, &size);
+	rc = of_dma_get_range(np, &map);
 
 	unittest(!rc, "of_dma_get_range failed on node %pOF rc=%i\n", np, rc);
+
 	if (!rc) {
-		unittest(size == expect_size,
-			 "of_dma_get_range wrong size on node %pOF size=%llx\n", np, size);
+		phys_addr_t	paddr;
+		dma_addr_t	dma_addr;
+		struct device	dev_bogus;
+
+		dev_bogus.dma_range_map = map;
+		paddr = dma_to_phys(&dev_bogus, expect_dma_addr);
+		dma_addr = phys_to_dma(&dev_bogus, expect_paddr);
+
 		unittest(paddr == expect_paddr,
-			 "of_dma_get_range wrong phys addr (%llx) on node %pOF", paddr, np);
+			 "of_dma_get_range: wrong phys addr %pap (expecting %llx) on node %pOF\n",
+			 &paddr, expect_paddr, np);
 		unittest(dma_addr == expect_dma_addr,
-			 "of_dma_get_range wrong DMA addr (%llx) on node %pOF", dma_addr, np);
+			 "of_dma_get_range: wrong DMA addr %pad (expecting %llx) on node %pOF\n",
+			 &dma_addr, expect_dma_addr, np);
+
+		kfree(map);
 	}
 	of_node_put(np);
+#endif
 }
 
 static void __init of_unittest_parse_dma_ranges(void)
 {
 	of_unittest_dma_ranges_one("/testcase-data/address-tests/device@70000000",
-		0x0, 0x20000000, 0x40000000);
+		0x0, 0x20000000);
 	of_unittest_dma_ranges_one("/testcase-data/address-tests/bus@80000000/device@1000",
-		0x100000000, 0x20000000, 0x2000000000);
+		0x100000000, 0x20000000);
 	of_unittest_dma_ranges_one("/testcase-data/address-tests/pci@90000000",
-		0x80000000, 0x20000000, 0x10000000);
+		0x80000000, 0x20000000);
 }
 
 static void __init of_unittest_pci_dma_ranges(void)
diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 7f90eeea67e279..8157dd491d2819 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -23,6 +23,7 @@
 #include <linux/slab.h>
 #include <linux/mutex.h>
 #include <linux/dma-mapping.h>
+#include <linux/dma-direct.h> /* XXX: pokes into bus_dma_range */
 #include <linux/firmware.h>
 #include <linux/string.h>
 #include <linux/debugfs.h>
@@ -458,6 +459,25 @@ static void rproc_rvdev_release(struct device *dev)
 	kfree(rvdev);
 }
 
+static int copy_dma_range_map(struct device *to, struct device *from)
+{
+	const struct bus_dma_region *map = from->dma_range_map, *new_map, *r;
+	int num_ranges = 0;
+
+	if (!map)
+		return 0;
+
+	for (r = map; r->size; r++)
+		num_ranges++;
+
+	new_map = kmemdup(map, array_size(num_ranges + 1, sizeof(*map)),
+			  GFP_KERNEL);
+	if (!new_map)
+		return -ENOMEM;
+	to->dma_range_map = new_map;
+	return 0;
+}
+
 /**
  * rproc_handle_vdev() - handle a vdev fw resource
  * @rproc: the remote processor
@@ -529,7 +549,9 @@ static int rproc_handle_vdev(struct rproc *rproc, struct fw_rsc_vdev *rsc,
 	/* Initialise vdev subdevice */
 	snprintf(name, sizeof(name), "vdev%dbuffer", rvdev->index);
 	rvdev->dev.parent = &rproc->dev;
-	rvdev->dev.dma_pfn_offset = rproc->dev.parent->dma_pfn_offset;
+	ret = copy_dma_range_map(&rvdev->dev, rproc->dev.parent);
+	if (ret)
+		return ret;
 	rvdev->dev.release = rproc_rvdev_release;
 	dev_set_name(&rvdev->dev, "%s#%s", dev_name(rvdev->dev.parent), name);
 	dev_set_drvdata(&rvdev->dev, rvdev);
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c b/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
index 1744e6fcc99980..bcf050a04ffc45 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
@@ -227,11 +227,17 @@ int cedrus_hw_probe(struct cedrus_dev *dev)
 	 * the RAM offset to the physcal addresses.
 	 *
 	 * This information will eventually be obtained from device-tree.
+	 *
+	 * XXX(hch): this has no business in a driver and needs to move
+	 * to the device tree.
 	 */
 
 #ifdef PHYS_PFN_OFFSET
-	if (!(variant->quirks & CEDRUS_QUIRK_NO_DMA_OFFSET))
-		dev->dev->dma_pfn_offset = PHYS_PFN_OFFSET;
+	if (!(variant->quirks & CEDRUS_QUIRK_NO_DMA_OFFSET)) {
+		ret = dma_direct_set_offset(dev->dev, PHYS_OFFSET, 0, SZ_4G);
+		if (ret)
+			return ret;
+	}
 #endif
 
 	ret = of_reserved_mem_device_init(dev->dev);
diff --git a/include/linux/device.h b/include/linux/device.h
index ca18da4768e3e8..1c78621fc3c01f 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -466,7 +466,7 @@ struct dev_links_info {
  * 		such descriptors.
  * @bus_dma_limit: Limit of an upstream bridge or bus which imposes a smaller
  *		DMA limit than the device itself supports.
- * @dma_pfn_offset: offset of DMA memory range relatively of RAM
+ * @dma_range_map: map for DMA memory ranges relative to that of RAM
  * @dma_parms:	A low level driver may set these to teach IOMMU code about
  * 		segment limitations.
  * @dma_pools:	Dma pools (if dma'ble device).
@@ -561,7 +561,7 @@ struct device {
 					     64 bit addresses for consistent
 					     allocations such descriptors. */
 	u64		bus_dma_limit;	/* upstream dma constraint */
-	unsigned long	dma_pfn_offset;
+	const struct bus_dma_region *dma_range_map;
 
 	struct device_dma_parameters *dma_parms;
 
diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index 805010ea5346f9..bd619579505687 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -14,6 +14,41 @@
 
 extern unsigned int zone_dma_bits;
 
+/*
+ * Record the mapping of CPU physical to DMA addresses for a given region.
+ */
+struct bus_dma_region {
+	phys_addr_t	cpu_start;
+	dma_addr_t	dma_start;
+	u64		size;
+	u64		offset;
+};
+
+static inline dma_addr_t translate_phys_to_dma(struct device *dev,
+		phys_addr_t paddr)
+{
+	const struct bus_dma_region *m;
+
+	for (m = dev->dma_range_map; m->size; m++)
+		if (paddr >= m->cpu_start && paddr - m->cpu_start < m->size)
+			return (dma_addr_t)paddr - m->offset;
+
+	/* make sure dma_capable fails when no translation is available */
+	return DMA_MAPPING_ERROR; 
+}
+
+static inline phys_addr_t translate_dma_to_phys(struct device *dev,
+		dma_addr_t dma_addr)
+{
+	const struct bus_dma_region *m;
+
+	for (m = dev->dma_range_map; m->size; m++)
+		if (dma_addr >= m->dma_start && dma_addr - m->dma_start < m->size)
+			return (phys_addr_t)dma_addr + m->offset;
+
+	return 0;
+}
+
 #ifdef CONFIG_ARCH_HAS_PHYS_TO_DMA
 #include <asm/dma-direct.h>
 #ifndef phys_to_dma_unencrypted
@@ -23,9 +58,9 @@ extern unsigned int zone_dma_bits;
 static inline dma_addr_t phys_to_dma_unencrypted(struct device *dev,
 		phys_addr_t paddr)
 {
-	dma_addr_t dev_addr = (dma_addr_t)paddr;
-
-	return dev_addr - ((dma_addr_t)dev->dma_pfn_offset << PAGE_SHIFT);
+	if (dev->dma_range_map)
+		return translate_phys_to_dma(dev, paddr);
+	return paddr;
 }
 
 /*
@@ -41,8 +76,12 @@ static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
 
 static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t dev_addr)
 {
-	phys_addr_t paddr = (phys_addr_t)dev_addr +
-		((phys_addr_t)dev->dma_pfn_offset << PAGE_SHIFT);
+	phys_addr_t paddr;
+
+	if (dev->dma_range_map)
+		paddr = translate_dma_to_phys(dev, dma_addr);
+	else
+		paddr = dma_addr;
 
 	return __sme_clr(paddr);
 }
@@ -64,7 +103,8 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size,
 
 	if (!dev->dma_mask)
 		return false;
-
+	if (addr == DMA_MAPPING_ERROR)
+		return false;
 	if (is_ram && !IS_ENABLED(CONFIG_ARCH_DMA_ADDR_T_64BIT) &&
 	    min(addr, end) < phys_to_dma(dev, PFN_PHYS(min_low_pfn)))
 		return false;
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index df0bff2ea750e0..bb138ac6f5e63e 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -730,4 +730,11 @@ static inline int dma_mmap_wc(struct device *dev,
 #define dma_unmap_len_set(PTR, LEN_NAME, VAL)    do { } while (0)
 #endif
 
-#endif
+/*
+ * Legacy interface to set up the dma offset map.  Drivers really should not
+ * actually use it, but we have a few legacy cases left.
+ */
+int dma_direct_set_offset(struct device *dev, phys_addr_t cpu_start,
+		dma_addr_t dma_start, u64 size);
+
+#endif /* _LINUX_DMA_MAPPING_H */
diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index f85d14bbfcbe03..c0685196fb6d42 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -7,7 +7,7 @@
 #include <linux/slab.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/dma-mapping.h>
+#include <linux/dma-direct.h>
 
 struct dma_coherent_mem {
 	void		*virt_base;
@@ -32,9 +32,8 @@ static inline dma_addr_t dma_get_device_base(struct device *dev,
 					     struct dma_coherent_mem * mem)
 {
 	if (mem->use_dev_dma_pfn_offset)
-		return (mem->pfn_base - dev->dma_pfn_offset) << PAGE_SHIFT;
-	else
-		return mem->device_base;
+		return phys_to_dma(dev, PFN_PHYS(mem->pfn_base));
+	return mem->device_base;
 }
 
 static int dma_init_coherent_memory(phys_addr_t phys_addr,
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 54db9cfdaecc6d..750659f7447c4b 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -13,6 +13,7 @@
 #include <linux/pfn.h>
 #include <linux/vmalloc.h>
 #include <linux/set_memory.h>
+#include <linux/slab.h>
 
 /*
  * Most architectures use ZONE_DMA for the first 16 Megabytes, but some use it
@@ -66,8 +67,12 @@ static gfp_t dma_direct_optimal_gfp_mask(struct device *dev, u64 dma_mask,
 
 static bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
 {
-	return phys_to_dma_direct(dev, phys) + size - 1 <=
-			min_not_zero(dev->coherent_dma_mask, dev->bus_dma_limit);
+	dma_addr_t dma_addr = phys_to_dma_direct(dev, phys);
+
+	if (dma_addr == DMA_MAPPING_ERROR)
+		return false;
+	return dma_addr + size - 1 <=
+		min_not_zero(dev->coherent_dma_mask, dev->bus_dma_limit);
 }
 
 /*
@@ -461,3 +466,45 @@ bool dma_direct_need_sync(struct device *dev, dma_addr_t dma_addr)
 	return !dev_is_dma_coherent(dev) ||
 		is_swiotlb_buffer(dma_to_phys(dev, dma_addr));
 }
+
+/**
+ * dma_direct_set_offset - Assign scalar offset for a single DMA range.
+ * @dev:	device pointer; needed to "own" the alloced memory.
+ * @cpu_start:  beginning of memory region covered by this offset.
+ * @dma_start:  beginning of DMA/PCI region covered by this offset.
+ * @size:	size of the region.
+ *
+ * This is for the simple case of a uniform offset which cannot
+ * be discovered by "dma-ranges".
+ *
+ * It returns -ENOMEM if out of memory, -EINVAL if a map
+ * already exists, 0 otherwise.
+ *
+ * Note: any call to this from a driver is a bug.  The mapping needs
+ * to be described by the device tree or other firmware interfaces.
+ */
+int dma_direct_set_offset(struct device *dev, phys_addr_t cpu_start,
+			 dma_addr_t dma_start, u64 size)
+{
+	struct bus_dma_region *map;
+	u64 offset = (u64)cpu_start - (u64)dma_start;
+
+	if (dev->dma_range_map) {
+		dev_err(dev, "attempt to add DMA range to existing map\n");
+		return -EINVAL;
+	}
+
+	if (!offset)
+		return 0;
+
+	map = kcalloc(2, sizeof(*map), GFP_KERNEL);
+	if (!map)
+		return -ENOMEM;
+	map[0].cpu_start = cpu_start;
+	map[0].dma_start = dma_start;
+	map[0].offset = offset;
+	map[0].size = size;
+	dev->dma_range_map = map;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dma_direct_set_offset);
-- 
2.28.0

