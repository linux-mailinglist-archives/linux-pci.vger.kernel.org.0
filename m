Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97E9C1D9EA4
	for <lists+linux-pci@lfdr.de>; Tue, 19 May 2020 20:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbgESSCK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 May 2020 14:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729346AbgESSCK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 May 2020 14:02:10 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A4EC08C5C2
        for <linux-pci@vger.kernel.org>; Tue, 19 May 2020 11:02:09 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f134so180497wmf.1
        for <linux-pci@vger.kernel.org>; Tue, 19 May 2020 11:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hORlUUicNTnmubGRwNiUffCoZPiWJG9HuOL8osSXdzo=;
        b=RaBfqvZBLG2+O2ys2+0Ikq5Wp+XHH/rqPMkeuqJRaQX3zplSn8zIVMkUTAPhGK28u9
         wAEiv6Yy2jClvwowLeJGvp9nz/q2xjW3B1m8ef6AweRUFIRQce+1qhbFZu9Iqxpgb93T
         HQS/ayRa/QKZAcPdong1IOD4jlzFFccRioNNAzKo4Svis/lAW9o32Xi6WC9+XqJP5jVD
         95wb3prQy7RhU+V9NvD9Uimr2HAe66cN0BSaK01ShE8K4Vh5b6WaVDUh0vqD6yii3Akb
         VvWJQ/nNMjB1sgj37nXUu8itMP/AiTtQykovHtt0BFwZVr2yuqgX+iT4E9CLWqxkgpmY
         SZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hORlUUicNTnmubGRwNiUffCoZPiWJG9HuOL8osSXdzo=;
        b=UTsnPZwZ9UqbajYnqkzAXmZBUZyOU6KpX1DoZ7yDszXRfWK8VT+wXz1SRDsxkbD5jF
         lpwPzGiJw5RjLdopTTw6yt59TGTsYYAvaGVbb/nyq5kpUTP5R602xTitx50YkNDGPNhW
         ihh6bP7QXmmThNlCxat/iTtdkJYbQNfAytPVEpYvkk3IRb2obfYaLqbUM44DRrzHydc7
         DJS9GAFbm1cRefFfeW93XODOT48pPKPsD4PfvnpCMlkE3ayulQSV6AX4mhl0+lW5b36G
         8ePyxTcwGnCZjVv/G7NVH74JXEuMSFrQJwuFuwx2ilSdJrbiRttkvS72mZ9lq98UiFJd
         02Sw==
X-Gm-Message-State: AOAM5319XVGNm6ccieUmguWh2tWYQ7EokHmXQvGFJwdhMdkNSxJS1Y2n
        1tt9prhKuyHIxKzfgE7zqOeZuw==
X-Google-Smtp-Source: ABdhPJxkJn6Qhu9nn0EKvZWG6V4NMT7DJRYrUqG7GGKCgCc/g26MRyJ+LKLXQeOruPfp1Lim/+kFJw==
X-Received: by 2002:a05:600c:29a:: with SMTP id 26mr615194wmk.151.1589911328505;
        Tue, 19 May 2020 11:02:08 -0700 (PDT)
Received: from localhost.localdomain ([2001:171b:226e:c200:c43b:ef78:d083:b355])
        by smtp.gmail.com with ESMTPSA id 1sm510496wmz.13.2020.05.19.11.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 11:02:08 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org
Cc:     joro@8bytes.org, catalin.marinas@arm.com, will@kernel.org,
        robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, Jonathan.Cameron@huawei.com,
        jacob.jun.pan@linux.intel.com, christian.koenig@amd.com,
        felix.kuehling@amd.com, zhangfei.gao@linaro.org, jgg@ziepe.ca,
        xuzaibo@huawei.com, fenghua.yu@intel.com, hch@infradead.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH v7 23/24] PCI/ATS: Export PRI functions
Date:   Tue, 19 May 2020 19:55:01 +0200
Message-Id: <20200519175502.2504091-24-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200519175502.2504091-1-jean-philippe@linaro.org>
References: <20200519175502.2504091-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The SMMUv3 driver uses pci_{enable,disable}_pri() and related
functions. Export those functions to allow the driver to be built as a
module.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/pci/ats.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index a4722e8b6a51..418737a3c2c2 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -191,6 +191,7 @@ void pci_pri_init(struct pci_dev *pdev)
 	if (status & PCI_PRI_STATUS_PASID)
 		pdev->pasid_required = 1;
 }
+EXPORT_SYMBOL_GPL(pci_pri_init);
 
 /**
  * pci_enable_pri - Enable PRI capability
@@ -237,6 +238,7 @@ int pci_enable_pri(struct pci_dev *pdev, u32 reqs)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(pci_enable_pri);
 
 /**
  * pci_disable_pri - Disable PRI capability
@@ -316,6 +318,7 @@ int pci_reset_pri(struct pci_dev *pdev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(pci_reset_pri);
 
 /**
  * pci_prg_resp_pasid_required - Return PRG Response PASID Required bit
@@ -331,6 +334,7 @@ int pci_prg_resp_pasid_required(struct pci_dev *pdev)
 
 	return pdev->pasid_required;
 }
+EXPORT_SYMBOL_GPL(pci_prg_resp_pasid_required);
 #endif /* CONFIG_PCI_PRI */
 
 #ifdef CONFIG_PCI_PASID
-- 
2.26.2

