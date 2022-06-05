Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFD653DA4F
	for <lists+linux-pci@lfdr.de>; Sun,  5 Jun 2022 07:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244015AbiFEFvn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 5 Jun 2022 01:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiFEFvm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 5 Jun 2022 01:51:42 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C986620F5F;
        Sat,  4 Jun 2022 22:51:41 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id bo5so10300246pfb.4;
        Sat, 04 Jun 2022 22:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xvSt0AKHTEKrJ0jlJnO67OfEugds1dmz8a43+lRd6EA=;
        b=ldRwqD9PV/gagyZd0fUfRP37tUfOfD0L/Dg87ohbmuwNSDfPFAXhji1LAJSMypxlMD
         0ASo53zaJ/GxC8pLYV7muYNsnhXxu8xdPt39wFIujRIuae+nWT//CS/iMbSzjNIx8exS
         Jowq9CIF35yK+JUb2ftbj0IeyyAyIOji7nJACK6dGXTykpA50j6o7cM8OsrjzTSWZo7r
         QOEWiYC7WMaTik8u4aw4oO2E3ZrUcX6yStjHnDpgtbfzhq+YaduZuB+BgGGIYJAQ2rMk
         jJrFbzkIg3+DHVbYfupitcH9TpkAYRugEoSbrC7A5+/BJpJWMtSTA+LBEQK87Ei2kmuw
         gznw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xvSt0AKHTEKrJ0jlJnO67OfEugds1dmz8a43+lRd6EA=;
        b=twr9HXqFELF2hpST2doVlwZgIjOOd0fMxvoNYhh6j2eKqmtEg5ZsZW1E2SGoiZ7ne9
         Vwdx/9K3P+ZOKZVtMS34nmTPV1fpqVg2GrFCD+qAF9Rb2Czh8pvmHacTRDgAHMNlqOVC
         mdY6N7KGHOYFtYXMb4Wu3znc5/Qc3DHz8wmjZUGyv6r0N639xD8f4hEOxnyO9qweOgGJ
         Ffxwsb5ONFlqLKBu2aesNQhNxLc6gIIwh3nytOZxXjae3yYL4EUvSW/UFSDZQ2Xwt+Nv
         2GIHg5ix3p5Og3VOyZQkibcxkQua0+ZJaz8gjba8clGdo32PsCr+cDGNsb5Ehue7khQu
         EKMA==
X-Gm-Message-State: AOAM533zvJUOti6udAtMT4iSAkJPusxc5jk3hOkzEmoplBFOdTxhRl5c
        iwb8CI5Mt2AW3BT/dQ7cNXZJ/tJHaEhThW4a
X-Google-Smtp-Source: ABdhPJxaB243sNnKHjxSjb5LVQPz6UCeFE8rsCRlktjT3gE7xBxb28KZlKrHyxew/xfQRoOjgbS+mg==
X-Received: by 2002:a05:6a00:1805:b0:51c:3a7:54dc with SMTP id y5-20020a056a00180500b0051c03a754dcmr3134938pfa.15.1654408301252;
        Sat, 04 Jun 2022 22:51:41 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id dw15-20020a17090b094f00b001e0b971196csm10161239pjb.57.2022.06.04.22.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 22:51:40 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Daire McNamara <daire.mcnamara@microchip.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] PCI: microchip: Fix refcount leak in mc_pcie_init_irq_domains
Date:   Sun,  5 Jun 2022 09:51:23 +0400
Message-Id: <20220605055123.59127-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

of_get_next_child() returns a node pointer with refcount incremented,
we should use of_node_put() on it when not need anymore.
This function only call of_node_put() in normal path,
missing it in some error paths.
Add missing of_node_put() to avoid refcount leak.

Fixes: 6f15a9c9f941 ("PCI: microchip: Add Microchip PolarFire PCIe controller driver")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/pci/controller/pcie-microchip-host.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/pcie-microchip-host.c b/drivers/pci/controller/pcie-microchip-host.c
index dd5dba419047..7263d175b5ad 100644
--- a/drivers/pci/controller/pcie-microchip-host.c
+++ b/drivers/pci/controller/pcie-microchip-host.c
@@ -904,6 +904,7 @@ static int mc_pcie_init_irq_domains(struct mc_pcie *port)
 						   &event_domain_ops, port);
 	if (!port->event_domain) {
 		dev_err(dev, "failed to get event domain\n");
+		of_node_put(pcie_intc_node);
 		return -ENOMEM;
 	}
 
@@ -913,6 +914,7 @@ static int mc_pcie_init_irq_domains(struct mc_pcie *port)
 						  &intx_domain_ops, port);
 	if (!port->intx_domain) {
 		dev_err(dev, "failed to get an INTx IRQ domain\n");
+		of_node_put(pcie_intc_node);
 		return -ENOMEM;
 	}
 
-- 
2.25.1

