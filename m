Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07308E7640
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2019 17:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732964AbfJ1QdM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Oct 2019 12:33:12 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40547 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730772AbfJ1QdM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Oct 2019 12:33:12 -0400
Received: by mail-ot1-f66.google.com with SMTP id d8so7160131otc.7;
        Mon, 28 Oct 2019 09:33:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/baIkufFp5mlTrEe7IeynKuDaRx91+3hOWgRDUhWFkU=;
        b=hIOcsE67OKf4cc/bV6KNN2hhWpEjJRzdubQ3ML9c6qStu84Vez/s3VJAfXd/j5VX/N
         3qX7nXFNCPDfekk4/FKUmoXdCyYrIe7wHc4uzmNY8WHMZDtq0Yw8nmhcgFMKVycfICkh
         6AE1lQH7zSUBWSRvbcU03zGqEhaAc0A9Osuf0k8bF9XmSPS2FAha73hoxmWih3mpvKDL
         FZKVvV3IXcoUIqBU8v/hBiGz0SZSW6DvfCka3mw34n6A3WGn27pM05XzqK9Faz0k/poq
         EGdBUFvIlkEzg5l6n0PeuLJvtwgIVU6m216Cz3BjwFEs9Z0ob1pN29J/58xEy1i88Y2Q
         vZYw==
X-Gm-Message-State: APjAAAX9Ax8ENUTbZ/Yf2i9mKZ3u/4CaCHJiNrSGZfDpvzejICQnfeo0
        yRv9rND6HlB6BwiiQxqTQA==
X-Google-Smtp-Source: APXvYqx+LIHYOqhOeHGYYTJWv4RVEy0aq3Lc+2gCsX7tadvpjU/gR9g+Z64Jn7VX8cIew+VZHzINfQ==
X-Received: by 2002:a9d:4a9c:: with SMTP id i28mr13723432otf.169.1572280390819;
        Mon, 28 Oct 2019 09:33:10 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id e186sm354991oia.47.2019.10.28.09.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 09:33:08 -0700 (PDT)
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
Subject: [PATCH v3 05/25] PCI: dwc: Use pci_parse_request_of_pci_ranges()
Date:   Mon, 28 Oct 2019 11:32:36 -0500
Message-Id: <20191028163256.8004-6-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191028163256.8004-1-robh@kernel.org>
References: <20191028163256.8004-1-robh@kernel.org>
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

