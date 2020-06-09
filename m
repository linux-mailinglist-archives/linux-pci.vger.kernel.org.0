Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 851641F4125
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jun 2020 18:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731163AbgFIQkB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jun 2020 12:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731076AbgFIQkB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Jun 2020 12:40:01 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45D0C05BD1E
        for <linux-pci@vger.kernel.org>; Tue,  9 Jun 2020 09:40:00 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id n24so23127668ejd.0
        for <linux-pci@vger.kernel.org>; Tue, 09 Jun 2020 09:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0jsc0WVDCzngvbleQ8FMVWNiYCK+/w60HL1ut3/sF08=;
        b=mAsgYWoOJGUlGLWXjx2QapagvaT5DCRY0rgeNKlXSiz17mP7EviuKkkYgS46x7C0F2
         mxlZhY1ZEgThqWQQdzbqlakWTv4msE5E7ribb18M1AAxxHL2DhKBF3EFMkI49BNnIKAA
         DreY9qGzBl577nQaRl+sL1pt6JoMRJL3p5jyOUxHeeka320N8ZhTs36Jim1L1R0TlZuf
         OlD+K7gZjWzt+3YHmsQeKxbAwn7GE1YUfF/zLCod2Ay9L59UfD1/b4E97Nvp8JOBB5G7
         tfw5BfqBTLmI/pPZ2NvbiI/EyvW/pARDblT6eURtmqrzzNzMfQ3SI8ExKAfHrpn5YGJ+
         vg0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0jsc0WVDCzngvbleQ8FMVWNiYCK+/w60HL1ut3/sF08=;
        b=S5EKZJMBQlGRqYAg8ZcLzUVf51PJRv07GIgF063Mpda4jWukmJxIfoexjaqrwDX3hf
         eWBYlQo2ZVXG4RJ8+0I9qXrCM3aNsi2/t693u1nKyHVTMWnSw89Sd89W8cKgLCGXntaL
         s6chAIxRMKiR264gcFJdHPs3obeVWyzF4onGKBgC1UtZu/T8TZS1gk9zVA8JD98G2CEO
         eO2lezPoXcwgUBrGfSRarsDZ9aPbIQN0T5m64ksVvqtCC73ax7M/fULNInDl1lisJfN4
         1R3hVmv24upOmV4Nd5wfccNlpxcbdIG86N1b2eX2MwrYb7WyKfPrhfAzkAOa21i8EGgY
         w2Vg==
X-Gm-Message-State: AOAM533H50cnKHVQZShZMRhMBxHOt9q90lMExihj22mvyN94gPE8r4pW
        nFdygCa0q30MoYHmR2nZfhA=
X-Google-Smtp-Source: ABdhPJzGbsBCwNgskEcVznnyAoQuL7JnlRbzWbMC447LnC3mtr7xDTjXw3UyWIeiXwWBoNmhNJlfDA==
X-Received: by 2002:a17:906:f185:: with SMTP id gs5mr25417319ejb.223.1591720799486;
        Tue, 09 Jun 2020 09:39:59 -0700 (PDT)
Received: from net.saheed (0526DA6B.dsl.pool.telekom.hu. [5.38.218.107])
        by smtp.gmail.com with ESMTPSA id ce25sm8822176edb.45.2020.06.09.09.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 09:39:58 -0700 (PDT)
From:   refactormyself@gmail.com
To:     helgaas@kernel.org
Cc:     Bolarinwa Olayemi Saheed <refactormyself@gmail.com>,
        bjorn@helgaas.com, linux-pci@vger.kernel.org,
        skhan@linuxfoundation.org
Subject: [PATCH 8/8] PCI: Align return value of pcie capability accessors with other accessors
Date:   Tue,  9 Jun 2020 17:39:50 +0200
Message-Id: <20200609153950.8346-9-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200609153950.8346-1-refactormyself@gmail.com>
References: <20200609153950.8346-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>

The pcie capability accessors can return 0, -EINVAL, or any PCIBIOS_ error
code. PCIBIOS_ error codes have positive values. The pci accessor on the
other hand can only return 0 or any PCIBIOS_ error code.This inconsistency
among these accessor makes it harder for callers to check for errors.

Return PCIBIOS_BAD_REGISTER_NUMBER instead of -EINVAL in all pcie
capability accessors.

Signed-off-by: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
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

