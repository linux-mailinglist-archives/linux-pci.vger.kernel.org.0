Return-Path: <linux-pci+bounces-28022-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBEFABCA0B
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 23:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5307A1B67CFE
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 21:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B59822259E;
	Mon, 19 May 2025 21:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrPiLiDm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CBB222598;
	Mon, 19 May 2025 21:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747690622; cv=none; b=uBg2bVbZixgA+FP7fgPyxZAQT5MXiYq2preYMxotLVIHny5U+1G4BfeIq5ELUJgN+avxG7IHY3ReDPUAu7scqMJMXz7V5Jxs397uLn2vipmxGNxIMiBSxZNPZO74jQSUxMdJWTmkLJEp1h7s313T5qpkgy6o0bhwGhISF+1QzSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747690622; c=relaxed/simple;
	bh=gCT9zdwjoP3FNraWNBiZ8smNlAkNybhV2cLRnGajjKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LtRvooNzkZeQ7bChHpIWXKT7KDgEBqF9RQBXZu6Kb6AzhzbQFwQCQVwC2xliugrKutAjCMXtfIoSDm5amr7WGY7OTup0L01Qpu+azHNAbsxnwpBZKzMBLLaxJWmnGKRUWcE6q0Mk9I4x+pzSZl8JuxpgTN7vzDxj51XgMvEzhg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OrPiLiDm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9314CC4CEE4;
	Mon, 19 May 2025 21:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747690621;
	bh=gCT9zdwjoP3FNraWNBiZ8smNlAkNybhV2cLRnGajjKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OrPiLiDmpSu1WJ9nom0wJOy2FCbHU+YnPGTo/5Xn6QMvGmqMH8IfwtPy5yvmyNVEd
	 R2sM5OyxvvFe/Tz5dljMdsncNBsacd4eve4DtjhvqOxObvbe6v1+w+2uBC2aNhYknY
	 AqgX5PLViSDcmjXnohR9JM7/CWiFGkyEmtr8xZgGfvnd/P8JdZ5F6RGGMkEZfq5qrV
	 ageQzsUsWVRZPMzrux9eMn6Wyl24eHibuYpvNOTzST9Y0U4EQar52V35DI8Y+CH/Uz
	 boXmkSdE1ntQmUs+cVICZ98h/5zuHrkFPcQyedXSevJR8P65fVOiYgvpSWD1RnxTXk
	 mkaTa3l2mKbnA==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Jon Pan-Doh <pandoh@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
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
Subject: [PATCH v6 07/16] PCI/AER: Initialize aer_err_info before using it
Date: Mon, 19 May 2025 16:35:49 -0500
Message-ID: <20250519213603.1257897-8-helgaas@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250519213603.1257897-1-helgaas@kernel.org>
References: <20250519213603.1257897-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Previously the struct aer_err_info "e_info" was allocated on the stack
without being initialized, so it contained junk except for the fields we
explicitly set later.

Initialize "e_info" at declaration with a designated initializer list,
which initializes the other members to zero.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aer.c | 37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 95a4cab1d517..40f003eca1c5 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1281,7 +1281,7 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
 		struct aer_err_source *e_src)
 {
 	struct pci_dev *pdev = rpc->rpd;
-	struct aer_err_info e_info;
+	u32 status = e_src->status;
 
 	pci_rootport_aer_stats_incr(pdev, e_src);
 
@@ -1289,14 +1289,13 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
 	 * There is a possibility that both correctable error and
 	 * uncorrectable error being logged. Report correctable error first.
 	 */
-	if (e_src->status & PCI_ERR_ROOT_COR_RCV) {
-		e_info.id = ERR_COR_ID(e_src->id);
-		e_info.severity = AER_CORRECTABLE;
-
-		if (e_src->status & PCI_ERR_ROOT_MULTI_COR_RCV)
-			e_info.multi_error_valid = 1;
-		else
-			e_info.multi_error_valid = 0;
+	if (status & PCI_ERR_ROOT_COR_RCV) {
+		int multi = status & PCI_ERR_ROOT_MULTI_COR_RCV;
+		struct aer_err_info e_info = {
+			.id = ERR_COR_ID(e_src->id),
+			.severity = AER_CORRECTABLE,
+			.multi_error_valid = multi ? 1 : 0,
+		};
 
 		if (find_source_device(pdev, &e_info)) {
 			aer_print_source(pdev, &e_info, "");
@@ -1304,18 +1303,14 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
 		}
 	}
 
-	if (e_src->status & PCI_ERR_ROOT_UNCOR_RCV) {
-		e_info.id = ERR_UNCOR_ID(e_src->id);
-
-		if (e_src->status & PCI_ERR_ROOT_FATAL_RCV)
-			e_info.severity = AER_FATAL;
-		else
-			e_info.severity = AER_NONFATAL;
-
-		if (e_src->status & PCI_ERR_ROOT_MULTI_UNCOR_RCV)
-			e_info.multi_error_valid = 1;
-		else
-			e_info.multi_error_valid = 0;
+	if (status & PCI_ERR_ROOT_UNCOR_RCV) {
+		int fatal = status & PCI_ERR_ROOT_FATAL_RCV;
+		int multi = status & PCI_ERR_ROOT_MULTI_UNCOR_RCV;
+		struct aer_err_info e_info = {
+			.id = ERR_UNCOR_ID(e_src->id),
+			.severity = fatal ? AER_FATAL : AER_NONFATAL,
+			.multi_error_valid = multi ? 1 : 0,
+		};
 
 		if (find_source_device(pdev, &e_info)) {
 			aer_print_source(pdev, &e_info, "");
-- 
2.43.0


