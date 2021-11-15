Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49E8C44FEA2
	for <lists+linux-pci@lfdr.de>; Mon, 15 Nov 2021 07:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbhKOG22 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Nov 2021 01:28:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhKOG22 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Nov 2021 01:28:28 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A31FC061746;
        Sun, 14 Nov 2021 22:25:32 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id j5-20020a17090a318500b001a6c749e697so10330269pjb.1;
        Sun, 14 Nov 2021 22:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7W9XanpshXvtSoCLshMRQwI6dIMSbV7kXiCbFgHrPGQ=;
        b=UvSfkLnYlDcixJTWnQ5GfcIG/r2wmRiqz6WT9HwhrUHHvxV5Z+s3mXBN0XX9uMPKzJ
         Lw1zXvwc/Ug34ogE39aks5ve65QQOdJ4zi0pyEE2Ky74zwpbxUnfmYazDbFhx1MXWACd
         8Zhwimu51nccW7X2G1imIHF0GvnlnQTIjsM2APdMB6Wp9qKVkHMHkoWl34rvL6eAf9xh
         8crNdvmfzNaU9tmKji/IduJXDEyXBCHem1yqAkw0TEzWVLwMkTu1RaY29Ka5O8WYTE9p
         eFN2fp8FL71WRx46tnwQnns6cvW1a2rAJd9J54H4b0On++nGHUxBC+jUv+KQs+3Vu/wo
         kW9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7W9XanpshXvtSoCLshMRQwI6dIMSbV7kXiCbFgHrPGQ=;
        b=5sxNaCCrcsFIMwRmiIMp5qvmCttBZwJ3gecP7j9/xr9LCbxM4MNPEYVh0/o74xBQbl
         wJdfVPu5D2FgN4aiE7MndujOC5IjJx+auUNAupWmFcFWHOP2o1GeD0HRZGHgydXZzVgj
         AqCK9PoeuBBnq+ExkIXqw39G/CmTdFFlG3Em5Huz1rudT6a5bK9jGXwojX4B2Kn6Tj6V
         Kp4vqCgYMcCa3S0zyrTI/Mg6HInNb+NZwzDw5FShSUkoYlcMnU/QASO98znaWQboY7FD
         XCF3/g/xehTvMnpwlYFGrYhT3zzA+F124Mg+pXPXJ+DODhP4WrGwmMz8PkZkKM21lMyT
         wYKw==
X-Gm-Message-State: AOAM531b7ydu/DZCYLRTXT5pINsyABsYWO1tMW17CrMs0pRUYoQt4d36
        QSQGzkbePpcmvzhi8femmOo=
X-Google-Smtp-Source: ABdhPJyWEXR0EyLejAUFWCYb03G4m+oTjbPVWHg+o0cZ8YzmPiNU3pNKfCJ6FyrARIhRTjLGiaQNHQ==
X-Received: by 2002:a17:90b:3807:: with SMTP id mq7mr43337338pjb.38.1636957531422;
        Sun, 14 Nov 2021 22:25:31 -0800 (PST)
Received: from localhost.localdomain ([2406:7400:63:e619:88c4:d8a2:c9f5:5c37])
        by smtp.gmail.com with ESMTPSA id s2sm15865647pfg.124.2021.11.14.22.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 22:25:30 -0800 (PST)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v2 0/1] PCI: Initial KUnit test fixture for resource assignment
Date:   Mon, 15 Nov 2021 11:55:14 +0530
Message-Id: <cover.1636956898.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently it's hard to deubg issues in the resource assignment code of
the PCI because of the long reproduction cycles between the developer
trying to fix the code and the user testing it due to the lack of
hardware device with the developer [1].

[1]:
https://lore.kernel.org/all/20210621123714.GA3286648@bjorn-Precision-5520/

Bjorn, suggested that it would be really good if we could have a test
fixture for debugging/testing resource assignment. 

The patch attached along with the cover letter is an attempt to lay the
foundation and also have a proof of concept to show that it is possible 
to have a test fixture to debug the resource assignment code.

Since there are a lot of things which happens during the resource
assignement phase, the first version only tests the __pci_read_base()
function since that was the most easiest to set up.

Hopefully, in the future patches I'll be able to write more KUnit tests
for the other parts responsible during the resource assignment phase and
get closer to the goal of having a complete test fixtures :)

Thanks,
Naveen

Changelog
=========

v2:
    - Add test cases to test resource assignment for Type 1 devices
    - Fix a error (a function was not static) found by Kernel Test Robot

Naveen Naidu (1):
  [PATCH v2 1/1] PCI: Add KUnit tests for __pci_read_base()

 drivers/pci/Kconfig              |   4 +
 drivers/pci/Makefile             |   3 +
 drivers/pci/pci-read-base-test.c | 803 +++++++++++++++++++++++++++++++
 3 files changed, 810 insertions(+)
 create mode 100644 drivers/pci/pci-read-base-test.c

-- 
2.25.1

