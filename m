Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43290436537
	for <lists+linux-pci@lfdr.de>; Thu, 21 Oct 2021 17:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhJUPMv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Oct 2021 11:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbhJUPMv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Oct 2021 11:12:51 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAC1C0613B9;
        Thu, 21 Oct 2021 08:10:35 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id u6so644742ple.2;
        Thu, 21 Oct 2021 08:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wdvW0++TQSaLpnlhn3di6k88yfCHb1cy15TmRrFrgvg=;
        b=nn6UzH9K9xm3BbgtRQT6//j7LivuHHqgkWvtklOkW7BxcAWXi6Rd3wDo0ZMLlHD6Jl
         NRcnBGrGQ1ZfkNe5rRWEQ0JQ/mM3SVw90rPXXq4UEClymVBFEo2/hYL4S72QvEomDSWW
         oliXHekIGSCz1mEQuSIzvaJAfV+o0Na3hlhpMrArEX0ePY3PIiCA/SbBbVZ8zstP05F3
         4LnrCFGoiSabuUSczr3kkL6WkQMjJsBLXxqzyEbVvTbvHul0SrcUz9JNZX9r5yxgaXVt
         1kinykOuYgmINjXMI/Rrj406Xsjo8n4/P+tO2WTw8CnQGG5HABdOrzMIIvUoSV5bwV2o
         2P/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wdvW0++TQSaLpnlhn3di6k88yfCHb1cy15TmRrFrgvg=;
        b=tt4AnwtveVE2He0KKIxyLdkp96ICMpX5b/walCD1nh6IJXHHdCfMRAOhi/WOKRUtpM
         vhAZ+1LbTwz0kz/Pe1i6cDRlLj97+hvOuxUJ6XJjX/ziQ0MZEsguK9+je9nPqTg3VKiD
         JQIJ97l4L9p1QbDW92RMaC0qfx/+26yB534RZaUvTS6aeRqmDxp27kgm1+evQGhISAcV
         l9huNl0elGQwrQOxCvAh7xeTozqefN6Y493KBYBQE48hqsaCGBt4Xm/J8TbN/oIISafK
         A7JquoKCfAhxSx8jtW7baMCbpfBv1Zgf/adNGssmB1XesDotdCm53CNYLJPMHh5+GmMq
         KVPg==
X-Gm-Message-State: AOAM531d7+0Pvnk9CmO/mFD0RLR8oYETBaQuSWVF/M7PzFv50wz/tVmC
        f9kASxoJ9S925xXUotXkeZ4=
X-Google-Smtp-Source: ABdhPJwQAqO9qqsqzDQINhSUMNkWXH1PmXLf2/63QLfNEoLTgPrpMEAnn6+IoPd3F6XdClY7Gx/RiA==
X-Received: by 2002:a17:902:6808:b0:13e:a85b:52bd with SMTP id h8-20020a170902680800b0013ea85b52bdmr5630098plk.76.1634829035035;
        Thu, 21 Oct 2021 08:10:35 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:29a4:d874:a949:6890:f95f])
        by smtp.gmail.com with ESMTPSA id c9sm5508027pgq.58.2021.10.21.08.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 08:10:34 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, Robert Richter <rric@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:PCIE DRIVER FOR
        CAVIUM THUNDERX)
Subject: [PATCH v3 05/25] PCI: thunder: Remove redundant error fabrication when device read fails
Date:   Thu, 21 Oct 2021 20:37:30 +0530
Message-Id: <823658699653e78ffe9ff856d0bff5058f5d6a8f.1634825082.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1634825082.git.naveennaidu479@gmail.com>
References: <cover.1634825082.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

An MMIO read from a PCI device that doesn't exist or doesn't respond
causes a PCI error. There's no real data to return to satisfy the
CPU read, so most hardware fabricates ~0 data.

The host controller drivers sets the error response values (~0) and
returns an error when faulty hardware read occurs. But the error
response value (~0) is already being set in PCI_OP_READ and
PCI_USER_READ_CONFIG whenever a read by host controller driver fails.

Thus, it's no longer necessary for the host controller drivers to
fabricate any error response.

This helps unify PCI error response checking and make error check
consistent and easier to find.

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/controller/pci-thunder-ecam.c | 46 ++++++++---------------
 drivers/pci/controller/pci-thunder-pem.c  |  4 +-
 2 files changed, 17 insertions(+), 33 deletions(-)

