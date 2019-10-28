Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B26DFE765C
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2019 17:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732933AbfJ1Qdm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Oct 2019 12:33:42 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45970 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730772AbfJ1Qdm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Oct 2019 12:33:42 -0400
Received: by mail-oi1-f193.google.com with SMTP id k2so1286405oij.12;
        Mon, 28 Oct 2019 09:33:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gXFj97mkbGwNy9HcITgsXlHzoihDJWyxuLbZMG3bMrk=;
        b=AbLBebpL7oUHwFjivY0wy182SRR3iFiem9N/daj6okX6CFNpRJAgM4w26Oq5jw/cY9
         NwDrpGCOaUBHC3YndbKkL2l9AK0hisuxI2wLLtVqvib/3TQLyuByr/PliDbv+g6V8gbJ
         wt930pJX0fdI5k9/MWXzqJb/GIEDousbEHCMnHNqVH63wKG1FOiTqujHBrWiIbXnj1E1
         EoOl2jyk6V+Aai29eDus2Epzdy6iLUNe/0Dj438QtkvmMEuIKFqcjxRreiPEe6BbSXEu
         DtO0nByYAFb74/ULhG6ch1xeShDALw2uhG52I4qpefO7X+5mafdYi8J7A4k+uZ+Hv0Ot
         iBdQ==
X-Gm-Message-State: APjAAAXF7bm0qGYAVVucm7Qm7fcSWclhyIvbdscg395MnIh7GzCEg458
        xG5Rx9M/F9l+VqsCjhPAxg==
X-Google-Smtp-Source: APXvYqyAyPrUKbfPJy6jun7gPAIEO0JEPIYDjbds2nS284G2YkNImID/wTHAeVHyFp19AQ13lX76hg==
X-Received: by 2002:aca:1a0b:: with SMTP id a11mr149284oia.138.1572280421584;
        Mon, 28 Oct 2019 09:33:41 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id e186sm354991oia.47.2019.10.28.09.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 09:33:40 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        Christoph Hellwig <hch@infradead.org>,
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
Subject: [PATCH v3 17/25] PCI: versatile: Remove usage of PHYS_OFFSET
Date:   Mon, 28 Oct 2019 11:32:48 -0500
Message-Id: <20191028163256.8004-18-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191028163256.8004-1-robh@kernel.org>
References: <20191028163256.8004-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PHYS_OFFSET is not universally defined on all arches and using it prevents
enabling COMPILE_TEST. PAGE_OFFSET and __pa() are always available, so use
them to get the physical start of memory address.

This should have probably used 'dma-ranges' to get the address, but we
don't want to force a DT update to do that. At least in QEMU, the SMAP
registers have no effect (or perhaps the only value that is handled is 0).

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Andrew Murray <andrew.murray@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/pci-versatile.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pci-versatile.c b/drivers/pci/controller/pci-versatile.c
index 18697f2ea345..eae1b859990b 100644
--- a/drivers/pci/controller/pci-versatile.c
+++ b/drivers/pci/controller/pci-versatile.c
@@ -99,7 +99,7 @@ static int versatile_pci_probe(struct platform_device *pdev)
 	resource_list_for_each_entry(entry, &bridge->windows) {
 		if (resource_type(entry->res) == IORESOURCE_MEM) {
 			writel(entry->res->start >> 28, PCI_IMAP(mem));
-			writel(PHYS_OFFSET >> 28, PCI_SMAP(mem));
+			writel(__pa(PAGE_OFFSET) >> 28, PCI_SMAP(mem));
 			mem++;
 		}
 	}
@@ -136,9 +136,9 @@ static int versatile_pci_probe(struct platform_device *pdev)
 	/*
 	 * Configure the PCI inbound memory windows to be 1:1 mapped to SDRAM
 	 */
-	writel(PHYS_OFFSET, local_pci_cfg_base + PCI_BASE_ADDRESS_0);
-	writel(PHYS_OFFSET, local_pci_cfg_base + PCI_BASE_ADDRESS_1);
-	writel(PHYS_OFFSET, local_pci_cfg_base + PCI_BASE_ADDRESS_2);
+	writel(__pa(PAGE_OFFSET), local_pci_cfg_base + PCI_BASE_ADDRESS_0);
+	writel(__pa(PAGE_OFFSET), local_pci_cfg_base + PCI_BASE_ADDRESS_1);
+	writel(__pa(PAGE_OFFSET), local_pci_cfg_base + PCI_BASE_ADDRESS_2);
 
 	/*
 	 * For many years the kernel and QEMU were symbiotically buggy
-- 
2.20.1

