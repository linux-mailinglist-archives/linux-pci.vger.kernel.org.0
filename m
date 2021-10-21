Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 523634365AB
	for <lists+linux-pci@lfdr.de>; Thu, 21 Oct 2021 17:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbhJUPRk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Oct 2021 11:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbhJUPR1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Oct 2021 11:17:27 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130EEC061232;
        Thu, 21 Oct 2021 08:14:36 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id o4-20020a17090a3d4400b001a1c8344c3fso1256352pjf.3;
        Thu, 21 Oct 2021 08:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x+grG83XrHCBepZfPJFFdEnHFlsALdbCTTo16jghra4=;
        b=k2YxjrVdUyT6a9mQTulZsMADoQNPR0aEjOM2l8Nefwzj49jPdG7PMzP+Djh8LqMPFS
         4Y2D2rFclGUV/Yw4tW0DjmZCSvgkJTLH4cuR8qs/PGV0deaffN5woFOBylwqPkmPsMCi
         zw1Jiea3qvbGASUN6gUlEQ515asnyGh/rm+avjBYvDqUuFb0JYuQd0wm+uGnCVfWeOpm
         xFivKrxIhLrpwsicd8PBEp0H/k5YuJjPgU9JViFGvoz5Ai8nR2phWXKKrlGFJ0GVLnFD
         bMs566lmMTB3Jc5PWDcpV9O2tbmSY3+jcAc6mMiJ3NJQSnrqjM2GBaRlfH8GQpFIxkNo
         j+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x+grG83XrHCBepZfPJFFdEnHFlsALdbCTTo16jghra4=;
        b=5p2Tu7hZwFy+LvjPiteL4DpEV7rG2POG39cPUZfZRZERzrSiCi9Eh9NoREKOoiLiRi
         oxzew7cI53rqE3xlo3rDCmlf3gBLmysYx8L4Nd5RWdsRk9g7D0WXU8/GUUyOhE/HeSze
         yfNGV1t4hYk/WLo2q1y79pjV2LbCvScP4VaLDHBrGHZJFs27IgB9Z4GPjcC80CaDERLC
         41ECBf6qK+C6lQ0Rky/ofZnYxAIL36B6I8lpZnBZpQFlTxDR0FxAJFSZD4eYBzjZebu3
         SObpdcZI3iH0Z20fTloImeL4tapX3xO96Uod1uCgGzTizTc2fbcrNk7B6xARhcs42+pi
         goow==
X-Gm-Message-State: AOAM530Tr2VT856uoefUoeRmVtbuhNp57ejcvNdAFFN9lnXIu27d5aJW
        s6LL6LRRbuaWaAdr2otBSpM=
X-Google-Smtp-Source: ABdhPJzAnJbpgVe2j8+IaDzkyiZYmscRfLlNZfOxZxm73HJbbJg8/yRu1BEritTBQ0SQnOcbuVcIsw==
X-Received: by 2002:a17:90a:600d:: with SMTP id y13mr7405347pji.84.1634829275558;
        Thu, 21 Oct 2021 08:14:35 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:29a4:d874:a949:6890:f95f])
        by smtp.gmail.com with ESMTPSA id c9sm5508027pgq.58.2021.10.21.08.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 08:14:35 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org
Subject: [PATCH v3 22/25] PCI: Use PCI_ERROR_RESPONSE to specify hardware error
Date:   Thu, 21 Oct 2021 20:37:47 +0530
Message-Id: <eac42e773a543a866f0b675195576307141f6a7b.1634825082.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1634825082.git.naveennaidu479@gmail.com>
References: <cover.1634825082.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Include PCI_ERROR_RESPONSE along with 0xFFFF and 0xFFFFFFFF in the
comment to specify a hardware error. This makes MMIO read errors
easier to find.

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/access.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 2705a4412e69..baff68916f17 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -413,8 +413,8 @@ int pcie_capability_read_word(struct pci_dev *dev, int pos, u16 *val)
 		ret = pci_read_config_word(dev, pci_pcie_cap(dev) + pos, val);
 		/*
 		 * Reset *val to 0 if pci_read_config_word() fails, it may
-		 * have been written as 0xFFFF if hardware error happens
-		 * during pci_read_config_word().
+		 * have been written as 0xFFFF (PCI_ERROR_RESPONSE) if hardware error
+		 * happens during pci_read_config_word().
 		 */
 		if (ret)
 			*val = 0;
@@ -448,8 +448,8 @@ int pcie_capability_read_dword(struct pci_dev *dev, int pos, u32 *val)
 		ret = pci_read_config_dword(dev, pci_pcie_cap(dev) + pos, val);
 		/*
 		 * Reset *val to 0 if pci_read_config_dword() fails, it may
-		 * have been written as 0xFFFFFFFF if hardware error happens
-		 * during pci_read_config_dword().
+		 * have been written as 0xFFFFFFFF (PCI_ERROR_RESPONSE) if hardware
+		 * error happens during pci_read_config_dword().
 		 */
 		if (ret)
 			*val = 0;
-- 
2.25.1

