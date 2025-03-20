Return-Path: <linux-pci+bounces-24204-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E743AA6A128
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 09:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0B69461645
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 08:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DB320FA8B;
	Thu, 20 Mar 2025 08:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RHrRPCnN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A411020CCDB
	for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 08:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742458882; cv=none; b=E3wSDEDCDkUgPDyOlU7ndJAiH2i1KxCXbgcUtnkQYeMAjKd7gI1eEfvxAy/WvugUAB7hqI2AtoKq/qHDxC2OPm9n8yLnEC8aMWjNTojt9NrvOBlUL+6zWiqnG6CNo5Cc1Z9zsJ1SpNslYcLBL0Yj09XSCWjtUra4g7hZ5ZQZ8zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742458882; c=relaxed/simple;
	bh=IQehk48Mrt/qYtNtAi6UcqFKSghE87jJvGVubnO5NNY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tQ/0tTx0Sg9TgOj/1qAORt4fkI99GG6WAC3UdkWCUvXkuQbLFYOw9uHEZmkS/8gaGcg8/fvcYNozppeNHze+PxQFZy/FdE+lBh60q9csAGzO45fKobv3gNKpd9ABb8aBIxw6SJ9B+nbrB24xdlSrzrp3LQR3iNeWEZ+9gpx9ftw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RHrRPCnN; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pandoh.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff78dd28ecso1167592a91.1
        for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 01:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742458880; x=1743063680; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XKR4MJYbWdtySqzg+qIiY+QEKRx1H123IJNT0GWRmiU=;
        b=RHrRPCnNCg0cLZYoZIAwY1+zIsXcU07TyAxbl+orMkHlzCCvtcrnLErUycc4lh9qAe
         TEdLxDDqPJwI7vwykNimo9T189vPYHP9dNBXixHnEBzPEl1/IGiIrvPrTPRg9VO9M/aM
         9ewVU2fu91NT92PAuKwKNaxgEfl3BlA/VAHofSgLbjUZnZCgjju4KJUEvJ2M0FVYnT25
         jIM8T1YbuORF/0u0Z558PBqxWqG05Qhw6Zh7rumUCH0FyIM+9mKfWV/InjddbGddNGP5
         agcFPs+vwKQo4YkW0XVnRdzvqsShaPl+5skFRFu+C1qnSiQ82NwDb1idGbuEuL4jG4VQ
         XgPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742458880; x=1743063680;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XKR4MJYbWdtySqzg+qIiY+QEKRx1H123IJNT0GWRmiU=;
        b=wVLdvCu3PsOH46R1GGrb7lIkhPF9Hj6I3P6k5JmdJimAVAsEyZ7V1WA/JsAkMmwiG+
         D3GLO3lY4Ri7pw07YfuK3NZmIAaq5OaiNfBKVHDHSOhqQpVzBe0hEaKkSAzsTo9uiOKz
         V0WMW8Qfbos6YILYTR6usdjZpt1vecfDy1Q+G7P3eXPS+Y6UIgT7TN7jHRlhm9/dvMcC
         FrpfoMxAun3QiTHUcTPzGzA+ZqWCsGR7Zwq7Ki7O9goBu1ZMKKd1RmmNqCOukX3JVSiD
         m4E9S9usqjL4ifiTUirNhSZq4WI76mW4pfBKQ/JPNabzJgPbJRzFLqlv2Smtz78MO7AD
         ZzmA==
X-Gm-Message-State: AOJu0YwcKdkmY6PelrWPmqZNvMloS33X2PywNBg3gbEv7JodYIKrtxDa
	+daqNmRJAKcgl1NTptZfVXSHEYPQIv35dQSF6uO9jZF8maV8mqQwUnY1TDgNlKAZjedolON4MLL
	OXA==
