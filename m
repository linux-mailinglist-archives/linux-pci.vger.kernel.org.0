Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3042A41BBCB
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 02:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243475AbhI2AnG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Sep 2021 20:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243471AbhI2AnF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Sep 2021 20:43:05 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1D6C06161C;
        Tue, 28 Sep 2021 17:41:25 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id g8so1901503edt.7;
        Tue, 28 Sep 2021 17:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zBaxdjR458Cms2rk+PE1YK0Xhx5uxYTQbasRo/1RH8s=;
        b=kAi7RnTYzsJw+xBNyo7tVSdA1R74ghjgx9CsY1SC3iVw5HcqooLIxFafkG4rW688zc
         DRme2z4pLza4ozX1s9g459KNL3eXe+HgxQiQf2i3wkR1JQH2x5MynMc+VVT7n24rom+I
         +p8KaGNR0PTjGGJKU7bCOEaYzGWbInIzoX9ERqDpTWwmXf6Jq2UCMCz/zF0KRB4iqPz/
         NcP/n6FK9Yxh9KSVGJbQQCNsMFqGBiCTvD5I4Axo2znnB/plzsGCHTThUOp58sIB/30s
         q2eJZAiNV1PgqVmDbzu6ywDjb8ukvQf/PUKt2gXaHSKTlcsMZjXHf5BHdWzknpGYWlwW
         a97A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zBaxdjR458Cms2rk+PE1YK0Xhx5uxYTQbasRo/1RH8s=;
        b=ym/Au0uZ8Pqa1mDOKASHf26KplAIB/3lD04uaAkZBscfJRm61PAzbqYrUXsGkhI7Mv
         +w6l9K5ur55jGeFWyN2HHsOZmy7PsKOT3DZasJpJ4TW499NFwQmqvo3Cgye7QOp+pYxj
         m/Bb4SkVC0gU2Spyy3XTp+Qxx+8V7Gq6MdeEX5GAnZ9ek5in1YnF1BLtHWvcuNuTc16t
         qYdMMuIIM3ayrmX13SPYqLlfm6slKGVQoGtXtyq42DuvESUZqOrLb8MdvZ2WI01q/g1U
         eOA9AlX7MqBGvF9zECUo2iuCP3tTxmGrGvzptRjF+IiZlEXx0tK9fIb+qFqFDOkixCze
         /9mA==
X-Gm-Message-State: AOAM532NCzdKliCORNIB8pwO9jxxLNtNBkufsMmTUXea7HYIcOb7j0TV
        aWjcj+m28IkC+lGMh905Ysc=
X-Google-Smtp-Source: ABdhPJz72n7t7ggRbMU/mxGc0sdAdt5XmtpU/sLNfJp3ce8zz9o9+fn37H3qdiJfweDcRM29/74gOw==
X-Received: by 2002:a50:d8c5:: with SMTP id y5mr11265142edj.370.1632876083805;
        Tue, 28 Sep 2021 17:41:23 -0700 (PDT)
Received: from localhost.localdomain ([2a02:ab88:10f:c9f0:35c7:3af0:a197:61d0])
        by smtp.googlemail.com with ESMTPSA id y1sm372727edv.79.2021.09.28.17.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 17:41:23 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 2/3] PCI/ASPM: Remove struct pcie_link_state.acceptable
Date:   Wed, 29 Sep 2021 02:41:15 +0200
Message-Id: <20210929004116.20650-3-refactormyself@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210929004116.20650-1-refactormyself@gmail.com>
References: <20210929004116.20650-1-refactormyself@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The acceptable latencies for each device on the bus are calculated within
pcie_aspm_cap_init() and cached in struct pcie_link_state.acceptable.
They are only used within pcie_aspm_check_latency() to validate actual
latencies. Thus, it is possible to avoid caching these values.

This patch:
 - removes `acceptable` from struct pcie_link_state
 - calculates the acceptable latency for each device directly
 - removes the calculations done within pcie_aspm_cap_init()

Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
---
 drivers/pci/pcie/aspm.c | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 9e85dfc56657..0c0c055823f1 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -65,12 +65,6 @@ struct pcie_link_state {
 	u32 clkpm_enabled:1;		/* Current Clock PM state */
 	u32 clkpm_default:1;		/* Default Clock PM state by BIOS */
 	u32 clkpm_disable:1;		/* Clock PM disabled */
-
-	/*
-	 * Endpoint acceptable latencies. A pcie downstream port only
-	 * has one slot under it, so at most there are 8 functions.
-	 */
-	struct aspm_latency acceptable[8];
 };
 
 static int aspm_disabled, aspm_force;
@@ -389,7 +383,7 @@ static struct pci_dev *pci_function_0(struct pci_bus *linkbus)
 
 static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 {
-	u32 latency, lnkcap_up, lnkcap_dw, l1_switch_latency = 0;
+	u32 reg32, latency, encoding, lnkcap_up, lnkcap_dw, l1_switch_latency = 0;
 	struct pci_dev *downstream;
 	struct aspm_latency latency_up, latency_dw;
 	struct aspm_latency *acceptable;
@@ -402,7 +396,13 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 
 	link = endpoint->bus->self->link_state;
 	downstream = pci_function_0(link->pdev->subordinate);
-	acceptable = &link->acceptable[PCI_FUNC(endpoint->devfn)];
+	pcie_capability_read_dword(endpoint, PCI_EXP_DEVCAP, &reg32);
+	/* Calculate endpoint L0s acceptable latency */
+	encoding = (reg32 & PCI_EXP_DEVCAP_L0S) >> 6;
+	acceptable->l0s = calc_l0s_acceptable(encoding);
+	/* Calculate endpoint L1 acceptable latency */
+	encoding = (reg32 & PCI_EXP_DEVCAP_L1) >> 9;
+	acceptable->l1 = calc_l1_acceptable(encoding);
 
 	while (link) {
 		/* Read direction exit latencies */
@@ -664,22 +664,11 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 
 	/* Get and check endpoint acceptable latencies */
 	list_for_each_entry(child, &linkbus->devices, bus_list) {
-		u32 reg32, encoding;
-		struct aspm_latency *acceptable =
-			&link->acceptable[PCI_FUNC(child->devfn)];
 
 		if (pci_pcie_type(child) != PCI_EXP_TYPE_ENDPOINT &&
 		    pci_pcie_type(child) != PCI_EXP_TYPE_LEG_END)
 			continue;
 
-		pcie_capability_read_dword(child, PCI_EXP_DEVCAP, &reg32);
-		/* Calculate endpoint L0s acceptable latency */
-		encoding = (reg32 & PCI_EXP_DEVCAP_L0S) >> 6;
-		acceptable->l0s = calc_l0s_acceptable(encoding);
-		/* Calculate endpoint L1 acceptable latency */
-		encoding = (reg32 & PCI_EXP_DEVCAP_L1) >> 9;
-		acceptable->l1 = calc_l1_acceptable(encoding);
-
 		pcie_aspm_check_latency(child);
 	}
 }
-- 
2.20.1

