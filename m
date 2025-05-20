Return-Path: <linux-pci+bounces-28150-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08778ABE653
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 23:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41F721B681FC
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 21:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260ED25F96B;
	Tue, 20 May 2025 21:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NuctOaY8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CD325F7BF;
	Tue, 20 May 2025 21:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747777856; cv=none; b=P0xSnU0jfOnaIxrAhvENCQhefTooUx0Skn41tnHNDpg9pP0jQMj2ivoIPSO0M6zeG5vESlNAIdNDS2DVUNd8kmTX2f9xDNPAHiT1tyo/7dt7WOxPBzrRp/FbFUP1cnxR2B0GEypPuMp4doffU1he4+mw/Am7rUYiesvAcXO1YL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747777856; c=relaxed/simple;
	bh=bOmto9wLMARVaw1TnEPc56nZV6A8tSFt4Yy4a/LNgTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W76PO23MbWjfsyKnbRqQN9lUKzGhCSROTkEftEV3N0PdJS42ErP3I0ZPtidKV0W+Mf/71lwzqpRsZJ9ZdLv61mVOyfCJgyPc12dlgt7Y0S0y/+/TxI6QNlg0YSu1hi20XaFixEEyZuwn0BbTASCYpRWYzHtKYu0RyXSasQKDoLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NuctOaY8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98C0EC4CEEF;
	Tue, 20 May 2025 21:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747777855;
	bh=bOmto9wLMARVaw1TnEPc56nZV6A8tSFt4Yy4a/LNgTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NuctOaY8bndBicWsciYCCKzNXMgTJ5UEMrJl16YOrn9MvPRP9QPyZESvPPiXCQSPq
	 54rgbRzkMQHc2+x1ozcAYB/Z+qSiXdo5MjoqHJzDVzRznHpH59jfB47G3niFxVgI+d
	 kyAC1a0hYGtNasbof07CG9vadAWF7JfqXYfspgydFnMV8MVxTJxD2EhgtYkn6Ob++/
	 WkZILGsDwtAZdHMJNSBQNpq6dUuQCUkbMluJMOvR7h+hJdxIf3VcAl6+1/AFu+tiAY
	 MA3upti9b6h90Q0KTSRwuW5JluOYd4FEGMClyEe7XkAb7xODbgqnKk1k41lb1i2+KQ
	 XNE7SWd0ULo1w==
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
Subject: [PATCH v7 03/17] PCI/AER: Factor COR/UNCOR error handling out from aer_isr_one_error()
Date: Tue, 20 May 2025 16:50:20 -0500
Message-ID: <20250520215047.1350603-4-helgaas@kernel.org>
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

From: Bjorn Helgaas <bhelgaas@google.com>

aer_isr_one_error() duplicates the Error Source ID logging and AER error
processing for Correctable Errors and Uncorrectable Errors.  Factor out the
duplicated code to aer_isr_one_error_type().

aer_isr_one_error() doesn't need the struct aer_rpc pointer, so pass it the
Root Port or RCEC pci_dev pointer instead.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aer.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index a1cf8c7ef628..568229288ca3 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1273,17 +1273,32 @@ static inline void aer_process_err_devices(struct aer_err_info *e_info)
 }
 
 /**
- * aer_isr_one_error - consume an error detected by Root Port
- * @rpc: pointer to the Root Port which holds an error
+ * aer_isr_one_error_type - consume a Correctable or Uncorrectable Error
+ *			    detected by Root Port or RCEC
+ * @root: pointer to Root Port or RCEC that signaled AER interrupt
+ * @info: pointer to AER error info
+ */
+static void aer_isr_one_error_type(struct pci_dev *root,
+				   struct aer_err_info *info)
+{
+	aer_print_port_info(root, info);
+
+	if (find_source_device(root, info))
+		aer_process_err_devices(info);
+}
+
+/**
+ * aer_isr_one_error - consume error(s) signaled by an AER interrupt from
+ *		       Root Port or RCEC
+ * @root: pointer to Root Port or RCEC that signaled AER interrupt
  * @e_src: pointer to an error source
  */
-static void aer_isr_one_error(struct aer_rpc *rpc,
+static void aer_isr_one_error(struct pci_dev *root,
 		struct aer_err_source *e_src)
 {
-	struct pci_dev *pdev = rpc->rpd;
 	struct aer_err_info e_info;
 
-	pci_rootport_aer_stats_incr(pdev, e_src);
+	pci_rootport_aer_stats_incr(root, e_src);
 
 	/*
 	 * There is a possibility that both correctable error and
@@ -1297,10 +1312,8 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
 			e_info.multi_error_valid = 1;
 		else
 			e_info.multi_error_valid = 0;
-		aer_print_port_info(pdev, &e_info);
 
-		if (find_source_device(pdev, &e_info))
-			aer_process_err_devices(&e_info);
+		aer_isr_one_error_type(root, &e_info);
 	}
 
 	if (e_src->status & PCI_ERR_ROOT_UNCOR_RCV) {
@@ -1316,10 +1329,7 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
 		else
 			e_info.multi_error_valid = 0;
 
-		aer_print_port_info(pdev, &e_info);
-
-		if (find_source_device(pdev, &e_info))
-			aer_process_err_devices(&e_info);
+		aer_isr_one_error_type(root, &e_info);
 	}
 }
 
@@ -1340,7 +1350,7 @@ static irqreturn_t aer_isr(int irq, void *context)
 		return IRQ_NONE;
 
 	while (kfifo_get(&rpc->aer_fifo, &e_src))
-		aer_isr_one_error(rpc, &e_src);
+		aer_isr_one_error(rpc->rpd, &e_src);
 	return IRQ_HANDLED;
 }
 
-- 
2.43.0


