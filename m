Return-Path: <linux-pci+bounces-37571-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6D7BB8045
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 21:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAF0A4A73B0
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 19:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E4B238172;
	Fri,  3 Oct 2025 19:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Aq5Nwu88"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com [209.85.219.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E0422B8BD
	for <linux-pci@vger.kernel.org>; Fri,  3 Oct 2025 19:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759521383; cv=none; b=tzgjymoLtMVX/DUeVSFJPFPL0MDIXqJ0/8EdJu7QXX0v/qrrrx1pV7m+22I13T00iM0q9Bn6Veu80EDGisNC0LSA5UP51FD2vNkmgSEyOMPJCwu06uoXSmxRuSygDa4Vb52JqNz/iCCtzO91M4Ucn7vEQ/JmEtDJwl974Mtlzms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759521383; c=relaxed/simple;
	bh=c4MZfZNVvxGqziEBBKMW4qFSI268GYWYGVGAoh1WgNc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KHx4E/cjGUS/T7ThaRVq0dFaUZXGzyHXudF+G6dddV876Y1izpANNyJW659yCAfUwvjGUp/1K46cl7banHxunLfVuUlt6uJ0s8lmhSZDKiJvLUe2o747E9JskT6wyR7+goYwZ2ZjYsIhbc3qgGxC6KpFRICSjjtR87eFEIPgsDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Aq5Nwu88; arc=none smtp.client-ip=209.85.219.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f97.google.com with SMTP id 6a1803df08f44-7960d69f14bso16374666d6.2
        for <linux-pci@vger.kernel.org>; Fri, 03 Oct 2025 12:56:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759521380; x=1760126180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8l4grpSFSjWNM4iqEUy0sH3xfwBR0H8/rIl0Jd6fkMU=;
        b=HfNnbDT9dU/R51PzbySFdMjfVbmJQwHzCj7wHUR31t/eAfGvxKONx7e7aksVe3+J2u
         Yz6mTZaJt5e2bCl9jFYAMxdbsQDqolJzP7mLmISoQTbmlK+Ds5HyM7GHddoYPJ4DDx81
         KlFu0cAzgiWVb1vBqdSj7uIyfkVF3qlAHZNm+7QFyb8DjaqkYKCoYaF9epPF6Uc3Ze+o
         djYdAeDzKRnRc8cZwiHWC2tQN7U1yB0zKEy9B94MCXVsHxaq4mPm4b1TOVqnGEk+Tsr5
         LMQj2HNSiIQ31DqFsGW9g50XrMs9fPlqxwLSK08W8ZG/fzVDUad/WHetjHsZ/2l1lDSI
         AAHg==
X-Gm-Message-State: AOJu0Yyhh+h67zEMLFxrYAMnucSj5o8xYRighlyH6L+LV0loSdgm2QWy
	Pf0Uje9UPXsT+zj8mlvLRFpGsQMhsEQvNsm7ukC9kj0FRT/H1JPv1q8Cv391vwZL8x7yXfwXVM2
	fwpY799uL3Iwsha5+Ywrp/fy3EDQT5SazFjg6QBo5CxqDrH34iiJNU/nDYFrN0LEpowguU6iZ9u
	B4wbLmzUmKb95h1E7csK2z2nywoIvCi0xNOmFDYJvlrvLAVEFaWhK2kTrBShnyv1H6iomUbvuAq
	CSCdkmCtFi+vN0G
X-Gm-Gg: ASbGnctA6+Kdugor9mx4F33Wx42jUJxDavVrl/vt6efQ2bbRXXk92mvxxkQiMykYNYW
	xwUmOO6MLYlhyuCT/j7NSeJteP4SshKyb2/Xrg43myiN28BGy92rBgF47PHXq8VYJzkQlvZybQs
	uLThgWDlnMppMsSazU3zxk15epftBbqIXfJekProKdaDDoYTgUNsOrcByAA4nghRghkU7+9nEvj
	mj8uHT/XGQiupKU5mxjTPHQXMj2dhBM6lY0msY1MyFIRgf3RTOEayFasWO2zFzhC9TKCSYDHgTy
	ptkmSJYmpnZem7gbQffUcTlMqN5W+J1maVxCLnnaoMmwqo79uum38PnkfWkCbqIhuW2/khtlYcN
	GzkXYG1XnDCSoGHzGqMSqzIWk+FrlyejM5cXG6bgZ4FhoPtx1K+QeyjMvOT+X9x+Vxy35aqPxKg
	El3H7JhuIg
