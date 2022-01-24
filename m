Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7DDC497F44
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jan 2022 13:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239500AbiAXMVu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jan 2022 07:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239407AbiAXMVp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jan 2022 07:21:45 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5325C06173B;
        Mon, 24 Jan 2022 04:21:44 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id a13so13231251wrh.9;
        Mon, 24 Jan 2022 04:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yNk3iptcaf318dqFvmgFI2Cy5wTzaw5Fh5cUP/iskfI=;
        b=MzO9AUc2ANAyPODg7OE6uf3n3mk8jAUUPoucXqJIgb8W5HF3uINCqAKFWGOfc/howo
         dZvdbFPLMKwN5ZmLKaUYyYrxw7pG87h0sCgUqaFFXaA8Gy+0d91NBChxVDZaUs3ri1ug
         2u84lJUDxeV6AyifKzjZadF3iLiDH1yhfzOmCrhV+f9i0CUkfirDpurTgpOBcYhXGEIh
         Tq7xrRFoNhnW0tdF4Fk/QG4kwzedYtal6sXiweCv7vL5x0//SCXHFVfGZuL6B8WodgHe
         kDuXT8vHwvWDzBiGAko57Noxy2Iw70ZQEZhbs+GYrgsoJXDTGQwBX+8Rc4J31DQ8xDex
         yHwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yNk3iptcaf318dqFvmgFI2Cy5wTzaw5Fh5cUP/iskfI=;
        b=QwjR+VnNIwW2Kx5aPe5T+6ELdX4iw4uST4tztY/jP4YI08HXf4K5MUyWkp1AjaXh4c
         B2gILsRPAZeeHS/tMRYXWlEs988TvEgRv56odtJFcPN89hrwf8p3caN4iPhRYVJ0dQcC
         XK6/L+cZRQ24ngRxFzKuUqPoahN9cObIl2djDrvX5+OJH4+Kj72bKez7Sv7dtid/A1kd
         YScDL3Jk/hcL0mjwBTCGN8FRg1A4zMrs9lry2kc/gNIQgGx6B7q29nPGJS+Yeyh3of3S
         6cosPfSG6CkkMw2o5VzedVachxswbR1AYKeDFiQ+7OT0R8P+bk5f6Xit1BCHUsIfdUXo
         NWIg==
X-Gm-Message-State: AOAM533bJSOq1qdtPG/89CUJ6VcgW0ZwtHtzuuHgFdHWLXlVvCiw5+v2
        Z/0xu2NEHDNNlr6ck6p630cwFyO9pRU=
X-Google-Smtp-Source: ABdhPJxpFZOXc2gQIkGEiuUZRHxO0E1YI7AvQ9fqIfJ4409KMCRS1KZ2BLTx5rAooWuz0vvYxMIg2A==
X-Received: by 2002:adf:f90c:: with SMTP id b12mr14161536wrr.379.1643026903103;
        Mon, 24 Jan 2022 04:21:43 -0800 (PST)
Received: from localhost.localdomain.at (62-178-82-229.cable.dynamic.surfer.at. [62.178.82.229])
        by smtp.gmail.com with ESMTPSA id w8sm13984499wre.83.2022.01.24.04.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 04:21:42 -0800 (PST)
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] Revert "PCI: j721e: Drop redundant struct device *"
Date:   Mon, 24 Jan 2022 13:21:22 +0100
Message-Id: <20220124122132.435743-1-christian.gmeiner@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This reverts commit 19e863828acf6d8ac8475ba1fd93c0fe17fdc4ef.

