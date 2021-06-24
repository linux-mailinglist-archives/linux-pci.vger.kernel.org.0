Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4E43B38F9
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jun 2021 23:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232713AbhFXV6c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Jun 2021 17:58:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:60336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232650AbhFXV6a (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Jun 2021 17:58:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 45A72613C3;
        Thu, 24 Jun 2021 21:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624571770;
        bh=f7rGdZhLVrNc5kET8MKHCUshNp/bL7gBI1GctO6tCo0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QJgsx6LgqrK1Aat3oUPYa+Ghm+dtV38c8f/cwCm3INIpDRIB1XrvADzN7fJuhTn+O
         XJlnDqYgzy+6C7eGpWU+x5dc7RitbPv5+6sVj/4Bkg/NxdfeLH3S3INHIAHd80SCnF
         otDxyEY4cpnEqX187PkdAI6YOSr+ETBL3+CQriVPgvUf2tykUDhTTZ8shdK82AlwkK
         nc+uJ10yVY4S839vATbYUNO/Cv/k6zKDUi27HChnu2ib3rTRkQVgjWpasM6CgeilCZ
         9zycVY2eZ+i2zqH/74arIZeOhJbeW0VweJkKvtAMjZO/MyqvzxiMx3CAurskhY0Tm8
         c2t+4Xbm9V+jg==
Received: by pali.im (Postfix)
        id 6B2C896D; Thu, 24 Jun 2021 23:56:08 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Gregory Clement <gregory.clement@bootlin.com>
Cc:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        "Remi Pommarel" <repk@triplefau.lt>, Xogium <contact@xogium.me>,
        "Tomasz Maciej Nowak" <tmn505@gmail.com>,
        "Marc Zyngier" <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] PCI: aardvark: Configure PCIe resources from 'ranges' DT property
