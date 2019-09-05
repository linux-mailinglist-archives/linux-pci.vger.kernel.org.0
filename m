Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73DE0A9788
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2019 02:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730074AbfIEAOc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Sep 2019 20:14:32 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46729 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728008AbfIEAOb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Sep 2019 20:14:31 -0400
Received: by mail-wr1-f65.google.com with SMTP id h7so561455wrt.13
        for <linux-pci@vger.kernel.org>; Wed, 04 Sep 2019 17:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=EMqJanKa6d9ufLdcg9Og2Xx8yO+erq7cKQzFLTnqrLs=;
        b=uEqj10WJSkUkp59STUKXANKRAmF/lMiPYqV8ZZ/ptYYPLM+rpdLL6lc/AwWNfwcdeV
         FF+SmYfAoEDp4/iqdvmbjVIeZ33Yqys9nkUdnqlWd3NjDiX5GzLUELxnyoOr0GmAskhU
         Oe39XF/SVk4vjHmBWGBlDiQT0v9N7mLotN+T8TB8fXmlcxzmYSmxhn48U+PGl/xAy9A0
         +x768Y1tXsCWe1wInuojEZi+EAN3nA046SwDf41ft+w9VooP2mv08Ke4bmLKGN67GhxI
         HCavsBbE2qBIBE/qx/M3rPEqs5hl4DDWci/CFCXvjWNcdmr8+xlNJIh1tR0r7D7q+xE6
         ZI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=EMqJanKa6d9ufLdcg9Og2Xx8yO+erq7cKQzFLTnqrLs=;
        b=oGSi1dZu7o1CCMALFlfSJ/ehx3IfSKmzQNcrYnb+R2NKpU+S0yQIEV8jmJ78/Y9Ipp
         Rh/lX/+yN17iSNl7apnYB8jbDPx7K4ZQyXCJynK5kQ8qhtTvqBOeLsy1Etr2+dsilpqv
         1oqEkU0r2Iykm0fwYDzaDFdXtvrkzKxL5LGvxKoHy+wlYTRlxgg7yKCfkDO7jUlp1thD
         7VtAo0MJhm1ZMXGY/3iuvwZxYQlOqkwbEOpFXUgL53rOakEJhiNvs1R+8xpSwNNxzqB4
         7jruB4+VEWDb/W1dIZCrMVHVI7cY3uZOlARDfxC6dVEChYcgTVMA7JEfXMADsRwA/jZS
         escQ==
X-Gm-Message-State: APjAAAUJ0OpH1DOKrhYawbnOSHaImbJTlDDrudZSkITYQ/Ba8QaJRvqi
        TppBxDq2h2fTh2Lm0JE3KTUGFOT5
X-Google-Smtp-Source: APXvYqyie/z9mak96vfhL5bW9naBx6i3/N39TxYAsAvUT7WqIvgz1nWtZ0K/OLW4vOX52DYNsP4+vg==
X-Received: by 2002:a5d:6a90:: with SMTP id s16mr225115wru.282.1567642467453;
        Wed, 04 Sep 2019 17:14:27 -0700 (PDT)
Received: from kontron.lan (2001-1ae9-0ff1-f191-29a2-e1e4-a772-ac31.ip6.tmcz.cz. [2001:1ae9:ff1:f191:29a2:e1e4:a772:ac31])
        by smtp.gmail.com with ESMTPSA id t7sm495572wrr.37.2019.09.04.17.14.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Sep 2019 17:14:26 -0700 (PDT)
From:   Petr Cvek <petrcvekcz@gmail.com>
Subject: [RFC][PATCH] partial rewrite of pci-mt7620 driver
To:     jhogan@kernel.org, ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, linux-pci@vger.kernel.org
Message-ID: <2a546439-16b3-4cb5-8f87-8c255243a05c@gmail.com>
Date:   Thu, 5 Sep 2019 02:14:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

I've finally managed to clean the code to publishable format. The code is RFC because I have few questions. Most likely for MT7620 SoC behavior and the fact I've had to change general PCI subsystem (one function).

All functionality was tested on MT7628 SoC in vocore2 board.

The changes (along with lots of new comments):

1) Renamed few registers, they had misleading name and they was wrongly used:

 #define RALINK_PCI_IO_MAP_BASE		0x10160000
-#define RALINK_PCI_MEMORY_BASE		0x0

...

-#define RALINK_PCI_MEMBASE		0x28
-#define RALINK_PCI_IOBASE		0x2C
+#define RALINK_PCI_MEM_OFFSET		0x28
+#define RALINK_PCI_IO_OFFSET		0x2C