X-Google-Smtp-Source: AGHT+IF9XplI32/63gVHvuQSLF0VS96v+cA24JGdzkji2cW4BJEwbWqjXU3EQEo3sWJnVV1F/MBXit9habs=
X-Received: from pjp6.prod.google.com ([2002:a17:90b:55c6:b0:2ef:78ff:bc3b])
 (user=pandoh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:384b:b0:2ff:6aa6:47a3
 with SMTP id 98e67ed59e1d1-301be1f86eamr8815217a91.25.1742458879868; Thu, 20
 Mar 2025 01:21:19 -0700 (PDT)
Date: Thu, 20 Mar 2025 01:20:55 -0700
In-Reply-To: <20250320082057.622983-1-pandoh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250320082057.622983-1-pandoh@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250320082057.622983-6-pandoh@google.com>
Subject: [PATCH v4 5/7] PCI/AER: Introduce ratelimit for error logs
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

Spammy devices can flood kernel logs with AER errors and slow/stall
execution. Add per-device ratelimits for AER correctable and uncorrectable
errors that use the kernel defaults (10 per 5s).

Tested using aer-inject[1]. Sent 11 AER errors. Observed 10 errors logged
while AER stats (cat /sys/bus/pci/devices/<dev>/aer_dev_correctable) show
true count of 11.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer-inject.git

Signed-off-by: Jon Pan-Doh <pandoh@google.com>
Reviewed-by: Karolina Stolarek <karolina.stolarek@oracle.com>
---
 drivers/pci/pcie/aer.c | 74 +++++++++++++++++++++++++++++++++---------
 1 file changed, 58 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 3069376b3553..081cef5fc678 100644
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
@@ -379,6 +384,15 @@ void pci_aer_init(struct pci_dev *dev)
 
 	dev->aer_report = kzalloc(sizeof(*dev->aer_report), GFP_KERNEL);
 
+	/*
+	 * Ratelimits are doubled as a given error produces 2 logs (root port
+	 * and endpoint) that should be under same ratelimit.
+	 */
+	ratelimit_state_init(&dev->aer_report->cor_log_ratelimit,
+			     DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST * 2);
+	ratelimit_state_init(&dev->aer_report->uncor_log_ratelimit,
+			     DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST * 2);
+
 	/*
 	 * We save/restore PCI_ERR_UNCOR_MASK, PCI_ERR_UNCOR_SEVER,
 	 * PCI_ERR_COR_MASK, and PCI_ERR_CAP.  Root and Root Complex Event
@@ -668,6 +682,17 @@ static void pci_rootport_aer_stats_incr(struct pci_dev *pdev,
 	}
 }
 
+static int aer_ratelimit(struct pci_dev *dev, unsigned int severity)
+{
+	struct ratelimit_state *ratelimit;
+
+	if (severity == AER_CORRECTABLE)
+		ratelimit = &dev->aer_report->cor_log_ratelimit;
+	else
+		ratelimit = &dev->aer_report->uncor_log_ratelimit;
+	return __ratelimit(ratelimit);
+}
+
 static void __aer_print_error(struct pci_dev *dev,
 			      struct aer_err_info *info,
 			      const char *level)
@@ -698,6 +723,12 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info,
 	int layer, agent;
 	int id = pci_dev_id(dev);
 
+	trace_aer_event(dev_name(&dev->dev), (info->status & ~info->mask),
+			info->severity, info->tlp_header_valid, &info->tlp);
+
+	if (!aer_ratelimit(dev, info->severity))
+		return;
+
 	if (!info->status) {
 		pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
 			aer_error_severity_string[info->severity]);
@@ -722,21 +753,28 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info,
 out:
 	if (info->id && info->error_dev_num > 1 && info->id == id)
 		pci_err(dev, "  Error of this Agent is reported first\n");
-
-	trace_aer_event(dev_name(&dev->dev), (info->status & ~info->mask),
-			info->severity, info->tlp_header_valid, &info->tlp);
 }
 
 static void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info)
 {
 	u8 bus = info->id >> 8;
 	u8 devfn = info->id & 0xff;
+	struct pci_dev *endpoint;
+	int i;
+
+	/* extract endpoint device ratelimit */
+	for (i = 0; i < info->error_dev_num; i++) {
+		endpoint = info->dev[i];
+		if (info->id == pci_dev_id(endpoint))
+			break;
+	}
 
-	pci_info(dev, "%s%s error message received from %04x:%02x:%02x.%d\n",
-		 info->multi_error_valid ? "Multiple " : "",
-		 aer_error_severity_string[info->severity],
-		 pci_domain_nr(dev->bus), bus, PCI_SLOT(devfn),
-		 PCI_FUNC(devfn));
+	if (aer_ratelimit(endpoint, info->severity))
+		pci_info(dev, "%s%s error message received from %04x:%02x:%02x.%d\n",
+			 info->multi_error_valid ? "Multiple " : "",
+			 aer_error_severity_string[info->severity],
+			 pci_domain_nr(dev->bus), bus, PCI_SLOT(devfn),
+			 PCI_FUNC(devfn));
 }
 
 #ifdef CONFIG_ACPI_APEI_PCIEAER
@@ -784,6 +822,12 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 
 	pci_dev_aer_stats_incr(dev, &info);
 
+	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
+			aer_severity, tlp_header_valid, &aer->header_log);
+
+	if (!aer_ratelimit(dev, aer_severity))
+		return;
+
 	aer_printk(level, dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
 	__aer_print_error(dev, &info, level);
 	aer_printk(level, dev, "aer_layer=%s, aer_agent=%s\n",
@@ -795,9 +839,6 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 
 	if (tlp_header_valid)
 		pcie_print_tlp_log(dev, &aer->header_log, dev_fmt("  "));
-
-	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
-			aer_severity, tlp_header_valid, &aer->header_log);
 }
 EXPORT_SYMBOL_NS_GPL(pci_print_aer, "CXL");
 
@@ -1299,10 +1340,11 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
 			e_info.multi_error_valid = 1;
 		else
 			e_info.multi_error_valid = 0;
-		aer_print_port_info(pdev, &e_info);
 
-		if (find_source_device(pdev, &e_info))
+		if (find_source_device(pdev, &e_info)) {
+			aer_print_port_info(pdev, &e_info);
 			aer_process_err_devices(&e_info, KERN_WARNING);
+		}
 	}
 
 	if (e_src->status & PCI_ERR_ROOT_UNCOR_RCV) {
@@ -1318,10 +1360,10 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
 		else
 			e_info.multi_error_valid = 0;
 
-		aer_print_port_info(pdev, &e_info);
-
-		if (find_source_device(pdev, &e_info))
+		if (find_source_device(pdev, &e_info)) {
+			aer_print_port_info(pdev, &e_info);
 			aer_process_err_devices(&e_info, KERN_ERR);
+		}
 	}
 }
 
-- 
2.49.0.rc1.451.g8f38331e32-goog


