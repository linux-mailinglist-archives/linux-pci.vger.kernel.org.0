Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 688403E1DC1
	for <lists+linux-pci@lfdr.de>; Thu,  5 Aug 2021 23:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241866AbhHEVMX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Aug 2021 17:12:23 -0400
Received: from foss.arm.com ([217.140.110.172]:52392 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241806AbhHEVMW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Aug 2021 17:12:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 169D711FB;
        Thu,  5 Aug 2021 14:12:07 -0700 (PDT)
Received: from u200856.usa.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B78C3F719;
        Thu,  5 Aug 2021 14:12:06 -0700 (PDT)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-pci@vger.kernel.org
Cc:     lorenzo.pieralisi@arm.com, nsaenz@kernel.org, bhelgaas@google.com,
        rjw@rjwysocki.net, lenb@kernel.org, robh@kernel.org, kw@linux.com,
        f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH 1/3] PCI: brcmstb: Break register definitions into separate header
Date:   Thu,  5 Aug 2021 16:11:58 -0500
Message-Id: <20210805211200.491275-2-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210805211200.491275-1-jeremy.linton@arm.com>
References: <20210805211200.491275-1-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We are about to create a standalone ACPI quirk module for the
bcmstb controller. Lets move the register definitions into a separate
file so they can be shared between the APCI quirk and the normal
host bridge driver.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 179 +------------------------
 drivers/pci/controller/pcie-brcmstb.h | 182 ++++++++++++++++++++++++++
 2 files changed, 183 insertions(+), 178 deletions(-)
 create mode 100644 drivers/pci/controller/pcie-brcmstb.h

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 08bc788d9422..916de435ced9 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -31,192 +31,15 @@
 #include <linux/types.h>
 
 #include "../pci.h"
