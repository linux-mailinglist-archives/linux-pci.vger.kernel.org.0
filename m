Return-Path: <linux-pci+bounces-28305-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A13AC17DF
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 01:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E6E91887D92
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 23:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A122E3393;
	Thu, 22 May 2025 23:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2zPJSIA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2932E3391;
	Thu, 22 May 2025 23:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747956253; cv=none; b=rulr2FgfMgW7ZJfy60bUMz1+Hb3qVMP3rLsKvIV5Ll8lOiDqy86HSS3xRiWjJz0cl+JLP6dNXfmSmymEV27JVlH9jq+fR+BehFsejdtpIDfO+OEN6/R4vOQ4xl/Y5Ulae+LsmBa/Z05vBVtiyyZCKdjFGSjPKsg8xFumcpv+NZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747956253; c=relaxed/simple;
	bh=1oorHgUTF+X69XVlnPc3rvfjlARvJO5mXzyBMZUNfGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B6R2m5IeskqLvFQbOhDhusMpH3jqypH/vJhkN8SpJtMYaiIzreksJ/Fht6M68uKjd2bw8M45DrqCib7aYEjUADuljlDQ3ATH8dxqGViZFqyR5aPkWWCgKqf4ibUt4blWQDJAxzn87xH3iL2oj72PRh0XS1QerZotR6qUEQHqDUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2zPJSIA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A9B7C4CEE4;
	Thu, 22 May 2025 23:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747956252;
	bh=1oorHgUTF+X69XVlnPc3rvfjlARvJO5mXzyBMZUNfGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d2zPJSIAjncOAzhy7//nOddqxOOFcaYR+Kw0u4CbdT4avIqWXQghYukon9b8vGfSz
	 lQaWY28Bsqbn/h37PheKku0njOZyiAiYDd0phv/bNmNYmehWpKQ5D7/7LIJfNYlIuV
	 mRY6TvQPbycQxcrnV6G0nvE+SSq1e68K4P8IgpXVTOkNf4swMUcmu1PYSIdNOvypYa
	 GEkbf0r9bToUMUXFCg2bUxItrWzzMaSvRG4udk8HmbffoDQF9IVvFUL3Yz85DANKLQ
	 oVCVck8F9UZE3zvaqT2xSaOeI2uwe6B4tVQgMBGYxlEj5OkydNvWei4XHABHjSJFPw
	 w5j23wfgGjMcg==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Jon Pan-Doh <pandoh@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	Weinan Liu <wnliu@google.com>,
	Martin Petersen <martin.petersen@oracle.com>,
	Ben Fuller <ben.fuller@oracle.com>,
	Drew Walton <drewwalton@microsoft.com>,
	Anil Agrawal <anilagrawal@meta.com>,
	Tony Luck <tony.luck@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sargun Dhillon <sargun@meta.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Robert Richter <rrichter@amd.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v8 18/20] PCI/AER: Ratelimit correctable and non-fatal error logging
Date: Thu, 22 May 2025 18:21:24 -0500
Message-ID: <20250522232339.1525671-19-helgaas@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250522232339.1525671-1-helgaas@kernel.org>
References: <20250522232339.1525671-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jon Pan-Doh <pandoh@google.com>

Spammy devices can flood kernel logs with AER errors and slow/stall
execution. Add per-device ratelimits for AER correctable and non-fatal
uncorrectable errors that use the kernel defaults (10 per 5s).  Logging of
fatal errors is not ratelimited.

There are two AER logging entry points:

  - aer_print_error() is used by DPC and native AER

  - pci_print_aer() is used by GHES and CXL

The native AER aer_print_error() case includes a loop that may log details
from multiple devices, which are ratelimited individually.  If we log
details for any device, we also log the Error Source ID from the Root Port
or RCEC.

If no such device details are found, we still log the Error Source from the
ERR_* Message, ratelimited by the Root Port or RCEC that received it.

The DPC aer_print_error() case is not ratelimited, since this only happens
for fatal errors.

