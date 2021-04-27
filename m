Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8799336CAA2
	for <lists+linux-pci@lfdr.de>; Tue, 27 Apr 2021 19:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238637AbhD0Rwg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Apr 2021 13:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238144AbhD0Rwg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Apr 2021 13:52:36 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F64EC061756;
        Tue, 27 Apr 2021 10:51:52 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id lr7so13197450pjb.2;
        Tue, 27 Apr 2021 10:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2TeMQIR29LL2unimARSS4Lts2CWaYP5hnwBOgRuHstg=;
        b=QdGe6x34JJei2d/ron5yM0DJQaJi1jeLsPy+/ZgW8umuLF/6hL54BgrJOy72zTLBjj
         SaK5FWmffeSlWH5iOk1FAJzl5PWqPNY0lPgOA5SoFwV0/2U0dVHZ0jjDJkB/LW1qInfS
         wq2eVemAQ6lsSAsYA3EN1hzrNckL75XUZy/osCJ5UlUQCbmfEpjZZocSlIxOYVBx/mZL
         U/iMQ+0T33Mgv4wd74WTfR7YUksY5jo7JzL6mJ5MNE6JTiIUTDMIl6zX4PT9PejgPwQR
         r5nEtNC8rKuUUFqSPLFX40vmF4R558O6AWsl/aBxO/vk9eHCR05ZAIhLcyS83em4fyeA
         5xTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2TeMQIR29LL2unimARSS4Lts2CWaYP5hnwBOgRuHstg=;
        b=HrgyxdGPCW8npNH1vfQOy8JRycTED6Au7dYGbaVpaLoqpQFA6S730qJjnrooq1wQlO
         y6X6mpoM9oLnVZbkl1JJZT/X+RAnLqn3EJGouMaMET+xxnSxCXOxAdpRsFUafVZFhKnK
         dWNuu1rF4ovfLzOflsF79T6ndRtsAbrW2wAD/VHI053vUOY2wivnq+BqRs7MuiVTup+M
         T58kAN0AsO7486q9Dzj3rVeLn3uDgRiHt7/NZgKAM0Bu4zOkuftk0s55haR24rZ72GA4
         IzW9ERmLrF/FWFfKW2SQ+4U8H7hz/1iVSA6oGFp1cXE0IC86MjzZbR7JLkRoZnfl1FxK
         ELZQ==
X-Gm-Message-State: AOAM533eLAnIxsgOC3qECDV5RVxSbhTe9yvTre6cz/icKzUL/YrqL1B2
        ++Ps4yXPZFEjV7dxXkK+Yflx9vc5hLs=
X-Google-Smtp-Source: ABdhPJx3pj84P+TymUJU7/RCESFFoXJOkjgVGHcMsSz22PuKQmBEfFdZP2cdrdcIWYQSdH7bw/9cXg==
X-Received: by 2002:a17:90b:e95:: with SMTP id fv21mr13283405pjb.107.1619545911874;
        Tue, 27 Apr 2021 10:51:51 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id h21sm2456833pfo.211.2021.04.27.10.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 10:51:51 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 2/4] PCI: brcmstb: Give 7216 SOCs their own config type
Date:   Tue, 27 Apr 2021 13:51:37 -0400
Message-Id: <20210427175140.17800-3-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210427175140.17800-1-jim2101024@gmail.com>
References: <20210427175140.17800-1-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This distinction is required for an imminent commit.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 4ce1f3a60574..3b6a62dd2e72 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -257,6 +257,13 @@ static const struct pcie_cfg_data bcm2711_cfg = {
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
 };
 
+static const struct pcie_cfg_data bcm7216_cfg = {
+	.offsets	= pcie_offset_bcm7278,
+	.type		= BCM7278,
+	.perst_set	= brcm_pcie_perst_set_7278,
+	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_7278,
+};
+
 struct brcm_msi {
 	struct device		*dev;
 	void __iomem		*base;
@@ -1220,7 +1227,7 @@ static const struct of_device_id brcm_pcie_match[] = {
 	{ .compatible = "brcm,bcm4908-pcie", .data = &bcm4908_cfg },
 	{ .compatible = "brcm,bcm7211-pcie", .data = &generic_cfg },
 	{ .compatible = "brcm,bcm7278-pcie", .data = &bcm7278_cfg },
-	{ .compatible = "brcm,bcm7216-pcie", .data = &bcm7278_cfg },
+	{ .compatible = "brcm,bcm7216-pcie", .data = &bcm7216_cfg },
 	{ .compatible = "brcm,bcm7445-pcie", .data = &generic_cfg },
 	{},
 };
-- 
2.17.1

