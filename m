Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83F84446F8B
	for <lists+linux-pci@lfdr.de>; Sat,  6 Nov 2021 18:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234803AbhKFR4u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 6 Nov 2021 13:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233233AbhKFR4o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 6 Nov 2021 13:56:44 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A2DC061205;
        Sat,  6 Nov 2021 10:54:02 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id ee33so44973351edb.8;
        Sat, 06 Nov 2021 10:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K3WG4rAD+56vKxa50XW1TjNBq/BUIzSO/60jcuHZf/Q=;
        b=SNOF1DfDg4DpLqPempXc2Rm9C7wQ/auTZo7U8lWSpvKf5E00/sqfQKNAPwXJNPDloZ
         7ghptArMEL+RX7hsYwSFDhfvPpENUDQ4pVVuvoGsbhU4+J2I4wVS9tbETQOavC2He9lJ
         KngI1J2Oj7W72m/dvpCqpS2jY4QdlYj5sjizwa2wPrTNOSR4g4tmq3OHLsfIn2jtZdTr
         bU9yyC7F9UEmn+QQGAbUzYuePGrAHyRgHweDlxnXqjLzIUehxfpxZRkxFqA1ADBFPOaV
         q+7o1+L7hFAQIBScntpDRcOv0x8FGyxZkjlDIQ2J0e0YcYEJRGEmEO3I8GgP5MdLyjq+
         nqTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K3WG4rAD+56vKxa50XW1TjNBq/BUIzSO/60jcuHZf/Q=;
        b=07FBzE+e011DZqB46ZV5Gr1FJXzeRaqW0wF50oWHQco8xS4uUxf+eWXFygfrUh3uHZ
         TH2NzxuvW84O2bOSbEm9YBIIMDeSp+vt5IcG5Uhb+KpVV6zMGlXaXYcGZa98Ciy35Do5
         RzoUatysF0Dgc+tzhPVUGQobpccTAEQhixu0sJ9Pm56DTJ687XC4TgwUv/cpfCix0CMl
         7t/jD/qR2wiPxMLIrKrHHE7D1z+AqYgSC+VkfZzoslqAKbmkSJS3DMp2aAsRGE4vPnZE
         waTbq92gR/3sV/soexxUzbHA5M2IZ7xQvPoAPF5bmMfN1IEn3hIT/I/u0uer21Fk9kew
         GPqw==
X-Gm-Message-State: AOAM5320tAu5LKoJx7ACrlMww5BBybe6JOe1BwA7Mje4Wlws6LlMXKTx
        hUO/UsIfs42b4Qg6TNoUs64=
X-Google-Smtp-Source: ABdhPJz8j0dvlOxXY448+qcUjsMKlCqnNdHUwRmE3hrjCsqAgyUi6E9z+98/qnLMevGfOWKenFANNw==
X-Received: by 2002:a05:6402:2cd:: with SMTP id b13mr38280196edx.199.1636221241051;
        Sat, 06 Nov 2021 10:54:01 -0700 (PDT)
Received: from localhost.localdomain ([2a02:ab88:109:9f0:f6a6:7fbe:807a:e1cc])
        by smtp.googlemail.com with ESMTPSA id m12sm5753494ejj.63.2021.11.06.10.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 10:54:00 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 5/6] PCI/ASPM: Move pcie_aspm_sanity_check() upwards
Date:   Sat,  6 Nov 2021 18:53:52 +0100
Message-Id: <20211106175353.26248-6-refactormyself@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211106175353.26248-1-refactormyself@gmail.com>
References: <20211106175353.26248-1-refactormyself@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Move pcie_aspm_sanity_check() upwards to make more accessible.

Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
---
 drivers/pci/pcie/aspm.c | 70 ++++++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 9aaae476ea31..05ca165380e1 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -447,6 +447,41 @@ static void pci_clear_and_set_dword(struct pci_dev *pdev, int pos,
 	pci_write_config_dword(pdev, pos, val);
 }
 
+static int pcie_aspm_sanity_check(struct pci_dev *pdev)
+{
+	struct pci_dev *child;
+	u32 reg32;
+
+	/*
+	 * Some functions in a slot might not all be PCIe functions,
+	 * very strange. Disable ASPM for the whole slot
+	 */
+	list_for_each_entry(child, &pdev->subordinate->devices, bus_list) {
+		if (!pci_is_pcie(child))
+			return -EINVAL;
+
+		/*
+		 * If ASPM is disabled then we're not going to change
+		 * the BIOS state. It's safe to continue even if it's a
+		 * pre-1.1 device
+		 */
+
+		if (aspm_disabled)
+			continue;
+
+		/*
+		 * Disable ASPM for pre-1.1 PCIe device, we follow MS to use
+		 * RBER bit to determine if a function is 1.1 version device
+		 */
+		pcie_capability_read_dword(child, PCI_EXP_DEVCAP, &reg32);
+		if (!(reg32 & PCI_EXP_DEVCAP_RBER) && !aspm_force) {
+			pci_info(child, "disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'\n");
+			return -EINVAL;
+		}
+	}
+	return 0;
+}
+
 /* Calculate L1.2 PM substate timing parameters */
 static void aspm_calc_l1ss_info(struct pcie_link_state *link,
 				u32 aspm_support, u32 parent_l1ss_cap,
@@ -846,41 +881,6 @@ static void free_link_state(struct pcie_link_state *link)
 	kfree(link);
 }
 
-static int pcie_aspm_sanity_check(struct pci_dev *pdev)
-{
-	struct pci_dev *child;
-	u32 reg32;
-
-	/*
-	 * Some functions in a slot might not all be PCIe functions,
-	 * very strange. Disable ASPM for the whole slot
-	 */
-	list_for_each_entry(child, &pdev->subordinate->devices, bus_list) {
-		if (!pci_is_pcie(child))
-			return -EINVAL;
-
-		/*
-		 * If ASPM is disabled then we're not going to change
-		 * the BIOS state. It's safe to continue even if it's a
-		 * pre-1.1 device
-		 */
-
-		if (aspm_disabled)
-			continue;
-
-		/*
-		 * Disable ASPM for pre-1.1 PCIe device, we follow MS to use
-		 * RBER bit to determine if a function is 1.1 version device
-		 */
-		pcie_capability_read_dword(child, PCI_EXP_DEVCAP, &reg32);
-		if (!(reg32 & PCI_EXP_DEVCAP_RBER) && !aspm_force) {
-			pci_info(child, "disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'\n");
-			return -EINVAL;
-		}
-	}
-	return 0;
-}
-
 static struct pcie_link_state *alloc_pcie_link_state(struct pci_dev *pdev)
 {
 	struct pcie_link_state *link;
-- 
2.20.1

