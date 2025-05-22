Return-Path: <linux-pci+bounces-28290-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C83AAC17B1
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 01:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5B101B6258B
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 23:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D092D1F76;
	Thu, 22 May 2025 23:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/HVPUDe"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867742D191F;
	Thu, 22 May 2025 23:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747956230; cv=none; b=LYFCdLb7/x6mfhqlLa3WFBcaq51xLonIave9Y6GKViU3UIF/2gumJPsRw/PkMHerQOZ4XzjHy2fBG9HZlX5wHTcvGHXsXhd/CQXAunO1v2rhjwivQ8TNVv1TXHGdK9hD2L/UMv46IhZOb0o2jnYh5q46KeAZl0vAz4l64o9/ksA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747956230; c=relaxed/simple;
	bh=LcIUWhj5nNnSPZAL+zgkVI9JEnmmZCD3KzStQFp7sr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NfJYUUJyqhe2hewt+fnIQe46Synx6p1q6U0nUBQhhW/e1avSh3/ZvGeXvUyq4dTiusX3R0PQgGxenGP9jtP7B0Mwo+OIZpsF0BNO6a0HilJke4gXGWAdOTAs3ntKmVDHNjynhiPLDoXi0q4jg3XKCxEN/KCVA11STxEBt2pyhWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/HVPUDe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B35D9C4CEF3;
	Thu, 22 May 2025 23:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747956229;
	bh=LcIUWhj5nNnSPZAL+zgkVI9JEnmmZCD3KzStQFp7sr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K/HVPUDe7VbeiPhmHszDIct1InFeR0HSHX3Mkvyockt4/bAnfiPMojUOiqEGyAlbz
	 HHBkoy4f+KcU+Xk1UHRECQH443b9MYF78R0xzsuNIRES+iI8ciL8pA0qvIC6APqgIU
	 bjZOzO3ViaHTMM4Z1vMaXVl3Xtt7+d+JPUwQ4/zTeZ5EqBpWOmtWLA6MTLwtXofn+p
	 QsYWS9kqaV3XtvR9XGsIU5W5TnMybqVftBasWTWqu/l+BqLDqLH5+S0TI0CzK9DmNp
	 weOFJvD0Xp1EY8OA7bZg0znqQYQqkzYZOkYE5dZSttSf1xwQN6RJeyyykor+K6YucJ
	 wcfwJ4z32AAfQ==
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
Subject: [PATCH v8 03/20] PCI/AER: Factor COR/UNCOR error handling out from aer_isr_one_error()
Date: Thu, 22 May 2025 18:21:09 -0500
Message-ID: <20250522232339.1525671-4-helgaas@kernel.org>
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

From: Bjorn Helgaas <bhelgaas@google.com>

aer_isr_one_error() duplicates the Error Source ID logging and AER error
processing for Correctable Errors and Uncorrectable Errors.  Factor out the
duplicated code to aer_isr_one_error_type().

aer_isr_one_error() doesn't need the struct aer_rpc pointer, so pass it the
Root Port or RCEC pci_dev pointer instead.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Link: https://patch.msgid.link/20250520215047.1350603-4-helgaas@kernel.org
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


