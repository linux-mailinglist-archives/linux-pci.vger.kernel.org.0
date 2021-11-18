Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79359456152
	for <lists+linux-pci@lfdr.de>; Thu, 18 Nov 2021 18:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbhKRRWN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Nov 2021 12:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbhKRRWN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Nov 2021 12:22:13 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40092C061574;
        Thu, 18 Nov 2021 09:19:13 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id r5so5977237pgi.6;
        Thu, 18 Nov 2021 09:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ouDQlk5zP/VXAJVsTu5rp4BRmgexGWzx5mlwojfemqc=;
        b=U4kbcX15gvaWqE8KhuqMkEpRudV6Qdtb81j0UvxOntWtT4KLFSkbOn2p0zqzHQfM1w
         1B6Koj+zmv5GDJcyTUKKA2KVQ8dJe+Jj82xx3f8nPA+oPegZXmVCe1dzoI8qSJbZsviH
         hGnyTtq82W5qMyDDtYrwDhQJUO8g/2XWUgQLoZ51rJt7q/ziKybUz4BRl0NPwV5w5bMt
         RT177gzHnsuBLarSXhczjOAXwinHFX6b/g0XqtZ54jJja9Mx+nuXUkx+ZsgdCTu+Ia3r
         nb/fspMloJ7PNSSphBjM206T3FUmqUuoZlPDzjgbDslBiQcY1/VlqaZ1sTd+2px+C6/0
         UZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ouDQlk5zP/VXAJVsTu5rp4BRmgexGWzx5mlwojfemqc=;
        b=RcqTXdiNV8UWfOvNKzW1On5WVz5GYHrUGoDfEqHJewzwaIHTjA4OVk45h7uhyhadr3
         5yeDjQvl633tdmlqw6uPkR3NOa+jOMzp1MzcONiZEt5rIVQhXfyJUa64m0O8a7tXT2Lj
         DUGPkkmdWsn6+t58xZGbEdP02T+EqcnHL4mnvCg8mQ//Wc53bnJukb+XaU8Hx4swosva
         JcZ7bvmHfdEXKEo9Gdhnh1Ui1O4iqHN5G1wHSuLaFXBhpZ+QPtE/N8Ywildu1LnYqmSb
         8dO2X05yV2lWkcrhav2SV8g7uygBSJN2m5U4Bj8odNM+eHZq56k42KkPyG5jAELQTrJe
         MRNw==
X-Gm-Message-State: AOAM530XrkIG2EVpq+nYehRTprg2xld2NQf8DiNYjNz7JpCGLGLrMwOn
        C7ahsD5ZjYSAA5M55lCRTI0=
X-Google-Smtp-Source: ABdhPJwO0ITyNRj+mvPgJqS/+PgQh3J1f7sJBQ4UVI/GSsPPZalXjYjmutxdKmG7qxXQUYyQVYhUsA==
X-Received: by 2002:a62:4e0a:0:b0:4a0:4127:174b with SMTP id c10-20020a624e0a000000b004a04127174bmr16706105pfb.41.1637255952588;
        Thu, 18 Nov 2021 09:19:12 -0800 (PST)
Received: from localhost.localdomain ([2406:7400:63:2c47:5ffe:fc34:61f0:f1ea])
        by smtp.gmail.com with ESMTPSA id u32sm191283pfg.220.2021.11.18.09.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 09:19:12 -0800 (PST)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v3 0/1] PCI: Initial KUnit test fixture for resource assignment
Date:   Thu, 18 Nov 2021 22:48:50 +0530
Message-Id: <cover.1637250854.git.naveennaidu479@gmail.com>
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

v3:
    - Rename init_registers to init_test_registers 
v2:
    - Add test cases to test resource assignment for Type 1 devices
    - Fix a error (a function was not static) found by Kernel Test Robot

Naveen Naidu (1):
  [PATCH v3 1/1] PCI: Add KUnit tests for __pci_read_base()

 drivers/pci/Kconfig              |   4 +
 drivers/pci/Makefile             |   3 +
 drivers/pci/pci-read-base-test.c | 803 +++++++++++++++++++++++++++++++
 3 files changed, 810 insertions(+)
 create mode 100644 drivers/pci/pci-read-base-test.c

-- 
2.25.1

