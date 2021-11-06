Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7720C446F83
	for <lists+linux-pci@lfdr.de>; Sat,  6 Nov 2021 18:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234711AbhKFR4l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 6 Nov 2021 13:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233233AbhKFR4k (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 6 Nov 2021 13:56:40 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A307C061570;
        Sat,  6 Nov 2021 10:53:59 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id j21so44583739edt.11;
        Sat, 06 Nov 2021 10:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6D5HkkzZ/+jWBfSY9gLjOQ9sfmUeP65T8bu+SScNXxY=;
        b=mqT8opC1vtsJeLwFdLCmo9jx/z0UjbZ4IiGMX906qH/reDbnTKfShqHe9qwUnb1qJ9
         rr8JaLowSYpJ94OAwZRgJ47gbTHlRw1oFB5h38s/7bYID61Oj/bya8WzlNcqi0VPDDeQ
         M+S3kQeZ+n1dXprEY0luKrX3Eu33pSiAx0VH0LAfxdUq1TnZ/5roBtzHnigP/0AqJt4T
         FzPnWIdPddx+Lm83s0vsOt0/AATsAe65w2cGMWSHyWWCFz9Pk+LpqxDVcJHfuy4aAAsJ
         t40S43yqP3L3gvaHkxhzuLsbLRL6FG3E+mpSMtFQAt1Aa/MM8A5nsSm4HplX6a8BlSKq
         6K1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6D5HkkzZ/+jWBfSY9gLjOQ9sfmUeP65T8bu+SScNXxY=;
        b=cNJZDuMSn6VMEYvjqpizwpFO1LVNZWqAU80giO2yUKal2sUk6AX2SNOXyPyRyWDgFF
         UaNu96N27BfYnONHr36EFcJ/cWkFyfHLrixf8mTUkGZkQocPAXGMfF5ffbac0HdJFQcP
         AqixuvR/8Liltok8tjPyUXUy6ssWqe7wFd9JeK0XOHehNdgbBhus0rtj8Q0rWyrREFab
         DagCClbM9Id1S4KcHfX1wur6pL+eCpWNrI1oVzXJpCbXV8dZviGJV1Xc+ex2+Pwq9wBL
         Xo8oR2tXeDrZ9lgL6a+uK9cC2Mf7Fzo6cd+lB1oODgzHaBahLCov2/pxPWOv39bp2FKg
         NVLw==
X-Gm-Message-State: AOAM5330xQ55Q3ZxU8aAqsRWbUDL9xjPN/li/R7CJPApGau2f6JZaV+M
        zfkyLcqsV+NlBFPhZUKcRwg+sRmDhCY=
X-Google-Smtp-Source: ABdhPJxHay+IlnQngLVeJ5UftGjI+KZHVvns+uFn7U9nM1+xd765EY05nyQ4ZL8koht9Lsl2fDS1lw==
X-Received: by 2002:a17:906:309b:: with SMTP id 27mr18284487ejv.129.1636221237719;
        Sat, 06 Nov 2021 10:53:57 -0700 (PDT)
Received: from localhost.localdomain ([2a02:ab88:109:9f0:f6a6:7fbe:807a:e1cc])
        by smtp.googlemail.com with ESMTPSA id m12sm5753494ejj.63.2021.11.06.10.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 10:53:57 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 1/6] PCI/ASPM: Extract out L1SS_CAP calculations
Date:   Sat,  6 Nov 2021 18:53:48 +0100
Message-Id: <20211106175353.26248-2-refactormyself@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211106175353.26248-1-refactormyself@gmail.com>
References: <20211106175353.26248-1-refactormyself@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Inside pcie_aspm_cap_init() the L1SS_CAP of both ends of the link is
calculated. The values are used to calculate link->aspm_support and
link->aspm_enabled. Isolating this calcution with simplify
pcie_aspm_cap_init().

Extract the calculations of L1SS_CAP on both ends into
aspm_calc_both_l1ss_caps().

Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
---
 drivers/pci/pcie/aspm.c | 42 ++++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 013a47f587ce..057c6768fb7b 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -540,6 +540,30 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
 	}
 }
 
+static void aspm_calc_both_l1ss_caps(struct pcie_link_state *link,
+				    u32 *up_l1ss_cap, u32 *dwn_l1ss_cap)
+{
+	struct pci_dev *child = link->downstream, *parent = link->pdev;
+
+	pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CAP,
+			      up_l1ss_cap);
+	pci_read_config_dword(child, child->l1ss + PCI_L1SS_CAP,
+			      dwn_l1ss_cap);
+
+	if (!(*up_l1ss_cap & PCI_L1SS_CAP_L1_PM_SS))
+		*up_l1ss_cap = 0;
+	if (!(*dwn_l1ss_cap & PCI_L1SS_CAP_L1_PM_SS))
+		*dwn_l1ss_cap = 0;
+
+	/*
+	 * If we don't have LTR for the entire path from the Root Complex
+	 * to this device, we can't use ASPM L1.2 because it relies on the
+	 * LTR_L1.2_THRESHOLD.  See PCIe r4.0, secs 5.5.4, 6.18.
+	 */
+	if (!child->ltr_path)
+		*dwn_l1ss_cap &= ~PCI_L1SS_CAP_ASPM_L1_2;
+}
+
 static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 {
 	struct pci_dev *child = link->downstream, *parent = link->pdev;
@@ -606,23 +630,7 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	link->latency_dw.l1 = calc_l1_latency(child_lnkcap);
 
 	/* Setup L1 substate */
-	pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CAP,
-			      &parent_l1ss_cap);
-	pci_read_config_dword(child, child->l1ss + PCI_L1SS_CAP,
-			      &child_l1ss_cap);
-
-	if (!(parent_l1ss_cap & PCI_L1SS_CAP_L1_PM_SS))
-		parent_l1ss_cap = 0;
-	if (!(child_l1ss_cap & PCI_L1SS_CAP_L1_PM_SS))
-		child_l1ss_cap = 0;
-
-	/*
-	 * If we don't have LTR for the entire path from the Root Complex
-	 * to this device, we can't use ASPM L1.2 because it relies on the
-	 * LTR_L1.2_THRESHOLD.  See PCIe r4.0, secs 5.5.4, 6.18.
-	 */
-	if (!child->ltr_path)
-		child_l1ss_cap &= ~PCI_L1SS_CAP_ASPM_L1_2;
+	aspm_calc_both_l1ss_caps(link, &parent_l1ss_cap, &child_l1ss_cap);
 
 	if (parent_l1ss_cap & child_l1ss_cap & PCI_L1SS_CAP_ASPM_L1_1)
 		link->aspm_support |= ASPM_STATE_L1_1;
-- 
2.20.1

