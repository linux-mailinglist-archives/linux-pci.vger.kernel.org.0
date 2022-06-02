Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954B153B924
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jun 2022 14:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233380AbiFBMuQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jun 2022 08:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbiFBMuO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jun 2022 08:50:14 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2E5E2750;
        Thu,  2 Jun 2022 05:50:14 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id c2so4463980plh.2;
        Thu, 02 Jun 2022 05:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kcZmoDNkypwVXAUGHN+8MXLjQTBcIwGXqyPCDHsu1M0=;
        b=kpVZpW9n9dbKqWRHDXzfVLoSjAdUYchpilbWAnfoSAcUlK+dSDFLQ+Vtf4qyy19tfY
         GSPyJIxmj+urIEtCa8WMmrJ8f4r0SlPLCQ9YnvFoWgJ8dLDoQ3T0vnXYRoS4JzZr4t+2
         I80dzyJG5TC/KAy9AII28TcnUb9IcbEaz2MYARNdo60J0P0xZz6nb4caD1ihsGIwb126
         xaEU9lVdNBkZad7j5nn59k/jg4AOyrgeEXz1bPGEW1AsAzG8JuE7KXbyMuR/YMB+BfRI
         a6v63NoTwxvDhMmq0BcOPNY3ckQjEqmLr2XVtTOrJoGDp/ZrCSZbA9T6ZAuQIEaoGQUr
         6jnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kcZmoDNkypwVXAUGHN+8MXLjQTBcIwGXqyPCDHsu1M0=;
        b=OWwrofBVJ3XB7lrAuYrZvujf1itbsi+KfCarQCyoPslpYj//cVBgHXejISKp1aOUoG
         ThsiHosrDyLtYbKCucR9EIye5wjTIgkFVovDKvielKgyPpap+EymYz90r3cX9Oqqgqwz
         X8lkI7nqGRAZ0tKZ6pvuWOxXl3IWFVxXBKYGEgh5j+Ll334fimM4Qj8fmI2hT3QArI5O
         DyB2FlOCZlJRoCmpKmKNcOtsXZqfgPqKiDVrwxHpL45xzrtf0pqfZllQMzrOWpndhBwd
         KBJQ0BakzOe6krh/ozsp5enoR0GfgYoCnFAz+A8Oo1iAaZ7kShFG8n082TNzIRZ296wQ
         DmDA==
X-Gm-Message-State: AOAM533TqmoeJL2bI6pLnvks70UBwsh5Cwv1piMKN7HYlA5Dy/QKMR19
        lb2fUY+uyNlX3nCiM9lGhCk=
X-Google-Smtp-Source: ABdhPJwDj60u40yHeOaBRKIgUx6FsuYrv4FjYePtp/TN3VzzNi90RvcmoTsOqA5IAnuznJgiiMtgXg==
X-Received: by 2002:a17:902:6e01:b0:164:27c:1135 with SMTP id u1-20020a1709026e0100b00164027c1135mr4810408plk.8.1654174213729;
        Thu, 02 Jun 2022 05:50:13 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id ju10-20020a17090b20ca00b001df264610c4sm2849408pjb.0.2022.06.02.05.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 05:50:13 -0700 (PDT)
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
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] PCI: brcmstb: Fix refcount leak in brcm_pcie_probe
Date:   Thu,  2 Jun 2022 16:50:02 +0400
Message-Id: <20220602125003.10723-1-linmq006@gmail.com>
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

Fixes: format:40ca1bf580ef ("PCI: brcmstb: Add MSI support")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
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

