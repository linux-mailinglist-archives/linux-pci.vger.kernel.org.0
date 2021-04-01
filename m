Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6246F35219B
	for <lists+linux-pci@lfdr.de>; Thu,  1 Apr 2021 23:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235528AbhDAVWL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Apr 2021 17:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235480AbhDAVWI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Apr 2021 17:22:08 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57DC5C0613E6;
        Thu,  1 Apr 2021 14:22:08 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id e14so1648719plj.2;
        Thu, 01 Apr 2021 14:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9phU48RwJquj1HVaVVeNhbqrrN2jUhNbS5Biccg8yro=;
        b=mf05s/dF++HwMxbOidTLOvztf9Kpc4EiadrDa5AtEPTVx8J0angukRCUMwXd14G84t
         4xawu3d07CQrZ7qdTbZRXj2/NxPGRrRLwOOh/B+E19gy5BCRZwje0Nzjib9LnmKO2csh
         ahDdHznUPTguLAACsTUG34OMHkceHz0YjVVxUHwCG4730RPIkBbA+LB0Z/JONaCLGxQt
         vjk2FEFB7iBFpkJKl/yVV6FBsM98+3dt/HmGCFzrzu4oBz+4byk9WG7uIssc2mgTAosX
         lQ/zVx6XuzgoACZmsgwIGLcS8feinE0tdmWSR4F3vDseVAa9fLkhpAUKJXQLM8w6Dot2
         vKoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9phU48RwJquj1HVaVVeNhbqrrN2jUhNbS5Biccg8yro=;
        b=tApooJQNKmkyta5FI3NKEoWI5a4oaWlBJImHtfIPbPgraC5zRaVGbzLwXaa/aJOV6S
         /Ucqj+g5P9Pw7NYjT+CQ+brclrlR1sFKT1C79Q1i/VRrjqviVnnDbJRnF51f+acW0xui
         g5og99f91qs8Z9QUM5tPS3lVtiMLHOFhBsUtjKEtw8Si5oXWYAbCtQQtMQYWGEimZrpD
         pX84BWN45TQHlf1jhLq/rl1u2nqT5dJoIP6SGMulZmjU5+WnQxTLyPboVTuMibBUIQDj
         9Q5t23pe8Pve6LGo4dpdtLQIdbD9K1QOBK2IuRIVTUjzNunGuiFVJ/cS/Qz8eymQzjkN
         Lrgw==
X-Gm-Message-State: AOAM530IYzzjc5XC1cn1wpWri/9WIZOsj1X0rvDZUbljj3sXzQDWBIRv
        6ppR8jqK1+jhAtQ454AuxGHEntFaYC8=
X-Google-Smtp-Source: ABdhPJzUHdMagnBlhKn7JuKQcxF83/2LF3hu3PoZB4IHWdEjl6OlL4MufW0ramrPBv1MZWu4Aaswbw==
X-Received: by 2002:a17:90b:a01:: with SMTP id gg1mr10770520pjb.22.1617312127478;
        Thu, 01 Apr 2021 14:22:07 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id q5sm5926707pfk.219.2021.04.01.14.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 14:22:06 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 6/6] PCI: brcmstb: Add panic/die handler to RC driver
Date:   Thu,  1 Apr 2021 17:21:46 -0400
Message-Id: <20210401212148.47033-7-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210401212148.47033-1-jim2101024@gmail.com>
References: <20210401212148.47033-1-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Whereas most PCIe HW returns 0xffffffff on illegal accesses and the like,
by default Broadcom's STB PCIe controller effects an abort.  This simple
handler determines if the PCIe controller was the cause of the abort and if
so, prints out diagnostic info.

Example output:
  brcm-pcie 8b20000.pcie: Error: Mem Acc: 32bit, Read, @0x38000000
  brcm-pcie 8b20000.pcie:  Type: TO=0 Abt=0 UnspReq=1 AccDsble=0 BadAddr=0

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 122 ++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 44128df33785..73a12c62b94e 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -12,11 +12,13 @@
 #include <linux/ioport.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
+#include <linux/kdebug.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/log2.h>
 #include <linux/module.h>
 #include <linux/msi.h>
+#include <linux/notifier.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_pci.h>
@@ -186,6 +188,39 @@
 #define  PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_PWRDN_MASK		0x1
 #define  PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_PWRDN_SHIFT		0x0
 
