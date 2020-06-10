Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31A661F4C10
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jun 2020 06:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbgFJESh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Jun 2020 00:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbgFJESh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Jun 2020 00:18:37 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9876AC03E96B
        for <linux-pci@vger.kernel.org>; Tue,  9 Jun 2020 21:18:32 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id e9so400829pgo.9
        for <linux-pci@vger.kernel.org>; Tue, 09 Jun 2020 21:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=K0hwNtKfAibOJKiyWU3Z9GaQQI3EVYmF1iagX0XS7wk=;
        b=gJEWN7a7/A5UeFkZQMLzhzfOwv5PGiXLgXIVjALpG57ToRLaUkcY6YZoKjKGYfA/tV
         4JQkJQQ3fUSvGiHkhoY0sMj+mWtQo1UNQhj6IxrSeTu7B4mCW4QIKoxqgdtw3ruGc9yk
         XTd4Of+0FV++GHK1UFOq2yk8ckPg1Z+8bQn1TwMVnfuLnxPe8VoAAlaHfm9oYfrLYwHb
         d4Yhb2G9hqk2Ig5LrVsc4xSnb2LzjfNVakj98+pfkRm6ojd5bNJSBnVNF46mDpfeYjcW
         YjUY8HoLmotQyGFMo9eI3cF8SbQo2EBeXTINqT667/IgDO3s0Uh8h457KDYoftOHivD1
         wHqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=K0hwNtKfAibOJKiyWU3Z9GaQQI3EVYmF1iagX0XS7wk=;
        b=eE16u6bMQ0xzIqN9e6kFGzuPmhwZeKZmw9DcWn1N2+ugfiW0hTE2Cxcy2vp6NmfqCA
         TBJl+gihjLW3TxqLNJkl4QLoKIq1AIpUh3m8zcnXhV0hKhEZbhsTqiZ3UIs61pKgV6dC
         Ty6jBreKgPma5BjTZYQ9yE5ewkCVBz1ifsV1RjYVDdnNoCP80lSAUtXWjd1IcyH4RzTx
         RspwELezrsuYFNdtDBs/u7sSJfO9oV1QGe+kYPrrNIunHHoGLv1BogEz0Ui6KEmgqzEc
         KBTxmEziXoDwTxp55yYKZVHqfPRsNtNkU+Dd1mKs9OjL27/JGg/QisU83HYsXLrChGdR
         c58w==
X-Gm-Message-State: AOAM530w0a6UQ/OmDzLcG+XhjFA8IlDLOSbRnqTOLzL/z46s8BfU/5pu
        B/l6HgX2deCJLx/1we6LjKwyOw==
X-Google-Smtp-Source: ABdhPJy2hbHFEpC3FXD1wOh+lpyB2FXygfpswDjRSUMDEb2dYdEHtFe2H6RSKJkmOXachpVQ8dioNQ==
X-Received: by 2002:a63:a36e:: with SMTP id v46mr1070419pgn.378.1591762710565;
        Tue, 09 Jun 2020 21:18:30 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.73])
        by smtp.gmail.com with ESMTPSA id w73sm11627476pfd.113.2020.06.09.21.18.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2020 21:18:29 -0700 (PDT)
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        jean-philippe <jean-philippe@linaro.org>,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [RFC PATCH] PCI: Remove End-End TLP as PASID dependency
Date:   Wed, 10 Jun 2020 12:18:14 +0800
Message-Id: <1591762694-9131-1-git-send-email-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some platform devices appear as PCI and have PCI cfg space,
but are actually on the AMBA bus.
They can support PASID via smmu stall feature, but does not
support tlp since they are not real pci devices.
So remove tlp as a PASID dependency.

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/pci/ats.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 390e92f..8e31278 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -344,9 +344,6 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
 	if (WARN_ON(pdev->pasid_enabled))
 		return -EBUSY;
 
-	if (!pdev->eetlp_prefix_path)
-		return -EINVAL;
-
 	if (!pasid)
 		return -EINVAL;
 
-- 
2.7.4

