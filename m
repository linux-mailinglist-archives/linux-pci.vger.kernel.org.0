Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A13D3235222
	for <lists+linux-pci@lfdr.de>; Sat,  1 Aug 2020 14:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgHAMZE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 1 Aug 2020 08:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729103AbgHAMYq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 1 Aug 2020 08:24:46 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A878DC061756;
        Sat,  1 Aug 2020 05:24:45 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id c2so18272607edx.8;
        Sat, 01 Aug 2020 05:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9SS/6geyX0ClI4ij6hB9TxwrDh/zKm7zopv5L3r5c8s=;
        b=Vc2zKFpSPflxIgkXb2/9foXDeDygDY7Eh7RBpe+OBhcwG9txlHhUTADSY0zl+WxwY9
         Kfb8ubabl5bXf5t+me8h6LOdOVgNx3RWTh3l9nvD62Hj4C+HVNM0yzL81CZDIgWKuQsM
         1RFCX6qT0RpcjIQnrRuZ+3NoxXgbeGY86tdkUxocr8VnSr4sDLHBSzv4ELIsnoN3tr0L
         hOwCWxwXz+8O/GBTJW2I4CAR3b25+gDsusQFJbca/CnQOa+THu4aXP6LLU9OXqdAxiiZ
         M7CVKh2dwCjyd35SrdHeY97TUAPQMrUxfslEBfgVTDcSjqpTy0I/VAdWHS1thQpVA/Af
         dnDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9SS/6geyX0ClI4ij6hB9TxwrDh/zKm7zopv5L3r5c8s=;
        b=XBhArnWH5AF3yNbu0WuT/3pOe46831+VqF6UF86/5wzD0YBA1wD37Ke6LLTtArDJpE
         6z+6lzsMkDdjlRUkbKnJbzCbhg9fiSsAUldnLP1HrLlZ7X/hoAzr25IVjrj0cVpvxtkd
         eWCKqq0ZsNEtjGgBT/se4wTRQy81RHmD7AA3YpnsZ+jT5zG3heqNG9cbOJiI7JbfR41f
         Vrzn8XMtojXuEuvbc0dT6nTQJdeG8z/8lCM55RP2N+8uBhyS1H15l8wkgfq6aZUb9Qi9
         JdMUSFVa0h/ii+rgsXFTzJrg9sbr1vN28Zp+UQa4UN2FZY71DMY9jBvPWkNF4sOXu2qz
         Y/tQ==
X-Gm-Message-State: AOAM530rPVEhrGoY8H1OLAfJ+21Faj8pklyawPVWcafbH0/4BoXCK/E8
        4dklc6OCPcqyzoSceQSDi5k=
X-Google-Smtp-Source: ABdhPJxCb6w1gVLD3rEZyWpaLmof4X4XsjraNm+7kSy1/q7MbTUqjWvl5aU3W4jrAAp2UMmQx6JGjA==
X-Received: by 2002:a50:d80c:: with SMTP id o12mr8165291edj.265.1596284684386;
        Sat, 01 Aug 2020 05:24:44 -0700 (PDT)
Received: from net.saheed (95C84E0A.dsl.pool.telekom.hu. [149.200.78.10])
        by smtp.gmail.com with ESMTPSA id a101sm12083131edf.76.2020.08.01.05.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2020 05:24:43 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org, Joerg Roedel <joro@8bytes.org>
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org
Subject: [RFC PATCH 15/17] iommu/vt-d: Drop uses of pci_read_config_*() return value
Date:   Sat,  1 Aug 2020 13:24:44 +0200
Message-Id: <20200801112446.149549-16-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20200801112446.149549-1-refactormyself@gmail.com>
References: <20200801112446.149549-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The return value of pci_read_config_*() may not indicate a device error.
However, the value read by these functions is more likely to indicate
this kind of error. This presents two overlapping ways of reporting
errors and complicates error checking.

It is possible to move to one single way of checking for error if the
dependency on the return value of these functions is removed, then it
can later be made to return void.

Remove all uses of the return value of pci_read_config_*().
Check the actual value read for ~0. In this case, ~0 is an invalid
value thus it indicates some kind of error.

Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
---
 drivers/iommu/intel/iommu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index d759e7234e98..aad3c065e4a0 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -6165,7 +6165,8 @@ static void quirk_calpella_no_shadow_gtt(struct pci_dev *dev)
 	if (risky_device(dev))
 		return;
 
-	if (pci_read_config_word(dev, GGC, &ggc))
+	pci_read_config_word(dev, GGC, &ggc);
+	if (ggc == (u16)~0)
 		return;
 
 	if (!(ggc & GGC_MEMORY_VT_ENABLED)) {
@@ -6218,7 +6219,8 @@ static void __init check_tylersburg_isoch(void)
 		return;
 	}
 
-	if (pci_read_config_dword(pdev, 0x188, &vtisochctrl)) {
+	pci_read_config_dword(pdev, 0x188, &vtisochctrl);
+	if (vtisochctrl == (uint32_t)~0) {
 		pci_dev_put(pdev);
 		return;
 	}
-- 
2.18.4

