Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D1827752E
	for <lists+linux-pci@lfdr.de>; Thu, 24 Sep 2020 17:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbgIXPYP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Sep 2020 11:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728285AbgIXPYO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Sep 2020 11:24:14 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC64C0613CE
        for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2020 08:24:14 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id z23so4982545ejr.13
        for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2020 08:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7kHwfcAazeBg+h2uEVovJwlfIIrEWzUTpgb6sW8h8RI=;
        b=cKO1/dw7vR3pvZAtvJzVVZU3A0UrzI7YmHvx0MDAmeRXVV0jWVmum7kzwPL5gjOE1b
         01wD06CN9lIYPnCn8yfjGd8a0EefOejZOeRx1mSt+avP5Vmi+8ym5P031TdYf4SJUcvH
         XaeRkMXU8aeocsep0hN7697QCbYZPj7MLARWlZzB848mO8ZZ8XmEzKoikkAnS3QbeSTh
         d/2vhEWZOzR0IXi1dZQDv8/sgHwDR5La97NTI7a5M2IFsS39CJkPp0vTrE6ozrmIQp/+
         HOr8iuQc2GbAhsr+NwN51lf1RdZnXiql1i+BjeRLCpyRkckXZ7izmrBnqDdsyQfgRLvo
         iRqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7kHwfcAazeBg+h2uEVovJwlfIIrEWzUTpgb6sW8h8RI=;
        b=Z9adWHPDeOdIOfk9Vl/wmxzt62YM1kQgrXIa2FWcY9xVWV1WyLokoVORZoqhSUF5aa
         aAgYmK4VyXZvHBrq2jeYDiDESt+Q4i3f1v6HEQ2KZ1p9pW2gvGGL/HUSAnepHLMOEI3f
         wPggaWwVmqz73wUwQYUWxNxf9n1dcOlN9oSGBC0HNfM/CHR9CXY4DU3LBNfNZw2EDqg6
         VCyd28ox5jYNw249mURkdUSV2zQ/XjEqrwav5JwYvnKMzFzbjhc0qkwUDDnwIyVIyEQg
         wWEtg2elYHgnwinN3je2Zq+psQFo7HkKObvo8tS5WbEwoH8LN9KDnveM6XO9O0qaQn1y
         4FeQ==
X-Gm-Message-State: AOAM533qaHkPeKCgHsWqyL2KpEeQ053z7bKkCixQ1RbsHcoVSs3lzCgD
        BhfOtkSxxmbSZq+ilUp+oRI=
X-Google-Smtp-Source: ABdhPJycTMt0iBMbMs1r0za9D8QSz2i9l1CXXdE5NuEwInEv+Xpo+JY/udUHiXtYG9OI+L2bzXmyNw==
X-Received: by 2002:a17:906:f1d5:: with SMTP id gx21mr384571ejb.165.1600961053192;
        Thu, 24 Sep 2020 08:24:13 -0700 (PDT)
Received: from net.saheed (5402C65D.dsl.pool.telekom.hu. [84.2.198.93])
        by smtp.gmail.com with ESMTPSA id i7sm2641735ejo.22.2020.09.24.08.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 08:24:12 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH v2 1/7] PCI/ASPM: Cache device's ASPM link capability in struct pci_dev
Date:   Thu, 24 Sep 2020 16:24:37 +0200
Message-Id: <20200924142443.260861-2-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20200924142443.260861-1-refactormyself@gmail.com>
References: <20200924142443.260861-1-refactormyself@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pcie_get_aspm_reg() reads LNKCAP to learn whether the device supports
ASPM L0s and/or L1 and L1 substates.

If we cache the entire LNKCAP word early enough, we may be able to
use it in other places that read LNKCAP, e.g. pcie_get_speed_cap(),
pcie_get_width_cap(), pcie_init(), etc.

 - Add struct pci_dev.lnkcap (u32)
 - Read PCI_EXP_LNKCAP in set_pcie_port_type() and save it
   in pci_dev.lnkcap
 - Use pdev->lnkcap instead of reading PCI_EXP_LNKCAP

Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
---
 drivers/pci/pcie/aspm.c | 7 ++-----
 drivers/pci/probe.c     | 1 +
 include/linux/pci.h     | 1 +
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 253c30cc1967..d7e69b3595a0 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -177,15 +177,13 @@ static void pcie_set_clkpm(struct pcie_link_state *link, int enable)
 static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
 {
 	int capable = 1, enabled = 1;
-	u32 reg32;
 	u16 reg16;
 	struct pci_dev *child;
 	struct pci_bus *linkbus = link->pdev->subordinate;
 
 	/* All functions should have the same cap and state, take the worst */
 	list_for_each_entry(child, &linkbus->devices, bus_list) {
-		pcie_capability_read_dword(child, PCI_EXP_LNKCAP, &reg32);
-		if (!(reg32 & PCI_EXP_LNKCAP_CLKPM)) {
+		if (!(child->lnkcap & PCI_EXP_LNKCAP_CLKPM)) {
 			capable = 0;
 			enabled = 0;
 			break;
@@ -397,9 +395,8 @@ static void pcie_get_aspm_reg(struct pci_dev *pdev,
 			      struct aspm_register_info *info)
 {
 	u16 reg16;
-	u32 reg32;
+	u32 reg32 = pdev->lnkcap;
 
-	pcie_capability_read_dword(pdev, PCI_EXP_LNKCAP, &reg32);
 	info->support = (reg32 & PCI_EXP_LNKCAP_ASPMS) >> 10;
 	info->latency_encoding_l0s = (reg32 & PCI_EXP_LNKCAP_L0SEL) >> 12;
 	info->latency_encoding_l1  = (reg32 & PCI_EXP_LNKCAP_L1EL) >> 15;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 03d37128a24f..2d5898f05f89 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1486,6 +1486,7 @@ void set_pcie_port_type(struct pci_dev *pdev)
 	pdev->pcie_flags_reg = reg16;
 	pci_read_config_word(pdev, pos + PCI_EXP_DEVCAP, &reg16);
 	pdev->pcie_mpss = reg16 & PCI_EXP_DEVCAP_PAYLOAD;
+	pcie_capability_read_dword(pdev, PCI_EXP_LNKCAP, &pdev->lnkcap);
 
 	parent = pci_upstream_bridge(pdev);
 	if (!parent)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 835530605c0d..5b305cfeb1dc 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -375,6 +375,7 @@ struct pci_dev {
 						   bit manually */
 	unsigned int	d3_delay;	/* D3->D0 transition time in ms */
 	unsigned int	d3cold_delay;	/* D3cold->D0 transition time in ms */
+	u32		lnkcap;		/* Link Capabilities */
 
 #ifdef CONFIG_PCIEASPM
 	struct pcie_link_state	*link_state;	/* ASPM link state */
-- 
2.18.4