+/* Error report regiseters */
+#define PCIE_OUTB_ERR_TREAT				0x6000
+#define  PCIE_OUTB_ERR_TREAT_CONFIG_MASK		0x1
+#define  PCIE_OUTB_ERR_TREAT_MEM_MASK			0x2
+#define PCIE_OUTB_ERR_VALID				0x6004
+#define PCIE_OUTB_ERR_CLEAR				0x6008
+#define PCIE_OUTB_ERR_ACC_INFO				0x600c
+#define  PCIE_OUTB_ERR_ACC_INFO_CFG_ERR_MASK		0x01
+#define  PCIE_OUTB_ERR_ACC_INFO_MEM_ERR_MASK		0x02
+#define  PCIE_OUTB_ERR_ACC_INFO_TYPE_64_MASK		0x04
+#define  PCIE_OUTB_ERR_ACC_INFO_DIR_WRITE_MASK		0x10
+#define  PCIE_OUTB_ERR_ACC_INFO_BYTE_LANES_MASK		0xff00
+#define PCIE_OUTB_ERR_ACC_ADDR				0x6010
+#define PCIE_OUTB_ERR_ACC_ADDR_BUS_MASK			0xff00000
+#define PCIE_OUTB_ERR_ACC_ADDR_DEV_MASK			0xf8000
+#define PCIE_OUTB_ERR_ACC_ADDR_FUNC_MASK		0x7000
+#define PCIE_OUTB_ERR_ACC_ADDR_REG_MASK			0xfff
+#define PCIE_OUTB_ERR_CFG_CAUSE				0x6014
+#define  PCIE_OUTB_ERR_CFG_CAUSE_TIMEOUT_MASK		0x40
+#define  PCIE_OUTB_ERR_CFG_CAUSE_ABORT_MASK		0x20
+#define  PCIE_OUTB_ERR_CFG_CAUSE_UNSUPP_REQ_MASK	0x10
+#define  PCIE_OUTB_ERR_CFG_CAUSE_ACC_TIMEOUT_MASK	0x4
+#define  PCIE_OUTB_ERR_CFG_CAUSE_ACC_DISABLED_MASK	0x2
+#define  PCIE_OUTB_ERR_CFG_CAUSE_ACC_64BIT__MASK	0x1
+#define PCIE_OUTB_ERR_MEM_ADDR_LO			0x6018
+#define PCIE_OUTB_ERR_MEM_ADDR_HI			0x601c
+#define PCIE_OUTB_ERR_MEM_CAUSE				0x6020
+#define  PCIE_OUTB_ERR_MEM_CAUSE_TIMEOUT_MASK		0x40
+#define  PCIE_OUTB_ERR_MEM_CAUSE_ABORT_MASK		0x20
+#define  PCIE_OUTB_ERR_MEM_CAUSE_UNSUPP_REQ_MASK	0x10
+#define  PCIE_OUTB_ERR_MEM_CAUSE_ACC_DISABLED_MASK	0x2
+#define  PCIE_OUTB_ERR_MEM_CAUSE_BAD_ADDR_MASK		0x1
+
 /* Forward declarations */
 struct brcm_pcie;
 static inline void brcm_pcie_bridge_sw_init_set_7278(struct brcm_pcie *pcie, u32 val);
