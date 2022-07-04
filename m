Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3C0564DB1
	for <lists+linux-pci@lfdr.de>; Mon,  4 Jul 2022 08:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiGDGbi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Jul 2022 02:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiGDGbh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Jul 2022 02:31:37 -0400
Received: from mail-m965.mail.126.com (mail-m965.mail.126.com [123.126.96.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0544525EC
        for <linux-pci@vger.kernel.org>; Sun,  3 Jul 2022 23:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=yRVcx
        myDVI1OczELBLXvvBpUvTWxQntYZZzohzOW9wM=; b=NuDLctoZLTpIon2fWazCm
        4eq7K7Agi8NnJNp91FMpTXUfIP6o9uDTc9BQPHPY3CnRLQYpGhj9XAMer9AjU4Ib
        syn673IN1tp3tA2S4aX3JCfNFJcYPVvEhR5LJxHF1pi7xUYxrF2nrMwcmN1kf4Q0
        PYpsZlLJI7viHgK0rlwmZ4=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp10 (Coremail) with SMTP id NuRpCgBnsXUCiMJidW8FGA--.15859S2;
        Mon, 04 Jul 2022 14:26:11 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     Zhiqiang.Hou@nxp.com, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        windhl@126.com, linmq006@gmail.com
Subject: [PATCH] pci: controller: mobiveil: Hold reference returned by of_parse_phandle()
Date:   Mon,  4 Jul 2022 14:26:08 +0800
Message-Id: <20220704062608.273440-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NuRpCgBnsXUCiMJidW8FGA--.15859S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zry5XrWxKw47XryxuryUWrg_yoW8GF4UpF
        95ta1ay3WfJr4F9r4Fv3WDZFy3KF9rG3y5ta9293ZavasrJF1UJwn8Cryfu3WrGan8Xr17
        tr1Iva1Uua1rXFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UxwIgUUUUU=
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbizgM0F18RPbUYBgAAs2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In ls_g4_pcie_probe(), we should hold the reference returned by
of_parse_phandle() and use it to call of_node_put() for refcount
balance.

Fixes: d29ad70a813b ("PCI: mobiveil: Add PCIe Gen4 RC driver for Layerscape SoCs")
Co-authored-by: Miaoqian Lin <linmq006@gmail.com>
Signed-off-by: Liang He <windhl@126.com>
---
 drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c b/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
index d7b7350f02dd..075aa487f92e 100644
--- a/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
+++ b/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
@@ -204,13 +204,15 @@ static int __init ls_g4_pcie_probe(struct platform_device *pdev)
 	struct pci_host_bridge *bridge;
 	struct mobiveil_pcie *mv_pci;
 	struct ls_g4_pcie *pcie;
-	struct device_node *np = dev->of_node;
+	struct device_node *np = dev->of_node, *parse_np;
 	int ret;
 
-	if (!of_parse_phandle(np, "msi-parent", 0)) {
+	parse_np = of_parse_phandle(np, "msi-parent", 0);
+	if (!parse_np) {
 		dev_err(dev, "Failed to find msi-parent\n");
 		return -EINVAL;
 	}
+	of_node_put(parse_np);
 
 	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
 	if (!bridge)
-- 
2.25.1

