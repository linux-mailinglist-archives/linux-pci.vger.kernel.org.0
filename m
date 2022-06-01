Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9BA539BF6
	for <lists+linux-pci@lfdr.de>; Wed,  1 Jun 2022 06:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbiFAENV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Jun 2022 00:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbiFAENU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Jun 2022 00:13:20 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867942F033;
        Tue, 31 May 2022 21:13:17 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id nn3-20020a17090b38c300b001e0e091cf03so2980235pjb.1;
        Tue, 31 May 2022 21:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ilrv2fsQ1oyZr4Sxgimv3HjgUAGGQatiiqNbcEA0JFU=;
        b=im8+dOhyrYsZgyqm/2nx3dBhLfzOI7x5+GXKwk4veel/e3dCK2Lt2Ri/gyxKSDlOtG
         8rhg+YkF1ktZU6A9sosvKcMFf+/uZnko/TESgmA1vwUr4nM/S9+o0tM3KvTTN0vY6zYR
         a9CvDXgQvas+3Mox/NUQb/SO/p2/mqhhygeGrMnWUQdiDityjaCjgVLYMGdIJtR3lw92
         0fZprUZLdxYbEEX9kFeVbuDJ+F6/TdLvQU+G9Zhi29Q2a8gMEoGh6skDN7qQ7jOZcgPA
         7iz8OUwUzw+lLNXk2YP9aEOhqTVkAs6BNfvcKUjA2iF1ev4Q9qXN+g5BFWvBlmSJNf4g
         1Ktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ilrv2fsQ1oyZr4Sxgimv3HjgUAGGQatiiqNbcEA0JFU=;
        b=Ns9Apj0Q2J9A7Yo9qGdKofvZF7XKQUePYgsYNTsv7JsSijNJDZcvZAd0TxYkPulfXq
         pzMo4VOMAAEihZVJv9ydvLatxDYpOz+NbTNqxauODBH/VCgvZ8YRcDbaphn/CyH+ldlV
         QGacf44f3kpbGBMVEPDA0a/qzyLCE7AmUBrat/zlAHKvfW1I+s2QwDU8yE0HCac2nSDb
         VKcgV6E0KAT2hY53zKthc13bBwBuyOoaS4rMkvbVmBypbzAUZ8p1g+8OdC8qONwyQwjs
         8GV0CD748usDZ3fQp/5R10D8Eg1t8VZioR4h3E7qy9pwV/Ovds89CZ3LUVTocRPxerzi
         324g==
X-Gm-Message-State: AOAM532BSISpb80rpjHXqrOaiRVRf0xEFjJ2OjeIX2ZYqIe/2cv+V9Cz
        wDcltSYBo/CgDxxO+9NlmCs=
X-Google-Smtp-Source: ABdhPJyPvtXzWJO2RmYHgPiZUTuVpyzAZyIlZ53x15if6PBizKnZr1JaSDXzPfVBdWGswbimTAuoHg==
X-Received: by 2002:a17:902:ef48:b0:159:51d:f725 with SMTP id e8-20020a170902ef4800b00159051df725mr65758050plx.47.1654056796365;
        Tue, 31 May 2022 21:13:16 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id d17-20020a17090abf9100b001df68146a20sm2714564pjs.56.2022.05.31.21.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 21:13:15 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     miles.chen@mediatek.com, Ryder Lee <ryder.lee@mediatek.com>,
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
Subject: [PATCH v3] PCI: mediatek-gen3: Fix refcount leak in mtk_pcie_init_irq_domains
Date:   Wed,  1 Jun 2022 08:12:58 +0400
Message-Id: <20220601041259.56185-1-linmq006@gmail.com>
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
---
changes in v3:
- call of_node_put() in error paths with goto, and call of_node_put() before
  return 0 in normal path. Since this function has a goto part to handle
  resources, so put them together, as suggested by Miles Chen <miles.chen@mediatek.com>

v1 link: https://lore.kernel.org/all/20220526110246.53502-1-linmq006@gmail.com/
v2 link: https://lore.kernel.org/all/20220530064807.34534-1-linmq006@gmail.com/
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 3e8d70bfabc6..bceed28446ed 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -600,7 +600,8 @@ static int mtk_pcie_init_irq_domains(struct mtk_gen3_pcie *pcie)
 						  &intx_domain_ops, pcie);
 	if (!pcie->intx_domain) {
 		dev_err(dev, "failed to create INTx IRQ domain\n");
-		return -ENODEV;
+		ret = -ENODEV;
+		goto out_put_node;
 	}
 
 	/* Setup MSI */
@@ -623,13 +624,15 @@ static int mtk_pcie_init_irq_domains(struct mtk_gen3_pcie *pcie)
 		goto err_msi_domain;
 	}
 
+	of_node_put(intc_node);
 	return 0;
 
 err_msi_domain:
 	irq_domain_remove(pcie->msi_bottom_domain);
 err_msi_bottom_domain:
 	irq_domain_remove(pcie->intx_domain);
-
+out_put_node:
+	of_node_put(intc_node);
 	return ret;
 }
 
-- 
2.25.1

