Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8351D2FD311
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jan 2021 15:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389210AbhATOnA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Jan 2021 09:43:00 -0500
Received: from m12-12.163.com ([220.181.12.12]:47933 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390764AbhATOlW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Jan 2021 09:41:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=y8Z+jU1IE/vKH8MMhw
        F/F1/xZhIIlIreDEVa8fPEHRM=; b=n8biHLN1jMTnSd/CT269uO2McS1u8rKODW
        klv1XG5VUTGPFf7hk6Jwg3YQk777iOca3vrtmwfV7aKD7ISjceCaM20Fd+LUMeao
        3ilKmtOBcjmxuxF7Dyqd/t7H5D8BFCa3rQIY3vYffAhWL7bEZZMQRjHujkDhPbA1
        +PAL0afpI=
Received: from localhost.localdomain (unknown [111.201.134.89])
        by smtp8 (Coremail) with SMTP id DMCowAC3Nvs7QAhgoibuMw--.3261S4;
        Wed, 20 Jan 2021 22:37:50 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Pan Bian <bianpan2016@163.com>
Subject: [PATCH] PCI: xilinx-cpm: Fix reference count leak on error path
Date:   Wed, 20 Jan 2021 06:37:45 -0800
Message-Id: <20210120143745.699-1-bianpan2016@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: DMCowAC3Nvs7QAhgoibuMw--.3261S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7JF15uFWUZF4ruw1rAw1DJrb_yoW3urX_uw
        1UZF1xur4UCryfJr1vyrWSvr9Yyas7Xwn7KFn3tF13Aa9FgryfZr97A398XryrCrWfJF9r
        Ar90yay7CFyUCjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjYiiPUUUUU==
X-Originating-IP: [111.201.134.89]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/xtbBzx4gclaD9ynmfAAAsS
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Also drop the reference count of the node on error path.

Fixes: 508f610648b9 ("PCI: xilinx-cpm: Add Versal CPM Root Port driver")
Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 drivers/pci/controller/pcie-xilinx-cpm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c b/drivers/pci/controller/pcie-xilinx-cpm.c
index f92e0152e65e..67937facd90c 100644
--- a/drivers/pci/controller/pcie-xilinx-cpm.c
+++ b/drivers/pci/controller/pcie-xilinx-cpm.c
@@ -404,6 +404,7 @@ static int xilinx_cpm_pcie_init_irq_domain(struct xilinx_cpm_pcie_port *port)
 	return 0;
 out:
 	xilinx_cpm_free_irq_domains(port);
+	of_node_put(pcie_intc_node);
 	dev_err(dev, "Failed to allocate IRQ domains\n");
 
 	return -ENOMEM;
-- 
2.17.1


