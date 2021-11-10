Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC1044CC5F
	for <lists+linux-pci@lfdr.de>; Wed, 10 Nov 2021 23:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233711AbhKJWU3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Nov 2021 17:20:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233621AbhKJWUY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Nov 2021 17:20:24 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD95AC0797B8;
        Wed, 10 Nov 2021 14:15:05 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id n15-20020a17090a160f00b001a75089daa3so3049906pja.1;
        Wed, 10 Nov 2021 14:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DtWhfKdUtW9iOKlARDdNWnnImSZ5FB7Na1++POtAlgg=;
        b=LM7Ah0rKfOoHj+lixTe9M3QqNrzZ7r9PZ2Q+E7+ErGLfbyXA5s8RglAQZgt1FUrck1
         ON/2vWjlzQUftUJkwHqBs8YsReO8zt/ZFl0ejVH1QqbM7IoRHkYLwUxSd1E1LAAq1egi
         2m/NHpXXtSTB0iZa6CBkikESeFgEVpmxHE+sAS4hmSzTEGy3bjHB/ZhvFOeDpEyrAFVr
         9tTlOzVnlOfPConWe8SvpAOxdRcR+4CtkpUYmYenHbTs9Qb4tmTiWbAxgDja4upCDcoR
         PHwuupSvA7n3LYEKDykBf57h/ULOwtyPcVsKguEHFqKOiRk8cogXZ54mcu6/Tb6yS60H
         F8wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DtWhfKdUtW9iOKlARDdNWnnImSZ5FB7Na1++POtAlgg=;
        b=GMf0wjR+GLnmsAxq0KvWXH7e6dfeGHmL32j5DSZ6RB9+t3B/fQ1gckm62g7HL4/VLY
         7rEd+0coL/hLEMulS++9mq1FiL48YBAI9HWzTJrbQc6OI/xfdeXteJ2109891uslUIlo
         xwhBsI7gzLS7IkjBqLrm3O2nEqDF1VEcky+4ApqfWsjwlFoTbIsNCMJEa2R7Sq1j1F+1
         i03eLmeORlztlD9vaFkTtvR3H9sWTz4YDxjV4OCjmnLWZezFIFCjt2BOiEPWUy9ab2Lg
         1usApgeWf3QKKEn4/pLV5miwTSsaswFMGY9jsZWm1fu/pgVHxgMyaDru4VXzcass71Vu
         KKXg==
X-Gm-Message-State: AOAM533Y23DyZSIX16ExNOAsXNs6kx3ESjRzA3QaMOcsgwT55vOdk6d8
        Ug0HKk/yse9mCH3brXK3eF1j/71aKAM4cQ==
X-Google-Smtp-Source: ABdhPJyxzsEjf9jRaw67JXc4mjFC5lTQZqMd/0Rt9PxJGUaSDkuZVg58yf/bwW6/8MOU7wSjW15Efw==
X-Received: by 2002:a17:902:d114:b0:142:3934:be82 with SMTP id w20-20020a170902d11400b001423934be82mr2316791plw.40.1636582505108;
        Wed, 10 Nov 2021 14:15:05 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id q11sm611774pfk.192.2021.11.10.14.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 14:15:04 -0800 (PST)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v8 1/8] PCI: brcmstb: Change brcm_phy_stop() to return void
Date:   Wed, 10 Nov 2021 17:14:41 -0500
Message-Id: <20211110221456.11977-2-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211110221456.11977-1-jim2101024@gmail.com>
References: <20211110221456.11977-1-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We do not use the result of this function so make it void.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index cc30215f5a43..ff7d0d291531 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1111,9 +1111,10 @@ static inline int brcm_phy_start(struct brcm_pcie *pcie)
 	return pcie->rescal ? brcm_phy_cntl(pcie, 1) : 0;
 }
 
-static inline int brcm_phy_stop(struct brcm_pcie *pcie)
+static inline void brcm_phy_stop(struct brcm_pcie *pcie)
 {
-	return pcie->rescal ? brcm_phy_cntl(pcie, 0) : 0;
+	if (pcie->rescal)
+		brcm_phy_cntl(pcie, 0);
 }
 
 static void brcm_pcie_turn_off(struct brcm_pcie *pcie)
@@ -1143,14 +1144,13 @@ static void brcm_pcie_turn_off(struct brcm_pcie *pcie)
 static int brcm_pcie_suspend(struct device *dev)
 {
 	struct brcm_pcie *pcie = dev_get_drvdata(dev);
-	int ret;
 
 	brcm_pcie_turn_off(pcie);
-	ret = brcm_phy_stop(pcie);
+	brcm_phy_stop(pcie);
 	reset_control_rearm(pcie->rescal);
 	clk_disable_unprepare(pcie->clk);
 
-	return ret;
+	return 0;
 }
 
 static int brcm_pcie_resume(struct device *dev)
-- 
2.17.1

