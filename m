Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B48D3B08F5
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jun 2021 17:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbhFVP3U (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Jun 2021 11:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbhFVP3T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Jun 2021 11:29:19 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FD7C061574;
        Tue, 22 Jun 2021 08:27:02 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id h21-20020a1ccc150000b02901d4d33c5ca0so2525665wmb.3;
        Tue, 22 Jun 2021 08:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H0fRRUN9hmaR59XL6pJP1fOrRa3SKmuQ9EeViv8hJUQ=;
        b=bb88ouU3crmfqRKxU+pJjoZiy3AST7BfANO3yReF/O6pWOA7iBqjUsWYoT8ICvzP8r
         IIjp3xtUiQUpIbWbwXfZLciETKWnqXfdsvEXyQIOt3AL+Vv4KYu+Lsa/6HOnLXk7uL/R
         BP+5htCixe6hHRmQvIGxl5WuFojOJnUC5aro2E58Jvw2GuwvKmtVdj8ZZIj5TmZzCiAR
         ai7b5c8YJTWu952PjSVbuJ/kUAyBOkuiMbpmHVYpt7TRTV6zE16DIEvG7G8ssOMR+zbZ
         HOeZEMd7LmUwEvJ3ezUVJX7O716Yc8Y5Ci9j0draS4b6MkAXcsHXZcw4PltYtSQmrF/e
         FtlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H0fRRUN9hmaR59XL6pJP1fOrRa3SKmuQ9EeViv8hJUQ=;
        b=KiG1/0URC430sYEAgdb3tYtUTjC8LSiQ2ef+wA0JYsqP9zzlf3IDy8XOSkyTObmw0m
         C1sMB4VNyRACZBo213p+Cw964Tlw+O1FWeyu5PSZhx2GybIZRL1MNat2zyVW7wbz7vq2
         8Y6KcpK3L/isPmbkjjq3UMnbNOPuhAuYv112N7OEwBwWKRIqJfeNtQsAVaORE8d2nOjG
         BLfYVvmcYuEGv6fPOasCBWn7tuugbGNa81mg59s3H8cMRwkoP9SipwNH+1/DLW/wBFrb
         5r/1xIxAz8J3cFp98E7owEYiNAGzqh3i7gNJZsuU+Bea3/yqG2qNkSsFb4/xv7SuPcYz
         n8jQ==
X-Gm-Message-State: AOAM530L/B6AvUwXHn7XEEK6iFXJ0YYdvwk+kTELtTc+vLOgt5G8bie7
        254zTV0k+8RAvYpsCb+B0O0=
X-Google-Smtp-Source: ABdhPJy33SSeYQeH48XF1N0otWdKyEt0GndZA8MdlT5lYAscQku+HNc9OSLWOiH0pqnVbuUIQ+omOg==
X-Received: by 2002:a1c:7706:: with SMTP id t6mr5237921wmi.62.1624375621362;
        Tue, 22 Jun 2021 08:27:01 -0700 (PDT)
Received: from snuff.lan (84-236-11-56.pool.digikabel.hu. [84.236.11.56])
        by smtp.gmail.com with ESMTPSA id l15sm11469907wrt.47.2021.06.22.08.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 08:27:01 -0700 (PDT)
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
Cc:     Marc Zyngier <maz@kernel.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH v2 2/2] PCI: iproc: Support multi-MSI only on uniprocessor kernel
Date:   Tue, 22 Jun 2021 17:26:30 +0200
Message-Id: <20210622152630.40842-2-sbodomerle@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210621144702.GD27516@lpieralisi>
References: <20210621144702.GD27516@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The interrupt affinity scheme used by this driver is incompatible with
multi-MSI as it implies moving the doorbell address to that of another MSI
group.  This isn't possible for multi-MSI, as all the MSIs must have the
same doorbell address. As such it is restricted to systems with a single
CPU.

Fixes: fc54bae28818 ("PCI: iproc: Allow allocation of multiple MSIs")
Reported-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Sandor Bodo-Merle <sbodomerle@gmail.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Acked-by: Pali Rohár <pali@kernel.org>
Acked-by: Ray Jui <ray.jui@broadcom.com>
---
 drivers/pci/controller/pcie-iproc-msi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-iproc-msi.c b/drivers/pci/controller/pcie-iproc-msi.c
index 557d93dcb3bc..81b4effeb130 100644
--- a/drivers/pci/controller/pcie-iproc-msi.c
+++ b/drivers/pci/controller/pcie-iproc-msi.c
@@ -171,7 +171,7 @@ static struct irq_chip iproc_msi_irq_chip = {
 
 static struct msi_domain_info iproc_msi_domain_info = {
 	.flags = MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX,
+		MSI_FLAG_PCI_MSIX,
 	.chip = &iproc_msi_irq_chip,
 };
 
@@ -250,6 +250,9 @@ static int iproc_msi_irq_domain_alloc(struct irq_domain *domain,
 	struct iproc_msi *msi = domain->host_data;
 	int hwirq, i;
 
+	if (msi->nr_cpus > 1 && nr_irqs > 1)
+		return -EINVAL;
+
 	mutex_lock(&msi->bitmap_lock);
 
 	/*
@@ -540,6 +543,9 @@ int iproc_msi_init(struct iproc_pcie *pcie, struct device_node *node)
 	mutex_init(&msi->bitmap_lock);
 	msi->nr_cpus = num_possible_cpus();
 
+	if (msi->nr_cpus == 1)
+		iproc_msi_domain_info.flags |=  MSI_FLAG_MULTI_PCI_MSI;
+
 	msi->nr_irqs = of_irq_count(node);
 	if (!msi->nr_irqs) {
 		dev_err(pcie->dev, "found no MSI GIC interrupt\n");
-- 
2.31.0

