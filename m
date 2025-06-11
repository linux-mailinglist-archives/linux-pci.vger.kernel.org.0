Return-Path: <linux-pci+bounces-29384-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2FFAD4729
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 02:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E0283A8587
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 00:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1254184E;
	Wed, 11 Jun 2025 00:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="AWF4qIYT"
X-Original-To: linux-pci@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743B8191;
	Wed, 11 Jun 2025 00:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749600355; cv=none; b=qiSiMydSP26O5tqoftRezgQieTamk5SXeLcj2nsGp7NMj831kNPLZtvgOiqcDGPBC3MgEt2LAv65Ckiu89Lj2nS6ByUjQ4dFAwXfhcDBSJP6p033c8TGqdJXQgtDqJA3Yd2b+RQwlZo+ju8wgbVwLIVXzchgoeXxyMmGK3NPRgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749600355; c=relaxed/simple;
	bh=h23fSn7G/BlccmRhZs8w6qcvCx8fyjkrcpSIpTFLPpo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WGE8p5bA52Q8H6hNB+OXBI5wDwcCkzJb6nXQHJoYDNLqnz14rd7vrjYCVwXa3maW55JuZjCRBvJ215lNc4/eik2vYA/xtJ+snOMuibs0hNgDjqBxrKlqqt36irNBLTBtt8EQjXHpAzGSaCRUrb3Ppt123OM+ft/CjqSNuqdv8Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=AWF4qIYT; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from CPC-grwhy-1BDK8.redmond.corp.microsoft.com (unknown [70.37.26.40])
	by linux.microsoft.com (Postfix) with ESMTPSA id 291F92115187;
	Tue, 10 Jun 2025 17:05:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 291F92115187
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1749600354;
	bh=ofdfrfPhwLhQaW6wA1DGE5ye5f3yAqrIG60EWUNb21A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AWF4qIYTv4kZaXQrRxWC+r3yBHVGlg2MrPNlTwYvbkv0yIIQqrzeK3CLDSs1YIduq
	 X5iFxsOFeghsW7LEDAg+IV5z3CpVHIhqZyVz0Pde6bG+XCVrWKb0E4lWEmBxsR9kGV
	 ugq0FryPI14C8B5XPhTEHlusz9Im04zvmqhztS44=
From: grwhyte@linux.microsoft.com
To: linux-pci@vger.kernel.org
Cc: shyamsaini@linux.microsoft.com,
	code@tyhicks.com,
	Okaya@kernel.org,
	bhelgaas@google.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] PCI: Reduce FLR delay to 10ms for MSFT devices
Date: Wed, 11 Jun 2025 00:05:52 +0000
Message-Id: <20250611000552.1989795-3-grwhyte@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250611000552.1989795-1-grwhyte@linux.microsoft.com>
References: <20250611000552.1989795-1-grwhyte@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Graham Whyte <grwhyte@linux.microsoft.com>

Add a new quirk to reduce the delay after a FLR to 10ms
for MSFT devices. These devices complete the FLR well within the default
100ms timeframe and this path can be optimized for VF removal during
runtime repairs and driver updates. These devices do not support immediate
readiness or readiness time reporting

Signed-off-by: Graham Whyte <grwhyte@linux.microsoft.com>
---
 drivers/pci/quirks.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index d7f4ee634263..d704606330bd 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6335,3 +6335,23 @@ static void pci_mask_replay_timer_timeout(struct pci_dev *pdev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9750, pci_mask_replay_timer_timeout);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9755, pci_mask_replay_timer_timeout);
 #endif
+
+#define MICROSOFT_2051_SVC 0xb210
+#define MICROSOFT_2051_MANA_MGMT 0x00b8
+#define MICROSOFT_2051_MANA_MGMT_GFT 0xb290
+
+/*
+ * For devices that don't require the full 100ms sleep
+ * after FLR and do not support immediate readiness or readiness
+ * time reporting
+ */
+static void pci_fixup_pci_flr_10msec(struct pci_dev *pdev)
+{
+	pdev->flr_delay = 10000;
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSOFT, MICROSOFT_2051_SVC,
+	pci_fixup_pci_flr_10msec);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSOFT, MICROSOFT_2051_MANA_MGMT,
+	pci_fixup_pci_flr_10msec);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MICROSOFT, MICROSOFT_2051_MANA_MGMT_GFT,
+	pci_fixup_pci_flr_10msec);
-- 
2.25.1


