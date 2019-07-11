Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E94C661A5
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2019 00:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbfGKW0j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Jul 2019 18:26:39 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36818 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728960AbfGKW0X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Jul 2019 18:26:23 -0400
Received: by mail-io1-f67.google.com with SMTP id o9so16211972iom.3;
        Thu, 11 Jul 2019 15:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tLtPErnr+10mn/XsYOjDK3yHjlI3l+cv/3zQtxd52ew=;
        b=vAHxja5YQ/17QpJhY0YbiqGLiWC3QUVwEZWVnncNW2rXsmHpTwA5W4kZ/8xD9OnZ0T
         N4s07/uneatBdzihYNtKyAGLYsscPNce7EI5lYNYtQyIxyVKJ1LTnixBAcbJGQyvYD3D
         LOCs+MMXw39TkG6ckB4GBcvSdOQyczUQMA6vRWo+3ZkLAFWnspR/bPkDAMyDfIjxp6Ny
         AMBD1HcjogPFyRx1YeDyFTtThhI3m2phXwhtZhXKwUb3Rf0bcAy5i/wMdaT/naBqorzg
         o81T+zHv6piOZSTUvzOiAGTOwhS0rpoWwOBUpvZhe1r0NbHlLVGHXOx0kVpKphHot4Nz
         NyRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tLtPErnr+10mn/XsYOjDK3yHjlI3l+cv/3zQtxd52ew=;
        b=Mly4JK7LaeFSUa/80c8/FyRHfa5gOhvUM5pYnnm1JlVsJvb7aAxxDCSfywkxFSbsro
         k0sUtcTS5+6yBesfSFhCEQVhOqPXR+PYIoLYYq8cZLxpfPjWmUkr0UCPtNPcG+TmZURO
         rfNmjlQVBXehcxarfOARtgnAxEX/hiA5H/e9YJvHirpW6S96HMChA0BsAYfwggqhODu1
         u09ZzUqdoge9fIwazOtexo/7jGfAfra0PRwlaD3Tnk0txg42Ze/p1ukGpiX5Dv9YpxDa
         KgFso7uGC2h3mrIsAdr2FI0b2RGOyl8wYN1ZVnDwiOwZp+XRsUeNa+/MYhLKZV2b5H8U
         kFDw==
X-Gm-Message-State: APjAAAXNeIPPlu9SBJ4Q/mfiZfaNDFPL/TGOeGhCwqAmX/HuRHI7dC9f
        DdlVeqoUdQ8swdnHxD8SJe9YNEDlwMOtrQ==
X-Google-Smtp-Source: APXvYqxrrWPZB2J+3K2QCgyIVw+lp6xsZ+i3MMFO9R3py1cZ4WR00jvhtOEW3nSoU8AR9K5nox6n1Q==
X-Received: by 2002:a02:c487:: with SMTP id t7mr7318479jam.99.1562883981680;
        Thu, 11 Jul 2019 15:26:21 -0700 (PDT)
Received: from localhost.localdomain (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id s2sm4478982ioj.8.2019.07.11.15.26.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 15:26:21 -0700 (PDT)
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        linux-kernel@vger.kernel.org
Cc:     skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skunberg.kelsey@gmail.com
Subject: [PATCH 08/11] PCI: Move pci_ats_init() to drivers/pci/pci.h
Date:   Thu, 11 Jul 2019 16:23:38 -0600
Message-Id: <20190711222341.111556-9-skunberg.kelsey@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190711222341.111556-1-skunberg.kelsey@gmail.com>
References: <20190711222341.111556-1-skunberg.kelsey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pci_ats_init() is only called with drivers/pci/. Since declarations do not
need to be visible to the rest of the kernel, move to drivers/pci/pci.h.

Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
---
 drivers/pci/pci.h   | 7 ++++---
 include/linux/pci.h | 2 --
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 59321488da03..bc677e97a262 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -436,11 +436,12 @@ static inline void pci_restore_dpc_state(struct pci_dev *dev) {}
 #endif
 
 #ifdef CONFIG_PCI_ATS
+/* Address Translation Service */
+void pci_ats_init(struct pci_dev *dev);
 void pci_restore_ats_state(struct pci_dev *dev);
 #else
-static inline void pci_restore_ats_state(struct pci_dev *dev)
-{
-}
+static inline void pci_ats_init(struct pci_dev *d) { }
+static inline void pci_restore_ats_state(struct pci_dev *dev) { }
 #endif /* CONFIG_PCI_ATS */
 
 #ifdef CONFIG_PCI_IOV
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 3221d9f61ab4..263c087b95d5 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1708,13 +1708,11 @@ static inline bool pci_ats_disabled(void) { return true; }
 
 #ifdef CONFIG_PCI_ATS
 /* Address Translation Service */
-void pci_ats_init(struct pci_dev *dev);
 int pci_enable_ats(struct pci_dev *dev, int ps);
 void pci_disable_ats(struct pci_dev *dev);
 int pci_ats_queue_depth(struct pci_dev *dev);
 int pci_ats_page_aligned(struct pci_dev *dev);
 #else
-static inline void pci_ats_init(struct pci_dev *d) { }
 static inline int pci_enable_ats(struct pci_dev *d, int ps) { return -ENODEV; }
 static inline void pci_disable_ats(struct pci_dev *d) { }
 static inline int pci_ats_queue_depth(struct pci_dev *d) { return -ENODEV; }
-- 
2.20.1

