Return-Path: <linux-pci+bounces-23820-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C6BA62ABC
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 11:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1477E3B9B0A
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 10:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4A01E1C1A;
	Sat, 15 Mar 2025 10:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TCxgd/Zn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C74718DF73
	for <linux-pci@vger.kernel.org>; Sat, 15 Mar 2025 10:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742033450; cv=none; b=bD48MkyaKwdE32zd0EPceiccEJf5bKZL2L6y5vK3lzn90Yy/WzZco53+UR0xc9+nG213IWfKnaXBaO6gDfr3ZRiyvdP6UgqbxE7/akuJqBjbfdfsT3vlLrUrUhJ+TnbCnZjYRA01g5KCL9LRf+e8y+SrQ7f0zo57QbCYPe5RUnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742033450; c=relaxed/simple;
	bh=vo1Ew4aLSrrge0Lgz3BYM6r54y2dPTj2RJNNDXpsAMc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RKe0DddkwQxJ1Q4halDcbWFzazzPeKt9s46ZkE0e0qVc0xZhExsaqo8Nb9g5V5GAltGlAJqju8m4OUz3yBQaLlENl7DEZeonpSPox/6jcGtTKxCGlC3K1ha6kuAhKCr2CjLHGz1/9I2A2hbF4E0A8IRxY9HSYcUyevK4vyI9fk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TCxgd/Zn; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-224019ad9edso72560935ad.1
        for <linux-pci@vger.kernel.org>; Sat, 15 Mar 2025 03:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742033446; x=1742638246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yyw0PGKWLV1nMfM+kNzqLLYQtPTsmeX5w4ikFyh9R7s=;
        b=TCxgd/Znrq1Pa4kN1zt5GI53SwfjxlCvojXLTMRTzyGtaybRdu8cDhULHVSyplAeQl
         baUit4Ffaaa9x8LOTvi3ENtZoWeWhgl6oD6K5txCybrmQFzou42GctxIIBj+3nYSKiA1
         GqcSEdQS5J5fC9cyRaj/TTouT3d5GbAf9usaE9ErcSWLdafThnCgc2HEnIh/zreDiJDx
         NQGw1e/vG3anLiXKZNr8Htc+ptSi0rzLZWE8kEy6K4zfXlEwueaMTJZ9LusTIrDNJXxr
         OMmigsMqBxZv40KpXzGDbqhNPnCLo12eLO0/7bTOrfZiP35izWnfdN2skgZfHYfqnaAo
         HNlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742033446; x=1742638246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yyw0PGKWLV1nMfM+kNzqLLYQtPTsmeX5w4ikFyh9R7s=;
        b=IXmROwTP+2jvO+akSwtJGMGGSy3ZALWvYfvleaKlorI8UbbP2voNGGIyAXhhfnv6zJ
         Vg5z6gmNBuWZeiKTi7N6qEQuLcqHT7RO6KBxvTYJzebaZjKsmKkJIQbNpMudg3A4Fu6I
         CfZVpMqs7bydPlFo6BoZgXuigVzVCbp5h2eGiq89SGpg4+ciPAPy1WS7/PIVAfh0eN2T
         s5+U2azPLA4/3BIo1FrnHmJh9uosPwag+b4cEuMDzyVEQ3E1iCVOAhNuD73mfoHGCwsr
         iKEPxEKXNZnzm2XVQGae4WvVh+/97jz6Den3quXcZIngIGMMy1TH/Swi4NskYE/ko7IH
         lm0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVzyal5PxEITwBOZIHnhF1Jq8uhQiHncjjNs0TWDqcpDSI7jmafIQbhCIJ1Asrl4XuOUF6GEYr1zlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW0SPZEy2NgrGQ8SUz7mSPXpoM7lrAvovniS1E5FqdG75Tigrg
	9zmR7gDEF1Twp3CSVyCegEn6HF/KYTSwi/VA8gQsyiXffjc3XUPOXZ/VAVqe/0o/Uu8By5xcS1+
	kyRYAYA==