-
-/* BRCM_PCIE_CAP_REGS - Offset for the mandatory capability config regs */
-#define BRCM_PCIE_CAP_REGS				0x00ac
-
-/* Broadcom STB PCIe Register Offsets */
-#define PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1				0x0188
-#define  PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1_ENDIAN_MODE_BAR2_MASK	0xc
-#define  PCIE_RC_CFG_VENDOR_SPCIFIC_REG1_LITTLE_ENDIAN			0x0
-
-#define PCIE_RC_CFG_PRIV1_ID_VAL3			0x043c
-#define  PCIE_RC_CFG_PRIV1_ID_VAL3_CLASS_CODE_MASK	0xffffff
-
-#define PCIE_RC_CFG_PRIV1_LINK_CAPABILITY			0x04dc
-#define  PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK	0xc00
-
-#define PCIE_RC_DL_MDIO_ADDR				0x1100
-#define PCIE_RC_DL_MDIO_WR_DATA				0x1104
-#define PCIE_RC_DL_MDIO_RD_DATA				0x1108
-
-#define PCIE_MISC_MISC_CTRL				0x4008
-#define  PCIE_MISC_MISC_CTRL_SCB_ACCESS_EN_MASK		0x1000
-#define  PCIE_MISC_MISC_CTRL_CFG_READ_UR_MODE_MASK	0x2000
-#define  PCIE_MISC_MISC_CTRL_MAX_BURST_SIZE_MASK	0x300000
-
-#define  PCIE_MISC_MISC_CTRL_SCB0_SIZE_MASK		0xf8000000
-#define  PCIE_MISC_MISC_CTRL_SCB1_SIZE_MASK		0x07c00000
-#define  PCIE_MISC_MISC_CTRL_SCB2_SIZE_MASK		0x0000001f
-#define  SCB_SIZE_MASK(x) PCIE_MISC_MISC_CTRL_SCB ## x ## _SIZE_MASK
-
-#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LO		0x400c
-#define PCIE_MEM_WIN0_LO(win)	\
-		PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LO + ((win) * 8)
-
-#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_HI		0x4010
-#define PCIE_MEM_WIN0_HI(win)	\
-		PCIE_MISC_CPU_2_PCIE_MEM_WIN0_HI + ((win) * 8)
-
-#define PCIE_MISC_RC_BAR1_CONFIG_LO			0x402c
-#define  PCIE_MISC_RC_BAR1_CONFIG_LO_SIZE_MASK		0x1f
-
-#define PCIE_MISC_RC_BAR2_CONFIG_LO			0x4034
-#define  PCIE_MISC_RC_BAR2_CONFIG_LO_SIZE_MASK		0x1f
-#define PCIE_MISC_RC_BAR2_CONFIG_HI			0x4038
-
-#define PCIE_MISC_RC_BAR3_CONFIG_LO			0x403c
-#define  PCIE_MISC_RC_BAR3_CONFIG_LO_SIZE_MASK		0x1f
-
-#define PCIE_MISC_MSI_BAR_CONFIG_LO			0x4044
-#define PCIE_MISC_MSI_BAR_CONFIG_HI			0x4048
-
-#define PCIE_MISC_MSI_DATA_CONFIG			0x404c
-#define  PCIE_MISC_MSI_DATA_CONFIG_VAL_32		0xffe06540
-#define  PCIE_MISC_MSI_DATA_CONFIG_VAL_8		0xfff86540
-
-#define PCIE_MISC_PCIE_CTRL				0x4064
-#define  PCIE_MISC_PCIE_CTRL_PCIE_L23_REQUEST_MASK	0x1
-#define PCIE_MISC_PCIE_CTRL_PCIE_PERSTB_MASK		0x4
-
-#define PCIE_MISC_PCIE_STATUS				0x4068
-#define  PCIE_MISC_PCIE_STATUS_PCIE_PORT_MASK		0x80
-#define  PCIE_MISC_PCIE_STATUS_PCIE_DL_ACTIVE_MASK	0x20
-#define  PCIE_MISC_PCIE_STATUS_PCIE_PHYLINKUP_MASK	0x10
-#define  PCIE_MISC_PCIE_STATUS_PCIE_LINK_IN_L23_MASK	0x40
-
-#define PCIE_MISC_REVISION				0x406c
-#define  BRCM_PCIE_HW_REV_33				0x0303
-#define  BRCM_PCIE_HW_REV_3_20				0x0320
-
-#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT		0x4070
-#define  PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT_LIMIT_MASK	0xfff00000
-#define  PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT_BASE_MASK	0xfff0
-#define PCIE_MEM_WIN0_BASE_LIMIT(win)	\
-		PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT + ((win) * 4)
-
-#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_HI			0x4080
-#define  PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_HI_BASE_MASK	0xff
-#define PCIE_MEM_WIN0_BASE_HI(win)	\
-		PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_HI + ((win) * 8)
-
-#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LIMIT_HI			0x4084
-#define  PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LIMIT_HI_LIMIT_MASK	0xff
-#define PCIE_MEM_WIN0_LIMIT_HI(win)	\
-		PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LIMIT_HI + ((win) * 8)
-
-#define PCIE_MISC_HARD_PCIE_HARD_DEBUG					0x4204
-#define  PCIE_MISC_HARD_PCIE_HARD_DEBUG_CLKREQ_DEBUG_ENABLE_MASK	0x2
-#define  PCIE_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK		0x08000000
-
-
-#define PCIE_INTR2_CPU_BASE		0x4300
-#define PCIE_MSI_INTR2_BASE		0x4500
-/* Offsets from PCIE_INTR2_CPU_BASE and PCIE_MSI_INTR2_BASE */
-#define  MSI_INT_STATUS			0x0
-#define  MSI_INT_CLR			0x8
-#define  MSI_INT_MASK_SET		0x10
-#define  MSI_INT_MASK_CLR		0x14
-
-#define PCIE_EXT_CFG_DATA				0x8000
-#define PCIE_EXT_CFG_INDEX				0x9000
-
-#define  PCIE_RGR1_SW_INIT_1_PERST_MASK			0x1
-#define  PCIE_RGR1_SW_INIT_1_PERST_SHIFT		0x0
-
-#define RGR1_SW_INIT_1_INIT_GENERIC_MASK		0x2
-#define RGR1_SW_INIT_1_INIT_GENERIC_SHIFT		0x1
-#define RGR1_SW_INIT_1_INIT_7278_MASK			0x1
-#define RGR1_SW_INIT_1_INIT_7278_SHIFT			0x0
-
-/* PCIe parameters */
-#define BRCM_NUM_PCIE_OUT_WINS		0x4
-#define BRCM_INT_PCI_MSI_NR		32
-#define BRCM_INT_PCI_MSI_LEGACY_NR	8
-#define BRCM_INT_PCI_MSI_SHIFT		0
-
-/* MSI target adresses */
-#define BRCM_MSI_TARGET_ADDR_LT_4GB	0x0fffffffcULL
-#define BRCM_MSI_TARGET_ADDR_GT_4GB	0xffffffffcULL
-
-/* MDIO registers */
-#define MDIO_PORT0			0x0
-#define MDIO_DATA_MASK			0x7fffffff
-#define MDIO_PORT_MASK			0xf0000
-#define MDIO_REGAD_MASK			0xffff
-#define MDIO_CMD_MASK			0xfff00000
-#define MDIO_CMD_READ			0x1
-#define MDIO_CMD_WRITE			0x0
-#define MDIO_DATA_DONE_MASK		0x80000000
-#define MDIO_RD_DONE(x)			(((x) & MDIO_DATA_DONE_MASK) ? 1 : 0)
-#define MDIO_WT_DONE(x)			(((x) & MDIO_DATA_DONE_MASK) ? 0 : 1)
-#define SSC_REGS_ADDR			0x1100
-#define SET_ADDR_OFFSET			0x1f
-#define SSC_CNTL_OFFSET			0x2
-#define SSC_CNTL_OVRD_EN_MASK		0x8000
-#define SSC_CNTL_OVRD_VAL_MASK		0x4000
-#define SSC_STATUS_OFFSET		0x1
-#define SSC_STATUS_SSC_MASK		0x400
-#define SSC_STATUS_PLL_LOCK_MASK	0x800
-#define PCIE_BRCM_MAX_MEMC		3
-
-#define IDX_ADDR(pcie)			(pcie->reg_offsets[EXT_CFG_INDEX])
-#define DATA_ADDR(pcie)			(pcie->reg_offsets[EXT_CFG_DATA])
-#define PCIE_RGR1_SW_INIT_1(pcie)	(pcie->reg_offsets[RGR1_SW_INIT_1])
-
-/* Rescal registers */
-#define PCIE_DVT_PMU_PCIE_PHY_CTRL				0xc700
-#define  PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_NFLDS			0x3
-#define  PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_DIG_RESET_MASK		0x4
-#define  PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_DIG_RESET_SHIFT	0x2
-#define  PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_RESET_MASK		0x2
-#define  PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_RESET_SHIFT		0x1
-#define  PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_PWRDN_MASK		0x1
-#define  PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_PWRDN_SHIFT		0x0
+#include "pcie-brcmstb.h"
 
 /* Forward declarations */
