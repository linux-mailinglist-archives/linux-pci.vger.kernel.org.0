Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 617C8E764F
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2019 17:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390994AbfJ1Qdc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Oct 2019 12:33:32 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40578 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730772AbfJ1Qdc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Oct 2019 12:33:32 -0400
Received: by mail-ot1-f68.google.com with SMTP id d8so7161239otc.7;
        Mon, 28 Oct 2019 09:33:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mxMsu5buQ7iHumyqQOK7pePSEYHVrJpDScdqrZRoUwA=;
        b=eSRpAyN4ijakW4DI9taAz4SeK5h/wZDh5vsH61Jxl/BURZuh6q9FrIgofiHb2cgyOX
         YV9gE+r5vjp8vpQOoocIr2MIfOm3EbfoqfKzfonVOiEt2//dP8wUFxFUEO3ICwFk0Bs3
         lM84V/wn616CS73lvHsfqUuJrBCsr80U+zgZW9tP2d+g/4ESTqQwDORXtbtvXqEkGRXk
         RuyXRwUQtd+1QCCGYmqifYydw0NOd+dzAf2s2soQ2mY5b2ciNdIYYnKnyXN+p7dqvJH2
         zzDylGDCJW723SvzQgdZVpPUJjAs90LjmVOiY3GYMy96K06hySf1hx+7m5IHpbEYmDFx
         2sZQ==
X-Gm-Message-State: APjAAAW2F2a+VaaF8q16E9xSFVglJz/PKUS3wPhb30Ui2PivvDb4oM2E
        X+JCZX1qMP9+6oNOZ7W16Q==
X-Google-Smtp-Source: APXvYqxOkIeS4BmL7xvWW0X3OFJHqHE79e6/UgYAXh9+BdleE4h11RfX6HaRFlUyGOi9IbQqg7eeRw==
X-Received: by 2002:a9d:4616:: with SMTP id y22mr13799435ote.319.1572280411103;
        Mon, 28 Oct 2019 09:33:31 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id e186sm354991oia.47.2019.10.28.09.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 09:33:30 -0700 (PDT)
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
Subject: [PATCH v3 12/25] PCI: v3-semi: Use pci_parse_request_of_pci_ranges()
Date:   Mon, 28 Oct 2019 11:32:43 -0500
Message-Id: <20191028163256.8004-13-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191028163256.8004-1-robh@kernel.org>
References: <20191028163256.8004-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Convert V3 host bridge to use the common
pci_parse_request_of_pci_ranges().

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Andrew Murray <andrew.murray@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/pci-v3-semi.c | 35 +++++-----------------------
 1 file changed, 6 insertions(+), 29 deletions(-)

diff --git a/drivers/pci/controller/pci-v3-semi.c b/drivers/pci/controller/pci-v3-semi.c
index d219404bad92..96677520f6c1 100644
--- a/drivers/pci/controller/pci-v3-semi.c
+++ b/drivers/pci/controller/pci-v3-semi.c
@@ -241,10 +241,8 @@ struct v3_pci {
 	void __iomem *config_base;
 	struct pci_bus *bus;
 	u32 config_mem;
-	u32 io_mem;
 	u32 non_pre_mem;
 	u32 pre_mem;
-	phys_addr_t io_bus_addr;
 	phys_addr_t non_pre_bus_addr;
 	phys_addr_t pre_bus_addr;
 	struct regmap *map;
@@ -520,35 +518,22 @@ static int v3_integrator_init(struct v3_pci *v3)
 }
 
 static int v3_pci_setup_resource(struct v3_pci *v3,
-				 resource_size_t io_base,
 				 struct pci_host_bridge *host,
 				 struct resource_entry *win)
 {
 	struct device *dev = v3->dev;
 	struct resource *mem;
 	struct resource *io;
-	int ret;
 
 	switch (resource_type(win->res)) {
 	case IORESOURCE_IO:
 		io = win->res;
-		io->name = "V3 PCI I/O";
-		v3->io_mem = io_base;
-		v3->io_bus_addr = io->start - win->offset;
-		dev_dbg(dev, "I/O window %pR, bus addr %pap\n",
-			io, &v3->io_bus_addr);
-		ret = devm_pci_remap_iospace(dev, io, io_base);
-		if (ret) {
-			dev_warn(dev,
-				 "error %d: failed to map resource %pR\n",
-				 ret, io);
-			return ret;
-		}
+
 		/* Setup window 2 - PCI I/O */
-		writel(v3_addr_to_lb_base2(v3->io_mem) |
+		writel(v3_addr_to_lb_base2(pci_pio_to_address(io->start)) |
 		       V3_LB_BASE2_ENABLE,
 		       v3->base + V3_LB_BASE2);
-		writew(v3_addr_to_lb_map2(v3->io_bus_addr),
+		writew(v3_addr_to_lb_map2(io->start - win->offset),
 		       v3->base + V3_LB_MAP2);
 		break;
 	case IORESOURCE_MEM:
@@ -732,7 +717,6 @@ static int v3_pci_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
-	resource_size_t io_base;
 	struct resource *regs;
 	struct resource_entry *win;
 	struct v3_pci *v3;
@@ -741,7 +725,6 @@ static int v3_pci_probe(struct platform_device *pdev)
 	u16 val;
 	int irq;
 	int ret;
-	LIST_HEAD(res);
 
 	host = pci_alloc_host_bridge(sizeof(*v3));
 	if (!host)
@@ -793,12 +776,7 @@ static int v3_pci_probe(struct platform_device *pdev)
 	if (IS_ERR(v3->config_base))
 		return PTR_ERR(v3->config_base);
 
-	ret = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff, &res,
-						    &io_base);
-	if (ret)
-		return ret;
-
-	ret = devm_request_pci_bus_resources(dev, &res);
+	ret = pci_parse_request_of_pci_ranges(dev, &host->windows, NULL);
 	if (ret)
 		return ret;
 
@@ -852,8 +830,8 @@ static int v3_pci_probe(struct platform_device *pdev)
 	writew(val, v3->base + V3_PCI_CMD);
 
 	/* Get the I/O and memory ranges from DT */
-	resource_list_for_each_entry(win, &res) {
-		ret = v3_pci_setup_resource(v3, io_base, host, win);
+	resource_list_for_each_entry(win, &host->windows) {
+		ret = v3_pci_setup_resource(v3, host, win);
 		if (ret) {
 			dev_err(dev, "error setting up resources\n");
 			return ret;
@@ -931,7 +909,6 @@ static int v3_pci_probe(struct platform_device *pdev)
 	val |= V3_SYSTEM_M_LOCK;
 	writew(val, v3->base + V3_SYSTEM);
 
-	list_splice_init(&res, &host->windows);
 	ret = pci_scan_root_bus_bridge(host);
 	if (ret) {
 		dev_err(dev, "failed to register host: %d\n", ret);
-- 
2.20.1