X-Gm-Gg: ASbGncvjOOSqHphq0A6AG7K+q5Z+UHtG29GCYMFcg+9Tb5Dr+6poDbWfZkSrJtksTLJ
	CH2HP1o3ep9PMBPfAblCqwee22Nc34ih5DsNrHUSpuUO5Xq8lln23PsWh7x9xAjeEqMJE1oN0eF
	qyoAiQhcc91EpOS6o+003Z+03muL6LAFhMaKamKuQ/YSrB3+QbLwdhtwwczAAQTVGiYY3O8zNwI
	zGlOCN/J+SORmb9UgLiPc3nhk7Tl9imnP+SFuceGiHuQiVTKo1lKvOhCWiFLEjesqU9I9CxWV+Y
	/JZLalSJkAgBudRo7uV3k2QLalKZmABzxSqNevkHat6eiQ==
X-Google-Smtp-Source: AGHT+IHosIY5bP7h7ArQEoRLmL4SQpY/tfLFxgPSITUzhMnagdaeGJGiz8uq3+AHPbKPkmPtW1BXFw==
X-Received: by 2002:a05:6a00:a27:b0:736:4644:86ee with SMTP id d2e1a72fcca58-7372235af19mr6775218b3a.14.1742033446613;
        Sat, 15 Mar 2025 03:10:46 -0700 (PDT)
Received: from gmail.com ([121.37.54.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-737115511dasm4305588b3a.60.2025.03.15.03.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 03:10:45 -0700 (PDT)
From: Zhangfei Gao <zhangfei.gao@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: iommu@lists.linux.dev,
	linux-pci@vger.kernel.org,
	llinux-kernel@vger.kernel.org,
	Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH v2] PCI: Declare quirk_huawei_pcie_sva() as pci_fixup_header
Date: Sat, 15 Mar 2025 10:10:32 +0000
Message-Id: <20250315101032.5152-1-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250314071058.6713-1-zhangfei.gao@linaro.org>
References: <20250314071058.6713-1-zhangfei.gao@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The commit bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper
probe path") changes the arm_smmu_probe_device() sequence.

The arm_smmu_probe_device() is now called earlier via pci_device_add(),
which calls pci_fixup_device() at the "pci_fixup_header" phase, while
originally it was called from the pci_bus_add_device(), which called
pci_fixup_device() at the "pci_fixup_final" phase.

The callstack before:
[ 1121.314405]  arm_smmu_probe_device+0x48/0x450
[ 1121.314410]  __iommu_probe_device+0xc4/0x3c8
[ 1121.314412]  iommu_probe_device+0x40/0x90
[ 1121.314414]  acpi_dma_configure_id+0xb4/0x100
[ 1121.314417]  pci_dma_configure+0xf8/0x108
[ 1121.314421]  really_probe+0x78/0x278
[ 1121.314425]  __driver_probe_device+0x80/0x140
[ 1121.314427]  driver_probe_device+0x48/0x130
[ 1121.314430]  __device_attach_driver+0xc0/0x108
[ 1121.314432]  bus_for_each_drv+0x8c/0xf8
[ 1121.314435]  __device_attach+0x104/0x1a0
[ 1121.314437]  device_attach+0x1c/0x30
[ 1121.314440]  pci_bus_add_device+0xb8/0x1f0
[ 1121.314442]  pci_iov_add_virtfn+0x2ac/0x300

And after:
[  215.072859]  arm_smmu_probe_device+0x48/0x450
[  215.072871]  __iommu_probe_device+0xc0/0x468
[  215.072875]  iommu_probe_device+0x40/0x90
[  215.072877]  iommu_bus_notifier+0x38/0x68
[  215.072879]  notifier_call_chain+0x80/0x148
[  215.072886]  blocking_notifier_call_chain+0x50/0x80
[  215.072889]  bus_notify+0x44/0x68
[  215.072896]  device_add+0x580/0x768
[  215.072898]  pci_device_add+0x1e8/0x568
[  215.072906]  pci_iov_add_virtfn+0x198/0x300

Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe path")
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
[kwilczynski: commit log]
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---

v2: Modify commit log

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


