Return-Path: <linux-pci+bounces-37921-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B38DBD4979
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 17:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A175218A5F30
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 15:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD87A313536;
	Mon, 13 Oct 2025 15:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="R/EqLILR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-io1-f65.google.com (mail-io1-f65.google.com [209.85.166.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C288313297
	for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 15:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369742; cv=none; b=fYqRJmQ/M0JDxxSV9ADUUkH1JMridiMcfyNZ5Y1RQTCGkOmBOqrsBmxMOAfZyk36RrShcPkHPVcjl62zBYXwIeMiEp8iTAqwivacE1m/ywStB5XlLEKM93oqtZKv+J6m7jU7WOl5BqvsDF3ZVrJzRGYKOy/1R+BYX74eXPBybhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369742; c=relaxed/simple;
	bh=BZzLT2zTqqohce5XiFaeA7Y4ZBvLdr8R11zUfUnjosA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YkGyQ054BlOoor7AgPQOFhqufPtt71kSflMXziw0fPDnDRAcX3KIwxkDtyNtObYWLDG0djzEzdF32DS7Div7zoBhjHZ+2Uh5vpVIxVVsBjBOVtTggUriorYsl2ZybobZADGUCxE3L4L5XiFhL+1NkrI2L8Xz5nju84VvxoXmLn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=R/EqLILR; arc=none smtp.client-ip=209.85.166.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f65.google.com with SMTP id ca18e2360f4ac-93e2d42d9b4so106004039f.2
        for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 08:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1760369739; x=1760974539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aBCCSnYnVlbpKUHll5nMGocmcp9VAJDVhRzqTmH+szM=;
        b=R/EqLILRHbcVt/BBTOy6/4asGSiQg2HJXjGP+ic2lB6iZrDc/kqdaAuTE+LShBCc3z
         Tzjd6DqTmHY677vScXwwnMNMfY7igvJiOYNdRhRLBagf5YkSvf0eWxq6R/D0lUjJN+BC
         RHflg8KJLjTz2I4grFEDvg6PxKyC5wk/CwvhML62UMI+Gm9BofSF+uKKkCe6LuO7qjOB
         FvIyKlsGQeCVGMohZ/+0bDlvybSXbU2HlfdjTWyf6g3q6QSVdGoqvkKyM2ar2B5Eeod9
         XwX7CCrx90XND/m+pdsHUF6gi8iClvLk10Dfg1xmMUYlNa+1kvMdjtwK0G7KjKZiFfRW
         2c3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760369739; x=1760974539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aBCCSnYnVlbpKUHll5nMGocmcp9VAJDVhRzqTmH+szM=;
        b=kvLCV08tZ9e9m1xp39/+ka1epkNAwKLNbHqoQQGus0icht8mzOebuEUnNSsam7DnC7
         kSvfE3cqJ9WHzk1036SU1UuD5mgDHB1dvGr7bMFdGGtAg3SU1G6o2CSncoaEiVX9RH5s
         ZcojL+OSIJVriB9XZSaoL5XRdBic5B8Sp1Bq0eKeMpEpXZyoR0x+A71YcIljWAq0rhz2
         v6K5X2pyI5nBV5ZyySvWGh4p0vvQluosl8IZHxYOoOGL/Fj2BIkYmxOFmnccToRu0UkC
         kOoOev8jbnhsy0q9pRFJBQlKvrm1IO+3OTMYNVDd6P9ideI3SvtBVqc+dEQ+VcxCSKxk
         tVLQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4KcmZvXOwZGN/vMhjceaebxTyxziZ4wKUa6Pg86GOnIzZad5FD7ocqz9wEf8OzUNXRO8r6Z0qb9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJFjQXY6YPHHzLEcimzDnp6m1MGkvSR6D7laxWrwZlsu9WCBAS
	FWoNGJ8Ty8D6P4pnXR1czJ0Ce13p0gCBUjxIDUXjV6gm4+0PTt7mutUG04zdaQFxt+M=
X-Gm-Gg: ASbGncvgiUNTTEyvQj6QgWMdIuvxW0xGaY8lNsRyFJL7kr81KTr82w4+/KAdHHSJbRg
	txv2Va4NnmrgPsTScTXZ2OE3760M5bUzcRjsQCGTnLaO7EBJ3yVY48gMP4FFvWbOC3ml56ovZpo
	TqWtdvnMclmXKJcMj9VzhNjK9YqFHY4fkUzb0g3BBltrTMgnoy7k7B3nVrNwOgfzaykReb+bqNa
	Dg2dMgvnsSXyD3BQBW0IOQmTxElHz3QJOZ5/bdaqUpKNXXs3TjIetqR1FI2LgTsRcdS0qBIvsCq
	Xgkn2VE8dmskHFPxw9rfMtfo34lfKnmwEzHolnJRL1xHbhaHjki053pbMJdNsQ2tM0FWnX/vRSu
	8RhwsTVOxFMGUH3yVvFLo+jQIi4EeYvrn2gmmkTPLdZfQiy3iaZFsgW7iKBGpmrGkTKKp3+lDuf
	wdvBr2i/fv
