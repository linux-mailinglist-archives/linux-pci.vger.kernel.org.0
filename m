Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12D9274243
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2019 01:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbfGXXjv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Jul 2019 19:39:51 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44081 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388743AbfGXXjf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Jul 2019 19:39:35 -0400
Received: by mail-io1-f67.google.com with SMTP id s7so93183522iob.11;
        Wed, 24 Jul 2019 16:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PMejsUr9K8/BuCWQx6vgffGUCxlWl6FVyv+Mq0t5PyY=;
        b=oALzStoxBDoSIlWbN6YPeEuD/T0n8vprngDcpk7Wdx026sDFtVNYqA0fCLFfy8XRW0
         5YCmBMinTsiPjB5jXmUFg/uJIbptOD+pMSOeyRUN9UM6sXpY6+7RYh4VQkctaUk3caYv
         rtfcA+4Bb/VuD3oRTg6XxmWR2iv/MZd3i8kkzFOVoBZGQLg3iN3O5jqeYEB1D7gYmVUt
         WgDYXv4HBPR8WTTCeq5PTeceotDsx6TQUq5T1RHWDtJl2l5fjkISAjHsIVAxdXBX6SWd
         HgAFuWI8KWDuRVh7DQNfSNcwghqvDUmtrAIYHx0CL4n02dilRSLe1ph/56ncBpOyYtqu
         JNpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PMejsUr9K8/BuCWQx6vgffGUCxlWl6FVyv+Mq0t5PyY=;
        b=VllsBGc1fU1rEt4MRx4A9LKnyxKSdY6sWRTJLaL6m0QjpGRvTTY1BKUl2uP6X2f7jp
         H/CQNw48E6VK/1uFjFvmq0i35msYatfSVptn0pWMXbOtm81eMRFY9DKNg5orqkYztzuG
         fGOkAzqjO6BSHNa0ldwsNykE3WgsASY5dq9jrk9celtT5dLn7If2aCAMiOmd99u3U1w4
         rMEasuYTY8mOxD+R0EDeMsqS5AK98AbSScRAR/jh21kmv0zt4pStFAVGKDAXefv9p6/H
         JfbajGaqrH46CU3qmmNjqn1n7rj6giJkzjLNsNcWJpTqXz8DpdpUo5+vEqBf1rh+3Dh7
         Oo5g==
X-Gm-Message-State: APjAAAWsSt8XDNFYJFjsuIe+Uz4UQd/jDNKOZMTMC+1S5yPU5dm8x1z6
        ysmd6I0ISpfvaTav2vb4hkw=
X-Google-Smtp-Source: APXvYqyArnMIGaLRu1YF0B/3Kg2tyhDsqsLvvZ/MgLRe2voM0nZtj/FUXNEnuExWm3h0sXW6r6ooLQ==
X-Received: by 2002:a05:6602:2183:: with SMTP id b3mr67144703iob.249.1564011574860;
        Wed, 24 Jul 2019 16:39:34 -0700 (PDT)
Received: from localhost.localdomain (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id b14sm51612959iod.33.2019.07.24.16.39.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 16:39:34 -0700 (PDT)
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     skunberg.kelsey@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org
Subject: [PATCH v2 10/11] PCI: Move PTM declaration to drivers/pci/pci.h
Date:   Wed, 24 Jul 2019 17:38:47 -0600
Message-Id: <20190724233848.73327-11-skunberg.kelsey@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190724233848.73327-1-skunberg.kelsey@gmail.com>
References: <20190711222341.111556-1-skunberg.kelsey@gmail.com>
 <20190724233848.73327-1-skunberg.kelsey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pci_enable_ptm() is only called within drivers/pci/. Since declaration
does not need to be visible to the rest of the kernel, move to
drivers/pci/pci.h.

Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
---
 drivers/pci/pci.h   | 3 +++
 include/linux/pci.h | 7 -------
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 5e5ce04bda59..6cdc3500de15 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -551,8 +551,11 @@ static inline void pcie_ecrc_get_policy(char *str) { }
 
 #ifdef CONFIG_PCIE_PTM
 void pci_ptm_init(struct pci_dev *dev);
+int pci_enable_ptm(struct pci_dev *dev, u8 *granularity);
 #else
 static inline void pci_ptm_init(struct pci_dev *dev) { }
+static inline int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
+{ return -EINVAL; }
 #endif
 
 struct pci_dev_reset_methods {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 5dd4abeef8b0..a483b7598059 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1561,13 +1561,6 @@ static inline bool pci_aer_available(void) { return false; }
 
 bool pci_ats_disabled(void);
 
-#ifdef CONFIG_PCIE_PTM
-int pci_enable_ptm(struct pci_dev *dev, u8 *granularity);
-#else
-static inline int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
-{ return -EINVAL; }
-#endif
-
 void pci_cfg_access_lock(struct pci_dev *dev);
 bool pci_cfg_access_trylock(struct pci_dev *dev);
 void pci_cfg_access_unlock(struct pci_dev *dev);
-- 
2.20.1

