Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8F5D9AEF
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2019 22:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732715AbfJPUHR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Oct 2019 16:07:17 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39093 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732214AbfJPUHR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Oct 2019 16:07:17 -0400
Received: by mail-oi1-f196.google.com with SMTP id w144so119398oia.6;
        Wed, 16 Oct 2019 13:07:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/1oYAep1iMpZDyVd+bc5fdO9/WhUAJcxCL7Y+S+HNKM=;
        b=pQjaJs/sYVc4Wti02EsBI/+dmwt+YR7hMuqkKJC9EB5F40XeT9jCEpjNZaDMVJtu9Z
         z4FHAxs/2c2CjGCA6LJZmrE1XoM1PvURd7op3onjxZUtROEtw3HqQGKwA27ajZ8LS7LY
         7KT2WlorBe39idHSRhOvxW4j6FoNATLcKsFiIv7UCEpFFQ/uIq8qSEaRQCY602tFGFtP
         pqVG4qiwZbxOAS0fGGKMli58SFS+EFtYwSzdVhpvVLc2nntRpWxh4JKPbgsneoR96v4t
         ZZta+k/vKXdOOyBXE2kEamNql7IMH3ftRKYDIOjdgcVGKIWBqYFapgn1P8iaixHPpGJH
         A+iA==
X-Gm-Message-State: APjAAAUb+S7j5ApWv2QJ94/kYnaCLh2pBBT9QQ/wR1pscm6E4wDY+2em
        8Q/5xO5CSLl16XdEur9+dQ==
X-Google-Smtp-Source: APXvYqz66F2v4b5Ld2gp0cxp3wU06Hj5buWMISghPeAHsAtQ+/9CM9ObzMQbSYC2ymEYHYsz/zThqw==
X-Received: by 2002:aca:221a:: with SMTP id b26mr117376oic.86.1571256436526;
        Wed, 16 Oct 2019 13:07:16 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id a9sm7412463oie.7.2019.10.16.13.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 13:07:15 -0700 (PDT)
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
Subject: [PATCH v2 14/25] PCI: xilinx: Use pci_parse_request_of_pci_ranges()
Date:   Wed, 16 Oct 2019 15:06:36 -0500
Message-Id: <20191016200647.32050-15-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191016200647.32050-1-robh@kernel.org>
References: <20191016200647.32050-1-robh@kernel.org>
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
v2:
- New patch

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
