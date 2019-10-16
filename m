Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62040D9AE5
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2019 22:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732372AbfJPUHK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Oct 2019 16:07:10 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42295 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732214AbfJPUHK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Oct 2019 16:07:10 -0400
Received: by mail-oi1-f193.google.com with SMTP id i185so104228oif.9;
        Wed, 16 Oct 2019 13:07:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=st17vpO3Sjk/YveE/shGEEjM5IJJ8bf2RUn8pW/5jlw=;
        b=MjIBHjH/dirDvRcN3JgDulKxQxUyI1C09UhdpeY+gBzK06X1F+Xphc44ezHjDh8gJG
         JzyRqlBbmtpXHfkynUpoIguLDmoKOqhQINgxCjRuZ1/Valt3SV+I/+t2gHO+Hrmk5t6/
         Kn8YKum2j9TqyzZfW93HQQNplM7QecrG8BX79ZvB3AaEc1cZvWTwGkj2NPPaEYXlCdZ3
         r17+xRkw9vta4PwjyDvKq5DZdMOT4Kj+za7KZFxvIv2cMACb94FLmZ7IZUFnxEm5CBrg
         Bxgjy7DymSY9yjO/IKv7MmOHhy8U9mdfVpkfLPRP2+k6kWPqGvBVFsMrLMcvG6VadYRh
         yrQw==
X-Gm-Message-State: APjAAAXS9rehGi6KC0TtLLJHEmhg7DVutKkmqQXendh3haGv7HFOcUOU
        Bd3S6TosgsHVEdBEdDAjRw==
X-Google-Smtp-Source: APXvYqy7QYMWarjlrmBh8PnibBMnH8u9wCgCHLI7lviMJVQl9vK5JFNEJrVkOjl3hfz3ufReLXBzHQ==
X-Received: by 2002:aca:d954:: with SMTP id q81mr76216oig.161.1571256428894;
        Wed, 16 Oct 2019 13:07:08 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id a9sm7412463oie.7.2019.10.16.13.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 13:07:08 -0700 (PDT)
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
Subject: [PATCH v2 10/25] PCI: rockchip: Use pci_parse_request_of_pci_ranges()
Date:   Wed, 16 Oct 2019 15:06:32 -0500
Message-Id: <20191016200647.32050-11-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191016200647.32050-1-robh@kernel.org>
References: <20191016200647.32050-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Convert the Rockchip host bridge to use the common
pci_parse_request_of_pci_ranges().

There's no need to assign the resources to a temporary list first. Just
use bridge->windows directly and remove all the temporary list handling.

Cc: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Andrew Murray <andrew.murray@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
- New patch

 drivers/pci/controller/pcie-rockchip-host.c | 36 ++++-----------------
 1 file changed, 7 insertions(+), 29 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index ef8e677ce9d1..8d2e6f2e141e 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -950,14 +950,10 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct pci_bus *bus, *child;
 	struct pci_host_bridge *bridge;
+	struct resource *bus_res;
 	struct resource_entry *win;
-	resource_size_t io_base;
-	struct resource	*mem;
-	struct resource	*io;
 	int err;

-	LIST_HEAD(res);
-
 	if (!dev->of_node)
 		return -ENODEV;

@@ -995,29 +991,20 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 	if (err < 0)
 		goto err_deinit_port;

-	err = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
-						    &res, &io_base);
+	err = pci_parse_request_of_pci_ranges(dev, &bridge->windows, &bus_res);
 	if (err)
 		goto err_remove_irq_domain;

-	err = devm_request_pci_bus_resources(dev, &res);
-	if (err)
-		goto err_free_res;
+	rockchip->root_bus_nr = bus_res->start;

 	/* Get the I/O and memory ranges from DT */
-	resource_list_for_each_entry(win, &res) {
+	resource_list_for_each_entry(win, &bridge->windows) {
 		switch (resource_type(win->res)) {
 		case IORESOURCE_IO:
 			io = win->res;
 			io->name = "I/O";
 			rockchip->io_size = resource_size(io);
 			rockchip->io_bus_addr = io->start - win->offset;
-			err = pci_remap_iospace(io, io_base);
-			if (err) {
-				dev_warn(dev, "error %d: failed to map resource %pR\n",
-					 err, io);
-				continue;
-			}
 			rockchip->io = io;
 			break;
 		case IORESOURCE_MEM:
@@ -1026,9 +1013,6 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 			rockchip->mem_size = resource_size(mem);
 			rockchip->mem_bus_addr = mem->start - win->offset;
 			break;
-		case IORESOURCE_BUS:
-			rockchip->root_bus_nr = win->res->start;
-			break;
 		default:
 			continue;
 		}
@@ -1036,15 +1020,14 @@ static int rockchip_pcie_probe(struct platform_device *pdev)

 	err = rockchip_pcie_cfg_atu(rockchip);
 	if (err)
-		goto err_unmap_iospace;
+		goto err_remove_irq_domain;

 	rockchip->msg_region = devm_ioremap(dev, rockchip->msg_bus_addr, SZ_1M);
 	if (!rockchip->msg_region) {
 		err = -ENOMEM;
-		goto err_unmap_iospace;
+		goto err_remove_irq_domain;
 	}

-	list_splice_init(&res, &bridge->windows);
 	bridge->dev.parent = dev;
 	bridge->sysdata = rockchip;
 	bridge->busnr = 0;
@@ -1054,7 +1037,7 @@ static int rockchip_pcie_probe(struct platform_device *pdev)

 	err = pci_scan_root_bus_bridge(bridge);
 	if (err < 0)
-		goto err_unmap_iospace;
+		goto err_remove_irq_domain;

 	bus = bridge->bus;

@@ -1068,10 +1051,6 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 	pci_bus_add_devices(bus);
 	return 0;

-err_unmap_iospace:
-	pci_unmap_iospace(rockchip->io);
-err_free_res:
-	pci_free_resource_list(&res);
 err_remove_irq_domain:
 	irq_domain_remove(rockchip->irq_domain);
 err_deinit_port:
@@ -1097,7 +1076,6 @@ static int rockchip_pcie_remove(struct platform_device *pdev)

 	pci_stop_root_bus(rockchip->root_bus);
 	pci_remove_root_bus(rockchip->root_bus);
-	pci_unmap_iospace(rockchip->io);
 	irq_domain_remove(rockchip->irq_domain);

 	rockchip_pcie_deinit_phys(rockchip);
--
2.20.1
