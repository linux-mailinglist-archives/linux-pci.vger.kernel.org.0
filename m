Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 463E74403BB
	for <lists+linux-pci@lfdr.de>; Fri, 29 Oct 2021 22:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbhJ2UGI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Oct 2021 16:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbhJ2UGG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Oct 2021 16:06:06 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C2BC061570;
        Fri, 29 Oct 2021 13:03:37 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id o6-20020a17090a0a0600b001a64b9a11aeso818962pjo.3;
        Fri, 29 Oct 2021 13:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+KIUczUS/ZsYc2yKqmHED/7x17icKPInYDTolIdaty0=;
        b=qjSLHUXCDQWygnVlyrtmeX80jN8aeq1XvoNqVZbcgz3pWBNXh2WUTbMxhMcqf6Dy6L
         Y4b+BpSNhZm3TwUwIyJpnh7f9gY/5lESKlhSZmdENaKYakRR4wWQ2GAh40GPdp7Z5csi
         S55V7NyXufyKihgew1e11sQGlAkkspyYiGOvhjDaiPCWkge568MSaSuoJFqrHiZF6flb
         D6lAmbmbfPM4jB1keRmDH6qOEwYbUo49nk5ujBzeKcAqYt1VML7em0zYZYwk1uravbYj
         f7fabu+/GOWr9aP30GdqxwFQHniV9QABhzWk5Jx24yBOhjV1dHSpHt3duL95ucNnVCX2
         rM9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+KIUczUS/ZsYc2yKqmHED/7x17icKPInYDTolIdaty0=;
        b=B4KqN5zql6A73JQrBuSjZCucG2rjPRwFUCcx3hhUZi2qOLw5RVaoDoo8250pgHNv6d
         j6FtJcF0ax2m/pxpnem5VMx8+gNWfaf+WuxvhZ5HHXVWPYbgq6xBonj55z7CiKkLm0mF
         PLOYJbJOinSPufpsfQ7E8SH7gZKMM7qBznH0ugU3EFHKqBfODTTLOH4QFsbFL3pwp406
         YheZAjwjnihS1UGuK/NVcfnVA7Tu2VfKuRFQtuz4q9n876rKYBvSFniJZVYKsDnWSbKV
         YnzDGjo+g5mhq5G/6shCuXNgwnWoo/Bdeh/35K4aUsUHRFipZB1X/mKKPWKN/1eA67ic
         adOg==
X-Gm-Message-State: AOAM533tJMIldxrh2KWYiljBCcujqSs7KVq+E9lAgLalRwUZ63rKYmOE
        pHdRDk/KCffhv1+tiWGmQ5/39AS2sCMCPA==
X-Google-Smtp-Source: ABdhPJz8kWh0F8QgJktCkgyP+kh03917s5z8vxLV8DEMrXsbHm9kC89imHO+DLcCD6SsMQdbqPK9cQ==
X-Received: by 2002:a17:902:64c2:b0:141:c171:b99b with SMTP id y2-20020a17090264c200b00141c171b99bmr351680pli.55.1635537816878;
        Fri, 29 Oct 2021 13:03:36 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id j16sm8775041pfj.16.2021.10.29.13.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 13:03:36 -0700 (PDT)
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
Subject: [PATCH v6 6/9] PCI: brcmstb: split brcm_pcie_setup() into two funcs
Date:   Fri, 29 Oct 2021 16:03:14 -0400
Message-Id: <20211029200319.23475-7-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211029200319.23475-1-jim2101024@gmail.com>
References: <20211029200319.23475-1-jim2101024@gmail.com>
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

