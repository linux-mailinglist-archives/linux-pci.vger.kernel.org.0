Return-Path: <linux-pci+bounces-33586-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A7AB1DF4B
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 00:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6EE71895A38
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 22:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B2F256C73;
	Thu,  7 Aug 2025 22:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cBlhPrF+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3529420296A
	for <linux-pci@vger.kernel.org>; Thu,  7 Aug 2025 22:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754604924; cv=none; b=MRpdgnSFtVMuokm8B0pnB1JOzVjIsy72FHt6DXd0e2vfOojjvVOGYCg0ovuWLkzAfBOPkzjBVe284nofdU3E6F23DcAcAZhrS4hVzJhkZObsAAkcm4kDqUSzeIYGz2r+qnHO5tg8o8WgCTmkZUI8WwiBFDQju2E+EBVSa/F7ft4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754604924; c=relaxed/simple;
	bh=b++w7n9UcEIF0kfuMLVTkm2T5H5oPwLC2M81iAY1xKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J5Bf7bbm6kwr/GkR0xsXWc9VdxH7julhyGbSP/B23vWBbKNpN7HUwlQBpypgHe2tu6W2MFMtHBbVpDhTAx2tVXyeHGHBDECMvOexEAX/nNoR0lbaEwTwrIlKutsTDPpdz88MELgaC1hypMgfj84aKsFE2s/FKP1JWnBzLN8hvFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cBlhPrF+; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b0ad5fa282so6583301cf.1
        for <linux-pci@vger.kernel.org>; Thu, 07 Aug 2025 15:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1754604920; x=1755209720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5jYW+PSZIquq87XIfneJCMUIneGwyGc9tsrP0Mk4ojE=;
        b=cBlhPrF+R5Qsj1OsohCOEHnzwQ8nrbmPTYfyKbpyq/LjTPyHLcVeCVfRDEovXUCDuf
         9kivD9tBaQPBCQ5leNldQb0t4QQN+M0Dzr6WzHBR/GfMoyM72UMuMRm6tVqCx20zprI8
         /NLn6KA9M6Ks3j7E/eFL2AC/RmIGPaLbPRWvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754604920; x=1755209720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5jYW+PSZIquq87XIfneJCMUIneGwyGc9tsrP0Mk4ojE=;
        b=bnAp0NI+di+awxRqBGn1BTk1BcA7FsYTNugB18TCtin/TlaEmbdtVxT2xOfTXMfvNz
         nKBb9LVHCPgm1GXXYu9G9i6md2STiEsjaV5F8F7rWMT2bcebrl/l5JkMQhte84by7Z4w
         PsPzlzW17kncNvdVwahd7zZ9y/Gakrl8xBm2XA3/82+C9WlG/SvX7DJxvQz7srTqfZmV
         3nwyJ/6HpSEpdr2M6ajQCevn+2WhoAftg4ibdP/iBmhFVpdQ9nCf3v9SsaVUzikh16BZ
         2seXiiX6eYG4gx3O4t2dvyFtLG4P9tALvpV2NNSYRFIBXOZboOkkdwjTU48lrp8ZMdGh
         J7mA==
X-Gm-Message-State: AOJu0YxtxUXgbBKCSwu75+ifuiq48yugAl1z8MQSQj5wmwo9pfgNjk/c
	CWCek1sEvhXbC3omq0CfonAYTkqELgMi/+2LS4ID32HiLAlYde0RdeGDZaRoTB/OqZaFFUvFnbf
	Ig/m701z1ZUkbc3WOdTjPHjQcaRqZcXeZhTzAMBv33SZN8AI4WFUWAwY63WSVfG9/ybD7XX9qdY
	oCwfpR08tA6YAeuSAzfDlT9/sXtZh8cmEhk2COeFLv9qrRwTo56w==