...

-	/* setup ranges */
-	bridge_w32(0xffffffff, RALINK_PCI_MEMBASE);
-	bridge_w32(RALINK_PCI_IO_MAP_BASE, RALINK_PCI_IOBASE);
+	/* offset of access in 0x1015xxxx will add to the reg val */
+	bridge_w32(0x30000000, RALINK_PCI_MEM_OFFSET);	//a valid value
+	/* no offset for IO access */
+	bridge_w32(0, RALINK_PCI_IO_OFFSET);

The RALINK_PCI_IOBASE register is not for value 0x10160000, but more like for an offset. Any access in RALINK_PCI_IO_MAP_BASE area (0x10000 length) will generate IO transaction from 0 to 0xffff. RALINK_PCI_IOBASE can add an offset to this.

2) The probe error path was reworked so it will return things like -ENODEV instead just -1. Plus in the case of an error during hw initialization the driver will always reset the PCIe core. The "no card found" message was little reworked. Maybe we could change dev_err to just dev_info. It is error path, but the missing card is a valid state and the message is only informative.

+
+fail_and_disable:
+#if 0
+	reset_control_assert(rstpcie0);
+	rt_sysc_m32(RALINK_PCIE0_CLK_EN, 0, RALINK_CLKCFG1);
+	if (ralink_soc == MT762X_SOC_MT7620A)
+		rt_sysc_m32(LC_CKDRVPD, PDRV_SW_SET, PPLL_DRV);
+#endif
+	return err;

(if 0 is just for debug ;-) )

3) non compliant BARs

-	pcie_w32(0x7FFF0001, RALINK_PCI0_BAR0SETUP_ADDR);

This sets the BAR size of host bridge (which is not exactly used). The problem is the PCIe core is designed badly, so this value also sets the size of accessible RAM for PCIe busmaster (device access host RAM). If you want to access the whole RAM, you must set this to 256MB. The problem is this register allows BAR0 to be detected with the same size and PCI probe will assign 256MB windows to unused host bridge. The 256MB PCIe region is also the max size for MT7628 SoC (-> there is no space left for cards).

I've workarounded this by setting the bar size to 0 in DECLARE_PCI_FIXUP_EARLY and later after PCI probing I set this to 256MB (ram size) in DECLARE_PCI_FIXUP_FINAL.

RFC here: if the behavior of RALINK_PCI0_BAR0SETUP_ADDR is the same in MT7620 (as in MT7628), please let me know, maybe the first DECLARE_PCI_FIXUP_EARLY can be moved just to global probe(). Also send me the default VID/PID of MT7620 (maybe MT7688, but I assume these are same as MT7628).

4) Added missing reset assertion + some info about what is what

-	/* bring the core out of reset */
+	/* put core into reset */
+	reset_control_assert(rstpcie0);

...

+	/* disable GPIO on PERST pinmux */
 	rt_sysc_m32(BIT(16), 0, RALINK_GPIOMODE);
+
+	/* bring the core out of reset, PERST is left asserted */
 	reset_control_deassert(rstpcie0);

5) I've added something like emergency interrupt handler. It seems the link down signal from the core is connected to the core reset, so if you unplug the card or the link is weak and it drops the PCIe core will reset, all registers/settings will be erased, interrupt and transactions disabled. This means any card and its driver will get probably locked up.

+	/* FIXME someone with mt7620: is there link down interrupt too? */
+	irq = of_irq_get(pdev->dev.of_node, 0);
+	if (irq <= 0) {
+		dev_err(&pdev->dev, "failed to get IRQ\n");
+		return irq ? irq : -EINVAL;
+	}
+
+	err = devm_request_irq(&pdev->dev, irq, mt7628_irq_handler_link,
+			       0, "PCIe link down", NULL);
+	if (err) {
+		dev_err(&pdev->dev, "failed to request IRQ %i\n", irq);
+		return err;
+	}

And the handler:

