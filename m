Return-Path: <linux-pci+bounces-8716-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A349066A2
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 10:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 243A6B24833
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 08:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292BB13D52C;
	Thu, 13 Jun 2024 08:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTQMvkIp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7DC13E3F4;
	Thu, 13 Jun 2024 08:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718267096; cv=none; b=gRbpLbGwfmmoS32itB+d1L5N10bPG4HKaeFm1AKBxpmfiilXu9o7RpVC5jQEg7sSaExKsYfwMlYeyq1U6lkYdB6lTQ203EpOhpr0U64OaSJkAFvnEm1wQV4Rh/y75LTpQi5rWjY9eiiu6nnm34XDbPRk56dk+mwj7L/sQSO8iKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718267096; c=relaxed/simple;
	bh=x2UOnZVpw5W6JMJEDnZM+FeWtuTLMmgaXmPFsBI9q/A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WjrOCAXxTJaBJsOJfnvY/mDG0+RNVhBnh8oXdo8e74IbPiDDRmy9bM1BLk0zv+PPQsKppbromlxXEU1bRA6bG+LOD31f5tH9YofJvS8s6S/Kx87T7EfzLxLDK++lmj6BIarCl1sYkmlc/4HTY89n95I5FsTEDeR70mCa1f4Pzb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZTQMvkIp; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-35f1c209893so874705f8f.2;
        Thu, 13 Jun 2024 01:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718267092; x=1718871892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tAEMR4VJ1zjdBk5zvtR3Vo5e9vJ3KQrS8U0kuWsRUbE=;
        b=ZTQMvkIp7P32lSu2Z118klmmVxS0kEOG8SMcJoumWS9wnV3XaiVMsOn88KMGP5UEmm
         nizt5E7ht1JrCqcZjoiUj4hVoXCnSqbq/VbsNO0ZUdr0/KZvHfcBzzIdKcb3w+yvRiKA
         ZFksF3qn0XCb9g+NU/jF85Uaxqg0iATgXWNdci28n5lRu69ARnkYyUGwYRfk1zD3Jw5+
         9/0Sgm/SdLT1kx8RW6tiki2dXDU63bSwuLanROzNzNVim8WNoB4jIE7omgAmxUKrMpQS
         LLOr+02crKVZ2F7bn+1qgNmcqXGnvm7KRWdd2b9be1ieC51WAamqT/p/4zRiCvtsaaFH
         eWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718267092; x=1718871892;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tAEMR4VJ1zjdBk5zvtR3Vo5e9vJ3KQrS8U0kuWsRUbE=;
        b=fA1od3+e7HgOR6hSqllEJk8w1nwOYbv4o4Z0TKhX9Nz8pTzU/QWiiaqsw7i6CBOkLF
         XZIjmHAtuKXj+EA/m/PIRct9ayiSJxslfAP+HUeyAK/AI4qTLR+dvYxVF+Sp7obaRDRn
         IlYTBBFtyfqWueuE874k7mNh6r5I6fnvi/B3eODd/G6qsps7034/M9H/MRrGCt4mmTuV
         XRuyy6dr86o+GXfoGPK4hL67yfP/H6kXRyINlc9YUGLNultlKeGEncKk8cd3v4niBr1c
         MMWmuiauD0tyoPsCBUSteWpJxAH8IW2cyXcKPypCjEcPrdr2x8h7j4LtmdofSaD/doyv
         trag==
X-Forwarded-Encrypted: i=1; AJvYcCWiuU/WG1BtmJ85p606tYHA6YHd/kuCnWEt/ETraVgJhGJEnYTC8oa6Oa0QI5VT2fQ5RLjk0RoAcWxYsOfP2yQNNz9l3+62NUhbjKvt
X-Gm-Message-State: AOJu0YwPKT6OZyRgjRctW0DmcW6Ept9m0KucDZFHyulL806Hu00rVaMP
	IXG2lkId4vlKH1Nh5QwA29TRK2maj2ex096szFChmVKppO2gCGOEVWh0yDuC
X-Google-Smtp-Source: AGHT+IHRU12lKUJDZ7+uzD6ICezfP1hdb3au7EU3UKrkS4itnPhZuLj9tRikL+iqIxgCyUWkKoKYjg==
X-Received: by 2002:a05:6000:401f:b0:360:6e2f:b77 with SMTP id ffacd0b85a97d-3606e2f0c60mr3835288f8f.55.1718267091850;
        Thu, 13 Jun 2024 01:24:51 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36075093615sm981462f8f.6.2024.06.13.01.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 01:24:51 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI: hotplug: Use atomic_{fetch_}andnot() where appropriate
Date: Thu, 13 Jun 2024 10:24:24 +0200
Message-ID: <20240613082449.197397-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use atomic_{fetch_}andnot(i, v) instead of atomic_{fetch_}and(~i, v).

No functional changes intended.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 drivers/pci/hotplug/pciehp_ctrl.c | 4 ++--
 drivers/pci/hotplug/pciehp_hpc.c  | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index dcdbfcf404dd..7c775d9a6599 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -121,8 +121,8 @@ static void remove_board(struct controller *ctrl, bool safe_removal)
 		msleep(1000);
 
 		/* Ignore link or presence changes caused by power off */
-		atomic_and(~(PCI_EXP_SLTSTA_DLLSC | PCI_EXP_SLTSTA_PDC),
-			   &ctrl->pending_events);
+		atomic_andnot(PCI_EXP_SLTSTA_DLLSC | PCI_EXP_SLTSTA_PDC,
+			      &ctrl->pending_events);
 	}
 
 	pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_OFF,
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index b1d0a1b3917d..6d192f64ea19 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -307,8 +307,8 @@ int pciehp_check_link_status(struct controller *ctrl)
 
 	/* ignore link or presence changes up to this point */
 	if (found)
-		atomic_and(~(PCI_EXP_SLTSTA_DLLSC | PCI_EXP_SLTSTA_PDC),
-			   &ctrl->pending_events);
+		atomic_andnot(PCI_EXP_SLTSTA_DLLSC | PCI_EXP_SLTSTA_PDC,
+			      &ctrl->pending_events);
 
 	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
 	ctrl_dbg(ctrl, "%s: lnk_status = %x\n", __func__, lnk_status);
@@ -568,7 +568,7 @@ static void pciehp_ignore_dpc_link_change(struct controller *ctrl,
 	 * Could be several if DPC triggered multiple times consecutively.
 	 */
 	synchronize_hardirq(irq);
-	atomic_and(~PCI_EXP_SLTSTA_DLLSC, &ctrl->pending_events);
+	atomic_andnot(PCI_EXP_SLTSTA_DLLSC, &ctrl->pending_events);
 	if (pciehp_poll_mode)
 		pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
 					   PCI_EXP_SLTSTA_DLLSC);
@@ -702,7 +702,7 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
 	pci_config_pm_runtime_get(pdev);
 
 	/* rerun pciehp_isr() if the port was inaccessible on interrupt */
-	if (atomic_fetch_and(~RERUN_ISR, &ctrl->pending_events) & RERUN_ISR) {
+	if (atomic_fetch_andnot(RERUN_ISR, &ctrl->pending_events) & RERUN_ISR) {
 		ret = pciehp_isr(irq, dev_id);
 		enable_irq(irq);
 		if (ret != IRQ_WAKE_THREAD)
-- 
2.45.2


