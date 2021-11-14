Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61A4844FB7F
	for <lists+linux-pci@lfdr.de>; Sun, 14 Nov 2021 21:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233916AbhKNUMY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 14 Nov 2021 15:12:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbhKNUMT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 14 Nov 2021 15:12:19 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85869C061746;
        Sun, 14 Nov 2021 12:09:23 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id n15-20020a17090a160f00b001a75089daa3so11489759pja.1;
        Sun, 14 Nov 2021 12:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Nj+oxSX/c3z55ECc6E1sqG8puAX/WDZIVVJffo9MIU=;
        b=IuCl7VIm2KIapGhBYDwqQraU2CCe8kI2wOVKMMb4/TueOPYH0p/qni4XBxWevydhM3
         yat9GBWYNNtfvFuxCN56xDOf0O44GUSE4XyVcq4gqGFcHIeNBduVB7TpgLvxhJSYh2rt
         oYCfH9tfK6JidnW3E4ashRn4POqA8g/qMcYbs1XYBh9TOtCcrw53nSF3/uJ8fHyFw347
         wKMg5nhy6H87qEdY9jYXD0dkWkVvG/zPhJKjQQCyBt5H2zGYOYBtxbZBxlXVumZLqTkK
         uc750RhkMpxz03fT00tQ20I+qqxl17t3Qdb4kgWcbRvekWBb/eazkRFObjBbnVyNsPos
         p2hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Nj+oxSX/c3z55ECc6E1sqG8puAX/WDZIVVJffo9MIU=;
        b=YoP2+woCqwy8brrP4hLmePI6rVfaQmnTe4JCgfRjYi69Upa0Fdd0PHdMaZNBDrBfkG
         d0TSZcKh35Pfwh8cq9b7PeASvsvxKuXm2CpLRqYBIpESg12VhoypH7LRuOlBKbYyEwN5
         9i1efyhgobCELKSlGk4DwqkMnVTh9aM1B07g3nohBzLKQYQpKyNqq5Weee3N8FVFup0B
         OMUY4OJ9g0utftCE/bHSycYJEcx/nXivazSnN/rBVwrvd0ih0vZw0zdTe2+veJodIlg3
         hyNRKdxbXog2Fo78HYqBCTCDlBzk9MkcPExMDcDzhh4YikSNN52xO98ThDsKpQbF4uD4
         DITQ==
X-Gm-Message-State: AOAM530by9xxOZ8FaM91ZFOooeJ794l6cXwPVzZ46QO09NfMtXd1Btb5
        mYM/CAqqVFW8wOzTkA5sPKrq6U8JuuiaDg==
X-Google-Smtp-Source: ABdhPJwuJ+OxtBtDWYllww/wd9EdAd7SjOmtJN4Sh7D5MNzQjMSbfpRQg1nv/5+aexHdRUQazD21yA==
X-Received: by 2002:a17:90a:8043:: with SMTP id e3mr41373127pjw.130.1636920562867;
        Sun, 14 Nov 2021 12:09:22 -0800 (PST)
Received: from localhost.localdomain ([2406:7400:63:9777:151e:e959:105:10d])
        by smtp.gmail.com with ESMTPSA id e7sm9737869pgk.90.2021.11.14.12.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 12:09:22 -0800 (PST)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH 0/1] PCI: Intial KUnit test fixture for resource assignment
Date:   Mon, 15 Nov 2021 01:38:45 +0530
Message-Id: <cover.1636919579.git.naveennaidu479@gmail.com>
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


Naveen Naidu (1):
  PCI: Add KUnit tests for __pci_read_base()

 drivers/pci/Kconfig              |   4 +
 drivers/pci/Makefile             |   3 +
 drivers/pci/pci-read-base-test.c | 740 +++++++++++++++++++++++++++++++
 3 files changed, 747 insertions(+)
 create mode 100644 drivers/pci/pci-read-base-test.c

-- 
2.25.1

