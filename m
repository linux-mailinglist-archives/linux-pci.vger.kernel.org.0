Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7672353CA70
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jun 2022 15:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbiFCNJC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Jun 2022 09:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiFCNJB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Jun 2022 09:09:01 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CAA2D1C1;
        Fri,  3 Jun 2022 06:09:00 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id mh16-20020a17090b4ad000b001e8313301f1so1061423pjb.1;
        Fri, 03 Jun 2022 06:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mVZpEQ32MpZ2jjCKEG/4tHTxVZCWFD+esEDsknLSJKI=;
        b=WBAcoxSP2zhANkvtbfwCiU2kORsH55UzHh/mapzXWi/0kED+ukXlntdj8C/P8KM7oJ
         iILNZM0iQj0J0TPwakXUfYIeVZn+s5brhnRcfjXfMTqNRYU9XkmzPhHClWMiB2aKXQ50
         gwPThywhc1UK4wdvZtdLNbXjXh4MOoksJQhDz3n+2O40MiUcoGno0UfleNFiFDI8Fg1L
         VP9+B1PP0TXkZ+vUSLs4rnyEp//KEwH0+mbZsFvLeBJ1suT7dyf+WLMrXKcQbCcAjrCZ
         CSR5X1MoCt2wxiW/D72BdUwHvkUhcZMhbS/SSFhPRrVGVj740SsGGjk8QvaBXqLP6gkL
         oXAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mVZpEQ32MpZ2jjCKEG/4tHTxVZCWFD+esEDsknLSJKI=;
        b=VAT87kNQOLGfQuOMvtKPx/PXBBIafnBaMXtbwJK1zlsWUzId8wJKpbfGDRAUR+k5HR
         RiiwrFjV3D0ezjrM+4ysjVrQKZtYNzhyrpbFzG1htk7nXEk8ZKXCWfm2ACWh7saJ4DjK
         8ekWTX8BdZ1NcEEy+51r1+WsbPhsWAp+QoWYp4hJyE5lDSzfgS775zMfSU1JWP37ZYkR
         rYWL48uE5kgSmZhEAiu0XvPwO1AtOaCbqgWfxOIsLKE4uJTb9Cu88MQJuZW5v6Lan8K9
         ksjE7B5yJxvDvxJpU7T9ZiHbV5Z91ZOO8TSyqbXqg0YGhjVF9yt4AVTm0IKxNNGvFOUr
         2SVg==
X-Gm-Message-State: AOAM533fQwLAru76+gRy3faAIG9ew1I1qomhoQ5QebM5us4xL7zG2Bu4
        V+XPVnRH49jr9iWQvlhaz04=
X-Google-Smtp-Source: ABdhPJwFb/EjeiXip+FbPnvJM5M4Ceo7gNr0Wbt8APuryYL9ZXsDK3uuQDjpABp3K0y5wQ7HSUshnQ==
X-Received: by 2002:a17:90b:3b4c:b0:1e0:3354:5e5d with SMTP id ot12-20020a17090b3b4c00b001e033545e5dmr46202726pjb.239.1654261740290;
        Fri, 03 Jun 2022 06:09:00 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id g69-20020a636b48000000b003fbfe88be17sm5166973pgc.24.2022.06.03.06.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 06:08:59 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Jim Quinlan <jim2101024@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH v2] PCI: brcmstb: Fix refcount leak in brcm_pcie_probe
Date:   Fri,  3 Jun 2022 17:08:49 +0400
Message-Id: <20220603130849.38252-1-linmq006@gmail.com>
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

of_parse_phandle() returns a node pointer with refcount
incremented, we should use of_node_put() on it when not need anymore.
Add missing of_node_put() to avoid refcount leak.

Fixes: 40ca1bf580ef ("PCI: brcmstb: Add MSI support")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
changes in v2:
- update Fixes tag.
v1 Link: https://lore.kernel.org/r/20220602125003.10723-1-linmq006@gmail.com
---
 drivers/pci/controller/pcie-brcmstb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 375c0c40bbf8..e3b673441a11 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1597,8 +1597,10 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 		ret = brcm_pcie_enable_msi(pcie);
 		if (ret) {
 			dev_err(pcie->dev, "probe of internal MSI failed");
+			of_node_put(msi_np);
 			goto fail;
 		}
+		of_node_put(msi_np);
 	}
 
 	bridge->ops = pcie->type == BCM7425 ? &brcm_pcie_ops32 : &brcm_pcie_ops;
-- 
2.25.1

