Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C035F45FF22
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 15:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343515AbhK0OTz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Nov 2021 09:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbhK0ORy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Nov 2021 09:17:54 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA5EC0613F7
        for <linux-pci@vger.kernel.org>; Sat, 27 Nov 2021 06:11:45 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id i5so25195880wrb.2
        for <linux-pci@vger.kernel.org>; Sat, 27 Nov 2021 06:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zh+NOZs5/REqQNlTOGbjtnd3sstlb1c/9N9L5Mvs0xo=;
        b=iSa7TymEbRIAY/nBTYcK8bfUodICSovbII7PFzhJYFFwP8GyStW8H4dd5ZTTJQjZu5
         h+U09OStS2PgXmgirf8pHQ1MnSYpcjI29CErUqEFWS7N24SafCn3s5lD8lwugywZC8Lf
         P5ET3U/DxqV72RlLmgmkLVWwvhSGweVZ8ZBjhzrRe4q87tHfUAAN/KvZfjzmUiyFJwq2
         nn8Fj982yXcXDYUNf7A8lh2N5u+3jZLdjT00HayfyfnW0F4fT0dvVMZaiL6tkXuY30Ak
         9kL8xkT0B6SmkGFuNEqwG4TM2twrtsyqERnpGorp+IslxzGTqnHGgyfA5QLJ/Jwu/Ep2
         NUtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zh+NOZs5/REqQNlTOGbjtnd3sstlb1c/9N9L5Mvs0xo=;
        b=EE1k/5mpH9o6gpZqIx4jPFAWCKVVwvKv25KZzO4zrEtHVwpxDGdHO3K3CgfXjUA6n6
         QE58/J1okjP/79vTXWT1uap7bf5alRzfI06qEp62jBme60OK/z8jj5O41XLN+pO9Nvbk
         NDUoNLVyUXSrQAGtIsqP8E1Apw9NoFZUvwmjAPkME7XZ2wvMlDPgV/37/p3ex3kBy9ZS
         CUTiB/v3Q1DOY6Etmcpyr7GxWqH2BfDDYz0ovfIvwBPrfLTuPcF2+FfP720Ikbdu3eEe
         +aP808/MI0BHdiYBzntC8SO75U6tOmDDK+Y8SWQB/aN2Lqg9taiIaBwwt4bnlcczsIOJ
         c1iw==
X-Gm-Message-State: AOAM531Y62a39nzJW8Tru8Hufo6ycAtZyfUsaVK9mwhY7FVh6AiE+yZy
        Ch6eLJXEMOlVPizeEN9rtFHTi+O91e3rHw==
X-Google-Smtp-Source: ABdhPJwqTih8JFgAuF4pPRTH0BuNxSICRA5Stm/yqahpvLln2bIN8GHY5w+jy/XbE0i1wf9dDZ7A/g==
X-Received: by 2002:adf:eb05:: with SMTP id s5mr19852681wrn.448.1638022304220;
        Sat, 27 Nov 2021 06:11:44 -0800 (PST)
Received: from claire-ThinkPad-T470.localdomain (dynamic-2a01-0c22-7349-1000-d163-c2fa-698a-934f.c22.pool.telefonica.de. [2a01:c22:7349:1000:d163:c2fa:698a:934f])
        by smtp.gmail.com with ESMTPSA id q26sm8754522wrc.39.2021.11.27.06.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Nov 2021 06:11:43 -0800 (PST)
From:   Fan Fei <ffclaire1224@gmail.com>
To:     bjorn@helgaas.com
Cc:     Fan Fei <ffclaire1224@gmail.com>, linux-pci@vger.kernel.org
Subject: [PATCH 11/13] PCI: ixp4xx: Replace device * with platform_device *
Date:   Sat, 27 Nov 2021 15:11:19 +0100
Message-Id: <bedef09f8c041caebdc779d59b176bad197cd39b.1638022049.git.ffclaire1224@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1638022048.git.ffclaire1224@gmail.com>
References: <cover.1638022048.git.ffclaire1224@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some PCI controller struct contain "device *", while others contain
"platform_device *". Unify "device *dev" to "platform_device *pdev" in
struct ixp4xx_pci, because PCI controllers interact with platform_device
directly, not device, to enumerate the controlled device.

Signed-off-by: Fan Fei <ffclaire1224@gmail.com>
---
 drivers/pci/controller/pci-ixp4xx.c | 47 ++++++++++++++++-------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/controller/pci-ixp4xx.c b/drivers/pci/controller/pci-ixp4xx.c
