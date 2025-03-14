Return-Path: <linux-pci+bounces-23712-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8B2A6098D
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 08:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89A2D17F47A
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 07:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416151AAA1A;
	Fri, 14 Mar 2025 07:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vyv+EZID"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CF01A5BB2
	for <linux-pci@vger.kernel.org>; Fri, 14 Mar 2025 07:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741936281; cv=none; b=SyKM/wGJkr0Jekq6qgQiVaUzwriMcmQEHylRv5H+mvDT1EHgoeJK6Oqx6uv+0BRC+xatnJ+KjVsrjaKpybF914zozVBhkxRMlRibj6qq5n/9rJGdptxAPKmMipuZQpO9+VOisVHDBAOS+h/sObIgkSqg+O46V0/kcrpcA3Y2EMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741936281; c=relaxed/simple;
	bh=v3Hh5XzM1q70/Zy0diNWQaVYW49fUs4qzgb8E/fNb7E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aWmpwSAjYnmUBxXc+Hani34VAnLN6tEVvs4gH9ZdbMVR/y4eWwSacpKMtg7LhEtvtq0P4QcrnwgsQ3ivVjJ74r2Pg2gPq57CXnCrnLXyfVGEM4hb6pW6skPVbjg3s7huy9xhGNP63FRjZWgv2k/M10HF9xA9JRuVC3IbHHBohIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vyv+EZID; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-225e3002dffso3221495ad.1
        for <linux-pci@vger.kernel.org>; Fri, 14 Mar 2025 00:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741936277; x=1742541077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DavlysOJJOHA17TDQ0xs7RzF5yYVvf6N8aCOT9Y+pcU=;
        b=Vyv+EZIDkDIF497Mv6oJooqGkMsfA6jdETY4/VS34HRNQ82cAi/Yi/i6dMpr4Ipgi9
         SyQsRUbOUtTp5BRbJMmYcslBJ884cMcCQV430WizM7bsGFY/t/XtXiCKLs6pbiqCCA+9
         sOvxayNc5lUR209frwbyr16jomDYTBfcFGwKddyZNeKU72Mewo5ic/PU0PpK4Fku7z2R
         Q5MgeybI7qnJPpMlQt4r567I5W8HPX1T4a68pKVLO0/6tvXZMl7/5MxvPkGDxQRDR7X5
         4LIt1djtoF1cqts7n1D4jSomJZf55wtyhUfytiS+7TOVYAwBy/5x3aEUwPA4vXFVY+dc
         TloA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741936277; x=1742541077;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DavlysOJJOHA17TDQ0xs7RzF5yYVvf6N8aCOT9Y+pcU=;
        b=gqZzqjOyfK91+4iLtmJRqWKiRJ9eaTfXN454rd0/SwwLd/PVsJg/4GiQsv1jTncNQ5
         krbakvsPIfy74z3k6E/hRctRcNTMt3fpLFJunVgVe1OmYYiNZ6AkGufGVuAUWTTAg3MD
         SMmO4OUZz+m981O3m7N+g257DRCYLAtRX6ogrApWk2yr0WGAOLoddviICJHd+pa16tzG
         DnHbLfmcUNnGXwdAjKegulwMKzNJLGekmg7+py+Ihg1Tgvr6+dk/LiJm+r1Hh/tgzbzo
         6Mfxi3R0/J0uhMXrFdH7AT3GwkxHEi2tv3zp+04AjpYTE+GkbFHROfh1TidvHsTxu0xO
         YntA==
X-Forwarded-Encrypted: i=1; AJvYcCXqcotErIoOO2nsY4pF6CQ2Qv9R3T7sa1wpqj9v3wijLFxvMBZZimZbV7I1vgtAMf6h9Y8Lbd8Zxp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjNlsmmh0Hfw+nfwyYqYYN4A7wFwq9mEoVXsbzaVRr9G8iIGqv
	yrY9PxssqcGySfGTGm2HugB/Wzpp/tx0HyR4WdIC5ScySef23lFLY/lANzNt2+71hB6RFQU/tBK
	8pgKxdQ==
X-Gm-Gg: ASbGncsGuG2h8oaWCTnWnw73M/U3IZu0YdJyloAq9UinjH1c3ygHe7PTdL6bn79nsRc
	1O8EpbEh44TB+w2izoa3L70Fy2vhOlGrAHusKHHd4+njCtUt3r1TksW4clKEE1g4z7VWpweCMCS
	NwSGTqPyeCjbafkpeRPxSRAnhtmq0iKmVVA+iRNyRPhLwCH9KauPOmmq+ufeb4O8K1yNuv4gbg0
	CZGqX2rqdmbWht6E1iHKCWYwY4Mq5jGSPvJiMsJW+h4Qbxk+ofaSQSKZeV05fu8VWEkhCSLKh3J
	VX21f7a+G+Sqj2B8bI5fstQP8Z4KnlN9spyighbq7L9zrw==
X-Google-Smtp-Source: AGHT+IGPf7fXWdxEZzxqZBkzaZVDb+txe1gZne9gbcr6A/ds4bXXsnQpygSMKdfyZSdgoHRw/AONzg==
X-Received: by 2002:a05:6a21:648f:b0:1f5:591b:4f73 with SMTP id adf61e73a8af0-1f5c12d8e83mr2531873637.34.1741936277485;
        Fri, 14 Mar 2025 00:11:17 -0700 (PDT)
Received: from gmail.com ([121.37.54.139])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56ea041e7sm1929966a12.44.2025.03.14.00.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 00:11:16 -0700 (PDT)
From: Zhangfei Gao <zhangfei.gao@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev,
	linux-pci@vger.kernel.org,
	Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH] PCI: declare quirk_huawei_pcie_sva as FIXUP_HEADER
Date: Fri, 14 Mar 2025 07:10:58 +0000
Message-Id: <20250314071058.6713-1-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"bcb81ac6ae3c iommu: Get DT/ACPI parsing into the proper probe path"
changes arm_smmu_probe_device sequence.

From
pci_bus_add_device(virtfn)
-> pci_fixup_device(pci_fixup_final, dev)
-> arm_smmu_probe_device

To
pci_device_add(virtfn, virtfn->bus)
-> pci_fixup_device(pci_fixup_header, dev)
-> arm_smmu_probe_device

So declare the fixup as pci_fixup_header to take effect
before arm_smmu_probe_device.

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/pci/quirks.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index f840d611c450..a9759889ff5e 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1991,12 +1991,12 @@ static void quirk_huawei_pcie_sva(struct pci_dev *pdev)
 	    device_create_managed_software_node(&pdev->dev, properties, NULL))
 		pci_warn(pdev, "could not add stall property");
 }
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa250, quirk_huawei_pcie_sva);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa251, quirk_huawei_pcie_sva);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa255, quirk_huawei_pcie_sva);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa256, quirk_huawei_pcie_sva);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa258, quirk_huawei_pcie_sva);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa259, quirk_huawei_pcie_sva);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HUAWEI, 0xa250, quirk_huawei_pcie_sva);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HUAWEI, 0xa251, quirk_huawei_pcie_sva);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HUAWEI, 0xa255, quirk_huawei_pcie_sva);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HUAWEI, 0xa256, quirk_huawei_pcie_sva);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HUAWEI, 0xa258, quirk_huawei_pcie_sva);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HUAWEI, 0xa259, quirk_huawei_pcie_sva);
 
 /*
  * It's possible for the MSI to get corrupted if SHPC and ACPI are used
-- 
2.25.1


