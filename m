Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB75D39CF08
	for <lists+linux-pci@lfdr.de>; Sun,  6 Jun 2021 14:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhFFMeJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 6 Jun 2021 08:34:09 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:40608 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbhFFMeF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 6 Jun 2021 08:34:05 -0400
Received: by mail-wr1-f45.google.com with SMTP id y7so9569683wrh.7;
        Sun, 06 Jun 2021 05:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ngEb9x/2utKfD/oQZnoIJU7hrPHYhp9F52zqoVWgx2Q=;
        b=ln3LRqC6tLdxL+1LU08oPx52dfBqDds6fq3/rr4qQA4cUSbe0SzLnE6+4MMNXd2bH7
         Qnro11dvjRucyBvvWclLmMRQVoy5WDhwtt/OqzhoEIY1dEsH7smnEtn0f7pTXf1EDelr
         bdriH02MC6Ksuck9Hfj44uZDAXf8mAdYqbyzzOpKYh/S43xhCKVpdxSH4P+BrRBS/6Do
         enX4qeCZCOpfw5ix6q/5rv2yY2WZlr3CXEOXC11OtYhhL7+vI8MWGvF8REk2R/g9ZXRX
         aWAaSSr2v8Wdop1Tq0Wxs6MwasZZMDBN82qPVc2E1pUHTPAueVOZeCKz1XOTzUMSO/YR
         Frrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ngEb9x/2utKfD/oQZnoIJU7hrPHYhp9F52zqoVWgx2Q=;
        b=ZLMHgghV2xgRFZCeUTvUPCoIhM+karvF6asqMD3qFGBVUWQMPQsAk7XMZnAAnfpPXR
         IWF1L+V38Qxati9lq+kPgJjlGa9cmioRBi0MkWDw3v1/zHjNwEhFYBfsrhO/hkRgzZqv
         IT+xrDuINYXPT0RcKGeNY/n2XK7QVhHI0Lj7xk5wvNZ2UVkPNVeaSHgd7/sAG3r83aZc
         mSpDcwR1LVH5QeQOypt1N3oZkGbAw7mvqP/UeDkJChQh/Z/1yfkuqwjoo84kdo6b1HzX
         ncKFAt/8Qbl+VN20wxrHzC5XLy32GQF3pJgG8nqHrqR2SNuELYtEW66KFKu1fhCb1yk6
         jBfw==
X-Gm-Message-State: AOAM531aGtkZL+Ww62QsjH7RLYbJ8XNw183X3e8DtfYG5lDLMKgdDs1I
        24n1siTnAFCDj8Y6OrgITz0=
X-Google-Smtp-Source: ABdhPJxWiQPwTbCyI7h2PehlUVgYVecZGrRQnXC+VdJYC3TS78WhRModc4mvqS8dbMGWjdUi2qYDKw==
X-Received: by 2002:adf:fd90:: with SMTP id d16mr12536436wrr.35.1622982674405;
        Sun, 06 Jun 2021 05:31:14 -0700 (PDT)
Received: from snuff.lan (178-164-181-11.pool.digikabel.hu. [178.164.181.11])
        by smtp.gmail.com with ESMTPSA id p5sm12922023wrd.25.2021.06.06.05.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jun 2021 05:31:14 -0700 (PDT)
From:   Sandor Bodo-Merle <sbodomerle@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Sandor Bodo-Merle <sbodomerle@gmail.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Subject: [PATCH 1/2] PCI: iproc: fix the base vector number allocation for multi-MSI
Date:   Sun,  6 Jun 2021 14:30:43 +0200
Message-Id: <20210606123044.31250-1-sbodomerle@gmail.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit fc54bae28818 ("PCI: iproc: Allow allocation of multiple MSIs")
introduced multi-MSI support with a broken allocation mechanism (it failed
to reserve the proper number of bits from the inner domain).  Natural
alignment of the base vector number was also not guaranteed.

Fixes: fc54bae28818 ("PCI: iproc: Allow allocation of multiple MSIs")
Reported-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Sandor Bodo-Merle <sbodomerle@gmail.com>
---
 drivers/pci/controller/pcie-iproc-msi.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/pcie-iproc-msi.c b/drivers/pci/controller/pcie-iproc-msi.c
index eede4e8f3f75..557d93dcb3bc 100644
--- a/drivers/pci/controller/pcie-iproc-msi.c
+++ b/drivers/pci/controller/pcie-iproc-msi.c
@@ -252,18 +252,18 @@ static int iproc_msi_irq_domain_alloc(struct irq_domain *domain,
 
 	mutex_lock(&msi->bitmap_lock);
 
-	/* Allocate 'nr_cpus' number of MSI vectors each time */
-	hwirq = bitmap_find_next_zero_area(msi->bitmap, msi->nr_msi_vecs, 0,
-					   msi->nr_cpus, 0);
-	if (hwirq < msi->nr_msi_vecs) {
-		bitmap_set(msi->bitmap, hwirq, msi->nr_cpus);
-	} else {
-		mutex_unlock(&msi->bitmap_lock);
-		return -ENOSPC;
-	}
+	/*
+	 * Allocate 'nr_irqs' multiplied by 'nr_cpus' number of MSI vectors
+	 * each time
+	 */
+	hwirq = bitmap_find_free_region(msi->bitmap, msi->nr_msi_vecs,
+					order_base_2(msi->nr_cpus * nr_irqs));
 
 	mutex_unlock(&msi->bitmap_lock);
 
+	if (hwirq < 0)
+		return -ENOSPC;
+
 	for (i = 0; i < nr_irqs; i++) {
 		irq_domain_set_info(domain, virq + i, hwirq + i,
 				    &iproc_msi_bottom_irq_chip,
@@ -284,7 +284,8 @@ static void iproc_msi_irq_domain_free(struct irq_domain *domain,
 	mutex_lock(&msi->bitmap_lock);
 
 	hwirq = hwirq_to_canonical_hwirq(msi, data->hwirq);
-	bitmap_clear(msi->bitmap, hwirq, msi->nr_cpus);
+	bitmap_release_region(msi->bitmap, hwirq,
+			      order_base_2(msi->nr_cpus * nr_irqs));
 
 	mutex_unlock(&msi->bitmap_lock);
 
-- 
2.31.0