X-Google-Smtp-Source: AGHT+IEUKLWHfv4WOxCqt3I62OMkhCpDR1jT8M+ohLnH8jpHa2C5L+kA+je4O8RkLJDRWoFTpDkvCw==
X-Received: by 2002:a05:6e02:144e:b0:42f:9ba7:e471 with SMTP id e9e14a558f8ab-42f9ba7e713mr122216845ab.20.1760369738846;
        Mon, 13 Oct 2025 08:35:38 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-58f6c49b522sm3910266173.1.2025.10.13.08.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 08:35:38 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	vkoul@kernel.org,
	kishon@kernel.org
Cc: dlan@gentoo.org,
	guodong@riscstar.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	p.zabel@pengutronix.de,
	christian.bruel@foss.st.com,
	shradha.t@samsung.com,
	krishna.chundru@oss.qualcomm.com,
	qiang.yu@oss.qualcomm.com,
	namcao@linutronix.de,
	thippeswamy.havalige@amd.com,
	inochiama@gmail.com,
	devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-phy@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Junzhong Pan <panjunzhong@linux.spacemit.com>
Subject: [PATCH v2 4/7] phy: spacemit: introduce PCIe/combo PHY
Date: Mon, 13 Oct 2025 10:35:21 -0500
Message-ID: <20251013153526.2276556-5-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251013153526.2276556-1-elder@riscstar.com>
References: <20251013153526.2276556-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a driver that supports three PHYs found on the SpacemiT
K1 SoC.  The first PHY is a combo PHY that can be configured for
use for either USB 3 or PCIe.  The other two PHYs support PCIe
only.

All three PHYs must be programmed with an 8 bit receiver termination
value, which must be determined dynamically.  Only the combo PHY is
able to determine this value.  The combo PHY performs a special
calibration step at probe time to discover this, and that value is
used to program each PHY that operates in PCIe mode.  The combo
PHY must therefore be probed before either of the PCIe-only PHYs
will be used.

Each PHY has an internal PLL driven from an external oscillator.
This PLL started when the PHY is first initialized, and stays
on thereafter.

During normal operation, the USB or PCIe driver using the PHY must
ensure (other) clocks and resets are set up properly.

However PCIe mode clocks are enabled and resets are de-asserted
temporarily by this driver to perform the calibration step on the
combo PHY.

Tested-by: Junzhong Pan <panjunzhong@linux.spacemit.com>
Signed-off-by: Alex Elder <elder@riscstar.com>
---
v2: - Renamed the PCIe driver Kconfig option PCIE_SPACEMIT_K1
    - Reimplemented the PHY PLL as a clock registered with the
      common clock framework, driven by an external oscillator
    - Memory-mapped regmap operations no longer check for errors
    - Bulk clocks are now named, allowing the PLL clock to be
      managed separate from the rest
    - No longer use a "virt" local variable for read/modify/write
    - Deleted a few unused symbol definitions
    - Added and reworded some comments

 drivers/phy/Kconfig                |  11 +
 drivers/phy/Makefile               |   1 +
 drivers/phy/phy-spacemit-k1-pcie.c | 672 +++++++++++++++++++++++++++++
 3 files changed, 684 insertions(+)
 create mode 100644 drivers/phy/phy-spacemit-k1-pcie.c

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 678dd0452f0aa..1984c2e56122e 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -101,6 +101,17 @@ config PHY_NXP_PTN3222
 	  schemes. It supports all three USB 2.0 data rates: Low Speed, Full
 	  Speed and High Speed.
 
+config PHY_SPACEMIT_K1_PCIE
+	tristate "PCIe and combo PHY driver for the SpacemiT K1 SoC"
+	depends on ARCH_SPACEMIT || COMPILE_TEST
+	depends on HAS_IOMEM
+	depends on OF
+	select GENERIC_PHY
+	default ARCH_SPACEMIT
+	help
+	  Enable support for the PCIe and USB 3 combo PHY and two
+	  PCIe-only PHYs used in the SpacemiT K1 SoC.
+
 source "drivers/phy/allwinner/Kconfig"
 source "drivers/phy/amlogic/Kconfig"
 source "drivers/phy/broadcom/Kconfig"
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index bfb27fb5a4942..a206133a35151 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_PHY_SNPS_EUSB2)		+= phy-snps-eusb2.o
 obj-$(CONFIG_USB_LGM_PHY)		+= phy-lgm-usb.o
 obj-$(CONFIG_PHY_AIROHA_PCIE)		+= phy-airoha-pcie.o
 obj-$(CONFIG_PHY_NXP_PTN3222)		+= phy-nxp-ptn3222.o
