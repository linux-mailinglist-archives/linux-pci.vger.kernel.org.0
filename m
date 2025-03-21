Return-Path: <linux-pci+bounces-24291-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CA4A6B2C8
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 02:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EE52882806
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 01:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FE01DF979;
	Fri, 21 Mar 2025 01:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uJ2slKpt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E777D1E0DBA
	for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 01:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742522306; cv=none; b=k0UA68UwByv8O4A8I1qRSWs/gLlzvNpR9V8bnjU2AcsZIgRDv5aFq7ztv7Gz6uup4idFbzP32dV0X8wBnZYm/dHB+PoCECsUa66KahynidTp/V6MnkGnznqPLYHs0tDzzIHXiHVbU3aVi7RvQ2iXalF4iKresLlEryFRErsaNio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742522306; c=relaxed/simple;
	bh=dTbJMiOM8w8eTApIsT0zFZVI4R8afXrqoMJE/SCp08k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RwvZ81qIHR9UznIQmSBXdXptxz4YYI/KGthzPhOAZlH8MdAV8wtK6sBFbAMkb3EoiMDPHFOVSYzcXF7UJoBn909aOSAIoL29sG+dbg7x8McH4Ag2EOQrJGq744p1MVs9uW+RNiwAZ5sWs656AYF83m+PFDTfoxlQGyYMgsitD3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uJ2slKpt; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff605a7a43so3673829a91.3
        for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 18:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742522303; x=1743127103; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5o+H1+slcsM+kRAnO5vDiFeOSdTxVMfuQTpFrFusKP8=;
        b=uJ2slKpty7U+qCGHRqv/BiTkFZX19K/omtrHudyXKLGApaQBG1YEZzEMjHaJD+EP31
         GqhJ1PuWZJpxSRFpCIoagCDbH7AIrE7FBVV1m8N59jgdbuiQXzD1BxJPG1mBEh3pBtBy
         lvZ1PF3BtRurEinXCO25uopWA33kVvkAx9KEq31cAehXUYiv6x0B+1ZIrmAh3NqzQgZh
         7iVRGZTjT/lOQkg5yvTLtSQBiFU3VkGcAcIYg71/R3Qfe6nadREaEI+XQJtOUd8DuE6S
         epXFAIYuaaiLUI+afpSBUsazi/cgAfnOCzyrQc8m+I7RXjLnT2aZZHm9YWxiNlBEP+xb
         iTHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742522303; x=1743127103;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5o+H1+slcsM+kRAnO5vDiFeOSdTxVMfuQTpFrFusKP8=;
        b=QZWTfwJLlnae58ahxSk8OL3hFnFNY6jK6sEpRfU89O/mIhNRsIvRvA4XhZFYZ0rDlI
         iYh+wmJLQUt8zHai4q5bLkm68shmB0hr0HHS7bPE0AJ5V+KYh62V6FXnmYS2R1ds7Hzz
         87HMfvUxbaPPRnAfD3t+FYAdFqiCKsOmVcePi9Z/kkCOM91Y42sCeBdNNJN4FtlxjeWu
         pGxq0Fv0jxhs3CTrZvD3t0WiTb810vKpEgojCEMPcIrcbRfc/f7gU+Gaf9f9i+/TlsAw
         ZqgUyYhOi7JzsKXgFJTlSS45CEs+A/rpCQm7vAUM1ocxYZtK13p43MoOo/Kpxc8SsXPv
         2NEA==
X-Gm-Message-State: AOJu0YxQXnE0FAp3rHI/uFBVupmtEpBsIhiYE4Dvqu55zHvnEd70uldl
	jeA+/QeVGmM5AkweikOtMIYFIFRLU6XJGcEfZD7ZJk4RYAGvCGMTkonoXq/WDjfAFfgOT88S77T
	0Tg==
