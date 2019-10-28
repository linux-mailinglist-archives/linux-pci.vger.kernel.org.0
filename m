Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE8C4E7666
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2019 17:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391046AbfJ1Qdv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Oct 2019 12:33:51 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40606 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729420AbfJ1Qdu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Oct 2019 12:33:50 -0400
Received: by mail-ot1-f68.google.com with SMTP id d8so7162183otc.7;
        Mon, 28 Oct 2019 09:33:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QU/9wyXAj8Hn9lmmawqTA3HdfmHqtIC+dVHktjAk5bo=;
        b=PEpGvN0DdjfYjwg1mCKlVb2MbHd4qpvuqBqUF6tswn6C9/vpS7U/vifbjkJN3vhCmh
         PHXlLrwv1k1SFdbgcD6BtDdjiSMgvkZUrbBdTLL/Une1iE5Jvdp9ZnAki/WnbxmuZHUB
         d9W+J1WE35Bvu5/I3dGJweXHf5tE2ooZbZrj2wcFkwUWfPxehLb70/0Hw6yfEb+WCvDS
         /A7A9qVo3NPRKUkwna/v5Q3sXdqLn3EhQbpPmFfcdAJ7HTp0TTxHnuhNfYhVmQkIxMnh
         qzBCQDxJoh+AWXvrwnQysijtnaOrFiSO5UIQV81gpJ3YBG5dSPoQIcwVGVJOcViBvED+
         OjDw==
X-Gm-Message-State: APjAAAVVhKZPfwDi4Wmu7YTBA9GG/IZ59RKvsySF7kPE1yrAsgFAsQvS
        qwvn92zUMKMFhic5CrU1gg==
X-Google-Smtp-Source: APXvYqzX2Hu9uOY3jcrsLEYHaEbafPvhljS7PBlsyooLht3SWyOGTn98jF9BU/3i/RKiepgEwvPcpw==
X-Received: by 2002:a9d:334:: with SMTP id 49mr13870685otv.15.1572280429878;
        Mon, 28 Oct 2019 09:33:49 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id e186sm354991oia.47.2019.10.28.09.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 09:33:49 -0700 (PDT)
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
Subject: [PATCH v3 20/25] PCI: ftpci100: Use inbound resources for setup
Date:   Mon, 28 Oct 2019 11:32:51 -0500
Message-Id: <20191028163256.8004-21-robh@kernel.org>
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
'dma_ranges' resource list, convert Faraday ftpci100 host bridge to use
the resource list to setup the inbound addresses.

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Andrew Murray <andrew.murray@arm.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/pci-ftpci100.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/controller/pci-ftpci100.c b/drivers/pci/controller/pci-ftpci100.c
index 66288b94e92d..1b67564de7af 100644
--- a/drivers/pci/controller/pci-ftpci100.c
+++ b/drivers/pci/controller/pci-ftpci100.c
@@ -375,12 +375,11 @@ static int faraday_pci_setup_cascaded_irq(struct faraday_pci *p)
 	return 0;
 }
 
-static int faraday_pci_parse_map_dma_ranges(struct faraday_pci *p,
-					    struct device_node *np)
+static int faraday_pci_parse_map_dma_ranges(struct faraday_pci *p)
 {
-	struct of_pci_range range;
-	struct of_pci_range_parser parser;
 	struct device *dev = p->dev;
+	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(p);
+	struct resource_entry *entry;
 	u32 confreg[3] = {
 		FARADAY_PCI_MEM1_BASE_SIZE,
 		FARADAY_PCI_MEM2_BASE_SIZE,
@@ -389,19 +388,13 @@ static int faraday_pci_parse_map_dma_ranges(struct faraday_pci *p,
 	int i = 0;
 	u32 val;
 
-	if (of_pci_dma_range_parser_init(&parser, np)) {
-		dev_err(dev, "missing dma-ranges property\n");
-		return -EINVAL;
-	}
-
-	/*
-	 * Get the dma-ranges from the device tree
-	 */
-	for_each_of_pci_range(&parser, &range) {
-		u64 end = range.pci_addr + range.size - 1;
+	resource_list_for_each_entry(entry, &bridge->dma_ranges) {
+		u64 pci_addr = entry->res->start - entry->offset;
+		u64 end = entry->res->end - entry->offset;
 		int ret;
 
-		ret = faraday_res_to_memcfg(range.pci_addr, range.size, &val);
+		ret = faraday_res_to_memcfg(pci_addr,
+					    resource_size(entry->res), &val);
 		if (ret) {
 			dev_err(dev,
 				"DMA range %d: illegal MEM resource size\n", i);
@@ -409,7 +402,7 @@ static int faraday_pci_parse_map_dma_ranges(struct faraday_pci *p,
 		}
 
 		dev_info(dev, "DMA MEM%d BASE: 0x%016llx -> 0x%016llx config %08x\n",
-			 i + 1, range.pci_addr, end, val);
+			 i + 1, pci_addr, end, val);
 		if (i <= 2) {
 			faraday_raw_pci_write_config(p, 0, 0, confreg[i],
 						     4, val);
@@ -539,7 +532,7 @@ static int faraday_pci_probe(struct platform_device *pdev)
 			cur_bus_speed = PCI_SPEED_66MHz;
 	}
 
-	ret = faraday_pci_parse_map_dma_ranges(p, dev->of_node);
+	ret = faraday_pci_parse_map_dma_ranges(p);
 	if (ret)
 		return ret;
 
-- 
2.20.1

