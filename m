Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A434E766C
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2019 17:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391050AbfJ1Qd5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Oct 2019 12:33:57 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36193 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729420AbfJ1Qd5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Oct 2019 12:33:57 -0400
Received: by mail-ot1-f66.google.com with SMTP id c7so7185813otm.3;
        Mon, 28 Oct 2019 09:33:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DUL+m3NhP58NWVgq+Qieb9x0OfdgTK/3u8ZTlPRNpf8=;
        b=M5zu+zDBcywzsIOBcaU3SNc1/CPj2AI/W+QjLLUHVmEHebApspAAhAis44m5lLE+yF
         jvRCYd93Q4q92NvKUtNko/rT96lWp+SSMNylaNL6j+GnW0tZH4TGMN5Q46z2+p+LVl0I
         PT/ZdCDnDjK7oL/KNzh2w1B0fQg6QkbTs8gb7HUhodvGNTnwfpDsvV+m+8r+h+VO7wXF
         AfCJDfqKXM9s0cn4naKLK3puXYi6kkCbENDeQhvQeLbAknZADw2lw34y5vht3PoFux/S
         OHw0Kwu/uAAmjyQyJgV226a1nTeSth0brKagKWU+SSTEP9mJvrcTUcw8X2ddz3Ij7RLD
         pk1Q==
X-Gm-Message-State: APjAAAVsUF3r2GSEpueB0DFsfH5Z/urFSbziOsg2vDIuUgpnegqyjgET
        cczoGC/AfE9TzWJUdqfpfg==
X-Google-Smtp-Source: APXvYqyPxtg2swpf530JxdQcsdiawBZNYu+uT+14bkBsB8TaDWNTfBY9ewk7vPf38ETbIHCmQW7g2w==
X-Received: by 2002:a9d:1c9c:: with SMTP id l28mr8888143ota.10.1572280435975;
        Mon, 28 Oct 2019 09:33:55 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id e186sm354991oia.47.2019.10.28.09.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 09:33:55 -0700 (PDT)
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
Subject: [PATCH v3 23/25] PCI: iproc: Use inbound resources for setup
Date:   Mon, 28 Oct 2019 11:32:54 -0500
Message-Id: <20191028163256.8004-24-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191028163256.8004-1-robh@kernel.org>
References: <20191028163256.8004-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Now that the helpers provide the inbound resources in the host bridge
'dma_ranges' resource list, convert Broadcom iProc host bridge to use
the resource list to setup the inbound addresses.

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com
Reviewed-by: Andrew Murray <andrew.murray@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - Fix iproc_pcie_paxb_v2_msi_steer() to use resource_entry
---
 drivers/pci/controller/pcie-iproc.c | 77 +++++++----------------------
 1 file changed, 17 insertions(+), 60 deletions(-)

diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
index 223335ee791a..f4d78e66846e 100644
--- a/drivers/pci/controller/pcie-iproc.c
+++ b/drivers/pci/controller/pcie-iproc.c
@@ -1122,15 +1122,16 @@ static int iproc_pcie_ib_write(struct iproc_pcie *pcie, int region_idx,
 }
 
 static int iproc_pcie_setup_ib(struct iproc_pcie *pcie,
-			       struct of_pci_range *range,
+			       struct resource_entry *entry,
 			       enum iproc_pcie_ib_map_type type)
 {
 	struct device *dev = pcie->dev;
 	struct iproc_pcie_ib *ib = &pcie->ib;
 	int ret;
 	unsigned int region_idx, size_idx;
-	u64 axi_addr = range->cpu_addr, pci_addr = range->pci_addr;
-	resource_size_t size = range->size;
+	u64 axi_addr = entry->res->start;
+	u64 pci_addr = entry->res->start - entry->offset;
+	resource_size_t size = resource_size(entry->res);
 
 	/* iterate through all IARR mapping regions */
 	for (region_idx = 0; region_idx < ib->nr_regions; region_idx++) {
@@ -1182,66 +1183,19 @@ static int iproc_pcie_setup_ib(struct iproc_pcie *pcie,
 	return ret;
 }
 
-static int iproc_pcie_add_dma_range(struct device *dev,
-				    struct list_head *resources,
-				    struct of_pci_range *range)
-{
-	struct resource *res;
-	struct resource_entry *entry, *tmp;
-	struct list_head *head = resources;
-
-	res = devm_kzalloc(dev, sizeof(struct resource), GFP_KERNEL);
-	if (!res)
-		return -ENOMEM;
-
-	resource_list_for_each_entry(tmp, resources) {
-		if (tmp->res->start < range->cpu_addr)
-			head = &tmp->node;
-	}
-
-	res->start = range->cpu_addr;
-	res->end = res->start + range->size - 1;
-
-	entry = resource_list_create_entry(res, 0);
-	if (!entry)
-		return -ENOMEM;
-
-	entry->offset = res->start - range->cpu_addr;
-	resource_list_add(entry, head);
-
-	return 0;
-}
-
 static int iproc_pcie_map_dma_ranges(struct iproc_pcie *pcie)
 {
 	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
-	struct of_pci_range range;
-	struct of_pci_range_parser parser;
-	int ret;
-	LIST_HEAD(resources);
-
-	/* Get the dma-ranges from DT */
-	ret = of_pci_dma_range_parser_init(&parser, pcie->dev->of_node);
-	if (ret)
-		return ret;
+	struct resource_entry *entry;
+	int ret = 0;
 
-	for_each_of_pci_range(&parser, &range) {
-		ret = iproc_pcie_add_dma_range(pcie->dev,
-					       &resources,
-					       &range);
-		if (ret)
-			goto out;
+	resource_list_for_each_entry(entry, &host->dma_ranges) {
 		/* Each range entry corresponds to an inbound mapping region */
-		ret = iproc_pcie_setup_ib(pcie, &range, IPROC_PCIE_IB_MAP_MEM);
+		ret = iproc_pcie_setup_ib(pcie, entry, IPROC_PCIE_IB_MAP_MEM);
 		if (ret)
-			goto out;
+			break;
 	}
 
-	list_splice_init(&resources, &host->dma_ranges);
-
-	return 0;
-out:
-	pci_free_resource_list(&resources);
 	return ret;
 }
 
@@ -1276,13 +1230,16 @@ static int iproce_pcie_get_msi(struct iproc_pcie *pcie,
 static int iproc_pcie_paxb_v2_msi_steer(struct iproc_pcie *pcie, u64 msi_addr)
 {
 	int ret;
-	struct of_pci_range range;
+	struct resource_entry entry;
+
+	memset(&entry, 0, sizeof(entry));
+	entry.res = &entry.__res;
 
-	memset(&range, 0, sizeof(range));
-	range.size = SZ_32K;
-	range.pci_addr = range.cpu_addr = msi_addr & ~(range.size - 1);
+	msi_addr &= ~(SZ_32K - 1);
+	entry.res->start = msi_addr;
+	entry.res->end = msi_addr + SZ_32K - 1;
 
-	ret = iproc_pcie_setup_ib(pcie, &range, IPROC_PCIE_IB_MAP_IO);
+	ret = iproc_pcie_setup_ib(pcie, &entry, IPROC_PCIE_IB_MAP_IO);
 	return ret;
 }
 
-- 
2.20.1

