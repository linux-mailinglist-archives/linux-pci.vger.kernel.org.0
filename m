Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E929AD9B00
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2019 22:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387651AbfJPUHc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Oct 2019 16:07:32 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37923 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbfJPUHb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Oct 2019 16:07:31 -0400
Received: by mail-ot1-f67.google.com with SMTP id e11so21281633otl.5;
        Wed, 16 Oct 2019 13:07:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1bGHnYASjnI+P7cb/3RVdE6NbxNvaokwSF+ldOrM7Qw=;
        b=afwbGu4DlgFpQfOwfvHxRJoFIUk1KvnejBhavSJbnGXvEMgWVy62VvwUQ0ZDCwQv8/
         CdPALodL/QAobMBKr1zWdEgRxVavbSOm/hmHkCBdmt6R+fp/NclCEL0Jq6WyPZB2dREa
         GbLGlqUNuYRCFTKHNsoqXGKp5ajezbAKWacxa1jH5stdhW1yznyekoU/ofu1GeVXQz2t
         AhjsGEZBts5fAjsCROqFeVaT5SO9bbM1ndlGsq5tIxIjKX3Pz42dpKbXb/viqifQnqcH
         qTBSXdnkXWQiBzNzgSm3cdZWE1b7bU2zQ+114cZtscGaGGF7hTvrsHriZxJCXGf9rM0j
         08mw==
X-Gm-Message-State: APjAAAVecgPtN8WcB9ahA+9NtofU/klrZmLAh990tlHknFT+qeYDPj93
        GnWOAJLxx9oMCCxNNe4r5w==
X-Google-Smtp-Source: APXvYqyLj/yK9YMmfwegdydwCk5s+1fUmu7hKih8ld0vvpY4HhzRxwdSsYNyifYWjZYhgXnSuDgfcw==
X-Received: by 2002:a9d:4591:: with SMTP id x17mr51499ote.112.1571256450757;
        Wed, 16 Oct 2019 13:07:30 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id a9sm7412463oie.7.2019.10.16.13.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 13:07:30 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
        Ley Foon Tan <lftan@altera.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Ray Jui <rjui@broadcom.com>, rfi@lists.rocketboards.org,
        Ryder Lee <ryder.lee@mediatek.com>,
        Scott Branden <sbranden@broadcom.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Horman <horms@verge.net.au>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Toan Le <toan@os.amperecomputing.com>,
        Tom Joseph <tjoseph@cadence.com>, Will Deacon <will@kernel.org>
Subject: [PATCH v2 22/25] PCI: xgene: Use inbound resources for setup
Date:   Wed, 16 Oct 2019 15:06:44 -0500
Message-Id: <20191016200647.32050-23-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191016200647.32050-1-robh@kernel.org>
References: <20191016200647.32050-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Now that the helpers provide the inbound resources in the host bridge
'dma_ranges' resource list, convert the Xgene host bridge to use the
resource list to setup the inbound addresses.

Cc: Toan Le <toan@os.amperecomputing.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Andrew Murray <andrew.murray@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/pci-xgene.c | 32 ++++++++++--------------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/controller/pci-xgene.c b/drivers/pci/controller/pci-xgene.c
index 9408269d943d..e808a406dfb0 100644
--- a/drivers/pci/controller/pci-xgene.c
+++ b/drivers/pci/controller/pci-xgene.c
@@ -481,27 +481,27 @@ static int xgene_pcie_select_ib_reg(u8 *ib_reg_mask, u64 size)
 }
 
 static void xgene_pcie_setup_ib_reg(struct xgene_pcie_port *port,
-				    struct of_pci_range *range, u8 *ib_reg_mask)
+				    struct resource_entry *entry, u8 *ib_reg_mask)
 {
 	void __iomem *cfg_base = port->cfg_base;
 	struct device *dev = port->dev;
 	void *bar_addr;
 	u32 pim_reg;
-	u64 cpu_addr = range->cpu_addr;
-	u64 pci_addr = range->pci_addr;
-	u64 size = range->size;
+	u64 cpu_addr = entry->res->start;
+	u64 pci_addr = cpu_addr - entry->offset;
+	u64 size = resource_size(entry->res);
 	u64 mask = ~(size - 1) | EN_REG;
 	u32 flags = PCI_BASE_ADDRESS_MEM_TYPE_64;
 	u32 bar_low;
 	int region;
 
-	region = xgene_pcie_select_ib_reg(ib_reg_mask, range->size);
+	region = xgene_pcie_select_ib_reg(ib_reg_mask, size);
 	if (region < 0) {
 		dev_warn(dev, "invalid pcie dma-range config\n");
 		return;
 	}
 
-	if (range->flags & IORESOURCE_PREFETCH)
+	if (entry->res->flags & IORESOURCE_PREFETCH)
 		flags |= PCI_BASE_ADDRESS_MEM_PREFETCH;
 
 	bar_low = pcie_bar_low_val((u32)cpu_addr, flags);
@@ -532,25 +532,13 @@ static void xgene_pcie_setup_ib_reg(struct xgene_pcie_port *port,
 
 static int xgene_pcie_parse_map_dma_ranges(struct xgene_pcie_port *port)
 {
-	struct device_node *np = port->node;
-	struct of_pci_range range;
-	struct of_pci_range_parser parser;
-	struct device *dev = port->dev;
+	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(port);
+	struct resource_entry *entry;
 	u8 ib_reg_mask = 0;
 
-	if (of_pci_dma_range_parser_init(&parser, np)) {
-		dev_err(dev, "missing dma-ranges property\n");
-		return -EINVAL;
-	}
-
-	/* Get the dma-ranges from DT */
-	for_each_of_pci_range(&parser, &range) {
-		u64 end = range.cpu_addr + range.size - 1;
+	resource_list_for_each_entry(entry, &bridge->dma_ranges)
+		xgene_pcie_setup_ib_reg(port, entry, &ib_reg_mask);
 
-		dev_dbg(dev, "0x%08x 0x%016llx..0x%016llx -> 0x%016llx\n",
-			range.flags, range.cpu_addr, end, range.pci_addr);
-		xgene_pcie_setup_ib_reg(port, &range, &ib_reg_mask);
-	}
 	return 0;
 }
 
-- 
2.20.1

