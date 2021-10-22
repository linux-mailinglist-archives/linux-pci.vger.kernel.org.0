Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 935894378BA
	for <lists+linux-pci@lfdr.de>; Fri, 22 Oct 2021 16:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbhJVOKE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Oct 2021 10:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233013AbhJVOJr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Oct 2021 10:09:47 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B411C061243;
        Fri, 22 Oct 2021 07:07:30 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id s136so3427595pgs.4;
        Fri, 22 Oct 2021 07:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+KIUczUS/ZsYc2yKqmHED/7x17icKPInYDTolIdaty0=;
        b=R5SGZu++CgAI53CDoFpKRRq5pfPpbRWzsDQhASS7V4vht2a8aJA26iGAM6WMSY8/DI
         iwh/3R/FvCGNziPaSgeMjNtmqoG//S/ugGtHwv7FzwaV+D/6Ts9VQFQ9SMA5cRZPe6A6
         7bCbyu8IPjO4jLXNpe59zANpZ3tLFdg9fMiVg5ihOdFiexyP78XUVsCEXGblSkPCcLgK
         8IupRQ+hjlwQKGX2iZaduGm4oFG6mwBl0J6c4U6KoUjhDpo6Oys3yb8U3VhSIpD6M4w4
         HuNrJg14LPzjgVOWapzHaZbCk0EagD12edxAhjgpGv43/Fl8N1tq0EcBccWfaU35pGGH
         TIAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+KIUczUS/ZsYc2yKqmHED/7x17icKPInYDTolIdaty0=;
        b=8Gr+1KjcYnout5wk1RWkCjeq7dW3xkUlJL+DoQawHdh64iCBwjEY+0ntkdMNY/ZGYE
         7K+rFKGVT1QX7LkVjJsMnWJ5igpRlOWGeS9j6CE3m13u2+2md2dYWRd1lzChnP5vIOMW
         KqPct3/vof2qxhfGLm7cHg2+Oa7ncMXHkl9MYjyx+2zTymMDaLjKTVWf4PTlqvGY58uD
         6itCVzXYiFdlhISq1vLynw4SVmvr+fZ1sdbqt6gpXclBCWXn4BCF12ihZpcP0gt9AIGA
         WmPottSLkTd97QufVi6DRmyb7VAqgMzM30mP0OiddHjO4jWNOekmMXKWinpDVaT5zvK/
         3uww==
X-Gm-Message-State: AOAM530j5bPAkCxwiAjVMx5BRrpXtVZ4eWFuLrZNqYe/SlR+4A66Dm2J
        tPR9C7+absIR7WqWqwgbgTKUaHOcB7xReg==
X-Google-Smtp-Source: ABdhPJyEsS1l7Tar/HjbpqhXPB/7RZ8R0mvhJOIAjFQICeySHFB/Iw9Wd2lHo3yMnA7UWO/xk/F2AA==
X-Received: by 2002:a05:6a00:1309:b0:44d:4d1e:c930 with SMTP id j9-20020a056a00130900b0044d4d1ec930mr12610806pfu.65.1634911649761;
        Fri, 22 Oct 2021 07:07:29 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id e12sm9482990pfl.67.2021.10.22.07.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 07:07:29 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 3/6] PCI: brcmstb: split brcm_pcie_setup() into two funcs
Date:   Fri, 22 Oct 2021 10:06:56 -0400
Message-Id: <20211022140714.28767-4-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211022140714.28767-1-jim2101024@gmail.com>
References: <20211022140714.28767-1-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We need to split a function in two so that the driver can take advantage of
the recently added function pci_subdev_prepare() which is a member
of struct pci_host_bridge.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 30 +++++++++++++++++++--------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index cc30215f5a43..ba4d6daf312c 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -863,17 +863,10 @@ static inline int brcm_pcie_get_rc_bar2_size_and_offset(struct brcm_pcie *pcie,
 
 static int brcm_pcie_setup(struct brcm_pcie *pcie)
 {
-	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
 	u64 rc_bar2_offset, rc_bar2_size;
 	void __iomem *base = pcie->base;
-	struct device *dev = pcie->dev;
-	struct resource_entry *entry;
-	bool ssc_good = false;
-	struct resource *res;
-	int num_out_wins = 0;
-	u16 nlw, cls, lnksta;
-	int i, ret, memc;
-	u32 tmp, burst, aspm_support;
+	int ret, memc;
+	u32 tmp, burst;
 
 	/* Reset the bridge */
 	pcie->bridge_sw_init_set(pcie, 1);
@@ -956,6 +949,21 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 
 	if (pcie->gen)
 		brcm_pcie_set_gen(pcie, pcie->gen);
+	return 0;
+}
+
+static int brcm_pcie_linkup(struct brcm_pcie *pcie)
+{
+	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
+	struct device *dev = pcie->dev;
+	void __iomem *base = pcie->base;
+	struct resource_entry *entry;
+	struct resource *res;
+	int num_out_wins = 0;
+	u16 nlw, cls, lnksta;
+	bool ssc_good = false;
+	u32 aspm_support, tmp;
+	int ret, i;
 
 	/* Unassert the fundamental reset */
 	pcie->perst_set(pcie, 0);
@@ -1186,6 +1194,10 @@ static int brcm_pcie_resume(struct device *dev)
 	if (ret)
 		goto err_reset;
 
+	ret = brcm_pcie_linkup(pcie);
+	if (ret)
+		goto err_reset;
+
 	if (pcie->msi)
 		brcm_msi_set_regs(pcie->msi);
 
-- 
2.17.1

