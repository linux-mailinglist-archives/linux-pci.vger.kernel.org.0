Return-Path: <linux-pci+bounces-24202-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 842E7A6A130
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 09:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED9A23B2B8C
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 08:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65700220685;
	Thu, 20 Mar 2025 08:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dcRNJb00"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EBE21421F
	for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 08:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742458877; cv=none; b=DsZ9VW0dbjWKc1xrkh/bxsBtn8VnZVWWlcSC+NGp0aDd+HO2V9zGWOeHoQd2GsMLgIjXwrMGURfRS5dqH3xYo2yD4F/7Fz57TDt20IPSrdHYXspNPPhjISmPFecm96tTjm4s5ogkJ0mwqipS4RJXYkWpcjSKhHl3uJJoggkw0P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742458877; c=relaxed/simple;
	bh=a4uz5nvJYXzRCyAM1Ru3R79vGOGjnMwNXODawHU6BvM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZfIzolbwAPcHq0xqDJ/tFSYFuTgPDA7wWBOPIEC/l0qcsgHdirJnkTTNT70KzZtFyb4+ngZWPPNtCNR5bSM2KFEqxRR/KZ1cS13CZu79II174yKEZ2tlkC9iyseY6g1VU1K2j7xQURBiDFaKDFPCIrFS1FzYhkfjC6qxk0xkWUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dcRNJb00; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-2ad8e353167so329741fac.2
        for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 01:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742458874; x=1743063674; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yb1PJufKWZ+3n/aiJ7qR17De5J9CKZZElC89yBN5d1A=;
        b=dcRNJb00eMiOr7TiJtVi667rkwQ+PWzDXX3ojd7BBtbrRq9iCsscQBBD+HhBQm4c07
         Puq7E4rJ/1o0TCl3qELqKQ63FmmZtNGD1Y5jvpaYgb0ayZPAloXN1fSQ0bgQQdxEDWQY
         h6DnijHWdR8PxyiQB3VbCsd/oiOm8gfzUBdhOpymjmxw09+2fZG6CCN4HQ1p2K15N/Gu
         V3dFrJ6RkFNnHUXTdZFIM3m+lR16DFi2YHX7UV4xmsWbvyS15RUtfXt0zWNGy3cxHnDp
         7cQ8VntIKM6RtcUt23aBOYJ/rFzPvLkgW/JnB0VeYWjSTRfI9QpwVoqNa66XtUUjjarY
         UPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742458874; x=1743063674;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yb1PJufKWZ+3n/aiJ7qR17De5J9CKZZElC89yBN5d1A=;
        b=JMFfoXxLpdKotZOFuzt1hYe4Nz+t5bg8tKoDWEglKzySTSYSTRB1tbsYhpAEDw0Iry
         0thOhBl46uFcYGybjIh2xTPvJlfrD6EkJEgwru86/X0pRypDcv+c+oBbhxb9mIpPD0EY
         FsmOYjNaGFL6O/vy7zUF1Ct+JOKYuyd1wgjSgLZSkCiB8gFpu4c13CD5OkwsU0psNMLu
         CRGCqQOOpblt2DLoQXqBkpr3Vo5Y0IluDk53ZiULdMGvUHGUAy7WQaUYGhHWtwtMAqzw
         1J2UK3U9ZMtaSoN9g6w2pUh/uoX29rYPCe6EFwaZk3sPufCvHXAGV2BfW4NNEIf02XnF
         VtKg==
X-Gm-Message-State: AOJu0Yws2QN/nGuaqYhco+hNn0gsZhWAb9upGLIWNkel4T96I/1uVRGg
	686wb3pC0Kkt990MXZ4yXnc6SQLActsrwSt/ojucPTauJlBQriqazgQjaFRjecVweCDU5TDD70f
	TOg==
X-Google-Smtp-Source: AGHT+IGqBIB1coIx3i+LtFcxPSxPXyGrohrfMMxIu/CP4LqDjDFslrrOF8UFes1LfRQE9vrlOcnXbLYgBbk=
X-Received: from oabhq14.prod.google.com ([2002:a05:6870:9b0e:b0:277:f256:18a2])
 (user=pandoh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:b006:b0:28c:8476:dd76
 with SMTP id 586e51a60fabf-2c7458b8914mr4840501fac.29.1742458873841; Thu, 20
 Mar 2025 01:21:13 -0700 (PDT)
Date: Thu, 20 Mar 2025 01:20:53 -0700
In-Reply-To: <20250320082057.622983-1-pandoh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250320082057.622983-1-pandoh@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250320082057.622983-4-pandoh@google.com>
Subject: [PATCH v4 3/7] PCI/AER: Move AER stat collection out of __aer_print_error()
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

Decouple stat collection from internal AER print functions. Prerequisite
to add ratelimits to logs while leaving stats unaffected. Also simplifies
control flow as stats collection is no longer buried in nested functions.

AERs from ghes or cxl drivers are a minor exception. Stat collection occurs
in pci_print_aer(), an external interface, as that is where aer_err_info
is populated.

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
2.49.0.rc1.451.g8f38331e32-goog