Date:   Thu, 24 Jun 2021 23:55:45 +0200
Message-Id: <20210624215546.4015-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210624215546.4015-1-pali@kernel.org>
References: <20210624215546.4015-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In commit 6df6ba974a55 ("PCI: aardvark: Remove PCIe outbound window
configuration") was removed aardvark PCIe outbound window configuration and
commit description said that was recommended solution by HW designers.

But that commit completely removed support for configuring PCIe IO
resources without removing PCIe IO 'ranges' from DTS files. After that
commit PCIe IO space started to be treated as PCIe MEM space and accessing
it just caused kernel crash.

Moreover implementation of PCIe outbound windows prior that commit was
incorrect. It completely ignored offset between CPU address and PCIe bus
address and expected that in DTS is CPU address always same as PCIe bus
address without doing any checks. Also it completely ignored size of every
PCIe resource specified in 'ranges' DTS property and expected that every
PCIe resource has size 128 MB (also for PCIe IO range). Again without any
check. Apparently none of PCIe resource has in DTS specified size of 128
MB. So it was completely broken and thanks to how aardvark mask works,
configuration was completely ignored.

This patch reverts back support for PCIe outbound window configuration but
implementation is a new without issues mentioned above. PCIe outbound
window is required when DTS specify in 'ranges' property non-zero offset
between CPU and PCIe address space. To address recommendation by HW
designers as specified in commit description of 6df6ba974a55, set default
outbound parameters as PCIe MEM access without translation and therefore
for this PCIe 'ranges' it is not needed to configure PCIe outbound window.
For PCIe IO space is needed to configure aardvark PCIe outbound window.

This patch fixes kernel crash when trying to access PCIe IO space.

Signed-off-by: Pali Rohár <pali@kernel.org>
Cc: stable@vger.kernel.org # 6df6ba974a55 ("PCI: aardvark: Remove PCIe outbound window configuration")
---
 drivers/pci/controller/pci-aardvark.c | 195 +++++++++++++++++++++++++-
 1 file changed, 194 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 3f3c72927afb..b4da496360f0 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -119,6 +119,46 @@
 #define PCIE_MSI_MASK_REG			(CONTROL_BASE_ADDR + 0x5C)
 #define PCIE_MSI_PAYLOAD_REG			(CONTROL_BASE_ADDR + 0x9C)
 
+/* PCIe window configuration */
+#define OB_WIN_BASE_ADDR			0x4c00
+#define OB_WIN_BLOCK_SIZE			0x20
+#define OB_WIN_COUNT				8
+#define OB_WIN_REG_ADDR(win, offset)		(OB_WIN_BASE_ADDR + \
+						 OB_WIN_BLOCK_SIZE * (win) + \
+						 (offset))
+#define OB_WIN_MATCH_LS(win)			OB_WIN_REG_ADDR(win, 0x00)
+#define     OB_WIN_ENABLE			BIT(0)
+#define OB_WIN_MATCH_MS(win)			OB_WIN_REG_ADDR(win, 0x04)
+#define OB_WIN_REMAP_LS(win)			OB_WIN_REG_ADDR(win, 0x08)
+#define OB_WIN_REMAP_MS(win)			OB_WIN_REG_ADDR(win, 0x0c)
+#define OB_WIN_MASK_LS(win)			OB_WIN_REG_ADDR(win, 0x10)
+#define OB_WIN_MASK_MS(win)			OB_WIN_REG_ADDR(win, 0x14)
+#define OB_WIN_ACTIONS(win)			OB_WIN_REG_ADDR(win, 0x18)
+#define OB_WIN_DEFAULT_ACTIONS			(OB_WIN_ACTIONS(OB_WIN_COUNT-1) + 0x4)
+#define     OB_WIN_FUNC_NUM_MASK		GENMASK(31, 24)
+#define     OB_WIN_FUNC_NUM_SHIFT		24
+#define     OB_WIN_FUNC_NUM_ENABLE		BIT(23)
+#define     OB_WIN_BUS_NUM_BITS_MASK		GENMASK(22, 20)
+#define     OB_WIN_BUS_NUM_BITS_SHIFT		20
+#define     OB_WIN_MSG_CODE_ENABLE		BIT(22)
+#define     OB_WIN_MSG_CODE_MASK		GENMASK(21, 14)
+#define     OB_WIN_MSG_CODE_SHIFT		14
+#define     OB_WIN_MSG_PAYLOAD_LEN		BIT(12)
+#define     OB_WIN_ATTR_ENABLE			BIT(11)
+#define     OB_WIN_ATTR_TC_MASK			GENMASK(10, 8)
+#define     OB_WIN_ATTR_TC_SHIFT		8
+#define     OB_WIN_ATTR_RELAXED			BIT(7)
+#define     OB_WIN_ATTR_NOSNOOP			BIT(6)
+#define     OB_WIN_ATTR_POISON			BIT(5)
+#define     OB_WIN_ATTR_IDO			BIT(4)
+#define     OB_WIN_TYPE_MASK			GENMASK(3, 0)
+#define     OB_WIN_TYPE_SHIFT			0
+#define     OB_WIN_TYPE_MEM			0x0
+#define     OB_WIN_TYPE_IO			0x4
+#define     OB_WIN_TYPE_CONFIG_TYPE0		0x8
+#define     OB_WIN_TYPE_CONFIG_TYPE1		0x9
+#define     OB_WIN_TYPE_MSG			0xc
+
 /* LMI registers base address and register offsets */
 #define LMI_BASE_ADDR				0x6000
 #define CFG_REG					(LMI_BASE_ADDR + 0x0)
@@ -183,6 +223,13 @@
 struct advk_pcie {
 	struct platform_device *pdev;
 	void __iomem *base;
+	struct {
+		phys_addr_t match;
+		phys_addr_t remap;
+		phys_addr_t mask;
+		u32 actions;
+	} wins[OB_WIN_COUNT];
+	u8 wins_count;
 	struct irq_domain *irq_domain;
 	struct irq_chip irq_chip;
 	struct irq_domain *msi_domain;
@@ -369,9 +416,39 @@ static void advk_pcie_train_link(struct advk_pcie *pcie)
 	dev_err(dev, "link never came up\n");
 }
 