diff --git a/drivers/pci/controller/pci-thunder-ecam.c b/drivers/pci/controller/pci-thunder-ecam.c
index ffd84656544f..a95bb58afd52 100644
--- a/drivers/pci/controller/pci-thunder-ecam.c
+++ b/drivers/pci/controller/pci-thunder-ecam.c
@@ -41,10 +41,9 @@ static int handle_ea_bar(u32 e0, int bar, struct pci_bus *bus,
 	}
 	if (where_a == 0x4) {
 		addr = bus->ops->map_bus(bus, devfn, bar); /* BAR 0 */
-		if (!addr) {
-			*val = ~0;
+		if (!addr)
 			return PCIBIOS_DEVICE_NOT_FOUND;
-		}
+
 		v = readl(addr);
 		v &= ~0xf;
 		v |= 2; /* EA entry-1. Base-L */
@@ -56,10 +55,9 @@ static int handle_ea_bar(u32 e0, int bar, struct pci_bus *bus,
 		u32 barl_rb;
 
 		addr = bus->ops->map_bus(bus, devfn, bar); /* BAR 0 */
-		if (!addr) {
-			*val = ~0;
+		if (!addr)
 			return PCIBIOS_DEVICE_NOT_FOUND;
-		}
+
 		barl_orig = readl(addr + 0);
 		writel(0xffffffff, addr + 0);
 		barl_rb = readl(addr + 0);
@@ -72,10 +70,9 @@ static int handle_ea_bar(u32 e0, int bar, struct pci_bus *bus,
 	}
 	if (where_a == 0xc) {
 		addr = bus->ops->map_bus(bus, devfn, bar + 4); /* BAR 1 */
-		if (!addr) {
-			*val = ~0;
+		if (!addr)
 			return PCIBIOS_DEVICE_NOT_FOUND;
-		}
+
 		v = readl(addr); /* EA entry-3. Base-H */
 		set_val(v, where, size, val);
 		return PCIBIOS_SUCCESSFUL;
@@ -104,10 +101,8 @@ static int thunder_ecam_p2_config_read(struct pci_bus *bus, unsigned int devfn,
 	}
 
 	addr = bus->ops->map_bus(bus, devfn, where_a);
-	if (!addr) {
-		*val = ~0;
+	if (!addr)
 		return PCIBIOS_DEVICE_NOT_FOUND;
-	}
 
 	v = readl(addr);
 
@@ -135,10 +130,8 @@ static int thunder_ecam_config_read(struct pci_bus *bus, unsigned int devfn,
 	int where_a = where & ~3;
 
 	addr = bus->ops->map_bus(bus, devfn, 0xc);
-	if (!addr) {
-		*val = ~0;
+	if (!addr)
 		return PCIBIOS_DEVICE_NOT_FOUND;
-	}
 
 	v = readl(addr);
 
@@ -146,10 +139,8 @@ static int thunder_ecam_config_read(struct pci_bus *bus, unsigned int devfn,
 	cfg_type = (v >> 16) & 0x7f;
 
 	addr = bus->ops->map_bus(bus, devfn, 8);
-	if (!addr) {
-		*val = ~0;
+	if (!addr)
 		return PCIBIOS_DEVICE_NOT_FOUND;
-	}
 
 	class_rev = readl(addr);
 	if (class_rev == 0xffffffff)
@@ -176,10 +167,8 @@ static int thunder_ecam_config_read(struct pci_bus *bus, unsigned int devfn,
 	}
 
 	addr = bus->ops->map_bus(bus, devfn, 0);
-	if (!addr) {
-		*val = ~0;
+	if (!addr)
 		return PCIBIOS_DEVICE_NOT_FOUND;
-	}
 
 	vendor_device = readl(addr);
 	if (vendor_device == 0xffffffff)
@@ -196,10 +185,9 @@ static int thunder_ecam_config_read(struct pci_bus *bus, unsigned int devfn,
 		bool is_tns = (vendor_device == 0xa01f177d);
 
 		addr = bus->ops->map_bus(bus, devfn, 0x70);
-		if (!addr) {
-			*val = ~0;
+		if (!addr)
 			return PCIBIOS_DEVICE_NOT_FOUND;
-		}
+
 		/* E_CAP */
 		v = readl(addr);
 		has_msix = (v & 0xff00) != 0;
@@ -211,10 +199,9 @@ static int thunder_ecam_config_read(struct pci_bus *bus, unsigned int devfn,
 		}
 		if (where_a == 0xb0) {
 			addr = bus->ops->map_bus(bus, devfn, where_a);
-			if (!addr) {
-				*val = ~0;
+			if (!addr)
 				return PCIBIOS_DEVICE_NOT_FOUND;
-			}
+
 			v = readl(addr);
 			if (v & 0xff00)
 				pr_err("Bad MSIX cap header: %08x\n", v);
@@ -268,10 +255,9 @@ static int thunder_ecam_config_read(struct pci_bus *bus, unsigned int devfn,
 
 		if (where_a == 0x70) {
 			addr = bus->ops->map_bus(bus, devfn, where_a);
-			if (!addr) {
-				*val = ~0;
+			if (!addr)
 				return PCIBIOS_DEVICE_NOT_FOUND;
-			}
+
 			v = readl(addr);
 			if (v & 0xff00)
 				pr_err("Bad PCIe cap header: %08x\n", v);
diff --git a/drivers/pci/controller/pci-thunder-pem.c b/drivers/pci/controller/pci-thunder-pem.c
index 0660b9da204f..06a9855cb431 100644
--- a/drivers/pci/controller/pci-thunder-pem.c
+++ b/drivers/pci/controller/pci-thunder-pem.c
@@ -41,10 +41,8 @@ static int thunder_pem_bridge_read(struct pci_bus *bus, unsigned int devfn,
 	struct pci_config_window *cfg = bus->sysdata;
 	struct thunder_pem_pci *pem_pci = (struct thunder_pem_pci *)cfg->priv;
 
-	if (devfn != 0 || where >= 2048) {
-		*val = ~0;
+	if (devfn != 0 || where >= 2048)
 		return PCIBIOS_DEVICE_NOT_FOUND;
-	}
 
 	/*
 	 * 32-bit accesses only.  Write the address to the low order
-- 
2.25.1

