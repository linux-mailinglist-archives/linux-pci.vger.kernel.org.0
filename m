Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C67E83B08F2
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jun 2021 17:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbhFVP3L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Jun 2021 11:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbhFVP3K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Jun 2021 11:29:10 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AD0C061574;
        Tue, 22 Jun 2021 08:26:53 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id y13-20020a1c4b0d0000b02901c20173e165so2558710wma.0;
        Tue, 22 Jun 2021 08:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iREvRYd3Jw/uqUSWQKuYJucIkeBg2924CRlJ1YiHk5w=;
        b=R8uvF2EI8NCwXb8QpW12T3b4wTO8IcQ8jgbHHBiKgF9LGnVUhQJfJtGaN2bAiyglWH
         F7oTpfRXCp0IStdz/s/K39V/GnL00Fq430cFpwRfBQXeyYqlxV00YJlWZdkQn9HLn3NB
         R/woi01xmS3k81eF0UJHNYjQbA4xTCcE7hpI0cKTg0DQB066bATaFULTrohoAHUr17GI
         iKBEdRbgiZ5zbV0Z+PE1xlB3qzcKVsi02oskhaArCjvbsxFTy2rXY1NpdMLC3UJdCvR5
         y39d45SpvUvizxRdmARP/8QoYRH6WN9D+FSabI5RwXJ/Egx1cxdKXuvUOljCeAqbWF+o
         Rl5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iREvRYd3Jw/uqUSWQKuYJucIkeBg2924CRlJ1YiHk5w=;
        b=BuUXU9dDmx1fFMRVdtYF6RLeSGyjMvOXuV5pUdlgPBx7FwEFFi4xzHrv3/4tNB82Th
         LKSS0RqCYj7DyBIHqrPX6ACDhHd7KB5K2bg9MNLHKAuss2ZSxz3dV4VB+KD0tZrL9F8k
         DTmu0hgPOvFbZT46jyLQ3Yp/PSkKvU1vQl0HKGF/c8nArrP1fsy6kCcwZacWS5VNd9Qv
         qjli6yvkrtir1JLVTkCV0ItAnpwOoxt7KCRdq/WxIXUhGB8sApQmj60/v5BfD1wcaHtu
         VGKJ1sgObv1lb0U5jPZYefjAf0HCGtHE/M+0pxJFVsSS7h3tYmrtyTSmypGj0DoJej78
         o1NA==
X-Gm-Message-State: AOAM533JCu68OQv/7uIBlZ98v7K5J3MZlX4N1fYmn6s769F2fF7UIF2z
        VfPRYbimCqAzISmml9hIZ9o=
X-Google-Smtp-Source: ABdhPJzUklaWfijjyr/QbZe9TxRCC6Rdn+RrwCKY4rd7cIy/g0zxVcLA8G7PDAcZMjIvtxpOJoA6Jw==
X-Received: by 2002:a1c:2584:: with SMTP id l126mr5069924wml.83.1624375612387;
        Tue, 22 Jun 2021 08:26:52 -0700 (PDT)
Received: from snuff.lan (84-236-11-56.pool.digikabel.hu. [84.236.11.56])
        by smtp.gmail.com with ESMTPSA id l15sm11469907wrt.47.2021.06.22.08.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 08:26:51 -0700 (PDT)
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
Cc:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH v2 1/2] PCI: iproc: Fix multi-MSI base vector number allocation
Date:   Tue, 22 Jun 2021 17:26:29 +0200
Message-Id: <20210622152630.40842-1-sbodomerle@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210621144702.GD27516@lpieralisi>
References: <20210621144702.GD27516@lpieralisi>
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
Acked-by: Marc Zyngier <maz@kernel.org>
Acked-by: Pali Rohár <pali@kernel.org>
Acked-by: Ray Jui <ray.jui@broadcom.com>
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

