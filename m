Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18FC68D5B5
	for <lists+linux-pci@lfdr.de>; Tue,  7 Feb 2023 12:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbjBGLkJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Feb 2023 06:40:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbjBGLj6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Feb 2023 06:39:58 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F8110248
        for <linux-pci@vger.kernel.org>; Tue,  7 Feb 2023 03:39:56 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id d2so11016763pjd.5
        for <linux-pci@vger.kernel.org>; Tue, 07 Feb 2023 03:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dankook-ac-kr.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oZ6K/KqCj8pDHNXLdT4gXi5ZWgqVInn4mxJn19ef0hc=;
        b=SI6tl2awZEyjLhlfWvnpxIEH33qgdOwS4rpcvxEWXei8AxM/GtPclV76aWYCT9GCqH
         R2NQG9tRN3pZ6n//ZsgxdmU0kO9Ku2C4ledVTMGL4h5xdfPNj1tKf3jd5mkOF7/meAVX
         k2LOEXlS92vju7NNOQUuYz+KJ3gq5poNawzEdo9zmoHLIY3stUHJe6p121agVLCyL4cP
         76survKDho35ty1CH9GfaT2WbqaIZDtzgY6ZYJV5Nsg1A3myTfIxSENnL/36WUBzfJ3n
         l+ido8Ao2CkJdDv6twvLYaJqU9GXBpbX1Comn8Bi+dHfnNB4OPAyDOz9/9jzDWty8xWr
         IhPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oZ6K/KqCj8pDHNXLdT4gXi5ZWgqVInn4mxJn19ef0hc=;
        b=fg/is1ugDdGYOSzXPpky+6B97SBJKpNSBGbDvnBC2t6KXrN85UImpgNhGDjTrFSb7N
         XR6Ga2zsWwl+Plbthau8RgmY0f1ERepmg5cjFUsmENDCT5NE/FPqXD6lSOuiyR4mPzMy
         EMv8amlqeiUMqE+S96Zcel2sihM/KPuPqMcZUZFYIE+5XxdiTDHZzoPjhGbBn8E64X5B
         jdZM+eWcY1cGKzSMHfQmkFX7XCqpcUVX9yD0LptdFVKRNUlfeLsHlN7p4/DCihnHXN5T
         EE8ylO8SYvKbqHonXqIq+rttCA/yfxi8PJX8ufeOF51P37I0AZuQtA72HCBxGUVRT4Oj
         R1zQ==
X-Gm-Message-State: AO0yUKW+u/QAUa94L1R0p+uHaN+LLFED97cGtItIwZx6JgIUs2ocxtJb
        icSQYg/+J5XHPXMsa3Ix3kSH7gVRXxbNi01ITAI=
X-Google-Smtp-Source: AK7set+OROHGpHOvb4TeMD8kWjZCB/TWCkbp9fXcmeLi6E41EGTHfTapuuRnaVHVa+CdPonTtMHblA==
X-Received: by 2002:a17:903:1246:b0:196:19af:a7f3 with SMTP id u6-20020a170903124600b0019619afa7f3mr2523896plh.39.1675769995751;
        Tue, 07 Feb 2023 03:39:55 -0800 (PST)
Received: from localhost.localdomain ([220.149.244.126])
        by smtp.googlemail.com with ESMTPSA id v13-20020a17090331cd00b00198f1de408csm6597761ple.268.2023.02.07.03.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 03:39:55 -0800 (PST)
From:   Seunggyun Lee <sglee97@dankook.ac.kr>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pci/mmap: add pci device EBUSY check
Date:   Tue,  7 Feb 2023 20:39:49 +0900
Message-Id: <20230207113949.17943-1-sglee97@dankook.ac.kr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When using a pci device through the vfio-pci driver, other software was
also able to access the pci device memory through sysfs.

To prevent this, when mmap is performed through sysfs, a process of
checking whether the device is in use is added.

Signed-off-by: Seunggyun Lee <sglee97@dankook.ac.kr>
---
 drivers/pci/mmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/mmap.c b/drivers/pci/mmap.c
index 4504039056d1..4c9df2e23e03 100644
--- a/drivers/pci/mmap.c
+++ b/drivers/pci/mmap.c
@@ -25,6 +25,8 @@ int pci_mmap_resource_range(struct pci_dev *pdev, int bar,
 {
 	unsigned long size;
 	int ret;
+	if (pdev->driver)
+		return -1;
 
 	size = ((pci_resource_len(pdev, bar) - 1) >> PAGE_SHIFT) + 1;
 	if (vma->vm_pgoff + vma_pages(vma) > size)
-- 
2.25.1

