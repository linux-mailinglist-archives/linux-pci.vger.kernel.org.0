Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079C3508A7E
	for <lists+linux-pci@lfdr.de>; Wed, 20 Apr 2022 16:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377538AbiDTOTL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Apr 2022 10:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379989AbiDTOSY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Apr 2022 10:18:24 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9943E4A3E3
        for <linux-pci@vger.kernel.org>; Wed, 20 Apr 2022 07:11:45 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id i27so3789229ejd.9
        for <linux-pci@vger.kernel.org>; Wed, 20 Apr 2022 07:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D5oN6OjFAAM2Jtgw8cFuu+OC1yUTyBmH5VCH73tbJIs=;
        b=J2QfDs++WjQJaTh2gO5bBcfx5DI5gjex5gZVeg3++RKOiNZuEDy53Jzn/3ocatbQX8
         A9DP7bGr9pkjgTPyL7YhvA0JkMKR/iwU9fmDFHO5bhmg4ulHj7sGMmfaLGnM/ASvMM62
         POEYYCtKbLWI+TrSTNW7SnA06O2HHLl79aJMhzRDTQe0LmL7ZV87QPRA/SyB7CW/beUS
         +LGMgtjcSSj7aAiPP9a1mY3q8q/j4ueSRkS7/cTh0tsn4FMcK2rBiTL3m8CRIVq+x6Jf
         7LPAjHO8EkIwIi2yjoAHGP/dgcaUxH5Sf1GWwlCTBAZXDLzBZ69jhBfJ+f1jVD+1Lbcz
         KLmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D5oN6OjFAAM2Jtgw8cFuu+OC1yUTyBmH5VCH73tbJIs=;
        b=4qTFNEZdxuHtvhgRlP6RF285UwvDq6HKeEe8OQOykWhLC922bgAsQ6lXuDKnizKDK+
         JtmrYERaA25zxuUVxo5JHbSsuV0ujrJbDNDkIfhaxGJivzOAH9ZtF0f8rHbSBXs00BS8
         sYVXfTpgjx0UcG7mtAwb4G+Snf575tqIFlLA7CIZAQXt2GJm4tea7BRUkdiXyLKISU2n
         o0wmD0t2Dp8mEiCWKP6P7xB8cb8olQ4rAb1xOoQ7Y7uUtlpy0454hDX33ywdZtZbMiOM
         xb25Adqhg+f5irsHkx3petaCD2HZlSMPt6AfTTKxUfEDwdzcOEzhRac0xj2+OixkhG48
         YB+Q==
X-Gm-Message-State: AOAM531fJ3wOhD50dnbFnsuTcGHtMUgxHlSgzlhbQO4W5SBzkYSTGF6b
        lVwyxdQvXvNOxQ0cfByqhrVHYQ==
X-Google-Smtp-Source: ABdhPJyB1OGo392CHMXgZTS9PN4elzbRaBcXavX/HTTNgufEwPnYzRC9k42BVq0grtwj+114Sr0j+w==
X-Received: by 2002:a17:906:6a1d:b0:6ef:8745:bf91 with SMTP id qw29-20020a1709066a1d00b006ef8745bf91mr16669763ejc.76.1650463904199;
        Wed, 20 Apr 2022 07:11:44 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id v7-20020a50d087000000b00424269f1c75sm387465edd.96.2022.04.20.07.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 07:11:43 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] PCI: fix unused pci_restore_standard_config without suspend/hibernate
Date:   Wed, 20 Apr 2022 16:11:35 +0200
Message-Id: <20220420141135.444820-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pci_restore_standard_config() is called only by functions within
CONFIG_SUSPEND or CONFIG_HIBERNATION, so a configuration with only PM
leads to a warning:

  drivers/pci/pci-driver.c:533:12: error: ‘pci_restore_standard_config’ defined but not used [-Werror=unused-function]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/pci/pci-driver.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index dc18c1faf5e5..a2e6aabfa324 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -522,9 +522,9 @@ static void pci_device_shutdown(struct device *dev)
 		pci_clear_master(pci_dev);
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 
-/* Auxiliary functions used for system resume and run-time resume. */
+/* Auxiliary functions used for system resume. */
 
 /**
  * pci_restore_standard_config - restore standard config registers of PCI device
@@ -544,6 +544,11 @@ static int pci_restore_standard_config(struct pci_dev *pci_dev)
 	pci_pme_restore(pci_dev);
 	return 0;
 }
+#endif /* CONFIG_PM_SLEEP */
+
+#ifdef CONFIG_PM
+
+/* Auxiliary functions used for system resume and run-time resume. */
 
 static void pci_pm_default_resume(struct pci_dev *pci_dev)
 {
@@ -558,8 +563,7 @@ static void pci_pm_default_resume_early(struct pci_dev *pci_dev)
 	pci_restore_state(pci_dev);
 	pci_pme_restore(pci_dev);
 }
-
-#endif
+#endif /* CONFIG_PM */
 
 #ifdef CONFIG_PM_SLEEP
 
-- 
2.32.0