@@ -223,6 +258,7 @@ struct pcie_cfg_data {
 	const enum pcie_type type;
 	void (*perst_set)(struct brcm_pcie *pcie, u32 val);
 	void (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
+	const bool has_err_report;
 };
 
 static const int pcie_offsets[] = {
@@ -270,6 +306,7 @@ static const struct pcie_cfg_data bcm7216_cfg = {
 	.type		= BCM7278,
 	.perst_set	= brcm_pcie_perst_set_7278,
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_7278,
+	.has_err_report = true,
 };
 
 struct brcm_msi {
@@ -313,8 +350,87 @@ struct brcm_pcie {
 	struct regulator_bulk_data supplies[PCIE_BRCM_MAX_EP_REGULATORS];
 	unsigned int		num_supplies;
 	bool			ep_wakeup_capable;
+	bool			has_err_report;
+	struct notifier_block	die_notifier;
 };
 
+/* Dump out PCIe errors on die or panic */
+static int dump_pcie_error(struct notifier_block *self, unsigned long v, void *p)
+{
+	const struct brcm_pcie *pcie = container_of(self, struct brcm_pcie, die_notifier);
+	void __iomem *base = pcie->base;
+	int i, is_cfg_err, is_mem_err, lanes;
+	char *width_str, *direction_str, lanes_str[9];
+	u32 info;
+
+	if (readl(base + PCIE_OUTB_ERR_VALID) == 0)
+		return NOTIFY_DONE;
+	info = readl(base + PCIE_OUTB_ERR_ACC_INFO);
+
+
+	is_cfg_err = !!(info & PCIE_OUTB_ERR_ACC_INFO_CFG_ERR_MASK);
+	is_mem_err = !!(info & PCIE_OUTB_ERR_ACC_INFO_MEM_ERR_MASK);
+	width_str = (info & PCIE_OUTB_ERR_ACC_INFO_TYPE_64_MASK) ? "64bit" : "32bit";
+	direction_str = (info & PCIE_OUTB_ERR_ACC_INFO_DIR_WRITE_MASK) ? "Write" : "Read";
+	lanes = FIELD_GET(PCIE_OUTB_ERR_ACC_INFO_BYTE_LANES_MASK, info);
+	for (i = 0, lanes_str[8] = 0; i < 8; i++)
+		lanes_str[i] = (lanes & (1 << i)) ? '1' : '0';
+
+	if (is_cfg_err) {
+		u32 cfg_addr = readl(base + PCIE_OUTB_ERR_ACC_ADDR);
+		u32 cause = readl(base + PCIE_OUTB_ERR_CFG_CAUSE);
+		int bus = FIELD_GET(PCIE_OUTB_ERR_ACC_ADDR_BUS_MASK, cfg_addr);
+		int dev = FIELD_GET(PCIE_OUTB_ERR_ACC_ADDR_DEV_MASK, cfg_addr);
+		int func = FIELD_GET(PCIE_OUTB_ERR_ACC_ADDR_FUNC_MASK, cfg_addr);
+		int reg = FIELD_GET(PCIE_OUTB_ERR_ACC_ADDR_REG_MASK, cfg_addr);
+
+		dev_err(pcie->dev, "Error: CFG Acc, %s, %s, Bus=%d, Dev=%d, Fun=%d, Reg=0x%x, lanes=%s\n",
+			width_str, direction_str, bus, dev, func, reg, lanes_str);
+		dev_err(pcie->dev, " Type: TO=%d Abt=%d UnsupReq=%d AccTO=%d AccDsbld=%d Acc64bit=%d\n",
+			!!(cause & PCIE_OUTB_ERR_CFG_CAUSE_TIMEOUT_MASK),
+			!!(cause & PCIE_OUTB_ERR_CFG_CAUSE_ABORT_MASK),
+			!!(cause & PCIE_OUTB_ERR_CFG_CAUSE_UNSUPP_REQ_MASK),
+			!!(cause & PCIE_OUTB_ERR_CFG_CAUSE_ACC_TIMEOUT_MASK),
+			!!(cause & PCIE_OUTB_ERR_CFG_CAUSE_ACC_DISABLED_MASK),
+			!!(cause & PCIE_OUTB_ERR_CFG_CAUSE_ACC_64BIT__MASK));
+	}
+
+	if (is_mem_err) {
+		u32 cause = readl(base + PCIE_OUTB_ERR_MEM_CAUSE);
+		u32 lo = readl(base + PCIE_OUTB_ERR_MEM_ADDR_LO);
+		u32 hi = readl(base + PCIE_OUTB_ERR_MEM_ADDR_HI);
+		u64 addr = ((u64)hi << 32) | (u64)lo;
+
+		dev_err(pcie->dev, "Error: Mem Acc, %s, %s, @0x%llx, lanes=%s\n",
+			width_str, direction_str, addr, lanes_str);
+		dev_err(pcie->dev, " Type: TO=%d Abt=%d UnsupReq=%d AccDsble=%d BadAddr=%d\n",
+			!!(cause & PCIE_OUTB_ERR_MEM_CAUSE_TIMEOUT_MASK),
+			!!(cause & PCIE_OUTB_ERR_MEM_CAUSE_ABORT_MASK),
+			!!(cause & PCIE_OUTB_ERR_MEM_CAUSE_UNSUPP_REQ_MASK),
+			!!(cause & PCIE_OUTB_ERR_MEM_CAUSE_ACC_DISABLED_MASK),
+			!!(cause & PCIE_OUTB_ERR_MEM_CAUSE_BAD_ADDR_MASK));
+	}
+
+	/* Clear the error */
+	writel(1, base + PCIE_OUTB_ERR_CLEAR);
+
+	return NOTIFY_DONE;
+}
+
+static void brcm_register_die_notifiers(struct brcm_pcie *pcie)
+{
+	pcie->die_notifier.notifier_call = dump_pcie_error;
+	register_die_notifier(&pcie->die_notifier);
+	atomic_notifier_chain_register(&panic_notifier_list, &pcie->die_notifier);
+}
+
+static void brcm_unregister_die_notifiers(struct brcm_pcie *pcie)
+{
+	unregister_die_notifier(&pcie->die_notifier);
+	atomic_notifier_chain_unregister(&panic_notifier_list, &pcie->die_notifier);
+	pcie->die_notifier.notifier_call = NULL;
+}
+
 static int pci_dev_may_wakeup(struct pci_dev *dev, void *data)
 {
 	bool *ret = data;
@@ -1321,6 +1437,8 @@ static int brcm_pcie_remove(struct platform_device *pdev)
 	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
 
 	pci_stop_root_bus(bridge->bus);
+	if (pcie->has_err_report)
+		brcm_unregister_die_notifiers(pcie);
 	pci_remove_root_bus(bridge->bus);
 	__brcm_pcie_remove(pcie);
 
@@ -1360,6 +1478,7 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 	pcie->np = np;
 	pcie->reg_offsets = data->offsets;
 	pcie->type = data->type;
+	pcie->has_err_report = data->has_err_report;
 	pcie->perst_set = data->perst_set;
 	pcie->bridge_sw_init_set = data->bridge_sw_init_set;
 
@@ -1439,6 +1558,9 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pcie);
 
+	if (pcie->has_err_report)
+		brcm_register_die_notifiers(pcie);
+
 	return pci_host_probe(bridge);
 fail:
 	__brcm_pcie_remove(pcie);
-- 
2.17.1

