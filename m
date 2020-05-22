Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9B51DF336
	for <lists+linux-pci@lfdr.de>; Sat, 23 May 2020 01:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387435AbgEVXst (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 May 2020 19:48:49 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:46922 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387413AbgEVXss (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 May 2020 19:48:48 -0400
Received: by mail-il1-f195.google.com with SMTP id w18so12437147ilm.13
        for <linux-pci@vger.kernel.org>; Fri, 22 May 2020 16:48:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zH2C4ImO8nBnvyYQO4O7Y0tt8wrJ36q82CPBc6+58Gs=;
        b=Kqg1cHr7p6LLh9wS6F5EjscfBMwhEmHKsEyyWZeS3mkMqB/AJCmAnaUCOUYCXwRaW1
         u8hL8w9TtSEufsdtB8jxDAW/vUWxvQRD4uyworVVZKDDUHr5GWvTWGBx5Hun7UC/i3pU
         yWLLehIrzOj+DT3sXDruaqp42RBhpwipLP79w6niX89ZcWa/bg+nuP30O8TIVbYxMWJz
         GVvCMMTlMJgsZIFMZqi1HOUmOVMvn0lKFSEt5CpFunc+P0lDNubRFEli3q94Fxqgduyt
         p4eE80WTdxuDGSlxZFxnVOalkteVr4W/q1uC3YXUIriBgxEOaeZnrv5Z/Rr8cRvCuPPm
         Ds3A==
X-Gm-Message-State: AOAM530IaFCKpcnJlCFauAyaKJXXQtKid3y8BmSk5/yEydHc06VnJTz5
        gn310Rlzxoqr+cC6Uwe28g==
X-Google-Smtp-Source: ABdhPJybuB2O9NZz3pehcS6OOH6aSsjmBYbiZ8trb6adP3sKcXHHx5eDTRdxXxjc/F2eV1Dz4MmC9g==
X-Received: by 2002:a92:c94f:: with SMTP id i15mr14637382ilq.185.1590191327879;
        Fri, 22 May 2020 16:48:47 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id w23sm4390877iod.9.2020.05.22.16.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 16:48:47 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Subject: [PATCH 13/15] PCI: rockchip: Use pci_host_probe() to register host
Date:   Fri, 22 May 2020 17:48:30 -0600
Message-Id: <20200522234832.954484-14-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200522234832.954484-1-robh@kernel.org>
References: <20200522234832.954484-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The rockchip host driver does the same host registration and bus scanning
calls as pci_host_probe, so let's use it instead.

Cc: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/pcie-rockchip-host.c | 18 ++++--------------
 drivers/pci/controller/pcie-rockchip.h      |  1 -
 2 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index 94af6f5828a3..6a3c8442258b 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -949,7 +949,6 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 {
 	struct rockchip_pcie *rockchip;
 	struct device *dev = &pdev->dev;
-	struct pci_bus *bus, *child;
 	struct pci_host_bridge *bridge;
 	struct resource *bus_res;
 	int err;
@@ -1015,20 +1014,10 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 	bridge->map_irq = of_irq_parse_and_map_pci;
 	bridge->swizzle_irq = pci_common_swizzle;
 
-	err = pci_scan_root_bus_bridge(bridge);
+	err = pci_host_probe(bridge);
 	if (err < 0)
 		goto err_remove_irq_domain;
 
-	bus = bridge->bus;
-
-	rockchip->root_bus = bus;
-
-	pci_bus_size_bridges(bus);
-	pci_bus_assign_resources(bus);
-	list_for_each_entry(child, &bus->children, node)
-		pcie_bus_configure_settings(child);
-
-	pci_bus_add_devices(bus);
 	return 0;
 
 err_remove_irq_domain:
@@ -1051,9 +1040,10 @@ static int rockchip_pcie_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
+	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(rockchip);
 
-	pci_stop_root_bus(rockchip->root_bus);
-	pci_remove_root_bus(rockchip->root_bus);
+	pci_stop_root_bus(bridge->bus);
+	pci_remove_root_bus(bridge->bus);
 	irq_domain_remove(rockchip->irq_domain);
 
 	rockchip_pcie_deinit_phys(rockchip);
diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index d90dfb354573..4012543bafbe 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -303,7 +303,6 @@ struct rockchip_pcie {
 	struct	device *dev;
 	struct	irq_domain *irq_domain;
 	int     offset;
-	struct pci_bus *root_bus;
 	void    __iomem *msg_region;
 	phys_addr_t msg_bus_addr;
 	bool is_rc;
-- 
2.25.1

