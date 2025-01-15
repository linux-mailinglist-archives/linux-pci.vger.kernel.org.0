Return-Path: <linux-pci+bounces-19840-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA8FA11B2E
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 08:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0E20168B4E
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 07:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AF922F85A;
	Wed, 15 Jan 2025 07:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uSF2vEA7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1210222F84F
	for <linux-pci@vger.kernel.org>; Wed, 15 Jan 2025 07:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736927010; cv=none; b=Ft5XVYEN5y/dn1rghuw/Sos+ULBDt0b8x68bvquHIaSENtnZmwxFf6uVkjhUroy/rN3oZKbeRNy3UOtgYDb9E5xiClQDs7DUt1kExktfWhwy8szRNlCFrXptvkqVqYJM/k9rfueCv71Tr6QUOCrpPxE+pQxx4JLlUjoOkyWGwJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736927010; c=relaxed/simple;
	bh=AaRwseQYUhklbNnb1otoMO+0fpMTsbExqcehBF0JpnU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qAe3PvFU8gtXpJKeZY3pttbrQahqurNGI0siJ5lmBUjxupAKFEvsoyIX9nhDetdUwhnY6zMGBxBBs4/eVfMSx/ytp1247/+TGRjjHV2EYtGV0lp7061kPp7FpQM8NzzseKEs4XvQA+nB2N1DlGRYN7p2svSoq7Hv0ixXAQcNED4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uSF2vEA7; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2166f9f52fbso199476275ad.2
        for <linux-pci@vger.kernel.org>; Tue, 14 Jan 2025 23:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736927008; x=1737531808; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=T2hkO9ecKAiOgwd/fwTHBr3GM0JTbJkNKW0Qdn18gN4=;
        b=uSF2vEA71xxL0Ot32ZNg3kKQfrzjuG0sj9Mwvkqn1BfrGsS2MCdWFyNL6k0Z8uZKEI
         GGQJATpSgFf2I5/oujZk8OWB7AUXRJeWTZohy/1p2ae5zYycGpalePgf4STB1Of+Wg3j
         mvPMJ5MZ8jmAnToy0CNX3a96L7TfntEE10ii2ybuHhodgbq26Ru+MM+ZzPc91vLhyrE5
         qwbbSQTDXJXNOPIiRdN7T3kUdUoupC4hJd6hv7pt6GmXV8YxhgSdnYdRalGy60h/sIZR
         2qIKB+XVojL0vhsT3jesrsiu29qMQXVVE4j5zON6mvxRE9Q1NDWOVFt14lGRKFlzh8v2
         agmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736927008; x=1737531808;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T2hkO9ecKAiOgwd/fwTHBr3GM0JTbJkNKW0Qdn18gN4=;
        b=teLodKMmAfL2zJfU9mcDiPRKlrBhgFoWq0zNH+mFmQqs3Xzm0cav0DfeEXrJjI6+g/
         5fW8BODTE4HQ+Up+zs3Kx9HXmJLQSyAJEsbFdmGTynz9bSgZ7nj8K9M1cJpKQU+8oS3V
         u5OMH5dE4tKgl5jtnEE6Oz2gMJuEqkyrXuFwVrLPrOlM6LCbVxk9AAFgYCZNbhIyDweN
         HxFs1bvDjoGImOsMDFNxEiuZszPuLY1aAdkZg1XSENYJ+MDGLoxgVLIxdlTAuyCfhBmF
         D+KT9rSutBQaoc6aP6VXTVFiYrtWfGiUpAolOrhPdVAThJIGMdhS/V+Gigj4zqKBd+y/
         uaBw==
X-Gm-Message-State: AOJu0YyvF0CWeho/e9/YlyFcipw4rGJ8+brC2VefojYV0FS52oXnWJva
	xgQSgyE0fa2UqvKhn2FAlZ3SPzcuS5P/qwYg92AXHcxAlNxOeTgTLFjFOlV5/FTIRyjfumKdeW5
	Tyw==
