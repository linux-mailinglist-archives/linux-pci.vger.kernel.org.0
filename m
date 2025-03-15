Return-Path: <linux-pci+bounces-23821-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D851CA62ABE
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 11:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0D52189D453
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 10:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC9A1F4C8C;
	Sat, 15 Mar 2025 10:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vnUfSK+j"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEE51A2388
	for <linux-pci@vger.kernel.org>; Sat, 15 Mar 2025 10:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742033614; cv=none; b=Ygmv2hlqROJxf26+RFgT8kP2/R0Wk4/h+1KmKSeamXLG+08FXmeu0/wKylqsDCkcE1AeoGXtbWPSXU6h5PxyG1u6Oe+PAVA6dopdiUuoGj76US9OgxCvgRvYtTs5/9Ygm664N5QmSFmcyA7Ip7vd5MjyqZMUPkX1OTtlVVk7Vbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742033614; c=relaxed/simple;
	bh=vo1Ew4aLSrrge0Lgz3BYM6r54y2dPTj2RJNNDXpsAMc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cBK+QPy/nZUz2nKOSkeMLYP8g3V04q2pQNjHyv/fTOaU3kItvsE9Dnu/yU/1OuCK4UJg9vnGfeHwuvFpOGLwOgToSwZ4/DJKqVHdImInUImcRLCa+xhoC3NXY46rUUPvi6bj4L4RH3hTqvyMKYvIBA5UfynlN7dEUbCLvzpoaDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vnUfSK+j; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2255003f4c6so50501445ad.0
        for <linux-pci@vger.kernel.org>; Sat, 15 Mar 2025 03:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742033612; x=1742638412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yyw0PGKWLV1nMfM+kNzqLLYQtPTsmeX5w4ikFyh9R7s=;
        b=vnUfSK+jT8F4QyGrnzVqQfRYAhSsmuXU4o+i7YW0fCxaWCAggy8tsVNOadXzZFLUrw
         QklMxmX56hXc7+9Y25R4ptz5IB0VQ4PNBqyuWXpkrEGPjM7Ze06HoYYjd19FteBBGBGg
         EpHALVm1bVq3hapdgmvJV/XYHeBH86ULNUFJG8LvOGm71ApFHwy+12LpZwokH5sB9Ryc
         99ldqpwIrcO1os6lt/hdstut52/1gHydS0A+O1qBWNrZ1qLWiFzgOSa48mmgxuAPqKcM
         ++EDHuMwQX05c52Lans/6bVodAVsOVfKcfSptycRjmxEIfrU2QwCPjZvLdoaoXenV3QP
         K1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742033612; x=1742638412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yyw0PGKWLV1nMfM+kNzqLLYQtPTsmeX5w4ikFyh9R7s=;
        b=gSJakzYDVtWfxJP0ut6b+QNpxNH2k8d9EM5EKq/hCAGZgkR9GsAdu44M63ucLvlPPR
         laLuUazwR8Uw+9V1ELmFa3EnU5Zt5g361si+VmqKn3wPILa+e2YzrGWH55fALUCzN3aP
         /jM6WPU/dBP0YitOZDaaGDoCBliQ0OKBPC74FTYZqF26bDX6G1EEB6UQ8OqJElR4iA50
         3qMHHk9UXtAoa7KBzYI1cXiw+nWFxw02BcBU4UY8UEtS9awe4WzPfc7JkR5KgM4Pkeic
         PKAuqzaMd2HZsAWN7VO0Ic+LDwcuilk9uGC3V/TxdC2zVh/Ivln0E3GViMxNPr1LrYSd
         eZRw==
X-Forwarded-Encrypted: i=1; AJvYcCUKwOeaBZd8t+rY9W+9ZCIGg8SO+bxJ/0AE6LC4M8VHsfaDqCjIrbGYpwmidiTCU8drZfV63DxDyX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM6Px8Jhys31YdeSkTSNvjSJHLDeXKYRGk+7+0GPGALsgI/O4f
	GTZn3ISosLMcQDSo6ZxMN0NruH95FketaR28jTFiT10UKby9ZNupy2wlo44Pn5Y=
X-Gm-Gg: ASbGncsm6XjL4zIpUGTMNFqNIx7PBOYkZzfG85MgYbk63KFRfGnKIRklmRyXfDmY0m1
	F7PBI7ZR+DNPercTl6+UqUwgnFTfrFYfma5Vvnvr0Dq1AlCxYbgasyuehs28ywldMpX4qKM49vL
	UxWNo/g/964b7AgKLQMvns+mKbs7Gud8+icGjgHdLLARi6pEXBM8lVpRdF8nojWxKkOolStV8R/
	juKtrTc1y8BBAMHQsrzz4K8r9ELqw59x1LzCAqlzGgzqKSO3/LF9nC1TMzoBiBKCndXvrdGOFrc
	rq/SWnJx2YW0oIejtRoCHCFWw6uK3q1Te57Z7plhFYrIAg==
X-Google-Smtp-Source: AGHT+IHc+zbfLPsEbvvVLayren4erBe1Dj0SSg+NK2HsIPUFW6sh7RHagO+DW1A24D8x9HdCwjeFHQ==
X-Received: by 2002:a17:903:3c50:b0:224:1579:5e8e with SMTP id d9443c01a7336-225e0a3635emr76218415ad.1.1742033612590;
        Sat, 15 Mar 2025 03:13:32 -0700 (PDT)
Received: from gmail.com ([121.37.54.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c688846csm41957545ad.33.2025.03.15.03.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 03:13:32 -0700 (PDT)
From: Zhangfei Gao <zhangfei.gao@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: iommu@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH v2] PCI: Declare quirk_huawei_pcie_sva() as pci_fixup_header
Date: Sat, 15 Mar 2025 10:13:19 +0000
Message-Id: <20250315101319.5269-1-zhangfei.gao@linaro.org>
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