+/*
+ * TODO change it to WARN or BUG
+ * if this irq occurs, the PCIe controller "crashed"
+ * otherwise it would meant link down normally
+ */
+static irqreturn_t mt7628_irq_handler_link(int irq, void *data)
+{
+	u32 val = 0;
+
+	pr_emerg("PCIe link down, unstable system due HW BUG\n");
+
+//TODO maybe call bug?
+//delete vvvv, not working!
+#if 0
+
+	pr_info("**PCIe link down event %08x %08x\n",
+		bridge_r32(0x08),
+		pcie_r32(0x7414)
+	);
+
+	/* voodoo from the SDK driver */
+	pcie_m32(~0xff, 0x5, RALINK_PCIEPHY_P0_CTL_OFFSET);
+
+	// spread spectrum enable
+	pcie_w32(0x10000000, 0x7414);
+
+	pci_config_read(NULL, 0, 0x70, 4, &val);
+	val |= 1 << (8+16);
+	pci_config_write(NULL, 0, 0x70, 4, val);
+
+	pci_config_read(NULL, 0, 0x84, 4, &val);
+pr_info("slotcap1=%08x\n",val);
+
+	val &= ~(1 << 6);	//hotplug capable
+	val &= ~(1 << 5);	//hotplug surprise
+	val &= ~(1 << 0);	//no attn
+	val &= ~(1 << 1);	//no power control
+	val &= ~(1 << 2);	//no manual retention sensor
+	val &= ~(1 << 3);	//no attention indicator
+	val &= ~(1 << 4);	//no power indicator
+	val &= ~(1 << 17);	//no electromech interlock
+	pci_config_write(NULL, 0, 0x84, 4, val);
+
+	pci_config_read(NULL, 0, 0x84, 4, &val);
+pr_info("slotcap2=%08x\n",val);
+
+	pci_config_read(NULL, 0, 0x88, 4, &val);
+pr_info("slotstat=%08x\n",val);
+	val |= 0xffbf1008;	//clear  states
+	pci_config_write(NULL, 0, 0x88, 4, val);
+
+	pci_config_read(NULL, 0, 0x70c, 4, &val);
+	val &= ~(0xff) << 8;
+	val |= 0x80 << 8;
+	pci_config_write(NULL, 0, 0x70c, 4, val);
+
+//	bridge_w32(0xffffffff,0x08);
+// 	pr_info("aft fl=%08lx\n",bridge_r32(0x08));
+#endif
+	/* Nothing to do */
+	return IRQ_HANDLED;
+}

This handler should probably end with a kernel panic and the system will get locked/non coherent after that. 

(The code remains were just hotplug tests - the SoC obviously don't supports them)

RFC: does 7620 and 7688 behaves same? 

6) Bugfixes:

Register access in the wrong region.
-	pcie_m32(0, PCIRST, RALINK_PCI_PCICFG_ADDR);
+	bridge_m32(0, PCIRST, RALINK_PCI_PCICFG_ADDR);

... mdelay() to msleep() changes.

-	/* voodoo from the SDK driver */
+	/* voodoo from the SDK driver, phy LDO setting: 1..1.0V - 5..1.2V */

... be more descriptive from SDK driver.

7) Interrupt handling is now done from devicetree (function of_irq_parse_and_map_pci()), all devices shares IRQ 4 line of MIPS controller. There is no MSI (as from available documentations). 

8) Dependency on pci-legacy was removed, the driver now uses the general driver/pci functions as:

	devm_pci_alloc_host_bridge()
	pci_parse_request_of_pci_ranges()
	pci_host_probe()

The IO port mapping is done by new functions:

+unsigned long pci_address_to_pio(phys_addr_t address)
+{
+
+//get 0- 0xffff IO port value from physical address
+	return address - RALINK_PCI_IO_MAP_BASE;
+}
+
+void __iomem *__pci_ioport_map(struct pci_dev *dev,
+			       unsigned long port, unsigned int nr)
+{
+	void __iomem * temp;
+
+//get iomem address for driver accesses from IO port value
+	temp = (void __iomem *) (mips_io_port_base + port);
+
+	return temp;
+}
+

The problem is with general pci_remap_iospace() function, the code will fail without defined PCI_IOBASE in arch/mips. As defining PCI_IOBASE would changed too much of the code in arch/mips I've just disabled the check in pci_remap_iospace(). This could be solved by defining pci_remap_iospace() as a weak function too. Anyway this is just RFC, so if you have some remarks about PCI_IOBASE support feel free to comment.

The functionality was successfully tested with a real card.

The example of devicetree node (present only in openwrt):

	pcie@10140000 {
		compatible = "mediatek,mt7620-pci";
		reg = <0x10140000 0x100
			0x10142000 0x8000>;

 		#address-cells = <3>;
 		#size-cells = <2>;

		resets = <&resetc 26>;
		reset-names = "pcie0";

		interrupt-parent = <&intc>;
		interrupts = <16>;

		status = "okay";

		device_type = "pci";

                bus-range = <0x0 0xff>;

		ranges = <
			/* pci memory */
			0x02000000 0 0x20000000 0x20000000 0 0x10000000
			/* io space, NOTICE start from 0x1000, some cards and kernel don't like 0 */
			0x01000000 0 0x00000000 0x10160000 0 0x00010000
			/* pci memory, window offsetable by 0x28 reg */
//			0x02000000 0 0x30000000 0x10150000 0 0x00010000
		>;

		#interrupt-cells = <1>;
		interrupt-map-mask = <0xf800 0 0 1>;
		interrupt-map = <0x0000 0 0 1 &cpuintc 4 3 >;
	};