X-Gm-Gg: ASbGncvlbvl5ett+UhqnTZYVG090nPgUEjr6LD9ufed6ssSnXg57SOKB6rphOO6DdYw
	xRpDzGAj3IaEfxFQUkE9GhgvE2MZgLKqpOXGTSFT68S1+OCGsqWPIy1IVuUs4dV1WYz7QyyVPfN
	+It8bzmZT6W3IwsoWld9aTZ2rcX7pD1aXoMWp0XVDObrGsKNY+c2vZh9f8Ty6MjCLQxoqo08Vn2
	hFKmj6qSJvqvoPz8cViEK7ueY3lR0CEQz4ShauhB4MDKoUH3wBEaI92e1UgKillUPAVtbyi2V5c
	BcyoqyeLUm5FTfq0YJVqpxD6Vn2PIPD7ev/IWg5l1G+AAnmMlzKktktzI7/xu63iT/YntxCQeRD
	z9WkH+7SkLOCQ1jou92yqGmrBrcmwzzgVxyHl9QPRf15AYLOMIK/V4v5lqdrGKO3uv2hwHOjkNf
	a6aQ==
X-Google-Smtp-Source: AGHT+IEP2/GGK0JMu+NX/V1KJMI1F/LXcfkstdOsWhBZULL4vo6ZiUpJyMyYHhBerb+zc2yyI6Q32w==
X-Received: by 2002:ac8:5e4b:0:b0:4b0:7db9:92d7 with SMTP id d75a77b69052e-4b0a06eefbfmr77409541cf.2.1754604919914;
        Thu, 07 Aug 2025 15:15:19 -0700 (PDT)
Received: from stband-bld-1.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b0aa1efe78sm9527421cf.8.2025.08.07.15.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 15:15:19 -0700 (PDT)
From: Jim Quinlan <james.quinlan@broadcom.com>
To: linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	bcm-kernel-feedback-list@broadcom.com,
	jim2101024@gmail.com,
	james.quinlan@broadcom.com
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/2] PCI: brcmstb: Add panic/die handler to driver
Date: Thu,  7 Aug 2025 18:15:13 -0400
Message-Id: <20250807221513.1439407-3-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250807221513.1439407-1-james.quinlan@broadcom.com>
References: <20250807221513.1439407-1-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Whereas most PCIe HW returns 0xffffffff on illegal accesses and the like,
by default Broadcom's STB PCIe controller effects an abort.  Some SoCs --
7216 and its descendants -- have new HW that identifies error details.

This simple handler determines if the PCIe controller was the cause of the
abort and if so, prints out diagnostic info.  Unfortunately, an abort still
occurs.

Care is taken to read the error registers only when the PCIe bridge is
active and the PCIe registers are acceptable.  Otherwise, a "die" event
caused by something other than the PCIe could cause an abort if the PCIe
"die" handler tried to access registers when the bridge is off.

Example error output:
  brcm-pcie 8b20000.pcie: Error: Mem Acc: 32bit, Read, @0x38000000
  brcm-pcie 8b20000.pcie:  Type: TO=0 Abt=0 UnspReq=1 AccDsble=0 BadAddr=0

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 155 +++++++++++++++++++++++++-
 1 file changed, 154 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index ceb431a252b7..43c4ada3de07 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -14,15 +14,18 @@
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqchip/irq-msi-lib.h>
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
 #include <linux/of_platform.h>
+#include <linux/panic_notifier.h>
 #include <linux/pci.h>
 #include <linux/pci-ecam.h>
 #include <linux/printk.h>
@@ -156,6 +159,39 @@
 #define  MSI_INT_MASK_SET		0x10
 #define  MSI_INT_MASK_CLR		0x14
 
+/* Error report registers */
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
 #define  PCIE_RGR1_SW_INIT_1_PERST_MASK			0x1
 #define  PCIE_RGR1_SW_INIT_1_PERST_SHIFT		0x0
 
@@ -305,6 +341,8 @@ struct brcm_pcie {
 	struct subdev_regulators *sr;
 	bool			ep_wakeup_capable;
 	const struct pcie_cfg_data	*cfg;
+	struct notifier_block	die_notifier;
+	struct notifier_block	panic_notifier;
 	bool			bridge_on;
 	spinlock_t		bridge_lock;
 };
