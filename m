Return-Path: <linux-pci+bounces-28162-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45237ABE67C
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 23:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 792E618990DA
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 21:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE06283157;
	Tue, 20 May 2025 21:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVC6mZkb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DE8283137;
	Tue, 20 May 2025 21:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747777874; cv=none; b=PeySSE8vc5I6FmeiSSeF6JQvq88T/SKutBOrFe/b2S+Vs0wu9C7vN4kT0wHPWEtPtLSksHsN4JRM+SBoLO5XYdfFwVU5Mr5ovhRdKjXF/t0Qfs7hbp2VajF89OPe0jGWgCMAmAKwFRmWsv9kItABhVKAfm3x76z9lQrdzwnRY7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747777874; c=relaxed/simple;
	bh=OMqSCVP7ecxR5OMOUPcTpr/sHmUfKWQn9r4jsLdCRI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fg6EoxGRQ9gh7FK8i+CRObPvB9LtfEnqmgNVf82/Y9jpkQUwtKrMMbMr9nKdXi3jbeMqB3x+Zq7V3VNbRb5fshksFI/MGiWY0HxVunGbAq7pntLe7ChQX+YCMXHgB3R9w/ZvsoRa245c6/RE6U0LdKhpkkU5qVHyWCeaVesCp1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVC6mZkb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E2ABC4CEE9;
	Tue, 20 May 2025 21:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747777874;
	bh=OMqSCVP7ecxR5OMOUPcTpr/sHmUfKWQn9r4jsLdCRI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MVC6mZkbTwv4jN1kG51CHf8N08yMNE2ywYJjbWBj8x2W9Fk/n92REWIDCffe18Y/x
	 n6W148ypHxNLMHabV7rnAmEhJS7kGh+w/0XV5SSHoc9N+rGZgx9FKpg6ZfJpEIW752
	 dJk7Wm25P3rZOpw+s5+/ENY0y294lSwif61cR+xHcrI42LN06lDKGuN9jpXS3eQEYp
	 tfqhn0WAcqQqKdGU5ZRDAlmAyQSjfMx4JNr/YZ7HOk0KZcp4nFUj2Q+j5ldgYWXtao
	 EhlPCfsAcK3+O76E2ikHOYCHirhMH0jLjvAGUILuN/OPxBSRjzAecgoB3hMnzMnkNj
	 RpdxSR3s9SNCg==
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
Subject: [PATCH v7 15/17] PCI/AER: Ratelimit correctable and non-fatal error logging
Date: Tue, 20 May 2025 16:50:32 -0500
Message-ID: <20250520215047.1350603-16-helgaas@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250520215047.1350603-1-helgaas@kernel.org>
References: <20250520215047.1350603-1-helgaas@kernel.org>
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
from multiple devices.  This is ratelimited such that we log all the
details we find if any of the devices has not hit the ratelimit.  If no
such device details are found, we still log the Error Source from the ERR_*
Message, ratelimited by the Root Port or RCEC that received it.

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
changes to previous patches, collect single aer_err_info.ratelimit as union
of ratelimits of all error source devices, don't ratelimit fatal errors,
"aer_report" -> "aer_info"]
Reported-by: Sargun Dhillon <sargun@meta.com>
Signed-off-by: Jon Pan-Doh <pandoh@google.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.h      |  3 +-
 drivers/pci/pcie/aer.c | 66 ++++++++++++++++++++++++++++++++++++++----
 drivers/pci/pcie/dpc.c |  1 +
 3 files changed, 64 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 705f9ef58acc..65c466279ade 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -593,7 +593,8 @@ struct aer_err_info {
 	unsigned int id:16;
 
 	unsigned int severity:2;	/* 0:NONFATAL | 1:FATAL | 2:COR */
-	unsigned int __pad1:5;
+	unsigned int ratelimit:1;	/* 0=skip, 1=print */
+	unsigned int __pad1:4;
 	unsigned int multi_error_valid:1;
 
 	unsigned int first_error:5;
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 4f1bff0f000f..f9e684ac7878 100644
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
+	struct ratelimit_state cor_log_ratelimit;
+	struct ratelimit_state uncor_log_ratelimit;
 };
 
 #define AER_LOG_TLP_MASKS		(PCI_ERR_UNC_POISON_TLP|	\
@@ -379,6 +384,11 @@ void pci_aer_init(struct pci_dev *dev)
 
 	dev->aer_info = kzalloc(sizeof(*dev->aer_info), GFP_KERNEL);
 
