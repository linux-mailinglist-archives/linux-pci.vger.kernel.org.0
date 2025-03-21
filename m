Return-Path: <linux-pci+bounces-24289-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7D3A6B2C4
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 02:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B81AF7A49DF
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 01:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DD01E1A31;
	Fri, 21 Mar 2025 01:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mpElgeHg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A711E0DBA
	for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 01:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742522301; cv=none; b=Q1F3QJ3/9DFlFQCgY8/dDUCU6G5ObdQrX5scuOwetUUhYkkwYHKrLDyT+tV+8L/dRGiQGeJiuAcUKoC1gSPWYX2JgA6VYP/UpshS7n4XqZaeYlIXKXSeoHUVmmS/yqbAylSgnZW273YAej7U/NupRQXMiN/e05MgU+SMqftMiBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742522301; c=relaxed/simple;
	bh=7almazT6KfTWEap1S6wf9x3QXeB8agLb0ZD6yXeWsVw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=urDGTN8jcneFI2T0GmWT7ABgkfWTb5qecY6Fd2Stc4zGo9ICMagSjEVDwR7segEQk2t61saBeUNrtW43tDnueCbQ8Aji3zdvZPsIWnui/d5f7eAoskji2ataUMUetgorXmRHB7IevSt2xtM/5ZTwtZvDK00aZYenkNrWYOopxiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mpElgeHg; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2241e7e3addso19584835ad.1
        for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 18:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742522297; x=1743127097; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FDlB1RVfCR7nk6uMtaKocbEO2vLTixw+qKZEpWq08Rs=;
        b=mpElgeHg+QVjMyKCfquqo/i5QQabMUao13Jvmjnpz1U+M28NJXhJm6RAMFn1vhu7PF
         dypS2ArjdwZrjHB5isBIopIkySPemN3r+7zFBl9si3o2Nd0FoSTUPbgdSiFn5cGYexC9
         uIzk3B5uKrgadO0yUvSwoX857Ic47fGhCpK21Xec/fwYWq8grcx3gNKiTgWcvF2v8D7H
         yzGR4lVa/vYkoHKC7tw1ReHfQy0pPocB0ytcYlTdrgZI6Wo+Au77mPeKLE5Hk6SIpYMJ
         j22JDUWTA5k/bkFqloUMdpp0shZBtQKTPI5m+F9zWdCSfOpEUou5gbNWVh5WMJ+AcW15
         88Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742522297; x=1743127097;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FDlB1RVfCR7nk6uMtaKocbEO2vLTixw+qKZEpWq08Rs=;
        b=fZ9GcsbSDyhO2qDVy5tt5Y6MTyFGeztLHseYEEyix9Si2CiM7jqfDKNiE5/hFbWCRb
         mb8UVhQc2TyjKu5O6Bzd4xMvxdPnlH5GGp3je+cUBKnkaI4odSSEH/C9ummZ4w0WRcmm
         7xAJo7B28rdEYeL3pjCzjU1CRHuojx4c7g0amZfoq4FU8dYlFAnLIxBRNZ7D1uqVjj+w
         ZltCRx61mdVD8DM8qY8AcU07p6NaaKBKCM2/ZLw6v8ldDM7m+nMkPJD7Vf20mZKQP/VM
         SYTG9qgnC986IGPVirFKjaOh5/JG4o3Ub5uY9xPLy/3/AmjUB2dtLljWeQ8Sq9U9ECF4
         rITg==
X-Gm-Message-State: AOJu0Ywb6+yYUIp0dsBvoD5f7rElUJtJK0pWIDn5jRVZynyM18KS9OY9
	YrEVXgVqar+eGUkA6AT5yfkUeiiM3fuUcS6w570RNi2M1cdd2pPx7cyhy2UkecvRW7oEUBe6+vF
	KjA==
X-Google-Smtp-Source: AGHT+IGHfQViGTBq/dvJbC2+GdWKb5TEL9gO4pgkG21ms2i8spYMzfpoBd1feq8YhFByhasH/lwrTXYqglE=
X-Received: from pfjt20.prod.google.com ([2002:a05:6a00:21d4:b0:736:4ad6:181b])
 (user=pandoh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ecc4:b0:224:1935:fb91
 with SMTP id d9443c01a7336-22780da5a45mr21718265ad.27.1742522297452; Thu, 20
 Mar 2025 18:58:17 -0700 (PDT)
Date: Thu, 20 Mar 2025 18:57:59 -0700
In-Reply-To: <20250321015806.954866-1-pandoh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250321015806.954866-1-pandoh@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250321015806.954866-2-pandoh@google.com>
Subject: [PATCH v5 1/8] PCI/AER: Check log level once and propagate down
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

From: Karolina Stolarek <karolina.stolarek@oracle.com>

When reporting an AER error, we check its type multiple times
to determine the log level for each message. Do this check only
in the top-level functions (aer_isr_one_error(), pci_print_aer()) and
propagate the result down the call chain.

Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>
Signed-off-by: Jon Pan-Doh <pandoh@google.com>
Reported-by: Sargun Dhillon <sargun@meta.com>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Jon Pan-Doh <pandoh@google.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/pci.h      |  2 +-
 drivers/pci/pcie/aer.c | 34 +++++++++++++++++-----------------
 drivers/pci/pcie/dpc.c |  2 +-
 3 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index b8911d1e10dc..75985b96ecc1 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -551,7 +551,7 @@ struct aer_err_info {
 };
 
 int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info);
