Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA7636CAA4
	for <lists+linux-pci@lfdr.de>; Tue, 27 Apr 2021 19:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238790AbhD0Rwk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Apr 2021 13:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238144AbhD0Rwj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Apr 2021 13:52:39 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4312C061756;
        Tue, 27 Apr 2021 10:51:55 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id lr7so13197521pjb.2;
        Tue, 27 Apr 2021 10:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iB4Oot/0lSTvUQU4iqLoWuoZs5LYAMg1vqOt+d8WS9Y=;
        b=bZqqTgnJlQGzbai3jyFB3ehCinYQgPhAhwo1ZLmVVUr6SD0z7iakzmaZMB1JJdYyo6
         weePY+ZuTn5ZcU01JuNl677/XDFojGvffrR/qrhvSGoW2QqtCD+PcOrXxn8w/24Dq7a+
         jNFD4ch0i836/Ug6if0d4dsHPQ4pd4rsCHijf88kLCT2N/tRYuFOWPGNET3C5op3kEKf
         ZlzP996/DaMphxK2SfFuAyPsOnGNZZk1//PK7siHo2NHz22m3gMirCpVUFRcRHgAZo0G
         k/4NxBg7xb8/qaJzxQ/Vp9EDdq4fNMuPq/nHZRT/rS3/0J3nfXp0fbgppCZYrwzH70Sf
         EwXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iB4Oot/0lSTvUQU4iqLoWuoZs5LYAMg1vqOt+d8WS9Y=;
        b=TlA9DCmBdGbmY88iDNb63et1jOByppN0BAj8+FaQJKmqVzhZaCUm6E63CA5JIA1hBP
         g+vS7085TJ+7IqGthqmJuXcrEON4w+j5qJCt5g1MHrZKBIrEHt7ZWRrPKzXa00kLHPH6
         IYgF/rS+//UoWIu0vYblSQaAUKePvQb8ZHZIDs5iCZLg/9WFNCqbhCc4sMl+SH+e5Und
         YlhfMAkXyyswqRyTtFlK+2A0pIUhs6U91v/nhZKSmRdm5J3mTGoi2AH/o1N0LqqshP8q
         b0tLZyyMfPx49D7N55lL6SKKMqcqKMLdjasMhmQdcl3ScZA4NipKiPq0zcwx1LPyKauB
         /l4Q==
X-Gm-Message-State: AOAM532IkzsnNvLu61J5GtmMuMr3F7scZ8OkI+mkwFLiVZyzfG+b3BpD
        7j2fHEeT6FHU5+vwKpe63bPlcOy/Q88=
X-Google-Smtp-Source: ABdhPJzHGHFcKV8nvFEefnummSuloMSBCvVu6bgx287p5NtPcZB/6U7cngbAXxMcDWS3vRqJ1BqAeA==
X-Received: by 2002:a17:90b:1b03:: with SMTP id nu3mr6130980pjb.62.1619545914772;
        Tue, 27 Apr 2021 10:51:54 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id h21sm2456833pfo.211.2021.04.27.10.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 10:51:54 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 3/4] PCI: brcmstb: Add panic/die handler to RC driver
Date:   Tue, 27 Apr 2021 13:51:38 -0400
Message-Id: <20210427175140.17800-4-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210427175140.17800-1-jim2101024@gmail.com>
References: <20210427175140.17800-1-jim2101024@gmail.com>
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
index 3b6a62dd2e72..d3af8d84f0d6 100644
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
@@ -184,6 +186,39 @@
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
@@ -215,6 +250,7 @@ struct pcie_cfg_data {
 	const enum pcie_type type;
 	void (*perst_set)(struct brcm_pcie *pcie, u32 val);
 	void (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
+	const bool has_err_report;
 };
 
 static const int pcie_offsets[] = {
@@ -262,6 +298,7 @@ static const struct pcie_cfg_data bcm7216_cfg = {
 	.type		= BCM7278,
 	.perst_set	= brcm_pcie_perst_set_7278,
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_7278,
+	.has_err_report = true,
 };
 
 struct brcm_msi {
@@ -302,8 +339,87 @@ struct brcm_pcie {
 	u32			hw_rev;
 	void			(*perst_set)(struct brcm_pcie *pcie, u32 val);
 	void			(*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
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
 /*
  * This is to convert the size of the inbound "BAR" region to the
  * non-linear values of PCIE_X_MISC_RC_BAR[123]_CONFIG_LO.SIZE
@@ -1216,6 +1332,8 @@ static int brcm_pcie_remove(struct platform_device *pdev)
 	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
 
 	pci_stop_root_bus(bridge->bus);
+	if (pcie->has_err_report)
+		brcm_unregister_die_notifiers(pcie);
 	pci_remove_root_bus(bridge->bus);
 	__brcm_pcie_remove(pcie);
 
@@ -1255,6 +1373,7 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 	pcie->np = np;
 	pcie->reg_offsets = data->offsets;
 	pcie->type = data->type;
+	pcie->has_err_report = data->has_err_report;
 	pcie->perst_set = data->perst_set;
 	pcie->bridge_sw_init_set = data->bridge_sw_init_set;
 
@@ -1322,6 +1441,9 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pcie);
 
+	if (pcie->has_err_report)
+		brcm_register_die_notifiers(pcie);
+
 	return pci_host_probe(bridge);
 fail:
 	__brcm_pcie_remove(pcie);
-- 
2.17.1

