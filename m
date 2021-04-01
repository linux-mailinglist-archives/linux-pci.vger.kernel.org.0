Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE8F352191
	for <lists+linux-pci@lfdr.de>; Thu,  1 Apr 2021 23:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235183AbhDAVV6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Apr 2021 17:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235113AbhDAVV5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Apr 2021 17:21:57 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F149C0613E6;
        Thu,  1 Apr 2021 14:21:56 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id j25so2355490pfe.2;
        Thu, 01 Apr 2021 14:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7XSm6/qzn9duNJgtAGMhBBSTeeaC2tU96ijTiVyfrw0=;
        b=FVZIRLrnc8G1Hy9rQgixadd2ErSk6SMttyrJQOLWi/5XMq0Cg0ILEkiaulBE+VmFta
         Fk/v9tsh1o+JslU3jZLly0kNadXbLPSOEuhPDchDCfF+8S5gru2p8WWxbqKKCL8Gn+UN
         7FTawmIMsHV9y6QvGzuoqMw+dmO3NqCLTSZNV46hrnIU7GNJRRiaetP8xcmF7yWVCD6T
         BtD9+rKJJfw6+FGl6YLL7PGUiU4bxKuj6k6AwDo4c69CS6Q1oqvQCG69vvDwrXFUKHVX
         9EVIsc5TM7AhBkKvC7+IudUmfss4KwzGldZ4MYRIQXDY2Hjs9e/xfVzPRoH8Sla8lgzy
         6cxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7XSm6/qzn9duNJgtAGMhBBSTeeaC2tU96ijTiVyfrw0=;
        b=c8l4q1seS1n8aGZoSAVwl3SLTp01sdtZUv/uQQ8+zTdEdJA8E0hVJFJsvjc9acrWuN
         f4yqH897LVIayeaqNHR2mSdNxfK7QzO76lhQtzIQHHe9jiOQ6fLxfrUGWzpxGudZmpr9
         NlC/gFu7mrUTlfqDJldT0HNzDM8xcImMf0hvbY+joTWzmscfEhbXnnVOFhklc+vdSi7T
         vRjS7JSLFACa9HwVFRv5K267ZVO2HJxH3I0cEBHYaZvKgrdP6FRvu1qzZgfz6n2jPHtO
         5pgglHwUIsQRStGe59LA9f3qwksuFyQUbSMATkHGz9eVHj45j0kNWNvWUHVcn5RCDFnJ
         jnMA==
X-Gm-Message-State: AOAM530EHdjnTUuJhesKRsSbFSmAPHjaTuYWXWZl44ZOEO89dLrCMUmv
        1U0cJKr5M7P+TiiHk0mCIYQuZP0/xy4=
X-Google-Smtp-Source: ABdhPJyfsLCcva5kpJAf0m0l/d1Xo7b+YAYAci8o03yqPZmVUlbZ1wQvQH2IXG+wFsRbemPv1EzAqw==
X-Received: by 2002:a63:78cc:: with SMTP id t195mr9011398pgc.196.1617312115571;
        Thu, 01 Apr 2021 14:21:55 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id q5sm5926707pfk.219.2021.04.01.14.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 14:21:55 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jim Quinlan <jquinlan@broadcom.com>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 1/6] PCI: brcmstb: Check return value of clk_prepare_enable()
Date:   Thu,  1 Apr 2021 17:21:41 -0400
Message-Id: <20210401212148.47033-2-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210401212148.47033-1-jim2101024@gmail.com>
References: <20210401212148.47033-1-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Check for failure of clk_prepare_enable() on device resume.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Fixes: 8195b7417018 ("PCI: brcmstb: Add suspend and resume pm_ops")
---
 drivers/pci/controller/pcie-brcmstb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index e330e6811f0b..4ce1f3a60574 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1161,7 +1161,9 @@ static int brcm_pcie_resume(struct device *dev)
 	int ret;
 
 	base = pcie->base;
-	clk_prepare_enable(pcie->clk);
+	ret = clk_prepare_enable(pcie->clk);
+	if (ret)
+		return ret;
 
 	ret = brcm_phy_start(pcie);
 	if (ret)
-- 
2.17.1

