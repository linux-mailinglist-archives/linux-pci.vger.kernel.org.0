Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE59D9ADB
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2019 22:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731790AbfJPUHB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Oct 2019 16:07:01 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41096 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731066AbfJPUHB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Oct 2019 16:07:01 -0400
Received: by mail-oi1-f195.google.com with SMTP id g81so109095oib.8;
        Wed, 16 Oct 2019 13:07:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YA57ID7HssfptBArCep2MY8T32tzTOpp6n73JZLWHrY=;
        b=UAZIEXtjtzdPa0W2gLYOh1KRpFa/BLEhaUV9VVgvreSkNAQLHO55pptKxcY9N/6xp0
         mGt/kOoH+OShn4DFydiEfjKblosDGX2vq17yZHKbJwDlm0KsePEkPUJQgntW7DwFIuav
         ORMNzu6mCAtEGhjYTXTQ0c+E7AgYs//0xVETRPT9wfJ1BEBG+zmBWDXfG6+2zN/out+b
         GunCOeJmV2RYJqj5zDierZixzYhEbTlQYk6VKvdYz5c8XYIidPJtiitjp9jvmW4Fc5Qj
         EEwGZerLSZQBjWzVEA3wrE7GcQEHYEYmmR7CutnGFjrxS7DQu1LxemF9FfQZirmE9yJQ
         ZmrA==
X-Gm-Message-State: APjAAAXaKqvTe9E/rPkk4iryfvhCs7au4ne4VoMpdoV6QJKkQzTVCkmx
        x7iOtUKloWHXIRgpR0vy5w==
X-Google-Smtp-Source: APXvYqyakPWBO0mkOpMpK5U/GSZnT1haaiWULUW+yiLTI26g2Lgw4JGeutIuaV6f+nslk+Tc2+/0YA==
X-Received: by 2002:aca:5b02:: with SMTP id p2mr111363oib.94.1571256420107;
        Wed, 16 Oct 2019 13:07:00 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id a9sm7412463oie.7.2019.10.16.13.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 13:06:59 -0700 (PDT)
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
Subject: [PATCH v2 05/25] PCI: dwc: Use pci_parse_request_of_pci_ranges()
Date:   Wed, 16 Oct 2019 15:06:27 -0500
Message-Id: <20191016200647.32050-6-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191016200647.32050-1-robh@kernel.org>
References: <20191016200647.32050-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Convert the Designware host bridge to use the common
pci_parse_request_of_pci_ranges().

Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Andrew Murray <andrew.murray@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
- New patch

 .../pci/controller/dwc/pcie-designware-host.c | 28 ++++++-------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 0f36a926059a..aeec8b65eb97 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -319,7 +319,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	struct device *dev = pci->dev;
 	struct device_node *np = dev->of_node;
 	struct platform_device *pdev = to_platform_device(dev);
-	struct resource_entry *win, *tmp;
+	struct resource_entry *win;
 	struct pci_bus *child;
 	struct pci_host_bridge *bridge;
 	struct resource *cfg_res;
@@ -342,31 +342,19 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	if (!bridge)
 		return -ENOMEM;

-	ret = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
-					&bridge->windows, &pp->io_base);
-	if (ret)
-		return ret;
-
-	ret = devm_request_pci_bus_resources(dev, &bridge->windows);
+	ret = pci_parse_request_of_pci_ranges(dev, &bridge->windows, NULL);
 	if (ret)
 		return ret;

 	/* Get the I/O and memory ranges from DT */
-	resource_list_for_each_entry_safe(win, tmp, &bridge->windows) {
+	resource_list_for_each_entry(win, &bridge->windows) {
 		switch (resource_type(win->res)) {
 		case IORESOURCE_IO:
-			ret = devm_pci_remap_iospace(dev, win->res,
-						     pp->io_base);
-			if (ret) {
-				dev_warn(dev, "Error %d: failed to map resource %pR\n",
-					 ret, win->res);
-				resource_list_destroy_entry(win);
-			} else {
-				pp->io = win->res;
-				pp->io->name = "I/O";
-				pp->io_size = resource_size(pp->io);
-				pp->io_bus_addr = pp->io->start - win->offset;
-			}
+			pp->io = win->res;
+			pp->io->name = "I/O";
+			pp->io_size = resource_size(pp->io);
+			pp->io_bus_addr = pp->io->start - win->offset;
+			pp->io_base = pci_pio_to_address(pp->io->start);
 			break;
 		case IORESOURCE_MEM:
 			pp->mem = win->res;
--
2.20.1
