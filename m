Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB3B228E08
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jul 2020 04:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731796AbgGVCZm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jul 2020 22:25:42 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33045 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731764AbgGVCZk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jul 2020 22:25:40 -0400
Received: by mail-io1-f67.google.com with SMTP id d18so895356ion.0;
        Tue, 21 Jul 2020 19:25:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yZX8GtxzIvI0BLawXOSy34dS8zpbVsqdHlUxTpQVpL8=;
        b=Oyz1NoMyNxs0QLSMOyLx73Mjh8W2f2ly36fcautVg1Dnpw0zDsjq34RW0hBRhbWSMT
         OwKns5W30wvhBSAfzUB+qmI3KsfWP3fyN/6UHxDoLE6jOq0FJAKF7v2eqJLXPXwFPvHG
         BW6saQaqw18mKO/omo3lYtL3yqUsZ0zyc00S5sc+JLrIfAwcXGSKnW4/ntC0jHCkdQIi
         J8JTxDJ5PyRuZlbxF+DZCKtE8k/DQnPD4+YTBGEP3RwE2aGiOcH1BCaDAAto5Zu4DZMA
         L4ffVV1YqSZwIl4LilJQ+u7R/YvyrpN0CnqF9SP2zGWnkYlQ3q+KATJYeyB1d0triDV0
         uavw==
X-Gm-Message-State: AOAM5336Rte40r0Ns9VUr5j+RbXuXwQmLxFrOd77T1VgKelxwpSbwjxp
        bC91JkI2DltsfpfXWyebwQ==
X-Google-Smtp-Source: ABdhPJz4sGi9luyOXYk58mq4r4siCaMJWINiGTp2AvzN9kAFUT92PuxemaSvg8HDlZCOqn4NVsZ7Ww==
X-Received: by 2002:a6b:5502:: with SMTP id j2mr492985iob.204.1595384739849;
        Tue, 21 Jul 2020 19:25:39 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id y2sm11687981iox.22.2020.07.21.19.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 19:25:39 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Will Deacon <will@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: [PATCH 06/19] PCI: mobiveil: Use pci_is_root_bus() to check if bus is root bus
Date:   Tue, 21 Jul 2020 20:25:01 -0600
Message-Id: <20200722022514.1283916-7-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200722022514.1283916-1-robh@kernel.org>
References: <20200722022514.1283916-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use pci_is_root_bus() rather than tracking the root bus number to
determine if the bus is the root bus or not. This removes storing
duplicated data as well as the need for the host bridge driver to have
to care about the bus numbers in most cases.

Cc: Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>
Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/mobiveil/pcie-mobiveil-host.c | 10 +++-------
 drivers/pci/controller/mobiveil/pcie-mobiveil.h      |  1 -
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
index 705542b4bd21..7250b84a7efe 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
@@ -29,18 +29,15 @@
 
 static bool mobiveil_pcie_valid_device(struct pci_bus *bus, unsigned int devfn)
 {
-	struct mobiveil_pcie *pcie = bus->sysdata;
-	struct mobiveil_root_port *rp = &pcie->rp;
-
 	/* Only one device down on each root port */
-	if ((bus->number == rp->root_bus_nr) && (devfn > 0))
+	if (pci_is_root_bus(bus) && (devfn > 0))
 		return false;
 
 	/*
 	 * Do not read more than one device on the bus directly
 	 * attached to RC
 	 */
-	if ((bus->primary == rp->root_bus_nr) && (PCI_SLOT(devfn) > 0))
+	if ((bus->primary == to_pci_host_bridge(bus->bridge)->busnr) && (PCI_SLOT(devfn) > 0))
 		return false;
 
 	return true;
@@ -61,7 +58,7 @@ static void __iomem *mobiveil_pcie_map_bus(struct pci_bus *bus,
 		return NULL;
 
 	/* RC config access */
-	if (bus->number == rp->root_bus_nr)
+	if (pci_is_root_bus(bus))
 		return pcie->csr_axi_slave_base + where;
 
 	/*
@@ -606,7 +603,6 @@ int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie)
 
 	/* Initialize bridge */
 	bridge->sysdata = pcie;
-	bridge->busnr = rp->root_bus_nr;
 	bridge->ops = &mobiveil_pcie_ops;
 	bridge->map_irq = of_irq_parse_and_map_pci;
 	bridge->swizzle_irq = pci_common_swizzle;
diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.h b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
index 767e36a8522d..6082b8afbc31 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil.h
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
@@ -149,7 +149,6 @@ struct mobiveil_rp_ops {
 };
 
 struct mobiveil_root_port {
-	char root_bus_nr;
 	void __iomem *config_axi_slave_base;	/* endpoint config base */
 	struct resource *ob_io_res;
 	struct mobiveil_rp_ops *ops;
-- 
2.25.1