Regards,
Petr

---
 arch/mips/pci/pci-mt7620.c | 329 +++++++++++++++++++++++++++----------
 arch/mips/ralink/Kconfig   |   6 +
 drivers/pci/pci.c          |   4 +
 3 files changed, 251 insertions(+), 88 deletions(-)

diff --git a/arch/mips/pci/pci-mt7620.c b/arch/mips/pci/pci-mt7620.c
index d36061603752..f132e7de45bf 100644
--- a/arch/mips/pci/pci-mt7620.c
+++ b/arch/mips/pci/pci-mt7620.c
@@ -16,15 +16,28 @@
 #include <linux/of_irq.h>
 #include <linux/of_pci.h>
 #include <linux/reset.h>
+#include <linux/pci.h>
 #include <linux/platform_device.h>
 
 #include <asm/mach-ralink/ralink_regs.h>
 #include <asm/mach-ralink/mt7620.h>
 
+#define RALINK_MT7628_SPREAD_SPECTRUM
+
+/* region for IO port accesses */
 #define RALINK_PCI_IO_MAP_BASE		0x10160000
-#define RALINK_PCI_MEMORY_BASE		0x0
 
-#define RALINK_INT_PCIE0		4
+/* region for indirect MEM accesses */
+#define RALINK_PCI_IND_MEM_MAP_BASE	0x10150000
+
+/*
+ * RAM address offset for PCIe MEM access from device
+ * 0 = direct mapping
+ */
+#define RALINK_PCI_BUSMASTER_OFFSET	0x0
+
+/* IRQ number for all interrupts from PCIe */
+#define RALINK_IRQ_PCIE0		4
 
 #define RALINK_CLKCFG1			0x30
 #define RALINK_GPIOMODE			0x60
@@ -43,12 +56,13 @@
 #define PCIRST				BIT(1)
 
 #define RALINK_PCI_PCIENA		0x0C
+/* NOTICE on MT7628 this is called PCIINT0 */
 #define PCIINT2				BIT(20)
 
 #define RALINK_PCI_CONFIG_ADDR		0x20
 #define RALINK_PCI_CONFIG_DATA_VIRT_REG	0x24
-#define RALINK_PCI_MEMBASE		0x28
-#define RALINK_PCI_IOBASE		0x2C
+#define RALINK_PCI_MEM_OFFSET		0x28
+#define RALINK_PCI_IO_OFFSET		0x2C
 
 /* PCI RC registers */
 #define RALINK_PCI0_BAR0SETUP_ADDR	0x10
@@ -70,7 +84,6 @@
 #define DATA_SHIFT			0
 #define ADDR_SHIFT			8
 
-
 static void __iomem *bridge_base;
 static void __iomem *pcie_base;
 
@@ -86,6 +99,15 @@ static inline u32 bridge_r32(unsigned reg)
 	return ioread32(bridge_base + reg);
 }
 
