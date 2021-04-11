Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE6E35B308
	for <lists+linux-pci@lfdr.de>; Sun, 11 Apr 2021 12:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235204AbhDKKPe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 11 Apr 2021 06:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235194AbhDKKPe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 11 Apr 2021 06:15:34 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10D1C061574;
        Sun, 11 Apr 2021 03:15:18 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id i190so7223568pfc.12;
        Sun, 11 Apr 2021 03:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tALxIC5C2ozJfWNsDIYTLsxHNEVLmhYGZfg3+tBvepQ=;
        b=pcIwI9/JrMck4W4DyRDkp3q5nIlxzt8vlMTzsb4ZuZfUu2HW7qYsKh4YsHn2GU7Uxs
         J4MWVT7NgjfDG0Z0+Zcfd9H+wPqPiAbX0oZOFeW2q2JVsT3ajbtW6QxAanNcZe9yW7Ap
         Pv8sR+m+ov9i5cR3/CGWJP5/khXkXQgX/ODfwhfROMUV3EIG+JSKju0TNt+IWxJ3SpKw
         W9IqrvNnyDJ3FffeZPgqZMSMUis84bVdIFl9ax4lyOQokVw5k/7tvPTbkvJ+M77Z9b0G
         m5oiCTa0LSFklMyWx2l/e0beJ1xaF8JYzg4R/P50/fGK/IlUK/JY6ZH63iUOgQRqW7+8
         BZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tALxIC5C2ozJfWNsDIYTLsxHNEVLmhYGZfg3+tBvepQ=;
        b=EXSHbOlClO4vWrA9C3Z7lKuvATxEjFJxvHHjo4H6ryL46qLRlHbmip9a4BTBGYBSK6
         Jr2r+ZEVGFC2BYzlIlZw/tnchJZHuANmbuujibDuMH6QQ19V3qYs2fimBqScdkPXV6d7
         gUjNiAX2QvvhrFqpJO+uIPO3Vqsq0AwGkX4ho5nIkRG+dqTug4m1hQ20xG+KjQfTDtuF
         WJD1h+SPrdbpu12FI8teeBm2NHMm0/J7uypbPnt83tM/JZ+kjFfmTjxAVWOtvGnV+H9p
         +8YwsWGRrx54swJIiiPE8f+FkPEfDVte4C2aswi0SWMjFyQRS/nfMqnw5EFuSWVzmrFx
         tYpQ==
X-Gm-Message-State: AOAM533wVVFidhj9MCljEUjAg5rDEMNqXab3iEG0SwbY3lp4pG8uGfGe
        +pHO4r6eeBDAZm85xnttRHQ=
X-Google-Smtp-Source: ABdhPJyqFYfuQYsq+4KmXf9iSGWkrm32tlH3p1ISbSyLvgz7MrM9S4IT6ni5rF1Gyc8xmC2hqi8JvQ==
X-Received: by 2002:a63:6a41:: with SMTP id f62mr21043660pgc.428.1618136117998;
        Sun, 11 Apr 2021 03:15:17 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:600d:a089:d8d9:c3e6:7914:c3d2])
        by smtp.googlemail.com with ESMTPSA id gk20sm7607472pjb.17.2021.04.11.03.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 03:15:17 -0700 (PDT)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     bhelgaas@google.com
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com,
        rdunlap@infradead.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: endpoint: fix incorrect kernel-doc comment syntax
Date:   Sun, 11 Apr 2021 15:45:08 +0530
Message-Id: <20210411101508.11065-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The opening comment mark '/**' is used for highlighting the beginning of
kernel-doc comments.
There are certain files in include/linux/pci*, which follow this syntax,
but the content inside does not comply with kernel-doc.
Such lines were probably not meant for kernel-doc parsing, but are parsed
due to the presence of kernel-doc like comment syntax(i.e, '/**'), which
causes unexpected warnings from kernel-doc.

E.g., presence of kernel-doc like comment in include/linux/pci-ep-cfs.h at
header causes this warnings by kernel-doc:
"warning: expecting prototype for PCI Endpoint ConfigFS header file(). Prototype was for __LINUX_PCI_EP_CFS_H() instead"

Similarly for other files too.

Provide a simple fix by replacing such occurrences with general comment
format, i.e. '/*', to prevent kernel-doc from parsing it.

Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
---
 include/linux/pci-ep-cfs.h | 2 +-
 include/linux/pci-epc.h    | 2 +-
 include/linux/pci-epf.h    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/pci-ep-cfs.h b/include/linux/pci-ep-cfs.h
index 662881335c7e..3e2140d7e31d 100644
--- a/include/linux/pci-ep-cfs.h
+++ b/include/linux/pci-ep-cfs.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
-/**
+/*
  * PCI Endpoint ConfigFS header file
  *
  * Copyright (C) 2017 Texas Instruments
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index b82c9b100e97..80197a6df371 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/**
+/*
  * PCI Endpoint *Controller* (EPC) header file
  *
  * Copyright (C) 2017 Texas Instruments
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 6833e2160ef1..c43912b1d2d0 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/**
+/*
  * PCI Endpoint *Function* (EPF) header file
  *
  * Copyright (C) 2017 Texas Instruments
-- 
2.17.1