X-Google-Smtp-Source: AGHT+IFAt4fQjhDkxUfvXtP2HxSEVaclOsQHOD9OkFBuZ2ovbOEGtAqj+Q2zKOYXspIa8Ej61/Y9pRlv/OE=
X-Received: from plte6.prod.google.com ([2002:a17:902:7446:b0:215:515c:124e])
 (user=pandoh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d2d2:b0:216:3dc0:c8ab
 with SMTP id d9443c01a7336-21a83f3ee9emr404760155ad.9.1736927008305; Tue, 14
 Jan 2025 23:43:28 -0800 (PST)
Date: Tue, 14 Jan 2025 23:42:57 -0800
In-Reply-To: <20250115074301.3514927-1-pandoh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250115074301.3514927-1-pandoh@google.com>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Message-ID: <20250115074301.3514927-6-pandoh@google.com>
Subject: [PATCH 5/8] PCI/AER: Introduce ratelimit for AER IRQs
From: Jon Pan-Doh <pandoh@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>, 
	Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, 
	Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>, 
	Jon Pan-Doh <pandoh@google.com>
Content-Type: text/plain; charset="UTF-8"

After ratelimiting logs, spammy devices can still slow execution by
continued AER IRQ servicing.

Add higher per-device ratelimits for AER errors to mask out those IRQs.
Set the default rate to 3x default AER ratelimit (30 per 5s).

Tested using aer-inject[1] tool. Injected 32 AER errors. Observed IRQ
masked via lspci and sysfs counters record 31 errors (1 masked).

Before: CEMsk: BadTLP-
After:  CEMsk: BadTLP+

[1] https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer-inject.git

Signed-off-by: Jon Pan-Doh <pandoh@google.com>
---
 Documentation/PCI/pcieaer-howto.rst |  4 +-
 drivers/pci/pcie/aer.c              | 64 +++++++++++++++++++++++++----
 2 files changed, 57 insertions(+), 11 deletions(-)

diff --git a/Documentation/PCI/pcieaer-howto.rst b/Documentation/PCI/pcieaer-howto.rst
index 5546de60f184..d41272504b18 100644
--- a/Documentation/PCI/pcieaer-howto.rst
+++ b/Documentation/PCI/pcieaer-howto.rst
@@ -88,8 +88,8 @@ fields.
 AER Ratelimits
 -------------------------
 
-Error messages are ratelimited per device and error type. This prevents spammy
-devices from flooding the console.
+Errors, both at log and IRQ level, are ratelimited per device and error type.
+This prevents spammy devices from stalling execution.
 
 AER Statistics / Counters
 -------------------------
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 025c50b0f293..1db70ae87f52 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -87,6 +87,8 @@ struct aer_info {
 	u64 rootport_total_nonfatal_errs;
 
 	/* Ratelimits for errors */
+	struct ratelimit_state cor_irq_ratelimit;
+	struct ratelimit_state uncor_irq_ratelimit;
 	struct ratelimit_state cor_log_ratelimit;
 	struct ratelimit_state uncor_log_ratelimit;
 };
@@ -379,6 +381,10 @@ void pci_aer_init(struct pci_dev *dev)
 		return;
 
 	dev->aer_info = kzalloc(sizeof(struct aer_info), GFP_KERNEL);
+	ratelimit_state_init(&dev->aer_info->cor_irq_ratelimit,
+			     DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST*3);
+	ratelimit_state_init(&dev->aer_info->uncor_irq_ratelimit,
+			     DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST*3);
 	ratelimit_state_init(&dev->aer_info->cor_log_ratelimit,
 			     DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST);
 	ratelimit_state_init(&dev->aer_info->uncor_log_ratelimit,
@@ -676,6 +682,39 @@ static void pci_rootport_aer_stats_incr(struct pci_dev *pdev,
 	}
 }
 
+static void mask_reported_error(struct pci_dev *dev, struct aer_err_info *info)
+{
+	const char **strings;
+	const char *errmsg;
+	u16 aer_offset = dev->aer_cap;
+	u16 mask_reg_offset;
+	u32 mask;
+	unsigned long status = info->status;
+	int i;
+
+	if (info->severity == AER_CORRECTABLE) {
+		strings = aer_correctable_error_string;
+		mask_reg_offset = PCI_ERR_COR_MASK;
+	} else {
+		strings = aer_uncorrectable_error_string;
+		mask_reg_offset = PCI_ERR_UNCOR_MASK;
+	}
+
+	pci_read_config_dword(dev, aer_offset + mask_reg_offset, &mask);
+	mask |= status;
+	pci_write_config_dword(dev, aer_offset + mask_reg_offset, mask);
+
+	pci_warn(dev, "%s error(s) masked due to rate-limiting:",
+		 aer_error_severity_string[info->severity]);
+	for_each_set_bit(i, &status, 32) {
+		errmsg = strings[i];
+		if (!errmsg)
+			errmsg = "Unknown Error Bit";
+
+		pci_warn(dev, "   [%2d] %-22s\n", i, errmsg);
+	}
+}
+
 static void __print_tlp_header(struct pci_dev *dev, struct pcie_tlp_log *t)
 {
 	pci_err(dev, "  TLP Header: %08x %08x %08x %08x\n",
@@ -713,7 +752,8 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 	int layer, agent;
 	int id = pci_dev_id(dev);
 	const char *level;
-	struct ratelimit_state *ratelimit;
+	struct ratelimit_state *irq_ratelimit;
+	struct ratelimit_state *log_ratelimit;
 
 	if (!info->status) {
 		pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
@@ -722,14 +762,20 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 	}
 
 	if (info->severity == AER_CORRECTABLE) {
-		ratelimit = &dev->aer_info->cor_log_ratelimit;
+		irq_ratelimit = &dev->aer_info->cor_irq_ratelimit;
+		log_ratelimit = &dev->aer_info->cor_log_ratelimit;
 		level = KERN_WARNING;
 	} else {
-		ratelimit = &dev->aer_info->uncor_log_ratelimit;
+		irq_ratelimit = &dev->aer_info->uncor_irq_ratelimit;
+		log_ratelimit = &dev->aer_info->uncor_log_ratelimit;
 		level = KERN_ERR;
 	}
 
-	if (!__ratelimit(ratelimit))
+	if (!__ratelimit(irq_ratelimit)) {
+		mask_reported_error(dev, info);
+		return;
+	}
+	if (!__ratelimit(log_ratelimit))
 		return;
 
 	layer = AER_GET_LAYER_ERROR(info->severity, info->status);
@@ -776,14 +822,14 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 	int layer, agent, tlp_header_valid = 0;
 	u32 status, mask;
 	struct aer_err_info info;
-	struct ratelimit_state *ratelimit;
+	struct ratelimit_state *log_ratelimit;
 
 	if (aer_severity == AER_CORRECTABLE) {
-		ratelimit = &dev->aer_info->cor_log_ratelimit;
+		log_ratelimit = &dev->aer_info->cor_log_ratelimit;
 		status = aer->cor_status;
 		mask = aer->cor_mask;
 	} else {
-		ratelimit = &dev->aer_info->uncor_log_ratelimit;
+		log_ratelimit = &dev->aer_info->uncor_log_ratelimit;
 		status = aer->uncor_status;
 		mask = aer->uncor_mask;
 		tlp_header_valid = status & AER_LOG_TLP_MASKS;
@@ -799,8 +845,8 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 	info.first_error = PCI_ERR_CAP_FEP(aer->cap_control);
 
 	pci_dev_aer_stats_incr(dev, &info);
-
-	if (!__ratelimit(ratelimit))
+	/* Only ratelimit logs (no IRQ) as AERs reported via GHES/CXL (caller). */
+	if (!__ratelimit(log_ratelimit))
 		return;
 
 	pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
-- 
2.48.0.rc2.279.g1de40edade-goog