The CXL pci_print_aer() case is ratelimited by the Error Source device.

The GHES pci_print_aer() case is via aer_recover_work_func(), which
searches for the Error Source device.  If the device is not found, there's
no per-device ratelimit, so we use a system-wide ratelimit that covers all
error types (correctable, non-fatal, and fatal).

Sargun at Meta reported internally that a flood of AER errors causes RCU
CPU stall warnings and CSD-lock warnings.

Tested using aer-inject[1]. Sent 11 AER errors. Observed 10 errors logged
while AER stats (cat /sys/bus/pci/devices/<dev>/aer_dev_correctable) show
true count of 11.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer-inject.git

[bhelgaas: commit log, factor out trace_aer_event() and aer_print_rp_info()
changes to previous patches, enable Error Source logging if any downstream
detail will be printed, don't ratelimit fatal errors, "aer_report" ->
"aer_info", "cor_log_ratelimit" -> "correctable_ratelimit",
"uncor_log_ratelimit" -> "nonfatal_ratelimit"]

Reported-by: Sargun Dhillon <sargun@meta.com>
Signed-off-by: Jon Pan-Doh <pandoh@google.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://patch.msgid.link/20250520215047.1350603-16-helgaas@kernel.org
---
 drivers/pci/pci.h      |  4 ++-
 drivers/pci/pcie/aer.c | 69 +++++++++++++++++++++++++++++++++++++++---
 2 files changed, 67 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index e1a28215967f..3023c68fe485 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -587,13 +587,15 @@ static inline bool pci_dev_test_and_set_removed(struct pci_dev *dev)
 
 struct aer_err_info {
 	struct pci_dev *dev[AER_MAX_MULTI_ERR_DEVICES];
+	int ratelimit_print[AER_MAX_MULTI_ERR_DEVICES];
 	int error_dev_num;
 	const char *level;		/* printk level */
 
 	unsigned int id:16;
 
 	unsigned int severity:2;	/* 0:NONFATAL | 1:FATAL | 2:COR */
-	unsigned int __pad1:5;
+	unsigned int root_ratelimit_print:1;	/* 0=skip, 1=print */
+	unsigned int __pad1:4;
 	unsigned int multi_error_valid:1;
 
 	unsigned int first_error:5;
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 24f0f5c55256..ebac126144fc 100644
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
@@ -88,6 +89,10 @@ struct aer_info {
 	u64 rootport_total_cor_errs;
 	u64 rootport_total_fatal_errs;
 	u64 rootport_total_nonfatal_errs;
+
+	/* Ratelimits for errors */
+	struct ratelimit_state correctable_ratelimit;
+	struct ratelimit_state nonfatal_ratelimit;
 };
 
 #define AER_LOG_TLP_MASKS		(PCI_ERR_UNC_POISON_TLP|	\
@@ -379,6 +384,11 @@ void pci_aer_init(struct pci_dev *dev)
 
 	dev->aer_info = kzalloc(sizeof(*dev->aer_info), GFP_KERNEL);
 
+	ratelimit_state_init(&dev->aer_info->correctable_ratelimit,
+			     DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST);
+	ratelimit_state_init(&dev->aer_info->nonfatal_ratelimit,
+			     DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST);
+
 	/*
 	 * We save/restore PCI_ERR_UNCOR_MASK, PCI_ERR_UNCOR_SEVER,
 	 * PCI_ERR_COR_MASK, and PCI_ERR_CAP.  Root and Root Complex Event
@@ -669,6 +679,21 @@ static void pci_rootport_aer_stats_incr(struct pci_dev *pdev,
 	}
 }
 
+static int aer_ratelimit(struct pci_dev *dev, unsigned int severity)
+{
+	struct ratelimit_state *ratelimit;
+
+	if (severity == AER_FATAL)
+		return 1;	/* AER_FATAL not ratelimited */
+
+	if (severity == AER_CORRECTABLE)
+		ratelimit = &dev->aer_info->correctable_ratelimit;
+	else
+		ratelimit = &dev->aer_info->nonfatal_ratelimit;
+
+	return __ratelimit(ratelimit);
+}
+
 static void __aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 {
 	const char **strings;
@@ -721,6 +746,9 @@ void aer_print_error(struct aer_err_info *info, int i)
 	trace_aer_event(pci_name(dev), (info->status & ~info->mask),
 			info->severity, info->tlp_header_valid, &info->tlp);
 
+	if (!info->ratelimit_print[i])
+		return;
+
 	if (!info->status) {
 		pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
 			aer_error_severity_string[info->severity]);
@@ -790,6 +818,9 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 	trace_aer_event(pci_name(dev), (status & ~mask),
 			aer_severity, tlp_header_valid, &aer->header_log);
 
+	if (!aer_ratelimit(dev, info.severity))
+		return;
+
 	layer = AER_GET_LAYER_ERROR(aer_severity, status);
 	agent = AER_GET_AGENT(aer_severity, status);
 
@@ -824,6 +855,18 @@ static int add_error_device(struct aer_err_info *e_info, struct pci_dev *dev)
 	e_info->dev[i] = pci_dev_get(dev);
 	e_info->error_dev_num++;
 
+	/*
+	 * Ratelimit AER log messages.  "dev" is either the source
+	 * identified by the root's Error Source ID or it has an unmasked
+	 * error logged in its own AER Capability.  Messages are emitted
+	 * when "ratelimit_print[i]" is non-zero.  If we will print detail
+	 * for a downstream device, make sure we print the Error Source ID
+	 * from the root as well.
+	 */
+	if (aer_ratelimit(dev, e_info->severity)) {
+		e_info->ratelimit_print[i] = 1;
+		e_info->root_ratelimit_print = 1;
+	}
 	return 0;
 }
 
