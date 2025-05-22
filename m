Return-Path: <linux-pci+bounces-28299-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87868AC17D3
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 01:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 821DF7BADAF
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 23:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BFA2D8DAF;
	Thu, 22 May 2025 23:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LyugBz2A"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5C22D8DAD;
	Thu, 22 May 2025 23:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747956244; cv=none; b=SRa5im9llgc1nxQtUmrP0lj/O7+GqIJ2IgqC3wHvkWdNTc7fstEfnErEPQsiwDP41iEpxj7mOWvb7z8FPHkG0G66x3SWxFiHhea2PHSr0NDniA7Y2bhKSUtTo8+vKfIoGZFCBsYv0szOwPC+zDbRtdgnvIexFNcRe2OrPBwo2TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747956244; c=relaxed/simple;
	bh=tlAD9AdL+GVG0VKLEhv34aIrnvZJlSg7fRrzKCtpra8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KRoDR6YzNkwLaikjnthWjJTlCHRn+rBBdgseHKF203ZlfWopF7txFWSAjaqTfN79DTMZ//ZtoA4yrTBrJMIMwC9Q0CxxWU7S6AJTocH2sVItJ74kMqN+A/MLHvvnEhbO8a7ZhBtl5PoTl2LmTwzfXFJ/9OWP7NI/Cxl/iADf4xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LyugBz2A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7674FC4CEE4;
	Thu, 22 May 2025 23:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747956243;
	bh=tlAD9AdL+GVG0VKLEhv34aIrnvZJlSg7fRrzKCtpra8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LyugBz2AOlvyz8/jF57FMQy2HQg5qAXj1Vr6lxZGPwaRgssmPPf/l2EfU17MpYZyq
	 qYco/qlMBrLpwCoJwlTkEvDpEnW3kn+WcUOr4902OthZDurC3LQbxOZViT8hsVOxar
	 /LxvjvqkDRWfuV9aJ+P1Kd7wM+q92Zoq/mO3MSPRg/o78br8VQgO91Dfv9wA7dPaez
	 HTphYeSa989v9aB/eDwtTm+IAYuDHroKsJ5Jy4vCjoEo+Odg8VaWB+fkr/aPQvJzCF
	 8qMMzHK7t4DhhM/7B6uIiA/7QRcnjaCcmMnfKu69EZp0OYCZDZokVgKnFO88b0bJMV
	 CVFrfFDNUBHhg==
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
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v8 12/20] PCI/AER: Check log level once and remember it
Date: Thu, 22 May 2025 18:21:18 -0500
Message-ID: <20250522232339.1525671-13-helgaas@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250522232339.1525671-1-helgaas@kernel.org>
References: <20250522232339.1525671-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Karolina Stolarek <karolina.stolarek@oracle.com>

When reporting an AER error, we check its type multiple times to determine
the log level for each message. Do this check only in the top-level
functions (aer_isr_one_error(), pci_print_aer()) and save the level in
struct aer_err_info.

[bhelgaas: save log level in struct aer_err_info instead of passing it
as a parameter]

Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>
Tested-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://patch.msgid.link/20250520215047.1350603-13-helgaas@kernel.org
---
 drivers/pci/pci.h      |  1 +
 drivers/pci/pcie/aer.c | 21 ++++++++++-----------
 drivers/pci/pcie/dpc.c |  1 +
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index b81e99cd4b62..705f9ef58acc 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -588,6 +588,7 @@ static inline bool pci_dev_test_and_set_removed(struct pci_dev *dev)
 struct aer_err_info {
 	struct pci_dev *dev[AER_MAX_MULTI_ERR_DEVICES];
 	int error_dev_num;
+	const char *level;		/* printk level */
 
 	unsigned int id:16;
 
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 636bcd92afa1..f80c78846a14 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -669,21 +669,18 @@ static void pci_rootport_aer_stats_incr(struct pci_dev *pdev,
 	}
 }
 
-static void __aer_print_error(struct pci_dev *dev,
-			      struct aer_err_info *info)
+static void __aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 {
 	const char **strings;
 	unsigned long status = info->status & ~info->mask;
-	const char *level, *errmsg;
+	const char *level = info->level;
+	const char *errmsg;
 	int i;
 
-	if (info->severity == AER_CORRECTABLE) {
+	if (info->severity == AER_CORRECTABLE)
 		strings = aer_correctable_error_string;
-		level = KERN_WARNING;
-	} else {
+	else
 		strings = aer_uncorrectable_error_string;
-		level = KERN_ERR;
-	}
 
 	for_each_set_bit(i, &status, 32) {
 		errmsg = strings[i];
@@ -712,7 +709,7 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 {
 	int layer, agent;
 	int id = pci_dev_id(dev);
-	const char *level;
+	const char *level = info->level;
 
 	pci_dev_aer_stats_incr(dev, info);
 	trace_aer_event(pci_name(dev), (info->status & ~info->mask),
@@ -727,8 +724,6 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 	layer = AER_GET_LAYER_ERROR(info->severity, info->status);
 	agent = AER_GET_AGENT(info->severity, info->status);
 
-	level = (info->severity == AER_CORRECTABLE) ? KERN_WARNING : KERN_ERR;
-
 	aer_printk(level, dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
 		   aer_error_severity_string[info->severity],
 		   aer_error_layer[layer], aer_agent_string[agent]);
@@ -774,9 +769,11 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 	if (aer_severity == AER_CORRECTABLE) {
 		status = aer->cor_status;
 		mask = aer->cor_mask;
+		info.level = KERN_WARNING;
 	} else {
 		status = aer->uncor_status;
 		mask = aer->uncor_mask;
+		info.level = KERN_ERR;
 		tlp_header_valid = status & AER_LOG_TLP_MASKS;
 	}
 
@@ -1306,6 +1303,7 @@ static void aer_isr_one_error(struct pci_dev *root,
 		struct aer_err_info e_info = {
 			.id = ERR_COR_ID(e_src->id),
 			.severity = AER_CORRECTABLE,
+			.level = KERN_WARNING,
 			.multi_error_valid = multi ? 1 : 0,
 		};
 
@@ -1318,6 +1316,7 @@ static void aer_isr_one_error(struct pci_dev *root,
 		struct aer_err_info e_info = {
 			.id = ERR_UNCOR_ID(e_src->id),
 			.severity = fatal ? AER_FATAL : AER_NONFATAL,
+			.level = KERN_ERR,
 			.multi_error_valid = multi ? 1 : 0,
 		};
 
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 9d85f1b3b761..6c98fabdba57 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -252,6 +252,7 @@ static int dpc_get_aer_uncorrect_severity(struct pci_dev *dev,
 	else
 		info->severity = AER_NONFATAL;
 
+	info->level = KERN_ERR;
 	return 1;
 }
 
-- 
2.43.0


