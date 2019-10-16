Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 955DBD9AF1
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2019 22:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732860AbfJPUHU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Oct 2019 16:07:20 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36225 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732749AbfJPUHU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Oct 2019 16:07:20 -0400
Received: by mail-oi1-f193.google.com with SMTP id k20so136013oih.3;
        Wed, 16 Oct 2019 13:07:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+lDUo/HCLyrc0sWOGTnz5id2tGBLQKtkLPjhxgUhPzY=;
        b=MK+QssY2WfDlFqwFCCAyHqNlrcPgH41R9UvCI0eou1JUMjO1EedR89h/NcSK2LkRUa
         ViWqC+HeysntLyn/iRndZuc4DGr1U885+u1Tq2Ol5yyg/n+fSt/ZnK6sVgPyRBxFajXa
         +vQio2kDqw4FH1Ro7O3mO4D37MgwCybkmYVe79vlwXJbDppbJZtCMFnqCsfjbhLAbvEd
         8T8fhBMn5tmg+2dcBGtFklLcaWyP5iIUJKN4ep81lKu1TWZVgsC6TI+yQ2d47qLhclUH
         3sWU/lI25gRTj+2YP9Xj8RG9tUjbGnlSvWSKMi+srWZ1eoo7OW6hwgDCim7HNd2TFYNF
         FfRg==
X-Gm-Message-State: APjAAAX2AJ68BipVoOeehKrEqyfAp3bB4z9gopnmkg6IGKpLYXQ94BSY
        K7G2N/8U/lLd5BT0m+s1AQ==
X-Google-Smtp-Source: APXvYqyAG5FcM4PQq9OSa73PqrKFfTA6OVfMPy95H504g8Gj6pQ81a+5/Od2e9kgvPtJjJw7yifKmA==
X-Received: by 2002:aca:df87:: with SMTP id w129mr120106oig.50.1571256438533;
        Wed, 16 Oct 2019 13:07:18 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id a9sm7412463oie.7.2019.10.16.13.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 13:07:17 -0700 (PDT)
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
Subject: [PATCH v2 15/25] PCI: xilinx-nwl: Use pci_parse_request_of_pci_ranges()
Date:   Wed, 16 Oct 2019 15:06:37 -0500
Message-Id: <20191016200647.32050-16-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191016200647.32050-1-robh@kernel.org>
References: <20191016200647.32050-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Convert the xilinx-nwl host bridge to use the common
pci_parse_request_of_pci_ranges().

There's no need to assign the resources to a temporary list first. Just
use bridge->windows directly and remove all the temporary list handling.

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Andrew Murray <andrew.murray@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
- New patch

 drivers/pci/controller/pcie-xilinx-nwl.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index 45c0f344ccd1..e135a4b60489 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -821,8 +821,6 @@ static int nwl_pcie_probe(struct platform_device *pdev)
 	struct pci_bus *child;
 	struct pci_host_bridge *bridge;
 	int err;
-	resource_size_t iobase = 0;
-	LIST_HEAD(res);

 	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
 	if (!bridge)
@@ -845,24 +843,18 @@ static int nwl_pcie_probe(struct platform_device *pdev)
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
 	err = nwl_pcie_init_irq_domain(pcie);
 	if (err) {
 		dev_err(dev, "Failed creating IRQ Domain\n");
-		goto error;
+		return err;
 	}

-	list_splice_init(&res, &bridge->windows);
 	bridge->dev.parent = dev;
 	bridge->sysdata = pcie;
 	bridge->busnr = pcie->root_busno;
@@ -874,13 +866,13 @@ static int nwl_pcie_probe(struct platform_device *pdev)
 		err = nwl_pcie_enable_msi(pcie);
 		if (err < 0) {
 			dev_err(dev, "failed to enable MSI support: %d\n", err);
-			goto error;
+			return err;
 		}
 	}

 	err = pci_scan_root_bus_bridge(bridge);
 	if (err)
-		goto error;
+		return err;

 	bus = bridge->bus;

@@ -889,10 +881,6 @@ static int nwl_pcie_probe(struct platform_device *pdev)
 		pcie_bus_configure_settings(child);
 	pci_bus_add_devices(bus);
 	return 0;
-
-error:
-	pci_free_resource_list(&res);
-	return err;
 }

 static struct platform_driver nwl_pcie_driver = {
--
2.20.1
