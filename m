Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD456619B
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2019 00:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbfGKW01 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Jul 2019 18:26:27 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37802 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728946AbfGKW00 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Jul 2019 18:26:26 -0400
Received: by mail-io1-f68.google.com with SMTP id q22so16168827iog.4;
        Thu, 11 Jul 2019 15:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TcJ39mrTnrQlLHfGMzt7/5Q8HNdDCCU3tKZkCQ828ZU=;
        b=uTWK1/58bH92DE6I5OcM0TOKOi08hvLUxO2zwYDSeu+G0xK0fEO+sl+bl8ufZT8Ofs
         2ZtGevaZh+JRkImOpVXgC52RU6KvSoo+rq6gunglaY8azo3+IKe9qlPRdm3vwWSogcCn
         qkF5+dg1WoZI5cOAVLfVk7mglurCY713h5x8o2jC3635Gl93ytO1f92t5HZTwm0VVide
         YAJ9vp6/cidQ8WSue7C07T0Py06UDSCJeMLZ/9FL0f2IhXkPyZm5nRaUPPMI+OKg+ykQ
         2ONZeDHcY9tXpbQHlLZnOoyFd87LrvnUaAfu+R0wa2llPdIhjSZLyT4hJFagt1vcyRLx
         qsGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TcJ39mrTnrQlLHfGMzt7/5Q8HNdDCCU3tKZkCQ828ZU=;
        b=NuH63WvkJxh03/huaLypWyCIl8e/iMpFT06/MawKUyUd7lDzZeblQLVbRtLMZEfMWy
         bvV0k9/Fu0Tk/6cZH6iEKOyuBAUt70/toi24YsLFdequfEtatq6Uu1jWw7W2Xtu+EQBw
         TW2zE8VFzY/ZIjqtMzFKriDoa1OLfNqZ46eIoCTTv3/xHRikoK2L6mO3nzOYdhIzVehv
         Ff9XwTXBytbG47K9fWZKgwvUceATvzEKPd9HoZWZUfEoe2p6XwVR8AO0at4uLUoqHAqx
         fQ52ktXL7nkLV3beZkxfn+WPKIGsiZZghWmKGhPziudw0c7tP7nu4HFI34PHn8n4ku0r
         KKpw==
X-Gm-Message-State: APjAAAW1irU2PLAa6hQPGFj0WDjCIPgtJb4GCz97NoGgscTdH6BkKhRm
        7JvSunskN+xkzGO4hpNHleZkLBeFPumx0w==
X-Google-Smtp-Source: APXvYqxR+OqfK3XOrZf7742wsjyMO7kSKYIu8GaWsGPoEx/W2J+txrGujJWRGIegbDsS268MwqGJgg==
X-Received: by 2002:a02:7f15:: with SMTP id r21mr7677881jac.120.1562883985001;
        Thu, 11 Jul 2019 15:26:25 -0700 (PDT)
Received: from localhost.localdomain (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id s2sm4478982ioj.8.2019.07.11.15.26.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 15:26:24 -0700 (PDT)
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        linux-kernel@vger.kernel.org
Cc:     skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skunberg.kelsey@gmail.com
Subject: [PATCH 10/11] PCI: Move PTM declaration to drivers/pci/pci.h
Date:   Thu, 11 Jul 2019 16:23:40 -0600
Message-Id: <20190711222341.111556-11-skunberg.kelsey@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190711222341.111556-1-skunberg.kelsey@gmail.com>
References: <20190711222341.111556-1-skunberg.kelsey@gmail.com>
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
index 74249c31325c..95bca00ea85a 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -547,8 +547,11 @@ static inline void pcie_ecrc_get_policy(char *str) { }
 
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
index 8fbe3471e8f0..ea4dfb6b6693 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1503,13 +1503,6 @@ static inline bool pci_aer_available(void) { return false; }
 
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