+	ratelimit_state_init(&dev->aer_info->cor_log_ratelimit,
+			     DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST);
+	ratelimit_state_init(&dev->aer_info->uncor_log_ratelimit,
+			     DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST);
+
 	/*
 	 * We save/restore PCI_ERR_UNCOR_MASK, PCI_ERR_UNCOR_SEVER,
 	 * PCI_ERR_COR_MASK, and PCI_ERR_CAP.  Root and Root Complex Event
@@ -672,6 +682,18 @@ static void pci_rootport_aer_stats_incr(struct pci_dev *pdev,
 	}
 }
 
+static int aer_ratelimit(struct pci_dev *dev, unsigned int severity)
+{
+	struct ratelimit_state *ratelimit;
+
+	if (severity == AER_CORRECTABLE)
+		ratelimit = &dev->aer_info->cor_log_ratelimit;
+	else
+		ratelimit = &dev->aer_info->uncor_log_ratelimit;
+
+	return __ratelimit(ratelimit);
+}
+
 static void __aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 {
 	const char **strings;
@@ -715,6 +737,9 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 
 	pci_dev_aer_stats_incr(dev, info);
 
+	if (!info->ratelimit)
+		return;
+
 	if (!info->status) {
 		pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
 			aer_error_severity_string[info->severity]);
@@ -785,6 +810,9 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 
 	pci_dev_aer_stats_incr(dev, &info);
 
+	if (!aer_ratelimit(dev, info.severity))
+		return;
+
 	layer = AER_GET_LAYER_ERROR(aer_severity, status);
 	agent = AER_GET_AGENT(aer_severity, status);
 
@@ -815,8 +843,19 @@ EXPORT_SYMBOL_NS_GPL(pci_print_aer, "CXL");
  */
 static int add_error_device(struct aer_err_info *e_info, struct pci_dev *dev)
 {
+	/*
+	 * Ratelimit AER log messages.  "dev" is either the source
+	 * identified by the root's Error Source ID or it has an unmasked
+	 * error logged in its own AER Capability.  If any of these devices
+	 * has not reached its ratelimit, log messages for all of them.
+	 * Messages are emitted when "e_info->ratelimit" is non-zero.
+	 *
+	 * Note that "e_info->ratelimit" was already initialized to 1 for the
+	 * ERR_FATAL case.
+	 */
 	if (e_info->error_dev_num < AER_MAX_MULTI_ERR_DEVICES) {
 		e_info->dev[e_info->error_dev_num] = pci_dev_get(dev);
+		e_info->ratelimit |= aer_ratelimit(dev, e_info->severity);
 		e_info->error_dev_num++;
 		return 0;
 	}
@@ -914,7 +953,7 @@ static int find_device_iter(struct pci_dev *dev, void *data)
  * e_info->error_dev_num and e_info->dev[], based on the given information.
  */
 static bool find_source_device(struct pci_dev *parent,
-		struct aer_err_info *e_info)
+			       struct aer_err_info *e_info)
 {
 	struct pci_dev *dev = parent;
 	int result;
@@ -1140,9 +1179,10 @@ static void aer_recover_work_func(struct work_struct *work)
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
@@ -1283,7 +1323,21 @@ static void aer_isr_one_error_type(struct pci_dev *root,
 	bool found;
 
 	found = find_source_device(root, info);
-	aer_print_source(root, info, found ? "" : " (no details found");
+
+	/*
+	 * If we're going to log error messages, we've already set
+	 * "info->ratelimit" to non-zero (which enables printing) because
+	 * this is either an ERR_FATAL or we found a device with an error
+	 * logged in its AER Capability.
+	 *
+	 * If we didn't find the Error Source device, at least log the
+	 * Requester ID from the ERR_* Message received by the Root Port or
+	 * RCEC, ratelimited by the RP or RCEC.
+	 */
+	if (info->ratelimit ||
+	    (!found && aer_ratelimit(root, info->severity)))
+		aer_print_source(root, info, found ? "" : " (no details found");
+
 	if (found)
 		aer_process_err_devices(info);
 }
@@ -1317,12 +1371,14 @@ static void aer_isr_one_error(struct pci_dev *root,
 		aer_isr_one_error_type(root, &e_info);
 	}
 
+	/* Note that messages for ERR_FATAL are never ratelimited */
 	if (status & PCI_ERR_ROOT_UNCOR_RCV) {
 		int fatal = status & PCI_ERR_ROOT_FATAL_RCV;
 		int multi = status & PCI_ERR_ROOT_MULTI_UNCOR_RCV;
 		struct aer_err_info e_info = {
 			.id = ERR_UNCOR_ID(e_src->id),
 			.severity = fatal ? AER_FATAL : AER_NONFATAL,
+			.ratelimit = fatal ? 1 : 0,
 			.level = KERN_ERR,
 			.multi_error_valid = multi ? 1 : 0,
 		};
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 6c98fabdba57..530c5e2cf7e8 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -271,6 +271,7 @@ void dpc_process_error(struct pci_dev *pdev)
 			 status);
 		if (dpc_get_aer_uncorrect_severity(pdev, &info) &&
 		    aer_get_device_error_info(pdev, &info)) {
+			info.ratelimit = 1;	/* ERR_FATAL; no ratelimit */
 			aer_print_error(pdev, &info);
 			pci_aer_clear_nonfatal_status(pdev);
 			pci_aer_clear_fatal_status(pdev);
-- 
2.43.0


