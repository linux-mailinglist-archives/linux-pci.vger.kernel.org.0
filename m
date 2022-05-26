Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F87534DB9
	for <lists+linux-pci@lfdr.de>; Thu, 26 May 2022 13:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347102AbiEZLDR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 May 2022 07:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347089AbiEZLC7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 May 2022 07:02:59 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039BFCEB93;
        Thu, 26 May 2022 04:02:58 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id n8so1169253plh.1;
        Thu, 26 May 2022 04:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pQUCA+bAk9kVI/8KTFrFISyXPuEQ82dwO725ac3Sycc=;
        b=mImrJwj6KAgd0728Scm85+G/bDiUAaeeOA3NKofzoL0zUz3ATZra9wQ3f0wz5AdoJd
         cCFSmNyx5/WJc+nWyl//m/yZXJG0B4bcQXMIM83VVZYafy4uDfrUGVtHHCDYTdKqpfxy
         Qsn/PlbNfOodNnzS7L+jMl1BOuKxZ6mm/lNR/H3UuwNYRpWd5JpuGs+k9JSkMY1AJTKP
         hzIL0Wc143ZQ7QvedXICpdL8eW1N9aK+6Td7HkVfgtjqI6VEMUnJhZYGBc+MN8PSCG+D
         DGKWVUuWVj2yyPGauuXss/WgP6GlwIn/RBvUHt2lF/MQqq93UcyjtL6NrNnZvYMlJ94c
         udRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pQUCA+bAk9kVI/8KTFrFISyXPuEQ82dwO725ac3Sycc=;
        b=jwzXhEdkdWBB2mohNqTtHcq4PsuU9jpQUhdOn75dsd8Omb51rRXx+1Se69hFJhM66a
         Hq1UEybB3oh9Pjw1KcPjKy6KUsi7ghZUmNlWePKfQ6xWc89wo0c6jgKdYIEqTxb9zNwB
         UGuoKfekzpPCjpqHxGjayqLwXVQDea3fiyYU2eU00HoeoPRQbstpEgCUyKx9xvoUX+6k
         HWHf+dD1wvx7oujOCxE1K+q+cqAH6QwdwSSn7W9YaY7eh9L+RuYGOddaVRZXZdJJQ6W8
         wBzRCoZhpzUah8TheOTqOVno7kTfjgbIuJzxUDobat4TETnETI2OgQEfcH53DQKmcLPS
         F7yA==
X-Gm-Message-State: AOAM532QZUrKfl2BYti96WKvcE/AWkFk9Rud5ZiF4Uu733pX6jd6NBo9
        1qxw0bGJ8RSl24ysvQnVXDrrKgQRmbKTL8jV
X-Google-Smtp-Source: ABdhPJzQNCewyZz5gSKXq3raps72PN4ezX+1KdP2h6rnRD65QUCkIlb9JRWJUGJBbANgZNjY/Ze1HQ==
X-Received: by 2002:a17:902:cec6:b0:162:50b1:b40a with SMTP id d6-20020a170902cec600b0016250b1b40amr10923335plg.107.1653562977387;
        Thu, 26 May 2022 04:02:57 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id x1-20020a17090300c100b0015e8d4eb289sm1178902plc.211.2022.05.26.04.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 04:02:56 -0700 (PDT)
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
Subject: [PATCH] PCI: mediatek-gen3: Fix refcount leak in mtk_pcie_init_irq_domains
Date:   Thu, 26 May 2022 15:02:46 +0400
Message-Id: <20220526110246.53502-1-linmq006@gmail.com>
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
 drivers/pci/controller/pcie-mediatek-gen3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 3e8d70bfabc6..da8e9db0abdf 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -600,6 +600,7 @@ static int mtk_pcie_init_irq_domains(struct mtk_gen3_pcie *pcie)
 						  &intx_domain_ops, pcie);
 	if (!pcie->intx_domain) {
 		dev_err(dev, "failed to create INTx IRQ domain\n");
+		of_node_put(intc_node);
 		return -ENODEV;
 	}
 
-- 
2.25.1

