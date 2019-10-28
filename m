Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19BEBE7671
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2019 17:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391053AbfJ1QeB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Oct 2019 12:34:01 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36203 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729420AbfJ1QeB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Oct 2019 12:34:01 -0400
Received: by mail-ot1-f68.google.com with SMTP id c7so7186034otm.3;
        Mon, 28 Oct 2019 09:34:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5gD14iI8UpOKj376Bq/txSzTZsSs0VToSMrptEdmjdQ=;
        b=FXJu07jJTTBXvWYa9yBZ5TzlT+TAQnH9G7/tyeIZQk53OIMC4ISFwjF7VCFVi76LDi
         NMdp0+mXrEHXIRv83R+XPuBbZ3ixi2cV7suurM4C0DrmKQjtF9HgLUswL/gXlpZESDpZ
         QgNKjOvVBWeGabp/Bfphf4LMn/w5EEAClQCsEZOYpFfx9SpxxvSWtsJ2bb0WrielsGIx
         61ckOTh86bSAP7UPWLShfU06NwZIs2no/7jPGy0OV9ZJVxvqPKWuorbIYOQvIVryP0YM
         0IBIVwwWl8l+zvSOKGF0+mbNzPXyfohS+uExCQVjIC1hXZYoJvLlkVazZE6dNopZ6CuI
         bvwA==
X-Gm-Message-State: APjAAAUi9gYkWHsBG1642/LyrBvcW6743Hj5ysMEkRgg5O40Rd/5eMzb
        YqnBFVXaAYKa4lN0tJStqQ==
X-Google-Smtp-Source: APXvYqxwQvVW18ni2MGlR3yza3cM3F7fWkGTz5dS8pb+bIhSeEI2GqTMRaA5bo4tECabCiP8MTGJZA==
X-Received: by 2002:a9d:4616:: with SMTP id y22mr13801201ote.319.1572280439895;
        Mon, 28 Oct 2019 09:33:59 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id e186sm354991oia.47.2019.10.28.09.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 09:33:59 -0700 (PDT)
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
Subject: [PATCH v3 25/25] PCI: Make devm_of_pci_get_host_bridge_resources() static
Date:   Mon, 28 Oct 2019 11:32:56 -0500
Message-Id: <20191028163256.8004-26-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191028163256.8004-1-robh@kernel.org>
References: <20191028163256.8004-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Now that all the PCI host drivers are using pci_parse_request_of_pci_ranges(),
make devm_of_pci_get_host_bridge_resources() static.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/of.c  |  5 +----
 drivers/pci/pci.h | 17 -----------------
 2 files changed, 1 insertion(+), 21 deletions(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 0b1e4623dfcf..00e4b9fcb41d 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -236,7 +236,6 @@ void of_pci_check_probe_only(void)
 }
 EXPORT_SYMBOL_GPL(of_pci_check_probe_only);
 
-#if defined(CONFIG_OF_ADDRESS)
 /**
  * devm_of_pci_get_host_bridge_resources() - Resource-managed parsing of PCI
  *                                           host bridge resources from DT
@@ -255,7 +254,7 @@ EXPORT_SYMBOL_GPL(of_pci_check_probe_only);
  * It returns zero if the range parsing has been successful or a standard error
  * value if it failed.
  */
-int devm_of_pci_get_host_bridge_resources(struct device *dev,
+static int devm_of_pci_get_host_bridge_resources(struct device *dev,
 			unsigned char busno, unsigned char bus_max,
 			struct list_head *resources,
 			struct list_head *ib_resources,
@@ -384,8 +383,6 @@ int devm_of_pci_get_host_bridge_resources(struct device *dev,
 	pci_free_resource_list(resources);
 	return err;
 }
-EXPORT_SYMBOL_GPL(devm_of_pci_get_host_bridge_resources);
-#endif /* CONFIG_OF_ADDRESS */
 
 #if IS_ENABLED(CONFIG_OF_IRQ)
 /**
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 6692c4fe4290..118a4974537b 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -630,23 +630,6 @@ static inline void pci_set_bus_of_node(struct pci_bus *bus) { }
 static inline void pci_release_bus_of_node(struct pci_bus *bus) { }
 #endif /* CONFIG_OF */
 
-#if defined(CONFIG_OF_ADDRESS)
-int devm_of_pci_get_host_bridge_resources(struct device *dev,
-			unsigned char busno, unsigned char bus_max,
-			struct list_head *resources,
-			struct list_head *ib_resources,
-			resource_size_t *io_base);
-#else
-static inline int devm_of_pci_get_host_bridge_resources(struct device *dev,
-			unsigned char busno, unsigned char bus_max,
-			struct list_head *resources,
-			struct list_head *ib_resources,
-			resource_size_t *io_base)
-{
-	return -EINVAL;
-}
-#endif
-
 #ifdef CONFIG_PCIEAER
 void pci_no_aer(void);
 void pci_aer_init(struct pci_dev *dev);
-- 
2.20.1