-void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
+void aer_print_error(struct pci_dev *dev, struct aer_err_info *info, const char *level);
 
 int pcie_read_tlp_log(struct pci_dev *dev, int where, int where2,
 		      unsigned int tlp_len, bool flit,
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 9cff7069577e..45629e1ea058 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -670,20 +670,18 @@ static void pci_rootport_aer_stats_incr(struct pci_dev *pdev,
 }
 
 static void __aer_print_error(struct pci_dev *dev,
-			      struct aer_err_info *info)
+			      struct aer_err_info *info,
+			      const char *level)
 {
 	const char **strings;
 	unsigned long status = info->status & ~info->mask;
-	const char *level, *errmsg;
+	const char *errmsg;
 	int i;
 
-	if (info->severity == AER_CORRECTABLE) {
+	if (info->severity == AER_CORRECTABLE)
 		strings = aer_correctable_error_string;
-		level = KERN_WARNING;
-	} else {
+	else
 		strings = aer_uncorrectable_error_string;
-		level = KERN_ERR;
-	}
 
 	for_each_set_bit(i, &status, 32) {
 		errmsg = strings[i];
@@ -696,11 +694,11 @@ static void __aer_print_error(struct pci_dev *dev,
 	pci_dev_aer_stats_incr(dev, info);
 }
 
-void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
+void aer_print_error(struct pci_dev *dev, struct aer_err_info *info,
+		     const char *level)
 {
 	int layer, agent;
 	int id = pci_dev_id(dev);
-	const char *level;
 
 	if (!info->status) {
 		pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
@@ -711,8 +709,6 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 	layer = AER_GET_LAYER_ERROR(info->severity, info->status);
 	agent = AER_GET_AGENT(info->severity, info->status);
 
-	level = (info->severity == AER_CORRECTABLE) ? KERN_WARNING : KERN_ERR;
-
 	aer_printk(level, dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
 		   aer_error_severity_string[info->severity],
 		   aer_error_layer[layer], aer_agent_string[agent]);
@@ -720,7 +716,7 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 	aer_printk(level, dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
 		   dev->vendor, dev->device, info->status, info->mask);
 
-	__aer_print_error(dev, info);
+	__aer_print_error(dev, info, level);
 
 	if (info->tlp_header_valid)
 		pcie_print_tlp_log(dev, &info->tlp, dev_fmt("  "));
@@ -765,15 +761,18 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 {
 	int layer, agent, tlp_header_valid = 0;
 	u32 status, mask;
+	const char *level;
 	struct aer_err_info info;
 
 	if (aer_severity == AER_CORRECTABLE) {
 		status = aer->cor_status;
 		mask = aer->cor_mask;
+		level = KERN_WARNING;
 	} else {
 		status = aer->uncor_status;
 		mask = aer->uncor_mask;
 		tlp_header_valid = status & AER_LOG_TLP_MASKS;
+		level = KERN_ERR;
 	}
 
 	layer = AER_GET_LAYER_ERROR(aer_severity, status);
@@ -786,7 +785,7 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 	info.first_error = PCI_ERR_CAP_FEP(aer->cap_control);
 
 	pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
-	__aer_print_error(dev, &info);
+	__aer_print_error(dev, &info, level);
 	pci_err(dev, "aer_layer=%s, aer_agent=%s\n",
 		aer_error_layer[layer], aer_agent_string[agent]);
 
@@ -1257,14 +1256,15 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
 	return 1;
 }
 
-static inline void aer_process_err_devices(struct aer_err_info *e_info)
+static inline void aer_process_err_devices(struct aer_err_info *e_info,
+					   const char *level)
 {
 	int i;
 
 	/* Report all before handle them, not to lost records by reset etc. */
 	for (i = 0; i < e_info->error_dev_num && e_info->dev[i]; i++) {
 		if (aer_get_device_error_info(e_info->dev[i], e_info))
-			aer_print_error(e_info->dev[i], e_info);
+			aer_print_error(e_info->dev[i], e_info, level);
 	}
 	for (i = 0; i < e_info->error_dev_num && e_info->dev[i]; i++) {
 		if (aer_get_device_error_info(e_info->dev[i], e_info))
@@ -1300,7 +1300,7 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
 		aer_print_port_info(pdev, &e_info);
 
 		if (find_source_device(pdev, &e_info))
-			aer_process_err_devices(&e_info);
+			aer_process_err_devices(&e_info, KERN_WARNING);
 	}
 
 	if (e_src->status & PCI_ERR_ROOT_UNCOR_RCV) {
@@ -1319,7 +1319,7 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
 		aer_print_port_info(pdev, &e_info);
 
 		if (find_source_device(pdev, &e_info))
-			aer_process_err_devices(&e_info);
+			aer_process_err_devices(&e_info, KERN_ERR);
 	}
 }
 
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index df42f15c9829..9e4c9ac737a7 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -289,7 +289,7 @@ void dpc_process_error(struct pci_dev *pdev)
 	else if (reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_UNCOR &&
 		 dpc_get_aer_uncorrect_severity(pdev, &info) &&
 		 aer_get_device_error_info(pdev, &info)) {
-		aer_print_error(pdev, &info);
+		aer_print_error(pdev, &info, KERN_ERR);
 		pci_aer_clear_nonfatal_status(pdev);
 		pci_aer_clear_fatal_status(pdev);
 	}
-- 
2.49.0.395.g12beb8f557-goog


