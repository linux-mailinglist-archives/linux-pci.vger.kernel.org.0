Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B002F223CB2
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jul 2020 15:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgGQNaQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jul 2020 09:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbgGQNaQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jul 2020 09:30:16 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297F8C061755;
        Fri, 17 Jul 2020 06:30:16 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id k5so6363083pjg.3;
        Fri, 17 Jul 2020 06:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KA8+BCThQcJ0LRUas8mEHnLeHf4G0JN/o4kBoJ11ao4=;
        b=Ew7go265THrXcCo9R7QqWPFNUC6m+Vh6NUeRwvXlPSe0VJZbR9rQfMfYlxSKi6RaRA
         gVb2Kvq/vbg4rZtdMgU4zzpyoX0eMTJ+JWtKzKZgulGNc9Vxv0CjB63kr8JW2jbPTgaB
         +5eHRJ6epadXZHiChy1g5fTc8SmbomqyqvoKfAdm94q3xU1OxI1ClfrzRD/54HHA8kZ6
         A22lh+Sn3ahXiS7Wq0KwYg7RKteQlr2DUvuD4NO6tR4WK/1zt+aQSj08kvrauISzdOhg
         8ldOhoRF2r3Vcelfcm5j/brDYmiLq52RsoI+ermOb5Tw/N5dNQcBbKMivzNWK8v3qJ6Q
         3cnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KA8+BCThQcJ0LRUas8mEHnLeHf4G0JN/o4kBoJ11ao4=;
        b=Qw5LqgaEdivSDDmimTVe1t5FvoxhXOKA5ZxDW1ro1z6s6RP1SoA/78oraHJK4KaFyY
         evqhqZLtN/qEFCgkReXfCYQXLHqm56VCnS+TVhztaast2Q22fFQb80TDnsXeAMgXSQdb
         dZcmZvggYrw/YFADrbQ6mrWVYGzisHqJz26uFUez7rcsKm9TTftjQeiskSxPwZGPoNup
         kVbttvE2WdaoaCnhg+uKhCozsoryx6sH+3Vmd0yp9CJDt9+9gjc8Sgsh+xcgW3p5vp6M
         8sAYiBrr2oOLqxCt7AUS0K24myb5d+DNe+xXZlQKH1peOXJ7Oq+B74LxBfd5nNbNgYL4
         Y08Q==
X-Gm-Message-State: AOAM5309lK3nYTLaKO6N2McMTCpF1UhDz02VcG2hdojFMlOdLvp1IZzA
        cvHiMrG2yTOglKGlLKm19h0=
X-Google-Smtp-Source: ABdhPJyTEisx3beIa/u5++UyoSvIIfKcqCyUwaWL1AJo3A+t3cP0eYEO1wwLNqXySkLvcofRnsjoYg==
X-Received: by 2002:a17:90a:ed87:: with SMTP id k7mr10231962pjy.31.1594992615587;
        Fri, 17 Jul 2020 06:30:15 -0700 (PDT)
Received: from localhost ([89.208.244.139])
        by smtp.gmail.com with ESMTPSA id t20sm7974375pfc.158.2020.07.17.06.30.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Jul 2020 06:30:14 -0700 (PDT)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     m-karicheri2@ti.com, lorenzo.pieralisi@arm.com, robh@kernel.org,
        bhelgaas@google.com, gustavo.pimentel@synopsys.com,
        linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Dejin Zheng <zhengdejin5@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v1] PCI: dwc: fix a warning about variable 'res' is uninitialized
Date:   Fri, 17 Jul 2020 21:30:07 +0800
Message-Id: <20200717133007.23858-1-zhengdejin5@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The kernel test robot reported a compile warning,

drivers/pci/controller/dwc/pci-keystone.c:1236:18: warning: variable 'res'
is uninitialized when used here [-Wuninitialized]

The commit c59a7d771134b5 ("PCI: dwc: Convert to
devm_platform_ioremap_resource_byname()") did a wrong conversion for
keystone driver. the commit use devm_platform_ioremap_resource_byname()
to replace platform_get_resource_byname() and devm_ioremap_resource().
but the subsequent code needs to use the variable 'res', which is got by
platform_get_resource_byname() for resource "app". so revert it.

Fixes: c59a7d771134b5 ("PCI: dwc: Convert to devm_platform_ioremap_resource_byname()")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 5ffc3b40c4f6..00279002102e 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -1228,8 +1228,8 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	if (!pci)
 		return -ENOMEM;
 
-	ks_pcie->va_app_base =
-		devm_platform_ioremap_resource_byname(pdev, "app");
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "app");
+	ks_pcie->va_app_base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(ks_pcie->va_app_base))
 		return PTR_ERR(ks_pcie->va_app_base);
 
-- 
2.25.0

