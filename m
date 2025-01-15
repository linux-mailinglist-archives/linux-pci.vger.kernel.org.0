Return-Path: <linux-pci+bounces-19839-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC50A11B2D
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 08:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55B51188AC91
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 07:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA5F35944;
	Wed, 15 Jan 2025 07:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UnTXON1x"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8FD22F84F
	for <linux-pci@vger.kernel.org>; Wed, 15 Jan 2025 07:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736927008; cv=none; b=dYXkrxL2My/DVrgZfeMGGlEwBBlYgfwMEIZa8SffFZ50gbRab5XLBd95iLjDZNo+yt3odCe9oyieUGEtfPqeZySTKWQz7fK8uvlLW8Aijck026qQ05uw+BTf6k1RsIPvreLHRuKBKu8R+pt2nf8PKot6PBMMlFQ6SMjNOCKhsB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736927008; c=relaxed/simple;
	bh=IM7yP5EalKHZtTxPHuuFwdgrvigaCtKIa7SSBRfAHuw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AjsoOvTPXJNsJZz2RVbetwP4hfBQXrpgoiCWhZc0sqhGVn1kQVV2G/InXjMuj36mObv2BfMPnbWstv8ZLNO3vEI9HIwnzTSYXmnh82x+tF0+HgHpuaMPMK6x3trbzo5zRGT4Amtv4PFGwFJbYZpJf/kZwhkABcjpuJQgBQVPK1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UnTXON1x; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-216750b679eso81824935ad.1
        for <linux-pci@vger.kernel.org>; Tue, 14 Jan 2025 23:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736927006; x=1737531806; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YLA8BfXAyOsGawEI0SfcV0jVnz1LUpPhnTpff1nkyuI=;
        b=UnTXON1xUP03CZMTf6pY8sZqjxXnh2KYXRbuYvoDJRKxxMa0TU/dPBs7z06v2bm0z0
         PQT8OVKAq79c8prja2L2xU2I/NBtAm9420YzSP+yVQyZs/3vmwSH+rRbgycKtIMyNIxa
         lV9may6YxRuiczHlRM66JIlQIo6cxi7IjjKuYNWveu7wB5wO8+0MCoN/TZjtlafQ7Vuu
         DuV4mWEC4xC0uESLmK0YxrI8ZIFphukALEfJ6TdLxOmticooHaQVJlj1MVl7woGcbtKt
         qhhoInMAJ/uuR+F1HfcZleMlhwFe8TM8Q8oEhrgF2Xo2U7g7f9OlxCkaLe3pl8a7vtME
         JAIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736927006; x=1737531806;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YLA8BfXAyOsGawEI0SfcV0jVnz1LUpPhnTpff1nkyuI=;
        b=k/GyOVo75I7D2ceid1TGZrU0XVxYxOpjB+XqLE0b+zbuQ/cYbl1gea3vhfN5qfAoBH
         ZPVy6QP55bV+pftIb0ZLGjCk69rUnKrx+YQPW1Rtp3hJJQK5zUkpRSs0USt8arjaLvMx
         N42hL2NUjqCRKye8eHqUBBl/vMkA0nRIHLfxnnPc4clNFRsRJqY3ozKSbqAfxDKZza3w
         dHwX4VjCS5+HRgy4ffjazOnYFZtgJCd3jpcLRkuJQiAwMVMGhKeZHwmzWOpUPK+UrwN/
         Y5hSJYJoo/n+sVcHLQn4fMR3d3QyVAPmwSgLmj7A42/mzI1HyQVcycJKn/7S/0dJN/xu
         wsmQ==
X-Gm-Message-State: AOJu0Yzt31iWfZeFbZMop3atlrX1sASVMyfB23iEaw1wb0F/t7JUDqx4
	Hbc44/FiTQRLT6rl+ln5MmLF6iC3on0PHWJoyv/fqFOKIe3sk8hb11HQMss4vczm6CYbWVkLWoe
	rmg==
