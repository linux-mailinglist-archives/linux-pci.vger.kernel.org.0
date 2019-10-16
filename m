Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82E6AD9AF4
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2019 22:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732815AbfJPUHV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Oct 2019 16:07:21 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39097 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732760AbfJPUHV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Oct 2019 16:07:21 -0400
Received: by mail-oi1-f193.google.com with SMTP id w144so119570oia.6;
        Wed, 16 Oct 2019 13:07:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EUvNXVMR7ueFc2YPhgs8zP4YzcDIk6QWtKI1XB6VZ+Y=;
        b=BQbalzCmikHp/Chrw0anU8Yd7ELKqvX+GzlfoIHlgDV2TqEOick5Q1XNDKerCIYOpt
         Iaii1xJkEJtBklQ6l7FL8unbXQwxLg1ZaBeiJ9f0v6WusNvrc3+qXjWWgHvqO4lHgP8Q
         zSWBMP0SXjj17tr7jbCBJeH252scUXUTOlSAom4qZmEpJxi4m2DorHzgqeZE69ijsyzz
         bp2HJPviqm/cuvbBLRtVazHSfLLJd4Fd6xnrhsc6f/n9H4fcPSkUM2iM9UWRsVeuGZEE
         ZtspxnBudw1wPZJcShy9mSe6Ky+cKRxz5QNxglNwo3M8SPeHZ/wtl0zRDaPfDL7BNL54
         HRkg==
X-Gm-Message-State: APjAAAU7mJjkGEjiLEMZQIYb3nPoUo8MlcCyRvK7m210uEEHKq1LQdGf
        N6y1hI7bWk+I75gbi7so7w==
X-Google-Smtp-Source: APXvYqy/2Fy9rR5BzYiQ6RiCmXGzv9E3TVFk2RmyQBRWYVoIxeJcIYcMHXgrMkV0fEcNz2sBt7+DZg==
X-Received: by 2002:aca:b9d7:: with SMTP id j206mr112019oif.112.1571256440272;
        Wed, 16 Oct 2019 13:07:20 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id a9sm7412463oie.7.2019.10.16.13.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 13:07:19 -0700 (PDT)
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
Subject: [PATCH v2 16/25] PCI: versatile: Use pci_parse_request_of_pci_ranges()
Date:   Wed, 16 Oct 2019 15:06:38 -0500
Message-Id: <20191016200647.32050-17-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191016200647.32050-1-robh@kernel.org>
References: <20191016200647.32050-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Convert ARM Versatile host bridge to use the common
pci_parse_request_of_pci_ranges().

There's no need to assign the resources to a temporary list first. Just
use bridge->windows directly and remove all the temporary list handling.

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
- Fix 'mem' initial value to 1
- Remove temporary resource list
---
 drivers/pci/controller/pci-versatile.c | 64 +++++---------------------
 1 file changed, 11 insertions(+), 53 deletions(-)

diff --git a/drivers/pci/controller/pci-versatile.c b/drivers/pci/controller/pci-versatile.c
index f59ad2728c0b..18697f2ea345 100644
--- a/drivers/pci/controller/pci-versatile.c
+++ b/drivers/pci/controller/pci-versatile.c
@@ -62,65 +62,16 @@ static struct pci_ops pci_versatile_ops = {
 	.write	= pci_generic_config_write,
 };
 
-static int versatile_pci_parse_request_of_pci_ranges(struct device *dev,
-						     struct list_head *res)
-{
-	int err, mem = 1, res_valid = 0;
-	resource_size_t iobase;
-	struct resource_entry *win, *tmp;
-
-	err = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff, res, &iobase);
-	if (err)
-		return err;
-
-	err = devm_request_pci_bus_resources(dev, res);
-	if (err)
-		goto out_release_res;
-
-	resource_list_for_each_entry_safe(win, tmp, res) {
-		struct resource *res = win->res;
-
-		switch (resource_type(res)) {
-		case IORESOURCE_IO:
-			err = devm_pci_remap_iospace(dev, res, iobase);
-			if (err) {
-				dev_warn(dev, "error %d: failed to map resource %pR\n",
-					 err, res);
-				resource_list_destroy_entry(win);
-			}
-			break;
-		case IORESOURCE_MEM:
-			res_valid |= !(res->flags & IORESOURCE_PREFETCH);
-
-			writel(res->start >> 28, PCI_IMAP(mem));
-			writel(PHYS_OFFSET >> 28, PCI_SMAP(mem));
-			mem++;
-
-			break;
-		}
-	}
-
-	if (res_valid)
-		return 0;
-
-	dev_err(dev, "non-prefetchable memory resource required\n");
-	err = -EINVAL;
-
-out_release_res:
-	pci_free_resource_list(res);
-	return err;
-}
-
 static int versatile_pci_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct resource *res;
-	int ret, i, myslot = -1;
+	struct resource_entry *entry;
+	int ret, i, myslot = -1, mem = 1;
 	u32 val;
 	void __iomem *local_pci_cfg_base;
 	struct pci_bus *bus, *child;
 	struct pci_host_bridge *bridge;
-	LIST_HEAD(pci_res);
 
 	bridge = devm_pci_alloc_host_bridge(dev, 0);
 	if (!bridge)
@@ -141,10 +92,18 @@ static int versatile_pci_probe(struct platform_device *pdev)
 	if (IS_ERR(versatile_cfg_base[1]))
 		return PTR_ERR(versatile_cfg_base[1]);
 
-	ret = versatile_pci_parse_request_of_pci_ranges(dev, &pci_res);
+	ret = pci_parse_request_of_pci_ranges(dev, &bridge->windows, NULL);
 	if (ret)
 		return ret;
 
+	resource_list_for_each_entry(entry, &bridge->windows) {
+		if (resource_type(entry->res) == IORESOURCE_MEM) {
+			writel(entry->res->start >> 28, PCI_IMAP(mem));
+			writel(PHYS_OFFSET >> 28, PCI_SMAP(mem));
+			mem++;
+		}
+	}
+
 	/*
 	 * We need to discover the PCI core first to configure itself
 	 * before the main PCI probing is performed
@@ -197,7 +156,6 @@ static int versatile_pci_probe(struct platform_device *pdev)
 	pci_add_flags(PCI_ENABLE_PROC_DOMAINS);
 	pci_add_flags(PCI_REASSIGN_ALL_BUS);
 
-	list_splice_init(&pci_res, &bridge->windows);
 	bridge->dev.parent = dev;
 	bridge->sysdata = NULL;
 	bridge->busnr = 0;
-- 
2.20.1

