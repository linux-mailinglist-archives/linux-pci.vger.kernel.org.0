Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF9E564EAA
	for <lists+linux-pci@lfdr.de>; Mon,  4 Jul 2022 09:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbiGDH2k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Jul 2022 03:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbiGDH2k (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Jul 2022 03:28:40 -0400
Received: from m15111.mail.126.com (m15111.mail.126.com [220.181.15.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 551565F76
        for <linux-pci@vger.kernel.org>; Mon,  4 Jul 2022 00:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=v3Cng
        f1g73W8rlZL3QpzHp1oXKvOXGEwTwK007R7BYM=; b=R203fNJ/XfCN06n8lklms
        EbKDTdkNthps43Ba4BTrCpJGbvDVPB4TVQ1wYZf4h6ukX+5kVnUCl2JzPvAfLZIE
        F8S29XNdbnvoz4dG16HDjNaa7AJX39PvF0nBVloHCpHFhuklE2JDuYXDt2blFMck
        6v6/ocmD1KyG+K6JOMgjx8=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp1 (Coremail) with SMTP id C8mowAD3_BzGjsJiBpfcFw--.17627S2;
        Mon, 04 Jul 2022 14:55:04 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     jim2101024@gmail.com, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, lpieralisi@kernel.org,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        p.zabel@pengutronix.de, linux-pci@vger.kernel.org, windhl@126.com,
        linmq006@gmail.com
Subject: [PATCH] pci: controller: brcmstb: Move of_node_put() out of 'if' in brcm_pcie_probe
Date:   Mon,  4 Jul 2022 14:55:01 +0800
Message-Id: <20220704065501.275677-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8mowAD3_BzGjsJiBpfcFw--.17627S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtw1xWFWDXF45AryUGw4Uurg_yoWkXFXE9a
        4IyFnrur4UWFWSgFnIyrWrW392y343Ww4vganYq3W3t3ZIqryUXFyUXrsrZ34kurZYqr1j
        yrnrZF429ay5AjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRpWlqJUUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbiuAg0F2JVkLu7WAAAss
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit 3a87cb8f6a ("Fix refcount leak in brcm_pcie_probe()") adds
of_node_put() for of_parse_phandle() in fail path but not adds it
correctly in normal path. We should move the second of_node_put()
out of the 'if(pci_msi_enabled() && msi_np == pcie->np)'.

Fixes: 3a87cb8f6a ("Fix refcount leak in brcm_pcie_probe()")
Co-authored-by: Miaoqian Lin <linmq006@gmail.com>
Signed-off-by: Liang He <windhl@126.com>
---
 Patched file has been compiled test in next branch.

 drivers/pci/controller/pcie-brcmstb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 48a7148376d4..80e19d053e9f 100755
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1413,8 +1413,8 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 			of_node_put(msi_np);
 			goto fail;
 		}
-		of_node_put(msi_np);
 	}
+	of_node_put(msi_np);
 
 	bridge->ops = pcie->type == BCM7425 ? &brcm_pcie_ops32 : &brcm_pcie_ops;
 	bridge->sysdata = pcie;
-- 
2.25.1

