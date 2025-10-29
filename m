Return-Path: <linux-pci+bounces-39724-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB12C1D063
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 20:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B01E406A61
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 19:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94692359711;
	Wed, 29 Oct 2025 19:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gSE+PdzV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f225.google.com (mail-qt1-f225.google.com [209.85.160.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFE43596F6
	for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 19:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761766592; cv=none; b=e0iyNza7CvK72gjjxSoJtecqu1gNmeTlqN/1ZfWlCwvWUtEUzgNTmPSKixROIaKe+kSk5BpZoUkrODpaIIap+UEpJBsRL/K0xy+9R5DRjXyEHSevqv7gqsjAlbgkSwHJYhoTF3N8zwyPwh1NyW4lVituqZJgNbNkzzddusgcKHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761766592; c=relaxed/simple;
	bh=FWnj7yWKTeYmwhieu9s9nCgdzdSjmS2ZaFuRcyk9uxs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Di1lKy6K/zrXlxofdpctuioPE7P/7nZQ46aq9kEgRsqPeCRPdMWA+e4PIhY3ibwo35WlaPYjXaG1banM8Ph/sxeN4Ya8Jx5xukInMY9bbjGVi+aJWjEY6gDNViQsRGlRIthnewM//PWvAWpY2KgEgKT0UZBAi+BPuD355bLBzVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gSE+PdzV; arc=none smtp.client-ip=209.85.160.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f225.google.com with SMTP id d75a77b69052e-4e88ed3a132so3454081cf.0
        for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 12:36:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761766590; x=1762371390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qs94W/XWkVsQM8QXT0wY5HKWqWEfFFstbFkTTTBpc24=;
        b=lvIFF24W1muEK3TE5CQeEUwIM7elLjHfMItESHxGtRYvTM/7jb7/KPvwMLWkfwNOZu
         5Lyh6WjVuggoYqvzvozjgor+Jsi9pLH9auNBpb3HPvx5JuX3H8YmDenEtjHr80IzCfOU
         //jBPJseyaYiQQVeML1DlkQvIZmI7HZJLV86emYhEkwKphOlQl0ConOsHOGqOJPTm2uL
         Mrhq82RzA5eVEwP+RluGbqx29ysMK1EoJKxZ2E4BVus3Xelrga5ko090qjy08LlLdX8G
         37sqWrx7EeFNLv15H7zIln6bTBeOtl0IaPt/rPopDRydPvtLxLTesJeMfRJ3ifDKhaCZ
         fQtw==
X-Gm-Message-State: AOJu0YxJdwwcri2qryyarCKbiwFvNArMUDKo6fcHGjqQQ8Ce+MiT/Imj
	UPuElJeqbIKfvdBBjoCMZkEPUMRlquDta0pkR73Sy6m6Qrqrq8Gk3nfbEdpQ9lfiPjqlBlBiH/B
	5zpM4N7HIdORZ8G3yQxd7zLxTdPYto304ER5KGDy8OZ0PM38gscXdc5OANFtopg4BC9cpdkJAqu
	4vFvckA3tTfbaAckGHKht6wWTzeT1j9CP37YsYkT6T+vkVT0bfG9m7/+TG08WKn3Xr4ORmQB/WT
	H+ml2ANVrnDbsI4
X-Gm-Gg: ASbGncuj+bDugBP/L4AcJPKlDePIbqS5rJi2fBfThZ2IYTHsLAOuAQhhfs6JpWVfOEC
	+jpX1b3f0iqdri8B+EFB+j4Rq1pXXMm/zFDhyhpN8hQmQuHOEkSfv5npp8Co2PDlzu1pfTvgmeJ
	kP8NEepDPek+CLibWe66MvHxpm/RsypRzo5S5iYGN7GOOKrQUKPvSxrgWOcGXK0RVaLX75ZXE8n
	vDlIwE1sFQDpIxbRMDLpVgzIF7gsCo0oJ5/zwpfMG6N7RlSdqzoE1XcY7hDCbcB0Iw4fP0KZcSE
	Bi+FvHqnu61PEVcKoMv++tFNsCHIPxfxv5uo6cetNOktkTzIB8BrE+CLEnZHSv6utjPQ4rhJOj1
	OlcKhSYJQx4Aub4sF3pYnAh+Wib7TBNtLRoHPcdYQtmDoKf1U6tSy/2tArrnfGXiRCnqBMvqap0
	eUsziokVmw7ZVr6PVBqMLeRIf+DLR8FD9UCws=
X-Google-Smtp-Source: AGHT+IF2MmeKMfEZlXiWM0G2hBtIusqQs+8rPZgR2VRypIat67EaMUwtPDiu98ceu+69fAkgKn7lF2eoLWoK
X-Received: by 2002:ac8:580b:0:b0:4d3:7e:d6ca with SMTP id d75a77b69052e-4ed2181a01fmr11146491cf.17.1761766589562;
        Wed, 29 Oct 2025 12:36:29 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-4eba3800821sm3197651cf.5.2025.10.29.12.36.28
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Oct 2025 12:36:29 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-79e43c51e6fso167204b3a.1
        for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 12:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1761766587; x=1762371387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qs94W/XWkVsQM8QXT0wY5HKWqWEfFFstbFkTTTBpc24=;
        b=gSE+PdzVu5cA6cwDbldBlwGADWwIGBjsU0Cx8Z/qFI9nCIVurWf59m2T5IreSENTtq
         /IAVr+PDDvYM3k9Y4AFA5qBZHYia7Q9PTkxvDqXnvusxii8LWhwBazN7qHiXqeWQeLRN
         E7DgFEeHciZP/Ouw66PhWXwgS757WrAmU9WwE=
X-Received: by 2002:a05:6a00:12d0:b0:77d:98ee:e1c5 with SMTP id d2e1a72fcca58-7a615f6d321mr755398b3a.15.1761766586727;
        Wed, 29 Oct 2025 12:36:26 -0700 (PDT)
X-Received: by 2002:a05:6a00:12d0:b0:77d:98ee:e1c5 with SMTP id d2e1a72fcca58-7a615f6d321mr755353b3a.15.1761766586139;
        Wed, 29 Oct 2025 12:36:26 -0700 (PDT)
Received: from stband-bld-1.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a4140a0d47sm15895260b3a.73.2025.10.29.12.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 12:36:25 -0700 (PDT)
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
Subject: [PATCH v4 2/2] PCI: brcmstb: Add panic/die handler to driver
Date: Wed, 29 Oct 2025 15:36:15 -0400
Message-Id: <20251029193616.3670003-3-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029193616.3670003-1-james.quinlan@broadcom.com>
References: <20251029193616.3670003-1-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

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
  brcm-pcie 8b20000.pcie: Error: Mem Acc: 32bit, read, @0x38000000
  brcm-pcie 8b20000.pcie:  Type: TO=0 Abt=0 UnspReq=1 AccDsble=0 BadAddr=0

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 160 +++++++++++++++++++++++++-
 1 file changed, 158 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 9f1f746091be..67e73607f0ed 100644
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
@@ -32,6 +35,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/string.h>
+#include <linux/string_choices.h>
 #include <linux/types.h>
 
 #include "../pci.h"
@@ -156,8 +160,40 @@
 #define  MSI_INT_MASK_SET		0x10
 #define  MSI_INT_MASK_CLR		0x14
 
+/* Error report registers */
+#define PCIE_OUTB_ERR_TREAT				0x6000
+#define  PCIE_OUTB_ERR_TREAT_CONFIG		0x1
+#define  PCIE_OUTB_ERR_TREAT_MEM			0x2
+#define PCIE_OUTB_ERR_VALID				0x6004
+#define PCIE_OUTB_ERR_CLEAR				0x6008
+#define PCIE_OUTB_ERR_ACC_INFO				0x600c
+#define  PCIE_OUTB_ERR_ACC_INFO_CFG_ERR			BIT(0)
+#define  PCIE_OUTB_ERR_ACC_INFO_MEM_ERR			BIT(1)
+#define  PCIE_OUTB_ERR_ACC_INFO_TYPE_64			BIT(2)
+#define  PCIE_OUTB_ERR_ACC_INFO_DIR_WRITE		BIT(4)
+#define  PCIE_OUTB_ERR_ACC_INFO_BYTE_LANES		0xff00
+#define PCIE_OUTB_ERR_ACC_ADDR				0x6010
+#define PCIE_OUTB_ERR_ACC_ADDR_BUS			0xff00000
+#define PCIE_OUTB_ERR_ACC_ADDR_DEV			0xf8000
+#define PCIE_OUTB_ERR_ACC_ADDR_FUNC			0x7000
+#define PCIE_OUTB_ERR_ACC_ADDR_REG			0xfff
+#define PCIE_OUTB_ERR_CFG_CAUSE				0x6014
+#define  PCIE_OUTB_ERR_CFG_CAUSE_TIMEOUT		BIT(6)
+#define  PCIE_OUTB_ERR_CFG_CAUSE_ABORT			BIT(5)
+#define  PCIE_OUTB_ERR_CFG_CAUSE_UNSUPP_REQ		BIT(4)
+#define  PCIE_OUTB_ERR_CFG_CAUSE_ACC_TIMEOUT		BIT(2)
+#define  PCIE_OUTB_ERR_CFG_CAUSE_ACC_DISABLED		BIT(1)
+#define  PCIE_OUTB_ERR_CFG_CAUSE_ACC_64BIT		BIT(0)
+#define PCIE_OUTB_ERR_MEM_ADDR_LO			0x6018
+#define PCIE_OUTB_ERR_MEM_ADDR_HI			0x601c
+#define PCIE_OUTB_ERR_MEM_CAUSE				0x6020
+#define  PCIE_OUTB_ERR_MEM_CAUSE_TIMEOUT		BIT(6)
+#define  PCIE_OUTB_ERR_MEM_CAUSE_ABORT			BIT(5)
+#define  PCIE_OUTB_ERR_MEM_CAUSE_UNSUPP_REQ		BIT(4)
+#define  PCIE_OUTB_ERR_MEM_CAUSE_ACC_DISABLED		BIT(1)
+#define  PCIE_OUTB_ERR_MEM_CAUSE_BAD_ADDR		BIT(0)
+
 #define  PCIE_RGR1_SW_INIT_1_PERST_MASK			0x1
-#define  PCIE_RGR1_SW_INIT_1_PERST_SHIFT		0x0
 
 #define RGR1_SW_INIT_1_INIT_GENERIC_MASK		0x2
 #define RGR1_SW_INIT_1_INIT_GENERIC_SHIFT		0x1
@@ -306,6 +342,8 @@ struct brcm_pcie {
 	bool			ep_wakeup_capable;
 	const struct pcie_cfg_data	*cfg;
 	bool			bridge_in_reset;
+	struct notifier_block	die_notifier;
+	struct notifier_block	panic_notifier;
 	spinlock_t		bridge_lock;
 };
 
@@ -1731,6 +1769,118 @@ static int brcm_pcie_resume_noirq(struct device *dev)
 	return ret;
 }
 
+/* Dump out PCIe errors on die or panic */
+static int brcm_pcie_dump_err(struct brcm_pcie *pcie,
+			       const char *type)
+{
+	void __iomem *base = pcie->base;
+	int i, is_cfg_err, is_mem_err, lanes;
+	const char *width_str, *direction_str;
+	u32 info, cfg_addr, cfg_cause, mem_cause, lo, hi;
+	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
+	unsigned long flags;
+	char lanes_str[9];
+
+	spin_lock_irqsave(&pcie->bridge_lock, flags);
+	/* Don't access registers when the bridge is off */
+	if (pcie->bridge_in_reset || readl(base + PCIE_OUTB_ERR_VALID) == 0) {
+		spin_unlock_irqrestore(&pcie->bridge_lock, flags);
+		return NOTIFY_DONE;
+	}
+
+	/* Read all necessary registers so we can release the spinlock ASAP */
+	info = readl(base + PCIE_OUTB_ERR_ACC_INFO);
+	is_cfg_err = !!(info & PCIE_OUTB_ERR_ACC_INFO_CFG_ERR);
+	is_mem_err = !!(info & PCIE_OUTB_ERR_ACC_INFO_MEM_ERR);
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
+	dev_err(pcie->dev, "reporting PCIe info which may be related to %s error\n", type);
+	width_str = (info & PCIE_OUTB_ERR_ACC_INFO_TYPE_64) ? "64bit" : "32bit";
+	direction_str = str_read_write(!(info & PCIE_OUTB_ERR_ACC_INFO_DIR_WRITE));
+	lanes = FIELD_GET(PCIE_OUTB_ERR_ACC_INFO_BYTE_LANES, info);
+	for (i = 0, lanes_str[8] = 0; i < 8; i++)
+		lanes_str[i] = (lanes & (1 << i)) ? '1' : '0';
+
+	if (is_cfg_err) {
+		int bus = FIELD_GET(PCIE_OUTB_ERR_ACC_ADDR_BUS, cfg_addr);
+		int dev = FIELD_GET(PCIE_OUTB_ERR_ACC_ADDR_DEV, cfg_addr);
+		int func = FIELD_GET(PCIE_OUTB_ERR_ACC_ADDR_FUNC, cfg_addr);
+		int reg = FIELD_GET(PCIE_OUTB_ERR_ACC_ADDR_REG, cfg_addr);
+
+		dev_err(pcie->dev, "Error: CFG Acc, %s, %s (%04x:%02x:%02x.%d) reg=0x%x, lanes=%s\n",
+			width_str, direction_str, bridge->domain_nr, bus, dev, func,
+			reg, lanes_str);
+		dev_err(pcie->dev, " Type: TO=%d Abt=%d UnsupReq=%d AccTO=%d AccDsbld=%d Acc64bit=%d\n",
+			!!(cfg_cause & PCIE_OUTB_ERR_CFG_CAUSE_TIMEOUT),
+			!!(cfg_cause & PCIE_OUTB_ERR_CFG_CAUSE_ABORT),
+			!!(cfg_cause & PCIE_OUTB_ERR_CFG_CAUSE_UNSUPP_REQ),
+			!!(cfg_cause & PCIE_OUTB_ERR_CFG_CAUSE_ACC_TIMEOUT),
+			!!(cfg_cause & PCIE_OUTB_ERR_CFG_CAUSE_ACC_DISABLED),
+			!!(cfg_cause & PCIE_OUTB_ERR_CFG_CAUSE_ACC_64BIT));
+	}
+
+	if (is_mem_err) {
+		u64 addr = ((u64)hi << 32) | (u64)lo;
+
+		dev_err(pcie->dev, "Error: Mem Acc, %s, %s, @0x%llx, lanes=%s\n",
+			width_str, direction_str, addr, lanes_str);
+		dev_err(pcie->dev, " Type: TO=%d Abt=%d UnsupReq=%d AccDsble=%d BadAddr=%d\n",
+			!!(mem_cause & PCIE_OUTB_ERR_MEM_CAUSE_TIMEOUT),
+			!!(mem_cause & PCIE_OUTB_ERR_MEM_CAUSE_ABORT),
+			!!(mem_cause & PCIE_OUTB_ERR_MEM_CAUSE_UNSUPP_REQ),
+			!!(mem_cause & PCIE_OUTB_ERR_MEM_CAUSE_ACC_DISABLED),
+			!!(mem_cause & PCIE_OUTB_ERR_MEM_CAUSE_BAD_ADDR));
+	}
+
+	return NOTIFY_DONE;
+}
+
+static int brcm_pcie_die_notify_cb(struct notifier_block *self,
+				   unsigned long v, void *p)
+{
+	struct brcm_pcie *pcie =
+		container_of(self, struct brcm_pcie, die_notifier);
+
+	return brcm_pcie_dump_err(pcie, "Die");
+}
+
+static int brcm_pcie_panic_notify_cb(struct notifier_block *self,
+				     unsigned long v, void *p)
+{
+	struct brcm_pcie *pcie =
+		container_of(self, struct brcm_pcie, panic_notifier);
+
+	return brcm_pcie_dump_err(pcie, "Panic");
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
@@ -1749,6 +1899,9 @@ static void brcm_pcie_remove(struct platform_device *pdev)
 
 	pci_stop_root_bus(bridge->bus);
 	pci_remove_root_bus(bridge->bus);
+	if (pcie->cfg->has_err_report)
+		brcm_unregister_die_notifiers(pcie);
+
 	__brcm_pcie_remove(pcie);
 }
 
@@ -1849,6 +2002,7 @@ static const struct pcie_cfg_data bcm7216_cfg = {
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_7278,
 	.has_phy	= true,
 	.num_inbound_wins = 3,
+	.has_err_report = true,
 };
 
 static const struct pcie_cfg_data bcm7712_cfg = {
@@ -2023,8 +2177,10 @@ static int brcm_pcie_probe(struct platform_device *pdev)
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