Fixes the following oops:
 Unable to handle kernel NULL pointer dereference at virtual address 0000000000000010
 Internal error: Oops: 96000004 [#1] PREEMPT SMP
 Modules linked in:
 CPU: 1 PID: 7 Comm: kworker/u4:0 Not tainted 5.17.0-rc1-00086-ge38b27816fea-dirty #71
 Hardware name: CPE0108 (DT)
 Workqueue: events_unbound deferred_probe_work_func
 pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : j721e_pcie_probe+0x184/0x600
 lr : j721e_pcie_probe+0x170/0x600
 sp : ffff80000957bae0
 x29: ffff80000957bae0 x28: ffff800009357000 x27: ffff00000000c078
 x26: ffff00003fe047a8 x25: 0000000000000000 x24: ffff0000000f5280
 x23: ffff800008c98f78 x22: ffff800008f90ff0 x21: ffff000000231410
 x20: ffff000002ef2780 x19: 0000000000000021 x18: 0000000000000001
 x17: 0000000000000000 x16: 0000000000058c00 x15: ffffffffffffffff
 x14: ffffffffffffffff x13: 0000000000000010 x12: 0101010101010101
 x11: 0000000000000040 x10: ffff8000093e06c8 x9 : ffff8000093e06c0
 x8 : ffff000000400270 x7 : 0000000000000000 x6 : ffff000000231590
 x5 : ffff80000957b9e0 x4 : 0000000000000000 x3 : ffff0000002314f4
 x2 : 0000000000000000 x1 : ffff0000000f5280 x0 : 0000000000000000
 Call trace:
  j721e_pcie_probe+0x184/0x600
  platform_probe+0x68/0xe0
  really_probe+0x144/0x320
  __driver_probe_device+0xc4/0xe0
  driver_probe_device+0x7c/0x110
  __device_attach_driver+0x90/0xe0
  bus_for_each_drv+0x78/0xd0
  __device_attach+0xf0/0x150
  device_initial_probe+0x14/0x20
  bus_probe_device+0x9c/0xb0
  deferred_probe_work_func+0x88/0xc0
  process_one_work+0x1bc/0x340
  worker_thread+0x1f8/0x420
  kthread+0x110/0x120
  ret_from_fork+0x10/0x20
 Code: f9400280 a90573fb d0005396 913fc2d6 (f9400800)

Fixes: 19e863828acf ("PCI: j721e: Drop redundant struct device *")
Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
---
 drivers/pci/controller/cadence/pci-j721e.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index 489586a4cdc7..cd43d1898482 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -51,10 +51,11 @@ enum link_status {
 #define MAX_LANES			2
 
 struct j721e_pcie {
-	struct cdns_pcie	*cdns_pcie;
+	struct device		*dev;
 	struct clk		*refclk;
 	u32			mode;
 	u32			num_lanes;
+	struct cdns_pcie	*cdns_pcie;
 	void __iomem		*user_cfg_base;
 	void __iomem		*intd_cfg_base;
 	u32			linkdown_irq_regfield;
@@ -98,7 +99,7 @@ static inline void j721e_pcie_intd_writel(struct j721e_pcie *pcie, u32 offset,
 static irqreturn_t j721e_pcie_link_irq_handler(int irq, void *priv)
 {
 	struct j721e_pcie *pcie = priv;
-	struct device *dev = pcie->cdns_pcie->dev;
+	struct device *dev = pcie->dev;
 	u32 reg;
 
 	reg = j721e_pcie_intd_readl(pcie, STATUS_REG_SYS_2);
@@ -164,7 +165,7 @@ static const struct cdns_pcie_ops j721e_pcie_ops = {
 static int j721e_pcie_set_mode(struct j721e_pcie *pcie, struct regmap *syscon,
 			       unsigned int offset)
 {
-	struct device *dev = pcie->cdns_pcie->dev;
+	struct device *dev = pcie->dev;
 	u32 mask = J721E_MODE_RC;
 	u32 mode = pcie->mode;
 	u32 val = 0;
@@ -183,7 +184,7 @@ static int j721e_pcie_set_mode(struct j721e_pcie *pcie, struct regmap *syscon,
 static int j721e_pcie_set_link_speed(struct j721e_pcie *pcie,
 				     struct regmap *syscon, unsigned int offset)
 {
-	struct device *dev = pcie->cdns_pcie->dev;
+	struct device *dev = pcie->dev;
 	struct device_node *np = dev->of_node;
 	int link_speed;
 	u32 val = 0;
@@ -204,7 +205,7 @@ static int j721e_pcie_set_link_speed(struct j721e_pcie *pcie,
 static int j721e_pcie_set_lane_count(struct j721e_pcie *pcie,
 				     struct regmap *syscon, unsigned int offset)
 {
-	struct device *dev = pcie->cdns_pcie->dev;
+	struct device *dev = pcie->dev;
 	u32 lanes = pcie->num_lanes;
 	u32 val = 0;
 	int ret;
@@ -219,7 +220,7 @@ static int j721e_pcie_set_lane_count(struct j721e_pcie *pcie,
 
 static int j721e_pcie_ctrl_init(struct j721e_pcie *pcie)
 {
-	struct device *dev = pcie->cdns_pcie->dev;
+	struct device *dev = pcie->dev;
 	struct device_node *node = dev->of_node;
 	struct of_phandle_args args;
 	unsigned int offset = 0;
@@ -376,6 +377,7 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 	if (!pcie)
 		return -ENOMEM;
 
+	pcie->dev = dev;
 	pcie->mode = mode;
 	pcie->linkdown_irq_regfield = data->linkdown_irq_regfield;
 
-- 
2.34.1

