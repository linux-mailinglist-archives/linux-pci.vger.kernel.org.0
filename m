Return-Path: <linux-pci+bounces-21415-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADAF2A354C8
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 03:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22EEE3ACA91
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 02:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF762C2EF;
	Fri, 14 Feb 2025 02:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GFFmORj5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FA2137930
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 02:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739500579; cv=none; b=W3TwGt5BFQce6s1Hj3eHxpXA6mKZZFL2ZBzPpob5c28nx39W5bFZis48lIf9yAH/N8RMf+rxzEEtDOscfa9Yab1keqTNEUf3fcU/ZSMnTsSANtMfTyanmoRBw9007Xj4VsRyAqO83+FaE8K4q9vAeVJjIqP4fE1drcDjq0+lZ+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739500579; c=relaxed/simple;
	bh=GPzOoUZY2/G8/jdv5l9hLV+gKD/CWyouhEXll5KMmJc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LRAmkAMFia79Hs9cV4Oi9vCuC2jgUix6TTceyxBKq0nRgS+ajS00ZtvmdcpNmpJxcGjg4M8dMhA5R8mO4FBx8apCLImWBbMWqKh/cZGFcePefHQQ++wYHNldmUgGpTrkefC4YKzl3hhH+DEW/4ZlxtPlkGP69xxtkdA8mmdrHls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GFFmORj5; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fc318bd470so84189a91.0
        for <linux-pci@vger.kernel.org>; Thu, 13 Feb 2025 18:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739500577; x=1740105377; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9W9BFxI+YRnR7tfqCSoyQdI4xkMFTHFH7uD6a1Bk1nc=;
        b=GFFmORj5Tem6kV4JtqSl9ER1+ayodWJzz/EfPVhsSWFZNCjpaQVhZ6czfeS59Jl8ke
         IEwHWGl42jChAv0v0xhfhIgrSpvTzsKcJSnyS1FAB3hIOLaUIX5cvQiXFS6ilphB2Lsw
         fmhYXIAA/0czN7c6m90MuptvVIPz6EAdKJcjAaX+3exIKNXW4uVhP4v31aV9LEz3mieY
         4lK7miPNsn2mTclL6lu9JiiYyvnXa75/b44HHkPjGNVWVI3DYtkdwdOaHmThvL4Cp47s
         YatvULo6TYmtESWLYB5OOn/xPKYc7xB2MXnuHSuZVEyfJ2dXkEcY7wO5jPtX6tjcWt8Z
         wRNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739500577; x=1740105377;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9W9BFxI+YRnR7tfqCSoyQdI4xkMFTHFH7uD6a1Bk1nc=;
        b=DHUttPoOBsYGsmFwHKAJBJ56/+pDxTlgZlimhITrvy9qURC6I88beVUcUWUGm41fyB
         1YyMy7zg6LBIut0i/3rBLkzQ7lr/BD6/WxbNmp+uXMaPRVjZqtqEqvHU83g6n2bC7o+e
         WK5IgymLrrd+5ov1ltGlOumkQDhkY2oTp0KqxnVokO+j/MX8vIFvEhkCO+dq3fciqf0R
         EvKUEq5xE/jGiDS7aeLONiTo61/DMGBdH3QdzLSt/7FY5MBFMF/DifHMOgamkGABiP1E
         SWkkuGDh5a5kBsYi3UWHG46aUIQOKk2Zlv4KmHJLJVO2AH04QPyTWALT1iNHHdJPPZqJ
         l6rA==
X-Gm-Message-State: AOJu0YxgzXUhW1Hj9tbmMV1PlAY/+a5fmSAuGMHi6iFPZqLjTAxAMYFC
	gSDeCcR6VZ2FVtycnQMYrg5omYgjpH6W5mz7mTaPt9VZGC15TgkIIyDwAHUPekXlzseW3NSlEsP
	i/Q==