X-Google-Smtp-Source: AGHT+IGilcyPCWNu864h2jEzpMYcvLo7bAWmF9h6hjnvT1Z817uL9EvDSbCLT5XwdmbKQHLLxfj8CGZErvY=
X-Received: from pjbpq9.prod.google.com ([2002:a17:90b:3d89:b0:2fa:a101:755])
 (user=pandoh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:528b:b0:2fa:17dd:6afa
 with SMTP id 98e67ed59e1d1-3030feb1d3dmr2539113a91.17.1742522303169; Thu, 20
 Mar 2025 18:58:23 -0700 (PDT)
Date: Thu, 20 Mar 2025 18:58:01 -0700
In-Reply-To: <20250321015806.954866-1-pandoh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250321015806.954866-1-pandoh@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250321015806.954866-4-pandoh@google.com>
Subject: [PATCH v5 3/8] PCI/AER: Move AER stat collection out of __aer_print_error()
From: Jon Pan-Doh <pandoh@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>, 
	Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, 
	Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>, 
	"=?UTF-8?q?Ilpo=20J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, 
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Sargun Dhillon <sargun@meta.com>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Jon Pan-Doh <pandoh@google.com>
Content-Type: text/plain; charset="UTF-8"

Decouple stat collection from internal AER print functions, so the
ratelimit does not impact the error counters. The stats collection is no
longer buried in nested functions, simplifying the function flow.

AERs from ghes or cxl drivers are a minor exception. Stat collection occurs
in pci_print_aer(), an external interface, as that is where aer_err_info
is populated.

Signed-off-by: Jon Pan-Doh <pandoh@google.com>
Reported-by: Sargun Dhillon <sargun@meta.com>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
---
 drivers/pci/pci.h      |  1 +
 drivers/pci/pcie/aer.c | 10 ++++++----
 drivers/pci/pcie/dpc.c |  1 +
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 75985b96ecc1..9d63d32f041c 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -551,6 +551,7 @@ struct aer_err_info {
 };
 
 int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info);
+void pci_dev_aer_stats_incr(struct pci_dev *pdev, struct aer_err_info *info);
 void aer_print_error(struct pci_dev *dev, struct aer_err_info *info, const char *level);
 
 int pcie_read_tlp_log(struct pci_dev *dev, int where, int where2,
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 3116b4678081..e5db1fdd8421 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -617,8 +617,7 @@ const struct attribute_group aer_stats_attr_group = {
 	.is_visible = aer_stats_attrs_are_visible,
 };
 
-static void pci_dev_aer_stats_incr(struct pci_dev *pdev,
-				   struct aer_err_info *info)
+void pci_dev_aer_stats_incr(struct pci_dev *pdev, struct aer_err_info *info)
 {
 	unsigned long status = info->status & ~info->mask;
 	int i, max = -1;
@@ -691,7 +690,6 @@ static void __aer_print_error(struct pci_dev *dev,
 		aer_printk(level, dev, "   [%2d] %-22s%s\n", i, errmsg,
 				info->first_error == i ? " (First)" : "");
 	}
-	pci_dev_aer_stats_incr(dev, info);
 }
 
 void aer_print_error(struct pci_dev *dev, struct aer_err_info *info,
@@ -784,6 +782,8 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 	info.mask = mask;
 	info.first_error = PCI_ERR_CAP_FEP(aer->cap_control);
 
+	pci_dev_aer_stats_incr(dev, &info);
+
 	aer_printk(level, dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
 	__aer_print_error(dev, &info, level);
 	aer_printk(level, dev, "aer_layer=%s, aer_agent=%s\n",
@@ -1263,8 +1263,10 @@ static inline void aer_process_err_devices(struct aer_err_info *e_info,
 
 	/* Report all before handle them, not to lost records by reset etc. */
 	for (i = 0; i < e_info->error_dev_num && e_info->dev[i]; i++) {
-		if (aer_get_device_error_info(e_info->dev[i], e_info))
+		if (aer_get_device_error_info(e_info->dev[i], e_info)) {
+			pci_dev_aer_stats_incr(e_info->dev[i], e_info);
 			aer_print_error(e_info->dev[i], e_info, level);
+		}
 	}
 	for (i = 0; i < e_info->error_dev_num && e_info->dev[i]; i++) {
 		if (aer_get_device_error_info(e_info->dev[i], e_info))
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 9e4c9ac737a7..81cd6e8ff3a4 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -289,6 +289,7 @@ void dpc_process_error(struct pci_dev *pdev)
 	else if (reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_UNCOR &&
 		 dpc_get_aer_uncorrect_severity(pdev, &info) &&
 		 aer_get_device_error_info(pdev, &info)) {
+		pci_dev_aer_stats_incr(pdev, &info);
 		aer_print_error(pdev, &info, KERN_ERR);
 		pci_aer_clear_nonfatal_status(pdev);
 		pci_aer_clear_fatal_status(pdev);
-- 
2.49.0.395.g12beb8f557-goog


