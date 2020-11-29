Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D18E2C7BE8
	for <lists+linux-pci@lfdr.de>; Mon, 30 Nov 2020 00:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbgK2XId (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 29 Nov 2020 18:08:33 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44538 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbgK2XId (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 29 Nov 2020 18:08:33 -0500
Received: by mail-wr1-f68.google.com with SMTP id 64so13064696wra.11
        for <linux-pci@vger.kernel.org>; Sun, 29 Nov 2020 15:08:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w7DrLBT8KBYKfbvtR7994XDirbE4jnXzlQLSoJlL9lc=;
        b=Z14E7mDO1eaRmbZRdiA2D93K66tckvBISHxzDbVb6Z/uL59Ueb+JqDs47RIkbng6Tq
         MLSoR8ZiCX505+I1qvKSK+czeLoK3nUQg/xeagijmEF//SuVyRmYIdCajQQqwwB1fs1/
         aB8nxWwzoPsArDFoNIDhC2newJjn/VHM8rGhrCRbAI4oneCzWDl8y4P/JsCaYDgK+ejs
         GxHt7LZ1e4z4GndWNKipwVIE6r53PJQMlUtimDL1PfnPoT4/ABPpeZaqzUPq+ZlX9yfc
         1XP+07+Wmy6SxJT6DLEId5Ta3oNO8JT7l3TG0XXy7rQpTccNNEvpPSnN3LVoUJLjM8Vy
         Yf4w==
X-Gm-Message-State: AOAM530+Ud6ySUKsS0FLTcNTDwvFQTzYHDpFZUQ9buGcSc1qqPEzTWYB
        TKFQE+5X1qfZccoBJZ9EP74=
X-Google-Smtp-Source: ABdhPJwdjGj7iDsGU1B5WR1LxkaOGB+ic6Eu0jtLWAlHXS2/EdXYuqT/jY33YywMRM935NcuXWVL6A==
X-Received: by 2002:a5d:65ca:: with SMTP id e10mr24605112wrw.42.1606691270924;
        Sun, 29 Nov 2020 15:07:50 -0800 (PST)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id d2sm24831005wrn.43.2020.11.29.15.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 15:07:50 -0800 (PST)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Rob Herring <robh@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Will Deacon <will@kernel.org>,
        Robert Richter <rrichter@marvell.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Toan Le <toan@os.amperecomputing.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-rockchip@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH v6 3/5] PCI: iproc: Convert to use the new ECAM constants
Date:   Sun, 29 Nov 2020 23:07:41 +0000
Message-Id: <20201129230743.3006978-4-kw@linux.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201129230743.3006978-1-kw@linux.com>
References: <20201129230743.3006978-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Change interface of the function iproc_pcie_map_ep_cfg_reg() so that use
of PCI_SLOT() and PCI_FUNC() macros and most of the local ECAM-specific
constants can be dropped, and the new PCIE_ECAM_OFFSET() macro can be
used instead.  Use the ALIGN_DOWN() macro to ensure that PCI Express
ECAM offset is always 32 bit aligned.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/controller/pcie-iproc.c | 31 ++++++++---------------------
 1 file changed, 8 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
index 905e93808243..503662380ff8 100644
--- a/drivers/pci/controller/pcie-iproc.c
+++ b/drivers/pci/controller/pcie-iproc.c
@@ -6,6 +6,7 @@
 
 #include <linux/kernel.h>
 #include <linux/pci.h>
+#include <linux/pci-ecam.h>
 #include <linux/msi.h>
 #include <linux/clk.h>
 #include <linux/module.h>
@@ -39,16 +40,8 @@
 
 #define CFG_IND_ADDR_MASK		0x00001ffc
 
-#define CFG_ADDR_BUS_NUM_SHIFT		20
-#define CFG_ADDR_BUS_NUM_MASK		0x0ff00000
-#define CFG_ADDR_DEV_NUM_SHIFT		15
-#define CFG_ADDR_DEV_NUM_MASK		0x000f8000
-#define CFG_ADDR_FUNC_NUM_SHIFT		12
-#define CFG_ADDR_FUNC_NUM_MASK		0x00007000
-#define CFG_ADDR_REG_NUM_SHIFT		2
 #define CFG_ADDR_REG_NUM_MASK		0x00000ffc
-#define CFG_ADDR_CFG_TYPE_SHIFT		0
-#define CFG_ADDR_CFG_TYPE_MASK		0x00000003
+#define CFG_ADDR_CFG_TYPE_1		1
 
 #define SYS_RC_INTX_MASK		0xf
 
@@ -459,19 +452,15 @@ static inline void iproc_pcie_apb_err_disable(struct pci_bus *bus,
 
 static void __iomem *iproc_pcie_map_ep_cfg_reg(struct iproc_pcie *pcie,
 					       unsigned int busno,
-					       unsigned int slot,
-					       unsigned int fn,
+					       unsigned int devfn,
 					       int where)
 {
 	u16 offset;
 	u32 val;
 
 	/* EP device access */
-	val = (busno << CFG_ADDR_BUS_NUM_SHIFT) |
-		(slot << CFG_ADDR_DEV_NUM_SHIFT) |
-		(fn << CFG_ADDR_FUNC_NUM_SHIFT) |
-		(where & CFG_ADDR_REG_NUM_MASK) |
-		(1 & CFG_ADDR_CFG_TYPE_MASK);
+	val = ALIGN_DOWN(PCIE_ECAM_OFFSET(busno, devfn, where), 4) |
+		CFG_ADDR_CFG_TYPE_1;
 
 	iproc_pcie_write_reg(pcie, IPROC_PCIE_CFG_ADDR, val);
 	offset = iproc_pcie_reg_offset(pcie, IPROC_PCIE_CFG_DATA);
@@ -574,8 +563,6 @@ static int iproc_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
 				  int where, int size, u32 *val)
 {
 	struct iproc_pcie *pcie = iproc_data(bus);
-	unsigned int slot = PCI_SLOT(devfn);
-	unsigned int fn = PCI_FUNC(devfn);
 	unsigned int busno = bus->number;
 	void __iomem *cfg_data_p;
 	unsigned int data;
@@ -590,7 +577,7 @@ static int iproc_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
 		return ret;
 	}
 
-	cfg_data_p = iproc_pcie_map_ep_cfg_reg(pcie, busno, slot, fn, where);
+	cfg_data_p = iproc_pcie_map_ep_cfg_reg(pcie, busno, devfn, where);
 
 	if (!cfg_data_p)
 		return PCIBIOS_DEVICE_NOT_FOUND;
@@ -631,13 +618,11 @@ static void __iomem *iproc_pcie_map_cfg_bus(struct iproc_pcie *pcie,
 					    int busno, unsigned int devfn,
 					    int where)
 {
-	unsigned slot = PCI_SLOT(devfn);
-	unsigned fn = PCI_FUNC(devfn);
 	u16 offset;
 
 	/* root complex access */
 	if (busno == 0) {
-		if (slot > 0 || fn > 0)
+		if (PCIE_ECAM_DEVFN(devfn) > 0)
 			return NULL;
 
 		iproc_pcie_write_reg(pcie, IPROC_PCIE_CFG_IND_ADDR,
@@ -649,7 +634,7 @@ static void __iomem *iproc_pcie_map_cfg_bus(struct iproc_pcie *pcie,
 			return (pcie->base + offset);
 	}
 
-	return iproc_pcie_map_ep_cfg_reg(pcie, busno, slot, fn, where);
+	return iproc_pcie_map_ep_cfg_reg(pcie, busno, devfn, where);
 }
 
 static void __iomem *iproc_pcie_bus_map_cfg_bus(struct pci_bus *bus,
-- 
2.29.2

