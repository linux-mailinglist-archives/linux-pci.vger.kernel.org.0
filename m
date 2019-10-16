Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01D3FD9AF6
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2019 22:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732948AbfJPUHY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Oct 2019 16:07:24 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43782 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732749AbfJPUHY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Oct 2019 16:07:24 -0400
Received: by mail-ot1-f68.google.com with SMTP id o44so21291058ota.10;
        Wed, 16 Oct 2019 13:07:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8EjZCMf9X25YL2xnDGvatS6WOhekTnEbr44pTFr9BnI=;
        b=Pc14sNLH2MYPntKCUpHbKC9ns5k0COm1oQkSEHK//7f7L6j4H/Fi3jyffoO/gCqWJ+
         0hej7SiV6x0vrDfN28vds8gzTplnAHVCuKsDyDxMmMVsS/vpxIgrYkcjR4svO8l5UQTX
         Yc8ZTVdrjKDnJRqb/FlifI4GEOd1LyajFhn2yPyT49Xqc9T2yzY+92twr115WR4+NN+S
         6t/eEp1YFLn5VAJf+PaZcJh9flYnWd7uTAgOrVa95LyJ3HkqWewreIr0Y/8mEiUrRVjt
         /60MppiGMQpJDHFdiMVsHM1wIzv+IY80IH0hUj5E09EdwegReSqPIFMvCoOToW+k2yEr
         OsBQ==
X-Gm-Message-State: APjAAAWv86skolw6qfIlCYbccBQLAqhOPE55rawHnY6SU+pT7+l2xpjr
        6zSidWf4lfr5y2vmAC0+ag==
X-Google-Smtp-Source: APXvYqzTJeYoQM+BkZM8HRDuXdjqrFMtTYAuFWBkh10dsGSfzyliazEsJrxYjIRJ2m4HiNIDFy9TSw==
X-Received: by 2002:a9d:5914:: with SMTP id t20mr35250oth.344.1571256442080;
        Wed, 16 Oct 2019 13:07:22 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id a9sm7412463oie.7.2019.10.16.13.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 13:07:21 -0700 (PDT)
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
Subject: [PATCH v2 17/25] PCI: versatile: Remove usage of PHYS_OFFSET
Date:   Wed, 16 Oct 2019 15:06:39 -0500
Message-Id: <20191016200647.32050-18-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191016200647.32050-1-robh@kernel.org>
References: <20191016200647.32050-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PHYS_OFFSET is not universally defined on all arches and using it prevents
enabling COMPILE_TEST. PAGE_OFFSET and __pa() are always available, so use
them to get the physical start of memory address.

This should have probably used 'dma-ranges' to get the address, but we
don't want to force a DT update to do that. At least in QEMU, the SMAP
registers have no effect (or perhaps the only value that is handled is 0).

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Andrew Murray <andrew.murray@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
- New patch to fix build failure on some arches.

 drivers/pci/controller/pci-versatile.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pci-versatile.c b/drivers/pci/controller/pci-versatile.c
index 18697f2ea345..eae1b859990b 100644
--- a/drivers/pci/controller/pci-versatile.c
+++ b/drivers/pci/controller/pci-versatile.c
@@ -99,7 +99,7 @@ static int versatile_pci_probe(struct platform_device *pdev)
 	resource_list_for_each_entry(entry, &bridge->windows) {
 		if (resource_type(entry->res) == IORESOURCE_MEM) {
 			writel(entry->res->start >> 28, PCI_IMAP(mem));
-			writel(PHYS_OFFSET >> 28, PCI_SMAP(mem));
+			writel(__pa(PAGE_OFFSET) >> 28, PCI_SMAP(mem));
 			mem++;
 		}
 	}
@@ -136,9 +136,9 @@ static int versatile_pci_probe(struct platform_device *pdev)
 	/*
 	 * Configure the PCI inbound memory windows to be 1:1 mapped to SDRAM
 	 */
-	writel(PHYS_OFFSET, local_pci_cfg_base + PCI_BASE_ADDRESS_0);
-	writel(PHYS_OFFSET, local_pci_cfg_base + PCI_BASE_ADDRESS_1);
-	writel(PHYS_OFFSET, local_pci_cfg_base + PCI_BASE_ADDRESS_2);
+	writel(__pa(PAGE_OFFSET), local_pci_cfg_base + PCI_BASE_ADDRESS_0);
+	writel(__pa(PAGE_OFFSET), local_pci_cfg_base + PCI_BASE_ADDRESS_1);
+	writel(__pa(PAGE_OFFSET), local_pci_cfg_base + PCI_BASE_ADDRESS_2);

 	/*
 	 * For many years the kernel and QEMU were symbiotically buggy
--
2.20.1