@@ -1730,6 +1768,115 @@ static int brcm_pcie_resume_noirq(struct device *dev)
 	return ret;
 }
 
+/* Dump out PCIe errors on die or panic */
+static int _brcm_pcie_dump_err(struct brcm_pcie *pcie,
+			       const char *type)
+{
+	void __iomem *base = pcie->base;
+	int i, is_cfg_err, is_mem_err, lanes;
+	char *width_str, *direction_str, lanes_str[9];
+	u32 info, cfg_addr, cfg_cause, mem_cause, lo, hi;
+	unsigned long flags;
+
+	spin_lock_irqsave(&pcie->bridge_lock, flags);
+	/* Don't access registers when the bridge is off */
+	if (!pcie->bridge_on || readl(base + PCIE_OUTB_ERR_VALID) == 0) {
+		spin_unlock_irqrestore(&pcie->bridge_lock, flags);
+		return NOTIFY_DONE;
+	}
+
+	/* Read all necessary registers so we can release the spinlock ASAP */
+	info = readl(base + PCIE_OUTB_ERR_ACC_INFO);
+	is_cfg_err = !!(info & PCIE_OUTB_ERR_ACC_INFO_CFG_ERR_MASK);
+	is_mem_err = !!(info & PCIE_OUTB_ERR_ACC_INFO_MEM_ERR_MASK);
+	if (is_cfg_err) {
+		cfg_addr = readl(base + PCIE_OUTB_ERR_ACC_ADDR);
+		cfg_cause = readl(base + PCIE_OUTB_ERR_CFG_CAUSE);
+	}
+	if (is_mem_err) {
+		mem_cause = readl(base + PCIE_OUTB_ERR_MEM_CAUSE);
+		lo = readl(base + PCIE_OUTB_ERR_MEM_ADDR_LO);
+		hi = readl(base + PCIE_OUTB_ERR_MEM_ADDR_HI);
+	}
+	/* We've got all of the info, clear the error */
+	writel(1, base + PCIE_OUTB_ERR_CLEAR);
+	spin_unlock_irqrestore(&pcie->bridge_lock, flags);
+
+	dev_err(pcie->dev, "handling %s error notification\n", type);
+	width_str = (info & PCIE_OUTB_ERR_ACC_INFO_TYPE_64_MASK) ? "64bit" : "32bit";
+	direction_str = (info & PCIE_OUTB_ERR_ACC_INFO_DIR_WRITE_MASK) ? "Write" : "Read";
+	lanes = FIELD_GET(PCIE_OUTB_ERR_ACC_INFO_BYTE_LANES_MASK, info);
+	for (i = 0, lanes_str[8] = 0; i < 8; i++)
+		lanes_str[i] = (lanes & (1 << i)) ? '1' : '0';
+
+	if (is_cfg_err) {
+		int bus = FIELD_GET(PCIE_OUTB_ERR_ACC_ADDR_BUS_MASK, cfg_addr);
+		int dev = FIELD_GET(PCIE_OUTB_ERR_ACC_ADDR_DEV_MASK, cfg_addr);
+		int func = FIELD_GET(PCIE_OUTB_ERR_ACC_ADDR_FUNC_MASK, cfg_addr);
+		int reg = FIELD_GET(PCIE_OUTB_ERR_ACC_ADDR_REG_MASK, cfg_addr);
+
+		dev_err(pcie->dev, "Error: CFG Acc, %s, %s, Bus=%d, Dev=%d, Fun=%d, Reg=0x%x, lanes=%s\n",
+			width_str, direction_str, bus, dev, func, reg, lanes_str);
+		dev_err(pcie->dev, " Type: TO=%d Abt=%d UnsupReq=%d AccTO=%d AccDsbld=%d Acc64bit=%d\n",
+			!!(cfg_cause & PCIE_OUTB_ERR_CFG_CAUSE_TIMEOUT_MASK),
+			!!(cfg_cause & PCIE_OUTB_ERR_CFG_CAUSE_ABORT_MASK),
+			!!(cfg_cause & PCIE_OUTB_ERR_CFG_CAUSE_UNSUPP_REQ_MASK),
+			!!(cfg_cause & PCIE_OUTB_ERR_CFG_CAUSE_ACC_TIMEOUT_MASK),
+			!!(cfg_cause & PCIE_OUTB_ERR_CFG_CAUSE_ACC_DISABLED_MASK),
+			!!(cfg_cause & PCIE_OUTB_ERR_CFG_CAUSE_ACC_64BIT__MASK));
+	}
+
+	if (is_mem_err) {
+		u64 addr = ((u64)hi << 32) | (u64)lo;
+
+		dev_err(pcie->dev, "Error: Mem Acc, %s, %s, @0x%llx, lanes=%s\n",
+			width_str, direction_str, addr, lanes_str);
+		dev_err(pcie->dev, " Type: TO=%d Abt=%d UnsupReq=%d AccDsble=%d BadAddr=%d\n",
+			!!(mem_cause & PCIE_OUTB_ERR_MEM_CAUSE_TIMEOUT_MASK),
+			!!(mem_cause & PCIE_OUTB_ERR_MEM_CAUSE_ABORT_MASK),
+			!!(mem_cause & PCIE_OUTB_ERR_MEM_CAUSE_UNSUPP_REQ_MASK),
+			!!(mem_cause & PCIE_OUTB_ERR_MEM_CAUSE_ACC_DISABLED_MASK),
+			!!(mem_cause & PCIE_OUTB_ERR_MEM_CAUSE_BAD_ADDR_MASK));
+	}
+
+	return NOTIFY_OK;
+}
+
+static int brcm_pcie_die_notify_cb(struct notifier_block *self,
+				   unsigned long v, void *p)
+{
+	struct brcm_pcie *pcie =
+		container_of(self, struct brcm_pcie, die_notifier);
+
+	return _brcm_pcie_dump_err(pcie, "Die");
+}
+
+static int brcm_pcie_panic_notify_cb(struct notifier_block *self,
+				     unsigned long v, void *p)
+{
+	struct brcm_pcie *pcie =
+		container_of(self, struct brcm_pcie, panic_notifier);
+
+	return _brcm_pcie_dump_err(pcie, "Panic");
+}
+
+static void brcm_register_die_notifiers(struct brcm_pcie *pcie)
+{
+	pcie->panic_notifier.notifier_call = brcm_pcie_panic_notify_cb;
+	atomic_notifier_chain_register(&panic_notifier_list,
+				       &pcie->panic_notifier);
+
+	pcie->die_notifier.notifier_call = brcm_pcie_die_notify_cb;
+	register_die_notifier(&pcie->die_notifier);
+}
+
+static void brcm_unregister_die_notifiers(struct brcm_pcie *pcie)
+{
+	unregister_die_notifier(&pcie->die_notifier);
+	atomic_notifier_chain_unregister(&panic_notifier_list,
+					 &pcie->panic_notifier);
+}
+
 static void __brcm_pcie_remove(struct brcm_pcie *pcie)
 {
 	brcm_msi_remove(pcie);
@@ -1748,6 +1895,9 @@ static void brcm_pcie_remove(struct platform_device *pdev)
 
 	pci_stop_root_bus(bridge->bus);
 	pci_remove_root_bus(bridge->bus);
+	if (pcie->cfg->has_err_report)
+		brcm_unregister_die_notifiers(pcie);
+
 	__brcm_pcie_remove(pcie);
 }
 
@@ -1848,6 +1998,7 @@ static const struct pcie_cfg_data bcm7216_cfg = {
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_7278,
 	.has_phy	= true,
 	.num_inbound_wins = 3,
+	.has_err_report = true,
 };
 
 static const struct pcie_cfg_data bcm7712_cfg = {
@@ -2022,8 +2173,10 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	if (pcie->cfg->has_err_report)
+	if (pcie->cfg->has_err_report) {
 		spin_lock_init(&pcie->bridge_lock);
+		brcm_register_die_notifiers(pcie);
+	}
 
 	return 0;
 
-- 
2.34.1


