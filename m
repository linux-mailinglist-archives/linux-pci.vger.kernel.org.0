Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7FE4D2BA6
	for <lists+linux-pci@lfdr.de>; Wed,  9 Mar 2022 10:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiCIJU5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Mar 2022 04:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbiCIJU5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Mar 2022 04:20:57 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B00814D26C;
        Wed,  9 Mar 2022 01:19:59 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id t5so1719069pfg.4;
        Wed, 09 Mar 2022 01:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=bEfAhcbqdZYeRPwL35nsLH5O9/gJamZgyeCS3FefDNw=;
        b=BsoKPHGooVGX5YiMJYd3QMKPcI1SY0zHSNffkRhDtqHmSki7knDnJM3+Bh6oOky7NN
         zPjSxKAQ7RGDiJzONdOBMO4dgnSI2QdLCxwDTnGOevdEvLdkuMCthRygXJlJKnRGj/pX
         pCNPjcrtedFH4PyMzq0YY1+g6c56R+l9+G7wKhprjCKFBIVxbJjmymVwFyB1xdkJ6nO6
         34UIDl3yWMtHys6p0eK1K3RbZkEOMIl5TNKrFjhJhQV4EvzJUlLazm96GegfmlUN8/oQ
         wVuWvn29XcBbEAgyH5hHixV2OcDAQ1Ajf4wf42IHmAMSaUJfsgJBxadnTJi6NFYpWNmP
         HQKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bEfAhcbqdZYeRPwL35nsLH5O9/gJamZgyeCS3FefDNw=;
        b=GcHp4srYW4QtCjWlfFqL5T4qunqcCguhIRx2Xg19oNmCG4N3s4p6h7VhL7zNxGSIuI
         0we0KLxqYMpmHjSwfyY9SODQYzOqo8fHYOgoeVo6HuAe6XFyxcSLq3tXB3RyVF542oQ8
         LObWO/IAimeSsrkDy9W1fz7JpA/YKoGKc37g5JTIg7D7Hx6Gb6ONjSK30TW24IslFAG3
         kWE+beqWG27YtuR8+sw7qkGeMcpVbp3n0nUeOHMLjtlWgYUFopYTaPz6I2ZSHNhGA8vO
         vOKLuLibEQCzXbgUuTiPtnmoREyJr6uexViaC0KZgF8GU8acqdkquuZvUOAHEmxKOxGR
         TYRQ==
X-Gm-Message-State: AOAM532Oo6oYuOnhiYQObVxBAHp99hKZp0RcOx4PoqLgcFRxBQsonIBk
        QL6iOqAwXl9aG0txTCKX+bc=
X-Google-Smtp-Source: ABdhPJz154842HCAn71vp+FZHXMEdU/ZMNx3OLEChgK28OxSn1qfQPpKo19ta6GkpOADMhYbIb7XJA==
X-Received: by 2002:a05:6a00:8ca:b0:4e0:2ed3:5630 with SMTP id s10-20020a056a0008ca00b004e02ed35630mr22900242pfu.3.1646817599116;
        Wed, 09 Mar 2022 01:19:59 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id 78-20020a621451000000b004f6e8a033b5sm2071595pfu.142.2022.03.09.01.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 01:19:58 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chuanjia Liu <chuanjia.liu@mediatek.com>,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     linmq006@gmail.com
Subject: [PATCH] PCI: mediatek: Fix refcount leak in mtk_pcie_subsys_powerup
Date:   Wed,  9 Mar 2022 09:19:52 +0000
Message-Id: <20220309091953.5630-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The of_find_compatible_node() function returns a node pointer with
refcount incremented, We should use of_node_put() on it when done
Add the missing of_node_put() to release the refcount.

Fixes: 87e8657ba99c ("PCI: mediatek: Add new method to get shared pcie-cfg base address")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/pci/controller/pcie-mediatek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index ddfbd4aebdec..be8bd919cb88 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -1008,6 +1008,7 @@ static int mtk_pcie_subsys_powerup(struct mtk_pcie *pcie)
 					   "mediatek,generic-pciecfg");
 	if (cfg_node) {
 		pcie->cfg = syscon_node_to_regmap(cfg_node);
+		of_node_put(cfg_node);
 		if (IS_ERR(pcie->cfg))
 			return PTR_ERR(pcie->cfg);
 	}
-- 
2.17.1