+obj-$(CONFIG_PHY_SPACEMIT_K1_PCIE)	+= phy-spacemit-k1-pcie.o
 obj-y					+= allwinner/	\
 					   amlogic/	\
 					   broadcom/	\
diff --git a/drivers/phy/phy-spacemit-k1-pcie.c b/drivers/phy/phy-spacemit-k1-pcie.c
new file mode 100644
index 0000000000000..81bc05823d080
--- /dev/null
+++ b/drivers/phy/phy-spacemit-k1-pcie.c
@@ -0,0 +1,672 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SpacemiT K1 PCIe and PCIe/USB 3 combo PHY driver
+ *
+ * Copyright (C) 2025 by RISCstar Solutions Corporation.  All rights reserved.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+
+#include <dt-bindings/phy/phy.h>
+
+/*
+ * Three PCIe ports are supported in the SpacemiT K1 SoC, and this driver
+ * supports their PHYs.
+ *
+ * The PHY for PCIe port A is different from the PHYs for ports B and C:
+ * - It has one lane, while ports B and C have two
+ * - It is a combo PHY can be used for PCIe or USB 3
+ * - It can automatically calibrate PCIe TX and RX termination settings
+ *
+ * The PHY functionality for PCIe ports B and C is identical:
+ * - They have two PCIe lanes (but can be restricted to 1 via Device Tree)
+ * - They are used for PCIe only
+ * - They are configured using TX and RX values computed for port A
+ *
+ * A given board is designed to use the combo PHY for either PCIe or USB 3.
+ * Whether the combo PHY is configured for PCIe or USB 3 is specified in
+ * Device Tree using a phandle plus an argument.  The argument indicates
+ * the type (either PHY_TYPE_PCIE or PHY_TYPE_USB3).
+ *
+ * Each PHY depends on clocks and resets provided by the controller
+ * hardware (PCIe or USB) it is associated with.  The controller drivers
+ * are required to enable any clocks and de-assert any resets that affect
+ * PHY operation.  In addition each PHY implements an internal PLL, driven
+ * by an external (24 MHz) oscillator.
+ *
+ * PCIe PHYs must be programmed with RX and TX calibration values.  The
+ * combo PHY is the only one that can determine these values.  They are
+ * determined by temporarily enabling the combo PHY in PCIe mode at probe
+ * time (if necessary).  This calibration only needs to be done once, and
+ * when it has completed the TX and RX values are saved.
+ *
+ * To allow the combo PHY to be enabled for calibration, the resets and
+ * clocks it uses in PCIe mode must be supplied.
+ */
+
+struct k1_pcie_phy {
+	struct device *dev;		/* PHY provider device */
+	struct phy *phy;
+	void __iomem *regs;
+	u32 pcie_lanes;			/* Max (1 or 2) unless limited by DT */
+	struct clk *pll;
+	struct clk_hw pll_hw;		/* Private PLL clock */
+
+	/* The remaining fields are only used for the combo PHY */
+	u32 type;			/* PHY_TYPE_PCIE or PHY_TYPE_USB3 */
+	struct regmap *pmu;		/* MMIO regmap (no errors) */
+};
+
+#define CALIBRATION_TIMEOUT		500000	/* For combo PHY (usec) */
+#define PLL_TIMEOUT			500000	/* For PHY PLL lock (usec) */
+#define POLL_DELAY			500	/* Time between polls (usec) */
+
+/* Selecting the combo PHY operating mode requires APMU regmap access */
+#define SYSCON_APMU			"spacemit,apmu"
+
+/* PMU space, for selecting between PCIe and USB 3 mode (combo PHY only) */
+
+#define PMUA_USB_PHY_CTRL0			0x0110
+#define COMBO_PHY_SEL			BIT(3)	/* 0: PCIe; 1: USB 3 */
+
+#define PCIE_CLK_RES_CTRL			0x03cc
+#define PCIE_APP_HOLD_PHY_RST		BIT(30)
+
+/* PHY register space */
+
+/* Offset between lane 0 and lane 1 registers when there are two */
+#define PHY_LANE_OFFSET				0x0400
+
+/* PHY PLL configuration */
+#define PCIE_PU_ADDR_CLK_CFG			0x0008
+#define PLL_READY			BIT(0)		/* read-only */
+#define CFG_INTERNAL_TIMER_ADJ		GENMASK(10, 7)
+#define TIMER_ADJ_USB		0x2
+#define TIMER_ADJ_PCIE		0x6
+#define CFG_SW_PHY_INIT_DONE		BIT(11)	/* We set after PLL config */
+
+#define PCIE_RC_DONE_STATUS			0x0018
+#define CFG_FORCE_RCV_RETRY		BIT(10)		/* Used for PCIe */
+
+/* PCIe PHY lane calibration; assumes 24MHz input clock */
+#define PCIE_RC_CAL_REG2			0x0020
+#define RC_CAL_TOGGLE			BIT(22)
+#define CLKSEL				GENMASK(31, 29)
+#define CLKSEL_24M		0x3
+
+/* Additional PHY PLL configuration (USB 3 and PCIe) */
+#define PCIE_PU_PLL_1				0x0048
+#define REF_100_WSSC			BIT(12)	/* 1: input is 100MHz, SSC */
+#define FREF_SEL			GENMASK(15, 13)
+#define FREF_24M		0x1
+#define SSC_DEP_SEL			GENMASK(19, 16)
+#define SSC_DEP_NONE		0x0
+#define SSC_DEP_5000PPM		0xa
+
+/* PCIe PHY configuration */
+#define PCIE_PU_PLL_2				0x004c
+#define GEN_REF100			BIT(4)	/* 1: generate 100MHz clk */
+
+#define PCIE_RX_REG1				0x0050
+#define EN_RTERM			BIT(3)
+#define AFE_RTERM_REG			GENMASK(11, 8)
+
+#define PCIE_RX_REG2				0x0054
+#define RX_RTERM_SEL			BIT(5)	/* 0: use AFE_RTERM_REG value */
+
+#define PCIE_LTSSM_DIS_ENTRY			0x005c
+#define CFG_REFCLK_MODE			GENMASK(9, 8)
+#define RFCLK_MODE_DRIVER	0x1
+#define OVRD_REFCLK_MODE		BIT(10)	/* 1: use CFG_RFCLK_MODE */
+
+#define PCIE_TX_REG1				0x0064
+#define TX_RTERM_REG			GENMASK(15, 12)
+#define TX_RTERM_SEL			BIT(25)	/* 1: use TX_RTERM_REG */
+
+/* Zeroed for the combo PHY operating in USB mode */
+#define USB3_TEST_CTRL				0x0068
+
+/* PHY calibration values, determined by the combo PHY at probe time */
+#define PCIE_RCAL_RESULT			0x0084	/* Port A PHY only */
+#define RTERM_VALUE_RX			GENMASK(3, 0)
+#define RTERM_VALUE_TX			GENMASK(7, 4)
+#define R_TUNE_DONE			BIT(10)
+
+static u32 k1_phy_rterm = ~0;     /* Invalid initial value */
+
+/* Save the RX and TX receiver termination values */
+static void k1_phy_rterm_set(u32 val)
+{
+	k1_phy_rterm = val & (RTERM_VALUE_RX | RTERM_VALUE_TX);
+}
+
+static bool k1_phy_rterm_valid(void)
+{
+	/* Valid if no bits outside those we care about are set */
+	return !(k1_phy_rterm & ~(RTERM_VALUE_RX | RTERM_VALUE_TX));
+}
+
+static u32 k1_phy_rterm_rx(void)
+{
+	return FIELD_GET(RTERM_VALUE_RX, k1_phy_rterm);
+}
+
+static u32 k1_phy_rterm_tx(void)
+{
+	return FIELD_GET(RTERM_VALUE_TX, k1_phy_rterm);
+}
+
+/* Only the combo PHY has a PMU pointer defined */
+static bool k1_phy_port_a(struct k1_pcie_phy *k1_phy)
+{
+	return !!k1_phy->pmu;
+}
+
+/* The PLL clocks are driven by the external oscillator */
+static const struct clk_parent_data k1_pcie_phy_data[] = {
+	{ .fw_name = "refclk", },
+};
+
+static struct k1_pcie_phy *clk_hw_to_k1_phy(struct clk_hw *clk_hw)
+{
+	return container_of(clk_hw, struct k1_pcie_phy, pll_hw);
+}
+
+/* USB mode only works on the combo PHY, which has only one lane */
+static void k1_pcie_phy_pll_prepare_usb(struct k1_pcie_phy *k1_phy)
+{
+	void __iomem *regs = k1_phy->regs;
+	u32 val;
+
+	val = readl(regs + PCIE_PU_ADDR_CLK_CFG);
+	val &= ~CFG_INTERNAL_TIMER_ADJ;
+	val |= FIELD_PREP(CFG_INTERNAL_TIMER_ADJ, TIMER_ADJ_USB);
+	writel(val, regs + PCIE_PU_ADDR_CLK_CFG);
+
+	val = readl(regs + PCIE_PU_PLL_1);
+	val &= ~SSC_DEP_SEL;
+	val |= FIELD_PREP(SSC_DEP_SEL, SSC_DEP_5000PPM);
+	writel(val, regs + PCIE_PU_PLL_1);
+}
+
+/* Perform PCIe-specific register updates before starting the PLL clock */
+static void k1_pcie_phy_pll_prepare_pcie(struct k1_pcie_phy *k1_phy)
+{
+	void __iomem *regs = k1_phy->regs;
+	u32 val;
+	u32 i;
+
+	for (i = 0; i < k1_phy->pcie_lanes; i++) {
+		val = readl(regs + PCIE_PU_ADDR_CLK_CFG);
+		val &= ~CFG_INTERNAL_TIMER_ADJ;
+		val |= FIELD_PREP(CFG_INTERNAL_TIMER_ADJ, TIMER_ADJ_PCIE);
+		writel(val, regs + PCIE_PU_ADDR_CLK_CFG);
+
+		regs += PHY_LANE_OFFSET;	/* Next lane */
+	}
+
+	regs = k1_phy->regs;
+	val = readl(regs + PCIE_RC_DONE_STATUS);
+	val |= CFG_FORCE_RCV_RETRY;
+	writel(val, regs + PCIE_RC_DONE_STATUS);
+
+	val = readl(regs + PCIE_PU_PLL_1);
+	val &= ~SSC_DEP_SEL;
+	val |= FIELD_PREP(SSC_DEP_SEL, SSC_DEP_NONE);
+	writel(val, regs + PCIE_PU_PLL_1);
+
+	val = readl(regs + PCIE_PU_PLL_2);
+	val |= GEN_REF100;		/* Enable 100 MHz PLL output clock */
+	writel(val, regs + PCIE_PU_PLL_2);
+}
+
+static int k1_pcie_phy_pll_prepare(struct clk_hw *clk_hw)
+{
+	struct k1_pcie_phy *k1_phy = clk_hw_to_k1_phy(clk_hw);
+	void __iomem *regs = k1_phy->regs;
+	u32 val;
+	u32 i;
+
+	if (k1_phy_port_a(k1_phy) && k1_phy->type == PHY_TYPE_USB3)
+		k1_pcie_phy_pll_prepare_usb(k1_phy);
+	else
+		k1_pcie_phy_pll_prepare_pcie(k1_phy);
+
+	/*
+	 * Disable 100 MHz input reference with spread-spectrum
+	 * clocking and select the 24 MHz clock input frequency
+	 */
+	val = readl(regs + PCIE_PU_PLL_1);
+	val &= ~REF_100_WSSC;
+	val &= ~FREF_SEL;
+	val |= FIELD_PREP(FREF_SEL, FREF_24M);
+	writel(val, regs + PCIE_PU_PLL_1);
+
+	/* Mark PLL configuration done on all lanes */
+	for (i = 0; i < k1_phy->pcie_lanes; i++) {
+		val = readl(regs + PCIE_PU_ADDR_CLK_CFG);
+		val |= CFG_SW_PHY_INIT_DONE;
+		writel(val, regs + PCIE_PU_ADDR_CLK_CFG);
+
+		regs += PHY_LANE_OFFSET;	/* Next lane */
+	}
+
+	/*
+	 * Wait for indication the PHY PLL is locked.  Lanes for ports
+	 * B and C share a PLL, so it's enough to sample just lane 0.
+	 */
+	return readl_poll_timeout(k1_phy->regs + PCIE_PU_ADDR_CLK_CFG,
+				  val, val & PLL_READY,
+				  POLL_DELAY, PLL_TIMEOUT);
+}
+
+/* Prepare implies enable, and once enabled, it's always on */
+static const struct clk_ops k1_pcie_phy_pll_ops = {
+	.prepare	= k1_pcie_phy_pll_prepare,
+};
+
+/* We represent the PHY PLL as a private clock */
+static int k1_pcie_phy_pll_setup(struct k1_pcie_phy *k1_phy)
+{
+	struct clk_hw *hw = &k1_phy->pll_hw;
+	struct device *dev = k1_phy->dev;
+	struct clk_init_data init = { };
+	char *name;
+	int ret;
+
+	name = kasprintf(GFP_KERNEL, "pcie%u_phy_pll", k1_phy->phy->id);
+	if (!name)
+		return -ENOMEM;
+
+	init.name = name;
+	init.ops = &k1_pcie_phy_pll_ops;
+	init.parent_data = k1_pcie_phy_data;
+	init.num_parents = ARRAY_SIZE(k1_pcie_phy_data);
+
+	hw->init = &init;
+
+	ret = devm_clk_hw_register(dev, hw);
+
+	kfree(name);	/* __clk_register() duplicates the name we provide */
+
+	if (ret)
+		return ret;
+
+	k1_phy->pll = devm_clk_hw_get_clk(dev, hw, "pll");
+	if (IS_ERR(k1_phy->pll))
+		return PTR_ERR(k1_phy->pll);
+
+	return 0;
+}
+
+/* Select PCIe or USB 3 mode for the combo PHY. */
+static void k1_combo_phy_sel(struct k1_pcie_phy *k1_phy, bool usb)
+{
+	struct regmap *pmu = k1_phy->pmu;
+
+	/* Only change it if it's not already in the desired state */
+	if (!regmap_test_bits(pmu, PMUA_USB_PHY_CTRL0, COMBO_PHY_SEL) == usb)
+		regmap_assign_bits(pmu, PMUA_USB_PHY_CTRL0, COMBO_PHY_SEL, usb);
+}
+
+static void k1_pcie_phy_init_pcie(struct k1_pcie_phy *k1_phy)
+{
+	u32 rx_rterm = k1_phy_rterm_rx();
+	u32 tx_rterm = k1_phy_rterm_tx();
+	void __iomem *regs;
+	u32 val;
+	int i;
+
+	/* For the combo PHY, set PHY to PCIe mode */
+	if (k1_phy_port_a(k1_phy))
+		k1_combo_phy_sel(k1_phy, false);
+
+	regs = k1_phy->regs;
+	for (i = 0; i < k1_phy->pcie_lanes; i++) {
+		val = readl(regs + PCIE_RX_REG1);
+
+		/* Set RX analog front-end receiver termination value */
+		val &= ~AFE_RTERM_REG;
+		val |= FIELD_PREP(AFE_RTERM_REG, rx_rterm);
+
+		/* And enable refclock receiver termination */
+		val |= EN_RTERM;
+		writel(val, regs + PCIE_RX_REG1);
+
+		val = readl(regs + PCIE_RX_REG2);
+		/* Use PCIE_RX_REG1 AFE_RTERM_REG value */
+		val &= ~RX_RTERM_SEL;
+		writel(val, regs + PCIE_RX_REG2);
+
+		val = readl(regs + PCIE_TX_REG1);
+
+		/* Set TX driver termination value */
+		val &= ~TX_RTERM_REG;
+		val |= FIELD_PREP(TX_RTERM_REG, tx_rterm);
+
+		/* Use PCIE_TX_REG1 TX_RTERM_REG value */
+		val |= TX_RTERM_SEL;
+		writel(val, regs + PCIE_TX_REG1);
+
+		/* Set the input clock to 24 MHz, and clear RC_CAL_TOGGLE */
+		val = readl(regs + PCIE_RC_CAL_REG2);
+		val &= CLKSEL;
+		val |= FIELD_PREP(CLKSEL, CLKSEL_24M);
+		val &= ~RC_CAL_TOGGLE;
+		writel(val, regs + PCIE_RC_CAL_REG2);
+
+		/* Now trigger recalibration by setting RC_CAL_TOGGLE again */
+		val |= RC_CAL_TOGGLE;
+		writel(val, regs + PCIE_RC_CAL_REG2);
+
+		val = readl(regs + PCIE_LTSSM_DIS_ENTRY);
+		/* Override the reference clock; set to refclk driver mode */
+		val |= OVRD_REFCLK_MODE;
+		val &= ~CFG_REFCLK_MODE;
+		val |= FIELD_PREP(CFG_REFCLK_MODE, RFCLK_MODE_DRIVER);
+		writel(val, regs + PCIE_LTSSM_DIS_ENTRY);
+
+		regs += PHY_LANE_OFFSET;	/* Next lane */
+	}
+}
+
+/* Only called for combo PHY */
+static void k1_pcie_phy_init_usb(struct k1_pcie_phy *k1_phy)
+{
+	k1_combo_phy_sel(k1_phy, true);
+
+	/* We're not doing any testing */
+	writel(0, k1_phy->regs + USB3_TEST_CTRL);
+}
+
+static int k1_pcie_phy_init(struct phy *phy)
+{
+	struct k1_pcie_phy *k1_phy = phy_get_drvdata(phy);
+
+	/* Note: port type is only valid for port A (both checks needed) */
+	if (k1_phy_port_a(k1_phy) && k1_phy->type == PHY_TYPE_USB3)
+		k1_pcie_phy_init_usb(k1_phy);
+	else
+		k1_pcie_phy_init_pcie(k1_phy);
+
+
+	return clk_prepare_enable(k1_phy->pll);
+}
+
+static int k1_pcie_phy_exit(struct phy *phy)
+{
+	struct k1_pcie_phy *k1_phy = phy_get_drvdata(phy);
+
+	clk_disable_unprepare(k1_phy->pll);
+
+	return 0;
+}
+
+static const struct phy_ops k1_pcie_phy_ops = {
+	.init		= k1_pcie_phy_init,
+	.exit		= k1_pcie_phy_exit,
+	.owner		= THIS_MODULE,
+};
+
+/*
+ * Get values needed for calibrating PHYs operating in PCIe mode.  Only
+ * the combo PHY is able to do this, and its calibration values are used
+ * for configuring all PCIe PHYs.
+ *
+ * We always need to de-assert the "global" reset on the combo PHY,
+ * because the USB driver depends on it.  If used for PCIe, that driver
+ * will (also) de-assert this, but by leaving it de-asserted for the
+ * combo PHY, the USB driver doesn't have to do this.  Note: although
+ * SpacemiT refers to this as the global reset, we name the "phy" reset.
+ *
+ * In addition, we guarantee the APP_HOLD_PHY_RESET bit is clear for the
+ * combo PHY, so the USB driver doesn't have to manage that either.  The
+ * PCIe driver is free to change this bit for normal operation.
+ *
+ * Calibration only needs to be done once.  It's possible calibration has
+ * already completed (e.g., it might have happened in the boot loader, or
+ * -EPROBE_DEFER might result in this function being called again).  So we
+ * check that early too, to avoid doing it more than once.
+ *
+ * Otherwise we temporarily power up the PHY using the PCIe app clocks
+ * and resets, wait for the hardware to indicate calibration is done,
+ * grab the value, then shut the PHY down again.
+ */
+static int k1_pcie_combo_phy_calibrate(struct k1_pcie_phy *k1_phy)
+{
+	struct reset_control_bulk_data resets[] = {
+		{ .id = "dbi", },
+		{ .id = "mstr", },
+		{ .id = "slv", },
+	};
+	struct clk_bulk_data clocks[] = {
+		{ .id = "dbi", },
+		{ .id = "mstr", },
+		{ .id = "slv", },
+	};
+	struct device *dev = k1_phy->dev;
+	struct reset_control *phy_reset;
+	int ret = 0;
+	int val;
+
+	/* Nothing to do if we already set the receiver termination value */
+	if (k1_phy_rterm_valid())
+		return 0;
+
+	/* De-assert the PHY (global) reset and leave it that way for USB */
+	phy_reset = devm_reset_control_get_exclusive_deasserted(dev, "phy");
+	if (IS_ERR(phy_reset))
+		return PTR_ERR(phy_reset);
+
+	/*
+	 * We also guarantee the APP_HOLD_PHY_RESET bit is clear.  We can
+	 * leave this bit clear even if an error happens below.
+	 */
+	regmap_assign_bits(k1_phy->pmu, PCIE_CLK_RES_CTRL,
+			   PCIE_APP_HOLD_PHY_RST, false);
+
+	/* If the calibration already completed (e.g. by U-Boot), we're done */
+	val = readl(k1_phy->regs + PCIE_RCAL_RESULT);
+	if (val & R_TUNE_DONE)
+		goto out_tune_done;
+
+	/* Put the PHY into PCIe mode */
+	k1_combo_phy_sel(k1_phy, false);
+
+	/* Get and enable the PCIe app clocks */
+	ret = clk_bulk_get(dev, ARRAY_SIZE(clocks), clocks);
+	if (ret <= 0) {
+		if (!ret)
+			ret = -ENOENT;
+		goto out_tune_done;
+	}
+	ret = clk_bulk_prepare_enable(ARRAY_SIZE(clocks), clocks);
+	if (ret)
+		goto out_put_clocks;
+
+	/* Get the PCIe application resets (not the PHY reset) */
+	ret = reset_control_bulk_get_shared(dev, ARRAY_SIZE(resets), resets);
+	if (ret)
+		goto out_disable_clocks;
+
+	/* De-assert the PCIe application resets */
+	ret = reset_control_bulk_deassert(ARRAY_SIZE(resets), resets);
+	if (ret)
+		goto out_put_resets;
+
+	/*
+	 * This is the core activity here.  Wait for the hardware to
+	 * signal that it has completed calibration/tuning.  Once it
+	 * has, the register value will contain the values we'll
+	 * use to configure PCIe PHYs.
+	 */
+	ret = readl_poll_timeout(k1_phy->regs + PCIE_RCAL_RESULT,
+				 val, val & R_TUNE_DONE,
+				 POLL_DELAY, CALIBRATION_TIMEOUT);
+
+	/* Clean up.  We're done with the resets and clocks */
+	reset_control_bulk_assert(ARRAY_SIZE(resets), resets);
+out_put_resets:
+	reset_control_bulk_put(ARRAY_SIZE(resets), resets);
+out_disable_clocks:
+	clk_bulk_disable_unprepare(ARRAY_SIZE(clocks), clocks);
+out_put_clocks:
+	clk_bulk_put_all(ARRAY_SIZE(clocks), clocks);
+out_tune_done:
+	/* If we got the value without timing out, set k1_phy_rterm */
+	if (!ret)
+		k1_phy_rterm_set(val);
+
+	return ret;
+}
+
+static struct phy *
+k1_pcie_combo_phy_xlate(struct device *dev, const struct of_phandle_args *args)
+{
+	struct k1_pcie_phy *k1_phy = dev_get_drvdata(dev);
+	u32 type;
+
+	/* The argument specifying the PHY mode is required */
+	if (args->args_count != 1)
+		return ERR_PTR(-EINVAL);
+
+	/* We only support PCIe and USB 3 mode */
+	type = args->args[0];
+	if (type != PHY_TYPE_PCIE && type != PHY_TYPE_USB3)
+		return ERR_PTR(-EINVAL);
+
+	/* This PHY can only be used once */
+	if (k1_phy->type != PHY_NONE)
+		return ERR_PTR(-EBUSY);
+
+	k1_phy->type = type;
+
+	return k1_phy->phy;
+}
+
+/* Use the maximum number of PCIe lanes unless limited by Device Tree */
+static u32 k1_pcie_num_lanes(struct k1_pcie_phy *k1_phy, bool port_a)
+{
+	struct device *dev = k1_phy->dev;
+	u32 count = 0;
+	u32 max;
+	int ret;
+
+	ret = of_property_read_u32(dev_of_node(dev), "num-lanes", &count);
+	if (count == 1)
+		return 1;
+
+	if (count == 2 && !port_a)
+		return 2;
+
+	max = port_a ? 1 : 2;
+	if (ret != -EINVAL)
+		dev_warn(dev, "bad lane count %u for port; using %u\n",
+			 count, max);
+
+	return max;
+}
+
+static int k1_pcie_combo_phy_probe(struct k1_pcie_phy *k1_phy)
+{
+	struct device *dev = k1_phy->dev;
+	struct regmap *regmap;
+	int ret;
+
+	/* Setting the PHY mode requires access to the PMU regmap */
+	regmap = syscon_regmap_lookup_by_phandle(dev_of_node(dev), SYSCON_APMU);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap), "failed to get PMU\n");
+	k1_phy->pmu = regmap;
+
+	ret = k1_pcie_combo_phy_calibrate(k1_phy);
+	if (ret)
+		return dev_err_probe(dev, ret, "calibration failed\n");
+
+	/* Needed by k1_pcie_combo_phy_xlate(), which also sets k1_phy->type */
+	dev_set_drvdata(dev, k1_phy);
+
+	return 0;
+}
+
+static int k1_pcie_phy_probe(struct platform_device *pdev)
+{
+	struct phy *(*xlate)(struct device *dev,
+			     const struct of_phandle_args *args);
+	struct device *dev = &pdev->dev;
+	struct phy_provider *provider;
+	struct k1_pcie_phy *k1_phy;
+	bool probing_port_a;
+	int ret;
+
+	xlate = of_device_get_match_data(dev);
+	probing_port_a = xlate == k1_pcie_combo_phy_xlate;
+
+	/* Only the combo PHY can calibrate, so it must probe first */
+	if (!k1_phy_rterm_valid() && !probing_port_a)
+		return -EPROBE_DEFER;
+
+	k1_phy = devm_kzalloc(dev, sizeof(*k1_phy), GFP_KERNEL);
+	if (!k1_phy)
+		return -ENOMEM;
+	k1_phy->dev = dev;
+
+	k1_phy->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(k1_phy->regs))
+		return dev_err_probe(dev, PTR_ERR(k1_phy->regs),
+				     "error mapping registers\n");
+
+	if (probing_port_a) {
+		ret = k1_pcie_combo_phy_probe(k1_phy);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "error probing combo phy\n");
+	}
+
+	k1_phy->pcie_lanes = k1_pcie_num_lanes(k1_phy, probing_port_a);
+
+	k1_phy->phy = devm_phy_create(dev, NULL, &k1_pcie_phy_ops);
+	if (IS_ERR(k1_phy->phy))
+		return dev_err_probe(dev, PTR_ERR(k1_phy->phy),
+				     "error creating phy\n");
+	phy_set_drvdata(k1_phy->phy, k1_phy);
+
+	ret = k1_pcie_phy_pll_setup(k1_phy);
+	if (ret)
+		return dev_err_probe(dev, ret, "error initializing clock\n");
+
+	provider = devm_of_phy_provider_register(dev, xlate);
+	if (IS_ERR(provider))
+		return dev_err_probe(dev, PTR_ERR(provider),
+				     "error registering provider\n");
+	return 0;
+}
+
+static const struct of_device_id k1_pcie_phy_of_match[] = {
+	{ .compatible = "spacemit,k1-combo-phy", k1_pcie_combo_phy_xlate, },
+	{ .compatible = "spacemit,k1-pcie-phy", of_phy_simple_xlate, },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, k1_pcie_phy_of_match);
+
+static struct platform_driver k1_pcie_phy_driver = {
+	.probe	= k1_pcie_phy_probe,
+	.driver = {
+		.of_match_table	= k1_pcie_phy_of_match,
+		.name = "spacemit-k1-pcie-phy",
+	}
+};
+module_platform_driver(k1_pcie_phy_driver);
+
+MODULE_DESCRIPTION("SpacemiT K1 PCIe and USB 3 PHY driver");
+MODULE_LICENSE("GPL");
-- 
2.48.1