+/*
+ * Set PCIe address window register which could be used for memory
+ * mapping.
+ */
+static void advk_pcie_set_ob_win(struct advk_pcie *pcie, u8 win_num,
+				 phys_addr_t match, phys_addr_t remap,
+				 phys_addr_t mask, u32 actions)
+{
+	advk_writel(pcie, OB_WIN_ENABLE |
+			  lower_32_bits(match), OB_WIN_MATCH_LS(win_num));
+	advk_writel(pcie, upper_32_bits(match), OB_WIN_MATCH_MS(win_num));
+	advk_writel(pcie, lower_32_bits(remap), OB_WIN_REMAP_LS(win_num));
+	advk_writel(pcie, upper_32_bits(remap), OB_WIN_REMAP_MS(win_num));
+	advk_writel(pcie, lower_32_bits(mask), OB_WIN_MASK_LS(win_num));
+	advk_writel(pcie, upper_32_bits(mask), OB_WIN_MASK_MS(win_num));
+	advk_writel(pcie, actions, OB_WIN_ACTIONS(win_num));
+}
+
+static void advk_pcie_disable_ob_win(struct advk_pcie *pcie, u8 win_num)
+{
+	advk_writel(pcie, 0, OB_WIN_MATCH_LS(win_num));
+	advk_writel(pcie, 0, OB_WIN_MATCH_MS(win_num));
+	advk_writel(pcie, 0, OB_WIN_REMAP_LS(win_num));
+	advk_writel(pcie, 0, OB_WIN_REMAP_MS(win_num));
+	advk_writel(pcie, 0, OB_WIN_MASK_LS(win_num));
+	advk_writel(pcie, 0, OB_WIN_MASK_MS(win_num));
+	advk_writel(pcie, 0, OB_WIN_ACTIONS(win_num));
+}
+
 static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 {
 	u32 reg;
+	int i;
 
 	/* Enable TX */
 	reg = advk_readl(pcie, PCIE_CORE_REF_CLK_REG);
@@ -440,15 +517,51 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 	reg = PCIE_IRQ_ALL_MASK & (~PCIE_IRQ_ENABLE_INTS_MASK);
 	advk_writel(pcie, reg, HOST_CTRL_INT_MASK_REG);
 
+	/*
+	 * Enable AXI address window location generation:
+	 * When it is enabled, the default outbound window
+	 * configurations (Default User Field: 0xD0074CFC)
+	 * are used to transparent address translation for
+	 * the outbound transactions. Thus, PCIe address
+	 * windows are not required for transparent memory
+	 * access when default outbound window configuration
+	 * is set for memory access.
+	 */
 	reg = advk_readl(pcie, PCIE_CORE_CTRL2_REG);
 	reg |= PCIE_CORE_CTRL2_OB_WIN_ENABLE;
 	advk_writel(pcie, reg, PCIE_CORE_CTRL2_REG);
 
-	/* Bypass the address window mapping for PIO */
+	/*
+	 * Set memory access in Default User Field so it
+	 * is not required to configure PCIe address for
+	 * transparent memory access.
+	 */
+	advk_writel(pcie, OB_WIN_TYPE_MEM, OB_WIN_DEFAULT_ACTIONS);
+
+	/*
+	 * Bypass the address window mapping for PIO:
+	 * Since PIO access already contains all required
+	 * info over AXI interface by PIO registers, the
+	 * address window is not required.
+	 */
 	reg = advk_readl(pcie, PIO_CTRL);
 	reg |= PIO_CTRL_ADDR_WIN_DISABLE;
 	advk_writel(pcie, reg, PIO_CTRL);
 
+	/*
+	 * Configure PCIe address windows for non-memory or
+	 * non-transparent access as by default PCIe uses
+	 * transparent memory access.
+	 */
+	for (i = 0; i < pcie->wins_count; i++)
+		advk_pcie_set_ob_win(pcie, i,
+				     pcie->wins[i].match, pcie->wins[i].remap,
+				     pcie->wins[i].mask, pcie->wins[i].actions);
+
+	/* Disable remaining PCIe outbound windows */
+	for (i = pcie->wins_count; i < OB_WIN_COUNT; i++)
+		advk_pcie_disable_ob_win(pcie, i);
+
 	advk_pcie_train_link(pcie);
 
 	/*
@@ -1218,6 +1331,7 @@ static int advk_pcie_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct advk_pcie *pcie;
 	struct pci_host_bridge *bridge;
+	struct resource_entry *entry;
 	int ret, irq;
 
 	bridge = devm_pci_alloc_host_bridge(dev, sizeof(struct advk_pcie));
@@ -1228,6 +1342,80 @@ static int advk_pcie_probe(struct platform_device *pdev)
 	pcie->pdev = pdev;
 	platform_set_drvdata(pdev, pcie);
 
+	resource_list_for_each_entry(entry, &bridge->windows) {
+		resource_size_t start = entry->res->start;
+		resource_size_t size = resource_size(entry->res);
+		unsigned long type = resource_type(entry->res);
+		u64 win_size;
+
+		/*
+		 * Aardvark hardware allows to configure also PCIe window
+		 * for config type 0 and type 1 mapping, but driver uses
+		 * only PIO for issuing configuration transfers which does
+		 * not use PCIe window configuration.
+		 */
+		if (type != IORESOURCE_MEM && type != IORESOURCE_MEM_64 &&
+		    type != IORESOURCE_IO)
+			continue;
+
+		/*
+		 * Skip transparent memory resources. Default outbound access
+		 * configuration is set to transparent memory access so it
+		 * does not need window configuration.
+		 */
+		if ((type == IORESOURCE_MEM || type == IORESOURCE_MEM_64) &&
+		    entry->offset == 0)
+			continue;
+
+		/*
+		 * The n-th PCIe window is configured by tuple (match, remap, mask)
+		 * and an access to address A uses this window if A matches the
+		 * match with given mask.
+		 * So every PCIe window size must be a power of two and every start
+		 * address must be aligned to window size. Minimal size is 64 KiB
+		 * because lower 16 bits of mask must be zero. Remapped address
+		 * may have set only bits from the mask.
+		 */
+		while (pcie->wins_count < OB_WIN_COUNT && size > 0) {
+			/* Calculate the largest aligned window size */
+			win_size = (1ULL << (fls64(size)-1)) |
+				   (start ? (1ULL << __ffs64(start)) : 0);
+			win_size = 1ULL << __ffs64(win_size);
+			if (win_size < 0x10000)
+				break;
+
+			dev_dbg(dev,
+				"Configuring PCIe window %d: [0x%llx-0x%llx] as %lu\n",
+				pcie->wins_count, (unsigned long long)start,
+				(unsigned long long)start + win_size, type);
+
+			if (type == IORESOURCE_IO) {
+				pcie->wins[pcie->wins_count].actions = OB_WIN_TYPE_IO;
+				pcie->wins[pcie->wins_count].match = pci_pio_to_address(start);
+			} else {
+				pcie->wins[pcie->wins_count].actions = OB_WIN_TYPE_MEM;
+				pcie->wins[pcie->wins_count].match = start;
+			}
+			pcie->wins[pcie->wins_count].remap = start - entry->offset;
+			pcie->wins[pcie->wins_count].mask = ~(win_size - 1);
+
+			if (pcie->wins[pcie->wins_count].remap & (win_size - 1))
+				break;
+
+			start += win_size;
+			size -= win_size;
+			pcie->wins_count++;
+		}
+
+		if (size > 0) {
+			dev_err(&pcie->pdev->dev,
+				"Invalid PCIe region [0x%llx-0x%llx]\n",
+				(unsigned long long)entry->res->start,
+				(unsigned long long)entry->res->end + 1);
+			return -EINVAL;
+		}
+	}
+
 	pcie->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pcie->base))
 		return PTR_ERR(pcie->base);
@@ -1308,6 +1496,7 @@ static int advk_pcie_remove(struct platform_device *pdev)
 {
 	struct advk_pcie *pcie = platform_get_drvdata(pdev);
 	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
+	int i;
 
 	pci_lock_rescan_remove();
 	pci_stop_root_bus(bridge->bus);
@@ -1317,6 +1506,10 @@ static int advk_pcie_remove(struct platform_device *pdev)
 	advk_pcie_remove_msi_irq_domain(pcie);
 	advk_pcie_remove_irq_domain(pcie);
 
+	/* Disable outbound address windows mapping */
+	for (i = 0; i < OB_WIN_COUNT; i++)
+		advk_pcie_disable_ob_win(pcie, i);
+
 	return 0;
 }
 
-- 
2.20.1