@@ -918,7 +961,7 @@ static int find_device_iter(struct pci_dev *dev, void *data)
  * e_info->error_dev_num and e_info->dev[], based on the given information.
  */
 static bool find_source_device(struct pci_dev *parent,
-		struct aer_err_info *e_info)
+			       struct aer_err_info *e_info)
 {
 	struct pci_dev *dev = parent;
 	int result;
@@ -1144,9 +1187,10 @@ static void aer_recover_work_func(struct work_struct *work)
 		pdev = pci_get_domain_bus_and_slot(entry.domain, entry.bus,
 						   entry.devfn);
 		if (!pdev) {
-			pr_err("no pci_dev for %04x:%02x:%02x.%x\n",
-			       entry.domain, entry.bus,
-			       PCI_SLOT(entry.devfn), PCI_FUNC(entry.devfn));
+			pr_err_ratelimited("%04x:%02x:%02x.%x: no pci_dev found\n",
+					   entry.domain, entry.bus,
+					   PCI_SLOT(entry.devfn),
+					   PCI_FUNC(entry.devfn));
 			continue;
 		}
 		pci_print_aer(pdev, entry.severity, entry.regs);
@@ -1294,7 +1338,22 @@ static void aer_isr_one_error_type(struct pci_dev *root,
 	bool found;
 
 	found = find_source_device(root, info);
-	aer_print_source(root, info, found);
+
+	/*
+	 * If we're going to log error messages, we've already set
+	 * "info->root_ratelimit_print" and "info->ratelimit_print[i]" to
+	 * non-zero (which enables printing) because this is either an
+	 * ERR_FATAL or we found a device with an error logged in its AER
+	 * Capability.
+	 *
+	 * If we didn't find the Error Source device, at least log the
+	 * Requester ID from the ERR_* Message received by the Root Port or
+	 * RCEC, ratelimited by the RP or RCEC.
+	 */
+	if (info->root_ratelimit_print ||
+	    (!found && aer_ratelimit(root, info->severity)))
+		aer_print_source(root, info, found);
+
 	if (found)
 		aer_process_err_devices(info);
 }
-- 
2.43.0


