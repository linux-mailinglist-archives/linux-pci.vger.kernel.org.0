Return-Path: <linux-pci+bounces-28303-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E823AC17DB
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 01:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5BC8A44ADD
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 23:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09EA32DFA58;
	Thu, 22 May 2025 23:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6vZAIOT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D655A2DFA54;
	Thu, 22 May 2025 23:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747956249; cv=none; b=U4fFJJJQOPIzGElVIjFfO1lV7V82s73idQ5oxpEKerZa8+E7CJDLz5GqnsCf1cLPP+7y0bxUQiSJYG3oeBEQU6GQOyy/XdkXZDHs1MNaQbCaO8WO5oWQ5pvqdD3WztOgQoYEKiOCYupEEcmToVdA4BHYCZBtbocxRCqcrXzQV4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747956249; c=relaxed/simple;
	bh=BUCZr/dM3GUDSHARVzJs1oCeKTAGD/sFBPiAMckNcuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gb6mm9UCZhIZyaUNwfe4k6mRa6f9xdq1l6NYcU3lA6W8js2HnMPwjwp+puGgGN6oAHZFqWxoyo+0emAGY1+uoAw3cHmI7EBGGsT/GB9xnTST7QfUngFv7qc188I4M3PrkXUAAgGfnYcsogc6OFAI9Y0BK2NBWJ8ytncKhEDclp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6vZAIOT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84CC0C4CEE4;
	Thu, 22 May 2025 23:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747956249;
	bh=BUCZr/dM3GUDSHARVzJs1oCeKTAGD/sFBPiAMckNcuA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l6vZAIOTy+wGNUN8fBut5fZnYzpwOR6wrCv4B5yibDLzYtRew/ujwn4Zk59YkndgG
	 gdBwelhOislmDYSb6VbHB9cs7UMXkf4qRJFoHpMhiXOGAa8K5B6oeBp6FKd+50utya
	 bzIgwiWhK3tA2U7RqH9yKjDqYeg4lXDQXTx0YLXJzx+mMB0yxgT4o+f2u6ATbBNYcw
	 KrJ03wPGksUtNTn/aQHWaDhPSvu+5Na6HqnzNrR3qPGa602C082sN+JOI3c3c1aigB
	 oc5QVxJ1rtWtOmmuGEsefU1oQ0ZhNeE8ms7g79SFN/kX2LIigk+vg83GEkAnmxcFVS
	 nOV9/tLJ6tJCQ==
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
Subject: [PATCH v8 16/20] PCI/AER: Convert aer_get_device_error_info(), aer_print_error() to index
Date: Thu, 22 May 2025 18:21:22 -0500
Message-ID: <20250522232339.1525671-17-helgaas@kernel.org>
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

From: Bjorn Helgaas <bhelgaas@google.com>

Previously aer_get_device_error_info() and aer_print_error() took a pointer
to struct aer_err_info and a pointer to a pci_dev.  Typically the pci_dev
was one of the elements of the aer_err_info.dev[] array (DPC was an
exception, where the dev[] array was unused).

Convert aer_get_device_error_info() and aer_print_error() to take an index
into the aer_err_info.dev[] array instead.  A future patch will add
per-device ratelimit information, so the index makes it convenient to find
the ratelimit associated with the device.

To accommodate DPC, set info->dev[0] to the DPC port before using these
interfaces.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.h      |  4 ++--
 drivers/pci/pcie/aer.c | 33 +++++++++++++++++++++++----------
 drivers/pci/pcie/dpc.c |  8 ++++++--
 3 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 1a9bfc708757..e1a28215967f 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -605,8 +605,8 @@ struct aer_err_info {
 	struct pcie_tlp_log tlp;	/* TLP Header */
 };
 
-int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info);
-void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
+int aer_get_device_error_info(struct aer_err_info *info, int i);
+void aer_print_error(struct aer_err_info *info, int i);
 
 int pcie_read_tlp_log(struct pci_dev *dev, int where, int where2,
 		      unsigned int tlp_len, bool flit,
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 787a953fb331..237741e66d28 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -705,12 +705,18 @@ static void aer_print_source(struct pci_dev *dev, struct aer_err_info *info,
 		 found ? "" : " (no details found");
 }
 
-void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
+void aer_print_error(struct aer_err_info *info, int i)
 {
-	int layer, agent;
-	int id = pci_dev_id(dev);
+	struct pci_dev *dev;
+	int layer, agent, id;
 	const char *level = info->level;
 
+	if (i >= AER_MAX_MULTI_ERR_DEVICES)
+		return;
+
+	dev = info->dev[i];
+	id = pci_dev_id(dev);
+
 	pci_dev_aer_stats_incr(dev, info);
 	trace_aer_event(pci_name(dev), (info->status & ~info->mask),
 			info->severity, info->tlp_header_valid, &info->tlp);
@@ -1193,19 +1199,26 @@ EXPORT_SYMBOL_GPL(aer_recover_queue);
 
 /**
  * aer_get_device_error_info - read error status from dev and store it to info
- * @dev: pointer to the device expected to have an error record
  * @info: pointer to structure to store the error record
+ * @i: index into info->dev[]
  *
  * Return: 1 on success, 0 on error.
  *
  * Note that @info is reused among all error devices. Clear fields properly.
  */
-int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
+int aer_get_device_error_info(struct aer_err_info *info, int i)
 {
-	int type = pci_pcie_type(dev);
-	int aer = dev->aer_cap;
+	struct pci_dev *dev;
+	int type, aer;
 	u32 aercc;
 
+	if (i >= AER_MAX_MULTI_ERR_DEVICES)
+		return 0;
+
+	dev = info->dev[i];
+	aer = dev->aer_cap;
+	type = pci_pcie_type(dev);
+
 	/* Must reset in this function */
 	info->status = 0;
 	info->tlp_header_valid = 0;
@@ -1257,11 +1270,11 @@ static inline void aer_process_err_devices(struct aer_err_info *e_info)
 
 	/* Report all before handling them, to not lose records by reset etc. */
 	for (i = 0; i < e_info->error_dev_num && e_info->dev[i]; i++) {
-		if (aer_get_device_error_info(e_info->dev[i], e_info))
-			aer_print_error(e_info->dev[i], e_info);
+		if (aer_get_device_error_info(e_info, i))
+			aer_print_error(e_info, i);
 	}
 	for (i = 0; i < e_info->error_dev_num && e_info->dev[i]; i++) {
-		if (aer_get_device_error_info(e_info->dev[i], e_info))
+		if (aer_get_device_error_info(e_info, i))
 			handle_error_source(e_info->dev[i], e_info);
 	}
 }
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 7ae1590ea1da..fc18349614d7 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -253,6 +253,10 @@ static int dpc_get_aer_uncorrect_severity(struct pci_dev *dev,
 		info->severity = AER_NONFATAL;
 
 	info->level = KERN_ERR;
+
+	info->dev[0] = dev;
+	info->error_dev_num = 1;
+
 	return 1;
 }
 
@@ -270,8 +274,8 @@ void dpc_process_error(struct pci_dev *pdev)
 		pci_warn(pdev, "containment event, status:%#06x: unmasked uncorrectable error detected\n",
 			 status);
 		if (dpc_get_aer_uncorrect_severity(pdev, &info) &&
-		    aer_get_device_error_info(pdev, &info)) {
-			aer_print_error(pdev, &info);
+		    aer_get_device_error_info(&info, 0)) {
+			aer_print_error(&info, 0);
 			pci_aer_clear_nonfatal_status(pdev);
 			pci_aer_clear_fatal_status(pdev);
 		}
-- 
2.43.0


