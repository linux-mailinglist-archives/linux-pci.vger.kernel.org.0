Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA711F9191
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jun 2020 10:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbgFOIcu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Jun 2020 04:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728773AbgFOIcp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Jun 2020 04:32:45 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E687C05BD43;
        Mon, 15 Jun 2020 01:32:45 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id o8so4266571wmh.4;
        Mon, 15 Jun 2020 01:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5N7OiTkpW2bbIsUq9FnRk9cirBO+6YwRec/YN067b5E=;
        b=W/ldJLhCdUJj5d05mtV4pK65pjgE+/YRWMSLx9Ubvv++oDnBBIL5FwSU4I1vbGgwuG
         S19kPYUbfK+bbLud6LxLvZOc0qwk3cInUEb4d9luu0OT5Yo1sinR3yBNWJ03r3oP/IgL
         e+KCcuHvL8OqUgoioVPrwkT/CMV3p9DkA+8Nd12c7OI/ntMDv0QsL8hPJnyLTTYfR0Cr
         ZrTtT/JhkbNzcrB4rt+M5vguZV0YJ6NManuAQmbeZHMQXLPFltrw8ilsv/t46Go6sg+Q
         3mUSGrAahLu1bsuV4x8nlY8jsYO7zJtvYxSvk7PXWVqVbgKDgpUb74sxtkeaIxDqkQLH
         pLZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5N7OiTkpW2bbIsUq9FnRk9cirBO+6YwRec/YN067b5E=;
        b=i6Q5Xqbtw6L+iKokRrNMG+pvCo3/Yzr9pav1twJyWesHD0A3pz+g9ou2m1EeF5hCCV
         r0mFRg/eg93yi0gEwlN88jObL7b8kBA6XPYkrpjFdudkTvWj6nbT88yJ8rSIvoD80bA+
         35Vg7H2KVxxFbocUnm5lh7jC9KtaAi4A1La5qSKs4/QfKWO73T73Ly6Bx44O6NfRJORX
         8tm8TQShYN6yTe8bMm4zX0EybBUeyvztdfwYlylXuXVsorKe3/qt5MNbLz06AdVPreU0
         Udrh9qcVb8MflrO1xigc8OEFKB8m6G3RRl5zSreCmgeADsyfGFxSjf40LdeGrKyUHjet
         6fXA==
X-Gm-Message-State: AOAM531tXF/eLOmLILduEheR2JVYkVN5vMsT0ntKEt5XEMFDtzcs/rwq
        eC5KotDRylnsbvm6hItiSXg=
X-Google-Smtp-Source: ABdhPJyDOmxsWcHptOCXrlz2DfdRs3ToWlKFmU7sWKf2RWgc6Jg6hrJsDIU8bNUTt2KgGgbCPx8bcA==
X-Received: by 2002:a7b:c76a:: with SMTP id x10mr12117201wmk.16.1592209964155;
        Mon, 15 Jun 2020 01:32:44 -0700 (PDT)
Received: from net.saheed (54006BB0.dsl.pool.telekom.hu. [84.0.107.176])
        by smtp.gmail.com with ESMTPSA id z206sm21954745wmg.30.2020.06.15.01.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 01:32:43 -0700 (PDT)
From:   refactormyself@gmail.com
To:     helgaas@kernel.org
Cc:     Bolarinwa Olayemi Saheed <refactormyself@gmail.com>,
        bjorn@helgaas.com, linux-pci@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/8] PCI: Align return values of PCIe capability and PCI accessors
Date:   Mon, 15 Jun 2020 09:32:25 +0200
Message-Id: <20200615073225.24061-9-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200615073225.24061-1-refactormyself@gmail.com>
References: <20200615073225.24061-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>

The PCIe capability accessors can return 0, -EINVAL, or any PCIBIOS_ error
code. PCIBIOS_ error codes have positive values. The PCI accessor on the
other hand can only return 0 or any PCIBIOS_ error code. This
inconsistency among these accessor makes it harder for callers to check 
for errors.

Return PCIBIOS_BAD_REGISTER_NUMBER instead of -EINVAL in all PCIe
capability accessors.

Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
Signed-off-by: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
---
 drivers/pci/access.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 79c4a2ef269a..cbb3804903a0 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -409,7 +409,7 @@ int pcie_capability_read_word(struct pci_dev *dev, int pos, u16 *val)
 
 	*val = 0;
 	if (pos & 1)
-		return -EINVAL;
+		return PCIBIOS_BAD_REGISTER_NUMBER;
 
 	if (pcie_capability_reg_implemented(dev, pos)) {
 		ret = pci_read_config_word(dev, pci_pcie_cap(dev) + pos, val);
@@ -444,7 +444,7 @@ int pcie_capability_read_dword(struct pci_dev *dev, int pos, u32 *val)
 
 	*val = 0;
 	if (pos & 3)
-		return -EINVAL;
+		return PCIBIOS_BAD_REGISTER_NUMBER;
 
 	if (pcie_capability_reg_implemented(dev, pos)) {
 		ret = pci_read_config_dword(dev, pci_pcie_cap(dev) + pos, val);
@@ -469,7 +469,7 @@ EXPORT_SYMBOL(pcie_capability_read_dword);
 int pcie_capability_write_word(struct pci_dev *dev, int pos, u16 val)
 {
 	if (pos & 1)
-		return -EINVAL;
+		return PCIBIOS_BAD_REGISTER_NUMBER;
 
 	if (!pcie_capability_reg_implemented(dev, pos))
 		return 0;
@@ -481,7 +481,7 @@ EXPORT_SYMBOL(pcie_capability_write_word);
 int pcie_capability_write_dword(struct pci_dev *dev, int pos, u32 val)
 {
 	if (pos & 3)
-		return -EINVAL;
+		return PCIBIOS_BAD_REGISTER_NUMBER;
 
 	if (!pcie_capability_reg_implemented(dev, pos))
 		return 0;
-- 
2.18.2

