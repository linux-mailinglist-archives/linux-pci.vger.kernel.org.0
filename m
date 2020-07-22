Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 147B6228E0D
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jul 2020 04:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731809AbgGVCZq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jul 2020 22:25:46 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40009 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731633AbgGVCZq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jul 2020 22:25:46 -0400
Received: by mail-io1-f68.google.com with SMTP id l17so861351iok.7;
        Tue, 21 Jul 2020 19:25:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hDVBFAV1LgRYqxRG53cBTHDmtvye0RECoeUbU3k4QmU=;
        b=PeCf/9fBiGRz37y02Wrk2feP55PO17pZWHEVUsfBG/5B3QkbbH1IU6IZ9CNVIxk+Qt
         n7S9Dp4oew7qWqEBkF1XwBXTBcIvEkbY3AheTAVh58dFnSu90dS+ZQQ+d1yyMLs5EvgA
         luDjPowET7ycNMKwjpadFcUEta6/c4vJA9FBDk++oB8bZdA+mRFdstHtymEFP2wpAs/+
         BjPSGhNSGPHrFfwr+AI6nNM0ZSoGMrHjohgiqlu44d8G0oBmVNuDbnyqWU4ph9W4OPpW
         S5PnqFy7WrR3INk+2w7CjemK5cW4VtI4zw0Hlx0USkgw++E41oWmJz1FKX3KjFYlUfF/
         +h0Q==
X-Gm-Message-State: AOAM5311KhFY26h5Zya3KOmDyqhx0Nx2ngskSiS9TJLtv6ZvNO4XXbws
        ujs+kguQHNzykN3ybtVj8Q==
X-Google-Smtp-Source: ABdhPJy/sM+kScso9OnqADpgcxe+bbOpc4xZJUnmm8EGIxt611lXsKW60uaDZrA/MwcYgio2CkE47Q==
X-Received: by 2002:a05:6e02:8e4:: with SMTP id n4mr28099024ilt.96.1595384745117;
        Tue, 21 Jul 2020 19:25:45 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id y2sm11687981iox.22.2020.07.21.19.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 19:25:44 -0700 (PDT)
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
Subject: [PATCH 08/19] PCI: xilinx: Use pci_is_root_bus() to check if bus is root bus
Date:   Tue, 21 Jul 2020 20:25:03 -0600
Message-Id: <20200722022514.1283916-9-robh@kernel.org>
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

There was also a bug that the root_busno is never set which means the
root bus number is always 0 even if the DT said something else.

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/pcie-xilinx.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx.c b/drivers/pci/controller/pcie-xilinx.c
index cce67cb8fb2b..7bf80f68efa9 100644
--- a/drivers/pci/controller/pcie-xilinx.c
+++ b/drivers/pci/controller/pcie-xilinx.c
@@ -98,7 +98,6 @@
  * @reg_base: IO Mapped Register Base
  * @irq: Interrupt number
  * @msi_pages: MSI pages
- * @root_busno: Root Bus number
  * @dev: Device pointer
  * @msi_domain: MSI IRQ domain pointer
  * @leg_domain: Legacy IRQ domain pointer
@@ -108,7 +107,6 @@ struct xilinx_pcie_port {
 	void __iomem *reg_base;
 	u32 irq;
 	unsigned long msi_pages;
-	u8 root_busno;
 	struct device *dev;
 	struct irq_domain *msi_domain;
 	struct irq_domain *leg_domain;
@@ -162,14 +160,13 @@ static bool xilinx_pcie_valid_device(struct pci_bus *bus, unsigned int devfn)
 	struct xilinx_pcie_port *port = bus->sysdata;
 
 	/* Check if link is up when trying to access downstream ports */
-	if (bus->number != port->root_busno)
+	if (!pci_is_root_bus(bus)) {
 		if (!xilinx_pcie_link_up(port))
 			return false;
-
-	/* Only one device down on each root port */
-	if (bus->number == port->root_busno && devfn > 0)
+	} else if (devfn > 0) {
+		/* Only one device down on each root port */
 		return false;
-
+	}
 	return true;
 }
 
-- 
2.25.1

