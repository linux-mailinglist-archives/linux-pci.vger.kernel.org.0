Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB23294936
	for <lists+linux-pci@lfdr.de>; Wed, 21 Oct 2020 10:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502181AbgJUIKs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Oct 2020 04:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502070AbgJUIKq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Oct 2020 04:10:46 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6917DC0613CE;
        Wed, 21 Oct 2020 01:10:45 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id y1so822369plp.6;
        Wed, 21 Oct 2020 01:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p2N0hv7dPumGVAi7Lo1RDOfD6xzKW7ppYAQ487en3D0=;
        b=BwC/fUCnvXfp73piwdIFPsud7riDrAwxtn5KGZ6dUxleqAcUjxaxS4FUIuRoNAl7u5
         iNvGpFuFdC0fldTa9wYPYoGTWK1UfDai8Q6mYwT8WbSH/kZsObqnkH2wB/3EDhHYEU1n
         y/+SvDMtd7Yajt3e8yf4tKXGZ3vBCG3TxM3WHn0v240tfbya2/510O/5giDOexEg2iux
         7Tw/G6KTkBVoclLBs1j/lojP9BAPKELLxy6mE1DPA5FuyUpIDwxJyuoV4wC4HA56IVqb
         9pWKQHw9f04qeTDYb/SgxNpYI8QseCxHGB1v0w/jaM2dwP2ZN46kXHzBwBQUqhGVZvGZ
         A2Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p2N0hv7dPumGVAi7Lo1RDOfD6xzKW7ppYAQ487en3D0=;
        b=PdXm4LL10/WQ7owZas6jgfQ7cVe1ORbhmPFBq1fIb4dNFkNuj38Ex5FPnpsFSPOkqc
         cAIrPOd10IWt2ak4ckD9KHhH0bILxwMJUaIb4635V15sbFSd8MKXA9KVB6OLwLCmLJKL
         HJGXXAkBytQzEX4Ge0LgQz7RY10brKmaMmERihfWdcBhMtHXhd9dZYl8FOogj17xLBg4
         vxGAT0N9Ms71D5yfTaCwGTXXhPW+WpD4mOKnuDsjXvkj8uSB9cFBGhq4uDmfN2TpvZ1E
         2ooW7DoVguIfjzFGYEEv06d69/QqYxbIlspTOHrdnnQ9PTd5GPfZc57vAA8YOrRUnFd+
         m8RQ==
X-Gm-Message-State: AOAM531j9vtpjBT4r0X2pGtyrTPxfiiqsFfhKvZ/qx2lDZc0MscyrkUC
        QRmhp6ArfQ0tU3ckfeteUFEnJuy4X80=
X-Google-Smtp-Source: ABdhPJzbE+qZ+6c/p6CJcC1sYQlVVbfY/vogLKssJHJnaE+JSPVVkZ4xJ2jRS+lXrbq2hOASTCNwKQ==
X-Received: by 2002:a17:90a:3f10:: with SMTP id l16mr2190969pjc.110.1603267844672;
        Wed, 21 Oct 2020 01:10:44 -0700 (PDT)
Received: from ZB-PF0YQ8ZU.360buyad.local ([137.116.162.235])
        by smtp.gmail.com with ESMTPSA id q23sm466075pfg.192.2020.10.21.01.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 01:10:44 -0700 (PDT)
From:   Zhenzhong Duan <zhenzhong.duan@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     bhelgaas@google.com, Zhenzhong Duan <zhenzhong.duan@gmail.com>
Subject: [PATCH 2/2] PCI: add support for dynamic ID when checking for duplicate IDs
Date:   Wed, 21 Oct 2020 16:10:30 +0800
Message-Id: <20201021081030.160-2-zhenzhong.duan@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201021081030.160-1-zhenzhong.duan@gmail.com>
References: <20201021081030.160-1-zhenzhong.duan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When a device ID data is writen to /sys/bus/pci/drivers/.../new_id,
only static ID table is checked for duplicate and multiple dynamic id
entries of same kind are allowed to be dynamically linked.

Fix it by calling pci_match_device() which checks both dynamic and static IDs.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
---
 drivers/pci/pci-driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index bd9cfd1..751c605 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -125,7 +125,7 @@ static ssize_t new_id_store(struct device_driver *driver, const char *buf,
 		pdev->subsystem_device = subdevice;
 		pdev->class = class;
 
-		if (pci_match_id(pdrv->id_table, pdev))
+		if (pci_match_device(pdrv, pdev))
 			retval = -EEXIST;
 
 		kfree(pdev);
-- 
1.8.3.1

