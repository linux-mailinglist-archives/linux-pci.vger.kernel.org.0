Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A97B1E2149
	for <lists+linux-pci@lfdr.de>; Tue, 26 May 2020 13:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732018AbgEZLuR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 May 2020 07:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732014AbgEZLuQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 May 2020 07:50:16 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98F0C03E96E
        for <linux-pci@vger.kernel.org>; Tue, 26 May 2020 04:50:16 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id cx22so1338299pjb.1
        for <linux-pci@vger.kernel.org>; Tue, 26 May 2020 04:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rzP5fzn/E340EPlW7gDpFBlyEkfSVaF1oJz6fYo76k8=;
        b=cSls9zjl0whNH0eR/l2i02O95OOhgGrNGwM26ZGFvkQW9VtZxJfxlywizJRke/rmbm
         DjeTG2qfQRIUFCJCYqf3IQGjZY5BYNOiPnuTiljaUSiUooWYyRzwspOmUiqDqG0M0ZC0
         NH/f8WAxs2sULx5ClU2rSJ/IVPF1eLlml+6rdIo1i25jIwEm+AfsqPAhvJRo8r0X4r3K
         IiHWdbIh+eGq5kqb6u0B/VzWcIY6fcWtE+dhbKonQdK7ew/58LBw5We1pNCxs/7oweP5
         Jjm4EUWxVNg2+Xy8U6NcCfQFYKXK3ubEYUyGEqX5s/R/MQ0L946l4eUlakQO2SpHpvOw
         LfPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rzP5fzn/E340EPlW7gDpFBlyEkfSVaF1oJz6fYo76k8=;
        b=TRN/H91bkHYgd8vYqK+oCk3sg7PHI2Ezuq/ypYfAbMKhLB4yuTLeLBfGZrzyuwrpCb
         JBYvuHplnfjPKQNMurz4hYnKPtiSAvZ5gLH+IRgDnawLmozm2i9CMo91voPLRxeQH4/+
         VZDsfnqKuGbTNwv/wgYJs136mk5QHNODgZtmarR1JvmKgPHJT01CrYBcCKRzEYh4Y71E
         uKMKmtJqbhgf5I1jnXyBB6QLa7/TipYf9ABdcmeIP4XbpR56nejAR8ZhobuJpB8E0FXx
         oPz0ddyhhrQj83JlNypy8T6CHWlHL9xx+61NbIC0py8gndLmf5ZcZYR/oUh0sxXpBTDx
         w4Jg==
X-Gm-Message-State: AOAM530bjWAc0zYg+UVvVERH2ZaD8TDx9rLA00dth8GC42cp5Yz1ycpF
        aZ1lULactvugZlMKm2m8MFnAkQ==
X-Google-Smtp-Source: ABdhPJzHFiU9uQ9tpgEPP89QRh+ApddGGVo2/M4MgxGlH4yKc3wRc1jVL2ox1xaiLvr1T78JAyGRGQ==
X-Received: by 2002:a17:90a:4809:: with SMTP id a9mr26082742pjh.196.1590493816386;
        Tue, 26 May 2020 04:50:16 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.9])
        by smtp.gmail.com with ESMTPSA id c12sm15586567pjm.46.2020.05.26.04.50.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 May 2020 04:50:16 -0700 (PDT)
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
To:     Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        jean-philippe <jean-philippe@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH 2/2] iommu: calling pci_fixup_iommu in iommu_fwspec_init
Date:   Tue, 26 May 2020 19:49:09 +0800
Message-Id: <1590493749-13823-3-git-send-email-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590493749-13823-1-git-send-email-zhangfei.gao@linaro.org>
References: <1590493749-13823-1-git-send-email-zhangfei.gao@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Calling pci_fixup_iommu in iommu_fwspec_init, which alloc
iommu_fwnode. Some platform devices appear as PCI but are
actually on the AMBA bus, and they need fixup in
drivers/pci/quirks.c handling iommu_fwnode.
So calling pci_fixup_iommu after iommu_fwnode is allocated.

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/iommu/iommu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 7b37542..fb84c42 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2418,6 +2418,10 @@ int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
 	fwspec->iommu_fwnode = iommu_fwnode;
 	fwspec->ops = ops;
 	dev_iommu_fwspec_set(dev, fwspec);
+
+	if (dev_is_pci(dev))
+		pci_fixup_device(pci_fixup_iommu, to_pci_dev(dev));
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(iommu_fwspec_init);
-- 
2.7.4

