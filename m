Return-Path: <linux-pci+bounces-24200-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B1BA6A121
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 09:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED164189EFBB
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 08:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DEE21A44B;
	Thu, 20 Mar 2025 08:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XnrKmE4/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21D2219314
	for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 08:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742458870; cv=none; b=JtAWfpk6FDK/stRcAnvuGgUIux5SUEpy8DUXkQYgO6EKYast0YMY9YFriPAfZsCKHloG4wFfQoqEVwRaHDHVfGfYVB2znMtyTR/sytSq/sGR7fxQ89iqZZS47kMfSkInEQTMKT3Uo/zva5uIvDOQWvxU/qhggkbAUrq4/ZwMN5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742458870; c=relaxed/simple;
	bh=Wnqcl0F3/ZfxfPUMaB8Hnpqd6Ket108uHN/4FFbUqqQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eifIkgvXq2305h2St0A8IafHmD6MF8V1bObmX9idllWWAIfe42kMzwtRMwPrFDj/+crFVKB7lVIUzN1+r2DNW2uTv4cS7SRSK+hhw1x0u5GrGAPKvE60+Q1DVaN+5lLze2zg+BQaanpEATR4BZoPYqciuwoGZiLSXfQZBU2BYbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XnrKmE4/; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-22406ee0243so4991795ad.3
        for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 01:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742458868; x=1743063668; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=w/y130VO+6eQgy1/U5GEb4Ube5y8CNIhxn5Ir6sOIC4=;
        b=XnrKmE4/OrfCJ0PFfXrtOvuoHvpPq5qIK9lOLZUivQ20NmfRimaOw+qkK3YMxObsTQ
         EBaHCaJxSMYPR9RZ/oL8TwJ5P5vpduGEcw33FcxzARnI8qB+aqupocIEnAY+idYS71JN
         eh8/jQpw/hq01yukj8wZr65eH5jj7mDn595EVSnGRV1/MI6JXJhUJvuwWuOnfERyXzx6
         Ip1XGk3dpQVv+D4ExMjDo0FVMGKUpQMlYMowXniN3KU6nOb2Q4nDM02vjO4hxcqTiuls
         bSPQCz4Pi2GlWrwy5U1jNttqiPtDX1f/r9ZGviicNy88F8dWyZ/CiTZ/ZECGOcsf8IGY
         nSKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742458868; x=1743063668;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w/y130VO+6eQgy1/U5GEb4Ube5y8CNIhxn5Ir6sOIC4=;
        b=QRv3zHMipg7Rp5Dtq+dd5VP2TecMgoW9sW2hnjL7OHBVmIvJKa+bJiYGF/L8owLbfk
         atPD/pv1KZbXayeNgD8SSIe2VIUUKXnEx+JaqNYONa6IVRp/Yo3zjnW6ywED9Hyd8yvU
         q8KD1rt4g+B6A2myJzTEbSKkkqMBuCipCV3k+zJunsxPiNfhL4e+D/pKXjwARzMLwWoF
         wPnfH9BXIzhjluSTfMk841UBtRv5iFG6sTlGe0AaQufhZVQuJgNvlYRRJqZJFX1SltvX
         xbmECNjSgjaA3fkIHx15Y2FZTvwzgy8IuxQbTKHdlvlqDmiFKhGe2JcGlsieMKQJn8BH
         pePw==
X-Gm-Message-State: AOJu0YwvNTz7RwkTWwzjEdMbdm1HX5d/2WEujwOVYplshrbaHNzdUbj/
	tfmcvvPuLvuZkQdRs1bnhLJePn7H0k8LAjKg4sPFlDPp+AgTG3zEvPFlgzFSUtJe8Av7Ma/0gXk
	vGA==
X-Google-Smtp-Source: AGHT+IFIqIAKMR5aHIcKOBKRUrcSoQrhOTNGjZmpMVPBERrdWfmWug8N2V9twYmxR51z2p680cQ45ofDkqY=
X-Received: from pfld16.prod.google.com ([2002:a05:6a00:1990:b0:730:5761:84af])
 (user=pandoh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:993:b0:730:9502:d564
 with SMTP id d2e1a72fcca58-7376d62c89emr9398974b3a.14.1742458868013; Thu, 20
 Mar 2025 01:21:08 -0700 (PDT)
Date: Thu, 20 Mar 2025 01:20:51 -0700
In-Reply-To: <20250320082057.622983-1-pandoh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250320082057.622983-1-pandoh@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250320082057.622983-2-pandoh@google.com>
Subject: [PATCH v4 1/7] PCI/AER: Check log level once and propagate down
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
2.49.0.rc1.451.g8f38331e32-goog


