Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1837B4C6A6
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2019 07:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731490AbfFTFN5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jun 2019 01:13:57 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44659 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730815AbfFTFNy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jun 2019 01:13:54 -0400
Received: by mail-pf1-f193.google.com with SMTP id t16so951054pfe.11
        for <linux-pci@vger.kernel.org>; Wed, 19 Jun 2019 22:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=93pd9G4UIoBr8e0tvrz9C44+OnAylV1JTAk/uJtJYjk=;
        b=oo7A3kwoOK6VCYBLqyaL9S+XBir5vMHc4AzSTp8Dh5XTbhRQrmHlNiYhNXe8aGKimx
         J7RauecVI3mbpcEn0QVXx0N6NUZbX+Ep0D0uusXtSYABGaxjLighwAHdy8oNdTQoBoVC
         bcwaa/6qE+mARo3GHiwJ09fssO5Tz2Rs7U7+vmiddO6jvIzVbZLizwXBh4QwLJvLIv99
         eCwoXq9k1c352H1RevOjR81xKy88MLU9ASr0tGJv6T46ffidSBPOOwM2D2tGEIcMa2eb
         l5TmgW4nHdf/A+kBWA+B8mSiRBk3V5wJ7LTm8i7VxyhdGiDWc+qM8OErGKeGopbkU/r0
         bFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=93pd9G4UIoBr8e0tvrz9C44+OnAylV1JTAk/uJtJYjk=;
        b=Xi8OEA/uRWqfOHYUd8LrUfpo8QPUkvrUGbvFv33z9hX3nA2GDKp+QyfryaaNvh/dVJ
         82zUWfuvnVJO2TK3BZ2UGzUPMjCl1Oee9MktxVrNGIum3gSSwWzrVowd/ldscyYn3NWY
         8bZckCML6s+/3I0RaDJPmFMKs5p4wElDUWxJc3JFCfIzqgtxHggXt5bksbL3Jne5xYQ3
         zUA6TbD/AyAP5XJ3MJwF7w+199tg/62fJHTUo2RhxcQgVU2u+LqC6XBGkzGsSgHeNRt9
         NChwK7Z5AM7BpR5kIe6I3ynVohJ5c/YWTEgfm8jLh4sMCQHMdBQ4zm/acAha+d3YfAXx
         M43w==
X-Gm-Message-State: APjAAAXkXEDt8FeYCxwQYf7yz8WoQTp69MBBECdMVN3mA6C1A3TqRIA1
        JN/Pxl8AM/kpQEhspKmRWT+Mew==
X-Google-Smtp-Source: APXvYqyUdnoXHD0MZr35aFY9ap745bjtRuh4g+87m2KYH4pWO+nAlZ1xGOtU603AW3GnIk1/gjmKYQ==
X-Received: by 2002:a62:e910:: with SMTP id j16mr27077606pfh.123.1561007633635;
        Wed, 19 Jun 2019 22:13:53 -0700 (PDT)
Received: from limbo.local (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.gmail.com with ESMTPSA id j2sm26383423pfn.135.2019.06.19.22.13.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 22:13:53 -0700 (PDT)
From:   Daniel Drake <drake@endlessm.com>
To:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
Cc:     linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com, linux-ide@vger.kernel.org, linux@endlessm.com,
        linux-kernel@vger.kernel.org, hare@suse.de,
        alex.williamson@redhat.com, dan.j.williams@intel.com
Subject: [PATCH v2 2/5] nvme: rename "pci" operations to "mmio"
Date:   Thu, 20 Jun 2019 13:13:30 +0800
Message-Id: <20190620051333.2235-3-drake@endlessm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190620051333.2235-1-drake@endlessm.com>
References: <20190620051333.2235-1-drake@endlessm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Dan Williams <dan.j.williams@intel.com>

In preparation for adding a platform_device nvme host, rename to a more
generic "mmio" prefix.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Daniel Drake <drake@endlessm.com>
---
 drivers/nvme/host/pci.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 524d6bd6d095..42990b93349d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1108,7 +1108,7 @@ static int nvme_poll(struct blk_mq_hw_ctx *hctx)
 	return found;
 }
 
-static void nvme_pci_submit_async_event(struct nvme_ctrl *ctrl)
+static void nvme_mmio_submit_async_event(struct nvme_ctrl *ctrl)
 {
 	struct nvme_dev *dev = to_nvme_dev(ctrl);
 	struct nvme_queue *nvmeq = &dev->queues[0];
@@ -2448,7 +2448,7 @@ static void nvme_release_prp_pools(struct nvme_dev *dev)
 	dma_pool_destroy(dev->prp_small_pool);
 }
 
-static void nvme_pci_free_ctrl(struct nvme_ctrl *ctrl)
+static void nvme_mmio_free_ctrl(struct nvme_ctrl *ctrl)
 {
 	struct nvme_dev *dev = to_nvme_dev(ctrl);
 
@@ -2610,42 +2610,42 @@ static void nvme_remove_dead_ctrl_work(struct work_struct *work)
 	nvme_put_ctrl(&dev->ctrl);
 }
 
-static int nvme_pci_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val)
+static int nvme_mmio_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val)
 {
 	*val = readl(to_nvme_dev(ctrl)->bar + off);
 	return 0;
 }
 
-static int nvme_pci_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
+static int nvme_mmio_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
 {
 	writel(val, to_nvme_dev(ctrl)->bar + off);
 	return 0;
 }
 
-static int nvme_pci_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
+static int nvme_mmio_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
 {
 	*val = readq(to_nvme_dev(ctrl)->bar + off);
 	return 0;
 }
 
-static int nvme_pci_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
+static int nvme_mmio_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
 {
 	struct pci_dev *pdev = to_pci_dev(to_nvme_dev(ctrl)->dev);
 
 	return snprintf(buf, size, "%s", dev_name(&pdev->dev));
 }
 
-static const struct nvme_ctrl_ops nvme_pci_ctrl_ops = {
+static const struct nvme_ctrl_ops nvme_mmio_ctrl_ops = {
 	.name			= "pcie",
 	.module			= THIS_MODULE,
 	.flags			= NVME_F_METADATA_SUPPORTED |
 				  NVME_F_PCI_P2PDMA,
-	.reg_read32		= nvme_pci_reg_read32,
-	.reg_write32		= nvme_pci_reg_write32,
-	.reg_read64		= nvme_pci_reg_read64,
-	.free_ctrl		= nvme_pci_free_ctrl,
-	.submit_async_event	= nvme_pci_submit_async_event,
-	.get_address		= nvme_pci_get_address,
+	.reg_read32		= nvme_mmio_reg_read32,
+	.reg_write32		= nvme_mmio_reg_write32,
+	.reg_read64		= nvme_mmio_reg_read64,
+	.free_ctrl		= nvme_mmio_free_ctrl,
+	.submit_async_event	= nvme_mmio_submit_async_event,
+	.get_address		= nvme_mmio_get_address,
 };
 
 static int nvme_dev_map(struct nvme_dev *dev)
@@ -2758,7 +2758,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto release_pools;
 	}
 
-	result = nvme_init_ctrl(&dev->ctrl, &pdev->dev, &nvme_pci_ctrl_ops,
+	result = nvme_init_ctrl(&dev->ctrl, &pdev->dev, &nvme_mmio_ctrl_ops,
 			quirks);
 	if (result)
 		goto release_mempool;
-- 
2.20.1

