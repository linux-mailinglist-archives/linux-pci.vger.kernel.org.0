Return-Path: <linux-pci+bounces-32744-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A95B0E11B
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 17:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 690B41C24B53
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 15:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB7B279DC3;
	Tue, 22 Jul 2025 15:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cvwZcSnG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D2A1422DD
	for <linux-pci@vger.kernel.org>; Tue, 22 Jul 2025 15:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753199970; cv=none; b=blTWK6g7wWLGc2JXpNXgdvWkfCLpIRdHuEJxzTprR7AhRkF3B7n6wpE2/xu9IUpEEK34D8VfkyQblOFl3uA3FKNcKg5vyW7WbND5oMfShL0evE+ve1qFHLn/5wI525VjB4Ax2LO/vGGzGEx1v9O44LttNe64Nwvsl2T91SZBSV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753199970; c=relaxed/simple;
	bh=mWtDnSQCYeZL9dkcSRR9bvLD/h8VqK6lFPSfMF6XW0g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uusQlayw6+W0ah3ql+qsv2uVdvt0w1RsUpZ8qEd2lVxn5wLcwG8MWLzqPwB8O8mv0C9H4WKcMERZnVp1j3ZmKpy++m99sK+Xel9GqBPM7ITsoQD0BzhadjggTtjmon+BbhjMHcND2z8U2s88dbPu83PIkoRqJLnbEEuGh+eCYvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cvwZcSnG; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3122368d82bso7544484a91.0
        for <linux-pci@vger.kernel.org>; Tue, 22 Jul 2025 08:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753199968; x=1753804768; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4oY2UXluwDgBDqqMPrNv9m0VXP+oX1YkjXphURYGppU=;
        b=cvwZcSnGHAKSIgRb2A/xktlKEuOSeO/ObaF2rWsIYKFFS0KVvHpv0XPsd4hBDj9Etm
         y7X1gJ1k6xyuXR5W/fawqyrze5IKoina5G6LtQdBYIbejQ4FcQykh/5wfE8eIzwUntGt
         rXApjljkRZTPPTX7MJY/K2YWKalYFgc4Ec5EPkPxtMJJLGMq0LD+b1B1LZdoufaK3MgT
         q4oHrOEshefbP+hOmGWyszz9FOGxkyInaTOlKlnSNTUBODb4OTuyx3Ud/SLA9PaPX2WQ
         sw3jj+I3vTymYPj5CKMReuQjBgUOgrBQt0nOLHUHf7KtBzQ0jSbL4NBkkgUJmHOoqgYi
         IpYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753199968; x=1753804768;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4oY2UXluwDgBDqqMPrNv9m0VXP+oX1YkjXphURYGppU=;
        b=RZ48MZHtOsa8iyjq/iJqjgrIOHOVMoa+GuTIUooFrmfFYkQN47z4XawzF0Nlqp3N29
         70uqIxAfaOTh5e4VrpLW4+xpymplHA48F0If9A0SwnZPbTHxFQ1URU/pNY0bdBAGK59f
         m2TBulNhLo9o+fNp50lCAUJL4qV13goG0ltkjxybE3lmI8zXdqTrkGRuTBeMi6WQPtZr
         th31Zt1ZqFNKa6edXdKOI6CzB6XD6s9wYR9Uc44E33FMXS8ftke53lR1dAcCaiD43KvE
         vi4kdJvNQPf7d3qRc5xZRCWnPqXmutiPDrNezOoWGT0mdux0/eHD+mWtnx4bMkRSJeW8
         h7UQ==
X-Gm-Message-State: AOJu0YzWIZUNI0VkGFm+UvogFnhYcmq1ZW7AWJULGlKJ6biA9whf4RVU
	uACJDi/sj9B0RQi/gz7fGy5la5tI+Xxed+OFFAZg21fchFPQyg/gQmMLw+uB9IlU7uvO8QDEubS
	tmhtqeA==
X-Google-Smtp-Source: AGHT+IGXIEboSCl5JOdW4SOZCVdMakwem47+DmnLMKEqKMH0xsCnQLIFE6gaGQH3eT0KMX+GNZTKOU/lj8o=
X-Received: from pjbtc15.prod.google.com ([2002:a17:90b:540f:b0:31c:2fe4:33b4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:35c7:b0:311:fde5:c4b6
 with SMTP id 98e67ed59e1d1-31c9f3efe45mr36227310a91.6.1753199968692; Tue, 22
 Jul 2025 08:59:28 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 22 Jul 2025 08:59:26 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250722155926.352248-1-seanjc@google.com>
Subject: [PATCH v2] PCI: Support Immediate Readiness on devices without PM capabilities
From: Sean Christopherson <seanjc@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Vipin Sharma <vipinsh@google.com>, 
	Aaron Lewis <aaronlewis@google.com>, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Query support for Immediate Readiness irrespective of whether or not the
device supports PM capabilities, as nothing in the PCIe spec suggests that
Immediate Readiness is in any way dependent on PM functionality.

Fixes: d6112f8def51 ("PCI: Add support for Immediate Readiness")
Cc: David Matlack <dmatlack@google.com>
Cc: Vipin Sharma <vipinsh@google.com>
Cc: Aaron Lewis <aaronlewis@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---

v2: Move logic to pci_init_capabilities() instead of piggybacking the
    PM initialization code. [Vipin, Bjorn]

v1 [RFC]:  https://lore.kernel.org/all/20250624171637.485616-1-seanjc@google.com

 drivers/pci/pci.c   |  4 ----
 drivers/pci/probe.c | 10 ++++++++++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 9e42090fb108..4a1ba5c017cd 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3205,7 +3205,6 @@ void pci_pm_power_up_and_verify_state(struct pci_dev *pci_dev)
 void pci_pm_init(struct pci_dev *dev)
 {
 	int pm;
-	u16 status;
 	u16 pmc;
 
 	device_enable_async_suspend(&dev->dev);
@@ -3266,9 +3265,6 @@ void pci_pm_init(struct pci_dev *dev)
 		pci_pme_active(dev, false);
 	}
 
-	pci_read_config_word(dev, PCI_STATUS, &status);
-	if (status & PCI_STATUS_IMM_READY)
-		dev->imm_ready = 1;
 poweron:
 	pci_pm_power_up_and_verify_state(dev);
 	pm_runtime_forbid(&dev->dev);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 4b8693ec9e4c..d33b8af37247 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2595,6 +2595,15 @@ void pcie_report_downtraining(struct pci_dev *dev)
 	__pcie_print_link_status(dev, false);
 }
 
+static void pci_imm_ready_init(struct pci_dev *dev)
+{
+	u16 status;
+
+	pci_read_config_word(dev, PCI_STATUS, &status);
+	if (status & PCI_STATUS_IMM_READY)
+		dev->imm_ready = 1;
+}
+
 static void pci_init_capabilities(struct pci_dev *dev)
 {
 	pci_ea_init(dev);		/* Enhanced Allocation */
@@ -2604,6 +2613,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	/* Buffers for saving PCIe and PCI-X capabilities */
 	pci_allocate_cap_save_buffers(dev);
 
+	pci_imm_ready_init(dev);	/* Immediate Ready */
 	pci_pm_init(dev);		/* Power Management */
 	pci_vpd_init(dev);		/* Vital Product Data */
 	pci_configure_ari(dev);		/* Alternative Routing-ID Forwarding */

base-commit: 89be9a83ccf1f88522317ce02f854f30d6115c41
-- 
2.50.0.727.gbf7dc18ff4-goog