X-Google-Smtp-Source: AGHT+IEuFI8qJPg0sQoJhm64k4w3rhjOs2sT9jPCCRvBypEQ7eKqSPGl+SbLtIsRCgMDc7y8S6Y3WDMLQ3I=
X-Received: from pldr2.prod.google.com ([2002:a17:903:4102:b0:216:23fc:b4a1])
 (user=pandoh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce8d:b0:216:282d:c697
 with SMTP id d9443c01a7336-21a83f62877mr395988265ad.27.1736927006323; Tue, 14
 Jan 2025 23:43:26 -0800 (PST)
Date: Tue, 14 Jan 2025 23:42:56 -0800
In-Reply-To: <20250115074301.3514927-1-pandoh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250115074301.3514927-1-pandoh@google.com>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Message-ID: <20250115074301.3514927-5-pandoh@google.com>
Subject: [PATCH 4/8] PCI/AER: Introduce ratelimit for error logs
From: Jon Pan-Doh <pandoh@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>, 
	Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, 
	Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>, 
	Jon Pan-Doh <pandoh@google.com>
Content-Type: text/plain; charset="UTF-8"

Spammy devices can flood kernel logs with AER errors and slow/stall
execution. Add per-device ratelimits for AER errors (correctable and
uncorrectable). Set the default rate to the default kernel ratelimit
(10 per 5s).

Tested using aer-inject[1] tool. Sent 11 AER errors. Observed 10 errors
logged while AER stats (cat /sys/bus/pci/devices/<dev>/aer_dev_correctable)
show true count of 11.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer-inject.git

Signed-off-by: Jon Pan-Doh <pandoh@google.com>
---
 Documentation/PCI/pcieaer-howto.rst |  6 ++++++
 drivers/pci/pcie/aer.c              | 31 +++++++++++++++++++++++++++--
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/Documentation/PCI/pcieaer-howto.rst b/Documentation/PCI/pcieaer-howto.rst
index f013f3b27c82..5546de60f184 100644
--- a/Documentation/PCI/pcieaer-howto.rst
+++ b/Documentation/PCI/pcieaer-howto.rst
@@ -85,6 +85,12 @@ In the example, 'Requester ID' means the ID of the device that sent
 the error message to the Root Port. Please refer to PCIe specs for other
 fields.
 
+AER Ratelimits
+-------------------------
+
+Error messages are ratelimited per device and error type. This prevents spammy
+devices from flooding the console.
+
 AER Statistics / Counters
 -------------------------
 
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 5ab5cd7368bc..025c50b0f293 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -27,6 +27,7 @@
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/kfifo.h>
+#include <linux/ratelimit.h>
 #include <linux/slab.h>
 #include <acpi/apei.h>
 #include <acpi/ghes.h>
@@ -84,6 +85,10 @@ struct aer_info {
 	u64 rootport_total_cor_errs;
 	u64 rootport_total_fatal_errs;
 	u64 rootport_total_nonfatal_errs;
+
+	/* Ratelimits for errors */
+	struct ratelimit_state cor_log_ratelimit;
+	struct ratelimit_state uncor_log_ratelimit;
 };
 
 #define AER_LOG_TLP_MASKS		(PCI_ERR_UNC_POISON_TLP|	\
@@ -374,6 +379,12 @@ void pci_aer_init(struct pci_dev *dev)
 		return;
 
 	dev->aer_info = kzalloc(sizeof(struct aer_info), GFP_KERNEL);
+	ratelimit_state_init(&dev->aer_info->cor_log_ratelimit,
+			     DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST);
+	ratelimit_state_init(&dev->aer_info->uncor_log_ratelimit,
+			     DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST);
+	ratelimit_set_flags(&dev->aer_info->cor_log_ratelimit, RATELIMIT_MSG_ON_RELEASE);
+	ratelimit_set_flags(&dev->aer_info->uncor_log_ratelimit, RATELIMIT_MSG_ON_RELEASE);
 
 	/*
 	 * We save/restore PCI_ERR_UNCOR_MASK, PCI_ERR_UNCOR_SEVER,
@@ -702,6 +713,7 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 	int layer, agent;
 	int id = pci_dev_id(dev);
 	const char *level;
+	struct ratelimit_state *ratelimit;
 
 	if (!info->status) {
 		pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
@@ -709,11 +721,20 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 		goto out;
 	}
 
+	if (info->severity == AER_CORRECTABLE) {
+		ratelimit = &dev->aer_info->cor_log_ratelimit;
+		level = KERN_WARNING;
+	} else {
+		ratelimit = &dev->aer_info->uncor_log_ratelimit;
+		level = KERN_ERR;
+	}
+
+	if (!__ratelimit(ratelimit))
+		return;
+
 	layer = AER_GET_LAYER_ERROR(info->severity, info->status);
 	agent = AER_GET_AGENT(info->severity, info->status);
 
-	level = (info->severity == AER_CORRECTABLE) ? KERN_WARNING : KERN_ERR;
-
 	pci_printk(level, dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
 		   aer_error_severity_string[info->severity],
 		   aer_error_layer[layer], aer_agent_string[agent]);
@@ -755,11 +776,14 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 	int layer, agent, tlp_header_valid = 0;
 	u32 status, mask;
 	struct aer_err_info info;
+	struct ratelimit_state *ratelimit;
 
 	if (aer_severity == AER_CORRECTABLE) {
+		ratelimit = &dev->aer_info->cor_log_ratelimit;
 		status = aer->cor_status;
 		mask = aer->cor_mask;
 	} else {
+		ratelimit = &dev->aer_info->uncor_log_ratelimit;
 		status = aer->uncor_status;
 		mask = aer->uncor_mask;
 		tlp_header_valid = status & AER_LOG_TLP_MASKS;
@@ -776,6 +800,9 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 
 	pci_dev_aer_stats_incr(dev, &info);
 
+	if (!__ratelimit(ratelimit))
+		return;
+
 	pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
 	__aer_print_error(dev, &info);
 	pci_err(dev, "aer_layer=%s, aer_agent=%s\n",
-- 
2.48.0.rc2.279.g1de40edade-goog


