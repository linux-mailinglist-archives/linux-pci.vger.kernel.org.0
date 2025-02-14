Return-Path: <linux-pci+bounces-21413-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE57EA354C7
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 03:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ED011891135
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 02:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577BF139D0A;
	Fri, 14 Feb 2025 02:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L4eyeltH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B40C2EF
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 02:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739500574; cv=none; b=nCIyMwcfuhNSsuiHGTxYZxRnslf2E3yL56nFx96mGTqSsLAn56SsFZppc2N5XMNXJ1go/r+aNIGO7Zcwwbuqe+hQU6Ap8MBvNBUKMqK4Mj328L7LIuq/iac99XAbH2XVZ4q6xOcWt5kInT+UA3Fd0jWaZQ+eXIf+bfn3hzxtBas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739500574; c=relaxed/simple;
	bh=o0rJn9m6wmHGOu6s8YJwfI8S6S7/Wy5vHh7NM6AR5pE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D5d1dsHAoWUVJTM7siy2Vc0CJucVD+VqFABMUsf4d9CY2y5LHHty30CFDiwSbMIbdUMPLPhuyyCWDYwKgRl0J8Lp+FYDKJIGzEH3zH8EXotd2lcoDbpEvAZlhgP5Ozi67bAMaE+Gy8HIo5BYnOwkZK3JA3MhoG92s8JZdGck1p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L4eyeltH; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6fb33e7a5dfso13974787b3.2
        for <linux-pci@vger.kernel.org>; Thu, 13 Feb 2025 18:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739500571; x=1740105371; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FXwDFR7jTCsSat48d4MGYeivPqa/JH9YFjZem/QbpTY=;
        b=L4eyeltHDtHQgcUE2ViFKC5tPlo37zZ+b9v7LckpCUI55sAaYV4cuJEaDs/atJOtlm
         xXVja4q8V8dTedWSUrgavPLvTXwO0Pvc9REv10BD5c62iBRuSdMwQ4PGZuzL7MBzLATx
         fi3GtaHu8qo6VgVtUXtiztBa1ASzvVHkbC6olclsWRRhP6UJ2rP23UZttZAVV67xRRdP
         /U7nIlzO/wLhGZ1WWeG37zk4nzwGWzYYnRqRAGYFj7BuxZJPLZHn2zFs/3kDdtZ7N++Z
         CiLRoA2UcsNzrNG1pyhxsLIhlpFDEntp67bW0yZGmYekksOTERwJUqCDP4EZOKfSuqnh
         naEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739500571; x=1740105371;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FXwDFR7jTCsSat48d4MGYeivPqa/JH9YFjZem/QbpTY=;
        b=obkbOP4rxbv1kX1woZaRLw7mjcl7zZYavhZ/vL/0HJnya5PRmntabV/crAYm3zINm4
         3zO8YkCWxgko49Ck8ExlJnsDbMRV5ttfN7nsuaHCVRqWaOSrOuHbrTC3JzaIbu+fBfp7
         P3LjdnDRvGZ0HHa69HO8GsHhpId4IjNOUMGfsWKDwIOPTwNBQKYF3oMHYAGBx3t+YoWn
         eDZjXpSZ2x+17aQz46q1kLkiJtIMR17w7Q0DaDPznKXfiIGVcdZW1pFLXYoZoFCnCG2R
         hvQbthFeBwxx1YiljOo4APO4zGABtNRK1VaptVuHLW2nVuJgzRT5IMTsYBF+7xGylaYn
         Y1fQ==
X-Gm-Message-State: AOJu0YzQZV8IHjRC4QVoq/lHOtGmBV2i5FG1sjRSqWf0MfQ85FbQSOdv
	78OYe3tV/c1E1TmZtWYSTnXT/lOvpNo1pSH8KBEYxs6F1uFjKo5/tE4u/+O/ivkuYNqi63MmkgF
	uuw==
X-Google-Smtp-Source: AGHT+IH2JpSRr3nyqkfZ/2g1NWVxxN8SFQ5P14LZP5nzNWTlBWD3xZrErltPfU92fyp5+VX7v7C6eKkgaMs=
X-Received: from ywbkg10.prod.google.com ([2002:a05:690c:760a:b0:6f9:7647:ac85])
 (user=pandoh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690c:3703:b0:6f9:82ae:5988
 with SMTP id 00721157ae682-6fb32c9ac38mr51565317b3.22.1739500571618; Thu, 13
 Feb 2025 18:36:11 -0800 (PST)
Date: Thu, 13 Feb 2025 18:35:38 -0800
In-Reply-To: <20250214023543.992372-1-pandoh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250214023543.992372-1-pandoh@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250214023543.992372-4-pandoh@google.com>
Subject: [PATCH v2 3/8] PCI/AER: Move AER stat collection out of __aer_print_error
From: Jon Pan-Doh <pandoh@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>, 
	Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, 
	Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>, 
	"=?UTF-8?q?Ilpo=20J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, 
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Jon Pan-Doh <pandoh@google.com>
Content-Type: text/plain; charset="UTF-8"

Decouple stat collection from internal AER print functions. AERs from ghes
or cxl drivers have stat collection in pci_print_aer as that is where
aer_err_info is populated.

Tested using aer-inject[1]. AER sysfs counters still updated correctly.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer-inject.git

Signed-off-by: Jon Pan-Doh <pandoh@google.com>
---
 drivers/pci/pci.h      |  1 +
 drivers/pci/pcie/aer.c | 10 ++++++----
 drivers/pci/pcie/dpc.c |  1 +
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 8cb816ee5388..26104aee06c0 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -550,6 +550,7 @@ struct aer_err_info {
 };
 
 int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info);
+void pci_dev_aer_stats_incr(struct pci_dev *pdev, struct aer_err_info *info);
 void aer_print_error(struct pci_dev *dev, struct aer_err_info *info, const char *level);
 
 int pcie_read_tlp_log(struct pci_dev *dev, int where, int where2,
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index f1fdaa052cf6..d6edb95d468f 100644
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
@@ -772,6 +770,8 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 	info.mask = mask;
 	info.first_error = PCI_ERR_CAP_FEP(aer->cap_control);
 
+	pci_dev_aer_stats_incr(dev, &info);
+
 	aer_printk(level, dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
 	__aer_print_error(dev, &info, level);
 	aer_printk(level, dev, "aer_layer=%s, aer_agent=%s\n",
@@ -1250,8 +1250,10 @@ static inline void aer_process_err_devices(struct aer_err_info *e_info,
 
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
index f06fad95f2eb..a85ea76b4dea 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -287,6 +287,7 @@ void dpc_process_error(struct pci_dev *pdev)
 	else if (reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_UNCOR &&
 		 dpc_get_aer_uncorrect_severity(pdev, &info) &&
 		 aer_get_device_error_info(pdev, &info)) {
+		pci_dev_aer_stats_incr(pdev, &info);
 		aer_print_error(pdev, &info, KERN_ERR);
 		pci_aer_clear_nonfatal_status(pdev);
 		pci_aer_clear_fatal_status(pdev);
-- 
2.48.1.601.g30ceb7b040-goog