X-Google-Smtp-Source: AGHT+IF+EZeJKj9fV1gzMRDhw9MfBsCrRI0GNKJxueQmffyar/ZBMZRnqbVa7Ety4SzRDk06zRf2YkafJfHl
X-Received: by 2002:a05:6214:124f:b0:795:67ac:c4c7 with SMTP id 6a1803df08f44-879dc7ae350mr60027176d6.12.1759521380019;
        Fri, 03 Oct 2025 12:56:20 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-126.dlp.protect.broadcom.com. [144.49.247.126])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-878bac6bb31sm4259496d6.7.2025.10.03.12.56.19
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Oct 2025 12:56:20 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b59682541d5so4151865a12.0
        for <linux-pci@vger.kernel.org>; Fri, 03 Oct 2025 12:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1759521378; x=1760126178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8l4grpSFSjWNM4iqEUy0sH3xfwBR0H8/rIl0Jd6fkMU=;
        b=Aq5Nwu88HyZkCSFDF5PDKD+6d5Z10kFWBF/3Esi1wqsf3DwY+XhysVQ/9sTLP9kjxf
         8blCeqE1exd3c4SKhDRx+/7DQpKMq2G+YQCcx9YeGuxh8dM5HcBfSv56AwII3n3ghAcF
         xxeJtW259gueFbjcVEXRmabMHPWTtrewhq7sQ=
X-Received: by 2002:a05:6a20:9154:b0:301:5784:8cf3 with SMTP id adf61e73a8af0-32b620d6861mr5267934637.49.1759521378253;
        Fri, 03 Oct 2025 12:56:18 -0700 (PDT)
X-Received: by 2002:a05:6a20:9154:b0:301:5784:8cf3 with SMTP id adf61e73a8af0-32b620d6861mr5267896637.49.1759521377723;
        Fri, 03 Oct 2025 12:56:17 -0700 (PDT)
Received: from stband-bld-1.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099add13esm5371162a12.8.2025.10.03.12.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 12:56:17 -0700 (PDT)
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
Subject: [PATCH v3 2/2] PCI: brcmstb: Add panic/die handler to driver
Date: Fri,  3 Oct 2025 15:56:07 -0400
Message-Id: <20251003195607.2009785-3-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251003195607.2009785-1-james.quinlan@broadcom.com>
References: <20251003195607.2009785-1-james.quinlan@broadcom.com>
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
  brcm-pcie 8b20000.pcie: Error: Mem Acc: 32bit, Read, @0x38000000
  brcm-pcie 8b20000.pcie:  Type: TO=0 Abt=0 UnspReq=1 AccDsble=0 BadAddr=0

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 155 +++++++++++++++++++++++++-
 1 file changed, 154 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 9f1f746091be..326155c9ce52 100644
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
 
@@ -306,6 +342,8 @@ struct brcm_pcie {
 	bool			ep_wakeup_capable;
 	const struct pcie_cfg_data	*cfg;
 	bool			bridge_in_reset;
+	struct notifier_block	die_notifier;
+	struct notifier_block	panic_notifier;
 	spinlock_t		bridge_lock;
 };
 
@@ -1731,6 +1769,115 @@ static int brcm_pcie_resume_noirq(struct device *dev)
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
+	if (pcie->bridge_in_reset || readl(base + PCIE_OUTB_ERR_VALID) == 0) {
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
+	dev_err(pcie->dev, "reporting data on PCIe %s error\n", type);
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
@@ -1749,6 +1896,9 @@ static void brcm_pcie_remove(struct platform_device *pdev)
 
 	pci_stop_root_bus(bridge->bus);
 	pci_remove_root_bus(bridge->bus);
+	if (pcie->cfg->has_err_report)
+		brcm_unregister_die_notifiers(pcie);
+
 	__brcm_pcie_remove(pcie);
 }
 
@@ -1849,6 +1999,7 @@ static const struct pcie_cfg_data bcm7216_cfg = {
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_7278,
 	.has_phy	= true,
 	.num_inbound_wins = 3,
+	.has_err_report = true,
 };
 
 static const struct pcie_cfg_data bcm7712_cfg = {
@@ -2023,8 +2174,10 @@ static int brcm_pcie_probe(struct platform_device *pdev)
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


