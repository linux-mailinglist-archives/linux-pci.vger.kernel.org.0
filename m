Return-Path: <linux-pci+bounces-24073-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E28CA68716
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 09:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84A8E188DEB3
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 08:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BABA15A85A;
	Wed, 19 Mar 2025 08:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VGHNnbfM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01AD211484
	for <linux-pci@vger.kernel.org>; Wed, 19 Mar 2025 08:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742373667; cv=none; b=e2JvJ6TcwRh8zB0AQjuJHSiSpq+u39PkAd1qTtMTwYwekjS5VLTRnI3bKaOE9e5jGPTMifoBkYmPgocJBK7U9xusLqQV/HNJOB6QS25jdyEovZZuQ/gGP3tRjUdpl5S0laQJyiRwSdlEZYsfTFgvQh1pTaFOo1fNDha2NUKkkPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742373667; c=relaxed/simple;
	bh=GOG0WE76MB9baa1tT4VsAXQzEz+JjzrCTqFeJ0u+3X0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MqMoJNKviJRB2ekOGuGahy29/gChvjBWG4ln08+P3WJq7ZOs0BSBhXvdONs1WPkKnEd7440tdHgVgrWQzsrnnL0utWeNJBlrOprbJQTqcIW1qH+j0V/ZjubduZ/RHONOO8gqufXbNzILoq6cL67eTQAdILbcKrD51Af6XsFQSwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VGHNnbfM; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2241aad40f3so108901595ad.1
        for <linux-pci@vger.kernel.org>; Wed, 19 Mar 2025 01:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742373665; x=1742978465; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=74C5WvFIkJT1ruLlg2wdf4z0XA1NMV1P5buaVGuxgpo=;
        b=VGHNnbfMxR0SwNtlflpsW45gDWPRbIacnaZPDG3cWgKp+fr5DpZsSUgkU4LSFIB+kC
         awjiORPiT626VB/ppFvMpnbkODdwv2XVngmc/aXLUSxqF9swPC21pMsqfGxvhQ4ML5wY
         ipVKepb4A7OrX6n5Aj8LboW9XvmXjKJl63LGWB0KmiCW9u1ZzGWi/3FD4GXDv+AB/o/o
         EOLlXG3QNXB/ujUWzuGpF82o5TeqH8zNNvCjud20yBuunJlUU896U/yKiqqe1KYdUY3o
         AE5dQ9KnaQsd/qzNe0Uj/oBSV8NAPAWip7WgUg18r/qRf0n+hks/OsmtZLMWodpvn/uG
         PxIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742373665; x=1742978465;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=74C5WvFIkJT1ruLlg2wdf4z0XA1NMV1P5buaVGuxgpo=;
        b=THSqBTuTs5WZoFJE7HjoF0a9w3iP3+tfQ/M2MwhAt/IZQKJFUcT1tgByWf+rnb7b0B
         rzoGhT6AmRSeuTUbDb72VQvcufAZ/AninkrBDu1as8ezV/4CWFtDf5J1BMoXwRiMm62W
         HAKK0tmDfXk8Wjir6cMGzjL5ZwetX4FJVkIfvqwrJ+lUzd2eAgxc9LE7aolGknysuvFv
         ZeXWzRCpEwbmQc2+cpaujYIUT3oHJdrqgnRp2CpJkVVfcsHJHfLdYes7lhOBJRXCMMin
         MVTGJqIKe7JHceECuIcApCf851/eXHIYxQ+dKZ0X4PFpBWJ5Je/n2d9ALM6GEeWEE3+N
         Yj2Q==
X-Gm-Message-State: AOJu0YzEy9xQz5xtS8/75GtU0pDqzSLFEsAlBJstdfcMleC1L1g/JFsQ
	jfLLeIguk03wjqB4PO3OyAyki1iLKfqWBmUTwQ/gZoVJDgbvrScEw1xlRNgFO00YmZIUm4GOtXr
	wog==
X-Google-Smtp-Source: AGHT+IE7Q8r8bZJCF+ez0ZNtOr5Dliyosd4DiLp7F+KjSCijKS98ZeDQ0Xy+Q8aUOaQm0m32r1vHOnuoi4E=
X-Received: from pllo22.prod.google.com ([2002:a17:902:7796:b0:223:5693:a4e9])
 (user=pandoh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1ce:b0:223:4c09:20b8
 with SMTP id d9443c01a7336-22649c8f3a7mr23464275ad.37.1742373665017; Wed, 19
 Mar 2025 01:41:05 -0700 (PDT)
Date: Wed, 19 Mar 2025 01:40:42 -0700
In-Reply-To: <20250319084050.366718-1-pandoh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250319084050.366718-1-pandoh@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250319084050.366718-2-pandoh@google.com>
Subject: [PATCH v3 1/8] PCI/AER: Check log level once and propagate down
From: Jon Pan-Doh <pandoh@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>, 
	Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, 
	Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>, 
	"=?UTF-8?q?Ilpo=20J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, 
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Terry Bowman <Terry.bowman@amd.com>, 
	Jon Pan-Doh <pandoh@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Karolina Stolarek <karolina.stolarek@oracle.com>

When reporting an AER error, we check its type multiple times
to determine the log level for each message. Do this check only
in the top-level functions (aer_isr_one_error(), pci_print_aer()) and
propagate the result down the call chain.

Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>
Signed-off-by: Jon Pan-Doh <pandoh@google.com>
Reviewed-by: Jon Pan-Doh <pandoh@google.com>
---
 drivers/pci/pci.h      |  2 +-
 drivers/pci/pcie/aer.c | 37 ++++++++++++++++++++-----------------
 drivers/pci/pcie/dpc.c |  2 +-
 3 files changed, 22 insertions(+), 19 deletions(-)

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
index 9cff7069577e..cc9c80cd88f3 100644
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
@@ -1282,6 +1282,7 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
 {
 	struct pci_dev *pdev = rpc->rpd;
 	struct aer_err_info e_info;
+	const char *level;
 
 	pci_rootport_aer_stats_incr(pdev, e_src);
 
@@ -1292,6 +1293,7 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
 	if (e_src->status & PCI_ERR_ROOT_COR_RCV) {
 		e_info.id = ERR_COR_ID(e_src->id);
 		e_info.severity = AER_CORRECTABLE;
+		level = KERN_WARNING;
 
 		if (e_src->status & PCI_ERR_ROOT_MULTI_COR_RCV)
 			e_info.multi_error_valid = 1;
@@ -1300,11 +1302,12 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
 		aer_print_port_info(pdev, &e_info);
 
 		if (find_source_device(pdev, &e_info))
-			aer_process_err_devices(&e_info);
+			aer_process_err_devices(&e_info, level);
 	}
 
 	if (e_src->status & PCI_ERR_ROOT_UNCOR_RCV) {
 		e_info.id = ERR_UNCOR_ID(e_src->id);
+		level = KERN_ERR;
 
 		if (e_src->status & PCI_ERR_ROOT_FATAL_RCV)
 			e_info.severity = AER_FATAL;
@@ -1319,7 +1322,7 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
 		aer_print_port_info(pdev, &e_info);
 
 		if (find_source_device(pdev, &e_info))
-			aer_process_err_devices(&e_info);
+			aer_process_err_devices(&e_info, level);
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
2.49.0.rc1.451.g8f38331e32-goog


