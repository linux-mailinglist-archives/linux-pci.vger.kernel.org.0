Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199E66C942D
	for <lists+linux-pci@lfdr.de>; Sun, 26 Mar 2023 14:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbjCZMXT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 26 Mar 2023 08:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjCZMXS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 26 Mar 2023 08:23:18 -0400
X-Greylist: delayed 601 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 26 Mar 2023 05:23:15 PDT
Received: from mail1.kuutio.org (mail1.kuutio.org [54.37.79.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BEC269A
        for <linux-pci@vger.kernel.org>; Sun, 26 Mar 2023 05:23:14 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail1.kuutio.org (Postfix) with ESMTP id 6196A1F47C;
        Sun, 26 Mar 2023 14:13:08 +0200 (CEST)
Authentication-Results: mail1.kuutio.org (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=lemmela.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
        content-transfer-encoding:mime-version:x-mailer:message-id:date
        :date:subject:subject:from:from:received:received; s=dkim; t=
        1679832787; x=1682424788; bh=mNipBvnJy3jqF3ZH/dS2XiePL+XgvUisaqA
        YEKyRry4=; b=tHMBq8jnrkX7X5OmO+eSbF7hVHSbw+RabI+7pQgcPDCZyPaqxXu
        7YySyZSogDc5V8AfQGIEhslGbWZt7QLZYC5Bzw6utvBFx7sKnq5XheomfmtmxqHR
        b+L/3/sNrFqF6wwQQox4cYkfZjG2aQBuTqDEkTFyrYD3WHSXSvOnsSiGE6La+3lV
        iXKQK6pFg6OFSM2rQatHbJpqlHqdtPgALLgmYruDDZzuJ4JcUxHkr6iimcfFhWZJ
        HLzoATBiF+WiLwtdYf6YYhYNKHh6GDE7/w3G9b7C0MmBssKjojFUJdb3/u8o6NtB
        kEXYpP9bHBhI1mMtUFSKq4sOqQuVxELNtufcjpRfEPAiwbbV434iHyZ6xHOensgk
        6CsQXYLuQoyQth2/IQ14X4UYZ2IOfoiSeAHntZPAeuw9UKhaLqaoUfQIXsRIgTGJ
        VxP+NyZ/AB3bs9t+XLlMHutgXRKf4J7I5FD92b4vYsFu0c58K2/wlXTClgP9bhlF
        CCgDtTFeXAIKKL1I+eWgTDnkNWxbMaLygtd4FDwPqARhpUbCKd/b6NSRwyeLjwfg
        NpwpkhwutOLAVL9UWMJdFcdBDriXcKQMCt7K3fkH/KfD4keJvSfUJLX7zQ4LlFPK
        B+D7Xod9OwCkYxhaG0Lxw5Vbp2MzlKEEWEEkSUIzdZOZmooJEWJ2VWHM=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
        by localhost (mail1.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id oMaQBMVjpCH9; Sun, 26 Mar 2023 14:13:07 +0200 (CEST)
Received: from build.DOMAINS (unknown [IPv6:2001:998:13:e4::69])
        by mail1.kuutio.org (Postfix) with ESMTPSA id 3AD621FD44;
        Sun, 26 Mar 2023 14:13:07 +0200 (CEST)
From:   Oskari Lemmela <oskari@lemmela.net>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Oskari Lemmela <oskari@lemmela.net>
Subject: [PATCH] PCI: mediatek: increase link training timeout
Date:   Sun, 26 Mar 2023 15:12:17 +0300
Message-Id: <20230326121217.2664953-1-oskari@lemmela.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some PCI devices fail to complete link training in 100ms.
Increase link training timeout by 20ms to 120ms.

Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
---
 drivers/pci/controller/pcie-mediatek.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index ae5ad05ddc1d..67b8cf0dc9f7 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -720,10 +720,10 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
 	if (soc->need_fix_device_id)
 		writew(soc->device_id, port->base + PCIE_CONF_DEVICE_ID);
 
-	/* 100ms timeout value should be enough for Gen1/2 training */
+	/* 120ms timeout value should be enough for Gen1/2 training */
 	err = readl_poll_timeout(port->base + PCIE_LINK_STATUS_V2, val,
 				 !!(val & PCIE_PORT_LINKUP_V2), 20,
-				 100 * USEC_PER_MSEC);
+				 120 * USEC_PER_MSEC);
 	if (err)
 		return -ETIMEDOUT;
 
@@ -785,10 +785,10 @@ static int mtk_pcie_startup_port(struct mtk_pcie_port *port)
 	val &= ~PCIE_PORT_PERST(port->slot);
 	writel(val, pcie->base + PCIE_SYS_CFG);
 
-	/* 100ms timeout value should be enough for Gen1/2 training */
+	/* 120ms timeout value should be enough for Gen1/2 training */
 	err = readl_poll_timeout(port->base + PCIE_LINK_STATUS, val,
 				 !!(val & PCIE_PORT_LINKUP), 20,
-				 100 * USEC_PER_MSEC);
+				 120 * USEC_PER_MSEC);
 	if (err)
 		return -ETIMEDOUT;
 
-- 
2.34.1