X-Google-Smtp-Source: AGHT+IFeVdRVPjECaLJLPQPxCuwg3oEgqlTj0jR54Zq3B6tDKvAISVm/S8W7wz5Yr9SGXCnExhyEdLXgAXI=
X-Received: from pglo12.prod.google.com ([2002:a63:4e4c:0:b0:7fd:3ffb:bf1b])
 (user=pandoh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6da8:b0:1e1:cbbf:be0
 with SMTP id adf61e73a8af0-1ee5e5bbea4mr17562703637.22.1739500577538; Thu, 13
 Feb 2025 18:36:17 -0800 (PST)
Date: Thu, 13 Feb 2025 18:35:40 -0800
In-Reply-To: <20250214023543.992372-1-pandoh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250214023543.992372-1-pandoh@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250214023543.992372-6-pandoh@google.com>
Subject: [PATCH v2 5/8] PCI/AER: Introduce ratelimit for error logs
From: Jon Pan-Doh <pandoh@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>, 
	Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, 
	Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>, 
	"=?UTF-8?q?Ilpo=20J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, 
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Jon Pan-Doh <pandoh@google.com>
Content-Type: text/plain; charset="UTF-8"

Spammy devices can flood kernel logs with AER errors and slow/stall
execution. Add per-device ratelimits for AER errors (correctable and
uncorrectable). Set the default rate to the default kernel ratelimit
(10 per 5s).

Tested using aer-inject[1]. Sent 11 AER errors. Observed 10 errors logged
while AER stats (cat /sys/bus/pci/devices/<dev>/aer_dev_correctable) show
true count of 11.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer-inject.git

Signed-off-by: Jon Pan-Doh <pandoh@google.com>
---
 drivers/pci/pcie/aer.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index b4f902fd5ef6..c5b5381e2930 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -28,6 +28,7 @@
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/kfifo.h>
+#include <linux/ratelimit.h>
 #include <linux/slab.h>
 #include <acpi/apei.h>
 #include <acpi/ghes.h>
@@ -88,6 +89,10 @@ struct aer_report {
 	u64 rootport_total_cor_errs;
 	u64 rootport_total_fatal_errs;
 	u64 rootport_total_nonfatal_errs;
+
+	/* Ratelimits for errors */
+	struct ratelimit_state cor_log_ratelimit;
+	struct ratelimit_state uncor_log_ratelimit;
 };
 
 #define AER_LOG_TLP_MASKS		(PCI_ERR_UNC_POISON_TLP|	\
@@ -378,6 +383,10 @@ void pci_aer_init(struct pci_dev *dev)
 		return;
 
 	dev->aer_report = kzalloc(sizeof(struct aer_report), GFP_KERNEL);
+	ratelimit_state_init(&dev->aer_report->cor_log_ratelimit,
+			     DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST);
+	ratelimit_state_init(&dev->aer_report->uncor_log_ratelimit,
+			     DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST);
 
 	/*
 	 * We save/restore PCI_ERR_UNCOR_MASK, PCI_ERR_UNCOR_SEVER,
@@ -697,6 +706,7 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info,
 {
 	int layer, agent;
 	int id = pci_dev_id(dev);
+	struct ratelimit_state *ratelimit;
 
 	if (!info->status) {
 		pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
@@ -704,6 +714,14 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info,
 		goto out;
 	}
 
+	if (info->severity == AER_CORRECTABLE)
+		ratelimit = &dev->aer_report->cor_log_ratelimit;
+	else
+		ratelimit = &dev->aer_report->uncor_log_ratelimit;
+
+	if (!__ratelimit(ratelimit))
+		return;
+
 	layer = AER_GET_LAYER_ERROR(info->severity, info->status);
 	agent = AER_GET_AGENT(info->severity, info->status);
 
@@ -749,12 +767,15 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 	u32 status, mask;
 	const char *level;
 	struct aer_err_info info;
+	struct ratelimit_state *ratelimit;
 
 	if (aer_severity == AER_CORRECTABLE) {
+		ratelimit = &dev->aer_report->cor_log_ratelimit;
 		status = aer->cor_status;
 		mask = aer->cor_mask;
 		level = KERN_WARNING;
 	} else {
+		ratelimit = &dev->aer_report->uncor_log_ratelimit;
 		status = aer->uncor_status;
 		mask = aer->uncor_mask;
 		tlp_header_valid = status & AER_LOG_TLP_MASKS;
@@ -772,6 +793,9 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 
 	pci_dev_aer_stats_incr(dev, &info);
 
+	if (!__ratelimit(ratelimit))
+		return;
+
 	aer_printk(level, dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
 	__aer_print_error(dev, &info, level);
 	aer_printk(level, dev, "aer_layer=%s, aer_agent=%s\n",
-- 
2.48.1.601.g30ceb7b040-goog


