Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B86EBE7655
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2019 17:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732987AbfJ1Qdg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Oct 2019 12:33:36 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33009 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730772AbfJ1Qdg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Oct 2019 12:33:36 -0400
Received: by mail-oi1-f193.google.com with SMTP id m193so1931284oig.0;
        Mon, 28 Oct 2019 09:33:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o+Nu5yrVJjsG4TTQSGHiVlpfm5ZyTifg0RmA51gaOc0=;
        b=bA+iRtM18Eq/0MlY0qvzFEAqnlxrFPCzt1aGv+XQJG3Z3WGKAe5WFWNG3bnmOscc8o
         AjXXz04wwEPpp12wYQVTdYaSLDvQY2v/iiXvZVdJblKqnIgmTWvB7lfJ5QpQTYBq0bB8
         vcbI2Ea2/FLRq6nRIf3TVuTqL9e/Ln2jgefzn0R4Y6sIXzfwiu7xJiLLvuFdVIgBVEpl
         PBg/7UvKwo9jx1WG6KOS74tt9WIAfm5sh6ZcEZjBHqi4AGZeUoFIXuOxC2VTnh7GK9Y8
         6dRAzh22dwywZWhsj9UxxZEHyozA4hr/QcU/8mnE4r6E2Uyr7unsg3LcUIQ9x59/hvd1
         KKkA==
X-Gm-Message-State: APjAAAWNwrUrBRtJwYT3Ms7DMdr+fUQevazUzhSh1SrBihPn0rERKPq+
        ocnFksbKfnA04X6cpazbDA==
X-Google-Smtp-Source: APXvYqxZLTR5wVAhoLt1SmTt4eoDfXlOKWV5o+tkbeIOsDVOrc+wq0rFYNtuDO1eJW+OcmohkZZkqQ==
X-Received: by 2002:aca:5015:: with SMTP id e21mr140283oib.174.1572280415373;
        Mon, 28 Oct 2019 09:33:35 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id e186sm354991oia.47.2019.10.28.09.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 09:33:34 -0700 (PDT)
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
Subject: [PATCH v3 14/25] PCI: xilinx: Use pci_parse_request_of_pci_ranges()
Date:   Mon, 28 Oct 2019 11:32:45 -0500
Message-Id: <20191028163256.8004-15-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191028163256.8004-1-robh@kernel.org>
References: <20191028163256.8004-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Convert the Xilinx host bridge to use the common
pci_parse_request_of_pci_ranges().

There's no need to assign the resources to a temporary list first. Just
use bridge->windows directly and remove all the temporary list handling.

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Andrew Murray <andrew.murray@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/pcie-xilinx.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx.c b/drivers/pci/controller/pcie-xilinx.c
index 5bf3af3b28e6..257702288787 100644
--- a/drivers/pci/controller/pcie-xilinx.c
+++ b/drivers/pci/controller/pcie-xilinx.c
@@ -619,8 +619,6 @@ static int xilinx_pcie_probe(struct platform_device *pdev)
 	struct pci_bus *bus, *child;
 	struct pci_host_bridge *bridge;
 	int err;
-	resource_size_t iobase = 0;
-	LIST_HEAD(res);
 
 	if (!dev->of_node)
 		return -ENODEV;
@@ -647,19 +645,12 @@ static int xilinx_pcie_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	err = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff, &res,
-						    &iobase);
+	err = pci_parse_request_of_pci_ranges(dev, &bridge->windows, NULL);
 	if (err) {
 		dev_err(dev, "Getting bridge resources failed\n");
 		return err;
 	}
 
-	err = devm_request_pci_bus_resources(dev, &res);
-	if (err)
-		goto error;
-
-
-	list_splice_init(&res, &bridge->windows);
 	bridge->dev.parent = dev;
 	bridge->sysdata = port;
 	bridge->busnr = 0;
@@ -673,7 +664,7 @@ static int xilinx_pcie_probe(struct platform_device *pdev)
 #endif
 	err = pci_scan_root_bus_bridge(bridge);
 	if (err < 0)
-		goto error;
+		return err;
 
 	bus = bridge->bus;
 
@@ -682,10 +673,6 @@ static int xilinx_pcie_probe(struct platform_device *pdev)
 		pcie_bus_configure_settings(child);
 	pci_bus_add_devices(bus);
 	return 0;
-
-error:
-	pci_free_resource_list(&res);
-	return err;
 }
 
 static const struct of_device_id xilinx_pcie_of_match[] = {
-- 
2.20.1