-struct brcm_pcie;
 static inline void brcm_pcie_bridge_sw_init_set_7278(struct brcm_pcie *pcie, u32 val);
 static inline void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie, u32 val);
 static inline void brcm_pcie_perst_set_4908(struct brcm_pcie *pcie, u32 val);
 static inline void brcm_pcie_perst_set_7278(struct brcm_pcie *pcie, u32 val);
 static inline void brcm_pcie_perst_set_generic(struct brcm_pcie *pcie, u32 val);
 
-enum {
-	RGR1_SW_INIT_1,
-	EXT_CFG_INDEX,
-	EXT_CFG_DATA,
-};
-
-enum {
-	RGR1_SW_INIT_1_INIT_MASK,
-	RGR1_SW_INIT_1_INIT_SHIFT,
-};
-
-enum pcie_type {
-	GENERIC,
-	BCM4908,
-	BCM7278,
-	BCM2711,
-};
-
-struct pcie_cfg_data {
-	const int *offsets;
-	const enum pcie_type type;
-	void (*perst_set)(struct brcm_pcie *pcie, u32 val);
-	void (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
-};
-
 static const int pcie_offsets[] = {
 	[RGR1_SW_INIT_1] = 0x9210,
 	[EXT_CFG_INDEX]  = 0x9000,
diff --git a/drivers/pci/controller/pcie-brcmstb.h b/drivers/pci/controller/pcie-brcmstb.h
new file mode 100644
index 000000000000..b732a0ec56a0
--- /dev/null
+++ b/drivers/pci/controller/pcie-brcmstb.h
@@ -0,0 +1,182 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Copyright (C) 2009 - 2021 Broadcom */
+
+/* BRCM_PCIE_CAP_REGS - Offset for the mandatory capability config regs */
+#define BRCM_PCIE_CAP_REGS				0x00ac
+
+/* Broadcom STB PCIe Register Offsets */
+#define PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1				0x0188
+#define  PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1_ENDIAN_MODE_BAR2_MASK	0xc
+#define  PCIE_RC_CFG_VENDOR_SPCIFIC_REG1_LITTLE_ENDIAN			0x0
+
+#define PCIE_RC_CFG_PRIV1_ID_VAL3			0x043c
+#define  PCIE_RC_CFG_PRIV1_ID_VAL3_CLASS_CODE_MASK	0xffffff
+
+#define PCIE_RC_CFG_PRIV1_LINK_CAPABILITY			0x04dc
+#define  PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK	0xc00
+
+#define PCIE_RC_DL_MDIO_ADDR				0x1100
+#define PCIE_RC_DL_MDIO_WR_DATA				0x1104
+#define PCIE_RC_DL_MDIO_RD_DATA				0x1108
+
+#define PCIE_MISC_MISC_CTRL				0x4008
+#define  PCIE_MISC_MISC_CTRL_SCB_ACCESS_EN_MASK		0x1000
+#define  PCIE_MISC_MISC_CTRL_CFG_READ_UR_MODE_MASK	0x2000
+#define  PCIE_MISC_MISC_CTRL_MAX_BURST_SIZE_MASK	0x300000
+
+#define  PCIE_MISC_MISC_CTRL_SCB0_SIZE_MASK		0xf8000000
+#define  PCIE_MISC_MISC_CTRL_SCB1_SIZE_MASK		0x07c00000
+#define  PCIE_MISC_MISC_CTRL_SCB2_SIZE_MASK		0x0000001f
+#define  SCB_SIZE_MASK(x) PCIE_MISC_MISC_CTRL_SCB ## x ## _SIZE_MASK
+
+#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LO		0x400c
+#define PCIE_MEM_WIN0_LO(win)	\
+		PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LO + ((win) * 8)
+
+#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_HI		0x4010
+#define PCIE_MEM_WIN0_HI(win)	\
+		PCIE_MISC_CPU_2_PCIE_MEM_WIN0_HI + ((win) * 8)
+
+#define PCIE_MISC_RC_BAR1_CONFIG_LO			0x402c
+#define  PCIE_MISC_RC_BAR1_CONFIG_LO_SIZE_MASK		0x1f
+
+#define PCIE_MISC_RC_BAR2_CONFIG_LO			0x4034
+#define  PCIE_MISC_RC_BAR2_CONFIG_LO_SIZE_MASK		0x1f
+#define PCIE_MISC_RC_BAR2_CONFIG_HI			0x4038
+
+#define PCIE_MISC_RC_BAR3_CONFIG_LO			0x403c
+#define  PCIE_MISC_RC_BAR3_CONFIG_LO_SIZE_MASK		0x1f
+
+#define PCIE_MISC_MSI_BAR_CONFIG_LO			0x4044
+#define PCIE_MISC_MSI_BAR_CONFIG_HI			0x4048
+
+#define PCIE_MISC_MSI_DATA_CONFIG			0x404c
+#define  PCIE_MISC_MSI_DATA_CONFIG_VAL_32		0xffe06540
+#define  PCIE_MISC_MSI_DATA_CONFIG_VAL_8		0xfff86540
+
+#define PCIE_MISC_PCIE_CTRL				0x4064
+#define  PCIE_MISC_PCIE_CTRL_PCIE_L23_REQUEST_MASK	0x1
+#define PCIE_MISC_PCIE_CTRL_PCIE_PERSTB_MASK		0x4
+
+#define PCIE_MISC_PCIE_STATUS				0x4068
+#define  PCIE_MISC_PCIE_STATUS_PCIE_PORT_MASK		0x80
+#define  PCIE_MISC_PCIE_STATUS_PCIE_DL_ACTIVE_MASK	0x20
+#define  PCIE_MISC_PCIE_STATUS_PCIE_PHYLINKUP_MASK	0x10
+#define  PCIE_MISC_PCIE_STATUS_PCIE_LINK_IN_L23_MASK	0x40
+
+#define PCIE_MISC_REVISION				0x406c
+#define  BRCM_PCIE_HW_REV_33				0x0303
+#define  BRCM_PCIE_HW_REV_3_20				0x0320
+
+#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT		0x4070
+#define  PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT_LIMIT_MASK	0xfff00000
+#define  PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT_BASE_MASK	0xfff0
+#define PCIE_MEM_WIN0_BASE_LIMIT(win)	\
+		PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT + ((win) * 4)
+
+#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_HI			0x4080
+#define  PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_HI_BASE_MASK	0xff
+#define PCIE_MEM_WIN0_BASE_HI(win)	\
+		PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_HI + ((win) * 8)
+
+#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LIMIT_HI			0x4084
+#define  PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LIMIT_HI_LIMIT_MASK	0xff
+#define PCIE_MEM_WIN0_LIMIT_HI(win)	\
+		PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LIMIT_HI + ((win) * 8)
+
+#define PCIE_MISC_HARD_PCIE_HARD_DEBUG					0x4204
+#define  PCIE_MISC_HARD_PCIE_HARD_DEBUG_CLKREQ_DEBUG_ENABLE_MASK	0x2
+#define  PCIE_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK		0x08000000
+
+
+#define PCIE_INTR2_CPU_BASE		0x4300
+#define PCIE_MSI_INTR2_BASE		0x4500
+/* Offsets from PCIE_INTR2_CPU_BASE and PCIE_MSI_INTR2_BASE */
+#define  MSI_INT_STATUS			0x0
+#define  MSI_INT_CLR			0x8
+#define  MSI_INT_MASK_SET		0x10
+#define  MSI_INT_MASK_CLR		0x14
+
+#define PCIE_EXT_CFG_DATA				0x8000
+#define PCIE_EXT_CFG_INDEX				0x9000
+
+#define  PCIE_RGR1_SW_INIT_1_PERST_MASK			0x1
+#define  PCIE_RGR1_SW_INIT_1_PERST_SHIFT		0x0
+
+#define RGR1_SW_INIT_1_INIT_GENERIC_MASK		0x2
+#define RGR1_SW_INIT_1_INIT_GENERIC_SHIFT		0x1
+#define RGR1_SW_INIT_1_INIT_7278_MASK			0x1
+#define RGR1_SW_INIT_1_INIT_7278_SHIFT			0x0
+
+/* PCIe parameters */
+#define BRCM_NUM_PCIE_OUT_WINS		0x4
+#define BRCM_INT_PCI_MSI_NR		32
+#define BRCM_INT_PCI_MSI_LEGACY_NR	8
+#define BRCM_INT_PCI_MSI_SHIFT		0
+
+/* MSI target addresses */
+#define BRCM_MSI_TARGET_ADDR_LT_4GB	0x0fffffffcULL
+#define BRCM_MSI_TARGET_ADDR_GT_4GB	0xffffffffcULL
+
+/* MDIO registers */
+#define MDIO_PORT0			0x0
+#define MDIO_DATA_MASK			0x7fffffff
+#define MDIO_PORT_MASK			0xf0000
+#define MDIO_REGAD_MASK			0xffff
+#define MDIO_CMD_MASK			0xfff00000
+#define MDIO_CMD_READ			0x1
+#define MDIO_CMD_WRITE			0x0
+#define MDIO_DATA_DONE_MASK		0x80000000
+#define MDIO_RD_DONE(x)			(((x) & MDIO_DATA_DONE_MASK) ? 1 : 0)
+#define MDIO_WT_DONE(x)			(((x) & MDIO_DATA_DONE_MASK) ? 0 : 1)
+#define SSC_REGS_ADDR			0x1100
+#define SET_ADDR_OFFSET			0x1f
+#define SSC_CNTL_OFFSET			0x2
+#define SSC_CNTL_OVRD_EN_MASK		0x8000
+#define SSC_CNTL_OVRD_VAL_MASK		0x4000
+#define SSC_STATUS_OFFSET		0x1
+#define SSC_STATUS_SSC_MASK		0x400
+#define SSC_STATUS_PLL_LOCK_MASK	0x800
+#define PCIE_BRCM_MAX_MEMC		3
+
+#define IDX_ADDR(pcie)			(pcie->reg_offsets[EXT_CFG_INDEX])
+#define DATA_ADDR(pcie)			(pcie->reg_offsets[EXT_CFG_DATA])
+#define PCIE_RGR1_SW_INIT_1(pcie)	(pcie->reg_offsets[RGR1_SW_INIT_1])
+
+/* Rescal registers */
+#define PCIE_DVT_PMU_PCIE_PHY_CTRL				0xc700
+#define  PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_NFLDS			0x3
+#define  PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_DIG_RESET_MASK		0x4
+#define  PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_DIG_RESET_SHIFT	0x2
+#define  PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_RESET_MASK		0x2
+#define  PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_RESET_SHIFT		0x1
+#define  PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_PWRDN_MASK		0x1
+#define  PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_PWRDN_SHIFT		0x0
+
+/* Forward declarations */
+struct brcm_pcie;
+
+enum {
+	RGR1_SW_INIT_1,
+	EXT_CFG_INDEX,
+	EXT_CFG_DATA,
+};
+
+enum {
+	RGR1_SW_INIT_1_INIT_MASK,
+	RGR1_SW_INIT_1_INIT_SHIFT,
+};
+
+enum pcie_type {
+	GENERIC,
+	BCM4908,
+	BCM7278,
+	BCM2711,
+};
+
+struct pcie_cfg_data {
+	const int *offsets;
+	const enum pcie_type type;
+	void (*perst_set)(struct brcm_pcie *pcie, u32 val);
+	void (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
+};
-- 
2.31.1

