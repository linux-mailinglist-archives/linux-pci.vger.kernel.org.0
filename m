Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7C95374E4
	for <lists+linux-pci@lfdr.de>; Mon, 30 May 2022 09:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbiE3Gsz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 May 2022 02:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbiE3Gsy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 May 2022 02:48:54 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AC950B28;
        Sun, 29 May 2022 23:48:54 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id y189so9766416pfy.10;
        Sun, 29 May 2022 23:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kzFFxChRf7RgMYcMJ2ll5DY8vkYnacLX8rZwLOdfqa8=;
        b=musOaD+e8VR3WVlAfkK5uKKyxkR+shVmejo5NWKByI75Uu3nTCkw0n/od0vocI2Y7u
         zB8S0/T21sOShBFD5iiqVFIgG6aSrIk5/F8UjfsW+QvNhEki23PnkrSVx9HDWTSWf2qU
         8QE0gj3kvFfiwxrQOZpJrJ5RpoBG9qz9vIs0GMmfCxnNynvnqxl92C0YCdfe7n8+/Mci
         nLYN4kQZN1DySeEfspZp4ZVtCn59f4Kz1pzelDGOUmDzRaSS3L879dZrxEGwRf+jKobg
         3KtmWmwHfKnqfG7t3TU/ZoFNayog8PscZk49H7GytwjPTPx2Qr5xJhdIz3e2Xbd/tsmc
         pgBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kzFFxChRf7RgMYcMJ2ll5DY8vkYnacLX8rZwLOdfqa8=;
        b=M0RZ9/VszdhTXV/NjYbzV6oQyogiB4PE+men3ncNg3Elv/m3kF9GK1UKPw4pVqVuK2
         Egg4qCxNmgLIhQCpAEC7GKXP7vDHunr0zY6qYNLiLYVkt/1hVGCDF1BQHlQ9PlKHFxvN
         NJX1tKV+Yk4Tp/G1vXG7cGtDGCmYYge339pmaG8iXi9BdTEhEtrMC7wpIRFSohJVZek4
         yYaOaPvgrhTEklAstEog3sMt/LkrGMuYtrlQc1noRS66Fn5sPZOH14eiqO4j8tjt5cxC
         s9FTk1sjIY38n37PZZX23iHtdhQb1yIMiH+o3w7lT0pD6He4gjQbcnXT9VMZ+T/Nknqy
         6aHw==
X-Gm-Message-State: AOAM532QXSJ8YIrl2fj2me2rVIZsz5OPalDmnxk/CIb2V81+4sG+37H/
        Sg48JDuiATOD46uAb4Oxfag=
X-Google-Smtp-Source: ABdhPJxFqpNKl8VvLOwz6v8FfeXv5UDp72W5VWnmYNXP0X2DVfcSqFfEpd3ke0JpZuPugL7BR1W7fw==
X-Received: by 2002:a62:c186:0:b0:518:900c:837 with SMTP id i128-20020a62c186000000b00518900c0837mr41044044pfg.50.1653893333580;
        Sun, 29 May 2022 23:48:53 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id h28-20020a63211c000000b003fbaae74971sm5826704pgh.72.2022.05.29.23.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 May 2022 23:48:53 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     linmq006@gmail.com
Subject: [PATCH v2] PCI: mediatek-gen3: Fix refcount leak in mtk_pcie_init_irq_domains
Date:   Mon, 30 May 2022 10:48:06 +0400
Message-Id: <20220530064807.34534-1-linmq006@gmail.com>
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

of_get_child_by_name() returns a node pointer with refcount
incremented, we should use of_node_put() on it when not need anymore.
Add missing of_node_put() to avoid refcount leak.

Fixes: 814cceebba9b ("PCI: mediatek-gen3: Add INTx support")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
changes in v2:
- move of_node_put(intc_node) right after irq_domain_add_linear to cover
normal path and error paths.

v1 link: https://lore.kernel.org/all/20220526110246.53502-1-linmq006@gmail.com/
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 3e8d70bfabc6..19a01daad304 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -598,6 +598,7 @@ static int mtk_pcie_init_irq_domains(struct mtk_gen3_pcie *pcie)
 
 	pcie->intx_domain = irq_domain_add_linear(intc_node, PCI_NUM_INTX,
 						  &intx_domain_ops, pcie);
+	of_node_put(intc_node);
 	if (!pcie->intx_domain) {
 		dev_err(dev, "failed to create INTx IRQ domain\n");
 		return -ENODEV;
-- 
2.25.1

