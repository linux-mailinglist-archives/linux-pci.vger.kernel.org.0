Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 090E6457720
	for <lists+linux-pci@lfdr.de>; Fri, 19 Nov 2021 20:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236021AbhKSTmg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Nov 2021 14:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233316AbhKSTm0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Nov 2021 14:42:26 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C0FC06173E;
        Fri, 19 Nov 2021 11:39:23 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id l25so30491194eda.11;
        Fri, 19 Nov 2021 11:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I11JeP0C+xPtxQfTDFdcykWMdcdXSfkW887zDpRNp50=;
        b=jjLXvrs1+lYVb8bA/DCI4jUWFv2zX6rCMYZmT/vQVNgpKyAVxkiz09+AXkGUazWcg3
         LapHY46+QKARUltlcDnQR9Cu6YxexX/ZL+SdYsLxLl9ck5WUxYLcp71lhWF71AwdyZw7
         4ccDQq2mchhpHLTsdbRqXj5jmRSkKFOAXfK9ARRSunKT0CXg/h+RjBBcu3dG3fEW+2x1
         I/1FaJZlfHBLj+ixQA/fD85nwzeHzXkQ8/c6IU3fcr7aySZDSy2WxgcV1LSYU3hr0zH2
         VIybwbANdq/Lr3oa7mij7LJBxkNEyboZhEM773pD/LSUgB89Ylml1C4YFQ0JRQv6ux/r
         jAAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I11JeP0C+xPtxQfTDFdcykWMdcdXSfkW887zDpRNp50=;
        b=uXdvxRSZwGBBL0Y10UN8DXZQ7jhw8932U3YBfR1xuyiuQrPRzJqCt+eRgATtT7IuOa
         aYiHIDPtMhu8D2HJLqboozficj3UG/7gYAcuZX9qJYr1xrQY6S6NNog428LCec8ta+dm
         fsbRPOOEPIXjb2IBbNJr3FNw0tQbGH02tDOn9439EyUzpA5iCpT6eg2tqjprEdzpNyuQ
         hnxkMMsQSONsETNznvJLh3F1cZFvwk06jt0Qis3sPAJUbnDrEPeCONfHG8lnJ9d5pNuj
         ggQhZPqvR+P0J5bkVVd5D6VN51+GFnn6KAMwFTW5kkkVJhL7ZD4V0wpiMFdyZMV2tIls
         M0yw==
X-Gm-Message-State: AOAM533RhxWhIWyeGaoUXLzlfhPW/wbnnBQBdkMWJguZtmfH/tb1sVac
        AjCSs0q1rXleI6nognufbOg=
X-Google-Smtp-Source: ABdhPJyrUyIXsEjIX9xoZgGdtwJWdJrK7xdU/tsgGq4gKDofhYBtSYBSgwVtCNOeAzIrxEy0BbaIGg==
X-Received: by 2002:a17:907:1b16:: with SMTP id mp22mr11402616ejc.503.1637350762544;
        Fri, 19 Nov 2021 11:39:22 -0800 (PST)
Received: from localhost.localdomain (catv-176-63-2-222.catv.broadband.hu. [176.63.2.222])
        by smtp.googlemail.com with ESMTPSA id sb19sm327521ejc.120.2021.11.19.11.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 11:39:22 -0800 (PST)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Bolarinwa O. Saheed" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, hch@lst.de
Subject: [RFC PATCH v5 1/4] PCI/ASPM: Move pci_function_0() upward
Date:   Fri, 19 Nov 2021 20:37:29 +0100
Message-Id: <20211119193732.12343-2-refactormyself@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211119193732.12343-1-refactormyself@gmail.com>
References: <20211119193732.12343-1-refactormyself@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: "Bolarinwa O. Saheed" <refactormyself@gmail.com>

To call pci_function_0() directly from other functions,
move its definition upward to a more accessible location.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bolarinwa O. Saheed <refactormyself@gmail.com>
---
 drivers/pci/pcie/aspm.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 52c74682601a..6f128b654730 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -105,6 +105,20 @@ static const char *policy_str[] = {
 
 #define LINK_RETRAIN_TIMEOUT HZ
 
+/*
+ * The L1 PM substate capability is only implemented in function 0 in a
+ * multi function device.
+ */
+static struct pci_dev *pci_function_0(struct pci_bus *linkbus)
+{
+	struct pci_dev *child;
+
+	list_for_each_entry(child, &linkbus->devices, bus_list)
+		if (PCI_FUNC(child->devfn) == 0)
+			return child;
+	return NULL;
+}
+
 static int policy_to_aspm_state(struct pcie_link_state *link)
 {
 	switch (aspm_policy) {
@@ -423,20 +437,6 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 	}
 }
 
-/*
- * The L1 PM substate capability is only implemented in function 0 in a
- * multi function device.
- */
-static struct pci_dev *pci_function_0(struct pci_bus *linkbus)
-{
-	struct pci_dev *child;
-
-	list_for_each_entry(child, &linkbus->devices, bus_list)
-		if (PCI_FUNC(child->devfn) == 0)
-			return child;
-	return NULL;
-}
-
 static void pci_clear_and_set_dword(struct pci_dev *pdev, int pos,
 				    u32 clear, u32 set)
 {
-- 
2.20.1

