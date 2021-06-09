Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE0373A0ABA
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jun 2021 05:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236501AbhFIDkO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Jun 2021 23:40:14 -0400
Received: from mail-pj1-f50.google.com ([209.85.216.50]:34464 "EHLO
        mail-pj1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236516AbhFIDkN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Jun 2021 23:40:13 -0400
Received: by mail-pj1-f50.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso2864636pjx.1
        for <linux-pci@vger.kernel.org>; Tue, 08 Jun 2021 20:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x3db9pjXA84h01LUCZq4pwVqoTgwPoimoEKIvQtDJvk=;
        b=s3V6CA1Q+zfQZbBHuh+ry0GiiD2rW9uQwZJKsA2r5UK9Zi5cmy/cFoyzFSd1RmHB33
         wbiNzflsUiCzNJxn6GOWqLZI6oR+315jeguEQ3ACLJnG0R2SHPwLW4N8cGVOd6bpvzFG
         ANFe/y6t1ITumv6sFdK13Ic6NqfnreSEaoWkY0ooYFGMAOvoQbiojm0Lo7KK0flOWNxn
         z7F3YhrvPj3l1FRR/HXQphTPFEMj0OQjLOFO8BlAsIKrfVINAkI0uIqOheLLf6fEkwLb
         BNHZwZWKDpQQuSH0i3Q90HL+xNciqAvTe4qnzTdvby9EljaDe8/nw1b3Ell+HBNAipEU
         IL0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x3db9pjXA84h01LUCZq4pwVqoTgwPoimoEKIvQtDJvk=;
        b=jFjwlFvxblNXkFWPUD8atfl8Nt9vm7lpgrIh1Im/ewkUWNmU89NXukAlIcT6mj75SQ
         KbD2kgCbWx8uYw02p8OlnYCb/shT7dzVanrcIOd2em2bNKUfoRqSQB2QD/ChIdnlu6Uy
         AAD/ddYzGtnIGROLIkoFKoE6VfC+8ViXvnCdL1pxoXJ4Vl+ulPFBEi2mAkbvcDFidp3p
         8qyVJpLZz839njaUbaFSFL1phEpkk5yWrJo7QvZhQ5SQR3mg5LFT7Vguy/RwK1lkGwbp
         ujYy1l0eQmNvo6ahRlrBYa0qFgCVSlJAlNHuT6LPwiHSI/qdN75RvdQ8b3k9b9LKAlG2
         Kiqg==
X-Gm-Message-State: AOAM530qWCCGv8/d35QvfI5AkhgQO04gyj7FKoJN+IqFWMGMDHNaKApo
        KsfSS9d6DcSclxnLezbG+DUFjg==
X-Google-Smtp-Source: ABdhPJx457xWbtIJl1QI/e6/0sC+r5W336CMwB2P1zazGuA+tmNS0WIHnBG+CI10KF4l8b/CDGaJlQ==
X-Received: by 2002:a17:90a:16c2:: with SMTP id y2mr29428390pje.236.1623209823962;
        Tue, 08 Jun 2021 20:37:03 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.135])
        by smtp.gmail.com with ESMTPSA id t24sm3473904pji.56.2021.06.08.20.36.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jun 2021 20:37:03 -0700 (PDT)
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        jean-philippe <jean-philippe@linaro.org>,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH v4 1/3] PCI: PASID can be enabled without TLP prefix
Date:   Wed,  9 Jun 2021 11:36:39 +0800
Message-Id: <1623209801-1709-2-git-send-email-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1623209801-1709-1-git-send-email-zhangfei.gao@linaro.org>
References: <1623209801-1709-1-git-send-email-zhangfei.gao@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

A PASID-like feature is implemented on AMBA without using TLP prefixes
and these devices have PASID capability though not supporting TLP.
Adding a pasid_no_tlp bit for "PASID works without TLP prefixes" and
pci_enable_pasid() checks pasid_no_tlp as well as eetlp_prefix_path.

Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/pci/ats.c   | 2 +-
 include/linux/pci.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 6d7d649..c967ad6 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -376,7 +376,7 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
 	if (WARN_ON(pdev->pasid_enabled))
 		return -EBUSY;
 
-	if (!pdev->eetlp_prefix_path)
+	if (!pdev->eetlp_prefix_path && !pdev->pasid_no_tlp)
 		return -EINVAL;
 
 	if (!pasid)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index c20211e..766dca1 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -388,6 +388,7 @@ struct pci_dev {
 					   supported from root to here */
 	u16		l1ss;		/* L1SS Capability pointer */
 #endif
+	unsigned int	pasid_no_tlp:1;		/* PASID works without TLP Prefix */
 	unsigned int	eetlp_prefix_path:1;	/* End-to-End TLP Prefix */
 
 	pci_channel_state_t error_state;	/* Current connectivity state */
-- 
2.7.4