+static inline void bridge_m32(u32 clr, u32 set, unsigned reg)
+{
+	u32 val = bridge_r32(reg);
+
+	val &= ~clr;
+	val |= set;
+	bridge_w32(val, reg);
+}
+
 static inline void pcie_w32(u32 val, unsigned reg)
 {
 	iowrite32(val, pcie_base + reg);
@@ -113,7 +135,7 @@ static int wait_pciephy_busy(void)
 		reg_value = pcie_r32(PCIEPHY0_CFG);
 
 		if (reg_value & BUSY)
-			mdelay(100);
+			msleep(100);
 		else
 			break;
 		if (retry++ > WAITRETRY_MAX) {
@@ -129,7 +151,7 @@ static void pcie_phy(unsigned long addr, unsigned long val)
 	wait_pciephy_busy();
 	pcie_w32(WRITE_MODE | (val << DATA_SHIFT) | (addr << ADDR_SHIFT),
 		 PCIEPHY0_CFG);
-	mdelay(1);
+	msleep(1);
 	wait_pciephy_busy();
 }
 
@@ -206,16 +228,86 @@ struct pci_ops mt7620_pci_ops = {
 	.write	= pci_config_write,
 };
 
-static struct resource mt7620_res_pci_mem1;
-static struct resource mt7620_res_pci_io1;
-struct pci_controller mt7620_controller = {
-	.pci_ops	= &mt7620_pci_ops,
-	.mem_resource	= &mt7620_res_pci_mem1,
-	.mem_offset	= 0x00000000UL,
-	.io_resource	= &mt7620_res_pci_io1,
-	.io_offset	= 0x00000000UL,
-	.io_map_base	= 0xa0000000,
-};
+unsigned long pci_address_to_pio(phys_addr_t address)
+{
+
+//get 0- 0xffff IO port value from physical address
+	return address - RALINK_PCI_IO_MAP_BASE;
+}
+
+void __iomem *__pci_ioport_map(struct pci_dev *dev,
+			       unsigned long port, unsigned int nr)
+{
+	void __iomem * temp;
+
+//get iomem address for driver accesses from IO port value
+	temp = (void __iomem *) (mips_io_port_base + port);
+
+	return temp;
+}
+
+/*
+ * TODO change it to WARN or BUG
+ * if this irq occurs, the PCIe controller "crashed"
+ * otherwise it would meant link down normally
+ */
+static irqreturn_t mt7628_irq_handler_link(int irq, void *data)
+{
+	u32 val = 0;
+
+	pr_emerg("PCIe link down, unstable system due HW BUG\n");
+
+//TODO maybe call bug?
+//delete vvvv, not working!
+#if 0
+
+	pr_info("**PCIe link down event %08x %08x\n",
+		bridge_r32(0x08),
+		pcie_r32(0x7414)
+	);
+
+	/* voodoo from the SDK driver */
+	pcie_m32(~0xff, 0x5, RALINK_PCIEPHY_P0_CTL_OFFSET);
+
+	// spread spectrum enable
+	pcie_w32(0x10000000, 0x7414);
+
+	pci_config_read(NULL, 0, 0x70, 4, &val);
+	val |= 1 << (8+16);
+	pci_config_write(NULL, 0, 0x70, 4, val);
+
+	pci_config_read(NULL, 0, 0x84, 4, &val);
+pr_info("slotcap1=%08x\n",val);
+
+	val &= ~(1 << 6);	//hotplug capable
+	val &= ~(1 << 5);	//hotplug surprise
+	val &= ~(1 << 0);	//no attn
+	val &= ~(1 << 1);	//no power control
+	val &= ~(1 << 2);	//no manual retention sensor
+	val &= ~(1 << 3);	//no attention indicator
+	val &= ~(1 << 4);	//no power indicator
+	val &= ~(1 << 17);	//no electromech interlock
+	pci_config_write(NULL, 0, 0x84, 4, val);
+
+	pci_config_read(NULL, 0, 0x84, 4, &val);
+pr_info("slotcap2=%08x\n",val);
+
+	pci_config_read(NULL, 0, 0x88, 4, &val);
+pr_info("slotstat=%08x\n",val);
+	val |= 0xffbf1008;	//clear  states
+	pci_config_write(NULL, 0, 0x88, 4, val);
+
+	pci_config_read(NULL, 0, 0x70c, 4, &val);
+	val &= ~(0xff) << 8;
+	val |= 0x80 << 8;
+	pci_config_write(NULL, 0, 0x70c, 4, val);
+
+//	bridge_w32(0xffffffff,0x08);
+// 	pr_info("aft fl=%08lx\n",bridge_r32(0x08));
+#endif
+	/* Nothing to do */
+	return IRQ_HANDLED;
+}
 
 static int mt7620_pci_hw_init(struct platform_device *pdev)
 {
@@ -227,7 +319,7 @@ static int mt7620_pci_hw_init(struct platform_device *pdev)
 	pcie_phy(0x68, 0xB4);
 
 	/* put core into reset */
-	pcie_m32(0, PCIRST, RALINK_PCI_PCICFG_ADDR);
+	bridge_m32(0, PCIRST, RALINK_PCI_PCICFG_ADDR);
 	reset_control_assert(rstpcie0);
 
 	/* disable power and all clocks */
@@ -237,7 +329,7 @@ static int mt7620_pci_hw_init(struct platform_device *pdev)
 	/* bring core out of reset */
 	reset_control_deassert(rstpcie0);
 	rt_sysc_m32(0, RALINK_PCIE0_CLK_EN, RALINK_CLKCFG1);
-	mdelay(100);
+	msleep(100);
 
 	if (!(rt_sysc_r32(PPLL_CFG1) & PDRV_SW_SET)) {
 		dev_err(&pdev->dev, "MT7620 PPLL unlock\n");
@@ -256,25 +348,59 @@ static int mt7620_pci_hw_init(struct platform_device *pdev)
 static int mt7628_pci_hw_init(struct platform_device *pdev)
 {
 	u32 val = 0;
+	int err;
+	int irq;
 
-	/* bring the core out of reset */
+	/* put core into reset */
+	reset_control_assert(rstpcie0);
+
+	/* FIXME someone with mt7620: is there link down interrupt too? */
+	irq = of_irq_get(pdev->dev.of_node, 0);
+	if (irq <= 0) {
+		dev_err(&pdev->dev, "failed to get IRQ\n");
+		return irq ? irq : -EINVAL;
+	}
+
+	err = devm_request_irq(&pdev->dev, irq, mt7628_irq_handler_link,
+			       0, "PCIe link down", NULL);
+	if (err) {
+		dev_err(&pdev->dev, "failed to request IRQ %i\n", irq);
+		return err;
+	}
+
+	/* disable GPIO on PERST pinmux */
 	rt_sysc_m32(BIT(16), 0, RALINK_GPIOMODE);
+
+	/* bring the core out of reset, PERST is left asserted */
 	reset_control_deassert(rstpcie0);
 
 	/* enable the pci clk */
 	rt_sysc_m32(0, RALINK_PCIE0_CLK_EN, RALINK_CLKCFG1);
-	mdelay(100);
 
-	/* voodoo from the SDK driver */
+	/* voodoo from the SDK driver, phy LDO setting: 1..1.0V - 5..1.2V */
 	pcie_m32(~0xff, 0x5, RALINK_PCIEPHY_P0_CTL_OFFSET);
 
+#if defined(RALINK_MT7628_SPREAD_SPECTRUM)
+	/* spread spectrum enable */
+	pcie_w32(0x10000000, 0x7414);
+#endif
+
+	/* wait for clock stabilization */
+	msleep(100);
+
+	/* set "slot implemented" flag */
+	pci_config_read(NULL, 0, 0x70, 4, &val);
+	val |= 1 << (8 + 16);
+	pci_config_write(NULL, 0, 0x70, 4, val);
+
+	/* Increase N_FTS, undocumented */
 	pci_config_read(NULL, 0, 0x70c, 4, &val);
 	val &= ~(0xff) << 8;
 	val |= 0x50 << 8;
 	pci_config_write(NULL, 0, 0x70c, 4, val);
 
 	pci_config_read(NULL, 0, 0x70c, 4, &val);
-	dev_err(&pdev->dev, "Port 0 N_FTS = %x\n", (unsigned int) val);
+	dev_info(&pdev->dev, "Port 0 N_FTS = %x\n", (unsigned int) val);
 
 	return 0;
 }
@@ -285,6 +411,8 @@ static int mt7620_pci_probe(struct platform_device *pdev)
 							    IORESOURCE_MEM, 0);
 	struct resource *pcie_res = platform_get_resource(pdev,
 							  IORESOURCE_MEM, 1);
+	struct pci_host_bridge *bridge;
+	int err;
 	u32 val = 0;
 
 	rstpcie0 = devm_reset_control_get_exclusive(&pdev->dev, "pcie0");
@@ -299,50 +427,56 @@ static int mt7620_pci_probe(struct platform_device *pdev)
 	if (IS_ERR(pcie_base))
 		return PTR_ERR(pcie_base);
 
-	iomem_resource.start = 0;
-	iomem_resource.end = ~0;
-	ioport_resource.start = 0;
-	ioport_resource.end = ~0;
-
 	/* bring up the pci core */
 	switch (ralink_soc) {
 	case MT762X_SOC_MT7620A:
-		if (mt7620_pci_hw_init(pdev))
-			return -1;
+		err = mt7620_pci_hw_init(pdev);
+		if (err)
+			goto fail_and_disable;
 		break;
 
 	case MT762X_SOC_MT7628AN:
 	case MT762X_SOC_MT7688:
-		if (mt7628_pci_hw_init(pdev))
-			return -1;
+		err = mt7628_pci_hw_init(pdev);
+		if (err)
+			goto fail_and_disable;
 		break;
 
 	default:
 		dev_err(&pdev->dev, "pcie is not supported on this hardware\n");
-		return -1;
+		err = -ENODEV;
+		goto fail_and_disable;
 	}
-	mdelay(50);
 
-	/* enable write access */
-	pcie_m32(PCIRST, 0, RALINK_PCI_PCICFG_ADDR);
-	mdelay(100);
+	/*
+	 * deactivate PERST after power and clock stabilization
+	 *
+	 * FIXME if mt7620 leaves PERST asserted too,
+	 * next wait can probably go away
+	 */
+	msleep(50);
+	bridge_m32(PCIRST, 0, RALINK_PCI_PCICFG_ADDR);
+
+	/* wait until device enables link */
+	msleep(100);
 
 	/* check if there is a card present */
 	if ((pcie_r32(RALINK_PCI0_STATUS) & PCIE_LINK_UP_ST) == 0) {
-		reset_control_assert(rstpcie0);
-		rt_sysc_m32(RALINK_PCIE0_CLK_EN, 0, RALINK_CLKCFG1);
-		if (ralink_soc == MT762X_SOC_MT7620A)
-			rt_sysc_m32(LC_CKDRVPD, PDRV_SW_SET, PPLL_DRV);
-		dev_err(&pdev->dev, "PCIE0 no card, disable it(RST&CLK)\n");
-		return -1;
+		dev_err(&pdev->dev, "No card detected, disable PCIe core\n");
+		err = -ENODEV;
+		goto fail_and_disable;
 	}
 
-	/* setup ranges */
-	bridge_w32(0xffffffff, RALINK_PCI_MEMBASE);
-	bridge_w32(RALINK_PCI_IO_MAP_BASE, RALINK_PCI_IOBASE);
+	/* offset of access in 0x1015xxxx will add to the reg val */
+	bridge_w32(0x30000000, RALINK_PCI_MEM_OFFSET);	//a valid value
+
+	/* no offset for IO access */
+	bridge_w32(0, RALINK_PCI_IO_OFFSET);
+
+	/* default offset for busmaster = beginning of RAM */
+	pcie_w32(RALINK_PCI_BUSMASTER_OFFSET, RALINK_PCI0_IMBASEBAR0_ADDR);
 
-	pcie_w32(0x7FFF0001, RALINK_PCI0_BAR0SETUP_ADDR);
-	pcie_w32(RALINK_PCI_MEMORY_BASE, RALINK_PCI0_IMBASEBAR0_ADDR);
+	/* change default class (wifi adapter) */
 	pcie_w32(0x06040001, RALINK_PCI0_CLASS);
 
 	/* enable interrupts */
@@ -352,51 +486,45 @@ static int mt7620_pci_probe(struct platform_device *pdev)
 	pci_config_read(NULL, 0, 4, 4, &val);
 	pci_config_write(NULL, 0, 4, 4, val | 0x7);
 
-	pci_load_of_ranges(&mt7620_controller, pdev->dev.of_node);
-	register_pci_controller(&mt7620_controller);
+	/* don't start IO ports from 0 */
+	PCIBIOS_MIN_IO = 0x1000;
+	PCIBIOS_MIN_MEM = 0x20000000;
 
-	return 0;
-}
+	set_io_port_base(KSEG1 + RALINK_PCI_IO_MAP_BASE);
 
-int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
-{
-	u16 cmd;
-	u32 val;
-	int irq = 0;
-
-	if ((dev->bus->number == 0) && (slot == 0)) {
-		pcie_w32(0x7FFF0001, RALINK_PCI0_BAR0SETUP_ADDR);
-		pci_config_write(dev->bus, 0, PCI_BASE_ADDRESS_0, 4,
-				 RALINK_PCI_MEMORY_BASE);
-		pci_config_read(dev->bus, 0, PCI_BASE_ADDRESS_0, 4, &val);
-	} else if ((dev->bus->number == 1) && (slot == 0x0)) {
-		irq = RALINK_INT_PCIE0;
-	} else {
-		dev_err(&dev->dev, "no irq found - bus=0x%x, slot = 0x%x\n",
-			dev->bus->number, slot);
-		return 0;
+        bridge = devm_pci_alloc_host_bridge(&pdev->dev, 0);
+        if (!bridge) {
+                err = -ENOMEM;
+		goto fail_and_disable;
 	}
-	dev_err(&dev->dev, "card - bus=0x%x, slot = 0x%x irq=%d\n",
-		dev->bus->number, slot, irq);
-
-	/* configure the cache line size to 0x14 */
-	pci_write_config_byte(dev, PCI_CACHE_LINE_SIZE, 0x14);
-
-	/* configure latency timer to 0xff */
-	pci_write_config_byte(dev, PCI_LATENCY_TIMER, 0xff);
-	pci_read_config_word(dev, PCI_COMMAND, &cmd);
-
-	/* setup the slot */
-	cmd = cmd | PCI_COMMAND_MASTER | PCI_COMMAND_IO | PCI_COMMAND_MEMORY;
-	pci_write_config_word(dev, PCI_COMMAND, cmd);
-	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
 
-	return irq;
-}
+	err = pci_parse_request_of_pci_ranges(&pdev->dev, &bridge->windows, NULL);
+	if (err)
+		goto fail_and_disable;
+
+	bridge->dev.parent = &pdev->dev;
+	bridge->busnr = 0;
+	bridge->ops = &mt7620_pci_ops;
+	bridge->swizzle_irq = pci_common_swizzle;
+	bridge->map_irq = of_irq_parse_and_map_pci;
+
+	err = pci_host_probe(bridge);
+	if (err < 0) {
+		dev_err(&pdev->dev, "failed to probe host %d\n", err);
+		pci_free_resource_list(&bridge->windows);
+		goto fail_and_disable;
+	}
 
-int pcibios_plat_dev_init(struct pci_dev *dev)
-{
 	return 0;
+
+fail_and_disable:
+#if 0
+	reset_control_assert(rstpcie0);
+	rt_sysc_m32(RALINK_PCIE0_CLK_EN, 0, RALINK_CLKCFG1);
+	if (ralink_soc == MT762X_SOC_MT7620A)
+		rt_sysc_m32(LC_CKDRVPD, PDRV_SW_SET, PPLL_DRV);
+#endif
+	return err;
 }
 
 static const struct of_device_id mt7620_pci_ids[] = {
@@ -414,7 +542,32 @@ static struct platform_driver mt7620_pci_driver = {
 
 static int __init mt7620_pci_init(void)
 {
-	return platform_driver_register(&mt7620_pci_driver);
+	int ret;
+
+	ret = platform_driver_register(&mt7620_pci_driver);
+	return ret;
 }
 
 arch_initcall(mt7620_pci_init);
+
+static void mediatek_fixup_bar(struct pci_dev *dev) {
+pr_info("++++++ mediatek_fixup_bar dev=%px\n",dev);
+
+//TODO probably put it directly to init, here only if mt7620 work OK
+//	dev->non_compliant_bars = true;
+
+	pcie_w32(0x0, RALINK_PCI0_BAR0SETUP_ADDR);
+	pcie_w32(0x0, RALINK_PCI0_BAR0SETUP_ADDR + 4);
+}
+DECLARE_PCI_FIXUP_EARLY(0x14c3, 0x0801, mediatek_fixup_bar);
+
+static void mediatek_fixup_final_bar(struct pci_dev *dev) {
+
+pr_info("++++++ MTK final fixup, BAR0 must-be-set bug\n");
+
+	pcie_w32(0x0FFF0001, RALINK_PCI0_BAR0SETUP_ADDR);
+	pcie_w32(0x0FFF0001, RALINK_PCI0_BAR0SETUP_ADDR);
+}
+
+//TODO for mt7620 ... or does it works there OK?
+DECLARE_PCI_FIXUP_FINAL(0x14c3, 0x0801, mediatek_fixup_final_bar);
diff --git a/arch/mips/ralink/Kconfig b/arch/mips/ralink/Kconfig
index 49c22ddd9c41..ac89d01cf7d5 100644
--- a/arch/mips/ralink/Kconfig
+++ b/arch/mips/ralink/Kconfig
@@ -38,8 +38,14 @@ choice
 
 	config SOC_MT7620
 		bool "MT7620/8"
+		select SYS_SUPPORTS_HIGHMEM
 		select CPU_MIPSR2_IRQ_VI
 		select HAVE_PCI
+#		select COMMON_CLK
+		select CPU_HAS_PREFETCH
+	        select PCI_DRIVERS_GENERIC
+	        select NO_GENERIC_PCI_IOPORT_MAP
+
 
 	config SOC_MT7621
 		bool "MT7621"
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index f20a3de57d21..2da5d8b4ba59 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3941,6 +3941,8 @@ unsigned long __weak pci_address_to_pio(phys_addr_t address)
  */
 int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
 {
+
+#if 0
 #if defined(PCI_IOBASE) && defined(CONFIG_MMU)
 	unsigned long vaddr = (unsigned long)PCI_IOBASE + res->start;
 
@@ -3960,6 +3962,8 @@ int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
 	WARN_ONCE(1, "This architecture does not support memory mapped I/O\n");
 	return -ENODEV;
 #endif
+#endif
+return 0;
 }
 EXPORT_SYMBOL(pci_remap_iospace);
 
-- 
2.23.0

