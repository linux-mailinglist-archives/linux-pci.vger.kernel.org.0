Return-Path: <linux-pci+bounces-24075-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB13AA68718
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 09:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D37D4203AD
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 08:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED7B211484;
	Wed, 19 Mar 2025 08:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YZLRoqX7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B678D15A85A
	for <linux-pci@vger.kernel.org>; Wed, 19 Mar 2025 08:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742373674; cv=none; b=F1MxYU0uWtftqD7tEvppYzIbpYiRjwk6umJemn33xoIhv5pwhS5xzdHTjyOEa8ayc3P4ZOi9mU4tAVDiTXFV2QXnPq1aq2I+/cnFSmbKyZqTSwzix5ZC6NvJ0iprhZIh4SlojrJc6GIeEBjMYDjpNuaD8L72uqKxp5VOrLNITOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742373674; c=relaxed/simple;
	bh=8v1Wu/st9YoPC4LuMevzXS+s4VlldbD4VWj4yFviFSk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hemUF1BNDAiBRmZ93duiBYrqBbNLAmJcx6WGyY5A4OkKP4acr7J/r0yGVrBSZ5cxTRx+3AthKulnm+QclDw3ddtVY5yI6WFa5OkTsg9BkuCkE4BDIo89cyIPVDon6QxFNuDKZQRipiUoWCH0snIq+zUd4h0blOylSeuo5lejWZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YZLRoqX7; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff58318acaso11523425a91.0
        for <linux-pci@vger.kernel.org>; Wed, 19 Mar 2025 01:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742373672; x=1742978472; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=i08StNHvG5KNUx/4IydE/l4KY3QQy5TNH3wrC1N9nos=;
        b=YZLRoqX7w/iPYXo+L0/YHf9uQ6x0sr/xOYm/ZpiVWgi5//QbK5ByPpuRq9B9OQMWDt
         GyzNlmdTYrDZEXhrY95bxxliUiVlkkbO9/2R0Wi1ehXjivkPwGcA/3JcA0XFogd3yJw7
         9IePxSowNTAiqNbHUbaFgs92kVv1EFDoH/sxo/cscovnvsqb0xXgojQxAvuog5xPi0IE
         2aoSAP0HDcgiyzu8i1tyuWMRj5szPcBXqKWXSH82SR77Z1cxyEyq6H0c5Qx9E9ctFlNK
         YmiV6iBsgi3y7AO/r/LyhAtxV1MYbfg2nEhmoLp8304PvBsOWDkLo8ah4exN3t9OOegV
         JkuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742373672; x=1742978472;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i08StNHvG5KNUx/4IydE/l4KY3QQy5TNH3wrC1N9nos=;
        b=EdihQEpP6Gzu6ufqo+EQrMkThpqOFmEFYErLs/s3K0KrhV8TJsaVEDuGlwW0YHnrni
         AC4o15A4BX/+0PZ8UI672ork8L0tdMxxgMV9WEJ4nXD2MvB5FUV6nDWffYQj/IygflYw
         YB2YfLorl8snVClnXBaDm3y7DSRfC89J7GjoF1Hxj6+AbH618vH30cCn0pSvo8cfBzA0
         9nwu4QfPQZ7UtGXlukW56XjJjkJWiRJBAFMX00648iY5xfMf/6DjZheaDd36uG+gL7FF
         8uiO6ZsjbI30pIHFR6Ju/1qYuRc2vOdVZb+Kq57F5uUXpz2rdFK3d6MuzctST27gZVfP
         LzYQ==
X-Gm-Message-State: AOJu0YwO15aX/Xth0S6/ZoYG7adJFOThInQon467UTtJuQFcZ+62ObOC
	LcN60ucHSFxFDWe+GlPF0LqApZj+f73PYNvxqPiKp2XknNtjKQcRh+c7+HizvVv6w2jYEapEXSJ
	2Rg==
X-Google-Smtp-Source: AGHT+IH9a0Rp2kbXCzu6xOHT+uEzhNCnn8gfGcW1brCjZ22NIHwtCRsGc3b2sogK9iziISmY9hnQHXAsZt4=
X-Received: from pjwx12.prod.google.com ([2002:a17:90a:c2cc:b0:2fc:2c9c:880])
 (user=pandoh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b02:b0:2ff:5016:7fd2
 with SMTP id 98e67ed59e1d1-301be1f8cc0mr3277154a91.24.1742373671971; Wed, 19
 Mar 2025 01:41:11 -0700 (PDT)
Date: Wed, 19 Mar 2025 01:40:44 -0700
In-Reply-To: <20250319084050.366718-1-pandoh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250319084050.366718-1-pandoh@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250319084050.366718-4-pandoh@google.com>
Subject: [PATCH v3 3/8] PCI/AER: Move AER stat collection out of __aer_print_error()
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

Decouple stat collection from internal AER print functions. AERs from ghes
or cxl drivers have stat collection in pci_print_aer() as that is where
aer_err_info is populated.

Signed-off-by: Jon Pan-Doh <pandoh@google.com>
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
index 7eeaad917134..8e4d4f9326e1 100644
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
2.49.0.rc1.451.g8f38331e32-goog


