Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B24C446F78
	for <lists+linux-pci@lfdr.de>; Sat,  6 Nov 2021 18:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbhKFRz5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 6 Nov 2021 13:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234707AbhKFRz4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 6 Nov 2021 13:55:56 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34436C061570;
        Sat,  6 Nov 2021 10:53:15 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id j21so44579446edt.11;
        Sat, 06 Nov 2021 10:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nbOjDct3Mi8YpAbJdZDOqR4PzB05X2wNYYMTuBfzE7k=;
        b=NTbJrxWojFdf4mOBjeTBJg1DMSxlxr/rm5WnHju3Au9ytT279EAsWXOieTl44bBEeA
         JbaoZ7W/N9klqP0rz7BtURrPN1p2RznOYKKXn6xnxQ3NTte4AL9N6Cugh0cZeEBfckQu
         UUGoK1UcxVayjWIZP9XgZS5pqfsH6xJgdwX9R+MkQC4MGW5mvk48Dcg8GU02lcLX1htV
         So22ojHNdi49TxrpXxQ6mnJsV6yzaE5gCKESAz+AXJTLElhjZIk2hs+Xd9c7/N0XKBWS
         i3fCsIfFbb13DWihAyS592yycd8LCm86nVFQ42iINmvWEWrNj1KHB2dyAIAjdjhQrH5F
         dNeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nbOjDct3Mi8YpAbJdZDOqR4PzB05X2wNYYMTuBfzE7k=;
        b=RLN6/y8rgprsKbuLch9mZaUFLUCZXV07OyjIz5XbCtIq7SC+8FCgoKt45UIqeLcWIi
         tDsmcIRf7QN9M/2YM73LNDhqCyjylvs8XW0BfcsYQccAvTbronbWpcnIdXZ5n0J5dWg8
         Qmm7oPaRI5ib7MFuYGHrQHkAUx80eojDPIsk4yansMmHv6FmTt0Xd41BqwaN6pbdfnnJ
         twmJXpItqqojh/upgCWryXr9XYAdp1ovwERT0F8WYQJ+0XhXZ6FtBWVMlgqbXCbQKqEL
         a0UCsdw7RkcZqRxL/HrylPvXOxLiRWUQvie6hMjZYaAXmE6r8EaxhpNNRs0QtKfLCSqc
         ROew==
X-Gm-Message-State: AOAM5337Pc7lb0h1hVSajaW3pm/PxxJ8bf9ECTizxK+7fLWvkpk77GbW
        JzChZHsqZDzJb8yPmKIlnbqW1XuGGjQ=
X-Google-Smtp-Source: ABdhPJz08L5d979C2bchJhsyJbjSGUlwTCY3LU+PcUrS4SSOeSY0oE5ELpiz2BR9qGo/1LAp1MyOJw==
X-Received: by 2002:a50:9d8e:: with SMTP id w14mr90190311ede.74.1636221193598;
        Sat, 06 Nov 2021 10:53:13 -0700 (PDT)
Received: from localhost.localdomain ([2a02:ab88:109:9f0:f6a6:7fbe:807a:e1cc])
        by smtp.googlemail.com with ESMTPSA id g10sm6364857edr.56.2021.11.06.10.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 10:53:13 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Bolarinwa O. Saheed" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v4 1/4] PCI/ASPM: Move pci_function_0() upward
Date:   Sat,  6 Nov 2021 18:53:02 +0100
Message-Id: <20211106175305.25565-2-refactormyself@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211106175305.25565-1-refactormyself@gmail.com>
References: <20211106175305.25565-1-refactormyself@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: "Bolarinwa O. Saheed" <refactormyself@gmail.com>

To call pci_function_0() directly from other functions,
move its definition upward to a more accessible location.

Signed-off-by: Bolarinwa O. Saheed <refactormyself@gmail.com>
---
 drivers/pci/pcie/aspm.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 013a47f587ce..a6d89c2c5b60 100644
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