index 654ac4a82beb..13e8a4754f5b 100644
--- a/drivers/pci/controller/pci-ixp4xx.c
+++ b/drivers/pci/controller/pci-ixp4xx.c
@@ -101,7 +101,7 @@
 #define IXP4XX_PCI_RTOTTO		0x40
 
 struct ixp4xx_pci {
-	struct device *dev;
+	struct platform_device *pdev;
 	void __iomem *base;
 	bool errata_hammer;
 	bool host_mode;
@@ -138,7 +138,7 @@ static int ixp4xx_pci_check_master_abort(struct ixp4xx_pci *p)
 	if (isr & IXP4XX_PCI_ISR_PFE) {
 		/* Make sure the master abort bit is reset */
 		ixp4xx_writel(p, IXP4XX_PCI_ISR, IXP4XX_PCI_ISR_PFE);
-		dev_dbg(p->dev, "master abort detected\n");
+		dev_dbg(&p->pdev->dev, "master abort detected\n");
 		return -EINVAL;
 	}
 
@@ -216,12 +216,13 @@ static u32 ixp4xx_crp_byte_lane_enable_bits(u32 n, int size)
 static int ixp4xx_crp_read_config(struct ixp4xx_pci *p, int where, int size,
 				  u32 *value)
 {
+	struct device *dev = &p->pdev->dev;
 	u32 n, cmd, val;
 
 	n = where % 4;
 	cmd = where & ~3;
 
-	dev_dbg(p->dev, "%s from %d size %d cmd %08x\n",
+	dev_dbg(dev, "%s from %d size %d cmd %08x\n",
 		__func__, where, size, cmd);
 
 	ixp4xx_writel(p, IXP4XX_PCI_CRP_AD_CBE, cmd);
@@ -231,19 +232,19 @@ static int ixp4xx_crp_read_config(struct ixp4xx_pci *p, int where, int size,
 	switch (size) {
 	case 1:
 		val &= U8_MAX;
-		dev_dbg(p->dev, "%s read byte %02x\n", __func__, val);
+		dev_dbg(dev, "%s read byte %02x\n", __func__, val);
 		break;
 	case 2:
 		val &= U16_MAX;
-		dev_dbg(p->dev, "%s read word %04x\n", __func__, val);
+		dev_dbg(dev, "%s read word %04x\n", __func__, val);
 		break;
 	case 4:
 		val &= U32_MAX;
-		dev_dbg(p->dev, "%s read long %08x\n", __func__, val);
+		dev_dbg(dev, "%s read long %08x\n", __func__, val);
 		break;
 	default:
 		/* Should not happen */
-		dev_err(p->dev, "%s illegal size\n", __func__);
+		dev_err(dev, "%s illegal size\n", __func__);
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
 	*value = val;
@@ -254,6 +255,7 @@ static int ixp4xx_crp_read_config(struct ixp4xx_pci *p, int where, int size,
 static int ixp4xx_crp_write_config(struct ixp4xx_pci *p, int where, int size,
 				   u32 value)
 {
+	struct device *dev = &p->pdev->dev;
 	u32 n, cmd, val;
 
 	n = where % 4;
@@ -265,7 +267,7 @@ static int ixp4xx_crp_write_config(struct ixp4xx_pci *p, int where, int size,
 
 	val = value << (8*n);
 
-	dev_dbg(p->dev, "%s to %d size %d cmd %08x val %08x\n",
+	dev_dbg(dev, "%s to %d size %d cmd %08x val %08x\n",
 		__func__, where, size, cmd, val);
 
 	ixp4xx_writel(p, IXP4XX_PCI_CRP_AD_CBE, cmd);
@@ -293,6 +295,7 @@ static int ixp4xx_pci_read_config(struct pci_bus *bus, unsigned int devfn,
 				  int where, int size, u32 *value)
 {
 	struct ixp4xx_pci *p = bus->sysdata;
+	struct device *dev = &p->pdev->dev;
 	u32 n, addr, val, cmd;
 	u8 bus_num = bus->number;
 	int ret;
@@ -305,7 +308,7 @@ static int ixp4xx_pci_read_config(struct pci_bus *bus, unsigned int devfn,
 
 	addr = ixp4xx_config_addr(bus_num, devfn, where);
 	cmd |= NP_CMD_CONFIGREAD;
-	dev_dbg(p->dev, "read_config from %d size %d dev %d:%d:%d address: %08x cmd: %08x\n",
+	dev_dbg(dev, "read_config from %d size %d dev %d:%d:%d address: %08x cmd: %08x\n",
 		where, size, bus_num, PCI_SLOT(devfn), PCI_FUNC(devfn), addr, cmd);
 
 	ret = ixp4xx_pci_read_indirect(p, addr, cmd, &val);
@@ -316,19 +319,19 @@ static int ixp4xx_pci_read_config(struct pci_bus *bus, unsigned int devfn,
 	switch (size) {
 	case 1:
 		val &= U8_MAX;
-		dev_dbg(p->dev, "%s read byte %02x\n", __func__, val);
+		dev_dbg(dev, "%s read byte %02x\n", __func__, val);
 		break;
 	case 2:
 		val &= U16_MAX;
-		dev_dbg(p->dev, "%s read word %04x\n", __func__, val);
+		dev_dbg(dev, "%s read word %04x\n", __func__, val);
 		break;
 	case 4:
 		val &= U32_MAX;
-		dev_dbg(p->dev, "%s read long %08x\n", __func__, val);
+		dev_dbg(dev, "%s read long %08x\n", __func__, val);
 		break;
 	default:
 		/* Should not happen */
-		dev_err(p->dev, "%s illegal size\n", __func__);
+		dev_err(dev, "%s illegal size\n", __func__);
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
 	*value = val;
@@ -340,6 +343,7 @@ static int ixp4xx_pci_write_config(struct pci_bus *bus,  unsigned int devfn,
 				   int where, int size, u32 value)
 {
 	struct ixp4xx_pci *p = bus->sysdata;
+	struct device *dev = &p->pdev->dev;
 	u32 n, addr, val, cmd;
 	u8 bus_num = bus->number;
 	int ret;
@@ -353,7 +357,7 @@ static int ixp4xx_pci_write_config(struct pci_bus *bus,  unsigned int devfn,
 	cmd |= NP_CMD_CONFIGWRITE;
 	val = value << (8*n);
 
-	dev_dbg(p->dev, "write_config_byte %#x to %d size %d dev %d:%d:%d addr: %08x cmd %08x\n",
+	dev_dbg(dev, "write_config_byte %#x to %d size %d dev %d:%d:%d addr: %08x cmd %08x\n",
 		value, where, size, bus_num, PCI_SLOT(devfn), PCI_FUNC(devfn), addr, cmd);
 
 	ret = ixp4xx_pci_write_indirect(p, addr, cmd, val);
@@ -379,7 +383,7 @@ static u32 ixp4xx_pci_addr_to_64mconf(phys_addr_t addr)
 
 static int ixp4xx_pci_parse_map_ranges(struct ixp4xx_pci *p)
 {
-	struct device *dev = p->dev;
+	struct device *dev = &p->pdev->dev;
 	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(p);
 	struct resource_entry *win;
 	struct resource *res;
@@ -437,7 +441,7 @@ static int ixp4xx_pci_parse_map_ranges(struct ixp4xx_pci *p)
 
 static int ixp4xx_pci_parse_map_dma_ranges(struct ixp4xx_pci *p)
 {
-	struct device *dev = p->dev;
+	struct device *dev = &p->pdev->dev;
 	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(p);
 	struct resource_entry *win;
 	struct resource *res;
@@ -476,17 +480,18 @@ static int ixp4xx_pci_abort_handler(unsigned long addr, unsigned int fsr,
 				    struct pt_regs *regs)
 {
 	struct ixp4xx_pci *p = ixp4xx_pci_abort_singleton;
+	struct device *dev = &p->pdev->dev;
 	u32 isr, status;
 	int ret;
 
 	isr = ixp4xx_readl(p, IXP4XX_PCI_ISR);
 	ret = ixp4xx_crp_read_config(p, PCI_STATUS, 2, &status);
 	if (ret) {
-		dev_err(p->dev, "unable to read abort status\n");
+		dev_err(dev, "unable to read abort status\n");
 		return -EINVAL;
 	}
 
-	dev_err(p->dev,
+	dev_err(dev,
 		"PCI: abort_handler addr = %#lx, isr = %#x, status = %#x\n",
 		addr, isr, status);
 
@@ -495,14 +500,14 @@ static int ixp4xx_pci_abort_handler(unsigned long addr, unsigned int fsr,
 	status |= PCI_STATUS_REC_MASTER_ABORT;
 	ret = ixp4xx_crp_write_config(p, PCI_STATUS, 2, status);
 	if (ret)
-		dev_err(p->dev, "unable to clear abort status bit\n");
+		dev_err(dev, "unable to clear abort status bit\n");
 
 	/*
 	 * If it was an imprecise abort, then we need to correct the
 	 * return address to be _after_ the instruction.
 	 */
 	if (fsr & (1 << 10)) {
-		dev_err(p->dev, "imprecise abort\n");
+		dev_err(dev, "imprecise abort\n");
 		regs->ARM_pc += 4;
 	}
 
@@ -533,7 +538,7 @@ static int __init ixp4xx_pci_probe(struct platform_device *pdev)
 	host->ops = &ixp4xx_pci_ops;
 	p = pci_host_bridge_priv(host);
 	host->sysdata = p;
-	p->dev = dev;
+	p->pdev = pdev;
 	dev_set_drvdata(dev, p);
 
 	/*
-- 
2.25.1

